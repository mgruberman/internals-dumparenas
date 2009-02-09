use strict;
use warnings;
use ExtUtils::MakeMaker;
WriteMakefile(
	NAME              => 'Internals::DumpArenas',
    ABSTRACT_FROM     => 'DumpArenas.pod',
	VERSION_FROM      => 'DumpArenas.pm',
	AUTHOR            => 'Joshua ben Jore <jjore@cpan.org>',
	PREREQ_PM => {
		'Sub::Exporter' => 0,
	},
);
