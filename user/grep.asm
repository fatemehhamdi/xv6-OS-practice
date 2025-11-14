
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
     154:	1d058593          	addi	a1,a1,464 # 1320 <malloc+0x13c>
     158:	4509                	li	a0,2
     15a:	64f000ef          	jal	fa8 <fprintf>
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
     1ce:	17650513          	addi	a0,a0,374 # 1340 <malloc+0x15c>
     1d2:	62b000ef          	jal	ffc <printf>
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

0000000000000988 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     988:	1101                	addi	sp,sp,-32
     98a:	ec06                	sd	ra,24(sp)
     98c:	e822                	sd	s0,16(sp)
     98e:	1000                	addi	s0,sp,32
     990:	87aa                	mv	a5,a0
     992:	872e                	mv	a4,a1
     994:	fef42623          	sw	a5,-20(s0)
     998:	87ba                	mv	a5,a4
     99a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     99e:	feb40713          	addi	a4,s0,-21
     9a2:	fec42783          	lw	a5,-20(s0)
     9a6:	4605                	li	a2,1
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	f55ff0ef          	jal	900 <write>
}
     9b0:	0001                	nop
     9b2:	60e2                	ld	ra,24(sp)
     9b4:	6442                	ld	s0,16(sp)
     9b6:	6105                	addi	sp,sp,32
     9b8:	8082                	ret

00000000000009ba <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     9ba:	711d                	addi	sp,sp,-96
     9bc:	ec86                	sd	ra,88(sp)
     9be:	e8a2                	sd	s0,80(sp)
     9c0:	1080                	addi	s0,sp,96
     9c2:	87aa                	mv	a5,a0
     9c4:	fab43823          	sd	a1,-80(s0)
     9c8:	8736                	mv	a4,a3
     9ca:	faf42e23          	sw	a5,-68(s0)
     9ce:	87b2                	mv	a5,a2
     9d0:	faf42c23          	sw	a5,-72(s0)
     9d4:	87ba                	mv	a5,a4
     9d6:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     9da:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9de:	fac42783          	lw	a5,-84(s0)
     9e2:	2781                	sext.w	a5,a5
     9e4:	cf99                	beqz	a5,a02 <printint+0x48>
     9e6:	fb043783          	ld	a5,-80(s0)
     9ea:	0007dc63          	bgez	a5,a02 <printint+0x48>
    neg = 1;
     9ee:	4785                	li	a5,1
     9f0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9f4:	fb043783          	ld	a5,-80(s0)
     9f8:	40f007b3          	neg	a5,a5
     9fc:	fef43023          	sd	a5,-32(s0)
     a00:	a029                	j	a0a <printint+0x50>
  } else {
    x = xx;
     a02:	fb043783          	ld	a5,-80(s0)
     a06:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     a0a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     a0e:	fb842783          	lw	a5,-72(s0)
     a12:	fe043703          	ld	a4,-32(s0)
     a16:	02f77733          	remu	a4,a4,a5
     a1a:	fec42783          	lw	a5,-20(s0)
     a1e:	0017869b          	addiw	a3,a5,1
     a22:	fed42623          	sw	a3,-20(s0)
     a26:	00001697          	auipc	a3,0x1
     a2a:	5da68693          	addi	a3,a3,1498 # 2000 <digits>
     a2e:	9736                	add	a4,a4,a3
     a30:	00074703          	lbu	a4,0(a4)
     a34:	17c1                	addi	a5,a5,-16
     a36:	97a2                	add	a5,a5,s0
     a38:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     a3c:	fb842783          	lw	a5,-72(s0)
     a40:	fe043703          	ld	a4,-32(s0)
     a44:	02f757b3          	divu	a5,a4,a5
     a48:	fef43023          	sd	a5,-32(s0)
     a4c:	fe043783          	ld	a5,-32(s0)
     a50:	ffdd                	bnez	a5,a0e <printint+0x54>
  if(neg)
     a52:	fe842783          	lw	a5,-24(s0)
     a56:	2781                	sext.w	a5,a5
     a58:	cb95                	beqz	a5,a8c <printint+0xd2>
    buf[i++] = '-';
     a5a:	fec42783          	lw	a5,-20(s0)
     a5e:	0017871b          	addiw	a4,a5,1
     a62:	fee42623          	sw	a4,-20(s0)
     a66:	17c1                	addi	a5,a5,-16
     a68:	97a2                	add	a5,a5,s0
     a6a:	02d00713          	li	a4,45
     a6e:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     a72:	a829                	j	a8c <printint+0xd2>
    putc(fd, buf[i]);
     a74:	fec42783          	lw	a5,-20(s0)
     a78:	17c1                	addi	a5,a5,-16
     a7a:	97a2                	add	a5,a5,s0
     a7c:	fd87c703          	lbu	a4,-40(a5)
     a80:	fbc42783          	lw	a5,-68(s0)
     a84:	85ba                	mv	a1,a4
     a86:	853e                	mv	a0,a5
     a88:	f01ff0ef          	jal	988 <putc>
  while(--i >= 0)
     a8c:	fec42783          	lw	a5,-20(s0)
     a90:	37fd                	addiw	a5,a5,-1
     a92:	fef42623          	sw	a5,-20(s0)
     a96:	fec42783          	lw	a5,-20(s0)
     a9a:	2781                	sext.w	a5,a5
     a9c:	fc07dce3          	bgez	a5,a74 <printint+0xba>
}
     aa0:	0001                	nop
     aa2:	0001                	nop
     aa4:	60e6                	ld	ra,88(sp)
     aa6:	6446                	ld	s0,80(sp)
     aa8:	6125                	addi	sp,sp,96
     aaa:	8082                	ret

0000000000000aac <printptr>:

static void
printptr(int fd, uint64 x) {
     aac:	7179                	addi	sp,sp,-48
     aae:	f406                	sd	ra,40(sp)
     ab0:	f022                	sd	s0,32(sp)
     ab2:	1800                	addi	s0,sp,48
     ab4:	87aa                	mv	a5,a0
     ab6:	fcb43823          	sd	a1,-48(s0)
     aba:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     abe:	fdc42783          	lw	a5,-36(s0)
     ac2:	03000593          	li	a1,48
     ac6:	853e                	mv	a0,a5
     ac8:	ec1ff0ef          	jal	988 <putc>
  putc(fd, 'x');
     acc:	fdc42783          	lw	a5,-36(s0)
     ad0:	07800593          	li	a1,120
     ad4:	853e                	mv	a0,a5
     ad6:	eb3ff0ef          	jal	988 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ada:	fe042623          	sw	zero,-20(s0)
     ade:	a81d                	j	b14 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ae0:	fd043783          	ld	a5,-48(s0)
     ae4:	93f1                	srli	a5,a5,0x3c
     ae6:	00001717          	auipc	a4,0x1
     aea:	51a70713          	addi	a4,a4,1306 # 2000 <digits>
     aee:	97ba                	add	a5,a5,a4
     af0:	0007c703          	lbu	a4,0(a5)
     af4:	fdc42783          	lw	a5,-36(s0)
     af8:	85ba                	mv	a1,a4
     afa:	853e                	mv	a0,a5
     afc:	e8dff0ef          	jal	988 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b00:	fec42783          	lw	a5,-20(s0)
     b04:	2785                	addiw	a5,a5,1
     b06:	fef42623          	sw	a5,-20(s0)
     b0a:	fd043783          	ld	a5,-48(s0)
     b0e:	0792                	slli	a5,a5,0x4
     b10:	fcf43823          	sd	a5,-48(s0)
     b14:	fec42703          	lw	a4,-20(s0)
     b18:	47bd                	li	a5,15
     b1a:	fce7f3e3          	bgeu	a5,a4,ae0 <printptr+0x34>
}
     b1e:	0001                	nop
     b20:	0001                	nop
     b22:	70a2                	ld	ra,40(sp)
     b24:	7402                	ld	s0,32(sp)
     b26:	6145                	addi	sp,sp,48
     b28:	8082                	ret

0000000000000b2a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b2a:	715d                	addi	sp,sp,-80
     b2c:	e486                	sd	ra,72(sp)
     b2e:	e0a2                	sd	s0,64(sp)
     b30:	0880                	addi	s0,sp,80
     b32:	87aa                	mv	a5,a0
     b34:	fcb43023          	sd	a1,-64(s0)
     b38:	fac43c23          	sd	a2,-72(s0)
     b3c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     b40:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     b44:	fc042e23          	sw	zero,-36(s0)
     b48:	a189                	j	f8a <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     b4a:	fdc42783          	lw	a5,-36(s0)
     b4e:	fc043703          	ld	a4,-64(s0)
     b52:	97ba                	add	a5,a5,a4
     b54:	0007c783          	lbu	a5,0(a5)
     b58:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     b5c:	fd842783          	lw	a5,-40(s0)
     b60:	2781                	sext.w	a5,a5
     b62:	eb8d                	bnez	a5,b94 <vprintf+0x6a>
      if(c0 == '%'){
     b64:	fd442783          	lw	a5,-44(s0)
     b68:	0007871b          	sext.w	a4,a5
     b6c:	02500793          	li	a5,37
     b70:	00f71763          	bne	a4,a5,b7e <vprintf+0x54>
        state = '%';
     b74:	02500793          	li	a5,37
     b78:	fcf42c23          	sw	a5,-40(s0)
     b7c:	a111                	j	f80 <vprintf+0x456>
      } else {
        putc(fd, c0);
     b7e:	fd442783          	lw	a5,-44(s0)
     b82:	0ff7f713          	zext.b	a4,a5
     b86:	fcc42783          	lw	a5,-52(s0)
     b8a:	85ba                	mv	a1,a4
     b8c:	853e                	mv	a0,a5
     b8e:	dfbff0ef          	jal	988 <putc>
     b92:	a6fd                	j	f80 <vprintf+0x456>
      }
    } else if(state == '%'){
     b94:	fd842783          	lw	a5,-40(s0)
     b98:	0007871b          	sext.w	a4,a5
     b9c:	02500793          	li	a5,37
     ba0:	3ef71063          	bne	a4,a5,f80 <vprintf+0x456>
      c1 = c2 = 0;
     ba4:	fe042023          	sw	zero,-32(s0)
     ba8:	fe042783          	lw	a5,-32(s0)
     bac:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     bb0:	fd442783          	lw	a5,-44(s0)
     bb4:	2781                	sext.w	a5,a5
     bb6:	cb99                	beqz	a5,bcc <vprintf+0xa2>
     bb8:	fdc42783          	lw	a5,-36(s0)
     bbc:	0785                	addi	a5,a5,1
     bbe:	fc043703          	ld	a4,-64(s0)
     bc2:	97ba                	add	a5,a5,a4
     bc4:	0007c783          	lbu	a5,0(a5)
     bc8:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     bcc:	fe442783          	lw	a5,-28(s0)
     bd0:	2781                	sext.w	a5,a5
     bd2:	cb99                	beqz	a5,be8 <vprintf+0xbe>
     bd4:	fdc42783          	lw	a5,-36(s0)
     bd8:	0789                	addi	a5,a5,2
     bda:	fc043703          	ld	a4,-64(s0)
     bde:	97ba                	add	a5,a5,a4
     be0:	0007c783          	lbu	a5,0(a5)
     be4:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     be8:	fd442783          	lw	a5,-44(s0)
     bec:	0007871b          	sext.w	a4,a5
     bf0:	06400793          	li	a5,100
     bf4:	02f71363          	bne	a4,a5,c1a <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     bf8:	fb843783          	ld	a5,-72(s0)
     bfc:	00878713          	addi	a4,a5,8
     c00:	fae43c23          	sd	a4,-72(s0)
     c04:	439c                	lw	a5,0(a5)
     c06:	873e                	mv	a4,a5
     c08:	fcc42783          	lw	a5,-52(s0)
     c0c:	4685                	li	a3,1
     c0e:	4629                	li	a2,10
     c10:	85ba                	mv	a1,a4
     c12:	853e                	mv	a0,a5
     c14:	da7ff0ef          	jal	9ba <printint>
     c18:	a695                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     c1a:	fd442783          	lw	a5,-44(s0)
     c1e:	0007871b          	sext.w	a4,a5
     c22:	06c00793          	li	a5,108
     c26:	04f71063          	bne	a4,a5,c66 <vprintf+0x13c>
     c2a:	fe442783          	lw	a5,-28(s0)
     c2e:	0007871b          	sext.w	a4,a5
     c32:	06400793          	li	a5,100
     c36:	02f71863          	bne	a4,a5,c66 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     c3a:	fb843783          	ld	a5,-72(s0)
     c3e:	00878713          	addi	a4,a5,8
     c42:	fae43c23          	sd	a4,-72(s0)
     c46:	639c                	ld	a5,0(a5)
     c48:	873e                	mv	a4,a5
     c4a:	fcc42783          	lw	a5,-52(s0)
     c4e:	4685                	li	a3,1
     c50:	4629                	li	a2,10
     c52:	85ba                	mv	a1,a4
     c54:	853e                	mv	a0,a5
     c56:	d65ff0ef          	jal	9ba <printint>
        i += 1;
     c5a:	fdc42783          	lw	a5,-36(s0)
     c5e:	2785                	addiw	a5,a5,1
     c60:	fcf42e23          	sw	a5,-36(s0)
     c64:	ae21                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     c66:	fd442783          	lw	a5,-44(s0)
     c6a:	0007871b          	sext.w	a4,a5
     c6e:	06c00793          	li	a5,108
     c72:	04f71863          	bne	a4,a5,cc2 <vprintf+0x198>
     c76:	fe442783          	lw	a5,-28(s0)
     c7a:	0007871b          	sext.w	a4,a5
     c7e:	06c00793          	li	a5,108
     c82:	04f71063          	bne	a4,a5,cc2 <vprintf+0x198>
     c86:	fe042783          	lw	a5,-32(s0)
     c8a:	0007871b          	sext.w	a4,a5
     c8e:	06400793          	li	a5,100
     c92:	02f71863          	bne	a4,a5,cc2 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     c96:	fb843783          	ld	a5,-72(s0)
     c9a:	00878713          	addi	a4,a5,8
     c9e:	fae43c23          	sd	a4,-72(s0)
     ca2:	639c                	ld	a5,0(a5)
     ca4:	873e                	mv	a4,a5
     ca6:	fcc42783          	lw	a5,-52(s0)
     caa:	4685                	li	a3,1
     cac:	4629                	li	a2,10
     cae:	85ba                	mv	a1,a4
     cb0:	853e                	mv	a0,a5
     cb2:	d09ff0ef          	jal	9ba <printint>
        i += 2;
     cb6:	fdc42783          	lw	a5,-36(s0)
     cba:	2789                	addiw	a5,a5,2
     cbc:	fcf42e23          	sw	a5,-36(s0)
     cc0:	ac75                	j	f7c <vprintf+0x452>
      } else if(c0 == 'u'){
     cc2:	fd442783          	lw	a5,-44(s0)
     cc6:	0007871b          	sext.w	a4,a5
     cca:	07500793          	li	a5,117
     cce:	02f71563          	bne	a4,a5,cf8 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     cd2:	fb843783          	ld	a5,-72(s0)
     cd6:	00878713          	addi	a4,a5,8
     cda:	fae43c23          	sd	a4,-72(s0)
     cde:	439c                	lw	a5,0(a5)
     ce0:	02079713          	slli	a4,a5,0x20
     ce4:	9301                	srli	a4,a4,0x20
     ce6:	fcc42783          	lw	a5,-52(s0)
     cea:	4681                	li	a3,0
     cec:	4629                	li	a2,10
     cee:	85ba                	mv	a1,a4
     cf0:	853e                	mv	a0,a5
     cf2:	cc9ff0ef          	jal	9ba <printint>
     cf6:	a459                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     cf8:	fd442783          	lw	a5,-44(s0)
     cfc:	0007871b          	sext.w	a4,a5
     d00:	06c00793          	li	a5,108
     d04:	04f71063          	bne	a4,a5,d44 <vprintf+0x21a>
     d08:	fe442783          	lw	a5,-28(s0)
     d0c:	0007871b          	sext.w	a4,a5
     d10:	07500793          	li	a5,117
     d14:	02f71863          	bne	a4,a5,d44 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     d18:	fb843783          	ld	a5,-72(s0)
     d1c:	00878713          	addi	a4,a5,8
     d20:	fae43c23          	sd	a4,-72(s0)
     d24:	639c                	ld	a5,0(a5)
     d26:	873e                	mv	a4,a5
     d28:	fcc42783          	lw	a5,-52(s0)
     d2c:	4681                	li	a3,0
     d2e:	4629                	li	a2,10
     d30:	85ba                	mv	a1,a4
     d32:	853e                	mv	a0,a5
     d34:	c87ff0ef          	jal	9ba <printint>
        i += 1;
     d38:	fdc42783          	lw	a5,-36(s0)
     d3c:	2785                	addiw	a5,a5,1
     d3e:	fcf42e23          	sw	a5,-36(s0)
     d42:	ac2d                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     d44:	fd442783          	lw	a5,-44(s0)
     d48:	0007871b          	sext.w	a4,a5
     d4c:	06c00793          	li	a5,108
     d50:	04f71863          	bne	a4,a5,da0 <vprintf+0x276>
     d54:	fe442783          	lw	a5,-28(s0)
     d58:	0007871b          	sext.w	a4,a5
     d5c:	06c00793          	li	a5,108
     d60:	04f71063          	bne	a4,a5,da0 <vprintf+0x276>
     d64:	fe042783          	lw	a5,-32(s0)
     d68:	0007871b          	sext.w	a4,a5
     d6c:	07500793          	li	a5,117
     d70:	02f71863          	bne	a4,a5,da0 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     d74:	fb843783          	ld	a5,-72(s0)
     d78:	00878713          	addi	a4,a5,8
     d7c:	fae43c23          	sd	a4,-72(s0)
     d80:	639c                	ld	a5,0(a5)
     d82:	873e                	mv	a4,a5
     d84:	fcc42783          	lw	a5,-52(s0)
     d88:	4681                	li	a3,0
     d8a:	4629                	li	a2,10
     d8c:	85ba                	mv	a1,a4
     d8e:	853e                	mv	a0,a5
     d90:	c2bff0ef          	jal	9ba <printint>
        i += 2;
     d94:	fdc42783          	lw	a5,-36(s0)
     d98:	2789                	addiw	a5,a5,2
     d9a:	fcf42e23          	sw	a5,-36(s0)
     d9e:	aaf9                	j	f7c <vprintf+0x452>
      } else if(c0 == 'x'){
     da0:	fd442783          	lw	a5,-44(s0)
     da4:	0007871b          	sext.w	a4,a5
     da8:	07800793          	li	a5,120
     dac:	02f71563          	bne	a4,a5,dd6 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     db0:	fb843783          	ld	a5,-72(s0)
     db4:	00878713          	addi	a4,a5,8
     db8:	fae43c23          	sd	a4,-72(s0)
     dbc:	439c                	lw	a5,0(a5)
     dbe:	02079713          	slli	a4,a5,0x20
     dc2:	9301                	srli	a4,a4,0x20
     dc4:	fcc42783          	lw	a5,-52(s0)
     dc8:	4681                	li	a3,0
     dca:	4641                	li	a2,16
     dcc:	85ba                	mv	a1,a4
     dce:	853e                	mv	a0,a5
     dd0:	bebff0ef          	jal	9ba <printint>
     dd4:	a265                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     dd6:	fd442783          	lw	a5,-44(s0)
     dda:	0007871b          	sext.w	a4,a5
     dde:	06c00793          	li	a5,108
     de2:	04f71063          	bne	a4,a5,e22 <vprintf+0x2f8>
     de6:	fe442783          	lw	a5,-28(s0)
     dea:	0007871b          	sext.w	a4,a5
     dee:	07800793          	li	a5,120
     df2:	02f71863          	bne	a4,a5,e22 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     df6:	fb843783          	ld	a5,-72(s0)
     dfa:	00878713          	addi	a4,a5,8
     dfe:	fae43c23          	sd	a4,-72(s0)
     e02:	639c                	ld	a5,0(a5)
     e04:	873e                	mv	a4,a5
     e06:	fcc42783          	lw	a5,-52(s0)
     e0a:	4681                	li	a3,0
     e0c:	4641                	li	a2,16
     e0e:	85ba                	mv	a1,a4
     e10:	853e                	mv	a0,a5
     e12:	ba9ff0ef          	jal	9ba <printint>
        i += 1;
     e16:	fdc42783          	lw	a5,-36(s0)
     e1a:	2785                	addiw	a5,a5,1
     e1c:	fcf42e23          	sw	a5,-36(s0)
     e20:	aab1                	j	f7c <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e22:	fd442783          	lw	a5,-44(s0)
     e26:	0007871b          	sext.w	a4,a5
     e2a:	06c00793          	li	a5,108
     e2e:	04f71863          	bne	a4,a5,e7e <vprintf+0x354>
     e32:	fe442783          	lw	a5,-28(s0)
     e36:	0007871b          	sext.w	a4,a5
     e3a:	06c00793          	li	a5,108
     e3e:	04f71063          	bne	a4,a5,e7e <vprintf+0x354>
     e42:	fe042783          	lw	a5,-32(s0)
     e46:	0007871b          	sext.w	a4,a5
     e4a:	07800793          	li	a5,120
     e4e:	02f71863          	bne	a4,a5,e7e <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e52:	fb843783          	ld	a5,-72(s0)
     e56:	00878713          	addi	a4,a5,8
     e5a:	fae43c23          	sd	a4,-72(s0)
     e5e:	639c                	ld	a5,0(a5)
     e60:	873e                	mv	a4,a5
     e62:	fcc42783          	lw	a5,-52(s0)
     e66:	4681                	li	a3,0
     e68:	4641                	li	a2,16
     e6a:	85ba                	mv	a1,a4
     e6c:	853e                	mv	a0,a5
     e6e:	b4dff0ef          	jal	9ba <printint>
        i += 2;
     e72:	fdc42783          	lw	a5,-36(s0)
     e76:	2789                	addiw	a5,a5,2
     e78:	fcf42e23          	sw	a5,-36(s0)
     e7c:	a201                	j	f7c <vprintf+0x452>
      } else if(c0 == 'p'){
     e7e:	fd442783          	lw	a5,-44(s0)
     e82:	0007871b          	sext.w	a4,a5
     e86:	07000793          	li	a5,112
     e8a:	02f71063          	bne	a4,a5,eaa <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     e8e:	fb843783          	ld	a5,-72(s0)
     e92:	00878713          	addi	a4,a5,8
     e96:	fae43c23          	sd	a4,-72(s0)
     e9a:	6398                	ld	a4,0(a5)
     e9c:	fcc42783          	lw	a5,-52(s0)
     ea0:	85ba                	mv	a1,a4
     ea2:	853e                	mv	a0,a5
     ea4:	c09ff0ef          	jal	aac <printptr>
     ea8:	a8d1                	j	f7c <vprintf+0x452>
      } else if(c0 == 'c'){
     eaa:	fd442783          	lw	a5,-44(s0)
     eae:	0007871b          	sext.w	a4,a5
     eb2:	06300793          	li	a5,99
     eb6:	02f71263          	bne	a4,a5,eda <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     eba:	fb843783          	ld	a5,-72(s0)
     ebe:	00878713          	addi	a4,a5,8
     ec2:	fae43c23          	sd	a4,-72(s0)
     ec6:	439c                	lw	a5,0(a5)
     ec8:	0ff7f713          	zext.b	a4,a5
     ecc:	fcc42783          	lw	a5,-52(s0)
     ed0:	85ba                	mv	a1,a4
     ed2:	853e                	mv	a0,a5
     ed4:	ab5ff0ef          	jal	988 <putc>
     ed8:	a055                	j	f7c <vprintf+0x452>
      } else if(c0 == 's'){
     eda:	fd442783          	lw	a5,-44(s0)
     ede:	0007871b          	sext.w	a4,a5
     ee2:	07300793          	li	a5,115
     ee6:	04f71a63          	bne	a4,a5,f3a <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     eea:	fb843783          	ld	a5,-72(s0)
     eee:	00878713          	addi	a4,a5,8
     ef2:	fae43c23          	sd	a4,-72(s0)
     ef6:	639c                	ld	a5,0(a5)
     ef8:	fef43423          	sd	a5,-24(s0)
     efc:	fe843783          	ld	a5,-24(s0)
     f00:	e79d                	bnez	a5,f2e <vprintf+0x404>
          s = "(null)";
     f02:	00000797          	auipc	a5,0x0
     f06:	45678793          	addi	a5,a5,1110 # 1358 <malloc+0x174>
     f0a:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     f0e:	a005                	j	f2e <vprintf+0x404>
          putc(fd, *s);
     f10:	fe843783          	ld	a5,-24(s0)
     f14:	0007c703          	lbu	a4,0(a5)
     f18:	fcc42783          	lw	a5,-52(s0)
     f1c:	85ba                	mv	a1,a4
     f1e:	853e                	mv	a0,a5
     f20:	a69ff0ef          	jal	988 <putc>
        for(; *s; s++)
     f24:	fe843783          	ld	a5,-24(s0)
     f28:	0785                	addi	a5,a5,1
     f2a:	fef43423          	sd	a5,-24(s0)
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	0007c783          	lbu	a5,0(a5)
     f36:	ffe9                	bnez	a5,f10 <vprintf+0x3e6>
     f38:	a091                	j	f7c <vprintf+0x452>
      } else if(c0 == '%'){
     f3a:	fd442783          	lw	a5,-44(s0)
     f3e:	0007871b          	sext.w	a4,a5
     f42:	02500793          	li	a5,37
     f46:	00f71a63          	bne	a4,a5,f5a <vprintf+0x430>
        putc(fd, '%');
     f4a:	fcc42783          	lw	a5,-52(s0)
     f4e:	02500593          	li	a1,37
     f52:	853e                	mv	a0,a5
     f54:	a35ff0ef          	jal	988 <putc>
     f58:	a015                	j	f7c <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f5a:	fcc42783          	lw	a5,-52(s0)
     f5e:	02500593          	li	a1,37
     f62:	853e                	mv	a0,a5
     f64:	a25ff0ef          	jal	988 <putc>
        putc(fd, c0);
     f68:	fd442783          	lw	a5,-44(s0)
     f6c:	0ff7f713          	zext.b	a4,a5
     f70:	fcc42783          	lw	a5,-52(s0)
     f74:	85ba                	mv	a1,a4
     f76:	853e                	mv	a0,a5
     f78:	a11ff0ef          	jal	988 <putc>
      }

      state = 0;
     f7c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     f80:	fdc42783          	lw	a5,-36(s0)
     f84:	2785                	addiw	a5,a5,1
     f86:	fcf42e23          	sw	a5,-36(s0)
     f8a:	fdc42783          	lw	a5,-36(s0)
     f8e:	fc043703          	ld	a4,-64(s0)
     f92:	97ba                	add	a5,a5,a4
     f94:	0007c783          	lbu	a5,0(a5)
     f98:	ba0799e3          	bnez	a5,b4a <vprintf+0x20>
    }
  }
}
     f9c:	0001                	nop
     f9e:	0001                	nop
     fa0:	60a6                	ld	ra,72(sp)
     fa2:	6406                	ld	s0,64(sp)
     fa4:	6161                	addi	sp,sp,80
     fa6:	8082                	ret

0000000000000fa8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fa8:	7159                	addi	sp,sp,-112
     faa:	fc06                	sd	ra,56(sp)
     fac:	f822                	sd	s0,48(sp)
     fae:	0080                	addi	s0,sp,64
     fb0:	fcb43823          	sd	a1,-48(s0)
     fb4:	e010                	sd	a2,0(s0)
     fb6:	e414                	sd	a3,8(s0)
     fb8:	e818                	sd	a4,16(s0)
     fba:	ec1c                	sd	a5,24(s0)
     fbc:	03043023          	sd	a6,32(s0)
     fc0:	03143423          	sd	a7,40(s0)
     fc4:	87aa                	mv	a5,a0
     fc6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     fca:	03040793          	addi	a5,s0,48
     fce:	fcf43423          	sd	a5,-56(s0)
     fd2:	fc843783          	ld	a5,-56(s0)
     fd6:	fd078793          	addi	a5,a5,-48
     fda:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     fde:	fe843703          	ld	a4,-24(s0)
     fe2:	fdc42783          	lw	a5,-36(s0)
     fe6:	863a                	mv	a2,a4
     fe8:	fd043583          	ld	a1,-48(s0)
     fec:	853e                	mv	a0,a5
     fee:	b3dff0ef          	jal	b2a <vprintf>
}
     ff2:	0001                	nop
     ff4:	70e2                	ld	ra,56(sp)
     ff6:	7442                	ld	s0,48(sp)
     ff8:	6165                	addi	sp,sp,112
     ffa:	8082                	ret

0000000000000ffc <printf>:

void
printf(const char *fmt, ...)
{
     ffc:	7159                	addi	sp,sp,-112
     ffe:	f406                	sd	ra,40(sp)
    1000:	f022                	sd	s0,32(sp)
    1002:	1800                	addi	s0,sp,48
    1004:	fca43c23          	sd	a0,-40(s0)
    1008:	e40c                	sd	a1,8(s0)
    100a:	e810                	sd	a2,16(s0)
    100c:	ec14                	sd	a3,24(s0)
    100e:	f018                	sd	a4,32(s0)
    1010:	f41c                	sd	a5,40(s0)
    1012:	03043823          	sd	a6,48(s0)
    1016:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    101a:	04040793          	addi	a5,s0,64
    101e:	fcf43823          	sd	a5,-48(s0)
    1022:	fd043783          	ld	a5,-48(s0)
    1026:	fc878793          	addi	a5,a5,-56
    102a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    102e:	fe843783          	ld	a5,-24(s0)
    1032:	863e                	mv	a2,a5
    1034:	fd843583          	ld	a1,-40(s0)
    1038:	4505                	li	a0,1
    103a:	af1ff0ef          	jal	b2a <vprintf>
}
    103e:	0001                	nop
    1040:	70a2                	ld	ra,40(sp)
    1042:	7402                	ld	s0,32(sp)
    1044:	6165                	addi	sp,sp,112
    1046:	8082                	ret

0000000000001048 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1048:	7179                	addi	sp,sp,-48
    104a:	f406                	sd	ra,40(sp)
    104c:	f022                	sd	s0,32(sp)
    104e:	1800                	addi	s0,sp,48
    1050:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1054:	fd843783          	ld	a5,-40(s0)
    1058:	17c1                	addi	a5,a5,-16
    105a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    105e:	00001797          	auipc	a5,0x1
    1062:	3d278793          	addi	a5,a5,978 # 2430 <freep>
    1066:	639c                	ld	a5,0(a5)
    1068:	fef43423          	sd	a5,-24(s0)
    106c:	a815                	j	10a0 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	639c                	ld	a5,0(a5)
    1074:	fe843703          	ld	a4,-24(s0)
    1078:	00f76f63          	bltu	a4,a5,1096 <free+0x4e>
    107c:	fe043703          	ld	a4,-32(s0)
    1080:	fe843783          	ld	a5,-24(s0)
    1084:	02e7eb63          	bltu	a5,a4,10ba <free+0x72>
    1088:	fe843783          	ld	a5,-24(s0)
    108c:	639c                	ld	a5,0(a5)
    108e:	fe043703          	ld	a4,-32(s0)
    1092:	02f76463          	bltu	a4,a5,10ba <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1096:	fe843783          	ld	a5,-24(s0)
    109a:	639c                	ld	a5,0(a5)
    109c:	fef43423          	sd	a5,-24(s0)
    10a0:	fe043703          	ld	a4,-32(s0)
    10a4:	fe843783          	ld	a5,-24(s0)
    10a8:	fce7f3e3          	bgeu	a5,a4,106e <free+0x26>
    10ac:	fe843783          	ld	a5,-24(s0)
    10b0:	639c                	ld	a5,0(a5)
    10b2:	fe043703          	ld	a4,-32(s0)
    10b6:	faf77ce3          	bgeu	a4,a5,106e <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10ba:	fe043783          	ld	a5,-32(s0)
    10be:	479c                	lw	a5,8(a5)
    10c0:	1782                	slli	a5,a5,0x20
    10c2:	9381                	srli	a5,a5,0x20
    10c4:	0792                	slli	a5,a5,0x4
    10c6:	fe043703          	ld	a4,-32(s0)
    10ca:	973e                	add	a4,a4,a5
    10cc:	fe843783          	ld	a5,-24(s0)
    10d0:	639c                	ld	a5,0(a5)
    10d2:	02f71763          	bne	a4,a5,1100 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    10d6:	fe043783          	ld	a5,-32(s0)
    10da:	4798                	lw	a4,8(a5)
    10dc:	fe843783          	ld	a5,-24(s0)
    10e0:	639c                	ld	a5,0(a5)
    10e2:	479c                	lw	a5,8(a5)
    10e4:	9fb9                	addw	a5,a5,a4
    10e6:	0007871b          	sext.w	a4,a5
    10ea:	fe043783          	ld	a5,-32(s0)
    10ee:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    10f0:	fe843783          	ld	a5,-24(s0)
    10f4:	639c                	ld	a5,0(a5)
    10f6:	6398                	ld	a4,0(a5)
    10f8:	fe043783          	ld	a5,-32(s0)
    10fc:	e398                	sd	a4,0(a5)
    10fe:	a039                	j	110c <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	6398                	ld	a4,0(a5)
    1106:	fe043783          	ld	a5,-32(s0)
    110a:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    110c:	fe843783          	ld	a5,-24(s0)
    1110:	479c                	lw	a5,8(a5)
    1112:	1782                	slli	a5,a5,0x20
    1114:	9381                	srli	a5,a5,0x20
    1116:	0792                	slli	a5,a5,0x4
    1118:	fe843703          	ld	a4,-24(s0)
    111c:	97ba                	add	a5,a5,a4
    111e:	fe043703          	ld	a4,-32(s0)
    1122:	02f71563          	bne	a4,a5,114c <free+0x104>
    p->s.size += bp->s.size;
    1126:	fe843783          	ld	a5,-24(s0)
    112a:	4798                	lw	a4,8(a5)
    112c:	fe043783          	ld	a5,-32(s0)
    1130:	479c                	lw	a5,8(a5)
    1132:	9fb9                	addw	a5,a5,a4
    1134:	0007871b          	sext.w	a4,a5
    1138:	fe843783          	ld	a5,-24(s0)
    113c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    113e:	fe043783          	ld	a5,-32(s0)
    1142:	6398                	ld	a4,0(a5)
    1144:	fe843783          	ld	a5,-24(s0)
    1148:	e398                	sd	a4,0(a5)
    114a:	a031                	j	1156 <free+0x10e>
  } else
    p->s.ptr = bp;
    114c:	fe843783          	ld	a5,-24(s0)
    1150:	fe043703          	ld	a4,-32(s0)
    1154:	e398                	sd	a4,0(a5)
  freep = p;
    1156:	00001797          	auipc	a5,0x1
    115a:	2da78793          	addi	a5,a5,730 # 2430 <freep>
    115e:	fe843703          	ld	a4,-24(s0)
    1162:	e398                	sd	a4,0(a5)
}
    1164:	0001                	nop
    1166:	70a2                	ld	ra,40(sp)
    1168:	7402                	ld	s0,32(sp)
    116a:	6145                	addi	sp,sp,48
    116c:	8082                	ret

000000000000116e <morecore>:

static Header*
morecore(uint nu)
{
    116e:	7179                	addi	sp,sp,-48
    1170:	f406                	sd	ra,40(sp)
    1172:	f022                	sd	s0,32(sp)
    1174:	1800                	addi	s0,sp,48
    1176:	87aa                	mv	a5,a0
    1178:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    117c:	fdc42783          	lw	a5,-36(s0)
    1180:	0007871b          	sext.w	a4,a5
    1184:	6785                	lui	a5,0x1
    1186:	00f77563          	bgeu	a4,a5,1190 <morecore+0x22>
    nu = 4096;
    118a:	6785                	lui	a5,0x1
    118c:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1190:	fdc42783          	lw	a5,-36(s0)
    1194:	0047979b          	slliw	a5,a5,0x4
    1198:	2781                	sext.w	a5,a5
    119a:	853e                	mv	a0,a5
    119c:	ef0ff0ef          	jal	88c <sbrk>
    11a0:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    11a4:	fe843703          	ld	a4,-24(s0)
    11a8:	57fd                	li	a5,-1
    11aa:	00f71463          	bne	a4,a5,11b2 <morecore+0x44>
    return 0;
    11ae:	4781                	li	a5,0
    11b0:	a02d                	j	11da <morecore+0x6c>
  hp = (Header*)p;
    11b2:	fe843783          	ld	a5,-24(s0)
    11b6:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    11ba:	fe043783          	ld	a5,-32(s0)
    11be:	fdc42703          	lw	a4,-36(s0)
    11c2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    11c4:	fe043783          	ld	a5,-32(s0)
    11c8:	07c1                	addi	a5,a5,16 # 1010 <printf+0x14>
    11ca:	853e                	mv	a0,a5
    11cc:	e7dff0ef          	jal	1048 <free>
  return freep;
    11d0:	00001797          	auipc	a5,0x1
    11d4:	26078793          	addi	a5,a5,608 # 2430 <freep>
    11d8:	639c                	ld	a5,0(a5)
}
    11da:	853e                	mv	a0,a5
    11dc:	70a2                	ld	ra,40(sp)
    11de:	7402                	ld	s0,32(sp)
    11e0:	6145                	addi	sp,sp,48
    11e2:	8082                	ret

00000000000011e4 <malloc>:

void*
malloc(uint nbytes)
{
    11e4:	7139                	addi	sp,sp,-64
    11e6:	fc06                	sd	ra,56(sp)
    11e8:	f822                	sd	s0,48(sp)
    11ea:	0080                	addi	s0,sp,64
    11ec:	87aa                	mv	a5,a0
    11ee:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11f2:	fcc46783          	lwu	a5,-52(s0)
    11f6:	07bd                	addi	a5,a5,15
    11f8:	8391                	srli	a5,a5,0x4
    11fa:	2781                	sext.w	a5,a5
    11fc:	2785                	addiw	a5,a5,1
    11fe:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1202:	00001797          	auipc	a5,0x1
    1206:	22e78793          	addi	a5,a5,558 # 2430 <freep>
    120a:	639c                	ld	a5,0(a5)
    120c:	fef43023          	sd	a5,-32(s0)
    1210:	fe043783          	ld	a5,-32(s0)
    1214:	ef95                	bnez	a5,1250 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1216:	00001797          	auipc	a5,0x1
    121a:	20a78793          	addi	a5,a5,522 # 2420 <base>
    121e:	fef43023          	sd	a5,-32(s0)
    1222:	00001797          	auipc	a5,0x1
    1226:	20e78793          	addi	a5,a5,526 # 2430 <freep>
    122a:	fe043703          	ld	a4,-32(s0)
    122e:	e398                	sd	a4,0(a5)
    1230:	00001797          	auipc	a5,0x1
    1234:	20078793          	addi	a5,a5,512 # 2430 <freep>
    1238:	6398                	ld	a4,0(a5)
    123a:	00001797          	auipc	a5,0x1
    123e:	1e678793          	addi	a5,a5,486 # 2420 <base>
    1242:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1244:	00001797          	auipc	a5,0x1
    1248:	1dc78793          	addi	a5,a5,476 # 2420 <base>
    124c:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1250:	fe043783          	ld	a5,-32(s0)
    1254:	639c                	ld	a5,0(a5)
    1256:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    125a:	fe843783          	ld	a5,-24(s0)
    125e:	479c                	lw	a5,8(a5)
    1260:	fdc42703          	lw	a4,-36(s0)
    1264:	2701                	sext.w	a4,a4
    1266:	06e7e763          	bltu	a5,a4,12d4 <malloc+0xf0>
      if(p->s.size == nunits)
    126a:	fe843783          	ld	a5,-24(s0)
    126e:	479c                	lw	a5,8(a5)
    1270:	fdc42703          	lw	a4,-36(s0)
    1274:	2701                	sext.w	a4,a4
    1276:	00f71963          	bne	a4,a5,1288 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    127a:	fe843783          	ld	a5,-24(s0)
    127e:	6398                	ld	a4,0(a5)
    1280:	fe043783          	ld	a5,-32(s0)
    1284:	e398                	sd	a4,0(a5)
    1286:	a825                	j	12be <malloc+0xda>
      else {
        p->s.size -= nunits;
    1288:	fe843783          	ld	a5,-24(s0)
    128c:	479c                	lw	a5,8(a5)
    128e:	fdc42703          	lw	a4,-36(s0)
    1292:	9f99                	subw	a5,a5,a4
    1294:	0007871b          	sext.w	a4,a5
    1298:	fe843783          	ld	a5,-24(s0)
    129c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    129e:	fe843783          	ld	a5,-24(s0)
    12a2:	479c                	lw	a5,8(a5)
    12a4:	1782                	slli	a5,a5,0x20
    12a6:	9381                	srli	a5,a5,0x20
    12a8:	0792                	slli	a5,a5,0x4
    12aa:	fe843703          	ld	a4,-24(s0)
    12ae:	97ba                	add	a5,a5,a4
    12b0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    12b4:	fe843783          	ld	a5,-24(s0)
    12b8:	fdc42703          	lw	a4,-36(s0)
    12bc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    12be:	00001797          	auipc	a5,0x1
    12c2:	17278793          	addi	a5,a5,370 # 2430 <freep>
    12c6:	fe043703          	ld	a4,-32(s0)
    12ca:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    12cc:	fe843783          	ld	a5,-24(s0)
    12d0:	07c1                	addi	a5,a5,16
    12d2:	a081                	j	1312 <malloc+0x12e>
    }
    if(p == freep)
    12d4:	00001797          	auipc	a5,0x1
    12d8:	15c78793          	addi	a5,a5,348 # 2430 <freep>
    12dc:	639c                	ld	a5,0(a5)
    12de:	fe843703          	ld	a4,-24(s0)
    12e2:	00f71e63          	bne	a4,a5,12fe <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    12e6:	fdc42783          	lw	a5,-36(s0)
    12ea:	853e                	mv	a0,a5
    12ec:	e83ff0ef          	jal	116e <morecore>
    12f0:	fea43423          	sd	a0,-24(s0)
    12f4:	fe843783          	ld	a5,-24(s0)
    12f8:	e399                	bnez	a5,12fe <malloc+0x11a>
        return 0;
    12fa:	4781                	li	a5,0
    12fc:	a819                	j	1312 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12fe:	fe843783          	ld	a5,-24(s0)
    1302:	fef43023          	sd	a5,-32(s0)
    1306:	fe843783          	ld	a5,-24(s0)
    130a:	639c                	ld	a5,0(a5)
    130c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1310:	b7a9                	j	125a <malloc+0x76>
  }
}
    1312:	853e                	mv	a0,a5
    1314:	70e2                	ld	ra,56(sp)
    1316:	7442                	ld	s0,48(sp)
    1318:	6121                	addi	sp,sp,64
    131a:	8082                	ret
