
0010 <__trap_interrupt>
0010:  3041           ret
4400 <__init_stack>
4400:  3140 0044      mov	#0x4400, sp
4404 <__low_level_init>
4404:  1542 5c01      mov	&0x015c, r5
4408:  75f3           and.b	#-0x1, r5
440a:  35d0 085a      bis	#0x5a08, r5
440e <__do_copy_data>
440e:  3f40 0000      clr	r15
4412:  0f93           tst	r15
4414:  0724           jz	#0x4424 <__do_clear_bss+0x0>
4416:  8245 5c01      mov	r5, &0x015c
441a:  2f83           decd	r15
441c:  9f4f 704a 0024 mov	0x4a70(r15), 0x2400(r15)
4422:  f923           jnz	#0x4416 <__do_copy_data+0x8>
4424 <__do_clear_bss>
4424:  3f40 3200      mov	#0x32, r15
4428:  0f93           tst	r15
442a:  0624           jz	#0x4438 <main+0x0>
442c:  8245 5c01      mov	r5, &0x015c
4430:  1f83           dec	r15
4432:  cf43 0024      mov.b	#0x0, 0x2400(r15)
4436:  fa23           jnz	#0x442c <__do_clear_bss+0x8>


4438 <main>
4438:  b012 1c4a      call	#0x4a1c <rand>
443c:  0b4f           mov	r15, r11
443e:  3bf0 fe7f      and	#0x7ffe, r11
4442:  3b50 0060      add	#0x6000, r11
4446:  b012 1c4a      call	#0x4a1c <rand>
444a:  0a4f           mov	r15, r10
444c:  3012 0010      push	#0x1000
4450:  3012 0044      push	#0x4400 <__init_stack>
4454:  0b12           push	r11
4456:  b012 e849      call	#0x49e8 <_memcpy>
445a:  3150 0600      add	#0x6, sp
445e:  0f4a           mov	r10, r15
4460:  3ff0 fe0f      and	#0xffe, r15
4464:  0e4b           mov	r11, r14
4466:  0e8f           sub	r15, r14
4468:  3e50 00ff      add	#0xff00, r14
446c:  0d4b           mov	r11, r13
446e:  3d50 5c03      add	#0x35c, r13
4472:  014e           mov	r14, sp
4474:  0f4b           mov	r11, r15
4476:  8d12           call	r13
4478 <__stop_progExec__>
4478:  32d0 f000      bis	#0xf0, sr
447c:  fd3f           jmp	#0x4478 <__stop_progExec__+0x0>
447e <__ctors_end>
447e:  3040 6e4a      br	#0x4a6e <_unexpected_>



; SETUP to skip asr
; #define reboot reset; b 4454; c; let r11=4400; let 449c=0001; c

; VECTORS:
;   - username is printfd
;       - if form is ..%x.... it prints the addr of printf, = code_offs + 0x376
;   - pwd has buffer 8 allocated, reads 20
;       - some return addr read from b8

; username: %x%x!8%n
; pre-printf:
;3710:   0000 0000 0000 0000 da45 0000 ca45 0200   .........E...E..
;3720:   2624 2624 0000 6a47 0000 0000 cc7b 0044   &$&$..jG.....{.D
;3730:   6447 7844 0000 0000 0000 0000 0000 0000   dGxD............
; post-printf
;36f0:   0000 0000 0000 0000 0000 0000 0048 0100   .............H..
;3700:   f047 0000 3800 0000 0000 6a47 0000 0000   .G..8.....jG....
;3710:   1037 0000 0000 0000 0000 0000>0800<2624   .7............&$
;3720:   e645 2624 0000 6a47 0000 0000 cc7b 0044   .E&$..jG.....{.D
;3730:   6447 7844 0000 0000 0000 0000 0000 0000   dGxD............

# 8bytes to unlock door:
#             vvvv---- lendian (_INT = printf_addr + 0x18a)
#                 vvvv---- lendian (printf_addr - 8)
# 3f407f00b012iiiipppp
# 3f407f00b012
#   nb: need a bunch of NOPs in there in case previous instr is 2- or 3-byte
#  034303433f407f00c0bb03430343b01252bd

; 4762:  8e12           call	r14

; .plan
;   - use username %x to find printf addr
;   - first 8 bytes of pwd is unlock code
;   - next 2 bytes is remapped address of 4762 (printf_addr - 8)
; => insn address unaligned T_T

; void aslr_main( void* base = 0x4400 ) {
4482 <_aslr_main>
4482:  0b12           push	r11
4484:  0a12           push	r10
4486:  3182           sub	#0x8, sp
4488:  0c4f           mov	r15, r12
448a:  3c50 6a03      add	#0x36a, r12
448e:  814c 0200      mov	r12, 0x2(sp)
; memset( 0x4400, 0x1000, 0 )
4492:  0e43           clr	r14
4494:  ce43 0044      mov.b	#0x0, 0x4400(r14)
4498:  1e53           inc	r14
449a:  3e90 0010      cmp	#0x1000, r14
449e:  fa23           jne	#0x4494 <_aslr_main+0x12>
;
; strcpy( 0x2402, "Username (8 char max):" )
44a0:  f240 5500 0224 mov.b	#0x55, &0x2402
44a6:  f240 7300 0324 mov.b	#0x73, &0x2403
44ac:  f240 6500 0424 mov.b	#0x65, &0x2404
44b2:  f240 7200 0524 mov.b	#0x72, &0x2405
44b8:  f240 6e00 0624 mov.b	#0x6e, &0x2406
44be:  f240 6100 0724 mov.b	#0x61, &0x2407
44c4:  f240 6d00 0824 mov.b	#0x6d, &0x2408
44ca:  f240 6500 0924 mov.b	#0x65, &0x2409
44d0:  f240 2000 0a24 mov.b	#0x20, &0x240a
44d6:  f240 2800 0b24 mov.b	#0x28, &0x240b
44dc:  f240 3800 0c24 mov.b	#0x38, &0x240c
44e2:  f240 2000 0d24 mov.b	#0x20, &0x240d
44e8:  f240 6300 0e24 mov.b	#0x63, &0x240e
44ee:  f240 6800 0f24 mov.b	#0x68, &0x240f
44f4:  f240 6100 1024 mov.b	#0x61, &0x2410
44fa:  f240 7200 1124 mov.b	#0x72, &0x2411
4500:  f240 2000 1224 mov.b	#0x20, &0x2412
4506:  f240 6d00 1324 mov.b	#0x6d, &0x2413
450c:  f240 6100 1424 mov.b	#0x61, &0x2414
4512:  f240 7800 1524 mov.b	#0x78, &0x2415
4518:  f240 2900 1624 mov.b	#0x29, &0x2416
451e:  f240 3a00 1724 mov.b	#0x3a, &0x2417
4524:  c243 1824      mov.b	#0x0, &0x2418
;
; puts( @2402)  // strangely inlined
4528:  b240 1700 0024 mov	#0x17, &0x2400
452e:  3e40 0224      mov	#0x2402, r14
4532:  0b43           clr	r11
4534:  103c           jmp	#0x4556 <_aslr_main+0xd4>
4536:  1e53           inc	r14
4538:  8d11           sxt	r13
453a:  0b12           push	r11
453c:  0d12           push	r13
453e:  0b12           push	r11
4540:  0012           push	pc
4542:  0212           push	sr
4544:  0f4b           mov	r11, r15
4546:  8f10           swpb	r15
4548:  024f           mov	r15, sr
454a:  32d0 0080      bis	#0x8000, sr
454e:  b012 1000      call	#0x10
4552:  3241           pop	sr
4554:  3152           add	#0x8, sp
4556:  6d4e           mov.b	@r14, r13
4558:  4d93           tst.b	r13
455a:  ed23           jnz	#0x4536 <_aslr_main+0xb4>
455c:  0e43           clr	r14
455e:  3d40 0a00      mov	#0xa, r13
4562:  0e12           push	r14
4564:  0d12           push	r13
4566:  0e12           push	r14
4568:  0012           push	pc
456a:  0212           push	sr
456c:  0f4e           mov	r14, r15
456e:  8f10           swpb	r15
4570:  024f           mov	r15, sr
4572:  32d0 0080      bis	#0x8000, sr
4576:  b012 1000      call	#0x10
457a:  3241           pop	sr
457c:  3152           add	#0x8, sp
;
; r13 = 0xa + 0x34   // = 0x3e
457e:  3d50 3400      add	#0x34, r13

4582:  0e12           push	r14
4584:  0d12           push	r13
4586:  0e12           push	r14
4588:  0012           push	pc
458a:  0212           push	sr
458c:  0f4e           mov	r14, r15
458e:  8f10           swpb	r15
4590:  024f           mov	r15, sr
4592:  32d0 0080      bis	#0x8000, sr
4596:  b012 1000      call	#0x10
459a:  3241           pop	sr
459c:  3152           add	#0x8, sp

459e:  0e12           push	r14
45a0:  0d12           push	r13
45a2:  0e12           push	r14
45a4:  0012           push	pc
45a6:  0212           push	sr
45a8:  0f4e           mov	r14, r15
45aa:  8f10           swpb	r15
45ac:  024f           mov	r15, sr
45ae:  32d0 0080      bis	#0x8000, sr
45b2:  b012 1000      call	#0x10
45b6:  3241           pop	sr
45b8:  3152           add	#0x8, sp
; getsn( @2426, 8 )
45ba:  3a42           mov	#0x8, r10
45bc:  3b40 2624      mov	#0x2426, r11
45c0:  2d43           mov	#0x2, r13
45c2:  0a12           push	r10
45c4:  0b12           push	r11
45c6:  0d12           push	r13
45c8:  0012           push	pc
45ca:  0212           push	sr
45cc:  0f4d           mov	r13, r15
45ce:  8f10           swpb	r15
45d0:  024f           mov	r15, sr
45d2:  32d0 0080      bis	#0x8000, sr
45d6:  b012 1000      call	#0x10
45da:  3241           pop	sr
45dc:  3152           add	#0x8, sp
; *(@242e) = '\0'   // null term the 8 char username
45de:  c24e 2e24      mov.b	r14, &0x242e
; printf( pUsername )
45e2:  0b12           push	r11
45e4:  8c12           call	r12
45e6:  2153           incd	sp
; memset(pUsername, 0, 24)
45e8:  0f4b           mov	r11, r15
45ea:  033c           jmp	#0x45f2 <_aslr_main+0x170>
45ec:  cf43 0000      mov.b	#0x0, 0x0(r15)
45f0:  1f53           inc	r15
45f2:  3f90 3224      cmp	#0x2432, r15
45f6:  fa23           jne	#0x45ec <_aslr_main+0x16a>
; strcpy( @2402, "\nPassword:" )
45f8:  f240 0a00 0224 mov.b	#0xa, &0x2402
45fe:  f240 5000 0324 mov.b	#0x50, &0x2403
4604:  f240 6100 0424 mov.b	#0x61, &0x2404
460a:  f240 7300 0524 mov.b	#0x73, &0x2405
4610:  f240 7300 0624 mov.b	#0x73, &0x2406
4616:  f240 7700 0724 mov.b	#0x77, &0x2407
461c:  f240 6f00 0824 mov.b	#0x6f, &0x2408
4622:  f240 7200 0924 mov.b	#0x72, &0x2409
4628:  f240 6400 0a24 mov.b	#0x64, &0x240a
462e:  f240 3a00 0b24 mov.b	#0x3a, &0x240b
4634:  c243 0c24      mov.b	#0x0, &0x240c
; puts( @2402 )
4638:  3e40 0224      mov	#0x2402, r14
463c:  0c43           clr	r12
463e:  103c           jmp	#0x4660 <_aslr_main+0x1de>
4640:  1e53           inc	r14
4642:  8d11           sxt	r13
4644:  0c12           push	r12
4646:  0d12           push	r13
4648:  0c12           push	r12
464a:  0012           push	pc
464c:  0212           push	sr
464e:  0f4c           mov	r12, r15
4650:  8f10           swpb	r15
4652:  024f           mov	r15, sr
4654:  32d0 0080      bis	#0x8000, sr
4658:  b012 1000      call	#0x10
465c:  3241           pop	sr
465e:  3152           add	#0x8, sp
4660:  6d4e           mov.b	@r14, r13
4662:  4d93           tst.b	r13
4664:  ed23           jnz	#0x4640 <_aslr_main+0x1be>
; putch( '\n' )
4666:  0e43           clr	r14
4668:  3d40 0a00      mov	#0xa, r13
466c:  0e12           push	r14
466e:  0d12           push	r13
4670:  0e12           push	r14
4672:  0012           push	pc
4674:  0212           push	sr
4676:  0f4e           mov	r14, r15
4678:  8f10           swpb	r15
467a:  024f           mov	r15, sr
467c:  32d0 0080      bis	#0x8000, sr
4680:  b012 1000      call	#0x10
4684:  3241           pop	sr
4686:  3152           add	#0x8, sp
; 
4688:  0b41           mov	sp, r11
468a:  2b52           add	#0x4, r11
;                     r11: ---v
; 33a0:   0a00 0000 0000 6a47 0000 0000 4ccf 0044   ......jG....L..D
; 33b0:   6447 7844 0000 0000 0000 0000 0000 0000   dGxD............
; 33c0:   *
; getsn( pPassword, 20 )
468c:  3c40 1400      mov	#0x14, r12
4690:  2d43           mov	#0x2, r13
4692:  0c12           push	r12
4694:  0b12           push	r11
4696:  0d12           push	r13
4698:  0012           push	pc
469a:  0212           push	sr
469c:  0f4d           mov	r13, r15
469e:  8f10           swpb	r15
46a0:  024f           mov	r15, sr
46a2:  32d0 0080      bis	#0x8000, sr
46a6:  b012 1000      call	#0x10
46aa:  3241           pop	sr
46ac:  3152           add	#0x8, sp
; INT 7e
46ae:  3d50 7c00      add	#0x7c, r13
46b2:  0c41           mov	sp, r12
46b4:  0c12           push	r12
46b6:  0b12           push	r11
46b8:  0d12           push	r13
46ba:  0012           push	pc
46bc:  0212           push	sr
46be:  0f4d           mov	r13, r15
46c0:  8f10           swpb	r15
46c2:  024f           mov	r15, sr
46c4:  32d0 0080      bis	#0x8000, sr
46c8:  b012 1000      call	#0x10
46cc:  3241           pop	sr
46ce:  3152           add	#0x8, sp
; strcpy( @2402, "Wrong!" )
46d0:  f240 5700 0224 mov.b	#0x57, &0x2402
46d6:  f240 7200 0324 mov.b	#0x72, &0x2403
46dc:  f240 6f00 0424 mov.b	#0x6f, &0x2404
46e2:  f240 6e00 0524 mov.b	#0x6e, &0x2405
46e8:  f240 6700 0624 mov.b	#0x67, &0x2406
46ee:  f240 2100 0724 mov.b	#0x21, &0x2407
46f4:  c24e 0824      mov.b	r14, &0x2408
46f8:  b240 0700 0024 mov	#0x7, &0x2400
46fe:  3d40 0224      mov	#0x2402, r13
; r13 = "Wrong."
4702:  103c           jmp	#0x4724 <_aslr_main+0x2a2>
; puts( "Wrong." )
4704:  1d53           inc	r13
4706:  8c11           sxt	r12
4708:  0e12           push	r14
470a:  0c12           push	r12
470c:  0e12           push	r14
470e:  0012           push	pc
4710:  0212           push	sr
4712:  0f4e           mov	r14, r15
4714:  8f10           swpb	r15
4716:  024f           mov	r15, sr
4718:  32d0 0080      bis	#0x8000, sr
471c:  b012 1000      call	#0x10
4720:  3241           pop	sr
4722:  3152           add	#0x8, sp
4724:  6c4d           mov.b	@r13, r12
4726:  4c93           tst.b	r12
4728:  ed23           jnz	#0x4704 <_aslr_main+0x282>
472a:  0e43           clr	r14
472c:  3d40 0a00      mov	#0xa, r13
4730:  0e12           push	r14
4732:  0d12           push	r13
4734:  0e12           push	r14
4736:  0012           push	pc
4738:  0212           push	sr
473a:  0f4e           mov	r14, r15
473c:  8f10           swpb	r15
473e:  024f           mov	r15, sr
4740:  32d0 0080      bis	#0x8000, sr
4744:  b012 1000      call	#0x10
4748:  3241           pop	sr
474a:  3152           add	#0x8, sp
;
474c:  0e41           mov	sp, r14
474e:  2e53           incd	r14
4750:  0e12           push	r14
4752:  3f41           pop	r15
4754:  3152           add	#0x8, sp
4756:  3a41           pop	r10
4758:  3b41           pop	r11
475a:  3041           ret


475c <aslr_main>
475c:  0e4f           mov	r15, r14
475e:  3e50 8200      add	#0x82, r14
4762:  8e12           call	r14
4764:  32d0 f000      bis	#0xf0, sr
4768:  3041           ret


476a <printf>
476a:  0b12           push	r11
476c:  0a12           push	r10
476e:  0912           push	r9
4770:  0812           push	r8
4772:  0712           push	r7
4774:  0612           push	r6
4776:  0412           push	r4
4778:  0441           mov	sp, r4
477a:  3450 0e00      add	#0xe, r4
477e:  2183           decd	sp
4780:  1a44 0200      mov	0x2(r4), r10
4784:  8441 f0ff      mov	sp, -0x10(r4)
4788:  0f4a           mov	r10, r15
478a:  0e43           clr	r14
478c:  0b3c           jmp	#0x47a4 <printf+0x3a>
478e:  1f53           inc	r15
4790:  7d90 2500      cmp.b	#0x25, r13
4794:  0720           jne	#0x47a4 <printf+0x3a>
4796:  6d9f           cmp.b	@r15, r13
4798:  0320           jne	#0x47a0 <printf+0x36>
479a:  1f53           inc	r15
479c:  0d43           clr	r13
479e:  013c           jmp	#0x47a2 <printf+0x38>
47a0:  1d43           mov	#0x1, r13
47a2:  0e5d           add	r13, r14
47a4:  6d4f           mov.b	@r15, r13
47a6:  4d93           tst.b	r13
47a8:  f223           jnz	#0x478e <printf+0x24>
47aa:  0f4e           mov	r14, r15
47ac:  0f5f           add	r15, r15
47ae:  2f53           incd	r15
47b0:  018f           sub	r15, sp
47b2:  0b41           mov	sp, r11
47b4:  0c44           mov	r4, r12
47b6:  2c52           add	#0x4, r12
47b8:  0f41           mov	sp, r15
47ba:  0d43           clr	r13
47bc:  053c           jmp	#0x47c8 <printf+0x5e>
47be:  af4c 0000      mov	@r12, 0x0(r15)
47c2:  1d53           inc	r13
47c4:  2f53           incd	r15
47c6:  2c53           incd	r12
47c8:  0d9e           cmp	r14, r13
47ca:  f93b           jl	#0x47be <printf+0x54>
47cc:  0c43           clr	r12
47ce:  3640 0900      mov	#0x9, r6
47d2:  0d4c           mov	r12, r13
47d4:  3740 2500      mov	#0x25, r7
47d8:  7b3c           jmp	#0x48d0 <printf+0x166>
47da:  1a53           inc	r10
47dc:  7f90 2500      cmp.b	#0x25, r15
47e0:  1224           jeq	#0x4806 <printf+0x9c>
47e2:  1c53           inc	r12
47e4:  4e4f           mov.b	r15, r14
47e6:  8e11           sxt	r14
47e8:  0d12           push	r13
47ea:  0e12           push	r14
47ec:  0d12           push	r13
47ee:  0012           push	pc
47f0:  0212           push	sr
47f2:  0f4d           mov	r13, r15
47f4:  8f10           swpb	r15
47f6:  024f           mov	r15, sr
47f8:  32d0 0080      bis	#0x8000, sr
47fc:  b012 1000      call	#0x10
4800:  3241           pop	sr
4802:  3152           add	#0x8, sp
4804:  653c           jmp	#0x48d0 <printf+0x166>
4806:  6e4a           mov.b	@r10, r14
4808:  4e9f           cmp.b	r15, r14
480a:  1020           jne	#0x482c <printf+0xc2>
480c:  1c53           inc	r12
480e:  0d12           push	r13
4810:  0712           push	r7
4812:  0d12           push	r13
4814:  0012           push	pc
4816:  0212           push	sr
4818:  0f4d           mov	r13, r15
481a:  8f10           swpb	r15
481c:  024f           mov	r15, sr
481e:  32d0 0080      bis	#0x8000, sr
4822:  b012 1000      call	#0x10
4826:  3241           pop	sr
4828:  3152           add	#0x8, sp
482a:  503c           jmp	#0x48cc <printf+0x162>
482c:  7e90 7300      cmp.b	#0x73, r14
4830:  1820           jne	#0x4862 <printf+0xf8>
4832:  2e4b           mov	@r11, r14
4834:  0843           clr	r8
4836:  113c           jmp	#0x485a <printf+0xf0>
4838:  1c53           inc	r12
483a:  1e53           inc	r14
483c:  8911           sxt	r9
483e:  0812           push	r8
4840:  0912           push	r9
4842:  0812           push	r8
4844:  0012           push	pc
4846:  0212           push	sr
4848:  0f48           mov	r8, r15
484a:  8f10           swpb	r15
484c:  024f           mov	r15, sr
484e:  32d0 0080      bis	#0x8000, sr
4852:  b012 1000      call	#0x10
4856:  3241           pop	sr
4858:  3152           add	#0x8, sp
485a:  694e           mov.b	@r14, r9
485c:  4993           tst.b	r9
485e:  ec23           jnz	#0x4838 <printf+0xce>
4860:  353c           jmp	#0x48cc <printf+0x162>
4862:  7e90 7800      cmp.b	#0x78, r14
4866:  2c20           jne	#0x48c0 <printf+0x156>
4868:  2e4b           mov	@r11, r14
486a:  2942           mov	#0x4, r9
486c:  243c           jmp	#0x48b6 <printf+0x14c>
486e:  0f4e           mov	r14, r15
4870:  8f10           swpb	r15
4872:  3ff0 ff00      and	#0xff, r15
4876:  12c3           clrc
4878:  0f10           rrc	r15
487a:  0f11           rra	r15
487c:  0f11           rra	r15
487e:  0f11           rra	r15
4880:  069f           cmp	r15, r6
4882:  0438           jl	#0x488c <printf+0x122>
4884:  084f           mov	r15, r8
4886:  3850 3000      add	#0x30, r8
488a:  033c           jmp	#0x4892 <printf+0x128>
488c:  084f           mov	r15, r8
488e:  3850 5700      add	#0x57, r8
4892:  0d12           push	r13
4894:  0812           push	r8
4896:  0d12           push	r13
4898:  0012           push	pc
489a:  0212           push	sr
489c:  0f4d           mov	r13, r15
489e:  8f10           swpb	r15
48a0:  024f           mov	r15, sr
48a2:  32d0 0080      bis	#0x8000, sr
48a6:  b012 1000      call	#0x10
48aa:  3241           pop	sr
48ac:  3152           add	#0x8, sp
48ae:  0e5e           add	r14, r14
48b0:  0e5e           add	r14, r14
48b2:  0e5e           add	r14, r14
48b4:  0e5e           add	r14, r14
48b6:  3953           add	#-0x1, r9
48b8:  3993           cmp	#-0x1, r9
48ba:  d923           jne	#0x486e <printf+0x104>
48bc:  2c52           add	#0x4, r12
48be:  063c           jmp	#0x48cc <printf+0x162>
48c0:  7e90 6e00      cmp.b	#0x6e, r14
48c4:  0320           jne	#0x48cc <printf+0x162>
48c6:  2f4b           mov	@r11, r15
48c8:  8f4c 0000      mov	r12, 0x0(r15)
48cc:  2b53           incd	r11
48ce:  1a53           inc	r10
48d0:  6f4a           mov.b	@r10, r15
48d2:  4f93           tst.b	r15
48d4:  8223           jnz	#0x47da <printf+0x70>
48d6:  1144 f0ff      mov	-0x10(r4), sp
48da:  2153           incd	sp
48dc:  3441           pop	r4
48de:  3641           pop	r6
48e0:  3741           pop	r7
48e2:  3841           pop	r8
48e4:  3941           pop	r9
48e6:  3a41           pop	r10
48e8:  3b41           pop	r11
48ea:  3041           ret


48ec <_INT>
48ec:  1e41 0200      mov	0x2(sp), r14
48f0:  0212           push	sr
48f2:  0f4e           mov	r14, r15
48f4:  8f10           swpb	r15
48f6:  024f           mov	r15, sr
48f8:  32d0 0080      bis	#0x8000, sr
48fc:  b012 1000      call	#0x10
4900:  3241           pop	sr
4902:  3041           ret


4904 <INT>
4904:  0c4f           mov	r15, r12
4906:  0d12           push	r13
4908:  0e12           push	r14
490a:  0c12           push	r12
490c:  0012           push	pc
490e:  0212           push	sr
4910:  0f4c           mov	r12, r15
4912:  8f10           swpb	r15
4914:  024f           mov	r15, sr
4916:  32d0 0080      bis	#0x8000, sr
491a:  b012 1000      call	#0x10
491e:  3241           pop	sr
4920:  3152           add	#0x8, sp
4922:  3041           ret


4924 <putchar>
4924:  0e4f           mov	r15, r14
4926:  0d43           clr	r13
4928:  0d12           push	r13
492a:  0e12           push	r14
492c:  0d12           push	r13
492e:  0012           push	pc
4930:  0212           push	sr
4932:  0f4d           mov	r13, r15
4934:  8f10           swpb	r15
4936:  024f           mov	r15, sr
4938:  32d0 0080      bis	#0x8000, sr
493c:  b012 1000      call	#0x10
4940:  3241           pop	sr
4942:  3152           add	#0x8, sp
4944:  0f4e           mov	r14, r15
4946:  3041           ret


4948 <getchar>
4948:  2183           decd	sp
494a:  0d43           clr	r13
494c:  1e43           mov	#0x1, r14
494e:  0c41           mov	sp, r12
4950:  0d12           push	r13
4952:  0c12           push	r12
4954:  0e12           push	r14
4956:  0012           push	pc
4958:  0212           push	sr
495a:  0f4e           mov	r14, r15
495c:  8f10           swpb	r15
495e:  024f           mov	r15, sr
4960:  32d0 0080      bis	#0x8000, sr
4964:  b012 1000      call	#0x10
4968:  3241           pop	sr
496a:  3152           add	#0x8, sp
496c:  6f41           mov.b	@sp, r15
496e:  8f11           sxt	r15
4970:  2153           incd	sp
4972:  3041           ret


4974 <getsn>
4974:  0d4f           mov	r15, r13
4976:  2c43           mov	#0x2, r12
4978:  0e12           push	r14
497a:  0d12           push	r13
497c:  0c12           push	r12
497e:  0012           push	pc
4980:  0212           push	sr
4982:  0f4c           mov	r12, r15
4984:  8f10           swpb	r15
4986:  024f           mov	r15, sr
4988:  32d0 0080      bis	#0x8000, sr
498c:  b012 1000      call	#0x10
4990:  3241           pop	sr
4992:  3152           add	#0x8, sp
4994:  3041           ret


4996 <puts>
4996:  0e4f           mov	r15, r14
4998:  0c43           clr	r12
499a:  103c           jmp	#0x49bc <puts+0x26>
499c:  1e53           inc	r14
499e:  8d11           sxt	r13
49a0:  0c12           push	r12
49a2:  0d12           push	r13
49a4:  0c12           push	r12
49a6:  0012           push	pc
49a8:  0212           push	sr
49aa:  0f4c           mov	r12, r15
49ac:  8f10           swpb	r15
49ae:  024f           mov	r15, sr
49b0:  32d0 0080      bis	#0x8000, sr
49b4:  b012 1000      call	#0x10
49b8:  3241           pop	sr
49ba:  3152           add	#0x8, sp
49bc:  6d4e           mov.b	@r14, r13
49be:  4d93           tst.b	r13
49c0:  ed23           jnz	#0x499c <puts+0x6>
49c2:  0e43           clr	r14
49c4:  3d40 0a00      mov	#0xa, r13
49c8:  0e12           push	r14
49ca:  0d12           push	r13
49cc:  0e12           push	r14
49ce:  0012           push	pc
49d0:  0212           push	sr
49d2:  0f4e           mov	r14, r15
49d4:  8f10           swpb	r15
49d6:  024f           mov	r15, sr
49d8:  32d0 0080      bis	#0x8000, sr
49dc:  b012 1000      call	#0x10
49e0:  3241           pop	sr
49e2:  3152           add	#0x8, sp
49e4:  0f4e           mov	r14, r15
49e6:  3041           ret


49e8 <_memcpy>
49e8:  1c41 0600      mov	0x6(sp), r12
49ec:  0f43           clr	r15
49ee:  093c           jmp	#0x4a02 <_memcpy+0x1a>
49f0:  1e41 0200      mov	0x2(sp), r14
49f4:  0e5f           add	r15, r14
49f6:  1d41 0400      mov	0x4(sp), r13
49fa:  0d5f           add	r15, r13
49fc:  ee4d 0000      mov.b	@r13, 0x0(r14)
4a00:  1f53           inc	r15
4a02:  0f9c           cmp	r12, r15
4a04:  f523           jne	#0x49f0 <_memcpy+0x8>
4a06:  3041           ret


4a08 <_bzero>
4a08:  0d43           clr	r13
4a0a:  053c           jmp	#0x4a16 <_bzero+0xe>
4a0c:  0c4f           mov	r15, r12
4a0e:  0c5d           add	r13, r12
4a10:  cc43 0000      mov.b	#0x0, 0x0(r12)
4a14:  1d53           inc	r13
4a16:  0d9e           cmp	r14, r13
4a18:  f923           jne	#0x4a0c <_bzero+0x4>
4a1a:  3041           ret


4a1c <rand>
4a1c:  0e43           clr	r14
4a1e:  3d40 2000      mov	#0x20, r13
4a22:  0e12           push	r14
4a24:  0e12           push	r14
4a26:  0d12           push	r13
4a28:  0012           push	pc
4a2a:  0212           push	sr
4a2c:  0f4d           mov	r13, r15
4a2e:  8f10           swpb	r15
4a30:  024f           mov	r15, sr
4a32:  32d0 0080      bis	#0x8000, sr
4a36:  b012 1000      call	#0x10
4a3a:  3241           pop	sr
4a3c:  3152           add	#0x8, sp
4a3e:  0f4f           mov	r15, r15
4a40:  3041           ret


4a42 <conditional_unlock_door>
4a42:  2183           decd	sp
4a44:  0e4f           mov	r15, r14
4a46:  3d40 7e00      mov	#0x7e, r13
4a4a:  0c41           mov	sp, r12
4a4c:  0c12           push	r12
4a4e:  0e12           push	r14
4a50:  0d12           push	r13
4a52:  0012           push	pc
4a54:  0212           push	sr
4a56:  0f4d           mov	r13, r15
4a58:  8f10           swpb	r15
4a5a:  024f           mov	r15, sr
4a5c:  32d0 0080      bis	#0x8000, sr
4a60:  b012 1000      call	#0x10
4a64:  3241           pop	sr
4a66:  3152           add	#0x8, sp
4a68:  0f43           clr	r15
4a6a:  2153           incd	sp
4a6c:  3041           ret
4a6e <_unexpected_>
    [overwritten]