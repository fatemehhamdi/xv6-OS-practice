
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
  16:	f7e50513          	addi	a0,a0,-130 # f90 <malloc+0x142>
  1a:	44d000ef          	jal	c66 <printf>
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

00000000000005ea <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
 5ea:	48dd                	li	a7,23
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f2:	1101                	addi	sp,sp,-32
 5f4:	ec06                	sd	ra,24(sp)
 5f6:	e822                	sd	s0,16(sp)
 5f8:	1000                	addi	s0,sp,32
 5fa:	87aa                	mv	a5,a0
 5fc:	872e                	mv	a4,a1
 5fe:	fef42623          	sw	a5,-20(s0)
 602:	87ba                	mv	a5,a4
 604:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 608:	feb40713          	addi	a4,s0,-21
 60c:	fec42783          	lw	a5,-20(s0)
 610:	4605                	li	a2,1
 612:	85ba                	mv	a1,a4
 614:	853e                	mv	a0,a5
 616:	f4dff0ef          	jal	562 <write>
}
 61a:	0001                	nop
 61c:	60e2                	ld	ra,24(sp)
 61e:	6442                	ld	s0,16(sp)
 620:	6105                	addi	sp,sp,32
 622:	8082                	ret

0000000000000624 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 624:	711d                	addi	sp,sp,-96
 626:	ec86                	sd	ra,88(sp)
 628:	e8a2                	sd	s0,80(sp)
 62a:	1080                	addi	s0,sp,96
 62c:	87aa                	mv	a5,a0
 62e:	fab43823          	sd	a1,-80(s0)
 632:	8736                	mv	a4,a3
 634:	faf42e23          	sw	a5,-68(s0)
 638:	87b2                	mv	a5,a2
 63a:	faf42c23          	sw	a5,-72(s0)
 63e:	87ba                	mv	a5,a4
 640:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 644:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 648:	fac42783          	lw	a5,-84(s0)
 64c:	2781                	sext.w	a5,a5
 64e:	cf99                	beqz	a5,66c <printint+0x48>
 650:	fb043783          	ld	a5,-80(s0)
 654:	0007dc63          	bgez	a5,66c <printint+0x48>
    neg = 1;
 658:	4785                	li	a5,1
 65a:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 65e:	fb043783          	ld	a5,-80(s0)
 662:	40f007b3          	neg	a5,a5
 666:	fef43023          	sd	a5,-32(s0)
 66a:	a029                	j	674 <printint+0x50>
  } else {
    x = xx;
 66c:	fb043783          	ld	a5,-80(s0)
 670:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 674:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 678:	fb842783          	lw	a5,-72(s0)
 67c:	fe043703          	ld	a4,-32(s0)
 680:	02f77733          	remu	a4,a4,a5
 684:	fec42783          	lw	a5,-20(s0)
 688:	0017869b          	addiw	a3,a5,1
 68c:	fed42623          	sw	a3,-20(s0)
 690:	00001697          	auipc	a3,0x1
 694:	97068693          	addi	a3,a3,-1680 # 1000 <digits>
 698:	9736                	add	a4,a4,a3
 69a:	00074703          	lbu	a4,0(a4)
 69e:	17c1                	addi	a5,a5,-16
 6a0:	97a2                	add	a5,a5,s0
 6a2:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 6a6:	fb842783          	lw	a5,-72(s0)
 6aa:	fe043703          	ld	a4,-32(s0)
 6ae:	02f757b3          	divu	a5,a4,a5
 6b2:	fef43023          	sd	a5,-32(s0)
 6b6:	fe043783          	ld	a5,-32(s0)
 6ba:	ffdd                	bnez	a5,678 <printint+0x54>
  if(neg)
 6bc:	fe842783          	lw	a5,-24(s0)
 6c0:	2781                	sext.w	a5,a5
 6c2:	cb95                	beqz	a5,6f6 <printint+0xd2>
    buf[i++] = '-';
 6c4:	fec42783          	lw	a5,-20(s0)
 6c8:	0017871b          	addiw	a4,a5,1
 6cc:	fee42623          	sw	a4,-20(s0)
 6d0:	17c1                	addi	a5,a5,-16
 6d2:	97a2                	add	a5,a5,s0
 6d4:	02d00713          	li	a4,45
 6d8:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 6dc:	a829                	j	6f6 <printint+0xd2>
    putc(fd, buf[i]);
 6de:	fec42783          	lw	a5,-20(s0)
 6e2:	17c1                	addi	a5,a5,-16
 6e4:	97a2                	add	a5,a5,s0
 6e6:	fd87c703          	lbu	a4,-40(a5)
 6ea:	fbc42783          	lw	a5,-68(s0)
 6ee:	85ba                	mv	a1,a4
 6f0:	853e                	mv	a0,a5
 6f2:	f01ff0ef          	jal	5f2 <putc>
  while(--i >= 0)
 6f6:	fec42783          	lw	a5,-20(s0)
 6fa:	37fd                	addiw	a5,a5,-1
 6fc:	fef42623          	sw	a5,-20(s0)
 700:	fec42783          	lw	a5,-20(s0)
 704:	2781                	sext.w	a5,a5
 706:	fc07dce3          	bgez	a5,6de <printint+0xba>
}
 70a:	0001                	nop
 70c:	0001                	nop
 70e:	60e6                	ld	ra,88(sp)
 710:	6446                	ld	s0,80(sp)
 712:	6125                	addi	sp,sp,96
 714:	8082                	ret

0000000000000716 <printptr>:

static void
printptr(int fd, uint64 x) {
 716:	7179                	addi	sp,sp,-48
 718:	f406                	sd	ra,40(sp)
 71a:	f022                	sd	s0,32(sp)
 71c:	1800                	addi	s0,sp,48
 71e:	87aa                	mv	a5,a0
 720:	fcb43823          	sd	a1,-48(s0)
 724:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 728:	fdc42783          	lw	a5,-36(s0)
 72c:	03000593          	li	a1,48
 730:	853e                	mv	a0,a5
 732:	ec1ff0ef          	jal	5f2 <putc>
  putc(fd, 'x');
 736:	fdc42783          	lw	a5,-36(s0)
 73a:	07800593          	li	a1,120
 73e:	853e                	mv	a0,a5
 740:	eb3ff0ef          	jal	5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 744:	fe042623          	sw	zero,-20(s0)
 748:	a81d                	j	77e <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74a:	fd043783          	ld	a5,-48(s0)
 74e:	93f1                	srli	a5,a5,0x3c
 750:	00001717          	auipc	a4,0x1
 754:	8b070713          	addi	a4,a4,-1872 # 1000 <digits>
 758:	97ba                	add	a5,a5,a4
 75a:	0007c703          	lbu	a4,0(a5)
 75e:	fdc42783          	lw	a5,-36(s0)
 762:	85ba                	mv	a1,a4
 764:	853e                	mv	a0,a5
 766:	e8dff0ef          	jal	5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76a:	fec42783          	lw	a5,-20(s0)
 76e:	2785                	addiw	a5,a5,1
 770:	fef42623          	sw	a5,-20(s0)
 774:	fd043783          	ld	a5,-48(s0)
 778:	0792                	slli	a5,a5,0x4
 77a:	fcf43823          	sd	a5,-48(s0)
 77e:	fec42703          	lw	a4,-20(s0)
 782:	47bd                	li	a5,15
 784:	fce7f3e3          	bgeu	a5,a4,74a <printptr+0x34>
}
 788:	0001                	nop
 78a:	0001                	nop
 78c:	70a2                	ld	ra,40(sp)
 78e:	7402                	ld	s0,32(sp)
 790:	6145                	addi	sp,sp,48
 792:	8082                	ret

0000000000000794 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 794:	715d                	addi	sp,sp,-80
 796:	e486                	sd	ra,72(sp)
 798:	e0a2                	sd	s0,64(sp)
 79a:	0880                	addi	s0,sp,80
 79c:	87aa                	mv	a5,a0
 79e:	fcb43023          	sd	a1,-64(s0)
 7a2:	fac43c23          	sd	a2,-72(s0)
 7a6:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 7aa:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 7ae:	fc042e23          	sw	zero,-36(s0)
 7b2:	a189                	j	bf4 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 7b4:	fdc42783          	lw	a5,-36(s0)
 7b8:	fc043703          	ld	a4,-64(s0)
 7bc:	97ba                	add	a5,a5,a4
 7be:	0007c783          	lbu	a5,0(a5)
 7c2:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 7c6:	fd842783          	lw	a5,-40(s0)
 7ca:	2781                	sext.w	a5,a5
 7cc:	eb8d                	bnez	a5,7fe <vprintf+0x6a>
      if(c0 == '%'){
 7ce:	fd442783          	lw	a5,-44(s0)
 7d2:	0007871b          	sext.w	a4,a5
 7d6:	02500793          	li	a5,37
 7da:	00f71763          	bne	a4,a5,7e8 <vprintf+0x54>
        state = '%';
 7de:	02500793          	li	a5,37
 7e2:	fcf42c23          	sw	a5,-40(s0)
 7e6:	a111                	j	bea <vprintf+0x456>
      } else {
        putc(fd, c0);
 7e8:	fd442783          	lw	a5,-44(s0)
 7ec:	0ff7f713          	zext.b	a4,a5
 7f0:	fcc42783          	lw	a5,-52(s0)
 7f4:	85ba                	mv	a1,a4
 7f6:	853e                	mv	a0,a5
 7f8:	dfbff0ef          	jal	5f2 <putc>
 7fc:	a6fd                	j	bea <vprintf+0x456>
      }
    } else if(state == '%'){
 7fe:	fd842783          	lw	a5,-40(s0)
 802:	0007871b          	sext.w	a4,a5
 806:	02500793          	li	a5,37
 80a:	3ef71063          	bne	a4,a5,bea <vprintf+0x456>
      c1 = c2 = 0;
 80e:	fe042023          	sw	zero,-32(s0)
 812:	fe042783          	lw	a5,-32(s0)
 816:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 81a:	fd442783          	lw	a5,-44(s0)
 81e:	2781                	sext.w	a5,a5
 820:	cb99                	beqz	a5,836 <vprintf+0xa2>
 822:	fdc42783          	lw	a5,-36(s0)
 826:	0785                	addi	a5,a5,1
 828:	fc043703          	ld	a4,-64(s0)
 82c:	97ba                	add	a5,a5,a4
 82e:	0007c783          	lbu	a5,0(a5)
 832:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 836:	fe442783          	lw	a5,-28(s0)
 83a:	2781                	sext.w	a5,a5
 83c:	cb99                	beqz	a5,852 <vprintf+0xbe>
 83e:	fdc42783          	lw	a5,-36(s0)
 842:	0789                	addi	a5,a5,2
 844:	fc043703          	ld	a4,-64(s0)
 848:	97ba                	add	a5,a5,a4
 84a:	0007c783          	lbu	a5,0(a5)
 84e:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 852:	fd442783          	lw	a5,-44(s0)
 856:	0007871b          	sext.w	a4,a5
 85a:	06400793          	li	a5,100
 85e:	02f71363          	bne	a4,a5,884 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 862:	fb843783          	ld	a5,-72(s0)
 866:	00878713          	addi	a4,a5,8
 86a:	fae43c23          	sd	a4,-72(s0)
 86e:	439c                	lw	a5,0(a5)
 870:	873e                	mv	a4,a5
 872:	fcc42783          	lw	a5,-52(s0)
 876:	4685                	li	a3,1
 878:	4629                	li	a2,10
 87a:	85ba                	mv	a1,a4
 87c:	853e                	mv	a0,a5
 87e:	da7ff0ef          	jal	624 <printint>
 882:	a695                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 884:	fd442783          	lw	a5,-44(s0)
 888:	0007871b          	sext.w	a4,a5
 88c:	06c00793          	li	a5,108
 890:	04f71063          	bne	a4,a5,8d0 <vprintf+0x13c>
 894:	fe442783          	lw	a5,-28(s0)
 898:	0007871b          	sext.w	a4,a5
 89c:	06400793          	li	a5,100
 8a0:	02f71863          	bne	a4,a5,8d0 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8a4:	fb843783          	ld	a5,-72(s0)
 8a8:	00878713          	addi	a4,a5,8
 8ac:	fae43c23          	sd	a4,-72(s0)
 8b0:	639c                	ld	a5,0(a5)
 8b2:	873e                	mv	a4,a5
 8b4:	fcc42783          	lw	a5,-52(s0)
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	85ba                	mv	a1,a4
 8be:	853e                	mv	a0,a5
 8c0:	d65ff0ef          	jal	624 <printint>
        i += 1;
 8c4:	fdc42783          	lw	a5,-36(s0)
 8c8:	2785                	addiw	a5,a5,1
 8ca:	fcf42e23          	sw	a5,-36(s0)
 8ce:	ae21                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8d0:	fd442783          	lw	a5,-44(s0)
 8d4:	0007871b          	sext.w	a4,a5
 8d8:	06c00793          	li	a5,108
 8dc:	04f71863          	bne	a4,a5,92c <vprintf+0x198>
 8e0:	fe442783          	lw	a5,-28(s0)
 8e4:	0007871b          	sext.w	a4,a5
 8e8:	06c00793          	li	a5,108
 8ec:	04f71063          	bne	a4,a5,92c <vprintf+0x198>
 8f0:	fe042783          	lw	a5,-32(s0)
 8f4:	0007871b          	sext.w	a4,a5
 8f8:	06400793          	li	a5,100
 8fc:	02f71863          	bne	a4,a5,92c <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 900:	fb843783          	ld	a5,-72(s0)
 904:	00878713          	addi	a4,a5,8
 908:	fae43c23          	sd	a4,-72(s0)
 90c:	639c                	ld	a5,0(a5)
 90e:	873e                	mv	a4,a5
 910:	fcc42783          	lw	a5,-52(s0)
 914:	4685                	li	a3,1
 916:	4629                	li	a2,10
 918:	85ba                	mv	a1,a4
 91a:	853e                	mv	a0,a5
 91c:	d09ff0ef          	jal	624 <printint>
        i += 2;
 920:	fdc42783          	lw	a5,-36(s0)
 924:	2789                	addiw	a5,a5,2
 926:	fcf42e23          	sw	a5,-36(s0)
 92a:	ac75                	j	be6 <vprintf+0x452>
      } else if(c0 == 'u'){
 92c:	fd442783          	lw	a5,-44(s0)
 930:	0007871b          	sext.w	a4,a5
 934:	07500793          	li	a5,117
 938:	02f71563          	bne	a4,a5,962 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 93c:	fb843783          	ld	a5,-72(s0)
 940:	00878713          	addi	a4,a5,8
 944:	fae43c23          	sd	a4,-72(s0)
 948:	439c                	lw	a5,0(a5)
 94a:	02079713          	slli	a4,a5,0x20
 94e:	9301                	srli	a4,a4,0x20
 950:	fcc42783          	lw	a5,-52(s0)
 954:	4681                	li	a3,0
 956:	4629                	li	a2,10
 958:	85ba                	mv	a1,a4
 95a:	853e                	mv	a0,a5
 95c:	cc9ff0ef          	jal	624 <printint>
 960:	a459                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 962:	fd442783          	lw	a5,-44(s0)
 966:	0007871b          	sext.w	a4,a5
 96a:	06c00793          	li	a5,108
 96e:	04f71063          	bne	a4,a5,9ae <vprintf+0x21a>
 972:	fe442783          	lw	a5,-28(s0)
 976:	0007871b          	sext.w	a4,a5
 97a:	07500793          	li	a5,117
 97e:	02f71863          	bne	a4,a5,9ae <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 982:	fb843783          	ld	a5,-72(s0)
 986:	00878713          	addi	a4,a5,8
 98a:	fae43c23          	sd	a4,-72(s0)
 98e:	639c                	ld	a5,0(a5)
 990:	873e                	mv	a4,a5
 992:	fcc42783          	lw	a5,-52(s0)
 996:	4681                	li	a3,0
 998:	4629                	li	a2,10
 99a:	85ba                	mv	a1,a4
 99c:	853e                	mv	a0,a5
 99e:	c87ff0ef          	jal	624 <printint>
        i += 1;
 9a2:	fdc42783          	lw	a5,-36(s0)
 9a6:	2785                	addiw	a5,a5,1
 9a8:	fcf42e23          	sw	a5,-36(s0)
 9ac:	ac2d                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9ae:	fd442783          	lw	a5,-44(s0)
 9b2:	0007871b          	sext.w	a4,a5
 9b6:	06c00793          	li	a5,108
 9ba:	04f71863          	bne	a4,a5,a0a <vprintf+0x276>
 9be:	fe442783          	lw	a5,-28(s0)
 9c2:	0007871b          	sext.w	a4,a5
 9c6:	06c00793          	li	a5,108
 9ca:	04f71063          	bne	a4,a5,a0a <vprintf+0x276>
 9ce:	fe042783          	lw	a5,-32(s0)
 9d2:	0007871b          	sext.w	a4,a5
 9d6:	07500793          	li	a5,117
 9da:	02f71863          	bne	a4,a5,a0a <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9de:	fb843783          	ld	a5,-72(s0)
 9e2:	00878713          	addi	a4,a5,8
 9e6:	fae43c23          	sd	a4,-72(s0)
 9ea:	639c                	ld	a5,0(a5)
 9ec:	873e                	mv	a4,a5
 9ee:	fcc42783          	lw	a5,-52(s0)
 9f2:	4681                	li	a3,0
 9f4:	4629                	li	a2,10
 9f6:	85ba                	mv	a1,a4
 9f8:	853e                	mv	a0,a5
 9fa:	c2bff0ef          	jal	624 <printint>
        i += 2;
 9fe:	fdc42783          	lw	a5,-36(s0)
 a02:	2789                	addiw	a5,a5,2
 a04:	fcf42e23          	sw	a5,-36(s0)
 a08:	aaf9                	j	be6 <vprintf+0x452>
      } else if(c0 == 'x'){
 a0a:	fd442783          	lw	a5,-44(s0)
 a0e:	0007871b          	sext.w	a4,a5
 a12:	07800793          	li	a5,120
 a16:	02f71563          	bne	a4,a5,a40 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a1a:	fb843783          	ld	a5,-72(s0)
 a1e:	00878713          	addi	a4,a5,8
 a22:	fae43c23          	sd	a4,-72(s0)
 a26:	439c                	lw	a5,0(a5)
 a28:	02079713          	slli	a4,a5,0x20
 a2c:	9301                	srli	a4,a4,0x20
 a2e:	fcc42783          	lw	a5,-52(s0)
 a32:	4681                	li	a3,0
 a34:	4641                	li	a2,16
 a36:	85ba                	mv	a1,a4
 a38:	853e                	mv	a0,a5
 a3a:	bebff0ef          	jal	624 <printint>
 a3e:	a265                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a40:	fd442783          	lw	a5,-44(s0)
 a44:	0007871b          	sext.w	a4,a5
 a48:	06c00793          	li	a5,108
 a4c:	04f71063          	bne	a4,a5,a8c <vprintf+0x2f8>
 a50:	fe442783          	lw	a5,-28(s0)
 a54:	0007871b          	sext.w	a4,a5
 a58:	07800793          	li	a5,120
 a5c:	02f71863          	bne	a4,a5,a8c <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a60:	fb843783          	ld	a5,-72(s0)
 a64:	00878713          	addi	a4,a5,8
 a68:	fae43c23          	sd	a4,-72(s0)
 a6c:	639c                	ld	a5,0(a5)
 a6e:	873e                	mv	a4,a5
 a70:	fcc42783          	lw	a5,-52(s0)
 a74:	4681                	li	a3,0
 a76:	4641                	li	a2,16
 a78:	85ba                	mv	a1,a4
 a7a:	853e                	mv	a0,a5
 a7c:	ba9ff0ef          	jal	624 <printint>
        i += 1;
 a80:	fdc42783          	lw	a5,-36(s0)
 a84:	2785                	addiw	a5,a5,1
 a86:	fcf42e23          	sw	a5,-36(s0)
 a8a:	aab1                	j	be6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a8c:	fd442783          	lw	a5,-44(s0)
 a90:	0007871b          	sext.w	a4,a5
 a94:	06c00793          	li	a5,108
 a98:	04f71863          	bne	a4,a5,ae8 <vprintf+0x354>
 a9c:	fe442783          	lw	a5,-28(s0)
 aa0:	0007871b          	sext.w	a4,a5
 aa4:	06c00793          	li	a5,108
 aa8:	04f71063          	bne	a4,a5,ae8 <vprintf+0x354>
 aac:	fe042783          	lw	a5,-32(s0)
 ab0:	0007871b          	sext.w	a4,a5
 ab4:	07800793          	li	a5,120
 ab8:	02f71863          	bne	a4,a5,ae8 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 abc:	fb843783          	ld	a5,-72(s0)
 ac0:	00878713          	addi	a4,a5,8
 ac4:	fae43c23          	sd	a4,-72(s0)
 ac8:	639c                	ld	a5,0(a5)
 aca:	873e                	mv	a4,a5
 acc:	fcc42783          	lw	a5,-52(s0)
 ad0:	4681                	li	a3,0
 ad2:	4641                	li	a2,16
 ad4:	85ba                	mv	a1,a4
 ad6:	853e                	mv	a0,a5
 ad8:	b4dff0ef          	jal	624 <printint>
        i += 2;
 adc:	fdc42783          	lw	a5,-36(s0)
 ae0:	2789                	addiw	a5,a5,2
 ae2:	fcf42e23          	sw	a5,-36(s0)
 ae6:	a201                	j	be6 <vprintf+0x452>
      } else if(c0 == 'p'){
 ae8:	fd442783          	lw	a5,-44(s0)
 aec:	0007871b          	sext.w	a4,a5
 af0:	07000793          	li	a5,112
 af4:	02f71063          	bne	a4,a5,b14 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 af8:	fb843783          	ld	a5,-72(s0)
 afc:	00878713          	addi	a4,a5,8
 b00:	fae43c23          	sd	a4,-72(s0)
 b04:	6398                	ld	a4,0(a5)
 b06:	fcc42783          	lw	a5,-52(s0)
 b0a:	85ba                	mv	a1,a4
 b0c:	853e                	mv	a0,a5
 b0e:	c09ff0ef          	jal	716 <printptr>
 b12:	a8d1                	j	be6 <vprintf+0x452>
      } else if(c0 == 'c'){
 b14:	fd442783          	lw	a5,-44(s0)
 b18:	0007871b          	sext.w	a4,a5
 b1c:	06300793          	li	a5,99
 b20:	02f71263          	bne	a4,a5,b44 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b24:	fb843783          	ld	a5,-72(s0)
 b28:	00878713          	addi	a4,a5,8
 b2c:	fae43c23          	sd	a4,-72(s0)
 b30:	439c                	lw	a5,0(a5)
 b32:	0ff7f713          	zext.b	a4,a5
 b36:	fcc42783          	lw	a5,-52(s0)
 b3a:	85ba                	mv	a1,a4
 b3c:	853e                	mv	a0,a5
 b3e:	ab5ff0ef          	jal	5f2 <putc>
 b42:	a055                	j	be6 <vprintf+0x452>
      } else if(c0 == 's'){
 b44:	fd442783          	lw	a5,-44(s0)
 b48:	0007871b          	sext.w	a4,a5
 b4c:	07300793          	li	a5,115
 b50:	04f71a63          	bne	a4,a5,ba4 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 b54:	fb843783          	ld	a5,-72(s0)
 b58:	00878713          	addi	a4,a5,8
 b5c:	fae43c23          	sd	a4,-72(s0)
 b60:	639c                	ld	a5,0(a5)
 b62:	fef43423          	sd	a5,-24(s0)
 b66:	fe843783          	ld	a5,-24(s0)
 b6a:	e79d                	bnez	a5,b98 <vprintf+0x404>
          s = "(null)";
 b6c:	00000797          	auipc	a5,0x0
 b70:	43478793          	addi	a5,a5,1076 # fa0 <malloc+0x152>
 b74:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 b78:	a005                	j	b98 <vprintf+0x404>
          putc(fd, *s);
 b7a:	fe843783          	ld	a5,-24(s0)
 b7e:	0007c703          	lbu	a4,0(a5)
 b82:	fcc42783          	lw	a5,-52(s0)
 b86:	85ba                	mv	a1,a4
 b88:	853e                	mv	a0,a5
 b8a:	a69ff0ef          	jal	5f2 <putc>
        for(; *s; s++)
 b8e:	fe843783          	ld	a5,-24(s0)
 b92:	0785                	addi	a5,a5,1
 b94:	fef43423          	sd	a5,-24(s0)
 b98:	fe843783          	ld	a5,-24(s0)
 b9c:	0007c783          	lbu	a5,0(a5)
 ba0:	ffe9                	bnez	a5,b7a <vprintf+0x3e6>
 ba2:	a091                	j	be6 <vprintf+0x452>
      } else if(c0 == '%'){
 ba4:	fd442783          	lw	a5,-44(s0)
 ba8:	0007871b          	sext.w	a4,a5
 bac:	02500793          	li	a5,37
 bb0:	00f71a63          	bne	a4,a5,bc4 <vprintf+0x430>
        putc(fd, '%');
 bb4:	fcc42783          	lw	a5,-52(s0)
 bb8:	02500593          	li	a1,37
 bbc:	853e                	mv	a0,a5
 bbe:	a35ff0ef          	jal	5f2 <putc>
 bc2:	a015                	j	be6 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bc4:	fcc42783          	lw	a5,-52(s0)
 bc8:	02500593          	li	a1,37
 bcc:	853e                	mv	a0,a5
 bce:	a25ff0ef          	jal	5f2 <putc>
        putc(fd, c0);
 bd2:	fd442783          	lw	a5,-44(s0)
 bd6:	0ff7f713          	zext.b	a4,a5
 bda:	fcc42783          	lw	a5,-52(s0)
 bde:	85ba                	mv	a1,a4
 be0:	853e                	mv	a0,a5
 be2:	a11ff0ef          	jal	5f2 <putc>
      }

      state = 0;
 be6:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 bea:	fdc42783          	lw	a5,-36(s0)
 bee:	2785                	addiw	a5,a5,1
 bf0:	fcf42e23          	sw	a5,-36(s0)
 bf4:	fdc42783          	lw	a5,-36(s0)
 bf8:	fc043703          	ld	a4,-64(s0)
 bfc:	97ba                	add	a5,a5,a4
 bfe:	0007c783          	lbu	a5,0(a5)
 c02:	ba0799e3          	bnez	a5,7b4 <vprintf+0x20>
    }
  }
}
 c06:	0001                	nop
 c08:	0001                	nop
 c0a:	60a6                	ld	ra,72(sp)
 c0c:	6406                	ld	s0,64(sp)
 c0e:	6161                	addi	sp,sp,80
 c10:	8082                	ret

0000000000000c12 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c12:	7159                	addi	sp,sp,-112
 c14:	fc06                	sd	ra,56(sp)
 c16:	f822                	sd	s0,48(sp)
 c18:	0080                	addi	s0,sp,64
 c1a:	fcb43823          	sd	a1,-48(s0)
 c1e:	e010                	sd	a2,0(s0)
 c20:	e414                	sd	a3,8(s0)
 c22:	e818                	sd	a4,16(s0)
 c24:	ec1c                	sd	a5,24(s0)
 c26:	03043023          	sd	a6,32(s0)
 c2a:	03143423          	sd	a7,40(s0)
 c2e:	87aa                	mv	a5,a0
 c30:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c34:	03040793          	addi	a5,s0,48
 c38:	fcf43423          	sd	a5,-56(s0)
 c3c:	fc843783          	ld	a5,-56(s0)
 c40:	fd078793          	addi	a5,a5,-48
 c44:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c48:	fe843703          	ld	a4,-24(s0)
 c4c:	fdc42783          	lw	a5,-36(s0)
 c50:	863a                	mv	a2,a4
 c52:	fd043583          	ld	a1,-48(s0)
 c56:	853e                	mv	a0,a5
 c58:	b3dff0ef          	jal	794 <vprintf>
}
 c5c:	0001                	nop
 c5e:	70e2                	ld	ra,56(sp)
 c60:	7442                	ld	s0,48(sp)
 c62:	6165                	addi	sp,sp,112
 c64:	8082                	ret

0000000000000c66 <printf>:

void
printf(const char *fmt, ...)
{
 c66:	7159                	addi	sp,sp,-112
 c68:	f406                	sd	ra,40(sp)
 c6a:	f022                	sd	s0,32(sp)
 c6c:	1800                	addi	s0,sp,48
 c6e:	fca43c23          	sd	a0,-40(s0)
 c72:	e40c                	sd	a1,8(s0)
 c74:	e810                	sd	a2,16(s0)
 c76:	ec14                	sd	a3,24(s0)
 c78:	f018                	sd	a4,32(s0)
 c7a:	f41c                	sd	a5,40(s0)
 c7c:	03043823          	sd	a6,48(s0)
 c80:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c84:	04040793          	addi	a5,s0,64
 c88:	fcf43823          	sd	a5,-48(s0)
 c8c:	fd043783          	ld	a5,-48(s0)
 c90:	fc878793          	addi	a5,a5,-56
 c94:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 c98:	fe843783          	ld	a5,-24(s0)
 c9c:	863e                	mv	a2,a5
 c9e:	fd843583          	ld	a1,-40(s0)
 ca2:	4505                	li	a0,1
 ca4:	af1ff0ef          	jal	794 <vprintf>
}
 ca8:	0001                	nop
 caa:	70a2                	ld	ra,40(sp)
 cac:	7402                	ld	s0,32(sp)
 cae:	6165                	addi	sp,sp,112
 cb0:	8082                	ret

0000000000000cb2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cb2:	7179                	addi	sp,sp,-48
 cb4:	f406                	sd	ra,40(sp)
 cb6:	f022                	sd	s0,32(sp)
 cb8:	1800                	addi	s0,sp,48
 cba:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 cbe:	fd843783          	ld	a5,-40(s0)
 cc2:	17c1                	addi	a5,a5,-16
 cc4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cc8:	00000797          	auipc	a5,0x0
 ccc:	36878793          	addi	a5,a5,872 # 1030 <freep>
 cd0:	639c                	ld	a5,0(a5)
 cd2:	fef43423          	sd	a5,-24(s0)
 cd6:	a815                	j	d0a <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cd8:	fe843783          	ld	a5,-24(s0)
 cdc:	639c                	ld	a5,0(a5)
 cde:	fe843703          	ld	a4,-24(s0)
 ce2:	00f76f63          	bltu	a4,a5,d00 <free+0x4e>
 ce6:	fe043703          	ld	a4,-32(s0)
 cea:	fe843783          	ld	a5,-24(s0)
 cee:	02e7eb63          	bltu	a5,a4,d24 <free+0x72>
 cf2:	fe843783          	ld	a5,-24(s0)
 cf6:	639c                	ld	a5,0(a5)
 cf8:	fe043703          	ld	a4,-32(s0)
 cfc:	02f76463          	bltu	a4,a5,d24 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d00:	fe843783          	ld	a5,-24(s0)
 d04:	639c                	ld	a5,0(a5)
 d06:	fef43423          	sd	a5,-24(s0)
 d0a:	fe043703          	ld	a4,-32(s0)
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	fce7f3e3          	bgeu	a5,a4,cd8 <free+0x26>
 d16:	fe843783          	ld	a5,-24(s0)
 d1a:	639c                	ld	a5,0(a5)
 d1c:	fe043703          	ld	a4,-32(s0)
 d20:	faf77ce3          	bgeu	a4,a5,cd8 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d24:	fe043783          	ld	a5,-32(s0)
 d28:	479c                	lw	a5,8(a5)
 d2a:	1782                	slli	a5,a5,0x20
 d2c:	9381                	srli	a5,a5,0x20
 d2e:	0792                	slli	a5,a5,0x4
 d30:	fe043703          	ld	a4,-32(s0)
 d34:	973e                	add	a4,a4,a5
 d36:	fe843783          	ld	a5,-24(s0)
 d3a:	639c                	ld	a5,0(a5)
 d3c:	02f71763          	bne	a4,a5,d6a <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d40:	fe043783          	ld	a5,-32(s0)
 d44:	4798                	lw	a4,8(a5)
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	639c                	ld	a5,0(a5)
 d4c:	479c                	lw	a5,8(a5)
 d4e:	9fb9                	addw	a5,a5,a4
 d50:	0007871b          	sext.w	a4,a5
 d54:	fe043783          	ld	a5,-32(s0)
 d58:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 d5a:	fe843783          	ld	a5,-24(s0)
 d5e:	639c                	ld	a5,0(a5)
 d60:	6398                	ld	a4,0(a5)
 d62:	fe043783          	ld	a5,-32(s0)
 d66:	e398                	sd	a4,0(a5)
 d68:	a039                	j	d76 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 d6a:	fe843783          	ld	a5,-24(s0)
 d6e:	6398                	ld	a4,0(a5)
 d70:	fe043783          	ld	a5,-32(s0)
 d74:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d76:	fe843783          	ld	a5,-24(s0)
 d7a:	479c                	lw	a5,8(a5)
 d7c:	1782                	slli	a5,a5,0x20
 d7e:	9381                	srli	a5,a5,0x20
 d80:	0792                	slli	a5,a5,0x4
 d82:	fe843703          	ld	a4,-24(s0)
 d86:	97ba                	add	a5,a5,a4
 d88:	fe043703          	ld	a4,-32(s0)
 d8c:	02f71563          	bne	a4,a5,db6 <free+0x104>
    p->s.size += bp->s.size;
 d90:	fe843783          	ld	a5,-24(s0)
 d94:	4798                	lw	a4,8(a5)
 d96:	fe043783          	ld	a5,-32(s0)
 d9a:	479c                	lw	a5,8(a5)
 d9c:	9fb9                	addw	a5,a5,a4
 d9e:	0007871b          	sext.w	a4,a5
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 da8:	fe043783          	ld	a5,-32(s0)
 dac:	6398                	ld	a4,0(a5)
 dae:	fe843783          	ld	a5,-24(s0)
 db2:	e398                	sd	a4,0(a5)
 db4:	a031                	j	dc0 <free+0x10e>
  } else
    p->s.ptr = bp;
 db6:	fe843783          	ld	a5,-24(s0)
 dba:	fe043703          	ld	a4,-32(s0)
 dbe:	e398                	sd	a4,0(a5)
  freep = p;
 dc0:	00000797          	auipc	a5,0x0
 dc4:	27078793          	addi	a5,a5,624 # 1030 <freep>
 dc8:	fe843703          	ld	a4,-24(s0)
 dcc:	e398                	sd	a4,0(a5)
}
 dce:	0001                	nop
 dd0:	70a2                	ld	ra,40(sp)
 dd2:	7402                	ld	s0,32(sp)
 dd4:	6145                	addi	sp,sp,48
 dd6:	8082                	ret

0000000000000dd8 <morecore>:

static Header*
morecore(uint nu)
{
 dd8:	7179                	addi	sp,sp,-48
 dda:	f406                	sd	ra,40(sp)
 ddc:	f022                	sd	s0,32(sp)
 dde:	1800                	addi	s0,sp,48
 de0:	87aa                	mv	a5,a0
 de2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 de6:	fdc42783          	lw	a5,-36(s0)
 dea:	0007871b          	sext.w	a4,a5
 dee:	6785                	lui	a5,0x1
 df0:	00f77563          	bgeu	a4,a5,dfa <morecore+0x22>
    nu = 4096;
 df4:	6785                	lui	a5,0x1
 df6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 dfa:	fdc42783          	lw	a5,-36(s0)
 dfe:	0047979b          	slliw	a5,a5,0x4
 e02:	2781                	sext.w	a5,a5
 e04:	853e                	mv	a0,a5
 e06:	ee8ff0ef          	jal	4ee <sbrk>
 e0a:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e0e:	fe843703          	ld	a4,-24(s0)
 e12:	57fd                	li	a5,-1
 e14:	00f71463          	bne	a4,a5,e1c <morecore+0x44>
    return 0;
 e18:	4781                	li	a5,0
 e1a:	a02d                	j	e44 <morecore+0x6c>
  hp = (Header*)p;
 e1c:	fe843783          	ld	a5,-24(s0)
 e20:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e24:	fe043783          	ld	a5,-32(s0)
 e28:	fdc42703          	lw	a4,-36(s0)
 e2c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e2e:	fe043783          	ld	a5,-32(s0)
 e32:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 e34:	853e                	mv	a0,a5
 e36:	e7dff0ef          	jal	cb2 <free>
  return freep;
 e3a:	00000797          	auipc	a5,0x0
 e3e:	1f678793          	addi	a5,a5,502 # 1030 <freep>
 e42:	639c                	ld	a5,0(a5)
}
 e44:	853e                	mv	a0,a5
 e46:	70a2                	ld	ra,40(sp)
 e48:	7402                	ld	s0,32(sp)
 e4a:	6145                	addi	sp,sp,48
 e4c:	8082                	ret

0000000000000e4e <malloc>:

void*
malloc(uint nbytes)
{
 e4e:	7139                	addi	sp,sp,-64
 e50:	fc06                	sd	ra,56(sp)
 e52:	f822                	sd	s0,48(sp)
 e54:	0080                	addi	s0,sp,64
 e56:	87aa                	mv	a5,a0
 e58:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e5c:	fcc46783          	lwu	a5,-52(s0)
 e60:	07bd                	addi	a5,a5,15
 e62:	8391                	srli	a5,a5,0x4
 e64:	2781                	sext.w	a5,a5
 e66:	2785                	addiw	a5,a5,1
 e68:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e6c:	00000797          	auipc	a5,0x0
 e70:	1c478793          	addi	a5,a5,452 # 1030 <freep>
 e74:	639c                	ld	a5,0(a5)
 e76:	fef43023          	sd	a5,-32(s0)
 e7a:	fe043783          	ld	a5,-32(s0)
 e7e:	ef95                	bnez	a5,eba <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e80:	00000797          	auipc	a5,0x0
 e84:	1a078793          	addi	a5,a5,416 # 1020 <base>
 e88:	fef43023          	sd	a5,-32(s0)
 e8c:	00000797          	auipc	a5,0x0
 e90:	1a478793          	addi	a5,a5,420 # 1030 <freep>
 e94:	fe043703          	ld	a4,-32(s0)
 e98:	e398                	sd	a4,0(a5)
 e9a:	00000797          	auipc	a5,0x0
 e9e:	19678793          	addi	a5,a5,406 # 1030 <freep>
 ea2:	6398                	ld	a4,0(a5)
 ea4:	00000797          	auipc	a5,0x0
 ea8:	17c78793          	addi	a5,a5,380 # 1020 <base>
 eac:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 eae:	00000797          	auipc	a5,0x0
 eb2:	17278793          	addi	a5,a5,370 # 1020 <base>
 eb6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eba:	fe043783          	ld	a5,-32(s0)
 ebe:	639c                	ld	a5,0(a5)
 ec0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ec4:	fe843783          	ld	a5,-24(s0)
 ec8:	479c                	lw	a5,8(a5)
 eca:	fdc42703          	lw	a4,-36(s0)
 ece:	2701                	sext.w	a4,a4
 ed0:	06e7e763          	bltu	a5,a4,f3e <malloc+0xf0>
      if(p->s.size == nunits)
 ed4:	fe843783          	ld	a5,-24(s0)
 ed8:	479c                	lw	a5,8(a5)
 eda:	fdc42703          	lw	a4,-36(s0)
 ede:	2701                	sext.w	a4,a4
 ee0:	00f71963          	bne	a4,a5,ef2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ee4:	fe843783          	ld	a5,-24(s0)
 ee8:	6398                	ld	a4,0(a5)
 eea:	fe043783          	ld	a5,-32(s0)
 eee:	e398                	sd	a4,0(a5)
 ef0:	a825                	j	f28 <malloc+0xda>
      else {
        p->s.size -= nunits;
 ef2:	fe843783          	ld	a5,-24(s0)
 ef6:	479c                	lw	a5,8(a5)
 ef8:	fdc42703          	lw	a4,-36(s0)
 efc:	9f99                	subw	a5,a5,a4
 efe:	0007871b          	sext.w	a4,a5
 f02:	fe843783          	ld	a5,-24(s0)
 f06:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f08:	fe843783          	ld	a5,-24(s0)
 f0c:	479c                	lw	a5,8(a5)
 f0e:	1782                	slli	a5,a5,0x20
 f10:	9381                	srli	a5,a5,0x20
 f12:	0792                	slli	a5,a5,0x4
 f14:	fe843703          	ld	a4,-24(s0)
 f18:	97ba                	add	a5,a5,a4
 f1a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f1e:	fe843783          	ld	a5,-24(s0)
 f22:	fdc42703          	lw	a4,-36(s0)
 f26:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f28:	00000797          	auipc	a5,0x0
 f2c:	10878793          	addi	a5,a5,264 # 1030 <freep>
 f30:	fe043703          	ld	a4,-32(s0)
 f34:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f36:	fe843783          	ld	a5,-24(s0)
 f3a:	07c1                	addi	a5,a5,16
 f3c:	a081                	j	f7c <malloc+0x12e>
    }
    if(p == freep)
 f3e:	00000797          	auipc	a5,0x0
 f42:	0f278793          	addi	a5,a5,242 # 1030 <freep>
 f46:	639c                	ld	a5,0(a5)
 f48:	fe843703          	ld	a4,-24(s0)
 f4c:	00f71e63          	bne	a4,a5,f68 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 f50:	fdc42783          	lw	a5,-36(s0)
 f54:	853e                	mv	a0,a5
 f56:	e83ff0ef          	jal	dd8 <morecore>
 f5a:	fea43423          	sd	a0,-24(s0)
 f5e:	fe843783          	ld	a5,-24(s0)
 f62:	e399                	bnez	a5,f68 <malloc+0x11a>
        return 0;
 f64:	4781                	li	a5,0
 f66:	a819                	j	f7c <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f68:	fe843783          	ld	a5,-24(s0)
 f6c:	fef43023          	sd	a5,-32(s0)
 f70:	fe843783          	ld	a5,-24(s0)
 f74:	639c                	ld	a5,0(a5)
 f76:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f7a:	b7a9                	j	ec4 <malloc+0x76>
  }
}
 f7c:	853e                	mv	a0,a5
 f7e:	70e2                	ld	ra,56(sp)
 f80:	7442                	ld	s0,48(sp)
 f82:	6121                	addi	sp,sp,64
 f84:	8082                	ret
