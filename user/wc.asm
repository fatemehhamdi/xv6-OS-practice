
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
      12:	fe042023          	sw	zero,-32(s0)
      16:	fe042783          	lw	a5,-32(s0)
      1a:	fef42223          	sw	a5,-28(s0)
      1e:	fe442783          	lw	a5,-28(s0)
      22:	fef42423          	sw	a5,-24(s0)
  inword = 0;
      26:	fc042e23          	sw	zero,-36(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      2a:	a851                	j	be <wc+0xbe>
    for(i=0; i<n; i++){
      2c:	fe042623          	sw	zero,-20(s0)
      30:	a8b5                	j	ac <wc+0xac>
      c++;
      32:	fe042783          	lw	a5,-32(s0)
      36:	2785                	addiw	a5,a5,1
      38:	fef42023          	sw	a5,-32(s0)
      if(buf[i] == '\n')
      3c:	00002717          	auipc	a4,0x2
      40:	fe470713          	addi	a4,a4,-28 # 2020 <buf>
      44:	fec42783          	lw	a5,-20(s0)
      48:	97ba                	add	a5,a5,a4
      4a:	0007c783          	lbu	a5,0(a5)
      4e:	873e                	mv	a4,a5
      50:	47a9                	li	a5,10
      52:	00f71763          	bne	a4,a5,60 <wc+0x60>
        l++;
      56:	fe842783          	lw	a5,-24(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	fef42423          	sw	a5,-24(s0)
      if(strchr(" \r\t\n\v", buf[i]))
      60:	00002717          	auipc	a4,0x2
      64:	fc070713          	addi	a4,a4,-64 # 2020 <buf>
      68:	fec42783          	lw	a5,-20(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	0007c783          	lbu	a5,0(a5)
      72:	85be                	mv	a1,a5
      74:	00001517          	auipc	a0,0x1
      78:	0dc50513          	addi	a0,a0,220 # 1150 <malloc+0x13a>
      7c:	2fc000ef          	jal	378 <strchr>
      80:	87aa                	mv	a5,a0
      82:	c781                	beqz	a5,8a <wc+0x8a>
        inword = 0;
      84:	fc042e23          	sw	zero,-36(s0)
      88:	a829                	j	a2 <wc+0xa2>
      else if(!inword){
      8a:	fdc42783          	lw	a5,-36(s0)
      8e:	2781                	sext.w	a5,a5
      90:	eb89                	bnez	a5,a2 <wc+0xa2>
        w++;
      92:	fe442783          	lw	a5,-28(s0)
      96:	2785                	addiw	a5,a5,1
      98:	fef42223          	sw	a5,-28(s0)
        inword = 1;
      9c:	4785                	li	a5,1
      9e:	fcf42e23          	sw	a5,-36(s0)
    for(i=0; i<n; i++){
      a2:	fec42783          	lw	a5,-20(s0)
      a6:	2785                	addiw	a5,a5,1
      a8:	fef42623          	sw	a5,-20(s0)
      ac:	fec42783          	lw	a5,-20(s0)
      b0:	873e                	mv	a4,a5
      b2:	fd842783          	lw	a5,-40(s0)
      b6:	2701                	sext.w	a4,a4
      b8:	2781                	sext.w	a5,a5
      ba:	f6f74ce3          	blt	a4,a5,32 <wc+0x32>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      be:	fcc42783          	lw	a5,-52(s0)
      c2:	20000613          	li	a2,512
      c6:	00002597          	auipc	a1,0x2
      ca:	f5a58593          	addi	a1,a1,-166 # 2020 <buf>
      ce:	853e                	mv	a0,a5
      d0:	652000ef          	jal	722 <read>
      d4:	87aa                	mv	a5,a0
      d6:	fcf42c23          	sw	a5,-40(s0)
      da:	fd842783          	lw	a5,-40(s0)
      de:	2781                	sext.w	a5,a5
      e0:	f4f046e3          	bgtz	a5,2c <wc+0x2c>
      }
    }
  }
  if(n < 0){
      e4:	fd842783          	lw	a5,-40(s0)
      e8:	2781                	sext.w	a5,a5
      ea:	0007db63          	bgez	a5,100 <wc+0x100>
    printf("wc: read error\n");
      ee:	00001517          	auipc	a0,0x1
      f2:	06a50513          	addi	a0,a0,106 # 1158 <malloc+0x142>
      f6:	539000ef          	jal	e2e <printf>
    exit(1);
      fa:	4505                	li	a0,1
      fc:	60e000ef          	jal	70a <exit>
  }
  printf("%d %d %d %s\n", l, w, c, name);
     100:	fe042683          	lw	a3,-32(s0)
     104:	fe442603          	lw	a2,-28(s0)
     108:	fe842783          	lw	a5,-24(s0)
     10c:	fc043703          	ld	a4,-64(s0)
     110:	85be                	mv	a1,a5
     112:	00001517          	auipc	a0,0x1
     116:	05650513          	addi	a0,a0,86 # 1168 <malloc+0x152>
     11a:	515000ef          	jal	e2e <printf>
}
     11e:	0001                	nop
     120:	70e2                	ld	ra,56(sp)
     122:	7442                	ld	s0,48(sp)
     124:	6121                	addi	sp,sp,64
     126:	8082                	ret

0000000000000128 <main>:

int
main(int argc, char *argv[])
{
     128:	7179                	addi	sp,sp,-48
     12a:	f406                	sd	ra,40(sp)
     12c:	f022                	sd	s0,32(sp)
     12e:	1800                	addi	s0,sp,48
     130:	87aa                	mv	a5,a0
     132:	fcb43823          	sd	a1,-48(s0)
     136:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
     13a:	fdc42783          	lw	a5,-36(s0)
     13e:	0007871b          	sext.w	a4,a5
     142:	4785                	li	a5,1
     144:	00e7cc63          	blt	a5,a4,15c <main+0x34>
    wc(0, "");
     148:	00001597          	auipc	a1,0x1
     14c:	03058593          	addi	a1,a1,48 # 1178 <malloc+0x162>
     150:	4501                	li	a0,0
     152:	eafff0ef          	jal	0 <wc>
    exit(0);
     156:	4501                	li	a0,0
     158:	5b2000ef          	jal	70a <exit>
  }

  for(i = 1; i < argc; i++){
     15c:	4785                	li	a5,1
     15e:	fef42623          	sw	a5,-20(s0)
     162:	a8a5                	j	1da <main+0xb2>
    if((fd = open(argv[i], O_RDONLY)) < 0){
     164:	fec42783          	lw	a5,-20(s0)
     168:	078e                	slli	a5,a5,0x3
     16a:	fd043703          	ld	a4,-48(s0)
     16e:	97ba                	add	a5,a5,a4
     170:	639c                	ld	a5,0(a5)
     172:	4581                	li	a1,0
     174:	853e                	mv	a0,a5
     176:	5d4000ef          	jal	74a <open>
     17a:	87aa                	mv	a5,a0
     17c:	fef42423          	sw	a5,-24(s0)
     180:	fe842783          	lw	a5,-24(s0)
     184:	2781                	sext.w	a5,a5
     186:	0207d363          	bgez	a5,1ac <main+0x84>
      printf("wc: cannot open %s\n", argv[i]);
     18a:	fec42783          	lw	a5,-20(s0)
     18e:	078e                	slli	a5,a5,0x3
     190:	fd043703          	ld	a4,-48(s0)
     194:	97ba                	add	a5,a5,a4
     196:	639c                	ld	a5,0(a5)
     198:	85be                	mv	a1,a5
     19a:	00001517          	auipc	a0,0x1
     19e:	fe650513          	addi	a0,a0,-26 # 1180 <malloc+0x16a>
     1a2:	48d000ef          	jal	e2e <printf>
      exit(1);
     1a6:	4505                	li	a0,1
     1a8:	562000ef          	jal	70a <exit>
    }
    wc(fd, argv[i]);
     1ac:	fec42783          	lw	a5,-20(s0)
     1b0:	078e                	slli	a5,a5,0x3
     1b2:	fd043703          	ld	a4,-48(s0)
     1b6:	97ba                	add	a5,a5,a4
     1b8:	6398                	ld	a4,0(a5)
     1ba:	fe842783          	lw	a5,-24(s0)
     1be:	85ba                	mv	a1,a4
     1c0:	853e                	mv	a0,a5
     1c2:	e3fff0ef          	jal	0 <wc>
    close(fd);
     1c6:	fe842783          	lw	a5,-24(s0)
     1ca:	853e                	mv	a0,a5
     1cc:	566000ef          	jal	732 <close>
  for(i = 1; i < argc; i++){
     1d0:	fec42783          	lw	a5,-20(s0)
     1d4:	2785                	addiw	a5,a5,1
     1d6:	fef42623          	sw	a5,-20(s0)
     1da:	fec42783          	lw	a5,-20(s0)
     1de:	873e                	mv	a4,a5
     1e0:	fdc42783          	lw	a5,-36(s0)
     1e4:	2701                	sext.w	a4,a4
     1e6:	2781                	sext.w	a5,a5
     1e8:	f6f74ee3          	blt	a4,a5,164 <main+0x3c>
  }
  exit(0);
     1ec:	4501                	li	a0,0
     1ee:	51c000ef          	jal	70a <exit>

00000000000001f2 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     1f2:	7179                	addi	sp,sp,-48
     1f4:	f406                	sd	ra,40(sp)
     1f6:	f022                	sd	s0,32(sp)
     1f8:	1800                	addi	s0,sp,48
     1fa:	87aa                	mv	a5,a0
     1fc:	fcb43823          	sd	a1,-48(s0)
     200:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     204:	fdc42783          	lw	a5,-36(s0)
     208:	fd043583          	ld	a1,-48(s0)
     20c:	853e                	mv	a0,a5
     20e:	f1bff0ef          	jal	128 <main>
     212:	87aa                	mv	a5,a0
     214:	fef42623          	sw	a5,-20(s0)
  exit(r);
     218:	fec42783          	lw	a5,-20(s0)
     21c:	853e                	mv	a0,a5
     21e:	4ec000ef          	jal	70a <exit>

0000000000000222 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     222:	7179                	addi	sp,sp,-48
     224:	f406                	sd	ra,40(sp)
     226:	f022                	sd	s0,32(sp)
     228:	1800                	addi	s0,sp,48
     22a:	fca43c23          	sd	a0,-40(s0)
     22e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     232:	fd843783          	ld	a5,-40(s0)
     236:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     23a:	0001                	nop
     23c:	fd043703          	ld	a4,-48(s0)
     240:	00170793          	addi	a5,a4,1
     244:	fcf43823          	sd	a5,-48(s0)
     248:	fd843783          	ld	a5,-40(s0)
     24c:	00178693          	addi	a3,a5,1
     250:	fcd43c23          	sd	a3,-40(s0)
     254:	00074703          	lbu	a4,0(a4)
     258:	00e78023          	sb	a4,0(a5)
     25c:	0007c783          	lbu	a5,0(a5)
     260:	fff1                	bnez	a5,23c <strcpy+0x1a>
    ;
  return os;
     262:	fe843783          	ld	a5,-24(s0)
}
     266:	853e                	mv	a0,a5
     268:	70a2                	ld	ra,40(sp)
     26a:	7402                	ld	s0,32(sp)
     26c:	6145                	addi	sp,sp,48
     26e:	8082                	ret

0000000000000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     270:	1101                	addi	sp,sp,-32
     272:	ec06                	sd	ra,24(sp)
     274:	e822                	sd	s0,16(sp)
     276:	1000                	addi	s0,sp,32
     278:	fea43423          	sd	a0,-24(s0)
     27c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     280:	a819                	j	296 <strcmp+0x26>
    p++, q++;
     282:	fe843783          	ld	a5,-24(s0)
     286:	0785                	addi	a5,a5,1
     288:	fef43423          	sd	a5,-24(s0)
     28c:	fe043783          	ld	a5,-32(s0)
     290:	0785                	addi	a5,a5,1
     292:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     296:	fe843783          	ld	a5,-24(s0)
     29a:	0007c783          	lbu	a5,0(a5)
     29e:	cb99                	beqz	a5,2b4 <strcmp+0x44>
     2a0:	fe843783          	ld	a5,-24(s0)
     2a4:	0007c703          	lbu	a4,0(a5)
     2a8:	fe043783          	ld	a5,-32(s0)
     2ac:	0007c783          	lbu	a5,0(a5)
     2b0:	fcf709e3          	beq	a4,a5,282 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     2b4:	fe843783          	ld	a5,-24(s0)
     2b8:	0007c783          	lbu	a5,0(a5)
     2bc:	0007871b          	sext.w	a4,a5
     2c0:	fe043783          	ld	a5,-32(s0)
     2c4:	0007c783          	lbu	a5,0(a5)
     2c8:	2781                	sext.w	a5,a5
     2ca:	40f707bb          	subw	a5,a4,a5
     2ce:	2781                	sext.w	a5,a5
}
     2d0:	853e                	mv	a0,a5
     2d2:	60e2                	ld	ra,24(sp)
     2d4:	6442                	ld	s0,16(sp)
     2d6:	6105                	addi	sp,sp,32
     2d8:	8082                	ret

00000000000002da <strlen>:

uint
strlen(const char *s)
{
     2da:	7179                	addi	sp,sp,-48
     2dc:	f406                	sd	ra,40(sp)
     2de:	f022                	sd	s0,32(sp)
     2e0:	1800                	addi	s0,sp,48
     2e2:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     2e6:	fe042623          	sw	zero,-20(s0)
     2ea:	a031                	j	2f6 <strlen+0x1c>
     2ec:	fec42783          	lw	a5,-20(s0)
     2f0:	2785                	addiw	a5,a5,1
     2f2:	fef42623          	sw	a5,-20(s0)
     2f6:	fec42783          	lw	a5,-20(s0)
     2fa:	fd843703          	ld	a4,-40(s0)
     2fe:	97ba                	add	a5,a5,a4
     300:	0007c783          	lbu	a5,0(a5)
     304:	f7e5                	bnez	a5,2ec <strlen+0x12>
    ;
  return n;
     306:	fec42783          	lw	a5,-20(s0)
}
     30a:	853e                	mv	a0,a5
     30c:	70a2                	ld	ra,40(sp)
     30e:	7402                	ld	s0,32(sp)
     310:	6145                	addi	sp,sp,48
     312:	8082                	ret

0000000000000314 <memset>:

void*
memset(void *dst, int c, uint n)
{
     314:	7179                	addi	sp,sp,-48
     316:	f406                	sd	ra,40(sp)
     318:	f022                	sd	s0,32(sp)
     31a:	1800                	addi	s0,sp,48
     31c:	fca43c23          	sd	a0,-40(s0)
     320:	87ae                	mv	a5,a1
     322:	8732                	mv	a4,a2
     324:	fcf42a23          	sw	a5,-44(s0)
     328:	87ba                	mv	a5,a4
     32a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     32e:	fd843783          	ld	a5,-40(s0)
     332:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     336:	fe042623          	sw	zero,-20(s0)
     33a:	a00d                	j	35c <memset+0x48>
    cdst[i] = c;
     33c:	fec42783          	lw	a5,-20(s0)
     340:	fe043703          	ld	a4,-32(s0)
     344:	97ba                	add	a5,a5,a4
     346:	fd442703          	lw	a4,-44(s0)
     34a:	0ff77713          	zext.b	a4,a4
     34e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     352:	fec42783          	lw	a5,-20(s0)
     356:	2785                	addiw	a5,a5,1
     358:	fef42623          	sw	a5,-20(s0)
     35c:	fec42783          	lw	a5,-20(s0)
     360:	fd042703          	lw	a4,-48(s0)
     364:	2701                	sext.w	a4,a4
     366:	fce7ebe3          	bltu	a5,a4,33c <memset+0x28>
  }
  return dst;
     36a:	fd843783          	ld	a5,-40(s0)
}
     36e:	853e                	mv	a0,a5
     370:	70a2                	ld	ra,40(sp)
     372:	7402                	ld	s0,32(sp)
     374:	6145                	addi	sp,sp,48
     376:	8082                	ret

0000000000000378 <strchr>:

char*
strchr(const char *s, char c)
{
     378:	1101                	addi	sp,sp,-32
     37a:	ec06                	sd	ra,24(sp)
     37c:	e822                	sd	s0,16(sp)
     37e:	1000                	addi	s0,sp,32
     380:	fea43423          	sd	a0,-24(s0)
     384:	87ae                	mv	a5,a1
     386:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     38a:	a01d                	j	3b0 <strchr+0x38>
    if(*s == c)
     38c:	fe843783          	ld	a5,-24(s0)
     390:	0007c703          	lbu	a4,0(a5)
     394:	fe744783          	lbu	a5,-25(s0)
     398:	0ff7f793          	zext.b	a5,a5
     39c:	00e79563          	bne	a5,a4,3a6 <strchr+0x2e>
      return (char*)s;
     3a0:	fe843783          	ld	a5,-24(s0)
     3a4:	a821                	j	3bc <strchr+0x44>
  for(; *s; s++)
     3a6:	fe843783          	ld	a5,-24(s0)
     3aa:	0785                	addi	a5,a5,1
     3ac:	fef43423          	sd	a5,-24(s0)
     3b0:	fe843783          	ld	a5,-24(s0)
     3b4:	0007c783          	lbu	a5,0(a5)
     3b8:	fbf1                	bnez	a5,38c <strchr+0x14>
  return 0;
     3ba:	4781                	li	a5,0
}
     3bc:	853e                	mv	a0,a5
     3be:	60e2                	ld	ra,24(sp)
     3c0:	6442                	ld	s0,16(sp)
     3c2:	6105                	addi	sp,sp,32
     3c4:	8082                	ret

00000000000003c6 <gets>:

char*
gets(char *buf, int max)
{
     3c6:	7179                	addi	sp,sp,-48
     3c8:	f406                	sd	ra,40(sp)
     3ca:	f022                	sd	s0,32(sp)
     3cc:	1800                	addi	s0,sp,48
     3ce:	fca43c23          	sd	a0,-40(s0)
     3d2:	87ae                	mv	a5,a1
     3d4:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3d8:	fe042623          	sw	zero,-20(s0)
     3dc:	a891                	j	430 <gets+0x6a>
    cc = read(0, &c, 1);
     3de:	fe740793          	addi	a5,s0,-25
     3e2:	4605                	li	a2,1
     3e4:	85be                	mv	a1,a5
     3e6:	4501                	li	a0,0
     3e8:	33a000ef          	jal	722 <read>
     3ec:	87aa                	mv	a5,a0
     3ee:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     3f2:	fe842783          	lw	a5,-24(s0)
     3f6:	2781                	sext.w	a5,a5
     3f8:	04f05663          	blez	a5,444 <gets+0x7e>
      break;
    buf[i++] = c;
     3fc:	fec42783          	lw	a5,-20(s0)
     400:	0017871b          	addiw	a4,a5,1
     404:	fee42623          	sw	a4,-20(s0)
     408:	873e                	mv	a4,a5
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	97ba                	add	a5,a5,a4
     410:	fe744703          	lbu	a4,-25(s0)
     414:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     418:	fe744783          	lbu	a5,-25(s0)
     41c:	873e                	mv	a4,a5
     41e:	47a9                	li	a5,10
     420:	02f70363          	beq	a4,a5,446 <gets+0x80>
     424:	fe744783          	lbu	a5,-25(s0)
     428:	873e                	mv	a4,a5
     42a:	47b5                	li	a5,13
     42c:	00f70d63          	beq	a4,a5,446 <gets+0x80>
  for(i=0; i+1 < max; ){
     430:	fec42783          	lw	a5,-20(s0)
     434:	2785                	addiw	a5,a5,1
     436:	2781                	sext.w	a5,a5
     438:	fd442703          	lw	a4,-44(s0)
     43c:	2701                	sext.w	a4,a4
     43e:	fae7c0e3          	blt	a5,a4,3de <gets+0x18>
     442:	a011                	j	446 <gets+0x80>
      break;
     444:	0001                	nop
      break;
  }
  buf[i] = '\0';
     446:	fec42783          	lw	a5,-20(s0)
     44a:	fd843703          	ld	a4,-40(s0)
     44e:	97ba                	add	a5,a5,a4
     450:	00078023          	sb	zero,0(a5)
  return buf;
     454:	fd843783          	ld	a5,-40(s0)
}
     458:	853e                	mv	a0,a5
     45a:	70a2                	ld	ra,40(sp)
     45c:	7402                	ld	s0,32(sp)
     45e:	6145                	addi	sp,sp,48
     460:	8082                	ret

0000000000000462 <stat>:

int
stat(const char *n, struct stat *st)
{
     462:	7179                	addi	sp,sp,-48
     464:	f406                	sd	ra,40(sp)
     466:	f022                	sd	s0,32(sp)
     468:	1800                	addi	s0,sp,48
     46a:	fca43c23          	sd	a0,-40(s0)
     46e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     472:	4581                	li	a1,0
     474:	fd843503          	ld	a0,-40(s0)
     478:	2d2000ef          	jal	74a <open>
     47c:	87aa                	mv	a5,a0
     47e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     482:	fec42783          	lw	a5,-20(s0)
     486:	2781                	sext.w	a5,a5
     488:	0007d463          	bgez	a5,490 <stat+0x2e>
    return -1;
     48c:	57fd                	li	a5,-1
     48e:	a015                	j	4b2 <stat+0x50>
  r = fstat(fd, st);
     490:	fec42783          	lw	a5,-20(s0)
     494:	fd043583          	ld	a1,-48(s0)
     498:	853e                	mv	a0,a5
     49a:	2c8000ef          	jal	762 <fstat>
     49e:	87aa                	mv	a5,a0
     4a0:	fef42423          	sw	a5,-24(s0)
  close(fd);
     4a4:	fec42783          	lw	a5,-20(s0)
     4a8:	853e                	mv	a0,a5
     4aa:	288000ef          	jal	732 <close>
  return r;
     4ae:	fe842783          	lw	a5,-24(s0)
}
     4b2:	853e                	mv	a0,a5
     4b4:	70a2                	ld	ra,40(sp)
     4b6:	7402                	ld	s0,32(sp)
     4b8:	6145                	addi	sp,sp,48
     4ba:	8082                	ret

00000000000004bc <atoi>:

int
atoi(const char *s)
{
     4bc:	7179                	addi	sp,sp,-48
     4be:	f406                	sd	ra,40(sp)
     4c0:	f022                	sd	s0,32(sp)
     4c2:	1800                	addi	s0,sp,48
     4c4:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     4c8:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     4cc:	a81d                	j	502 <atoi+0x46>
    n = n*10 + *s++ - '0';
     4ce:	fec42783          	lw	a5,-20(s0)
     4d2:	873e                	mv	a4,a5
     4d4:	87ba                	mv	a5,a4
     4d6:	0027979b          	slliw	a5,a5,0x2
     4da:	9fb9                	addw	a5,a5,a4
     4dc:	0017979b          	slliw	a5,a5,0x1
     4e0:	0007871b          	sext.w	a4,a5
     4e4:	fd843783          	ld	a5,-40(s0)
     4e8:	00178693          	addi	a3,a5,1
     4ec:	fcd43c23          	sd	a3,-40(s0)
     4f0:	0007c783          	lbu	a5,0(a5)
     4f4:	2781                	sext.w	a5,a5
     4f6:	9fb9                	addw	a5,a5,a4
     4f8:	2781                	sext.w	a5,a5
     4fa:	fd07879b          	addiw	a5,a5,-48
     4fe:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     502:	fd843783          	ld	a5,-40(s0)
     506:	0007c783          	lbu	a5,0(a5)
     50a:	873e                	mv	a4,a5
     50c:	02f00793          	li	a5,47
     510:	00e7fb63          	bgeu	a5,a4,526 <atoi+0x6a>
     514:	fd843783          	ld	a5,-40(s0)
     518:	0007c783          	lbu	a5,0(a5)
     51c:	873e                	mv	a4,a5
     51e:	03900793          	li	a5,57
     522:	fae7f6e3          	bgeu	a5,a4,4ce <atoi+0x12>
  return n;
     526:	fec42783          	lw	a5,-20(s0)
}
     52a:	853e                	mv	a0,a5
     52c:	70a2                	ld	ra,40(sp)
     52e:	7402                	ld	s0,32(sp)
     530:	6145                	addi	sp,sp,48
     532:	8082                	ret

0000000000000534 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     534:	7139                	addi	sp,sp,-64
     536:	fc06                	sd	ra,56(sp)
     538:	f822                	sd	s0,48(sp)
     53a:	0080                	addi	s0,sp,64
     53c:	fca43c23          	sd	a0,-40(s0)
     540:	fcb43823          	sd	a1,-48(s0)
     544:	87b2                	mv	a5,a2
     546:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     54a:	fd843783          	ld	a5,-40(s0)
     54e:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     552:	fd043783          	ld	a5,-48(s0)
     556:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     55a:	fe043703          	ld	a4,-32(s0)
     55e:	fe843783          	ld	a5,-24(s0)
     562:	02e7fc63          	bgeu	a5,a4,59a <memmove+0x66>
    while(n-- > 0)
     566:	a00d                	j	588 <memmove+0x54>
      *dst++ = *src++;
     568:	fe043703          	ld	a4,-32(s0)
     56c:	00170793          	addi	a5,a4,1
     570:	fef43023          	sd	a5,-32(s0)
     574:	fe843783          	ld	a5,-24(s0)
     578:	00178693          	addi	a3,a5,1
     57c:	fed43423          	sd	a3,-24(s0)
     580:	00074703          	lbu	a4,0(a4)
     584:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     588:	fcc42783          	lw	a5,-52(s0)
     58c:	fff7871b          	addiw	a4,a5,-1
     590:	fce42623          	sw	a4,-52(s0)
     594:	fcf04ae3          	bgtz	a5,568 <memmove+0x34>
     598:	a891                	j	5ec <memmove+0xb8>
  } else {
    dst += n;
     59a:	fcc42783          	lw	a5,-52(s0)
     59e:	fe843703          	ld	a4,-24(s0)
     5a2:	97ba                	add	a5,a5,a4
     5a4:	fef43423          	sd	a5,-24(s0)
    src += n;
     5a8:	fcc42783          	lw	a5,-52(s0)
     5ac:	fe043703          	ld	a4,-32(s0)
     5b0:	97ba                	add	a5,a5,a4
     5b2:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     5b6:	a01d                	j	5dc <memmove+0xa8>
      *--dst = *--src;
     5b8:	fe043783          	ld	a5,-32(s0)
     5bc:	17fd                	addi	a5,a5,-1
     5be:	fef43023          	sd	a5,-32(s0)
     5c2:	fe843783          	ld	a5,-24(s0)
     5c6:	17fd                	addi	a5,a5,-1
     5c8:	fef43423          	sd	a5,-24(s0)
     5cc:	fe043783          	ld	a5,-32(s0)
     5d0:	0007c703          	lbu	a4,0(a5)
     5d4:	fe843783          	ld	a5,-24(s0)
     5d8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     5dc:	fcc42783          	lw	a5,-52(s0)
     5e0:	fff7871b          	addiw	a4,a5,-1
     5e4:	fce42623          	sw	a4,-52(s0)
     5e8:	fcf048e3          	bgtz	a5,5b8 <memmove+0x84>
  }
  return vdst;
     5ec:	fd843783          	ld	a5,-40(s0)
}
     5f0:	853e                	mv	a0,a5
     5f2:	70e2                	ld	ra,56(sp)
     5f4:	7442                	ld	s0,48(sp)
     5f6:	6121                	addi	sp,sp,64
     5f8:	8082                	ret

00000000000005fa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     5fa:	7139                	addi	sp,sp,-64
     5fc:	fc06                	sd	ra,56(sp)
     5fe:	f822                	sd	s0,48(sp)
     600:	0080                	addi	s0,sp,64
     602:	fca43c23          	sd	a0,-40(s0)
     606:	fcb43823          	sd	a1,-48(s0)
     60a:	87b2                	mv	a5,a2
     60c:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     610:	fd843783          	ld	a5,-40(s0)
     614:	fef43423          	sd	a5,-24(s0)
     618:	fd043783          	ld	a5,-48(s0)
     61c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     620:	a0a1                	j	668 <memcmp+0x6e>
    if (*p1 != *p2) {
     622:	fe843783          	ld	a5,-24(s0)
     626:	0007c703          	lbu	a4,0(a5)
     62a:	fe043783          	ld	a5,-32(s0)
     62e:	0007c783          	lbu	a5,0(a5)
     632:	02f70163          	beq	a4,a5,654 <memcmp+0x5a>
      return *p1 - *p2;
     636:	fe843783          	ld	a5,-24(s0)
     63a:	0007c783          	lbu	a5,0(a5)
     63e:	0007871b          	sext.w	a4,a5
     642:	fe043783          	ld	a5,-32(s0)
     646:	0007c783          	lbu	a5,0(a5)
     64a:	2781                	sext.w	a5,a5
     64c:	40f707bb          	subw	a5,a4,a5
     650:	2781                	sext.w	a5,a5
     652:	a01d                	j	678 <memcmp+0x7e>
    }
    p1++;
     654:	fe843783          	ld	a5,-24(s0)
     658:	0785                	addi	a5,a5,1
     65a:	fef43423          	sd	a5,-24(s0)
    p2++;
     65e:	fe043783          	ld	a5,-32(s0)
     662:	0785                	addi	a5,a5,1
     664:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     668:	fcc42783          	lw	a5,-52(s0)
     66c:	fff7871b          	addiw	a4,a5,-1
     670:	fce42623          	sw	a4,-52(s0)
     674:	f7dd                	bnez	a5,622 <memcmp+0x28>
  }
  return 0;
     676:	4781                	li	a5,0
}
     678:	853e                	mv	a0,a5
     67a:	70e2                	ld	ra,56(sp)
     67c:	7442                	ld	s0,48(sp)
     67e:	6121                	addi	sp,sp,64
     680:	8082                	ret

0000000000000682 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     682:	7179                	addi	sp,sp,-48
     684:	f406                	sd	ra,40(sp)
     686:	f022                	sd	s0,32(sp)
     688:	1800                	addi	s0,sp,48
     68a:	fea43423          	sd	a0,-24(s0)
     68e:	feb43023          	sd	a1,-32(s0)
     692:	87b2                	mv	a5,a2
     694:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     698:	fdc42783          	lw	a5,-36(s0)
     69c:	863e                	mv	a2,a5
     69e:	fe043583          	ld	a1,-32(s0)
     6a2:	fe843503          	ld	a0,-24(s0)
     6a6:	e8fff0ef          	jal	534 <memmove>
     6aa:	87aa                	mv	a5,a0
}
     6ac:	853e                	mv	a0,a5
     6ae:	70a2                	ld	ra,40(sp)
     6b0:	7402                	ld	s0,32(sp)
     6b2:	6145                	addi	sp,sp,48
     6b4:	8082                	ret

00000000000006b6 <sbrk>:

char *
sbrk(int n) {
     6b6:	1101                	addi	sp,sp,-32
     6b8:	ec06                	sd	ra,24(sp)
     6ba:	e822                	sd	s0,16(sp)
     6bc:	1000                	addi	s0,sp,32
     6be:	87aa                	mv	a5,a0
     6c0:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     6c4:	fec42783          	lw	a5,-20(s0)
     6c8:	4585                	li	a1,1
     6ca:	853e                	mv	a0,a5
     6cc:	0c6000ef          	jal	792 <sys_sbrk>
     6d0:	87aa                	mv	a5,a0
}
     6d2:	853e                	mv	a0,a5
     6d4:	60e2                	ld	ra,24(sp)
     6d6:	6442                	ld	s0,16(sp)
     6d8:	6105                	addi	sp,sp,32
     6da:	8082                	ret

00000000000006dc <sbrklazy>:

char *
sbrklazy(int n) {
     6dc:	1101                	addi	sp,sp,-32
     6de:	ec06                	sd	ra,24(sp)
     6e0:	e822                	sd	s0,16(sp)
     6e2:	1000                	addi	s0,sp,32
     6e4:	87aa                	mv	a5,a0
     6e6:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     6ea:	fec42783          	lw	a5,-20(s0)
     6ee:	4589                	li	a1,2
     6f0:	853e                	mv	a0,a5
     6f2:	0a0000ef          	jal	792 <sys_sbrk>
     6f6:	87aa                	mv	a5,a0
}
     6f8:	853e                	mv	a0,a5
     6fa:	60e2                	ld	ra,24(sp)
     6fc:	6442                	ld	s0,16(sp)
     6fe:	6105                	addi	sp,sp,32
     700:	8082                	ret

0000000000000702 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     702:	4885                	li	a7,1
 ecall
     704:	00000073          	ecall
 ret
     708:	8082                	ret

000000000000070a <exit>:
.global exit
exit:
 li a7, SYS_exit
     70a:	4889                	li	a7,2
 ecall
     70c:	00000073          	ecall
 ret
     710:	8082                	ret

0000000000000712 <wait>:
.global wait
wait:
 li a7, SYS_wait
     712:	488d                	li	a7,3
 ecall
     714:	00000073          	ecall
 ret
     718:	8082                	ret

000000000000071a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     71a:	4891                	li	a7,4
 ecall
     71c:	00000073          	ecall
 ret
     720:	8082                	ret

0000000000000722 <read>:
.global read
read:
 li a7, SYS_read
     722:	4895                	li	a7,5
 ecall
     724:	00000073          	ecall
 ret
     728:	8082                	ret

000000000000072a <write>:
.global write
write:
 li a7, SYS_write
     72a:	48c1                	li	a7,16
 ecall
     72c:	00000073          	ecall
 ret
     730:	8082                	ret

0000000000000732 <close>:
.global close
close:
 li a7, SYS_close
     732:	48d5                	li	a7,21
 ecall
     734:	00000073          	ecall
 ret
     738:	8082                	ret

000000000000073a <kill>:
.global kill
kill:
 li a7, SYS_kill
     73a:	4899                	li	a7,6
 ecall
     73c:	00000073          	ecall
 ret
     740:	8082                	ret

0000000000000742 <exec>:
.global exec
exec:
 li a7, SYS_exec
     742:	489d                	li	a7,7
 ecall
     744:	00000073          	ecall
 ret
     748:	8082                	ret

000000000000074a <open>:
.global open
open:
 li a7, SYS_open
     74a:	48bd                	li	a7,15
 ecall
     74c:	00000073          	ecall
 ret
     750:	8082                	ret

0000000000000752 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     752:	48c5                	li	a7,17
 ecall
     754:	00000073          	ecall
 ret
     758:	8082                	ret

000000000000075a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     75a:	48c9                	li	a7,18
 ecall
     75c:	00000073          	ecall
 ret
     760:	8082                	ret

0000000000000762 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     762:	48a1                	li	a7,8
 ecall
     764:	00000073          	ecall
 ret
     768:	8082                	ret

000000000000076a <link>:
.global link
link:
 li a7, SYS_link
     76a:	48cd                	li	a7,19
 ecall
     76c:	00000073          	ecall
 ret
     770:	8082                	ret

0000000000000772 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     772:	48d1                	li	a7,20
 ecall
     774:	00000073          	ecall
 ret
     778:	8082                	ret

000000000000077a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     77a:	48a5                	li	a7,9
 ecall
     77c:	00000073          	ecall
 ret
     780:	8082                	ret

0000000000000782 <dup>:
.global dup
dup:
 li a7, SYS_dup
     782:	48a9                	li	a7,10
 ecall
     784:	00000073          	ecall
 ret
     788:	8082                	ret

000000000000078a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     78a:	48ad                	li	a7,11
 ecall
     78c:	00000073          	ecall
 ret
     790:	8082                	ret

0000000000000792 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     792:	48b1                	li	a7,12
 ecall
     794:	00000073          	ecall
 ret
     798:	8082                	ret

000000000000079a <pause>:
.global pause
pause:
 li a7, SYS_pause
     79a:	48b5                	li	a7,13
 ecall
     79c:	00000073          	ecall
 ret
     7a0:	8082                	ret

00000000000007a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     7a2:	48b9                	li	a7,14
 ecall
     7a4:	00000073          	ecall
 ret
     7a8:	8082                	ret

00000000000007aa <top>:
.global top
top:
 li a7, SYS_top
     7aa:	48d9                	li	a7,22
 ecall
     7ac:	00000073          	ecall
 ret
     7b0:	8082                	ret

00000000000007b2 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     7b2:	48dd                	li	a7,23
 ecall
     7b4:	00000073          	ecall
 ret
     7b8:	8082                	ret

00000000000007ba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     7ba:	1101                	addi	sp,sp,-32
     7bc:	ec06                	sd	ra,24(sp)
     7be:	e822                	sd	s0,16(sp)
     7c0:	1000                	addi	s0,sp,32
     7c2:	87aa                	mv	a5,a0
     7c4:	872e                	mv	a4,a1
     7c6:	fef42623          	sw	a5,-20(s0)
     7ca:	87ba                	mv	a5,a4
     7cc:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     7d0:	feb40713          	addi	a4,s0,-21
     7d4:	fec42783          	lw	a5,-20(s0)
     7d8:	4605                	li	a2,1
     7da:	85ba                	mv	a1,a4
     7dc:	853e                	mv	a0,a5
     7de:	f4dff0ef          	jal	72a <write>
}
     7e2:	0001                	nop
     7e4:	60e2                	ld	ra,24(sp)
     7e6:	6442                	ld	s0,16(sp)
     7e8:	6105                	addi	sp,sp,32
     7ea:	8082                	ret

00000000000007ec <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     7ec:	711d                	addi	sp,sp,-96
     7ee:	ec86                	sd	ra,88(sp)
     7f0:	e8a2                	sd	s0,80(sp)
     7f2:	1080                	addi	s0,sp,96
     7f4:	87aa                	mv	a5,a0
     7f6:	fab43823          	sd	a1,-80(s0)
     7fa:	8736                	mv	a4,a3
     7fc:	faf42e23          	sw	a5,-68(s0)
     800:	87b2                	mv	a5,a2
     802:	faf42c23          	sw	a5,-72(s0)
     806:	87ba                	mv	a5,a4
     808:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     80c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     810:	fac42783          	lw	a5,-84(s0)
     814:	2781                	sext.w	a5,a5
     816:	cf99                	beqz	a5,834 <printint+0x48>
     818:	fb043783          	ld	a5,-80(s0)
     81c:	0007dc63          	bgez	a5,834 <printint+0x48>
    neg = 1;
     820:	4785                	li	a5,1
     822:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     826:	fb043783          	ld	a5,-80(s0)
     82a:	40f007b3          	neg	a5,a5
     82e:	fef43023          	sd	a5,-32(s0)
     832:	a029                	j	83c <printint+0x50>
  } else {
    x = xx;
     834:	fb043783          	ld	a5,-80(s0)
     838:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     83c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     840:	fb842783          	lw	a5,-72(s0)
     844:	fe043703          	ld	a4,-32(s0)
     848:	02f77733          	remu	a4,a4,a5
     84c:	fec42783          	lw	a5,-20(s0)
     850:	0017869b          	addiw	a3,a5,1
     854:	fed42623          	sw	a3,-20(s0)
     858:	00001697          	auipc	a3,0x1
     85c:	7a868693          	addi	a3,a3,1960 # 2000 <digits>
     860:	9736                	add	a4,a4,a3
     862:	00074703          	lbu	a4,0(a4)
     866:	17c1                	addi	a5,a5,-16
     868:	97a2                	add	a5,a5,s0
     86a:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     86e:	fb842783          	lw	a5,-72(s0)
     872:	fe043703          	ld	a4,-32(s0)
     876:	02f757b3          	divu	a5,a4,a5
     87a:	fef43023          	sd	a5,-32(s0)
     87e:	fe043783          	ld	a5,-32(s0)
     882:	ffdd                	bnez	a5,840 <printint+0x54>
  if(neg)
     884:	fe842783          	lw	a5,-24(s0)
     888:	2781                	sext.w	a5,a5
     88a:	cb95                	beqz	a5,8be <printint+0xd2>
    buf[i++] = '-';
     88c:	fec42783          	lw	a5,-20(s0)
     890:	0017871b          	addiw	a4,a5,1
     894:	fee42623          	sw	a4,-20(s0)
     898:	17c1                	addi	a5,a5,-16
     89a:	97a2                	add	a5,a5,s0
     89c:	02d00713          	li	a4,45
     8a0:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     8a4:	a829                	j	8be <printint+0xd2>
    putc(fd, buf[i]);
     8a6:	fec42783          	lw	a5,-20(s0)
     8aa:	17c1                	addi	a5,a5,-16
     8ac:	97a2                	add	a5,a5,s0
     8ae:	fd87c703          	lbu	a4,-40(a5)
     8b2:	fbc42783          	lw	a5,-68(s0)
     8b6:	85ba                	mv	a1,a4
     8b8:	853e                	mv	a0,a5
     8ba:	f01ff0ef          	jal	7ba <putc>
  while(--i >= 0)
     8be:	fec42783          	lw	a5,-20(s0)
     8c2:	37fd                	addiw	a5,a5,-1
     8c4:	fef42623          	sw	a5,-20(s0)
     8c8:	fec42783          	lw	a5,-20(s0)
     8cc:	2781                	sext.w	a5,a5
     8ce:	fc07dce3          	bgez	a5,8a6 <printint+0xba>
}
     8d2:	0001                	nop
     8d4:	0001                	nop
     8d6:	60e6                	ld	ra,88(sp)
     8d8:	6446                	ld	s0,80(sp)
     8da:	6125                	addi	sp,sp,96
     8dc:	8082                	ret

00000000000008de <printptr>:

static void
printptr(int fd, uint64 x) {
     8de:	7179                	addi	sp,sp,-48
     8e0:	f406                	sd	ra,40(sp)
     8e2:	f022                	sd	s0,32(sp)
     8e4:	1800                	addi	s0,sp,48
     8e6:	87aa                	mv	a5,a0
     8e8:	fcb43823          	sd	a1,-48(s0)
     8ec:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8f0:	fdc42783          	lw	a5,-36(s0)
     8f4:	03000593          	li	a1,48
     8f8:	853e                	mv	a0,a5
     8fa:	ec1ff0ef          	jal	7ba <putc>
  putc(fd, 'x');
     8fe:	fdc42783          	lw	a5,-36(s0)
     902:	07800593          	li	a1,120
     906:	853e                	mv	a0,a5
     908:	eb3ff0ef          	jal	7ba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     90c:	fe042623          	sw	zero,-20(s0)
     910:	a81d                	j	946 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     912:	fd043783          	ld	a5,-48(s0)
     916:	93f1                	srli	a5,a5,0x3c
     918:	00001717          	auipc	a4,0x1
     91c:	6e870713          	addi	a4,a4,1768 # 2000 <digits>
     920:	97ba                	add	a5,a5,a4
     922:	0007c703          	lbu	a4,0(a5)
     926:	fdc42783          	lw	a5,-36(s0)
     92a:	85ba                	mv	a1,a4
     92c:	853e                	mv	a0,a5
     92e:	e8dff0ef          	jal	7ba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     932:	fec42783          	lw	a5,-20(s0)
     936:	2785                	addiw	a5,a5,1
     938:	fef42623          	sw	a5,-20(s0)
     93c:	fd043783          	ld	a5,-48(s0)
     940:	0792                	slli	a5,a5,0x4
     942:	fcf43823          	sd	a5,-48(s0)
     946:	fec42703          	lw	a4,-20(s0)
     94a:	47bd                	li	a5,15
     94c:	fce7f3e3          	bgeu	a5,a4,912 <printptr+0x34>
}
     950:	0001                	nop
     952:	0001                	nop
     954:	70a2                	ld	ra,40(sp)
     956:	7402                	ld	s0,32(sp)
     958:	6145                	addi	sp,sp,48
     95a:	8082                	ret

000000000000095c <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     95c:	715d                	addi	sp,sp,-80
     95e:	e486                	sd	ra,72(sp)
     960:	e0a2                	sd	s0,64(sp)
     962:	0880                	addi	s0,sp,80
     964:	87aa                	mv	a5,a0
     966:	fcb43023          	sd	a1,-64(s0)
     96a:	fac43c23          	sd	a2,-72(s0)
     96e:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     972:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     976:	fc042e23          	sw	zero,-36(s0)
     97a:	a189                	j	dbc <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     97c:	fdc42783          	lw	a5,-36(s0)
     980:	fc043703          	ld	a4,-64(s0)
     984:	97ba                	add	a5,a5,a4
     986:	0007c783          	lbu	a5,0(a5)
     98a:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     98e:	fd842783          	lw	a5,-40(s0)
     992:	2781                	sext.w	a5,a5
     994:	eb8d                	bnez	a5,9c6 <vprintf+0x6a>
      if(c0 == '%'){
     996:	fd442783          	lw	a5,-44(s0)
     99a:	0007871b          	sext.w	a4,a5
     99e:	02500793          	li	a5,37
     9a2:	00f71763          	bne	a4,a5,9b0 <vprintf+0x54>
        state = '%';
     9a6:	02500793          	li	a5,37
     9aa:	fcf42c23          	sw	a5,-40(s0)
     9ae:	a111                	j	db2 <vprintf+0x456>
      } else {
        putc(fd, c0);
     9b0:	fd442783          	lw	a5,-44(s0)
     9b4:	0ff7f713          	zext.b	a4,a5
     9b8:	fcc42783          	lw	a5,-52(s0)
     9bc:	85ba                	mv	a1,a4
     9be:	853e                	mv	a0,a5
     9c0:	dfbff0ef          	jal	7ba <putc>
     9c4:	a6fd                	j	db2 <vprintf+0x456>
      }
    } else if(state == '%'){
     9c6:	fd842783          	lw	a5,-40(s0)
     9ca:	0007871b          	sext.w	a4,a5
     9ce:	02500793          	li	a5,37
     9d2:	3ef71063          	bne	a4,a5,db2 <vprintf+0x456>
      c1 = c2 = 0;
     9d6:	fe042023          	sw	zero,-32(s0)
     9da:	fe042783          	lw	a5,-32(s0)
     9de:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     9e2:	fd442783          	lw	a5,-44(s0)
     9e6:	2781                	sext.w	a5,a5
     9e8:	cb99                	beqz	a5,9fe <vprintf+0xa2>
     9ea:	fdc42783          	lw	a5,-36(s0)
     9ee:	0785                	addi	a5,a5,1
     9f0:	fc043703          	ld	a4,-64(s0)
     9f4:	97ba                	add	a5,a5,a4
     9f6:	0007c783          	lbu	a5,0(a5)
     9fa:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     9fe:	fe442783          	lw	a5,-28(s0)
     a02:	2781                	sext.w	a5,a5
     a04:	cb99                	beqz	a5,a1a <vprintf+0xbe>
     a06:	fdc42783          	lw	a5,-36(s0)
     a0a:	0789                	addi	a5,a5,2
     a0c:	fc043703          	ld	a4,-64(s0)
     a10:	97ba                	add	a5,a5,a4
     a12:	0007c783          	lbu	a5,0(a5)
     a16:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     a1a:	fd442783          	lw	a5,-44(s0)
     a1e:	0007871b          	sext.w	a4,a5
     a22:	06400793          	li	a5,100
     a26:	02f71363          	bne	a4,a5,a4c <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     a2a:	fb843783          	ld	a5,-72(s0)
     a2e:	00878713          	addi	a4,a5,8
     a32:	fae43c23          	sd	a4,-72(s0)
     a36:	439c                	lw	a5,0(a5)
     a38:	873e                	mv	a4,a5
     a3a:	fcc42783          	lw	a5,-52(s0)
     a3e:	4685                	li	a3,1
     a40:	4629                	li	a2,10
     a42:	85ba                	mv	a1,a4
     a44:	853e                	mv	a0,a5
     a46:	da7ff0ef          	jal	7ec <printint>
     a4a:	a695                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     a4c:	fd442783          	lw	a5,-44(s0)
     a50:	0007871b          	sext.w	a4,a5
     a54:	06c00793          	li	a5,108
     a58:	04f71063          	bne	a4,a5,a98 <vprintf+0x13c>
     a5c:	fe442783          	lw	a5,-28(s0)
     a60:	0007871b          	sext.w	a4,a5
     a64:	06400793          	li	a5,100
     a68:	02f71863          	bne	a4,a5,a98 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a6c:	fb843783          	ld	a5,-72(s0)
     a70:	00878713          	addi	a4,a5,8
     a74:	fae43c23          	sd	a4,-72(s0)
     a78:	639c                	ld	a5,0(a5)
     a7a:	873e                	mv	a4,a5
     a7c:	fcc42783          	lw	a5,-52(s0)
     a80:	4685                	li	a3,1
     a82:	4629                	li	a2,10
     a84:	85ba                	mv	a1,a4
     a86:	853e                	mv	a0,a5
     a88:	d65ff0ef          	jal	7ec <printint>
        i += 1;
     a8c:	fdc42783          	lw	a5,-36(s0)
     a90:	2785                	addiw	a5,a5,1
     a92:	fcf42e23          	sw	a5,-36(s0)
     a96:	ae21                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     a98:	fd442783          	lw	a5,-44(s0)
     a9c:	0007871b          	sext.w	a4,a5
     aa0:	06c00793          	li	a5,108
     aa4:	04f71863          	bne	a4,a5,af4 <vprintf+0x198>
     aa8:	fe442783          	lw	a5,-28(s0)
     aac:	0007871b          	sext.w	a4,a5
     ab0:	06c00793          	li	a5,108
     ab4:	04f71063          	bne	a4,a5,af4 <vprintf+0x198>
     ab8:	fe042783          	lw	a5,-32(s0)
     abc:	0007871b          	sext.w	a4,a5
     ac0:	06400793          	li	a5,100
     ac4:	02f71863          	bne	a4,a5,af4 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ac8:	fb843783          	ld	a5,-72(s0)
     acc:	00878713          	addi	a4,a5,8
     ad0:	fae43c23          	sd	a4,-72(s0)
     ad4:	639c                	ld	a5,0(a5)
     ad6:	873e                	mv	a4,a5
     ad8:	fcc42783          	lw	a5,-52(s0)
     adc:	4685                	li	a3,1
     ade:	4629                	li	a2,10
     ae0:	85ba                	mv	a1,a4
     ae2:	853e                	mv	a0,a5
     ae4:	d09ff0ef          	jal	7ec <printint>
        i += 2;
     ae8:	fdc42783          	lw	a5,-36(s0)
     aec:	2789                	addiw	a5,a5,2
     aee:	fcf42e23          	sw	a5,-36(s0)
     af2:	ac75                	j	dae <vprintf+0x452>
      } else if(c0 == 'u'){
     af4:	fd442783          	lw	a5,-44(s0)
     af8:	0007871b          	sext.w	a4,a5
     afc:	07500793          	li	a5,117
     b00:	02f71563          	bne	a4,a5,b2a <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     b04:	fb843783          	ld	a5,-72(s0)
     b08:	00878713          	addi	a4,a5,8
     b0c:	fae43c23          	sd	a4,-72(s0)
     b10:	439c                	lw	a5,0(a5)
     b12:	02079713          	slli	a4,a5,0x20
     b16:	9301                	srli	a4,a4,0x20
     b18:	fcc42783          	lw	a5,-52(s0)
     b1c:	4681                	li	a3,0
     b1e:	4629                	li	a2,10
     b20:	85ba                	mv	a1,a4
     b22:	853e                	mv	a0,a5
     b24:	cc9ff0ef          	jal	7ec <printint>
     b28:	a459                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     b2a:	fd442783          	lw	a5,-44(s0)
     b2e:	0007871b          	sext.w	a4,a5
     b32:	06c00793          	li	a5,108
     b36:	04f71063          	bne	a4,a5,b76 <vprintf+0x21a>
     b3a:	fe442783          	lw	a5,-28(s0)
     b3e:	0007871b          	sext.w	a4,a5
     b42:	07500793          	li	a5,117
     b46:	02f71863          	bne	a4,a5,b76 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b4a:	fb843783          	ld	a5,-72(s0)
     b4e:	00878713          	addi	a4,a5,8
     b52:	fae43c23          	sd	a4,-72(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	873e                	mv	a4,a5
     b5a:	fcc42783          	lw	a5,-52(s0)
     b5e:	4681                	li	a3,0
     b60:	4629                	li	a2,10
     b62:	85ba                	mv	a1,a4
     b64:	853e                	mv	a0,a5
     b66:	c87ff0ef          	jal	7ec <printint>
        i += 1;
     b6a:	fdc42783          	lw	a5,-36(s0)
     b6e:	2785                	addiw	a5,a5,1
     b70:	fcf42e23          	sw	a5,-36(s0)
     b74:	ac2d                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     b76:	fd442783          	lw	a5,-44(s0)
     b7a:	0007871b          	sext.w	a4,a5
     b7e:	06c00793          	li	a5,108
     b82:	04f71863          	bne	a4,a5,bd2 <vprintf+0x276>
     b86:	fe442783          	lw	a5,-28(s0)
     b8a:	0007871b          	sext.w	a4,a5
     b8e:	06c00793          	li	a5,108
     b92:	04f71063          	bne	a4,a5,bd2 <vprintf+0x276>
     b96:	fe042783          	lw	a5,-32(s0)
     b9a:	0007871b          	sext.w	a4,a5
     b9e:	07500793          	li	a5,117
     ba2:	02f71863          	bne	a4,a5,bd2 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ba6:	fb843783          	ld	a5,-72(s0)
     baa:	00878713          	addi	a4,a5,8
     bae:	fae43c23          	sd	a4,-72(s0)
     bb2:	639c                	ld	a5,0(a5)
     bb4:	873e                	mv	a4,a5
     bb6:	fcc42783          	lw	a5,-52(s0)
     bba:	4681                	li	a3,0
     bbc:	4629                	li	a2,10
     bbe:	85ba                	mv	a1,a4
     bc0:	853e                	mv	a0,a5
     bc2:	c2bff0ef          	jal	7ec <printint>
        i += 2;
     bc6:	fdc42783          	lw	a5,-36(s0)
     bca:	2789                	addiw	a5,a5,2
     bcc:	fcf42e23          	sw	a5,-36(s0)
     bd0:	aaf9                	j	dae <vprintf+0x452>
      } else if(c0 == 'x'){
     bd2:	fd442783          	lw	a5,-44(s0)
     bd6:	0007871b          	sext.w	a4,a5
     bda:	07800793          	li	a5,120
     bde:	02f71563          	bne	a4,a5,c08 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     be2:	fb843783          	ld	a5,-72(s0)
     be6:	00878713          	addi	a4,a5,8
     bea:	fae43c23          	sd	a4,-72(s0)
     bee:	439c                	lw	a5,0(a5)
     bf0:	02079713          	slli	a4,a5,0x20
     bf4:	9301                	srli	a4,a4,0x20
     bf6:	fcc42783          	lw	a5,-52(s0)
     bfa:	4681                	li	a3,0
     bfc:	4641                	li	a2,16
     bfe:	85ba                	mv	a1,a4
     c00:	853e                	mv	a0,a5
     c02:	bebff0ef          	jal	7ec <printint>
     c06:	a265                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     c08:	fd442783          	lw	a5,-44(s0)
     c0c:	0007871b          	sext.w	a4,a5
     c10:	06c00793          	li	a5,108
     c14:	04f71063          	bne	a4,a5,c54 <vprintf+0x2f8>
     c18:	fe442783          	lw	a5,-28(s0)
     c1c:	0007871b          	sext.w	a4,a5
     c20:	07800793          	li	a5,120
     c24:	02f71863          	bne	a4,a5,c54 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c28:	fb843783          	ld	a5,-72(s0)
     c2c:	00878713          	addi	a4,a5,8
     c30:	fae43c23          	sd	a4,-72(s0)
     c34:	639c                	ld	a5,0(a5)
     c36:	873e                	mv	a4,a5
     c38:	fcc42783          	lw	a5,-52(s0)
     c3c:	4681                	li	a3,0
     c3e:	4641                	li	a2,16
     c40:	85ba                	mv	a1,a4
     c42:	853e                	mv	a0,a5
     c44:	ba9ff0ef          	jal	7ec <printint>
        i += 1;
     c48:	fdc42783          	lw	a5,-36(s0)
     c4c:	2785                	addiw	a5,a5,1
     c4e:	fcf42e23          	sw	a5,-36(s0)
     c52:	aab1                	j	dae <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     c54:	fd442783          	lw	a5,-44(s0)
     c58:	0007871b          	sext.w	a4,a5
     c5c:	06c00793          	li	a5,108
     c60:	04f71863          	bne	a4,a5,cb0 <vprintf+0x354>
     c64:	fe442783          	lw	a5,-28(s0)
     c68:	0007871b          	sext.w	a4,a5
     c6c:	06c00793          	li	a5,108
     c70:	04f71063          	bne	a4,a5,cb0 <vprintf+0x354>
     c74:	fe042783          	lw	a5,-32(s0)
     c78:	0007871b          	sext.w	a4,a5
     c7c:	07800793          	li	a5,120
     c80:	02f71863          	bne	a4,a5,cb0 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c84:	fb843783          	ld	a5,-72(s0)
     c88:	00878713          	addi	a4,a5,8
     c8c:	fae43c23          	sd	a4,-72(s0)
     c90:	639c                	ld	a5,0(a5)
     c92:	873e                	mv	a4,a5
     c94:	fcc42783          	lw	a5,-52(s0)
     c98:	4681                	li	a3,0
     c9a:	4641                	li	a2,16
     c9c:	85ba                	mv	a1,a4
     c9e:	853e                	mv	a0,a5
     ca0:	b4dff0ef          	jal	7ec <printint>
        i += 2;
     ca4:	fdc42783          	lw	a5,-36(s0)
     ca8:	2789                	addiw	a5,a5,2
     caa:	fcf42e23          	sw	a5,-36(s0)
     cae:	a201                	j	dae <vprintf+0x452>
      } else if(c0 == 'p'){
     cb0:	fd442783          	lw	a5,-44(s0)
     cb4:	0007871b          	sext.w	a4,a5
     cb8:	07000793          	li	a5,112
     cbc:	02f71063          	bne	a4,a5,cdc <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     cc0:	fb843783          	ld	a5,-72(s0)
     cc4:	00878713          	addi	a4,a5,8
     cc8:	fae43c23          	sd	a4,-72(s0)
     ccc:	6398                	ld	a4,0(a5)
     cce:	fcc42783          	lw	a5,-52(s0)
     cd2:	85ba                	mv	a1,a4
     cd4:	853e                	mv	a0,a5
     cd6:	c09ff0ef          	jal	8de <printptr>
     cda:	a8d1                	j	dae <vprintf+0x452>
      } else if(c0 == 'c'){
     cdc:	fd442783          	lw	a5,-44(s0)
     ce0:	0007871b          	sext.w	a4,a5
     ce4:	06300793          	li	a5,99
     ce8:	02f71263          	bne	a4,a5,d0c <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     cec:	fb843783          	ld	a5,-72(s0)
     cf0:	00878713          	addi	a4,a5,8
     cf4:	fae43c23          	sd	a4,-72(s0)
     cf8:	439c                	lw	a5,0(a5)
     cfa:	0ff7f713          	zext.b	a4,a5
     cfe:	fcc42783          	lw	a5,-52(s0)
     d02:	85ba                	mv	a1,a4
     d04:	853e                	mv	a0,a5
     d06:	ab5ff0ef          	jal	7ba <putc>
     d0a:	a055                	j	dae <vprintf+0x452>
      } else if(c0 == 's'){
     d0c:	fd442783          	lw	a5,-44(s0)
     d10:	0007871b          	sext.w	a4,a5
     d14:	07300793          	li	a5,115
     d18:	04f71a63          	bne	a4,a5,d6c <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     d1c:	fb843783          	ld	a5,-72(s0)
     d20:	00878713          	addi	a4,a5,8
     d24:	fae43c23          	sd	a4,-72(s0)
     d28:	639c                	ld	a5,0(a5)
     d2a:	fef43423          	sd	a5,-24(s0)
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	e79d                	bnez	a5,d60 <vprintf+0x404>
          s = "(null)";
     d34:	00000797          	auipc	a5,0x0
     d38:	46478793          	addi	a5,a5,1124 # 1198 <malloc+0x182>
     d3c:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     d40:	a005                	j	d60 <vprintf+0x404>
          putc(fd, *s);
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	0007c703          	lbu	a4,0(a5)
     d4a:	fcc42783          	lw	a5,-52(s0)
     d4e:	85ba                	mv	a1,a4
     d50:	853e                	mv	a0,a5
     d52:	a69ff0ef          	jal	7ba <putc>
        for(; *s; s++)
     d56:	fe843783          	ld	a5,-24(s0)
     d5a:	0785                	addi	a5,a5,1
     d5c:	fef43423          	sd	a5,-24(s0)
     d60:	fe843783          	ld	a5,-24(s0)
     d64:	0007c783          	lbu	a5,0(a5)
     d68:	ffe9                	bnez	a5,d42 <vprintf+0x3e6>
     d6a:	a091                	j	dae <vprintf+0x452>
      } else if(c0 == '%'){
     d6c:	fd442783          	lw	a5,-44(s0)
     d70:	0007871b          	sext.w	a4,a5
     d74:	02500793          	li	a5,37
     d78:	00f71a63          	bne	a4,a5,d8c <vprintf+0x430>
        putc(fd, '%');
     d7c:	fcc42783          	lw	a5,-52(s0)
     d80:	02500593          	li	a1,37
     d84:	853e                	mv	a0,a5
     d86:	a35ff0ef          	jal	7ba <putc>
     d8a:	a015                	j	dae <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d8c:	fcc42783          	lw	a5,-52(s0)
     d90:	02500593          	li	a1,37
     d94:	853e                	mv	a0,a5
     d96:	a25ff0ef          	jal	7ba <putc>
        putc(fd, c0);
     d9a:	fd442783          	lw	a5,-44(s0)
     d9e:	0ff7f713          	zext.b	a4,a5
     da2:	fcc42783          	lw	a5,-52(s0)
     da6:	85ba                	mv	a1,a4
     da8:	853e                	mv	a0,a5
     daa:	a11ff0ef          	jal	7ba <putc>
      }

      state = 0;
     dae:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     db2:	fdc42783          	lw	a5,-36(s0)
     db6:	2785                	addiw	a5,a5,1
     db8:	fcf42e23          	sw	a5,-36(s0)
     dbc:	fdc42783          	lw	a5,-36(s0)
     dc0:	fc043703          	ld	a4,-64(s0)
     dc4:	97ba                	add	a5,a5,a4
     dc6:	0007c783          	lbu	a5,0(a5)
     dca:	ba0799e3          	bnez	a5,97c <vprintf+0x20>
    }
  }
}
     dce:	0001                	nop
     dd0:	0001                	nop
     dd2:	60a6                	ld	ra,72(sp)
     dd4:	6406                	ld	s0,64(sp)
     dd6:	6161                	addi	sp,sp,80
     dd8:	8082                	ret

0000000000000dda <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     dda:	7159                	addi	sp,sp,-112
     ddc:	fc06                	sd	ra,56(sp)
     dde:	f822                	sd	s0,48(sp)
     de0:	0080                	addi	s0,sp,64
     de2:	fcb43823          	sd	a1,-48(s0)
     de6:	e010                	sd	a2,0(s0)
     de8:	e414                	sd	a3,8(s0)
     dea:	e818                	sd	a4,16(s0)
     dec:	ec1c                	sd	a5,24(s0)
     dee:	03043023          	sd	a6,32(s0)
     df2:	03143423          	sd	a7,40(s0)
     df6:	87aa                	mv	a5,a0
     df8:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     dfc:	03040793          	addi	a5,s0,48
     e00:	fcf43423          	sd	a5,-56(s0)
     e04:	fc843783          	ld	a5,-56(s0)
     e08:	fd078793          	addi	a5,a5,-48
     e0c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e10:	fe843703          	ld	a4,-24(s0)
     e14:	fdc42783          	lw	a5,-36(s0)
     e18:	863a                	mv	a2,a4
     e1a:	fd043583          	ld	a1,-48(s0)
     e1e:	853e                	mv	a0,a5
     e20:	b3dff0ef          	jal	95c <vprintf>
}
     e24:	0001                	nop
     e26:	70e2                	ld	ra,56(sp)
     e28:	7442                	ld	s0,48(sp)
     e2a:	6165                	addi	sp,sp,112
     e2c:	8082                	ret

0000000000000e2e <printf>:

void
printf(const char *fmt, ...)
{
     e2e:	7159                	addi	sp,sp,-112
     e30:	f406                	sd	ra,40(sp)
     e32:	f022                	sd	s0,32(sp)
     e34:	1800                	addi	s0,sp,48
     e36:	fca43c23          	sd	a0,-40(s0)
     e3a:	e40c                	sd	a1,8(s0)
     e3c:	e810                	sd	a2,16(s0)
     e3e:	ec14                	sd	a3,24(s0)
     e40:	f018                	sd	a4,32(s0)
     e42:	f41c                	sd	a5,40(s0)
     e44:	03043823          	sd	a6,48(s0)
     e48:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e4c:	04040793          	addi	a5,s0,64
     e50:	fcf43823          	sd	a5,-48(s0)
     e54:	fd043783          	ld	a5,-48(s0)
     e58:	fc878793          	addi	a5,a5,-56
     e5c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	863e                	mv	a2,a5
     e66:	fd843583          	ld	a1,-40(s0)
     e6a:	4505                	li	a0,1
     e6c:	af1ff0ef          	jal	95c <vprintf>
}
     e70:	0001                	nop
     e72:	70a2                	ld	ra,40(sp)
     e74:	7402                	ld	s0,32(sp)
     e76:	6165                	addi	sp,sp,112
     e78:	8082                	ret

0000000000000e7a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e7a:	7179                	addi	sp,sp,-48
     e7c:	f406                	sd	ra,40(sp)
     e7e:	f022                	sd	s0,32(sp)
     e80:	1800                	addi	s0,sp,48
     e82:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e86:	fd843783          	ld	a5,-40(s0)
     e8a:	17c1                	addi	a5,a5,-16
     e8c:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e90:	00001797          	auipc	a5,0x1
     e94:	3a078793          	addi	a5,a5,928 # 2230 <freep>
     e98:	639c                	ld	a5,0(a5)
     e9a:	fef43423          	sd	a5,-24(s0)
     e9e:	a815                	j	ed2 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	639c                	ld	a5,0(a5)
     ea6:	fe843703          	ld	a4,-24(s0)
     eaa:	00f76f63          	bltu	a4,a5,ec8 <free+0x4e>
     eae:	fe043703          	ld	a4,-32(s0)
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	02e7eb63          	bltu	a5,a4,eec <free+0x72>
     eba:	fe843783          	ld	a5,-24(s0)
     ebe:	639c                	ld	a5,0(a5)
     ec0:	fe043703          	ld	a4,-32(s0)
     ec4:	02f76463          	bltu	a4,a5,eec <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ec8:	fe843783          	ld	a5,-24(s0)
     ecc:	639c                	ld	a5,0(a5)
     ece:	fef43423          	sd	a5,-24(s0)
     ed2:	fe043703          	ld	a4,-32(s0)
     ed6:	fe843783          	ld	a5,-24(s0)
     eda:	fce7f3e3          	bgeu	a5,a4,ea0 <free+0x26>
     ede:	fe843783          	ld	a5,-24(s0)
     ee2:	639c                	ld	a5,0(a5)
     ee4:	fe043703          	ld	a4,-32(s0)
     ee8:	faf77ce3          	bgeu	a4,a5,ea0 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     eec:	fe043783          	ld	a5,-32(s0)
     ef0:	479c                	lw	a5,8(a5)
     ef2:	1782                	slli	a5,a5,0x20
     ef4:	9381                	srli	a5,a5,0x20
     ef6:	0792                	slli	a5,a5,0x4
     ef8:	fe043703          	ld	a4,-32(s0)
     efc:	973e                	add	a4,a4,a5
     efe:	fe843783          	ld	a5,-24(s0)
     f02:	639c                	ld	a5,0(a5)
     f04:	02f71763          	bne	a4,a5,f32 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     f08:	fe043783          	ld	a5,-32(s0)
     f0c:	4798                	lw	a4,8(a5)
     f0e:	fe843783          	ld	a5,-24(s0)
     f12:	639c                	ld	a5,0(a5)
     f14:	479c                	lw	a5,8(a5)
     f16:	9fb9                	addw	a5,a5,a4
     f18:	0007871b          	sext.w	a4,a5
     f1c:	fe043783          	ld	a5,-32(s0)
     f20:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     f22:	fe843783          	ld	a5,-24(s0)
     f26:	639c                	ld	a5,0(a5)
     f28:	6398                	ld	a4,0(a5)
     f2a:	fe043783          	ld	a5,-32(s0)
     f2e:	e398                	sd	a4,0(a5)
     f30:	a039                	j	f3e <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     f32:	fe843783          	ld	a5,-24(s0)
     f36:	6398                	ld	a4,0(a5)
     f38:	fe043783          	ld	a5,-32(s0)
     f3c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f3e:	fe843783          	ld	a5,-24(s0)
     f42:	479c                	lw	a5,8(a5)
     f44:	1782                	slli	a5,a5,0x20
     f46:	9381                	srli	a5,a5,0x20
     f48:	0792                	slli	a5,a5,0x4
     f4a:	fe843703          	ld	a4,-24(s0)
     f4e:	97ba                	add	a5,a5,a4
     f50:	fe043703          	ld	a4,-32(s0)
     f54:	02f71563          	bne	a4,a5,f7e <free+0x104>
    p->s.size += bp->s.size;
     f58:	fe843783          	ld	a5,-24(s0)
     f5c:	4798                	lw	a4,8(a5)
     f5e:	fe043783          	ld	a5,-32(s0)
     f62:	479c                	lw	a5,8(a5)
     f64:	9fb9                	addw	a5,a5,a4
     f66:	0007871b          	sext.w	a4,a5
     f6a:	fe843783          	ld	a5,-24(s0)
     f6e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f70:	fe043783          	ld	a5,-32(s0)
     f74:	6398                	ld	a4,0(a5)
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	e398                	sd	a4,0(a5)
     f7c:	a031                	j	f88 <free+0x10e>
  } else
    p->s.ptr = bp;
     f7e:	fe843783          	ld	a5,-24(s0)
     f82:	fe043703          	ld	a4,-32(s0)
     f86:	e398                	sd	a4,0(a5)
  freep = p;
     f88:	00001797          	auipc	a5,0x1
     f8c:	2a878793          	addi	a5,a5,680 # 2230 <freep>
     f90:	fe843703          	ld	a4,-24(s0)
     f94:	e398                	sd	a4,0(a5)
}
     f96:	0001                	nop
     f98:	70a2                	ld	ra,40(sp)
     f9a:	7402                	ld	s0,32(sp)
     f9c:	6145                	addi	sp,sp,48
     f9e:	8082                	ret

0000000000000fa0 <morecore>:

static Header*
morecore(uint nu)
{
     fa0:	7179                	addi	sp,sp,-48
     fa2:	f406                	sd	ra,40(sp)
     fa4:	f022                	sd	s0,32(sp)
     fa6:	1800                	addi	s0,sp,48
     fa8:	87aa                	mv	a5,a0
     faa:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     fae:	fdc42783          	lw	a5,-36(s0)
     fb2:	0007871b          	sext.w	a4,a5
     fb6:	6785                	lui	a5,0x1
     fb8:	00f77563          	bgeu	a4,a5,fc2 <morecore+0x22>
    nu = 4096;
     fbc:	6785                	lui	a5,0x1
     fbe:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     fc2:	fdc42783          	lw	a5,-36(s0)
     fc6:	0047979b          	slliw	a5,a5,0x4
     fca:	2781                	sext.w	a5,a5
     fcc:	853e                	mv	a0,a5
     fce:	ee8ff0ef          	jal	6b6 <sbrk>
     fd2:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     fd6:	fe843703          	ld	a4,-24(s0)
     fda:	57fd                	li	a5,-1
     fdc:	00f71463          	bne	a4,a5,fe4 <morecore+0x44>
    return 0;
     fe0:	4781                	li	a5,0
     fe2:	a02d                	j	100c <morecore+0x6c>
  hp = (Header*)p;
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     fec:	fe043783          	ld	a5,-32(s0)
     ff0:	fdc42703          	lw	a4,-36(s0)
     ff4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     ff6:	fe043783          	ld	a5,-32(s0)
     ffa:	07c1                	addi	a5,a5,16 # 1010 <morecore+0x70>
     ffc:	853e                	mv	a0,a5
     ffe:	e7dff0ef          	jal	e7a <free>
  return freep;
    1002:	00001797          	auipc	a5,0x1
    1006:	22e78793          	addi	a5,a5,558 # 2230 <freep>
    100a:	639c                	ld	a5,0(a5)
}
    100c:	853e                	mv	a0,a5
    100e:	70a2                	ld	ra,40(sp)
    1010:	7402                	ld	s0,32(sp)
    1012:	6145                	addi	sp,sp,48
    1014:	8082                	ret

0000000000001016 <malloc>:

void*
malloc(uint nbytes)
{
    1016:	7139                	addi	sp,sp,-64
    1018:	fc06                	sd	ra,56(sp)
    101a:	f822                	sd	s0,48(sp)
    101c:	0080                	addi	s0,sp,64
    101e:	87aa                	mv	a5,a0
    1020:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1024:	fcc46783          	lwu	a5,-52(s0)
    1028:	07bd                	addi	a5,a5,15
    102a:	8391                	srli	a5,a5,0x4
    102c:	2781                	sext.w	a5,a5
    102e:	2785                	addiw	a5,a5,1
    1030:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1034:	00001797          	auipc	a5,0x1
    1038:	1fc78793          	addi	a5,a5,508 # 2230 <freep>
    103c:	639c                	ld	a5,0(a5)
    103e:	fef43023          	sd	a5,-32(s0)
    1042:	fe043783          	ld	a5,-32(s0)
    1046:	ef95                	bnez	a5,1082 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1048:	00001797          	auipc	a5,0x1
    104c:	1d878793          	addi	a5,a5,472 # 2220 <base>
    1050:	fef43023          	sd	a5,-32(s0)
    1054:	00001797          	auipc	a5,0x1
    1058:	1dc78793          	addi	a5,a5,476 # 2230 <freep>
    105c:	fe043703          	ld	a4,-32(s0)
    1060:	e398                	sd	a4,0(a5)
    1062:	00001797          	auipc	a5,0x1
    1066:	1ce78793          	addi	a5,a5,462 # 2230 <freep>
    106a:	6398                	ld	a4,0(a5)
    106c:	00001797          	auipc	a5,0x1
    1070:	1b478793          	addi	a5,a5,436 # 2220 <base>
    1074:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1076:	00001797          	auipc	a5,0x1
    107a:	1aa78793          	addi	a5,a5,426 # 2220 <base>
    107e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1082:	fe043783          	ld	a5,-32(s0)
    1086:	639c                	ld	a5,0(a5)
    1088:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    108c:	fe843783          	ld	a5,-24(s0)
    1090:	479c                	lw	a5,8(a5)
    1092:	fdc42703          	lw	a4,-36(s0)
    1096:	2701                	sext.w	a4,a4
    1098:	06e7e763          	bltu	a5,a4,1106 <malloc+0xf0>
      if(p->s.size == nunits)
    109c:	fe843783          	ld	a5,-24(s0)
    10a0:	479c                	lw	a5,8(a5)
    10a2:	fdc42703          	lw	a4,-36(s0)
    10a6:	2701                	sext.w	a4,a4
    10a8:	00f71963          	bne	a4,a5,10ba <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    10ac:	fe843783          	ld	a5,-24(s0)
    10b0:	6398                	ld	a4,0(a5)
    10b2:	fe043783          	ld	a5,-32(s0)
    10b6:	e398                	sd	a4,0(a5)
    10b8:	a825                	j	10f0 <malloc+0xda>
      else {
        p->s.size -= nunits;
    10ba:	fe843783          	ld	a5,-24(s0)
    10be:	479c                	lw	a5,8(a5)
    10c0:	fdc42703          	lw	a4,-36(s0)
    10c4:	9f99                	subw	a5,a5,a4
    10c6:	0007871b          	sext.w	a4,a5
    10ca:	fe843783          	ld	a5,-24(s0)
    10ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10d0:	fe843783          	ld	a5,-24(s0)
    10d4:	479c                	lw	a5,8(a5)
    10d6:	1782                	slli	a5,a5,0x20
    10d8:	9381                	srli	a5,a5,0x20
    10da:	0792                	slli	a5,a5,0x4
    10dc:	fe843703          	ld	a4,-24(s0)
    10e0:	97ba                	add	a5,a5,a4
    10e2:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10e6:	fe843783          	ld	a5,-24(s0)
    10ea:	fdc42703          	lw	a4,-36(s0)
    10ee:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10f0:	00001797          	auipc	a5,0x1
    10f4:	14078793          	addi	a5,a5,320 # 2230 <freep>
    10f8:	fe043703          	ld	a4,-32(s0)
    10fc:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10fe:	fe843783          	ld	a5,-24(s0)
    1102:	07c1                	addi	a5,a5,16
    1104:	a081                	j	1144 <malloc+0x12e>
    }
    if(p == freep)
    1106:	00001797          	auipc	a5,0x1
    110a:	12a78793          	addi	a5,a5,298 # 2230 <freep>
    110e:	639c                	ld	a5,0(a5)
    1110:	fe843703          	ld	a4,-24(s0)
    1114:	00f71e63          	bne	a4,a5,1130 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1118:	fdc42783          	lw	a5,-36(s0)
    111c:	853e                	mv	a0,a5
    111e:	e83ff0ef          	jal	fa0 <morecore>
    1122:	fea43423          	sd	a0,-24(s0)
    1126:	fe843783          	ld	a5,-24(s0)
    112a:	e399                	bnez	a5,1130 <malloc+0x11a>
        return 0;
    112c:	4781                	li	a5,0
    112e:	a819                	j	1144 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1130:	fe843783          	ld	a5,-24(s0)
    1134:	fef43023          	sd	a5,-32(s0)
    1138:	fe843783          	ld	a5,-24(s0)
    113c:	639c                	ld	a5,0(a5)
    113e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1142:	b7a9                	j	108c <malloc+0x76>
  }
}
    1144:	853e                	mv	a0,a5
    1146:	70e2                	ld	ra,56(sp)
    1148:	7442                	ld	s0,48(sp)
    114a:	6121                	addi	sp,sp,64
    114c:	8082                	ret
