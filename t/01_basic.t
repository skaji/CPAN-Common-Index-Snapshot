use strict;
use warnings;
use Test::More;
use CPAN::Common::Index::Snapshot;

my $index = CPAN::Common::Index::Snapshot->new(path => "t/cpanfile.snapshot");


subtest basic => sub {
    my $found;
    $found = $index->search_packages({package => "LWP::Authen::Basic"});
    is_deeply $found, {
        package => "LWP::Authen::Basic",
        version => "undef", # string
        uri => "cpan://distfile/ETHER/libwww-perl-6.13.tar.gz",
    };
    $found = $index->search_packages({package => "LWP"});
    is_deeply $found, {
        package => "LWP",
        version => 6.13,
        uri => "cpan://distfile/ETHER/libwww-perl-6.13.tar.gz",
    };
    $found = $index->search_packages({package => "Moose"});
    ok !$found;
};

subtest with_version => sub {
    my $found;
    $found = $index->search_packages({package => "LWP::Authen::Basic", version => 0});
    is_deeply $found, {
        package => "LWP::Authen::Basic",
        version => "undef", # string
        uri => "cpan://distfile/ETHER/libwww-perl-6.13.tar.gz",
    };
    $found = $index->search_packages({package => "LWP", version => 1});
    ok !$found; # NOTE: version is EXACT match
    $found = $index->search_packages({package => "LWP", version => 6.13});
    is_deeply $found, {
        package => "LWP",
        version => 6.13,
        uri => "cpan://distfile/ETHER/libwww-perl-6.13.tar.gz",
    };
    $found = $index->search_packages({package => "LWP", version_range => "> 1"});
    is_deeply $found, {
        package => "LWP",
        version => 6.13,
        uri => "cpan://distfile/ETHER/libwww-perl-6.13.tar.gz",
    };
    $found = $index->search_packages({package => "LWP", version_range => "> 7.00"});
    ok !$found;
};


done_testing;
