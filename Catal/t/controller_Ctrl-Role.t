use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Ctrl::Role' }

ok( request('/ctrl/role')->is_success, 'Request should succeed' );


