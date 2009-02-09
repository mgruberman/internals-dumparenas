use strict;
use warnings;
use ExtUtils::MakeMaker;
WriteMakefile(
	NAME              => 'Internals::DumpArenas',,
	VERSION_FROM      => 'lib/Internals/DumpArenas.pm',
	AUTHOR            => 'WhitePages.com <whitepage@cpan.org>',
	PREREQ_PM => {
		'Sub::Exporter' => 0,
	},
);
