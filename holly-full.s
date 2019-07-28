4400:  013c           jmp	#0x4404
4404:  3140 0044      mov   #0x4400, sp
4408:  013c           jmp	#0x440c
440c:  1542 5c01      mov   &0x015c, r5
4410:  013c           jmp	#0x4414
4414:  75f3           and.b #-0x1, r5
4416:  013c           jmp	#0x441a
441a:  35d0 085a      bis   #0x5a08, r5
441e:  013c           jmp	#0x4422
4422:  3f40 0011      mov   #0x1100, r15
4426:  013c           jmp	#0x442a
442a:  0f93           tst   r15
442c:  0724           jeq	#0x443c
442e:  013c           jmp	#0x4432
4432:  8245 5c01      mov   r5, &0x015c
4436:  013c           jmp	#0x443a
443a:  2f83           decd  r15
443c:  0343           clr   r3
443e:  013c           jmp	#0x4442
4442:  1e4f 3446      mov   0x4634(r15), r14
4446:  013c           jmp	#0x444a
444a:  8f4e 0024      mov   r14, 0x2400(r15)
444e:  013c           jmp	#0x4452
4452:  ef23           jnz	#0x4432
4454:  013c           jmp	#0x4458
4458:  0f43           clr   r15
445a:  0f93           tst   r15
445c:  013c           jmp	#0x4460
4460:  0e24           jeq	#0x447e
4462:  013c           jmp	#0x4466
4466:  8245 5c01      mov   r5, &0x015c
446a:  013c           jmp	#0x446e
446e:  1f83           dec   r15
4470:  013c           jmp	#0x4474
4474:  cf43 0035      clr.b 0x3500(r15)
4478:  013c           jmp	#0x447c
447c:  f923           jnz	#0x4470
447e:  013c           jmp	#0x4482
4482:  3e40 0012      mov   #0x1200, r14
4486:  013c           jmp	#0x448a
448a:  3f40 0024      mov   #0x2400, r15
448e:  013c           jmp	#0x4492
4492:  bf4f feef      mov   @r15+, -0x1002(r15)
4496:  013c           jmp	#0x449a
449a:  3e53           add   #-0x1, r14
449c:  fa23           jnz	#0x4492
449e:  013c           jmp	#0x44a2
44a2:  3b40 0c16      mov   #0x160c, r11
44a6:  013c           jmp	#0x44aa
44aa:  0212           push  sr
44ac:  013c           jmp	#0x44b0
44b0:  3040 be44      br    #0x44be
44be:  3240 00a0      mov   #0xa000, sr
44c2:  b012 1000      call  #0x0010
44c6:  0c4f           mov   r15, r12
44c8:  3cf0 fe0f      and   #0x0ffe, r12
44cc:  3c50 00e0      add   #0xe000, r12
44d0:  0a4b           mov   r11, r10
44d2:  3f4a           mov   @r10+, r15
44d4:  0012           push  pc
44d6:  733c           jmp	#0x45be
44d8:  8c4f 0000      mov   r15, 0x0000(r12)
44dc:  3f4a           mov   @r10+, r15
44de:  0012           push  pc
44e0:  6e3c           jmp	#0x45be
44e2:  8c4f 0200      mov   r15, 0x0002(r12)
44e6:  3f4a           mov   @r10+, r15
44e8:  0012           push  pc
44ea:  693c           jmp	#0x45be
44ec:  8c4f 0400      mov   r15, 0x0004(r12)
44f0:  7ff0 1f00      and.b #0x001f, r15
44f4:  3f53           add   #-0x1, r15
44f6:  fe23           jnz	#0x44f4
44f8:  3f4a           mov   @r10+, r15
44fa:  0012           push  pc
44fc:  603c           jmp	#0x45be
44fe:  8c4f 0600      mov   r15, 0x0006(r12)
4502:  3f4a           mov   @r10+, r15
4504:  0012           push  pc
4506:  5b3c           jmp	#0x45be
4508:  8c4f 0800      mov   r15, 0x0008(r12)
450c:  3f4a           mov   @r10+, r15
450e:  0012           push  pc
4510:  563c           jmp	#0x45be
4512:  8c4f 0a00      mov   r15, 0x000a(r12)
4516:  3f4a           mov   @r10+, r15
4518:  0012           push  pc
451a:  513c           jmp	#0x45be
451c:  8c4f 0c00      mov   r15, 0x000c(r12)
4520:  0e4c           mov   r12, r14
4522:  013c           jmp	#0x4526
4526:  0e4c           mov   r12, r14
4528:  0d40           mov   pc, r13
452a:  3d50 0c00      add   #0x000c, r13
452e:  013c           jmp	#0x4532
4532:  3241           pop   sr
4534:  004c           br    r12
4536:  0212           push  sr
4538:  3e80 1541      sub   #0x4115, r14
453c:  013c           jmp	#0x4540
4540:  8e43 1541      clr   0x4115(r14)
4544:  8e43 1741      clr   0x4117(r14)
4548:  8e43 1941      clr   0x4119(r14)
454c:  8e43 1b41      clr   0x411b(r14)
4550:  8e43 1d41      clr   0x411d(r14)
4554:  8e43 1f41      clr   0x411f(r14)
4558:  8e43 2141      clr   0x4121(r14)
455c:  0b4c           mov   r12, r11
455e:  3b80 9431      sub   #0x3194, r11
4562:  3c40 2846      mov   #0x4628, r12
4566:  3c50 5000      add   #0x0050, r12
456a:  3240 00a0      mov   #0xa000, sr
456e:  b012 1000      call  #0x0010
4572:  0f53           add   #0x0, r15
4574:  0d4f           mov   r15, r13
4576:  3df0 f01f      and   #0x1ff0, r13
457a:  3d50 0050      add   #0x5000, r13
457e:  3090 0080      cmp   #0x8000, pc
4582:  0234           jge	#0x4588
4584:  3d50 0030      add   #0x3000, r13
4588:  3c80 be44      sub   #0x44be, r12
458c:  0e40           mov   pc, r14
458e:  0d12           push  r13
4590:  3e80 c800      sub   #0x00c8, r14
4594:  0e12           push  r14
4596:  0f4e           mov   r14, r15
4598:  0c12           push  r12
459a:  bd4e 0000      mov   @r14+, 0x0000(r13)
459e:  2d53           incd  r13
45a0:  2c83           decd  r12
45a2:  0c93           tst   r12
45a4:  fa23           jnz	#0x459a
45a6:  3c41           pop   r12
45a8:  3e41           pop   r14
45aa:  3c40 dc00      mov   #0x00dc, r12
45ae:  8e43 0000      clr   0x0000(r14)
45b2:  2e53           incd  r14
45b4:  2c83           decd  r12
45b6:  0c93           tst   r12
45b8:  fa23           jnz	#0x45ae
45ba:  3d41           pop   r13
45bc:  004d           br    r13
45be:  013c           jmp	#0x45c2
45c2:  0e4a           mov   r10, r14
45c4:  8e10           swpb  r14
45c6:  013c           jmp	#0x45ca
45ca:  3e80 d204      sub   #0x04d2, r14
45ce:  013c           jmp	#0x45d2
45d2:  0e52           add   sr, r14
45d4:  0e10           rrc   r14
45d6:  013c           jmp	#0x45da
45da:  0eaa           dadd  r10, r14
45dc:  013c           jmp	#0x45e0
45e0:  0e11           rra   r14
45e2:  013c           jmp	#0x45e6
45e6:  0e10           rrc   r14
45e8:  2ea0           dadd  @pc, r14
45ea:  013c           jmp	#0x45ee
45ee:  0e52           add   sr, r14
45f0:  0e10           rrc   r14
45f2:  013c           jmp	#0x45f6
45f6:  2e50           add   @pc, r14
45f8:  0e10           rrc   r14
45fa:  013c           jmp	#0x45fe
45fe:  0e10           rrc   r14
4600:  013c           jmp	#0x4604
4604:  0fee           xor   r14, r15
4606:  013c           jmp	#0x460a
460a:  3e41           pop   r14
460c:  2e53           incd  r14
460e:  013c           jmp	#0x4612
4612:  004e           br    r14
4614:  013c           jmp	#0x4618
4618:  3e41           pop   r14
461a:  013c           jmp	#0x461e
461e:  2e53           incd  r14
4620:  013c           jmp	#0x4624
4624:  004e           br    r14
4626:  3041           ret   
4628:  3041           ret   