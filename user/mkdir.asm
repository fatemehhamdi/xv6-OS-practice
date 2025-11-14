
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
  12:	fdc42783          	lw	a5,-36(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4785                	li	a5,1
  1c:	00e7cc63          	blt	a5,a4,34 <main+0x34>
    fprintf(2, "Usage: mkdir files...\n");
  20:	00001597          	auipc	a1,0x1
  24:	fd058593          	addi	a1,a1,-48 # ff0 <malloc+0x13c>
  28:	4509                	li	a0,2
  2a:	44f000ef          	jal	c78 <fprintf>
    exit(1);
  2e:	4505                	li	a0,1
  30:	580000ef          	jal	5b0 <exit>
  }

  for(i = 1; i < argc; i++){
  34:	4785                	li	a5,1
  36:	fef42623          	sw	a5,-20(s0)
  3a:	a099                	j	80 <main+0x80>
    if(mkdir(argv[i]) < 0){
  3c:	fec42783          	lw	a5,-20(s0)
  40:	078e                	slli	a5,a5,0x3
  42:	fd043703          	ld	a4,-48(s0)
  46:	97ba                	add	a5,a5,a4
  48:	639c                	ld	a5,0(a5)
  4a:	853e                	mv	a0,a5
  4c:	5cc000ef          	jal	618 <mkdir>
  50:	87aa                	mv	a5,a0
  52:	0207d263          	bgez	a5,76 <main+0x76>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  56:	fec42783          	lw	a5,-20(s0)
  5a:	078e                	slli	a5,a5,0x3
  5c:	fd043703          	ld	a4,-48(s0)
  60:	97ba                	add	a5,a5,a4
  62:	639c                	ld	a5,0(a5)
  64:	863e                	mv	a2,a5
  66:	00001597          	auipc	a1,0x1
  6a:	fa258593          	addi	a1,a1,-94 # 1008 <malloc+0x154>
  6e:	4509                	li	a0,2
  70:	409000ef          	jal	c78 <fprintf>
      break;
  74:	a839                	j	92 <main+0x92>
  for(i = 1; i < argc; i++){
  76:	fec42783          	lw	a5,-20(s0)
  7a:	2785                	addiw	a5,a5,1
  7c:	fef42623          	sw	a5,-20(s0)
  80:	fec42783          	lw	a5,-20(s0)
  84:	873e                	mv	a4,a5
  86:	fdc42783          	lw	a5,-36(s0)
  8a:	2701                	sext.w	a4,a4
  8c:	2781                	sext.w	a5,a5
  8e:	faf747e3          	blt	a4,a5,3c <main+0x3c>
    }
  }

  exit(0);
  92:	4501                	li	a0,0
  94:	51c000ef          	jal	5b0 <exit>

0000000000000098 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  98:	7179                	addi	sp,sp,-48
  9a:	f406                	sd	ra,40(sp)
  9c:	f022                	sd	s0,32(sp)
  9e:	1800                	addi	s0,sp,48
  a0:	87aa                	mv	a5,a0
  a2:	fcb43823          	sd	a1,-48(s0)
  a6:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  aa:	fdc42783          	lw	a5,-36(s0)
  ae:	fd043583          	ld	a1,-48(s0)
  b2:	853e                	mv	a0,a5
  b4:	f4dff0ef          	jal	0 <main>
  b8:	87aa                	mv	a5,a0
  ba:	fef42623          	sw	a5,-20(s0)
  exit(r);
  be:	fec42783          	lw	a5,-20(s0)
  c2:	853e                	mv	a0,a5
  c4:	4ec000ef          	jal	5b0 <exit>

00000000000000c8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  c8:	7179                	addi	sp,sp,-48
  ca:	f406                	sd	ra,40(sp)
  cc:	f022                	sd	s0,32(sp)
  ce:	1800                	addi	s0,sp,48
  d0:	fca43c23          	sd	a0,-40(s0)
  d4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  d8:	fd843783          	ld	a5,-40(s0)
  dc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  e0:	0001                	nop
  e2:	fd043703          	ld	a4,-48(s0)
  e6:	00170793          	addi	a5,a4,1
  ea:	fcf43823          	sd	a5,-48(s0)
  ee:	fd843783          	ld	a5,-40(s0)
  f2:	00178693          	addi	a3,a5,1
  f6:	fcd43c23          	sd	a3,-40(s0)
  fa:	00074703          	lbu	a4,0(a4)
  fe:	00e78023          	sb	a4,0(a5)
 102:	0007c783          	lbu	a5,0(a5)
 106:	fff1                	bnez	a5,e2 <strcpy+0x1a>
    ;
  return os;
 108:	fe843783          	ld	a5,-24(s0)
}
 10c:	853e                	mv	a0,a5
 10e:	70a2                	ld	ra,40(sp)
 110:	7402                	ld	s0,32(sp)
 112:	6145                	addi	sp,sp,48
 114:	8082                	ret

0000000000000116 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 116:	1101                	addi	sp,sp,-32
 118:	ec06                	sd	ra,24(sp)
 11a:	e822                	sd	s0,16(sp)
 11c:	1000                	addi	s0,sp,32
 11e:	fea43423          	sd	a0,-24(s0)
 122:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 126:	a819                	j	13c <strcmp+0x26>
    p++, q++;
 128:	fe843783          	ld	a5,-24(s0)
 12c:	0785                	addi	a5,a5,1
 12e:	fef43423          	sd	a5,-24(s0)
 132:	fe043783          	ld	a5,-32(s0)
 136:	0785                	addi	a5,a5,1
 138:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 13c:	fe843783          	ld	a5,-24(s0)
 140:	0007c783          	lbu	a5,0(a5)
 144:	cb99                	beqz	a5,15a <strcmp+0x44>
 146:	fe843783          	ld	a5,-24(s0)
 14a:	0007c703          	lbu	a4,0(a5)
 14e:	fe043783          	ld	a5,-32(s0)
 152:	0007c783          	lbu	a5,0(a5)
 156:	fcf709e3          	beq	a4,a5,128 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 15a:	fe843783          	ld	a5,-24(s0)
 15e:	0007c783          	lbu	a5,0(a5)
 162:	0007871b          	sext.w	a4,a5
 166:	fe043783          	ld	a5,-32(s0)
 16a:	0007c783          	lbu	a5,0(a5)
 16e:	2781                	sext.w	a5,a5
 170:	40f707bb          	subw	a5,a4,a5
 174:	2781                	sext.w	a5,a5
}
 176:	853e                	mv	a0,a5
 178:	60e2                	ld	ra,24(sp)
 17a:	6442                	ld	s0,16(sp)
 17c:	6105                	addi	sp,sp,32
 17e:	8082                	ret

0000000000000180 <strlen>:

uint
strlen(const char *s)
{
 180:	7179                	addi	sp,sp,-48
 182:	f406                	sd	ra,40(sp)
 184:	f022                	sd	s0,32(sp)
 186:	1800                	addi	s0,sp,48
 188:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 18c:	fe042623          	sw	zero,-20(s0)
 190:	a031                	j	19c <strlen+0x1c>
 192:	fec42783          	lw	a5,-20(s0)
 196:	2785                	addiw	a5,a5,1
 198:	fef42623          	sw	a5,-20(s0)
 19c:	fec42783          	lw	a5,-20(s0)
 1a0:	fd843703          	ld	a4,-40(s0)
 1a4:	97ba                	add	a5,a5,a4
 1a6:	0007c783          	lbu	a5,0(a5)
 1aa:	f7e5                	bnez	a5,192 <strlen+0x12>
    ;
  return n;
 1ac:	fec42783          	lw	a5,-20(s0)
}
 1b0:	853e                	mv	a0,a5
 1b2:	70a2                	ld	ra,40(sp)
 1b4:	7402                	ld	s0,32(sp)
 1b6:	6145                	addi	sp,sp,48
 1b8:	8082                	ret

00000000000001ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ba:	7179                	addi	sp,sp,-48
 1bc:	f406                	sd	ra,40(sp)
 1be:	f022                	sd	s0,32(sp)
 1c0:	1800                	addi	s0,sp,48
 1c2:	fca43c23          	sd	a0,-40(s0)
 1c6:	87ae                	mv	a5,a1
 1c8:	8732                	mv	a4,a2
 1ca:	fcf42a23          	sw	a5,-44(s0)
 1ce:	87ba                	mv	a5,a4
 1d0:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1d4:	fd843783          	ld	a5,-40(s0)
 1d8:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1dc:	fe042623          	sw	zero,-20(s0)
 1e0:	a00d                	j	202 <memset+0x48>
    cdst[i] = c;
 1e2:	fec42783          	lw	a5,-20(s0)
 1e6:	fe043703          	ld	a4,-32(s0)
 1ea:	97ba                	add	a5,a5,a4
 1ec:	fd442703          	lw	a4,-44(s0)
 1f0:	0ff77713          	zext.b	a4,a4
 1f4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1f8:	fec42783          	lw	a5,-20(s0)
 1fc:	2785                	addiw	a5,a5,1
 1fe:	fef42623          	sw	a5,-20(s0)
 202:	fec42783          	lw	a5,-20(s0)
 206:	fd042703          	lw	a4,-48(s0)
 20a:	2701                	sext.w	a4,a4
 20c:	fce7ebe3          	bltu	a5,a4,1e2 <memset+0x28>
  }
  return dst;
 210:	fd843783          	ld	a5,-40(s0)
}
 214:	853e                	mv	a0,a5
 216:	70a2                	ld	ra,40(sp)
 218:	7402                	ld	s0,32(sp)
 21a:	6145                	addi	sp,sp,48
 21c:	8082                	ret

000000000000021e <strchr>:

char*
strchr(const char *s, char c)
{
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	1000                	addi	s0,sp,32
 226:	fea43423          	sd	a0,-24(s0)
 22a:	87ae                	mv	a5,a1
 22c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 230:	a01d                	j	256 <strchr+0x38>
    if(*s == c)
 232:	fe843783          	ld	a5,-24(s0)
 236:	0007c703          	lbu	a4,0(a5)
 23a:	fe744783          	lbu	a5,-25(s0)
 23e:	0ff7f793          	zext.b	a5,a5
 242:	00e79563          	bne	a5,a4,24c <strchr+0x2e>
      return (char*)s;
 246:	fe843783          	ld	a5,-24(s0)
 24a:	a821                	j	262 <strchr+0x44>
  for(; *s; s++)
 24c:	fe843783          	ld	a5,-24(s0)
 250:	0785                	addi	a5,a5,1
 252:	fef43423          	sd	a5,-24(s0)
 256:	fe843783          	ld	a5,-24(s0)
 25a:	0007c783          	lbu	a5,0(a5)
 25e:	fbf1                	bnez	a5,232 <strchr+0x14>
  return 0;
 260:	4781                	li	a5,0
}
 262:	853e                	mv	a0,a5
 264:	60e2                	ld	ra,24(sp)
 266:	6442                	ld	s0,16(sp)
 268:	6105                	addi	sp,sp,32
 26a:	8082                	ret

000000000000026c <gets>:

char*
gets(char *buf, int max)
{
 26c:	7179                	addi	sp,sp,-48
 26e:	f406                	sd	ra,40(sp)
 270:	f022                	sd	s0,32(sp)
 272:	1800                	addi	s0,sp,48
 274:	fca43c23          	sd	a0,-40(s0)
 278:	87ae                	mv	a5,a1
 27a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27e:	fe042623          	sw	zero,-20(s0)
 282:	a891                	j	2d6 <gets+0x6a>
    cc = read(0, &c, 1);
 284:	fe740793          	addi	a5,s0,-25
 288:	4605                	li	a2,1
 28a:	85be                	mv	a1,a5
 28c:	4501                	li	a0,0
 28e:	33a000ef          	jal	5c8 <read>
 292:	87aa                	mv	a5,a0
 294:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 298:	fe842783          	lw	a5,-24(s0)
 29c:	2781                	sext.w	a5,a5
 29e:	04f05663          	blez	a5,2ea <gets+0x7e>
      break;
    buf[i++] = c;
 2a2:	fec42783          	lw	a5,-20(s0)
 2a6:	0017871b          	addiw	a4,a5,1
 2aa:	fee42623          	sw	a4,-20(s0)
 2ae:	873e                	mv	a4,a5
 2b0:	fd843783          	ld	a5,-40(s0)
 2b4:	97ba                	add	a5,a5,a4
 2b6:	fe744703          	lbu	a4,-25(s0)
 2ba:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2be:	fe744783          	lbu	a5,-25(s0)
 2c2:	873e                	mv	a4,a5
 2c4:	47a9                	li	a5,10
 2c6:	02f70363          	beq	a4,a5,2ec <gets+0x80>
 2ca:	fe744783          	lbu	a5,-25(s0)
 2ce:	873e                	mv	a4,a5
 2d0:	47b5                	li	a5,13
 2d2:	00f70d63          	beq	a4,a5,2ec <gets+0x80>
  for(i=0; i+1 < max; ){
 2d6:	fec42783          	lw	a5,-20(s0)
 2da:	2785                	addiw	a5,a5,1
 2dc:	2781                	sext.w	a5,a5
 2de:	fd442703          	lw	a4,-44(s0)
 2e2:	2701                	sext.w	a4,a4
 2e4:	fae7c0e3          	blt	a5,a4,284 <gets+0x18>
 2e8:	a011                	j	2ec <gets+0x80>
      break;
 2ea:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2ec:	fec42783          	lw	a5,-20(s0)
 2f0:	fd843703          	ld	a4,-40(s0)
 2f4:	97ba                	add	a5,a5,a4
 2f6:	00078023          	sb	zero,0(a5)
  return buf;
 2fa:	fd843783          	ld	a5,-40(s0)
}
 2fe:	853e                	mv	a0,a5
 300:	70a2                	ld	ra,40(sp)
 302:	7402                	ld	s0,32(sp)
 304:	6145                	addi	sp,sp,48
 306:	8082                	ret

0000000000000308 <stat>:

int
stat(const char *n, struct stat *st)
{
 308:	7179                	addi	sp,sp,-48
 30a:	f406                	sd	ra,40(sp)
 30c:	f022                	sd	s0,32(sp)
 30e:	1800                	addi	s0,sp,48
 310:	fca43c23          	sd	a0,-40(s0)
 314:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 318:	4581                	li	a1,0
 31a:	fd843503          	ld	a0,-40(s0)
 31e:	2d2000ef          	jal	5f0 <open>
 322:	87aa                	mv	a5,a0
 324:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 328:	fec42783          	lw	a5,-20(s0)
 32c:	2781                	sext.w	a5,a5
 32e:	0007d463          	bgez	a5,336 <stat+0x2e>
    return -1;
 332:	57fd                	li	a5,-1
 334:	a015                	j	358 <stat+0x50>
  r = fstat(fd, st);
 336:	fec42783          	lw	a5,-20(s0)
 33a:	fd043583          	ld	a1,-48(s0)
 33e:	853e                	mv	a0,a5
 340:	2c8000ef          	jal	608 <fstat>
 344:	87aa                	mv	a5,a0
 346:	fef42423          	sw	a5,-24(s0)
  close(fd);
 34a:	fec42783          	lw	a5,-20(s0)
 34e:	853e                	mv	a0,a5
 350:	288000ef          	jal	5d8 <close>
  return r;
 354:	fe842783          	lw	a5,-24(s0)
}
 358:	853e                	mv	a0,a5
 35a:	70a2                	ld	ra,40(sp)
 35c:	7402                	ld	s0,32(sp)
 35e:	6145                	addi	sp,sp,48
 360:	8082                	ret

0000000000000362 <atoi>:

int
atoi(const char *s)
{
 362:	7179                	addi	sp,sp,-48
 364:	f406                	sd	ra,40(sp)
 366:	f022                	sd	s0,32(sp)
 368:	1800                	addi	s0,sp,48
 36a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 36e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 372:	a81d                	j	3a8 <atoi+0x46>
    n = n*10 + *s++ - '0';
 374:	fec42783          	lw	a5,-20(s0)
 378:	873e                	mv	a4,a5
 37a:	87ba                	mv	a5,a4
 37c:	0027979b          	slliw	a5,a5,0x2
 380:	9fb9                	addw	a5,a5,a4
 382:	0017979b          	slliw	a5,a5,0x1
 386:	0007871b          	sext.w	a4,a5
 38a:	fd843783          	ld	a5,-40(s0)
 38e:	00178693          	addi	a3,a5,1
 392:	fcd43c23          	sd	a3,-40(s0)
 396:	0007c783          	lbu	a5,0(a5)
 39a:	2781                	sext.w	a5,a5
 39c:	9fb9                	addw	a5,a5,a4
 39e:	2781                	sext.w	a5,a5
 3a0:	fd07879b          	addiw	a5,a5,-48
 3a4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3a8:	fd843783          	ld	a5,-40(s0)
 3ac:	0007c783          	lbu	a5,0(a5)
 3b0:	873e                	mv	a4,a5
 3b2:	02f00793          	li	a5,47
 3b6:	00e7fb63          	bgeu	a5,a4,3cc <atoi+0x6a>
 3ba:	fd843783          	ld	a5,-40(s0)
 3be:	0007c783          	lbu	a5,0(a5)
 3c2:	873e                	mv	a4,a5
 3c4:	03900793          	li	a5,57
 3c8:	fae7f6e3          	bgeu	a5,a4,374 <atoi+0x12>
  return n;
 3cc:	fec42783          	lw	a5,-20(s0)
}
 3d0:	853e                	mv	a0,a5
 3d2:	70a2                	ld	ra,40(sp)
 3d4:	7402                	ld	s0,32(sp)
 3d6:	6145                	addi	sp,sp,48
 3d8:	8082                	ret

00000000000003da <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3da:	7139                	addi	sp,sp,-64
 3dc:	fc06                	sd	ra,56(sp)
 3de:	f822                	sd	s0,48(sp)
 3e0:	0080                	addi	s0,sp,64
 3e2:	fca43c23          	sd	a0,-40(s0)
 3e6:	fcb43823          	sd	a1,-48(s0)
 3ea:	87b2                	mv	a5,a2
 3ec:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3f0:	fd843783          	ld	a5,-40(s0)
 3f4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3f8:	fd043783          	ld	a5,-48(s0)
 3fc:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 400:	fe043703          	ld	a4,-32(s0)
 404:	fe843783          	ld	a5,-24(s0)
 408:	02e7fc63          	bgeu	a5,a4,440 <memmove+0x66>
    while(n-- > 0)
 40c:	a00d                	j	42e <memmove+0x54>
      *dst++ = *src++;
 40e:	fe043703          	ld	a4,-32(s0)
 412:	00170793          	addi	a5,a4,1
 416:	fef43023          	sd	a5,-32(s0)
 41a:	fe843783          	ld	a5,-24(s0)
 41e:	00178693          	addi	a3,a5,1
 422:	fed43423          	sd	a3,-24(s0)
 426:	00074703          	lbu	a4,0(a4)
 42a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 42e:	fcc42783          	lw	a5,-52(s0)
 432:	fff7871b          	addiw	a4,a5,-1
 436:	fce42623          	sw	a4,-52(s0)
 43a:	fcf04ae3          	bgtz	a5,40e <memmove+0x34>
 43e:	a891                	j	492 <memmove+0xb8>
  } else {
    dst += n;
 440:	fcc42783          	lw	a5,-52(s0)
 444:	fe843703          	ld	a4,-24(s0)
 448:	97ba                	add	a5,a5,a4
 44a:	fef43423          	sd	a5,-24(s0)
    src += n;
 44e:	fcc42783          	lw	a5,-52(s0)
 452:	fe043703          	ld	a4,-32(s0)
 456:	97ba                	add	a5,a5,a4
 458:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 45c:	a01d                	j	482 <memmove+0xa8>
      *--dst = *--src;
 45e:	fe043783          	ld	a5,-32(s0)
 462:	17fd                	addi	a5,a5,-1
 464:	fef43023          	sd	a5,-32(s0)
 468:	fe843783          	ld	a5,-24(s0)
 46c:	17fd                	addi	a5,a5,-1
 46e:	fef43423          	sd	a5,-24(s0)
 472:	fe043783          	ld	a5,-32(s0)
 476:	0007c703          	lbu	a4,0(a5)
 47a:	fe843783          	ld	a5,-24(s0)
 47e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 482:	fcc42783          	lw	a5,-52(s0)
 486:	fff7871b          	addiw	a4,a5,-1
 48a:	fce42623          	sw	a4,-52(s0)
 48e:	fcf048e3          	bgtz	a5,45e <memmove+0x84>
  }
  return vdst;
 492:	fd843783          	ld	a5,-40(s0)
}
 496:	853e                	mv	a0,a5
 498:	70e2                	ld	ra,56(sp)
 49a:	7442                	ld	s0,48(sp)
 49c:	6121                	addi	sp,sp,64
 49e:	8082                	ret

00000000000004a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a0:	7139                	addi	sp,sp,-64
 4a2:	fc06                	sd	ra,56(sp)
 4a4:	f822                	sd	s0,48(sp)
 4a6:	0080                	addi	s0,sp,64
 4a8:	fca43c23          	sd	a0,-40(s0)
 4ac:	fcb43823          	sd	a1,-48(s0)
 4b0:	87b2                	mv	a5,a2
 4b2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4b6:	fd843783          	ld	a5,-40(s0)
 4ba:	fef43423          	sd	a5,-24(s0)
 4be:	fd043783          	ld	a5,-48(s0)
 4c2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c6:	a0a1                	j	50e <memcmp+0x6e>
    if (*p1 != *p2) {
 4c8:	fe843783          	ld	a5,-24(s0)
 4cc:	0007c703          	lbu	a4,0(a5)
 4d0:	fe043783          	ld	a5,-32(s0)
 4d4:	0007c783          	lbu	a5,0(a5)
 4d8:	02f70163          	beq	a4,a5,4fa <memcmp+0x5a>
      return *p1 - *p2;
 4dc:	fe843783          	ld	a5,-24(s0)
 4e0:	0007c783          	lbu	a5,0(a5)
 4e4:	0007871b          	sext.w	a4,a5
 4e8:	fe043783          	ld	a5,-32(s0)
 4ec:	0007c783          	lbu	a5,0(a5)
 4f0:	2781                	sext.w	a5,a5
 4f2:	40f707bb          	subw	a5,a4,a5
 4f6:	2781                	sext.w	a5,a5
 4f8:	a01d                	j	51e <memcmp+0x7e>
    }
    p1++;
 4fa:	fe843783          	ld	a5,-24(s0)
 4fe:	0785                	addi	a5,a5,1
 500:	fef43423          	sd	a5,-24(s0)
    p2++;
 504:	fe043783          	ld	a5,-32(s0)
 508:	0785                	addi	a5,a5,1
 50a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 50e:	fcc42783          	lw	a5,-52(s0)
 512:	fff7871b          	addiw	a4,a5,-1
 516:	fce42623          	sw	a4,-52(s0)
 51a:	f7dd                	bnez	a5,4c8 <memcmp+0x28>
  }
  return 0;
 51c:	4781                	li	a5,0
}
 51e:	853e                	mv	a0,a5
 520:	70e2                	ld	ra,56(sp)
 522:	7442                	ld	s0,48(sp)
 524:	6121                	addi	sp,sp,64
 526:	8082                	ret

0000000000000528 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 528:	7179                	addi	sp,sp,-48
 52a:	f406                	sd	ra,40(sp)
 52c:	f022                	sd	s0,32(sp)
 52e:	1800                	addi	s0,sp,48
 530:	fea43423          	sd	a0,-24(s0)
 534:	feb43023          	sd	a1,-32(s0)
 538:	87b2                	mv	a5,a2
 53a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 53e:	fdc42783          	lw	a5,-36(s0)
 542:	863e                	mv	a2,a5
 544:	fe043583          	ld	a1,-32(s0)
 548:	fe843503          	ld	a0,-24(s0)
 54c:	e8fff0ef          	jal	3da <memmove>
 550:	87aa                	mv	a5,a0
}
 552:	853e                	mv	a0,a5
 554:	70a2                	ld	ra,40(sp)
 556:	7402                	ld	s0,32(sp)
 558:	6145                	addi	sp,sp,48
 55a:	8082                	ret

000000000000055c <sbrk>:

char *
sbrk(int n) {
 55c:	1101                	addi	sp,sp,-32
 55e:	ec06                	sd	ra,24(sp)
 560:	e822                	sd	s0,16(sp)
 562:	1000                	addi	s0,sp,32
 564:	87aa                	mv	a5,a0
 566:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 56a:	fec42783          	lw	a5,-20(s0)
 56e:	4585                	li	a1,1
 570:	853e                	mv	a0,a5
 572:	0c6000ef          	jal	638 <sys_sbrk>
 576:	87aa                	mv	a5,a0
}
 578:	853e                	mv	a0,a5
 57a:	60e2                	ld	ra,24(sp)
 57c:	6442                	ld	s0,16(sp)
 57e:	6105                	addi	sp,sp,32
 580:	8082                	ret

0000000000000582 <sbrklazy>:

char *
sbrklazy(int n) {
 582:	1101                	addi	sp,sp,-32
 584:	ec06                	sd	ra,24(sp)
 586:	e822                	sd	s0,16(sp)
 588:	1000                	addi	s0,sp,32
 58a:	87aa                	mv	a5,a0
 58c:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 590:	fec42783          	lw	a5,-20(s0)
 594:	4589                	li	a1,2
 596:	853e                	mv	a0,a5
 598:	0a0000ef          	jal	638 <sys_sbrk>
 59c:	87aa                	mv	a5,a0
}
 59e:	853e                	mv	a0,a5
 5a0:	60e2                	ld	ra,24(sp)
 5a2:	6442                	ld	s0,16(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret

00000000000005a8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5a8:	4885                	li	a7,1
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b0:	4889                	li	a7,2
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5b8:	488d                	li	a7,3
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c0:	4891                	li	a7,4
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <read>:
.global read
read:
 li a7, SYS_read
 5c8:	4895                	li	a7,5
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <write>:
.global write
write:
 li a7, SYS_write
 5d0:	48c1                	li	a7,16
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <close>:
.global close
close:
 li a7, SYS_close
 5d8:	48d5                	li	a7,21
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e0:	4899                	li	a7,6
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5e8:	489d                	li	a7,7
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <open>:
.global open
open:
 li a7, SYS_open
 5f0:	48bd                	li	a7,15
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5f8:	48c5                	li	a7,17
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 600:	48c9                	li	a7,18
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 608:	48a1                	li	a7,8
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <link>:
.global link
link:
 li a7, SYS_link
 610:	48cd                	li	a7,19
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 618:	48d1                	li	a7,20
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 620:	48a5                	li	a7,9
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <dup>:
.global dup
dup:
 li a7, SYS_dup
 628:	48a9                	li	a7,10
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 630:	48ad                	li	a7,11
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 638:	48b1                	li	a7,12
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <pause>:
.global pause
pause:
 li a7, SYS_pause
 640:	48b5                	li	a7,13
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 648:	48b9                	li	a7,14
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <top>:
.global top
top:
 li a7, SYS_top
 650:	48d9                	li	a7,22
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 658:	1101                	addi	sp,sp,-32
 65a:	ec06                	sd	ra,24(sp)
 65c:	e822                	sd	s0,16(sp)
 65e:	1000                	addi	s0,sp,32
 660:	87aa                	mv	a5,a0
 662:	872e                	mv	a4,a1
 664:	fef42623          	sw	a5,-20(s0)
 668:	87ba                	mv	a5,a4
 66a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 66e:	feb40713          	addi	a4,s0,-21
 672:	fec42783          	lw	a5,-20(s0)
 676:	4605                	li	a2,1
 678:	85ba                	mv	a1,a4
 67a:	853e                	mv	a0,a5
 67c:	f55ff0ef          	jal	5d0 <write>
}
 680:	0001                	nop
 682:	60e2                	ld	ra,24(sp)
 684:	6442                	ld	s0,16(sp)
 686:	6105                	addi	sp,sp,32
 688:	8082                	ret

000000000000068a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 68a:	711d                	addi	sp,sp,-96
 68c:	ec86                	sd	ra,88(sp)
 68e:	e8a2                	sd	s0,80(sp)
 690:	1080                	addi	s0,sp,96
 692:	87aa                	mv	a5,a0
 694:	fab43823          	sd	a1,-80(s0)
 698:	8736                	mv	a4,a3
 69a:	faf42e23          	sw	a5,-68(s0)
 69e:	87b2                	mv	a5,a2
 6a0:	faf42c23          	sw	a5,-72(s0)
 6a4:	87ba                	mv	a5,a4
 6a6:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 6aa:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6ae:	fac42783          	lw	a5,-84(s0)
 6b2:	2781                	sext.w	a5,a5
 6b4:	cf99                	beqz	a5,6d2 <printint+0x48>
 6b6:	fb043783          	ld	a5,-80(s0)
 6ba:	0007dc63          	bgez	a5,6d2 <printint+0x48>
    neg = 1;
 6be:	4785                	li	a5,1
 6c0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6c4:	fb043783          	ld	a5,-80(s0)
 6c8:	40f007b3          	neg	a5,a5
 6cc:	fef43023          	sd	a5,-32(s0)
 6d0:	a029                	j	6da <printint+0x50>
  } else {
    x = xx;
 6d2:	fb043783          	ld	a5,-80(s0)
 6d6:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6da:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6de:	fb842783          	lw	a5,-72(s0)
 6e2:	fe043703          	ld	a4,-32(s0)
 6e6:	02f77733          	remu	a4,a4,a5
 6ea:	fec42783          	lw	a5,-20(s0)
 6ee:	0017869b          	addiw	a3,a5,1
 6f2:	fed42623          	sw	a3,-20(s0)
 6f6:	00002697          	auipc	a3,0x2
 6fa:	90a68693          	addi	a3,a3,-1782 # 2000 <digits>
 6fe:	9736                	add	a4,a4,a3
 700:	00074703          	lbu	a4,0(a4)
 704:	17c1                	addi	a5,a5,-16
 706:	97a2                	add	a5,a5,s0
 708:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 70c:	fb842783          	lw	a5,-72(s0)
 710:	fe043703          	ld	a4,-32(s0)
 714:	02f757b3          	divu	a5,a4,a5
 718:	fef43023          	sd	a5,-32(s0)
 71c:	fe043783          	ld	a5,-32(s0)
 720:	ffdd                	bnez	a5,6de <printint+0x54>
  if(neg)
 722:	fe842783          	lw	a5,-24(s0)
 726:	2781                	sext.w	a5,a5
 728:	cb95                	beqz	a5,75c <printint+0xd2>
    buf[i++] = '-';
 72a:	fec42783          	lw	a5,-20(s0)
 72e:	0017871b          	addiw	a4,a5,1
 732:	fee42623          	sw	a4,-20(s0)
 736:	17c1                	addi	a5,a5,-16
 738:	97a2                	add	a5,a5,s0
 73a:	02d00713          	li	a4,45
 73e:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 742:	a829                	j	75c <printint+0xd2>
    putc(fd, buf[i]);
 744:	fec42783          	lw	a5,-20(s0)
 748:	17c1                	addi	a5,a5,-16
 74a:	97a2                	add	a5,a5,s0
 74c:	fd87c703          	lbu	a4,-40(a5)
 750:	fbc42783          	lw	a5,-68(s0)
 754:	85ba                	mv	a1,a4
 756:	853e                	mv	a0,a5
 758:	f01ff0ef          	jal	658 <putc>
  while(--i >= 0)
 75c:	fec42783          	lw	a5,-20(s0)
 760:	37fd                	addiw	a5,a5,-1
 762:	fef42623          	sw	a5,-20(s0)
 766:	fec42783          	lw	a5,-20(s0)
 76a:	2781                	sext.w	a5,a5
 76c:	fc07dce3          	bgez	a5,744 <printint+0xba>
}
 770:	0001                	nop
 772:	0001                	nop
 774:	60e6                	ld	ra,88(sp)
 776:	6446                	ld	s0,80(sp)
 778:	6125                	addi	sp,sp,96
 77a:	8082                	ret

000000000000077c <printptr>:

static void
printptr(int fd, uint64 x) {
 77c:	7179                	addi	sp,sp,-48
 77e:	f406                	sd	ra,40(sp)
 780:	f022                	sd	s0,32(sp)
 782:	1800                	addi	s0,sp,48
 784:	87aa                	mv	a5,a0
 786:	fcb43823          	sd	a1,-48(s0)
 78a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 78e:	fdc42783          	lw	a5,-36(s0)
 792:	03000593          	li	a1,48
 796:	853e                	mv	a0,a5
 798:	ec1ff0ef          	jal	658 <putc>
  putc(fd, 'x');
 79c:	fdc42783          	lw	a5,-36(s0)
 7a0:	07800593          	li	a1,120
 7a4:	853e                	mv	a0,a5
 7a6:	eb3ff0ef          	jal	658 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7aa:	fe042623          	sw	zero,-20(s0)
 7ae:	a81d                	j	7e4 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b0:	fd043783          	ld	a5,-48(s0)
 7b4:	93f1                	srli	a5,a5,0x3c
 7b6:	00002717          	auipc	a4,0x2
 7ba:	84a70713          	addi	a4,a4,-1974 # 2000 <digits>
 7be:	97ba                	add	a5,a5,a4
 7c0:	0007c703          	lbu	a4,0(a5)
 7c4:	fdc42783          	lw	a5,-36(s0)
 7c8:	85ba                	mv	a1,a4
 7ca:	853e                	mv	a0,a5
 7cc:	e8dff0ef          	jal	658 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d0:	fec42783          	lw	a5,-20(s0)
 7d4:	2785                	addiw	a5,a5,1
 7d6:	fef42623          	sw	a5,-20(s0)
 7da:	fd043783          	ld	a5,-48(s0)
 7de:	0792                	slli	a5,a5,0x4
 7e0:	fcf43823          	sd	a5,-48(s0)
 7e4:	fec42703          	lw	a4,-20(s0)
 7e8:	47bd                	li	a5,15
 7ea:	fce7f3e3          	bgeu	a5,a4,7b0 <printptr+0x34>
}
 7ee:	0001                	nop
 7f0:	0001                	nop
 7f2:	70a2                	ld	ra,40(sp)
 7f4:	7402                	ld	s0,32(sp)
 7f6:	6145                	addi	sp,sp,48
 7f8:	8082                	ret

00000000000007fa <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7fa:	715d                	addi	sp,sp,-80
 7fc:	e486                	sd	ra,72(sp)
 7fe:	e0a2                	sd	s0,64(sp)
 800:	0880                	addi	s0,sp,80
 802:	87aa                	mv	a5,a0
 804:	fcb43023          	sd	a1,-64(s0)
 808:	fac43c23          	sd	a2,-72(s0)
 80c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 810:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 814:	fc042e23          	sw	zero,-36(s0)
 818:	a189                	j	c5a <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 81a:	fdc42783          	lw	a5,-36(s0)
 81e:	fc043703          	ld	a4,-64(s0)
 822:	97ba                	add	a5,a5,a4
 824:	0007c783          	lbu	a5,0(a5)
 828:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 82c:	fd842783          	lw	a5,-40(s0)
 830:	2781                	sext.w	a5,a5
 832:	eb8d                	bnez	a5,864 <vprintf+0x6a>
      if(c0 == '%'){
 834:	fd442783          	lw	a5,-44(s0)
 838:	0007871b          	sext.w	a4,a5
 83c:	02500793          	li	a5,37
 840:	00f71763          	bne	a4,a5,84e <vprintf+0x54>
        state = '%';
 844:	02500793          	li	a5,37
 848:	fcf42c23          	sw	a5,-40(s0)
 84c:	a111                	j	c50 <vprintf+0x456>
      } else {
        putc(fd, c0);
 84e:	fd442783          	lw	a5,-44(s0)
 852:	0ff7f713          	zext.b	a4,a5
 856:	fcc42783          	lw	a5,-52(s0)
 85a:	85ba                	mv	a1,a4
 85c:	853e                	mv	a0,a5
 85e:	dfbff0ef          	jal	658 <putc>
 862:	a6fd                	j	c50 <vprintf+0x456>
      }
    } else if(state == '%'){
 864:	fd842783          	lw	a5,-40(s0)
 868:	0007871b          	sext.w	a4,a5
 86c:	02500793          	li	a5,37
 870:	3ef71063          	bne	a4,a5,c50 <vprintf+0x456>
      c1 = c2 = 0;
 874:	fe042023          	sw	zero,-32(s0)
 878:	fe042783          	lw	a5,-32(s0)
 87c:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 880:	fd442783          	lw	a5,-44(s0)
 884:	2781                	sext.w	a5,a5
 886:	cb99                	beqz	a5,89c <vprintf+0xa2>
 888:	fdc42783          	lw	a5,-36(s0)
 88c:	0785                	addi	a5,a5,1
 88e:	fc043703          	ld	a4,-64(s0)
 892:	97ba                	add	a5,a5,a4
 894:	0007c783          	lbu	a5,0(a5)
 898:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 89c:	fe442783          	lw	a5,-28(s0)
 8a0:	2781                	sext.w	a5,a5
 8a2:	cb99                	beqz	a5,8b8 <vprintf+0xbe>
 8a4:	fdc42783          	lw	a5,-36(s0)
 8a8:	0789                	addi	a5,a5,2
 8aa:	fc043703          	ld	a4,-64(s0)
 8ae:	97ba                	add	a5,a5,a4
 8b0:	0007c783          	lbu	a5,0(a5)
 8b4:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 8b8:	fd442783          	lw	a5,-44(s0)
 8bc:	0007871b          	sext.w	a4,a5
 8c0:	06400793          	li	a5,100
 8c4:	02f71363          	bne	a4,a5,8ea <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8c8:	fb843783          	ld	a5,-72(s0)
 8cc:	00878713          	addi	a4,a5,8
 8d0:	fae43c23          	sd	a4,-72(s0)
 8d4:	439c                	lw	a5,0(a5)
 8d6:	873e                	mv	a4,a5
 8d8:	fcc42783          	lw	a5,-52(s0)
 8dc:	4685                	li	a3,1
 8de:	4629                	li	a2,10
 8e0:	85ba                	mv	a1,a4
 8e2:	853e                	mv	a0,a5
 8e4:	da7ff0ef          	jal	68a <printint>
 8e8:	a695                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8ea:	fd442783          	lw	a5,-44(s0)
 8ee:	0007871b          	sext.w	a4,a5
 8f2:	06c00793          	li	a5,108
 8f6:	04f71063          	bne	a4,a5,936 <vprintf+0x13c>
 8fa:	fe442783          	lw	a5,-28(s0)
 8fe:	0007871b          	sext.w	a4,a5
 902:	06400793          	li	a5,100
 906:	02f71863          	bne	a4,a5,936 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 90a:	fb843783          	ld	a5,-72(s0)
 90e:	00878713          	addi	a4,a5,8
 912:	fae43c23          	sd	a4,-72(s0)
 916:	639c                	ld	a5,0(a5)
 918:	873e                	mv	a4,a5
 91a:	fcc42783          	lw	a5,-52(s0)
 91e:	4685                	li	a3,1
 920:	4629                	li	a2,10
 922:	85ba                	mv	a1,a4
 924:	853e                	mv	a0,a5
 926:	d65ff0ef          	jal	68a <printint>
        i += 1;
 92a:	fdc42783          	lw	a5,-36(s0)
 92e:	2785                	addiw	a5,a5,1
 930:	fcf42e23          	sw	a5,-36(s0)
 934:	ae21                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 936:	fd442783          	lw	a5,-44(s0)
 93a:	0007871b          	sext.w	a4,a5
 93e:	06c00793          	li	a5,108
 942:	04f71863          	bne	a4,a5,992 <vprintf+0x198>
 946:	fe442783          	lw	a5,-28(s0)
 94a:	0007871b          	sext.w	a4,a5
 94e:	06c00793          	li	a5,108
 952:	04f71063          	bne	a4,a5,992 <vprintf+0x198>
 956:	fe042783          	lw	a5,-32(s0)
 95a:	0007871b          	sext.w	a4,a5
 95e:	06400793          	li	a5,100
 962:	02f71863          	bne	a4,a5,992 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 966:	fb843783          	ld	a5,-72(s0)
 96a:	00878713          	addi	a4,a5,8
 96e:	fae43c23          	sd	a4,-72(s0)
 972:	639c                	ld	a5,0(a5)
 974:	873e                	mv	a4,a5
 976:	fcc42783          	lw	a5,-52(s0)
 97a:	4685                	li	a3,1
 97c:	4629                	li	a2,10
 97e:	85ba                	mv	a1,a4
 980:	853e                	mv	a0,a5
 982:	d09ff0ef          	jal	68a <printint>
        i += 2;
 986:	fdc42783          	lw	a5,-36(s0)
 98a:	2789                	addiw	a5,a5,2
 98c:	fcf42e23          	sw	a5,-36(s0)
 990:	ac75                	j	c4c <vprintf+0x452>
      } else if(c0 == 'u'){
 992:	fd442783          	lw	a5,-44(s0)
 996:	0007871b          	sext.w	a4,a5
 99a:	07500793          	li	a5,117
 99e:	02f71563          	bne	a4,a5,9c8 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9a2:	fb843783          	ld	a5,-72(s0)
 9a6:	00878713          	addi	a4,a5,8
 9aa:	fae43c23          	sd	a4,-72(s0)
 9ae:	439c                	lw	a5,0(a5)
 9b0:	02079713          	slli	a4,a5,0x20
 9b4:	9301                	srli	a4,a4,0x20
 9b6:	fcc42783          	lw	a5,-52(s0)
 9ba:	4681                	li	a3,0
 9bc:	4629                	li	a2,10
 9be:	85ba                	mv	a1,a4
 9c0:	853e                	mv	a0,a5
 9c2:	cc9ff0ef          	jal	68a <printint>
 9c6:	a459                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9c8:	fd442783          	lw	a5,-44(s0)
 9cc:	0007871b          	sext.w	a4,a5
 9d0:	06c00793          	li	a5,108
 9d4:	04f71063          	bne	a4,a5,a14 <vprintf+0x21a>
 9d8:	fe442783          	lw	a5,-28(s0)
 9dc:	0007871b          	sext.w	a4,a5
 9e0:	07500793          	li	a5,117
 9e4:	02f71863          	bne	a4,a5,a14 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9e8:	fb843783          	ld	a5,-72(s0)
 9ec:	00878713          	addi	a4,a5,8
 9f0:	fae43c23          	sd	a4,-72(s0)
 9f4:	639c                	ld	a5,0(a5)
 9f6:	873e                	mv	a4,a5
 9f8:	fcc42783          	lw	a5,-52(s0)
 9fc:	4681                	li	a3,0
 9fe:	4629                	li	a2,10
 a00:	85ba                	mv	a1,a4
 a02:	853e                	mv	a0,a5
 a04:	c87ff0ef          	jal	68a <printint>
        i += 1;
 a08:	fdc42783          	lw	a5,-36(s0)
 a0c:	2785                	addiw	a5,a5,1
 a0e:	fcf42e23          	sw	a5,-36(s0)
 a12:	ac2d                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a14:	fd442783          	lw	a5,-44(s0)
 a18:	0007871b          	sext.w	a4,a5
 a1c:	06c00793          	li	a5,108
 a20:	04f71863          	bne	a4,a5,a70 <vprintf+0x276>
 a24:	fe442783          	lw	a5,-28(s0)
 a28:	0007871b          	sext.w	a4,a5
 a2c:	06c00793          	li	a5,108
 a30:	04f71063          	bne	a4,a5,a70 <vprintf+0x276>
 a34:	fe042783          	lw	a5,-32(s0)
 a38:	0007871b          	sext.w	a4,a5
 a3c:	07500793          	li	a5,117
 a40:	02f71863          	bne	a4,a5,a70 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a44:	fb843783          	ld	a5,-72(s0)
 a48:	00878713          	addi	a4,a5,8
 a4c:	fae43c23          	sd	a4,-72(s0)
 a50:	639c                	ld	a5,0(a5)
 a52:	873e                	mv	a4,a5
 a54:	fcc42783          	lw	a5,-52(s0)
 a58:	4681                	li	a3,0
 a5a:	4629                	li	a2,10
 a5c:	85ba                	mv	a1,a4
 a5e:	853e                	mv	a0,a5
 a60:	c2bff0ef          	jal	68a <printint>
        i += 2;
 a64:	fdc42783          	lw	a5,-36(s0)
 a68:	2789                	addiw	a5,a5,2
 a6a:	fcf42e23          	sw	a5,-36(s0)
 a6e:	aaf9                	j	c4c <vprintf+0x452>
      } else if(c0 == 'x'){
 a70:	fd442783          	lw	a5,-44(s0)
 a74:	0007871b          	sext.w	a4,a5
 a78:	07800793          	li	a5,120
 a7c:	02f71563          	bne	a4,a5,aa6 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a80:	fb843783          	ld	a5,-72(s0)
 a84:	00878713          	addi	a4,a5,8
 a88:	fae43c23          	sd	a4,-72(s0)
 a8c:	439c                	lw	a5,0(a5)
 a8e:	02079713          	slli	a4,a5,0x20
 a92:	9301                	srli	a4,a4,0x20
 a94:	fcc42783          	lw	a5,-52(s0)
 a98:	4681                	li	a3,0
 a9a:	4641                	li	a2,16
 a9c:	85ba                	mv	a1,a4
 a9e:	853e                	mv	a0,a5
 aa0:	bebff0ef          	jal	68a <printint>
 aa4:	a265                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 aa6:	fd442783          	lw	a5,-44(s0)
 aaa:	0007871b          	sext.w	a4,a5
 aae:	06c00793          	li	a5,108
 ab2:	04f71063          	bne	a4,a5,af2 <vprintf+0x2f8>
 ab6:	fe442783          	lw	a5,-28(s0)
 aba:	0007871b          	sext.w	a4,a5
 abe:	07800793          	li	a5,120
 ac2:	02f71863          	bne	a4,a5,af2 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ac6:	fb843783          	ld	a5,-72(s0)
 aca:	00878713          	addi	a4,a5,8
 ace:	fae43c23          	sd	a4,-72(s0)
 ad2:	639c                	ld	a5,0(a5)
 ad4:	873e                	mv	a4,a5
 ad6:	fcc42783          	lw	a5,-52(s0)
 ada:	4681                	li	a3,0
 adc:	4641                	li	a2,16
 ade:	85ba                	mv	a1,a4
 ae0:	853e                	mv	a0,a5
 ae2:	ba9ff0ef          	jal	68a <printint>
        i += 1;
 ae6:	fdc42783          	lw	a5,-36(s0)
 aea:	2785                	addiw	a5,a5,1
 aec:	fcf42e23          	sw	a5,-36(s0)
 af0:	aab1                	j	c4c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 af2:	fd442783          	lw	a5,-44(s0)
 af6:	0007871b          	sext.w	a4,a5
 afa:	06c00793          	li	a5,108
 afe:	04f71863          	bne	a4,a5,b4e <vprintf+0x354>
 b02:	fe442783          	lw	a5,-28(s0)
 b06:	0007871b          	sext.w	a4,a5
 b0a:	06c00793          	li	a5,108
 b0e:	04f71063          	bne	a4,a5,b4e <vprintf+0x354>
 b12:	fe042783          	lw	a5,-32(s0)
 b16:	0007871b          	sext.w	a4,a5
 b1a:	07800793          	li	a5,120
 b1e:	02f71863          	bne	a4,a5,b4e <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b22:	fb843783          	ld	a5,-72(s0)
 b26:	00878713          	addi	a4,a5,8
 b2a:	fae43c23          	sd	a4,-72(s0)
 b2e:	639c                	ld	a5,0(a5)
 b30:	873e                	mv	a4,a5
 b32:	fcc42783          	lw	a5,-52(s0)
 b36:	4681                	li	a3,0
 b38:	4641                	li	a2,16
 b3a:	85ba                	mv	a1,a4
 b3c:	853e                	mv	a0,a5
 b3e:	b4dff0ef          	jal	68a <printint>
        i += 2;
 b42:	fdc42783          	lw	a5,-36(s0)
 b46:	2789                	addiw	a5,a5,2
 b48:	fcf42e23          	sw	a5,-36(s0)
 b4c:	a201                	j	c4c <vprintf+0x452>
      } else if(c0 == 'p'){
 b4e:	fd442783          	lw	a5,-44(s0)
 b52:	0007871b          	sext.w	a4,a5
 b56:	07000793          	li	a5,112
 b5a:	02f71063          	bne	a4,a5,b7a <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b5e:	fb843783          	ld	a5,-72(s0)
 b62:	00878713          	addi	a4,a5,8
 b66:	fae43c23          	sd	a4,-72(s0)
 b6a:	6398                	ld	a4,0(a5)
 b6c:	fcc42783          	lw	a5,-52(s0)
 b70:	85ba                	mv	a1,a4
 b72:	853e                	mv	a0,a5
 b74:	c09ff0ef          	jal	77c <printptr>
 b78:	a8d1                	j	c4c <vprintf+0x452>
      } else if(c0 == 'c'){
 b7a:	fd442783          	lw	a5,-44(s0)
 b7e:	0007871b          	sext.w	a4,a5
 b82:	06300793          	li	a5,99
 b86:	02f71263          	bne	a4,a5,baa <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b8a:	fb843783          	ld	a5,-72(s0)
 b8e:	00878713          	addi	a4,a5,8
 b92:	fae43c23          	sd	a4,-72(s0)
 b96:	439c                	lw	a5,0(a5)
 b98:	0ff7f713          	zext.b	a4,a5
 b9c:	fcc42783          	lw	a5,-52(s0)
 ba0:	85ba                	mv	a1,a4
 ba2:	853e                	mv	a0,a5
 ba4:	ab5ff0ef          	jal	658 <putc>
 ba8:	a055                	j	c4c <vprintf+0x452>
      } else if(c0 == 's'){
 baa:	fd442783          	lw	a5,-44(s0)
 bae:	0007871b          	sext.w	a4,a5
 bb2:	07300793          	li	a5,115
 bb6:	04f71a63          	bne	a4,a5,c0a <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 bba:	fb843783          	ld	a5,-72(s0)
 bbe:	00878713          	addi	a4,a5,8
 bc2:	fae43c23          	sd	a4,-72(s0)
 bc6:	639c                	ld	a5,0(a5)
 bc8:	fef43423          	sd	a5,-24(s0)
 bcc:	fe843783          	ld	a5,-24(s0)
 bd0:	e79d                	bnez	a5,bfe <vprintf+0x404>
          s = "(null)";
 bd2:	00000797          	auipc	a5,0x0
 bd6:	45678793          	addi	a5,a5,1110 # 1028 <malloc+0x174>
 bda:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 bde:	a005                	j	bfe <vprintf+0x404>
          putc(fd, *s);
 be0:	fe843783          	ld	a5,-24(s0)
 be4:	0007c703          	lbu	a4,0(a5)
 be8:	fcc42783          	lw	a5,-52(s0)
 bec:	85ba                	mv	a1,a4
 bee:	853e                	mv	a0,a5
 bf0:	a69ff0ef          	jal	658 <putc>
        for(; *s; s++)
 bf4:	fe843783          	ld	a5,-24(s0)
 bf8:	0785                	addi	a5,a5,1
 bfa:	fef43423          	sd	a5,-24(s0)
 bfe:	fe843783          	ld	a5,-24(s0)
 c02:	0007c783          	lbu	a5,0(a5)
 c06:	ffe9                	bnez	a5,be0 <vprintf+0x3e6>
 c08:	a091                	j	c4c <vprintf+0x452>
      } else if(c0 == '%'){
 c0a:	fd442783          	lw	a5,-44(s0)
 c0e:	0007871b          	sext.w	a4,a5
 c12:	02500793          	li	a5,37
 c16:	00f71a63          	bne	a4,a5,c2a <vprintf+0x430>
        putc(fd, '%');
 c1a:	fcc42783          	lw	a5,-52(s0)
 c1e:	02500593          	li	a1,37
 c22:	853e                	mv	a0,a5
 c24:	a35ff0ef          	jal	658 <putc>
 c28:	a015                	j	c4c <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c2a:	fcc42783          	lw	a5,-52(s0)
 c2e:	02500593          	li	a1,37
 c32:	853e                	mv	a0,a5
 c34:	a25ff0ef          	jal	658 <putc>
        putc(fd, c0);
 c38:	fd442783          	lw	a5,-44(s0)
 c3c:	0ff7f713          	zext.b	a4,a5
 c40:	fcc42783          	lw	a5,-52(s0)
 c44:	85ba                	mv	a1,a4
 c46:	853e                	mv	a0,a5
 c48:	a11ff0ef          	jal	658 <putc>
      }

      state = 0;
 c4c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c50:	fdc42783          	lw	a5,-36(s0)
 c54:	2785                	addiw	a5,a5,1
 c56:	fcf42e23          	sw	a5,-36(s0)
 c5a:	fdc42783          	lw	a5,-36(s0)
 c5e:	fc043703          	ld	a4,-64(s0)
 c62:	97ba                	add	a5,a5,a4
 c64:	0007c783          	lbu	a5,0(a5)
 c68:	ba0799e3          	bnez	a5,81a <vprintf+0x20>
    }
  }
}
 c6c:	0001                	nop
 c6e:	0001                	nop
 c70:	60a6                	ld	ra,72(sp)
 c72:	6406                	ld	s0,64(sp)
 c74:	6161                	addi	sp,sp,80
 c76:	8082                	ret

0000000000000c78 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c78:	7159                	addi	sp,sp,-112
 c7a:	fc06                	sd	ra,56(sp)
 c7c:	f822                	sd	s0,48(sp)
 c7e:	0080                	addi	s0,sp,64
 c80:	fcb43823          	sd	a1,-48(s0)
 c84:	e010                	sd	a2,0(s0)
 c86:	e414                	sd	a3,8(s0)
 c88:	e818                	sd	a4,16(s0)
 c8a:	ec1c                	sd	a5,24(s0)
 c8c:	03043023          	sd	a6,32(s0)
 c90:	03143423          	sd	a7,40(s0)
 c94:	87aa                	mv	a5,a0
 c96:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c9a:	03040793          	addi	a5,s0,48
 c9e:	fcf43423          	sd	a5,-56(s0)
 ca2:	fc843783          	ld	a5,-56(s0)
 ca6:	fd078793          	addi	a5,a5,-48
 caa:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 cae:	fe843703          	ld	a4,-24(s0)
 cb2:	fdc42783          	lw	a5,-36(s0)
 cb6:	863a                	mv	a2,a4
 cb8:	fd043583          	ld	a1,-48(s0)
 cbc:	853e                	mv	a0,a5
 cbe:	b3dff0ef          	jal	7fa <vprintf>
}
 cc2:	0001                	nop
 cc4:	70e2                	ld	ra,56(sp)
 cc6:	7442                	ld	s0,48(sp)
 cc8:	6165                	addi	sp,sp,112
 cca:	8082                	ret

0000000000000ccc <printf>:

void
printf(const char *fmt, ...)
{
 ccc:	7159                	addi	sp,sp,-112
 cce:	f406                	sd	ra,40(sp)
 cd0:	f022                	sd	s0,32(sp)
 cd2:	1800                	addi	s0,sp,48
 cd4:	fca43c23          	sd	a0,-40(s0)
 cd8:	e40c                	sd	a1,8(s0)
 cda:	e810                	sd	a2,16(s0)
 cdc:	ec14                	sd	a3,24(s0)
 cde:	f018                	sd	a4,32(s0)
 ce0:	f41c                	sd	a5,40(s0)
 ce2:	03043823          	sd	a6,48(s0)
 ce6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cea:	04040793          	addi	a5,s0,64
 cee:	fcf43823          	sd	a5,-48(s0)
 cf2:	fd043783          	ld	a5,-48(s0)
 cf6:	fc878793          	addi	a5,a5,-56
 cfa:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 cfe:	fe843783          	ld	a5,-24(s0)
 d02:	863e                	mv	a2,a5
 d04:	fd843583          	ld	a1,-40(s0)
 d08:	4505                	li	a0,1
 d0a:	af1ff0ef          	jal	7fa <vprintf>
}
 d0e:	0001                	nop
 d10:	70a2                	ld	ra,40(sp)
 d12:	7402                	ld	s0,32(sp)
 d14:	6165                	addi	sp,sp,112
 d16:	8082                	ret

0000000000000d18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d18:	7179                	addi	sp,sp,-48
 d1a:	f406                	sd	ra,40(sp)
 d1c:	f022                	sd	s0,32(sp)
 d1e:	1800                	addi	s0,sp,48
 d20:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d24:	fd843783          	ld	a5,-40(s0)
 d28:	17c1                	addi	a5,a5,-16
 d2a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d2e:	00001797          	auipc	a5,0x1
 d32:	30278793          	addi	a5,a5,770 # 2030 <freep>
 d36:	639c                	ld	a5,0(a5)
 d38:	fef43423          	sd	a5,-24(s0)
 d3c:	a815                	j	d70 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d3e:	fe843783          	ld	a5,-24(s0)
 d42:	639c                	ld	a5,0(a5)
 d44:	fe843703          	ld	a4,-24(s0)
 d48:	00f76f63          	bltu	a4,a5,d66 <free+0x4e>
 d4c:	fe043703          	ld	a4,-32(s0)
 d50:	fe843783          	ld	a5,-24(s0)
 d54:	02e7eb63          	bltu	a5,a4,d8a <free+0x72>
 d58:	fe843783          	ld	a5,-24(s0)
 d5c:	639c                	ld	a5,0(a5)
 d5e:	fe043703          	ld	a4,-32(s0)
 d62:	02f76463          	bltu	a4,a5,d8a <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d66:	fe843783          	ld	a5,-24(s0)
 d6a:	639c                	ld	a5,0(a5)
 d6c:	fef43423          	sd	a5,-24(s0)
 d70:	fe043703          	ld	a4,-32(s0)
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	fce7f3e3          	bgeu	a5,a4,d3e <free+0x26>
 d7c:	fe843783          	ld	a5,-24(s0)
 d80:	639c                	ld	a5,0(a5)
 d82:	fe043703          	ld	a4,-32(s0)
 d86:	faf77ce3          	bgeu	a4,a5,d3e <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d8a:	fe043783          	ld	a5,-32(s0)
 d8e:	479c                	lw	a5,8(a5)
 d90:	1782                	slli	a5,a5,0x20
 d92:	9381                	srli	a5,a5,0x20
 d94:	0792                	slli	a5,a5,0x4
 d96:	fe043703          	ld	a4,-32(s0)
 d9a:	973e                	add	a4,a4,a5
 d9c:	fe843783          	ld	a5,-24(s0)
 da0:	639c                	ld	a5,0(a5)
 da2:	02f71763          	bne	a4,a5,dd0 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 da6:	fe043783          	ld	a5,-32(s0)
 daa:	4798                	lw	a4,8(a5)
 dac:	fe843783          	ld	a5,-24(s0)
 db0:	639c                	ld	a5,0(a5)
 db2:	479c                	lw	a5,8(a5)
 db4:	9fb9                	addw	a5,a5,a4
 db6:	0007871b          	sext.w	a4,a5
 dba:	fe043783          	ld	a5,-32(s0)
 dbe:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 dc0:	fe843783          	ld	a5,-24(s0)
 dc4:	639c                	ld	a5,0(a5)
 dc6:	6398                	ld	a4,0(a5)
 dc8:	fe043783          	ld	a5,-32(s0)
 dcc:	e398                	sd	a4,0(a5)
 dce:	a039                	j	ddc <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 dd0:	fe843783          	ld	a5,-24(s0)
 dd4:	6398                	ld	a4,0(a5)
 dd6:	fe043783          	ld	a5,-32(s0)
 dda:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 ddc:	fe843783          	ld	a5,-24(s0)
 de0:	479c                	lw	a5,8(a5)
 de2:	1782                	slli	a5,a5,0x20
 de4:	9381                	srli	a5,a5,0x20
 de6:	0792                	slli	a5,a5,0x4
 de8:	fe843703          	ld	a4,-24(s0)
 dec:	97ba                	add	a5,a5,a4
 dee:	fe043703          	ld	a4,-32(s0)
 df2:	02f71563          	bne	a4,a5,e1c <free+0x104>
    p->s.size += bp->s.size;
 df6:	fe843783          	ld	a5,-24(s0)
 dfa:	4798                	lw	a4,8(a5)
 dfc:	fe043783          	ld	a5,-32(s0)
 e00:	479c                	lw	a5,8(a5)
 e02:	9fb9                	addw	a5,a5,a4
 e04:	0007871b          	sext.w	a4,a5
 e08:	fe843783          	ld	a5,-24(s0)
 e0c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 e0e:	fe043783          	ld	a5,-32(s0)
 e12:	6398                	ld	a4,0(a5)
 e14:	fe843783          	ld	a5,-24(s0)
 e18:	e398                	sd	a4,0(a5)
 e1a:	a031                	j	e26 <free+0x10e>
  } else
    p->s.ptr = bp;
 e1c:	fe843783          	ld	a5,-24(s0)
 e20:	fe043703          	ld	a4,-32(s0)
 e24:	e398                	sd	a4,0(a5)
  freep = p;
 e26:	00001797          	auipc	a5,0x1
 e2a:	20a78793          	addi	a5,a5,522 # 2030 <freep>
 e2e:	fe843703          	ld	a4,-24(s0)
 e32:	e398                	sd	a4,0(a5)
}
 e34:	0001                	nop
 e36:	70a2                	ld	ra,40(sp)
 e38:	7402                	ld	s0,32(sp)
 e3a:	6145                	addi	sp,sp,48
 e3c:	8082                	ret

0000000000000e3e <morecore>:

static Header*
morecore(uint nu)
{
 e3e:	7179                	addi	sp,sp,-48
 e40:	f406                	sd	ra,40(sp)
 e42:	f022                	sd	s0,32(sp)
 e44:	1800                	addi	s0,sp,48
 e46:	87aa                	mv	a5,a0
 e48:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e4c:	fdc42783          	lw	a5,-36(s0)
 e50:	0007871b          	sext.w	a4,a5
 e54:	6785                	lui	a5,0x1
 e56:	00f77563          	bgeu	a4,a5,e60 <morecore+0x22>
    nu = 4096;
 e5a:	6785                	lui	a5,0x1
 e5c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e60:	fdc42783          	lw	a5,-36(s0)
 e64:	0047979b          	slliw	a5,a5,0x4
 e68:	2781                	sext.w	a5,a5
 e6a:	853e                	mv	a0,a5
 e6c:	ef0ff0ef          	jal	55c <sbrk>
 e70:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e74:	fe843703          	ld	a4,-24(s0)
 e78:	57fd                	li	a5,-1
 e7a:	00f71463          	bne	a4,a5,e82 <morecore+0x44>
    return 0;
 e7e:	4781                	li	a5,0
 e80:	a02d                	j	eaa <morecore+0x6c>
  hp = (Header*)p;
 e82:	fe843783          	ld	a5,-24(s0)
 e86:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e8a:	fe043783          	ld	a5,-32(s0)
 e8e:	fdc42703          	lw	a4,-36(s0)
 e92:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e94:	fe043783          	ld	a5,-32(s0)
 e98:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x15c>
 e9a:	853e                	mv	a0,a5
 e9c:	e7dff0ef          	jal	d18 <free>
  return freep;
 ea0:	00001797          	auipc	a5,0x1
 ea4:	19078793          	addi	a5,a5,400 # 2030 <freep>
 ea8:	639c                	ld	a5,0(a5)
}
 eaa:	853e                	mv	a0,a5
 eac:	70a2                	ld	ra,40(sp)
 eae:	7402                	ld	s0,32(sp)
 eb0:	6145                	addi	sp,sp,48
 eb2:	8082                	ret

0000000000000eb4 <malloc>:

void*
malloc(uint nbytes)
{
 eb4:	7139                	addi	sp,sp,-64
 eb6:	fc06                	sd	ra,56(sp)
 eb8:	f822                	sd	s0,48(sp)
 eba:	0080                	addi	s0,sp,64
 ebc:	87aa                	mv	a5,a0
 ebe:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ec2:	fcc46783          	lwu	a5,-52(s0)
 ec6:	07bd                	addi	a5,a5,15
 ec8:	8391                	srli	a5,a5,0x4
 eca:	2781                	sext.w	a5,a5
 ecc:	2785                	addiw	a5,a5,1
 ece:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ed2:	00001797          	auipc	a5,0x1
 ed6:	15e78793          	addi	a5,a5,350 # 2030 <freep>
 eda:	639c                	ld	a5,0(a5)
 edc:	fef43023          	sd	a5,-32(s0)
 ee0:	fe043783          	ld	a5,-32(s0)
 ee4:	ef95                	bnez	a5,f20 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ee6:	00001797          	auipc	a5,0x1
 eea:	13a78793          	addi	a5,a5,314 # 2020 <base>
 eee:	fef43023          	sd	a5,-32(s0)
 ef2:	00001797          	auipc	a5,0x1
 ef6:	13e78793          	addi	a5,a5,318 # 2030 <freep>
 efa:	fe043703          	ld	a4,-32(s0)
 efe:	e398                	sd	a4,0(a5)
 f00:	00001797          	auipc	a5,0x1
 f04:	13078793          	addi	a5,a5,304 # 2030 <freep>
 f08:	6398                	ld	a4,0(a5)
 f0a:	00001797          	auipc	a5,0x1
 f0e:	11678793          	addi	a5,a5,278 # 2020 <base>
 f12:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 f14:	00001797          	auipc	a5,0x1
 f18:	10c78793          	addi	a5,a5,268 # 2020 <base>
 f1c:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f20:	fe043783          	ld	a5,-32(s0)
 f24:	639c                	ld	a5,0(a5)
 f26:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f2a:	fe843783          	ld	a5,-24(s0)
 f2e:	479c                	lw	a5,8(a5)
 f30:	fdc42703          	lw	a4,-36(s0)
 f34:	2701                	sext.w	a4,a4
 f36:	06e7e763          	bltu	a5,a4,fa4 <malloc+0xf0>
      if(p->s.size == nunits)
 f3a:	fe843783          	ld	a5,-24(s0)
 f3e:	479c                	lw	a5,8(a5)
 f40:	fdc42703          	lw	a4,-36(s0)
 f44:	2701                	sext.w	a4,a4
 f46:	00f71963          	bne	a4,a5,f58 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f4a:	fe843783          	ld	a5,-24(s0)
 f4e:	6398                	ld	a4,0(a5)
 f50:	fe043783          	ld	a5,-32(s0)
 f54:	e398                	sd	a4,0(a5)
 f56:	a825                	j	f8e <malloc+0xda>
      else {
        p->s.size -= nunits;
 f58:	fe843783          	ld	a5,-24(s0)
 f5c:	479c                	lw	a5,8(a5)
 f5e:	fdc42703          	lw	a4,-36(s0)
 f62:	9f99                	subw	a5,a5,a4
 f64:	0007871b          	sext.w	a4,a5
 f68:	fe843783          	ld	a5,-24(s0)
 f6c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f6e:	fe843783          	ld	a5,-24(s0)
 f72:	479c                	lw	a5,8(a5)
 f74:	1782                	slli	a5,a5,0x20
 f76:	9381                	srli	a5,a5,0x20
 f78:	0792                	slli	a5,a5,0x4
 f7a:	fe843703          	ld	a4,-24(s0)
 f7e:	97ba                	add	a5,a5,a4
 f80:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f84:	fe843783          	ld	a5,-24(s0)
 f88:	fdc42703          	lw	a4,-36(s0)
 f8c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f8e:	00001797          	auipc	a5,0x1
 f92:	0a278793          	addi	a5,a5,162 # 2030 <freep>
 f96:	fe043703          	ld	a4,-32(s0)
 f9a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f9c:	fe843783          	ld	a5,-24(s0)
 fa0:	07c1                	addi	a5,a5,16
 fa2:	a081                	j	fe2 <malloc+0x12e>
    }
    if(p == freep)
 fa4:	00001797          	auipc	a5,0x1
 fa8:	08c78793          	addi	a5,a5,140 # 2030 <freep>
 fac:	639c                	ld	a5,0(a5)
 fae:	fe843703          	ld	a4,-24(s0)
 fb2:	00f71e63          	bne	a4,a5,fce <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 fb6:	fdc42783          	lw	a5,-36(s0)
 fba:	853e                	mv	a0,a5
 fbc:	e83ff0ef          	jal	e3e <morecore>
 fc0:	fea43423          	sd	a0,-24(s0)
 fc4:	fe843783          	ld	a5,-24(s0)
 fc8:	e399                	bnez	a5,fce <malloc+0x11a>
        return 0;
 fca:	4781                	li	a5,0
 fcc:	a819                	j	fe2 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fce:	fe843783          	ld	a5,-24(s0)
 fd2:	fef43023          	sd	a5,-32(s0)
 fd6:	fe843783          	ld	a5,-24(s0)
 fda:	639c                	ld	a5,0(a5)
 fdc:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 fe0:	b7a9                	j	f2a <malloc+0x76>
  }
}
 fe2:	853e                	mv	a0,a5
 fe4:	70e2                	ld	ra,56(sp)
 fe6:	7442                	ld	s0,48(sp)
 fe8:	6121                	addi	sp,sp,64
 fea:	8082                	ret
