
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
       c:	87ae                	mv	a5,a1
       e:	fcf42223          	sw	a5,-60(s0)
  int n, m;
  char *p, *q;

  m = 0;
      12:	fe042623          	sw	zero,-20(s0)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      16:	a8c1                	j	e6 <grep+0xe6>
    m += n;
      18:	fec42783          	lw	a5,-20(s0)
      1c:	873e                	mv	a4,a5
      1e:	fdc42783          	lw	a5,-36(s0)
      22:	9fb9                	addw	a5,a5,a4
      24:	fef42623          	sw	a5,-20(s0)
    buf[m] = '\0';
      28:	00002717          	auipc	a4,0x2
      2c:	ff870713          	addi	a4,a4,-8 # 2020 <buf>
      30:	fec42783          	lw	a5,-20(s0)
      34:	97ba                	add	a5,a5,a4
      36:	00078023          	sb	zero,0(a5)
    p = buf;
      3a:	00002797          	auipc	a5,0x2
      3e:	fe678793          	addi	a5,a5,-26 # 2020 <buf>
      42:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      46:	a0b1                	j	92 <grep+0x92>
      *q = 0;
      48:	fd043783          	ld	a5,-48(s0)
      4c:	00078023          	sb	zero,0(a5)
      if(match(pattern, p)){
      50:	fe043583          	ld	a1,-32(s0)
      54:	fc843503          	ld	a0,-56(s0)
      58:	1be000ef          	jal	216 <match>
      5c:	87aa                	mv	a5,a0
      5e:	c78d                	beqz	a5,88 <grep+0x88>
        *q = '\n';
      60:	fd043783          	ld	a5,-48(s0)
      64:	4729                	li	a4,10
      66:	00e78023          	sb	a4,0(a5)
        write(1, p, q+1 - p);
      6a:	fd043783          	ld	a5,-48(s0)
      6e:	00178713          	addi	a4,a5,1
      72:	fe043783          	ld	a5,-32(s0)
      76:	40f707b3          	sub	a5,a4,a5
      7a:	2781                	sext.w	a5,a5
      7c:	863e                	mv	a2,a5
      7e:	fe043583          	ld	a1,-32(s0)
      82:	4505                	li	a0,1
      84:	07d000ef          	jal	900 <write>
      }
      p = q+1;
      88:	fd043783          	ld	a5,-48(s0)
      8c:	0785                	addi	a5,a5,1
      8e:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      92:	45a9                	li	a1,10
      94:	fe043503          	ld	a0,-32(s0)
      98:	4b6000ef          	jal	54e <strchr>
      9c:	fca43823          	sd	a0,-48(s0)
      a0:	fd043783          	ld	a5,-48(s0)
      a4:	f3d5                	bnez	a5,48 <grep+0x48>
    }
    if(m > 0){
      a6:	fec42783          	lw	a5,-20(s0)
      aa:	2781                	sext.w	a5,a5
      ac:	02f05d63          	blez	a5,e6 <grep+0xe6>
      m -= p - buf;
      b0:	fec42703          	lw	a4,-20(s0)
      b4:	fe043683          	ld	a3,-32(s0)
      b8:	00002797          	auipc	a5,0x2
      bc:	f6878793          	addi	a5,a5,-152 # 2020 <buf>
      c0:	40f687b3          	sub	a5,a3,a5
      c4:	2781                	sext.w	a5,a5
      c6:	40f707bb          	subw	a5,a4,a5
      ca:	2781                	sext.w	a5,a5
      cc:	fef42623          	sw	a5,-20(s0)
      memmove(buf, p, m);
      d0:	fec42783          	lw	a5,-20(s0)
      d4:	863e                	mv	a2,a5
      d6:	fe043583          	ld	a1,-32(s0)
      da:	00002517          	auipc	a0,0x2
      de:	f4650513          	addi	a0,a0,-186 # 2020 <buf>
      e2:	628000ef          	jal	70a <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      e6:	fec42703          	lw	a4,-20(s0)
      ea:	00002797          	auipc	a5,0x2
      ee:	f3678793          	addi	a5,a5,-202 # 2020 <buf>
      f2:	00f706b3          	add	a3,a4,a5
      f6:	fec42783          	lw	a5,-20(s0)
      fa:	3ff00713          	li	a4,1023
      fe:	40f707bb          	subw	a5,a4,a5
     102:	2781                	sext.w	a5,a5
     104:	873e                	mv	a4,a5
     106:	fc442783          	lw	a5,-60(s0)
     10a:	863a                	mv	a2,a4
     10c:	85b6                	mv	a1,a3
     10e:	853e                	mv	a0,a5
     110:	7e8000ef          	jal	8f8 <read>
     114:	87aa                	mv	a5,a0
     116:	fcf42e23          	sw	a5,-36(s0)
     11a:	fdc42783          	lw	a5,-36(s0)
     11e:	2781                	sext.w	a5,a5
     120:	eef04ce3          	bgtz	a5,18 <grep+0x18>
    }
  }
}
     124:	0001                	nop
     126:	0001                	nop
     128:	70e2                	ld	ra,56(sp)
     12a:	7442                	ld	s0,48(sp)
     12c:	6121                	addi	sp,sp,64
     12e:	8082                	ret

0000000000000130 <main>:

int
main(int argc, char *argv[])
{
     130:	7139                	addi	sp,sp,-64
     132:	fc06                	sd	ra,56(sp)
     134:	f822                	sd	s0,48(sp)
     136:	0080                	addi	s0,sp,64
     138:	87aa                	mv	a5,a0
     13a:	fcb43023          	sd	a1,-64(s0)
     13e:	fcf42623          	sw	a5,-52(s0)
  int fd, i;
  char *pattern;

  if(argc <= 1){
     142:	fcc42783          	lw	a5,-52(s0)
     146:	0007871b          	sext.w	a4,a5
     14a:	4785                	li	a5,1
     14c:	00e7cc63          	blt	a5,a4,164 <main+0x34>
    fprintf(2, "usage: grep pattern [file ...]\n");
     150:	00001597          	auipc	a1,0x1
     154:	1e058593          	addi	a1,a1,480 # 1330 <malloc+0x144>
     158:	4509                	li	a0,2
     15a:	657000ef          	jal	fb0 <fprintf>
    exit(1);
     15e:	4505                	li	a0,1
     160:	780000ef          	jal	8e0 <exit>
  }
  pattern = argv[1];
     164:	fc043783          	ld	a5,-64(s0)
     168:	679c                	ld	a5,8(a5)
     16a:	fef43023          	sd	a5,-32(s0)

  if(argc <= 2){
     16e:	fcc42783          	lw	a5,-52(s0)
     172:	0007871b          	sext.w	a4,a5
     176:	4789                	li	a5,2
     178:	00e7ca63          	blt	a5,a4,18c <main+0x5c>
    grep(pattern, 0);
     17c:	4581                	li	a1,0
     17e:	fe043503          	ld	a0,-32(s0)
     182:	e7fff0ef          	jal	0 <grep>
    exit(0);
     186:	4501                	li	a0,0
     188:	758000ef          	jal	8e0 <exit>
  }

  for(i = 2; i < argc; i++){
     18c:	4789                	li	a5,2
     18e:	fef42623          	sw	a5,-20(s0)
     192:	a0b5                	j	1fe <main+0xce>
    if((fd = open(argv[i], O_RDONLY)) < 0){
     194:	fec42783          	lw	a5,-20(s0)
     198:	078e                	slli	a5,a5,0x3
     19a:	fc043703          	ld	a4,-64(s0)
     19e:	97ba                	add	a5,a5,a4
     1a0:	639c                	ld	a5,0(a5)
     1a2:	4581                	li	a1,0
     1a4:	853e                	mv	a0,a5
     1a6:	77a000ef          	jal	920 <open>
     1aa:	87aa                	mv	a5,a0
     1ac:	fcf42e23          	sw	a5,-36(s0)
     1b0:	fdc42783          	lw	a5,-36(s0)
     1b4:	2781                	sext.w	a5,a5
     1b6:	0207d363          	bgez	a5,1dc <main+0xac>
      printf("grep: cannot open %s\n", argv[i]);
     1ba:	fec42783          	lw	a5,-20(s0)
     1be:	078e                	slli	a5,a5,0x3
     1c0:	fc043703          	ld	a4,-64(s0)
     1c4:	97ba                	add	a5,a5,a4
     1c6:	639c                	ld	a5,0(a5)
     1c8:	85be                	mv	a1,a5
     1ca:	00001517          	auipc	a0,0x1
     1ce:	18650513          	addi	a0,a0,390 # 1350 <malloc+0x164>
     1d2:	633000ef          	jal	1004 <printf>
      exit(1);
     1d6:	4505                	li	a0,1
     1d8:	708000ef          	jal	8e0 <exit>
    }
    grep(pattern, fd);
     1dc:	fdc42783          	lw	a5,-36(s0)
     1e0:	85be                	mv	a1,a5
     1e2:	fe043503          	ld	a0,-32(s0)
     1e6:	e1bff0ef          	jal	0 <grep>
    close(fd);
     1ea:	fdc42783          	lw	a5,-36(s0)
     1ee:	853e                	mv	a0,a5
     1f0:	718000ef          	jal	908 <close>
  for(i = 2; i < argc; i++){
     1f4:	fec42783          	lw	a5,-20(s0)
     1f8:	2785                	addiw	a5,a5,1
     1fa:	fef42623          	sw	a5,-20(s0)
     1fe:	fec42783          	lw	a5,-20(s0)
     202:	873e                	mv	a4,a5
     204:	fcc42783          	lw	a5,-52(s0)
     208:	2701                	sext.w	a4,a4
     20a:	2781                	sext.w	a5,a5
     20c:	f8f744e3          	blt	a4,a5,194 <main+0x64>
  }
  exit(0);
     210:	4501                	li	a0,0
     212:	6ce000ef          	jal	8e0 <exit>

0000000000000216 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     216:	1101                	addi	sp,sp,-32
     218:	ec06                	sd	ra,24(sp)
     21a:	e822                	sd	s0,16(sp)
     21c:	1000                	addi	s0,sp,32
     21e:	fea43423          	sd	a0,-24(s0)
     222:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '^')
     226:	fe843783          	ld	a5,-24(s0)
     22a:	0007c783          	lbu	a5,0(a5)
     22e:	873e                	mv	a4,a5
     230:	05e00793          	li	a5,94
     234:	00f71c63          	bne	a4,a5,24c <match+0x36>
    return matchhere(re+1, text);
     238:	fe843783          	ld	a5,-24(s0)
     23c:	0785                	addi	a5,a5,1
     23e:	fe043583          	ld	a1,-32(s0)
     242:	853e                	mv	a0,a5
     244:	03a000ef          	jal	27e <matchhere>
     248:	87aa                	mv	a5,a0
     24a:	a02d                	j	274 <match+0x5e>
  do{  // must look at empty string
    if(matchhere(re, text))
     24c:	fe043583          	ld	a1,-32(s0)
     250:	fe843503          	ld	a0,-24(s0)
     254:	02a000ef          	jal	27e <matchhere>
     258:	87aa                	mv	a5,a0
     25a:	c399                	beqz	a5,260 <match+0x4a>
      return 1;
     25c:	4785                	li	a5,1
     25e:	a819                	j	274 <match+0x5e>
  }while(*text++ != '\0');
     260:	fe043783          	ld	a5,-32(s0)
     264:	00178713          	addi	a4,a5,1
     268:	fee43023          	sd	a4,-32(s0)
     26c:	0007c783          	lbu	a5,0(a5)
     270:	fff1                	bnez	a5,24c <match+0x36>
  return 0;
     272:	4781                	li	a5,0
}
     274:	853e                	mv	a0,a5
     276:	60e2                	ld	ra,24(sp)
     278:	6442                	ld	s0,16(sp)
     27a:	6105                	addi	sp,sp,32
     27c:	8082                	ret

000000000000027e <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     27e:	1101                	addi	sp,sp,-32
     280:	ec06                	sd	ra,24(sp)
     282:	e822                	sd	s0,16(sp)
     284:	1000                	addi	s0,sp,32
     286:	fea43423          	sd	a0,-24(s0)
     28a:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '\0')
     28e:	fe843783          	ld	a5,-24(s0)
     292:	0007c783          	lbu	a5,0(a5)
     296:	e399                	bnez	a5,29c <matchhere+0x1e>
    return 1;
     298:	4785                	li	a5,1
     29a:	a865                	j	352 <matchhere+0xd4>
  if(re[1] == '*')
     29c:	fe843783          	ld	a5,-24(s0)
     2a0:	0785                	addi	a5,a5,1
     2a2:	0007c783          	lbu	a5,0(a5)
     2a6:	873e                	mv	a4,a5
     2a8:	02a00793          	li	a5,42
     2ac:	02f71363          	bne	a4,a5,2d2 <matchhere+0x54>
    return matchstar(re[0], re+2, text);
     2b0:	fe843783          	ld	a5,-24(s0)
     2b4:	0007c783          	lbu	a5,0(a5)
     2b8:	0007871b          	sext.w	a4,a5
     2bc:	fe843783          	ld	a5,-24(s0)
     2c0:	0789                	addi	a5,a5,2
     2c2:	fe043603          	ld	a2,-32(s0)
     2c6:	85be                	mv	a1,a5
     2c8:	853a                	mv	a0,a4
     2ca:	092000ef          	jal	35c <matchstar>
     2ce:	87aa                	mv	a5,a0
     2d0:	a049                	j	352 <matchhere+0xd4>
  if(re[0] == '$' && re[1] == '\0')
     2d2:	fe843783          	ld	a5,-24(s0)
     2d6:	0007c783          	lbu	a5,0(a5)
     2da:	873e                	mv	a4,a5
     2dc:	02400793          	li	a5,36
     2e0:	02f71363          	bne	a4,a5,306 <matchhere+0x88>
     2e4:	fe843783          	ld	a5,-24(s0)
     2e8:	0785                	addi	a5,a5,1
     2ea:	0007c783          	lbu	a5,0(a5)
     2ee:	ef81                	bnez	a5,306 <matchhere+0x88>
    return *text == '\0';
     2f0:	fe043783          	ld	a5,-32(s0)
     2f4:	0007c783          	lbu	a5,0(a5)
     2f8:	2781                	sext.w	a5,a5
     2fa:	0017b793          	seqz	a5,a5
     2fe:	0ff7f793          	zext.b	a5,a5
     302:	2781                	sext.w	a5,a5
     304:	a0b9                	j	352 <matchhere+0xd4>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     306:	fe043783          	ld	a5,-32(s0)
     30a:	0007c783          	lbu	a5,0(a5)
     30e:	c3a9                	beqz	a5,350 <matchhere+0xd2>
     310:	fe843783          	ld	a5,-24(s0)
     314:	0007c783          	lbu	a5,0(a5)
     318:	873e                	mv	a4,a5
     31a:	02e00793          	li	a5,46
     31e:	00f70c63          	beq	a4,a5,336 <matchhere+0xb8>
     322:	fe843783          	ld	a5,-24(s0)
     326:	0007c703          	lbu	a4,0(a5)
     32a:	fe043783          	ld	a5,-32(s0)
     32e:	0007c783          	lbu	a5,0(a5)
     332:	00f71f63          	bne	a4,a5,350 <matchhere+0xd2>
    return matchhere(re+1, text+1);
     336:	fe843783          	ld	a5,-24(s0)
     33a:	00178713          	addi	a4,a5,1
     33e:	fe043783          	ld	a5,-32(s0)
     342:	0785                	addi	a5,a5,1
     344:	85be                	mv	a1,a5
     346:	853a                	mv	a0,a4
     348:	f37ff0ef          	jal	27e <matchhere>
     34c:	87aa                	mv	a5,a0
     34e:	a011                	j	352 <matchhere+0xd4>
  return 0;
     350:	4781                	li	a5,0
}
     352:	853e                	mv	a0,a5
     354:	60e2                	ld	ra,24(sp)
     356:	6442                	ld	s0,16(sp)
     358:	6105                	addi	sp,sp,32
     35a:	8082                	ret

000000000000035c <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	1800                	addi	s0,sp,48
     364:	87aa                	mv	a5,a0
     366:	feb43023          	sd	a1,-32(s0)
     36a:	fcc43c23          	sd	a2,-40(s0)
     36e:	fef42623          	sw	a5,-20(s0)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     372:	fd843583          	ld	a1,-40(s0)
     376:	fe043503          	ld	a0,-32(s0)
     37a:	f05ff0ef          	jal	27e <matchhere>
     37e:	87aa                	mv	a5,a0
     380:	c399                	beqz	a5,386 <matchstar+0x2a>
      return 1;
     382:	4785                	li	a5,1
     384:	a82d                	j	3be <matchstar+0x62>
  }while(*text!='\0' && (*text++==c || c=='.'));
     386:	fd843783          	ld	a5,-40(s0)
     38a:	0007c783          	lbu	a5,0(a5)
     38e:	c79d                	beqz	a5,3bc <matchstar+0x60>
     390:	fd843783          	ld	a5,-40(s0)
     394:	00178713          	addi	a4,a5,1
     398:	fce43c23          	sd	a4,-40(s0)
     39c:	0007c783          	lbu	a5,0(a5)
     3a0:	2781                	sext.w	a5,a5
     3a2:	fec42703          	lw	a4,-20(s0)
     3a6:	2701                	sext.w	a4,a4
     3a8:	fcf705e3          	beq	a4,a5,372 <matchstar+0x16>
     3ac:	fec42783          	lw	a5,-20(s0)
     3b0:	0007871b          	sext.w	a4,a5
     3b4:	02e00793          	li	a5,46
     3b8:	faf70de3          	beq	a4,a5,372 <matchstar+0x16>
  return 0;
     3bc:	4781                	li	a5,0
}
     3be:	853e                	mv	a0,a5
     3c0:	70a2                	ld	ra,40(sp)
     3c2:	7402                	ld	s0,32(sp)
     3c4:	6145                	addi	sp,sp,48
     3c6:	8082                	ret

00000000000003c8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     3c8:	7179                	addi	sp,sp,-48
     3ca:	f406                	sd	ra,40(sp)
     3cc:	f022                	sd	s0,32(sp)
     3ce:	1800                	addi	s0,sp,48
     3d0:	87aa                	mv	a5,a0
     3d2:	fcb43823          	sd	a1,-48(s0)
     3d6:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     3da:	fdc42783          	lw	a5,-36(s0)
     3de:	fd043583          	ld	a1,-48(s0)
     3e2:	853e                	mv	a0,a5
     3e4:	d4dff0ef          	jal	130 <main>
     3e8:	87aa                	mv	a5,a0
     3ea:	fef42623          	sw	a5,-20(s0)
  exit(r);
     3ee:	fec42783          	lw	a5,-20(s0)
     3f2:	853e                	mv	a0,a5
     3f4:	4ec000ef          	jal	8e0 <exit>

00000000000003f8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     3f8:	7179                	addi	sp,sp,-48
     3fa:	f406                	sd	ra,40(sp)
     3fc:	f022                	sd	s0,32(sp)
     3fe:	1800                	addi	s0,sp,48
     400:	fca43c23          	sd	a0,-40(s0)
     404:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     408:	fd843783          	ld	a5,-40(s0)
     40c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     410:	0001                	nop
     412:	fd043703          	ld	a4,-48(s0)
     416:	00170793          	addi	a5,a4,1
     41a:	fcf43823          	sd	a5,-48(s0)
     41e:	fd843783          	ld	a5,-40(s0)
     422:	00178693          	addi	a3,a5,1
     426:	fcd43c23          	sd	a3,-40(s0)
     42a:	00074703          	lbu	a4,0(a4)
     42e:	00e78023          	sb	a4,0(a5)
     432:	0007c783          	lbu	a5,0(a5)
     436:	fff1                	bnez	a5,412 <strcpy+0x1a>
    ;
  return os;
     438:	fe843783          	ld	a5,-24(s0)
}
     43c:	853e                	mv	a0,a5
     43e:	70a2                	ld	ra,40(sp)
     440:	7402                	ld	s0,32(sp)
     442:	6145                	addi	sp,sp,48
     444:	8082                	ret

0000000000000446 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     446:	1101                	addi	sp,sp,-32
     448:	ec06                	sd	ra,24(sp)
     44a:	e822                	sd	s0,16(sp)
     44c:	1000                	addi	s0,sp,32
     44e:	fea43423          	sd	a0,-24(s0)
     452:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     456:	a819                	j	46c <strcmp+0x26>
    p++, q++;
     458:	fe843783          	ld	a5,-24(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43423          	sd	a5,-24(s0)
     462:	fe043783          	ld	a5,-32(s0)
     466:	0785                	addi	a5,a5,1
     468:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     46c:	fe843783          	ld	a5,-24(s0)
     470:	0007c783          	lbu	a5,0(a5)
     474:	cb99                	beqz	a5,48a <strcmp+0x44>
     476:	fe843783          	ld	a5,-24(s0)
     47a:	0007c703          	lbu	a4,0(a5)
     47e:	fe043783          	ld	a5,-32(s0)
     482:	0007c783          	lbu	a5,0(a5)
     486:	fcf709e3          	beq	a4,a5,458 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     48a:	fe843783          	ld	a5,-24(s0)
     48e:	0007c783          	lbu	a5,0(a5)
     492:	0007871b          	sext.w	a4,a5
     496:	fe043783          	ld	a5,-32(s0)
     49a:	0007c783          	lbu	a5,0(a5)
     49e:	2781                	sext.w	a5,a5
     4a0:	40f707bb          	subw	a5,a4,a5
     4a4:	2781                	sext.w	a5,a5
}
     4a6:	853e                	mv	a0,a5
     4a8:	60e2                	ld	ra,24(sp)
     4aa:	6442                	ld	s0,16(sp)
     4ac:	6105                	addi	sp,sp,32
     4ae:	8082                	ret

00000000000004b0 <strlen>:

uint
strlen(const char *s)
{
     4b0:	7179                	addi	sp,sp,-48
     4b2:	f406                	sd	ra,40(sp)
     4b4:	f022                	sd	s0,32(sp)
     4b6:	1800                	addi	s0,sp,48
     4b8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4bc:	fe042623          	sw	zero,-20(s0)
     4c0:	a031                	j	4cc <strlen+0x1c>
     4c2:	fec42783          	lw	a5,-20(s0)
     4c6:	2785                	addiw	a5,a5,1
     4c8:	fef42623          	sw	a5,-20(s0)
     4cc:	fec42783          	lw	a5,-20(s0)
     4d0:	fd843703          	ld	a4,-40(s0)
     4d4:	97ba                	add	a5,a5,a4
     4d6:	0007c783          	lbu	a5,0(a5)
     4da:	f7e5                	bnez	a5,4c2 <strlen+0x12>
    ;
  return n;
     4dc:	fec42783          	lw	a5,-20(s0)
}
     4e0:	853e                	mv	a0,a5
     4e2:	70a2                	ld	ra,40(sp)
     4e4:	7402                	ld	s0,32(sp)
     4e6:	6145                	addi	sp,sp,48
     4e8:	8082                	ret

00000000000004ea <memset>:

void*
memset(void *dst, int c, uint n)
{
     4ea:	7179                	addi	sp,sp,-48
     4ec:	f406                	sd	ra,40(sp)
     4ee:	f022                	sd	s0,32(sp)
     4f0:	1800                	addi	s0,sp,48
     4f2:	fca43c23          	sd	a0,-40(s0)
     4f6:	87ae                	mv	a5,a1
     4f8:	8732                	mv	a4,a2
     4fa:	fcf42a23          	sw	a5,-44(s0)
     4fe:	87ba                	mv	a5,a4
     500:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     504:	fd843783          	ld	a5,-40(s0)
     508:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     50c:	fe042623          	sw	zero,-20(s0)
     510:	a00d                	j	532 <memset+0x48>
    cdst[i] = c;
     512:	fec42783          	lw	a5,-20(s0)
     516:	fe043703          	ld	a4,-32(s0)
     51a:	97ba                	add	a5,a5,a4
     51c:	fd442703          	lw	a4,-44(s0)
     520:	0ff77713          	zext.b	a4,a4
     524:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     528:	fec42783          	lw	a5,-20(s0)
     52c:	2785                	addiw	a5,a5,1
     52e:	fef42623          	sw	a5,-20(s0)
     532:	fec42783          	lw	a5,-20(s0)
     536:	fd042703          	lw	a4,-48(s0)
     53a:	2701                	sext.w	a4,a4
     53c:	fce7ebe3          	bltu	a5,a4,512 <memset+0x28>
  }
  return dst;
     540:	fd843783          	ld	a5,-40(s0)
}
     544:	853e                	mv	a0,a5
     546:	70a2                	ld	ra,40(sp)
     548:	7402                	ld	s0,32(sp)
     54a:	6145                	addi	sp,sp,48
     54c:	8082                	ret

000000000000054e <strchr>:

char*
strchr(const char *s, char c)
{
     54e:	1101                	addi	sp,sp,-32
     550:	ec06                	sd	ra,24(sp)
     552:	e822                	sd	s0,16(sp)
     554:	1000                	addi	s0,sp,32
     556:	fea43423          	sd	a0,-24(s0)
     55a:	87ae                	mv	a5,a1
     55c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     560:	a01d                	j	586 <strchr+0x38>
    if(*s == c)
     562:	fe843783          	ld	a5,-24(s0)
     566:	0007c703          	lbu	a4,0(a5)
     56a:	fe744783          	lbu	a5,-25(s0)
     56e:	0ff7f793          	zext.b	a5,a5
     572:	00e79563          	bne	a5,a4,57c <strchr+0x2e>
      return (char*)s;
     576:	fe843783          	ld	a5,-24(s0)
     57a:	a821                	j	592 <strchr+0x44>
  for(; *s; s++)
     57c:	fe843783          	ld	a5,-24(s0)
     580:	0785                	addi	a5,a5,1
     582:	fef43423          	sd	a5,-24(s0)
     586:	fe843783          	ld	a5,-24(s0)
     58a:	0007c783          	lbu	a5,0(a5)
     58e:	fbf1                	bnez	a5,562 <strchr+0x14>
  return 0;
     590:	4781                	li	a5,0
}
     592:	853e                	mv	a0,a5
     594:	60e2                	ld	ra,24(sp)
     596:	6442                	ld	s0,16(sp)
     598:	6105                	addi	sp,sp,32
     59a:	8082                	ret

000000000000059c <gets>:

char*
gets(char *buf, int max)
{
     59c:	7179                	addi	sp,sp,-48
     59e:	f406                	sd	ra,40(sp)
     5a0:	f022                	sd	s0,32(sp)
     5a2:	1800                	addi	s0,sp,48
     5a4:	fca43c23          	sd	a0,-40(s0)
     5a8:	87ae                	mv	a5,a1
     5aa:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     5ae:	fe042623          	sw	zero,-20(s0)
     5b2:	a891                	j	606 <gets+0x6a>
    cc = read(0, &c, 1);
     5b4:	fe740793          	addi	a5,s0,-25
     5b8:	4605                	li	a2,1
     5ba:	85be                	mv	a1,a5
     5bc:	4501                	li	a0,0
     5be:	33a000ef          	jal	8f8 <read>
     5c2:	87aa                	mv	a5,a0
     5c4:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5c8:	fe842783          	lw	a5,-24(s0)
     5cc:	2781                	sext.w	a5,a5
     5ce:	04f05663          	blez	a5,61a <gets+0x7e>
      break;
    buf[i++] = c;
     5d2:	fec42783          	lw	a5,-20(s0)
     5d6:	0017871b          	addiw	a4,a5,1
     5da:	fee42623          	sw	a4,-20(s0)
     5de:	873e                	mv	a4,a5
     5e0:	fd843783          	ld	a5,-40(s0)
     5e4:	97ba                	add	a5,a5,a4
     5e6:	fe744703          	lbu	a4,-25(s0)
     5ea:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     5ee:	fe744783          	lbu	a5,-25(s0)
     5f2:	873e                	mv	a4,a5
     5f4:	47a9                	li	a5,10
     5f6:	02f70363          	beq	a4,a5,61c <gets+0x80>
     5fa:	fe744783          	lbu	a5,-25(s0)
     5fe:	873e                	mv	a4,a5
     600:	47b5                	li	a5,13
     602:	00f70d63          	beq	a4,a5,61c <gets+0x80>
  for(i=0; i+1 < max; ){
     606:	fec42783          	lw	a5,-20(s0)
     60a:	2785                	addiw	a5,a5,1
     60c:	2781                	sext.w	a5,a5
     60e:	fd442703          	lw	a4,-44(s0)
     612:	2701                	sext.w	a4,a4
     614:	fae7c0e3          	blt	a5,a4,5b4 <gets+0x18>
     618:	a011                	j	61c <gets+0x80>
      break;
     61a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     61c:	fec42783          	lw	a5,-20(s0)
     620:	fd843703          	ld	a4,-40(s0)
     624:	97ba                	add	a5,a5,a4
     626:	00078023          	sb	zero,0(a5)
  return buf;
     62a:	fd843783          	ld	a5,-40(s0)
}
     62e:	853e                	mv	a0,a5
     630:	70a2                	ld	ra,40(sp)
     632:	7402                	ld	s0,32(sp)
     634:	6145                	addi	sp,sp,48
     636:	8082                	ret

0000000000000638 <stat>:

int
stat(const char *n, struct stat *st)
{
     638:	7179                	addi	sp,sp,-48
     63a:	f406                	sd	ra,40(sp)
     63c:	f022                	sd	s0,32(sp)
     63e:	1800                	addi	s0,sp,48
     640:	fca43c23          	sd	a0,-40(s0)
     644:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     648:	4581                	li	a1,0
     64a:	fd843503          	ld	a0,-40(s0)
     64e:	2d2000ef          	jal	920 <open>
     652:	87aa                	mv	a5,a0
     654:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     658:	fec42783          	lw	a5,-20(s0)
     65c:	2781                	sext.w	a5,a5
     65e:	0007d463          	bgez	a5,666 <stat+0x2e>
    return -1;
     662:	57fd                	li	a5,-1
     664:	a015                	j	688 <stat+0x50>
  r = fstat(fd, st);
     666:	fec42783          	lw	a5,-20(s0)
     66a:	fd043583          	ld	a1,-48(s0)
     66e:	853e                	mv	a0,a5
     670:	2c8000ef          	jal	938 <fstat>
     674:	87aa                	mv	a5,a0
     676:	fef42423          	sw	a5,-24(s0)
  close(fd);
     67a:	fec42783          	lw	a5,-20(s0)
     67e:	853e                	mv	a0,a5
     680:	288000ef          	jal	908 <close>
  return r;
     684:	fe842783          	lw	a5,-24(s0)
}
     688:	853e                	mv	a0,a5
     68a:	70a2                	ld	ra,40(sp)
     68c:	7402                	ld	s0,32(sp)
     68e:	6145                	addi	sp,sp,48
     690:	8082                	ret

0000000000000692 <atoi>:

int
atoi(const char *s)
{
     692:	7179                	addi	sp,sp,-48
     694:	f406                	sd	ra,40(sp)
     696:	f022                	sd	s0,32(sp)
     698:	1800                	addi	s0,sp,48
     69a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     69e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     6a2:	a81d                	j	6d8 <atoi+0x46>
    n = n*10 + *s++ - '0';
     6a4:	fec42783          	lw	a5,-20(s0)
     6a8:	873e                	mv	a4,a5
     6aa:	87ba                	mv	a5,a4
     6ac:	0027979b          	slliw	a5,a5,0x2
     6b0:	9fb9                	addw	a5,a5,a4
     6b2:	0017979b          	slliw	a5,a5,0x1
     6b6:	0007871b          	sext.w	a4,a5
     6ba:	fd843783          	ld	a5,-40(s0)
     6be:	00178693          	addi	a3,a5,1
     6c2:	fcd43c23          	sd	a3,-40(s0)
     6c6:	0007c783          	lbu	a5,0(a5)
     6ca:	2781                	sext.w	a5,a5
     6cc:	9fb9                	addw	a5,a5,a4
     6ce:	2781                	sext.w	a5,a5
     6d0:	fd07879b          	addiw	a5,a5,-48
     6d4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     6d8:	fd843783          	ld	a5,-40(s0)
     6dc:	0007c783          	lbu	a5,0(a5)
     6e0:	873e                	mv	a4,a5
     6e2:	02f00793          	li	a5,47
     6e6:	00e7fb63          	bgeu	a5,a4,6fc <atoi+0x6a>
     6ea:	fd843783          	ld	a5,-40(s0)
     6ee:	0007c783          	lbu	a5,0(a5)
     6f2:	873e                	mv	a4,a5
     6f4:	03900793          	li	a5,57
     6f8:	fae7f6e3          	bgeu	a5,a4,6a4 <atoi+0x12>
  return n;
     6fc:	fec42783          	lw	a5,-20(s0)
}
     700:	853e                	mv	a0,a5
     702:	70a2                	ld	ra,40(sp)
     704:	7402                	ld	s0,32(sp)
     706:	6145                	addi	sp,sp,48
     708:	8082                	ret

000000000000070a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     70a:	7139                	addi	sp,sp,-64
     70c:	fc06                	sd	ra,56(sp)
     70e:	f822                	sd	s0,48(sp)
     710:	0080                	addi	s0,sp,64
     712:	fca43c23          	sd	a0,-40(s0)
     716:	fcb43823          	sd	a1,-48(s0)
     71a:	87b2                	mv	a5,a2
     71c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     720:	fd843783          	ld	a5,-40(s0)
     724:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     728:	fd043783          	ld	a5,-48(s0)
     72c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     730:	fe043703          	ld	a4,-32(s0)
     734:	fe843783          	ld	a5,-24(s0)
     738:	02e7fc63          	bgeu	a5,a4,770 <memmove+0x66>
    while(n-- > 0)
     73c:	a00d                	j	75e <memmove+0x54>
      *dst++ = *src++;
     73e:	fe043703          	ld	a4,-32(s0)
     742:	00170793          	addi	a5,a4,1
     746:	fef43023          	sd	a5,-32(s0)
     74a:	fe843783          	ld	a5,-24(s0)
     74e:	00178693          	addi	a3,a5,1
     752:	fed43423          	sd	a3,-24(s0)
     756:	00074703          	lbu	a4,0(a4)
     75a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     75e:	fcc42783          	lw	a5,-52(s0)
     762:	fff7871b          	addiw	a4,a5,-1
     766:	fce42623          	sw	a4,-52(s0)
     76a:	fcf04ae3          	bgtz	a5,73e <memmove+0x34>
     76e:	a891                	j	7c2 <memmove+0xb8>
  } else {
    dst += n;
     770:	fcc42783          	lw	a5,-52(s0)
     774:	fe843703          	ld	a4,-24(s0)
     778:	97ba                	add	a5,a5,a4
     77a:	fef43423          	sd	a5,-24(s0)
    src += n;
     77e:	fcc42783          	lw	a5,-52(s0)
     782:	fe043703          	ld	a4,-32(s0)
     786:	97ba                	add	a5,a5,a4
     788:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     78c:	a01d                	j	7b2 <memmove+0xa8>
      *--dst = *--src;
     78e:	fe043783          	ld	a5,-32(s0)
     792:	17fd                	addi	a5,a5,-1
     794:	fef43023          	sd	a5,-32(s0)
     798:	fe843783          	ld	a5,-24(s0)
     79c:	17fd                	addi	a5,a5,-1
     79e:	fef43423          	sd	a5,-24(s0)
     7a2:	fe043783          	ld	a5,-32(s0)
     7a6:	0007c703          	lbu	a4,0(a5)
     7aa:	fe843783          	ld	a5,-24(s0)
     7ae:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7b2:	fcc42783          	lw	a5,-52(s0)
     7b6:	fff7871b          	addiw	a4,a5,-1
     7ba:	fce42623          	sw	a4,-52(s0)
     7be:	fcf048e3          	bgtz	a5,78e <memmove+0x84>
  }
  return vdst;
     7c2:	fd843783          	ld	a5,-40(s0)
}
     7c6:	853e                	mv	a0,a5
     7c8:	70e2                	ld	ra,56(sp)
     7ca:	7442                	ld	s0,48(sp)
     7cc:	6121                	addi	sp,sp,64
     7ce:	8082                	ret

00000000000007d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     7d0:	7139                	addi	sp,sp,-64
     7d2:	fc06                	sd	ra,56(sp)
     7d4:	f822                	sd	s0,48(sp)
     7d6:	0080                	addi	s0,sp,64
     7d8:	fca43c23          	sd	a0,-40(s0)
     7dc:	fcb43823          	sd	a1,-48(s0)
     7e0:	87b2                	mv	a5,a2
     7e2:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     7e6:	fd843783          	ld	a5,-40(s0)
     7ea:	fef43423          	sd	a5,-24(s0)
     7ee:	fd043783          	ld	a5,-48(s0)
     7f2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7f6:	a0a1                	j	83e <memcmp+0x6e>
    if (*p1 != *p2) {
     7f8:	fe843783          	ld	a5,-24(s0)
     7fc:	0007c703          	lbu	a4,0(a5)
     800:	fe043783          	ld	a5,-32(s0)
     804:	0007c783          	lbu	a5,0(a5)
     808:	02f70163          	beq	a4,a5,82a <memcmp+0x5a>
      return *p1 - *p2;
     80c:	fe843783          	ld	a5,-24(s0)
     810:	0007c783          	lbu	a5,0(a5)
     814:	0007871b          	sext.w	a4,a5
     818:	fe043783          	ld	a5,-32(s0)
     81c:	0007c783          	lbu	a5,0(a5)
     820:	2781                	sext.w	a5,a5
     822:	40f707bb          	subw	a5,a4,a5
     826:	2781                	sext.w	a5,a5
     828:	a01d                	j	84e <memcmp+0x7e>
    }
    p1++;
     82a:	fe843783          	ld	a5,-24(s0)
     82e:	0785                	addi	a5,a5,1
     830:	fef43423          	sd	a5,-24(s0)
    p2++;
     834:	fe043783          	ld	a5,-32(s0)
     838:	0785                	addi	a5,a5,1
     83a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     83e:	fcc42783          	lw	a5,-52(s0)
     842:	fff7871b          	addiw	a4,a5,-1
     846:	fce42623          	sw	a4,-52(s0)
     84a:	f7dd                	bnez	a5,7f8 <memcmp+0x28>
  }
  return 0;
     84c:	4781                	li	a5,0
}
     84e:	853e                	mv	a0,a5
     850:	70e2                	ld	ra,56(sp)
     852:	7442                	ld	s0,48(sp)
     854:	6121                	addi	sp,sp,64
     856:	8082                	ret

0000000000000858 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     858:	7179                	addi	sp,sp,-48
     85a:	f406                	sd	ra,40(sp)
     85c:	f022                	sd	s0,32(sp)
     85e:	1800                	addi	s0,sp,48
     860:	fea43423          	sd	a0,-24(s0)
     864:	feb43023          	sd	a1,-32(s0)
     868:	87b2                	mv	a5,a2
     86a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     86e:	fdc42783          	lw	a5,-36(s0)
     872:	863e                	mv	a2,a5
     874:	fe043583          	ld	a1,-32(s0)
     878:	fe843503          	ld	a0,-24(s0)
     87c:	e8fff0ef          	jal	70a <memmove>
     880:	87aa                	mv	a5,a0
}
     882:	853e                	mv	a0,a5
     884:	70a2                	ld	ra,40(sp)
     886:	7402                	ld	s0,32(sp)
     888:	6145                	addi	sp,sp,48
     88a:	8082                	ret

000000000000088c <sbrk>:

char *
sbrk(int n) {
     88c:	1101                	addi	sp,sp,-32
     88e:	ec06                	sd	ra,24(sp)
     890:	e822                	sd	s0,16(sp)
     892:	1000                	addi	s0,sp,32
     894:	87aa                	mv	a5,a0
     896:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     89a:	fec42783          	lw	a5,-20(s0)
     89e:	4585                	li	a1,1
     8a0:	853e                	mv	a0,a5
     8a2:	0c6000ef          	jal	968 <sys_sbrk>
     8a6:	87aa                	mv	a5,a0
}
     8a8:	853e                	mv	a0,a5
     8aa:	60e2                	ld	ra,24(sp)
     8ac:	6442                	ld	s0,16(sp)
     8ae:	6105                	addi	sp,sp,32
     8b0:	8082                	ret

00000000000008b2 <sbrklazy>:

char *
sbrklazy(int n) {
     8b2:	1101                	addi	sp,sp,-32
     8b4:	ec06                	sd	ra,24(sp)
     8b6:	e822                	sd	s0,16(sp)
     8b8:	1000                	addi	s0,sp,32
     8ba:	87aa                	mv	a5,a0
     8bc:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     8c0:	fec42783          	lw	a5,-20(s0)
     8c4:	4589                	li	a1,2
     8c6:	853e                	mv	a0,a5
     8c8:	0a0000ef          	jal	968 <sys_sbrk>
     8cc:	87aa                	mv	a5,a0
}
     8ce:	853e                	mv	a0,a5
     8d0:	60e2                	ld	ra,24(sp)
     8d2:	6442                	ld	s0,16(sp)
     8d4:	6105                	addi	sp,sp,32
     8d6:	8082                	ret

00000000000008d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     8d8:	4885                	li	a7,1
 ecall
     8da:	00000073          	ecall
 ret
     8de:	8082                	ret

00000000000008e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
     8e0:	4889                	li	a7,2
 ecall
     8e2:	00000073          	ecall
 ret
     8e6:	8082                	ret

00000000000008e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
     8e8:	488d                	li	a7,3
 ecall
     8ea:	00000073          	ecall
 ret
     8ee:	8082                	ret

00000000000008f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     8f0:	4891                	li	a7,4
 ecall
     8f2:	00000073          	ecall
 ret
     8f6:	8082                	ret

00000000000008f8 <read>:
.global read
read:
 li a7, SYS_read
     8f8:	4895                	li	a7,5
 ecall
     8fa:	00000073          	ecall
 ret
     8fe:	8082                	ret

0000000000000900 <write>:
.global write
write:
 li a7, SYS_write
     900:	48c1                	li	a7,16
 ecall
     902:	00000073          	ecall
 ret
     906:	8082                	ret

0000000000000908 <close>:
.global close
close:
 li a7, SYS_close
     908:	48d5                	li	a7,21
 ecall
     90a:	00000073          	ecall
 ret
     90e:	8082                	ret

0000000000000910 <kill>:
.global kill
kill:
 li a7, SYS_kill
     910:	4899                	li	a7,6
 ecall
     912:	00000073          	ecall
 ret
     916:	8082                	ret

0000000000000918 <exec>:
.global exec
exec:
 li a7, SYS_exec
     918:	489d                	li	a7,7
 ecall
     91a:	00000073          	ecall
 ret
     91e:	8082                	ret

0000000000000920 <open>:
.global open
open:
 li a7, SYS_open
     920:	48bd                	li	a7,15
 ecall
     922:	00000073          	ecall
 ret
     926:	8082                	ret

0000000000000928 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     928:	48c5                	li	a7,17
 ecall
     92a:	00000073          	ecall
 ret
     92e:	8082                	ret

0000000000000930 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     930:	48c9                	li	a7,18
 ecall
     932:	00000073          	ecall
 ret
     936:	8082                	ret

0000000000000938 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     938:	48a1                	li	a7,8
 ecall
     93a:	00000073          	ecall
 ret
     93e:	8082                	ret

0000000000000940 <link>:
.global link
link:
 li a7, SYS_link
     940:	48cd                	li	a7,19
 ecall
     942:	00000073          	ecall
 ret
     946:	8082                	ret

0000000000000948 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     948:	48d1                	li	a7,20
 ecall
     94a:	00000073          	ecall
 ret
     94e:	8082                	ret

0000000000000950 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     950:	48a5                	li	a7,9
 ecall
     952:	00000073          	ecall
 ret
     956:	8082                	ret

0000000000000958 <dup>:
.global dup
dup:
 li a7, SYS_dup
     958:	48a9                	li	a7,10
 ecall
     95a:	00000073          	ecall
 ret
     95e:	8082                	ret

0000000000000960 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     960:	48ad                	li	a7,11
 ecall
     962:	00000073          	ecall
 ret
     966:	8082                	ret

0000000000000968 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     968:	48b1                	li	a7,12
 ecall
     96a:	00000073          	ecall
 ret
     96e:	8082                	ret

0000000000000970 <pause>:
.global pause
pause:
 li a7, SYS_pause
     970:	48b5                	li	a7,13
 ecall
     972:	00000073          	ecall
 ret
     976:	8082                	ret

0000000000000978 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     978:	48b9                	li	a7,14
 ecall
     97a:	00000073          	ecall
 ret
     97e:	8082                	ret

0000000000000980 <top>:
.global top
top:
 li a7, SYS_top
     980:	48d9                	li	a7,22
 ecall
     982:	00000073          	ecall
 ret
     986:	8082                	ret

0000000000000988 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     988:	48dd                	li	a7,23
 ecall
     98a:	00000073          	ecall
 ret
     98e:	8082                	ret

0000000000000990 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     990:	1101                	addi	sp,sp,-32
     992:	ec06                	sd	ra,24(sp)
     994:	e822                	sd	s0,16(sp)
     996:	1000                	addi	s0,sp,32
     998:	87aa                	mv	a5,a0
     99a:	872e                	mv	a4,a1
     99c:	fef42623          	sw	a5,-20(s0)
     9a0:	87ba                	mv	a5,a4
     9a2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     9a6:	feb40713          	addi	a4,s0,-21
     9aa:	fec42783          	lw	a5,-20(s0)
     9ae:	4605                	li	a2,1
     9b0:	85ba                	mv	a1,a4
     9b2:	853e                	mv	a0,a5
     9b4:	f4dff0ef          	jal	900 <write>
}
     9b8:	0001                	nop
     9ba:	60e2                	ld	ra,24(sp)
     9bc:	6442                	ld	s0,16(sp)
     9be:	6105                	addi	sp,sp,32
     9c0:	8082                	ret

00000000000009c2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     9c2:	711d                	addi	sp,sp,-96
     9c4:	ec86                	sd	ra,88(sp)
     9c6:	e8a2                	sd	s0,80(sp)
     9c8:	1080                	addi	s0,sp,96
     9ca:	87aa                	mv	a5,a0
     9cc:	fab43823          	sd	a1,-80(s0)
     9d0:	8736                	mv	a4,a3
     9d2:	faf42e23          	sw	a5,-68(s0)
     9d6:	87b2                	mv	a5,a2
     9d8:	faf42c23          	sw	a5,-72(s0)
     9dc:	87ba                	mv	a5,a4
     9de:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     9e2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9e6:	fac42783          	lw	a5,-84(s0)
     9ea:	2781                	sext.w	a5,a5
     9ec:	cf99                	beqz	a5,a0a <printint+0x48>
     9ee:	fb043783          	ld	a5,-80(s0)
     9f2:	0007dc63          	bgez	a5,a0a <printint+0x48>
    neg = 1;
     9f6:	4785                	li	a5,1
     9f8:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9fc:	fb043783          	ld	a5,-80(s0)
     a00:	40f007b3          	neg	a5,a5
     a04:	fef43023          	sd	a5,-32(s0)
     a08:	a029                	j	a12 <printint+0x50>
  } else {
    x = xx;
     a0a:	fb043783          	ld	a5,-80(s0)
     a0e:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     a12:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     a16:	fb842783          	lw	a5,-72(s0)
     a1a:	fe043703          	ld	a4,-32(s0)
     a1e:	02f77733          	remu	a4,a4,a5
     a22:	fec42783          	lw	a5,-20(s0)
     a26:	0017869b          	addiw	a3,a5,1
     a2a:	fed42623          	sw	a3,-20(s0)
     a2e:	00001697          	auipc	a3,0x1
     a32:	5d268693          	addi	a3,a3,1490 # 2000 <digits>
     a36:	9736                	add	a4,a4,a3
     a38:	00074703          	lbu	a4,0(a4)
     a3c:	17c1                	addi	a5,a5,-16
     a3e:	97a2                	add	a5,a5,s0
     a40:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     a44:	fb842783          	lw	a5,-72(s0)
     a48:	fe043703          	ld	a4,-32(s0)
     a4c:	02f757b3          	divu	a5,a4,a5
     a50:	fef43023          	sd	a5,-32(s0)
     a54:	fe043783          	ld	a5,-32(s0)
     a58:	ffdd                	bnez	a5,a16 <printint+0x54>
  if(neg)
     a5a:	fe842783          	lw	a5,-24(s0)
     a5e:	2781                	sext.w	a5,a5
     a60:	cb95                	beqz	a5,a94 <printint+0xd2>
    buf[i++] = '-';
     a62:	fec42783          	lw	a5,-20(s0)
     a66:	0017871b          	addiw	a4,a5,1
     a6a:	fee42623          	sw	a4,-20(s0)
     a6e:	17c1                	addi	a5,a5,-16
     a70:	97a2                	add	a5,a5,s0
     a72:	02d00713          	li	a4,45
     a76:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     a7a:	a829                	j	a94 <printint+0xd2>
    putc(fd, buf[i]);
     a7c:	fec42783          	lw	a5,-20(s0)
     a80:	17c1                	addi	a5,a5,-16
     a82:	97a2                	add	a5,a5,s0
     a84:	fd87c703          	lbu	a4,-40(a5)
     a88:	fbc42783          	lw	a5,-68(s0)
     a8c:	85ba                	mv	a1,a4
     a8e:	853e                	mv	a0,a5
     a90:	f01ff0ef          	jal	990 <putc>
  while(--i >= 0)
     a94:	fec42783          	lw	a5,-20(s0)
     a98:	37fd                	addiw	a5,a5,-1
     a9a:	fef42623          	sw	a5,-20(s0)
     a9e:	fec42783          	lw	a5,-20(s0)
     aa2:	2781                	sext.w	a5,a5
     aa4:	fc07dce3          	bgez	a5,a7c <printint+0xba>
}
     aa8:	0001                	nop
     aaa:	0001                	nop
     aac:	60e6                	ld	ra,88(sp)
     aae:	6446                	ld	s0,80(sp)
     ab0:	6125                	addi	sp,sp,96
     ab2:	8082                	ret

0000000000000ab4 <printptr>:

static void
printptr(int fd, uint64 x) {
     ab4:	7179                	addi	sp,sp,-48
     ab6:	f406                	sd	ra,40(sp)
     ab8:	f022                	sd	s0,32(sp)
     aba:	1800                	addi	s0,sp,48
     abc:	87aa                	mv	a5,a0
     abe:	fcb43823          	sd	a1,-48(s0)
     ac2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     ac6:	fdc42783          	lw	a5,-36(s0)
     aca:	03000593          	li	a1,48
     ace:	853e                	mv	a0,a5
     ad0:	ec1ff0ef          	jal	990 <putc>
  putc(fd, 'x');
     ad4:	fdc42783          	lw	a5,-36(s0)
     ad8:	07800593          	li	a1,120
     adc:	853e                	mv	a0,a5
     ade:	eb3ff0ef          	jal	990 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ae2:	fe042623          	sw	zero,-20(s0)
     ae6:	a81d                	j	b1c <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ae8:	fd043783          	ld	a5,-48(s0)
     aec:	93f1                	srli	a5,a5,0x3c
     aee:	00001717          	auipc	a4,0x1
     af2:	51270713          	addi	a4,a4,1298 # 2000 <digits>
     af6:	97ba                	add	a5,a5,a4
     af8:	0007c703          	lbu	a4,0(a5)
     afc:	fdc42783          	lw	a5,-36(s0)
     b00:	85ba                	mv	a1,a4
     b02:	853e                	mv	a0,a5
     b04:	e8dff0ef          	jal	990 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b08:	fec42783          	lw	a5,-20(s0)
     b0c:	2785                	addiw	a5,a5,1
     b0e:	fef42623          	sw	a5,-20(s0)
     b12:	fd043783          	ld	a5,-48(s0)
     b16:	0792                	slli	a5,a5,0x4
     b18:	fcf43823          	sd	a5,-48(s0)
     b1c:	fec42703          	lw	a4,-20(s0)
     b20:	47bd                	li	a5,15
     b22:	fce7f3e3          	bgeu	a5,a4,ae8 <printptr+0x34>
}
     b26:	0001                	nop
     b28:	0001                	nop
     b2a:	70a2                	ld	ra,40(sp)
     b2c:	7402                	ld	s0,32(sp)
     b2e:	6145                	addi	sp,sp,48
     b30:	8082                	ret

0000000000000b32 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b32:	715d                	addi	sp,sp,-80
     b34:	e486                	sd	ra,72(sp)
     b36:	e0a2                	sd	s0,64(sp)
     b38:	0880                	addi	s0,sp,80
     b3a:	87aa                	mv	a5,a0
     b3c:	fcb43023          	sd	a1,-64(s0)
     b40:	fac43c23          	sd	a2,-72(s0)
     b44:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     b48:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     b4c:	fc042e23          	sw	zero,-36(s0)
     b50:	a189                	j	f92 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     b52:	fdc42783          	lw	a5,-36(s0)
     b56:	fc043703          	ld	a4,-64(s0)
     b5a:	97ba                	add	a5,a5,a4
     b5c:	0007c783          	lbu	a5,0(a5)
     b60:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     b64:	fd842783          	lw	a5,-40(s0)
     b68:	2781                	sext.w	a5,a5
     b6a:	eb8d                	bnez	a5,b9c <vprintf+0x6a>
      if(c0 == '%'){
     b6c:	fd442783          	lw	a5,-44(s0)
     b70:	0007871b          	sext.w	a4,a5
     b74:	02500793          	li	a5,37
     b78:	00f71763          	bne	a4,a5,b86 <vprintf+0x54>
        state = '%';
     b7c:	02500793          	li	a5,37
     b80:	fcf42c23          	sw	a5,-40(s0)
     b84:	a111                	j	f88 <vprintf+0x456>
      } else {
        putc(fd, c0);
     b86:	fd442783          	lw	a5,-44(s0)
     b8a:	0ff7f713          	zext.b	a4,a5
     b8e:	fcc42783          	lw	a5,-52(s0)
     b92:	85ba                	mv	a1,a4
     b94:	853e                	mv	a0,a5
     b96:	dfbff0ef          	jal	990 <putc>
     b9a:	a6fd                	j	f88 <vprintf+0x456>
      }
    } else if(state == '%'){
     b9c:	fd842783          	lw	a5,-40(s0)
     ba0:	0007871b          	sext.w	a4,a5
     ba4:	02500793          	li	a5,37
     ba8:	3ef71063          	bne	a4,a5,f88 <vprintf+0x456>
      c1 = c2 = 0;
     bac:	fe042023          	sw	zero,-32(s0)
     bb0:	fe042783          	lw	a5,-32(s0)
     bb4:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     bb8:	fd442783          	lw	a5,-44(s0)
     bbc:	2781                	sext.w	a5,a5
     bbe:	cb99                	beqz	a5,bd4 <vprintf+0xa2>
     bc0:	fdc42783          	lw	a5,-36(s0)
     bc4:	0785                	addi	a5,a5,1
     bc6:	fc043703          	ld	a4,-64(s0)
     bca:	97ba                	add	a5,a5,a4
     bcc:	0007c783          	lbu	a5,0(a5)
     bd0:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     bd4:	fe442783          	lw	a5,-28(s0)
     bd8:	2781                	sext.w	a5,a5
     bda:	cb99                	beqz	a5,bf0 <vprintf+0xbe>
     bdc:	fdc42783          	lw	a5,-36(s0)
     be0:	0789                	addi	a5,a5,2
     be2:	fc043703          	ld	a4,-64(s0)
     be6:	97ba                	add	a5,a5,a4
     be8:	0007c783          	lbu	a5,0(a5)
     bec:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     bf0:	fd442783          	lw	a5,-44(s0)
     bf4:	0007871b          	sext.w	a4,a5
     bf8:	06400793          	li	a5,100
     bfc:	02f71363          	bne	a4,a5,c22 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     c00:	fb843783          	ld	a5,-72(s0)
     c04:	00878713          	addi	a4,a5,8
     c08:	fae43c23          	sd	a4,-72(s0)
     c0c:	439c                	lw	a5,0(a5)
     c0e:	873e                	mv	a4,a5
     c10:	fcc42783          	lw	a5,-52(s0)
     c14:	4685                	li	a3,1
     c16:	4629                	li	a2,10
     c18:	85ba                	mv	a1,a4
     c1a:	853e                	mv	a0,a5
     c1c:	da7ff0ef          	jal	9c2 <printint>
     c20:	a695                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     c22:	fd442783          	lw	a5,-44(s0)
     c26:	0007871b          	sext.w	a4,a5
     c2a:	06c00793          	li	a5,108
     c2e:	04f71063          	bne	a4,a5,c6e <vprintf+0x13c>
     c32:	fe442783          	lw	a5,-28(s0)
     c36:	0007871b          	sext.w	a4,a5
     c3a:	06400793          	li	a5,100
     c3e:	02f71863          	bne	a4,a5,c6e <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     c42:	fb843783          	ld	a5,-72(s0)
     c46:	00878713          	addi	a4,a5,8
     c4a:	fae43c23          	sd	a4,-72(s0)
     c4e:	639c                	ld	a5,0(a5)
     c50:	873e                	mv	a4,a5
     c52:	fcc42783          	lw	a5,-52(s0)
     c56:	4685                	li	a3,1
     c58:	4629                	li	a2,10
     c5a:	85ba                	mv	a1,a4
     c5c:	853e                	mv	a0,a5
     c5e:	d65ff0ef          	jal	9c2 <printint>
        i += 1;
     c62:	fdc42783          	lw	a5,-36(s0)
     c66:	2785                	addiw	a5,a5,1
     c68:	fcf42e23          	sw	a5,-36(s0)
     c6c:	ae21                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     c6e:	fd442783          	lw	a5,-44(s0)
     c72:	0007871b          	sext.w	a4,a5
     c76:	06c00793          	li	a5,108
     c7a:	04f71863          	bne	a4,a5,cca <vprintf+0x198>
     c7e:	fe442783          	lw	a5,-28(s0)
     c82:	0007871b          	sext.w	a4,a5
     c86:	06c00793          	li	a5,108
     c8a:	04f71063          	bne	a4,a5,cca <vprintf+0x198>
     c8e:	fe042783          	lw	a5,-32(s0)
     c92:	0007871b          	sext.w	a4,a5
     c96:	06400793          	li	a5,100
     c9a:	02f71863          	bne	a4,a5,cca <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     c9e:	fb843783          	ld	a5,-72(s0)
     ca2:	00878713          	addi	a4,a5,8
     ca6:	fae43c23          	sd	a4,-72(s0)
     caa:	639c                	ld	a5,0(a5)
     cac:	873e                	mv	a4,a5
     cae:	fcc42783          	lw	a5,-52(s0)
     cb2:	4685                	li	a3,1
     cb4:	4629                	li	a2,10
     cb6:	85ba                	mv	a1,a4
     cb8:	853e                	mv	a0,a5
     cba:	d09ff0ef          	jal	9c2 <printint>
        i += 2;
     cbe:	fdc42783          	lw	a5,-36(s0)
     cc2:	2789                	addiw	a5,a5,2
     cc4:	fcf42e23          	sw	a5,-36(s0)
     cc8:	ac75                	j	f84 <vprintf+0x452>
      } else if(c0 == 'u'){
     cca:	fd442783          	lw	a5,-44(s0)
     cce:	0007871b          	sext.w	a4,a5
     cd2:	07500793          	li	a5,117
     cd6:	02f71563          	bne	a4,a5,d00 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     cda:	fb843783          	ld	a5,-72(s0)
     cde:	00878713          	addi	a4,a5,8
     ce2:	fae43c23          	sd	a4,-72(s0)
     ce6:	439c                	lw	a5,0(a5)
     ce8:	02079713          	slli	a4,a5,0x20
     cec:	9301                	srli	a4,a4,0x20
     cee:	fcc42783          	lw	a5,-52(s0)
     cf2:	4681                	li	a3,0
     cf4:	4629                	li	a2,10
     cf6:	85ba                	mv	a1,a4
     cf8:	853e                	mv	a0,a5
     cfa:	cc9ff0ef          	jal	9c2 <printint>
     cfe:	a459                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     d00:	fd442783          	lw	a5,-44(s0)
     d04:	0007871b          	sext.w	a4,a5
     d08:	06c00793          	li	a5,108
     d0c:	04f71063          	bne	a4,a5,d4c <vprintf+0x21a>
     d10:	fe442783          	lw	a5,-28(s0)
     d14:	0007871b          	sext.w	a4,a5
     d18:	07500793          	li	a5,117
     d1c:	02f71863          	bne	a4,a5,d4c <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     d20:	fb843783          	ld	a5,-72(s0)
     d24:	00878713          	addi	a4,a5,8
     d28:	fae43c23          	sd	a4,-72(s0)
     d2c:	639c                	ld	a5,0(a5)
     d2e:	873e                	mv	a4,a5
     d30:	fcc42783          	lw	a5,-52(s0)
     d34:	4681                	li	a3,0
     d36:	4629                	li	a2,10
     d38:	85ba                	mv	a1,a4
     d3a:	853e                	mv	a0,a5
     d3c:	c87ff0ef          	jal	9c2 <printint>
        i += 1;
     d40:	fdc42783          	lw	a5,-36(s0)
     d44:	2785                	addiw	a5,a5,1
     d46:	fcf42e23          	sw	a5,-36(s0)
     d4a:	ac2d                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     d4c:	fd442783          	lw	a5,-44(s0)
     d50:	0007871b          	sext.w	a4,a5
     d54:	06c00793          	li	a5,108
     d58:	04f71863          	bne	a4,a5,da8 <vprintf+0x276>
     d5c:	fe442783          	lw	a5,-28(s0)
     d60:	0007871b          	sext.w	a4,a5
     d64:	06c00793          	li	a5,108
     d68:	04f71063          	bne	a4,a5,da8 <vprintf+0x276>
     d6c:	fe042783          	lw	a5,-32(s0)
     d70:	0007871b          	sext.w	a4,a5
     d74:	07500793          	li	a5,117
     d78:	02f71863          	bne	a4,a5,da8 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     d7c:	fb843783          	ld	a5,-72(s0)
     d80:	00878713          	addi	a4,a5,8
     d84:	fae43c23          	sd	a4,-72(s0)
     d88:	639c                	ld	a5,0(a5)
     d8a:	873e                	mv	a4,a5
     d8c:	fcc42783          	lw	a5,-52(s0)
     d90:	4681                	li	a3,0
     d92:	4629                	li	a2,10
     d94:	85ba                	mv	a1,a4
     d96:	853e                	mv	a0,a5
     d98:	c2bff0ef          	jal	9c2 <printint>
        i += 2;
     d9c:	fdc42783          	lw	a5,-36(s0)
     da0:	2789                	addiw	a5,a5,2
     da2:	fcf42e23          	sw	a5,-36(s0)
     da6:	aaf9                	j	f84 <vprintf+0x452>
      } else if(c0 == 'x'){
     da8:	fd442783          	lw	a5,-44(s0)
     dac:	0007871b          	sext.w	a4,a5
     db0:	07800793          	li	a5,120
     db4:	02f71563          	bne	a4,a5,dde <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     db8:	fb843783          	ld	a5,-72(s0)
     dbc:	00878713          	addi	a4,a5,8
     dc0:	fae43c23          	sd	a4,-72(s0)
     dc4:	439c                	lw	a5,0(a5)
     dc6:	02079713          	slli	a4,a5,0x20
     dca:	9301                	srli	a4,a4,0x20
     dcc:	fcc42783          	lw	a5,-52(s0)
     dd0:	4681                	li	a3,0
     dd2:	4641                	li	a2,16
     dd4:	85ba                	mv	a1,a4
     dd6:	853e                	mv	a0,a5
     dd8:	bebff0ef          	jal	9c2 <printint>
     ddc:	a265                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     dde:	fd442783          	lw	a5,-44(s0)
     de2:	0007871b          	sext.w	a4,a5
     de6:	06c00793          	li	a5,108
     dea:	04f71063          	bne	a4,a5,e2a <vprintf+0x2f8>
     dee:	fe442783          	lw	a5,-28(s0)
     df2:	0007871b          	sext.w	a4,a5
     df6:	07800793          	li	a5,120
     dfa:	02f71863          	bne	a4,a5,e2a <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     dfe:	fb843783          	ld	a5,-72(s0)
     e02:	00878713          	addi	a4,a5,8
     e06:	fae43c23          	sd	a4,-72(s0)
     e0a:	639c                	ld	a5,0(a5)
     e0c:	873e                	mv	a4,a5
     e0e:	fcc42783          	lw	a5,-52(s0)
     e12:	4681                	li	a3,0
     e14:	4641                	li	a2,16
     e16:	85ba                	mv	a1,a4
     e18:	853e                	mv	a0,a5
     e1a:	ba9ff0ef          	jal	9c2 <printint>
        i += 1;
     e1e:	fdc42783          	lw	a5,-36(s0)
     e22:	2785                	addiw	a5,a5,1
     e24:	fcf42e23          	sw	a5,-36(s0)
     e28:	aab1                	j	f84 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e2a:	fd442783          	lw	a5,-44(s0)
     e2e:	0007871b          	sext.w	a4,a5
     e32:	06c00793          	li	a5,108
     e36:	04f71863          	bne	a4,a5,e86 <vprintf+0x354>
     e3a:	fe442783          	lw	a5,-28(s0)
     e3e:	0007871b          	sext.w	a4,a5
     e42:	06c00793          	li	a5,108
     e46:	04f71063          	bne	a4,a5,e86 <vprintf+0x354>
     e4a:	fe042783          	lw	a5,-32(s0)
     e4e:	0007871b          	sext.w	a4,a5
     e52:	07800793          	li	a5,120
     e56:	02f71863          	bne	a4,a5,e86 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e5a:	fb843783          	ld	a5,-72(s0)
     e5e:	00878713          	addi	a4,a5,8
     e62:	fae43c23          	sd	a4,-72(s0)
     e66:	639c                	ld	a5,0(a5)
     e68:	873e                	mv	a4,a5
     e6a:	fcc42783          	lw	a5,-52(s0)
     e6e:	4681                	li	a3,0
     e70:	4641                	li	a2,16
     e72:	85ba                	mv	a1,a4
     e74:	853e                	mv	a0,a5
     e76:	b4dff0ef          	jal	9c2 <printint>
        i += 2;
     e7a:	fdc42783          	lw	a5,-36(s0)
     e7e:	2789                	addiw	a5,a5,2
     e80:	fcf42e23          	sw	a5,-36(s0)
     e84:	a201                	j	f84 <vprintf+0x452>
      } else if(c0 == 'p'){
     e86:	fd442783          	lw	a5,-44(s0)
     e8a:	0007871b          	sext.w	a4,a5
     e8e:	07000793          	li	a5,112
     e92:	02f71063          	bne	a4,a5,eb2 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     e96:	fb843783          	ld	a5,-72(s0)
     e9a:	00878713          	addi	a4,a5,8
     e9e:	fae43c23          	sd	a4,-72(s0)
     ea2:	6398                	ld	a4,0(a5)
     ea4:	fcc42783          	lw	a5,-52(s0)
     ea8:	85ba                	mv	a1,a4
     eaa:	853e                	mv	a0,a5
     eac:	c09ff0ef          	jal	ab4 <printptr>
     eb0:	a8d1                	j	f84 <vprintf+0x452>
      } else if(c0 == 'c'){
     eb2:	fd442783          	lw	a5,-44(s0)
     eb6:	0007871b          	sext.w	a4,a5
     eba:	06300793          	li	a5,99
     ebe:	02f71263          	bne	a4,a5,ee2 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     ec2:	fb843783          	ld	a5,-72(s0)
     ec6:	00878713          	addi	a4,a5,8
     eca:	fae43c23          	sd	a4,-72(s0)
     ece:	439c                	lw	a5,0(a5)
     ed0:	0ff7f713          	zext.b	a4,a5
     ed4:	fcc42783          	lw	a5,-52(s0)
     ed8:	85ba                	mv	a1,a4
     eda:	853e                	mv	a0,a5
     edc:	ab5ff0ef          	jal	990 <putc>
     ee0:	a055                	j	f84 <vprintf+0x452>
      } else if(c0 == 's'){
     ee2:	fd442783          	lw	a5,-44(s0)
     ee6:	0007871b          	sext.w	a4,a5
     eea:	07300793          	li	a5,115
     eee:	04f71a63          	bne	a4,a5,f42 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     ef2:	fb843783          	ld	a5,-72(s0)
     ef6:	00878713          	addi	a4,a5,8
     efa:	fae43c23          	sd	a4,-72(s0)
     efe:	639c                	ld	a5,0(a5)
     f00:	fef43423          	sd	a5,-24(s0)
     f04:	fe843783          	ld	a5,-24(s0)
     f08:	e79d                	bnez	a5,f36 <vprintf+0x404>
          s = "(null)";
     f0a:	00000797          	auipc	a5,0x0
     f0e:	45e78793          	addi	a5,a5,1118 # 1368 <malloc+0x17c>
     f12:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     f16:	a005                	j	f36 <vprintf+0x404>
          putc(fd, *s);
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	0007c703          	lbu	a4,0(a5)
     f20:	fcc42783          	lw	a5,-52(s0)
     f24:	85ba                	mv	a1,a4
     f26:	853e                	mv	a0,a5
     f28:	a69ff0ef          	jal	990 <putc>
        for(; *s; s++)
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	0785                	addi	a5,a5,1
     f32:	fef43423          	sd	a5,-24(s0)
     f36:	fe843783          	ld	a5,-24(s0)
     f3a:	0007c783          	lbu	a5,0(a5)
     f3e:	ffe9                	bnez	a5,f18 <vprintf+0x3e6>
     f40:	a091                	j	f84 <vprintf+0x452>
      } else if(c0 == '%'){
     f42:	fd442783          	lw	a5,-44(s0)
     f46:	0007871b          	sext.w	a4,a5
     f4a:	02500793          	li	a5,37
     f4e:	00f71a63          	bne	a4,a5,f62 <vprintf+0x430>
        putc(fd, '%');
     f52:	fcc42783          	lw	a5,-52(s0)
     f56:	02500593          	li	a1,37
     f5a:	853e                	mv	a0,a5
     f5c:	a35ff0ef          	jal	990 <putc>
     f60:	a015                	j	f84 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f62:	fcc42783          	lw	a5,-52(s0)
     f66:	02500593          	li	a1,37
     f6a:	853e                	mv	a0,a5
     f6c:	a25ff0ef          	jal	990 <putc>
        putc(fd, c0);
     f70:	fd442783          	lw	a5,-44(s0)
     f74:	0ff7f713          	zext.b	a4,a5
     f78:	fcc42783          	lw	a5,-52(s0)
     f7c:	85ba                	mv	a1,a4
     f7e:	853e                	mv	a0,a5
     f80:	a11ff0ef          	jal	990 <putc>
      }

      state = 0;
     f84:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     f88:	fdc42783          	lw	a5,-36(s0)
     f8c:	2785                	addiw	a5,a5,1
     f8e:	fcf42e23          	sw	a5,-36(s0)
     f92:	fdc42783          	lw	a5,-36(s0)
     f96:	fc043703          	ld	a4,-64(s0)
     f9a:	97ba                	add	a5,a5,a4
     f9c:	0007c783          	lbu	a5,0(a5)
     fa0:	ba0799e3          	bnez	a5,b52 <vprintf+0x20>
    }
  }
}
     fa4:	0001                	nop
     fa6:	0001                	nop
     fa8:	60a6                	ld	ra,72(sp)
     faa:	6406                	ld	s0,64(sp)
     fac:	6161                	addi	sp,sp,80
     fae:	8082                	ret

0000000000000fb0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fb0:	7159                	addi	sp,sp,-112
     fb2:	fc06                	sd	ra,56(sp)
     fb4:	f822                	sd	s0,48(sp)
     fb6:	0080                	addi	s0,sp,64
     fb8:	fcb43823          	sd	a1,-48(s0)
     fbc:	e010                	sd	a2,0(s0)
     fbe:	e414                	sd	a3,8(s0)
     fc0:	e818                	sd	a4,16(s0)
     fc2:	ec1c                	sd	a5,24(s0)
     fc4:	03043023          	sd	a6,32(s0)
     fc8:	03143423          	sd	a7,40(s0)
     fcc:	87aa                	mv	a5,a0
     fce:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     fd2:	03040793          	addi	a5,s0,48
     fd6:	fcf43423          	sd	a5,-56(s0)
     fda:	fc843783          	ld	a5,-56(s0)
     fde:	fd078793          	addi	a5,a5,-48
     fe2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     fe6:	fe843703          	ld	a4,-24(s0)
     fea:	fdc42783          	lw	a5,-36(s0)
     fee:	863a                	mv	a2,a4
     ff0:	fd043583          	ld	a1,-48(s0)
     ff4:	853e                	mv	a0,a5
     ff6:	b3dff0ef          	jal	b32 <vprintf>
}
     ffa:	0001                	nop
     ffc:	70e2                	ld	ra,56(sp)
     ffe:	7442                	ld	s0,48(sp)
    1000:	6165                	addi	sp,sp,112
    1002:	8082                	ret

0000000000001004 <printf>:

void
printf(const char *fmt, ...)
{
    1004:	7159                	addi	sp,sp,-112
    1006:	f406                	sd	ra,40(sp)
    1008:	f022                	sd	s0,32(sp)
    100a:	1800                	addi	s0,sp,48
    100c:	fca43c23          	sd	a0,-40(s0)
    1010:	e40c                	sd	a1,8(s0)
    1012:	e810                	sd	a2,16(s0)
    1014:	ec14                	sd	a3,24(s0)
    1016:	f018                	sd	a4,32(s0)
    1018:	f41c                	sd	a5,40(s0)
    101a:	03043823          	sd	a6,48(s0)
    101e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1022:	04040793          	addi	a5,s0,64
    1026:	fcf43823          	sd	a5,-48(s0)
    102a:	fd043783          	ld	a5,-48(s0)
    102e:	fc878793          	addi	a5,a5,-56
    1032:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	863e                	mv	a2,a5
    103c:	fd843583          	ld	a1,-40(s0)
    1040:	4505                	li	a0,1
    1042:	af1ff0ef          	jal	b32 <vprintf>
}
    1046:	0001                	nop
    1048:	70a2                	ld	ra,40(sp)
    104a:	7402                	ld	s0,32(sp)
    104c:	6165                	addi	sp,sp,112
    104e:	8082                	ret

0000000000001050 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1050:	7179                	addi	sp,sp,-48
    1052:	f406                	sd	ra,40(sp)
    1054:	f022                	sd	s0,32(sp)
    1056:	1800                	addi	s0,sp,48
    1058:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    105c:	fd843783          	ld	a5,-40(s0)
    1060:	17c1                	addi	a5,a5,-16
    1062:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1066:	00001797          	auipc	a5,0x1
    106a:	3ca78793          	addi	a5,a5,970 # 2430 <freep>
    106e:	639c                	ld	a5,0(a5)
    1070:	fef43423          	sd	a5,-24(s0)
    1074:	a815                	j	10a8 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1076:	fe843783          	ld	a5,-24(s0)
    107a:	639c                	ld	a5,0(a5)
    107c:	fe843703          	ld	a4,-24(s0)
    1080:	00f76f63          	bltu	a4,a5,109e <free+0x4e>
    1084:	fe043703          	ld	a4,-32(s0)
    1088:	fe843783          	ld	a5,-24(s0)
    108c:	02e7eb63          	bltu	a5,a4,10c2 <free+0x72>
    1090:	fe843783          	ld	a5,-24(s0)
    1094:	639c                	ld	a5,0(a5)
    1096:	fe043703          	ld	a4,-32(s0)
    109a:	02f76463          	bltu	a4,a5,10c2 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109e:	fe843783          	ld	a5,-24(s0)
    10a2:	639c                	ld	a5,0(a5)
    10a4:	fef43423          	sd	a5,-24(s0)
    10a8:	fe043703          	ld	a4,-32(s0)
    10ac:	fe843783          	ld	a5,-24(s0)
    10b0:	fce7f3e3          	bgeu	a5,a4,1076 <free+0x26>
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	639c                	ld	a5,0(a5)
    10ba:	fe043703          	ld	a4,-32(s0)
    10be:	faf77ce3          	bgeu	a4,a5,1076 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10c2:	fe043783          	ld	a5,-32(s0)
    10c6:	479c                	lw	a5,8(a5)
    10c8:	1782                	slli	a5,a5,0x20
    10ca:	9381                	srli	a5,a5,0x20
    10cc:	0792                	slli	a5,a5,0x4
    10ce:	fe043703          	ld	a4,-32(s0)
    10d2:	973e                	add	a4,a4,a5
    10d4:	fe843783          	ld	a5,-24(s0)
    10d8:	639c                	ld	a5,0(a5)
    10da:	02f71763          	bne	a4,a5,1108 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    10de:	fe043783          	ld	a5,-32(s0)
    10e2:	4798                	lw	a4,8(a5)
    10e4:	fe843783          	ld	a5,-24(s0)
    10e8:	639c                	ld	a5,0(a5)
    10ea:	479c                	lw	a5,8(a5)
    10ec:	9fb9                	addw	a5,a5,a4
    10ee:	0007871b          	sext.w	a4,a5
    10f2:	fe043783          	ld	a5,-32(s0)
    10f6:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    10f8:	fe843783          	ld	a5,-24(s0)
    10fc:	639c                	ld	a5,0(a5)
    10fe:	6398                	ld	a4,0(a5)
    1100:	fe043783          	ld	a5,-32(s0)
    1104:	e398                	sd	a4,0(a5)
    1106:	a039                	j	1114 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    1108:	fe843783          	ld	a5,-24(s0)
    110c:	6398                	ld	a4,0(a5)
    110e:	fe043783          	ld	a5,-32(s0)
    1112:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1114:	fe843783          	ld	a5,-24(s0)
    1118:	479c                	lw	a5,8(a5)
    111a:	1782                	slli	a5,a5,0x20
    111c:	9381                	srli	a5,a5,0x20
    111e:	0792                	slli	a5,a5,0x4
    1120:	fe843703          	ld	a4,-24(s0)
    1124:	97ba                	add	a5,a5,a4
    1126:	fe043703          	ld	a4,-32(s0)
    112a:	02f71563          	bne	a4,a5,1154 <free+0x104>
    p->s.size += bp->s.size;
    112e:	fe843783          	ld	a5,-24(s0)
    1132:	4798                	lw	a4,8(a5)
    1134:	fe043783          	ld	a5,-32(s0)
    1138:	479c                	lw	a5,8(a5)
    113a:	9fb9                	addw	a5,a5,a4
    113c:	0007871b          	sext.w	a4,a5
    1140:	fe843783          	ld	a5,-24(s0)
    1144:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1146:	fe043783          	ld	a5,-32(s0)
    114a:	6398                	ld	a4,0(a5)
    114c:	fe843783          	ld	a5,-24(s0)
    1150:	e398                	sd	a4,0(a5)
    1152:	a031                	j	115e <free+0x10e>
  } else
    p->s.ptr = bp;
    1154:	fe843783          	ld	a5,-24(s0)
    1158:	fe043703          	ld	a4,-32(s0)
    115c:	e398                	sd	a4,0(a5)
  freep = p;
    115e:	00001797          	auipc	a5,0x1
    1162:	2d278793          	addi	a5,a5,722 # 2430 <freep>
    1166:	fe843703          	ld	a4,-24(s0)
    116a:	e398                	sd	a4,0(a5)
}
    116c:	0001                	nop
    116e:	70a2                	ld	ra,40(sp)
    1170:	7402                	ld	s0,32(sp)
    1172:	6145                	addi	sp,sp,48
    1174:	8082                	ret

0000000000001176 <morecore>:

static Header*
morecore(uint nu)
{
    1176:	7179                	addi	sp,sp,-48
    1178:	f406                	sd	ra,40(sp)
    117a:	f022                	sd	s0,32(sp)
    117c:	1800                	addi	s0,sp,48
    117e:	87aa                	mv	a5,a0
    1180:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1184:	fdc42783          	lw	a5,-36(s0)
    1188:	0007871b          	sext.w	a4,a5
    118c:	6785                	lui	a5,0x1
    118e:	00f77563          	bgeu	a4,a5,1198 <morecore+0x22>
    nu = 4096;
    1192:	6785                	lui	a5,0x1
    1194:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1198:	fdc42783          	lw	a5,-36(s0)
    119c:	0047979b          	slliw	a5,a5,0x4
    11a0:	2781                	sext.w	a5,a5
    11a2:	853e                	mv	a0,a5
    11a4:	ee8ff0ef          	jal	88c <sbrk>
    11a8:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    11ac:	fe843703          	ld	a4,-24(s0)
    11b0:	57fd                	li	a5,-1
    11b2:	00f71463          	bne	a4,a5,11ba <morecore+0x44>
    return 0;
    11b6:	4781                	li	a5,0
    11b8:	a02d                	j	11e2 <morecore+0x6c>
  hp = (Header*)p;
    11ba:	fe843783          	ld	a5,-24(s0)
    11be:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    11c2:	fe043783          	ld	a5,-32(s0)
    11c6:	fdc42703          	lw	a4,-36(s0)
    11ca:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    11cc:	fe043783          	ld	a5,-32(s0)
    11d0:	07c1                	addi	a5,a5,16 # 1010 <printf+0xc>
    11d2:	853e                	mv	a0,a5
    11d4:	e7dff0ef          	jal	1050 <free>
  return freep;
    11d8:	00001797          	auipc	a5,0x1
    11dc:	25878793          	addi	a5,a5,600 # 2430 <freep>
    11e0:	639c                	ld	a5,0(a5)
}
    11e2:	853e                	mv	a0,a5
    11e4:	70a2                	ld	ra,40(sp)
    11e6:	7402                	ld	s0,32(sp)
    11e8:	6145                	addi	sp,sp,48
    11ea:	8082                	ret

00000000000011ec <malloc>:

void*
malloc(uint nbytes)
{
    11ec:	7139                	addi	sp,sp,-64
    11ee:	fc06                	sd	ra,56(sp)
    11f0:	f822                	sd	s0,48(sp)
    11f2:	0080                	addi	s0,sp,64
    11f4:	87aa                	mv	a5,a0
    11f6:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11fa:	fcc46783          	lwu	a5,-52(s0)
    11fe:	07bd                	addi	a5,a5,15
    1200:	8391                	srli	a5,a5,0x4
    1202:	2781                	sext.w	a5,a5
    1204:	2785                	addiw	a5,a5,1
    1206:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    120a:	00001797          	auipc	a5,0x1
    120e:	22678793          	addi	a5,a5,550 # 2430 <freep>
    1212:	639c                	ld	a5,0(a5)
    1214:	fef43023          	sd	a5,-32(s0)
    1218:	fe043783          	ld	a5,-32(s0)
    121c:	ef95                	bnez	a5,1258 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    121e:	00001797          	auipc	a5,0x1
    1222:	20278793          	addi	a5,a5,514 # 2420 <base>
    1226:	fef43023          	sd	a5,-32(s0)
    122a:	00001797          	auipc	a5,0x1
    122e:	20678793          	addi	a5,a5,518 # 2430 <freep>
    1232:	fe043703          	ld	a4,-32(s0)
    1236:	e398                	sd	a4,0(a5)
    1238:	00001797          	auipc	a5,0x1
    123c:	1f878793          	addi	a5,a5,504 # 2430 <freep>
    1240:	6398                	ld	a4,0(a5)
    1242:	00001797          	auipc	a5,0x1
    1246:	1de78793          	addi	a5,a5,478 # 2420 <base>
    124a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    124c:	00001797          	auipc	a5,0x1
    1250:	1d478793          	addi	a5,a5,468 # 2420 <base>
    1254:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1258:	fe043783          	ld	a5,-32(s0)
    125c:	639c                	ld	a5,0(a5)
    125e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1262:	fe843783          	ld	a5,-24(s0)
    1266:	479c                	lw	a5,8(a5)
    1268:	fdc42703          	lw	a4,-36(s0)
    126c:	2701                	sext.w	a4,a4
    126e:	06e7e763          	bltu	a5,a4,12dc <malloc+0xf0>
      if(p->s.size == nunits)
    1272:	fe843783          	ld	a5,-24(s0)
    1276:	479c                	lw	a5,8(a5)
    1278:	fdc42703          	lw	a4,-36(s0)
    127c:	2701                	sext.w	a4,a4
    127e:	00f71963          	bne	a4,a5,1290 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1282:	fe843783          	ld	a5,-24(s0)
    1286:	6398                	ld	a4,0(a5)
    1288:	fe043783          	ld	a5,-32(s0)
    128c:	e398                	sd	a4,0(a5)
    128e:	a825                	j	12c6 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1290:	fe843783          	ld	a5,-24(s0)
    1294:	479c                	lw	a5,8(a5)
    1296:	fdc42703          	lw	a4,-36(s0)
    129a:	9f99                	subw	a5,a5,a4
    129c:	0007871b          	sext.w	a4,a5
    12a0:	fe843783          	ld	a5,-24(s0)
    12a4:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12a6:	fe843783          	ld	a5,-24(s0)
    12aa:	479c                	lw	a5,8(a5)
    12ac:	1782                	slli	a5,a5,0x20
    12ae:	9381                	srli	a5,a5,0x20
    12b0:	0792                	slli	a5,a5,0x4
    12b2:	fe843703          	ld	a4,-24(s0)
    12b6:	97ba                	add	a5,a5,a4
    12b8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    12bc:	fe843783          	ld	a5,-24(s0)
    12c0:	fdc42703          	lw	a4,-36(s0)
    12c4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    12c6:	00001797          	auipc	a5,0x1
    12ca:	16a78793          	addi	a5,a5,362 # 2430 <freep>
    12ce:	fe043703          	ld	a4,-32(s0)
    12d2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    12d4:	fe843783          	ld	a5,-24(s0)
    12d8:	07c1                	addi	a5,a5,16
    12da:	a081                	j	131a <malloc+0x12e>
    }
    if(p == freep)
    12dc:	00001797          	auipc	a5,0x1
    12e0:	15478793          	addi	a5,a5,340 # 2430 <freep>
    12e4:	639c                	ld	a5,0(a5)
    12e6:	fe843703          	ld	a4,-24(s0)
    12ea:	00f71e63          	bne	a4,a5,1306 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    12ee:	fdc42783          	lw	a5,-36(s0)
    12f2:	853e                	mv	a0,a5
    12f4:	e83ff0ef          	jal	1176 <morecore>
    12f8:	fea43423          	sd	a0,-24(s0)
    12fc:	fe843783          	ld	a5,-24(s0)
    1300:	e399                	bnez	a5,1306 <malloc+0x11a>
        return 0;
    1302:	4781                	li	a5,0
    1304:	a819                	j	131a <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1306:	fe843783          	ld	a5,-24(s0)
    130a:	fef43023          	sd	a5,-32(s0)
    130e:	fe843783          	ld	a5,-24(s0)
    1312:	639c                	ld	a5,0(a5)
    1314:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1318:	b7a9                	j	1262 <malloc+0x76>
  }
}
    131a:	853e                	mv	a0,a5
    131c:	70e2                	ld	ra,56(sp)
    131e:	7442                	ld	s0,48(sp)
    1320:	6121                	addi	sp,sp,64
    1322:	8082                	ret
