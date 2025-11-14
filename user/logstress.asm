
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
      12:	4785                	li	a5,1
      14:	fef42623          	sw	a5,-20(s0)
      18:	aa29                	j	132 <main+0x132>
    int pid1 = fork();
      1a:	684000ef          	jal	69e <fork>
      1e:	87aa                	mv	a5,a0
      20:	fef42223          	sw	a5,-28(s0)
    if(pid1 < 0){
      24:	fe442783          	lw	a5,-28(s0)
      28:	2781                	sext.w	a5,a5
      2a:	0007df63          	bgez	a5,48 <main+0x48>
      printf("%s: fork failed\n", argv[0]);
      2e:	fc043783          	ld	a5,-64(s0)
      32:	639c                	ld	a5,0(a5)
      34:	85be                	mv	a1,a5
      36:	00001517          	auipc	a0,0x1
      3a:	0ba50513          	addi	a0,a0,186 # 10f0 <malloc+0x146>
      3e:	585000ef          	jal	dc2 <printf>
      exit(1);
      42:	4505                	li	a0,1
      44:	662000ef          	jal	6a6 <exit>
    }
    if(pid1 == 0) {
      48:	fe442783          	lw	a5,-28(s0)
      4c:	2781                	sext.w	a5,a5
      4e:	efe9                	bnez	a5,128 <main+0x128>
      fd = open(argv[i], O_CREATE | O_RDWR);
      50:	fec42783          	lw	a5,-20(s0)
      54:	078e                	slli	a5,a5,0x3
      56:	fc043703          	ld	a4,-64(s0)
      5a:	97ba                	add	a5,a5,a4
      5c:	639c                	ld	a5,0(a5)
      5e:	20200593          	li	a1,514
      62:	853e                	mv	a0,a5
      64:	682000ef          	jal	6e6 <open>
      68:	87aa                	mv	a5,a0
      6a:	fef42023          	sw	a5,-32(s0)
      if(fd < 0){
      6e:	fe042783          	lw	a5,-32(s0)
      72:	2781                	sext.w	a5,a5
      74:	0207d763          	bgez	a5,a2 <main+0xa2>
        printf("%s: create %s failed\n", argv[0], argv[i]);
      78:	fc043783          	ld	a5,-64(s0)
      7c:	6394                	ld	a3,0(a5)
      7e:	fec42783          	lw	a5,-20(s0)
      82:	078e                	slli	a5,a5,0x3
      84:	fc043703          	ld	a4,-64(s0)
      88:	97ba                	add	a5,a5,a4
      8a:	639c                	ld	a5,0(a5)
      8c:	863e                	mv	a2,a5
      8e:	85b6                	mv	a1,a3
      90:	00001517          	auipc	a0,0x1
      94:	07850513          	addi	a0,a0,120 # 1108 <malloc+0x15e>
      98:	52b000ef          	jal	dc2 <printf>
        exit(1);
      9c:	4505                	li	a0,1
      9e:	608000ef          	jal	6a6 <exit>
      }
      memset(buf, '0'+i, SZ);
      a2:	fec42783          	lw	a5,-20(s0)
      a6:	0307879b          	addiw	a5,a5,48
      aa:	2781                	sext.w	a5,a5
      ac:	7d000613          	li	a2,2000
      b0:	85be                	mv	a1,a5
      b2:	00002517          	auipc	a0,0x2
      b6:	f6e50513          	addi	a0,a0,-146 # 2020 <buf>
      ba:	1f6000ef          	jal	2b0 <memset>
      for(i = 0; i < N; i++){
      be:	fe042623          	sw	zero,-20(s0)
      c2:	a881                	j	112 <main+0x112>
        if((n = write(fd, buf, SZ)) != SZ){
      c4:	fe042783          	lw	a5,-32(s0)
      c8:	7d000613          	li	a2,2000
      cc:	00002597          	auipc	a1,0x2
      d0:	f5458593          	addi	a1,a1,-172 # 2020 <buf>
      d4:	853e                	mv	a0,a5
      d6:	5f0000ef          	jal	6c6 <write>
      da:	87aa                	mv	a5,a0
      dc:	fcf42e23          	sw	a5,-36(s0)
      e0:	fdc42783          	lw	a5,-36(s0)
      e4:	0007871b          	sext.w	a4,a5
      e8:	7d000793          	li	a5,2000
      ec:	00f70e63          	beq	a4,a5,108 <main+0x108>
          printf("write failed %d\n", n);
      f0:	fdc42783          	lw	a5,-36(s0)
      f4:	85be                	mv	a1,a5
      f6:	00001517          	auipc	a0,0x1
      fa:	02a50513          	addi	a0,a0,42 # 1120 <malloc+0x176>
      fe:	4c5000ef          	jal	dc2 <printf>
          exit(1);
     102:	4505                	li	a0,1
     104:	5a2000ef          	jal	6a6 <exit>
      for(i = 0; i < N; i++){
     108:	fec42783          	lw	a5,-20(s0)
     10c:	2785                	addiw	a5,a5,1
     10e:	fef42623          	sw	a5,-20(s0)
     112:	fec42783          	lw	a5,-20(s0)
     116:	0007871b          	sext.w	a4,a5
     11a:	0f900793          	li	a5,249
     11e:	fae7d3e3          	bge	a5,a4,c4 <main+0xc4>
        }
      }
      exit(0);
     122:	4501                	li	a0,0
     124:	582000ef          	jal	6a6 <exit>
  for (int i = 1; i < argc; i++){
     128:	fec42783          	lw	a5,-20(s0)
     12c:	2785                	addiw	a5,a5,1
     12e:	fef42623          	sw	a5,-20(s0)
     132:	fec42783          	lw	a5,-20(s0)
     136:	873e                	mv	a4,a5
     138:	fcc42783          	lw	a5,-52(s0)
     13c:	2701                	sext.w	a4,a4
     13e:	2781                	sext.w	a5,a5
     140:	ecf74de3          	blt	a4,a5,1a <main+0x1a>
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
     144:	4785                	li	a5,1
     146:	fef42423          	sw	a5,-24(s0)
     14a:	a01d                	j	170 <main+0x170>
    wait(&xstatus);
     14c:	fd840793          	addi	a5,s0,-40
     150:	853e                	mv	a0,a5
     152:	55c000ef          	jal	6ae <wait>
    if(xstatus != 0)
     156:	fd842783          	lw	a5,-40(s0)
     15a:	c791                	beqz	a5,166 <main+0x166>
      exit(xstatus);
     15c:	fd842783          	lw	a5,-40(s0)
     160:	853e                	mv	a0,a5
     162:	544000ef          	jal	6a6 <exit>
  for(int i = 1; i < argc; i++){
     166:	fe842783          	lw	a5,-24(s0)
     16a:	2785                	addiw	a5,a5,1
     16c:	fef42423          	sw	a5,-24(s0)
     170:	fe842783          	lw	a5,-24(s0)
     174:	873e                	mv	a4,a5
     176:	fcc42783          	lw	a5,-52(s0)
     17a:	2701                	sext.w	a4,a4
     17c:	2781                	sext.w	a5,a5
     17e:	fcf747e3          	blt	a4,a5,14c <main+0x14c>
  }
  return 0;
     182:	4781                	li	a5,0
}
     184:	853e                	mv	a0,a5
     186:	70e2                	ld	ra,56(sp)
     188:	7442                	ld	s0,48(sp)
     18a:	6121                	addi	sp,sp,64
     18c:	8082                	ret

000000000000018e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     18e:	7179                	addi	sp,sp,-48
     190:	f406                	sd	ra,40(sp)
     192:	f022                	sd	s0,32(sp)
     194:	1800                	addi	s0,sp,48
     196:	87aa                	mv	a5,a0
     198:	fcb43823          	sd	a1,-48(s0)
     19c:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     1a0:	fdc42783          	lw	a5,-36(s0)
     1a4:	fd043583          	ld	a1,-48(s0)
     1a8:	853e                	mv	a0,a5
     1aa:	e57ff0ef          	jal	0 <main>
     1ae:	87aa                	mv	a5,a0
     1b0:	fef42623          	sw	a5,-20(s0)
  exit(r);
     1b4:	fec42783          	lw	a5,-20(s0)
     1b8:	853e                	mv	a0,a5
     1ba:	4ec000ef          	jal	6a6 <exit>

00000000000001be <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     1be:	7179                	addi	sp,sp,-48
     1c0:	f406                	sd	ra,40(sp)
     1c2:	f022                	sd	s0,32(sp)
     1c4:	1800                	addi	s0,sp,48
     1c6:	fca43c23          	sd	a0,-40(s0)
     1ca:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     1ce:	fd843783          	ld	a5,-40(s0)
     1d2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     1d6:	0001                	nop
     1d8:	fd043703          	ld	a4,-48(s0)
     1dc:	00170793          	addi	a5,a4,1
     1e0:	fcf43823          	sd	a5,-48(s0)
     1e4:	fd843783          	ld	a5,-40(s0)
     1e8:	00178693          	addi	a3,a5,1
     1ec:	fcd43c23          	sd	a3,-40(s0)
     1f0:	00074703          	lbu	a4,0(a4)
     1f4:	00e78023          	sb	a4,0(a5)
     1f8:	0007c783          	lbu	a5,0(a5)
     1fc:	fff1                	bnez	a5,1d8 <strcpy+0x1a>
    ;
  return os;
     1fe:	fe843783          	ld	a5,-24(s0)
}
     202:	853e                	mv	a0,a5
     204:	70a2                	ld	ra,40(sp)
     206:	7402                	ld	s0,32(sp)
     208:	6145                	addi	sp,sp,48
     20a:	8082                	ret

000000000000020c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     20c:	1101                	addi	sp,sp,-32
     20e:	ec06                	sd	ra,24(sp)
     210:	e822                	sd	s0,16(sp)
     212:	1000                	addi	s0,sp,32
     214:	fea43423          	sd	a0,-24(s0)
     218:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     21c:	a819                	j	232 <strcmp+0x26>
    p++, q++;
     21e:	fe843783          	ld	a5,-24(s0)
     222:	0785                	addi	a5,a5,1
     224:	fef43423          	sd	a5,-24(s0)
     228:	fe043783          	ld	a5,-32(s0)
     22c:	0785                	addi	a5,a5,1
     22e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     232:	fe843783          	ld	a5,-24(s0)
     236:	0007c783          	lbu	a5,0(a5)
     23a:	cb99                	beqz	a5,250 <strcmp+0x44>
     23c:	fe843783          	ld	a5,-24(s0)
     240:	0007c703          	lbu	a4,0(a5)
     244:	fe043783          	ld	a5,-32(s0)
     248:	0007c783          	lbu	a5,0(a5)
     24c:	fcf709e3          	beq	a4,a5,21e <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     250:	fe843783          	ld	a5,-24(s0)
     254:	0007c783          	lbu	a5,0(a5)
     258:	0007871b          	sext.w	a4,a5
     25c:	fe043783          	ld	a5,-32(s0)
     260:	0007c783          	lbu	a5,0(a5)
     264:	2781                	sext.w	a5,a5
     266:	40f707bb          	subw	a5,a4,a5
     26a:	2781                	sext.w	a5,a5
}
     26c:	853e                	mv	a0,a5
     26e:	60e2                	ld	ra,24(sp)
     270:	6442                	ld	s0,16(sp)
     272:	6105                	addi	sp,sp,32
     274:	8082                	ret

0000000000000276 <strlen>:

uint
strlen(const char *s)
{
     276:	7179                	addi	sp,sp,-48
     278:	f406                	sd	ra,40(sp)
     27a:	f022                	sd	s0,32(sp)
     27c:	1800                	addi	s0,sp,48
     27e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     282:	fe042623          	sw	zero,-20(s0)
     286:	a031                	j	292 <strlen+0x1c>
     288:	fec42783          	lw	a5,-20(s0)
     28c:	2785                	addiw	a5,a5,1
     28e:	fef42623          	sw	a5,-20(s0)
     292:	fec42783          	lw	a5,-20(s0)
     296:	fd843703          	ld	a4,-40(s0)
     29a:	97ba                	add	a5,a5,a4
     29c:	0007c783          	lbu	a5,0(a5)
     2a0:	f7e5                	bnez	a5,288 <strlen+0x12>
    ;
  return n;
     2a2:	fec42783          	lw	a5,-20(s0)
}
     2a6:	853e                	mv	a0,a5
     2a8:	70a2                	ld	ra,40(sp)
     2aa:	7402                	ld	s0,32(sp)
     2ac:	6145                	addi	sp,sp,48
     2ae:	8082                	ret

00000000000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2b0:	7179                	addi	sp,sp,-48
     2b2:	f406                	sd	ra,40(sp)
     2b4:	f022                	sd	s0,32(sp)
     2b6:	1800                	addi	s0,sp,48
     2b8:	fca43c23          	sd	a0,-40(s0)
     2bc:	87ae                	mv	a5,a1
     2be:	8732                	mv	a4,a2
     2c0:	fcf42a23          	sw	a5,-44(s0)
     2c4:	87ba                	mv	a5,a4
     2c6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     2ca:	fd843783          	ld	a5,-40(s0)
     2ce:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     2d2:	fe042623          	sw	zero,-20(s0)
     2d6:	a00d                	j	2f8 <memset+0x48>
    cdst[i] = c;
     2d8:	fec42783          	lw	a5,-20(s0)
     2dc:	fe043703          	ld	a4,-32(s0)
     2e0:	97ba                	add	a5,a5,a4
     2e2:	fd442703          	lw	a4,-44(s0)
     2e6:	0ff77713          	zext.b	a4,a4
     2ea:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	2785                	addiw	a5,a5,1
     2f4:	fef42623          	sw	a5,-20(s0)
     2f8:	fec42783          	lw	a5,-20(s0)
     2fc:	fd042703          	lw	a4,-48(s0)
     300:	2701                	sext.w	a4,a4
     302:	fce7ebe3          	bltu	a5,a4,2d8 <memset+0x28>
  }
  return dst;
     306:	fd843783          	ld	a5,-40(s0)
}
     30a:	853e                	mv	a0,a5
     30c:	70a2                	ld	ra,40(sp)
     30e:	7402                	ld	s0,32(sp)
     310:	6145                	addi	sp,sp,48
     312:	8082                	ret

0000000000000314 <strchr>:

char*
strchr(const char *s, char c)
{
     314:	1101                	addi	sp,sp,-32
     316:	ec06                	sd	ra,24(sp)
     318:	e822                	sd	s0,16(sp)
     31a:	1000                	addi	s0,sp,32
     31c:	fea43423          	sd	a0,-24(s0)
     320:	87ae                	mv	a5,a1
     322:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     326:	a01d                	j	34c <strchr+0x38>
    if(*s == c)
     328:	fe843783          	ld	a5,-24(s0)
     32c:	0007c703          	lbu	a4,0(a5)
     330:	fe744783          	lbu	a5,-25(s0)
     334:	0ff7f793          	zext.b	a5,a5
     338:	00e79563          	bne	a5,a4,342 <strchr+0x2e>
      return (char*)s;
     33c:	fe843783          	ld	a5,-24(s0)
     340:	a821                	j	358 <strchr+0x44>
  for(; *s; s++)
     342:	fe843783          	ld	a5,-24(s0)
     346:	0785                	addi	a5,a5,1
     348:	fef43423          	sd	a5,-24(s0)
     34c:	fe843783          	ld	a5,-24(s0)
     350:	0007c783          	lbu	a5,0(a5)
     354:	fbf1                	bnez	a5,328 <strchr+0x14>
  return 0;
     356:	4781                	li	a5,0
}
     358:	853e                	mv	a0,a5
     35a:	60e2                	ld	ra,24(sp)
     35c:	6442                	ld	s0,16(sp)
     35e:	6105                	addi	sp,sp,32
     360:	8082                	ret

0000000000000362 <gets>:

char*
gets(char *buf, int max)
{
     362:	7179                	addi	sp,sp,-48
     364:	f406                	sd	ra,40(sp)
     366:	f022                	sd	s0,32(sp)
     368:	1800                	addi	s0,sp,48
     36a:	fca43c23          	sd	a0,-40(s0)
     36e:	87ae                	mv	a5,a1
     370:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     374:	fe042623          	sw	zero,-20(s0)
     378:	a891                	j	3cc <gets+0x6a>
    cc = read(0, &c, 1);
     37a:	fe740793          	addi	a5,s0,-25
     37e:	4605                	li	a2,1
     380:	85be                	mv	a1,a5
     382:	4501                	li	a0,0
     384:	33a000ef          	jal	6be <read>
     388:	87aa                	mv	a5,a0
     38a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     38e:	fe842783          	lw	a5,-24(s0)
     392:	2781                	sext.w	a5,a5
     394:	04f05663          	blez	a5,3e0 <gets+0x7e>
      break;
    buf[i++] = c;
     398:	fec42783          	lw	a5,-20(s0)
     39c:	0017871b          	addiw	a4,a5,1
     3a0:	fee42623          	sw	a4,-20(s0)
     3a4:	873e                	mv	a4,a5
     3a6:	fd843783          	ld	a5,-40(s0)
     3aa:	97ba                	add	a5,a5,a4
     3ac:	fe744703          	lbu	a4,-25(s0)
     3b0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     3b4:	fe744783          	lbu	a5,-25(s0)
     3b8:	873e                	mv	a4,a5
     3ba:	47a9                	li	a5,10
     3bc:	02f70363          	beq	a4,a5,3e2 <gets+0x80>
     3c0:	fe744783          	lbu	a5,-25(s0)
     3c4:	873e                	mv	a4,a5
     3c6:	47b5                	li	a5,13
     3c8:	00f70d63          	beq	a4,a5,3e2 <gets+0x80>
  for(i=0; i+1 < max; ){
     3cc:	fec42783          	lw	a5,-20(s0)
     3d0:	2785                	addiw	a5,a5,1
     3d2:	2781                	sext.w	a5,a5
     3d4:	fd442703          	lw	a4,-44(s0)
     3d8:	2701                	sext.w	a4,a4
     3da:	fae7c0e3          	blt	a5,a4,37a <gets+0x18>
     3de:	a011                	j	3e2 <gets+0x80>
      break;
     3e0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3e2:	fec42783          	lw	a5,-20(s0)
     3e6:	fd843703          	ld	a4,-40(s0)
     3ea:	97ba                	add	a5,a5,a4
     3ec:	00078023          	sb	zero,0(a5)
  return buf;
     3f0:	fd843783          	ld	a5,-40(s0)
}
     3f4:	853e                	mv	a0,a5
     3f6:	70a2                	ld	ra,40(sp)
     3f8:	7402                	ld	s0,32(sp)
     3fa:	6145                	addi	sp,sp,48
     3fc:	8082                	ret

00000000000003fe <stat>:

int
stat(const char *n, struct stat *st)
{
     3fe:	7179                	addi	sp,sp,-48
     400:	f406                	sd	ra,40(sp)
     402:	f022                	sd	s0,32(sp)
     404:	1800                	addi	s0,sp,48
     406:	fca43c23          	sd	a0,-40(s0)
     40a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     40e:	4581                	li	a1,0
     410:	fd843503          	ld	a0,-40(s0)
     414:	2d2000ef          	jal	6e6 <open>
     418:	87aa                	mv	a5,a0
     41a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     41e:	fec42783          	lw	a5,-20(s0)
     422:	2781                	sext.w	a5,a5
     424:	0007d463          	bgez	a5,42c <stat+0x2e>
    return -1;
     428:	57fd                	li	a5,-1
     42a:	a015                	j	44e <stat+0x50>
  r = fstat(fd, st);
     42c:	fec42783          	lw	a5,-20(s0)
     430:	fd043583          	ld	a1,-48(s0)
     434:	853e                	mv	a0,a5
     436:	2c8000ef          	jal	6fe <fstat>
     43a:	87aa                	mv	a5,a0
     43c:	fef42423          	sw	a5,-24(s0)
  close(fd);
     440:	fec42783          	lw	a5,-20(s0)
     444:	853e                	mv	a0,a5
     446:	288000ef          	jal	6ce <close>
  return r;
     44a:	fe842783          	lw	a5,-24(s0)
}
     44e:	853e                	mv	a0,a5
     450:	70a2                	ld	ra,40(sp)
     452:	7402                	ld	s0,32(sp)
     454:	6145                	addi	sp,sp,48
     456:	8082                	ret

0000000000000458 <atoi>:

int
atoi(const char *s)
{
     458:	7179                	addi	sp,sp,-48
     45a:	f406                	sd	ra,40(sp)
     45c:	f022                	sd	s0,32(sp)
     45e:	1800                	addi	s0,sp,48
     460:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     464:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     468:	a81d                	j	49e <atoi+0x46>
    n = n*10 + *s++ - '0';
     46a:	fec42783          	lw	a5,-20(s0)
     46e:	873e                	mv	a4,a5
     470:	87ba                	mv	a5,a4
     472:	0027979b          	slliw	a5,a5,0x2
     476:	9fb9                	addw	a5,a5,a4
     478:	0017979b          	slliw	a5,a5,0x1
     47c:	0007871b          	sext.w	a4,a5
     480:	fd843783          	ld	a5,-40(s0)
     484:	00178693          	addi	a3,a5,1
     488:	fcd43c23          	sd	a3,-40(s0)
     48c:	0007c783          	lbu	a5,0(a5)
     490:	2781                	sext.w	a5,a5
     492:	9fb9                	addw	a5,a5,a4
     494:	2781                	sext.w	a5,a5
     496:	fd07879b          	addiw	a5,a5,-48
     49a:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     49e:	fd843783          	ld	a5,-40(s0)
     4a2:	0007c783          	lbu	a5,0(a5)
     4a6:	873e                	mv	a4,a5
     4a8:	02f00793          	li	a5,47
     4ac:	00e7fb63          	bgeu	a5,a4,4c2 <atoi+0x6a>
     4b0:	fd843783          	ld	a5,-40(s0)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	873e                	mv	a4,a5
     4ba:	03900793          	li	a5,57
     4be:	fae7f6e3          	bgeu	a5,a4,46a <atoi+0x12>
  return n;
     4c2:	fec42783          	lw	a5,-20(s0)
}
     4c6:	853e                	mv	a0,a5
     4c8:	70a2                	ld	ra,40(sp)
     4ca:	7402                	ld	s0,32(sp)
     4cc:	6145                	addi	sp,sp,48
     4ce:	8082                	ret

00000000000004d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     4d0:	7139                	addi	sp,sp,-64
     4d2:	fc06                	sd	ra,56(sp)
     4d4:	f822                	sd	s0,48(sp)
     4d6:	0080                	addi	s0,sp,64
     4d8:	fca43c23          	sd	a0,-40(s0)
     4dc:	fcb43823          	sd	a1,-48(s0)
     4e0:	87b2                	mv	a5,a2
     4e2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4e6:	fd843783          	ld	a5,-40(s0)
     4ea:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4ee:	fd043783          	ld	a5,-48(s0)
     4f2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4f6:	fe043703          	ld	a4,-32(s0)
     4fa:	fe843783          	ld	a5,-24(s0)
     4fe:	02e7fc63          	bgeu	a5,a4,536 <memmove+0x66>
    while(n-- > 0)
     502:	a00d                	j	524 <memmove+0x54>
      *dst++ = *src++;
     504:	fe043703          	ld	a4,-32(s0)
     508:	00170793          	addi	a5,a4,1
     50c:	fef43023          	sd	a5,-32(s0)
     510:	fe843783          	ld	a5,-24(s0)
     514:	00178693          	addi	a3,a5,1
     518:	fed43423          	sd	a3,-24(s0)
     51c:	00074703          	lbu	a4,0(a4)
     520:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     524:	fcc42783          	lw	a5,-52(s0)
     528:	fff7871b          	addiw	a4,a5,-1
     52c:	fce42623          	sw	a4,-52(s0)
     530:	fcf04ae3          	bgtz	a5,504 <memmove+0x34>
     534:	a891                	j	588 <memmove+0xb8>
  } else {
    dst += n;
     536:	fcc42783          	lw	a5,-52(s0)
     53a:	fe843703          	ld	a4,-24(s0)
     53e:	97ba                	add	a5,a5,a4
     540:	fef43423          	sd	a5,-24(s0)
    src += n;
     544:	fcc42783          	lw	a5,-52(s0)
     548:	fe043703          	ld	a4,-32(s0)
     54c:	97ba                	add	a5,a5,a4
     54e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     552:	a01d                	j	578 <memmove+0xa8>
      *--dst = *--src;
     554:	fe043783          	ld	a5,-32(s0)
     558:	17fd                	addi	a5,a5,-1
     55a:	fef43023          	sd	a5,-32(s0)
     55e:	fe843783          	ld	a5,-24(s0)
     562:	17fd                	addi	a5,a5,-1
     564:	fef43423          	sd	a5,-24(s0)
     568:	fe043783          	ld	a5,-32(s0)
     56c:	0007c703          	lbu	a4,0(a5)
     570:	fe843783          	ld	a5,-24(s0)
     574:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     578:	fcc42783          	lw	a5,-52(s0)
     57c:	fff7871b          	addiw	a4,a5,-1
     580:	fce42623          	sw	a4,-52(s0)
     584:	fcf048e3          	bgtz	a5,554 <memmove+0x84>
  }
  return vdst;
     588:	fd843783          	ld	a5,-40(s0)
}
     58c:	853e                	mv	a0,a5
     58e:	70e2                	ld	ra,56(sp)
     590:	7442                	ld	s0,48(sp)
     592:	6121                	addi	sp,sp,64
     594:	8082                	ret

0000000000000596 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     596:	7139                	addi	sp,sp,-64
     598:	fc06                	sd	ra,56(sp)
     59a:	f822                	sd	s0,48(sp)
     59c:	0080                	addi	s0,sp,64
     59e:	fca43c23          	sd	a0,-40(s0)
     5a2:	fcb43823          	sd	a1,-48(s0)
     5a6:	87b2                	mv	a5,a2
     5a8:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     5ac:	fd843783          	ld	a5,-40(s0)
     5b0:	fef43423          	sd	a5,-24(s0)
     5b4:	fd043783          	ld	a5,-48(s0)
     5b8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5bc:	a0a1                	j	604 <memcmp+0x6e>
    if (*p1 != *p2) {
     5be:	fe843783          	ld	a5,-24(s0)
     5c2:	0007c703          	lbu	a4,0(a5)
     5c6:	fe043783          	ld	a5,-32(s0)
     5ca:	0007c783          	lbu	a5,0(a5)
     5ce:	02f70163          	beq	a4,a5,5f0 <memcmp+0x5a>
      return *p1 - *p2;
     5d2:	fe843783          	ld	a5,-24(s0)
     5d6:	0007c783          	lbu	a5,0(a5)
     5da:	0007871b          	sext.w	a4,a5
     5de:	fe043783          	ld	a5,-32(s0)
     5e2:	0007c783          	lbu	a5,0(a5)
     5e6:	2781                	sext.w	a5,a5
     5e8:	40f707bb          	subw	a5,a4,a5
     5ec:	2781                	sext.w	a5,a5
     5ee:	a01d                	j	614 <memcmp+0x7e>
    }
    p1++;
     5f0:	fe843783          	ld	a5,-24(s0)
     5f4:	0785                	addi	a5,a5,1
     5f6:	fef43423          	sd	a5,-24(s0)
    p2++;
     5fa:	fe043783          	ld	a5,-32(s0)
     5fe:	0785                	addi	a5,a5,1
     600:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     604:	fcc42783          	lw	a5,-52(s0)
     608:	fff7871b          	addiw	a4,a5,-1
     60c:	fce42623          	sw	a4,-52(s0)
     610:	f7dd                	bnez	a5,5be <memcmp+0x28>
  }
  return 0;
     612:	4781                	li	a5,0
}
     614:	853e                	mv	a0,a5
     616:	70e2                	ld	ra,56(sp)
     618:	7442                	ld	s0,48(sp)
     61a:	6121                	addi	sp,sp,64
     61c:	8082                	ret

000000000000061e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     61e:	7179                	addi	sp,sp,-48
     620:	f406                	sd	ra,40(sp)
     622:	f022                	sd	s0,32(sp)
     624:	1800                	addi	s0,sp,48
     626:	fea43423          	sd	a0,-24(s0)
     62a:	feb43023          	sd	a1,-32(s0)
     62e:	87b2                	mv	a5,a2
     630:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     634:	fdc42783          	lw	a5,-36(s0)
     638:	863e                	mv	a2,a5
     63a:	fe043583          	ld	a1,-32(s0)
     63e:	fe843503          	ld	a0,-24(s0)
     642:	e8fff0ef          	jal	4d0 <memmove>
     646:	87aa                	mv	a5,a0
}
     648:	853e                	mv	a0,a5
     64a:	70a2                	ld	ra,40(sp)
     64c:	7402                	ld	s0,32(sp)
     64e:	6145                	addi	sp,sp,48
     650:	8082                	ret

0000000000000652 <sbrk>:

char *
sbrk(int n) {
     652:	1101                	addi	sp,sp,-32
     654:	ec06                	sd	ra,24(sp)
     656:	e822                	sd	s0,16(sp)
     658:	1000                	addi	s0,sp,32
     65a:	87aa                	mv	a5,a0
     65c:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     660:	fec42783          	lw	a5,-20(s0)
     664:	4585                	li	a1,1
     666:	853e                	mv	a0,a5
     668:	0c6000ef          	jal	72e <sys_sbrk>
     66c:	87aa                	mv	a5,a0
}
     66e:	853e                	mv	a0,a5
     670:	60e2                	ld	ra,24(sp)
     672:	6442                	ld	s0,16(sp)
     674:	6105                	addi	sp,sp,32
     676:	8082                	ret

0000000000000678 <sbrklazy>:

char *
sbrklazy(int n) {
     678:	1101                	addi	sp,sp,-32
     67a:	ec06                	sd	ra,24(sp)
     67c:	e822                	sd	s0,16(sp)
     67e:	1000                	addi	s0,sp,32
     680:	87aa                	mv	a5,a0
     682:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     686:	fec42783          	lw	a5,-20(s0)
     68a:	4589                	li	a1,2
     68c:	853e                	mv	a0,a5
     68e:	0a0000ef          	jal	72e <sys_sbrk>
     692:	87aa                	mv	a5,a0
}
     694:	853e                	mv	a0,a5
     696:	60e2                	ld	ra,24(sp)
     698:	6442                	ld	s0,16(sp)
     69a:	6105                	addi	sp,sp,32
     69c:	8082                	ret

000000000000069e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     69e:	4885                	li	a7,1
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
     6a6:	4889                	li	a7,2
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <wait>:
.global wait
wait:
 li a7, SYS_wait
     6ae:	488d                	li	a7,3
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6b6:	4891                	li	a7,4
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <read>:
.global read
read:
 li a7, SYS_read
     6be:	4895                	li	a7,5
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <write>:
.global write
write:
 li a7, SYS_write
     6c6:	48c1                	li	a7,16
 ecall
     6c8:	00000073          	ecall
 ret
     6cc:	8082                	ret

00000000000006ce <close>:
.global close
close:
 li a7, SYS_close
     6ce:	48d5                	li	a7,21
 ecall
     6d0:	00000073          	ecall
 ret
     6d4:	8082                	ret

00000000000006d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
     6d6:	4899                	li	a7,6
 ecall
     6d8:	00000073          	ecall
 ret
     6dc:	8082                	ret

00000000000006de <exec>:
.global exec
exec:
 li a7, SYS_exec
     6de:	489d                	li	a7,7
 ecall
     6e0:	00000073          	ecall
 ret
     6e4:	8082                	ret

00000000000006e6 <open>:
.global open
open:
 li a7, SYS_open
     6e6:	48bd                	li	a7,15
 ecall
     6e8:	00000073          	ecall
 ret
     6ec:	8082                	ret

00000000000006ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6ee:	48c5                	li	a7,17
 ecall
     6f0:	00000073          	ecall
 ret
     6f4:	8082                	ret

00000000000006f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     6f6:	48c9                	li	a7,18
 ecall
     6f8:	00000073          	ecall
 ret
     6fc:	8082                	ret

00000000000006fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     6fe:	48a1                	li	a7,8
 ecall
     700:	00000073          	ecall
 ret
     704:	8082                	ret

0000000000000706 <link>:
.global link
link:
 li a7, SYS_link
     706:	48cd                	li	a7,19
 ecall
     708:	00000073          	ecall
 ret
     70c:	8082                	ret

000000000000070e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     70e:	48d1                	li	a7,20
 ecall
     710:	00000073          	ecall
 ret
     714:	8082                	ret

0000000000000716 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     716:	48a5                	li	a7,9
 ecall
     718:	00000073          	ecall
 ret
     71c:	8082                	ret

000000000000071e <dup>:
.global dup
dup:
 li a7, SYS_dup
     71e:	48a9                	li	a7,10
 ecall
     720:	00000073          	ecall
 ret
     724:	8082                	ret

0000000000000726 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     726:	48ad                	li	a7,11
 ecall
     728:	00000073          	ecall
 ret
     72c:	8082                	ret

000000000000072e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     72e:	48b1                	li	a7,12
 ecall
     730:	00000073          	ecall
 ret
     734:	8082                	ret

0000000000000736 <pause>:
.global pause
pause:
 li a7, SYS_pause
     736:	48b5                	li	a7,13
 ecall
     738:	00000073          	ecall
 ret
     73c:	8082                	ret

000000000000073e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     73e:	48b9                	li	a7,14
 ecall
     740:	00000073          	ecall
 ret
     744:	8082                	ret

0000000000000746 <top>:
.global top
top:
 li a7, SYS_top
     746:	48d9                	li	a7,22
 ecall
     748:	00000073          	ecall
 ret
     74c:	8082                	ret

000000000000074e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     74e:	1101                	addi	sp,sp,-32
     750:	ec06                	sd	ra,24(sp)
     752:	e822                	sd	s0,16(sp)
     754:	1000                	addi	s0,sp,32
     756:	87aa                	mv	a5,a0
     758:	872e                	mv	a4,a1
     75a:	fef42623          	sw	a5,-20(s0)
     75e:	87ba                	mv	a5,a4
     760:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     764:	feb40713          	addi	a4,s0,-21
     768:	fec42783          	lw	a5,-20(s0)
     76c:	4605                	li	a2,1
     76e:	85ba                	mv	a1,a4
     770:	853e                	mv	a0,a5
     772:	f55ff0ef          	jal	6c6 <write>
}
     776:	0001                	nop
     778:	60e2                	ld	ra,24(sp)
     77a:	6442                	ld	s0,16(sp)
     77c:	6105                	addi	sp,sp,32
     77e:	8082                	ret

0000000000000780 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     780:	711d                	addi	sp,sp,-96
     782:	ec86                	sd	ra,88(sp)
     784:	e8a2                	sd	s0,80(sp)
     786:	1080                	addi	s0,sp,96
     788:	87aa                	mv	a5,a0
     78a:	fab43823          	sd	a1,-80(s0)
     78e:	8736                	mv	a4,a3
     790:	faf42e23          	sw	a5,-68(s0)
     794:	87b2                	mv	a5,a2
     796:	faf42c23          	sw	a5,-72(s0)
     79a:	87ba                	mv	a5,a4
     79c:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     7a0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7a4:	fac42783          	lw	a5,-84(s0)
     7a8:	2781                	sext.w	a5,a5
     7aa:	cf99                	beqz	a5,7c8 <printint+0x48>
     7ac:	fb043783          	ld	a5,-80(s0)
     7b0:	0007dc63          	bgez	a5,7c8 <printint+0x48>
    neg = 1;
     7b4:	4785                	li	a5,1
     7b6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7ba:	fb043783          	ld	a5,-80(s0)
     7be:	40f007b3          	neg	a5,a5
     7c2:	fef43023          	sd	a5,-32(s0)
     7c6:	a029                	j	7d0 <printint+0x50>
  } else {
    x = xx;
     7c8:	fb043783          	ld	a5,-80(s0)
     7cc:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     7d0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7d4:	fb842783          	lw	a5,-72(s0)
     7d8:	fe043703          	ld	a4,-32(s0)
     7dc:	02f77733          	remu	a4,a4,a5
     7e0:	fec42783          	lw	a5,-20(s0)
     7e4:	0017869b          	addiw	a3,a5,1
     7e8:	fed42623          	sw	a3,-20(s0)
     7ec:	00002697          	auipc	a3,0x2
     7f0:	81468693          	addi	a3,a3,-2028 # 2000 <digits>
     7f4:	9736                	add	a4,a4,a3
     7f6:	00074703          	lbu	a4,0(a4)
     7fa:	17c1                	addi	a5,a5,-16
     7fc:	97a2                	add	a5,a5,s0
     7fe:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     802:	fb842783          	lw	a5,-72(s0)
     806:	fe043703          	ld	a4,-32(s0)
     80a:	02f757b3          	divu	a5,a4,a5
     80e:	fef43023          	sd	a5,-32(s0)
     812:	fe043783          	ld	a5,-32(s0)
     816:	ffdd                	bnez	a5,7d4 <printint+0x54>
  if(neg)
     818:	fe842783          	lw	a5,-24(s0)
     81c:	2781                	sext.w	a5,a5
     81e:	cb95                	beqz	a5,852 <printint+0xd2>
    buf[i++] = '-';
     820:	fec42783          	lw	a5,-20(s0)
     824:	0017871b          	addiw	a4,a5,1
     828:	fee42623          	sw	a4,-20(s0)
     82c:	17c1                	addi	a5,a5,-16
     82e:	97a2                	add	a5,a5,s0
     830:	02d00713          	li	a4,45
     834:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     838:	a829                	j	852 <printint+0xd2>
    putc(fd, buf[i]);
     83a:	fec42783          	lw	a5,-20(s0)
     83e:	17c1                	addi	a5,a5,-16
     840:	97a2                	add	a5,a5,s0
     842:	fd87c703          	lbu	a4,-40(a5)
     846:	fbc42783          	lw	a5,-68(s0)
     84a:	85ba                	mv	a1,a4
     84c:	853e                	mv	a0,a5
     84e:	f01ff0ef          	jal	74e <putc>
  while(--i >= 0)
     852:	fec42783          	lw	a5,-20(s0)
     856:	37fd                	addiw	a5,a5,-1
     858:	fef42623          	sw	a5,-20(s0)
     85c:	fec42783          	lw	a5,-20(s0)
     860:	2781                	sext.w	a5,a5
     862:	fc07dce3          	bgez	a5,83a <printint+0xba>
}
     866:	0001                	nop
     868:	0001                	nop
     86a:	60e6                	ld	ra,88(sp)
     86c:	6446                	ld	s0,80(sp)
     86e:	6125                	addi	sp,sp,96
     870:	8082                	ret

0000000000000872 <printptr>:

static void
printptr(int fd, uint64 x) {
     872:	7179                	addi	sp,sp,-48
     874:	f406                	sd	ra,40(sp)
     876:	f022                	sd	s0,32(sp)
     878:	1800                	addi	s0,sp,48
     87a:	87aa                	mv	a5,a0
     87c:	fcb43823          	sd	a1,-48(s0)
     880:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     884:	fdc42783          	lw	a5,-36(s0)
     888:	03000593          	li	a1,48
     88c:	853e                	mv	a0,a5
     88e:	ec1ff0ef          	jal	74e <putc>
  putc(fd, 'x');
     892:	fdc42783          	lw	a5,-36(s0)
     896:	07800593          	li	a1,120
     89a:	853e                	mv	a0,a5
     89c:	eb3ff0ef          	jal	74e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8a0:	fe042623          	sw	zero,-20(s0)
     8a4:	a81d                	j	8da <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8a6:	fd043783          	ld	a5,-48(s0)
     8aa:	93f1                	srli	a5,a5,0x3c
     8ac:	00001717          	auipc	a4,0x1
     8b0:	75470713          	addi	a4,a4,1876 # 2000 <digits>
     8b4:	97ba                	add	a5,a5,a4
     8b6:	0007c703          	lbu	a4,0(a5)
     8ba:	fdc42783          	lw	a5,-36(s0)
     8be:	85ba                	mv	a1,a4
     8c0:	853e                	mv	a0,a5
     8c2:	e8dff0ef          	jal	74e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8c6:	fec42783          	lw	a5,-20(s0)
     8ca:	2785                	addiw	a5,a5,1
     8cc:	fef42623          	sw	a5,-20(s0)
     8d0:	fd043783          	ld	a5,-48(s0)
     8d4:	0792                	slli	a5,a5,0x4
     8d6:	fcf43823          	sd	a5,-48(s0)
     8da:	fec42703          	lw	a4,-20(s0)
     8de:	47bd                	li	a5,15
     8e0:	fce7f3e3          	bgeu	a5,a4,8a6 <printptr+0x34>
}
     8e4:	0001                	nop
     8e6:	0001                	nop
     8e8:	70a2                	ld	ra,40(sp)
     8ea:	7402                	ld	s0,32(sp)
     8ec:	6145                	addi	sp,sp,48
     8ee:	8082                	ret

00000000000008f0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8f0:	715d                	addi	sp,sp,-80
     8f2:	e486                	sd	ra,72(sp)
     8f4:	e0a2                	sd	s0,64(sp)
     8f6:	0880                	addi	s0,sp,80
     8f8:	87aa                	mv	a5,a0
     8fa:	fcb43023          	sd	a1,-64(s0)
     8fe:	fac43c23          	sd	a2,-72(s0)
     902:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     906:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     90a:	fc042e23          	sw	zero,-36(s0)
     90e:	a189                	j	d50 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     910:	fdc42783          	lw	a5,-36(s0)
     914:	fc043703          	ld	a4,-64(s0)
     918:	97ba                	add	a5,a5,a4
     91a:	0007c783          	lbu	a5,0(a5)
     91e:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     922:	fd842783          	lw	a5,-40(s0)
     926:	2781                	sext.w	a5,a5
     928:	eb8d                	bnez	a5,95a <vprintf+0x6a>
      if(c0 == '%'){
     92a:	fd442783          	lw	a5,-44(s0)
     92e:	0007871b          	sext.w	a4,a5
     932:	02500793          	li	a5,37
     936:	00f71763          	bne	a4,a5,944 <vprintf+0x54>
        state = '%';
     93a:	02500793          	li	a5,37
     93e:	fcf42c23          	sw	a5,-40(s0)
     942:	a111                	j	d46 <vprintf+0x456>
      } else {
        putc(fd, c0);
     944:	fd442783          	lw	a5,-44(s0)
     948:	0ff7f713          	zext.b	a4,a5
     94c:	fcc42783          	lw	a5,-52(s0)
     950:	85ba                	mv	a1,a4
     952:	853e                	mv	a0,a5
     954:	dfbff0ef          	jal	74e <putc>
     958:	a6fd                	j	d46 <vprintf+0x456>
      }
    } else if(state == '%'){
     95a:	fd842783          	lw	a5,-40(s0)
     95e:	0007871b          	sext.w	a4,a5
     962:	02500793          	li	a5,37
     966:	3ef71063          	bne	a4,a5,d46 <vprintf+0x456>
      c1 = c2 = 0;
     96a:	fe042023          	sw	zero,-32(s0)
     96e:	fe042783          	lw	a5,-32(s0)
     972:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     976:	fd442783          	lw	a5,-44(s0)
     97a:	2781                	sext.w	a5,a5
     97c:	cb99                	beqz	a5,992 <vprintf+0xa2>
     97e:	fdc42783          	lw	a5,-36(s0)
     982:	0785                	addi	a5,a5,1
     984:	fc043703          	ld	a4,-64(s0)
     988:	97ba                	add	a5,a5,a4
     98a:	0007c783          	lbu	a5,0(a5)
     98e:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     992:	fe442783          	lw	a5,-28(s0)
     996:	2781                	sext.w	a5,a5
     998:	cb99                	beqz	a5,9ae <vprintf+0xbe>
     99a:	fdc42783          	lw	a5,-36(s0)
     99e:	0789                	addi	a5,a5,2
     9a0:	fc043703          	ld	a4,-64(s0)
     9a4:	97ba                	add	a5,a5,a4
     9a6:	0007c783          	lbu	a5,0(a5)
     9aa:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     9ae:	fd442783          	lw	a5,-44(s0)
     9b2:	0007871b          	sext.w	a4,a5
     9b6:	06400793          	li	a5,100
     9ba:	02f71363          	bne	a4,a5,9e0 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     9be:	fb843783          	ld	a5,-72(s0)
     9c2:	00878713          	addi	a4,a5,8
     9c6:	fae43c23          	sd	a4,-72(s0)
     9ca:	439c                	lw	a5,0(a5)
     9cc:	873e                	mv	a4,a5
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	4685                	li	a3,1
     9d4:	4629                	li	a2,10
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	da7ff0ef          	jal	780 <printint>
     9de:	a695                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9e0:	fd442783          	lw	a5,-44(s0)
     9e4:	0007871b          	sext.w	a4,a5
     9e8:	06c00793          	li	a5,108
     9ec:	04f71063          	bne	a4,a5,a2c <vprintf+0x13c>
     9f0:	fe442783          	lw	a5,-28(s0)
     9f4:	0007871b          	sext.w	a4,a5
     9f8:	06400793          	li	a5,100
     9fc:	02f71863          	bne	a4,a5,a2c <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a00:	fb843783          	ld	a5,-72(s0)
     a04:	00878713          	addi	a4,a5,8
     a08:	fae43c23          	sd	a4,-72(s0)
     a0c:	639c                	ld	a5,0(a5)
     a0e:	873e                	mv	a4,a5
     a10:	fcc42783          	lw	a5,-52(s0)
     a14:	4685                	li	a3,1
     a16:	4629                	li	a2,10
     a18:	85ba                	mv	a1,a4
     a1a:	853e                	mv	a0,a5
     a1c:	d65ff0ef          	jal	780 <printint>
        i += 1;
     a20:	fdc42783          	lw	a5,-36(s0)
     a24:	2785                	addiw	a5,a5,1
     a26:	fcf42e23          	sw	a5,-36(s0)
     a2a:	ae21                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     a2c:	fd442783          	lw	a5,-44(s0)
     a30:	0007871b          	sext.w	a4,a5
     a34:	06c00793          	li	a5,108
     a38:	04f71863          	bne	a4,a5,a88 <vprintf+0x198>
     a3c:	fe442783          	lw	a5,-28(s0)
     a40:	0007871b          	sext.w	a4,a5
     a44:	06c00793          	li	a5,108
     a48:	04f71063          	bne	a4,a5,a88 <vprintf+0x198>
     a4c:	fe042783          	lw	a5,-32(s0)
     a50:	0007871b          	sext.w	a4,a5
     a54:	06400793          	li	a5,100
     a58:	02f71863          	bne	a4,a5,a88 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a5c:	fb843783          	ld	a5,-72(s0)
     a60:	00878713          	addi	a4,a5,8
     a64:	fae43c23          	sd	a4,-72(s0)
     a68:	639c                	ld	a5,0(a5)
     a6a:	873e                	mv	a4,a5
     a6c:	fcc42783          	lw	a5,-52(s0)
     a70:	4685                	li	a3,1
     a72:	4629                	li	a2,10
     a74:	85ba                	mv	a1,a4
     a76:	853e                	mv	a0,a5
     a78:	d09ff0ef          	jal	780 <printint>
        i += 2;
     a7c:	fdc42783          	lw	a5,-36(s0)
     a80:	2789                	addiw	a5,a5,2
     a82:	fcf42e23          	sw	a5,-36(s0)
     a86:	ac75                	j	d42 <vprintf+0x452>
      } else if(c0 == 'u'){
     a88:	fd442783          	lw	a5,-44(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	07500793          	li	a5,117
     a94:	02f71563          	bne	a4,a5,abe <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a98:	fb843783          	ld	a5,-72(s0)
     a9c:	00878713          	addi	a4,a5,8
     aa0:	fae43c23          	sd	a4,-72(s0)
     aa4:	439c                	lw	a5,0(a5)
     aa6:	02079713          	slli	a4,a5,0x20
     aaa:	9301                	srli	a4,a4,0x20
     aac:	fcc42783          	lw	a5,-52(s0)
     ab0:	4681                	li	a3,0
     ab2:	4629                	li	a2,10
     ab4:	85ba                	mv	a1,a4
     ab6:	853e                	mv	a0,a5
     ab8:	cc9ff0ef          	jal	780 <printint>
     abc:	a459                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     abe:	fd442783          	lw	a5,-44(s0)
     ac2:	0007871b          	sext.w	a4,a5
     ac6:	06c00793          	li	a5,108
     aca:	04f71063          	bne	a4,a5,b0a <vprintf+0x21a>
     ace:	fe442783          	lw	a5,-28(s0)
     ad2:	0007871b          	sext.w	a4,a5
     ad6:	07500793          	li	a5,117
     ada:	02f71863          	bne	a4,a5,b0a <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ade:	fb843783          	ld	a5,-72(s0)
     ae2:	00878713          	addi	a4,a5,8
     ae6:	fae43c23          	sd	a4,-72(s0)
     aea:	639c                	ld	a5,0(a5)
     aec:	873e                	mv	a4,a5
     aee:	fcc42783          	lw	a5,-52(s0)
     af2:	4681                	li	a3,0
     af4:	4629                	li	a2,10
     af6:	85ba                	mv	a1,a4
     af8:	853e                	mv	a0,a5
     afa:	c87ff0ef          	jal	780 <printint>
        i += 1;
     afe:	fdc42783          	lw	a5,-36(s0)
     b02:	2785                	addiw	a5,a5,1
     b04:	fcf42e23          	sw	a5,-36(s0)
     b08:	ac2d                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     b0a:	fd442783          	lw	a5,-44(s0)
     b0e:	0007871b          	sext.w	a4,a5
     b12:	06c00793          	li	a5,108
     b16:	04f71863          	bne	a4,a5,b66 <vprintf+0x276>
     b1a:	fe442783          	lw	a5,-28(s0)
     b1e:	0007871b          	sext.w	a4,a5
     b22:	06c00793          	li	a5,108
     b26:	04f71063          	bne	a4,a5,b66 <vprintf+0x276>
     b2a:	fe042783          	lw	a5,-32(s0)
     b2e:	0007871b          	sext.w	a4,a5
     b32:	07500793          	li	a5,117
     b36:	02f71863          	bne	a4,a5,b66 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b3a:	fb843783          	ld	a5,-72(s0)
     b3e:	00878713          	addi	a4,a5,8
     b42:	fae43c23          	sd	a4,-72(s0)
     b46:	639c                	ld	a5,0(a5)
     b48:	873e                	mv	a4,a5
     b4a:	fcc42783          	lw	a5,-52(s0)
     b4e:	4681                	li	a3,0
     b50:	4629                	li	a2,10
     b52:	85ba                	mv	a1,a4
     b54:	853e                	mv	a0,a5
     b56:	c2bff0ef          	jal	780 <printint>
        i += 2;
     b5a:	fdc42783          	lw	a5,-36(s0)
     b5e:	2789                	addiw	a5,a5,2
     b60:	fcf42e23          	sw	a5,-36(s0)
     b64:	aaf9                	j	d42 <vprintf+0x452>
      } else if(c0 == 'x'){
     b66:	fd442783          	lw	a5,-44(s0)
     b6a:	0007871b          	sext.w	a4,a5
     b6e:	07800793          	li	a5,120
     b72:	02f71563          	bne	a4,a5,b9c <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b76:	fb843783          	ld	a5,-72(s0)
     b7a:	00878713          	addi	a4,a5,8
     b7e:	fae43c23          	sd	a4,-72(s0)
     b82:	439c                	lw	a5,0(a5)
     b84:	02079713          	slli	a4,a5,0x20
     b88:	9301                	srli	a4,a4,0x20
     b8a:	fcc42783          	lw	a5,-52(s0)
     b8e:	4681                	li	a3,0
     b90:	4641                	li	a2,16
     b92:	85ba                	mv	a1,a4
     b94:	853e                	mv	a0,a5
     b96:	bebff0ef          	jal	780 <printint>
     b9a:	a265                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b9c:	fd442783          	lw	a5,-44(s0)
     ba0:	0007871b          	sext.w	a4,a5
     ba4:	06c00793          	li	a5,108
     ba8:	04f71063          	bne	a4,a5,be8 <vprintf+0x2f8>
     bac:	fe442783          	lw	a5,-28(s0)
     bb0:	0007871b          	sext.w	a4,a5
     bb4:	07800793          	li	a5,120
     bb8:	02f71863          	bne	a4,a5,be8 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     bbc:	fb843783          	ld	a5,-72(s0)
     bc0:	00878713          	addi	a4,a5,8
     bc4:	fae43c23          	sd	a4,-72(s0)
     bc8:	639c                	ld	a5,0(a5)
     bca:	873e                	mv	a4,a5
     bcc:	fcc42783          	lw	a5,-52(s0)
     bd0:	4681                	li	a3,0
     bd2:	4641                	li	a2,16
     bd4:	85ba                	mv	a1,a4
     bd6:	853e                	mv	a0,a5
     bd8:	ba9ff0ef          	jal	780 <printint>
        i += 1;
     bdc:	fdc42783          	lw	a5,-36(s0)
     be0:	2785                	addiw	a5,a5,1
     be2:	fcf42e23          	sw	a5,-36(s0)
     be6:	aab1                	j	d42 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     be8:	fd442783          	lw	a5,-44(s0)
     bec:	0007871b          	sext.w	a4,a5
     bf0:	06c00793          	li	a5,108
     bf4:	04f71863          	bne	a4,a5,c44 <vprintf+0x354>
     bf8:	fe442783          	lw	a5,-28(s0)
     bfc:	0007871b          	sext.w	a4,a5
     c00:	06c00793          	li	a5,108
     c04:	04f71063          	bne	a4,a5,c44 <vprintf+0x354>
     c08:	fe042783          	lw	a5,-32(s0)
     c0c:	0007871b          	sext.w	a4,a5
     c10:	07800793          	li	a5,120
     c14:	02f71863          	bne	a4,a5,c44 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c18:	fb843783          	ld	a5,-72(s0)
     c1c:	00878713          	addi	a4,a5,8
     c20:	fae43c23          	sd	a4,-72(s0)
     c24:	639c                	ld	a5,0(a5)
     c26:	873e                	mv	a4,a5
     c28:	fcc42783          	lw	a5,-52(s0)
     c2c:	4681                	li	a3,0
     c2e:	4641                	li	a2,16
     c30:	85ba                	mv	a1,a4
     c32:	853e                	mv	a0,a5
     c34:	b4dff0ef          	jal	780 <printint>
        i += 2;
     c38:	fdc42783          	lw	a5,-36(s0)
     c3c:	2789                	addiw	a5,a5,2
     c3e:	fcf42e23          	sw	a5,-36(s0)
     c42:	a201                	j	d42 <vprintf+0x452>
      } else if(c0 == 'p'){
     c44:	fd442783          	lw	a5,-44(s0)
     c48:	0007871b          	sext.w	a4,a5
     c4c:	07000793          	li	a5,112
     c50:	02f71063          	bne	a4,a5,c70 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c54:	fb843783          	ld	a5,-72(s0)
     c58:	00878713          	addi	a4,a5,8
     c5c:	fae43c23          	sd	a4,-72(s0)
     c60:	6398                	ld	a4,0(a5)
     c62:	fcc42783          	lw	a5,-52(s0)
     c66:	85ba                	mv	a1,a4
     c68:	853e                	mv	a0,a5
     c6a:	c09ff0ef          	jal	872 <printptr>
     c6e:	a8d1                	j	d42 <vprintf+0x452>
      } else if(c0 == 'c'){
     c70:	fd442783          	lw	a5,-44(s0)
     c74:	0007871b          	sext.w	a4,a5
     c78:	06300793          	li	a5,99
     c7c:	02f71263          	bne	a4,a5,ca0 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c80:	fb843783          	ld	a5,-72(s0)
     c84:	00878713          	addi	a4,a5,8
     c88:	fae43c23          	sd	a4,-72(s0)
     c8c:	439c                	lw	a5,0(a5)
     c8e:	0ff7f713          	zext.b	a4,a5
     c92:	fcc42783          	lw	a5,-52(s0)
     c96:	85ba                	mv	a1,a4
     c98:	853e                	mv	a0,a5
     c9a:	ab5ff0ef          	jal	74e <putc>
     c9e:	a055                	j	d42 <vprintf+0x452>
      } else if(c0 == 's'){
     ca0:	fd442783          	lw	a5,-44(s0)
     ca4:	0007871b          	sext.w	a4,a5
     ca8:	07300793          	li	a5,115
     cac:	04f71a63          	bne	a4,a5,d00 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     cb0:	fb843783          	ld	a5,-72(s0)
     cb4:	00878713          	addi	a4,a5,8
     cb8:	fae43c23          	sd	a4,-72(s0)
     cbc:	639c                	ld	a5,0(a5)
     cbe:	fef43423          	sd	a5,-24(s0)
     cc2:	fe843783          	ld	a5,-24(s0)
     cc6:	e79d                	bnez	a5,cf4 <vprintf+0x404>
          s = "(null)";
     cc8:	00000797          	auipc	a5,0x0
     ccc:	47078793          	addi	a5,a5,1136 # 1138 <malloc+0x18e>
     cd0:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     cd4:	a005                	j	cf4 <vprintf+0x404>
          putc(fd, *s);
     cd6:	fe843783          	ld	a5,-24(s0)
     cda:	0007c703          	lbu	a4,0(a5)
     cde:	fcc42783          	lw	a5,-52(s0)
     ce2:	85ba                	mv	a1,a4
     ce4:	853e                	mv	a0,a5
     ce6:	a69ff0ef          	jal	74e <putc>
        for(; *s; s++)
     cea:	fe843783          	ld	a5,-24(s0)
     cee:	0785                	addi	a5,a5,1
     cf0:	fef43423          	sd	a5,-24(s0)
     cf4:	fe843783          	ld	a5,-24(s0)
     cf8:	0007c783          	lbu	a5,0(a5)
     cfc:	ffe9                	bnez	a5,cd6 <vprintf+0x3e6>
     cfe:	a091                	j	d42 <vprintf+0x452>
      } else if(c0 == '%'){
     d00:	fd442783          	lw	a5,-44(s0)
     d04:	0007871b          	sext.w	a4,a5
     d08:	02500793          	li	a5,37
     d0c:	00f71a63          	bne	a4,a5,d20 <vprintf+0x430>
        putc(fd, '%');
     d10:	fcc42783          	lw	a5,-52(s0)
     d14:	02500593          	li	a1,37
     d18:	853e                	mv	a0,a5
     d1a:	a35ff0ef          	jal	74e <putc>
     d1e:	a015                	j	d42 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d20:	fcc42783          	lw	a5,-52(s0)
     d24:	02500593          	li	a1,37
     d28:	853e                	mv	a0,a5
     d2a:	a25ff0ef          	jal	74e <putc>
        putc(fd, c0);
     d2e:	fd442783          	lw	a5,-44(s0)
     d32:	0ff7f713          	zext.b	a4,a5
     d36:	fcc42783          	lw	a5,-52(s0)
     d3a:	85ba                	mv	a1,a4
     d3c:	853e                	mv	a0,a5
     d3e:	a11ff0ef          	jal	74e <putc>
      }

      state = 0;
     d42:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d46:	fdc42783          	lw	a5,-36(s0)
     d4a:	2785                	addiw	a5,a5,1
     d4c:	fcf42e23          	sw	a5,-36(s0)
     d50:	fdc42783          	lw	a5,-36(s0)
     d54:	fc043703          	ld	a4,-64(s0)
     d58:	97ba                	add	a5,a5,a4
     d5a:	0007c783          	lbu	a5,0(a5)
     d5e:	ba0799e3          	bnez	a5,910 <vprintf+0x20>
    }
  }
}
     d62:	0001                	nop
     d64:	0001                	nop
     d66:	60a6                	ld	ra,72(sp)
     d68:	6406                	ld	s0,64(sp)
     d6a:	6161                	addi	sp,sp,80
     d6c:	8082                	ret

0000000000000d6e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d6e:	7159                	addi	sp,sp,-112
     d70:	fc06                	sd	ra,56(sp)
     d72:	f822                	sd	s0,48(sp)
     d74:	0080                	addi	s0,sp,64
     d76:	fcb43823          	sd	a1,-48(s0)
     d7a:	e010                	sd	a2,0(s0)
     d7c:	e414                	sd	a3,8(s0)
     d7e:	e818                	sd	a4,16(s0)
     d80:	ec1c                	sd	a5,24(s0)
     d82:	03043023          	sd	a6,32(s0)
     d86:	03143423          	sd	a7,40(s0)
     d8a:	87aa                	mv	a5,a0
     d8c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d90:	03040793          	addi	a5,s0,48
     d94:	fcf43423          	sd	a5,-56(s0)
     d98:	fc843783          	ld	a5,-56(s0)
     d9c:	fd078793          	addi	a5,a5,-48
     da0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     da4:	fe843703          	ld	a4,-24(s0)
     da8:	fdc42783          	lw	a5,-36(s0)
     dac:	863a                	mv	a2,a4
     dae:	fd043583          	ld	a1,-48(s0)
     db2:	853e                	mv	a0,a5
     db4:	b3dff0ef          	jal	8f0 <vprintf>
}
     db8:	0001                	nop
     dba:	70e2                	ld	ra,56(sp)
     dbc:	7442                	ld	s0,48(sp)
     dbe:	6165                	addi	sp,sp,112
     dc0:	8082                	ret

0000000000000dc2 <printf>:

void
printf(const char *fmt, ...)
{
     dc2:	7159                	addi	sp,sp,-112
     dc4:	f406                	sd	ra,40(sp)
     dc6:	f022                	sd	s0,32(sp)
     dc8:	1800                	addi	s0,sp,48
     dca:	fca43c23          	sd	a0,-40(s0)
     dce:	e40c                	sd	a1,8(s0)
     dd0:	e810                	sd	a2,16(s0)
     dd2:	ec14                	sd	a3,24(s0)
     dd4:	f018                	sd	a4,32(s0)
     dd6:	f41c                	sd	a5,40(s0)
     dd8:	03043823          	sd	a6,48(s0)
     ddc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     de0:	04040793          	addi	a5,s0,64
     de4:	fcf43823          	sd	a5,-48(s0)
     de8:	fd043783          	ld	a5,-48(s0)
     dec:	fc878793          	addi	a5,a5,-56
     df0:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     df4:	fe843783          	ld	a5,-24(s0)
     df8:	863e                	mv	a2,a5
     dfa:	fd843583          	ld	a1,-40(s0)
     dfe:	4505                	li	a0,1
     e00:	af1ff0ef          	jal	8f0 <vprintf>
}
     e04:	0001                	nop
     e06:	70a2                	ld	ra,40(sp)
     e08:	7402                	ld	s0,32(sp)
     e0a:	6165                	addi	sp,sp,112
     e0c:	8082                	ret

0000000000000e0e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e0e:	7179                	addi	sp,sp,-48
     e10:	f406                	sd	ra,40(sp)
     e12:	f022                	sd	s0,32(sp)
     e14:	1800                	addi	s0,sp,48
     e16:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e1a:	fd843783          	ld	a5,-40(s0)
     e1e:	17c1                	addi	a5,a5,-16
     e20:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e24:	00001797          	auipc	a5,0x1
     e28:	40478793          	addi	a5,a5,1028 # 2228 <freep>
     e2c:	639c                	ld	a5,0(a5)
     e2e:	fef43423          	sd	a5,-24(s0)
     e32:	a815                	j	e66 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e34:	fe843783          	ld	a5,-24(s0)
     e38:	639c                	ld	a5,0(a5)
     e3a:	fe843703          	ld	a4,-24(s0)
     e3e:	00f76f63          	bltu	a4,a5,e5c <free+0x4e>
     e42:	fe043703          	ld	a4,-32(s0)
     e46:	fe843783          	ld	a5,-24(s0)
     e4a:	02e7eb63          	bltu	a5,a4,e80 <free+0x72>
     e4e:	fe843783          	ld	a5,-24(s0)
     e52:	639c                	ld	a5,0(a5)
     e54:	fe043703          	ld	a4,-32(s0)
     e58:	02f76463          	bltu	a4,a5,e80 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	639c                	ld	a5,0(a5)
     e62:	fef43423          	sd	a5,-24(s0)
     e66:	fe043703          	ld	a4,-32(s0)
     e6a:	fe843783          	ld	a5,-24(s0)
     e6e:	fce7f3e3          	bgeu	a5,a4,e34 <free+0x26>
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	639c                	ld	a5,0(a5)
     e78:	fe043703          	ld	a4,-32(s0)
     e7c:	faf77ce3          	bgeu	a4,a5,e34 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e80:	fe043783          	ld	a5,-32(s0)
     e84:	479c                	lw	a5,8(a5)
     e86:	1782                	slli	a5,a5,0x20
     e88:	9381                	srli	a5,a5,0x20
     e8a:	0792                	slli	a5,a5,0x4
     e8c:	fe043703          	ld	a4,-32(s0)
     e90:	973e                	add	a4,a4,a5
     e92:	fe843783          	ld	a5,-24(s0)
     e96:	639c                	ld	a5,0(a5)
     e98:	02f71763          	bne	a4,a5,ec6 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e9c:	fe043783          	ld	a5,-32(s0)
     ea0:	4798                	lw	a4,8(a5)
     ea2:	fe843783          	ld	a5,-24(s0)
     ea6:	639c                	ld	a5,0(a5)
     ea8:	479c                	lw	a5,8(a5)
     eaa:	9fb9                	addw	a5,a5,a4
     eac:	0007871b          	sext.w	a4,a5
     eb0:	fe043783          	ld	a5,-32(s0)
     eb4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     eb6:	fe843783          	ld	a5,-24(s0)
     eba:	639c                	ld	a5,0(a5)
     ebc:	6398                	ld	a4,0(a5)
     ebe:	fe043783          	ld	a5,-32(s0)
     ec2:	e398                	sd	a4,0(a5)
     ec4:	a039                	j	ed2 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     ec6:	fe843783          	ld	a5,-24(s0)
     eca:	6398                	ld	a4,0(a5)
     ecc:	fe043783          	ld	a5,-32(s0)
     ed0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ed2:	fe843783          	ld	a5,-24(s0)
     ed6:	479c                	lw	a5,8(a5)
     ed8:	1782                	slli	a5,a5,0x20
     eda:	9381                	srli	a5,a5,0x20
     edc:	0792                	slli	a5,a5,0x4
     ede:	fe843703          	ld	a4,-24(s0)
     ee2:	97ba                	add	a5,a5,a4
     ee4:	fe043703          	ld	a4,-32(s0)
     ee8:	02f71563          	bne	a4,a5,f12 <free+0x104>
    p->s.size += bp->s.size;
     eec:	fe843783          	ld	a5,-24(s0)
     ef0:	4798                	lw	a4,8(a5)
     ef2:	fe043783          	ld	a5,-32(s0)
     ef6:	479c                	lw	a5,8(a5)
     ef8:	9fb9                	addw	a5,a5,a4
     efa:	0007871b          	sext.w	a4,a5
     efe:	fe843783          	ld	a5,-24(s0)
     f02:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f04:	fe043783          	ld	a5,-32(s0)
     f08:	6398                	ld	a4,0(a5)
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	e398                	sd	a4,0(a5)
     f10:	a031                	j	f1c <free+0x10e>
  } else
    p->s.ptr = bp;
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	fe043703          	ld	a4,-32(s0)
     f1a:	e398                	sd	a4,0(a5)
  freep = p;
     f1c:	00001797          	auipc	a5,0x1
     f20:	30c78793          	addi	a5,a5,780 # 2228 <freep>
     f24:	fe843703          	ld	a4,-24(s0)
     f28:	e398                	sd	a4,0(a5)
}
     f2a:	0001                	nop
     f2c:	70a2                	ld	ra,40(sp)
     f2e:	7402                	ld	s0,32(sp)
     f30:	6145                	addi	sp,sp,48
     f32:	8082                	ret

0000000000000f34 <morecore>:

static Header*
morecore(uint nu)
{
     f34:	7179                	addi	sp,sp,-48
     f36:	f406                	sd	ra,40(sp)
     f38:	f022                	sd	s0,32(sp)
     f3a:	1800                	addi	s0,sp,48
     f3c:	87aa                	mv	a5,a0
     f3e:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f42:	fdc42783          	lw	a5,-36(s0)
     f46:	0007871b          	sext.w	a4,a5
     f4a:	6785                	lui	a5,0x1
     f4c:	00f77563          	bgeu	a4,a5,f56 <morecore+0x22>
    nu = 4096;
     f50:	6785                	lui	a5,0x1
     f52:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f56:	fdc42783          	lw	a5,-36(s0)
     f5a:	0047979b          	slliw	a5,a5,0x4
     f5e:	2781                	sext.w	a5,a5
     f60:	853e                	mv	a0,a5
     f62:	ef0ff0ef          	jal	652 <sbrk>
     f66:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f6a:	fe843703          	ld	a4,-24(s0)
     f6e:	57fd                	li	a5,-1
     f70:	00f71463          	bne	a4,a5,f78 <morecore+0x44>
    return 0;
     f74:	4781                	li	a5,0
     f76:	a02d                	j	fa0 <morecore+0x6c>
  hp = (Header*)p;
     f78:	fe843783          	ld	a5,-24(s0)
     f7c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f80:	fe043783          	ld	a5,-32(s0)
     f84:	fdc42703          	lw	a4,-36(s0)
     f88:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f8a:	fe043783          	ld	a5,-32(s0)
     f8e:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x66>
     f90:	853e                	mv	a0,a5
     f92:	e7dff0ef          	jal	e0e <free>
  return freep;
     f96:	00001797          	auipc	a5,0x1
     f9a:	29278793          	addi	a5,a5,658 # 2228 <freep>
     f9e:	639c                	ld	a5,0(a5)
}
     fa0:	853e                	mv	a0,a5
     fa2:	70a2                	ld	ra,40(sp)
     fa4:	7402                	ld	s0,32(sp)
     fa6:	6145                	addi	sp,sp,48
     fa8:	8082                	ret

0000000000000faa <malloc>:

void*
malloc(uint nbytes)
{
     faa:	7139                	addi	sp,sp,-64
     fac:	fc06                	sd	ra,56(sp)
     fae:	f822                	sd	s0,48(sp)
     fb0:	0080                	addi	s0,sp,64
     fb2:	87aa                	mv	a5,a0
     fb4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fb8:	fcc46783          	lwu	a5,-52(s0)
     fbc:	07bd                	addi	a5,a5,15
     fbe:	8391                	srli	a5,a5,0x4
     fc0:	2781                	sext.w	a5,a5
     fc2:	2785                	addiw	a5,a5,1
     fc4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     fc8:	00001797          	auipc	a5,0x1
     fcc:	26078793          	addi	a5,a5,608 # 2228 <freep>
     fd0:	639c                	ld	a5,0(a5)
     fd2:	fef43023          	sd	a5,-32(s0)
     fd6:	fe043783          	ld	a5,-32(s0)
     fda:	ef95                	bnez	a5,1016 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fdc:	00001797          	auipc	a5,0x1
     fe0:	23c78793          	addi	a5,a5,572 # 2218 <base>
     fe4:	fef43023          	sd	a5,-32(s0)
     fe8:	00001797          	auipc	a5,0x1
     fec:	24078793          	addi	a5,a5,576 # 2228 <freep>
     ff0:	fe043703          	ld	a4,-32(s0)
     ff4:	e398                	sd	a4,0(a5)
     ff6:	00001797          	auipc	a5,0x1
     ffa:	23278793          	addi	a5,a5,562 # 2228 <freep>
     ffe:	6398                	ld	a4,0(a5)
    1000:	00001797          	auipc	a5,0x1
    1004:	21878793          	addi	a5,a5,536 # 2218 <base>
    1008:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    100a:	00001797          	auipc	a5,0x1
    100e:	20e78793          	addi	a5,a5,526 # 2218 <base>
    1012:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1016:	fe043783          	ld	a5,-32(s0)
    101a:	639c                	ld	a5,0(a5)
    101c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1020:	fe843783          	ld	a5,-24(s0)
    1024:	479c                	lw	a5,8(a5)
    1026:	fdc42703          	lw	a4,-36(s0)
    102a:	2701                	sext.w	a4,a4
    102c:	06e7e763          	bltu	a5,a4,109a <malloc+0xf0>
      if(p->s.size == nunits)
    1030:	fe843783          	ld	a5,-24(s0)
    1034:	479c                	lw	a5,8(a5)
    1036:	fdc42703          	lw	a4,-36(s0)
    103a:	2701                	sext.w	a4,a4
    103c:	00f71963          	bne	a4,a5,104e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1040:	fe843783          	ld	a5,-24(s0)
    1044:	6398                	ld	a4,0(a5)
    1046:	fe043783          	ld	a5,-32(s0)
    104a:	e398                	sd	a4,0(a5)
    104c:	a825                	j	1084 <malloc+0xda>
      else {
        p->s.size -= nunits;
    104e:	fe843783          	ld	a5,-24(s0)
    1052:	479c                	lw	a5,8(a5)
    1054:	fdc42703          	lw	a4,-36(s0)
    1058:	9f99                	subw	a5,a5,a4
    105a:	0007871b          	sext.w	a4,a5
    105e:	fe843783          	ld	a5,-24(s0)
    1062:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	479c                	lw	a5,8(a5)
    106a:	1782                	slli	a5,a5,0x20
    106c:	9381                	srli	a5,a5,0x20
    106e:	0792                	slli	a5,a5,0x4
    1070:	fe843703          	ld	a4,-24(s0)
    1074:	97ba                	add	a5,a5,a4
    1076:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    107a:	fe843783          	ld	a5,-24(s0)
    107e:	fdc42703          	lw	a4,-36(s0)
    1082:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1084:	00001797          	auipc	a5,0x1
    1088:	1a478793          	addi	a5,a5,420 # 2228 <freep>
    108c:	fe043703          	ld	a4,-32(s0)
    1090:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1092:	fe843783          	ld	a5,-24(s0)
    1096:	07c1                	addi	a5,a5,16
    1098:	a081                	j	10d8 <malloc+0x12e>
    }
    if(p == freep)
    109a:	00001797          	auipc	a5,0x1
    109e:	18e78793          	addi	a5,a5,398 # 2228 <freep>
    10a2:	639c                	ld	a5,0(a5)
    10a4:	fe843703          	ld	a4,-24(s0)
    10a8:	00f71e63          	bne	a4,a5,10c4 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    10ac:	fdc42783          	lw	a5,-36(s0)
    10b0:	853e                	mv	a0,a5
    10b2:	e83ff0ef          	jal	f34 <morecore>
    10b6:	fea43423          	sd	a0,-24(s0)
    10ba:	fe843783          	ld	a5,-24(s0)
    10be:	e399                	bnez	a5,10c4 <malloc+0x11a>
        return 0;
    10c0:	4781                	li	a5,0
    10c2:	a819                	j	10d8 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10c4:	fe843783          	ld	a5,-24(s0)
    10c8:	fef43023          	sd	a5,-32(s0)
    10cc:	fe843783          	ld	a5,-24(s0)
    10d0:	639c                	ld	a5,0(a5)
    10d2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10d6:	b7a9                	j	1020 <malloc+0x76>
  }
}
    10d8:	853e                	mv	a0,a5
    10da:	70e2                	ld	ra,56(sp)
    10dc:	7442                	ld	s0,48(sp)
    10de:	6121                	addi	sp,sp,64
    10e0:	8082                	ret
