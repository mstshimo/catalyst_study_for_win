package Catal::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Role

=cut

__PACKAGE__->table("role");

=head1 ACCESSORS

=head2 rid

  data_type: 'integer'
  is_nullable: 0

=head2 role

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "rid",
  { data_type => "integer", is_nullable => 0 },
  "role",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);
__PACKAGE__->set_primary_key("rid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3cXdqVgnwPydxV/jG7IJ6g
__PACKAGE__->has_many(map_user_roles => 'Catal::Schema::Result::UsrRole', 'rid');


# You can replace this text with custom content, and it will be preserved on regeneration
1;
