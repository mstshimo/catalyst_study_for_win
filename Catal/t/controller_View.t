use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::View' }

ok( request('/view')->is_success, 'Request should succeed' );


