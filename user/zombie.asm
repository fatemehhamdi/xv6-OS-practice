
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	526000ef          	jal	52e <fork>
   c:	87aa                	mv	a5,a0
   e:	00f05563          	blez	a5,18 <main+0x18>
    pause(5);  // Let child exit before parent.
  12:	4515                	li	a0,5
  14:	5b2000ef          	jal	5c6 <pause>
  exit(0);
  18:	4501                	li	a0,0
  1a:	51c000ef          	jal	536 <exit>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  1e:	7179                	addi	sp,sp,-48
  20:	f406                	sd	ra,40(sp)
  22:	f022                	sd	s0,32(sp)
  24:	1800                	addi	s0,sp,48
  26:	87aa                	mv	a5,a0
  28:	fcb43823          	sd	a1,-48(s0)
  2c:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  30:	fdc42783          	lw	a5,-36(s0)
  34:	fd043583          	ld	a1,-48(s0)
  38:	853e                	mv	a0,a5
  3a:	fc7ff0ef          	jal	0 <main>
  3e:	87aa                	mv	a5,a0
  40:	fef42623          	sw	a5,-20(s0)
  exit(r);
  44:	fec42783          	lw	a5,-20(s0)
  48:	853e                	mv	a0,a5
  4a:	4ec000ef          	jal	536 <exit>

000000000000004e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  4e:	7179                	addi	sp,sp,-48
  50:	f406                	sd	ra,40(sp)
  52:	f022                	sd	s0,32(sp)
  54:	1800                	addi	s0,sp,48
  56:	fca43c23          	sd	a0,-40(s0)
  5a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  5e:	fd843783          	ld	a5,-40(s0)
  62:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  66:	0001                	nop
  68:	fd043703          	ld	a4,-48(s0)
  6c:	00170793          	addi	a5,a4,1
  70:	fcf43823          	sd	a5,-48(s0)
  74:	fd843783          	ld	a5,-40(s0)
  78:	00178693          	addi	a3,a5,1
  7c:	fcd43c23          	sd	a3,-40(s0)
  80:	00074703          	lbu	a4,0(a4)
  84:	00e78023          	sb	a4,0(a5)
  88:	0007c783          	lbu	a5,0(a5)
  8c:	fff1                	bnez	a5,68 <strcpy+0x1a>
    ;
  return os;
  8e:	fe843783          	ld	a5,-24(s0)
}
  92:	853e                	mv	a0,a5
  94:	70a2                	ld	ra,40(sp)
  96:	7402                	ld	s0,32(sp)
  98:	6145                	addi	sp,sp,48
  9a:	8082                	ret

000000000000009c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9c:	1101                	addi	sp,sp,-32
  9e:	ec06                	sd	ra,24(sp)
  a0:	e822                	sd	s0,16(sp)
  a2:	1000                	addi	s0,sp,32
  a4:	fea43423          	sd	a0,-24(s0)
  a8:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  ac:	a819                	j	c2 <strcmp+0x26>
    p++, q++;
  ae:	fe843783          	ld	a5,-24(s0)
  b2:	0785                	addi	a5,a5,1
  b4:	fef43423          	sd	a5,-24(s0)
  b8:	fe043783          	ld	a5,-32(s0)
  bc:	0785                	addi	a5,a5,1
  be:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  c2:	fe843783          	ld	a5,-24(s0)
  c6:	0007c783          	lbu	a5,0(a5)
  ca:	cb99                	beqz	a5,e0 <strcmp+0x44>
  cc:	fe843783          	ld	a5,-24(s0)
  d0:	0007c703          	lbu	a4,0(a5)
  d4:	fe043783          	ld	a5,-32(s0)
  d8:	0007c783          	lbu	a5,0(a5)
  dc:	fcf709e3          	beq	a4,a5,ae <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
  e0:	fe843783          	ld	a5,-24(s0)
  e4:	0007c783          	lbu	a5,0(a5)
  e8:	0007871b          	sext.w	a4,a5
  ec:	fe043783          	ld	a5,-32(s0)
  f0:	0007c783          	lbu	a5,0(a5)
  f4:	2781                	sext.w	a5,a5
  f6:	40f707bb          	subw	a5,a4,a5
  fa:	2781                	sext.w	a5,a5
}
  fc:	853e                	mv	a0,a5
  fe:	60e2                	ld	ra,24(sp)
 100:	6442                	ld	s0,16(sp)
 102:	6105                	addi	sp,sp,32
 104:	8082                	ret

0000000000000106 <strlen>:

uint
strlen(const char *s)
{
 106:	7179                	addi	sp,sp,-48
 108:	f406                	sd	ra,40(sp)
 10a:	f022                	sd	s0,32(sp)
 10c:	1800                	addi	s0,sp,48
 10e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 112:	fe042623          	sw	zero,-20(s0)
 116:	a031                	j	122 <strlen+0x1c>
 118:	fec42783          	lw	a5,-20(s0)
 11c:	2785                	addiw	a5,a5,1
 11e:	fef42623          	sw	a5,-20(s0)
 122:	fec42783          	lw	a5,-20(s0)
 126:	fd843703          	ld	a4,-40(s0)
 12a:	97ba                	add	a5,a5,a4
 12c:	0007c783          	lbu	a5,0(a5)
 130:	f7e5                	bnez	a5,118 <strlen+0x12>
    ;
  return n;
 132:	fec42783          	lw	a5,-20(s0)
}
 136:	853e                	mv	a0,a5
 138:	70a2                	ld	ra,40(sp)
 13a:	7402                	ld	s0,32(sp)
 13c:	6145                	addi	sp,sp,48
 13e:	8082                	ret

0000000000000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	7179                	addi	sp,sp,-48
 142:	f406                	sd	ra,40(sp)
 144:	f022                	sd	s0,32(sp)
 146:	1800                	addi	s0,sp,48
 148:	fca43c23          	sd	a0,-40(s0)
 14c:	87ae                	mv	a5,a1
 14e:	8732                	mv	a4,a2
 150:	fcf42a23          	sw	a5,-44(s0)
 154:	87ba                	mv	a5,a4
 156:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 15a:	fd843783          	ld	a5,-40(s0)
 15e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 162:	fe042623          	sw	zero,-20(s0)
 166:	a00d                	j	188 <memset+0x48>
    cdst[i] = c;
 168:	fec42783          	lw	a5,-20(s0)
 16c:	fe043703          	ld	a4,-32(s0)
 170:	97ba                	add	a5,a5,a4
 172:	fd442703          	lw	a4,-44(s0)
 176:	0ff77713          	zext.b	a4,a4
 17a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 17e:	fec42783          	lw	a5,-20(s0)
 182:	2785                	addiw	a5,a5,1
 184:	fef42623          	sw	a5,-20(s0)
 188:	fec42783          	lw	a5,-20(s0)
 18c:	fd042703          	lw	a4,-48(s0)
 190:	2701                	sext.w	a4,a4
 192:	fce7ebe3          	bltu	a5,a4,168 <memset+0x28>
  }
  return dst;
 196:	fd843783          	ld	a5,-40(s0)
}
 19a:	853e                	mv	a0,a5
 19c:	70a2                	ld	ra,40(sp)
 19e:	7402                	ld	s0,32(sp)
 1a0:	6145                	addi	sp,sp,48
 1a2:	8082                	ret

00000000000001a4 <strchr>:

char*
strchr(const char *s, char c)
{
 1a4:	1101                	addi	sp,sp,-32
 1a6:	ec06                	sd	ra,24(sp)
 1a8:	e822                	sd	s0,16(sp)
 1aa:	1000                	addi	s0,sp,32
 1ac:	fea43423          	sd	a0,-24(s0)
 1b0:	87ae                	mv	a5,a1
 1b2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1b6:	a01d                	j	1dc <strchr+0x38>
    if(*s == c)
 1b8:	fe843783          	ld	a5,-24(s0)
 1bc:	0007c703          	lbu	a4,0(a5)
 1c0:	fe744783          	lbu	a5,-25(s0)
 1c4:	0ff7f793          	zext.b	a5,a5
 1c8:	00e79563          	bne	a5,a4,1d2 <strchr+0x2e>
      return (char*)s;
 1cc:	fe843783          	ld	a5,-24(s0)
 1d0:	a821                	j	1e8 <strchr+0x44>
  for(; *s; s++)
 1d2:	fe843783          	ld	a5,-24(s0)
 1d6:	0785                	addi	a5,a5,1
 1d8:	fef43423          	sd	a5,-24(s0)
 1dc:	fe843783          	ld	a5,-24(s0)
 1e0:	0007c783          	lbu	a5,0(a5)
 1e4:	fbf1                	bnez	a5,1b8 <strchr+0x14>
  return 0;
 1e6:	4781                	li	a5,0
}
 1e8:	853e                	mv	a0,a5
 1ea:	60e2                	ld	ra,24(sp)
 1ec:	6442                	ld	s0,16(sp)
 1ee:	6105                	addi	sp,sp,32
 1f0:	8082                	ret

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	7179                	addi	sp,sp,-48
 1f4:	f406                	sd	ra,40(sp)
 1f6:	f022                	sd	s0,32(sp)
 1f8:	1800                	addi	s0,sp,48
 1fa:	fca43c23          	sd	a0,-40(s0)
 1fe:	87ae                	mv	a5,a1
 200:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 204:	fe042623          	sw	zero,-20(s0)
 208:	a891                	j	25c <gets+0x6a>
    cc = read(0, &c, 1);
 20a:	fe740793          	addi	a5,s0,-25
 20e:	4605                	li	a2,1
 210:	85be                	mv	a1,a5
 212:	4501                	li	a0,0
 214:	33a000ef          	jal	54e <read>
 218:	87aa                	mv	a5,a0
 21a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 21e:	fe842783          	lw	a5,-24(s0)
 222:	2781                	sext.w	a5,a5
 224:	04f05663          	blez	a5,270 <gets+0x7e>
      break;
    buf[i++] = c;
 228:	fec42783          	lw	a5,-20(s0)
 22c:	0017871b          	addiw	a4,a5,1
 230:	fee42623          	sw	a4,-20(s0)
 234:	873e                	mv	a4,a5
 236:	fd843783          	ld	a5,-40(s0)
 23a:	97ba                	add	a5,a5,a4
 23c:	fe744703          	lbu	a4,-25(s0)
 240:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 244:	fe744783          	lbu	a5,-25(s0)
 248:	873e                	mv	a4,a5
 24a:	47a9                	li	a5,10
 24c:	02f70363          	beq	a4,a5,272 <gets+0x80>
 250:	fe744783          	lbu	a5,-25(s0)
 254:	873e                	mv	a4,a5
 256:	47b5                	li	a5,13
 258:	00f70d63          	beq	a4,a5,272 <gets+0x80>
  for(i=0; i+1 < max; ){
 25c:	fec42783          	lw	a5,-20(s0)
 260:	2785                	addiw	a5,a5,1
 262:	2781                	sext.w	a5,a5
 264:	fd442703          	lw	a4,-44(s0)
 268:	2701                	sext.w	a4,a4
 26a:	fae7c0e3          	blt	a5,a4,20a <gets+0x18>
 26e:	a011                	j	272 <gets+0x80>
      break;
 270:	0001                	nop
      break;
  }
  buf[i] = '\0';
 272:	fec42783          	lw	a5,-20(s0)
 276:	fd843703          	ld	a4,-40(s0)
 27a:	97ba                	add	a5,a5,a4
 27c:	00078023          	sb	zero,0(a5)
  return buf;
 280:	fd843783          	ld	a5,-40(s0)
}
 284:	853e                	mv	a0,a5
 286:	70a2                	ld	ra,40(sp)
 288:	7402                	ld	s0,32(sp)
 28a:	6145                	addi	sp,sp,48
 28c:	8082                	ret

000000000000028e <stat>:

int
stat(const char *n, struct stat *st)
{
 28e:	7179                	addi	sp,sp,-48
 290:	f406                	sd	ra,40(sp)
 292:	f022                	sd	s0,32(sp)
 294:	1800                	addi	s0,sp,48
 296:	fca43c23          	sd	a0,-40(s0)
 29a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	4581                	li	a1,0
 2a0:	fd843503          	ld	a0,-40(s0)
 2a4:	2d2000ef          	jal	576 <open>
 2a8:	87aa                	mv	a5,a0
 2aa:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2ae:	fec42783          	lw	a5,-20(s0)
 2b2:	2781                	sext.w	a5,a5
 2b4:	0007d463          	bgez	a5,2bc <stat+0x2e>
    return -1;
 2b8:	57fd                	li	a5,-1
 2ba:	a015                	j	2de <stat+0x50>
  r = fstat(fd, st);
 2bc:	fec42783          	lw	a5,-20(s0)
 2c0:	fd043583          	ld	a1,-48(s0)
 2c4:	853e                	mv	a0,a5
 2c6:	2c8000ef          	jal	58e <fstat>
 2ca:	87aa                	mv	a5,a0
 2cc:	fef42423          	sw	a5,-24(s0)
  close(fd);
 2d0:	fec42783          	lw	a5,-20(s0)
 2d4:	853e                	mv	a0,a5
 2d6:	288000ef          	jal	55e <close>
  return r;
 2da:	fe842783          	lw	a5,-24(s0)
}
 2de:	853e                	mv	a0,a5
 2e0:	70a2                	ld	ra,40(sp)
 2e2:	7402                	ld	s0,32(sp)
 2e4:	6145                	addi	sp,sp,48
 2e6:	8082                	ret

00000000000002e8 <atoi>:

int
atoi(const char *s)
{
 2e8:	7179                	addi	sp,sp,-48
 2ea:	f406                	sd	ra,40(sp)
 2ec:	f022                	sd	s0,32(sp)
 2ee:	1800                	addi	s0,sp,48
 2f0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 2f4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 2f8:	a81d                	j	32e <atoi+0x46>
    n = n*10 + *s++ - '0';
 2fa:	fec42783          	lw	a5,-20(s0)
 2fe:	873e                	mv	a4,a5
 300:	87ba                	mv	a5,a4
 302:	0027979b          	slliw	a5,a5,0x2
 306:	9fb9                	addw	a5,a5,a4
 308:	0017979b          	slliw	a5,a5,0x1
 30c:	0007871b          	sext.w	a4,a5
 310:	fd843783          	ld	a5,-40(s0)
 314:	00178693          	addi	a3,a5,1
 318:	fcd43c23          	sd	a3,-40(s0)
 31c:	0007c783          	lbu	a5,0(a5)
 320:	2781                	sext.w	a5,a5
 322:	9fb9                	addw	a5,a5,a4
 324:	2781                	sext.w	a5,a5
 326:	fd07879b          	addiw	a5,a5,-48
 32a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 32e:	fd843783          	ld	a5,-40(s0)
 332:	0007c783          	lbu	a5,0(a5)
 336:	873e                	mv	a4,a5
 338:	02f00793          	li	a5,47
 33c:	00e7fb63          	bgeu	a5,a4,352 <atoi+0x6a>
 340:	fd843783          	ld	a5,-40(s0)
 344:	0007c783          	lbu	a5,0(a5)
 348:	873e                	mv	a4,a5
 34a:	03900793          	li	a5,57
 34e:	fae7f6e3          	bgeu	a5,a4,2fa <atoi+0x12>
  return n;
 352:	fec42783          	lw	a5,-20(s0)
}
 356:	853e                	mv	a0,a5
 358:	70a2                	ld	ra,40(sp)
 35a:	7402                	ld	s0,32(sp)
 35c:	6145                	addi	sp,sp,48
 35e:	8082                	ret

0000000000000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	7139                	addi	sp,sp,-64
 362:	fc06                	sd	ra,56(sp)
 364:	f822                	sd	s0,48(sp)
 366:	0080                	addi	s0,sp,64
 368:	fca43c23          	sd	a0,-40(s0)
 36c:	fcb43823          	sd	a1,-48(s0)
 370:	87b2                	mv	a5,a2
 372:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 376:	fd843783          	ld	a5,-40(s0)
 37a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 37e:	fd043783          	ld	a5,-48(s0)
 382:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 386:	fe043703          	ld	a4,-32(s0)
 38a:	fe843783          	ld	a5,-24(s0)
 38e:	02e7fc63          	bgeu	a5,a4,3c6 <memmove+0x66>
    while(n-- > 0)
 392:	a00d                	j	3b4 <memmove+0x54>
      *dst++ = *src++;
 394:	fe043703          	ld	a4,-32(s0)
 398:	00170793          	addi	a5,a4,1
 39c:	fef43023          	sd	a5,-32(s0)
 3a0:	fe843783          	ld	a5,-24(s0)
 3a4:	00178693          	addi	a3,a5,1
 3a8:	fed43423          	sd	a3,-24(s0)
 3ac:	00074703          	lbu	a4,0(a4)
 3b0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3b4:	fcc42783          	lw	a5,-52(s0)
 3b8:	fff7871b          	addiw	a4,a5,-1
 3bc:	fce42623          	sw	a4,-52(s0)
 3c0:	fcf04ae3          	bgtz	a5,394 <memmove+0x34>
 3c4:	a891                	j	418 <memmove+0xb8>
  } else {
    dst += n;
 3c6:	fcc42783          	lw	a5,-52(s0)
 3ca:	fe843703          	ld	a4,-24(s0)
 3ce:	97ba                	add	a5,a5,a4
 3d0:	fef43423          	sd	a5,-24(s0)
    src += n;
 3d4:	fcc42783          	lw	a5,-52(s0)
 3d8:	fe043703          	ld	a4,-32(s0)
 3dc:	97ba                	add	a5,a5,a4
 3de:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 3e2:	a01d                	j	408 <memmove+0xa8>
      *--dst = *--src;
 3e4:	fe043783          	ld	a5,-32(s0)
 3e8:	17fd                	addi	a5,a5,-1
 3ea:	fef43023          	sd	a5,-32(s0)
 3ee:	fe843783          	ld	a5,-24(s0)
 3f2:	17fd                	addi	a5,a5,-1
 3f4:	fef43423          	sd	a5,-24(s0)
 3f8:	fe043783          	ld	a5,-32(s0)
 3fc:	0007c703          	lbu	a4,0(a5)
 400:	fe843783          	ld	a5,-24(s0)
 404:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 408:	fcc42783          	lw	a5,-52(s0)
 40c:	fff7871b          	addiw	a4,a5,-1
 410:	fce42623          	sw	a4,-52(s0)
 414:	fcf048e3          	bgtz	a5,3e4 <memmove+0x84>
  }
  return vdst;
 418:	fd843783          	ld	a5,-40(s0)
}
 41c:	853e                	mv	a0,a5
 41e:	70e2                	ld	ra,56(sp)
 420:	7442                	ld	s0,48(sp)
 422:	6121                	addi	sp,sp,64
 424:	8082                	ret

0000000000000426 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 426:	7139                	addi	sp,sp,-64
 428:	fc06                	sd	ra,56(sp)
 42a:	f822                	sd	s0,48(sp)
 42c:	0080                	addi	s0,sp,64
 42e:	fca43c23          	sd	a0,-40(s0)
 432:	fcb43823          	sd	a1,-48(s0)
 436:	87b2                	mv	a5,a2
 438:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 43c:	fd843783          	ld	a5,-40(s0)
 440:	fef43423          	sd	a5,-24(s0)
 444:	fd043783          	ld	a5,-48(s0)
 448:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 44c:	a0a1                	j	494 <memcmp+0x6e>
    if (*p1 != *p2) {
 44e:	fe843783          	ld	a5,-24(s0)
 452:	0007c703          	lbu	a4,0(a5)
 456:	fe043783          	ld	a5,-32(s0)
 45a:	0007c783          	lbu	a5,0(a5)
 45e:	02f70163          	beq	a4,a5,480 <memcmp+0x5a>
      return *p1 - *p2;
 462:	fe843783          	ld	a5,-24(s0)
 466:	0007c783          	lbu	a5,0(a5)
 46a:	0007871b          	sext.w	a4,a5
 46e:	fe043783          	ld	a5,-32(s0)
 472:	0007c783          	lbu	a5,0(a5)
 476:	2781                	sext.w	a5,a5
 478:	40f707bb          	subw	a5,a4,a5
 47c:	2781                	sext.w	a5,a5
 47e:	a01d                	j	4a4 <memcmp+0x7e>
    }
    p1++;
 480:	fe843783          	ld	a5,-24(s0)
 484:	0785                	addi	a5,a5,1
 486:	fef43423          	sd	a5,-24(s0)
    p2++;
 48a:	fe043783          	ld	a5,-32(s0)
 48e:	0785                	addi	a5,a5,1
 490:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 494:	fcc42783          	lw	a5,-52(s0)
 498:	fff7871b          	addiw	a4,a5,-1
 49c:	fce42623          	sw	a4,-52(s0)
 4a0:	f7dd                	bnez	a5,44e <memcmp+0x28>
  }
  return 0;
 4a2:	4781                	li	a5,0
}
 4a4:	853e                	mv	a0,a5
 4a6:	70e2                	ld	ra,56(sp)
 4a8:	7442                	ld	s0,48(sp)
 4aa:	6121                	addi	sp,sp,64
 4ac:	8082                	ret

00000000000004ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ae:	7179                	addi	sp,sp,-48
 4b0:	f406                	sd	ra,40(sp)
 4b2:	f022                	sd	s0,32(sp)
 4b4:	1800                	addi	s0,sp,48
 4b6:	fea43423          	sd	a0,-24(s0)
 4ba:	feb43023          	sd	a1,-32(s0)
 4be:	87b2                	mv	a5,a2
 4c0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4c4:	fdc42783          	lw	a5,-36(s0)
 4c8:	863e                	mv	a2,a5
 4ca:	fe043583          	ld	a1,-32(s0)
 4ce:	fe843503          	ld	a0,-24(s0)
 4d2:	e8fff0ef          	jal	360 <memmove>
 4d6:	87aa                	mv	a5,a0
}
 4d8:	853e                	mv	a0,a5
 4da:	70a2                	ld	ra,40(sp)
 4dc:	7402                	ld	s0,32(sp)
 4de:	6145                	addi	sp,sp,48
 4e0:	8082                	ret

00000000000004e2 <sbrk>:

char *
sbrk(int n) {
 4e2:	1101                	addi	sp,sp,-32
 4e4:	ec06                	sd	ra,24(sp)
 4e6:	e822                	sd	s0,16(sp)
 4e8:	1000                	addi	s0,sp,32
 4ea:	87aa                	mv	a5,a0
 4ec:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 4f0:	fec42783          	lw	a5,-20(s0)
 4f4:	4585                	li	a1,1
 4f6:	853e                	mv	a0,a5
 4f8:	0c6000ef          	jal	5be <sys_sbrk>
 4fc:	87aa                	mv	a5,a0
}
 4fe:	853e                	mv	a0,a5
 500:	60e2                	ld	ra,24(sp)
 502:	6442                	ld	s0,16(sp)
 504:	6105                	addi	sp,sp,32
 506:	8082                	ret

0000000000000508 <sbrklazy>:

char *
sbrklazy(int n) {
 508:	1101                	addi	sp,sp,-32
 50a:	ec06                	sd	ra,24(sp)
 50c:	e822                	sd	s0,16(sp)
 50e:	1000                	addi	s0,sp,32
 510:	87aa                	mv	a5,a0
 512:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 516:	fec42783          	lw	a5,-20(s0)
 51a:	4589                	li	a1,2
 51c:	853e                	mv	a0,a5
 51e:	0a0000ef          	jal	5be <sys_sbrk>
 522:	87aa                	mv	a5,a0
}
 524:	853e                	mv	a0,a5
 526:	60e2                	ld	ra,24(sp)
 528:	6442                	ld	s0,16(sp)
 52a:	6105                	addi	sp,sp,32
 52c:	8082                	ret

000000000000052e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52e:	4885                	li	a7,1
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exit>:
.global exit
exit:
 li a7, SYS_exit
 536:	4889                	li	a7,2
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <wait>:
.global wait
wait:
 li a7, SYS_wait
 53e:	488d                	li	a7,3
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 546:	4891                	li	a7,4
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <read>:
.global read
read:
 li a7, SYS_read
 54e:	4895                	li	a7,5
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <write>:
.global write
write:
 li a7, SYS_write
 556:	48c1                	li	a7,16
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <close>:
.global close
close:
 li a7, SYS_close
 55e:	48d5                	li	a7,21
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <kill>:
.global kill
kill:
 li a7, SYS_kill
 566:	4899                	li	a7,6
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exec>:
.global exec
exec:
 li a7, SYS_exec
 56e:	489d                	li	a7,7
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <open>:
.global open
open:
 li a7, SYS_open
 576:	48bd                	li	a7,15
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57e:	48c5                	li	a7,17
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 586:	48c9                	li	a7,18
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58e:	48a1                	li	a7,8
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <link>:
.global link
link:
 li a7, SYS_link
 596:	48cd                	li	a7,19
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59e:	48d1                	li	a7,20
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a6:	48a5                	li	a7,9
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ae:	48a9                	li	a7,10
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b6:	48ad                	li	a7,11
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5be:	48b1                	li	a7,12
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5c6:	48b5                	li	a7,13
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ce:	48b9                	li	a7,14
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <top>:
.global top
top:
 li a7, SYS_top
 5d6:	48d9                	li	a7,22
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
 5de:	48dd                	li	a7,23
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5e6:	1101                	addi	sp,sp,-32
 5e8:	ec06                	sd	ra,24(sp)
 5ea:	e822                	sd	s0,16(sp)
 5ec:	1000                	addi	s0,sp,32
 5ee:	87aa                	mv	a5,a0
 5f0:	872e                	mv	a4,a1
 5f2:	fef42623          	sw	a5,-20(s0)
 5f6:	87ba                	mv	a5,a4
 5f8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5fc:	feb40713          	addi	a4,s0,-21
 600:	fec42783          	lw	a5,-20(s0)
 604:	4605                	li	a2,1
 606:	85ba                	mv	a1,a4
 608:	853e                	mv	a0,a5
 60a:	f4dff0ef          	jal	556 <write>
}
 60e:	0001                	nop
 610:	60e2                	ld	ra,24(sp)
 612:	6442                	ld	s0,16(sp)
 614:	6105                	addi	sp,sp,32
 616:	8082                	ret

0000000000000618 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 618:	711d                	addi	sp,sp,-96
 61a:	ec86                	sd	ra,88(sp)
 61c:	e8a2                	sd	s0,80(sp)
 61e:	1080                	addi	s0,sp,96
 620:	87aa                	mv	a5,a0
 622:	fab43823          	sd	a1,-80(s0)
 626:	8736                	mv	a4,a3
 628:	faf42e23          	sw	a5,-68(s0)
 62c:	87b2                	mv	a5,a2
 62e:	faf42c23          	sw	a5,-72(s0)
 632:	87ba                	mv	a5,a4
 634:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 638:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 63c:	fac42783          	lw	a5,-84(s0)
 640:	2781                	sext.w	a5,a5
 642:	cf99                	beqz	a5,660 <printint+0x48>
 644:	fb043783          	ld	a5,-80(s0)
 648:	0007dc63          	bgez	a5,660 <printint+0x48>
    neg = 1;
 64c:	4785                	li	a5,1
 64e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 652:	fb043783          	ld	a5,-80(s0)
 656:	40f007b3          	neg	a5,a5
 65a:	fef43023          	sd	a5,-32(s0)
 65e:	a029                	j	668 <printint+0x50>
  } else {
    x = xx;
 660:	fb043783          	ld	a5,-80(s0)
 664:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 668:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 66c:	fb842783          	lw	a5,-72(s0)
 670:	fe043703          	ld	a4,-32(s0)
 674:	02f77733          	remu	a4,a4,a5
 678:	fec42783          	lw	a5,-20(s0)
 67c:	0017869b          	addiw	a3,a5,1
 680:	fed42623          	sw	a3,-20(s0)
 684:	00001697          	auipc	a3,0x1
 688:	97c68693          	addi	a3,a3,-1668 # 1000 <digits>
 68c:	9736                	add	a4,a4,a3
 68e:	00074703          	lbu	a4,0(a4)
 692:	17c1                	addi	a5,a5,-16
 694:	97a2                	add	a5,a5,s0
 696:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 69a:	fb842783          	lw	a5,-72(s0)
 69e:	fe043703          	ld	a4,-32(s0)
 6a2:	02f757b3          	divu	a5,a4,a5
 6a6:	fef43023          	sd	a5,-32(s0)
 6aa:	fe043783          	ld	a5,-32(s0)
 6ae:	ffdd                	bnez	a5,66c <printint+0x54>
  if(neg)
 6b0:	fe842783          	lw	a5,-24(s0)
 6b4:	2781                	sext.w	a5,a5
 6b6:	cb95                	beqz	a5,6ea <printint+0xd2>
    buf[i++] = '-';
 6b8:	fec42783          	lw	a5,-20(s0)
 6bc:	0017871b          	addiw	a4,a5,1
 6c0:	fee42623          	sw	a4,-20(s0)
 6c4:	17c1                	addi	a5,a5,-16
 6c6:	97a2                	add	a5,a5,s0
 6c8:	02d00713          	li	a4,45
 6cc:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 6d0:	a829                	j	6ea <printint+0xd2>
    putc(fd, buf[i]);
 6d2:	fec42783          	lw	a5,-20(s0)
 6d6:	17c1                	addi	a5,a5,-16
 6d8:	97a2                	add	a5,a5,s0
 6da:	fd87c703          	lbu	a4,-40(a5)
 6de:	fbc42783          	lw	a5,-68(s0)
 6e2:	85ba                	mv	a1,a4
 6e4:	853e                	mv	a0,a5
 6e6:	f01ff0ef          	jal	5e6 <putc>
  while(--i >= 0)
 6ea:	fec42783          	lw	a5,-20(s0)
 6ee:	37fd                	addiw	a5,a5,-1
 6f0:	fef42623          	sw	a5,-20(s0)
 6f4:	fec42783          	lw	a5,-20(s0)
 6f8:	2781                	sext.w	a5,a5
 6fa:	fc07dce3          	bgez	a5,6d2 <printint+0xba>
}
 6fe:	0001                	nop
 700:	0001                	nop
 702:	60e6                	ld	ra,88(sp)
 704:	6446                	ld	s0,80(sp)
 706:	6125                	addi	sp,sp,96
 708:	8082                	ret

000000000000070a <printptr>:

static void
printptr(int fd, uint64 x) {
 70a:	7179                	addi	sp,sp,-48
 70c:	f406                	sd	ra,40(sp)
 70e:	f022                	sd	s0,32(sp)
 710:	1800                	addi	s0,sp,48
 712:	87aa                	mv	a5,a0
 714:	fcb43823          	sd	a1,-48(s0)
 718:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 71c:	fdc42783          	lw	a5,-36(s0)
 720:	03000593          	li	a1,48
 724:	853e                	mv	a0,a5
 726:	ec1ff0ef          	jal	5e6 <putc>
  putc(fd, 'x');
 72a:	fdc42783          	lw	a5,-36(s0)
 72e:	07800593          	li	a1,120
 732:	853e                	mv	a0,a5
 734:	eb3ff0ef          	jal	5e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 738:	fe042623          	sw	zero,-20(s0)
 73c:	a81d                	j	772 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 73e:	fd043783          	ld	a5,-48(s0)
 742:	93f1                	srli	a5,a5,0x3c
 744:	00001717          	auipc	a4,0x1
 748:	8bc70713          	addi	a4,a4,-1860 # 1000 <digits>
 74c:	97ba                	add	a5,a5,a4
 74e:	0007c703          	lbu	a4,0(a5)
 752:	fdc42783          	lw	a5,-36(s0)
 756:	85ba                	mv	a1,a4
 758:	853e                	mv	a0,a5
 75a:	e8dff0ef          	jal	5e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 75e:	fec42783          	lw	a5,-20(s0)
 762:	2785                	addiw	a5,a5,1
 764:	fef42623          	sw	a5,-20(s0)
 768:	fd043783          	ld	a5,-48(s0)
 76c:	0792                	slli	a5,a5,0x4
 76e:	fcf43823          	sd	a5,-48(s0)
 772:	fec42703          	lw	a4,-20(s0)
 776:	47bd                	li	a5,15
 778:	fce7f3e3          	bgeu	a5,a4,73e <printptr+0x34>
}
 77c:	0001                	nop
 77e:	0001                	nop
 780:	70a2                	ld	ra,40(sp)
 782:	7402                	ld	s0,32(sp)
 784:	6145                	addi	sp,sp,48
 786:	8082                	ret

0000000000000788 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 788:	715d                	addi	sp,sp,-80
 78a:	e486                	sd	ra,72(sp)
 78c:	e0a2                	sd	s0,64(sp)
 78e:	0880                	addi	s0,sp,80
 790:	87aa                	mv	a5,a0
 792:	fcb43023          	sd	a1,-64(s0)
 796:	fac43c23          	sd	a2,-72(s0)
 79a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 79e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 7a2:	fc042e23          	sw	zero,-36(s0)
 7a6:	a189                	j	be8 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 7a8:	fdc42783          	lw	a5,-36(s0)
 7ac:	fc043703          	ld	a4,-64(s0)
 7b0:	97ba                	add	a5,a5,a4
 7b2:	0007c783          	lbu	a5,0(a5)
 7b6:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 7ba:	fd842783          	lw	a5,-40(s0)
 7be:	2781                	sext.w	a5,a5
 7c0:	eb8d                	bnez	a5,7f2 <vprintf+0x6a>
      if(c0 == '%'){
 7c2:	fd442783          	lw	a5,-44(s0)
 7c6:	0007871b          	sext.w	a4,a5
 7ca:	02500793          	li	a5,37
 7ce:	00f71763          	bne	a4,a5,7dc <vprintf+0x54>
        state = '%';
 7d2:	02500793          	li	a5,37
 7d6:	fcf42c23          	sw	a5,-40(s0)
 7da:	a111                	j	bde <vprintf+0x456>
      } else {
        putc(fd, c0);
 7dc:	fd442783          	lw	a5,-44(s0)
 7e0:	0ff7f713          	zext.b	a4,a5
 7e4:	fcc42783          	lw	a5,-52(s0)
 7e8:	85ba                	mv	a1,a4
 7ea:	853e                	mv	a0,a5
 7ec:	dfbff0ef          	jal	5e6 <putc>
 7f0:	a6fd                	j	bde <vprintf+0x456>
      }
    } else if(state == '%'){
 7f2:	fd842783          	lw	a5,-40(s0)
 7f6:	0007871b          	sext.w	a4,a5
 7fa:	02500793          	li	a5,37
 7fe:	3ef71063          	bne	a4,a5,bde <vprintf+0x456>
      c1 = c2 = 0;
 802:	fe042023          	sw	zero,-32(s0)
 806:	fe042783          	lw	a5,-32(s0)
 80a:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 80e:	fd442783          	lw	a5,-44(s0)
 812:	2781                	sext.w	a5,a5
 814:	cb99                	beqz	a5,82a <vprintf+0xa2>
 816:	fdc42783          	lw	a5,-36(s0)
 81a:	0785                	addi	a5,a5,1
 81c:	fc043703          	ld	a4,-64(s0)
 820:	97ba                	add	a5,a5,a4
 822:	0007c783          	lbu	a5,0(a5)
 826:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 82a:	fe442783          	lw	a5,-28(s0)
 82e:	2781                	sext.w	a5,a5
 830:	cb99                	beqz	a5,846 <vprintf+0xbe>
 832:	fdc42783          	lw	a5,-36(s0)
 836:	0789                	addi	a5,a5,2
 838:	fc043703          	ld	a4,-64(s0)
 83c:	97ba                	add	a5,a5,a4
 83e:	0007c783          	lbu	a5,0(a5)
 842:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 846:	fd442783          	lw	a5,-44(s0)
 84a:	0007871b          	sext.w	a4,a5
 84e:	06400793          	li	a5,100
 852:	02f71363          	bne	a4,a5,878 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 856:	fb843783          	ld	a5,-72(s0)
 85a:	00878713          	addi	a4,a5,8
 85e:	fae43c23          	sd	a4,-72(s0)
 862:	439c                	lw	a5,0(a5)
 864:	873e                	mv	a4,a5
 866:	fcc42783          	lw	a5,-52(s0)
 86a:	4685                	li	a3,1
 86c:	4629                	li	a2,10
 86e:	85ba                	mv	a1,a4
 870:	853e                	mv	a0,a5
 872:	da7ff0ef          	jal	618 <printint>
 876:	a695                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 878:	fd442783          	lw	a5,-44(s0)
 87c:	0007871b          	sext.w	a4,a5
 880:	06c00793          	li	a5,108
 884:	04f71063          	bne	a4,a5,8c4 <vprintf+0x13c>
 888:	fe442783          	lw	a5,-28(s0)
 88c:	0007871b          	sext.w	a4,a5
 890:	06400793          	li	a5,100
 894:	02f71863          	bne	a4,a5,8c4 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 898:	fb843783          	ld	a5,-72(s0)
 89c:	00878713          	addi	a4,a5,8
 8a0:	fae43c23          	sd	a4,-72(s0)
 8a4:	639c                	ld	a5,0(a5)
 8a6:	873e                	mv	a4,a5
 8a8:	fcc42783          	lw	a5,-52(s0)
 8ac:	4685                	li	a3,1
 8ae:	4629                	li	a2,10
 8b0:	85ba                	mv	a1,a4
 8b2:	853e                	mv	a0,a5
 8b4:	d65ff0ef          	jal	618 <printint>
        i += 1;
 8b8:	fdc42783          	lw	a5,-36(s0)
 8bc:	2785                	addiw	a5,a5,1
 8be:	fcf42e23          	sw	a5,-36(s0)
 8c2:	ae21                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8c4:	fd442783          	lw	a5,-44(s0)
 8c8:	0007871b          	sext.w	a4,a5
 8cc:	06c00793          	li	a5,108
 8d0:	04f71863          	bne	a4,a5,920 <vprintf+0x198>
 8d4:	fe442783          	lw	a5,-28(s0)
 8d8:	0007871b          	sext.w	a4,a5
 8dc:	06c00793          	li	a5,108
 8e0:	04f71063          	bne	a4,a5,920 <vprintf+0x198>
 8e4:	fe042783          	lw	a5,-32(s0)
 8e8:	0007871b          	sext.w	a4,a5
 8ec:	06400793          	li	a5,100
 8f0:	02f71863          	bne	a4,a5,920 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f4:	fb843783          	ld	a5,-72(s0)
 8f8:	00878713          	addi	a4,a5,8
 8fc:	fae43c23          	sd	a4,-72(s0)
 900:	639c                	ld	a5,0(a5)
 902:	873e                	mv	a4,a5
 904:	fcc42783          	lw	a5,-52(s0)
 908:	4685                	li	a3,1
 90a:	4629                	li	a2,10
 90c:	85ba                	mv	a1,a4
 90e:	853e                	mv	a0,a5
 910:	d09ff0ef          	jal	618 <printint>
        i += 2;
 914:	fdc42783          	lw	a5,-36(s0)
 918:	2789                	addiw	a5,a5,2
 91a:	fcf42e23          	sw	a5,-36(s0)
 91e:	ac75                	j	bda <vprintf+0x452>
      } else if(c0 == 'u'){
 920:	fd442783          	lw	a5,-44(s0)
 924:	0007871b          	sext.w	a4,a5
 928:	07500793          	li	a5,117
 92c:	02f71563          	bne	a4,a5,956 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 930:	fb843783          	ld	a5,-72(s0)
 934:	00878713          	addi	a4,a5,8
 938:	fae43c23          	sd	a4,-72(s0)
 93c:	439c                	lw	a5,0(a5)
 93e:	02079713          	slli	a4,a5,0x20
 942:	9301                	srli	a4,a4,0x20
 944:	fcc42783          	lw	a5,-52(s0)
 948:	4681                	li	a3,0
 94a:	4629                	li	a2,10
 94c:	85ba                	mv	a1,a4
 94e:	853e                	mv	a0,a5
 950:	cc9ff0ef          	jal	618 <printint>
 954:	a459                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 956:	fd442783          	lw	a5,-44(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	06c00793          	li	a5,108
 962:	04f71063          	bne	a4,a5,9a2 <vprintf+0x21a>
 966:	fe442783          	lw	a5,-28(s0)
 96a:	0007871b          	sext.w	a4,a5
 96e:	07500793          	li	a5,117
 972:	02f71863          	bne	a4,a5,9a2 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 976:	fb843783          	ld	a5,-72(s0)
 97a:	00878713          	addi	a4,a5,8
 97e:	fae43c23          	sd	a4,-72(s0)
 982:	639c                	ld	a5,0(a5)
 984:	873e                	mv	a4,a5
 986:	fcc42783          	lw	a5,-52(s0)
 98a:	4681                	li	a3,0
 98c:	4629                	li	a2,10
 98e:	85ba                	mv	a1,a4
 990:	853e                	mv	a0,a5
 992:	c87ff0ef          	jal	618 <printint>
        i += 1;
 996:	fdc42783          	lw	a5,-36(s0)
 99a:	2785                	addiw	a5,a5,1
 99c:	fcf42e23          	sw	a5,-36(s0)
 9a0:	ac2d                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9a2:	fd442783          	lw	a5,-44(s0)
 9a6:	0007871b          	sext.w	a4,a5
 9aa:	06c00793          	li	a5,108
 9ae:	04f71863          	bne	a4,a5,9fe <vprintf+0x276>
 9b2:	fe442783          	lw	a5,-28(s0)
 9b6:	0007871b          	sext.w	a4,a5
 9ba:	06c00793          	li	a5,108
 9be:	04f71063          	bne	a4,a5,9fe <vprintf+0x276>
 9c2:	fe042783          	lw	a5,-32(s0)
 9c6:	0007871b          	sext.w	a4,a5
 9ca:	07500793          	li	a5,117
 9ce:	02f71863          	bne	a4,a5,9fe <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d2:	fb843783          	ld	a5,-72(s0)
 9d6:	00878713          	addi	a4,a5,8
 9da:	fae43c23          	sd	a4,-72(s0)
 9de:	639c                	ld	a5,0(a5)
 9e0:	873e                	mv	a4,a5
 9e2:	fcc42783          	lw	a5,-52(s0)
 9e6:	4681                	li	a3,0
 9e8:	4629                	li	a2,10
 9ea:	85ba                	mv	a1,a4
 9ec:	853e                	mv	a0,a5
 9ee:	c2bff0ef          	jal	618 <printint>
        i += 2;
 9f2:	fdc42783          	lw	a5,-36(s0)
 9f6:	2789                	addiw	a5,a5,2
 9f8:	fcf42e23          	sw	a5,-36(s0)
 9fc:	aaf9                	j	bda <vprintf+0x452>
      } else if(c0 == 'x'){
 9fe:	fd442783          	lw	a5,-44(s0)
 a02:	0007871b          	sext.w	a4,a5
 a06:	07800793          	li	a5,120
 a0a:	02f71563          	bne	a4,a5,a34 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a0e:	fb843783          	ld	a5,-72(s0)
 a12:	00878713          	addi	a4,a5,8
 a16:	fae43c23          	sd	a4,-72(s0)
 a1a:	439c                	lw	a5,0(a5)
 a1c:	02079713          	slli	a4,a5,0x20
 a20:	9301                	srli	a4,a4,0x20
 a22:	fcc42783          	lw	a5,-52(s0)
 a26:	4681                	li	a3,0
 a28:	4641                	li	a2,16
 a2a:	85ba                	mv	a1,a4
 a2c:	853e                	mv	a0,a5
 a2e:	bebff0ef          	jal	618 <printint>
 a32:	a265                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a34:	fd442783          	lw	a5,-44(s0)
 a38:	0007871b          	sext.w	a4,a5
 a3c:	06c00793          	li	a5,108
 a40:	04f71063          	bne	a4,a5,a80 <vprintf+0x2f8>
 a44:	fe442783          	lw	a5,-28(s0)
 a48:	0007871b          	sext.w	a4,a5
 a4c:	07800793          	li	a5,120
 a50:	02f71863          	bne	a4,a5,a80 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a54:	fb843783          	ld	a5,-72(s0)
 a58:	00878713          	addi	a4,a5,8
 a5c:	fae43c23          	sd	a4,-72(s0)
 a60:	639c                	ld	a5,0(a5)
 a62:	873e                	mv	a4,a5
 a64:	fcc42783          	lw	a5,-52(s0)
 a68:	4681                	li	a3,0
 a6a:	4641                	li	a2,16
 a6c:	85ba                	mv	a1,a4
 a6e:	853e                	mv	a0,a5
 a70:	ba9ff0ef          	jal	618 <printint>
        i += 1;
 a74:	fdc42783          	lw	a5,-36(s0)
 a78:	2785                	addiw	a5,a5,1
 a7a:	fcf42e23          	sw	a5,-36(s0)
 a7e:	aab1                	j	bda <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a80:	fd442783          	lw	a5,-44(s0)
 a84:	0007871b          	sext.w	a4,a5
 a88:	06c00793          	li	a5,108
 a8c:	04f71863          	bne	a4,a5,adc <vprintf+0x354>
 a90:	fe442783          	lw	a5,-28(s0)
 a94:	0007871b          	sext.w	a4,a5
 a98:	06c00793          	li	a5,108
 a9c:	04f71063          	bne	a4,a5,adc <vprintf+0x354>
 aa0:	fe042783          	lw	a5,-32(s0)
 aa4:	0007871b          	sext.w	a4,a5
 aa8:	07800793          	li	a5,120
 aac:	02f71863          	bne	a4,a5,adc <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ab0:	fb843783          	ld	a5,-72(s0)
 ab4:	00878713          	addi	a4,a5,8
 ab8:	fae43c23          	sd	a4,-72(s0)
 abc:	639c                	ld	a5,0(a5)
 abe:	873e                	mv	a4,a5
 ac0:	fcc42783          	lw	a5,-52(s0)
 ac4:	4681                	li	a3,0
 ac6:	4641                	li	a2,16
 ac8:	85ba                	mv	a1,a4
 aca:	853e                	mv	a0,a5
 acc:	b4dff0ef          	jal	618 <printint>
        i += 2;
 ad0:	fdc42783          	lw	a5,-36(s0)
 ad4:	2789                	addiw	a5,a5,2
 ad6:	fcf42e23          	sw	a5,-36(s0)
 ada:	a201                	j	bda <vprintf+0x452>
      } else if(c0 == 'p'){
 adc:	fd442783          	lw	a5,-44(s0)
 ae0:	0007871b          	sext.w	a4,a5
 ae4:	07000793          	li	a5,112
 ae8:	02f71063          	bne	a4,a5,b08 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 aec:	fb843783          	ld	a5,-72(s0)
 af0:	00878713          	addi	a4,a5,8
 af4:	fae43c23          	sd	a4,-72(s0)
 af8:	6398                	ld	a4,0(a5)
 afa:	fcc42783          	lw	a5,-52(s0)
 afe:	85ba                	mv	a1,a4
 b00:	853e                	mv	a0,a5
 b02:	c09ff0ef          	jal	70a <printptr>
 b06:	a8d1                	j	bda <vprintf+0x452>
      } else if(c0 == 'c'){
 b08:	fd442783          	lw	a5,-44(s0)
 b0c:	0007871b          	sext.w	a4,a5
 b10:	06300793          	li	a5,99
 b14:	02f71263          	bne	a4,a5,b38 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b18:	fb843783          	ld	a5,-72(s0)
 b1c:	00878713          	addi	a4,a5,8
 b20:	fae43c23          	sd	a4,-72(s0)
 b24:	439c                	lw	a5,0(a5)
 b26:	0ff7f713          	zext.b	a4,a5
 b2a:	fcc42783          	lw	a5,-52(s0)
 b2e:	85ba                	mv	a1,a4
 b30:	853e                	mv	a0,a5
 b32:	ab5ff0ef          	jal	5e6 <putc>
 b36:	a055                	j	bda <vprintf+0x452>
      } else if(c0 == 's'){
 b38:	fd442783          	lw	a5,-44(s0)
 b3c:	0007871b          	sext.w	a4,a5
 b40:	07300793          	li	a5,115
 b44:	04f71a63          	bne	a4,a5,b98 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 b48:	fb843783          	ld	a5,-72(s0)
 b4c:	00878713          	addi	a4,a5,8
 b50:	fae43c23          	sd	a4,-72(s0)
 b54:	639c                	ld	a5,0(a5)
 b56:	fef43423          	sd	a5,-24(s0)
 b5a:	fe843783          	ld	a5,-24(s0)
 b5e:	e79d                	bnez	a5,b8c <vprintf+0x404>
          s = "(null)";
 b60:	00000797          	auipc	a5,0x0
 b64:	42078793          	addi	a5,a5,1056 # f80 <malloc+0x13e>
 b68:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 b6c:	a005                	j	b8c <vprintf+0x404>
          putc(fd, *s);
 b6e:	fe843783          	ld	a5,-24(s0)
 b72:	0007c703          	lbu	a4,0(a5)
 b76:	fcc42783          	lw	a5,-52(s0)
 b7a:	85ba                	mv	a1,a4
 b7c:	853e                	mv	a0,a5
 b7e:	a69ff0ef          	jal	5e6 <putc>
        for(; *s; s++)
 b82:	fe843783          	ld	a5,-24(s0)
 b86:	0785                	addi	a5,a5,1
 b88:	fef43423          	sd	a5,-24(s0)
 b8c:	fe843783          	ld	a5,-24(s0)
 b90:	0007c783          	lbu	a5,0(a5)
 b94:	ffe9                	bnez	a5,b6e <vprintf+0x3e6>
 b96:	a091                	j	bda <vprintf+0x452>
      } else if(c0 == '%'){
 b98:	fd442783          	lw	a5,-44(s0)
 b9c:	0007871b          	sext.w	a4,a5
 ba0:	02500793          	li	a5,37
 ba4:	00f71a63          	bne	a4,a5,bb8 <vprintf+0x430>
        putc(fd, '%');
 ba8:	fcc42783          	lw	a5,-52(s0)
 bac:	02500593          	li	a1,37
 bb0:	853e                	mv	a0,a5
 bb2:	a35ff0ef          	jal	5e6 <putc>
 bb6:	a015                	j	bda <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bb8:	fcc42783          	lw	a5,-52(s0)
 bbc:	02500593          	li	a1,37
 bc0:	853e                	mv	a0,a5
 bc2:	a25ff0ef          	jal	5e6 <putc>
        putc(fd, c0);
 bc6:	fd442783          	lw	a5,-44(s0)
 bca:	0ff7f713          	zext.b	a4,a5
 bce:	fcc42783          	lw	a5,-52(s0)
 bd2:	85ba                	mv	a1,a4
 bd4:	853e                	mv	a0,a5
 bd6:	a11ff0ef          	jal	5e6 <putc>
      }

      state = 0;
 bda:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 bde:	fdc42783          	lw	a5,-36(s0)
 be2:	2785                	addiw	a5,a5,1
 be4:	fcf42e23          	sw	a5,-36(s0)
 be8:	fdc42783          	lw	a5,-36(s0)
 bec:	fc043703          	ld	a4,-64(s0)
 bf0:	97ba                	add	a5,a5,a4
 bf2:	0007c783          	lbu	a5,0(a5)
 bf6:	ba0799e3          	bnez	a5,7a8 <vprintf+0x20>
    }
  }
}
 bfa:	0001                	nop
 bfc:	0001                	nop
 bfe:	60a6                	ld	ra,72(sp)
 c00:	6406                	ld	s0,64(sp)
 c02:	6161                	addi	sp,sp,80
 c04:	8082                	ret

0000000000000c06 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c06:	7159                	addi	sp,sp,-112
 c08:	fc06                	sd	ra,56(sp)
 c0a:	f822                	sd	s0,48(sp)
 c0c:	0080                	addi	s0,sp,64
 c0e:	fcb43823          	sd	a1,-48(s0)
 c12:	e010                	sd	a2,0(s0)
 c14:	e414                	sd	a3,8(s0)
 c16:	e818                	sd	a4,16(s0)
 c18:	ec1c                	sd	a5,24(s0)
 c1a:	03043023          	sd	a6,32(s0)
 c1e:	03143423          	sd	a7,40(s0)
 c22:	87aa                	mv	a5,a0
 c24:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c28:	03040793          	addi	a5,s0,48
 c2c:	fcf43423          	sd	a5,-56(s0)
 c30:	fc843783          	ld	a5,-56(s0)
 c34:	fd078793          	addi	a5,a5,-48
 c38:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c3c:	fe843703          	ld	a4,-24(s0)
 c40:	fdc42783          	lw	a5,-36(s0)
 c44:	863a                	mv	a2,a4
 c46:	fd043583          	ld	a1,-48(s0)
 c4a:	853e                	mv	a0,a5
 c4c:	b3dff0ef          	jal	788 <vprintf>
}
 c50:	0001                	nop
 c52:	70e2                	ld	ra,56(sp)
 c54:	7442                	ld	s0,48(sp)
 c56:	6165                	addi	sp,sp,112
 c58:	8082                	ret

0000000000000c5a <printf>:

void
printf(const char *fmt, ...)
{
 c5a:	7159                	addi	sp,sp,-112
 c5c:	f406                	sd	ra,40(sp)
 c5e:	f022                	sd	s0,32(sp)
 c60:	1800                	addi	s0,sp,48
 c62:	fca43c23          	sd	a0,-40(s0)
 c66:	e40c                	sd	a1,8(s0)
 c68:	e810                	sd	a2,16(s0)
 c6a:	ec14                	sd	a3,24(s0)
 c6c:	f018                	sd	a4,32(s0)
 c6e:	f41c                	sd	a5,40(s0)
 c70:	03043823          	sd	a6,48(s0)
 c74:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c78:	04040793          	addi	a5,s0,64
 c7c:	fcf43823          	sd	a5,-48(s0)
 c80:	fd043783          	ld	a5,-48(s0)
 c84:	fc878793          	addi	a5,a5,-56
 c88:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 c8c:	fe843783          	ld	a5,-24(s0)
 c90:	863e                	mv	a2,a5
 c92:	fd843583          	ld	a1,-40(s0)
 c96:	4505                	li	a0,1
 c98:	af1ff0ef          	jal	788 <vprintf>
}
 c9c:	0001                	nop
 c9e:	70a2                	ld	ra,40(sp)
 ca0:	7402                	ld	s0,32(sp)
 ca2:	6165                	addi	sp,sp,112
 ca4:	8082                	ret

0000000000000ca6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ca6:	7179                	addi	sp,sp,-48
 ca8:	f406                	sd	ra,40(sp)
 caa:	f022                	sd	s0,32(sp)
 cac:	1800                	addi	s0,sp,48
 cae:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 cb2:	fd843783          	ld	a5,-40(s0)
 cb6:	17c1                	addi	a5,a5,-16
 cb8:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cbc:	00000797          	auipc	a5,0x0
 cc0:	37478793          	addi	a5,a5,884 # 1030 <freep>
 cc4:	639c                	ld	a5,0(a5)
 cc6:	fef43423          	sd	a5,-24(s0)
 cca:	a815                	j	cfe <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ccc:	fe843783          	ld	a5,-24(s0)
 cd0:	639c                	ld	a5,0(a5)
 cd2:	fe843703          	ld	a4,-24(s0)
 cd6:	00f76f63          	bltu	a4,a5,cf4 <free+0x4e>
 cda:	fe043703          	ld	a4,-32(s0)
 cde:	fe843783          	ld	a5,-24(s0)
 ce2:	02e7eb63          	bltu	a5,a4,d18 <free+0x72>
 ce6:	fe843783          	ld	a5,-24(s0)
 cea:	639c                	ld	a5,0(a5)
 cec:	fe043703          	ld	a4,-32(s0)
 cf0:	02f76463          	bltu	a4,a5,d18 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cf4:	fe843783          	ld	a5,-24(s0)
 cf8:	639c                	ld	a5,0(a5)
 cfa:	fef43423          	sd	a5,-24(s0)
 cfe:	fe043703          	ld	a4,-32(s0)
 d02:	fe843783          	ld	a5,-24(s0)
 d06:	fce7f3e3          	bgeu	a5,a4,ccc <free+0x26>
 d0a:	fe843783          	ld	a5,-24(s0)
 d0e:	639c                	ld	a5,0(a5)
 d10:	fe043703          	ld	a4,-32(s0)
 d14:	faf77ce3          	bgeu	a4,a5,ccc <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d18:	fe043783          	ld	a5,-32(s0)
 d1c:	479c                	lw	a5,8(a5)
 d1e:	1782                	slli	a5,a5,0x20
 d20:	9381                	srli	a5,a5,0x20
 d22:	0792                	slli	a5,a5,0x4
 d24:	fe043703          	ld	a4,-32(s0)
 d28:	973e                	add	a4,a4,a5
 d2a:	fe843783          	ld	a5,-24(s0)
 d2e:	639c                	ld	a5,0(a5)
 d30:	02f71763          	bne	a4,a5,d5e <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d34:	fe043783          	ld	a5,-32(s0)
 d38:	4798                	lw	a4,8(a5)
 d3a:	fe843783          	ld	a5,-24(s0)
 d3e:	639c                	ld	a5,0(a5)
 d40:	479c                	lw	a5,8(a5)
 d42:	9fb9                	addw	a5,a5,a4
 d44:	0007871b          	sext.w	a4,a5
 d48:	fe043783          	ld	a5,-32(s0)
 d4c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	639c                	ld	a5,0(a5)
 d54:	6398                	ld	a4,0(a5)
 d56:	fe043783          	ld	a5,-32(s0)
 d5a:	e398                	sd	a4,0(a5)
 d5c:	a039                	j	d6a <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	6398                	ld	a4,0(a5)
 d64:	fe043783          	ld	a5,-32(s0)
 d68:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d6a:	fe843783          	ld	a5,-24(s0)
 d6e:	479c                	lw	a5,8(a5)
 d70:	1782                	slli	a5,a5,0x20
 d72:	9381                	srli	a5,a5,0x20
 d74:	0792                	slli	a5,a5,0x4
 d76:	fe843703          	ld	a4,-24(s0)
 d7a:	97ba                	add	a5,a5,a4
 d7c:	fe043703          	ld	a4,-32(s0)
 d80:	02f71563          	bne	a4,a5,daa <free+0x104>
    p->s.size += bp->s.size;
 d84:	fe843783          	ld	a5,-24(s0)
 d88:	4798                	lw	a4,8(a5)
 d8a:	fe043783          	ld	a5,-32(s0)
 d8e:	479c                	lw	a5,8(a5)
 d90:	9fb9                	addw	a5,a5,a4
 d92:	0007871b          	sext.w	a4,a5
 d96:	fe843783          	ld	a5,-24(s0)
 d9a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d9c:	fe043783          	ld	a5,-32(s0)
 da0:	6398                	ld	a4,0(a5)
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	e398                	sd	a4,0(a5)
 da8:	a031                	j	db4 <free+0x10e>
  } else
    p->s.ptr = bp;
 daa:	fe843783          	ld	a5,-24(s0)
 dae:	fe043703          	ld	a4,-32(s0)
 db2:	e398                	sd	a4,0(a5)
  freep = p;
 db4:	00000797          	auipc	a5,0x0
 db8:	27c78793          	addi	a5,a5,636 # 1030 <freep>
 dbc:	fe843703          	ld	a4,-24(s0)
 dc0:	e398                	sd	a4,0(a5)
}
 dc2:	0001                	nop
 dc4:	70a2                	ld	ra,40(sp)
 dc6:	7402                	ld	s0,32(sp)
 dc8:	6145                	addi	sp,sp,48
 dca:	8082                	ret

0000000000000dcc <morecore>:

static Header*
morecore(uint nu)
{
 dcc:	7179                	addi	sp,sp,-48
 dce:	f406                	sd	ra,40(sp)
 dd0:	f022                	sd	s0,32(sp)
 dd2:	1800                	addi	s0,sp,48
 dd4:	87aa                	mv	a5,a0
 dd6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 dda:	fdc42783          	lw	a5,-36(s0)
 dde:	0007871b          	sext.w	a4,a5
 de2:	6785                	lui	a5,0x1
 de4:	00f77563          	bgeu	a4,a5,dee <morecore+0x22>
    nu = 4096;
 de8:	6785                	lui	a5,0x1
 dea:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 dee:	fdc42783          	lw	a5,-36(s0)
 df2:	0047979b          	slliw	a5,a5,0x4
 df6:	2781                	sext.w	a5,a5
 df8:	853e                	mv	a0,a5
 dfa:	ee8ff0ef          	jal	4e2 <sbrk>
 dfe:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e02:	fe843703          	ld	a4,-24(s0)
 e06:	57fd                	li	a5,-1
 e08:	00f71463          	bne	a4,a5,e10 <morecore+0x44>
    return 0;
 e0c:	4781                	li	a5,0
 e0e:	a02d                	j	e38 <morecore+0x6c>
  hp = (Header*)p;
 e10:	fe843783          	ld	a5,-24(s0)
 e14:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e18:	fe043783          	ld	a5,-32(s0)
 e1c:	fdc42703          	lw	a4,-36(s0)
 e20:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e22:	fe043783          	ld	a5,-32(s0)
 e26:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 e28:	853e                	mv	a0,a5
 e2a:	e7dff0ef          	jal	ca6 <free>
  return freep;
 e2e:	00000797          	auipc	a5,0x0
 e32:	20278793          	addi	a5,a5,514 # 1030 <freep>
 e36:	639c                	ld	a5,0(a5)
}
 e38:	853e                	mv	a0,a5
 e3a:	70a2                	ld	ra,40(sp)
 e3c:	7402                	ld	s0,32(sp)
 e3e:	6145                	addi	sp,sp,48
 e40:	8082                	ret

0000000000000e42 <malloc>:

void*
malloc(uint nbytes)
{
 e42:	7139                	addi	sp,sp,-64
 e44:	fc06                	sd	ra,56(sp)
 e46:	f822                	sd	s0,48(sp)
 e48:	0080                	addi	s0,sp,64
 e4a:	87aa                	mv	a5,a0
 e4c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e50:	fcc46783          	lwu	a5,-52(s0)
 e54:	07bd                	addi	a5,a5,15
 e56:	8391                	srli	a5,a5,0x4
 e58:	2781                	sext.w	a5,a5
 e5a:	2785                	addiw	a5,a5,1
 e5c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e60:	00000797          	auipc	a5,0x0
 e64:	1d078793          	addi	a5,a5,464 # 1030 <freep>
 e68:	639c                	ld	a5,0(a5)
 e6a:	fef43023          	sd	a5,-32(s0)
 e6e:	fe043783          	ld	a5,-32(s0)
 e72:	ef95                	bnez	a5,eae <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e74:	00000797          	auipc	a5,0x0
 e78:	1ac78793          	addi	a5,a5,428 # 1020 <base>
 e7c:	fef43023          	sd	a5,-32(s0)
 e80:	00000797          	auipc	a5,0x0
 e84:	1b078793          	addi	a5,a5,432 # 1030 <freep>
 e88:	fe043703          	ld	a4,-32(s0)
 e8c:	e398                	sd	a4,0(a5)
 e8e:	00000797          	auipc	a5,0x0
 e92:	1a278793          	addi	a5,a5,418 # 1030 <freep>
 e96:	6398                	ld	a4,0(a5)
 e98:	00000797          	auipc	a5,0x0
 e9c:	18878793          	addi	a5,a5,392 # 1020 <base>
 ea0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ea2:	00000797          	auipc	a5,0x0
 ea6:	17e78793          	addi	a5,a5,382 # 1020 <base>
 eaa:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eae:	fe043783          	ld	a5,-32(s0)
 eb2:	639c                	ld	a5,0(a5)
 eb4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 eb8:	fe843783          	ld	a5,-24(s0)
 ebc:	479c                	lw	a5,8(a5)
 ebe:	fdc42703          	lw	a4,-36(s0)
 ec2:	2701                	sext.w	a4,a4
 ec4:	06e7e763          	bltu	a5,a4,f32 <malloc+0xf0>
      if(p->s.size == nunits)
 ec8:	fe843783          	ld	a5,-24(s0)
 ecc:	479c                	lw	a5,8(a5)
 ece:	fdc42703          	lw	a4,-36(s0)
 ed2:	2701                	sext.w	a4,a4
 ed4:	00f71963          	bne	a4,a5,ee6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ed8:	fe843783          	ld	a5,-24(s0)
 edc:	6398                	ld	a4,0(a5)
 ede:	fe043783          	ld	a5,-32(s0)
 ee2:	e398                	sd	a4,0(a5)
 ee4:	a825                	j	f1c <malloc+0xda>
      else {
        p->s.size -= nunits;
 ee6:	fe843783          	ld	a5,-24(s0)
 eea:	479c                	lw	a5,8(a5)
 eec:	fdc42703          	lw	a4,-36(s0)
 ef0:	9f99                	subw	a5,a5,a4
 ef2:	0007871b          	sext.w	a4,a5
 ef6:	fe843783          	ld	a5,-24(s0)
 efa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 efc:	fe843783          	ld	a5,-24(s0)
 f00:	479c                	lw	a5,8(a5)
 f02:	1782                	slli	a5,a5,0x20
 f04:	9381                	srli	a5,a5,0x20
 f06:	0792                	slli	a5,a5,0x4
 f08:	fe843703          	ld	a4,-24(s0)
 f0c:	97ba                	add	a5,a5,a4
 f0e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f12:	fe843783          	ld	a5,-24(s0)
 f16:	fdc42703          	lw	a4,-36(s0)
 f1a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f1c:	00000797          	auipc	a5,0x0
 f20:	11478793          	addi	a5,a5,276 # 1030 <freep>
 f24:	fe043703          	ld	a4,-32(s0)
 f28:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f2a:	fe843783          	ld	a5,-24(s0)
 f2e:	07c1                	addi	a5,a5,16
 f30:	a081                	j	f70 <malloc+0x12e>
    }
    if(p == freep)
 f32:	00000797          	auipc	a5,0x0
 f36:	0fe78793          	addi	a5,a5,254 # 1030 <freep>
 f3a:	639c                	ld	a5,0(a5)
 f3c:	fe843703          	ld	a4,-24(s0)
 f40:	00f71e63          	bne	a4,a5,f5c <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 f44:	fdc42783          	lw	a5,-36(s0)
 f48:	853e                	mv	a0,a5
 f4a:	e83ff0ef          	jal	dcc <morecore>
 f4e:	fea43423          	sd	a0,-24(s0)
 f52:	fe843783          	ld	a5,-24(s0)
 f56:	e399                	bnez	a5,f5c <malloc+0x11a>
        return 0;
 f58:	4781                	li	a5,0
 f5a:	a819                	j	f70 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f5c:	fe843783          	ld	a5,-24(s0)
 f60:	fef43023          	sd	a5,-32(s0)
 f64:	fe843783          	ld	a5,-24(s0)
 f68:	639c                	ld	a5,0(a5)
 f6a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f6e:	b7a9                	j	eb8 <malloc+0x76>
  }
}
 f70:	853e                	mv	a0,a5
 f72:	70e2                	ld	ra,56(sp)
 f74:	7442                	ld	s0,48(sp)
 f76:	6121                	addi	sp,sp,64
 f78:	8082                	ret
