
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
      3a:	0ba50513          	addi	a0,a0,186 # 10f0 <malloc+0x13e>
      3e:	58d000ef          	jal	dca <printf>
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
      94:	07850513          	addi	a0,a0,120 # 1108 <malloc+0x156>
      98:	533000ef          	jal	dca <printf>
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
      fa:	02a50513          	addi	a0,a0,42 # 1120 <malloc+0x16e>
      fe:	4cd000ef          	jal	dca <printf>
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

000000000000074e <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     74e:	48dd                	li	a7,23
 ecall
     750:	00000073          	ecall
 ret
     754:	8082                	ret

0000000000000756 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     756:	1101                	addi	sp,sp,-32
     758:	ec06                	sd	ra,24(sp)
     75a:	e822                	sd	s0,16(sp)
     75c:	1000                	addi	s0,sp,32
     75e:	87aa                	mv	a5,a0
     760:	872e                	mv	a4,a1
     762:	fef42623          	sw	a5,-20(s0)
     766:	87ba                	mv	a5,a4
     768:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     76c:	feb40713          	addi	a4,s0,-21
     770:	fec42783          	lw	a5,-20(s0)
     774:	4605                	li	a2,1
     776:	85ba                	mv	a1,a4
     778:	853e                	mv	a0,a5
     77a:	f4dff0ef          	jal	6c6 <write>
}
     77e:	0001                	nop
     780:	60e2                	ld	ra,24(sp)
     782:	6442                	ld	s0,16(sp)
     784:	6105                	addi	sp,sp,32
     786:	8082                	ret

0000000000000788 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     788:	711d                	addi	sp,sp,-96
     78a:	ec86                	sd	ra,88(sp)
     78c:	e8a2                	sd	s0,80(sp)
     78e:	1080                	addi	s0,sp,96
     790:	87aa                	mv	a5,a0
     792:	fab43823          	sd	a1,-80(s0)
     796:	8736                	mv	a4,a3
     798:	faf42e23          	sw	a5,-68(s0)
     79c:	87b2                	mv	a5,a2
     79e:	faf42c23          	sw	a5,-72(s0)
     7a2:	87ba                	mv	a5,a4
     7a4:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     7a8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7ac:	fac42783          	lw	a5,-84(s0)
     7b0:	2781                	sext.w	a5,a5
     7b2:	cf99                	beqz	a5,7d0 <printint+0x48>
     7b4:	fb043783          	ld	a5,-80(s0)
     7b8:	0007dc63          	bgez	a5,7d0 <printint+0x48>
    neg = 1;
     7bc:	4785                	li	a5,1
     7be:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7c2:	fb043783          	ld	a5,-80(s0)
     7c6:	40f007b3          	neg	a5,a5
     7ca:	fef43023          	sd	a5,-32(s0)
     7ce:	a029                	j	7d8 <printint+0x50>
  } else {
    x = xx;
     7d0:	fb043783          	ld	a5,-80(s0)
     7d4:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     7d8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7dc:	fb842783          	lw	a5,-72(s0)
     7e0:	fe043703          	ld	a4,-32(s0)
     7e4:	02f77733          	remu	a4,a4,a5
     7e8:	fec42783          	lw	a5,-20(s0)
     7ec:	0017869b          	addiw	a3,a5,1
     7f0:	fed42623          	sw	a3,-20(s0)
     7f4:	00002697          	auipc	a3,0x2
     7f8:	80c68693          	addi	a3,a3,-2036 # 2000 <digits>
     7fc:	9736                	add	a4,a4,a3
     7fe:	00074703          	lbu	a4,0(a4)
     802:	17c1                	addi	a5,a5,-16
     804:	97a2                	add	a5,a5,s0
     806:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     80a:	fb842783          	lw	a5,-72(s0)
     80e:	fe043703          	ld	a4,-32(s0)
     812:	02f757b3          	divu	a5,a4,a5
     816:	fef43023          	sd	a5,-32(s0)
     81a:	fe043783          	ld	a5,-32(s0)
     81e:	ffdd                	bnez	a5,7dc <printint+0x54>
  if(neg)
     820:	fe842783          	lw	a5,-24(s0)
     824:	2781                	sext.w	a5,a5
     826:	cb95                	beqz	a5,85a <printint+0xd2>
    buf[i++] = '-';
     828:	fec42783          	lw	a5,-20(s0)
     82c:	0017871b          	addiw	a4,a5,1
     830:	fee42623          	sw	a4,-20(s0)
     834:	17c1                	addi	a5,a5,-16
     836:	97a2                	add	a5,a5,s0
     838:	02d00713          	li	a4,45
     83c:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     840:	a829                	j	85a <printint+0xd2>
    putc(fd, buf[i]);
     842:	fec42783          	lw	a5,-20(s0)
     846:	17c1                	addi	a5,a5,-16
     848:	97a2                	add	a5,a5,s0
     84a:	fd87c703          	lbu	a4,-40(a5)
     84e:	fbc42783          	lw	a5,-68(s0)
     852:	85ba                	mv	a1,a4
     854:	853e                	mv	a0,a5
     856:	f01ff0ef          	jal	756 <putc>
  while(--i >= 0)
     85a:	fec42783          	lw	a5,-20(s0)
     85e:	37fd                	addiw	a5,a5,-1
     860:	fef42623          	sw	a5,-20(s0)
     864:	fec42783          	lw	a5,-20(s0)
     868:	2781                	sext.w	a5,a5
     86a:	fc07dce3          	bgez	a5,842 <printint+0xba>
}
     86e:	0001                	nop
     870:	0001                	nop
     872:	60e6                	ld	ra,88(sp)
     874:	6446                	ld	s0,80(sp)
     876:	6125                	addi	sp,sp,96
     878:	8082                	ret

000000000000087a <printptr>:

static void
printptr(int fd, uint64 x) {
     87a:	7179                	addi	sp,sp,-48
     87c:	f406                	sd	ra,40(sp)
     87e:	f022                	sd	s0,32(sp)
     880:	1800                	addi	s0,sp,48
     882:	87aa                	mv	a5,a0
     884:	fcb43823          	sd	a1,-48(s0)
     888:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     88c:	fdc42783          	lw	a5,-36(s0)
     890:	03000593          	li	a1,48
     894:	853e                	mv	a0,a5
     896:	ec1ff0ef          	jal	756 <putc>
  putc(fd, 'x');
     89a:	fdc42783          	lw	a5,-36(s0)
     89e:	07800593          	li	a1,120
     8a2:	853e                	mv	a0,a5
     8a4:	eb3ff0ef          	jal	756 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8a8:	fe042623          	sw	zero,-20(s0)
     8ac:	a81d                	j	8e2 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8ae:	fd043783          	ld	a5,-48(s0)
     8b2:	93f1                	srli	a5,a5,0x3c
     8b4:	00001717          	auipc	a4,0x1
     8b8:	74c70713          	addi	a4,a4,1868 # 2000 <digits>
     8bc:	97ba                	add	a5,a5,a4
     8be:	0007c703          	lbu	a4,0(a5)
     8c2:	fdc42783          	lw	a5,-36(s0)
     8c6:	85ba                	mv	a1,a4
     8c8:	853e                	mv	a0,a5
     8ca:	e8dff0ef          	jal	756 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8ce:	fec42783          	lw	a5,-20(s0)
     8d2:	2785                	addiw	a5,a5,1
     8d4:	fef42623          	sw	a5,-20(s0)
     8d8:	fd043783          	ld	a5,-48(s0)
     8dc:	0792                	slli	a5,a5,0x4
     8de:	fcf43823          	sd	a5,-48(s0)
     8e2:	fec42703          	lw	a4,-20(s0)
     8e6:	47bd                	li	a5,15
     8e8:	fce7f3e3          	bgeu	a5,a4,8ae <printptr+0x34>
}
     8ec:	0001                	nop
     8ee:	0001                	nop
     8f0:	70a2                	ld	ra,40(sp)
     8f2:	7402                	ld	s0,32(sp)
     8f4:	6145                	addi	sp,sp,48
     8f6:	8082                	ret

00000000000008f8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8f8:	715d                	addi	sp,sp,-80
     8fa:	e486                	sd	ra,72(sp)
     8fc:	e0a2                	sd	s0,64(sp)
     8fe:	0880                	addi	s0,sp,80
     900:	87aa                	mv	a5,a0
     902:	fcb43023          	sd	a1,-64(s0)
     906:	fac43c23          	sd	a2,-72(s0)
     90a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     90e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     912:	fc042e23          	sw	zero,-36(s0)
     916:	a189                	j	d58 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     918:	fdc42783          	lw	a5,-36(s0)
     91c:	fc043703          	ld	a4,-64(s0)
     920:	97ba                	add	a5,a5,a4
     922:	0007c783          	lbu	a5,0(a5)
     926:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     92a:	fd842783          	lw	a5,-40(s0)
     92e:	2781                	sext.w	a5,a5
     930:	eb8d                	bnez	a5,962 <vprintf+0x6a>
      if(c0 == '%'){
     932:	fd442783          	lw	a5,-44(s0)
     936:	0007871b          	sext.w	a4,a5
     93a:	02500793          	li	a5,37
     93e:	00f71763          	bne	a4,a5,94c <vprintf+0x54>
        state = '%';
     942:	02500793          	li	a5,37
     946:	fcf42c23          	sw	a5,-40(s0)
     94a:	a111                	j	d4e <vprintf+0x456>
      } else {
        putc(fd, c0);
     94c:	fd442783          	lw	a5,-44(s0)
     950:	0ff7f713          	zext.b	a4,a5
     954:	fcc42783          	lw	a5,-52(s0)
     958:	85ba                	mv	a1,a4
     95a:	853e                	mv	a0,a5
     95c:	dfbff0ef          	jal	756 <putc>
     960:	a6fd                	j	d4e <vprintf+0x456>
      }
    } else if(state == '%'){
     962:	fd842783          	lw	a5,-40(s0)
     966:	0007871b          	sext.w	a4,a5
     96a:	02500793          	li	a5,37
     96e:	3ef71063          	bne	a4,a5,d4e <vprintf+0x456>
      c1 = c2 = 0;
     972:	fe042023          	sw	zero,-32(s0)
     976:	fe042783          	lw	a5,-32(s0)
     97a:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     97e:	fd442783          	lw	a5,-44(s0)
     982:	2781                	sext.w	a5,a5
     984:	cb99                	beqz	a5,99a <vprintf+0xa2>
     986:	fdc42783          	lw	a5,-36(s0)
     98a:	0785                	addi	a5,a5,1
     98c:	fc043703          	ld	a4,-64(s0)
     990:	97ba                	add	a5,a5,a4
     992:	0007c783          	lbu	a5,0(a5)
     996:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     99a:	fe442783          	lw	a5,-28(s0)
     99e:	2781                	sext.w	a5,a5
     9a0:	cb99                	beqz	a5,9b6 <vprintf+0xbe>
     9a2:	fdc42783          	lw	a5,-36(s0)
     9a6:	0789                	addi	a5,a5,2
     9a8:	fc043703          	ld	a4,-64(s0)
     9ac:	97ba                	add	a5,a5,a4
     9ae:	0007c783          	lbu	a5,0(a5)
     9b2:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     9b6:	fd442783          	lw	a5,-44(s0)
     9ba:	0007871b          	sext.w	a4,a5
     9be:	06400793          	li	a5,100
     9c2:	02f71363          	bne	a4,a5,9e8 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     9c6:	fb843783          	ld	a5,-72(s0)
     9ca:	00878713          	addi	a4,a5,8
     9ce:	fae43c23          	sd	a4,-72(s0)
     9d2:	439c                	lw	a5,0(a5)
     9d4:	873e                	mv	a4,a5
     9d6:	fcc42783          	lw	a5,-52(s0)
     9da:	4685                	li	a3,1
     9dc:	4629                	li	a2,10
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	da7ff0ef          	jal	788 <printint>
     9e6:	a695                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9e8:	fd442783          	lw	a5,-44(s0)
     9ec:	0007871b          	sext.w	a4,a5
     9f0:	06c00793          	li	a5,108
     9f4:	04f71063          	bne	a4,a5,a34 <vprintf+0x13c>
     9f8:	fe442783          	lw	a5,-28(s0)
     9fc:	0007871b          	sext.w	a4,a5
     a00:	06400793          	li	a5,100
     a04:	02f71863          	bne	a4,a5,a34 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a08:	fb843783          	ld	a5,-72(s0)
     a0c:	00878713          	addi	a4,a5,8
     a10:	fae43c23          	sd	a4,-72(s0)
     a14:	639c                	ld	a5,0(a5)
     a16:	873e                	mv	a4,a5
     a18:	fcc42783          	lw	a5,-52(s0)
     a1c:	4685                	li	a3,1
     a1e:	4629                	li	a2,10
     a20:	85ba                	mv	a1,a4
     a22:	853e                	mv	a0,a5
     a24:	d65ff0ef          	jal	788 <printint>
        i += 1;
     a28:	fdc42783          	lw	a5,-36(s0)
     a2c:	2785                	addiw	a5,a5,1
     a2e:	fcf42e23          	sw	a5,-36(s0)
     a32:	ae21                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     a34:	fd442783          	lw	a5,-44(s0)
     a38:	0007871b          	sext.w	a4,a5
     a3c:	06c00793          	li	a5,108
     a40:	04f71863          	bne	a4,a5,a90 <vprintf+0x198>
     a44:	fe442783          	lw	a5,-28(s0)
     a48:	0007871b          	sext.w	a4,a5
     a4c:	06c00793          	li	a5,108
     a50:	04f71063          	bne	a4,a5,a90 <vprintf+0x198>
     a54:	fe042783          	lw	a5,-32(s0)
     a58:	0007871b          	sext.w	a4,a5
     a5c:	06400793          	li	a5,100
     a60:	02f71863          	bne	a4,a5,a90 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a64:	fb843783          	ld	a5,-72(s0)
     a68:	00878713          	addi	a4,a5,8
     a6c:	fae43c23          	sd	a4,-72(s0)
     a70:	639c                	ld	a5,0(a5)
     a72:	873e                	mv	a4,a5
     a74:	fcc42783          	lw	a5,-52(s0)
     a78:	4685                	li	a3,1
     a7a:	4629                	li	a2,10
     a7c:	85ba                	mv	a1,a4
     a7e:	853e                	mv	a0,a5
     a80:	d09ff0ef          	jal	788 <printint>
        i += 2;
     a84:	fdc42783          	lw	a5,-36(s0)
     a88:	2789                	addiw	a5,a5,2
     a8a:	fcf42e23          	sw	a5,-36(s0)
     a8e:	ac75                	j	d4a <vprintf+0x452>
      } else if(c0 == 'u'){
     a90:	fd442783          	lw	a5,-44(s0)
     a94:	0007871b          	sext.w	a4,a5
     a98:	07500793          	li	a5,117
     a9c:	02f71563          	bne	a4,a5,ac6 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     aa0:	fb843783          	ld	a5,-72(s0)
     aa4:	00878713          	addi	a4,a5,8
     aa8:	fae43c23          	sd	a4,-72(s0)
     aac:	439c                	lw	a5,0(a5)
     aae:	02079713          	slli	a4,a5,0x20
     ab2:	9301                	srli	a4,a4,0x20
     ab4:	fcc42783          	lw	a5,-52(s0)
     ab8:	4681                	li	a3,0
     aba:	4629                	li	a2,10
     abc:	85ba                	mv	a1,a4
     abe:	853e                	mv	a0,a5
     ac0:	cc9ff0ef          	jal	788 <printint>
     ac4:	a459                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     ac6:	fd442783          	lw	a5,-44(s0)
     aca:	0007871b          	sext.w	a4,a5
     ace:	06c00793          	li	a5,108
     ad2:	04f71063          	bne	a4,a5,b12 <vprintf+0x21a>
     ad6:	fe442783          	lw	a5,-28(s0)
     ada:	0007871b          	sext.w	a4,a5
     ade:	07500793          	li	a5,117
     ae2:	02f71863          	bne	a4,a5,b12 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ae6:	fb843783          	ld	a5,-72(s0)
     aea:	00878713          	addi	a4,a5,8
     aee:	fae43c23          	sd	a4,-72(s0)
     af2:	639c                	ld	a5,0(a5)
     af4:	873e                	mv	a4,a5
     af6:	fcc42783          	lw	a5,-52(s0)
     afa:	4681                	li	a3,0
     afc:	4629                	li	a2,10
     afe:	85ba                	mv	a1,a4
     b00:	853e                	mv	a0,a5
     b02:	c87ff0ef          	jal	788 <printint>
        i += 1;
     b06:	fdc42783          	lw	a5,-36(s0)
     b0a:	2785                	addiw	a5,a5,1
     b0c:	fcf42e23          	sw	a5,-36(s0)
     b10:	ac2d                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     b12:	fd442783          	lw	a5,-44(s0)
     b16:	0007871b          	sext.w	a4,a5
     b1a:	06c00793          	li	a5,108
     b1e:	04f71863          	bne	a4,a5,b6e <vprintf+0x276>
     b22:	fe442783          	lw	a5,-28(s0)
     b26:	0007871b          	sext.w	a4,a5
     b2a:	06c00793          	li	a5,108
     b2e:	04f71063          	bne	a4,a5,b6e <vprintf+0x276>
     b32:	fe042783          	lw	a5,-32(s0)
     b36:	0007871b          	sext.w	a4,a5
     b3a:	07500793          	li	a5,117
     b3e:	02f71863          	bne	a4,a5,b6e <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b42:	fb843783          	ld	a5,-72(s0)
     b46:	00878713          	addi	a4,a5,8
     b4a:	fae43c23          	sd	a4,-72(s0)
     b4e:	639c                	ld	a5,0(a5)
     b50:	873e                	mv	a4,a5
     b52:	fcc42783          	lw	a5,-52(s0)
     b56:	4681                	li	a3,0
     b58:	4629                	li	a2,10
     b5a:	85ba                	mv	a1,a4
     b5c:	853e                	mv	a0,a5
     b5e:	c2bff0ef          	jal	788 <printint>
        i += 2;
     b62:	fdc42783          	lw	a5,-36(s0)
     b66:	2789                	addiw	a5,a5,2
     b68:	fcf42e23          	sw	a5,-36(s0)
     b6c:	aaf9                	j	d4a <vprintf+0x452>
      } else if(c0 == 'x'){
     b6e:	fd442783          	lw	a5,-44(s0)
     b72:	0007871b          	sext.w	a4,a5
     b76:	07800793          	li	a5,120
     b7a:	02f71563          	bne	a4,a5,ba4 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b7e:	fb843783          	ld	a5,-72(s0)
     b82:	00878713          	addi	a4,a5,8
     b86:	fae43c23          	sd	a4,-72(s0)
     b8a:	439c                	lw	a5,0(a5)
     b8c:	02079713          	slli	a4,a5,0x20
     b90:	9301                	srli	a4,a4,0x20
     b92:	fcc42783          	lw	a5,-52(s0)
     b96:	4681                	li	a3,0
     b98:	4641                	li	a2,16
     b9a:	85ba                	mv	a1,a4
     b9c:	853e                	mv	a0,a5
     b9e:	bebff0ef          	jal	788 <printint>
     ba2:	a265                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     ba4:	fd442783          	lw	a5,-44(s0)
     ba8:	0007871b          	sext.w	a4,a5
     bac:	06c00793          	li	a5,108
     bb0:	04f71063          	bne	a4,a5,bf0 <vprintf+0x2f8>
     bb4:	fe442783          	lw	a5,-28(s0)
     bb8:	0007871b          	sext.w	a4,a5
     bbc:	07800793          	li	a5,120
     bc0:	02f71863          	bne	a4,a5,bf0 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     bc4:	fb843783          	ld	a5,-72(s0)
     bc8:	00878713          	addi	a4,a5,8
     bcc:	fae43c23          	sd	a4,-72(s0)
     bd0:	639c                	ld	a5,0(a5)
     bd2:	873e                	mv	a4,a5
     bd4:	fcc42783          	lw	a5,-52(s0)
     bd8:	4681                	li	a3,0
     bda:	4641                	li	a2,16
     bdc:	85ba                	mv	a1,a4
     bde:	853e                	mv	a0,a5
     be0:	ba9ff0ef          	jal	788 <printint>
        i += 1;
     be4:	fdc42783          	lw	a5,-36(s0)
     be8:	2785                	addiw	a5,a5,1
     bea:	fcf42e23          	sw	a5,-36(s0)
     bee:	aab1                	j	d4a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     bf0:	fd442783          	lw	a5,-44(s0)
     bf4:	0007871b          	sext.w	a4,a5
     bf8:	06c00793          	li	a5,108
     bfc:	04f71863          	bne	a4,a5,c4c <vprintf+0x354>
     c00:	fe442783          	lw	a5,-28(s0)
     c04:	0007871b          	sext.w	a4,a5
     c08:	06c00793          	li	a5,108
     c0c:	04f71063          	bne	a4,a5,c4c <vprintf+0x354>
     c10:	fe042783          	lw	a5,-32(s0)
     c14:	0007871b          	sext.w	a4,a5
     c18:	07800793          	li	a5,120
     c1c:	02f71863          	bne	a4,a5,c4c <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c20:	fb843783          	ld	a5,-72(s0)
     c24:	00878713          	addi	a4,a5,8
     c28:	fae43c23          	sd	a4,-72(s0)
     c2c:	639c                	ld	a5,0(a5)
     c2e:	873e                	mv	a4,a5
     c30:	fcc42783          	lw	a5,-52(s0)
     c34:	4681                	li	a3,0
     c36:	4641                	li	a2,16
     c38:	85ba                	mv	a1,a4
     c3a:	853e                	mv	a0,a5
     c3c:	b4dff0ef          	jal	788 <printint>
        i += 2;
     c40:	fdc42783          	lw	a5,-36(s0)
     c44:	2789                	addiw	a5,a5,2
     c46:	fcf42e23          	sw	a5,-36(s0)
     c4a:	a201                	j	d4a <vprintf+0x452>
      } else if(c0 == 'p'){
     c4c:	fd442783          	lw	a5,-44(s0)
     c50:	0007871b          	sext.w	a4,a5
     c54:	07000793          	li	a5,112
     c58:	02f71063          	bne	a4,a5,c78 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c5c:	fb843783          	ld	a5,-72(s0)
     c60:	00878713          	addi	a4,a5,8
     c64:	fae43c23          	sd	a4,-72(s0)
     c68:	6398                	ld	a4,0(a5)
     c6a:	fcc42783          	lw	a5,-52(s0)
     c6e:	85ba                	mv	a1,a4
     c70:	853e                	mv	a0,a5
     c72:	c09ff0ef          	jal	87a <printptr>
     c76:	a8d1                	j	d4a <vprintf+0x452>
      } else if(c0 == 'c'){
     c78:	fd442783          	lw	a5,-44(s0)
     c7c:	0007871b          	sext.w	a4,a5
     c80:	06300793          	li	a5,99
     c84:	02f71263          	bne	a4,a5,ca8 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c88:	fb843783          	ld	a5,-72(s0)
     c8c:	00878713          	addi	a4,a5,8
     c90:	fae43c23          	sd	a4,-72(s0)
     c94:	439c                	lw	a5,0(a5)
     c96:	0ff7f713          	zext.b	a4,a5
     c9a:	fcc42783          	lw	a5,-52(s0)
     c9e:	85ba                	mv	a1,a4
     ca0:	853e                	mv	a0,a5
     ca2:	ab5ff0ef          	jal	756 <putc>
     ca6:	a055                	j	d4a <vprintf+0x452>
      } else if(c0 == 's'){
     ca8:	fd442783          	lw	a5,-44(s0)
     cac:	0007871b          	sext.w	a4,a5
     cb0:	07300793          	li	a5,115
     cb4:	04f71a63          	bne	a4,a5,d08 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     cb8:	fb843783          	ld	a5,-72(s0)
     cbc:	00878713          	addi	a4,a5,8
     cc0:	fae43c23          	sd	a4,-72(s0)
     cc4:	639c                	ld	a5,0(a5)
     cc6:	fef43423          	sd	a5,-24(s0)
     cca:	fe843783          	ld	a5,-24(s0)
     cce:	e79d                	bnez	a5,cfc <vprintf+0x404>
          s = "(null)";
     cd0:	00000797          	auipc	a5,0x0
     cd4:	46878793          	addi	a5,a5,1128 # 1138 <malloc+0x186>
     cd8:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     cdc:	a005                	j	cfc <vprintf+0x404>
          putc(fd, *s);
     cde:	fe843783          	ld	a5,-24(s0)
     ce2:	0007c703          	lbu	a4,0(a5)
     ce6:	fcc42783          	lw	a5,-52(s0)
     cea:	85ba                	mv	a1,a4
     cec:	853e                	mv	a0,a5
     cee:	a69ff0ef          	jal	756 <putc>
        for(; *s; s++)
     cf2:	fe843783          	ld	a5,-24(s0)
     cf6:	0785                	addi	a5,a5,1
     cf8:	fef43423          	sd	a5,-24(s0)
     cfc:	fe843783          	ld	a5,-24(s0)
     d00:	0007c783          	lbu	a5,0(a5)
     d04:	ffe9                	bnez	a5,cde <vprintf+0x3e6>
     d06:	a091                	j	d4a <vprintf+0x452>
      } else if(c0 == '%'){
     d08:	fd442783          	lw	a5,-44(s0)
     d0c:	0007871b          	sext.w	a4,a5
     d10:	02500793          	li	a5,37
     d14:	00f71a63          	bne	a4,a5,d28 <vprintf+0x430>
        putc(fd, '%');
     d18:	fcc42783          	lw	a5,-52(s0)
     d1c:	02500593          	li	a1,37
     d20:	853e                	mv	a0,a5
     d22:	a35ff0ef          	jal	756 <putc>
     d26:	a015                	j	d4a <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d28:	fcc42783          	lw	a5,-52(s0)
     d2c:	02500593          	li	a1,37
     d30:	853e                	mv	a0,a5
     d32:	a25ff0ef          	jal	756 <putc>
        putc(fd, c0);
     d36:	fd442783          	lw	a5,-44(s0)
     d3a:	0ff7f713          	zext.b	a4,a5
     d3e:	fcc42783          	lw	a5,-52(s0)
     d42:	85ba                	mv	a1,a4
     d44:	853e                	mv	a0,a5
     d46:	a11ff0ef          	jal	756 <putc>
      }

      state = 0;
     d4a:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d4e:	fdc42783          	lw	a5,-36(s0)
     d52:	2785                	addiw	a5,a5,1
     d54:	fcf42e23          	sw	a5,-36(s0)
     d58:	fdc42783          	lw	a5,-36(s0)
     d5c:	fc043703          	ld	a4,-64(s0)
     d60:	97ba                	add	a5,a5,a4
     d62:	0007c783          	lbu	a5,0(a5)
     d66:	ba0799e3          	bnez	a5,918 <vprintf+0x20>
    }
  }
}
     d6a:	0001                	nop
     d6c:	0001                	nop
     d6e:	60a6                	ld	ra,72(sp)
     d70:	6406                	ld	s0,64(sp)
     d72:	6161                	addi	sp,sp,80
     d74:	8082                	ret

0000000000000d76 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d76:	7159                	addi	sp,sp,-112
     d78:	fc06                	sd	ra,56(sp)
     d7a:	f822                	sd	s0,48(sp)
     d7c:	0080                	addi	s0,sp,64
     d7e:	fcb43823          	sd	a1,-48(s0)
     d82:	e010                	sd	a2,0(s0)
     d84:	e414                	sd	a3,8(s0)
     d86:	e818                	sd	a4,16(s0)
     d88:	ec1c                	sd	a5,24(s0)
     d8a:	03043023          	sd	a6,32(s0)
     d8e:	03143423          	sd	a7,40(s0)
     d92:	87aa                	mv	a5,a0
     d94:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d98:	03040793          	addi	a5,s0,48
     d9c:	fcf43423          	sd	a5,-56(s0)
     da0:	fc843783          	ld	a5,-56(s0)
     da4:	fd078793          	addi	a5,a5,-48
     da8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     dac:	fe843703          	ld	a4,-24(s0)
     db0:	fdc42783          	lw	a5,-36(s0)
     db4:	863a                	mv	a2,a4
     db6:	fd043583          	ld	a1,-48(s0)
     dba:	853e                	mv	a0,a5
     dbc:	b3dff0ef          	jal	8f8 <vprintf>
}
     dc0:	0001                	nop
     dc2:	70e2                	ld	ra,56(sp)
     dc4:	7442                	ld	s0,48(sp)
     dc6:	6165                	addi	sp,sp,112
     dc8:	8082                	ret

0000000000000dca <printf>:

void
printf(const char *fmt, ...)
{
     dca:	7159                	addi	sp,sp,-112
     dcc:	f406                	sd	ra,40(sp)
     dce:	f022                	sd	s0,32(sp)
     dd0:	1800                	addi	s0,sp,48
     dd2:	fca43c23          	sd	a0,-40(s0)
     dd6:	e40c                	sd	a1,8(s0)
     dd8:	e810                	sd	a2,16(s0)
     dda:	ec14                	sd	a3,24(s0)
     ddc:	f018                	sd	a4,32(s0)
     dde:	f41c                	sd	a5,40(s0)
     de0:	03043823          	sd	a6,48(s0)
     de4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     de8:	04040793          	addi	a5,s0,64
     dec:	fcf43823          	sd	a5,-48(s0)
     df0:	fd043783          	ld	a5,-48(s0)
     df4:	fc878793          	addi	a5,a5,-56
     df8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	863e                	mv	a2,a5
     e02:	fd843583          	ld	a1,-40(s0)
     e06:	4505                	li	a0,1
     e08:	af1ff0ef          	jal	8f8 <vprintf>
}
     e0c:	0001                	nop
     e0e:	70a2                	ld	ra,40(sp)
     e10:	7402                	ld	s0,32(sp)
     e12:	6165                	addi	sp,sp,112
     e14:	8082                	ret

0000000000000e16 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e16:	7179                	addi	sp,sp,-48
     e18:	f406                	sd	ra,40(sp)
     e1a:	f022                	sd	s0,32(sp)
     e1c:	1800                	addi	s0,sp,48
     e1e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e22:	fd843783          	ld	a5,-40(s0)
     e26:	17c1                	addi	a5,a5,-16
     e28:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e2c:	00001797          	auipc	a5,0x1
     e30:	3fc78793          	addi	a5,a5,1020 # 2228 <freep>
     e34:	639c                	ld	a5,0(a5)
     e36:	fef43423          	sd	a5,-24(s0)
     e3a:	a815                	j	e6e <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e3c:	fe843783          	ld	a5,-24(s0)
     e40:	639c                	ld	a5,0(a5)
     e42:	fe843703          	ld	a4,-24(s0)
     e46:	00f76f63          	bltu	a4,a5,e64 <free+0x4e>
     e4a:	fe043703          	ld	a4,-32(s0)
     e4e:	fe843783          	ld	a5,-24(s0)
     e52:	02e7eb63          	bltu	a5,a4,e88 <free+0x72>
     e56:	fe843783          	ld	a5,-24(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	fe043703          	ld	a4,-32(s0)
     e60:	02f76463          	bltu	a4,a5,e88 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	639c                	ld	a5,0(a5)
     e6a:	fef43423          	sd	a5,-24(s0)
     e6e:	fe043703          	ld	a4,-32(s0)
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	fce7f3e3          	bgeu	a5,a4,e3c <free+0x26>
     e7a:	fe843783          	ld	a5,-24(s0)
     e7e:	639c                	ld	a5,0(a5)
     e80:	fe043703          	ld	a4,-32(s0)
     e84:	faf77ce3          	bgeu	a4,a5,e3c <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e88:	fe043783          	ld	a5,-32(s0)
     e8c:	479c                	lw	a5,8(a5)
     e8e:	1782                	slli	a5,a5,0x20
     e90:	9381                	srli	a5,a5,0x20
     e92:	0792                	slli	a5,a5,0x4
     e94:	fe043703          	ld	a4,-32(s0)
     e98:	973e                	add	a4,a4,a5
     e9a:	fe843783          	ld	a5,-24(s0)
     e9e:	639c                	ld	a5,0(a5)
     ea0:	02f71763          	bne	a4,a5,ece <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     ea4:	fe043783          	ld	a5,-32(s0)
     ea8:	4798                	lw	a4,8(a5)
     eaa:	fe843783          	ld	a5,-24(s0)
     eae:	639c                	ld	a5,0(a5)
     eb0:	479c                	lw	a5,8(a5)
     eb2:	9fb9                	addw	a5,a5,a4
     eb4:	0007871b          	sext.w	a4,a5
     eb8:	fe043783          	ld	a5,-32(s0)
     ebc:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ebe:	fe843783          	ld	a5,-24(s0)
     ec2:	639c                	ld	a5,0(a5)
     ec4:	6398                	ld	a4,0(a5)
     ec6:	fe043783          	ld	a5,-32(s0)
     eca:	e398                	sd	a4,0(a5)
     ecc:	a039                	j	eda <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	6398                	ld	a4,0(a5)
     ed4:	fe043783          	ld	a5,-32(s0)
     ed8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	479c                	lw	a5,8(a5)
     ee0:	1782                	slli	a5,a5,0x20
     ee2:	9381                	srli	a5,a5,0x20
     ee4:	0792                	slli	a5,a5,0x4
     ee6:	fe843703          	ld	a4,-24(s0)
     eea:	97ba                	add	a5,a5,a4
     eec:	fe043703          	ld	a4,-32(s0)
     ef0:	02f71563          	bne	a4,a5,f1a <free+0x104>
    p->s.size += bp->s.size;
     ef4:	fe843783          	ld	a5,-24(s0)
     ef8:	4798                	lw	a4,8(a5)
     efa:	fe043783          	ld	a5,-32(s0)
     efe:	479c                	lw	a5,8(a5)
     f00:	9fb9                	addw	a5,a5,a4
     f02:	0007871b          	sext.w	a4,a5
     f06:	fe843783          	ld	a5,-24(s0)
     f0a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f0c:	fe043783          	ld	a5,-32(s0)
     f10:	6398                	ld	a4,0(a5)
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	e398                	sd	a4,0(a5)
     f18:	a031                	j	f24 <free+0x10e>
  } else
    p->s.ptr = bp;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	fe043703          	ld	a4,-32(s0)
     f22:	e398                	sd	a4,0(a5)
  freep = p;
     f24:	00001797          	auipc	a5,0x1
     f28:	30478793          	addi	a5,a5,772 # 2228 <freep>
     f2c:	fe843703          	ld	a4,-24(s0)
     f30:	e398                	sd	a4,0(a5)
}
     f32:	0001                	nop
     f34:	70a2                	ld	ra,40(sp)
     f36:	7402                	ld	s0,32(sp)
     f38:	6145                	addi	sp,sp,48
     f3a:	8082                	ret

0000000000000f3c <morecore>:

static Header*
morecore(uint nu)
{
     f3c:	7179                	addi	sp,sp,-48
     f3e:	f406                	sd	ra,40(sp)
     f40:	f022                	sd	s0,32(sp)
     f42:	1800                	addi	s0,sp,48
     f44:	87aa                	mv	a5,a0
     f46:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f4a:	fdc42783          	lw	a5,-36(s0)
     f4e:	0007871b          	sext.w	a4,a5
     f52:	6785                	lui	a5,0x1
     f54:	00f77563          	bgeu	a4,a5,f5e <morecore+0x22>
    nu = 4096;
     f58:	6785                	lui	a5,0x1
     f5a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f5e:	fdc42783          	lw	a5,-36(s0)
     f62:	0047979b          	slliw	a5,a5,0x4
     f66:	2781                	sext.w	a5,a5
     f68:	853e                	mv	a0,a5
     f6a:	ee8ff0ef          	jal	652 <sbrk>
     f6e:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f72:	fe843703          	ld	a4,-24(s0)
     f76:	57fd                	li	a5,-1
     f78:	00f71463          	bne	a4,a5,f80 <morecore+0x44>
    return 0;
     f7c:	4781                	li	a5,0
     f7e:	a02d                	j	fa8 <morecore+0x6c>
  hp = (Header*)p;
     f80:	fe843783          	ld	a5,-24(s0)
     f84:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f88:	fe043783          	ld	a5,-32(s0)
     f8c:	fdc42703          	lw	a4,-36(s0)
     f90:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f92:	fe043783          	ld	a5,-32(s0)
     f96:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x5e>
     f98:	853e                	mv	a0,a5
     f9a:	e7dff0ef          	jal	e16 <free>
  return freep;
     f9e:	00001797          	auipc	a5,0x1
     fa2:	28a78793          	addi	a5,a5,650 # 2228 <freep>
     fa6:	639c                	ld	a5,0(a5)
}
     fa8:	853e                	mv	a0,a5
     faa:	70a2                	ld	ra,40(sp)
     fac:	7402                	ld	s0,32(sp)
     fae:	6145                	addi	sp,sp,48
     fb0:	8082                	ret

0000000000000fb2 <malloc>:

void*
malloc(uint nbytes)
{
     fb2:	7139                	addi	sp,sp,-64
     fb4:	fc06                	sd	ra,56(sp)
     fb6:	f822                	sd	s0,48(sp)
     fb8:	0080                	addi	s0,sp,64
     fba:	87aa                	mv	a5,a0
     fbc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fc0:	fcc46783          	lwu	a5,-52(s0)
     fc4:	07bd                	addi	a5,a5,15
     fc6:	8391                	srli	a5,a5,0x4
     fc8:	2781                	sext.w	a5,a5
     fca:	2785                	addiw	a5,a5,1
     fcc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     fd0:	00001797          	auipc	a5,0x1
     fd4:	25878793          	addi	a5,a5,600 # 2228 <freep>
     fd8:	639c                	ld	a5,0(a5)
     fda:	fef43023          	sd	a5,-32(s0)
     fde:	fe043783          	ld	a5,-32(s0)
     fe2:	ef95                	bnez	a5,101e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fe4:	00001797          	auipc	a5,0x1
     fe8:	23478793          	addi	a5,a5,564 # 2218 <base>
     fec:	fef43023          	sd	a5,-32(s0)
     ff0:	00001797          	auipc	a5,0x1
     ff4:	23878793          	addi	a5,a5,568 # 2228 <freep>
     ff8:	fe043703          	ld	a4,-32(s0)
     ffc:	e398                	sd	a4,0(a5)
     ffe:	00001797          	auipc	a5,0x1
    1002:	22a78793          	addi	a5,a5,554 # 2228 <freep>
    1006:	6398                	ld	a4,0(a5)
    1008:	00001797          	auipc	a5,0x1
    100c:	21078793          	addi	a5,a5,528 # 2218 <base>
    1010:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1012:	00001797          	auipc	a5,0x1
    1016:	20678793          	addi	a5,a5,518 # 2218 <base>
    101a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    101e:	fe043783          	ld	a5,-32(s0)
    1022:	639c                	ld	a5,0(a5)
    1024:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1028:	fe843783          	ld	a5,-24(s0)
    102c:	479c                	lw	a5,8(a5)
    102e:	fdc42703          	lw	a4,-36(s0)
    1032:	2701                	sext.w	a4,a4
    1034:	06e7e763          	bltu	a5,a4,10a2 <malloc+0xf0>
      if(p->s.size == nunits)
    1038:	fe843783          	ld	a5,-24(s0)
    103c:	479c                	lw	a5,8(a5)
    103e:	fdc42703          	lw	a4,-36(s0)
    1042:	2701                	sext.w	a4,a4
    1044:	00f71963          	bne	a4,a5,1056 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1048:	fe843783          	ld	a5,-24(s0)
    104c:	6398                	ld	a4,0(a5)
    104e:	fe043783          	ld	a5,-32(s0)
    1052:	e398                	sd	a4,0(a5)
    1054:	a825                	j	108c <malloc+0xda>
      else {
        p->s.size -= nunits;
    1056:	fe843783          	ld	a5,-24(s0)
    105a:	479c                	lw	a5,8(a5)
    105c:	fdc42703          	lw	a4,-36(s0)
    1060:	9f99                	subw	a5,a5,a4
    1062:	0007871b          	sext.w	a4,a5
    1066:	fe843783          	ld	a5,-24(s0)
    106a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    106c:	fe843783          	ld	a5,-24(s0)
    1070:	479c                	lw	a5,8(a5)
    1072:	1782                	slli	a5,a5,0x20
    1074:	9381                	srli	a5,a5,0x20
    1076:	0792                	slli	a5,a5,0x4
    1078:	fe843703          	ld	a4,-24(s0)
    107c:	97ba                	add	a5,a5,a4
    107e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1082:	fe843783          	ld	a5,-24(s0)
    1086:	fdc42703          	lw	a4,-36(s0)
    108a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    108c:	00001797          	auipc	a5,0x1
    1090:	19c78793          	addi	a5,a5,412 # 2228 <freep>
    1094:	fe043703          	ld	a4,-32(s0)
    1098:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    109a:	fe843783          	ld	a5,-24(s0)
    109e:	07c1                	addi	a5,a5,16
    10a0:	a081                	j	10e0 <malloc+0x12e>
    }
    if(p == freep)
    10a2:	00001797          	auipc	a5,0x1
    10a6:	18678793          	addi	a5,a5,390 # 2228 <freep>
    10aa:	639c                	ld	a5,0(a5)
    10ac:	fe843703          	ld	a4,-24(s0)
    10b0:	00f71e63          	bne	a4,a5,10cc <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    10b4:	fdc42783          	lw	a5,-36(s0)
    10b8:	853e                	mv	a0,a5
    10ba:	e83ff0ef          	jal	f3c <morecore>
    10be:	fea43423          	sd	a0,-24(s0)
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	e399                	bnez	a5,10cc <malloc+0x11a>
        return 0;
    10c8:	4781                	li	a5,0
    10ca:	a819                	j	10e0 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10cc:	fe843783          	ld	a5,-24(s0)
    10d0:	fef43023          	sd	a5,-32(s0)
    10d4:	fe843783          	ld	a5,-24(s0)
    10d8:	639c                	ld	a5,0(a5)
    10da:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10de:	b7a9                	j	1028 <malloc+0x76>
  }
}
    10e0:	853e                	mv	a0,a5
    10e2:	70e2                	ld	ra,56(sp)
    10e4:	7442                	ld	s0,48(sp)
    10e6:	6121                	addi	sp,sp,64
    10e8:	8082                	ret
