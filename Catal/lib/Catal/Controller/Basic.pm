package Catal::Controller::Basic;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Basic - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Basic in Basic.');
}


sub var :Local{
	my ($self, $c) = @_;

	$c->stash->{array_t} = ['Perl' ,'PHP', 'Ruby', 'Python'];
	$c->stash->{hash_t} = {"TT"   => "Template Toolkit" ,
						   'Perl' => "Practical Extraction and Report Language",
						   'PHP' => "Personal HomePage Tool",
						   };
	$c->stash->{obj_t} = $c->req->headers;
	$c->stash->{func_t} = sub {return join '|', @_ };
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
