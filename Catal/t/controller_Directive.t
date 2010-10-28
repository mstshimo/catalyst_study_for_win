use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Directive' }

ok( request('/directive')->is_success, 'Request should succeed' );


