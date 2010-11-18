package Catal::Schema::Result::Document;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Document

=cut

__PACKAGE__->table("document");

=head1 ACCESSORS

=head2 docid

  data_type: 'char'
  is_nullable: 0
  size: 5

=head2 doc

  data_type: 'text'
  is_nullable: 0

=head2 updated

  data_type: 'datetime'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "docid",
  { data_type => "char", is_nullable => 0, size => 5 },
  "doc",
  { data_type => "text", is_nullable => 0 },
  "updated",
  { data_type => "datetime", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("docid");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gmlb3/v4Zjf3bfENo4O2gA


# You can replace this text with custom content, and it will be preserved on regeneration
use XML::Simple;
__PACKAGE__->inflate_column(
	'doc',
	{
		inflate => sub {
							XMLin(shift)
						},
		deflate => sub {
						XMLout(
							shift,
							RootName => 'doc',
							NoAttr => 1);
						},
	}
);

1;
