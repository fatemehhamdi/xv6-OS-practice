
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
       8:	4589                	li	a1,2
       a:	00001517          	auipc	a0,0x1
       e:	03e50513          	addi	a0,a0,62 # 1048 <malloc+0x148>
      12:	62a000ef          	jal	63c <open>
      16:	87aa                	mv	a5,a0
      18:	0207d163          	bgez	a5,3a <main+0x3a>
    mknod("console", CONSOLE, 0);
      1c:	4601                	li	a2,0
      1e:	4585                	li	a1,1
      20:	00001517          	auipc	a0,0x1
      24:	02850513          	addi	a0,a0,40 # 1048 <malloc+0x148>
      28:	61c000ef          	jal	644 <mknod>
    open("console", O_RDWR);
      2c:	4589                	li	a1,2
      2e:	00001517          	auipc	a0,0x1
      32:	01a50513          	addi	a0,a0,26 # 1048 <malloc+0x148>
      36:	606000ef          	jal	63c <open>
  }
  dup(0);  // stdout
      3a:	4501                	li	a0,0
      3c:	638000ef          	jal	674 <dup>
  dup(0);  // stderr
      40:	4501                	li	a0,0
      42:	632000ef          	jal	674 <dup>

  for(;;){
    printf("init: starting sh\n");
      46:	00001517          	auipc	a0,0x1
      4a:	00a50513          	addi	a0,a0,10 # 1050 <malloc+0x150>
      4e:	4cb000ef          	jal	d18 <printf>
    pid = fork();
      52:	5a2000ef          	jal	5f4 <fork>
      56:	87aa                	mv	a5,a0
      58:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
      5c:	fec42783          	lw	a5,-20(s0)
      60:	2781                	sext.w	a5,a5
      62:	0007db63          	bgez	a5,78 <main+0x78>
      printf("init: fork failed\n");
      66:	00001517          	auipc	a0,0x1
      6a:	00250513          	addi	a0,a0,2 # 1068 <malloc+0x168>
      6e:	4ab000ef          	jal	d18 <printf>
      exit(1);
      72:	4505                	li	a0,1
      74:	588000ef          	jal	5fc <exit>
    }
    if(pid == 0){
      78:	fec42783          	lw	a5,-20(s0)
      7c:	2781                	sext.w	a5,a5
      7e:	e785                	bnez	a5,a6 <main+0xa6>
      exec("sh", argv);
      80:	00002597          	auipc	a1,0x2
      84:	f8058593          	addi	a1,a1,-128 # 2000 <argv>
      88:	00001517          	auipc	a0,0x1
      8c:	fb850513          	addi	a0,a0,-72 # 1040 <malloc+0x140>
      90:	5a4000ef          	jal	634 <exec>
      printf("init: exec sh failed\n");
      94:	00001517          	auipc	a0,0x1
      98:	fec50513          	addi	a0,a0,-20 # 1080 <malloc+0x180>
      9c:	47d000ef          	jal	d18 <printf>
      exit(1);
      a0:	4505                	li	a0,1
      a2:	55a000ef          	jal	5fc <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
      a6:	4501                	li	a0,0
      a8:	55c000ef          	jal	604 <wait>
      ac:	87aa                	mv	a5,a0
      ae:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
      b2:	fe842783          	lw	a5,-24(s0)
      b6:	873e                	mv	a4,a5
      b8:	fec42783          	lw	a5,-20(s0)
      bc:	2701                	sext.w	a4,a4
      be:	2781                	sext.w	a5,a5
      c0:	02f70063          	beq	a4,a5,e0 <main+0xe0>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
      c4:	fe842783          	lw	a5,-24(s0)
      c8:	2781                	sext.w	a5,a5
      ca:	fc07dee3          	bgez	a5,a6 <main+0xa6>
        printf("init: wait returned an error\n");
      ce:	00001517          	auipc	a0,0x1
      d2:	fca50513          	addi	a0,a0,-54 # 1098 <malloc+0x198>
      d6:	443000ef          	jal	d18 <printf>
        exit(1);
      da:	4505                	li	a0,1
      dc:	520000ef          	jal	5fc <exit>
        break;
      e0:	0001                	nop
    printf("init: starting sh\n");
      e2:	b795                	j	46 <main+0x46>

00000000000000e4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
      e4:	7179                	addi	sp,sp,-48
      e6:	f406                	sd	ra,40(sp)
      e8:	f022                	sd	s0,32(sp)
      ea:	1800                	addi	s0,sp,48
      ec:	87aa                	mv	a5,a0
      ee:	fcb43823          	sd	a1,-48(s0)
      f2:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
      f6:	fdc42783          	lw	a5,-36(s0)
      fa:	fd043583          	ld	a1,-48(s0)
      fe:	853e                	mv	a0,a5
     100:	f01ff0ef          	jal	0 <main>
     104:	87aa                	mv	a5,a0
     106:	fef42623          	sw	a5,-20(s0)
  exit(r);
     10a:	fec42783          	lw	a5,-20(s0)
     10e:	853e                	mv	a0,a5
     110:	4ec000ef          	jal	5fc <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     114:	7179                	addi	sp,sp,-48
     116:	f406                	sd	ra,40(sp)
     118:	f022                	sd	s0,32(sp)
     11a:	1800                	addi	s0,sp,48
     11c:	fca43c23          	sd	a0,-40(s0)
     120:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     124:	fd843783          	ld	a5,-40(s0)
     128:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     12c:	0001                	nop
     12e:	fd043703          	ld	a4,-48(s0)
     132:	00170793          	addi	a5,a4,1
     136:	fcf43823          	sd	a5,-48(s0)
     13a:	fd843783          	ld	a5,-40(s0)
     13e:	00178693          	addi	a3,a5,1
     142:	fcd43c23          	sd	a3,-40(s0)
     146:	00074703          	lbu	a4,0(a4)
     14a:	00e78023          	sb	a4,0(a5)
     14e:	0007c783          	lbu	a5,0(a5)
     152:	fff1                	bnez	a5,12e <strcpy+0x1a>
    ;
  return os;
     154:	fe843783          	ld	a5,-24(s0)
}
     158:	853e                	mv	a0,a5
     15a:	70a2                	ld	ra,40(sp)
     15c:	7402                	ld	s0,32(sp)
     15e:	6145                	addi	sp,sp,48
     160:	8082                	ret

0000000000000162 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     162:	1101                	addi	sp,sp,-32
     164:	ec06                	sd	ra,24(sp)
     166:	e822                	sd	s0,16(sp)
     168:	1000                	addi	s0,sp,32
     16a:	fea43423          	sd	a0,-24(s0)
     16e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     172:	a819                	j	188 <strcmp+0x26>
    p++, q++;
     174:	fe843783          	ld	a5,-24(s0)
     178:	0785                	addi	a5,a5,1
     17a:	fef43423          	sd	a5,-24(s0)
     17e:	fe043783          	ld	a5,-32(s0)
     182:	0785                	addi	a5,a5,1
     184:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     188:	fe843783          	ld	a5,-24(s0)
     18c:	0007c783          	lbu	a5,0(a5)
     190:	cb99                	beqz	a5,1a6 <strcmp+0x44>
     192:	fe843783          	ld	a5,-24(s0)
     196:	0007c703          	lbu	a4,0(a5)
     19a:	fe043783          	ld	a5,-32(s0)
     19e:	0007c783          	lbu	a5,0(a5)
     1a2:	fcf709e3          	beq	a4,a5,174 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0007c783          	lbu	a5,0(a5)
     1ae:	0007871b          	sext.w	a4,a5
     1b2:	fe043783          	ld	a5,-32(s0)
     1b6:	0007c783          	lbu	a5,0(a5)
     1ba:	2781                	sext.w	a5,a5
     1bc:	40f707bb          	subw	a5,a4,a5
     1c0:	2781                	sext.w	a5,a5
}
     1c2:	853e                	mv	a0,a5
     1c4:	60e2                	ld	ra,24(sp)
     1c6:	6442                	ld	s0,16(sp)
     1c8:	6105                	addi	sp,sp,32
     1ca:	8082                	ret

00000000000001cc <strlen>:

uint
strlen(const char *s)
{
     1cc:	7179                	addi	sp,sp,-48
     1ce:	f406                	sd	ra,40(sp)
     1d0:	f022                	sd	s0,32(sp)
     1d2:	1800                	addi	s0,sp,48
     1d4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1d8:	fe042623          	sw	zero,-20(s0)
     1dc:	a031                	j	1e8 <strlen+0x1c>
     1de:	fec42783          	lw	a5,-20(s0)
     1e2:	2785                	addiw	a5,a5,1
     1e4:	fef42623          	sw	a5,-20(s0)
     1e8:	fec42783          	lw	a5,-20(s0)
     1ec:	fd843703          	ld	a4,-40(s0)
     1f0:	97ba                	add	a5,a5,a4
     1f2:	0007c783          	lbu	a5,0(a5)
     1f6:	f7e5                	bnez	a5,1de <strlen+0x12>
    ;
  return n;
     1f8:	fec42783          	lw	a5,-20(s0)
}
     1fc:	853e                	mv	a0,a5
     1fe:	70a2                	ld	ra,40(sp)
     200:	7402                	ld	s0,32(sp)
     202:	6145                	addi	sp,sp,48
     204:	8082                	ret

0000000000000206 <memset>:

void*
memset(void *dst, int c, uint n)
{
     206:	7179                	addi	sp,sp,-48
     208:	f406                	sd	ra,40(sp)
     20a:	f022                	sd	s0,32(sp)
     20c:	1800                	addi	s0,sp,48
     20e:	fca43c23          	sd	a0,-40(s0)
     212:	87ae                	mv	a5,a1
     214:	8732                	mv	a4,a2
     216:	fcf42a23          	sw	a5,-44(s0)
     21a:	87ba                	mv	a5,a4
     21c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     220:	fd843783          	ld	a5,-40(s0)
     224:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     228:	fe042623          	sw	zero,-20(s0)
     22c:	a00d                	j	24e <memset+0x48>
    cdst[i] = c;
     22e:	fec42783          	lw	a5,-20(s0)
     232:	fe043703          	ld	a4,-32(s0)
     236:	97ba                	add	a5,a5,a4
     238:	fd442703          	lw	a4,-44(s0)
     23c:	0ff77713          	zext.b	a4,a4
     240:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     244:	fec42783          	lw	a5,-20(s0)
     248:	2785                	addiw	a5,a5,1
     24a:	fef42623          	sw	a5,-20(s0)
     24e:	fec42783          	lw	a5,-20(s0)
     252:	fd042703          	lw	a4,-48(s0)
     256:	2701                	sext.w	a4,a4
     258:	fce7ebe3          	bltu	a5,a4,22e <memset+0x28>
  }
  return dst;
     25c:	fd843783          	ld	a5,-40(s0)
}
     260:	853e                	mv	a0,a5
     262:	70a2                	ld	ra,40(sp)
     264:	7402                	ld	s0,32(sp)
     266:	6145                	addi	sp,sp,48
     268:	8082                	ret

000000000000026a <strchr>:

char*
strchr(const char *s, char c)
{
     26a:	1101                	addi	sp,sp,-32
     26c:	ec06                	sd	ra,24(sp)
     26e:	e822                	sd	s0,16(sp)
     270:	1000                	addi	s0,sp,32
     272:	fea43423          	sd	a0,-24(s0)
     276:	87ae                	mv	a5,a1
     278:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     27c:	a01d                	j	2a2 <strchr+0x38>
    if(*s == c)
     27e:	fe843783          	ld	a5,-24(s0)
     282:	0007c703          	lbu	a4,0(a5)
     286:	fe744783          	lbu	a5,-25(s0)
     28a:	0ff7f793          	zext.b	a5,a5
     28e:	00e79563          	bne	a5,a4,298 <strchr+0x2e>
      return (char*)s;
     292:	fe843783          	ld	a5,-24(s0)
     296:	a821                	j	2ae <strchr+0x44>
  for(; *s; s++)
     298:	fe843783          	ld	a5,-24(s0)
     29c:	0785                	addi	a5,a5,1
     29e:	fef43423          	sd	a5,-24(s0)
     2a2:	fe843783          	ld	a5,-24(s0)
     2a6:	0007c783          	lbu	a5,0(a5)
     2aa:	fbf1                	bnez	a5,27e <strchr+0x14>
  return 0;
     2ac:	4781                	li	a5,0
}
     2ae:	853e                	mv	a0,a5
     2b0:	60e2                	ld	ra,24(sp)
     2b2:	6442                	ld	s0,16(sp)
     2b4:	6105                	addi	sp,sp,32
     2b6:	8082                	ret

00000000000002b8 <gets>:

char*
gets(char *buf, int max)
{
     2b8:	7179                	addi	sp,sp,-48
     2ba:	f406                	sd	ra,40(sp)
     2bc:	f022                	sd	s0,32(sp)
     2be:	1800                	addi	s0,sp,48
     2c0:	fca43c23          	sd	a0,-40(s0)
     2c4:	87ae                	mv	a5,a1
     2c6:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ca:	fe042623          	sw	zero,-20(s0)
     2ce:	a891                	j	322 <gets+0x6a>
    cc = read(0, &c, 1);
     2d0:	fe740793          	addi	a5,s0,-25
     2d4:	4605                	li	a2,1
     2d6:	85be                	mv	a1,a5
     2d8:	4501                	li	a0,0
     2da:	33a000ef          	jal	614 <read>
     2de:	87aa                	mv	a5,a0
     2e0:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2e4:	fe842783          	lw	a5,-24(s0)
     2e8:	2781                	sext.w	a5,a5
     2ea:	04f05663          	blez	a5,336 <gets+0x7e>
      break;
    buf[i++] = c;
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	0017871b          	addiw	a4,a5,1
     2f6:	fee42623          	sw	a4,-20(s0)
     2fa:	873e                	mv	a4,a5
     2fc:	fd843783          	ld	a5,-40(s0)
     300:	97ba                	add	a5,a5,a4
     302:	fe744703          	lbu	a4,-25(s0)
     306:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     30a:	fe744783          	lbu	a5,-25(s0)
     30e:	873e                	mv	a4,a5
     310:	47a9                	li	a5,10
     312:	02f70363          	beq	a4,a5,338 <gets+0x80>
     316:	fe744783          	lbu	a5,-25(s0)
     31a:	873e                	mv	a4,a5
     31c:	47b5                	li	a5,13
     31e:	00f70d63          	beq	a4,a5,338 <gets+0x80>
  for(i=0; i+1 < max; ){
     322:	fec42783          	lw	a5,-20(s0)
     326:	2785                	addiw	a5,a5,1
     328:	2781                	sext.w	a5,a5
     32a:	fd442703          	lw	a4,-44(s0)
     32e:	2701                	sext.w	a4,a4
     330:	fae7c0e3          	blt	a5,a4,2d0 <gets+0x18>
     334:	a011                	j	338 <gets+0x80>
      break;
     336:	0001                	nop
      break;
  }
  buf[i] = '\0';
     338:	fec42783          	lw	a5,-20(s0)
     33c:	fd843703          	ld	a4,-40(s0)
     340:	97ba                	add	a5,a5,a4
     342:	00078023          	sb	zero,0(a5)
  return buf;
     346:	fd843783          	ld	a5,-40(s0)
}
     34a:	853e                	mv	a0,a5
     34c:	70a2                	ld	ra,40(sp)
     34e:	7402                	ld	s0,32(sp)
     350:	6145                	addi	sp,sp,48
     352:	8082                	ret

0000000000000354 <stat>:

int
stat(const char *n, struct stat *st)
{
     354:	7179                	addi	sp,sp,-48
     356:	f406                	sd	ra,40(sp)
     358:	f022                	sd	s0,32(sp)
     35a:	1800                	addi	s0,sp,48
     35c:	fca43c23          	sd	a0,-40(s0)
     360:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     364:	4581                	li	a1,0
     366:	fd843503          	ld	a0,-40(s0)
     36a:	2d2000ef          	jal	63c <open>
     36e:	87aa                	mv	a5,a0
     370:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     374:	fec42783          	lw	a5,-20(s0)
     378:	2781                	sext.w	a5,a5
     37a:	0007d463          	bgez	a5,382 <stat+0x2e>
    return -1;
     37e:	57fd                	li	a5,-1
     380:	a015                	j	3a4 <stat+0x50>
  r = fstat(fd, st);
     382:	fec42783          	lw	a5,-20(s0)
     386:	fd043583          	ld	a1,-48(s0)
     38a:	853e                	mv	a0,a5
     38c:	2c8000ef          	jal	654 <fstat>
     390:	87aa                	mv	a5,a0
     392:	fef42423          	sw	a5,-24(s0)
  close(fd);
     396:	fec42783          	lw	a5,-20(s0)
     39a:	853e                	mv	a0,a5
     39c:	288000ef          	jal	624 <close>
  return r;
     3a0:	fe842783          	lw	a5,-24(s0)
}
     3a4:	853e                	mv	a0,a5
     3a6:	70a2                	ld	ra,40(sp)
     3a8:	7402                	ld	s0,32(sp)
     3aa:	6145                	addi	sp,sp,48
     3ac:	8082                	ret

00000000000003ae <atoi>:

int
atoi(const char *s)
{
     3ae:	7179                	addi	sp,sp,-48
     3b0:	f406                	sd	ra,40(sp)
     3b2:	f022                	sd	s0,32(sp)
     3b4:	1800                	addi	s0,sp,48
     3b6:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3ba:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3be:	a81d                	j	3f4 <atoi+0x46>
    n = n*10 + *s++ - '0';
     3c0:	fec42783          	lw	a5,-20(s0)
     3c4:	873e                	mv	a4,a5
     3c6:	87ba                	mv	a5,a4
     3c8:	0027979b          	slliw	a5,a5,0x2
     3cc:	9fb9                	addw	a5,a5,a4
     3ce:	0017979b          	slliw	a5,a5,0x1
     3d2:	0007871b          	sext.w	a4,a5
     3d6:	fd843783          	ld	a5,-40(s0)
     3da:	00178693          	addi	a3,a5,1
     3de:	fcd43c23          	sd	a3,-40(s0)
     3e2:	0007c783          	lbu	a5,0(a5)
     3e6:	2781                	sext.w	a5,a5
     3e8:	9fb9                	addw	a5,a5,a4
     3ea:	2781                	sext.w	a5,a5
     3ec:	fd07879b          	addiw	a5,a5,-48
     3f0:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3f4:	fd843783          	ld	a5,-40(s0)
     3f8:	0007c783          	lbu	a5,0(a5)
     3fc:	873e                	mv	a4,a5
     3fe:	02f00793          	li	a5,47
     402:	00e7fb63          	bgeu	a5,a4,418 <atoi+0x6a>
     406:	fd843783          	ld	a5,-40(s0)
     40a:	0007c783          	lbu	a5,0(a5)
     40e:	873e                	mv	a4,a5
     410:	03900793          	li	a5,57
     414:	fae7f6e3          	bgeu	a5,a4,3c0 <atoi+0x12>
  return n;
     418:	fec42783          	lw	a5,-20(s0)
}
     41c:	853e                	mv	a0,a5
     41e:	70a2                	ld	ra,40(sp)
     420:	7402                	ld	s0,32(sp)
     422:	6145                	addi	sp,sp,48
     424:	8082                	ret

0000000000000426 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     426:	7139                	addi	sp,sp,-64
     428:	fc06                	sd	ra,56(sp)
     42a:	f822                	sd	s0,48(sp)
     42c:	0080                	addi	s0,sp,64
     42e:	fca43c23          	sd	a0,-40(s0)
     432:	fcb43823          	sd	a1,-48(s0)
     436:	87b2                	mv	a5,a2
     438:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     43c:	fd843783          	ld	a5,-40(s0)
     440:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     444:	fd043783          	ld	a5,-48(s0)
     448:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     44c:	fe043703          	ld	a4,-32(s0)
     450:	fe843783          	ld	a5,-24(s0)
     454:	02e7fc63          	bgeu	a5,a4,48c <memmove+0x66>
    while(n-- > 0)
     458:	a00d                	j	47a <memmove+0x54>
      *dst++ = *src++;
     45a:	fe043703          	ld	a4,-32(s0)
     45e:	00170793          	addi	a5,a4,1
     462:	fef43023          	sd	a5,-32(s0)
     466:	fe843783          	ld	a5,-24(s0)
     46a:	00178693          	addi	a3,a5,1
     46e:	fed43423          	sd	a3,-24(s0)
     472:	00074703          	lbu	a4,0(a4)
     476:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     47a:	fcc42783          	lw	a5,-52(s0)
     47e:	fff7871b          	addiw	a4,a5,-1
     482:	fce42623          	sw	a4,-52(s0)
     486:	fcf04ae3          	bgtz	a5,45a <memmove+0x34>
     48a:	a891                	j	4de <memmove+0xb8>
  } else {
    dst += n;
     48c:	fcc42783          	lw	a5,-52(s0)
     490:	fe843703          	ld	a4,-24(s0)
     494:	97ba                	add	a5,a5,a4
     496:	fef43423          	sd	a5,-24(s0)
    src += n;
     49a:	fcc42783          	lw	a5,-52(s0)
     49e:	fe043703          	ld	a4,-32(s0)
     4a2:	97ba                	add	a5,a5,a4
     4a4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     4a8:	a01d                	j	4ce <memmove+0xa8>
      *--dst = *--src;
     4aa:	fe043783          	ld	a5,-32(s0)
     4ae:	17fd                	addi	a5,a5,-1
     4b0:	fef43023          	sd	a5,-32(s0)
     4b4:	fe843783          	ld	a5,-24(s0)
     4b8:	17fd                	addi	a5,a5,-1
     4ba:	fef43423          	sd	a5,-24(s0)
     4be:	fe043783          	ld	a5,-32(s0)
     4c2:	0007c703          	lbu	a4,0(a5)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4ce:	fcc42783          	lw	a5,-52(s0)
     4d2:	fff7871b          	addiw	a4,a5,-1
     4d6:	fce42623          	sw	a4,-52(s0)
     4da:	fcf048e3          	bgtz	a5,4aa <memmove+0x84>
  }
  return vdst;
     4de:	fd843783          	ld	a5,-40(s0)
}
     4e2:	853e                	mv	a0,a5
     4e4:	70e2                	ld	ra,56(sp)
     4e6:	7442                	ld	s0,48(sp)
     4e8:	6121                	addi	sp,sp,64
     4ea:	8082                	ret

00000000000004ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4ec:	7139                	addi	sp,sp,-64
     4ee:	fc06                	sd	ra,56(sp)
     4f0:	f822                	sd	s0,48(sp)
     4f2:	0080                	addi	s0,sp,64
     4f4:	fca43c23          	sd	a0,-40(s0)
     4f8:	fcb43823          	sd	a1,-48(s0)
     4fc:	87b2                	mv	a5,a2
     4fe:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     502:	fd843783          	ld	a5,-40(s0)
     506:	fef43423          	sd	a5,-24(s0)
     50a:	fd043783          	ld	a5,-48(s0)
     50e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     512:	a0a1                	j	55a <memcmp+0x6e>
    if (*p1 != *p2) {
     514:	fe843783          	ld	a5,-24(s0)
     518:	0007c703          	lbu	a4,0(a5)
     51c:	fe043783          	ld	a5,-32(s0)
     520:	0007c783          	lbu	a5,0(a5)
     524:	02f70163          	beq	a4,a5,546 <memcmp+0x5a>
      return *p1 - *p2;
     528:	fe843783          	ld	a5,-24(s0)
     52c:	0007c783          	lbu	a5,0(a5)
     530:	0007871b          	sext.w	a4,a5
     534:	fe043783          	ld	a5,-32(s0)
     538:	0007c783          	lbu	a5,0(a5)
     53c:	2781                	sext.w	a5,a5
     53e:	40f707bb          	subw	a5,a4,a5
     542:	2781                	sext.w	a5,a5
     544:	a01d                	j	56a <memcmp+0x7e>
    }
    p1++;
     546:	fe843783          	ld	a5,-24(s0)
     54a:	0785                	addi	a5,a5,1
     54c:	fef43423          	sd	a5,-24(s0)
    p2++;
     550:	fe043783          	ld	a5,-32(s0)
     554:	0785                	addi	a5,a5,1
     556:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     55a:	fcc42783          	lw	a5,-52(s0)
     55e:	fff7871b          	addiw	a4,a5,-1
     562:	fce42623          	sw	a4,-52(s0)
     566:	f7dd                	bnez	a5,514 <memcmp+0x28>
  }
  return 0;
     568:	4781                	li	a5,0
}
     56a:	853e                	mv	a0,a5
     56c:	70e2                	ld	ra,56(sp)
     56e:	7442                	ld	s0,48(sp)
     570:	6121                	addi	sp,sp,64
     572:	8082                	ret

0000000000000574 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     574:	7179                	addi	sp,sp,-48
     576:	f406                	sd	ra,40(sp)
     578:	f022                	sd	s0,32(sp)
     57a:	1800                	addi	s0,sp,48
     57c:	fea43423          	sd	a0,-24(s0)
     580:	feb43023          	sd	a1,-32(s0)
     584:	87b2                	mv	a5,a2
     586:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     58a:	fdc42783          	lw	a5,-36(s0)
     58e:	863e                	mv	a2,a5
     590:	fe043583          	ld	a1,-32(s0)
     594:	fe843503          	ld	a0,-24(s0)
     598:	e8fff0ef          	jal	426 <memmove>
     59c:	87aa                	mv	a5,a0
}
     59e:	853e                	mv	a0,a5
     5a0:	70a2                	ld	ra,40(sp)
     5a2:	7402                	ld	s0,32(sp)
     5a4:	6145                	addi	sp,sp,48
     5a6:	8082                	ret

00000000000005a8 <sbrk>:

char *
sbrk(int n) {
     5a8:	1101                	addi	sp,sp,-32
     5aa:	ec06                	sd	ra,24(sp)
     5ac:	e822                	sd	s0,16(sp)
     5ae:	1000                	addi	s0,sp,32
     5b0:	87aa                	mv	a5,a0
     5b2:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     5b6:	fec42783          	lw	a5,-20(s0)
     5ba:	4585                	li	a1,1
     5bc:	853e                	mv	a0,a5
     5be:	0c6000ef          	jal	684 <sys_sbrk>
     5c2:	87aa                	mv	a5,a0
}
     5c4:	853e                	mv	a0,a5
     5c6:	60e2                	ld	ra,24(sp)
     5c8:	6442                	ld	s0,16(sp)
     5ca:	6105                	addi	sp,sp,32
     5cc:	8082                	ret

00000000000005ce <sbrklazy>:

char *
sbrklazy(int n) {
     5ce:	1101                	addi	sp,sp,-32
     5d0:	ec06                	sd	ra,24(sp)
     5d2:	e822                	sd	s0,16(sp)
     5d4:	1000                	addi	s0,sp,32
     5d6:	87aa                	mv	a5,a0
     5d8:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     5dc:	fec42783          	lw	a5,-20(s0)
     5e0:	4589                	li	a1,2
     5e2:	853e                	mv	a0,a5
     5e4:	0a0000ef          	jal	684 <sys_sbrk>
     5e8:	87aa                	mv	a5,a0
}
     5ea:	853e                	mv	a0,a5
     5ec:	60e2                	ld	ra,24(sp)
     5ee:	6442                	ld	s0,16(sp)
     5f0:	6105                	addi	sp,sp,32
     5f2:	8082                	ret

00000000000005f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     5f4:	4885                	li	a7,1
 ecall
     5f6:	00000073          	ecall
 ret
     5fa:	8082                	ret

00000000000005fc <exit>:
.global exit
exit:
 li a7, SYS_exit
     5fc:	4889                	li	a7,2
 ecall
     5fe:	00000073          	ecall
 ret
     602:	8082                	ret

0000000000000604 <wait>:
.global wait
wait:
 li a7, SYS_wait
     604:	488d                	li	a7,3
 ecall
     606:	00000073          	ecall
 ret
     60a:	8082                	ret

000000000000060c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     60c:	4891                	li	a7,4
 ecall
     60e:	00000073          	ecall
 ret
     612:	8082                	ret

0000000000000614 <read>:
.global read
read:
 li a7, SYS_read
     614:	4895                	li	a7,5
 ecall
     616:	00000073          	ecall
 ret
     61a:	8082                	ret

000000000000061c <write>:
.global write
write:
 li a7, SYS_write
     61c:	48c1                	li	a7,16
 ecall
     61e:	00000073          	ecall
 ret
     622:	8082                	ret

0000000000000624 <close>:
.global close
close:
 li a7, SYS_close
     624:	48d5                	li	a7,21
 ecall
     626:	00000073          	ecall
 ret
     62a:	8082                	ret

000000000000062c <kill>:
.global kill
kill:
 li a7, SYS_kill
     62c:	4899                	li	a7,6
 ecall
     62e:	00000073          	ecall
 ret
     632:	8082                	ret

0000000000000634 <exec>:
.global exec
exec:
 li a7, SYS_exec
     634:	489d                	li	a7,7
 ecall
     636:	00000073          	ecall
 ret
     63a:	8082                	ret

000000000000063c <open>:
.global open
open:
 li a7, SYS_open
     63c:	48bd                	li	a7,15
 ecall
     63e:	00000073          	ecall
 ret
     642:	8082                	ret

0000000000000644 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     644:	48c5                	li	a7,17
 ecall
     646:	00000073          	ecall
 ret
     64a:	8082                	ret

000000000000064c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     64c:	48c9                	li	a7,18
 ecall
     64e:	00000073          	ecall
 ret
     652:	8082                	ret

0000000000000654 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     654:	48a1                	li	a7,8
 ecall
     656:	00000073          	ecall
 ret
     65a:	8082                	ret

000000000000065c <link>:
.global link
link:
 li a7, SYS_link
     65c:	48cd                	li	a7,19
 ecall
     65e:	00000073          	ecall
 ret
     662:	8082                	ret

0000000000000664 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     664:	48d1                	li	a7,20
 ecall
     666:	00000073          	ecall
 ret
     66a:	8082                	ret

000000000000066c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     66c:	48a5                	li	a7,9
 ecall
     66e:	00000073          	ecall
 ret
     672:	8082                	ret

0000000000000674 <dup>:
.global dup
dup:
 li a7, SYS_dup
     674:	48a9                	li	a7,10
 ecall
     676:	00000073          	ecall
 ret
     67a:	8082                	ret

000000000000067c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     67c:	48ad                	li	a7,11
 ecall
     67e:	00000073          	ecall
 ret
     682:	8082                	ret

0000000000000684 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     684:	48b1                	li	a7,12
 ecall
     686:	00000073          	ecall
 ret
     68a:	8082                	ret

000000000000068c <pause>:
.global pause
pause:
 li a7, SYS_pause
     68c:	48b5                	li	a7,13
 ecall
     68e:	00000073          	ecall
 ret
     692:	8082                	ret

0000000000000694 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     694:	48b9                	li	a7,14
 ecall
     696:	00000073          	ecall
 ret
     69a:	8082                	ret

000000000000069c <top>:
.global top
top:
 li a7, SYS_top
     69c:	48d9                	li	a7,22
 ecall
     69e:	00000073          	ecall
 ret
     6a2:	8082                	ret

00000000000006a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6a4:	1101                	addi	sp,sp,-32
     6a6:	ec06                	sd	ra,24(sp)
     6a8:	e822                	sd	s0,16(sp)
     6aa:	1000                	addi	s0,sp,32
     6ac:	87aa                	mv	a5,a0
     6ae:	872e                	mv	a4,a1
     6b0:	fef42623          	sw	a5,-20(s0)
     6b4:	87ba                	mv	a5,a4
     6b6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6ba:	feb40713          	addi	a4,s0,-21
     6be:	fec42783          	lw	a5,-20(s0)
     6c2:	4605                	li	a2,1
     6c4:	85ba                	mv	a1,a4
     6c6:	853e                	mv	a0,a5
     6c8:	f55ff0ef          	jal	61c <write>
}
     6cc:	0001                	nop
     6ce:	60e2                	ld	ra,24(sp)
     6d0:	6442                	ld	s0,16(sp)
     6d2:	6105                	addi	sp,sp,32
     6d4:	8082                	ret

00000000000006d6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     6d6:	711d                	addi	sp,sp,-96
     6d8:	ec86                	sd	ra,88(sp)
     6da:	e8a2                	sd	s0,80(sp)
     6dc:	1080                	addi	s0,sp,96
     6de:	87aa                	mv	a5,a0
     6e0:	fab43823          	sd	a1,-80(s0)
     6e4:	8736                	mv	a4,a3
     6e6:	faf42e23          	sw	a5,-68(s0)
     6ea:	87b2                	mv	a5,a2
     6ec:	faf42c23          	sw	a5,-72(s0)
     6f0:	87ba                	mv	a5,a4
     6f2:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     6f6:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6fa:	fac42783          	lw	a5,-84(s0)
     6fe:	2781                	sext.w	a5,a5
     700:	cf99                	beqz	a5,71e <printint+0x48>
     702:	fb043783          	ld	a5,-80(s0)
     706:	0007dc63          	bgez	a5,71e <printint+0x48>
    neg = 1;
     70a:	4785                	li	a5,1
     70c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     710:	fb043783          	ld	a5,-80(s0)
     714:	40f007b3          	neg	a5,a5
     718:	fef43023          	sd	a5,-32(s0)
     71c:	a029                	j	726 <printint+0x50>
  } else {
    x = xx;
     71e:	fb043783          	ld	a5,-80(s0)
     722:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     726:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     72a:	fb842783          	lw	a5,-72(s0)
     72e:	fe043703          	ld	a4,-32(s0)
     732:	02f77733          	remu	a4,a4,a5
     736:	fec42783          	lw	a5,-20(s0)
     73a:	0017869b          	addiw	a3,a5,1
     73e:	fed42623          	sw	a3,-20(s0)
     742:	00002697          	auipc	a3,0x2
     746:	8ce68693          	addi	a3,a3,-1842 # 2010 <digits>
     74a:	9736                	add	a4,a4,a3
     74c:	00074703          	lbu	a4,0(a4)
     750:	17c1                	addi	a5,a5,-16
     752:	97a2                	add	a5,a5,s0
     754:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     758:	fb842783          	lw	a5,-72(s0)
     75c:	fe043703          	ld	a4,-32(s0)
     760:	02f757b3          	divu	a5,a4,a5
     764:	fef43023          	sd	a5,-32(s0)
     768:	fe043783          	ld	a5,-32(s0)
     76c:	ffdd                	bnez	a5,72a <printint+0x54>
  if(neg)
     76e:	fe842783          	lw	a5,-24(s0)
     772:	2781                	sext.w	a5,a5
     774:	cb95                	beqz	a5,7a8 <printint+0xd2>
    buf[i++] = '-';
     776:	fec42783          	lw	a5,-20(s0)
     77a:	0017871b          	addiw	a4,a5,1
     77e:	fee42623          	sw	a4,-20(s0)
     782:	17c1                	addi	a5,a5,-16
     784:	97a2                	add	a5,a5,s0
     786:	02d00713          	li	a4,45
     78a:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     78e:	a829                	j	7a8 <printint+0xd2>
    putc(fd, buf[i]);
     790:	fec42783          	lw	a5,-20(s0)
     794:	17c1                	addi	a5,a5,-16
     796:	97a2                	add	a5,a5,s0
     798:	fd87c703          	lbu	a4,-40(a5)
     79c:	fbc42783          	lw	a5,-68(s0)
     7a0:	85ba                	mv	a1,a4
     7a2:	853e                	mv	a0,a5
     7a4:	f01ff0ef          	jal	6a4 <putc>
  while(--i >= 0)
     7a8:	fec42783          	lw	a5,-20(s0)
     7ac:	37fd                	addiw	a5,a5,-1
     7ae:	fef42623          	sw	a5,-20(s0)
     7b2:	fec42783          	lw	a5,-20(s0)
     7b6:	2781                	sext.w	a5,a5
     7b8:	fc07dce3          	bgez	a5,790 <printint+0xba>
}
     7bc:	0001                	nop
     7be:	0001                	nop
     7c0:	60e6                	ld	ra,88(sp)
     7c2:	6446                	ld	s0,80(sp)
     7c4:	6125                	addi	sp,sp,96
     7c6:	8082                	ret

00000000000007c8 <printptr>:

static void
printptr(int fd, uint64 x) {
     7c8:	7179                	addi	sp,sp,-48
     7ca:	f406                	sd	ra,40(sp)
     7cc:	f022                	sd	s0,32(sp)
     7ce:	1800                	addi	s0,sp,48
     7d0:	87aa                	mv	a5,a0
     7d2:	fcb43823          	sd	a1,-48(s0)
     7d6:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7da:	fdc42783          	lw	a5,-36(s0)
     7de:	03000593          	li	a1,48
     7e2:	853e                	mv	a0,a5
     7e4:	ec1ff0ef          	jal	6a4 <putc>
  putc(fd, 'x');
     7e8:	fdc42783          	lw	a5,-36(s0)
     7ec:	07800593          	li	a1,120
     7f0:	853e                	mv	a0,a5
     7f2:	eb3ff0ef          	jal	6a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7f6:	fe042623          	sw	zero,-20(s0)
     7fa:	a81d                	j	830 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7fc:	fd043783          	ld	a5,-48(s0)
     800:	93f1                	srli	a5,a5,0x3c
     802:	00002717          	auipc	a4,0x2
     806:	80e70713          	addi	a4,a4,-2034 # 2010 <digits>
     80a:	97ba                	add	a5,a5,a4
     80c:	0007c703          	lbu	a4,0(a5)
     810:	fdc42783          	lw	a5,-36(s0)
     814:	85ba                	mv	a1,a4
     816:	853e                	mv	a0,a5
     818:	e8dff0ef          	jal	6a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     81c:	fec42783          	lw	a5,-20(s0)
     820:	2785                	addiw	a5,a5,1
     822:	fef42623          	sw	a5,-20(s0)
     826:	fd043783          	ld	a5,-48(s0)
     82a:	0792                	slli	a5,a5,0x4
     82c:	fcf43823          	sd	a5,-48(s0)
     830:	fec42703          	lw	a4,-20(s0)
     834:	47bd                	li	a5,15
     836:	fce7f3e3          	bgeu	a5,a4,7fc <printptr+0x34>
}
     83a:	0001                	nop
     83c:	0001                	nop
     83e:	70a2                	ld	ra,40(sp)
     840:	7402                	ld	s0,32(sp)
     842:	6145                	addi	sp,sp,48
     844:	8082                	ret

0000000000000846 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     846:	715d                	addi	sp,sp,-80
     848:	e486                	sd	ra,72(sp)
     84a:	e0a2                	sd	s0,64(sp)
     84c:	0880                	addi	s0,sp,80
     84e:	87aa                	mv	a5,a0
     850:	fcb43023          	sd	a1,-64(s0)
     854:	fac43c23          	sd	a2,-72(s0)
     858:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     85c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     860:	fc042e23          	sw	zero,-36(s0)
     864:	a189                	j	ca6 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     866:	fdc42783          	lw	a5,-36(s0)
     86a:	fc043703          	ld	a4,-64(s0)
     86e:	97ba                	add	a5,a5,a4
     870:	0007c783          	lbu	a5,0(a5)
     874:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     878:	fd842783          	lw	a5,-40(s0)
     87c:	2781                	sext.w	a5,a5
     87e:	eb8d                	bnez	a5,8b0 <vprintf+0x6a>
      if(c0 == '%'){
     880:	fd442783          	lw	a5,-44(s0)
     884:	0007871b          	sext.w	a4,a5
     888:	02500793          	li	a5,37
     88c:	00f71763          	bne	a4,a5,89a <vprintf+0x54>
        state = '%';
     890:	02500793          	li	a5,37
     894:	fcf42c23          	sw	a5,-40(s0)
     898:	a111                	j	c9c <vprintf+0x456>
      } else {
        putc(fd, c0);
     89a:	fd442783          	lw	a5,-44(s0)
     89e:	0ff7f713          	zext.b	a4,a5
     8a2:	fcc42783          	lw	a5,-52(s0)
     8a6:	85ba                	mv	a1,a4
     8a8:	853e                	mv	a0,a5
     8aa:	dfbff0ef          	jal	6a4 <putc>
     8ae:	a6fd                	j	c9c <vprintf+0x456>
      }
    } else if(state == '%'){
     8b0:	fd842783          	lw	a5,-40(s0)
     8b4:	0007871b          	sext.w	a4,a5
     8b8:	02500793          	li	a5,37
     8bc:	3ef71063          	bne	a4,a5,c9c <vprintf+0x456>
      c1 = c2 = 0;
     8c0:	fe042023          	sw	zero,-32(s0)
     8c4:	fe042783          	lw	a5,-32(s0)
     8c8:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     8cc:	fd442783          	lw	a5,-44(s0)
     8d0:	2781                	sext.w	a5,a5
     8d2:	cb99                	beqz	a5,8e8 <vprintf+0xa2>
     8d4:	fdc42783          	lw	a5,-36(s0)
     8d8:	0785                	addi	a5,a5,1
     8da:	fc043703          	ld	a4,-64(s0)
     8de:	97ba                	add	a5,a5,a4
     8e0:	0007c783          	lbu	a5,0(a5)
     8e4:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     8e8:	fe442783          	lw	a5,-28(s0)
     8ec:	2781                	sext.w	a5,a5
     8ee:	cb99                	beqz	a5,904 <vprintf+0xbe>
     8f0:	fdc42783          	lw	a5,-36(s0)
     8f4:	0789                	addi	a5,a5,2
     8f6:	fc043703          	ld	a4,-64(s0)
     8fa:	97ba                	add	a5,a5,a4
     8fc:	0007c783          	lbu	a5,0(a5)
     900:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     904:	fd442783          	lw	a5,-44(s0)
     908:	0007871b          	sext.w	a4,a5
     90c:	06400793          	li	a5,100
     910:	02f71363          	bne	a4,a5,936 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     914:	fb843783          	ld	a5,-72(s0)
     918:	00878713          	addi	a4,a5,8
     91c:	fae43c23          	sd	a4,-72(s0)
     920:	439c                	lw	a5,0(a5)
     922:	873e                	mv	a4,a5
     924:	fcc42783          	lw	a5,-52(s0)
     928:	4685                	li	a3,1
     92a:	4629                	li	a2,10
     92c:	85ba                	mv	a1,a4
     92e:	853e                	mv	a0,a5
     930:	da7ff0ef          	jal	6d6 <printint>
     934:	a695                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     936:	fd442783          	lw	a5,-44(s0)
     93a:	0007871b          	sext.w	a4,a5
     93e:	06c00793          	li	a5,108
     942:	04f71063          	bne	a4,a5,982 <vprintf+0x13c>
     946:	fe442783          	lw	a5,-28(s0)
     94a:	0007871b          	sext.w	a4,a5
     94e:	06400793          	li	a5,100
     952:	02f71863          	bne	a4,a5,982 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     956:	fb843783          	ld	a5,-72(s0)
     95a:	00878713          	addi	a4,a5,8
     95e:	fae43c23          	sd	a4,-72(s0)
     962:	639c                	ld	a5,0(a5)
     964:	873e                	mv	a4,a5
     966:	fcc42783          	lw	a5,-52(s0)
     96a:	4685                	li	a3,1
     96c:	4629                	li	a2,10
     96e:	85ba                	mv	a1,a4
     970:	853e                	mv	a0,a5
     972:	d65ff0ef          	jal	6d6 <printint>
        i += 1;
     976:	fdc42783          	lw	a5,-36(s0)
     97a:	2785                	addiw	a5,a5,1
     97c:	fcf42e23          	sw	a5,-36(s0)
     980:	ae21                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     982:	fd442783          	lw	a5,-44(s0)
     986:	0007871b          	sext.w	a4,a5
     98a:	06c00793          	li	a5,108
     98e:	04f71863          	bne	a4,a5,9de <vprintf+0x198>
     992:	fe442783          	lw	a5,-28(s0)
     996:	0007871b          	sext.w	a4,a5
     99a:	06c00793          	li	a5,108
     99e:	04f71063          	bne	a4,a5,9de <vprintf+0x198>
     9a2:	fe042783          	lw	a5,-32(s0)
     9a6:	0007871b          	sext.w	a4,a5
     9aa:	06400793          	li	a5,100
     9ae:	02f71863          	bne	a4,a5,9de <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9b2:	fb843783          	ld	a5,-72(s0)
     9b6:	00878713          	addi	a4,a5,8
     9ba:	fae43c23          	sd	a4,-72(s0)
     9be:	639c                	ld	a5,0(a5)
     9c0:	873e                	mv	a4,a5
     9c2:	fcc42783          	lw	a5,-52(s0)
     9c6:	4685                	li	a3,1
     9c8:	4629                	li	a2,10
     9ca:	85ba                	mv	a1,a4
     9cc:	853e                	mv	a0,a5
     9ce:	d09ff0ef          	jal	6d6 <printint>
        i += 2;
     9d2:	fdc42783          	lw	a5,-36(s0)
     9d6:	2789                	addiw	a5,a5,2
     9d8:	fcf42e23          	sw	a5,-36(s0)
     9dc:	ac75                	j	c98 <vprintf+0x452>
      } else if(c0 == 'u'){
     9de:	fd442783          	lw	a5,-44(s0)
     9e2:	0007871b          	sext.w	a4,a5
     9e6:	07500793          	li	a5,117
     9ea:	02f71563          	bne	a4,a5,a14 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     9ee:	fb843783          	ld	a5,-72(s0)
     9f2:	00878713          	addi	a4,a5,8
     9f6:	fae43c23          	sd	a4,-72(s0)
     9fa:	439c                	lw	a5,0(a5)
     9fc:	02079713          	slli	a4,a5,0x20
     a00:	9301                	srli	a4,a4,0x20
     a02:	fcc42783          	lw	a5,-52(s0)
     a06:	4681                	li	a3,0
     a08:	4629                	li	a2,10
     a0a:	85ba                	mv	a1,a4
     a0c:	853e                	mv	a0,a5
     a0e:	cc9ff0ef          	jal	6d6 <printint>
     a12:	a459                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a14:	fd442783          	lw	a5,-44(s0)
     a18:	0007871b          	sext.w	a4,a5
     a1c:	06c00793          	li	a5,108
     a20:	04f71063          	bne	a4,a5,a60 <vprintf+0x21a>
     a24:	fe442783          	lw	a5,-28(s0)
     a28:	0007871b          	sext.w	a4,a5
     a2c:	07500793          	li	a5,117
     a30:	02f71863          	bne	a4,a5,a60 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a34:	fb843783          	ld	a5,-72(s0)
     a38:	00878713          	addi	a4,a5,8
     a3c:	fae43c23          	sd	a4,-72(s0)
     a40:	639c                	ld	a5,0(a5)
     a42:	873e                	mv	a4,a5
     a44:	fcc42783          	lw	a5,-52(s0)
     a48:	4681                	li	a3,0
     a4a:	4629                	li	a2,10
     a4c:	85ba                	mv	a1,a4
     a4e:	853e                	mv	a0,a5
     a50:	c87ff0ef          	jal	6d6 <printint>
        i += 1;
     a54:	fdc42783          	lw	a5,-36(s0)
     a58:	2785                	addiw	a5,a5,1
     a5a:	fcf42e23          	sw	a5,-36(s0)
     a5e:	ac2d                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     a60:	fd442783          	lw	a5,-44(s0)
     a64:	0007871b          	sext.w	a4,a5
     a68:	06c00793          	li	a5,108
     a6c:	04f71863          	bne	a4,a5,abc <vprintf+0x276>
     a70:	fe442783          	lw	a5,-28(s0)
     a74:	0007871b          	sext.w	a4,a5
     a78:	06c00793          	li	a5,108
     a7c:	04f71063          	bne	a4,a5,abc <vprintf+0x276>
     a80:	fe042783          	lw	a5,-32(s0)
     a84:	0007871b          	sext.w	a4,a5
     a88:	07500793          	li	a5,117
     a8c:	02f71863          	bne	a4,a5,abc <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a90:	fb843783          	ld	a5,-72(s0)
     a94:	00878713          	addi	a4,a5,8
     a98:	fae43c23          	sd	a4,-72(s0)
     a9c:	639c                	ld	a5,0(a5)
     a9e:	873e                	mv	a4,a5
     aa0:	fcc42783          	lw	a5,-52(s0)
     aa4:	4681                	li	a3,0
     aa6:	4629                	li	a2,10
     aa8:	85ba                	mv	a1,a4
     aaa:	853e                	mv	a0,a5
     aac:	c2bff0ef          	jal	6d6 <printint>
        i += 2;
     ab0:	fdc42783          	lw	a5,-36(s0)
     ab4:	2789                	addiw	a5,a5,2
     ab6:	fcf42e23          	sw	a5,-36(s0)
     aba:	aaf9                	j	c98 <vprintf+0x452>
      } else if(c0 == 'x'){
     abc:	fd442783          	lw	a5,-44(s0)
     ac0:	0007871b          	sext.w	a4,a5
     ac4:	07800793          	li	a5,120
     ac8:	02f71563          	bne	a4,a5,af2 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     acc:	fb843783          	ld	a5,-72(s0)
     ad0:	00878713          	addi	a4,a5,8
     ad4:	fae43c23          	sd	a4,-72(s0)
     ad8:	439c                	lw	a5,0(a5)
     ada:	02079713          	slli	a4,a5,0x20
     ade:	9301                	srli	a4,a4,0x20
     ae0:	fcc42783          	lw	a5,-52(s0)
     ae4:	4681                	li	a3,0
     ae6:	4641                	li	a2,16
     ae8:	85ba                	mv	a1,a4
     aea:	853e                	mv	a0,a5
     aec:	bebff0ef          	jal	6d6 <printint>
     af0:	a265                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     af2:	fd442783          	lw	a5,-44(s0)
     af6:	0007871b          	sext.w	a4,a5
     afa:	06c00793          	li	a5,108
     afe:	04f71063          	bne	a4,a5,b3e <vprintf+0x2f8>
     b02:	fe442783          	lw	a5,-28(s0)
     b06:	0007871b          	sext.w	a4,a5
     b0a:	07800793          	li	a5,120
     b0e:	02f71863          	bne	a4,a5,b3e <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b12:	fb843783          	ld	a5,-72(s0)
     b16:	00878713          	addi	a4,a5,8
     b1a:	fae43c23          	sd	a4,-72(s0)
     b1e:	639c                	ld	a5,0(a5)
     b20:	873e                	mv	a4,a5
     b22:	fcc42783          	lw	a5,-52(s0)
     b26:	4681                	li	a3,0
     b28:	4641                	li	a2,16
     b2a:	85ba                	mv	a1,a4
     b2c:	853e                	mv	a0,a5
     b2e:	ba9ff0ef          	jal	6d6 <printint>
        i += 1;
     b32:	fdc42783          	lw	a5,-36(s0)
     b36:	2785                	addiw	a5,a5,1
     b38:	fcf42e23          	sw	a5,-36(s0)
     b3c:	aab1                	j	c98 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     b3e:	fd442783          	lw	a5,-44(s0)
     b42:	0007871b          	sext.w	a4,a5
     b46:	06c00793          	li	a5,108
     b4a:	04f71863          	bne	a4,a5,b9a <vprintf+0x354>
     b4e:	fe442783          	lw	a5,-28(s0)
     b52:	0007871b          	sext.w	a4,a5
     b56:	06c00793          	li	a5,108
     b5a:	04f71063          	bne	a4,a5,b9a <vprintf+0x354>
     b5e:	fe042783          	lw	a5,-32(s0)
     b62:	0007871b          	sext.w	a4,a5
     b66:	07800793          	li	a5,120
     b6a:	02f71863          	bne	a4,a5,b9a <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b6e:	fb843783          	ld	a5,-72(s0)
     b72:	00878713          	addi	a4,a5,8
     b76:	fae43c23          	sd	a4,-72(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	873e                	mv	a4,a5
     b7e:	fcc42783          	lw	a5,-52(s0)
     b82:	4681                	li	a3,0
     b84:	4641                	li	a2,16
     b86:	85ba                	mv	a1,a4
     b88:	853e                	mv	a0,a5
     b8a:	b4dff0ef          	jal	6d6 <printint>
        i += 2;
     b8e:	fdc42783          	lw	a5,-36(s0)
     b92:	2789                	addiw	a5,a5,2
     b94:	fcf42e23          	sw	a5,-36(s0)
     b98:	a201                	j	c98 <vprintf+0x452>
      } else if(c0 == 'p'){
     b9a:	fd442783          	lw	a5,-44(s0)
     b9e:	0007871b          	sext.w	a4,a5
     ba2:	07000793          	li	a5,112
     ba6:	02f71063          	bne	a4,a5,bc6 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     baa:	fb843783          	ld	a5,-72(s0)
     bae:	00878713          	addi	a4,a5,8
     bb2:	fae43c23          	sd	a4,-72(s0)
     bb6:	6398                	ld	a4,0(a5)
     bb8:	fcc42783          	lw	a5,-52(s0)
     bbc:	85ba                	mv	a1,a4
     bbe:	853e                	mv	a0,a5
     bc0:	c09ff0ef          	jal	7c8 <printptr>
     bc4:	a8d1                	j	c98 <vprintf+0x452>
      } else if(c0 == 'c'){
     bc6:	fd442783          	lw	a5,-44(s0)
     bca:	0007871b          	sext.w	a4,a5
     bce:	06300793          	li	a5,99
     bd2:	02f71263          	bne	a4,a5,bf6 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     bd6:	fb843783          	ld	a5,-72(s0)
     bda:	00878713          	addi	a4,a5,8
     bde:	fae43c23          	sd	a4,-72(s0)
     be2:	439c                	lw	a5,0(a5)
     be4:	0ff7f713          	zext.b	a4,a5
     be8:	fcc42783          	lw	a5,-52(s0)
     bec:	85ba                	mv	a1,a4
     bee:	853e                	mv	a0,a5
     bf0:	ab5ff0ef          	jal	6a4 <putc>
     bf4:	a055                	j	c98 <vprintf+0x452>
      } else if(c0 == 's'){
     bf6:	fd442783          	lw	a5,-44(s0)
     bfa:	0007871b          	sext.w	a4,a5
     bfe:	07300793          	li	a5,115
     c02:	04f71a63          	bne	a4,a5,c56 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c06:	fb843783          	ld	a5,-72(s0)
     c0a:	00878713          	addi	a4,a5,8
     c0e:	fae43c23          	sd	a4,-72(s0)
     c12:	639c                	ld	a5,0(a5)
     c14:	fef43423          	sd	a5,-24(s0)
     c18:	fe843783          	ld	a5,-24(s0)
     c1c:	e79d                	bnez	a5,c4a <vprintf+0x404>
          s = "(null)";
     c1e:	00000797          	auipc	a5,0x0
     c22:	49a78793          	addi	a5,a5,1178 # 10b8 <malloc+0x1b8>
     c26:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c2a:	a005                	j	c4a <vprintf+0x404>
          putc(fd, *s);
     c2c:	fe843783          	ld	a5,-24(s0)
     c30:	0007c703          	lbu	a4,0(a5)
     c34:	fcc42783          	lw	a5,-52(s0)
     c38:	85ba                	mv	a1,a4
     c3a:	853e                	mv	a0,a5
     c3c:	a69ff0ef          	jal	6a4 <putc>
        for(; *s; s++)
     c40:	fe843783          	ld	a5,-24(s0)
     c44:	0785                	addi	a5,a5,1
     c46:	fef43423          	sd	a5,-24(s0)
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	0007c783          	lbu	a5,0(a5)
     c52:	ffe9                	bnez	a5,c2c <vprintf+0x3e6>
     c54:	a091                	j	c98 <vprintf+0x452>
      } else if(c0 == '%'){
     c56:	fd442783          	lw	a5,-44(s0)
     c5a:	0007871b          	sext.w	a4,a5
     c5e:	02500793          	li	a5,37
     c62:	00f71a63          	bne	a4,a5,c76 <vprintf+0x430>
        putc(fd, '%');
     c66:	fcc42783          	lw	a5,-52(s0)
     c6a:	02500593          	li	a1,37
     c6e:	853e                	mv	a0,a5
     c70:	a35ff0ef          	jal	6a4 <putc>
     c74:	a015                	j	c98 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c76:	fcc42783          	lw	a5,-52(s0)
     c7a:	02500593          	li	a1,37
     c7e:	853e                	mv	a0,a5
     c80:	a25ff0ef          	jal	6a4 <putc>
        putc(fd, c0);
     c84:	fd442783          	lw	a5,-44(s0)
     c88:	0ff7f713          	zext.b	a4,a5
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	85ba                	mv	a1,a4
     c92:	853e                	mv	a0,a5
     c94:	a11ff0ef          	jal	6a4 <putc>
      }

      state = 0;
     c98:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	2785                	addiw	a5,a5,1
     ca2:	fcf42e23          	sw	a5,-36(s0)
     ca6:	fdc42783          	lw	a5,-36(s0)
     caa:	fc043703          	ld	a4,-64(s0)
     cae:	97ba                	add	a5,a5,a4
     cb0:	0007c783          	lbu	a5,0(a5)
     cb4:	ba0799e3          	bnez	a5,866 <vprintf+0x20>
    }
  }
}
     cb8:	0001                	nop
     cba:	0001                	nop
     cbc:	60a6                	ld	ra,72(sp)
     cbe:	6406                	ld	s0,64(sp)
     cc0:	6161                	addi	sp,sp,80
     cc2:	8082                	ret

0000000000000cc4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     cc4:	7159                	addi	sp,sp,-112
     cc6:	fc06                	sd	ra,56(sp)
     cc8:	f822                	sd	s0,48(sp)
     cca:	0080                	addi	s0,sp,64
     ccc:	fcb43823          	sd	a1,-48(s0)
     cd0:	e010                	sd	a2,0(s0)
     cd2:	e414                	sd	a3,8(s0)
     cd4:	e818                	sd	a4,16(s0)
     cd6:	ec1c                	sd	a5,24(s0)
     cd8:	03043023          	sd	a6,32(s0)
     cdc:	03143423          	sd	a7,40(s0)
     ce0:	87aa                	mv	a5,a0
     ce2:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     ce6:	03040793          	addi	a5,s0,48
     cea:	fcf43423          	sd	a5,-56(s0)
     cee:	fc843783          	ld	a5,-56(s0)
     cf2:	fd078793          	addi	a5,a5,-48
     cf6:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     cfa:	fe843703          	ld	a4,-24(s0)
     cfe:	fdc42783          	lw	a5,-36(s0)
     d02:	863a                	mv	a2,a4
     d04:	fd043583          	ld	a1,-48(s0)
     d08:	853e                	mv	a0,a5
     d0a:	b3dff0ef          	jal	846 <vprintf>
}
     d0e:	0001                	nop
     d10:	70e2                	ld	ra,56(sp)
     d12:	7442                	ld	s0,48(sp)
     d14:	6165                	addi	sp,sp,112
     d16:	8082                	ret

0000000000000d18 <printf>:

void
printf(const char *fmt, ...)
{
     d18:	7159                	addi	sp,sp,-112
     d1a:	f406                	sd	ra,40(sp)
     d1c:	f022                	sd	s0,32(sp)
     d1e:	1800                	addi	s0,sp,48
     d20:	fca43c23          	sd	a0,-40(s0)
     d24:	e40c                	sd	a1,8(s0)
     d26:	e810                	sd	a2,16(s0)
     d28:	ec14                	sd	a3,24(s0)
     d2a:	f018                	sd	a4,32(s0)
     d2c:	f41c                	sd	a5,40(s0)
     d2e:	03043823          	sd	a6,48(s0)
     d32:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d36:	04040793          	addi	a5,s0,64
     d3a:	fcf43823          	sd	a5,-48(s0)
     d3e:	fd043783          	ld	a5,-48(s0)
     d42:	fc878793          	addi	a5,a5,-56
     d46:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d4a:	fe843783          	ld	a5,-24(s0)
     d4e:	863e                	mv	a2,a5
     d50:	fd843583          	ld	a1,-40(s0)
     d54:	4505                	li	a0,1
     d56:	af1ff0ef          	jal	846 <vprintf>
}
     d5a:	0001                	nop
     d5c:	70a2                	ld	ra,40(sp)
     d5e:	7402                	ld	s0,32(sp)
     d60:	6165                	addi	sp,sp,112
     d62:	8082                	ret

0000000000000d64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d64:	7179                	addi	sp,sp,-48
     d66:	f406                	sd	ra,40(sp)
     d68:	f022                	sd	s0,32(sp)
     d6a:	1800                	addi	s0,sp,48
     d6c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d70:	fd843783          	ld	a5,-40(s0)
     d74:	17c1                	addi	a5,a5,-16
     d76:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d7a:	00001797          	auipc	a5,0x1
     d7e:	2c678793          	addi	a5,a5,710 # 2040 <freep>
     d82:	639c                	ld	a5,0(a5)
     d84:	fef43423          	sd	a5,-24(s0)
     d88:	a815                	j	dbc <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d8a:	fe843783          	ld	a5,-24(s0)
     d8e:	639c                	ld	a5,0(a5)
     d90:	fe843703          	ld	a4,-24(s0)
     d94:	00f76f63          	bltu	a4,a5,db2 <free+0x4e>
     d98:	fe043703          	ld	a4,-32(s0)
     d9c:	fe843783          	ld	a5,-24(s0)
     da0:	02e7eb63          	bltu	a5,a4,dd6 <free+0x72>
     da4:	fe843783          	ld	a5,-24(s0)
     da8:	639c                	ld	a5,0(a5)
     daa:	fe043703          	ld	a4,-32(s0)
     dae:	02f76463          	bltu	a4,a5,dd6 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     db2:	fe843783          	ld	a5,-24(s0)
     db6:	639c                	ld	a5,0(a5)
     db8:	fef43423          	sd	a5,-24(s0)
     dbc:	fe043703          	ld	a4,-32(s0)
     dc0:	fe843783          	ld	a5,-24(s0)
     dc4:	fce7f3e3          	bgeu	a5,a4,d8a <free+0x26>
     dc8:	fe843783          	ld	a5,-24(s0)
     dcc:	639c                	ld	a5,0(a5)
     dce:	fe043703          	ld	a4,-32(s0)
     dd2:	faf77ce3          	bgeu	a4,a5,d8a <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     dd6:	fe043783          	ld	a5,-32(s0)
     dda:	479c                	lw	a5,8(a5)
     ddc:	1782                	slli	a5,a5,0x20
     dde:	9381                	srli	a5,a5,0x20
     de0:	0792                	slli	a5,a5,0x4
     de2:	fe043703          	ld	a4,-32(s0)
     de6:	973e                	add	a4,a4,a5
     de8:	fe843783          	ld	a5,-24(s0)
     dec:	639c                	ld	a5,0(a5)
     dee:	02f71763          	bne	a4,a5,e1c <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     df2:	fe043783          	ld	a5,-32(s0)
     df6:	4798                	lw	a4,8(a5)
     df8:	fe843783          	ld	a5,-24(s0)
     dfc:	639c                	ld	a5,0(a5)
     dfe:	479c                	lw	a5,8(a5)
     e00:	9fb9                	addw	a5,a5,a4
     e02:	0007871b          	sext.w	a4,a5
     e06:	fe043783          	ld	a5,-32(s0)
     e0a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e0c:	fe843783          	ld	a5,-24(s0)
     e10:	639c                	ld	a5,0(a5)
     e12:	6398                	ld	a4,0(a5)
     e14:	fe043783          	ld	a5,-32(s0)
     e18:	e398                	sd	a4,0(a5)
     e1a:	a039                	j	e28 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e1c:	fe843783          	ld	a5,-24(s0)
     e20:	6398                	ld	a4,0(a5)
     e22:	fe043783          	ld	a5,-32(s0)
     e26:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e28:	fe843783          	ld	a5,-24(s0)
     e2c:	479c                	lw	a5,8(a5)
     e2e:	1782                	slli	a5,a5,0x20
     e30:	9381                	srli	a5,a5,0x20
     e32:	0792                	slli	a5,a5,0x4
     e34:	fe843703          	ld	a4,-24(s0)
     e38:	97ba                	add	a5,a5,a4
     e3a:	fe043703          	ld	a4,-32(s0)
     e3e:	02f71563          	bne	a4,a5,e68 <free+0x104>
    p->s.size += bp->s.size;
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	4798                	lw	a4,8(a5)
     e48:	fe043783          	ld	a5,-32(s0)
     e4c:	479c                	lw	a5,8(a5)
     e4e:	9fb9                	addw	a5,a5,a4
     e50:	0007871b          	sext.w	a4,a5
     e54:	fe843783          	ld	a5,-24(s0)
     e58:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     e5a:	fe043783          	ld	a5,-32(s0)
     e5e:	6398                	ld	a4,0(a5)
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	e398                	sd	a4,0(a5)
     e66:	a031                	j	e72 <free+0x10e>
  } else
    p->s.ptr = bp;
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	fe043703          	ld	a4,-32(s0)
     e70:	e398                	sd	a4,0(a5)
  freep = p;
     e72:	00001797          	auipc	a5,0x1
     e76:	1ce78793          	addi	a5,a5,462 # 2040 <freep>
     e7a:	fe843703          	ld	a4,-24(s0)
     e7e:	e398                	sd	a4,0(a5)
}
     e80:	0001                	nop
     e82:	70a2                	ld	ra,40(sp)
     e84:	7402                	ld	s0,32(sp)
     e86:	6145                	addi	sp,sp,48
     e88:	8082                	ret

0000000000000e8a <morecore>:

static Header*
morecore(uint nu)
{
     e8a:	7179                	addi	sp,sp,-48
     e8c:	f406                	sd	ra,40(sp)
     e8e:	f022                	sd	s0,32(sp)
     e90:	1800                	addi	s0,sp,48
     e92:	87aa                	mv	a5,a0
     e94:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     e98:	fdc42783          	lw	a5,-36(s0)
     e9c:	0007871b          	sext.w	a4,a5
     ea0:	6785                	lui	a5,0x1
     ea2:	00f77563          	bgeu	a4,a5,eac <morecore+0x22>
    nu = 4096;
     ea6:	6785                	lui	a5,0x1
     ea8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     eac:	fdc42783          	lw	a5,-36(s0)
     eb0:	0047979b          	slliw	a5,a5,0x4
     eb4:	2781                	sext.w	a5,a5
     eb6:	853e                	mv	a0,a5
     eb8:	ef0ff0ef          	jal	5a8 <sbrk>
     ebc:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     ec0:	fe843703          	ld	a4,-24(s0)
     ec4:	57fd                	li	a5,-1
     ec6:	00f71463          	bne	a4,a5,ece <morecore+0x44>
    return 0;
     eca:	4781                	li	a5,0
     ecc:	a02d                	j	ef6 <morecore+0x6c>
  hp = (Header*)p;
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ed6:	fe043783          	ld	a5,-32(s0)
     eda:	fdc42703          	lw	a4,-36(s0)
     ede:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     ee0:	fe043783          	ld	a5,-32(s0)
     ee4:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x110>
     ee6:	853e                	mv	a0,a5
     ee8:	e7dff0ef          	jal	d64 <free>
  return freep;
     eec:	00001797          	auipc	a5,0x1
     ef0:	15478793          	addi	a5,a5,340 # 2040 <freep>
     ef4:	639c                	ld	a5,0(a5)
}
     ef6:	853e                	mv	a0,a5
     ef8:	70a2                	ld	ra,40(sp)
     efa:	7402                	ld	s0,32(sp)
     efc:	6145                	addi	sp,sp,48
     efe:	8082                	ret

0000000000000f00 <malloc>:

void*
malloc(uint nbytes)
{
     f00:	7139                	addi	sp,sp,-64
     f02:	fc06                	sd	ra,56(sp)
     f04:	f822                	sd	s0,48(sp)
     f06:	0080                	addi	s0,sp,64
     f08:	87aa                	mv	a5,a0
     f0a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f0e:	fcc46783          	lwu	a5,-52(s0)
     f12:	07bd                	addi	a5,a5,15
     f14:	8391                	srli	a5,a5,0x4
     f16:	2781                	sext.w	a5,a5
     f18:	2785                	addiw	a5,a5,1
     f1a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f1e:	00001797          	auipc	a5,0x1
     f22:	12278793          	addi	a5,a5,290 # 2040 <freep>
     f26:	639c                	ld	a5,0(a5)
     f28:	fef43023          	sd	a5,-32(s0)
     f2c:	fe043783          	ld	a5,-32(s0)
     f30:	ef95                	bnez	a5,f6c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f32:	00001797          	auipc	a5,0x1
     f36:	0fe78793          	addi	a5,a5,254 # 2030 <base>
     f3a:	fef43023          	sd	a5,-32(s0)
     f3e:	00001797          	auipc	a5,0x1
     f42:	10278793          	addi	a5,a5,258 # 2040 <freep>
     f46:	fe043703          	ld	a4,-32(s0)
     f4a:	e398                	sd	a4,0(a5)
     f4c:	00001797          	auipc	a5,0x1
     f50:	0f478793          	addi	a5,a5,244 # 2040 <freep>
     f54:	6398                	ld	a4,0(a5)
     f56:	00001797          	auipc	a5,0x1
     f5a:	0da78793          	addi	a5,a5,218 # 2030 <base>
     f5e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f60:	00001797          	auipc	a5,0x1
     f64:	0d078793          	addi	a5,a5,208 # 2030 <base>
     f68:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f6c:	fe043783          	ld	a5,-32(s0)
     f70:	639c                	ld	a5,0(a5)
     f72:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	479c                	lw	a5,8(a5)
     f7c:	fdc42703          	lw	a4,-36(s0)
     f80:	2701                	sext.w	a4,a4
     f82:	06e7e763          	bltu	a5,a4,ff0 <malloc+0xf0>
      if(p->s.size == nunits)
     f86:	fe843783          	ld	a5,-24(s0)
     f8a:	479c                	lw	a5,8(a5)
     f8c:	fdc42703          	lw	a4,-36(s0)
     f90:	2701                	sext.w	a4,a4
     f92:	00f71963          	bne	a4,a5,fa4 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f96:	fe843783          	ld	a5,-24(s0)
     f9a:	6398                	ld	a4,0(a5)
     f9c:	fe043783          	ld	a5,-32(s0)
     fa0:	e398                	sd	a4,0(a5)
     fa2:	a825                	j	fda <malloc+0xda>
      else {
        p->s.size -= nunits;
     fa4:	fe843783          	ld	a5,-24(s0)
     fa8:	479c                	lw	a5,8(a5)
     faa:	fdc42703          	lw	a4,-36(s0)
     fae:	9f99                	subw	a5,a5,a4
     fb0:	0007871b          	sext.w	a4,a5
     fb4:	fe843783          	ld	a5,-24(s0)
     fb8:	c798                	sw	a4,8(a5)
        p += p->s.size;
     fba:	fe843783          	ld	a5,-24(s0)
     fbe:	479c                	lw	a5,8(a5)
     fc0:	1782                	slli	a5,a5,0x20
     fc2:	9381                	srli	a5,a5,0x20
     fc4:	0792                	slli	a5,a5,0x4
     fc6:	fe843703          	ld	a4,-24(s0)
     fca:	97ba                	add	a5,a5,a4
     fcc:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     fd0:	fe843783          	ld	a5,-24(s0)
     fd4:	fdc42703          	lw	a4,-36(s0)
     fd8:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     fda:	00001797          	auipc	a5,0x1
     fde:	06678793          	addi	a5,a5,102 # 2040 <freep>
     fe2:	fe043703          	ld	a4,-32(s0)
     fe6:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     fe8:	fe843783          	ld	a5,-24(s0)
     fec:	07c1                	addi	a5,a5,16
     fee:	a081                	j	102e <malloc+0x12e>
    }
    if(p == freep)
     ff0:	00001797          	auipc	a5,0x1
     ff4:	05078793          	addi	a5,a5,80 # 2040 <freep>
     ff8:	639c                	ld	a5,0(a5)
     ffa:	fe843703          	ld	a4,-24(s0)
     ffe:	00f71e63          	bne	a4,a5,101a <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1002:	fdc42783          	lw	a5,-36(s0)
    1006:	853e                	mv	a0,a5
    1008:	e83ff0ef          	jal	e8a <morecore>
    100c:	fea43423          	sd	a0,-24(s0)
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	e399                	bnez	a5,101a <malloc+0x11a>
        return 0;
    1016:	4781                	li	a5,0
    1018:	a819                	j	102e <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    101a:	fe843783          	ld	a5,-24(s0)
    101e:	fef43023          	sd	a5,-32(s0)
    1022:	fe843783          	ld	a5,-24(s0)
    1026:	639c                	ld	a5,0(a5)
    1028:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    102c:	b7a9                	j	f76 <malloc+0x76>
  }
}
    102e:	853e                	mv	a0,a5
    1030:	70e2                	ld	ra,56(sp)
    1032:	7442                	ld	s0,48(sp)
    1034:	6121                	addi	sp,sp,64
    1036:	8082                	ret
