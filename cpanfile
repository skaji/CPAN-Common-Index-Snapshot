requires 'perl', '5.008005';

requires 'parent';
requires 'CPAN::Common::Index';
requires 'Carton::Snapshot';
requires 'CPAN::Meta::Requirements';

on test => sub {
    requires 'Test::More', '0.98';
};
