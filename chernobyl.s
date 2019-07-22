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
441c:  9f4f 9e4d 0024 mov	0x4d9e(r15), 0x2400(r15)
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
4438:  3182           sub	#0x8, sp
443a:  b012 664b      call	#0x4b66 <run>
443e <__stop_progExec__>
443e:  32d0 f000      bis	#0xf0, sr
4442:  fd3f           jmp	#0x443e <__stop_progExec__+0x0>
4444 <__ctors_end>
4444:  3040 9c4d      br	#0x4d9c <_unexpected_>


4448 <printf>
4448:  0b12           push	r11
444a:  0a12           push	r10
444c:  0912           push	r9
444e:  0812           push	r8
4450:  0712           push	r7
4452:  0612           push	r6
4454:  0412           push	r4
4456:  0441           mov	sp, r4
4458:  3450 0e00      add	#0xe, r4
445c:  2183           decd	sp
445e:  1b44 0200      mov	0x2(r4), r11
4462:  8441 f0ff      mov	sp, -0x10(r4)
4466:  0f4b           mov	r11, r15
4468:  0e43           clr	r14
446a:  0b3c           jmp	#0x4482 <printf+0x3a>
446c:  1f53           inc	r15
446e:  7d90 2500      cmp.b	#0x25, r13
4472:  0720           jne	#0x4482 <printf+0x3a>
4474:  6d9f           cmp.b	@r15, r13
4476:  0320           jne	#0x447e <printf+0x36>
4478:  1f53           inc	r15
447a:  0d43           clr	r13
447c:  013c           jmp	#0x4480 <printf+0x38>
447e:  1d43           mov	#0x1, r13
4480:  0e5d           add	r13, r14
4482:  6d4f           mov.b	@r15, r13
4484:  4d93           tst.b	r13
4486:  f223           jnz	#0x446c <printf+0x24>
4488:  0f4e           mov	r14, r15
448a:  0f5f           add	r15, r15
448c:  2f53           incd	r15
448e:  018f           sub	r15, sp
4490:  0941           mov	sp, r9
4492:  0c44           mov	r4, r12
4494:  2c52           add	#0x4, r12
4496:  0f41           mov	sp, r15
4498:  0d43           clr	r13
449a:  053c           jmp	#0x44a6 <printf+0x5e>
449c:  af4c 0000      mov	@r12, 0x0(r15)
44a0:  1d53           inc	r13
44a2:  2f53           incd	r15
44a4:  2c53           incd	r12
44a6:  0d9e           cmp	r14, r13
44a8:  f93b           jl	#0x449c <printf+0x54>
44aa:  0a43           clr	r10
44ac:  3640 0900      mov	#0x9, r6
44b0:  4c3c           jmp	#0x454a <printf+0x102>
44b2:  084b           mov	r11, r8
44b4:  1853           inc	r8
44b6:  7f90 2500      cmp.b	#0x25, r15
44ba:  0624           jeq	#0x44c8 <printf+0x80>
44bc:  1a53           inc	r10
44be:  0b48           mov	r8, r11
44c0:  8f11           sxt	r15
44c2:  b012 044d      call	#0x4d04 <putchar>
44c6:  413c           jmp	#0x454a <printf+0x102>
44c8:  6e48           mov.b	@r8, r14
44ca:  4e9f           cmp.b	r15, r14
44cc:  0620           jne	#0x44da <printf+0x92>
44ce:  1a53           inc	r10
44d0:  3f40 2500      mov	#0x25, r15
44d4:  b012 044d      call	#0x4d04 <putchar>
44d8:  353c           jmp	#0x4544 <printf+0xfc>
44da:  7e90 7300      cmp.b	#0x73, r14
44de:  0b20           jne	#0x44f6 <printf+0xae>
44e0:  2b49           mov	@r9, r11
44e2:  053c           jmp	#0x44ee <printf+0xa6>
44e4:  1a53           inc	r10
44e6:  1b53           inc	r11
44e8:  8f11           sxt	r15
44ea:  b012 044d      call	#0x4d04 <putchar>
44ee:  6f4b           mov.b	@r11, r15
44f0:  4f93           tst.b	r15
44f2:  f823           jnz	#0x44e4 <printf+0x9c>
44f4:  273c           jmp	#0x4544 <printf+0xfc>
44f6:  7e90 7800      cmp.b	#0x78, r14
44fa:  1e20           jne	#0x4538 <printf+0xf0>
44fc:  2b49           mov	@r9, r11
44fe:  2742           mov	#0x4, r7
4500:  163c           jmp	#0x452e <printf+0xe6>
4502:  0f4b           mov	r11, r15
4504:  8f10           swpb	r15
4506:  3ff0 ff00      and	#0xff, r15
450a:  12c3           clrc
450c:  0f10           rrc	r15
450e:  0f11           rra	r15
4510:  0f11           rra	r15
4512:  0f11           rra	r15
4514:  069f           cmp	r15, r6
4516:  0338           jl	#0x451e <printf+0xd6>
4518:  3f50 3000      add	#0x30, r15
451c:  023c           jmp	#0x4522 <printf+0xda>
451e:  3f50 5700      add	#0x57, r15
4522:  b012 044d      call	#0x4d04 <putchar>
4526:  0b5b           add	r11, r11
4528:  0b5b           add	r11, r11
452a:  0b5b           add	r11, r11
452c:  0b5b           add	r11, r11
452e:  3753           add	#-0x1, r7
4530:  3793           cmp	#-0x1, r7
4532:  e723           jne	#0x4502 <printf+0xba>
4534:  2a52           add	#0x4, r10
4536:  063c           jmp	#0x4544 <printf+0xfc>
4538:  7e90 6e00      cmp.b	#0x6e, r14
453c:  0320           jne	#0x4544 <printf+0xfc>
453e:  2f49           mov	@r9, r15
4540:  8f4a 0000      mov	r10, 0x0(r15)
4544:  2953           incd	r9
4546:  0b48           mov	r8, r11
4548:  1b53           inc	r11
454a:  6f4b           mov.b	@r11, r15
454c:  4f93           tst.b	r15
454e:  b123           jnz	#0x44b2 <printf+0x6a>
4550:  1144 f0ff      mov	-0x10(r4), sp
4554:  2153           incd	sp
4556:  3441           pop	r4
4558:  3641           pop	r6
455a:  3741           pop	r7
455c:  3841           pop	r8
455e:  3941           pop	r9
4560:  3a41           pop	r10
4562:  3b41           pop	r11
4564:  3041           ret


4566: "\n\n"
4569: "[alloc] [p %x] [n %x] [s %x]\n"
458b: " {%x} [ "
4594: "%x "
4598: "@%x [freed] [p %x] [n %x] [s %x]\n"

45ba <walk>
45ba:  0b12           push	r11
45bc:  0a12           push	r10
45be:  0912           push	r9
45c0:  0b4f           mov	r15, r11
45c2:  3f40 6645      mov	#0x4566 "\n\n", r15
45c6:  b012 504d      call	#0x4d50 <puts>
45ca:  1f4b 0400      mov	0x4(r11), r15
45ce:  0e4f           mov	r15, r14
45d0:  1ef3           and	#0x1, r14
45d2:  12c3           clrc
45d4:  0f10           rrc	r15
45d6:  0e93           tst	r14
45d8:  2e24           jz	#0x4636 <walk+0x7c>
45da:  0f12           push	r15
45dc:  1b12 0200      push	0x2(r11)
45e0:  2b12           push	@r11
45e2:  0b12           push	r11
45e4:  3012 6945      push	#0x4569 "[alloc] [p %x] [n %x] [s %x]\n"
45e8:  b012 4844      call	#0x4448 <printf>
45ec:  3150 0a00      add	#0xa, sp
45f0:  0a4b           mov	r11, r10
45f2:  3a50 0600      add	#0x6, r10
45f6:  0a12           push	r10
45f8:  3012 8b45      push	#0x458b " {%x} [ "
45fc:  b012 4844      call	#0x4448 <printf>
4600:  2152           add	#0x4, sp
4602:  0943           clr	r9
4604:  083c           jmp	#0x4616 <walk+0x5c>
4606:  2a12           push	@r10
4608:  3012 9445      push	#0x4594 "%x "
460c:  b012 4844      call	#0x4448 <printf>
4610:  2152           add	#0x4, sp
4612:  1953           inc	r9
4614:  2a53           incd	r10
4616:  1f4b 0400      mov	0x4(r11), r15
461a:  12c3           clrc
461c:  0f10           rrc	r15
461e:  0f11           rra	r15
4620:  099f           cmp	r15, r9
4622:  f12b           jnc	#0x4606 <walk+0x4c>
4624:  3f40 5d00      mov	#0x5d, r15
4628:  b012 044d      call	#0x4d04 <putchar>
462c:  3f40 0a00      mov	#0xa, r15
4630:  b012 044d      call	#0x4d04 <putchar>
4634:  0b3c           jmp	#0x464c <walk+0x92>
4636:  0f12           push	r15
4638:  1b12 0200      push	0x2(r11)
463c:  2b12           push	@r11
463e:  0b12           push	r11
4640:  3012 9845      push	#0x4598 "@%x [freed] [p %x] [n %x] [s %x]\n"
4644:  b012 4844      call	#0x4448 <printf>
4648:  3150 0a00      add	#0xa, sp
464c:  1b4b 0200      mov	0x2(r11), r11
4650:  1b92 0024      cmp	&0x2400, r11
4654:  ba23           jne	#0x45ca <walk+0x10>
4656:  3941           pop	r9
4658:  3a41           pop	r10
465a:  3b41           pop	r11
465c:  3041           ret


; heap starts @ 5000
; structure:
;   2400:  pFirstChunk
;   2402:  size
;   2403:  needToInit    (=1)

; chunk strcture
;   0:  pPrevChunk
;   2:  pNextChunk
;   4:  info   (low bit = bTaken, rest = size)
;   6:  allocation

; see algiers.s


465e: "Heap exausted; aborting."

4678 <malloc>
4678:  0b12           push	r11
467a:  c293 0424      tst.b	&0x2404
467e:  0f24           jz	#0x469e <malloc+0x26>
4680:  1e42 0024      mov	&0x2400, r14
4684:  8e4e 0000      mov	r14, 0x0(r14)
4688:  8e4e 0200      mov	r14, 0x2(r14)
468c:  1d42 0224      mov	&0x2402, r13
4690:  3d50 faff      add	#0xfffa, r13
4694:  0d5d           add	r13, r13
4696:  8e4d 0400      mov	r13, 0x4(r14)
469a:  c243 0424      mov.b	#0x0, &0x2404
469e:  1b42 0024      mov	&0x2400, r11
46a2:  0e4b           mov	r11, r14
46a4:  1d4e 0400      mov	0x4(r14), r13
46a8:  1db3           bit	#0x1, r13
46aa:  2820           jnz	#0x46fc <malloc+0x84>
46ac:  0c4d           mov	r13, r12
46ae:  12c3           clrc
46b0:  0c10           rrc	r12
46b2:  0c9f           cmp	r15, r12
46b4:  2338           jl	#0x46fc <malloc+0x84>
46b6:  0b4f           mov	r15, r11
46b8:  3b50 0600      add	#0x6, r11
46bc:  0c9b           cmp	r11, r12
46be:  042c           jc	#0x46c8 <malloc+0x50>
46c0:  1dd3           bis	#0x1, r13
46c2:  8e4d 0400      mov	r13, 0x4(r14)
46c6:  163c           jmp	#0x46f4 <malloc+0x7c>
46c8:  0d4f           mov	r15, r13
46ca:  0d5d           add	r13, r13
46cc:  1dd3           bis	#0x1, r13
46ce:  8e4d 0400      mov	r13, 0x4(r14)
46d2:  0d4e           mov	r14, r13
46d4:  3d50 0600      add	#0x6, r13
46d8:  0d5f           add	r15, r13
46da:  8d4e 0000      mov	r14, 0x0(r13)
46de:  9d4e 0200 0200 mov	0x2(r14), 0x2(r13)
46e4:  0c8f           sub	r15, r12
46e6:  3c50 faff      add	#0xfffa, r12
46ea:  0c5c           add	r12, r12
46ec:  8d4c 0400      mov	r12, 0x4(r13)
46f0:  8e4d 0200      mov	r13, 0x2(r14)
46f4:  0f4e           mov	r14, r15
46f6:  3f50 0600      add	#0x6, r15
46fa:  0e3c           jmp	#0x4718 <malloc+0xa0>
46fc:  0d4e           mov	r14, r13
46fe:  1e4e 0200      mov	0x2(r14), r14
4702:  0e9d           cmp	r13, r14
4704:  0228           jnc	#0x470a <malloc+0x92>
4706:  0e9b           cmp	r11, r14
4708:  cd23           jne	#0x46a4 <malloc+0x2c>
470a:  3f40 5e46      mov	#0x465e, r15
470e:  b012 504d      call	#0x4d50 <puts>
4712:  3040 3e44      br	#0x443e <__stop_progExec__>
4716:  0f43           clr	r15
4718:  3b41           pop	r11
471a:  3041           ret

471c <free>
471c:  0b12           push	r11
471e:  3f50 faff      add	#0xfffa, r15
4722:  1d4f 0400      mov	0x4(r15), r13
4726:  3df0 feff      and	#0xfffe, r13
472a:  8f4d 0400      mov	r13, 0x4(r15)
472e:  2e4f           mov	@r15, r14
4730:  1c4e 0400      mov	0x4(r14), r12
4734:  1cb3           bit	#0x1, r12
4736:  0d20           jnz	#0x4752 <free+0x36>
4738:  3c50 0600      add	#0x6, r12
473c:  0c5d           add	r13, r12
473e:  8e4c 0400      mov	r12, 0x4(r14)
4742:  9e4f 0200 0200 mov	0x2(r15), 0x2(r14)
4748:  1d4f 0200      mov	0x2(r15), r13
474c:  8d4e 0000      mov	r14, 0x0(r13)
4750:  2f4f           mov	@r15, r15
4752:  1e4f 0200      mov	0x2(r15), r14
4756:  1d4e 0400      mov	0x4(r14), r13
475a:  1db3           bit	#0x1, r13
475c:  0b20           jnz	#0x4774 <free+0x58>
475e:  1d5f 0400      add	0x4(r15), r13
4762:  3d50 0600      add	#0x6, r13
4766:  8f4d 0400      mov	r13, 0x4(r15)
476a:  9f4e 0200 0200 mov	0x2(r14), 0x2(r15)
4770:  8e4f 0000      mov	r15, 0x0(r14)
4774:  3b41           pop	r11
4776:  3041           ret


; typedef entry_t {
;   char[16] name
;   int      pin
; }
;
; typedef table_t {
;   int         numentries
;   int         log2nbuckets
;   int         maxentriesperbucket
;   entry_t**   pbuckets
;   int*        pentriesperbucket       // array of ints, num entries per bucket
; }

; table* create_hash_table(int log2nbuckets, int maxentriesperbucket)    // with A=3, B=5
4778 <create_hash_table>
4778:  0b12           push	r11
477a:  0a12           push	r10
477c:  0912           push	r9
477e:  0812           push	r8
4780:  0712           push	r7
4782:  0612           push	r6
4784:  074f           mov	r15, r7
4786:  094e           mov	r14, r9
; ptable<r10> = malloc(sizeof(table_t))
; ptable->numentries = 0
; ptable->log2nbuckets = log2nbuckets (3)
; ptable->maxentriesperbucket = maxentriesperbucket (5)
4788:  3f40 0a00      mov	#0xa, r15
478c:  b012 7846      call	#0x4678 <malloc>
4790:  0a4f           mov	r15, r10
4792:  8f43 0000      clr	0x0(r15)
4796:  8f47 0200      mov	r7, 0x2(r15)
479a:  8f49 0400      mov	r9, 0x4(r15)
; int nbuckets=2
; for( int i=log2nbuckets; i!=0; --i ) {
;   nbuckets *= 2
479e:  2b43           mov	#0x2, r11
47a0:  0f47           mov	r7, r15
47a2:  0f93           tst	r15
47a4:  0324           jz	#0x47ac <create_hash_table+0x34>
47a6:  0b5b           add	r11, r11
47a8:  1f83           dec	r15
47aa:  fd23           jnz	#0x47a6 <create_hash_table+0x2e>
; }
; ptable->pbuckets = malloc( nbuckets * sizeof(int) )
47ac:  0f4b           mov	r11, r15
47ae:  b012 7846      call	#0x4678 <malloc>
47b2:  8a4f 0600      mov	r15, 0x6(r10)
; ptable->pentriesperbucket = malloc( nbuckets * sizeof(entry_t*) )
47b6:  0f4b           mov	r11, r15
47b8:  b012 7846      call	#0x4678 <malloc>
47bc:  8a4f 0800      mov	r15, 0x8(r10)
; int nbuckets = 1
; for( int i=log2nbuckets; i > 0; --i ) {
;   nbuckets *= 2
47c0:  1843           mov	#0x1, r8
47c2:  0793           tst	r7
47c4:  0324           jz	#0x47cc <create_hash_table+0x54>
47c6:  0858           add	r8, r8
47c8:  1783           dec	r7
47ca:  fd23           jnz	#0x47c6 <create_hash_table+0x4e>
; }
; int r11 = maxentriesperbucket * sizeof(entry_t)
47cc:  0b49           mov	r9, r11
47ce:  0b5b           add	r11, r11
47d0:  0b5b           add	r11, r11
47d2:  0b5b           add	r11, r11
47d4:  0b59           add	r9, r11
47d6:  0b5b           add	r11, r11
; for( int i<r9>=0; i<nbuckets; ++i ) {
47d8:  0943           clr	r9
47da:  0f3c           jmp	#0x47fa <create_hash_table+0x82>
;   ptable->pbuckets[i] = malloc( ptable->maxentriesperbucket * sizeof(entry_t) )
47dc:  0749           mov	r9, r7
47de:  0757           add	r7, r7
47e0:  164a 0600      mov	0x6(r10), r6
47e4:  0657           add	r7, r6
47e6:  0f4b           mov	r11, r15
47e8:  b012 7846      call	#0x4678 <malloc>
47ec:  864f 0000      mov	r15, 0x0(r6)
;   ptable->pnumentriesperbucket[i] = 0
47f0:  175a 0800      add	0x8(r10), r7
47f4:  8743 0000      clr	0x0(r7)
;  // end loop:   i<nbuckets; ++i
47f8:  1953           inc	r9
47fa:  0998           cmp	r8, r9
47fc:  ef3b           jl	#0x47dc <create_hash_table+0x64>
; }
; return ptable
47fe:  0f4a           mov	r10, r15
4800:  3641           pop	r6
4802:  3741           pop	r7
4804:  3841           pop	r8
4806:  3941           pop	r9
4808:  3a41           pop	r10
480a:  3b41           pop	r11
480c:  3041           ret


; int hash(char* s) {
480e <hash>
480e:  0e4f           mov	r15, r14
;   int hash<r15> = 0
4810:  0f43           clr	r15
;   for( char* pc=s; *pc; ++pc ) {
4812:  0b3c           jmp	#0x482a <hash+0x1c>
;       int c<r13> = *pc
4814:  6d4e           mov.b	@r14, r13
4816:  8d11           sxt	r13
;       c += hash
;       hash = c
4818:  0d5f           add	r15, r13
481a:  0f4d           mov	r13, r15
;       hash *= 32
481c:  0f5f           add	r15, r15
481e:  0f5f           add	r15, r15
4820:  0f5f           add	r15, r15
4822:  0f5f           add	r15, r15
4824:  0f5f           add	r15, r15
;       hash -= c
4826:  0f8d           sub	r13, r15
; END FOR...
4828:  1e53           inc	r14
482a:  ce93 0000      tst.b	0x0(r14)
482e:  f223           jnz	#0x4814 <hash+0x6>
;   }
;   return hash
4830:  3041           ret


4832 <add_to_table>
4832:  0b12           push	r11
4834:  0a12           push	r10
4836:  0912           push	r9
4838:  0b4f           mov	r15, r11
483a:  0a4e           mov	r14, r10
483c:  094d           mov	r13, r9
483e:  1e4f 0200      mov	0x2(r15), r14
; int maxentries = ptable->maxentriesperbucket
4842:  1c4f 0400      mov	0x4(r15), r12
; for( int i=ptable->log2nbuckets; i; --i )
4846:  0f4e           mov	r14, r15
4848:  0f93           tst	r15
484a:  0324           jz	#0x4852 <add_to_table+0x20>
; {
;   maxentries *= 2
484c:  0c5c           add	r12, r12
484e:  1f83           dec	r15
4850:  fd23           jnz	#0x484c <add_to_table+0x1a>
; }
; if( ???? maxentries & 0x8000 ) {
4852:  0c93           tst	r12
4854:  0234           jge	#0x485a <add_to_table+0x28>
;   maxentries += 3
4856:  3c50 0300      add	#0x3, r12
; }
; // for bits=3 & entriesperbucket=8, this rehashes after 11,21,41,81,then crashes
; if( ptable->numentries < maxentries/4 ) {
485a:  0c11           rra	r12
485c:  0c11           rra	r12
485e:  2c9b           cmp	@r11, r12
4860:  0434           jge	#0x486a <add_to_table+0x38>
;   log2nbuckets++
4862:  1e53           inc	r14
;   rehash( ptable, log2nbuckets )
4864:  0f4b           mov	r11, r15
4866:  b012 d448      call	#0x48d4 <rehash>
; }
;
; ptable->nentries++
486a:  9b53 0000      inc	0x0(r11)
; int hash<r15> = hash( user )
486e:  0f4a           mov	r10, r15
4870:  b012 0e48      call	#0x480e <hash>
; int bucketmask<r12> = 1
; for( int i=ptable->nbuckets; i; --i ) {
4874:  1c43           mov	#0x1, r12
4876:  1e4b 0200      mov	0x2(r11), r14
487a:  0e93           tst	r14
487c:  0324           jz	#0x4884 <add_to_table+0x52>
;   bucketmask *= 2
487e:  0c5c           add	r12, r12
4880:  1e83           dec	r14
4882:  fd23           jnz	#0x487e <add_to_table+0x4c>
; }
; bucketmask--
4884:  3c53           add	#-0x1, r12
; int bucket = hash & bucketmask
4886:  0cff           and	r15, r12
4888:  0c5c           add	r12, r12
488a:  1f4b 0800      mov	0x8(r11), r15
488e:  0f5c           add	r12, r15
; int entriesinbucket<r14> = ptable->pentriesperbucket[hash]
4890:  2e4f           mov	@r15, r14
4892:  1b4b 0600      mov	0x6(r11), r11
4896:  0b5c           add	r12, r11
4898:  0c4e           mov	r14, r12
489a:  0c5c           add	r12, r12
489c:  0c5c           add	r12, r12
489e:  0c5c           add	r12, r12
48a0:  0c5e           add	r14, r12
48a2:  0c5c           add	r12, r12
48a4:  2c5b           add	@r11, r12
48a6:  1e53           inc	r14
48a8:  8f4e 0000      mov	r14, 0x0(r15)
48ac:  0f43           clr	r15
48ae:  093c           jmp	#0x48c2 <add_to_table+0x90>
48b0:  0b4c           mov	r12, r11
48b2:  0b5f           add	r15, r11
48b4:  cb4e 0000      mov.b	r14, 0x0(r11)
48b8:  1f53           inc	r15
48ba:  3f90 0f00      cmp	#0xf, r15
48be:  0424           jeq	#0x48c8 <add_to_table+0x96>
48c0:  1a53           inc	r10
48c2:  6e4a           mov.b	@r10, r14
48c4:  4e93           tst.b	r14
48c6:  f423           jnz	#0x48b0 <add_to_table+0x7e>
48c8:  8c49 1000      mov	r9, 0x10(r12)
48cc:  3941           pop	r9
48ce:  3a41           pop	r10
48d0:  3b41           pop	r11
48d2:  3041           ret


; void rehash( table_t* ptable_in, int new_log2nbuckets ) {
48d4 <rehash>
48d4:  0b12           push	r11
48d6:  0a12           push	r10
48d8:  0912           push	r9
48da:  0812           push	r8
48dc:  0712           push	r7
48de:  0612           push	r6
48e0:  0512           push	r5
48e2:  0412           push	r4
48e4:  2183           decd	sp
;   table_t* ptable<r11> = ptable_in
48e6:  0b4f           mov	r15, r11
;   int old_log2nbuckets<r6> = ptable->log2nbuckets
48e8:  164f 0200      mov	0x2(r15), r6
;   entry_t** old_pbuckets<r5> = ptable->pbuckets
48ec:  154f 0600      mov	0x6(r15), r5
;   int* old_pentriesperbucket = ptable->pentriesperbucket
48f0:  144f 0800      mov	0x8(r15), r4
;   ptable->log2nbuckets = new_log2nbuckets
48f4:  8f4e 0200      mov	r14, 0x2(r15)
;   ptable->numentries = 0
48f8:  8f43 0000      clr	0x0(r15)
;   int arraysize<r10> = 2
48fc:  2a43           mov	#0x2, r10
;   for( int i=new_log2nbuckets; i!=0; --i) {
48fe:  0e93           tst	r14
4900:  0324           jz	#0x4908 <rehash+0x34>
;       arraysize *= 2
4902:  0a5a           add	r10, r10
4904:  1e83           dec	r14
4906:  fd23           jnz	#0x4902 <rehash+0x2e>
;   }
;
;   ptable->pbuckets = malloc( arraysize )
4908:  0f4a           mov	r10, r15
490a:  b012 7846      call	#0x4678 <malloc>
490e:  8b4f 0600      mov	r15, 0x6(r11)
;   ptable->pentriesperbucket = malloc( arraysize )
4912:  0f4a           mov	r10, r15
4914:  b012 7846      call	#0x4678 <malloc>
4918:  8b4f 0800      mov	r15, 0x8(r11)
;   for( int i<r10>=0; i<EXP2(ptable->log2nbuckets; ++i ) {
491c:  0a43           clr	r10
491e:  1843           mov	#0x1, r8
4920:  173c           jmp	#0x4950 <rehash+0x7c>
;       int* pentryoffset<r7> = (i*2) + (char*)ptable->pbuckets
4922:  094a           mov	r10, r9
4924:  0959           add	r9, r9
4926:  174b 0600      mov	0x6(r11), r7
492a:  0759           add	r9, r7
;       int bytesperbucket = ptable->maxentriesperbucket * 18
492c:  1f4b 0400      mov	0x4(r11), r15
4930:  0e4f           mov	r15, r14
4932:  0e5e           add	r14, r14
4934:  0e5e           add	r14, r14
4936:  0e5e           add	r14, r14
4938:  0e5f           add	r15, r14
493a:  0f4e           mov	r14, r15
493c:  0f5f           add	r15, r15
;       ptable->pbuckets[i] = malloc(bytesperbucket)
493e:  b012 7846      call	#0x4678 <malloc>
4942:  874f 0000      mov	r15, 0x0(r7)
;       ptable->pentriesperbucket[i] = 0
4946:  195b 0800      add	0x8(r11), r9
494a:  8943 0000      clr	0x0(r9)
494e:  1a53           inc	r10
;       <FOR LOOP EPILOGUE>
4950:  1d4b 0200      mov	0x2(r11), r13
4954:  0e48           mov	r8, r14
4956:  0d93           tst	r13
4958:  0324           jz	#0x4960 <rehash+0x8c>
495a:  0e5e           add	r14, r14
495c:  1d83           dec	r13
495e:  fd23           jnz	#0x495a <rehash+0x86>
4960:  0a9e           cmp	r14, r10
4962:  df3b           jl	#0x4922 <rehash+0x4e>
4964:  0f46           mov	r6, r15
4966:  1e43           mov	#0x1, r14
4968:  0f93           tst	r15
496a:  0324           jz	#0x4972 <rehash+0x9e>
496c:  0e5e           add	r14, r14
496e:  1f83           dec	r15
4970:  fd23           jnz	#0x496c <rehash+0x98>
4972:  814e 0000      mov	r14, 0x0(sp)
4976:  0a45           mov	r5, r10
4978:  0944           mov	r4, r9
497a:  0743           clr	r7
497c:  153c           jmp	#0x49a8 <rehash+0xd4>
497e:  2e4a           mov	@r10, r14
4980:  0e58           add	r8, r14
4982:  1d4e 1000      mov	0x10(r14), r13
4986:  0f4b           mov	r11, r15
4988:  b012 3248      call	#0x4832 <add_to_table>
498c:  1653           inc	r6
498e:  3850 1200      add	#0x12, r8
4992:  023c           jmp	#0x4998 <rehash+0xc4>
4994:  0843           clr	r8
4996:  0648           mov	r8, r6
4998:  2699           cmp	@r9, r6
499a:  f13b           jl	#0x497e <rehash+0xaa>
499c:  2f4a           mov	@r10, r15
499e:  b012 1c47      call	#0x471c <free>
49a2:  1753           inc	r7
49a4:  2a53           incd	r10
49a6:  2953           incd	r9
49a8:  2791           cmp	@sp, r7
49aa:  f43b           jl	#0x4994 <rehash+0xc0>
49ac:  0f44           mov	r4, r15
49ae:  b012 1c47      call	#0x471c <free>
49b2:  0f45           mov	r5, r15
49b4:  b012 1c47      call	#0x471c <free>
49b8:  2153           incd	sp
49ba:  3441           pop	r4
49bc:  3541           pop	r5
49be:  3641           pop	r6
49c0:  3741           pop	r7
49c2:  3841           pop	r8
49c4:  3941           pop	r9
49c6:  3a41           pop	r10
49c8:  3b41           pop	r11
49ca:  3041           ret


49cc <get_from_table>
49cc:  0b12           push	r11
49ce:  0a12           push	r10
49d0:  0912           push	r9
49d2:  0812           push	r8
49d4:  0712           push	r7
49d6:  0612           push	r6
49d8:  0a4f           mov	r15, r10
49da:  064e           mov	r14, r6
49dc:  0f4e           mov	r14, r15
49de:  b012 0e48      call	#0x480e <hash>
49e2:  1b43           mov	#0x1, r11
49e4:  1d4a 0200      mov	0x2(r10), r13
49e8:  0d93           tst	r13
49ea:  0324           jz	#0x49f2 <get_from_table+0x26>
49ec:  0b5b           add	r11, r11
49ee:  1d83           dec	r13
49f0:  fd23           jnz	#0x49ec <get_from_table+0x20>
49f2:  3b53           add	#-0x1, r11
49f4:  0bff           and	r15, r11
49f6:  0b5b           add	r11, r11
49f8:  1d4a 0600      mov	0x6(r10), r13
49fc:  0d5b           add	r11, r13
49fe:  294d           mov	@r13, r9
4a00:  0843           clr	r8
4a02:  0d3c           jmp	#0x4a1e <get_from_table+0x52>
4a04:  0749           mov	r9, r7
4a06:  0e49           mov	r9, r14
4a08:  0f46           mov	r6, r15
4a0a:  b012 7c4d      call	#0x4d7c <strcmp>
4a0e:  3950 1200      add	#0x12, r9
4a12:  0f93           tst	r15
4a14:  0320           jnz	#0x4a1c <get_from_table+0x50>
4a16:  1f47 1000      mov	0x10(r7), r15
4a1a:  073c           jmp	#0x4a2a <get_from_table+0x5e>
4a1c:  1853           inc	r8
4a1e:  1f4a 0800      mov	0x8(r10), r15
4a22:  0f5b           add	r11, r15
4a24:  289f           cmp	@r15, r8
4a26:  ee3b           jl	#0x4a04 <get_from_table+0x38>
4a28:  3f43           mov	#-0x1, r15
4a2a:  3641           pop	r6
4a2c:  3741           pop	r7
4a2e:  3841           pop	r8
4a30:  3941           pop	r9
4a32:  3a41           pop	r10
4a34:  3b41           pop	r11
4a36:  3041           ret


4a38: "Welcome to the lock controller."
4a58: "You can open the door by entering 'access [your name] [pin]'"
4a95: ""
4a96: "No such box."
4aa3: "Access granted."
4ab3: "Access granted; but account not activated."
4ade: "Aceess denied"
4aec: "Can not have a pin with high bit set."
4b12: "User already has an account."
4b2f: "Adding user account %s with pin %x.\n"
4b54: "Invalid command."

; VECTORS:
;   - no bounds checking on num entries per bucket
;       - bucket allocations are 90 bytes
; 
; .plan:
;   - add key user into bucket 1
;   - add 7 users into bucket 0, overwriting pin of key user
;       - user is 18B
;       - offs of pin of key user is 96+16=112 bytes from start of bucket 0
;       - so bytes 4&5 of user 7 in bucket 0 overlap pin of user 0 in bucket 1
;       - also, bytes 6-15 of username 6 are now the name of key user - and need to match hash for bucket 1
;   - login as key user
;  grah, successful login doesn't open the door T_T
;
; new .plan:
;   - use heap corruption trick to change instr at 4ce6 to jump forward to 4cf4
;       4ce6:  6b23           jnz	#0x4bbe <run+0x58>
;               6b23 => 236b => 00100011 01101011
;                               ^----^              jnz
;                                        36b => 11 0110 1011 => 1110 1101 0110 => -0x128
;       new instr:            jnz   +0x6
;                               00100000 00000110
;                                  => 2006 => 0620
;           ---> need to add 0xfc9b to @0x4ce6
;   - end input with 0x7f
;     => validated that if next char is 0x7f and @4ce6 is 0x2006, the door unlocks!
;
;  NONONONONONONONONONONONO
;   6b23 has bottom bit set, so the chunk won't be considered free
;  
;  BUT! 4bc2 also has next char in r15, and ends with a 0
;   4bc2:  3a20           jne	#0x4c38 <run+0xd2>
;               3a20 => 203a => 00100000 00111010
;            
;       new instr:          jnz +0x132
;                             00100001 00110010  => 2132   
;
;      -=-=-=-> need to add 0xf8 to @4bc2
;                - so pPrevChunk must be be4b (LE)
;                - pNextChunk can be whatevs - ideally pointing at something 5 bytes before an odd number
;                - info needs to be 0xf8-6 => f200 (LE)
;
;       ==> ending with a \0 means that processing will stop, so we need two strings. 
;               maybe switch to a jmp? 
;                            jmp +0x130
;                              00111100 10011010 => 3c9a BE => 9a3c
;
;            ***   info needs to be 0x1c60 - 6 | 1 = 1c5b (LE)
;
;      username6 must start with be4b0650f811
;
;
;   * * * * * nope, that results in:
;
; 4ba0:   053c 0f41 0f5e cf43 0000 1e53 079e f937   .<.A.^.C...S...7
; 4bb0:   3e40 5005 0f41 b012 404d 0b41 923c 7f90   >@P..A..@M.A.<.
; 4bc0:   c250 8020 0e4b 3e50 0700 0b4e 073c 7f90   .P. .K>P...N.<.
;         ^^^^^^^^^--- changed from 
;         6100 3a20
;
;
;
;    
;   HEAP TRICK: 
;       if prev chunk free: 
;           pChunk->pPrevChunk->info += pChunk->info + 6
;   
;   so to change addr 4ce6, we set pChunk->pPrevChunk to 4ce2
;       cmd is [new X Y;]*\x7f however many times causes realloc
;       before realloc, need to have overwritten end of a middle bucket, so we get a predictable free()
;       -> because we only overwrite prevChunk, the heap will still work, aside from being leaky once


; 'new 123 123' adds a new user, but they aren't activated yet
; .plan:
;   - 
;   NB: don't forget that walk() dumps the heap
;
; ------------------------------------
; > new 123 123
; > new molen 3124
; > walk(5000)
; @5000 [alloc] [p 5000] [n 5010] [s 000a]
;  {5006} [ 0002 0003 0005 5016 502c ]
; @5010 [alloc] [p 5000] [n 5026] [s 0010]
;  {5016} [ 5042 50a2 5102 5162 51c2 5222 5282 52e2 ]
; @5026 [alloc] [p 5010] [n 503c] [s 0010]
;  {502c} [ 0000 0000 0000 0000 0000 0001 0001 0000 ]
; @503c [alloc] [p 5026] [n 509c] [s 005a]
;  {5042} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @509c [alloc] [p 503c] [n 50fc] [s 005a]
;  {50a2} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @50fc [alloc] [p 509c] [n 515c] [s 005a]
;  {5102} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @515c [alloc] [p 50fc] [n 51bc] [s 005a]
;  {5162} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @51bc [alloc] [p 515c] [n 521c] [s 005a]
;  {51c2} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @521c [alloc] [p 51bc] [n 527c] [s 005a]
;  {5222} [ 6f6d 656c 006e 0000 0000 0000 0000 0000 090a 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @527c [alloc] [p 521c] [n 52dc] [s 005a]
;  {5282} [ 3231 0033 0000 0000 0000 0000 0000 0000 007b 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @52dc [alloc] [p 527c] [n 533c] [s 005a]
;  {52e2} [ 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ]
; @533c [freed] [p 52dc] [n 5000] [s 7cbe]
;
;
4b66 <run>
4b66:  0b12           push	r11
4b68:  0a12           push	r10
4b6a:  0912           push	r9
4b6c:  0812           push	r8
4b6e:  0712           push	r7
4b70:  3150 00fa      add	#0xfa00, sp     ; colossal stack - nonstarter
; table* ptable<r8> = create_hash_table(3,5)
4b74:  3e40 0500      mov	#0x5, r14
4b78:  3f40 0300      mov	#0x3, r15
4b7c:  b012 7847      call	#0x4778 <create_hash_table>
4b80:  084f           mov	r15, r8
; puts( "Welcome to the lock controller." )
4b82:  3f40 384a      mov	#0x4a38 "Welcome to the lock controller.", r15
4b86:  b012 504d      call	#0x4d50 <puts>
; puts( "You can open the door by entering 'access [your name] [pin]'" )
4b8a:  3f40 584a      mov	#0x4a58 "You can open the door by entering 'access [your name] [pin]'", r15
4b8e:  b012 504d      call	#0x4d50 <puts>
; puts( "" )
4b92:  3f40 954a      mov	#0x4a95 "", r15
4b96:  b012 504d      call	#0x4d50 <puts>
; const BUFZISE = 0x5ff
; char buf[BUFSIZE]
; int i<r14> = 0;
4b9a:  0e43           clr	r14
4b9c:  3740 ff05      mov	#0x5ff, r7
; do {
;   for( int i<r14> = 0; i!=BUFSIZE; ++i) {
4ba0:  053c           jmp	#0x4bac <run+0x46>
;       buf[i] = 0
4ba2:  0f41           mov	sp, r15
4ba4:  0f5e           add	r14, r15
4ba6:  cf43 0000      mov.b	#0x0, 0x0(r15)
4baa:  1e53           inc	r14
4bac:  079e           cmp	r14, r7
4bae:  f937           jge	#0x4ba2 <run+0x3c>
;   }
;
;   getsn( buf, 0x550 )
4bb0:  3e40 5005      mov	#0x550, r14
4bb4:  0f41           mov	sp, r15
4bb6:  b012 404d      call	#0x4d40 <getsn>
;   char* pc<r11> = buf
4bba:  0b41           mov	sp, r11
4bbc:  923c           jmp	#0x4ce2 <run+0x17c>
; ----->>
;   c = *pc
> 4ce2:  6f4b           mov.b	@r11, r15
;   if( !c ) {
> 4ce4:  4f93           tst.b	r15
> 4ce6:  6b23           jnz	#0x4bbe <run+0x58>
;       // re-zero memory and read next input
;       i = 0
;       continue
> 4ce8:  0e43           clr	r14
> 4cea:  603f           jmp	#0x4bac <run+0x46>
;   }
;
;   if( c == 'a' ) {
4bbe:  7f90 6100      cmp.b	#0x61, r15
4bc2:  3a20           jne	#0x4c38 <run+0xd2>
;       pc += 7     // "a??????"
4bc4:  0e4b           mov	r11, r14
4bc6:  3e50 0700      add	#0x7, r14
4bca:  0b4e           mov	r14, r11
;       char* pusername = pc
4bcc:  073c           jmp	#0x4bdc <run+0x76>
;       // find end of name and null terminate it
;       for( char c = *pc; c; pc++, c=*pc) {
;           if( c == ' ' ) {
4bce:  7f90 2000      cmp.b	#0x20, r15
4bd2:  0320           jne	#0x4bda <run+0x74>
;               *pc = 0
4bd4:  cb43 0000      mov.b	#0x0, 0x0(r11)
4bd8:  043c           jmp	#0x4be2 <run+0x7c>
;           }
;       <for loop epilogue>
4bda:  1b53           inc	r11
4bdc:  6f4b           mov.b	@r11, r15
4bde:  4f93           tst.b	r15
4be0:  f623           jnz	#0x4bce <run+0x68>
;       }
;       pc++
;       char* ppin<r11> = pc
4be2:  1b53           inc	r11
;
;       int pin<r10> = 0
4be4:  0a43           clr	r10
;       for(char c=*pc; c && c!=';'; pc++) {
4be6:  0b3c           jmp	#0x4bfe <run+0x98>
;           // atoi for pin
;  --> NOTE: pin tested is the lowest 5 significant digits. as long as bit16 is clear, pin can be any length
;           pin = (*pc - 0x30) + (pin * 10)
4be8:  0d4a           mov	r10, r13
4bea:  0d5d           add	r13, r13
4bec:  0d5d           add	r13, r13
4bee:  0d5a           add	r10, r13
4bf0:  0d5d           add	r13, r13
4bf2:  6a4b           mov.b	@r11, r10
4bf4:  8a11           sxt	r10
4bf6:  3a50 d0ff      add	#0xffd0, r10
4bfa:  0a5d           add	r13, r10
;
;      <for loop epilogue>
4bfc:  1b53           inc	r11
4bfe:  6f4b           mov.b	@r11, r15
4c00:  4f93           tst.b	r15
4c02:  0324           jz	#0x4c0a <run+0xa4>
4c04:  7f90 3b00      cmp.b	#0x3b, r15
4c08:  ef23           jne	#0x4be8 <run+0x82>
;       }
;
;       if( stored_pin = get_from_table( table, pusername ) == -1 ) {
4c0a:  0f48           mov	r8, r15
4c0c:  b012 cc49      call	#0x49cc <get_from_table>
4c10:  3f93           cmp	#-0x1, r15
4c12:  0320           jne	#0x4c1a <run+0xb4>
;           message = "No such box"
;           break
4c14:  3f40 964a      mov	#0x4a96 "No such box.", r15
4c18:  413c           jmp	#0x4c9c <run+0x136>
;       }
;                   else {
;                       if( ((stored_pin ^ pin) & 0x7fff) == 0 ) {
4c1a:  0aef           xor	r15, r10
4c1c:  3af0 ff7f      and	#0x7fff, r10
4c20:  0820           jnz	#0x4c32 <run+0xcc>
;                           if( stored_pin < (stored_pin & 0x7fff) ) { // i.e. top bit is set in stored pin
4c22:  0f9a           cmp	r10, r15
4c24:  0334           jge	#0x4c2c <run+0xc6>
;                               message = "Access granted."
4c26:  3f40 a34a      mov	#0x4aa3 "Access granted.", r15
4c2a:  383c           jmp	#0x4c9c <run+0x136>
;                           }
;                           else {
;                               message = "Access granted; but account not activated."
4c2c:  3f40 b34a      mov	#0x4ab3 "Access granted; but account not activated.", r15
4c30:  353c           jmp	#0x4c9c <run+0x136>
;                           }
;                       }
;                       else {   // ((stored_pin ^ pin) & 0x7fff) != 0 )
;                           // if stored pin is different from pin (in bottom 15 bits - which are the only ones)
;                           message = "Aceess denied"
4c32:  3f40 de4a      mov	#0x4ade "Aceess denied", r15
4c36:  323c           jmp	#0x4c9c <run+0x136>
;                       }
;                   }
;       else if( c == 'n' ) {
;           pc += 4
4c38:  7f90 6e00      cmp.b	#0x6e, r15
4c3c:  4020           jne	#0x4cbe <run+0x158>
4c3e:  094b           mov	r11, r9
4c40:  2952           add	#0x4, r9
4c42:  0b49           mov	r9, r11
4c44:  073c           jmp	#0x4c54 <run+0xee>
;
4c46:  7f90 2000      cmp.b	#0x20, r15
4c4a:  0320           jne	#0x4c52 <run+0xec>
4c4c:  cb43 0000      mov.b	#0x0, 0x0(r11)
4c50:  043c           jmp	#0x4c5a <run+0xf4>
4c52:  1b53           inc	r11
4c54:  6f4b           mov.b	@r11, r15
4c56:  4f93           tst.b	r15
4c58:  f623           jnz	#0x4c46 <run+0xe0>
4c5a:  1b53           inc	r11
;   // atoi for pin
4c5c:  0a43           clr	r10
4c5e:  0b3c           jmp	#0x4c76 <run+0x110>
4c60:  0c4a           mov	r10, r12
4c62:  0c5c           add	r12, r12
4c64:  0c5c           add	r12, r12
4c66:  0c5a           add	r10, r12
4c68:  0c5c           add	r12, r12
4c6a:  6a4b           mov.b	@r11, r10
4c6c:  8a11           sxt	r10
4c6e:  3a50 d0ff      add	#0xffd0, r10
4c72:  0a5c           add	r12, r10
4c74:  1b53           inc	r11
4c76:  6f4b           mov.b	@r11, r15
4c78:  4f93           tst.b	r15
4c7a:  0324           jz	#0x4c82 <run+0x11c>
4c7c:  7f90 3b00      cmp.b	#0x3b, r15
4c80:  ef23           jne	#0x4c60 <run+0xfa>
4c82:  0a93           tst	r10
4c84:  0334           jge	#0x4c8c <run+0x126>
4c86:  3f40 ec4a      mov	#0x4aec "Can not have a pin with high bit set.", r15
4c8a:  083c           jmp	#0x4c9c <run+0x136>
4c8c:  0e49           mov	r9, r14
4c8e:  0f48           mov	r8, r15
4c90:  b012 cc49      call	#0x49cc <get_from_table>
4c94:  3f93           cmp	#-0x1, r15
4c96:  0524           jeq	#0x4ca2 <run+0x13c>
4c98:  3f40 124b      mov	#0x4b12 "User already has an account.", r15
4c9c:  b012 504d      call	#0x4d50 <puts>
4ca0:  1c3c           jmp	#0x4cda <run+0x174>
4ca2:  0a12           push	r10
4ca4:  0912           push	r9
4ca6:  3012 2f4b      push	#0x4b2f "Adding user account %s with pin %x.\n"
4caa:  b012 4844      call	#0x4448 <printf>
4cae:  3150 0600      add	#0x6, sp
4cb2:  0d4a           mov	r10, r13
4cb4:  0e49           mov	r9, r14
4cb6:  0f48           mov	r8, r15
4cb8:  b012 3248      call	#0x4832 <add_to_table>
4cbc:  0e3c           jmp	#0x4cda <run+0x174>
4cbe:  3f40 544b      mov	#0x4b54 "Invalid command.", r15
4cc2:  b012 504d      call	#0x4d50 <puts>
4cc6:  1f43           mov	#0x1, r15
4cc8:  3150 0006      add	#0x600, sp
4ccc:  3741           pop	r7
4cce:  3841           pop	r8
4cd0:  3941           pop	r9
4cd2:  3a41           pop	r10
4cd4:  3b41           pop	r11
4cd6:  3041           ret
;
;   while( *i == ';' ) { ++i; }
4cd8:  1b53           inc	r11
4cda:  fb90 3b00 0000 cmp.b	#0x3b, 0x0(r11)
4ce0:  fb27           jeq	#0x4cd8 <run+0x172>
;   c = *pc
4ce2:  6f4b           mov.b	@r11, r15
4ce4:  4f93           tst.b	r15
4ce6:  6b23           jnz	#0x4bbe <run+0x58>
;   i = 0
;   continue
4ce8:  0e43           clr	r14
4cea:  603f           jmp	#0x4bac <run+0x46>
; }



4cec <INT>
4cec:  1e41 0200      mov	0x2(sp), r14
4cf0:  0212           push	sr
4cf2:  0f4e           mov	r14, r15
4cf4:  8f10           swpb	r15
4cf6:  024f           mov	r15, sr
4cf8:  32d0 0080      bis	#0x8000, sr
4cfc:  b012 1000      call	#0x10
4d00:  3241           pop	sr
4d02:  3041           ret

4d04 <putchar>
4d04:  2183           decd	sp
4d06:  0f12           push	r15
4d08:  0312           push	#0x0
4d0a:  814f 0400      mov	r15, 0x4(sp)
4d0e:  b012 ec4c      call	#0x4cec <INT>
4d12:  1f41 0400      mov	0x4(sp), r15
4d16:  3150 0600      add	#0x6, sp
4d1a:  3041           ret

4d1c <getchar>
4d1c:  0412           push	r4
4d1e:  0441           mov	sp, r4
4d20:  2453           incd	r4
4d22:  2183           decd	sp
4d24:  3f40 fcff      mov	#0xfffc, r15
4d28:  0f54           add	r4, r15
4d2a:  0f12           push	r15
4d2c:  1312           push	#0x1
4d2e:  b012 ec4c      call	#0x4cec <INT>
4d32:  5f44 fcff      mov.b	-0x4(r4), r15
4d36:  8f11           sxt	r15
4d38:  3150 0600      add	#0x6, sp
4d3c:  3441           pop	r4
4d3e:  3041           

4d40 <getsn>
4d40:  0e12           push	r14
4d42:  0f12           push	r15
4d44:  2312           push	#0x2
4d46:  b012 ec4c      call	#0x4cec <INT>
4d4a:  3150 0600      add	#0x6, sp
4d4e:  3041           ret

4d50 <puts>
4d50:  0b12           push	r11
4d52:  0b4f           mov	r15, r11
4d54:  073c           jmp	#0x4d64 <puts+0x14>
4d56:  1b53           inc	r11
4d58:  8f11           sxt	r15
4d5a:  0f12           push	r15
4d5c:  0312           push	#0x0
4d5e:  b012 ec4c      call	#0x4cec <INT>
4d62:  2152           add	#0x4, sp
4d64:  6f4b           mov.b	@r11, r15
4d66:  4f93           tst.b	r15
4d68:  f623           jnz	#0x4d56 <puts+0x6>
4d6a:  3012 0a00      push	#0xa
4d6e:  0312           push	#0x0
4d70:  b012 ec4c      call	#0x4cec <INT>
4d74:  2152           add	#0x4, sp
4d76:  0f43           clr	r15
4d78:  3b41           pop	r11
4d7a:  3041           ret


4d7c <strcmp>
4d7c:  033c           jmp	#0x4d84 <strcmp+0x8>
4d7e:  4d93           tst.b	r13
4d80:  0b24           jz	#0x4d98 <strcmp+0x1c>
4d82:  1f53           inc	r15
4d84:  6d4f           mov.b	@r15, r13
4d86:  6c4e           mov.b	@r14, r12
4d88:  1e53           inc	r14
4d8a:  4d9c           cmp.b	r12, r13
4d8c:  f827           jeq	#0x4d7e <strcmp+0x2>
4d8e:  4f4d           mov.b	r13, r15
4d90:  5e4e ffff      mov.b	-0x1(r14), r14
4d94:  0f8e           sub	r14, r15
4d96:  3041           ret
4d98:  0f43           clr	r15
4d9a:  3041           ret

4d9c <_unexpected_>
4d9c:  0013           reti	pc