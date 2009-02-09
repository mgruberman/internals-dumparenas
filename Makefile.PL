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

        # bin/puke
        'Moose' => 0,
        'parent' => 0,
        'Pod::Usage' => 0,
        'Expect' => 0,
        'IO::Stty' => 0,
	},
    EXE_FILES => [ 'bin/puke' ],
);
