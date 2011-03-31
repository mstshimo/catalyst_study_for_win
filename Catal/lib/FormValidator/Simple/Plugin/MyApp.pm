package FormValidator::Simple::Plugin::MyApp;

use strict;
use warnings;

use FormValidator::Simple::Exception;
use FormValidator::Simple::Constants;

sub ISBN{
	my ($self, $params, $args) = @_;
	my $data = $params->[0];

	return $data =~ /^978-4-[0-9]{2,5}-[0-9]{2,5}-[0-9A-Z]{1}$/ ? TRUE : FALSE;

}

1;