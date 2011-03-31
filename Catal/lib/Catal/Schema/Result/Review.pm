package Catal::Schema::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Review

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 isbn

  data_type: 'varchar'
  is_nullable: 0
  size: 17

=head2 uid

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 body

  data_type: 'text'
  is_nullable: 0

=head2 updated

  data_type: 'datetime'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "isbn",
  { data_type => "varchar", is_nullable => 0, size => 17 },
  "uid",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "body",
  { data_type => "text", is_nullable => 0 },
  "updated",
  { data_type => "datetime", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("isbn", "uid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ADq+h9O5LIJMuXQt2TXcXA


__PACKAGE__->belongs_to(book => 'Catal::Schema::Result::Book', 'isbn');
__PACKAGE__->belongs_to(usr => 'Catal::Schema::Result::Usr', 'uid');

# You can replace this text with custom content, and it will be preserved on regeneration
1;
