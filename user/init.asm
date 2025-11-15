
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
       e:	03e50513          	addi	a0,a0,62 # 1048 <malloc+0x140>
      12:	62a000ef          	jal	63c <open>
      16:	87aa                	mv	a5,a0
      18:	0207d163          	bgez	a5,3a <main+0x3a>
    mknod("console", CONSOLE, 0);
      1c:	4601                	li	a2,0
      1e:	4585                	li	a1,1
      20:	00001517          	auipc	a0,0x1
      24:	02850513          	addi	a0,a0,40 # 1048 <malloc+0x140>
      28:	61c000ef          	jal	644 <mknod>
    open("console", O_RDWR);
      2c:	4589                	li	a1,2
      2e:	00001517          	auipc	a0,0x1
      32:	01a50513          	addi	a0,a0,26 # 1048 <malloc+0x140>
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
      4a:	00a50513          	addi	a0,a0,10 # 1050 <malloc+0x148>
      4e:	4d3000ef          	jal	d20 <printf>
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
      6a:	00250513          	addi	a0,a0,2 # 1068 <malloc+0x160>
      6e:	4b3000ef          	jal	d20 <printf>
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
      8c:	fb850513          	addi	a0,a0,-72 # 1040 <malloc+0x138>
      90:	5a4000ef          	jal	634 <exec>
      printf("init: exec sh failed\n");
      94:	00001517          	auipc	a0,0x1
      98:	fec50513          	addi	a0,a0,-20 # 1080 <malloc+0x178>
      9c:	485000ef          	jal	d20 <printf>
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
      d2:	fca50513          	addi	a0,a0,-54 # 1098 <malloc+0x190>
      d6:	44b000ef          	jal	d20 <printf>
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

00000000000006a4 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     6a4:	48dd                	li	a7,23
 ecall
     6a6:	00000073          	ecall
 ret
     6aa:	8082                	ret

00000000000006ac <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6ac:	1101                	addi	sp,sp,-32
     6ae:	ec06                	sd	ra,24(sp)
     6b0:	e822                	sd	s0,16(sp)
     6b2:	1000                	addi	s0,sp,32
     6b4:	87aa                	mv	a5,a0
     6b6:	872e                	mv	a4,a1
     6b8:	fef42623          	sw	a5,-20(s0)
     6bc:	87ba                	mv	a5,a4
     6be:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6c2:	feb40713          	addi	a4,s0,-21
     6c6:	fec42783          	lw	a5,-20(s0)
     6ca:	4605                	li	a2,1
     6cc:	85ba                	mv	a1,a4
     6ce:	853e                	mv	a0,a5
     6d0:	f4dff0ef          	jal	61c <write>
}
     6d4:	0001                	nop
     6d6:	60e2                	ld	ra,24(sp)
     6d8:	6442                	ld	s0,16(sp)
     6da:	6105                	addi	sp,sp,32
     6dc:	8082                	ret

00000000000006de <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     6de:	711d                	addi	sp,sp,-96
     6e0:	ec86                	sd	ra,88(sp)
     6e2:	e8a2                	sd	s0,80(sp)
     6e4:	1080                	addi	s0,sp,96
     6e6:	87aa                	mv	a5,a0
     6e8:	fab43823          	sd	a1,-80(s0)
     6ec:	8736                	mv	a4,a3
     6ee:	faf42e23          	sw	a5,-68(s0)
     6f2:	87b2                	mv	a5,a2
     6f4:	faf42c23          	sw	a5,-72(s0)
     6f8:	87ba                	mv	a5,a4
     6fa:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     6fe:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     702:	fac42783          	lw	a5,-84(s0)
     706:	2781                	sext.w	a5,a5
     708:	cf99                	beqz	a5,726 <printint+0x48>
     70a:	fb043783          	ld	a5,-80(s0)
     70e:	0007dc63          	bgez	a5,726 <printint+0x48>
    neg = 1;
     712:	4785                	li	a5,1
     714:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     718:	fb043783          	ld	a5,-80(s0)
     71c:	40f007b3          	neg	a5,a5
     720:	fef43023          	sd	a5,-32(s0)
     724:	a029                	j	72e <printint+0x50>
  } else {
    x = xx;
     726:	fb043783          	ld	a5,-80(s0)
     72a:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     72e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     732:	fb842783          	lw	a5,-72(s0)
     736:	fe043703          	ld	a4,-32(s0)
     73a:	02f77733          	remu	a4,a4,a5
     73e:	fec42783          	lw	a5,-20(s0)
     742:	0017869b          	addiw	a3,a5,1
     746:	fed42623          	sw	a3,-20(s0)
     74a:	00002697          	auipc	a3,0x2
     74e:	8c668693          	addi	a3,a3,-1850 # 2010 <digits>
     752:	9736                	add	a4,a4,a3
     754:	00074703          	lbu	a4,0(a4)
     758:	17c1                	addi	a5,a5,-16
     75a:	97a2                	add	a5,a5,s0
     75c:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     760:	fb842783          	lw	a5,-72(s0)
     764:	fe043703          	ld	a4,-32(s0)
     768:	02f757b3          	divu	a5,a4,a5
     76c:	fef43023          	sd	a5,-32(s0)
     770:	fe043783          	ld	a5,-32(s0)
     774:	ffdd                	bnez	a5,732 <printint+0x54>
  if(neg)
     776:	fe842783          	lw	a5,-24(s0)
     77a:	2781                	sext.w	a5,a5
     77c:	cb95                	beqz	a5,7b0 <printint+0xd2>
    buf[i++] = '-';
     77e:	fec42783          	lw	a5,-20(s0)
     782:	0017871b          	addiw	a4,a5,1
     786:	fee42623          	sw	a4,-20(s0)
     78a:	17c1                	addi	a5,a5,-16
     78c:	97a2                	add	a5,a5,s0
     78e:	02d00713          	li	a4,45
     792:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     796:	a829                	j	7b0 <printint+0xd2>
    putc(fd, buf[i]);
     798:	fec42783          	lw	a5,-20(s0)
     79c:	17c1                	addi	a5,a5,-16
     79e:	97a2                	add	a5,a5,s0
     7a0:	fd87c703          	lbu	a4,-40(a5)
     7a4:	fbc42783          	lw	a5,-68(s0)
     7a8:	85ba                	mv	a1,a4
     7aa:	853e                	mv	a0,a5
     7ac:	f01ff0ef          	jal	6ac <putc>
  while(--i >= 0)
     7b0:	fec42783          	lw	a5,-20(s0)
     7b4:	37fd                	addiw	a5,a5,-1
     7b6:	fef42623          	sw	a5,-20(s0)
     7ba:	fec42783          	lw	a5,-20(s0)
     7be:	2781                	sext.w	a5,a5
     7c0:	fc07dce3          	bgez	a5,798 <printint+0xba>
}
     7c4:	0001                	nop
     7c6:	0001                	nop
     7c8:	60e6                	ld	ra,88(sp)
     7ca:	6446                	ld	s0,80(sp)
     7cc:	6125                	addi	sp,sp,96
     7ce:	8082                	ret

00000000000007d0 <printptr>:

static void
printptr(int fd, uint64 x) {
     7d0:	7179                	addi	sp,sp,-48
     7d2:	f406                	sd	ra,40(sp)
     7d4:	f022                	sd	s0,32(sp)
     7d6:	1800                	addi	s0,sp,48
     7d8:	87aa                	mv	a5,a0
     7da:	fcb43823          	sd	a1,-48(s0)
     7de:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7e2:	fdc42783          	lw	a5,-36(s0)
     7e6:	03000593          	li	a1,48
     7ea:	853e                	mv	a0,a5
     7ec:	ec1ff0ef          	jal	6ac <putc>
  putc(fd, 'x');
     7f0:	fdc42783          	lw	a5,-36(s0)
     7f4:	07800593          	li	a1,120
     7f8:	853e                	mv	a0,a5
     7fa:	eb3ff0ef          	jal	6ac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7fe:	fe042623          	sw	zero,-20(s0)
     802:	a81d                	j	838 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     804:	fd043783          	ld	a5,-48(s0)
     808:	93f1                	srli	a5,a5,0x3c
     80a:	00002717          	auipc	a4,0x2
     80e:	80670713          	addi	a4,a4,-2042 # 2010 <digits>
     812:	97ba                	add	a5,a5,a4
     814:	0007c703          	lbu	a4,0(a5)
     818:	fdc42783          	lw	a5,-36(s0)
     81c:	85ba                	mv	a1,a4
     81e:	853e                	mv	a0,a5
     820:	e8dff0ef          	jal	6ac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     824:	fec42783          	lw	a5,-20(s0)
     828:	2785                	addiw	a5,a5,1
     82a:	fef42623          	sw	a5,-20(s0)
     82e:	fd043783          	ld	a5,-48(s0)
     832:	0792                	slli	a5,a5,0x4
     834:	fcf43823          	sd	a5,-48(s0)
     838:	fec42703          	lw	a4,-20(s0)
     83c:	47bd                	li	a5,15
     83e:	fce7f3e3          	bgeu	a5,a4,804 <printptr+0x34>
}
     842:	0001                	nop
     844:	0001                	nop
     846:	70a2                	ld	ra,40(sp)
     848:	7402                	ld	s0,32(sp)
     84a:	6145                	addi	sp,sp,48
     84c:	8082                	ret

000000000000084e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     84e:	715d                	addi	sp,sp,-80
     850:	e486                	sd	ra,72(sp)
     852:	e0a2                	sd	s0,64(sp)
     854:	0880                	addi	s0,sp,80
     856:	87aa                	mv	a5,a0
     858:	fcb43023          	sd	a1,-64(s0)
     85c:	fac43c23          	sd	a2,-72(s0)
     860:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     864:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     868:	fc042e23          	sw	zero,-36(s0)
     86c:	a189                	j	cae <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     86e:	fdc42783          	lw	a5,-36(s0)
     872:	fc043703          	ld	a4,-64(s0)
     876:	97ba                	add	a5,a5,a4
     878:	0007c783          	lbu	a5,0(a5)
     87c:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     880:	fd842783          	lw	a5,-40(s0)
     884:	2781                	sext.w	a5,a5
     886:	eb8d                	bnez	a5,8b8 <vprintf+0x6a>
      if(c0 == '%'){
     888:	fd442783          	lw	a5,-44(s0)
     88c:	0007871b          	sext.w	a4,a5
     890:	02500793          	li	a5,37
     894:	00f71763          	bne	a4,a5,8a2 <vprintf+0x54>
        state = '%';
     898:	02500793          	li	a5,37
     89c:	fcf42c23          	sw	a5,-40(s0)
     8a0:	a111                	j	ca4 <vprintf+0x456>
      } else {
        putc(fd, c0);
     8a2:	fd442783          	lw	a5,-44(s0)
     8a6:	0ff7f713          	zext.b	a4,a5
     8aa:	fcc42783          	lw	a5,-52(s0)
     8ae:	85ba                	mv	a1,a4
     8b0:	853e                	mv	a0,a5
     8b2:	dfbff0ef          	jal	6ac <putc>
     8b6:	a6fd                	j	ca4 <vprintf+0x456>
      }
    } else if(state == '%'){
     8b8:	fd842783          	lw	a5,-40(s0)
     8bc:	0007871b          	sext.w	a4,a5
     8c0:	02500793          	li	a5,37
     8c4:	3ef71063          	bne	a4,a5,ca4 <vprintf+0x456>
      c1 = c2 = 0;
     8c8:	fe042023          	sw	zero,-32(s0)
     8cc:	fe042783          	lw	a5,-32(s0)
     8d0:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     8d4:	fd442783          	lw	a5,-44(s0)
     8d8:	2781                	sext.w	a5,a5
     8da:	cb99                	beqz	a5,8f0 <vprintf+0xa2>
     8dc:	fdc42783          	lw	a5,-36(s0)
     8e0:	0785                	addi	a5,a5,1
     8e2:	fc043703          	ld	a4,-64(s0)
     8e6:	97ba                	add	a5,a5,a4
     8e8:	0007c783          	lbu	a5,0(a5)
     8ec:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     8f0:	fe442783          	lw	a5,-28(s0)
     8f4:	2781                	sext.w	a5,a5
     8f6:	cb99                	beqz	a5,90c <vprintf+0xbe>
     8f8:	fdc42783          	lw	a5,-36(s0)
     8fc:	0789                	addi	a5,a5,2
     8fe:	fc043703          	ld	a4,-64(s0)
     902:	97ba                	add	a5,a5,a4
     904:	0007c783          	lbu	a5,0(a5)
     908:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     90c:	fd442783          	lw	a5,-44(s0)
     910:	0007871b          	sext.w	a4,a5
     914:	06400793          	li	a5,100
     918:	02f71363          	bne	a4,a5,93e <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     91c:	fb843783          	ld	a5,-72(s0)
     920:	00878713          	addi	a4,a5,8
     924:	fae43c23          	sd	a4,-72(s0)
     928:	439c                	lw	a5,0(a5)
     92a:	873e                	mv	a4,a5
     92c:	fcc42783          	lw	a5,-52(s0)
     930:	4685                	li	a3,1
     932:	4629                	li	a2,10
     934:	85ba                	mv	a1,a4
     936:	853e                	mv	a0,a5
     938:	da7ff0ef          	jal	6de <printint>
     93c:	a695                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     93e:	fd442783          	lw	a5,-44(s0)
     942:	0007871b          	sext.w	a4,a5
     946:	06c00793          	li	a5,108
     94a:	04f71063          	bne	a4,a5,98a <vprintf+0x13c>
     94e:	fe442783          	lw	a5,-28(s0)
     952:	0007871b          	sext.w	a4,a5
     956:	06400793          	li	a5,100
     95a:	02f71863          	bne	a4,a5,98a <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     95e:	fb843783          	ld	a5,-72(s0)
     962:	00878713          	addi	a4,a5,8
     966:	fae43c23          	sd	a4,-72(s0)
     96a:	639c                	ld	a5,0(a5)
     96c:	873e                	mv	a4,a5
     96e:	fcc42783          	lw	a5,-52(s0)
     972:	4685                	li	a3,1
     974:	4629                	li	a2,10
     976:	85ba                	mv	a1,a4
     978:	853e                	mv	a0,a5
     97a:	d65ff0ef          	jal	6de <printint>
        i += 1;
     97e:	fdc42783          	lw	a5,-36(s0)
     982:	2785                	addiw	a5,a5,1
     984:	fcf42e23          	sw	a5,-36(s0)
     988:	ae21                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     98a:	fd442783          	lw	a5,-44(s0)
     98e:	0007871b          	sext.w	a4,a5
     992:	06c00793          	li	a5,108
     996:	04f71863          	bne	a4,a5,9e6 <vprintf+0x198>
     99a:	fe442783          	lw	a5,-28(s0)
     99e:	0007871b          	sext.w	a4,a5
     9a2:	06c00793          	li	a5,108
     9a6:	04f71063          	bne	a4,a5,9e6 <vprintf+0x198>
     9aa:	fe042783          	lw	a5,-32(s0)
     9ae:	0007871b          	sext.w	a4,a5
     9b2:	06400793          	li	a5,100
     9b6:	02f71863          	bne	a4,a5,9e6 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9ba:	fb843783          	ld	a5,-72(s0)
     9be:	00878713          	addi	a4,a5,8
     9c2:	fae43c23          	sd	a4,-72(s0)
     9c6:	639c                	ld	a5,0(a5)
     9c8:	873e                	mv	a4,a5
     9ca:	fcc42783          	lw	a5,-52(s0)
     9ce:	4685                	li	a3,1
     9d0:	4629                	li	a2,10
     9d2:	85ba                	mv	a1,a4
     9d4:	853e                	mv	a0,a5
     9d6:	d09ff0ef          	jal	6de <printint>
        i += 2;
     9da:	fdc42783          	lw	a5,-36(s0)
     9de:	2789                	addiw	a5,a5,2
     9e0:	fcf42e23          	sw	a5,-36(s0)
     9e4:	ac75                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'u'){
     9e6:	fd442783          	lw	a5,-44(s0)
     9ea:	0007871b          	sext.w	a4,a5
     9ee:	07500793          	li	a5,117
     9f2:	02f71563          	bne	a4,a5,a1c <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     9f6:	fb843783          	ld	a5,-72(s0)
     9fa:	00878713          	addi	a4,a5,8
     9fe:	fae43c23          	sd	a4,-72(s0)
     a02:	439c                	lw	a5,0(a5)
     a04:	02079713          	slli	a4,a5,0x20
     a08:	9301                	srli	a4,a4,0x20
     a0a:	fcc42783          	lw	a5,-52(s0)
     a0e:	4681                	li	a3,0
     a10:	4629                	li	a2,10
     a12:	85ba                	mv	a1,a4
     a14:	853e                	mv	a0,a5
     a16:	cc9ff0ef          	jal	6de <printint>
     a1a:	a459                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a1c:	fd442783          	lw	a5,-44(s0)
     a20:	0007871b          	sext.w	a4,a5
     a24:	06c00793          	li	a5,108
     a28:	04f71063          	bne	a4,a5,a68 <vprintf+0x21a>
     a2c:	fe442783          	lw	a5,-28(s0)
     a30:	0007871b          	sext.w	a4,a5
     a34:	07500793          	li	a5,117
     a38:	02f71863          	bne	a4,a5,a68 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a3c:	fb843783          	ld	a5,-72(s0)
     a40:	00878713          	addi	a4,a5,8
     a44:	fae43c23          	sd	a4,-72(s0)
     a48:	639c                	ld	a5,0(a5)
     a4a:	873e                	mv	a4,a5
     a4c:	fcc42783          	lw	a5,-52(s0)
     a50:	4681                	li	a3,0
     a52:	4629                	li	a2,10
     a54:	85ba                	mv	a1,a4
     a56:	853e                	mv	a0,a5
     a58:	c87ff0ef          	jal	6de <printint>
        i += 1;
     a5c:	fdc42783          	lw	a5,-36(s0)
     a60:	2785                	addiw	a5,a5,1
     a62:	fcf42e23          	sw	a5,-36(s0)
     a66:	ac2d                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     a68:	fd442783          	lw	a5,-44(s0)
     a6c:	0007871b          	sext.w	a4,a5
     a70:	06c00793          	li	a5,108
     a74:	04f71863          	bne	a4,a5,ac4 <vprintf+0x276>
     a78:	fe442783          	lw	a5,-28(s0)
     a7c:	0007871b          	sext.w	a4,a5
     a80:	06c00793          	li	a5,108
     a84:	04f71063          	bne	a4,a5,ac4 <vprintf+0x276>
     a88:	fe042783          	lw	a5,-32(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	07500793          	li	a5,117
     a94:	02f71863          	bne	a4,a5,ac4 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     a98:	fb843783          	ld	a5,-72(s0)
     a9c:	00878713          	addi	a4,a5,8
     aa0:	fae43c23          	sd	a4,-72(s0)
     aa4:	639c                	ld	a5,0(a5)
     aa6:	873e                	mv	a4,a5
     aa8:	fcc42783          	lw	a5,-52(s0)
     aac:	4681                	li	a3,0
     aae:	4629                	li	a2,10
     ab0:	85ba                	mv	a1,a4
     ab2:	853e                	mv	a0,a5
     ab4:	c2bff0ef          	jal	6de <printint>
        i += 2;
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	2789                	addiw	a5,a5,2
     abe:	fcf42e23          	sw	a5,-36(s0)
     ac2:	aaf9                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'x'){
     ac4:	fd442783          	lw	a5,-44(s0)
     ac8:	0007871b          	sext.w	a4,a5
     acc:	07800793          	li	a5,120
     ad0:	02f71563          	bne	a4,a5,afa <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     ad4:	fb843783          	ld	a5,-72(s0)
     ad8:	00878713          	addi	a4,a5,8
     adc:	fae43c23          	sd	a4,-72(s0)
     ae0:	439c                	lw	a5,0(a5)
     ae2:	02079713          	slli	a4,a5,0x20
     ae6:	9301                	srli	a4,a4,0x20
     ae8:	fcc42783          	lw	a5,-52(s0)
     aec:	4681                	li	a3,0
     aee:	4641                	li	a2,16
     af0:	85ba                	mv	a1,a4
     af2:	853e                	mv	a0,a5
     af4:	bebff0ef          	jal	6de <printint>
     af8:	a265                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     afa:	fd442783          	lw	a5,-44(s0)
     afe:	0007871b          	sext.w	a4,a5
     b02:	06c00793          	li	a5,108
     b06:	04f71063          	bne	a4,a5,b46 <vprintf+0x2f8>
     b0a:	fe442783          	lw	a5,-28(s0)
     b0e:	0007871b          	sext.w	a4,a5
     b12:	07800793          	li	a5,120
     b16:	02f71863          	bne	a4,a5,b46 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b1a:	fb843783          	ld	a5,-72(s0)
     b1e:	00878713          	addi	a4,a5,8
     b22:	fae43c23          	sd	a4,-72(s0)
     b26:	639c                	ld	a5,0(a5)
     b28:	873e                	mv	a4,a5
     b2a:	fcc42783          	lw	a5,-52(s0)
     b2e:	4681                	li	a3,0
     b30:	4641                	li	a2,16
     b32:	85ba                	mv	a1,a4
     b34:	853e                	mv	a0,a5
     b36:	ba9ff0ef          	jal	6de <printint>
        i += 1;
     b3a:	fdc42783          	lw	a5,-36(s0)
     b3e:	2785                	addiw	a5,a5,1
     b40:	fcf42e23          	sw	a5,-36(s0)
     b44:	aab1                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     b46:	fd442783          	lw	a5,-44(s0)
     b4a:	0007871b          	sext.w	a4,a5
     b4e:	06c00793          	li	a5,108
     b52:	04f71863          	bne	a4,a5,ba2 <vprintf+0x354>
     b56:	fe442783          	lw	a5,-28(s0)
     b5a:	0007871b          	sext.w	a4,a5
     b5e:	06c00793          	li	a5,108
     b62:	04f71063          	bne	a4,a5,ba2 <vprintf+0x354>
     b66:	fe042783          	lw	a5,-32(s0)
     b6a:	0007871b          	sext.w	a4,a5
     b6e:	07800793          	li	a5,120
     b72:	02f71863          	bne	a4,a5,ba2 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b76:	fb843783          	ld	a5,-72(s0)
     b7a:	00878713          	addi	a4,a5,8
     b7e:	fae43c23          	sd	a4,-72(s0)
     b82:	639c                	ld	a5,0(a5)
     b84:	873e                	mv	a4,a5
     b86:	fcc42783          	lw	a5,-52(s0)
     b8a:	4681                	li	a3,0
     b8c:	4641                	li	a2,16
     b8e:	85ba                	mv	a1,a4
     b90:	853e                	mv	a0,a5
     b92:	b4dff0ef          	jal	6de <printint>
        i += 2;
     b96:	fdc42783          	lw	a5,-36(s0)
     b9a:	2789                	addiw	a5,a5,2
     b9c:	fcf42e23          	sw	a5,-36(s0)
     ba0:	a201                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'p'){
     ba2:	fd442783          	lw	a5,-44(s0)
     ba6:	0007871b          	sext.w	a4,a5
     baa:	07000793          	li	a5,112
     bae:	02f71063          	bne	a4,a5,bce <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     bb2:	fb843783          	ld	a5,-72(s0)
     bb6:	00878713          	addi	a4,a5,8
     bba:	fae43c23          	sd	a4,-72(s0)
     bbe:	6398                	ld	a4,0(a5)
     bc0:	fcc42783          	lw	a5,-52(s0)
     bc4:	85ba                	mv	a1,a4
     bc6:	853e                	mv	a0,a5
     bc8:	c09ff0ef          	jal	7d0 <printptr>
     bcc:	a8d1                	j	ca0 <vprintf+0x452>
      } else if(c0 == 'c'){
     bce:	fd442783          	lw	a5,-44(s0)
     bd2:	0007871b          	sext.w	a4,a5
     bd6:	06300793          	li	a5,99
     bda:	02f71263          	bne	a4,a5,bfe <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     bde:	fb843783          	ld	a5,-72(s0)
     be2:	00878713          	addi	a4,a5,8
     be6:	fae43c23          	sd	a4,-72(s0)
     bea:	439c                	lw	a5,0(a5)
     bec:	0ff7f713          	zext.b	a4,a5
     bf0:	fcc42783          	lw	a5,-52(s0)
     bf4:	85ba                	mv	a1,a4
     bf6:	853e                	mv	a0,a5
     bf8:	ab5ff0ef          	jal	6ac <putc>
     bfc:	a055                	j	ca0 <vprintf+0x452>
      } else if(c0 == 's'){
     bfe:	fd442783          	lw	a5,-44(s0)
     c02:	0007871b          	sext.w	a4,a5
     c06:	07300793          	li	a5,115
     c0a:	04f71a63          	bne	a4,a5,c5e <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c0e:	fb843783          	ld	a5,-72(s0)
     c12:	00878713          	addi	a4,a5,8
     c16:	fae43c23          	sd	a4,-72(s0)
     c1a:	639c                	ld	a5,0(a5)
     c1c:	fef43423          	sd	a5,-24(s0)
     c20:	fe843783          	ld	a5,-24(s0)
     c24:	e79d                	bnez	a5,c52 <vprintf+0x404>
          s = "(null)";
     c26:	00000797          	auipc	a5,0x0
     c2a:	49278793          	addi	a5,a5,1170 # 10b8 <malloc+0x1b0>
     c2e:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c32:	a005                	j	c52 <vprintf+0x404>
          putc(fd, *s);
     c34:	fe843783          	ld	a5,-24(s0)
     c38:	0007c703          	lbu	a4,0(a5)
     c3c:	fcc42783          	lw	a5,-52(s0)
     c40:	85ba                	mv	a1,a4
     c42:	853e                	mv	a0,a5
     c44:	a69ff0ef          	jal	6ac <putc>
        for(; *s; s++)
     c48:	fe843783          	ld	a5,-24(s0)
     c4c:	0785                	addi	a5,a5,1
     c4e:	fef43423          	sd	a5,-24(s0)
     c52:	fe843783          	ld	a5,-24(s0)
     c56:	0007c783          	lbu	a5,0(a5)
     c5a:	ffe9                	bnez	a5,c34 <vprintf+0x3e6>
     c5c:	a091                	j	ca0 <vprintf+0x452>
      } else if(c0 == '%'){
     c5e:	fd442783          	lw	a5,-44(s0)
     c62:	0007871b          	sext.w	a4,a5
     c66:	02500793          	li	a5,37
     c6a:	00f71a63          	bne	a4,a5,c7e <vprintf+0x430>
        putc(fd, '%');
     c6e:	fcc42783          	lw	a5,-52(s0)
     c72:	02500593          	li	a1,37
     c76:	853e                	mv	a0,a5
     c78:	a35ff0ef          	jal	6ac <putc>
     c7c:	a015                	j	ca0 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     c7e:	fcc42783          	lw	a5,-52(s0)
     c82:	02500593          	li	a1,37
     c86:	853e                	mv	a0,a5
     c88:	a25ff0ef          	jal	6ac <putc>
        putc(fd, c0);
     c8c:	fd442783          	lw	a5,-44(s0)
     c90:	0ff7f713          	zext.b	a4,a5
     c94:	fcc42783          	lw	a5,-52(s0)
     c98:	85ba                	mv	a1,a4
     c9a:	853e                	mv	a0,a5
     c9c:	a11ff0ef          	jal	6ac <putc>
      }

      state = 0;
     ca0:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     ca4:	fdc42783          	lw	a5,-36(s0)
     ca8:	2785                	addiw	a5,a5,1
     caa:	fcf42e23          	sw	a5,-36(s0)
     cae:	fdc42783          	lw	a5,-36(s0)
     cb2:	fc043703          	ld	a4,-64(s0)
     cb6:	97ba                	add	a5,a5,a4
     cb8:	0007c783          	lbu	a5,0(a5)
     cbc:	ba0799e3          	bnez	a5,86e <vprintf+0x20>
    }
  }
}
     cc0:	0001                	nop
     cc2:	0001                	nop
     cc4:	60a6                	ld	ra,72(sp)
     cc6:	6406                	ld	s0,64(sp)
     cc8:	6161                	addi	sp,sp,80
     cca:	8082                	ret

0000000000000ccc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ccc:	7159                	addi	sp,sp,-112
     cce:	fc06                	sd	ra,56(sp)
     cd0:	f822                	sd	s0,48(sp)
     cd2:	0080                	addi	s0,sp,64
     cd4:	fcb43823          	sd	a1,-48(s0)
     cd8:	e010                	sd	a2,0(s0)
     cda:	e414                	sd	a3,8(s0)
     cdc:	e818                	sd	a4,16(s0)
     cde:	ec1c                	sd	a5,24(s0)
     ce0:	03043023          	sd	a6,32(s0)
     ce4:	03143423          	sd	a7,40(s0)
     ce8:	87aa                	mv	a5,a0
     cea:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     cee:	03040793          	addi	a5,s0,48
     cf2:	fcf43423          	sd	a5,-56(s0)
     cf6:	fc843783          	ld	a5,-56(s0)
     cfa:	fd078793          	addi	a5,a5,-48
     cfe:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d02:	fe843703          	ld	a4,-24(s0)
     d06:	fdc42783          	lw	a5,-36(s0)
     d0a:	863a                	mv	a2,a4
     d0c:	fd043583          	ld	a1,-48(s0)
     d10:	853e                	mv	a0,a5
     d12:	b3dff0ef          	jal	84e <vprintf>
}
     d16:	0001                	nop
     d18:	70e2                	ld	ra,56(sp)
     d1a:	7442                	ld	s0,48(sp)
     d1c:	6165                	addi	sp,sp,112
     d1e:	8082                	ret

0000000000000d20 <printf>:

void
printf(const char *fmt, ...)
{
     d20:	7159                	addi	sp,sp,-112
     d22:	f406                	sd	ra,40(sp)
     d24:	f022                	sd	s0,32(sp)
     d26:	1800                	addi	s0,sp,48
     d28:	fca43c23          	sd	a0,-40(s0)
     d2c:	e40c                	sd	a1,8(s0)
     d2e:	e810                	sd	a2,16(s0)
     d30:	ec14                	sd	a3,24(s0)
     d32:	f018                	sd	a4,32(s0)
     d34:	f41c                	sd	a5,40(s0)
     d36:	03043823          	sd	a6,48(s0)
     d3a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d3e:	04040793          	addi	a5,s0,64
     d42:	fcf43823          	sd	a5,-48(s0)
     d46:	fd043783          	ld	a5,-48(s0)
     d4a:	fc878793          	addi	a5,a5,-56
     d4e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d52:	fe843783          	ld	a5,-24(s0)
     d56:	863e                	mv	a2,a5
     d58:	fd843583          	ld	a1,-40(s0)
     d5c:	4505                	li	a0,1
     d5e:	af1ff0ef          	jal	84e <vprintf>
}
     d62:	0001                	nop
     d64:	70a2                	ld	ra,40(sp)
     d66:	7402                	ld	s0,32(sp)
     d68:	6165                	addi	sp,sp,112
     d6a:	8082                	ret

0000000000000d6c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d6c:	7179                	addi	sp,sp,-48
     d6e:	f406                	sd	ra,40(sp)
     d70:	f022                	sd	s0,32(sp)
     d72:	1800                	addi	s0,sp,48
     d74:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d78:	fd843783          	ld	a5,-40(s0)
     d7c:	17c1                	addi	a5,a5,-16
     d7e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d82:	00001797          	auipc	a5,0x1
     d86:	2be78793          	addi	a5,a5,702 # 2040 <freep>
     d8a:	639c                	ld	a5,0(a5)
     d8c:	fef43423          	sd	a5,-24(s0)
     d90:	a815                	j	dc4 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	639c                	ld	a5,0(a5)
     d98:	fe843703          	ld	a4,-24(s0)
     d9c:	00f76f63          	bltu	a4,a5,dba <free+0x4e>
     da0:	fe043703          	ld	a4,-32(s0)
     da4:	fe843783          	ld	a5,-24(s0)
     da8:	02e7eb63          	bltu	a5,a4,dde <free+0x72>
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	639c                	ld	a5,0(a5)
     db2:	fe043703          	ld	a4,-32(s0)
     db6:	02f76463          	bltu	a4,a5,dde <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dba:	fe843783          	ld	a5,-24(s0)
     dbe:	639c                	ld	a5,0(a5)
     dc0:	fef43423          	sd	a5,-24(s0)
     dc4:	fe043703          	ld	a4,-32(s0)
     dc8:	fe843783          	ld	a5,-24(s0)
     dcc:	fce7f3e3          	bgeu	a5,a4,d92 <free+0x26>
     dd0:	fe843783          	ld	a5,-24(s0)
     dd4:	639c                	ld	a5,0(a5)
     dd6:	fe043703          	ld	a4,-32(s0)
     dda:	faf77ce3          	bgeu	a4,a5,d92 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     dde:	fe043783          	ld	a5,-32(s0)
     de2:	479c                	lw	a5,8(a5)
     de4:	1782                	slli	a5,a5,0x20
     de6:	9381                	srli	a5,a5,0x20
     de8:	0792                	slli	a5,a5,0x4
     dea:	fe043703          	ld	a4,-32(s0)
     dee:	973e                	add	a4,a4,a5
     df0:	fe843783          	ld	a5,-24(s0)
     df4:	639c                	ld	a5,0(a5)
     df6:	02f71763          	bne	a4,a5,e24 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     dfa:	fe043783          	ld	a5,-32(s0)
     dfe:	4798                	lw	a4,8(a5)
     e00:	fe843783          	ld	a5,-24(s0)
     e04:	639c                	ld	a5,0(a5)
     e06:	479c                	lw	a5,8(a5)
     e08:	9fb9                	addw	a5,a5,a4
     e0a:	0007871b          	sext.w	a4,a5
     e0e:	fe043783          	ld	a5,-32(s0)
     e12:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e14:	fe843783          	ld	a5,-24(s0)
     e18:	639c                	ld	a5,0(a5)
     e1a:	6398                	ld	a4,0(a5)
     e1c:	fe043783          	ld	a5,-32(s0)
     e20:	e398                	sd	a4,0(a5)
     e22:	a039                	j	e30 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	6398                	ld	a4,0(a5)
     e2a:	fe043783          	ld	a5,-32(s0)
     e2e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	479c                	lw	a5,8(a5)
     e36:	1782                	slli	a5,a5,0x20
     e38:	9381                	srli	a5,a5,0x20
     e3a:	0792                	slli	a5,a5,0x4
     e3c:	fe843703          	ld	a4,-24(s0)
     e40:	97ba                	add	a5,a5,a4
     e42:	fe043703          	ld	a4,-32(s0)
     e46:	02f71563          	bne	a4,a5,e70 <free+0x104>
    p->s.size += bp->s.size;
     e4a:	fe843783          	ld	a5,-24(s0)
     e4e:	4798                	lw	a4,8(a5)
     e50:	fe043783          	ld	a5,-32(s0)
     e54:	479c                	lw	a5,8(a5)
     e56:	9fb9                	addw	a5,a5,a4
     e58:	0007871b          	sext.w	a4,a5
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     e62:	fe043783          	ld	a5,-32(s0)
     e66:	6398                	ld	a4,0(a5)
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	e398                	sd	a4,0(a5)
     e6e:	a031                	j	e7a <free+0x10e>
  } else
    p->s.ptr = bp;
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	fe043703          	ld	a4,-32(s0)
     e78:	e398                	sd	a4,0(a5)
  freep = p;
     e7a:	00001797          	auipc	a5,0x1
     e7e:	1c678793          	addi	a5,a5,454 # 2040 <freep>
     e82:	fe843703          	ld	a4,-24(s0)
     e86:	e398                	sd	a4,0(a5)
}
     e88:	0001                	nop
     e8a:	70a2                	ld	ra,40(sp)
     e8c:	7402                	ld	s0,32(sp)
     e8e:	6145                	addi	sp,sp,48
     e90:	8082                	ret

0000000000000e92 <morecore>:

static Header*
morecore(uint nu)
{
     e92:	7179                	addi	sp,sp,-48
     e94:	f406                	sd	ra,40(sp)
     e96:	f022                	sd	s0,32(sp)
     e98:	1800                	addi	s0,sp,48
     e9a:	87aa                	mv	a5,a0
     e9c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ea0:	fdc42783          	lw	a5,-36(s0)
     ea4:	0007871b          	sext.w	a4,a5
     ea8:	6785                	lui	a5,0x1
     eaa:	00f77563          	bgeu	a4,a5,eb4 <morecore+0x22>
    nu = 4096;
     eae:	6785                	lui	a5,0x1
     eb0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     eb4:	fdc42783          	lw	a5,-36(s0)
     eb8:	0047979b          	slliw	a5,a5,0x4
     ebc:	2781                	sext.w	a5,a5
     ebe:	853e                	mv	a0,a5
     ec0:	ee8ff0ef          	jal	5a8 <sbrk>
     ec4:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     ec8:	fe843703          	ld	a4,-24(s0)
     ecc:	57fd                	li	a5,-1
     ece:	00f71463          	bne	a4,a5,ed6 <morecore+0x44>
    return 0;
     ed2:	4781                	li	a5,0
     ed4:	a02d                	j	efe <morecore+0x6c>
  hp = (Header*)p;
     ed6:	fe843783          	ld	a5,-24(s0)
     eda:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ede:	fe043783          	ld	a5,-32(s0)
     ee2:	fdc42703          	lw	a4,-36(s0)
     ee6:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     ee8:	fe043783          	ld	a5,-32(s0)
     eec:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x108>
     eee:	853e                	mv	a0,a5
     ef0:	e7dff0ef          	jal	d6c <free>
  return freep;
     ef4:	00001797          	auipc	a5,0x1
     ef8:	14c78793          	addi	a5,a5,332 # 2040 <freep>
     efc:	639c                	ld	a5,0(a5)
}
     efe:	853e                	mv	a0,a5
     f00:	70a2                	ld	ra,40(sp)
     f02:	7402                	ld	s0,32(sp)
     f04:	6145                	addi	sp,sp,48
     f06:	8082                	ret

0000000000000f08 <malloc>:

void*
malloc(uint nbytes)
{
     f08:	7139                	addi	sp,sp,-64
     f0a:	fc06                	sd	ra,56(sp)
     f0c:	f822                	sd	s0,48(sp)
     f0e:	0080                	addi	s0,sp,64
     f10:	87aa                	mv	a5,a0
     f12:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f16:	fcc46783          	lwu	a5,-52(s0)
     f1a:	07bd                	addi	a5,a5,15
     f1c:	8391                	srli	a5,a5,0x4
     f1e:	2781                	sext.w	a5,a5
     f20:	2785                	addiw	a5,a5,1
     f22:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f26:	00001797          	auipc	a5,0x1
     f2a:	11a78793          	addi	a5,a5,282 # 2040 <freep>
     f2e:	639c                	ld	a5,0(a5)
     f30:	fef43023          	sd	a5,-32(s0)
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	ef95                	bnez	a5,f74 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f3a:	00001797          	auipc	a5,0x1
     f3e:	0f678793          	addi	a5,a5,246 # 2030 <base>
     f42:	fef43023          	sd	a5,-32(s0)
     f46:	00001797          	auipc	a5,0x1
     f4a:	0fa78793          	addi	a5,a5,250 # 2040 <freep>
     f4e:	fe043703          	ld	a4,-32(s0)
     f52:	e398                	sd	a4,0(a5)
     f54:	00001797          	auipc	a5,0x1
     f58:	0ec78793          	addi	a5,a5,236 # 2040 <freep>
     f5c:	6398                	ld	a4,0(a5)
     f5e:	00001797          	auipc	a5,0x1
     f62:	0d278793          	addi	a5,a5,210 # 2030 <base>
     f66:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     f68:	00001797          	auipc	a5,0x1
     f6c:	0c878793          	addi	a5,a5,200 # 2030 <base>
     f70:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f74:	fe043783          	ld	a5,-32(s0)
     f78:	639c                	ld	a5,0(a5)
     f7a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f7e:	fe843783          	ld	a5,-24(s0)
     f82:	479c                	lw	a5,8(a5)
     f84:	fdc42703          	lw	a4,-36(s0)
     f88:	2701                	sext.w	a4,a4
     f8a:	06e7e763          	bltu	a5,a4,ff8 <malloc+0xf0>
      if(p->s.size == nunits)
     f8e:	fe843783          	ld	a5,-24(s0)
     f92:	479c                	lw	a5,8(a5)
     f94:	fdc42703          	lw	a4,-36(s0)
     f98:	2701                	sext.w	a4,a4
     f9a:	00f71963          	bne	a4,a5,fac <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     f9e:	fe843783          	ld	a5,-24(s0)
     fa2:	6398                	ld	a4,0(a5)
     fa4:	fe043783          	ld	a5,-32(s0)
     fa8:	e398                	sd	a4,0(a5)
     faa:	a825                	j	fe2 <malloc+0xda>
      else {
        p->s.size -= nunits;
     fac:	fe843783          	ld	a5,-24(s0)
     fb0:	479c                	lw	a5,8(a5)
     fb2:	fdc42703          	lw	a4,-36(s0)
     fb6:	9f99                	subw	a5,a5,a4
     fb8:	0007871b          	sext.w	a4,a5
     fbc:	fe843783          	ld	a5,-24(s0)
     fc0:	c798                	sw	a4,8(a5)
        p += p->s.size;
     fc2:	fe843783          	ld	a5,-24(s0)
     fc6:	479c                	lw	a5,8(a5)
     fc8:	1782                	slli	a5,a5,0x20
     fca:	9381                	srli	a5,a5,0x20
     fcc:	0792                	slli	a5,a5,0x4
     fce:	fe843703          	ld	a4,-24(s0)
     fd2:	97ba                	add	a5,a5,a4
     fd4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     fd8:	fe843783          	ld	a5,-24(s0)
     fdc:	fdc42703          	lw	a4,-36(s0)
     fe0:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     fe2:	00001797          	auipc	a5,0x1
     fe6:	05e78793          	addi	a5,a5,94 # 2040 <freep>
     fea:	fe043703          	ld	a4,-32(s0)
     fee:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     ff0:	fe843783          	ld	a5,-24(s0)
     ff4:	07c1                	addi	a5,a5,16
     ff6:	a081                	j	1036 <malloc+0x12e>
    }
    if(p == freep)
     ff8:	00001797          	auipc	a5,0x1
     ffc:	04878793          	addi	a5,a5,72 # 2040 <freep>
    1000:	639c                	ld	a5,0(a5)
    1002:	fe843703          	ld	a4,-24(s0)
    1006:	00f71e63          	bne	a4,a5,1022 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    100a:	fdc42783          	lw	a5,-36(s0)
    100e:	853e                	mv	a0,a5
    1010:	e83ff0ef          	jal	e92 <morecore>
    1014:	fea43423          	sd	a0,-24(s0)
    1018:	fe843783          	ld	a5,-24(s0)
    101c:	e399                	bnez	a5,1022 <malloc+0x11a>
        return 0;
    101e:	4781                	li	a5,0
    1020:	a819                	j	1036 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1022:	fe843783          	ld	a5,-24(s0)
    1026:	fef43023          	sd	a5,-32(s0)
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	639c                	ld	a5,0(a5)
    1030:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1034:	b7a9                	j	f7e <malloc+0x76>
  }
}
    1036:	853e                	mv	a0,a5
    1038:	70e2                	ld	ra,56(sp)
    103a:	7442                	ld	s0,48(sp)
    103c:	6121                	addi	sp,sp,64
    103e:	8082                	ret
