package Catal::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Catal::Controller::Root - Root Controller for Catal

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}


# 20110127
sub auto :Pirvate{
	my ($self, $c) = @_;

	# パス/loginによるループ回避
	if($c->action->reverse eq 'login'){
		return 1;
	}

	# 未認証のとき、認証処理へリダイレクト
	if(!$c->user_exists){
		$c->res->redirect($c->uri_for('/login'));

		# 移行のautoアクションを中止
		return 0;
	}
	
	# 本来のリクエストを継続
	return 1;

}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
	my ($self, $c) = @_;

	if(scalar @{$c->error}){
		$c->stash->{errors} = $c->error;
		$c->stash->{template} = "errors.tt";

		# エラー情報stashに入れたら、コンテキストはクリアする
		$c->clear_errors();
	}

}

sub login :Local{
	my ($self, $c) = @_;

	my $uid = $c->req->body_params->{'uid'};
	my $passwd = $c->req->body_params->{'passwd'};

use Data::Dumper;
warn Dumper($uid);
warn Dumper($passwd);
warn Dumper($c->req->body_params);

	if($uid ne '' && $passwd ne ''){
warn Dumper($uid);
warn Dumper($passwd);

		if($c->authenticate({uid => $uid, passwd => $passwd})){
			$c->res->body('こんちには、' . $c->user->get('unam') . 'さん!');
		}else{
			$c->stash->{error} = 'ユーザ名、またはパスワードが間違っています。';
		}
	}

}


sub logout :Local{
	my ($self, $c) = @_;

	$c->logout;

	$c->res->redirect($c->uri_for('/'));
}



=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
