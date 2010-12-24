package Catal::Controller::Ctrl::Attr;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#__PACKAGE__->config->{namespace} = 'win/sample';


=head1 NAME

Catal::Controller::Ctrl::Attr - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl::Attr in Ctrl::Attr.');
}

# 2010-12-03
sub intro :Local{
	my ($self, $c) = @_;
	
	$c->res->body('こんにちは、世界！');

}

# 2010-12-10
sub intro2 :Global{
	my ($self, $c) = @_;
	
	$c->res->body('Global属性');

}

sub path_attr :Path('/hoge-foo'){
	my ($self, $c) = @_;

	$c->res->body('Path属性');
}


sub regex_attr :Regex('^article/(\d{4})\.html$'){
	my ($self, $c) = @_;
	
	my $num = $c->request->captures->[0];
	
	$c->res->body("記事番号:${num}");
}


sub regex_attr2 :LocalRegex('^article/(\d{4})\.html$'){
	my ($self, $c) = @_;
	
	my $num = $c->request->captures->[0];
	
	$c->res->body("ローカル記事番号:${num}");
}


sub args_attr :Path('/args') :Args(2){
	my ($self, $c) = @_;
	
	my $args = $c->req->args;

	$c->res->body("パス情報" . join(',', @$args));

}


sub chain_top :Chained('/') :PathPart('first') :CaptureArgs(0){
	my ($self, $c) = @_;
	$c->stash->{body} = '<p>chain_topアクション</p>';
}

sub chain_second :Chained('chain_top') :PathPart('second') :CaptureArgs(1){
	my ($self, $c, $id) = @_;
	$c->stash->{body} .= "<p>chain_secondアクション:${id}</p>";

}

sub chain_third :Chained('chain_second') :PathPart('third'){
	my ($self, $c, $test1, $test2) = @_;
	$c->stash->{body} .= "<p>chain_thirdアクション ${test1}, ${test2}</p>";
	
	$c->res->body($c->stash->{body});
}

sub chain_path :Chained('chain_second') :PathPart{
	my ($self, $c) = @_;
	$c->stash->{body} .= '<p>chain_pathアクション</p>';
	$c->res->body($c->stash->{body});
}

sub chain_args :Chained('chain_second') :PathPart('args') :Args(2){
	my ($self, $c, $first, $second) = @_;
	
	$c->stash->{body} .= "<p>chain_argsアクション:$first, $second</p>";
	$c->res->body($c->stash->{body});
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
