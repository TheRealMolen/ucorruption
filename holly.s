4404:  3140 0044      mov   #0x4400, sp
; int* pN = (int*)0x015c
; int N <r5> = (*pN & 0xff) | 0x5a08
440c:  1542 5c01      mov   &0x015c, r5
4414:  75f3           and.b #-0x1, r5
441a:  35d0 085a      bis   #0x5a08, r5
; int c <r15> = 0x1100
4422:  3f40 0011      mov   #0x1100, r15
; if( c ) {
442a:  0f93           tst   r15
442c:  0724           jeq	#0x443c
;   while( r15 ) {
;   *pN = N
4432:  8245 5c01      mov   r5, &0x015c
443a:  2f83           decd  r15
443c:  0343           clr   r3
4442:  1e4f 3446      mov   0x4634(r15), r14
444a:  8f4e 0024      mov   r14, 0x2400(r15)
4452:  ef23           jnz	#0x4432
; }
4458:  0f43           clr   r15
445a:  0f93           tst   r15
4460:  0e24           jeq	#0x447e
; if( r15 ) {
;   *pN = N
4466:  8245 5c01      mov   r5, &0x015c
;   --r15
446e:  1f83           dec   r15
;   *((char*)pN + 0x3500) = 0
4474:  cf43 0035      clr.b 0x3500(r15)
447c:  f923           jnz	#0x4470
; }
;
; // copy mem from 2400->3600 to 1400->2600
; int* psrc <r15> = 0x2400
; for( int i <r14> = 0x1200; i != 0; --i ) {
4482:  3e40 0012      mov   #0x1200, r14
448a:  3f40 0024      mov   #0x2400, r15
;   *(psrc - 0x1002) = *psrc
4492:  bf4f feef      mov   @r15+, -0x1002(r15)
449a:  3e53           add   #-0x1, r14
449c:  fa23           jnz	#0x4492
; }
;  
; int* psomething = 0x160c
44a2:  3b40 0c16      mov   #0x160c, r11
44aa:  0212           push  sr
; int R = rand()
44be:  3240 00a0      mov   #0xa000, sr
44c2:  b012 1000      call  #0x10

<decode_and_execute_nugget>:    ; r11 is addr of nugget, r15 is (random) decrypt buffer
44c6:  0c4f           mov   r15, r12
; int* pdecrypted_nugg <r12> = 0xe000 + (rand() & 0x0ffe)
44c8:  3cf0 fe0f      and   #0x0ffe, r12
44cc:  3c50 00e0      add   #0xe000, r12
; int* pnextinstr_enc <r10> = ... // passed from prev func!
44d0:  0a4b           mov   r11, r10
; int instr <r15> = *(pnextinstr_enc++)
44d2:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[0] = decrypt_instr( instr )
44d4:  0012           push  pc
44d6:  733c           jmp	decrypt_instr
44d8:  8c4f 0000      mov   r15, 0x0(r12)
; instr <r15> = *(pnextinstr_enc++)
44dc:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[1] = decrypt_instr( instr )
44de:  0012           push  pc
44e0:  6e3c           jmp	decrypt_instr
44e2:  8c4f 0200      mov   r15, 0x2(r12)
; instr <r15> = *(pnextinstr_enc++)
44e6:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[2] = decrypt_instr( instr )
44e8:  0012           push  pc
44ea:  693c           jmp	decrypt_instr
44ec:  8c4f 0400      mov   r15, 0x4(r12)
; // red herring / time waste?
; instr = instr & 0xff1f
; while( instr ) {
;   instr--
44f0:  7ff0 1f00      and.b #0x1f, r15
44f4:  3f53           add   #-0x1, r15
44f6:  fe23           jnz	#0x44f4
; }
; instr <r15> = *(pnextinstr_enc++)
44f8:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[3] = decrypt_instr( instr )
44fa:  0012           push  pc
44fc:  603c           jmp	decrypt_instr
44fe:  8c4f 0600      mov   r15, 0x6(r12)
; instr <r15> = *(pnextinstr_enc++)
4502:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[4] = decrypt_instr( instr )
4504:  0012           push  pc
4506:  5b3c           jmp	decrypt_instr
4508:  8c4f 0800      mov   r15, 0x8(r12)
; instr <r15> = *(pnextinstr_enc++)
450c:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[5] = decrypt_instr( instr )
450e:  0012           push  pc
4510:  563c           jmp	decrypt_instr
4512:  8c4f 0a00      mov   r15, 0xa(r12)
; instr <r15> = *(pnextinstr_enc++)
4516:  3f4a           mov   @r10+, r15
; pdecrypted_nugg[6] = decrypt_instr( instr )
4518:  0012           push  pc
451a:  513c           jmp	decrypt_instr
451c:  8c4f 0c00      mov   r15, 0xc(r12)
;
4520:  0e4c           mov   r12, r14
4526:  0e4c           mov   r12, r14
; r13 = 0x4536  // this is used as a return jump from our decrypted nugget
4528:  0d40           mov   pc, r13
452a:  3d50 0c00      add   #0xc, r13
; ??
4532:  3241           pop   sr
; (*pdecrypted_nugg)()
4534:  004c           br    r12
; void* nextfunc <r12> = [set by previous microfunc]
4536:  0212           push  sr
; // clear pdecrypted_nugg buffer down
; pdecrypted_nugg[0] = 0
; pdecrypted_nugg[1] = 0
; pdecrypted_nugg[2] = 0
; pdecrypted_nugg[3] = 0
; pdecrypted_nugg[4] = 0
; pdecrypted_nugg[5] = 0
; pdecrypted_nugg[6] = 0
4538:  3e80 1541      sub   #0x4115, r14
4540:  8e43 1541      clr   0x4115(r14)
4544:  8e43 1741      clr   0x4117(r14)
4548:  8e43 1941      clr   0x4119(r14)
454c:  8e43 1b41      clr   0x411b(r14)
4550:  8e43 1d41      clr   0x411d(r14)
4554:  8e43 1f41      clr   0x411f(r14)
4558:  8e43 2141      clr   0x4121(r14)
; int a <r11> = 0x3194 - nextfunc
455c:  0b4c           mov   r12, r11
455e:  3b80 9431      sub   #0x3194, r11
; int src_size <r12> = 0x4678
4562:  3c40 2846      mov   #0x4628, r12
4566:  3c50 5000      add   #0x0050, r12
; int R <r15> = rand()
456a:  3240 00a0      mov   #0xa000, sr
456e:  b012 1000      call  #0x0010
4572:  0f53           add   #0x0, r15
; int c <r13> = 0x5000 + (R & 0x1ff0)
4574:  0d4f           mov   r15, r13
4576:  3df0 f01f      and   #0x1ff0, r13
457a:  3d50 0050      add   #0x5000, r13
; if( <pc> < 0x8000 ) {
457e:  3090 0080      cmp   #0x8000, pc
4582:  0234           jge	#0x4588
;   c += 0x3000
4584:  3d50 0030      add   #0x3000, r13
; }
; src_size -= 0x44be    // src_size = 0x01ba
4588:  3c80 be44      sub   #0x44be, r12
; 
458c:  0e40           mov   pc, r14
458e:  0d12           push  r13
4590:  3e80 c800      sub   #0x00c8, r14
4594:  0e12           push  r14
4596:  0f4e           mov   r14, r15
4598:  0c12           push  r12
; void* orig_src <r14> = 0x8000 + rnd1
; void* new_src <r13> = 0x5000 + rnd2
; memmove( new_src, orig_src, src_size )
459a:  bd4e 0000      mov   @r14+, 0x0000(r13)
459e:  2d53           incd  r13
45a0:  2c83           decd  r12
45a2:  0c93           tst   r12
45a4:  fa23           jnz	#0x459a
; memset( orig_src, 0, src_size * sizeof(int) )
45a6:  3c41           pop   r12
45a8:  3e41           pop   r14
45aa:  3c40 dc00      mov   #0x00dc, r12
45ae:  8e43 0000      clr   0x0000(r14)
45b2:  2e53           incd  r14
45b4:  2c83           decd  r12
45b6:  0c93           tst   r12
45b8:  fa23           jnz	#0x45ae
; goto new_src:decode_and_execute_nugget (randomly relocated)
45ba:  3d41           pop   r13
45bc:  004d           br    r13
;
<decrypt_instr>:    ; r10 = instr addr + 1w,  r15 = 1st instr, return decrypted in r15
45c2:  0e4a           mov   r10, r14
45c4:  8e10           swpb  r14
45ca:  3e80 d204      sub   #0x04d2, r14
45d2:  0e52           add   sr, r14
45d4:  0e10           rrc   r14
45da:  0eaa           dadd  r10, r14
45e0:  0e11           rra   r14
45e6:  0e10           rrc   r14
45e8:  2ea0           dadd  @pc, r14
45ee:  0e52           add   sr, r14
45f0:  0e10           rrc   r14
45f6:  2e50           add   @pc, r14
45f8:  0e10           rrc   r14
45fe:  0e10           rrc   r14
4604:  0fee           xor   r14, r15
; longform ret
460a:  3e41           pop   r14
460c:  2e53           incd  r14
4612:  004e           br    r14
;
4618:  3e41           pop   r14
461e:  2e53           incd  r14
4624:  004e           br    r14
;
4626:  3041           ret   
4628:  3041           ret   