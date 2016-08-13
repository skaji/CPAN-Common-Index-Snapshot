[![Build Status](https://travis-ci.org/skaji/CPAN-Common-Index-Snapshot.svg?branch=master)](https://travis-ci.org/skaji/CPAN-Common-Index-Snapshot)

# NAME

CPAN::Common::Index::Snapshot - query packages against cpanfile.snapshot

# SYNOPSIS

    use CPAN::Common::Index::Snapshot;

    my $index = CPAN::Common::Index::Snapshot->new(path => "./cpanfile.snapshot");
    my $found = $index->search_packages({package => "Plack"});

    print Dumper $found;
    # {
    #   package => 'Plack',
    #   version => '1.0037'
    #   uri      => 'cpan://distfile/MIYAGAWA/Plack-1.0037.tar.gz',
    # }

# DESCRIPTION

CPAN::Common::Index::Snapshot is a subclass of [CPAN::Common::Index](https://metacpan.org/pod/CPAN::Common::Index),
which queries packages against your **cpanfile.snapshot**.

Currently if you invoke `carton install --deployment`,
[Carton](https://metacpan.org/pod/Carton) creates **02packages.details.txt** from **cpanfile.snapshot**,
and [cpanm](https://metacpan.org/pod/cpanm) uses it.

Why don't you query **cpanfile.snapshot** directly?
I'm sure the hackability of [Menlo](https://metacpan.org/pod/Menlo) will allow us to do this.

# SEE ALSO

[CPAN::Common::Index](https://metacpan.org/pod/CPAN::Common::Index)

[App::cpanminus](https://metacpan.org/pod/App::cpanminus)

[Menlo](https://metacpan.org/pod/Menlo)

[Carton](https://metacpan.org/pod/Carton)

[Menlo::Index::\*](https://github.com/miyagawa/cpanminus/tree/menlo/lib/Menlo/Index)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
