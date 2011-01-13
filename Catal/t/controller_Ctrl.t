use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Ctrl' }

ok( request('/ctrl')->is_success, 'Request should succeed' );


