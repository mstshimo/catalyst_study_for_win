package Catal::Model::BookAdaptor;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Catal::Api::Book',
    constructor => 'new',
);

1;
