package Catal::Controller::Plugin;

use strict;
use warnings;
use DateTime;

use parent 'Catalyst::Controller';


=head1 NAME

Catal::Controller::Plugin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Plugin in Plugin.');
}

# 20110125
sub session :Local{
	my ($self, $c) = @_;

	my $cnt = $c->session->{cnt} || 1;

	$c->res->body("あなたは${cnt}回アクセスしました。");

	$c->session->{cnt} = ++$cnt;

}

sub change_session :Local{
	my ($self, $c) = @_;

	$c->session->{name} = 'ほげ';

	my $msg = $c->sessionid . ':' . $c->session->{name} . '<br />';

	$c->change_session_id;

	$msg .= $c->sessionid . ':' . $c->session->{name} . '<br />';

	$c->res->body($msg);
}

sub temp :Local{
	my ($self, $c) = @_;

	$c->flash->{msg} = 'flashデータです';
	$c->res->redirect($c->uri_for('temp_after'));
}

sub temp_after :Local{
	my ($self, $c) = @_;

	if(exists $c->flash->{msg}){
		$c->res->body($c->flash->{msg});
	}else{
		$c->res->body("データは存在しないです");
	}
}


# 20110127
sub role :Local{
	my ($self, $c) = @_;

	if($c->check_any_user_role( qw/admin/)){
		$c->res->body('管理者向けのコンテンツです');
	}else{
		$c->res->body('一般向けのコンテンツです');
	}
}


# 20110204
sub validate_basic :Local{
	my ($self, $c) = @_;

	if($c->request->method eq 'POST'){
		if($c->form->has_error){
			$c->stash->{error} = $c->form;
		}else{
			$c->res->body('検証に成功しました！');
		}
	}
}


sub validate :Local{
	my ($self, $c) = @_;

	$c->form(
		{mails => [qw/mail mail_confirm/]} => 'DUPLICATION',
	);

	if($c->req->method eq 'POST'){
		if($c->form->has_error){
			$c->stash->{error} = $c->form;
		}else{
			$c->res->body('検証に成功しました！');
		}
	}
}

# 20110325
sub cache :Local{
	my ($self, $c, $id) = @_;
	
	my $cache = $c->cache;

	my $data;

	if($data = $cache->get($id)){
		$c->res->body("現在時刻は${data}です。[${id}]:キャッシュ");
	}else{
		my $data = DateTime->now(time_zone => 'local');
		$c->cache->set($id, $data);
		$c->res->body("現在時刻は${data}です。[${id}]:処理結果");;

	}

}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
