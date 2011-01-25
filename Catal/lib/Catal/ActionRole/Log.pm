package Catal::ActionRole::Log;

use Moose::Role;

=pod
before execute => sub {
	my ($self, $controller, $c) = @_;
	$c->log->debug('Action Start!');
};

after execute => sub {
	my ($self, $controller, $c) = @_;
	$c->log->debug('Action Finish!');
};
=cut

around execute => sub {
	my ($code, $self, $controller, $c) = @_;
	$c->log->debug('Action Start!!!!');
	$code->($self, $controller, $c);
	$c->log->debug('Action Finish!!!');
};

1;