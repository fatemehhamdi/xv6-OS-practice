
user/_top:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main() {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    printf("PID\tCommand\t\t Size of Process Memory\n");
   8:	00001517          	auipc	a0,0x1
   c:	f7850513          	addi	a0,a0,-136 # f80 <malloc+0x146>
  10:	443000ef          	jal	c52 <printf>
    top();
  14:	5c2000ef          	jal	5d6 <top>
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

00000000000005de <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5de:	1101                	addi	sp,sp,-32
 5e0:	ec06                	sd	ra,24(sp)
 5e2:	e822                	sd	s0,16(sp)
 5e4:	1000                	addi	s0,sp,32
 5e6:	87aa                	mv	a5,a0
 5e8:	872e                	mv	a4,a1
 5ea:	fef42623          	sw	a5,-20(s0)
 5ee:	87ba                	mv	a5,a4
 5f0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5f4:	feb40713          	addi	a4,s0,-21
 5f8:	fec42783          	lw	a5,-20(s0)
 5fc:	4605                	li	a2,1
 5fe:	85ba                	mv	a1,a4
 600:	853e                	mv	a0,a5
 602:	f55ff0ef          	jal	556 <write>
}
 606:	0001                	nop
 608:	60e2                	ld	ra,24(sp)
 60a:	6442                	ld	s0,16(sp)
 60c:	6105                	addi	sp,sp,32
 60e:	8082                	ret

0000000000000610 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 610:	711d                	addi	sp,sp,-96
 612:	ec86                	sd	ra,88(sp)
 614:	e8a2                	sd	s0,80(sp)
 616:	1080                	addi	s0,sp,96
 618:	87aa                	mv	a5,a0
 61a:	fab43823          	sd	a1,-80(s0)
 61e:	8736                	mv	a4,a3
 620:	faf42e23          	sw	a5,-68(s0)
 624:	87b2                	mv	a5,a2
 626:	faf42c23          	sw	a5,-72(s0)
 62a:	87ba                	mv	a5,a4
 62c:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 630:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 634:	fac42783          	lw	a5,-84(s0)
 638:	2781                	sext.w	a5,a5
 63a:	cf99                	beqz	a5,658 <printint+0x48>
 63c:	fb043783          	ld	a5,-80(s0)
 640:	0007dc63          	bgez	a5,658 <printint+0x48>
    neg = 1;
 644:	4785                	li	a5,1
 646:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 64a:	fb043783          	ld	a5,-80(s0)
 64e:	40f007b3          	neg	a5,a5
 652:	fef43023          	sd	a5,-32(s0)
 656:	a029                	j	660 <printint+0x50>
  } else {
    x = xx;
 658:	fb043783          	ld	a5,-80(s0)
 65c:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 660:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 664:	fb842783          	lw	a5,-72(s0)
 668:	fe043703          	ld	a4,-32(s0)
 66c:	02f77733          	remu	a4,a4,a5
 670:	fec42783          	lw	a5,-20(s0)
 674:	0017869b          	addiw	a3,a5,1
 678:	fed42623          	sw	a3,-20(s0)
 67c:	00001697          	auipc	a3,0x1
 680:	98468693          	addi	a3,a3,-1660 # 1000 <digits>
 684:	9736                	add	a4,a4,a3
 686:	00074703          	lbu	a4,0(a4)
 68a:	17c1                	addi	a5,a5,-16
 68c:	97a2                	add	a5,a5,s0
 68e:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 692:	fb842783          	lw	a5,-72(s0)
 696:	fe043703          	ld	a4,-32(s0)
 69a:	02f757b3          	divu	a5,a4,a5
 69e:	fef43023          	sd	a5,-32(s0)
 6a2:	fe043783          	ld	a5,-32(s0)
 6a6:	ffdd                	bnez	a5,664 <printint+0x54>
  if(neg)
 6a8:	fe842783          	lw	a5,-24(s0)
 6ac:	2781                	sext.w	a5,a5
 6ae:	cb95                	beqz	a5,6e2 <printint+0xd2>
    buf[i++] = '-';
 6b0:	fec42783          	lw	a5,-20(s0)
 6b4:	0017871b          	addiw	a4,a5,1
 6b8:	fee42623          	sw	a4,-20(s0)
 6bc:	17c1                	addi	a5,a5,-16
 6be:	97a2                	add	a5,a5,s0
 6c0:	02d00713          	li	a4,45
 6c4:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 6c8:	a829                	j	6e2 <printint+0xd2>
    putc(fd, buf[i]);
 6ca:	fec42783          	lw	a5,-20(s0)
 6ce:	17c1                	addi	a5,a5,-16
 6d0:	97a2                	add	a5,a5,s0
 6d2:	fd87c703          	lbu	a4,-40(a5)
 6d6:	fbc42783          	lw	a5,-68(s0)
 6da:	85ba                	mv	a1,a4
 6dc:	853e                	mv	a0,a5
 6de:	f01ff0ef          	jal	5de <putc>
  while(--i >= 0)
 6e2:	fec42783          	lw	a5,-20(s0)
 6e6:	37fd                	addiw	a5,a5,-1
 6e8:	fef42623          	sw	a5,-20(s0)
 6ec:	fec42783          	lw	a5,-20(s0)
 6f0:	2781                	sext.w	a5,a5
 6f2:	fc07dce3          	bgez	a5,6ca <printint+0xba>
}
 6f6:	0001                	nop
 6f8:	0001                	nop
 6fa:	60e6                	ld	ra,88(sp)
 6fc:	6446                	ld	s0,80(sp)
 6fe:	6125                	addi	sp,sp,96
 700:	8082                	ret

0000000000000702 <printptr>:

static void
printptr(int fd, uint64 x) {
 702:	7179                	addi	sp,sp,-48
 704:	f406                	sd	ra,40(sp)
 706:	f022                	sd	s0,32(sp)
 708:	1800                	addi	s0,sp,48
 70a:	87aa                	mv	a5,a0
 70c:	fcb43823          	sd	a1,-48(s0)
 710:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 714:	fdc42783          	lw	a5,-36(s0)
 718:	03000593          	li	a1,48
 71c:	853e                	mv	a0,a5
 71e:	ec1ff0ef          	jal	5de <putc>
  putc(fd, 'x');
 722:	fdc42783          	lw	a5,-36(s0)
 726:	07800593          	li	a1,120
 72a:	853e                	mv	a0,a5
 72c:	eb3ff0ef          	jal	5de <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 730:	fe042623          	sw	zero,-20(s0)
 734:	a81d                	j	76a <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 736:	fd043783          	ld	a5,-48(s0)
 73a:	93f1                	srli	a5,a5,0x3c
 73c:	00001717          	auipc	a4,0x1
 740:	8c470713          	addi	a4,a4,-1852 # 1000 <digits>
 744:	97ba                	add	a5,a5,a4
 746:	0007c703          	lbu	a4,0(a5)
 74a:	fdc42783          	lw	a5,-36(s0)
 74e:	85ba                	mv	a1,a4
 750:	853e                	mv	a0,a5
 752:	e8dff0ef          	jal	5de <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 756:	fec42783          	lw	a5,-20(s0)
 75a:	2785                	addiw	a5,a5,1
 75c:	fef42623          	sw	a5,-20(s0)
 760:	fd043783          	ld	a5,-48(s0)
 764:	0792                	slli	a5,a5,0x4
 766:	fcf43823          	sd	a5,-48(s0)
 76a:	fec42703          	lw	a4,-20(s0)
 76e:	47bd                	li	a5,15
 770:	fce7f3e3          	bgeu	a5,a4,736 <printptr+0x34>
}
 774:	0001                	nop
 776:	0001                	nop
 778:	70a2                	ld	ra,40(sp)
 77a:	7402                	ld	s0,32(sp)
 77c:	6145                	addi	sp,sp,48
 77e:	8082                	ret

0000000000000780 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 780:	715d                	addi	sp,sp,-80
 782:	e486                	sd	ra,72(sp)
 784:	e0a2                	sd	s0,64(sp)
 786:	0880                	addi	s0,sp,80
 788:	87aa                	mv	a5,a0
 78a:	fcb43023          	sd	a1,-64(s0)
 78e:	fac43c23          	sd	a2,-72(s0)
 792:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 796:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 79a:	fc042e23          	sw	zero,-36(s0)
 79e:	a189                	j	be0 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 7a0:	fdc42783          	lw	a5,-36(s0)
 7a4:	fc043703          	ld	a4,-64(s0)
 7a8:	97ba                	add	a5,a5,a4
 7aa:	0007c783          	lbu	a5,0(a5)
 7ae:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 7b2:	fd842783          	lw	a5,-40(s0)
 7b6:	2781                	sext.w	a5,a5
 7b8:	eb8d                	bnez	a5,7ea <vprintf+0x6a>
      if(c0 == '%'){
 7ba:	fd442783          	lw	a5,-44(s0)
 7be:	0007871b          	sext.w	a4,a5
 7c2:	02500793          	li	a5,37
 7c6:	00f71763          	bne	a4,a5,7d4 <vprintf+0x54>
        state = '%';
 7ca:	02500793          	li	a5,37
 7ce:	fcf42c23          	sw	a5,-40(s0)
 7d2:	a111                	j	bd6 <vprintf+0x456>
      } else {
        putc(fd, c0);
 7d4:	fd442783          	lw	a5,-44(s0)
 7d8:	0ff7f713          	zext.b	a4,a5
 7dc:	fcc42783          	lw	a5,-52(s0)
 7e0:	85ba                	mv	a1,a4
 7e2:	853e                	mv	a0,a5
 7e4:	dfbff0ef          	jal	5de <putc>
 7e8:	a6fd                	j	bd6 <vprintf+0x456>
      }
    } else if(state == '%'){
 7ea:	fd842783          	lw	a5,-40(s0)
 7ee:	0007871b          	sext.w	a4,a5
 7f2:	02500793          	li	a5,37
 7f6:	3ef71063          	bne	a4,a5,bd6 <vprintf+0x456>
      c1 = c2 = 0;
 7fa:	fe042023          	sw	zero,-32(s0)
 7fe:	fe042783          	lw	a5,-32(s0)
 802:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 806:	fd442783          	lw	a5,-44(s0)
 80a:	2781                	sext.w	a5,a5
 80c:	cb99                	beqz	a5,822 <vprintf+0xa2>
 80e:	fdc42783          	lw	a5,-36(s0)
 812:	0785                	addi	a5,a5,1
 814:	fc043703          	ld	a4,-64(s0)
 818:	97ba                	add	a5,a5,a4
 81a:	0007c783          	lbu	a5,0(a5)
 81e:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 822:	fe442783          	lw	a5,-28(s0)
 826:	2781                	sext.w	a5,a5
 828:	cb99                	beqz	a5,83e <vprintf+0xbe>
 82a:	fdc42783          	lw	a5,-36(s0)
 82e:	0789                	addi	a5,a5,2
 830:	fc043703          	ld	a4,-64(s0)
 834:	97ba                	add	a5,a5,a4
 836:	0007c783          	lbu	a5,0(a5)
 83a:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 83e:	fd442783          	lw	a5,-44(s0)
 842:	0007871b          	sext.w	a4,a5
 846:	06400793          	li	a5,100
 84a:	02f71363          	bne	a4,a5,870 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 84e:	fb843783          	ld	a5,-72(s0)
 852:	00878713          	addi	a4,a5,8
 856:	fae43c23          	sd	a4,-72(s0)
 85a:	439c                	lw	a5,0(a5)
 85c:	873e                	mv	a4,a5
 85e:	fcc42783          	lw	a5,-52(s0)
 862:	4685                	li	a3,1
 864:	4629                	li	a2,10
 866:	85ba                	mv	a1,a4
 868:	853e                	mv	a0,a5
 86a:	da7ff0ef          	jal	610 <printint>
 86e:	a695                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 870:	fd442783          	lw	a5,-44(s0)
 874:	0007871b          	sext.w	a4,a5
 878:	06c00793          	li	a5,108
 87c:	04f71063          	bne	a4,a5,8bc <vprintf+0x13c>
 880:	fe442783          	lw	a5,-28(s0)
 884:	0007871b          	sext.w	a4,a5
 888:	06400793          	li	a5,100
 88c:	02f71863          	bne	a4,a5,8bc <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 890:	fb843783          	ld	a5,-72(s0)
 894:	00878713          	addi	a4,a5,8
 898:	fae43c23          	sd	a4,-72(s0)
 89c:	639c                	ld	a5,0(a5)
 89e:	873e                	mv	a4,a5
 8a0:	fcc42783          	lw	a5,-52(s0)
 8a4:	4685                	li	a3,1
 8a6:	4629                	li	a2,10
 8a8:	85ba                	mv	a1,a4
 8aa:	853e                	mv	a0,a5
 8ac:	d65ff0ef          	jal	610 <printint>
        i += 1;
 8b0:	fdc42783          	lw	a5,-36(s0)
 8b4:	2785                	addiw	a5,a5,1
 8b6:	fcf42e23          	sw	a5,-36(s0)
 8ba:	ae21                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8bc:	fd442783          	lw	a5,-44(s0)
 8c0:	0007871b          	sext.w	a4,a5
 8c4:	06c00793          	li	a5,108
 8c8:	04f71863          	bne	a4,a5,918 <vprintf+0x198>
 8cc:	fe442783          	lw	a5,-28(s0)
 8d0:	0007871b          	sext.w	a4,a5
 8d4:	06c00793          	li	a5,108
 8d8:	04f71063          	bne	a4,a5,918 <vprintf+0x198>
 8dc:	fe042783          	lw	a5,-32(s0)
 8e0:	0007871b          	sext.w	a4,a5
 8e4:	06400793          	li	a5,100
 8e8:	02f71863          	bne	a4,a5,918 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ec:	fb843783          	ld	a5,-72(s0)
 8f0:	00878713          	addi	a4,a5,8
 8f4:	fae43c23          	sd	a4,-72(s0)
 8f8:	639c                	ld	a5,0(a5)
 8fa:	873e                	mv	a4,a5
 8fc:	fcc42783          	lw	a5,-52(s0)
 900:	4685                	li	a3,1
 902:	4629                	li	a2,10
 904:	85ba                	mv	a1,a4
 906:	853e                	mv	a0,a5
 908:	d09ff0ef          	jal	610 <printint>
        i += 2;
 90c:	fdc42783          	lw	a5,-36(s0)
 910:	2789                	addiw	a5,a5,2
 912:	fcf42e23          	sw	a5,-36(s0)
 916:	ac75                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'u'){
 918:	fd442783          	lw	a5,-44(s0)
 91c:	0007871b          	sext.w	a4,a5
 920:	07500793          	li	a5,117
 924:	02f71563          	bne	a4,a5,94e <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 928:	fb843783          	ld	a5,-72(s0)
 92c:	00878713          	addi	a4,a5,8
 930:	fae43c23          	sd	a4,-72(s0)
 934:	439c                	lw	a5,0(a5)
 936:	02079713          	slli	a4,a5,0x20
 93a:	9301                	srli	a4,a4,0x20
 93c:	fcc42783          	lw	a5,-52(s0)
 940:	4681                	li	a3,0
 942:	4629                	li	a2,10
 944:	85ba                	mv	a1,a4
 946:	853e                	mv	a0,a5
 948:	cc9ff0ef          	jal	610 <printint>
 94c:	a459                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 94e:	fd442783          	lw	a5,-44(s0)
 952:	0007871b          	sext.w	a4,a5
 956:	06c00793          	li	a5,108
 95a:	04f71063          	bne	a4,a5,99a <vprintf+0x21a>
 95e:	fe442783          	lw	a5,-28(s0)
 962:	0007871b          	sext.w	a4,a5
 966:	07500793          	li	a5,117
 96a:	02f71863          	bne	a4,a5,99a <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 96e:	fb843783          	ld	a5,-72(s0)
 972:	00878713          	addi	a4,a5,8
 976:	fae43c23          	sd	a4,-72(s0)
 97a:	639c                	ld	a5,0(a5)
 97c:	873e                	mv	a4,a5
 97e:	fcc42783          	lw	a5,-52(s0)
 982:	4681                	li	a3,0
 984:	4629                	li	a2,10
 986:	85ba                	mv	a1,a4
 988:	853e                	mv	a0,a5
 98a:	c87ff0ef          	jal	610 <printint>
        i += 1;
 98e:	fdc42783          	lw	a5,-36(s0)
 992:	2785                	addiw	a5,a5,1
 994:	fcf42e23          	sw	a5,-36(s0)
 998:	ac2d                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 99a:	fd442783          	lw	a5,-44(s0)
 99e:	0007871b          	sext.w	a4,a5
 9a2:	06c00793          	li	a5,108
 9a6:	04f71863          	bne	a4,a5,9f6 <vprintf+0x276>
 9aa:	fe442783          	lw	a5,-28(s0)
 9ae:	0007871b          	sext.w	a4,a5
 9b2:	06c00793          	li	a5,108
 9b6:	04f71063          	bne	a4,a5,9f6 <vprintf+0x276>
 9ba:	fe042783          	lw	a5,-32(s0)
 9be:	0007871b          	sext.w	a4,a5
 9c2:	07500793          	li	a5,117
 9c6:	02f71863          	bne	a4,a5,9f6 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ca:	fb843783          	ld	a5,-72(s0)
 9ce:	00878713          	addi	a4,a5,8
 9d2:	fae43c23          	sd	a4,-72(s0)
 9d6:	639c                	ld	a5,0(a5)
 9d8:	873e                	mv	a4,a5
 9da:	fcc42783          	lw	a5,-52(s0)
 9de:	4681                	li	a3,0
 9e0:	4629                	li	a2,10
 9e2:	85ba                	mv	a1,a4
 9e4:	853e                	mv	a0,a5
 9e6:	c2bff0ef          	jal	610 <printint>
        i += 2;
 9ea:	fdc42783          	lw	a5,-36(s0)
 9ee:	2789                	addiw	a5,a5,2
 9f0:	fcf42e23          	sw	a5,-36(s0)
 9f4:	aaf9                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'x'){
 9f6:	fd442783          	lw	a5,-44(s0)
 9fa:	0007871b          	sext.w	a4,a5
 9fe:	07800793          	li	a5,120
 a02:	02f71563          	bne	a4,a5,a2c <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a06:	fb843783          	ld	a5,-72(s0)
 a0a:	00878713          	addi	a4,a5,8
 a0e:	fae43c23          	sd	a4,-72(s0)
 a12:	439c                	lw	a5,0(a5)
 a14:	02079713          	slli	a4,a5,0x20
 a18:	9301                	srli	a4,a4,0x20
 a1a:	fcc42783          	lw	a5,-52(s0)
 a1e:	4681                	li	a3,0
 a20:	4641                	li	a2,16
 a22:	85ba                	mv	a1,a4
 a24:	853e                	mv	a0,a5
 a26:	bebff0ef          	jal	610 <printint>
 a2a:	a265                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a2c:	fd442783          	lw	a5,-44(s0)
 a30:	0007871b          	sext.w	a4,a5
 a34:	06c00793          	li	a5,108
 a38:	04f71063          	bne	a4,a5,a78 <vprintf+0x2f8>
 a3c:	fe442783          	lw	a5,-28(s0)
 a40:	0007871b          	sext.w	a4,a5
 a44:	07800793          	li	a5,120
 a48:	02f71863          	bne	a4,a5,a78 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a4c:	fb843783          	ld	a5,-72(s0)
 a50:	00878713          	addi	a4,a5,8
 a54:	fae43c23          	sd	a4,-72(s0)
 a58:	639c                	ld	a5,0(a5)
 a5a:	873e                	mv	a4,a5
 a5c:	fcc42783          	lw	a5,-52(s0)
 a60:	4681                	li	a3,0
 a62:	4641                	li	a2,16
 a64:	85ba                	mv	a1,a4
 a66:	853e                	mv	a0,a5
 a68:	ba9ff0ef          	jal	610 <printint>
        i += 1;
 a6c:	fdc42783          	lw	a5,-36(s0)
 a70:	2785                	addiw	a5,a5,1
 a72:	fcf42e23          	sw	a5,-36(s0)
 a76:	aab1                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a78:	fd442783          	lw	a5,-44(s0)
 a7c:	0007871b          	sext.w	a4,a5
 a80:	06c00793          	li	a5,108
 a84:	04f71863          	bne	a4,a5,ad4 <vprintf+0x354>
 a88:	fe442783          	lw	a5,-28(s0)
 a8c:	0007871b          	sext.w	a4,a5
 a90:	06c00793          	li	a5,108
 a94:	04f71063          	bne	a4,a5,ad4 <vprintf+0x354>
 a98:	fe042783          	lw	a5,-32(s0)
 a9c:	0007871b          	sext.w	a4,a5
 aa0:	07800793          	li	a5,120
 aa4:	02f71863          	bne	a4,a5,ad4 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 aa8:	fb843783          	ld	a5,-72(s0)
 aac:	00878713          	addi	a4,a5,8
 ab0:	fae43c23          	sd	a4,-72(s0)
 ab4:	639c                	ld	a5,0(a5)
 ab6:	873e                	mv	a4,a5
 ab8:	fcc42783          	lw	a5,-52(s0)
 abc:	4681                	li	a3,0
 abe:	4641                	li	a2,16
 ac0:	85ba                	mv	a1,a4
 ac2:	853e                	mv	a0,a5
 ac4:	b4dff0ef          	jal	610 <printint>
        i += 2;
 ac8:	fdc42783          	lw	a5,-36(s0)
 acc:	2789                	addiw	a5,a5,2
 ace:	fcf42e23          	sw	a5,-36(s0)
 ad2:	a201                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'p'){
 ad4:	fd442783          	lw	a5,-44(s0)
 ad8:	0007871b          	sext.w	a4,a5
 adc:	07000793          	li	a5,112
 ae0:	02f71063          	bne	a4,a5,b00 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 ae4:	fb843783          	ld	a5,-72(s0)
 ae8:	00878713          	addi	a4,a5,8
 aec:	fae43c23          	sd	a4,-72(s0)
 af0:	6398                	ld	a4,0(a5)
 af2:	fcc42783          	lw	a5,-52(s0)
 af6:	85ba                	mv	a1,a4
 af8:	853e                	mv	a0,a5
 afa:	c09ff0ef          	jal	702 <printptr>
 afe:	a8d1                	j	bd2 <vprintf+0x452>
      } else if(c0 == 'c'){
 b00:	fd442783          	lw	a5,-44(s0)
 b04:	0007871b          	sext.w	a4,a5
 b08:	06300793          	li	a5,99
 b0c:	02f71263          	bne	a4,a5,b30 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b10:	fb843783          	ld	a5,-72(s0)
 b14:	00878713          	addi	a4,a5,8
 b18:	fae43c23          	sd	a4,-72(s0)
 b1c:	439c                	lw	a5,0(a5)
 b1e:	0ff7f713          	zext.b	a4,a5
 b22:	fcc42783          	lw	a5,-52(s0)
 b26:	85ba                	mv	a1,a4
 b28:	853e                	mv	a0,a5
 b2a:	ab5ff0ef          	jal	5de <putc>
 b2e:	a055                	j	bd2 <vprintf+0x452>
      } else if(c0 == 's'){
 b30:	fd442783          	lw	a5,-44(s0)
 b34:	0007871b          	sext.w	a4,a5
 b38:	07300793          	li	a5,115
 b3c:	04f71a63          	bne	a4,a5,b90 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 b40:	fb843783          	ld	a5,-72(s0)
 b44:	00878713          	addi	a4,a5,8
 b48:	fae43c23          	sd	a4,-72(s0)
 b4c:	639c                	ld	a5,0(a5)
 b4e:	fef43423          	sd	a5,-24(s0)
 b52:	fe843783          	ld	a5,-24(s0)
 b56:	e79d                	bnez	a5,b84 <vprintf+0x404>
          s = "(null)";
 b58:	00000797          	auipc	a5,0x0
 b5c:	45078793          	addi	a5,a5,1104 # fa8 <malloc+0x16e>
 b60:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 b64:	a005                	j	b84 <vprintf+0x404>
          putc(fd, *s);
 b66:	fe843783          	ld	a5,-24(s0)
 b6a:	0007c703          	lbu	a4,0(a5)
 b6e:	fcc42783          	lw	a5,-52(s0)
 b72:	85ba                	mv	a1,a4
 b74:	853e                	mv	a0,a5
 b76:	a69ff0ef          	jal	5de <putc>
        for(; *s; s++)
 b7a:	fe843783          	ld	a5,-24(s0)
 b7e:	0785                	addi	a5,a5,1
 b80:	fef43423          	sd	a5,-24(s0)
 b84:	fe843783          	ld	a5,-24(s0)
 b88:	0007c783          	lbu	a5,0(a5)
 b8c:	ffe9                	bnez	a5,b66 <vprintf+0x3e6>
 b8e:	a091                	j	bd2 <vprintf+0x452>
      } else if(c0 == '%'){
 b90:	fd442783          	lw	a5,-44(s0)
 b94:	0007871b          	sext.w	a4,a5
 b98:	02500793          	li	a5,37
 b9c:	00f71a63          	bne	a4,a5,bb0 <vprintf+0x430>
        putc(fd, '%');
 ba0:	fcc42783          	lw	a5,-52(s0)
 ba4:	02500593          	li	a1,37
 ba8:	853e                	mv	a0,a5
 baa:	a35ff0ef          	jal	5de <putc>
 bae:	a015                	j	bd2 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bb0:	fcc42783          	lw	a5,-52(s0)
 bb4:	02500593          	li	a1,37
 bb8:	853e                	mv	a0,a5
 bba:	a25ff0ef          	jal	5de <putc>
        putc(fd, c0);
 bbe:	fd442783          	lw	a5,-44(s0)
 bc2:	0ff7f713          	zext.b	a4,a5
 bc6:	fcc42783          	lw	a5,-52(s0)
 bca:	85ba                	mv	a1,a4
 bcc:	853e                	mv	a0,a5
 bce:	a11ff0ef          	jal	5de <putc>
      }

      state = 0;
 bd2:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 bd6:	fdc42783          	lw	a5,-36(s0)
 bda:	2785                	addiw	a5,a5,1
 bdc:	fcf42e23          	sw	a5,-36(s0)
 be0:	fdc42783          	lw	a5,-36(s0)
 be4:	fc043703          	ld	a4,-64(s0)
 be8:	97ba                	add	a5,a5,a4
 bea:	0007c783          	lbu	a5,0(a5)
 bee:	ba0799e3          	bnez	a5,7a0 <vprintf+0x20>
    }
  }
}
 bf2:	0001                	nop
 bf4:	0001                	nop
 bf6:	60a6                	ld	ra,72(sp)
 bf8:	6406                	ld	s0,64(sp)
 bfa:	6161                	addi	sp,sp,80
 bfc:	8082                	ret

0000000000000bfe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bfe:	7159                	addi	sp,sp,-112
 c00:	fc06                	sd	ra,56(sp)
 c02:	f822                	sd	s0,48(sp)
 c04:	0080                	addi	s0,sp,64
 c06:	fcb43823          	sd	a1,-48(s0)
 c0a:	e010                	sd	a2,0(s0)
 c0c:	e414                	sd	a3,8(s0)
 c0e:	e818                	sd	a4,16(s0)
 c10:	ec1c                	sd	a5,24(s0)
 c12:	03043023          	sd	a6,32(s0)
 c16:	03143423          	sd	a7,40(s0)
 c1a:	87aa                	mv	a5,a0
 c1c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c20:	03040793          	addi	a5,s0,48
 c24:	fcf43423          	sd	a5,-56(s0)
 c28:	fc843783          	ld	a5,-56(s0)
 c2c:	fd078793          	addi	a5,a5,-48
 c30:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c34:	fe843703          	ld	a4,-24(s0)
 c38:	fdc42783          	lw	a5,-36(s0)
 c3c:	863a                	mv	a2,a4
 c3e:	fd043583          	ld	a1,-48(s0)
 c42:	853e                	mv	a0,a5
 c44:	b3dff0ef          	jal	780 <vprintf>
}
 c48:	0001                	nop
 c4a:	70e2                	ld	ra,56(sp)
 c4c:	7442                	ld	s0,48(sp)
 c4e:	6165                	addi	sp,sp,112
 c50:	8082                	ret

0000000000000c52 <printf>:

void
printf(const char *fmt, ...)
{
 c52:	7159                	addi	sp,sp,-112
 c54:	f406                	sd	ra,40(sp)
 c56:	f022                	sd	s0,32(sp)
 c58:	1800                	addi	s0,sp,48
 c5a:	fca43c23          	sd	a0,-40(s0)
 c5e:	e40c                	sd	a1,8(s0)
 c60:	e810                	sd	a2,16(s0)
 c62:	ec14                	sd	a3,24(s0)
 c64:	f018                	sd	a4,32(s0)
 c66:	f41c                	sd	a5,40(s0)
 c68:	03043823          	sd	a6,48(s0)
 c6c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c70:	04040793          	addi	a5,s0,64
 c74:	fcf43823          	sd	a5,-48(s0)
 c78:	fd043783          	ld	a5,-48(s0)
 c7c:	fc878793          	addi	a5,a5,-56
 c80:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 c84:	fe843783          	ld	a5,-24(s0)
 c88:	863e                	mv	a2,a5
 c8a:	fd843583          	ld	a1,-40(s0)
 c8e:	4505                	li	a0,1
 c90:	af1ff0ef          	jal	780 <vprintf>
}
 c94:	0001                	nop
 c96:	70a2                	ld	ra,40(sp)
 c98:	7402                	ld	s0,32(sp)
 c9a:	6165                	addi	sp,sp,112
 c9c:	8082                	ret

0000000000000c9e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c9e:	7179                	addi	sp,sp,-48
 ca0:	f406                	sd	ra,40(sp)
 ca2:	f022                	sd	s0,32(sp)
 ca4:	1800                	addi	s0,sp,48
 ca6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 caa:	fd843783          	ld	a5,-40(s0)
 cae:	17c1                	addi	a5,a5,-16
 cb0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cb4:	00000797          	auipc	a5,0x0
 cb8:	37c78793          	addi	a5,a5,892 # 1030 <freep>
 cbc:	639c                	ld	a5,0(a5)
 cbe:	fef43423          	sd	a5,-24(s0)
 cc2:	a815                	j	cf6 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cc4:	fe843783          	ld	a5,-24(s0)
 cc8:	639c                	ld	a5,0(a5)
 cca:	fe843703          	ld	a4,-24(s0)
 cce:	00f76f63          	bltu	a4,a5,cec <free+0x4e>
 cd2:	fe043703          	ld	a4,-32(s0)
 cd6:	fe843783          	ld	a5,-24(s0)
 cda:	02e7eb63          	bltu	a5,a4,d10 <free+0x72>
 cde:	fe843783          	ld	a5,-24(s0)
 ce2:	639c                	ld	a5,0(a5)
 ce4:	fe043703          	ld	a4,-32(s0)
 ce8:	02f76463          	bltu	a4,a5,d10 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cec:	fe843783          	ld	a5,-24(s0)
 cf0:	639c                	ld	a5,0(a5)
 cf2:	fef43423          	sd	a5,-24(s0)
 cf6:	fe043703          	ld	a4,-32(s0)
 cfa:	fe843783          	ld	a5,-24(s0)
 cfe:	fce7f3e3          	bgeu	a5,a4,cc4 <free+0x26>
 d02:	fe843783          	ld	a5,-24(s0)
 d06:	639c                	ld	a5,0(a5)
 d08:	fe043703          	ld	a4,-32(s0)
 d0c:	faf77ce3          	bgeu	a4,a5,cc4 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d10:	fe043783          	ld	a5,-32(s0)
 d14:	479c                	lw	a5,8(a5)
 d16:	1782                	slli	a5,a5,0x20
 d18:	9381                	srli	a5,a5,0x20
 d1a:	0792                	slli	a5,a5,0x4
 d1c:	fe043703          	ld	a4,-32(s0)
 d20:	973e                	add	a4,a4,a5
 d22:	fe843783          	ld	a5,-24(s0)
 d26:	639c                	ld	a5,0(a5)
 d28:	02f71763          	bne	a4,a5,d56 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d2c:	fe043783          	ld	a5,-32(s0)
 d30:	4798                	lw	a4,8(a5)
 d32:	fe843783          	ld	a5,-24(s0)
 d36:	639c                	ld	a5,0(a5)
 d38:	479c                	lw	a5,8(a5)
 d3a:	9fb9                	addw	a5,a5,a4
 d3c:	0007871b          	sext.w	a4,a5
 d40:	fe043783          	ld	a5,-32(s0)
 d44:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	639c                	ld	a5,0(a5)
 d4c:	6398                	ld	a4,0(a5)
 d4e:	fe043783          	ld	a5,-32(s0)
 d52:	e398                	sd	a4,0(a5)
 d54:	a039                	j	d62 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	6398                	ld	a4,0(a5)
 d5c:	fe043783          	ld	a5,-32(s0)
 d60:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 d62:	fe843783          	ld	a5,-24(s0)
 d66:	479c                	lw	a5,8(a5)
 d68:	1782                	slli	a5,a5,0x20
 d6a:	9381                	srli	a5,a5,0x20
 d6c:	0792                	slli	a5,a5,0x4
 d6e:	fe843703          	ld	a4,-24(s0)
 d72:	97ba                	add	a5,a5,a4
 d74:	fe043703          	ld	a4,-32(s0)
 d78:	02f71563          	bne	a4,a5,da2 <free+0x104>
    p->s.size += bp->s.size;
 d7c:	fe843783          	ld	a5,-24(s0)
 d80:	4798                	lw	a4,8(a5)
 d82:	fe043783          	ld	a5,-32(s0)
 d86:	479c                	lw	a5,8(a5)
 d88:	9fb9                	addw	a5,a5,a4
 d8a:	0007871b          	sext.w	a4,a5
 d8e:	fe843783          	ld	a5,-24(s0)
 d92:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d94:	fe043783          	ld	a5,-32(s0)
 d98:	6398                	ld	a4,0(a5)
 d9a:	fe843783          	ld	a5,-24(s0)
 d9e:	e398                	sd	a4,0(a5)
 da0:	a031                	j	dac <free+0x10e>
  } else
    p->s.ptr = bp;
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	fe043703          	ld	a4,-32(s0)
 daa:	e398                	sd	a4,0(a5)
  freep = p;
 dac:	00000797          	auipc	a5,0x0
 db0:	28478793          	addi	a5,a5,644 # 1030 <freep>
 db4:	fe843703          	ld	a4,-24(s0)
 db8:	e398                	sd	a4,0(a5)
}
 dba:	0001                	nop
 dbc:	70a2                	ld	ra,40(sp)
 dbe:	7402                	ld	s0,32(sp)
 dc0:	6145                	addi	sp,sp,48
 dc2:	8082                	ret

0000000000000dc4 <morecore>:

static Header*
morecore(uint nu)
{
 dc4:	7179                	addi	sp,sp,-48
 dc6:	f406                	sd	ra,40(sp)
 dc8:	f022                	sd	s0,32(sp)
 dca:	1800                	addi	s0,sp,48
 dcc:	87aa                	mv	a5,a0
 dce:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 dd2:	fdc42783          	lw	a5,-36(s0)
 dd6:	0007871b          	sext.w	a4,a5
 dda:	6785                	lui	a5,0x1
 ddc:	00f77563          	bgeu	a4,a5,de6 <morecore+0x22>
    nu = 4096;
 de0:	6785                	lui	a5,0x1
 de2:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 de6:	fdc42783          	lw	a5,-36(s0)
 dea:	0047979b          	slliw	a5,a5,0x4
 dee:	2781                	sext.w	a5,a5
 df0:	853e                	mv	a0,a5
 df2:	ef0ff0ef          	jal	4e2 <sbrk>
 df6:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 dfa:	fe843703          	ld	a4,-24(s0)
 dfe:	57fd                	li	a5,-1
 e00:	00f71463          	bne	a4,a5,e08 <morecore+0x44>
    return 0;
 e04:	4781                	li	a5,0
 e06:	a02d                	j	e30 <morecore+0x6c>
  hp = (Header*)p;
 e08:	fe843783          	ld	a5,-24(s0)
 e0c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e10:	fe043783          	ld	a5,-32(s0)
 e14:	fdc42703          	lw	a4,-36(s0)
 e18:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e1a:	fe043783          	ld	a5,-32(s0)
 e1e:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 e20:	853e                	mv	a0,a5
 e22:	e7dff0ef          	jal	c9e <free>
  return freep;
 e26:	00000797          	auipc	a5,0x0
 e2a:	20a78793          	addi	a5,a5,522 # 1030 <freep>
 e2e:	639c                	ld	a5,0(a5)
}
 e30:	853e                	mv	a0,a5
 e32:	70a2                	ld	ra,40(sp)
 e34:	7402                	ld	s0,32(sp)
 e36:	6145                	addi	sp,sp,48
 e38:	8082                	ret

0000000000000e3a <malloc>:

void*
malloc(uint nbytes)
{
 e3a:	7139                	addi	sp,sp,-64
 e3c:	fc06                	sd	ra,56(sp)
 e3e:	f822                	sd	s0,48(sp)
 e40:	0080                	addi	s0,sp,64
 e42:	87aa                	mv	a5,a0
 e44:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e48:	fcc46783          	lwu	a5,-52(s0)
 e4c:	07bd                	addi	a5,a5,15
 e4e:	8391                	srli	a5,a5,0x4
 e50:	2781                	sext.w	a5,a5
 e52:	2785                	addiw	a5,a5,1
 e54:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 e58:	00000797          	auipc	a5,0x0
 e5c:	1d878793          	addi	a5,a5,472 # 1030 <freep>
 e60:	639c                	ld	a5,0(a5)
 e62:	fef43023          	sd	a5,-32(s0)
 e66:	fe043783          	ld	a5,-32(s0)
 e6a:	ef95                	bnez	a5,ea6 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 e6c:	00000797          	auipc	a5,0x0
 e70:	1b478793          	addi	a5,a5,436 # 1020 <base>
 e74:	fef43023          	sd	a5,-32(s0)
 e78:	00000797          	auipc	a5,0x0
 e7c:	1b878793          	addi	a5,a5,440 # 1030 <freep>
 e80:	fe043703          	ld	a4,-32(s0)
 e84:	e398                	sd	a4,0(a5)
 e86:	00000797          	auipc	a5,0x0
 e8a:	1aa78793          	addi	a5,a5,426 # 1030 <freep>
 e8e:	6398                	ld	a4,0(a5)
 e90:	00000797          	auipc	a5,0x0
 e94:	19078793          	addi	a5,a5,400 # 1020 <base>
 e98:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 e9a:	00000797          	auipc	a5,0x0
 e9e:	18678793          	addi	a5,a5,390 # 1020 <base>
 ea2:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea6:	fe043783          	ld	a5,-32(s0)
 eaa:	639c                	ld	a5,0(a5)
 eac:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 eb0:	fe843783          	ld	a5,-24(s0)
 eb4:	479c                	lw	a5,8(a5)
 eb6:	fdc42703          	lw	a4,-36(s0)
 eba:	2701                	sext.w	a4,a4
 ebc:	06e7e763          	bltu	a5,a4,f2a <malloc+0xf0>
      if(p->s.size == nunits)
 ec0:	fe843783          	ld	a5,-24(s0)
 ec4:	479c                	lw	a5,8(a5)
 ec6:	fdc42703          	lw	a4,-36(s0)
 eca:	2701                	sext.w	a4,a4
 ecc:	00f71963          	bne	a4,a5,ede <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 ed0:	fe843783          	ld	a5,-24(s0)
 ed4:	6398                	ld	a4,0(a5)
 ed6:	fe043783          	ld	a5,-32(s0)
 eda:	e398                	sd	a4,0(a5)
 edc:	a825                	j	f14 <malloc+0xda>
      else {
        p->s.size -= nunits;
 ede:	fe843783          	ld	a5,-24(s0)
 ee2:	479c                	lw	a5,8(a5)
 ee4:	fdc42703          	lw	a4,-36(s0)
 ee8:	9f99                	subw	a5,a5,a4
 eea:	0007871b          	sext.w	a4,a5
 eee:	fe843783          	ld	a5,-24(s0)
 ef2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ef4:	fe843783          	ld	a5,-24(s0)
 ef8:	479c                	lw	a5,8(a5)
 efa:	1782                	slli	a5,a5,0x20
 efc:	9381                	srli	a5,a5,0x20
 efe:	0792                	slli	a5,a5,0x4
 f00:	fe843703          	ld	a4,-24(s0)
 f04:	97ba                	add	a5,a5,a4
 f06:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f0a:	fe843783          	ld	a5,-24(s0)
 f0e:	fdc42703          	lw	a4,-36(s0)
 f12:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f14:	00000797          	auipc	a5,0x0
 f18:	11c78793          	addi	a5,a5,284 # 1030 <freep>
 f1c:	fe043703          	ld	a4,-32(s0)
 f20:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f22:	fe843783          	ld	a5,-24(s0)
 f26:	07c1                	addi	a5,a5,16
 f28:	a081                	j	f68 <malloc+0x12e>
    }
    if(p == freep)
 f2a:	00000797          	auipc	a5,0x0
 f2e:	10678793          	addi	a5,a5,262 # 1030 <freep>
 f32:	639c                	ld	a5,0(a5)
 f34:	fe843703          	ld	a4,-24(s0)
 f38:	00f71e63          	bne	a4,a5,f54 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 f3c:	fdc42783          	lw	a5,-36(s0)
 f40:	853e                	mv	a0,a5
 f42:	e83ff0ef          	jal	dc4 <morecore>
 f46:	fea43423          	sd	a0,-24(s0)
 f4a:	fe843783          	ld	a5,-24(s0)
 f4e:	e399                	bnez	a5,f54 <malloc+0x11a>
        return 0;
 f50:	4781                	li	a5,0
 f52:	a819                	j	f68 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f54:	fe843783          	ld	a5,-24(s0)
 f58:	fef43023          	sd	a5,-32(s0)
 f5c:	fe843783          	ld	a5,-24(s0)
 f60:	639c                	ld	a5,0(a5)
 f62:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f66:	b7a9                	j	eb0 <malloc+0x76>
  }
}
 f68:	853e                	mv	a0,a5
 f6a:	70e2                	ld	ra,56(sp)
 f6c:	7442                	ld	s0,48(sp)
 f6e:	6121                	addi	sp,sp,64
 f70:	8082                	ret
