
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
      78:	0dc50513          	addi	a0,a0,220 # 1150 <malloc+0x142>
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
      f2:	06a50513          	addi	a0,a0,106 # 1158 <malloc+0x14a>
      f6:	531000ef          	jal	e26 <printf>
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
     116:	05650513          	addi	a0,a0,86 # 1168 <malloc+0x15a>
     11a:	50d000ef          	jal	e26 <printf>
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
     14c:	03058593          	addi	a1,a1,48 # 1178 <malloc+0x16a>
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
     19e:	fe650513          	addi	a0,a0,-26 # 1180 <malloc+0x172>
     1a2:	485000ef          	jal	e26 <printf>
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

00000000000007b2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     7b2:	1101                	addi	sp,sp,-32
     7b4:	ec06                	sd	ra,24(sp)
     7b6:	e822                	sd	s0,16(sp)
     7b8:	1000                	addi	s0,sp,32
     7ba:	87aa                	mv	a5,a0
     7bc:	872e                	mv	a4,a1
     7be:	fef42623          	sw	a5,-20(s0)
     7c2:	87ba                	mv	a5,a4
     7c4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     7c8:	feb40713          	addi	a4,s0,-21
     7cc:	fec42783          	lw	a5,-20(s0)
     7d0:	4605                	li	a2,1
     7d2:	85ba                	mv	a1,a4
     7d4:	853e                	mv	a0,a5
     7d6:	f55ff0ef          	jal	72a <write>
}
     7da:	0001                	nop
     7dc:	60e2                	ld	ra,24(sp)
     7de:	6442                	ld	s0,16(sp)
     7e0:	6105                	addi	sp,sp,32
     7e2:	8082                	ret

00000000000007e4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     7e4:	711d                	addi	sp,sp,-96
     7e6:	ec86                	sd	ra,88(sp)
     7e8:	e8a2                	sd	s0,80(sp)
     7ea:	1080                	addi	s0,sp,96
     7ec:	87aa                	mv	a5,a0
     7ee:	fab43823          	sd	a1,-80(s0)
     7f2:	8736                	mv	a4,a3
     7f4:	faf42e23          	sw	a5,-68(s0)
     7f8:	87b2                	mv	a5,a2
     7fa:	faf42c23          	sw	a5,-72(s0)
     7fe:	87ba                	mv	a5,a4
     800:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     804:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     808:	fac42783          	lw	a5,-84(s0)
     80c:	2781                	sext.w	a5,a5
     80e:	cf99                	beqz	a5,82c <printint+0x48>
     810:	fb043783          	ld	a5,-80(s0)
     814:	0007dc63          	bgez	a5,82c <printint+0x48>
    neg = 1;
     818:	4785                	li	a5,1
     81a:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     81e:	fb043783          	ld	a5,-80(s0)
     822:	40f007b3          	neg	a5,a5
     826:	fef43023          	sd	a5,-32(s0)
     82a:	a029                	j	834 <printint+0x50>
  } else {
    x = xx;
     82c:	fb043783          	ld	a5,-80(s0)
     830:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     834:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     838:	fb842783          	lw	a5,-72(s0)
     83c:	fe043703          	ld	a4,-32(s0)
     840:	02f77733          	remu	a4,a4,a5
     844:	fec42783          	lw	a5,-20(s0)
     848:	0017869b          	addiw	a3,a5,1
     84c:	fed42623          	sw	a3,-20(s0)
     850:	00001697          	auipc	a3,0x1
     854:	7b068693          	addi	a3,a3,1968 # 2000 <digits>
     858:	9736                	add	a4,a4,a3
     85a:	00074703          	lbu	a4,0(a4)
     85e:	17c1                	addi	a5,a5,-16
     860:	97a2                	add	a5,a5,s0
     862:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     866:	fb842783          	lw	a5,-72(s0)
     86a:	fe043703          	ld	a4,-32(s0)
     86e:	02f757b3          	divu	a5,a4,a5
     872:	fef43023          	sd	a5,-32(s0)
     876:	fe043783          	ld	a5,-32(s0)
     87a:	ffdd                	bnez	a5,838 <printint+0x54>
  if(neg)
     87c:	fe842783          	lw	a5,-24(s0)
     880:	2781                	sext.w	a5,a5
     882:	cb95                	beqz	a5,8b6 <printint+0xd2>
    buf[i++] = '-';
     884:	fec42783          	lw	a5,-20(s0)
     888:	0017871b          	addiw	a4,a5,1
     88c:	fee42623          	sw	a4,-20(s0)
     890:	17c1                	addi	a5,a5,-16
     892:	97a2                	add	a5,a5,s0
     894:	02d00713          	li	a4,45
     898:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     89c:	a829                	j	8b6 <printint+0xd2>
    putc(fd, buf[i]);
     89e:	fec42783          	lw	a5,-20(s0)
     8a2:	17c1                	addi	a5,a5,-16
     8a4:	97a2                	add	a5,a5,s0
     8a6:	fd87c703          	lbu	a4,-40(a5)
     8aa:	fbc42783          	lw	a5,-68(s0)
     8ae:	85ba                	mv	a1,a4
     8b0:	853e                	mv	a0,a5
     8b2:	f01ff0ef          	jal	7b2 <putc>
  while(--i >= 0)
     8b6:	fec42783          	lw	a5,-20(s0)
     8ba:	37fd                	addiw	a5,a5,-1
     8bc:	fef42623          	sw	a5,-20(s0)
     8c0:	fec42783          	lw	a5,-20(s0)
     8c4:	2781                	sext.w	a5,a5
     8c6:	fc07dce3          	bgez	a5,89e <printint+0xba>
}
     8ca:	0001                	nop
     8cc:	0001                	nop
     8ce:	60e6                	ld	ra,88(sp)
     8d0:	6446                	ld	s0,80(sp)
     8d2:	6125                	addi	sp,sp,96
     8d4:	8082                	ret

00000000000008d6 <printptr>:

static void
printptr(int fd, uint64 x) {
     8d6:	7179                	addi	sp,sp,-48
     8d8:	f406                	sd	ra,40(sp)
     8da:	f022                	sd	s0,32(sp)
     8dc:	1800                	addi	s0,sp,48
     8de:	87aa                	mv	a5,a0
     8e0:	fcb43823          	sd	a1,-48(s0)
     8e4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8e8:	fdc42783          	lw	a5,-36(s0)
     8ec:	03000593          	li	a1,48
     8f0:	853e                	mv	a0,a5
     8f2:	ec1ff0ef          	jal	7b2 <putc>
  putc(fd, 'x');
     8f6:	fdc42783          	lw	a5,-36(s0)
     8fa:	07800593          	li	a1,120
     8fe:	853e                	mv	a0,a5
     900:	eb3ff0ef          	jal	7b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     904:	fe042623          	sw	zero,-20(s0)
     908:	a81d                	j	93e <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     90a:	fd043783          	ld	a5,-48(s0)
     90e:	93f1                	srli	a5,a5,0x3c
     910:	00001717          	auipc	a4,0x1
     914:	6f070713          	addi	a4,a4,1776 # 2000 <digits>
     918:	97ba                	add	a5,a5,a4
     91a:	0007c703          	lbu	a4,0(a5)
     91e:	fdc42783          	lw	a5,-36(s0)
     922:	85ba                	mv	a1,a4
     924:	853e                	mv	a0,a5
     926:	e8dff0ef          	jal	7b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     92a:	fec42783          	lw	a5,-20(s0)
     92e:	2785                	addiw	a5,a5,1
     930:	fef42623          	sw	a5,-20(s0)
     934:	fd043783          	ld	a5,-48(s0)
     938:	0792                	slli	a5,a5,0x4
     93a:	fcf43823          	sd	a5,-48(s0)
     93e:	fec42703          	lw	a4,-20(s0)
     942:	47bd                	li	a5,15
     944:	fce7f3e3          	bgeu	a5,a4,90a <printptr+0x34>
}
     948:	0001                	nop
     94a:	0001                	nop
     94c:	70a2                	ld	ra,40(sp)
     94e:	7402                	ld	s0,32(sp)
     950:	6145                	addi	sp,sp,48
     952:	8082                	ret

0000000000000954 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     954:	715d                	addi	sp,sp,-80
     956:	e486                	sd	ra,72(sp)
     958:	e0a2                	sd	s0,64(sp)
     95a:	0880                	addi	s0,sp,80
     95c:	87aa                	mv	a5,a0
     95e:	fcb43023          	sd	a1,-64(s0)
     962:	fac43c23          	sd	a2,-72(s0)
     966:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     96a:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     96e:	fc042e23          	sw	zero,-36(s0)
     972:	a189                	j	db4 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     974:	fdc42783          	lw	a5,-36(s0)
     978:	fc043703          	ld	a4,-64(s0)
     97c:	97ba                	add	a5,a5,a4
     97e:	0007c783          	lbu	a5,0(a5)
     982:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     986:	fd842783          	lw	a5,-40(s0)
     98a:	2781                	sext.w	a5,a5
     98c:	eb8d                	bnez	a5,9be <vprintf+0x6a>
      if(c0 == '%'){
     98e:	fd442783          	lw	a5,-44(s0)
     992:	0007871b          	sext.w	a4,a5
     996:	02500793          	li	a5,37
     99a:	00f71763          	bne	a4,a5,9a8 <vprintf+0x54>
        state = '%';
     99e:	02500793          	li	a5,37
     9a2:	fcf42c23          	sw	a5,-40(s0)
     9a6:	a111                	j	daa <vprintf+0x456>
      } else {
        putc(fd, c0);
     9a8:	fd442783          	lw	a5,-44(s0)
     9ac:	0ff7f713          	zext.b	a4,a5
     9b0:	fcc42783          	lw	a5,-52(s0)
     9b4:	85ba                	mv	a1,a4
     9b6:	853e                	mv	a0,a5
     9b8:	dfbff0ef          	jal	7b2 <putc>
     9bc:	a6fd                	j	daa <vprintf+0x456>
      }
    } else if(state == '%'){
     9be:	fd842783          	lw	a5,-40(s0)
     9c2:	0007871b          	sext.w	a4,a5
     9c6:	02500793          	li	a5,37
     9ca:	3ef71063          	bne	a4,a5,daa <vprintf+0x456>
      c1 = c2 = 0;
     9ce:	fe042023          	sw	zero,-32(s0)
     9d2:	fe042783          	lw	a5,-32(s0)
     9d6:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     9da:	fd442783          	lw	a5,-44(s0)
     9de:	2781                	sext.w	a5,a5
     9e0:	cb99                	beqz	a5,9f6 <vprintf+0xa2>
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	0785                	addi	a5,a5,1
     9e8:	fc043703          	ld	a4,-64(s0)
     9ec:	97ba                	add	a5,a5,a4
     9ee:	0007c783          	lbu	a5,0(a5)
     9f2:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     9f6:	fe442783          	lw	a5,-28(s0)
     9fa:	2781                	sext.w	a5,a5
     9fc:	cb99                	beqz	a5,a12 <vprintf+0xbe>
     9fe:	fdc42783          	lw	a5,-36(s0)
     a02:	0789                	addi	a5,a5,2
     a04:	fc043703          	ld	a4,-64(s0)
     a08:	97ba                	add	a5,a5,a4
     a0a:	0007c783          	lbu	a5,0(a5)
     a0e:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     a12:	fd442783          	lw	a5,-44(s0)
     a16:	0007871b          	sext.w	a4,a5
     a1a:	06400793          	li	a5,100
     a1e:	02f71363          	bne	a4,a5,a44 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     a22:	fb843783          	ld	a5,-72(s0)
     a26:	00878713          	addi	a4,a5,8
     a2a:	fae43c23          	sd	a4,-72(s0)
     a2e:	439c                	lw	a5,0(a5)
     a30:	873e                	mv	a4,a5
     a32:	fcc42783          	lw	a5,-52(s0)
     a36:	4685                	li	a3,1
     a38:	4629                	li	a2,10
     a3a:	85ba                	mv	a1,a4
     a3c:	853e                	mv	a0,a5
     a3e:	da7ff0ef          	jal	7e4 <printint>
     a42:	a695                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     a44:	fd442783          	lw	a5,-44(s0)
     a48:	0007871b          	sext.w	a4,a5
     a4c:	06c00793          	li	a5,108
     a50:	04f71063          	bne	a4,a5,a90 <vprintf+0x13c>
     a54:	fe442783          	lw	a5,-28(s0)
     a58:	0007871b          	sext.w	a4,a5
     a5c:	06400793          	li	a5,100
     a60:	02f71863          	bne	a4,a5,a90 <vprintf+0x13c>
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
     a80:	d65ff0ef          	jal	7e4 <printint>
        i += 1;
     a84:	fdc42783          	lw	a5,-36(s0)
     a88:	2785                	addiw	a5,a5,1
     a8a:	fcf42e23          	sw	a5,-36(s0)
     a8e:	ae21                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     a90:	fd442783          	lw	a5,-44(s0)
     a94:	0007871b          	sext.w	a4,a5
     a98:	06c00793          	li	a5,108
     a9c:	04f71863          	bne	a4,a5,aec <vprintf+0x198>
     aa0:	fe442783          	lw	a5,-28(s0)
     aa4:	0007871b          	sext.w	a4,a5
     aa8:	06c00793          	li	a5,108
     aac:	04f71063          	bne	a4,a5,aec <vprintf+0x198>
     ab0:	fe042783          	lw	a5,-32(s0)
     ab4:	0007871b          	sext.w	a4,a5
     ab8:	06400793          	li	a5,100
     abc:	02f71863          	bne	a4,a5,aec <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ac0:	fb843783          	ld	a5,-72(s0)
     ac4:	00878713          	addi	a4,a5,8
     ac8:	fae43c23          	sd	a4,-72(s0)
     acc:	639c                	ld	a5,0(a5)
     ace:	873e                	mv	a4,a5
     ad0:	fcc42783          	lw	a5,-52(s0)
     ad4:	4685                	li	a3,1
     ad6:	4629                	li	a2,10
     ad8:	85ba                	mv	a1,a4
     ada:	853e                	mv	a0,a5
     adc:	d09ff0ef          	jal	7e4 <printint>
        i += 2;
     ae0:	fdc42783          	lw	a5,-36(s0)
     ae4:	2789                	addiw	a5,a5,2
     ae6:	fcf42e23          	sw	a5,-36(s0)
     aea:	ac75                	j	da6 <vprintf+0x452>
      } else if(c0 == 'u'){
     aec:	fd442783          	lw	a5,-44(s0)
     af0:	0007871b          	sext.w	a4,a5
     af4:	07500793          	li	a5,117
     af8:	02f71563          	bne	a4,a5,b22 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     afc:	fb843783          	ld	a5,-72(s0)
     b00:	00878713          	addi	a4,a5,8
     b04:	fae43c23          	sd	a4,-72(s0)
     b08:	439c                	lw	a5,0(a5)
     b0a:	02079713          	slli	a4,a5,0x20
     b0e:	9301                	srli	a4,a4,0x20
     b10:	fcc42783          	lw	a5,-52(s0)
     b14:	4681                	li	a3,0
     b16:	4629                	li	a2,10
     b18:	85ba                	mv	a1,a4
     b1a:	853e                	mv	a0,a5
     b1c:	cc9ff0ef          	jal	7e4 <printint>
     b20:	a459                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     b22:	fd442783          	lw	a5,-44(s0)
     b26:	0007871b          	sext.w	a4,a5
     b2a:	06c00793          	li	a5,108
     b2e:	04f71063          	bne	a4,a5,b6e <vprintf+0x21a>
     b32:	fe442783          	lw	a5,-28(s0)
     b36:	0007871b          	sext.w	a4,a5
     b3a:	07500793          	li	a5,117
     b3e:	02f71863          	bne	a4,a5,b6e <vprintf+0x21a>
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
     b5e:	c87ff0ef          	jal	7e4 <printint>
        i += 1;
     b62:	fdc42783          	lw	a5,-36(s0)
     b66:	2785                	addiw	a5,a5,1
     b68:	fcf42e23          	sw	a5,-36(s0)
     b6c:	ac2d                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     b6e:	fd442783          	lw	a5,-44(s0)
     b72:	0007871b          	sext.w	a4,a5
     b76:	06c00793          	li	a5,108
     b7a:	04f71863          	bne	a4,a5,bca <vprintf+0x276>
     b7e:	fe442783          	lw	a5,-28(s0)
     b82:	0007871b          	sext.w	a4,a5
     b86:	06c00793          	li	a5,108
     b8a:	04f71063          	bne	a4,a5,bca <vprintf+0x276>
     b8e:	fe042783          	lw	a5,-32(s0)
     b92:	0007871b          	sext.w	a4,a5
     b96:	07500793          	li	a5,117
     b9a:	02f71863          	bne	a4,a5,bca <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b9e:	fb843783          	ld	a5,-72(s0)
     ba2:	00878713          	addi	a4,a5,8
     ba6:	fae43c23          	sd	a4,-72(s0)
     baa:	639c                	ld	a5,0(a5)
     bac:	873e                	mv	a4,a5
     bae:	fcc42783          	lw	a5,-52(s0)
     bb2:	4681                	li	a3,0
     bb4:	4629                	li	a2,10
     bb6:	85ba                	mv	a1,a4
     bb8:	853e                	mv	a0,a5
     bba:	c2bff0ef          	jal	7e4 <printint>
        i += 2;
     bbe:	fdc42783          	lw	a5,-36(s0)
     bc2:	2789                	addiw	a5,a5,2
     bc4:	fcf42e23          	sw	a5,-36(s0)
     bc8:	aaf9                	j	da6 <vprintf+0x452>
      } else if(c0 == 'x'){
     bca:	fd442783          	lw	a5,-44(s0)
     bce:	0007871b          	sext.w	a4,a5
     bd2:	07800793          	li	a5,120
     bd6:	02f71563          	bne	a4,a5,c00 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     bda:	fb843783          	ld	a5,-72(s0)
     bde:	00878713          	addi	a4,a5,8
     be2:	fae43c23          	sd	a4,-72(s0)
     be6:	439c                	lw	a5,0(a5)
     be8:	02079713          	slli	a4,a5,0x20
     bec:	9301                	srli	a4,a4,0x20
     bee:	fcc42783          	lw	a5,-52(s0)
     bf2:	4681                	li	a3,0
     bf4:	4641                	li	a2,16
     bf6:	85ba                	mv	a1,a4
     bf8:	853e                	mv	a0,a5
     bfa:	bebff0ef          	jal	7e4 <printint>
     bfe:	a265                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     c00:	fd442783          	lw	a5,-44(s0)
     c04:	0007871b          	sext.w	a4,a5
     c08:	06c00793          	li	a5,108
     c0c:	04f71063          	bne	a4,a5,c4c <vprintf+0x2f8>
     c10:	fe442783          	lw	a5,-28(s0)
     c14:	0007871b          	sext.w	a4,a5
     c18:	07800793          	li	a5,120
     c1c:	02f71863          	bne	a4,a5,c4c <vprintf+0x2f8>
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
     c3c:	ba9ff0ef          	jal	7e4 <printint>
        i += 1;
     c40:	fdc42783          	lw	a5,-36(s0)
     c44:	2785                	addiw	a5,a5,1
     c46:	fcf42e23          	sw	a5,-36(s0)
     c4a:	aab1                	j	da6 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     c4c:	fd442783          	lw	a5,-44(s0)
     c50:	0007871b          	sext.w	a4,a5
     c54:	06c00793          	li	a5,108
     c58:	04f71863          	bne	a4,a5,ca8 <vprintf+0x354>
     c5c:	fe442783          	lw	a5,-28(s0)
     c60:	0007871b          	sext.w	a4,a5
     c64:	06c00793          	li	a5,108
     c68:	04f71063          	bne	a4,a5,ca8 <vprintf+0x354>
     c6c:	fe042783          	lw	a5,-32(s0)
     c70:	0007871b          	sext.w	a4,a5
     c74:	07800793          	li	a5,120
     c78:	02f71863          	bne	a4,a5,ca8 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c7c:	fb843783          	ld	a5,-72(s0)
     c80:	00878713          	addi	a4,a5,8
     c84:	fae43c23          	sd	a4,-72(s0)
     c88:	639c                	ld	a5,0(a5)
     c8a:	873e                	mv	a4,a5
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	4681                	li	a3,0
     c92:	4641                	li	a2,16
     c94:	85ba                	mv	a1,a4
     c96:	853e                	mv	a0,a5
     c98:	b4dff0ef          	jal	7e4 <printint>
        i += 2;
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	2789                	addiw	a5,a5,2
     ca2:	fcf42e23          	sw	a5,-36(s0)
     ca6:	a201                	j	da6 <vprintf+0x452>
      } else if(c0 == 'p'){
     ca8:	fd442783          	lw	a5,-44(s0)
     cac:	0007871b          	sext.w	a4,a5
     cb0:	07000793          	li	a5,112
     cb4:	02f71063          	bne	a4,a5,cd4 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     cb8:	fb843783          	ld	a5,-72(s0)
     cbc:	00878713          	addi	a4,a5,8
     cc0:	fae43c23          	sd	a4,-72(s0)
     cc4:	6398                	ld	a4,0(a5)
     cc6:	fcc42783          	lw	a5,-52(s0)
     cca:	85ba                	mv	a1,a4
     ccc:	853e                	mv	a0,a5
     cce:	c09ff0ef          	jal	8d6 <printptr>
     cd2:	a8d1                	j	da6 <vprintf+0x452>
      } else if(c0 == 'c'){
     cd4:	fd442783          	lw	a5,-44(s0)
     cd8:	0007871b          	sext.w	a4,a5
     cdc:	06300793          	li	a5,99
     ce0:	02f71263          	bne	a4,a5,d04 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     ce4:	fb843783          	ld	a5,-72(s0)
     ce8:	00878713          	addi	a4,a5,8
     cec:	fae43c23          	sd	a4,-72(s0)
     cf0:	439c                	lw	a5,0(a5)
     cf2:	0ff7f713          	zext.b	a4,a5
     cf6:	fcc42783          	lw	a5,-52(s0)
     cfa:	85ba                	mv	a1,a4
     cfc:	853e                	mv	a0,a5
     cfe:	ab5ff0ef          	jal	7b2 <putc>
     d02:	a055                	j	da6 <vprintf+0x452>
      } else if(c0 == 's'){
     d04:	fd442783          	lw	a5,-44(s0)
     d08:	0007871b          	sext.w	a4,a5
     d0c:	07300793          	li	a5,115
     d10:	04f71a63          	bne	a4,a5,d64 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     d14:	fb843783          	ld	a5,-72(s0)
     d18:	00878713          	addi	a4,a5,8
     d1c:	fae43c23          	sd	a4,-72(s0)
     d20:	639c                	ld	a5,0(a5)
     d22:	fef43423          	sd	a5,-24(s0)
     d26:	fe843783          	ld	a5,-24(s0)
     d2a:	e79d                	bnez	a5,d58 <vprintf+0x404>
          s = "(null)";
     d2c:	00000797          	auipc	a5,0x0
     d30:	46c78793          	addi	a5,a5,1132 # 1198 <malloc+0x18a>
     d34:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     d38:	a005                	j	d58 <vprintf+0x404>
          putc(fd, *s);
     d3a:	fe843783          	ld	a5,-24(s0)
     d3e:	0007c703          	lbu	a4,0(a5)
     d42:	fcc42783          	lw	a5,-52(s0)
     d46:	85ba                	mv	a1,a4
     d48:	853e                	mv	a0,a5
     d4a:	a69ff0ef          	jal	7b2 <putc>
        for(; *s; s++)
     d4e:	fe843783          	ld	a5,-24(s0)
     d52:	0785                	addi	a5,a5,1
     d54:	fef43423          	sd	a5,-24(s0)
     d58:	fe843783          	ld	a5,-24(s0)
     d5c:	0007c783          	lbu	a5,0(a5)
     d60:	ffe9                	bnez	a5,d3a <vprintf+0x3e6>
     d62:	a091                	j	da6 <vprintf+0x452>
      } else if(c0 == '%'){
     d64:	fd442783          	lw	a5,-44(s0)
     d68:	0007871b          	sext.w	a4,a5
     d6c:	02500793          	li	a5,37
     d70:	00f71a63          	bne	a4,a5,d84 <vprintf+0x430>
        putc(fd, '%');
     d74:	fcc42783          	lw	a5,-52(s0)
     d78:	02500593          	li	a1,37
     d7c:	853e                	mv	a0,a5
     d7e:	a35ff0ef          	jal	7b2 <putc>
     d82:	a015                	j	da6 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d84:	fcc42783          	lw	a5,-52(s0)
     d88:	02500593          	li	a1,37
     d8c:	853e                	mv	a0,a5
     d8e:	a25ff0ef          	jal	7b2 <putc>
        putc(fd, c0);
     d92:	fd442783          	lw	a5,-44(s0)
     d96:	0ff7f713          	zext.b	a4,a5
     d9a:	fcc42783          	lw	a5,-52(s0)
     d9e:	85ba                	mv	a1,a4
     da0:	853e                	mv	a0,a5
     da2:	a11ff0ef          	jal	7b2 <putc>
      }

      state = 0;
     da6:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     daa:	fdc42783          	lw	a5,-36(s0)
     dae:	2785                	addiw	a5,a5,1
     db0:	fcf42e23          	sw	a5,-36(s0)
     db4:	fdc42783          	lw	a5,-36(s0)
     db8:	fc043703          	ld	a4,-64(s0)
     dbc:	97ba                	add	a5,a5,a4
     dbe:	0007c783          	lbu	a5,0(a5)
     dc2:	ba0799e3          	bnez	a5,974 <vprintf+0x20>
    }
  }
}
     dc6:	0001                	nop
     dc8:	0001                	nop
     dca:	60a6                	ld	ra,72(sp)
     dcc:	6406                	ld	s0,64(sp)
     dce:	6161                	addi	sp,sp,80
     dd0:	8082                	ret

0000000000000dd2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     dd2:	7159                	addi	sp,sp,-112
     dd4:	fc06                	sd	ra,56(sp)
     dd6:	f822                	sd	s0,48(sp)
     dd8:	0080                	addi	s0,sp,64
     dda:	fcb43823          	sd	a1,-48(s0)
     dde:	e010                	sd	a2,0(s0)
     de0:	e414                	sd	a3,8(s0)
     de2:	e818                	sd	a4,16(s0)
     de4:	ec1c                	sd	a5,24(s0)
     de6:	03043023          	sd	a6,32(s0)
     dea:	03143423          	sd	a7,40(s0)
     dee:	87aa                	mv	a5,a0
     df0:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     df4:	03040793          	addi	a5,s0,48
     df8:	fcf43423          	sd	a5,-56(s0)
     dfc:	fc843783          	ld	a5,-56(s0)
     e00:	fd078793          	addi	a5,a5,-48
     e04:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e08:	fe843703          	ld	a4,-24(s0)
     e0c:	fdc42783          	lw	a5,-36(s0)
     e10:	863a                	mv	a2,a4
     e12:	fd043583          	ld	a1,-48(s0)
     e16:	853e                	mv	a0,a5
     e18:	b3dff0ef          	jal	954 <vprintf>
}
     e1c:	0001                	nop
     e1e:	70e2                	ld	ra,56(sp)
     e20:	7442                	ld	s0,48(sp)
     e22:	6165                	addi	sp,sp,112
     e24:	8082                	ret

0000000000000e26 <printf>:

void
printf(const char *fmt, ...)
{
     e26:	7159                	addi	sp,sp,-112
     e28:	f406                	sd	ra,40(sp)
     e2a:	f022                	sd	s0,32(sp)
     e2c:	1800                	addi	s0,sp,48
     e2e:	fca43c23          	sd	a0,-40(s0)
     e32:	e40c                	sd	a1,8(s0)
     e34:	e810                	sd	a2,16(s0)
     e36:	ec14                	sd	a3,24(s0)
     e38:	f018                	sd	a4,32(s0)
     e3a:	f41c                	sd	a5,40(s0)
     e3c:	03043823          	sd	a6,48(s0)
     e40:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e44:	04040793          	addi	a5,s0,64
     e48:	fcf43823          	sd	a5,-48(s0)
     e4c:	fd043783          	ld	a5,-48(s0)
     e50:	fc878793          	addi	a5,a5,-56
     e54:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e58:	fe843783          	ld	a5,-24(s0)
     e5c:	863e                	mv	a2,a5
     e5e:	fd843583          	ld	a1,-40(s0)
     e62:	4505                	li	a0,1
     e64:	af1ff0ef          	jal	954 <vprintf>
}
     e68:	0001                	nop
     e6a:	70a2                	ld	ra,40(sp)
     e6c:	7402                	ld	s0,32(sp)
     e6e:	6165                	addi	sp,sp,112
     e70:	8082                	ret

0000000000000e72 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e72:	7179                	addi	sp,sp,-48
     e74:	f406                	sd	ra,40(sp)
     e76:	f022                	sd	s0,32(sp)
     e78:	1800                	addi	s0,sp,48
     e7a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e7e:	fd843783          	ld	a5,-40(s0)
     e82:	17c1                	addi	a5,a5,-16
     e84:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e88:	00001797          	auipc	a5,0x1
     e8c:	3a878793          	addi	a5,a5,936 # 2230 <freep>
     e90:	639c                	ld	a5,0(a5)
     e92:	fef43423          	sd	a5,-24(s0)
     e96:	a815                	j	eca <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e98:	fe843783          	ld	a5,-24(s0)
     e9c:	639c                	ld	a5,0(a5)
     e9e:	fe843703          	ld	a4,-24(s0)
     ea2:	00f76f63          	bltu	a4,a5,ec0 <free+0x4e>
     ea6:	fe043703          	ld	a4,-32(s0)
     eaa:	fe843783          	ld	a5,-24(s0)
     eae:	02e7eb63          	bltu	a5,a4,ee4 <free+0x72>
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	639c                	ld	a5,0(a5)
     eb8:	fe043703          	ld	a4,-32(s0)
     ebc:	02f76463          	bltu	a4,a5,ee4 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ec0:	fe843783          	ld	a5,-24(s0)
     ec4:	639c                	ld	a5,0(a5)
     ec6:	fef43423          	sd	a5,-24(s0)
     eca:	fe043703          	ld	a4,-32(s0)
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	fce7f3e3          	bgeu	a5,a4,e98 <free+0x26>
     ed6:	fe843783          	ld	a5,-24(s0)
     eda:	639c                	ld	a5,0(a5)
     edc:	fe043703          	ld	a4,-32(s0)
     ee0:	faf77ce3          	bgeu	a4,a5,e98 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ee4:	fe043783          	ld	a5,-32(s0)
     ee8:	479c                	lw	a5,8(a5)
     eea:	1782                	slli	a5,a5,0x20
     eec:	9381                	srli	a5,a5,0x20
     eee:	0792                	slli	a5,a5,0x4
     ef0:	fe043703          	ld	a4,-32(s0)
     ef4:	973e                	add	a4,a4,a5
     ef6:	fe843783          	ld	a5,-24(s0)
     efa:	639c                	ld	a5,0(a5)
     efc:	02f71763          	bne	a4,a5,f2a <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     f00:	fe043783          	ld	a5,-32(s0)
     f04:	4798                	lw	a4,8(a5)
     f06:	fe843783          	ld	a5,-24(s0)
     f0a:	639c                	ld	a5,0(a5)
     f0c:	479c                	lw	a5,8(a5)
     f0e:	9fb9                	addw	a5,a5,a4
     f10:	0007871b          	sext.w	a4,a5
     f14:	fe043783          	ld	a5,-32(s0)
     f18:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	639c                	ld	a5,0(a5)
     f20:	6398                	ld	a4,0(a5)
     f22:	fe043783          	ld	a5,-32(s0)
     f26:	e398                	sd	a4,0(a5)
     f28:	a039                	j	f36 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     f2a:	fe843783          	ld	a5,-24(s0)
     f2e:	6398                	ld	a4,0(a5)
     f30:	fe043783          	ld	a5,-32(s0)
     f34:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f36:	fe843783          	ld	a5,-24(s0)
     f3a:	479c                	lw	a5,8(a5)
     f3c:	1782                	slli	a5,a5,0x20
     f3e:	9381                	srli	a5,a5,0x20
     f40:	0792                	slli	a5,a5,0x4
     f42:	fe843703          	ld	a4,-24(s0)
     f46:	97ba                	add	a5,a5,a4
     f48:	fe043703          	ld	a4,-32(s0)
     f4c:	02f71563          	bne	a4,a5,f76 <free+0x104>
    p->s.size += bp->s.size;
     f50:	fe843783          	ld	a5,-24(s0)
     f54:	4798                	lw	a4,8(a5)
     f56:	fe043783          	ld	a5,-32(s0)
     f5a:	479c                	lw	a5,8(a5)
     f5c:	9fb9                	addw	a5,a5,a4
     f5e:	0007871b          	sext.w	a4,a5
     f62:	fe843783          	ld	a5,-24(s0)
     f66:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f68:	fe043783          	ld	a5,-32(s0)
     f6c:	6398                	ld	a4,0(a5)
     f6e:	fe843783          	ld	a5,-24(s0)
     f72:	e398                	sd	a4,0(a5)
     f74:	a031                	j	f80 <free+0x10e>
  } else
    p->s.ptr = bp;
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	fe043703          	ld	a4,-32(s0)
     f7e:	e398                	sd	a4,0(a5)
  freep = p;
     f80:	00001797          	auipc	a5,0x1
     f84:	2b078793          	addi	a5,a5,688 # 2230 <freep>
     f88:	fe843703          	ld	a4,-24(s0)
     f8c:	e398                	sd	a4,0(a5)
}
     f8e:	0001                	nop
     f90:	70a2                	ld	ra,40(sp)
     f92:	7402                	ld	s0,32(sp)
     f94:	6145                	addi	sp,sp,48
     f96:	8082                	ret

0000000000000f98 <morecore>:

static Header*
morecore(uint nu)
{
     f98:	7179                	addi	sp,sp,-48
     f9a:	f406                	sd	ra,40(sp)
     f9c:	f022                	sd	s0,32(sp)
     f9e:	1800                	addi	s0,sp,48
     fa0:	87aa                	mv	a5,a0
     fa2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     fa6:	fdc42783          	lw	a5,-36(s0)
     faa:	0007871b          	sext.w	a4,a5
     fae:	6785                	lui	a5,0x1
     fb0:	00f77563          	bgeu	a4,a5,fba <morecore+0x22>
    nu = 4096;
     fb4:	6785                	lui	a5,0x1
     fb6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     fba:	fdc42783          	lw	a5,-36(s0)
     fbe:	0047979b          	slliw	a5,a5,0x4
     fc2:	2781                	sext.w	a5,a5
     fc4:	853e                	mv	a0,a5
     fc6:	ef0ff0ef          	jal	6b6 <sbrk>
     fca:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     fce:	fe843703          	ld	a4,-24(s0)
     fd2:	57fd                	li	a5,-1
     fd4:	00f71463          	bne	a4,a5,fdc <morecore+0x44>
    return 0;
     fd8:	4781                	li	a5,0
     fda:	a02d                	j	1004 <morecore+0x6c>
  hp = (Header*)p;
     fdc:	fe843783          	ld	a5,-24(s0)
     fe0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     fe4:	fe043783          	ld	a5,-32(s0)
     fe8:	fdc42703          	lw	a4,-36(s0)
     fec:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     fee:	fe043783          	ld	a5,-32(s0)
     ff2:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x2>
     ff4:	853e                	mv	a0,a5
     ff6:	e7dff0ef          	jal	e72 <free>
  return freep;
     ffa:	00001797          	auipc	a5,0x1
     ffe:	23678793          	addi	a5,a5,566 # 2230 <freep>
    1002:	639c                	ld	a5,0(a5)
}
    1004:	853e                	mv	a0,a5
    1006:	70a2                	ld	ra,40(sp)
    1008:	7402                	ld	s0,32(sp)
    100a:	6145                	addi	sp,sp,48
    100c:	8082                	ret

000000000000100e <malloc>:

void*
malloc(uint nbytes)
{
    100e:	7139                	addi	sp,sp,-64
    1010:	fc06                	sd	ra,56(sp)
    1012:	f822                	sd	s0,48(sp)
    1014:	0080                	addi	s0,sp,64
    1016:	87aa                	mv	a5,a0
    1018:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    101c:	fcc46783          	lwu	a5,-52(s0)
    1020:	07bd                	addi	a5,a5,15
    1022:	8391                	srli	a5,a5,0x4
    1024:	2781                	sext.w	a5,a5
    1026:	2785                	addiw	a5,a5,1
    1028:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    102c:	00001797          	auipc	a5,0x1
    1030:	20478793          	addi	a5,a5,516 # 2230 <freep>
    1034:	639c                	ld	a5,0(a5)
    1036:	fef43023          	sd	a5,-32(s0)
    103a:	fe043783          	ld	a5,-32(s0)
    103e:	ef95                	bnez	a5,107a <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1040:	00001797          	auipc	a5,0x1
    1044:	1e078793          	addi	a5,a5,480 # 2220 <base>
    1048:	fef43023          	sd	a5,-32(s0)
    104c:	00001797          	auipc	a5,0x1
    1050:	1e478793          	addi	a5,a5,484 # 2230 <freep>
    1054:	fe043703          	ld	a4,-32(s0)
    1058:	e398                	sd	a4,0(a5)
    105a:	00001797          	auipc	a5,0x1
    105e:	1d678793          	addi	a5,a5,470 # 2230 <freep>
    1062:	6398                	ld	a4,0(a5)
    1064:	00001797          	auipc	a5,0x1
    1068:	1bc78793          	addi	a5,a5,444 # 2220 <base>
    106c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    106e:	00001797          	auipc	a5,0x1
    1072:	1b278793          	addi	a5,a5,434 # 2220 <base>
    1076:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    107a:	fe043783          	ld	a5,-32(s0)
    107e:	639c                	ld	a5,0(a5)
    1080:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1084:	fe843783          	ld	a5,-24(s0)
    1088:	479c                	lw	a5,8(a5)
    108a:	fdc42703          	lw	a4,-36(s0)
    108e:	2701                	sext.w	a4,a4
    1090:	06e7e763          	bltu	a5,a4,10fe <malloc+0xf0>
      if(p->s.size == nunits)
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	479c                	lw	a5,8(a5)
    109a:	fdc42703          	lw	a4,-36(s0)
    109e:	2701                	sext.w	a4,a4
    10a0:	00f71963          	bne	a4,a5,10b2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    10a4:	fe843783          	ld	a5,-24(s0)
    10a8:	6398                	ld	a4,0(a5)
    10aa:	fe043783          	ld	a5,-32(s0)
    10ae:	e398                	sd	a4,0(a5)
    10b0:	a825                	j	10e8 <malloc+0xda>
      else {
        p->s.size -= nunits;
    10b2:	fe843783          	ld	a5,-24(s0)
    10b6:	479c                	lw	a5,8(a5)
    10b8:	fdc42703          	lw	a4,-36(s0)
    10bc:	9f99                	subw	a5,a5,a4
    10be:	0007871b          	sext.w	a4,a5
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10c8:	fe843783          	ld	a5,-24(s0)
    10cc:	479c                	lw	a5,8(a5)
    10ce:	1782                	slli	a5,a5,0x20
    10d0:	9381                	srli	a5,a5,0x20
    10d2:	0792                	slli	a5,a5,0x4
    10d4:	fe843703          	ld	a4,-24(s0)
    10d8:	97ba                	add	a5,a5,a4
    10da:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10de:	fe843783          	ld	a5,-24(s0)
    10e2:	fdc42703          	lw	a4,-36(s0)
    10e6:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10e8:	00001797          	auipc	a5,0x1
    10ec:	14878793          	addi	a5,a5,328 # 2230 <freep>
    10f0:	fe043703          	ld	a4,-32(s0)
    10f4:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10f6:	fe843783          	ld	a5,-24(s0)
    10fa:	07c1                	addi	a5,a5,16
    10fc:	a081                	j	113c <malloc+0x12e>
    }
    if(p == freep)
    10fe:	00001797          	auipc	a5,0x1
    1102:	13278793          	addi	a5,a5,306 # 2230 <freep>
    1106:	639c                	ld	a5,0(a5)
    1108:	fe843703          	ld	a4,-24(s0)
    110c:	00f71e63          	bne	a4,a5,1128 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1110:	fdc42783          	lw	a5,-36(s0)
    1114:	853e                	mv	a0,a5
    1116:	e83ff0ef          	jal	f98 <morecore>
    111a:	fea43423          	sd	a0,-24(s0)
    111e:	fe843783          	ld	a5,-24(s0)
    1122:	e399                	bnez	a5,1128 <malloc+0x11a>
        return 0;
    1124:	4781                	li	a5,0
    1126:	a819                	j	113c <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1128:	fe843783          	ld	a5,-24(s0)
    112c:	fef43023          	sd	a5,-32(s0)
    1130:	fe843783          	ld	a5,-24(s0)
    1134:	639c                	ld	a5,0(a5)
    1136:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    113a:	b7a9                	j	1084 <malloc+0x76>
  }
}
    113c:	853e                	mv	a0,a5
    113e:	70e2                	ld	ra,56(sp)
    1140:	7442                	ld	s0,48(sp)
    1142:	6121                	addi	sp,sp,64
    1144:	8082                	ret
