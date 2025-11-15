
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	87aa                	mv	a5,a0
   c:	fcb43023          	sd	a1,-64(s0)
  10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	fcf42e23          	sw	a5,-36(s0)
  1a:	a0bd                	j	88 <main+0x88>
    write(1, argv[i], strlen(argv[i]));
  1c:	fdc42783          	lw	a5,-36(s0)
  20:	078e                	slli	a5,a5,0x3
  22:	fc043703          	ld	a4,-64(s0)
  26:	97ba                	add	a5,a5,a4
  28:	6384                	ld	s1,0(a5)
  2a:	fdc42783          	lw	a5,-36(s0)
  2e:	078e                	slli	a5,a5,0x3
  30:	fc043703          	ld	a4,-64(s0)
  34:	97ba                	add	a5,a5,a4
  36:	639c                	ld	a5,0(a5)
  38:	853e                	mv	a0,a5
  3a:	14e000ef          	jal	188 <strlen>
  3e:	87aa                	mv	a5,a0
  40:	863e                	mv	a2,a5
  42:	85a6                	mv	a1,s1
  44:	4505                	li	a0,1
  46:	592000ef          	jal	5d8 <write>
    if(i + 1 < argc){
  4a:	fdc42783          	lw	a5,-36(s0)
  4e:	2785                	addiw	a5,a5,1
  50:	2781                	sext.w	a5,a5
  52:	fcc42703          	lw	a4,-52(s0)
  56:	2701                	sext.w	a4,a4
  58:	00e7db63          	bge	a5,a4,6e <main+0x6e>
      write(1, " ", 1);
  5c:	4605                	li	a2,1
  5e:	00001597          	auipc	a1,0x1
  62:	fa258593          	addi	a1,a1,-94 # 1000 <malloc+0x13c>
  66:	4505                	li	a0,1
  68:	570000ef          	jal	5d8 <write>
  6c:	a809                	j	7e <main+0x7e>
    } else {
      write(1, "\n", 1);
  6e:	4605                	li	a2,1
  70:	00001597          	auipc	a1,0x1
  74:	f9858593          	addi	a1,a1,-104 # 1008 <malloc+0x144>
  78:	4505                	li	a0,1
  7a:	55e000ef          	jal	5d8 <write>
  for(i = 1; i < argc; i++){
  7e:	fdc42783          	lw	a5,-36(s0)
  82:	2785                	addiw	a5,a5,1
  84:	fcf42e23          	sw	a5,-36(s0)
  88:	fdc42783          	lw	a5,-36(s0)
  8c:	873e                	mv	a4,a5
  8e:	fcc42783          	lw	a5,-52(s0)
  92:	2701                	sext.w	a4,a4
  94:	2781                	sext.w	a5,a5
  96:	f8f743e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
  9a:	4501                	li	a0,0
  9c:	51c000ef          	jal	5b8 <exit>

00000000000000a0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  a0:	7179                	addi	sp,sp,-48
  a2:	f406                	sd	ra,40(sp)
  a4:	f022                	sd	s0,32(sp)
  a6:	1800                	addi	s0,sp,48
  a8:	87aa                	mv	a5,a0
  aa:	fcb43823          	sd	a1,-48(s0)
  ae:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  b2:	fdc42783          	lw	a5,-36(s0)
  b6:	fd043583          	ld	a1,-48(s0)
  ba:	853e                	mv	a0,a5
  bc:	f45ff0ef          	jal	0 <main>
  c0:	87aa                	mv	a5,a0
  c2:	fef42623          	sw	a5,-20(s0)
  exit(r);
  c6:	fec42783          	lw	a5,-20(s0)
  ca:	853e                	mv	a0,a5
  cc:	4ec000ef          	jal	5b8 <exit>

00000000000000d0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d0:	7179                	addi	sp,sp,-48
  d2:	f406                	sd	ra,40(sp)
  d4:	f022                	sd	s0,32(sp)
  d6:	1800                	addi	s0,sp,48
  d8:	fca43c23          	sd	a0,-40(s0)
  dc:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  e0:	fd843783          	ld	a5,-40(s0)
  e4:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  e8:	0001                	nop
  ea:	fd043703          	ld	a4,-48(s0)
  ee:	00170793          	addi	a5,a4,1
  f2:	fcf43823          	sd	a5,-48(s0)
  f6:	fd843783          	ld	a5,-40(s0)
  fa:	00178693          	addi	a3,a5,1
  fe:	fcd43c23          	sd	a3,-40(s0)
 102:	00074703          	lbu	a4,0(a4)
 106:	00e78023          	sb	a4,0(a5)
 10a:	0007c783          	lbu	a5,0(a5)
 10e:	fff1                	bnez	a5,ea <strcpy+0x1a>
    ;
  return os;
 110:	fe843783          	ld	a5,-24(s0)
}
 114:	853e                	mv	a0,a5
 116:	70a2                	ld	ra,40(sp)
 118:	7402                	ld	s0,32(sp)
 11a:	6145                	addi	sp,sp,48
 11c:	8082                	ret

000000000000011e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11e:	1101                	addi	sp,sp,-32
 120:	ec06                	sd	ra,24(sp)
 122:	e822                	sd	s0,16(sp)
 124:	1000                	addi	s0,sp,32
 126:	fea43423          	sd	a0,-24(s0)
 12a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 12e:	a819                	j	144 <strcmp+0x26>
    p++, q++;
 130:	fe843783          	ld	a5,-24(s0)
 134:	0785                	addi	a5,a5,1
 136:	fef43423          	sd	a5,-24(s0)
 13a:	fe043783          	ld	a5,-32(s0)
 13e:	0785                	addi	a5,a5,1
 140:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 144:	fe843783          	ld	a5,-24(s0)
 148:	0007c783          	lbu	a5,0(a5)
 14c:	cb99                	beqz	a5,162 <strcmp+0x44>
 14e:	fe843783          	ld	a5,-24(s0)
 152:	0007c703          	lbu	a4,0(a5)
 156:	fe043783          	ld	a5,-32(s0)
 15a:	0007c783          	lbu	a5,0(a5)
 15e:	fcf709e3          	beq	a4,a5,130 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 162:	fe843783          	ld	a5,-24(s0)
 166:	0007c783          	lbu	a5,0(a5)
 16a:	0007871b          	sext.w	a4,a5
 16e:	fe043783          	ld	a5,-32(s0)
 172:	0007c783          	lbu	a5,0(a5)
 176:	2781                	sext.w	a5,a5
 178:	40f707bb          	subw	a5,a4,a5
 17c:	2781                	sext.w	a5,a5
}
 17e:	853e                	mv	a0,a5
 180:	60e2                	ld	ra,24(sp)
 182:	6442                	ld	s0,16(sp)
 184:	6105                	addi	sp,sp,32
 186:	8082                	ret

0000000000000188 <strlen>:

uint
strlen(const char *s)
{
 188:	7179                	addi	sp,sp,-48
 18a:	f406                	sd	ra,40(sp)
 18c:	f022                	sd	s0,32(sp)
 18e:	1800                	addi	s0,sp,48
 190:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 194:	fe042623          	sw	zero,-20(s0)
 198:	a031                	j	1a4 <strlen+0x1c>
 19a:	fec42783          	lw	a5,-20(s0)
 19e:	2785                	addiw	a5,a5,1
 1a0:	fef42623          	sw	a5,-20(s0)
 1a4:	fec42783          	lw	a5,-20(s0)
 1a8:	fd843703          	ld	a4,-40(s0)
 1ac:	97ba                	add	a5,a5,a4
 1ae:	0007c783          	lbu	a5,0(a5)
 1b2:	f7e5                	bnez	a5,19a <strlen+0x12>
    ;
  return n;
 1b4:	fec42783          	lw	a5,-20(s0)
}
 1b8:	853e                	mv	a0,a5
 1ba:	70a2                	ld	ra,40(sp)
 1bc:	7402                	ld	s0,32(sp)
 1be:	6145                	addi	sp,sp,48
 1c0:	8082                	ret

00000000000001c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c2:	7179                	addi	sp,sp,-48
 1c4:	f406                	sd	ra,40(sp)
 1c6:	f022                	sd	s0,32(sp)
 1c8:	1800                	addi	s0,sp,48
 1ca:	fca43c23          	sd	a0,-40(s0)
 1ce:	87ae                	mv	a5,a1
 1d0:	8732                	mv	a4,a2
 1d2:	fcf42a23          	sw	a5,-44(s0)
 1d6:	87ba                	mv	a5,a4
 1d8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1dc:	fd843783          	ld	a5,-40(s0)
 1e0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1e4:	fe042623          	sw	zero,-20(s0)
 1e8:	a00d                	j	20a <memset+0x48>
    cdst[i] = c;
 1ea:	fec42783          	lw	a5,-20(s0)
 1ee:	fe043703          	ld	a4,-32(s0)
 1f2:	97ba                	add	a5,a5,a4
 1f4:	fd442703          	lw	a4,-44(s0)
 1f8:	0ff77713          	zext.b	a4,a4
 1fc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 200:	fec42783          	lw	a5,-20(s0)
 204:	2785                	addiw	a5,a5,1
 206:	fef42623          	sw	a5,-20(s0)
 20a:	fec42783          	lw	a5,-20(s0)
 20e:	fd042703          	lw	a4,-48(s0)
 212:	2701                	sext.w	a4,a4
 214:	fce7ebe3          	bltu	a5,a4,1ea <memset+0x28>
  }
  return dst;
 218:	fd843783          	ld	a5,-40(s0)
}
 21c:	853e                	mv	a0,a5
 21e:	70a2                	ld	ra,40(sp)
 220:	7402                	ld	s0,32(sp)
 222:	6145                	addi	sp,sp,48
 224:	8082                	ret

0000000000000226 <strchr>:

char*
strchr(const char *s, char c)
{
 226:	1101                	addi	sp,sp,-32
 228:	ec06                	sd	ra,24(sp)
 22a:	e822                	sd	s0,16(sp)
 22c:	1000                	addi	s0,sp,32
 22e:	fea43423          	sd	a0,-24(s0)
 232:	87ae                	mv	a5,a1
 234:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 238:	a01d                	j	25e <strchr+0x38>
    if(*s == c)
 23a:	fe843783          	ld	a5,-24(s0)
 23e:	0007c703          	lbu	a4,0(a5)
 242:	fe744783          	lbu	a5,-25(s0)
 246:	0ff7f793          	zext.b	a5,a5
 24a:	00e79563          	bne	a5,a4,254 <strchr+0x2e>
      return (char*)s;
 24e:	fe843783          	ld	a5,-24(s0)
 252:	a821                	j	26a <strchr+0x44>
  for(; *s; s++)
 254:	fe843783          	ld	a5,-24(s0)
 258:	0785                	addi	a5,a5,1
 25a:	fef43423          	sd	a5,-24(s0)
 25e:	fe843783          	ld	a5,-24(s0)
 262:	0007c783          	lbu	a5,0(a5)
 266:	fbf1                	bnez	a5,23a <strchr+0x14>
  return 0;
 268:	4781                	li	a5,0
}
 26a:	853e                	mv	a0,a5
 26c:	60e2                	ld	ra,24(sp)
 26e:	6442                	ld	s0,16(sp)
 270:	6105                	addi	sp,sp,32
 272:	8082                	ret

0000000000000274 <gets>:

char*
gets(char *buf, int max)
{
 274:	7179                	addi	sp,sp,-48
 276:	f406                	sd	ra,40(sp)
 278:	f022                	sd	s0,32(sp)
 27a:	1800                	addi	s0,sp,48
 27c:	fca43c23          	sd	a0,-40(s0)
 280:	87ae                	mv	a5,a1
 282:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	fe042623          	sw	zero,-20(s0)
 28a:	a891                	j	2de <gets+0x6a>
    cc = read(0, &c, 1);
 28c:	fe740793          	addi	a5,s0,-25
 290:	4605                	li	a2,1
 292:	85be                	mv	a1,a5
 294:	4501                	li	a0,0
 296:	33a000ef          	jal	5d0 <read>
 29a:	87aa                	mv	a5,a0
 29c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2a0:	fe842783          	lw	a5,-24(s0)
 2a4:	2781                	sext.w	a5,a5
 2a6:	04f05663          	blez	a5,2f2 <gets+0x7e>
      break;
    buf[i++] = c;
 2aa:	fec42783          	lw	a5,-20(s0)
 2ae:	0017871b          	addiw	a4,a5,1
 2b2:	fee42623          	sw	a4,-20(s0)
 2b6:	873e                	mv	a4,a5
 2b8:	fd843783          	ld	a5,-40(s0)
 2bc:	97ba                	add	a5,a5,a4
 2be:	fe744703          	lbu	a4,-25(s0)
 2c2:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2c6:	fe744783          	lbu	a5,-25(s0)
 2ca:	873e                	mv	a4,a5
 2cc:	47a9                	li	a5,10
 2ce:	02f70363          	beq	a4,a5,2f4 <gets+0x80>
 2d2:	fe744783          	lbu	a5,-25(s0)
 2d6:	873e                	mv	a4,a5
 2d8:	47b5                	li	a5,13
 2da:	00f70d63          	beq	a4,a5,2f4 <gets+0x80>
  for(i=0; i+1 < max; ){
 2de:	fec42783          	lw	a5,-20(s0)
 2e2:	2785                	addiw	a5,a5,1
 2e4:	2781                	sext.w	a5,a5
 2e6:	fd442703          	lw	a4,-44(s0)
 2ea:	2701                	sext.w	a4,a4
 2ec:	fae7c0e3          	blt	a5,a4,28c <gets+0x18>
 2f0:	a011                	j	2f4 <gets+0x80>
      break;
 2f2:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2f4:	fec42783          	lw	a5,-20(s0)
 2f8:	fd843703          	ld	a4,-40(s0)
 2fc:	97ba                	add	a5,a5,a4
 2fe:	00078023          	sb	zero,0(a5)
  return buf;
 302:	fd843783          	ld	a5,-40(s0)
}
 306:	853e                	mv	a0,a5
 308:	70a2                	ld	ra,40(sp)
 30a:	7402                	ld	s0,32(sp)
 30c:	6145                	addi	sp,sp,48
 30e:	8082                	ret

0000000000000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	7179                	addi	sp,sp,-48
 312:	f406                	sd	ra,40(sp)
 314:	f022                	sd	s0,32(sp)
 316:	1800                	addi	s0,sp,48
 318:	fca43c23          	sd	a0,-40(s0)
 31c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 320:	4581                	li	a1,0
 322:	fd843503          	ld	a0,-40(s0)
 326:	2d2000ef          	jal	5f8 <open>
 32a:	87aa                	mv	a5,a0
 32c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 330:	fec42783          	lw	a5,-20(s0)
 334:	2781                	sext.w	a5,a5
 336:	0007d463          	bgez	a5,33e <stat+0x2e>
    return -1;
 33a:	57fd                	li	a5,-1
 33c:	a015                	j	360 <stat+0x50>
  r = fstat(fd, st);
 33e:	fec42783          	lw	a5,-20(s0)
 342:	fd043583          	ld	a1,-48(s0)
 346:	853e                	mv	a0,a5
 348:	2c8000ef          	jal	610 <fstat>
 34c:	87aa                	mv	a5,a0
 34e:	fef42423          	sw	a5,-24(s0)
  close(fd);
 352:	fec42783          	lw	a5,-20(s0)
 356:	853e                	mv	a0,a5
 358:	288000ef          	jal	5e0 <close>
  return r;
 35c:	fe842783          	lw	a5,-24(s0)
}
 360:	853e                	mv	a0,a5
 362:	70a2                	ld	ra,40(sp)
 364:	7402                	ld	s0,32(sp)
 366:	6145                	addi	sp,sp,48
 368:	8082                	ret

000000000000036a <atoi>:

int
atoi(const char *s)
{
 36a:	7179                	addi	sp,sp,-48
 36c:	f406                	sd	ra,40(sp)
 36e:	f022                	sd	s0,32(sp)
 370:	1800                	addi	s0,sp,48
 372:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 376:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 37a:	a81d                	j	3b0 <atoi+0x46>
    n = n*10 + *s++ - '0';
 37c:	fec42783          	lw	a5,-20(s0)
 380:	873e                	mv	a4,a5
 382:	87ba                	mv	a5,a4
 384:	0027979b          	slliw	a5,a5,0x2
 388:	9fb9                	addw	a5,a5,a4
 38a:	0017979b          	slliw	a5,a5,0x1
 38e:	0007871b          	sext.w	a4,a5
 392:	fd843783          	ld	a5,-40(s0)
 396:	00178693          	addi	a3,a5,1
 39a:	fcd43c23          	sd	a3,-40(s0)
 39e:	0007c783          	lbu	a5,0(a5)
 3a2:	2781                	sext.w	a5,a5
 3a4:	9fb9                	addw	a5,a5,a4
 3a6:	2781                	sext.w	a5,a5
 3a8:	fd07879b          	addiw	a5,a5,-48
 3ac:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3b0:	fd843783          	ld	a5,-40(s0)
 3b4:	0007c783          	lbu	a5,0(a5)
 3b8:	873e                	mv	a4,a5
 3ba:	02f00793          	li	a5,47
 3be:	00e7fb63          	bgeu	a5,a4,3d4 <atoi+0x6a>
 3c2:	fd843783          	ld	a5,-40(s0)
 3c6:	0007c783          	lbu	a5,0(a5)
 3ca:	873e                	mv	a4,a5
 3cc:	03900793          	li	a5,57
 3d0:	fae7f6e3          	bgeu	a5,a4,37c <atoi+0x12>
  return n;
 3d4:	fec42783          	lw	a5,-20(s0)
}
 3d8:	853e                	mv	a0,a5
 3da:	70a2                	ld	ra,40(sp)
 3dc:	7402                	ld	s0,32(sp)
 3de:	6145                	addi	sp,sp,48
 3e0:	8082                	ret

00000000000003e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e2:	7139                	addi	sp,sp,-64
 3e4:	fc06                	sd	ra,56(sp)
 3e6:	f822                	sd	s0,48(sp)
 3e8:	0080                	addi	s0,sp,64
 3ea:	fca43c23          	sd	a0,-40(s0)
 3ee:	fcb43823          	sd	a1,-48(s0)
 3f2:	87b2                	mv	a5,a2
 3f4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3f8:	fd843783          	ld	a5,-40(s0)
 3fc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 400:	fd043783          	ld	a5,-48(s0)
 404:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 408:	fe043703          	ld	a4,-32(s0)
 40c:	fe843783          	ld	a5,-24(s0)
 410:	02e7fc63          	bgeu	a5,a4,448 <memmove+0x66>
    while(n-- > 0)
 414:	a00d                	j	436 <memmove+0x54>
      *dst++ = *src++;
 416:	fe043703          	ld	a4,-32(s0)
 41a:	00170793          	addi	a5,a4,1
 41e:	fef43023          	sd	a5,-32(s0)
 422:	fe843783          	ld	a5,-24(s0)
 426:	00178693          	addi	a3,a5,1
 42a:	fed43423          	sd	a3,-24(s0)
 42e:	00074703          	lbu	a4,0(a4)
 432:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 436:	fcc42783          	lw	a5,-52(s0)
 43a:	fff7871b          	addiw	a4,a5,-1
 43e:	fce42623          	sw	a4,-52(s0)
 442:	fcf04ae3          	bgtz	a5,416 <memmove+0x34>
 446:	a891                	j	49a <memmove+0xb8>
  } else {
    dst += n;
 448:	fcc42783          	lw	a5,-52(s0)
 44c:	fe843703          	ld	a4,-24(s0)
 450:	97ba                	add	a5,a5,a4
 452:	fef43423          	sd	a5,-24(s0)
    src += n;
 456:	fcc42783          	lw	a5,-52(s0)
 45a:	fe043703          	ld	a4,-32(s0)
 45e:	97ba                	add	a5,a5,a4
 460:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 464:	a01d                	j	48a <memmove+0xa8>
      *--dst = *--src;
 466:	fe043783          	ld	a5,-32(s0)
 46a:	17fd                	addi	a5,a5,-1
 46c:	fef43023          	sd	a5,-32(s0)
 470:	fe843783          	ld	a5,-24(s0)
 474:	17fd                	addi	a5,a5,-1
 476:	fef43423          	sd	a5,-24(s0)
 47a:	fe043783          	ld	a5,-32(s0)
 47e:	0007c703          	lbu	a4,0(a5)
 482:	fe843783          	ld	a5,-24(s0)
 486:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 48a:	fcc42783          	lw	a5,-52(s0)
 48e:	fff7871b          	addiw	a4,a5,-1
 492:	fce42623          	sw	a4,-52(s0)
 496:	fcf048e3          	bgtz	a5,466 <memmove+0x84>
  }
  return vdst;
 49a:	fd843783          	ld	a5,-40(s0)
}
 49e:	853e                	mv	a0,a5
 4a0:	70e2                	ld	ra,56(sp)
 4a2:	7442                	ld	s0,48(sp)
 4a4:	6121                	addi	sp,sp,64
 4a6:	8082                	ret

00000000000004a8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a8:	7139                	addi	sp,sp,-64
 4aa:	fc06                	sd	ra,56(sp)
 4ac:	f822                	sd	s0,48(sp)
 4ae:	0080                	addi	s0,sp,64
 4b0:	fca43c23          	sd	a0,-40(s0)
 4b4:	fcb43823          	sd	a1,-48(s0)
 4b8:	87b2                	mv	a5,a2
 4ba:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4be:	fd843783          	ld	a5,-40(s0)
 4c2:	fef43423          	sd	a5,-24(s0)
 4c6:	fd043783          	ld	a5,-48(s0)
 4ca:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4ce:	a0a1                	j	516 <memcmp+0x6e>
    if (*p1 != *p2) {
 4d0:	fe843783          	ld	a5,-24(s0)
 4d4:	0007c703          	lbu	a4,0(a5)
 4d8:	fe043783          	ld	a5,-32(s0)
 4dc:	0007c783          	lbu	a5,0(a5)
 4e0:	02f70163          	beq	a4,a5,502 <memcmp+0x5a>
      return *p1 - *p2;
 4e4:	fe843783          	ld	a5,-24(s0)
 4e8:	0007c783          	lbu	a5,0(a5)
 4ec:	0007871b          	sext.w	a4,a5
 4f0:	fe043783          	ld	a5,-32(s0)
 4f4:	0007c783          	lbu	a5,0(a5)
 4f8:	2781                	sext.w	a5,a5
 4fa:	40f707bb          	subw	a5,a4,a5
 4fe:	2781                	sext.w	a5,a5
 500:	a01d                	j	526 <memcmp+0x7e>
    }
    p1++;
 502:	fe843783          	ld	a5,-24(s0)
 506:	0785                	addi	a5,a5,1
 508:	fef43423          	sd	a5,-24(s0)
    p2++;
 50c:	fe043783          	ld	a5,-32(s0)
 510:	0785                	addi	a5,a5,1
 512:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 516:	fcc42783          	lw	a5,-52(s0)
 51a:	fff7871b          	addiw	a4,a5,-1
 51e:	fce42623          	sw	a4,-52(s0)
 522:	f7dd                	bnez	a5,4d0 <memcmp+0x28>
  }
  return 0;
 524:	4781                	li	a5,0
}
 526:	853e                	mv	a0,a5
 528:	70e2                	ld	ra,56(sp)
 52a:	7442                	ld	s0,48(sp)
 52c:	6121                	addi	sp,sp,64
 52e:	8082                	ret

0000000000000530 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 530:	7179                	addi	sp,sp,-48
 532:	f406                	sd	ra,40(sp)
 534:	f022                	sd	s0,32(sp)
 536:	1800                	addi	s0,sp,48
 538:	fea43423          	sd	a0,-24(s0)
 53c:	feb43023          	sd	a1,-32(s0)
 540:	87b2                	mv	a5,a2
 542:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 546:	fdc42783          	lw	a5,-36(s0)
 54a:	863e                	mv	a2,a5
 54c:	fe043583          	ld	a1,-32(s0)
 550:	fe843503          	ld	a0,-24(s0)
 554:	e8fff0ef          	jal	3e2 <memmove>
 558:	87aa                	mv	a5,a0
}
 55a:	853e                	mv	a0,a5
 55c:	70a2                	ld	ra,40(sp)
 55e:	7402                	ld	s0,32(sp)
 560:	6145                	addi	sp,sp,48
 562:	8082                	ret

0000000000000564 <sbrk>:

char *
sbrk(int n) {
 564:	1101                	addi	sp,sp,-32
 566:	ec06                	sd	ra,24(sp)
 568:	e822                	sd	s0,16(sp)
 56a:	1000                	addi	s0,sp,32
 56c:	87aa                	mv	a5,a0
 56e:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 572:	fec42783          	lw	a5,-20(s0)
 576:	4585                	li	a1,1
 578:	853e                	mv	a0,a5
 57a:	0c6000ef          	jal	640 <sys_sbrk>
 57e:	87aa                	mv	a5,a0
}
 580:	853e                	mv	a0,a5
 582:	60e2                	ld	ra,24(sp)
 584:	6442                	ld	s0,16(sp)
 586:	6105                	addi	sp,sp,32
 588:	8082                	ret

000000000000058a <sbrklazy>:

char *
sbrklazy(int n) {
 58a:	1101                	addi	sp,sp,-32
 58c:	ec06                	sd	ra,24(sp)
 58e:	e822                	sd	s0,16(sp)
 590:	1000                	addi	s0,sp,32
 592:	87aa                	mv	a5,a0
 594:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 598:	fec42783          	lw	a5,-20(s0)
 59c:	4589                	li	a1,2
 59e:	853e                	mv	a0,a5
 5a0:	0a0000ef          	jal	640 <sys_sbrk>
 5a4:	87aa                	mv	a5,a0
}
 5a6:	853e                	mv	a0,a5
 5a8:	60e2                	ld	ra,24(sp)
 5aa:	6442                	ld	s0,16(sp)
 5ac:	6105                	addi	sp,sp,32
 5ae:	8082                	ret

00000000000005b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b0:	4885                	li	a7,1
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b8:	4889                	li	a7,2
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c0:	488d                	li	a7,3
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c8:	4891                	li	a7,4
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <read>:
.global read
read:
 li a7, SYS_read
 5d0:	4895                	li	a7,5
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <write>:
.global write
write:
 li a7, SYS_write
 5d8:	48c1                	li	a7,16
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <close>:
.global close
close:
 li a7, SYS_close
 5e0:	48d5                	li	a7,21
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e8:	4899                	li	a7,6
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f0:	489d                	li	a7,7
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <open>:
.global open
open:
 li a7, SYS_open
 5f8:	48bd                	li	a7,15
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 600:	48c5                	li	a7,17
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 608:	48c9                	li	a7,18
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 610:	48a1                	li	a7,8
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <link>:
.global link
link:
 li a7, SYS_link
 618:	48cd                	li	a7,19
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 620:	48d1                	li	a7,20
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 628:	48a5                	li	a7,9
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <dup>:
.global dup
dup:
 li a7, SYS_dup
 630:	48a9                	li	a7,10
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 638:	48ad                	li	a7,11
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 640:	48b1                	li	a7,12
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <pause>:
.global pause
pause:
 li a7, SYS_pause
 648:	48b5                	li	a7,13
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 650:	48b9                	li	a7,14
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <top>:
.global top
top:
 li a7, SYS_top
 658:	48d9                	li	a7,22
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
 660:	48dd                	li	a7,23
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 668:	1101                	addi	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	addi	s0,sp,32
 670:	87aa                	mv	a5,a0
 672:	872e                	mv	a4,a1
 674:	fef42623          	sw	a5,-20(s0)
 678:	87ba                	mv	a5,a4
 67a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 67e:	feb40713          	addi	a4,s0,-21
 682:	fec42783          	lw	a5,-20(s0)
 686:	4605                	li	a2,1
 688:	85ba                	mv	a1,a4
 68a:	853e                	mv	a0,a5
 68c:	f4dff0ef          	jal	5d8 <write>
}
 690:	0001                	nop
 692:	60e2                	ld	ra,24(sp)
 694:	6442                	ld	s0,16(sp)
 696:	6105                	addi	sp,sp,32
 698:	8082                	ret

000000000000069a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 69a:	711d                	addi	sp,sp,-96
 69c:	ec86                	sd	ra,88(sp)
 69e:	e8a2                	sd	s0,80(sp)
 6a0:	1080                	addi	s0,sp,96
 6a2:	87aa                	mv	a5,a0
 6a4:	fab43823          	sd	a1,-80(s0)
 6a8:	8736                	mv	a4,a3
 6aa:	faf42e23          	sw	a5,-68(s0)
 6ae:	87b2                	mv	a5,a2
 6b0:	faf42c23          	sw	a5,-72(s0)
 6b4:	87ba                	mv	a5,a4
 6b6:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 6ba:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6be:	fac42783          	lw	a5,-84(s0)
 6c2:	2781                	sext.w	a5,a5
 6c4:	cf99                	beqz	a5,6e2 <printint+0x48>
 6c6:	fb043783          	ld	a5,-80(s0)
 6ca:	0007dc63          	bgez	a5,6e2 <printint+0x48>
    neg = 1;
 6ce:	4785                	li	a5,1
 6d0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6d4:	fb043783          	ld	a5,-80(s0)
 6d8:	40f007b3          	neg	a5,a5
 6dc:	fef43023          	sd	a5,-32(s0)
 6e0:	a029                	j	6ea <printint+0x50>
  } else {
    x = xx;
 6e2:	fb043783          	ld	a5,-80(s0)
 6e6:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6ea:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6ee:	fb842783          	lw	a5,-72(s0)
 6f2:	fe043703          	ld	a4,-32(s0)
 6f6:	02f77733          	remu	a4,a4,a5
 6fa:	fec42783          	lw	a5,-20(s0)
 6fe:	0017869b          	addiw	a3,a5,1
 702:	fed42623          	sw	a3,-20(s0)
 706:	00002697          	auipc	a3,0x2
 70a:	8fa68693          	addi	a3,a3,-1798 # 2000 <digits>
 70e:	9736                	add	a4,a4,a3
 710:	00074703          	lbu	a4,0(a4)
 714:	17c1                	addi	a5,a5,-16
 716:	97a2                	add	a5,a5,s0
 718:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 71c:	fb842783          	lw	a5,-72(s0)
 720:	fe043703          	ld	a4,-32(s0)
 724:	02f757b3          	divu	a5,a4,a5
 728:	fef43023          	sd	a5,-32(s0)
 72c:	fe043783          	ld	a5,-32(s0)
 730:	ffdd                	bnez	a5,6ee <printint+0x54>
  if(neg)
 732:	fe842783          	lw	a5,-24(s0)
 736:	2781                	sext.w	a5,a5
 738:	cb95                	beqz	a5,76c <printint+0xd2>
    buf[i++] = '-';
 73a:	fec42783          	lw	a5,-20(s0)
 73e:	0017871b          	addiw	a4,a5,1
 742:	fee42623          	sw	a4,-20(s0)
 746:	17c1                	addi	a5,a5,-16
 748:	97a2                	add	a5,a5,s0
 74a:	02d00713          	li	a4,45
 74e:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 752:	a829                	j	76c <printint+0xd2>
    putc(fd, buf[i]);
 754:	fec42783          	lw	a5,-20(s0)
 758:	17c1                	addi	a5,a5,-16
 75a:	97a2                	add	a5,a5,s0
 75c:	fd87c703          	lbu	a4,-40(a5)
 760:	fbc42783          	lw	a5,-68(s0)
 764:	85ba                	mv	a1,a4
 766:	853e                	mv	a0,a5
 768:	f01ff0ef          	jal	668 <putc>
  while(--i >= 0)
 76c:	fec42783          	lw	a5,-20(s0)
 770:	37fd                	addiw	a5,a5,-1
 772:	fef42623          	sw	a5,-20(s0)
 776:	fec42783          	lw	a5,-20(s0)
 77a:	2781                	sext.w	a5,a5
 77c:	fc07dce3          	bgez	a5,754 <printint+0xba>
}
 780:	0001                	nop
 782:	0001                	nop
 784:	60e6                	ld	ra,88(sp)
 786:	6446                	ld	s0,80(sp)
 788:	6125                	addi	sp,sp,96
 78a:	8082                	ret

000000000000078c <printptr>:

static void
printptr(int fd, uint64 x) {
 78c:	7179                	addi	sp,sp,-48
 78e:	f406                	sd	ra,40(sp)
 790:	f022                	sd	s0,32(sp)
 792:	1800                	addi	s0,sp,48
 794:	87aa                	mv	a5,a0
 796:	fcb43823          	sd	a1,-48(s0)
 79a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 79e:	fdc42783          	lw	a5,-36(s0)
 7a2:	03000593          	li	a1,48
 7a6:	853e                	mv	a0,a5
 7a8:	ec1ff0ef          	jal	668 <putc>
  putc(fd, 'x');
 7ac:	fdc42783          	lw	a5,-36(s0)
 7b0:	07800593          	li	a1,120
 7b4:	853e                	mv	a0,a5
 7b6:	eb3ff0ef          	jal	668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	fe042623          	sw	zero,-20(s0)
 7be:	a81d                	j	7f4 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c0:	fd043783          	ld	a5,-48(s0)
 7c4:	93f1                	srli	a5,a5,0x3c
 7c6:	00002717          	auipc	a4,0x2
 7ca:	83a70713          	addi	a4,a4,-1990 # 2000 <digits>
 7ce:	97ba                	add	a5,a5,a4
 7d0:	0007c703          	lbu	a4,0(a5)
 7d4:	fdc42783          	lw	a5,-36(s0)
 7d8:	85ba                	mv	a1,a4
 7da:	853e                	mv	a0,a5
 7dc:	e8dff0ef          	jal	668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e0:	fec42783          	lw	a5,-20(s0)
 7e4:	2785                	addiw	a5,a5,1
 7e6:	fef42623          	sw	a5,-20(s0)
 7ea:	fd043783          	ld	a5,-48(s0)
 7ee:	0792                	slli	a5,a5,0x4
 7f0:	fcf43823          	sd	a5,-48(s0)
 7f4:	fec42703          	lw	a4,-20(s0)
 7f8:	47bd                	li	a5,15
 7fa:	fce7f3e3          	bgeu	a5,a4,7c0 <printptr+0x34>
}
 7fe:	0001                	nop
 800:	0001                	nop
 802:	70a2                	ld	ra,40(sp)
 804:	7402                	ld	s0,32(sp)
 806:	6145                	addi	sp,sp,48
 808:	8082                	ret

000000000000080a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 80a:	715d                	addi	sp,sp,-80
 80c:	e486                	sd	ra,72(sp)
 80e:	e0a2                	sd	s0,64(sp)
 810:	0880                	addi	s0,sp,80
 812:	87aa                	mv	a5,a0
 814:	fcb43023          	sd	a1,-64(s0)
 818:	fac43c23          	sd	a2,-72(s0)
 81c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 820:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 824:	fc042e23          	sw	zero,-36(s0)
 828:	a189                	j	c6a <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 82a:	fdc42783          	lw	a5,-36(s0)
 82e:	fc043703          	ld	a4,-64(s0)
 832:	97ba                	add	a5,a5,a4
 834:	0007c783          	lbu	a5,0(a5)
 838:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 83c:	fd842783          	lw	a5,-40(s0)
 840:	2781                	sext.w	a5,a5
 842:	eb8d                	bnez	a5,874 <vprintf+0x6a>
      if(c0 == '%'){
 844:	fd442783          	lw	a5,-44(s0)
 848:	0007871b          	sext.w	a4,a5
 84c:	02500793          	li	a5,37
 850:	00f71763          	bne	a4,a5,85e <vprintf+0x54>
        state = '%';
 854:	02500793          	li	a5,37
 858:	fcf42c23          	sw	a5,-40(s0)
 85c:	a111                	j	c60 <vprintf+0x456>
      } else {
        putc(fd, c0);
 85e:	fd442783          	lw	a5,-44(s0)
 862:	0ff7f713          	zext.b	a4,a5
 866:	fcc42783          	lw	a5,-52(s0)
 86a:	85ba                	mv	a1,a4
 86c:	853e                	mv	a0,a5
 86e:	dfbff0ef          	jal	668 <putc>
 872:	a6fd                	j	c60 <vprintf+0x456>
      }
    } else if(state == '%'){
 874:	fd842783          	lw	a5,-40(s0)
 878:	0007871b          	sext.w	a4,a5
 87c:	02500793          	li	a5,37
 880:	3ef71063          	bne	a4,a5,c60 <vprintf+0x456>
      c1 = c2 = 0;
 884:	fe042023          	sw	zero,-32(s0)
 888:	fe042783          	lw	a5,-32(s0)
 88c:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 890:	fd442783          	lw	a5,-44(s0)
 894:	2781                	sext.w	a5,a5
 896:	cb99                	beqz	a5,8ac <vprintf+0xa2>
 898:	fdc42783          	lw	a5,-36(s0)
 89c:	0785                	addi	a5,a5,1
 89e:	fc043703          	ld	a4,-64(s0)
 8a2:	97ba                	add	a5,a5,a4
 8a4:	0007c783          	lbu	a5,0(a5)
 8a8:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 8ac:	fe442783          	lw	a5,-28(s0)
 8b0:	2781                	sext.w	a5,a5
 8b2:	cb99                	beqz	a5,8c8 <vprintf+0xbe>
 8b4:	fdc42783          	lw	a5,-36(s0)
 8b8:	0789                	addi	a5,a5,2
 8ba:	fc043703          	ld	a4,-64(s0)
 8be:	97ba                	add	a5,a5,a4
 8c0:	0007c783          	lbu	a5,0(a5)
 8c4:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 8c8:	fd442783          	lw	a5,-44(s0)
 8cc:	0007871b          	sext.w	a4,a5
 8d0:	06400793          	li	a5,100
 8d4:	02f71363          	bne	a4,a5,8fa <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8d8:	fb843783          	ld	a5,-72(s0)
 8dc:	00878713          	addi	a4,a5,8
 8e0:	fae43c23          	sd	a4,-72(s0)
 8e4:	439c                	lw	a5,0(a5)
 8e6:	873e                	mv	a4,a5
 8e8:	fcc42783          	lw	a5,-52(s0)
 8ec:	4685                	li	a3,1
 8ee:	4629                	li	a2,10
 8f0:	85ba                	mv	a1,a4
 8f2:	853e                	mv	a0,a5
 8f4:	da7ff0ef          	jal	69a <printint>
 8f8:	a695                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8fa:	fd442783          	lw	a5,-44(s0)
 8fe:	0007871b          	sext.w	a4,a5
 902:	06c00793          	li	a5,108
 906:	04f71063          	bne	a4,a5,946 <vprintf+0x13c>
 90a:	fe442783          	lw	a5,-28(s0)
 90e:	0007871b          	sext.w	a4,a5
 912:	06400793          	li	a5,100
 916:	02f71863          	bne	a4,a5,946 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 91a:	fb843783          	ld	a5,-72(s0)
 91e:	00878713          	addi	a4,a5,8
 922:	fae43c23          	sd	a4,-72(s0)
 926:	639c                	ld	a5,0(a5)
 928:	873e                	mv	a4,a5
 92a:	fcc42783          	lw	a5,-52(s0)
 92e:	4685                	li	a3,1
 930:	4629                	li	a2,10
 932:	85ba                	mv	a1,a4
 934:	853e                	mv	a0,a5
 936:	d65ff0ef          	jal	69a <printint>
        i += 1;
 93a:	fdc42783          	lw	a5,-36(s0)
 93e:	2785                	addiw	a5,a5,1
 940:	fcf42e23          	sw	a5,-36(s0)
 944:	ae21                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 946:	fd442783          	lw	a5,-44(s0)
 94a:	0007871b          	sext.w	a4,a5
 94e:	06c00793          	li	a5,108
 952:	04f71863          	bne	a4,a5,9a2 <vprintf+0x198>
 956:	fe442783          	lw	a5,-28(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	06c00793          	li	a5,108
 962:	04f71063          	bne	a4,a5,9a2 <vprintf+0x198>
 966:	fe042783          	lw	a5,-32(s0)
 96a:	0007871b          	sext.w	a4,a5
 96e:	06400793          	li	a5,100
 972:	02f71863          	bne	a4,a5,9a2 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 976:	fb843783          	ld	a5,-72(s0)
 97a:	00878713          	addi	a4,a5,8
 97e:	fae43c23          	sd	a4,-72(s0)
 982:	639c                	ld	a5,0(a5)
 984:	873e                	mv	a4,a5
 986:	fcc42783          	lw	a5,-52(s0)
 98a:	4685                	li	a3,1
 98c:	4629                	li	a2,10
 98e:	85ba                	mv	a1,a4
 990:	853e                	mv	a0,a5
 992:	d09ff0ef          	jal	69a <printint>
        i += 2;
 996:	fdc42783          	lw	a5,-36(s0)
 99a:	2789                	addiw	a5,a5,2
 99c:	fcf42e23          	sw	a5,-36(s0)
 9a0:	ac75                	j	c5c <vprintf+0x452>
      } else if(c0 == 'u'){
 9a2:	fd442783          	lw	a5,-44(s0)
 9a6:	0007871b          	sext.w	a4,a5
 9aa:	07500793          	li	a5,117
 9ae:	02f71563          	bne	a4,a5,9d8 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9b2:	fb843783          	ld	a5,-72(s0)
 9b6:	00878713          	addi	a4,a5,8
 9ba:	fae43c23          	sd	a4,-72(s0)
 9be:	439c                	lw	a5,0(a5)
 9c0:	02079713          	slli	a4,a5,0x20
 9c4:	9301                	srli	a4,a4,0x20
 9c6:	fcc42783          	lw	a5,-52(s0)
 9ca:	4681                	li	a3,0
 9cc:	4629                	li	a2,10
 9ce:	85ba                	mv	a1,a4
 9d0:	853e                	mv	a0,a5
 9d2:	cc9ff0ef          	jal	69a <printint>
 9d6:	a459                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9d8:	fd442783          	lw	a5,-44(s0)
 9dc:	0007871b          	sext.w	a4,a5
 9e0:	06c00793          	li	a5,108
 9e4:	04f71063          	bne	a4,a5,a24 <vprintf+0x21a>
 9e8:	fe442783          	lw	a5,-28(s0)
 9ec:	0007871b          	sext.w	a4,a5
 9f0:	07500793          	li	a5,117
 9f4:	02f71863          	bne	a4,a5,a24 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f8:	fb843783          	ld	a5,-72(s0)
 9fc:	00878713          	addi	a4,a5,8
 a00:	fae43c23          	sd	a4,-72(s0)
 a04:	639c                	ld	a5,0(a5)
 a06:	873e                	mv	a4,a5
 a08:	fcc42783          	lw	a5,-52(s0)
 a0c:	4681                	li	a3,0
 a0e:	4629                	li	a2,10
 a10:	85ba                	mv	a1,a4
 a12:	853e                	mv	a0,a5
 a14:	c87ff0ef          	jal	69a <printint>
        i += 1;
 a18:	fdc42783          	lw	a5,-36(s0)
 a1c:	2785                	addiw	a5,a5,1
 a1e:	fcf42e23          	sw	a5,-36(s0)
 a22:	ac2d                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a24:	fd442783          	lw	a5,-44(s0)
 a28:	0007871b          	sext.w	a4,a5
 a2c:	06c00793          	li	a5,108
 a30:	04f71863          	bne	a4,a5,a80 <vprintf+0x276>
 a34:	fe442783          	lw	a5,-28(s0)
 a38:	0007871b          	sext.w	a4,a5
 a3c:	06c00793          	li	a5,108
 a40:	04f71063          	bne	a4,a5,a80 <vprintf+0x276>
 a44:	fe042783          	lw	a5,-32(s0)
 a48:	0007871b          	sext.w	a4,a5
 a4c:	07500793          	li	a5,117
 a50:	02f71863          	bne	a4,a5,a80 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a54:	fb843783          	ld	a5,-72(s0)
 a58:	00878713          	addi	a4,a5,8
 a5c:	fae43c23          	sd	a4,-72(s0)
 a60:	639c                	ld	a5,0(a5)
 a62:	873e                	mv	a4,a5
 a64:	fcc42783          	lw	a5,-52(s0)
 a68:	4681                	li	a3,0
 a6a:	4629                	li	a2,10
 a6c:	85ba                	mv	a1,a4
 a6e:	853e                	mv	a0,a5
 a70:	c2bff0ef          	jal	69a <printint>
        i += 2;
 a74:	fdc42783          	lw	a5,-36(s0)
 a78:	2789                	addiw	a5,a5,2
 a7a:	fcf42e23          	sw	a5,-36(s0)
 a7e:	aaf9                	j	c5c <vprintf+0x452>
      } else if(c0 == 'x'){
 a80:	fd442783          	lw	a5,-44(s0)
 a84:	0007871b          	sext.w	a4,a5
 a88:	07800793          	li	a5,120
 a8c:	02f71563          	bne	a4,a5,ab6 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a90:	fb843783          	ld	a5,-72(s0)
 a94:	00878713          	addi	a4,a5,8
 a98:	fae43c23          	sd	a4,-72(s0)
 a9c:	439c                	lw	a5,0(a5)
 a9e:	02079713          	slli	a4,a5,0x20
 aa2:	9301                	srli	a4,a4,0x20
 aa4:	fcc42783          	lw	a5,-52(s0)
 aa8:	4681                	li	a3,0
 aaa:	4641                	li	a2,16
 aac:	85ba                	mv	a1,a4
 aae:	853e                	mv	a0,a5
 ab0:	bebff0ef          	jal	69a <printint>
 ab4:	a265                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 ab6:	fd442783          	lw	a5,-44(s0)
 aba:	0007871b          	sext.w	a4,a5
 abe:	06c00793          	li	a5,108
 ac2:	04f71063          	bne	a4,a5,b02 <vprintf+0x2f8>
 ac6:	fe442783          	lw	a5,-28(s0)
 aca:	0007871b          	sext.w	a4,a5
 ace:	07800793          	li	a5,120
 ad2:	02f71863          	bne	a4,a5,b02 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad6:	fb843783          	ld	a5,-72(s0)
 ada:	00878713          	addi	a4,a5,8
 ade:	fae43c23          	sd	a4,-72(s0)
 ae2:	639c                	ld	a5,0(a5)
 ae4:	873e                	mv	a4,a5
 ae6:	fcc42783          	lw	a5,-52(s0)
 aea:	4681                	li	a3,0
 aec:	4641                	li	a2,16
 aee:	85ba                	mv	a1,a4
 af0:	853e                	mv	a0,a5
 af2:	ba9ff0ef          	jal	69a <printint>
        i += 1;
 af6:	fdc42783          	lw	a5,-36(s0)
 afa:	2785                	addiw	a5,a5,1
 afc:	fcf42e23          	sw	a5,-36(s0)
 b00:	aab1                	j	c5c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 b02:	fd442783          	lw	a5,-44(s0)
 b06:	0007871b          	sext.w	a4,a5
 b0a:	06c00793          	li	a5,108
 b0e:	04f71863          	bne	a4,a5,b5e <vprintf+0x354>
 b12:	fe442783          	lw	a5,-28(s0)
 b16:	0007871b          	sext.w	a4,a5
 b1a:	06c00793          	li	a5,108
 b1e:	04f71063          	bne	a4,a5,b5e <vprintf+0x354>
 b22:	fe042783          	lw	a5,-32(s0)
 b26:	0007871b          	sext.w	a4,a5
 b2a:	07800793          	li	a5,120
 b2e:	02f71863          	bne	a4,a5,b5e <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b32:	fb843783          	ld	a5,-72(s0)
 b36:	00878713          	addi	a4,a5,8
 b3a:	fae43c23          	sd	a4,-72(s0)
 b3e:	639c                	ld	a5,0(a5)
 b40:	873e                	mv	a4,a5
 b42:	fcc42783          	lw	a5,-52(s0)
 b46:	4681                	li	a3,0
 b48:	4641                	li	a2,16
 b4a:	85ba                	mv	a1,a4
 b4c:	853e                	mv	a0,a5
 b4e:	b4dff0ef          	jal	69a <printint>
        i += 2;
 b52:	fdc42783          	lw	a5,-36(s0)
 b56:	2789                	addiw	a5,a5,2
 b58:	fcf42e23          	sw	a5,-36(s0)
 b5c:	a201                	j	c5c <vprintf+0x452>
      } else if(c0 == 'p'){
 b5e:	fd442783          	lw	a5,-44(s0)
 b62:	0007871b          	sext.w	a4,a5
 b66:	07000793          	li	a5,112
 b6a:	02f71063          	bne	a4,a5,b8a <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b6e:	fb843783          	ld	a5,-72(s0)
 b72:	00878713          	addi	a4,a5,8
 b76:	fae43c23          	sd	a4,-72(s0)
 b7a:	6398                	ld	a4,0(a5)
 b7c:	fcc42783          	lw	a5,-52(s0)
 b80:	85ba                	mv	a1,a4
 b82:	853e                	mv	a0,a5
 b84:	c09ff0ef          	jal	78c <printptr>
 b88:	a8d1                	j	c5c <vprintf+0x452>
      } else if(c0 == 'c'){
 b8a:	fd442783          	lw	a5,-44(s0)
 b8e:	0007871b          	sext.w	a4,a5
 b92:	06300793          	li	a5,99
 b96:	02f71263          	bne	a4,a5,bba <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b9a:	fb843783          	ld	a5,-72(s0)
 b9e:	00878713          	addi	a4,a5,8
 ba2:	fae43c23          	sd	a4,-72(s0)
 ba6:	439c                	lw	a5,0(a5)
 ba8:	0ff7f713          	zext.b	a4,a5
 bac:	fcc42783          	lw	a5,-52(s0)
 bb0:	85ba                	mv	a1,a4
 bb2:	853e                	mv	a0,a5
 bb4:	ab5ff0ef          	jal	668 <putc>
 bb8:	a055                	j	c5c <vprintf+0x452>
      } else if(c0 == 's'){
 bba:	fd442783          	lw	a5,-44(s0)
 bbe:	0007871b          	sext.w	a4,a5
 bc2:	07300793          	li	a5,115
 bc6:	04f71a63          	bne	a4,a5,c1a <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 bca:	fb843783          	ld	a5,-72(s0)
 bce:	00878713          	addi	a4,a5,8
 bd2:	fae43c23          	sd	a4,-72(s0)
 bd6:	639c                	ld	a5,0(a5)
 bd8:	fef43423          	sd	a5,-24(s0)
 bdc:	fe843783          	ld	a5,-24(s0)
 be0:	e79d                	bnez	a5,c0e <vprintf+0x404>
          s = "(null)";
 be2:	00000797          	auipc	a5,0x0
 be6:	42e78793          	addi	a5,a5,1070 # 1010 <malloc+0x14c>
 bea:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 bee:	a005                	j	c0e <vprintf+0x404>
          putc(fd, *s);
 bf0:	fe843783          	ld	a5,-24(s0)
 bf4:	0007c703          	lbu	a4,0(a5)
 bf8:	fcc42783          	lw	a5,-52(s0)
 bfc:	85ba                	mv	a1,a4
 bfe:	853e                	mv	a0,a5
 c00:	a69ff0ef          	jal	668 <putc>
        for(; *s; s++)
 c04:	fe843783          	ld	a5,-24(s0)
 c08:	0785                	addi	a5,a5,1
 c0a:	fef43423          	sd	a5,-24(s0)
 c0e:	fe843783          	ld	a5,-24(s0)
 c12:	0007c783          	lbu	a5,0(a5)
 c16:	ffe9                	bnez	a5,bf0 <vprintf+0x3e6>
 c18:	a091                	j	c5c <vprintf+0x452>
      } else if(c0 == '%'){
 c1a:	fd442783          	lw	a5,-44(s0)
 c1e:	0007871b          	sext.w	a4,a5
 c22:	02500793          	li	a5,37
 c26:	00f71a63          	bne	a4,a5,c3a <vprintf+0x430>
        putc(fd, '%');
 c2a:	fcc42783          	lw	a5,-52(s0)
 c2e:	02500593          	li	a1,37
 c32:	853e                	mv	a0,a5
 c34:	a35ff0ef          	jal	668 <putc>
 c38:	a015                	j	c5c <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c3a:	fcc42783          	lw	a5,-52(s0)
 c3e:	02500593          	li	a1,37
 c42:	853e                	mv	a0,a5
 c44:	a25ff0ef          	jal	668 <putc>
        putc(fd, c0);
 c48:	fd442783          	lw	a5,-44(s0)
 c4c:	0ff7f713          	zext.b	a4,a5
 c50:	fcc42783          	lw	a5,-52(s0)
 c54:	85ba                	mv	a1,a4
 c56:	853e                	mv	a0,a5
 c58:	a11ff0ef          	jal	668 <putc>
      }

      state = 0;
 c5c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c60:	fdc42783          	lw	a5,-36(s0)
 c64:	2785                	addiw	a5,a5,1
 c66:	fcf42e23          	sw	a5,-36(s0)
 c6a:	fdc42783          	lw	a5,-36(s0)
 c6e:	fc043703          	ld	a4,-64(s0)
 c72:	97ba                	add	a5,a5,a4
 c74:	0007c783          	lbu	a5,0(a5)
 c78:	ba0799e3          	bnez	a5,82a <vprintf+0x20>
    }
  }
}
 c7c:	0001                	nop
 c7e:	0001                	nop
 c80:	60a6                	ld	ra,72(sp)
 c82:	6406                	ld	s0,64(sp)
 c84:	6161                	addi	sp,sp,80
 c86:	8082                	ret

0000000000000c88 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c88:	7159                	addi	sp,sp,-112
 c8a:	fc06                	sd	ra,56(sp)
 c8c:	f822                	sd	s0,48(sp)
 c8e:	0080                	addi	s0,sp,64
 c90:	fcb43823          	sd	a1,-48(s0)
 c94:	e010                	sd	a2,0(s0)
 c96:	e414                	sd	a3,8(s0)
 c98:	e818                	sd	a4,16(s0)
 c9a:	ec1c                	sd	a5,24(s0)
 c9c:	03043023          	sd	a6,32(s0)
 ca0:	03143423          	sd	a7,40(s0)
 ca4:	87aa                	mv	a5,a0
 ca6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 caa:	03040793          	addi	a5,s0,48
 cae:	fcf43423          	sd	a5,-56(s0)
 cb2:	fc843783          	ld	a5,-56(s0)
 cb6:	fd078793          	addi	a5,a5,-48
 cba:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 cbe:	fe843703          	ld	a4,-24(s0)
 cc2:	fdc42783          	lw	a5,-36(s0)
 cc6:	863a                	mv	a2,a4
 cc8:	fd043583          	ld	a1,-48(s0)
 ccc:	853e                	mv	a0,a5
 cce:	b3dff0ef          	jal	80a <vprintf>
}
 cd2:	0001                	nop
 cd4:	70e2                	ld	ra,56(sp)
 cd6:	7442                	ld	s0,48(sp)
 cd8:	6165                	addi	sp,sp,112
 cda:	8082                	ret

0000000000000cdc <printf>:

void
printf(const char *fmt, ...)
{
 cdc:	7159                	addi	sp,sp,-112
 cde:	f406                	sd	ra,40(sp)
 ce0:	f022                	sd	s0,32(sp)
 ce2:	1800                	addi	s0,sp,48
 ce4:	fca43c23          	sd	a0,-40(s0)
 ce8:	e40c                	sd	a1,8(s0)
 cea:	e810                	sd	a2,16(s0)
 cec:	ec14                	sd	a3,24(s0)
 cee:	f018                	sd	a4,32(s0)
 cf0:	f41c                	sd	a5,40(s0)
 cf2:	03043823          	sd	a6,48(s0)
 cf6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cfa:	04040793          	addi	a5,s0,64
 cfe:	fcf43823          	sd	a5,-48(s0)
 d02:	fd043783          	ld	a5,-48(s0)
 d06:	fc878793          	addi	a5,a5,-56
 d0a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 d0e:	fe843783          	ld	a5,-24(s0)
 d12:	863e                	mv	a2,a5
 d14:	fd843583          	ld	a1,-40(s0)
 d18:	4505                	li	a0,1
 d1a:	af1ff0ef          	jal	80a <vprintf>
}
 d1e:	0001                	nop
 d20:	70a2                	ld	ra,40(sp)
 d22:	7402                	ld	s0,32(sp)
 d24:	6165                	addi	sp,sp,112
 d26:	8082                	ret

0000000000000d28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d28:	7179                	addi	sp,sp,-48
 d2a:	f406                	sd	ra,40(sp)
 d2c:	f022                	sd	s0,32(sp)
 d2e:	1800                	addi	s0,sp,48
 d30:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d34:	fd843783          	ld	a5,-40(s0)
 d38:	17c1                	addi	a5,a5,-16
 d3a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d3e:	00001797          	auipc	a5,0x1
 d42:	2f278793          	addi	a5,a5,754 # 2030 <freep>
 d46:	639c                	ld	a5,0(a5)
 d48:	fef43423          	sd	a5,-24(s0)
 d4c:	a815                	j	d80 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d4e:	fe843783          	ld	a5,-24(s0)
 d52:	639c                	ld	a5,0(a5)
 d54:	fe843703          	ld	a4,-24(s0)
 d58:	00f76f63          	bltu	a4,a5,d76 <free+0x4e>
 d5c:	fe043703          	ld	a4,-32(s0)
 d60:	fe843783          	ld	a5,-24(s0)
 d64:	02e7eb63          	bltu	a5,a4,d9a <free+0x72>
 d68:	fe843783          	ld	a5,-24(s0)
 d6c:	639c                	ld	a5,0(a5)
 d6e:	fe043703          	ld	a4,-32(s0)
 d72:	02f76463          	bltu	a4,a5,d9a <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d76:	fe843783          	ld	a5,-24(s0)
 d7a:	639c                	ld	a5,0(a5)
 d7c:	fef43423          	sd	a5,-24(s0)
 d80:	fe043703          	ld	a4,-32(s0)
 d84:	fe843783          	ld	a5,-24(s0)
 d88:	fce7f3e3          	bgeu	a5,a4,d4e <free+0x26>
 d8c:	fe843783          	ld	a5,-24(s0)
 d90:	639c                	ld	a5,0(a5)
 d92:	fe043703          	ld	a4,-32(s0)
 d96:	faf77ce3          	bgeu	a4,a5,d4e <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d9a:	fe043783          	ld	a5,-32(s0)
 d9e:	479c                	lw	a5,8(a5)
 da0:	1782                	slli	a5,a5,0x20
 da2:	9381                	srli	a5,a5,0x20
 da4:	0792                	slli	a5,a5,0x4
 da6:	fe043703          	ld	a4,-32(s0)
 daa:	973e                	add	a4,a4,a5
 dac:	fe843783          	ld	a5,-24(s0)
 db0:	639c                	ld	a5,0(a5)
 db2:	02f71763          	bne	a4,a5,de0 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 db6:	fe043783          	ld	a5,-32(s0)
 dba:	4798                	lw	a4,8(a5)
 dbc:	fe843783          	ld	a5,-24(s0)
 dc0:	639c                	ld	a5,0(a5)
 dc2:	479c                	lw	a5,8(a5)
 dc4:	9fb9                	addw	a5,a5,a4
 dc6:	0007871b          	sext.w	a4,a5
 dca:	fe043783          	ld	a5,-32(s0)
 dce:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 dd0:	fe843783          	ld	a5,-24(s0)
 dd4:	639c                	ld	a5,0(a5)
 dd6:	6398                	ld	a4,0(a5)
 dd8:	fe043783          	ld	a5,-32(s0)
 ddc:	e398                	sd	a4,0(a5)
 dde:	a039                	j	dec <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 de0:	fe843783          	ld	a5,-24(s0)
 de4:	6398                	ld	a4,0(a5)
 de6:	fe043783          	ld	a5,-32(s0)
 dea:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 dec:	fe843783          	ld	a5,-24(s0)
 df0:	479c                	lw	a5,8(a5)
 df2:	1782                	slli	a5,a5,0x20
 df4:	9381                	srli	a5,a5,0x20
 df6:	0792                	slli	a5,a5,0x4
 df8:	fe843703          	ld	a4,-24(s0)
 dfc:	97ba                	add	a5,a5,a4
 dfe:	fe043703          	ld	a4,-32(s0)
 e02:	02f71563          	bne	a4,a5,e2c <free+0x104>
    p->s.size += bp->s.size;
 e06:	fe843783          	ld	a5,-24(s0)
 e0a:	4798                	lw	a4,8(a5)
 e0c:	fe043783          	ld	a5,-32(s0)
 e10:	479c                	lw	a5,8(a5)
 e12:	9fb9                	addw	a5,a5,a4
 e14:	0007871b          	sext.w	a4,a5
 e18:	fe843783          	ld	a5,-24(s0)
 e1c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 e1e:	fe043783          	ld	a5,-32(s0)
 e22:	6398                	ld	a4,0(a5)
 e24:	fe843783          	ld	a5,-24(s0)
 e28:	e398                	sd	a4,0(a5)
 e2a:	a031                	j	e36 <free+0x10e>
  } else
    p->s.ptr = bp;
 e2c:	fe843783          	ld	a5,-24(s0)
 e30:	fe043703          	ld	a4,-32(s0)
 e34:	e398                	sd	a4,0(a5)
  freep = p;
 e36:	00001797          	auipc	a5,0x1
 e3a:	1fa78793          	addi	a5,a5,506 # 2030 <freep>
 e3e:	fe843703          	ld	a4,-24(s0)
 e42:	e398                	sd	a4,0(a5)
}
 e44:	0001                	nop
 e46:	70a2                	ld	ra,40(sp)
 e48:	7402                	ld	s0,32(sp)
 e4a:	6145                	addi	sp,sp,48
 e4c:	8082                	ret

0000000000000e4e <morecore>:

static Header*
morecore(uint nu)
{
 e4e:	7179                	addi	sp,sp,-48
 e50:	f406                	sd	ra,40(sp)
 e52:	f022                	sd	s0,32(sp)
 e54:	1800                	addi	s0,sp,48
 e56:	87aa                	mv	a5,a0
 e58:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e5c:	fdc42783          	lw	a5,-36(s0)
 e60:	0007871b          	sext.w	a4,a5
 e64:	6785                	lui	a5,0x1
 e66:	00f77563          	bgeu	a4,a5,e70 <morecore+0x22>
    nu = 4096;
 e6a:	6785                	lui	a5,0x1
 e6c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e70:	fdc42783          	lw	a5,-36(s0)
 e74:	0047979b          	slliw	a5,a5,0x4
 e78:	2781                	sext.w	a5,a5
 e7a:	853e                	mv	a0,a5
 e7c:	ee8ff0ef          	jal	564 <sbrk>
 e80:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e84:	fe843703          	ld	a4,-24(s0)
 e88:	57fd                	li	a5,-1
 e8a:	00f71463          	bne	a4,a5,e92 <morecore+0x44>
    return 0;
 e8e:	4781                	li	a5,0
 e90:	a02d                	j	eba <morecore+0x6c>
  hp = (Header*)p;
 e92:	fe843783          	ld	a5,-24(s0)
 e96:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e9a:	fe043783          	ld	a5,-32(s0)
 e9e:	fdc42703          	lw	a4,-36(s0)
 ea2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 ea4:	fe043783          	ld	a5,-32(s0)
 ea8:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x14c>
 eaa:	853e                	mv	a0,a5
 eac:	e7dff0ef          	jal	d28 <free>
  return freep;
 eb0:	00001797          	auipc	a5,0x1
 eb4:	18078793          	addi	a5,a5,384 # 2030 <freep>
 eb8:	639c                	ld	a5,0(a5)
}
 eba:	853e                	mv	a0,a5
 ebc:	70a2                	ld	ra,40(sp)
 ebe:	7402                	ld	s0,32(sp)
 ec0:	6145                	addi	sp,sp,48
 ec2:	8082                	ret

0000000000000ec4 <malloc>:

void*
malloc(uint nbytes)
{
 ec4:	7139                	addi	sp,sp,-64
 ec6:	fc06                	sd	ra,56(sp)
 ec8:	f822                	sd	s0,48(sp)
 eca:	0080                	addi	s0,sp,64
 ecc:	87aa                	mv	a5,a0
 ece:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ed2:	fcc46783          	lwu	a5,-52(s0)
 ed6:	07bd                	addi	a5,a5,15
 ed8:	8391                	srli	a5,a5,0x4
 eda:	2781                	sext.w	a5,a5
 edc:	2785                	addiw	a5,a5,1
 ede:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ee2:	00001797          	auipc	a5,0x1
 ee6:	14e78793          	addi	a5,a5,334 # 2030 <freep>
 eea:	639c                	ld	a5,0(a5)
 eec:	fef43023          	sd	a5,-32(s0)
 ef0:	fe043783          	ld	a5,-32(s0)
 ef4:	ef95                	bnez	a5,f30 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ef6:	00001797          	auipc	a5,0x1
 efa:	12a78793          	addi	a5,a5,298 # 2020 <base>
 efe:	fef43023          	sd	a5,-32(s0)
 f02:	00001797          	auipc	a5,0x1
 f06:	12e78793          	addi	a5,a5,302 # 2030 <freep>
 f0a:	fe043703          	ld	a4,-32(s0)
 f0e:	e398                	sd	a4,0(a5)
 f10:	00001797          	auipc	a5,0x1
 f14:	12078793          	addi	a5,a5,288 # 2030 <freep>
 f18:	6398                	ld	a4,0(a5)
 f1a:	00001797          	auipc	a5,0x1
 f1e:	10678793          	addi	a5,a5,262 # 2020 <base>
 f22:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 f24:	00001797          	auipc	a5,0x1
 f28:	0fc78793          	addi	a5,a5,252 # 2020 <base>
 f2c:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f30:	fe043783          	ld	a5,-32(s0)
 f34:	639c                	ld	a5,0(a5)
 f36:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f3a:	fe843783          	ld	a5,-24(s0)
 f3e:	479c                	lw	a5,8(a5)
 f40:	fdc42703          	lw	a4,-36(s0)
 f44:	2701                	sext.w	a4,a4
 f46:	06e7e763          	bltu	a5,a4,fb4 <malloc+0xf0>
      if(p->s.size == nunits)
 f4a:	fe843783          	ld	a5,-24(s0)
 f4e:	479c                	lw	a5,8(a5)
 f50:	fdc42703          	lw	a4,-36(s0)
 f54:	2701                	sext.w	a4,a4
 f56:	00f71963          	bne	a4,a5,f68 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f5a:	fe843783          	ld	a5,-24(s0)
 f5e:	6398                	ld	a4,0(a5)
 f60:	fe043783          	ld	a5,-32(s0)
 f64:	e398                	sd	a4,0(a5)
 f66:	a825                	j	f9e <malloc+0xda>
      else {
        p->s.size -= nunits;
 f68:	fe843783          	ld	a5,-24(s0)
 f6c:	479c                	lw	a5,8(a5)
 f6e:	fdc42703          	lw	a4,-36(s0)
 f72:	9f99                	subw	a5,a5,a4
 f74:	0007871b          	sext.w	a4,a5
 f78:	fe843783          	ld	a5,-24(s0)
 f7c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f7e:	fe843783          	ld	a5,-24(s0)
 f82:	479c                	lw	a5,8(a5)
 f84:	1782                	slli	a5,a5,0x20
 f86:	9381                	srli	a5,a5,0x20
 f88:	0792                	slli	a5,a5,0x4
 f8a:	fe843703          	ld	a4,-24(s0)
 f8e:	97ba                	add	a5,a5,a4
 f90:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f94:	fe843783          	ld	a5,-24(s0)
 f98:	fdc42703          	lw	a4,-36(s0)
 f9c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f9e:	00001797          	auipc	a5,0x1
 fa2:	09278793          	addi	a5,a5,146 # 2030 <freep>
 fa6:	fe043703          	ld	a4,-32(s0)
 faa:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 fac:	fe843783          	ld	a5,-24(s0)
 fb0:	07c1                	addi	a5,a5,16
 fb2:	a081                	j	ff2 <malloc+0x12e>
    }
    if(p == freep)
 fb4:	00001797          	auipc	a5,0x1
 fb8:	07c78793          	addi	a5,a5,124 # 2030 <freep>
 fbc:	639c                	ld	a5,0(a5)
 fbe:	fe843703          	ld	a4,-24(s0)
 fc2:	00f71e63          	bne	a4,a5,fde <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 fc6:	fdc42783          	lw	a5,-36(s0)
 fca:	853e                	mv	a0,a5
 fcc:	e83ff0ef          	jal	e4e <morecore>
 fd0:	fea43423          	sd	a0,-24(s0)
 fd4:	fe843783          	ld	a5,-24(s0)
 fd8:	e399                	bnez	a5,fde <malloc+0x11a>
        return 0;
 fda:	4781                	li	a5,0
 fdc:	a819                	j	ff2 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fde:	fe843783          	ld	a5,-24(s0)
 fe2:	fef43023          	sd	a5,-32(s0)
 fe6:	fe843783          	ld	a5,-24(s0)
 fea:	639c                	ld	a5,0(a5)
 fec:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 ff0:	b7a9                	j	f3a <malloc+0x76>
  }
}
 ff2:	853e                	mv	a0,a5
 ff4:	70e2                	ld	ra,56(sp)
 ff6:	7442                	ld	s0,48(sp)
 ff8:	6121                	addi	sp,sp,64
 ffa:	8082                	ret
