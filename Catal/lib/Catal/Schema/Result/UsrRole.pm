package Catal::Schema::Result::UsrRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::UsrRole

=cut

__PACKAGE__->table("usr_role");

=head1 ACCESSORS

=head2 uid

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 rid

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uid",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "rid",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("uid", "rid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FoWiwN3vWvdbosiQ59uX+w
__PACKAGE__->belongs_to(user => 'Catal::Schema::Result::Usr', 'uid');
__PACKAGE__->belongs_to(role => 'Catal::Schema::Result::Role', 'rid');

# You can replace this text with custom content, and it will be preserved on regeneration
1;
