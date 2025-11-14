
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
       e:	a825                	j	46 <cat+0x46>
    if (write(1, buf, n) != n) {
      10:	fec42783          	lw	a5,-20(s0)
      14:	863e                	mv	a2,a5
      16:	00002597          	auipc	a1,0x2
      1a:	00a58593          	addi	a1,a1,10 # 2020 <buf>
      1e:	4505                	li	a0,1
      20:	660000ef          	jal	680 <write>
      24:	87aa                	mv	a5,a0
      26:	873e                	mv	a4,a5
      28:	fec42783          	lw	a5,-20(s0)
      2c:	2781                	sext.w	a5,a5
      2e:	00e78c63          	beq	a5,a4,46 <cat+0x46>
      fprintf(2, "cat: write error\n");
      32:	00001597          	auipc	a1,0x1
      36:	06e58593          	addi	a1,a1,110 # 10a0 <malloc+0x13c>
      3a:	4509                	li	a0,2
      3c:	4ed000ef          	jal	d28 <fprintf>
      exit(1);
      40:	4505                	li	a0,1
      42:	61e000ef          	jal	660 <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
      46:	fdc42783          	lw	a5,-36(s0)
      4a:	20000613          	li	a2,512
      4e:	00002597          	auipc	a1,0x2
      52:	fd258593          	addi	a1,a1,-46 # 2020 <buf>
      56:	853e                	mv	a0,a5
      58:	620000ef          	jal	678 <read>
      5c:	87aa                	mv	a5,a0
      5e:	fef42623          	sw	a5,-20(s0)
      62:	fec42783          	lw	a5,-20(s0)
      66:	2781                	sext.w	a5,a5
      68:	faf044e3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
      6c:	fec42783          	lw	a5,-20(s0)
      70:	2781                	sext.w	a5,a5
      72:	0007dc63          	bgez	a5,8a <cat+0x8a>
    fprintf(2, "cat: read error\n");
      76:	00001597          	auipc	a1,0x1
      7a:	04258593          	addi	a1,a1,66 # 10b8 <malloc+0x154>
      7e:	4509                	li	a0,2
      80:	4a9000ef          	jal	d28 <fprintf>
    exit(1);
      84:	4505                	li	a0,1
      86:	5da000ef          	jal	660 <exit>
  }
}
      8a:	0001                	nop
      8c:	70a2                	ld	ra,40(sp)
      8e:	7402                	ld	s0,32(sp)
      90:	6145                	addi	sp,sp,48
      92:	8082                	ret

0000000000000094 <main>:

int
main(int argc, char *argv[])
{
      94:	7179                	addi	sp,sp,-48
      96:	f406                	sd	ra,40(sp)
      98:	f022                	sd	s0,32(sp)
      9a:	1800                	addi	s0,sp,48
      9c:	87aa                	mv	a5,a0
      9e:	fcb43823          	sd	a1,-48(s0)
      a2:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
      a6:	fdc42783          	lw	a5,-36(s0)
      aa:	0007871b          	sext.w	a4,a5
      ae:	4785                	li	a5,1
      b0:	00e7c863          	blt	a5,a4,c0 <main+0x2c>
    cat(0);
      b4:	4501                	li	a0,0
      b6:	f4bff0ef          	jal	0 <cat>
    exit(0);
      ba:	4501                	li	a0,0
      bc:	5a4000ef          	jal	660 <exit>
  }

  for(i = 1; i < argc; i++){
      c0:	4785                	li	a5,1
      c2:	fef42623          	sw	a5,-20(s0)
      c6:	a0ad                	j	130 <main+0x9c>
    if((fd = open(argv[i], O_RDONLY)) < 0){
      c8:	fec42783          	lw	a5,-20(s0)
      cc:	078e                	slli	a5,a5,0x3
      ce:	fd043703          	ld	a4,-48(s0)
      d2:	97ba                	add	a5,a5,a4
      d4:	639c                	ld	a5,0(a5)
      d6:	4581                	li	a1,0
      d8:	853e                	mv	a0,a5
      da:	5c6000ef          	jal	6a0 <open>
      de:	87aa                	mv	a5,a0
      e0:	fef42423          	sw	a5,-24(s0)
      e4:	fe842783          	lw	a5,-24(s0)
      e8:	2781                	sext.w	a5,a5
      ea:	0207d463          	bgez	a5,112 <main+0x7e>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      ee:	fec42783          	lw	a5,-20(s0)
      f2:	078e                	slli	a5,a5,0x3
      f4:	fd043703          	ld	a4,-48(s0)
      f8:	97ba                	add	a5,a5,a4
      fa:	639c                	ld	a5,0(a5)
      fc:	863e                	mv	a2,a5
      fe:	00001597          	auipc	a1,0x1
     102:	fd258593          	addi	a1,a1,-46 # 10d0 <malloc+0x16c>
     106:	4509                	li	a0,2
     108:	421000ef          	jal	d28 <fprintf>
      exit(1);
     10c:	4505                	li	a0,1
     10e:	552000ef          	jal	660 <exit>
    }
    cat(fd);
     112:	fe842783          	lw	a5,-24(s0)
     116:	853e                	mv	a0,a5
     118:	ee9ff0ef          	jal	0 <cat>
    close(fd);
     11c:	fe842783          	lw	a5,-24(s0)
     120:	853e                	mv	a0,a5
     122:	566000ef          	jal	688 <close>
  for(i = 1; i < argc; i++){
     126:	fec42783          	lw	a5,-20(s0)
     12a:	2785                	addiw	a5,a5,1
     12c:	fef42623          	sw	a5,-20(s0)
     130:	fec42783          	lw	a5,-20(s0)
     134:	873e                	mv	a4,a5
     136:	fdc42783          	lw	a5,-36(s0)
     13a:	2701                	sext.w	a4,a4
     13c:	2781                	sext.w	a5,a5
     13e:	f8f745e3          	blt	a4,a5,c8 <main+0x34>
  }
  exit(0);
     142:	4501                	li	a0,0
     144:	51c000ef          	jal	660 <exit>

0000000000000148 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     148:	7179                	addi	sp,sp,-48
     14a:	f406                	sd	ra,40(sp)
     14c:	f022                	sd	s0,32(sp)
     14e:	1800                	addi	s0,sp,48
     150:	87aa                	mv	a5,a0
     152:	fcb43823          	sd	a1,-48(s0)
     156:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     15a:	fdc42783          	lw	a5,-36(s0)
     15e:	fd043583          	ld	a1,-48(s0)
     162:	853e                	mv	a0,a5
     164:	f31ff0ef          	jal	94 <main>
     168:	87aa                	mv	a5,a0
     16a:	fef42623          	sw	a5,-20(s0)
  exit(r);
     16e:	fec42783          	lw	a5,-20(s0)
     172:	853e                	mv	a0,a5
     174:	4ec000ef          	jal	660 <exit>

0000000000000178 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     178:	7179                	addi	sp,sp,-48
     17a:	f406                	sd	ra,40(sp)
     17c:	f022                	sd	s0,32(sp)
     17e:	1800                	addi	s0,sp,48
     180:	fca43c23          	sd	a0,-40(s0)
     184:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     188:	fd843783          	ld	a5,-40(s0)
     18c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     190:	0001                	nop
     192:	fd043703          	ld	a4,-48(s0)
     196:	00170793          	addi	a5,a4,1
     19a:	fcf43823          	sd	a5,-48(s0)
     19e:	fd843783          	ld	a5,-40(s0)
     1a2:	00178693          	addi	a3,a5,1
     1a6:	fcd43c23          	sd	a3,-40(s0)
     1aa:	00074703          	lbu	a4,0(a4)
     1ae:	00e78023          	sb	a4,0(a5)
     1b2:	0007c783          	lbu	a5,0(a5)
     1b6:	fff1                	bnez	a5,192 <strcpy+0x1a>
    ;
  return os;
     1b8:	fe843783          	ld	a5,-24(s0)
}
     1bc:	853e                	mv	a0,a5
     1be:	70a2                	ld	ra,40(sp)
     1c0:	7402                	ld	s0,32(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret

00000000000001c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1c6:	1101                	addi	sp,sp,-32
     1c8:	ec06                	sd	ra,24(sp)
     1ca:	e822                	sd	s0,16(sp)
     1cc:	1000                	addi	s0,sp,32
     1ce:	fea43423          	sd	a0,-24(s0)
     1d2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1d6:	a819                	j	1ec <strcmp+0x26>
    p++, q++;
     1d8:	fe843783          	ld	a5,-24(s0)
     1dc:	0785                	addi	a5,a5,1
     1de:	fef43423          	sd	a5,-24(s0)
     1e2:	fe043783          	ld	a5,-32(s0)
     1e6:	0785                	addi	a5,a5,1
     1e8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1ec:	fe843783          	ld	a5,-24(s0)
     1f0:	0007c783          	lbu	a5,0(a5)
     1f4:	cb99                	beqz	a5,20a <strcmp+0x44>
     1f6:	fe843783          	ld	a5,-24(s0)
     1fa:	0007c703          	lbu	a4,0(a5)
     1fe:	fe043783          	ld	a5,-32(s0)
     202:	0007c783          	lbu	a5,0(a5)
     206:	fcf709e3          	beq	a4,a5,1d8 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     20a:	fe843783          	ld	a5,-24(s0)
     20e:	0007c783          	lbu	a5,0(a5)
     212:	0007871b          	sext.w	a4,a5
     216:	fe043783          	ld	a5,-32(s0)
     21a:	0007c783          	lbu	a5,0(a5)
     21e:	2781                	sext.w	a5,a5
     220:	40f707bb          	subw	a5,a4,a5
     224:	2781                	sext.w	a5,a5
}
     226:	853e                	mv	a0,a5
     228:	60e2                	ld	ra,24(sp)
     22a:	6442                	ld	s0,16(sp)
     22c:	6105                	addi	sp,sp,32
     22e:	8082                	ret

0000000000000230 <strlen>:

uint
strlen(const char *s)
{
     230:	7179                	addi	sp,sp,-48
     232:	f406                	sd	ra,40(sp)
     234:	f022                	sd	s0,32(sp)
     236:	1800                	addi	s0,sp,48
     238:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     23c:	fe042623          	sw	zero,-20(s0)
     240:	a031                	j	24c <strlen+0x1c>
     242:	fec42783          	lw	a5,-20(s0)
     246:	2785                	addiw	a5,a5,1
     248:	fef42623          	sw	a5,-20(s0)
     24c:	fec42783          	lw	a5,-20(s0)
     250:	fd843703          	ld	a4,-40(s0)
     254:	97ba                	add	a5,a5,a4
     256:	0007c783          	lbu	a5,0(a5)
     25a:	f7e5                	bnez	a5,242 <strlen+0x12>
    ;
  return n;
     25c:	fec42783          	lw	a5,-20(s0)
}
     260:	853e                	mv	a0,a5
     262:	70a2                	ld	ra,40(sp)
     264:	7402                	ld	s0,32(sp)
     266:	6145                	addi	sp,sp,48
     268:	8082                	ret

000000000000026a <memset>:

void*
memset(void *dst, int c, uint n)
{
     26a:	7179                	addi	sp,sp,-48
     26c:	f406                	sd	ra,40(sp)
     26e:	f022                	sd	s0,32(sp)
     270:	1800                	addi	s0,sp,48
     272:	fca43c23          	sd	a0,-40(s0)
     276:	87ae                	mv	a5,a1
     278:	8732                	mv	a4,a2
     27a:	fcf42a23          	sw	a5,-44(s0)
     27e:	87ba                	mv	a5,a4
     280:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     284:	fd843783          	ld	a5,-40(s0)
     288:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     28c:	fe042623          	sw	zero,-20(s0)
     290:	a00d                	j	2b2 <memset+0x48>
    cdst[i] = c;
     292:	fec42783          	lw	a5,-20(s0)
     296:	fe043703          	ld	a4,-32(s0)
     29a:	97ba                	add	a5,a5,a4
     29c:	fd442703          	lw	a4,-44(s0)
     2a0:	0ff77713          	zext.b	a4,a4
     2a4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2a8:	fec42783          	lw	a5,-20(s0)
     2ac:	2785                	addiw	a5,a5,1
     2ae:	fef42623          	sw	a5,-20(s0)
     2b2:	fec42783          	lw	a5,-20(s0)
     2b6:	fd042703          	lw	a4,-48(s0)
     2ba:	2701                	sext.w	a4,a4
     2bc:	fce7ebe3          	bltu	a5,a4,292 <memset+0x28>
  }
  return dst;
     2c0:	fd843783          	ld	a5,-40(s0)
}
     2c4:	853e                	mv	a0,a5
     2c6:	70a2                	ld	ra,40(sp)
     2c8:	7402                	ld	s0,32(sp)
     2ca:	6145                	addi	sp,sp,48
     2cc:	8082                	ret

00000000000002ce <strchr>:

char*
strchr(const char *s, char c)
{
     2ce:	1101                	addi	sp,sp,-32
     2d0:	ec06                	sd	ra,24(sp)
     2d2:	e822                	sd	s0,16(sp)
     2d4:	1000                	addi	s0,sp,32
     2d6:	fea43423          	sd	a0,-24(s0)
     2da:	87ae                	mv	a5,a1
     2dc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2e0:	a01d                	j	306 <strchr+0x38>
    if(*s == c)
     2e2:	fe843783          	ld	a5,-24(s0)
     2e6:	0007c703          	lbu	a4,0(a5)
     2ea:	fe744783          	lbu	a5,-25(s0)
     2ee:	0ff7f793          	zext.b	a5,a5
     2f2:	00e79563          	bne	a5,a4,2fc <strchr+0x2e>
      return (char*)s;
     2f6:	fe843783          	ld	a5,-24(s0)
     2fa:	a821                	j	312 <strchr+0x44>
  for(; *s; s++)
     2fc:	fe843783          	ld	a5,-24(s0)
     300:	0785                	addi	a5,a5,1
     302:	fef43423          	sd	a5,-24(s0)
     306:	fe843783          	ld	a5,-24(s0)
     30a:	0007c783          	lbu	a5,0(a5)
     30e:	fbf1                	bnez	a5,2e2 <strchr+0x14>
  return 0;
     310:	4781                	li	a5,0
}
     312:	853e                	mv	a0,a5
     314:	60e2                	ld	ra,24(sp)
     316:	6442                	ld	s0,16(sp)
     318:	6105                	addi	sp,sp,32
     31a:	8082                	ret

000000000000031c <gets>:

char*
gets(char *buf, int max)
{
     31c:	7179                	addi	sp,sp,-48
     31e:	f406                	sd	ra,40(sp)
     320:	f022                	sd	s0,32(sp)
     322:	1800                	addi	s0,sp,48
     324:	fca43c23          	sd	a0,-40(s0)
     328:	87ae                	mv	a5,a1
     32a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     32e:	fe042623          	sw	zero,-20(s0)
     332:	a891                	j	386 <gets+0x6a>
    cc = read(0, &c, 1);
     334:	fe740793          	addi	a5,s0,-25
     338:	4605                	li	a2,1
     33a:	85be                	mv	a1,a5
     33c:	4501                	li	a0,0
     33e:	33a000ef          	jal	678 <read>
     342:	87aa                	mv	a5,a0
     344:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     348:	fe842783          	lw	a5,-24(s0)
     34c:	2781                	sext.w	a5,a5
     34e:	04f05663          	blez	a5,39a <gets+0x7e>
      break;
    buf[i++] = c;
     352:	fec42783          	lw	a5,-20(s0)
     356:	0017871b          	addiw	a4,a5,1
     35a:	fee42623          	sw	a4,-20(s0)
     35e:	873e                	mv	a4,a5
     360:	fd843783          	ld	a5,-40(s0)
     364:	97ba                	add	a5,a5,a4
     366:	fe744703          	lbu	a4,-25(s0)
     36a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     36e:	fe744783          	lbu	a5,-25(s0)
     372:	873e                	mv	a4,a5
     374:	47a9                	li	a5,10
     376:	02f70363          	beq	a4,a5,39c <gets+0x80>
     37a:	fe744783          	lbu	a5,-25(s0)
     37e:	873e                	mv	a4,a5
     380:	47b5                	li	a5,13
     382:	00f70d63          	beq	a4,a5,39c <gets+0x80>
  for(i=0; i+1 < max; ){
     386:	fec42783          	lw	a5,-20(s0)
     38a:	2785                	addiw	a5,a5,1
     38c:	2781                	sext.w	a5,a5
     38e:	fd442703          	lw	a4,-44(s0)
     392:	2701                	sext.w	a4,a4
     394:	fae7c0e3          	blt	a5,a4,334 <gets+0x18>
     398:	a011                	j	39c <gets+0x80>
      break;
     39a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     39c:	fec42783          	lw	a5,-20(s0)
     3a0:	fd843703          	ld	a4,-40(s0)
     3a4:	97ba                	add	a5,a5,a4
     3a6:	00078023          	sb	zero,0(a5)
  return buf;
     3aa:	fd843783          	ld	a5,-40(s0)
}
     3ae:	853e                	mv	a0,a5
     3b0:	70a2                	ld	ra,40(sp)
     3b2:	7402                	ld	s0,32(sp)
     3b4:	6145                	addi	sp,sp,48
     3b6:	8082                	ret

00000000000003b8 <stat>:

int
stat(const char *n, struct stat *st)
{
     3b8:	7179                	addi	sp,sp,-48
     3ba:	f406                	sd	ra,40(sp)
     3bc:	f022                	sd	s0,32(sp)
     3be:	1800                	addi	s0,sp,48
     3c0:	fca43c23          	sd	a0,-40(s0)
     3c4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3c8:	4581                	li	a1,0
     3ca:	fd843503          	ld	a0,-40(s0)
     3ce:	2d2000ef          	jal	6a0 <open>
     3d2:	87aa                	mv	a5,a0
     3d4:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3d8:	fec42783          	lw	a5,-20(s0)
     3dc:	2781                	sext.w	a5,a5
     3de:	0007d463          	bgez	a5,3e6 <stat+0x2e>
    return -1;
     3e2:	57fd                	li	a5,-1
     3e4:	a015                	j	408 <stat+0x50>
  r = fstat(fd, st);
     3e6:	fec42783          	lw	a5,-20(s0)
     3ea:	fd043583          	ld	a1,-48(s0)
     3ee:	853e                	mv	a0,a5
     3f0:	2c8000ef          	jal	6b8 <fstat>
     3f4:	87aa                	mv	a5,a0
     3f6:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3fa:	fec42783          	lw	a5,-20(s0)
     3fe:	853e                	mv	a0,a5
     400:	288000ef          	jal	688 <close>
  return r;
     404:	fe842783          	lw	a5,-24(s0)
}
     408:	853e                	mv	a0,a5
     40a:	70a2                	ld	ra,40(sp)
     40c:	7402                	ld	s0,32(sp)
     40e:	6145                	addi	sp,sp,48
     410:	8082                	ret

0000000000000412 <atoi>:

int
atoi(const char *s)
{
     412:	7179                	addi	sp,sp,-48
     414:	f406                	sd	ra,40(sp)
     416:	f022                	sd	s0,32(sp)
     418:	1800                	addi	s0,sp,48
     41a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     41e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     422:	a81d                	j	458 <atoi+0x46>
    n = n*10 + *s++ - '0';
     424:	fec42783          	lw	a5,-20(s0)
     428:	873e                	mv	a4,a5
     42a:	87ba                	mv	a5,a4
     42c:	0027979b          	slliw	a5,a5,0x2
     430:	9fb9                	addw	a5,a5,a4
     432:	0017979b          	slliw	a5,a5,0x1
     436:	0007871b          	sext.w	a4,a5
     43a:	fd843783          	ld	a5,-40(s0)
     43e:	00178693          	addi	a3,a5,1
     442:	fcd43c23          	sd	a3,-40(s0)
     446:	0007c783          	lbu	a5,0(a5)
     44a:	2781                	sext.w	a5,a5
     44c:	9fb9                	addw	a5,a5,a4
     44e:	2781                	sext.w	a5,a5
     450:	fd07879b          	addiw	a5,a5,-48
     454:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     458:	fd843783          	ld	a5,-40(s0)
     45c:	0007c783          	lbu	a5,0(a5)
     460:	873e                	mv	a4,a5
     462:	02f00793          	li	a5,47
     466:	00e7fb63          	bgeu	a5,a4,47c <atoi+0x6a>
     46a:	fd843783          	ld	a5,-40(s0)
     46e:	0007c783          	lbu	a5,0(a5)
     472:	873e                	mv	a4,a5
     474:	03900793          	li	a5,57
     478:	fae7f6e3          	bgeu	a5,a4,424 <atoi+0x12>
  return n;
     47c:	fec42783          	lw	a5,-20(s0)
}
     480:	853e                	mv	a0,a5
     482:	70a2                	ld	ra,40(sp)
     484:	7402                	ld	s0,32(sp)
     486:	6145                	addi	sp,sp,48
     488:	8082                	ret

000000000000048a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     48a:	7139                	addi	sp,sp,-64
     48c:	fc06                	sd	ra,56(sp)
     48e:	f822                	sd	s0,48(sp)
     490:	0080                	addi	s0,sp,64
     492:	fca43c23          	sd	a0,-40(s0)
     496:	fcb43823          	sd	a1,-48(s0)
     49a:	87b2                	mv	a5,a2
     49c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4a0:	fd843783          	ld	a5,-40(s0)
     4a4:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4a8:	fd043783          	ld	a5,-48(s0)
     4ac:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4b0:	fe043703          	ld	a4,-32(s0)
     4b4:	fe843783          	ld	a5,-24(s0)
     4b8:	02e7fc63          	bgeu	a5,a4,4f0 <memmove+0x66>
    while(n-- > 0)
     4bc:	a00d                	j	4de <memmove+0x54>
      *dst++ = *src++;
     4be:	fe043703          	ld	a4,-32(s0)
     4c2:	00170793          	addi	a5,a4,1
     4c6:	fef43023          	sd	a5,-32(s0)
     4ca:	fe843783          	ld	a5,-24(s0)
     4ce:	00178693          	addi	a3,a5,1
     4d2:	fed43423          	sd	a3,-24(s0)
     4d6:	00074703          	lbu	a4,0(a4)
     4da:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4de:	fcc42783          	lw	a5,-52(s0)
     4e2:	fff7871b          	addiw	a4,a5,-1
     4e6:	fce42623          	sw	a4,-52(s0)
     4ea:	fcf04ae3          	bgtz	a5,4be <memmove+0x34>
     4ee:	a891                	j	542 <memmove+0xb8>
  } else {
    dst += n;
     4f0:	fcc42783          	lw	a5,-52(s0)
     4f4:	fe843703          	ld	a4,-24(s0)
     4f8:	97ba                	add	a5,a5,a4
     4fa:	fef43423          	sd	a5,-24(s0)
    src += n;
     4fe:	fcc42783          	lw	a5,-52(s0)
     502:	fe043703          	ld	a4,-32(s0)
     506:	97ba                	add	a5,a5,a4
     508:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     50c:	a01d                	j	532 <memmove+0xa8>
      *--dst = *--src;
     50e:	fe043783          	ld	a5,-32(s0)
     512:	17fd                	addi	a5,a5,-1
     514:	fef43023          	sd	a5,-32(s0)
     518:	fe843783          	ld	a5,-24(s0)
     51c:	17fd                	addi	a5,a5,-1
     51e:	fef43423          	sd	a5,-24(s0)
     522:	fe043783          	ld	a5,-32(s0)
     526:	0007c703          	lbu	a4,0(a5)
     52a:	fe843783          	ld	a5,-24(s0)
     52e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     532:	fcc42783          	lw	a5,-52(s0)
     536:	fff7871b          	addiw	a4,a5,-1
     53a:	fce42623          	sw	a4,-52(s0)
     53e:	fcf048e3          	bgtz	a5,50e <memmove+0x84>
  }
  return vdst;
     542:	fd843783          	ld	a5,-40(s0)
}
     546:	853e                	mv	a0,a5
     548:	70e2                	ld	ra,56(sp)
     54a:	7442                	ld	s0,48(sp)
     54c:	6121                	addi	sp,sp,64
     54e:	8082                	ret

0000000000000550 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     550:	7139                	addi	sp,sp,-64
     552:	fc06                	sd	ra,56(sp)
     554:	f822                	sd	s0,48(sp)
     556:	0080                	addi	s0,sp,64
     558:	fca43c23          	sd	a0,-40(s0)
     55c:	fcb43823          	sd	a1,-48(s0)
     560:	87b2                	mv	a5,a2
     562:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     566:	fd843783          	ld	a5,-40(s0)
     56a:	fef43423          	sd	a5,-24(s0)
     56e:	fd043783          	ld	a5,-48(s0)
     572:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     576:	a0a1                	j	5be <memcmp+0x6e>
    if (*p1 != *p2) {
     578:	fe843783          	ld	a5,-24(s0)
     57c:	0007c703          	lbu	a4,0(a5)
     580:	fe043783          	ld	a5,-32(s0)
     584:	0007c783          	lbu	a5,0(a5)
     588:	02f70163          	beq	a4,a5,5aa <memcmp+0x5a>
      return *p1 - *p2;
     58c:	fe843783          	ld	a5,-24(s0)
     590:	0007c783          	lbu	a5,0(a5)
     594:	0007871b          	sext.w	a4,a5
     598:	fe043783          	ld	a5,-32(s0)
     59c:	0007c783          	lbu	a5,0(a5)
     5a0:	2781                	sext.w	a5,a5
     5a2:	40f707bb          	subw	a5,a4,a5
     5a6:	2781                	sext.w	a5,a5
     5a8:	a01d                	j	5ce <memcmp+0x7e>
    }
    p1++;
     5aa:	fe843783          	ld	a5,-24(s0)
     5ae:	0785                	addi	a5,a5,1
     5b0:	fef43423          	sd	a5,-24(s0)
    p2++;
     5b4:	fe043783          	ld	a5,-32(s0)
     5b8:	0785                	addi	a5,a5,1
     5ba:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5be:	fcc42783          	lw	a5,-52(s0)
     5c2:	fff7871b          	addiw	a4,a5,-1
     5c6:	fce42623          	sw	a4,-52(s0)
     5ca:	f7dd                	bnez	a5,578 <memcmp+0x28>
  }
  return 0;
     5cc:	4781                	li	a5,0
}
     5ce:	853e                	mv	a0,a5
     5d0:	70e2                	ld	ra,56(sp)
     5d2:	7442                	ld	s0,48(sp)
     5d4:	6121                	addi	sp,sp,64
     5d6:	8082                	ret

00000000000005d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5d8:	7179                	addi	sp,sp,-48
     5da:	f406                	sd	ra,40(sp)
     5dc:	f022                	sd	s0,32(sp)
     5de:	1800                	addi	s0,sp,48
     5e0:	fea43423          	sd	a0,-24(s0)
     5e4:	feb43023          	sd	a1,-32(s0)
     5e8:	87b2                	mv	a5,a2
     5ea:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5ee:	fdc42783          	lw	a5,-36(s0)
     5f2:	863e                	mv	a2,a5
     5f4:	fe043583          	ld	a1,-32(s0)
     5f8:	fe843503          	ld	a0,-24(s0)
     5fc:	e8fff0ef          	jal	48a <memmove>
     600:	87aa                	mv	a5,a0
}
     602:	853e                	mv	a0,a5
     604:	70a2                	ld	ra,40(sp)
     606:	7402                	ld	s0,32(sp)
     608:	6145                	addi	sp,sp,48
     60a:	8082                	ret

000000000000060c <sbrk>:

char *
sbrk(int n) {
     60c:	1101                	addi	sp,sp,-32
     60e:	ec06                	sd	ra,24(sp)
     610:	e822                	sd	s0,16(sp)
     612:	1000                	addi	s0,sp,32
     614:	87aa                	mv	a5,a0
     616:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     61a:	fec42783          	lw	a5,-20(s0)
     61e:	4585                	li	a1,1
     620:	853e                	mv	a0,a5
     622:	0c6000ef          	jal	6e8 <sys_sbrk>
     626:	87aa                	mv	a5,a0
}
     628:	853e                	mv	a0,a5
     62a:	60e2                	ld	ra,24(sp)
     62c:	6442                	ld	s0,16(sp)
     62e:	6105                	addi	sp,sp,32
     630:	8082                	ret

0000000000000632 <sbrklazy>:

char *
sbrklazy(int n) {
     632:	1101                	addi	sp,sp,-32
     634:	ec06                	sd	ra,24(sp)
     636:	e822                	sd	s0,16(sp)
     638:	1000                	addi	s0,sp,32
     63a:	87aa                	mv	a5,a0
     63c:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     640:	fec42783          	lw	a5,-20(s0)
     644:	4589                	li	a1,2
     646:	853e                	mv	a0,a5
     648:	0a0000ef          	jal	6e8 <sys_sbrk>
     64c:	87aa                	mv	a5,a0
}
     64e:	853e                	mv	a0,a5
     650:	60e2                	ld	ra,24(sp)
     652:	6442                	ld	s0,16(sp)
     654:	6105                	addi	sp,sp,32
     656:	8082                	ret

0000000000000658 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     658:	4885                	li	a7,1
 ecall
     65a:	00000073          	ecall
 ret
     65e:	8082                	ret

0000000000000660 <exit>:
.global exit
exit:
 li a7, SYS_exit
     660:	4889                	li	a7,2
 ecall
     662:	00000073          	ecall
 ret
     666:	8082                	ret

0000000000000668 <wait>:
.global wait
wait:
 li a7, SYS_wait
     668:	488d                	li	a7,3
 ecall
     66a:	00000073          	ecall
 ret
     66e:	8082                	ret

0000000000000670 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     670:	4891                	li	a7,4
 ecall
     672:	00000073          	ecall
 ret
     676:	8082                	ret

0000000000000678 <read>:
.global read
read:
 li a7, SYS_read
     678:	4895                	li	a7,5
 ecall
     67a:	00000073          	ecall
 ret
     67e:	8082                	ret

0000000000000680 <write>:
.global write
write:
 li a7, SYS_write
     680:	48c1                	li	a7,16
 ecall
     682:	00000073          	ecall
 ret
     686:	8082                	ret

0000000000000688 <close>:
.global close
close:
 li a7, SYS_close
     688:	48d5                	li	a7,21
 ecall
     68a:	00000073          	ecall
 ret
     68e:	8082                	ret

0000000000000690 <kill>:
.global kill
kill:
 li a7, SYS_kill
     690:	4899                	li	a7,6
 ecall
     692:	00000073          	ecall
 ret
     696:	8082                	ret

0000000000000698 <exec>:
.global exec
exec:
 li a7, SYS_exec
     698:	489d                	li	a7,7
 ecall
     69a:	00000073          	ecall
 ret
     69e:	8082                	ret

00000000000006a0 <open>:
.global open
open:
 li a7, SYS_open
     6a0:	48bd                	li	a7,15
 ecall
     6a2:	00000073          	ecall
 ret
     6a6:	8082                	ret

00000000000006a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6a8:	48c5                	li	a7,17
 ecall
     6aa:	00000073          	ecall
 ret
     6ae:	8082                	ret

00000000000006b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     6b0:	48c9                	li	a7,18
 ecall
     6b2:	00000073          	ecall
 ret
     6b6:	8082                	ret

00000000000006b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     6b8:	48a1                	li	a7,8
 ecall
     6ba:	00000073          	ecall
 ret
     6be:	8082                	ret

00000000000006c0 <link>:
.global link
link:
 li a7, SYS_link
     6c0:	48cd                	li	a7,19
 ecall
     6c2:	00000073          	ecall
 ret
     6c6:	8082                	ret

00000000000006c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     6c8:	48d1                	li	a7,20
 ecall
     6ca:	00000073          	ecall
 ret
     6ce:	8082                	ret

00000000000006d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     6d0:	48a5                	li	a7,9
 ecall
     6d2:	00000073          	ecall
 ret
     6d6:	8082                	ret

00000000000006d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
     6d8:	48a9                	li	a7,10
 ecall
     6da:	00000073          	ecall
 ret
     6de:	8082                	ret

00000000000006e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     6e0:	48ad                	li	a7,11
 ecall
     6e2:	00000073          	ecall
 ret
     6e6:	8082                	ret

00000000000006e8 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     6e8:	48b1                	li	a7,12
 ecall
     6ea:	00000073          	ecall
 ret
     6ee:	8082                	ret

00000000000006f0 <pause>:
.global pause
pause:
 li a7, SYS_pause
     6f0:	48b5                	li	a7,13
 ecall
     6f2:	00000073          	ecall
 ret
     6f6:	8082                	ret

00000000000006f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6f8:	48b9                	li	a7,14
 ecall
     6fa:	00000073          	ecall
 ret
     6fe:	8082                	ret

0000000000000700 <top>:
.global top
top:
 li a7, SYS_top
     700:	48d9                	li	a7,22
 ecall
     702:	00000073          	ecall
 ret
     706:	8082                	ret

0000000000000708 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     708:	1101                	addi	sp,sp,-32
     70a:	ec06                	sd	ra,24(sp)
     70c:	e822                	sd	s0,16(sp)
     70e:	1000                	addi	s0,sp,32
     710:	87aa                	mv	a5,a0
     712:	872e                	mv	a4,a1
     714:	fef42623          	sw	a5,-20(s0)
     718:	87ba                	mv	a5,a4
     71a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     71e:	feb40713          	addi	a4,s0,-21
     722:	fec42783          	lw	a5,-20(s0)
     726:	4605                	li	a2,1
     728:	85ba                	mv	a1,a4
     72a:	853e                	mv	a0,a5
     72c:	f55ff0ef          	jal	680 <write>
}
     730:	0001                	nop
     732:	60e2                	ld	ra,24(sp)
     734:	6442                	ld	s0,16(sp)
     736:	6105                	addi	sp,sp,32
     738:	8082                	ret

000000000000073a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     73a:	711d                	addi	sp,sp,-96
     73c:	ec86                	sd	ra,88(sp)
     73e:	e8a2                	sd	s0,80(sp)
     740:	1080                	addi	s0,sp,96
     742:	87aa                	mv	a5,a0
     744:	fab43823          	sd	a1,-80(s0)
     748:	8736                	mv	a4,a3
     74a:	faf42e23          	sw	a5,-68(s0)
     74e:	87b2                	mv	a5,a2
     750:	faf42c23          	sw	a5,-72(s0)
     754:	87ba                	mv	a5,a4
     756:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     75a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     75e:	fac42783          	lw	a5,-84(s0)
     762:	2781                	sext.w	a5,a5
     764:	cf99                	beqz	a5,782 <printint+0x48>
     766:	fb043783          	ld	a5,-80(s0)
     76a:	0007dc63          	bgez	a5,782 <printint+0x48>
    neg = 1;
     76e:	4785                	li	a5,1
     770:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     774:	fb043783          	ld	a5,-80(s0)
     778:	40f007b3          	neg	a5,a5
     77c:	fef43023          	sd	a5,-32(s0)
     780:	a029                	j	78a <printint+0x50>
  } else {
    x = xx;
     782:	fb043783          	ld	a5,-80(s0)
     786:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     78a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     78e:	fb842783          	lw	a5,-72(s0)
     792:	fe043703          	ld	a4,-32(s0)
     796:	02f77733          	remu	a4,a4,a5
     79a:	fec42783          	lw	a5,-20(s0)
     79e:	0017869b          	addiw	a3,a5,1
     7a2:	fed42623          	sw	a3,-20(s0)
     7a6:	00002697          	auipc	a3,0x2
     7aa:	85a68693          	addi	a3,a3,-1958 # 2000 <digits>
     7ae:	9736                	add	a4,a4,a3
     7b0:	00074703          	lbu	a4,0(a4)
     7b4:	17c1                	addi	a5,a5,-16
     7b6:	97a2                	add	a5,a5,s0
     7b8:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     7bc:	fb842783          	lw	a5,-72(s0)
     7c0:	fe043703          	ld	a4,-32(s0)
     7c4:	02f757b3          	divu	a5,a4,a5
     7c8:	fef43023          	sd	a5,-32(s0)
     7cc:	fe043783          	ld	a5,-32(s0)
     7d0:	ffdd                	bnez	a5,78e <printint+0x54>
  if(neg)
     7d2:	fe842783          	lw	a5,-24(s0)
     7d6:	2781                	sext.w	a5,a5
     7d8:	cb95                	beqz	a5,80c <printint+0xd2>
    buf[i++] = '-';
     7da:	fec42783          	lw	a5,-20(s0)
     7de:	0017871b          	addiw	a4,a5,1
     7e2:	fee42623          	sw	a4,-20(s0)
     7e6:	17c1                	addi	a5,a5,-16
     7e8:	97a2                	add	a5,a5,s0
     7ea:	02d00713          	li	a4,45
     7ee:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     7f2:	a829                	j	80c <printint+0xd2>
    putc(fd, buf[i]);
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	17c1                	addi	a5,a5,-16
     7fa:	97a2                	add	a5,a5,s0
     7fc:	fd87c703          	lbu	a4,-40(a5)
     800:	fbc42783          	lw	a5,-68(s0)
     804:	85ba                	mv	a1,a4
     806:	853e                	mv	a0,a5
     808:	f01ff0ef          	jal	708 <putc>
  while(--i >= 0)
     80c:	fec42783          	lw	a5,-20(s0)
     810:	37fd                	addiw	a5,a5,-1
     812:	fef42623          	sw	a5,-20(s0)
     816:	fec42783          	lw	a5,-20(s0)
     81a:	2781                	sext.w	a5,a5
     81c:	fc07dce3          	bgez	a5,7f4 <printint+0xba>
}
     820:	0001                	nop
     822:	0001                	nop
     824:	60e6                	ld	ra,88(sp)
     826:	6446                	ld	s0,80(sp)
     828:	6125                	addi	sp,sp,96
     82a:	8082                	ret

000000000000082c <printptr>:

static void
printptr(int fd, uint64 x) {
     82c:	7179                	addi	sp,sp,-48
     82e:	f406                	sd	ra,40(sp)
     830:	f022                	sd	s0,32(sp)
     832:	1800                	addi	s0,sp,48
     834:	87aa                	mv	a5,a0
     836:	fcb43823          	sd	a1,-48(s0)
     83a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     83e:	fdc42783          	lw	a5,-36(s0)
     842:	03000593          	li	a1,48
     846:	853e                	mv	a0,a5
     848:	ec1ff0ef          	jal	708 <putc>
  putc(fd, 'x');
     84c:	fdc42783          	lw	a5,-36(s0)
     850:	07800593          	li	a1,120
     854:	853e                	mv	a0,a5
     856:	eb3ff0ef          	jal	708 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     85a:	fe042623          	sw	zero,-20(s0)
     85e:	a81d                	j	894 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     860:	fd043783          	ld	a5,-48(s0)
     864:	93f1                	srli	a5,a5,0x3c
     866:	00001717          	auipc	a4,0x1
     86a:	79a70713          	addi	a4,a4,1946 # 2000 <digits>
     86e:	97ba                	add	a5,a5,a4
     870:	0007c703          	lbu	a4,0(a5)
     874:	fdc42783          	lw	a5,-36(s0)
     878:	85ba                	mv	a1,a4
     87a:	853e                	mv	a0,a5
     87c:	e8dff0ef          	jal	708 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     880:	fec42783          	lw	a5,-20(s0)
     884:	2785                	addiw	a5,a5,1
     886:	fef42623          	sw	a5,-20(s0)
     88a:	fd043783          	ld	a5,-48(s0)
     88e:	0792                	slli	a5,a5,0x4
     890:	fcf43823          	sd	a5,-48(s0)
     894:	fec42703          	lw	a4,-20(s0)
     898:	47bd                	li	a5,15
     89a:	fce7f3e3          	bgeu	a5,a4,860 <printptr+0x34>
}
     89e:	0001                	nop
     8a0:	0001                	nop
     8a2:	70a2                	ld	ra,40(sp)
     8a4:	7402                	ld	s0,32(sp)
     8a6:	6145                	addi	sp,sp,48
     8a8:	8082                	ret

00000000000008aa <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8aa:	715d                	addi	sp,sp,-80
     8ac:	e486                	sd	ra,72(sp)
     8ae:	e0a2                	sd	s0,64(sp)
     8b0:	0880                	addi	s0,sp,80
     8b2:	87aa                	mv	a5,a0
     8b4:	fcb43023          	sd	a1,-64(s0)
     8b8:	fac43c23          	sd	a2,-72(s0)
     8bc:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     8c0:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     8c4:	fc042e23          	sw	zero,-36(s0)
     8c8:	a189                	j	d0a <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     8ca:	fdc42783          	lw	a5,-36(s0)
     8ce:	fc043703          	ld	a4,-64(s0)
     8d2:	97ba                	add	a5,a5,a4
     8d4:	0007c783          	lbu	a5,0(a5)
     8d8:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     8dc:	fd842783          	lw	a5,-40(s0)
     8e0:	2781                	sext.w	a5,a5
     8e2:	eb8d                	bnez	a5,914 <vprintf+0x6a>
      if(c0 == '%'){
     8e4:	fd442783          	lw	a5,-44(s0)
     8e8:	0007871b          	sext.w	a4,a5
     8ec:	02500793          	li	a5,37
     8f0:	00f71763          	bne	a4,a5,8fe <vprintf+0x54>
        state = '%';
     8f4:	02500793          	li	a5,37
     8f8:	fcf42c23          	sw	a5,-40(s0)
     8fc:	a111                	j	d00 <vprintf+0x456>
      } else {
        putc(fd, c0);
     8fe:	fd442783          	lw	a5,-44(s0)
     902:	0ff7f713          	zext.b	a4,a5
     906:	fcc42783          	lw	a5,-52(s0)
     90a:	85ba                	mv	a1,a4
     90c:	853e                	mv	a0,a5
     90e:	dfbff0ef          	jal	708 <putc>
     912:	a6fd                	j	d00 <vprintf+0x456>
      }
    } else if(state == '%'){
     914:	fd842783          	lw	a5,-40(s0)
     918:	0007871b          	sext.w	a4,a5
     91c:	02500793          	li	a5,37
     920:	3ef71063          	bne	a4,a5,d00 <vprintf+0x456>
      c1 = c2 = 0;
     924:	fe042023          	sw	zero,-32(s0)
     928:	fe042783          	lw	a5,-32(s0)
     92c:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     930:	fd442783          	lw	a5,-44(s0)
     934:	2781                	sext.w	a5,a5
     936:	cb99                	beqz	a5,94c <vprintf+0xa2>
     938:	fdc42783          	lw	a5,-36(s0)
     93c:	0785                	addi	a5,a5,1
     93e:	fc043703          	ld	a4,-64(s0)
     942:	97ba                	add	a5,a5,a4
     944:	0007c783          	lbu	a5,0(a5)
     948:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     94c:	fe442783          	lw	a5,-28(s0)
     950:	2781                	sext.w	a5,a5
     952:	cb99                	beqz	a5,968 <vprintf+0xbe>
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0789                	addi	a5,a5,2
     95a:	fc043703          	ld	a4,-64(s0)
     95e:	97ba                	add	a5,a5,a4
     960:	0007c783          	lbu	a5,0(a5)
     964:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     968:	fd442783          	lw	a5,-44(s0)
     96c:	0007871b          	sext.w	a4,a5
     970:	06400793          	li	a5,100
     974:	02f71363          	bne	a4,a5,99a <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     978:	fb843783          	ld	a5,-72(s0)
     97c:	00878713          	addi	a4,a5,8
     980:	fae43c23          	sd	a4,-72(s0)
     984:	439c                	lw	a5,0(a5)
     986:	873e                	mv	a4,a5
     988:	fcc42783          	lw	a5,-52(s0)
     98c:	4685                	li	a3,1
     98e:	4629                	li	a2,10
     990:	85ba                	mv	a1,a4
     992:	853e                	mv	a0,a5
     994:	da7ff0ef          	jal	73a <printint>
     998:	a695                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     99a:	fd442783          	lw	a5,-44(s0)
     99e:	0007871b          	sext.w	a4,a5
     9a2:	06c00793          	li	a5,108
     9a6:	04f71063          	bne	a4,a5,9e6 <vprintf+0x13c>
     9aa:	fe442783          	lw	a5,-28(s0)
     9ae:	0007871b          	sext.w	a4,a5
     9b2:	06400793          	li	a5,100
     9b6:	02f71863          	bne	a4,a5,9e6 <vprintf+0x13c>
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
     9d6:	d65ff0ef          	jal	73a <printint>
        i += 1;
     9da:	fdc42783          	lw	a5,-36(s0)
     9de:	2785                	addiw	a5,a5,1
     9e0:	fcf42e23          	sw	a5,-36(s0)
     9e4:	ae21                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     9e6:	fd442783          	lw	a5,-44(s0)
     9ea:	0007871b          	sext.w	a4,a5
     9ee:	06c00793          	li	a5,108
     9f2:	04f71863          	bne	a4,a5,a42 <vprintf+0x198>
     9f6:	fe442783          	lw	a5,-28(s0)
     9fa:	0007871b          	sext.w	a4,a5
     9fe:	06c00793          	li	a5,108
     a02:	04f71063          	bne	a4,a5,a42 <vprintf+0x198>
     a06:	fe042783          	lw	a5,-32(s0)
     a0a:	0007871b          	sext.w	a4,a5
     a0e:	06400793          	li	a5,100
     a12:	02f71863          	bne	a4,a5,a42 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a16:	fb843783          	ld	a5,-72(s0)
     a1a:	00878713          	addi	a4,a5,8
     a1e:	fae43c23          	sd	a4,-72(s0)
     a22:	639c                	ld	a5,0(a5)
     a24:	873e                	mv	a4,a5
     a26:	fcc42783          	lw	a5,-52(s0)
     a2a:	4685                	li	a3,1
     a2c:	4629                	li	a2,10
     a2e:	85ba                	mv	a1,a4
     a30:	853e                	mv	a0,a5
     a32:	d09ff0ef          	jal	73a <printint>
        i += 2;
     a36:	fdc42783          	lw	a5,-36(s0)
     a3a:	2789                	addiw	a5,a5,2
     a3c:	fcf42e23          	sw	a5,-36(s0)
     a40:	ac75                	j	cfc <vprintf+0x452>
      } else if(c0 == 'u'){
     a42:	fd442783          	lw	a5,-44(s0)
     a46:	0007871b          	sext.w	a4,a5
     a4a:	07500793          	li	a5,117
     a4e:	02f71563          	bne	a4,a5,a78 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a52:	fb843783          	ld	a5,-72(s0)
     a56:	00878713          	addi	a4,a5,8
     a5a:	fae43c23          	sd	a4,-72(s0)
     a5e:	439c                	lw	a5,0(a5)
     a60:	02079713          	slli	a4,a5,0x20
     a64:	9301                	srli	a4,a4,0x20
     a66:	fcc42783          	lw	a5,-52(s0)
     a6a:	4681                	li	a3,0
     a6c:	4629                	li	a2,10
     a6e:	85ba                	mv	a1,a4
     a70:	853e                	mv	a0,a5
     a72:	cc9ff0ef          	jal	73a <printint>
     a76:	a459                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a78:	fd442783          	lw	a5,-44(s0)
     a7c:	0007871b          	sext.w	a4,a5
     a80:	06c00793          	li	a5,108
     a84:	04f71063          	bne	a4,a5,ac4 <vprintf+0x21a>
     a88:	fe442783          	lw	a5,-28(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	07500793          	li	a5,117
     a94:	02f71863          	bne	a4,a5,ac4 <vprintf+0x21a>
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
     ab4:	c87ff0ef          	jal	73a <printint>
        i += 1;
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	2785                	addiw	a5,a5,1
     abe:	fcf42e23          	sw	a5,-36(s0)
     ac2:	ac2d                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ac4:	fd442783          	lw	a5,-44(s0)
     ac8:	0007871b          	sext.w	a4,a5
     acc:	06c00793          	li	a5,108
     ad0:	04f71863          	bne	a4,a5,b20 <vprintf+0x276>
     ad4:	fe442783          	lw	a5,-28(s0)
     ad8:	0007871b          	sext.w	a4,a5
     adc:	06c00793          	li	a5,108
     ae0:	04f71063          	bne	a4,a5,b20 <vprintf+0x276>
     ae4:	fe042783          	lw	a5,-32(s0)
     ae8:	0007871b          	sext.w	a4,a5
     aec:	07500793          	li	a5,117
     af0:	02f71863          	bne	a4,a5,b20 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     af4:	fb843783          	ld	a5,-72(s0)
     af8:	00878713          	addi	a4,a5,8
     afc:	fae43c23          	sd	a4,-72(s0)
     b00:	639c                	ld	a5,0(a5)
     b02:	873e                	mv	a4,a5
     b04:	fcc42783          	lw	a5,-52(s0)
     b08:	4681                	li	a3,0
     b0a:	4629                	li	a2,10
     b0c:	85ba                	mv	a1,a4
     b0e:	853e                	mv	a0,a5
     b10:	c2bff0ef          	jal	73a <printint>
        i += 2;
     b14:	fdc42783          	lw	a5,-36(s0)
     b18:	2789                	addiw	a5,a5,2
     b1a:	fcf42e23          	sw	a5,-36(s0)
     b1e:	aaf9                	j	cfc <vprintf+0x452>
      } else if(c0 == 'x'){
     b20:	fd442783          	lw	a5,-44(s0)
     b24:	0007871b          	sext.w	a4,a5
     b28:	07800793          	li	a5,120
     b2c:	02f71563          	bne	a4,a5,b56 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b30:	fb843783          	ld	a5,-72(s0)
     b34:	00878713          	addi	a4,a5,8
     b38:	fae43c23          	sd	a4,-72(s0)
     b3c:	439c                	lw	a5,0(a5)
     b3e:	02079713          	slli	a4,a5,0x20
     b42:	9301                	srli	a4,a4,0x20
     b44:	fcc42783          	lw	a5,-52(s0)
     b48:	4681                	li	a3,0
     b4a:	4641                	li	a2,16
     b4c:	85ba                	mv	a1,a4
     b4e:	853e                	mv	a0,a5
     b50:	bebff0ef          	jal	73a <printint>
     b54:	a265                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b56:	fd442783          	lw	a5,-44(s0)
     b5a:	0007871b          	sext.w	a4,a5
     b5e:	06c00793          	li	a5,108
     b62:	04f71063          	bne	a4,a5,ba2 <vprintf+0x2f8>
     b66:	fe442783          	lw	a5,-28(s0)
     b6a:	0007871b          	sext.w	a4,a5
     b6e:	07800793          	li	a5,120
     b72:	02f71863          	bne	a4,a5,ba2 <vprintf+0x2f8>
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
     b92:	ba9ff0ef          	jal	73a <printint>
        i += 1;
     b96:	fdc42783          	lw	a5,-36(s0)
     b9a:	2785                	addiw	a5,a5,1
     b9c:	fcf42e23          	sw	a5,-36(s0)
     ba0:	aab1                	j	cfc <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     ba2:	fd442783          	lw	a5,-44(s0)
     ba6:	0007871b          	sext.w	a4,a5
     baa:	06c00793          	li	a5,108
     bae:	04f71863          	bne	a4,a5,bfe <vprintf+0x354>
     bb2:	fe442783          	lw	a5,-28(s0)
     bb6:	0007871b          	sext.w	a4,a5
     bba:	06c00793          	li	a5,108
     bbe:	04f71063          	bne	a4,a5,bfe <vprintf+0x354>
     bc2:	fe042783          	lw	a5,-32(s0)
     bc6:	0007871b          	sext.w	a4,a5
     bca:	07800793          	li	a5,120
     bce:	02f71863          	bne	a4,a5,bfe <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     bd2:	fb843783          	ld	a5,-72(s0)
     bd6:	00878713          	addi	a4,a5,8
     bda:	fae43c23          	sd	a4,-72(s0)
     bde:	639c                	ld	a5,0(a5)
     be0:	873e                	mv	a4,a5
     be2:	fcc42783          	lw	a5,-52(s0)
     be6:	4681                	li	a3,0
     be8:	4641                	li	a2,16
     bea:	85ba                	mv	a1,a4
     bec:	853e                	mv	a0,a5
     bee:	b4dff0ef          	jal	73a <printint>
        i += 2;
     bf2:	fdc42783          	lw	a5,-36(s0)
     bf6:	2789                	addiw	a5,a5,2
     bf8:	fcf42e23          	sw	a5,-36(s0)
     bfc:	a201                	j	cfc <vprintf+0x452>
      } else if(c0 == 'p'){
     bfe:	fd442783          	lw	a5,-44(s0)
     c02:	0007871b          	sext.w	a4,a5
     c06:	07000793          	li	a5,112
     c0a:	02f71063          	bne	a4,a5,c2a <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c0e:	fb843783          	ld	a5,-72(s0)
     c12:	00878713          	addi	a4,a5,8
     c16:	fae43c23          	sd	a4,-72(s0)
     c1a:	6398                	ld	a4,0(a5)
     c1c:	fcc42783          	lw	a5,-52(s0)
     c20:	85ba                	mv	a1,a4
     c22:	853e                	mv	a0,a5
     c24:	c09ff0ef          	jal	82c <printptr>
     c28:	a8d1                	j	cfc <vprintf+0x452>
      } else if(c0 == 'c'){
     c2a:	fd442783          	lw	a5,-44(s0)
     c2e:	0007871b          	sext.w	a4,a5
     c32:	06300793          	li	a5,99
     c36:	02f71263          	bne	a4,a5,c5a <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c3a:	fb843783          	ld	a5,-72(s0)
     c3e:	00878713          	addi	a4,a5,8
     c42:	fae43c23          	sd	a4,-72(s0)
     c46:	439c                	lw	a5,0(a5)
     c48:	0ff7f713          	zext.b	a4,a5
     c4c:	fcc42783          	lw	a5,-52(s0)
     c50:	85ba                	mv	a1,a4
     c52:	853e                	mv	a0,a5
     c54:	ab5ff0ef          	jal	708 <putc>
     c58:	a055                	j	cfc <vprintf+0x452>
      } else if(c0 == 's'){
     c5a:	fd442783          	lw	a5,-44(s0)
     c5e:	0007871b          	sext.w	a4,a5
     c62:	07300793          	li	a5,115
     c66:	04f71a63          	bne	a4,a5,cba <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c6a:	fb843783          	ld	a5,-72(s0)
     c6e:	00878713          	addi	a4,a5,8
     c72:	fae43c23          	sd	a4,-72(s0)
     c76:	639c                	ld	a5,0(a5)
     c78:	fef43423          	sd	a5,-24(s0)
     c7c:	fe843783          	ld	a5,-24(s0)
     c80:	e79d                	bnez	a5,cae <vprintf+0x404>
          s = "(null)";
     c82:	00000797          	auipc	a5,0x0
     c86:	46678793          	addi	a5,a5,1126 # 10e8 <malloc+0x184>
     c8a:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c8e:	a005                	j	cae <vprintf+0x404>
          putc(fd, *s);
     c90:	fe843783          	ld	a5,-24(s0)
     c94:	0007c703          	lbu	a4,0(a5)
     c98:	fcc42783          	lw	a5,-52(s0)
     c9c:	85ba                	mv	a1,a4
     c9e:	853e                	mv	a0,a5
     ca0:	a69ff0ef          	jal	708 <putc>
        for(; *s; s++)
     ca4:	fe843783          	ld	a5,-24(s0)
     ca8:	0785                	addi	a5,a5,1
     caa:	fef43423          	sd	a5,-24(s0)
     cae:	fe843783          	ld	a5,-24(s0)
     cb2:	0007c783          	lbu	a5,0(a5)
     cb6:	ffe9                	bnez	a5,c90 <vprintf+0x3e6>
     cb8:	a091                	j	cfc <vprintf+0x452>
      } else if(c0 == '%'){
     cba:	fd442783          	lw	a5,-44(s0)
     cbe:	0007871b          	sext.w	a4,a5
     cc2:	02500793          	li	a5,37
     cc6:	00f71a63          	bne	a4,a5,cda <vprintf+0x430>
        putc(fd, '%');
     cca:	fcc42783          	lw	a5,-52(s0)
     cce:	02500593          	li	a1,37
     cd2:	853e                	mv	a0,a5
     cd4:	a35ff0ef          	jal	708 <putc>
     cd8:	a015                	j	cfc <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cda:	fcc42783          	lw	a5,-52(s0)
     cde:	02500593          	li	a1,37
     ce2:	853e                	mv	a0,a5
     ce4:	a25ff0ef          	jal	708 <putc>
        putc(fd, c0);
     ce8:	fd442783          	lw	a5,-44(s0)
     cec:	0ff7f713          	zext.b	a4,a5
     cf0:	fcc42783          	lw	a5,-52(s0)
     cf4:	85ba                	mv	a1,a4
     cf6:	853e                	mv	a0,a5
     cf8:	a11ff0ef          	jal	708 <putc>
      }

      state = 0;
     cfc:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d00:	fdc42783          	lw	a5,-36(s0)
     d04:	2785                	addiw	a5,a5,1
     d06:	fcf42e23          	sw	a5,-36(s0)
     d0a:	fdc42783          	lw	a5,-36(s0)
     d0e:	fc043703          	ld	a4,-64(s0)
     d12:	97ba                	add	a5,a5,a4
     d14:	0007c783          	lbu	a5,0(a5)
     d18:	ba0799e3          	bnez	a5,8ca <vprintf+0x20>
    }
  }
}
     d1c:	0001                	nop
     d1e:	0001                	nop
     d20:	60a6                	ld	ra,72(sp)
     d22:	6406                	ld	s0,64(sp)
     d24:	6161                	addi	sp,sp,80
     d26:	8082                	ret

0000000000000d28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d28:	7159                	addi	sp,sp,-112
     d2a:	fc06                	sd	ra,56(sp)
     d2c:	f822                	sd	s0,48(sp)
     d2e:	0080                	addi	s0,sp,64
     d30:	fcb43823          	sd	a1,-48(s0)
     d34:	e010                	sd	a2,0(s0)
     d36:	e414                	sd	a3,8(s0)
     d38:	e818                	sd	a4,16(s0)
     d3a:	ec1c                	sd	a5,24(s0)
     d3c:	03043023          	sd	a6,32(s0)
     d40:	03143423          	sd	a7,40(s0)
     d44:	87aa                	mv	a5,a0
     d46:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d4a:	03040793          	addi	a5,s0,48
     d4e:	fcf43423          	sd	a5,-56(s0)
     d52:	fc843783          	ld	a5,-56(s0)
     d56:	fd078793          	addi	a5,a5,-48
     d5a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d5e:	fe843703          	ld	a4,-24(s0)
     d62:	fdc42783          	lw	a5,-36(s0)
     d66:	863a                	mv	a2,a4
     d68:	fd043583          	ld	a1,-48(s0)
     d6c:	853e                	mv	a0,a5
     d6e:	b3dff0ef          	jal	8aa <vprintf>
}
     d72:	0001                	nop
     d74:	70e2                	ld	ra,56(sp)
     d76:	7442                	ld	s0,48(sp)
     d78:	6165                	addi	sp,sp,112
     d7a:	8082                	ret

0000000000000d7c <printf>:

void
printf(const char *fmt, ...)
{
     d7c:	7159                	addi	sp,sp,-112
     d7e:	f406                	sd	ra,40(sp)
     d80:	f022                	sd	s0,32(sp)
     d82:	1800                	addi	s0,sp,48
     d84:	fca43c23          	sd	a0,-40(s0)
     d88:	e40c                	sd	a1,8(s0)
     d8a:	e810                	sd	a2,16(s0)
     d8c:	ec14                	sd	a3,24(s0)
     d8e:	f018                	sd	a4,32(s0)
     d90:	f41c                	sd	a5,40(s0)
     d92:	03043823          	sd	a6,48(s0)
     d96:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d9a:	04040793          	addi	a5,s0,64
     d9e:	fcf43823          	sd	a5,-48(s0)
     da2:	fd043783          	ld	a5,-48(s0)
     da6:	fc878793          	addi	a5,a5,-56
     daa:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     dae:	fe843783          	ld	a5,-24(s0)
     db2:	863e                	mv	a2,a5
     db4:	fd843583          	ld	a1,-40(s0)
     db8:	4505                	li	a0,1
     dba:	af1ff0ef          	jal	8aa <vprintf>
}
     dbe:	0001                	nop
     dc0:	70a2                	ld	ra,40(sp)
     dc2:	7402                	ld	s0,32(sp)
     dc4:	6165                	addi	sp,sp,112
     dc6:	8082                	ret

0000000000000dc8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dc8:	7179                	addi	sp,sp,-48
     dca:	f406                	sd	ra,40(sp)
     dcc:	f022                	sd	s0,32(sp)
     dce:	1800                	addi	s0,sp,48
     dd0:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     dd4:	fd843783          	ld	a5,-40(s0)
     dd8:	17c1                	addi	a5,a5,-16
     dda:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dde:	00001797          	auipc	a5,0x1
     de2:	45278793          	addi	a5,a5,1106 # 2230 <freep>
     de6:	639c                	ld	a5,0(a5)
     de8:	fef43423          	sd	a5,-24(s0)
     dec:	a815                	j	e20 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dee:	fe843783          	ld	a5,-24(s0)
     df2:	639c                	ld	a5,0(a5)
     df4:	fe843703          	ld	a4,-24(s0)
     df8:	00f76f63          	bltu	a4,a5,e16 <free+0x4e>
     dfc:	fe043703          	ld	a4,-32(s0)
     e00:	fe843783          	ld	a5,-24(s0)
     e04:	02e7eb63          	bltu	a5,a4,e3a <free+0x72>
     e08:	fe843783          	ld	a5,-24(s0)
     e0c:	639c                	ld	a5,0(a5)
     e0e:	fe043703          	ld	a4,-32(s0)
     e12:	02f76463          	bltu	a4,a5,e3a <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e16:	fe843783          	ld	a5,-24(s0)
     e1a:	639c                	ld	a5,0(a5)
     e1c:	fef43423          	sd	a5,-24(s0)
     e20:	fe043703          	ld	a4,-32(s0)
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	fce7f3e3          	bgeu	a5,a4,dee <free+0x26>
     e2c:	fe843783          	ld	a5,-24(s0)
     e30:	639c                	ld	a5,0(a5)
     e32:	fe043703          	ld	a4,-32(s0)
     e36:	faf77ce3          	bgeu	a4,a5,dee <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e3a:	fe043783          	ld	a5,-32(s0)
     e3e:	479c                	lw	a5,8(a5)
     e40:	1782                	slli	a5,a5,0x20
     e42:	9381                	srli	a5,a5,0x20
     e44:	0792                	slli	a5,a5,0x4
     e46:	fe043703          	ld	a4,-32(s0)
     e4a:	973e                	add	a4,a4,a5
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	639c                	ld	a5,0(a5)
     e52:	02f71763          	bne	a4,a5,e80 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e56:	fe043783          	ld	a5,-32(s0)
     e5a:	4798                	lw	a4,8(a5)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	639c                	ld	a5,0(a5)
     e62:	479c                	lw	a5,8(a5)
     e64:	9fb9                	addw	a5,a5,a4
     e66:	0007871b          	sext.w	a4,a5
     e6a:	fe043783          	ld	a5,-32(s0)
     e6e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	639c                	ld	a5,0(a5)
     e76:	6398                	ld	a4,0(a5)
     e78:	fe043783          	ld	a5,-32(s0)
     e7c:	e398                	sd	a4,0(a5)
     e7e:	a039                	j	e8c <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	6398                	ld	a4,0(a5)
     e86:	fe043783          	ld	a5,-32(s0)
     e8a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e8c:	fe843783          	ld	a5,-24(s0)
     e90:	479c                	lw	a5,8(a5)
     e92:	1782                	slli	a5,a5,0x20
     e94:	9381                	srli	a5,a5,0x20
     e96:	0792                	slli	a5,a5,0x4
     e98:	fe843703          	ld	a4,-24(s0)
     e9c:	97ba                	add	a5,a5,a4
     e9e:	fe043703          	ld	a4,-32(s0)
     ea2:	02f71563          	bne	a4,a5,ecc <free+0x104>
    p->s.size += bp->s.size;
     ea6:	fe843783          	ld	a5,-24(s0)
     eaa:	4798                	lw	a4,8(a5)
     eac:	fe043783          	ld	a5,-32(s0)
     eb0:	479c                	lw	a5,8(a5)
     eb2:	9fb9                	addw	a5,a5,a4
     eb4:	0007871b          	sext.w	a4,a5
     eb8:	fe843783          	ld	a5,-24(s0)
     ebc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ebe:	fe043783          	ld	a5,-32(s0)
     ec2:	6398                	ld	a4,0(a5)
     ec4:	fe843783          	ld	a5,-24(s0)
     ec8:	e398                	sd	a4,0(a5)
     eca:	a031                	j	ed6 <free+0x10e>
  } else
    p->s.ptr = bp;
     ecc:	fe843783          	ld	a5,-24(s0)
     ed0:	fe043703          	ld	a4,-32(s0)
     ed4:	e398                	sd	a4,0(a5)
  freep = p;
     ed6:	00001797          	auipc	a5,0x1
     eda:	35a78793          	addi	a5,a5,858 # 2230 <freep>
     ede:	fe843703          	ld	a4,-24(s0)
     ee2:	e398                	sd	a4,0(a5)
}
     ee4:	0001                	nop
     ee6:	70a2                	ld	ra,40(sp)
     ee8:	7402                	ld	s0,32(sp)
     eea:	6145                	addi	sp,sp,48
     eec:	8082                	ret

0000000000000eee <morecore>:

static Header*
morecore(uint nu)
{
     eee:	7179                	addi	sp,sp,-48
     ef0:	f406                	sd	ra,40(sp)
     ef2:	f022                	sd	s0,32(sp)
     ef4:	1800                	addi	s0,sp,48
     ef6:	87aa                	mv	a5,a0
     ef8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     efc:	fdc42783          	lw	a5,-36(s0)
     f00:	0007871b          	sext.w	a4,a5
     f04:	6785                	lui	a5,0x1
     f06:	00f77563          	bgeu	a4,a5,f10 <morecore+0x22>
    nu = 4096;
     f0a:	6785                	lui	a5,0x1
     f0c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f10:	fdc42783          	lw	a5,-36(s0)
     f14:	0047979b          	slliw	a5,a5,0x4
     f18:	2781                	sext.w	a5,a5
     f1a:	853e                	mv	a0,a5
     f1c:	ef0ff0ef          	jal	60c <sbrk>
     f20:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f24:	fe843703          	ld	a4,-24(s0)
     f28:	57fd                	li	a5,-1
     f2a:	00f71463          	bne	a4,a5,f32 <morecore+0x44>
    return 0;
     f2e:	4781                	li	a5,0
     f30:	a02d                	j	f5a <morecore+0x6c>
  hp = (Header*)p;
     f32:	fe843783          	ld	a5,-24(s0)
     f36:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f3a:	fe043783          	ld	a5,-32(s0)
     f3e:	fdc42703          	lw	a4,-36(s0)
     f42:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f44:	fe043783          	ld	a5,-32(s0)
     f48:	07c1                	addi	a5,a5,16 # 1010 <malloc+0xac>
     f4a:	853e                	mv	a0,a5
     f4c:	e7dff0ef          	jal	dc8 <free>
  return freep;
     f50:	00001797          	auipc	a5,0x1
     f54:	2e078793          	addi	a5,a5,736 # 2230 <freep>
     f58:	639c                	ld	a5,0(a5)
}
     f5a:	853e                	mv	a0,a5
     f5c:	70a2                	ld	ra,40(sp)
     f5e:	7402                	ld	s0,32(sp)
     f60:	6145                	addi	sp,sp,48
     f62:	8082                	ret

0000000000000f64 <malloc>:

void*
malloc(uint nbytes)
{
     f64:	7139                	addi	sp,sp,-64
     f66:	fc06                	sd	ra,56(sp)
     f68:	f822                	sd	s0,48(sp)
     f6a:	0080                	addi	s0,sp,64
     f6c:	87aa                	mv	a5,a0
     f6e:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f72:	fcc46783          	lwu	a5,-52(s0)
     f76:	07bd                	addi	a5,a5,15
     f78:	8391                	srli	a5,a5,0x4
     f7a:	2781                	sext.w	a5,a5
     f7c:	2785                	addiw	a5,a5,1
     f7e:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f82:	00001797          	auipc	a5,0x1
     f86:	2ae78793          	addi	a5,a5,686 # 2230 <freep>
     f8a:	639c                	ld	a5,0(a5)
     f8c:	fef43023          	sd	a5,-32(s0)
     f90:	fe043783          	ld	a5,-32(s0)
     f94:	ef95                	bnez	a5,fd0 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f96:	00001797          	auipc	a5,0x1
     f9a:	28a78793          	addi	a5,a5,650 # 2220 <base>
     f9e:	fef43023          	sd	a5,-32(s0)
     fa2:	00001797          	auipc	a5,0x1
     fa6:	28e78793          	addi	a5,a5,654 # 2230 <freep>
     faa:	fe043703          	ld	a4,-32(s0)
     fae:	e398                	sd	a4,0(a5)
     fb0:	00001797          	auipc	a5,0x1
     fb4:	28078793          	addi	a5,a5,640 # 2230 <freep>
     fb8:	6398                	ld	a4,0(a5)
     fba:	00001797          	auipc	a5,0x1
     fbe:	26678793          	addi	a5,a5,614 # 2220 <base>
     fc2:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fc4:	00001797          	auipc	a5,0x1
     fc8:	25c78793          	addi	a5,a5,604 # 2220 <base>
     fcc:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fd0:	fe043783          	ld	a5,-32(s0)
     fd4:	639c                	ld	a5,0(a5)
     fd6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	479c                	lw	a5,8(a5)
     fe0:	fdc42703          	lw	a4,-36(s0)
     fe4:	2701                	sext.w	a4,a4
     fe6:	06e7e763          	bltu	a5,a4,1054 <malloc+0xf0>
      if(p->s.size == nunits)
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	479c                	lw	a5,8(a5)
     ff0:	fdc42703          	lw	a4,-36(s0)
     ff4:	2701                	sext.w	a4,a4
     ff6:	00f71963          	bne	a4,a5,1008 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     ffa:	fe843783          	ld	a5,-24(s0)
     ffe:	6398                	ld	a4,0(a5)
    1000:	fe043783          	ld	a5,-32(s0)
    1004:	e398                	sd	a4,0(a5)
    1006:	a825                	j	103e <malloc+0xda>
      else {
        p->s.size -= nunits;
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	479c                	lw	a5,8(a5)
    100e:	fdc42703          	lw	a4,-36(s0)
    1012:	9f99                	subw	a5,a5,a4
    1014:	0007871b          	sext.w	a4,a5
    1018:	fe843783          	ld	a5,-24(s0)
    101c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    101e:	fe843783          	ld	a5,-24(s0)
    1022:	479c                	lw	a5,8(a5)
    1024:	1782                	slli	a5,a5,0x20
    1026:	9381                	srli	a5,a5,0x20
    1028:	0792                	slli	a5,a5,0x4
    102a:	fe843703          	ld	a4,-24(s0)
    102e:	97ba                	add	a5,a5,a4
    1030:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1034:	fe843783          	ld	a5,-24(s0)
    1038:	fdc42703          	lw	a4,-36(s0)
    103c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    103e:	00001797          	auipc	a5,0x1
    1042:	1f278793          	addi	a5,a5,498 # 2230 <freep>
    1046:	fe043703          	ld	a4,-32(s0)
    104a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    104c:	fe843783          	ld	a5,-24(s0)
    1050:	07c1                	addi	a5,a5,16
    1052:	a081                	j	1092 <malloc+0x12e>
    }
    if(p == freep)
    1054:	00001797          	auipc	a5,0x1
    1058:	1dc78793          	addi	a5,a5,476 # 2230 <freep>
    105c:	639c                	ld	a5,0(a5)
    105e:	fe843703          	ld	a4,-24(s0)
    1062:	00f71e63          	bne	a4,a5,107e <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1066:	fdc42783          	lw	a5,-36(s0)
    106a:	853e                	mv	a0,a5
    106c:	e83ff0ef          	jal	eee <morecore>
    1070:	fea43423          	sd	a0,-24(s0)
    1074:	fe843783          	ld	a5,-24(s0)
    1078:	e399                	bnez	a5,107e <malloc+0x11a>
        return 0;
    107a:	4781                	li	a5,0
    107c:	a819                	j	1092 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    107e:	fe843783          	ld	a5,-24(s0)
    1082:	fef43023          	sd	a5,-32(s0)
    1086:	fe843783          	ld	a5,-24(s0)
    108a:	639c                	ld	a5,0(a5)
    108c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1090:	b7a9                	j	fda <malloc+0x76>
  }
}
    1092:	853e                	mv	a0,a5
    1094:	70e2                	ld	ra,56(sp)
    1096:	7442                	ld	s0,48(sp)
    1098:	6121                	addi	sp,sp,64
    109a:	8082                	ret
