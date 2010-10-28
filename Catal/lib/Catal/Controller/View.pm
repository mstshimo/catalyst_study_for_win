package Catal::Controller::View;

use strict;
use warnings;
use parent 'Catalyst::Controller';

use Encode;

=head1 NAME

Catal::Controller::View - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::View in View.');
}


sub sample :Local{
	my ($self, $c) = @_;

	$c->stash->{list} = [$c->model('CatalDB::Book')->all];

}

sub json :Local{
	my ($self, $c) = @_;

	$c->stash->{name} = decode('utf8', '山田');

	$c->stash->{old} = 53;

	$c->forward('Catal::View::JSON');
}

sub dbjson :Local{
	my ($self, $c) = @_;

	$c->stash->{list} = [

		map{

			$_ = { map { $_ = decode('utf8', $_) } $_->get_columns }

			} $c->model('CatalDB::Book')->all
	];

	$c->forward('Catal::View::JSON');

}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
