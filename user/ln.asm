
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	87aa                	mv	a5,a0
   a:	feb43023          	sd	a1,-32(s0)
   e:	fef42623          	sw	a5,-20(s0)
  if(argc != 3){
  12:	fec42783          	lw	a5,-20(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	478d                	li	a5,3
  1c:	00f70c63          	beq	a4,a5,34 <main+0x34>
    fprintf(2, "Usage: ln old new\n");
  20:	00001597          	auipc	a1,0x1
  24:	fc058593          	addi	a1,a1,-64 # fe0 <malloc+0x142>
  28:	4509                	li	a0,2
  2a:	439000ef          	jal	c62 <fprintf>
    exit(1);
  2e:	4505                	li	a0,1
  30:	562000ef          	jal	592 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  34:	fe043783          	ld	a5,-32(s0)
  38:	07a1                	addi	a5,a5,8
  3a:	6398                	ld	a4,0(a5)
  3c:	fe043783          	ld	a5,-32(s0)
  40:	07c1                	addi	a5,a5,16
  42:	639c                	ld	a5,0(a5)
  44:	85be                	mv	a1,a5
  46:	853a                	mv	a0,a4
  48:	5aa000ef          	jal	5f2 <link>
  4c:	87aa                	mv	a5,a0
  4e:	0207d363          	bgez	a5,74 <main+0x74>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  52:	fe043783          	ld	a5,-32(s0)
  56:	07a1                	addi	a5,a5,8
  58:	6398                	ld	a4,0(a5)
  5a:	fe043783          	ld	a5,-32(s0)
  5e:	07c1                	addi	a5,a5,16
  60:	639c                	ld	a5,0(a5)
  62:	86be                	mv	a3,a5
  64:	863a                	mv	a2,a4
  66:	00001597          	auipc	a1,0x1
  6a:	f9258593          	addi	a1,a1,-110 # ff8 <malloc+0x15a>
  6e:	4509                	li	a0,2
  70:	3f3000ef          	jal	c62 <fprintf>
  exit(0);
  74:	4501                	li	a0,0
  76:	51c000ef          	jal	592 <exit>

000000000000007a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  7a:	7179                	addi	sp,sp,-48
  7c:	f406                	sd	ra,40(sp)
  7e:	f022                	sd	s0,32(sp)
  80:	1800                	addi	s0,sp,48
  82:	87aa                	mv	a5,a0
  84:	fcb43823          	sd	a1,-48(s0)
  88:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  8c:	fdc42783          	lw	a5,-36(s0)
  90:	fd043583          	ld	a1,-48(s0)
  94:	853e                	mv	a0,a5
  96:	f6bff0ef          	jal	0 <main>
  9a:	87aa                	mv	a5,a0
  9c:	fef42623          	sw	a5,-20(s0)
  exit(r);
  a0:	fec42783          	lw	a5,-20(s0)
  a4:	853e                	mv	a0,a5
  a6:	4ec000ef          	jal	592 <exit>

00000000000000aa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  aa:	7179                	addi	sp,sp,-48
  ac:	f406                	sd	ra,40(sp)
  ae:	f022                	sd	s0,32(sp)
  b0:	1800                	addi	s0,sp,48
  b2:	fca43c23          	sd	a0,-40(s0)
  b6:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  ba:	fd843783          	ld	a5,-40(s0)
  be:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  c2:	0001                	nop
  c4:	fd043703          	ld	a4,-48(s0)
  c8:	00170793          	addi	a5,a4,1
  cc:	fcf43823          	sd	a5,-48(s0)
  d0:	fd843783          	ld	a5,-40(s0)
  d4:	00178693          	addi	a3,a5,1
  d8:	fcd43c23          	sd	a3,-40(s0)
  dc:	00074703          	lbu	a4,0(a4)
  e0:	00e78023          	sb	a4,0(a5)
  e4:	0007c783          	lbu	a5,0(a5)
  e8:	fff1                	bnez	a5,c4 <strcpy+0x1a>
    ;
  return os;
  ea:	fe843783          	ld	a5,-24(s0)
}
  ee:	853e                	mv	a0,a5
  f0:	70a2                	ld	ra,40(sp)
  f2:	7402                	ld	s0,32(sp)
  f4:	6145                	addi	sp,sp,48
  f6:	8082                	ret

00000000000000f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f8:	1101                	addi	sp,sp,-32
  fa:	ec06                	sd	ra,24(sp)
  fc:	e822                	sd	s0,16(sp)
  fe:	1000                	addi	s0,sp,32
 100:	fea43423          	sd	a0,-24(s0)
 104:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 108:	a819                	j	11e <strcmp+0x26>
    p++, q++;
 10a:	fe843783          	ld	a5,-24(s0)
 10e:	0785                	addi	a5,a5,1
 110:	fef43423          	sd	a5,-24(s0)
 114:	fe043783          	ld	a5,-32(s0)
 118:	0785                	addi	a5,a5,1
 11a:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 11e:	fe843783          	ld	a5,-24(s0)
 122:	0007c783          	lbu	a5,0(a5)
 126:	cb99                	beqz	a5,13c <strcmp+0x44>
 128:	fe843783          	ld	a5,-24(s0)
 12c:	0007c703          	lbu	a4,0(a5)
 130:	fe043783          	ld	a5,-32(s0)
 134:	0007c783          	lbu	a5,0(a5)
 138:	fcf709e3          	beq	a4,a5,10a <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 13c:	fe843783          	ld	a5,-24(s0)
 140:	0007c783          	lbu	a5,0(a5)
 144:	0007871b          	sext.w	a4,a5
 148:	fe043783          	ld	a5,-32(s0)
 14c:	0007c783          	lbu	a5,0(a5)
 150:	2781                	sext.w	a5,a5
 152:	40f707bb          	subw	a5,a4,a5
 156:	2781                	sext.w	a5,a5
}
 158:	853e                	mv	a0,a5
 15a:	60e2                	ld	ra,24(sp)
 15c:	6442                	ld	s0,16(sp)
 15e:	6105                	addi	sp,sp,32
 160:	8082                	ret

0000000000000162 <strlen>:

uint
strlen(const char *s)
{
 162:	7179                	addi	sp,sp,-48
 164:	f406                	sd	ra,40(sp)
 166:	f022                	sd	s0,32(sp)
 168:	1800                	addi	s0,sp,48
 16a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 16e:	fe042623          	sw	zero,-20(s0)
 172:	a031                	j	17e <strlen+0x1c>
 174:	fec42783          	lw	a5,-20(s0)
 178:	2785                	addiw	a5,a5,1
 17a:	fef42623          	sw	a5,-20(s0)
 17e:	fec42783          	lw	a5,-20(s0)
 182:	fd843703          	ld	a4,-40(s0)
 186:	97ba                	add	a5,a5,a4
 188:	0007c783          	lbu	a5,0(a5)
 18c:	f7e5                	bnez	a5,174 <strlen+0x12>
    ;
  return n;
 18e:	fec42783          	lw	a5,-20(s0)
}
 192:	853e                	mv	a0,a5
 194:	70a2                	ld	ra,40(sp)
 196:	7402                	ld	s0,32(sp)
 198:	6145                	addi	sp,sp,48
 19a:	8082                	ret

000000000000019c <memset>:

void*
memset(void *dst, int c, uint n)
{
 19c:	7179                	addi	sp,sp,-48
 19e:	f406                	sd	ra,40(sp)
 1a0:	f022                	sd	s0,32(sp)
 1a2:	1800                	addi	s0,sp,48
 1a4:	fca43c23          	sd	a0,-40(s0)
 1a8:	87ae                	mv	a5,a1
 1aa:	8732                	mv	a4,a2
 1ac:	fcf42a23          	sw	a5,-44(s0)
 1b0:	87ba                	mv	a5,a4
 1b2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1b6:	fd843783          	ld	a5,-40(s0)
 1ba:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1be:	fe042623          	sw	zero,-20(s0)
 1c2:	a00d                	j	1e4 <memset+0x48>
    cdst[i] = c;
 1c4:	fec42783          	lw	a5,-20(s0)
 1c8:	fe043703          	ld	a4,-32(s0)
 1cc:	97ba                	add	a5,a5,a4
 1ce:	fd442703          	lw	a4,-44(s0)
 1d2:	0ff77713          	zext.b	a4,a4
 1d6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1da:	fec42783          	lw	a5,-20(s0)
 1de:	2785                	addiw	a5,a5,1
 1e0:	fef42623          	sw	a5,-20(s0)
 1e4:	fec42783          	lw	a5,-20(s0)
 1e8:	fd042703          	lw	a4,-48(s0)
 1ec:	2701                	sext.w	a4,a4
 1ee:	fce7ebe3          	bltu	a5,a4,1c4 <memset+0x28>
  }
  return dst;
 1f2:	fd843783          	ld	a5,-40(s0)
}
 1f6:	853e                	mv	a0,a5
 1f8:	70a2                	ld	ra,40(sp)
 1fa:	7402                	ld	s0,32(sp)
 1fc:	6145                	addi	sp,sp,48
 1fe:	8082                	ret

0000000000000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	1101                	addi	sp,sp,-32
 202:	ec06                	sd	ra,24(sp)
 204:	e822                	sd	s0,16(sp)
 206:	1000                	addi	s0,sp,32
 208:	fea43423          	sd	a0,-24(s0)
 20c:	87ae                	mv	a5,a1
 20e:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 212:	a01d                	j	238 <strchr+0x38>
    if(*s == c)
 214:	fe843783          	ld	a5,-24(s0)
 218:	0007c703          	lbu	a4,0(a5)
 21c:	fe744783          	lbu	a5,-25(s0)
 220:	0ff7f793          	zext.b	a5,a5
 224:	00e79563          	bne	a5,a4,22e <strchr+0x2e>
      return (char*)s;
 228:	fe843783          	ld	a5,-24(s0)
 22c:	a821                	j	244 <strchr+0x44>
  for(; *s; s++)
 22e:	fe843783          	ld	a5,-24(s0)
 232:	0785                	addi	a5,a5,1
 234:	fef43423          	sd	a5,-24(s0)
 238:	fe843783          	ld	a5,-24(s0)
 23c:	0007c783          	lbu	a5,0(a5)
 240:	fbf1                	bnez	a5,214 <strchr+0x14>
  return 0;
 242:	4781                	li	a5,0
}
 244:	853e                	mv	a0,a5
 246:	60e2                	ld	ra,24(sp)
 248:	6442                	ld	s0,16(sp)
 24a:	6105                	addi	sp,sp,32
 24c:	8082                	ret

000000000000024e <gets>:

char*
gets(char *buf, int max)
{
 24e:	7179                	addi	sp,sp,-48
 250:	f406                	sd	ra,40(sp)
 252:	f022                	sd	s0,32(sp)
 254:	1800                	addi	s0,sp,48
 256:	fca43c23          	sd	a0,-40(s0)
 25a:	87ae                	mv	a5,a1
 25c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 260:	fe042623          	sw	zero,-20(s0)
 264:	a891                	j	2b8 <gets+0x6a>
    cc = read(0, &c, 1);
 266:	fe740793          	addi	a5,s0,-25
 26a:	4605                	li	a2,1
 26c:	85be                	mv	a1,a5
 26e:	4501                	li	a0,0
 270:	33a000ef          	jal	5aa <read>
 274:	87aa                	mv	a5,a0
 276:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 27a:	fe842783          	lw	a5,-24(s0)
 27e:	2781                	sext.w	a5,a5
 280:	04f05663          	blez	a5,2cc <gets+0x7e>
      break;
    buf[i++] = c;
 284:	fec42783          	lw	a5,-20(s0)
 288:	0017871b          	addiw	a4,a5,1
 28c:	fee42623          	sw	a4,-20(s0)
 290:	873e                	mv	a4,a5
 292:	fd843783          	ld	a5,-40(s0)
 296:	97ba                	add	a5,a5,a4
 298:	fe744703          	lbu	a4,-25(s0)
 29c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2a0:	fe744783          	lbu	a5,-25(s0)
 2a4:	873e                	mv	a4,a5
 2a6:	47a9                	li	a5,10
 2a8:	02f70363          	beq	a4,a5,2ce <gets+0x80>
 2ac:	fe744783          	lbu	a5,-25(s0)
 2b0:	873e                	mv	a4,a5
 2b2:	47b5                	li	a5,13
 2b4:	00f70d63          	beq	a4,a5,2ce <gets+0x80>
  for(i=0; i+1 < max; ){
 2b8:	fec42783          	lw	a5,-20(s0)
 2bc:	2785                	addiw	a5,a5,1
 2be:	2781                	sext.w	a5,a5
 2c0:	fd442703          	lw	a4,-44(s0)
 2c4:	2701                	sext.w	a4,a4
 2c6:	fae7c0e3          	blt	a5,a4,266 <gets+0x18>
 2ca:	a011                	j	2ce <gets+0x80>
      break;
 2cc:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2ce:	fec42783          	lw	a5,-20(s0)
 2d2:	fd843703          	ld	a4,-40(s0)
 2d6:	97ba                	add	a5,a5,a4
 2d8:	00078023          	sb	zero,0(a5)
  return buf;
 2dc:	fd843783          	ld	a5,-40(s0)
}
 2e0:	853e                	mv	a0,a5
 2e2:	70a2                	ld	ra,40(sp)
 2e4:	7402                	ld	s0,32(sp)
 2e6:	6145                	addi	sp,sp,48
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	7179                	addi	sp,sp,-48
 2ec:	f406                	sd	ra,40(sp)
 2ee:	f022                	sd	s0,32(sp)
 2f0:	1800                	addi	s0,sp,48
 2f2:	fca43c23          	sd	a0,-40(s0)
 2f6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fa:	4581                	li	a1,0
 2fc:	fd843503          	ld	a0,-40(s0)
 300:	2d2000ef          	jal	5d2 <open>
 304:	87aa                	mv	a5,a0
 306:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 30a:	fec42783          	lw	a5,-20(s0)
 30e:	2781                	sext.w	a5,a5
 310:	0007d463          	bgez	a5,318 <stat+0x2e>
    return -1;
 314:	57fd                	li	a5,-1
 316:	a015                	j	33a <stat+0x50>
  r = fstat(fd, st);
 318:	fec42783          	lw	a5,-20(s0)
 31c:	fd043583          	ld	a1,-48(s0)
 320:	853e                	mv	a0,a5
 322:	2c8000ef          	jal	5ea <fstat>
 326:	87aa                	mv	a5,a0
 328:	fef42423          	sw	a5,-24(s0)
  close(fd);
 32c:	fec42783          	lw	a5,-20(s0)
 330:	853e                	mv	a0,a5
 332:	288000ef          	jal	5ba <close>
  return r;
 336:	fe842783          	lw	a5,-24(s0)
}
 33a:	853e                	mv	a0,a5
 33c:	70a2                	ld	ra,40(sp)
 33e:	7402                	ld	s0,32(sp)
 340:	6145                	addi	sp,sp,48
 342:	8082                	ret

0000000000000344 <atoi>:

int
atoi(const char *s)
{
 344:	7179                	addi	sp,sp,-48
 346:	f406                	sd	ra,40(sp)
 348:	f022                	sd	s0,32(sp)
 34a:	1800                	addi	s0,sp,48
 34c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 350:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 354:	a81d                	j	38a <atoi+0x46>
    n = n*10 + *s++ - '0';
 356:	fec42783          	lw	a5,-20(s0)
 35a:	873e                	mv	a4,a5
 35c:	87ba                	mv	a5,a4
 35e:	0027979b          	slliw	a5,a5,0x2
 362:	9fb9                	addw	a5,a5,a4
 364:	0017979b          	slliw	a5,a5,0x1
 368:	0007871b          	sext.w	a4,a5
 36c:	fd843783          	ld	a5,-40(s0)
 370:	00178693          	addi	a3,a5,1
 374:	fcd43c23          	sd	a3,-40(s0)
 378:	0007c783          	lbu	a5,0(a5)
 37c:	2781                	sext.w	a5,a5
 37e:	9fb9                	addw	a5,a5,a4
 380:	2781                	sext.w	a5,a5
 382:	fd07879b          	addiw	a5,a5,-48
 386:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 38a:	fd843783          	ld	a5,-40(s0)
 38e:	0007c783          	lbu	a5,0(a5)
 392:	873e                	mv	a4,a5
 394:	02f00793          	li	a5,47
 398:	00e7fb63          	bgeu	a5,a4,3ae <atoi+0x6a>
 39c:	fd843783          	ld	a5,-40(s0)
 3a0:	0007c783          	lbu	a5,0(a5)
 3a4:	873e                	mv	a4,a5
 3a6:	03900793          	li	a5,57
 3aa:	fae7f6e3          	bgeu	a5,a4,356 <atoi+0x12>
  return n;
 3ae:	fec42783          	lw	a5,-20(s0)
}
 3b2:	853e                	mv	a0,a5
 3b4:	70a2                	ld	ra,40(sp)
 3b6:	7402                	ld	s0,32(sp)
 3b8:	6145                	addi	sp,sp,48
 3ba:	8082                	ret

00000000000003bc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3bc:	7139                	addi	sp,sp,-64
 3be:	fc06                	sd	ra,56(sp)
 3c0:	f822                	sd	s0,48(sp)
 3c2:	0080                	addi	s0,sp,64
 3c4:	fca43c23          	sd	a0,-40(s0)
 3c8:	fcb43823          	sd	a1,-48(s0)
 3cc:	87b2                	mv	a5,a2
 3ce:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3d2:	fd843783          	ld	a5,-40(s0)
 3d6:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3da:	fd043783          	ld	a5,-48(s0)
 3de:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3e2:	fe043703          	ld	a4,-32(s0)
 3e6:	fe843783          	ld	a5,-24(s0)
 3ea:	02e7fc63          	bgeu	a5,a4,422 <memmove+0x66>
    while(n-- > 0)
 3ee:	a00d                	j	410 <memmove+0x54>
      *dst++ = *src++;
 3f0:	fe043703          	ld	a4,-32(s0)
 3f4:	00170793          	addi	a5,a4,1
 3f8:	fef43023          	sd	a5,-32(s0)
 3fc:	fe843783          	ld	a5,-24(s0)
 400:	00178693          	addi	a3,a5,1
 404:	fed43423          	sd	a3,-24(s0)
 408:	00074703          	lbu	a4,0(a4)
 40c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 410:	fcc42783          	lw	a5,-52(s0)
 414:	fff7871b          	addiw	a4,a5,-1
 418:	fce42623          	sw	a4,-52(s0)
 41c:	fcf04ae3          	bgtz	a5,3f0 <memmove+0x34>
 420:	a891                	j	474 <memmove+0xb8>
  } else {
    dst += n;
 422:	fcc42783          	lw	a5,-52(s0)
 426:	fe843703          	ld	a4,-24(s0)
 42a:	97ba                	add	a5,a5,a4
 42c:	fef43423          	sd	a5,-24(s0)
    src += n;
 430:	fcc42783          	lw	a5,-52(s0)
 434:	fe043703          	ld	a4,-32(s0)
 438:	97ba                	add	a5,a5,a4
 43a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 43e:	a01d                	j	464 <memmove+0xa8>
      *--dst = *--src;
 440:	fe043783          	ld	a5,-32(s0)
 444:	17fd                	addi	a5,a5,-1
 446:	fef43023          	sd	a5,-32(s0)
 44a:	fe843783          	ld	a5,-24(s0)
 44e:	17fd                	addi	a5,a5,-1
 450:	fef43423          	sd	a5,-24(s0)
 454:	fe043783          	ld	a5,-32(s0)
 458:	0007c703          	lbu	a4,0(a5)
 45c:	fe843783          	ld	a5,-24(s0)
 460:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 464:	fcc42783          	lw	a5,-52(s0)
 468:	fff7871b          	addiw	a4,a5,-1
 46c:	fce42623          	sw	a4,-52(s0)
 470:	fcf048e3          	bgtz	a5,440 <memmove+0x84>
  }
  return vdst;
 474:	fd843783          	ld	a5,-40(s0)
}
 478:	853e                	mv	a0,a5
 47a:	70e2                	ld	ra,56(sp)
 47c:	7442                	ld	s0,48(sp)
 47e:	6121                	addi	sp,sp,64
 480:	8082                	ret

0000000000000482 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 482:	7139                	addi	sp,sp,-64
 484:	fc06                	sd	ra,56(sp)
 486:	f822                	sd	s0,48(sp)
 488:	0080                	addi	s0,sp,64
 48a:	fca43c23          	sd	a0,-40(s0)
 48e:	fcb43823          	sd	a1,-48(s0)
 492:	87b2                	mv	a5,a2
 494:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 498:	fd843783          	ld	a5,-40(s0)
 49c:	fef43423          	sd	a5,-24(s0)
 4a0:	fd043783          	ld	a5,-48(s0)
 4a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4a8:	a0a1                	j	4f0 <memcmp+0x6e>
    if (*p1 != *p2) {
 4aa:	fe843783          	ld	a5,-24(s0)
 4ae:	0007c703          	lbu	a4,0(a5)
 4b2:	fe043783          	ld	a5,-32(s0)
 4b6:	0007c783          	lbu	a5,0(a5)
 4ba:	02f70163          	beq	a4,a5,4dc <memcmp+0x5a>
      return *p1 - *p2;
 4be:	fe843783          	ld	a5,-24(s0)
 4c2:	0007c783          	lbu	a5,0(a5)
 4c6:	0007871b          	sext.w	a4,a5
 4ca:	fe043783          	ld	a5,-32(s0)
 4ce:	0007c783          	lbu	a5,0(a5)
 4d2:	2781                	sext.w	a5,a5
 4d4:	40f707bb          	subw	a5,a4,a5
 4d8:	2781                	sext.w	a5,a5
 4da:	a01d                	j	500 <memcmp+0x7e>
    }
    p1++;
 4dc:	fe843783          	ld	a5,-24(s0)
 4e0:	0785                	addi	a5,a5,1
 4e2:	fef43423          	sd	a5,-24(s0)
    p2++;
 4e6:	fe043783          	ld	a5,-32(s0)
 4ea:	0785                	addi	a5,a5,1
 4ec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4f0:	fcc42783          	lw	a5,-52(s0)
 4f4:	fff7871b          	addiw	a4,a5,-1
 4f8:	fce42623          	sw	a4,-52(s0)
 4fc:	f7dd                	bnez	a5,4aa <memcmp+0x28>
  }
  return 0;
 4fe:	4781                	li	a5,0
}
 500:	853e                	mv	a0,a5
 502:	70e2                	ld	ra,56(sp)
 504:	7442                	ld	s0,48(sp)
 506:	6121                	addi	sp,sp,64
 508:	8082                	ret

000000000000050a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50a:	7179                	addi	sp,sp,-48
 50c:	f406                	sd	ra,40(sp)
 50e:	f022                	sd	s0,32(sp)
 510:	1800                	addi	s0,sp,48
 512:	fea43423          	sd	a0,-24(s0)
 516:	feb43023          	sd	a1,-32(s0)
 51a:	87b2                	mv	a5,a2
 51c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 520:	fdc42783          	lw	a5,-36(s0)
 524:	863e                	mv	a2,a5
 526:	fe043583          	ld	a1,-32(s0)
 52a:	fe843503          	ld	a0,-24(s0)
 52e:	e8fff0ef          	jal	3bc <memmove>
 532:	87aa                	mv	a5,a0
}
 534:	853e                	mv	a0,a5
 536:	70a2                	ld	ra,40(sp)
 538:	7402                	ld	s0,32(sp)
 53a:	6145                	addi	sp,sp,48
 53c:	8082                	ret

000000000000053e <sbrk>:

char *
sbrk(int n) {
 53e:	1101                	addi	sp,sp,-32
 540:	ec06                	sd	ra,24(sp)
 542:	e822                	sd	s0,16(sp)
 544:	1000                	addi	s0,sp,32
 546:	87aa                	mv	a5,a0
 548:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 54c:	fec42783          	lw	a5,-20(s0)
 550:	4585                	li	a1,1
 552:	853e                	mv	a0,a5
 554:	0c6000ef          	jal	61a <sys_sbrk>
 558:	87aa                	mv	a5,a0
}
 55a:	853e                	mv	a0,a5
 55c:	60e2                	ld	ra,24(sp)
 55e:	6442                	ld	s0,16(sp)
 560:	6105                	addi	sp,sp,32
 562:	8082                	ret

0000000000000564 <sbrklazy>:

char *
sbrklazy(int n) {
 564:	1101                	addi	sp,sp,-32
 566:	ec06                	sd	ra,24(sp)
 568:	e822                	sd	s0,16(sp)
 56a:	1000                	addi	s0,sp,32
 56c:	87aa                	mv	a5,a0
 56e:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 572:	fec42783          	lw	a5,-20(s0)
 576:	4589                	li	a1,2
 578:	853e                	mv	a0,a5
 57a:	0a0000ef          	jal	61a <sys_sbrk>
 57e:	87aa                	mv	a5,a0
}
 580:	853e                	mv	a0,a5
 582:	60e2                	ld	ra,24(sp)
 584:	6442                	ld	s0,16(sp)
 586:	6105                	addi	sp,sp,32
 588:	8082                	ret

000000000000058a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 58a:	4885                	li	a7,1
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <exit>:
.global exit
exit:
 li a7, SYS_exit
 592:	4889                	li	a7,2
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <wait>:
.global wait
wait:
 li a7, SYS_wait
 59a:	488d                	li	a7,3
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a2:	4891                	li	a7,4
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <read>:
.global read
read:
 li a7, SYS_read
 5aa:	4895                	li	a7,5
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <write>:
.global write
write:
 li a7, SYS_write
 5b2:	48c1                	li	a7,16
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <close>:
.global close
close:
 li a7, SYS_close
 5ba:	48d5                	li	a7,21
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c2:	4899                	li	a7,6
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ca:	489d                	li	a7,7
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <open>:
.global open
open:
 li a7, SYS_open
 5d2:	48bd                	li	a7,15
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5da:	48c5                	li	a7,17
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e2:	48c9                	li	a7,18
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ea:	48a1                	li	a7,8
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <link>:
.global link
link:
 li a7, SYS_link
 5f2:	48cd                	li	a7,19
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5fa:	48d1                	li	a7,20
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 602:	48a5                	li	a7,9
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <dup>:
.global dup
dup:
 li a7, SYS_dup
 60a:	48a9                	li	a7,10
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 612:	48ad                	li	a7,11
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 61a:	48b1                	li	a7,12
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <pause>:
.global pause
pause:
 li a7, SYS_pause
 622:	48b5                	li	a7,13
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 62a:	48b9                	li	a7,14
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <top>:
.global top
top:
 li a7, SYS_top
 632:	48d9                	li	a7,22
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
 63a:	48dd                	li	a7,23
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 642:	1101                	addi	sp,sp,-32
 644:	ec06                	sd	ra,24(sp)
 646:	e822                	sd	s0,16(sp)
 648:	1000                	addi	s0,sp,32
 64a:	87aa                	mv	a5,a0
 64c:	872e                	mv	a4,a1
 64e:	fef42623          	sw	a5,-20(s0)
 652:	87ba                	mv	a5,a4
 654:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 658:	feb40713          	addi	a4,s0,-21
 65c:	fec42783          	lw	a5,-20(s0)
 660:	4605                	li	a2,1
 662:	85ba                	mv	a1,a4
 664:	853e                	mv	a0,a5
 666:	f4dff0ef          	jal	5b2 <write>
}
 66a:	0001                	nop
 66c:	60e2                	ld	ra,24(sp)
 66e:	6442                	ld	s0,16(sp)
 670:	6105                	addi	sp,sp,32
 672:	8082                	ret

0000000000000674 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 674:	711d                	addi	sp,sp,-96
 676:	ec86                	sd	ra,88(sp)
 678:	e8a2                	sd	s0,80(sp)
 67a:	1080                	addi	s0,sp,96
 67c:	87aa                	mv	a5,a0
 67e:	fab43823          	sd	a1,-80(s0)
 682:	8736                	mv	a4,a3
 684:	faf42e23          	sw	a5,-68(s0)
 688:	87b2                	mv	a5,a2
 68a:	faf42c23          	sw	a5,-72(s0)
 68e:	87ba                	mv	a5,a4
 690:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 694:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 698:	fac42783          	lw	a5,-84(s0)
 69c:	2781                	sext.w	a5,a5
 69e:	cf99                	beqz	a5,6bc <printint+0x48>
 6a0:	fb043783          	ld	a5,-80(s0)
 6a4:	0007dc63          	bgez	a5,6bc <printint+0x48>
    neg = 1;
 6a8:	4785                	li	a5,1
 6aa:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6ae:	fb043783          	ld	a5,-80(s0)
 6b2:	40f007b3          	neg	a5,a5
 6b6:	fef43023          	sd	a5,-32(s0)
 6ba:	a029                	j	6c4 <printint+0x50>
  } else {
    x = xx;
 6bc:	fb043783          	ld	a5,-80(s0)
 6c0:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6c4:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6c8:	fb842783          	lw	a5,-72(s0)
 6cc:	fe043703          	ld	a4,-32(s0)
 6d0:	02f77733          	remu	a4,a4,a5
 6d4:	fec42783          	lw	a5,-20(s0)
 6d8:	0017869b          	addiw	a3,a5,1
 6dc:	fed42623          	sw	a3,-20(s0)
 6e0:	00002697          	auipc	a3,0x2
 6e4:	92068693          	addi	a3,a3,-1760 # 2000 <digits>
 6e8:	9736                	add	a4,a4,a3
 6ea:	00074703          	lbu	a4,0(a4)
 6ee:	17c1                	addi	a5,a5,-16
 6f0:	97a2                	add	a5,a5,s0
 6f2:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 6f6:	fb842783          	lw	a5,-72(s0)
 6fa:	fe043703          	ld	a4,-32(s0)
 6fe:	02f757b3          	divu	a5,a4,a5
 702:	fef43023          	sd	a5,-32(s0)
 706:	fe043783          	ld	a5,-32(s0)
 70a:	ffdd                	bnez	a5,6c8 <printint+0x54>
  if(neg)
 70c:	fe842783          	lw	a5,-24(s0)
 710:	2781                	sext.w	a5,a5
 712:	cb95                	beqz	a5,746 <printint+0xd2>
    buf[i++] = '-';
 714:	fec42783          	lw	a5,-20(s0)
 718:	0017871b          	addiw	a4,a5,1
 71c:	fee42623          	sw	a4,-20(s0)
 720:	17c1                	addi	a5,a5,-16
 722:	97a2                	add	a5,a5,s0
 724:	02d00713          	li	a4,45
 728:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 72c:	a829                	j	746 <printint+0xd2>
    putc(fd, buf[i]);
 72e:	fec42783          	lw	a5,-20(s0)
 732:	17c1                	addi	a5,a5,-16
 734:	97a2                	add	a5,a5,s0
 736:	fd87c703          	lbu	a4,-40(a5)
 73a:	fbc42783          	lw	a5,-68(s0)
 73e:	85ba                	mv	a1,a4
 740:	853e                	mv	a0,a5
 742:	f01ff0ef          	jal	642 <putc>
  while(--i >= 0)
 746:	fec42783          	lw	a5,-20(s0)
 74a:	37fd                	addiw	a5,a5,-1
 74c:	fef42623          	sw	a5,-20(s0)
 750:	fec42783          	lw	a5,-20(s0)
 754:	2781                	sext.w	a5,a5
 756:	fc07dce3          	bgez	a5,72e <printint+0xba>
}
 75a:	0001                	nop
 75c:	0001                	nop
 75e:	60e6                	ld	ra,88(sp)
 760:	6446                	ld	s0,80(sp)
 762:	6125                	addi	sp,sp,96
 764:	8082                	ret

0000000000000766 <printptr>:

static void
printptr(int fd, uint64 x) {
 766:	7179                	addi	sp,sp,-48
 768:	f406                	sd	ra,40(sp)
 76a:	f022                	sd	s0,32(sp)
 76c:	1800                	addi	s0,sp,48
 76e:	87aa                	mv	a5,a0
 770:	fcb43823          	sd	a1,-48(s0)
 774:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 778:	fdc42783          	lw	a5,-36(s0)
 77c:	03000593          	li	a1,48
 780:	853e                	mv	a0,a5
 782:	ec1ff0ef          	jal	642 <putc>
  putc(fd, 'x');
 786:	fdc42783          	lw	a5,-36(s0)
 78a:	07800593          	li	a1,120
 78e:	853e                	mv	a0,a5
 790:	eb3ff0ef          	jal	642 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 794:	fe042623          	sw	zero,-20(s0)
 798:	a81d                	j	7ce <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79a:	fd043783          	ld	a5,-48(s0)
 79e:	93f1                	srli	a5,a5,0x3c
 7a0:	00002717          	auipc	a4,0x2
 7a4:	86070713          	addi	a4,a4,-1952 # 2000 <digits>
 7a8:	97ba                	add	a5,a5,a4
 7aa:	0007c703          	lbu	a4,0(a5)
 7ae:	fdc42783          	lw	a5,-36(s0)
 7b2:	85ba                	mv	a1,a4
 7b4:	853e                	mv	a0,a5
 7b6:	e8dff0ef          	jal	642 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	fec42783          	lw	a5,-20(s0)
 7be:	2785                	addiw	a5,a5,1
 7c0:	fef42623          	sw	a5,-20(s0)
 7c4:	fd043783          	ld	a5,-48(s0)
 7c8:	0792                	slli	a5,a5,0x4
 7ca:	fcf43823          	sd	a5,-48(s0)
 7ce:	fec42703          	lw	a4,-20(s0)
 7d2:	47bd                	li	a5,15
 7d4:	fce7f3e3          	bgeu	a5,a4,79a <printptr+0x34>
}
 7d8:	0001                	nop
 7da:	0001                	nop
 7dc:	70a2                	ld	ra,40(sp)
 7de:	7402                	ld	s0,32(sp)
 7e0:	6145                	addi	sp,sp,48
 7e2:	8082                	ret

00000000000007e4 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7e4:	715d                	addi	sp,sp,-80
 7e6:	e486                	sd	ra,72(sp)
 7e8:	e0a2                	sd	s0,64(sp)
 7ea:	0880                	addi	s0,sp,80
 7ec:	87aa                	mv	a5,a0
 7ee:	fcb43023          	sd	a1,-64(s0)
 7f2:	fac43c23          	sd	a2,-72(s0)
 7f6:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 7fa:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 7fe:	fc042e23          	sw	zero,-36(s0)
 802:	a189                	j	c44 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 804:	fdc42783          	lw	a5,-36(s0)
 808:	fc043703          	ld	a4,-64(s0)
 80c:	97ba                	add	a5,a5,a4
 80e:	0007c783          	lbu	a5,0(a5)
 812:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 816:	fd842783          	lw	a5,-40(s0)
 81a:	2781                	sext.w	a5,a5
 81c:	eb8d                	bnez	a5,84e <vprintf+0x6a>
      if(c0 == '%'){
 81e:	fd442783          	lw	a5,-44(s0)
 822:	0007871b          	sext.w	a4,a5
 826:	02500793          	li	a5,37
 82a:	00f71763          	bne	a4,a5,838 <vprintf+0x54>
        state = '%';
 82e:	02500793          	li	a5,37
 832:	fcf42c23          	sw	a5,-40(s0)
 836:	a111                	j	c3a <vprintf+0x456>
      } else {
        putc(fd, c0);
 838:	fd442783          	lw	a5,-44(s0)
 83c:	0ff7f713          	zext.b	a4,a5
 840:	fcc42783          	lw	a5,-52(s0)
 844:	85ba                	mv	a1,a4
 846:	853e                	mv	a0,a5
 848:	dfbff0ef          	jal	642 <putc>
 84c:	a6fd                	j	c3a <vprintf+0x456>
      }
    } else if(state == '%'){
 84e:	fd842783          	lw	a5,-40(s0)
 852:	0007871b          	sext.w	a4,a5
 856:	02500793          	li	a5,37
 85a:	3ef71063          	bne	a4,a5,c3a <vprintf+0x456>
      c1 = c2 = 0;
 85e:	fe042023          	sw	zero,-32(s0)
 862:	fe042783          	lw	a5,-32(s0)
 866:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 86a:	fd442783          	lw	a5,-44(s0)
 86e:	2781                	sext.w	a5,a5
 870:	cb99                	beqz	a5,886 <vprintf+0xa2>
 872:	fdc42783          	lw	a5,-36(s0)
 876:	0785                	addi	a5,a5,1
 878:	fc043703          	ld	a4,-64(s0)
 87c:	97ba                	add	a5,a5,a4
 87e:	0007c783          	lbu	a5,0(a5)
 882:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 886:	fe442783          	lw	a5,-28(s0)
 88a:	2781                	sext.w	a5,a5
 88c:	cb99                	beqz	a5,8a2 <vprintf+0xbe>
 88e:	fdc42783          	lw	a5,-36(s0)
 892:	0789                	addi	a5,a5,2
 894:	fc043703          	ld	a4,-64(s0)
 898:	97ba                	add	a5,a5,a4
 89a:	0007c783          	lbu	a5,0(a5)
 89e:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 8a2:	fd442783          	lw	a5,-44(s0)
 8a6:	0007871b          	sext.w	a4,a5
 8aa:	06400793          	li	a5,100
 8ae:	02f71363          	bne	a4,a5,8d4 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8b2:	fb843783          	ld	a5,-72(s0)
 8b6:	00878713          	addi	a4,a5,8
 8ba:	fae43c23          	sd	a4,-72(s0)
 8be:	439c                	lw	a5,0(a5)
 8c0:	873e                	mv	a4,a5
 8c2:	fcc42783          	lw	a5,-52(s0)
 8c6:	4685                	li	a3,1
 8c8:	4629                	li	a2,10
 8ca:	85ba                	mv	a1,a4
 8cc:	853e                	mv	a0,a5
 8ce:	da7ff0ef          	jal	674 <printint>
 8d2:	a695                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8d4:	fd442783          	lw	a5,-44(s0)
 8d8:	0007871b          	sext.w	a4,a5
 8dc:	06c00793          	li	a5,108
 8e0:	04f71063          	bne	a4,a5,920 <vprintf+0x13c>
 8e4:	fe442783          	lw	a5,-28(s0)
 8e8:	0007871b          	sext.w	a4,a5
 8ec:	06400793          	li	a5,100
 8f0:	02f71863          	bne	a4,a5,920 <vprintf+0x13c>
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
 910:	d65ff0ef          	jal	674 <printint>
        i += 1;
 914:	fdc42783          	lw	a5,-36(s0)
 918:	2785                	addiw	a5,a5,1
 91a:	fcf42e23          	sw	a5,-36(s0)
 91e:	ae21                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 920:	fd442783          	lw	a5,-44(s0)
 924:	0007871b          	sext.w	a4,a5
 928:	06c00793          	li	a5,108
 92c:	04f71863          	bne	a4,a5,97c <vprintf+0x198>
 930:	fe442783          	lw	a5,-28(s0)
 934:	0007871b          	sext.w	a4,a5
 938:	06c00793          	li	a5,108
 93c:	04f71063          	bne	a4,a5,97c <vprintf+0x198>
 940:	fe042783          	lw	a5,-32(s0)
 944:	0007871b          	sext.w	a4,a5
 948:	06400793          	li	a5,100
 94c:	02f71863          	bne	a4,a5,97c <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 950:	fb843783          	ld	a5,-72(s0)
 954:	00878713          	addi	a4,a5,8
 958:	fae43c23          	sd	a4,-72(s0)
 95c:	639c                	ld	a5,0(a5)
 95e:	873e                	mv	a4,a5
 960:	fcc42783          	lw	a5,-52(s0)
 964:	4685                	li	a3,1
 966:	4629                	li	a2,10
 968:	85ba                	mv	a1,a4
 96a:	853e                	mv	a0,a5
 96c:	d09ff0ef          	jal	674 <printint>
        i += 2;
 970:	fdc42783          	lw	a5,-36(s0)
 974:	2789                	addiw	a5,a5,2
 976:	fcf42e23          	sw	a5,-36(s0)
 97a:	ac75                	j	c36 <vprintf+0x452>
      } else if(c0 == 'u'){
 97c:	fd442783          	lw	a5,-44(s0)
 980:	0007871b          	sext.w	a4,a5
 984:	07500793          	li	a5,117
 988:	02f71563          	bne	a4,a5,9b2 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 98c:	fb843783          	ld	a5,-72(s0)
 990:	00878713          	addi	a4,a5,8
 994:	fae43c23          	sd	a4,-72(s0)
 998:	439c                	lw	a5,0(a5)
 99a:	02079713          	slli	a4,a5,0x20
 99e:	9301                	srli	a4,a4,0x20
 9a0:	fcc42783          	lw	a5,-52(s0)
 9a4:	4681                	li	a3,0
 9a6:	4629                	li	a2,10
 9a8:	85ba                	mv	a1,a4
 9aa:	853e                	mv	a0,a5
 9ac:	cc9ff0ef          	jal	674 <printint>
 9b0:	a459                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9b2:	fd442783          	lw	a5,-44(s0)
 9b6:	0007871b          	sext.w	a4,a5
 9ba:	06c00793          	li	a5,108
 9be:	04f71063          	bne	a4,a5,9fe <vprintf+0x21a>
 9c2:	fe442783          	lw	a5,-28(s0)
 9c6:	0007871b          	sext.w	a4,a5
 9ca:	07500793          	li	a5,117
 9ce:	02f71863          	bne	a4,a5,9fe <vprintf+0x21a>
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
 9ee:	c87ff0ef          	jal	674 <printint>
        i += 1;
 9f2:	fdc42783          	lw	a5,-36(s0)
 9f6:	2785                	addiw	a5,a5,1
 9f8:	fcf42e23          	sw	a5,-36(s0)
 9fc:	ac2d                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9fe:	fd442783          	lw	a5,-44(s0)
 a02:	0007871b          	sext.w	a4,a5
 a06:	06c00793          	li	a5,108
 a0a:	04f71863          	bne	a4,a5,a5a <vprintf+0x276>
 a0e:	fe442783          	lw	a5,-28(s0)
 a12:	0007871b          	sext.w	a4,a5
 a16:	06c00793          	li	a5,108
 a1a:	04f71063          	bne	a4,a5,a5a <vprintf+0x276>
 a1e:	fe042783          	lw	a5,-32(s0)
 a22:	0007871b          	sext.w	a4,a5
 a26:	07500793          	li	a5,117
 a2a:	02f71863          	bne	a4,a5,a5a <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a2e:	fb843783          	ld	a5,-72(s0)
 a32:	00878713          	addi	a4,a5,8
 a36:	fae43c23          	sd	a4,-72(s0)
 a3a:	639c                	ld	a5,0(a5)
 a3c:	873e                	mv	a4,a5
 a3e:	fcc42783          	lw	a5,-52(s0)
 a42:	4681                	li	a3,0
 a44:	4629                	li	a2,10
 a46:	85ba                	mv	a1,a4
 a48:	853e                	mv	a0,a5
 a4a:	c2bff0ef          	jal	674 <printint>
        i += 2;
 a4e:	fdc42783          	lw	a5,-36(s0)
 a52:	2789                	addiw	a5,a5,2
 a54:	fcf42e23          	sw	a5,-36(s0)
 a58:	aaf9                	j	c36 <vprintf+0x452>
      } else if(c0 == 'x'){
 a5a:	fd442783          	lw	a5,-44(s0)
 a5e:	0007871b          	sext.w	a4,a5
 a62:	07800793          	li	a5,120
 a66:	02f71563          	bne	a4,a5,a90 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a6a:	fb843783          	ld	a5,-72(s0)
 a6e:	00878713          	addi	a4,a5,8
 a72:	fae43c23          	sd	a4,-72(s0)
 a76:	439c                	lw	a5,0(a5)
 a78:	02079713          	slli	a4,a5,0x20
 a7c:	9301                	srli	a4,a4,0x20
 a7e:	fcc42783          	lw	a5,-52(s0)
 a82:	4681                	li	a3,0
 a84:	4641                	li	a2,16
 a86:	85ba                	mv	a1,a4
 a88:	853e                	mv	a0,a5
 a8a:	bebff0ef          	jal	674 <printint>
 a8e:	a265                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a90:	fd442783          	lw	a5,-44(s0)
 a94:	0007871b          	sext.w	a4,a5
 a98:	06c00793          	li	a5,108
 a9c:	04f71063          	bne	a4,a5,adc <vprintf+0x2f8>
 aa0:	fe442783          	lw	a5,-28(s0)
 aa4:	0007871b          	sext.w	a4,a5
 aa8:	07800793          	li	a5,120
 aac:	02f71863          	bne	a4,a5,adc <vprintf+0x2f8>
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
 acc:	ba9ff0ef          	jal	674 <printint>
        i += 1;
 ad0:	fdc42783          	lw	a5,-36(s0)
 ad4:	2785                	addiw	a5,a5,1
 ad6:	fcf42e23          	sw	a5,-36(s0)
 ada:	aab1                	j	c36 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 adc:	fd442783          	lw	a5,-44(s0)
 ae0:	0007871b          	sext.w	a4,a5
 ae4:	06c00793          	li	a5,108
 ae8:	04f71863          	bne	a4,a5,b38 <vprintf+0x354>
 aec:	fe442783          	lw	a5,-28(s0)
 af0:	0007871b          	sext.w	a4,a5
 af4:	06c00793          	li	a5,108
 af8:	04f71063          	bne	a4,a5,b38 <vprintf+0x354>
 afc:	fe042783          	lw	a5,-32(s0)
 b00:	0007871b          	sext.w	a4,a5
 b04:	07800793          	li	a5,120
 b08:	02f71863          	bne	a4,a5,b38 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b0c:	fb843783          	ld	a5,-72(s0)
 b10:	00878713          	addi	a4,a5,8
 b14:	fae43c23          	sd	a4,-72(s0)
 b18:	639c                	ld	a5,0(a5)
 b1a:	873e                	mv	a4,a5
 b1c:	fcc42783          	lw	a5,-52(s0)
 b20:	4681                	li	a3,0
 b22:	4641                	li	a2,16
 b24:	85ba                	mv	a1,a4
 b26:	853e                	mv	a0,a5
 b28:	b4dff0ef          	jal	674 <printint>
        i += 2;
 b2c:	fdc42783          	lw	a5,-36(s0)
 b30:	2789                	addiw	a5,a5,2
 b32:	fcf42e23          	sw	a5,-36(s0)
 b36:	a201                	j	c36 <vprintf+0x452>
      } else if(c0 == 'p'){
 b38:	fd442783          	lw	a5,-44(s0)
 b3c:	0007871b          	sext.w	a4,a5
 b40:	07000793          	li	a5,112
 b44:	02f71063          	bne	a4,a5,b64 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b48:	fb843783          	ld	a5,-72(s0)
 b4c:	00878713          	addi	a4,a5,8
 b50:	fae43c23          	sd	a4,-72(s0)
 b54:	6398                	ld	a4,0(a5)
 b56:	fcc42783          	lw	a5,-52(s0)
 b5a:	85ba                	mv	a1,a4
 b5c:	853e                	mv	a0,a5
 b5e:	c09ff0ef          	jal	766 <printptr>
 b62:	a8d1                	j	c36 <vprintf+0x452>
      } else if(c0 == 'c'){
 b64:	fd442783          	lw	a5,-44(s0)
 b68:	0007871b          	sext.w	a4,a5
 b6c:	06300793          	li	a5,99
 b70:	02f71263          	bne	a4,a5,b94 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b74:	fb843783          	ld	a5,-72(s0)
 b78:	00878713          	addi	a4,a5,8
 b7c:	fae43c23          	sd	a4,-72(s0)
 b80:	439c                	lw	a5,0(a5)
 b82:	0ff7f713          	zext.b	a4,a5
 b86:	fcc42783          	lw	a5,-52(s0)
 b8a:	85ba                	mv	a1,a4
 b8c:	853e                	mv	a0,a5
 b8e:	ab5ff0ef          	jal	642 <putc>
 b92:	a055                	j	c36 <vprintf+0x452>
      } else if(c0 == 's'){
 b94:	fd442783          	lw	a5,-44(s0)
 b98:	0007871b          	sext.w	a4,a5
 b9c:	07300793          	li	a5,115
 ba0:	04f71a63          	bne	a4,a5,bf4 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 ba4:	fb843783          	ld	a5,-72(s0)
 ba8:	00878713          	addi	a4,a5,8
 bac:	fae43c23          	sd	a4,-72(s0)
 bb0:	639c                	ld	a5,0(a5)
 bb2:	fef43423          	sd	a5,-24(s0)
 bb6:	fe843783          	ld	a5,-24(s0)
 bba:	e79d                	bnez	a5,be8 <vprintf+0x404>
          s = "(null)";
 bbc:	00000797          	auipc	a5,0x0
 bc0:	45478793          	addi	a5,a5,1108 # 1010 <malloc+0x172>
 bc4:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 bc8:	a005                	j	be8 <vprintf+0x404>
          putc(fd, *s);
 bca:	fe843783          	ld	a5,-24(s0)
 bce:	0007c703          	lbu	a4,0(a5)
 bd2:	fcc42783          	lw	a5,-52(s0)
 bd6:	85ba                	mv	a1,a4
 bd8:	853e                	mv	a0,a5
 bda:	a69ff0ef          	jal	642 <putc>
        for(; *s; s++)
 bde:	fe843783          	ld	a5,-24(s0)
 be2:	0785                	addi	a5,a5,1
 be4:	fef43423          	sd	a5,-24(s0)
 be8:	fe843783          	ld	a5,-24(s0)
 bec:	0007c783          	lbu	a5,0(a5)
 bf0:	ffe9                	bnez	a5,bca <vprintf+0x3e6>
 bf2:	a091                	j	c36 <vprintf+0x452>
      } else if(c0 == '%'){
 bf4:	fd442783          	lw	a5,-44(s0)
 bf8:	0007871b          	sext.w	a4,a5
 bfc:	02500793          	li	a5,37
 c00:	00f71a63          	bne	a4,a5,c14 <vprintf+0x430>
        putc(fd, '%');
 c04:	fcc42783          	lw	a5,-52(s0)
 c08:	02500593          	li	a1,37
 c0c:	853e                	mv	a0,a5
 c0e:	a35ff0ef          	jal	642 <putc>
 c12:	a015                	j	c36 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c14:	fcc42783          	lw	a5,-52(s0)
 c18:	02500593          	li	a1,37
 c1c:	853e                	mv	a0,a5
 c1e:	a25ff0ef          	jal	642 <putc>
        putc(fd, c0);
 c22:	fd442783          	lw	a5,-44(s0)
 c26:	0ff7f713          	zext.b	a4,a5
 c2a:	fcc42783          	lw	a5,-52(s0)
 c2e:	85ba                	mv	a1,a4
 c30:	853e                	mv	a0,a5
 c32:	a11ff0ef          	jal	642 <putc>
      }

      state = 0;
 c36:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c3a:	fdc42783          	lw	a5,-36(s0)
 c3e:	2785                	addiw	a5,a5,1
 c40:	fcf42e23          	sw	a5,-36(s0)
 c44:	fdc42783          	lw	a5,-36(s0)
 c48:	fc043703          	ld	a4,-64(s0)
 c4c:	97ba                	add	a5,a5,a4
 c4e:	0007c783          	lbu	a5,0(a5)
 c52:	ba0799e3          	bnez	a5,804 <vprintf+0x20>
    }
  }
}
 c56:	0001                	nop
 c58:	0001                	nop
 c5a:	60a6                	ld	ra,72(sp)
 c5c:	6406                	ld	s0,64(sp)
 c5e:	6161                	addi	sp,sp,80
 c60:	8082                	ret

0000000000000c62 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c62:	7159                	addi	sp,sp,-112
 c64:	fc06                	sd	ra,56(sp)
 c66:	f822                	sd	s0,48(sp)
 c68:	0080                	addi	s0,sp,64
 c6a:	fcb43823          	sd	a1,-48(s0)
 c6e:	e010                	sd	a2,0(s0)
 c70:	e414                	sd	a3,8(s0)
 c72:	e818                	sd	a4,16(s0)
 c74:	ec1c                	sd	a5,24(s0)
 c76:	03043023          	sd	a6,32(s0)
 c7a:	03143423          	sd	a7,40(s0)
 c7e:	87aa                	mv	a5,a0
 c80:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c84:	03040793          	addi	a5,s0,48
 c88:	fcf43423          	sd	a5,-56(s0)
 c8c:	fc843783          	ld	a5,-56(s0)
 c90:	fd078793          	addi	a5,a5,-48
 c94:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c98:	fe843703          	ld	a4,-24(s0)
 c9c:	fdc42783          	lw	a5,-36(s0)
 ca0:	863a                	mv	a2,a4
 ca2:	fd043583          	ld	a1,-48(s0)
 ca6:	853e                	mv	a0,a5
 ca8:	b3dff0ef          	jal	7e4 <vprintf>
}
 cac:	0001                	nop
 cae:	70e2                	ld	ra,56(sp)
 cb0:	7442                	ld	s0,48(sp)
 cb2:	6165                	addi	sp,sp,112
 cb4:	8082                	ret

0000000000000cb6 <printf>:

void
printf(const char *fmt, ...)
{
 cb6:	7159                	addi	sp,sp,-112
 cb8:	f406                	sd	ra,40(sp)
 cba:	f022                	sd	s0,32(sp)
 cbc:	1800                	addi	s0,sp,48
 cbe:	fca43c23          	sd	a0,-40(s0)
 cc2:	e40c                	sd	a1,8(s0)
 cc4:	e810                	sd	a2,16(s0)
 cc6:	ec14                	sd	a3,24(s0)
 cc8:	f018                	sd	a4,32(s0)
 cca:	f41c                	sd	a5,40(s0)
 ccc:	03043823          	sd	a6,48(s0)
 cd0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cd4:	04040793          	addi	a5,s0,64
 cd8:	fcf43823          	sd	a5,-48(s0)
 cdc:	fd043783          	ld	a5,-48(s0)
 ce0:	fc878793          	addi	a5,a5,-56
 ce4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ce8:	fe843783          	ld	a5,-24(s0)
 cec:	863e                	mv	a2,a5
 cee:	fd843583          	ld	a1,-40(s0)
 cf2:	4505                	li	a0,1
 cf4:	af1ff0ef          	jal	7e4 <vprintf>
}
 cf8:	0001                	nop
 cfa:	70a2                	ld	ra,40(sp)
 cfc:	7402                	ld	s0,32(sp)
 cfe:	6165                	addi	sp,sp,112
 d00:	8082                	ret

0000000000000d02 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d02:	7179                	addi	sp,sp,-48
 d04:	f406                	sd	ra,40(sp)
 d06:	f022                	sd	s0,32(sp)
 d08:	1800                	addi	s0,sp,48
 d0a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d0e:	fd843783          	ld	a5,-40(s0)
 d12:	17c1                	addi	a5,a5,-16
 d14:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d18:	00001797          	auipc	a5,0x1
 d1c:	31878793          	addi	a5,a5,792 # 2030 <freep>
 d20:	639c                	ld	a5,0(a5)
 d22:	fef43423          	sd	a5,-24(s0)
 d26:	a815                	j	d5a <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d28:	fe843783          	ld	a5,-24(s0)
 d2c:	639c                	ld	a5,0(a5)
 d2e:	fe843703          	ld	a4,-24(s0)
 d32:	00f76f63          	bltu	a4,a5,d50 <free+0x4e>
 d36:	fe043703          	ld	a4,-32(s0)
 d3a:	fe843783          	ld	a5,-24(s0)
 d3e:	02e7eb63          	bltu	a5,a4,d74 <free+0x72>
 d42:	fe843783          	ld	a5,-24(s0)
 d46:	639c                	ld	a5,0(a5)
 d48:	fe043703          	ld	a4,-32(s0)
 d4c:	02f76463          	bltu	a4,a5,d74 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d50:	fe843783          	ld	a5,-24(s0)
 d54:	639c                	ld	a5,0(a5)
 d56:	fef43423          	sd	a5,-24(s0)
 d5a:	fe043703          	ld	a4,-32(s0)
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	fce7f3e3          	bgeu	a5,a4,d28 <free+0x26>
 d66:	fe843783          	ld	a5,-24(s0)
 d6a:	639c                	ld	a5,0(a5)
 d6c:	fe043703          	ld	a4,-32(s0)
 d70:	faf77ce3          	bgeu	a4,a5,d28 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d74:	fe043783          	ld	a5,-32(s0)
 d78:	479c                	lw	a5,8(a5)
 d7a:	1782                	slli	a5,a5,0x20
 d7c:	9381                	srli	a5,a5,0x20
 d7e:	0792                	slli	a5,a5,0x4
 d80:	fe043703          	ld	a4,-32(s0)
 d84:	973e                	add	a4,a4,a5
 d86:	fe843783          	ld	a5,-24(s0)
 d8a:	639c                	ld	a5,0(a5)
 d8c:	02f71763          	bne	a4,a5,dba <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d90:	fe043783          	ld	a5,-32(s0)
 d94:	4798                	lw	a4,8(a5)
 d96:	fe843783          	ld	a5,-24(s0)
 d9a:	639c                	ld	a5,0(a5)
 d9c:	479c                	lw	a5,8(a5)
 d9e:	9fb9                	addw	a5,a5,a4
 da0:	0007871b          	sext.w	a4,a5
 da4:	fe043783          	ld	a5,-32(s0)
 da8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 daa:	fe843783          	ld	a5,-24(s0)
 dae:	639c                	ld	a5,0(a5)
 db0:	6398                	ld	a4,0(a5)
 db2:	fe043783          	ld	a5,-32(s0)
 db6:	e398                	sd	a4,0(a5)
 db8:	a039                	j	dc6 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 dba:	fe843783          	ld	a5,-24(s0)
 dbe:	6398                	ld	a4,0(a5)
 dc0:	fe043783          	ld	a5,-32(s0)
 dc4:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 dc6:	fe843783          	ld	a5,-24(s0)
 dca:	479c                	lw	a5,8(a5)
 dcc:	1782                	slli	a5,a5,0x20
 dce:	9381                	srli	a5,a5,0x20
 dd0:	0792                	slli	a5,a5,0x4
 dd2:	fe843703          	ld	a4,-24(s0)
 dd6:	97ba                	add	a5,a5,a4
 dd8:	fe043703          	ld	a4,-32(s0)
 ddc:	02f71563          	bne	a4,a5,e06 <free+0x104>
    p->s.size += bp->s.size;
 de0:	fe843783          	ld	a5,-24(s0)
 de4:	4798                	lw	a4,8(a5)
 de6:	fe043783          	ld	a5,-32(s0)
 dea:	479c                	lw	a5,8(a5)
 dec:	9fb9                	addw	a5,a5,a4
 dee:	0007871b          	sext.w	a4,a5
 df2:	fe843783          	ld	a5,-24(s0)
 df6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 df8:	fe043783          	ld	a5,-32(s0)
 dfc:	6398                	ld	a4,0(a5)
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	e398                	sd	a4,0(a5)
 e04:	a031                	j	e10 <free+0x10e>
  } else
    p->s.ptr = bp;
 e06:	fe843783          	ld	a5,-24(s0)
 e0a:	fe043703          	ld	a4,-32(s0)
 e0e:	e398                	sd	a4,0(a5)
  freep = p;
 e10:	00001797          	auipc	a5,0x1
 e14:	22078793          	addi	a5,a5,544 # 2030 <freep>
 e18:	fe843703          	ld	a4,-24(s0)
 e1c:	e398                	sd	a4,0(a5)
}
 e1e:	0001                	nop
 e20:	70a2                	ld	ra,40(sp)
 e22:	7402                	ld	s0,32(sp)
 e24:	6145                	addi	sp,sp,48
 e26:	8082                	ret

0000000000000e28 <morecore>:

static Header*
morecore(uint nu)
{
 e28:	7179                	addi	sp,sp,-48
 e2a:	f406                	sd	ra,40(sp)
 e2c:	f022                	sd	s0,32(sp)
 e2e:	1800                	addi	s0,sp,48
 e30:	87aa                	mv	a5,a0
 e32:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e36:	fdc42783          	lw	a5,-36(s0)
 e3a:	0007871b          	sext.w	a4,a5
 e3e:	6785                	lui	a5,0x1
 e40:	00f77563          	bgeu	a4,a5,e4a <morecore+0x22>
    nu = 4096;
 e44:	6785                	lui	a5,0x1
 e46:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e4a:	fdc42783          	lw	a5,-36(s0)
 e4e:	0047979b          	slliw	a5,a5,0x4
 e52:	2781                	sext.w	a5,a5
 e54:	853e                	mv	a0,a5
 e56:	ee8ff0ef          	jal	53e <sbrk>
 e5a:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e5e:	fe843703          	ld	a4,-24(s0)
 e62:	57fd                	li	a5,-1
 e64:	00f71463          	bne	a4,a5,e6c <morecore+0x44>
    return 0;
 e68:	4781                	li	a5,0
 e6a:	a02d                	j	e94 <morecore+0x6c>
  hp = (Header*)p;
 e6c:	fe843783          	ld	a5,-24(s0)
 e70:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e74:	fe043783          	ld	a5,-32(s0)
 e78:	fdc42703          	lw	a4,-36(s0)
 e7c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e7e:	fe043783          	ld	a5,-32(s0)
 e82:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x172>
 e84:	853e                	mv	a0,a5
 e86:	e7dff0ef          	jal	d02 <free>
  return freep;
 e8a:	00001797          	auipc	a5,0x1
 e8e:	1a678793          	addi	a5,a5,422 # 2030 <freep>
 e92:	639c                	ld	a5,0(a5)
}
 e94:	853e                	mv	a0,a5
 e96:	70a2                	ld	ra,40(sp)
 e98:	7402                	ld	s0,32(sp)
 e9a:	6145                	addi	sp,sp,48
 e9c:	8082                	ret

0000000000000e9e <malloc>:

void*
malloc(uint nbytes)
{
 e9e:	7139                	addi	sp,sp,-64
 ea0:	fc06                	sd	ra,56(sp)
 ea2:	f822                	sd	s0,48(sp)
 ea4:	0080                	addi	s0,sp,64
 ea6:	87aa                	mv	a5,a0
 ea8:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eac:	fcc46783          	lwu	a5,-52(s0)
 eb0:	07bd                	addi	a5,a5,15
 eb2:	8391                	srli	a5,a5,0x4
 eb4:	2781                	sext.w	a5,a5
 eb6:	2785                	addiw	a5,a5,1
 eb8:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ebc:	00001797          	auipc	a5,0x1
 ec0:	17478793          	addi	a5,a5,372 # 2030 <freep>
 ec4:	639c                	ld	a5,0(a5)
 ec6:	fef43023          	sd	a5,-32(s0)
 eca:	fe043783          	ld	a5,-32(s0)
 ece:	ef95                	bnez	a5,f0a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ed0:	00001797          	auipc	a5,0x1
 ed4:	15078793          	addi	a5,a5,336 # 2020 <base>
 ed8:	fef43023          	sd	a5,-32(s0)
 edc:	00001797          	auipc	a5,0x1
 ee0:	15478793          	addi	a5,a5,340 # 2030 <freep>
 ee4:	fe043703          	ld	a4,-32(s0)
 ee8:	e398                	sd	a4,0(a5)
 eea:	00001797          	auipc	a5,0x1
 eee:	14678793          	addi	a5,a5,326 # 2030 <freep>
 ef2:	6398                	ld	a4,0(a5)
 ef4:	00001797          	auipc	a5,0x1
 ef8:	12c78793          	addi	a5,a5,300 # 2020 <base>
 efc:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 efe:	00001797          	auipc	a5,0x1
 f02:	12278793          	addi	a5,a5,290 # 2020 <base>
 f06:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f0a:	fe043783          	ld	a5,-32(s0)
 f0e:	639c                	ld	a5,0(a5)
 f10:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f14:	fe843783          	ld	a5,-24(s0)
 f18:	479c                	lw	a5,8(a5)
 f1a:	fdc42703          	lw	a4,-36(s0)
 f1e:	2701                	sext.w	a4,a4
 f20:	06e7e763          	bltu	a5,a4,f8e <malloc+0xf0>
      if(p->s.size == nunits)
 f24:	fe843783          	ld	a5,-24(s0)
 f28:	479c                	lw	a5,8(a5)
 f2a:	fdc42703          	lw	a4,-36(s0)
 f2e:	2701                	sext.w	a4,a4
 f30:	00f71963          	bne	a4,a5,f42 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f34:	fe843783          	ld	a5,-24(s0)
 f38:	6398                	ld	a4,0(a5)
 f3a:	fe043783          	ld	a5,-32(s0)
 f3e:	e398                	sd	a4,0(a5)
 f40:	a825                	j	f78 <malloc+0xda>
      else {
        p->s.size -= nunits;
 f42:	fe843783          	ld	a5,-24(s0)
 f46:	479c                	lw	a5,8(a5)
 f48:	fdc42703          	lw	a4,-36(s0)
 f4c:	9f99                	subw	a5,a5,a4
 f4e:	0007871b          	sext.w	a4,a5
 f52:	fe843783          	ld	a5,-24(s0)
 f56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f58:	fe843783          	ld	a5,-24(s0)
 f5c:	479c                	lw	a5,8(a5)
 f5e:	1782                	slli	a5,a5,0x20
 f60:	9381                	srli	a5,a5,0x20
 f62:	0792                	slli	a5,a5,0x4
 f64:	fe843703          	ld	a4,-24(s0)
 f68:	97ba                	add	a5,a5,a4
 f6a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f6e:	fe843783          	ld	a5,-24(s0)
 f72:	fdc42703          	lw	a4,-36(s0)
 f76:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f78:	00001797          	auipc	a5,0x1
 f7c:	0b878793          	addi	a5,a5,184 # 2030 <freep>
 f80:	fe043703          	ld	a4,-32(s0)
 f84:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f86:	fe843783          	ld	a5,-24(s0)
 f8a:	07c1                	addi	a5,a5,16
 f8c:	a081                	j	fcc <malloc+0x12e>
    }
    if(p == freep)
 f8e:	00001797          	auipc	a5,0x1
 f92:	0a278793          	addi	a5,a5,162 # 2030 <freep>
 f96:	639c                	ld	a5,0(a5)
 f98:	fe843703          	ld	a4,-24(s0)
 f9c:	00f71e63          	bne	a4,a5,fb8 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 fa0:	fdc42783          	lw	a5,-36(s0)
 fa4:	853e                	mv	a0,a5
 fa6:	e83ff0ef          	jal	e28 <morecore>
 faa:	fea43423          	sd	a0,-24(s0)
 fae:	fe843783          	ld	a5,-24(s0)
 fb2:	e399                	bnez	a5,fb8 <malloc+0x11a>
        return 0;
 fb4:	4781                	li	a5,0
 fb6:	a819                	j	fcc <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fb8:	fe843783          	ld	a5,-24(s0)
 fbc:	fef43023          	sd	a5,-32(s0)
 fc0:	fe843783          	ld	a5,-24(s0)
 fc4:	639c                	ld	a5,0(a5)
 fc6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 fca:	b7a9                	j	f14 <malloc+0x76>
  }
}
 fcc:	853e                	mv	a0,a5
 fce:	70e2                	ld	ra,56(sp)
 fd0:	7442                	ld	s0,48(sp)
 fd2:	6121                	addi	sp,sp,64
 fd4:	8082                	ret
