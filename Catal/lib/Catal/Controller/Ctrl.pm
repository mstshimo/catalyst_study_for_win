package Catal::Controller::Ctrl;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Ctrl - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl in Ctrl.');
}


sub chain_parent :Chained :PathPart('parent') :CaptureArgs(0){
	my ($self, $c) = @_;

	$c->stash->{body} .= '<p>chain_parentアクション[Ctrl]</p>';
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
