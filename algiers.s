0010 <__trap_interrupt>
0010:  3041           ret
4400 <__init_stack>
4400:  3140 0044      mov	#0x4400, sp
4404 <__low_level_init>
4404:  1542 5c01      mov	&0x015c, r5
4408:  75f3           and.b	#-0x1, r5
440a:  35d0 085a      bis	#0x5a08, r5
440e <__do_copy_data>
440e:  3f40 0600      mov	#0x6, r15
4412:  0f93           tst	r15
4414:  0724           jz	#0x4424 <__do_clear_bss+0x0>
4416:  8245 5c01      mov	r5, &0x015c
441a:  2f83           decd	r15
441c:  9f4f 4847 0024 mov	0x4748(r15), 0x2400(r15)
4422:  f923           jnz	#0x4416 <__do_copy_data+0x8>
4424 <__do_clear_bss>
4424:  3f40 0000      clr	r15
4428:  0f93           tst	r15
442a:  0624           jz	#0x4438 <main+0x0>
442c:  8245 5c01      mov	r5, &0x015c
4430:  1f83           dec	r15
4432:  cf43 0624      mov.b	#0x0, 0x2406(r15)
4436:  fa23           jnz	#0x442c <__do_clear_bss+0x8>


4438 <main>
4438:  3150 9cff      add	#0xff9c, sp
443c:  b012 3a46      call	#0x463a <login>

4440 <__stop_progExec__>
4440:  32d0 f000      bis	#0xf0, sr
4444:  fd3f           jmp	#0x4440 <__stop_progExec__+0x0>

4446 <__ctors_end>
4446:  3040 4647      br	#0x4746 <_unexpected_>


444a .strings:
444a: "Heap exausted; aborting."
4463: ""


; heap starts @ 2400
; structure:
;   2400:  pFirstChunk
;   2402:  size
;   2403:  needToInit    (=1)

; chunk strcture
;   0:  pPrevChunk
;   2:  pNextChunk
;   4:  info   (low bit = bTaken, rest = size)
;   6:  allocation


4464 <malloc>
4464:  0b12           push	r11
; if( needToInit ) {
4466:  c293 0424      tst.b	&0x2404
446a:  0f24           jz	#0x448a <malloc+0x26>
;   pChunk = pfirstchunk
446c:  1e42 0024      mov	&0x2400, r14
;   pChunk->pPrevChunk = pfirstchunk
4470:  8e4e 0000      mov	r14, 0x0(r14)
;   pChunk->pnextchunk = pfirstchunk
4474:  8e4e 0200      mov	r14, 0x2(r14)
;   // set up entire remaining free space as unallocated
;   pChunk->info = (heapsize - 6) * 2
4478:  1d42 0224      mov	&0x2402, r13
447c:  3d50 faff      add	#0xfffa, r13
4480:  0d5d           add	r13, r13
4482:  8e4d 0400      mov	r13, 0x4(r14)
;   needToInit = 0
4486:  c243 0424      mov.b	#0x0, &0x2404
; }

;   r11 = pFirstChunk
;   pChunk [r14] = pFirstChunk
448a:  1b42 0024      mov	&0x2400, r11
448e:  0e4b           mov	r11, r14
;   if( !(pChunk->info & 1) ) { // if free
4490:  1d4e 0400      mov	0x4(r14), r13
4494:  1db3           bit	#0x1, r13
4496:  2820           jnz	#0x44e8 <malloc+0x84>
4498:  0c4d           mov	r13, r12
449a:  12c3           clrc
449c:  0c10           rrc	r12
449e:  0c9f           cmp	r15, r12
44a0:  2338           jl	#0x44e8 <malloc+0x84>
44a2:  0b4f           mov	r15, r11
44a4:  3b50 0600      add	#0x6, r11
44a8:  0c9b           cmp	r11, r12
44aa:  042c           jc	#0x44b4 <malloc+0x50>
44ac:  1dd3           bis	#0x1, r13
44ae:  8e4d 0400      mov	r13, 0x4(r14)
44b2:  163c           jmp	#0x44e0 <malloc+0x7c>
44b4:  0d4f           mov	r15, r13
44b6:  0d5d           add	r13, r13
44b8:  1dd3           bis	#0x1, r13
44ba:  8e4d 0400      mov	r13, 0x4(r14)
44be:  0d4e           mov	r14, r13
44c0:  3d50 0600      add	#0x6, r13
44c4:  0d5f           add	r15, r13
44c6:  8d4e 0000      mov	r14, 0x0(r13)
44ca:  9d4e 0200 0200 mov	0x2(r14), 0x2(r13)
44d0:  0c8f           sub	r15, r12
44d2:  3c50 faff      add	#0xfffa, r12
44d6:  0c5c           add	r12, r12
44d8:  8d4c 0400      mov	r12, 0x4(r13)
44dc:  8e4d 0200      mov	r13, 0x2(r14)
44e0:  0f4e           mov	r14, r15
44e2:  3f50 0600      add	#0x6, r15
44e6:  0e3c           jmp	#0x4504 <malloc+0xa0>
;   }
;   else {    // keep looking for a new chunk
44e8:  0d4e           mov	r14, r13
44ea:  1e4e 0200      mov	0x2(r14), r14
44ee:  0e9d           cmp	r13, r14
44f0:  0228           jnc	#0x44f6 <malloc+0x92>
44f2:  0e9b           cmp	r11, r14
44f4:  cd23           jne	#0x4490 <malloc+0x2c>
44f6:  3f40 4a44      mov	#0x444a "Heap exausted; aborting.", r15
44fa:  b012 1a47      call	#0x471a <puts>
44fe:  3040 4044      br	#0x4440 <__stop_progExec__>
4502:  0f43           clr	r15
4504:  3b41           pop	r11
4506:  3041           ret


; password: 8w of whatever, tailchunk->prev, tailchunk->next, tailchunk->info
; username: 8w of whatever, pwdchunk->prev, pwdchunk->next, pwdchunk->info
;                                   PrevNextInfo
;   414141414141414141414141414141415e455e4521f4

; vector: blat instr @ 4562 with any 1word, non jump instr
;     OR: blat return pc with 4562

; addresses we write to:
;
;   if next chunk "free":   // any instr or sp addr will be free
;       pChunk->info    += pChunk->pNextChunk->info + 6
;
;   if prev chunk free: 
;       pChunk->pPrevChunk->info += pChunk->info + 6
;

; void free(void* pAlloc)
4508 <free>
4508:  0b12           push	r11
;   pChunk = (char*)pAlloc - 6
450a:  3f50 faff      add	#0xfffa, r15
;   pChunk->info &= 0xfffe      // clear the "taken" bit
450e:  1d4f 0400      mov	0x4(r15), r13
4512:  3df0 feff      and	#0xfffe, r13
4516:  8f4d 0400      mov	r13, 0x4(r15)
;   prevchunk [r14] = pChunk->pPrevChunk
451a:  2e4f           mov	@r15, r14
;   if( !(prevchunk->info & 1) ) {  // if prev chunk was free
451c:  1c4e 0400      mov	0x4(r14), r12
4520:  1cb3           bit	#0x1, r12
4522:  0d20           jnz	#0x453e <free+0x36>
;       prevchunk->info = prevchunk->info + sizeof(chunkhdr) + pchunk->info
4524:  3c50 0600      add	#0x6, r12
4528:  0c5d           add	r13, r12
452a:  8e4c 0400      mov	r12, 0x4(r14)
;       prvchunk->nextchunk = pChunk->nextchunk
452e:  9e4f 0200 0200 mov	0x2(r15), 0x2(r14)
;       nextchunk [r13] = pChunk->pNextChunk
4534:  1d4f 0200      mov	0x2(r15), r13
;       nextchunk->pPrevChunk = prevchunk
4538:  8d4e 0000      mov	r14, 0x0(r13)
;       pChunk = pChunk->pPrevChunk
453c:  2f4f           mov	@r15, r15
;   }   // if prev chunk free
;
;   nextchunk = pChunk->pNextChunk
453e:  1e4f 0200      mov	0x2(r15), r14
;   if( !(nextchunk->info & 1) ) {  // if next chunk is free
4542:  1d4e 0400      mov	0x4(r14), r13
4546:  1db3           bit	#0x1, r13
4548:  0b20           jnz	#0x4560 <free+0x58>
;       pChunk->info = nextchunk->info + pChunk->info + 6
454a:  1d5f 0400      add	0x4(r15), r13
454e:  3d50 0600      add	#0x6, r13
4552:  8f4d 0400      mov	r13, 0x4(r15)
;       pChunk->pNextChunk = nextchunk->pNextChunk
4556:  9f4e 0200 0200 mov	0x2(r14), 0x2(r15)
;       nextchunk->pPrevChunk = pChunk      // why?
455c:  8e4f 0000      mov	r15, 0x0(r14)
;   }   // if next chunk free
;
4560:  3b41           pop	r11
4562:  3041           ret



4564 <unlock_door>
4564:  3012 7f00      push	#0x7f
4568:  b012 b646      call	#0x46b6 <INT>
456c:  2153           incd	sp
456e:  3041           ret

4570 <test_password_valid>
4570:  0412           push	r4
4572:  0441           mov	sp, r4
4574:  2453           incd	r4
4576:  2183           decd	sp
4578:  c443 fcff      mov.b	#0x0, -0x4(r4)
457c:  3e40 fcff      mov	#0xfffc, r14
4580:  0e54           add	r4, r14
4582:  0e12           push	r14
4584:  0f12           push	r15
4586:  3012 7d00      push	#0x7d
458a:  b012 b646      call	#0x46b6 <INT>
458e:  5f44 fcff      mov.b	-0x4(r4), r15
4592:  8f11           sxt	r15
4594:  3152           add	#0x8, sp
4596:  3441           pop	r4
4598:  3041           ret

459a: "Enter your username and password to continue"
45c8: "Username >>"
45d4: "(Remember: passwords are between 8 and 16 characters.)"
460b: "Access granted"
461b: "That password is not correct"

463a <login>
463a:  0b12           push	r11
463c:  0a12           push	r10
463e:  3f40 1000      mov	#0x10, r15
4642:  b012 6444      call	#0x4464 <malloc>
4646:  0a4f           mov	r15, r10
4648:  3f40 1000      mov	#0x10, r15
464c:  b012 6444      call	#0x4464 <malloc>
4650:  0b4f           mov	r15, r11
4652:  3f40 9a45      mov	#0x459a "Enter your username and password to continue", r15
4656:  b012 1a47      call	#0x471a <puts>
465a:  3f40 c845      mov	#0x45c8 "Username >>", r15
465e:  b012 1a47      call	#0x471a <puts>
4662:  3e40 3000      mov	#0x30, r14
4666:  0f4a           mov	r10, r15
4668:  b012 0a47      call	#0x470a <getsn>
466c:  3f40 c845      mov	#0x45c8 "Username >>", r15
4670:  b012 1a47      call	#0x471a <puts>
4674:  3f40 d445      mov	#0x45d4 "(Remember: passwords are between 8 and 16 characters.)", r15
4678:  b012 1a47      call	#0x471a <puts>
467c:  3e40 3000      mov	#0x30, r14
4680:  0f4b           mov	r11, r15
4682:  b012 0a47      call	#0x470a <getsn>
4686:  0f4b           mov	r11, r15
4688:  b012 7045      call	#0x4570 <test_password_valid>
468c:  0f93           tst	r15
468e:  0524           jz	#0x469a <login+0x60>
4690:  b012 6445      call	#0x4564 <unlock_door>
4694:  3f40 0b46      mov	#0x460b "Access granted", r15
4698:  023c           jmp	#0x469e <login+0x64>
469a:  3f40 1b46      mov	#0x461b "That password is not correct", r15
469e:  b012 1a47      call	#0x471a <puts>
46a2:  0f4b           mov	r11, r15
46a4:  b012 0845      call	#0x4508 <free>
46a8:  0f4a           mov	r10, r15
46aa:  b012 0845      call	#0x4508 <free>
46ae:  3a41           pop	r10
46b0:  3b41           pop	r11
46b2:  3041           ret

46b4 <__do_nothing>
46b4:  3041           ret

46b6 <INT>
46b6:  1e41 0200      mov	0x2(sp), r14
46ba:  0212           push	sr
46bc:  0f4e           mov	r14, r15
46be:  8f10           swpb	r15
46c0:  024f           mov	r15, sr
46c2:  32d0 0080      bis	#0x8000, sr
46c6:  b012 1000      call	#0x10
46ca:  3241           pop	sr
46cc:  3041           ret

46ce <putchar>
46ce:  2183           decd	sp
46d0:  0f12           push	r15
46d2:  0312           push	#0x0
46d4:  814f 0400      mov	r15, 0x4(sp)
46d8:  b012 b646      call	#0x46b6 <INT>
46dc:  1f41 0400      mov	0x4(sp), r15
46e0:  3150 0600      add	#0x6, sp
46e4:  3041           ret

46e6 <getchar>
46e6:  0412           push	r4
46e8:  0441           mov	sp, r4
46ea:  2453           incd	r4
46ec:  2183           decd	sp
46ee:  3f40 fcff      mov	#0xfffc, r15
46f2:  0f54           add	r4, r15
46f4:  0f12           push	r15
46f6:  1312           push	#0x1
46f8:  b012 b646      call	#0x46b6 <INT>
46fc:  5f44 fcff      mov.b	-0x4(r4), r15
4700:  8f11           sxt	r15
4702:  3150 0600      add	#0x6, sp
4706:  3441           pop	r4
4708:  3041           ret

470a <getsn>
470a:  0e12           push	r14
470c:  0f12           push	r15
470e:  2312           push	#0x2
4710:  b012 b646      call	#0x46b6 <INT>
4714:  3150 0600      add	#0x6, sp
4718:  3041           ret

471a <puts>
471a:  0b12           push	r11
471c:  0b4f           mov	r15, r11
471e:  073c           jmp	#0x472e <puts+0x14>
4720:  1b53           inc	r11
4722:  8f11           sxt	r15
4724:  0f12           push	r15
4726:  0312           push	#0x0
4728:  b012 b646      call	#0x46b6 <INT>
472c:  2152           add	#0x4, sp
472e:  6f4b           mov.b	@r11, r15
4730:  4f93           tst.b	r15
4732:  f623           jnz	#0x4720 <puts+0x6>
4734:  3012 0a00      push	#0xa
4738:  0312           push	#0x0
473a:  b012 b646      call	#0x46b6 <INT>
473e:  2152           add	#0x4, sp
4740:  0f43           clr	r15
4742:  3b41           pop	r11
4744:  3041           ret

4746 <_unexpected_>
4746:  0013           reti	pc