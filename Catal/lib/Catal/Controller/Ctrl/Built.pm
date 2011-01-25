package Catal::Controller::Ctrl::Built;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Ctrl::Built - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	$c->response->body('Builtコントローラのトップページです');
    #$c->response->body('Matched Catal::Controller::Ctrl::Built in Ctrl::Built.');
}

#2011-01-13
sub default :Path{}


#2011-01-21
sub begin :Private {
	my ($self, $c) = @_;

	my $start = DateTime->new(time_zone => 'local',
							  year => 2009,
							  month => 12,
							  day => 1);

	my $end = DateTime->new(time_zone => 'local',
							  year => 2011,
							  month => 12,
							  day => 31);

	my $dt = DateTime->now(time_zone => 'local');

	if(DateTime->compare($start, $dt) == 1 ||
	   DateTime->compare($dt, $end) == 1){

		my $fmt = DateTime::Format::Strptime->new(pattern => '%Y年%m月%d日');

		$c->res->body(sprintf('このページは%s～%sの期間のみ有効です',
		$fmt->format_datetime($start), $fmt->format_datetime($end)));

		$c->res->status(403);

		$c->detach();
	}
}

sub limit :Local {
	my ($self, $c) = @_;

	$c->res->body('有効期間中');
}

sub except :Local {
	my ($self, $c) = @_;
	$c->error('exceptアクションで意図的なエラーを発生');
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
