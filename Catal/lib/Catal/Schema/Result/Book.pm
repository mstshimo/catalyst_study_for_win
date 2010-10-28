package Catal::Schema::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Catal::Schema::Result::Book

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 isbn

  data_type: 'varchar'
  is_nullable: 0
  size: 17

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 price

  data_type: 'integer'
  is_nullable: 0

=head2 publish

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 published

  data_type: 'date'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "isbn",
  { data_type => "varchar", is_nullable => 0, size => 17 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "price",
  { data_type => "integer", is_nullable => 0 },
  "publish",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "published",
  { data_type => "date", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("isbn");
__PACKAGE__->add_unique_constraint("title_key", ["title"]);


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2010-05-27 20:59:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f98zKhUjNYgYkqWuE9uMmQ

__PACKAGE__->has_many(book_review => 'Catal::Schema::Result::Review', 'isbn');
__PACKAGE__->many_to_many(reviews => 'book_review', 'usr');

# You can replace this text with custom content, and it will be preserved on regeneration
1;
