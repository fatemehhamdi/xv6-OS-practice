
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
  62:	fa258593          	addi	a1,a1,-94 # 1000 <malloc+0x144>
  66:	4505                	li	a0,1
  68:	570000ef          	jal	5d8 <write>
  6c:	a809                	j	7e <main+0x7e>
    } else {
      write(1, "\n", 1);
  6e:	4605                	li	a2,1
  70:	00001597          	auipc	a1,0x1
  74:	f9858593          	addi	a1,a1,-104 # 1008 <malloc+0x14c>
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

0000000000000660 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 660:	1101                	addi	sp,sp,-32
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	87aa                	mv	a5,a0
 66a:	872e                	mv	a4,a1
 66c:	fef42623          	sw	a5,-20(s0)
 670:	87ba                	mv	a5,a4
 672:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 676:	feb40713          	addi	a4,s0,-21
 67a:	fec42783          	lw	a5,-20(s0)
 67e:	4605                	li	a2,1
 680:	85ba                	mv	a1,a4
 682:	853e                	mv	a0,a5
 684:	f55ff0ef          	jal	5d8 <write>
}
 688:	0001                	nop
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6105                	addi	sp,sp,32
 690:	8082                	ret

0000000000000692 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 692:	711d                	addi	sp,sp,-96
 694:	ec86                	sd	ra,88(sp)
 696:	e8a2                	sd	s0,80(sp)
 698:	1080                	addi	s0,sp,96
 69a:	87aa                	mv	a5,a0
 69c:	fab43823          	sd	a1,-80(s0)
 6a0:	8736                	mv	a4,a3
 6a2:	faf42e23          	sw	a5,-68(s0)
 6a6:	87b2                	mv	a5,a2
 6a8:	faf42c23          	sw	a5,-72(s0)
 6ac:	87ba                	mv	a5,a4
 6ae:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 6b2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6b6:	fac42783          	lw	a5,-84(s0)
 6ba:	2781                	sext.w	a5,a5
 6bc:	cf99                	beqz	a5,6da <printint+0x48>
 6be:	fb043783          	ld	a5,-80(s0)
 6c2:	0007dc63          	bgez	a5,6da <printint+0x48>
    neg = 1;
 6c6:	4785                	li	a5,1
 6c8:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6cc:	fb043783          	ld	a5,-80(s0)
 6d0:	40f007b3          	neg	a5,a5
 6d4:	fef43023          	sd	a5,-32(s0)
 6d8:	a029                	j	6e2 <printint+0x50>
  } else {
    x = xx;
 6da:	fb043783          	ld	a5,-80(s0)
 6de:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6e2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6e6:	fb842783          	lw	a5,-72(s0)
 6ea:	fe043703          	ld	a4,-32(s0)
 6ee:	02f77733          	remu	a4,a4,a5
 6f2:	fec42783          	lw	a5,-20(s0)
 6f6:	0017869b          	addiw	a3,a5,1
 6fa:	fed42623          	sw	a3,-20(s0)
 6fe:	00002697          	auipc	a3,0x2
 702:	90268693          	addi	a3,a3,-1790 # 2000 <digits>
 706:	9736                	add	a4,a4,a3
 708:	00074703          	lbu	a4,0(a4)
 70c:	17c1                	addi	a5,a5,-16
 70e:	97a2                	add	a5,a5,s0
 710:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 714:	fb842783          	lw	a5,-72(s0)
 718:	fe043703          	ld	a4,-32(s0)
 71c:	02f757b3          	divu	a5,a4,a5
 720:	fef43023          	sd	a5,-32(s0)
 724:	fe043783          	ld	a5,-32(s0)
 728:	ffdd                	bnez	a5,6e6 <printint+0x54>
  if(neg)
 72a:	fe842783          	lw	a5,-24(s0)
 72e:	2781                	sext.w	a5,a5
 730:	cb95                	beqz	a5,764 <printint+0xd2>
    buf[i++] = '-';
 732:	fec42783          	lw	a5,-20(s0)
 736:	0017871b          	addiw	a4,a5,1
 73a:	fee42623          	sw	a4,-20(s0)
 73e:	17c1                	addi	a5,a5,-16
 740:	97a2                	add	a5,a5,s0
 742:	02d00713          	li	a4,45
 746:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 74a:	a829                	j	764 <printint+0xd2>
    putc(fd, buf[i]);
 74c:	fec42783          	lw	a5,-20(s0)
 750:	17c1                	addi	a5,a5,-16
 752:	97a2                	add	a5,a5,s0
 754:	fd87c703          	lbu	a4,-40(a5)
 758:	fbc42783          	lw	a5,-68(s0)
 75c:	85ba                	mv	a1,a4
 75e:	853e                	mv	a0,a5
 760:	f01ff0ef          	jal	660 <putc>
  while(--i >= 0)
 764:	fec42783          	lw	a5,-20(s0)
 768:	37fd                	addiw	a5,a5,-1
 76a:	fef42623          	sw	a5,-20(s0)
 76e:	fec42783          	lw	a5,-20(s0)
 772:	2781                	sext.w	a5,a5
 774:	fc07dce3          	bgez	a5,74c <printint+0xba>
}
 778:	0001                	nop
 77a:	0001                	nop
 77c:	60e6                	ld	ra,88(sp)
 77e:	6446                	ld	s0,80(sp)
 780:	6125                	addi	sp,sp,96
 782:	8082                	ret

0000000000000784 <printptr>:

static void
printptr(int fd, uint64 x) {
 784:	7179                	addi	sp,sp,-48
 786:	f406                	sd	ra,40(sp)
 788:	f022                	sd	s0,32(sp)
 78a:	1800                	addi	s0,sp,48
 78c:	87aa                	mv	a5,a0
 78e:	fcb43823          	sd	a1,-48(s0)
 792:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 796:	fdc42783          	lw	a5,-36(s0)
 79a:	03000593          	li	a1,48
 79e:	853e                	mv	a0,a5
 7a0:	ec1ff0ef          	jal	660 <putc>
  putc(fd, 'x');
 7a4:	fdc42783          	lw	a5,-36(s0)
 7a8:	07800593          	li	a1,120
 7ac:	853e                	mv	a0,a5
 7ae:	eb3ff0ef          	jal	660 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b2:	fe042623          	sw	zero,-20(s0)
 7b6:	a81d                	j	7ec <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b8:	fd043783          	ld	a5,-48(s0)
 7bc:	93f1                	srli	a5,a5,0x3c
 7be:	00002717          	auipc	a4,0x2
 7c2:	84270713          	addi	a4,a4,-1982 # 2000 <digits>
 7c6:	97ba                	add	a5,a5,a4
 7c8:	0007c703          	lbu	a4,0(a5)
 7cc:	fdc42783          	lw	a5,-36(s0)
 7d0:	85ba                	mv	a1,a4
 7d2:	853e                	mv	a0,a5
 7d4:	e8dff0ef          	jal	660 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d8:	fec42783          	lw	a5,-20(s0)
 7dc:	2785                	addiw	a5,a5,1
 7de:	fef42623          	sw	a5,-20(s0)
 7e2:	fd043783          	ld	a5,-48(s0)
 7e6:	0792                	slli	a5,a5,0x4
 7e8:	fcf43823          	sd	a5,-48(s0)
 7ec:	fec42703          	lw	a4,-20(s0)
 7f0:	47bd                	li	a5,15
 7f2:	fce7f3e3          	bgeu	a5,a4,7b8 <printptr+0x34>
}
 7f6:	0001                	nop
 7f8:	0001                	nop
 7fa:	70a2                	ld	ra,40(sp)
 7fc:	7402                	ld	s0,32(sp)
 7fe:	6145                	addi	sp,sp,48
 800:	8082                	ret

0000000000000802 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 802:	715d                	addi	sp,sp,-80
 804:	e486                	sd	ra,72(sp)
 806:	e0a2                	sd	s0,64(sp)
 808:	0880                	addi	s0,sp,80
 80a:	87aa                	mv	a5,a0
 80c:	fcb43023          	sd	a1,-64(s0)
 810:	fac43c23          	sd	a2,-72(s0)
 814:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 818:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 81c:	fc042e23          	sw	zero,-36(s0)
 820:	a189                	j	c62 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 822:	fdc42783          	lw	a5,-36(s0)
 826:	fc043703          	ld	a4,-64(s0)
 82a:	97ba                	add	a5,a5,a4
 82c:	0007c783          	lbu	a5,0(a5)
 830:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 834:	fd842783          	lw	a5,-40(s0)
 838:	2781                	sext.w	a5,a5
 83a:	eb8d                	bnez	a5,86c <vprintf+0x6a>
      if(c0 == '%'){
 83c:	fd442783          	lw	a5,-44(s0)
 840:	0007871b          	sext.w	a4,a5
 844:	02500793          	li	a5,37
 848:	00f71763          	bne	a4,a5,856 <vprintf+0x54>
        state = '%';
 84c:	02500793          	li	a5,37
 850:	fcf42c23          	sw	a5,-40(s0)
 854:	a111                	j	c58 <vprintf+0x456>
      } else {
        putc(fd, c0);
 856:	fd442783          	lw	a5,-44(s0)
 85a:	0ff7f713          	zext.b	a4,a5
 85e:	fcc42783          	lw	a5,-52(s0)
 862:	85ba                	mv	a1,a4
 864:	853e                	mv	a0,a5
 866:	dfbff0ef          	jal	660 <putc>
 86a:	a6fd                	j	c58 <vprintf+0x456>
      }
    } else if(state == '%'){
 86c:	fd842783          	lw	a5,-40(s0)
 870:	0007871b          	sext.w	a4,a5
 874:	02500793          	li	a5,37
 878:	3ef71063          	bne	a4,a5,c58 <vprintf+0x456>
      c1 = c2 = 0;
 87c:	fe042023          	sw	zero,-32(s0)
 880:	fe042783          	lw	a5,-32(s0)
 884:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 888:	fd442783          	lw	a5,-44(s0)
 88c:	2781                	sext.w	a5,a5
 88e:	cb99                	beqz	a5,8a4 <vprintf+0xa2>
 890:	fdc42783          	lw	a5,-36(s0)
 894:	0785                	addi	a5,a5,1
 896:	fc043703          	ld	a4,-64(s0)
 89a:	97ba                	add	a5,a5,a4
 89c:	0007c783          	lbu	a5,0(a5)
 8a0:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 8a4:	fe442783          	lw	a5,-28(s0)
 8a8:	2781                	sext.w	a5,a5
 8aa:	cb99                	beqz	a5,8c0 <vprintf+0xbe>
 8ac:	fdc42783          	lw	a5,-36(s0)
 8b0:	0789                	addi	a5,a5,2
 8b2:	fc043703          	ld	a4,-64(s0)
 8b6:	97ba                	add	a5,a5,a4
 8b8:	0007c783          	lbu	a5,0(a5)
 8bc:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 8c0:	fd442783          	lw	a5,-44(s0)
 8c4:	0007871b          	sext.w	a4,a5
 8c8:	06400793          	li	a5,100
 8cc:	02f71363          	bne	a4,a5,8f2 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8d0:	fb843783          	ld	a5,-72(s0)
 8d4:	00878713          	addi	a4,a5,8
 8d8:	fae43c23          	sd	a4,-72(s0)
 8dc:	439c                	lw	a5,0(a5)
 8de:	873e                	mv	a4,a5
 8e0:	fcc42783          	lw	a5,-52(s0)
 8e4:	4685                	li	a3,1
 8e6:	4629                	li	a2,10
 8e8:	85ba                	mv	a1,a4
 8ea:	853e                	mv	a0,a5
 8ec:	da7ff0ef          	jal	692 <printint>
 8f0:	a695                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8f2:	fd442783          	lw	a5,-44(s0)
 8f6:	0007871b          	sext.w	a4,a5
 8fa:	06c00793          	li	a5,108
 8fe:	04f71063          	bne	a4,a5,93e <vprintf+0x13c>
 902:	fe442783          	lw	a5,-28(s0)
 906:	0007871b          	sext.w	a4,a5
 90a:	06400793          	li	a5,100
 90e:	02f71863          	bne	a4,a5,93e <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 912:	fb843783          	ld	a5,-72(s0)
 916:	00878713          	addi	a4,a5,8
 91a:	fae43c23          	sd	a4,-72(s0)
 91e:	639c                	ld	a5,0(a5)
 920:	873e                	mv	a4,a5
 922:	fcc42783          	lw	a5,-52(s0)
 926:	4685                	li	a3,1
 928:	4629                	li	a2,10
 92a:	85ba                	mv	a1,a4
 92c:	853e                	mv	a0,a5
 92e:	d65ff0ef          	jal	692 <printint>
        i += 1;
 932:	fdc42783          	lw	a5,-36(s0)
 936:	2785                	addiw	a5,a5,1
 938:	fcf42e23          	sw	a5,-36(s0)
 93c:	ae21                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 93e:	fd442783          	lw	a5,-44(s0)
 942:	0007871b          	sext.w	a4,a5
 946:	06c00793          	li	a5,108
 94a:	04f71863          	bne	a4,a5,99a <vprintf+0x198>
 94e:	fe442783          	lw	a5,-28(s0)
 952:	0007871b          	sext.w	a4,a5
 956:	06c00793          	li	a5,108
 95a:	04f71063          	bne	a4,a5,99a <vprintf+0x198>
 95e:	fe042783          	lw	a5,-32(s0)
 962:	0007871b          	sext.w	a4,a5
 966:	06400793          	li	a5,100
 96a:	02f71863          	bne	a4,a5,99a <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 96e:	fb843783          	ld	a5,-72(s0)
 972:	00878713          	addi	a4,a5,8
 976:	fae43c23          	sd	a4,-72(s0)
 97a:	639c                	ld	a5,0(a5)
 97c:	873e                	mv	a4,a5
 97e:	fcc42783          	lw	a5,-52(s0)
 982:	4685                	li	a3,1
 984:	4629                	li	a2,10
 986:	85ba                	mv	a1,a4
 988:	853e                	mv	a0,a5
 98a:	d09ff0ef          	jal	692 <printint>
        i += 2;
 98e:	fdc42783          	lw	a5,-36(s0)
 992:	2789                	addiw	a5,a5,2
 994:	fcf42e23          	sw	a5,-36(s0)
 998:	ac75                	j	c54 <vprintf+0x452>
      } else if(c0 == 'u'){
 99a:	fd442783          	lw	a5,-44(s0)
 99e:	0007871b          	sext.w	a4,a5
 9a2:	07500793          	li	a5,117
 9a6:	02f71563          	bne	a4,a5,9d0 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9aa:	fb843783          	ld	a5,-72(s0)
 9ae:	00878713          	addi	a4,a5,8
 9b2:	fae43c23          	sd	a4,-72(s0)
 9b6:	439c                	lw	a5,0(a5)
 9b8:	02079713          	slli	a4,a5,0x20
 9bc:	9301                	srli	a4,a4,0x20
 9be:	fcc42783          	lw	a5,-52(s0)
 9c2:	4681                	li	a3,0
 9c4:	4629                	li	a2,10
 9c6:	85ba                	mv	a1,a4
 9c8:	853e                	mv	a0,a5
 9ca:	cc9ff0ef          	jal	692 <printint>
 9ce:	a459                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9d0:	fd442783          	lw	a5,-44(s0)
 9d4:	0007871b          	sext.w	a4,a5
 9d8:	06c00793          	li	a5,108
 9dc:	04f71063          	bne	a4,a5,a1c <vprintf+0x21a>
 9e0:	fe442783          	lw	a5,-28(s0)
 9e4:	0007871b          	sext.w	a4,a5
 9e8:	07500793          	li	a5,117
 9ec:	02f71863          	bne	a4,a5,a1c <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f0:	fb843783          	ld	a5,-72(s0)
 9f4:	00878713          	addi	a4,a5,8
 9f8:	fae43c23          	sd	a4,-72(s0)
 9fc:	639c                	ld	a5,0(a5)
 9fe:	873e                	mv	a4,a5
 a00:	fcc42783          	lw	a5,-52(s0)
 a04:	4681                	li	a3,0
 a06:	4629                	li	a2,10
 a08:	85ba                	mv	a1,a4
 a0a:	853e                	mv	a0,a5
 a0c:	c87ff0ef          	jal	692 <printint>
        i += 1;
 a10:	fdc42783          	lw	a5,-36(s0)
 a14:	2785                	addiw	a5,a5,1
 a16:	fcf42e23          	sw	a5,-36(s0)
 a1a:	ac2d                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a1c:	fd442783          	lw	a5,-44(s0)
 a20:	0007871b          	sext.w	a4,a5
 a24:	06c00793          	li	a5,108
 a28:	04f71863          	bne	a4,a5,a78 <vprintf+0x276>
 a2c:	fe442783          	lw	a5,-28(s0)
 a30:	0007871b          	sext.w	a4,a5
 a34:	06c00793          	li	a5,108
 a38:	04f71063          	bne	a4,a5,a78 <vprintf+0x276>
 a3c:	fe042783          	lw	a5,-32(s0)
 a40:	0007871b          	sext.w	a4,a5
 a44:	07500793          	li	a5,117
 a48:	02f71863          	bne	a4,a5,a78 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a4c:	fb843783          	ld	a5,-72(s0)
 a50:	00878713          	addi	a4,a5,8
 a54:	fae43c23          	sd	a4,-72(s0)
 a58:	639c                	ld	a5,0(a5)
 a5a:	873e                	mv	a4,a5
 a5c:	fcc42783          	lw	a5,-52(s0)
 a60:	4681                	li	a3,0
 a62:	4629                	li	a2,10
 a64:	85ba                	mv	a1,a4
 a66:	853e                	mv	a0,a5
 a68:	c2bff0ef          	jal	692 <printint>
        i += 2;
 a6c:	fdc42783          	lw	a5,-36(s0)
 a70:	2789                	addiw	a5,a5,2
 a72:	fcf42e23          	sw	a5,-36(s0)
 a76:	aaf9                	j	c54 <vprintf+0x452>
      } else if(c0 == 'x'){
 a78:	fd442783          	lw	a5,-44(s0)
 a7c:	0007871b          	sext.w	a4,a5
 a80:	07800793          	li	a5,120
 a84:	02f71563          	bne	a4,a5,aae <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a88:	fb843783          	ld	a5,-72(s0)
 a8c:	00878713          	addi	a4,a5,8
 a90:	fae43c23          	sd	a4,-72(s0)
 a94:	439c                	lw	a5,0(a5)
 a96:	02079713          	slli	a4,a5,0x20
 a9a:	9301                	srli	a4,a4,0x20
 a9c:	fcc42783          	lw	a5,-52(s0)
 aa0:	4681                	li	a3,0
 aa2:	4641                	li	a2,16
 aa4:	85ba                	mv	a1,a4
 aa6:	853e                	mv	a0,a5
 aa8:	bebff0ef          	jal	692 <printint>
 aac:	a265                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 aae:	fd442783          	lw	a5,-44(s0)
 ab2:	0007871b          	sext.w	a4,a5
 ab6:	06c00793          	li	a5,108
 aba:	04f71063          	bne	a4,a5,afa <vprintf+0x2f8>
 abe:	fe442783          	lw	a5,-28(s0)
 ac2:	0007871b          	sext.w	a4,a5
 ac6:	07800793          	li	a5,120
 aca:	02f71863          	bne	a4,a5,afa <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ace:	fb843783          	ld	a5,-72(s0)
 ad2:	00878713          	addi	a4,a5,8
 ad6:	fae43c23          	sd	a4,-72(s0)
 ada:	639c                	ld	a5,0(a5)
 adc:	873e                	mv	a4,a5
 ade:	fcc42783          	lw	a5,-52(s0)
 ae2:	4681                	li	a3,0
 ae4:	4641                	li	a2,16
 ae6:	85ba                	mv	a1,a4
 ae8:	853e                	mv	a0,a5
 aea:	ba9ff0ef          	jal	692 <printint>
        i += 1;
 aee:	fdc42783          	lw	a5,-36(s0)
 af2:	2785                	addiw	a5,a5,1
 af4:	fcf42e23          	sw	a5,-36(s0)
 af8:	aab1                	j	c54 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 afa:	fd442783          	lw	a5,-44(s0)
 afe:	0007871b          	sext.w	a4,a5
 b02:	06c00793          	li	a5,108
 b06:	04f71863          	bne	a4,a5,b56 <vprintf+0x354>
 b0a:	fe442783          	lw	a5,-28(s0)
 b0e:	0007871b          	sext.w	a4,a5
 b12:	06c00793          	li	a5,108
 b16:	04f71063          	bne	a4,a5,b56 <vprintf+0x354>
 b1a:	fe042783          	lw	a5,-32(s0)
 b1e:	0007871b          	sext.w	a4,a5
 b22:	07800793          	li	a5,120
 b26:	02f71863          	bne	a4,a5,b56 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b2a:	fb843783          	ld	a5,-72(s0)
 b2e:	00878713          	addi	a4,a5,8
 b32:	fae43c23          	sd	a4,-72(s0)
 b36:	639c                	ld	a5,0(a5)
 b38:	873e                	mv	a4,a5
 b3a:	fcc42783          	lw	a5,-52(s0)
 b3e:	4681                	li	a3,0
 b40:	4641                	li	a2,16
 b42:	85ba                	mv	a1,a4
 b44:	853e                	mv	a0,a5
 b46:	b4dff0ef          	jal	692 <printint>
        i += 2;
 b4a:	fdc42783          	lw	a5,-36(s0)
 b4e:	2789                	addiw	a5,a5,2
 b50:	fcf42e23          	sw	a5,-36(s0)
 b54:	a201                	j	c54 <vprintf+0x452>
      } else if(c0 == 'p'){
 b56:	fd442783          	lw	a5,-44(s0)
 b5a:	0007871b          	sext.w	a4,a5
 b5e:	07000793          	li	a5,112
 b62:	02f71063          	bne	a4,a5,b82 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b66:	fb843783          	ld	a5,-72(s0)
 b6a:	00878713          	addi	a4,a5,8
 b6e:	fae43c23          	sd	a4,-72(s0)
 b72:	6398                	ld	a4,0(a5)
 b74:	fcc42783          	lw	a5,-52(s0)
 b78:	85ba                	mv	a1,a4
 b7a:	853e                	mv	a0,a5
 b7c:	c09ff0ef          	jal	784 <printptr>
 b80:	a8d1                	j	c54 <vprintf+0x452>
      } else if(c0 == 'c'){
 b82:	fd442783          	lw	a5,-44(s0)
 b86:	0007871b          	sext.w	a4,a5
 b8a:	06300793          	li	a5,99
 b8e:	02f71263          	bne	a4,a5,bb2 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b92:	fb843783          	ld	a5,-72(s0)
 b96:	00878713          	addi	a4,a5,8
 b9a:	fae43c23          	sd	a4,-72(s0)
 b9e:	439c                	lw	a5,0(a5)
 ba0:	0ff7f713          	zext.b	a4,a5
 ba4:	fcc42783          	lw	a5,-52(s0)
 ba8:	85ba                	mv	a1,a4
 baa:	853e                	mv	a0,a5
 bac:	ab5ff0ef          	jal	660 <putc>
 bb0:	a055                	j	c54 <vprintf+0x452>
      } else if(c0 == 's'){
 bb2:	fd442783          	lw	a5,-44(s0)
 bb6:	0007871b          	sext.w	a4,a5
 bba:	07300793          	li	a5,115
 bbe:	04f71a63          	bne	a4,a5,c12 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 bc2:	fb843783          	ld	a5,-72(s0)
 bc6:	00878713          	addi	a4,a5,8
 bca:	fae43c23          	sd	a4,-72(s0)
 bce:	639c                	ld	a5,0(a5)
 bd0:	fef43423          	sd	a5,-24(s0)
 bd4:	fe843783          	ld	a5,-24(s0)
 bd8:	e79d                	bnez	a5,c06 <vprintf+0x404>
          s = "(null)";
 bda:	00000797          	auipc	a5,0x0
 bde:	43678793          	addi	a5,a5,1078 # 1010 <malloc+0x154>
 be2:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 be6:	a005                	j	c06 <vprintf+0x404>
          putc(fd, *s);
 be8:	fe843783          	ld	a5,-24(s0)
 bec:	0007c703          	lbu	a4,0(a5)
 bf0:	fcc42783          	lw	a5,-52(s0)
 bf4:	85ba                	mv	a1,a4
 bf6:	853e                	mv	a0,a5
 bf8:	a69ff0ef          	jal	660 <putc>
        for(; *s; s++)
 bfc:	fe843783          	ld	a5,-24(s0)
 c00:	0785                	addi	a5,a5,1
 c02:	fef43423          	sd	a5,-24(s0)
 c06:	fe843783          	ld	a5,-24(s0)
 c0a:	0007c783          	lbu	a5,0(a5)
 c0e:	ffe9                	bnez	a5,be8 <vprintf+0x3e6>
 c10:	a091                	j	c54 <vprintf+0x452>
      } else if(c0 == '%'){
 c12:	fd442783          	lw	a5,-44(s0)
 c16:	0007871b          	sext.w	a4,a5
 c1a:	02500793          	li	a5,37
 c1e:	00f71a63          	bne	a4,a5,c32 <vprintf+0x430>
        putc(fd, '%');
 c22:	fcc42783          	lw	a5,-52(s0)
 c26:	02500593          	li	a1,37
 c2a:	853e                	mv	a0,a5
 c2c:	a35ff0ef          	jal	660 <putc>
 c30:	a015                	j	c54 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c32:	fcc42783          	lw	a5,-52(s0)
 c36:	02500593          	li	a1,37
 c3a:	853e                	mv	a0,a5
 c3c:	a25ff0ef          	jal	660 <putc>
        putc(fd, c0);
 c40:	fd442783          	lw	a5,-44(s0)
 c44:	0ff7f713          	zext.b	a4,a5
 c48:	fcc42783          	lw	a5,-52(s0)
 c4c:	85ba                	mv	a1,a4
 c4e:	853e                	mv	a0,a5
 c50:	a11ff0ef          	jal	660 <putc>
      }

      state = 0;
 c54:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c58:	fdc42783          	lw	a5,-36(s0)
 c5c:	2785                	addiw	a5,a5,1
 c5e:	fcf42e23          	sw	a5,-36(s0)
 c62:	fdc42783          	lw	a5,-36(s0)
 c66:	fc043703          	ld	a4,-64(s0)
 c6a:	97ba                	add	a5,a5,a4
 c6c:	0007c783          	lbu	a5,0(a5)
 c70:	ba0799e3          	bnez	a5,822 <vprintf+0x20>
    }
  }
}
 c74:	0001                	nop
 c76:	0001                	nop
 c78:	60a6                	ld	ra,72(sp)
 c7a:	6406                	ld	s0,64(sp)
 c7c:	6161                	addi	sp,sp,80
 c7e:	8082                	ret

0000000000000c80 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c80:	7159                	addi	sp,sp,-112
 c82:	fc06                	sd	ra,56(sp)
 c84:	f822                	sd	s0,48(sp)
 c86:	0080                	addi	s0,sp,64
 c88:	fcb43823          	sd	a1,-48(s0)
 c8c:	e010                	sd	a2,0(s0)
 c8e:	e414                	sd	a3,8(s0)
 c90:	e818                	sd	a4,16(s0)
 c92:	ec1c                	sd	a5,24(s0)
 c94:	03043023          	sd	a6,32(s0)
 c98:	03143423          	sd	a7,40(s0)
 c9c:	87aa                	mv	a5,a0
 c9e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ca2:	03040793          	addi	a5,s0,48
 ca6:	fcf43423          	sd	a5,-56(s0)
 caa:	fc843783          	ld	a5,-56(s0)
 cae:	fd078793          	addi	a5,a5,-48
 cb2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 cb6:	fe843703          	ld	a4,-24(s0)
 cba:	fdc42783          	lw	a5,-36(s0)
 cbe:	863a                	mv	a2,a4
 cc0:	fd043583          	ld	a1,-48(s0)
 cc4:	853e                	mv	a0,a5
 cc6:	b3dff0ef          	jal	802 <vprintf>
}
 cca:	0001                	nop
 ccc:	70e2                	ld	ra,56(sp)
 cce:	7442                	ld	s0,48(sp)
 cd0:	6165                	addi	sp,sp,112
 cd2:	8082                	ret

0000000000000cd4 <printf>:

void
printf(const char *fmt, ...)
{
 cd4:	7159                	addi	sp,sp,-112
 cd6:	f406                	sd	ra,40(sp)
 cd8:	f022                	sd	s0,32(sp)
 cda:	1800                	addi	s0,sp,48
 cdc:	fca43c23          	sd	a0,-40(s0)
 ce0:	e40c                	sd	a1,8(s0)
 ce2:	e810                	sd	a2,16(s0)
 ce4:	ec14                	sd	a3,24(s0)
 ce6:	f018                	sd	a4,32(s0)
 ce8:	f41c                	sd	a5,40(s0)
 cea:	03043823          	sd	a6,48(s0)
 cee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cf2:	04040793          	addi	a5,s0,64
 cf6:	fcf43823          	sd	a5,-48(s0)
 cfa:	fd043783          	ld	a5,-48(s0)
 cfe:	fc878793          	addi	a5,a5,-56
 d02:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 d06:	fe843783          	ld	a5,-24(s0)
 d0a:	863e                	mv	a2,a5
 d0c:	fd843583          	ld	a1,-40(s0)
 d10:	4505                	li	a0,1
 d12:	af1ff0ef          	jal	802 <vprintf>
}
 d16:	0001                	nop
 d18:	70a2                	ld	ra,40(sp)
 d1a:	7402                	ld	s0,32(sp)
 d1c:	6165                	addi	sp,sp,112
 d1e:	8082                	ret

0000000000000d20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d20:	7179                	addi	sp,sp,-48
 d22:	f406                	sd	ra,40(sp)
 d24:	f022                	sd	s0,32(sp)
 d26:	1800                	addi	s0,sp,48
 d28:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d2c:	fd843783          	ld	a5,-40(s0)
 d30:	17c1                	addi	a5,a5,-16
 d32:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d36:	00001797          	auipc	a5,0x1
 d3a:	2fa78793          	addi	a5,a5,762 # 2030 <freep>
 d3e:	639c                	ld	a5,0(a5)
 d40:	fef43423          	sd	a5,-24(s0)
 d44:	a815                	j	d78 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d46:	fe843783          	ld	a5,-24(s0)
 d4a:	639c                	ld	a5,0(a5)
 d4c:	fe843703          	ld	a4,-24(s0)
 d50:	00f76f63          	bltu	a4,a5,d6e <free+0x4e>
 d54:	fe043703          	ld	a4,-32(s0)
 d58:	fe843783          	ld	a5,-24(s0)
 d5c:	02e7eb63          	bltu	a5,a4,d92 <free+0x72>
 d60:	fe843783          	ld	a5,-24(s0)
 d64:	639c                	ld	a5,0(a5)
 d66:	fe043703          	ld	a4,-32(s0)
 d6a:	02f76463          	bltu	a4,a5,d92 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d6e:	fe843783          	ld	a5,-24(s0)
 d72:	639c                	ld	a5,0(a5)
 d74:	fef43423          	sd	a5,-24(s0)
 d78:	fe043703          	ld	a4,-32(s0)
 d7c:	fe843783          	ld	a5,-24(s0)
 d80:	fce7f3e3          	bgeu	a5,a4,d46 <free+0x26>
 d84:	fe843783          	ld	a5,-24(s0)
 d88:	639c                	ld	a5,0(a5)
 d8a:	fe043703          	ld	a4,-32(s0)
 d8e:	faf77ce3          	bgeu	a4,a5,d46 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d92:	fe043783          	ld	a5,-32(s0)
 d96:	479c                	lw	a5,8(a5)
 d98:	1782                	slli	a5,a5,0x20
 d9a:	9381                	srli	a5,a5,0x20
 d9c:	0792                	slli	a5,a5,0x4
 d9e:	fe043703          	ld	a4,-32(s0)
 da2:	973e                	add	a4,a4,a5
 da4:	fe843783          	ld	a5,-24(s0)
 da8:	639c                	ld	a5,0(a5)
 daa:	02f71763          	bne	a4,a5,dd8 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 dae:	fe043783          	ld	a5,-32(s0)
 db2:	4798                	lw	a4,8(a5)
 db4:	fe843783          	ld	a5,-24(s0)
 db8:	639c                	ld	a5,0(a5)
 dba:	479c                	lw	a5,8(a5)
 dbc:	9fb9                	addw	a5,a5,a4
 dbe:	0007871b          	sext.w	a4,a5
 dc2:	fe043783          	ld	a5,-32(s0)
 dc6:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 dc8:	fe843783          	ld	a5,-24(s0)
 dcc:	639c                	ld	a5,0(a5)
 dce:	6398                	ld	a4,0(a5)
 dd0:	fe043783          	ld	a5,-32(s0)
 dd4:	e398                	sd	a4,0(a5)
 dd6:	a039                	j	de4 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 dd8:	fe843783          	ld	a5,-24(s0)
 ddc:	6398                	ld	a4,0(a5)
 dde:	fe043783          	ld	a5,-32(s0)
 de2:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 de4:	fe843783          	ld	a5,-24(s0)
 de8:	479c                	lw	a5,8(a5)
 dea:	1782                	slli	a5,a5,0x20
 dec:	9381                	srli	a5,a5,0x20
 dee:	0792                	slli	a5,a5,0x4
 df0:	fe843703          	ld	a4,-24(s0)
 df4:	97ba                	add	a5,a5,a4
 df6:	fe043703          	ld	a4,-32(s0)
 dfa:	02f71563          	bne	a4,a5,e24 <free+0x104>
    p->s.size += bp->s.size;
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	4798                	lw	a4,8(a5)
 e04:	fe043783          	ld	a5,-32(s0)
 e08:	479c                	lw	a5,8(a5)
 e0a:	9fb9                	addw	a5,a5,a4
 e0c:	0007871b          	sext.w	a4,a5
 e10:	fe843783          	ld	a5,-24(s0)
 e14:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 e16:	fe043783          	ld	a5,-32(s0)
 e1a:	6398                	ld	a4,0(a5)
 e1c:	fe843783          	ld	a5,-24(s0)
 e20:	e398                	sd	a4,0(a5)
 e22:	a031                	j	e2e <free+0x10e>
  } else
    p->s.ptr = bp;
 e24:	fe843783          	ld	a5,-24(s0)
 e28:	fe043703          	ld	a4,-32(s0)
 e2c:	e398                	sd	a4,0(a5)
  freep = p;
 e2e:	00001797          	auipc	a5,0x1
 e32:	20278793          	addi	a5,a5,514 # 2030 <freep>
 e36:	fe843703          	ld	a4,-24(s0)
 e3a:	e398                	sd	a4,0(a5)
}
 e3c:	0001                	nop
 e3e:	70a2                	ld	ra,40(sp)
 e40:	7402                	ld	s0,32(sp)
 e42:	6145                	addi	sp,sp,48
 e44:	8082                	ret

0000000000000e46 <morecore>:

static Header*
morecore(uint nu)
{
 e46:	7179                	addi	sp,sp,-48
 e48:	f406                	sd	ra,40(sp)
 e4a:	f022                	sd	s0,32(sp)
 e4c:	1800                	addi	s0,sp,48
 e4e:	87aa                	mv	a5,a0
 e50:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e54:	fdc42783          	lw	a5,-36(s0)
 e58:	0007871b          	sext.w	a4,a5
 e5c:	6785                	lui	a5,0x1
 e5e:	00f77563          	bgeu	a4,a5,e68 <morecore+0x22>
    nu = 4096;
 e62:	6785                	lui	a5,0x1
 e64:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e68:	fdc42783          	lw	a5,-36(s0)
 e6c:	0047979b          	slliw	a5,a5,0x4
 e70:	2781                	sext.w	a5,a5
 e72:	853e                	mv	a0,a5
 e74:	ef0ff0ef          	jal	564 <sbrk>
 e78:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e7c:	fe843703          	ld	a4,-24(s0)
 e80:	57fd                	li	a5,-1
 e82:	00f71463          	bne	a4,a5,e8a <morecore+0x44>
    return 0;
 e86:	4781                	li	a5,0
 e88:	a02d                	j	eb2 <morecore+0x6c>
  hp = (Header*)p;
 e8a:	fe843783          	ld	a5,-24(s0)
 e8e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e92:	fe043783          	ld	a5,-32(s0)
 e96:	fdc42703          	lw	a4,-36(s0)
 e9a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e9c:	fe043783          	ld	a5,-32(s0)
 ea0:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x154>
 ea2:	853e                	mv	a0,a5
 ea4:	e7dff0ef          	jal	d20 <free>
  return freep;
 ea8:	00001797          	auipc	a5,0x1
 eac:	18878793          	addi	a5,a5,392 # 2030 <freep>
 eb0:	639c                	ld	a5,0(a5)
}
 eb2:	853e                	mv	a0,a5
 eb4:	70a2                	ld	ra,40(sp)
 eb6:	7402                	ld	s0,32(sp)
 eb8:	6145                	addi	sp,sp,48
 eba:	8082                	ret

0000000000000ebc <malloc>:

void*
malloc(uint nbytes)
{
 ebc:	7139                	addi	sp,sp,-64
 ebe:	fc06                	sd	ra,56(sp)
 ec0:	f822                	sd	s0,48(sp)
 ec2:	0080                	addi	s0,sp,64
 ec4:	87aa                	mv	a5,a0
 ec6:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eca:	fcc46783          	lwu	a5,-52(s0)
 ece:	07bd                	addi	a5,a5,15
 ed0:	8391                	srli	a5,a5,0x4
 ed2:	2781                	sext.w	a5,a5
 ed4:	2785                	addiw	a5,a5,1
 ed6:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 eda:	00001797          	auipc	a5,0x1
 ede:	15678793          	addi	a5,a5,342 # 2030 <freep>
 ee2:	639c                	ld	a5,0(a5)
 ee4:	fef43023          	sd	a5,-32(s0)
 ee8:	fe043783          	ld	a5,-32(s0)
 eec:	ef95                	bnez	a5,f28 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 eee:	00001797          	auipc	a5,0x1
 ef2:	13278793          	addi	a5,a5,306 # 2020 <base>
 ef6:	fef43023          	sd	a5,-32(s0)
 efa:	00001797          	auipc	a5,0x1
 efe:	13678793          	addi	a5,a5,310 # 2030 <freep>
 f02:	fe043703          	ld	a4,-32(s0)
 f06:	e398                	sd	a4,0(a5)
 f08:	00001797          	auipc	a5,0x1
 f0c:	12878793          	addi	a5,a5,296 # 2030 <freep>
 f10:	6398                	ld	a4,0(a5)
 f12:	00001797          	auipc	a5,0x1
 f16:	10e78793          	addi	a5,a5,270 # 2020 <base>
 f1a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 f1c:	00001797          	auipc	a5,0x1
 f20:	10478793          	addi	a5,a5,260 # 2020 <base>
 f24:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f28:	fe043783          	ld	a5,-32(s0)
 f2c:	639c                	ld	a5,0(a5)
 f2e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f32:	fe843783          	ld	a5,-24(s0)
 f36:	479c                	lw	a5,8(a5)
 f38:	fdc42703          	lw	a4,-36(s0)
 f3c:	2701                	sext.w	a4,a4
 f3e:	06e7e763          	bltu	a5,a4,fac <malloc+0xf0>
      if(p->s.size == nunits)
 f42:	fe843783          	ld	a5,-24(s0)
 f46:	479c                	lw	a5,8(a5)
 f48:	fdc42703          	lw	a4,-36(s0)
 f4c:	2701                	sext.w	a4,a4
 f4e:	00f71963          	bne	a4,a5,f60 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f52:	fe843783          	ld	a5,-24(s0)
 f56:	6398                	ld	a4,0(a5)
 f58:	fe043783          	ld	a5,-32(s0)
 f5c:	e398                	sd	a4,0(a5)
 f5e:	a825                	j	f96 <malloc+0xda>
      else {
        p->s.size -= nunits;
 f60:	fe843783          	ld	a5,-24(s0)
 f64:	479c                	lw	a5,8(a5)
 f66:	fdc42703          	lw	a4,-36(s0)
 f6a:	9f99                	subw	a5,a5,a4
 f6c:	0007871b          	sext.w	a4,a5
 f70:	fe843783          	ld	a5,-24(s0)
 f74:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f76:	fe843783          	ld	a5,-24(s0)
 f7a:	479c                	lw	a5,8(a5)
 f7c:	1782                	slli	a5,a5,0x20
 f7e:	9381                	srli	a5,a5,0x20
 f80:	0792                	slli	a5,a5,0x4
 f82:	fe843703          	ld	a4,-24(s0)
 f86:	97ba                	add	a5,a5,a4
 f88:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f8c:	fe843783          	ld	a5,-24(s0)
 f90:	fdc42703          	lw	a4,-36(s0)
 f94:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f96:	00001797          	auipc	a5,0x1
 f9a:	09a78793          	addi	a5,a5,154 # 2030 <freep>
 f9e:	fe043703          	ld	a4,-32(s0)
 fa2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 fa4:	fe843783          	ld	a5,-24(s0)
 fa8:	07c1                	addi	a5,a5,16
 faa:	a081                	j	fea <malloc+0x12e>
    }
    if(p == freep)
 fac:	00001797          	auipc	a5,0x1
 fb0:	08478793          	addi	a5,a5,132 # 2030 <freep>
 fb4:	639c                	ld	a5,0(a5)
 fb6:	fe843703          	ld	a4,-24(s0)
 fba:	00f71e63          	bne	a4,a5,fd6 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 fbe:	fdc42783          	lw	a5,-36(s0)
 fc2:	853e                	mv	a0,a5
 fc4:	e83ff0ef          	jal	e46 <morecore>
 fc8:	fea43423          	sd	a0,-24(s0)
 fcc:	fe843783          	ld	a5,-24(s0)
 fd0:	e399                	bnez	a5,fd6 <malloc+0x11a>
        return 0;
 fd2:	4781                	li	a5,0
 fd4:	a819                	j	fea <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fd6:	fe843783          	ld	a5,-24(s0)
 fda:	fef43023          	sd	a5,-32(s0)
 fde:	fe843783          	ld	a5,-24(s0)
 fe2:	639c                	ld	a5,0(a5)
 fe4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 fe8:	b7a9                	j	f32 <malloc+0x76>
  }
}
 fea:	853e                	mv	a0,a5
 fec:	70e2                	ld	ra,56(sp)
 fee:	7442                	ld	s0,48(sp)
 ff0:	6121                	addi	sp,sp,64
 ff2:	8082                	ret
