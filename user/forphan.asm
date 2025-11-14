
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
       0:	715d                	addi	sp,sp,-80
       2:	e486                	sd	ra,72(sp)
       4:	e0a2                	sd	s0,64(sp)
       6:	0880                	addi	s0,sp,80
       8:	87aa                	mv	a5,a0
       a:	fab43823          	sd	a1,-80(s0)
       e:	faf42e23          	sw	a5,-68(s0)
  int fd = 0;
      12:	fe042623          	sw	zero,-20(s0)
  char *s = argv[0];
      16:	fb043783          	ld	a5,-80(s0)
      1a:	639c                	ld	a5,0(a5)
      1c:	fef43023          	sd	a5,-32(s0)
  struct stat st;
  char *ff = "file0";
      20:	00001797          	auipc	a5,0x1
      24:	04078793          	addi	a5,a5,64 # 1060 <malloc+0x146>
      28:	fcf43c23          	sd	a5,-40(s0)
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
      2c:	20100593          	li	a1,513
      30:	fd843503          	ld	a0,-40(s0)
      34:	622000ef          	jal	656 <open>
      38:	87aa                	mv	a5,a0
      3a:	fef42623          	sw	a5,-20(s0)
      3e:	fec42783          	lw	a5,-20(s0)
      42:	2781                	sext.w	a5,a5
      44:	0007dd63          	bgez	a5,5e <main+0x5e>
    printf("%s: open failed\n", s);
      48:	fe043583          	ld	a1,-32(s0)
      4c:	00001517          	auipc	a0,0x1
      50:	01c50513          	addi	a0,a0,28 # 1068 <malloc+0x14e>
      54:	4df000ef          	jal	d32 <printf>
    exit(1);
      58:	4505                	li	a0,1
      5a:	5bc000ef          	jal	616 <exit>
  }
  if(fstat(fd, &st) < 0){
      5e:	fc040713          	addi	a4,s0,-64
      62:	fec42783          	lw	a5,-20(s0)
      66:	85ba                	mv	a1,a4
      68:	853e                	mv	a0,a5
      6a:	604000ef          	jal	66e <fstat>
      6e:	87aa                	mv	a5,a0
      70:	0207d263          	bgez	a5,94 <main+0x94>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
      74:	00001697          	auipc	a3,0x1
      78:	00c68693          	addi	a3,a3,12 # 1080 <malloc+0x166>
      7c:	fe043603          	ld	a2,-32(s0)
      80:	00001597          	auipc	a1,0x1
      84:	00858593          	addi	a1,a1,8 # 1088 <malloc+0x16e>
      88:	4509                	li	a0,2
      8a:	455000ef          	jal	cde <fprintf>
    exit(1);
      8e:	4505                	li	a0,1
      90:	586000ef          	jal	616 <exit>
  }
  if (unlink(ff) < 0) {
      94:	fd843503          	ld	a0,-40(s0)
      98:	5ce000ef          	jal	666 <unlink>
      9c:	87aa                	mv	a5,a0
      9e:	0007dd63          	bgez	a5,b8 <main+0xb8>
    printf("%s: unlink failed\n", s);
      a2:	fe043583          	ld	a1,-32(s0)
      a6:	00001517          	auipc	a0,0x1
      aa:	ffa50513          	addi	a0,a0,-6 # 10a0 <malloc+0x186>
      ae:	485000ef          	jal	d32 <printf>
    exit(1);
      b2:	4505                	li	a0,1
      b4:	562000ef          	jal	616 <exit>
  }
  if (open(ff, O_RDONLY) != -1) {
      b8:	4581                	li	a1,0
      ba:	fd843503          	ld	a0,-40(s0)
      be:	598000ef          	jal	656 <open>
      c2:	87aa                	mv	a5,a0
      c4:	873e                	mv	a4,a5
      c6:	57fd                	li	a5,-1
      c8:	00f70d63          	beq	a4,a5,e2 <main+0xe2>
    printf("%s: open successed\n", s);
      cc:	fe043583          	ld	a1,-32(s0)
      d0:	00001517          	auipc	a0,0x1
      d4:	fe850513          	addi	a0,a0,-24 # 10b8 <malloc+0x19e>
      d8:	45b000ef          	jal	d32 <printf>
    exit(1);
      dc:	4505                	li	a0,1
      de:	538000ef          	jal	616 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
      e2:	fc442783          	lw	a5,-60(s0)
      e6:	85be                	mv	a1,a5
      e8:	00001517          	auipc	a0,0x1
      ec:	fe850513          	addi	a0,a0,-24 # 10d0 <malloc+0x1b6>
      f0:	443000ef          	jal	d32 <printf>
  // sit around until killed
  for(;;) pause(1000);
      f4:	3e800513          	li	a0,1000
      f8:	5ae000ef          	jal	6a6 <pause>
      fc:	bfe5                	j	f4 <main+0xf4>

00000000000000fe <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
      fe:	7179                	addi	sp,sp,-48
     100:	f406                	sd	ra,40(sp)
     102:	f022                	sd	s0,32(sp)
     104:	1800                	addi	s0,sp,48
     106:	87aa                	mv	a5,a0
     108:	fcb43823          	sd	a1,-48(s0)
     10c:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     110:	fdc42783          	lw	a5,-36(s0)
     114:	fd043583          	ld	a1,-48(s0)
     118:	853e                	mv	a0,a5
     11a:	ee7ff0ef          	jal	0 <main>
     11e:	87aa                	mv	a5,a0
     120:	fef42623          	sw	a5,-20(s0)
  exit(r);
     124:	fec42783          	lw	a5,-20(s0)
     128:	853e                	mv	a0,a5
     12a:	4ec000ef          	jal	616 <exit>

000000000000012e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     12e:	7179                	addi	sp,sp,-48
     130:	f406                	sd	ra,40(sp)
     132:	f022                	sd	s0,32(sp)
     134:	1800                	addi	s0,sp,48
     136:	fca43c23          	sd	a0,-40(s0)
     13a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     13e:	fd843783          	ld	a5,-40(s0)
     142:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     146:	0001                	nop
     148:	fd043703          	ld	a4,-48(s0)
     14c:	00170793          	addi	a5,a4,1
     150:	fcf43823          	sd	a5,-48(s0)
     154:	fd843783          	ld	a5,-40(s0)
     158:	00178693          	addi	a3,a5,1
     15c:	fcd43c23          	sd	a3,-40(s0)
     160:	00074703          	lbu	a4,0(a4)
     164:	00e78023          	sb	a4,0(a5)
     168:	0007c783          	lbu	a5,0(a5)
     16c:	fff1                	bnez	a5,148 <strcpy+0x1a>
    ;
  return os;
     16e:	fe843783          	ld	a5,-24(s0)
}
     172:	853e                	mv	a0,a5
     174:	70a2                	ld	ra,40(sp)
     176:	7402                	ld	s0,32(sp)
     178:	6145                	addi	sp,sp,48
     17a:	8082                	ret

000000000000017c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     17c:	1101                	addi	sp,sp,-32
     17e:	ec06                	sd	ra,24(sp)
     180:	e822                	sd	s0,16(sp)
     182:	1000                	addi	s0,sp,32
     184:	fea43423          	sd	a0,-24(s0)
     188:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     18c:	a819                	j	1a2 <strcmp+0x26>
    p++, q++;
     18e:	fe843783          	ld	a5,-24(s0)
     192:	0785                	addi	a5,a5,1
     194:	fef43423          	sd	a5,-24(s0)
     198:	fe043783          	ld	a5,-32(s0)
     19c:	0785                	addi	a5,a5,1
     19e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1a2:	fe843783          	ld	a5,-24(s0)
     1a6:	0007c783          	lbu	a5,0(a5)
     1aa:	cb99                	beqz	a5,1c0 <strcmp+0x44>
     1ac:	fe843783          	ld	a5,-24(s0)
     1b0:	0007c703          	lbu	a4,0(a5)
     1b4:	fe043783          	ld	a5,-32(s0)
     1b8:	0007c783          	lbu	a5,0(a5)
     1bc:	fcf709e3          	beq	a4,a5,18e <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     1c0:	fe843783          	ld	a5,-24(s0)
     1c4:	0007c783          	lbu	a5,0(a5)
     1c8:	0007871b          	sext.w	a4,a5
     1cc:	fe043783          	ld	a5,-32(s0)
     1d0:	0007c783          	lbu	a5,0(a5)
     1d4:	2781                	sext.w	a5,a5
     1d6:	40f707bb          	subw	a5,a4,a5
     1da:	2781                	sext.w	a5,a5
}
     1dc:	853e                	mv	a0,a5
     1de:	60e2                	ld	ra,24(sp)
     1e0:	6442                	ld	s0,16(sp)
     1e2:	6105                	addi	sp,sp,32
     1e4:	8082                	ret

00000000000001e6 <strlen>:

uint
strlen(const char *s)
{
     1e6:	7179                	addi	sp,sp,-48
     1e8:	f406                	sd	ra,40(sp)
     1ea:	f022                	sd	s0,32(sp)
     1ec:	1800                	addi	s0,sp,48
     1ee:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1f2:	fe042623          	sw	zero,-20(s0)
     1f6:	a031                	j	202 <strlen+0x1c>
     1f8:	fec42783          	lw	a5,-20(s0)
     1fc:	2785                	addiw	a5,a5,1
     1fe:	fef42623          	sw	a5,-20(s0)
     202:	fec42783          	lw	a5,-20(s0)
     206:	fd843703          	ld	a4,-40(s0)
     20a:	97ba                	add	a5,a5,a4
     20c:	0007c783          	lbu	a5,0(a5)
     210:	f7e5                	bnez	a5,1f8 <strlen+0x12>
    ;
  return n;
     212:	fec42783          	lw	a5,-20(s0)
}
     216:	853e                	mv	a0,a5
     218:	70a2                	ld	ra,40(sp)
     21a:	7402                	ld	s0,32(sp)
     21c:	6145                	addi	sp,sp,48
     21e:	8082                	ret

0000000000000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
     220:	7179                	addi	sp,sp,-48
     222:	f406                	sd	ra,40(sp)
     224:	f022                	sd	s0,32(sp)
     226:	1800                	addi	s0,sp,48
     228:	fca43c23          	sd	a0,-40(s0)
     22c:	87ae                	mv	a5,a1
     22e:	8732                	mv	a4,a2
     230:	fcf42a23          	sw	a5,-44(s0)
     234:	87ba                	mv	a5,a4
     236:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     23a:	fd843783          	ld	a5,-40(s0)
     23e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     242:	fe042623          	sw	zero,-20(s0)
     246:	a00d                	j	268 <memset+0x48>
    cdst[i] = c;
     248:	fec42783          	lw	a5,-20(s0)
     24c:	fe043703          	ld	a4,-32(s0)
     250:	97ba                	add	a5,a5,a4
     252:	fd442703          	lw	a4,-44(s0)
     256:	0ff77713          	zext.b	a4,a4
     25a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     25e:	fec42783          	lw	a5,-20(s0)
     262:	2785                	addiw	a5,a5,1
     264:	fef42623          	sw	a5,-20(s0)
     268:	fec42783          	lw	a5,-20(s0)
     26c:	fd042703          	lw	a4,-48(s0)
     270:	2701                	sext.w	a4,a4
     272:	fce7ebe3          	bltu	a5,a4,248 <memset+0x28>
  }
  return dst;
     276:	fd843783          	ld	a5,-40(s0)
}
     27a:	853e                	mv	a0,a5
     27c:	70a2                	ld	ra,40(sp)
     27e:	7402                	ld	s0,32(sp)
     280:	6145                	addi	sp,sp,48
     282:	8082                	ret

0000000000000284 <strchr>:

char*
strchr(const char *s, char c)
{
     284:	1101                	addi	sp,sp,-32
     286:	ec06                	sd	ra,24(sp)
     288:	e822                	sd	s0,16(sp)
     28a:	1000                	addi	s0,sp,32
     28c:	fea43423          	sd	a0,-24(s0)
     290:	87ae                	mv	a5,a1
     292:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     296:	a01d                	j	2bc <strchr+0x38>
    if(*s == c)
     298:	fe843783          	ld	a5,-24(s0)
     29c:	0007c703          	lbu	a4,0(a5)
     2a0:	fe744783          	lbu	a5,-25(s0)
     2a4:	0ff7f793          	zext.b	a5,a5
     2a8:	00e79563          	bne	a5,a4,2b2 <strchr+0x2e>
      return (char*)s;
     2ac:	fe843783          	ld	a5,-24(s0)
     2b0:	a821                	j	2c8 <strchr+0x44>
  for(; *s; s++)
     2b2:	fe843783          	ld	a5,-24(s0)
     2b6:	0785                	addi	a5,a5,1
     2b8:	fef43423          	sd	a5,-24(s0)
     2bc:	fe843783          	ld	a5,-24(s0)
     2c0:	0007c783          	lbu	a5,0(a5)
     2c4:	fbf1                	bnez	a5,298 <strchr+0x14>
  return 0;
     2c6:	4781                	li	a5,0
}
     2c8:	853e                	mv	a0,a5
     2ca:	60e2                	ld	ra,24(sp)
     2cc:	6442                	ld	s0,16(sp)
     2ce:	6105                	addi	sp,sp,32
     2d0:	8082                	ret

00000000000002d2 <gets>:

char*
gets(char *buf, int max)
{
     2d2:	7179                	addi	sp,sp,-48
     2d4:	f406                	sd	ra,40(sp)
     2d6:	f022                	sd	s0,32(sp)
     2d8:	1800                	addi	s0,sp,48
     2da:	fca43c23          	sd	a0,-40(s0)
     2de:	87ae                	mv	a5,a1
     2e0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2e4:	fe042623          	sw	zero,-20(s0)
     2e8:	a891                	j	33c <gets+0x6a>
    cc = read(0, &c, 1);
     2ea:	fe740793          	addi	a5,s0,-25
     2ee:	4605                	li	a2,1
     2f0:	85be                	mv	a1,a5
     2f2:	4501                	li	a0,0
     2f4:	33a000ef          	jal	62e <read>
     2f8:	87aa                	mv	a5,a0
     2fa:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2fe:	fe842783          	lw	a5,-24(s0)
     302:	2781                	sext.w	a5,a5
     304:	04f05663          	blez	a5,350 <gets+0x7e>
      break;
    buf[i++] = c;
     308:	fec42783          	lw	a5,-20(s0)
     30c:	0017871b          	addiw	a4,a5,1
     310:	fee42623          	sw	a4,-20(s0)
     314:	873e                	mv	a4,a5
     316:	fd843783          	ld	a5,-40(s0)
     31a:	97ba                	add	a5,a5,a4
     31c:	fe744703          	lbu	a4,-25(s0)
     320:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     324:	fe744783          	lbu	a5,-25(s0)
     328:	873e                	mv	a4,a5
     32a:	47a9                	li	a5,10
     32c:	02f70363          	beq	a4,a5,352 <gets+0x80>
     330:	fe744783          	lbu	a5,-25(s0)
     334:	873e                	mv	a4,a5
     336:	47b5                	li	a5,13
     338:	00f70d63          	beq	a4,a5,352 <gets+0x80>
  for(i=0; i+1 < max; ){
     33c:	fec42783          	lw	a5,-20(s0)
     340:	2785                	addiw	a5,a5,1
     342:	2781                	sext.w	a5,a5
     344:	fd442703          	lw	a4,-44(s0)
     348:	2701                	sext.w	a4,a4
     34a:	fae7c0e3          	blt	a5,a4,2ea <gets+0x18>
     34e:	a011                	j	352 <gets+0x80>
      break;
     350:	0001                	nop
      break;
  }
  buf[i] = '\0';
     352:	fec42783          	lw	a5,-20(s0)
     356:	fd843703          	ld	a4,-40(s0)
     35a:	97ba                	add	a5,a5,a4
     35c:	00078023          	sb	zero,0(a5)
  return buf;
     360:	fd843783          	ld	a5,-40(s0)
}
     364:	853e                	mv	a0,a5
     366:	70a2                	ld	ra,40(sp)
     368:	7402                	ld	s0,32(sp)
     36a:	6145                	addi	sp,sp,48
     36c:	8082                	ret

000000000000036e <stat>:

int
stat(const char *n, struct stat *st)
{
     36e:	7179                	addi	sp,sp,-48
     370:	f406                	sd	ra,40(sp)
     372:	f022                	sd	s0,32(sp)
     374:	1800                	addi	s0,sp,48
     376:	fca43c23          	sd	a0,-40(s0)
     37a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     37e:	4581                	li	a1,0
     380:	fd843503          	ld	a0,-40(s0)
     384:	2d2000ef          	jal	656 <open>
     388:	87aa                	mv	a5,a0
     38a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     38e:	fec42783          	lw	a5,-20(s0)
     392:	2781                	sext.w	a5,a5
     394:	0007d463          	bgez	a5,39c <stat+0x2e>
    return -1;
     398:	57fd                	li	a5,-1
     39a:	a015                	j	3be <stat+0x50>
  r = fstat(fd, st);
     39c:	fec42783          	lw	a5,-20(s0)
     3a0:	fd043583          	ld	a1,-48(s0)
     3a4:	853e                	mv	a0,a5
     3a6:	2c8000ef          	jal	66e <fstat>
     3aa:	87aa                	mv	a5,a0
     3ac:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3b0:	fec42783          	lw	a5,-20(s0)
     3b4:	853e                	mv	a0,a5
     3b6:	288000ef          	jal	63e <close>
  return r;
     3ba:	fe842783          	lw	a5,-24(s0)
}
     3be:	853e                	mv	a0,a5
     3c0:	70a2                	ld	ra,40(sp)
     3c2:	7402                	ld	s0,32(sp)
     3c4:	6145                	addi	sp,sp,48
     3c6:	8082                	ret

00000000000003c8 <atoi>:

int
atoi(const char *s)
{
     3c8:	7179                	addi	sp,sp,-48
     3ca:	f406                	sd	ra,40(sp)
     3cc:	f022                	sd	s0,32(sp)
     3ce:	1800                	addi	s0,sp,48
     3d0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3d4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3d8:	a81d                	j	40e <atoi+0x46>
    n = n*10 + *s++ - '0';
     3da:	fec42783          	lw	a5,-20(s0)
     3de:	873e                	mv	a4,a5
     3e0:	87ba                	mv	a5,a4
     3e2:	0027979b          	slliw	a5,a5,0x2
     3e6:	9fb9                	addw	a5,a5,a4
     3e8:	0017979b          	slliw	a5,a5,0x1
     3ec:	0007871b          	sext.w	a4,a5
     3f0:	fd843783          	ld	a5,-40(s0)
     3f4:	00178693          	addi	a3,a5,1
     3f8:	fcd43c23          	sd	a3,-40(s0)
     3fc:	0007c783          	lbu	a5,0(a5)
     400:	2781                	sext.w	a5,a5
     402:	9fb9                	addw	a5,a5,a4
     404:	2781                	sext.w	a5,a5
     406:	fd07879b          	addiw	a5,a5,-48
     40a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     40e:	fd843783          	ld	a5,-40(s0)
     412:	0007c783          	lbu	a5,0(a5)
     416:	873e                	mv	a4,a5
     418:	02f00793          	li	a5,47
     41c:	00e7fb63          	bgeu	a5,a4,432 <atoi+0x6a>
     420:	fd843783          	ld	a5,-40(s0)
     424:	0007c783          	lbu	a5,0(a5)
     428:	873e                	mv	a4,a5
     42a:	03900793          	li	a5,57
     42e:	fae7f6e3          	bgeu	a5,a4,3da <atoi+0x12>
  return n;
     432:	fec42783          	lw	a5,-20(s0)
}
     436:	853e                	mv	a0,a5
     438:	70a2                	ld	ra,40(sp)
     43a:	7402                	ld	s0,32(sp)
     43c:	6145                	addi	sp,sp,48
     43e:	8082                	ret

0000000000000440 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     440:	7139                	addi	sp,sp,-64
     442:	fc06                	sd	ra,56(sp)
     444:	f822                	sd	s0,48(sp)
     446:	0080                	addi	s0,sp,64
     448:	fca43c23          	sd	a0,-40(s0)
     44c:	fcb43823          	sd	a1,-48(s0)
     450:	87b2                	mv	a5,a2
     452:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     456:	fd843783          	ld	a5,-40(s0)
     45a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     45e:	fd043783          	ld	a5,-48(s0)
     462:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     466:	fe043703          	ld	a4,-32(s0)
     46a:	fe843783          	ld	a5,-24(s0)
     46e:	02e7fc63          	bgeu	a5,a4,4a6 <memmove+0x66>
    while(n-- > 0)
     472:	a00d                	j	494 <memmove+0x54>
      *dst++ = *src++;
     474:	fe043703          	ld	a4,-32(s0)
     478:	00170793          	addi	a5,a4,1
     47c:	fef43023          	sd	a5,-32(s0)
     480:	fe843783          	ld	a5,-24(s0)
     484:	00178693          	addi	a3,a5,1
     488:	fed43423          	sd	a3,-24(s0)
     48c:	00074703          	lbu	a4,0(a4)
     490:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     494:	fcc42783          	lw	a5,-52(s0)
     498:	fff7871b          	addiw	a4,a5,-1
     49c:	fce42623          	sw	a4,-52(s0)
     4a0:	fcf04ae3          	bgtz	a5,474 <memmove+0x34>
     4a4:	a891                	j	4f8 <memmove+0xb8>
  } else {
    dst += n;
     4a6:	fcc42783          	lw	a5,-52(s0)
     4aa:	fe843703          	ld	a4,-24(s0)
     4ae:	97ba                	add	a5,a5,a4
     4b0:	fef43423          	sd	a5,-24(s0)
    src += n;
     4b4:	fcc42783          	lw	a5,-52(s0)
     4b8:	fe043703          	ld	a4,-32(s0)
     4bc:	97ba                	add	a5,a5,a4
     4be:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     4c2:	a01d                	j	4e8 <memmove+0xa8>
      *--dst = *--src;
     4c4:	fe043783          	ld	a5,-32(s0)
     4c8:	17fd                	addi	a5,a5,-1
     4ca:	fef43023          	sd	a5,-32(s0)
     4ce:	fe843783          	ld	a5,-24(s0)
     4d2:	17fd                	addi	a5,a5,-1
     4d4:	fef43423          	sd	a5,-24(s0)
     4d8:	fe043783          	ld	a5,-32(s0)
     4dc:	0007c703          	lbu	a4,0(a5)
     4e0:	fe843783          	ld	a5,-24(s0)
     4e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4e8:	fcc42783          	lw	a5,-52(s0)
     4ec:	fff7871b          	addiw	a4,a5,-1
     4f0:	fce42623          	sw	a4,-52(s0)
     4f4:	fcf048e3          	bgtz	a5,4c4 <memmove+0x84>
  }
  return vdst;
     4f8:	fd843783          	ld	a5,-40(s0)
}
     4fc:	853e                	mv	a0,a5
     4fe:	70e2                	ld	ra,56(sp)
     500:	7442                	ld	s0,48(sp)
     502:	6121                	addi	sp,sp,64
     504:	8082                	ret

0000000000000506 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     506:	7139                	addi	sp,sp,-64
     508:	fc06                	sd	ra,56(sp)
     50a:	f822                	sd	s0,48(sp)
     50c:	0080                	addi	s0,sp,64
     50e:	fca43c23          	sd	a0,-40(s0)
     512:	fcb43823          	sd	a1,-48(s0)
     516:	87b2                	mv	a5,a2
     518:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     51c:	fd843783          	ld	a5,-40(s0)
     520:	fef43423          	sd	a5,-24(s0)
     524:	fd043783          	ld	a5,-48(s0)
     528:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     52c:	a0a1                	j	574 <memcmp+0x6e>
    if (*p1 != *p2) {
     52e:	fe843783          	ld	a5,-24(s0)
     532:	0007c703          	lbu	a4,0(a5)
     536:	fe043783          	ld	a5,-32(s0)
     53a:	0007c783          	lbu	a5,0(a5)
     53e:	02f70163          	beq	a4,a5,560 <memcmp+0x5a>
      return *p1 - *p2;
     542:	fe843783          	ld	a5,-24(s0)
     546:	0007c783          	lbu	a5,0(a5)
     54a:	0007871b          	sext.w	a4,a5
     54e:	fe043783          	ld	a5,-32(s0)
     552:	0007c783          	lbu	a5,0(a5)
     556:	2781                	sext.w	a5,a5
     558:	40f707bb          	subw	a5,a4,a5
     55c:	2781                	sext.w	a5,a5
     55e:	a01d                	j	584 <memcmp+0x7e>
    }
    p1++;
     560:	fe843783          	ld	a5,-24(s0)
     564:	0785                	addi	a5,a5,1
     566:	fef43423          	sd	a5,-24(s0)
    p2++;
     56a:	fe043783          	ld	a5,-32(s0)
     56e:	0785                	addi	a5,a5,1
     570:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     574:	fcc42783          	lw	a5,-52(s0)
     578:	fff7871b          	addiw	a4,a5,-1
     57c:	fce42623          	sw	a4,-52(s0)
     580:	f7dd                	bnez	a5,52e <memcmp+0x28>
  }
  return 0;
     582:	4781                	li	a5,0
}
     584:	853e                	mv	a0,a5
     586:	70e2                	ld	ra,56(sp)
     588:	7442                	ld	s0,48(sp)
     58a:	6121                	addi	sp,sp,64
     58c:	8082                	ret

000000000000058e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     58e:	7179                	addi	sp,sp,-48
     590:	f406                	sd	ra,40(sp)
     592:	f022                	sd	s0,32(sp)
     594:	1800                	addi	s0,sp,48
     596:	fea43423          	sd	a0,-24(s0)
     59a:	feb43023          	sd	a1,-32(s0)
     59e:	87b2                	mv	a5,a2
     5a0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5a4:	fdc42783          	lw	a5,-36(s0)
     5a8:	863e                	mv	a2,a5
     5aa:	fe043583          	ld	a1,-32(s0)
     5ae:	fe843503          	ld	a0,-24(s0)
     5b2:	e8fff0ef          	jal	440 <memmove>
     5b6:	87aa                	mv	a5,a0
}
     5b8:	853e                	mv	a0,a5
     5ba:	70a2                	ld	ra,40(sp)
     5bc:	7402                	ld	s0,32(sp)
     5be:	6145                	addi	sp,sp,48
     5c0:	8082                	ret

00000000000005c2 <sbrk>:

char *
sbrk(int n) {
     5c2:	1101                	addi	sp,sp,-32
     5c4:	ec06                	sd	ra,24(sp)
     5c6:	e822                	sd	s0,16(sp)
     5c8:	1000                	addi	s0,sp,32
     5ca:	87aa                	mv	a5,a0
     5cc:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     5d0:	fec42783          	lw	a5,-20(s0)
     5d4:	4585                	li	a1,1
     5d6:	853e                	mv	a0,a5
     5d8:	0c6000ef          	jal	69e <sys_sbrk>
     5dc:	87aa                	mv	a5,a0
}
     5de:	853e                	mv	a0,a5
     5e0:	60e2                	ld	ra,24(sp)
     5e2:	6442                	ld	s0,16(sp)
     5e4:	6105                	addi	sp,sp,32
     5e6:	8082                	ret

00000000000005e8 <sbrklazy>:

char *
sbrklazy(int n) {
     5e8:	1101                	addi	sp,sp,-32
     5ea:	ec06                	sd	ra,24(sp)
     5ec:	e822                	sd	s0,16(sp)
     5ee:	1000                	addi	s0,sp,32
     5f0:	87aa                	mv	a5,a0
     5f2:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     5f6:	fec42783          	lw	a5,-20(s0)
     5fa:	4589                	li	a1,2
     5fc:	853e                	mv	a0,a5
     5fe:	0a0000ef          	jal	69e <sys_sbrk>
     602:	87aa                	mv	a5,a0
}
     604:	853e                	mv	a0,a5
     606:	60e2                	ld	ra,24(sp)
     608:	6442                	ld	s0,16(sp)
     60a:	6105                	addi	sp,sp,32
     60c:	8082                	ret

000000000000060e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     60e:	4885                	li	a7,1
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <exit>:
.global exit
exit:
 li a7, SYS_exit
     616:	4889                	li	a7,2
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <wait>:
.global wait
wait:
 li a7, SYS_wait
     61e:	488d                	li	a7,3
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     626:	4891                	li	a7,4
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <read>:
.global read
read:
 li a7, SYS_read
     62e:	4895                	li	a7,5
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <write>:
.global write
write:
 li a7, SYS_write
     636:	48c1                	li	a7,16
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <close>:
.global close
close:
 li a7, SYS_close
     63e:	48d5                	li	a7,21
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <kill>:
.global kill
kill:
 li a7, SYS_kill
     646:	4899                	li	a7,6
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <exec>:
.global exec
exec:
 li a7, SYS_exec
     64e:	489d                	li	a7,7
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <open>:
.global open
open:
 li a7, SYS_open
     656:	48bd                	li	a7,15
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     65e:	48c5                	li	a7,17
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     666:	48c9                	li	a7,18
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     66e:	48a1                	li	a7,8
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <link>:
.global link
link:
 li a7, SYS_link
     676:	48cd                	li	a7,19
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     67e:	48d1                	li	a7,20
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     686:	48a5                	li	a7,9
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <dup>:
.global dup
dup:
 li a7, SYS_dup
     68e:	48a9                	li	a7,10
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     696:	48ad                	li	a7,11
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     69e:	48b1                	li	a7,12
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <pause>:
.global pause
pause:
 li a7, SYS_pause
     6a6:	48b5                	li	a7,13
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6ae:	48b9                	li	a7,14
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <top>:
.global top
top:
 li a7, SYS_top
     6b6:	48d9                	li	a7,22
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6be:	1101                	addi	sp,sp,-32
     6c0:	ec06                	sd	ra,24(sp)
     6c2:	e822                	sd	s0,16(sp)
     6c4:	1000                	addi	s0,sp,32
     6c6:	87aa                	mv	a5,a0
     6c8:	872e                	mv	a4,a1
     6ca:	fef42623          	sw	a5,-20(s0)
     6ce:	87ba                	mv	a5,a4
     6d0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6d4:	feb40713          	addi	a4,s0,-21
     6d8:	fec42783          	lw	a5,-20(s0)
     6dc:	4605                	li	a2,1
     6de:	85ba                	mv	a1,a4
     6e0:	853e                	mv	a0,a5
     6e2:	f55ff0ef          	jal	636 <write>
}
     6e6:	0001                	nop
     6e8:	60e2                	ld	ra,24(sp)
     6ea:	6442                	ld	s0,16(sp)
     6ec:	6105                	addi	sp,sp,32
     6ee:	8082                	ret

00000000000006f0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     6f0:	711d                	addi	sp,sp,-96
     6f2:	ec86                	sd	ra,88(sp)
     6f4:	e8a2                	sd	s0,80(sp)
     6f6:	1080                	addi	s0,sp,96
     6f8:	87aa                	mv	a5,a0
     6fa:	fab43823          	sd	a1,-80(s0)
     6fe:	8736                	mv	a4,a3
     700:	faf42e23          	sw	a5,-68(s0)
     704:	87b2                	mv	a5,a2
     706:	faf42c23          	sw	a5,-72(s0)
     70a:	87ba                	mv	a5,a4
     70c:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     710:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     714:	fac42783          	lw	a5,-84(s0)
     718:	2781                	sext.w	a5,a5
     71a:	cf99                	beqz	a5,738 <printint+0x48>
     71c:	fb043783          	ld	a5,-80(s0)
     720:	0007dc63          	bgez	a5,738 <printint+0x48>
    neg = 1;
     724:	4785                	li	a5,1
     726:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     72a:	fb043783          	ld	a5,-80(s0)
     72e:	40f007b3          	neg	a5,a5
     732:	fef43023          	sd	a5,-32(s0)
     736:	a029                	j	740 <printint+0x50>
  } else {
    x = xx;
     738:	fb043783          	ld	a5,-80(s0)
     73c:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     740:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     744:	fb842783          	lw	a5,-72(s0)
     748:	fe043703          	ld	a4,-32(s0)
     74c:	02f77733          	remu	a4,a4,a5
     750:	fec42783          	lw	a5,-20(s0)
     754:	0017869b          	addiw	a3,a5,1
     758:	fed42623          	sw	a3,-20(s0)
     75c:	00002697          	auipc	a3,0x2
     760:	8a468693          	addi	a3,a3,-1884 # 2000 <digits>
     764:	9736                	add	a4,a4,a3
     766:	00074703          	lbu	a4,0(a4)
     76a:	17c1                	addi	a5,a5,-16
     76c:	97a2                	add	a5,a5,s0
     76e:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     772:	fb842783          	lw	a5,-72(s0)
     776:	fe043703          	ld	a4,-32(s0)
     77a:	02f757b3          	divu	a5,a4,a5
     77e:	fef43023          	sd	a5,-32(s0)
     782:	fe043783          	ld	a5,-32(s0)
     786:	ffdd                	bnez	a5,744 <printint+0x54>
  if(neg)
     788:	fe842783          	lw	a5,-24(s0)
     78c:	2781                	sext.w	a5,a5
     78e:	cb95                	beqz	a5,7c2 <printint+0xd2>
    buf[i++] = '-';
     790:	fec42783          	lw	a5,-20(s0)
     794:	0017871b          	addiw	a4,a5,1
     798:	fee42623          	sw	a4,-20(s0)
     79c:	17c1                	addi	a5,a5,-16
     79e:	97a2                	add	a5,a5,s0
     7a0:	02d00713          	li	a4,45
     7a4:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     7a8:	a829                	j	7c2 <printint+0xd2>
    putc(fd, buf[i]);
     7aa:	fec42783          	lw	a5,-20(s0)
     7ae:	17c1                	addi	a5,a5,-16
     7b0:	97a2                	add	a5,a5,s0
     7b2:	fd87c703          	lbu	a4,-40(a5)
     7b6:	fbc42783          	lw	a5,-68(s0)
     7ba:	85ba                	mv	a1,a4
     7bc:	853e                	mv	a0,a5
     7be:	f01ff0ef          	jal	6be <putc>
  while(--i >= 0)
     7c2:	fec42783          	lw	a5,-20(s0)
     7c6:	37fd                	addiw	a5,a5,-1
     7c8:	fef42623          	sw	a5,-20(s0)
     7cc:	fec42783          	lw	a5,-20(s0)
     7d0:	2781                	sext.w	a5,a5
     7d2:	fc07dce3          	bgez	a5,7aa <printint+0xba>
}
     7d6:	0001                	nop
     7d8:	0001                	nop
     7da:	60e6                	ld	ra,88(sp)
     7dc:	6446                	ld	s0,80(sp)
     7de:	6125                	addi	sp,sp,96
     7e0:	8082                	ret

00000000000007e2 <printptr>:

static void
printptr(int fd, uint64 x) {
     7e2:	7179                	addi	sp,sp,-48
     7e4:	f406                	sd	ra,40(sp)
     7e6:	f022                	sd	s0,32(sp)
     7e8:	1800                	addi	s0,sp,48
     7ea:	87aa                	mv	a5,a0
     7ec:	fcb43823          	sd	a1,-48(s0)
     7f0:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7f4:	fdc42783          	lw	a5,-36(s0)
     7f8:	03000593          	li	a1,48
     7fc:	853e                	mv	a0,a5
     7fe:	ec1ff0ef          	jal	6be <putc>
  putc(fd, 'x');
     802:	fdc42783          	lw	a5,-36(s0)
     806:	07800593          	li	a1,120
     80a:	853e                	mv	a0,a5
     80c:	eb3ff0ef          	jal	6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     810:	fe042623          	sw	zero,-20(s0)
     814:	a81d                	j	84a <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     816:	fd043783          	ld	a5,-48(s0)
     81a:	93f1                	srli	a5,a5,0x3c
     81c:	00001717          	auipc	a4,0x1
     820:	7e470713          	addi	a4,a4,2020 # 2000 <digits>
     824:	97ba                	add	a5,a5,a4
     826:	0007c703          	lbu	a4,0(a5)
     82a:	fdc42783          	lw	a5,-36(s0)
     82e:	85ba                	mv	a1,a4
     830:	853e                	mv	a0,a5
     832:	e8dff0ef          	jal	6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     836:	fec42783          	lw	a5,-20(s0)
     83a:	2785                	addiw	a5,a5,1
     83c:	fef42623          	sw	a5,-20(s0)
     840:	fd043783          	ld	a5,-48(s0)
     844:	0792                	slli	a5,a5,0x4
     846:	fcf43823          	sd	a5,-48(s0)
     84a:	fec42703          	lw	a4,-20(s0)
     84e:	47bd                	li	a5,15
     850:	fce7f3e3          	bgeu	a5,a4,816 <printptr+0x34>
}
     854:	0001                	nop
     856:	0001                	nop
     858:	70a2                	ld	ra,40(sp)
     85a:	7402                	ld	s0,32(sp)
     85c:	6145                	addi	sp,sp,48
     85e:	8082                	ret

0000000000000860 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     860:	715d                	addi	sp,sp,-80
     862:	e486                	sd	ra,72(sp)
     864:	e0a2                	sd	s0,64(sp)
     866:	0880                	addi	s0,sp,80
     868:	87aa                	mv	a5,a0
     86a:	fcb43023          	sd	a1,-64(s0)
     86e:	fac43c23          	sd	a2,-72(s0)
     872:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     876:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     87a:	fc042e23          	sw	zero,-36(s0)
     87e:	a189                	j	cc0 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     880:	fdc42783          	lw	a5,-36(s0)
     884:	fc043703          	ld	a4,-64(s0)
     888:	97ba                	add	a5,a5,a4
     88a:	0007c783          	lbu	a5,0(a5)
     88e:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     892:	fd842783          	lw	a5,-40(s0)
     896:	2781                	sext.w	a5,a5
     898:	eb8d                	bnez	a5,8ca <vprintf+0x6a>
      if(c0 == '%'){
     89a:	fd442783          	lw	a5,-44(s0)
     89e:	0007871b          	sext.w	a4,a5
     8a2:	02500793          	li	a5,37
     8a6:	00f71763          	bne	a4,a5,8b4 <vprintf+0x54>
        state = '%';
     8aa:	02500793          	li	a5,37
     8ae:	fcf42c23          	sw	a5,-40(s0)
     8b2:	a111                	j	cb6 <vprintf+0x456>
      } else {
        putc(fd, c0);
     8b4:	fd442783          	lw	a5,-44(s0)
     8b8:	0ff7f713          	zext.b	a4,a5
     8bc:	fcc42783          	lw	a5,-52(s0)
     8c0:	85ba                	mv	a1,a4
     8c2:	853e                	mv	a0,a5
     8c4:	dfbff0ef          	jal	6be <putc>
     8c8:	a6fd                	j	cb6 <vprintf+0x456>
      }
    } else if(state == '%'){
     8ca:	fd842783          	lw	a5,-40(s0)
     8ce:	0007871b          	sext.w	a4,a5
     8d2:	02500793          	li	a5,37
     8d6:	3ef71063          	bne	a4,a5,cb6 <vprintf+0x456>
      c1 = c2 = 0;
     8da:	fe042023          	sw	zero,-32(s0)
     8de:	fe042783          	lw	a5,-32(s0)
     8e2:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     8e6:	fd442783          	lw	a5,-44(s0)
     8ea:	2781                	sext.w	a5,a5
     8ec:	cb99                	beqz	a5,902 <vprintf+0xa2>
     8ee:	fdc42783          	lw	a5,-36(s0)
     8f2:	0785                	addi	a5,a5,1
     8f4:	fc043703          	ld	a4,-64(s0)
     8f8:	97ba                	add	a5,a5,a4
     8fa:	0007c783          	lbu	a5,0(a5)
     8fe:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     902:	fe442783          	lw	a5,-28(s0)
     906:	2781                	sext.w	a5,a5
     908:	cb99                	beqz	a5,91e <vprintf+0xbe>
     90a:	fdc42783          	lw	a5,-36(s0)
     90e:	0789                	addi	a5,a5,2
     910:	fc043703          	ld	a4,-64(s0)
     914:	97ba                	add	a5,a5,a4
     916:	0007c783          	lbu	a5,0(a5)
     91a:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     91e:	fd442783          	lw	a5,-44(s0)
     922:	0007871b          	sext.w	a4,a5
     926:	06400793          	li	a5,100
     92a:	02f71363          	bne	a4,a5,950 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     92e:	fb843783          	ld	a5,-72(s0)
     932:	00878713          	addi	a4,a5,8
     936:	fae43c23          	sd	a4,-72(s0)
     93a:	439c                	lw	a5,0(a5)
     93c:	873e                	mv	a4,a5
     93e:	fcc42783          	lw	a5,-52(s0)
     942:	4685                	li	a3,1
     944:	4629                	li	a2,10
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	da7ff0ef          	jal	6f0 <printint>
     94e:	a695                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     950:	fd442783          	lw	a5,-44(s0)
     954:	0007871b          	sext.w	a4,a5
     958:	06c00793          	li	a5,108
     95c:	04f71063          	bne	a4,a5,99c <vprintf+0x13c>
     960:	fe442783          	lw	a5,-28(s0)
     964:	0007871b          	sext.w	a4,a5
     968:	06400793          	li	a5,100
     96c:	02f71863          	bne	a4,a5,99c <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     970:	fb843783          	ld	a5,-72(s0)
     974:	00878713          	addi	a4,a5,8
     978:	fae43c23          	sd	a4,-72(s0)
     97c:	639c                	ld	a5,0(a5)
     97e:	873e                	mv	a4,a5
     980:	fcc42783          	lw	a5,-52(s0)
     984:	4685                	li	a3,1
     986:	4629                	li	a2,10
     988:	85ba                	mv	a1,a4
     98a:	853e                	mv	a0,a5
     98c:	d65ff0ef          	jal	6f0 <printint>
        i += 1;
     990:	fdc42783          	lw	a5,-36(s0)
     994:	2785                	addiw	a5,a5,1
     996:	fcf42e23          	sw	a5,-36(s0)
     99a:	ae21                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     99c:	fd442783          	lw	a5,-44(s0)
     9a0:	0007871b          	sext.w	a4,a5
     9a4:	06c00793          	li	a5,108
     9a8:	04f71863          	bne	a4,a5,9f8 <vprintf+0x198>
     9ac:	fe442783          	lw	a5,-28(s0)
     9b0:	0007871b          	sext.w	a4,a5
     9b4:	06c00793          	li	a5,108
     9b8:	04f71063          	bne	a4,a5,9f8 <vprintf+0x198>
     9bc:	fe042783          	lw	a5,-32(s0)
     9c0:	0007871b          	sext.w	a4,a5
     9c4:	06400793          	li	a5,100
     9c8:	02f71863          	bne	a4,a5,9f8 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9cc:	fb843783          	ld	a5,-72(s0)
     9d0:	00878713          	addi	a4,a5,8
     9d4:	fae43c23          	sd	a4,-72(s0)
     9d8:	639c                	ld	a5,0(a5)
     9da:	873e                	mv	a4,a5
     9dc:	fcc42783          	lw	a5,-52(s0)
     9e0:	4685                	li	a3,1
     9e2:	4629                	li	a2,10
     9e4:	85ba                	mv	a1,a4
     9e6:	853e                	mv	a0,a5
     9e8:	d09ff0ef          	jal	6f0 <printint>
        i += 2;
     9ec:	fdc42783          	lw	a5,-36(s0)
     9f0:	2789                	addiw	a5,a5,2
     9f2:	fcf42e23          	sw	a5,-36(s0)
     9f6:	ac75                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'u'){
     9f8:	fd442783          	lw	a5,-44(s0)
     9fc:	0007871b          	sext.w	a4,a5
     a00:	07500793          	li	a5,117
     a04:	02f71563          	bne	a4,a5,a2e <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a08:	fb843783          	ld	a5,-72(s0)
     a0c:	00878713          	addi	a4,a5,8
     a10:	fae43c23          	sd	a4,-72(s0)
     a14:	439c                	lw	a5,0(a5)
     a16:	02079713          	slli	a4,a5,0x20
     a1a:	9301                	srli	a4,a4,0x20
     a1c:	fcc42783          	lw	a5,-52(s0)
     a20:	4681                	li	a3,0
     a22:	4629                	li	a2,10
     a24:	85ba                	mv	a1,a4
     a26:	853e                	mv	a0,a5
     a28:	cc9ff0ef          	jal	6f0 <printint>
     a2c:	a459                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a2e:	fd442783          	lw	a5,-44(s0)
     a32:	0007871b          	sext.w	a4,a5
     a36:	06c00793          	li	a5,108
     a3a:	04f71063          	bne	a4,a5,a7a <vprintf+0x21a>
     a3e:	fe442783          	lw	a5,-28(s0)
     a42:	0007871b          	sext.w	a4,a5
     a46:	07500793          	li	a5,117
     a4a:	02f71863          	bne	a4,a5,a7a <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a4e:	fb843783          	ld	a5,-72(s0)
     a52:	00878713          	addi	a4,a5,8
     a56:	fae43c23          	sd	a4,-72(s0)
     a5a:	639c                	ld	a5,0(a5)
     a5c:	873e                	mv	a4,a5
     a5e:	fcc42783          	lw	a5,-52(s0)
     a62:	4681                	li	a3,0
     a64:	4629                	li	a2,10
     a66:	85ba                	mv	a1,a4
     a68:	853e                	mv	a0,a5
     a6a:	c87ff0ef          	jal	6f0 <printint>
        i += 1;
     a6e:	fdc42783          	lw	a5,-36(s0)
     a72:	2785                	addiw	a5,a5,1
     a74:	fcf42e23          	sw	a5,-36(s0)
     a78:	ac2d                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     a7a:	fd442783          	lw	a5,-44(s0)
     a7e:	0007871b          	sext.w	a4,a5
     a82:	06c00793          	li	a5,108
     a86:	04f71863          	bne	a4,a5,ad6 <vprintf+0x276>
     a8a:	fe442783          	lw	a5,-28(s0)
     a8e:	0007871b          	sext.w	a4,a5
     a92:	06c00793          	li	a5,108
     a96:	04f71063          	bne	a4,a5,ad6 <vprintf+0x276>
     a9a:	fe042783          	lw	a5,-32(s0)
     a9e:	0007871b          	sext.w	a4,a5
     aa2:	07500793          	li	a5,117
     aa6:	02f71863          	bne	a4,a5,ad6 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     aaa:	fb843783          	ld	a5,-72(s0)
     aae:	00878713          	addi	a4,a5,8
     ab2:	fae43c23          	sd	a4,-72(s0)
     ab6:	639c                	ld	a5,0(a5)
     ab8:	873e                	mv	a4,a5
     aba:	fcc42783          	lw	a5,-52(s0)
     abe:	4681                	li	a3,0
     ac0:	4629                	li	a2,10
     ac2:	85ba                	mv	a1,a4
     ac4:	853e                	mv	a0,a5
     ac6:	c2bff0ef          	jal	6f0 <printint>
        i += 2;
     aca:	fdc42783          	lw	a5,-36(s0)
     ace:	2789                	addiw	a5,a5,2
     ad0:	fcf42e23          	sw	a5,-36(s0)
     ad4:	aaf9                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'x'){
     ad6:	fd442783          	lw	a5,-44(s0)
     ada:	0007871b          	sext.w	a4,a5
     ade:	07800793          	li	a5,120
     ae2:	02f71563          	bne	a4,a5,b0c <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     ae6:	fb843783          	ld	a5,-72(s0)
     aea:	00878713          	addi	a4,a5,8
     aee:	fae43c23          	sd	a4,-72(s0)
     af2:	439c                	lw	a5,0(a5)
     af4:	02079713          	slli	a4,a5,0x20
     af8:	9301                	srli	a4,a4,0x20
     afa:	fcc42783          	lw	a5,-52(s0)
     afe:	4681                	li	a3,0
     b00:	4641                	li	a2,16
     b02:	85ba                	mv	a1,a4
     b04:	853e                	mv	a0,a5
     b06:	bebff0ef          	jal	6f0 <printint>
     b0a:	a265                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b0c:	fd442783          	lw	a5,-44(s0)
     b10:	0007871b          	sext.w	a4,a5
     b14:	06c00793          	li	a5,108
     b18:	04f71063          	bne	a4,a5,b58 <vprintf+0x2f8>
     b1c:	fe442783          	lw	a5,-28(s0)
     b20:	0007871b          	sext.w	a4,a5
     b24:	07800793          	li	a5,120
     b28:	02f71863          	bne	a4,a5,b58 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b2c:	fb843783          	ld	a5,-72(s0)
     b30:	00878713          	addi	a4,a5,8
     b34:	fae43c23          	sd	a4,-72(s0)
     b38:	639c                	ld	a5,0(a5)
     b3a:	873e                	mv	a4,a5
     b3c:	fcc42783          	lw	a5,-52(s0)
     b40:	4681                	li	a3,0
     b42:	4641                	li	a2,16
     b44:	85ba                	mv	a1,a4
     b46:	853e                	mv	a0,a5
     b48:	ba9ff0ef          	jal	6f0 <printint>
        i += 1;
     b4c:	fdc42783          	lw	a5,-36(s0)
     b50:	2785                	addiw	a5,a5,1
     b52:	fcf42e23          	sw	a5,-36(s0)
     b56:	aab1                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     b58:	fd442783          	lw	a5,-44(s0)
     b5c:	0007871b          	sext.w	a4,a5
     b60:	06c00793          	li	a5,108
     b64:	04f71863          	bne	a4,a5,bb4 <vprintf+0x354>
     b68:	fe442783          	lw	a5,-28(s0)
     b6c:	0007871b          	sext.w	a4,a5
     b70:	06c00793          	li	a5,108
     b74:	04f71063          	bne	a4,a5,bb4 <vprintf+0x354>
     b78:	fe042783          	lw	a5,-32(s0)
     b7c:	0007871b          	sext.w	a4,a5
     b80:	07800793          	li	a5,120
     b84:	02f71863          	bne	a4,a5,bb4 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b88:	fb843783          	ld	a5,-72(s0)
     b8c:	00878713          	addi	a4,a5,8
     b90:	fae43c23          	sd	a4,-72(s0)
     b94:	639c                	ld	a5,0(a5)
     b96:	873e                	mv	a4,a5
     b98:	fcc42783          	lw	a5,-52(s0)
     b9c:	4681                	li	a3,0
     b9e:	4641                	li	a2,16
     ba0:	85ba                	mv	a1,a4
     ba2:	853e                	mv	a0,a5
     ba4:	b4dff0ef          	jal	6f0 <printint>
        i += 2;
     ba8:	fdc42783          	lw	a5,-36(s0)
     bac:	2789                	addiw	a5,a5,2
     bae:	fcf42e23          	sw	a5,-36(s0)
     bb2:	a201                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'p'){
     bb4:	fd442783          	lw	a5,-44(s0)
     bb8:	0007871b          	sext.w	a4,a5
     bbc:	07000793          	li	a5,112
     bc0:	02f71063          	bne	a4,a5,be0 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     bc4:	fb843783          	ld	a5,-72(s0)
     bc8:	00878713          	addi	a4,a5,8
     bcc:	fae43c23          	sd	a4,-72(s0)
     bd0:	6398                	ld	a4,0(a5)
     bd2:	fcc42783          	lw	a5,-52(s0)
     bd6:	85ba                	mv	a1,a4
     bd8:	853e                	mv	a0,a5
     bda:	c09ff0ef          	jal	7e2 <printptr>
     bde:	a8d1                	j	cb2 <vprintf+0x452>
      } else if(c0 == 'c'){
     be0:	fd442783          	lw	a5,-44(s0)
     be4:	0007871b          	sext.w	a4,a5
     be8:	06300793          	li	a5,99
     bec:	02f71263          	bne	a4,a5,c10 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     bf0:	fb843783          	ld	a5,-72(s0)
     bf4:	00878713          	addi	a4,a5,8
     bf8:	fae43c23          	sd	a4,-72(s0)
     bfc:	439c                	lw	a5,0(a5)
     bfe:	0ff7f713          	zext.b	a4,a5
     c02:	fcc42783          	lw	a5,-52(s0)
     c06:	85ba                	mv	a1,a4
     c08:	853e                	mv	a0,a5
     c0a:	ab5ff0ef          	jal	6be <putc>
     c0e:	a055                	j	cb2 <vprintf+0x452>
      } else if(c0 == 's'){
     c10:	fd442783          	lw	a5,-44(s0)
     c14:	0007871b          	sext.w	a4,a5
     c18:	07300793          	li	a5,115
     c1c:	04f71a63          	bne	a4,a5,c70 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c20:	fb843783          	ld	a5,-72(s0)
     c24:	00878713          	addi	a4,a5,8
     c28:	fae43c23          	sd	a4,-72(s0)
     c2c:	639c                	ld	a5,0(a5)
     c2e:	fef43423          	sd	a5,-24(s0)
     c32:	fe843783          	ld	a5,-24(s0)
     c36:	e79d                	bnez	a5,c64 <vprintf+0x404>
          s = "(null)";
     c38:	00000797          	auipc	a5,0x0
     c3c:	4b878793          	addi	a5,a5,1208 # 10f0 <malloc+0x1d6>
     c40:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c44:	a005                	j	c64 <vprintf+0x404>
          putc(fd, *s);
     c46:	fe843783          	ld	a5,-24(s0)
     c4a:	0007c703          	lbu	a4,0(a5)
     c4e:	fcc42783          	lw	a5,-52(s0)
     c52:	85ba                	mv	a1,a4
     c54:	853e                	mv	a0,a5
     c56:	a69ff0ef          	jal	6be <putc>
        for(; *s; s++)
     c5a:	fe843783          	ld	a5,-24(s0)
     c5e:	0785                	addi	a5,a5,1
     c60:	fef43423          	sd	a5,-24(s0)
     c64:	fe843783          	ld	a5,-24(s0)
     c68:	0007c783          	lbu	a5,0(a5)
     c6c:	ffe9                	bnez	a5,c46 <vprintf+0x3e6>
     c6e:	a091                	j	cb2 <vprintf+0x452>
      } else if(c0 == '%'){
     c70:	fd442783          	lw	a5,-44(s0)
     c74:	0007871b          	sext.w	a4,a5
     c78:	02500793          	li	a5,37
     c7c:	00f71a63          	bne	a4,a5,c90 <vprintf+0x430>
        putc(fd, '%');
     c80:	fcc42783          	lw	a5,-52(s0)
     c84:	02500593          	li	a1,37
     c88:	853e                	mv	a0,a5
     c8a:	a35ff0ef          	jal	6be <putc>
     c8e:	a015                	j	cb2 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c90:	fcc42783          	lw	a5,-52(s0)
     c94:	02500593          	li	a1,37
     c98:	853e                	mv	a0,a5
     c9a:	a25ff0ef          	jal	6be <putc>
        putc(fd, c0);
     c9e:	fd442783          	lw	a5,-44(s0)
     ca2:	0ff7f713          	zext.b	a4,a5
     ca6:	fcc42783          	lw	a5,-52(s0)
     caa:	85ba                	mv	a1,a4
     cac:	853e                	mv	a0,a5
     cae:	a11ff0ef          	jal	6be <putc>
      }

      state = 0;
     cb2:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     cb6:	fdc42783          	lw	a5,-36(s0)
     cba:	2785                	addiw	a5,a5,1
     cbc:	fcf42e23          	sw	a5,-36(s0)
     cc0:	fdc42783          	lw	a5,-36(s0)
     cc4:	fc043703          	ld	a4,-64(s0)
     cc8:	97ba                	add	a5,a5,a4
     cca:	0007c783          	lbu	a5,0(a5)
     cce:	ba0799e3          	bnez	a5,880 <vprintf+0x20>
    }
  }
}
     cd2:	0001                	nop
     cd4:	0001                	nop
     cd6:	60a6                	ld	ra,72(sp)
     cd8:	6406                	ld	s0,64(sp)
     cda:	6161                	addi	sp,sp,80
     cdc:	8082                	ret

0000000000000cde <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     cde:	7159                	addi	sp,sp,-112
     ce0:	fc06                	sd	ra,56(sp)
     ce2:	f822                	sd	s0,48(sp)
     ce4:	0080                	addi	s0,sp,64
     ce6:	fcb43823          	sd	a1,-48(s0)
     cea:	e010                	sd	a2,0(s0)
     cec:	e414                	sd	a3,8(s0)
     cee:	e818                	sd	a4,16(s0)
     cf0:	ec1c                	sd	a5,24(s0)
     cf2:	03043023          	sd	a6,32(s0)
     cf6:	03143423          	sd	a7,40(s0)
     cfa:	87aa                	mv	a5,a0
     cfc:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d00:	03040793          	addi	a5,s0,48
     d04:	fcf43423          	sd	a5,-56(s0)
     d08:	fc843783          	ld	a5,-56(s0)
     d0c:	fd078793          	addi	a5,a5,-48
     d10:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d14:	fe843703          	ld	a4,-24(s0)
     d18:	fdc42783          	lw	a5,-36(s0)
     d1c:	863a                	mv	a2,a4
     d1e:	fd043583          	ld	a1,-48(s0)
     d22:	853e                	mv	a0,a5
     d24:	b3dff0ef          	jal	860 <vprintf>
}
     d28:	0001                	nop
     d2a:	70e2                	ld	ra,56(sp)
     d2c:	7442                	ld	s0,48(sp)
     d2e:	6165                	addi	sp,sp,112
     d30:	8082                	ret

0000000000000d32 <printf>:

void
printf(const char *fmt, ...)
{
     d32:	7159                	addi	sp,sp,-112
     d34:	f406                	sd	ra,40(sp)
     d36:	f022                	sd	s0,32(sp)
     d38:	1800                	addi	s0,sp,48
     d3a:	fca43c23          	sd	a0,-40(s0)
     d3e:	e40c                	sd	a1,8(s0)
     d40:	e810                	sd	a2,16(s0)
     d42:	ec14                	sd	a3,24(s0)
     d44:	f018                	sd	a4,32(s0)
     d46:	f41c                	sd	a5,40(s0)
     d48:	03043823          	sd	a6,48(s0)
     d4c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d50:	04040793          	addi	a5,s0,64
     d54:	fcf43823          	sd	a5,-48(s0)
     d58:	fd043783          	ld	a5,-48(s0)
     d5c:	fc878793          	addi	a5,a5,-56
     d60:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d64:	fe843783          	ld	a5,-24(s0)
     d68:	863e                	mv	a2,a5
     d6a:	fd843583          	ld	a1,-40(s0)
     d6e:	4505                	li	a0,1
     d70:	af1ff0ef          	jal	860 <vprintf>
}
     d74:	0001                	nop
     d76:	70a2                	ld	ra,40(sp)
     d78:	7402                	ld	s0,32(sp)
     d7a:	6165                	addi	sp,sp,112
     d7c:	8082                	ret

0000000000000d7e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d7e:	7179                	addi	sp,sp,-48
     d80:	f406                	sd	ra,40(sp)
     d82:	f022                	sd	s0,32(sp)
     d84:	1800                	addi	s0,sp,48
     d86:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d8a:	fd843783          	ld	a5,-40(s0)
     d8e:	17c1                	addi	a5,a5,-16
     d90:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d94:	00001797          	auipc	a5,0x1
     d98:	49478793          	addi	a5,a5,1172 # 2228 <freep>
     d9c:	639c                	ld	a5,0(a5)
     d9e:	fef43423          	sd	a5,-24(s0)
     da2:	a815                	j	dd6 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     da4:	fe843783          	ld	a5,-24(s0)
     da8:	639c                	ld	a5,0(a5)
     daa:	fe843703          	ld	a4,-24(s0)
     dae:	00f76f63          	bltu	a4,a5,dcc <free+0x4e>
     db2:	fe043703          	ld	a4,-32(s0)
     db6:	fe843783          	ld	a5,-24(s0)
     dba:	02e7eb63          	bltu	a5,a4,df0 <free+0x72>
     dbe:	fe843783          	ld	a5,-24(s0)
     dc2:	639c                	ld	a5,0(a5)
     dc4:	fe043703          	ld	a4,-32(s0)
     dc8:	02f76463          	bltu	a4,a5,df0 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	639c                	ld	a5,0(a5)
     dd2:	fef43423          	sd	a5,-24(s0)
     dd6:	fe043703          	ld	a4,-32(s0)
     dda:	fe843783          	ld	a5,-24(s0)
     dde:	fce7f3e3          	bgeu	a5,a4,da4 <free+0x26>
     de2:	fe843783          	ld	a5,-24(s0)
     de6:	639c                	ld	a5,0(a5)
     de8:	fe043703          	ld	a4,-32(s0)
     dec:	faf77ce3          	bgeu	a4,a5,da4 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     df0:	fe043783          	ld	a5,-32(s0)
     df4:	479c                	lw	a5,8(a5)
     df6:	1782                	slli	a5,a5,0x20
     df8:	9381                	srli	a5,a5,0x20
     dfa:	0792                	slli	a5,a5,0x4
     dfc:	fe043703          	ld	a4,-32(s0)
     e00:	973e                	add	a4,a4,a5
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	639c                	ld	a5,0(a5)
     e08:	02f71763          	bne	a4,a5,e36 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e0c:	fe043783          	ld	a5,-32(s0)
     e10:	4798                	lw	a4,8(a5)
     e12:	fe843783          	ld	a5,-24(s0)
     e16:	639c                	ld	a5,0(a5)
     e18:	479c                	lw	a5,8(a5)
     e1a:	9fb9                	addw	a5,a5,a4
     e1c:	0007871b          	sext.w	a4,a5
     e20:	fe043783          	ld	a5,-32(s0)
     e24:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e26:	fe843783          	ld	a5,-24(s0)
     e2a:	639c                	ld	a5,0(a5)
     e2c:	6398                	ld	a4,0(a5)
     e2e:	fe043783          	ld	a5,-32(s0)
     e32:	e398                	sd	a4,0(a5)
     e34:	a039                	j	e42 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e36:	fe843783          	ld	a5,-24(s0)
     e3a:	6398                	ld	a4,0(a5)
     e3c:	fe043783          	ld	a5,-32(s0)
     e40:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	479c                	lw	a5,8(a5)
     e48:	1782                	slli	a5,a5,0x20
     e4a:	9381                	srli	a5,a5,0x20
     e4c:	0792                	slli	a5,a5,0x4
     e4e:	fe843703          	ld	a4,-24(s0)
     e52:	97ba                	add	a5,a5,a4
     e54:	fe043703          	ld	a4,-32(s0)
     e58:	02f71563          	bne	a4,a5,e82 <free+0x104>
    p->s.size += bp->s.size;
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	4798                	lw	a4,8(a5)
     e62:	fe043783          	ld	a5,-32(s0)
     e66:	479c                	lw	a5,8(a5)
     e68:	9fb9                	addw	a5,a5,a4
     e6a:	0007871b          	sext.w	a4,a5
     e6e:	fe843783          	ld	a5,-24(s0)
     e72:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     e74:	fe043783          	ld	a5,-32(s0)
     e78:	6398                	ld	a4,0(a5)
     e7a:	fe843783          	ld	a5,-24(s0)
     e7e:	e398                	sd	a4,0(a5)
     e80:	a031                	j	e8c <free+0x10e>
  } else
    p->s.ptr = bp;
     e82:	fe843783          	ld	a5,-24(s0)
     e86:	fe043703          	ld	a4,-32(s0)
     e8a:	e398                	sd	a4,0(a5)
  freep = p;
     e8c:	00001797          	auipc	a5,0x1
     e90:	39c78793          	addi	a5,a5,924 # 2228 <freep>
     e94:	fe843703          	ld	a4,-24(s0)
     e98:	e398                	sd	a4,0(a5)
}
     e9a:	0001                	nop
     e9c:	70a2                	ld	ra,40(sp)
     e9e:	7402                	ld	s0,32(sp)
     ea0:	6145                	addi	sp,sp,48
     ea2:	8082                	ret

0000000000000ea4 <morecore>:

static Header*
morecore(uint nu)
{
     ea4:	7179                	addi	sp,sp,-48
     ea6:	f406                	sd	ra,40(sp)
     ea8:	f022                	sd	s0,32(sp)
     eaa:	1800                	addi	s0,sp,48
     eac:	87aa                	mv	a5,a0
     eae:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     eb2:	fdc42783          	lw	a5,-36(s0)
     eb6:	0007871b          	sext.w	a4,a5
     eba:	6785                	lui	a5,0x1
     ebc:	00f77563          	bgeu	a4,a5,ec6 <morecore+0x22>
    nu = 4096;
     ec0:	6785                	lui	a5,0x1
     ec2:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ec6:	fdc42783          	lw	a5,-36(s0)
     eca:	0047979b          	slliw	a5,a5,0x4
     ece:	2781                	sext.w	a5,a5
     ed0:	853e                	mv	a0,a5
     ed2:	ef0ff0ef          	jal	5c2 <sbrk>
     ed6:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     eda:	fe843703          	ld	a4,-24(s0)
     ede:	57fd                	li	a5,-1
     ee0:	00f71463          	bne	a4,a5,ee8 <morecore+0x44>
    return 0;
     ee4:	4781                	li	a5,0
     ee6:	a02d                	j	f10 <morecore+0x6c>
  hp = (Header*)p;
     ee8:	fe843783          	ld	a5,-24(s0)
     eec:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ef0:	fe043783          	ld	a5,-32(s0)
     ef4:	fdc42703          	lw	a4,-36(s0)
     ef8:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     efa:	fe043783          	ld	a5,-32(s0)
     efe:	07c1                	addi	a5,a5,16 # 1010 <malloc+0xf6>
     f00:	853e                	mv	a0,a5
     f02:	e7dff0ef          	jal	d7e <free>
  return freep;
     f06:	00001797          	auipc	a5,0x1
     f0a:	32278793          	addi	a5,a5,802 # 2228 <freep>
     f0e:	639c                	ld	a5,0(a5)
}
     f10:	853e                	mv	a0,a5
     f12:	70a2                	ld	ra,40(sp)
     f14:	7402                	ld	s0,32(sp)
     f16:	6145                	addi	sp,sp,48
     f18:	8082                	ret

0000000000000f1a <malloc>:

void*
malloc(uint nbytes)
{
     f1a:	7139                	addi	sp,sp,-64
     f1c:	fc06                	sd	ra,56(sp)
     f1e:	f822                	sd	s0,48(sp)
     f20:	0080                	addi	s0,sp,64
     f22:	87aa                	mv	a5,a0
     f24:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f28:	fcc46783          	lwu	a5,-52(s0)
     f2c:	07bd                	addi	a5,a5,15
     f2e:	8391                	srli	a5,a5,0x4
     f30:	2781                	sext.w	a5,a5
     f32:	2785                	addiw	a5,a5,1
     f34:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f38:	00001797          	auipc	a5,0x1
     f3c:	2f078793          	addi	a5,a5,752 # 2228 <freep>
     f40:	639c                	ld	a5,0(a5)
     f42:	fef43023          	sd	a5,-32(s0)
     f46:	fe043783          	ld	a5,-32(s0)
     f4a:	ef95                	bnez	a5,f86 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f4c:	00001797          	auipc	a5,0x1
     f50:	2cc78793          	addi	a5,a5,716 # 2218 <base>
     f54:	fef43023          	sd	a5,-32(s0)
     f58:	00001797          	auipc	a5,0x1
     f5c:	2d078793          	addi	a5,a5,720 # 2228 <freep>
     f60:	fe043703          	ld	a4,-32(s0)
     f64:	e398                	sd	a4,0(a5)
     f66:	00001797          	auipc	a5,0x1
     f6a:	2c278793          	addi	a5,a5,706 # 2228 <freep>
     f6e:	6398                	ld	a4,0(a5)
     f70:	00001797          	auipc	a5,0x1
     f74:	2a878793          	addi	a5,a5,680 # 2218 <base>
     f78:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f7a:	00001797          	auipc	a5,0x1
     f7e:	29e78793          	addi	a5,a5,670 # 2218 <base>
     f82:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f86:	fe043783          	ld	a5,-32(s0)
     f8a:	639c                	ld	a5,0(a5)
     f8c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f90:	fe843783          	ld	a5,-24(s0)
     f94:	479c                	lw	a5,8(a5)
     f96:	fdc42703          	lw	a4,-36(s0)
     f9a:	2701                	sext.w	a4,a4
     f9c:	06e7e763          	bltu	a5,a4,100a <malloc+0xf0>
      if(p->s.size == nunits)
     fa0:	fe843783          	ld	a5,-24(s0)
     fa4:	479c                	lw	a5,8(a5)
     fa6:	fdc42703          	lw	a4,-36(s0)
     faa:	2701                	sext.w	a4,a4
     fac:	00f71963          	bne	a4,a5,fbe <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fb0:	fe843783          	ld	a5,-24(s0)
     fb4:	6398                	ld	a4,0(a5)
     fb6:	fe043783          	ld	a5,-32(s0)
     fba:	e398                	sd	a4,0(a5)
     fbc:	a825                	j	ff4 <malloc+0xda>
      else {
        p->s.size -= nunits;
     fbe:	fe843783          	ld	a5,-24(s0)
     fc2:	479c                	lw	a5,8(a5)
     fc4:	fdc42703          	lw	a4,-36(s0)
     fc8:	9f99                	subw	a5,a5,a4
     fca:	0007871b          	sext.w	a4,a5
     fce:	fe843783          	ld	a5,-24(s0)
     fd2:	c798                	sw	a4,8(a5)
        p += p->s.size;
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	479c                	lw	a5,8(a5)
     fda:	1782                	slli	a5,a5,0x20
     fdc:	9381                	srli	a5,a5,0x20
     fde:	0792                	slli	a5,a5,0x4
     fe0:	fe843703          	ld	a4,-24(s0)
     fe4:	97ba                	add	a5,a5,a4
     fe6:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	fdc42703          	lw	a4,-36(s0)
     ff2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ff4:	00001797          	auipc	a5,0x1
     ff8:	23478793          	addi	a5,a5,564 # 2228 <freep>
     ffc:	fe043703          	ld	a4,-32(s0)
    1000:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	07c1                	addi	a5,a5,16
    1008:	a081                	j	1048 <malloc+0x12e>
    }
    if(p == freep)
    100a:	00001797          	auipc	a5,0x1
    100e:	21e78793          	addi	a5,a5,542 # 2228 <freep>
    1012:	639c                	ld	a5,0(a5)
    1014:	fe843703          	ld	a4,-24(s0)
    1018:	00f71e63          	bne	a4,a5,1034 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    101c:	fdc42783          	lw	a5,-36(s0)
    1020:	853e                	mv	a0,a5
    1022:	e83ff0ef          	jal	ea4 <morecore>
    1026:	fea43423          	sd	a0,-24(s0)
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	e399                	bnez	a5,1034 <malloc+0x11a>
        return 0;
    1030:	4781                	li	a5,0
    1032:	a819                	j	1048 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1034:	fe843783          	ld	a5,-24(s0)
    1038:	fef43023          	sd	a5,-32(s0)
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	639c                	ld	a5,0(a5)
    1042:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1046:	b7a9                	j	f90 <malloc+0x76>
  }
}
    1048:	853e                	mv	a0,a5
    104a:	70e2                	ld	ra,56(sp)
    104c:	7442                	ld	s0,48(sp)
    104e:	6121                	addi	sp,sp,64
    1050:	8082                	ret
