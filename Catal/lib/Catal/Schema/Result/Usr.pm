package Catal::Schema::Result::Usr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Usr

=cut

__PACKAGE__->table("usr");

=head1 ACCESSORS

=head2 uid

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 passwd

  data_type: 'char'
  is_nullable: 0
  size: 32

=head2 unam

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 roles

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "uid",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "passwd",
  { data_type => "char", is_nullable => 0, size => 32 },
  "unam",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "roles",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);
__PACKAGE__->set_primary_key("uid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7HiBDBu9v1qyBOL01ryRYQ

__PACKAGE__->has_many(usr_review => 'Catal::Schema::Result::Review', 'uid');
__PACKAGE__->many_to_many(books => 'usr_review', 'book');


# You can replace this text with custom content, and it will be preserved on regeneration
1;
