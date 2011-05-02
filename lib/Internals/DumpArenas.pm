package Internals::DumpArenas;
#ABSTRACT: Dump perl memory

use 5.006_000;

$VERSION = '0.09';

use DynaLoader ();
sub dl_load_flags { return 0x01 }
DynaLoader::bootstrap('Internals::DumpArenas', $VERSION);

use Exporter ();
@ISA = 'Exporter';
@EXPORT_OK = qw( DumpArenas DumpArenasFd );
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

no warnings;
q{ ...A most horrible treasure, this Great Ring," said Frito.

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
