use strict;
use warnings;
use testapi;
use autotest;
use distribution;

testapi::set_distribution(distribution->new);

if (defined(get_var('PUBLISH_HDD_1'))) {
    autotest::loadtest('tests/installer/install_reactos.pm');
}

1;
