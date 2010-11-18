package Catal::Model::Catal;

use strict;
use warnings;
use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
    dsn           => 'dbi:mysql:cataldb',
    user          => 'cataluser',
    password      => 'catalpass',
    options       => {},
);

=head1 NAME

Catal::Model::Catal - DBI Model Class

=head1 SYNOPSIS

See L<Catal>

=head1 DESCRIPTION

DBI Model Class.

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
