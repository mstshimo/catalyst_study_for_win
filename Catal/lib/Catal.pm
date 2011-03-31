package Catal;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug
				ConfigLoader
				Static::Simple
				Session
				Session::Store::File
				Session::State::Cookie
				Authentication
				Authorization::Roles
				FillInForm
				FormValidator::Simple
				FormValidator::Simple::Auto
				Cache
/;
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in catal.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

#__PACKAGE__->config( name => 'Catal' );
__PACKAGE__->config( name => 'Catal',
					 default_view => 'TT',
					 default_model => 'CatalDB',
					 'Plugin::Session' => {
						expires => 1800,
						storage => 'c:/tmp',
						namespace => 'MyApp',
						cookie_expires => 0,
						verify_address => 1,
						verify_user_agent => 1,
					 },
					 'Plugin::Authentication' => {
						default => {
							credential => {
								class => 'Password',
								password_field => 'passwd',
								password_type => 'hashed',
								password_hash_type => 'MD5',
							},
							store => {
								class => 'DBIx::Class',
								user_model => 'CatalDB::Usr',
								use_userdata_from_session =>1,
								role_relation => 'roles',
								role_field => 'role',
							}
						}
					 },
					 'validator' => {
						plugins => [qw/Japanese MyApp/],
						options => {
							charset => 'utf8',
						},
						profiles => __PACKAGE__->path_to('profiles.yml'),
						message_format => '<span class="error">%s</span>',
					 },
					 'Plugin::Cache' => {
						'backend' => {
							class => 'Cache::FileCache',
							cache_root => 'C:/tmp',
							namespace => 'MyApp',
							default_expires_in => 30,
						}
					 },
);


# Start the application
__PACKAGE__->setup();


=head1 NAME

Catal - Catalyst based application

=head1 SYNOPSIS

    script/catal_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Catal::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
