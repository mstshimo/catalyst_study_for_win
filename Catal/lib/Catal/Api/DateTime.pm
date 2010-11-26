package Catal::Api::DateTime;

use strict;
use warnings;

use DateTime::Format::Strptime;
use parent 'DateTime';

use overload

'""' => sub{
	my ($self) = @_;
	
	return $self->strftime($self->{format});
};

sub now{
	my ($class, $args) =@_;
	
	my $self = $class->SUPER::now(time_zone => $args->{time_zone} || 'local');
	
	$self->{format} = $args->{format} || '%Y年%m月%d日 %H時%M分%S秒';
	
	return $self;
};

1;
