
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <r_sp>:
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64
r_sp()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
       8:	878a                	mv	a5,sp
       a:	fef43423          	sd	a5,-24(s0)
  return x;
       e:	fe843783          	ld	a5,-24(s0)
}
      12:	853e                	mv	a0,a5
      14:	60e2                	ld	ra,24(sp)
      16:	6442                	ld	s0,16(sp)
      18:	6105                	addi	sp,sp,32
      1a:	8082                	ret

000000000000001c <copyin>:

// what if you pass ridiculous pointers to system calls
// that read user memory with copyin?
void
copyin(char *s)
{
      1c:	7159                	addi	sp,sp,-112
      1e:	f486                	sd	ra,104(sp)
      20:	f0a2                	sd	s0,96(sp)
      22:	1880                	addi	s0,sp,112
      24:	f8a43c23          	sd	a0,-104(s0)
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      28:	00008797          	auipc	a5,0x8
      2c:	8b878793          	addi	a5,a5,-1864 # 78e0 <malloc+0x1fc>
      30:	638c                	ld	a1,0(a5)
      32:	6790                	ld	a2,8(a5)
      34:	6b94                	ld	a3,16(a5)
      36:	6f98                	ld	a4,24(a5)
      38:	739c                	ld	a5,32(a5)
      3a:	fab43823          	sd	a1,-80(s0)
      3e:	fac43c23          	sd	a2,-72(s0)
      42:	fcd43023          	sd	a3,-64(s0)
      46:	fce43423          	sd	a4,-56(s0)
      4a:	fcf43823          	sd	a5,-48(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      4e:	fe042623          	sw	zero,-20(s0)
      52:	aaa1                	j	1aa <copyin+0x18e>
    uint64 addr = addrs[ai];
      54:	fec42703          	lw	a4,-20(s0)
      58:	fb040793          	addi	a5,s0,-80
      5c:	070e                	slli	a4,a4,0x3
      5e:	97ba                	add	a5,a5,a4
      60:	639c                	ld	a5,0(a5)
      62:	fef43023          	sd	a5,-32(s0)
    
    int fd = open("copyin1", O_CREATE|O_WRONLY);
      66:	20100593          	li	a1,513
      6a:	00007517          	auipc	a0,0x7
      6e:	7b650513          	addi	a0,a0,1974 # 7820 <malloc+0x13c>
      72:	5a7060ef          	jal	6e18 <open>
      76:	87aa                	mv	a5,a0
      78:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      7c:	fdc42783          	lw	a5,-36(s0)
      80:	2781                	sext.w	a5,a5
      82:	0007db63          	bgez	a5,98 <copyin+0x7c>
      printf("open(copyin1) failed\n");
      86:	00007517          	auipc	a0,0x7
      8a:	7a250513          	addi	a0,a0,1954 # 7828 <malloc+0x144>
      8e:	46e070ef          	jal	74fc <printf>
      exit(1);
      92:	4505                	li	a0,1
      94:	545060ef          	jal	6dd8 <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      98:	fe043703          	ld	a4,-32(s0)
      9c:	fdc42783          	lw	a5,-36(s0)
      a0:	6609                	lui	a2,0x2
      a2:	85ba                	mv	a1,a4
      a4:	853e                	mv	a0,a5
      a6:	553060ef          	jal	6df8 <write>
      aa:	87aa                	mv	a5,a0
      ac:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      b0:	fd842783          	lw	a5,-40(s0)
      b4:	2781                	sext.w	a5,a5
      b6:	0207c163          	bltz	a5,d8 <copyin+0xbc>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
      ba:	fe043783          	ld	a5,-32(s0)
      be:	fd842703          	lw	a4,-40(s0)
      c2:	863a                	mv	a2,a4
      c4:	85be                	mv	a1,a5
      c6:	00007517          	auipc	a0,0x7
      ca:	77a50513          	addi	a0,a0,1914 # 7840 <malloc+0x15c>
      ce:	42e070ef          	jal	74fc <printf>
      exit(1);
      d2:	4505                	li	a0,1
      d4:	505060ef          	jal	6dd8 <exit>
    }
    close(fd);
      d8:	fdc42783          	lw	a5,-36(s0)
      dc:	853e                	mv	a0,a5
      de:	523060ef          	jal	6e00 <close>
    unlink("copyin1");
      e2:	00007517          	auipc	a0,0x7
      e6:	73e50513          	addi	a0,a0,1854 # 7820 <malloc+0x13c>
      ea:	53f060ef          	jal	6e28 <unlink>
    
    n = write(1, (char*)addr, 8192);
      ee:	fe043783          	ld	a5,-32(s0)
      f2:	6609                	lui	a2,0x2
      f4:	85be                	mv	a1,a5
      f6:	4505                	li	a0,1
      f8:	501060ef          	jal	6df8 <write>
      fc:	87aa                	mv	a5,a0
      fe:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     102:	fd842783          	lw	a5,-40(s0)
     106:	2781                	sext.w	a5,a5
     108:	02f05163          	blez	a5,12a <copyin+0x10e>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     10c:	fe043783          	ld	a5,-32(s0)
     110:	fd842703          	lw	a4,-40(s0)
     114:	863a                	mv	a2,a4
     116:	85be                	mv	a1,a5
     118:	00007517          	auipc	a0,0x7
     11c:	75850513          	addi	a0,a0,1880 # 7870 <malloc+0x18c>
     120:	3dc070ef          	jal	74fc <printf>
      exit(1);
     124:	4505                	li	a0,1
     126:	4b3060ef          	jal	6dd8 <exit>
    }
    
    int fds[2];
    if(pipe(fds) < 0){
     12a:	fa840793          	addi	a5,s0,-88
     12e:	853e                	mv	a0,a5
     130:	4b9060ef          	jal	6de8 <pipe>
     134:	87aa                	mv	a5,a0
     136:	0007db63          	bgez	a5,14c <copyin+0x130>
      printf("pipe() failed\n");
     13a:	00007517          	auipc	a0,0x7
     13e:	76650513          	addi	a0,a0,1894 # 78a0 <malloc+0x1bc>
     142:	3ba070ef          	jal	74fc <printf>
      exit(1);
     146:	4505                	li	a0,1
     148:	491060ef          	jal	6dd8 <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     14c:	fac42783          	lw	a5,-84(s0)
     150:	fe043703          	ld	a4,-32(s0)
     154:	6609                	lui	a2,0x2
     156:	85ba                	mv	a1,a4
     158:	853e                	mv	a0,a5
     15a:	49f060ef          	jal	6df8 <write>
     15e:	87aa                	mv	a5,a0
     160:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     164:	fd842783          	lw	a5,-40(s0)
     168:	2781                	sext.w	a5,a5
     16a:	02f05163          	blez	a5,18c <copyin+0x170>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     16e:	fe043783          	ld	a5,-32(s0)
     172:	fd842703          	lw	a4,-40(s0)
     176:	863a                	mv	a2,a4
     178:	85be                	mv	a1,a5
     17a:	00007517          	auipc	a0,0x7
     17e:	73650513          	addi	a0,a0,1846 # 78b0 <malloc+0x1cc>
     182:	37a070ef          	jal	74fc <printf>
      exit(1);
     186:	4505                	li	a0,1
     188:	451060ef          	jal	6dd8 <exit>
    }
    close(fds[0]);
     18c:	fa842783          	lw	a5,-88(s0)
     190:	853e                	mv	a0,a5
     192:	46f060ef          	jal	6e00 <close>
    close(fds[1]);
     196:	fac42783          	lw	a5,-84(s0)
     19a:	853e                	mv	a0,a5
     19c:	465060ef          	jal	6e00 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     1a0:	fec42783          	lw	a5,-20(s0)
     1a4:	2785                	addiw	a5,a5,1
     1a6:	fef42623          	sw	a5,-20(s0)
     1aa:	fec42703          	lw	a4,-20(s0)
     1ae:	4791                	li	a5,4
     1b0:	eae7f2e3          	bgeu	a5,a4,54 <copyin+0x38>
  }
}
     1b4:	0001                	nop
     1b6:	0001                	nop
     1b8:	70a6                	ld	ra,104(sp)
     1ba:	7406                	ld	s0,96(sp)
     1bc:	6165                	addi	sp,sp,112
     1be:	8082                	ret

00000000000001c0 <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1c0:	7159                	addi	sp,sp,-112
     1c2:	f486                	sd	ra,104(sp)
     1c4:	f0a2                	sd	s0,96(sp)
     1c6:	1880                	addi	s0,sp,112
     1c8:	f8a43c23          	sd	a0,-104(s0)
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     1cc:	00007797          	auipc	a5,0x7
     1d0:	7dc78793          	addi	a5,a5,2012 # 79a8 <malloc+0x2c4>
     1d4:	6388                	ld	a0,0(a5)
     1d6:	678c                	ld	a1,8(a5)
     1d8:	6b90                	ld	a2,16(a5)
     1da:	6f94                	ld	a3,24(a5)
     1dc:	7398                	ld	a4,32(a5)
     1de:	779c                	ld	a5,40(a5)
     1e0:	faa43423          	sd	a0,-88(s0)
     1e4:	fab43823          	sd	a1,-80(s0)
     1e8:	fac43c23          	sd	a2,-72(s0)
     1ec:	fcd43023          	sd	a3,-64(s0)
     1f0:	fce43423          	sd	a4,-56(s0)
     1f4:	fcf43823          	sd	a5,-48(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     1f8:	fe042623          	sw	zero,-20(s0)
     1fc:	a2a1                	j	344 <copyout+0x184>
    uint64 addr = addrs[ai];
     1fe:	fec42703          	lw	a4,-20(s0)
     202:	fa840793          	addi	a5,s0,-88
     206:	070e                	slli	a4,a4,0x3
     208:	97ba                	add	a5,a5,a4
     20a:	639c                	ld	a5,0(a5)
     20c:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     210:	4581                	li	a1,0
     212:	00007517          	auipc	a0,0x7
     216:	6f650513          	addi	a0,a0,1782 # 7908 <malloc+0x224>
     21a:	3ff060ef          	jal	6e18 <open>
     21e:	87aa                	mv	a5,a0
     220:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     224:	fdc42783          	lw	a5,-36(s0)
     228:	2781                	sext.w	a5,a5
     22a:	0007db63          	bgez	a5,240 <copyout+0x80>
      printf("open(README) failed\n");
     22e:	00007517          	auipc	a0,0x7
     232:	6e250513          	addi	a0,a0,1762 # 7910 <malloc+0x22c>
     236:	2c6070ef          	jal	74fc <printf>
      exit(1);
     23a:	4505                	li	a0,1
     23c:	39d060ef          	jal	6dd8 <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     240:	fe043703          	ld	a4,-32(s0)
     244:	fdc42783          	lw	a5,-36(s0)
     248:	6609                	lui	a2,0x2
     24a:	85ba                	mv	a1,a4
     24c:	853e                	mv	a0,a5
     24e:	3a3060ef          	jal	6df0 <read>
     252:	87aa                	mv	a5,a0
     254:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     258:	fd842783          	lw	a5,-40(s0)
     25c:	2781                	sext.w	a5,a5
     25e:	02f05163          	blez	a5,280 <copyout+0xc0>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     262:	fe043783          	ld	a5,-32(s0)
     266:	fd842703          	lw	a4,-40(s0)
     26a:	863a                	mv	a2,a4
     26c:	85be                	mv	a1,a5
     26e:	00007517          	auipc	a0,0x7
     272:	6ba50513          	addi	a0,a0,1722 # 7928 <malloc+0x244>
     276:	286070ef          	jal	74fc <printf>
      exit(1);
     27a:	4505                	li	a0,1
     27c:	35d060ef          	jal	6dd8 <exit>
    }
    close(fd);
     280:	fdc42783          	lw	a5,-36(s0)
     284:	853e                	mv	a0,a5
     286:	37b060ef          	jal	6e00 <close>

    int fds[2];
    if(pipe(fds) < 0){
     28a:	fa040793          	addi	a5,s0,-96
     28e:	853e                	mv	a0,a5
     290:	359060ef          	jal	6de8 <pipe>
     294:	87aa                	mv	a5,a0
     296:	0007db63          	bgez	a5,2ac <copyout+0xec>
      printf("pipe() failed\n");
     29a:	00007517          	auipc	a0,0x7
     29e:	60650513          	addi	a0,a0,1542 # 78a0 <malloc+0x1bc>
     2a2:	25a070ef          	jal	74fc <printf>
      exit(1);
     2a6:	4505                	li	a0,1
     2a8:	331060ef          	jal	6dd8 <exit>
    }
    n = write(fds[1], "x", 1);
     2ac:	fa442783          	lw	a5,-92(s0)
     2b0:	4605                	li	a2,1
     2b2:	00007597          	auipc	a1,0x7
     2b6:	6a658593          	addi	a1,a1,1702 # 7958 <malloc+0x274>
     2ba:	853e                	mv	a0,a5
     2bc:	33d060ef          	jal	6df8 <write>
     2c0:	87aa                	mv	a5,a0
     2c2:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     2c6:	fd842783          	lw	a5,-40(s0)
     2ca:	0007871b          	sext.w	a4,a5
     2ce:	4785                	li	a5,1
     2d0:	00f70b63          	beq	a4,a5,2e6 <copyout+0x126>
      printf("pipe write failed\n");
     2d4:	00007517          	auipc	a0,0x7
     2d8:	68c50513          	addi	a0,a0,1676 # 7960 <malloc+0x27c>
     2dc:	220070ef          	jal	74fc <printf>
      exit(1);
     2e0:	4505                	li	a0,1
     2e2:	2f7060ef          	jal	6dd8 <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     2e6:	fa042783          	lw	a5,-96(s0)
     2ea:	fe043703          	ld	a4,-32(s0)
     2ee:	6609                	lui	a2,0x2
     2f0:	85ba                	mv	a1,a4
     2f2:	853e                	mv	a0,a5
     2f4:	2fd060ef          	jal	6df0 <read>
     2f8:	87aa                	mv	a5,a0
     2fa:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     2fe:	fd842783          	lw	a5,-40(s0)
     302:	2781                	sext.w	a5,a5
     304:	02f05163          	blez	a5,326 <copyout+0x166>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     308:	fe043783          	ld	a5,-32(s0)
     30c:	fd842703          	lw	a4,-40(s0)
     310:	863a                	mv	a2,a4
     312:	85be                	mv	a1,a5
     314:	00007517          	auipc	a0,0x7
     318:	66450513          	addi	a0,a0,1636 # 7978 <malloc+0x294>
     31c:	1e0070ef          	jal	74fc <printf>
      exit(1);
     320:	4505                	li	a0,1
     322:	2b7060ef          	jal	6dd8 <exit>
    }
    close(fds[0]);
     326:	fa042783          	lw	a5,-96(s0)
     32a:	853e                	mv	a0,a5
     32c:	2d5060ef          	jal	6e00 <close>
    close(fds[1]);
     330:	fa442783          	lw	a5,-92(s0)
     334:	853e                	mv	a0,a5
     336:	2cb060ef          	jal	6e00 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     33a:	fec42783          	lw	a5,-20(s0)
     33e:	2785                	addiw	a5,a5,1
     340:	fef42623          	sw	a5,-20(s0)
     344:	fec42703          	lw	a4,-20(s0)
     348:	4795                	li	a5,5
     34a:	eae7fae3          	bgeu	a5,a4,1fe <copyout+0x3e>
  }
}
     34e:	0001                	nop
     350:	0001                	nop
     352:	70a6                	ld	ra,104(sp)
     354:	7406                	ld	s0,96(sp)
     356:	6165                	addi	sp,sp,112
     358:	8082                	ret

000000000000035a <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     35a:	711d                	addi	sp,sp,-96
     35c:	ec86                	sd	ra,88(sp)
     35e:	e8a2                	sd	s0,80(sp)
     360:	1080                	addi	s0,sp,96
     362:	faa43423          	sd	a0,-88(s0)
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     366:	00007797          	auipc	a5,0x7
     36a:	57a78793          	addi	a5,a5,1402 # 78e0 <malloc+0x1fc>
     36e:	638c                	ld	a1,0(a5)
     370:	6790                	ld	a2,8(a5)
     372:	6b94                	ld	a3,16(a5)
     374:	6f98                	ld	a4,24(a5)
     376:	739c                	ld	a5,32(a5)
     378:	fab43823          	sd	a1,-80(s0)
     37c:	fac43c23          	sd	a2,-72(s0)
     380:	fcd43023          	sd	a3,-64(s0)
     384:	fce43423          	sd	a4,-56(s0)
     388:	fcf43823          	sd	a5,-48(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     38c:	fe042623          	sw	zero,-20(s0)
     390:	a8a9                	j	3ea <copyinstr1+0x90>
    uint64 addr = addrs[ai];
     392:	fec42703          	lw	a4,-20(s0)
     396:	fb040793          	addi	a5,s0,-80
     39a:	070e                	slli	a4,a4,0x3
     39c:	97ba                	add	a5,a5,a4
     39e:	639c                	ld	a5,0(a5)
     3a0:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3a4:	fe043783          	ld	a5,-32(s0)
     3a8:	20100593          	li	a1,513
     3ac:	853e                	mv	a0,a5
     3ae:	26b060ef          	jal	6e18 <open>
     3b2:	87aa                	mv	a5,a0
     3b4:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     3b8:	fdc42783          	lw	a5,-36(s0)
     3bc:	2781                	sext.w	a5,a5
     3be:	0207c163          	bltz	a5,3e0 <copyinstr1+0x86>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
     3c2:	fe043783          	ld	a5,-32(s0)
     3c6:	fdc42703          	lw	a4,-36(s0)
     3ca:	863a                	mv	a2,a4
     3cc:	85be                	mv	a1,a5
     3ce:	00007517          	auipc	a0,0x7
     3d2:	60a50513          	addi	a0,a0,1546 # 79d8 <malloc+0x2f4>
     3d6:	126070ef          	jal	74fc <printf>
      exit(1);
     3da:	4505                	li	a0,1
     3dc:	1fd060ef          	jal	6dd8 <exit>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     3e0:	fec42783          	lw	a5,-20(s0)
     3e4:	2785                	addiw	a5,a5,1
     3e6:	fef42623          	sw	a5,-20(s0)
     3ea:	fec42703          	lw	a4,-20(s0)
     3ee:	4791                	li	a5,4
     3f0:	fae7f1e3          	bgeu	a5,a4,392 <copyinstr1+0x38>
    }
  }
}
     3f4:	0001                	nop
     3f6:	0001                	nop
     3f8:	60e6                	ld	ra,88(sp)
     3fa:	6446                	ld	s0,80(sp)
     3fc:	6125                	addi	sp,sp,96
     3fe:	8082                	ret

0000000000000400 <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     400:	7151                	addi	sp,sp,-240
     402:	f586                	sd	ra,232(sp)
     404:	f1a2                	sd	s0,224(sp)
     406:	1980                	addi	s0,sp,240
     408:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     40c:	fe042623          	sw	zero,-20(s0)
     410:	a831                	j	42c <copyinstr2+0x2c>
    b[i] = 'x';
     412:	fec42783          	lw	a5,-20(s0)
     416:	17c1                	addi	a5,a5,-16
     418:	97a2                	add	a5,a5,s0
     41a:	07800713          	li	a4,120
     41e:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     422:	fec42783          	lw	a5,-20(s0)
     426:	2785                	addiw	a5,a5,1
     428:	fef42623          	sw	a5,-20(s0)
     42c:	fec42783          	lw	a5,-20(s0)
     430:	0007871b          	sext.w	a4,a5
     434:	07f00793          	li	a5,127
     438:	fce7dde3          	bge	a5,a4,412 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     43c:	fc040c23          	sb	zero,-40(s0)
  
  int ret = unlink(b);
     440:	f5840793          	addi	a5,s0,-168
     444:	853e                	mv	a0,a5
     446:	1e3060ef          	jal	6e28 <unlink>
     44a:	87aa                	mv	a5,a0
     44c:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     450:	fe442783          	lw	a5,-28(s0)
     454:	0007871b          	sext.w	a4,a5
     458:	57fd                	li	a5,-1
     45a:	02f70163          	beq	a4,a5,47c <copyinstr2+0x7c>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     45e:	fe442703          	lw	a4,-28(s0)
     462:	f5840793          	addi	a5,s0,-168
     466:	863a                	mv	a2,a4
     468:	85be                	mv	a1,a5
     46a:	00007517          	auipc	a0,0x7
     46e:	58e50513          	addi	a0,a0,1422 # 79f8 <malloc+0x314>
     472:	08a070ef          	jal	74fc <printf>
    exit(1);
     476:	4505                	li	a0,1
     478:	161060ef          	jal	6dd8 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     47c:	f5840793          	addi	a5,s0,-168
     480:	20100593          	li	a1,513
     484:	853e                	mv	a0,a5
     486:	193060ef          	jal	6e18 <open>
     48a:	87aa                	mv	a5,a0
     48c:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     490:	fe042783          	lw	a5,-32(s0)
     494:	0007871b          	sext.w	a4,a5
     498:	57fd                	li	a5,-1
     49a:	02f70163          	beq	a4,a5,4bc <copyinstr2+0xbc>
    printf("open(%s) returned %d, not -1\n", b, fd);
     49e:	fe042703          	lw	a4,-32(s0)
     4a2:	f5840793          	addi	a5,s0,-168
     4a6:	863a                	mv	a2,a4
     4a8:	85be                	mv	a1,a5
     4aa:	00007517          	auipc	a0,0x7
     4ae:	56e50513          	addi	a0,a0,1390 # 7a18 <malloc+0x334>
     4b2:	04a070ef          	jal	74fc <printf>
    exit(1);
     4b6:	4505                	li	a0,1
     4b8:	121060ef          	jal	6dd8 <exit>
  }

  ret = link(b, b);
     4bc:	f5840713          	addi	a4,s0,-168
     4c0:	f5840793          	addi	a5,s0,-168
     4c4:	85ba                	mv	a1,a4
     4c6:	853e                	mv	a0,a5
     4c8:	171060ef          	jal	6e38 <link>
     4cc:	87aa                	mv	a5,a0
     4ce:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4d2:	fe442783          	lw	a5,-28(s0)
     4d6:	0007871b          	sext.w	a4,a5
     4da:	57fd                	li	a5,-1
     4dc:	02f70363          	beq	a4,a5,502 <copyinstr2+0x102>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     4e0:	fe442683          	lw	a3,-28(s0)
     4e4:	f5840713          	addi	a4,s0,-168
     4e8:	f5840793          	addi	a5,s0,-168
     4ec:	863a                	mv	a2,a4
     4ee:	85be                	mv	a1,a5
     4f0:	00007517          	auipc	a0,0x7
     4f4:	54850513          	addi	a0,a0,1352 # 7a38 <malloc+0x354>
     4f8:	004070ef          	jal	74fc <printf>
    exit(1);
     4fc:	4505                	li	a0,1
     4fe:	0db060ef          	jal	6dd8 <exit>
  }

  char *args[] = { "xx", 0 };
     502:	00007797          	auipc	a5,0x7
     506:	55e78793          	addi	a5,a5,1374 # 7a60 <malloc+0x37c>
     50a:	f4f43423          	sd	a5,-184(s0)
     50e:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     512:	f4840713          	addi	a4,s0,-184
     516:	f5840793          	addi	a5,s0,-168
     51a:	85ba                	mv	a1,a4
     51c:	853e                	mv	a0,a5
     51e:	0f3060ef          	jal	6e10 <exec>
     522:	87aa                	mv	a5,a0
     524:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     528:	fe442783          	lw	a5,-28(s0)
     52c:	0007871b          	sext.w	a4,a5
     530:	57fd                	li	a5,-1
     532:	02f70163          	beq	a4,a5,554 <copyinstr2+0x154>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     536:	fe042703          	lw	a4,-32(s0)
     53a:	f5840793          	addi	a5,s0,-168
     53e:	863a                	mv	a2,a4
     540:	85be                	mv	a1,a5
     542:	00007517          	auipc	a0,0x7
     546:	52650513          	addi	a0,a0,1318 # 7a68 <malloc+0x384>
     54a:	7b3060ef          	jal	74fc <printf>
    exit(1);
     54e:	4505                	li	a0,1
     550:	089060ef          	jal	6dd8 <exit>
  }

  int pid = fork();
     554:	07d060ef          	jal	6dd0 <fork>
     558:	87aa                	mv	a5,a0
     55a:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     55e:	fdc42783          	lw	a5,-36(s0)
     562:	2781                	sext.w	a5,a5
     564:	0007db63          	bgez	a5,57a <copyinstr2+0x17a>
    printf("fork failed\n");
     568:	00007517          	auipc	a0,0x7
     56c:	52050513          	addi	a0,a0,1312 # 7a88 <malloc+0x3a4>
     570:	78d060ef          	jal	74fc <printf>
    exit(1);
     574:	4505                	li	a0,1
     576:	063060ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
     57a:	fdc42783          	lw	a5,-36(s0)
     57e:	2781                	sext.w	a5,a5
     580:	e7d5                	bnez	a5,62c <copyinstr2+0x22c>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     582:	fe042423          	sw	zero,-24(s0)
     586:	a00d                	j	5a8 <copyinstr2+0x1a8>
      big[i] = 'x';
     588:	0000f717          	auipc	a4,0xf
     58c:	63870713          	addi	a4,a4,1592 # fbc0 <big.0>
     590:	fe842783          	lw	a5,-24(s0)
     594:	97ba                	add	a5,a5,a4
     596:	07800713          	li	a4,120
     59a:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     59e:	fe842783          	lw	a5,-24(s0)
     5a2:	2785                	addiw	a5,a5,1
     5a4:	fef42423          	sw	a5,-24(s0)
     5a8:	fe842783          	lw	a5,-24(s0)
     5ac:	0007871b          	sext.w	a4,a5
     5b0:	6785                	lui	a5,0x1
     5b2:	fcf74be3          	blt	a4,a5,588 <copyinstr2+0x188>
    big[PGSIZE] = '\0';
     5b6:	0000f717          	auipc	a4,0xf
     5ba:	60a70713          	addi	a4,a4,1546 # fbc0 <big.0>
     5be:	6785                	lui	a5,0x1
     5c0:	97ba                	add	a5,a5,a4
     5c2:	00078023          	sb	zero,0(a5) # 1000 <openiputtest+0x14>
    char *args2[] = { big, big, big, 0 };
     5c6:	00007797          	auipc	a5,0x7
     5ca:	53278793          	addi	a5,a5,1330 # 7af8 <malloc+0x414>
     5ce:	6390                	ld	a2,0(a5)
     5d0:	6794                	ld	a3,8(a5)
     5d2:	6b98                	ld	a4,16(a5)
     5d4:	6f9c                	ld	a5,24(a5)
     5d6:	f2c43023          	sd	a2,-224(s0)
     5da:	f2d43423          	sd	a3,-216(s0)
     5de:	f2e43823          	sd	a4,-208(s0)
     5e2:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     5e6:	f2040793          	addi	a5,s0,-224
     5ea:	85be                	mv	a1,a5
     5ec:	00007517          	auipc	a0,0x7
     5f0:	4ac50513          	addi	a0,a0,1196 # 7a98 <malloc+0x3b4>
     5f4:	01d060ef          	jal	6e10 <exec>
     5f8:	87aa                	mv	a5,a0
     5fa:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     5fe:	fe442783          	lw	a5,-28(s0)
     602:	0007871b          	sext.w	a4,a5
     606:	57fd                	li	a5,-1
     608:	00f70e63          	beq	a4,a5,624 <copyinstr2+0x224>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     60c:	fe042783          	lw	a5,-32(s0)
     610:	85be                	mv	a1,a5
     612:	00007517          	auipc	a0,0x7
     616:	48e50513          	addi	a0,a0,1166 # 7aa0 <malloc+0x3bc>
     61a:	6e3060ef          	jal	74fc <printf>
      exit(1);
     61e:	4505                	li	a0,1
     620:	7b8060ef          	jal	6dd8 <exit>
    }
    exit(747); // OK
     624:	2eb00513          	li	a0,747
     628:	7b0060ef          	jal	6dd8 <exit>
  }

  int st = 0;
     62c:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     630:	f4440793          	addi	a5,s0,-188
     634:	853e                	mv	a0,a5
     636:	7aa060ef          	jal	6de0 <wait>
  if(st != 747){
     63a:	f4442703          	lw	a4,-188(s0)
     63e:	2eb00793          	li	a5,747
     642:	00f70b63          	beq	a4,a5,658 <copyinstr2+0x258>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     646:	00007517          	auipc	a0,0x7
     64a:	48250513          	addi	a0,a0,1154 # 7ac8 <malloc+0x3e4>
     64e:	6af060ef          	jal	74fc <printf>
    exit(1);
     652:	4505                	li	a0,1
     654:	784060ef          	jal	6dd8 <exit>
  }
}
     658:	0001                	nop
     65a:	70ae                	ld	ra,232(sp)
     65c:	740e                	ld	s0,224(sp)
     65e:	616d                	addi	sp,sp,240
     660:	8082                	ret

0000000000000662 <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     662:	715d                	addi	sp,sp,-80
     664:	e486                	sd	ra,72(sp)
     666:	e0a2                	sd	s0,64(sp)
     668:	0880                	addi	s0,sp,80
     66a:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     66e:	6509                	lui	a0,0x2
     670:	714060ef          	jal	6d84 <sbrk>
  uint64 top = (uint64) sbrk(0);
     674:	4501                	li	a0,0
     676:	70e060ef          	jal	6d84 <sbrk>
     67a:	87aa                	mv	a5,a0
     67c:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     680:	fe843703          	ld	a4,-24(s0)
     684:	6785                	lui	a5,0x1
     686:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
     688:	8ff9                	and	a5,a5,a4
     68a:	c385                	beqz	a5,6aa <copyinstr3+0x48>
    sbrk(PGSIZE - (top % PGSIZE));
     68c:	fe843783          	ld	a5,-24(s0)
     690:	2781                	sext.w	a5,a5
     692:	873e                	mv	a4,a5
     694:	6785                	lui	a5,0x1
     696:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
     698:	8ff9                	and	a5,a5,a4
     69a:	2781                	sext.w	a5,a5
     69c:	6705                	lui	a4,0x1
     69e:	40f707bb          	subw	a5,a4,a5
     6a2:	2781                	sext.w	a5,a5
     6a4:	853e                	mv	a0,a5
     6a6:	6de060ef          	jal	6d84 <sbrk>
  }
  top = (uint64) sbrk(0);
     6aa:	4501                	li	a0,0
     6ac:	6d8060ef          	jal	6d84 <sbrk>
     6b0:	87aa                	mv	a5,a0
     6b2:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     6b6:	fe843703          	ld	a4,-24(s0)
     6ba:	6785                	lui	a5,0x1
     6bc:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
     6be:	8ff9                	and	a5,a5,a4
     6c0:	cb91                	beqz	a5,6d4 <copyinstr3+0x72>
    printf("oops\n");
     6c2:	00007517          	auipc	a0,0x7
     6c6:	45650513          	addi	a0,a0,1110 # 7b18 <malloc+0x434>
     6ca:	633060ef          	jal	74fc <printf>
    exit(1);
     6ce:	4505                	li	a0,1
     6d0:	708060ef          	jal	6dd8 <exit>
  }

  char *b = (char *) (top - 1);
     6d4:	fe843783          	ld	a5,-24(s0)
     6d8:	17fd                	addi	a5,a5,-1
     6da:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     6de:	fe043783          	ld	a5,-32(s0)
     6e2:	07800713          	li	a4,120
     6e6:	00e78023          	sb	a4,0(a5)

  int ret = unlink(b);
     6ea:	fe043503          	ld	a0,-32(s0)
     6ee:	73a060ef          	jal	6e28 <unlink>
     6f2:	87aa                	mv	a5,a0
     6f4:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     6f8:	fdc42783          	lw	a5,-36(s0)
     6fc:	0007871b          	sext.w	a4,a5
     700:	57fd                	li	a5,-1
     702:	02f70063          	beq	a4,a5,722 <copyinstr3+0xc0>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     706:	fdc42783          	lw	a5,-36(s0)
     70a:	863e                	mv	a2,a5
     70c:	fe043583          	ld	a1,-32(s0)
     710:	00007517          	auipc	a0,0x7
     714:	2e850513          	addi	a0,a0,744 # 79f8 <malloc+0x314>
     718:	5e5060ef          	jal	74fc <printf>
    exit(1);
     71c:	4505                	li	a0,1
     71e:	6ba060ef          	jal	6dd8 <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     722:	20100593          	li	a1,513
     726:	fe043503          	ld	a0,-32(s0)
     72a:	6ee060ef          	jal	6e18 <open>
     72e:	87aa                	mv	a5,a0
     730:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     734:	fd842783          	lw	a5,-40(s0)
     738:	0007871b          	sext.w	a4,a5
     73c:	57fd                	li	a5,-1
     73e:	02f70063          	beq	a4,a5,75e <copyinstr3+0xfc>
    printf("open(%s) returned %d, not -1\n", b, fd);
     742:	fd842783          	lw	a5,-40(s0)
     746:	863e                	mv	a2,a5
     748:	fe043583          	ld	a1,-32(s0)
     74c:	00007517          	auipc	a0,0x7
     750:	2cc50513          	addi	a0,a0,716 # 7a18 <malloc+0x334>
     754:	5a9060ef          	jal	74fc <printf>
    exit(1);
     758:	4505                	li	a0,1
     75a:	67e060ef          	jal	6dd8 <exit>
  }

  ret = link(b, b);
     75e:	fe043583          	ld	a1,-32(s0)
     762:	fe043503          	ld	a0,-32(s0)
     766:	6d2060ef          	jal	6e38 <link>
     76a:	87aa                	mv	a5,a0
     76c:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     770:	fdc42783          	lw	a5,-36(s0)
     774:	0007871b          	sext.w	a4,a5
     778:	57fd                	li	a5,-1
     77a:	02f70263          	beq	a4,a5,79e <copyinstr3+0x13c>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     77e:	fdc42783          	lw	a5,-36(s0)
     782:	86be                	mv	a3,a5
     784:	fe043603          	ld	a2,-32(s0)
     788:	fe043583          	ld	a1,-32(s0)
     78c:	00007517          	auipc	a0,0x7
     790:	2ac50513          	addi	a0,a0,684 # 7a38 <malloc+0x354>
     794:	569060ef          	jal	74fc <printf>
    exit(1);
     798:	4505                	li	a0,1
     79a:	63e060ef          	jal	6dd8 <exit>
  }

  char *args[] = { "xx", 0 };
     79e:	00007797          	auipc	a5,0x7
     7a2:	2c278793          	addi	a5,a5,706 # 7a60 <malloc+0x37c>
     7a6:	fcf43423          	sd	a5,-56(s0)
     7aa:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     7ae:	fc840793          	addi	a5,s0,-56
     7b2:	85be                	mv	a1,a5
     7b4:	fe043503          	ld	a0,-32(s0)
     7b8:	658060ef          	jal	6e10 <exec>
     7bc:	87aa                	mv	a5,a0
     7be:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7c2:	fdc42783          	lw	a5,-36(s0)
     7c6:	0007871b          	sext.w	a4,a5
     7ca:	57fd                	li	a5,-1
     7cc:	02f70063          	beq	a4,a5,7ec <copyinstr3+0x18a>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     7d0:	fd842783          	lw	a5,-40(s0)
     7d4:	863e                	mv	a2,a5
     7d6:	fe043583          	ld	a1,-32(s0)
     7da:	00007517          	auipc	a0,0x7
     7de:	28e50513          	addi	a0,a0,654 # 7a68 <malloc+0x384>
     7e2:	51b060ef          	jal	74fc <printf>
    exit(1);
     7e6:	4505                	li	a0,1
     7e8:	5f0060ef          	jal	6dd8 <exit>
  }
}
     7ec:	0001                	nop
     7ee:	60a6                	ld	ra,72(sp)
     7f0:	6406                	ld	s0,64(sp)
     7f2:	6161                	addi	sp,sp,80
     7f4:	8082                	ret

00000000000007f6 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk(char *s)
{
     7f6:	7179                	addi	sp,sp,-48
     7f8:	f406                	sd	ra,40(sp)
     7fa:	f022                	sd	s0,32(sp)
     7fc:	1800                	addi	s0,sp,48
     7fe:	fca43c23          	sd	a0,-40(s0)
  int fd, n;
  
  uint64 a = (uint64) sbrk(8192);
     802:	6509                	lui	a0,0x2
     804:	580060ef          	jal	6d84 <sbrk>
     808:	87aa                	mv	a5,a0
     80a:	fef43423          	sd	a5,-24(s0)

  if(a == (uint64) SBRK_ERROR) {
     80e:	fe843703          	ld	a4,-24(s0)
     812:	57fd                	li	a5,-1
     814:	00f71b63          	bne	a4,a5,82a <rwsbrk+0x34>
    printf("sbrk(rwsbrk) failed\n");
     818:	00007517          	auipc	a0,0x7
     81c:	30850513          	addi	a0,a0,776 # 7b20 <malloc+0x43c>
     820:	4dd060ef          	jal	74fc <printf>
    exit(1);
     824:	4505                	li	a0,1
     826:	5b2060ef          	jal	6dd8 <exit>
  }
  
  if (sbrk(-8192) == SBRK_ERROR) {
     82a:	7579                	lui	a0,0xffffe
     82c:	558060ef          	jal	6d84 <sbrk>
     830:	872a                	mv	a4,a0
     832:	57fd                	li	a5,-1
     834:	00f71b63          	bne	a4,a5,84a <rwsbrk+0x54>
    printf("sbrk(rwsbrk) shrink failed\n");
     838:	00007517          	auipc	a0,0x7
     83c:	30050513          	addi	a0,a0,768 # 7b38 <malloc+0x454>
     840:	4bd060ef          	jal	74fc <printf>
    exit(1);
     844:	4505                	li	a0,1
     846:	592060ef          	jal	6dd8 <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     84a:	20100593          	li	a1,513
     84e:	00007517          	auipc	a0,0x7
     852:	30a50513          	addi	a0,a0,778 # 7b58 <malloc+0x474>
     856:	5c2060ef          	jal	6e18 <open>
     85a:	87aa                	mv	a5,a0
     85c:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     860:	fe442783          	lw	a5,-28(s0)
     864:	2781                	sext.w	a5,a5
     866:	0007db63          	bgez	a5,87c <rwsbrk+0x86>
    printf("open(rwsbrk) failed\n");
     86a:	00007517          	auipc	a0,0x7
     86e:	2f650513          	addi	a0,a0,758 # 7b60 <malloc+0x47c>
     872:	48b060ef          	jal	74fc <printf>
    exit(1);
     876:	4505                	li	a0,1
     878:	560060ef          	jal	6dd8 <exit>
  }
  n = write(fd, (void*)(a+PGSIZE), 1024);
     87c:	fe843703          	ld	a4,-24(s0)
     880:	6785                	lui	a5,0x1
     882:	97ba                	add	a5,a5,a4
     884:	873e                	mv	a4,a5
     886:	fe442783          	lw	a5,-28(s0)
     88a:	40000613          	li	a2,1024
     88e:	85ba                	mv	a1,a4
     890:	853e                	mv	a0,a5
     892:	566060ef          	jal	6df8 <write>
     896:	87aa                	mv	a5,a0
     898:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     89c:	fe042783          	lw	a5,-32(s0)
     8a0:	2781                	sext.w	a5,a5
     8a2:	0207c463          	bltz	a5,8ca <rwsbrk+0xd4>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+PGSIZE, n);
     8a6:	fe843703          	ld	a4,-24(s0)
     8aa:	6785                	lui	a5,0x1
     8ac:	97ba                	add	a5,a5,a4
     8ae:	873e                	mv	a4,a5
     8b0:	fe042783          	lw	a5,-32(s0)
     8b4:	863e                	mv	a2,a5
     8b6:	85ba                	mv	a1,a4
     8b8:	00007517          	auipc	a0,0x7
     8bc:	2c050513          	addi	a0,a0,704 # 7b78 <malloc+0x494>
     8c0:	43d060ef          	jal	74fc <printf>
    exit(1);
     8c4:	4505                	li	a0,1
     8c6:	512060ef          	jal	6dd8 <exit>
  }
  close(fd);
     8ca:	fe442783          	lw	a5,-28(s0)
     8ce:	853e                	mv	a0,a5
     8d0:	530060ef          	jal	6e00 <close>
  unlink("rwsbrk");
     8d4:	00007517          	auipc	a0,0x7
     8d8:	28450513          	addi	a0,a0,644 # 7b58 <malloc+0x474>
     8dc:	54c060ef          	jal	6e28 <unlink>

  fd = open("README", O_RDONLY);
     8e0:	4581                	li	a1,0
     8e2:	00007517          	auipc	a0,0x7
     8e6:	02650513          	addi	a0,a0,38 # 7908 <malloc+0x224>
     8ea:	52e060ef          	jal	6e18 <open>
     8ee:	87aa                	mv	a5,a0
     8f0:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     8f4:	fe442783          	lw	a5,-28(s0)
     8f8:	2781                	sext.w	a5,a5
     8fa:	0007db63          	bgez	a5,910 <rwsbrk+0x11a>
    printf("open(README) failed\n");
     8fe:	00007517          	auipc	a0,0x7
     902:	01250513          	addi	a0,a0,18 # 7910 <malloc+0x22c>
     906:	3f7060ef          	jal	74fc <printf>
    exit(1);
     90a:	4505                	li	a0,1
     90c:	4cc060ef          	jal	6dd8 <exit>
  }
  n = read(fd, (void*)(a+PGSIZE), 10);
     910:	fe843703          	ld	a4,-24(s0)
     914:	6785                	lui	a5,0x1
     916:	97ba                	add	a5,a5,a4
     918:	873e                	mv	a4,a5
     91a:	fe442783          	lw	a5,-28(s0)
     91e:	4629                	li	a2,10
     920:	85ba                	mv	a1,a4
     922:	853e                	mv	a0,a5
     924:	4cc060ef          	jal	6df0 <read>
     928:	87aa                	mv	a5,a0
     92a:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     92e:	fe042783          	lw	a5,-32(s0)
     932:	2781                	sext.w	a5,a5
     934:	0207c463          	bltz	a5,95c <rwsbrk+0x166>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+PGSIZE, n);
     938:	fe843703          	ld	a4,-24(s0)
     93c:	6785                	lui	a5,0x1
     93e:	97ba                	add	a5,a5,a4
     940:	873e                	mv	a4,a5
     942:	fe042783          	lw	a5,-32(s0)
     946:	863e                	mv	a2,a5
     948:	85ba                	mv	a1,a4
     94a:	00007517          	auipc	a0,0x7
     94e:	25e50513          	addi	a0,a0,606 # 7ba8 <malloc+0x4c4>
     952:	3ab060ef          	jal	74fc <printf>
    exit(1);
     956:	4505                	li	a0,1
     958:	480060ef          	jal	6dd8 <exit>
  }
  close(fd);
     95c:	fe442783          	lw	a5,-28(s0)
     960:	853e                	mv	a0,a5
     962:	49e060ef          	jal	6e00 <close>
  
  exit(0);
     966:	4501                	li	a0,0
     968:	470060ef          	jal	6dd8 <exit>

000000000000096c <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     96c:	715d                	addi	sp,sp,-80
     96e:	e486                	sd	ra,72(sp)
     970:	e0a2                	sd	s0,64(sp)
     972:	0880                	addi	s0,sp,80
     974:	faa43c23          	sd	a0,-72(s0)
  char buf[32];
  
  unlink("truncfile");
     978:	00007517          	auipc	a0,0x7
     97c:	25850513          	addi	a0,a0,600 # 7bd0 <malloc+0x4ec>
     980:	4a8060ef          	jal	6e28 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     984:	60100593          	li	a1,1537
     988:	00007517          	auipc	a0,0x7
     98c:	24850513          	addi	a0,a0,584 # 7bd0 <malloc+0x4ec>
     990:	488060ef          	jal	6e18 <open>
     994:	87aa                	mv	a5,a0
     996:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     99a:	fec42783          	lw	a5,-20(s0)
     99e:	4611                	li	a2,4
     9a0:	00007597          	auipc	a1,0x7
     9a4:	24058593          	addi	a1,a1,576 # 7be0 <malloc+0x4fc>
     9a8:	853e                	mv	a0,a5
     9aa:	44e060ef          	jal	6df8 <write>
  close(fd1);
     9ae:	fec42783          	lw	a5,-20(s0)
     9b2:	853e                	mv	a0,a5
     9b4:	44c060ef          	jal	6e00 <close>

  int fd2 = open("truncfile", O_RDONLY);
     9b8:	4581                	li	a1,0
     9ba:	00007517          	auipc	a0,0x7
     9be:	21650513          	addi	a0,a0,534 # 7bd0 <malloc+0x4ec>
     9c2:	456060ef          	jal	6e18 <open>
     9c6:	87aa                	mv	a5,a0
     9c8:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     9cc:	fc040713          	addi	a4,s0,-64
     9d0:	fe842783          	lw	a5,-24(s0)
     9d4:	02000613          	li	a2,32
     9d8:	85ba                	mv	a1,a4
     9da:	853e                	mv	a0,a5
     9dc:	414060ef          	jal	6df0 <read>
     9e0:	87aa                	mv	a5,a0
     9e2:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     9e6:	fe442783          	lw	a5,-28(s0)
     9ea:	0007871b          	sext.w	a4,a5
     9ee:	4791                	li	a5,4
     9f0:	02f70063          	beq	a4,a5,a10 <truncate1+0xa4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     9f4:	fe442783          	lw	a5,-28(s0)
     9f8:	863e                	mv	a2,a5
     9fa:	fb843583          	ld	a1,-72(s0)
     9fe:	00007517          	auipc	a0,0x7
     a02:	1ea50513          	addi	a0,a0,490 # 7be8 <malloc+0x504>
     a06:	2f7060ef          	jal	74fc <printf>
    exit(1);
     a0a:	4505                	li	a0,1
     a0c:	3cc060ef          	jal	6dd8 <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     a10:	40100593          	li	a1,1025
     a14:	00007517          	auipc	a0,0x7
     a18:	1bc50513          	addi	a0,a0,444 # 7bd0 <malloc+0x4ec>
     a1c:	3fc060ef          	jal	6e18 <open>
     a20:	87aa                	mv	a5,a0
     a22:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     a26:	4581                	li	a1,0
     a28:	00007517          	auipc	a0,0x7
     a2c:	1a850513          	addi	a0,a0,424 # 7bd0 <malloc+0x4ec>
     a30:	3e8060ef          	jal	6e18 <open>
     a34:	87aa                	mv	a5,a0
     a36:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     a3a:	fc040713          	addi	a4,s0,-64
     a3e:	fe042783          	lw	a5,-32(s0)
     a42:	02000613          	li	a2,32
     a46:	85ba                	mv	a1,a4
     a48:	853e                	mv	a0,a5
     a4a:	3a6060ef          	jal	6df0 <read>
     a4e:	87aa                	mv	a5,a0
     a50:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     a54:	fe442783          	lw	a5,-28(s0)
     a58:	2781                	sext.w	a5,a5
     a5a:	cb85                	beqz	a5,a8a <truncate1+0x11e>
    printf("aaa fd3=%d\n", fd3);
     a5c:	fe042783          	lw	a5,-32(s0)
     a60:	85be                	mv	a1,a5
     a62:	00007517          	auipc	a0,0x7
     a66:	1a650513          	addi	a0,a0,422 # 7c08 <malloc+0x524>
     a6a:	293060ef          	jal	74fc <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     a6e:	fe442783          	lw	a5,-28(s0)
     a72:	863e                	mv	a2,a5
     a74:	fb843583          	ld	a1,-72(s0)
     a78:	00007517          	auipc	a0,0x7
     a7c:	1a050513          	addi	a0,a0,416 # 7c18 <malloc+0x534>
     a80:	27d060ef          	jal	74fc <printf>
    exit(1);
     a84:	4505                	li	a0,1
     a86:	352060ef          	jal	6dd8 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     a8a:	fc040713          	addi	a4,s0,-64
     a8e:	fe842783          	lw	a5,-24(s0)
     a92:	02000613          	li	a2,32
     a96:	85ba                	mv	a1,a4
     a98:	853e                	mv	a0,a5
     a9a:	356060ef          	jal	6df0 <read>
     a9e:	87aa                	mv	a5,a0
     aa0:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     aa4:	fe442783          	lw	a5,-28(s0)
     aa8:	2781                	sext.w	a5,a5
     aaa:	cb85                	beqz	a5,ada <truncate1+0x16e>
    printf("bbb fd2=%d\n", fd2);
     aac:	fe842783          	lw	a5,-24(s0)
     ab0:	85be                	mv	a1,a5
     ab2:	00007517          	auipc	a0,0x7
     ab6:	18650513          	addi	a0,a0,390 # 7c38 <malloc+0x554>
     aba:	243060ef          	jal	74fc <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     abe:	fe442783          	lw	a5,-28(s0)
     ac2:	863e                	mv	a2,a5
     ac4:	fb843583          	ld	a1,-72(s0)
     ac8:	00007517          	auipc	a0,0x7
     acc:	15050513          	addi	a0,a0,336 # 7c18 <malloc+0x534>
     ad0:	22d060ef          	jal	74fc <printf>
    exit(1);
     ad4:	4505                	li	a0,1
     ad6:	302060ef          	jal	6dd8 <exit>
  }
  
  write(fd1, "abcdef", 6);
     ada:	fec42783          	lw	a5,-20(s0)
     ade:	4619                	li	a2,6
     ae0:	00007597          	auipc	a1,0x7
     ae4:	16858593          	addi	a1,a1,360 # 7c48 <malloc+0x564>
     ae8:	853e                	mv	a0,a5
     aea:	30e060ef          	jal	6df8 <write>

  n = read(fd3, buf, sizeof(buf));
     aee:	fc040713          	addi	a4,s0,-64
     af2:	fe042783          	lw	a5,-32(s0)
     af6:	02000613          	li	a2,32
     afa:	85ba                	mv	a1,a4
     afc:	853e                	mv	a0,a5
     afe:	2f2060ef          	jal	6df0 <read>
     b02:	87aa                	mv	a5,a0
     b04:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     b08:	fe442783          	lw	a5,-28(s0)
     b0c:	0007871b          	sext.w	a4,a5
     b10:	4799                	li	a5,6
     b12:	02f70063          	beq	a4,a5,b32 <truncate1+0x1c6>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     b16:	fe442783          	lw	a5,-28(s0)
     b1a:	863e                	mv	a2,a5
     b1c:	fb843583          	ld	a1,-72(s0)
     b20:	00007517          	auipc	a0,0x7
     b24:	13050513          	addi	a0,a0,304 # 7c50 <malloc+0x56c>
     b28:	1d5060ef          	jal	74fc <printf>
    exit(1);
     b2c:	4505                	li	a0,1
     b2e:	2aa060ef          	jal	6dd8 <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     b32:	fc040713          	addi	a4,s0,-64
     b36:	fe842783          	lw	a5,-24(s0)
     b3a:	02000613          	li	a2,32
     b3e:	85ba                	mv	a1,a4
     b40:	853e                	mv	a0,a5
     b42:	2ae060ef          	jal	6df0 <read>
     b46:	87aa                	mv	a5,a0
     b48:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     b4c:	fe442783          	lw	a5,-28(s0)
     b50:	0007871b          	sext.w	a4,a5
     b54:	4789                	li	a5,2
     b56:	02f70063          	beq	a4,a5,b76 <truncate1+0x20a>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     b5a:	fe442783          	lw	a5,-28(s0)
     b5e:	863e                	mv	a2,a5
     b60:	fb843583          	ld	a1,-72(s0)
     b64:	00007517          	auipc	a0,0x7
     b68:	10c50513          	addi	a0,a0,268 # 7c70 <malloc+0x58c>
     b6c:	191060ef          	jal	74fc <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	266060ef          	jal	6dd8 <exit>
  }

  unlink("truncfile");
     b76:	00007517          	auipc	a0,0x7
     b7a:	05a50513          	addi	a0,a0,90 # 7bd0 <malloc+0x4ec>
     b7e:	2aa060ef          	jal	6e28 <unlink>

  close(fd1);
     b82:	fec42783          	lw	a5,-20(s0)
     b86:	853e                	mv	a0,a5
     b88:	278060ef          	jal	6e00 <close>
  close(fd2);
     b8c:	fe842783          	lw	a5,-24(s0)
     b90:	853e                	mv	a0,a5
     b92:	26e060ef          	jal	6e00 <close>
  close(fd3);
     b96:	fe042783          	lw	a5,-32(s0)
     b9a:	853e                	mv	a0,a5
     b9c:	264060ef          	jal	6e00 <close>
}
     ba0:	0001                	nop
     ba2:	60a6                	ld	ra,72(sp)
     ba4:	6406                	ld	s0,64(sp)
     ba6:	6161                	addi	sp,sp,80
     ba8:	8082                	ret

0000000000000baa <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     baa:	7179                	addi	sp,sp,-48
     bac:	f406                	sd	ra,40(sp)
     bae:	f022                	sd	s0,32(sp)
     bb0:	1800                	addi	s0,sp,48
     bb2:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     bb6:	00007517          	auipc	a0,0x7
     bba:	01a50513          	addi	a0,a0,26 # 7bd0 <malloc+0x4ec>
     bbe:	26a060ef          	jal	6e28 <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     bc2:	60100593          	li	a1,1537
     bc6:	00007517          	auipc	a0,0x7
     bca:	00a50513          	addi	a0,a0,10 # 7bd0 <malloc+0x4ec>
     bce:	24a060ef          	jal	6e18 <open>
     bd2:	87aa                	mv	a5,a0
     bd4:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     bd8:	fec42783          	lw	a5,-20(s0)
     bdc:	4611                	li	a2,4
     bde:	00007597          	auipc	a1,0x7
     be2:	00258593          	addi	a1,a1,2 # 7be0 <malloc+0x4fc>
     be6:	853e                	mv	a0,a5
     be8:	210060ef          	jal	6df8 <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     bec:	40100593          	li	a1,1025
     bf0:	00007517          	auipc	a0,0x7
     bf4:	fe050513          	addi	a0,a0,-32 # 7bd0 <malloc+0x4ec>
     bf8:	220060ef          	jal	6e18 <open>
     bfc:	87aa                	mv	a5,a0
     bfe:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     c02:	fec42783          	lw	a5,-20(s0)
     c06:	4605                	li	a2,1
     c08:	00007597          	auipc	a1,0x7
     c0c:	d5058593          	addi	a1,a1,-688 # 7958 <malloc+0x274>
     c10:	853e                	mv	a0,a5
     c12:	1e6060ef          	jal	6df8 <write>
     c16:	87aa                	mv	a5,a0
     c18:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     c1c:	fe442783          	lw	a5,-28(s0)
     c20:	0007871b          	sext.w	a4,a5
     c24:	57fd                	li	a5,-1
     c26:	02f70063          	beq	a4,a5,c46 <truncate2+0x9c>
    printf("%s: write returned %d, expected -1\n", s, n);
     c2a:	fe442783          	lw	a5,-28(s0)
     c2e:	863e                	mv	a2,a5
     c30:	fd843583          	ld	a1,-40(s0)
     c34:	00007517          	auipc	a0,0x7
     c38:	05c50513          	addi	a0,a0,92 # 7c90 <malloc+0x5ac>
     c3c:	0c1060ef          	jal	74fc <printf>
    exit(1);
     c40:	4505                	li	a0,1
     c42:	196060ef          	jal	6dd8 <exit>
  }

  unlink("truncfile");
     c46:	00007517          	auipc	a0,0x7
     c4a:	f8a50513          	addi	a0,a0,-118 # 7bd0 <malloc+0x4ec>
     c4e:	1da060ef          	jal	6e28 <unlink>
  close(fd1);
     c52:	fec42783          	lw	a5,-20(s0)
     c56:	853e                	mv	a0,a5
     c58:	1a8060ef          	jal	6e00 <close>
  close(fd2);
     c5c:	fe842783          	lw	a5,-24(s0)
     c60:	853e                	mv	a0,a5
     c62:	19e060ef          	jal	6e00 <close>
}
     c66:	0001                	nop
     c68:	70a2                	ld	ra,40(sp)
     c6a:	7402                	ld	s0,32(sp)
     c6c:	6145                	addi	sp,sp,48
     c6e:	8082                	ret

0000000000000c70 <truncate3>:

void
truncate3(char *s)
{
     c70:	711d                	addi	sp,sp,-96
     c72:	ec86                	sd	ra,88(sp)
     c74:	e8a2                	sd	s0,80(sp)
     c76:	1080                	addi	s0,sp,96
     c78:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     c7c:	60100593          	li	a1,1537
     c80:	00007517          	auipc	a0,0x7
     c84:	f5050513          	addi	a0,a0,-176 # 7bd0 <malloc+0x4ec>
     c88:	190060ef          	jal	6e18 <open>
     c8c:	87aa                	mv	a5,a0
     c8e:	853e                	mv	a0,a5
     c90:	170060ef          	jal	6e00 <close>
  
  pid = fork();
     c94:	13c060ef          	jal	6dd0 <fork>
     c98:	87aa                	mv	a5,a0
     c9a:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     c9e:	fe442783          	lw	a5,-28(s0)
     ca2:	2781                	sext.w	a5,a5
     ca4:	0007dd63          	bgez	a5,cbe <truncate3+0x4e>
    printf("%s: fork failed\n", s);
     ca8:	fa843583          	ld	a1,-88(s0)
     cac:	00007517          	auipc	a0,0x7
     cb0:	00c50513          	addi	a0,a0,12 # 7cb8 <malloc+0x5d4>
     cb4:	049060ef          	jal	74fc <printf>
    exit(1);
     cb8:	4505                	li	a0,1
     cba:	11e060ef          	jal	6dd8 <exit>
  }

  if(pid == 0){
     cbe:	fe442783          	lw	a5,-28(s0)
     cc2:	2781                	sext.w	a5,a5
     cc4:	0c079f63          	bnez	a5,da2 <truncate3+0x132>
    for(int i = 0; i < 100; i++){
     cc8:	fe042623          	sw	zero,-20(s0)
     ccc:	a0c1                	j	d8c <truncate3+0x11c>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     cce:	4585                	li	a1,1
     cd0:	00007517          	auipc	a0,0x7
     cd4:	f0050513          	addi	a0,a0,-256 # 7bd0 <malloc+0x4ec>
     cd8:	140060ef          	jal	6e18 <open>
     cdc:	87aa                	mv	a5,a0
     cde:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ce2:	fd842783          	lw	a5,-40(s0)
     ce6:	2781                	sext.w	a5,a5
     ce8:	0007dd63          	bgez	a5,d02 <truncate3+0x92>
        printf("%s: open failed\n", s);
     cec:	fa843583          	ld	a1,-88(s0)
     cf0:	00007517          	auipc	a0,0x7
     cf4:	fe050513          	addi	a0,a0,-32 # 7cd0 <malloc+0x5ec>
     cf8:	005060ef          	jal	74fc <printf>
        exit(1);
     cfc:	4505                	li	a0,1
     cfe:	0da060ef          	jal	6dd8 <exit>
      }
      int n = write(fd, "1234567890", 10);
     d02:	fd842783          	lw	a5,-40(s0)
     d06:	4629                	li	a2,10
     d08:	00007597          	auipc	a1,0x7
     d0c:	fe058593          	addi	a1,a1,-32 # 7ce8 <malloc+0x604>
     d10:	853e                	mv	a0,a5
     d12:	0e6060ef          	jal	6df8 <write>
     d16:	87aa                	mv	a5,a0
     d18:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     d1c:	fd442783          	lw	a5,-44(s0)
     d20:	0007871b          	sext.w	a4,a5
     d24:	47a9                	li	a5,10
     d26:	02f70063          	beq	a4,a5,d46 <truncate3+0xd6>
        printf("%s: write got %d, expected 10\n", s, n);
     d2a:	fd442783          	lw	a5,-44(s0)
     d2e:	863e                	mv	a2,a5
     d30:	fa843583          	ld	a1,-88(s0)
     d34:	00007517          	auipc	a0,0x7
     d38:	fc450513          	addi	a0,a0,-60 # 7cf8 <malloc+0x614>
     d3c:	7c0060ef          	jal	74fc <printf>
        exit(1);
     d40:	4505                	li	a0,1
     d42:	096060ef          	jal	6dd8 <exit>
      }
      close(fd);
     d46:	fd842783          	lw	a5,-40(s0)
     d4a:	853e                	mv	a0,a5
     d4c:	0b4060ef          	jal	6e00 <close>
      fd = open("truncfile", O_RDONLY);
     d50:	4581                	li	a1,0
     d52:	00007517          	auipc	a0,0x7
     d56:	e7e50513          	addi	a0,a0,-386 # 7bd0 <malloc+0x4ec>
     d5a:	0be060ef          	jal	6e18 <open>
     d5e:	87aa                	mv	a5,a0
     d60:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     d64:	fb040713          	addi	a4,s0,-80
     d68:	fd842783          	lw	a5,-40(s0)
     d6c:	02000613          	li	a2,32
     d70:	85ba                	mv	a1,a4
     d72:	853e                	mv	a0,a5
     d74:	07c060ef          	jal	6df0 <read>
      close(fd);
     d78:	fd842783          	lw	a5,-40(s0)
     d7c:	853e                	mv	a0,a5
     d7e:	082060ef          	jal	6e00 <close>
    for(int i = 0; i < 100; i++){
     d82:	fec42783          	lw	a5,-20(s0)
     d86:	2785                	addiw	a5,a5,1 # 1001 <openiputtest+0x15>
     d88:	fef42623          	sw	a5,-20(s0)
     d8c:	fec42783          	lw	a5,-20(s0)
     d90:	0007871b          	sext.w	a4,a5
     d94:	06300793          	li	a5,99
     d98:	f2e7dbe3          	bge	a5,a4,cce <truncate3+0x5e>
    }
    exit(0);
     d9c:	4501                	li	a0,0
     d9e:	03a060ef          	jal	6dd8 <exit>
  }

  for(int i = 0; i < 150; i++){
     da2:	fe042423          	sw	zero,-24(s0)
     da6:	a841                	j	e36 <truncate3+0x1c6>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     da8:	60100593          	li	a1,1537
     dac:	00007517          	auipc	a0,0x7
     db0:	e2450513          	addi	a0,a0,-476 # 7bd0 <malloc+0x4ec>
     db4:	064060ef          	jal	6e18 <open>
     db8:	87aa                	mv	a5,a0
     dba:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     dbe:	fe042783          	lw	a5,-32(s0)
     dc2:	2781                	sext.w	a5,a5
     dc4:	0007dd63          	bgez	a5,dde <truncate3+0x16e>
      printf("%s: open failed\n", s);
     dc8:	fa843583          	ld	a1,-88(s0)
     dcc:	00007517          	auipc	a0,0x7
     dd0:	f0450513          	addi	a0,a0,-252 # 7cd0 <malloc+0x5ec>
     dd4:	728060ef          	jal	74fc <printf>
      exit(1);
     dd8:	4505                	li	a0,1
     dda:	7ff050ef          	jal	6dd8 <exit>
    }
    int n = write(fd, "xxx", 3);
     dde:	fe042783          	lw	a5,-32(s0)
     de2:	460d                	li	a2,3
     de4:	00007597          	auipc	a1,0x7
     de8:	f3458593          	addi	a1,a1,-204 # 7d18 <malloc+0x634>
     dec:	853e                	mv	a0,a5
     dee:	00a060ef          	jal	6df8 <write>
     df2:	87aa                	mv	a5,a0
     df4:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
     df8:	fdc42783          	lw	a5,-36(s0)
     dfc:	0007871b          	sext.w	a4,a5
     e00:	478d                	li	a5,3
     e02:	02f70063          	beq	a4,a5,e22 <truncate3+0x1b2>
      printf("%s: write got %d, expected 3\n", s, n);
     e06:	fdc42783          	lw	a5,-36(s0)
     e0a:	863e                	mv	a2,a5
     e0c:	fa843583          	ld	a1,-88(s0)
     e10:	00007517          	auipc	a0,0x7
     e14:	f1050513          	addi	a0,a0,-240 # 7d20 <malloc+0x63c>
     e18:	6e4060ef          	jal	74fc <printf>
      exit(1);
     e1c:	4505                	li	a0,1
     e1e:	7bb050ef          	jal	6dd8 <exit>
    }
    close(fd);
     e22:	fe042783          	lw	a5,-32(s0)
     e26:	853e                	mv	a0,a5
     e28:	7d9050ef          	jal	6e00 <close>
  for(int i = 0; i < 150; i++){
     e2c:	fe842783          	lw	a5,-24(s0)
     e30:	2785                	addiw	a5,a5,1
     e32:	fef42423          	sw	a5,-24(s0)
     e36:	fe842783          	lw	a5,-24(s0)
     e3a:	0007871b          	sext.w	a4,a5
     e3e:	09500793          	li	a5,149
     e42:	f6e7d3e3          	bge	a5,a4,da8 <truncate3+0x138>
  }

  wait(&xstatus);
     e46:	fd040793          	addi	a5,s0,-48
     e4a:	853e                	mv	a0,a5
     e4c:	795050ef          	jal	6de0 <wait>
  unlink("truncfile");
     e50:	00007517          	auipc	a0,0x7
     e54:	d8050513          	addi	a0,a0,-640 # 7bd0 <malloc+0x4ec>
     e58:	7d1050ef          	jal	6e28 <unlink>
  exit(xstatus);
     e5c:	fd042783          	lw	a5,-48(s0)
     e60:	853e                	mv	a0,a5
     e62:	777050ef          	jal	6dd8 <exit>

0000000000000e66 <iputtest>:
  

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
     e66:	1101                	addi	sp,sp,-32
     e68:	ec06                	sd	ra,24(sp)
     e6a:	e822                	sd	s0,16(sp)
     e6c:	1000                	addi	s0,sp,32
     e6e:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
     e72:	00007517          	auipc	a0,0x7
     e76:	ece50513          	addi	a0,a0,-306 # 7d40 <malloc+0x65c>
     e7a:	7c7050ef          	jal	6e40 <mkdir>
     e7e:	87aa                	mv	a5,a0
     e80:	0007dd63          	bgez	a5,e9a <iputtest+0x34>
    printf("%s: mkdir failed\n", s);
     e84:	fe843583          	ld	a1,-24(s0)
     e88:	00007517          	auipc	a0,0x7
     e8c:	ec050513          	addi	a0,a0,-320 # 7d48 <malloc+0x664>
     e90:	66c060ef          	jal	74fc <printf>
    exit(1);
     e94:	4505                	li	a0,1
     e96:	743050ef          	jal	6dd8 <exit>
  }
  if(chdir("iputdir") < 0){
     e9a:	00007517          	auipc	a0,0x7
     e9e:	ea650513          	addi	a0,a0,-346 # 7d40 <malloc+0x65c>
     ea2:	7a7050ef          	jal	6e48 <chdir>
     ea6:	87aa                	mv	a5,a0
     ea8:	0007dd63          	bgez	a5,ec2 <iputtest+0x5c>
    printf("%s: chdir iputdir failed\n", s);
     eac:	fe843583          	ld	a1,-24(s0)
     eb0:	00007517          	auipc	a0,0x7
     eb4:	eb050513          	addi	a0,a0,-336 # 7d60 <malloc+0x67c>
     eb8:	644060ef          	jal	74fc <printf>
    exit(1);
     ebc:	4505                	li	a0,1
     ebe:	71b050ef          	jal	6dd8 <exit>
  }
  if(unlink("../iputdir") < 0){
     ec2:	00007517          	auipc	a0,0x7
     ec6:	ebe50513          	addi	a0,a0,-322 # 7d80 <malloc+0x69c>
     eca:	75f050ef          	jal	6e28 <unlink>
     ece:	87aa                	mv	a5,a0
     ed0:	0007dd63          	bgez	a5,eea <iputtest+0x84>
    printf("%s: unlink ../iputdir failed\n", s);
     ed4:	fe843583          	ld	a1,-24(s0)
     ed8:	00007517          	auipc	a0,0x7
     edc:	eb850513          	addi	a0,a0,-328 # 7d90 <malloc+0x6ac>
     ee0:	61c060ef          	jal	74fc <printf>
    exit(1);
     ee4:	4505                	li	a0,1
     ee6:	6f3050ef          	jal	6dd8 <exit>
  }
  if(chdir("/") < 0){
     eea:	00007517          	auipc	a0,0x7
     eee:	ec650513          	addi	a0,a0,-314 # 7db0 <malloc+0x6cc>
     ef2:	757050ef          	jal	6e48 <chdir>
     ef6:	87aa                	mv	a5,a0
     ef8:	0007dd63          	bgez	a5,f12 <iputtest+0xac>
    printf("%s: chdir / failed\n", s);
     efc:	fe843583          	ld	a1,-24(s0)
     f00:	00007517          	auipc	a0,0x7
     f04:	eb850513          	addi	a0,a0,-328 # 7db8 <malloc+0x6d4>
     f08:	5f4060ef          	jal	74fc <printf>
    exit(1);
     f0c:	4505                	li	a0,1
     f0e:	6cb050ef          	jal	6dd8 <exit>
  }
}
     f12:	0001                	nop
     f14:	60e2                	ld	ra,24(sp)
     f16:	6442                	ld	s0,16(sp)
     f18:	6105                	addi	sp,sp,32
     f1a:	8082                	ret

0000000000000f1c <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
     f1c:	7179                	addi	sp,sp,-48
     f1e:	f406                	sd	ra,40(sp)
     f20:	f022                	sd	s0,32(sp)
     f22:	1800                	addi	s0,sp,48
     f24:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
     f28:	6a9050ef          	jal	6dd0 <fork>
     f2c:	87aa                	mv	a5,a0
     f2e:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
     f32:	fec42783          	lw	a5,-20(s0)
     f36:	2781                	sext.w	a5,a5
     f38:	0007dd63          	bgez	a5,f52 <exitiputtest+0x36>
    printf("%s: fork failed\n", s);
     f3c:	fd843583          	ld	a1,-40(s0)
     f40:	00007517          	auipc	a0,0x7
     f44:	d7850513          	addi	a0,a0,-648 # 7cb8 <malloc+0x5d4>
     f48:	5b4060ef          	jal	74fc <printf>
    exit(1);
     f4c:	4505                	li	a0,1
     f4e:	68b050ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
     f52:	fec42783          	lw	a5,-20(s0)
     f56:	2781                	sext.w	a5,a5
     f58:	e3c1                	bnez	a5,fd8 <exitiputtest+0xbc>
    if(mkdir("iputdir") < 0){
     f5a:	00007517          	auipc	a0,0x7
     f5e:	de650513          	addi	a0,a0,-538 # 7d40 <malloc+0x65c>
     f62:	6df050ef          	jal	6e40 <mkdir>
     f66:	87aa                	mv	a5,a0
     f68:	0007dd63          	bgez	a5,f82 <exitiputtest+0x66>
      printf("%s: mkdir failed\n", s);
     f6c:	fd843583          	ld	a1,-40(s0)
     f70:	00007517          	auipc	a0,0x7
     f74:	dd850513          	addi	a0,a0,-552 # 7d48 <malloc+0x664>
     f78:	584060ef          	jal	74fc <printf>
      exit(1);
     f7c:	4505                	li	a0,1
     f7e:	65b050ef          	jal	6dd8 <exit>
    }
    if(chdir("iputdir") < 0){
     f82:	00007517          	auipc	a0,0x7
     f86:	dbe50513          	addi	a0,a0,-578 # 7d40 <malloc+0x65c>
     f8a:	6bf050ef          	jal	6e48 <chdir>
     f8e:	87aa                	mv	a5,a0
     f90:	0007dd63          	bgez	a5,faa <exitiputtest+0x8e>
      printf("%s: child chdir failed\n", s);
     f94:	fd843583          	ld	a1,-40(s0)
     f98:	00007517          	auipc	a0,0x7
     f9c:	e3850513          	addi	a0,a0,-456 # 7dd0 <malloc+0x6ec>
     fa0:	55c060ef          	jal	74fc <printf>
      exit(1);
     fa4:	4505                	li	a0,1
     fa6:	633050ef          	jal	6dd8 <exit>
    }
    if(unlink("../iputdir") < 0){
     faa:	00007517          	auipc	a0,0x7
     fae:	dd650513          	addi	a0,a0,-554 # 7d80 <malloc+0x69c>
     fb2:	677050ef          	jal	6e28 <unlink>
     fb6:	87aa                	mv	a5,a0
     fb8:	0007dd63          	bgez	a5,fd2 <exitiputtest+0xb6>
      printf("%s: unlink ../iputdir failed\n", s);
     fbc:	fd843583          	ld	a1,-40(s0)
     fc0:	00007517          	auipc	a0,0x7
     fc4:	dd050513          	addi	a0,a0,-560 # 7d90 <malloc+0x6ac>
     fc8:	534060ef          	jal	74fc <printf>
      exit(1);
     fcc:	4505                	li	a0,1
     fce:	60b050ef          	jal	6dd8 <exit>
    }
    exit(0);
     fd2:	4501                	li	a0,0
     fd4:	605050ef          	jal	6dd8 <exit>
  }
  wait(&xstatus);
     fd8:	fe840793          	addi	a5,s0,-24
     fdc:	853e                	mv	a0,a5
     fde:	603050ef          	jal	6de0 <wait>
  exit(xstatus);
     fe2:	fe842783          	lw	a5,-24(s0)
     fe6:	853e                	mv	a0,a5
     fe8:	5f1050ef          	jal	6dd8 <exit>

0000000000000fec <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
     fec:	7179                	addi	sp,sp,-48
     fee:	f406                	sd	ra,40(sp)
     ff0:	f022                	sd	s0,32(sp)
     ff2:	1800                	addi	s0,sp,48
     ff4:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
     ff8:	00007517          	auipc	a0,0x7
     ffc:	df050513          	addi	a0,a0,-528 # 7de8 <malloc+0x704>
    1000:	641050ef          	jal	6e40 <mkdir>
    1004:	87aa                	mv	a5,a0
    1006:	0007dd63          	bgez	a5,1020 <openiputtest+0x34>
    printf("%s: mkdir oidir failed\n", s);
    100a:	fd843583          	ld	a1,-40(s0)
    100e:	00007517          	auipc	a0,0x7
    1012:	de250513          	addi	a0,a0,-542 # 7df0 <malloc+0x70c>
    1016:	4e6060ef          	jal	74fc <printf>
    exit(1);
    101a:	4505                	li	a0,1
    101c:	5bd050ef          	jal	6dd8 <exit>
  }
  pid = fork();
    1020:	5b1050ef          	jal	6dd0 <fork>
    1024:	87aa                	mv	a5,a0
    1026:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    102a:	fec42783          	lw	a5,-20(s0)
    102e:	2781                	sext.w	a5,a5
    1030:	0007dd63          	bgez	a5,104a <openiputtest+0x5e>
    printf("%s: fork failed\n", s);
    1034:	fd843583          	ld	a1,-40(s0)
    1038:	00007517          	auipc	a0,0x7
    103c:	c8050513          	addi	a0,a0,-896 # 7cb8 <malloc+0x5d4>
    1040:	4bc060ef          	jal	74fc <printf>
    exit(1);
    1044:	4505                	li	a0,1
    1046:	593050ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    104a:	fec42783          	lw	a5,-20(s0)
    104e:	2781                	sext.w	a5,a5
    1050:	ef95                	bnez	a5,108c <openiputtest+0xa0>
    int fd = open("oidir", O_RDWR);
    1052:	4589                	li	a1,2
    1054:	00007517          	auipc	a0,0x7
    1058:	d9450513          	addi	a0,a0,-620 # 7de8 <malloc+0x704>
    105c:	5bd050ef          	jal	6e18 <open>
    1060:	87aa                	mv	a5,a0
    1062:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    1066:	fe842783          	lw	a5,-24(s0)
    106a:	2781                	sext.w	a5,a5
    106c:	0007cd63          	bltz	a5,1086 <openiputtest+0x9a>
      printf("%s: open directory for write succeeded\n", s);
    1070:	fd843583          	ld	a1,-40(s0)
    1074:	00007517          	auipc	a0,0x7
    1078:	d9450513          	addi	a0,a0,-620 # 7e08 <malloc+0x724>
    107c:	480060ef          	jal	74fc <printf>
      exit(1);
    1080:	4505                	li	a0,1
    1082:	557050ef          	jal	6dd8 <exit>
    }
    exit(0);
    1086:	4501                	li	a0,0
    1088:	551050ef          	jal	6dd8 <exit>
  }
  pause(1);
    108c:	4505                	li	a0,1
    108e:	5db050ef          	jal	6e68 <pause>
  if(unlink("oidir") != 0){
    1092:	00007517          	auipc	a0,0x7
    1096:	d5650513          	addi	a0,a0,-682 # 7de8 <malloc+0x704>
    109a:	58f050ef          	jal	6e28 <unlink>
    109e:	87aa                	mv	a5,a0
    10a0:	cf81                	beqz	a5,10b8 <openiputtest+0xcc>
    printf("%s: unlink failed\n", s);
    10a2:	fd843583          	ld	a1,-40(s0)
    10a6:	00007517          	auipc	a0,0x7
    10aa:	d8a50513          	addi	a0,a0,-630 # 7e30 <malloc+0x74c>
    10ae:	44e060ef          	jal	74fc <printf>
    exit(1);
    10b2:	4505                	li	a0,1
    10b4:	525050ef          	jal	6dd8 <exit>
  }
  wait(&xstatus);
    10b8:	fe440793          	addi	a5,s0,-28
    10bc:	853e                	mv	a0,a5
    10be:	523050ef          	jal	6de0 <wait>
  exit(xstatus);
    10c2:	fe442783          	lw	a5,-28(s0)
    10c6:	853e                	mv	a0,a5
    10c8:	511050ef          	jal	6dd8 <exit>

00000000000010cc <opentest>:

// simple file system tests

void
opentest(char *s)
{
    10cc:	7179                	addi	sp,sp,-48
    10ce:	f406                	sd	ra,40(sp)
    10d0:	f022                	sd	s0,32(sp)
    10d2:	1800                	addi	s0,sp,48
    10d4:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    10d8:	4581                	li	a1,0
    10da:	00007517          	auipc	a0,0x7
    10de:	9be50513          	addi	a0,a0,-1602 # 7a98 <malloc+0x3b4>
    10e2:	537050ef          	jal	6e18 <open>
    10e6:	87aa                	mv	a5,a0
    10e8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    10ec:	fec42783          	lw	a5,-20(s0)
    10f0:	2781                	sext.w	a5,a5
    10f2:	0007dd63          	bgez	a5,110c <opentest+0x40>
    printf("%s: open echo failed!\n", s);
    10f6:	fd843583          	ld	a1,-40(s0)
    10fa:	00007517          	auipc	a0,0x7
    10fe:	d4e50513          	addi	a0,a0,-690 # 7e48 <malloc+0x764>
    1102:	3fa060ef          	jal	74fc <printf>
    exit(1);
    1106:	4505                	li	a0,1
    1108:	4d1050ef          	jal	6dd8 <exit>
  }
  close(fd);
    110c:	fec42783          	lw	a5,-20(s0)
    1110:	853e                	mv	a0,a5
    1112:	4ef050ef          	jal	6e00 <close>
  fd = open("doesnotexist", 0);
    1116:	4581                	li	a1,0
    1118:	00007517          	auipc	a0,0x7
    111c:	d4850513          	addi	a0,a0,-696 # 7e60 <malloc+0x77c>
    1120:	4f9050ef          	jal	6e18 <open>
    1124:	87aa                	mv	a5,a0
    1126:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    112a:	fec42783          	lw	a5,-20(s0)
    112e:	2781                	sext.w	a5,a5
    1130:	0007cd63          	bltz	a5,114a <opentest+0x7e>
    printf("%s: open doesnotexist succeeded!\n", s);
    1134:	fd843583          	ld	a1,-40(s0)
    1138:	00007517          	auipc	a0,0x7
    113c:	d3850513          	addi	a0,a0,-712 # 7e70 <malloc+0x78c>
    1140:	3bc060ef          	jal	74fc <printf>
    exit(1);
    1144:	4505                	li	a0,1
    1146:	493050ef          	jal	6dd8 <exit>
  }
}
    114a:	0001                	nop
    114c:	70a2                	ld	ra,40(sp)
    114e:	7402                	ld	s0,32(sp)
    1150:	6145                	addi	sp,sp,48
    1152:	8082                	ret

0000000000001154 <writetest>:

void
writetest(char *s)
{
    1154:	7179                	addi	sp,sp,-48
    1156:	f406                	sd	ra,40(sp)
    1158:	f022                	sd	s0,32(sp)
    115a:	1800                	addi	s0,sp,48
    115c:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };
  
  fd = open("small", O_CREATE|O_RDWR);
    1160:	20200593          	li	a1,514
    1164:	00007517          	auipc	a0,0x7
    1168:	d3450513          	addi	a0,a0,-716 # 7e98 <malloc+0x7b4>
    116c:	4ad050ef          	jal	6e18 <open>
    1170:	87aa                	mv	a5,a0
    1172:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1176:	fe842783          	lw	a5,-24(s0)
    117a:	2781                	sext.w	a5,a5
    117c:	0007dd63          	bgez	a5,1196 <writetest+0x42>
    printf("%s: error: creat small failed!\n", s);
    1180:	fd843583          	ld	a1,-40(s0)
    1184:	00007517          	auipc	a0,0x7
    1188:	d1c50513          	addi	a0,a0,-740 # 7ea0 <malloc+0x7bc>
    118c:	370060ef          	jal	74fc <printf>
    exit(1);
    1190:	4505                	li	a0,1
    1192:	447050ef          	jal	6dd8 <exit>
  }
  for(i = 0; i < N; i++){
    1196:	fe042623          	sw	zero,-20(s0)
    119a:	a041                	j	121a <writetest+0xc6>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    119c:	fe842783          	lw	a5,-24(s0)
    11a0:	4629                	li	a2,10
    11a2:	00007597          	auipc	a1,0x7
    11a6:	d1e58593          	addi	a1,a1,-738 # 7ec0 <malloc+0x7dc>
    11aa:	853e                	mv	a0,a5
    11ac:	44d050ef          	jal	6df8 <write>
    11b0:	87aa                	mv	a5,a0
    11b2:	873e                	mv	a4,a5
    11b4:	47a9                	li	a5,10
    11b6:	02f70063          	beq	a4,a5,11d6 <writetest+0x82>
      printf("%s: error: write aa %d new file failed\n", s, i);
    11ba:	fec42783          	lw	a5,-20(s0)
    11be:	863e                	mv	a2,a5
    11c0:	fd843583          	ld	a1,-40(s0)
    11c4:	00007517          	auipc	a0,0x7
    11c8:	d0c50513          	addi	a0,a0,-756 # 7ed0 <malloc+0x7ec>
    11cc:	330060ef          	jal	74fc <printf>
      exit(1);
    11d0:	4505                	li	a0,1
    11d2:	407050ef          	jal	6dd8 <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    11d6:	fe842783          	lw	a5,-24(s0)
    11da:	4629                	li	a2,10
    11dc:	00007597          	auipc	a1,0x7
    11e0:	d1c58593          	addi	a1,a1,-740 # 7ef8 <malloc+0x814>
    11e4:	853e                	mv	a0,a5
    11e6:	413050ef          	jal	6df8 <write>
    11ea:	87aa                	mv	a5,a0
    11ec:	873e                	mv	a4,a5
    11ee:	47a9                	li	a5,10
    11f0:	02f70063          	beq	a4,a5,1210 <writetest+0xbc>
      printf("%s: error: write bb %d new file failed\n", s, i);
    11f4:	fec42783          	lw	a5,-20(s0)
    11f8:	863e                	mv	a2,a5
    11fa:	fd843583          	ld	a1,-40(s0)
    11fe:	00007517          	auipc	a0,0x7
    1202:	d0a50513          	addi	a0,a0,-758 # 7f08 <malloc+0x824>
    1206:	2f6060ef          	jal	74fc <printf>
      exit(1);
    120a:	4505                	li	a0,1
    120c:	3cd050ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    1210:	fec42783          	lw	a5,-20(s0)
    1214:	2785                	addiw	a5,a5,1
    1216:	fef42623          	sw	a5,-20(s0)
    121a:	fec42783          	lw	a5,-20(s0)
    121e:	0007871b          	sext.w	a4,a5
    1222:	06300793          	li	a5,99
    1226:	f6e7dbe3          	bge	a5,a4,119c <writetest+0x48>
    }
  }
  close(fd);
    122a:	fe842783          	lw	a5,-24(s0)
    122e:	853e                	mv	a0,a5
    1230:	3d1050ef          	jal	6e00 <close>
  fd = open("small", O_RDONLY);
    1234:	4581                	li	a1,0
    1236:	00007517          	auipc	a0,0x7
    123a:	c6250513          	addi	a0,a0,-926 # 7e98 <malloc+0x7b4>
    123e:	3db050ef          	jal	6e18 <open>
    1242:	87aa                	mv	a5,a0
    1244:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1248:	fe842783          	lw	a5,-24(s0)
    124c:	2781                	sext.w	a5,a5
    124e:	0007dd63          	bgez	a5,1268 <writetest+0x114>
    printf("%s: error: open small failed!\n", s);
    1252:	fd843583          	ld	a1,-40(s0)
    1256:	00007517          	auipc	a0,0x7
    125a:	cda50513          	addi	a0,a0,-806 # 7f30 <malloc+0x84c>
    125e:	29e060ef          	jal	74fc <printf>
    exit(1);
    1262:	4505                	li	a0,1
    1264:	375050ef          	jal	6dd8 <exit>
  }
  i = read(fd, buf, N*SZ*2);
    1268:	fe842783          	lw	a5,-24(s0)
    126c:	7d000613          	li	a2,2000
    1270:	00009597          	auipc	a1,0x9
    1274:	24058593          	addi	a1,a1,576 # a4b0 <buf>
    1278:	853e                	mv	a0,a5
    127a:	377050ef          	jal	6df0 <read>
    127e:	87aa                	mv	a5,a0
    1280:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    1284:	fec42783          	lw	a5,-20(s0)
    1288:	0007871b          	sext.w	a4,a5
    128c:	7d000793          	li	a5,2000
    1290:	00f70d63          	beq	a4,a5,12aa <writetest+0x156>
    printf("%s: read failed\n", s);
    1294:	fd843583          	ld	a1,-40(s0)
    1298:	00007517          	auipc	a0,0x7
    129c:	cb850513          	addi	a0,a0,-840 # 7f50 <malloc+0x86c>
    12a0:	25c060ef          	jal	74fc <printf>
    exit(1);
    12a4:	4505                	li	a0,1
    12a6:	333050ef          	jal	6dd8 <exit>
  }
  close(fd);
    12aa:	fe842783          	lw	a5,-24(s0)
    12ae:	853e                	mv	a0,a5
    12b0:	351050ef          	jal	6e00 <close>

  if(unlink("small") < 0){
    12b4:	00007517          	auipc	a0,0x7
    12b8:	be450513          	addi	a0,a0,-1052 # 7e98 <malloc+0x7b4>
    12bc:	36d050ef          	jal	6e28 <unlink>
    12c0:	87aa                	mv	a5,a0
    12c2:	0007dd63          	bgez	a5,12dc <writetest+0x188>
    printf("%s: unlink small failed\n", s);
    12c6:	fd843583          	ld	a1,-40(s0)
    12ca:	00007517          	auipc	a0,0x7
    12ce:	c9e50513          	addi	a0,a0,-866 # 7f68 <malloc+0x884>
    12d2:	22a060ef          	jal	74fc <printf>
    exit(1);
    12d6:	4505                	li	a0,1
    12d8:	301050ef          	jal	6dd8 <exit>
  }
}
    12dc:	0001                	nop
    12de:	70a2                	ld	ra,40(sp)
    12e0:	7402                	ld	s0,32(sp)
    12e2:	6145                	addi	sp,sp,48
    12e4:	8082                	ret

00000000000012e6 <writebig>:

void
writebig(char *s)
{
    12e6:	7179                	addi	sp,sp,-48
    12e8:	f406                	sd	ra,40(sp)
    12ea:	f022                	sd	s0,32(sp)
    12ec:	1800                	addi	s0,sp,48
    12ee:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    12f2:	20200593          	li	a1,514
    12f6:	00007517          	auipc	a0,0x7
    12fa:	c9250513          	addi	a0,a0,-878 # 7f88 <malloc+0x8a4>
    12fe:	31b050ef          	jal	6e18 <open>
    1302:	87aa                	mv	a5,a0
    1304:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1308:	fe442783          	lw	a5,-28(s0)
    130c:	2781                	sext.w	a5,a5
    130e:	0007dd63          	bgez	a5,1328 <writebig+0x42>
    printf("%s: error: creat big failed!\n", s);
    1312:	fd843583          	ld	a1,-40(s0)
    1316:	00007517          	auipc	a0,0x7
    131a:	c7a50513          	addi	a0,a0,-902 # 7f90 <malloc+0x8ac>
    131e:	1de060ef          	jal	74fc <printf>
    exit(1);
    1322:	4505                	li	a0,1
    1324:	2b5050ef          	jal	6dd8 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    1328:	fe042623          	sw	zero,-20(s0)
    132c:	a8a1                	j	1384 <writebig+0x9e>
    ((int*)buf)[0] = i;
    132e:	00009797          	auipc	a5,0x9
    1332:	18278793          	addi	a5,a5,386 # a4b0 <buf>
    1336:	fec42703          	lw	a4,-20(s0)
    133a:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    133c:	fe442783          	lw	a5,-28(s0)
    1340:	40000613          	li	a2,1024
    1344:	00009597          	auipc	a1,0x9
    1348:	16c58593          	addi	a1,a1,364 # a4b0 <buf>
    134c:	853e                	mv	a0,a5
    134e:	2ab050ef          	jal	6df8 <write>
    1352:	87aa                	mv	a5,a0
    1354:	873e                	mv	a4,a5
    1356:	40000793          	li	a5,1024
    135a:	02f70063          	beq	a4,a5,137a <writebig+0x94>
      printf("%s: error: write big file failed i=%d\n", s, i);
    135e:	fec42783          	lw	a5,-20(s0)
    1362:	863e                	mv	a2,a5
    1364:	fd843583          	ld	a1,-40(s0)
    1368:	00007517          	auipc	a0,0x7
    136c:	c4850513          	addi	a0,a0,-952 # 7fb0 <malloc+0x8cc>
    1370:	18c060ef          	jal	74fc <printf>
      exit(1);
    1374:	4505                	li	a0,1
    1376:	263050ef          	jal	6dd8 <exit>
  for(i = 0; i < MAXFILE; i++){
    137a:	fec42783          	lw	a5,-20(s0)
    137e:	2785                	addiw	a5,a5,1
    1380:	fef42623          	sw	a5,-20(s0)
    1384:	fec42703          	lw	a4,-20(s0)
    1388:	10b00793          	li	a5,267
    138c:	fae7f1e3          	bgeu	a5,a4,132e <writebig+0x48>
    }
  }

  close(fd);
    1390:	fe442783          	lw	a5,-28(s0)
    1394:	853e                	mv	a0,a5
    1396:	26b050ef          	jal	6e00 <close>

  fd = open("big", O_RDONLY);
    139a:	4581                	li	a1,0
    139c:	00007517          	auipc	a0,0x7
    13a0:	bec50513          	addi	a0,a0,-1044 # 7f88 <malloc+0x8a4>
    13a4:	275050ef          	jal	6e18 <open>
    13a8:	87aa                	mv	a5,a0
    13aa:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    13ae:	fe442783          	lw	a5,-28(s0)
    13b2:	2781                	sext.w	a5,a5
    13b4:	0007dd63          	bgez	a5,13ce <writebig+0xe8>
    printf("%s: error: open big failed!\n", s);
    13b8:	fd843583          	ld	a1,-40(s0)
    13bc:	00007517          	auipc	a0,0x7
    13c0:	c1c50513          	addi	a0,a0,-996 # 7fd8 <malloc+0x8f4>
    13c4:	138060ef          	jal	74fc <printf>
    exit(1);
    13c8:	4505                	li	a0,1
    13ca:	20f050ef          	jal	6dd8 <exit>
  }

  n = 0;
    13ce:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    13d2:	fe442783          	lw	a5,-28(s0)
    13d6:	40000613          	li	a2,1024
    13da:	00009597          	auipc	a1,0x9
    13de:	0d658593          	addi	a1,a1,214 # a4b0 <buf>
    13e2:	853e                	mv	a0,a5
    13e4:	20d050ef          	jal	6df0 <read>
    13e8:	87aa                	mv	a5,a0
    13ea:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    13ee:	fec42783          	lw	a5,-20(s0)
    13f2:	2781                	sext.w	a5,a5
    13f4:	e79d                	bnez	a5,1422 <writebig+0x13c>
      if(n != MAXFILE){
    13f6:	fe842783          	lw	a5,-24(s0)
    13fa:	0007871b          	sext.w	a4,a5
    13fe:	10c00793          	li	a5,268
    1402:	08f70a63          	beq	a4,a5,1496 <writebig+0x1b0>
        printf("%s: read only %d blocks from big", s, n);
    1406:	fe842783          	lw	a5,-24(s0)
    140a:	863e                	mv	a2,a5
    140c:	fd843583          	ld	a1,-40(s0)
    1410:	00007517          	auipc	a0,0x7
    1414:	be850513          	addi	a0,a0,-1048 # 7ff8 <malloc+0x914>
    1418:	0e4060ef          	jal	74fc <printf>
        exit(1);
    141c:	4505                	li	a0,1
    141e:	1bb050ef          	jal	6dd8 <exit>
      }
      break;
    } else if(i != BSIZE){
    1422:	fec42783          	lw	a5,-20(s0)
    1426:	0007871b          	sext.w	a4,a5
    142a:	40000793          	li	a5,1024
    142e:	02f70063          	beq	a4,a5,144e <writebig+0x168>
      printf("%s: read failed %d\n", s, i);
    1432:	fec42783          	lw	a5,-20(s0)
    1436:	863e                	mv	a2,a5
    1438:	fd843583          	ld	a1,-40(s0)
    143c:	00007517          	auipc	a0,0x7
    1440:	be450513          	addi	a0,a0,-1052 # 8020 <malloc+0x93c>
    1444:	0b8060ef          	jal	74fc <printf>
      exit(1);
    1448:	4505                	li	a0,1
    144a:	18f050ef          	jal	6dd8 <exit>
    }
    if(((int*)buf)[0] != n){
    144e:	00009797          	auipc	a5,0x9
    1452:	06278793          	addi	a5,a5,98 # a4b0 <buf>
    1456:	439c                	lw	a5,0(a5)
    1458:	fe842703          	lw	a4,-24(s0)
    145c:	2701                	sext.w	a4,a4
    145e:	02f70663          	beq	a4,a5,148a <writebig+0x1a4>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    1462:	00009797          	auipc	a5,0x9
    1466:	04e78793          	addi	a5,a5,78 # a4b0 <buf>
      printf("%s: read content of block %d is %d\n", s,
    146a:	4398                	lw	a4,0(a5)
    146c:	fe842783          	lw	a5,-24(s0)
    1470:	86ba                	mv	a3,a4
    1472:	863e                	mv	a2,a5
    1474:	fd843583          	ld	a1,-40(s0)
    1478:	00007517          	auipc	a0,0x7
    147c:	bc050513          	addi	a0,a0,-1088 # 8038 <malloc+0x954>
    1480:	07c060ef          	jal	74fc <printf>
      exit(1);
    1484:	4505                	li	a0,1
    1486:	153050ef          	jal	6dd8 <exit>
    }
    n++;
    148a:	fe842783          	lw	a5,-24(s0)
    148e:	2785                	addiw	a5,a5,1
    1490:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1494:	bf3d                	j	13d2 <writebig+0xec>
      break;
    1496:	0001                	nop
  }
  close(fd);
    1498:	fe442783          	lw	a5,-28(s0)
    149c:	853e                	mv	a0,a5
    149e:	163050ef          	jal	6e00 <close>
  if(unlink("big") < 0){
    14a2:	00007517          	auipc	a0,0x7
    14a6:	ae650513          	addi	a0,a0,-1306 # 7f88 <malloc+0x8a4>
    14aa:	17f050ef          	jal	6e28 <unlink>
    14ae:	87aa                	mv	a5,a0
    14b0:	0007dd63          	bgez	a5,14ca <writebig+0x1e4>
    printf("%s: unlink big failed\n", s);
    14b4:	fd843583          	ld	a1,-40(s0)
    14b8:	00007517          	auipc	a0,0x7
    14bc:	ba850513          	addi	a0,a0,-1112 # 8060 <malloc+0x97c>
    14c0:	03c060ef          	jal	74fc <printf>
    exit(1);
    14c4:	4505                	li	a0,1
    14c6:	113050ef          	jal	6dd8 <exit>
  }
}
    14ca:	0001                	nop
    14cc:	70a2                	ld	ra,40(sp)
    14ce:	7402                	ld	s0,32(sp)
    14d0:	6145                	addi	sp,sp,48
    14d2:	8082                	ret

00000000000014d4 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    14d4:	7179                	addi	sp,sp,-48
    14d6:	f406                	sd	ra,40(sp)
    14d8:	f022                	sd	s0,32(sp)
    14da:	1800                	addi	s0,sp,48
    14dc:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    14e0:	06100793          	li	a5,97
    14e4:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    14e8:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    14ec:	fe042623          	sw	zero,-20(s0)
    14f0:	a83d                	j	152e <createtest+0x5a>
    name[1] = '0' + i;
    14f2:	fec42783          	lw	a5,-20(s0)
    14f6:	0ff7f793          	zext.b	a5,a5
    14fa:	0307879b          	addiw	a5,a5,48
    14fe:	0ff7f793          	zext.b	a5,a5
    1502:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    1506:	fe040793          	addi	a5,s0,-32
    150a:	20200593          	li	a1,514
    150e:	853e                	mv	a0,a5
    1510:	109050ef          	jal	6e18 <open>
    1514:	87aa                	mv	a5,a0
    1516:	fef42423          	sw	a5,-24(s0)
    close(fd);
    151a:	fe842783          	lw	a5,-24(s0)
    151e:	853e                	mv	a0,a5
    1520:	0e1050ef          	jal	6e00 <close>
  for(i = 0; i < N; i++){
    1524:	fec42783          	lw	a5,-20(s0)
    1528:	2785                	addiw	a5,a5,1
    152a:	fef42623          	sw	a5,-20(s0)
    152e:	fec42783          	lw	a5,-20(s0)
    1532:	0007871b          	sext.w	a4,a5
    1536:	03300793          	li	a5,51
    153a:	fae7dce3          	bge	a5,a4,14f2 <createtest+0x1e>
  }
  name[0] = 'a';
    153e:	06100793          	li	a5,97
    1542:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    1546:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    154a:	fe042623          	sw	zero,-20(s0)
    154e:	a02d                	j	1578 <createtest+0xa4>
    name[1] = '0' + i;
    1550:	fec42783          	lw	a5,-20(s0)
    1554:	0ff7f793          	zext.b	a5,a5
    1558:	0307879b          	addiw	a5,a5,48
    155c:	0ff7f793          	zext.b	a5,a5
    1560:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    1564:	fe040793          	addi	a5,s0,-32
    1568:	853e                	mv	a0,a5
    156a:	0bf050ef          	jal	6e28 <unlink>
  for(i = 0; i < N; i++){
    156e:	fec42783          	lw	a5,-20(s0)
    1572:	2785                	addiw	a5,a5,1
    1574:	fef42623          	sw	a5,-20(s0)
    1578:	fec42783          	lw	a5,-20(s0)
    157c:	0007871b          	sext.w	a4,a5
    1580:	03300793          	li	a5,51
    1584:	fce7d6e3          	bge	a5,a4,1550 <createtest+0x7c>
  }
}
    1588:	0001                	nop
    158a:	0001                	nop
    158c:	70a2                	ld	ra,40(sp)
    158e:	7402                	ld	s0,32(sp)
    1590:	6145                	addi	sp,sp,48
    1592:	8082                	ret

0000000000001594 <dirtest>:

void dirtest(char *s)
{
    1594:	1101                	addi	sp,sp,-32
    1596:	ec06                	sd	ra,24(sp)
    1598:	e822                	sd	s0,16(sp)
    159a:	1000                	addi	s0,sp,32
    159c:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    15a0:	00007517          	auipc	a0,0x7
    15a4:	ad850513          	addi	a0,a0,-1320 # 8078 <malloc+0x994>
    15a8:	099050ef          	jal	6e40 <mkdir>
    15ac:	87aa                	mv	a5,a0
    15ae:	0007dd63          	bgez	a5,15c8 <dirtest+0x34>
    printf("%s: mkdir failed\n", s);
    15b2:	fe843583          	ld	a1,-24(s0)
    15b6:	00006517          	auipc	a0,0x6
    15ba:	79250513          	addi	a0,a0,1938 # 7d48 <malloc+0x664>
    15be:	73f050ef          	jal	74fc <printf>
    exit(1);
    15c2:	4505                	li	a0,1
    15c4:	015050ef          	jal	6dd8 <exit>
  }

  if(chdir("dir0") < 0){
    15c8:	00007517          	auipc	a0,0x7
    15cc:	ab050513          	addi	a0,a0,-1360 # 8078 <malloc+0x994>
    15d0:	079050ef          	jal	6e48 <chdir>
    15d4:	87aa                	mv	a5,a0
    15d6:	0007dd63          	bgez	a5,15f0 <dirtest+0x5c>
    printf("%s: chdir dir0 failed\n", s);
    15da:	fe843583          	ld	a1,-24(s0)
    15de:	00007517          	auipc	a0,0x7
    15e2:	aa250513          	addi	a0,a0,-1374 # 8080 <malloc+0x99c>
    15e6:	717050ef          	jal	74fc <printf>
    exit(1);
    15ea:	4505                	li	a0,1
    15ec:	7ec050ef          	jal	6dd8 <exit>
  }

  if(chdir("..") < 0){
    15f0:	00007517          	auipc	a0,0x7
    15f4:	aa850513          	addi	a0,a0,-1368 # 8098 <malloc+0x9b4>
    15f8:	051050ef          	jal	6e48 <chdir>
    15fc:	87aa                	mv	a5,a0
    15fe:	0007dd63          	bgez	a5,1618 <dirtest+0x84>
    printf("%s: chdir .. failed\n", s);
    1602:	fe843583          	ld	a1,-24(s0)
    1606:	00007517          	auipc	a0,0x7
    160a:	a9a50513          	addi	a0,a0,-1382 # 80a0 <malloc+0x9bc>
    160e:	6ef050ef          	jal	74fc <printf>
    exit(1);
    1612:	4505                	li	a0,1
    1614:	7c4050ef          	jal	6dd8 <exit>
  }

  if(unlink("dir0") < 0){
    1618:	00007517          	auipc	a0,0x7
    161c:	a6050513          	addi	a0,a0,-1440 # 8078 <malloc+0x994>
    1620:	009050ef          	jal	6e28 <unlink>
    1624:	87aa                	mv	a5,a0
    1626:	0007dd63          	bgez	a5,1640 <dirtest+0xac>
    printf("%s: unlink dir0 failed\n", s);
    162a:	fe843583          	ld	a1,-24(s0)
    162e:	00007517          	auipc	a0,0x7
    1632:	a8a50513          	addi	a0,a0,-1398 # 80b8 <malloc+0x9d4>
    1636:	6c7050ef          	jal	74fc <printf>
    exit(1);
    163a:	4505                	li	a0,1
    163c:	79c050ef          	jal	6dd8 <exit>
  }
}
    1640:	0001                	nop
    1642:	60e2                	ld	ra,24(sp)
    1644:	6442                	ld	s0,16(sp)
    1646:	6105                	addi	sp,sp,32
    1648:	8082                	ret

000000000000164a <exectest>:

void
exectest(char *s)
{
    164a:	715d                	addi	sp,sp,-80
    164c:	e486                	sd	ra,72(sp)
    164e:	e0a2                	sd	s0,64(sp)
    1650:	0880                	addi	s0,sp,80
    1652:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1656:	00006797          	auipc	a5,0x6
    165a:	44278793          	addi	a5,a5,1090 # 7a98 <malloc+0x3b4>
    165e:	fcf43423          	sd	a5,-56(s0)
    1662:	00007797          	auipc	a5,0x7
    1666:	a6e78793          	addi	a5,a5,-1426 # 80d0 <malloc+0x9ec>
    166a:	fcf43823          	sd	a5,-48(s0)
    166e:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1672:	00007517          	auipc	a0,0x7
    1676:	a6650513          	addi	a0,a0,-1434 # 80d8 <malloc+0x9f4>
    167a:	7ae050ef          	jal	6e28 <unlink>
  pid = fork();
    167e:	752050ef          	jal	6dd0 <fork>
    1682:	87aa                	mv	a5,a0
    1684:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1688:	fec42783          	lw	a5,-20(s0)
    168c:	2781                	sext.w	a5,a5
    168e:	0007dd63          	bgez	a5,16a8 <exectest+0x5e>
     printf("%s: fork failed\n", s);
    1692:	fb843583          	ld	a1,-72(s0)
    1696:	00006517          	auipc	a0,0x6
    169a:	62250513          	addi	a0,a0,1570 # 7cb8 <malloc+0x5d4>
    169e:	65f050ef          	jal	74fc <printf>
     exit(1);
    16a2:	4505                	li	a0,1
    16a4:	734050ef          	jal	6dd8 <exit>
  }
  if(pid == 0) {
    16a8:	fec42783          	lw	a5,-20(s0)
    16ac:	2781                	sext.w	a5,a5
    16ae:	ebc1                	bnez	a5,173e <exectest+0xf4>
    close(1);
    16b0:	4505                	li	a0,1
    16b2:	74e050ef          	jal	6e00 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    16b6:	20100593          	li	a1,513
    16ba:	00007517          	auipc	a0,0x7
    16be:	a1e50513          	addi	a0,a0,-1506 # 80d8 <malloc+0x9f4>
    16c2:	756050ef          	jal	6e18 <open>
    16c6:	87aa                	mv	a5,a0
    16c8:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    16cc:	fe842783          	lw	a5,-24(s0)
    16d0:	2781                	sext.w	a5,a5
    16d2:	0007dd63          	bgez	a5,16ec <exectest+0xa2>
      printf("%s: create failed\n", s);
    16d6:	fb843583          	ld	a1,-72(s0)
    16da:	00007517          	auipc	a0,0x7
    16de:	a0650513          	addi	a0,a0,-1530 # 80e0 <malloc+0x9fc>
    16e2:	61b050ef          	jal	74fc <printf>
      exit(1);
    16e6:	4505                	li	a0,1
    16e8:	6f0050ef          	jal	6dd8 <exit>
    }
    if(fd != 1) {
    16ec:	fe842783          	lw	a5,-24(s0)
    16f0:	0007871b          	sext.w	a4,a5
    16f4:	4785                	li	a5,1
    16f6:	00f70d63          	beq	a4,a5,1710 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    16fa:	fb843583          	ld	a1,-72(s0)
    16fe:	00007517          	auipc	a0,0x7
    1702:	9fa50513          	addi	a0,a0,-1542 # 80f8 <malloc+0xa14>
    1706:	5f7050ef          	jal	74fc <printf>
      exit(1);
    170a:	4505                	li	a0,1
    170c:	6cc050ef          	jal	6dd8 <exit>
    }
    if(exec("echo", echoargv) < 0){
    1710:	fc840793          	addi	a5,s0,-56
    1714:	85be                	mv	a1,a5
    1716:	00006517          	auipc	a0,0x6
    171a:	38250513          	addi	a0,a0,898 # 7a98 <malloc+0x3b4>
    171e:	6f2050ef          	jal	6e10 <exec>
    1722:	87aa                	mv	a5,a0
    1724:	0007dd63          	bgez	a5,173e <exectest+0xf4>
      printf("%s: exec echo failed\n", s);
    1728:	fb843583          	ld	a1,-72(s0)
    172c:	00007517          	auipc	a0,0x7
    1730:	9dc50513          	addi	a0,a0,-1572 # 8108 <malloc+0xa24>
    1734:	5c9050ef          	jal	74fc <printf>
      exit(1);
    1738:	4505                	li	a0,1
    173a:	69e050ef          	jal	6dd8 <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    173e:	fe440793          	addi	a5,s0,-28
    1742:	853e                	mv	a0,a5
    1744:	69c050ef          	jal	6de0 <wait>
    1748:	87aa                	mv	a5,a0
    174a:	873e                	mv	a4,a5
    174c:	fec42783          	lw	a5,-20(s0)
    1750:	2781                	sext.w	a5,a5
    1752:	00e78a63          	beq	a5,a4,1766 <exectest+0x11c>
    printf("%s: wait failed!\n", s);
    1756:	fb843583          	ld	a1,-72(s0)
    175a:	00007517          	auipc	a0,0x7
    175e:	9c650513          	addi	a0,a0,-1594 # 8120 <malloc+0xa3c>
    1762:	59b050ef          	jal	74fc <printf>
  }
  if(xstatus != 0)
    1766:	fe442783          	lw	a5,-28(s0)
    176a:	c791                	beqz	a5,1776 <exectest+0x12c>
    exit(xstatus);
    176c:	fe442783          	lw	a5,-28(s0)
    1770:	853e                	mv	a0,a5
    1772:	666050ef          	jal	6dd8 <exit>

  fd = open("echo-ok", O_RDONLY);
    1776:	4581                	li	a1,0
    1778:	00007517          	auipc	a0,0x7
    177c:	96050513          	addi	a0,a0,-1696 # 80d8 <malloc+0x9f4>
    1780:	698050ef          	jal	6e18 <open>
    1784:	87aa                	mv	a5,a0
    1786:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    178a:	fe842783          	lw	a5,-24(s0)
    178e:	2781                	sext.w	a5,a5
    1790:	0007dd63          	bgez	a5,17aa <exectest+0x160>
    printf("%s: open failed\n", s);
    1794:	fb843583          	ld	a1,-72(s0)
    1798:	00006517          	auipc	a0,0x6
    179c:	53850513          	addi	a0,a0,1336 # 7cd0 <malloc+0x5ec>
    17a0:	55d050ef          	jal	74fc <printf>
    exit(1);
    17a4:	4505                	li	a0,1
    17a6:	632050ef          	jal	6dd8 <exit>
  }
  if (read(fd, buf, 2) != 2) {
    17aa:	fc040713          	addi	a4,s0,-64
    17ae:	fe842783          	lw	a5,-24(s0)
    17b2:	4609                	li	a2,2
    17b4:	85ba                	mv	a1,a4
    17b6:	853e                	mv	a0,a5
    17b8:	638050ef          	jal	6df0 <read>
    17bc:	87aa                	mv	a5,a0
    17be:	873e                	mv	a4,a5
    17c0:	4789                	li	a5,2
    17c2:	00f70d63          	beq	a4,a5,17dc <exectest+0x192>
    printf("%s: read failed\n", s);
    17c6:	fb843583          	ld	a1,-72(s0)
    17ca:	00006517          	auipc	a0,0x6
    17ce:	78650513          	addi	a0,a0,1926 # 7f50 <malloc+0x86c>
    17d2:	52b050ef          	jal	74fc <printf>
    exit(1);
    17d6:	4505                	li	a0,1
    17d8:	600050ef          	jal	6dd8 <exit>
  }
  unlink("echo-ok");
    17dc:	00007517          	auipc	a0,0x7
    17e0:	8fc50513          	addi	a0,a0,-1796 # 80d8 <malloc+0x9f4>
    17e4:	644050ef          	jal	6e28 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    17e8:	fc044783          	lbu	a5,-64(s0)
    17ec:	873e                	mv	a4,a5
    17ee:	04f00793          	li	a5,79
    17f2:	00f71c63          	bne	a4,a5,180a <exectest+0x1c0>
    17f6:	fc144783          	lbu	a5,-63(s0)
    17fa:	873e                	mv	a4,a5
    17fc:	04b00793          	li	a5,75
    1800:	00f71563          	bne	a4,a5,180a <exectest+0x1c0>
    exit(0);
    1804:	4501                	li	a0,0
    1806:	5d2050ef          	jal	6dd8 <exit>
  else {
    printf("%s: wrong output\n", s);
    180a:	fb843583          	ld	a1,-72(s0)
    180e:	00007517          	auipc	a0,0x7
    1812:	92a50513          	addi	a0,a0,-1750 # 8138 <malloc+0xa54>
    1816:	4e7050ef          	jal	74fc <printf>
    exit(1);
    181a:	4505                	li	a0,1
    181c:	5bc050ef          	jal	6dd8 <exit>

0000000000001820 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1820:	715d                	addi	sp,sp,-80
    1822:	e486                	sd	ra,72(sp)
    1824:	e0a2                	sd	s0,64(sp)
    1826:	0880                	addi	s0,sp,80
    1828:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };
  
  if(pipe(fds) != 0){
    182c:	fd040793          	addi	a5,s0,-48
    1830:	853e                	mv	a0,a5
    1832:	5b6050ef          	jal	6de8 <pipe>
    1836:	87aa                	mv	a5,a0
    1838:	cf81                	beqz	a5,1850 <pipe1+0x30>
    printf("%s: pipe() failed\n", s);
    183a:	fb843583          	ld	a1,-72(s0)
    183e:	00007517          	auipc	a0,0x7
    1842:	91250513          	addi	a0,a0,-1774 # 8150 <malloc+0xa6c>
    1846:	4b7050ef          	jal	74fc <printf>
    exit(1);
    184a:	4505                	li	a0,1
    184c:	58c050ef          	jal	6dd8 <exit>
  }
  pid = fork();
    1850:	580050ef          	jal	6dd0 <fork>
    1854:	87aa                	mv	a5,a0
    1856:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    185a:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    185e:	fd842783          	lw	a5,-40(s0)
    1862:	2781                	sext.w	a5,a5
    1864:	e7cd                	bnez	a5,190e <pipe1+0xee>
    close(fds[0]);
    1866:	fd042783          	lw	a5,-48(s0)
    186a:	853e                	mv	a0,a5
    186c:	594050ef          	jal	6e00 <close>
    for(n = 0; n < N; n++){
    1870:	fe042223          	sw	zero,-28(s0)
    1874:	a059                	j	18fa <pipe1+0xda>
      for(i = 0; i < SZ; i++)
    1876:	fe042423          	sw	zero,-24(s0)
    187a:	a03d                	j	18a8 <pipe1+0x88>
        buf[i] = seq++;
    187c:	fec42783          	lw	a5,-20(s0)
    1880:	0017871b          	addiw	a4,a5,1
    1884:	fee42623          	sw	a4,-20(s0)
    1888:	0ff7f713          	zext.b	a4,a5
    188c:	00009697          	auipc	a3,0x9
    1890:	c2468693          	addi	a3,a3,-988 # a4b0 <buf>
    1894:	fe842783          	lw	a5,-24(s0)
    1898:	97b6                	add	a5,a5,a3
    189a:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    189e:	fe842783          	lw	a5,-24(s0)
    18a2:	2785                	addiw	a5,a5,1
    18a4:	fef42423          	sw	a5,-24(s0)
    18a8:	fe842783          	lw	a5,-24(s0)
    18ac:	0007871b          	sext.w	a4,a5
    18b0:	40800793          	li	a5,1032
    18b4:	fce7d4e3          	bge	a5,a4,187c <pipe1+0x5c>
      if(write(fds[1], buf, SZ) != SZ){
    18b8:	fd442783          	lw	a5,-44(s0)
    18bc:	40900613          	li	a2,1033
    18c0:	00009597          	auipc	a1,0x9
    18c4:	bf058593          	addi	a1,a1,-1040 # a4b0 <buf>
    18c8:	853e                	mv	a0,a5
    18ca:	52e050ef          	jal	6df8 <write>
    18ce:	87aa                	mv	a5,a0
    18d0:	873e                	mv	a4,a5
    18d2:	40900793          	li	a5,1033
    18d6:	00f70d63          	beq	a4,a5,18f0 <pipe1+0xd0>
        printf("%s: pipe1 oops 1\n", s);
    18da:	fb843583          	ld	a1,-72(s0)
    18de:	00007517          	auipc	a0,0x7
    18e2:	88a50513          	addi	a0,a0,-1910 # 8168 <malloc+0xa84>
    18e6:	417050ef          	jal	74fc <printf>
        exit(1);
    18ea:	4505                	li	a0,1
    18ec:	4ec050ef          	jal	6dd8 <exit>
    for(n = 0; n < N; n++){
    18f0:	fe442783          	lw	a5,-28(s0)
    18f4:	2785                	addiw	a5,a5,1
    18f6:	fef42223          	sw	a5,-28(s0)
    18fa:	fe442783          	lw	a5,-28(s0)
    18fe:	0007871b          	sext.w	a4,a5
    1902:	4791                	li	a5,4
    1904:	f6e7d9e3          	bge	a5,a4,1876 <pipe1+0x56>
      }
    }
    exit(0);
    1908:	4501                	li	a0,0
    190a:	4ce050ef          	jal	6dd8 <exit>
  } else if(pid > 0){
    190e:	fd842783          	lw	a5,-40(s0)
    1912:	2781                	sext.w	a5,a5
    1914:	10f05d63          	blez	a5,1a2e <pipe1+0x20e>
    close(fds[1]);
    1918:	fd442783          	lw	a5,-44(s0)
    191c:	853e                	mv	a0,a5
    191e:	4e2050ef          	jal	6e00 <close>
    total = 0;
    1922:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1926:	4785                	li	a5,1
    1928:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    192c:	a079                	j	19ba <pipe1+0x19a>
      for(i = 0; i < n; i++){
    192e:	fe042423          	sw	zero,-24(s0)
    1932:	a0a9                	j	197c <pipe1+0x15c>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1934:	00009717          	auipc	a4,0x9
    1938:	b7c70713          	addi	a4,a4,-1156 # a4b0 <buf>
    193c:	fe842783          	lw	a5,-24(s0)
    1940:	97ba                	add	a5,a5,a4
    1942:	0007c783          	lbu	a5,0(a5)
    1946:	0007871b          	sext.w	a4,a5
    194a:	fec42783          	lw	a5,-20(s0)
    194e:	0017869b          	addiw	a3,a5,1
    1952:	fed42623          	sw	a3,-20(s0)
    1956:	0ff7f793          	zext.b	a5,a5
    195a:	2781                	sext.w	a5,a5
    195c:	00f70b63          	beq	a4,a5,1972 <pipe1+0x152>
          printf("%s: pipe1 oops 2\n", s);
    1960:	fb843583          	ld	a1,-72(s0)
    1964:	00007517          	auipc	a0,0x7
    1968:	81c50513          	addi	a0,a0,-2020 # 8180 <malloc+0xa9c>
    196c:	391050ef          	jal	74fc <printf>
          return;
    1970:	a8d1                	j	1a44 <pipe1+0x224>
      for(i = 0; i < n; i++){
    1972:	fe842783          	lw	a5,-24(s0)
    1976:	2785                	addiw	a5,a5,1
    1978:	fef42423          	sw	a5,-24(s0)
    197c:	fe842783          	lw	a5,-24(s0)
    1980:	873e                	mv	a4,a5
    1982:	fe442783          	lw	a5,-28(s0)
    1986:	2701                	sext.w	a4,a4
    1988:	2781                	sext.w	a5,a5
    198a:	faf745e3          	blt	a4,a5,1934 <pipe1+0x114>
        }
      }
      total += n;
    198e:	fdc42783          	lw	a5,-36(s0)
    1992:	873e                	mv	a4,a5
    1994:	fe442783          	lw	a5,-28(s0)
    1998:	9fb9                	addw	a5,a5,a4
    199a:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    199e:	fe042783          	lw	a5,-32(s0)
    19a2:	0017979b          	slliw	a5,a5,0x1
    19a6:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    19aa:	fe042703          	lw	a4,-32(s0)
    19ae:	678d                	lui	a5,0x3
    19b0:	00e7f563          	bgeu	a5,a4,19ba <pipe1+0x19a>
        cc = sizeof(buf);
    19b4:	678d                	lui	a5,0x3
    19b6:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    19ba:	fd042783          	lw	a5,-48(s0)
    19be:	fe042703          	lw	a4,-32(s0)
    19c2:	863a                	mv	a2,a4
    19c4:	00009597          	auipc	a1,0x9
    19c8:	aec58593          	addi	a1,a1,-1300 # a4b0 <buf>
    19cc:	853e                	mv	a0,a5
    19ce:	422050ef          	jal	6df0 <read>
    19d2:	87aa                	mv	a5,a0
    19d4:	fef42223          	sw	a5,-28(s0)
    19d8:	fe442783          	lw	a5,-28(s0)
    19dc:	2781                	sext.w	a5,a5
    19de:	f4f048e3          	bgtz	a5,192e <pipe1+0x10e>
    }
    if(total != N * SZ){
    19e2:	fdc42783          	lw	a5,-36(s0)
    19e6:	0007871b          	sext.w	a4,a5
    19ea:	6785                	lui	a5,0x1
    19ec:	42d78793          	addi	a5,a5,1069 # 142d <writebig+0x147>
    19f0:	02f70063          	beq	a4,a5,1a10 <pipe1+0x1f0>
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    19f4:	fdc42783          	lw	a5,-36(s0)
    19f8:	863e                	mv	a2,a5
    19fa:	fb843583          	ld	a1,-72(s0)
    19fe:	00006517          	auipc	a0,0x6
    1a02:	79a50513          	addi	a0,a0,1946 # 8198 <malloc+0xab4>
    1a06:	2f7050ef          	jal	74fc <printf>
      exit(1);
    1a0a:	4505                	li	a0,1
    1a0c:	3cc050ef          	jal	6dd8 <exit>
    }
    close(fds[0]);
    1a10:	fd042783          	lw	a5,-48(s0)
    1a14:	853e                	mv	a0,a5
    1a16:	3ea050ef          	jal	6e00 <close>
    wait(&xstatus);
    1a1a:	fcc40793          	addi	a5,s0,-52
    1a1e:	853e                	mv	a0,a5
    1a20:	3c0050ef          	jal	6de0 <wait>
    exit(xstatus);
    1a24:	fcc42783          	lw	a5,-52(s0)
    1a28:	853e                	mv	a0,a5
    1a2a:	3ae050ef          	jal	6dd8 <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1a2e:	fb843583          	ld	a1,-72(s0)
    1a32:	00006517          	auipc	a0,0x6
    1a36:	78650513          	addi	a0,a0,1926 # 81b8 <malloc+0xad4>
    1a3a:	2c3050ef          	jal	74fc <printf>
    exit(1);
    1a3e:	4505                	li	a0,1
    1a40:	398050ef          	jal	6dd8 <exit>
  }
}
    1a44:	60a6                	ld	ra,72(sp)
    1a46:	6406                	ld	s0,64(sp)
    1a48:	6161                	addi	sp,sp,80
    1a4a:	8082                	ret

0000000000001a4c <killstatus>:


// test if child is killed (status = -1)
void
killstatus(char *s)
{
    1a4c:	7179                	addi	sp,sp,-48
    1a4e:	f406                	sd	ra,40(sp)
    1a50:	f022                	sd	s0,32(sp)
    1a52:	1800                	addi	s0,sp,48
    1a54:	fca43c23          	sd	a0,-40(s0)
  int xst;
  
  for(int i = 0; i < 100; i++){
    1a58:	fe042623          	sw	zero,-20(s0)
    1a5c:	a8bd                	j	1ada <killstatus+0x8e>
    int pid1 = fork();
    1a5e:	372050ef          	jal	6dd0 <fork>
    1a62:	87aa                	mv	a5,a0
    1a64:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1a68:	fe842783          	lw	a5,-24(s0)
    1a6c:	2781                	sext.w	a5,a5
    1a6e:	0007dd63          	bgez	a5,1a88 <killstatus+0x3c>
      printf("%s: fork failed\n", s);
    1a72:	fd843583          	ld	a1,-40(s0)
    1a76:	00006517          	auipc	a0,0x6
    1a7a:	24250513          	addi	a0,a0,578 # 7cb8 <malloc+0x5d4>
    1a7e:	27f050ef          	jal	74fc <printf>
      exit(1);
    1a82:	4505                	li	a0,1
    1a84:	354050ef          	jal	6dd8 <exit>
    }
    if(pid1 == 0){
    1a88:	fe842783          	lw	a5,-24(s0)
    1a8c:	2781                	sext.w	a5,a5
    1a8e:	e781                	bnez	a5,1a96 <killstatus+0x4a>
      while(1) {
        getpid();
    1a90:	3c8050ef          	jal	6e58 <getpid>
    1a94:	bff5                	j	1a90 <killstatus+0x44>
      }
      exit(0);
    }
    pause(1);
    1a96:	4505                	li	a0,1
    1a98:	3d0050ef          	jal	6e68 <pause>
    kill(pid1);
    1a9c:	fe842783          	lw	a5,-24(s0)
    1aa0:	853e                	mv	a0,a5
    1aa2:	366050ef          	jal	6e08 <kill>
    wait(&xst);
    1aa6:	fe440793          	addi	a5,s0,-28
    1aaa:	853e                	mv	a0,a5
    1aac:	334050ef          	jal	6de0 <wait>
    if(xst != -1) {
    1ab0:	fe442703          	lw	a4,-28(s0)
    1ab4:	57fd                	li	a5,-1
    1ab6:	00f70d63          	beq	a4,a5,1ad0 <killstatus+0x84>
       printf("%s: status should be -1\n", s);
    1aba:	fd843583          	ld	a1,-40(s0)
    1abe:	00006517          	auipc	a0,0x6
    1ac2:	71250513          	addi	a0,a0,1810 # 81d0 <malloc+0xaec>
    1ac6:	237050ef          	jal	74fc <printf>
       exit(1);
    1aca:	4505                	li	a0,1
    1acc:	30c050ef          	jal	6dd8 <exit>
  for(int i = 0; i < 100; i++){
    1ad0:	fec42783          	lw	a5,-20(s0)
    1ad4:	2785                	addiw	a5,a5,1
    1ad6:	fef42623          	sw	a5,-20(s0)
    1ada:	fec42783          	lw	a5,-20(s0)
    1ade:	0007871b          	sext.w	a4,a5
    1ae2:	06300793          	li	a5,99
    1ae6:	f6e7dce3          	bge	a5,a4,1a5e <killstatus+0x12>
    }
  }
  exit(0);
    1aea:	4501                	li	a0,0
    1aec:	2ec050ef          	jal	6dd8 <exit>

0000000000001af0 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1af0:	7139                	addi	sp,sp,-64
    1af2:	fc06                	sd	ra,56(sp)
    1af4:	f822                	sd	s0,48(sp)
    1af6:	0080                	addi	s0,sp,64
    1af8:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1afc:	2d4050ef          	jal	6dd0 <fork>
    1b00:	87aa                	mv	a5,a0
    1b02:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1b06:	fec42783          	lw	a5,-20(s0)
    1b0a:	2781                	sext.w	a5,a5
    1b0c:	0007dd63          	bgez	a5,1b26 <preempt+0x36>
    printf("%s: fork failed", s);
    1b10:	fc843583          	ld	a1,-56(s0)
    1b14:	00006517          	auipc	a0,0x6
    1b18:	6dc50513          	addi	a0,a0,1756 # 81f0 <malloc+0xb0c>
    1b1c:	1e1050ef          	jal	74fc <printf>
    exit(1);
    1b20:	4505                	li	a0,1
    1b22:	2b6050ef          	jal	6dd8 <exit>
  }
  if(pid1 == 0)
    1b26:	fec42783          	lw	a5,-20(s0)
    1b2a:	2781                	sext.w	a5,a5
    1b2c:	e399                	bnez	a5,1b32 <preempt+0x42>
    for(;;)
    1b2e:	0001                	nop
    1b30:	bffd                	j	1b2e <preempt+0x3e>
      ;

  pid2 = fork();
    1b32:	29e050ef          	jal	6dd0 <fork>
    1b36:	87aa                	mv	a5,a0
    1b38:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    1b3c:	fe842783          	lw	a5,-24(s0)
    1b40:	2781                	sext.w	a5,a5
    1b42:	0007dd63          	bgez	a5,1b5c <preempt+0x6c>
    printf("%s: fork failed\n", s);
    1b46:	fc843583          	ld	a1,-56(s0)
    1b4a:	00006517          	auipc	a0,0x6
    1b4e:	16e50513          	addi	a0,a0,366 # 7cb8 <malloc+0x5d4>
    1b52:	1ab050ef          	jal	74fc <printf>
    exit(1);
    1b56:	4505                	li	a0,1
    1b58:	280050ef          	jal	6dd8 <exit>
  }
  if(pid2 == 0)
    1b5c:	fe842783          	lw	a5,-24(s0)
    1b60:	2781                	sext.w	a5,a5
    1b62:	e399                	bnez	a5,1b68 <preempt+0x78>
    for(;;)
    1b64:	0001                	nop
    1b66:	bffd                	j	1b64 <preempt+0x74>
      ;

  pipe(pfds);
    1b68:	fd840793          	addi	a5,s0,-40
    1b6c:	853e                	mv	a0,a5
    1b6e:	27a050ef          	jal	6de8 <pipe>
  pid3 = fork();
    1b72:	25e050ef          	jal	6dd0 <fork>
    1b76:	87aa                	mv	a5,a0
    1b78:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    1b7c:	fe442783          	lw	a5,-28(s0)
    1b80:	2781                	sext.w	a5,a5
    1b82:	0007dd63          	bgez	a5,1b9c <preempt+0xac>
     printf("%s: fork failed\n", s);
    1b86:	fc843583          	ld	a1,-56(s0)
    1b8a:	00006517          	auipc	a0,0x6
    1b8e:	12e50513          	addi	a0,a0,302 # 7cb8 <malloc+0x5d4>
    1b92:	16b050ef          	jal	74fc <printf>
     exit(1);
    1b96:	4505                	li	a0,1
    1b98:	240050ef          	jal	6dd8 <exit>
  }
  if(pid3 == 0){
    1b9c:	fe442783          	lw	a5,-28(s0)
    1ba0:	2781                	sext.w	a5,a5
    1ba2:	e7a1                	bnez	a5,1bea <preempt+0xfa>
    close(pfds[0]);
    1ba4:	fd842783          	lw	a5,-40(s0)
    1ba8:	853e                	mv	a0,a5
    1baa:	256050ef          	jal	6e00 <close>
    if(write(pfds[1], "x", 1) != 1)
    1bae:	fdc42783          	lw	a5,-36(s0)
    1bb2:	4605                	li	a2,1
    1bb4:	00006597          	auipc	a1,0x6
    1bb8:	da458593          	addi	a1,a1,-604 # 7958 <malloc+0x274>
    1bbc:	853e                	mv	a0,a5
    1bbe:	23a050ef          	jal	6df8 <write>
    1bc2:	87aa                	mv	a5,a0
    1bc4:	873e                	mv	a4,a5
    1bc6:	4785                	li	a5,1
    1bc8:	00f70a63          	beq	a4,a5,1bdc <preempt+0xec>
      printf("%s: preempt write error", s);
    1bcc:	fc843583          	ld	a1,-56(s0)
    1bd0:	00006517          	auipc	a0,0x6
    1bd4:	63050513          	addi	a0,a0,1584 # 8200 <malloc+0xb1c>
    1bd8:	125050ef          	jal	74fc <printf>
    close(pfds[1]);
    1bdc:	fdc42783          	lw	a5,-36(s0)
    1be0:	853e                	mv	a0,a5
    1be2:	21e050ef          	jal	6e00 <close>
    for(;;)
    1be6:	0001                	nop
    1be8:	bffd                	j	1be6 <preempt+0xf6>
      ;
  }

  close(pfds[1]);
    1bea:	fdc42783          	lw	a5,-36(s0)
    1bee:	853e                	mv	a0,a5
    1bf0:	210050ef          	jal	6e00 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1bf4:	fd842783          	lw	a5,-40(s0)
    1bf8:	660d                	lui	a2,0x3
    1bfa:	00009597          	auipc	a1,0x9
    1bfe:	8b658593          	addi	a1,a1,-1866 # a4b0 <buf>
    1c02:	853e                	mv	a0,a5
    1c04:	1ec050ef          	jal	6df0 <read>
    1c08:	87aa                	mv	a5,a0
    1c0a:	873e                	mv	a4,a5
    1c0c:	4785                	li	a5,1
    1c0e:	00f70b63          	beq	a4,a5,1c24 <preempt+0x134>
    printf("%s: preempt read error", s);
    1c12:	fc843583          	ld	a1,-56(s0)
    1c16:	00006517          	auipc	a0,0x6
    1c1a:	60250513          	addi	a0,a0,1538 # 8218 <malloc+0xb34>
    1c1e:	0df050ef          	jal	74fc <printf>
    1c22:	a891                	j	1c76 <preempt+0x186>
    return;
  }
  close(pfds[0]);
    1c24:	fd842783          	lw	a5,-40(s0)
    1c28:	853e                	mv	a0,a5
    1c2a:	1d6050ef          	jal	6e00 <close>
  printf("kill... ");
    1c2e:	00006517          	auipc	a0,0x6
    1c32:	60250513          	addi	a0,a0,1538 # 8230 <malloc+0xb4c>
    1c36:	0c7050ef          	jal	74fc <printf>
  kill(pid1);
    1c3a:	fec42783          	lw	a5,-20(s0)
    1c3e:	853e                	mv	a0,a5
    1c40:	1c8050ef          	jal	6e08 <kill>
  kill(pid2);
    1c44:	fe842783          	lw	a5,-24(s0)
    1c48:	853e                	mv	a0,a5
    1c4a:	1be050ef          	jal	6e08 <kill>
  kill(pid3);
    1c4e:	fe442783          	lw	a5,-28(s0)
    1c52:	853e                	mv	a0,a5
    1c54:	1b4050ef          	jal	6e08 <kill>
  printf("wait... ");
    1c58:	00006517          	auipc	a0,0x6
    1c5c:	5e850513          	addi	a0,a0,1512 # 8240 <malloc+0xb5c>
    1c60:	09d050ef          	jal	74fc <printf>
  wait(0);
    1c64:	4501                	li	a0,0
    1c66:	17a050ef          	jal	6de0 <wait>
  wait(0);
    1c6a:	4501                	li	a0,0
    1c6c:	174050ef          	jal	6de0 <wait>
  wait(0);
    1c70:	4501                	li	a0,0
    1c72:	16e050ef          	jal	6de0 <wait>
}
    1c76:	70e2                	ld	ra,56(sp)
    1c78:	7442                	ld	s0,48(sp)
    1c7a:	6121                	addi	sp,sp,64
    1c7c:	8082                	ret

0000000000001c7e <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    1c7e:	7179                	addi	sp,sp,-48
    1c80:	f406                	sd	ra,40(sp)
    1c82:	f022                	sd	s0,32(sp)
    1c84:	1800                	addi	s0,sp,48
    1c86:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    1c8a:	fe042623          	sw	zero,-20(s0)
    1c8e:	a869                	j	1d28 <exitwait+0xaa>
    pid = fork();
    1c90:	140050ef          	jal	6dd0 <fork>
    1c94:	87aa                	mv	a5,a0
    1c96:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    1c9a:	fe842783          	lw	a5,-24(s0)
    1c9e:	2781                	sext.w	a5,a5
    1ca0:	0007dd63          	bgez	a5,1cba <exitwait+0x3c>
      printf("%s: fork failed\n", s);
    1ca4:	fd843583          	ld	a1,-40(s0)
    1ca8:	00006517          	auipc	a0,0x6
    1cac:	01050513          	addi	a0,a0,16 # 7cb8 <malloc+0x5d4>
    1cb0:	04d050ef          	jal	74fc <printf>
      exit(1);
    1cb4:	4505                	li	a0,1
    1cb6:	122050ef          	jal	6dd8 <exit>
    }
    if(pid){
    1cba:	fe842783          	lw	a5,-24(s0)
    1cbe:	2781                	sext.w	a5,a5
    1cc0:	cbb1                	beqz	a5,1d14 <exitwait+0x96>
      int xstate;
      if(wait(&xstate) != pid){
    1cc2:	fe440793          	addi	a5,s0,-28
    1cc6:	853e                	mv	a0,a5
    1cc8:	118050ef          	jal	6de0 <wait>
    1ccc:	87aa                	mv	a5,a0
    1cce:	873e                	mv	a4,a5
    1cd0:	fe842783          	lw	a5,-24(s0)
    1cd4:	2781                	sext.w	a5,a5
    1cd6:	00e78d63          	beq	a5,a4,1cf0 <exitwait+0x72>
        printf("%s: wait wrong pid\n", s);
    1cda:	fd843583          	ld	a1,-40(s0)
    1cde:	00006517          	auipc	a0,0x6
    1ce2:	57250513          	addi	a0,a0,1394 # 8250 <malloc+0xb6c>
    1ce6:	017050ef          	jal	74fc <printf>
        exit(1);
    1cea:	4505                	li	a0,1
    1cec:	0ec050ef          	jal	6dd8 <exit>
      }
      if(i != xstate) {
    1cf0:	fe442783          	lw	a5,-28(s0)
    1cf4:	fec42703          	lw	a4,-20(s0)
    1cf8:	2701                	sext.w	a4,a4
    1cfa:	02f70263          	beq	a4,a5,1d1e <exitwait+0xa0>
        printf("%s: wait wrong exit status\n", s);
    1cfe:	fd843583          	ld	a1,-40(s0)
    1d02:	00006517          	auipc	a0,0x6
    1d06:	56650513          	addi	a0,a0,1382 # 8268 <malloc+0xb84>
    1d0a:	7f2050ef          	jal	74fc <printf>
        exit(1);
    1d0e:	4505                	li	a0,1
    1d10:	0c8050ef          	jal	6dd8 <exit>
      }
    } else {
      exit(i);
    1d14:	fec42783          	lw	a5,-20(s0)
    1d18:	853e                	mv	a0,a5
    1d1a:	0be050ef          	jal	6dd8 <exit>
  for(i = 0; i < 100; i++){
    1d1e:	fec42783          	lw	a5,-20(s0)
    1d22:	2785                	addiw	a5,a5,1
    1d24:	fef42623          	sw	a5,-20(s0)
    1d28:	fec42783          	lw	a5,-20(s0)
    1d2c:	0007871b          	sext.w	a4,a5
    1d30:	06300793          	li	a5,99
    1d34:	f4e7dee3          	bge	a5,a4,1c90 <exitwait+0x12>
    }
  }
}
    1d38:	0001                	nop
    1d3a:	0001                	nop
    1d3c:	70a2                	ld	ra,40(sp)
    1d3e:	7402                	ld	s0,32(sp)
    1d40:	6145                	addi	sp,sp,48
    1d42:	8082                	ret

0000000000001d44 <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    1d44:	7179                	addi	sp,sp,-48
    1d46:	f406                	sd	ra,40(sp)
    1d48:	f022                	sd	s0,32(sp)
    1d4a:	1800                	addi	s0,sp,48
    1d4c:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    1d50:	108050ef          	jal	6e58 <getpid>
    1d54:	87aa                	mv	a5,a0
    1d56:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    1d5a:	fe042623          	sw	zero,-20(s0)
    1d5e:	a849                	j	1df0 <reparent+0xac>
    int pid = fork();
    1d60:	070050ef          	jal	6dd0 <fork>
    1d64:	87aa                	mv	a5,a0
    1d66:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    1d6a:	fe442783          	lw	a5,-28(s0)
    1d6e:	2781                	sext.w	a5,a5
    1d70:	0007dd63          	bgez	a5,1d8a <reparent+0x46>
      printf("%s: fork failed\n", s);
    1d74:	fd843583          	ld	a1,-40(s0)
    1d78:	00006517          	auipc	a0,0x6
    1d7c:	f4050513          	addi	a0,a0,-192 # 7cb8 <malloc+0x5d4>
    1d80:	77c050ef          	jal	74fc <printf>
      exit(1);
    1d84:	4505                	li	a0,1
    1d86:	052050ef          	jal	6dd8 <exit>
    }
    if(pid){
    1d8a:	fe442783          	lw	a5,-28(s0)
    1d8e:	2781                	sext.w	a5,a5
    1d90:	c795                	beqz	a5,1dbc <reparent+0x78>
      if(wait(0) != pid){
    1d92:	4501                	li	a0,0
    1d94:	04c050ef          	jal	6de0 <wait>
    1d98:	87aa                	mv	a5,a0
    1d9a:	873e                	mv	a4,a5
    1d9c:	fe442783          	lw	a5,-28(s0)
    1da0:	2781                	sext.w	a5,a5
    1da2:	04e78263          	beq	a5,a4,1de6 <reparent+0xa2>
        printf("%s: wait wrong pid\n", s);
    1da6:	fd843583          	ld	a1,-40(s0)
    1daa:	00006517          	auipc	a0,0x6
    1dae:	4a650513          	addi	a0,a0,1190 # 8250 <malloc+0xb6c>
    1db2:	74a050ef          	jal	74fc <printf>
        exit(1);
    1db6:	4505                	li	a0,1
    1db8:	020050ef          	jal	6dd8 <exit>
      }
    } else {
      int pid2 = fork();
    1dbc:	014050ef          	jal	6dd0 <fork>
    1dc0:	87aa                	mv	a5,a0
    1dc2:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    1dc6:	fe042783          	lw	a5,-32(s0)
    1dca:	2781                	sext.w	a5,a5
    1dcc:	0007da63          	bgez	a5,1de0 <reparent+0x9c>
        kill(master_pid);
    1dd0:	fe842783          	lw	a5,-24(s0)
    1dd4:	853e                	mv	a0,a5
    1dd6:	032050ef          	jal	6e08 <kill>
        exit(1);
    1dda:	4505                	li	a0,1
    1ddc:	7fd040ef          	jal	6dd8 <exit>
      }
      exit(0);
    1de0:	4501                	li	a0,0
    1de2:	7f7040ef          	jal	6dd8 <exit>
  for(int i = 0; i < 200; i++){
    1de6:	fec42783          	lw	a5,-20(s0)
    1dea:	2785                	addiw	a5,a5,1
    1dec:	fef42623          	sw	a5,-20(s0)
    1df0:	fec42783          	lw	a5,-20(s0)
    1df4:	0007871b          	sext.w	a4,a5
    1df8:	0c700793          	li	a5,199
    1dfc:	f6e7d2e3          	bge	a5,a4,1d60 <reparent+0x1c>
    }
  }
  exit(0);
    1e00:	4501                	li	a0,0
    1e02:	7d7040ef          	jal	6dd8 <exit>

0000000000001e06 <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    1e06:	7179                	addi	sp,sp,-48
    1e08:	f406                	sd	ra,40(sp)
    1e0a:	f022                	sd	s0,32(sp)
    1e0c:	1800                	addi	s0,sp,48
    1e0e:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    1e12:	fe042623          	sw	zero,-20(s0)
    1e16:	a061                	j	1e9e <twochildren+0x98>
    int pid1 = fork();
    1e18:	7b9040ef          	jal	6dd0 <fork>
    1e1c:	87aa                	mv	a5,a0
    1e1e:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    1e22:	fe842783          	lw	a5,-24(s0)
    1e26:	2781                	sext.w	a5,a5
    1e28:	0007dd63          	bgez	a5,1e42 <twochildren+0x3c>
      printf("%s: fork failed\n", s);
    1e2c:	fd843583          	ld	a1,-40(s0)
    1e30:	00006517          	auipc	a0,0x6
    1e34:	e8850513          	addi	a0,a0,-376 # 7cb8 <malloc+0x5d4>
    1e38:	6c4050ef          	jal	74fc <printf>
      exit(1);
    1e3c:	4505                	li	a0,1
    1e3e:	79b040ef          	jal	6dd8 <exit>
    }
    if(pid1 == 0){
    1e42:	fe842783          	lw	a5,-24(s0)
    1e46:	2781                	sext.w	a5,a5
    1e48:	e781                	bnez	a5,1e50 <twochildren+0x4a>
      exit(0);
    1e4a:	4501                	li	a0,0
    1e4c:	78d040ef          	jal	6dd8 <exit>
    } else {
      int pid2 = fork();
    1e50:	781040ef          	jal	6dd0 <fork>
    1e54:	87aa                	mv	a5,a0
    1e56:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    1e5a:	fe442783          	lw	a5,-28(s0)
    1e5e:	2781                	sext.w	a5,a5
    1e60:	0007dd63          	bgez	a5,1e7a <twochildren+0x74>
        printf("%s: fork failed\n", s);
    1e64:	fd843583          	ld	a1,-40(s0)
    1e68:	00006517          	auipc	a0,0x6
    1e6c:	e5050513          	addi	a0,a0,-432 # 7cb8 <malloc+0x5d4>
    1e70:	68c050ef          	jal	74fc <printf>
        exit(1);
    1e74:	4505                	li	a0,1
    1e76:	763040ef          	jal	6dd8 <exit>
      }
      if(pid2 == 0){
    1e7a:	fe442783          	lw	a5,-28(s0)
    1e7e:	2781                	sext.w	a5,a5
    1e80:	e781                	bnez	a5,1e88 <twochildren+0x82>
        exit(0);
    1e82:	4501                	li	a0,0
    1e84:	755040ef          	jal	6dd8 <exit>
      } else {
        wait(0);
    1e88:	4501                	li	a0,0
    1e8a:	757040ef          	jal	6de0 <wait>
        wait(0);
    1e8e:	4501                	li	a0,0
    1e90:	751040ef          	jal	6de0 <wait>
  for(int i = 0; i < 1000; i++){
    1e94:	fec42783          	lw	a5,-20(s0)
    1e98:	2785                	addiw	a5,a5,1
    1e9a:	fef42623          	sw	a5,-20(s0)
    1e9e:	fec42783          	lw	a5,-20(s0)
    1ea2:	0007871b          	sext.w	a4,a5
    1ea6:	3e700793          	li	a5,999
    1eaa:	f6e7d7e3          	bge	a5,a4,1e18 <twochildren+0x12>
      }
    }
  }
}
    1eae:	0001                	nop
    1eb0:	0001                	nop
    1eb2:	70a2                	ld	ra,40(sp)
    1eb4:	7402                	ld	s0,32(sp)
    1eb6:	6145                	addi	sp,sp,48
    1eb8:	8082                	ret

0000000000001eba <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    1eba:	7139                	addi	sp,sp,-64
    1ebc:	fc06                	sd	ra,56(sp)
    1ebe:	f822                	sd	s0,48(sp)
    1ec0:	0080                	addi	s0,sp,64
    1ec2:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };
  
  for(int i = 0; i < N; i++){
    1ec6:	fe042623          	sw	zero,-20(s0)
    1eca:	a849                	j	1f5c <forkfork+0xa2>
    int pid = fork();
    1ecc:	705040ef          	jal	6dd0 <fork>
    1ed0:	87aa                	mv	a5,a0
    1ed2:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    1ed6:	fe042783          	lw	a5,-32(s0)
    1eda:	2781                	sext.w	a5,a5
    1edc:	0007dd63          	bgez	a5,1ef6 <forkfork+0x3c>
      printf("%s: fork failed", s);
    1ee0:	fc843583          	ld	a1,-56(s0)
    1ee4:	00006517          	auipc	a0,0x6
    1ee8:	30c50513          	addi	a0,a0,780 # 81f0 <malloc+0xb0c>
    1eec:	610050ef          	jal	74fc <printf>
      exit(1);
    1ef0:	4505                	li	a0,1
    1ef2:	6e7040ef          	jal	6dd8 <exit>
    }
    if(pid == 0){
    1ef6:	fe042783          	lw	a5,-32(s0)
    1efa:	2781                	sext.w	a5,a5
    1efc:	ebb9                	bnez	a5,1f52 <forkfork+0x98>
      for(int j = 0; j < 200; j++){
    1efe:	fe042423          	sw	zero,-24(s0)
    1f02:	a82d                	j	1f3c <forkfork+0x82>
        int pid1 = fork();
    1f04:	6cd040ef          	jal	6dd0 <fork>
    1f08:	87aa                	mv	a5,a0
    1f0a:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    1f0e:	fdc42783          	lw	a5,-36(s0)
    1f12:	2781                	sext.w	a5,a5
    1f14:	0007d563          	bgez	a5,1f1e <forkfork+0x64>
          exit(1);
    1f18:	4505                	li	a0,1
    1f1a:	6bf040ef          	jal	6dd8 <exit>
        }
        if(pid1 == 0){
    1f1e:	fdc42783          	lw	a5,-36(s0)
    1f22:	2781                	sext.w	a5,a5
    1f24:	e781                	bnez	a5,1f2c <forkfork+0x72>
          exit(0);
    1f26:	4501                	li	a0,0
    1f28:	6b1040ef          	jal	6dd8 <exit>
        }
        wait(0);
    1f2c:	4501                	li	a0,0
    1f2e:	6b3040ef          	jal	6de0 <wait>
      for(int j = 0; j < 200; j++){
    1f32:	fe842783          	lw	a5,-24(s0)
    1f36:	2785                	addiw	a5,a5,1
    1f38:	fef42423          	sw	a5,-24(s0)
    1f3c:	fe842783          	lw	a5,-24(s0)
    1f40:	0007871b          	sext.w	a4,a5
    1f44:	0c700793          	li	a5,199
    1f48:	fae7dee3          	bge	a5,a4,1f04 <forkfork+0x4a>
      }
      exit(0);
    1f4c:	4501                	li	a0,0
    1f4e:	68b040ef          	jal	6dd8 <exit>
  for(int i = 0; i < N; i++){
    1f52:	fec42783          	lw	a5,-20(s0)
    1f56:	2785                	addiw	a5,a5,1
    1f58:	fef42623          	sw	a5,-20(s0)
    1f5c:	fec42783          	lw	a5,-20(s0)
    1f60:	0007871b          	sext.w	a4,a5
    1f64:	4785                	li	a5,1
    1f66:	f6e7d3e3          	bge	a5,a4,1ecc <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    1f6a:	fe042223          	sw	zero,-28(s0)
    1f6e:	a80d                	j	1fa0 <forkfork+0xe6>
    wait(&xstatus);
    1f70:	fd840793          	addi	a5,s0,-40
    1f74:	853e                	mv	a0,a5
    1f76:	66b040ef          	jal	6de0 <wait>
    if(xstatus != 0) {
    1f7a:	fd842783          	lw	a5,-40(s0)
    1f7e:	cf81                	beqz	a5,1f96 <forkfork+0xdc>
      printf("%s: fork in child failed", s);
    1f80:	fc843583          	ld	a1,-56(s0)
    1f84:	00006517          	auipc	a0,0x6
    1f88:	30450513          	addi	a0,a0,772 # 8288 <malloc+0xba4>
    1f8c:	570050ef          	jal	74fc <printf>
      exit(1);
    1f90:	4505                	li	a0,1
    1f92:	647040ef          	jal	6dd8 <exit>
  for(int i = 0; i < N; i++){
    1f96:	fe442783          	lw	a5,-28(s0)
    1f9a:	2785                	addiw	a5,a5,1
    1f9c:	fef42223          	sw	a5,-28(s0)
    1fa0:	fe442783          	lw	a5,-28(s0)
    1fa4:	0007871b          	sext.w	a4,a5
    1fa8:	4785                	li	a5,1
    1faa:	fce7d3e3          	bge	a5,a4,1f70 <forkfork+0xb6>
    }
  }
}
    1fae:	0001                	nop
    1fb0:	0001                	nop
    1fb2:	70e2                	ld	ra,56(sp)
    1fb4:	7442                	ld	s0,48(sp)
    1fb6:	6121                	addi	sp,sp,64
    1fb8:	8082                	ret

0000000000001fba <forkforkfork>:

void
forkforkfork(char *s)
{
    1fba:	7179                	addi	sp,sp,-48
    1fbc:	f406                	sd	ra,40(sp)
    1fbe:	f022                	sd	s0,32(sp)
    1fc0:	1800                	addi	s0,sp,48
    1fc2:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    1fc6:	00006517          	auipc	a0,0x6
    1fca:	2e250513          	addi	a0,a0,738 # 82a8 <malloc+0xbc4>
    1fce:	65b040ef          	jal	6e28 <unlink>

  int pid = fork();
    1fd2:	5ff040ef          	jal	6dd0 <fork>
    1fd6:	87aa                	mv	a5,a0
    1fd8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    1fdc:	fec42783          	lw	a5,-20(s0)
    1fe0:	2781                	sext.w	a5,a5
    1fe2:	0007dd63          	bgez	a5,1ffc <forkforkfork+0x42>
    printf("%s: fork failed", s);
    1fe6:	fd843583          	ld	a1,-40(s0)
    1fea:	00006517          	auipc	a0,0x6
    1fee:	20650513          	addi	a0,a0,518 # 81f0 <malloc+0xb0c>
    1ff2:	50a050ef          	jal	74fc <printf>
    exit(1);
    1ff6:	4505                	li	a0,1
    1ff8:	5e1040ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    1ffc:	fec42783          	lw	a5,-20(s0)
    2000:	2781                	sext.w	a5,a5
    2002:	e7a9                	bnez	a5,204c <forkforkfork+0x92>
    while(1){
      int fd = open("stopforking", 0);
    2004:	4581                	li	a1,0
    2006:	00006517          	auipc	a0,0x6
    200a:	2a250513          	addi	a0,a0,674 # 82a8 <malloc+0xbc4>
    200e:	60b040ef          	jal	6e18 <open>
    2012:	87aa                	mv	a5,a0
    2014:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    2018:	fe842783          	lw	a5,-24(s0)
    201c:	2781                	sext.w	a5,a5
    201e:	0007c563          	bltz	a5,2028 <forkforkfork+0x6e>
        exit(0);
    2022:	4501                	li	a0,0
    2024:	5b5040ef          	jal	6dd8 <exit>
      }
      if(fork() < 0){
    2028:	5a9040ef          	jal	6dd0 <fork>
    202c:	87aa                	mv	a5,a0
    202e:	fc07dbe3          	bgez	a5,2004 <forkforkfork+0x4a>
        close(open("stopforking", O_CREATE|O_RDWR));
    2032:	20200593          	li	a1,514
    2036:	00006517          	auipc	a0,0x6
    203a:	27250513          	addi	a0,a0,626 # 82a8 <malloc+0xbc4>
    203e:	5db040ef          	jal	6e18 <open>
    2042:	87aa                	mv	a5,a0
    2044:	853e                	mv	a0,a5
    2046:	5bb040ef          	jal	6e00 <close>
    while(1){
    204a:	bf6d                	j	2004 <forkforkfork+0x4a>
    }

    exit(0);
  }

  pause(20); // two seconds
    204c:	4551                	li	a0,20
    204e:	61b040ef          	jal	6e68 <pause>
  close(open("stopforking", O_CREATE|O_RDWR));
    2052:	20200593          	li	a1,514
    2056:	00006517          	auipc	a0,0x6
    205a:	25250513          	addi	a0,a0,594 # 82a8 <malloc+0xbc4>
    205e:	5bb040ef          	jal	6e18 <open>
    2062:	87aa                	mv	a5,a0
    2064:	853e                	mv	a0,a5
    2066:	59b040ef          	jal	6e00 <close>
  wait(0);
    206a:	4501                	li	a0,0
    206c:	575040ef          	jal	6de0 <wait>
  pause(10); // one second
    2070:	4529                	li	a0,10
    2072:	5f7040ef          	jal	6e68 <pause>
}
    2076:	0001                	nop
    2078:	70a2                	ld	ra,40(sp)
    207a:	7402                	ld	s0,32(sp)
    207c:	6145                	addi	sp,sp,48
    207e:	8082                	ret

0000000000002080 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    2080:	7179                	addi	sp,sp,-48
    2082:	f406                	sd	ra,40(sp)
    2084:	f022                	sd	s0,32(sp)
    2086:	1800                	addi	s0,sp,48
    2088:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    208c:	fe042623          	sw	zero,-20(s0)
    2090:	a0b9                	j	20de <reparent2+0x5e>
    int pid1 = fork();
    2092:	53f040ef          	jal	6dd0 <fork>
    2096:	87aa                	mv	a5,a0
    2098:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    209c:	fe842783          	lw	a5,-24(s0)
    20a0:	2781                	sext.w	a5,a5
    20a2:	0007db63          	bgez	a5,20b8 <reparent2+0x38>
      printf("fork failed\n");
    20a6:	00006517          	auipc	a0,0x6
    20aa:	9e250513          	addi	a0,a0,-1566 # 7a88 <malloc+0x3a4>
    20ae:	44e050ef          	jal	74fc <printf>
      exit(1);
    20b2:	4505                	li	a0,1
    20b4:	525040ef          	jal	6dd8 <exit>
    }
    if(pid1 == 0){
    20b8:	fe842783          	lw	a5,-24(s0)
    20bc:	2781                	sext.w	a5,a5
    20be:	eb81                	bnez	a5,20ce <reparent2+0x4e>
      fork();
    20c0:	511040ef          	jal	6dd0 <fork>
      fork();
    20c4:	50d040ef          	jal	6dd0 <fork>
      exit(0);
    20c8:	4501                	li	a0,0
    20ca:	50f040ef          	jal	6dd8 <exit>
    }
    wait(0);
    20ce:	4501                	li	a0,0
    20d0:	511040ef          	jal	6de0 <wait>
  for(int i = 0; i < 800; i++){
    20d4:	fec42783          	lw	a5,-20(s0)
    20d8:	2785                	addiw	a5,a5,1
    20da:	fef42623          	sw	a5,-20(s0)
    20de:	fec42783          	lw	a5,-20(s0)
    20e2:	0007871b          	sext.w	a4,a5
    20e6:	31f00793          	li	a5,799
    20ea:	fae7d4e3          	bge	a5,a4,2092 <reparent2+0x12>
  }

  exit(0);
    20ee:	4501                	li	a0,0
    20f0:	4e9040ef          	jal	6dd8 <exit>

00000000000020f4 <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    20f4:	7139                	addi	sp,sp,-64
    20f6:	fc06                	sd	ra,56(sp)
    20f8:	f822                	sd	s0,48(sp)
    20fa:	0080                	addi	s0,sp,64
    20fc:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2100:	4d1040ef          	jal	6dd0 <fork>
    2104:	87aa                	mv	a5,a0
    2106:	fef42223          	sw	a5,-28(s0)
    210a:	fe442783          	lw	a5,-28(s0)
    210e:	2781                	sext.w	a5,a5
    2110:	e3d1                	bnez	a5,2194 <mem+0xa0>
    m1 = 0;
    2112:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2116:	a811                	j	212a <mem+0x36>
      *(char**)m2 = m1;
    2118:	fd843783          	ld	a5,-40(s0)
    211c:	fe843703          	ld	a4,-24(s0)
    2120:	e398                	sd	a4,0(a5)
      m1 = m2;
    2122:	fd843783          	ld	a5,-40(s0)
    2126:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    212a:	6789                	lui	a5,0x2
    212c:	71178513          	addi	a0,a5,1809 # 2711 <createdelete+0xa7>
    2130:	5b4050ef          	jal	76e4 <malloc>
    2134:	fca43c23          	sd	a0,-40(s0)
    2138:	fd843783          	ld	a5,-40(s0)
    213c:	fff1                	bnez	a5,2118 <mem+0x24>
    }
    while(m1){
    213e:	a831                	j	215a <mem+0x66>
      m2 = *(char**)m1;
    2140:	fe843783          	ld	a5,-24(s0)
    2144:	639c                	ld	a5,0(a5)
    2146:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    214a:	fe843503          	ld	a0,-24(s0)
    214e:	3fa050ef          	jal	7548 <free>
      m1 = m2;
    2152:	fd843783          	ld	a5,-40(s0)
    2156:	fef43423          	sd	a5,-24(s0)
    while(m1){
    215a:	fe843783          	ld	a5,-24(s0)
    215e:	f3ed                	bnez	a5,2140 <mem+0x4c>
    }
    m1 = malloc(1024*20);
    2160:	6515                	lui	a0,0x5
    2162:	582050ef          	jal	76e4 <malloc>
    2166:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    216a:	fe843783          	ld	a5,-24(s0)
    216e:	ef81                	bnez	a5,2186 <mem+0x92>
      printf("%s: couldn't allocate mem?!!\n", s);
    2170:	fc843583          	ld	a1,-56(s0)
    2174:	00006517          	auipc	a0,0x6
    2178:	14450513          	addi	a0,a0,324 # 82b8 <malloc+0xbd4>
    217c:	380050ef          	jal	74fc <printf>
      exit(1);
    2180:	4505                	li	a0,1
    2182:	457040ef          	jal	6dd8 <exit>
    }
    free(m1);
    2186:	fe843503          	ld	a0,-24(s0)
    218a:	3be050ef          	jal	7548 <free>
    exit(0);
    218e:	4501                	li	a0,0
    2190:	449040ef          	jal	6dd8 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    2194:	fd440793          	addi	a5,s0,-44
    2198:	853e                	mv	a0,a5
    219a:	447040ef          	jal	6de0 <wait>
    if(xstatus == -1){
    219e:	fd442703          	lw	a4,-44(s0)
    21a2:	57fd                	li	a5,-1
    21a4:	00f71563          	bne	a4,a5,21ae <mem+0xba>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    21a8:	4501                	li	a0,0
    21aa:	42f040ef          	jal	6dd8 <exit>
    }
    exit(xstatus);
    21ae:	fd442783          	lw	a5,-44(s0)
    21b2:	853e                	mv	a0,a5
    21b4:	425040ef          	jal	6dd8 <exit>

00000000000021b8 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    21b8:	715d                	addi	sp,sp,-80
    21ba:	e486                	sd	ra,72(sp)
    21bc:	e0a2                	sd	s0,64(sp)
    21be:	0880                	addi	s0,sp,80
    21c0:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    21c4:	00006517          	auipc	a0,0x6
    21c8:	11450513          	addi	a0,a0,276 # 82d8 <malloc+0xbf4>
    21cc:	45d040ef          	jal	6e28 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    21d0:	20200593          	li	a1,514
    21d4:	00006517          	auipc	a0,0x6
    21d8:	10450513          	addi	a0,a0,260 # 82d8 <malloc+0xbf4>
    21dc:	43d040ef          	jal	6e18 <open>
    21e0:	87aa                	mv	a5,a0
    21e2:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    21e6:	fe042783          	lw	a5,-32(s0)
    21ea:	2781                	sext.w	a5,a5
    21ec:	0007dd63          	bgez	a5,2206 <sharedfd+0x4e>
    printf("%s: cannot open sharedfd for writing", s);
    21f0:	fb843583          	ld	a1,-72(s0)
    21f4:	00006517          	auipc	a0,0x6
    21f8:	0f450513          	addi	a0,a0,244 # 82e8 <malloc+0xc04>
    21fc:	300050ef          	jal	74fc <printf>
    exit(1);
    2200:	4505                	li	a0,1
    2202:	3d7040ef          	jal	6dd8 <exit>
  }
  pid = fork();
    2206:	3cb040ef          	jal	6dd0 <fork>
    220a:	87aa                	mv	a5,a0
    220c:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2210:	fdc42783          	lw	a5,-36(s0)
    2214:	2781                	sext.w	a5,a5
    2216:	e781                	bnez	a5,221e <sharedfd+0x66>
    2218:	06300793          	li	a5,99
    221c:	a019                	j	2222 <sharedfd+0x6a>
    221e:	07000793          	li	a5,112
    2222:	fc840713          	addi	a4,s0,-56
    2226:	4629                	li	a2,10
    2228:	85be                	mv	a1,a5
    222a:	853a                	mv	a0,a4
    222c:	7b6040ef          	jal	69e2 <memset>
  for(i = 0; i < N; i++){
    2230:	fe042623          	sw	zero,-20(s0)
    2234:	a83d                	j	2272 <sharedfd+0xba>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    2236:	fc840713          	addi	a4,s0,-56
    223a:	fe042783          	lw	a5,-32(s0)
    223e:	4629                	li	a2,10
    2240:	85ba                	mv	a1,a4
    2242:	853e                	mv	a0,a5
    2244:	3b5040ef          	jal	6df8 <write>
    2248:	87aa                	mv	a5,a0
    224a:	873e                	mv	a4,a5
    224c:	47a9                	li	a5,10
    224e:	00f70d63          	beq	a4,a5,2268 <sharedfd+0xb0>
      printf("%s: write sharedfd failed\n", s);
    2252:	fb843583          	ld	a1,-72(s0)
    2256:	00006517          	auipc	a0,0x6
    225a:	0ba50513          	addi	a0,a0,186 # 8310 <malloc+0xc2c>
    225e:	29e050ef          	jal	74fc <printf>
      exit(1);
    2262:	4505                	li	a0,1
    2264:	375040ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    2268:	fec42783          	lw	a5,-20(s0)
    226c:	2785                	addiw	a5,a5,1
    226e:	fef42623          	sw	a5,-20(s0)
    2272:	fec42783          	lw	a5,-20(s0)
    2276:	0007871b          	sext.w	a4,a5
    227a:	3e700793          	li	a5,999
    227e:	fae7dce3          	bge	a5,a4,2236 <sharedfd+0x7e>
    }
  }
  if(pid == 0) {
    2282:	fdc42783          	lw	a5,-36(s0)
    2286:	2781                	sext.w	a5,a5
    2288:	e781                	bnez	a5,2290 <sharedfd+0xd8>
    exit(0);
    228a:	4501                	li	a0,0
    228c:	34d040ef          	jal	6dd8 <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    2290:	fc440793          	addi	a5,s0,-60
    2294:	853e                	mv	a0,a5
    2296:	34b040ef          	jal	6de0 <wait>
    if(xstatus != 0)
    229a:	fc442783          	lw	a5,-60(s0)
    229e:	c791                	beqz	a5,22aa <sharedfd+0xf2>
      exit(xstatus);
    22a0:	fc442783          	lw	a5,-60(s0)
    22a4:	853e                	mv	a0,a5
    22a6:	333040ef          	jal	6dd8 <exit>
  }
  
  close(fd);
    22aa:	fe042783          	lw	a5,-32(s0)
    22ae:	853e                	mv	a0,a5
    22b0:	351040ef          	jal	6e00 <close>
  fd = open("sharedfd", 0);
    22b4:	4581                	li	a1,0
    22b6:	00006517          	auipc	a0,0x6
    22ba:	02250513          	addi	a0,a0,34 # 82d8 <malloc+0xbf4>
    22be:	35b040ef          	jal	6e18 <open>
    22c2:	87aa                	mv	a5,a0
    22c4:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    22c8:	fe042783          	lw	a5,-32(s0)
    22cc:	2781                	sext.w	a5,a5
    22ce:	0007dd63          	bgez	a5,22e8 <sharedfd+0x130>
    printf("%s: cannot open sharedfd for reading\n", s);
    22d2:	fb843583          	ld	a1,-72(s0)
    22d6:	00006517          	auipc	a0,0x6
    22da:	05a50513          	addi	a0,a0,90 # 8330 <malloc+0xc4c>
    22de:	21e050ef          	jal	74fc <printf>
    exit(1);
    22e2:	4505                	li	a0,1
    22e4:	2f5040ef          	jal	6dd8 <exit>
  }
  nc = np = 0;
    22e8:	fe042223          	sw	zero,-28(s0)
    22ec:	fe442783          	lw	a5,-28(s0)
    22f0:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    22f4:	a8b1                	j	2350 <sharedfd+0x198>
    for(i = 0; i < sizeof(buf); i++){
    22f6:	fe042623          	sw	zero,-20(s0)
    22fa:	a0b1                	j	2346 <sharedfd+0x18e>
      if(buf[i] == 'c')
    22fc:	fec42783          	lw	a5,-20(s0)
    2300:	17c1                	addi	a5,a5,-16
    2302:	97a2                	add	a5,a5,s0
    2304:	fd87c783          	lbu	a5,-40(a5)
    2308:	873e                	mv	a4,a5
    230a:	06300793          	li	a5,99
    230e:	00f71763          	bne	a4,a5,231c <sharedfd+0x164>
        nc++;
    2312:	fe842783          	lw	a5,-24(s0)
    2316:	2785                	addiw	a5,a5,1
    2318:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    231c:	fec42783          	lw	a5,-20(s0)
    2320:	17c1                	addi	a5,a5,-16
    2322:	97a2                	add	a5,a5,s0
    2324:	fd87c783          	lbu	a5,-40(a5)
    2328:	873e                	mv	a4,a5
    232a:	07000793          	li	a5,112
    232e:	00f71763          	bne	a4,a5,233c <sharedfd+0x184>
        np++;
    2332:	fe442783          	lw	a5,-28(s0)
    2336:	2785                	addiw	a5,a5,1
    2338:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    233c:	fec42783          	lw	a5,-20(s0)
    2340:	2785                	addiw	a5,a5,1
    2342:	fef42623          	sw	a5,-20(s0)
    2346:	fec42703          	lw	a4,-20(s0)
    234a:	47a5                	li	a5,9
    234c:	fae7f8e3          	bgeu	a5,a4,22fc <sharedfd+0x144>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2350:	fc840713          	addi	a4,s0,-56
    2354:	fe042783          	lw	a5,-32(s0)
    2358:	4629                	li	a2,10
    235a:	85ba                	mv	a1,a4
    235c:	853e                	mv	a0,a5
    235e:	293040ef          	jal	6df0 <read>
    2362:	87aa                	mv	a5,a0
    2364:	fcf42c23          	sw	a5,-40(s0)
    2368:	fd842783          	lw	a5,-40(s0)
    236c:	2781                	sext.w	a5,a5
    236e:	f8f044e3          	bgtz	a5,22f6 <sharedfd+0x13e>
    }
  }
  close(fd);
    2372:	fe042783          	lw	a5,-32(s0)
    2376:	853e                	mv	a0,a5
    2378:	289040ef          	jal	6e00 <close>
  unlink("sharedfd");
    237c:	00006517          	auipc	a0,0x6
    2380:	f5c50513          	addi	a0,a0,-164 # 82d8 <malloc+0xbf4>
    2384:	2a5040ef          	jal	6e28 <unlink>
  if(nc == N*SZ && np == N*SZ){
    2388:	fe842783          	lw	a5,-24(s0)
    238c:	0007871b          	sext.w	a4,a5
    2390:	6789                	lui	a5,0x2
    2392:	71078793          	addi	a5,a5,1808 # 2710 <createdelete+0xa6>
    2396:	00f71e63          	bne	a4,a5,23b2 <sharedfd+0x1fa>
    239a:	fe442783          	lw	a5,-28(s0)
    239e:	0007871b          	sext.w	a4,a5
    23a2:	6789                	lui	a5,0x2
    23a4:	71078793          	addi	a5,a5,1808 # 2710 <createdelete+0xa6>
    23a8:	00f71563          	bne	a4,a5,23b2 <sharedfd+0x1fa>
    exit(0);
    23ac:	4501                	li	a0,0
    23ae:	22b040ef          	jal	6dd8 <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    23b2:	fb843583          	ld	a1,-72(s0)
    23b6:	00006517          	auipc	a0,0x6
    23ba:	fa250513          	addi	a0,a0,-94 # 8358 <malloc+0xc74>
    23be:	13e050ef          	jal	74fc <printf>
    exit(1);
    23c2:	4505                	li	a0,1
    23c4:	215040ef          	jal	6dd8 <exit>

00000000000023c8 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    23c8:	7159                	addi	sp,sp,-112
    23ca:	f486                	sd	ra,104(sp)
    23cc:	f0a2                	sd	s0,96(sp)
    23ce:	1880                	addi	s0,sp,112
    23d0:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    23d4:	00006797          	auipc	a5,0x6
    23d8:	ffc78793          	addi	a5,a5,-4 # 83d0 <malloc+0xcec>
    23dc:	6390                	ld	a2,0(a5)
    23de:	6794                	ld	a3,8(a5)
    23e0:	6b98                	ld	a4,16(a5)
    23e2:	6f9c                	ld	a5,24(a5)
    23e4:	fac43423          	sd	a2,-88(s0)
    23e8:	fad43823          	sd	a3,-80(s0)
    23ec:	fae43c23          	sd	a4,-72(s0)
    23f0:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };
  
  for(pi = 0; pi < NCHILD; pi++){
    23f4:	fe042023          	sw	zero,-32(s0)
    23f8:	a239                	j	2506 <fourfiles+0x13e>
    fname = names[pi];
    23fa:	fe042703          	lw	a4,-32(s0)
    23fe:	fa840793          	addi	a5,s0,-88
    2402:	070e                	slli	a4,a4,0x3
    2404:	97ba                	add	a5,a5,a4
    2406:	639c                	ld	a5,0(a5)
    2408:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    240c:	fd843503          	ld	a0,-40(s0)
    2410:	219040ef          	jal	6e28 <unlink>

    pid = fork();
    2414:	1bd040ef          	jal	6dd0 <fork>
    2418:	87aa                	mv	a5,a0
    241a:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    241e:	fcc42783          	lw	a5,-52(s0)
    2422:	2781                	sext.w	a5,a5
    2424:	0007dd63          	bgez	a5,243e <fourfiles+0x76>
      printf("%s: fork failed\n", s);
    2428:	f9843583          	ld	a1,-104(s0)
    242c:	00006517          	auipc	a0,0x6
    2430:	88c50513          	addi	a0,a0,-1908 # 7cb8 <malloc+0x5d4>
    2434:	0c8050ef          	jal	74fc <printf>
      exit(1);
    2438:	4505                	li	a0,1
    243a:	19f040ef          	jal	6dd8 <exit>
    }

    if(pid == 0){
    243e:	fcc42783          	lw	a5,-52(s0)
    2442:	2781                	sext.w	a5,a5
    2444:	efc5                	bnez	a5,24fc <fourfiles+0x134>
      fd = open(fname, O_CREATE | O_RDWR);
    2446:	20200593          	li	a1,514
    244a:	fd843503          	ld	a0,-40(s0)
    244e:	1cb040ef          	jal	6e18 <open>
    2452:	87aa                	mv	a5,a0
    2454:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2458:	fd442783          	lw	a5,-44(s0)
    245c:	2781                	sext.w	a5,a5
    245e:	0007dd63          	bgez	a5,2478 <fourfiles+0xb0>
        printf("%s: create failed\n", s);
    2462:	f9843583          	ld	a1,-104(s0)
    2466:	00006517          	auipc	a0,0x6
    246a:	c7a50513          	addi	a0,a0,-902 # 80e0 <malloc+0x9fc>
    246e:	08e050ef          	jal	74fc <printf>
        exit(1);
    2472:	4505                	li	a0,1
    2474:	165040ef          	jal	6dd8 <exit>
      }

      memset(buf, '0'+pi, SZ);
    2478:	fe042783          	lw	a5,-32(s0)
    247c:	0307879b          	addiw	a5,a5,48
    2480:	2781                	sext.w	a5,a5
    2482:	1f400613          	li	a2,500
    2486:	85be                	mv	a1,a5
    2488:	00008517          	auipc	a0,0x8
    248c:	02850513          	addi	a0,a0,40 # a4b0 <buf>
    2490:	552040ef          	jal	69e2 <memset>
      for(i = 0; i < N; i++){
    2494:	fe042623          	sw	zero,-20(s0)
    2498:	a881                	j	24e8 <fourfiles+0x120>
        if((n = write(fd, buf, SZ)) != SZ){
    249a:	fd442783          	lw	a5,-44(s0)
    249e:	1f400613          	li	a2,500
    24a2:	00008597          	auipc	a1,0x8
    24a6:	00e58593          	addi	a1,a1,14 # a4b0 <buf>
    24aa:	853e                	mv	a0,a5
    24ac:	14d040ef          	jal	6df8 <write>
    24b0:	87aa                	mv	a5,a0
    24b2:	fcf42823          	sw	a5,-48(s0)
    24b6:	fd042783          	lw	a5,-48(s0)
    24ba:	0007871b          	sext.w	a4,a5
    24be:	1f400793          	li	a5,500
    24c2:	00f70e63          	beq	a4,a5,24de <fourfiles+0x116>
          printf("write failed %d\n", n);
    24c6:	fd042783          	lw	a5,-48(s0)
    24ca:	85be                	mv	a1,a5
    24cc:	00006517          	auipc	a0,0x6
    24d0:	ea450513          	addi	a0,a0,-348 # 8370 <malloc+0xc8c>
    24d4:	028050ef          	jal	74fc <printf>
          exit(1);
    24d8:	4505                	li	a0,1
    24da:	0ff040ef          	jal	6dd8 <exit>
      for(i = 0; i < N; i++){
    24de:	fec42783          	lw	a5,-20(s0)
    24e2:	2785                	addiw	a5,a5,1
    24e4:	fef42623          	sw	a5,-20(s0)
    24e8:	fec42783          	lw	a5,-20(s0)
    24ec:	0007871b          	sext.w	a4,a5
    24f0:	47ad                	li	a5,11
    24f2:	fae7d4e3          	bge	a5,a4,249a <fourfiles+0xd2>
        }
      }
      exit(0);
    24f6:	4501                	li	a0,0
    24f8:	0e1040ef          	jal	6dd8 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    24fc:	fe042783          	lw	a5,-32(s0)
    2500:	2785                	addiw	a5,a5,1
    2502:	fef42023          	sw	a5,-32(s0)
    2506:	fe042783          	lw	a5,-32(s0)
    250a:	0007871b          	sext.w	a4,a5
    250e:	478d                	li	a5,3
    2510:	eee7d5e3          	bge	a5,a4,23fa <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2514:	fe042023          	sw	zero,-32(s0)
    2518:	a01d                	j	253e <fourfiles+0x176>
    wait(&xstatus);
    251a:	fa440793          	addi	a5,s0,-92
    251e:	853e                	mv	a0,a5
    2520:	0c1040ef          	jal	6de0 <wait>
    if(xstatus != 0)
    2524:	fa442783          	lw	a5,-92(s0)
    2528:	c791                	beqz	a5,2534 <fourfiles+0x16c>
      exit(xstatus);
    252a:	fa442783          	lw	a5,-92(s0)
    252e:	853e                	mv	a0,a5
    2530:	0a9040ef          	jal	6dd8 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2534:	fe042783          	lw	a5,-32(s0)
    2538:	2785                	addiw	a5,a5,1
    253a:	fef42023          	sw	a5,-32(s0)
    253e:	fe042783          	lw	a5,-32(s0)
    2542:	0007871b          	sext.w	a4,a5
    2546:	478d                	li	a5,3
    2548:	fce7d9e3          	bge	a5,a4,251a <fourfiles+0x152>
  }

  for(i = 0; i < NCHILD; i++){
    254c:	fe042623          	sw	zero,-20(s0)
    2550:	a201                	j	2650 <fourfiles+0x288>
    fname = names[i];
    2552:	fec42703          	lw	a4,-20(s0)
    2556:	fa840793          	addi	a5,s0,-88
    255a:	070e                	slli	a4,a4,0x3
    255c:	97ba                	add	a5,a5,a4
    255e:	639c                	ld	a5,0(a5)
    2560:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2564:	4581                	li	a1,0
    2566:	fd843503          	ld	a0,-40(s0)
    256a:	0af040ef          	jal	6e18 <open>
    256e:	87aa                	mv	a5,a0
    2570:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2574:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2578:	a0bd                	j	25e6 <fourfiles+0x21e>
      for(j = 0; j < n; j++){
    257a:	fe042423          	sw	zero,-24(s0)
    257e:	a099                	j	25c4 <fourfiles+0x1fc>
        if(buf[j] != '0'+i){
    2580:	00008717          	auipc	a4,0x8
    2584:	f3070713          	addi	a4,a4,-208 # a4b0 <buf>
    2588:	fe842783          	lw	a5,-24(s0)
    258c:	97ba                	add	a5,a5,a4
    258e:	0007c783          	lbu	a5,0(a5)
    2592:	0007871b          	sext.w	a4,a5
    2596:	fec42783          	lw	a5,-20(s0)
    259a:	0307879b          	addiw	a5,a5,48
    259e:	2781                	sext.w	a5,a5
    25a0:	00f70d63          	beq	a4,a5,25ba <fourfiles+0x1f2>
          printf("%s: wrong char\n", s);
    25a4:	f9843583          	ld	a1,-104(s0)
    25a8:	00006517          	auipc	a0,0x6
    25ac:	de050513          	addi	a0,a0,-544 # 8388 <malloc+0xca4>
    25b0:	74d040ef          	jal	74fc <printf>
          exit(1);
    25b4:	4505                	li	a0,1
    25b6:	023040ef          	jal	6dd8 <exit>
      for(j = 0; j < n; j++){
    25ba:	fe842783          	lw	a5,-24(s0)
    25be:	2785                	addiw	a5,a5,1
    25c0:	fef42423          	sw	a5,-24(s0)
    25c4:	fe842783          	lw	a5,-24(s0)
    25c8:	873e                	mv	a4,a5
    25ca:	fd042783          	lw	a5,-48(s0)
    25ce:	2701                	sext.w	a4,a4
    25d0:	2781                	sext.w	a5,a5
    25d2:	faf747e3          	blt	a4,a5,2580 <fourfiles+0x1b8>
        }
      }
      total += n;
    25d6:	fe442783          	lw	a5,-28(s0)
    25da:	873e                	mv	a4,a5
    25dc:	fd042783          	lw	a5,-48(s0)
    25e0:	9fb9                	addw	a5,a5,a4
    25e2:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    25e6:	fd442783          	lw	a5,-44(s0)
    25ea:	660d                	lui	a2,0x3
    25ec:	00008597          	auipc	a1,0x8
    25f0:	ec458593          	addi	a1,a1,-316 # a4b0 <buf>
    25f4:	853e                	mv	a0,a5
    25f6:	7fa040ef          	jal	6df0 <read>
    25fa:	87aa                	mv	a5,a0
    25fc:	fcf42823          	sw	a5,-48(s0)
    2600:	fd042783          	lw	a5,-48(s0)
    2604:	2781                	sext.w	a5,a5
    2606:	f6f04ae3          	bgtz	a5,257a <fourfiles+0x1b2>
    }
    close(fd);
    260a:	fd442783          	lw	a5,-44(s0)
    260e:	853e                	mv	a0,a5
    2610:	7f0040ef          	jal	6e00 <close>
    if(total != N*SZ){
    2614:	fe442783          	lw	a5,-28(s0)
    2618:	0007871b          	sext.w	a4,a5
    261c:	6785                	lui	a5,0x1
    261e:	77078793          	addi	a5,a5,1904 # 1770 <exectest+0x126>
    2622:	00f70e63          	beq	a4,a5,263e <fourfiles+0x276>
      printf("wrong length %d\n", total);
    2626:	fe442783          	lw	a5,-28(s0)
    262a:	85be                	mv	a1,a5
    262c:	00006517          	auipc	a0,0x6
    2630:	d6c50513          	addi	a0,a0,-660 # 8398 <malloc+0xcb4>
    2634:	6c9040ef          	jal	74fc <printf>
      exit(1);
    2638:	4505                	li	a0,1
    263a:	79e040ef          	jal	6dd8 <exit>
    }
    unlink(fname);
    263e:	fd843503          	ld	a0,-40(s0)
    2642:	7e6040ef          	jal	6e28 <unlink>
  for(i = 0; i < NCHILD; i++){
    2646:	fec42783          	lw	a5,-20(s0)
    264a:	2785                	addiw	a5,a5,1
    264c:	fef42623          	sw	a5,-20(s0)
    2650:	fec42783          	lw	a5,-20(s0)
    2654:	0007871b          	sext.w	a4,a5
    2658:	478d                	li	a5,3
    265a:	eee7dce3          	bge	a5,a4,2552 <fourfiles+0x18a>
  }
}
    265e:	0001                	nop
    2660:	0001                	nop
    2662:	70a6                	ld	ra,104(sp)
    2664:	7406                	ld	s0,96(sp)
    2666:	6165                	addi	sp,sp,112
    2668:	8082                	ret

000000000000266a <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    266a:	711d                	addi	sp,sp,-96
    266c:	ec86                	sd	ra,88(sp)
    266e:	e8a2                	sd	s0,80(sp)
    2670:	1080                	addi	s0,sp,96
    2672:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2676:	fe042423          	sw	zero,-24(s0)
    267a:	a225                	j	27a2 <createdelete+0x138>
    pid = fork();
    267c:	754040ef          	jal	6dd0 <fork>
    2680:	87aa                	mv	a5,a0
    2682:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2686:	fe042783          	lw	a5,-32(s0)
    268a:	2781                	sext.w	a5,a5
    268c:	0007dd63          	bgez	a5,26a6 <createdelete+0x3c>
      printf("%s: fork failed\n", s);
    2690:	fa843583          	ld	a1,-88(s0)
    2694:	00005517          	auipc	a0,0x5
    2698:	62450513          	addi	a0,a0,1572 # 7cb8 <malloc+0x5d4>
    269c:	661040ef          	jal	74fc <printf>
      exit(1);
    26a0:	4505                	li	a0,1
    26a2:	736040ef          	jal	6dd8 <exit>
    }

    if(pid == 0){
    26a6:	fe042783          	lw	a5,-32(s0)
    26aa:	2781                	sext.w	a5,a5
    26ac:	0e079663          	bnez	a5,2798 <createdelete+0x12e>
      name[0] = 'p' + pi;
    26b0:	fe842783          	lw	a5,-24(s0)
    26b4:	0ff7f793          	zext.b	a5,a5
    26b8:	0707879b          	addiw	a5,a5,112
    26bc:	0ff7f793          	zext.b	a5,a5
    26c0:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    26c4:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    26c8:	fe042623          	sw	zero,-20(s0)
    26cc:	a865                	j	2784 <createdelete+0x11a>
        name[1] = '0' + i;
    26ce:	fec42783          	lw	a5,-20(s0)
    26d2:	0ff7f793          	zext.b	a5,a5
    26d6:	0307879b          	addiw	a5,a5,48
    26da:	0ff7f793          	zext.b	a5,a5
    26de:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    26e2:	fc040793          	addi	a5,s0,-64
    26e6:	20200593          	li	a1,514
    26ea:	853e                	mv	a0,a5
    26ec:	72c040ef          	jal	6e18 <open>
    26f0:	87aa                	mv	a5,a0
    26f2:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    26f6:	fe442783          	lw	a5,-28(s0)
    26fa:	2781                	sext.w	a5,a5
    26fc:	0007dd63          	bgez	a5,2716 <createdelete+0xac>
          printf("%s: create failed\n", s);
    2700:	fa843583          	ld	a1,-88(s0)
    2704:	00006517          	auipc	a0,0x6
    2708:	9dc50513          	addi	a0,a0,-1572 # 80e0 <malloc+0x9fc>
    270c:	5f1040ef          	jal	74fc <printf>
          exit(1);
    2710:	4505                	li	a0,1
    2712:	6c6040ef          	jal	6dd8 <exit>
        }
        close(fd);
    2716:	fe442783          	lw	a5,-28(s0)
    271a:	853e                	mv	a0,a5
    271c:	6e4040ef          	jal	6e00 <close>
        if(i > 0 && (i % 2 ) == 0){
    2720:	fec42783          	lw	a5,-20(s0)
    2724:	2781                	sext.w	a5,a5
    2726:	04f05a63          	blez	a5,277a <createdelete+0x110>
    272a:	fec42783          	lw	a5,-20(s0)
    272e:	8b85                	andi	a5,a5,1
    2730:	2781                	sext.w	a5,a5
    2732:	e7a1                	bnez	a5,277a <createdelete+0x110>
          name[1] = '0' + (i / 2);
    2734:	fec42783          	lw	a5,-20(s0)
    2738:	01f7d71b          	srliw	a4,a5,0x1f
    273c:	9fb9                	addw	a5,a5,a4
    273e:	4017d79b          	sraiw	a5,a5,0x1
    2742:	2781                	sext.w	a5,a5
    2744:	0ff7f793          	zext.b	a5,a5
    2748:	0307879b          	addiw	a5,a5,48
    274c:	0ff7f793          	zext.b	a5,a5
    2750:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2754:	fc040793          	addi	a5,s0,-64
    2758:	853e                	mv	a0,a5
    275a:	6ce040ef          	jal	6e28 <unlink>
    275e:	87aa                	mv	a5,a0
    2760:	0007dd63          	bgez	a5,277a <createdelete+0x110>
            printf("%s: unlink failed\n", s);
    2764:	fa843583          	ld	a1,-88(s0)
    2768:	00005517          	auipc	a0,0x5
    276c:	6c850513          	addi	a0,a0,1736 # 7e30 <malloc+0x74c>
    2770:	58d040ef          	jal	74fc <printf>
            exit(1);
    2774:	4505                	li	a0,1
    2776:	662040ef          	jal	6dd8 <exit>
      for(i = 0; i < N; i++){
    277a:	fec42783          	lw	a5,-20(s0)
    277e:	2785                	addiw	a5,a5,1
    2780:	fef42623          	sw	a5,-20(s0)
    2784:	fec42783          	lw	a5,-20(s0)
    2788:	0007871b          	sext.w	a4,a5
    278c:	47cd                	li	a5,19
    278e:	f4e7d0e3          	bge	a5,a4,26ce <createdelete+0x64>
          }
        }
      }
      exit(0);
    2792:	4501                	li	a0,0
    2794:	644040ef          	jal	6dd8 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2798:	fe842783          	lw	a5,-24(s0)
    279c:	2785                	addiw	a5,a5,1
    279e:	fef42423          	sw	a5,-24(s0)
    27a2:	fe842783          	lw	a5,-24(s0)
    27a6:	0007871b          	sext.w	a4,a5
    27aa:	478d                	li	a5,3
    27ac:	ece7d8e3          	bge	a5,a4,267c <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    27b0:	fe042423          	sw	zero,-24(s0)
    27b4:	a00d                	j	27d6 <createdelete+0x16c>
    wait(&xstatus);
    27b6:	fbc40793          	addi	a5,s0,-68
    27ba:	853e                	mv	a0,a5
    27bc:	624040ef          	jal	6de0 <wait>
    if(xstatus != 0)
    27c0:	fbc42783          	lw	a5,-68(s0)
    27c4:	c781                	beqz	a5,27cc <createdelete+0x162>
      exit(1);
    27c6:	4505                	li	a0,1
    27c8:	610040ef          	jal	6dd8 <exit>
  for(pi = 0; pi < NCHILD; pi++){
    27cc:	fe842783          	lw	a5,-24(s0)
    27d0:	2785                	addiw	a5,a5,1
    27d2:	fef42423          	sw	a5,-24(s0)
    27d6:	fe842783          	lw	a5,-24(s0)
    27da:	0007871b          	sext.w	a4,a5
    27de:	478d                	li	a5,3
    27e0:	fce7dbe3          	bge	a5,a4,27b6 <createdelete+0x14c>
  }

  name[0] = name[1] = name[2] = 0;
    27e4:	fc040123          	sb	zero,-62(s0)
    27e8:	fc244783          	lbu	a5,-62(s0)
    27ec:	fcf400a3          	sb	a5,-63(s0)
    27f0:	fc144783          	lbu	a5,-63(s0)
    27f4:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    27f8:	fe042623          	sw	zero,-20(s0)
    27fc:	a8cd                	j	28ee <createdelete+0x284>
    for(pi = 0; pi < NCHILD; pi++){
    27fe:	fe042423          	sw	zero,-24(s0)
    2802:	a8d1                	j	28d6 <createdelete+0x26c>
      name[0] = 'p' + pi;
    2804:	fe842783          	lw	a5,-24(s0)
    2808:	0ff7f793          	zext.b	a5,a5
    280c:	0707879b          	addiw	a5,a5,112
    2810:	0ff7f793          	zext.b	a5,a5
    2814:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2818:	fec42783          	lw	a5,-20(s0)
    281c:	0ff7f793          	zext.b	a5,a5
    2820:	0307879b          	addiw	a5,a5,48
    2824:	0ff7f793          	zext.b	a5,a5
    2828:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    282c:	fc040793          	addi	a5,s0,-64
    2830:	4581                	li	a1,0
    2832:	853e                	mv	a0,a5
    2834:	5e4040ef          	jal	6e18 <open>
    2838:	87aa                	mv	a5,a0
    283a:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    283e:	fec42783          	lw	a5,-20(s0)
    2842:	2781                	sext.w	a5,a5
    2844:	cb81                	beqz	a5,2854 <createdelete+0x1ea>
    2846:	fec42783          	lw	a5,-20(s0)
    284a:	0007871b          	sext.w	a4,a5
    284e:	47a5                	li	a5,9
    2850:	02e7d563          	bge	a5,a4,287a <createdelete+0x210>
    2854:	fe442783          	lw	a5,-28(s0)
    2858:	2781                	sext.w	a5,a5
    285a:	0207d063          	bgez	a5,287a <createdelete+0x210>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    285e:	fc040793          	addi	a5,s0,-64
    2862:	863e                	mv	a2,a5
    2864:	fa843583          	ld	a1,-88(s0)
    2868:	00006517          	auipc	a0,0x6
    286c:	b8850513          	addi	a0,a0,-1144 # 83f0 <malloc+0xd0c>
    2870:	48d040ef          	jal	74fc <printf>
        exit(1);
    2874:	4505                	li	a0,1
    2876:	562040ef          	jal	6dd8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    287a:	fec42783          	lw	a5,-20(s0)
    287e:	2781                	sext.w	a5,a5
    2880:	02f05c63          	blez	a5,28b8 <createdelete+0x24e>
    2884:	fec42783          	lw	a5,-20(s0)
    2888:	0007871b          	sext.w	a4,a5
    288c:	47a5                	li	a5,9
    288e:	02e7c563          	blt	a5,a4,28b8 <createdelete+0x24e>
    2892:	fe442783          	lw	a5,-28(s0)
    2896:	2781                	sext.w	a5,a5
    2898:	0207c063          	bltz	a5,28b8 <createdelete+0x24e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    289c:	fc040793          	addi	a5,s0,-64
    28a0:	863e                	mv	a2,a5
    28a2:	fa843583          	ld	a1,-88(s0)
    28a6:	00006517          	auipc	a0,0x6
    28aa:	b7250513          	addi	a0,a0,-1166 # 8418 <malloc+0xd34>
    28ae:	44f040ef          	jal	74fc <printf>
        exit(1);
    28b2:	4505                	li	a0,1
    28b4:	524040ef          	jal	6dd8 <exit>
      }
      if(fd >= 0)
    28b8:	fe442783          	lw	a5,-28(s0)
    28bc:	2781                	sext.w	a5,a5
    28be:	0007c763          	bltz	a5,28cc <createdelete+0x262>
        close(fd);
    28c2:	fe442783          	lw	a5,-28(s0)
    28c6:	853e                	mv	a0,a5
    28c8:	538040ef          	jal	6e00 <close>
    for(pi = 0; pi < NCHILD; pi++){
    28cc:	fe842783          	lw	a5,-24(s0)
    28d0:	2785                	addiw	a5,a5,1
    28d2:	fef42423          	sw	a5,-24(s0)
    28d6:	fe842783          	lw	a5,-24(s0)
    28da:	0007871b          	sext.w	a4,a5
    28de:	478d                	li	a5,3
    28e0:	f2e7d2e3          	bge	a5,a4,2804 <createdelete+0x19a>
  for(i = 0; i < N; i++){
    28e4:	fec42783          	lw	a5,-20(s0)
    28e8:	2785                	addiw	a5,a5,1
    28ea:	fef42623          	sw	a5,-20(s0)
    28ee:	fec42783          	lw	a5,-20(s0)
    28f2:	0007871b          	sext.w	a4,a5
    28f6:	47cd                	li	a5,19
    28f8:	f0e7d3e3          	bge	a5,a4,27fe <createdelete+0x194>
    }
  }

  for(i = 0; i < N; i++){
    28fc:	fe042623          	sw	zero,-20(s0)
    2900:	a8b1                	j	295c <createdelete+0x2f2>
    for(pi = 0; pi < NCHILD; pi++){
    2902:	fe042423          	sw	zero,-24(s0)
    2906:	a83d                	j	2944 <createdelete+0x2da>
      name[0] = 'p' + pi;
    2908:	fe842783          	lw	a5,-24(s0)
    290c:	0ff7f793          	zext.b	a5,a5
    2910:	0707879b          	addiw	a5,a5,112
    2914:	0ff7f793          	zext.b	a5,a5
    2918:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    291c:	fec42783          	lw	a5,-20(s0)
    2920:	0ff7f793          	zext.b	a5,a5
    2924:	0307879b          	addiw	a5,a5,48
    2928:	0ff7f793          	zext.b	a5,a5
    292c:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    2930:	fc040793          	addi	a5,s0,-64
    2934:	853e                	mv	a0,a5
    2936:	4f2040ef          	jal	6e28 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    293a:	fe842783          	lw	a5,-24(s0)
    293e:	2785                	addiw	a5,a5,1
    2940:	fef42423          	sw	a5,-24(s0)
    2944:	fe842783          	lw	a5,-24(s0)
    2948:	0007871b          	sext.w	a4,a5
    294c:	478d                	li	a5,3
    294e:	fae7dde3          	bge	a5,a4,2908 <createdelete+0x29e>
  for(i = 0; i < N; i++){
    2952:	fec42783          	lw	a5,-20(s0)
    2956:	2785                	addiw	a5,a5,1
    2958:	fef42623          	sw	a5,-20(s0)
    295c:	fec42783          	lw	a5,-20(s0)
    2960:	0007871b          	sext.w	a4,a5
    2964:	47cd                	li	a5,19
    2966:	f8e7dee3          	bge	a5,a4,2902 <createdelete+0x298>
    }
  }
}
    296a:	0001                	nop
    296c:	0001                	nop
    296e:	60e6                	ld	ra,88(sp)
    2970:	6446                	ld	s0,80(sp)
    2972:	6125                	addi	sp,sp,96
    2974:	8082                	ret

0000000000002976 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    2976:	7179                	addi	sp,sp,-48
    2978:	f406                	sd	ra,40(sp)
    297a:	f022                	sd	s0,32(sp)
    297c:	1800                	addi	s0,sp,48
    297e:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    2982:	20200593          	li	a1,514
    2986:	00006517          	auipc	a0,0x6
    298a:	aba50513          	addi	a0,a0,-1350 # 8440 <malloc+0xd5c>
    298e:	48a040ef          	jal	6e18 <open>
    2992:	87aa                	mv	a5,a0
    2994:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    2998:	fec42783          	lw	a5,-20(s0)
    299c:	2781                	sext.w	a5,a5
    299e:	0007dd63          	bgez	a5,29b8 <unlinkread+0x42>
    printf("%s: create unlinkread failed\n", s);
    29a2:	fd843583          	ld	a1,-40(s0)
    29a6:	00006517          	auipc	a0,0x6
    29aa:	aaa50513          	addi	a0,a0,-1366 # 8450 <malloc+0xd6c>
    29ae:	34f040ef          	jal	74fc <printf>
    exit(1);
    29b2:	4505                	li	a0,1
    29b4:	424040ef          	jal	6dd8 <exit>
  }
  write(fd, "hello", SZ);
    29b8:	fec42783          	lw	a5,-20(s0)
    29bc:	4615                	li	a2,5
    29be:	00006597          	auipc	a1,0x6
    29c2:	ab258593          	addi	a1,a1,-1358 # 8470 <malloc+0xd8c>
    29c6:	853e                	mv	a0,a5
    29c8:	430040ef          	jal	6df8 <write>
  close(fd);
    29cc:	fec42783          	lw	a5,-20(s0)
    29d0:	853e                	mv	a0,a5
    29d2:	42e040ef          	jal	6e00 <close>

  fd = open("unlinkread", O_RDWR);
    29d6:	4589                	li	a1,2
    29d8:	00006517          	auipc	a0,0x6
    29dc:	a6850513          	addi	a0,a0,-1432 # 8440 <malloc+0xd5c>
    29e0:	438040ef          	jal	6e18 <open>
    29e4:	87aa                	mv	a5,a0
    29e6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    29ea:	fec42783          	lw	a5,-20(s0)
    29ee:	2781                	sext.w	a5,a5
    29f0:	0007dd63          	bgez	a5,2a0a <unlinkread+0x94>
    printf("%s: open unlinkread failed\n", s);
    29f4:	fd843583          	ld	a1,-40(s0)
    29f8:	00006517          	auipc	a0,0x6
    29fc:	a8050513          	addi	a0,a0,-1408 # 8478 <malloc+0xd94>
    2a00:	2fd040ef          	jal	74fc <printf>
    exit(1);
    2a04:	4505                	li	a0,1
    2a06:	3d2040ef          	jal	6dd8 <exit>
  }
  if(unlink("unlinkread") != 0){
    2a0a:	00006517          	auipc	a0,0x6
    2a0e:	a3650513          	addi	a0,a0,-1482 # 8440 <malloc+0xd5c>
    2a12:	416040ef          	jal	6e28 <unlink>
    2a16:	87aa                	mv	a5,a0
    2a18:	cf81                	beqz	a5,2a30 <unlinkread+0xba>
    printf("%s: unlink unlinkread failed\n", s);
    2a1a:	fd843583          	ld	a1,-40(s0)
    2a1e:	00006517          	auipc	a0,0x6
    2a22:	a7a50513          	addi	a0,a0,-1414 # 8498 <malloc+0xdb4>
    2a26:	2d7040ef          	jal	74fc <printf>
    exit(1);
    2a2a:	4505                	li	a0,1
    2a2c:	3ac040ef          	jal	6dd8 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    2a30:	20200593          	li	a1,514
    2a34:	00006517          	auipc	a0,0x6
    2a38:	a0c50513          	addi	a0,a0,-1524 # 8440 <malloc+0xd5c>
    2a3c:	3dc040ef          	jal	6e18 <open>
    2a40:	87aa                	mv	a5,a0
    2a42:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    2a46:	fe842783          	lw	a5,-24(s0)
    2a4a:	460d                	li	a2,3
    2a4c:	00006597          	auipc	a1,0x6
    2a50:	a6c58593          	addi	a1,a1,-1428 # 84b8 <malloc+0xdd4>
    2a54:	853e                	mv	a0,a5
    2a56:	3a2040ef          	jal	6df8 <write>
  close(fd1);
    2a5a:	fe842783          	lw	a5,-24(s0)
    2a5e:	853e                	mv	a0,a5
    2a60:	3a0040ef          	jal	6e00 <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    2a64:	fec42783          	lw	a5,-20(s0)
    2a68:	660d                	lui	a2,0x3
    2a6a:	00008597          	auipc	a1,0x8
    2a6e:	a4658593          	addi	a1,a1,-1466 # a4b0 <buf>
    2a72:	853e                	mv	a0,a5
    2a74:	37c040ef          	jal	6df0 <read>
    2a78:	87aa                	mv	a5,a0
    2a7a:	873e                	mv	a4,a5
    2a7c:	4795                	li	a5,5
    2a7e:	00f70d63          	beq	a4,a5,2a98 <unlinkread+0x122>
    printf("%s: unlinkread read failed", s);
    2a82:	fd843583          	ld	a1,-40(s0)
    2a86:	00006517          	auipc	a0,0x6
    2a8a:	a3a50513          	addi	a0,a0,-1478 # 84c0 <malloc+0xddc>
    2a8e:	26f040ef          	jal	74fc <printf>
    exit(1);
    2a92:	4505                	li	a0,1
    2a94:	344040ef          	jal	6dd8 <exit>
  }
  if(buf[0] != 'h'){
    2a98:	00008797          	auipc	a5,0x8
    2a9c:	a1878793          	addi	a5,a5,-1512 # a4b0 <buf>
    2aa0:	0007c783          	lbu	a5,0(a5)
    2aa4:	873e                	mv	a4,a5
    2aa6:	06800793          	li	a5,104
    2aaa:	00f70d63          	beq	a4,a5,2ac4 <unlinkread+0x14e>
    printf("%s: unlinkread wrong data\n", s);
    2aae:	fd843583          	ld	a1,-40(s0)
    2ab2:	00006517          	auipc	a0,0x6
    2ab6:	a2e50513          	addi	a0,a0,-1490 # 84e0 <malloc+0xdfc>
    2aba:	243040ef          	jal	74fc <printf>
    exit(1);
    2abe:	4505                	li	a0,1
    2ac0:	318040ef          	jal	6dd8 <exit>
  }
  if(write(fd, buf, 10) != 10){
    2ac4:	fec42783          	lw	a5,-20(s0)
    2ac8:	4629                	li	a2,10
    2aca:	00008597          	auipc	a1,0x8
    2ace:	9e658593          	addi	a1,a1,-1562 # a4b0 <buf>
    2ad2:	853e                	mv	a0,a5
    2ad4:	324040ef          	jal	6df8 <write>
    2ad8:	87aa                	mv	a5,a0
    2ada:	873e                	mv	a4,a5
    2adc:	47a9                	li	a5,10
    2ade:	00f70d63          	beq	a4,a5,2af8 <unlinkread+0x182>
    printf("%s: unlinkread write failed\n", s);
    2ae2:	fd843583          	ld	a1,-40(s0)
    2ae6:	00006517          	auipc	a0,0x6
    2aea:	a1a50513          	addi	a0,a0,-1510 # 8500 <malloc+0xe1c>
    2aee:	20f040ef          	jal	74fc <printf>
    exit(1);
    2af2:	4505                	li	a0,1
    2af4:	2e4040ef          	jal	6dd8 <exit>
  }
  close(fd);
    2af8:	fec42783          	lw	a5,-20(s0)
    2afc:	853e                	mv	a0,a5
    2afe:	302040ef          	jal	6e00 <close>
  unlink("unlinkread");
    2b02:	00006517          	auipc	a0,0x6
    2b06:	93e50513          	addi	a0,a0,-1730 # 8440 <malloc+0xd5c>
    2b0a:	31e040ef          	jal	6e28 <unlink>
}
    2b0e:	0001                	nop
    2b10:	70a2                	ld	ra,40(sp)
    2b12:	7402                	ld	s0,32(sp)
    2b14:	6145                	addi	sp,sp,48
    2b16:	8082                	ret

0000000000002b18 <linktest>:

void
linktest(char *s)
{
    2b18:	7179                	addi	sp,sp,-48
    2b1a:	f406                	sd	ra,40(sp)
    2b1c:	f022                	sd	s0,32(sp)
    2b1e:	1800                	addi	s0,sp,48
    2b20:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    2b24:	00006517          	auipc	a0,0x6
    2b28:	9fc50513          	addi	a0,a0,-1540 # 8520 <malloc+0xe3c>
    2b2c:	2fc040ef          	jal	6e28 <unlink>
  unlink("lf2");
    2b30:	00006517          	auipc	a0,0x6
    2b34:	9f850513          	addi	a0,a0,-1544 # 8528 <malloc+0xe44>
    2b38:	2f0040ef          	jal	6e28 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    2b3c:	20200593          	li	a1,514
    2b40:	00006517          	auipc	a0,0x6
    2b44:	9e050513          	addi	a0,a0,-1568 # 8520 <malloc+0xe3c>
    2b48:	2d0040ef          	jal	6e18 <open>
    2b4c:	87aa                	mv	a5,a0
    2b4e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    2b52:	fec42783          	lw	a5,-20(s0)
    2b56:	2781                	sext.w	a5,a5
    2b58:	0007dd63          	bgez	a5,2b72 <linktest+0x5a>
    printf("%s: create lf1 failed\n", s);
    2b5c:	fd843583          	ld	a1,-40(s0)
    2b60:	00006517          	auipc	a0,0x6
    2b64:	9d050513          	addi	a0,a0,-1584 # 8530 <malloc+0xe4c>
    2b68:	195040ef          	jal	74fc <printf>
    exit(1);
    2b6c:	4505                	li	a0,1
    2b6e:	26a040ef          	jal	6dd8 <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    2b72:	fec42783          	lw	a5,-20(s0)
    2b76:	4615                	li	a2,5
    2b78:	00006597          	auipc	a1,0x6
    2b7c:	8f858593          	addi	a1,a1,-1800 # 8470 <malloc+0xd8c>
    2b80:	853e                	mv	a0,a5
    2b82:	276040ef          	jal	6df8 <write>
    2b86:	87aa                	mv	a5,a0
    2b88:	873e                	mv	a4,a5
    2b8a:	4795                	li	a5,5
    2b8c:	00f70d63          	beq	a4,a5,2ba6 <linktest+0x8e>
    printf("%s: write lf1 failed\n", s);
    2b90:	fd843583          	ld	a1,-40(s0)
    2b94:	00006517          	auipc	a0,0x6
    2b98:	9b450513          	addi	a0,a0,-1612 # 8548 <malloc+0xe64>
    2b9c:	161040ef          	jal	74fc <printf>
    exit(1);
    2ba0:	4505                	li	a0,1
    2ba2:	236040ef          	jal	6dd8 <exit>
  }
  close(fd);
    2ba6:	fec42783          	lw	a5,-20(s0)
    2baa:	853e                	mv	a0,a5
    2bac:	254040ef          	jal	6e00 <close>

  if(link("lf1", "lf2") < 0){
    2bb0:	00006597          	auipc	a1,0x6
    2bb4:	97858593          	addi	a1,a1,-1672 # 8528 <malloc+0xe44>
    2bb8:	00006517          	auipc	a0,0x6
    2bbc:	96850513          	addi	a0,a0,-1688 # 8520 <malloc+0xe3c>
    2bc0:	278040ef          	jal	6e38 <link>
    2bc4:	87aa                	mv	a5,a0
    2bc6:	0007dd63          	bgez	a5,2be0 <linktest+0xc8>
    printf("%s: link lf1 lf2 failed\n", s);
    2bca:	fd843583          	ld	a1,-40(s0)
    2bce:	00006517          	auipc	a0,0x6
    2bd2:	99250513          	addi	a0,a0,-1646 # 8560 <malloc+0xe7c>
    2bd6:	127040ef          	jal	74fc <printf>
    exit(1);
    2bda:	4505                	li	a0,1
    2bdc:	1fc040ef          	jal	6dd8 <exit>
  }
  unlink("lf1");
    2be0:	00006517          	auipc	a0,0x6
    2be4:	94050513          	addi	a0,a0,-1728 # 8520 <malloc+0xe3c>
    2be8:	240040ef          	jal	6e28 <unlink>

  if(open("lf1", 0) >= 0){
    2bec:	4581                	li	a1,0
    2bee:	00006517          	auipc	a0,0x6
    2bf2:	93250513          	addi	a0,a0,-1742 # 8520 <malloc+0xe3c>
    2bf6:	222040ef          	jal	6e18 <open>
    2bfa:	87aa                	mv	a5,a0
    2bfc:	0007cd63          	bltz	a5,2c16 <linktest+0xfe>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    2c00:	fd843583          	ld	a1,-40(s0)
    2c04:	00006517          	auipc	a0,0x6
    2c08:	97c50513          	addi	a0,a0,-1668 # 8580 <malloc+0xe9c>
    2c0c:	0f1040ef          	jal	74fc <printf>
    exit(1);
    2c10:	4505                	li	a0,1
    2c12:	1c6040ef          	jal	6dd8 <exit>
  }

  fd = open("lf2", 0);
    2c16:	4581                	li	a1,0
    2c18:	00006517          	auipc	a0,0x6
    2c1c:	91050513          	addi	a0,a0,-1776 # 8528 <malloc+0xe44>
    2c20:	1f8040ef          	jal	6e18 <open>
    2c24:	87aa                	mv	a5,a0
    2c26:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    2c2a:	fec42783          	lw	a5,-20(s0)
    2c2e:	2781                	sext.w	a5,a5
    2c30:	0007dd63          	bgez	a5,2c4a <linktest+0x132>
    printf("%s: open lf2 failed\n", s);
    2c34:	fd843583          	ld	a1,-40(s0)
    2c38:	00006517          	auipc	a0,0x6
    2c3c:	97850513          	addi	a0,a0,-1672 # 85b0 <malloc+0xecc>
    2c40:	0bd040ef          	jal	74fc <printf>
    exit(1);
    2c44:	4505                	li	a0,1
    2c46:	192040ef          	jal	6dd8 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    2c4a:	fec42783          	lw	a5,-20(s0)
    2c4e:	660d                	lui	a2,0x3
    2c50:	00008597          	auipc	a1,0x8
    2c54:	86058593          	addi	a1,a1,-1952 # a4b0 <buf>
    2c58:	853e                	mv	a0,a5
    2c5a:	196040ef          	jal	6df0 <read>
    2c5e:	87aa                	mv	a5,a0
    2c60:	873e                	mv	a4,a5
    2c62:	4795                	li	a5,5
    2c64:	00f70d63          	beq	a4,a5,2c7e <linktest+0x166>
    printf("%s: read lf2 failed\n", s);
    2c68:	fd843583          	ld	a1,-40(s0)
    2c6c:	00006517          	auipc	a0,0x6
    2c70:	95c50513          	addi	a0,a0,-1700 # 85c8 <malloc+0xee4>
    2c74:	089040ef          	jal	74fc <printf>
    exit(1);
    2c78:	4505                	li	a0,1
    2c7a:	15e040ef          	jal	6dd8 <exit>
  }
  close(fd);
    2c7e:	fec42783          	lw	a5,-20(s0)
    2c82:	853e                	mv	a0,a5
    2c84:	17c040ef          	jal	6e00 <close>

  if(link("lf2", "lf2") >= 0){
    2c88:	00006597          	auipc	a1,0x6
    2c8c:	8a058593          	addi	a1,a1,-1888 # 8528 <malloc+0xe44>
    2c90:	00006517          	auipc	a0,0x6
    2c94:	89850513          	addi	a0,a0,-1896 # 8528 <malloc+0xe44>
    2c98:	1a0040ef          	jal	6e38 <link>
    2c9c:	87aa                	mv	a5,a0
    2c9e:	0007cd63          	bltz	a5,2cb8 <linktest+0x1a0>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    2ca2:	fd843583          	ld	a1,-40(s0)
    2ca6:	00006517          	auipc	a0,0x6
    2caa:	93a50513          	addi	a0,a0,-1734 # 85e0 <malloc+0xefc>
    2cae:	04f040ef          	jal	74fc <printf>
    exit(1);
    2cb2:	4505                	li	a0,1
    2cb4:	124040ef          	jal	6dd8 <exit>
  }

  unlink("lf2");
    2cb8:	00006517          	auipc	a0,0x6
    2cbc:	87050513          	addi	a0,a0,-1936 # 8528 <malloc+0xe44>
    2cc0:	168040ef          	jal	6e28 <unlink>
  if(link("lf2", "lf1") >= 0){
    2cc4:	00006597          	auipc	a1,0x6
    2cc8:	85c58593          	addi	a1,a1,-1956 # 8520 <malloc+0xe3c>
    2ccc:	00006517          	auipc	a0,0x6
    2cd0:	85c50513          	addi	a0,a0,-1956 # 8528 <malloc+0xe44>
    2cd4:	164040ef          	jal	6e38 <link>
    2cd8:	87aa                	mv	a5,a0
    2cda:	0007cd63          	bltz	a5,2cf4 <linktest+0x1dc>
    printf("%s: link non-existent succeeded! oops\n", s);
    2cde:	fd843583          	ld	a1,-40(s0)
    2ce2:	00006517          	auipc	a0,0x6
    2ce6:	92650513          	addi	a0,a0,-1754 # 8608 <malloc+0xf24>
    2cea:	013040ef          	jal	74fc <printf>
    exit(1);
    2cee:	4505                	li	a0,1
    2cf0:	0e8040ef          	jal	6dd8 <exit>
  }

  if(link(".", "lf1") >= 0){
    2cf4:	00006597          	auipc	a1,0x6
    2cf8:	82c58593          	addi	a1,a1,-2004 # 8520 <malloc+0xe3c>
    2cfc:	00006517          	auipc	a0,0x6
    2d00:	93450513          	addi	a0,a0,-1740 # 8630 <malloc+0xf4c>
    2d04:	134040ef          	jal	6e38 <link>
    2d08:	87aa                	mv	a5,a0
    2d0a:	0007cd63          	bltz	a5,2d24 <linktest+0x20c>
    printf("%s: link . lf1 succeeded! oops\n", s);
    2d0e:	fd843583          	ld	a1,-40(s0)
    2d12:	00006517          	auipc	a0,0x6
    2d16:	92650513          	addi	a0,a0,-1754 # 8638 <malloc+0xf54>
    2d1a:	7e2040ef          	jal	74fc <printf>
    exit(1);
    2d1e:	4505                	li	a0,1
    2d20:	0b8040ef          	jal	6dd8 <exit>
  }
}
    2d24:	0001                	nop
    2d26:	70a2                	ld	ra,40(sp)
    2d28:	7402                	ld	s0,32(sp)
    2d2a:	6145                	addi	sp,sp,48
    2d2c:	8082                	ret

0000000000002d2e <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    2d2e:	7119                	addi	sp,sp,-128
    2d30:	fc86                	sd	ra,120(sp)
    2d32:	f8a2                	sd	s0,112(sp)
    2d34:	0100                	addi	s0,sp,128
    2d36:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    2d3a:	04300793          	li	a5,67
    2d3e:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    2d42:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    2d46:	fe042623          	sw	zero,-20(s0)
    2d4a:	aa35                	j	2e86 <concreate+0x158>
    file[1] = '0' + i;
    2d4c:	fec42783          	lw	a5,-20(s0)
    2d50:	0ff7f793          	zext.b	a5,a5
    2d54:	0307879b          	addiw	a5,a5,48
    2d58:	0ff7f793          	zext.b	a5,a5
    2d5c:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    2d60:	fd840793          	addi	a5,s0,-40
    2d64:	853e                	mv	a0,a5
    2d66:	0c2040ef          	jal	6e28 <unlink>
    pid = fork();
    2d6a:	066040ef          	jal	6dd0 <fork>
    2d6e:	87aa                	mv	a5,a0
    2d70:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    2d74:	fe042783          	lw	a5,-32(s0)
    2d78:	2781                	sext.w	a5,a5
    2d7a:	c7a1                	beqz	a5,2dc2 <concreate+0x94>
    2d7c:	fec42783          	lw	a5,-20(s0)
    2d80:	0007869b          	sext.w	a3,a5
    2d84:	55555737          	lui	a4,0x55555
    2d88:	55670713          	addi	a4,a4,1366 # 55555556 <freep+0x5554487e>
    2d8c:	02e68733          	mul	a4,a3,a4
    2d90:	9301                	srli	a4,a4,0x20
    2d92:	41f7d69b          	sraiw	a3,a5,0x1f
    2d96:	9f15                	subw	a4,a4,a3
    2d98:	86ba                	mv	a3,a4
    2d9a:	8736                	mv	a4,a3
    2d9c:	0017171b          	slliw	a4,a4,0x1
    2da0:	9f35                	addw	a4,a4,a3
    2da2:	9f99                	subw	a5,a5,a4
    2da4:	0007871b          	sext.w	a4,a5
    2da8:	4785                	li	a5,1
    2daa:	00f71c63          	bne	a4,a5,2dc2 <concreate+0x94>
      link("C0", file);
    2dae:	fd840793          	addi	a5,s0,-40
    2db2:	85be                	mv	a1,a5
    2db4:	00006517          	auipc	a0,0x6
    2db8:	8a450513          	addi	a0,a0,-1884 # 8658 <malloc+0xf74>
    2dbc:	07c040ef          	jal	6e38 <link>
    2dc0:	a861                	j	2e58 <concreate+0x12a>
    } else if(pid == 0 && (i % 5) == 1){
    2dc2:	fe042783          	lw	a5,-32(s0)
    2dc6:	2781                	sext.w	a5,a5
    2dc8:	eba1                	bnez	a5,2e18 <concreate+0xea>
    2dca:	fec42783          	lw	a5,-20(s0)
    2dce:	0007869b          	sext.w	a3,a5
    2dd2:	66666737          	lui	a4,0x66666
    2dd6:	66770713          	addi	a4,a4,1639 # 66666667 <freep+0x6665598f>
    2dda:	02e68733          	mul	a4,a3,a4
    2dde:	9301                	srli	a4,a4,0x20
    2de0:	4017571b          	sraiw	a4,a4,0x1
    2de4:	86ba                	mv	a3,a4
    2de6:	41f7d71b          	sraiw	a4,a5,0x1f
    2dea:	40e6873b          	subw	a4,a3,a4
    2dee:	86ba                	mv	a3,a4
    2df0:	8736                	mv	a4,a3
    2df2:	0027171b          	slliw	a4,a4,0x2
    2df6:	9f35                	addw	a4,a4,a3
    2df8:	9f99                	subw	a5,a5,a4
    2dfa:	0007871b          	sext.w	a4,a5
    2dfe:	4785                	li	a5,1
    2e00:	00f71c63          	bne	a4,a5,2e18 <concreate+0xea>
      link("C0", file);
    2e04:	fd840793          	addi	a5,s0,-40
    2e08:	85be                	mv	a1,a5
    2e0a:	00006517          	auipc	a0,0x6
    2e0e:	84e50513          	addi	a0,a0,-1970 # 8658 <malloc+0xf74>
    2e12:	026040ef          	jal	6e38 <link>
    2e16:	a089                	j	2e58 <concreate+0x12a>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    2e18:	fd840793          	addi	a5,s0,-40
    2e1c:	20200593          	li	a1,514
    2e20:	853e                	mv	a0,a5
    2e22:	7f7030ef          	jal	6e18 <open>
    2e26:	87aa                	mv	a5,a0
    2e28:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    2e2c:	fe442783          	lw	a5,-28(s0)
    2e30:	2781                	sext.w	a5,a5
    2e32:	0007de63          	bgez	a5,2e4e <concreate+0x120>
        printf("concreate create %s failed\n", file);
    2e36:	fd840793          	addi	a5,s0,-40
    2e3a:	85be                	mv	a1,a5
    2e3c:	00006517          	auipc	a0,0x6
    2e40:	82450513          	addi	a0,a0,-2012 # 8660 <malloc+0xf7c>
    2e44:	6b8040ef          	jal	74fc <printf>
        exit(1);
    2e48:	4505                	li	a0,1
    2e4a:	78f030ef          	jal	6dd8 <exit>
      }
      close(fd);
    2e4e:	fe442783          	lw	a5,-28(s0)
    2e52:	853e                	mv	a0,a5
    2e54:	7ad030ef          	jal	6e00 <close>
    }
    if(pid == 0) {
    2e58:	fe042783          	lw	a5,-32(s0)
    2e5c:	2781                	sext.w	a5,a5
    2e5e:	e781                	bnez	a5,2e66 <concreate+0x138>
      exit(0);
    2e60:	4501                	li	a0,0
    2e62:	777030ef          	jal	6dd8 <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    2e66:	f9c40793          	addi	a5,s0,-100
    2e6a:	853e                	mv	a0,a5
    2e6c:	775030ef          	jal	6de0 <wait>
      if(xstatus != 0)
    2e70:	f9c42783          	lw	a5,-100(s0)
    2e74:	c781                	beqz	a5,2e7c <concreate+0x14e>
        exit(1);
    2e76:	4505                	li	a0,1
    2e78:	761030ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    2e7c:	fec42783          	lw	a5,-20(s0)
    2e80:	2785                	addiw	a5,a5,1
    2e82:	fef42623          	sw	a5,-20(s0)
    2e86:	fec42783          	lw	a5,-20(s0)
    2e8a:	0007871b          	sext.w	a4,a5
    2e8e:	02700793          	li	a5,39
    2e92:	eae7dde3          	bge	a5,a4,2d4c <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    2e96:	fb040793          	addi	a5,s0,-80
    2e9a:	02800613          	li	a2,40
    2e9e:	4581                	li	a1,0
    2ea0:	853e                	mv	a0,a5
    2ea2:	341030ef          	jal	69e2 <memset>
  fd = open(".", 0);
    2ea6:	4581                	li	a1,0
    2ea8:	00005517          	auipc	a0,0x5
    2eac:	78850513          	addi	a0,a0,1928 # 8630 <malloc+0xf4c>
    2eb0:	769030ef          	jal	6e18 <open>
    2eb4:	87aa                	mv	a5,a0
    2eb6:	fef42223          	sw	a5,-28(s0)
  n = 0;
    2eba:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    2ebe:	a05d                	j	2f64 <concreate+0x236>
    if(de.inum == 0)
    2ec0:	fa045783          	lhu	a5,-96(s0)
    2ec4:	cfd9                	beqz	a5,2f62 <concreate+0x234>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2ec6:	fa244783          	lbu	a5,-94(s0)
    2eca:	873e                	mv	a4,a5
    2ecc:	04300793          	li	a5,67
    2ed0:	08f71a63          	bne	a4,a5,2f64 <concreate+0x236>
    2ed4:	fa444783          	lbu	a5,-92(s0)
    2ed8:	e7d1                	bnez	a5,2f64 <concreate+0x236>
      i = de.name[1] - '0';
    2eda:	fa344783          	lbu	a5,-93(s0)
    2ede:	2781                	sext.w	a5,a5
    2ee0:	fd07879b          	addiw	a5,a5,-48
    2ee4:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    2ee8:	fec42783          	lw	a5,-20(s0)
    2eec:	2781                	sext.w	a5,a5
    2eee:	0007c863          	bltz	a5,2efe <concreate+0x1d0>
    2ef2:	fec42703          	lw	a4,-20(s0)
    2ef6:	02700793          	li	a5,39
    2efa:	02e7f163          	bgeu	a5,a4,2f1c <concreate+0x1ee>
        printf("%s: concreate weird file %s\n", s, de.name);
    2efe:	fa040793          	addi	a5,s0,-96
    2f02:	0789                	addi	a5,a5,2
    2f04:	863e                	mv	a2,a5
    2f06:	f8843583          	ld	a1,-120(s0)
    2f0a:	00005517          	auipc	a0,0x5
    2f0e:	77650513          	addi	a0,a0,1910 # 8680 <malloc+0xf9c>
    2f12:	5ea040ef          	jal	74fc <printf>
        exit(1);
    2f16:	4505                	li	a0,1
    2f18:	6c1030ef          	jal	6dd8 <exit>
      }
      if(fa[i]){
    2f1c:	fec42783          	lw	a5,-20(s0)
    2f20:	17c1                	addi	a5,a5,-16
    2f22:	97a2                	add	a5,a5,s0
    2f24:	fc07c783          	lbu	a5,-64(a5)
    2f28:	c385                	beqz	a5,2f48 <concreate+0x21a>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    2f2a:	fa040793          	addi	a5,s0,-96
    2f2e:	0789                	addi	a5,a5,2
    2f30:	863e                	mv	a2,a5
    2f32:	f8843583          	ld	a1,-120(s0)
    2f36:	00005517          	auipc	a0,0x5
    2f3a:	76a50513          	addi	a0,a0,1898 # 86a0 <malloc+0xfbc>
    2f3e:	5be040ef          	jal	74fc <printf>
        exit(1);
    2f42:	4505                	li	a0,1
    2f44:	695030ef          	jal	6dd8 <exit>
      }
      fa[i] = 1;
    2f48:	fec42783          	lw	a5,-20(s0)
    2f4c:	17c1                	addi	a5,a5,-16
    2f4e:	97a2                	add	a5,a5,s0
    2f50:	4705                	li	a4,1
    2f52:	fce78023          	sb	a4,-64(a5)
      n++;
    2f56:	fe842783          	lw	a5,-24(s0)
    2f5a:	2785                	addiw	a5,a5,1
    2f5c:	fef42423          	sw	a5,-24(s0)
    2f60:	a011                	j	2f64 <concreate+0x236>
      continue;
    2f62:	0001                	nop
  while(read(fd, &de, sizeof(de)) > 0){
    2f64:	fa040713          	addi	a4,s0,-96
    2f68:	fe442783          	lw	a5,-28(s0)
    2f6c:	4641                	li	a2,16
    2f6e:	85ba                	mv	a1,a4
    2f70:	853e                	mv	a0,a5
    2f72:	67f030ef          	jal	6df0 <read>
    2f76:	87aa                	mv	a5,a0
    2f78:	f4f044e3          	bgtz	a5,2ec0 <concreate+0x192>
    }
  }
  close(fd);
    2f7c:	fe442783          	lw	a5,-28(s0)
    2f80:	853e                	mv	a0,a5
    2f82:	67f030ef          	jal	6e00 <close>

  if(n != N){
    2f86:	fe842783          	lw	a5,-24(s0)
    2f8a:	0007871b          	sext.w	a4,a5
    2f8e:	02800793          	li	a5,40
    2f92:	00f70d63          	beq	a4,a5,2fac <concreate+0x27e>
    printf("%s: concreate not enough files in directory listing\n", s);
    2f96:	f8843583          	ld	a1,-120(s0)
    2f9a:	00005517          	auipc	a0,0x5
    2f9e:	72e50513          	addi	a0,a0,1838 # 86c8 <malloc+0xfe4>
    2fa2:	55a040ef          	jal	74fc <printf>
    exit(1);
    2fa6:	4505                	li	a0,1
    2fa8:	631030ef          	jal	6dd8 <exit>
  }

  for(i = 0; i < N; i++){
    2fac:	fe042623          	sw	zero,-20(s0)
    2fb0:	a249                	j	3132 <concreate+0x404>
    file[1] = '0' + i;
    2fb2:	fec42783          	lw	a5,-20(s0)
    2fb6:	0ff7f793          	zext.b	a5,a5
    2fba:	0307879b          	addiw	a5,a5,48
    2fbe:	0ff7f793          	zext.b	a5,a5
    2fc2:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    2fc6:	60b030ef          	jal	6dd0 <fork>
    2fca:	87aa                	mv	a5,a0
    2fcc:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2fd0:	fe042783          	lw	a5,-32(s0)
    2fd4:	2781                	sext.w	a5,a5
    2fd6:	0007dd63          	bgez	a5,2ff0 <concreate+0x2c2>
      printf("%s: fork failed\n", s);
    2fda:	f8843583          	ld	a1,-120(s0)
    2fde:	00005517          	auipc	a0,0x5
    2fe2:	cda50513          	addi	a0,a0,-806 # 7cb8 <malloc+0x5d4>
    2fe6:	516040ef          	jal	74fc <printf>
      exit(1);
    2fea:	4505                	li	a0,1
    2fec:	5ed030ef          	jal	6dd8 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    2ff0:	fec42783          	lw	a5,-20(s0)
    2ff4:	0007869b          	sext.w	a3,a5
    2ff8:	55555737          	lui	a4,0x55555
    2ffc:	55670713          	addi	a4,a4,1366 # 55555556 <freep+0x5554487e>
    3000:	02e68733          	mul	a4,a3,a4
    3004:	9301                	srli	a4,a4,0x20
    3006:	41f7d69b          	sraiw	a3,a5,0x1f
    300a:	9f15                	subw	a4,a4,a3
    300c:	86ba                	mv	a3,a4
    300e:	8736                	mv	a4,a3
    3010:	0017171b          	slliw	a4,a4,0x1
    3014:	9f35                	addw	a4,a4,a3
    3016:	9f99                	subw	a5,a5,a4
    3018:	2781                	sext.w	a5,a5
    301a:	e789                	bnez	a5,3024 <concreate+0x2f6>
    301c:	fe042783          	lw	a5,-32(s0)
    3020:	2781                	sext.w	a5,a5
    3022:	cf95                	beqz	a5,305e <concreate+0x330>
       ((i % 3) == 1 && pid != 0)){
    3024:	fec42783          	lw	a5,-20(s0)
    3028:	0007869b          	sext.w	a3,a5
    302c:	55555737          	lui	a4,0x55555
    3030:	55670713          	addi	a4,a4,1366 # 55555556 <freep+0x5554487e>
    3034:	02e68733          	mul	a4,a3,a4
    3038:	9301                	srli	a4,a4,0x20
    303a:	41f7d69b          	sraiw	a3,a5,0x1f
    303e:	9f15                	subw	a4,a4,a3
    3040:	86ba                	mv	a3,a4
    3042:	8736                	mv	a4,a3
    3044:	0017171b          	slliw	a4,a4,0x1
    3048:	9f35                	addw	a4,a4,a3
    304a:	9f99                	subw	a5,a5,a4
    304c:	0007871b          	sext.w	a4,a5
    if(((i % 3) == 0 && pid == 0) ||
    3050:	4785                	li	a5,1
    3052:	08f71363          	bne	a4,a5,30d8 <concreate+0x3aa>
       ((i % 3) == 1 && pid != 0)){
    3056:	fe042783          	lw	a5,-32(s0)
    305a:	2781                	sext.w	a5,a5
    305c:	cfb5                	beqz	a5,30d8 <concreate+0x3aa>
      close(open(file, 0));
    305e:	fd840793          	addi	a5,s0,-40
    3062:	4581                	li	a1,0
    3064:	853e                	mv	a0,a5
    3066:	5b3030ef          	jal	6e18 <open>
    306a:	87aa                	mv	a5,a0
    306c:	853e                	mv	a0,a5
    306e:	593030ef          	jal	6e00 <close>
      close(open(file, 0));
    3072:	fd840793          	addi	a5,s0,-40
    3076:	4581                	li	a1,0
    3078:	853e                	mv	a0,a5
    307a:	59f030ef          	jal	6e18 <open>
    307e:	87aa                	mv	a5,a0
    3080:	853e                	mv	a0,a5
    3082:	57f030ef          	jal	6e00 <close>
      close(open(file, 0));
    3086:	fd840793          	addi	a5,s0,-40
    308a:	4581                	li	a1,0
    308c:	853e                	mv	a0,a5
    308e:	58b030ef          	jal	6e18 <open>
    3092:	87aa                	mv	a5,a0
    3094:	853e                	mv	a0,a5
    3096:	56b030ef          	jal	6e00 <close>
      close(open(file, 0));
    309a:	fd840793          	addi	a5,s0,-40
    309e:	4581                	li	a1,0
    30a0:	853e                	mv	a0,a5
    30a2:	577030ef          	jal	6e18 <open>
    30a6:	87aa                	mv	a5,a0
    30a8:	853e                	mv	a0,a5
    30aa:	557030ef          	jal	6e00 <close>
      close(open(file, 0));
    30ae:	fd840793          	addi	a5,s0,-40
    30b2:	4581                	li	a1,0
    30b4:	853e                	mv	a0,a5
    30b6:	563030ef          	jal	6e18 <open>
    30ba:	87aa                	mv	a5,a0
    30bc:	853e                	mv	a0,a5
    30be:	543030ef          	jal	6e00 <close>
      close(open(file, 0));
    30c2:	fd840793          	addi	a5,s0,-40
    30c6:	4581                	li	a1,0
    30c8:	853e                	mv	a0,a5
    30ca:	54f030ef          	jal	6e18 <open>
    30ce:	87aa                	mv	a5,a0
    30d0:	853e                	mv	a0,a5
    30d2:	52f030ef          	jal	6e00 <close>
    30d6:	a83d                	j	3114 <concreate+0x3e6>
    } else {
      unlink(file);
    30d8:	fd840793          	addi	a5,s0,-40
    30dc:	853e                	mv	a0,a5
    30de:	54b030ef          	jal	6e28 <unlink>
      unlink(file);
    30e2:	fd840793          	addi	a5,s0,-40
    30e6:	853e                	mv	a0,a5
    30e8:	541030ef          	jal	6e28 <unlink>
      unlink(file);
    30ec:	fd840793          	addi	a5,s0,-40
    30f0:	853e                	mv	a0,a5
    30f2:	537030ef          	jal	6e28 <unlink>
      unlink(file);
    30f6:	fd840793          	addi	a5,s0,-40
    30fa:	853e                	mv	a0,a5
    30fc:	52d030ef          	jal	6e28 <unlink>
      unlink(file);
    3100:	fd840793          	addi	a5,s0,-40
    3104:	853e                	mv	a0,a5
    3106:	523030ef          	jal	6e28 <unlink>
      unlink(file);
    310a:	fd840793          	addi	a5,s0,-40
    310e:	853e                	mv	a0,a5
    3110:	519030ef          	jal	6e28 <unlink>
    }
    if(pid == 0)
    3114:	fe042783          	lw	a5,-32(s0)
    3118:	2781                	sext.w	a5,a5
    311a:	e781                	bnez	a5,3122 <concreate+0x3f4>
      exit(0);
    311c:	4501                	li	a0,0
    311e:	4bb030ef          	jal	6dd8 <exit>
    else
      wait(0);
    3122:	4501                	li	a0,0
    3124:	4bd030ef          	jal	6de0 <wait>
  for(i = 0; i < N; i++){
    3128:	fec42783          	lw	a5,-20(s0)
    312c:	2785                	addiw	a5,a5,1
    312e:	fef42623          	sw	a5,-20(s0)
    3132:	fec42783          	lw	a5,-20(s0)
    3136:	0007871b          	sext.w	a4,a5
    313a:	02700793          	li	a5,39
    313e:	e6e7dae3          	bge	a5,a4,2fb2 <concreate+0x284>
  }
}
    3142:	0001                	nop
    3144:	0001                	nop
    3146:	70e6                	ld	ra,120(sp)
    3148:	7446                	ld	s0,112(sp)
    314a:	6109                	addi	sp,sp,128
    314c:	8082                	ret

000000000000314e <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    314e:	7179                	addi	sp,sp,-48
    3150:	f406                	sd	ra,40(sp)
    3152:	f022                	sd	s0,32(sp)
    3154:	1800                	addi	s0,sp,48
    3156:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    315a:	00004517          	auipc	a0,0x4
    315e:	7fe50513          	addi	a0,a0,2046 # 7958 <malloc+0x274>
    3162:	4c7030ef          	jal	6e28 <unlink>
  pid = fork();
    3166:	46b030ef          	jal	6dd0 <fork>
    316a:	87aa                	mv	a5,a0
    316c:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    3170:	fe442783          	lw	a5,-28(s0)
    3174:	2781                	sext.w	a5,a5
    3176:	0007dd63          	bgez	a5,3190 <linkunlink+0x42>
    printf("%s: fork failed\n", s);
    317a:	fd843583          	ld	a1,-40(s0)
    317e:	00005517          	auipc	a0,0x5
    3182:	b3a50513          	addi	a0,a0,-1222 # 7cb8 <malloc+0x5d4>
    3186:	376040ef          	jal	74fc <printf>
    exit(1);
    318a:	4505                	li	a0,1
    318c:	44d030ef          	jal	6dd8 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3190:	fe442783          	lw	a5,-28(s0)
    3194:	2781                	sext.w	a5,a5
    3196:	c399                	beqz	a5,319c <linkunlink+0x4e>
    3198:	4785                	li	a5,1
    319a:	a019                	j	31a0 <linkunlink+0x52>
    319c:	06100793          	li	a5,97
    31a0:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    31a4:	fe042623          	sw	zero,-20(s0)
    31a8:	a8d1                	j	327c <linkunlink+0x12e>
    x = x * 1103515245 + 12345;
    31aa:	fe842783          	lw	a5,-24(s0)
    31ae:	873e                	mv	a4,a5
    31b0:	41c657b7          	lui	a5,0x41c65
    31b4:	e6d7879b          	addiw	a5,a5,-403 # 41c64e6d <freep+0x41c54195>
    31b8:	02f707bb          	mulw	a5,a4,a5
    31bc:	0007871b          	sext.w	a4,a5
    31c0:	678d                	lui	a5,0x3
    31c2:	0397879b          	addiw	a5,a5,57 # 3039 <concreate+0x30b>
    31c6:	9fb9                	addw	a5,a5,a4
    31c8:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    31cc:	fe842783          	lw	a5,-24(s0)
    31d0:	86be                	mv	a3,a5
    31d2:	02069713          	slli	a4,a3,0x20
    31d6:	9301                	srli	a4,a4,0x20
    31d8:	00007797          	auipc	a5,0x7
    31dc:	cc878793          	addi	a5,a5,-824 # 9ea0 <malloc+0x27bc>
    31e0:	639c                	ld	a5,0(a5)
    31e2:	02f707b3          	mul	a5,a4,a5
    31e6:	9381                	srli	a5,a5,0x20
    31e8:	0017d79b          	srliw	a5,a5,0x1
    31ec:	873e                	mv	a4,a5
    31ee:	87ba                	mv	a5,a4
    31f0:	0017979b          	slliw	a5,a5,0x1
    31f4:	9fb9                	addw	a5,a5,a4
    31f6:	40f687bb          	subw	a5,a3,a5
    31fa:	2781                	sext.w	a5,a5
    31fc:	ef91                	bnez	a5,3218 <linkunlink+0xca>
      close(open("x", O_RDWR | O_CREATE));
    31fe:	20200593          	li	a1,514
    3202:	00004517          	auipc	a0,0x4
    3206:	75650513          	addi	a0,a0,1878 # 7958 <malloc+0x274>
    320a:	40f030ef          	jal	6e18 <open>
    320e:	87aa                	mv	a5,a0
    3210:	853e                	mv	a0,a5
    3212:	3ef030ef          	jal	6e00 <close>
    3216:	a8b1                	j	3272 <linkunlink+0x124>
    } else if((x % 3) == 1){
    3218:	fe842783          	lw	a5,-24(s0)
    321c:	86be                	mv	a3,a5
    321e:	02069713          	slli	a4,a3,0x20
    3222:	9301                	srli	a4,a4,0x20
    3224:	00007797          	auipc	a5,0x7
    3228:	c7c78793          	addi	a5,a5,-900 # 9ea0 <malloc+0x27bc>
    322c:	639c                	ld	a5,0(a5)
    322e:	02f707b3          	mul	a5,a4,a5
    3232:	9381                	srli	a5,a5,0x20
    3234:	0017d79b          	srliw	a5,a5,0x1
    3238:	873e                	mv	a4,a5
    323a:	87ba                	mv	a5,a4
    323c:	0017979b          	slliw	a5,a5,0x1
    3240:	9fb9                	addw	a5,a5,a4
    3242:	40f687bb          	subw	a5,a3,a5
    3246:	0007871b          	sext.w	a4,a5
    324a:	4785                	li	a5,1
    324c:	00f71d63          	bne	a4,a5,3266 <linkunlink+0x118>
      link("cat", "x");
    3250:	00004597          	auipc	a1,0x4
    3254:	70858593          	addi	a1,a1,1800 # 7958 <malloc+0x274>
    3258:	00005517          	auipc	a0,0x5
    325c:	4a850513          	addi	a0,a0,1192 # 8700 <malloc+0x101c>
    3260:	3d9030ef          	jal	6e38 <link>
    3264:	a039                	j	3272 <linkunlink+0x124>
    } else {
      unlink("x");
    3266:	00004517          	auipc	a0,0x4
    326a:	6f250513          	addi	a0,a0,1778 # 7958 <malloc+0x274>
    326e:	3bb030ef          	jal	6e28 <unlink>
  for(i = 0; i < 100; i++){
    3272:	fec42783          	lw	a5,-20(s0)
    3276:	2785                	addiw	a5,a5,1
    3278:	fef42623          	sw	a5,-20(s0)
    327c:	fec42783          	lw	a5,-20(s0)
    3280:	0007871b          	sext.w	a4,a5
    3284:	06300793          	li	a5,99
    3288:	f2e7d1e3          	bge	a5,a4,31aa <linkunlink+0x5c>
    }
  }

  if(pid)
    328c:	fe442783          	lw	a5,-28(s0)
    3290:	2781                	sext.w	a5,a5
    3292:	c789                	beqz	a5,329c <linkunlink+0x14e>
    wait(0);
    3294:	4501                	li	a0,0
    3296:	34b030ef          	jal	6de0 <wait>
  else
    exit(0);
}
    329a:	a021                	j	32a2 <linkunlink+0x154>
    exit(0);
    329c:	4501                	li	a0,0
    329e:	33b030ef          	jal	6dd8 <exit>
}
    32a2:	70a2                	ld	ra,40(sp)
    32a4:	7402                	ld	s0,32(sp)
    32a6:	6145                	addi	sp,sp,48
    32a8:	8082                	ret

00000000000032aa <subdir>:


void
subdir(char *s)
{
    32aa:	7179                	addi	sp,sp,-48
    32ac:	f406                	sd	ra,40(sp)
    32ae:	f022                	sd	s0,32(sp)
    32b0:	1800                	addi	s0,sp,48
    32b2:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    32b6:	00005517          	auipc	a0,0x5
    32ba:	45250513          	addi	a0,a0,1106 # 8708 <malloc+0x1024>
    32be:	36b030ef          	jal	6e28 <unlink>
  if(mkdir("dd") != 0){
    32c2:	00005517          	auipc	a0,0x5
    32c6:	44e50513          	addi	a0,a0,1102 # 8710 <malloc+0x102c>
    32ca:	377030ef          	jal	6e40 <mkdir>
    32ce:	87aa                	mv	a5,a0
    32d0:	cf81                	beqz	a5,32e8 <subdir+0x3e>
    printf("%s: mkdir dd failed\n", s);
    32d2:	fd843583          	ld	a1,-40(s0)
    32d6:	00005517          	auipc	a0,0x5
    32da:	44250513          	addi	a0,a0,1090 # 8718 <malloc+0x1034>
    32de:	21e040ef          	jal	74fc <printf>
    exit(1);
    32e2:	4505                	li	a0,1
    32e4:	2f5030ef          	jal	6dd8 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    32e8:	20200593          	li	a1,514
    32ec:	00005517          	auipc	a0,0x5
    32f0:	44450513          	addi	a0,a0,1092 # 8730 <malloc+0x104c>
    32f4:	325030ef          	jal	6e18 <open>
    32f8:	87aa                	mv	a5,a0
    32fa:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    32fe:	fec42783          	lw	a5,-20(s0)
    3302:	2781                	sext.w	a5,a5
    3304:	0007dd63          	bgez	a5,331e <subdir+0x74>
    printf("%s: create dd/ff failed\n", s);
    3308:	fd843583          	ld	a1,-40(s0)
    330c:	00005517          	auipc	a0,0x5
    3310:	42c50513          	addi	a0,a0,1068 # 8738 <malloc+0x1054>
    3314:	1e8040ef          	jal	74fc <printf>
    exit(1);
    3318:	4505                	li	a0,1
    331a:	2bf030ef          	jal	6dd8 <exit>
  }
  write(fd, "ff", 2);
    331e:	fec42783          	lw	a5,-20(s0)
    3322:	4609                	li	a2,2
    3324:	00005597          	auipc	a1,0x5
    3328:	3e458593          	addi	a1,a1,996 # 8708 <malloc+0x1024>
    332c:	853e                	mv	a0,a5
    332e:	2cb030ef          	jal	6df8 <write>
  close(fd);
    3332:	fec42783          	lw	a5,-20(s0)
    3336:	853e                	mv	a0,a5
    3338:	2c9030ef          	jal	6e00 <close>

  if(unlink("dd") >= 0){
    333c:	00005517          	auipc	a0,0x5
    3340:	3d450513          	addi	a0,a0,980 # 8710 <malloc+0x102c>
    3344:	2e5030ef          	jal	6e28 <unlink>
    3348:	87aa                	mv	a5,a0
    334a:	0007cd63          	bltz	a5,3364 <subdir+0xba>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    334e:	fd843583          	ld	a1,-40(s0)
    3352:	00005517          	auipc	a0,0x5
    3356:	40650513          	addi	a0,a0,1030 # 8758 <malloc+0x1074>
    335a:	1a2040ef          	jal	74fc <printf>
    exit(1);
    335e:	4505                	li	a0,1
    3360:	279030ef          	jal	6dd8 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3364:	00005517          	auipc	a0,0x5
    3368:	42450513          	addi	a0,a0,1060 # 8788 <malloc+0x10a4>
    336c:	2d5030ef          	jal	6e40 <mkdir>
    3370:	87aa                	mv	a5,a0
    3372:	cf81                	beqz	a5,338a <subdir+0xe0>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    3374:	fd843583          	ld	a1,-40(s0)
    3378:	00005517          	auipc	a0,0x5
    337c:	41850513          	addi	a0,a0,1048 # 8790 <malloc+0x10ac>
    3380:	17c040ef          	jal	74fc <printf>
    exit(1);
    3384:	4505                	li	a0,1
    3386:	253030ef          	jal	6dd8 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    338a:	20200593          	li	a1,514
    338e:	00005517          	auipc	a0,0x5
    3392:	42250513          	addi	a0,a0,1058 # 87b0 <malloc+0x10cc>
    3396:	283030ef          	jal	6e18 <open>
    339a:	87aa                	mv	a5,a0
    339c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    33a0:	fec42783          	lw	a5,-20(s0)
    33a4:	2781                	sext.w	a5,a5
    33a6:	0007dd63          	bgez	a5,33c0 <subdir+0x116>
    printf("%s: create dd/dd/ff failed\n", s);
    33aa:	fd843583          	ld	a1,-40(s0)
    33ae:	00005517          	auipc	a0,0x5
    33b2:	41250513          	addi	a0,a0,1042 # 87c0 <malloc+0x10dc>
    33b6:	146040ef          	jal	74fc <printf>
    exit(1);
    33ba:	4505                	li	a0,1
    33bc:	21d030ef          	jal	6dd8 <exit>
  }
  write(fd, "FF", 2);
    33c0:	fec42783          	lw	a5,-20(s0)
    33c4:	4609                	li	a2,2
    33c6:	00005597          	auipc	a1,0x5
    33ca:	41a58593          	addi	a1,a1,1050 # 87e0 <malloc+0x10fc>
    33ce:	853e                	mv	a0,a5
    33d0:	229030ef          	jal	6df8 <write>
  close(fd);
    33d4:	fec42783          	lw	a5,-20(s0)
    33d8:	853e                	mv	a0,a5
    33da:	227030ef          	jal	6e00 <close>

  fd = open("dd/dd/../ff", 0);
    33de:	4581                	li	a1,0
    33e0:	00005517          	auipc	a0,0x5
    33e4:	40850513          	addi	a0,a0,1032 # 87e8 <malloc+0x1104>
    33e8:	231030ef          	jal	6e18 <open>
    33ec:	87aa                	mv	a5,a0
    33ee:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    33f2:	fec42783          	lw	a5,-20(s0)
    33f6:	2781                	sext.w	a5,a5
    33f8:	0007dd63          	bgez	a5,3412 <subdir+0x168>
    printf("%s: open dd/dd/../ff failed\n", s);
    33fc:	fd843583          	ld	a1,-40(s0)
    3400:	00005517          	auipc	a0,0x5
    3404:	3f850513          	addi	a0,a0,1016 # 87f8 <malloc+0x1114>
    3408:	0f4040ef          	jal	74fc <printf>
    exit(1);
    340c:	4505                	li	a0,1
    340e:	1cb030ef          	jal	6dd8 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3412:	fec42783          	lw	a5,-20(s0)
    3416:	660d                	lui	a2,0x3
    3418:	00007597          	auipc	a1,0x7
    341c:	09858593          	addi	a1,a1,152 # a4b0 <buf>
    3420:	853e                	mv	a0,a5
    3422:	1cf030ef          	jal	6df0 <read>
    3426:	87aa                	mv	a5,a0
    3428:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    342c:	fe842783          	lw	a5,-24(s0)
    3430:	0007871b          	sext.w	a4,a5
    3434:	4789                	li	a5,2
    3436:	00f71d63          	bne	a4,a5,3450 <subdir+0x1a6>
    343a:	00007797          	auipc	a5,0x7
    343e:	07678793          	addi	a5,a5,118 # a4b0 <buf>
    3442:	0007c783          	lbu	a5,0(a5)
    3446:	873e                	mv	a4,a5
    3448:	06600793          	li	a5,102
    344c:	00f70d63          	beq	a4,a5,3466 <subdir+0x1bc>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3450:	fd843583          	ld	a1,-40(s0)
    3454:	00005517          	auipc	a0,0x5
    3458:	3c450513          	addi	a0,a0,964 # 8818 <malloc+0x1134>
    345c:	0a0040ef          	jal	74fc <printf>
    exit(1);
    3460:	4505                	li	a0,1
    3462:	177030ef          	jal	6dd8 <exit>
  }
  close(fd);
    3466:	fec42783          	lw	a5,-20(s0)
    346a:	853e                	mv	a0,a5
    346c:	195030ef          	jal	6e00 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3470:	00005597          	auipc	a1,0x5
    3474:	3c858593          	addi	a1,a1,968 # 8838 <malloc+0x1154>
    3478:	00005517          	auipc	a0,0x5
    347c:	33850513          	addi	a0,a0,824 # 87b0 <malloc+0x10cc>
    3480:	1b9030ef          	jal	6e38 <link>
    3484:	87aa                	mv	a5,a0
    3486:	cf81                	beqz	a5,349e <subdir+0x1f4>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    3488:	fd843583          	ld	a1,-40(s0)
    348c:	00005517          	auipc	a0,0x5
    3490:	3bc50513          	addi	a0,a0,956 # 8848 <malloc+0x1164>
    3494:	068040ef          	jal	74fc <printf>
    exit(1);
    3498:	4505                	li	a0,1
    349a:	13f030ef          	jal	6dd8 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    349e:	00005517          	auipc	a0,0x5
    34a2:	31250513          	addi	a0,a0,786 # 87b0 <malloc+0x10cc>
    34a6:	183030ef          	jal	6e28 <unlink>
    34aa:	87aa                	mv	a5,a0
    34ac:	cf81                	beqz	a5,34c4 <subdir+0x21a>
    printf("%s: unlink dd/dd/ff failed\n", s);
    34ae:	fd843583          	ld	a1,-40(s0)
    34b2:	00005517          	auipc	a0,0x5
    34b6:	3be50513          	addi	a0,a0,958 # 8870 <malloc+0x118c>
    34ba:	042040ef          	jal	74fc <printf>
    exit(1);
    34be:	4505                	li	a0,1
    34c0:	119030ef          	jal	6dd8 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    34c4:	4581                	li	a1,0
    34c6:	00005517          	auipc	a0,0x5
    34ca:	2ea50513          	addi	a0,a0,746 # 87b0 <malloc+0x10cc>
    34ce:	14b030ef          	jal	6e18 <open>
    34d2:	87aa                	mv	a5,a0
    34d4:	0007cd63          	bltz	a5,34ee <subdir+0x244>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    34d8:	fd843583          	ld	a1,-40(s0)
    34dc:	00005517          	auipc	a0,0x5
    34e0:	3b450513          	addi	a0,a0,948 # 8890 <malloc+0x11ac>
    34e4:	018040ef          	jal	74fc <printf>
    exit(1);
    34e8:	4505                	li	a0,1
    34ea:	0ef030ef          	jal	6dd8 <exit>
  }

  if(chdir("dd") != 0){
    34ee:	00005517          	auipc	a0,0x5
    34f2:	22250513          	addi	a0,a0,546 # 8710 <malloc+0x102c>
    34f6:	153030ef          	jal	6e48 <chdir>
    34fa:	87aa                	mv	a5,a0
    34fc:	cf81                	beqz	a5,3514 <subdir+0x26a>
    printf("%s: chdir dd failed\n", s);
    34fe:	fd843583          	ld	a1,-40(s0)
    3502:	00005517          	auipc	a0,0x5
    3506:	3b650513          	addi	a0,a0,950 # 88b8 <malloc+0x11d4>
    350a:	7f3030ef          	jal	74fc <printf>
    exit(1);
    350e:	4505                	li	a0,1
    3510:	0c9030ef          	jal	6dd8 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3514:	00005517          	auipc	a0,0x5
    3518:	3bc50513          	addi	a0,a0,956 # 88d0 <malloc+0x11ec>
    351c:	12d030ef          	jal	6e48 <chdir>
    3520:	87aa                	mv	a5,a0
    3522:	cf81                	beqz	a5,353a <subdir+0x290>
    printf("%s: chdir dd/../../dd failed\n", s);
    3524:	fd843583          	ld	a1,-40(s0)
    3528:	00005517          	auipc	a0,0x5
    352c:	3b850513          	addi	a0,a0,952 # 88e0 <malloc+0x11fc>
    3530:	7cd030ef          	jal	74fc <printf>
    exit(1);
    3534:	4505                	li	a0,1
    3536:	0a3030ef          	jal	6dd8 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    353a:	00005517          	auipc	a0,0x5
    353e:	3c650513          	addi	a0,a0,966 # 8900 <malloc+0x121c>
    3542:	107030ef          	jal	6e48 <chdir>
    3546:	87aa                	mv	a5,a0
    3548:	cf81                	beqz	a5,3560 <subdir+0x2b6>
    printf("%s: chdir dd/../../../dd failed\n", s);
    354a:	fd843583          	ld	a1,-40(s0)
    354e:	00005517          	auipc	a0,0x5
    3552:	3c250513          	addi	a0,a0,962 # 8910 <malloc+0x122c>
    3556:	7a7030ef          	jal	74fc <printf>
    exit(1);
    355a:	4505                	li	a0,1
    355c:	07d030ef          	jal	6dd8 <exit>
  }
  if(chdir("./..") != 0){
    3560:	00005517          	auipc	a0,0x5
    3564:	3d850513          	addi	a0,a0,984 # 8938 <malloc+0x1254>
    3568:	0e1030ef          	jal	6e48 <chdir>
    356c:	87aa                	mv	a5,a0
    356e:	cf81                	beqz	a5,3586 <subdir+0x2dc>
    printf("%s: chdir ./.. failed\n", s);
    3570:	fd843583          	ld	a1,-40(s0)
    3574:	00005517          	auipc	a0,0x5
    3578:	3cc50513          	addi	a0,a0,972 # 8940 <malloc+0x125c>
    357c:	781030ef          	jal	74fc <printf>
    exit(1);
    3580:	4505                	li	a0,1
    3582:	057030ef          	jal	6dd8 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    3586:	4581                	li	a1,0
    3588:	00005517          	auipc	a0,0x5
    358c:	2b050513          	addi	a0,a0,688 # 8838 <malloc+0x1154>
    3590:	089030ef          	jal	6e18 <open>
    3594:	87aa                	mv	a5,a0
    3596:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    359a:	fec42783          	lw	a5,-20(s0)
    359e:	2781                	sext.w	a5,a5
    35a0:	0007dd63          	bgez	a5,35ba <subdir+0x310>
    printf("%s: open dd/dd/ffff failed\n", s);
    35a4:	fd843583          	ld	a1,-40(s0)
    35a8:	00005517          	auipc	a0,0x5
    35ac:	3b050513          	addi	a0,a0,944 # 8958 <malloc+0x1274>
    35b0:	74d030ef          	jal	74fc <printf>
    exit(1);
    35b4:	4505                	li	a0,1
    35b6:	023030ef          	jal	6dd8 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    35ba:	fec42783          	lw	a5,-20(s0)
    35be:	660d                	lui	a2,0x3
    35c0:	00007597          	auipc	a1,0x7
    35c4:	ef058593          	addi	a1,a1,-272 # a4b0 <buf>
    35c8:	853e                	mv	a0,a5
    35ca:	027030ef          	jal	6df0 <read>
    35ce:	87aa                	mv	a5,a0
    35d0:	873e                	mv	a4,a5
    35d2:	4789                	li	a5,2
    35d4:	00f70d63          	beq	a4,a5,35ee <subdir+0x344>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    35d8:	fd843583          	ld	a1,-40(s0)
    35dc:	00005517          	auipc	a0,0x5
    35e0:	39c50513          	addi	a0,a0,924 # 8978 <malloc+0x1294>
    35e4:	719030ef          	jal	74fc <printf>
    exit(1);
    35e8:	4505                	li	a0,1
    35ea:	7ee030ef          	jal	6dd8 <exit>
  }
  close(fd);
    35ee:	fec42783          	lw	a5,-20(s0)
    35f2:	853e                	mv	a0,a5
    35f4:	00d030ef          	jal	6e00 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    35f8:	4581                	li	a1,0
    35fa:	00005517          	auipc	a0,0x5
    35fe:	1b650513          	addi	a0,a0,438 # 87b0 <malloc+0x10cc>
    3602:	017030ef          	jal	6e18 <open>
    3606:	87aa                	mv	a5,a0
    3608:	0007cd63          	bltz	a5,3622 <subdir+0x378>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    360c:	fd843583          	ld	a1,-40(s0)
    3610:	00005517          	auipc	a0,0x5
    3614:	38850513          	addi	a0,a0,904 # 8998 <malloc+0x12b4>
    3618:	6e5030ef          	jal	74fc <printf>
    exit(1);
    361c:	4505                	li	a0,1
    361e:	7ba030ef          	jal	6dd8 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3622:	20200593          	li	a1,514
    3626:	00005517          	auipc	a0,0x5
    362a:	3a250513          	addi	a0,a0,930 # 89c8 <malloc+0x12e4>
    362e:	7ea030ef          	jal	6e18 <open>
    3632:	87aa                	mv	a5,a0
    3634:	0007cd63          	bltz	a5,364e <subdir+0x3a4>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3638:	fd843583          	ld	a1,-40(s0)
    363c:	00005517          	auipc	a0,0x5
    3640:	39c50513          	addi	a0,a0,924 # 89d8 <malloc+0x12f4>
    3644:	6b9030ef          	jal	74fc <printf>
    exit(1);
    3648:	4505                	li	a0,1
    364a:	78e030ef          	jal	6dd8 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    364e:	20200593          	li	a1,514
    3652:	00005517          	auipc	a0,0x5
    3656:	3a650513          	addi	a0,a0,934 # 89f8 <malloc+0x1314>
    365a:	7be030ef          	jal	6e18 <open>
    365e:	87aa                	mv	a5,a0
    3660:	0007cd63          	bltz	a5,367a <subdir+0x3d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3664:	fd843583          	ld	a1,-40(s0)
    3668:	00005517          	auipc	a0,0x5
    366c:	3a050513          	addi	a0,a0,928 # 8a08 <malloc+0x1324>
    3670:	68d030ef          	jal	74fc <printf>
    exit(1);
    3674:	4505                	li	a0,1
    3676:	762030ef          	jal	6dd8 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    367a:	20000593          	li	a1,512
    367e:	00005517          	auipc	a0,0x5
    3682:	09250513          	addi	a0,a0,146 # 8710 <malloc+0x102c>
    3686:	792030ef          	jal	6e18 <open>
    368a:	87aa                	mv	a5,a0
    368c:	0007cd63          	bltz	a5,36a6 <subdir+0x3fc>
    printf("%s: create dd succeeded!\n", s);
    3690:	fd843583          	ld	a1,-40(s0)
    3694:	00005517          	auipc	a0,0x5
    3698:	39450513          	addi	a0,a0,916 # 8a28 <malloc+0x1344>
    369c:	661030ef          	jal	74fc <printf>
    exit(1);
    36a0:	4505                	li	a0,1
    36a2:	736030ef          	jal	6dd8 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    36a6:	4589                	li	a1,2
    36a8:	00005517          	auipc	a0,0x5
    36ac:	06850513          	addi	a0,a0,104 # 8710 <malloc+0x102c>
    36b0:	768030ef          	jal	6e18 <open>
    36b4:	87aa                	mv	a5,a0
    36b6:	0007cd63          	bltz	a5,36d0 <subdir+0x426>
    printf("%s: open dd rdwr succeeded!\n", s);
    36ba:	fd843583          	ld	a1,-40(s0)
    36be:	00005517          	auipc	a0,0x5
    36c2:	38a50513          	addi	a0,a0,906 # 8a48 <malloc+0x1364>
    36c6:	637030ef          	jal	74fc <printf>
    exit(1);
    36ca:	4505                	li	a0,1
    36cc:	70c030ef          	jal	6dd8 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    36d0:	4585                	li	a1,1
    36d2:	00005517          	auipc	a0,0x5
    36d6:	03e50513          	addi	a0,a0,62 # 8710 <malloc+0x102c>
    36da:	73e030ef          	jal	6e18 <open>
    36de:	87aa                	mv	a5,a0
    36e0:	0007cd63          	bltz	a5,36fa <subdir+0x450>
    printf("%s: open dd wronly succeeded!\n", s);
    36e4:	fd843583          	ld	a1,-40(s0)
    36e8:	00005517          	auipc	a0,0x5
    36ec:	38050513          	addi	a0,a0,896 # 8a68 <malloc+0x1384>
    36f0:	60d030ef          	jal	74fc <printf>
    exit(1);
    36f4:	4505                	li	a0,1
    36f6:	6e2030ef          	jal	6dd8 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    36fa:	00005597          	auipc	a1,0x5
    36fe:	38e58593          	addi	a1,a1,910 # 8a88 <malloc+0x13a4>
    3702:	00005517          	auipc	a0,0x5
    3706:	2c650513          	addi	a0,a0,710 # 89c8 <malloc+0x12e4>
    370a:	72e030ef          	jal	6e38 <link>
    370e:	87aa                	mv	a5,a0
    3710:	ef81                	bnez	a5,3728 <subdir+0x47e>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3712:	fd843583          	ld	a1,-40(s0)
    3716:	00005517          	auipc	a0,0x5
    371a:	38250513          	addi	a0,a0,898 # 8a98 <malloc+0x13b4>
    371e:	5df030ef          	jal	74fc <printf>
    exit(1);
    3722:	4505                	li	a0,1
    3724:	6b4030ef          	jal	6dd8 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3728:	00005597          	auipc	a1,0x5
    372c:	36058593          	addi	a1,a1,864 # 8a88 <malloc+0x13a4>
    3730:	00005517          	auipc	a0,0x5
    3734:	2c850513          	addi	a0,a0,712 # 89f8 <malloc+0x1314>
    3738:	700030ef          	jal	6e38 <link>
    373c:	87aa                	mv	a5,a0
    373e:	ef81                	bnez	a5,3756 <subdir+0x4ac>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3740:	fd843583          	ld	a1,-40(s0)
    3744:	00005517          	auipc	a0,0x5
    3748:	37c50513          	addi	a0,a0,892 # 8ac0 <malloc+0x13dc>
    374c:	5b1030ef          	jal	74fc <printf>
    exit(1);
    3750:	4505                	li	a0,1
    3752:	686030ef          	jal	6dd8 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3756:	00005597          	auipc	a1,0x5
    375a:	0e258593          	addi	a1,a1,226 # 8838 <malloc+0x1154>
    375e:	00005517          	auipc	a0,0x5
    3762:	fd250513          	addi	a0,a0,-46 # 8730 <malloc+0x104c>
    3766:	6d2030ef          	jal	6e38 <link>
    376a:	87aa                	mv	a5,a0
    376c:	ef81                	bnez	a5,3784 <subdir+0x4da>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    376e:	fd843583          	ld	a1,-40(s0)
    3772:	00005517          	auipc	a0,0x5
    3776:	37650513          	addi	a0,a0,886 # 8ae8 <malloc+0x1404>
    377a:	583030ef          	jal	74fc <printf>
    exit(1);
    377e:	4505                	li	a0,1
    3780:	658030ef          	jal	6dd8 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    3784:	00005517          	auipc	a0,0x5
    3788:	24450513          	addi	a0,a0,580 # 89c8 <malloc+0x12e4>
    378c:	6b4030ef          	jal	6e40 <mkdir>
    3790:	87aa                	mv	a5,a0
    3792:	ef81                	bnez	a5,37aa <subdir+0x500>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3794:	fd843583          	ld	a1,-40(s0)
    3798:	00005517          	auipc	a0,0x5
    379c:	37850513          	addi	a0,a0,888 # 8b10 <malloc+0x142c>
    37a0:	55d030ef          	jal	74fc <printf>
    exit(1);
    37a4:	4505                	li	a0,1
    37a6:	632030ef          	jal	6dd8 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    37aa:	00005517          	auipc	a0,0x5
    37ae:	24e50513          	addi	a0,a0,590 # 89f8 <malloc+0x1314>
    37b2:	68e030ef          	jal	6e40 <mkdir>
    37b6:	87aa                	mv	a5,a0
    37b8:	ef81                	bnez	a5,37d0 <subdir+0x526>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    37ba:	fd843583          	ld	a1,-40(s0)
    37be:	00005517          	auipc	a0,0x5
    37c2:	37250513          	addi	a0,a0,882 # 8b30 <malloc+0x144c>
    37c6:	537030ef          	jal	74fc <printf>
    exit(1);
    37ca:	4505                	li	a0,1
    37cc:	60c030ef          	jal	6dd8 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    37d0:	00005517          	auipc	a0,0x5
    37d4:	06850513          	addi	a0,a0,104 # 8838 <malloc+0x1154>
    37d8:	668030ef          	jal	6e40 <mkdir>
    37dc:	87aa                	mv	a5,a0
    37de:	ef81                	bnez	a5,37f6 <subdir+0x54c>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    37e0:	fd843583          	ld	a1,-40(s0)
    37e4:	00005517          	auipc	a0,0x5
    37e8:	36c50513          	addi	a0,a0,876 # 8b50 <malloc+0x146c>
    37ec:	511030ef          	jal	74fc <printf>
    exit(1);
    37f0:	4505                	li	a0,1
    37f2:	5e6030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    37f6:	00005517          	auipc	a0,0x5
    37fa:	20250513          	addi	a0,a0,514 # 89f8 <malloc+0x1314>
    37fe:	62a030ef          	jal	6e28 <unlink>
    3802:	87aa                	mv	a5,a0
    3804:	ef81                	bnez	a5,381c <subdir+0x572>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3806:	fd843583          	ld	a1,-40(s0)
    380a:	00005517          	auipc	a0,0x5
    380e:	36e50513          	addi	a0,a0,878 # 8b78 <malloc+0x1494>
    3812:	4eb030ef          	jal	74fc <printf>
    exit(1);
    3816:	4505                	li	a0,1
    3818:	5c0030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    381c:	00005517          	auipc	a0,0x5
    3820:	1ac50513          	addi	a0,a0,428 # 89c8 <malloc+0x12e4>
    3824:	604030ef          	jal	6e28 <unlink>
    3828:	87aa                	mv	a5,a0
    382a:	ef81                	bnez	a5,3842 <subdir+0x598>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    382c:	fd843583          	ld	a1,-40(s0)
    3830:	00005517          	auipc	a0,0x5
    3834:	36850513          	addi	a0,a0,872 # 8b98 <malloc+0x14b4>
    3838:	4c5030ef          	jal	74fc <printf>
    exit(1);
    383c:	4505                	li	a0,1
    383e:	59a030ef          	jal	6dd8 <exit>
  }
  if(chdir("dd/ff") == 0){
    3842:	00005517          	auipc	a0,0x5
    3846:	eee50513          	addi	a0,a0,-274 # 8730 <malloc+0x104c>
    384a:	5fe030ef          	jal	6e48 <chdir>
    384e:	87aa                	mv	a5,a0
    3850:	ef81                	bnez	a5,3868 <subdir+0x5be>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3852:	fd843583          	ld	a1,-40(s0)
    3856:	00005517          	auipc	a0,0x5
    385a:	36250513          	addi	a0,a0,866 # 8bb8 <malloc+0x14d4>
    385e:	49f030ef          	jal	74fc <printf>
    exit(1);
    3862:	4505                	li	a0,1
    3864:	574030ef          	jal	6dd8 <exit>
  }
  if(chdir("dd/xx") == 0){
    3868:	00005517          	auipc	a0,0x5
    386c:	37050513          	addi	a0,a0,880 # 8bd8 <malloc+0x14f4>
    3870:	5d8030ef          	jal	6e48 <chdir>
    3874:	87aa                	mv	a5,a0
    3876:	ef81                	bnez	a5,388e <subdir+0x5e4>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3878:	fd843583          	ld	a1,-40(s0)
    387c:	00005517          	auipc	a0,0x5
    3880:	36450513          	addi	a0,a0,868 # 8be0 <malloc+0x14fc>
    3884:	479030ef          	jal	74fc <printf>
    exit(1);
    3888:	4505                	li	a0,1
    388a:	54e030ef          	jal	6dd8 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    388e:	00005517          	auipc	a0,0x5
    3892:	faa50513          	addi	a0,a0,-86 # 8838 <malloc+0x1154>
    3896:	592030ef          	jal	6e28 <unlink>
    389a:	87aa                	mv	a5,a0
    389c:	cf81                	beqz	a5,38b4 <subdir+0x60a>
    printf("%s: unlink dd/dd/ff failed\n", s);
    389e:	fd843583          	ld	a1,-40(s0)
    38a2:	00005517          	auipc	a0,0x5
    38a6:	fce50513          	addi	a0,a0,-50 # 8870 <malloc+0x118c>
    38aa:	453030ef          	jal	74fc <printf>
    exit(1);
    38ae:	4505                	li	a0,1
    38b0:	528030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd/ff") != 0){
    38b4:	00005517          	auipc	a0,0x5
    38b8:	e7c50513          	addi	a0,a0,-388 # 8730 <malloc+0x104c>
    38bc:	56c030ef          	jal	6e28 <unlink>
    38c0:	87aa                	mv	a5,a0
    38c2:	cf81                	beqz	a5,38da <subdir+0x630>
    printf("%s: unlink dd/ff failed\n", s);
    38c4:	fd843583          	ld	a1,-40(s0)
    38c8:	00005517          	auipc	a0,0x5
    38cc:	33850513          	addi	a0,a0,824 # 8c00 <malloc+0x151c>
    38d0:	42d030ef          	jal	74fc <printf>
    exit(1);
    38d4:	4505                	li	a0,1
    38d6:	502030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd") == 0){
    38da:	00005517          	auipc	a0,0x5
    38de:	e3650513          	addi	a0,a0,-458 # 8710 <malloc+0x102c>
    38e2:	546030ef          	jal	6e28 <unlink>
    38e6:	87aa                	mv	a5,a0
    38e8:	ef81                	bnez	a5,3900 <subdir+0x656>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    38ea:	fd843583          	ld	a1,-40(s0)
    38ee:	00005517          	auipc	a0,0x5
    38f2:	33250513          	addi	a0,a0,818 # 8c20 <malloc+0x153c>
    38f6:	407030ef          	jal	74fc <printf>
    exit(1);
    38fa:	4505                	li	a0,1
    38fc:	4dc030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd/dd") < 0){
    3900:	00005517          	auipc	a0,0x5
    3904:	34850513          	addi	a0,a0,840 # 8c48 <malloc+0x1564>
    3908:	520030ef          	jal	6e28 <unlink>
    390c:	87aa                	mv	a5,a0
    390e:	0007dd63          	bgez	a5,3928 <subdir+0x67e>
    printf("%s: unlink dd/dd failed\n", s);
    3912:	fd843583          	ld	a1,-40(s0)
    3916:	00005517          	auipc	a0,0x5
    391a:	33a50513          	addi	a0,a0,826 # 8c50 <malloc+0x156c>
    391e:	3df030ef          	jal	74fc <printf>
    exit(1);
    3922:	4505                	li	a0,1
    3924:	4b4030ef          	jal	6dd8 <exit>
  }
  if(unlink("dd") < 0){
    3928:	00005517          	auipc	a0,0x5
    392c:	de850513          	addi	a0,a0,-536 # 8710 <malloc+0x102c>
    3930:	4f8030ef          	jal	6e28 <unlink>
    3934:	87aa                	mv	a5,a0
    3936:	0007dd63          	bgez	a5,3950 <subdir+0x6a6>
    printf("%s: unlink dd failed\n", s);
    393a:	fd843583          	ld	a1,-40(s0)
    393e:	00005517          	auipc	a0,0x5
    3942:	33250513          	addi	a0,a0,818 # 8c70 <malloc+0x158c>
    3946:	3b7030ef          	jal	74fc <printf>
    exit(1);
    394a:	4505                	li	a0,1
    394c:	48c030ef          	jal	6dd8 <exit>
  }
}
    3950:	0001                	nop
    3952:	70a2                	ld	ra,40(sp)
    3954:	7402                	ld	s0,32(sp)
    3956:	6145                	addi	sp,sp,48
    3958:	8082                	ret

000000000000395a <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    395a:	7179                	addi	sp,sp,-48
    395c:	f406                	sd	ra,40(sp)
    395e:	f022                	sd	s0,32(sp)
    3960:	1800                	addi	s0,sp,48
    3962:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    3966:	00005517          	auipc	a0,0x5
    396a:	32250513          	addi	a0,a0,802 # 8c88 <malloc+0x15a4>
    396e:	4ba030ef          	jal	6e28 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    3972:	1f300793          	li	a5,499
    3976:	fef42623          	sw	a5,-20(s0)
    397a:	a0e9                	j	3a44 <bigwrite+0xea>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    397c:	20200593          	li	a1,514
    3980:	00005517          	auipc	a0,0x5
    3984:	30850513          	addi	a0,a0,776 # 8c88 <malloc+0x15a4>
    3988:	490030ef          	jal	6e18 <open>
    398c:	87aa                	mv	a5,a0
    398e:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    3992:	fe442783          	lw	a5,-28(s0)
    3996:	2781                	sext.w	a5,a5
    3998:	0007dd63          	bgez	a5,39b2 <bigwrite+0x58>
      printf("%s: cannot create bigwrite\n", s);
    399c:	fd843583          	ld	a1,-40(s0)
    39a0:	00005517          	auipc	a0,0x5
    39a4:	2f850513          	addi	a0,a0,760 # 8c98 <malloc+0x15b4>
    39a8:	355030ef          	jal	74fc <printf>
      exit(1);
    39ac:	4505                	li	a0,1
    39ae:	42a030ef          	jal	6dd8 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    39b2:	fe042423          	sw	zero,-24(s0)
    39b6:	a8b9                	j	3a14 <bigwrite+0xba>
      int cc = write(fd, buf, sz);
    39b8:	fec42703          	lw	a4,-20(s0)
    39bc:	fe442783          	lw	a5,-28(s0)
    39c0:	863a                	mv	a2,a4
    39c2:	00007597          	auipc	a1,0x7
    39c6:	aee58593          	addi	a1,a1,-1298 # a4b0 <buf>
    39ca:	853e                	mv	a0,a5
    39cc:	42c030ef          	jal	6df8 <write>
    39d0:	87aa                	mv	a5,a0
    39d2:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    39d6:	fe042783          	lw	a5,-32(s0)
    39da:	873e                	mv	a4,a5
    39dc:	fec42783          	lw	a5,-20(s0)
    39e0:	2701                	sext.w	a4,a4
    39e2:	2781                	sext.w	a5,a5
    39e4:	02f70363          	beq	a4,a5,3a0a <bigwrite+0xb0>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    39e8:	fe042703          	lw	a4,-32(s0)
    39ec:	fec42783          	lw	a5,-20(s0)
    39f0:	86ba                	mv	a3,a4
    39f2:	863e                	mv	a2,a5
    39f4:	fd843583          	ld	a1,-40(s0)
    39f8:	00005517          	auipc	a0,0x5
    39fc:	2c050513          	addi	a0,a0,704 # 8cb8 <malloc+0x15d4>
    3a00:	2fd030ef          	jal	74fc <printf>
        exit(1);
    3a04:	4505                	li	a0,1
    3a06:	3d2030ef          	jal	6dd8 <exit>
    for(i = 0; i < 2; i++){
    3a0a:	fe842783          	lw	a5,-24(s0)
    3a0e:	2785                	addiw	a5,a5,1
    3a10:	fef42423          	sw	a5,-24(s0)
    3a14:	fe842783          	lw	a5,-24(s0)
    3a18:	0007871b          	sext.w	a4,a5
    3a1c:	4785                	li	a5,1
    3a1e:	f8e7dde3          	bge	a5,a4,39b8 <bigwrite+0x5e>
      }
    }
    close(fd);
    3a22:	fe442783          	lw	a5,-28(s0)
    3a26:	853e                	mv	a0,a5
    3a28:	3d8030ef          	jal	6e00 <close>
    unlink("bigwrite");
    3a2c:	00005517          	auipc	a0,0x5
    3a30:	25c50513          	addi	a0,a0,604 # 8c88 <malloc+0x15a4>
    3a34:	3f4030ef          	jal	6e28 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    3a38:	fec42783          	lw	a5,-20(s0)
    3a3c:	1d77879b          	addiw	a5,a5,471
    3a40:	fef42623          	sw	a5,-20(s0)
    3a44:	fec42783          	lw	a5,-20(s0)
    3a48:	0007871b          	sext.w	a4,a5
    3a4c:	678d                	lui	a5,0x3
    3a4e:	f2f747e3          	blt	a4,a5,397c <bigwrite+0x22>
  }
}
    3a52:	0001                	nop
    3a54:	0001                	nop
    3a56:	70a2                	ld	ra,40(sp)
    3a58:	7402                	ld	s0,32(sp)
    3a5a:	6145                	addi	sp,sp,48
    3a5c:	8082                	ret

0000000000003a5e <bigfile>:


void
bigfile(char *s)
{
    3a5e:	7179                	addi	sp,sp,-48
    3a60:	f406                	sd	ra,40(sp)
    3a62:	f022                	sd	s0,32(sp)
    3a64:	1800                	addi	s0,sp,48
    3a66:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    3a6a:	00005517          	auipc	a0,0x5
    3a6e:	26650513          	addi	a0,a0,614 # 8cd0 <malloc+0x15ec>
    3a72:	3b6030ef          	jal	6e28 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    3a76:	20200593          	li	a1,514
    3a7a:	00005517          	auipc	a0,0x5
    3a7e:	25650513          	addi	a0,a0,598 # 8cd0 <malloc+0x15ec>
    3a82:	396030ef          	jal	6e18 <open>
    3a86:	87aa                	mv	a5,a0
    3a88:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    3a8c:	fe442783          	lw	a5,-28(s0)
    3a90:	2781                	sext.w	a5,a5
    3a92:	0007dd63          	bgez	a5,3aac <bigfile+0x4e>
    printf("%s: cannot create bigfile", s);
    3a96:	fd843583          	ld	a1,-40(s0)
    3a9a:	00005517          	auipc	a0,0x5
    3a9e:	24650513          	addi	a0,a0,582 # 8ce0 <malloc+0x15fc>
    3aa2:	25b030ef          	jal	74fc <printf>
    exit(1);
    3aa6:	4505                	li	a0,1
    3aa8:	330030ef          	jal	6dd8 <exit>
  }
  for(i = 0; i < N; i++){
    3aac:	fe042623          	sw	zero,-20(s0)
    3ab0:	a8a9                	j	3b0a <bigfile+0xac>
    memset(buf, i, SZ);
    3ab2:	fec42783          	lw	a5,-20(s0)
    3ab6:	25800613          	li	a2,600
    3aba:	85be                	mv	a1,a5
    3abc:	00007517          	auipc	a0,0x7
    3ac0:	9f450513          	addi	a0,a0,-1548 # a4b0 <buf>
    3ac4:	71f020ef          	jal	69e2 <memset>
    if(write(fd, buf, SZ) != SZ){
    3ac8:	fe442783          	lw	a5,-28(s0)
    3acc:	25800613          	li	a2,600
    3ad0:	00007597          	auipc	a1,0x7
    3ad4:	9e058593          	addi	a1,a1,-1568 # a4b0 <buf>
    3ad8:	853e                	mv	a0,a5
    3ada:	31e030ef          	jal	6df8 <write>
    3ade:	87aa                	mv	a5,a0
    3ae0:	873e                	mv	a4,a5
    3ae2:	25800793          	li	a5,600
    3ae6:	00f70d63          	beq	a4,a5,3b00 <bigfile+0xa2>
      printf("%s: write bigfile failed\n", s);
    3aea:	fd843583          	ld	a1,-40(s0)
    3aee:	00005517          	auipc	a0,0x5
    3af2:	21250513          	addi	a0,a0,530 # 8d00 <malloc+0x161c>
    3af6:	207030ef          	jal	74fc <printf>
      exit(1);
    3afa:	4505                	li	a0,1
    3afc:	2dc030ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    3b00:	fec42783          	lw	a5,-20(s0)
    3b04:	2785                	addiw	a5,a5,1 # 3001 <concreate+0x2d3>
    3b06:	fef42623          	sw	a5,-20(s0)
    3b0a:	fec42783          	lw	a5,-20(s0)
    3b0e:	0007871b          	sext.w	a4,a5
    3b12:	47cd                	li	a5,19
    3b14:	f8e7dfe3          	bge	a5,a4,3ab2 <bigfile+0x54>
    }
  }
  close(fd);
    3b18:	fe442783          	lw	a5,-28(s0)
    3b1c:	853e                	mv	a0,a5
    3b1e:	2e2030ef          	jal	6e00 <close>

  fd = open("bigfile.dat", 0);
    3b22:	4581                	li	a1,0
    3b24:	00005517          	auipc	a0,0x5
    3b28:	1ac50513          	addi	a0,a0,428 # 8cd0 <malloc+0x15ec>
    3b2c:	2ec030ef          	jal	6e18 <open>
    3b30:	87aa                	mv	a5,a0
    3b32:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    3b36:	fe442783          	lw	a5,-28(s0)
    3b3a:	2781                	sext.w	a5,a5
    3b3c:	0007dd63          	bgez	a5,3b56 <bigfile+0xf8>
    printf("%s: cannot open bigfile\n", s);
    3b40:	fd843583          	ld	a1,-40(s0)
    3b44:	00005517          	auipc	a0,0x5
    3b48:	1dc50513          	addi	a0,a0,476 # 8d20 <malloc+0x163c>
    3b4c:	1b1030ef          	jal	74fc <printf>
    exit(1);
    3b50:	4505                	li	a0,1
    3b52:	286030ef          	jal	6dd8 <exit>
  }
  total = 0;
    3b56:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    3b5a:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    3b5e:	fe442783          	lw	a5,-28(s0)
    3b62:	12c00613          	li	a2,300
    3b66:	00007597          	auipc	a1,0x7
    3b6a:	94a58593          	addi	a1,a1,-1718 # a4b0 <buf>
    3b6e:	853e                	mv	a0,a5
    3b70:	280030ef          	jal	6df0 <read>
    3b74:	87aa                	mv	a5,a0
    3b76:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    3b7a:	fe042783          	lw	a5,-32(s0)
    3b7e:	2781                	sext.w	a5,a5
    3b80:	0007dd63          	bgez	a5,3b9a <bigfile+0x13c>
      printf("%s: read bigfile failed\n", s);
    3b84:	fd843583          	ld	a1,-40(s0)
    3b88:	00005517          	auipc	a0,0x5
    3b8c:	1b850513          	addi	a0,a0,440 # 8d40 <malloc+0x165c>
    3b90:	16d030ef          	jal	74fc <printf>
      exit(1);
    3b94:	4505                	li	a0,1
    3b96:	242030ef          	jal	6dd8 <exit>
    }
    if(cc == 0)
    3b9a:	fe042783          	lw	a5,-32(s0)
    3b9e:	2781                	sext.w	a5,a5
    3ba0:	c3cd                	beqz	a5,3c42 <bigfile+0x1e4>
      break;
    if(cc != SZ/2){
    3ba2:	fe042783          	lw	a5,-32(s0)
    3ba6:	0007871b          	sext.w	a4,a5
    3baa:	12c00793          	li	a5,300
    3bae:	00f70d63          	beq	a4,a5,3bc8 <bigfile+0x16a>
      printf("%s: short read bigfile\n", s);
    3bb2:	fd843583          	ld	a1,-40(s0)
    3bb6:	00005517          	auipc	a0,0x5
    3bba:	1aa50513          	addi	a0,a0,426 # 8d60 <malloc+0x167c>
    3bbe:	13f030ef          	jal	74fc <printf>
      exit(1);
    3bc2:	4505                	li	a0,1
    3bc4:	214030ef          	jal	6dd8 <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    3bc8:	00007797          	auipc	a5,0x7
    3bcc:	8e878793          	addi	a5,a5,-1816 # a4b0 <buf>
    3bd0:	0007c783          	lbu	a5,0(a5)
    3bd4:	0007871b          	sext.w	a4,a5
    3bd8:	fec42783          	lw	a5,-20(s0)
    3bdc:	01f7d69b          	srliw	a3,a5,0x1f
    3be0:	9fb5                	addw	a5,a5,a3
    3be2:	4017d79b          	sraiw	a5,a5,0x1
    3be6:	2781                	sext.w	a5,a5
    3be8:	02f71463          	bne	a4,a5,3c10 <bigfile+0x1b2>
    3bec:	00007797          	auipc	a5,0x7
    3bf0:	8c478793          	addi	a5,a5,-1852 # a4b0 <buf>
    3bf4:	12b7c783          	lbu	a5,299(a5)
    3bf8:	0007871b          	sext.w	a4,a5
    3bfc:	fec42783          	lw	a5,-20(s0)
    3c00:	01f7d69b          	srliw	a3,a5,0x1f
    3c04:	9fb5                	addw	a5,a5,a3
    3c06:	4017d79b          	sraiw	a5,a5,0x1
    3c0a:	2781                	sext.w	a5,a5
    3c0c:	00f70d63          	beq	a4,a5,3c26 <bigfile+0x1c8>
      printf("%s: read bigfile wrong data\n", s);
    3c10:	fd843583          	ld	a1,-40(s0)
    3c14:	00005517          	auipc	a0,0x5
    3c18:	16450513          	addi	a0,a0,356 # 8d78 <malloc+0x1694>
    3c1c:	0e1030ef          	jal	74fc <printf>
      exit(1);
    3c20:	4505                	li	a0,1
    3c22:	1b6030ef          	jal	6dd8 <exit>
    }
    total += cc;
    3c26:	fe842783          	lw	a5,-24(s0)
    3c2a:	873e                	mv	a4,a5
    3c2c:	fe042783          	lw	a5,-32(s0)
    3c30:	9fb9                	addw	a5,a5,a4
    3c32:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    3c36:	fec42783          	lw	a5,-20(s0)
    3c3a:	2785                	addiw	a5,a5,1
    3c3c:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    3c40:	bf39                	j	3b5e <bigfile+0x100>
      break;
    3c42:	0001                	nop
  }
  close(fd);
    3c44:	fe442783          	lw	a5,-28(s0)
    3c48:	853e                	mv	a0,a5
    3c4a:	1b6030ef          	jal	6e00 <close>
  if(total != N*SZ){
    3c4e:	fe842783          	lw	a5,-24(s0)
    3c52:	0007871b          	sext.w	a4,a5
    3c56:	678d                	lui	a5,0x3
    3c58:	ee078793          	addi	a5,a5,-288 # 2ee0 <concreate+0x1b2>
    3c5c:	00f70d63          	beq	a4,a5,3c76 <bigfile+0x218>
    printf("%s: read bigfile wrong total\n", s);
    3c60:	fd843583          	ld	a1,-40(s0)
    3c64:	00005517          	auipc	a0,0x5
    3c68:	13450513          	addi	a0,a0,308 # 8d98 <malloc+0x16b4>
    3c6c:	091030ef          	jal	74fc <printf>
    exit(1);
    3c70:	4505                	li	a0,1
    3c72:	166030ef          	jal	6dd8 <exit>
  }
  unlink("bigfile.dat");
    3c76:	00005517          	auipc	a0,0x5
    3c7a:	05a50513          	addi	a0,a0,90 # 8cd0 <malloc+0x15ec>
    3c7e:	1aa030ef          	jal	6e28 <unlink>
}
    3c82:	0001                	nop
    3c84:	70a2                	ld	ra,40(sp)
    3c86:	7402                	ld	s0,32(sp)
    3c88:	6145                	addi	sp,sp,48
    3c8a:	8082                	ret

0000000000003c8c <fourteen>:

void
fourteen(char *s)
{
    3c8c:	7179                	addi	sp,sp,-48
    3c8e:	f406                	sd	ra,40(sp)
    3c90:	f022                	sd	s0,32(sp)
    3c92:	1800                	addi	s0,sp,48
    3c94:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    3c98:	00005517          	auipc	a0,0x5
    3c9c:	12050513          	addi	a0,a0,288 # 8db8 <malloc+0x16d4>
    3ca0:	1a0030ef          	jal	6e40 <mkdir>
    3ca4:	87aa                	mv	a5,a0
    3ca6:	cf81                	beqz	a5,3cbe <fourteen+0x32>
    printf("%s: mkdir 12345678901234 failed\n", s);
    3ca8:	fd843583          	ld	a1,-40(s0)
    3cac:	00005517          	auipc	a0,0x5
    3cb0:	11c50513          	addi	a0,a0,284 # 8dc8 <malloc+0x16e4>
    3cb4:	049030ef          	jal	74fc <printf>
    exit(1);
    3cb8:	4505                	li	a0,1
    3cba:	11e030ef          	jal	6dd8 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    3cbe:	00005517          	auipc	a0,0x5
    3cc2:	13250513          	addi	a0,a0,306 # 8df0 <malloc+0x170c>
    3cc6:	17a030ef          	jal	6e40 <mkdir>
    3cca:	87aa                	mv	a5,a0
    3ccc:	cf81                	beqz	a5,3ce4 <fourteen+0x58>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3cce:	fd843583          	ld	a1,-40(s0)
    3cd2:	00005517          	auipc	a0,0x5
    3cd6:	13e50513          	addi	a0,a0,318 # 8e10 <malloc+0x172c>
    3cda:	023030ef          	jal	74fc <printf>
    exit(1);
    3cde:	4505                	li	a0,1
    3ce0:	0f8030ef          	jal	6dd8 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3ce4:	20000593          	li	a1,512
    3ce8:	00005517          	auipc	a0,0x5
    3cec:	16050513          	addi	a0,a0,352 # 8e48 <malloc+0x1764>
    3cf0:	128030ef          	jal	6e18 <open>
    3cf4:	87aa                	mv	a5,a0
    3cf6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3cfa:	fec42783          	lw	a5,-20(s0)
    3cfe:	2781                	sext.w	a5,a5
    3d00:	0007dd63          	bgez	a5,3d1a <fourteen+0x8e>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3d04:	fd843583          	ld	a1,-40(s0)
    3d08:	00005517          	auipc	a0,0x5
    3d0c:	17050513          	addi	a0,a0,368 # 8e78 <malloc+0x1794>
    3d10:	7ec030ef          	jal	74fc <printf>
    exit(1);
    3d14:	4505                	li	a0,1
    3d16:	0c2030ef          	jal	6dd8 <exit>
  }
  close(fd);
    3d1a:	fec42783          	lw	a5,-20(s0)
    3d1e:	853e                	mv	a0,a5
    3d20:	0e0030ef          	jal	6e00 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3d24:	4581                	li	a1,0
    3d26:	00005517          	auipc	a0,0x5
    3d2a:	19a50513          	addi	a0,a0,410 # 8ec0 <malloc+0x17dc>
    3d2e:	0ea030ef          	jal	6e18 <open>
    3d32:	87aa                	mv	a5,a0
    3d34:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3d38:	fec42783          	lw	a5,-20(s0)
    3d3c:	2781                	sext.w	a5,a5
    3d3e:	0007dd63          	bgez	a5,3d58 <fourteen+0xcc>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3d42:	fd843583          	ld	a1,-40(s0)
    3d46:	00005517          	auipc	a0,0x5
    3d4a:	1aa50513          	addi	a0,a0,426 # 8ef0 <malloc+0x180c>
    3d4e:	7ae030ef          	jal	74fc <printf>
    exit(1);
    3d52:	4505                	li	a0,1
    3d54:	084030ef          	jal	6dd8 <exit>
  }
  close(fd);
    3d58:	fec42783          	lw	a5,-20(s0)
    3d5c:	853e                	mv	a0,a5
    3d5e:	0a2030ef          	jal	6e00 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    3d62:	00005517          	auipc	a0,0x5
    3d66:	1ce50513          	addi	a0,a0,462 # 8f30 <malloc+0x184c>
    3d6a:	0d6030ef          	jal	6e40 <mkdir>
    3d6e:	87aa                	mv	a5,a0
    3d70:	ef81                	bnez	a5,3d88 <fourteen+0xfc>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3d72:	fd843583          	ld	a1,-40(s0)
    3d76:	00005517          	auipc	a0,0x5
    3d7a:	1da50513          	addi	a0,a0,474 # 8f50 <malloc+0x186c>
    3d7e:	77e030ef          	jal	74fc <printf>
    exit(1);
    3d82:	4505                	li	a0,1
    3d84:	054030ef          	jal	6dd8 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    3d88:	00005517          	auipc	a0,0x5
    3d8c:	20050513          	addi	a0,a0,512 # 8f88 <malloc+0x18a4>
    3d90:	0b0030ef          	jal	6e40 <mkdir>
    3d94:	87aa                	mv	a5,a0
    3d96:	ef81                	bnez	a5,3dae <fourteen+0x122>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    3d98:	fd843583          	ld	a1,-40(s0)
    3d9c:	00005517          	auipc	a0,0x5
    3da0:	20c50513          	addi	a0,a0,524 # 8fa8 <malloc+0x18c4>
    3da4:	758030ef          	jal	74fc <printf>
    exit(1);
    3da8:	4505                	li	a0,1
    3daa:	02e030ef          	jal	6dd8 <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    3dae:	00005517          	auipc	a0,0x5
    3db2:	1da50513          	addi	a0,a0,474 # 8f88 <malloc+0x18a4>
    3db6:	072030ef          	jal	6e28 <unlink>
  unlink("12345678901234/12345678901234");
    3dba:	00005517          	auipc	a0,0x5
    3dbe:	17650513          	addi	a0,a0,374 # 8f30 <malloc+0x184c>
    3dc2:	066030ef          	jal	6e28 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    3dc6:	00005517          	auipc	a0,0x5
    3dca:	0fa50513          	addi	a0,a0,250 # 8ec0 <malloc+0x17dc>
    3dce:	05a030ef          	jal	6e28 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    3dd2:	00005517          	auipc	a0,0x5
    3dd6:	07650513          	addi	a0,a0,118 # 8e48 <malloc+0x1764>
    3dda:	04e030ef          	jal	6e28 <unlink>
  unlink("12345678901234/123456789012345");
    3dde:	00005517          	auipc	a0,0x5
    3de2:	01250513          	addi	a0,a0,18 # 8df0 <malloc+0x170c>
    3de6:	042030ef          	jal	6e28 <unlink>
  unlink("12345678901234");
    3dea:	00005517          	auipc	a0,0x5
    3dee:	fce50513          	addi	a0,a0,-50 # 8db8 <malloc+0x16d4>
    3df2:	036030ef          	jal	6e28 <unlink>
}
    3df6:	0001                	nop
    3df8:	70a2                	ld	ra,40(sp)
    3dfa:	7402                	ld	s0,32(sp)
    3dfc:	6145                	addi	sp,sp,48
    3dfe:	8082                	ret

0000000000003e00 <rmdot>:

void
rmdot(char *s)
{
    3e00:	1101                	addi	sp,sp,-32
    3e02:	ec06                	sd	ra,24(sp)
    3e04:	e822                	sd	s0,16(sp)
    3e06:	1000                	addi	s0,sp,32
    3e08:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    3e0c:	00005517          	auipc	a0,0x5
    3e10:	1d450513          	addi	a0,a0,468 # 8fe0 <malloc+0x18fc>
    3e14:	02c030ef          	jal	6e40 <mkdir>
    3e18:	87aa                	mv	a5,a0
    3e1a:	cf81                	beqz	a5,3e32 <rmdot+0x32>
    printf("%s: mkdir dots failed\n", s);
    3e1c:	fe843583          	ld	a1,-24(s0)
    3e20:	00005517          	auipc	a0,0x5
    3e24:	1c850513          	addi	a0,a0,456 # 8fe8 <malloc+0x1904>
    3e28:	6d4030ef          	jal	74fc <printf>
    exit(1);
    3e2c:	4505                	li	a0,1
    3e2e:	7ab020ef          	jal	6dd8 <exit>
  }
  if(chdir("dots") != 0){
    3e32:	00005517          	auipc	a0,0x5
    3e36:	1ae50513          	addi	a0,a0,430 # 8fe0 <malloc+0x18fc>
    3e3a:	00e030ef          	jal	6e48 <chdir>
    3e3e:	87aa                	mv	a5,a0
    3e40:	cf81                	beqz	a5,3e58 <rmdot+0x58>
    printf("%s: chdir dots failed\n", s);
    3e42:	fe843583          	ld	a1,-24(s0)
    3e46:	00005517          	auipc	a0,0x5
    3e4a:	1ba50513          	addi	a0,a0,442 # 9000 <malloc+0x191c>
    3e4e:	6ae030ef          	jal	74fc <printf>
    exit(1);
    3e52:	4505                	li	a0,1
    3e54:	785020ef          	jal	6dd8 <exit>
  }
  if(unlink(".") == 0){
    3e58:	00004517          	auipc	a0,0x4
    3e5c:	7d850513          	addi	a0,a0,2008 # 8630 <malloc+0xf4c>
    3e60:	7c9020ef          	jal	6e28 <unlink>
    3e64:	87aa                	mv	a5,a0
    3e66:	ef81                	bnez	a5,3e7e <rmdot+0x7e>
    printf("%s: rm . worked!\n", s);
    3e68:	fe843583          	ld	a1,-24(s0)
    3e6c:	00005517          	auipc	a0,0x5
    3e70:	1ac50513          	addi	a0,a0,428 # 9018 <malloc+0x1934>
    3e74:	688030ef          	jal	74fc <printf>
    exit(1);
    3e78:	4505                	li	a0,1
    3e7a:	75f020ef          	jal	6dd8 <exit>
  }
  if(unlink("..") == 0){
    3e7e:	00004517          	auipc	a0,0x4
    3e82:	21a50513          	addi	a0,a0,538 # 8098 <malloc+0x9b4>
    3e86:	7a3020ef          	jal	6e28 <unlink>
    3e8a:	87aa                	mv	a5,a0
    3e8c:	ef81                	bnez	a5,3ea4 <rmdot+0xa4>
    printf("%s: rm .. worked!\n", s);
    3e8e:	fe843583          	ld	a1,-24(s0)
    3e92:	00005517          	auipc	a0,0x5
    3e96:	19e50513          	addi	a0,a0,414 # 9030 <malloc+0x194c>
    3e9a:	662030ef          	jal	74fc <printf>
    exit(1);
    3e9e:	4505                	li	a0,1
    3ea0:	739020ef          	jal	6dd8 <exit>
  }
  if(chdir("/") != 0){
    3ea4:	00004517          	auipc	a0,0x4
    3ea8:	f0c50513          	addi	a0,a0,-244 # 7db0 <malloc+0x6cc>
    3eac:	79d020ef          	jal	6e48 <chdir>
    3eb0:	87aa                	mv	a5,a0
    3eb2:	cf81                	beqz	a5,3eca <rmdot+0xca>
    printf("%s: chdir / failed\n", s);
    3eb4:	fe843583          	ld	a1,-24(s0)
    3eb8:	00004517          	auipc	a0,0x4
    3ebc:	f0050513          	addi	a0,a0,-256 # 7db8 <malloc+0x6d4>
    3ec0:	63c030ef          	jal	74fc <printf>
    exit(1);
    3ec4:	4505                	li	a0,1
    3ec6:	713020ef          	jal	6dd8 <exit>
  }
  if(unlink("dots/.") == 0){
    3eca:	00005517          	auipc	a0,0x5
    3ece:	17e50513          	addi	a0,a0,382 # 9048 <malloc+0x1964>
    3ed2:	757020ef          	jal	6e28 <unlink>
    3ed6:	87aa                	mv	a5,a0
    3ed8:	ef81                	bnez	a5,3ef0 <rmdot+0xf0>
    printf("%s: unlink dots/. worked!\n", s);
    3eda:	fe843583          	ld	a1,-24(s0)
    3ede:	00005517          	auipc	a0,0x5
    3ee2:	17250513          	addi	a0,a0,370 # 9050 <malloc+0x196c>
    3ee6:	616030ef          	jal	74fc <printf>
    exit(1);
    3eea:	4505                	li	a0,1
    3eec:	6ed020ef          	jal	6dd8 <exit>
  }
  if(unlink("dots/..") == 0){
    3ef0:	00005517          	auipc	a0,0x5
    3ef4:	18050513          	addi	a0,a0,384 # 9070 <malloc+0x198c>
    3ef8:	731020ef          	jal	6e28 <unlink>
    3efc:	87aa                	mv	a5,a0
    3efe:	ef81                	bnez	a5,3f16 <rmdot+0x116>
    printf("%s: unlink dots/.. worked!\n", s);
    3f00:	fe843583          	ld	a1,-24(s0)
    3f04:	00005517          	auipc	a0,0x5
    3f08:	17450513          	addi	a0,a0,372 # 9078 <malloc+0x1994>
    3f0c:	5f0030ef          	jal	74fc <printf>
    exit(1);
    3f10:	4505                	li	a0,1
    3f12:	6c7020ef          	jal	6dd8 <exit>
  }
  if(unlink("dots") != 0){
    3f16:	00005517          	auipc	a0,0x5
    3f1a:	0ca50513          	addi	a0,a0,202 # 8fe0 <malloc+0x18fc>
    3f1e:	70b020ef          	jal	6e28 <unlink>
    3f22:	87aa                	mv	a5,a0
    3f24:	cf81                	beqz	a5,3f3c <rmdot+0x13c>
    printf("%s: unlink dots failed!\n", s);
    3f26:	fe843583          	ld	a1,-24(s0)
    3f2a:	00005517          	auipc	a0,0x5
    3f2e:	16e50513          	addi	a0,a0,366 # 9098 <malloc+0x19b4>
    3f32:	5ca030ef          	jal	74fc <printf>
    exit(1);
    3f36:	4505                	li	a0,1
    3f38:	6a1020ef          	jal	6dd8 <exit>
  }
}
    3f3c:	0001                	nop
    3f3e:	60e2                	ld	ra,24(sp)
    3f40:	6442                	ld	s0,16(sp)
    3f42:	6105                	addi	sp,sp,32
    3f44:	8082                	ret

0000000000003f46 <dirfile>:

void
dirfile(char *s)
{
    3f46:	7179                	addi	sp,sp,-48
    3f48:	f406                	sd	ra,40(sp)
    3f4a:	f022                	sd	s0,32(sp)
    3f4c:	1800                	addi	s0,sp,48
    3f4e:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    3f52:	20000593          	li	a1,512
    3f56:	00005517          	auipc	a0,0x5
    3f5a:	16250513          	addi	a0,a0,354 # 90b8 <malloc+0x19d4>
    3f5e:	6bb020ef          	jal	6e18 <open>
    3f62:	87aa                	mv	a5,a0
    3f64:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3f68:	fec42783          	lw	a5,-20(s0)
    3f6c:	2781                	sext.w	a5,a5
    3f6e:	0007dd63          	bgez	a5,3f88 <dirfile+0x42>
    printf("%s: create dirfile failed\n", s);
    3f72:	fd843583          	ld	a1,-40(s0)
    3f76:	00005517          	auipc	a0,0x5
    3f7a:	14a50513          	addi	a0,a0,330 # 90c0 <malloc+0x19dc>
    3f7e:	57e030ef          	jal	74fc <printf>
    exit(1);
    3f82:	4505                	li	a0,1
    3f84:	655020ef          	jal	6dd8 <exit>
  }
  close(fd);
    3f88:	fec42783          	lw	a5,-20(s0)
    3f8c:	853e                	mv	a0,a5
    3f8e:	673020ef          	jal	6e00 <close>
  if(chdir("dirfile") == 0){
    3f92:	00005517          	auipc	a0,0x5
    3f96:	12650513          	addi	a0,a0,294 # 90b8 <malloc+0x19d4>
    3f9a:	6af020ef          	jal	6e48 <chdir>
    3f9e:	87aa                	mv	a5,a0
    3fa0:	ef81                	bnez	a5,3fb8 <dirfile+0x72>
    printf("%s: chdir dirfile succeeded!\n", s);
    3fa2:	fd843583          	ld	a1,-40(s0)
    3fa6:	00005517          	auipc	a0,0x5
    3faa:	13a50513          	addi	a0,a0,314 # 90e0 <malloc+0x19fc>
    3fae:	54e030ef          	jal	74fc <printf>
    exit(1);
    3fb2:	4505                	li	a0,1
    3fb4:	625020ef          	jal	6dd8 <exit>
  }
  fd = open("dirfile/xx", 0);
    3fb8:	4581                	li	a1,0
    3fba:	00005517          	auipc	a0,0x5
    3fbe:	14650513          	addi	a0,a0,326 # 9100 <malloc+0x1a1c>
    3fc2:	657020ef          	jal	6e18 <open>
    3fc6:	87aa                	mv	a5,a0
    3fc8:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    3fcc:	fec42783          	lw	a5,-20(s0)
    3fd0:	2781                	sext.w	a5,a5
    3fd2:	0007cd63          	bltz	a5,3fec <dirfile+0xa6>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3fd6:	fd843583          	ld	a1,-40(s0)
    3fda:	00005517          	auipc	a0,0x5
    3fde:	13650513          	addi	a0,a0,310 # 9110 <malloc+0x1a2c>
    3fe2:	51a030ef          	jal	74fc <printf>
    exit(1);
    3fe6:	4505                	li	a0,1
    3fe8:	5f1020ef          	jal	6dd8 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    3fec:	20000593          	li	a1,512
    3ff0:	00005517          	auipc	a0,0x5
    3ff4:	11050513          	addi	a0,a0,272 # 9100 <malloc+0x1a1c>
    3ff8:	621020ef          	jal	6e18 <open>
    3ffc:	87aa                	mv	a5,a0
    3ffe:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4002:	fec42783          	lw	a5,-20(s0)
    4006:	2781                	sext.w	a5,a5
    4008:	0007cd63          	bltz	a5,4022 <dirfile+0xdc>
    printf("%s: create dirfile/xx succeeded!\n", s);
    400c:	fd843583          	ld	a1,-40(s0)
    4010:	00005517          	auipc	a0,0x5
    4014:	10050513          	addi	a0,a0,256 # 9110 <malloc+0x1a2c>
    4018:	4e4030ef          	jal	74fc <printf>
    exit(1);
    401c:	4505                	li	a0,1
    401e:	5bb020ef          	jal	6dd8 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4022:	00005517          	auipc	a0,0x5
    4026:	0de50513          	addi	a0,a0,222 # 9100 <malloc+0x1a1c>
    402a:	617020ef          	jal	6e40 <mkdir>
    402e:	87aa                	mv	a5,a0
    4030:	ef81                	bnez	a5,4048 <dirfile+0x102>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4032:	fd843583          	ld	a1,-40(s0)
    4036:	00005517          	auipc	a0,0x5
    403a:	10250513          	addi	a0,a0,258 # 9138 <malloc+0x1a54>
    403e:	4be030ef          	jal	74fc <printf>
    exit(1);
    4042:	4505                	li	a0,1
    4044:	595020ef          	jal	6dd8 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    4048:	00005517          	auipc	a0,0x5
    404c:	0b850513          	addi	a0,a0,184 # 9100 <malloc+0x1a1c>
    4050:	5d9020ef          	jal	6e28 <unlink>
    4054:	87aa                	mv	a5,a0
    4056:	ef81                	bnez	a5,406e <dirfile+0x128>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4058:	fd843583          	ld	a1,-40(s0)
    405c:	00005517          	auipc	a0,0x5
    4060:	10450513          	addi	a0,a0,260 # 9160 <malloc+0x1a7c>
    4064:	498030ef          	jal	74fc <printf>
    exit(1);
    4068:	4505                	li	a0,1
    406a:	56f020ef          	jal	6dd8 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    406e:	00005597          	auipc	a1,0x5
    4072:	09258593          	addi	a1,a1,146 # 9100 <malloc+0x1a1c>
    4076:	00004517          	auipc	a0,0x4
    407a:	89250513          	addi	a0,a0,-1902 # 7908 <malloc+0x224>
    407e:	5bb020ef          	jal	6e38 <link>
    4082:	87aa                	mv	a5,a0
    4084:	ef81                	bnez	a5,409c <dirfile+0x156>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    4086:	fd843583          	ld	a1,-40(s0)
    408a:	00005517          	auipc	a0,0x5
    408e:	0fe50513          	addi	a0,a0,254 # 9188 <malloc+0x1aa4>
    4092:	46a030ef          	jal	74fc <printf>
    exit(1);
    4096:	4505                	li	a0,1
    4098:	541020ef          	jal	6dd8 <exit>
  }
  if(unlink("dirfile") != 0){
    409c:	00005517          	auipc	a0,0x5
    40a0:	01c50513          	addi	a0,a0,28 # 90b8 <malloc+0x19d4>
    40a4:	585020ef          	jal	6e28 <unlink>
    40a8:	87aa                	mv	a5,a0
    40aa:	cf81                	beqz	a5,40c2 <dirfile+0x17c>
    printf("%s: unlink dirfile failed!\n", s);
    40ac:	fd843583          	ld	a1,-40(s0)
    40b0:	00005517          	auipc	a0,0x5
    40b4:	10050513          	addi	a0,a0,256 # 91b0 <malloc+0x1acc>
    40b8:	444030ef          	jal	74fc <printf>
    exit(1);
    40bc:	4505                	li	a0,1
    40be:	51b020ef          	jal	6dd8 <exit>
  }

  fd = open(".", O_RDWR);
    40c2:	4589                	li	a1,2
    40c4:	00004517          	auipc	a0,0x4
    40c8:	56c50513          	addi	a0,a0,1388 # 8630 <malloc+0xf4c>
    40cc:	54d020ef          	jal	6e18 <open>
    40d0:	87aa                	mv	a5,a0
    40d2:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    40d6:	fec42783          	lw	a5,-20(s0)
    40da:	2781                	sext.w	a5,a5
    40dc:	0007cd63          	bltz	a5,40f6 <dirfile+0x1b0>
    printf("%s: open . for writing succeeded!\n", s);
    40e0:	fd843583          	ld	a1,-40(s0)
    40e4:	00005517          	auipc	a0,0x5
    40e8:	0ec50513          	addi	a0,a0,236 # 91d0 <malloc+0x1aec>
    40ec:	410030ef          	jal	74fc <printf>
    exit(1);
    40f0:	4505                	li	a0,1
    40f2:	4e7020ef          	jal	6dd8 <exit>
  }
  fd = open(".", 0);
    40f6:	4581                	li	a1,0
    40f8:	00004517          	auipc	a0,0x4
    40fc:	53850513          	addi	a0,a0,1336 # 8630 <malloc+0xf4c>
    4100:	519020ef          	jal	6e18 <open>
    4104:	87aa                	mv	a5,a0
    4106:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    410a:	fec42783          	lw	a5,-20(s0)
    410e:	4605                	li	a2,1
    4110:	00004597          	auipc	a1,0x4
    4114:	84858593          	addi	a1,a1,-1976 # 7958 <malloc+0x274>
    4118:	853e                	mv	a0,a5
    411a:	4df020ef          	jal	6df8 <write>
    411e:	87aa                	mv	a5,a0
    4120:	00f05d63          	blez	a5,413a <dirfile+0x1f4>
    printf("%s: write . succeeded!\n", s);
    4124:	fd843583          	ld	a1,-40(s0)
    4128:	00005517          	auipc	a0,0x5
    412c:	0d050513          	addi	a0,a0,208 # 91f8 <malloc+0x1b14>
    4130:	3cc030ef          	jal	74fc <printf>
    exit(1);
    4134:	4505                	li	a0,1
    4136:	4a3020ef          	jal	6dd8 <exit>
  }
  close(fd);
    413a:	fec42783          	lw	a5,-20(s0)
    413e:	853e                	mv	a0,a5
    4140:	4c1020ef          	jal	6e00 <close>
}
    4144:	0001                	nop
    4146:	70a2                	ld	ra,40(sp)
    4148:	7402                	ld	s0,32(sp)
    414a:	6145                	addi	sp,sp,48
    414c:	8082                	ret

000000000000414e <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    414e:	7179                	addi	sp,sp,-48
    4150:	f406                	sd	ra,40(sp)
    4152:	f022                	sd	s0,32(sp)
    4154:	1800                	addi	s0,sp,48
    4156:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    415a:	fe042623          	sw	zero,-20(s0)
    415e:	a8e1                	j	4236 <iref+0xe8>
    if(mkdir("irefd") != 0){
    4160:	00005517          	auipc	a0,0x5
    4164:	0b050513          	addi	a0,a0,176 # 9210 <malloc+0x1b2c>
    4168:	4d9020ef          	jal	6e40 <mkdir>
    416c:	87aa                	mv	a5,a0
    416e:	cf81                	beqz	a5,4186 <iref+0x38>
      printf("%s: mkdir irefd failed\n", s);
    4170:	fd843583          	ld	a1,-40(s0)
    4174:	00005517          	auipc	a0,0x5
    4178:	0a450513          	addi	a0,a0,164 # 9218 <malloc+0x1b34>
    417c:	380030ef          	jal	74fc <printf>
      exit(1);
    4180:	4505                	li	a0,1
    4182:	457020ef          	jal	6dd8 <exit>
    }
    if(chdir("irefd") != 0){
    4186:	00005517          	auipc	a0,0x5
    418a:	08a50513          	addi	a0,a0,138 # 9210 <malloc+0x1b2c>
    418e:	4bb020ef          	jal	6e48 <chdir>
    4192:	87aa                	mv	a5,a0
    4194:	cf81                	beqz	a5,41ac <iref+0x5e>
      printf("%s: chdir irefd failed\n", s);
    4196:	fd843583          	ld	a1,-40(s0)
    419a:	00005517          	auipc	a0,0x5
    419e:	09650513          	addi	a0,a0,150 # 9230 <malloc+0x1b4c>
    41a2:	35a030ef          	jal	74fc <printf>
      exit(1);
    41a6:	4505                	li	a0,1
    41a8:	431020ef          	jal	6dd8 <exit>
    }

    mkdir("");
    41ac:	00005517          	auipc	a0,0x5
    41b0:	09c50513          	addi	a0,a0,156 # 9248 <malloc+0x1b64>
    41b4:	48d020ef          	jal	6e40 <mkdir>
    link("README", "");
    41b8:	00005597          	auipc	a1,0x5
    41bc:	09058593          	addi	a1,a1,144 # 9248 <malloc+0x1b64>
    41c0:	00003517          	auipc	a0,0x3
    41c4:	74850513          	addi	a0,a0,1864 # 7908 <malloc+0x224>
    41c8:	471020ef          	jal	6e38 <link>
    fd = open("", O_CREATE);
    41cc:	20000593          	li	a1,512
    41d0:	00005517          	auipc	a0,0x5
    41d4:	07850513          	addi	a0,a0,120 # 9248 <malloc+0x1b64>
    41d8:	441020ef          	jal	6e18 <open>
    41dc:	87aa                	mv	a5,a0
    41de:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    41e2:	fe842783          	lw	a5,-24(s0)
    41e6:	2781                	sext.w	a5,a5
    41e8:	0007c763          	bltz	a5,41f6 <iref+0xa8>
      close(fd);
    41ec:	fe842783          	lw	a5,-24(s0)
    41f0:	853e                	mv	a0,a5
    41f2:	40f020ef          	jal	6e00 <close>
    fd = open("xx", O_CREATE);
    41f6:	20000593          	li	a1,512
    41fa:	00004517          	auipc	a0,0x4
    41fe:	86650513          	addi	a0,a0,-1946 # 7a60 <malloc+0x37c>
    4202:	417020ef          	jal	6e18 <open>
    4206:	87aa                	mv	a5,a0
    4208:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    420c:	fe842783          	lw	a5,-24(s0)
    4210:	2781                	sext.w	a5,a5
    4212:	0007c763          	bltz	a5,4220 <iref+0xd2>
      close(fd);
    4216:	fe842783          	lw	a5,-24(s0)
    421a:	853e                	mv	a0,a5
    421c:	3e5020ef          	jal	6e00 <close>
    unlink("xx");
    4220:	00004517          	auipc	a0,0x4
    4224:	84050513          	addi	a0,a0,-1984 # 7a60 <malloc+0x37c>
    4228:	401020ef          	jal	6e28 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    422c:	fec42783          	lw	a5,-20(s0)
    4230:	2785                	addiw	a5,a5,1
    4232:	fef42623          	sw	a5,-20(s0)
    4236:	fec42783          	lw	a5,-20(s0)
    423a:	0007871b          	sext.w	a4,a5
    423e:	03200793          	li	a5,50
    4242:	f0e7dfe3          	bge	a5,a4,4160 <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    4246:	fe042623          	sw	zero,-20(s0)
    424a:	a015                	j	426e <iref+0x120>
    chdir("..");
    424c:	00004517          	auipc	a0,0x4
    4250:	e4c50513          	addi	a0,a0,-436 # 8098 <malloc+0x9b4>
    4254:	3f5020ef          	jal	6e48 <chdir>
    unlink("irefd");
    4258:	00005517          	auipc	a0,0x5
    425c:	fb850513          	addi	a0,a0,-72 # 9210 <malloc+0x1b2c>
    4260:	3c9020ef          	jal	6e28 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4264:	fec42783          	lw	a5,-20(s0)
    4268:	2785                	addiw	a5,a5,1
    426a:	fef42623          	sw	a5,-20(s0)
    426e:	fec42783          	lw	a5,-20(s0)
    4272:	0007871b          	sext.w	a4,a5
    4276:	03200793          	li	a5,50
    427a:	fce7d9e3          	bge	a5,a4,424c <iref+0xfe>
  }

  chdir("/");
    427e:	00004517          	auipc	a0,0x4
    4282:	b3250513          	addi	a0,a0,-1230 # 7db0 <malloc+0x6cc>
    4286:	3c3020ef          	jal	6e48 <chdir>
}
    428a:	0001                	nop
    428c:	70a2                	ld	ra,40(sp)
    428e:	7402                	ld	s0,32(sp)
    4290:	6145                	addi	sp,sp,48
    4292:	8082                	ret

0000000000004294 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    4294:	7179                	addi	sp,sp,-48
    4296:	f406                	sd	ra,40(sp)
    4298:	f022                	sd	s0,32(sp)
    429a:	1800                	addi	s0,sp,48
    429c:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    42a0:	fe042623          	sw	zero,-20(s0)
    42a4:	a03d                	j	42d2 <forktest+0x3e>
    pid = fork();
    42a6:	32b020ef          	jal	6dd0 <fork>
    42aa:	87aa                	mv	a5,a0
    42ac:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    42b0:	fe842783          	lw	a5,-24(s0)
    42b4:	2781                	sext.w	a5,a5
    42b6:	0207c763          	bltz	a5,42e4 <forktest+0x50>
      break;
    if(pid == 0)
    42ba:	fe842783          	lw	a5,-24(s0)
    42be:	2781                	sext.w	a5,a5
    42c0:	e781                	bnez	a5,42c8 <forktest+0x34>
      exit(0);
    42c2:	4501                	li	a0,0
    42c4:	315020ef          	jal	6dd8 <exit>
  for(n=0; n<N; n++){
    42c8:	fec42783          	lw	a5,-20(s0)
    42cc:	2785                	addiw	a5,a5,1
    42ce:	fef42623          	sw	a5,-20(s0)
    42d2:	fec42783          	lw	a5,-20(s0)
    42d6:	0007871b          	sext.w	a4,a5
    42da:	3e700793          	li	a5,999
    42de:	fce7d4e3          	bge	a5,a4,42a6 <forktest+0x12>
    42e2:	a011                	j	42e6 <forktest+0x52>
      break;
    42e4:	0001                	nop
  }

  if (n == 0) {
    42e6:	fec42783          	lw	a5,-20(s0)
    42ea:	2781                	sext.w	a5,a5
    42ec:	ef81                	bnez	a5,4304 <forktest+0x70>
    printf("%s: no fork at all!\n", s);
    42ee:	fd843583          	ld	a1,-40(s0)
    42f2:	00005517          	auipc	a0,0x5
    42f6:	f5e50513          	addi	a0,a0,-162 # 9250 <malloc+0x1b6c>
    42fa:	202030ef          	jal	74fc <printf>
    exit(1);
    42fe:	4505                	li	a0,1
    4300:	2d9020ef          	jal	6dd8 <exit>
  }

  if(n == N){
    4304:	fec42783          	lw	a5,-20(s0)
    4308:	0007871b          	sext.w	a4,a5
    430c:	3e800793          	li	a5,1000
    4310:	04f71363          	bne	a4,a5,4356 <forktest+0xc2>
    printf("%s: fork claimed to work 1000 times!\n", s);
    4314:	fd843583          	ld	a1,-40(s0)
    4318:	00005517          	auipc	a0,0x5
    431c:	f5050513          	addi	a0,a0,-176 # 9268 <malloc+0x1b84>
    4320:	1dc030ef          	jal	74fc <printf>
    exit(1);
    4324:	4505                	li	a0,1
    4326:	2b3020ef          	jal	6dd8 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    432a:	4501                	li	a0,0
    432c:	2b5020ef          	jal	6de0 <wait>
    4330:	87aa                	mv	a5,a0
    4332:	0007dd63          	bgez	a5,434c <forktest+0xb8>
      printf("%s: wait stopped early\n", s);
    4336:	fd843583          	ld	a1,-40(s0)
    433a:	00005517          	auipc	a0,0x5
    433e:	f5650513          	addi	a0,a0,-170 # 9290 <malloc+0x1bac>
    4342:	1ba030ef          	jal	74fc <printf>
      exit(1);
    4346:	4505                	li	a0,1
    4348:	291020ef          	jal	6dd8 <exit>
  for(; n > 0; n--){
    434c:	fec42783          	lw	a5,-20(s0)
    4350:	37fd                	addiw	a5,a5,-1
    4352:	fef42623          	sw	a5,-20(s0)
    4356:	fec42783          	lw	a5,-20(s0)
    435a:	2781                	sext.w	a5,a5
    435c:	fcf047e3          	bgtz	a5,432a <forktest+0x96>
    }
  }

  if(wait(0) != -1){
    4360:	4501                	li	a0,0
    4362:	27f020ef          	jal	6de0 <wait>
    4366:	87aa                	mv	a5,a0
    4368:	873e                	mv	a4,a5
    436a:	57fd                	li	a5,-1
    436c:	00f70d63          	beq	a4,a5,4386 <forktest+0xf2>
    printf("%s: wait got too many\n", s);
    4370:	fd843583          	ld	a1,-40(s0)
    4374:	00005517          	auipc	a0,0x5
    4378:	f3450513          	addi	a0,a0,-204 # 92a8 <malloc+0x1bc4>
    437c:	180030ef          	jal	74fc <printf>
    exit(1);
    4380:	4505                	li	a0,1
    4382:	257020ef          	jal	6dd8 <exit>
  }
}
    4386:	0001                	nop
    4388:	70a2                	ld	ra,40(sp)
    438a:	7402                	ld	s0,32(sp)
    438c:	6145                	addi	sp,sp,48
    438e:	8082                	ret

0000000000004390 <sbrkbasic>:

void
sbrkbasic(char *s)
{
    4390:	715d                	addi	sp,sp,-80
    4392:	e486                	sd	ra,72(sp)
    4394:	e0a2                	sd	s0,64(sp)
    4396:	0880                	addi	s0,sp,80
    4398:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    439c:	235020ef          	jal	6dd0 <fork>
    43a0:	87aa                	mv	a5,a0
    43a2:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    43a6:	fd442783          	lw	a5,-44(s0)
    43aa:	2781                	sext.w	a5,a5
    43ac:	0007db63          	bgez	a5,43c2 <sbrkbasic+0x32>
    printf("fork failed in sbrkbasic\n");
    43b0:	00005517          	auipc	a0,0x5
    43b4:	f1050513          	addi	a0,a0,-240 # 92c0 <malloc+0x1bdc>
    43b8:	144030ef          	jal	74fc <printf>
    exit(1);
    43bc:	4505                	li	a0,1
    43be:	21b020ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    43c2:	fd442783          	lw	a5,-44(s0)
    43c6:	2781                	sext.w	a5,a5
    43c8:	efa1                	bnez	a5,4420 <sbrkbasic+0x90>
    a = sbrk(TOOMUCH);
    43ca:	40000537          	lui	a0,0x40000
    43ce:	1b7020ef          	jal	6d84 <sbrk>
    43d2:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)SBRK_ERROR){
    43d6:	fe043703          	ld	a4,-32(s0)
    43da:	57fd                	li	a5,-1
    43dc:	00f71563          	bne	a4,a5,43e6 <sbrkbasic+0x56>
      // it's OK if this fails.
      exit(0);
    43e0:	4501                	li	a0,0
    43e2:	1f7020ef          	jal	6dd8 <exit>
    }
    
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    43e6:	fe043783          	ld	a5,-32(s0)
    43ea:	fcf43c23          	sd	a5,-40(s0)
    43ee:	a829                	j	4408 <sbrkbasic+0x78>
      *b = 99;
    43f0:	fd843783          	ld	a5,-40(s0)
    43f4:	06300713          	li	a4,99
    43f8:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    43fc:	fd843703          	ld	a4,-40(s0)
    4400:	6785                	lui	a5,0x1
    4402:	97ba                	add	a5,a5,a4
    4404:	fcf43c23          	sd	a5,-40(s0)
    4408:	fe043703          	ld	a4,-32(s0)
    440c:	400007b7          	lui	a5,0x40000
    4410:	97ba                	add	a5,a5,a4
    4412:	fd843703          	ld	a4,-40(s0)
    4416:	fcf76de3          	bltu	a4,a5,43f0 <sbrkbasic+0x60>
    }
    
    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    441a:	4505                	li	a0,1
    441c:	1bd020ef          	jal	6dd8 <exit>
  }

  wait(&xstatus);
    4420:	fc440793          	addi	a5,s0,-60
    4424:	853e                	mv	a0,a5
    4426:	1bb020ef          	jal	6de0 <wait>
  if(xstatus == 1){
    442a:	fc442703          	lw	a4,-60(s0)
    442e:	4785                	li	a5,1
    4430:	00f71d63          	bne	a4,a5,444a <sbrkbasic+0xba>
    printf("%s: too much memory allocated!\n", s);
    4434:	fb843583          	ld	a1,-72(s0)
    4438:	00005517          	auipc	a0,0x5
    443c:	ea850513          	addi	a0,a0,-344 # 92e0 <malloc+0x1bfc>
    4440:	0bc030ef          	jal	74fc <printf>
    exit(1);
    4444:	4505                	li	a0,1
    4446:	193020ef          	jal	6dd8 <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    444a:	4501                	li	a0,0
    444c:	139020ef          	jal	6d84 <sbrk>
    4450:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    4454:	fe042623          	sw	zero,-20(s0)
    4458:	a8a9                	j	44b2 <sbrkbasic+0x122>
    b = sbrk(1);
    445a:	4505                	li	a0,1
    445c:	129020ef          	jal	6d84 <sbrk>
    4460:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    4464:	fd843703          	ld	a4,-40(s0)
    4468:	fe043783          	ld	a5,-32(s0)
    446c:	02f70463          	beq	a4,a5,4494 <sbrkbasic+0x104>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    4470:	fec42783          	lw	a5,-20(s0)
    4474:	fd843703          	ld	a4,-40(s0)
    4478:	fe043683          	ld	a3,-32(s0)
    447c:	863e                	mv	a2,a5
    447e:	fb843583          	ld	a1,-72(s0)
    4482:	00005517          	auipc	a0,0x5
    4486:	e7e50513          	addi	a0,a0,-386 # 9300 <malloc+0x1c1c>
    448a:	072030ef          	jal	74fc <printf>
      exit(1);
    448e:	4505                	li	a0,1
    4490:	149020ef          	jal	6dd8 <exit>
    }
    *b = 1;
    4494:	fd843783          	ld	a5,-40(s0)
    4498:	4705                	li	a4,1
    449a:	00e78023          	sb	a4,0(a5) # 40000000 <freep+0x3ffef328>
    a = b + 1;
    449e:	fd843783          	ld	a5,-40(s0)
    44a2:	0785                	addi	a5,a5,1
    44a4:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    44a8:	fec42783          	lw	a5,-20(s0)
    44ac:	2785                	addiw	a5,a5,1
    44ae:	fef42623          	sw	a5,-20(s0)
    44b2:	fec42783          	lw	a5,-20(s0)
    44b6:	0007871b          	sext.w	a4,a5
    44ba:	6785                	lui	a5,0x1
    44bc:	38778793          	addi	a5,a5,903 # 1387 <writebig+0xa1>
    44c0:	f8e7dde3          	bge	a5,a4,445a <sbrkbasic+0xca>
  }
  pid = fork();
    44c4:	10d020ef          	jal	6dd0 <fork>
    44c8:	87aa                	mv	a5,a0
    44ca:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    44ce:	fd442783          	lw	a5,-44(s0)
    44d2:	2781                	sext.w	a5,a5
    44d4:	0007dd63          	bgez	a5,44ee <sbrkbasic+0x15e>
    printf("%s: sbrk test fork failed\n", s);
    44d8:	fb843583          	ld	a1,-72(s0)
    44dc:	00005517          	auipc	a0,0x5
    44e0:	e4450513          	addi	a0,a0,-444 # 9320 <malloc+0x1c3c>
    44e4:	018030ef          	jal	74fc <printf>
    exit(1);
    44e8:	4505                	li	a0,1
    44ea:	0ef020ef          	jal	6dd8 <exit>
  }
  c = sbrk(1);
    44ee:	4505                	li	a0,1
    44f0:	095020ef          	jal	6d84 <sbrk>
    44f4:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    44f8:	4505                	li	a0,1
    44fa:	08b020ef          	jal	6d84 <sbrk>
    44fe:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    4502:	fe043783          	ld	a5,-32(s0)
    4506:	0785                	addi	a5,a5,1
    4508:	fc843703          	ld	a4,-56(s0)
    450c:	00f70d63          	beq	a4,a5,4526 <sbrkbasic+0x196>
    printf("%s: sbrk test failed post-fork\n", s);
    4510:	fb843583          	ld	a1,-72(s0)
    4514:	00005517          	auipc	a0,0x5
    4518:	e2c50513          	addi	a0,a0,-468 # 9340 <malloc+0x1c5c>
    451c:	7e1020ef          	jal	74fc <printf>
    exit(1);
    4520:	4505                	li	a0,1
    4522:	0b7020ef          	jal	6dd8 <exit>
  }
  if(pid == 0)
    4526:	fd442783          	lw	a5,-44(s0)
    452a:	2781                	sext.w	a5,a5
    452c:	e781                	bnez	a5,4534 <sbrkbasic+0x1a4>
    exit(0);
    452e:	4501                	li	a0,0
    4530:	0a9020ef          	jal	6dd8 <exit>
  wait(&xstatus);
    4534:	fc440793          	addi	a5,s0,-60
    4538:	853e                	mv	a0,a5
    453a:	0a7020ef          	jal	6de0 <wait>
  exit(xstatus);
    453e:	fc442783          	lw	a5,-60(s0)
    4542:	853e                	mv	a0,a5
    4544:	095020ef          	jal	6dd8 <exit>

0000000000004548 <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    4548:	715d                	addi	sp,sp,-80
    454a:	e486                	sd	ra,72(sp)
    454c:	e0a2                	sd	s0,64(sp)
    454e:	0880                	addi	s0,sp,80
    4550:	faa43c23          	sd	a0,-72(s0)
  enum { BIG=100*1024*1024 };
  char *c, *oldbrk, *a, *lastaddr, *p;
  uint64 amt;

  oldbrk = sbrk(0);
    4554:	4501                	li	a0,0
    4556:	02f020ef          	jal	6d84 <sbrk>
    455a:	fea43423          	sd	a0,-24(s0)

  // can one grow address space to something big?
  a = sbrk(0);
    455e:	4501                	li	a0,0
    4560:	025020ef          	jal	6d84 <sbrk>
    4564:	fea43023          	sd	a0,-32(s0)
  amt = BIG - (uint64)a;
    4568:	fe043783          	ld	a5,-32(s0)
    456c:	06400737          	lui	a4,0x6400
    4570:	40f707b3          	sub	a5,a4,a5
    4574:	fcf43c23          	sd	a5,-40(s0)
  p = sbrk(amt);
    4578:	fd843783          	ld	a5,-40(s0)
    457c:	2781                	sext.w	a5,a5
    457e:	853e                	mv	a0,a5
    4580:	005020ef          	jal	6d84 <sbrk>
    4584:	fca43823          	sd	a0,-48(s0)
  if (p != a) {
    4588:	fd043703          	ld	a4,-48(s0)
    458c:	fe043783          	ld	a5,-32(s0)
    4590:	00f70d63          	beq	a4,a5,45aa <sbrkmuch+0x62>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    4594:	fb843583          	ld	a1,-72(s0)
    4598:	00005517          	auipc	a0,0x5
    459c:	dc850513          	addi	a0,a0,-568 # 9360 <malloc+0x1c7c>
    45a0:	75d020ef          	jal	74fc <printf>
    exit(1);
    45a4:	4505                	li	a0,1
    45a6:	033020ef          	jal	6dd8 <exit>
  }

  lastaddr = (char*) (BIG-1);
    45aa:	064007b7          	lui	a5,0x6400
    45ae:	17fd                	addi	a5,a5,-1 # 63fffff <freep+0x63ef327>
    45b0:	fcf43423          	sd	a5,-56(s0)
  *lastaddr = 99;
    45b4:	fc843783          	ld	a5,-56(s0)
    45b8:	06300713          	li	a4,99
    45bc:	00e78023          	sb	a4,0(a5)

  // can one de-allocate?
  a = sbrk(0);
    45c0:	4501                	li	a0,0
    45c2:	7c2020ef          	jal	6d84 <sbrk>
    45c6:	fea43023          	sd	a0,-32(s0)
  c = sbrk(-PGSIZE);
    45ca:	757d                	lui	a0,0xfffff
    45cc:	7b8020ef          	jal	6d84 <sbrk>
    45d0:	fca43023          	sd	a0,-64(s0)
  if(c == (char*)SBRK_ERROR){
    45d4:	fc043703          	ld	a4,-64(s0)
    45d8:	57fd                	li	a5,-1
    45da:	00f71d63          	bne	a4,a5,45f4 <sbrkmuch+0xac>
    printf("%s: sbrk could not deallocate\n", s);
    45de:	fb843583          	ld	a1,-72(s0)
    45e2:	00005517          	auipc	a0,0x5
    45e6:	dc650513          	addi	a0,a0,-570 # 93a8 <malloc+0x1cc4>
    45ea:	713020ef          	jal	74fc <printf>
    exit(1);
    45ee:	4505                	li	a0,1
    45f0:	7e8020ef          	jal	6dd8 <exit>
  }
  c = sbrk(0);
    45f4:	4501                	li	a0,0
    45f6:	78e020ef          	jal	6d84 <sbrk>
    45fa:	fca43023          	sd	a0,-64(s0)
  if(c != a - PGSIZE){
    45fe:	fe043703          	ld	a4,-32(s0)
    4602:	77fd                	lui	a5,0xfffff
    4604:	97ba                	add	a5,a5,a4
    4606:	fc043703          	ld	a4,-64(s0)
    460a:	02f70163          	beq	a4,a5,462c <sbrkmuch+0xe4>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    460e:	fc043683          	ld	a3,-64(s0)
    4612:	fe043603          	ld	a2,-32(s0)
    4616:	fb843583          	ld	a1,-72(s0)
    461a:	00005517          	auipc	a0,0x5
    461e:	dae50513          	addi	a0,a0,-594 # 93c8 <malloc+0x1ce4>
    4622:	6db020ef          	jal	74fc <printf>
    exit(1);
    4626:	4505                	li	a0,1
    4628:	7b0020ef          	jal	6dd8 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    462c:	4501                	li	a0,0
    462e:	756020ef          	jal	6d84 <sbrk>
    4632:	fea43023          	sd	a0,-32(s0)
  c = sbrk(PGSIZE);
    4636:	6505                	lui	a0,0x1
    4638:	74c020ef          	jal	6d84 <sbrk>
    463c:	fca43023          	sd	a0,-64(s0)
  if(c != a || sbrk(0) != a + PGSIZE){
    4640:	fc043703          	ld	a4,-64(s0)
    4644:	fe043783          	ld	a5,-32(s0)
    4648:	00f71c63          	bne	a4,a5,4660 <sbrkmuch+0x118>
    464c:	4501                	li	a0,0
    464e:	736020ef          	jal	6d84 <sbrk>
    4652:	86aa                	mv	a3,a0
    4654:	fe043703          	ld	a4,-32(s0)
    4658:	6785                	lui	a5,0x1
    465a:	97ba                	add	a5,a5,a4
    465c:	02f68163          	beq	a3,a5,467e <sbrkmuch+0x136>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    4660:	fc043683          	ld	a3,-64(s0)
    4664:	fe043603          	ld	a2,-32(s0)
    4668:	fb843583          	ld	a1,-72(s0)
    466c:	00005517          	auipc	a0,0x5
    4670:	d9c50513          	addi	a0,a0,-612 # 9408 <malloc+0x1d24>
    4674:	689020ef          	jal	74fc <printf>
    exit(1);
    4678:	4505                	li	a0,1
    467a:	75e020ef          	jal	6dd8 <exit>
  }
  if(*lastaddr == 99){
    467e:	fc843783          	ld	a5,-56(s0)
    4682:	0007c783          	lbu	a5,0(a5) # 1000 <openiputtest+0x14>
    4686:	873e                	mv	a4,a5
    4688:	06300793          	li	a5,99
    468c:	00f71d63          	bne	a4,a5,46a6 <sbrkmuch+0x15e>
    // should be zero
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    4690:	fb843583          	ld	a1,-72(s0)
    4694:	00005517          	auipc	a0,0x5
    4698:	da450513          	addi	a0,a0,-604 # 9438 <malloc+0x1d54>
    469c:	661020ef          	jal	74fc <printf>
    exit(1);
    46a0:	4505                	li	a0,1
    46a2:	736020ef          	jal	6dd8 <exit>
  }

  a = sbrk(0);
    46a6:	4501                	li	a0,0
    46a8:	6dc020ef          	jal	6d84 <sbrk>
    46ac:	fea43023          	sd	a0,-32(s0)
  c = sbrk(-(sbrk(0) - oldbrk));
    46b0:	4501                	li	a0,0
    46b2:	6d2020ef          	jal	6d84 <sbrk>
    46b6:	872a                	mv	a4,a0
    46b8:	fe843783          	ld	a5,-24(s0)
    46bc:	8f99                	sub	a5,a5,a4
    46be:	2781                	sext.w	a5,a5
    46c0:	853e                	mv	a0,a5
    46c2:	6c2020ef          	jal	6d84 <sbrk>
    46c6:	fca43023          	sd	a0,-64(s0)
  if(c != a){
    46ca:	fc043703          	ld	a4,-64(s0)
    46ce:	fe043783          	ld	a5,-32(s0)
    46d2:	02f70163          	beq	a4,a5,46f4 <sbrkmuch+0x1ac>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    46d6:	fc043683          	ld	a3,-64(s0)
    46da:	fe043603          	ld	a2,-32(s0)
    46de:	fb843583          	ld	a1,-72(s0)
    46e2:	00005517          	auipc	a0,0x5
    46e6:	d8e50513          	addi	a0,a0,-626 # 9470 <malloc+0x1d8c>
    46ea:	613020ef          	jal	74fc <printf>
    exit(1);
    46ee:	4505                	li	a0,1
    46f0:	6e8020ef          	jal	6dd8 <exit>
  }
}
    46f4:	0001                	nop
    46f6:	60a6                	ld	ra,72(sp)
    46f8:	6406                	ld	s0,64(sp)
    46fa:	6161                	addi	sp,sp,80
    46fc:	8082                	ret

00000000000046fe <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    46fe:	7179                	addi	sp,sp,-48
    4700:	f406                	sd	ra,40(sp)
    4702:	f022                	sd	s0,32(sp)
    4704:	1800                	addi	s0,sp,48
    4706:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    470a:	4785                	li	a5,1
    470c:	07fe                	slli	a5,a5,0x1f
    470e:	fef43423          	sd	a5,-24(s0)
    4712:	a051                	j	4796 <kernmem+0x98>
    pid = fork();
    4714:	6bc020ef          	jal	6dd0 <fork>
    4718:	87aa                	mv	a5,a0
    471a:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    471e:	fe442783          	lw	a5,-28(s0)
    4722:	2781                	sext.w	a5,a5
    4724:	0007dd63          	bgez	a5,473e <kernmem+0x40>
      printf("%s: fork failed\n", s);
    4728:	fd843583          	ld	a1,-40(s0)
    472c:	00003517          	auipc	a0,0x3
    4730:	58c50513          	addi	a0,a0,1420 # 7cb8 <malloc+0x5d4>
    4734:	5c9020ef          	jal	74fc <printf>
      exit(1);
    4738:	4505                	li	a0,1
    473a:	69e020ef          	jal	6dd8 <exit>
    }
    if(pid == 0){
    473e:	fe442783          	lw	a5,-28(s0)
    4742:	2781                	sext.w	a5,a5
    4744:	e785                	bnez	a5,476c <kernmem+0x6e>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    4746:	fe843783          	ld	a5,-24(s0)
    474a:	0007c783          	lbu	a5,0(a5)
    474e:	2781                	sext.w	a5,a5
    4750:	86be                	mv	a3,a5
    4752:	fe843603          	ld	a2,-24(s0)
    4756:	fd843583          	ld	a1,-40(s0)
    475a:	00005517          	auipc	a0,0x5
    475e:	d3e50513          	addi	a0,a0,-706 # 9498 <malloc+0x1db4>
    4762:	59b020ef          	jal	74fc <printf>
      exit(1);
    4766:	4505                	li	a0,1
    4768:	670020ef          	jal	6dd8 <exit>
    }
    int xstatus;
    wait(&xstatus);
    476c:	fe040793          	addi	a5,s0,-32
    4770:	853e                	mv	a0,a5
    4772:	66e020ef          	jal	6de0 <wait>
    if(xstatus != -1)  // did kernel kill child?
    4776:	fe042703          	lw	a4,-32(s0)
    477a:	57fd                	li	a5,-1
    477c:	00f70563          	beq	a4,a5,4786 <kernmem+0x88>
      exit(1);
    4780:	4505                	li	a0,1
    4782:	656020ef          	jal	6dd8 <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    4786:	fe843703          	ld	a4,-24(s0)
    478a:	67b1                	lui	a5,0xc
    478c:	35078793          	addi	a5,a5,848 # c350 <buf+0x1ea0>
    4790:	97ba                	add	a5,a5,a4
    4792:	fef43423          	sd	a5,-24(s0)
    4796:	fe843703          	ld	a4,-24(s0)
    479a:	1003d7b7          	lui	a5,0x1003d
    479e:	078e                	slli	a5,a5,0x3
    47a0:	47f78793          	addi	a5,a5,1151 # 1003d47f <freep+0x1002c7a7>
    47a4:	f6e7f8e3          	bgeu	a5,a4,4714 <kernmem+0x16>
  }
}
    47a8:	0001                	nop
    47aa:	0001                	nop
    47ac:	70a2                	ld	ra,40(sp)
    47ae:	7402                	ld	s0,32(sp)
    47b0:	6145                	addi	sp,sp,48
    47b2:	8082                	ret

00000000000047b4 <MAXVAplus>:

// user code should not be able to write to addresses above MAXVA.
void
MAXVAplus(char *s)
{
    47b4:	7139                	addi	sp,sp,-64
    47b6:	fc06                	sd	ra,56(sp)
    47b8:	f822                	sd	s0,48(sp)
    47ba:	0080                	addi	s0,sp,64
    47bc:	fca43423          	sd	a0,-56(s0)
  volatile uint64 a = MAXVA;
    47c0:	4785                	li	a5,1
    47c2:	179a                	slli	a5,a5,0x26
    47c4:	fef43023          	sd	a5,-32(s0)
  for( ; a != 0; a <<= 1){
    47c8:	a049                	j	484a <MAXVAplus+0x96>
    int pid;
    pid = fork();
    47ca:	606020ef          	jal	6dd0 <fork>
    47ce:	87aa                	mv	a5,a0
    47d0:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
    47d4:	fec42783          	lw	a5,-20(s0)
    47d8:	2781                	sext.w	a5,a5
    47da:	0007dd63          	bgez	a5,47f4 <MAXVAplus+0x40>
      printf("%s: fork failed\n", s);
    47de:	fc843583          	ld	a1,-56(s0)
    47e2:	00003517          	auipc	a0,0x3
    47e6:	4d650513          	addi	a0,a0,1238 # 7cb8 <malloc+0x5d4>
    47ea:	513020ef          	jal	74fc <printf>
      exit(1);
    47ee:	4505                	li	a0,1
    47f0:	5e8020ef          	jal	6dd8 <exit>
    }
    if(pid == 0){
    47f4:	fec42783          	lw	a5,-20(s0)
    47f8:	2781                	sext.w	a5,a5
    47fa:	e795                	bnez	a5,4826 <MAXVAplus+0x72>
      *(char*)a = 99;
    47fc:	fe043783          	ld	a5,-32(s0)
    4800:	873e                	mv	a4,a5
    4802:	06300793          	li	a5,99
    4806:	00f70023          	sb	a5,0(a4) # 6400000 <freep+0x63ef328>
      printf("%s: oops wrote %p\n", s, (void*)a);
    480a:	fe043783          	ld	a5,-32(s0)
    480e:	863e                	mv	a2,a5
    4810:	fc843583          	ld	a1,-56(s0)
    4814:	00005517          	auipc	a0,0x5
    4818:	ca450513          	addi	a0,a0,-860 # 94b8 <malloc+0x1dd4>
    481c:	4e1020ef          	jal	74fc <printf>
      exit(1);
    4820:	4505                	li	a0,1
    4822:	5b6020ef          	jal	6dd8 <exit>
    }
    int xstatus;
    wait(&xstatus);
    4826:	fdc40793          	addi	a5,s0,-36
    482a:	853e                	mv	a0,a5
    482c:	5b4020ef          	jal	6de0 <wait>
    if(xstatus != -1)  // did kernel kill child?
    4830:	fdc42703          	lw	a4,-36(s0)
    4834:	57fd                	li	a5,-1
    4836:	00f70563          	beq	a4,a5,4840 <MAXVAplus+0x8c>
      exit(1);
    483a:	4505                	li	a0,1
    483c:	59c020ef          	jal	6dd8 <exit>
  for( ; a != 0; a <<= 1){
    4840:	fe043783          	ld	a5,-32(s0)
    4844:	0786                	slli	a5,a5,0x1
    4846:	fef43023          	sd	a5,-32(s0)
    484a:	fe043783          	ld	a5,-32(s0)
    484e:	ffb5                	bnez	a5,47ca <MAXVAplus+0x16>
  }
}
    4850:	0001                	nop
    4852:	0001                	nop
    4854:	70e2                	ld	ra,56(sp)
    4856:	7442                	ld	s0,48(sp)
    4858:	6121                	addi	sp,sp,64
    485a:	8082                	ret

000000000000485c <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    485c:	7119                	addi	sp,sp,-128
    485e:	fc86                	sd	ra,120(sp)
    4860:	f8a2                	sd	s0,112(sp)
    4862:	0100                	addi	s0,sp,128
    4864:	f8a43423          	sd	a0,-120(s0)
  char *c, *a;
  int pids[10];
  int pid;
  int failed;

  failed = 0;
    4868:	fe042423          	sw	zero,-24(s0)
  if(pipe(fds) != 0){
    486c:	fc040793          	addi	a5,s0,-64
    4870:	853e                	mv	a0,a5
    4872:	576020ef          	jal	6de8 <pipe>
    4876:	87aa                	mv	a5,a0
    4878:	cf81                	beqz	a5,4890 <sbrkfail+0x34>
    printf("%s: pipe() failed\n", s);
    487a:	f8843583          	ld	a1,-120(s0)
    487e:	00004517          	auipc	a0,0x4
    4882:	8d250513          	addi	a0,a0,-1838 # 8150 <malloc+0xa6c>
    4886:	477020ef          	jal	74fc <printf>
    exit(1);
    488a:	4505                	li	a0,1
    488c:	54c020ef          	jal	6dd8 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4890:	fe042623          	sw	zero,-20(s0)
    4894:	a0c9                	j	4956 <sbrkfail+0xfa>
    if((pids[i] = fork()) == 0){
    4896:	53a020ef          	jal	6dd0 <fork>
    489a:	87aa                	mv	a5,a0
    489c:	86be                	mv	a3,a5
    489e:	fec42703          	lw	a4,-20(s0)
    48a2:	f9040793          	addi	a5,s0,-112
    48a6:	070a                	slli	a4,a4,0x2
    48a8:	97ba                	add	a5,a5,a4
    48aa:	c394                	sw	a3,0(a5)
    48ac:	fec42703          	lw	a4,-20(s0)
    48b0:	f9040793          	addi	a5,s0,-112
    48b4:	070a                	slli	a4,a4,0x2
    48b6:	97ba                	add	a5,a5,a4
    48b8:	439c                	lw	a5,0(a5)
    48ba:	efa1                	bnez	a5,4912 <sbrkfail+0xb6>
      // allocate a lot of memory
      if (sbrk(BIG - (uint64)sbrk(0)) ==  (char*)SBRK_ERROR)
    48bc:	4501                	li	a0,0
    48be:	4c6020ef          	jal	6d84 <sbrk>
    48c2:	87aa                	mv	a5,a0
    48c4:	2781                	sext.w	a5,a5
    48c6:	06400737          	lui	a4,0x6400
    48ca:	40f707bb          	subw	a5,a4,a5
    48ce:	2781                	sext.w	a5,a5
    48d0:	853e                	mv	a0,a5
    48d2:	4b2020ef          	jal	6d84 <sbrk>
    48d6:	872a                	mv	a4,a0
    48d8:	57fd                	li	a5,-1
    48da:	00f71d63          	bne	a4,a5,48f4 <sbrkfail+0x98>
        write(fds[1], "0", 1);
    48de:	fc442783          	lw	a5,-60(s0)
    48e2:	4605                	li	a2,1
    48e4:	00005597          	auipc	a1,0x5
    48e8:	bec58593          	addi	a1,a1,-1044 # 94d0 <malloc+0x1dec>
    48ec:	853e                	mv	a0,a5
    48ee:	50a020ef          	jal	6df8 <write>
    48f2:	a819                	j	4908 <sbrkfail+0xac>
      else
        write(fds[1], "1", 1);
    48f4:	fc442783          	lw	a5,-60(s0)
    48f8:	4605                	li	a2,1
    48fa:	00005597          	auipc	a1,0x5
    48fe:	bde58593          	addi	a1,a1,-1058 # 94d8 <malloc+0x1df4>
    4902:	853e                	mv	a0,a5
    4904:	4f4020ef          	jal	6df8 <write>
      // sit around until killed
      for(;;) pause(1000);
    4908:	3e800513          	li	a0,1000
    490c:	55c020ef          	jal	6e68 <pause>
    4910:	bfe5                	j	4908 <sbrkfail+0xac>
    }
    if(pids[i] != -1) {
    4912:	fec42703          	lw	a4,-20(s0)
    4916:	f9040793          	addi	a5,s0,-112
    491a:	070a                	slli	a4,a4,0x2
    491c:	97ba                	add	a5,a5,a4
    491e:	4398                	lw	a4,0(a5)
    4920:	57fd                	li	a5,-1
    4922:	02f70563          	beq	a4,a5,494c <sbrkfail+0xf0>
      read(fds[0], &scratch, 1);
    4926:	fc042783          	lw	a5,-64(s0)
    492a:	fbf40713          	addi	a4,s0,-65
    492e:	4605                	li	a2,1
    4930:	85ba                	mv	a1,a4
    4932:	853e                	mv	a0,a5
    4934:	4bc020ef          	jal	6df0 <read>
      if(scratch == '0')
    4938:	fbf44783          	lbu	a5,-65(s0)
    493c:	873e                	mv	a4,a5
    493e:	03000793          	li	a5,48
    4942:	00f71563          	bne	a4,a5,494c <sbrkfail+0xf0>
        failed = 1;
    4946:	4785                	li	a5,1
    4948:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    494c:	fec42783          	lw	a5,-20(s0)
    4950:	2785                	addiw	a5,a5,1
    4952:	fef42623          	sw	a5,-20(s0)
    4956:	fec42703          	lw	a4,-20(s0)
    495a:	47a5                	li	a5,9
    495c:	f2e7fde3          	bgeu	a5,a4,4896 <sbrkfail+0x3a>
    }
  }
  if(!failed) {
    4960:	fe842783          	lw	a5,-24(s0)
    4964:	2781                	sext.w	a5,a5
    4966:	eb89                	bnez	a5,4978 <sbrkfail+0x11c>
    printf("%s: no allocation failed; allocate more?\n", s);
    4968:	f8843583          	ld	a1,-120(s0)
    496c:	00005517          	auipc	a0,0x5
    4970:	b7450513          	addi	a0,a0,-1164 # 94e0 <malloc+0x1dfc>
    4974:	389020ef          	jal	74fc <printf>
  }
  
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    4978:	6505                	lui	a0,0x1
    497a:	40a020ef          	jal	6d84 <sbrk>
    497e:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4982:	fe042623          	sw	zero,-20(s0)
    4986:	a83d                	j	49c4 <sbrkfail+0x168>
    if(pids[i] == -1)
    4988:	fec42703          	lw	a4,-20(s0)
    498c:	f9040793          	addi	a5,s0,-112
    4990:	070a                	slli	a4,a4,0x2
    4992:	97ba                	add	a5,a5,a4
    4994:	4398                	lw	a4,0(a5)
    4996:	57fd                	li	a5,-1
    4998:	02f70063          	beq	a4,a5,49b8 <sbrkfail+0x15c>
      continue;
    kill(pids[i]);
    499c:	fec42703          	lw	a4,-20(s0)
    49a0:	f9040793          	addi	a5,s0,-112
    49a4:	070a                	slli	a4,a4,0x2
    49a6:	97ba                	add	a5,a5,a4
    49a8:	439c                	lw	a5,0(a5)
    49aa:	853e                	mv	a0,a5
    49ac:	45c020ef          	jal	6e08 <kill>
    wait(0);
    49b0:	4501                	li	a0,0
    49b2:	42e020ef          	jal	6de0 <wait>
    49b6:	a011                	j	49ba <sbrkfail+0x15e>
      continue;
    49b8:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    49ba:	fec42783          	lw	a5,-20(s0)
    49be:	2785                	addiw	a5,a5,1
    49c0:	fef42623          	sw	a5,-20(s0)
    49c4:	fec42703          	lw	a4,-20(s0)
    49c8:	47a5                	li	a5,9
    49ca:	fae7ffe3          	bgeu	a5,a4,4988 <sbrkfail+0x12c>
  }
  if(c == (char*)SBRK_ERROR){
    49ce:	fe043703          	ld	a4,-32(s0)
    49d2:	57fd                	li	a5,-1
    49d4:	00f71d63          	bne	a4,a5,49ee <sbrkfail+0x192>
    printf("%s: failed sbrk leaked memory\n", s);
    49d8:	f8843583          	ld	a1,-120(s0)
    49dc:	00005517          	auipc	a0,0x5
    49e0:	b3450513          	addi	a0,a0,-1228 # 9510 <malloc+0x1e2c>
    49e4:	319020ef          	jal	74fc <printf>
    exit(1);
    49e8:	4505                	li	a0,1
    49ea:	3ee020ef          	jal	6dd8 <exit>
  }

  // test running fork with the above allocated page 
  pid = fork();
    49ee:	3e2020ef          	jal	6dd0 <fork>
    49f2:	87aa                	mv	a5,a0
    49f4:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    49f8:	fdc42783          	lw	a5,-36(s0)
    49fc:	2781                	sext.w	a5,a5
    49fe:	0007dd63          	bgez	a5,4a18 <sbrkfail+0x1bc>
    printf("%s: fork failed\n", s);
    4a02:	f8843583          	ld	a1,-120(s0)
    4a06:	00003517          	auipc	a0,0x3
    4a0a:	2b250513          	addi	a0,a0,690 # 7cb8 <malloc+0x5d4>
    4a0e:	2ef020ef          	jal	74fc <printf>
    exit(1);
    4a12:	4505                	li	a0,1
    4a14:	3c4020ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    4a18:	fdc42783          	lw	a5,-36(s0)
    4a1c:	2781                	sext.w	a5,a5
    4a1e:	ef85                	bnez	a5,4a56 <sbrkfail+0x1fa>
    // allocate a lot of memory. this should produce an error
    a = sbrk(10*BIG);
    4a20:	3e800537          	lui	a0,0x3e800
    4a24:	360020ef          	jal	6d84 <sbrk>
    4a28:	fca43823          	sd	a0,-48(s0)
    if(a == (char*)SBRK_ERROR){
    4a2c:	fd043703          	ld	a4,-48(s0)
    4a30:	57fd                	li	a5,-1
    4a32:	00f71563          	bne	a4,a5,4a3c <sbrkfail+0x1e0>
      exit(0);
    4a36:	4501                	li	a0,0
    4a38:	3a0020ef          	jal	6dd8 <exit>
    }   
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10*BIG);
    4a3c:	3e800637          	lui	a2,0x3e800
    4a40:	f8843583          	ld	a1,-120(s0)
    4a44:	00005517          	auipc	a0,0x5
    4a48:	aec50513          	addi	a0,a0,-1300 # 9530 <malloc+0x1e4c>
    4a4c:	2b1020ef          	jal	74fc <printf>
    exit(1);
    4a50:	4505                	li	a0,1
    4a52:	386020ef          	jal	6dd8 <exit>
  }
  wait(&xstatus);
    4a56:	fcc40793          	addi	a5,s0,-52
    4a5a:	853e                	mv	a0,a5
    4a5c:	384020ef          	jal	6de0 <wait>
  if(xstatus != 0)
    4a60:	fcc42783          	lw	a5,-52(s0)
    4a64:	c781                	beqz	a5,4a6c <sbrkfail+0x210>
    exit(1);
    4a66:	4505                	li	a0,1
    4a68:	370020ef          	jal	6dd8 <exit>
}
    4a6c:	0001                	nop
    4a6e:	70e6                	ld	ra,120(sp)
    4a70:	7446                	ld	s0,112(sp)
    4a72:	6109                	addi	sp,sp,128
    4a74:	8082                	ret

0000000000004a76 <sbrkarg>:

  
// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    4a76:	7179                	addi	sp,sp,-48
    4a78:	f406                	sd	ra,40(sp)
    4a7a:	f022                	sd	s0,32(sp)
    4a7c:	1800                	addi	s0,sp,48
    4a7e:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    4a82:	6505                	lui	a0,0x1
    4a84:	300020ef          	jal	6d84 <sbrk>
    4a88:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    4a8c:	20100593          	li	a1,513
    4a90:	00005517          	auipc	a0,0x5
    4a94:	ad050513          	addi	a0,a0,-1328 # 9560 <malloc+0x1e7c>
    4a98:	380020ef          	jal	6e18 <open>
    4a9c:	87aa                	mv	a5,a0
    4a9e:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    4aa2:	00005517          	auipc	a0,0x5
    4aa6:	abe50513          	addi	a0,a0,-1346 # 9560 <malloc+0x1e7c>
    4aaa:	37e020ef          	jal	6e28 <unlink>
  if(fd < 0)  {
    4aae:	fe442783          	lw	a5,-28(s0)
    4ab2:	2781                	sext.w	a5,a5
    4ab4:	0007dd63          	bgez	a5,4ace <sbrkarg+0x58>
    printf("%s: open sbrk failed\n", s);
    4ab8:	fd843583          	ld	a1,-40(s0)
    4abc:	00005517          	auipc	a0,0x5
    4ac0:	aac50513          	addi	a0,a0,-1364 # 9568 <malloc+0x1e84>
    4ac4:	239020ef          	jal	74fc <printf>
    exit(1);
    4ac8:	4505                	li	a0,1
    4aca:	30e020ef          	jal	6dd8 <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    4ace:	fe442783          	lw	a5,-28(s0)
    4ad2:	6605                	lui	a2,0x1
    4ad4:	fe843583          	ld	a1,-24(s0)
    4ad8:	853e                	mv	a0,a5
    4ada:	31e020ef          	jal	6df8 <write>
    4ade:	87aa                	mv	a5,a0
    4ae0:	fef42023          	sw	a5,-32(s0)
    4ae4:	fe042783          	lw	a5,-32(s0)
    4ae8:	2781                	sext.w	a5,a5
    4aea:	0007dd63          	bgez	a5,4b04 <sbrkarg+0x8e>
    printf("%s: write sbrk failed\n", s);
    4aee:	fd843583          	ld	a1,-40(s0)
    4af2:	00005517          	auipc	a0,0x5
    4af6:	a8e50513          	addi	a0,a0,-1394 # 9580 <malloc+0x1e9c>
    4afa:	203020ef          	jal	74fc <printf>
    exit(1);
    4afe:	4505                	li	a0,1
    4b00:	2d8020ef          	jal	6dd8 <exit>
  }
  close(fd);
    4b04:	fe442783          	lw	a5,-28(s0)
    4b08:	853e                	mv	a0,a5
    4b0a:	2f6020ef          	jal	6e00 <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    4b0e:	6505                	lui	a0,0x1
    4b10:	274020ef          	jal	6d84 <sbrk>
    4b14:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    4b18:	fe843503          	ld	a0,-24(s0)
    4b1c:	2cc020ef          	jal	6de8 <pipe>
    4b20:	87aa                	mv	a5,a0
    4b22:	cf81                	beqz	a5,4b3a <sbrkarg+0xc4>
    printf("%s: pipe() failed\n", s);
    4b24:	fd843583          	ld	a1,-40(s0)
    4b28:	00003517          	auipc	a0,0x3
    4b2c:	62850513          	addi	a0,a0,1576 # 8150 <malloc+0xa6c>
    4b30:	1cd020ef          	jal	74fc <printf>
    exit(1);
    4b34:	4505                	li	a0,1
    4b36:	2a2020ef          	jal	6dd8 <exit>
  } 
}
    4b3a:	0001                	nop
    4b3c:	70a2                	ld	ra,40(sp)
    4b3e:	7402                	ld	s0,32(sp)
    4b40:	6145                	addi	sp,sp,48
    4b42:	8082                	ret

0000000000004b44 <validatetest>:

void
validatetest(char *s)
{
    4b44:	7179                	addi	sp,sp,-48
    4b46:	f406                	sd	ra,40(sp)
    4b48:	f022                	sd	s0,32(sp)
    4b4a:	1800                	addi	s0,sp,48
    4b4c:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    4b50:	001137b7          	lui	a5,0x113
    4b54:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    4b58:	fe043423          	sd	zero,-24(s0)
    4b5c:	a081                	j	4b9c <validatetest+0x58>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    4b5e:	fe843783          	ld	a5,-24(s0)
    4b62:	85be                	mv	a1,a5
    4b64:	00005517          	auipc	a0,0x5
    4b68:	a3450513          	addi	a0,a0,-1484 # 9598 <malloc+0x1eb4>
    4b6c:	2cc020ef          	jal	6e38 <link>
    4b70:	87aa                	mv	a5,a0
    4b72:	873e                	mv	a4,a5
    4b74:	57fd                	li	a5,-1
    4b76:	00f70d63          	beq	a4,a5,4b90 <validatetest+0x4c>
      printf("%s: link should not succeed\n", s);
    4b7a:	fd843583          	ld	a1,-40(s0)
    4b7e:	00005517          	auipc	a0,0x5
    4b82:	a2a50513          	addi	a0,a0,-1494 # 95a8 <malloc+0x1ec4>
    4b86:	177020ef          	jal	74fc <printf>
      exit(1);
    4b8a:	4505                	li	a0,1
    4b8c:	24c020ef          	jal	6dd8 <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    4b90:	fe843703          	ld	a4,-24(s0)
    4b94:	6785                	lui	a5,0x1
    4b96:	97ba                	add	a5,a5,a4
    4b98:	fef43423          	sd	a5,-24(s0)
    4b9c:	fe442783          	lw	a5,-28(s0)
    4ba0:	1782                	slli	a5,a5,0x20
    4ba2:	9381                	srli	a5,a5,0x20
    4ba4:	fe843703          	ld	a4,-24(s0)
    4ba8:	fae7fbe3          	bgeu	a5,a4,4b5e <validatetest+0x1a>
    }
  }
}
    4bac:	0001                	nop
    4bae:	0001                	nop
    4bb0:	70a2                	ld	ra,40(sp)
    4bb2:	7402                	ld	s0,32(sp)
    4bb4:	6145                	addi	sp,sp,48
    4bb6:	8082                	ret

0000000000004bb8 <bsstest>:

// does uninitialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    4bb8:	7179                	addi	sp,sp,-48
    4bba:	f406                	sd	ra,40(sp)
    4bbc:	f022                	sd	s0,32(sp)
    4bbe:	1800                	addi	s0,sp,48
    4bc0:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    4bc4:	fe042623          	sw	zero,-20(s0)
    4bc8:	a81d                	j	4bfe <bsstest+0x46>
    if(uninit[i] != '\0'){
    4bca:	00009717          	auipc	a4,0x9
    4bce:	8e670713          	addi	a4,a4,-1818 # d4b0 <uninit>
    4bd2:	fec42783          	lw	a5,-20(s0)
    4bd6:	97ba                	add	a5,a5,a4
    4bd8:	0007c783          	lbu	a5,0(a5) # 1000 <openiputtest+0x14>
    4bdc:	cf81                	beqz	a5,4bf4 <bsstest+0x3c>
      printf("%s: bss test failed\n", s);
    4bde:	fd843583          	ld	a1,-40(s0)
    4be2:	00005517          	auipc	a0,0x5
    4be6:	9e650513          	addi	a0,a0,-1562 # 95c8 <malloc+0x1ee4>
    4bea:	113020ef          	jal	74fc <printf>
      exit(1);
    4bee:	4505                	li	a0,1
    4bf0:	1e8020ef          	jal	6dd8 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    4bf4:	fec42783          	lw	a5,-20(s0)
    4bf8:	2785                	addiw	a5,a5,1
    4bfa:	fef42623          	sw	a5,-20(s0)
    4bfe:	fec42703          	lw	a4,-20(s0)
    4c02:	6789                	lui	a5,0x2
    4c04:	70f78793          	addi	a5,a5,1807 # 270f <createdelete+0xa5>
    4c08:	fce7f1e3          	bgeu	a5,a4,4bca <bsstest+0x12>
    }
  }
}
    4c0c:	0001                	nop
    4c0e:	0001                	nop
    4c10:	70a2                	ld	ra,40(sp)
    4c12:	7402                	ld	s0,32(sp)
    4c14:	6145                	addi	sp,sp,48
    4c16:	8082                	ret

0000000000004c18 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    4c18:	7121                	addi	sp,sp,-448
    4c1a:	ff06                	sd	ra,440(sp)
    4c1c:	fb22                	sd	s0,432(sp)
    4c1e:	0380                	addi	s0,sp,448
    4c20:	e4a43423          	sd	a0,-440(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    4c24:	00005517          	auipc	a0,0x5
    4c28:	9bc50513          	addi	a0,a0,-1604 # 95e0 <malloc+0x1efc>
    4c2c:	1fc020ef          	jal	6e28 <unlink>
  pid = fork();
    4c30:	1a0020ef          	jal	6dd0 <fork>
    4c34:	87aa                	mv	a5,a0
    4c36:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    4c3a:	fe842783          	lw	a5,-24(s0)
    4c3e:	2781                	sext.w	a5,a5
    4c40:	ebc9                	bnez	a5,4cd2 <bigargtest+0xba>
    static char *args[MAXARG];
    int i;
    char big[400];
    memset(big, ' ', sizeof(big));
    4c42:	e5040793          	addi	a5,s0,-432
    4c46:	19000613          	li	a2,400
    4c4a:	02000593          	li	a1,32
    4c4e:	853e                	mv	a0,a5
    4c50:	593010ef          	jal	69e2 <memset>
    big[sizeof(big)-1] = '\0';
    4c54:	fc040fa3          	sb	zero,-33(s0)
    for(i = 0; i < MAXARG-1; i++)
    4c58:	fe042623          	sw	zero,-20(s0)
    4c5c:	a00d                	j	4c7e <bigargtest+0x66>
      args[i] = big;
    4c5e:	0000c717          	auipc	a4,0xc
    4c62:	f6a70713          	addi	a4,a4,-150 # 10bc8 <args.1>
    4c66:	fec42783          	lw	a5,-20(s0)
    4c6a:	078e                	slli	a5,a5,0x3
    4c6c:	97ba                	add	a5,a5,a4
    4c6e:	e5040713          	addi	a4,s0,-432
    4c72:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    4c74:	fec42783          	lw	a5,-20(s0)
    4c78:	2785                	addiw	a5,a5,1
    4c7a:	fef42623          	sw	a5,-20(s0)
    4c7e:	fec42783          	lw	a5,-20(s0)
    4c82:	0007871b          	sext.w	a4,a5
    4c86:	47f9                	li	a5,30
    4c88:	fce7dbe3          	bge	a5,a4,4c5e <bigargtest+0x46>
    args[MAXARG-1] = 0;
    4c8c:	0000c797          	auipc	a5,0xc
    4c90:	f3c78793          	addi	a5,a5,-196 # 10bc8 <args.1>
    4c94:	0e07bc23          	sd	zero,248(a5)
    // this exec() should fail (and return) because the
    // arguments are too large.
    exec("echo", args);
    4c98:	0000c597          	auipc	a1,0xc
    4c9c:	f3058593          	addi	a1,a1,-208 # 10bc8 <args.1>
    4ca0:	00003517          	auipc	a0,0x3
    4ca4:	df850513          	addi	a0,a0,-520 # 7a98 <malloc+0x3b4>
    4ca8:	168020ef          	jal	6e10 <exec>
    fd = open("bigarg-ok", O_CREATE);
    4cac:	20000593          	li	a1,512
    4cb0:	00005517          	auipc	a0,0x5
    4cb4:	93050513          	addi	a0,a0,-1744 # 95e0 <malloc+0x1efc>
    4cb8:	160020ef          	jal	6e18 <open>
    4cbc:	87aa                	mv	a5,a0
    4cbe:	fef42223          	sw	a5,-28(s0)
    close(fd);
    4cc2:	fe442783          	lw	a5,-28(s0)
    4cc6:	853e                	mv	a0,a5
    4cc8:	138020ef          	jal	6e00 <close>
    exit(0);
    4ccc:	4501                	li	a0,0
    4cce:	10a020ef          	jal	6dd8 <exit>
  } else if(pid < 0){
    4cd2:	fe842783          	lw	a5,-24(s0)
    4cd6:	2781                	sext.w	a5,a5
    4cd8:	0007dd63          	bgez	a5,4cf2 <bigargtest+0xda>
    printf("%s: bigargtest: fork failed\n", s);
    4cdc:	e4843583          	ld	a1,-440(s0)
    4ce0:	00005517          	auipc	a0,0x5
    4ce4:	91050513          	addi	a0,a0,-1776 # 95f0 <malloc+0x1f0c>
    4ce8:	015020ef          	jal	74fc <printf>
    exit(1);
    4cec:	4505                	li	a0,1
    4cee:	0ea020ef          	jal	6dd8 <exit>
  }
  
  wait(&xstatus);
    4cf2:	fe040793          	addi	a5,s0,-32
    4cf6:	853e                	mv	a0,a5
    4cf8:	0e8020ef          	jal	6de0 <wait>
  if(xstatus != 0)
    4cfc:	fe042783          	lw	a5,-32(s0)
    4d00:	c791                	beqz	a5,4d0c <bigargtest+0xf4>
    exit(xstatus);
    4d02:	fe042783          	lw	a5,-32(s0)
    4d06:	853e                	mv	a0,a5
    4d08:	0d0020ef          	jal	6dd8 <exit>
  fd = open("bigarg-ok", 0);
    4d0c:	4581                	li	a1,0
    4d0e:	00005517          	auipc	a0,0x5
    4d12:	8d250513          	addi	a0,a0,-1838 # 95e0 <malloc+0x1efc>
    4d16:	102020ef          	jal	6e18 <open>
    4d1a:	87aa                	mv	a5,a0
    4d1c:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    4d20:	fe442783          	lw	a5,-28(s0)
    4d24:	2781                	sext.w	a5,a5
    4d26:	0007dd63          	bgez	a5,4d40 <bigargtest+0x128>
    printf("%s: bigarg test failed!\n", s);
    4d2a:	e4843583          	ld	a1,-440(s0)
    4d2e:	00005517          	auipc	a0,0x5
    4d32:	8e250513          	addi	a0,a0,-1822 # 9610 <malloc+0x1f2c>
    4d36:	7c6020ef          	jal	74fc <printf>
    exit(1);
    4d3a:	4505                	li	a0,1
    4d3c:	09c020ef          	jal	6dd8 <exit>
  }
  close(fd);
    4d40:	fe442783          	lw	a5,-28(s0)
    4d44:	853e                	mv	a0,a5
    4d46:	0ba020ef          	jal	6e00 <close>
}
    4d4a:	0001                	nop
    4d4c:	70fa                	ld	ra,440(sp)
    4d4e:	745a                	ld	s0,432(sp)
    4d50:	6139                	addi	sp,sp,448
    4d52:	8082                	ret

0000000000004d54 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    4d54:	7159                	addi	sp,sp,-112
    4d56:	f486                	sd	ra,104(sp)
    4d58:	f0a2                	sd	s0,96(sp)
    4d5a:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    4d5c:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    4d60:	00005517          	auipc	a0,0x5
    4d64:	8d050513          	addi	a0,a0,-1840 # 9630 <malloc+0x1f4c>
    4d68:	794020ef          	jal	74fc <printf>

  for(nfiles = 0; ; nfiles++){
    4d6c:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    4d70:	06600793          	li	a5,102
    4d74:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    4d78:	fec42783          	lw	a5,-20(s0)
    4d7c:	86be                	mv	a3,a5
    4d7e:	0006871b          	sext.w	a4,a3
    4d82:	106257b7          	lui	a5,0x10625
    4d86:	dd378793          	addi	a5,a5,-557 # 10624dd3 <freep+0x106140fb>
    4d8a:	02f707b3          	mul	a5,a4,a5
    4d8e:	9381                	srli	a5,a5,0x20
    4d90:	4067d79b          	sraiw	a5,a5,0x6
    4d94:	873e                	mv	a4,a5
    4d96:	41f6d79b          	sraiw	a5,a3,0x1f
    4d9a:	40f707bb          	subw	a5,a4,a5
    4d9e:	2781                	sext.w	a5,a5
    4da0:	0ff7f793          	zext.b	a5,a5
    4da4:	0307879b          	addiw	a5,a5,48
    4da8:	0ff7f793          	zext.b	a5,a5
    4dac:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4db0:	fec42783          	lw	a5,-20(s0)
    4db4:	0007869b          	sext.w	a3,a5
    4db8:	10625737          	lui	a4,0x10625
    4dbc:	dd370713          	addi	a4,a4,-557 # 10624dd3 <freep+0x106140fb>
    4dc0:	02e68733          	mul	a4,a3,a4
    4dc4:	9301                	srli	a4,a4,0x20
    4dc6:	4067571b          	sraiw	a4,a4,0x6
    4dca:	86ba                	mv	a3,a4
    4dcc:	41f7d71b          	sraiw	a4,a5,0x1f
    4dd0:	40e6873b          	subw	a4,a3,a4
    4dd4:	86ba                	mv	a3,a4
    4dd6:	3e800713          	li	a4,1000
    4dda:	02e6873b          	mulw	a4,a3,a4
    4dde:	9f99                	subw	a5,a5,a4
    4de0:	2781                	sext.w	a5,a5
    4de2:	86be                	mv	a3,a5
    4de4:	0006871b          	sext.w	a4,a3
    4de8:	51eb87b7          	lui	a5,0x51eb8
    4dec:	51f78793          	addi	a5,a5,1311 # 51eb851f <freep+0x51ea7847>
    4df0:	02f707b3          	mul	a5,a4,a5
    4df4:	9381                	srli	a5,a5,0x20
    4df6:	4057d79b          	sraiw	a5,a5,0x5
    4dfa:	873e                	mv	a4,a5
    4dfc:	41f6d79b          	sraiw	a5,a3,0x1f
    4e00:	40f707bb          	subw	a5,a4,a5
    4e04:	2781                	sext.w	a5,a5
    4e06:	0ff7f793          	zext.b	a5,a5
    4e0a:	0307879b          	addiw	a5,a5,48
    4e0e:	0ff7f793          	zext.b	a5,a5
    4e12:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4e16:	fec42783          	lw	a5,-20(s0)
    4e1a:	0007869b          	sext.w	a3,a5
    4e1e:	51eb8737          	lui	a4,0x51eb8
    4e22:	51f70713          	addi	a4,a4,1311 # 51eb851f <freep+0x51ea7847>
    4e26:	02e68733          	mul	a4,a3,a4
    4e2a:	9301                	srli	a4,a4,0x20
    4e2c:	4057571b          	sraiw	a4,a4,0x5
    4e30:	86ba                	mv	a3,a4
    4e32:	41f7d71b          	sraiw	a4,a5,0x1f
    4e36:	40e6873b          	subw	a4,a3,a4
    4e3a:	86ba                	mv	a3,a4
    4e3c:	06400713          	li	a4,100
    4e40:	02e6873b          	mulw	a4,a3,a4
    4e44:	9f99                	subw	a5,a5,a4
    4e46:	2781                	sext.w	a5,a5
    4e48:	86be                	mv	a3,a5
    4e4a:	0006871b          	sext.w	a4,a3
    4e4e:	666667b7          	lui	a5,0x66666
    4e52:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x6665598f>
    4e56:	02f707b3          	mul	a5,a4,a5
    4e5a:	9381                	srli	a5,a5,0x20
    4e5c:	4027d79b          	sraiw	a5,a5,0x2
    4e60:	873e                	mv	a4,a5
    4e62:	41f6d79b          	sraiw	a5,a3,0x1f
    4e66:	40f707bb          	subw	a5,a4,a5
    4e6a:	2781                	sext.w	a5,a5
    4e6c:	0ff7f793          	zext.b	a5,a5
    4e70:	0307879b          	addiw	a5,a5,48
    4e74:	0ff7f793          	zext.b	a5,a5
    4e78:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    4e7c:	fec42783          	lw	a5,-20(s0)
    4e80:	873e                	mv	a4,a5
    4e82:	0007069b          	sext.w	a3,a4
    4e86:	666667b7          	lui	a5,0x66666
    4e8a:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x6665598f>
    4e8e:	02f687b3          	mul	a5,a3,a5
    4e92:	9381                	srli	a5,a5,0x20
    4e94:	4027d79b          	sraiw	a5,a5,0x2
    4e98:	86be                	mv	a3,a5
    4e9a:	41f7579b          	sraiw	a5,a4,0x1f
    4e9e:	40f687bb          	subw	a5,a3,a5
    4ea2:	86be                	mv	a3,a5
    4ea4:	87b6                	mv	a5,a3
    4ea6:	0027979b          	slliw	a5,a5,0x2
    4eaa:	9fb5                	addw	a5,a5,a3
    4eac:	0017979b          	slliw	a5,a5,0x1
    4eb0:	40f707bb          	subw	a5,a4,a5
    4eb4:	2781                	sext.w	a5,a5
    4eb6:	0ff7f793          	zext.b	a5,a5
    4eba:	0307879b          	addiw	a5,a5,48
    4ebe:	0ff7f793          	zext.b	a5,a5
    4ec2:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    4ec6:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    4eca:	f9840793          	addi	a5,s0,-104
    4ece:	85be                	mv	a1,a5
    4ed0:	00004517          	auipc	a0,0x4
    4ed4:	77050513          	addi	a0,a0,1904 # 9640 <malloc+0x1f5c>
    4ed8:	624020ef          	jal	74fc <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4edc:	f9840793          	addi	a5,s0,-104
    4ee0:	20200593          	li	a1,514
    4ee4:	853e                	mv	a0,a5
    4ee6:	733010ef          	jal	6e18 <open>
    4eea:	87aa                	mv	a5,a0
    4eec:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    4ef0:	fe042783          	lw	a5,-32(s0)
    4ef4:	2781                	sext.w	a5,a5
    4ef6:	0007dc63          	bgez	a5,4f0e <fsfull+0x1ba>
      printf("open %s failed\n", name);
    4efa:	f9840793          	addi	a5,s0,-104
    4efe:	85be                	mv	a1,a5
    4f00:	00004517          	auipc	a0,0x4
    4f04:	75050513          	addi	a0,a0,1872 # 9650 <malloc+0x1f6c>
    4f08:	5f4020ef          	jal	74fc <printf>
      break;
    4f0c:	a049                	j	4f8e <fsfull+0x23a>
    }
    int total = 0;
    4f0e:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    4f12:	fe042783          	lw	a5,-32(s0)
    4f16:	40000613          	li	a2,1024
    4f1a:	00005597          	auipc	a1,0x5
    4f1e:	59658593          	addi	a1,a1,1430 # a4b0 <buf>
    4f22:	853e                	mv	a0,a5
    4f24:	6d5010ef          	jal	6df8 <write>
    4f28:	87aa                	mv	a5,a0
    4f2a:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    4f2e:	fdc42783          	lw	a5,-36(s0)
    4f32:	0007871b          	sext.w	a4,a5
    4f36:	3ff00793          	li	a5,1023
    4f3a:	02e7d063          	bge	a5,a4,4f5a <fsfull+0x206>
        break;
      total += cc;
    4f3e:	fe442783          	lw	a5,-28(s0)
    4f42:	873e                	mv	a4,a5
    4f44:	fdc42783          	lw	a5,-36(s0)
    4f48:	9fb9                	addw	a5,a5,a4
    4f4a:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    4f4e:	fe842783          	lw	a5,-24(s0)
    4f52:	2785                	addiw	a5,a5,1
    4f54:	fef42423          	sw	a5,-24(s0)
    while(1){
    4f58:	bf6d                	j	4f12 <fsfull+0x1be>
        break;
    4f5a:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    4f5c:	fe442783          	lw	a5,-28(s0)
    4f60:	85be                	mv	a1,a5
    4f62:	00004517          	auipc	a0,0x4
    4f66:	6fe50513          	addi	a0,a0,1790 # 9660 <malloc+0x1f7c>
    4f6a:	592020ef          	jal	74fc <printf>
    close(fd);
    4f6e:	fe042783          	lw	a5,-32(s0)
    4f72:	853e                	mv	a0,a5
    4f74:	68d010ef          	jal	6e00 <close>
    if(total == 0)
    4f78:	fe442783          	lw	a5,-28(s0)
    4f7c:	2781                	sext.w	a5,a5
    4f7e:	c799                	beqz	a5,4f8c <fsfull+0x238>
  for(nfiles = 0; ; nfiles++){
    4f80:	fec42783          	lw	a5,-20(s0)
    4f84:	2785                	addiw	a5,a5,1
    4f86:	fef42623          	sw	a5,-20(s0)
    4f8a:	b3dd                	j	4d70 <fsfull+0x1c>
      break;
    4f8c:	0001                	nop
  }

  while(nfiles >= 0){
    4f8e:	aa85                	j	50fe <fsfull+0x3aa>
    char name[64];
    name[0] = 'f';
    4f90:	06600793          	li	a5,102
    4f94:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    4f98:	fec42783          	lw	a5,-20(s0)
    4f9c:	86be                	mv	a3,a5
    4f9e:	0006871b          	sext.w	a4,a3
    4fa2:	106257b7          	lui	a5,0x10625
    4fa6:	dd378793          	addi	a5,a5,-557 # 10624dd3 <freep+0x106140fb>
    4faa:	02f707b3          	mul	a5,a4,a5
    4fae:	9381                	srli	a5,a5,0x20
    4fb0:	4067d79b          	sraiw	a5,a5,0x6
    4fb4:	873e                	mv	a4,a5
    4fb6:	41f6d79b          	sraiw	a5,a3,0x1f
    4fba:	40f707bb          	subw	a5,a4,a5
    4fbe:	2781                	sext.w	a5,a5
    4fc0:	0ff7f793          	zext.b	a5,a5
    4fc4:	0307879b          	addiw	a5,a5,48
    4fc8:	0ff7f793          	zext.b	a5,a5
    4fcc:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4fd0:	fec42783          	lw	a5,-20(s0)
    4fd4:	0007869b          	sext.w	a3,a5
    4fd8:	10625737          	lui	a4,0x10625
    4fdc:	dd370713          	addi	a4,a4,-557 # 10624dd3 <freep+0x106140fb>
    4fe0:	02e68733          	mul	a4,a3,a4
    4fe4:	9301                	srli	a4,a4,0x20
    4fe6:	4067571b          	sraiw	a4,a4,0x6
    4fea:	86ba                	mv	a3,a4
    4fec:	41f7d71b          	sraiw	a4,a5,0x1f
    4ff0:	40e6873b          	subw	a4,a3,a4
    4ff4:	86ba                	mv	a3,a4
    4ff6:	3e800713          	li	a4,1000
    4ffa:	02e6873b          	mulw	a4,a3,a4
    4ffe:	9f99                	subw	a5,a5,a4
    5000:	2781                	sext.w	a5,a5
    5002:	86be                	mv	a3,a5
    5004:	0006871b          	sext.w	a4,a3
    5008:	51eb87b7          	lui	a5,0x51eb8
    500c:	51f78793          	addi	a5,a5,1311 # 51eb851f <freep+0x51ea7847>
    5010:	02f707b3          	mul	a5,a4,a5
    5014:	9381                	srli	a5,a5,0x20
    5016:	4057d79b          	sraiw	a5,a5,0x5
    501a:	873e                	mv	a4,a5
    501c:	41f6d79b          	sraiw	a5,a3,0x1f
    5020:	40f707bb          	subw	a5,a4,a5
    5024:	2781                	sext.w	a5,a5
    5026:	0ff7f793          	zext.b	a5,a5
    502a:	0307879b          	addiw	a5,a5,48
    502e:	0ff7f793          	zext.b	a5,a5
    5032:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5036:	fec42783          	lw	a5,-20(s0)
    503a:	0007869b          	sext.w	a3,a5
    503e:	51eb8737          	lui	a4,0x51eb8
    5042:	51f70713          	addi	a4,a4,1311 # 51eb851f <freep+0x51ea7847>
    5046:	02e68733          	mul	a4,a3,a4
    504a:	9301                	srli	a4,a4,0x20
    504c:	4057571b          	sraiw	a4,a4,0x5
    5050:	86ba                	mv	a3,a4
    5052:	41f7d71b          	sraiw	a4,a5,0x1f
    5056:	40e6873b          	subw	a4,a3,a4
    505a:	86ba                	mv	a3,a4
    505c:	06400713          	li	a4,100
    5060:	02e6873b          	mulw	a4,a3,a4
    5064:	9f99                	subw	a5,a5,a4
    5066:	2781                	sext.w	a5,a5
    5068:	86be                	mv	a3,a5
    506a:	0006871b          	sext.w	a4,a3
    506e:	666667b7          	lui	a5,0x66666
    5072:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x6665598f>
    5076:	02f707b3          	mul	a5,a4,a5
    507a:	9381                	srli	a5,a5,0x20
    507c:	4027d79b          	sraiw	a5,a5,0x2
    5080:	873e                	mv	a4,a5
    5082:	41f6d79b          	sraiw	a5,a3,0x1f
    5086:	40f707bb          	subw	a5,a4,a5
    508a:	2781                	sext.w	a5,a5
    508c:	0ff7f793          	zext.b	a5,a5
    5090:	0307879b          	addiw	a5,a5,48
    5094:	0ff7f793          	zext.b	a5,a5
    5098:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    509c:	fec42783          	lw	a5,-20(s0)
    50a0:	873e                	mv	a4,a5
    50a2:	0007069b          	sext.w	a3,a4
    50a6:	666667b7          	lui	a5,0x66666
    50aa:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x6665598f>
    50ae:	02f687b3          	mul	a5,a3,a5
    50b2:	9381                	srli	a5,a5,0x20
    50b4:	4027d79b          	sraiw	a5,a5,0x2
    50b8:	86be                	mv	a3,a5
    50ba:	41f7579b          	sraiw	a5,a4,0x1f
    50be:	40f687bb          	subw	a5,a3,a5
    50c2:	86be                	mv	a3,a5
    50c4:	87b6                	mv	a5,a3
    50c6:	0027979b          	slliw	a5,a5,0x2
    50ca:	9fb5                	addw	a5,a5,a3
    50cc:	0017979b          	slliw	a5,a5,0x1
    50d0:	40f707bb          	subw	a5,a4,a5
    50d4:	2781                	sext.w	a5,a5
    50d6:	0ff7f793          	zext.b	a5,a5
    50da:	0307879b          	addiw	a5,a5,48
    50de:	0ff7f793          	zext.b	a5,a5
    50e2:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    50e6:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    50ea:	f9840793          	addi	a5,s0,-104
    50ee:	853e                	mv	a0,a5
    50f0:	539010ef          	jal	6e28 <unlink>
    nfiles--;
    50f4:	fec42783          	lw	a5,-20(s0)
    50f8:	37fd                	addiw	a5,a5,-1
    50fa:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    50fe:	fec42783          	lw	a5,-20(s0)
    5102:	2781                	sext.w	a5,a5
    5104:	e807d6e3          	bgez	a5,4f90 <fsfull+0x23c>
  }

  printf("fsfull test finished\n");
    5108:	00004517          	auipc	a0,0x4
    510c:	56850513          	addi	a0,a0,1384 # 9670 <malloc+0x1f8c>
    5110:	3ec020ef          	jal	74fc <printf>
}
    5114:	0001                	nop
    5116:	70a6                	ld	ra,104(sp)
    5118:	7406                	ld	s0,96(sp)
    511a:	6165                	addi	sp,sp,112
    511c:	8082                	ret

000000000000511e <argptest>:

void argptest(char *s)
{
    511e:	7179                	addi	sp,sp,-48
    5120:	f406                	sd	ra,40(sp)
    5122:	f022                	sd	s0,32(sp)
    5124:	1800                	addi	s0,sp,48
    5126:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    512a:	4581                	li	a1,0
    512c:	00004517          	auipc	a0,0x4
    5130:	55c50513          	addi	a0,a0,1372 # 9688 <malloc+0x1fa4>
    5134:	4e5010ef          	jal	6e18 <open>
    5138:	87aa                	mv	a5,a0
    513a:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    513e:	fec42783          	lw	a5,-20(s0)
    5142:	2781                	sext.w	a5,a5
    5144:	0007dd63          	bgez	a5,515e <argptest+0x40>
    printf("%s: open failed\n", s);
    5148:	fd843583          	ld	a1,-40(s0)
    514c:	00003517          	auipc	a0,0x3
    5150:	b8450513          	addi	a0,a0,-1148 # 7cd0 <malloc+0x5ec>
    5154:	3a8020ef          	jal	74fc <printf>
    exit(1);
    5158:	4505                	li	a0,1
    515a:	47f010ef          	jal	6dd8 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    515e:	4501                	li	a0,0
    5160:	425010ef          	jal	6d84 <sbrk>
    5164:	87aa                	mv	a5,a0
    5166:	fff78713          	addi	a4,a5,-1
    516a:	fec42783          	lw	a5,-20(s0)
    516e:	567d                	li	a2,-1
    5170:	85ba                	mv	a1,a4
    5172:	853e                	mv	a0,a5
    5174:	47d010ef          	jal	6df0 <read>
  close(fd);
    5178:	fec42783          	lw	a5,-20(s0)
    517c:	853e                	mv	a0,a5
    517e:	483010ef          	jal	6e00 <close>
}
    5182:	0001                	nop
    5184:	70a2                	ld	ra,40(sp)
    5186:	7402                	ld	s0,32(sp)
    5188:	6145                	addi	sp,sp,48
    518a:	8082                	ret

000000000000518c <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    518c:	7139                	addi	sp,sp,-64
    518e:	fc06                	sd	ra,56(sp)
    5190:	f822                	sd	s0,48(sp)
    5192:	0080                	addi	s0,sp,64
    5194:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;
  
  pid = fork();
    5198:	439010ef          	jal	6dd0 <fork>
    519c:	87aa                	mv	a5,a0
    519e:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    51a2:	fec42783          	lw	a5,-20(s0)
    51a6:	2781                	sext.w	a5,a5
    51a8:	ef8d                	bnez	a5,51e2 <stacktest+0x56>
    char *sp = (char *) r_sp();
    51aa:	e57fa0ef          	jal	0 <r_sp>
    51ae:	87aa                	mv	a5,a0
    51b0:	fef43023          	sd	a5,-32(s0)
    sp -= USERSTACK*PGSIZE;
    51b4:	fe043703          	ld	a4,-32(s0)
    51b8:	77fd                	lui	a5,0xfffff
    51ba:	97ba                	add	a5,a5,a4
    51bc:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    51c0:	fe043783          	ld	a5,-32(s0)
    51c4:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <freep+0xfffffffffffee328>
    51c8:	2781                	sext.w	a5,a5
    51ca:	863e                	mv	a2,a5
    51cc:	fc843583          	ld	a1,-56(s0)
    51d0:	00004517          	auipc	a0,0x4
    51d4:	4c050513          	addi	a0,a0,1216 # 9690 <malloc+0x1fac>
    51d8:	324020ef          	jal	74fc <printf>
    exit(1);
    51dc:	4505                	li	a0,1
    51de:	3fb010ef          	jal	6dd8 <exit>
  } else if(pid < 0){
    51e2:	fec42783          	lw	a5,-20(s0)
    51e6:	2781                	sext.w	a5,a5
    51e8:	0007dd63          	bgez	a5,5202 <stacktest+0x76>
    printf("%s: fork failed\n", s);
    51ec:	fc843583          	ld	a1,-56(s0)
    51f0:	00003517          	auipc	a0,0x3
    51f4:	ac850513          	addi	a0,a0,-1336 # 7cb8 <malloc+0x5d4>
    51f8:	304020ef          	jal	74fc <printf>
    exit(1);
    51fc:	4505                	li	a0,1
    51fe:	3db010ef          	jal	6dd8 <exit>
  }
  wait(&xstatus);
    5202:	fdc40793          	addi	a5,s0,-36
    5206:	853e                	mv	a0,a5
    5208:	3d9010ef          	jal	6de0 <wait>
  if(xstatus == -1)  // kernel killed child?
    520c:	fdc42703          	lw	a4,-36(s0)
    5210:	57fd                	li	a5,-1
    5212:	00f71563          	bne	a4,a5,521c <stacktest+0x90>
    exit(0);
    5216:	4501                	li	a0,0
    5218:	3c1010ef          	jal	6dd8 <exit>
  else
    exit(xstatus);
    521c:	fdc42783          	lw	a5,-36(s0)
    5220:	853e                	mv	a0,a5
    5222:	3b7010ef          	jal	6dd8 <exit>

0000000000005226 <nowrite>:

// check that writes to a few forbidden addresses
// cause a fault, e.g. process's text and TRAMPOLINE.
void
nowrite(char *s)
{
    5226:	7159                	addi	sp,sp,-112
    5228:	f486                	sd	ra,104(sp)
    522a:	f0a2                	sd	s0,96(sp)
    522c:	1880                	addi	s0,sp,112
    522e:	f8a43c23          	sd	a0,-104(s0)
  int pid;
  int xstatus;
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    5232:	00002797          	auipc	a5,0x2
    5236:	77678793          	addi	a5,a5,1910 # 79a8 <malloc+0x2c4>
    523a:	6388                	ld	a0,0(a5)
    523c:	678c                	ld	a1,8(a5)
    523e:	6b90                	ld	a2,16(a5)
    5240:	6f94                	ld	a3,24(a5)
    5242:	7398                	ld	a4,32(a5)
    5244:	779c                	ld	a5,40(a5)
    5246:	faa43423          	sd	a0,-88(s0)
    524a:	fab43823          	sd	a1,-80(s0)
    524e:	fac43c23          	sd	a2,-72(s0)
    5252:	fcd43023          	sd	a3,-64(s0)
    5256:	fce43423          	sd	a4,-56(s0)
    525a:	fcf43823          	sd	a5,-48(s0)
                     0xffffffffffffffff };
  
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    525e:	fe042623          	sw	zero,-20(s0)
    5262:	a061                	j	52ea <nowrite+0xc4>
    pid = fork();
    5264:	36d010ef          	jal	6dd0 <fork>
    5268:	87aa                	mv	a5,a0
    526a:	fef42423          	sw	a5,-24(s0)
    if(pid == 0) {
    526e:	fe842783          	lw	a5,-24(s0)
    5272:	2781                	sext.w	a5,a5
    5274:	eb9d                	bnez	a5,52aa <nowrite+0x84>
      volatile int *addr = (int *) addrs[ai];
    5276:	fec42703          	lw	a4,-20(s0)
    527a:	fa840793          	addi	a5,s0,-88
    527e:	070e                	slli	a4,a4,0x3
    5280:	97ba                	add	a5,a5,a4
    5282:	639c                	ld	a5,0(a5)
    5284:	fef43023          	sd	a5,-32(s0)
      *addr = 10;
    5288:	fe043783          	ld	a5,-32(s0)
    528c:	4729                	li	a4,10
    528e:	c398                	sw	a4,0(a5)
      printf("%s: write to %p did not fail!\n", s, addr);
    5290:	fe043603          	ld	a2,-32(s0)
    5294:	f9843583          	ld	a1,-104(s0)
    5298:	00004517          	auipc	a0,0x4
    529c:	42050513          	addi	a0,a0,1056 # 96b8 <malloc+0x1fd4>
    52a0:	25c020ef          	jal	74fc <printf>
      exit(0);
    52a4:	4501                	li	a0,0
    52a6:	333010ef          	jal	6dd8 <exit>
    } else if(pid < 0){
    52aa:	fe842783          	lw	a5,-24(s0)
    52ae:	2781                	sext.w	a5,a5
    52b0:	0007dd63          	bgez	a5,52ca <nowrite+0xa4>
      printf("%s: fork failed\n", s);
    52b4:	f9843583          	ld	a1,-104(s0)
    52b8:	00003517          	auipc	a0,0x3
    52bc:	a0050513          	addi	a0,a0,-1536 # 7cb8 <malloc+0x5d4>
    52c0:	23c020ef          	jal	74fc <printf>
      exit(1);
    52c4:	4505                	li	a0,1
    52c6:	313010ef          	jal	6dd8 <exit>
    }
    wait(&xstatus);
    52ca:	fdc40793          	addi	a5,s0,-36
    52ce:	853e                	mv	a0,a5
    52d0:	311010ef          	jal	6de0 <wait>
    if(xstatus == 0){
    52d4:	fdc42783          	lw	a5,-36(s0)
    52d8:	e781                	bnez	a5,52e0 <nowrite+0xba>
      // kernel did not kill child!
      exit(1);
    52da:	4505                	li	a0,1
    52dc:	2fd010ef          	jal	6dd8 <exit>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    52e0:	fec42783          	lw	a5,-20(s0)
    52e4:	2785                	addiw	a5,a5,1
    52e6:	fef42623          	sw	a5,-20(s0)
    52ea:	fec42703          	lw	a4,-20(s0)
    52ee:	4795                	li	a5,5
    52f0:	f6e7fae3          	bgeu	a5,a4,5264 <nowrite+0x3e>
    }
  }
  exit(0);
    52f4:	4501                	li	a0,0
    52f6:	2e3010ef          	jal	6dd8 <exit>

00000000000052fa <pgbug>:
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void *big = (void*) 0xeaeb0b5b00002f5e;
void
pgbug(char *s)
{
    52fa:	7179                	addi	sp,sp,-48
    52fc:	f406                	sd	ra,40(sp)
    52fe:	f022                	sd	s0,32(sp)
    5300:	1800                	addi	s0,sp,48
    5302:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    5306:	fe043423          	sd	zero,-24(s0)
  exec(big, argv);
    530a:	00005797          	auipc	a5,0x5
    530e:	cf678793          	addi	a5,a5,-778 # a000 <big>
    5312:	639c                	ld	a5,0(a5)
    5314:	fe840713          	addi	a4,s0,-24
    5318:	85ba                	mv	a1,a4
    531a:	853e                	mv	a0,a5
    531c:	2f5010ef          	jal	6e10 <exec>
  pipe(big);
    5320:	00005797          	auipc	a5,0x5
    5324:	ce078793          	addi	a5,a5,-800 # a000 <big>
    5328:	639c                	ld	a5,0(a5)
    532a:	853e                	mv	a0,a5
    532c:	2bd010ef          	jal	6de8 <pipe>

  exit(0);
    5330:	4501                	li	a0,0
    5332:	2a7010ef          	jal	6dd8 <exit>

0000000000005336 <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    5336:	7179                	addi	sp,sp,-48
    5338:	f406                	sd	ra,40(sp)
    533a:	f022                	sd	s0,32(sp)
    533c:	1800                	addi	s0,sp,48
    533e:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    5342:	28f010ef          	jal	6dd0 <fork>
    5346:	87aa                	mv	a5,a0
    5348:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    534c:	fec42783          	lw	a5,-20(s0)
    5350:	2781                	sext.w	a5,a5
    5352:	0007db63          	bgez	a5,5368 <sbrkbugs+0x32>
    printf("fork failed\n");
    5356:	00002517          	auipc	a0,0x2
    535a:	73250513          	addi	a0,a0,1842 # 7a88 <malloc+0x3a4>
    535e:	19e020ef          	jal	74fc <printf>
    exit(1);
    5362:	4505                	li	a0,1
    5364:	275010ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    5368:	fec42783          	lw	a5,-20(s0)
    536c:	2781                	sext.w	a5,a5
    536e:	e395                	bnez	a5,5392 <sbrkbugs+0x5c>
    int sz = (uint64) sbrk(0);
    5370:	4501                	li	a0,0
    5372:	213010ef          	jal	6d84 <sbrk>
    5376:	87aa                	mv	a5,a0
    5378:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    537c:	fe442783          	lw	a5,-28(s0)
    5380:	40f007bb          	negw	a5,a5
    5384:	2781                	sext.w	a5,a5
    5386:	853e                	mv	a0,a5
    5388:	1fd010ef          	jal	6d84 <sbrk>
    // user page fault here.
    exit(0);
    538c:	4501                	li	a0,0
    538e:	24b010ef          	jal	6dd8 <exit>
  }
  wait(0);
    5392:	4501                	li	a0,0
    5394:	24d010ef          	jal	6de0 <wait>

  pid = fork();
    5398:	239010ef          	jal	6dd0 <fork>
    539c:	87aa                	mv	a5,a0
    539e:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    53a2:	fec42783          	lw	a5,-20(s0)
    53a6:	2781                	sext.w	a5,a5
    53a8:	0007db63          	bgez	a5,53be <sbrkbugs+0x88>
    printf("fork failed\n");
    53ac:	00002517          	auipc	a0,0x2
    53b0:	6dc50513          	addi	a0,a0,1756 # 7a88 <malloc+0x3a4>
    53b4:	148020ef          	jal	74fc <printf>
    exit(1);
    53b8:	4505                	li	a0,1
    53ba:	21f010ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    53be:	fec42783          	lw	a5,-20(s0)
    53c2:	2781                	sext.w	a5,a5
    53c4:	e785                	bnez	a5,53ec <sbrkbugs+0xb6>
    int sz = (uint64) sbrk(0);
    53c6:	4501                	li	a0,0
    53c8:	1bd010ef          	jal	6d84 <sbrk>
    53cc:	87aa                	mv	a5,a0
    53ce:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    53d2:	6785                	lui	a5,0x1
    53d4:	dac7879b          	addiw	a5,a5,-596 # dac <truncate3+0x13c>
    53d8:	fe842703          	lw	a4,-24(s0)
    53dc:	9f99                	subw	a5,a5,a4
    53de:	2781                	sext.w	a5,a5
    53e0:	853e                	mv	a0,a5
    53e2:	1a3010ef          	jal	6d84 <sbrk>
    exit(0);
    53e6:	4501                	li	a0,0
    53e8:	1f1010ef          	jal	6dd8 <exit>
  }
  wait(0);
    53ec:	4501                	li	a0,0
    53ee:	1f3010ef          	jal	6de0 <wait>

  pid = fork();
    53f2:	1df010ef          	jal	6dd0 <fork>
    53f6:	87aa                	mv	a5,a0
    53f8:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    53fc:	fec42783          	lw	a5,-20(s0)
    5400:	2781                	sext.w	a5,a5
    5402:	0007db63          	bgez	a5,5418 <sbrkbugs+0xe2>
    printf("fork failed\n");
    5406:	00002517          	auipc	a0,0x2
    540a:	68250513          	addi	a0,a0,1666 # 7a88 <malloc+0x3a4>
    540e:	0ee020ef          	jal	74fc <printf>
    exit(1);
    5412:	4505                	li	a0,1
    5414:	1c5010ef          	jal	6dd8 <exit>
  }
  if(pid == 0){
    5418:	fec42783          	lw	a5,-20(s0)
    541c:	2781                	sext.w	a5,a5
    541e:	e78d                	bnez	a5,5448 <sbrkbugs+0x112>
    // set the break in the middle of a page.
    sbrk((10*PGSIZE + 2048) - (uint64)sbrk(0));
    5420:	4501                	li	a0,0
    5422:	163010ef          	jal	6d84 <sbrk>
    5426:	87aa                	mv	a5,a0
    5428:	2781                	sext.w	a5,a5
    542a:	672d                	lui	a4,0xb
    542c:	8007071b          	addiw	a4,a4,-2048 # a800 <buf+0x350>
    5430:	40f707bb          	subw	a5,a4,a5
    5434:	2781                	sext.w	a5,a5
    5436:	853e                	mv	a0,a5
    5438:	14d010ef          	jal	6d84 <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    543c:	5559                	li	a0,-10
    543e:	147010ef          	jal	6d84 <sbrk>

    exit(0);
    5442:	4501                	li	a0,0
    5444:	195010ef          	jal	6dd8 <exit>
  }
  wait(0);
    5448:	4501                	li	a0,0
    544a:	197010ef          	jal	6de0 <wait>

  exit(0);
    544e:	4501                	li	a0,0
    5450:	189010ef          	jal	6dd8 <exit>

0000000000005454 <sbrklast>:
// if process size was somewhat more than a page boundary, and then
// shrunk to be somewhat less than that page boundary, can the kernel
// still copyin() from addresses in the last page?
void
sbrklast(char *s)
{
    5454:	7139                	addi	sp,sp,-64
    5456:	fc06                	sd	ra,56(sp)
    5458:	f822                	sd	s0,48(sp)
    545a:	0080                	addi	s0,sp,64
    545c:	fca43423          	sd	a0,-56(s0)
  uint64 top = (uint64) sbrk(0);
    5460:	4501                	li	a0,0
    5462:	123010ef          	jal	6d84 <sbrk>
    5466:	87aa                	mv	a5,a0
    5468:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0)
    546c:	fe843703          	ld	a4,-24(s0)
    5470:	6785                	lui	a5,0x1
    5472:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
    5474:	8ff9                	and	a5,a5,a4
    5476:	c385                	beqz	a5,5496 <sbrklast+0x42>
    sbrk(PGSIZE - (top % PGSIZE));
    5478:	fe843783          	ld	a5,-24(s0)
    547c:	2781                	sext.w	a5,a5
    547e:	873e                	mv	a4,a5
    5480:	6785                	lui	a5,0x1
    5482:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
    5484:	8ff9                	and	a5,a5,a4
    5486:	2781                	sext.w	a5,a5
    5488:	6705                	lui	a4,0x1
    548a:	40f707bb          	subw	a5,a4,a5
    548e:	2781                	sext.w	a5,a5
    5490:	853e                	mv	a0,a5
    5492:	0f3010ef          	jal	6d84 <sbrk>
  sbrk(PGSIZE);
    5496:	6505                	lui	a0,0x1
    5498:	0ed010ef          	jal	6d84 <sbrk>
  sbrk(10);
    549c:	4529                	li	a0,10
    549e:	0e7010ef          	jal	6d84 <sbrk>
  sbrk(-20);
    54a2:	5531                	li	a0,-20
    54a4:	0e1010ef          	jal	6d84 <sbrk>
  top = (uint64) sbrk(0);
    54a8:	4501                	li	a0,0
    54aa:	0db010ef          	jal	6d84 <sbrk>
    54ae:	87aa                	mv	a5,a0
    54b0:	fef43423          	sd	a5,-24(s0)
  char *p = (char *) (top - 64);
    54b4:	fe843783          	ld	a5,-24(s0)
    54b8:	fc078793          	addi	a5,a5,-64
    54bc:	fef43023          	sd	a5,-32(s0)
  p[0] = 'x';
    54c0:	fe043783          	ld	a5,-32(s0)
    54c4:	07800713          	li	a4,120
    54c8:	00e78023          	sb	a4,0(a5)
  p[1] = '\0';
    54cc:	fe043783          	ld	a5,-32(s0)
    54d0:	0785                	addi	a5,a5,1
    54d2:	00078023          	sb	zero,0(a5)
  int fd = open(p, O_RDWR|O_CREATE);
    54d6:	20200593          	li	a1,514
    54da:	fe043503          	ld	a0,-32(s0)
    54de:	13b010ef          	jal	6e18 <open>
    54e2:	87aa                	mv	a5,a0
    54e4:	fcf42e23          	sw	a5,-36(s0)
  write(fd, p, 1);
    54e8:	fdc42783          	lw	a5,-36(s0)
    54ec:	4605                	li	a2,1
    54ee:	fe043583          	ld	a1,-32(s0)
    54f2:	853e                	mv	a0,a5
    54f4:	105010ef          	jal	6df8 <write>
  close(fd);
    54f8:	fdc42783          	lw	a5,-36(s0)
    54fc:	853e                	mv	a0,a5
    54fe:	103010ef          	jal	6e00 <close>
  fd = open(p, O_RDWR);
    5502:	4589                	li	a1,2
    5504:	fe043503          	ld	a0,-32(s0)
    5508:	111010ef          	jal	6e18 <open>
    550c:	87aa                	mv	a5,a0
    550e:	fcf42e23          	sw	a5,-36(s0)
  p[0] = '\0';
    5512:	fe043783          	ld	a5,-32(s0)
    5516:	00078023          	sb	zero,0(a5)
  read(fd, p, 1);
    551a:	fdc42783          	lw	a5,-36(s0)
    551e:	4605                	li	a2,1
    5520:	fe043583          	ld	a1,-32(s0)
    5524:	853e                	mv	a0,a5
    5526:	0cb010ef          	jal	6df0 <read>
  if(p[0] != 'x')
    552a:	fe043783          	ld	a5,-32(s0)
    552e:	0007c783          	lbu	a5,0(a5)
    5532:	873e                	mv	a4,a5
    5534:	07800793          	li	a5,120
    5538:	00f70563          	beq	a4,a5,5542 <sbrklast+0xee>
    exit(1);
    553c:	4505                	li	a0,1
    553e:	09b010ef          	jal	6dd8 <exit>
}
    5542:	0001                	nop
    5544:	70e2                	ld	ra,56(sp)
    5546:	7442                	ld	s0,48(sp)
    5548:	6121                	addi	sp,sp,64
    554a:	8082                	ret

000000000000554c <sbrk8000>:

// does sbrk handle signed int32 wrap-around with
// negative arguments?
void
sbrk8000(char *s)
{
    554c:	7179                	addi	sp,sp,-48
    554e:	f406                	sd	ra,40(sp)
    5550:	f022                	sd	s0,32(sp)
    5552:	1800                	addi	s0,sp,48
    5554:	fca43c23          	sd	a0,-40(s0)
  sbrk(0x80000004);
    5558:	800007b7          	lui	a5,0x80000
    555c:	00478513          	addi	a0,a5,4 # ffffffff80000004 <freep+0xffffffff7ffef32c>
    5560:	025010ef          	jal	6d84 <sbrk>
  volatile char *top = sbrk(0);
    5564:	4501                	li	a0,0
    5566:	01f010ef          	jal	6d84 <sbrk>
    556a:	fea43423          	sd	a0,-24(s0)
  *(top-1) = *(top-1) + 1;
    556e:	fe843783          	ld	a5,-24(s0)
    5572:	17fd                	addi	a5,a5,-1
    5574:	0007c783          	lbu	a5,0(a5)
    5578:	0ff7f713          	zext.b	a4,a5
    557c:	fe843783          	ld	a5,-24(s0)
    5580:	17fd                	addi	a5,a5,-1
    5582:	2705                	addiw	a4,a4,1 # 1001 <openiputtest+0x15>
    5584:	0ff77713          	zext.b	a4,a4
    5588:	00e78023          	sb	a4,0(a5)
}
    558c:	0001                	nop
    558e:	70a2                	ld	ra,40(sp)
    5590:	7402                	ld	s0,32(sp)
    5592:	6145                	addi	sp,sp,48
    5594:	8082                	ret

0000000000005596 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    5596:	7139                	addi	sp,sp,-64
    5598:	fc06                	sd	ra,56(sp)
    559a:	f822                	sd	s0,48(sp)
    559c:	0080                	addi	s0,sp,64
    559e:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    55a2:	fe042623          	sw	zero,-20(s0)
    55a6:	a02d                	j	55d0 <badarg+0x3a>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    55a8:	57fd                	li	a5,-1
    55aa:	9381                	srli	a5,a5,0x20
    55ac:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    55b0:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    55b4:	fd840793          	addi	a5,s0,-40
    55b8:	85be                	mv	a1,a5
    55ba:	00002517          	auipc	a0,0x2
    55be:	4de50513          	addi	a0,a0,1246 # 7a98 <malloc+0x3b4>
    55c2:	04f010ef          	jal	6e10 <exec>
  for(int i = 0; i < 50000; i++){
    55c6:	fec42783          	lw	a5,-20(s0)
    55ca:	2785                	addiw	a5,a5,1
    55cc:	fef42623          	sw	a5,-20(s0)
    55d0:	fec42783          	lw	a5,-20(s0)
    55d4:	0007871b          	sext.w	a4,a5
    55d8:	67b1                	lui	a5,0xc
    55da:	34f78793          	addi	a5,a5,847 # c34f <buf+0x1e9f>
    55de:	fce7d5e3          	bge	a5,a4,55a8 <badarg+0x12>
  }
  
  exit(0);
    55e2:	4501                	li	a0,0
    55e4:	7f4010ef          	jal	6dd8 <exit>

00000000000055e8 <lazy_alloc>:

// Touch a page every 64 pages, which with lazy allocation
// causes one page to be allocated.
void
lazy_alloc(char *s)
{
    55e8:	7139                	addi	sp,sp,-64
    55ea:	fc06                	sd	ra,56(sp)
    55ec:	f822                	sd	s0,48(sp)
    55ee:	0080                	addi	s0,sp,64
    55f0:	fca43423          	sd	a0,-56(s0)
  char *i, *prev_end, *new_end;
  
  prev_end = sbrklazy(REGION_SZ);
    55f4:	40000537          	lui	a0,0x40000
    55f8:	7b2010ef          	jal	6daa <sbrklazy>
    55fc:	fea43023          	sd	a0,-32(s0)
  if (prev_end == (char *) SBRK_ERROR) {
    5600:	fe043703          	ld	a4,-32(s0)
    5604:	57fd                	li	a5,-1
    5606:	00f71b63          	bne	a4,a5,561c <lazy_alloc+0x34>
    printf("sbrklazy() failed\n");
    560a:	00004517          	auipc	a0,0x4
    560e:	0ce50513          	addi	a0,a0,206 # 96d8 <malloc+0x1ff4>
    5612:	6eb010ef          	jal	74fc <printf>
    exit(1);
    5616:	4505                	li	a0,1
    5618:	7c0010ef          	jal	6dd8 <exit>
  }
  new_end = prev_end + REGION_SZ;
    561c:	fe043703          	ld	a4,-32(s0)
    5620:	400007b7          	lui	a5,0x40000
    5624:	97ba                	add	a5,a5,a4
    5626:	fcf43c23          	sd	a5,-40(s0)

  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    562a:	fe043703          	ld	a4,-32(s0)
    562e:	6785                	lui	a5,0x1
    5630:	97ba                	add	a5,a5,a4
    5632:	fef43423          	sd	a5,-24(s0)
    5636:	a829                	j	5650 <lazy_alloc+0x68>
    *(char **)i = i;
    5638:	fe843783          	ld	a5,-24(s0)
    563c:	fe843703          	ld	a4,-24(s0)
    5640:	e398                	sd	a4,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    5642:	fe843703          	ld	a4,-24(s0)
    5646:	000407b7          	lui	a5,0x40
    564a:	97ba                	add	a5,a5,a4
    564c:	fef43423          	sd	a5,-24(s0)
    5650:	fe843703          	ld	a4,-24(s0)
    5654:	fd843783          	ld	a5,-40(s0)
    5658:	fef760e3          	bltu	a4,a5,5638 <lazy_alloc+0x50>

  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    565c:	fe043703          	ld	a4,-32(s0)
    5660:	6785                	lui	a5,0x1
    5662:	97ba                	add	a5,a5,a4
    5664:	fef43423          	sd	a5,-24(s0)
    5668:	a805                	j	5698 <lazy_alloc+0xb0>
    if (*(char **)i != i) {
    566a:	fe843783          	ld	a5,-24(s0)
    566e:	639c                	ld	a5,0(a5)
    5670:	fe843703          	ld	a4,-24(s0)
    5674:	00f70b63          	beq	a4,a5,568a <lazy_alloc+0xa2>
      printf("failed to read value from memory\n");
    5678:	00004517          	auipc	a0,0x4
    567c:	07850513          	addi	a0,a0,120 # 96f0 <malloc+0x200c>
    5680:	67d010ef          	jal	74fc <printf>
      exit(1);
    5684:	4505                	li	a0,1
    5686:	752010ef          	jal	6dd8 <exit>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    568a:	fe843703          	ld	a4,-24(s0)
    568e:	000407b7          	lui	a5,0x40
    5692:	97ba                	add	a5,a5,a4
    5694:	fef43423          	sd	a5,-24(s0)
    5698:	fe843703          	ld	a4,-24(s0)
    569c:	fd843783          	ld	a5,-40(s0)
    56a0:	fcf765e3          	bltu	a4,a5,566a <lazy_alloc+0x82>
    }
  }

  exit(0);
    56a4:	4501                	li	a0,0
    56a6:	732010ef          	jal	6dd8 <exit>

00000000000056aa <lazy_unmap>:
// Touch a page every 64 pages in region, which with lazy allocation
// causes one page to be allocated. Check that freeing the region
// frees the allocated pages.
void
lazy_unmap(char *s)
{
    56aa:	7139                	addi	sp,sp,-64
    56ac:	fc06                	sd	ra,56(sp)
    56ae:	f822                	sd	s0,48(sp)
    56b0:	0080                	addi	s0,sp,64
    56b2:	fca43423          	sd	a0,-56(s0)
  int pid;
  char *i, *prev_end, *new_end;

  prev_end = sbrklazy(REGION_SZ);
    56b6:	40000537          	lui	a0,0x40000
    56ba:	6f0010ef          	jal	6daa <sbrklazy>
    56be:	fea43023          	sd	a0,-32(s0)
  if (prev_end == (char*)SBRK_ERROR) {
    56c2:	fe043703          	ld	a4,-32(s0)
    56c6:	57fd                	li	a5,-1
    56c8:	00f71b63          	bne	a4,a5,56de <lazy_unmap+0x34>
    printf("sbrklazy() failed\n");
    56cc:	00004517          	auipc	a0,0x4
    56d0:	00c50513          	addi	a0,a0,12 # 96d8 <malloc+0x1ff4>
    56d4:	629010ef          	jal	74fc <printf>
    exit(1);
    56d8:	4505                	li	a0,1
    56da:	6fe010ef          	jal	6dd8 <exit>
  }
  new_end = prev_end + REGION_SZ;
    56de:	fe043703          	ld	a4,-32(s0)
    56e2:	400007b7          	lui	a5,0x40000
    56e6:	97ba                	add	a5,a5,a4
    56e8:	fcf43c23          	sd	a5,-40(s0)

  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    56ec:	fe043703          	ld	a4,-32(s0)
    56f0:	6785                	lui	a5,0x1
    56f2:	97ba                	add	a5,a5,a4
    56f4:	fef43423          	sd	a5,-24(s0)
    56f8:	a829                	j	5712 <lazy_unmap+0x68>
    *(char **)i = i;
    56fa:	fe843783          	ld	a5,-24(s0)
    56fe:	fe843703          	ld	a4,-24(s0)
    5702:	e398                	sd	a4,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    5704:	fe843703          	ld	a4,-24(s0)
    5708:	010007b7          	lui	a5,0x1000
    570c:	97ba                	add	a5,a5,a4
    570e:	fef43423          	sd	a5,-24(s0)
    5712:	fe843703          	ld	a4,-24(s0)
    5716:	fd843783          	ld	a5,-40(s0)
    571a:	fef760e3          	bltu	a4,a5,56fa <lazy_unmap+0x50>

  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    571e:	fe043703          	ld	a4,-32(s0)
    5722:	6785                	lui	a5,0x1
    5724:	97ba                	add	a5,a5,a4
    5726:	fef43423          	sd	a5,-24(s0)
    572a:	a8a5                	j	57a2 <lazy_unmap+0xf8>
    pid = fork();
    572c:	6a4010ef          	jal	6dd0 <fork>
    5730:	87aa                	mv	a5,a0
    5732:	fcf42a23          	sw	a5,-44(s0)
    if (pid < 0) {
    5736:	fd442783          	lw	a5,-44(s0)
    573a:	2781                	sext.w	a5,a5
    573c:	0007db63          	bgez	a5,5752 <lazy_unmap+0xa8>
      printf("error forking\n");
    5740:	00004517          	auipc	a0,0x4
    5744:	fd850513          	addi	a0,a0,-40 # 9718 <malloc+0x2034>
    5748:	5b5010ef          	jal	74fc <printf>
      exit(1);
    574c:	4505                	li	a0,1
    574e:	68a010ef          	jal	6dd8 <exit>
    } else if (pid == 0) {
    5752:	fd442783          	lw	a5,-44(s0)
    5756:	2781                	sext.w	a5,a5
    5758:	ef89                	bnez	a5,5772 <lazy_unmap+0xc8>
      sbrklazy(-1L * REGION_SZ);
    575a:	c0000537          	lui	a0,0xc0000
    575e:	64c010ef          	jal	6daa <sbrklazy>
      *(char **)i = i;
    5762:	fe843783          	ld	a5,-24(s0)
    5766:	fe843703          	ld	a4,-24(s0)
    576a:	e398                	sd	a4,0(a5)
      exit(0);
    576c:	4501                	li	a0,0
    576e:	66a010ef          	jal	6dd8 <exit>
    } else {
      int status;
      wait(&status);
    5772:	fd040793          	addi	a5,s0,-48
    5776:	853e                	mv	a0,a5
    5778:	668010ef          	jal	6de0 <wait>
      if (status == 0) {
    577c:	fd042783          	lw	a5,-48(s0)
    5780:	eb91                	bnez	a5,5794 <lazy_unmap+0xea>
        printf("memory not unmapped\n");
    5782:	00004517          	auipc	a0,0x4
    5786:	fa650513          	addi	a0,a0,-90 # 9728 <malloc+0x2044>
    578a:	573010ef          	jal	74fc <printf>
        exit(1);
    578e:	4505                	li	a0,1
    5790:	648010ef          	jal	6dd8 <exit>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    5794:	fe843703          	ld	a4,-24(s0)
    5798:	010007b7          	lui	a5,0x1000
    579c:	97ba                	add	a5,a5,a4
    579e:	fef43423          	sd	a5,-24(s0)
    57a2:	fe843703          	ld	a4,-24(s0)
    57a6:	fd843783          	ld	a5,-40(s0)
    57aa:	f8f761e3          	bltu	a4,a5,572c <lazy_unmap+0x82>
      }
    }
  }

  exit(0);
    57ae:	4501                	li	a0,0
    57b0:	628010ef          	jal	6dd8 <exit>

00000000000057b4 <lazy_copy>:
}

void
lazy_copy(char *s)
{
    57b4:	7119                	addi	sp,sp,-128
    57b6:	fc86                	sd	ra,120(sp)
    57b8:	f8a2                	sd	s0,112(sp)
    57ba:	0100                	addi	s0,sp,128
    57bc:	f8a43423          	sd	a0,-120(s0)
  // copyinstr on lazy page
  {
    char *p = sbrk(0);
    57c0:	4501                	li	a0,0
    57c2:	5c2010ef          	jal	6d84 <sbrk>
    57c6:	fea43023          	sd	a0,-32(s0)
    sbrklazy(4*PGSIZE);
    57ca:	6511                	lui	a0,0x4
    57cc:	5de010ef          	jal	6daa <sbrklazy>
    open(p + 8192, 0);
    57d0:	fe043703          	ld	a4,-32(s0)
    57d4:	6789                	lui	a5,0x2
    57d6:	97ba                	add	a5,a5,a4
    57d8:	4581                	li	a1,0
    57da:	853e                	mv	a0,a5
    57dc:	63c010ef          	jal	6e18 <open>
  }
  
  {
    void *xx = sbrk(0);
    57e0:	4501                	li	a0,0
    57e2:	5a2010ef          	jal	6d84 <sbrk>
    57e6:	fca43c23          	sd	a0,-40(s0)
    void *ret = sbrk(-(((uint64) xx)+1));
    57ea:	fd843783          	ld	a5,-40(s0)
    57ee:	2781                	sext.w	a5,a5
    57f0:	fff7c793          	not	a5,a5
    57f4:	2781                	sext.w	a5,a5
    57f6:	853e                	mv	a0,a5
    57f8:	58c010ef          	jal	6d84 <sbrk>
    57fc:	fca43823          	sd	a0,-48(s0)
    if(ret != xx){
    5800:	fd043703          	ld	a4,-48(s0)
    5804:	fd843783          	ld	a5,-40(s0)
    5808:	00f70d63          	beq	a4,a5,5822 <lazy_copy+0x6e>
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    580c:	fd043583          	ld	a1,-48(s0)
    5810:	00004517          	auipc	a0,0x4
    5814:	f3050513          	addi	a0,a0,-208 # 9740 <malloc+0x205c>
    5818:	4e5010ef          	jal	74fc <printf>
      exit(1);
    581c:	4505                	li	a0,1
    581e:	5ba010ef          	jal	6dd8 <exit>
    }
  }

  
  // read() and write() to these addresses should fail.
  unsigned long bad[] = {
    5822:	00004797          	auipc	a5,0x4
    5826:	fae78793          	addi	a5,a5,-82 # 97d0 <malloc+0x20ec>
    582a:	6388                	ld	a0,0(a5)
    582c:	678c                	ld	a1,8(a5)
    582e:	6b90                	ld	a2,16(a5)
    5830:	6f94                	ld	a3,24(a5)
    5832:	7398                	ld	a4,32(a5)
    5834:	779c                	ld	a5,40(a5)
    5836:	f8a43c23          	sd	a0,-104(s0)
    583a:	fab43023          	sd	a1,-96(s0)
    583e:	fac43423          	sd	a2,-88(s0)
    5842:	fad43823          	sd	a3,-80(s0)
    5846:	fae43c23          	sd	a4,-72(s0)
    584a:	fcf43023          	sd	a5,-64(s0)
    0x3fffffe000,
    0x3ffffff000,
    0x4000000000,
    0x8000000000,
  };
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    584e:	fe042623          	sw	zero,-20(s0)
    5852:	a8cd                	j	5944 <lazy_copy+0x190>
    int fd = open("README", 0);
    5854:	4581                	li	a1,0
    5856:	00002517          	auipc	a0,0x2
    585a:	0b250513          	addi	a0,a0,178 # 7908 <malloc+0x224>
    585e:	5ba010ef          	jal	6e18 <open>
    5862:	87aa                	mv	a5,a0
    5864:	fcf42623          	sw	a5,-52(s0)
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    5868:	fcc42783          	lw	a5,-52(s0)
    586c:	2781                	sext.w	a5,a5
    586e:	0007db63          	bgez	a5,5884 <lazy_copy+0xd0>
    5872:	00004517          	auipc	a0,0x4
    5876:	efe50513          	addi	a0,a0,-258 # 9770 <malloc+0x208c>
    587a:	483010ef          	jal	74fc <printf>
    587e:	4505                	li	a0,1
    5880:	558010ef          	jal	6dd8 <exit>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    5884:	fec42703          	lw	a4,-20(s0)
    5888:	f9840793          	addi	a5,s0,-104
    588c:	070e                	slli	a4,a4,0x3
    588e:	97ba                	add	a5,a5,a4
    5890:	639c                	ld	a5,0(a5)
    5892:	873e                	mv	a4,a5
    5894:	fcc42783          	lw	a5,-52(s0)
    5898:	20000613          	li	a2,512
    589c:	85ba                	mv	a1,a4
    589e:	853e                	mv	a0,a5
    58a0:	550010ef          	jal	6df0 <read>
    58a4:	87aa                	mv	a5,a0
    58a6:	0007cb63          	bltz	a5,58bc <lazy_copy+0x108>
    58aa:	00004517          	auipc	a0,0x4
    58ae:	ede50513          	addi	a0,a0,-290 # 9788 <malloc+0x20a4>
    58b2:	44b010ef          	jal	74fc <printf>
    58b6:	4505                	li	a0,1
    58b8:	520010ef          	jal	6dd8 <exit>
    close(fd);
    58bc:	fcc42783          	lw	a5,-52(s0)
    58c0:	853e                	mv	a0,a5
    58c2:	53e010ef          	jal	6e00 <close>
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    58c6:	60200593          	li	a1,1538
    58ca:	00004517          	auipc	a0,0x4
    58ce:	ece50513          	addi	a0,a0,-306 # 9798 <malloc+0x20b4>
    58d2:	546010ef          	jal	6e18 <open>
    58d6:	87aa                	mv	a5,a0
    58d8:	fcf42623          	sw	a5,-52(s0)
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    58dc:	fcc42783          	lw	a5,-52(s0)
    58e0:	2781                	sext.w	a5,a5
    58e2:	0007db63          	bgez	a5,58f8 <lazy_copy+0x144>
    58e6:	00004517          	auipc	a0,0x4
    58ea:	eba50513          	addi	a0,a0,-326 # 97a0 <malloc+0x20bc>
    58ee:	40f010ef          	jal	74fc <printf>
    58f2:	4505                	li	a0,1
    58f4:	4e4010ef          	jal	6dd8 <exit>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    58f8:	fec42703          	lw	a4,-20(s0)
    58fc:	f9840793          	addi	a5,s0,-104
    5900:	070e                	slli	a4,a4,0x3
    5902:	97ba                	add	a5,a5,a4
    5904:	639c                	ld	a5,0(a5)
    5906:	873e                	mv	a4,a5
    5908:	fcc42783          	lw	a5,-52(s0)
    590c:	20000613          	li	a2,512
    5910:	85ba                	mv	a1,a4
    5912:	853e                	mv	a0,a5
    5914:	4e4010ef          	jal	6df8 <write>
    5918:	87aa                	mv	a5,a0
    591a:	0007cb63          	bltz	a5,5930 <lazy_copy+0x17c>
    591e:	00004517          	auipc	a0,0x4
    5922:	e9a50513          	addi	a0,a0,-358 # 97b8 <malloc+0x20d4>
    5926:	3d7010ef          	jal	74fc <printf>
    592a:	4505                	li	a0,1
    592c:	4ac010ef          	jal	6dd8 <exit>
    close(fd);
    5930:	fcc42783          	lw	a5,-52(s0)
    5934:	853e                	mv	a0,a5
    5936:	4ca010ef          	jal	6e00 <close>
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    593a:	fec42783          	lw	a5,-20(s0)
    593e:	2785                	addiw	a5,a5,1
    5940:	fef42623          	sw	a5,-20(s0)
    5944:	fec42703          	lw	a4,-20(s0)
    5948:	4795                	li	a5,5
    594a:	f0e7f5e3          	bgeu	a5,a4,5854 <lazy_copy+0xa0>
  }

  exit(0);
    594e:	4501                	li	a0,0
    5950:	488010ef          	jal	6dd8 <exit>

0000000000005954 <lazy_sbrk>:
}

void
lazy_sbrk(char *s)
{
    5954:	7139                	addi	sp,sp,-64
    5956:	fc06                	sd	ra,56(sp)
    5958:	f822                	sd	s0,48(sp)
    595a:	0080                	addi	s0,sp,64
    595c:	fca43423          	sd	a0,-56(s0)
  // sbrk() takes just int, so take 2^30-sized steps towards MAXVA
  char *p = sbrk(0);
    5960:	4501                	li	a0,0
    5962:	422010ef          	jal	6d84 <sbrk>
    5966:	fea43423          	sd	a0,-24(s0)
  while ((uint64)p < MAXVA-(1<<30)) {
    596a:	a821                	j	5982 <lazy_sbrk+0x2e>
    p = sbrklazy(1<<30);
    596c:	40000537          	lui	a0,0x40000
    5970:	43a010ef          	jal	6daa <sbrklazy>
    5974:	fea43423          	sd	a0,-24(s0)
    if (p < 0) {
      printf("sbrklazy(%d) returned %p\n", 1<<30, p);
      exit(1);
    }

    p = sbrklazy(0);
    5978:	4501                	li	a0,0
    597a:	430010ef          	jal	6daa <sbrklazy>
    597e:	fea43423          	sd	a0,-24(s0)
  while ((uint64)p < MAXVA-(1<<30)) {
    5982:	fe843703          	ld	a4,-24(s0)
    5986:	0ff00793          	li	a5,255
    598a:	07fa                	slli	a5,a5,0x1e
    598c:	fef760e3          	bltu	a4,a5,596c <lazy_sbrk+0x18>
  }

  int n = TRAPFRAME-PGSIZE-(uint64)p;
    5990:	fe843783          	ld	a5,-24(s0)
    5994:	2781                	sext.w	a5,a5
    5996:	7775                	lui	a4,0xffffd
    5998:	40f707bb          	subw	a5,a4,a5
    599c:	2781                	sext.w	a5,a5
    599e:	fef42223          	sw	a5,-28(s0)

  char *p1 = sbrklazy(n);
    59a2:	fe442783          	lw	a5,-28(s0)
    59a6:	853e                	mv	a0,a5
    59a8:	402010ef          	jal	6daa <sbrklazy>
    59ac:	fca43c23          	sd	a0,-40(s0)
  if (p1 < 0 || p1 != p) {
    59b0:	fd843703          	ld	a4,-40(s0)
    59b4:	fe843783          	ld	a5,-24(s0)
    59b8:	02f70263          	beq	a4,a5,59dc <lazy_sbrk+0x88>
    printf("sbrklazy(%d) returned %p, not expected %p\n", n, p1, p);
    59bc:	fe442783          	lw	a5,-28(s0)
    59c0:	fe843683          	ld	a3,-24(s0)
    59c4:	fd843603          	ld	a2,-40(s0)
    59c8:	85be                	mv	a1,a5
    59ca:	00004517          	auipc	a0,0x4
    59ce:	e3650513          	addi	a0,a0,-458 # 9800 <malloc+0x211c>
    59d2:	32b010ef          	jal	74fc <printf>
    exit(1);
    59d6:	4505                	li	a0,1
    59d8:	400010ef          	jal	6dd8 <exit>
  }

  p = sbrk(PGSIZE);
    59dc:	6505                	lui	a0,0x1
    59de:	3a6010ef          	jal	6d84 <sbrk>
    59e2:	fea43423          	sd	a0,-24(s0)
  if (p < 0 || (uint64)p != TRAPFRAME-PGSIZE) {
    59e6:	fe843703          	ld	a4,-24(s0)
    59ea:	040007b7          	lui	a5,0x4000
    59ee:	17f5                	addi	a5,a5,-3 # 3fffffd <freep+0x3fef325>
    59f0:	07b2                	slli	a5,a5,0xc
    59f2:	00f70e63          	beq	a4,a5,5a0e <lazy_sbrk+0xba>
    printf("sbrk(%d) returned %p, not expected TRAPFRAME-PGSIZE\n", PGSIZE, p);
    59f6:	fe843603          	ld	a2,-24(s0)
    59fa:	6585                	lui	a1,0x1
    59fc:	00004517          	auipc	a0,0x4
    5a00:	e3450513          	addi	a0,a0,-460 # 9830 <malloc+0x214c>
    5a04:	2f9010ef          	jal	74fc <printf>
    exit(1);
    5a08:	4505                	li	a0,1
    5a0a:	3ce010ef          	jal	6dd8 <exit>
  }

  p[0] = 1;
    5a0e:	fe843783          	ld	a5,-24(s0)
    5a12:	4705                	li	a4,1
    5a14:	00e78023          	sb	a4,0(a5)
  if (p[1] != 0) {
    5a18:	fe843783          	ld	a5,-24(s0)
    5a1c:	0785                	addi	a5,a5,1
    5a1e:	0007c783          	lbu	a5,0(a5)
    5a22:	cb91                	beqz	a5,5a36 <lazy_sbrk+0xe2>
    printf("sbrk() returned non-zero-filled memory\n");
    5a24:	00004517          	auipc	a0,0x4
    5a28:	e4450513          	addi	a0,a0,-444 # 9868 <malloc+0x2184>
    5a2c:	2d1010ef          	jal	74fc <printf>
    exit(1);
    5a30:	4505                	li	a0,1
    5a32:	3a6010ef          	jal	6dd8 <exit>
  }

  p = sbrk(1);
    5a36:	4505                	li	a0,1
    5a38:	34c010ef          	jal	6d84 <sbrk>
    5a3c:	fea43423          	sd	a0,-24(s0)
  if ((uint64)p != -1) {
    5a40:	fe843703          	ld	a4,-24(s0)
    5a44:	57fd                	li	a5,-1
    5a46:	00f70d63          	beq	a4,a5,5a60 <lazy_sbrk+0x10c>
    printf("sbrk(1) returned %p, expected error\n", p);
    5a4a:	fe843583          	ld	a1,-24(s0)
    5a4e:	00004517          	auipc	a0,0x4
    5a52:	e4250513          	addi	a0,a0,-446 # 9890 <malloc+0x21ac>
    5a56:	2a7010ef          	jal	74fc <printf>
    exit(1);
    5a5a:	4505                	li	a0,1
    5a5c:	37c010ef          	jal	6dd8 <exit>
  }

  p = sbrklazy(1);
    5a60:	4505                	li	a0,1
    5a62:	348010ef          	jal	6daa <sbrklazy>
    5a66:	fea43423          	sd	a0,-24(s0)
  if ((uint64)p != -1) {
    5a6a:	fe843703          	ld	a4,-24(s0)
    5a6e:	57fd                	li	a5,-1
    5a70:	00f70d63          	beq	a4,a5,5a8a <lazy_sbrk+0x136>
    printf("sbrklazy(1) returned %p, expected error\n", p);
    5a74:	fe843583          	ld	a1,-24(s0)
    5a78:	00004517          	auipc	a0,0x4
    5a7c:	e4050513          	addi	a0,a0,-448 # 98b8 <malloc+0x21d4>
    5a80:	27d010ef          	jal	74fc <printf>
    exit(1);
    5a84:	4505                	li	a0,1
    5a86:	352010ef          	jal	6dd8 <exit>
  }

  exit(0);
    5a8a:	4501                	li	a0,0
    5a8c:	34c010ef          	jal	6dd8 <exit>

0000000000005a90 <bigdir>:
//

// directory that uses indirect blocks
void
bigdir(char *s)
{
    5a90:	7139                	addi	sp,sp,-64
    5a92:	fc06                	sd	ra,56(sp)
    5a94:	f822                	sd	s0,48(sp)
    5a96:	0080                	addi	s0,sp,64
    5a98:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    5a9c:	00004517          	auipc	a0,0x4
    5aa0:	17450513          	addi	a0,a0,372 # 9c10 <malloc+0x252c>
    5aa4:	384010ef          	jal	6e28 <unlink>

  fd = open("bd", O_CREATE);
    5aa8:	20000593          	li	a1,512
    5aac:	00004517          	auipc	a0,0x4
    5ab0:	16450513          	addi	a0,a0,356 # 9c10 <malloc+0x252c>
    5ab4:	364010ef          	jal	6e18 <open>
    5ab8:	87aa                	mv	a5,a0
    5aba:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    5abe:	fe842783          	lw	a5,-24(s0)
    5ac2:	2781                	sext.w	a5,a5
    5ac4:	0007dd63          	bgez	a5,5ade <bigdir+0x4e>
    printf("%s: bigdir create failed\n", s);
    5ac8:	fc843583          	ld	a1,-56(s0)
    5acc:	00004517          	auipc	a0,0x4
    5ad0:	14c50513          	addi	a0,a0,332 # 9c18 <malloc+0x2534>
    5ad4:	229010ef          	jal	74fc <printf>
    exit(1);
    5ad8:	4505                	li	a0,1
    5ada:	2fe010ef          	jal	6dd8 <exit>
  }
  close(fd);
    5ade:	fe842783          	lw	a5,-24(s0)
    5ae2:	853e                	mv	a0,a5
    5ae4:	31c010ef          	jal	6e00 <close>

  for(i = 0; i < N; i++){
    5ae8:	fe042623          	sw	zero,-20(s0)
    5aec:	a879                	j	5b8a <bigdir+0xfa>
    name[0] = 'x';
    5aee:	07800793          	li	a5,120
    5af2:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    5af6:	fec42783          	lw	a5,-20(s0)
    5afa:	41f7d71b          	sraiw	a4,a5,0x1f
    5afe:	01a7571b          	srliw	a4,a4,0x1a
    5b02:	9fb9                	addw	a5,a5,a4
    5b04:	4067d79b          	sraiw	a5,a5,0x6
    5b08:	2781                	sext.w	a5,a5
    5b0a:	0ff7f793          	zext.b	a5,a5
    5b0e:	0307879b          	addiw	a5,a5,48
    5b12:	0ff7f793          	zext.b	a5,a5
    5b16:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    5b1a:	fec42783          	lw	a5,-20(s0)
    5b1e:	873e                	mv	a4,a5
    5b20:	41f7579b          	sraiw	a5,a4,0x1f
    5b24:	01a7d79b          	srliw	a5,a5,0x1a
    5b28:	9f3d                	addw	a4,a4,a5
    5b2a:	03f77713          	andi	a4,a4,63
    5b2e:	40f707bb          	subw	a5,a4,a5
    5b32:	2781                	sext.w	a5,a5
    5b34:	0ff7f793          	zext.b	a5,a5
    5b38:	0307879b          	addiw	a5,a5,48
    5b3c:	0ff7f793          	zext.b	a5,a5
    5b40:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    5b44:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    5b48:	fd840793          	addi	a5,s0,-40
    5b4c:	85be                	mv	a1,a5
    5b4e:	00004517          	auipc	a0,0x4
    5b52:	0c250513          	addi	a0,a0,194 # 9c10 <malloc+0x252c>
    5b56:	2e2010ef          	jal	6e38 <link>
    5b5a:	87aa                	mv	a5,a0
    5b5c:	c395                	beqz	a5,5b80 <bigdir+0xf0>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    5b5e:	fd840713          	addi	a4,s0,-40
    5b62:	fec42783          	lw	a5,-20(s0)
    5b66:	86ba                	mv	a3,a4
    5b68:	863e                	mv	a2,a5
    5b6a:	fc843583          	ld	a1,-56(s0)
    5b6e:	00004517          	auipc	a0,0x4
    5b72:	0ca50513          	addi	a0,a0,202 # 9c38 <malloc+0x2554>
    5b76:	187010ef          	jal	74fc <printf>
      exit(1);
    5b7a:	4505                	li	a0,1
    5b7c:	25c010ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    5b80:	fec42783          	lw	a5,-20(s0)
    5b84:	2785                	addiw	a5,a5,1
    5b86:	fef42623          	sw	a5,-20(s0)
    5b8a:	fec42783          	lw	a5,-20(s0)
    5b8e:	0007871b          	sext.w	a4,a5
    5b92:	1f300793          	li	a5,499
    5b96:	f4e7dce3          	bge	a5,a4,5aee <bigdir+0x5e>
    }
  }

  unlink("bd");
    5b9a:	00004517          	auipc	a0,0x4
    5b9e:	07650513          	addi	a0,a0,118 # 9c10 <malloc+0x252c>
    5ba2:	286010ef          	jal	6e28 <unlink>
  for(i = 0; i < N; i++){
    5ba6:	fe042623          	sw	zero,-20(s0)
    5baa:	a069                	j	5c34 <bigdir+0x1a4>
    name[0] = 'x';
    5bac:	07800793          	li	a5,120
    5bb0:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    5bb4:	fec42783          	lw	a5,-20(s0)
    5bb8:	41f7d71b          	sraiw	a4,a5,0x1f
    5bbc:	01a7571b          	srliw	a4,a4,0x1a
    5bc0:	9fb9                	addw	a5,a5,a4
    5bc2:	4067d79b          	sraiw	a5,a5,0x6
    5bc6:	2781                	sext.w	a5,a5
    5bc8:	0ff7f793          	zext.b	a5,a5
    5bcc:	0307879b          	addiw	a5,a5,48
    5bd0:	0ff7f793          	zext.b	a5,a5
    5bd4:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    5bd8:	fec42783          	lw	a5,-20(s0)
    5bdc:	873e                	mv	a4,a5
    5bde:	41f7579b          	sraiw	a5,a4,0x1f
    5be2:	01a7d79b          	srliw	a5,a5,0x1a
    5be6:	9f3d                	addw	a4,a4,a5
    5be8:	03f77713          	andi	a4,a4,63
    5bec:	40f707bb          	subw	a5,a4,a5
    5bf0:	2781                	sext.w	a5,a5
    5bf2:	0ff7f793          	zext.b	a5,a5
    5bf6:	0307879b          	addiw	a5,a5,48
    5bfa:	0ff7f793          	zext.b	a5,a5
    5bfe:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    5c02:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    5c06:	fd840793          	addi	a5,s0,-40
    5c0a:	853e                	mv	a0,a5
    5c0c:	21c010ef          	jal	6e28 <unlink>
    5c10:	87aa                	mv	a5,a0
    5c12:	cf81                	beqz	a5,5c2a <bigdir+0x19a>
      printf("%s: bigdir unlink failed", s);
    5c14:	fc843583          	ld	a1,-56(s0)
    5c18:	00004517          	auipc	a0,0x4
    5c1c:	04850513          	addi	a0,a0,72 # 9c60 <malloc+0x257c>
    5c20:	0dd010ef          	jal	74fc <printf>
      exit(1);
    5c24:	4505                	li	a0,1
    5c26:	1b2010ef          	jal	6dd8 <exit>
  for(i = 0; i < N; i++){
    5c2a:	fec42783          	lw	a5,-20(s0)
    5c2e:	2785                	addiw	a5,a5,1
    5c30:	fef42623          	sw	a5,-20(s0)
    5c34:	fec42783          	lw	a5,-20(s0)
    5c38:	0007871b          	sext.w	a4,a5
    5c3c:	1f300793          	li	a5,499
    5c40:	f6e7d6e3          	bge	a5,a4,5bac <bigdir+0x11c>
    }
  }
}
    5c44:	0001                	nop
    5c46:	0001                	nop
    5c48:	70e2                	ld	ra,56(sp)
    5c4a:	7442                	ld	s0,48(sp)
    5c4c:	6121                	addi	sp,sp,64
    5c4e:	8082                	ret

0000000000005c50 <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    5c50:	711d                	addi	sp,sp,-96
    5c52:	ec86                	sd	ra,88(sp)
    5c54:	e8a2                	sd	s0,80(sp)
    5c56:	1080                	addi	s0,sp,96
    5c58:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    5c5c:	4791                	li	a5,4
    5c5e:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    5c62:	47f9                	li	a5,30
    5c64:	fcf42c23          	sw	a5,-40(s0)
  
  for(int ci = 0; ci < nchildren; ci++){
    5c68:	fe042623          	sw	zero,-20(s0)
    5c6c:	a285                	j	5dcc <manywrites+0x17c>
    int pid = fork();
    5c6e:	162010ef          	jal	6dd0 <fork>
    5c72:	87aa                	mv	a5,a0
    5c74:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    5c78:	fd442783          	lw	a5,-44(s0)
    5c7c:	2781                	sext.w	a5,a5
    5c7e:	0007db63          	bgez	a5,5c94 <manywrites+0x44>
      printf("fork failed\n");
    5c82:	00002517          	auipc	a0,0x2
    5c86:	e0650513          	addi	a0,a0,-506 # 7a88 <malloc+0x3a4>
    5c8a:	073010ef          	jal	74fc <printf>
      exit(1);
    5c8e:	4505                	li	a0,1
    5c90:	148010ef          	jal	6dd8 <exit>
    }

    if(pid == 0){
    5c94:	fd442783          	lw	a5,-44(s0)
    5c98:	2781                	sext.w	a5,a5
    5c9a:	12079463          	bnez	a5,5dc2 <manywrites+0x172>
      char name[3];
      name[0] = 'b';
    5c9e:	06200793          	li	a5,98
    5ca2:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    5ca6:	fec42783          	lw	a5,-20(s0)
    5caa:	0ff7f793          	zext.b	a5,a5
    5cae:	0617879b          	addiw	a5,a5,97
    5cb2:	0ff7f793          	zext.b	a5,a5
    5cb6:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    5cba:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    5cbe:	fc040793          	addi	a5,s0,-64
    5cc2:	853e                	mv	a0,a5
    5cc4:	164010ef          	jal	6e28 <unlink>
      
      for(int iters = 0; iters < howmany; iters++){
    5cc8:	fe042423          	sw	zero,-24(s0)
    5ccc:	a8d1                	j	5da0 <manywrites+0x150>
        for(int i = 0; i < ci+1; i++){
    5cce:	fe042223          	sw	zero,-28(s0)
    5cd2:	a065                	j	5d7a <manywrites+0x12a>
          int fd = open(name, O_CREATE | O_RDWR);
    5cd4:	fc040793          	addi	a5,s0,-64
    5cd8:	20200593          	li	a1,514
    5cdc:	853e                	mv	a0,a5
    5cde:	13a010ef          	jal	6e18 <open>
    5ce2:	87aa                	mv	a5,a0
    5ce4:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    5ce8:	fd042783          	lw	a5,-48(s0)
    5cec:	2781                	sext.w	a5,a5
    5cee:	0207d063          	bgez	a5,5d0e <manywrites+0xbe>
            printf("%s: cannot create %s\n", s, name);
    5cf2:	fc040793          	addi	a5,s0,-64
    5cf6:	863e                	mv	a2,a5
    5cf8:	fa843583          	ld	a1,-88(s0)
    5cfc:	00004517          	auipc	a0,0x4
    5d00:	f8450513          	addi	a0,a0,-124 # 9c80 <malloc+0x259c>
    5d04:	7f8010ef          	jal	74fc <printf>
            exit(1);
    5d08:	4505                	li	a0,1
    5d0a:	0ce010ef          	jal	6dd8 <exit>
          }
          int sz = sizeof(buf);
    5d0e:	678d                	lui	a5,0x3
    5d10:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    5d14:	fcc42703          	lw	a4,-52(s0)
    5d18:	fd042783          	lw	a5,-48(s0)
    5d1c:	863a                	mv	a2,a4
    5d1e:	00004597          	auipc	a1,0x4
    5d22:	79258593          	addi	a1,a1,1938 # a4b0 <buf>
    5d26:	853e                	mv	a0,a5
    5d28:	0d0010ef          	jal	6df8 <write>
    5d2c:	87aa                	mv	a5,a0
    5d2e:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    5d32:	fc842783          	lw	a5,-56(s0)
    5d36:	873e                	mv	a4,a5
    5d38:	fcc42783          	lw	a5,-52(s0)
    5d3c:	2701                	sext.w	a4,a4
    5d3e:	2781                	sext.w	a5,a5
    5d40:	02f70363          	beq	a4,a5,5d66 <manywrites+0x116>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    5d44:	fc842703          	lw	a4,-56(s0)
    5d48:	fcc42783          	lw	a5,-52(s0)
    5d4c:	86ba                	mv	a3,a4
    5d4e:	863e                	mv	a2,a5
    5d50:	fa843583          	ld	a1,-88(s0)
    5d54:	00003517          	auipc	a0,0x3
    5d58:	f6450513          	addi	a0,a0,-156 # 8cb8 <malloc+0x15d4>
    5d5c:	7a0010ef          	jal	74fc <printf>
            exit(1);
    5d60:	4505                	li	a0,1
    5d62:	076010ef          	jal	6dd8 <exit>
          }
          close(fd);
    5d66:	fd042783          	lw	a5,-48(s0)
    5d6a:	853e                	mv	a0,a5
    5d6c:	094010ef          	jal	6e00 <close>
        for(int i = 0; i < ci+1; i++){
    5d70:	fe442783          	lw	a5,-28(s0)
    5d74:	2785                	addiw	a5,a5,1 # 3001 <concreate+0x2d3>
    5d76:	fef42223          	sw	a5,-28(s0)
    5d7a:	fec42783          	lw	a5,-20(s0)
    5d7e:	873e                	mv	a4,a5
    5d80:	fe442783          	lw	a5,-28(s0)
    5d84:	2701                	sext.w	a4,a4
    5d86:	2781                	sext.w	a5,a5
    5d88:	f4f756e3          	bge	a4,a5,5cd4 <manywrites+0x84>
        }
        unlink(name);
    5d8c:	fc040793          	addi	a5,s0,-64
    5d90:	853e                	mv	a0,a5
    5d92:	096010ef          	jal	6e28 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    5d96:	fe842783          	lw	a5,-24(s0)
    5d9a:	2785                	addiw	a5,a5,1
    5d9c:	fef42423          	sw	a5,-24(s0)
    5da0:	fe842783          	lw	a5,-24(s0)
    5da4:	873e                	mv	a4,a5
    5da6:	fd842783          	lw	a5,-40(s0)
    5daa:	2701                	sext.w	a4,a4
    5dac:	2781                	sext.w	a5,a5
    5dae:	f2f740e3          	blt	a4,a5,5cce <manywrites+0x7e>
      }

      unlink(name);
    5db2:	fc040793          	addi	a5,s0,-64
    5db6:	853e                	mv	a0,a5
    5db8:	070010ef          	jal	6e28 <unlink>
      exit(0);
    5dbc:	4501                	li	a0,0
    5dbe:	01a010ef          	jal	6dd8 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    5dc2:	fec42783          	lw	a5,-20(s0)
    5dc6:	2785                	addiw	a5,a5,1
    5dc8:	fef42623          	sw	a5,-20(s0)
    5dcc:	fec42783          	lw	a5,-20(s0)
    5dd0:	873e                	mv	a4,a5
    5dd2:	fdc42783          	lw	a5,-36(s0)
    5dd6:	2701                	sext.w	a4,a4
    5dd8:	2781                	sext.w	a5,a5
    5dda:	e8f74ae3          	blt	a4,a5,5c6e <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    5dde:	fe042023          	sw	zero,-32(s0)
    5de2:	a02d                	j	5e0c <manywrites+0x1bc>
    int st = 0;
    5de4:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    5de8:	fbc40793          	addi	a5,s0,-68
    5dec:	853e                	mv	a0,a5
    5dee:	7f3000ef          	jal	6de0 <wait>
    if(st != 0)
    5df2:	fbc42783          	lw	a5,-68(s0)
    5df6:	c791                	beqz	a5,5e02 <manywrites+0x1b2>
      exit(st);
    5df8:	fbc42783          	lw	a5,-68(s0)
    5dfc:	853e                	mv	a0,a5
    5dfe:	7db000ef          	jal	6dd8 <exit>
  for(int ci = 0; ci < nchildren; ci++){
    5e02:	fe042783          	lw	a5,-32(s0)
    5e06:	2785                	addiw	a5,a5,1
    5e08:	fef42023          	sw	a5,-32(s0)
    5e0c:	fe042783          	lw	a5,-32(s0)
    5e10:	873e                	mv	a4,a5
    5e12:	fdc42783          	lw	a5,-36(s0)
    5e16:	2701                	sext.w	a4,a4
    5e18:	2781                	sext.w	a5,a5
    5e1a:	fcf745e3          	blt	a4,a5,5de4 <manywrites+0x194>
  }
  exit(0);
    5e1e:	4501                	li	a0,0
    5e20:	7b9000ef          	jal	6dd8 <exit>

0000000000005e24 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    5e24:	7179                	addi	sp,sp,-48
    5e26:	f406                	sd	ra,40(sp)
    5e28:	f022                	sd	s0,32(sp)
    5e2a:	1800                	addi	s0,sp,48
    5e2c:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    5e30:	25800793          	li	a5,600
    5e34:	fef42423          	sw	a5,-24(s0)
  
  unlink("junk");
    5e38:	00004517          	auipc	a0,0x4
    5e3c:	96050513          	addi	a0,a0,-1696 # 9798 <malloc+0x20b4>
    5e40:	7e9000ef          	jal	6e28 <unlink>
  for(int i = 0; i < assumed_free; i++){
    5e44:	fe042623          	sw	zero,-20(s0)
    5e48:	a09d                	j	5eae <badwrite+0x8a>
    int fd = open("junk", O_CREATE|O_WRONLY);
    5e4a:	20100593          	li	a1,513
    5e4e:	00004517          	auipc	a0,0x4
    5e52:	94a50513          	addi	a0,a0,-1718 # 9798 <malloc+0x20b4>
    5e56:	7c3000ef          	jal	6e18 <open>
    5e5a:	87aa                	mv	a5,a0
    5e5c:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    5e60:	fe042783          	lw	a5,-32(s0)
    5e64:	2781                	sext.w	a5,a5
    5e66:	0007db63          	bgez	a5,5e7c <badwrite+0x58>
      printf("open junk failed\n");
    5e6a:	00004517          	auipc	a0,0x4
    5e6e:	e2e50513          	addi	a0,a0,-466 # 9c98 <malloc+0x25b4>
    5e72:	68a010ef          	jal	74fc <printf>
      exit(1);
    5e76:	4505                	li	a0,1
    5e78:	761000ef          	jal	6dd8 <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    5e7c:	fe042703          	lw	a4,-32(s0)
    5e80:	4605                	li	a2,1
    5e82:	57fd                	li	a5,-1
    5e84:	0187d593          	srli	a1,a5,0x18
    5e88:	853a                	mv	a0,a4
    5e8a:	76f000ef          	jal	6df8 <write>
    close(fd);
    5e8e:	fe042783          	lw	a5,-32(s0)
    5e92:	853e                	mv	a0,a5
    5e94:	76d000ef          	jal	6e00 <close>
    unlink("junk");
    5e98:	00004517          	auipc	a0,0x4
    5e9c:	90050513          	addi	a0,a0,-1792 # 9798 <malloc+0x20b4>
    5ea0:	789000ef          	jal	6e28 <unlink>
  for(int i = 0; i < assumed_free; i++){
    5ea4:	fec42783          	lw	a5,-20(s0)
    5ea8:	2785                	addiw	a5,a5,1
    5eaa:	fef42623          	sw	a5,-20(s0)
    5eae:	fec42783          	lw	a5,-20(s0)
    5eb2:	873e                	mv	a4,a5
    5eb4:	fe842783          	lw	a5,-24(s0)
    5eb8:	2701                	sext.w	a4,a4
    5eba:	2781                	sext.w	a5,a5
    5ebc:	f8f747e3          	blt	a4,a5,5e4a <badwrite+0x26>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    5ec0:	20100593          	li	a1,513
    5ec4:	00004517          	auipc	a0,0x4
    5ec8:	8d450513          	addi	a0,a0,-1836 # 9798 <malloc+0x20b4>
    5ecc:	74d000ef          	jal	6e18 <open>
    5ed0:	87aa                	mv	a5,a0
    5ed2:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    5ed6:	fe442783          	lw	a5,-28(s0)
    5eda:	2781                	sext.w	a5,a5
    5edc:	0007db63          	bgez	a5,5ef2 <badwrite+0xce>
    printf("open junk failed\n");
    5ee0:	00004517          	auipc	a0,0x4
    5ee4:	db850513          	addi	a0,a0,-584 # 9c98 <malloc+0x25b4>
    5ee8:	614010ef          	jal	74fc <printf>
    exit(1);
    5eec:	4505                	li	a0,1
    5eee:	6eb000ef          	jal	6dd8 <exit>
  }
  if(write(fd, "x", 1) != 1){
    5ef2:	fe442783          	lw	a5,-28(s0)
    5ef6:	4605                	li	a2,1
    5ef8:	00002597          	auipc	a1,0x2
    5efc:	a6058593          	addi	a1,a1,-1440 # 7958 <malloc+0x274>
    5f00:	853e                	mv	a0,a5
    5f02:	6f7000ef          	jal	6df8 <write>
    5f06:	87aa                	mv	a5,a0
    5f08:	873e                	mv	a4,a5
    5f0a:	4785                	li	a5,1
    5f0c:	00f70b63          	beq	a4,a5,5f22 <badwrite+0xfe>
    printf("write failed\n");
    5f10:	00004517          	auipc	a0,0x4
    5f14:	da050513          	addi	a0,a0,-608 # 9cb0 <malloc+0x25cc>
    5f18:	5e4010ef          	jal	74fc <printf>
    exit(1);
    5f1c:	4505                	li	a0,1
    5f1e:	6bb000ef          	jal	6dd8 <exit>
  }
  close(fd);
    5f22:	fe442783          	lw	a5,-28(s0)
    5f26:	853e                	mv	a0,a5
    5f28:	6d9000ef          	jal	6e00 <close>
  unlink("junk");
    5f2c:	00004517          	auipc	a0,0x4
    5f30:	86c50513          	addi	a0,a0,-1940 # 9798 <malloc+0x20b4>
    5f34:	6f5000ef          	jal	6e28 <unlink>

  exit(0);
    5f38:	4501                	li	a0,0
    5f3a:	69f000ef          	jal	6dd8 <exit>

0000000000005f3e <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    5f3e:	715d                	addi	sp,sp,-80
    5f40:	e486                	sd	ra,72(sp)
    5f42:	e0a2                	sd	s0,64(sp)
    5f44:	0880                	addi	s0,sp,80
    5f46:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    5f4a:	fe042623          	sw	zero,-20(s0)
    5f4e:	a0e9                	j	6018 <execout+0xda>
    int pid = fork();
    5f50:	681000ef          	jal	6dd0 <fork>
    5f54:	87aa                	mv	a5,a0
    5f56:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    5f5a:	fe442783          	lw	a5,-28(s0)
    5f5e:	2781                	sext.w	a5,a5
    5f60:	0007db63          	bgez	a5,5f76 <execout+0x38>
      printf("fork failed\n");
    5f64:	00002517          	auipc	a0,0x2
    5f68:	b2450513          	addi	a0,a0,-1244 # 7a88 <malloc+0x3a4>
    5f6c:	590010ef          	jal	74fc <printf>
      exit(1);
    5f70:	4505                	li	a0,1
    5f72:	667000ef          	jal	6dd8 <exit>
    } else if(pid == 0){
    5f76:	fe442783          	lw	a5,-28(s0)
    5f7a:	2781                	sext.w	a5,a5
    5f7c:	e7d1                	bnez	a5,6008 <execout+0xca>
      // allocate all of memory.
      while(1){
        char *a = sbrk(PGSIZE);
    5f7e:	6505                	lui	a0,0x1
    5f80:	605000ef          	jal	6d84 <sbrk>
    5f84:	fca43c23          	sd	a0,-40(s0)
        if(a == SBRK_ERROR)
    5f88:	fd843703          	ld	a4,-40(s0)
    5f8c:	57fd                	li	a5,-1
    5f8e:	00f70b63          	beq	a4,a5,5fa4 <execout+0x66>
          break;
        *(a + PGSIZE - 1) = 1;
    5f92:	fd843703          	ld	a4,-40(s0)
    5f96:	6785                	lui	a5,0x1
    5f98:	17fd                	addi	a5,a5,-1 # fff <openiputtest+0x13>
    5f9a:	97ba                	add	a5,a5,a4
    5f9c:	4705                	li	a4,1
    5f9e:	00e78023          	sb	a4,0(a5)
      while(1){
    5fa2:	bff1                	j	5f7e <execout+0x40>
          break;
    5fa4:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    5fa6:	fe042423          	sw	zero,-24(s0)
    5faa:	a809                	j	5fbc <execout+0x7e>
        sbrk(-PGSIZE);
    5fac:	757d                	lui	a0,0xfffff
    5fae:	5d7000ef          	jal	6d84 <sbrk>
      for(int i = 0; i < avail; i++)
    5fb2:	fe842783          	lw	a5,-24(s0)
    5fb6:	2785                	addiw	a5,a5,1
    5fb8:	fef42423          	sw	a5,-24(s0)
    5fbc:	fe842783          	lw	a5,-24(s0)
    5fc0:	873e                	mv	a4,a5
    5fc2:	fec42783          	lw	a5,-20(s0)
    5fc6:	2701                	sext.w	a4,a4
    5fc8:	2781                	sext.w	a5,a5
    5fca:	fef741e3          	blt	a4,a5,5fac <execout+0x6e>
      
      close(1);
    5fce:	4505                	li	a0,1
    5fd0:	631000ef          	jal	6e00 <close>
      char *args[] = { "echo", "x", 0 };
    5fd4:	00002797          	auipc	a5,0x2
    5fd8:	ac478793          	addi	a5,a5,-1340 # 7a98 <malloc+0x3b4>
    5fdc:	fcf43023          	sd	a5,-64(s0)
    5fe0:	00002797          	auipc	a5,0x2
    5fe4:	97878793          	addi	a5,a5,-1672 # 7958 <malloc+0x274>
    5fe8:	fcf43423          	sd	a5,-56(s0)
    5fec:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    5ff0:	fc040793          	addi	a5,s0,-64
    5ff4:	85be                	mv	a1,a5
    5ff6:	00002517          	auipc	a0,0x2
    5ffa:	aa250513          	addi	a0,a0,-1374 # 7a98 <malloc+0x3b4>
    5ffe:	613000ef          	jal	6e10 <exec>
      exit(0);
    6002:	4501                	li	a0,0
    6004:	5d5000ef          	jal	6dd8 <exit>
    } else {
      wait((int*)0);
    6008:	4501                	li	a0,0
    600a:	5d7000ef          	jal	6de0 <wait>
  for(int avail = 0; avail < 15; avail++){
    600e:	fec42783          	lw	a5,-20(s0)
    6012:	2785                	addiw	a5,a5,1
    6014:	fef42623          	sw	a5,-20(s0)
    6018:	fec42783          	lw	a5,-20(s0)
    601c:	0007871b          	sext.w	a4,a5
    6020:	47b9                	li	a5,14
    6022:	f2e7d7e3          	bge	a5,a4,5f50 <execout+0x12>
    }
  }

  exit(0);
    6026:	4501                	li	a0,0
    6028:	5b1000ef          	jal	6dd8 <exit>

000000000000602c <diskfull>:
}

// can the kernel tolerate running out of disk space?
void
diskfull(char *s)
{
    602c:	b9010113          	addi	sp,sp,-1136
    6030:	46113423          	sd	ra,1128(sp)
    6034:	46813023          	sd	s0,1120(sp)
    6038:	47010413          	addi	s0,sp,1136
    603c:	b8a43c23          	sd	a0,-1128(s0)
  int fi;
  int done = 0;
    6040:	fe042423          	sw	zero,-24(s0)

  unlink("diskfulldir");
    6044:	00004517          	auipc	a0,0x4
    6048:	c7c50513          	addi	a0,a0,-900 # 9cc0 <malloc+0x25dc>
    604c:	5dd000ef          	jal	6e28 <unlink>
  
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    6050:	fe042623          	sw	zero,-20(s0)
    6054:	a8e9                	j	612e <diskfull+0x102>
    char name[32];
    name[0] = 'b';
    6056:	06200793          	li	a5,98
    605a:	baf40423          	sb	a5,-1112(s0)
    name[1] = 'i';
    605e:	06900793          	li	a5,105
    6062:	baf404a3          	sb	a5,-1111(s0)
    name[2] = 'g';
    6066:	06700793          	li	a5,103
    606a:	baf40523          	sb	a5,-1110(s0)
    name[3] = '0' + fi;
    606e:	fec42783          	lw	a5,-20(s0)
    6072:	0ff7f793          	zext.b	a5,a5
    6076:	0307879b          	addiw	a5,a5,48
    607a:	0ff7f793          	zext.b	a5,a5
    607e:	baf405a3          	sb	a5,-1109(s0)
    name[4] = '\0';
    6082:	ba040623          	sb	zero,-1108(s0)
    unlink(name);
    6086:	ba840793          	addi	a5,s0,-1112
    608a:	853e                	mv	a0,a5
    608c:	59d000ef          	jal	6e28 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6090:	ba840793          	addi	a5,s0,-1112
    6094:	60200593          	li	a1,1538
    6098:	853e                	mv	a0,a5
    609a:	57f000ef          	jal	6e18 <open>
    609e:	87aa                	mv	a5,a0
    60a0:	fcf42a23          	sw	a5,-44(s0)
    if(fd < 0){
    60a4:	fd442783          	lw	a5,-44(s0)
    60a8:	2781                	sext.w	a5,a5
    60aa:	0207d163          	bgez	a5,60cc <diskfull+0xa0>
      // oops, ran out of inodes before running out of blocks.
      printf("%s: could not create file %s\n", s, name);
    60ae:	ba840793          	addi	a5,s0,-1112
    60b2:	863e                	mv	a2,a5
    60b4:	b9843583          	ld	a1,-1128(s0)
    60b8:	00004517          	auipc	a0,0x4
    60bc:	c1850513          	addi	a0,a0,-1000 # 9cd0 <malloc+0x25ec>
    60c0:	43c010ef          	jal	74fc <printf>
      done = 1;
    60c4:	4785                	li	a5,1
    60c6:	fef42423          	sw	a5,-24(s0)
    60ca:	a8b5                	j	6146 <diskfull+0x11a>
      break;
    }
    for(int i = 0; i < MAXFILE; i++){
    60cc:	fe042223          	sw	zero,-28(s0)
    60d0:	a83d                	j	610e <diskfull+0xe2>
      char buf[BSIZE];
      if(write(fd, buf, BSIZE) != BSIZE){
    60d2:	bc840713          	addi	a4,s0,-1080
    60d6:	fd442783          	lw	a5,-44(s0)
    60da:	40000613          	li	a2,1024
    60de:	85ba                	mv	a1,a4
    60e0:	853e                	mv	a0,a5
    60e2:	517000ef          	jal	6df8 <write>
    60e6:	87aa                	mv	a5,a0
    60e8:	873e                	mv	a4,a5
    60ea:	40000793          	li	a5,1024
    60ee:	00f70b63          	beq	a4,a5,6104 <diskfull+0xd8>
        done = 1;
    60f2:	4785                	li	a5,1
    60f4:	fef42423          	sw	a5,-24(s0)
        close(fd);
    60f8:	fd442783          	lw	a5,-44(s0)
    60fc:	853e                	mv	a0,a5
    60fe:	503000ef          	jal	6e00 <close>
    6102:	a821                	j	611a <diskfull+0xee>
    for(int i = 0; i < MAXFILE; i++){
    6104:	fe442783          	lw	a5,-28(s0)
    6108:	2785                	addiw	a5,a5,1
    610a:	fef42223          	sw	a5,-28(s0)
    610e:	fe442703          	lw	a4,-28(s0)
    6112:	10b00793          	li	a5,267
    6116:	fae7fee3          	bgeu	a5,a4,60d2 <diskfull+0xa6>
        break;
      }
    }
    close(fd);
    611a:	fd442783          	lw	a5,-44(s0)
    611e:	853e                	mv	a0,a5
    6120:	4e1000ef          	jal	6e00 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    6124:	fec42783          	lw	a5,-20(s0)
    6128:	2785                	addiw	a5,a5,1
    612a:	fef42623          	sw	a5,-20(s0)
    612e:	fe842783          	lw	a5,-24(s0)
    6132:	2781                	sext.w	a5,a5
    6134:	eb89                	bnez	a5,6146 <diskfull+0x11a>
    6136:	fec42783          	lw	a5,-20(s0)
    613a:	0007871b          	sext.w	a4,a5
    613e:	04e00793          	li	a5,78
    6142:	f0e7dae3          	bge	a5,a4,6056 <diskfull+0x2a>

  // now that there are no free blocks, test that dirlink()
  // merely fails (doesn't panic) if it can't extend
  // directory content. one of these file creations
  // is expected to fail.
  int nzz = 128;
    6146:	08000793          	li	a5,128
    614a:	fcf42823          	sw	a5,-48(s0)
  for(int i = 0; i < nzz; i++){
    614e:	fe042023          	sw	zero,-32(s0)
    6152:	a879                	j	61f0 <diskfull+0x1c4>
    char name[32];
    name[0] = 'z';
    6154:	07a00793          	li	a5,122
    6158:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    615c:	07a00793          	li	a5,122
    6160:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6164:	fe042783          	lw	a5,-32(s0)
    6168:	41f7d71b          	sraiw	a4,a5,0x1f
    616c:	01b7571b          	srliw	a4,a4,0x1b
    6170:	9fb9                	addw	a5,a5,a4
    6172:	4057d79b          	sraiw	a5,a5,0x5
    6176:	2781                	sext.w	a5,a5
    6178:	0ff7f793          	zext.b	a5,a5
    617c:	0307879b          	addiw	a5,a5,48
    6180:	0ff7f793          	zext.b	a5,a5
    6184:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    6188:	fe042783          	lw	a5,-32(s0)
    618c:	873e                	mv	a4,a5
    618e:	41f7579b          	sraiw	a5,a4,0x1f
    6192:	01b7d79b          	srliw	a5,a5,0x1b
    6196:	9f3d                	addw	a4,a4,a5
    6198:	8b7d                	andi	a4,a4,31
    619a:	40f707bb          	subw	a5,a4,a5
    619e:	2781                	sext.w	a5,a5
    61a0:	0ff7f793          	zext.b	a5,a5
    61a4:	0307879b          	addiw	a5,a5,48
    61a8:	0ff7f793          	zext.b	a5,a5
    61ac:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    61b0:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    61b4:	bc840793          	addi	a5,s0,-1080
    61b8:	853e                	mv	a0,a5
    61ba:	46f000ef          	jal	6e28 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    61be:	bc840793          	addi	a5,s0,-1080
    61c2:	60200593          	li	a1,1538
    61c6:	853e                	mv	a0,a5
    61c8:	451000ef          	jal	6e18 <open>
    61cc:	87aa                	mv	a5,a0
    61ce:	fcf42623          	sw	a5,-52(s0)
    if(fd < 0)
    61d2:	fcc42783          	lw	a5,-52(s0)
    61d6:	2781                	sext.w	a5,a5
    61d8:	0207c663          	bltz	a5,6204 <diskfull+0x1d8>
      break;
    close(fd);
    61dc:	fcc42783          	lw	a5,-52(s0)
    61e0:	853e                	mv	a0,a5
    61e2:	41f000ef          	jal	6e00 <close>
  for(int i = 0; i < nzz; i++){
    61e6:	fe042783          	lw	a5,-32(s0)
    61ea:	2785                	addiw	a5,a5,1
    61ec:	fef42023          	sw	a5,-32(s0)
    61f0:	fe042783          	lw	a5,-32(s0)
    61f4:	873e                	mv	a4,a5
    61f6:	fd042783          	lw	a5,-48(s0)
    61fa:	2701                	sext.w	a4,a4
    61fc:	2781                	sext.w	a5,a5
    61fe:	f4f74be3          	blt	a4,a5,6154 <diskfull+0x128>
    6202:	a011                	j	6206 <diskfull+0x1da>
      break;
    6204:	0001                	nop
  }

  // this mkdir() is expected to fail.
  if(mkdir("diskfulldir") == 0)
    6206:	00004517          	auipc	a0,0x4
    620a:	aba50513          	addi	a0,a0,-1350 # 9cc0 <malloc+0x25dc>
    620e:	433000ef          	jal	6e40 <mkdir>
    6212:	87aa                	mv	a5,a0
    6214:	eb89                	bnez	a5,6226 <diskfull+0x1fa>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    6216:	b9843583          	ld	a1,-1128(s0)
    621a:	00004517          	auipc	a0,0x4
    621e:	ad650513          	addi	a0,a0,-1322 # 9cf0 <malloc+0x260c>
    6222:	2da010ef          	jal	74fc <printf>

  unlink("diskfulldir");
    6226:	00004517          	auipc	a0,0x4
    622a:	a9a50513          	addi	a0,a0,-1382 # 9cc0 <malloc+0x25dc>
    622e:	3fb000ef          	jal	6e28 <unlink>

  for(int i = 0; i < nzz; i++){
    6232:	fc042e23          	sw	zero,-36(s0)
    6236:	a89d                	j	62ac <diskfull+0x280>
    char name[32];
    name[0] = 'z';
    6238:	07a00793          	li	a5,122
    623c:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'z';
    6240:	07a00793          	li	a5,122
    6244:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = '0' + (i / 32);
    6248:	fdc42783          	lw	a5,-36(s0)
    624c:	41f7d71b          	sraiw	a4,a5,0x1f
    6250:	01b7571b          	srliw	a4,a4,0x1b
    6254:	9fb9                	addw	a5,a5,a4
    6256:	4057d79b          	sraiw	a5,a5,0x5
    625a:	2781                	sext.w	a5,a5
    625c:	0ff7f793          	zext.b	a5,a5
    6260:	0307879b          	addiw	a5,a5,48
    6264:	0ff7f793          	zext.b	a5,a5
    6268:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + (i % 32);
    626c:	fdc42783          	lw	a5,-36(s0)
    6270:	873e                	mv	a4,a5
    6272:	41f7579b          	sraiw	a5,a4,0x1f
    6276:	01b7d79b          	srliw	a5,a5,0x1b
    627a:	9f3d                	addw	a4,a4,a5
    627c:	8b7d                	andi	a4,a4,31
    627e:	40f707bb          	subw	a5,a4,a5
    6282:	2781                	sext.w	a5,a5
    6284:	0ff7f793          	zext.b	a5,a5
    6288:	0307879b          	addiw	a5,a5,48
    628c:	0ff7f793          	zext.b	a5,a5
    6290:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    6294:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    6298:	bc840793          	addi	a5,s0,-1080
    629c:	853e                	mv	a0,a5
    629e:	38b000ef          	jal	6e28 <unlink>
  for(int i = 0; i < nzz; i++){
    62a2:	fdc42783          	lw	a5,-36(s0)
    62a6:	2785                	addiw	a5,a5,1
    62a8:	fcf42e23          	sw	a5,-36(s0)
    62ac:	fdc42783          	lw	a5,-36(s0)
    62b0:	873e                	mv	a4,a5
    62b2:	fd042783          	lw	a5,-48(s0)
    62b6:	2701                	sext.w	a4,a4
    62b8:	2781                	sext.w	a5,a5
    62ba:	f6f74fe3          	blt	a4,a5,6238 <diskfull+0x20c>
  }

  for(int i = 0; '0' + i < 0177; i++){
    62be:	fc042c23          	sw	zero,-40(s0)
    62c2:	a099                	j	6308 <diskfull+0x2dc>
    char name[32];
    name[0] = 'b';
    62c4:	06200793          	li	a5,98
    62c8:	bcf40423          	sb	a5,-1080(s0)
    name[1] = 'i';
    62cc:	06900793          	li	a5,105
    62d0:	bcf404a3          	sb	a5,-1079(s0)
    name[2] = 'g';
    62d4:	06700793          	li	a5,103
    62d8:	bcf40523          	sb	a5,-1078(s0)
    name[3] = '0' + i;
    62dc:	fd842783          	lw	a5,-40(s0)
    62e0:	0ff7f793          	zext.b	a5,a5
    62e4:	0307879b          	addiw	a5,a5,48
    62e8:	0ff7f793          	zext.b	a5,a5
    62ec:	bcf405a3          	sb	a5,-1077(s0)
    name[4] = '\0';
    62f0:	bc040623          	sb	zero,-1076(s0)
    unlink(name);
    62f4:	bc840793          	addi	a5,s0,-1080
    62f8:	853e                	mv	a0,a5
    62fa:	32f000ef          	jal	6e28 <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    62fe:	fd842783          	lw	a5,-40(s0)
    6302:	2785                	addiw	a5,a5,1
    6304:	fcf42c23          	sw	a5,-40(s0)
    6308:	fd842783          	lw	a5,-40(s0)
    630c:	0007871b          	sext.w	a4,a5
    6310:	04e00793          	li	a5,78
    6314:	fae7d8e3          	bge	a5,a4,62c4 <diskfull+0x298>
  }
}
    6318:	0001                	nop
    631a:	0001                	nop
    631c:	46813083          	ld	ra,1128(sp)
    6320:	46013403          	ld	s0,1120(sp)
    6324:	47010113          	addi	sp,sp,1136
    6328:	8082                	ret

000000000000632a <outofinodes>:

void
outofinodes(char *s)
{
    632a:	715d                	addi	sp,sp,-80
    632c:	e486                	sd	ra,72(sp)
    632e:	e0a2                	sd	s0,64(sp)
    6330:	0880                	addi	s0,sp,80
    6332:	faa43c23          	sd	a0,-72(s0)
  int nzz = 32*32;
    6336:	40000793          	li	a5,1024
    633a:	fef42223          	sw	a5,-28(s0)
  for(int i = 0; i < nzz; i++){
    633e:	fe042623          	sw	zero,-20(s0)
    6342:	a879                	j	63e0 <outofinodes+0xb6>
    char name[32];
    name[0] = 'z';
    6344:	07a00793          	li	a5,122
    6348:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    634c:	07a00793          	li	a5,122
    6350:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    6354:	fec42783          	lw	a5,-20(s0)
    6358:	41f7d71b          	sraiw	a4,a5,0x1f
    635c:	01b7571b          	srliw	a4,a4,0x1b
    6360:	9fb9                	addw	a5,a5,a4
    6362:	4057d79b          	sraiw	a5,a5,0x5
    6366:	2781                	sext.w	a5,a5
    6368:	0ff7f793          	zext.b	a5,a5
    636c:	0307879b          	addiw	a5,a5,48
    6370:	0ff7f793          	zext.b	a5,a5
    6374:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6378:	fec42783          	lw	a5,-20(s0)
    637c:	873e                	mv	a4,a5
    637e:	41f7579b          	sraiw	a5,a4,0x1f
    6382:	01b7d79b          	srliw	a5,a5,0x1b
    6386:	9f3d                	addw	a4,a4,a5
    6388:	8b7d                	andi	a4,a4,31
    638a:	40f707bb          	subw	a5,a4,a5
    638e:	2781                	sext.w	a5,a5
    6390:	0ff7f793          	zext.b	a5,a5
    6394:	0307879b          	addiw	a5,a5,48
    6398:	0ff7f793          	zext.b	a5,a5
    639c:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    63a0:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    63a4:	fc040793          	addi	a5,s0,-64
    63a8:	853e                	mv	a0,a5
    63aa:	27f000ef          	jal	6e28 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    63ae:	fc040793          	addi	a5,s0,-64
    63b2:	60200593          	li	a1,1538
    63b6:	853e                	mv	a0,a5
    63b8:	261000ef          	jal	6e18 <open>
    63bc:	87aa                	mv	a5,a0
    63be:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    63c2:	fe042783          	lw	a5,-32(s0)
    63c6:	2781                	sext.w	a5,a5
    63c8:	0207c663          	bltz	a5,63f4 <outofinodes+0xca>
      // failure is eventually expected.
      break;
    }
    close(fd);
    63cc:	fe042783          	lw	a5,-32(s0)
    63d0:	853e                	mv	a0,a5
    63d2:	22f000ef          	jal	6e00 <close>
  for(int i = 0; i < nzz; i++){
    63d6:	fec42783          	lw	a5,-20(s0)
    63da:	2785                	addiw	a5,a5,1
    63dc:	fef42623          	sw	a5,-20(s0)
    63e0:	fec42783          	lw	a5,-20(s0)
    63e4:	873e                	mv	a4,a5
    63e6:	fe442783          	lw	a5,-28(s0)
    63ea:	2701                	sext.w	a4,a4
    63ec:	2781                	sext.w	a5,a5
    63ee:	f4f74be3          	blt	a4,a5,6344 <outofinodes+0x1a>
    63f2:	a011                	j	63f6 <outofinodes+0xcc>
      break;
    63f4:	0001                	nop
  }

  for(int i = 0; i < nzz; i++){
    63f6:	fe042423          	sw	zero,-24(s0)
    63fa:	a89d                	j	6470 <outofinodes+0x146>
    char name[32];
    name[0] = 'z';
    63fc:	07a00793          	li	a5,122
    6400:	fcf40023          	sb	a5,-64(s0)
    name[1] = 'z';
    6404:	07a00793          	li	a5,122
    6408:	fcf400a3          	sb	a5,-63(s0)
    name[2] = '0' + (i / 32);
    640c:	fe842783          	lw	a5,-24(s0)
    6410:	41f7d71b          	sraiw	a4,a5,0x1f
    6414:	01b7571b          	srliw	a4,a4,0x1b
    6418:	9fb9                	addw	a5,a5,a4
    641a:	4057d79b          	sraiw	a5,a5,0x5
    641e:	2781                	sext.w	a5,a5
    6420:	0ff7f793          	zext.b	a5,a5
    6424:	0307879b          	addiw	a5,a5,48
    6428:	0ff7f793          	zext.b	a5,a5
    642c:	fcf40123          	sb	a5,-62(s0)
    name[3] = '0' + (i % 32);
    6430:	fe842783          	lw	a5,-24(s0)
    6434:	873e                	mv	a4,a5
    6436:	41f7579b          	sraiw	a5,a4,0x1f
    643a:	01b7d79b          	srliw	a5,a5,0x1b
    643e:	9f3d                	addw	a4,a4,a5
    6440:	8b7d                	andi	a4,a4,31
    6442:	40f707bb          	subw	a5,a4,a5
    6446:	2781                	sext.w	a5,a5
    6448:	0ff7f793          	zext.b	a5,a5
    644c:	0307879b          	addiw	a5,a5,48
    6450:	0ff7f793          	zext.b	a5,a5
    6454:	fcf401a3          	sb	a5,-61(s0)
    name[4] = '\0';
    6458:	fc040223          	sb	zero,-60(s0)
    unlink(name);
    645c:	fc040793          	addi	a5,s0,-64
    6460:	853e                	mv	a0,a5
    6462:	1c7000ef          	jal	6e28 <unlink>
  for(int i = 0; i < nzz; i++){
    6466:	fe842783          	lw	a5,-24(s0)
    646a:	2785                	addiw	a5,a5,1
    646c:	fef42423          	sw	a5,-24(s0)
    6470:	fe842783          	lw	a5,-24(s0)
    6474:	873e                	mv	a4,a5
    6476:	fe442783          	lw	a5,-28(s0)
    647a:	2701                	sext.w	a4,a4
    647c:	2781                	sext.w	a5,a5
    647e:	f6f74fe3          	blt	a4,a5,63fc <outofinodes+0xd2>
  }
}
    6482:	0001                	nop
    6484:	0001                	nop
    6486:	60a6                	ld	ra,72(sp)
    6488:	6406                	ld	s0,64(sp)
    648a:	6161                	addi	sp,sp,80
    648c:	8082                	ret

000000000000648e <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    648e:	7179                	addi	sp,sp,-48
    6490:	f406                	sd	ra,40(sp)
    6492:	f022                	sd	s0,32(sp)
    6494:	1800                	addi	s0,sp,48
    6496:	fca43c23          	sd	a0,-40(s0)
    649a:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    649e:	fd043583          	ld	a1,-48(s0)
    64a2:	00004517          	auipc	a0,0x4
    64a6:	8ce50513          	addi	a0,a0,-1842 # 9d70 <malloc+0x268c>
    64aa:	052010ef          	jal	74fc <printf>
  if((pid = fork()) < 0) {
    64ae:	123000ef          	jal	6dd0 <fork>
    64b2:	87aa                	mv	a5,a0
    64b4:	fef42623          	sw	a5,-20(s0)
    64b8:	fec42783          	lw	a5,-20(s0)
    64bc:	2781                	sext.w	a5,a5
    64be:	0007db63          	bgez	a5,64d4 <run+0x46>
    printf("runtest: fork error\n");
    64c2:	00004517          	auipc	a0,0x4
    64c6:	8be50513          	addi	a0,a0,-1858 # 9d80 <malloc+0x269c>
    64ca:	032010ef          	jal	74fc <printf>
    exit(1);
    64ce:	4505                	li	a0,1
    64d0:	109000ef          	jal	6dd8 <exit>
  }
  if(pid == 0) {
    64d4:	fec42783          	lw	a5,-20(s0)
    64d8:	2781                	sext.w	a5,a5
    64da:	eb89                	bnez	a5,64ec <run+0x5e>
    f(s);
    64dc:	fd843783          	ld	a5,-40(s0)
    64e0:	fd043503          	ld	a0,-48(s0)
    64e4:	9782                	jalr	a5
    exit(0);
    64e6:	4501                	li	a0,0
    64e8:	0f1000ef          	jal	6dd8 <exit>
  } else {
    wait(&xstatus);
    64ec:	fe840793          	addi	a5,s0,-24
    64f0:	853e                	mv	a0,a5
    64f2:	0ef000ef          	jal	6de0 <wait>
    if(xstatus != 0) 
    64f6:	fe842783          	lw	a5,-24(s0)
    64fa:	cb81                	beqz	a5,650a <run+0x7c>
      printf("FAILED\n");
    64fc:	00004517          	auipc	a0,0x4
    6500:	89c50513          	addi	a0,a0,-1892 # 9d98 <malloc+0x26b4>
    6504:	7f9000ef          	jal	74fc <printf>
    6508:	a039                	j	6516 <run+0x88>
    else
      printf("OK\n");
    650a:	00004517          	auipc	a0,0x4
    650e:	89650513          	addi	a0,a0,-1898 # 9da0 <malloc+0x26bc>
    6512:	7eb000ef          	jal	74fc <printf>
    return xstatus == 0;
    6516:	fe842783          	lw	a5,-24(s0)
    651a:	0017b793          	seqz	a5,a5
    651e:	0ff7f793          	zext.b	a5,a5
    6522:	2781                	sext.w	a5,a5
  }
}
    6524:	853e                	mv	a0,a5
    6526:	70a2                	ld	ra,40(sp)
    6528:	7402                	ld	s0,32(sp)
    652a:	6145                	addi	sp,sp,48
    652c:	8082                	ret

000000000000652e <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    652e:	7139                	addi	sp,sp,-64
    6530:	fc06                	sd	ra,56(sp)
    6532:	f822                	sd	s0,48(sp)
    6534:	0080                	addi	s0,sp,64
    6536:	fca43c23          	sd	a0,-40(s0)
    653a:	fcb43823          	sd	a1,-48(s0)
    653e:	87b2                	mv	a5,a2
    6540:	fcf42623          	sw	a5,-52(s0)
  int ntests = 0;
    6544:	fe042623          	sw	zero,-20(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6548:	fd843783          	ld	a5,-40(s0)
    654c:	fef43023          	sd	a5,-32(s0)
    6550:	a09d                	j	65b6 <runtests+0x88>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6552:	fd043783          	ld	a5,-48(s0)
    6556:	cb99                	beqz	a5,656c <runtests+0x3e>
    6558:	fe043783          	ld	a5,-32(s0)
    655c:	679c                	ld	a5,8(a5)
    655e:	fd043583          	ld	a1,-48(s0)
    6562:	853e                	mv	a0,a5
    6564:	3da000ef          	jal	693e <strcmp>
    6568:	87aa                	mv	a5,a0
    656a:	e3a9                	bnez	a5,65ac <runtests+0x7e>
      ntests++;
    656c:	fec42783          	lw	a5,-20(s0)
    6570:	2785                	addiw	a5,a5,1
    6572:	fef42623          	sw	a5,-20(s0)
      if(!run(t->f, t->s)){
    6576:	fe043783          	ld	a5,-32(s0)
    657a:	6398                	ld	a4,0(a5)
    657c:	fe043783          	ld	a5,-32(s0)
    6580:	679c                	ld	a5,8(a5)
    6582:	85be                	mv	a1,a5
    6584:	853a                	mv	a0,a4
    6586:	f09ff0ef          	jal	648e <run>
    658a:	87aa                	mv	a5,a0
    658c:	e385                	bnez	a5,65ac <runtests+0x7e>
        if(continuous != 2){
    658e:	fcc42783          	lw	a5,-52(s0)
    6592:	0007871b          	sext.w	a4,a5
    6596:	4789                	li	a5,2
    6598:	00f70a63          	beq	a4,a5,65ac <runtests+0x7e>
          printf("SOME TESTS FAILED\n");
    659c:	00004517          	auipc	a0,0x4
    65a0:	80c50513          	addi	a0,a0,-2036 # 9da8 <malloc+0x26c4>
    65a4:	759000ef          	jal	74fc <printf>
          return -1;
    65a8:	57fd                	li	a5,-1
    65aa:	a821                	j	65c2 <runtests+0x94>
  for (struct test *t = tests; t->s != 0; t++) {
    65ac:	fe043783          	ld	a5,-32(s0)
    65b0:	07c1                	addi	a5,a5,16
    65b2:	fef43023          	sd	a5,-32(s0)
    65b6:	fe043783          	ld	a5,-32(s0)
    65ba:	679c                	ld	a5,8(a5)
    65bc:	fbd9                	bnez	a5,6552 <runtests+0x24>
        }
      }
    }
  }
  return ntests;
    65be:	fec42783          	lw	a5,-20(s0)
}
    65c2:	853e                	mv	a0,a5
    65c4:	70e2                	ld	ra,56(sp)
    65c6:	7442                	ld	s0,48(sp)
    65c8:	6121                	addi	sp,sp,64
    65ca:	8082                	ret

00000000000065cc <countfree>:


// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    65cc:	7139                	addi	sp,sp,-64
    65ce:	fc06                	sd	ra,56(sp)
    65d0:	f822                	sd	s0,48(sp)
    65d2:	f426                	sd	s1,40(sp)
    65d4:	0080                	addi	s0,sp,64
  int n = 0;
    65d6:	fc042e23          	sw	zero,-36(s0)
  uint64 sz0 = (uint64)sbrk(0);
    65da:	4501                	li	a0,0
    65dc:	7a8000ef          	jal	6d84 <sbrk>
    65e0:	87aa                	mv	a5,a0
    65e2:	fcf43823          	sd	a5,-48(s0)
  while(1){
    char *a = sbrk(PGSIZE);
    65e6:	6505                	lui	a0,0x1
    65e8:	79c000ef          	jal	6d84 <sbrk>
    65ec:	fca43423          	sd	a0,-56(s0)
    if(a == SBRK_ERROR){
    65f0:	fc843703          	ld	a4,-56(s0)
    65f4:	57fd                	li	a5,-1
    65f6:	00f70863          	beq	a4,a5,6606 <countfree+0x3a>
      break;
    }
    n += 1;
    65fa:	fdc42783          	lw	a5,-36(s0)
    65fe:	2785                	addiw	a5,a5,1
    6600:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    6604:	b7cd                	j	65e6 <countfree+0x1a>
      break;
    6606:	0001                	nop
  }
  sbrk(-((uint64)sbrk(0) - sz0));  
    6608:	fd043783          	ld	a5,-48(s0)
    660c:	0007849b          	sext.w	s1,a5
    6610:	4501                	li	a0,0
    6612:	772000ef          	jal	6d84 <sbrk>
    6616:	87aa                	mv	a5,a0
    6618:	2781                	sext.w	a5,a5
    661a:	40f487bb          	subw	a5,s1,a5
    661e:	2781                	sext.w	a5,a5
    6620:	853e                	mv	a0,a5
    6622:	762000ef          	jal	6d84 <sbrk>
  return n;
    6626:	fdc42783          	lw	a5,-36(s0)
}
    662a:	853e                	mv	a0,a5
    662c:	70e2                	ld	ra,56(sp)
    662e:	7442                	ld	s0,48(sp)
    6630:	74a2                	ld	s1,40(sp)
    6632:	6121                	addi	sp,sp,64
    6634:	8082                	ret

0000000000006636 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    6636:	7179                	addi	sp,sp,-48
    6638:	f406                	sd	ra,40(sp)
    663a:	f022                	sd	s0,32(sp)
    663c:	1800                	addi	s0,sp,48
    663e:	87aa                	mv	a5,a0
    6640:	872e                	mv	a4,a1
    6642:	fcc43823          	sd	a2,-48(s0)
    6646:	fcf42e23          	sw	a5,-36(s0)
    664a:	87ba                	mv	a5,a4
    664c:	fcf42c23          	sw	a5,-40(s0)
  do {
    printf("usertests starting\n");
    6650:	00003517          	auipc	a0,0x3
    6654:	77050513          	addi	a0,a0,1904 # 9dc0 <malloc+0x26dc>
    6658:	6a5000ef          	jal	74fc <printf>
    int free0 = countfree();
    665c:	f71ff0ef          	jal	65cc <countfree>
    6660:	87aa                	mv	a5,a0
    6662:	fef42423          	sw	a5,-24(s0)
    int free1 = 0;
    6666:	fe042223          	sw	zero,-28(s0)
    int ntests = 0;
    666a:	fe042623          	sw	zero,-20(s0)
    int n;
    n = runtests(quicktests, justone, continuous);
    666e:	fd842783          	lw	a5,-40(s0)
    6672:	863e                	mv	a2,a5
    6674:	fd043583          	ld	a1,-48(s0)
    6678:	00004517          	auipc	a0,0x4
    667c:	99850513          	addi	a0,a0,-1640 # a010 <quicktests>
    6680:	eafff0ef          	jal	652e <runtests>
    6684:	87aa                	mv	a5,a0
    6686:	fef42023          	sw	a5,-32(s0)
    if (n < 0) {
    668a:	fe042783          	lw	a5,-32(s0)
    668e:	2781                	sext.w	a5,a5
    6690:	0007db63          	bgez	a5,66a6 <drivetests+0x70>
      if(continuous != 2) {
    6694:	fd842783          	lw	a5,-40(s0)
    6698:	0007871b          	sext.w	a4,a5
    669c:	4789                	li	a5,2
    669e:	00f70c63          	beq	a4,a5,66b6 <drivetests+0x80>
        return 1;
    66a2:	4785                	li	a5,1
    66a4:	a0d5                	j	6788 <drivetests+0x152>
      }
    } else {
      ntests += n;
    66a6:	fec42783          	lw	a5,-20(s0)
    66aa:	873e                	mv	a4,a5
    66ac:	fe042783          	lw	a5,-32(s0)
    66b0:	9fb9                	addw	a5,a5,a4
    66b2:	fef42623          	sw	a5,-20(s0)
    }
    if(!quick) {
    66b6:	fdc42783          	lw	a5,-36(s0)
    66ba:	2781                	sext.w	a5,a5
    66bc:	efb1                	bnez	a5,6718 <drivetests+0xe2>
      if (justone == 0)
    66be:	fd043783          	ld	a5,-48(s0)
    66c2:	e799                	bnez	a5,66d0 <drivetests+0x9a>
        printf("usertests slow tests starting\n");
    66c4:	00003517          	auipc	a0,0x3
    66c8:	71450513          	addi	a0,a0,1812 # 9dd8 <malloc+0x26f4>
    66cc:	631000ef          	jal	74fc <printf>
      n = runtests(slowtests, justone, continuous);
    66d0:	fd842783          	lw	a5,-40(s0)
    66d4:	863e                	mv	a2,a5
    66d6:	fd043583          	ld	a1,-48(s0)
    66da:	00004517          	auipc	a0,0x4
    66de:	d4650513          	addi	a0,a0,-698 # a420 <slowtests>
    66e2:	e4dff0ef          	jal	652e <runtests>
    66e6:	87aa                	mv	a5,a0
    66e8:	fef42023          	sw	a5,-32(s0)
      if (n < 0) {
    66ec:	fe042783          	lw	a5,-32(s0)
    66f0:	2781                	sext.w	a5,a5
    66f2:	0007db63          	bgez	a5,6708 <drivetests+0xd2>
        if(continuous != 2) {
    66f6:	fd842783          	lw	a5,-40(s0)
    66fa:	0007871b          	sext.w	a4,a5
    66fe:	4789                	li	a5,2
    6700:	00f70c63          	beq	a4,a5,6718 <drivetests+0xe2>
          return 1;
    6704:	4785                	li	a5,1
    6706:	a049                	j	6788 <drivetests+0x152>
        }
      } else {
        ntests += n;
    6708:	fec42783          	lw	a5,-20(s0)
    670c:	873e                	mv	a4,a5
    670e:	fe042783          	lw	a5,-32(s0)
    6712:	9fb9                	addw	a5,a5,a4
    6714:	fef42623          	sw	a5,-20(s0)
      }
    }
    if((free1 = countfree()) < free0) {
    6718:	eb5ff0ef          	jal	65cc <countfree>
    671c:	87aa                	mv	a5,a0
    671e:	fef42223          	sw	a5,-28(s0)
    6722:	fe442783          	lw	a5,-28(s0)
    6726:	873e                	mv	a4,a5
    6728:	fe842783          	lw	a5,-24(s0)
    672c:	2701                	sext.w	a4,a4
    672e:	2781                	sext.w	a5,a5
    6730:	02f75763          	bge	a4,a5,675e <drivetests+0x128>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    6734:	fe842703          	lw	a4,-24(s0)
    6738:	fe442783          	lw	a5,-28(s0)
    673c:	863a                	mv	a2,a4
    673e:	85be                	mv	a1,a5
    6740:	00003517          	auipc	a0,0x3
    6744:	6b850513          	addi	a0,a0,1720 # 9df8 <malloc+0x2714>
    6748:	5b5000ef          	jal	74fc <printf>
      if(continuous != 2) {
    674c:	fd842783          	lw	a5,-40(s0)
    6750:	0007871b          	sext.w	a4,a5
    6754:	4789                	li	a5,2
    6756:	00f70463          	beq	a4,a5,675e <drivetests+0x128>
        return 1;
    675a:	4785                	li	a5,1
    675c:	a035                	j	6788 <drivetests+0x152>
      }
    }
    if (justone != 0 && ntests == 0) {
    675e:	fd043783          	ld	a5,-48(s0)
    6762:	cf89                	beqz	a5,677c <drivetests+0x146>
    6764:	fec42783          	lw	a5,-20(s0)
    6768:	2781                	sext.w	a5,a5
    676a:	eb89                	bnez	a5,677c <drivetests+0x146>
      printf("NO TESTS EXECUTED\n");
    676c:	00003517          	auipc	a0,0x3
    6770:	6bc50513          	addi	a0,a0,1724 # 9e28 <malloc+0x2744>
    6774:	589000ef          	jal	74fc <printf>
      return 1;
    6778:	4785                	li	a5,1
    677a:	a039                	j	6788 <drivetests+0x152>
    }
  } while(continuous);
    677c:	fd842783          	lw	a5,-40(s0)
    6780:	2781                	sext.w	a5,a5
    6782:	ec0797e3          	bnez	a5,6650 <drivetests+0x1a>
  return 0;
    6786:	4781                	li	a5,0
}
    6788:	853e                	mv	a0,a5
    678a:	70a2                	ld	ra,40(sp)
    678c:	7402                	ld	s0,32(sp)
    678e:	6145                	addi	sp,sp,48
    6790:	8082                	ret

0000000000006792 <main>:

int
main(int argc, char *argv[])
{
    6792:	7179                	addi	sp,sp,-48
    6794:	f406                	sd	ra,40(sp)
    6796:	f022                	sd	s0,32(sp)
    6798:	1800                	addi	s0,sp,48
    679a:	87aa                	mv	a5,a0
    679c:	fcb43823          	sd	a1,-48(s0)
    67a0:	fcf42e23          	sw	a5,-36(s0)
  int continuous = 0;
    67a4:	fe042623          	sw	zero,-20(s0)
  int quick = 0;
    67a8:	fe042423          	sw	zero,-24(s0)
  char *justone = 0;
    67ac:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    67b0:	fdc42783          	lw	a5,-36(s0)
    67b4:	0007871b          	sext.w	a4,a5
    67b8:	4789                	li	a5,2
    67ba:	02f71363          	bne	a4,a5,67e0 <main+0x4e>
    67be:	fd043783          	ld	a5,-48(s0)
    67c2:	07a1                	addi	a5,a5,8
    67c4:	639c                	ld	a5,0(a5)
    67c6:	00003597          	auipc	a1,0x3
    67ca:	67a58593          	addi	a1,a1,1658 # 9e40 <malloc+0x275c>
    67ce:	853e                	mv	a0,a5
    67d0:	16e000ef          	jal	693e <strcmp>
    67d4:	87aa                	mv	a5,a0
    67d6:	e789                	bnez	a5,67e0 <main+0x4e>
    quick = 1;
    67d8:	4785                	li	a5,1
    67da:	fef42423          	sw	a5,-24(s0)
    67de:	a84d                	j	6890 <main+0xfe>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    67e0:	fdc42783          	lw	a5,-36(s0)
    67e4:	0007871b          	sext.w	a4,a5
    67e8:	4789                	li	a5,2
    67ea:	02f71363          	bne	a4,a5,6810 <main+0x7e>
    67ee:	fd043783          	ld	a5,-48(s0)
    67f2:	07a1                	addi	a5,a5,8
    67f4:	639c                	ld	a5,0(a5)
    67f6:	00003597          	auipc	a1,0x3
    67fa:	65258593          	addi	a1,a1,1618 # 9e48 <malloc+0x2764>
    67fe:	853e                	mv	a0,a5
    6800:	13e000ef          	jal	693e <strcmp>
    6804:	87aa                	mv	a5,a0
    6806:	e789                	bnez	a5,6810 <main+0x7e>
    continuous = 1;
    6808:	4785                	li	a5,1
    680a:	fef42623          	sw	a5,-20(s0)
    680e:	a049                	j	6890 <main+0xfe>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    6810:	fdc42783          	lw	a5,-36(s0)
    6814:	0007871b          	sext.w	a4,a5
    6818:	4789                	li	a5,2
    681a:	02f71363          	bne	a4,a5,6840 <main+0xae>
    681e:	fd043783          	ld	a5,-48(s0)
    6822:	07a1                	addi	a5,a5,8
    6824:	639c                	ld	a5,0(a5)
    6826:	00003597          	auipc	a1,0x3
    682a:	62a58593          	addi	a1,a1,1578 # 9e50 <malloc+0x276c>
    682e:	853e                	mv	a0,a5
    6830:	10e000ef          	jal	693e <strcmp>
    6834:	87aa                	mv	a5,a0
    6836:	e789                	bnez	a5,6840 <main+0xae>
    continuous = 2;
    6838:	4789                	li	a5,2
    683a:	fef42623          	sw	a5,-20(s0)
    683e:	a889                	j	6890 <main+0xfe>
  } else if(argc == 2 && argv[1][0] != '-'){
    6840:	fdc42783          	lw	a5,-36(s0)
    6844:	0007871b          	sext.w	a4,a5
    6848:	4789                	li	a5,2
    684a:	02f71363          	bne	a4,a5,6870 <main+0xde>
    684e:	fd043783          	ld	a5,-48(s0)
    6852:	07a1                	addi	a5,a5,8
    6854:	639c                	ld	a5,0(a5)
    6856:	0007c783          	lbu	a5,0(a5)
    685a:	873e                	mv	a4,a5
    685c:	02d00793          	li	a5,45
    6860:	00f70863          	beq	a4,a5,6870 <main+0xde>
    justone = argv[1];
    6864:	fd043783          	ld	a5,-48(s0)
    6868:	679c                	ld	a5,8(a5)
    686a:	fef43023          	sd	a5,-32(s0)
    686e:	a00d                	j	6890 <main+0xfe>
  } else if(argc > 1){
    6870:	fdc42783          	lw	a5,-36(s0)
    6874:	0007871b          	sext.w	a4,a5
    6878:	4785                	li	a5,1
    687a:	00e7db63          	bge	a5,a4,6890 <main+0xfe>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    687e:	00003517          	auipc	a0,0x3
    6882:	5da50513          	addi	a0,a0,1498 # 9e58 <malloc+0x2774>
    6886:	477000ef          	jal	74fc <printf>
    exit(1);
    688a:	4505                	li	a0,1
    688c:	54c000ef          	jal	6dd8 <exit>
  }
  if (drivetests(quick, continuous, justone)) {
    6890:	fec42703          	lw	a4,-20(s0)
    6894:	fe842783          	lw	a5,-24(s0)
    6898:	fe043603          	ld	a2,-32(s0)
    689c:	85ba                	mv	a1,a4
    689e:	853e                	mv	a0,a5
    68a0:	d97ff0ef          	jal	6636 <drivetests>
    68a4:	87aa                	mv	a5,a0
    68a6:	c781                	beqz	a5,68ae <main+0x11c>
    exit(1);
    68a8:	4505                	li	a0,1
    68aa:	52e000ef          	jal	6dd8 <exit>
  }
  printf("ALL TESTS PASSED\n");
    68ae:	00003517          	auipc	a0,0x3
    68b2:	5da50513          	addi	a0,a0,1498 # 9e88 <malloc+0x27a4>
    68b6:	447000ef          	jal	74fc <printf>
  exit(0);
    68ba:	4501                	li	a0,0
    68bc:	51c000ef          	jal	6dd8 <exit>

00000000000068c0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    68c0:	7179                	addi	sp,sp,-48
    68c2:	f406                	sd	ra,40(sp)
    68c4:	f022                	sd	s0,32(sp)
    68c6:	1800                	addi	s0,sp,48
    68c8:	87aa                	mv	a5,a0
    68ca:	fcb43823          	sd	a1,-48(s0)
    68ce:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    68d2:	fdc42783          	lw	a5,-36(s0)
    68d6:	fd043583          	ld	a1,-48(s0)
    68da:	853e                	mv	a0,a5
    68dc:	eb7ff0ef          	jal	6792 <main>
    68e0:	87aa                	mv	a5,a0
    68e2:	fef42623          	sw	a5,-20(s0)
  exit(r);
    68e6:	fec42783          	lw	a5,-20(s0)
    68ea:	853e                	mv	a0,a5
    68ec:	4ec000ef          	jal	6dd8 <exit>

00000000000068f0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    68f0:	7179                	addi	sp,sp,-48
    68f2:	f406                	sd	ra,40(sp)
    68f4:	f022                	sd	s0,32(sp)
    68f6:	1800                	addi	s0,sp,48
    68f8:	fca43c23          	sd	a0,-40(s0)
    68fc:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    6900:	fd843783          	ld	a5,-40(s0)
    6904:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    6908:	0001                	nop
    690a:	fd043703          	ld	a4,-48(s0)
    690e:	00170793          	addi	a5,a4,1 # ffffffffffffd001 <freep+0xfffffffffffec329>
    6912:	fcf43823          	sd	a5,-48(s0)
    6916:	fd843783          	ld	a5,-40(s0)
    691a:	00178693          	addi	a3,a5,1
    691e:	fcd43c23          	sd	a3,-40(s0)
    6922:	00074703          	lbu	a4,0(a4)
    6926:	00e78023          	sb	a4,0(a5)
    692a:	0007c783          	lbu	a5,0(a5)
    692e:	fff1                	bnez	a5,690a <strcpy+0x1a>
    ;
  return os;
    6930:	fe843783          	ld	a5,-24(s0)
}
    6934:	853e                	mv	a0,a5
    6936:	70a2                	ld	ra,40(sp)
    6938:	7402                	ld	s0,32(sp)
    693a:	6145                	addi	sp,sp,48
    693c:	8082                	ret

000000000000693e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    693e:	1101                	addi	sp,sp,-32
    6940:	ec06                	sd	ra,24(sp)
    6942:	e822                	sd	s0,16(sp)
    6944:	1000                	addi	s0,sp,32
    6946:	fea43423          	sd	a0,-24(s0)
    694a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    694e:	a819                	j	6964 <strcmp+0x26>
    p++, q++;
    6950:	fe843783          	ld	a5,-24(s0)
    6954:	0785                	addi	a5,a5,1
    6956:	fef43423          	sd	a5,-24(s0)
    695a:	fe043783          	ld	a5,-32(s0)
    695e:	0785                	addi	a5,a5,1
    6960:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    6964:	fe843783          	ld	a5,-24(s0)
    6968:	0007c783          	lbu	a5,0(a5)
    696c:	cb99                	beqz	a5,6982 <strcmp+0x44>
    696e:	fe843783          	ld	a5,-24(s0)
    6972:	0007c703          	lbu	a4,0(a5)
    6976:	fe043783          	ld	a5,-32(s0)
    697a:	0007c783          	lbu	a5,0(a5)
    697e:	fcf709e3          	beq	a4,a5,6950 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    6982:	fe843783          	ld	a5,-24(s0)
    6986:	0007c783          	lbu	a5,0(a5)
    698a:	0007871b          	sext.w	a4,a5
    698e:	fe043783          	ld	a5,-32(s0)
    6992:	0007c783          	lbu	a5,0(a5)
    6996:	2781                	sext.w	a5,a5
    6998:	40f707bb          	subw	a5,a4,a5
    699c:	2781                	sext.w	a5,a5
}
    699e:	853e                	mv	a0,a5
    69a0:	60e2                	ld	ra,24(sp)
    69a2:	6442                	ld	s0,16(sp)
    69a4:	6105                	addi	sp,sp,32
    69a6:	8082                	ret

00000000000069a8 <strlen>:

uint
strlen(const char *s)
{
    69a8:	7179                	addi	sp,sp,-48
    69aa:	f406                	sd	ra,40(sp)
    69ac:	f022                	sd	s0,32(sp)
    69ae:	1800                	addi	s0,sp,48
    69b0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    69b4:	fe042623          	sw	zero,-20(s0)
    69b8:	a031                	j	69c4 <strlen+0x1c>
    69ba:	fec42783          	lw	a5,-20(s0)
    69be:	2785                	addiw	a5,a5,1
    69c0:	fef42623          	sw	a5,-20(s0)
    69c4:	fec42783          	lw	a5,-20(s0)
    69c8:	fd843703          	ld	a4,-40(s0)
    69cc:	97ba                	add	a5,a5,a4
    69ce:	0007c783          	lbu	a5,0(a5)
    69d2:	f7e5                	bnez	a5,69ba <strlen+0x12>
    ;
  return n;
    69d4:	fec42783          	lw	a5,-20(s0)
}
    69d8:	853e                	mv	a0,a5
    69da:	70a2                	ld	ra,40(sp)
    69dc:	7402                	ld	s0,32(sp)
    69de:	6145                	addi	sp,sp,48
    69e0:	8082                	ret

00000000000069e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    69e2:	7179                	addi	sp,sp,-48
    69e4:	f406                	sd	ra,40(sp)
    69e6:	f022                	sd	s0,32(sp)
    69e8:	1800                	addi	s0,sp,48
    69ea:	fca43c23          	sd	a0,-40(s0)
    69ee:	87ae                	mv	a5,a1
    69f0:	8732                	mv	a4,a2
    69f2:	fcf42a23          	sw	a5,-44(s0)
    69f6:	87ba                	mv	a5,a4
    69f8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    69fc:	fd843783          	ld	a5,-40(s0)
    6a00:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    6a04:	fe042623          	sw	zero,-20(s0)
    6a08:	a00d                	j	6a2a <memset+0x48>
    cdst[i] = c;
    6a0a:	fec42783          	lw	a5,-20(s0)
    6a0e:	fe043703          	ld	a4,-32(s0)
    6a12:	97ba                	add	a5,a5,a4
    6a14:	fd442703          	lw	a4,-44(s0)
    6a18:	0ff77713          	zext.b	a4,a4
    6a1c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    6a20:	fec42783          	lw	a5,-20(s0)
    6a24:	2785                	addiw	a5,a5,1
    6a26:	fef42623          	sw	a5,-20(s0)
    6a2a:	fec42783          	lw	a5,-20(s0)
    6a2e:	fd042703          	lw	a4,-48(s0)
    6a32:	2701                	sext.w	a4,a4
    6a34:	fce7ebe3          	bltu	a5,a4,6a0a <memset+0x28>
  }
  return dst;
    6a38:	fd843783          	ld	a5,-40(s0)
}
    6a3c:	853e                	mv	a0,a5
    6a3e:	70a2                	ld	ra,40(sp)
    6a40:	7402                	ld	s0,32(sp)
    6a42:	6145                	addi	sp,sp,48
    6a44:	8082                	ret

0000000000006a46 <strchr>:

char*
strchr(const char *s, char c)
{
    6a46:	1101                	addi	sp,sp,-32
    6a48:	ec06                	sd	ra,24(sp)
    6a4a:	e822                	sd	s0,16(sp)
    6a4c:	1000                	addi	s0,sp,32
    6a4e:	fea43423          	sd	a0,-24(s0)
    6a52:	87ae                	mv	a5,a1
    6a54:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    6a58:	a01d                	j	6a7e <strchr+0x38>
    if(*s == c)
    6a5a:	fe843783          	ld	a5,-24(s0)
    6a5e:	0007c703          	lbu	a4,0(a5)
    6a62:	fe744783          	lbu	a5,-25(s0)
    6a66:	0ff7f793          	zext.b	a5,a5
    6a6a:	00e79563          	bne	a5,a4,6a74 <strchr+0x2e>
      return (char*)s;
    6a6e:	fe843783          	ld	a5,-24(s0)
    6a72:	a821                	j	6a8a <strchr+0x44>
  for(; *s; s++)
    6a74:	fe843783          	ld	a5,-24(s0)
    6a78:	0785                	addi	a5,a5,1
    6a7a:	fef43423          	sd	a5,-24(s0)
    6a7e:	fe843783          	ld	a5,-24(s0)
    6a82:	0007c783          	lbu	a5,0(a5)
    6a86:	fbf1                	bnez	a5,6a5a <strchr+0x14>
  return 0;
    6a88:	4781                	li	a5,0
}
    6a8a:	853e                	mv	a0,a5
    6a8c:	60e2                	ld	ra,24(sp)
    6a8e:	6442                	ld	s0,16(sp)
    6a90:	6105                	addi	sp,sp,32
    6a92:	8082                	ret

0000000000006a94 <gets>:

char*
gets(char *buf, int max)
{
    6a94:	7179                	addi	sp,sp,-48
    6a96:	f406                	sd	ra,40(sp)
    6a98:	f022                	sd	s0,32(sp)
    6a9a:	1800                	addi	s0,sp,48
    6a9c:	fca43c23          	sd	a0,-40(s0)
    6aa0:	87ae                	mv	a5,a1
    6aa2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    6aa6:	fe042623          	sw	zero,-20(s0)
    6aaa:	a891                	j	6afe <gets+0x6a>
    cc = read(0, &c, 1);
    6aac:	fe740793          	addi	a5,s0,-25
    6ab0:	4605                	li	a2,1
    6ab2:	85be                	mv	a1,a5
    6ab4:	4501                	li	a0,0
    6ab6:	33a000ef          	jal	6df0 <read>
    6aba:	87aa                	mv	a5,a0
    6abc:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    6ac0:	fe842783          	lw	a5,-24(s0)
    6ac4:	2781                	sext.w	a5,a5
    6ac6:	04f05663          	blez	a5,6b12 <gets+0x7e>
      break;
    buf[i++] = c;
    6aca:	fec42783          	lw	a5,-20(s0)
    6ace:	0017871b          	addiw	a4,a5,1
    6ad2:	fee42623          	sw	a4,-20(s0)
    6ad6:	873e                	mv	a4,a5
    6ad8:	fd843783          	ld	a5,-40(s0)
    6adc:	97ba                	add	a5,a5,a4
    6ade:	fe744703          	lbu	a4,-25(s0)
    6ae2:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    6ae6:	fe744783          	lbu	a5,-25(s0)
    6aea:	873e                	mv	a4,a5
    6aec:	47a9                	li	a5,10
    6aee:	02f70363          	beq	a4,a5,6b14 <gets+0x80>
    6af2:	fe744783          	lbu	a5,-25(s0)
    6af6:	873e                	mv	a4,a5
    6af8:	47b5                	li	a5,13
    6afa:	00f70d63          	beq	a4,a5,6b14 <gets+0x80>
  for(i=0; i+1 < max; ){
    6afe:	fec42783          	lw	a5,-20(s0)
    6b02:	2785                	addiw	a5,a5,1
    6b04:	2781                	sext.w	a5,a5
    6b06:	fd442703          	lw	a4,-44(s0)
    6b0a:	2701                	sext.w	a4,a4
    6b0c:	fae7c0e3          	blt	a5,a4,6aac <gets+0x18>
    6b10:	a011                	j	6b14 <gets+0x80>
      break;
    6b12:	0001                	nop
      break;
  }
  buf[i] = '\0';
    6b14:	fec42783          	lw	a5,-20(s0)
    6b18:	fd843703          	ld	a4,-40(s0)
    6b1c:	97ba                	add	a5,a5,a4
    6b1e:	00078023          	sb	zero,0(a5)
  return buf;
    6b22:	fd843783          	ld	a5,-40(s0)
}
    6b26:	853e                	mv	a0,a5
    6b28:	70a2                	ld	ra,40(sp)
    6b2a:	7402                	ld	s0,32(sp)
    6b2c:	6145                	addi	sp,sp,48
    6b2e:	8082                	ret

0000000000006b30 <stat>:

int
stat(const char *n, struct stat *st)
{
    6b30:	7179                	addi	sp,sp,-48
    6b32:	f406                	sd	ra,40(sp)
    6b34:	f022                	sd	s0,32(sp)
    6b36:	1800                	addi	s0,sp,48
    6b38:	fca43c23          	sd	a0,-40(s0)
    6b3c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    6b40:	4581                	li	a1,0
    6b42:	fd843503          	ld	a0,-40(s0)
    6b46:	2d2000ef          	jal	6e18 <open>
    6b4a:	87aa                	mv	a5,a0
    6b4c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    6b50:	fec42783          	lw	a5,-20(s0)
    6b54:	2781                	sext.w	a5,a5
    6b56:	0007d463          	bgez	a5,6b5e <stat+0x2e>
    return -1;
    6b5a:	57fd                	li	a5,-1
    6b5c:	a015                	j	6b80 <stat+0x50>
  r = fstat(fd, st);
    6b5e:	fec42783          	lw	a5,-20(s0)
    6b62:	fd043583          	ld	a1,-48(s0)
    6b66:	853e                	mv	a0,a5
    6b68:	2c8000ef          	jal	6e30 <fstat>
    6b6c:	87aa                	mv	a5,a0
    6b6e:	fef42423          	sw	a5,-24(s0)
  close(fd);
    6b72:	fec42783          	lw	a5,-20(s0)
    6b76:	853e                	mv	a0,a5
    6b78:	288000ef          	jal	6e00 <close>
  return r;
    6b7c:	fe842783          	lw	a5,-24(s0)
}
    6b80:	853e                	mv	a0,a5
    6b82:	70a2                	ld	ra,40(sp)
    6b84:	7402                	ld	s0,32(sp)
    6b86:	6145                	addi	sp,sp,48
    6b88:	8082                	ret

0000000000006b8a <atoi>:

int
atoi(const char *s)
{
    6b8a:	7179                	addi	sp,sp,-48
    6b8c:	f406                	sd	ra,40(sp)
    6b8e:	f022                	sd	s0,32(sp)
    6b90:	1800                	addi	s0,sp,48
    6b92:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    6b96:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    6b9a:	a81d                	j	6bd0 <atoi+0x46>
    n = n*10 + *s++ - '0';
    6b9c:	fec42783          	lw	a5,-20(s0)
    6ba0:	873e                	mv	a4,a5
    6ba2:	87ba                	mv	a5,a4
    6ba4:	0027979b          	slliw	a5,a5,0x2
    6ba8:	9fb9                	addw	a5,a5,a4
    6baa:	0017979b          	slliw	a5,a5,0x1
    6bae:	0007871b          	sext.w	a4,a5
    6bb2:	fd843783          	ld	a5,-40(s0)
    6bb6:	00178693          	addi	a3,a5,1
    6bba:	fcd43c23          	sd	a3,-40(s0)
    6bbe:	0007c783          	lbu	a5,0(a5)
    6bc2:	2781                	sext.w	a5,a5
    6bc4:	9fb9                	addw	a5,a5,a4
    6bc6:	2781                	sext.w	a5,a5
    6bc8:	fd07879b          	addiw	a5,a5,-48
    6bcc:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    6bd0:	fd843783          	ld	a5,-40(s0)
    6bd4:	0007c783          	lbu	a5,0(a5)
    6bd8:	873e                	mv	a4,a5
    6bda:	02f00793          	li	a5,47
    6bde:	00e7fb63          	bgeu	a5,a4,6bf4 <atoi+0x6a>
    6be2:	fd843783          	ld	a5,-40(s0)
    6be6:	0007c783          	lbu	a5,0(a5)
    6bea:	873e                	mv	a4,a5
    6bec:	03900793          	li	a5,57
    6bf0:	fae7f6e3          	bgeu	a5,a4,6b9c <atoi+0x12>
  return n;
    6bf4:	fec42783          	lw	a5,-20(s0)
}
    6bf8:	853e                	mv	a0,a5
    6bfa:	70a2                	ld	ra,40(sp)
    6bfc:	7402                	ld	s0,32(sp)
    6bfe:	6145                	addi	sp,sp,48
    6c00:	8082                	ret

0000000000006c02 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    6c02:	7139                	addi	sp,sp,-64
    6c04:	fc06                	sd	ra,56(sp)
    6c06:	f822                	sd	s0,48(sp)
    6c08:	0080                	addi	s0,sp,64
    6c0a:	fca43c23          	sd	a0,-40(s0)
    6c0e:	fcb43823          	sd	a1,-48(s0)
    6c12:	87b2                	mv	a5,a2
    6c14:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    6c18:	fd843783          	ld	a5,-40(s0)
    6c1c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    6c20:	fd043783          	ld	a5,-48(s0)
    6c24:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    6c28:	fe043703          	ld	a4,-32(s0)
    6c2c:	fe843783          	ld	a5,-24(s0)
    6c30:	02e7fc63          	bgeu	a5,a4,6c68 <memmove+0x66>
    while(n-- > 0)
    6c34:	a00d                	j	6c56 <memmove+0x54>
      *dst++ = *src++;
    6c36:	fe043703          	ld	a4,-32(s0)
    6c3a:	00170793          	addi	a5,a4,1
    6c3e:	fef43023          	sd	a5,-32(s0)
    6c42:	fe843783          	ld	a5,-24(s0)
    6c46:	00178693          	addi	a3,a5,1
    6c4a:	fed43423          	sd	a3,-24(s0)
    6c4e:	00074703          	lbu	a4,0(a4)
    6c52:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    6c56:	fcc42783          	lw	a5,-52(s0)
    6c5a:	fff7871b          	addiw	a4,a5,-1
    6c5e:	fce42623          	sw	a4,-52(s0)
    6c62:	fcf04ae3          	bgtz	a5,6c36 <memmove+0x34>
    6c66:	a891                	j	6cba <memmove+0xb8>
  } else {
    dst += n;
    6c68:	fcc42783          	lw	a5,-52(s0)
    6c6c:	fe843703          	ld	a4,-24(s0)
    6c70:	97ba                	add	a5,a5,a4
    6c72:	fef43423          	sd	a5,-24(s0)
    src += n;
    6c76:	fcc42783          	lw	a5,-52(s0)
    6c7a:	fe043703          	ld	a4,-32(s0)
    6c7e:	97ba                	add	a5,a5,a4
    6c80:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    6c84:	a01d                	j	6caa <memmove+0xa8>
      *--dst = *--src;
    6c86:	fe043783          	ld	a5,-32(s0)
    6c8a:	17fd                	addi	a5,a5,-1
    6c8c:	fef43023          	sd	a5,-32(s0)
    6c90:	fe843783          	ld	a5,-24(s0)
    6c94:	17fd                	addi	a5,a5,-1
    6c96:	fef43423          	sd	a5,-24(s0)
    6c9a:	fe043783          	ld	a5,-32(s0)
    6c9e:	0007c703          	lbu	a4,0(a5)
    6ca2:	fe843783          	ld	a5,-24(s0)
    6ca6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    6caa:	fcc42783          	lw	a5,-52(s0)
    6cae:	fff7871b          	addiw	a4,a5,-1
    6cb2:	fce42623          	sw	a4,-52(s0)
    6cb6:	fcf048e3          	bgtz	a5,6c86 <memmove+0x84>
  }
  return vdst;
    6cba:	fd843783          	ld	a5,-40(s0)
}
    6cbe:	853e                	mv	a0,a5
    6cc0:	70e2                	ld	ra,56(sp)
    6cc2:	7442                	ld	s0,48(sp)
    6cc4:	6121                	addi	sp,sp,64
    6cc6:	8082                	ret

0000000000006cc8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    6cc8:	7139                	addi	sp,sp,-64
    6cca:	fc06                	sd	ra,56(sp)
    6ccc:	f822                	sd	s0,48(sp)
    6cce:	0080                	addi	s0,sp,64
    6cd0:	fca43c23          	sd	a0,-40(s0)
    6cd4:	fcb43823          	sd	a1,-48(s0)
    6cd8:	87b2                	mv	a5,a2
    6cda:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    6cde:	fd843783          	ld	a5,-40(s0)
    6ce2:	fef43423          	sd	a5,-24(s0)
    6ce6:	fd043783          	ld	a5,-48(s0)
    6cea:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    6cee:	a0a1                	j	6d36 <memcmp+0x6e>
    if (*p1 != *p2) {
    6cf0:	fe843783          	ld	a5,-24(s0)
    6cf4:	0007c703          	lbu	a4,0(a5)
    6cf8:	fe043783          	ld	a5,-32(s0)
    6cfc:	0007c783          	lbu	a5,0(a5)
    6d00:	02f70163          	beq	a4,a5,6d22 <memcmp+0x5a>
      return *p1 - *p2;
    6d04:	fe843783          	ld	a5,-24(s0)
    6d08:	0007c783          	lbu	a5,0(a5)
    6d0c:	0007871b          	sext.w	a4,a5
    6d10:	fe043783          	ld	a5,-32(s0)
    6d14:	0007c783          	lbu	a5,0(a5)
    6d18:	2781                	sext.w	a5,a5
    6d1a:	40f707bb          	subw	a5,a4,a5
    6d1e:	2781                	sext.w	a5,a5
    6d20:	a01d                	j	6d46 <memcmp+0x7e>
    }
    p1++;
    6d22:	fe843783          	ld	a5,-24(s0)
    6d26:	0785                	addi	a5,a5,1
    6d28:	fef43423          	sd	a5,-24(s0)
    p2++;
    6d2c:	fe043783          	ld	a5,-32(s0)
    6d30:	0785                	addi	a5,a5,1
    6d32:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    6d36:	fcc42783          	lw	a5,-52(s0)
    6d3a:	fff7871b          	addiw	a4,a5,-1
    6d3e:	fce42623          	sw	a4,-52(s0)
    6d42:	f7dd                	bnez	a5,6cf0 <memcmp+0x28>
  }
  return 0;
    6d44:	4781                	li	a5,0
}
    6d46:	853e                	mv	a0,a5
    6d48:	70e2                	ld	ra,56(sp)
    6d4a:	7442                	ld	s0,48(sp)
    6d4c:	6121                	addi	sp,sp,64
    6d4e:	8082                	ret

0000000000006d50 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    6d50:	7179                	addi	sp,sp,-48
    6d52:	f406                	sd	ra,40(sp)
    6d54:	f022                	sd	s0,32(sp)
    6d56:	1800                	addi	s0,sp,48
    6d58:	fea43423          	sd	a0,-24(s0)
    6d5c:	feb43023          	sd	a1,-32(s0)
    6d60:	87b2                	mv	a5,a2
    6d62:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    6d66:	fdc42783          	lw	a5,-36(s0)
    6d6a:	863e                	mv	a2,a5
    6d6c:	fe043583          	ld	a1,-32(s0)
    6d70:	fe843503          	ld	a0,-24(s0)
    6d74:	e8fff0ef          	jal	6c02 <memmove>
    6d78:	87aa                	mv	a5,a0
}
    6d7a:	853e                	mv	a0,a5
    6d7c:	70a2                	ld	ra,40(sp)
    6d7e:	7402                	ld	s0,32(sp)
    6d80:	6145                	addi	sp,sp,48
    6d82:	8082                	ret

0000000000006d84 <sbrk>:

char *
sbrk(int n) {
    6d84:	1101                	addi	sp,sp,-32
    6d86:	ec06                	sd	ra,24(sp)
    6d88:	e822                	sd	s0,16(sp)
    6d8a:	1000                	addi	s0,sp,32
    6d8c:	87aa                	mv	a5,a0
    6d8e:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
    6d92:	fec42783          	lw	a5,-20(s0)
    6d96:	4585                	li	a1,1
    6d98:	853e                	mv	a0,a5
    6d9a:	0c6000ef          	jal	6e60 <sys_sbrk>
    6d9e:	87aa                	mv	a5,a0
}
    6da0:	853e                	mv	a0,a5
    6da2:	60e2                	ld	ra,24(sp)
    6da4:	6442                	ld	s0,16(sp)
    6da6:	6105                	addi	sp,sp,32
    6da8:	8082                	ret

0000000000006daa <sbrklazy>:

char *
sbrklazy(int n) {
    6daa:	1101                	addi	sp,sp,-32
    6dac:	ec06                	sd	ra,24(sp)
    6dae:	e822                	sd	s0,16(sp)
    6db0:	1000                	addi	s0,sp,32
    6db2:	87aa                	mv	a5,a0
    6db4:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
    6db8:	fec42783          	lw	a5,-20(s0)
    6dbc:	4589                	li	a1,2
    6dbe:	853e                	mv	a0,a5
    6dc0:	0a0000ef          	jal	6e60 <sys_sbrk>
    6dc4:	87aa                	mv	a5,a0
}
    6dc6:	853e                	mv	a0,a5
    6dc8:	60e2                	ld	ra,24(sp)
    6dca:	6442                	ld	s0,16(sp)
    6dcc:	6105                	addi	sp,sp,32
    6dce:	8082                	ret

0000000000006dd0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    6dd0:	4885                	li	a7,1
 ecall
    6dd2:	00000073          	ecall
 ret
    6dd6:	8082                	ret

0000000000006dd8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    6dd8:	4889                	li	a7,2
 ecall
    6dda:	00000073          	ecall
 ret
    6dde:	8082                	ret

0000000000006de0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    6de0:	488d                	li	a7,3
 ecall
    6de2:	00000073          	ecall
 ret
    6de6:	8082                	ret

0000000000006de8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    6de8:	4891                	li	a7,4
 ecall
    6dea:	00000073          	ecall
 ret
    6dee:	8082                	ret

0000000000006df0 <read>:
.global read
read:
 li a7, SYS_read
    6df0:	4895                	li	a7,5
 ecall
    6df2:	00000073          	ecall
 ret
    6df6:	8082                	ret

0000000000006df8 <write>:
.global write
write:
 li a7, SYS_write
    6df8:	48c1                	li	a7,16
 ecall
    6dfa:	00000073          	ecall
 ret
    6dfe:	8082                	ret

0000000000006e00 <close>:
.global close
close:
 li a7, SYS_close
    6e00:	48d5                	li	a7,21
 ecall
    6e02:	00000073          	ecall
 ret
    6e06:	8082                	ret

0000000000006e08 <kill>:
.global kill
kill:
 li a7, SYS_kill
    6e08:	4899                	li	a7,6
 ecall
    6e0a:	00000073          	ecall
 ret
    6e0e:	8082                	ret

0000000000006e10 <exec>:
.global exec
exec:
 li a7, SYS_exec
    6e10:	489d                	li	a7,7
 ecall
    6e12:	00000073          	ecall
 ret
    6e16:	8082                	ret

0000000000006e18 <open>:
.global open
open:
 li a7, SYS_open
    6e18:	48bd                	li	a7,15
 ecall
    6e1a:	00000073          	ecall
 ret
    6e1e:	8082                	ret

0000000000006e20 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    6e20:	48c5                	li	a7,17
 ecall
    6e22:	00000073          	ecall
 ret
    6e26:	8082                	ret

0000000000006e28 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    6e28:	48c9                	li	a7,18
 ecall
    6e2a:	00000073          	ecall
 ret
    6e2e:	8082                	ret

0000000000006e30 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    6e30:	48a1                	li	a7,8
 ecall
    6e32:	00000073          	ecall
 ret
    6e36:	8082                	ret

0000000000006e38 <link>:
.global link
link:
 li a7, SYS_link
    6e38:	48cd                	li	a7,19
 ecall
    6e3a:	00000073          	ecall
 ret
    6e3e:	8082                	ret

0000000000006e40 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    6e40:	48d1                	li	a7,20
 ecall
    6e42:	00000073          	ecall
 ret
    6e46:	8082                	ret

0000000000006e48 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    6e48:	48a5                	li	a7,9
 ecall
    6e4a:	00000073          	ecall
 ret
    6e4e:	8082                	ret

0000000000006e50 <dup>:
.global dup
dup:
 li a7, SYS_dup
    6e50:	48a9                	li	a7,10
 ecall
    6e52:	00000073          	ecall
 ret
    6e56:	8082                	ret

0000000000006e58 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    6e58:	48ad                	li	a7,11
 ecall
    6e5a:	00000073          	ecall
 ret
    6e5e:	8082                	ret

0000000000006e60 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    6e60:	48b1                	li	a7,12
 ecall
    6e62:	00000073          	ecall
 ret
    6e66:	8082                	ret

0000000000006e68 <pause>:
.global pause
pause:
 li a7, SYS_pause
    6e68:	48b5                	li	a7,13
 ecall
    6e6a:	00000073          	ecall
 ret
    6e6e:	8082                	ret

0000000000006e70 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    6e70:	48b9                	li	a7,14
 ecall
    6e72:	00000073          	ecall
 ret
    6e76:	8082                	ret

0000000000006e78 <top>:
.global top
top:
 li a7, SYS_top
    6e78:	48d9                	li	a7,22
 ecall
    6e7a:	00000073          	ecall
 ret
    6e7e:	8082                	ret

0000000000006e80 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
    6e80:	48dd                	li	a7,23
 ecall
    6e82:	00000073          	ecall
 ret
    6e86:	8082                	ret

0000000000006e88 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    6e88:	1101                	addi	sp,sp,-32
    6e8a:	ec06                	sd	ra,24(sp)
    6e8c:	e822                	sd	s0,16(sp)
    6e8e:	1000                	addi	s0,sp,32
    6e90:	87aa                	mv	a5,a0
    6e92:	872e                	mv	a4,a1
    6e94:	fef42623          	sw	a5,-20(s0)
    6e98:	87ba                	mv	a5,a4
    6e9a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    6e9e:	feb40713          	addi	a4,s0,-21
    6ea2:	fec42783          	lw	a5,-20(s0)
    6ea6:	4605                	li	a2,1
    6ea8:	85ba                	mv	a1,a4
    6eaa:	853e                	mv	a0,a5
    6eac:	f4dff0ef          	jal	6df8 <write>
}
    6eb0:	0001                	nop
    6eb2:	60e2                	ld	ra,24(sp)
    6eb4:	6442                	ld	s0,16(sp)
    6eb6:	6105                	addi	sp,sp,32
    6eb8:	8082                	ret

0000000000006eba <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    6eba:	711d                	addi	sp,sp,-96
    6ebc:	ec86                	sd	ra,88(sp)
    6ebe:	e8a2                	sd	s0,80(sp)
    6ec0:	1080                	addi	s0,sp,96
    6ec2:	87aa                	mv	a5,a0
    6ec4:	fab43823          	sd	a1,-80(s0)
    6ec8:	8736                	mv	a4,a3
    6eca:	faf42e23          	sw	a5,-68(s0)
    6ece:	87b2                	mv	a5,a2
    6ed0:	faf42c23          	sw	a5,-72(s0)
    6ed4:	87ba                	mv	a5,a4
    6ed6:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
    6eda:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    6ede:	fac42783          	lw	a5,-84(s0)
    6ee2:	2781                	sext.w	a5,a5
    6ee4:	cf99                	beqz	a5,6f02 <printint+0x48>
    6ee6:	fb043783          	ld	a5,-80(s0)
    6eea:	0007dc63          	bgez	a5,6f02 <printint+0x48>
    neg = 1;
    6eee:	4785                	li	a5,1
    6ef0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    6ef4:	fb043783          	ld	a5,-80(s0)
    6ef8:	40f007b3          	neg	a5,a5
    6efc:	fef43023          	sd	a5,-32(s0)
    6f00:	a029                	j	6f0a <printint+0x50>
  } else {
    x = xx;
    6f02:	fb043783          	ld	a5,-80(s0)
    6f06:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
    6f0a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    6f0e:	fb842783          	lw	a5,-72(s0)
    6f12:	fe043703          	ld	a4,-32(s0)
    6f16:	02f77733          	remu	a4,a4,a5
    6f1a:	fec42783          	lw	a5,-20(s0)
    6f1e:	0017869b          	addiw	a3,a5,1
    6f22:	fed42623          	sw	a3,-20(s0)
    6f26:	00003697          	auipc	a3,0x3
    6f2a:	56a68693          	addi	a3,a3,1386 # a490 <digits>
    6f2e:	9736                	add	a4,a4,a3
    6f30:	00074703          	lbu	a4,0(a4)
    6f34:	17c1                	addi	a5,a5,-16
    6f36:	97a2                	add	a5,a5,s0
    6f38:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
    6f3c:	fb842783          	lw	a5,-72(s0)
    6f40:	fe043703          	ld	a4,-32(s0)
    6f44:	02f757b3          	divu	a5,a4,a5
    6f48:	fef43023          	sd	a5,-32(s0)
    6f4c:	fe043783          	ld	a5,-32(s0)
    6f50:	ffdd                	bnez	a5,6f0e <printint+0x54>
  if(neg)
    6f52:	fe842783          	lw	a5,-24(s0)
    6f56:	2781                	sext.w	a5,a5
    6f58:	cb95                	beqz	a5,6f8c <printint+0xd2>
    buf[i++] = '-';
    6f5a:	fec42783          	lw	a5,-20(s0)
    6f5e:	0017871b          	addiw	a4,a5,1
    6f62:	fee42623          	sw	a4,-20(s0)
    6f66:	17c1                	addi	a5,a5,-16
    6f68:	97a2                	add	a5,a5,s0
    6f6a:	02d00713          	li	a4,45
    6f6e:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
    6f72:	a829                	j	6f8c <printint+0xd2>
    putc(fd, buf[i]);
    6f74:	fec42783          	lw	a5,-20(s0)
    6f78:	17c1                	addi	a5,a5,-16
    6f7a:	97a2                	add	a5,a5,s0
    6f7c:	fd87c703          	lbu	a4,-40(a5)
    6f80:	fbc42783          	lw	a5,-68(s0)
    6f84:	85ba                	mv	a1,a4
    6f86:	853e                	mv	a0,a5
    6f88:	f01ff0ef          	jal	6e88 <putc>
  while(--i >= 0)
    6f8c:	fec42783          	lw	a5,-20(s0)
    6f90:	37fd                	addiw	a5,a5,-1
    6f92:	fef42623          	sw	a5,-20(s0)
    6f96:	fec42783          	lw	a5,-20(s0)
    6f9a:	2781                	sext.w	a5,a5
    6f9c:	fc07dce3          	bgez	a5,6f74 <printint+0xba>
}
    6fa0:	0001                	nop
    6fa2:	0001                	nop
    6fa4:	60e6                	ld	ra,88(sp)
    6fa6:	6446                	ld	s0,80(sp)
    6fa8:	6125                	addi	sp,sp,96
    6faa:	8082                	ret

0000000000006fac <printptr>:

static void
printptr(int fd, uint64 x) {
    6fac:	7179                	addi	sp,sp,-48
    6fae:	f406                	sd	ra,40(sp)
    6fb0:	f022                	sd	s0,32(sp)
    6fb2:	1800                	addi	s0,sp,48
    6fb4:	87aa                	mv	a5,a0
    6fb6:	fcb43823          	sd	a1,-48(s0)
    6fba:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    6fbe:	fdc42783          	lw	a5,-36(s0)
    6fc2:	03000593          	li	a1,48
    6fc6:	853e                	mv	a0,a5
    6fc8:	ec1ff0ef          	jal	6e88 <putc>
  putc(fd, 'x');
    6fcc:	fdc42783          	lw	a5,-36(s0)
    6fd0:	07800593          	li	a1,120
    6fd4:	853e                	mv	a0,a5
    6fd6:	eb3ff0ef          	jal	6e88 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    6fda:	fe042623          	sw	zero,-20(s0)
    6fde:	a81d                	j	7014 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    6fe0:	fd043783          	ld	a5,-48(s0)
    6fe4:	93f1                	srli	a5,a5,0x3c
    6fe6:	00003717          	auipc	a4,0x3
    6fea:	4aa70713          	addi	a4,a4,1194 # a490 <digits>
    6fee:	97ba                	add	a5,a5,a4
    6ff0:	0007c703          	lbu	a4,0(a5)
    6ff4:	fdc42783          	lw	a5,-36(s0)
    6ff8:	85ba                	mv	a1,a4
    6ffa:	853e                	mv	a0,a5
    6ffc:	e8dff0ef          	jal	6e88 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    7000:	fec42783          	lw	a5,-20(s0)
    7004:	2785                	addiw	a5,a5,1
    7006:	fef42623          	sw	a5,-20(s0)
    700a:	fd043783          	ld	a5,-48(s0)
    700e:	0792                	slli	a5,a5,0x4
    7010:	fcf43823          	sd	a5,-48(s0)
    7014:	fec42703          	lw	a4,-20(s0)
    7018:	47bd                	li	a5,15
    701a:	fce7f3e3          	bgeu	a5,a4,6fe0 <printptr+0x34>
}
    701e:	0001                	nop
    7020:	0001                	nop
    7022:	70a2                	ld	ra,40(sp)
    7024:	7402                	ld	s0,32(sp)
    7026:	6145                	addi	sp,sp,48
    7028:	8082                	ret

000000000000702a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    702a:	715d                	addi	sp,sp,-80
    702c:	e486                	sd	ra,72(sp)
    702e:	e0a2                	sd	s0,64(sp)
    7030:	0880                	addi	s0,sp,80
    7032:	87aa                	mv	a5,a0
    7034:	fcb43023          	sd	a1,-64(s0)
    7038:	fac43c23          	sd	a2,-72(s0)
    703c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
    7040:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    7044:	fc042e23          	sw	zero,-36(s0)
    7048:	a189                	j	748a <vprintf+0x460>
    c0 = fmt[i] & 0xff;
    704a:	fdc42783          	lw	a5,-36(s0)
    704e:	fc043703          	ld	a4,-64(s0)
    7052:	97ba                	add	a5,a5,a4
    7054:	0007c783          	lbu	a5,0(a5)
    7058:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
    705c:	fd842783          	lw	a5,-40(s0)
    7060:	2781                	sext.w	a5,a5
    7062:	eb8d                	bnez	a5,7094 <vprintf+0x6a>
      if(c0 == '%'){
    7064:	fd442783          	lw	a5,-44(s0)
    7068:	0007871b          	sext.w	a4,a5
    706c:	02500793          	li	a5,37
    7070:	00f71763          	bne	a4,a5,707e <vprintf+0x54>
        state = '%';
    7074:	02500793          	li	a5,37
    7078:	fcf42c23          	sw	a5,-40(s0)
    707c:	a111                	j	7480 <vprintf+0x456>
      } else {
        putc(fd, c0);
    707e:	fd442783          	lw	a5,-44(s0)
    7082:	0ff7f713          	zext.b	a4,a5
    7086:	fcc42783          	lw	a5,-52(s0)
    708a:	85ba                	mv	a1,a4
    708c:	853e                	mv	a0,a5
    708e:	dfbff0ef          	jal	6e88 <putc>
    7092:	a6fd                	j	7480 <vprintf+0x456>
      }
    } else if(state == '%'){
    7094:	fd842783          	lw	a5,-40(s0)
    7098:	0007871b          	sext.w	a4,a5
    709c:	02500793          	li	a5,37
    70a0:	3ef71063          	bne	a4,a5,7480 <vprintf+0x456>
      c1 = c2 = 0;
    70a4:	fe042023          	sw	zero,-32(s0)
    70a8:	fe042783          	lw	a5,-32(s0)
    70ac:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
    70b0:	fd442783          	lw	a5,-44(s0)
    70b4:	2781                	sext.w	a5,a5
    70b6:	cb99                	beqz	a5,70cc <vprintf+0xa2>
    70b8:	fdc42783          	lw	a5,-36(s0)
    70bc:	0785                	addi	a5,a5,1
    70be:	fc043703          	ld	a4,-64(s0)
    70c2:	97ba                	add	a5,a5,a4
    70c4:	0007c783          	lbu	a5,0(a5)
    70c8:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
    70cc:	fe442783          	lw	a5,-28(s0)
    70d0:	2781                	sext.w	a5,a5
    70d2:	cb99                	beqz	a5,70e8 <vprintf+0xbe>
    70d4:	fdc42783          	lw	a5,-36(s0)
    70d8:	0789                	addi	a5,a5,2
    70da:	fc043703          	ld	a4,-64(s0)
    70de:	97ba                	add	a5,a5,a4
    70e0:	0007c783          	lbu	a5,0(a5)
    70e4:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
    70e8:	fd442783          	lw	a5,-44(s0)
    70ec:	0007871b          	sext.w	a4,a5
    70f0:	06400793          	li	a5,100
    70f4:	02f71363          	bne	a4,a5,711a <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
    70f8:	fb843783          	ld	a5,-72(s0)
    70fc:	00878713          	addi	a4,a5,8
    7100:	fae43c23          	sd	a4,-72(s0)
    7104:	439c                	lw	a5,0(a5)
    7106:	873e                	mv	a4,a5
    7108:	fcc42783          	lw	a5,-52(s0)
    710c:	4685                	li	a3,1
    710e:	4629                	li	a2,10
    7110:	85ba                	mv	a1,a4
    7112:	853e                	mv	a0,a5
    7114:	da7ff0ef          	jal	6eba <printint>
    7118:	a695                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
    711a:	fd442783          	lw	a5,-44(s0)
    711e:	0007871b          	sext.w	a4,a5
    7122:	06c00793          	li	a5,108
    7126:	04f71063          	bne	a4,a5,7166 <vprintf+0x13c>
    712a:	fe442783          	lw	a5,-28(s0)
    712e:	0007871b          	sext.w	a4,a5
    7132:	06400793          	li	a5,100
    7136:	02f71863          	bne	a4,a5,7166 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
    713a:	fb843783          	ld	a5,-72(s0)
    713e:	00878713          	addi	a4,a5,8
    7142:	fae43c23          	sd	a4,-72(s0)
    7146:	639c                	ld	a5,0(a5)
    7148:	873e                	mv	a4,a5
    714a:	fcc42783          	lw	a5,-52(s0)
    714e:	4685                	li	a3,1
    7150:	4629                	li	a2,10
    7152:	85ba                	mv	a1,a4
    7154:	853e                	mv	a0,a5
    7156:	d65ff0ef          	jal	6eba <printint>
        i += 1;
    715a:	fdc42783          	lw	a5,-36(s0)
    715e:	2785                	addiw	a5,a5,1
    7160:	fcf42e23          	sw	a5,-36(s0)
    7164:	ae21                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    7166:	fd442783          	lw	a5,-44(s0)
    716a:	0007871b          	sext.w	a4,a5
    716e:	06c00793          	li	a5,108
    7172:	04f71863          	bne	a4,a5,71c2 <vprintf+0x198>
    7176:	fe442783          	lw	a5,-28(s0)
    717a:	0007871b          	sext.w	a4,a5
    717e:	06c00793          	li	a5,108
    7182:	04f71063          	bne	a4,a5,71c2 <vprintf+0x198>
    7186:	fe042783          	lw	a5,-32(s0)
    718a:	0007871b          	sext.w	a4,a5
    718e:	06400793          	li	a5,100
    7192:	02f71863          	bne	a4,a5,71c2 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
    7196:	fb843783          	ld	a5,-72(s0)
    719a:	00878713          	addi	a4,a5,8
    719e:	fae43c23          	sd	a4,-72(s0)
    71a2:	639c                	ld	a5,0(a5)
    71a4:	873e                	mv	a4,a5
    71a6:	fcc42783          	lw	a5,-52(s0)
    71aa:	4685                	li	a3,1
    71ac:	4629                	li	a2,10
    71ae:	85ba                	mv	a1,a4
    71b0:	853e                	mv	a0,a5
    71b2:	d09ff0ef          	jal	6eba <printint>
        i += 2;
    71b6:	fdc42783          	lw	a5,-36(s0)
    71ba:	2789                	addiw	a5,a5,2
    71bc:	fcf42e23          	sw	a5,-36(s0)
    71c0:	ac75                	j	747c <vprintf+0x452>
      } else if(c0 == 'u'){
    71c2:	fd442783          	lw	a5,-44(s0)
    71c6:	0007871b          	sext.w	a4,a5
    71ca:	07500793          	li	a5,117
    71ce:	02f71563          	bne	a4,a5,71f8 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
    71d2:	fb843783          	ld	a5,-72(s0)
    71d6:	00878713          	addi	a4,a5,8
    71da:	fae43c23          	sd	a4,-72(s0)
    71de:	439c                	lw	a5,0(a5)
    71e0:	02079713          	slli	a4,a5,0x20
    71e4:	9301                	srli	a4,a4,0x20
    71e6:	fcc42783          	lw	a5,-52(s0)
    71ea:	4681                	li	a3,0
    71ec:	4629                	li	a2,10
    71ee:	85ba                	mv	a1,a4
    71f0:	853e                	mv	a0,a5
    71f2:	cc9ff0ef          	jal	6eba <printint>
    71f6:	a459                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
    71f8:	fd442783          	lw	a5,-44(s0)
    71fc:	0007871b          	sext.w	a4,a5
    7200:	06c00793          	li	a5,108
    7204:	04f71063          	bne	a4,a5,7244 <vprintf+0x21a>
    7208:	fe442783          	lw	a5,-28(s0)
    720c:	0007871b          	sext.w	a4,a5
    7210:	07500793          	li	a5,117
    7214:	02f71863          	bne	a4,a5,7244 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    7218:	fb843783          	ld	a5,-72(s0)
    721c:	00878713          	addi	a4,a5,8
    7220:	fae43c23          	sd	a4,-72(s0)
    7224:	639c                	ld	a5,0(a5)
    7226:	873e                	mv	a4,a5
    7228:	fcc42783          	lw	a5,-52(s0)
    722c:	4681                	li	a3,0
    722e:	4629                	li	a2,10
    7230:	85ba                	mv	a1,a4
    7232:	853e                	mv	a0,a5
    7234:	c87ff0ef          	jal	6eba <printint>
        i += 1;
    7238:	fdc42783          	lw	a5,-36(s0)
    723c:	2785                	addiw	a5,a5,1
    723e:	fcf42e23          	sw	a5,-36(s0)
    7242:	ac2d                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    7244:	fd442783          	lw	a5,-44(s0)
    7248:	0007871b          	sext.w	a4,a5
    724c:	06c00793          	li	a5,108
    7250:	04f71863          	bne	a4,a5,72a0 <vprintf+0x276>
    7254:	fe442783          	lw	a5,-28(s0)
    7258:	0007871b          	sext.w	a4,a5
    725c:	06c00793          	li	a5,108
    7260:	04f71063          	bne	a4,a5,72a0 <vprintf+0x276>
    7264:	fe042783          	lw	a5,-32(s0)
    7268:	0007871b          	sext.w	a4,a5
    726c:	07500793          	li	a5,117
    7270:	02f71863          	bne	a4,a5,72a0 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
    7274:	fb843783          	ld	a5,-72(s0)
    7278:	00878713          	addi	a4,a5,8
    727c:	fae43c23          	sd	a4,-72(s0)
    7280:	639c                	ld	a5,0(a5)
    7282:	873e                	mv	a4,a5
    7284:	fcc42783          	lw	a5,-52(s0)
    7288:	4681                	li	a3,0
    728a:	4629                	li	a2,10
    728c:	85ba                	mv	a1,a4
    728e:	853e                	mv	a0,a5
    7290:	c2bff0ef          	jal	6eba <printint>
        i += 2;
    7294:	fdc42783          	lw	a5,-36(s0)
    7298:	2789                	addiw	a5,a5,2
    729a:	fcf42e23          	sw	a5,-36(s0)
    729e:	aaf9                	j	747c <vprintf+0x452>
      } else if(c0 == 'x'){
    72a0:	fd442783          	lw	a5,-44(s0)
    72a4:	0007871b          	sext.w	a4,a5
    72a8:	07800793          	li	a5,120
    72ac:	02f71563          	bne	a4,a5,72d6 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
    72b0:	fb843783          	ld	a5,-72(s0)
    72b4:	00878713          	addi	a4,a5,8
    72b8:	fae43c23          	sd	a4,-72(s0)
    72bc:	439c                	lw	a5,0(a5)
    72be:	02079713          	slli	a4,a5,0x20
    72c2:	9301                	srli	a4,a4,0x20
    72c4:	fcc42783          	lw	a5,-52(s0)
    72c8:	4681                	li	a3,0
    72ca:	4641                	li	a2,16
    72cc:	85ba                	mv	a1,a4
    72ce:	853e                	mv	a0,a5
    72d0:	bebff0ef          	jal	6eba <printint>
    72d4:	a265                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
    72d6:	fd442783          	lw	a5,-44(s0)
    72da:	0007871b          	sext.w	a4,a5
    72de:	06c00793          	li	a5,108
    72e2:	04f71063          	bne	a4,a5,7322 <vprintf+0x2f8>
    72e6:	fe442783          	lw	a5,-28(s0)
    72ea:	0007871b          	sext.w	a4,a5
    72ee:	07800793          	li	a5,120
    72f2:	02f71863          	bne	a4,a5,7322 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
    72f6:	fb843783          	ld	a5,-72(s0)
    72fa:	00878713          	addi	a4,a5,8
    72fe:	fae43c23          	sd	a4,-72(s0)
    7302:	639c                	ld	a5,0(a5)
    7304:	873e                	mv	a4,a5
    7306:	fcc42783          	lw	a5,-52(s0)
    730a:	4681                	li	a3,0
    730c:	4641                	li	a2,16
    730e:	85ba                	mv	a1,a4
    7310:	853e                	mv	a0,a5
    7312:	ba9ff0ef          	jal	6eba <printint>
        i += 1;
    7316:	fdc42783          	lw	a5,-36(s0)
    731a:	2785                	addiw	a5,a5,1
    731c:	fcf42e23          	sw	a5,-36(s0)
    7320:	aab1                	j	747c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    7322:	fd442783          	lw	a5,-44(s0)
    7326:	0007871b          	sext.w	a4,a5
    732a:	06c00793          	li	a5,108
    732e:	04f71863          	bne	a4,a5,737e <vprintf+0x354>
    7332:	fe442783          	lw	a5,-28(s0)
    7336:	0007871b          	sext.w	a4,a5
    733a:	06c00793          	li	a5,108
    733e:	04f71063          	bne	a4,a5,737e <vprintf+0x354>
    7342:	fe042783          	lw	a5,-32(s0)
    7346:	0007871b          	sext.w	a4,a5
    734a:	07800793          	li	a5,120
    734e:	02f71863          	bne	a4,a5,737e <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
    7352:	fb843783          	ld	a5,-72(s0)
    7356:	00878713          	addi	a4,a5,8
    735a:	fae43c23          	sd	a4,-72(s0)
    735e:	639c                	ld	a5,0(a5)
    7360:	873e                	mv	a4,a5
    7362:	fcc42783          	lw	a5,-52(s0)
    7366:	4681                	li	a3,0
    7368:	4641                	li	a2,16
    736a:	85ba                	mv	a1,a4
    736c:	853e                	mv	a0,a5
    736e:	b4dff0ef          	jal	6eba <printint>
        i += 2;
    7372:	fdc42783          	lw	a5,-36(s0)
    7376:	2789                	addiw	a5,a5,2
    7378:	fcf42e23          	sw	a5,-36(s0)
    737c:	a201                	j	747c <vprintf+0x452>
      } else if(c0 == 'p'){
    737e:	fd442783          	lw	a5,-44(s0)
    7382:	0007871b          	sext.w	a4,a5
    7386:	07000793          	li	a5,112
    738a:	02f71063          	bne	a4,a5,73aa <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
    738e:	fb843783          	ld	a5,-72(s0)
    7392:	00878713          	addi	a4,a5,8
    7396:	fae43c23          	sd	a4,-72(s0)
    739a:	6398                	ld	a4,0(a5)
    739c:	fcc42783          	lw	a5,-52(s0)
    73a0:	85ba                	mv	a1,a4
    73a2:	853e                	mv	a0,a5
    73a4:	c09ff0ef          	jal	6fac <printptr>
    73a8:	a8d1                	j	747c <vprintf+0x452>
      } else if(c0 == 'c'){
    73aa:	fd442783          	lw	a5,-44(s0)
    73ae:	0007871b          	sext.w	a4,a5
    73b2:	06300793          	li	a5,99
    73b6:	02f71263          	bne	a4,a5,73da <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
    73ba:	fb843783          	ld	a5,-72(s0)
    73be:	00878713          	addi	a4,a5,8
    73c2:	fae43c23          	sd	a4,-72(s0)
    73c6:	439c                	lw	a5,0(a5)
    73c8:	0ff7f713          	zext.b	a4,a5
    73cc:	fcc42783          	lw	a5,-52(s0)
    73d0:	85ba                	mv	a1,a4
    73d2:	853e                	mv	a0,a5
    73d4:	ab5ff0ef          	jal	6e88 <putc>
    73d8:	a055                	j	747c <vprintf+0x452>
      } else if(c0 == 's'){
    73da:	fd442783          	lw	a5,-44(s0)
    73de:	0007871b          	sext.w	a4,a5
    73e2:	07300793          	li	a5,115
    73e6:	04f71a63          	bne	a4,a5,743a <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
    73ea:	fb843783          	ld	a5,-72(s0)
    73ee:	00878713          	addi	a4,a5,8
    73f2:	fae43c23          	sd	a4,-72(s0)
    73f6:	639c                	ld	a5,0(a5)
    73f8:	fef43423          	sd	a5,-24(s0)
    73fc:	fe843783          	ld	a5,-24(s0)
    7400:	e79d                	bnez	a5,742e <vprintf+0x404>
          s = "(null)";
    7402:	00003797          	auipc	a5,0x3
    7406:	aa678793          	addi	a5,a5,-1370 # 9ea8 <malloc+0x27c4>
    740a:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
    740e:	a005                	j	742e <vprintf+0x404>
          putc(fd, *s);
    7410:	fe843783          	ld	a5,-24(s0)
    7414:	0007c703          	lbu	a4,0(a5)
    7418:	fcc42783          	lw	a5,-52(s0)
    741c:	85ba                	mv	a1,a4
    741e:	853e                	mv	a0,a5
    7420:	a69ff0ef          	jal	6e88 <putc>
        for(; *s; s++)
    7424:	fe843783          	ld	a5,-24(s0)
    7428:	0785                	addi	a5,a5,1
    742a:	fef43423          	sd	a5,-24(s0)
    742e:	fe843783          	ld	a5,-24(s0)
    7432:	0007c783          	lbu	a5,0(a5)
    7436:	ffe9                	bnez	a5,7410 <vprintf+0x3e6>
    7438:	a091                	j	747c <vprintf+0x452>
      } else if(c0 == '%'){
    743a:	fd442783          	lw	a5,-44(s0)
    743e:	0007871b          	sext.w	a4,a5
    7442:	02500793          	li	a5,37
    7446:	00f71a63          	bne	a4,a5,745a <vprintf+0x430>
        putc(fd, '%');
    744a:	fcc42783          	lw	a5,-52(s0)
    744e:	02500593          	li	a1,37
    7452:	853e                	mv	a0,a5
    7454:	a35ff0ef          	jal	6e88 <putc>
    7458:	a015                	j	747c <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    745a:	fcc42783          	lw	a5,-52(s0)
    745e:	02500593          	li	a1,37
    7462:	853e                	mv	a0,a5
    7464:	a25ff0ef          	jal	6e88 <putc>
        putc(fd, c0);
    7468:	fd442783          	lw	a5,-44(s0)
    746c:	0ff7f713          	zext.b	a4,a5
    7470:	fcc42783          	lw	a5,-52(s0)
    7474:	85ba                	mv	a1,a4
    7476:	853e                	mv	a0,a5
    7478:	a11ff0ef          	jal	6e88 <putc>
      }

      state = 0;
    747c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    7480:	fdc42783          	lw	a5,-36(s0)
    7484:	2785                	addiw	a5,a5,1
    7486:	fcf42e23          	sw	a5,-36(s0)
    748a:	fdc42783          	lw	a5,-36(s0)
    748e:	fc043703          	ld	a4,-64(s0)
    7492:	97ba                	add	a5,a5,a4
    7494:	0007c783          	lbu	a5,0(a5)
    7498:	ba0799e3          	bnez	a5,704a <vprintf+0x20>
    }
  }
}
    749c:	0001                	nop
    749e:	0001                	nop
    74a0:	60a6                	ld	ra,72(sp)
    74a2:	6406                	ld	s0,64(sp)
    74a4:	6161                	addi	sp,sp,80
    74a6:	8082                	ret

00000000000074a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    74a8:	7159                	addi	sp,sp,-112
    74aa:	fc06                	sd	ra,56(sp)
    74ac:	f822                	sd	s0,48(sp)
    74ae:	0080                	addi	s0,sp,64
    74b0:	fcb43823          	sd	a1,-48(s0)
    74b4:	e010                	sd	a2,0(s0)
    74b6:	e414                	sd	a3,8(s0)
    74b8:	e818                	sd	a4,16(s0)
    74ba:	ec1c                	sd	a5,24(s0)
    74bc:	03043023          	sd	a6,32(s0)
    74c0:	03143423          	sd	a7,40(s0)
    74c4:	87aa                	mv	a5,a0
    74c6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    74ca:	03040793          	addi	a5,s0,48
    74ce:	fcf43423          	sd	a5,-56(s0)
    74d2:	fc843783          	ld	a5,-56(s0)
    74d6:	fd078793          	addi	a5,a5,-48
    74da:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    74de:	fe843703          	ld	a4,-24(s0)
    74e2:	fdc42783          	lw	a5,-36(s0)
    74e6:	863a                	mv	a2,a4
    74e8:	fd043583          	ld	a1,-48(s0)
    74ec:	853e                	mv	a0,a5
    74ee:	b3dff0ef          	jal	702a <vprintf>
}
    74f2:	0001                	nop
    74f4:	70e2                	ld	ra,56(sp)
    74f6:	7442                	ld	s0,48(sp)
    74f8:	6165                	addi	sp,sp,112
    74fa:	8082                	ret

00000000000074fc <printf>:

void
printf(const char *fmt, ...)
{
    74fc:	7159                	addi	sp,sp,-112
    74fe:	f406                	sd	ra,40(sp)
    7500:	f022                	sd	s0,32(sp)
    7502:	1800                	addi	s0,sp,48
    7504:	fca43c23          	sd	a0,-40(s0)
    7508:	e40c                	sd	a1,8(s0)
    750a:	e810                	sd	a2,16(s0)
    750c:	ec14                	sd	a3,24(s0)
    750e:	f018                	sd	a4,32(s0)
    7510:	f41c                	sd	a5,40(s0)
    7512:	03043823          	sd	a6,48(s0)
    7516:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    751a:	04040793          	addi	a5,s0,64
    751e:	fcf43823          	sd	a5,-48(s0)
    7522:	fd043783          	ld	a5,-48(s0)
    7526:	fc878793          	addi	a5,a5,-56
    752a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    752e:	fe843783          	ld	a5,-24(s0)
    7532:	863e                	mv	a2,a5
    7534:	fd843583          	ld	a1,-40(s0)
    7538:	4505                	li	a0,1
    753a:	af1ff0ef          	jal	702a <vprintf>
}
    753e:	0001                	nop
    7540:	70a2                	ld	ra,40(sp)
    7542:	7402                	ld	s0,32(sp)
    7544:	6165                	addi	sp,sp,112
    7546:	8082                	ret

0000000000007548 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    7548:	7179                	addi	sp,sp,-48
    754a:	f406                	sd	ra,40(sp)
    754c:	f022                	sd	s0,32(sp)
    754e:	1800                	addi	s0,sp,48
    7550:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    7554:	fd843783          	ld	a5,-40(s0)
    7558:	17c1                	addi	a5,a5,-16
    755a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    755e:	00009797          	auipc	a5,0x9
    7562:	77a78793          	addi	a5,a5,1914 # 10cd8 <freep>
    7566:	639c                	ld	a5,0(a5)
    7568:	fef43423          	sd	a5,-24(s0)
    756c:	a815                	j	75a0 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    756e:	fe843783          	ld	a5,-24(s0)
    7572:	639c                	ld	a5,0(a5)
    7574:	fe843703          	ld	a4,-24(s0)
    7578:	00f76f63          	bltu	a4,a5,7596 <free+0x4e>
    757c:	fe043703          	ld	a4,-32(s0)
    7580:	fe843783          	ld	a5,-24(s0)
    7584:	02e7eb63          	bltu	a5,a4,75ba <free+0x72>
    7588:	fe843783          	ld	a5,-24(s0)
    758c:	639c                	ld	a5,0(a5)
    758e:	fe043703          	ld	a4,-32(s0)
    7592:	02f76463          	bltu	a4,a5,75ba <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7596:	fe843783          	ld	a5,-24(s0)
    759a:	639c                	ld	a5,0(a5)
    759c:	fef43423          	sd	a5,-24(s0)
    75a0:	fe043703          	ld	a4,-32(s0)
    75a4:	fe843783          	ld	a5,-24(s0)
    75a8:	fce7f3e3          	bgeu	a5,a4,756e <free+0x26>
    75ac:	fe843783          	ld	a5,-24(s0)
    75b0:	639c                	ld	a5,0(a5)
    75b2:	fe043703          	ld	a4,-32(s0)
    75b6:	faf77ce3          	bgeu	a4,a5,756e <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    75ba:	fe043783          	ld	a5,-32(s0)
    75be:	479c                	lw	a5,8(a5)
    75c0:	1782                	slli	a5,a5,0x20
    75c2:	9381                	srli	a5,a5,0x20
    75c4:	0792                	slli	a5,a5,0x4
    75c6:	fe043703          	ld	a4,-32(s0)
    75ca:	973e                	add	a4,a4,a5
    75cc:	fe843783          	ld	a5,-24(s0)
    75d0:	639c                	ld	a5,0(a5)
    75d2:	02f71763          	bne	a4,a5,7600 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    75d6:	fe043783          	ld	a5,-32(s0)
    75da:	4798                	lw	a4,8(a5)
    75dc:	fe843783          	ld	a5,-24(s0)
    75e0:	639c                	ld	a5,0(a5)
    75e2:	479c                	lw	a5,8(a5)
    75e4:	9fb9                	addw	a5,a5,a4
    75e6:	0007871b          	sext.w	a4,a5
    75ea:	fe043783          	ld	a5,-32(s0)
    75ee:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    75f0:	fe843783          	ld	a5,-24(s0)
    75f4:	639c                	ld	a5,0(a5)
    75f6:	6398                	ld	a4,0(a5)
    75f8:	fe043783          	ld	a5,-32(s0)
    75fc:	e398                	sd	a4,0(a5)
    75fe:	a039                	j	760c <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    7600:	fe843783          	ld	a5,-24(s0)
    7604:	6398                	ld	a4,0(a5)
    7606:	fe043783          	ld	a5,-32(s0)
    760a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    760c:	fe843783          	ld	a5,-24(s0)
    7610:	479c                	lw	a5,8(a5)
    7612:	1782                	slli	a5,a5,0x20
    7614:	9381                	srli	a5,a5,0x20
    7616:	0792                	slli	a5,a5,0x4
    7618:	fe843703          	ld	a4,-24(s0)
    761c:	97ba                	add	a5,a5,a4
    761e:	fe043703          	ld	a4,-32(s0)
    7622:	02f71563          	bne	a4,a5,764c <free+0x104>
    p->s.size += bp->s.size;
    7626:	fe843783          	ld	a5,-24(s0)
    762a:	4798                	lw	a4,8(a5)
    762c:	fe043783          	ld	a5,-32(s0)
    7630:	479c                	lw	a5,8(a5)
    7632:	9fb9                	addw	a5,a5,a4
    7634:	0007871b          	sext.w	a4,a5
    7638:	fe843783          	ld	a5,-24(s0)
    763c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    763e:	fe043783          	ld	a5,-32(s0)
    7642:	6398                	ld	a4,0(a5)
    7644:	fe843783          	ld	a5,-24(s0)
    7648:	e398                	sd	a4,0(a5)
    764a:	a031                	j	7656 <free+0x10e>
  } else
    p->s.ptr = bp;
    764c:	fe843783          	ld	a5,-24(s0)
    7650:	fe043703          	ld	a4,-32(s0)
    7654:	e398                	sd	a4,0(a5)
  freep = p;
    7656:	00009797          	auipc	a5,0x9
    765a:	68278793          	addi	a5,a5,1666 # 10cd8 <freep>
    765e:	fe843703          	ld	a4,-24(s0)
    7662:	e398                	sd	a4,0(a5)
}
    7664:	0001                	nop
    7666:	70a2                	ld	ra,40(sp)
    7668:	7402                	ld	s0,32(sp)
    766a:	6145                	addi	sp,sp,48
    766c:	8082                	ret

000000000000766e <morecore>:

static Header*
morecore(uint nu)
{
    766e:	7179                	addi	sp,sp,-48
    7670:	f406                	sd	ra,40(sp)
    7672:	f022                	sd	s0,32(sp)
    7674:	1800                	addi	s0,sp,48
    7676:	87aa                	mv	a5,a0
    7678:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    767c:	fdc42783          	lw	a5,-36(s0)
    7680:	0007871b          	sext.w	a4,a5
    7684:	6785                	lui	a5,0x1
    7686:	00f77563          	bgeu	a4,a5,7690 <morecore+0x22>
    nu = 4096;
    768a:	6785                	lui	a5,0x1
    768c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7690:	fdc42783          	lw	a5,-36(s0)
    7694:	0047979b          	slliw	a5,a5,0x4
    7698:	2781                	sext.w	a5,a5
    769a:	853e                	mv	a0,a5
    769c:	ee8ff0ef          	jal	6d84 <sbrk>
    76a0:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    76a4:	fe843703          	ld	a4,-24(s0)
    76a8:	57fd                	li	a5,-1
    76aa:	00f71463          	bne	a4,a5,76b2 <morecore+0x44>
    return 0;
    76ae:	4781                	li	a5,0
    76b0:	a02d                	j	76da <morecore+0x6c>
  hp = (Header*)p;
    76b2:	fe843783          	ld	a5,-24(s0)
    76b6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    76ba:	fe043783          	ld	a5,-32(s0)
    76be:	fdc42703          	lw	a4,-36(s0)
    76c2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    76c4:	fe043783          	ld	a5,-32(s0)
    76c8:	07c1                	addi	a5,a5,16 # 1010 <openiputtest+0x24>
    76ca:	853e                	mv	a0,a5
    76cc:	e7dff0ef          	jal	7548 <free>
  return freep;
    76d0:	00009797          	auipc	a5,0x9
    76d4:	60878793          	addi	a5,a5,1544 # 10cd8 <freep>
    76d8:	639c                	ld	a5,0(a5)
}
    76da:	853e                	mv	a0,a5
    76dc:	70a2                	ld	ra,40(sp)
    76de:	7402                	ld	s0,32(sp)
    76e0:	6145                	addi	sp,sp,48
    76e2:	8082                	ret

00000000000076e4 <malloc>:

void*
malloc(uint nbytes)
{
    76e4:	7139                	addi	sp,sp,-64
    76e6:	fc06                	sd	ra,56(sp)
    76e8:	f822                	sd	s0,48(sp)
    76ea:	0080                	addi	s0,sp,64
    76ec:	87aa                	mv	a5,a0
    76ee:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    76f2:	fcc46783          	lwu	a5,-52(s0)
    76f6:	07bd                	addi	a5,a5,15
    76f8:	8391                	srli	a5,a5,0x4
    76fa:	2781                	sext.w	a5,a5
    76fc:	2785                	addiw	a5,a5,1
    76fe:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    7702:	00009797          	auipc	a5,0x9
    7706:	5d678793          	addi	a5,a5,1494 # 10cd8 <freep>
    770a:	639c                	ld	a5,0(a5)
    770c:	fef43023          	sd	a5,-32(s0)
    7710:	fe043783          	ld	a5,-32(s0)
    7714:	ef95                	bnez	a5,7750 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    7716:	00009797          	auipc	a5,0x9
    771a:	5b278793          	addi	a5,a5,1458 # 10cc8 <base>
    771e:	fef43023          	sd	a5,-32(s0)
    7722:	00009797          	auipc	a5,0x9
    7726:	5b678793          	addi	a5,a5,1462 # 10cd8 <freep>
    772a:	fe043703          	ld	a4,-32(s0)
    772e:	e398                	sd	a4,0(a5)
    7730:	00009797          	auipc	a5,0x9
    7734:	5a878793          	addi	a5,a5,1448 # 10cd8 <freep>
    7738:	6398                	ld	a4,0(a5)
    773a:	00009797          	auipc	a5,0x9
    773e:	58e78793          	addi	a5,a5,1422 # 10cc8 <base>
    7742:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7744:	00009797          	auipc	a5,0x9
    7748:	58478793          	addi	a5,a5,1412 # 10cc8 <base>
    774c:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7750:	fe043783          	ld	a5,-32(s0)
    7754:	639c                	ld	a5,0(a5)
    7756:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    775a:	fe843783          	ld	a5,-24(s0)
    775e:	479c                	lw	a5,8(a5)
    7760:	fdc42703          	lw	a4,-36(s0)
    7764:	2701                	sext.w	a4,a4
    7766:	06e7e763          	bltu	a5,a4,77d4 <malloc+0xf0>
      if(p->s.size == nunits)
    776a:	fe843783          	ld	a5,-24(s0)
    776e:	479c                	lw	a5,8(a5)
    7770:	fdc42703          	lw	a4,-36(s0)
    7774:	2701                	sext.w	a4,a4
    7776:	00f71963          	bne	a4,a5,7788 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    777a:	fe843783          	ld	a5,-24(s0)
    777e:	6398                	ld	a4,0(a5)
    7780:	fe043783          	ld	a5,-32(s0)
    7784:	e398                	sd	a4,0(a5)
    7786:	a825                	j	77be <malloc+0xda>
      else {
        p->s.size -= nunits;
    7788:	fe843783          	ld	a5,-24(s0)
    778c:	479c                	lw	a5,8(a5)
    778e:	fdc42703          	lw	a4,-36(s0)
    7792:	9f99                	subw	a5,a5,a4
    7794:	0007871b          	sext.w	a4,a5
    7798:	fe843783          	ld	a5,-24(s0)
    779c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    779e:	fe843783          	ld	a5,-24(s0)
    77a2:	479c                	lw	a5,8(a5)
    77a4:	1782                	slli	a5,a5,0x20
    77a6:	9381                	srli	a5,a5,0x20
    77a8:	0792                	slli	a5,a5,0x4
    77aa:	fe843703          	ld	a4,-24(s0)
    77ae:	97ba                	add	a5,a5,a4
    77b0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    77b4:	fe843783          	ld	a5,-24(s0)
    77b8:	fdc42703          	lw	a4,-36(s0)
    77bc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    77be:	00009797          	auipc	a5,0x9
    77c2:	51a78793          	addi	a5,a5,1306 # 10cd8 <freep>
    77c6:	fe043703          	ld	a4,-32(s0)
    77ca:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    77cc:	fe843783          	ld	a5,-24(s0)
    77d0:	07c1                	addi	a5,a5,16
    77d2:	a081                	j	7812 <malloc+0x12e>
    }
    if(p == freep)
    77d4:	00009797          	auipc	a5,0x9
    77d8:	50478793          	addi	a5,a5,1284 # 10cd8 <freep>
    77dc:	639c                	ld	a5,0(a5)
    77de:	fe843703          	ld	a4,-24(s0)
    77e2:	00f71e63          	bne	a4,a5,77fe <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    77e6:	fdc42783          	lw	a5,-36(s0)
    77ea:	853e                	mv	a0,a5
    77ec:	e83ff0ef          	jal	766e <morecore>
    77f0:	fea43423          	sd	a0,-24(s0)
    77f4:	fe843783          	ld	a5,-24(s0)
    77f8:	e399                	bnez	a5,77fe <malloc+0x11a>
        return 0;
    77fa:	4781                	li	a5,0
    77fc:	a819                	j	7812 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    77fe:	fe843783          	ld	a5,-24(s0)
    7802:	fef43023          	sd	a5,-32(s0)
    7806:	fe843783          	ld	a5,-24(s0)
    780a:	639c                	ld	a5,0(a5)
    780c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7810:	b7a9                	j	775a <malloc+0x76>
  }
}
    7812:	853e                	mv	a0,a5
    7814:	70e2                	ld	ra,56(sp)
    7816:	7442                	ld	s0,48(sp)
    7818:	6121                	addi	sp,sp,64
    781a:	8082                	ret
