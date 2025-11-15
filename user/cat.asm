
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
      36:	07e58593          	addi	a1,a1,126 # 10b0 <malloc+0x144>
      3a:	4509                	li	a0,2
      3c:	4f5000ef          	jal	d30 <fprintf>
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
      7a:	05258593          	addi	a1,a1,82 # 10c8 <malloc+0x15c>
      7e:	4509                	li	a0,2
      80:	4b1000ef          	jal	d30 <fprintf>
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
     102:	fe258593          	addi	a1,a1,-30 # 10e0 <malloc+0x174>
     106:	4509                	li	a0,2
     108:	429000ef          	jal	d30 <fprintf>
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

0000000000000708 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     708:	48dd                	li	a7,23
 ecall
     70a:	00000073          	ecall
 ret
     70e:	8082                	ret

0000000000000710 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     710:	1101                	addi	sp,sp,-32
     712:	ec06                	sd	ra,24(sp)
     714:	e822                	sd	s0,16(sp)
     716:	1000                	addi	s0,sp,32
     718:	87aa                	mv	a5,a0
     71a:	872e                	mv	a4,a1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	87ba                	mv	a5,a4
     722:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     726:	feb40713          	addi	a4,s0,-21
     72a:	fec42783          	lw	a5,-20(s0)
     72e:	4605                	li	a2,1
     730:	85ba                	mv	a1,a4
     732:	853e                	mv	a0,a5
     734:	f4dff0ef          	jal	680 <write>
}
     738:	0001                	nop
     73a:	60e2                	ld	ra,24(sp)
     73c:	6442                	ld	s0,16(sp)
     73e:	6105                	addi	sp,sp,32
     740:	8082                	ret

0000000000000742 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     742:	711d                	addi	sp,sp,-96
     744:	ec86                	sd	ra,88(sp)
     746:	e8a2                	sd	s0,80(sp)
     748:	1080                	addi	s0,sp,96
     74a:	87aa                	mv	a5,a0
     74c:	fab43823          	sd	a1,-80(s0)
     750:	8736                	mv	a4,a3
     752:	faf42e23          	sw	a5,-68(s0)
     756:	87b2                	mv	a5,a2
     758:	faf42c23          	sw	a5,-72(s0)
     75c:	87ba                	mv	a5,a4
     75e:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     762:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     766:	fac42783          	lw	a5,-84(s0)
     76a:	2781                	sext.w	a5,a5
     76c:	cf99                	beqz	a5,78a <printint+0x48>
     76e:	fb043783          	ld	a5,-80(s0)
     772:	0007dc63          	bgez	a5,78a <printint+0x48>
    neg = 1;
     776:	4785                	li	a5,1
     778:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     77c:	fb043783          	ld	a5,-80(s0)
     780:	40f007b3          	neg	a5,a5
     784:	fef43023          	sd	a5,-32(s0)
     788:	a029                	j	792 <printint+0x50>
  } else {
    x = xx;
     78a:	fb043783          	ld	a5,-80(s0)
     78e:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     792:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     796:	fb842783          	lw	a5,-72(s0)
     79a:	fe043703          	ld	a4,-32(s0)
     79e:	02f77733          	remu	a4,a4,a5
     7a2:	fec42783          	lw	a5,-20(s0)
     7a6:	0017869b          	addiw	a3,a5,1
     7aa:	fed42623          	sw	a3,-20(s0)
     7ae:	00002697          	auipc	a3,0x2
     7b2:	85268693          	addi	a3,a3,-1966 # 2000 <digits>
     7b6:	9736                	add	a4,a4,a3
     7b8:	00074703          	lbu	a4,0(a4)
     7bc:	17c1                	addi	a5,a5,-16
     7be:	97a2                	add	a5,a5,s0
     7c0:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     7c4:	fb842783          	lw	a5,-72(s0)
     7c8:	fe043703          	ld	a4,-32(s0)
     7cc:	02f757b3          	divu	a5,a4,a5
     7d0:	fef43023          	sd	a5,-32(s0)
     7d4:	fe043783          	ld	a5,-32(s0)
     7d8:	ffdd                	bnez	a5,796 <printint+0x54>
  if(neg)
     7da:	fe842783          	lw	a5,-24(s0)
     7de:	2781                	sext.w	a5,a5
     7e0:	cb95                	beqz	a5,814 <printint+0xd2>
    buf[i++] = '-';
     7e2:	fec42783          	lw	a5,-20(s0)
     7e6:	0017871b          	addiw	a4,a5,1
     7ea:	fee42623          	sw	a4,-20(s0)
     7ee:	17c1                	addi	a5,a5,-16
     7f0:	97a2                	add	a5,a5,s0
     7f2:	02d00713          	li	a4,45
     7f6:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     7fa:	a829                	j	814 <printint+0xd2>
    putc(fd, buf[i]);
     7fc:	fec42783          	lw	a5,-20(s0)
     800:	17c1                	addi	a5,a5,-16
     802:	97a2                	add	a5,a5,s0
     804:	fd87c703          	lbu	a4,-40(a5)
     808:	fbc42783          	lw	a5,-68(s0)
     80c:	85ba                	mv	a1,a4
     80e:	853e                	mv	a0,a5
     810:	f01ff0ef          	jal	710 <putc>
  while(--i >= 0)
     814:	fec42783          	lw	a5,-20(s0)
     818:	37fd                	addiw	a5,a5,-1
     81a:	fef42623          	sw	a5,-20(s0)
     81e:	fec42783          	lw	a5,-20(s0)
     822:	2781                	sext.w	a5,a5
     824:	fc07dce3          	bgez	a5,7fc <printint+0xba>
}
     828:	0001                	nop
     82a:	0001                	nop
     82c:	60e6                	ld	ra,88(sp)
     82e:	6446                	ld	s0,80(sp)
     830:	6125                	addi	sp,sp,96
     832:	8082                	ret

0000000000000834 <printptr>:

static void
printptr(int fd, uint64 x) {
     834:	7179                	addi	sp,sp,-48
     836:	f406                	sd	ra,40(sp)
     838:	f022                	sd	s0,32(sp)
     83a:	1800                	addi	s0,sp,48
     83c:	87aa                	mv	a5,a0
     83e:	fcb43823          	sd	a1,-48(s0)
     842:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     846:	fdc42783          	lw	a5,-36(s0)
     84a:	03000593          	li	a1,48
     84e:	853e                	mv	a0,a5
     850:	ec1ff0ef          	jal	710 <putc>
  putc(fd, 'x');
     854:	fdc42783          	lw	a5,-36(s0)
     858:	07800593          	li	a1,120
     85c:	853e                	mv	a0,a5
     85e:	eb3ff0ef          	jal	710 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     862:	fe042623          	sw	zero,-20(s0)
     866:	a81d                	j	89c <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     868:	fd043783          	ld	a5,-48(s0)
     86c:	93f1                	srli	a5,a5,0x3c
     86e:	00001717          	auipc	a4,0x1
     872:	79270713          	addi	a4,a4,1938 # 2000 <digits>
     876:	97ba                	add	a5,a5,a4
     878:	0007c703          	lbu	a4,0(a5)
     87c:	fdc42783          	lw	a5,-36(s0)
     880:	85ba                	mv	a1,a4
     882:	853e                	mv	a0,a5
     884:	e8dff0ef          	jal	710 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     888:	fec42783          	lw	a5,-20(s0)
     88c:	2785                	addiw	a5,a5,1
     88e:	fef42623          	sw	a5,-20(s0)
     892:	fd043783          	ld	a5,-48(s0)
     896:	0792                	slli	a5,a5,0x4
     898:	fcf43823          	sd	a5,-48(s0)
     89c:	fec42703          	lw	a4,-20(s0)
     8a0:	47bd                	li	a5,15
     8a2:	fce7f3e3          	bgeu	a5,a4,868 <printptr+0x34>
}
     8a6:	0001                	nop
     8a8:	0001                	nop
     8aa:	70a2                	ld	ra,40(sp)
     8ac:	7402                	ld	s0,32(sp)
     8ae:	6145                	addi	sp,sp,48
     8b0:	8082                	ret

00000000000008b2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8b2:	715d                	addi	sp,sp,-80
     8b4:	e486                	sd	ra,72(sp)
     8b6:	e0a2                	sd	s0,64(sp)
     8b8:	0880                	addi	s0,sp,80
     8ba:	87aa                	mv	a5,a0
     8bc:	fcb43023          	sd	a1,-64(s0)
     8c0:	fac43c23          	sd	a2,-72(s0)
     8c4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     8c8:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     8cc:	fc042e23          	sw	zero,-36(s0)
     8d0:	a189                	j	d12 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     8d2:	fdc42783          	lw	a5,-36(s0)
     8d6:	fc043703          	ld	a4,-64(s0)
     8da:	97ba                	add	a5,a5,a4
     8dc:	0007c783          	lbu	a5,0(a5)
     8e0:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     8e4:	fd842783          	lw	a5,-40(s0)
     8e8:	2781                	sext.w	a5,a5
     8ea:	eb8d                	bnez	a5,91c <vprintf+0x6a>
      if(c0 == '%'){
     8ec:	fd442783          	lw	a5,-44(s0)
     8f0:	0007871b          	sext.w	a4,a5
     8f4:	02500793          	li	a5,37
     8f8:	00f71763          	bne	a4,a5,906 <vprintf+0x54>
        state = '%';
     8fc:	02500793          	li	a5,37
     900:	fcf42c23          	sw	a5,-40(s0)
     904:	a111                	j	d08 <vprintf+0x456>
      } else {
        putc(fd, c0);
     906:	fd442783          	lw	a5,-44(s0)
     90a:	0ff7f713          	zext.b	a4,a5
     90e:	fcc42783          	lw	a5,-52(s0)
     912:	85ba                	mv	a1,a4
     914:	853e                	mv	a0,a5
     916:	dfbff0ef          	jal	710 <putc>
     91a:	a6fd                	j	d08 <vprintf+0x456>
      }
    } else if(state == '%'){
     91c:	fd842783          	lw	a5,-40(s0)
     920:	0007871b          	sext.w	a4,a5
     924:	02500793          	li	a5,37
     928:	3ef71063          	bne	a4,a5,d08 <vprintf+0x456>
      c1 = c2 = 0;
     92c:	fe042023          	sw	zero,-32(s0)
     930:	fe042783          	lw	a5,-32(s0)
     934:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     938:	fd442783          	lw	a5,-44(s0)
     93c:	2781                	sext.w	a5,a5
     93e:	cb99                	beqz	a5,954 <vprintf+0xa2>
     940:	fdc42783          	lw	a5,-36(s0)
     944:	0785                	addi	a5,a5,1
     946:	fc043703          	ld	a4,-64(s0)
     94a:	97ba                	add	a5,a5,a4
     94c:	0007c783          	lbu	a5,0(a5)
     950:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     954:	fe442783          	lw	a5,-28(s0)
     958:	2781                	sext.w	a5,a5
     95a:	cb99                	beqz	a5,970 <vprintf+0xbe>
     95c:	fdc42783          	lw	a5,-36(s0)
     960:	0789                	addi	a5,a5,2
     962:	fc043703          	ld	a4,-64(s0)
     966:	97ba                	add	a5,a5,a4
     968:	0007c783          	lbu	a5,0(a5)
     96c:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     970:	fd442783          	lw	a5,-44(s0)
     974:	0007871b          	sext.w	a4,a5
     978:	06400793          	li	a5,100
     97c:	02f71363          	bne	a4,a5,9a2 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     980:	fb843783          	ld	a5,-72(s0)
     984:	00878713          	addi	a4,a5,8
     988:	fae43c23          	sd	a4,-72(s0)
     98c:	439c                	lw	a5,0(a5)
     98e:	873e                	mv	a4,a5
     990:	fcc42783          	lw	a5,-52(s0)
     994:	4685                	li	a3,1
     996:	4629                	li	a2,10
     998:	85ba                	mv	a1,a4
     99a:	853e                	mv	a0,a5
     99c:	da7ff0ef          	jal	742 <printint>
     9a0:	a695                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9a2:	fd442783          	lw	a5,-44(s0)
     9a6:	0007871b          	sext.w	a4,a5
     9aa:	06c00793          	li	a5,108
     9ae:	04f71063          	bne	a4,a5,9ee <vprintf+0x13c>
     9b2:	fe442783          	lw	a5,-28(s0)
     9b6:	0007871b          	sext.w	a4,a5
     9ba:	06400793          	li	a5,100
     9be:	02f71863          	bne	a4,a5,9ee <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     9c2:	fb843783          	ld	a5,-72(s0)
     9c6:	00878713          	addi	a4,a5,8
     9ca:	fae43c23          	sd	a4,-72(s0)
     9ce:	639c                	ld	a5,0(a5)
     9d0:	873e                	mv	a4,a5
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	4685                	li	a3,1
     9d8:	4629                	li	a2,10
     9da:	85ba                	mv	a1,a4
     9dc:	853e                	mv	a0,a5
     9de:	d65ff0ef          	jal	742 <printint>
        i += 1;
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	2785                	addiw	a5,a5,1
     9e8:	fcf42e23          	sw	a5,-36(s0)
     9ec:	ae21                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     9ee:	fd442783          	lw	a5,-44(s0)
     9f2:	0007871b          	sext.w	a4,a5
     9f6:	06c00793          	li	a5,108
     9fa:	04f71863          	bne	a4,a5,a4a <vprintf+0x198>
     9fe:	fe442783          	lw	a5,-28(s0)
     a02:	0007871b          	sext.w	a4,a5
     a06:	06c00793          	li	a5,108
     a0a:	04f71063          	bne	a4,a5,a4a <vprintf+0x198>
     a0e:	fe042783          	lw	a5,-32(s0)
     a12:	0007871b          	sext.w	a4,a5
     a16:	06400793          	li	a5,100
     a1a:	02f71863          	bne	a4,a5,a4a <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a1e:	fb843783          	ld	a5,-72(s0)
     a22:	00878713          	addi	a4,a5,8
     a26:	fae43c23          	sd	a4,-72(s0)
     a2a:	639c                	ld	a5,0(a5)
     a2c:	873e                	mv	a4,a5
     a2e:	fcc42783          	lw	a5,-52(s0)
     a32:	4685                	li	a3,1
     a34:	4629                	li	a2,10
     a36:	85ba                	mv	a1,a4
     a38:	853e                	mv	a0,a5
     a3a:	d09ff0ef          	jal	742 <printint>
        i += 2;
     a3e:	fdc42783          	lw	a5,-36(s0)
     a42:	2789                	addiw	a5,a5,2
     a44:	fcf42e23          	sw	a5,-36(s0)
     a48:	ac75                	j	d04 <vprintf+0x452>
      } else if(c0 == 'u'){
     a4a:	fd442783          	lw	a5,-44(s0)
     a4e:	0007871b          	sext.w	a4,a5
     a52:	07500793          	li	a5,117
     a56:	02f71563          	bne	a4,a5,a80 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     a5a:	fb843783          	ld	a5,-72(s0)
     a5e:	00878713          	addi	a4,a5,8
     a62:	fae43c23          	sd	a4,-72(s0)
     a66:	439c                	lw	a5,0(a5)
     a68:	02079713          	slli	a4,a5,0x20
     a6c:	9301                	srli	a4,a4,0x20
     a6e:	fcc42783          	lw	a5,-52(s0)
     a72:	4681                	li	a3,0
     a74:	4629                	li	a2,10
     a76:	85ba                	mv	a1,a4
     a78:	853e                	mv	a0,a5
     a7a:	cc9ff0ef          	jal	742 <printint>
     a7e:	a459                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     a80:	fd442783          	lw	a5,-44(s0)
     a84:	0007871b          	sext.w	a4,a5
     a88:	06c00793          	li	a5,108
     a8c:	04f71063          	bne	a4,a5,acc <vprintf+0x21a>
     a90:	fe442783          	lw	a5,-28(s0)
     a94:	0007871b          	sext.w	a4,a5
     a98:	07500793          	li	a5,117
     a9c:	02f71863          	bne	a4,a5,acc <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     aa0:	fb843783          	ld	a5,-72(s0)
     aa4:	00878713          	addi	a4,a5,8
     aa8:	fae43c23          	sd	a4,-72(s0)
     aac:	639c                	ld	a5,0(a5)
     aae:	873e                	mv	a4,a5
     ab0:	fcc42783          	lw	a5,-52(s0)
     ab4:	4681                	li	a3,0
     ab6:	4629                	li	a2,10
     ab8:	85ba                	mv	a1,a4
     aba:	853e                	mv	a0,a5
     abc:	c87ff0ef          	jal	742 <printint>
        i += 1;
     ac0:	fdc42783          	lw	a5,-36(s0)
     ac4:	2785                	addiw	a5,a5,1
     ac6:	fcf42e23          	sw	a5,-36(s0)
     aca:	ac2d                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     acc:	fd442783          	lw	a5,-44(s0)
     ad0:	0007871b          	sext.w	a4,a5
     ad4:	06c00793          	li	a5,108
     ad8:	04f71863          	bne	a4,a5,b28 <vprintf+0x276>
     adc:	fe442783          	lw	a5,-28(s0)
     ae0:	0007871b          	sext.w	a4,a5
     ae4:	06c00793          	li	a5,108
     ae8:	04f71063          	bne	a4,a5,b28 <vprintf+0x276>
     aec:	fe042783          	lw	a5,-32(s0)
     af0:	0007871b          	sext.w	a4,a5
     af4:	07500793          	li	a5,117
     af8:	02f71863          	bne	a4,a5,b28 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     afc:	fb843783          	ld	a5,-72(s0)
     b00:	00878713          	addi	a4,a5,8
     b04:	fae43c23          	sd	a4,-72(s0)
     b08:	639c                	ld	a5,0(a5)
     b0a:	873e                	mv	a4,a5
     b0c:	fcc42783          	lw	a5,-52(s0)
     b10:	4681                	li	a3,0
     b12:	4629                	li	a2,10
     b14:	85ba                	mv	a1,a4
     b16:	853e                	mv	a0,a5
     b18:	c2bff0ef          	jal	742 <printint>
        i += 2;
     b1c:	fdc42783          	lw	a5,-36(s0)
     b20:	2789                	addiw	a5,a5,2
     b22:	fcf42e23          	sw	a5,-36(s0)
     b26:	aaf9                	j	d04 <vprintf+0x452>
      } else if(c0 == 'x'){
     b28:	fd442783          	lw	a5,-44(s0)
     b2c:	0007871b          	sext.w	a4,a5
     b30:	07800793          	li	a5,120
     b34:	02f71563          	bne	a4,a5,b5e <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b38:	fb843783          	ld	a5,-72(s0)
     b3c:	00878713          	addi	a4,a5,8
     b40:	fae43c23          	sd	a4,-72(s0)
     b44:	439c                	lw	a5,0(a5)
     b46:	02079713          	slli	a4,a5,0x20
     b4a:	9301                	srli	a4,a4,0x20
     b4c:	fcc42783          	lw	a5,-52(s0)
     b50:	4681                	li	a3,0
     b52:	4641                	li	a2,16
     b54:	85ba                	mv	a1,a4
     b56:	853e                	mv	a0,a5
     b58:	bebff0ef          	jal	742 <printint>
     b5c:	a265                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     b5e:	fd442783          	lw	a5,-44(s0)
     b62:	0007871b          	sext.w	a4,a5
     b66:	06c00793          	li	a5,108
     b6a:	04f71063          	bne	a4,a5,baa <vprintf+0x2f8>
     b6e:	fe442783          	lw	a5,-28(s0)
     b72:	0007871b          	sext.w	a4,a5
     b76:	07800793          	li	a5,120
     b7a:	02f71863          	bne	a4,a5,baa <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     b7e:	fb843783          	ld	a5,-72(s0)
     b82:	00878713          	addi	a4,a5,8
     b86:	fae43c23          	sd	a4,-72(s0)
     b8a:	639c                	ld	a5,0(a5)
     b8c:	873e                	mv	a4,a5
     b8e:	fcc42783          	lw	a5,-52(s0)
     b92:	4681                	li	a3,0
     b94:	4641                	li	a2,16
     b96:	85ba                	mv	a1,a4
     b98:	853e                	mv	a0,a5
     b9a:	ba9ff0ef          	jal	742 <printint>
        i += 1;
     b9e:	fdc42783          	lw	a5,-36(s0)
     ba2:	2785                	addiw	a5,a5,1
     ba4:	fcf42e23          	sw	a5,-36(s0)
     ba8:	aab1                	j	d04 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     baa:	fd442783          	lw	a5,-44(s0)
     bae:	0007871b          	sext.w	a4,a5
     bb2:	06c00793          	li	a5,108
     bb6:	04f71863          	bne	a4,a5,c06 <vprintf+0x354>
     bba:	fe442783          	lw	a5,-28(s0)
     bbe:	0007871b          	sext.w	a4,a5
     bc2:	06c00793          	li	a5,108
     bc6:	04f71063          	bne	a4,a5,c06 <vprintf+0x354>
     bca:	fe042783          	lw	a5,-32(s0)
     bce:	0007871b          	sext.w	a4,a5
     bd2:	07800793          	li	a5,120
     bd6:	02f71863          	bne	a4,a5,c06 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     bda:	fb843783          	ld	a5,-72(s0)
     bde:	00878713          	addi	a4,a5,8
     be2:	fae43c23          	sd	a4,-72(s0)
     be6:	639c                	ld	a5,0(a5)
     be8:	873e                	mv	a4,a5
     bea:	fcc42783          	lw	a5,-52(s0)
     bee:	4681                	li	a3,0
     bf0:	4641                	li	a2,16
     bf2:	85ba                	mv	a1,a4
     bf4:	853e                	mv	a0,a5
     bf6:	b4dff0ef          	jal	742 <printint>
        i += 2;
     bfa:	fdc42783          	lw	a5,-36(s0)
     bfe:	2789                	addiw	a5,a5,2
     c00:	fcf42e23          	sw	a5,-36(s0)
     c04:	a201                	j	d04 <vprintf+0x452>
      } else if(c0 == 'p'){
     c06:	fd442783          	lw	a5,-44(s0)
     c0a:	0007871b          	sext.w	a4,a5
     c0e:	07000793          	li	a5,112
     c12:	02f71063          	bne	a4,a5,c32 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c16:	fb843783          	ld	a5,-72(s0)
     c1a:	00878713          	addi	a4,a5,8
     c1e:	fae43c23          	sd	a4,-72(s0)
     c22:	6398                	ld	a4,0(a5)
     c24:	fcc42783          	lw	a5,-52(s0)
     c28:	85ba                	mv	a1,a4
     c2a:	853e                	mv	a0,a5
     c2c:	c09ff0ef          	jal	834 <printptr>
     c30:	a8d1                	j	d04 <vprintf+0x452>
      } else if(c0 == 'c'){
     c32:	fd442783          	lw	a5,-44(s0)
     c36:	0007871b          	sext.w	a4,a5
     c3a:	06300793          	li	a5,99
     c3e:	02f71263          	bne	a4,a5,c62 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c42:	fb843783          	ld	a5,-72(s0)
     c46:	00878713          	addi	a4,a5,8
     c4a:	fae43c23          	sd	a4,-72(s0)
     c4e:	439c                	lw	a5,0(a5)
     c50:	0ff7f713          	zext.b	a4,a5
     c54:	fcc42783          	lw	a5,-52(s0)
     c58:	85ba                	mv	a1,a4
     c5a:	853e                	mv	a0,a5
     c5c:	ab5ff0ef          	jal	710 <putc>
     c60:	a055                	j	d04 <vprintf+0x452>
      } else if(c0 == 's'){
     c62:	fd442783          	lw	a5,-44(s0)
     c66:	0007871b          	sext.w	a4,a5
     c6a:	07300793          	li	a5,115
     c6e:	04f71a63          	bne	a4,a5,cc2 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     c72:	fb843783          	ld	a5,-72(s0)
     c76:	00878713          	addi	a4,a5,8
     c7a:	fae43c23          	sd	a4,-72(s0)
     c7e:	639c                	ld	a5,0(a5)
     c80:	fef43423          	sd	a5,-24(s0)
     c84:	fe843783          	ld	a5,-24(s0)
     c88:	e79d                	bnez	a5,cb6 <vprintf+0x404>
          s = "(null)";
     c8a:	00000797          	auipc	a5,0x0
     c8e:	46e78793          	addi	a5,a5,1134 # 10f8 <malloc+0x18c>
     c92:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     c96:	a005                	j	cb6 <vprintf+0x404>
          putc(fd, *s);
     c98:	fe843783          	ld	a5,-24(s0)
     c9c:	0007c703          	lbu	a4,0(a5)
     ca0:	fcc42783          	lw	a5,-52(s0)
     ca4:	85ba                	mv	a1,a4
     ca6:	853e                	mv	a0,a5
     ca8:	a69ff0ef          	jal	710 <putc>
        for(; *s; s++)
     cac:	fe843783          	ld	a5,-24(s0)
     cb0:	0785                	addi	a5,a5,1
     cb2:	fef43423          	sd	a5,-24(s0)
     cb6:	fe843783          	ld	a5,-24(s0)
     cba:	0007c783          	lbu	a5,0(a5)
     cbe:	ffe9                	bnez	a5,c98 <vprintf+0x3e6>
     cc0:	a091                	j	d04 <vprintf+0x452>
      } else if(c0 == '%'){
     cc2:	fd442783          	lw	a5,-44(s0)
     cc6:	0007871b          	sext.w	a4,a5
     cca:	02500793          	li	a5,37
     cce:	00f71a63          	bne	a4,a5,ce2 <vprintf+0x430>
        putc(fd, '%');
     cd2:	fcc42783          	lw	a5,-52(s0)
     cd6:	02500593          	li	a1,37
     cda:	853e                	mv	a0,a5
     cdc:	a35ff0ef          	jal	710 <putc>
     ce0:	a015                	j	d04 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ce2:	fcc42783          	lw	a5,-52(s0)
     ce6:	02500593          	li	a1,37
     cea:	853e                	mv	a0,a5
     cec:	a25ff0ef          	jal	710 <putc>
        putc(fd, c0);
     cf0:	fd442783          	lw	a5,-44(s0)
     cf4:	0ff7f713          	zext.b	a4,a5
     cf8:	fcc42783          	lw	a5,-52(s0)
     cfc:	85ba                	mv	a1,a4
     cfe:	853e                	mv	a0,a5
     d00:	a11ff0ef          	jal	710 <putc>
      }

      state = 0;
     d04:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d08:	fdc42783          	lw	a5,-36(s0)
     d0c:	2785                	addiw	a5,a5,1
     d0e:	fcf42e23          	sw	a5,-36(s0)
     d12:	fdc42783          	lw	a5,-36(s0)
     d16:	fc043703          	ld	a4,-64(s0)
     d1a:	97ba                	add	a5,a5,a4
     d1c:	0007c783          	lbu	a5,0(a5)
     d20:	ba0799e3          	bnez	a5,8d2 <vprintf+0x20>
    }
  }
}
     d24:	0001                	nop
     d26:	0001                	nop
     d28:	60a6                	ld	ra,72(sp)
     d2a:	6406                	ld	s0,64(sp)
     d2c:	6161                	addi	sp,sp,80
     d2e:	8082                	ret

0000000000000d30 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d30:	7159                	addi	sp,sp,-112
     d32:	fc06                	sd	ra,56(sp)
     d34:	f822                	sd	s0,48(sp)
     d36:	0080                	addi	s0,sp,64
     d38:	fcb43823          	sd	a1,-48(s0)
     d3c:	e010                	sd	a2,0(s0)
     d3e:	e414                	sd	a3,8(s0)
     d40:	e818                	sd	a4,16(s0)
     d42:	ec1c                	sd	a5,24(s0)
     d44:	03043023          	sd	a6,32(s0)
     d48:	03143423          	sd	a7,40(s0)
     d4c:	87aa                	mv	a5,a0
     d4e:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d52:	03040793          	addi	a5,s0,48
     d56:	fcf43423          	sd	a5,-56(s0)
     d5a:	fc843783          	ld	a5,-56(s0)
     d5e:	fd078793          	addi	a5,a5,-48
     d62:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d66:	fe843703          	ld	a4,-24(s0)
     d6a:	fdc42783          	lw	a5,-36(s0)
     d6e:	863a                	mv	a2,a4
     d70:	fd043583          	ld	a1,-48(s0)
     d74:	853e                	mv	a0,a5
     d76:	b3dff0ef          	jal	8b2 <vprintf>
}
     d7a:	0001                	nop
     d7c:	70e2                	ld	ra,56(sp)
     d7e:	7442                	ld	s0,48(sp)
     d80:	6165                	addi	sp,sp,112
     d82:	8082                	ret

0000000000000d84 <printf>:

void
printf(const char *fmt, ...)
{
     d84:	7159                	addi	sp,sp,-112
     d86:	f406                	sd	ra,40(sp)
     d88:	f022                	sd	s0,32(sp)
     d8a:	1800                	addi	s0,sp,48
     d8c:	fca43c23          	sd	a0,-40(s0)
     d90:	e40c                	sd	a1,8(s0)
     d92:	e810                	sd	a2,16(s0)
     d94:	ec14                	sd	a3,24(s0)
     d96:	f018                	sd	a4,32(s0)
     d98:	f41c                	sd	a5,40(s0)
     d9a:	03043823          	sd	a6,48(s0)
     d9e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     da2:	04040793          	addi	a5,s0,64
     da6:	fcf43823          	sd	a5,-48(s0)
     daa:	fd043783          	ld	a5,-48(s0)
     dae:	fc878793          	addi	a5,a5,-56
     db2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     db6:	fe843783          	ld	a5,-24(s0)
     dba:	863e                	mv	a2,a5
     dbc:	fd843583          	ld	a1,-40(s0)
     dc0:	4505                	li	a0,1
     dc2:	af1ff0ef          	jal	8b2 <vprintf>
}
     dc6:	0001                	nop
     dc8:	70a2                	ld	ra,40(sp)
     dca:	7402                	ld	s0,32(sp)
     dcc:	6165                	addi	sp,sp,112
     dce:	8082                	ret

0000000000000dd0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     dd0:	7179                	addi	sp,sp,-48
     dd2:	f406                	sd	ra,40(sp)
     dd4:	f022                	sd	s0,32(sp)
     dd6:	1800                	addi	s0,sp,48
     dd8:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ddc:	fd843783          	ld	a5,-40(s0)
     de0:	17c1                	addi	a5,a5,-16
     de2:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     de6:	00001797          	auipc	a5,0x1
     dea:	44a78793          	addi	a5,a5,1098 # 2230 <freep>
     dee:	639c                	ld	a5,0(a5)
     df0:	fef43423          	sd	a5,-24(s0)
     df4:	a815                	j	e28 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     df6:	fe843783          	ld	a5,-24(s0)
     dfa:	639c                	ld	a5,0(a5)
     dfc:	fe843703          	ld	a4,-24(s0)
     e00:	00f76f63          	bltu	a4,a5,e1e <free+0x4e>
     e04:	fe043703          	ld	a4,-32(s0)
     e08:	fe843783          	ld	a5,-24(s0)
     e0c:	02e7eb63          	bltu	a5,a4,e42 <free+0x72>
     e10:	fe843783          	ld	a5,-24(s0)
     e14:	639c                	ld	a5,0(a5)
     e16:	fe043703          	ld	a4,-32(s0)
     e1a:	02f76463          	bltu	a4,a5,e42 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e1e:	fe843783          	ld	a5,-24(s0)
     e22:	639c                	ld	a5,0(a5)
     e24:	fef43423          	sd	a5,-24(s0)
     e28:	fe043703          	ld	a4,-32(s0)
     e2c:	fe843783          	ld	a5,-24(s0)
     e30:	fce7f3e3          	bgeu	a5,a4,df6 <free+0x26>
     e34:	fe843783          	ld	a5,-24(s0)
     e38:	639c                	ld	a5,0(a5)
     e3a:	fe043703          	ld	a4,-32(s0)
     e3e:	faf77ce3          	bgeu	a4,a5,df6 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e42:	fe043783          	ld	a5,-32(s0)
     e46:	479c                	lw	a5,8(a5)
     e48:	1782                	slli	a5,a5,0x20
     e4a:	9381                	srli	a5,a5,0x20
     e4c:	0792                	slli	a5,a5,0x4
     e4e:	fe043703          	ld	a4,-32(s0)
     e52:	973e                	add	a4,a4,a5
     e54:	fe843783          	ld	a5,-24(s0)
     e58:	639c                	ld	a5,0(a5)
     e5a:	02f71763          	bne	a4,a5,e88 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     e5e:	fe043783          	ld	a5,-32(s0)
     e62:	4798                	lw	a4,8(a5)
     e64:	fe843783          	ld	a5,-24(s0)
     e68:	639c                	ld	a5,0(a5)
     e6a:	479c                	lw	a5,8(a5)
     e6c:	9fb9                	addw	a5,a5,a4
     e6e:	0007871b          	sext.w	a4,a5
     e72:	fe043783          	ld	a5,-32(s0)
     e76:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	639c                	ld	a5,0(a5)
     e7e:	6398                	ld	a4,0(a5)
     e80:	fe043783          	ld	a5,-32(s0)
     e84:	e398                	sd	a4,0(a5)
     e86:	a039                	j	e94 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     e88:	fe843783          	ld	a5,-24(s0)
     e8c:	6398                	ld	a4,0(a5)
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e94:	fe843783          	ld	a5,-24(s0)
     e98:	479c                	lw	a5,8(a5)
     e9a:	1782                	slli	a5,a5,0x20
     e9c:	9381                	srli	a5,a5,0x20
     e9e:	0792                	slli	a5,a5,0x4
     ea0:	fe843703          	ld	a4,-24(s0)
     ea4:	97ba                	add	a5,a5,a4
     ea6:	fe043703          	ld	a4,-32(s0)
     eaa:	02f71563          	bne	a4,a5,ed4 <free+0x104>
    p->s.size += bp->s.size;
     eae:	fe843783          	ld	a5,-24(s0)
     eb2:	4798                	lw	a4,8(a5)
     eb4:	fe043783          	ld	a5,-32(s0)
     eb8:	479c                	lw	a5,8(a5)
     eba:	9fb9                	addw	a5,a5,a4
     ebc:	0007871b          	sext.w	a4,a5
     ec0:	fe843783          	ld	a5,-24(s0)
     ec4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ec6:	fe043783          	ld	a5,-32(s0)
     eca:	6398                	ld	a4,0(a5)
     ecc:	fe843783          	ld	a5,-24(s0)
     ed0:	e398                	sd	a4,0(a5)
     ed2:	a031                	j	ede <free+0x10e>
  } else
    p->s.ptr = bp;
     ed4:	fe843783          	ld	a5,-24(s0)
     ed8:	fe043703          	ld	a4,-32(s0)
     edc:	e398                	sd	a4,0(a5)
  freep = p;
     ede:	00001797          	auipc	a5,0x1
     ee2:	35278793          	addi	a5,a5,850 # 2230 <freep>
     ee6:	fe843703          	ld	a4,-24(s0)
     eea:	e398                	sd	a4,0(a5)
}
     eec:	0001                	nop
     eee:	70a2                	ld	ra,40(sp)
     ef0:	7402                	ld	s0,32(sp)
     ef2:	6145                	addi	sp,sp,48
     ef4:	8082                	ret

0000000000000ef6 <morecore>:

static Header*
morecore(uint nu)
{
     ef6:	7179                	addi	sp,sp,-48
     ef8:	f406                	sd	ra,40(sp)
     efa:	f022                	sd	s0,32(sp)
     efc:	1800                	addi	s0,sp,48
     efe:	87aa                	mv	a5,a0
     f00:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f04:	fdc42783          	lw	a5,-36(s0)
     f08:	0007871b          	sext.w	a4,a5
     f0c:	6785                	lui	a5,0x1
     f0e:	00f77563          	bgeu	a4,a5,f18 <morecore+0x22>
    nu = 4096;
     f12:	6785                	lui	a5,0x1
     f14:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f18:	fdc42783          	lw	a5,-36(s0)
     f1c:	0047979b          	slliw	a5,a5,0x4
     f20:	2781                	sext.w	a5,a5
     f22:	853e                	mv	a0,a5
     f24:	ee8ff0ef          	jal	60c <sbrk>
     f28:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f2c:	fe843703          	ld	a4,-24(s0)
     f30:	57fd                	li	a5,-1
     f32:	00f71463          	bne	a4,a5,f3a <morecore+0x44>
    return 0;
     f36:	4781                	li	a5,0
     f38:	a02d                	j	f62 <morecore+0x6c>
  hp = (Header*)p;
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f42:	fe043783          	ld	a5,-32(s0)
     f46:	fdc42703          	lw	a4,-36(s0)
     f4a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f4c:	fe043783          	ld	a5,-32(s0)
     f50:	07c1                	addi	a5,a5,16 # 1010 <malloc+0xa4>
     f52:	853e                	mv	a0,a5
     f54:	e7dff0ef          	jal	dd0 <free>
  return freep;
     f58:	00001797          	auipc	a5,0x1
     f5c:	2d878793          	addi	a5,a5,728 # 2230 <freep>
     f60:	639c                	ld	a5,0(a5)
}
     f62:	853e                	mv	a0,a5
     f64:	70a2                	ld	ra,40(sp)
     f66:	7402                	ld	s0,32(sp)
     f68:	6145                	addi	sp,sp,48
     f6a:	8082                	ret

0000000000000f6c <malloc>:

void*
malloc(uint nbytes)
{
     f6c:	7139                	addi	sp,sp,-64
     f6e:	fc06                	sd	ra,56(sp)
     f70:	f822                	sd	s0,48(sp)
     f72:	0080                	addi	s0,sp,64
     f74:	87aa                	mv	a5,a0
     f76:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f7a:	fcc46783          	lwu	a5,-52(s0)
     f7e:	07bd                	addi	a5,a5,15
     f80:	8391                	srli	a5,a5,0x4
     f82:	2781                	sext.w	a5,a5
     f84:	2785                	addiw	a5,a5,1
     f86:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f8a:	00001797          	auipc	a5,0x1
     f8e:	2a678793          	addi	a5,a5,678 # 2230 <freep>
     f92:	639c                	ld	a5,0(a5)
     f94:	fef43023          	sd	a5,-32(s0)
     f98:	fe043783          	ld	a5,-32(s0)
     f9c:	ef95                	bnez	a5,fd8 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f9e:	00001797          	auipc	a5,0x1
     fa2:	28278793          	addi	a5,a5,642 # 2220 <base>
     fa6:	fef43023          	sd	a5,-32(s0)
     faa:	00001797          	auipc	a5,0x1
     fae:	28678793          	addi	a5,a5,646 # 2230 <freep>
     fb2:	fe043703          	ld	a4,-32(s0)
     fb6:	e398                	sd	a4,0(a5)
     fb8:	00001797          	auipc	a5,0x1
     fbc:	27878793          	addi	a5,a5,632 # 2230 <freep>
     fc0:	6398                	ld	a4,0(a5)
     fc2:	00001797          	auipc	a5,0x1
     fc6:	25e78793          	addi	a5,a5,606 # 2220 <base>
     fca:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fcc:	00001797          	auipc	a5,0x1
     fd0:	25478793          	addi	a5,a5,596 # 2220 <base>
     fd4:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fd8:	fe043783          	ld	a5,-32(s0)
     fdc:	639c                	ld	a5,0(a5)
     fde:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fe2:	fe843783          	ld	a5,-24(s0)
     fe6:	479c                	lw	a5,8(a5)
     fe8:	fdc42703          	lw	a4,-36(s0)
     fec:	2701                	sext.w	a4,a4
     fee:	06e7e763          	bltu	a5,a4,105c <malloc+0xf0>
      if(p->s.size == nunits)
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	479c                	lw	a5,8(a5)
     ff8:	fdc42703          	lw	a4,-36(s0)
     ffc:	2701                	sext.w	a4,a4
     ffe:	00f71963          	bne	a4,a5,1010 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	6398                	ld	a4,0(a5)
    1008:	fe043783          	ld	a5,-32(s0)
    100c:	e398                	sd	a4,0(a5)
    100e:	a825                	j	1046 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	479c                	lw	a5,8(a5)
    1016:	fdc42703          	lw	a4,-36(s0)
    101a:	9f99                	subw	a5,a5,a4
    101c:	0007871b          	sext.w	a4,a5
    1020:	fe843783          	ld	a5,-24(s0)
    1024:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	479c                	lw	a5,8(a5)
    102c:	1782                	slli	a5,a5,0x20
    102e:	9381                	srli	a5,a5,0x20
    1030:	0792                	slli	a5,a5,0x4
    1032:	fe843703          	ld	a4,-24(s0)
    1036:	97ba                	add	a5,a5,a4
    1038:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	fdc42703          	lw	a4,-36(s0)
    1044:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1046:	00001797          	auipc	a5,0x1
    104a:	1ea78793          	addi	a5,a5,490 # 2230 <freep>
    104e:	fe043703          	ld	a4,-32(s0)
    1052:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1054:	fe843783          	ld	a5,-24(s0)
    1058:	07c1                	addi	a5,a5,16
    105a:	a081                	j	109a <malloc+0x12e>
    }
    if(p == freep)
    105c:	00001797          	auipc	a5,0x1
    1060:	1d478793          	addi	a5,a5,468 # 2230 <freep>
    1064:	639c                	ld	a5,0(a5)
    1066:	fe843703          	ld	a4,-24(s0)
    106a:	00f71e63          	bne	a4,a5,1086 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    106e:	fdc42783          	lw	a5,-36(s0)
    1072:	853e                	mv	a0,a5
    1074:	e83ff0ef          	jal	ef6 <morecore>
    1078:	fea43423          	sd	a0,-24(s0)
    107c:	fe843783          	ld	a5,-24(s0)
    1080:	e399                	bnez	a5,1086 <malloc+0x11a>
        return 0;
    1082:	4781                	li	a5,0
    1084:	a819                	j	109a <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1086:	fe843783          	ld	a5,-24(s0)
    108a:	fef43023          	sd	a5,-32(s0)
    108e:	fe843783          	ld	a5,-24(s0)
    1092:	639c                	ld	a5,0(a5)
    1094:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1098:	b7a9                	j	fe2 <malloc+0x76>
  }
}
    109a:	853e                	mv	a0,a5
    109c:	70e2                	ld	ra,56(sp)
    109e:	7442                	ld	s0,48(sp)
    10a0:	6121                	addi	sp,sp,64
    10a2:	8082                	ret
