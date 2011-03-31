package Catal::Controller::Request;

use strict;
use warnings;

use Encode;
use Data::Dumper;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Request - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Request in Request.');
}


# ---------------------------------------
# form アクション
# テキストボックス入力フォーム
sub form :Local{}

# process アクション
# ポストデータ表示
sub process :Local{
	my ($self, $c) = @_;
	$c->stash->{namae} = $c->request->body_params->{'name'};
	
	# アプリ名が入ってしまう。stash->nameは予約語？
	$c->stash->{name} = $c->request->body_params->{'name'};

}
# ---------------------------------------

# ---------------------------------------
# multiForm アクション
# チェックボックス入力フォーム
sub multiForm :Local{}


# multiProcess アクション
# ポストデータ表示
sub multiProcess :Local{
	my ($self, $c) = @_;
	
	my $fw = $c->request->body_params->{'fw'};
	
	$c->stash->{fw} = join ',' , @$fw;

	$c->stash->{fwroop} = $fw;
}
# ---------------------------------------

# ---------------------------------------
# uploadForm アクション
# ファイルアップロードフォーム
sub uploadForm :Local{}

# uploadProcess アクション
# ファイルアップロード処理
sub uploadProcess :Local{
	my ($self, $c) = @_;
	
	my $_msg;
	
	# アップロードファイル取得
	my $upload = $c->req->upload('upfile');
	
	# アップロードファイルのパス取得
	my $file = $upload->filename;

	# ベース名(パスを除く)を取得
	#my $base = substr ($file, (rindex $file, '\\')+1);

	# 拡張子を取得
	my $ext = lc substr ($file, (rindex $file, '.')+1);
	
	# アップロードを許可する拡張子を定義
	my @perm = ('jpg','jpeg','gif','png');
	
	# 拡張子に応じて、ファイルを処理する
	if(grep {$_ eq $ext} @perm != 1){
		$_msg = "アップロードできるファイルは画像のみです。";
		
	}elsif($upload->size > 100000){
		$_msg = "アップロードできるファイルは1MBまでです。";
		
	}else{
		Encode::from_to($file, 'utf8', 'shiftjis');
		
		if($upload->copy_to('./doc/' . $file)){
			$_msg = $file . 'をアップロードしました。';
		}else{
			$_msg = "アップロードに失敗しました。";
		}
	}
		die Dumper($_msg);

		$c->response->body($_msg);

}
# ---------------------------------------


# ---------------------------------------
# queryForm アクション
# クエリフォーム
sub queryForm :Local{}

# queryProcess アクション
# クエリ情報を表示
sub queryProcess :Local{
	my ($self, $c) = @_;
	
	$c->stash->{nam} = $c->request->query_params->{'nam'};

}

# ---------------------------------------

# ---------------------------------------
# list アクション
# 書籍一覧表示
sub list :Local{
	my ($self, $c) = @_;
	$c->stash->{list} = [$c->model('CatalDB::Book')->all];
}


# detail アクション
# 書籍一覧表示
sub detail :Local{
	my ($self, $c) = @_;
	
#	$c->stash->{book} = $c->model('CatalDB::Book')->find($c->request->query_params->{'isbn'});
	$c->stash->{book} = $c->model('CatalDB::Book')->find($c->request->args->[0]);
}
# ---------------------------------------


# header アクション
# 2010/06/10
sub header :Local{
	my ($self, $c) = @_;
	#$c->res->body( $c->req->header('User-Agent') );

	$c->res->body($c->req->address          . "<br>" .
				  $c->req->base             . "<br>" .
				  $c->req->content_encoding . "<br>" .
				  $c->req->content_length   . "<br>" .
				  $c->req->content_type     . "<br>" .
				  $c->req->hostname         . "<br>" .
				  $c->req->method           . "<br>" .
				  $c->req->path             . "<br>" .
				  $c->req->path_info        . "<br>" .
				  $c->req->protocol        . "<br>" .
				  $c->req->referer          . "<br>" .
				  $c->req->secure           . "<br>" .
				  $c->req->uri           . "<br>" .
				  $c->req->user_agent
				  );

}

sub headers :Local{
	my ($self, $c) = @_;

	my $result;
	my $hs = $c->req->headers;
	
	foreach my $name($hs->header_field_names){
		$result .= $name . ':' . $hs->header($name) . '<br>';
	}

	$c->res->body($result);
}

# cookie アクション
sub cookie :Local{
	my ($self, $c) = @_;
	
	my $email = $c->req->cookie('email');
	
	$c->stash->{email} = $email ? $email->value : '';
}

sub cookieProcess :Local{
	my ($self, $c) = @_;
	
	$c->res->cookies->{email} = {
									value   => $c->req->body_params->{'email'},
									expires => '+3M',
									secure  => '0',
									httponly  => '1',
								};

	$c->res->body('クッキーを保存しました。');
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
