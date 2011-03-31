use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Ctrl::Flow' }

ok( request('/ctrl/flow')->is_success, 'Request should succeed' );


