package CPAN::Common::Index::Snapshot;
use strict;
use warnings;

our $VERSION = '0.001';
use parent 'CPAN::Common::Index';
use Carton::Snapshot;
use CPAN::Meta::Requirements;

sub new {
    my ($class, %option) = @_;
    my $path = $option{path} || "cpanfile.snapshot";
    my $snapshot = Carton::Snapshot->new(path => $path);
    $snapshot->load;
    bless { snapshot => $snapshot }, $class;
}

sub snapshot { shift->{snapshot} }

sub search_packages {
    my ($self, $args) = @_;
    my $package = $args->{package};
    my $found = $self->snapshot->find($package);
    return unless $found;

    my $snapshot_version = $found->version_for($package);
    if (exists $args->{version} or exists $args->{version_range}) {
        my $range = exists $args->{version} ? "== $args->{version}" : $args->{version_range};
        my $reqs = CPAN::Meta::Requirements->from_string_hash({ $package => $range });
        if (!$reqs->accepts_module($package, $snapshot_version)) {
            return;
        }
    }

    my $distfile = $found->distfile;
    $distfile =~ s{^./../}{};
    return {
        package => $package,
        version => $snapshot_version,
        uri     => "cpan://distfile/$distfile",
    };
}

sub search_authors {
    die "not implemented";
}

1;
__END__

=encoding utf-8

=for stopwords hackability

=head1 NAME

CPAN::Common::Index::Snapshot - query packages against cpanfile.snapshot

=head1 SYNOPSIS

  use CPAN::Common::Index::Snapshot;

  my $index = CPAN::Common::Index::Snapshot->new(path => "./cpanfile.snapshot");
  my $found = $index->search_packages({package => "Plack"});

  print Dumper $found;
  # {
  #   package => 'Plack',
  #   version => '1.0037'
  #   uri      => 'cpan://distfile/MIYAGAWA/Plack-1.0037.tar.gz',
  # }

=head1 DESCRIPTION

CPAN::Common::Index::Snapshot is a subclass of L<CPAN::Common::Index>,
which queries packages against your B<cpanfile.snapshot>.

Currently if you invoke C<carton install --deployment>,
L<Carton> creates B<02packages.details.txt> from B<cpanfile.snapshot>,
and L<cpanm> uses it.

Why don't you query B<cpanfile.snapshot> directly?
I'm sure the hackability of L<Menlo> will allow us to do this.

=head1 SEE ALSO

L<CPAN::Common::Index>

L<App::cpanminus>

L<Menlo>

L<Caron>

L<Menlo::Index::*|https://github.com/miyagawa/cpanminus/tree/menlo/lib/Menlo/Index>

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
