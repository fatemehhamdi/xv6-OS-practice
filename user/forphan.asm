
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
      24:	04078793          	addi	a5,a5,64 # 1060 <malloc+0x13e>
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
      50:	01c50513          	addi	a0,a0,28 # 1068 <malloc+0x146>
      54:	4e7000ef          	jal	d3a <printf>
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
      78:	00c68693          	addi	a3,a3,12 # 1080 <malloc+0x15e>
      7c:	fe043603          	ld	a2,-32(s0)
      80:	00001597          	auipc	a1,0x1
      84:	00858593          	addi	a1,a1,8 # 1088 <malloc+0x166>
      88:	4509                	li	a0,2
      8a:	45d000ef          	jal	ce6 <fprintf>
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
      aa:	ffa50513          	addi	a0,a0,-6 # 10a0 <malloc+0x17e>
      ae:	48d000ef          	jal	d3a <printf>
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
      d4:	fe850513          	addi	a0,a0,-24 # 10b8 <malloc+0x196>
      d8:	463000ef          	jal	d3a <printf>
    exit(1);
      dc:	4505                	li	a0,1
      de:	538000ef          	jal	616 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
      e2:	fc442783          	lw	a5,-60(s0)
      e6:	85be                	mv	a1,a5
      e8:	00001517          	auipc	a0,0x1
      ec:	fe850513          	addi	a0,a0,-24 # 10d0 <malloc+0x1ae>
      f0:	44b000ef          	jal	d3a <printf>
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

00000000000006be <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     6be:	48dd                	li	a7,23
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6c6:	1101                	addi	sp,sp,-32
     6c8:	ec06                	sd	ra,24(sp)
     6ca:	e822                	sd	s0,16(sp)
     6cc:	1000                	addi	s0,sp,32
     6ce:	87aa                	mv	a5,a0
     6d0:	872e                	mv	a4,a1
     6d2:	fef42623          	sw	a5,-20(s0)
     6d6:	87ba                	mv	a5,a4
     6d8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6dc:	feb40713          	addi	a4,s0,-21
     6e0:	fec42783          	lw	a5,-20(s0)
     6e4:	4605                	li	a2,1
     6e6:	85ba                	mv	a1,a4
     6e8:	853e                	mv	a0,a5
     6ea:	f4dff0ef          	jal	636 <write>
}
     6ee:	0001                	nop
     6f0:	60e2                	ld	ra,24(sp)
     6f2:	6442                	ld	s0,16(sp)
     6f4:	6105                	addi	sp,sp,32
     6f6:	8082                	ret

00000000000006f8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     6f8:	711d                	addi	sp,sp,-96
     6fa:	ec86                	sd	ra,88(sp)
     6fc:	e8a2                	sd	s0,80(sp)
     6fe:	1080                	addi	s0,sp,96
     700:	87aa                	mv	a5,a0
     702:	fab43823          	sd	a1,-80(s0)
     706:	8736                	mv	a4,a3
     708:	faf42e23          	sw	a5,-68(s0)
     70c:	87b2                	mv	a5,a2
     70e:	faf42c23          	sw	a5,-72(s0)
     712:	87ba                	mv	a5,a4
     714:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     718:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     71c:	fac42783          	lw	a5,-84(s0)
     720:	2781                	sext.w	a5,a5
     722:	cf99                	beqz	a5,740 <printint+0x48>
     724:	fb043783          	ld	a5,-80(s0)
     728:	0007dc63          	bgez	a5,740 <printint+0x48>
    neg = 1;
     72c:	4785                	li	a5,1
     72e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     732:	fb043783          	ld	a5,-80(s0)
     736:	40f007b3          	neg	a5,a5
     73a:	fef43023          	sd	a5,-32(s0)
     73e:	a029                	j	748 <printint+0x50>
  } else {
    x = xx;
     740:	fb043783          	ld	a5,-80(s0)
     744:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     748:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     74c:	fb842783          	lw	a5,-72(s0)
     750:	fe043703          	ld	a4,-32(s0)
     754:	02f77733          	remu	a4,a4,a5
     758:	fec42783          	lw	a5,-20(s0)
     75c:	0017869b          	addiw	a3,a5,1
     760:	fed42623          	sw	a3,-20(s0)
     764:	00002697          	auipc	a3,0x2
     768:	89c68693          	addi	a3,a3,-1892 # 2000 <digits>
     76c:	9736                	add	a4,a4,a3
     76e:	00074703          	lbu	a4,0(a4)
     772:	17c1                	addi	a5,a5,-16
     774:	97a2                	add	a5,a5,s0
     776:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     77a:	fb842783          	lw	a5,-72(s0)
     77e:	fe043703          	ld	a4,-32(s0)
     782:	02f757b3          	divu	a5,a4,a5
     786:	fef43023          	sd	a5,-32(s0)
     78a:	fe043783          	ld	a5,-32(s0)
     78e:	ffdd                	bnez	a5,74c <printint+0x54>
  if(neg)
     790:	fe842783          	lw	a5,-24(s0)
     794:	2781                	sext.w	a5,a5
     796:	cb95                	beqz	a5,7ca <printint+0xd2>
    buf[i++] = '-';
     798:	fec42783          	lw	a5,-20(s0)
     79c:	0017871b          	addiw	a4,a5,1
     7a0:	fee42623          	sw	a4,-20(s0)
     7a4:	17c1                	addi	a5,a5,-16
     7a6:	97a2                	add	a5,a5,s0
     7a8:	02d00713          	li	a4,45
     7ac:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     7b0:	a829                	j	7ca <printint+0xd2>
    putc(fd, buf[i]);
     7b2:	fec42783          	lw	a5,-20(s0)
     7b6:	17c1                	addi	a5,a5,-16
     7b8:	97a2                	add	a5,a5,s0
     7ba:	fd87c703          	lbu	a4,-40(a5)
     7be:	fbc42783          	lw	a5,-68(s0)
     7c2:	85ba                	mv	a1,a4
     7c4:	853e                	mv	a0,a5
     7c6:	f01ff0ef          	jal	6c6 <putc>
  while(--i >= 0)
     7ca:	fec42783          	lw	a5,-20(s0)
     7ce:	37fd                	addiw	a5,a5,-1
     7d0:	fef42623          	sw	a5,-20(s0)
     7d4:	fec42783          	lw	a5,-20(s0)
     7d8:	2781                	sext.w	a5,a5
     7da:	fc07dce3          	bgez	a5,7b2 <printint+0xba>
}
     7de:	0001                	nop
     7e0:	0001                	nop
     7e2:	60e6                	ld	ra,88(sp)
     7e4:	6446                	ld	s0,80(sp)
     7e6:	6125                	addi	sp,sp,96
     7e8:	8082                	ret

00000000000007ea <printptr>:

static void
printptr(int fd, uint64 x) {
     7ea:	7179                	addi	sp,sp,-48
     7ec:	f406                	sd	ra,40(sp)
     7ee:	f022                	sd	s0,32(sp)
     7f0:	1800                	addi	s0,sp,48
     7f2:	87aa                	mv	a5,a0
     7f4:	fcb43823          	sd	a1,-48(s0)
     7f8:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7fc:	fdc42783          	lw	a5,-36(s0)
     800:	03000593          	li	a1,48
     804:	853e                	mv	a0,a5
     806:	ec1ff0ef          	jal	6c6 <putc>
  putc(fd, 'x');
     80a:	fdc42783          	lw	a5,-36(s0)
     80e:	07800593          	li	a1,120
     812:	853e                	mv	a0,a5
     814:	eb3ff0ef          	jal	6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     818:	fe042623          	sw	zero,-20(s0)
     81c:	a81d                	j	852 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     81e:	fd043783          	ld	a5,-48(s0)
     822:	93f1                	srli	a5,a5,0x3c
     824:	00001717          	auipc	a4,0x1
     828:	7dc70713          	addi	a4,a4,2012 # 2000 <digits>
     82c:	97ba                	add	a5,a5,a4
     82e:	0007c703          	lbu	a4,0(a5)
     832:	fdc42783          	lw	a5,-36(s0)
     836:	85ba                	mv	a1,a4
     838:	853e                	mv	a0,a5
     83a:	e8dff0ef          	jal	6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     83e:	fec42783          	lw	a5,-20(s0)
     842:	2785                	addiw	a5,a5,1
     844:	fef42623          	sw	a5,-20(s0)
     848:	fd043783          	ld	a5,-48(s0)
     84c:	0792                	slli	a5,a5,0x4
     84e:	fcf43823          	sd	a5,-48(s0)
     852:	fec42703          	lw	a4,-20(s0)
     856:	47bd                	li	a5,15
     858:	fce7f3e3          	bgeu	a5,a4,81e <printptr+0x34>
}
     85c:	0001                	nop
     85e:	0001                	nop
     860:	70a2                	ld	ra,40(sp)
     862:	7402                	ld	s0,32(sp)
     864:	6145                	addi	sp,sp,48
     866:	8082                	ret

0000000000000868 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     868:	715d                	addi	sp,sp,-80
     86a:	e486                	sd	ra,72(sp)
     86c:	e0a2                	sd	s0,64(sp)
     86e:	0880                	addi	s0,sp,80
     870:	87aa                	mv	a5,a0
     872:	fcb43023          	sd	a1,-64(s0)
     876:	fac43c23          	sd	a2,-72(s0)
     87a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     87e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     882:	fc042e23          	sw	zero,-36(s0)
     886:	a189                	j	cc8 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     888:	fdc42783          	lw	a5,-36(s0)
     88c:	fc043703          	ld	a4,-64(s0)
     890:	97ba                	add	a5,a5,a4
     892:	0007c783          	lbu	a5,0(a5)
     896:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     89a:	fd842783          	lw	a5,-40(s0)
     89e:	2781                	sext.w	a5,a5
     8a0:	eb8d                	bnez	a5,8d2 <vprintf+0x6a>
      if(c0 == '%'){
     8a2:	fd442783          	lw	a5,-44(s0)
     8a6:	0007871b          	sext.w	a4,a5
     8aa:	02500793          	li	a5,37
     8ae:	00f71763          	bne	a4,a5,8bc <vprintf+0x54>
        state = '%';
     8b2:	02500793          	li	a5,37
     8b6:	fcf42c23          	sw	a5,-40(s0)
     8ba:	a111                	j	cbe <vprintf+0x456>
      } else {
        putc(fd, c0);
     8bc:	fd442783          	lw	a5,-44(s0)
     8c0:	0ff7f713          	zext.b	a4,a5
     8c4:	fcc42783          	lw	a5,-52(s0)
     8c8:	85ba                	mv	a1,a4
     8ca:	853e                	mv	a0,a5
     8cc:	dfbff0ef          	jal	6c6 <putc>
     8d0:	a6fd                	j	cbe <vprintf+0x456>
      }
    } else if(state == '%'){
     8d2:	fd842783          	lw	a5,-40(s0)
     8d6:	0007871b          	sext.w	a4,a5
     8da:	02500793          	li	a5,37
     8de:	3ef71063          	bne	a4,a5,cbe <vprintf+0x456>
      c1 = c2 = 0;
     8e2:	fe042023          	sw	zero,-32(s0)
     8e6:	fe042783          	lw	a5,-32(s0)
     8ea:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     8ee:	fd442783          	lw	a5,-44(s0)
     8f2:	2781                	sext.w	a5,a5
     8f4:	cb99                	beqz	a5,90a <vprintf+0xa2>
     8f6:	fdc42783          	lw	a5,-36(s0)
     8fa:	0785                	addi	a5,a5,1
     8fc:	fc043703          	ld	a4,-64(s0)
     900:	97ba                	add	a5,a5,a4
     902:	0007c783          	lbu	a5,0(a5)
     906:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     90a:	fe442783          	lw	a5,-28(s0)
     90e:	2781                	sext.w	a5,a5
     910:	cb99                	beqz	a5,926 <vprintf+0xbe>
     912:	fdc42783          	lw	a5,-36(s0)
     916:	0789                	addi	a5,a5,2
     918:	fc043703          	ld	a4,-64(s0)
     91c:	97ba                	add	a5,a5,a4
     91e:	0007c783          	lbu	a5,0(a5)
     922:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     926:	fd442783          	lw	a5,-44(s0)
     92a:	0007871b          	sext.w	a4,a5
     92e:	06400793          	li	a5,100
     932:	02f71363          	bne	a4,a5,958 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     936:	fb843783          	ld	a5,-72(s0)
     93a:	00878713          	addi	a4,a5,8
     93e:	fae43c23          	sd	a4,-72(s0)
     942:	439c                	lw	a5,0(a5)
     944:	873e                	mv	a4,a5
     946:	fcc42783          	lw	a5,-52(s0)
     94a:	4685                	li	a3,1
     94c:	4629                	li	a2,10
     94e:	85ba                	mv	a1,a4
     950:	853e                	mv	a0,a5
     952:	da7ff0ef          	jal	6f8 <printint>
     956:	a695                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     958:	fd442783          	lw	a5,-44(s0)
     95c:	0007871b          	sext.w	a4,a5
     960:	06c00793          	li	a5,108
     964:	04f71063          	bne	a4,a5,9a4 <vprintf+0x13c>
     968:	fe442783          	lw	a5,-28(s0)
     96c:	0007871b          	sext.w	a4,a5
     970:	06400793          	li	a5,100
     974:	02f71863          	bne	a4,a5,9a4 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     978:	fb843783          	ld	a5,-72(s0)
     97c:	00878713          	addi	a4,a5,8
     980:	fae43c23          	sd	a4,-72(s0)
     984:	639c                	ld	a5,0(a5)
     986:	873e                	mv	a4,a5
     988:	fcc42783          	lw	a5,-52(s0)
     98c:	4685                	li	a3,1
     98e:	4629                	li	a2,10
     990:	85ba                	mv	a1,a4
     992:	853e                	mv	a0,a5
     994:	d65ff0ef          	jal	6f8 <printint>
        i += 1;
     998:	fdc42783          	lw	a5,-36(s0)
     99c:	2785                	addiw	a5,a5,1
     99e:	fcf42e23          	sw	a5,-36(s0)
     9a2:	ae21                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     9a4:	fd442783          	lw	a5,-44(s0)
     9a8:	0007871b          	sext.w	a4,a5
     9ac:	06c00793          	li	a5,108
     9b0:	04f71863          	bne	a4,a5,a00 <vprintf+0x198>
     9b4:	fe442783          	lw	a5,-28(s0)
     9b8:	0007871b          	sext.w	a4,a5
     9bc:	06c00793          	li	a5,108
     9c0:	04f71063          	bne	a4,a5,a00 <vprintf+0x198>
     9c4:	fe042783          	lw	a5,-32(s0)
     9c8:	0007871b          	sext.w	a4,a5
     9cc:	06400793          	li	a5,100
     9d0:	02f71863          	bne	a4,a5,a00 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9d4:	fb843783          	ld	a5,-72(s0)
     9d8:	00878713          	addi	a4,a5,8
     9dc:	fae43c23          	sd	a4,-72(s0)
     9e0:	639c                	ld	a5,0(a5)
     9e2:	873e                	mv	a4,a5
     9e4:	fcc42783          	lw	a5,-52(s0)
     9e8:	4685                	li	a3,1
     9ea:	4629                	li	a2,10
     9ec:	85ba                	mv	a1,a4
     9ee:	853e                	mv	a0,a5
     9f0:	d09ff0ef          	jal	6f8 <printint>
        i += 2;
     9f4:	fdc42783          	lw	a5,-36(s0)
     9f8:	2789                	addiw	a5,a5,2
     9fa:	fcf42e23          	sw	a5,-36(s0)
     9fe:	ac75                	j	cba <vprintf+0x452>
      } else if(c0 == 'u'){
     a00:	fd442783          	lw	a5,-44(s0)
     a04:	0007871b          	sext.w	a4,a5
     a08:	07500793          	li	a5,117
     a0c:	02f71563          	bne	a4,a5,a36 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a10:	fb843783          	ld	a5,-72(s0)
     a14:	00878713          	addi	a4,a5,8
     a18:	fae43c23          	sd	a4,-72(s0)
     a1c:	439c                	lw	a5,0(a5)
     a1e:	02079713          	slli	a4,a5,0x20
     a22:	9301                	srli	a4,a4,0x20
     a24:	fcc42783          	lw	a5,-52(s0)
     a28:	4681                	li	a3,0
     a2a:	4629                	li	a2,10
     a2c:	85ba                	mv	a1,a4
     a2e:	853e                	mv	a0,a5
     a30:	cc9ff0ef          	jal	6f8 <printint>
     a34:	a459                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a36:	fd442783          	lw	a5,-44(s0)
     a3a:	0007871b          	sext.w	a4,a5
     a3e:	06c00793          	li	a5,108
     a42:	04f71063          	bne	a4,a5,a82 <vprintf+0x21a>
     a46:	fe442783          	lw	a5,-28(s0)
     a4a:	0007871b          	sext.w	a4,a5
     a4e:	07500793          	li	a5,117
     a52:	02f71863          	bne	a4,a5,a82 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a56:	fb843783          	ld	a5,-72(s0)
     a5a:	00878713          	addi	a4,a5,8
     a5e:	fae43c23          	sd	a4,-72(s0)
     a62:	639c                	ld	a5,0(a5)
     a64:	873e                	mv	a4,a5
     a66:	fcc42783          	lw	a5,-52(s0)
     a6a:	4681                	li	a3,0
     a6c:	4629                	li	a2,10
     a6e:	85ba                	mv	a1,a4
     a70:	853e                	mv	a0,a5
     a72:	c87ff0ef          	jal	6f8 <printint>
        i += 1;
     a76:	fdc42783          	lw	a5,-36(s0)
     a7a:	2785                	addiw	a5,a5,1
     a7c:	fcf42e23          	sw	a5,-36(s0)
     a80:	ac2d                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     a82:	fd442783          	lw	a5,-44(s0)
     a86:	0007871b          	sext.w	a4,a5
     a8a:	06c00793          	li	a5,108
     a8e:	04f71863          	bne	a4,a5,ade <vprintf+0x276>
     a92:	fe442783          	lw	a5,-28(s0)
     a96:	0007871b          	sext.w	a4,a5
     a9a:	06c00793          	li	a5,108
     a9e:	04f71063          	bne	a4,a5,ade <vprintf+0x276>
     aa2:	fe042783          	lw	a5,-32(s0)
     aa6:	0007871b          	sext.w	a4,a5
     aaa:	07500793          	li	a5,117
     aae:	02f71863          	bne	a4,a5,ade <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ab2:	fb843783          	ld	a5,-72(s0)
     ab6:	00878713          	addi	a4,a5,8
     aba:	fae43c23          	sd	a4,-72(s0)
     abe:	639c                	ld	a5,0(a5)
     ac0:	873e                	mv	a4,a5
     ac2:	fcc42783          	lw	a5,-52(s0)
     ac6:	4681                	li	a3,0
     ac8:	4629                	li	a2,10
     aca:	85ba                	mv	a1,a4
     acc:	853e                	mv	a0,a5
     ace:	c2bff0ef          	jal	6f8 <printint>
        i += 2;
     ad2:	fdc42783          	lw	a5,-36(s0)
     ad6:	2789                	addiw	a5,a5,2
     ad8:	fcf42e23          	sw	a5,-36(s0)
     adc:	aaf9                	j	cba <vprintf+0x452>
      } else if(c0 == 'x'){
     ade:	fd442783          	lw	a5,-44(s0)
     ae2:	0007871b          	sext.w	a4,a5
     ae6:	07800793          	li	a5,120
     aea:	02f71563          	bne	a4,a5,b14 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     aee:	fb843783          	ld	a5,-72(s0)
     af2:	00878713          	addi	a4,a5,8
     af6:	fae43c23          	sd	a4,-72(s0)
     afa:	439c                	lw	a5,0(a5)
     afc:	02079713          	slli	a4,a5,0x20
     b00:	9301                	srli	a4,a4,0x20
     b02:	fcc42783          	lw	a5,-52(s0)
     b06:	4681                	li	a3,0
     b08:	4641                	li	a2,16
     b0a:	85ba                	mv	a1,a4
     b0c:	853e                	mv	a0,a5
     b0e:	bebff0ef          	jal	6f8 <printint>
     b12:	a265                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b14:	fd442783          	lw	a5,-44(s0)
     b18:	0007871b          	sext.w	a4,a5
     b1c:	06c00793          	li	a5,108
     b20:	04f71063          	bne	a4,a5,b60 <vprintf+0x2f8>
     b24:	fe442783          	lw	a5,-28(s0)
     b28:	0007871b          	sext.w	a4,a5
     b2c:	07800793          	li	a5,120
     b30:	02f71863          	bne	a4,a5,b60 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b34:	fb843783          	ld	a5,-72(s0)
     b38:	00878713          	addi	a4,a5,8
     b3c:	fae43c23          	sd	a4,-72(s0)
     b40:	639c                	ld	a5,0(a5)
     b42:	873e                	mv	a4,a5
     b44:	fcc42783          	lw	a5,-52(s0)
     b48:	4681                	li	a3,0
     b4a:	4641                	li	a2,16
     b4c:	85ba                	mv	a1,a4
     b4e:	853e                	mv	a0,a5
     b50:	ba9ff0ef          	jal	6f8 <printint>
        i += 1;
     b54:	fdc42783          	lw	a5,-36(s0)
     b58:	2785                	addiw	a5,a5,1
     b5a:	fcf42e23          	sw	a5,-36(s0)
     b5e:	aab1                	j	cba <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     b60:	fd442783          	lw	a5,-44(s0)
     b64:	0007871b          	sext.w	a4,a5
     b68:	06c00793          	li	a5,108
     b6c:	04f71863          	bne	a4,a5,bbc <vprintf+0x354>
     b70:	fe442783          	lw	a5,-28(s0)
     b74:	0007871b          	sext.w	a4,a5
     b78:	06c00793          	li	a5,108
     b7c:	04f71063          	bne	a4,a5,bbc <vprintf+0x354>
     b80:	fe042783          	lw	a5,-32(s0)
     b84:	0007871b          	sext.w	a4,a5
     b88:	07800793          	li	a5,120
     b8c:	02f71863          	bne	a4,a5,bbc <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b90:	fb843783          	ld	a5,-72(s0)
     b94:	00878713          	addi	a4,a5,8
     b98:	fae43c23          	sd	a4,-72(s0)
     b9c:	639c                	ld	a5,0(a5)
     b9e:	873e                	mv	a4,a5
     ba0:	fcc42783          	lw	a5,-52(s0)
     ba4:	4681                	li	a3,0
     ba6:	4641                	li	a2,16
     ba8:	85ba                	mv	a1,a4
     baa:	853e                	mv	a0,a5
     bac:	b4dff0ef          	jal	6f8 <printint>
        i += 2;
     bb0:	fdc42783          	lw	a5,-36(s0)
     bb4:	2789                	addiw	a5,a5,2
     bb6:	fcf42e23          	sw	a5,-36(s0)
     bba:	a201                	j	cba <vprintf+0x452>
      } else if(c0 == 'p'){
     bbc:	fd442783          	lw	a5,-44(s0)
     bc0:	0007871b          	sext.w	a4,a5
     bc4:	07000793          	li	a5,112
     bc8:	02f71063          	bne	a4,a5,be8 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     bcc:	fb843783          	ld	a5,-72(s0)
     bd0:	00878713          	addi	a4,a5,8
     bd4:	fae43c23          	sd	a4,-72(s0)
     bd8:	6398                	ld	a4,0(a5)
     bda:	fcc42783          	lw	a5,-52(s0)
     bde:	85ba                	mv	a1,a4
     be0:	853e                	mv	a0,a5
     be2:	c09ff0ef          	jal	7ea <printptr>
     be6:	a8d1                	j	cba <vprintf+0x452>
      } else if(c0 == 'c'){
     be8:	fd442783          	lw	a5,-44(s0)
     bec:	0007871b          	sext.w	a4,a5
     bf0:	06300793          	li	a5,99
     bf4:	02f71263          	bne	a4,a5,c18 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     bf8:	fb843783          	ld	a5,-72(s0)
     bfc:	00878713          	addi	a4,a5,8
     c00:	fae43c23          	sd	a4,-72(s0)
     c04:	439c                	lw	a5,0(a5)
     c06:	0ff7f713          	zext.b	a4,a5
     c0a:	fcc42783          	lw	a5,-52(s0)
     c0e:	85ba                	mv	a1,a4
     c10:	853e                	mv	a0,a5
     c12:	ab5ff0ef          	jal	6c6 <putc>
     c16:	a055                	j	cba <vprintf+0x452>
      } else if(c0 == 's'){
     c18:	fd442783          	lw	a5,-44(s0)
     c1c:	0007871b          	sext.w	a4,a5
     c20:	07300793          	li	a5,115
     c24:	04f71a63          	bne	a4,a5,c78 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c28:	fb843783          	ld	a5,-72(s0)
     c2c:	00878713          	addi	a4,a5,8
     c30:	fae43c23          	sd	a4,-72(s0)
     c34:	639c                	ld	a5,0(a5)
     c36:	fef43423          	sd	a5,-24(s0)
     c3a:	fe843783          	ld	a5,-24(s0)
     c3e:	e79d                	bnez	a5,c6c <vprintf+0x404>
          s = "(null)";
     c40:	00000797          	auipc	a5,0x0
     c44:	4b078793          	addi	a5,a5,1200 # 10f0 <malloc+0x1ce>
     c48:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c4c:	a005                	j	c6c <vprintf+0x404>
          putc(fd, *s);
     c4e:	fe843783          	ld	a5,-24(s0)
     c52:	0007c703          	lbu	a4,0(a5)
     c56:	fcc42783          	lw	a5,-52(s0)
     c5a:	85ba                	mv	a1,a4
     c5c:	853e                	mv	a0,a5
     c5e:	a69ff0ef          	jal	6c6 <putc>
        for(; *s; s++)
     c62:	fe843783          	ld	a5,-24(s0)
     c66:	0785                	addi	a5,a5,1
     c68:	fef43423          	sd	a5,-24(s0)
     c6c:	fe843783          	ld	a5,-24(s0)
     c70:	0007c783          	lbu	a5,0(a5)
     c74:	ffe9                	bnez	a5,c4e <vprintf+0x3e6>
     c76:	a091                	j	cba <vprintf+0x452>
      } else if(c0 == '%'){
     c78:	fd442783          	lw	a5,-44(s0)
     c7c:	0007871b          	sext.w	a4,a5
     c80:	02500793          	li	a5,37
     c84:	00f71a63          	bne	a4,a5,c98 <vprintf+0x430>
        putc(fd, '%');
     c88:	fcc42783          	lw	a5,-52(s0)
     c8c:	02500593          	li	a1,37
     c90:	853e                	mv	a0,a5
     c92:	a35ff0ef          	jal	6c6 <putc>
     c96:	a015                	j	cba <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c98:	fcc42783          	lw	a5,-52(s0)
     c9c:	02500593          	li	a1,37
     ca0:	853e                	mv	a0,a5
     ca2:	a25ff0ef          	jal	6c6 <putc>
        putc(fd, c0);
     ca6:	fd442783          	lw	a5,-44(s0)
     caa:	0ff7f713          	zext.b	a4,a5
     cae:	fcc42783          	lw	a5,-52(s0)
     cb2:	85ba                	mv	a1,a4
     cb4:	853e                	mv	a0,a5
     cb6:	a11ff0ef          	jal	6c6 <putc>
      }

      state = 0;
     cba:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     cbe:	fdc42783          	lw	a5,-36(s0)
     cc2:	2785                	addiw	a5,a5,1
     cc4:	fcf42e23          	sw	a5,-36(s0)
     cc8:	fdc42783          	lw	a5,-36(s0)
     ccc:	fc043703          	ld	a4,-64(s0)
     cd0:	97ba                	add	a5,a5,a4
     cd2:	0007c783          	lbu	a5,0(a5)
     cd6:	ba0799e3          	bnez	a5,888 <vprintf+0x20>
    }
  }
}
     cda:	0001                	nop
     cdc:	0001                	nop
     cde:	60a6                	ld	ra,72(sp)
     ce0:	6406                	ld	s0,64(sp)
     ce2:	6161                	addi	sp,sp,80
     ce4:	8082                	ret

0000000000000ce6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ce6:	7159                	addi	sp,sp,-112
     ce8:	fc06                	sd	ra,56(sp)
     cea:	f822                	sd	s0,48(sp)
     cec:	0080                	addi	s0,sp,64
     cee:	fcb43823          	sd	a1,-48(s0)
     cf2:	e010                	sd	a2,0(s0)
     cf4:	e414                	sd	a3,8(s0)
     cf6:	e818                	sd	a4,16(s0)
     cf8:	ec1c                	sd	a5,24(s0)
     cfa:	03043023          	sd	a6,32(s0)
     cfe:	03143423          	sd	a7,40(s0)
     d02:	87aa                	mv	a5,a0
     d04:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d08:	03040793          	addi	a5,s0,48
     d0c:	fcf43423          	sd	a5,-56(s0)
     d10:	fc843783          	ld	a5,-56(s0)
     d14:	fd078793          	addi	a5,a5,-48
     d18:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d1c:	fe843703          	ld	a4,-24(s0)
     d20:	fdc42783          	lw	a5,-36(s0)
     d24:	863a                	mv	a2,a4
     d26:	fd043583          	ld	a1,-48(s0)
     d2a:	853e                	mv	a0,a5
     d2c:	b3dff0ef          	jal	868 <vprintf>
}
     d30:	0001                	nop
     d32:	70e2                	ld	ra,56(sp)
     d34:	7442                	ld	s0,48(sp)
     d36:	6165                	addi	sp,sp,112
     d38:	8082                	ret

0000000000000d3a <printf>:

void
printf(const char *fmt, ...)
{
     d3a:	7159                	addi	sp,sp,-112
     d3c:	f406                	sd	ra,40(sp)
     d3e:	f022                	sd	s0,32(sp)
     d40:	1800                	addi	s0,sp,48
     d42:	fca43c23          	sd	a0,-40(s0)
     d46:	e40c                	sd	a1,8(s0)
     d48:	e810                	sd	a2,16(s0)
     d4a:	ec14                	sd	a3,24(s0)
     d4c:	f018                	sd	a4,32(s0)
     d4e:	f41c                	sd	a5,40(s0)
     d50:	03043823          	sd	a6,48(s0)
     d54:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d58:	04040793          	addi	a5,s0,64
     d5c:	fcf43823          	sd	a5,-48(s0)
     d60:	fd043783          	ld	a5,-48(s0)
     d64:	fc878793          	addi	a5,a5,-56
     d68:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d6c:	fe843783          	ld	a5,-24(s0)
     d70:	863e                	mv	a2,a5
     d72:	fd843583          	ld	a1,-40(s0)
     d76:	4505                	li	a0,1
     d78:	af1ff0ef          	jal	868 <vprintf>
}
     d7c:	0001                	nop
     d7e:	70a2                	ld	ra,40(sp)
     d80:	7402                	ld	s0,32(sp)
     d82:	6165                	addi	sp,sp,112
     d84:	8082                	ret

0000000000000d86 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d86:	7179                	addi	sp,sp,-48
     d88:	f406                	sd	ra,40(sp)
     d8a:	f022                	sd	s0,32(sp)
     d8c:	1800                	addi	s0,sp,48
     d8e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d92:	fd843783          	ld	a5,-40(s0)
     d96:	17c1                	addi	a5,a5,-16
     d98:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d9c:	00001797          	auipc	a5,0x1
     da0:	48c78793          	addi	a5,a5,1164 # 2228 <freep>
     da4:	639c                	ld	a5,0(a5)
     da6:	fef43423          	sd	a5,-24(s0)
     daa:	a815                	j	dde <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	639c                	ld	a5,0(a5)
     db2:	fe843703          	ld	a4,-24(s0)
     db6:	00f76f63          	bltu	a4,a5,dd4 <free+0x4e>
     dba:	fe043703          	ld	a4,-32(s0)
     dbe:	fe843783          	ld	a5,-24(s0)
     dc2:	02e7eb63          	bltu	a5,a4,df8 <free+0x72>
     dc6:	fe843783          	ld	a5,-24(s0)
     dca:	639c                	ld	a5,0(a5)
     dcc:	fe043703          	ld	a4,-32(s0)
     dd0:	02f76463          	bltu	a4,a5,df8 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dd4:	fe843783          	ld	a5,-24(s0)
     dd8:	639c                	ld	a5,0(a5)
     dda:	fef43423          	sd	a5,-24(s0)
     dde:	fe043703          	ld	a4,-32(s0)
     de2:	fe843783          	ld	a5,-24(s0)
     de6:	fce7f3e3          	bgeu	a5,a4,dac <free+0x26>
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	639c                	ld	a5,0(a5)
     df0:	fe043703          	ld	a4,-32(s0)
     df4:	faf77ce3          	bgeu	a4,a5,dac <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     df8:	fe043783          	ld	a5,-32(s0)
     dfc:	479c                	lw	a5,8(a5)
     dfe:	1782                	slli	a5,a5,0x20
     e00:	9381                	srli	a5,a5,0x20
     e02:	0792                	slli	a5,a5,0x4
     e04:	fe043703          	ld	a4,-32(s0)
     e08:	973e                	add	a4,a4,a5
     e0a:	fe843783          	ld	a5,-24(s0)
     e0e:	639c                	ld	a5,0(a5)
     e10:	02f71763          	bne	a4,a5,e3e <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e14:	fe043783          	ld	a5,-32(s0)
     e18:	4798                	lw	a4,8(a5)
     e1a:	fe843783          	ld	a5,-24(s0)
     e1e:	639c                	ld	a5,0(a5)
     e20:	479c                	lw	a5,8(a5)
     e22:	9fb9                	addw	a5,a5,a4
     e24:	0007871b          	sext.w	a4,a5
     e28:	fe043783          	ld	a5,-32(s0)
     e2c:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e2e:	fe843783          	ld	a5,-24(s0)
     e32:	639c                	ld	a5,0(a5)
     e34:	6398                	ld	a4,0(a5)
     e36:	fe043783          	ld	a5,-32(s0)
     e3a:	e398                	sd	a4,0(a5)
     e3c:	a039                	j	e4a <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e3e:	fe843783          	ld	a5,-24(s0)
     e42:	6398                	ld	a4,0(a5)
     e44:	fe043783          	ld	a5,-32(s0)
     e48:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e4a:	fe843783          	ld	a5,-24(s0)
     e4e:	479c                	lw	a5,8(a5)
     e50:	1782                	slli	a5,a5,0x20
     e52:	9381                	srli	a5,a5,0x20
     e54:	0792                	slli	a5,a5,0x4
     e56:	fe843703          	ld	a4,-24(s0)
     e5a:	97ba                	add	a5,a5,a4
     e5c:	fe043703          	ld	a4,-32(s0)
     e60:	02f71563          	bne	a4,a5,e8a <free+0x104>
    p->s.size += bp->s.size;
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	4798                	lw	a4,8(a5)
     e6a:	fe043783          	ld	a5,-32(s0)
     e6e:	479c                	lw	a5,8(a5)
     e70:	9fb9                	addw	a5,a5,a4
     e72:	0007871b          	sext.w	a4,a5
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     e7c:	fe043783          	ld	a5,-32(s0)
     e80:	6398                	ld	a4,0(a5)
     e82:	fe843783          	ld	a5,-24(s0)
     e86:	e398                	sd	a4,0(a5)
     e88:	a031                	j	e94 <free+0x10e>
  } else
    p->s.ptr = bp;
     e8a:	fe843783          	ld	a5,-24(s0)
     e8e:	fe043703          	ld	a4,-32(s0)
     e92:	e398                	sd	a4,0(a5)
  freep = p;
     e94:	00001797          	auipc	a5,0x1
     e98:	39478793          	addi	a5,a5,916 # 2228 <freep>
     e9c:	fe843703          	ld	a4,-24(s0)
     ea0:	e398                	sd	a4,0(a5)
}
     ea2:	0001                	nop
     ea4:	70a2                	ld	ra,40(sp)
     ea6:	7402                	ld	s0,32(sp)
     ea8:	6145                	addi	sp,sp,48
     eaa:	8082                	ret

0000000000000eac <morecore>:

static Header*
morecore(uint nu)
{
     eac:	7179                	addi	sp,sp,-48
     eae:	f406                	sd	ra,40(sp)
     eb0:	f022                	sd	s0,32(sp)
     eb2:	1800                	addi	s0,sp,48
     eb4:	87aa                	mv	a5,a0
     eb6:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     eba:	fdc42783          	lw	a5,-36(s0)
     ebe:	0007871b          	sext.w	a4,a5
     ec2:	6785                	lui	a5,0x1
     ec4:	00f77563          	bgeu	a4,a5,ece <morecore+0x22>
    nu = 4096;
     ec8:	6785                	lui	a5,0x1
     eca:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ece:	fdc42783          	lw	a5,-36(s0)
     ed2:	0047979b          	slliw	a5,a5,0x4
     ed6:	2781                	sext.w	a5,a5
     ed8:	853e                	mv	a0,a5
     eda:	ee8ff0ef          	jal	5c2 <sbrk>
     ede:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     ee2:	fe843703          	ld	a4,-24(s0)
     ee6:	57fd                	li	a5,-1
     ee8:	00f71463          	bne	a4,a5,ef0 <morecore+0x44>
    return 0;
     eec:	4781                	li	a5,0
     eee:	a02d                	j	f18 <morecore+0x6c>
  hp = (Header*)p;
     ef0:	fe843783          	ld	a5,-24(s0)
     ef4:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ef8:	fe043783          	ld	a5,-32(s0)
     efc:	fdc42703          	lw	a4,-36(s0)
     f00:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f02:	fe043783          	ld	a5,-32(s0)
     f06:	07c1                	addi	a5,a5,16 # 1010 <malloc+0xee>
     f08:	853e                	mv	a0,a5
     f0a:	e7dff0ef          	jal	d86 <free>
  return freep;
     f0e:	00001797          	auipc	a5,0x1
     f12:	31a78793          	addi	a5,a5,794 # 2228 <freep>
     f16:	639c                	ld	a5,0(a5)
}
     f18:	853e                	mv	a0,a5
     f1a:	70a2                	ld	ra,40(sp)
     f1c:	7402                	ld	s0,32(sp)
     f1e:	6145                	addi	sp,sp,48
     f20:	8082                	ret

0000000000000f22 <malloc>:

void*
malloc(uint nbytes)
{
     f22:	7139                	addi	sp,sp,-64
     f24:	fc06                	sd	ra,56(sp)
     f26:	f822                	sd	s0,48(sp)
     f28:	0080                	addi	s0,sp,64
     f2a:	87aa                	mv	a5,a0
     f2c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f30:	fcc46783          	lwu	a5,-52(s0)
     f34:	07bd                	addi	a5,a5,15
     f36:	8391                	srli	a5,a5,0x4
     f38:	2781                	sext.w	a5,a5
     f3a:	2785                	addiw	a5,a5,1
     f3c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f40:	00001797          	auipc	a5,0x1
     f44:	2e878793          	addi	a5,a5,744 # 2228 <freep>
     f48:	639c                	ld	a5,0(a5)
     f4a:	fef43023          	sd	a5,-32(s0)
     f4e:	fe043783          	ld	a5,-32(s0)
     f52:	ef95                	bnez	a5,f8e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f54:	00001797          	auipc	a5,0x1
     f58:	2c478793          	addi	a5,a5,708 # 2218 <base>
     f5c:	fef43023          	sd	a5,-32(s0)
     f60:	00001797          	auipc	a5,0x1
     f64:	2c878793          	addi	a5,a5,712 # 2228 <freep>
     f68:	fe043703          	ld	a4,-32(s0)
     f6c:	e398                	sd	a4,0(a5)
     f6e:	00001797          	auipc	a5,0x1
     f72:	2ba78793          	addi	a5,a5,698 # 2228 <freep>
     f76:	6398                	ld	a4,0(a5)
     f78:	00001797          	auipc	a5,0x1
     f7c:	2a078793          	addi	a5,a5,672 # 2218 <base>
     f80:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f82:	00001797          	auipc	a5,0x1
     f86:	29678793          	addi	a5,a5,662 # 2218 <base>
     f8a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f8e:	fe043783          	ld	a5,-32(s0)
     f92:	639c                	ld	a5,0(a5)
     f94:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f98:	fe843783          	ld	a5,-24(s0)
     f9c:	479c                	lw	a5,8(a5)
     f9e:	fdc42703          	lw	a4,-36(s0)
     fa2:	2701                	sext.w	a4,a4
     fa4:	06e7e763          	bltu	a5,a4,1012 <malloc+0xf0>
      if(p->s.size == nunits)
     fa8:	fe843783          	ld	a5,-24(s0)
     fac:	479c                	lw	a5,8(a5)
     fae:	fdc42703          	lw	a4,-36(s0)
     fb2:	2701                	sext.w	a4,a4
     fb4:	00f71963          	bne	a4,a5,fc6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fb8:	fe843783          	ld	a5,-24(s0)
     fbc:	6398                	ld	a4,0(a5)
     fbe:	fe043783          	ld	a5,-32(s0)
     fc2:	e398                	sd	a4,0(a5)
     fc4:	a825                	j	ffc <malloc+0xda>
      else {
        p->s.size -= nunits;
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	479c                	lw	a5,8(a5)
     fcc:	fdc42703          	lw	a4,-36(s0)
     fd0:	9f99                	subw	a5,a5,a4
     fd2:	0007871b          	sext.w	a4,a5
     fd6:	fe843783          	ld	a5,-24(s0)
     fda:	c798                	sw	a4,8(a5)
        p += p->s.size;
     fdc:	fe843783          	ld	a5,-24(s0)
     fe0:	479c                	lw	a5,8(a5)
     fe2:	1782                	slli	a5,a5,0x20
     fe4:	9381                	srli	a5,a5,0x20
     fe6:	0792                	slli	a5,a5,0x4
     fe8:	fe843703          	ld	a4,-24(s0)
     fec:	97ba                	add	a5,a5,a4
     fee:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	fdc42703          	lw	a4,-36(s0)
     ffa:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ffc:	00001797          	auipc	a5,0x1
    1000:	22c78793          	addi	a5,a5,556 # 2228 <freep>
    1004:	fe043703          	ld	a4,-32(s0)
    1008:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    100a:	fe843783          	ld	a5,-24(s0)
    100e:	07c1                	addi	a5,a5,16
    1010:	a081                	j	1050 <malloc+0x12e>
    }
    if(p == freep)
    1012:	00001797          	auipc	a5,0x1
    1016:	21678793          	addi	a5,a5,534 # 2228 <freep>
    101a:	639c                	ld	a5,0(a5)
    101c:	fe843703          	ld	a4,-24(s0)
    1020:	00f71e63          	bne	a4,a5,103c <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1024:	fdc42783          	lw	a5,-36(s0)
    1028:	853e                	mv	a0,a5
    102a:	e83ff0ef          	jal	eac <morecore>
    102e:	fea43423          	sd	a0,-24(s0)
    1032:	fe843783          	ld	a5,-24(s0)
    1036:	e399                	bnez	a5,103c <malloc+0x11a>
        return 0;
    1038:	4781                	li	a5,0
    103a:	a819                	j	1050 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	fef43023          	sd	a5,-32(s0)
    1044:	fe843783          	ld	a5,-24(s0)
    1048:	639c                	ld	a5,0(a5)
    104a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    104e:	b7a9                	j	f98 <malloc+0x76>
  }
}
    1050:	853e                	mv	a0,a5
    1052:	70e2                	ld	ra,56(sp)
    1054:	7442                	ld	s0,48(sp)
    1056:	6121                	addi	sp,sp,64
    1058:	8082                	ret
