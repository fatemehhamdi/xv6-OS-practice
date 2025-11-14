
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
  24:	fb058593          	addi	a1,a1,-80 # fd0 <malloc+0x13a>
  28:	4509                	li	a0,2
  2a:	431000ef          	jal	c5a <fprintf>
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
  6a:	f8258593          	addi	a1,a1,-126 # fe8 <malloc+0x152>
  6e:	4509                	li	a0,2
  70:	3eb000ef          	jal	c5a <fprintf>
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

000000000000063a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 63a:	1101                	addi	sp,sp,-32
 63c:	ec06                	sd	ra,24(sp)
 63e:	e822                	sd	s0,16(sp)
 640:	1000                	addi	s0,sp,32
 642:	87aa                	mv	a5,a0
 644:	872e                	mv	a4,a1
 646:	fef42623          	sw	a5,-20(s0)
 64a:	87ba                	mv	a5,a4
 64c:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 650:	feb40713          	addi	a4,s0,-21
 654:	fec42783          	lw	a5,-20(s0)
 658:	4605                	li	a2,1
 65a:	85ba                	mv	a1,a4
 65c:	853e                	mv	a0,a5
 65e:	f55ff0ef          	jal	5b2 <write>
}
 662:	0001                	nop
 664:	60e2                	ld	ra,24(sp)
 666:	6442                	ld	s0,16(sp)
 668:	6105                	addi	sp,sp,32
 66a:	8082                	ret

000000000000066c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 66c:	711d                	addi	sp,sp,-96
 66e:	ec86                	sd	ra,88(sp)
 670:	e8a2                	sd	s0,80(sp)
 672:	1080                	addi	s0,sp,96
 674:	87aa                	mv	a5,a0
 676:	fab43823          	sd	a1,-80(s0)
 67a:	8736                	mv	a4,a3
 67c:	faf42e23          	sw	a5,-68(s0)
 680:	87b2                	mv	a5,a2
 682:	faf42c23          	sw	a5,-72(s0)
 686:	87ba                	mv	a5,a4
 688:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 68c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 690:	fac42783          	lw	a5,-84(s0)
 694:	2781                	sext.w	a5,a5
 696:	cf99                	beqz	a5,6b4 <printint+0x48>
 698:	fb043783          	ld	a5,-80(s0)
 69c:	0007dc63          	bgez	a5,6b4 <printint+0x48>
    neg = 1;
 6a0:	4785                	li	a5,1
 6a2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6a6:	fb043783          	ld	a5,-80(s0)
 6aa:	40f007b3          	neg	a5,a5
 6ae:	fef43023          	sd	a5,-32(s0)
 6b2:	a029                	j	6bc <printint+0x50>
  } else {
    x = xx;
 6b4:	fb043783          	ld	a5,-80(s0)
 6b8:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6bc:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6c0:	fb842783          	lw	a5,-72(s0)
 6c4:	fe043703          	ld	a4,-32(s0)
 6c8:	02f77733          	remu	a4,a4,a5
 6cc:	fec42783          	lw	a5,-20(s0)
 6d0:	0017869b          	addiw	a3,a5,1
 6d4:	fed42623          	sw	a3,-20(s0)
 6d8:	00002697          	auipc	a3,0x2
 6dc:	92868693          	addi	a3,a3,-1752 # 2000 <digits>
 6e0:	9736                	add	a4,a4,a3
 6e2:	00074703          	lbu	a4,0(a4)
 6e6:	17c1                	addi	a5,a5,-16
 6e8:	97a2                	add	a5,a5,s0
 6ea:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 6ee:	fb842783          	lw	a5,-72(s0)
 6f2:	fe043703          	ld	a4,-32(s0)
 6f6:	02f757b3          	divu	a5,a4,a5
 6fa:	fef43023          	sd	a5,-32(s0)
 6fe:	fe043783          	ld	a5,-32(s0)
 702:	ffdd                	bnez	a5,6c0 <printint+0x54>
  if(neg)
 704:	fe842783          	lw	a5,-24(s0)
 708:	2781                	sext.w	a5,a5
 70a:	cb95                	beqz	a5,73e <printint+0xd2>
    buf[i++] = '-';
 70c:	fec42783          	lw	a5,-20(s0)
 710:	0017871b          	addiw	a4,a5,1
 714:	fee42623          	sw	a4,-20(s0)
 718:	17c1                	addi	a5,a5,-16
 71a:	97a2                	add	a5,a5,s0
 71c:	02d00713          	li	a4,45
 720:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 724:	a829                	j	73e <printint+0xd2>
    putc(fd, buf[i]);
 726:	fec42783          	lw	a5,-20(s0)
 72a:	17c1                	addi	a5,a5,-16
 72c:	97a2                	add	a5,a5,s0
 72e:	fd87c703          	lbu	a4,-40(a5)
 732:	fbc42783          	lw	a5,-68(s0)
 736:	85ba                	mv	a1,a4
 738:	853e                	mv	a0,a5
 73a:	f01ff0ef          	jal	63a <putc>
  while(--i >= 0)
 73e:	fec42783          	lw	a5,-20(s0)
 742:	37fd                	addiw	a5,a5,-1
 744:	fef42623          	sw	a5,-20(s0)
 748:	fec42783          	lw	a5,-20(s0)
 74c:	2781                	sext.w	a5,a5
 74e:	fc07dce3          	bgez	a5,726 <printint+0xba>
}
 752:	0001                	nop
 754:	0001                	nop
 756:	60e6                	ld	ra,88(sp)
 758:	6446                	ld	s0,80(sp)
 75a:	6125                	addi	sp,sp,96
 75c:	8082                	ret

000000000000075e <printptr>:

static void
printptr(int fd, uint64 x) {
 75e:	7179                	addi	sp,sp,-48
 760:	f406                	sd	ra,40(sp)
 762:	f022                	sd	s0,32(sp)
 764:	1800                	addi	s0,sp,48
 766:	87aa                	mv	a5,a0
 768:	fcb43823          	sd	a1,-48(s0)
 76c:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 770:	fdc42783          	lw	a5,-36(s0)
 774:	03000593          	li	a1,48
 778:	853e                	mv	a0,a5
 77a:	ec1ff0ef          	jal	63a <putc>
  putc(fd, 'x');
 77e:	fdc42783          	lw	a5,-36(s0)
 782:	07800593          	li	a1,120
 786:	853e                	mv	a0,a5
 788:	eb3ff0ef          	jal	63a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78c:	fe042623          	sw	zero,-20(s0)
 790:	a81d                	j	7c6 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 792:	fd043783          	ld	a5,-48(s0)
 796:	93f1                	srli	a5,a5,0x3c
 798:	00002717          	auipc	a4,0x2
 79c:	86870713          	addi	a4,a4,-1944 # 2000 <digits>
 7a0:	97ba                	add	a5,a5,a4
 7a2:	0007c703          	lbu	a4,0(a5)
 7a6:	fdc42783          	lw	a5,-36(s0)
 7aa:	85ba                	mv	a1,a4
 7ac:	853e                	mv	a0,a5
 7ae:	e8dff0ef          	jal	63a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b2:	fec42783          	lw	a5,-20(s0)
 7b6:	2785                	addiw	a5,a5,1
 7b8:	fef42623          	sw	a5,-20(s0)
 7bc:	fd043783          	ld	a5,-48(s0)
 7c0:	0792                	slli	a5,a5,0x4
 7c2:	fcf43823          	sd	a5,-48(s0)
 7c6:	fec42703          	lw	a4,-20(s0)
 7ca:	47bd                	li	a5,15
 7cc:	fce7f3e3          	bgeu	a5,a4,792 <printptr+0x34>
}
 7d0:	0001                	nop
 7d2:	0001                	nop
 7d4:	70a2                	ld	ra,40(sp)
 7d6:	7402                	ld	s0,32(sp)
 7d8:	6145                	addi	sp,sp,48
 7da:	8082                	ret

00000000000007dc <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7dc:	715d                	addi	sp,sp,-80
 7de:	e486                	sd	ra,72(sp)
 7e0:	e0a2                	sd	s0,64(sp)
 7e2:	0880                	addi	s0,sp,80
 7e4:	87aa                	mv	a5,a0
 7e6:	fcb43023          	sd	a1,-64(s0)
 7ea:	fac43c23          	sd	a2,-72(s0)
 7ee:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 7f2:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 7f6:	fc042e23          	sw	zero,-36(s0)
 7fa:	a189                	j	c3c <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 7fc:	fdc42783          	lw	a5,-36(s0)
 800:	fc043703          	ld	a4,-64(s0)
 804:	97ba                	add	a5,a5,a4
 806:	0007c783          	lbu	a5,0(a5)
 80a:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 80e:	fd842783          	lw	a5,-40(s0)
 812:	2781                	sext.w	a5,a5
 814:	eb8d                	bnez	a5,846 <vprintf+0x6a>
      if(c0 == '%'){
 816:	fd442783          	lw	a5,-44(s0)
 81a:	0007871b          	sext.w	a4,a5
 81e:	02500793          	li	a5,37
 822:	00f71763          	bne	a4,a5,830 <vprintf+0x54>
        state = '%';
 826:	02500793          	li	a5,37
 82a:	fcf42c23          	sw	a5,-40(s0)
 82e:	a111                	j	c32 <vprintf+0x456>
      } else {
        putc(fd, c0);
 830:	fd442783          	lw	a5,-44(s0)
 834:	0ff7f713          	zext.b	a4,a5
 838:	fcc42783          	lw	a5,-52(s0)
 83c:	85ba                	mv	a1,a4
 83e:	853e                	mv	a0,a5
 840:	dfbff0ef          	jal	63a <putc>
 844:	a6fd                	j	c32 <vprintf+0x456>
      }
    } else if(state == '%'){
 846:	fd842783          	lw	a5,-40(s0)
 84a:	0007871b          	sext.w	a4,a5
 84e:	02500793          	li	a5,37
 852:	3ef71063          	bne	a4,a5,c32 <vprintf+0x456>
      c1 = c2 = 0;
 856:	fe042023          	sw	zero,-32(s0)
 85a:	fe042783          	lw	a5,-32(s0)
 85e:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 862:	fd442783          	lw	a5,-44(s0)
 866:	2781                	sext.w	a5,a5
 868:	cb99                	beqz	a5,87e <vprintf+0xa2>
 86a:	fdc42783          	lw	a5,-36(s0)
 86e:	0785                	addi	a5,a5,1
 870:	fc043703          	ld	a4,-64(s0)
 874:	97ba                	add	a5,a5,a4
 876:	0007c783          	lbu	a5,0(a5)
 87a:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 87e:	fe442783          	lw	a5,-28(s0)
 882:	2781                	sext.w	a5,a5
 884:	cb99                	beqz	a5,89a <vprintf+0xbe>
 886:	fdc42783          	lw	a5,-36(s0)
 88a:	0789                	addi	a5,a5,2
 88c:	fc043703          	ld	a4,-64(s0)
 890:	97ba                	add	a5,a5,a4
 892:	0007c783          	lbu	a5,0(a5)
 896:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 89a:	fd442783          	lw	a5,-44(s0)
 89e:	0007871b          	sext.w	a4,a5
 8a2:	06400793          	li	a5,100
 8a6:	02f71363          	bne	a4,a5,8cc <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8aa:	fb843783          	ld	a5,-72(s0)
 8ae:	00878713          	addi	a4,a5,8
 8b2:	fae43c23          	sd	a4,-72(s0)
 8b6:	439c                	lw	a5,0(a5)
 8b8:	873e                	mv	a4,a5
 8ba:	fcc42783          	lw	a5,-52(s0)
 8be:	4685                	li	a3,1
 8c0:	4629                	li	a2,10
 8c2:	85ba                	mv	a1,a4
 8c4:	853e                	mv	a0,a5
 8c6:	da7ff0ef          	jal	66c <printint>
 8ca:	a695                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8cc:	fd442783          	lw	a5,-44(s0)
 8d0:	0007871b          	sext.w	a4,a5
 8d4:	06c00793          	li	a5,108
 8d8:	04f71063          	bne	a4,a5,918 <vprintf+0x13c>
 8dc:	fe442783          	lw	a5,-28(s0)
 8e0:	0007871b          	sext.w	a4,a5
 8e4:	06400793          	li	a5,100
 8e8:	02f71863          	bne	a4,a5,918 <vprintf+0x13c>
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
 908:	d65ff0ef          	jal	66c <printint>
        i += 1;
 90c:	fdc42783          	lw	a5,-36(s0)
 910:	2785                	addiw	a5,a5,1
 912:	fcf42e23          	sw	a5,-36(s0)
 916:	ae21                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 918:	fd442783          	lw	a5,-44(s0)
 91c:	0007871b          	sext.w	a4,a5
 920:	06c00793          	li	a5,108
 924:	04f71863          	bne	a4,a5,974 <vprintf+0x198>
 928:	fe442783          	lw	a5,-28(s0)
 92c:	0007871b          	sext.w	a4,a5
 930:	06c00793          	li	a5,108
 934:	04f71063          	bne	a4,a5,974 <vprintf+0x198>
 938:	fe042783          	lw	a5,-32(s0)
 93c:	0007871b          	sext.w	a4,a5
 940:	06400793          	li	a5,100
 944:	02f71863          	bne	a4,a5,974 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 948:	fb843783          	ld	a5,-72(s0)
 94c:	00878713          	addi	a4,a5,8
 950:	fae43c23          	sd	a4,-72(s0)
 954:	639c                	ld	a5,0(a5)
 956:	873e                	mv	a4,a5
 958:	fcc42783          	lw	a5,-52(s0)
 95c:	4685                	li	a3,1
 95e:	4629                	li	a2,10
 960:	85ba                	mv	a1,a4
 962:	853e                	mv	a0,a5
 964:	d09ff0ef          	jal	66c <printint>
        i += 2;
 968:	fdc42783          	lw	a5,-36(s0)
 96c:	2789                	addiw	a5,a5,2
 96e:	fcf42e23          	sw	a5,-36(s0)
 972:	ac75                	j	c2e <vprintf+0x452>
      } else if(c0 == 'u'){
 974:	fd442783          	lw	a5,-44(s0)
 978:	0007871b          	sext.w	a4,a5
 97c:	07500793          	li	a5,117
 980:	02f71563          	bne	a4,a5,9aa <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 984:	fb843783          	ld	a5,-72(s0)
 988:	00878713          	addi	a4,a5,8
 98c:	fae43c23          	sd	a4,-72(s0)
 990:	439c                	lw	a5,0(a5)
 992:	02079713          	slli	a4,a5,0x20
 996:	9301                	srli	a4,a4,0x20
 998:	fcc42783          	lw	a5,-52(s0)
 99c:	4681                	li	a3,0
 99e:	4629                	li	a2,10
 9a0:	85ba                	mv	a1,a4
 9a2:	853e                	mv	a0,a5
 9a4:	cc9ff0ef          	jal	66c <printint>
 9a8:	a459                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9aa:	fd442783          	lw	a5,-44(s0)
 9ae:	0007871b          	sext.w	a4,a5
 9b2:	06c00793          	li	a5,108
 9b6:	04f71063          	bne	a4,a5,9f6 <vprintf+0x21a>
 9ba:	fe442783          	lw	a5,-28(s0)
 9be:	0007871b          	sext.w	a4,a5
 9c2:	07500793          	li	a5,117
 9c6:	02f71863          	bne	a4,a5,9f6 <vprintf+0x21a>
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
 9e6:	c87ff0ef          	jal	66c <printint>
        i += 1;
 9ea:	fdc42783          	lw	a5,-36(s0)
 9ee:	2785                	addiw	a5,a5,1
 9f0:	fcf42e23          	sw	a5,-36(s0)
 9f4:	ac2d                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9f6:	fd442783          	lw	a5,-44(s0)
 9fa:	0007871b          	sext.w	a4,a5
 9fe:	06c00793          	li	a5,108
 a02:	04f71863          	bne	a4,a5,a52 <vprintf+0x276>
 a06:	fe442783          	lw	a5,-28(s0)
 a0a:	0007871b          	sext.w	a4,a5
 a0e:	06c00793          	li	a5,108
 a12:	04f71063          	bne	a4,a5,a52 <vprintf+0x276>
 a16:	fe042783          	lw	a5,-32(s0)
 a1a:	0007871b          	sext.w	a4,a5
 a1e:	07500793          	li	a5,117
 a22:	02f71863          	bne	a4,a5,a52 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a26:	fb843783          	ld	a5,-72(s0)
 a2a:	00878713          	addi	a4,a5,8
 a2e:	fae43c23          	sd	a4,-72(s0)
 a32:	639c                	ld	a5,0(a5)
 a34:	873e                	mv	a4,a5
 a36:	fcc42783          	lw	a5,-52(s0)
 a3a:	4681                	li	a3,0
 a3c:	4629                	li	a2,10
 a3e:	85ba                	mv	a1,a4
 a40:	853e                	mv	a0,a5
 a42:	c2bff0ef          	jal	66c <printint>
        i += 2;
 a46:	fdc42783          	lw	a5,-36(s0)
 a4a:	2789                	addiw	a5,a5,2
 a4c:	fcf42e23          	sw	a5,-36(s0)
 a50:	aaf9                	j	c2e <vprintf+0x452>
      } else if(c0 == 'x'){
 a52:	fd442783          	lw	a5,-44(s0)
 a56:	0007871b          	sext.w	a4,a5
 a5a:	07800793          	li	a5,120
 a5e:	02f71563          	bne	a4,a5,a88 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a62:	fb843783          	ld	a5,-72(s0)
 a66:	00878713          	addi	a4,a5,8
 a6a:	fae43c23          	sd	a4,-72(s0)
 a6e:	439c                	lw	a5,0(a5)
 a70:	02079713          	slli	a4,a5,0x20
 a74:	9301                	srli	a4,a4,0x20
 a76:	fcc42783          	lw	a5,-52(s0)
 a7a:	4681                	li	a3,0
 a7c:	4641                	li	a2,16
 a7e:	85ba                	mv	a1,a4
 a80:	853e                	mv	a0,a5
 a82:	bebff0ef          	jal	66c <printint>
 a86:	a265                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 a88:	fd442783          	lw	a5,-44(s0)
 a8c:	0007871b          	sext.w	a4,a5
 a90:	06c00793          	li	a5,108
 a94:	04f71063          	bne	a4,a5,ad4 <vprintf+0x2f8>
 a98:	fe442783          	lw	a5,-28(s0)
 a9c:	0007871b          	sext.w	a4,a5
 aa0:	07800793          	li	a5,120
 aa4:	02f71863          	bne	a4,a5,ad4 <vprintf+0x2f8>
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
 ac4:	ba9ff0ef          	jal	66c <printint>
        i += 1;
 ac8:	fdc42783          	lw	a5,-36(s0)
 acc:	2785                	addiw	a5,a5,1
 ace:	fcf42e23          	sw	a5,-36(s0)
 ad2:	aab1                	j	c2e <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 ad4:	fd442783          	lw	a5,-44(s0)
 ad8:	0007871b          	sext.w	a4,a5
 adc:	06c00793          	li	a5,108
 ae0:	04f71863          	bne	a4,a5,b30 <vprintf+0x354>
 ae4:	fe442783          	lw	a5,-28(s0)
 ae8:	0007871b          	sext.w	a4,a5
 aec:	06c00793          	li	a5,108
 af0:	04f71063          	bne	a4,a5,b30 <vprintf+0x354>
 af4:	fe042783          	lw	a5,-32(s0)
 af8:	0007871b          	sext.w	a4,a5
 afc:	07800793          	li	a5,120
 b00:	02f71863          	bne	a4,a5,b30 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b04:	fb843783          	ld	a5,-72(s0)
 b08:	00878713          	addi	a4,a5,8
 b0c:	fae43c23          	sd	a4,-72(s0)
 b10:	639c                	ld	a5,0(a5)
 b12:	873e                	mv	a4,a5
 b14:	fcc42783          	lw	a5,-52(s0)
 b18:	4681                	li	a3,0
 b1a:	4641                	li	a2,16
 b1c:	85ba                	mv	a1,a4
 b1e:	853e                	mv	a0,a5
 b20:	b4dff0ef          	jal	66c <printint>
        i += 2;
 b24:	fdc42783          	lw	a5,-36(s0)
 b28:	2789                	addiw	a5,a5,2
 b2a:	fcf42e23          	sw	a5,-36(s0)
 b2e:	a201                	j	c2e <vprintf+0x452>
      } else if(c0 == 'p'){
 b30:	fd442783          	lw	a5,-44(s0)
 b34:	0007871b          	sext.w	a4,a5
 b38:	07000793          	li	a5,112
 b3c:	02f71063          	bne	a4,a5,b5c <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b40:	fb843783          	ld	a5,-72(s0)
 b44:	00878713          	addi	a4,a5,8
 b48:	fae43c23          	sd	a4,-72(s0)
 b4c:	6398                	ld	a4,0(a5)
 b4e:	fcc42783          	lw	a5,-52(s0)
 b52:	85ba                	mv	a1,a4
 b54:	853e                	mv	a0,a5
 b56:	c09ff0ef          	jal	75e <printptr>
 b5a:	a8d1                	j	c2e <vprintf+0x452>
      } else if(c0 == 'c'){
 b5c:	fd442783          	lw	a5,-44(s0)
 b60:	0007871b          	sext.w	a4,a5
 b64:	06300793          	li	a5,99
 b68:	02f71263          	bne	a4,a5,b8c <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b6c:	fb843783          	ld	a5,-72(s0)
 b70:	00878713          	addi	a4,a5,8
 b74:	fae43c23          	sd	a4,-72(s0)
 b78:	439c                	lw	a5,0(a5)
 b7a:	0ff7f713          	zext.b	a4,a5
 b7e:	fcc42783          	lw	a5,-52(s0)
 b82:	85ba                	mv	a1,a4
 b84:	853e                	mv	a0,a5
 b86:	ab5ff0ef          	jal	63a <putc>
 b8a:	a055                	j	c2e <vprintf+0x452>
      } else if(c0 == 's'){
 b8c:	fd442783          	lw	a5,-44(s0)
 b90:	0007871b          	sext.w	a4,a5
 b94:	07300793          	li	a5,115
 b98:	04f71a63          	bne	a4,a5,bec <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 b9c:	fb843783          	ld	a5,-72(s0)
 ba0:	00878713          	addi	a4,a5,8
 ba4:	fae43c23          	sd	a4,-72(s0)
 ba8:	639c                	ld	a5,0(a5)
 baa:	fef43423          	sd	a5,-24(s0)
 bae:	fe843783          	ld	a5,-24(s0)
 bb2:	e79d                	bnez	a5,be0 <vprintf+0x404>
          s = "(null)";
 bb4:	00000797          	auipc	a5,0x0
 bb8:	44c78793          	addi	a5,a5,1100 # 1000 <malloc+0x16a>
 bbc:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 bc0:	a005                	j	be0 <vprintf+0x404>
          putc(fd, *s);
 bc2:	fe843783          	ld	a5,-24(s0)
 bc6:	0007c703          	lbu	a4,0(a5)
 bca:	fcc42783          	lw	a5,-52(s0)
 bce:	85ba                	mv	a1,a4
 bd0:	853e                	mv	a0,a5
 bd2:	a69ff0ef          	jal	63a <putc>
        for(; *s; s++)
 bd6:	fe843783          	ld	a5,-24(s0)
 bda:	0785                	addi	a5,a5,1
 bdc:	fef43423          	sd	a5,-24(s0)
 be0:	fe843783          	ld	a5,-24(s0)
 be4:	0007c783          	lbu	a5,0(a5)
 be8:	ffe9                	bnez	a5,bc2 <vprintf+0x3e6>
 bea:	a091                	j	c2e <vprintf+0x452>
      } else if(c0 == '%'){
 bec:	fd442783          	lw	a5,-44(s0)
 bf0:	0007871b          	sext.w	a4,a5
 bf4:	02500793          	li	a5,37
 bf8:	00f71a63          	bne	a4,a5,c0c <vprintf+0x430>
        putc(fd, '%');
 bfc:	fcc42783          	lw	a5,-52(s0)
 c00:	02500593          	li	a1,37
 c04:	853e                	mv	a0,a5
 c06:	a35ff0ef          	jal	63a <putc>
 c0a:	a015                	j	c2e <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c0c:	fcc42783          	lw	a5,-52(s0)
 c10:	02500593          	li	a1,37
 c14:	853e                	mv	a0,a5
 c16:	a25ff0ef          	jal	63a <putc>
        putc(fd, c0);
 c1a:	fd442783          	lw	a5,-44(s0)
 c1e:	0ff7f713          	zext.b	a4,a5
 c22:	fcc42783          	lw	a5,-52(s0)
 c26:	85ba                	mv	a1,a4
 c28:	853e                	mv	a0,a5
 c2a:	a11ff0ef          	jal	63a <putc>
      }

      state = 0;
 c2e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c32:	fdc42783          	lw	a5,-36(s0)
 c36:	2785                	addiw	a5,a5,1
 c38:	fcf42e23          	sw	a5,-36(s0)
 c3c:	fdc42783          	lw	a5,-36(s0)
 c40:	fc043703          	ld	a4,-64(s0)
 c44:	97ba                	add	a5,a5,a4
 c46:	0007c783          	lbu	a5,0(a5)
 c4a:	ba0799e3          	bnez	a5,7fc <vprintf+0x20>
    }
  }
}
 c4e:	0001                	nop
 c50:	0001                	nop
 c52:	60a6                	ld	ra,72(sp)
 c54:	6406                	ld	s0,64(sp)
 c56:	6161                	addi	sp,sp,80
 c58:	8082                	ret

0000000000000c5a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c5a:	7159                	addi	sp,sp,-112
 c5c:	fc06                	sd	ra,56(sp)
 c5e:	f822                	sd	s0,48(sp)
 c60:	0080                	addi	s0,sp,64
 c62:	fcb43823          	sd	a1,-48(s0)
 c66:	e010                	sd	a2,0(s0)
 c68:	e414                	sd	a3,8(s0)
 c6a:	e818                	sd	a4,16(s0)
 c6c:	ec1c                	sd	a5,24(s0)
 c6e:	03043023          	sd	a6,32(s0)
 c72:	03143423          	sd	a7,40(s0)
 c76:	87aa                	mv	a5,a0
 c78:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 c7c:	03040793          	addi	a5,s0,48
 c80:	fcf43423          	sd	a5,-56(s0)
 c84:	fc843783          	ld	a5,-56(s0)
 c88:	fd078793          	addi	a5,a5,-48
 c8c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 c90:	fe843703          	ld	a4,-24(s0)
 c94:	fdc42783          	lw	a5,-36(s0)
 c98:	863a                	mv	a2,a4
 c9a:	fd043583          	ld	a1,-48(s0)
 c9e:	853e                	mv	a0,a5
 ca0:	b3dff0ef          	jal	7dc <vprintf>
}
 ca4:	0001                	nop
 ca6:	70e2                	ld	ra,56(sp)
 ca8:	7442                	ld	s0,48(sp)
 caa:	6165                	addi	sp,sp,112
 cac:	8082                	ret

0000000000000cae <printf>:

void
printf(const char *fmt, ...)
{
 cae:	7159                	addi	sp,sp,-112
 cb0:	f406                	sd	ra,40(sp)
 cb2:	f022                	sd	s0,32(sp)
 cb4:	1800                	addi	s0,sp,48
 cb6:	fca43c23          	sd	a0,-40(s0)
 cba:	e40c                	sd	a1,8(s0)
 cbc:	e810                	sd	a2,16(s0)
 cbe:	ec14                	sd	a3,24(s0)
 cc0:	f018                	sd	a4,32(s0)
 cc2:	f41c                	sd	a5,40(s0)
 cc4:	03043823          	sd	a6,48(s0)
 cc8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ccc:	04040793          	addi	a5,s0,64
 cd0:	fcf43823          	sd	a5,-48(s0)
 cd4:	fd043783          	ld	a5,-48(s0)
 cd8:	fc878793          	addi	a5,a5,-56
 cdc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 ce0:	fe843783          	ld	a5,-24(s0)
 ce4:	863e                	mv	a2,a5
 ce6:	fd843583          	ld	a1,-40(s0)
 cea:	4505                	li	a0,1
 cec:	af1ff0ef          	jal	7dc <vprintf>
}
 cf0:	0001                	nop
 cf2:	70a2                	ld	ra,40(sp)
 cf4:	7402                	ld	s0,32(sp)
 cf6:	6165                	addi	sp,sp,112
 cf8:	8082                	ret

0000000000000cfa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cfa:	7179                	addi	sp,sp,-48
 cfc:	f406                	sd	ra,40(sp)
 cfe:	f022                	sd	s0,32(sp)
 d00:	1800                	addi	s0,sp,48
 d02:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d06:	fd843783          	ld	a5,-40(s0)
 d0a:	17c1                	addi	a5,a5,-16
 d0c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d10:	00001797          	auipc	a5,0x1
 d14:	32078793          	addi	a5,a5,800 # 2030 <freep>
 d18:	639c                	ld	a5,0(a5)
 d1a:	fef43423          	sd	a5,-24(s0)
 d1e:	a815                	j	d52 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d20:	fe843783          	ld	a5,-24(s0)
 d24:	639c                	ld	a5,0(a5)
 d26:	fe843703          	ld	a4,-24(s0)
 d2a:	00f76f63          	bltu	a4,a5,d48 <free+0x4e>
 d2e:	fe043703          	ld	a4,-32(s0)
 d32:	fe843783          	ld	a5,-24(s0)
 d36:	02e7eb63          	bltu	a5,a4,d6c <free+0x72>
 d3a:	fe843783          	ld	a5,-24(s0)
 d3e:	639c                	ld	a5,0(a5)
 d40:	fe043703          	ld	a4,-32(s0)
 d44:	02f76463          	bltu	a4,a5,d6c <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d48:	fe843783          	ld	a5,-24(s0)
 d4c:	639c                	ld	a5,0(a5)
 d4e:	fef43423          	sd	a5,-24(s0)
 d52:	fe043703          	ld	a4,-32(s0)
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	fce7f3e3          	bgeu	a5,a4,d20 <free+0x26>
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	639c                	ld	a5,0(a5)
 d64:	fe043703          	ld	a4,-32(s0)
 d68:	faf77ce3          	bgeu	a4,a5,d20 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d6c:	fe043783          	ld	a5,-32(s0)
 d70:	479c                	lw	a5,8(a5)
 d72:	1782                	slli	a5,a5,0x20
 d74:	9381                	srli	a5,a5,0x20
 d76:	0792                	slli	a5,a5,0x4
 d78:	fe043703          	ld	a4,-32(s0)
 d7c:	973e                	add	a4,a4,a5
 d7e:	fe843783          	ld	a5,-24(s0)
 d82:	639c                	ld	a5,0(a5)
 d84:	02f71763          	bne	a4,a5,db2 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 d88:	fe043783          	ld	a5,-32(s0)
 d8c:	4798                	lw	a4,8(a5)
 d8e:	fe843783          	ld	a5,-24(s0)
 d92:	639c                	ld	a5,0(a5)
 d94:	479c                	lw	a5,8(a5)
 d96:	9fb9                	addw	a5,a5,a4
 d98:	0007871b          	sext.w	a4,a5
 d9c:	fe043783          	ld	a5,-32(s0)
 da0:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 da2:	fe843783          	ld	a5,-24(s0)
 da6:	639c                	ld	a5,0(a5)
 da8:	6398                	ld	a4,0(a5)
 daa:	fe043783          	ld	a5,-32(s0)
 dae:	e398                	sd	a4,0(a5)
 db0:	a039                	j	dbe <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 db2:	fe843783          	ld	a5,-24(s0)
 db6:	6398                	ld	a4,0(a5)
 db8:	fe043783          	ld	a5,-32(s0)
 dbc:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 dbe:	fe843783          	ld	a5,-24(s0)
 dc2:	479c                	lw	a5,8(a5)
 dc4:	1782                	slli	a5,a5,0x20
 dc6:	9381                	srli	a5,a5,0x20
 dc8:	0792                	slli	a5,a5,0x4
 dca:	fe843703          	ld	a4,-24(s0)
 dce:	97ba                	add	a5,a5,a4
 dd0:	fe043703          	ld	a4,-32(s0)
 dd4:	02f71563          	bne	a4,a5,dfe <free+0x104>
    p->s.size += bp->s.size;
 dd8:	fe843783          	ld	a5,-24(s0)
 ddc:	4798                	lw	a4,8(a5)
 dde:	fe043783          	ld	a5,-32(s0)
 de2:	479c                	lw	a5,8(a5)
 de4:	9fb9                	addw	a5,a5,a4
 de6:	0007871b          	sext.w	a4,a5
 dea:	fe843783          	ld	a5,-24(s0)
 dee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 df0:	fe043783          	ld	a5,-32(s0)
 df4:	6398                	ld	a4,0(a5)
 df6:	fe843783          	ld	a5,-24(s0)
 dfa:	e398                	sd	a4,0(a5)
 dfc:	a031                	j	e08 <free+0x10e>
  } else
    p->s.ptr = bp;
 dfe:	fe843783          	ld	a5,-24(s0)
 e02:	fe043703          	ld	a4,-32(s0)
 e06:	e398                	sd	a4,0(a5)
  freep = p;
 e08:	00001797          	auipc	a5,0x1
 e0c:	22878793          	addi	a5,a5,552 # 2030 <freep>
 e10:	fe843703          	ld	a4,-24(s0)
 e14:	e398                	sd	a4,0(a5)
}
 e16:	0001                	nop
 e18:	70a2                	ld	ra,40(sp)
 e1a:	7402                	ld	s0,32(sp)
 e1c:	6145                	addi	sp,sp,48
 e1e:	8082                	ret

0000000000000e20 <morecore>:

static Header*
morecore(uint nu)
{
 e20:	7179                	addi	sp,sp,-48
 e22:	f406                	sd	ra,40(sp)
 e24:	f022                	sd	s0,32(sp)
 e26:	1800                	addi	s0,sp,48
 e28:	87aa                	mv	a5,a0
 e2a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e2e:	fdc42783          	lw	a5,-36(s0)
 e32:	0007871b          	sext.w	a4,a5
 e36:	6785                	lui	a5,0x1
 e38:	00f77563          	bgeu	a4,a5,e42 <morecore+0x22>
    nu = 4096;
 e3c:	6785                	lui	a5,0x1
 e3e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e42:	fdc42783          	lw	a5,-36(s0)
 e46:	0047979b          	slliw	a5,a5,0x4
 e4a:	2781                	sext.w	a5,a5
 e4c:	853e                	mv	a0,a5
 e4e:	ef0ff0ef          	jal	53e <sbrk>
 e52:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e56:	fe843703          	ld	a4,-24(s0)
 e5a:	57fd                	li	a5,-1
 e5c:	00f71463          	bne	a4,a5,e64 <morecore+0x44>
    return 0;
 e60:	4781                	li	a5,0
 e62:	a02d                	j	e8c <morecore+0x6c>
  hp = (Header*)p;
 e64:	fe843783          	ld	a5,-24(s0)
 e68:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e6c:	fe043783          	ld	a5,-32(s0)
 e70:	fdc42703          	lw	a4,-36(s0)
 e74:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 e76:	fe043783          	ld	a5,-32(s0)
 e7a:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x17a>
 e7c:	853e                	mv	a0,a5
 e7e:	e7dff0ef          	jal	cfa <free>
  return freep;
 e82:	00001797          	auipc	a5,0x1
 e86:	1ae78793          	addi	a5,a5,430 # 2030 <freep>
 e8a:	639c                	ld	a5,0(a5)
}
 e8c:	853e                	mv	a0,a5
 e8e:	70a2                	ld	ra,40(sp)
 e90:	7402                	ld	s0,32(sp)
 e92:	6145                	addi	sp,sp,48
 e94:	8082                	ret

0000000000000e96 <malloc>:

void*
malloc(uint nbytes)
{
 e96:	7139                	addi	sp,sp,-64
 e98:	fc06                	sd	ra,56(sp)
 e9a:	f822                	sd	s0,48(sp)
 e9c:	0080                	addi	s0,sp,64
 e9e:	87aa                	mv	a5,a0
 ea0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ea4:	fcc46783          	lwu	a5,-52(s0)
 ea8:	07bd                	addi	a5,a5,15
 eaa:	8391                	srli	a5,a5,0x4
 eac:	2781                	sext.w	a5,a5
 eae:	2785                	addiw	a5,a5,1
 eb0:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 eb4:	00001797          	auipc	a5,0x1
 eb8:	17c78793          	addi	a5,a5,380 # 2030 <freep>
 ebc:	639c                	ld	a5,0(a5)
 ebe:	fef43023          	sd	a5,-32(s0)
 ec2:	fe043783          	ld	a5,-32(s0)
 ec6:	ef95                	bnez	a5,f02 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ec8:	00001797          	auipc	a5,0x1
 ecc:	15878793          	addi	a5,a5,344 # 2020 <base>
 ed0:	fef43023          	sd	a5,-32(s0)
 ed4:	00001797          	auipc	a5,0x1
 ed8:	15c78793          	addi	a5,a5,348 # 2030 <freep>
 edc:	fe043703          	ld	a4,-32(s0)
 ee0:	e398                	sd	a4,0(a5)
 ee2:	00001797          	auipc	a5,0x1
 ee6:	14e78793          	addi	a5,a5,334 # 2030 <freep>
 eea:	6398                	ld	a4,0(a5)
 eec:	00001797          	auipc	a5,0x1
 ef0:	13478793          	addi	a5,a5,308 # 2020 <base>
 ef4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ef6:	00001797          	auipc	a5,0x1
 efa:	12a78793          	addi	a5,a5,298 # 2020 <base>
 efe:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f02:	fe043783          	ld	a5,-32(s0)
 f06:	639c                	ld	a5,0(a5)
 f08:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f0c:	fe843783          	ld	a5,-24(s0)
 f10:	479c                	lw	a5,8(a5)
 f12:	fdc42703          	lw	a4,-36(s0)
 f16:	2701                	sext.w	a4,a4
 f18:	06e7e763          	bltu	a5,a4,f86 <malloc+0xf0>
      if(p->s.size == nunits)
 f1c:	fe843783          	ld	a5,-24(s0)
 f20:	479c                	lw	a5,8(a5)
 f22:	fdc42703          	lw	a4,-36(s0)
 f26:	2701                	sext.w	a4,a4
 f28:	00f71963          	bne	a4,a5,f3a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f2c:	fe843783          	ld	a5,-24(s0)
 f30:	6398                	ld	a4,0(a5)
 f32:	fe043783          	ld	a5,-32(s0)
 f36:	e398                	sd	a4,0(a5)
 f38:	a825                	j	f70 <malloc+0xda>
      else {
        p->s.size -= nunits;
 f3a:	fe843783          	ld	a5,-24(s0)
 f3e:	479c                	lw	a5,8(a5)
 f40:	fdc42703          	lw	a4,-36(s0)
 f44:	9f99                	subw	a5,a5,a4
 f46:	0007871b          	sext.w	a4,a5
 f4a:	fe843783          	ld	a5,-24(s0)
 f4e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f50:	fe843783          	ld	a5,-24(s0)
 f54:	479c                	lw	a5,8(a5)
 f56:	1782                	slli	a5,a5,0x20
 f58:	9381                	srli	a5,a5,0x20
 f5a:	0792                	slli	a5,a5,0x4
 f5c:	fe843703          	ld	a4,-24(s0)
 f60:	97ba                	add	a5,a5,a4
 f62:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f66:	fe843783          	ld	a5,-24(s0)
 f6a:	fdc42703          	lw	a4,-36(s0)
 f6e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f70:	00001797          	auipc	a5,0x1
 f74:	0c078793          	addi	a5,a5,192 # 2030 <freep>
 f78:	fe043703          	ld	a4,-32(s0)
 f7c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 f7e:	fe843783          	ld	a5,-24(s0)
 f82:	07c1                	addi	a5,a5,16
 f84:	a081                	j	fc4 <malloc+0x12e>
    }
    if(p == freep)
 f86:	00001797          	auipc	a5,0x1
 f8a:	0aa78793          	addi	a5,a5,170 # 2030 <freep>
 f8e:	639c                	ld	a5,0(a5)
 f90:	fe843703          	ld	a4,-24(s0)
 f94:	00f71e63          	bne	a4,a5,fb0 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 f98:	fdc42783          	lw	a5,-36(s0)
 f9c:	853e                	mv	a0,a5
 f9e:	e83ff0ef          	jal	e20 <morecore>
 fa2:	fea43423          	sd	a0,-24(s0)
 fa6:	fe843783          	ld	a5,-24(s0)
 faa:	e399                	bnez	a5,fb0 <malloc+0x11a>
        return 0;
 fac:	4781                	li	a5,0
 fae:	a819                	j	fc4 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fb0:	fe843783          	ld	a5,-24(s0)
 fb4:	fef43023          	sd	a5,-32(s0)
 fb8:	fe843783          	ld	a5,-24(s0)
 fbc:	639c                	ld	a5,0(a5)
 fbe:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 fc2:	b7a9                	j	f0c <malloc+0x76>
  }
}
 fc4:	853e                	mv	a0,a5
 fc6:	70e2                	ld	ra,56(sp)
 fc8:	7442                	ld	s0,48(sp)
 fca:	6121                	addi	sp,sp,64
 fcc:	8082                	ret
