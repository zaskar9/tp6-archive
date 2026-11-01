SNDBLS - SOUND BLASTER
======================
Sound Blaster programming, September 1993 to September 1994.

SBLASTER.PAS  program Soundblaster (Mar 1994): programs the FM
              chip directly through port 220h
SBOSZ.PAS     program sbscope (Sept 1993): oscilloscope display of
              the sampled input
SOUNDBLS.PAS  test (Mar 1994)
SNDBLST.PAS   unit SndBlst (Jun 1994), with SNDTEST.PAS
SNDBLS.PAS    unit SndBls (Sept 1994), the newer unit, with
              TEST.PAS, INTERRPT.PAS (IRQ mode, INIT.INC), DEMO.PAS.
              INTERRPT.PAS hooks the timer interrupt 08h and plays
              VL1.CMP, VL2.CMP and HN1.CMP (from C:\TPWORK\SBLASTER)
              on three FM channels at once.
SBTEST.PAS    plays Composer .CMP songs through unit Musik
PORTTEST.PAS  port test (Feb 1994)
HN1.CMP, TONLEIT.CMP, VL1.CMP, VL2.CMP   test songs
SONG.SBL      song data; SOUNDMAN.DOC notes
HOOK.EXE      18 Sept 1994: the build of INTERRPT.PAS, renamed
              after the interrupt hook. Recompiling INTERRPT.PAS
              with Turbo Pascal 6.0 gives this file byte for byte
              (checked Nov 2026).
OLD\  older builds of SBLASTER.EXE and SBOSZ.EXE
