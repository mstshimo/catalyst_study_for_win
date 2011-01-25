package Catal::Controller::Ctrl::Attr;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#__PACKAGE__->config->{namespace} = 'win/sample';


=head1 NAME

Catal::Controller::Ctrl::Attr - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl::Attr in Ctrl::Attr.');
}

# 2010-12-03
sub intro :Local{
	my ($self, $c) = @_;
	
	$c->res->body('こんにちは、世界！');
}

# 2010-12-10
sub intro2 :Global{
	my ($self, $c) = @_;
	
	$c->res->body('Global属性');

}

sub path_attr :Path('/hoge-foo'){
	my ($self, $c) = @_;

	$c->res->body('Path属性');
}


sub regex_attr :Regex('^article/(\d{4})\.html$'){
	my ($self, $c) = @_;
	
	my $num = $c->request->captures->[0];
	
	$c->res->body("記事番号:${num}");
}


sub regex_attr2 :LocalRegex('^article/(\d{4})\.html$'){
	my ($self, $c) = @_;
	
	my $num = $c->request->captures->[0];
	
	$c->res->body("ローカル記事番号:${num}");
}


sub args_attr :Path('/args') :Args(2){
	my ($self, $c) = @_;
	
	my $args = $c->req->args;

	$c->res->body("パス情報" . join(',', @$args));

}


sub chain_top :Chained('/') :PathPart('first') :CaptureArgs(0){
	my ($self, $c) = @_;
	$c->stash->{body} = '<p>chain_topアクション</p>';
}

sub chain_second :Chained('chain_top') :PathPart('second') :CaptureArgs(1){
	my ($self, $c, $id) = @_;
	$c->stash->{body} .= "<p>chain_secondアクション:${id}</p>";

}

sub chain_third :Chained('chain_second') :PathPart('third'){
	my ($self, $c, $test1, $test2) = @_;
	$c->stash->{body} .= "<p>chain_thirdアクション ${test1}, ${test2}</p>";
	
	$c->res->body($c->stash->{body});
}

sub chain_path :Chained('chain_second') :PathPart{
	my ($self, $c) = @_;
	$c->stash->{body} .= '<p>chain_pathアクション</p>';
	$c->res->body($c->stash->{body});
}

sub chain_args :Chained('chain_second') :PathPart('args') :Args(2){
	my ($self, $c, $first, $second) = @_;
	
	$c->stash->{body} .= "<p>chain_argsアクション:$first, $second</p>";
	$c->res->body($c->stash->{body});
}

# 2010-12-24
sub chain_parent :ChainedParent :PathPart('child'){
	my ($self, $c) = @_;

	$c->stash->{body} .= '<p>chain_parentアクション[Ctrl/Attr]</p>';
	$c->res->body($c->stash->{body});
}

# 2011-01-13
# 連鎖アクションの基点
sub note_base :Chained('/') :PathPart('memo') CaptureArgs(0){
	my ($self, $c) = @_;

	$c->stash->{memo} = $c->model('CatalDB::Memo');
}

# すべてのメモをリスト表示
sub note_all :Chained('note_base') :PathPart('all') :Args(0){
	my ($self, $c) = @_;

	$c->stash->{list} = [$c->stash->{memo}->search({}, {order_by => {-asc => 'updated'}})]

}

# 新規のメモを登録
sub note_create :Chained('note_base') :PathPart('create') :Args(0) {
	my ($self, $c) = @_;

	# postアクセス
	if($c->req->method eq 'POST'){
		# validation
		$c->forward('note_validate');
		if(scalar @{$c->stash->{errors}}){
			$c->go('note_error');
		}
	
		$c->stash->{memo}->create({
			title => $c->req->body_params->{title},
			body => $c->req->body_params->{body},
			updated => \'NOW()',
		});

		$c->res->redirect($c->uri_for('/memo/all'), 303);
	}

	# getアクセスの場合は、対応する登録フォームを表示
}

# 特定のメモ情報を取得
sub note_details :Chained('note_base') :PathPart('') :CaptureArgs(1){
	my ($self, $c, $mid) = @_;

	$c->stash->{item} = $c->stash->{memo}->find($mid);

	# 該当するメモが存在しない場合は、エラーメッセージ
	if(!$c->stash->{item}){
		$c->res->body("not found memo ${mid}.");

		# 連鎖アクション終了
		$c->detach();
	}
}


# note_detailsアクションを引き継いで、メモ情報を表示
sub note_show :Chained('note_details') :PathPart('') :Args(0){

}

# 既存のメモを編集
sub note_edit :Chained('note_details') :PathPart('edit') :Args(0){
	my ($self, $c) = @_;

	# postアクセス
	if($c->req->method eq 'POST'){
		# validation
		$c->forward('note_validate');
		if(scalar @{$c->stash->{errors}}){
			$c->go('note_error');
		}

		my $row = $c->stash->{item};
		$row->title($c->req->body_params->{title});
		$row->body($c->req->body_params->{body});
		$row->updated(\'NOW()');
		$row->update;

		#更新処理に成功したら、一覧へリダイレクト
		$c->res->redirect($c->uri_for('/memo/all'), 303);
	}

	# getアクセスの場合は、対応する登録フォームを表示

}


sub note_delete :Chained('note_details') :PathPart('delete') :Args(0){
	my ($self, $c) = @_;

	# postアクセス
	if($c->req->method eq 'POST'){
		$c->stash->{item}->delete;

		# 削除に成功したら、一覧へリダイレクト
		$c->res->redirect($c->uri_for('/memo/all'), 303);
	}

	# getアクセスの場合は、エラー
	$c->res->body('アクセスが拒否されました。');
}


sub note_validate :Private{
	my ($self, $c) = @_;

	# リクエスト取得
	my $p = $c->req->body_params;

	my @errs;

	push @errs, '件名を入力してください' unless $p->{title};
	push @errs, '本文を入力してください' unless $p->{body};

	$c->stash->{errors} = \@errs;

}

sub note_error :Private{};

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
