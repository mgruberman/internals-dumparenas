#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

void
DumpAvARRAY( pTHX_ PerlIO *f, SV *sv) {
  I32 key = 0;

  PerlIO_printf(f,"AvARRAY(0x%x) = {",(int)AvARRAY(sv));
  if ( AvMAX(sv) != AvFILL(sv) ) {
    PerlIO_puts(f,"{");
  }
  
  for ( key = 0; key <= AvMAX(sv); ++key ) {
    if ( &PL_sv_undef == AvARRAY(sv)[key] ) {
      PerlIO_puts(f,"PL_sv_undef");
    }
    else if ( &PL_sv_yes == AvARRAY(sv)[key] ) {
      PerlIO_puts(f,"PL_sv_yes");
    }
    else if ( &PL_sv_no == AvARRAY(sv)[key] ) {
      PerlIO_puts(f,"PL_sv_no");
    }
    else if ( &PL_sv_placeholder == AvARRAY(sv)[key] ) {
      PerlIO_puts(f,"PL_sv_placeholder");
    }
    else {
      PerlIO_printf(f,"0x%x", (int)AvARRAY(sv)[key]);
    }
    
    /* Join with something */
    if ( AvMAX(sv) == AvFILL(sv) ) {
      PerlIO_puts(f, AvMAX(sv) == key ? "}" : ",");
    }
    else {
      PerlIO_puts(
        f,
        AvFILL(sv) == key ? "}{" :
        AvMAX(sv) == key  ? "}" :
        ","
      );
    }
  }
  PerlIO_puts(f,"}\n\n");
}

void
DumpHvARRAY( pTHX_ PerlIO *f, SV *sv) {
  I32 key = 0;
  HE *entry;
  SV *tmp = newSVpv("",0);

  PerlIO_printf(f,"ARRAY(0x%x)\n",(int)HvARRAY(sv));

  for ( key = 0; key <= HvMAX(sv); ++key ) {
    for ( entry = HvARRAY(sv)[key]; entry; entry = HeNEXT(entry) ) {
      if ( HEf_SVKEY == HeKLEN(entry) ) {
        croak("not implemented");
        /* PerlIO_printf(f, "    [SV 0x%x %s] => 0x%x\n", HeKEY(entry), pv_display(tmp,SvPVHeVAL(entry) );*/
      }
      else {
        PerlIO_printf(
          f, "    [0x%x %s] => 0x%x\n",
          (int)HeKEY(entry),
          pv_display(
            tmp,
            HeKEY(entry), HeKLEN(entry), HeKLEN(entry),
            0 ),
          (int)HeVAL(entry) );
      }
    }
  }
  PerlIO_puts(f,"\n");

  SvREFCNT_dec(tmp);
}

/*
void
DumpHashKeys( aTHX_ PerlIO *f, SV *sv) {
  I32 key = 0;
  HE *entry;
  SV *tmp = newSVpv("",0);

  PerlIO_printf(f,"HASH KEYS at 0x%x\n",sv);
  
  for ( key = 0; key <= HvMAX(sv); ++key ) {
    for ( entry = HvARRAY(sv)[key]; entry; entry = HeNEXT(entry) ) {
      if ( HEf_SVKEY == HeKLEN(entry) ) {
        PerlIO_printf(f, "    SV 0x%x\n", HeKEY(entry) );
      }
      else {
        PerlIO_printf(f, "    0x%x %s\n", HeKEY(entry), pv_display( (SV*)tmp, (const char*)HeKEY(entry), HeKLEN(entry), HeKLEN(entry), 0 ) );
      } 
    }
  }
  PerlIO_puts(f,"\n\n");

  SvREFCNT_dec(tmp);
}
*/

void
DumpArenasPerlIO( pTHX_ PerlIO *f) {
  SV *arena;
  
  for (arena = PL_sv_arenaroot; arena; arena = (SV*)SvANY(arena)) {
    const SV *const arena_end = &arena[SvREFCNT(arena)];
    SV *sv;
    
    PerlIO_printf(f,"START ARENA = (0x%x-0x%x)\n\n",(int)arena,(int)arena_end);
    for (sv = arena + 1; sv < arena_end; ++sv) {
      if (SvTYPE(sv) != SVTYPEMASK
          && SvREFCNT(sv)) {

        /* Dump the plain SV */
        do_sv_dump( aTHX_ 0,f,sv,0,0,0,0);
        PerlIO_puts(f,"\n");
        
        /* Dump AvARRAY(0x...) = {{0x...,0x...}{0x...}} */
        switch (SvTYPE(sv)) {
        case SVt_PVAV:
          if ( AvARRAY(sv)
               && AvMAX(sv) != -1 ) {
            DumpAvARRAY( aTHX_ f,sv);
          }
          break;
        case SVt_PVHV:
          if ( HvARRAY(sv)
               && HvMAX(sv) != -1 ) {
            DumpHvARRAY( aTHX_ f,sv);
          }
          
          if ( ! HvSHAREKEYS(sv) ) {
            /* DumpHashKeys( aTHX_ f,sv); */
          }
          
          break;
        }
      }
      else {
        PerlIO_printf(f,"AVAILABLE(0x%x)\n\n",(int)sv);
      }
    }
    PerlIO_printf(f,"END ARENA = (0x%x-0x%x)\n\n",(int)arena,(int)arena_end);
  }
}

void
DumpArenas( pTHX ) {
  DumpArenasPerlIO( aTHX_ Perl_error_log );
}

void
DumpArenasFd( pTHX_ int fd ) {
  PerlIO *f = (PerlIO*)PerlIO_fdopen( fd, "w" );
  DumpArenasPerlIO( aTHX_ f );
}

MODULE = Internals::DumpArenas  PACKAGE = Internals::DumpArenas
  
PROTOTYPES: DISABLE

void
DumpArenas()
    CODE:
        DumpArenas( aTHX );

void
DumpArenasFd( int fn )
    CODE:
        DumpArenasFd( aTHX_ fn );
