use Test::More tests => 2;
BEGIN { use_ok('Internals::DumpArenas') };

Internals::DumpArenas::DumpArenas();
pass( 'Still alive' );
