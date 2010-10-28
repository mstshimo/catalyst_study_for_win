package Catal::Controller::Directive;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Directive - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Directive in Directive.');
}

sub set :Local{
	my ($self, $c) = @_;
	$c->stash->{width} = 10;
	$c->stash->{height} = 50;

}

sub def :Local{
	my ($self, $c) = @_;
	$c->stash->{title} = "DEFAULT命令";
	$c->stash->{keyword} = "ディレクティブ, デフォルト値";
}

sub foreachAction :Local{

}

sub insert :Local{

}

sub include :Local{

}

sub process :Local{

}

sub wrapper :Local{

}

sub block :Local{

}

sub block2 :Local{

}

sub macro :Local{

}

sub meta :Local{

}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
