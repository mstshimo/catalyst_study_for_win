package Catal::Api::Book;

use strict;
use warnings;
use Catal::Schema;

sub new {
	my ($class, $c) = @_;
	
	my $self = { Schema => Catal::Schema->connect(
		'dbi:mysql:cataldb',
		'cataluser',
		'catalpass',
		{
			on_connect_do => 'SET NAMES utf8',
			AutoCommit =>1
		},
	)};
	
	return bless $self, $class;
}

sub getInfosByPublish{
	my ($self, $publish) = @_;
	
	my $rs = $self->{Schema}->resultset('Book');
	
	return [$rs->search({publish => $publish})];

}

1;
