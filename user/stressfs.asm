
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
      1c:	0d878793          	addi	a5,a5,216 # 10f0 <malloc+0x176>
      20:	6398                	ld	a4,0(a5)
      22:	fce43c23          	sd	a4,-40(s0)
      26:	0087d783          	lhu	a5,8(a5)
      2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
      2e:	00001517          	auipc	a0,0x1
      32:	09250513          	addi	a0,a0,146 # 10c0 <malloc+0x146>
      36:	55d000ef          	jal	d92 <printf>
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
      82:	05a50513          	addi	a0,a0,90 # 10d8 <malloc+0x15e>
      86:	50d000ef          	jal	d92 <printf>

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
      f4:	ff850513          	addi	a0,a0,-8 # 10e8 <malloc+0x16e>
      f8:	49b000ef          	jal	d92 <printf>

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

0000000000000716 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     716:	48dd                	li	a7,23
 ecall
     718:	00000073          	ecall
 ret
     71c:	8082                	ret

000000000000071e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     71e:	1101                	addi	sp,sp,-32
     720:	ec06                	sd	ra,24(sp)
     722:	e822                	sd	s0,16(sp)
     724:	1000                	addi	s0,sp,32
     726:	87aa                	mv	a5,a0
     728:	872e                	mv	a4,a1
     72a:	fef42623          	sw	a5,-20(s0)
     72e:	87ba                	mv	a5,a4
     730:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     734:	feb40713          	addi	a4,s0,-21
     738:	fec42783          	lw	a5,-20(s0)
     73c:	4605                	li	a2,1
     73e:	85ba                	mv	a1,a4
     740:	853e                	mv	a0,a5
     742:	f4dff0ef          	jal	68e <write>
}
     746:	0001                	nop
     748:	60e2                	ld	ra,24(sp)
     74a:	6442                	ld	s0,16(sp)
     74c:	6105                	addi	sp,sp,32
     74e:	8082                	ret

0000000000000750 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     750:	711d                	addi	sp,sp,-96
     752:	ec86                	sd	ra,88(sp)
     754:	e8a2                	sd	s0,80(sp)
     756:	1080                	addi	s0,sp,96
     758:	87aa                	mv	a5,a0
     75a:	fab43823          	sd	a1,-80(s0)
     75e:	8736                	mv	a4,a3
     760:	faf42e23          	sw	a5,-68(s0)
     764:	87b2                	mv	a5,a2
     766:	faf42c23          	sw	a5,-72(s0)
     76a:	87ba                	mv	a5,a4
     76c:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     770:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     774:	fac42783          	lw	a5,-84(s0)
     778:	2781                	sext.w	a5,a5
     77a:	cf99                	beqz	a5,798 <printint+0x48>
     77c:	fb043783          	ld	a5,-80(s0)
     780:	0007dc63          	bgez	a5,798 <printint+0x48>
    neg = 1;
     784:	4785                	li	a5,1
     786:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     78a:	fb043783          	ld	a5,-80(s0)
     78e:	40f007b3          	neg	a5,a5
     792:	fef43023          	sd	a5,-32(s0)
     796:	a029                	j	7a0 <printint+0x50>
  } else {
    x = xx;
     798:	fb043783          	ld	a5,-80(s0)
     79c:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     7a0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7a4:	fb842783          	lw	a5,-72(s0)
     7a8:	fe043703          	ld	a4,-32(s0)
     7ac:	02f77733          	remu	a4,a4,a5
     7b0:	fec42783          	lw	a5,-20(s0)
     7b4:	0017869b          	addiw	a3,a5,1
     7b8:	fed42623          	sw	a3,-20(s0)
     7bc:	00002697          	auipc	a3,0x2
     7c0:	84468693          	addi	a3,a3,-1980 # 2000 <digits>
     7c4:	9736                	add	a4,a4,a3
     7c6:	00074703          	lbu	a4,0(a4)
     7ca:	17c1                	addi	a5,a5,-16
     7cc:	97a2                	add	a5,a5,s0
     7ce:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     7d2:	fb842783          	lw	a5,-72(s0)
     7d6:	fe043703          	ld	a4,-32(s0)
     7da:	02f757b3          	divu	a5,a4,a5
     7de:	fef43023          	sd	a5,-32(s0)
     7e2:	fe043783          	ld	a5,-32(s0)
     7e6:	ffdd                	bnez	a5,7a4 <printint+0x54>
  if(neg)
     7e8:	fe842783          	lw	a5,-24(s0)
     7ec:	2781                	sext.w	a5,a5
     7ee:	cb95                	beqz	a5,822 <printint+0xd2>
    buf[i++] = '-';
     7f0:	fec42783          	lw	a5,-20(s0)
     7f4:	0017871b          	addiw	a4,a5,1
     7f8:	fee42623          	sw	a4,-20(s0)
     7fc:	17c1                	addi	a5,a5,-16
     7fe:	97a2                	add	a5,a5,s0
     800:	02d00713          	li	a4,45
     804:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     808:	a829                	j	822 <printint+0xd2>
    putc(fd, buf[i]);
     80a:	fec42783          	lw	a5,-20(s0)
     80e:	17c1                	addi	a5,a5,-16
     810:	97a2                	add	a5,a5,s0
     812:	fd87c703          	lbu	a4,-40(a5)
     816:	fbc42783          	lw	a5,-68(s0)
     81a:	85ba                	mv	a1,a4
     81c:	853e                	mv	a0,a5
     81e:	f01ff0ef          	jal	71e <putc>
  while(--i >= 0)
     822:	fec42783          	lw	a5,-20(s0)
     826:	37fd                	addiw	a5,a5,-1
     828:	fef42623          	sw	a5,-20(s0)
     82c:	fec42783          	lw	a5,-20(s0)
     830:	2781                	sext.w	a5,a5
     832:	fc07dce3          	bgez	a5,80a <printint+0xba>
}
     836:	0001                	nop
     838:	0001                	nop
     83a:	60e6                	ld	ra,88(sp)
     83c:	6446                	ld	s0,80(sp)
     83e:	6125                	addi	sp,sp,96
     840:	8082                	ret

0000000000000842 <printptr>:

static void
printptr(int fd, uint64 x) {
     842:	7179                	addi	sp,sp,-48
     844:	f406                	sd	ra,40(sp)
     846:	f022                	sd	s0,32(sp)
     848:	1800                	addi	s0,sp,48
     84a:	87aa                	mv	a5,a0
     84c:	fcb43823          	sd	a1,-48(s0)
     850:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     854:	fdc42783          	lw	a5,-36(s0)
     858:	03000593          	li	a1,48
     85c:	853e                	mv	a0,a5
     85e:	ec1ff0ef          	jal	71e <putc>
  putc(fd, 'x');
     862:	fdc42783          	lw	a5,-36(s0)
     866:	07800593          	li	a1,120
     86a:	853e                	mv	a0,a5
     86c:	eb3ff0ef          	jal	71e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     870:	fe042623          	sw	zero,-20(s0)
     874:	a81d                	j	8aa <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     876:	fd043783          	ld	a5,-48(s0)
     87a:	93f1                	srli	a5,a5,0x3c
     87c:	00001717          	auipc	a4,0x1
     880:	78470713          	addi	a4,a4,1924 # 2000 <digits>
     884:	97ba                	add	a5,a5,a4
     886:	0007c703          	lbu	a4,0(a5)
     88a:	fdc42783          	lw	a5,-36(s0)
     88e:	85ba                	mv	a1,a4
     890:	853e                	mv	a0,a5
     892:	e8dff0ef          	jal	71e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     896:	fec42783          	lw	a5,-20(s0)
     89a:	2785                	addiw	a5,a5,1
     89c:	fef42623          	sw	a5,-20(s0)
     8a0:	fd043783          	ld	a5,-48(s0)
     8a4:	0792                	slli	a5,a5,0x4
     8a6:	fcf43823          	sd	a5,-48(s0)
     8aa:	fec42703          	lw	a4,-20(s0)
     8ae:	47bd                	li	a5,15
     8b0:	fce7f3e3          	bgeu	a5,a4,876 <printptr+0x34>
}
     8b4:	0001                	nop
     8b6:	0001                	nop
     8b8:	70a2                	ld	ra,40(sp)
     8ba:	7402                	ld	s0,32(sp)
     8bc:	6145                	addi	sp,sp,48
     8be:	8082                	ret

00000000000008c0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8c0:	715d                	addi	sp,sp,-80
     8c2:	e486                	sd	ra,72(sp)
     8c4:	e0a2                	sd	s0,64(sp)
     8c6:	0880                	addi	s0,sp,80
     8c8:	87aa                	mv	a5,a0
     8ca:	fcb43023          	sd	a1,-64(s0)
     8ce:	fac43c23          	sd	a2,-72(s0)
     8d2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     8d6:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     8da:	fc042e23          	sw	zero,-36(s0)
     8de:	a189                	j	d20 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     8e0:	fdc42783          	lw	a5,-36(s0)
     8e4:	fc043703          	ld	a4,-64(s0)
     8e8:	97ba                	add	a5,a5,a4
     8ea:	0007c783          	lbu	a5,0(a5)
     8ee:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     8f2:	fd842783          	lw	a5,-40(s0)
     8f6:	2781                	sext.w	a5,a5
     8f8:	eb8d                	bnez	a5,92a <vprintf+0x6a>
      if(c0 == '%'){
     8fa:	fd442783          	lw	a5,-44(s0)
     8fe:	0007871b          	sext.w	a4,a5
     902:	02500793          	li	a5,37
     906:	00f71763          	bne	a4,a5,914 <vprintf+0x54>
        state = '%';
     90a:	02500793          	li	a5,37
     90e:	fcf42c23          	sw	a5,-40(s0)
     912:	a111                	j	d16 <vprintf+0x456>
      } else {
        putc(fd, c0);
     914:	fd442783          	lw	a5,-44(s0)
     918:	0ff7f713          	zext.b	a4,a5
     91c:	fcc42783          	lw	a5,-52(s0)
     920:	85ba                	mv	a1,a4
     922:	853e                	mv	a0,a5
     924:	dfbff0ef          	jal	71e <putc>
     928:	a6fd                	j	d16 <vprintf+0x456>
      }
    } else if(state == '%'){
     92a:	fd842783          	lw	a5,-40(s0)
     92e:	0007871b          	sext.w	a4,a5
     932:	02500793          	li	a5,37
     936:	3ef71063          	bne	a4,a5,d16 <vprintf+0x456>
      c1 = c2 = 0;
     93a:	fe042023          	sw	zero,-32(s0)
     93e:	fe042783          	lw	a5,-32(s0)
     942:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     946:	fd442783          	lw	a5,-44(s0)
     94a:	2781                	sext.w	a5,a5
     94c:	cb99                	beqz	a5,962 <vprintf+0xa2>
     94e:	fdc42783          	lw	a5,-36(s0)
     952:	0785                	addi	a5,a5,1
     954:	fc043703          	ld	a4,-64(s0)
     958:	97ba                	add	a5,a5,a4
     95a:	0007c783          	lbu	a5,0(a5)
     95e:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     962:	fe442783          	lw	a5,-28(s0)
     966:	2781                	sext.w	a5,a5
     968:	cb99                	beqz	a5,97e <vprintf+0xbe>
     96a:	fdc42783          	lw	a5,-36(s0)
     96e:	0789                	addi	a5,a5,2
     970:	fc043703          	ld	a4,-64(s0)
     974:	97ba                	add	a5,a5,a4
     976:	0007c783          	lbu	a5,0(a5)
     97a:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     97e:	fd442783          	lw	a5,-44(s0)
     982:	0007871b          	sext.w	a4,a5
     986:	06400793          	li	a5,100
     98a:	02f71363          	bne	a4,a5,9b0 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     98e:	fb843783          	ld	a5,-72(s0)
     992:	00878713          	addi	a4,a5,8
     996:	fae43c23          	sd	a4,-72(s0)
     99a:	439c                	lw	a5,0(a5)
     99c:	873e                	mv	a4,a5
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	4685                	li	a3,1
     9a4:	4629                	li	a2,10
     9a6:	85ba                	mv	a1,a4
     9a8:	853e                	mv	a0,a5
     9aa:	da7ff0ef          	jal	750 <printint>
     9ae:	a695                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9b0:	fd442783          	lw	a5,-44(s0)
     9b4:	0007871b          	sext.w	a4,a5
     9b8:	06c00793          	li	a5,108
     9bc:	04f71063          	bne	a4,a5,9fc <vprintf+0x13c>
     9c0:	fe442783          	lw	a5,-28(s0)
     9c4:	0007871b          	sext.w	a4,a5
     9c8:	06400793          	li	a5,100
     9cc:	02f71863          	bne	a4,a5,9fc <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9d0:	fb843783          	ld	a5,-72(s0)
     9d4:	00878713          	addi	a4,a5,8
     9d8:	fae43c23          	sd	a4,-72(s0)
     9dc:	639c                	ld	a5,0(a5)
     9de:	873e                	mv	a4,a5
     9e0:	fcc42783          	lw	a5,-52(s0)
     9e4:	4685                	li	a3,1
     9e6:	4629                	li	a2,10
     9e8:	85ba                	mv	a1,a4
     9ea:	853e                	mv	a0,a5
     9ec:	d65ff0ef          	jal	750 <printint>
        i += 1;
     9f0:	fdc42783          	lw	a5,-36(s0)
     9f4:	2785                	addiw	a5,a5,1
     9f6:	fcf42e23          	sw	a5,-36(s0)
     9fa:	ae21                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     9fc:	fd442783          	lw	a5,-44(s0)
     a00:	0007871b          	sext.w	a4,a5
     a04:	06c00793          	li	a5,108
     a08:	04f71863          	bne	a4,a5,a58 <vprintf+0x198>
     a0c:	fe442783          	lw	a5,-28(s0)
     a10:	0007871b          	sext.w	a4,a5
     a14:	06c00793          	li	a5,108
     a18:	04f71063          	bne	a4,a5,a58 <vprintf+0x198>
     a1c:	fe042783          	lw	a5,-32(s0)
     a20:	0007871b          	sext.w	a4,a5
     a24:	06400793          	li	a5,100
     a28:	02f71863          	bne	a4,a5,a58 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a2c:	fb843783          	ld	a5,-72(s0)
     a30:	00878713          	addi	a4,a5,8
     a34:	fae43c23          	sd	a4,-72(s0)
     a38:	639c                	ld	a5,0(a5)
     a3a:	873e                	mv	a4,a5
     a3c:	fcc42783          	lw	a5,-52(s0)
     a40:	4685                	li	a3,1
     a42:	4629                	li	a2,10
     a44:	85ba                	mv	a1,a4
     a46:	853e                	mv	a0,a5
     a48:	d09ff0ef          	jal	750 <printint>
        i += 2;
     a4c:	fdc42783          	lw	a5,-36(s0)
     a50:	2789                	addiw	a5,a5,2
     a52:	fcf42e23          	sw	a5,-36(s0)
     a56:	ac75                	j	d12 <vprintf+0x452>
      } else if(c0 == 'u'){
     a58:	fd442783          	lw	a5,-44(s0)
     a5c:	0007871b          	sext.w	a4,a5
     a60:	07500793          	li	a5,117
     a64:	02f71563          	bne	a4,a5,a8e <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a68:	fb843783          	ld	a5,-72(s0)
     a6c:	00878713          	addi	a4,a5,8
     a70:	fae43c23          	sd	a4,-72(s0)
     a74:	439c                	lw	a5,0(a5)
     a76:	02079713          	slli	a4,a5,0x20
     a7a:	9301                	srli	a4,a4,0x20
     a7c:	fcc42783          	lw	a5,-52(s0)
     a80:	4681                	li	a3,0
     a82:	4629                	li	a2,10
     a84:	85ba                	mv	a1,a4
     a86:	853e                	mv	a0,a5
     a88:	cc9ff0ef          	jal	750 <printint>
     a8c:	a459                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a8e:	fd442783          	lw	a5,-44(s0)
     a92:	0007871b          	sext.w	a4,a5
     a96:	06c00793          	li	a5,108
     a9a:	04f71063          	bne	a4,a5,ada <vprintf+0x21a>
     a9e:	fe442783          	lw	a5,-28(s0)
     aa2:	0007871b          	sext.w	a4,a5
     aa6:	07500793          	li	a5,117
     aaa:	02f71863          	bne	a4,a5,ada <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     aae:	fb843783          	ld	a5,-72(s0)
     ab2:	00878713          	addi	a4,a5,8
     ab6:	fae43c23          	sd	a4,-72(s0)
     aba:	639c                	ld	a5,0(a5)
     abc:	873e                	mv	a4,a5
     abe:	fcc42783          	lw	a5,-52(s0)
     ac2:	4681                	li	a3,0
     ac4:	4629                	li	a2,10
     ac6:	85ba                	mv	a1,a4
     ac8:	853e                	mv	a0,a5
     aca:	c87ff0ef          	jal	750 <printint>
        i += 1;
     ace:	fdc42783          	lw	a5,-36(s0)
     ad2:	2785                	addiw	a5,a5,1
     ad4:	fcf42e23          	sw	a5,-36(s0)
     ad8:	ac2d                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ada:	fd442783          	lw	a5,-44(s0)
     ade:	0007871b          	sext.w	a4,a5
     ae2:	06c00793          	li	a5,108
     ae6:	04f71863          	bne	a4,a5,b36 <vprintf+0x276>
     aea:	fe442783          	lw	a5,-28(s0)
     aee:	0007871b          	sext.w	a4,a5
     af2:	06c00793          	li	a5,108
     af6:	04f71063          	bne	a4,a5,b36 <vprintf+0x276>
     afa:	fe042783          	lw	a5,-32(s0)
     afe:	0007871b          	sext.w	a4,a5
     b02:	07500793          	li	a5,117
     b06:	02f71863          	bne	a4,a5,b36 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b0a:	fb843783          	ld	a5,-72(s0)
     b0e:	00878713          	addi	a4,a5,8
     b12:	fae43c23          	sd	a4,-72(s0)
     b16:	639c                	ld	a5,0(a5)
     b18:	873e                	mv	a4,a5
     b1a:	fcc42783          	lw	a5,-52(s0)
     b1e:	4681                	li	a3,0
     b20:	4629                	li	a2,10
     b22:	85ba                	mv	a1,a4
     b24:	853e                	mv	a0,a5
     b26:	c2bff0ef          	jal	750 <printint>
        i += 2;
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	2789                	addiw	a5,a5,2
     b30:	fcf42e23          	sw	a5,-36(s0)
     b34:	aaf9                	j	d12 <vprintf+0x452>
      } else if(c0 == 'x'){
     b36:	fd442783          	lw	a5,-44(s0)
     b3a:	0007871b          	sext.w	a4,a5
     b3e:	07800793          	li	a5,120
     b42:	02f71563          	bne	a4,a5,b6c <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b46:	fb843783          	ld	a5,-72(s0)
     b4a:	00878713          	addi	a4,a5,8
     b4e:	fae43c23          	sd	a4,-72(s0)
     b52:	439c                	lw	a5,0(a5)
     b54:	02079713          	slli	a4,a5,0x20
     b58:	9301                	srli	a4,a4,0x20
     b5a:	fcc42783          	lw	a5,-52(s0)
     b5e:	4681                	li	a3,0
     b60:	4641                	li	a2,16
     b62:	85ba                	mv	a1,a4
     b64:	853e                	mv	a0,a5
     b66:	bebff0ef          	jal	750 <printint>
     b6a:	a265                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b6c:	fd442783          	lw	a5,-44(s0)
     b70:	0007871b          	sext.w	a4,a5
     b74:	06c00793          	li	a5,108
     b78:	04f71063          	bne	a4,a5,bb8 <vprintf+0x2f8>
     b7c:	fe442783          	lw	a5,-28(s0)
     b80:	0007871b          	sext.w	a4,a5
     b84:	07800793          	li	a5,120
     b88:	02f71863          	bne	a4,a5,bb8 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b8c:	fb843783          	ld	a5,-72(s0)
     b90:	00878713          	addi	a4,a5,8
     b94:	fae43c23          	sd	a4,-72(s0)
     b98:	639c                	ld	a5,0(a5)
     b9a:	873e                	mv	a4,a5
     b9c:	fcc42783          	lw	a5,-52(s0)
     ba0:	4681                	li	a3,0
     ba2:	4641                	li	a2,16
     ba4:	85ba                	mv	a1,a4
     ba6:	853e                	mv	a0,a5
     ba8:	ba9ff0ef          	jal	750 <printint>
        i += 1;
     bac:	fdc42783          	lw	a5,-36(s0)
     bb0:	2785                	addiw	a5,a5,1
     bb2:	fcf42e23          	sw	a5,-36(s0)
     bb6:	aab1                	j	d12 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     bb8:	fd442783          	lw	a5,-44(s0)
     bbc:	0007871b          	sext.w	a4,a5
     bc0:	06c00793          	li	a5,108
     bc4:	04f71863          	bne	a4,a5,c14 <vprintf+0x354>
     bc8:	fe442783          	lw	a5,-28(s0)
     bcc:	0007871b          	sext.w	a4,a5
     bd0:	06c00793          	li	a5,108
     bd4:	04f71063          	bne	a4,a5,c14 <vprintf+0x354>
     bd8:	fe042783          	lw	a5,-32(s0)
     bdc:	0007871b          	sext.w	a4,a5
     be0:	07800793          	li	a5,120
     be4:	02f71863          	bne	a4,a5,c14 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     be8:	fb843783          	ld	a5,-72(s0)
     bec:	00878713          	addi	a4,a5,8
     bf0:	fae43c23          	sd	a4,-72(s0)
     bf4:	639c                	ld	a5,0(a5)
     bf6:	873e                	mv	a4,a5
     bf8:	fcc42783          	lw	a5,-52(s0)
     bfc:	4681                	li	a3,0
     bfe:	4641                	li	a2,16
     c00:	85ba                	mv	a1,a4
     c02:	853e                	mv	a0,a5
     c04:	b4dff0ef          	jal	750 <printint>
        i += 2;
     c08:	fdc42783          	lw	a5,-36(s0)
     c0c:	2789                	addiw	a5,a5,2
     c0e:	fcf42e23          	sw	a5,-36(s0)
     c12:	a201                	j	d12 <vprintf+0x452>
      } else if(c0 == 'p'){
     c14:	fd442783          	lw	a5,-44(s0)
     c18:	0007871b          	sext.w	a4,a5
     c1c:	07000793          	li	a5,112
     c20:	02f71063          	bne	a4,a5,c40 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c24:	fb843783          	ld	a5,-72(s0)
     c28:	00878713          	addi	a4,a5,8
     c2c:	fae43c23          	sd	a4,-72(s0)
     c30:	6398                	ld	a4,0(a5)
     c32:	fcc42783          	lw	a5,-52(s0)
     c36:	85ba                	mv	a1,a4
     c38:	853e                	mv	a0,a5
     c3a:	c09ff0ef          	jal	842 <printptr>
     c3e:	a8d1                	j	d12 <vprintf+0x452>
      } else if(c0 == 'c'){
     c40:	fd442783          	lw	a5,-44(s0)
     c44:	0007871b          	sext.w	a4,a5
     c48:	06300793          	li	a5,99
     c4c:	02f71263          	bne	a4,a5,c70 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c50:	fb843783          	ld	a5,-72(s0)
     c54:	00878713          	addi	a4,a5,8
     c58:	fae43c23          	sd	a4,-72(s0)
     c5c:	439c                	lw	a5,0(a5)
     c5e:	0ff7f713          	zext.b	a4,a5
     c62:	fcc42783          	lw	a5,-52(s0)
     c66:	85ba                	mv	a1,a4
     c68:	853e                	mv	a0,a5
     c6a:	ab5ff0ef          	jal	71e <putc>
     c6e:	a055                	j	d12 <vprintf+0x452>
      } else if(c0 == 's'){
     c70:	fd442783          	lw	a5,-44(s0)
     c74:	0007871b          	sext.w	a4,a5
     c78:	07300793          	li	a5,115
     c7c:	04f71a63          	bne	a4,a5,cd0 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c80:	fb843783          	ld	a5,-72(s0)
     c84:	00878713          	addi	a4,a5,8
     c88:	fae43c23          	sd	a4,-72(s0)
     c8c:	639c                	ld	a5,0(a5)
     c8e:	fef43423          	sd	a5,-24(s0)
     c92:	fe843783          	ld	a5,-24(s0)
     c96:	e79d                	bnez	a5,cc4 <vprintf+0x404>
          s = "(null)";
     c98:	00000797          	auipc	a5,0x0
     c9c:	46878793          	addi	a5,a5,1128 # 1100 <malloc+0x186>
     ca0:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     ca4:	a005                	j	cc4 <vprintf+0x404>
          putc(fd, *s);
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	0007c703          	lbu	a4,0(a5)
     cae:	fcc42783          	lw	a5,-52(s0)
     cb2:	85ba                	mv	a1,a4
     cb4:	853e                	mv	a0,a5
     cb6:	a69ff0ef          	jal	71e <putc>
        for(; *s; s++)
     cba:	fe843783          	ld	a5,-24(s0)
     cbe:	0785                	addi	a5,a5,1
     cc0:	fef43423          	sd	a5,-24(s0)
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	0007c783          	lbu	a5,0(a5)
     ccc:	ffe9                	bnez	a5,ca6 <vprintf+0x3e6>
     cce:	a091                	j	d12 <vprintf+0x452>
      } else if(c0 == '%'){
     cd0:	fd442783          	lw	a5,-44(s0)
     cd4:	0007871b          	sext.w	a4,a5
     cd8:	02500793          	li	a5,37
     cdc:	00f71a63          	bne	a4,a5,cf0 <vprintf+0x430>
        putc(fd, '%');
     ce0:	fcc42783          	lw	a5,-52(s0)
     ce4:	02500593          	li	a1,37
     ce8:	853e                	mv	a0,a5
     cea:	a35ff0ef          	jal	71e <putc>
     cee:	a015                	j	d12 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cf0:	fcc42783          	lw	a5,-52(s0)
     cf4:	02500593          	li	a1,37
     cf8:	853e                	mv	a0,a5
     cfa:	a25ff0ef          	jal	71e <putc>
        putc(fd, c0);
     cfe:	fd442783          	lw	a5,-44(s0)
     d02:	0ff7f713          	zext.b	a4,a5
     d06:	fcc42783          	lw	a5,-52(s0)
     d0a:	85ba                	mv	a1,a4
     d0c:	853e                	mv	a0,a5
     d0e:	a11ff0ef          	jal	71e <putc>
      }

      state = 0;
     d12:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d16:	fdc42783          	lw	a5,-36(s0)
     d1a:	2785                	addiw	a5,a5,1
     d1c:	fcf42e23          	sw	a5,-36(s0)
     d20:	fdc42783          	lw	a5,-36(s0)
     d24:	fc043703          	ld	a4,-64(s0)
     d28:	97ba                	add	a5,a5,a4
     d2a:	0007c783          	lbu	a5,0(a5)
     d2e:	ba0799e3          	bnez	a5,8e0 <vprintf+0x20>
    }
  }
}
     d32:	0001                	nop
     d34:	0001                	nop
     d36:	60a6                	ld	ra,72(sp)
     d38:	6406                	ld	s0,64(sp)
     d3a:	6161                	addi	sp,sp,80
     d3c:	8082                	ret

0000000000000d3e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d3e:	7159                	addi	sp,sp,-112
     d40:	fc06                	sd	ra,56(sp)
     d42:	f822                	sd	s0,48(sp)
     d44:	0080                	addi	s0,sp,64
     d46:	fcb43823          	sd	a1,-48(s0)
     d4a:	e010                	sd	a2,0(s0)
     d4c:	e414                	sd	a3,8(s0)
     d4e:	e818                	sd	a4,16(s0)
     d50:	ec1c                	sd	a5,24(s0)
     d52:	03043023          	sd	a6,32(s0)
     d56:	03143423          	sd	a7,40(s0)
     d5a:	87aa                	mv	a5,a0
     d5c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d60:	03040793          	addi	a5,s0,48
     d64:	fcf43423          	sd	a5,-56(s0)
     d68:	fc843783          	ld	a5,-56(s0)
     d6c:	fd078793          	addi	a5,a5,-48
     d70:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d74:	fe843703          	ld	a4,-24(s0)
     d78:	fdc42783          	lw	a5,-36(s0)
     d7c:	863a                	mv	a2,a4
     d7e:	fd043583          	ld	a1,-48(s0)
     d82:	853e                	mv	a0,a5
     d84:	b3dff0ef          	jal	8c0 <vprintf>
}
     d88:	0001                	nop
     d8a:	70e2                	ld	ra,56(sp)
     d8c:	7442                	ld	s0,48(sp)
     d8e:	6165                	addi	sp,sp,112
     d90:	8082                	ret

0000000000000d92 <printf>:

void
printf(const char *fmt, ...)
{
     d92:	7159                	addi	sp,sp,-112
     d94:	f406                	sd	ra,40(sp)
     d96:	f022                	sd	s0,32(sp)
     d98:	1800                	addi	s0,sp,48
     d9a:	fca43c23          	sd	a0,-40(s0)
     d9e:	e40c                	sd	a1,8(s0)
     da0:	e810                	sd	a2,16(s0)
     da2:	ec14                	sd	a3,24(s0)
     da4:	f018                	sd	a4,32(s0)
     da6:	f41c                	sd	a5,40(s0)
     da8:	03043823          	sd	a6,48(s0)
     dac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     db0:	04040793          	addi	a5,s0,64
     db4:	fcf43823          	sd	a5,-48(s0)
     db8:	fd043783          	ld	a5,-48(s0)
     dbc:	fc878793          	addi	a5,a5,-56
     dc0:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     dc4:	fe843783          	ld	a5,-24(s0)
     dc8:	863e                	mv	a2,a5
     dca:	fd843583          	ld	a1,-40(s0)
     dce:	4505                	li	a0,1
     dd0:	af1ff0ef          	jal	8c0 <vprintf>
}
     dd4:	0001                	nop
     dd6:	70a2                	ld	ra,40(sp)
     dd8:	7402                	ld	s0,32(sp)
     dda:	6165                	addi	sp,sp,112
     ddc:	8082                	ret

0000000000000dde <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dde:	7179                	addi	sp,sp,-48
     de0:	f406                	sd	ra,40(sp)
     de2:	f022                	sd	s0,32(sp)
     de4:	1800                	addi	s0,sp,48
     de6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     dea:	fd843783          	ld	a5,-40(s0)
     dee:	17c1                	addi	a5,a5,-16
     df0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     df4:	00001797          	auipc	a5,0x1
     df8:	23c78793          	addi	a5,a5,572 # 2030 <freep>
     dfc:	639c                	ld	a5,0(a5)
     dfe:	fef43423          	sd	a5,-24(s0)
     e02:	a815                	j	e36 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e04:	fe843783          	ld	a5,-24(s0)
     e08:	639c                	ld	a5,0(a5)
     e0a:	fe843703          	ld	a4,-24(s0)
     e0e:	00f76f63          	bltu	a4,a5,e2c <free+0x4e>
     e12:	fe043703          	ld	a4,-32(s0)
     e16:	fe843783          	ld	a5,-24(s0)
     e1a:	02e7eb63          	bltu	a5,a4,e50 <free+0x72>
     e1e:	fe843783          	ld	a5,-24(s0)
     e22:	639c                	ld	a5,0(a5)
     e24:	fe043703          	ld	a4,-32(s0)
     e28:	02f76463          	bltu	a4,a5,e50 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e2c:	fe843783          	ld	a5,-24(s0)
     e30:	639c                	ld	a5,0(a5)
     e32:	fef43423          	sd	a5,-24(s0)
     e36:	fe043703          	ld	a4,-32(s0)
     e3a:	fe843783          	ld	a5,-24(s0)
     e3e:	fce7f3e3          	bgeu	a5,a4,e04 <free+0x26>
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	639c                	ld	a5,0(a5)
     e48:	fe043703          	ld	a4,-32(s0)
     e4c:	faf77ce3          	bgeu	a4,a5,e04 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e50:	fe043783          	ld	a5,-32(s0)
     e54:	479c                	lw	a5,8(a5)
     e56:	1782                	slli	a5,a5,0x20
     e58:	9381                	srli	a5,a5,0x20
     e5a:	0792                	slli	a5,a5,0x4
     e5c:	fe043703          	ld	a4,-32(s0)
     e60:	973e                	add	a4,a4,a5
     e62:	fe843783          	ld	a5,-24(s0)
     e66:	639c                	ld	a5,0(a5)
     e68:	02f71763          	bne	a4,a5,e96 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e6c:	fe043783          	ld	a5,-32(s0)
     e70:	4798                	lw	a4,8(a5)
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	639c                	ld	a5,0(a5)
     e78:	479c                	lw	a5,8(a5)
     e7a:	9fb9                	addw	a5,a5,a4
     e7c:	0007871b          	sext.w	a4,a5
     e80:	fe043783          	ld	a5,-32(s0)
     e84:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	639c                	ld	a5,0(a5)
     e8c:	6398                	ld	a4,0(a5)
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	e398                	sd	a4,0(a5)
     e94:	a039                	j	ea2 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	6398                	ld	a4,0(a5)
     e9c:	fe043783          	ld	a5,-32(s0)
     ea0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ea2:	fe843783          	ld	a5,-24(s0)
     ea6:	479c                	lw	a5,8(a5)
     ea8:	1782                	slli	a5,a5,0x20
     eaa:	9381                	srli	a5,a5,0x20
     eac:	0792                	slli	a5,a5,0x4
     eae:	fe843703          	ld	a4,-24(s0)
     eb2:	97ba                	add	a5,a5,a4
     eb4:	fe043703          	ld	a4,-32(s0)
     eb8:	02f71563          	bne	a4,a5,ee2 <free+0x104>
    p->s.size += bp->s.size;
     ebc:	fe843783          	ld	a5,-24(s0)
     ec0:	4798                	lw	a4,8(a5)
     ec2:	fe043783          	ld	a5,-32(s0)
     ec6:	479c                	lw	a5,8(a5)
     ec8:	9fb9                	addw	a5,a5,a4
     eca:	0007871b          	sext.w	a4,a5
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ed4:	fe043783          	ld	a5,-32(s0)
     ed8:	6398                	ld	a4,0(a5)
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	e398                	sd	a4,0(a5)
     ee0:	a031                	j	eec <free+0x10e>
  } else
    p->s.ptr = bp;
     ee2:	fe843783          	ld	a5,-24(s0)
     ee6:	fe043703          	ld	a4,-32(s0)
     eea:	e398                	sd	a4,0(a5)
  freep = p;
     eec:	00001797          	auipc	a5,0x1
     ef0:	14478793          	addi	a5,a5,324 # 2030 <freep>
     ef4:	fe843703          	ld	a4,-24(s0)
     ef8:	e398                	sd	a4,0(a5)
}
     efa:	0001                	nop
     efc:	70a2                	ld	ra,40(sp)
     efe:	7402                	ld	s0,32(sp)
     f00:	6145                	addi	sp,sp,48
     f02:	8082                	ret

0000000000000f04 <morecore>:

static Header*
morecore(uint nu)
{
     f04:	7179                	addi	sp,sp,-48
     f06:	f406                	sd	ra,40(sp)
     f08:	f022                	sd	s0,32(sp)
     f0a:	1800                	addi	s0,sp,48
     f0c:	87aa                	mv	a5,a0
     f0e:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f12:	fdc42783          	lw	a5,-36(s0)
     f16:	0007871b          	sext.w	a4,a5
     f1a:	6785                	lui	a5,0x1
     f1c:	00f77563          	bgeu	a4,a5,f26 <morecore+0x22>
    nu = 4096;
     f20:	6785                	lui	a5,0x1
     f22:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f26:	fdc42783          	lw	a5,-36(s0)
     f2a:	0047979b          	slliw	a5,a5,0x4
     f2e:	2781                	sext.w	a5,a5
     f30:	853e                	mv	a0,a5
     f32:	ee8ff0ef          	jal	61a <sbrk>
     f36:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f3a:	fe843703          	ld	a4,-24(s0)
     f3e:	57fd                	li	a5,-1
     f40:	00f71463          	bne	a4,a5,f48 <morecore+0x44>
    return 0;
     f44:	4781                	li	a5,0
     f46:	a02d                	j	f70 <morecore+0x6c>
  hp = (Header*)p;
     f48:	fe843783          	ld	a5,-24(s0)
     f4c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f50:	fe043783          	ld	a5,-32(s0)
     f54:	fdc42703          	lw	a4,-36(s0)
     f58:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f5a:	fe043783          	ld	a5,-32(s0)
     f5e:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x96>
     f60:	853e                	mv	a0,a5
     f62:	e7dff0ef          	jal	dde <free>
  return freep;
     f66:	00001797          	auipc	a5,0x1
     f6a:	0ca78793          	addi	a5,a5,202 # 2030 <freep>
     f6e:	639c                	ld	a5,0(a5)
}
     f70:	853e                	mv	a0,a5
     f72:	70a2                	ld	ra,40(sp)
     f74:	7402                	ld	s0,32(sp)
     f76:	6145                	addi	sp,sp,48
     f78:	8082                	ret

0000000000000f7a <malloc>:

void*
malloc(uint nbytes)
{
     f7a:	7139                	addi	sp,sp,-64
     f7c:	fc06                	sd	ra,56(sp)
     f7e:	f822                	sd	s0,48(sp)
     f80:	0080                	addi	s0,sp,64
     f82:	87aa                	mv	a5,a0
     f84:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f88:	fcc46783          	lwu	a5,-52(s0)
     f8c:	07bd                	addi	a5,a5,15
     f8e:	8391                	srli	a5,a5,0x4
     f90:	2781                	sext.w	a5,a5
     f92:	2785                	addiw	a5,a5,1
     f94:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f98:	00001797          	auipc	a5,0x1
     f9c:	09878793          	addi	a5,a5,152 # 2030 <freep>
     fa0:	639c                	ld	a5,0(a5)
     fa2:	fef43023          	sd	a5,-32(s0)
     fa6:	fe043783          	ld	a5,-32(s0)
     faa:	ef95                	bnez	a5,fe6 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fac:	00001797          	auipc	a5,0x1
     fb0:	07478793          	addi	a5,a5,116 # 2020 <base>
     fb4:	fef43023          	sd	a5,-32(s0)
     fb8:	00001797          	auipc	a5,0x1
     fbc:	07878793          	addi	a5,a5,120 # 2030 <freep>
     fc0:	fe043703          	ld	a4,-32(s0)
     fc4:	e398                	sd	a4,0(a5)
     fc6:	00001797          	auipc	a5,0x1
     fca:	06a78793          	addi	a5,a5,106 # 2030 <freep>
     fce:	6398                	ld	a4,0(a5)
     fd0:	00001797          	auipc	a5,0x1
     fd4:	05078793          	addi	a5,a5,80 # 2020 <base>
     fd8:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fda:	00001797          	auipc	a5,0x1
     fde:	04678793          	addi	a5,a5,70 # 2020 <base>
     fe2:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fe6:	fe043783          	ld	a5,-32(s0)
     fea:	639c                	ld	a5,0(a5)
     fec:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ff0:	fe843783          	ld	a5,-24(s0)
     ff4:	479c                	lw	a5,8(a5)
     ff6:	fdc42703          	lw	a4,-36(s0)
     ffa:	2701                	sext.w	a4,a4
     ffc:	06e7e763          	bltu	a5,a4,106a <malloc+0xf0>
      if(p->s.size == nunits)
    1000:	fe843783          	ld	a5,-24(s0)
    1004:	479c                	lw	a5,8(a5)
    1006:	fdc42703          	lw	a4,-36(s0)
    100a:	2701                	sext.w	a4,a4
    100c:	00f71963          	bne	a4,a5,101e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	6398                	ld	a4,0(a5)
    1016:	fe043783          	ld	a5,-32(s0)
    101a:	e398                	sd	a4,0(a5)
    101c:	a825                	j	1054 <malloc+0xda>
      else {
        p->s.size -= nunits;
    101e:	fe843783          	ld	a5,-24(s0)
    1022:	479c                	lw	a5,8(a5)
    1024:	fdc42703          	lw	a4,-36(s0)
    1028:	9f99                	subw	a5,a5,a4
    102a:	0007871b          	sext.w	a4,a5
    102e:	fe843783          	ld	a5,-24(s0)
    1032:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1034:	fe843783          	ld	a5,-24(s0)
    1038:	479c                	lw	a5,8(a5)
    103a:	1782                	slli	a5,a5,0x20
    103c:	9381                	srli	a5,a5,0x20
    103e:	0792                	slli	a5,a5,0x4
    1040:	fe843703          	ld	a4,-24(s0)
    1044:	97ba                	add	a5,a5,a4
    1046:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    104a:	fe843783          	ld	a5,-24(s0)
    104e:	fdc42703          	lw	a4,-36(s0)
    1052:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1054:	00001797          	auipc	a5,0x1
    1058:	fdc78793          	addi	a5,a5,-36 # 2030 <freep>
    105c:	fe043703          	ld	a4,-32(s0)
    1060:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1062:	fe843783          	ld	a5,-24(s0)
    1066:	07c1                	addi	a5,a5,16
    1068:	a081                	j	10a8 <malloc+0x12e>
    }
    if(p == freep)
    106a:	00001797          	auipc	a5,0x1
    106e:	fc678793          	addi	a5,a5,-58 # 2030 <freep>
    1072:	639c                	ld	a5,0(a5)
    1074:	fe843703          	ld	a4,-24(s0)
    1078:	00f71e63          	bne	a4,a5,1094 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    107c:	fdc42783          	lw	a5,-36(s0)
    1080:	853e                	mv	a0,a5
    1082:	e83ff0ef          	jal	f04 <morecore>
    1086:	fea43423          	sd	a0,-24(s0)
    108a:	fe843783          	ld	a5,-24(s0)
    108e:	e399                	bnez	a5,1094 <malloc+0x11a>
        return 0;
    1090:	4781                	li	a5,0
    1092:	a819                	j	10a8 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	fef43023          	sd	a5,-32(s0)
    109c:	fe843783          	ld	a5,-24(s0)
    10a0:	639c                	ld	a5,0(a5)
    10a2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10a6:	b7a9                	j	ff0 <malloc+0x76>
  }
}
    10a8:	853e                	mv	a0,a5
    10aa:	70e2                	ld	ra,56(sp)
    10ac:	7442                	ld	s0,48(sp)
    10ae:	6121                	addi	sp,sp,64
    10b0:	8082                	ret
