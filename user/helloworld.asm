
user/_helloworld:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user.h"

int main(int argc, char *argv[]) {
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	87aa                	mv	a5,a0
   a:	feb43023          	sd	a1,-32(s0)
   e:	fef42623          	sw	a5,-20(s0)
    printf("Hello World!\n");
  12:	00001517          	auipc	a0,0x1
  16:	f6e50513          	addi	a0,a0,-146 # f80 <malloc+0x13a>
  1a:	445000ef          	jal	c5e <printf>
    return 0;
  1e:	4781                	li	a5,0
}
  20:	853e                	mv	a0,a5
  22:	60e2                	ld	ra,24(sp)
  24:	6442                	ld	s0,16(sp)
  26:	6105                	addi	sp,sp,32
  28:	8082                	ret

000000000000002a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  2a:	7179                	addi	sp,sp,-48
  2c:	f406                	sd	ra,40(sp)
  2e:	f022                	sd	s0,32(sp)
  30:	1800                	addi	s0,sp,48
  32:	87aa                	mv	a5,a0
  34:	fcb43823          	sd	a1,-48(s0)
  38:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  3c:	fdc42783          	lw	a5,-36(s0)
  40:	fd043583          	ld	a1,-48(s0)
  44:	853e                	mv	a0,a5
  46:	fbbff0ef          	jal	0 <main>
  4a:	87aa                	mv	a5,a0
  4c:	fef42623          	sw	a5,-20(s0)
  exit(r);
  50:	fec42783          	lw	a5,-20(s0)
  54:	853e                	mv	a0,a5
  56:	4ec000ef          	jal	542 <exit>

000000000000005a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  5a:	7179                	addi	sp,sp,-48
  5c:	f406                	sd	ra,40(sp)
  5e:	f022                	sd	s0,32(sp)
  60:	1800                	addi	s0,sp,48
  62:	fca43c23          	sd	a0,-40(s0)
  66:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  6a:	fd843783          	ld	a5,-40(s0)
  6e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  72:	0001                	nop
  74:	fd043703          	ld	a4,-48(s0)
  78:	00170793          	addi	a5,a4,1
  7c:	fcf43823          	sd	a5,-48(s0)
  80:	fd843783          	ld	a5,-40(s0)
  84:	00178693          	addi	a3,a5,1
  88:	fcd43c23          	sd	a3,-40(s0)
  8c:	00074703          	lbu	a4,0(a4)
  90:	00e78023          	sb	a4,0(a5)
  94:	0007c783          	lbu	a5,0(a5)
  98:	fff1                	bnez	a5,74 <strcpy+0x1a>
    ;
  return os;
  9a:	fe843783          	ld	a5,-24(s0)
}
  9e:	853e                	mv	a0,a5
  a0:	70a2                	ld	ra,40(sp)
  a2:	7402                	ld	s0,32(sp)
  a4:	6145                	addi	sp,sp,48
  a6:	8082                	ret

00000000000000a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a8:	1101                	addi	sp,sp,-32
  aa:	ec06                	sd	ra,24(sp)
  ac:	e822                	sd	s0,16(sp)
  ae:	1000                	addi	s0,sp,32
  b0:	fea43423          	sd	a0,-24(s0)
  b4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  b8:	a819                	j	ce <strcmp+0x26>
    p++, q++;
  ba:	fe843783          	ld	a5,-24(s0)
  be:	0785                	addi	a5,a5,1
  c0:	fef43423          	sd	a5,-24(s0)
  c4:	fe043783          	ld	a5,-32(s0)
  c8:	0785                	addi	a5,a5,1
  ca:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  ce:	fe843783          	ld	a5,-24(s0)
  d2:	0007c783          	lbu	a5,0(a5)
  d6:	cb99                	beqz	a5,ec <strcmp+0x44>
  d8:	fe843783          	ld	a5,-24(s0)
  dc:	0007c703          	lbu	a4,0(a5)
  e0:	fe043783          	ld	a5,-32(s0)
  e4:	0007c783          	lbu	a5,0(a5)
  e8:	fcf709e3          	beq	a4,a5,ba <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
  ec:	fe843783          	ld	a5,-24(s0)
  f0:	0007c783          	lbu	a5,0(a5)
  f4:	0007871b          	sext.w	a4,a5
  f8:	fe043783          	ld	a5,-32(s0)
  fc:	0007c783          	lbu	a5,0(a5)
 100:	2781                	sext.w	a5,a5
 102:	40f707bb          	subw	a5,a4,a5
 106:	2781                	sext.w	a5,a5
}
 108:	853e                	mv	a0,a5
 10a:	60e2                	ld	ra,24(sp)
 10c:	6442                	ld	s0,16(sp)
 10e:	6105                	addi	sp,sp,32
 110:	8082                	ret

0000000000000112 <strlen>:

uint
strlen(const char *s)
{
 112:	7179                	addi	sp,sp,-48
 114:	f406                	sd	ra,40(sp)
 116:	f022                	sd	s0,32(sp)
 118:	1800                	addi	s0,sp,48
 11a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 11e:	fe042623          	sw	zero,-20(s0)
 122:	a031                	j	12e <strlen+0x1c>
 124:	fec42783          	lw	a5,-20(s0)
 128:	2785                	addiw	a5,a5,1
 12a:	fef42623          	sw	a5,-20(s0)
 12e:	fec42783          	lw	a5,-20(s0)
 132:	fd843703          	ld	a4,-40(s0)
 136:	97ba                	add	a5,a5,a4
 138:	0007c783          	lbu	a5,0(a5)
 13c:	f7e5                	bnez	a5,124 <strlen+0x12>
    ;
  return n;
 13e:	fec42783          	lw	a5,-20(s0)
}
 142:	853e                	mv	a0,a5
 144:	70a2                	ld	ra,40(sp)
 146:	7402                	ld	s0,32(sp)
 148:	6145                	addi	sp,sp,48
 14a:	8082                	ret

000000000000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
 14c:	7179                	addi	sp,sp,-48
 14e:	f406                	sd	ra,40(sp)
 150:	f022                	sd	s0,32(sp)
 152:	1800                	addi	s0,sp,48
 154:	fca43c23          	sd	a0,-40(s0)
 158:	87ae                	mv	a5,a1
 15a:	8732                	mv	a4,a2
 15c:	fcf42a23          	sw	a5,-44(s0)
 160:	87ba                	mv	a5,a4
 162:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 166:	fd843783          	ld	a5,-40(s0)
 16a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 16e:	fe042623          	sw	zero,-20(s0)
 172:	a00d                	j	194 <memset+0x48>
    cdst[i] = c;
 174:	fec42783          	lw	a5,-20(s0)
 178:	fe043703          	ld	a4,-32(s0)
 17c:	97ba                	add	a5,a5,a4
 17e:	fd442703          	lw	a4,-44(s0)
 182:	0ff77713          	zext.b	a4,a4
 186:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 18a:	fec42783          	lw	a5,-20(s0)
 18e:	2785                	addiw	a5,a5,1
 190:	fef42623          	sw	a5,-20(s0)
 194:	fec42783          	lw	a5,-20(s0)
 198:	fd042703          	lw	a4,-48(s0)
 19c:	2701                	sext.w	a4,a4
 19e:	fce7ebe3          	bltu	a5,a4,174 <memset+0x28>
  }
  return dst;
 1a2:	fd843783          	ld	a5,-40(s0)
}
 1a6:	853e                	mv	a0,a5
 1a8:	70a2                	ld	ra,40(sp)
 1aa:	7402                	ld	s0,32(sp)
 1ac:	6145                	addi	sp,sp,48
 1ae:	8082                	ret

00000000000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	1101                	addi	sp,sp,-32
 1b2:	ec06                	sd	ra,24(sp)
 1b4:	e822                	sd	s0,16(sp)
 1b6:	1000                	addi	s0,sp,32
 1b8:	fea43423          	sd	a0,-24(s0)
 1bc:	87ae                	mv	a5,a1
 1be:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1c2:	a01d                	j	1e8 <strchr+0x38>
    if(*s == c)
 1c4:	fe843783          	ld	a5,-24(s0)
 1c8:	0007c703          	lbu	a4,0(a5)
 1cc:	fe744783          	lbu	a5,-25(s0)
 1d0:	0ff7f793          	zext.b	a5,a5
 1d4:	00e79563          	bne	a5,a4,1de <strchr+0x2e>
      return (char*)s;
 1d8:	fe843783          	ld	a5,-24(s0)
 1dc:	a821                	j	1f4 <strchr+0x44>
  for(; *s; s++)
 1de:	fe843783          	ld	a5,-24(s0)
 1e2:	0785                	addi	a5,a5,1
 1e4:	fef43423          	sd	a5,-24(s0)
 1e8:	fe843783          	ld	a5,-24(s0)
 1ec:	0007c783          	lbu	a5,0(a5)
 1f0:	fbf1                	bnez	a5,1c4 <strchr+0x14>
  return 0;
 1f2:	4781                	li	a5,0
}
 1f4:	853e                	mv	a0,a5
 1f6:	60e2                	ld	ra,24(sp)
 1f8:	6442                	ld	s0,16(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret

00000000000001fe <gets>:

char*
gets(char *buf, int max)
{
 1fe:	7179                	addi	sp,sp,-48
 200:	f406                	sd	ra,40(sp)
 202:	f022                	sd	s0,32(sp)
 204:	1800                	addi	s0,sp,48
 206:	fca43c23          	sd	a0,-40(s0)
 20a:	87ae                	mv	a5,a1
 20c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 210:	fe042623          	sw	zero,-20(s0)
 214:	a891                	j	268 <gets+0x6a>
    cc = read(0, &c, 1);
 216:	fe740793          	addi	a5,s0,-25
 21a:	4605                	li	a2,1
 21c:	85be                	mv	a1,a5
 21e:	4501                	li	a0,0
 220:	33a000ef          	jal	55a <read>
 224:	87aa                	mv	a5,a0
 226:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 22a:	fe842783          	lw	a5,-24(s0)
 22e:	2781                	sext.w	a5,a5
 230:	04f05663          	blez	a5,27c <gets+0x7e>
      break;
    buf[i++] = c;
 234:	fec42783          	lw	a5,-20(s0)
 238:	0017871b          	addiw	a4,a5,1
 23c:	fee42623          	sw	a4,-20(s0)
 240:	873e                	mv	a4,a5
 242:	fd843783          	ld	a5,-40(s0)
 246:	97ba                	add	a5,a5,a4
 248:	fe744703          	lbu	a4,-25(s0)
 24c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 250:	fe744783          	lbu	a5,-25(s0)
 254:	873e                	mv	a4,a5
 256:	47a9                	li	a5,10
 258:	02f70363          	beq	a4,a5,27e <gets+0x80>
 25c:	fe744783          	lbu	a5,-25(s0)
 260:	873e                	mv	a4,a5
 262:	47b5                	li	a5,13
 264:	00f70d63          	beq	a4,a5,27e <gets+0x80>
  for(i=0; i+1 < max; ){
 268:	fec42783          	lw	a5,-20(s0)
 26c:	2785                	addiw	a5,a5,1
 26e:	2781                	sext.w	a5,a5
 270:	fd442703          	lw	a4,-44(s0)
 274:	2701                	sext.w	a4,a4
 276:	fae7c0e3          	blt	a5,a4,216 <gets+0x18>
 27a:	a011                	j	27e <gets+0x80>
      break;
 27c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 27e:	fec42783          	lw	a5,-20(s0)
 282:	fd843703          	ld	a4,-40(s0)
 286:	97ba                	add	a5,a5,a4
 288:	00078023          	sb	zero,0(a5)
  return buf;
 28c:	fd843783          	ld	a5,-40(s0)
}
 290:	853e                	mv	a0,a5
 292:	70a2                	ld	ra,40(sp)
 294:	7402                	ld	s0,32(sp)
 296:	6145                	addi	sp,sp,48
 298:	8082                	ret

000000000000029a <stat>:

int
stat(const char *n, struct stat *st)
{
 29a:	7179                	addi	sp,sp,-48
 29c:	f406                	sd	ra,40(sp)
 29e:	f022                	sd	s0,32(sp)
 2a0:	1800                	addi	s0,sp,48
 2a2:	fca43c23          	sd	a0,-40(s0)
 2a6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2aa:	4581                	li	a1,0
 2ac:	fd843503          	ld	a0,-40(s0)
 2b0:	2d2000ef          	jal	582 <open>
 2b4:	87aa                	mv	a5,a0
 2b6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2ba:	fec42783          	lw	a5,-20(s0)
 2be:	2781                	sext.w	a5,a5
 2c0:	0007d463          	bgez	a5,2c8 <stat+0x2e>
    return -1;
 2c4:	57fd                	li	a5,-1
 2c6:	a015                	j	2ea <stat+0x50>
  r = fstat(fd, st);
 2c8:	fec42783          	lw	a5,-20(s0)
 2cc:	fd043583          	ld	a1,-48(s0)
 2d0:	853e                	mv	a0,a5
 2d2:	2c8000ef          	jal	59a <fstat>
 2d6:	87aa                	mv	a5,a0
 2d8:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2dc:	fec42783          	lw	a5,-20(s0)
 2e0:	853e                	mv	a0,a5
 2e2:	288000ef          	jal	56a <close>
  return r;
 2e6:	fe842783          	lw	a5,-24(s0)
}
 2ea:	853e                	mv	a0,a5
 2ec:	70a2                	ld	ra,40(sp)
 2ee:	7402                	ld	s0,32(sp)
 2f0:	6145                	addi	sp,sp,48
 2f2:	8082                	ret

00000000000002f4 <atoi>:

int
atoi(const char *s)
{
 2f4:	7179                	addi	sp,sp,-48
 2f6:	f406                	sd	ra,40(sp)
 2f8:	f022                	sd	s0,32(sp)
 2fa:	1800                	addi	s0,sp,48
 2fc:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 300:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 304:	a81d                	j	33a <atoi+0x46>
    n = n*10 + *s++ - '0';
 306:	fec42783          	lw	a5,-20(s0)
 30a:	873e                	mv	a4,a5
 30c:	87ba                	mv	a5,a4
 30e:	0027979b          	slliw	a5,a5,0x2
 312:	9fb9                	addw	a5,a5,a4
 314:	0017979b          	slliw	a5,a5,0x1
 318:	0007871b          	sext.w	a4,a5
 31c:	fd843783          	ld	a5,-40(s0)
 320:	00178693          	addi	a3,a5,1
 324:	fcd43c23          	sd	a3,-40(s0)
 328:	0007c783          	lbu	a5,0(a5)
 32c:	2781                	sext.w	a5,a5
 32e:	9fb9                	addw	a5,a5,a4
 330:	2781                	sext.w	a5,a5
 332:	fd07879b          	addiw	a5,a5,-48
 336:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 33a:	fd843783          	ld	a5,-40(s0)
 33e:	0007c783          	lbu	a5,0(a5)
 342:	873e                	mv	a4,a5
 344:	02f00793          	li	a5,47
 348:	00e7fb63          	bgeu	a5,a4,35e <atoi+0x6a>
 34c:	fd843783          	ld	a5,-40(s0)
 350:	0007c783          	lbu	a5,0(a5)
 354:	873e                	mv	a4,a5
 356:	03900793          	li	a5,57
 35a:	fae7f6e3          	bgeu	a5,a4,306 <atoi+0x12>
  return n;
 35e:	fec42783          	lw	a5,-20(s0)
}
 362:	853e                	mv	a0,a5
 364:	70a2                	ld	ra,40(sp)
 366:	7402                	ld	s0,32(sp)
 368:	6145                	addi	sp,sp,48
 36a:	8082                	ret

000000000000036c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 36c:	7139                	addi	sp,sp,-64
 36e:	fc06                	sd	ra,56(sp)
 370:	f822                	sd	s0,48(sp)
 372:	0080                	addi	s0,sp,64
 374:	fca43c23          	sd	a0,-40(s0)
 378:	fcb43823          	sd	a1,-48(s0)
 37c:	87b2                	mv	a5,a2
 37e:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 382:	fd843783          	ld	a5,-40(s0)
 386:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 38a:	fd043783          	ld	a5,-48(s0)
 38e:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 392:	fe043703          	ld	a4,-32(s0)
 396:	fe843783          	ld	a5,-24(s0)
 39a:	02e7fc63          	bgeu	a5,a4,3d2 <memmove+0x66>
    while(n-- > 0)
 39e:	a00d                	j	3c0 <memmove+0x54>
      *dst++ = *src++;
 3a0:	fe043703          	ld	a4,-32(s0)
 3a4:	00170793          	addi	a5,a4,1
 3a8:	fef43023          	sd	a5,-32(s0)
 3ac:	fe843783          	ld	a5,-24(s0)
 3b0:	00178693          	addi	a3,a5,1
 3b4:	fed43423          	sd	a3,-24(s0)
 3b8:	00074703          	lbu	a4,0(a4)
 3bc:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3c0:	fcc42783          	lw	a5,-52(s0)
 3c4:	fff7871b          	addiw	a4,a5,-1
 3c8:	fce42623          	sw	a4,-52(s0)
 3cc:	fcf04ae3          	bgtz	a5,3a0 <memmove+0x34>
 3d0:	a891                	j	424 <memmove+0xb8>
  } else {
    dst += n;
 3d2:	fcc42783          	lw	a5,-52(s0)
 3d6:	fe843703          	ld	a4,-24(s0)
 3da:	97ba                	add	a5,a5,a4
 3dc:	fef43423          	sd	a5,-24(s0)
    src += n;
 3e0:	fcc42783          	lw	a5,-52(s0)
 3e4:	fe043703          	ld	a4,-32(s0)
 3e8:	97ba                	add	a5,a5,a4
 3ea:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3ee:	a01d                	j	414 <memmove+0xa8>
      *--dst = *--src;
 3f0:	fe043783          	ld	a5,-32(s0)
 3f4:	17fd                	addi	a5,a5,-1
 3f6:	fef43023          	sd	a5,-32(s0)
 3fa:	fe843783          	ld	a5,-24(s0)
 3fe:	17fd                	addi	a5,a5,-1
 400:	fef43423          	sd	a5,-24(s0)
 404:	fe043783          	ld	a5,-32(s0)
 408:	0007c703          	lbu	a4,0(a5)
 40c:	fe843783          	ld	a5,-24(s0)
 410:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 414:	fcc42783          	lw	a5,-52(s0)
 418:	fff7871b          	addiw	a4,a5,-1
 41c:	fce42623          	sw	a4,-52(s0)
 420:	fcf048e3          	bgtz	a5,3f0 <memmove+0x84>
  }
  return vdst;
 424:	fd843783          	ld	a5,-40(s0)
}
 428:	853e                	mv	a0,a5
 42a:	70e2                	ld	ra,56(sp)
 42c:	7442                	ld	s0,48(sp)
 42e:	6121                	addi	sp,sp,64
 430:	8082                	ret

0000000000000432 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 432:	7139                	addi	sp,sp,-64
 434:	fc06                	sd	ra,56(sp)
 436:	f822                	sd	s0,48(sp)
 438:	0080                	addi	s0,sp,64
 43a:	fca43c23          	sd	a0,-40(s0)
 43e:	fcb43823          	sd	a1,-48(s0)
 442:	87b2                	mv	a5,a2
 444:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 448:	fd843783          	ld	a5,-40(s0)
 44c:	fef43423          	sd	a5,-24(s0)
 450:	fd043783          	ld	a5,-48(s0)
 454:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 458:	a0a1                	j	4a0 <memcmp+0x6e>
    if (*p1 != *p2) {
 45a:	fe843783          	ld	a5,-24(s0)
 45e:	0007c703          	lbu	a4,0(a5)
 462:	fe043783          	ld	a5,-32(s0)
 466:	0007c783          	lbu	a5,0(a5)
 46a:	02f70163          	beq	a4,a5,48c <memcmp+0x5a>
      return *p1 - *p2;
 46e:	fe843783          	ld	a5,-24(s0)
 472:	0007c783          	lbu	a5,0(a5)
 476:	0007871b          	sext.w	a4,a5
 47a:	fe043783          	ld	a5,-32(s0)
 47e:	0007c783          	lbu	a5,0(a5)
 482:	2781                	sext.w	a5,a5
 484:	40f707bb          	subw	a5,a4,a5
 488:	2781                	sext.w	a5,a5
 48a:	a01d                	j	4b0 <memcmp+0x7e>
    }
    p1++;
 48c:	fe843783          	ld	a5,-24(s0)
 490:	0785                	addi	a5,a5,1
 492:	fef43423          	sd	a5,-24(s0)
    p2++;
 496:	fe043783          	ld	a5,-32(s0)
 49a:	0785                	addi	a5,a5,1
 49c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4a0:	fcc42783          	lw	a5,-52(s0)
 4a4:	fff7871b          	addiw	a4,a5,-1
 4a8:	fce42623          	sw	a4,-52(s0)
 4ac:	f7dd                	bnez	a5,45a <memcmp+0x28>
  }
  return 0;
 4ae:	4781                	li	a5,0
}
 4b0:	853e                	mv	a0,a5
 4b2:	70e2                	ld	ra,56(sp)
 4b4:	7442                	ld	s0,48(sp)
 4b6:	6121                	addi	sp,sp,64
 4b8:	8082                	ret

00000000000004ba <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ba:	7179                	addi	sp,sp,-48
 4bc:	f406                	sd	ra,40(sp)
 4be:	f022                	sd	s0,32(sp)
 4c0:	1800                	addi	s0,sp,48
 4c2:	fea43423          	sd	a0,-24(s0)
 4c6:	feb43023          	sd	a1,-32(s0)
 4ca:	87b2                	mv	a5,a2
 4cc:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4d0:	fdc42783          	lw	a5,-36(s0)
 4d4:	863e                	mv	a2,a5
 4d6:	fe043583          	ld	a1,-32(s0)
 4da:	fe843503          	ld	a0,-24(s0)
 4de:	e8fff0ef          	jal	36c <memmove>
 4e2:	87aa                	mv	a5,a0
}
 4e4:	853e                	mv	a0,a5
 4e6:	70a2                	ld	ra,40(sp)
 4e8:	7402                	ld	s0,32(sp)
 4ea:	6145                	addi	sp,sp,48
 4ec:	8082                	ret

00000000000004ee <sbrk>:

char *
sbrk(int n) {
 4ee:	1101                	addi	sp,sp,-32
 4f0:	ec06                	sd	ra,24(sp)
 4f2:	e822                	sd	s0,16(sp)
 4f4:	1000                	addi	s0,sp,32
 4f6:	87aa                	mv	a5,a0
 4f8:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 4fc:	fec42783          	lw	a5,-20(s0)
 500:	4585                	li	a1,1
 502:	853e                	mv	a0,a5
 504:	0c6000ef          	jal	5ca <sys_sbrk>
 508:	87aa                	mv	a5,a0
}
 50a:	853e                	mv	a0,a5
 50c:	60e2                	ld	ra,24(sp)
 50e:	6442                	ld	s0,16(sp)
 510:	6105                	addi	sp,sp,32
 512:	8082                	ret

0000000000000514 <sbrklazy>:

char *
sbrklazy(int n) {
 514:	1101                	addi	sp,sp,-32
 516:	ec06                	sd	ra,24(sp)
 518:	e822                	sd	s0,16(sp)
 51a:	1000                	addi	s0,sp,32
 51c:	87aa                	mv	a5,a0
 51e:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 522:	fec42783          	lw	a5,-20(s0)
 526:	4589                	li	a1,2
 528:	853e                	mv	a0,a5
 52a:	0a0000ef          	jal	5ca <sys_sbrk>
 52e:	87aa                	mv	a5,a0
}
 530:	853e                	mv	a0,a5
 532:	60e2                	ld	ra,24(sp)
 534:	6442                	ld	s0,16(sp)
 536:	6105                	addi	sp,sp,32
 538:	8082                	ret

000000000000053a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 53a:	4885                	li	a7,1
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <exit>:
.global exit
exit:
 li a7, SYS_exit
 542:	4889                	li	a7,2
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <wait>:
.global wait
wait:
 li a7, SYS_wait
 54a:	488d                	li	a7,3
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 552:	4891                	li	a7,4
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <read>:
.global read
read:
 li a7, SYS_read
 55a:	4895                	li	a7,5
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <write>:
.global write
write:
 li a7, SYS_write
 562:	48c1                	li	a7,16
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <close>:
.global close
close:
 li a7, SYS_close
 56a:	48d5                	li	a7,21
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <kill>:
.global kill
kill:
 li a7, SYS_kill
 572:	4899                	li	a7,6
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <exec>:
.global exec
exec:
 li a7, SYS_exec
 57a:	489d                	li	a7,7
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <open>:
.global open
open:
 li a7, SYS_open
 582:	48bd                	li	a7,15
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 58a:	48c5                	li	a7,17
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 592:	48c9                	li	a7,18
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 59a:	48a1                	li	a7,8
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <link>:
.global link
link:
 li a7, SYS_link
 5a2:	48cd                	li	a7,19
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5aa:	48d1                	li	a7,20
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5b2:	48a5                	li	a7,9
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ba:	48a9                	li	a7,10
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5c2:	48ad                	li	a7,11
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5ca:	48b1                	li	a7,12
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5d2:	48b5                	li	a7,13
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5da:	48b9                	li	a7,14
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <top>:
.global top
top:
 li a7, SYS_top
 5e2:	48d9                	li	a7,22
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ea:	1101                	addi	sp,sp,-32
 5ec:	ec06                	sd	ra,24(sp)
 5ee:	e822                	sd	s0,16(sp)
 5f0:	1000                	addi	s0,sp,32
 5f2:	87aa                	mv	a5,a0
 5f4:	872e                	mv	a4,a1
 5f6:	fef42623          	sw	a5,-20(s0)
 5fa:	87ba                	mv	a5,a4
 5fc:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 600:	feb40713          	addi	a4,s0,-21
 604:	fec42783          	lw	a5,-20(s0)
 608:	4605                	li	a2,1
 60a:	85ba                	mv	a1,a4
 60c:	853e                	mv	a0,a5
 60e:	f55ff0ef          	jal	562 <write>
}
 612:	0001                	nop
 614:	60e2                	ld	ra,24(sp)
 616:	6442                	ld	s0,16(sp)
 618:	6105                	addi	sp,sp,32
 61a:	8082                	ret

000000000000061c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 61c:	711d                	addi	sp,sp,-96
 61e:	ec86                	sd	ra,88(sp)
 620:	e8a2                	sd	s0,80(sp)
 622:	1080                	addi	s0,sp,96
 624:	87aa                	mv	a5,a0
 626:	fab43823          	sd	a1,-80(s0)
 62a:	8736                	mv	a4,a3
 62c:	faf42e23          	sw	a5,-68(s0)
 630:	87b2                	mv	a5,a2
 632:	faf42c23          	sw	a5,-72(s0)
 636:	87ba                	mv	a5,a4
 638:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 63c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 640:	fac42783          	lw	a5,-84(s0)
 644:	2781                	sext.w	a5,a5
 646:	cf99                	beqz	a5,664 <printint+0x48>
 648:	fb043783          	ld	a5,-80(s0)
 64c:	0007dc63          	bgez	a5,664 <printint+0x48>
    neg = 1;
 650:	4785                	li	a5,1
 652:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 656:	fb043783          	ld	a5,-80(s0)
 65a:	40f007b3          	neg	a5,a5
 65e:	fef43023          	sd	a5,-32(s0)
 662:	a029                	j	66c <printint+0x50>
  } else {
    x = xx;
 664:	fb043783          	ld	a5,-80(s0)
 668:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 66c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 670:	fb842783          	lw	a5,-72(s0)
 674:	fe043703          	ld	a4,-32(s0)
 678:	02f77733          	remu	a4,a4,a5
 67c:	fec42783          	lw	a5,-20(s0)
 680:	0017869b          	addiw	a3,a5,1
 684:	fed42623          	sw	a3,-20(s0)
 688:	00001697          	auipc	a3,0x1
 68c:	97868693          	addi	a3,a3,-1672 # 1000 <digits>
 690:	9736                	add	a4,a4,a3
 692:	00074703          	lbu	a4,0(a4)
 696:	17c1                	addi	a5,a5,-16
 698:	97a2                	add	a5,a5,s0
 69a:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 69e:	fb842783          	lw	a5,-72(s0)
 6a2:	fe043703          	ld	a4,-32(s0)
 6a6:	02f757b3          	divu	a5,a4,a5
 6aa:	fef43023          	sd	a5,-32(s0)
 6ae:	fe043783          	ld	a5,-32(s0)
 6b2:	ffdd                	bnez	a5,670 <printint+0x54>
  if(neg)
 6b4:	fe842783          	lw	a5,-24(s0)
 6b8:	2781                	sext.w	a5,a5
 6ba:	cb95                	beqz	a5,6ee <printint+0xd2>
    buf[i++] = '-';
 6bc:	fec42783          	lw	a5,-20(s0)
 6c0:	0017871b          	addiw	a4,a5,1
 6c4:	fee42623          	sw	a4,-20(s0)
 6c8:	17c1                	addi	a5,a5,-16
 6ca:	97a2                	add	a5,a5,s0
 6cc:	02d00713          	li	a4,45
 6d0:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 6d4:	a829                	j	6ee <printint+0xd2>
    putc(fd, buf[i]);
 6d6:	fec42783          	lw	a5,-20(s0)
 6da:	17c1                	addi	a5,a5,-16
 6dc:	97a2                	add	a5,a5,s0
 6de:	fd87c703          	lbu	a4,-40(a5)
 6e2:	fbc42783          	lw	a5,-68(s0)
 6e6:	85ba                	mv	a1,a4
 6e8:	853e                	mv	a0,a5
 6ea:	f01ff0ef          	jal	5ea <putc>
  while(--i >= 0)
 6ee:	fec42783          	lw	a5,-20(s0)
 6f2:	37fd                	addiw	a5,a5,-1
 6f4:	fef42623          	sw	a5,-20(s0)
 6f8:	fec42783          	lw	a5,-20(s0)
 6fc:	2781                	sext.w	a5,a5
 6fe:	fc07dce3          	bgez	a5,6d6 <printint+0xba>
}
 702:	0001                	nop
 704:	0001                	nop
 706:	60e6                	ld	ra,88(sp)
 708:	6446                	ld	s0,80(sp)
 70a:	6125                	addi	sp,sp,96
 70c:	8082                	ret

000000000000070e <printptr>:

static void
printptr(int fd, uint64 x) {
 70e:	7179                	addi	sp,sp,-48
 710:	f406                	sd	ra,40(sp)
 712:	f022                	sd	s0,32(sp)
 714:	1800                	addi	s0,sp,48
 716:	87aa                	mv	a5,a0
 718:	fcb43823          	sd	a1,-48(s0)
 71c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 720:	fdc42783          	lw	a5,-36(s0)
 724:	03000593          	li	a1,48
 728:	853e                	mv	a0,a5
 72a:	ec1ff0ef          	jal	5ea <putc>
  putc(fd, 'x');
 72e:	fdc42783          	lw	a5,-36(s0)
 732:	07800593          	li	a1,120
 736:	853e                	mv	a0,a5
 738:	eb3ff0ef          	jal	5ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 73c:	fe042623          	sw	zero,-20(s0)
 740:	a81d                	j	776 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 742:	fd043783          	ld	a5,-48(s0)
 746:	93f1                	srli	a5,a5,0x3c
 748:	00001717          	auipc	a4,0x1
 74c:	8b870713          	addi	a4,a4,-1864 # 1000 <digits>
 750:	97ba                	add	a5,a5,a4
 752:	0007c703          	lbu	a4,0(a5)
 756:	fdc42783          	lw	a5,-36(s0)
 75a:	85ba                	mv	a1,a4
 75c:	853e                	mv	a0,a5
 75e:	e8dff0ef          	jal	5ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 762:	fec42783          	lw	a5,-20(s0)
 766:	2785                	addiw	a5,a5,1
 768:	fef42623          	sw	a5,-20(s0)
 76c:	fd043783          	ld	a5,-48(s0)
 770:	0792                	slli	a5,a5,0x4
 772:	fcf43823          	sd	a5,-48(s0)
 776:	fec42703          	lw	a4,-20(s0)
 77a:	47bd                	li	a5,15
 77c:	fce7f3e3          	bgeu	a5,a4,742 <printptr+0x34>
}
 780:	0001                	nop
 782:	0001                	nop
 784:	70a2                	ld	ra,40(sp)
 786:	7402                	ld	s0,32(sp)
 788:	6145                	addi	sp,sp,48
 78a:	8082                	ret

000000000000078c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 78c:	715d                	addi	sp,sp,-80
 78e:	e486                	sd	ra,72(sp)
 790:	e0a2                	sd	s0,64(sp)
 792:	0880                	addi	s0,sp,80
 794:	87aa                	mv	a5,a0
 796:	fcb43023          	sd	a1,-64(s0)
 79a:	fac43c23          	sd	a2,-72(s0)
 79e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 7a2:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 7a6:	fc042e23          	sw	zero,-36(s0)
 7aa:	a189                	j	bec <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 7ac:	fdc42783          	lw	a5,-36(s0)
 7b0:	fc043703          	ld	a4,-64(s0)
 7b4:	97ba                	add	a5,a5,a4
 7b6:	0007c783          	lbu	a5,0(a5)
 7ba:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 7be:	fd842783          	lw	a5,-40(s0)
 7c2:	2781                	sext.w	a5,a5
 7c4:	eb8d                	bnez	a5,7f6 <vprintf+0x6a>
      if(c0 == '%'){
 7c6:	fd442783          	lw	a5,-44(s0)
 7ca:	0007871b          	sext.w	a4,a5
 7ce:	02500793          	li	a5,37
 7d2:	00f71763          	bne	a4,a5,7e0 <vprintf+0x54>
        state = '%';
 7d6:	02500793          	li	a5,37
 7da:	fcf42c23          	sw	a5,-40(s0)
 7de:	a111                	j	be2 <vprintf+0x456>
      } else {
        putc(fd, c0);
 7e0:	fd442783          	lw	a5,-44(s0)
 7e4:	0ff7f713          	zext.b	a4,a5
 7e8:	fcc42783          	lw	a5,-52(s0)
 7ec:	85ba                	mv	a1,a4
 7ee:	853e                	mv	a0,a5
 7f0:	dfbff0ef          	jal	5ea <putc>
 7f4:	a6fd                	j	be2 <vprintf+0x456>
      }
    } else if(state == '%'){
 7f6:	fd842783          	lw	a5,-40(s0)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	02500793          	li	a5,37
 802:	3ef71063          	bne	a4,a5,be2 <vprintf+0x456>
      c1 = c2 = 0;
 806:	fe042023          	sw	zero,-32(s0)
 80a:	fe042783          	lw	a5,-32(s0)
 80e:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 812:	fd442783          	lw	a5,-44(s0)
 816:	2781                	sext.w	a5,a5
 818:	cb99                	beqz	a5,82e <vprintf+0xa2>
 81a:	fdc42783          	lw	a5,-36(s0)
 81e:	0785                	addi	a5,a5,1
 820:	fc043703          	ld	a4,-64(s0)
 824:	97ba                	add	a5,a5,a4
 826:	0007c783          	lbu	a5,0(a5)
 82a:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 82e:	fe442783          	lw	a5,-28(s0)
 832:	2781                	sext.w	a5,a5
 834:	cb99                	beqz	a5,84a <vprintf+0xbe>
 836:	fdc42783          	lw	a5,-36(s0)
 83a:	0789                	addi	a5,a5,2
 83c:	fc043703          	ld	a4,-64(s0)
 840:	97ba                	add	a5,a5,a4
 842:	0007c783          	lbu	a5,0(a5)
 846:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 84a:	fd442783          	lw	a5,-44(s0)
 84e:	0007871b          	sext.w	a4,a5
 852:	06400793          	li	a5,100
 856:	02f71363          	bne	a4,a5,87c <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 85a:	fb843783          	ld	a5,-72(s0)
 85e:	00878713          	addi	a4,a5,8
 862:	fae43c23          	sd	a4,-72(s0)
 866:	439c                	lw	a5,0(a5)
 868:	873e                	mv	a4,a5
 86a:	fcc42783          	lw	a5,-52(s0)
 86e:	4685                	li	a3,1
 870:	4629                	li	a2,10
 872:	85ba                	mv	a1,a4
 874:	853e                	mv	a0,a5
 876:	da7ff0ef          	jal	61c <printint>
 87a:	a695                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 87c:	fd442783          	lw	a5,-44(s0)
 880:	0007871b          	sext.w	a4,a5
 884:	06c00793          	li	a5,108
 888:	04f71063          	bne	a4,a5,8c8 <vprintf+0x13c>
 88c:	fe442783          	lw	a5,-28(s0)
 890:	0007871b          	sext.w	a4,a5
 894:	06400793          	li	a5,100
 898:	02f71863          	bne	a4,a5,8c8 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 89c:	fb843783          	ld	a5,-72(s0)
 8a0:	00878713          	addi	a4,a5,8
 8a4:	fae43c23          	sd	a4,-72(s0)
 8a8:	639c                	ld	a5,0(a5)
 8aa:	873e                	mv	a4,a5
 8ac:	fcc42783          	lw	a5,-52(s0)
 8b0:	4685                	li	a3,1
 8b2:	4629                	li	a2,10
 8b4:	85ba                	mv	a1,a4
 8b6:	853e                	mv	a0,a5
 8b8:	d65ff0ef          	jal	61c <printint>
        i += 1;
 8bc:	fdc42783          	lw	a5,-36(s0)
 8c0:	2785                	addiw	a5,a5,1
 8c2:	fcf42e23          	sw	a5,-36(s0)
 8c6:	ae21                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8c8:	fd442783          	lw	a5,-44(s0)
 8cc:	0007871b          	sext.w	a4,a5
 8d0:	06c00793          	li	a5,108
 8d4:	04f71863          	bne	a4,a5,924 <vprintf+0x198>
 8d8:	fe442783          	lw	a5,-28(s0)
 8dc:	0007871b          	sext.w	a4,a5
 8e0:	06c00793          	li	a5,108
 8e4:	04f71063          	bne	a4,a5,924 <vprintf+0x198>
 8e8:	fe042783          	lw	a5,-32(s0)
 8ec:	0007871b          	sext.w	a4,a5
 8f0:	06400793          	li	a5,100
 8f4:	02f71863          	bne	a4,a5,924 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f8:	fb843783          	ld	a5,-72(s0)
 8fc:	00878713          	addi	a4,a5,8
 900:	fae43c23          	sd	a4,-72(s0)
 904:	639c                	ld	a5,0(a5)
 906:	873e                	mv	a4,a5
 908:	fcc42783          	lw	a5,-52(s0)
 90c:	4685                	li	a3,1
 90e:	4629                	li	a2,10
 910:	85ba                	mv	a1,a4
 912:	853e                	mv	a0,a5
 914:	d09ff0ef          	jal	61c <printint>
        i += 2;
 918:	fdc42783          	lw	a5,-36(s0)
 91c:	2789                	addiw	a5,a5,2
 91e:	fcf42e23          	sw	a5,-36(s0)
 922:	ac75                	j	bde <vprintf+0x452>
      } else if(c0 == 'u'){
 924:	fd442783          	lw	a5,-44(s0)
 928:	0007871b          	sext.w	a4,a5
 92c:	07500793          	li	a5,117
 930:	02f71563          	bne	a4,a5,95a <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 934:	fb843783          	ld	a5,-72(s0)
 938:	00878713          	addi	a4,a5,8
 93c:	fae43c23          	sd	a4,-72(s0)
 940:	439c                	lw	a5,0(a5)
 942:	02079713          	slli	a4,a5,0x20
 946:	9301                	srli	a4,a4,0x20
 948:	fcc42783          	lw	a5,-52(s0)
 94c:	4681                	li	a3,0
 94e:	4629                	li	a2,10
 950:	85ba                	mv	a1,a4
 952:	853e                	mv	a0,a5
 954:	cc9ff0ef          	jal	61c <printint>
 958:	a459                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 95a:	fd442783          	lw	a5,-44(s0)
 95e:	0007871b          	sext.w	a4,a5
 962:	06c00793          	li	a5,108
 966:	04f71063          	bne	a4,a5,9a6 <vprintf+0x21a>
 96a:	fe442783          	lw	a5,-28(s0)
 96e:	0007871b          	sext.w	a4,a5
 972:	07500793          	li	a5,117
 976:	02f71863          	bne	a4,a5,9a6 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 97a:	fb843783          	ld	a5,-72(s0)
 97e:	00878713          	addi	a4,a5,8
 982:	fae43c23          	sd	a4,-72(s0)
 986:	639c                	ld	a5,0(a5)
 988:	873e                	mv	a4,a5
 98a:	fcc42783          	lw	a5,-52(s0)
 98e:	4681                	li	a3,0
 990:	4629                	li	a2,10
 992:	85ba                	mv	a1,a4
 994:	853e                	mv	a0,a5
 996:	c87ff0ef          	jal	61c <printint>
        i += 1;
 99a:	fdc42783          	lw	a5,-36(s0)
 99e:	2785                	addiw	a5,a5,1
 9a0:	fcf42e23          	sw	a5,-36(s0)
 9a4:	ac2d                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9a6:	fd442783          	lw	a5,-44(s0)
 9aa:	0007871b          	sext.w	a4,a5
 9ae:	06c00793          	li	a5,108
 9b2:	04f71863          	bne	a4,a5,a02 <vprintf+0x276>
 9b6:	fe442783          	lw	a5,-28(s0)
 9ba:	0007871b          	sext.w	a4,a5
 9be:	06c00793          	li	a5,108
 9c2:	04f71063          	bne	a4,a5,a02 <vprintf+0x276>
 9c6:	fe042783          	lw	a5,-32(s0)
 9ca:	0007871b          	sext.w	a4,a5
 9ce:	07500793          	li	a5,117
 9d2:	02f71863          	bne	a4,a5,a02 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d6:	fb843783          	ld	a5,-72(s0)
 9da:	00878713          	addi	a4,a5,8
 9de:	fae43c23          	sd	a4,-72(s0)
 9e2:	639c                	ld	a5,0(a5)
 9e4:	873e                	mv	a4,a5
 9e6:	fcc42783          	lw	a5,-52(s0)
 9ea:	4681                	li	a3,0
 9ec:	4629                	li	a2,10
 9ee:	85ba                	mv	a1,a4
 9f0:	853e                	mv	a0,a5
 9f2:	c2bff0ef          	jal	61c <printint>
        i += 2;
 9f6:	fdc42783          	lw	a5,-36(s0)
 9fa:	2789                	addiw	a5,a5,2
 9fc:	fcf42e23          	sw	a5,-36(s0)
 a00:	aaf9                	j	bde <vprintf+0x452>
      } else if(c0 == 'x'){
 a02:	fd442783          	lw	a5,-44(s0)
 a06:	0007871b          	sext.w	a4,a5
 a0a:	07800793          	li	a5,120
 a0e:	02f71563          	bne	a4,a5,a38 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a12:	fb843783          	ld	a5,-72(s0)
 a16:	00878713          	addi	a4,a5,8
 a1a:	fae43c23          	sd	a4,-72(s0)
 a1e:	439c                	lw	a5,0(a5)
 a20:	02079713          	slli	a4,a5,0x20
 a24:	9301                	srli	a4,a4,0x20
 a26:	fcc42783          	lw	a5,-52(s0)
 a2a:	4681                	li	a3,0
 a2c:	4641                	li	a2,16
 a2e:	85ba                	mv	a1,a4
 a30:	853e                	mv	a0,a5
 a32:	bebff0ef          	jal	61c <printint>
 a36:	a265                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a38:	fd442783          	lw	a5,-44(s0)
 a3c:	0007871b          	sext.w	a4,a5
 a40:	06c00793          	li	a5,108
 a44:	04f71063          	bne	a4,a5,a84 <vprintf+0x2f8>
 a48:	fe442783          	lw	a5,-28(s0)
 a4c:	0007871b          	sext.w	a4,a5
 a50:	07800793          	li	a5,120
 a54:	02f71863          	bne	a4,a5,a84 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a58:	fb843783          	ld	a5,-72(s0)
 a5c:	00878713          	addi	a4,a5,8
 a60:	fae43c23          	sd	a4,-72(s0)
 a64:	639c                	ld	a5,0(a5)
 a66:	873e                	mv	a4,a5
 a68:	fcc42783          	lw	a5,-52(s0)
 a6c:	4681                	li	a3,0
 a6e:	4641                	li	a2,16
 a70:	85ba                	mv	a1,a4
 a72:	853e                	mv	a0,a5
 a74:	ba9ff0ef          	jal	61c <printint>
        i += 1;
 a78:	fdc42783          	lw	a5,-36(s0)
 a7c:	2785                	addiw	a5,a5,1
 a7e:	fcf42e23          	sw	a5,-36(s0)
 a82:	aab1                	j	bde <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a84:	fd442783          	lw	a5,-44(s0)
 a88:	0007871b          	sext.w	a4,a5
 a8c:	06c00793          	li	a5,108
 a90:	04f71863          	bne	a4,a5,ae0 <vprintf+0x354>
 a94:	fe442783          	lw	a5,-28(s0)
 a98:	0007871b          	sext.w	a4,a5
 a9c:	06c00793          	li	a5,108
 aa0:	04f71063          	bne	a4,a5,ae0 <vprintf+0x354>
 aa4:	fe042783          	lw	a5,-32(s0)
 aa8:	0007871b          	sext.w	a4,a5
 aac:	07800793          	li	a5,120
 ab0:	02f71863          	bne	a4,a5,ae0 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ab4:	fb843783          	ld	a5,-72(s0)
 ab8:	00878713          	addi	a4,a5,8
 abc:	fae43c23          	sd	a4,-72(s0)
 ac0:	639c                	ld	a5,0(a5)
 ac2:	873e                	mv	a4,a5
 ac4:	fcc42783          	lw	a5,-52(s0)
 ac8:	4681                	li	a3,0
 aca:	4641                	li	a2,16
 acc:	85ba                	mv	a1,a4
 ace:	853e                	mv	a0,a5
 ad0:	b4dff0ef          	jal	61c <printint>
        i += 2;
 ad4:	fdc42783          	lw	a5,-36(s0)
 ad8:	2789                	addiw	a5,a5,2
 ada:	fcf42e23          	sw	a5,-36(s0)
 ade:	a201                	j	bde <vprintf+0x452>
      } else if(c0 == 'p'){
 ae0:	fd442783          	lw	a5,-44(s0)
 ae4:	0007871b          	sext.w	a4,a5
 ae8:	07000793          	li	a5,112
 aec:	02f71063          	bne	a4,a5,b0c <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 af0:	fb843783          	ld	a5,-72(s0)
 af4:	00878713          	addi	a4,a5,8
 af8:	fae43c23          	sd	a4,-72(s0)
 afc:	6398                	ld	a4,0(a5)
 afe:	fcc42783          	lw	a5,-52(s0)
 b02:	85ba                	mv	a1,a4
 b04:	853e                	mv	a0,a5
 b06:	c09ff0ef          	jal	70e <printptr>
 b0a:	a8d1                	j	bde <vprintf+0x452>
      } else if(c0 == 'c'){
 b0c:	fd442783          	lw	a5,-44(s0)
 b10:	0007871b          	sext.w	a4,a5
 b14:	06300793          	li	a5,99
 b18:	02f71263          	bne	a4,a5,b3c <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b1c:	fb843783          	ld	a5,-72(s0)
 b20:	00878713          	addi	a4,a5,8
 b24:	fae43c23          	sd	a4,-72(s0)
 b28:	439c                	lw	a5,0(a5)
 b2a:	0ff7f713          	zext.b	a4,a5
 b2e:	fcc42783          	lw	a5,-52(s0)
 b32:	85ba                	mv	a1,a4
 b34:	853e                	mv	a0,a5
 b36:	ab5ff0ef          	jal	5ea <putc>
 b3a:	a055                	j	bde <vprintf+0x452>
      } else if(c0 == 's'){
 b3c:	fd442783          	lw	a5,-44(s0)
 b40:	0007871b          	sext.w	a4,a5
 b44:	07300793          	li	a5,115
 b48:	04f71a63          	bne	a4,a5,b9c <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 b4c:	fb843783          	ld	a5,-72(s0)
 b50:	00878713          	addi	a4,a5,8
 b54:	fae43c23          	sd	a4,-72(s0)
 b58:	639c                	ld	a5,0(a5)
 b5a:	fef43423          	sd	a5,-24(s0)
 b5e:	fe843783          	ld	a5,-24(s0)
 b62:	e79d                	bnez	a5,b90 <vprintf+0x404>
          s = "(null)";
 b64:	00000797          	auipc	a5,0x0
 b68:	42c78793          	addi	a5,a5,1068 # f90 <malloc+0x14a>
 b6c:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 b70:	a005                	j	b90 <vprintf+0x404>
          putc(fd, *s);
 b72:	fe843783          	ld	a5,-24(s0)
 b76:	0007c703          	lbu	a4,0(a5)
 b7a:	fcc42783          	lw	a5,-52(s0)
 b7e:	85ba                	mv	a1,a4
 b80:	853e                	mv	a0,a5
 b82:	a69ff0ef          	jal	5ea <putc>
        for(; *s; s++)
 b86:	fe843783          	ld	a5,-24(s0)
 b8a:	0785                	addi	a5,a5,1
 b8c:	fef43423          	sd	a5,-24(s0)
 b90:	fe843783          	ld	a5,-24(s0)
 b94:	0007c783          	lbu	a5,0(a5)
 b98:	ffe9                	bnez	a5,b72 <vprintf+0x3e6>
 b9a:	a091                	j	bde <vprintf+0x452>
      } else if(c0 == '%'){
 b9c:	fd442783          	lw	a5,-44(s0)
 ba0:	0007871b          	sext.w	a4,a5
 ba4:	02500793          	li	a5,37
 ba8:	00f71a63          	bne	a4,a5,bbc <vprintf+0x430>
        putc(fd, '%');
 bac:	fcc42783          	lw	a5,-52(s0)
 bb0:	02500593          	li	a1,37
 bb4:	853e                	mv	a0,a5
 bb6:	a35ff0ef          	jal	5ea <putc>
 bba:	a015                	j	bde <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bbc:	fcc42783          	lw	a5,-52(s0)
 bc0:	02500593          	li	a1,37
 bc4:	853e                	mv	a0,a5
 bc6:	a25ff0ef          	jal	5ea <putc>
        putc(fd, c0);
 bca:	fd442783          	lw	a5,-44(s0)
 bce:	0ff7f713          	zext.b	a4,a5
 bd2:	fcc42783          	lw	a5,-52(s0)
 bd6:	85ba                	mv	a1,a4
 bd8:	853e                	mv	a0,a5
 bda:	a11ff0ef          	jal	5ea <putc>
      }

      state = 0;
 bde:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 be2:	fdc42783          	lw	a5,-36(s0)
 be6:	2785                	addiw	a5,a5,1
 be8:	fcf42e23          	sw	a5,-36(s0)
 bec:	fdc42783          	lw	a5,-36(s0)
 bf0:	fc043703          	ld	a4,-64(s0)
 bf4:	97ba                	add	a5,a5,a4
 bf6:	0007c783          	lbu	a5,0(a5)
 bfa:	ba0799e3          	bnez	a5,7ac <vprintf+0x20>
    }
  }
}
 bfe:	0001                	nop
 c00:	0001                	nop
 c02:	60a6                	ld	ra,72(sp)
 c04:	6406                	ld	s0,64(sp)
 c06:	6161                	addi	sp,sp,80
 c08:	8082                	ret

0000000000000c0a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c0a:	7159                	addi	sp,sp,-112
 c0c:	fc06                	sd	ra,56(sp)
 c0e:	f822                	sd	s0,48(sp)
 c10:	0080                	addi	s0,sp,64
 c12:	fcb43823          	sd	a1,-48(s0)
 c16:	e010                	sd	a2,0(s0)
 c18:	e414                	sd	a3,8(s0)
 c1a:	e818                	sd	a4,16(s0)
 c1c:	ec1c                	sd	a5,24(s0)
 c1e:	03043023          	sd	a6,32(s0)
 c22:	03143423          	sd	a7,40(s0)
 c26:	87aa                	mv	a5,a0
 c28:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c2c:	03040793          	addi	a5,s0,48
 c30:	fcf43423          	sd	a5,-56(s0)
 c34:	fc843783          	ld	a5,-56(s0)
 c38:	fd078793          	addi	a5,a5,-48
 c3c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c40:	fe843703          	ld	a4,-24(s0)
 c44:	fdc42783          	lw	a5,-36(s0)
 c48:	863a                	mv	a2,a4
 c4a:	fd043583          	ld	a1,-48(s0)
 c4e:	853e                	mv	a0,a5
 c50:	b3dff0ef          	jal	78c <vprintf>
}
 c54:	0001                	nop
 c56:	70e2                	ld	ra,56(sp)
 c58:	7442                	ld	s0,48(sp)
 c5a:	6165                	addi	sp,sp,112
 c5c:	8082                	ret

0000000000000c5e <printf>:

void
printf(const char *fmt, ...)
{
 c5e:	7159                	addi	sp,sp,-112
 c60:	f406                	sd	ra,40(sp)
 c62:	f022                	sd	s0,32(sp)
 c64:	1800                	addi	s0,sp,48
 c66:	fca43c23          	sd	a0,-40(s0)
 c6a:	e40c                	sd	a1,8(s0)
 c6c:	e810                	sd	a2,16(s0)
 c6e:	ec14                	sd	a3,24(s0)
 c70:	f018                	sd	a4,32(s0)
 c72:	f41c                	sd	a5,40(s0)
 c74:	03043823          	sd	a6,48(s0)
 c78:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c7c:	04040793          	addi	a5,s0,64
 c80:	fcf43823          	sd	a5,-48(s0)
 c84:	fd043783          	ld	a5,-48(s0)
 c88:	fc878793          	addi	a5,a5,-56
 c8c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 c90:	fe843783          	ld	a5,-24(s0)
 c94:	863e                	mv	a2,a5
 c96:	fd843583          	ld	a1,-40(s0)
 c9a:	4505                	li	a0,1
 c9c:	af1ff0ef          	jal	78c <vprintf>
}
 ca0:	0001                	nop
 ca2:	70a2                	ld	ra,40(sp)
 ca4:	7402                	ld	s0,32(sp)
 ca6:	6165                	addi	sp,sp,112
 ca8:	8082                	ret

0000000000000caa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 caa:	7179                	addi	sp,sp,-48
 cac:	f406                	sd	ra,40(sp)
 cae:	f022                	sd	s0,32(sp)
 cb0:	1800                	addi	s0,sp,48
 cb2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 cb6:	fd843783          	ld	a5,-40(s0)
 cba:	17c1                	addi	a5,a5,-16
 cbc:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cc0:	00000797          	auipc	a5,0x0
 cc4:	37078793          	addi	a5,a5,880 # 1030 <freep>
 cc8:	639c                	ld	a5,0(a5)
 cca:	fef43423          	sd	a5,-24(s0)
 cce:	a815                	j	d02 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cd0:	fe843783          	ld	a5,-24(s0)
 cd4:	639c                	ld	a5,0(a5)
 cd6:	fe843703          	ld	a4,-24(s0)
 cda:	00f76f63          	bltu	a4,a5,cf8 <free+0x4e>
 cde:	fe043703          	ld	a4,-32(s0)
 ce2:	fe843783          	ld	a5,-24(s0)
 ce6:	02e7eb63          	bltu	a5,a4,d1c <free+0x72>
 cea:	fe843783          	ld	a5,-24(s0)
 cee:	639c                	ld	a5,0(a5)
 cf0:	fe043703          	ld	a4,-32(s0)
 cf4:	02f76463          	bltu	a4,a5,d1c <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cf8:	fe843783          	ld	a5,-24(s0)
 cfc:	639c                	ld	a5,0(a5)
 cfe:	fef43423          	sd	a5,-24(s0)
 d02:	fe043703          	ld	a4,-32(s0)
 d06:	fe843783          	ld	a5,-24(s0)
 d0a:	fce7f3e3          	bgeu	a5,a4,cd0 <free+0x26>
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	639c                	ld	a5,0(a5)
 d14:	fe043703          	ld	a4,-32(s0)
 d18:	faf77ce3          	bgeu	a4,a5,cd0 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d1c:	fe043783          	ld	a5,-32(s0)
 d20:	479c                	lw	a5,8(a5)
 d22:	1782                	slli	a5,a5,0x20
 d24:	9381                	srli	a5,a5,0x20
 d26:	0792                	slli	a5,a5,0x4
 d28:	fe043703          	ld	a4,-32(s0)
 d2c:	973e                	add	a4,a4,a5
 d2e:	fe843783          	ld	a5,-24(s0)
 d32:	639c                	ld	a5,0(a5)
 d34:	02f71763          	bne	a4,a5,d62 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d38:	fe043783          	ld	a5,-32(s0)
 d3c:	4798                	lw	a4,8(a5)
 d3e:	fe843783          	ld	a5,-24(s0)
 d42:	639c                	ld	a5,0(a5)
 d44:	479c                	lw	a5,8(a5)
 d46:	9fb9                	addw	a5,a5,a4
 d48:	0007871b          	sext.w	a4,a5
 d4c:	fe043783          	ld	a5,-32(s0)
 d50:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 d52:	fe843783          	ld	a5,-24(s0)
 d56:	639c                	ld	a5,0(a5)
 d58:	6398                	ld	a4,0(a5)
 d5a:	fe043783          	ld	a5,-32(s0)
 d5e:	e398                	sd	a4,0(a5)
 d60:	a039                	j	d6e <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 d62:	fe843783          	ld	a5,-24(s0)
 d66:	6398                	ld	a4,0(a5)
 d68:	fe043783          	ld	a5,-32(s0)
 d6c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	479c                	lw	a5,8(a5)
 d74:	1782                	slli	a5,a5,0x20
 d76:	9381                	srli	a5,a5,0x20
 d78:	0792                	slli	a5,a5,0x4
 d7a:	fe843703          	ld	a4,-24(s0)
 d7e:	97ba                	add	a5,a5,a4
 d80:	fe043703          	ld	a4,-32(s0)
 d84:	02f71563          	bne	a4,a5,dae <free+0x104>
    p->s.size += bp->s.size;
 d88:	fe843783          	ld	a5,-24(s0)
 d8c:	4798                	lw	a4,8(a5)
 d8e:	fe043783          	ld	a5,-32(s0)
 d92:	479c                	lw	a5,8(a5)
 d94:	9fb9                	addw	a5,a5,a4
 d96:	0007871b          	sext.w	a4,a5
 d9a:	fe843783          	ld	a5,-24(s0)
 d9e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 da0:	fe043783          	ld	a5,-32(s0)
 da4:	6398                	ld	a4,0(a5)
 da6:	fe843783          	ld	a5,-24(s0)
 daa:	e398                	sd	a4,0(a5)
 dac:	a031                	j	db8 <free+0x10e>
  } else
    p->s.ptr = bp;
 dae:	fe843783          	ld	a5,-24(s0)
 db2:	fe043703          	ld	a4,-32(s0)
 db6:	e398                	sd	a4,0(a5)
  freep = p;
 db8:	00000797          	auipc	a5,0x0
 dbc:	27878793          	addi	a5,a5,632 # 1030 <freep>
 dc0:	fe843703          	ld	a4,-24(s0)
 dc4:	e398                	sd	a4,0(a5)
}
 dc6:	0001                	nop
 dc8:	70a2                	ld	ra,40(sp)
 dca:	7402                	ld	s0,32(sp)
 dcc:	6145                	addi	sp,sp,48
 dce:	8082                	ret

0000000000000dd0 <morecore>:

static Header*
morecore(uint nu)
{
 dd0:	7179                	addi	sp,sp,-48
 dd2:	f406                	sd	ra,40(sp)
 dd4:	f022                	sd	s0,32(sp)
 dd6:	1800                	addi	s0,sp,48
 dd8:	87aa                	mv	a5,a0
 dda:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 dde:	fdc42783          	lw	a5,-36(s0)
 de2:	0007871b          	sext.w	a4,a5
 de6:	6785                	lui	a5,0x1
 de8:	00f77563          	bgeu	a4,a5,df2 <morecore+0x22>
    nu = 4096;
 dec:	6785                	lui	a5,0x1
 dee:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 df2:	fdc42783          	lw	a5,-36(s0)
 df6:	0047979b          	slliw	a5,a5,0x4
 dfa:	2781                	sext.w	a5,a5
 dfc:	853e                	mv	a0,a5
 dfe:	ef0ff0ef          	jal	4ee <sbrk>
 e02:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e06:	fe843703          	ld	a4,-24(s0)
 e0a:	57fd                	li	a5,-1
 e0c:	00f71463          	bne	a4,a5,e14 <morecore+0x44>
    return 0;
 e10:	4781                	li	a5,0
 e12:	a02d                	j	e3c <morecore+0x6c>
  hp = (Header*)p;
 e14:	fe843783          	ld	a5,-24(s0)
 e18:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e1c:	fe043783          	ld	a5,-32(s0)
 e20:	fdc42703          	lw	a4,-36(s0)
 e24:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e26:	fe043783          	ld	a5,-32(s0)
 e2a:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 e2c:	853e                	mv	a0,a5
 e2e:	e7dff0ef          	jal	caa <free>
  return freep;
 e32:	00000797          	auipc	a5,0x0
 e36:	1fe78793          	addi	a5,a5,510 # 1030 <freep>
 e3a:	639c                	ld	a5,0(a5)
}
 e3c:	853e                	mv	a0,a5
 e3e:	70a2                	ld	ra,40(sp)
 e40:	7402                	ld	s0,32(sp)
 e42:	6145                	addi	sp,sp,48
 e44:	8082                	ret

0000000000000e46 <malloc>:

void*
malloc(uint nbytes)
{
 e46:	7139                	addi	sp,sp,-64
 e48:	fc06                	sd	ra,56(sp)
 e4a:	f822                	sd	s0,48(sp)
 e4c:	0080                	addi	s0,sp,64
 e4e:	87aa                	mv	a5,a0
 e50:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e54:	fcc46783          	lwu	a5,-52(s0)
 e58:	07bd                	addi	a5,a5,15
 e5a:	8391                	srli	a5,a5,0x4
 e5c:	2781                	sext.w	a5,a5
 e5e:	2785                	addiw	a5,a5,1
 e60:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e64:	00000797          	auipc	a5,0x0
 e68:	1cc78793          	addi	a5,a5,460 # 1030 <freep>
 e6c:	639c                	ld	a5,0(a5)
 e6e:	fef43023          	sd	a5,-32(s0)
 e72:	fe043783          	ld	a5,-32(s0)
 e76:	ef95                	bnez	a5,eb2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e78:	00000797          	auipc	a5,0x0
 e7c:	1a878793          	addi	a5,a5,424 # 1020 <base>
 e80:	fef43023          	sd	a5,-32(s0)
 e84:	00000797          	auipc	a5,0x0
 e88:	1ac78793          	addi	a5,a5,428 # 1030 <freep>
 e8c:	fe043703          	ld	a4,-32(s0)
 e90:	e398                	sd	a4,0(a5)
 e92:	00000797          	auipc	a5,0x0
 e96:	19e78793          	addi	a5,a5,414 # 1030 <freep>
 e9a:	6398                	ld	a4,0(a5)
 e9c:	00000797          	auipc	a5,0x0
 ea0:	18478793          	addi	a5,a5,388 # 1020 <base>
 ea4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ea6:	00000797          	auipc	a5,0x0
 eaa:	17a78793          	addi	a5,a5,378 # 1020 <base>
 eae:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eb2:	fe043783          	ld	a5,-32(s0)
 eb6:	639c                	ld	a5,0(a5)
 eb8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ebc:	fe843783          	ld	a5,-24(s0)
 ec0:	479c                	lw	a5,8(a5)
 ec2:	fdc42703          	lw	a4,-36(s0)
 ec6:	2701                	sext.w	a4,a4
 ec8:	06e7e763          	bltu	a5,a4,f36 <malloc+0xf0>
      if(p->s.size == nunits)
 ecc:	fe843783          	ld	a5,-24(s0)
 ed0:	479c                	lw	a5,8(a5)
 ed2:	fdc42703          	lw	a4,-36(s0)
 ed6:	2701                	sext.w	a4,a4
 ed8:	00f71963          	bne	a4,a5,eea <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 edc:	fe843783          	ld	a5,-24(s0)
 ee0:	6398                	ld	a4,0(a5)
 ee2:	fe043783          	ld	a5,-32(s0)
 ee6:	e398                	sd	a4,0(a5)
 ee8:	a825                	j	f20 <malloc+0xda>
      else {
        p->s.size -= nunits;
 eea:	fe843783          	ld	a5,-24(s0)
 eee:	479c                	lw	a5,8(a5)
 ef0:	fdc42703          	lw	a4,-36(s0)
 ef4:	9f99                	subw	a5,a5,a4
 ef6:	0007871b          	sext.w	a4,a5
 efa:	fe843783          	ld	a5,-24(s0)
 efe:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f00:	fe843783          	ld	a5,-24(s0)
 f04:	479c                	lw	a5,8(a5)
 f06:	1782                	slli	a5,a5,0x20
 f08:	9381                	srli	a5,a5,0x20
 f0a:	0792                	slli	a5,a5,0x4
 f0c:	fe843703          	ld	a4,-24(s0)
 f10:	97ba                	add	a5,a5,a4
 f12:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f16:	fe843783          	ld	a5,-24(s0)
 f1a:	fdc42703          	lw	a4,-36(s0)
 f1e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f20:	00000797          	auipc	a5,0x0
 f24:	11078793          	addi	a5,a5,272 # 1030 <freep>
 f28:	fe043703          	ld	a4,-32(s0)
 f2c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f2e:	fe843783          	ld	a5,-24(s0)
 f32:	07c1                	addi	a5,a5,16
 f34:	a081                	j	f74 <malloc+0x12e>
    }
    if(p == freep)
 f36:	00000797          	auipc	a5,0x0
 f3a:	0fa78793          	addi	a5,a5,250 # 1030 <freep>
 f3e:	639c                	ld	a5,0(a5)
 f40:	fe843703          	ld	a4,-24(s0)
 f44:	00f71e63          	bne	a4,a5,f60 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 f48:	fdc42783          	lw	a5,-36(s0)
 f4c:	853e                	mv	a0,a5
 f4e:	e83ff0ef          	jal	dd0 <morecore>
 f52:	fea43423          	sd	a0,-24(s0)
 f56:	fe843783          	ld	a5,-24(s0)
 f5a:	e399                	bnez	a5,f60 <malloc+0x11a>
        return 0;
 f5c:	4781                	li	a5,0
 f5e:	a819                	j	f74 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f60:	fe843783          	ld	a5,-24(s0)
 f64:	fef43023          	sd	a5,-32(s0)
 f68:	fe843783          	ld	a5,-24(s0)
 f6c:	639c                	ld	a5,0(a5)
 f6e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f72:	b7a9                	j	ebc <malloc+0x76>
  }
}
 f74:	853e                	mv	a0,a5
 f76:	70e2                	ld	ra,56(sp)
 f78:	7442                	ld	s0,48(sp)
 f7a:	6121                	addi	sp,sp,64
 f7c:	8082                	ret
