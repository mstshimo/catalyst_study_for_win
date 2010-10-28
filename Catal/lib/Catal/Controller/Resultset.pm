package Catal::Controller::Resultset;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Resultset - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Resultset in Resultset.');
}

# テンプレートの場所を、書籍のサンプルとは場所を変えているので気をつけること。
sub all :Local {

}

sub find :Local {
	my ($self, $c) = @_;
	$c->stash->{book} = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');
	$c->stash->{template} = 'resultset/details.tt';
}


sub find2 :Local {
	my ($self, $c) = @_;
	$c->stash->{book} = $c->model('CatalDB::Book')
		->find('基礎XML', {key => 'title_key'});
	$c->stash->{template} = 'resultset/details.tt';
}


sub where  :Local {
	my ($self, $c) = @_;

#	$c->stash->{list} = [ $c->model('CatalDB::Book')->search({publish => 'インプレス'}) ];

	$c->stash->{list} = [ $c->model('CatalDB::Book')->search(
		{
			published => {'>=' => '2009-01-01'}
		}) ];
	$c->stash->{template} = 'resultset/list.tt';
}


sub orderby :Local {
	my ($self, $c) = @_;
	
	# pulished, price列について、降順ソートした結果を取得。
	$c->stash->{list} = [$c->model('CatalDB::Book')->search({}, {order_by => {-desc => 'published'}})];
	$c->stash->{template} = 'resultset/list.tt';

}


sub rows :Local {
	my ($self, $c, $page) = @_;

	# ページ番号 $page が指定されていない場合、デフォルト値は1
	$page = 1 unless $page;

	$c->stash->{list} = [$c->model('CatalDB::Book')->search(undef, {
		order_by => {-desc => ['published', 'price']}, # sort指定
		rows => 3, # ページあたりの件数指定
		page => $page # 現在のページ番号
		})];

	$c->stash->{template} = 'resultset/list.tt';
}

sub groupby :Local {
	my ($self, $c) = @_;
	
=pod
	# publish列でグループ化、price列の平均を取得
	$c->stash->{list} = [$c->model('CatalDB::Book')->search(undef, {
		group_by => ['publish'],
		select => ['publish', {AVG => 'price'}],
		as => ['publish', 'avg_price'],
	})];
=cut

	$c->stash->{list} = [$c->model('CatalDB::Book')->search({},{
		select => ['publish'],
		distinct => 1,
	})];

}


sub count :Local {
	my ($self, $c) = @_;

	# カウント
	my $num = $c->model('CatalDB::Book')->search({publish => 'インプレス'},{})->count;

	$c->response->body("出版社がインプレスの書籍は${num}件ありました。");

}


sub search_literal :Local {
	my ($self, $c) = @_;

	$c->stash->{list} = [$c->model('CatalDB::Book')->search_literal('(title like ? or published > ?) and publish = ?', 
	 ('%Perl%', '2009-01-01', 'インプレス'))];

	$c->stash->{template} = 'resultset/list.tt';

}


sub get_column :Local {
	my ($self, $c) = @_;

	# インプレスの書籍情報を取得した上で、その最高価格を求める
	my $max_price = $c->model('CatalDB::Book')->get_column('price')->max;

	$c->res->body("インプレスの書籍の最も高い価格は${max_price}です");
}


sub insert :Local {
	my ($self, $c) = @_;
	
	my $row = $c->model('CatalDB::Book')->create({
		isbn => '978-4-8443-2699-2',
		title => '基礎Perl2',
		price => '3150',
		publish => 'インプレスジャパン',
		published => \'NOW()'
	});

	$c->res->body('データの登録に成功しました。${row}');
}


sub last_id :Local{
	my ($self, $c) = @_;

	# commentテーブルに新規データの投入
#	my $row = $c->model('CatalDB::Comment')->create({
#		name => 'Masato.Shimomura';
#		body => 'テスト',
#		updated => \'NOW()',
#	});

	my $row = $c->model('CatalDB::Comment')->new({});

	$row->name('Masato.Shimomura');
	$row->body('テストです');
	$row->updated(\'NOW()');
	$row->insert();

	$c->res->body('コメントテーブルに追加しました。' . $row->id );
}


# 2010-08-19
sub update :Local {
	my ($self, $c) = @_;

	my $row = $c->model('CatalDB::Book')->find('978-4-8443-2699-2');

	$row->title('基礎Perl 第2版');
	$row->publish('インプレス');

	$row->update();
	$c->res->body("データを更新できました");
}

sub update2 :Local {
	my ($self, $c) = @_;
	my $row = $c->model('CatalDB::Book')->search({publish => 'インプレス'});
	
	$row->update({price => \"price * 1.05"});

	$c->res->body($row->count . "件を更新しました。");
}


sub delete :Local {
	my ($self, $c) = @_;

	my $result = $c->model('CatalDB::Book')->search({
		published => {'<' => '2008-01-01'}
		})->delete();
	
	$c->res->body($result . "件を削除しました。");
}


sub find_or_new :Local {
	my ($self, $c) = @_;
	
	my $book = $c->model('CatalDB::Book')->find_or_new({
		isbn => '978-4-8443-2061-7',
		title => "基礎XML 第2版",
		price => 3150,
		publish => 'インプレス',
		published => '2010-04-28'
		});
		
	if($book->in_storage){
		$c->res->body("同一キーのデータが存在します。");
	}else{
		$book->insert();
		$c->res->body("新規登録しました。");
	}
	

}


sub update_or_new :Local {
	my ($self, $c) = @_;
	
	my $review = $c->model('CatalDB::Review')->update_or_new({
		isbn => '978-4-8443-2699-1',
		uid => 'nkakeya',
		body => 'Perlをこれから学びたい人にはお勧めです。基礎がしっかり身につきます',
		updated => \'NOW()'
	});
	
	if($review->in_storage){
		$c->res->body('データを更新しました。');
	}else{
		$review->insert();
		$c->res->body('データを登録しました。');
	}
}


sub transaction :Local {
	my ($self, $c) = @_;
	eval {
		$c->model('CatalDB')->schema->txn_do(sub {
			$c->model('CatalDB::Book')->create({
				isbn => '978-4-8443-2699-3',
				title => '基礎Catalyst',
				price => '3360',
				publish => 'インプレス',
				published => '2010-05-12',
			});

			# 主キー違反をさせる
			$c->model('CatalDB::Book')->create({
				isbn => '978-4-8443-2699-3',
				title => '基礎Catalyst',
				price => '3360',
				publish => 'インプレス',
				published => '2010-05-12',
			});
		});
	};

	if($@){
		# 例外メッセージをチェック
		if($@ =~ /rollback failed/){
			$c->response->body('ロールバックに失敗しました');
		}else{
			$c->response->body("ロールバックしました:$@");
		}
		return;
	}

	$c->response->body('トランザクションは成功しました。');
}


sub relname :Local {
	my ($self, $c) = @_;

	$c->stash->{book} = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');

}


# 2010-09-23
sub related :Local {
	my ($self, $c) = @_;
	
	my $rs = $c->model('CatalDB::Book')->find('978-4-8443-2699-1');
	
	
	$c->stash->{book} = $rs;
	$c->stash->{reviews} = [$rs->search_related('book_review', {},
	{order_by => {-desc => ['isbn']}} )->all];

}


sub prefetch :Local {
	my ($self, $c) = @_;
	
	#基点テーブルの参照をme
	$c->stash->{list} = [$c->model('CatalDB::Review')->search(
		{},
		{
			prefetch => ['book'],
			rows => 6,
			order_by => {-desc => ['book.published', 'me.updated']}
		}
	)];
	

}


sub prefetch2 :Local {
	my ($self, $c) = @_;
	
	#基点テーブルの参照をme
	$c->stash->{list} = [$c->model('CatalDB::Book')->search(
		{},
		{
			prefetch => ['book_review'],
			rows => 6,
			order_by => {-desc => ['me.published', 'book_review.updated']}
		}
	)];
	

}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
