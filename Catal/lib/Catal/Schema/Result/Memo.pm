package Catal::Schema::Result::Memo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Memo

=cut

__PACKAGE__->table("memo");

=head1 ACCESSORS

=head2 mid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 updated

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "mid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "updated",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("mid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4tzalYk3l/byAXeHJN1ASA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
