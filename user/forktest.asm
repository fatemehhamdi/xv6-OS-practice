
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	fea43423          	sd	a0,-24(s0)
  write(1, s, strlen(s));
   c:	fe843503          	ld	a0,-24(s0)
  10:	1e8000ef          	jal	1f8 <strlen>
  14:	87aa                	mv	a5,a0
  16:	863e                	mv	a2,a5
  18:	fe843583          	ld	a1,-24(s0)
  1c:	4505                	li	a0,1
  1e:	62a000ef          	jal	648 <write>
}
  22:	0001                	nop
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	6105                	addi	sp,sp,32
  2a:	8082                	ret

000000000000002c <forktest>:

void
forktest(void)
{
  2c:	1101                	addi	sp,sp,-32
  2e:	ec06                	sd	ra,24(sp)
  30:	e822                	sd	s0,16(sp)
  32:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  34:	6d800513          	li	a0,1752
  38:	fc9ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3c:	fe042623          	sw	zero,-20(s0)
  40:	a03d                	j	6e <forktest+0x42>
    pid = fork();
  42:	5de000ef          	jal	620 <fork>
  46:	87aa                	mv	a5,a0
  48:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
  4c:	fe842783          	lw	a5,-24(s0)
  50:	2781                	sext.w	a5,a5
  52:	0207c763          	bltz	a5,80 <forktest+0x54>
      break;
    if(pid == 0)
  56:	fe842783          	lw	a5,-24(s0)
  5a:	2781                	sext.w	a5,a5
  5c:	e781                	bnez	a5,64 <forktest+0x38>
      exit(0);
  5e:	4501                	li	a0,0
  60:	5c8000ef          	jal	628 <exit>
  for(n=0; n<N; n++){
  64:	fec42783          	lw	a5,-20(s0)
  68:	2785                	addiw	a5,a5,1
  6a:	fef42623          	sw	a5,-20(s0)
  6e:	fec42783          	lw	a5,-20(s0)
  72:	0007871b          	sext.w	a4,a5
  76:	3e700793          	li	a5,999
  7a:	fce7d4e3          	bge	a5,a4,42 <forktest+0x16>
  7e:	a011                	j	82 <forktest+0x56>
      break;
  80:	0001                	nop
  }

  if(n == N){
  82:	fec42783          	lw	a5,-20(s0)
  86:	0007871b          	sext.w	a4,a5
  8a:	3e800793          	li	a5,1000
  8e:	02f71b63          	bne	a4,a5,c4 <forktest+0x98>
    print("fork claimed to work N times!\n");
  92:	6e800513          	li	a0,1768
  96:	f6bff0ef          	jal	0 <print>
    exit(1);
  9a:	4505                	li	a0,1
  9c:	58c000ef          	jal	628 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
  a0:	4501                	li	a0,0
  a2:	58e000ef          	jal	630 <wait>
  a6:	87aa                	mv	a5,a0
  a8:	0007d963          	bgez	a5,ba <forktest+0x8e>
      print("wait stopped early\n");
  ac:	70800513          	li	a0,1800
  b0:	f51ff0ef          	jal	0 <print>
      exit(1);
  b4:	4505                	li	a0,1
  b6:	572000ef          	jal	628 <exit>
  for(; n > 0; n--){
  ba:	fec42783          	lw	a5,-20(s0)
  be:	37fd                	addiw	a5,a5,-1
  c0:	fef42623          	sw	a5,-20(s0)
  c4:	fec42783          	lw	a5,-20(s0)
  c8:	2781                	sext.w	a5,a5
  ca:	fcf04be3          	bgtz	a5,a0 <forktest+0x74>
    }
  }

  if(wait(0) != -1){
  ce:	4501                	li	a0,0
  d0:	560000ef          	jal	630 <wait>
  d4:	87aa                	mv	a5,a0
  d6:	873e                	mv	a4,a5
  d8:	57fd                	li	a5,-1
  da:	00f70963          	beq	a4,a5,ec <forktest+0xc0>
    print("wait got too many\n");
  de:	72000513          	li	a0,1824
  e2:	f1fff0ef          	jal	0 <print>
    exit(1);
  e6:	4505                	li	a0,1
  e8:	540000ef          	jal	628 <exit>
  }

  print("fork test OK\n");
  ec:	73800513          	li	a0,1848
  f0:	f11ff0ef          	jal	0 <print>
}
  f4:	0001                	nop
  f6:	60e2                	ld	ra,24(sp)
  f8:	6442                	ld	s0,16(sp)
  fa:	6105                	addi	sp,sp,32
  fc:	8082                	ret

00000000000000fe <main>:

int
main(void)
{
  fe:	1141                	addi	sp,sp,-16
 100:	e406                	sd	ra,8(sp)
 102:	e022                	sd	s0,0(sp)
 104:	0800                	addi	s0,sp,16
  forktest();
 106:	f27ff0ef          	jal	2c <forktest>
  exit(0);
 10a:	4501                	li	a0,0
 10c:	51c000ef          	jal	628 <exit>

0000000000000110 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 110:	7179                	addi	sp,sp,-48
 112:	f406                	sd	ra,40(sp)
 114:	f022                	sd	s0,32(sp)
 116:	1800                	addi	s0,sp,48
 118:	87aa                	mv	a5,a0
 11a:	fcb43823          	sd	a1,-48(s0)
 11e:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 122:	fdc42783          	lw	a5,-36(s0)
 126:	fd043583          	ld	a1,-48(s0)
 12a:	853e                	mv	a0,a5
 12c:	fd3ff0ef          	jal	fe <main>
 130:	87aa                	mv	a5,a0
 132:	fef42623          	sw	a5,-20(s0)
  exit(r);
 136:	fec42783          	lw	a5,-20(s0)
 13a:	853e                	mv	a0,a5
 13c:	4ec000ef          	jal	628 <exit>

0000000000000140 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 140:	7179                	addi	sp,sp,-48
 142:	f406                	sd	ra,40(sp)
 144:	f022                	sd	s0,32(sp)
 146:	1800                	addi	s0,sp,48
 148:	fca43c23          	sd	a0,-40(s0)
 14c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 150:	fd843783          	ld	a5,-40(s0)
 154:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 158:	0001                	nop
 15a:	fd043703          	ld	a4,-48(s0)
 15e:	00170793          	addi	a5,a4,1
 162:	fcf43823          	sd	a5,-48(s0)
 166:	fd843783          	ld	a5,-40(s0)
 16a:	00178693          	addi	a3,a5,1
 16e:	fcd43c23          	sd	a3,-40(s0)
 172:	00074703          	lbu	a4,0(a4)
 176:	00e78023          	sb	a4,0(a5)
 17a:	0007c783          	lbu	a5,0(a5)
 17e:	fff1                	bnez	a5,15a <strcpy+0x1a>
    ;
  return os;
 180:	fe843783          	ld	a5,-24(s0)
}
 184:	853e                	mv	a0,a5
 186:	70a2                	ld	ra,40(sp)
 188:	7402                	ld	s0,32(sp)
 18a:	6145                	addi	sp,sp,48
 18c:	8082                	ret

000000000000018e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18e:	1101                	addi	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	1000                	addi	s0,sp,32
 196:	fea43423          	sd	a0,-24(s0)
 19a:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 19e:	a819                	j	1b4 <strcmp+0x26>
    p++, q++;
 1a0:	fe843783          	ld	a5,-24(s0)
 1a4:	0785                	addi	a5,a5,1
 1a6:	fef43423          	sd	a5,-24(s0)
 1aa:	fe043783          	ld	a5,-32(s0)
 1ae:	0785                	addi	a5,a5,1
 1b0:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1b4:	fe843783          	ld	a5,-24(s0)
 1b8:	0007c783          	lbu	a5,0(a5)
 1bc:	cb99                	beqz	a5,1d2 <strcmp+0x44>
 1be:	fe843783          	ld	a5,-24(s0)
 1c2:	0007c703          	lbu	a4,0(a5)
 1c6:	fe043783          	ld	a5,-32(s0)
 1ca:	0007c783          	lbu	a5,0(a5)
 1ce:	fcf709e3          	beq	a4,a5,1a0 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 1d2:	fe843783          	ld	a5,-24(s0)
 1d6:	0007c783          	lbu	a5,0(a5)
 1da:	0007871b          	sext.w	a4,a5
 1de:	fe043783          	ld	a5,-32(s0)
 1e2:	0007c783          	lbu	a5,0(a5)
 1e6:	2781                	sext.w	a5,a5
 1e8:	40f707bb          	subw	a5,a4,a5
 1ec:	2781                	sext.w	a5,a5
}
 1ee:	853e                	mv	a0,a5
 1f0:	60e2                	ld	ra,24(sp)
 1f2:	6442                	ld	s0,16(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret

00000000000001f8 <strlen>:

uint
strlen(const char *s)
{
 1f8:	7179                	addi	sp,sp,-48
 1fa:	f406                	sd	ra,40(sp)
 1fc:	f022                	sd	s0,32(sp)
 1fe:	1800                	addi	s0,sp,48
 200:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 204:	fe042623          	sw	zero,-20(s0)
 208:	a031                	j	214 <strlen+0x1c>
 20a:	fec42783          	lw	a5,-20(s0)
 20e:	2785                	addiw	a5,a5,1
 210:	fef42623          	sw	a5,-20(s0)
 214:	fec42783          	lw	a5,-20(s0)
 218:	fd843703          	ld	a4,-40(s0)
 21c:	97ba                	add	a5,a5,a4
 21e:	0007c783          	lbu	a5,0(a5)
 222:	f7e5                	bnez	a5,20a <strlen+0x12>
    ;
  return n;
 224:	fec42783          	lw	a5,-20(s0)
}
 228:	853e                	mv	a0,a5
 22a:	70a2                	ld	ra,40(sp)
 22c:	7402                	ld	s0,32(sp)
 22e:	6145                	addi	sp,sp,48
 230:	8082                	ret

0000000000000232 <memset>:

void*
memset(void *dst, int c, uint n)
{
 232:	7179                	addi	sp,sp,-48
 234:	f406                	sd	ra,40(sp)
 236:	f022                	sd	s0,32(sp)
 238:	1800                	addi	s0,sp,48
 23a:	fca43c23          	sd	a0,-40(s0)
 23e:	87ae                	mv	a5,a1
 240:	8732                	mv	a4,a2
 242:	fcf42a23          	sw	a5,-44(s0)
 246:	87ba                	mv	a5,a4
 248:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 24c:	fd843783          	ld	a5,-40(s0)
 250:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 254:	fe042623          	sw	zero,-20(s0)
 258:	a00d                	j	27a <memset+0x48>
    cdst[i] = c;
 25a:	fec42783          	lw	a5,-20(s0)
 25e:	fe043703          	ld	a4,-32(s0)
 262:	97ba                	add	a5,a5,a4
 264:	fd442703          	lw	a4,-44(s0)
 268:	0ff77713          	zext.b	a4,a4
 26c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 270:	fec42783          	lw	a5,-20(s0)
 274:	2785                	addiw	a5,a5,1
 276:	fef42623          	sw	a5,-20(s0)
 27a:	fec42783          	lw	a5,-20(s0)
 27e:	fd042703          	lw	a4,-48(s0)
 282:	2701                	sext.w	a4,a4
 284:	fce7ebe3          	bltu	a5,a4,25a <memset+0x28>
  }
  return dst;
 288:	fd843783          	ld	a5,-40(s0)
}
 28c:	853e                	mv	a0,a5
 28e:	70a2                	ld	ra,40(sp)
 290:	7402                	ld	s0,32(sp)
 292:	6145                	addi	sp,sp,48
 294:	8082                	ret

0000000000000296 <strchr>:

char*
strchr(const char *s, char c)
{
 296:	1101                	addi	sp,sp,-32
 298:	ec06                	sd	ra,24(sp)
 29a:	e822                	sd	s0,16(sp)
 29c:	1000                	addi	s0,sp,32
 29e:	fea43423          	sd	a0,-24(s0)
 2a2:	87ae                	mv	a5,a1
 2a4:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2a8:	a01d                	j	2ce <strchr+0x38>
    if(*s == c)
 2aa:	fe843783          	ld	a5,-24(s0)
 2ae:	0007c703          	lbu	a4,0(a5)
 2b2:	fe744783          	lbu	a5,-25(s0)
 2b6:	0ff7f793          	zext.b	a5,a5
 2ba:	00e79563          	bne	a5,a4,2c4 <strchr+0x2e>
      return (char*)s;
 2be:	fe843783          	ld	a5,-24(s0)
 2c2:	a821                	j	2da <strchr+0x44>
  for(; *s; s++)
 2c4:	fe843783          	ld	a5,-24(s0)
 2c8:	0785                	addi	a5,a5,1
 2ca:	fef43423          	sd	a5,-24(s0)
 2ce:	fe843783          	ld	a5,-24(s0)
 2d2:	0007c783          	lbu	a5,0(a5)
 2d6:	fbf1                	bnez	a5,2aa <strchr+0x14>
  return 0;
 2d8:	4781                	li	a5,0
}
 2da:	853e                	mv	a0,a5
 2dc:	60e2                	ld	ra,24(sp)
 2de:	6442                	ld	s0,16(sp)
 2e0:	6105                	addi	sp,sp,32
 2e2:	8082                	ret

00000000000002e4 <gets>:

char*
gets(char *buf, int max)
{
 2e4:	7179                	addi	sp,sp,-48
 2e6:	f406                	sd	ra,40(sp)
 2e8:	f022                	sd	s0,32(sp)
 2ea:	1800                	addi	s0,sp,48
 2ec:	fca43c23          	sd	a0,-40(s0)
 2f0:	87ae                	mv	a5,a1
 2f2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	fe042623          	sw	zero,-20(s0)
 2fa:	a891                	j	34e <gets+0x6a>
    cc = read(0, &c, 1);
 2fc:	fe740793          	addi	a5,s0,-25
 300:	4605                	li	a2,1
 302:	85be                	mv	a1,a5
 304:	4501                	li	a0,0
 306:	33a000ef          	jal	640 <read>
 30a:	87aa                	mv	a5,a0
 30c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 310:	fe842783          	lw	a5,-24(s0)
 314:	2781                	sext.w	a5,a5
 316:	04f05663          	blez	a5,362 <gets+0x7e>
      break;
    buf[i++] = c;
 31a:	fec42783          	lw	a5,-20(s0)
 31e:	0017871b          	addiw	a4,a5,1
 322:	fee42623          	sw	a4,-20(s0)
 326:	873e                	mv	a4,a5
 328:	fd843783          	ld	a5,-40(s0)
 32c:	97ba                	add	a5,a5,a4
 32e:	fe744703          	lbu	a4,-25(s0)
 332:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 336:	fe744783          	lbu	a5,-25(s0)
 33a:	873e                	mv	a4,a5
 33c:	47a9                	li	a5,10
 33e:	02f70363          	beq	a4,a5,364 <gets+0x80>
 342:	fe744783          	lbu	a5,-25(s0)
 346:	873e                	mv	a4,a5
 348:	47b5                	li	a5,13
 34a:	00f70d63          	beq	a4,a5,364 <gets+0x80>
  for(i=0; i+1 < max; ){
 34e:	fec42783          	lw	a5,-20(s0)
 352:	2785                	addiw	a5,a5,1
 354:	2781                	sext.w	a5,a5
 356:	fd442703          	lw	a4,-44(s0)
 35a:	2701                	sext.w	a4,a4
 35c:	fae7c0e3          	blt	a5,a4,2fc <gets+0x18>
 360:	a011                	j	364 <gets+0x80>
      break;
 362:	0001                	nop
      break;
  }
  buf[i] = '\0';
 364:	fec42783          	lw	a5,-20(s0)
 368:	fd843703          	ld	a4,-40(s0)
 36c:	97ba                	add	a5,a5,a4
 36e:	00078023          	sb	zero,0(a5)
  return buf;
 372:	fd843783          	ld	a5,-40(s0)
}
 376:	853e                	mv	a0,a5
 378:	70a2                	ld	ra,40(sp)
 37a:	7402                	ld	s0,32(sp)
 37c:	6145                	addi	sp,sp,48
 37e:	8082                	ret

0000000000000380 <stat>:

int
stat(const char *n, struct stat *st)
{
 380:	7179                	addi	sp,sp,-48
 382:	f406                	sd	ra,40(sp)
 384:	f022                	sd	s0,32(sp)
 386:	1800                	addi	s0,sp,48
 388:	fca43c23          	sd	a0,-40(s0)
 38c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 390:	4581                	li	a1,0
 392:	fd843503          	ld	a0,-40(s0)
 396:	2d2000ef          	jal	668 <open>
 39a:	87aa                	mv	a5,a0
 39c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3a0:	fec42783          	lw	a5,-20(s0)
 3a4:	2781                	sext.w	a5,a5
 3a6:	0007d463          	bgez	a5,3ae <stat+0x2e>
    return -1;
 3aa:	57fd                	li	a5,-1
 3ac:	a015                	j	3d0 <stat+0x50>
  r = fstat(fd, st);
 3ae:	fec42783          	lw	a5,-20(s0)
 3b2:	fd043583          	ld	a1,-48(s0)
 3b6:	853e                	mv	a0,a5
 3b8:	2c8000ef          	jal	680 <fstat>
 3bc:	87aa                	mv	a5,a0
 3be:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3c2:	fec42783          	lw	a5,-20(s0)
 3c6:	853e                	mv	a0,a5
 3c8:	288000ef          	jal	650 <close>
  return r;
 3cc:	fe842783          	lw	a5,-24(s0)
}
 3d0:	853e                	mv	a0,a5
 3d2:	70a2                	ld	ra,40(sp)
 3d4:	7402                	ld	s0,32(sp)
 3d6:	6145                	addi	sp,sp,48
 3d8:	8082                	ret

00000000000003da <atoi>:

int
atoi(const char *s)
{
 3da:	7179                	addi	sp,sp,-48
 3dc:	f406                	sd	ra,40(sp)
 3de:	f022                	sd	s0,32(sp)
 3e0:	1800                	addi	s0,sp,48
 3e2:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3e6:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3ea:	a81d                	j	420 <atoi+0x46>
    n = n*10 + *s++ - '0';
 3ec:	fec42783          	lw	a5,-20(s0)
 3f0:	873e                	mv	a4,a5
 3f2:	87ba                	mv	a5,a4
 3f4:	0027979b          	slliw	a5,a5,0x2
 3f8:	9fb9                	addw	a5,a5,a4
 3fa:	0017979b          	slliw	a5,a5,0x1
 3fe:	0007871b          	sext.w	a4,a5
 402:	fd843783          	ld	a5,-40(s0)
 406:	00178693          	addi	a3,a5,1
 40a:	fcd43c23          	sd	a3,-40(s0)
 40e:	0007c783          	lbu	a5,0(a5)
 412:	2781                	sext.w	a5,a5
 414:	9fb9                	addw	a5,a5,a4
 416:	2781                	sext.w	a5,a5
 418:	fd07879b          	addiw	a5,a5,-48
 41c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 420:	fd843783          	ld	a5,-40(s0)
 424:	0007c783          	lbu	a5,0(a5)
 428:	873e                	mv	a4,a5
 42a:	02f00793          	li	a5,47
 42e:	00e7fb63          	bgeu	a5,a4,444 <atoi+0x6a>
 432:	fd843783          	ld	a5,-40(s0)
 436:	0007c783          	lbu	a5,0(a5)
 43a:	873e                	mv	a4,a5
 43c:	03900793          	li	a5,57
 440:	fae7f6e3          	bgeu	a5,a4,3ec <atoi+0x12>
  return n;
 444:	fec42783          	lw	a5,-20(s0)
}
 448:	853e                	mv	a0,a5
 44a:	70a2                	ld	ra,40(sp)
 44c:	7402                	ld	s0,32(sp)
 44e:	6145                	addi	sp,sp,48
 450:	8082                	ret

0000000000000452 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 452:	7139                	addi	sp,sp,-64
 454:	fc06                	sd	ra,56(sp)
 456:	f822                	sd	s0,48(sp)
 458:	0080                	addi	s0,sp,64
 45a:	fca43c23          	sd	a0,-40(s0)
 45e:	fcb43823          	sd	a1,-48(s0)
 462:	87b2                	mv	a5,a2
 464:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 468:	fd843783          	ld	a5,-40(s0)
 46c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 470:	fd043783          	ld	a5,-48(s0)
 474:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 478:	fe043703          	ld	a4,-32(s0)
 47c:	fe843783          	ld	a5,-24(s0)
 480:	02e7fc63          	bgeu	a5,a4,4b8 <memmove+0x66>
    while(n-- > 0)
 484:	a00d                	j	4a6 <memmove+0x54>
      *dst++ = *src++;
 486:	fe043703          	ld	a4,-32(s0)
 48a:	00170793          	addi	a5,a4,1
 48e:	fef43023          	sd	a5,-32(s0)
 492:	fe843783          	ld	a5,-24(s0)
 496:	00178693          	addi	a3,a5,1
 49a:	fed43423          	sd	a3,-24(s0)
 49e:	00074703          	lbu	a4,0(a4)
 4a2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4a6:	fcc42783          	lw	a5,-52(s0)
 4aa:	fff7871b          	addiw	a4,a5,-1
 4ae:	fce42623          	sw	a4,-52(s0)
 4b2:	fcf04ae3          	bgtz	a5,486 <memmove+0x34>
 4b6:	a891                	j	50a <memmove+0xb8>
  } else {
    dst += n;
 4b8:	fcc42783          	lw	a5,-52(s0)
 4bc:	fe843703          	ld	a4,-24(s0)
 4c0:	97ba                	add	a5,a5,a4
 4c2:	fef43423          	sd	a5,-24(s0)
    src += n;
 4c6:	fcc42783          	lw	a5,-52(s0)
 4ca:	fe043703          	ld	a4,-32(s0)
 4ce:	97ba                	add	a5,a5,a4
 4d0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4d4:	a01d                	j	4fa <memmove+0xa8>
      *--dst = *--src;
 4d6:	fe043783          	ld	a5,-32(s0)
 4da:	17fd                	addi	a5,a5,-1
 4dc:	fef43023          	sd	a5,-32(s0)
 4e0:	fe843783          	ld	a5,-24(s0)
 4e4:	17fd                	addi	a5,a5,-1
 4e6:	fef43423          	sd	a5,-24(s0)
 4ea:	fe043783          	ld	a5,-32(s0)
 4ee:	0007c703          	lbu	a4,0(a5)
 4f2:	fe843783          	ld	a5,-24(s0)
 4f6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4fa:	fcc42783          	lw	a5,-52(s0)
 4fe:	fff7871b          	addiw	a4,a5,-1
 502:	fce42623          	sw	a4,-52(s0)
 506:	fcf048e3          	bgtz	a5,4d6 <memmove+0x84>
  }
  return vdst;
 50a:	fd843783          	ld	a5,-40(s0)
}
 50e:	853e                	mv	a0,a5
 510:	70e2                	ld	ra,56(sp)
 512:	7442                	ld	s0,48(sp)
 514:	6121                	addi	sp,sp,64
 516:	8082                	ret

0000000000000518 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 518:	7139                	addi	sp,sp,-64
 51a:	fc06                	sd	ra,56(sp)
 51c:	f822                	sd	s0,48(sp)
 51e:	0080                	addi	s0,sp,64
 520:	fca43c23          	sd	a0,-40(s0)
 524:	fcb43823          	sd	a1,-48(s0)
 528:	87b2                	mv	a5,a2
 52a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 52e:	fd843783          	ld	a5,-40(s0)
 532:	fef43423          	sd	a5,-24(s0)
 536:	fd043783          	ld	a5,-48(s0)
 53a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 53e:	a0a1                	j	586 <memcmp+0x6e>
    if (*p1 != *p2) {
 540:	fe843783          	ld	a5,-24(s0)
 544:	0007c703          	lbu	a4,0(a5)
 548:	fe043783          	ld	a5,-32(s0)
 54c:	0007c783          	lbu	a5,0(a5)
 550:	02f70163          	beq	a4,a5,572 <memcmp+0x5a>
      return *p1 - *p2;
 554:	fe843783          	ld	a5,-24(s0)
 558:	0007c783          	lbu	a5,0(a5)
 55c:	0007871b          	sext.w	a4,a5
 560:	fe043783          	ld	a5,-32(s0)
 564:	0007c783          	lbu	a5,0(a5)
 568:	2781                	sext.w	a5,a5
 56a:	40f707bb          	subw	a5,a4,a5
 56e:	2781                	sext.w	a5,a5
 570:	a01d                	j	596 <memcmp+0x7e>
    }
    p1++;
 572:	fe843783          	ld	a5,-24(s0)
 576:	0785                	addi	a5,a5,1
 578:	fef43423          	sd	a5,-24(s0)
    p2++;
 57c:	fe043783          	ld	a5,-32(s0)
 580:	0785                	addi	a5,a5,1
 582:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 586:	fcc42783          	lw	a5,-52(s0)
 58a:	fff7871b          	addiw	a4,a5,-1
 58e:	fce42623          	sw	a4,-52(s0)
 592:	f7dd                	bnez	a5,540 <memcmp+0x28>
  }
  return 0;
 594:	4781                	li	a5,0
}
 596:	853e                	mv	a0,a5
 598:	70e2                	ld	ra,56(sp)
 59a:	7442                	ld	s0,48(sp)
 59c:	6121                	addi	sp,sp,64
 59e:	8082                	ret

00000000000005a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5a0:	7179                	addi	sp,sp,-48
 5a2:	f406                	sd	ra,40(sp)
 5a4:	f022                	sd	s0,32(sp)
 5a6:	1800                	addi	s0,sp,48
 5a8:	fea43423          	sd	a0,-24(s0)
 5ac:	feb43023          	sd	a1,-32(s0)
 5b0:	87b2                	mv	a5,a2
 5b2:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5b6:	fdc42783          	lw	a5,-36(s0)
 5ba:	863e                	mv	a2,a5
 5bc:	fe043583          	ld	a1,-32(s0)
 5c0:	fe843503          	ld	a0,-24(s0)
 5c4:	e8fff0ef          	jal	452 <memmove>
 5c8:	87aa                	mv	a5,a0
}
 5ca:	853e                	mv	a0,a5
 5cc:	70a2                	ld	ra,40(sp)
 5ce:	7402                	ld	s0,32(sp)
 5d0:	6145                	addi	sp,sp,48
 5d2:	8082                	ret

00000000000005d4 <sbrk>:

char *
sbrk(int n) {
 5d4:	1101                	addi	sp,sp,-32
 5d6:	ec06                	sd	ra,24(sp)
 5d8:	e822                	sd	s0,16(sp)
 5da:	1000                	addi	s0,sp,32
 5dc:	87aa                	mv	a5,a0
 5de:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
 5e2:	fec42783          	lw	a5,-20(s0)
 5e6:	4585                	li	a1,1
 5e8:	853e                	mv	a0,a5
 5ea:	0c6000ef          	jal	6b0 <sys_sbrk>
 5ee:	87aa                	mv	a5,a0
}
 5f0:	853e                	mv	a0,a5
 5f2:	60e2                	ld	ra,24(sp)
 5f4:	6442                	ld	s0,16(sp)
 5f6:	6105                	addi	sp,sp,32
 5f8:	8082                	ret

00000000000005fa <sbrklazy>:

char *
sbrklazy(int n) {
 5fa:	1101                	addi	sp,sp,-32
 5fc:	ec06                	sd	ra,24(sp)
 5fe:	e822                	sd	s0,16(sp)
 600:	1000                	addi	s0,sp,32
 602:	87aa                	mv	a5,a0
 604:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
 608:	fec42783          	lw	a5,-20(s0)
 60c:	4589                	li	a1,2
 60e:	853e                	mv	a0,a5
 610:	0a0000ef          	jal	6b0 <sys_sbrk>
 614:	87aa                	mv	a5,a0
}
 616:	853e                	mv	a0,a5
 618:	60e2                	ld	ra,24(sp)
 61a:	6442                	ld	s0,16(sp)
 61c:	6105                	addi	sp,sp,32
 61e:	8082                	ret

0000000000000620 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 620:	4885                	li	a7,1
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <exit>:
.global exit
exit:
 li a7, SYS_exit
 628:	4889                	li	a7,2
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <wait>:
.global wait
wait:
 li a7, SYS_wait
 630:	488d                	li	a7,3
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 638:	4891                	li	a7,4
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <read>:
.global read
read:
 li a7, SYS_read
 640:	4895                	li	a7,5
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <write>:
.global write
write:
 li a7, SYS_write
 648:	48c1                	li	a7,16
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <close>:
.global close
close:
 li a7, SYS_close
 650:	48d5                	li	a7,21
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <kill>:
.global kill
kill:
 li a7, SYS_kill
 658:	4899                	li	a7,6
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <exec>:
.global exec
exec:
 li a7, SYS_exec
 660:	489d                	li	a7,7
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <open>:
.global open
open:
 li a7, SYS_open
 668:	48bd                	li	a7,15
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 670:	48c5                	li	a7,17
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 678:	48c9                	li	a7,18
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 680:	48a1                	li	a7,8
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <link>:
.global link
link:
 li a7, SYS_link
 688:	48cd                	li	a7,19
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 690:	48d1                	li	a7,20
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 698:	48a5                	li	a7,9
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6a0:	48a9                	li	a7,10
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6a8:	48ad                	li	a7,11
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6b0:	48b1                	li	a7,12
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 6b8:	48b5                	li	a7,13
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6c0:	48b9                	li	a7,14
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <top>:
.global top
top:
 li a7, SYS_top
 6c8:	48d9                	li	a7,22
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
 6d0:	48dd                	li	a7,23
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret
