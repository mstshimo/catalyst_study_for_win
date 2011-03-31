package Catal::Controller::Context;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Context - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Context in Context.');
}

sub log_basic :Local{
	my ($self, $c) = @_;

	my $log = $c->log();

	$log->fatal("Fatal Log!");
	$log->error("ERROR Log!");
	$log->warn("WARN Log!");
	$log->info("INFO Log!");
	$log->debug("DEBUG Log!");
	$c->res->body('コンソールを見よ。');
}

sub conf :Local{
	my ($self, $c) = @_;

	$c->res->body('アプリ名:' . $c->config->{name});
}

sub path_to :Local{
	my ($self, $c) = @_;

	$c->res->body($c->path_to('conf','hoge','poko.txt'));
}

sub urifor :Local{
	my ($self, $c) = @_;

	my $msg;

	$msg .= $c->uri_for . '<br />';
	$msg .= $c->uri_for('static/image/catalyst_log.png') . '<br />';
	$msg .= $c->uri_for($c->action) . '<br />';
	$msg .= $c->uri_for($c->action, @{$c->req->args}, $c->req->query_params) . '<br />';
#	my $msg .= $c->uri_for('/boo/details', 'mvc', '978-4-7980-2401-1', {charset => 'utf8'}) . '<br />';

	$c->res->body($msg);
}




=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
