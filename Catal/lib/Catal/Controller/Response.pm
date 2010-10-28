package Catal::Controller::Response;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use DateTime;
use MIME::Base64;
use Data::Dumper;

=head1 NAME

Catal::Controller::Response - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Response in Response.');
}


sub forbidden :Local{
	my ($self, $c) = @_;
	
	$c->res->status(403);
	$c->res->body("アクセス禁止されています");
}

sub refresh :Local{
	my ($self, $c) =@_;
	
	
	$c->res->header('Refresh' => 5,);
	
	my $dt = DateTime->now('time_zone' => 'local');
	
	$c->stash->{now} = $dt->strftime('%Y年%m月%d日 %H時%M分%S秒');
}


sub auth :Local{
	my ($self, $c) = @_;
	
	
	my $auth = $c->req->header('Authorization');
	
	if($auth eq ''){
		$c->res->status('401');
		$c->res->header('WWW-Authenticate' => 'Basic realm="catalyst hoge"');
		$c->res->body('このページにはアクセス認証が必要です');
	
	}else{
		my @user = split /:/, decode_base64(substr($auth,6));
		
		if($user[0] ne 'admin_user' || $user[1] ne 'admin_pass'){
			$c->res->status('401');
			$c->res->header('WWW-Authenticate' => 'Basic realm="catalyst poko"');
			$c->res->body("ユーザ名かパスワードが間違っています。");
		}

	}
}

sub download :Local{
	my ($self, $c) = @_;

	#Content-Type/Content-Dispositionヘッダ
	$c->response->header(
		'Content-Type' => 'application/octet-stream',
		'Content-Disposition' => 'attachement; filename = "dl.csv"');

	$c->stash->{list} = [$c->model('CatalDB::Book')->all];

}


sub cache :Local{
	my ($self, $c) = @_;
	
	my $dt = DateTime->now(time_zone => 'local');
	my $fmt = DateTime::Format::Strptime->new(pattern => '%a, %d %m %Y %H:%M:%S GMT');

	$c->res->header(
		# 有効期限を過去日に設定
		'Expires' => 'Sun, 1 Jan 1970 00:00:00 GMT',

		# ページの最終更新日
		'Last-Modified' => $fmt->format_datetime($dt),

		# キャッシュ機構を無効
		'Cache-Control' => 'no-store, no-cache, must-revalidate',
		'Cache-Control' => 'post-check=0, pre-check=0',
		'Pragma' => 'no-cache'
	);

	$c->response->body('.');

}

sub redirect :Local{
	my ($self, $c) = @_;

	$c->res->redirect('http://yahoo.co.jp');


}

sub body :Local{
	my ($self, $c) = @_;
	$c->res->body('X');
	$c->res->body('Y');

}


sub write :Local{
	my ($self, $c) = @_;
	$c->res->write('X');
	$c->res->write('Y');
#	$c->res->body('Z');


}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
