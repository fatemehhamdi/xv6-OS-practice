
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
       0:	dc010113          	addi	sp,sp,-576
       4:	22113c23          	sd	ra,568(sp)
       8:	22813823          	sd	s0,560(sp)
       c:	0480                	addi	s0,sp,576
       e:	87aa                	mv	a5,a0
      10:	dcb43023          	sd	a1,-576(s0)
      14:	dcf42623          	sw	a5,-564(s0)
  int fd, i;
  char path[] = "stressfs0";
      18:	00001797          	auipc	a5,0x1
      1c:	0c878793          	addi	a5,a5,200 # 10e0 <malloc+0x16e>
      20:	6398                	ld	a4,0(a5)
      22:	fce43c23          	sd	a4,-40(s0)
      26:	0087d783          	lhu	a5,8(a5)
      2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
      2e:	00001517          	auipc	a0,0x1
      32:	08250513          	addi	a0,a0,130 # 10b0 <malloc+0x13e>
      36:	555000ef          	jal	d8a <printf>
  memset(data, 'a', sizeof(data));
      3a:	dd840793          	addi	a5,s0,-552
      3e:	20000613          	li	a2,512
      42:	06100593          	li	a1,97
      46:	853e                	mv	a0,a5
      48:	230000ef          	jal	278 <memset>

  for(i = 0; i < 4; i++)
      4c:	fe042623          	sw	zero,-20(s0)
      50:	a819                	j	66 <main+0x66>
    if(fork() > 0)
      52:	614000ef          	jal	666 <fork>
      56:	87aa                	mv	a5,a0
      58:	00f04f63          	bgtz	a5,76 <main+0x76>
  for(i = 0; i < 4; i++)
      5c:	fec42783          	lw	a5,-20(s0)
      60:	2785                	addiw	a5,a5,1
      62:	fef42623          	sw	a5,-20(s0)
      66:	fec42783          	lw	a5,-20(s0)
      6a:	0007871b          	sext.w	a4,a5
      6e:	478d                	li	a5,3
      70:	fee7d1e3          	bge	a5,a4,52 <main+0x52>
      74:	a011                	j	78 <main+0x78>
      break;
      76:	0001                	nop

  printf("write %d\n", i);
      78:	fec42783          	lw	a5,-20(s0)
      7c:	85be                	mv	a1,a5
      7e:	00001517          	auipc	a0,0x1
      82:	04a50513          	addi	a0,a0,74 # 10c8 <malloc+0x156>
      86:	505000ef          	jal	d8a <printf>

  path[8] += i;
      8a:	fe044703          	lbu	a4,-32(s0)
      8e:	fec42783          	lw	a5,-20(s0)
      92:	0ff7f793          	zext.b	a5,a5
      96:	9fb9                	addw	a5,a5,a4
      98:	0ff7f793          	zext.b	a5,a5
      9c:	fef40023          	sb	a5,-32(s0)
  fd = open(path, O_CREATE | O_RDWR);
      a0:	fd840793          	addi	a5,s0,-40
      a4:	20200593          	li	a1,514
      a8:	853e                	mv	a0,a5
      aa:	604000ef          	jal	6ae <open>
      ae:	87aa                	mv	a5,a0
      b0:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 20; i++)
      b4:	fe042623          	sw	zero,-20(s0)
      b8:	a005                	j	d8 <main+0xd8>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
      ba:	dd840713          	addi	a4,s0,-552
      be:	fe842783          	lw	a5,-24(s0)
      c2:	20000613          	li	a2,512
      c6:	85ba                	mv	a1,a4
      c8:	853e                	mv	a0,a5
      ca:	5c4000ef          	jal	68e <write>
  for(i = 0; i < 20; i++)
      ce:	fec42783          	lw	a5,-20(s0)
      d2:	2785                	addiw	a5,a5,1
      d4:	fef42623          	sw	a5,-20(s0)
      d8:	fec42783          	lw	a5,-20(s0)
      dc:	0007871b          	sext.w	a4,a5
      e0:	47cd                	li	a5,19
      e2:	fce7dce3          	bge	a5,a4,ba <main+0xba>
  close(fd);
      e6:	fe842783          	lw	a5,-24(s0)
      ea:	853e                	mv	a0,a5
      ec:	5aa000ef          	jal	696 <close>

  printf("read\n");
      f0:	00001517          	auipc	a0,0x1
      f4:	fe850513          	addi	a0,a0,-24 # 10d8 <malloc+0x166>
      f8:	493000ef          	jal	d8a <printf>

  fd = open(path, O_RDONLY);
      fc:	fd840793          	addi	a5,s0,-40
     100:	4581                	li	a1,0
     102:	853e                	mv	a0,a5
     104:	5aa000ef          	jal	6ae <open>
     108:	87aa                	mv	a5,a0
     10a:	fef42423          	sw	a5,-24(s0)
  for (i = 0; i < 20; i++)
     10e:	fe042623          	sw	zero,-20(s0)
     112:	a005                	j	132 <main+0x132>
    read(fd, data, sizeof(data));
     114:	dd840713          	addi	a4,s0,-552
     118:	fe842783          	lw	a5,-24(s0)
     11c:	20000613          	li	a2,512
     120:	85ba                	mv	a1,a4
     122:	853e                	mv	a0,a5
     124:	562000ef          	jal	686 <read>
  for (i = 0; i < 20; i++)
     128:	fec42783          	lw	a5,-20(s0)
     12c:	2785                	addiw	a5,a5,1
     12e:	fef42623          	sw	a5,-20(s0)
     132:	fec42783          	lw	a5,-20(s0)
     136:	0007871b          	sext.w	a4,a5
     13a:	47cd                	li	a5,19
     13c:	fce7dce3          	bge	a5,a4,114 <main+0x114>
  close(fd);
     140:	fe842783          	lw	a5,-24(s0)
     144:	853e                	mv	a0,a5
     146:	550000ef          	jal	696 <close>

  wait(0);
     14a:	4501                	li	a0,0
     14c:	52a000ef          	jal	676 <wait>

  exit(0);
     150:	4501                	li	a0,0
     152:	51c000ef          	jal	66e <exit>

0000000000000156 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     156:	7179                	addi	sp,sp,-48
     158:	f406                	sd	ra,40(sp)
     15a:	f022                	sd	s0,32(sp)
     15c:	1800                	addi	s0,sp,48
     15e:	87aa                	mv	a5,a0
     160:	fcb43823          	sd	a1,-48(s0)
     164:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     168:	fdc42783          	lw	a5,-36(s0)
     16c:	fd043583          	ld	a1,-48(s0)
     170:	853e                	mv	a0,a5
     172:	e8fff0ef          	jal	0 <main>
     176:	87aa                	mv	a5,a0
     178:	fef42623          	sw	a5,-20(s0)
  exit(r);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	4ec000ef          	jal	66e <exit>

0000000000000186 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     186:	7179                	addi	sp,sp,-48
     188:	f406                	sd	ra,40(sp)
     18a:	f022                	sd	s0,32(sp)
     18c:	1800                	addi	s0,sp,48
     18e:	fca43c23          	sd	a0,-40(s0)
     192:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     196:	fd843783          	ld	a5,-40(s0)
     19a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     19e:	0001                	nop
     1a0:	fd043703          	ld	a4,-48(s0)
     1a4:	00170793          	addi	a5,a4,1
     1a8:	fcf43823          	sd	a5,-48(s0)
     1ac:	fd843783          	ld	a5,-40(s0)
     1b0:	00178693          	addi	a3,a5,1
     1b4:	fcd43c23          	sd	a3,-40(s0)
     1b8:	00074703          	lbu	a4,0(a4)
     1bc:	00e78023          	sb	a4,0(a5)
     1c0:	0007c783          	lbu	a5,0(a5)
     1c4:	fff1                	bnez	a5,1a0 <strcpy+0x1a>
    ;
  return os;
     1c6:	fe843783          	ld	a5,-24(s0)
}
     1ca:	853e                	mv	a0,a5
     1cc:	70a2                	ld	ra,40(sp)
     1ce:	7402                	ld	s0,32(sp)
     1d0:	6145                	addi	sp,sp,48
     1d2:	8082                	ret

00000000000001d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1d4:	1101                	addi	sp,sp,-32
     1d6:	ec06                	sd	ra,24(sp)
     1d8:	e822                	sd	s0,16(sp)
     1da:	1000                	addi	s0,sp,32
     1dc:	fea43423          	sd	a0,-24(s0)
     1e0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1e4:	a819                	j	1fa <strcmp+0x26>
    p++, q++;
     1e6:	fe843783          	ld	a5,-24(s0)
     1ea:	0785                	addi	a5,a5,1
     1ec:	fef43423          	sd	a5,-24(s0)
     1f0:	fe043783          	ld	a5,-32(s0)
     1f4:	0785                	addi	a5,a5,1
     1f6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1fa:	fe843783          	ld	a5,-24(s0)
     1fe:	0007c783          	lbu	a5,0(a5)
     202:	cb99                	beqz	a5,218 <strcmp+0x44>
     204:	fe843783          	ld	a5,-24(s0)
     208:	0007c703          	lbu	a4,0(a5)
     20c:	fe043783          	ld	a5,-32(s0)
     210:	0007c783          	lbu	a5,0(a5)
     214:	fcf709e3          	beq	a4,a5,1e6 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     218:	fe843783          	ld	a5,-24(s0)
     21c:	0007c783          	lbu	a5,0(a5)
     220:	0007871b          	sext.w	a4,a5
     224:	fe043783          	ld	a5,-32(s0)
     228:	0007c783          	lbu	a5,0(a5)
     22c:	2781                	sext.w	a5,a5
     22e:	40f707bb          	subw	a5,a4,a5
     232:	2781                	sext.w	a5,a5
}
     234:	853e                	mv	a0,a5
     236:	60e2                	ld	ra,24(sp)
     238:	6442                	ld	s0,16(sp)
     23a:	6105                	addi	sp,sp,32
     23c:	8082                	ret

000000000000023e <strlen>:

uint
strlen(const char *s)
{
     23e:	7179                	addi	sp,sp,-48
     240:	f406                	sd	ra,40(sp)
     242:	f022                	sd	s0,32(sp)
     244:	1800                	addi	s0,sp,48
     246:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     24a:	fe042623          	sw	zero,-20(s0)
     24e:	a031                	j	25a <strlen+0x1c>
     250:	fec42783          	lw	a5,-20(s0)
     254:	2785                	addiw	a5,a5,1
     256:	fef42623          	sw	a5,-20(s0)
     25a:	fec42783          	lw	a5,-20(s0)
     25e:	fd843703          	ld	a4,-40(s0)
     262:	97ba                	add	a5,a5,a4
     264:	0007c783          	lbu	a5,0(a5)
     268:	f7e5                	bnez	a5,250 <strlen+0x12>
    ;
  return n;
     26a:	fec42783          	lw	a5,-20(s0)
}
     26e:	853e                	mv	a0,a5
     270:	70a2                	ld	ra,40(sp)
     272:	7402                	ld	s0,32(sp)
     274:	6145                	addi	sp,sp,48
     276:	8082                	ret

0000000000000278 <memset>:

void*
memset(void *dst, int c, uint n)
{
     278:	7179                	addi	sp,sp,-48
     27a:	f406                	sd	ra,40(sp)
     27c:	f022                	sd	s0,32(sp)
     27e:	1800                	addi	s0,sp,48
     280:	fca43c23          	sd	a0,-40(s0)
     284:	87ae                	mv	a5,a1
     286:	8732                	mv	a4,a2
     288:	fcf42a23          	sw	a5,-44(s0)
     28c:	87ba                	mv	a5,a4
     28e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     292:	fd843783          	ld	a5,-40(s0)
     296:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     29a:	fe042623          	sw	zero,-20(s0)
     29e:	a00d                	j	2c0 <memset+0x48>
    cdst[i] = c;
     2a0:	fec42783          	lw	a5,-20(s0)
     2a4:	fe043703          	ld	a4,-32(s0)
     2a8:	97ba                	add	a5,a5,a4
     2aa:	fd442703          	lw	a4,-44(s0)
     2ae:	0ff77713          	zext.b	a4,a4
     2b2:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	2785                	addiw	a5,a5,1
     2bc:	fef42623          	sw	a5,-20(s0)
     2c0:	fec42783          	lw	a5,-20(s0)
     2c4:	fd042703          	lw	a4,-48(s0)
     2c8:	2701                	sext.w	a4,a4
     2ca:	fce7ebe3          	bltu	a5,a4,2a0 <memset+0x28>
  }
  return dst;
     2ce:	fd843783          	ld	a5,-40(s0)
}
     2d2:	853e                	mv	a0,a5
     2d4:	70a2                	ld	ra,40(sp)
     2d6:	7402                	ld	s0,32(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <strchr>:

char*
strchr(const char *s, char c)
{
     2dc:	1101                	addi	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	1000                	addi	s0,sp,32
     2e4:	fea43423          	sd	a0,-24(s0)
     2e8:	87ae                	mv	a5,a1
     2ea:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2ee:	a01d                	j	314 <strchr+0x38>
    if(*s == c)
     2f0:	fe843783          	ld	a5,-24(s0)
     2f4:	0007c703          	lbu	a4,0(a5)
     2f8:	fe744783          	lbu	a5,-25(s0)
     2fc:	0ff7f793          	zext.b	a5,a5
     300:	00e79563          	bne	a5,a4,30a <strchr+0x2e>
      return (char*)s;
     304:	fe843783          	ld	a5,-24(s0)
     308:	a821                	j	320 <strchr+0x44>
  for(; *s; s++)
     30a:	fe843783          	ld	a5,-24(s0)
     30e:	0785                	addi	a5,a5,1
     310:	fef43423          	sd	a5,-24(s0)
     314:	fe843783          	ld	a5,-24(s0)
     318:	0007c783          	lbu	a5,0(a5)
     31c:	fbf1                	bnez	a5,2f0 <strchr+0x14>
  return 0;
     31e:	4781                	li	a5,0
}
     320:	853e                	mv	a0,a5
     322:	60e2                	ld	ra,24(sp)
     324:	6442                	ld	s0,16(sp)
     326:	6105                	addi	sp,sp,32
     328:	8082                	ret

000000000000032a <gets>:

char*
gets(char *buf, int max)
{
     32a:	7179                	addi	sp,sp,-48
     32c:	f406                	sd	ra,40(sp)
     32e:	f022                	sd	s0,32(sp)
     330:	1800                	addi	s0,sp,48
     332:	fca43c23          	sd	a0,-40(s0)
     336:	87ae                	mv	a5,a1
     338:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     33c:	fe042623          	sw	zero,-20(s0)
     340:	a891                	j	394 <gets+0x6a>
    cc = read(0, &c, 1);
     342:	fe740793          	addi	a5,s0,-25
     346:	4605                	li	a2,1
     348:	85be                	mv	a1,a5
     34a:	4501                	li	a0,0
     34c:	33a000ef          	jal	686 <read>
     350:	87aa                	mv	a5,a0
     352:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     356:	fe842783          	lw	a5,-24(s0)
     35a:	2781                	sext.w	a5,a5
     35c:	04f05663          	blez	a5,3a8 <gets+0x7e>
      break;
    buf[i++] = c;
     360:	fec42783          	lw	a5,-20(s0)
     364:	0017871b          	addiw	a4,a5,1
     368:	fee42623          	sw	a4,-20(s0)
     36c:	873e                	mv	a4,a5
     36e:	fd843783          	ld	a5,-40(s0)
     372:	97ba                	add	a5,a5,a4
     374:	fe744703          	lbu	a4,-25(s0)
     378:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     37c:	fe744783          	lbu	a5,-25(s0)
     380:	873e                	mv	a4,a5
     382:	47a9                	li	a5,10
     384:	02f70363          	beq	a4,a5,3aa <gets+0x80>
     388:	fe744783          	lbu	a5,-25(s0)
     38c:	873e                	mv	a4,a5
     38e:	47b5                	li	a5,13
     390:	00f70d63          	beq	a4,a5,3aa <gets+0x80>
  for(i=0; i+1 < max; ){
     394:	fec42783          	lw	a5,-20(s0)
     398:	2785                	addiw	a5,a5,1
     39a:	2781                	sext.w	a5,a5
     39c:	fd442703          	lw	a4,-44(s0)
     3a0:	2701                	sext.w	a4,a4
     3a2:	fae7c0e3          	blt	a5,a4,342 <gets+0x18>
     3a6:	a011                	j	3aa <gets+0x80>
      break;
     3a8:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3aa:	fec42783          	lw	a5,-20(s0)
     3ae:	fd843703          	ld	a4,-40(s0)
     3b2:	97ba                	add	a5,a5,a4
     3b4:	00078023          	sb	zero,0(a5)
  return buf;
     3b8:	fd843783          	ld	a5,-40(s0)
}
     3bc:	853e                	mv	a0,a5
     3be:	70a2                	ld	ra,40(sp)
     3c0:	7402                	ld	s0,32(sp)
     3c2:	6145                	addi	sp,sp,48
     3c4:	8082                	ret

00000000000003c6 <stat>:

int
stat(const char *n, struct stat *st)
{
     3c6:	7179                	addi	sp,sp,-48
     3c8:	f406                	sd	ra,40(sp)
     3ca:	f022                	sd	s0,32(sp)
     3cc:	1800                	addi	s0,sp,48
     3ce:	fca43c23          	sd	a0,-40(s0)
     3d2:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3d6:	4581                	li	a1,0
     3d8:	fd843503          	ld	a0,-40(s0)
     3dc:	2d2000ef          	jal	6ae <open>
     3e0:	87aa                	mv	a5,a0
     3e2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3e6:	fec42783          	lw	a5,-20(s0)
     3ea:	2781                	sext.w	a5,a5
     3ec:	0007d463          	bgez	a5,3f4 <stat+0x2e>
    return -1;
     3f0:	57fd                	li	a5,-1
     3f2:	a015                	j	416 <stat+0x50>
  r = fstat(fd, st);
     3f4:	fec42783          	lw	a5,-20(s0)
     3f8:	fd043583          	ld	a1,-48(s0)
     3fc:	853e                	mv	a0,a5
     3fe:	2c8000ef          	jal	6c6 <fstat>
     402:	87aa                	mv	a5,a0
     404:	fef42423          	sw	a5,-24(s0)
  close(fd);
     408:	fec42783          	lw	a5,-20(s0)
     40c:	853e                	mv	a0,a5
     40e:	288000ef          	jal	696 <close>
  return r;
     412:	fe842783          	lw	a5,-24(s0)
}
     416:	853e                	mv	a0,a5
     418:	70a2                	ld	ra,40(sp)
     41a:	7402                	ld	s0,32(sp)
     41c:	6145                	addi	sp,sp,48
     41e:	8082                	ret

0000000000000420 <atoi>:

int
atoi(const char *s)
{
     420:	7179                	addi	sp,sp,-48
     422:	f406                	sd	ra,40(sp)
     424:	f022                	sd	s0,32(sp)
     426:	1800                	addi	s0,sp,48
     428:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     42c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     430:	a81d                	j	466 <atoi+0x46>
    n = n*10 + *s++ - '0';
     432:	fec42783          	lw	a5,-20(s0)
     436:	873e                	mv	a4,a5
     438:	87ba                	mv	a5,a4
     43a:	0027979b          	slliw	a5,a5,0x2
     43e:	9fb9                	addw	a5,a5,a4
     440:	0017979b          	slliw	a5,a5,0x1
     444:	0007871b          	sext.w	a4,a5
     448:	fd843783          	ld	a5,-40(s0)
     44c:	00178693          	addi	a3,a5,1
     450:	fcd43c23          	sd	a3,-40(s0)
     454:	0007c783          	lbu	a5,0(a5)
     458:	2781                	sext.w	a5,a5
     45a:	9fb9                	addw	a5,a5,a4
     45c:	2781                	sext.w	a5,a5
     45e:	fd07879b          	addiw	a5,a5,-48
     462:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     466:	fd843783          	ld	a5,-40(s0)
     46a:	0007c783          	lbu	a5,0(a5)
     46e:	873e                	mv	a4,a5
     470:	02f00793          	li	a5,47
     474:	00e7fb63          	bgeu	a5,a4,48a <atoi+0x6a>
     478:	fd843783          	ld	a5,-40(s0)
     47c:	0007c783          	lbu	a5,0(a5)
     480:	873e                	mv	a4,a5
     482:	03900793          	li	a5,57
     486:	fae7f6e3          	bgeu	a5,a4,432 <atoi+0x12>
  return n;
     48a:	fec42783          	lw	a5,-20(s0)
}
     48e:	853e                	mv	a0,a5
     490:	70a2                	ld	ra,40(sp)
     492:	7402                	ld	s0,32(sp)
     494:	6145                	addi	sp,sp,48
     496:	8082                	ret

0000000000000498 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     498:	7139                	addi	sp,sp,-64
     49a:	fc06                	sd	ra,56(sp)
     49c:	f822                	sd	s0,48(sp)
     49e:	0080                	addi	s0,sp,64
     4a0:	fca43c23          	sd	a0,-40(s0)
     4a4:	fcb43823          	sd	a1,-48(s0)
     4a8:	87b2                	mv	a5,a2
     4aa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4ae:	fd843783          	ld	a5,-40(s0)
     4b2:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4b6:	fd043783          	ld	a5,-48(s0)
     4ba:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4be:	fe043703          	ld	a4,-32(s0)
     4c2:	fe843783          	ld	a5,-24(s0)
     4c6:	02e7fc63          	bgeu	a5,a4,4fe <memmove+0x66>
    while(n-- > 0)
     4ca:	a00d                	j	4ec <memmove+0x54>
      *dst++ = *src++;
     4cc:	fe043703          	ld	a4,-32(s0)
     4d0:	00170793          	addi	a5,a4,1
     4d4:	fef43023          	sd	a5,-32(s0)
     4d8:	fe843783          	ld	a5,-24(s0)
     4dc:	00178693          	addi	a3,a5,1
     4e0:	fed43423          	sd	a3,-24(s0)
     4e4:	00074703          	lbu	a4,0(a4)
     4e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4ec:	fcc42783          	lw	a5,-52(s0)
     4f0:	fff7871b          	addiw	a4,a5,-1
     4f4:	fce42623          	sw	a4,-52(s0)
     4f8:	fcf04ae3          	bgtz	a5,4cc <memmove+0x34>
     4fc:	a891                	j	550 <memmove+0xb8>
  } else {
    dst += n;
     4fe:	fcc42783          	lw	a5,-52(s0)
     502:	fe843703          	ld	a4,-24(s0)
     506:	97ba                	add	a5,a5,a4
     508:	fef43423          	sd	a5,-24(s0)
    src += n;
     50c:	fcc42783          	lw	a5,-52(s0)
     510:	fe043703          	ld	a4,-32(s0)
     514:	97ba                	add	a5,a5,a4
     516:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     51a:	a01d                	j	540 <memmove+0xa8>
      *--dst = *--src;
     51c:	fe043783          	ld	a5,-32(s0)
     520:	17fd                	addi	a5,a5,-1
     522:	fef43023          	sd	a5,-32(s0)
     526:	fe843783          	ld	a5,-24(s0)
     52a:	17fd                	addi	a5,a5,-1
     52c:	fef43423          	sd	a5,-24(s0)
     530:	fe043783          	ld	a5,-32(s0)
     534:	0007c703          	lbu	a4,0(a5)
     538:	fe843783          	ld	a5,-24(s0)
     53c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     540:	fcc42783          	lw	a5,-52(s0)
     544:	fff7871b          	addiw	a4,a5,-1
     548:	fce42623          	sw	a4,-52(s0)
     54c:	fcf048e3          	bgtz	a5,51c <memmove+0x84>
  }
  return vdst;
     550:	fd843783          	ld	a5,-40(s0)
}
     554:	853e                	mv	a0,a5
     556:	70e2                	ld	ra,56(sp)
     558:	7442                	ld	s0,48(sp)
     55a:	6121                	addi	sp,sp,64
     55c:	8082                	ret

000000000000055e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     55e:	7139                	addi	sp,sp,-64
     560:	fc06                	sd	ra,56(sp)
     562:	f822                	sd	s0,48(sp)
     564:	0080                	addi	s0,sp,64
     566:	fca43c23          	sd	a0,-40(s0)
     56a:	fcb43823          	sd	a1,-48(s0)
     56e:	87b2                	mv	a5,a2
     570:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     574:	fd843783          	ld	a5,-40(s0)
     578:	fef43423          	sd	a5,-24(s0)
     57c:	fd043783          	ld	a5,-48(s0)
     580:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     584:	a0a1                	j	5cc <memcmp+0x6e>
    if (*p1 != *p2) {
     586:	fe843783          	ld	a5,-24(s0)
     58a:	0007c703          	lbu	a4,0(a5)
     58e:	fe043783          	ld	a5,-32(s0)
     592:	0007c783          	lbu	a5,0(a5)
     596:	02f70163          	beq	a4,a5,5b8 <memcmp+0x5a>
      return *p1 - *p2;
     59a:	fe843783          	ld	a5,-24(s0)
     59e:	0007c783          	lbu	a5,0(a5)
     5a2:	0007871b          	sext.w	a4,a5
     5a6:	fe043783          	ld	a5,-32(s0)
     5aa:	0007c783          	lbu	a5,0(a5)
     5ae:	2781                	sext.w	a5,a5
     5b0:	40f707bb          	subw	a5,a4,a5
     5b4:	2781                	sext.w	a5,a5
     5b6:	a01d                	j	5dc <memcmp+0x7e>
    }
    p1++;
     5b8:	fe843783          	ld	a5,-24(s0)
     5bc:	0785                	addi	a5,a5,1
     5be:	fef43423          	sd	a5,-24(s0)
    p2++;
     5c2:	fe043783          	ld	a5,-32(s0)
     5c6:	0785                	addi	a5,a5,1
     5c8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5cc:	fcc42783          	lw	a5,-52(s0)
     5d0:	fff7871b          	addiw	a4,a5,-1
     5d4:	fce42623          	sw	a4,-52(s0)
     5d8:	f7dd                	bnez	a5,586 <memcmp+0x28>
  }
  return 0;
     5da:	4781                	li	a5,0
}
     5dc:	853e                	mv	a0,a5
     5de:	70e2                	ld	ra,56(sp)
     5e0:	7442                	ld	s0,48(sp)
     5e2:	6121                	addi	sp,sp,64
     5e4:	8082                	ret

00000000000005e6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5e6:	7179                	addi	sp,sp,-48
     5e8:	f406                	sd	ra,40(sp)
     5ea:	f022                	sd	s0,32(sp)
     5ec:	1800                	addi	s0,sp,48
     5ee:	fea43423          	sd	a0,-24(s0)
     5f2:	feb43023          	sd	a1,-32(s0)
     5f6:	87b2                	mv	a5,a2
     5f8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5fc:	fdc42783          	lw	a5,-36(s0)
     600:	863e                	mv	a2,a5
     602:	fe043583          	ld	a1,-32(s0)
     606:	fe843503          	ld	a0,-24(s0)
     60a:	e8fff0ef          	jal	498 <memmove>
     60e:	87aa                	mv	a5,a0
}
     610:	853e                	mv	a0,a5
     612:	70a2                	ld	ra,40(sp)
     614:	7402                	ld	s0,32(sp)
     616:	6145                	addi	sp,sp,48
     618:	8082                	ret

000000000000061a <sbrk>:

char *
sbrk(int n) {
     61a:	1101                	addi	sp,sp,-32
     61c:	ec06                	sd	ra,24(sp)
     61e:	e822                	sd	s0,16(sp)
     620:	1000                	addi	s0,sp,32
     622:	87aa                	mv	a5,a0
     624:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     628:	fec42783          	lw	a5,-20(s0)
     62c:	4585                	li	a1,1
     62e:	853e                	mv	a0,a5
     630:	0c6000ef          	jal	6f6 <sys_sbrk>
     634:	87aa                	mv	a5,a0
}
     636:	853e                	mv	a0,a5
     638:	60e2                	ld	ra,24(sp)
     63a:	6442                	ld	s0,16(sp)
     63c:	6105                	addi	sp,sp,32
     63e:	8082                	ret

0000000000000640 <sbrklazy>:

char *
sbrklazy(int n) {
     640:	1101                	addi	sp,sp,-32
     642:	ec06                	sd	ra,24(sp)
     644:	e822                	sd	s0,16(sp)
     646:	1000                	addi	s0,sp,32
     648:	87aa                	mv	a5,a0
     64a:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     64e:	fec42783          	lw	a5,-20(s0)
     652:	4589                	li	a1,2
     654:	853e                	mv	a0,a5
     656:	0a0000ef          	jal	6f6 <sys_sbrk>
     65a:	87aa                	mv	a5,a0
}
     65c:	853e                	mv	a0,a5
     65e:	60e2                	ld	ra,24(sp)
     660:	6442                	ld	s0,16(sp)
     662:	6105                	addi	sp,sp,32
     664:	8082                	ret

0000000000000666 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     666:	4885                	li	a7,1
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <exit>:
.global exit
exit:
 li a7, SYS_exit
     66e:	4889                	li	a7,2
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <wait>:
.global wait
wait:
 li a7, SYS_wait
     676:	488d                	li	a7,3
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     67e:	4891                	li	a7,4
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <read>:
.global read
read:
 li a7, SYS_read
     686:	4895                	li	a7,5
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <write>:
.global write
write:
 li a7, SYS_write
     68e:	48c1                	li	a7,16
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <close>:
.global close
close:
 li a7, SYS_close
     696:	48d5                	li	a7,21
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <kill>:
.global kill
kill:
 li a7, SYS_kill
     69e:	4899                	li	a7,6
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     6a6:	489d                	li	a7,7
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <open>:
.global open
open:
 li a7, SYS_open
     6ae:	48bd                	li	a7,15
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6b6:	48c5                	li	a7,17
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     6be:	48c9                	li	a7,18
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     6c6:	48a1                	li	a7,8
 ecall
     6c8:	00000073          	ecall
 ret
     6cc:	8082                	ret

00000000000006ce <link>:
.global link
link:
 li a7, SYS_link
     6ce:	48cd                	li	a7,19
 ecall
     6d0:	00000073          	ecall
 ret
     6d4:	8082                	ret

00000000000006d6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     6d6:	48d1                	li	a7,20
 ecall
     6d8:	00000073          	ecall
 ret
     6dc:	8082                	ret

00000000000006de <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     6de:	48a5                	li	a7,9
 ecall
     6e0:	00000073          	ecall
 ret
     6e4:	8082                	ret

00000000000006e6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     6e6:	48a9                	li	a7,10
 ecall
     6e8:	00000073          	ecall
 ret
     6ec:	8082                	ret

00000000000006ee <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     6ee:	48ad                	li	a7,11
 ecall
     6f0:	00000073          	ecall
 ret
     6f4:	8082                	ret

00000000000006f6 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     6f6:	48b1                	li	a7,12
 ecall
     6f8:	00000073          	ecall
 ret
     6fc:	8082                	ret

00000000000006fe <pause>:
.global pause
pause:
 li a7, SYS_pause
     6fe:	48b5                	li	a7,13
 ecall
     700:	00000073          	ecall
 ret
     704:	8082                	ret

0000000000000706 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     706:	48b9                	li	a7,14
 ecall
     708:	00000073          	ecall
 ret
     70c:	8082                	ret

000000000000070e <top>:
.global top
top:
 li a7, SYS_top
     70e:	48d9                	li	a7,22
 ecall
     710:	00000073          	ecall
 ret
     714:	8082                	ret

0000000000000716 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     716:	1101                	addi	sp,sp,-32
     718:	ec06                	sd	ra,24(sp)
     71a:	e822                	sd	s0,16(sp)
     71c:	1000                	addi	s0,sp,32
     71e:	87aa                	mv	a5,a0
     720:	872e                	mv	a4,a1
     722:	fef42623          	sw	a5,-20(s0)
     726:	87ba                	mv	a5,a4
     728:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     72c:	feb40713          	addi	a4,s0,-21
     730:	fec42783          	lw	a5,-20(s0)
     734:	4605                	li	a2,1
     736:	85ba                	mv	a1,a4
     738:	853e                	mv	a0,a5
     73a:	f55ff0ef          	jal	68e <write>
}
     73e:	0001                	nop
     740:	60e2                	ld	ra,24(sp)
     742:	6442                	ld	s0,16(sp)
     744:	6105                	addi	sp,sp,32
     746:	8082                	ret

0000000000000748 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     748:	711d                	addi	sp,sp,-96
     74a:	ec86                	sd	ra,88(sp)
     74c:	e8a2                	sd	s0,80(sp)
     74e:	1080                	addi	s0,sp,96
     750:	87aa                	mv	a5,a0
     752:	fab43823          	sd	a1,-80(s0)
     756:	8736                	mv	a4,a3
     758:	faf42e23          	sw	a5,-68(s0)
     75c:	87b2                	mv	a5,a2
     75e:	faf42c23          	sw	a5,-72(s0)
     762:	87ba                	mv	a5,a4
     764:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     768:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     76c:	fac42783          	lw	a5,-84(s0)
     770:	2781                	sext.w	a5,a5
     772:	cf99                	beqz	a5,790 <printint+0x48>
     774:	fb043783          	ld	a5,-80(s0)
     778:	0007dc63          	bgez	a5,790 <printint+0x48>
    neg = 1;
     77c:	4785                	li	a5,1
     77e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     782:	fb043783          	ld	a5,-80(s0)
     786:	40f007b3          	neg	a5,a5
     78a:	fef43023          	sd	a5,-32(s0)
     78e:	a029                	j	798 <printint+0x50>
  } else {
    x = xx;
     790:	fb043783          	ld	a5,-80(s0)
     794:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     798:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     79c:	fb842783          	lw	a5,-72(s0)
     7a0:	fe043703          	ld	a4,-32(s0)
     7a4:	02f77733          	remu	a4,a4,a5
     7a8:	fec42783          	lw	a5,-20(s0)
     7ac:	0017869b          	addiw	a3,a5,1
     7b0:	fed42623          	sw	a3,-20(s0)
     7b4:	00002697          	auipc	a3,0x2
     7b8:	84c68693          	addi	a3,a3,-1972 # 2000 <digits>
     7bc:	9736                	add	a4,a4,a3
     7be:	00074703          	lbu	a4,0(a4)
     7c2:	17c1                	addi	a5,a5,-16
     7c4:	97a2                	add	a5,a5,s0
     7c6:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     7ca:	fb842783          	lw	a5,-72(s0)
     7ce:	fe043703          	ld	a4,-32(s0)
     7d2:	02f757b3          	divu	a5,a4,a5
     7d6:	fef43023          	sd	a5,-32(s0)
     7da:	fe043783          	ld	a5,-32(s0)
     7de:	ffdd                	bnez	a5,79c <printint+0x54>
  if(neg)
     7e0:	fe842783          	lw	a5,-24(s0)
     7e4:	2781                	sext.w	a5,a5
     7e6:	cb95                	beqz	a5,81a <printint+0xd2>
    buf[i++] = '-';
     7e8:	fec42783          	lw	a5,-20(s0)
     7ec:	0017871b          	addiw	a4,a5,1
     7f0:	fee42623          	sw	a4,-20(s0)
     7f4:	17c1                	addi	a5,a5,-16
     7f6:	97a2                	add	a5,a5,s0
     7f8:	02d00713          	li	a4,45
     7fc:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     800:	a829                	j	81a <printint+0xd2>
    putc(fd, buf[i]);
     802:	fec42783          	lw	a5,-20(s0)
     806:	17c1                	addi	a5,a5,-16
     808:	97a2                	add	a5,a5,s0
     80a:	fd87c703          	lbu	a4,-40(a5)
     80e:	fbc42783          	lw	a5,-68(s0)
     812:	85ba                	mv	a1,a4
     814:	853e                	mv	a0,a5
     816:	f01ff0ef          	jal	716 <putc>
  while(--i >= 0)
     81a:	fec42783          	lw	a5,-20(s0)
     81e:	37fd                	addiw	a5,a5,-1
     820:	fef42623          	sw	a5,-20(s0)
     824:	fec42783          	lw	a5,-20(s0)
     828:	2781                	sext.w	a5,a5
     82a:	fc07dce3          	bgez	a5,802 <printint+0xba>
}
     82e:	0001                	nop
     830:	0001                	nop
     832:	60e6                	ld	ra,88(sp)
     834:	6446                	ld	s0,80(sp)
     836:	6125                	addi	sp,sp,96
     838:	8082                	ret

000000000000083a <printptr>:

static void
printptr(int fd, uint64 x) {
     83a:	7179                	addi	sp,sp,-48
     83c:	f406                	sd	ra,40(sp)
     83e:	f022                	sd	s0,32(sp)
     840:	1800                	addi	s0,sp,48
     842:	87aa                	mv	a5,a0
     844:	fcb43823          	sd	a1,-48(s0)
     848:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     84c:	fdc42783          	lw	a5,-36(s0)
     850:	03000593          	li	a1,48
     854:	853e                	mv	a0,a5
     856:	ec1ff0ef          	jal	716 <putc>
  putc(fd, 'x');
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	07800593          	li	a1,120
     862:	853e                	mv	a0,a5
     864:	eb3ff0ef          	jal	716 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     868:	fe042623          	sw	zero,-20(s0)
     86c:	a81d                	j	8a2 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     86e:	fd043783          	ld	a5,-48(s0)
     872:	93f1                	srli	a5,a5,0x3c
     874:	00001717          	auipc	a4,0x1
     878:	78c70713          	addi	a4,a4,1932 # 2000 <digits>
     87c:	97ba                	add	a5,a5,a4
     87e:	0007c703          	lbu	a4,0(a5)
     882:	fdc42783          	lw	a5,-36(s0)
     886:	85ba                	mv	a1,a4
     888:	853e                	mv	a0,a5
     88a:	e8dff0ef          	jal	716 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     88e:	fec42783          	lw	a5,-20(s0)
     892:	2785                	addiw	a5,a5,1
     894:	fef42623          	sw	a5,-20(s0)
     898:	fd043783          	ld	a5,-48(s0)
     89c:	0792                	slli	a5,a5,0x4
     89e:	fcf43823          	sd	a5,-48(s0)
     8a2:	fec42703          	lw	a4,-20(s0)
     8a6:	47bd                	li	a5,15
     8a8:	fce7f3e3          	bgeu	a5,a4,86e <printptr+0x34>
}
     8ac:	0001                	nop
     8ae:	0001                	nop
     8b0:	70a2                	ld	ra,40(sp)
     8b2:	7402                	ld	s0,32(sp)
     8b4:	6145                	addi	sp,sp,48
     8b6:	8082                	ret

00000000000008b8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8b8:	715d                	addi	sp,sp,-80
     8ba:	e486                	sd	ra,72(sp)
     8bc:	e0a2                	sd	s0,64(sp)
     8be:	0880                	addi	s0,sp,80
     8c0:	87aa                	mv	a5,a0
     8c2:	fcb43023          	sd	a1,-64(s0)
     8c6:	fac43c23          	sd	a2,-72(s0)
     8ca:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     8ce:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     8d2:	fc042e23          	sw	zero,-36(s0)
     8d6:	a189                	j	d18 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     8d8:	fdc42783          	lw	a5,-36(s0)
     8dc:	fc043703          	ld	a4,-64(s0)
     8e0:	97ba                	add	a5,a5,a4
     8e2:	0007c783          	lbu	a5,0(a5)
     8e6:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     8ea:	fd842783          	lw	a5,-40(s0)
     8ee:	2781                	sext.w	a5,a5
     8f0:	eb8d                	bnez	a5,922 <vprintf+0x6a>
      if(c0 == '%'){
     8f2:	fd442783          	lw	a5,-44(s0)
     8f6:	0007871b          	sext.w	a4,a5
     8fa:	02500793          	li	a5,37
     8fe:	00f71763          	bne	a4,a5,90c <vprintf+0x54>
        state = '%';
     902:	02500793          	li	a5,37
     906:	fcf42c23          	sw	a5,-40(s0)
     90a:	a111                	j	d0e <vprintf+0x456>
      } else {
        putc(fd, c0);
     90c:	fd442783          	lw	a5,-44(s0)
     910:	0ff7f713          	zext.b	a4,a5
     914:	fcc42783          	lw	a5,-52(s0)
     918:	85ba                	mv	a1,a4
     91a:	853e                	mv	a0,a5
     91c:	dfbff0ef          	jal	716 <putc>
     920:	a6fd                	j	d0e <vprintf+0x456>
      }
    } else if(state == '%'){
     922:	fd842783          	lw	a5,-40(s0)
     926:	0007871b          	sext.w	a4,a5
     92a:	02500793          	li	a5,37
     92e:	3ef71063          	bne	a4,a5,d0e <vprintf+0x456>
      c1 = c2 = 0;
     932:	fe042023          	sw	zero,-32(s0)
     936:	fe042783          	lw	a5,-32(s0)
     93a:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     93e:	fd442783          	lw	a5,-44(s0)
     942:	2781                	sext.w	a5,a5
     944:	cb99                	beqz	a5,95a <vprintf+0xa2>
     946:	fdc42783          	lw	a5,-36(s0)
     94a:	0785                	addi	a5,a5,1
     94c:	fc043703          	ld	a4,-64(s0)
     950:	97ba                	add	a5,a5,a4
     952:	0007c783          	lbu	a5,0(a5)
     956:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     95a:	fe442783          	lw	a5,-28(s0)
     95e:	2781                	sext.w	a5,a5
     960:	cb99                	beqz	a5,976 <vprintf+0xbe>
     962:	fdc42783          	lw	a5,-36(s0)
     966:	0789                	addi	a5,a5,2
     968:	fc043703          	ld	a4,-64(s0)
     96c:	97ba                	add	a5,a5,a4
     96e:	0007c783          	lbu	a5,0(a5)
     972:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     976:	fd442783          	lw	a5,-44(s0)
     97a:	0007871b          	sext.w	a4,a5
     97e:	06400793          	li	a5,100
     982:	02f71363          	bne	a4,a5,9a8 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     986:	fb843783          	ld	a5,-72(s0)
     98a:	00878713          	addi	a4,a5,8
     98e:	fae43c23          	sd	a4,-72(s0)
     992:	439c                	lw	a5,0(a5)
     994:	873e                	mv	a4,a5
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	4685                	li	a3,1
     99c:	4629                	li	a2,10
     99e:	85ba                	mv	a1,a4
     9a0:	853e                	mv	a0,a5
     9a2:	da7ff0ef          	jal	748 <printint>
     9a6:	a695                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9a8:	fd442783          	lw	a5,-44(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	06c00793          	li	a5,108
     9b4:	04f71063          	bne	a4,a5,9f4 <vprintf+0x13c>
     9b8:	fe442783          	lw	a5,-28(s0)
     9bc:	0007871b          	sext.w	a4,a5
     9c0:	06400793          	li	a5,100
     9c4:	02f71863          	bne	a4,a5,9f4 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9c8:	fb843783          	ld	a5,-72(s0)
     9cc:	00878713          	addi	a4,a5,8
     9d0:	fae43c23          	sd	a4,-72(s0)
     9d4:	639c                	ld	a5,0(a5)
     9d6:	873e                	mv	a4,a5
     9d8:	fcc42783          	lw	a5,-52(s0)
     9dc:	4685                	li	a3,1
     9de:	4629                	li	a2,10
     9e0:	85ba                	mv	a1,a4
     9e2:	853e                	mv	a0,a5
     9e4:	d65ff0ef          	jal	748 <printint>
        i += 1;
     9e8:	fdc42783          	lw	a5,-36(s0)
     9ec:	2785                	addiw	a5,a5,1
     9ee:	fcf42e23          	sw	a5,-36(s0)
     9f2:	ae21                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     9f4:	fd442783          	lw	a5,-44(s0)
     9f8:	0007871b          	sext.w	a4,a5
     9fc:	06c00793          	li	a5,108
     a00:	04f71863          	bne	a4,a5,a50 <vprintf+0x198>
     a04:	fe442783          	lw	a5,-28(s0)
     a08:	0007871b          	sext.w	a4,a5
     a0c:	06c00793          	li	a5,108
     a10:	04f71063          	bne	a4,a5,a50 <vprintf+0x198>
     a14:	fe042783          	lw	a5,-32(s0)
     a18:	0007871b          	sext.w	a4,a5
     a1c:	06400793          	li	a5,100
     a20:	02f71863          	bne	a4,a5,a50 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a24:	fb843783          	ld	a5,-72(s0)
     a28:	00878713          	addi	a4,a5,8
     a2c:	fae43c23          	sd	a4,-72(s0)
     a30:	639c                	ld	a5,0(a5)
     a32:	873e                	mv	a4,a5
     a34:	fcc42783          	lw	a5,-52(s0)
     a38:	4685                	li	a3,1
     a3a:	4629                	li	a2,10
     a3c:	85ba                	mv	a1,a4
     a3e:	853e                	mv	a0,a5
     a40:	d09ff0ef          	jal	748 <printint>
        i += 2;
     a44:	fdc42783          	lw	a5,-36(s0)
     a48:	2789                	addiw	a5,a5,2
     a4a:	fcf42e23          	sw	a5,-36(s0)
     a4e:	ac75                	j	d0a <vprintf+0x452>
      } else if(c0 == 'u'){
     a50:	fd442783          	lw	a5,-44(s0)
     a54:	0007871b          	sext.w	a4,a5
     a58:	07500793          	li	a5,117
     a5c:	02f71563          	bne	a4,a5,a86 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a60:	fb843783          	ld	a5,-72(s0)
     a64:	00878713          	addi	a4,a5,8
     a68:	fae43c23          	sd	a4,-72(s0)
     a6c:	439c                	lw	a5,0(a5)
     a6e:	02079713          	slli	a4,a5,0x20
     a72:	9301                	srli	a4,a4,0x20
     a74:	fcc42783          	lw	a5,-52(s0)
     a78:	4681                	li	a3,0
     a7a:	4629                	li	a2,10
     a7c:	85ba                	mv	a1,a4
     a7e:	853e                	mv	a0,a5
     a80:	cc9ff0ef          	jal	748 <printint>
     a84:	a459                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a86:	fd442783          	lw	a5,-44(s0)
     a8a:	0007871b          	sext.w	a4,a5
     a8e:	06c00793          	li	a5,108
     a92:	04f71063          	bne	a4,a5,ad2 <vprintf+0x21a>
     a96:	fe442783          	lw	a5,-28(s0)
     a9a:	0007871b          	sext.w	a4,a5
     a9e:	07500793          	li	a5,117
     aa2:	02f71863          	bne	a4,a5,ad2 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     aa6:	fb843783          	ld	a5,-72(s0)
     aaa:	00878713          	addi	a4,a5,8
     aae:	fae43c23          	sd	a4,-72(s0)
     ab2:	639c                	ld	a5,0(a5)
     ab4:	873e                	mv	a4,a5
     ab6:	fcc42783          	lw	a5,-52(s0)
     aba:	4681                	li	a3,0
     abc:	4629                	li	a2,10
     abe:	85ba                	mv	a1,a4
     ac0:	853e                	mv	a0,a5
     ac2:	c87ff0ef          	jal	748 <printint>
        i += 1;
     ac6:	fdc42783          	lw	a5,-36(s0)
     aca:	2785                	addiw	a5,a5,1
     acc:	fcf42e23          	sw	a5,-36(s0)
     ad0:	ac2d                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ad2:	fd442783          	lw	a5,-44(s0)
     ad6:	0007871b          	sext.w	a4,a5
     ada:	06c00793          	li	a5,108
     ade:	04f71863          	bne	a4,a5,b2e <vprintf+0x276>
     ae2:	fe442783          	lw	a5,-28(s0)
     ae6:	0007871b          	sext.w	a4,a5
     aea:	06c00793          	li	a5,108
     aee:	04f71063          	bne	a4,a5,b2e <vprintf+0x276>
     af2:	fe042783          	lw	a5,-32(s0)
     af6:	0007871b          	sext.w	a4,a5
     afa:	07500793          	li	a5,117
     afe:	02f71863          	bne	a4,a5,b2e <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b02:	fb843783          	ld	a5,-72(s0)
     b06:	00878713          	addi	a4,a5,8
     b0a:	fae43c23          	sd	a4,-72(s0)
     b0e:	639c                	ld	a5,0(a5)
     b10:	873e                	mv	a4,a5
     b12:	fcc42783          	lw	a5,-52(s0)
     b16:	4681                	li	a3,0
     b18:	4629                	li	a2,10
     b1a:	85ba                	mv	a1,a4
     b1c:	853e                	mv	a0,a5
     b1e:	c2bff0ef          	jal	748 <printint>
        i += 2;
     b22:	fdc42783          	lw	a5,-36(s0)
     b26:	2789                	addiw	a5,a5,2
     b28:	fcf42e23          	sw	a5,-36(s0)
     b2c:	aaf9                	j	d0a <vprintf+0x452>
      } else if(c0 == 'x'){
     b2e:	fd442783          	lw	a5,-44(s0)
     b32:	0007871b          	sext.w	a4,a5
     b36:	07800793          	li	a5,120
     b3a:	02f71563          	bne	a4,a5,b64 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b3e:	fb843783          	ld	a5,-72(s0)
     b42:	00878713          	addi	a4,a5,8
     b46:	fae43c23          	sd	a4,-72(s0)
     b4a:	439c                	lw	a5,0(a5)
     b4c:	02079713          	slli	a4,a5,0x20
     b50:	9301                	srli	a4,a4,0x20
     b52:	fcc42783          	lw	a5,-52(s0)
     b56:	4681                	li	a3,0
     b58:	4641                	li	a2,16
     b5a:	85ba                	mv	a1,a4
     b5c:	853e                	mv	a0,a5
     b5e:	bebff0ef          	jal	748 <printint>
     b62:	a265                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b64:	fd442783          	lw	a5,-44(s0)
     b68:	0007871b          	sext.w	a4,a5
     b6c:	06c00793          	li	a5,108
     b70:	04f71063          	bne	a4,a5,bb0 <vprintf+0x2f8>
     b74:	fe442783          	lw	a5,-28(s0)
     b78:	0007871b          	sext.w	a4,a5
     b7c:	07800793          	li	a5,120
     b80:	02f71863          	bne	a4,a5,bb0 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b84:	fb843783          	ld	a5,-72(s0)
     b88:	00878713          	addi	a4,a5,8
     b8c:	fae43c23          	sd	a4,-72(s0)
     b90:	639c                	ld	a5,0(a5)
     b92:	873e                	mv	a4,a5
     b94:	fcc42783          	lw	a5,-52(s0)
     b98:	4681                	li	a3,0
     b9a:	4641                	li	a2,16
     b9c:	85ba                	mv	a1,a4
     b9e:	853e                	mv	a0,a5
     ba0:	ba9ff0ef          	jal	748 <printint>
        i += 1;
     ba4:	fdc42783          	lw	a5,-36(s0)
     ba8:	2785                	addiw	a5,a5,1
     baa:	fcf42e23          	sw	a5,-36(s0)
     bae:	aab1                	j	d0a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     bb0:	fd442783          	lw	a5,-44(s0)
     bb4:	0007871b          	sext.w	a4,a5
     bb8:	06c00793          	li	a5,108
     bbc:	04f71863          	bne	a4,a5,c0c <vprintf+0x354>
     bc0:	fe442783          	lw	a5,-28(s0)
     bc4:	0007871b          	sext.w	a4,a5
     bc8:	06c00793          	li	a5,108
     bcc:	04f71063          	bne	a4,a5,c0c <vprintf+0x354>
     bd0:	fe042783          	lw	a5,-32(s0)
     bd4:	0007871b          	sext.w	a4,a5
     bd8:	07800793          	li	a5,120
     bdc:	02f71863          	bne	a4,a5,c0c <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     be0:	fb843783          	ld	a5,-72(s0)
     be4:	00878713          	addi	a4,a5,8
     be8:	fae43c23          	sd	a4,-72(s0)
     bec:	639c                	ld	a5,0(a5)
     bee:	873e                	mv	a4,a5
     bf0:	fcc42783          	lw	a5,-52(s0)
     bf4:	4681                	li	a3,0
     bf6:	4641                	li	a2,16
     bf8:	85ba                	mv	a1,a4
     bfa:	853e                	mv	a0,a5
     bfc:	b4dff0ef          	jal	748 <printint>
        i += 2;
     c00:	fdc42783          	lw	a5,-36(s0)
     c04:	2789                	addiw	a5,a5,2
     c06:	fcf42e23          	sw	a5,-36(s0)
     c0a:	a201                	j	d0a <vprintf+0x452>
      } else if(c0 == 'p'){
     c0c:	fd442783          	lw	a5,-44(s0)
     c10:	0007871b          	sext.w	a4,a5
     c14:	07000793          	li	a5,112
     c18:	02f71063          	bne	a4,a5,c38 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c1c:	fb843783          	ld	a5,-72(s0)
     c20:	00878713          	addi	a4,a5,8
     c24:	fae43c23          	sd	a4,-72(s0)
     c28:	6398                	ld	a4,0(a5)
     c2a:	fcc42783          	lw	a5,-52(s0)
     c2e:	85ba                	mv	a1,a4
     c30:	853e                	mv	a0,a5
     c32:	c09ff0ef          	jal	83a <printptr>
     c36:	a8d1                	j	d0a <vprintf+0x452>
      } else if(c0 == 'c'){
     c38:	fd442783          	lw	a5,-44(s0)
     c3c:	0007871b          	sext.w	a4,a5
     c40:	06300793          	li	a5,99
     c44:	02f71263          	bne	a4,a5,c68 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c48:	fb843783          	ld	a5,-72(s0)
     c4c:	00878713          	addi	a4,a5,8
     c50:	fae43c23          	sd	a4,-72(s0)
     c54:	439c                	lw	a5,0(a5)
     c56:	0ff7f713          	zext.b	a4,a5
     c5a:	fcc42783          	lw	a5,-52(s0)
     c5e:	85ba                	mv	a1,a4
     c60:	853e                	mv	a0,a5
     c62:	ab5ff0ef          	jal	716 <putc>
     c66:	a055                	j	d0a <vprintf+0x452>
      } else if(c0 == 's'){
     c68:	fd442783          	lw	a5,-44(s0)
     c6c:	0007871b          	sext.w	a4,a5
     c70:	07300793          	li	a5,115
     c74:	04f71a63          	bne	a4,a5,cc8 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c78:	fb843783          	ld	a5,-72(s0)
     c7c:	00878713          	addi	a4,a5,8
     c80:	fae43c23          	sd	a4,-72(s0)
     c84:	639c                	ld	a5,0(a5)
     c86:	fef43423          	sd	a5,-24(s0)
     c8a:	fe843783          	ld	a5,-24(s0)
     c8e:	e79d                	bnez	a5,cbc <vprintf+0x404>
          s = "(null)";
     c90:	00000797          	auipc	a5,0x0
     c94:	46078793          	addi	a5,a5,1120 # 10f0 <malloc+0x17e>
     c98:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c9c:	a005                	j	cbc <vprintf+0x404>
          putc(fd, *s);
     c9e:	fe843783          	ld	a5,-24(s0)
     ca2:	0007c703          	lbu	a4,0(a5)
     ca6:	fcc42783          	lw	a5,-52(s0)
     caa:	85ba                	mv	a1,a4
     cac:	853e                	mv	a0,a5
     cae:	a69ff0ef          	jal	716 <putc>
        for(; *s; s++)
     cb2:	fe843783          	ld	a5,-24(s0)
     cb6:	0785                	addi	a5,a5,1
     cb8:	fef43423          	sd	a5,-24(s0)
     cbc:	fe843783          	ld	a5,-24(s0)
     cc0:	0007c783          	lbu	a5,0(a5)
     cc4:	ffe9                	bnez	a5,c9e <vprintf+0x3e6>
     cc6:	a091                	j	d0a <vprintf+0x452>
      } else if(c0 == '%'){
     cc8:	fd442783          	lw	a5,-44(s0)
     ccc:	0007871b          	sext.w	a4,a5
     cd0:	02500793          	li	a5,37
     cd4:	00f71a63          	bne	a4,a5,ce8 <vprintf+0x430>
        putc(fd, '%');
     cd8:	fcc42783          	lw	a5,-52(s0)
     cdc:	02500593          	li	a1,37
     ce0:	853e                	mv	a0,a5
     ce2:	a35ff0ef          	jal	716 <putc>
     ce6:	a015                	j	d0a <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ce8:	fcc42783          	lw	a5,-52(s0)
     cec:	02500593          	li	a1,37
     cf0:	853e                	mv	a0,a5
     cf2:	a25ff0ef          	jal	716 <putc>
        putc(fd, c0);
     cf6:	fd442783          	lw	a5,-44(s0)
     cfa:	0ff7f713          	zext.b	a4,a5
     cfe:	fcc42783          	lw	a5,-52(s0)
     d02:	85ba                	mv	a1,a4
     d04:	853e                	mv	a0,a5
     d06:	a11ff0ef          	jal	716 <putc>
      }

      state = 0;
     d0a:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d0e:	fdc42783          	lw	a5,-36(s0)
     d12:	2785                	addiw	a5,a5,1
     d14:	fcf42e23          	sw	a5,-36(s0)
     d18:	fdc42783          	lw	a5,-36(s0)
     d1c:	fc043703          	ld	a4,-64(s0)
     d20:	97ba                	add	a5,a5,a4
     d22:	0007c783          	lbu	a5,0(a5)
     d26:	ba0799e3          	bnez	a5,8d8 <vprintf+0x20>
    }
  }
}
     d2a:	0001                	nop
     d2c:	0001                	nop
     d2e:	60a6                	ld	ra,72(sp)
     d30:	6406                	ld	s0,64(sp)
     d32:	6161                	addi	sp,sp,80
     d34:	8082                	ret

0000000000000d36 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d36:	7159                	addi	sp,sp,-112
     d38:	fc06                	sd	ra,56(sp)
     d3a:	f822                	sd	s0,48(sp)
     d3c:	0080                	addi	s0,sp,64
     d3e:	fcb43823          	sd	a1,-48(s0)
     d42:	e010                	sd	a2,0(s0)
     d44:	e414                	sd	a3,8(s0)
     d46:	e818                	sd	a4,16(s0)
     d48:	ec1c                	sd	a5,24(s0)
     d4a:	03043023          	sd	a6,32(s0)
     d4e:	03143423          	sd	a7,40(s0)
     d52:	87aa                	mv	a5,a0
     d54:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d58:	03040793          	addi	a5,s0,48
     d5c:	fcf43423          	sd	a5,-56(s0)
     d60:	fc843783          	ld	a5,-56(s0)
     d64:	fd078793          	addi	a5,a5,-48
     d68:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d6c:	fe843703          	ld	a4,-24(s0)
     d70:	fdc42783          	lw	a5,-36(s0)
     d74:	863a                	mv	a2,a4
     d76:	fd043583          	ld	a1,-48(s0)
     d7a:	853e                	mv	a0,a5
     d7c:	b3dff0ef          	jal	8b8 <vprintf>
}
     d80:	0001                	nop
     d82:	70e2                	ld	ra,56(sp)
     d84:	7442                	ld	s0,48(sp)
     d86:	6165                	addi	sp,sp,112
     d88:	8082                	ret

0000000000000d8a <printf>:

void
printf(const char *fmt, ...)
{
     d8a:	7159                	addi	sp,sp,-112
     d8c:	f406                	sd	ra,40(sp)
     d8e:	f022                	sd	s0,32(sp)
     d90:	1800                	addi	s0,sp,48
     d92:	fca43c23          	sd	a0,-40(s0)
     d96:	e40c                	sd	a1,8(s0)
     d98:	e810                	sd	a2,16(s0)
     d9a:	ec14                	sd	a3,24(s0)
     d9c:	f018                	sd	a4,32(s0)
     d9e:	f41c                	sd	a5,40(s0)
     da0:	03043823          	sd	a6,48(s0)
     da4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     da8:	04040793          	addi	a5,s0,64
     dac:	fcf43823          	sd	a5,-48(s0)
     db0:	fd043783          	ld	a5,-48(s0)
     db4:	fc878793          	addi	a5,a5,-56
     db8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	863e                	mv	a2,a5
     dc2:	fd843583          	ld	a1,-40(s0)
     dc6:	4505                	li	a0,1
     dc8:	af1ff0ef          	jal	8b8 <vprintf>
}
     dcc:	0001                	nop
     dce:	70a2                	ld	ra,40(sp)
     dd0:	7402                	ld	s0,32(sp)
     dd2:	6165                	addi	sp,sp,112
     dd4:	8082                	ret

0000000000000dd6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dd6:	7179                	addi	sp,sp,-48
     dd8:	f406                	sd	ra,40(sp)
     dda:	f022                	sd	s0,32(sp)
     ddc:	1800                	addi	s0,sp,48
     dde:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     de2:	fd843783          	ld	a5,-40(s0)
     de6:	17c1                	addi	a5,a5,-16
     de8:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dec:	00001797          	auipc	a5,0x1
     df0:	24478793          	addi	a5,a5,580 # 2030 <freep>
     df4:	639c                	ld	a5,0(a5)
     df6:	fef43423          	sd	a5,-24(s0)
     dfa:	a815                	j	e2e <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	639c                	ld	a5,0(a5)
     e02:	fe843703          	ld	a4,-24(s0)
     e06:	00f76f63          	bltu	a4,a5,e24 <free+0x4e>
     e0a:	fe043703          	ld	a4,-32(s0)
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	02e7eb63          	bltu	a5,a4,e48 <free+0x72>
     e16:	fe843783          	ld	a5,-24(s0)
     e1a:	639c                	ld	a5,0(a5)
     e1c:	fe043703          	ld	a4,-32(s0)
     e20:	02f76463          	bltu	a4,a5,e48 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	639c                	ld	a5,0(a5)
     e2a:	fef43423          	sd	a5,-24(s0)
     e2e:	fe043703          	ld	a4,-32(s0)
     e32:	fe843783          	ld	a5,-24(s0)
     e36:	fce7f3e3          	bgeu	a5,a4,dfc <free+0x26>
     e3a:	fe843783          	ld	a5,-24(s0)
     e3e:	639c                	ld	a5,0(a5)
     e40:	fe043703          	ld	a4,-32(s0)
     e44:	faf77ce3          	bgeu	a4,a5,dfc <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e48:	fe043783          	ld	a5,-32(s0)
     e4c:	479c                	lw	a5,8(a5)
     e4e:	1782                	slli	a5,a5,0x20
     e50:	9381                	srli	a5,a5,0x20
     e52:	0792                	slli	a5,a5,0x4
     e54:	fe043703          	ld	a4,-32(s0)
     e58:	973e                	add	a4,a4,a5
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	639c                	ld	a5,0(a5)
     e60:	02f71763          	bne	a4,a5,e8e <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e64:	fe043783          	ld	a5,-32(s0)
     e68:	4798                	lw	a4,8(a5)
     e6a:	fe843783          	ld	a5,-24(s0)
     e6e:	639c                	ld	a5,0(a5)
     e70:	479c                	lw	a5,8(a5)
     e72:	9fb9                	addw	a5,a5,a4
     e74:	0007871b          	sext.w	a4,a5
     e78:	fe043783          	ld	a5,-32(s0)
     e7c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e7e:	fe843783          	ld	a5,-24(s0)
     e82:	639c                	ld	a5,0(a5)
     e84:	6398                	ld	a4,0(a5)
     e86:	fe043783          	ld	a5,-32(s0)
     e8a:	e398                	sd	a4,0(a5)
     e8c:	a039                	j	e9a <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e8e:	fe843783          	ld	a5,-24(s0)
     e92:	6398                	ld	a4,0(a5)
     e94:	fe043783          	ld	a5,-32(s0)
     e98:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e9a:	fe843783          	ld	a5,-24(s0)
     e9e:	479c                	lw	a5,8(a5)
     ea0:	1782                	slli	a5,a5,0x20
     ea2:	9381                	srli	a5,a5,0x20
     ea4:	0792                	slli	a5,a5,0x4
     ea6:	fe843703          	ld	a4,-24(s0)
     eaa:	97ba                	add	a5,a5,a4
     eac:	fe043703          	ld	a4,-32(s0)
     eb0:	02f71563          	bne	a4,a5,eda <free+0x104>
    p->s.size += bp->s.size;
     eb4:	fe843783          	ld	a5,-24(s0)
     eb8:	4798                	lw	a4,8(a5)
     eba:	fe043783          	ld	a5,-32(s0)
     ebe:	479c                	lw	a5,8(a5)
     ec0:	9fb9                	addw	a5,a5,a4
     ec2:	0007871b          	sext.w	a4,a5
     ec6:	fe843783          	ld	a5,-24(s0)
     eca:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ecc:	fe043783          	ld	a5,-32(s0)
     ed0:	6398                	ld	a4,0(a5)
     ed2:	fe843783          	ld	a5,-24(s0)
     ed6:	e398                	sd	a4,0(a5)
     ed8:	a031                	j	ee4 <free+0x10e>
  } else
    p->s.ptr = bp;
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	fe043703          	ld	a4,-32(s0)
     ee2:	e398                	sd	a4,0(a5)
  freep = p;
     ee4:	00001797          	auipc	a5,0x1
     ee8:	14c78793          	addi	a5,a5,332 # 2030 <freep>
     eec:	fe843703          	ld	a4,-24(s0)
     ef0:	e398                	sd	a4,0(a5)
}
     ef2:	0001                	nop
     ef4:	70a2                	ld	ra,40(sp)
     ef6:	7402                	ld	s0,32(sp)
     ef8:	6145                	addi	sp,sp,48
     efa:	8082                	ret

0000000000000efc <morecore>:

static Header*
morecore(uint nu)
{
     efc:	7179                	addi	sp,sp,-48
     efe:	f406                	sd	ra,40(sp)
     f00:	f022                	sd	s0,32(sp)
     f02:	1800                	addi	s0,sp,48
     f04:	87aa                	mv	a5,a0
     f06:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f0a:	fdc42783          	lw	a5,-36(s0)
     f0e:	0007871b          	sext.w	a4,a5
     f12:	6785                	lui	a5,0x1
     f14:	00f77563          	bgeu	a4,a5,f1e <morecore+0x22>
    nu = 4096;
     f18:	6785                	lui	a5,0x1
     f1a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f1e:	fdc42783          	lw	a5,-36(s0)
     f22:	0047979b          	slliw	a5,a5,0x4
     f26:	2781                	sext.w	a5,a5
     f28:	853e                	mv	a0,a5
     f2a:	ef0ff0ef          	jal	61a <sbrk>
     f2e:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f32:	fe843703          	ld	a4,-24(s0)
     f36:	57fd                	li	a5,-1
     f38:	00f71463          	bne	a4,a5,f40 <morecore+0x44>
    return 0;
     f3c:	4781                	li	a5,0
     f3e:	a02d                	j	f68 <morecore+0x6c>
  hp = (Header*)p;
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f48:	fe043783          	ld	a5,-32(s0)
     f4c:	fdc42703          	lw	a4,-36(s0)
     f50:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f52:	fe043783          	ld	a5,-32(s0)
     f56:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x9e>
     f58:	853e                	mv	a0,a5
     f5a:	e7dff0ef          	jal	dd6 <free>
  return freep;
     f5e:	00001797          	auipc	a5,0x1
     f62:	0d278793          	addi	a5,a5,210 # 2030 <freep>
     f66:	639c                	ld	a5,0(a5)
}
     f68:	853e                	mv	a0,a5
     f6a:	70a2                	ld	ra,40(sp)
     f6c:	7402                	ld	s0,32(sp)
     f6e:	6145                	addi	sp,sp,48
     f70:	8082                	ret

0000000000000f72 <malloc>:

void*
malloc(uint nbytes)
{
     f72:	7139                	addi	sp,sp,-64
     f74:	fc06                	sd	ra,56(sp)
     f76:	f822                	sd	s0,48(sp)
     f78:	0080                	addi	s0,sp,64
     f7a:	87aa                	mv	a5,a0
     f7c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f80:	fcc46783          	lwu	a5,-52(s0)
     f84:	07bd                	addi	a5,a5,15
     f86:	8391                	srli	a5,a5,0x4
     f88:	2781                	sext.w	a5,a5
     f8a:	2785                	addiw	a5,a5,1
     f8c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f90:	00001797          	auipc	a5,0x1
     f94:	0a078793          	addi	a5,a5,160 # 2030 <freep>
     f98:	639c                	ld	a5,0(a5)
     f9a:	fef43023          	sd	a5,-32(s0)
     f9e:	fe043783          	ld	a5,-32(s0)
     fa2:	ef95                	bnez	a5,fde <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fa4:	00001797          	auipc	a5,0x1
     fa8:	07c78793          	addi	a5,a5,124 # 2020 <base>
     fac:	fef43023          	sd	a5,-32(s0)
     fb0:	00001797          	auipc	a5,0x1
     fb4:	08078793          	addi	a5,a5,128 # 2030 <freep>
     fb8:	fe043703          	ld	a4,-32(s0)
     fbc:	e398                	sd	a4,0(a5)
     fbe:	00001797          	auipc	a5,0x1
     fc2:	07278793          	addi	a5,a5,114 # 2030 <freep>
     fc6:	6398                	ld	a4,0(a5)
     fc8:	00001797          	auipc	a5,0x1
     fcc:	05878793          	addi	a5,a5,88 # 2020 <base>
     fd0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fd2:	00001797          	auipc	a5,0x1
     fd6:	04e78793          	addi	a5,a5,78 # 2020 <base>
     fda:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fde:	fe043783          	ld	a5,-32(s0)
     fe2:	639c                	ld	a5,0(a5)
     fe4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fe8:	fe843783          	ld	a5,-24(s0)
     fec:	479c                	lw	a5,8(a5)
     fee:	fdc42703          	lw	a4,-36(s0)
     ff2:	2701                	sext.w	a4,a4
     ff4:	06e7e763          	bltu	a5,a4,1062 <malloc+0xf0>
      if(p->s.size == nunits)
     ff8:	fe843783          	ld	a5,-24(s0)
     ffc:	479c                	lw	a5,8(a5)
     ffe:	fdc42703          	lw	a4,-36(s0)
    1002:	2701                	sext.w	a4,a4
    1004:	00f71963          	bne	a4,a5,1016 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	6398                	ld	a4,0(a5)
    100e:	fe043783          	ld	a5,-32(s0)
    1012:	e398                	sd	a4,0(a5)
    1014:	a825                	j	104c <malloc+0xda>
      else {
        p->s.size -= nunits;
    1016:	fe843783          	ld	a5,-24(s0)
    101a:	479c                	lw	a5,8(a5)
    101c:	fdc42703          	lw	a4,-36(s0)
    1020:	9f99                	subw	a5,a5,a4
    1022:	0007871b          	sext.w	a4,a5
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    102c:	fe843783          	ld	a5,-24(s0)
    1030:	479c                	lw	a5,8(a5)
    1032:	1782                	slli	a5,a5,0x20
    1034:	9381                	srli	a5,a5,0x20
    1036:	0792                	slli	a5,a5,0x4
    1038:	fe843703          	ld	a4,-24(s0)
    103c:	97ba                	add	a5,a5,a4
    103e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1042:	fe843783          	ld	a5,-24(s0)
    1046:	fdc42703          	lw	a4,-36(s0)
    104a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    104c:	00001797          	auipc	a5,0x1
    1050:	fe478793          	addi	a5,a5,-28 # 2030 <freep>
    1054:	fe043703          	ld	a4,-32(s0)
    1058:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    105a:	fe843783          	ld	a5,-24(s0)
    105e:	07c1                	addi	a5,a5,16
    1060:	a081                	j	10a0 <malloc+0x12e>
    }
    if(p == freep)
    1062:	00001797          	auipc	a5,0x1
    1066:	fce78793          	addi	a5,a5,-50 # 2030 <freep>
    106a:	639c                	ld	a5,0(a5)
    106c:	fe843703          	ld	a4,-24(s0)
    1070:	00f71e63          	bne	a4,a5,108c <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1074:	fdc42783          	lw	a5,-36(s0)
    1078:	853e                	mv	a0,a5
    107a:	e83ff0ef          	jal	efc <morecore>
    107e:	fea43423          	sd	a0,-24(s0)
    1082:	fe843783          	ld	a5,-24(s0)
    1086:	e399                	bnez	a5,108c <malloc+0x11a>
        return 0;
    1088:	4781                	li	a5,0
    108a:	a819                	j	10a0 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    108c:	fe843783          	ld	a5,-24(s0)
    1090:	fef43023          	sd	a5,-32(s0)
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	639c                	ld	a5,0(a5)
    109a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    109e:	b7a9                	j	fe8 <malloc+0x76>
  }
}
    10a0:	853e                	mv	a0,a5
    10a2:	70e2                	ld	ra,56(sp)
    10a4:	7442                	ld	s0,48(sp)
    10a6:	6121                	addi	sp,sp,64
    10a8:	8082                	ret
