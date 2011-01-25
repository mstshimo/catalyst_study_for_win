package Catal::Controller::Ctrl::Role;

use strict;
use warnings;
use parent 'Catalyst::Controller::ActionRole';

=head1 NAME

Catal::Controller::Ctrl::Role - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl::Role in Ctrl::Role.');
}

sub intro :Local :Does('Log'){
	my ($self, $c) = @_;
	$c->log->debug('Action Processing...');
	$c->res->body('ActionRoleサンプル!!');
}

=pod
sub intro : Local :Does('Log'){
	my ( $self, $c ) = @_;
	$c->log->debug('Action Processing...');
	$c->response->body('ActionRoleサンプル');
}
=cut


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
