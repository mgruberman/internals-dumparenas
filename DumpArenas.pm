package Internals::DumpArenas;

use strict;
use warnings;

# $ perl ppport.h
# Scanning ./DumpArenas.xs ...
# === Analyzing ./DumpArenas.xs ===
# Uses PL_sv_arenaroot
# Uses PL_sv_no
# Uses PL_sv_undef
# Uses PL_sv_yes
# Uses aTHX
# Uses aTHX_
# Uses pTHX
# Uses pTHX_
# *** Uses HEf_SVKEY, which may not be portable below perl 5.004
# *** Uses HeKEY, which may not be portable below perl 5.004
# *** Uses HeKLEN, which may not be portable below perl 5.004
# *** Uses HeVAL, which may not be portable below perl 5.004
# *** Uses do_sv_dump, which may not be portable below perl 5.6.0
# *** Uses pv_display, which may not be portable below perl 5.6.0
# Looks good
use 5.006_000;

use vars qw( $VERSION );
$VERSION = '0.06';

use DynaLoader ();
sub dl_load_flags { 0x01 }
DynaLoader::bootstrap('Internals::DumpArenas', $VERSION);

use Sub::Exporter -setup => {
	exports => [
		qw( DumpArenas DumpArenasFd ),
	],
};

no warnings;
qq{ ...A most horrible treasure, this Great Ring," said Frito.

"And a horrible burden for he who bears it," said Goodgulf, "for some
unlucky one must carry it from Sorhed's grasp into danger and certain
doom. Someone must take the ring to the Zazu Pits of Fordor, under the
evil nose of the wrathful Sorhed, yet appear so unsuited to his task
that he will not soon be found out."

Frito shivered in sympathy for such an unfortunate.

"Then the bearer should be a complete and utter dunce," he laughed
nervously.

Goodgulf glanced at Dildo, who nodded and casually flipped a small,
shining object into Frito's lap. It was a ring.

"Congratulations," said Dildo somberly. "You've just won the booby
prize"... };
