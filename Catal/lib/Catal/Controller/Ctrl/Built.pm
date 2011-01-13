package Catal::Controller::Ctrl::Built;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Ctrl::Built - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl::Built in Ctrl::Built.');
}

#2011-01-13
sub default :Path{}



=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
