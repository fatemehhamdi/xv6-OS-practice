
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
      20:	ff450513          	addi	a0,a0,-12 # 1010 <malloc+0x146>
      24:	602000ef          	jal	626 <mkdir>
      28:	87aa                	mv	a5,a0
      2a:	cf81                	beqz	a5,42 <main+0x42>
    printf("%s: mkdir dd failed\n", s);
      2c:	fe843583          	ld	a1,-24(s0)
      30:	00001517          	auipc	a0,0x1
      34:	fe850513          	addi	a0,a0,-24 # 1018 <malloc+0x14e>
      38:	4ab000ef          	jal	ce2 <printf>
    exit(1);
      3c:	4505                	li	a0,1
      3e:	580000ef          	jal	5be <exit>
  }

  if(chdir("dd") != 0){
      42:	00001517          	auipc	a0,0x1
      46:	fce50513          	addi	a0,a0,-50 # 1010 <malloc+0x146>
      4a:	5e4000ef          	jal	62e <chdir>
      4e:	87aa                	mv	a5,a0
      50:	cf81                	beqz	a5,68 <main+0x68>
    printf("%s: chdir dd failed\n", s);
      52:	fe843583          	ld	a1,-24(s0)
      56:	00001517          	auipc	a0,0x1
      5a:	fda50513          	addi	a0,a0,-38 # 1030 <malloc+0x166>
      5e:	485000ef          	jal	ce2 <printf>
    exit(1);
      62:	4505                	li	a0,1
      64:	55a000ef          	jal	5be <exit>
  }

  if (unlink("../dd") < 0) {
      68:	00001517          	auipc	a0,0x1
      6c:	fe050513          	addi	a0,a0,-32 # 1048 <malloc+0x17e>
      70:	59e000ef          	jal	60e <unlink>
      74:	87aa                	mv	a5,a0
      76:	0007dd63          	bgez	a5,90 <main+0x90>
    printf("%s: unlink failed\n", s);
      7a:	fe843583          	ld	a1,-24(s0)
      7e:	00001517          	auipc	a0,0x1
      82:	fd250513          	addi	a0,a0,-46 # 1050 <malloc+0x186>
      86:	45d000ef          	jal	ce2 <printf>
    exit(1);
      8a:	4505                	li	a0,1
      8c:	532000ef          	jal	5be <exit>
  }
  printf("wait for kill and reclaim\n");
      90:	00001517          	auipc	a0,0x1
      94:	fd850513          	addi	a0,a0,-40 # 1068 <malloc+0x19e>
      98:	44b000ef          	jal	ce2 <printf>
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

0000000000000666 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     666:	48dd                	li	a7,23
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     66e:	1101                	addi	sp,sp,-32
     670:	ec06                	sd	ra,24(sp)
     672:	e822                	sd	s0,16(sp)
     674:	1000                	addi	s0,sp,32
     676:	87aa                	mv	a5,a0
     678:	872e                	mv	a4,a1
     67a:	fef42623          	sw	a5,-20(s0)
     67e:	87ba                	mv	a5,a4
     680:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     684:	feb40713          	addi	a4,s0,-21
     688:	fec42783          	lw	a5,-20(s0)
     68c:	4605                	li	a2,1
     68e:	85ba                	mv	a1,a4
     690:	853e                	mv	a0,a5
     692:	f4dff0ef          	jal	5de <write>
}
     696:	0001                	nop
     698:	60e2                	ld	ra,24(sp)
     69a:	6442                	ld	s0,16(sp)
     69c:	6105                	addi	sp,sp,32
     69e:	8082                	ret

00000000000006a0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     6a0:	711d                	addi	sp,sp,-96
     6a2:	ec86                	sd	ra,88(sp)
     6a4:	e8a2                	sd	s0,80(sp)
     6a6:	1080                	addi	s0,sp,96
     6a8:	87aa                	mv	a5,a0
     6aa:	fab43823          	sd	a1,-80(s0)
     6ae:	8736                	mv	a4,a3
     6b0:	faf42e23          	sw	a5,-68(s0)
     6b4:	87b2                	mv	a5,a2
     6b6:	faf42c23          	sw	a5,-72(s0)
     6ba:	87ba                	mv	a5,a4
     6bc:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     6c0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6c4:	fac42783          	lw	a5,-84(s0)
     6c8:	2781                	sext.w	a5,a5
     6ca:	cf99                	beqz	a5,6e8 <printint+0x48>
     6cc:	fb043783          	ld	a5,-80(s0)
     6d0:	0007dc63          	bgez	a5,6e8 <printint+0x48>
    neg = 1;
     6d4:	4785                	li	a5,1
     6d6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6da:	fb043783          	ld	a5,-80(s0)
     6de:	40f007b3          	neg	a5,a5
     6e2:	fef43023          	sd	a5,-32(s0)
     6e6:	a029                	j	6f0 <printint+0x50>
  } else {
    x = xx;
     6e8:	fb043783          	ld	a5,-80(s0)
     6ec:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     6f0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6f4:	fb842783          	lw	a5,-72(s0)
     6f8:	fe043703          	ld	a4,-32(s0)
     6fc:	02f77733          	remu	a4,a4,a5
     700:	fec42783          	lw	a5,-20(s0)
     704:	0017869b          	addiw	a3,a5,1
     708:	fed42623          	sw	a3,-20(s0)
     70c:	00002697          	auipc	a3,0x2
     710:	8f468693          	addi	a3,a3,-1804 # 2000 <digits>
     714:	9736                	add	a4,a4,a3
     716:	00074703          	lbu	a4,0(a4)
     71a:	17c1                	addi	a5,a5,-16
     71c:	97a2                	add	a5,a5,s0
     71e:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     722:	fb842783          	lw	a5,-72(s0)
     726:	fe043703          	ld	a4,-32(s0)
     72a:	02f757b3          	divu	a5,a4,a5
     72e:	fef43023          	sd	a5,-32(s0)
     732:	fe043783          	ld	a5,-32(s0)
     736:	ffdd                	bnez	a5,6f4 <printint+0x54>
  if(neg)
     738:	fe842783          	lw	a5,-24(s0)
     73c:	2781                	sext.w	a5,a5
     73e:	cb95                	beqz	a5,772 <printint+0xd2>
    buf[i++] = '-';
     740:	fec42783          	lw	a5,-20(s0)
     744:	0017871b          	addiw	a4,a5,1
     748:	fee42623          	sw	a4,-20(s0)
     74c:	17c1                	addi	a5,a5,-16
     74e:	97a2                	add	a5,a5,s0
     750:	02d00713          	li	a4,45
     754:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     758:	a829                	j	772 <printint+0xd2>
    putc(fd, buf[i]);
     75a:	fec42783          	lw	a5,-20(s0)
     75e:	17c1                	addi	a5,a5,-16
     760:	97a2                	add	a5,a5,s0
     762:	fd87c703          	lbu	a4,-40(a5)
     766:	fbc42783          	lw	a5,-68(s0)
     76a:	85ba                	mv	a1,a4
     76c:	853e                	mv	a0,a5
     76e:	f01ff0ef          	jal	66e <putc>
  while(--i >= 0)
     772:	fec42783          	lw	a5,-20(s0)
     776:	37fd                	addiw	a5,a5,-1
     778:	fef42623          	sw	a5,-20(s0)
     77c:	fec42783          	lw	a5,-20(s0)
     780:	2781                	sext.w	a5,a5
     782:	fc07dce3          	bgez	a5,75a <printint+0xba>
}
     786:	0001                	nop
     788:	0001                	nop
     78a:	60e6                	ld	ra,88(sp)
     78c:	6446                	ld	s0,80(sp)
     78e:	6125                	addi	sp,sp,96
     790:	8082                	ret

0000000000000792 <printptr>:

static void
printptr(int fd, uint64 x) {
     792:	7179                	addi	sp,sp,-48
     794:	f406                	sd	ra,40(sp)
     796:	f022                	sd	s0,32(sp)
     798:	1800                	addi	s0,sp,48
     79a:	87aa                	mv	a5,a0
     79c:	fcb43823          	sd	a1,-48(s0)
     7a0:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7a4:	fdc42783          	lw	a5,-36(s0)
     7a8:	03000593          	li	a1,48
     7ac:	853e                	mv	a0,a5
     7ae:	ec1ff0ef          	jal	66e <putc>
  putc(fd, 'x');
     7b2:	fdc42783          	lw	a5,-36(s0)
     7b6:	07800593          	li	a1,120
     7ba:	853e                	mv	a0,a5
     7bc:	eb3ff0ef          	jal	66e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7c0:	fe042623          	sw	zero,-20(s0)
     7c4:	a81d                	j	7fa <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7c6:	fd043783          	ld	a5,-48(s0)
     7ca:	93f1                	srli	a5,a5,0x3c
     7cc:	00002717          	auipc	a4,0x2
     7d0:	83470713          	addi	a4,a4,-1996 # 2000 <digits>
     7d4:	97ba                	add	a5,a5,a4
     7d6:	0007c703          	lbu	a4,0(a5)
     7da:	fdc42783          	lw	a5,-36(s0)
     7de:	85ba                	mv	a1,a4
     7e0:	853e                	mv	a0,a5
     7e2:	e8dff0ef          	jal	66e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7e6:	fec42783          	lw	a5,-20(s0)
     7ea:	2785                	addiw	a5,a5,1
     7ec:	fef42623          	sw	a5,-20(s0)
     7f0:	fd043783          	ld	a5,-48(s0)
     7f4:	0792                	slli	a5,a5,0x4
     7f6:	fcf43823          	sd	a5,-48(s0)
     7fa:	fec42703          	lw	a4,-20(s0)
     7fe:	47bd                	li	a5,15
     800:	fce7f3e3          	bgeu	a5,a4,7c6 <printptr+0x34>
}
     804:	0001                	nop
     806:	0001                	nop
     808:	70a2                	ld	ra,40(sp)
     80a:	7402                	ld	s0,32(sp)
     80c:	6145                	addi	sp,sp,48
     80e:	8082                	ret

0000000000000810 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     810:	715d                	addi	sp,sp,-80
     812:	e486                	sd	ra,72(sp)
     814:	e0a2                	sd	s0,64(sp)
     816:	0880                	addi	s0,sp,80
     818:	87aa                	mv	a5,a0
     81a:	fcb43023          	sd	a1,-64(s0)
     81e:	fac43c23          	sd	a2,-72(s0)
     822:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     826:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     82a:	fc042e23          	sw	zero,-36(s0)
     82e:	a189                	j	c70 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     830:	fdc42783          	lw	a5,-36(s0)
     834:	fc043703          	ld	a4,-64(s0)
     838:	97ba                	add	a5,a5,a4
     83a:	0007c783          	lbu	a5,0(a5)
     83e:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     842:	fd842783          	lw	a5,-40(s0)
     846:	2781                	sext.w	a5,a5
     848:	eb8d                	bnez	a5,87a <vprintf+0x6a>
      if(c0 == '%'){
     84a:	fd442783          	lw	a5,-44(s0)
     84e:	0007871b          	sext.w	a4,a5
     852:	02500793          	li	a5,37
     856:	00f71763          	bne	a4,a5,864 <vprintf+0x54>
        state = '%';
     85a:	02500793          	li	a5,37
     85e:	fcf42c23          	sw	a5,-40(s0)
     862:	a111                	j	c66 <vprintf+0x456>
      } else {
        putc(fd, c0);
     864:	fd442783          	lw	a5,-44(s0)
     868:	0ff7f713          	zext.b	a4,a5
     86c:	fcc42783          	lw	a5,-52(s0)
     870:	85ba                	mv	a1,a4
     872:	853e                	mv	a0,a5
     874:	dfbff0ef          	jal	66e <putc>
     878:	a6fd                	j	c66 <vprintf+0x456>
      }
    } else if(state == '%'){
     87a:	fd842783          	lw	a5,-40(s0)
     87e:	0007871b          	sext.w	a4,a5
     882:	02500793          	li	a5,37
     886:	3ef71063          	bne	a4,a5,c66 <vprintf+0x456>
      c1 = c2 = 0;
     88a:	fe042023          	sw	zero,-32(s0)
     88e:	fe042783          	lw	a5,-32(s0)
     892:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     896:	fd442783          	lw	a5,-44(s0)
     89a:	2781                	sext.w	a5,a5
     89c:	cb99                	beqz	a5,8b2 <vprintf+0xa2>
     89e:	fdc42783          	lw	a5,-36(s0)
     8a2:	0785                	addi	a5,a5,1
     8a4:	fc043703          	ld	a4,-64(s0)
     8a8:	97ba                	add	a5,a5,a4
     8aa:	0007c783          	lbu	a5,0(a5)
     8ae:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     8b2:	fe442783          	lw	a5,-28(s0)
     8b6:	2781                	sext.w	a5,a5
     8b8:	cb99                	beqz	a5,8ce <vprintf+0xbe>
     8ba:	fdc42783          	lw	a5,-36(s0)
     8be:	0789                	addi	a5,a5,2
     8c0:	fc043703          	ld	a4,-64(s0)
     8c4:	97ba                	add	a5,a5,a4
     8c6:	0007c783          	lbu	a5,0(a5)
     8ca:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     8ce:	fd442783          	lw	a5,-44(s0)
     8d2:	0007871b          	sext.w	a4,a5
     8d6:	06400793          	li	a5,100
     8da:	02f71363          	bne	a4,a5,900 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     8de:	fb843783          	ld	a5,-72(s0)
     8e2:	00878713          	addi	a4,a5,8
     8e6:	fae43c23          	sd	a4,-72(s0)
     8ea:	439c                	lw	a5,0(a5)
     8ec:	873e                	mv	a4,a5
     8ee:	fcc42783          	lw	a5,-52(s0)
     8f2:	4685                	li	a3,1
     8f4:	4629                	li	a2,10
     8f6:	85ba                	mv	a1,a4
     8f8:	853e                	mv	a0,a5
     8fa:	da7ff0ef          	jal	6a0 <printint>
     8fe:	a695                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     900:	fd442783          	lw	a5,-44(s0)
     904:	0007871b          	sext.w	a4,a5
     908:	06c00793          	li	a5,108
     90c:	04f71063          	bne	a4,a5,94c <vprintf+0x13c>
     910:	fe442783          	lw	a5,-28(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	06400793          	li	a5,100
     91c:	02f71863          	bne	a4,a5,94c <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     920:	fb843783          	ld	a5,-72(s0)
     924:	00878713          	addi	a4,a5,8
     928:	fae43c23          	sd	a4,-72(s0)
     92c:	639c                	ld	a5,0(a5)
     92e:	873e                	mv	a4,a5
     930:	fcc42783          	lw	a5,-52(s0)
     934:	4685                	li	a3,1
     936:	4629                	li	a2,10
     938:	85ba                	mv	a1,a4
     93a:	853e                	mv	a0,a5
     93c:	d65ff0ef          	jal	6a0 <printint>
        i += 1;
     940:	fdc42783          	lw	a5,-36(s0)
     944:	2785                	addiw	a5,a5,1
     946:	fcf42e23          	sw	a5,-36(s0)
     94a:	ae21                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     94c:	fd442783          	lw	a5,-44(s0)
     950:	0007871b          	sext.w	a4,a5
     954:	06c00793          	li	a5,108
     958:	04f71863          	bne	a4,a5,9a8 <vprintf+0x198>
     95c:	fe442783          	lw	a5,-28(s0)
     960:	0007871b          	sext.w	a4,a5
     964:	06c00793          	li	a5,108
     968:	04f71063          	bne	a4,a5,9a8 <vprintf+0x198>
     96c:	fe042783          	lw	a5,-32(s0)
     970:	0007871b          	sext.w	a4,a5
     974:	06400793          	li	a5,100
     978:	02f71863          	bne	a4,a5,9a8 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     97c:	fb843783          	ld	a5,-72(s0)
     980:	00878713          	addi	a4,a5,8
     984:	fae43c23          	sd	a4,-72(s0)
     988:	639c                	ld	a5,0(a5)
     98a:	873e                	mv	a4,a5
     98c:	fcc42783          	lw	a5,-52(s0)
     990:	4685                	li	a3,1
     992:	4629                	li	a2,10
     994:	85ba                	mv	a1,a4
     996:	853e                	mv	a0,a5
     998:	d09ff0ef          	jal	6a0 <printint>
        i += 2;
     99c:	fdc42783          	lw	a5,-36(s0)
     9a0:	2789                	addiw	a5,a5,2
     9a2:	fcf42e23          	sw	a5,-36(s0)
     9a6:	ac75                	j	c62 <vprintf+0x452>
      } else if(c0 == 'u'){
     9a8:	fd442783          	lw	a5,-44(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	07500793          	li	a5,117
     9b4:	02f71563          	bne	a4,a5,9de <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     9b8:	fb843783          	ld	a5,-72(s0)
     9bc:	00878713          	addi	a4,a5,8
     9c0:	fae43c23          	sd	a4,-72(s0)
     9c4:	439c                	lw	a5,0(a5)
     9c6:	02079713          	slli	a4,a5,0x20
     9ca:	9301                	srli	a4,a4,0x20
     9cc:	fcc42783          	lw	a5,-52(s0)
     9d0:	4681                	li	a3,0
     9d2:	4629                	li	a2,10
     9d4:	85ba                	mv	a1,a4
     9d6:	853e                	mv	a0,a5
     9d8:	cc9ff0ef          	jal	6a0 <printint>
     9dc:	a459                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     9de:	fd442783          	lw	a5,-44(s0)
     9e2:	0007871b          	sext.w	a4,a5
     9e6:	06c00793          	li	a5,108
     9ea:	04f71063          	bne	a4,a5,a2a <vprintf+0x21a>
     9ee:	fe442783          	lw	a5,-28(s0)
     9f2:	0007871b          	sext.w	a4,a5
     9f6:	07500793          	li	a5,117
     9fa:	02f71863          	bne	a4,a5,a2a <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     9fe:	fb843783          	ld	a5,-72(s0)
     a02:	00878713          	addi	a4,a5,8
     a06:	fae43c23          	sd	a4,-72(s0)
     a0a:	639c                	ld	a5,0(a5)
     a0c:	873e                	mv	a4,a5
     a0e:	fcc42783          	lw	a5,-52(s0)
     a12:	4681                	li	a3,0
     a14:	4629                	li	a2,10
     a16:	85ba                	mv	a1,a4
     a18:	853e                	mv	a0,a5
     a1a:	c87ff0ef          	jal	6a0 <printint>
        i += 1;
     a1e:	fdc42783          	lw	a5,-36(s0)
     a22:	2785                	addiw	a5,a5,1
     a24:	fcf42e23          	sw	a5,-36(s0)
     a28:	ac2d                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     a2a:	fd442783          	lw	a5,-44(s0)
     a2e:	0007871b          	sext.w	a4,a5
     a32:	06c00793          	li	a5,108
     a36:	04f71863          	bne	a4,a5,a86 <vprintf+0x276>
     a3a:	fe442783          	lw	a5,-28(s0)
     a3e:	0007871b          	sext.w	a4,a5
     a42:	06c00793          	li	a5,108
     a46:	04f71063          	bne	a4,a5,a86 <vprintf+0x276>
     a4a:	fe042783          	lw	a5,-32(s0)
     a4e:	0007871b          	sext.w	a4,a5
     a52:	07500793          	li	a5,117
     a56:	02f71863          	bne	a4,a5,a86 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a5a:	fb843783          	ld	a5,-72(s0)
     a5e:	00878713          	addi	a4,a5,8
     a62:	fae43c23          	sd	a4,-72(s0)
     a66:	639c                	ld	a5,0(a5)
     a68:	873e                	mv	a4,a5
     a6a:	fcc42783          	lw	a5,-52(s0)
     a6e:	4681                	li	a3,0
     a70:	4629                	li	a2,10
     a72:	85ba                	mv	a1,a4
     a74:	853e                	mv	a0,a5
     a76:	c2bff0ef          	jal	6a0 <printint>
        i += 2;
     a7a:	fdc42783          	lw	a5,-36(s0)
     a7e:	2789                	addiw	a5,a5,2
     a80:	fcf42e23          	sw	a5,-36(s0)
     a84:	aaf9                	j	c62 <vprintf+0x452>
      } else if(c0 == 'x'){
     a86:	fd442783          	lw	a5,-44(s0)
     a8a:	0007871b          	sext.w	a4,a5
     a8e:	07800793          	li	a5,120
     a92:	02f71563          	bne	a4,a5,abc <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     a96:	fb843783          	ld	a5,-72(s0)
     a9a:	00878713          	addi	a4,a5,8
     a9e:	fae43c23          	sd	a4,-72(s0)
     aa2:	439c                	lw	a5,0(a5)
     aa4:	02079713          	slli	a4,a5,0x20
     aa8:	9301                	srli	a4,a4,0x20
     aaa:	fcc42783          	lw	a5,-52(s0)
     aae:	4681                	li	a3,0
     ab0:	4641                	li	a2,16
     ab2:	85ba                	mv	a1,a4
     ab4:	853e                	mv	a0,a5
     ab6:	bebff0ef          	jal	6a0 <printint>
     aba:	a265                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     abc:	fd442783          	lw	a5,-44(s0)
     ac0:	0007871b          	sext.w	a4,a5
     ac4:	06c00793          	li	a5,108
     ac8:	04f71063          	bne	a4,a5,b08 <vprintf+0x2f8>
     acc:	fe442783          	lw	a5,-28(s0)
     ad0:	0007871b          	sext.w	a4,a5
     ad4:	07800793          	li	a5,120
     ad8:	02f71863          	bne	a4,a5,b08 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     adc:	fb843783          	ld	a5,-72(s0)
     ae0:	00878713          	addi	a4,a5,8
     ae4:	fae43c23          	sd	a4,-72(s0)
     ae8:	639c                	ld	a5,0(a5)
     aea:	873e                	mv	a4,a5
     aec:	fcc42783          	lw	a5,-52(s0)
     af0:	4681                	li	a3,0
     af2:	4641                	li	a2,16
     af4:	85ba                	mv	a1,a4
     af6:	853e                	mv	a0,a5
     af8:	ba9ff0ef          	jal	6a0 <printint>
        i += 1;
     afc:	fdc42783          	lw	a5,-36(s0)
     b00:	2785                	addiw	a5,a5,1
     b02:	fcf42e23          	sw	a5,-36(s0)
     b06:	aab1                	j	c62 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     b08:	fd442783          	lw	a5,-44(s0)
     b0c:	0007871b          	sext.w	a4,a5
     b10:	06c00793          	li	a5,108
     b14:	04f71863          	bne	a4,a5,b64 <vprintf+0x354>
     b18:	fe442783          	lw	a5,-28(s0)
     b1c:	0007871b          	sext.w	a4,a5
     b20:	06c00793          	li	a5,108
     b24:	04f71063          	bne	a4,a5,b64 <vprintf+0x354>
     b28:	fe042783          	lw	a5,-32(s0)
     b2c:	0007871b          	sext.w	a4,a5
     b30:	07800793          	li	a5,120
     b34:	02f71863          	bne	a4,a5,b64 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b38:	fb843783          	ld	a5,-72(s0)
     b3c:	00878713          	addi	a4,a5,8
     b40:	fae43c23          	sd	a4,-72(s0)
     b44:	639c                	ld	a5,0(a5)
     b46:	873e                	mv	a4,a5
     b48:	fcc42783          	lw	a5,-52(s0)
     b4c:	4681                	li	a3,0
     b4e:	4641                	li	a2,16
     b50:	85ba                	mv	a1,a4
     b52:	853e                	mv	a0,a5
     b54:	b4dff0ef          	jal	6a0 <printint>
        i += 2;
     b58:	fdc42783          	lw	a5,-36(s0)
     b5c:	2789                	addiw	a5,a5,2
     b5e:	fcf42e23          	sw	a5,-36(s0)
     b62:	a201                	j	c62 <vprintf+0x452>
      } else if(c0 == 'p'){
     b64:	fd442783          	lw	a5,-44(s0)
     b68:	0007871b          	sext.w	a4,a5
     b6c:	07000793          	li	a5,112
     b70:	02f71063          	bne	a4,a5,b90 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     b74:	fb843783          	ld	a5,-72(s0)
     b78:	00878713          	addi	a4,a5,8
     b7c:	fae43c23          	sd	a4,-72(s0)
     b80:	6398                	ld	a4,0(a5)
     b82:	fcc42783          	lw	a5,-52(s0)
     b86:	85ba                	mv	a1,a4
     b88:	853e                	mv	a0,a5
     b8a:	c09ff0ef          	jal	792 <printptr>
     b8e:	a8d1                	j	c62 <vprintf+0x452>
      } else if(c0 == 'c'){
     b90:	fd442783          	lw	a5,-44(s0)
     b94:	0007871b          	sext.w	a4,a5
     b98:	06300793          	li	a5,99
     b9c:	02f71263          	bne	a4,a5,bc0 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     ba0:	fb843783          	ld	a5,-72(s0)
     ba4:	00878713          	addi	a4,a5,8
     ba8:	fae43c23          	sd	a4,-72(s0)
     bac:	439c                	lw	a5,0(a5)
     bae:	0ff7f713          	zext.b	a4,a5
     bb2:	fcc42783          	lw	a5,-52(s0)
     bb6:	85ba                	mv	a1,a4
     bb8:	853e                	mv	a0,a5
     bba:	ab5ff0ef          	jal	66e <putc>
     bbe:	a055                	j	c62 <vprintf+0x452>
      } else if(c0 == 's'){
     bc0:	fd442783          	lw	a5,-44(s0)
     bc4:	0007871b          	sext.w	a4,a5
     bc8:	07300793          	li	a5,115
     bcc:	04f71a63          	bne	a4,a5,c20 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     bd0:	fb843783          	ld	a5,-72(s0)
     bd4:	00878713          	addi	a4,a5,8
     bd8:	fae43c23          	sd	a4,-72(s0)
     bdc:	639c                	ld	a5,0(a5)
     bde:	fef43423          	sd	a5,-24(s0)
     be2:	fe843783          	ld	a5,-24(s0)
     be6:	e79d                	bnez	a5,c14 <vprintf+0x404>
          s = "(null)";
     be8:	00000797          	auipc	a5,0x0
     bec:	4a078793          	addi	a5,a5,1184 # 1088 <malloc+0x1be>
     bf0:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     bf4:	a005                	j	c14 <vprintf+0x404>
          putc(fd, *s);
     bf6:	fe843783          	ld	a5,-24(s0)
     bfa:	0007c703          	lbu	a4,0(a5)
     bfe:	fcc42783          	lw	a5,-52(s0)
     c02:	85ba                	mv	a1,a4
     c04:	853e                	mv	a0,a5
     c06:	a69ff0ef          	jal	66e <putc>
        for(; *s; s++)
     c0a:	fe843783          	ld	a5,-24(s0)
     c0e:	0785                	addi	a5,a5,1
     c10:	fef43423          	sd	a5,-24(s0)
     c14:	fe843783          	ld	a5,-24(s0)
     c18:	0007c783          	lbu	a5,0(a5)
     c1c:	ffe9                	bnez	a5,bf6 <vprintf+0x3e6>
     c1e:	a091                	j	c62 <vprintf+0x452>
      } else if(c0 == '%'){
     c20:	fd442783          	lw	a5,-44(s0)
     c24:	0007871b          	sext.w	a4,a5
     c28:	02500793          	li	a5,37
     c2c:	00f71a63          	bne	a4,a5,c40 <vprintf+0x430>
        putc(fd, '%');
     c30:	fcc42783          	lw	a5,-52(s0)
     c34:	02500593          	li	a1,37
     c38:	853e                	mv	a0,a5
     c3a:	a35ff0ef          	jal	66e <putc>
     c3e:	a015                	j	c62 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c40:	fcc42783          	lw	a5,-52(s0)
     c44:	02500593          	li	a1,37
     c48:	853e                	mv	a0,a5
     c4a:	a25ff0ef          	jal	66e <putc>
        putc(fd, c0);
     c4e:	fd442783          	lw	a5,-44(s0)
     c52:	0ff7f713          	zext.b	a4,a5
     c56:	fcc42783          	lw	a5,-52(s0)
     c5a:	85ba                	mv	a1,a4
     c5c:	853e                	mv	a0,a5
     c5e:	a11ff0ef          	jal	66e <putc>
      }

      state = 0;
     c62:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     c66:	fdc42783          	lw	a5,-36(s0)
     c6a:	2785                	addiw	a5,a5,1
     c6c:	fcf42e23          	sw	a5,-36(s0)
     c70:	fdc42783          	lw	a5,-36(s0)
     c74:	fc043703          	ld	a4,-64(s0)
     c78:	97ba                	add	a5,a5,a4
     c7a:	0007c783          	lbu	a5,0(a5)
     c7e:	ba0799e3          	bnez	a5,830 <vprintf+0x20>
    }
  }
}
     c82:	0001                	nop
     c84:	0001                	nop
     c86:	60a6                	ld	ra,72(sp)
     c88:	6406                	ld	s0,64(sp)
     c8a:	6161                	addi	sp,sp,80
     c8c:	8082                	ret

0000000000000c8e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     c8e:	7159                	addi	sp,sp,-112
     c90:	fc06                	sd	ra,56(sp)
     c92:	f822                	sd	s0,48(sp)
     c94:	0080                	addi	s0,sp,64
     c96:	fcb43823          	sd	a1,-48(s0)
     c9a:	e010                	sd	a2,0(s0)
     c9c:	e414                	sd	a3,8(s0)
     c9e:	e818                	sd	a4,16(s0)
     ca0:	ec1c                	sd	a5,24(s0)
     ca2:	03043023          	sd	a6,32(s0)
     ca6:	03143423          	sd	a7,40(s0)
     caa:	87aa                	mv	a5,a0
     cac:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     cb0:	03040793          	addi	a5,s0,48
     cb4:	fcf43423          	sd	a5,-56(s0)
     cb8:	fc843783          	ld	a5,-56(s0)
     cbc:	fd078793          	addi	a5,a5,-48
     cc0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     cc4:	fe843703          	ld	a4,-24(s0)
     cc8:	fdc42783          	lw	a5,-36(s0)
     ccc:	863a                	mv	a2,a4
     cce:	fd043583          	ld	a1,-48(s0)
     cd2:	853e                	mv	a0,a5
     cd4:	b3dff0ef          	jal	810 <vprintf>
}
     cd8:	0001                	nop
     cda:	70e2                	ld	ra,56(sp)
     cdc:	7442                	ld	s0,48(sp)
     cde:	6165                	addi	sp,sp,112
     ce0:	8082                	ret

0000000000000ce2 <printf>:

void
printf(const char *fmt, ...)
{
     ce2:	7159                	addi	sp,sp,-112
     ce4:	f406                	sd	ra,40(sp)
     ce6:	f022                	sd	s0,32(sp)
     ce8:	1800                	addi	s0,sp,48
     cea:	fca43c23          	sd	a0,-40(s0)
     cee:	e40c                	sd	a1,8(s0)
     cf0:	e810                	sd	a2,16(s0)
     cf2:	ec14                	sd	a3,24(s0)
     cf4:	f018                	sd	a4,32(s0)
     cf6:	f41c                	sd	a5,40(s0)
     cf8:	03043823          	sd	a6,48(s0)
     cfc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d00:	04040793          	addi	a5,s0,64
     d04:	fcf43823          	sd	a5,-48(s0)
     d08:	fd043783          	ld	a5,-48(s0)
     d0c:	fc878793          	addi	a5,a5,-56
     d10:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d14:	fe843783          	ld	a5,-24(s0)
     d18:	863e                	mv	a2,a5
     d1a:	fd843583          	ld	a1,-40(s0)
     d1e:	4505                	li	a0,1
     d20:	af1ff0ef          	jal	810 <vprintf>
}
     d24:	0001                	nop
     d26:	70a2                	ld	ra,40(sp)
     d28:	7402                	ld	s0,32(sp)
     d2a:	6165                	addi	sp,sp,112
     d2c:	8082                	ret

0000000000000d2e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d2e:	7179                	addi	sp,sp,-48
     d30:	f406                	sd	ra,40(sp)
     d32:	f022                	sd	s0,32(sp)
     d34:	1800                	addi	s0,sp,48
     d36:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d3a:	fd843783          	ld	a5,-40(s0)
     d3e:	17c1                	addi	a5,a5,-16
     d40:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d44:	00001797          	auipc	a5,0x1
     d48:	4e478793          	addi	a5,a5,1252 # 2228 <freep>
     d4c:	639c                	ld	a5,0(a5)
     d4e:	fef43423          	sd	a5,-24(s0)
     d52:	a815                	j	d86 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d54:	fe843783          	ld	a5,-24(s0)
     d58:	639c                	ld	a5,0(a5)
     d5a:	fe843703          	ld	a4,-24(s0)
     d5e:	00f76f63          	bltu	a4,a5,d7c <free+0x4e>
     d62:	fe043703          	ld	a4,-32(s0)
     d66:	fe843783          	ld	a5,-24(s0)
     d6a:	02e7eb63          	bltu	a5,a4,da0 <free+0x72>
     d6e:	fe843783          	ld	a5,-24(s0)
     d72:	639c                	ld	a5,0(a5)
     d74:	fe043703          	ld	a4,-32(s0)
     d78:	02f76463          	bltu	a4,a5,da0 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d7c:	fe843783          	ld	a5,-24(s0)
     d80:	639c                	ld	a5,0(a5)
     d82:	fef43423          	sd	a5,-24(s0)
     d86:	fe043703          	ld	a4,-32(s0)
     d8a:	fe843783          	ld	a5,-24(s0)
     d8e:	fce7f3e3          	bgeu	a5,a4,d54 <free+0x26>
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	639c                	ld	a5,0(a5)
     d98:	fe043703          	ld	a4,-32(s0)
     d9c:	faf77ce3          	bgeu	a4,a5,d54 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     da0:	fe043783          	ld	a5,-32(s0)
     da4:	479c                	lw	a5,8(a5)
     da6:	1782                	slli	a5,a5,0x20
     da8:	9381                	srli	a5,a5,0x20
     daa:	0792                	slli	a5,a5,0x4
     dac:	fe043703          	ld	a4,-32(s0)
     db0:	973e                	add	a4,a4,a5
     db2:	fe843783          	ld	a5,-24(s0)
     db6:	639c                	ld	a5,0(a5)
     db8:	02f71763          	bne	a4,a5,de6 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     dbc:	fe043783          	ld	a5,-32(s0)
     dc0:	4798                	lw	a4,8(a5)
     dc2:	fe843783          	ld	a5,-24(s0)
     dc6:	639c                	ld	a5,0(a5)
     dc8:	479c                	lw	a5,8(a5)
     dca:	9fb9                	addw	a5,a5,a4
     dcc:	0007871b          	sext.w	a4,a5
     dd0:	fe043783          	ld	a5,-32(s0)
     dd4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     dd6:	fe843783          	ld	a5,-24(s0)
     dda:	639c                	ld	a5,0(a5)
     ddc:	6398                	ld	a4,0(a5)
     dde:	fe043783          	ld	a5,-32(s0)
     de2:	e398                	sd	a4,0(a5)
     de4:	a039                	j	df2 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     de6:	fe843783          	ld	a5,-24(s0)
     dea:	6398                	ld	a4,0(a5)
     dec:	fe043783          	ld	a5,-32(s0)
     df0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     df2:	fe843783          	ld	a5,-24(s0)
     df6:	479c                	lw	a5,8(a5)
     df8:	1782                	slli	a5,a5,0x20
     dfa:	9381                	srli	a5,a5,0x20
     dfc:	0792                	slli	a5,a5,0x4
     dfe:	fe843703          	ld	a4,-24(s0)
     e02:	97ba                	add	a5,a5,a4
     e04:	fe043703          	ld	a4,-32(s0)
     e08:	02f71563          	bne	a4,a5,e32 <free+0x104>
    p->s.size += bp->s.size;
     e0c:	fe843783          	ld	a5,-24(s0)
     e10:	4798                	lw	a4,8(a5)
     e12:	fe043783          	ld	a5,-32(s0)
     e16:	479c                	lw	a5,8(a5)
     e18:	9fb9                	addw	a5,a5,a4
     e1a:	0007871b          	sext.w	a4,a5
     e1e:	fe843783          	ld	a5,-24(s0)
     e22:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     e24:	fe043783          	ld	a5,-32(s0)
     e28:	6398                	ld	a4,0(a5)
     e2a:	fe843783          	ld	a5,-24(s0)
     e2e:	e398                	sd	a4,0(a5)
     e30:	a031                	j	e3c <free+0x10e>
  } else
    p->s.ptr = bp;
     e32:	fe843783          	ld	a5,-24(s0)
     e36:	fe043703          	ld	a4,-32(s0)
     e3a:	e398                	sd	a4,0(a5)
  freep = p;
     e3c:	00001797          	auipc	a5,0x1
     e40:	3ec78793          	addi	a5,a5,1004 # 2228 <freep>
     e44:	fe843703          	ld	a4,-24(s0)
     e48:	e398                	sd	a4,0(a5)
}
     e4a:	0001                	nop
     e4c:	70a2                	ld	ra,40(sp)
     e4e:	7402                	ld	s0,32(sp)
     e50:	6145                	addi	sp,sp,48
     e52:	8082                	ret

0000000000000e54 <morecore>:

static Header*
morecore(uint nu)
{
     e54:	7179                	addi	sp,sp,-48
     e56:	f406                	sd	ra,40(sp)
     e58:	f022                	sd	s0,32(sp)
     e5a:	1800                	addi	s0,sp,48
     e5c:	87aa                	mv	a5,a0
     e5e:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     e62:	fdc42783          	lw	a5,-36(s0)
     e66:	0007871b          	sext.w	a4,a5
     e6a:	6785                	lui	a5,0x1
     e6c:	00f77563          	bgeu	a4,a5,e76 <morecore+0x22>
    nu = 4096;
     e70:	6785                	lui	a5,0x1
     e72:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     e76:	fdc42783          	lw	a5,-36(s0)
     e7a:	0047979b          	slliw	a5,a5,0x4
     e7e:	2781                	sext.w	a5,a5
     e80:	853e                	mv	a0,a5
     e82:	ee8ff0ef          	jal	56a <sbrk>
     e86:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     e8a:	fe843703          	ld	a4,-24(s0)
     e8e:	57fd                	li	a5,-1
     e90:	00f71463          	bne	a4,a5,e98 <morecore+0x44>
    return 0;
     e94:	4781                	li	a5,0
     e96:	a02d                	j	ec0 <morecore+0x6c>
  hp = (Header*)p;
     e98:	fe843783          	ld	a5,-24(s0)
     e9c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ea0:	fe043783          	ld	a5,-32(s0)
     ea4:	fdc42703          	lw	a4,-36(s0)
     ea8:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     eaa:	fe043783          	ld	a5,-32(s0)
     eae:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x146>
     eb0:	853e                	mv	a0,a5
     eb2:	e7dff0ef          	jal	d2e <free>
  return freep;
     eb6:	00001797          	auipc	a5,0x1
     eba:	37278793          	addi	a5,a5,882 # 2228 <freep>
     ebe:	639c                	ld	a5,0(a5)
}
     ec0:	853e                	mv	a0,a5
     ec2:	70a2                	ld	ra,40(sp)
     ec4:	7402                	ld	s0,32(sp)
     ec6:	6145                	addi	sp,sp,48
     ec8:	8082                	ret

0000000000000eca <malloc>:

void*
malloc(uint nbytes)
{
     eca:	7139                	addi	sp,sp,-64
     ecc:	fc06                	sd	ra,56(sp)
     ece:	f822                	sd	s0,48(sp)
     ed0:	0080                	addi	s0,sp,64
     ed2:	87aa                	mv	a5,a0
     ed4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ed8:	fcc46783          	lwu	a5,-52(s0)
     edc:	07bd                	addi	a5,a5,15
     ede:	8391                	srli	a5,a5,0x4
     ee0:	2781                	sext.w	a5,a5
     ee2:	2785                	addiw	a5,a5,1
     ee4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     ee8:	00001797          	auipc	a5,0x1
     eec:	34078793          	addi	a5,a5,832 # 2228 <freep>
     ef0:	639c                	ld	a5,0(a5)
     ef2:	fef43023          	sd	a5,-32(s0)
     ef6:	fe043783          	ld	a5,-32(s0)
     efa:	ef95                	bnez	a5,f36 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     efc:	00001797          	auipc	a5,0x1
     f00:	31c78793          	addi	a5,a5,796 # 2218 <base>
     f04:	fef43023          	sd	a5,-32(s0)
     f08:	00001797          	auipc	a5,0x1
     f0c:	32078793          	addi	a5,a5,800 # 2228 <freep>
     f10:	fe043703          	ld	a4,-32(s0)
     f14:	e398                	sd	a4,0(a5)
     f16:	00001797          	auipc	a5,0x1
     f1a:	31278793          	addi	a5,a5,786 # 2228 <freep>
     f1e:	6398                	ld	a4,0(a5)
     f20:	00001797          	auipc	a5,0x1
     f24:	2f878793          	addi	a5,a5,760 # 2218 <base>
     f28:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f2a:	00001797          	auipc	a5,0x1
     f2e:	2ee78793          	addi	a5,a5,750 # 2218 <base>
     f32:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f36:	fe043783          	ld	a5,-32(s0)
     f3a:	639c                	ld	a5,0(a5)
     f3c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	479c                	lw	a5,8(a5)
     f46:	fdc42703          	lw	a4,-36(s0)
     f4a:	2701                	sext.w	a4,a4
     f4c:	06e7e763          	bltu	a5,a4,fba <malloc+0xf0>
      if(p->s.size == nunits)
     f50:	fe843783          	ld	a5,-24(s0)
     f54:	479c                	lw	a5,8(a5)
     f56:	fdc42703          	lw	a4,-36(s0)
     f5a:	2701                	sext.w	a4,a4
     f5c:	00f71963          	bne	a4,a5,f6e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f60:	fe843783          	ld	a5,-24(s0)
     f64:	6398                	ld	a4,0(a5)
     f66:	fe043783          	ld	a5,-32(s0)
     f6a:	e398                	sd	a4,0(a5)
     f6c:	a825                	j	fa4 <malloc+0xda>
      else {
        p->s.size -= nunits;
     f6e:	fe843783          	ld	a5,-24(s0)
     f72:	479c                	lw	a5,8(a5)
     f74:	fdc42703          	lw	a4,-36(s0)
     f78:	9f99                	subw	a5,a5,a4
     f7a:	0007871b          	sext.w	a4,a5
     f7e:	fe843783          	ld	a5,-24(s0)
     f82:	c798                	sw	a4,8(a5)
        p += p->s.size;
     f84:	fe843783          	ld	a5,-24(s0)
     f88:	479c                	lw	a5,8(a5)
     f8a:	1782                	slli	a5,a5,0x20
     f8c:	9381                	srli	a5,a5,0x20
     f8e:	0792                	slli	a5,a5,0x4
     f90:	fe843703          	ld	a4,-24(s0)
     f94:	97ba                	add	a5,a5,a4
     f96:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     f9a:	fe843783          	ld	a5,-24(s0)
     f9e:	fdc42703          	lw	a4,-36(s0)
     fa2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     fa4:	00001797          	auipc	a5,0x1
     fa8:	28478793          	addi	a5,a5,644 # 2228 <freep>
     fac:	fe043703          	ld	a4,-32(s0)
     fb0:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     fb2:	fe843783          	ld	a5,-24(s0)
     fb6:	07c1                	addi	a5,a5,16
     fb8:	a081                	j	ff8 <malloc+0x12e>
    }
    if(p == freep)
     fba:	00001797          	auipc	a5,0x1
     fbe:	26e78793          	addi	a5,a5,622 # 2228 <freep>
     fc2:	639c                	ld	a5,0(a5)
     fc4:	fe843703          	ld	a4,-24(s0)
     fc8:	00f71e63          	bne	a4,a5,fe4 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
     fcc:	fdc42783          	lw	a5,-36(s0)
     fd0:	853e                	mv	a0,a5
     fd2:	e83ff0ef          	jal	e54 <morecore>
     fd6:	fea43423          	sd	a0,-24(s0)
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	e399                	bnez	a5,fe4 <malloc+0x11a>
        return 0;
     fe0:	4781                	li	a5,0
     fe2:	a819                	j	ff8 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	fef43023          	sd	a5,-32(s0)
     fec:	fe843783          	ld	a5,-24(s0)
     ff0:	639c                	ld	a5,0(a5)
     ff2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ff6:	b7a9                	j	f40 <malloc+0x76>
  }
}
     ff8:	853e                	mv	a0,a5
     ffa:	70e2                	ld	ra,56(sp)
     ffc:	7442                	ld	s0,48(sp)
     ffe:	6121                	addi	sp,sp,64
    1000:	8082                	ret
