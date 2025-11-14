
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  char *s = argv[0];
  12:	fd043783          	ld	a5,-48(s0)
  16:	639c                	ld	a5,0(a5)
  18:	fef43423          	sd	a5,-24(s0)

  if(mkdir("dd") != 0){
  1c:	00001517          	auipc	a0,0x1
  20:	fe450513          	addi	a0,a0,-28 # 1000 <malloc+0x13e>
  24:	602000ef          	jal	626 <mkdir>
  28:	87aa                	mv	a5,a0
  2a:	cf81                	beqz	a5,42 <main+0x42>
    printf("%s: mkdir dd failed\n", s);
  2c:	fe843583          	ld	a1,-24(s0)
  30:	00001517          	auipc	a0,0x1
  34:	fd850513          	addi	a0,a0,-40 # 1008 <malloc+0x146>
  38:	4a3000ef          	jal	cda <printf>
    exit(1);
  3c:	4505                	li	a0,1
  3e:	580000ef          	jal	5be <exit>
  }

  if(chdir("dd") != 0){
  42:	00001517          	auipc	a0,0x1
  46:	fbe50513          	addi	a0,a0,-66 # 1000 <malloc+0x13e>
  4a:	5e4000ef          	jal	62e <chdir>
  4e:	87aa                	mv	a5,a0
  50:	cf81                	beqz	a5,68 <main+0x68>
    printf("%s: chdir dd failed\n", s);
  52:	fe843583          	ld	a1,-24(s0)
  56:	00001517          	auipc	a0,0x1
  5a:	fca50513          	addi	a0,a0,-54 # 1020 <malloc+0x15e>
  5e:	47d000ef          	jal	cda <printf>
    exit(1);
  62:	4505                	li	a0,1
  64:	55a000ef          	jal	5be <exit>
  }

  if (unlink("../dd") < 0) {
  68:	00001517          	auipc	a0,0x1
  6c:	fd050513          	addi	a0,a0,-48 # 1038 <malloc+0x176>
  70:	59e000ef          	jal	60e <unlink>
  74:	87aa                	mv	a5,a0
  76:	0007dd63          	bgez	a5,90 <main+0x90>
    printf("%s: unlink failed\n", s);
  7a:	fe843583          	ld	a1,-24(s0)
  7e:	00001517          	auipc	a0,0x1
  82:	fc250513          	addi	a0,a0,-62 # 1040 <malloc+0x17e>
  86:	455000ef          	jal	cda <printf>
    exit(1);
  8a:	4505                	li	a0,1
  8c:	532000ef          	jal	5be <exit>
  }
  printf("wait for kill and reclaim\n");
  90:	00001517          	auipc	a0,0x1
  94:	fc850513          	addi	a0,a0,-56 # 1058 <malloc+0x196>
  98:	443000ef          	jal	cda <printf>
  // sit around until killed
  for(;;) pause(1000);
  9c:	3e800513          	li	a0,1000
  a0:	5ae000ef          	jal	64e <pause>
  a4:	bfe5                	j	9c <main+0x9c>

00000000000000a6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  a6:	7179                	addi	sp,sp,-48
  a8:	f406                	sd	ra,40(sp)
  aa:	f022                	sd	s0,32(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	87aa                	mv	a5,a0
  b0:	fcb43823          	sd	a1,-48(s0)
  b4:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  b8:	fdc42783          	lw	a5,-36(s0)
  bc:	fd043583          	ld	a1,-48(s0)
  c0:	853e                	mv	a0,a5
  c2:	f3fff0ef          	jal	0 <main>
  c6:	87aa                	mv	a5,a0
  c8:	fef42623          	sw	a5,-20(s0)
  exit(r);
  cc:	fec42783          	lw	a5,-20(s0)
  d0:	853e                	mv	a0,a5
  d2:	4ec000ef          	jal	5be <exit>

00000000000000d6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d6:	7179                	addi	sp,sp,-48
  d8:	f406                	sd	ra,40(sp)
  da:	f022                	sd	s0,32(sp)
  dc:	1800                	addi	s0,sp,48
  de:	fca43c23          	sd	a0,-40(s0)
  e2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  e6:	fd843783          	ld	a5,-40(s0)
  ea:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  ee:	0001                	nop
  f0:	fd043703          	ld	a4,-48(s0)
  f4:	00170793          	addi	a5,a4,1
  f8:	fcf43823          	sd	a5,-48(s0)
  fc:	fd843783          	ld	a5,-40(s0)
 100:	00178693          	addi	a3,a5,1
 104:	fcd43c23          	sd	a3,-40(s0)
 108:	00074703          	lbu	a4,0(a4)
 10c:	00e78023          	sb	a4,0(a5)
 110:	0007c783          	lbu	a5,0(a5)
 114:	fff1                	bnez	a5,f0 <strcpy+0x1a>
    ;
  return os;
 116:	fe843783          	ld	a5,-24(s0)
}
 11a:	853e                	mv	a0,a5
 11c:	70a2                	ld	ra,40(sp)
 11e:	7402                	ld	s0,32(sp)
 120:	6145                	addi	sp,sp,48
 122:	8082                	ret

0000000000000124 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 124:	1101                	addi	sp,sp,-32
 126:	ec06                	sd	ra,24(sp)
 128:	e822                	sd	s0,16(sp)
 12a:	1000                	addi	s0,sp,32
 12c:	fea43423          	sd	a0,-24(s0)
 130:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 134:	a819                	j	14a <strcmp+0x26>
    p++, q++;
 136:	fe843783          	ld	a5,-24(s0)
 13a:	0785                	addi	a5,a5,1
 13c:	fef43423          	sd	a5,-24(s0)
 140:	fe043783          	ld	a5,-32(s0)
 144:	0785                	addi	a5,a5,1
 146:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 14a:	fe843783          	ld	a5,-24(s0)
 14e:	0007c783          	lbu	a5,0(a5)
 152:	cb99                	beqz	a5,168 <strcmp+0x44>
 154:	fe843783          	ld	a5,-24(s0)
 158:	0007c703          	lbu	a4,0(a5)
 15c:	fe043783          	ld	a5,-32(s0)
 160:	0007c783          	lbu	a5,0(a5)
 164:	fcf709e3          	beq	a4,a5,136 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 168:	fe843783          	ld	a5,-24(s0)
 16c:	0007c783          	lbu	a5,0(a5)
 170:	0007871b          	sext.w	a4,a5
 174:	fe043783          	ld	a5,-32(s0)
 178:	0007c783          	lbu	a5,0(a5)
 17c:	2781                	sext.w	a5,a5
 17e:	40f707bb          	subw	a5,a4,a5
 182:	2781                	sext.w	a5,a5
}
 184:	853e                	mv	a0,a5
 186:	60e2                	ld	ra,24(sp)
 188:	6442                	ld	s0,16(sp)
 18a:	6105                	addi	sp,sp,32
 18c:	8082                	ret

000000000000018e <strlen>:

uint
strlen(const char *s)
{
 18e:	7179                	addi	sp,sp,-48
 190:	f406                	sd	ra,40(sp)
 192:	f022                	sd	s0,32(sp)
 194:	1800                	addi	s0,sp,48
 196:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 19a:	fe042623          	sw	zero,-20(s0)
 19e:	a031                	j	1aa <strlen+0x1c>
 1a0:	fec42783          	lw	a5,-20(s0)
 1a4:	2785                	addiw	a5,a5,1
 1a6:	fef42623          	sw	a5,-20(s0)
 1aa:	fec42783          	lw	a5,-20(s0)
 1ae:	fd843703          	ld	a4,-40(s0)
 1b2:	97ba                	add	a5,a5,a4
 1b4:	0007c783          	lbu	a5,0(a5)
 1b8:	f7e5                	bnez	a5,1a0 <strlen+0x12>
    ;
  return n;
 1ba:	fec42783          	lw	a5,-20(s0)
}
 1be:	853e                	mv	a0,a5
 1c0:	70a2                	ld	ra,40(sp)
 1c2:	7402                	ld	s0,32(sp)
 1c4:	6145                	addi	sp,sp,48
 1c6:	8082                	ret

00000000000001c8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c8:	7179                	addi	sp,sp,-48
 1ca:	f406                	sd	ra,40(sp)
 1cc:	f022                	sd	s0,32(sp)
 1ce:	1800                	addi	s0,sp,48
 1d0:	fca43c23          	sd	a0,-40(s0)
 1d4:	87ae                	mv	a5,a1
 1d6:	8732                	mv	a4,a2
 1d8:	fcf42a23          	sw	a5,-44(s0)
 1dc:	87ba                	mv	a5,a4
 1de:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 1e2:	fd843783          	ld	a5,-40(s0)
 1e6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 1ea:	fe042623          	sw	zero,-20(s0)
 1ee:	a00d                	j	210 <memset+0x48>
    cdst[i] = c;
 1f0:	fec42783          	lw	a5,-20(s0)
 1f4:	fe043703          	ld	a4,-32(s0)
 1f8:	97ba                	add	a5,a5,a4
 1fa:	fd442703          	lw	a4,-44(s0)
 1fe:	0ff77713          	zext.b	a4,a4
 202:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 206:	fec42783          	lw	a5,-20(s0)
 20a:	2785                	addiw	a5,a5,1
 20c:	fef42623          	sw	a5,-20(s0)
 210:	fec42783          	lw	a5,-20(s0)
 214:	fd042703          	lw	a4,-48(s0)
 218:	2701                	sext.w	a4,a4
 21a:	fce7ebe3          	bltu	a5,a4,1f0 <memset+0x28>
  }
  return dst;
 21e:	fd843783          	ld	a5,-40(s0)
}
 222:	853e                	mv	a0,a5
 224:	70a2                	ld	ra,40(sp)
 226:	7402                	ld	s0,32(sp)
 228:	6145                	addi	sp,sp,48
 22a:	8082                	ret

000000000000022c <strchr>:

char*
strchr(const char *s, char c)
{
 22c:	1101                	addi	sp,sp,-32
 22e:	ec06                	sd	ra,24(sp)
 230:	e822                	sd	s0,16(sp)
 232:	1000                	addi	s0,sp,32
 234:	fea43423          	sd	a0,-24(s0)
 238:	87ae                	mv	a5,a1
 23a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 23e:	a01d                	j	264 <strchr+0x38>
    if(*s == c)
 240:	fe843783          	ld	a5,-24(s0)
 244:	0007c703          	lbu	a4,0(a5)
 248:	fe744783          	lbu	a5,-25(s0)
 24c:	0ff7f793          	zext.b	a5,a5
 250:	00e79563          	bne	a5,a4,25a <strchr+0x2e>
      return (char*)s;
 254:	fe843783          	ld	a5,-24(s0)
 258:	a821                	j	270 <strchr+0x44>
  for(; *s; s++)
 25a:	fe843783          	ld	a5,-24(s0)
 25e:	0785                	addi	a5,a5,1
 260:	fef43423          	sd	a5,-24(s0)
 264:	fe843783          	ld	a5,-24(s0)
 268:	0007c783          	lbu	a5,0(a5)
 26c:	fbf1                	bnez	a5,240 <strchr+0x14>
  return 0;
 26e:	4781                	li	a5,0
}
 270:	853e                	mv	a0,a5
 272:	60e2                	ld	ra,24(sp)
 274:	6442                	ld	s0,16(sp)
 276:	6105                	addi	sp,sp,32
 278:	8082                	ret

000000000000027a <gets>:

char*
gets(char *buf, int max)
{
 27a:	7179                	addi	sp,sp,-48
 27c:	f406                	sd	ra,40(sp)
 27e:	f022                	sd	s0,32(sp)
 280:	1800                	addi	s0,sp,48
 282:	fca43c23          	sd	a0,-40(s0)
 286:	87ae                	mv	a5,a1
 288:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28c:	fe042623          	sw	zero,-20(s0)
 290:	a891                	j	2e4 <gets+0x6a>
    cc = read(0, &c, 1);
 292:	fe740793          	addi	a5,s0,-25
 296:	4605                	li	a2,1
 298:	85be                	mv	a1,a5
 29a:	4501                	li	a0,0
 29c:	33a000ef          	jal	5d6 <read>
 2a0:	87aa                	mv	a5,a0
 2a2:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 2a6:	fe842783          	lw	a5,-24(s0)
 2aa:	2781                	sext.w	a5,a5
 2ac:	04f05663          	blez	a5,2f8 <gets+0x7e>
      break;
    buf[i++] = c;
 2b0:	fec42783          	lw	a5,-20(s0)
 2b4:	0017871b          	addiw	a4,a5,1
 2b8:	fee42623          	sw	a4,-20(s0)
 2bc:	873e                	mv	a4,a5
 2be:	fd843783          	ld	a5,-40(s0)
 2c2:	97ba                	add	a5,a5,a4
 2c4:	fe744703          	lbu	a4,-25(s0)
 2c8:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 2cc:	fe744783          	lbu	a5,-25(s0)
 2d0:	873e                	mv	a4,a5
 2d2:	47a9                	li	a5,10
 2d4:	02f70363          	beq	a4,a5,2fa <gets+0x80>
 2d8:	fe744783          	lbu	a5,-25(s0)
 2dc:	873e                	mv	a4,a5
 2de:	47b5                	li	a5,13
 2e0:	00f70d63          	beq	a4,a5,2fa <gets+0x80>
  for(i=0; i+1 < max; ){
 2e4:	fec42783          	lw	a5,-20(s0)
 2e8:	2785                	addiw	a5,a5,1
 2ea:	2781                	sext.w	a5,a5
 2ec:	fd442703          	lw	a4,-44(s0)
 2f0:	2701                	sext.w	a4,a4
 2f2:	fae7c0e3          	blt	a5,a4,292 <gets+0x18>
 2f6:	a011                	j	2fa <gets+0x80>
      break;
 2f8:	0001                	nop
      break;
  }
  buf[i] = '\0';
 2fa:	fec42783          	lw	a5,-20(s0)
 2fe:	fd843703          	ld	a4,-40(s0)
 302:	97ba                	add	a5,a5,a4
 304:	00078023          	sb	zero,0(a5)
  return buf;
 308:	fd843783          	ld	a5,-40(s0)
}
 30c:	853e                	mv	a0,a5
 30e:	70a2                	ld	ra,40(sp)
 310:	7402                	ld	s0,32(sp)
 312:	6145                	addi	sp,sp,48
 314:	8082                	ret

0000000000000316 <stat>:

int
stat(const char *n, struct stat *st)
{
 316:	7179                	addi	sp,sp,-48
 318:	f406                	sd	ra,40(sp)
 31a:	f022                	sd	s0,32(sp)
 31c:	1800                	addi	s0,sp,48
 31e:	fca43c23          	sd	a0,-40(s0)
 322:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 326:	4581                	li	a1,0
 328:	fd843503          	ld	a0,-40(s0)
 32c:	2d2000ef          	jal	5fe <open>
 330:	87aa                	mv	a5,a0
 332:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 336:	fec42783          	lw	a5,-20(s0)
 33a:	2781                	sext.w	a5,a5
 33c:	0007d463          	bgez	a5,344 <stat+0x2e>
    return -1;
 340:	57fd                	li	a5,-1
 342:	a015                	j	366 <stat+0x50>
  r = fstat(fd, st);
 344:	fec42783          	lw	a5,-20(s0)
 348:	fd043583          	ld	a1,-48(s0)
 34c:	853e                	mv	a0,a5
 34e:	2c8000ef          	jal	616 <fstat>
 352:	87aa                	mv	a5,a0
 354:	fef42423          	sw	a5,-24(s0)
  close(fd);
 358:	fec42783          	lw	a5,-20(s0)
 35c:	853e                	mv	a0,a5
 35e:	288000ef          	jal	5e6 <close>
  return r;
 362:	fe842783          	lw	a5,-24(s0)
}
 366:	853e                	mv	a0,a5
 368:	70a2                	ld	ra,40(sp)
 36a:	7402                	ld	s0,32(sp)
 36c:	6145                	addi	sp,sp,48
 36e:	8082                	ret

0000000000000370 <atoi>:

int
atoi(const char *s)
{
 370:	7179                	addi	sp,sp,-48
 372:	f406                	sd	ra,40(sp)
 374:	f022                	sd	s0,32(sp)
 376:	1800                	addi	s0,sp,48
 378:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 37c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 380:	a81d                	j	3b6 <atoi+0x46>
    n = n*10 + *s++ - '0';
 382:	fec42783          	lw	a5,-20(s0)
 386:	873e                	mv	a4,a5
 388:	87ba                	mv	a5,a4
 38a:	0027979b          	slliw	a5,a5,0x2
 38e:	9fb9                	addw	a5,a5,a4
 390:	0017979b          	slliw	a5,a5,0x1
 394:	0007871b          	sext.w	a4,a5
 398:	fd843783          	ld	a5,-40(s0)
 39c:	00178693          	addi	a3,a5,1
 3a0:	fcd43c23          	sd	a3,-40(s0)
 3a4:	0007c783          	lbu	a5,0(a5)
 3a8:	2781                	sext.w	a5,a5
 3aa:	9fb9                	addw	a5,a5,a4
 3ac:	2781                	sext.w	a5,a5
 3ae:	fd07879b          	addiw	a5,a5,-48
 3b2:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 3b6:	fd843783          	ld	a5,-40(s0)
 3ba:	0007c783          	lbu	a5,0(a5)
 3be:	873e                	mv	a4,a5
 3c0:	02f00793          	li	a5,47
 3c4:	00e7fb63          	bgeu	a5,a4,3da <atoi+0x6a>
 3c8:	fd843783          	ld	a5,-40(s0)
 3cc:	0007c783          	lbu	a5,0(a5)
 3d0:	873e                	mv	a4,a5
 3d2:	03900793          	li	a5,57
 3d6:	fae7f6e3          	bgeu	a5,a4,382 <atoi+0x12>
  return n;
 3da:	fec42783          	lw	a5,-20(s0)
}
 3de:	853e                	mv	a0,a5
 3e0:	70a2                	ld	ra,40(sp)
 3e2:	7402                	ld	s0,32(sp)
 3e4:	6145                	addi	sp,sp,48
 3e6:	8082                	ret

00000000000003e8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e8:	7139                	addi	sp,sp,-64
 3ea:	fc06                	sd	ra,56(sp)
 3ec:	f822                	sd	s0,48(sp)
 3ee:	0080                	addi	s0,sp,64
 3f0:	fca43c23          	sd	a0,-40(s0)
 3f4:	fcb43823          	sd	a1,-48(s0)
 3f8:	87b2                	mv	a5,a2
 3fa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3fe:	fd843783          	ld	a5,-40(s0)
 402:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 406:	fd043783          	ld	a5,-48(s0)
 40a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 40e:	fe043703          	ld	a4,-32(s0)
 412:	fe843783          	ld	a5,-24(s0)
 416:	02e7fc63          	bgeu	a5,a4,44e <memmove+0x66>
    while(n-- > 0)
 41a:	a00d                	j	43c <memmove+0x54>
      *dst++ = *src++;
 41c:	fe043703          	ld	a4,-32(s0)
 420:	00170793          	addi	a5,a4,1
 424:	fef43023          	sd	a5,-32(s0)
 428:	fe843783          	ld	a5,-24(s0)
 42c:	00178693          	addi	a3,a5,1
 430:	fed43423          	sd	a3,-24(s0)
 434:	00074703          	lbu	a4,0(a4)
 438:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 43c:	fcc42783          	lw	a5,-52(s0)
 440:	fff7871b          	addiw	a4,a5,-1
 444:	fce42623          	sw	a4,-52(s0)
 448:	fcf04ae3          	bgtz	a5,41c <memmove+0x34>
 44c:	a891                	j	4a0 <memmove+0xb8>
  } else {
    dst += n;
 44e:	fcc42783          	lw	a5,-52(s0)
 452:	fe843703          	ld	a4,-24(s0)
 456:	97ba                	add	a5,a5,a4
 458:	fef43423          	sd	a5,-24(s0)
    src += n;
 45c:	fcc42783          	lw	a5,-52(s0)
 460:	fe043703          	ld	a4,-32(s0)
 464:	97ba                	add	a5,a5,a4
 466:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 46a:	a01d                	j	490 <memmove+0xa8>
      *--dst = *--src;
 46c:	fe043783          	ld	a5,-32(s0)
 470:	17fd                	addi	a5,a5,-1
 472:	fef43023          	sd	a5,-32(s0)
 476:	fe843783          	ld	a5,-24(s0)
 47a:	17fd                	addi	a5,a5,-1
 47c:	fef43423          	sd	a5,-24(s0)
 480:	fe043783          	ld	a5,-32(s0)
 484:	0007c703          	lbu	a4,0(a5)
 488:	fe843783          	ld	a5,-24(s0)
 48c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 490:	fcc42783          	lw	a5,-52(s0)
 494:	fff7871b          	addiw	a4,a5,-1
 498:	fce42623          	sw	a4,-52(s0)
 49c:	fcf048e3          	bgtz	a5,46c <memmove+0x84>
  }
  return vdst;
 4a0:	fd843783          	ld	a5,-40(s0)
}
 4a4:	853e                	mv	a0,a5
 4a6:	70e2                	ld	ra,56(sp)
 4a8:	7442                	ld	s0,48(sp)
 4aa:	6121                	addi	sp,sp,64
 4ac:	8082                	ret

00000000000004ae <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ae:	7139                	addi	sp,sp,-64
 4b0:	fc06                	sd	ra,56(sp)
 4b2:	f822                	sd	s0,48(sp)
 4b4:	0080                	addi	s0,sp,64
 4b6:	fca43c23          	sd	a0,-40(s0)
 4ba:	fcb43823          	sd	a1,-48(s0)
 4be:	87b2                	mv	a5,a2
 4c0:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 4c4:	fd843783          	ld	a5,-40(s0)
 4c8:	fef43423          	sd	a5,-24(s0)
 4cc:	fd043783          	ld	a5,-48(s0)
 4d0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4d4:	a0a1                	j	51c <memcmp+0x6e>
    if (*p1 != *p2) {
 4d6:	fe843783          	ld	a5,-24(s0)
 4da:	0007c703          	lbu	a4,0(a5)
 4de:	fe043783          	ld	a5,-32(s0)
 4e2:	0007c783          	lbu	a5,0(a5)
 4e6:	02f70163          	beq	a4,a5,508 <memcmp+0x5a>
      return *p1 - *p2;
 4ea:	fe843783          	ld	a5,-24(s0)
 4ee:	0007c783          	lbu	a5,0(a5)
 4f2:	0007871b          	sext.w	a4,a5
 4f6:	fe043783          	ld	a5,-32(s0)
 4fa:	0007c783          	lbu	a5,0(a5)
 4fe:	2781                	sext.w	a5,a5
 500:	40f707bb          	subw	a5,a4,a5
 504:	2781                	sext.w	a5,a5
 506:	a01d                	j	52c <memcmp+0x7e>
    }
    p1++;
 508:	fe843783          	ld	a5,-24(s0)
 50c:	0785                	addi	a5,a5,1
 50e:	fef43423          	sd	a5,-24(s0)
    p2++;
 512:	fe043783          	ld	a5,-32(s0)
 516:	0785                	addi	a5,a5,1
 518:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 51c:	fcc42783          	lw	a5,-52(s0)
 520:	fff7871b          	addiw	a4,a5,-1
 524:	fce42623          	sw	a4,-52(s0)
 528:	f7dd                	bnez	a5,4d6 <memcmp+0x28>
  }
  return 0;
 52a:	4781                	li	a5,0
}
 52c:	853e                	mv	a0,a5
 52e:	70e2                	ld	ra,56(sp)
 530:	7442                	ld	s0,48(sp)
 532:	6121                	addi	sp,sp,64
 534:	8082                	ret

0000000000000536 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 536:	7179                	addi	sp,sp,-48
 538:	f406                	sd	ra,40(sp)
 53a:	f022                	sd	s0,32(sp)
 53c:	1800                	addi	s0,sp,48
 53e:	fea43423          	sd	a0,-24(s0)
 542:	feb43023          	sd	a1,-32(s0)
 546:	87b2                	mv	a5,a2
 548:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 54c:	fdc42783          	lw	a5,-36(s0)
 550:	863e                	mv	a2,a5
 552:	fe043583          	ld	a1,-32(s0)
 556:	fe843503          	ld	a0,-24(s0)
 55a:	e8fff0ef          	jal	3e8 <memmove>
 55e:	87aa                	mv	a5,a0
}
 560:	853e                	mv	a0,a5
 562:	70a2                	ld	ra,40(sp)
 564:	7402                	ld	s0,32(sp)
 566:	6145                	addi	sp,sp,48
 568:	8082                	ret

000000000000056a <sbrk>:

char *
sbrk(int n) {
 56a:	1101                	addi	sp,sp,-32
 56c:	ec06                	sd	ra,24(sp)
 56e:	e822                	sd	s0,16(sp)
 570:	1000                	addi	s0,sp,32
 572:	87aa                	mv	a5,a0
 574:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 578:	fec42783          	lw	a5,-20(s0)
 57c:	4585                	li	a1,1
 57e:	853e                	mv	a0,a5
 580:	0c6000ef          	jal	646 <sys_sbrk>
 584:	87aa                	mv	a5,a0
}
 586:	853e                	mv	a0,a5
 588:	60e2                	ld	ra,24(sp)
 58a:	6442                	ld	s0,16(sp)
 58c:	6105                	addi	sp,sp,32
 58e:	8082                	ret

0000000000000590 <sbrklazy>:

char *
sbrklazy(int n) {
 590:	1101                	addi	sp,sp,-32
 592:	ec06                	sd	ra,24(sp)
 594:	e822                	sd	s0,16(sp)
 596:	1000                	addi	s0,sp,32
 598:	87aa                	mv	a5,a0
 59a:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 59e:	fec42783          	lw	a5,-20(s0)
 5a2:	4589                	li	a1,2
 5a4:	853e                	mv	a0,a5
 5a6:	0a0000ef          	jal	646 <sys_sbrk>
 5aa:	87aa                	mv	a5,a0
}
 5ac:	853e                	mv	a0,a5
 5ae:	60e2                	ld	ra,24(sp)
 5b0:	6442                	ld	s0,16(sp)
 5b2:	6105                	addi	sp,sp,32
 5b4:	8082                	ret

00000000000005b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b6:	4885                	li	a7,1
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <exit>:
.global exit
exit:
 li a7, SYS_exit
 5be:	4889                	li	a7,2
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c6:	488d                	li	a7,3
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ce:	4891                	li	a7,4
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <read>:
.global read
read:
 li a7, SYS_read
 5d6:	4895                	li	a7,5
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <write>:
.global write
write:
 li a7, SYS_write
 5de:	48c1                	li	a7,16
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <close>:
.global close
close:
 li a7, SYS_close
 5e6:	48d5                	li	a7,21
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ee:	4899                	li	a7,6
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f6:	489d                	li	a7,7
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <open>:
.global open
open:
 li a7, SYS_open
 5fe:	48bd                	li	a7,15
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 606:	48c5                	li	a7,17
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 60e:	48c9                	li	a7,18
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 616:	48a1                	li	a7,8
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <link>:
.global link
link:
 li a7, SYS_link
 61e:	48cd                	li	a7,19
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 626:	48d1                	li	a7,20
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 62e:	48a5                	li	a7,9
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <dup>:
.global dup
dup:
 li a7, SYS_dup
 636:	48a9                	li	a7,10
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 63e:	48ad                	li	a7,11
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 646:	48b1                	li	a7,12
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <pause>:
.global pause
pause:
 li a7, SYS_pause
 64e:	48b5                	li	a7,13
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 656:	48b9                	li	a7,14
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <top>:
.global top
top:
 li a7, SYS_top
 65e:	48d9                	li	a7,22
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 666:	1101                	addi	sp,sp,-32
 668:	ec06                	sd	ra,24(sp)
 66a:	e822                	sd	s0,16(sp)
 66c:	1000                	addi	s0,sp,32
 66e:	87aa                	mv	a5,a0
 670:	872e                	mv	a4,a1
 672:	fef42623          	sw	a5,-20(s0)
 676:	87ba                	mv	a5,a4
 678:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 67c:	feb40713          	addi	a4,s0,-21
 680:	fec42783          	lw	a5,-20(s0)
 684:	4605                	li	a2,1
 686:	85ba                	mv	a1,a4
 688:	853e                	mv	a0,a5
 68a:	f55ff0ef          	jal	5de <write>
}
 68e:	0001                	nop
 690:	60e2                	ld	ra,24(sp)
 692:	6442                	ld	s0,16(sp)
 694:	6105                	addi	sp,sp,32
 696:	8082                	ret

0000000000000698 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 698:	711d                	addi	sp,sp,-96
 69a:	ec86                	sd	ra,88(sp)
 69c:	e8a2                	sd	s0,80(sp)
 69e:	1080                	addi	s0,sp,96
 6a0:	87aa                	mv	a5,a0
 6a2:	fab43823          	sd	a1,-80(s0)
 6a6:	8736                	mv	a4,a3
 6a8:	faf42e23          	sw	a5,-68(s0)
 6ac:	87b2                	mv	a5,a2
 6ae:	faf42c23          	sw	a5,-72(s0)
 6b2:	87ba                	mv	a5,a4
 6b4:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
 6b8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6bc:	fac42783          	lw	a5,-84(s0)
 6c0:	2781                	sext.w	a5,a5
 6c2:	cf99                	beqz	a5,6e0 <printint+0x48>
 6c4:	fb043783          	ld	a5,-80(s0)
 6c8:	0007dc63          	bgez	a5,6e0 <printint+0x48>
    neg = 1;
 6cc:	4785                	li	a5,1
 6ce:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6d2:	fb043783          	ld	a5,-80(s0)
 6d6:	40f007b3          	neg	a5,a5
 6da:	fef43023          	sd	a5,-32(s0)
 6de:	a029                	j	6e8 <printint+0x50>
  } else {
    x = xx;
 6e0:	fb043783          	ld	a5,-80(s0)
 6e4:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
 6e8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 6ec:	fb842783          	lw	a5,-72(s0)
 6f0:	fe043703          	ld	a4,-32(s0)
 6f4:	02f77733          	remu	a4,a4,a5
 6f8:	fec42783          	lw	a5,-20(s0)
 6fc:	0017869b          	addiw	a3,a5,1
 700:	fed42623          	sw	a3,-20(s0)
 704:	00002697          	auipc	a3,0x2
 708:	8fc68693          	addi	a3,a3,-1796 # 2000 <digits>
 70c:	9736                	add	a4,a4,a3
 70e:	00074703          	lbu	a4,0(a4)
 712:	17c1                	addi	a5,a5,-16
 714:	97a2                	add	a5,a5,s0
 716:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
 71a:	fb842783          	lw	a5,-72(s0)
 71e:	fe043703          	ld	a4,-32(s0)
 722:	02f757b3          	divu	a5,a4,a5
 726:	fef43023          	sd	a5,-32(s0)
 72a:	fe043783          	ld	a5,-32(s0)
 72e:	ffdd                	bnez	a5,6ec <printint+0x54>
  if(neg)
 730:	fe842783          	lw	a5,-24(s0)
 734:	2781                	sext.w	a5,a5
 736:	cb95                	beqz	a5,76a <printint+0xd2>
    buf[i++] = '-';
 738:	fec42783          	lw	a5,-20(s0)
 73c:	0017871b          	addiw	a4,a5,1
 740:	fee42623          	sw	a4,-20(s0)
 744:	17c1                	addi	a5,a5,-16
 746:	97a2                	add	a5,a5,s0
 748:	02d00713          	li	a4,45
 74c:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
 750:	a829                	j	76a <printint+0xd2>
    putc(fd, buf[i]);
 752:	fec42783          	lw	a5,-20(s0)
 756:	17c1                	addi	a5,a5,-16
 758:	97a2                	add	a5,a5,s0
 75a:	fd87c703          	lbu	a4,-40(a5)
 75e:	fbc42783          	lw	a5,-68(s0)
 762:	85ba                	mv	a1,a4
 764:	853e                	mv	a0,a5
 766:	f01ff0ef          	jal	666 <putc>
  while(--i >= 0)
 76a:	fec42783          	lw	a5,-20(s0)
 76e:	37fd                	addiw	a5,a5,-1
 770:	fef42623          	sw	a5,-20(s0)
 774:	fec42783          	lw	a5,-20(s0)
 778:	2781                	sext.w	a5,a5
 77a:	fc07dce3          	bgez	a5,752 <printint+0xba>
}
 77e:	0001                	nop
 780:	0001                	nop
 782:	60e6                	ld	ra,88(sp)
 784:	6446                	ld	s0,80(sp)
 786:	6125                	addi	sp,sp,96
 788:	8082                	ret

000000000000078a <printptr>:

static void
printptr(int fd, uint64 x) {
 78a:	7179                	addi	sp,sp,-48
 78c:	f406                	sd	ra,40(sp)
 78e:	f022                	sd	s0,32(sp)
 790:	1800                	addi	s0,sp,48
 792:	87aa                	mv	a5,a0
 794:	fcb43823          	sd	a1,-48(s0)
 798:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 79c:	fdc42783          	lw	a5,-36(s0)
 7a0:	03000593          	li	a1,48
 7a4:	853e                	mv	a0,a5
 7a6:	ec1ff0ef          	jal	666 <putc>
  putc(fd, 'x');
 7aa:	fdc42783          	lw	a5,-36(s0)
 7ae:	07800593          	li	a1,120
 7b2:	853e                	mv	a0,a5
 7b4:	eb3ff0ef          	jal	666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b8:	fe042623          	sw	zero,-20(s0)
 7bc:	a81d                	j	7f2 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7be:	fd043783          	ld	a5,-48(s0)
 7c2:	93f1                	srli	a5,a5,0x3c
 7c4:	00002717          	auipc	a4,0x2
 7c8:	83c70713          	addi	a4,a4,-1988 # 2000 <digits>
 7cc:	97ba                	add	a5,a5,a4
 7ce:	0007c703          	lbu	a4,0(a5)
 7d2:	fdc42783          	lw	a5,-36(s0)
 7d6:	85ba                	mv	a1,a4
 7d8:	853e                	mv	a0,a5
 7da:	e8dff0ef          	jal	666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7de:	fec42783          	lw	a5,-20(s0)
 7e2:	2785                	addiw	a5,a5,1
 7e4:	fef42623          	sw	a5,-20(s0)
 7e8:	fd043783          	ld	a5,-48(s0)
 7ec:	0792                	slli	a5,a5,0x4
 7ee:	fcf43823          	sd	a5,-48(s0)
 7f2:	fec42703          	lw	a4,-20(s0)
 7f6:	47bd                	li	a5,15
 7f8:	fce7f3e3          	bgeu	a5,a4,7be <printptr+0x34>
}
 7fc:	0001                	nop
 7fe:	0001                	nop
 800:	70a2                	ld	ra,40(sp)
 802:	7402                	ld	s0,32(sp)
 804:	6145                	addi	sp,sp,48
 806:	8082                	ret

0000000000000808 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 808:	715d                	addi	sp,sp,-80
 80a:	e486                	sd	ra,72(sp)
 80c:	e0a2                	sd	s0,64(sp)
 80e:	0880                	addi	s0,sp,80
 810:	87aa                	mv	a5,a0
 812:	fcb43023          	sd	a1,-64(s0)
 816:	fac43c23          	sd	a2,-72(s0)
 81a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
 81e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 822:	fc042e23          	sw	zero,-36(s0)
 826:	a189                	j	c68 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
 828:	fdc42783          	lw	a5,-36(s0)
 82c:	fc043703          	ld	a4,-64(s0)
 830:	97ba                	add	a5,a5,a4
 832:	0007c783          	lbu	a5,0(a5)
 836:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
 83a:	fd842783          	lw	a5,-40(s0)
 83e:	2781                	sext.w	a5,a5
 840:	eb8d                	bnez	a5,872 <vprintf+0x6a>
      if(c0 == '%'){
 842:	fd442783          	lw	a5,-44(s0)
 846:	0007871b          	sext.w	a4,a5
 84a:	02500793          	li	a5,37
 84e:	00f71763          	bne	a4,a5,85c <vprintf+0x54>
        state = '%';
 852:	02500793          	li	a5,37
 856:	fcf42c23          	sw	a5,-40(s0)
 85a:	a111                	j	c5e <vprintf+0x456>
      } else {
        putc(fd, c0);
 85c:	fd442783          	lw	a5,-44(s0)
 860:	0ff7f713          	zext.b	a4,a5
 864:	fcc42783          	lw	a5,-52(s0)
 868:	85ba                	mv	a1,a4
 86a:	853e                	mv	a0,a5
 86c:	dfbff0ef          	jal	666 <putc>
 870:	a6fd                	j	c5e <vprintf+0x456>
      }
    } else if(state == '%'){
 872:	fd842783          	lw	a5,-40(s0)
 876:	0007871b          	sext.w	a4,a5
 87a:	02500793          	li	a5,37
 87e:	3ef71063          	bne	a4,a5,c5e <vprintf+0x456>
      c1 = c2 = 0;
 882:	fe042023          	sw	zero,-32(s0)
 886:	fe042783          	lw	a5,-32(s0)
 88a:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
 88e:	fd442783          	lw	a5,-44(s0)
 892:	2781                	sext.w	a5,a5
 894:	cb99                	beqz	a5,8aa <vprintf+0xa2>
 896:	fdc42783          	lw	a5,-36(s0)
 89a:	0785                	addi	a5,a5,1
 89c:	fc043703          	ld	a4,-64(s0)
 8a0:	97ba                	add	a5,a5,a4
 8a2:	0007c783          	lbu	a5,0(a5)
 8a6:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
 8aa:	fe442783          	lw	a5,-28(s0)
 8ae:	2781                	sext.w	a5,a5
 8b0:	cb99                	beqz	a5,8c6 <vprintf+0xbe>
 8b2:	fdc42783          	lw	a5,-36(s0)
 8b6:	0789                	addi	a5,a5,2
 8b8:	fc043703          	ld	a4,-64(s0)
 8bc:	97ba                	add	a5,a5,a4
 8be:	0007c783          	lbu	a5,0(a5)
 8c2:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
 8c6:	fd442783          	lw	a5,-44(s0)
 8ca:	0007871b          	sext.w	a4,a5
 8ce:	06400793          	li	a5,100
 8d2:	02f71363          	bne	a4,a5,8f8 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
 8d6:	fb843783          	ld	a5,-72(s0)
 8da:	00878713          	addi	a4,a5,8
 8de:	fae43c23          	sd	a4,-72(s0)
 8e2:	439c                	lw	a5,0(a5)
 8e4:	873e                	mv	a4,a5
 8e6:	fcc42783          	lw	a5,-52(s0)
 8ea:	4685                	li	a3,1
 8ec:	4629                	li	a2,10
 8ee:	85ba                	mv	a1,a4
 8f0:	853e                	mv	a0,a5
 8f2:	da7ff0ef          	jal	698 <printint>
 8f6:	a695                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
 8f8:	fd442783          	lw	a5,-44(s0)
 8fc:	0007871b          	sext.w	a4,a5
 900:	06c00793          	li	a5,108
 904:	04f71063          	bne	a4,a5,944 <vprintf+0x13c>
 908:	fe442783          	lw	a5,-28(s0)
 90c:	0007871b          	sext.w	a4,a5
 910:	06400793          	li	a5,100
 914:	02f71863          	bne	a4,a5,944 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 918:	fb843783          	ld	a5,-72(s0)
 91c:	00878713          	addi	a4,a5,8
 920:	fae43c23          	sd	a4,-72(s0)
 924:	639c                	ld	a5,0(a5)
 926:	873e                	mv	a4,a5
 928:	fcc42783          	lw	a5,-52(s0)
 92c:	4685                	li	a3,1
 92e:	4629                	li	a2,10
 930:	85ba                	mv	a1,a4
 932:	853e                	mv	a0,a5
 934:	d65ff0ef          	jal	698 <printint>
        i += 1;
 938:	fdc42783          	lw	a5,-36(s0)
 93c:	2785                	addiw	a5,a5,1
 93e:	fcf42e23          	sw	a5,-36(s0)
 942:	ae21                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 944:	fd442783          	lw	a5,-44(s0)
 948:	0007871b          	sext.w	a4,a5
 94c:	06c00793          	li	a5,108
 950:	04f71863          	bne	a4,a5,9a0 <vprintf+0x198>
 954:	fe442783          	lw	a5,-28(s0)
 958:	0007871b          	sext.w	a4,a5
 95c:	06c00793          	li	a5,108
 960:	04f71063          	bne	a4,a5,9a0 <vprintf+0x198>
 964:	fe042783          	lw	a5,-32(s0)
 968:	0007871b          	sext.w	a4,a5
 96c:	06400793          	li	a5,100
 970:	02f71863          	bne	a4,a5,9a0 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
 974:	fb843783          	ld	a5,-72(s0)
 978:	00878713          	addi	a4,a5,8
 97c:	fae43c23          	sd	a4,-72(s0)
 980:	639c                	ld	a5,0(a5)
 982:	873e                	mv	a4,a5
 984:	fcc42783          	lw	a5,-52(s0)
 988:	4685                	li	a3,1
 98a:	4629                	li	a2,10
 98c:	85ba                	mv	a1,a4
 98e:	853e                	mv	a0,a5
 990:	d09ff0ef          	jal	698 <printint>
        i += 2;
 994:	fdc42783          	lw	a5,-36(s0)
 998:	2789                	addiw	a5,a5,2
 99a:	fcf42e23          	sw	a5,-36(s0)
 99e:	ac75                	j	c5a <vprintf+0x452>
      } else if(c0 == 'u'){
 9a0:	fd442783          	lw	a5,-44(s0)
 9a4:	0007871b          	sext.w	a4,a5
 9a8:	07500793          	li	a5,117
 9ac:	02f71563          	bne	a4,a5,9d6 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9b0:	fb843783          	ld	a5,-72(s0)
 9b4:	00878713          	addi	a4,a5,8
 9b8:	fae43c23          	sd	a4,-72(s0)
 9bc:	439c                	lw	a5,0(a5)
 9be:	02079713          	slli	a4,a5,0x20
 9c2:	9301                	srli	a4,a4,0x20
 9c4:	fcc42783          	lw	a5,-52(s0)
 9c8:	4681                	li	a3,0
 9ca:	4629                	li	a2,10
 9cc:	85ba                	mv	a1,a4
 9ce:	853e                	mv	a0,a5
 9d0:	cc9ff0ef          	jal	698 <printint>
 9d4:	a459                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
 9d6:	fd442783          	lw	a5,-44(s0)
 9da:	0007871b          	sext.w	a4,a5
 9de:	06c00793          	li	a5,108
 9e2:	04f71063          	bne	a4,a5,a22 <vprintf+0x21a>
 9e6:	fe442783          	lw	a5,-28(s0)
 9ea:	0007871b          	sext.w	a4,a5
 9ee:	07500793          	li	a5,117
 9f2:	02f71863          	bne	a4,a5,a22 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f6:	fb843783          	ld	a5,-72(s0)
 9fa:	00878713          	addi	a4,a5,8
 9fe:	fae43c23          	sd	a4,-72(s0)
 a02:	639c                	ld	a5,0(a5)
 a04:	873e                	mv	a4,a5
 a06:	fcc42783          	lw	a5,-52(s0)
 a0a:	4681                	li	a3,0
 a0c:	4629                	li	a2,10
 a0e:	85ba                	mv	a1,a4
 a10:	853e                	mv	a0,a5
 a12:	c87ff0ef          	jal	698 <printint>
        i += 1;
 a16:	fdc42783          	lw	a5,-36(s0)
 a1a:	2785                	addiw	a5,a5,1
 a1c:	fcf42e23          	sw	a5,-36(s0)
 a20:	ac2d                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a22:	fd442783          	lw	a5,-44(s0)
 a26:	0007871b          	sext.w	a4,a5
 a2a:	06c00793          	li	a5,108
 a2e:	04f71863          	bne	a4,a5,a7e <vprintf+0x276>
 a32:	fe442783          	lw	a5,-28(s0)
 a36:	0007871b          	sext.w	a4,a5
 a3a:	06c00793          	li	a5,108
 a3e:	04f71063          	bne	a4,a5,a7e <vprintf+0x276>
 a42:	fe042783          	lw	a5,-32(s0)
 a46:	0007871b          	sext.w	a4,a5
 a4a:	07500793          	li	a5,117
 a4e:	02f71863          	bne	a4,a5,a7e <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a52:	fb843783          	ld	a5,-72(s0)
 a56:	00878713          	addi	a4,a5,8
 a5a:	fae43c23          	sd	a4,-72(s0)
 a5e:	639c                	ld	a5,0(a5)
 a60:	873e                	mv	a4,a5
 a62:	fcc42783          	lw	a5,-52(s0)
 a66:	4681                	li	a3,0
 a68:	4629                	li	a2,10
 a6a:	85ba                	mv	a1,a4
 a6c:	853e                	mv	a0,a5
 a6e:	c2bff0ef          	jal	698 <printint>
        i += 2;
 a72:	fdc42783          	lw	a5,-36(s0)
 a76:	2789                	addiw	a5,a5,2
 a78:	fcf42e23          	sw	a5,-36(s0)
 a7c:	aaf9                	j	c5a <vprintf+0x452>
      } else if(c0 == 'x'){
 a7e:	fd442783          	lw	a5,-44(s0)
 a82:	0007871b          	sext.w	a4,a5
 a86:	07800793          	li	a5,120
 a8a:	02f71563          	bne	a4,a5,ab4 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a8e:	fb843783          	ld	a5,-72(s0)
 a92:	00878713          	addi	a4,a5,8
 a96:	fae43c23          	sd	a4,-72(s0)
 a9a:	439c                	lw	a5,0(a5)
 a9c:	02079713          	slli	a4,a5,0x20
 aa0:	9301                	srli	a4,a4,0x20
 aa2:	fcc42783          	lw	a5,-52(s0)
 aa6:	4681                	li	a3,0
 aa8:	4641                	li	a2,16
 aaa:	85ba                	mv	a1,a4
 aac:	853e                	mv	a0,a5
 aae:	bebff0ef          	jal	698 <printint>
 ab2:	a265                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
 ab4:	fd442783          	lw	a5,-44(s0)
 ab8:	0007871b          	sext.w	a4,a5
 abc:	06c00793          	li	a5,108
 ac0:	04f71063          	bne	a4,a5,b00 <vprintf+0x2f8>
 ac4:	fe442783          	lw	a5,-28(s0)
 ac8:	0007871b          	sext.w	a4,a5
 acc:	07800793          	li	a5,120
 ad0:	02f71863          	bne	a4,a5,b00 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad4:	fb843783          	ld	a5,-72(s0)
 ad8:	00878713          	addi	a4,a5,8
 adc:	fae43c23          	sd	a4,-72(s0)
 ae0:	639c                	ld	a5,0(a5)
 ae2:	873e                	mv	a4,a5
 ae4:	fcc42783          	lw	a5,-52(s0)
 ae8:	4681                	li	a3,0
 aea:	4641                	li	a2,16
 aec:	85ba                	mv	a1,a4
 aee:	853e                	mv	a0,a5
 af0:	ba9ff0ef          	jal	698 <printint>
        i += 1;
 af4:	fdc42783          	lw	a5,-36(s0)
 af8:	2785                	addiw	a5,a5,1
 afa:	fcf42e23          	sw	a5,-36(s0)
 afe:	aab1                	j	c5a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 b00:	fd442783          	lw	a5,-44(s0)
 b04:	0007871b          	sext.w	a4,a5
 b08:	06c00793          	li	a5,108
 b0c:	04f71863          	bne	a4,a5,b5c <vprintf+0x354>
 b10:	fe442783          	lw	a5,-28(s0)
 b14:	0007871b          	sext.w	a4,a5
 b18:	06c00793          	li	a5,108
 b1c:	04f71063          	bne	a4,a5,b5c <vprintf+0x354>
 b20:	fe042783          	lw	a5,-32(s0)
 b24:	0007871b          	sext.w	a4,a5
 b28:	07800793          	li	a5,120
 b2c:	02f71863          	bne	a4,a5,b5c <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b30:	fb843783          	ld	a5,-72(s0)
 b34:	00878713          	addi	a4,a5,8
 b38:	fae43c23          	sd	a4,-72(s0)
 b3c:	639c                	ld	a5,0(a5)
 b3e:	873e                	mv	a4,a5
 b40:	fcc42783          	lw	a5,-52(s0)
 b44:	4681                	li	a3,0
 b46:	4641                	li	a2,16
 b48:	85ba                	mv	a1,a4
 b4a:	853e                	mv	a0,a5
 b4c:	b4dff0ef          	jal	698 <printint>
        i += 2;
 b50:	fdc42783          	lw	a5,-36(s0)
 b54:	2789                	addiw	a5,a5,2
 b56:	fcf42e23          	sw	a5,-36(s0)
 b5a:	a201                	j	c5a <vprintf+0x452>
      } else if(c0 == 'p'){
 b5c:	fd442783          	lw	a5,-44(s0)
 b60:	0007871b          	sext.w	a4,a5
 b64:	07000793          	li	a5,112
 b68:	02f71063          	bne	a4,a5,b88 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
 b6c:	fb843783          	ld	a5,-72(s0)
 b70:	00878713          	addi	a4,a5,8
 b74:	fae43c23          	sd	a4,-72(s0)
 b78:	6398                	ld	a4,0(a5)
 b7a:	fcc42783          	lw	a5,-52(s0)
 b7e:	85ba                	mv	a1,a4
 b80:	853e                	mv	a0,a5
 b82:	c09ff0ef          	jal	78a <printptr>
 b86:	a8d1                	j	c5a <vprintf+0x452>
      } else if(c0 == 'c'){
 b88:	fd442783          	lw	a5,-44(s0)
 b8c:	0007871b          	sext.w	a4,a5
 b90:	06300793          	li	a5,99
 b94:	02f71263          	bne	a4,a5,bb8 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
 b98:	fb843783          	ld	a5,-72(s0)
 b9c:	00878713          	addi	a4,a5,8
 ba0:	fae43c23          	sd	a4,-72(s0)
 ba4:	439c                	lw	a5,0(a5)
 ba6:	0ff7f713          	zext.b	a4,a5
 baa:	fcc42783          	lw	a5,-52(s0)
 bae:	85ba                	mv	a1,a4
 bb0:	853e                	mv	a0,a5
 bb2:	ab5ff0ef          	jal	666 <putc>
 bb6:	a055                	j	c5a <vprintf+0x452>
      } else if(c0 == 's'){
 bb8:	fd442783          	lw	a5,-44(s0)
 bbc:	0007871b          	sext.w	a4,a5
 bc0:	07300793          	li	a5,115
 bc4:	04f71a63          	bne	a4,a5,c18 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
 bc8:	fb843783          	ld	a5,-72(s0)
 bcc:	00878713          	addi	a4,a5,8
 bd0:	fae43c23          	sd	a4,-72(s0)
 bd4:	639c                	ld	a5,0(a5)
 bd6:	fef43423          	sd	a5,-24(s0)
 bda:	fe843783          	ld	a5,-24(s0)
 bde:	e79d                	bnez	a5,c0c <vprintf+0x404>
          s = "(null)";
 be0:	00000797          	auipc	a5,0x0
 be4:	49878793          	addi	a5,a5,1176 # 1078 <malloc+0x1b6>
 be8:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
 bec:	a005                	j	c0c <vprintf+0x404>
          putc(fd, *s);
 bee:	fe843783          	ld	a5,-24(s0)
 bf2:	0007c703          	lbu	a4,0(a5)
 bf6:	fcc42783          	lw	a5,-52(s0)
 bfa:	85ba                	mv	a1,a4
 bfc:	853e                	mv	a0,a5
 bfe:	a69ff0ef          	jal	666 <putc>
        for(; *s; s++)
 c02:	fe843783          	ld	a5,-24(s0)
 c06:	0785                	addi	a5,a5,1
 c08:	fef43423          	sd	a5,-24(s0)
 c0c:	fe843783          	ld	a5,-24(s0)
 c10:	0007c783          	lbu	a5,0(a5)
 c14:	ffe9                	bnez	a5,bee <vprintf+0x3e6>
 c16:	a091                	j	c5a <vprintf+0x452>
      } else if(c0 == '%'){
 c18:	fd442783          	lw	a5,-44(s0)
 c1c:	0007871b          	sext.w	a4,a5
 c20:	02500793          	li	a5,37
 c24:	00f71a63          	bne	a4,a5,c38 <vprintf+0x430>
        putc(fd, '%');
 c28:	fcc42783          	lw	a5,-52(s0)
 c2c:	02500593          	li	a1,37
 c30:	853e                	mv	a0,a5
 c32:	a35ff0ef          	jal	666 <putc>
 c36:	a015                	j	c5a <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c38:	fcc42783          	lw	a5,-52(s0)
 c3c:	02500593          	li	a1,37
 c40:	853e                	mv	a0,a5
 c42:	a25ff0ef          	jal	666 <putc>
        putc(fd, c0);
 c46:	fd442783          	lw	a5,-44(s0)
 c4a:	0ff7f713          	zext.b	a4,a5
 c4e:	fcc42783          	lw	a5,-52(s0)
 c52:	85ba                	mv	a1,a4
 c54:	853e                	mv	a0,a5
 c56:	a11ff0ef          	jal	666 <putc>
      }

      state = 0;
 c5a:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
 c5e:	fdc42783          	lw	a5,-36(s0)
 c62:	2785                	addiw	a5,a5,1
 c64:	fcf42e23          	sw	a5,-36(s0)
 c68:	fdc42783          	lw	a5,-36(s0)
 c6c:	fc043703          	ld	a4,-64(s0)
 c70:	97ba                	add	a5,a5,a4
 c72:	0007c783          	lbu	a5,0(a5)
 c76:	ba0799e3          	bnez	a5,828 <vprintf+0x20>
    }
  }
}
 c7a:	0001                	nop
 c7c:	0001                	nop
 c7e:	60a6                	ld	ra,72(sp)
 c80:	6406                	ld	s0,64(sp)
 c82:	6161                	addi	sp,sp,80
 c84:	8082                	ret

0000000000000c86 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c86:	7159                	addi	sp,sp,-112
 c88:	fc06                	sd	ra,56(sp)
 c8a:	f822                	sd	s0,48(sp)
 c8c:	0080                	addi	s0,sp,64
 c8e:	fcb43823          	sd	a1,-48(s0)
 c92:	e010                	sd	a2,0(s0)
 c94:	e414                	sd	a3,8(s0)
 c96:	e818                	sd	a4,16(s0)
 c98:	ec1c                	sd	a5,24(s0)
 c9a:	03043023          	sd	a6,32(s0)
 c9e:	03143423          	sd	a7,40(s0)
 ca2:	87aa                	mv	a5,a0
 ca4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ca8:	03040793          	addi	a5,s0,48
 cac:	fcf43423          	sd	a5,-56(s0)
 cb0:	fc843783          	ld	a5,-56(s0)
 cb4:	fd078793          	addi	a5,a5,-48
 cb8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 cbc:	fe843703          	ld	a4,-24(s0)
 cc0:	fdc42783          	lw	a5,-36(s0)
 cc4:	863a                	mv	a2,a4
 cc6:	fd043583          	ld	a1,-48(s0)
 cca:	853e                	mv	a0,a5
 ccc:	b3dff0ef          	jal	808 <vprintf>
}
 cd0:	0001                	nop
 cd2:	70e2                	ld	ra,56(sp)
 cd4:	7442                	ld	s0,48(sp)
 cd6:	6165                	addi	sp,sp,112
 cd8:	8082                	ret

0000000000000cda <printf>:

void
printf(const char *fmt, ...)
{
 cda:	7159                	addi	sp,sp,-112
 cdc:	f406                	sd	ra,40(sp)
 cde:	f022                	sd	s0,32(sp)
 ce0:	1800                	addi	s0,sp,48
 ce2:	fca43c23          	sd	a0,-40(s0)
 ce6:	e40c                	sd	a1,8(s0)
 ce8:	e810                	sd	a2,16(s0)
 cea:	ec14                	sd	a3,24(s0)
 cec:	f018                	sd	a4,32(s0)
 cee:	f41c                	sd	a5,40(s0)
 cf0:	03043823          	sd	a6,48(s0)
 cf4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cf8:	04040793          	addi	a5,s0,64
 cfc:	fcf43823          	sd	a5,-48(s0)
 d00:	fd043783          	ld	a5,-48(s0)
 d04:	fc878793          	addi	a5,a5,-56
 d08:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 d0c:	fe843783          	ld	a5,-24(s0)
 d10:	863e                	mv	a2,a5
 d12:	fd843583          	ld	a1,-40(s0)
 d16:	4505                	li	a0,1
 d18:	af1ff0ef          	jal	808 <vprintf>
}
 d1c:	0001                	nop
 d1e:	70a2                	ld	ra,40(sp)
 d20:	7402                	ld	s0,32(sp)
 d22:	6165                	addi	sp,sp,112
 d24:	8082                	ret

0000000000000d26 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d26:	7179                	addi	sp,sp,-48
 d28:	f406                	sd	ra,40(sp)
 d2a:	f022                	sd	s0,32(sp)
 d2c:	1800                	addi	s0,sp,48
 d2e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d32:	fd843783          	ld	a5,-40(s0)
 d36:	17c1                	addi	a5,a5,-16
 d38:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d3c:	00001797          	auipc	a5,0x1
 d40:	4ec78793          	addi	a5,a5,1260 # 2228 <freep>
 d44:	639c                	ld	a5,0(a5)
 d46:	fef43423          	sd	a5,-24(s0)
 d4a:	a815                	j	d7e <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d4c:	fe843783          	ld	a5,-24(s0)
 d50:	639c                	ld	a5,0(a5)
 d52:	fe843703          	ld	a4,-24(s0)
 d56:	00f76f63          	bltu	a4,a5,d74 <free+0x4e>
 d5a:	fe043703          	ld	a4,-32(s0)
 d5e:	fe843783          	ld	a5,-24(s0)
 d62:	02e7eb63          	bltu	a5,a4,d98 <free+0x72>
 d66:	fe843783          	ld	a5,-24(s0)
 d6a:	639c                	ld	a5,0(a5)
 d6c:	fe043703          	ld	a4,-32(s0)
 d70:	02f76463          	bltu	a4,a5,d98 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d74:	fe843783          	ld	a5,-24(s0)
 d78:	639c                	ld	a5,0(a5)
 d7a:	fef43423          	sd	a5,-24(s0)
 d7e:	fe043703          	ld	a4,-32(s0)
 d82:	fe843783          	ld	a5,-24(s0)
 d86:	fce7f3e3          	bgeu	a5,a4,d4c <free+0x26>
 d8a:	fe843783          	ld	a5,-24(s0)
 d8e:	639c                	ld	a5,0(a5)
 d90:	fe043703          	ld	a4,-32(s0)
 d94:	faf77ce3          	bgeu	a4,a5,d4c <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d98:	fe043783          	ld	a5,-32(s0)
 d9c:	479c                	lw	a5,8(a5)
 d9e:	1782                	slli	a5,a5,0x20
 da0:	9381                	srli	a5,a5,0x20
 da2:	0792                	slli	a5,a5,0x4
 da4:	fe043703          	ld	a4,-32(s0)
 da8:	973e                	add	a4,a4,a5
 daa:	fe843783          	ld	a5,-24(s0)
 dae:	639c                	ld	a5,0(a5)
 db0:	02f71763          	bne	a4,a5,dde <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
 db4:	fe043783          	ld	a5,-32(s0)
 db8:	4798                	lw	a4,8(a5)
 dba:	fe843783          	ld	a5,-24(s0)
 dbe:	639c                	ld	a5,0(a5)
 dc0:	479c                	lw	a5,8(a5)
 dc2:	9fb9                	addw	a5,a5,a4
 dc4:	0007871b          	sext.w	a4,a5
 dc8:	fe043783          	ld	a5,-32(s0)
 dcc:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 dce:	fe843783          	ld	a5,-24(s0)
 dd2:	639c                	ld	a5,0(a5)
 dd4:	6398                	ld	a4,0(a5)
 dd6:	fe043783          	ld	a5,-32(s0)
 dda:	e398                	sd	a4,0(a5)
 ddc:	a039                	j	dea <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
 dde:	fe843783          	ld	a5,-24(s0)
 de2:	6398                	ld	a4,0(a5)
 de4:	fe043783          	ld	a5,-32(s0)
 de8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 dea:	fe843783          	ld	a5,-24(s0)
 dee:	479c                	lw	a5,8(a5)
 df0:	1782                	slli	a5,a5,0x20
 df2:	9381                	srli	a5,a5,0x20
 df4:	0792                	slli	a5,a5,0x4
 df6:	fe843703          	ld	a4,-24(s0)
 dfa:	97ba                	add	a5,a5,a4
 dfc:	fe043703          	ld	a4,-32(s0)
 e00:	02f71563          	bne	a4,a5,e2a <free+0x104>
    p->s.size += bp->s.size;
 e04:	fe843783          	ld	a5,-24(s0)
 e08:	4798                	lw	a4,8(a5)
 e0a:	fe043783          	ld	a5,-32(s0)
 e0e:	479c                	lw	a5,8(a5)
 e10:	9fb9                	addw	a5,a5,a4
 e12:	0007871b          	sext.w	a4,a5
 e16:	fe843783          	ld	a5,-24(s0)
 e1a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 e1c:	fe043783          	ld	a5,-32(s0)
 e20:	6398                	ld	a4,0(a5)
 e22:	fe843783          	ld	a5,-24(s0)
 e26:	e398                	sd	a4,0(a5)
 e28:	a031                	j	e34 <free+0x10e>
  } else
    p->s.ptr = bp;
 e2a:	fe843783          	ld	a5,-24(s0)
 e2e:	fe043703          	ld	a4,-32(s0)
 e32:	e398                	sd	a4,0(a5)
  freep = p;
 e34:	00001797          	auipc	a5,0x1
 e38:	3f478793          	addi	a5,a5,1012 # 2228 <freep>
 e3c:	fe843703          	ld	a4,-24(s0)
 e40:	e398                	sd	a4,0(a5)
}
 e42:	0001                	nop
 e44:	70a2                	ld	ra,40(sp)
 e46:	7402                	ld	s0,32(sp)
 e48:	6145                	addi	sp,sp,48
 e4a:	8082                	ret

0000000000000e4c <morecore>:

static Header*
morecore(uint nu)
{
 e4c:	7179                	addi	sp,sp,-48
 e4e:	f406                	sd	ra,40(sp)
 e50:	f022                	sd	s0,32(sp)
 e52:	1800                	addi	s0,sp,48
 e54:	87aa                	mv	a5,a0
 e56:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 e5a:	fdc42783          	lw	a5,-36(s0)
 e5e:	0007871b          	sext.w	a4,a5
 e62:	6785                	lui	a5,0x1
 e64:	00f77563          	bgeu	a4,a5,e6e <morecore+0x22>
    nu = 4096;
 e68:	6785                	lui	a5,0x1
 e6a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 e6e:	fdc42783          	lw	a5,-36(s0)
 e72:	0047979b          	slliw	a5,a5,0x4
 e76:	2781                	sext.w	a5,a5
 e78:	853e                	mv	a0,a5
 e7a:	ef0ff0ef          	jal	56a <sbrk>
 e7e:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
 e82:	fe843703          	ld	a4,-24(s0)
 e86:	57fd                	li	a5,-1
 e88:	00f71463          	bne	a4,a5,e90 <morecore+0x44>
    return 0;
 e8c:	4781                	li	a5,0
 e8e:	a02d                	j	eb8 <morecore+0x6c>
  hp = (Header*)p;
 e90:	fe843783          	ld	a5,-24(s0)
 e94:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 e98:	fe043783          	ld	a5,-32(s0)
 e9c:	fdc42703          	lw	a4,-36(s0)
 ea0:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 ea2:	fe043783          	ld	a5,-32(s0)
 ea6:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x14e>
 ea8:	853e                	mv	a0,a5
 eaa:	e7dff0ef          	jal	d26 <free>
  return freep;
 eae:	00001797          	auipc	a5,0x1
 eb2:	37a78793          	addi	a5,a5,890 # 2228 <freep>
 eb6:	639c                	ld	a5,0(a5)
}
 eb8:	853e                	mv	a0,a5
 eba:	70a2                	ld	ra,40(sp)
 ebc:	7402                	ld	s0,32(sp)
 ebe:	6145                	addi	sp,sp,48
 ec0:	8082                	ret

0000000000000ec2 <malloc>:

void*
malloc(uint nbytes)
{
 ec2:	7139                	addi	sp,sp,-64
 ec4:	fc06                	sd	ra,56(sp)
 ec6:	f822                	sd	s0,48(sp)
 ec8:	0080                	addi	s0,sp,64
 eca:	87aa                	mv	a5,a0
 ecc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ed0:	fcc46783          	lwu	a5,-52(s0)
 ed4:	07bd                	addi	a5,a5,15
 ed6:	8391                	srli	a5,a5,0x4
 ed8:	2781                	sext.w	a5,a5
 eda:	2785                	addiw	a5,a5,1
 edc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 ee0:	00001797          	auipc	a5,0x1
 ee4:	34878793          	addi	a5,a5,840 # 2228 <freep>
 ee8:	639c                	ld	a5,0(a5)
 eea:	fef43023          	sd	a5,-32(s0)
 eee:	fe043783          	ld	a5,-32(s0)
 ef2:	ef95                	bnez	a5,f2e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 ef4:	00001797          	auipc	a5,0x1
 ef8:	32478793          	addi	a5,a5,804 # 2218 <base>
 efc:	fef43023          	sd	a5,-32(s0)
 f00:	00001797          	auipc	a5,0x1
 f04:	32878793          	addi	a5,a5,808 # 2228 <freep>
 f08:	fe043703          	ld	a4,-32(s0)
 f0c:	e398                	sd	a4,0(a5)
 f0e:	00001797          	auipc	a5,0x1
 f12:	31a78793          	addi	a5,a5,794 # 2228 <freep>
 f16:	6398                	ld	a4,0(a5)
 f18:	00001797          	auipc	a5,0x1
 f1c:	30078793          	addi	a5,a5,768 # 2218 <base>
 f20:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 f22:	00001797          	auipc	a5,0x1
 f26:	2f678793          	addi	a5,a5,758 # 2218 <base>
 f2a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f2e:	fe043783          	ld	a5,-32(s0)
 f32:	639c                	ld	a5,0(a5)
 f34:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 f38:	fe843783          	ld	a5,-24(s0)
 f3c:	479c                	lw	a5,8(a5)
 f3e:	fdc42703          	lw	a4,-36(s0)
 f42:	2701                	sext.w	a4,a4
 f44:	06e7e763          	bltu	a5,a4,fb2 <malloc+0xf0>
      if(p->s.size == nunits)
 f48:	fe843783          	ld	a5,-24(s0)
 f4c:	479c                	lw	a5,8(a5)
 f4e:	fdc42703          	lw	a4,-36(s0)
 f52:	2701                	sext.w	a4,a4
 f54:	00f71963          	bne	a4,a5,f66 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 f58:	fe843783          	ld	a5,-24(s0)
 f5c:	6398                	ld	a4,0(a5)
 f5e:	fe043783          	ld	a5,-32(s0)
 f62:	e398                	sd	a4,0(a5)
 f64:	a825                	j	f9c <malloc+0xda>
      else {
        p->s.size -= nunits;
 f66:	fe843783          	ld	a5,-24(s0)
 f6a:	479c                	lw	a5,8(a5)
 f6c:	fdc42703          	lw	a4,-36(s0)
 f70:	9f99                	subw	a5,a5,a4
 f72:	0007871b          	sext.w	a4,a5
 f76:	fe843783          	ld	a5,-24(s0)
 f7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f7c:	fe843783          	ld	a5,-24(s0)
 f80:	479c                	lw	a5,8(a5)
 f82:	1782                	slli	a5,a5,0x20
 f84:	9381                	srli	a5,a5,0x20
 f86:	0792                	slli	a5,a5,0x4
 f88:	fe843703          	ld	a4,-24(s0)
 f8c:	97ba                	add	a5,a5,a4
 f8e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 f92:	fe843783          	ld	a5,-24(s0)
 f96:	fdc42703          	lw	a4,-36(s0)
 f9a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 f9c:	00001797          	auipc	a5,0x1
 fa0:	28c78793          	addi	a5,a5,652 # 2228 <freep>
 fa4:	fe043703          	ld	a4,-32(s0)
 fa8:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 faa:	fe843783          	ld	a5,-24(s0)
 fae:	07c1                	addi	a5,a5,16
 fb0:	a081                	j	ff0 <malloc+0x12e>
    }
    if(p == freep)
 fb2:	00001797          	auipc	a5,0x1
 fb6:	27678793          	addi	a5,a5,630 # 2228 <freep>
 fba:	639c                	ld	a5,0(a5)
 fbc:	fe843703          	ld	a4,-24(s0)
 fc0:	00f71e63          	bne	a4,a5,fdc <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
 fc4:	fdc42783          	lw	a5,-36(s0)
 fc8:	853e                	mv	a0,a5
 fca:	e83ff0ef          	jal	e4c <morecore>
 fce:	fea43423          	sd	a0,-24(s0)
 fd2:	fe843783          	ld	a5,-24(s0)
 fd6:	e399                	bnez	a5,fdc <malloc+0x11a>
        return 0;
 fd8:	4781                	li	a5,0
 fda:	a819                	j	ff0 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fdc:	fe843783          	ld	a5,-24(s0)
 fe0:	fef43023          	sd	a5,-32(s0)
 fe4:	fe843783          	ld	a5,-24(s0)
 fe8:	639c                	ld	a5,0(a5)
 fea:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 fee:	b7a9                	j	f38 <malloc+0x76>
  }
}
 ff0:	853e                	mv	a0,a5
 ff2:	70e2                	ld	ra,56(sp)
 ff4:	7442                	ld	s0,48(sp)
 ff6:	6121                	addi	sp,sp,64
 ff8:	8082                	ret
