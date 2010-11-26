package Catal::Model::DateTimeAdaptor;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Catal::Api::DateTime',
    constructor => 'now',
);

1;
