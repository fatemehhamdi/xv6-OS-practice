
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	fca43423          	sd	a0,-56(s0)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       e:	fc843503          	ld	a0,-56(s0)
      12:	3fa000ef          	jal	40c <strlen>
      16:	87aa                	mv	a5,a0
      18:	1782                	slli	a5,a5,0x20
      1a:	9381                	srli	a5,a5,0x20
      1c:	fc843703          	ld	a4,-56(s0)
      20:	97ba                	add	a5,a5,a4
      22:	fcf43c23          	sd	a5,-40(s0)
      26:	a031                	j	32 <fmtname+0x32>
      28:	fd843783          	ld	a5,-40(s0)
      2c:	17fd                	addi	a5,a5,-1
      2e:	fcf43c23          	sd	a5,-40(s0)
      32:	fd843703          	ld	a4,-40(s0)
      36:	fc843783          	ld	a5,-56(s0)
      3a:	00f76b63          	bltu	a4,a5,50 <fmtname+0x50>
      3e:	fd843783          	ld	a5,-40(s0)
      42:	0007c783          	lbu	a5,0(a5)
      46:	873e                	mv	a4,a5
      48:	02f00793          	li	a5,47
      4c:	fcf71ee3          	bne	a4,a5,28 <fmtname+0x28>
    ;
  p++;
      50:	fd843783          	ld	a5,-40(s0)
      54:	0785                	addi	a5,a5,1
      56:	fcf43c23          	sd	a5,-40(s0)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      5a:	fd843503          	ld	a0,-40(s0)
      5e:	3ae000ef          	jal	40c <strlen>
      62:	87aa                	mv	a5,a0
      64:	873e                	mv	a4,a5
      66:	47b5                	li	a5,13
      68:	00e7f563          	bgeu	a5,a4,72 <fmtname+0x72>
    return p;
      6c:	fd843783          	ld	a5,-40(s0)
      70:	a0b5                	j	dc <fmtname+0xdc>
  memmove(buf, p, strlen(p));
      72:	fd843503          	ld	a0,-40(s0)
      76:	396000ef          	jal	40c <strlen>
      7a:	87aa                	mv	a5,a0
      7c:	863e                	mv	a2,a5
      7e:	fd843583          	ld	a1,-40(s0)
      82:	00002517          	auipc	a0,0x2
      86:	f9e50513          	addi	a0,a0,-98 # 2020 <buf.0>
      8a:	5dc000ef          	jal	666 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      8e:	fd843503          	ld	a0,-40(s0)
      92:	37a000ef          	jal	40c <strlen>
      96:	87aa                	mv	a5,a0
      98:	02079713          	slli	a4,a5,0x20
      9c:	9301                	srli	a4,a4,0x20
      9e:	00002797          	auipc	a5,0x2
      a2:	f8278793          	addi	a5,a5,-126 # 2020 <buf.0>
      a6:	00f704b3          	add	s1,a4,a5
      aa:	fd843503          	ld	a0,-40(s0)
      ae:	35e000ef          	jal	40c <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	873e                	mv	a4,a5
      b6:	47b9                	li	a5,14
      b8:	9f99                	subw	a5,a5,a4
      ba:	2781                	sext.w	a5,a5
      bc:	863e                	mv	a2,a5
      be:	02000593          	li	a1,32
      c2:	8526                	mv	a0,s1
      c4:	382000ef          	jal	446 <memset>
  buf[sizeof(buf)-1] = '\0';
      c8:	00002797          	auipc	a5,0x2
      cc:	f5878793          	addi	a5,a5,-168 # 2020 <buf.0>
      d0:	00078723          	sb	zero,14(a5)
  return buf;
      d4:	00002797          	auipc	a5,0x2
      d8:	f4c78793          	addi	a5,a5,-180 # 2020 <buf.0>
}
      dc:	853e                	mv	a0,a5
      de:	70e2                	ld	ra,56(sp)
      e0:	7442                	ld	s0,48(sp)
      e2:	74a2                	ld	s1,40(sp)
      e4:	6121                	addi	sp,sp,64
      e6:	8082                	ret

00000000000000e8 <ls>:

void
ls(char *path)
{
      e8:	da010113          	addi	sp,sp,-608
      ec:	24113c23          	sd	ra,600(sp)
      f0:	24813823          	sd	s0,592(sp)
      f4:	1480                	addi	s0,sp,608
      f6:	daa43423          	sd	a0,-600(s0)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
      fa:	4581                	li	a1,0
      fc:	da843503          	ld	a0,-600(s0)
     100:	77c000ef          	jal	87c <open>
     104:	87aa                	mv	a5,a0
     106:	fef42623          	sw	a5,-20(s0)
     10a:	fec42783          	lw	a5,-20(s0)
     10e:	2781                	sext.w	a5,a5
     110:	0007dc63          	bgez	a5,128 <ls+0x40>
    fprintf(2, "ls: cannot open %s\n", path);
     114:	da843603          	ld	a2,-600(s0)
     118:	00001597          	auipc	a1,0x1
     11c:	16858593          	addi	a1,a1,360 # 1280 <malloc+0x138>
     120:	4509                	li	a0,2
     122:	5eb000ef          	jal	f0c <fprintf>
    return;
     126:	a241                	j	2a6 <ls+0x1be>
  }

  if(fstat(fd, &st) < 0){
     128:	db840713          	addi	a4,s0,-584
     12c:	fec42783          	lw	a5,-20(s0)
     130:	85ba                	mv	a1,a4
     132:	853e                	mv	a0,a5
     134:	760000ef          	jal	894 <fstat>
     138:	87aa                	mv	a5,a0
     13a:	0207d163          	bgez	a5,15c <ls+0x74>
    fprintf(2, "ls: cannot stat %s\n", path);
     13e:	da843603          	ld	a2,-600(s0)
     142:	00001597          	auipc	a1,0x1
     146:	15658593          	addi	a1,a1,342 # 1298 <malloc+0x150>
     14a:	4509                	li	a0,2
     14c:	5c1000ef          	jal	f0c <fprintf>
    close(fd);
     150:	fec42783          	lw	a5,-20(s0)
     154:	853e                	mv	a0,a5
     156:	70e000ef          	jal	864 <close>
    return;
     15a:	a2b1                	j	2a6 <ls+0x1be>
  }

  switch(st.type){
     15c:	dc041783          	lh	a5,-576(s0)
     160:	4705                	li	a4,1
     162:	02e78f63          	beq	a5,a4,1a0 <ls+0xb8>
     166:	12f05b63          	blez	a5,29c <ls+0x1b4>
     16a:	37f9                	addiw	a5,a5,-2
     16c:	0007871b          	sext.w	a4,a5
     170:	4785                	li	a5,1
     172:	12e7e563          	bltu	a5,a4,29c <ls+0x1b4>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
     176:	da843503          	ld	a0,-600(s0)
     17a:	e87ff0ef          	jal	0 <fmtname>
     17e:	85aa                	mv	a1,a0
     180:	dc041783          	lh	a5,-576(s0)
     184:	863e                	mv	a2,a5
     186:	dbc42783          	lw	a5,-580(s0)
     18a:	dc843703          	ld	a4,-568(s0)
     18e:	2701                	sext.w	a4,a4
     190:	86be                	mv	a3,a5
     192:	00001517          	auipc	a0,0x1
     196:	11e50513          	addi	a0,a0,286 # 12b0 <malloc+0x168>
     19a:	5c7000ef          	jal	f60 <printf>
    break;
     19e:	a8fd                	j	29c <ls+0x1b4>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1a0:	da843503          	ld	a0,-600(s0)
     1a4:	268000ef          	jal	40c <strlen>
     1a8:	87aa                	mv	a5,a0
     1aa:	27c1                	addiw	a5,a5,16
     1ac:	0007871b          	sext.w	a4,a5
     1b0:	20000793          	li	a5,512
     1b4:	00e7f963          	bgeu	a5,a4,1c6 <ls+0xde>
      printf("ls: path too long\n");
     1b8:	00001517          	auipc	a0,0x1
     1bc:	10850513          	addi	a0,a0,264 # 12c0 <malloc+0x178>
     1c0:	5a1000ef          	jal	f60 <printf>
      break;
     1c4:	a8e1                	j	29c <ls+0x1b4>
    }
    strcpy(buf, path);
     1c6:	de040793          	addi	a5,s0,-544
     1ca:	da843583          	ld	a1,-600(s0)
     1ce:	853e                	mv	a0,a5
     1d0:	184000ef          	jal	354 <strcpy>
    p = buf+strlen(buf);
     1d4:	de040793          	addi	a5,s0,-544
     1d8:	853e                	mv	a0,a5
     1da:	232000ef          	jal	40c <strlen>
     1de:	87aa                	mv	a5,a0
     1e0:	1782                	slli	a5,a5,0x20
     1e2:	9381                	srli	a5,a5,0x20
     1e4:	de040713          	addi	a4,s0,-544
     1e8:	97ba                	add	a5,a5,a4
     1ea:	fef43023          	sd	a5,-32(s0)
    *p++ = '/';
     1ee:	fe043783          	ld	a5,-32(s0)
     1f2:	00178713          	addi	a4,a5,1
     1f6:	fee43023          	sd	a4,-32(s0)
     1fa:	02f00713          	li	a4,47
     1fe:	00e78023          	sb	a4,0(a5)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     202:	a8b5                	j	27e <ls+0x196>
      if(de.inum == 0)
     204:	dd045783          	lhu	a5,-560(s0)
     208:	cbb5                	beqz	a5,27c <ls+0x194>
        continue;
      memmove(p, de.name, DIRSIZ);
     20a:	dd040793          	addi	a5,s0,-560
     20e:	0789                	addi	a5,a5,2
     210:	4639                	li	a2,14
     212:	85be                	mv	a1,a5
     214:	fe043503          	ld	a0,-32(s0)
     218:	44e000ef          	jal	666 <memmove>
      p[DIRSIZ] = 0;
     21c:	fe043783          	ld	a5,-32(s0)
     220:	07b9                	addi	a5,a5,14
     222:	00078023          	sb	zero,0(a5)
      if(stat(buf, &st) < 0){
     226:	db840713          	addi	a4,s0,-584
     22a:	de040793          	addi	a5,s0,-544
     22e:	85ba                	mv	a1,a4
     230:	853e                	mv	a0,a5
     232:	362000ef          	jal	594 <stat>
     236:	87aa                	mv	a5,a0
     238:	0007dc63          	bgez	a5,250 <ls+0x168>
        printf("ls: cannot stat %s\n", buf);
     23c:	de040793          	addi	a5,s0,-544
     240:	85be                	mv	a1,a5
     242:	00001517          	auipc	a0,0x1
     246:	05650513          	addi	a0,a0,86 # 1298 <malloc+0x150>
     24a:	517000ef          	jal	f60 <printf>
        continue;
     24e:	a805                	j	27e <ls+0x196>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
     250:	de040793          	addi	a5,s0,-544
     254:	853e                	mv	a0,a5
     256:	dabff0ef          	jal	0 <fmtname>
     25a:	85aa                	mv	a1,a0
     25c:	dc041783          	lh	a5,-576(s0)
     260:	863e                	mv	a2,a5
     262:	dbc42783          	lw	a5,-580(s0)
     266:	dc843703          	ld	a4,-568(s0)
     26a:	2701                	sext.w	a4,a4
     26c:	86be                	mv	a3,a5
     26e:	00001517          	auipc	a0,0x1
     272:	04250513          	addi	a0,a0,66 # 12b0 <malloc+0x168>
     276:	4eb000ef          	jal	f60 <printf>
     27a:	a011                	j	27e <ls+0x196>
        continue;
     27c:	0001                	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     27e:	dd040713          	addi	a4,s0,-560
     282:	fec42783          	lw	a5,-20(s0)
     286:	4641                	li	a2,16
     288:	85ba                	mv	a1,a4
     28a:	853e                	mv	a0,a5
     28c:	5c8000ef          	jal	854 <read>
     290:	87aa                	mv	a5,a0
     292:	873e                	mv	a4,a5
     294:	47c1                	li	a5,16
     296:	f6f707e3          	beq	a4,a5,204 <ls+0x11c>
    }
    break;
     29a:	0001                	nop
  }
  close(fd);
     29c:	fec42783          	lw	a5,-20(s0)
     2a0:	853e                	mv	a0,a5
     2a2:	5c2000ef          	jal	864 <close>
}
     2a6:	25813083          	ld	ra,600(sp)
     2aa:	25013403          	ld	s0,592(sp)
     2ae:	26010113          	addi	sp,sp,608
     2b2:	8082                	ret

00000000000002b4 <main>:

int
main(int argc, char *argv[])
{
     2b4:	7179                	addi	sp,sp,-48
     2b6:	f406                	sd	ra,40(sp)
     2b8:	f022                	sd	s0,32(sp)
     2ba:	1800                	addi	s0,sp,48
     2bc:	87aa                	mv	a5,a0
     2be:	fcb43823          	sd	a1,-48(s0)
     2c2:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
     2c6:	fdc42783          	lw	a5,-36(s0)
     2ca:	0007871b          	sext.w	a4,a5
     2ce:	4785                	li	a5,1
     2d0:	00e7cb63          	blt	a5,a4,2e6 <main+0x32>
    ls(".");
     2d4:	00001517          	auipc	a0,0x1
     2d8:	00450513          	addi	a0,a0,4 # 12d8 <malloc+0x190>
     2dc:	e0dff0ef          	jal	e8 <ls>
    exit(0);
     2e0:	4501                	li	a0,0
     2e2:	55a000ef          	jal	83c <exit>
  }
  for(i=1; i<argc; i++)
     2e6:	4785                	li	a5,1
     2e8:	fef42623          	sw	a5,-20(s0)
     2ec:	a005                	j	30c <main+0x58>
    ls(argv[i]);
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	078e                	slli	a5,a5,0x3
     2f4:	fd043703          	ld	a4,-48(s0)
     2f8:	97ba                	add	a5,a5,a4
     2fa:	639c                	ld	a5,0(a5)
     2fc:	853e                	mv	a0,a5
     2fe:	debff0ef          	jal	e8 <ls>
  for(i=1; i<argc; i++)
     302:	fec42783          	lw	a5,-20(s0)
     306:	2785                	addiw	a5,a5,1
     308:	fef42623          	sw	a5,-20(s0)
     30c:	fec42783          	lw	a5,-20(s0)
     310:	873e                	mv	a4,a5
     312:	fdc42783          	lw	a5,-36(s0)
     316:	2701                	sext.w	a4,a4
     318:	2781                	sext.w	a5,a5
     31a:	fcf74ae3          	blt	a4,a5,2ee <main+0x3a>
  exit(0);
     31e:	4501                	li	a0,0
     320:	51c000ef          	jal	83c <exit>

0000000000000324 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     324:	7179                	addi	sp,sp,-48
     326:	f406                	sd	ra,40(sp)
     328:	f022                	sd	s0,32(sp)
     32a:	1800                	addi	s0,sp,48
     32c:	87aa                	mv	a5,a0
     32e:	fcb43823          	sd	a1,-48(s0)
     332:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     336:	fdc42783          	lw	a5,-36(s0)
     33a:	fd043583          	ld	a1,-48(s0)
     33e:	853e                	mv	a0,a5
     340:	f75ff0ef          	jal	2b4 <main>
     344:	87aa                	mv	a5,a0
     346:	fef42623          	sw	a5,-20(s0)
  exit(r);
     34a:	fec42783          	lw	a5,-20(s0)
     34e:	853e                	mv	a0,a5
     350:	4ec000ef          	jal	83c <exit>

0000000000000354 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     354:	7179                	addi	sp,sp,-48
     356:	f406                	sd	ra,40(sp)
     358:	f022                	sd	s0,32(sp)
     35a:	1800                	addi	s0,sp,48
     35c:	fca43c23          	sd	a0,-40(s0)
     360:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     364:	fd843783          	ld	a5,-40(s0)
     368:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     36c:	0001                	nop
     36e:	fd043703          	ld	a4,-48(s0)
     372:	00170793          	addi	a5,a4,1
     376:	fcf43823          	sd	a5,-48(s0)
     37a:	fd843783          	ld	a5,-40(s0)
     37e:	00178693          	addi	a3,a5,1
     382:	fcd43c23          	sd	a3,-40(s0)
     386:	00074703          	lbu	a4,0(a4)
     38a:	00e78023          	sb	a4,0(a5)
     38e:	0007c783          	lbu	a5,0(a5)
     392:	fff1                	bnez	a5,36e <strcpy+0x1a>
    ;
  return os;
     394:	fe843783          	ld	a5,-24(s0)
}
     398:	853e                	mv	a0,a5
     39a:	70a2                	ld	ra,40(sp)
     39c:	7402                	ld	s0,32(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	1000                	addi	s0,sp,32
     3aa:	fea43423          	sd	a0,-24(s0)
     3ae:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     3b2:	a819                	j	3c8 <strcmp+0x26>
    p++, q++;
     3b4:	fe843783          	ld	a5,-24(s0)
     3b8:	0785                	addi	a5,a5,1
     3ba:	fef43423          	sd	a5,-24(s0)
     3be:	fe043783          	ld	a5,-32(s0)
     3c2:	0785                	addi	a5,a5,1
     3c4:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     3c8:	fe843783          	ld	a5,-24(s0)
     3cc:	0007c783          	lbu	a5,0(a5)
     3d0:	cb99                	beqz	a5,3e6 <strcmp+0x44>
     3d2:	fe843783          	ld	a5,-24(s0)
     3d6:	0007c703          	lbu	a4,0(a5)
     3da:	fe043783          	ld	a5,-32(s0)
     3de:	0007c783          	lbu	a5,0(a5)
     3e2:	fcf709e3          	beq	a4,a5,3b4 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     3e6:	fe843783          	ld	a5,-24(s0)
     3ea:	0007c783          	lbu	a5,0(a5)
     3ee:	0007871b          	sext.w	a4,a5
     3f2:	fe043783          	ld	a5,-32(s0)
     3f6:	0007c783          	lbu	a5,0(a5)
     3fa:	2781                	sext.w	a5,a5
     3fc:	40f707bb          	subw	a5,a4,a5
     400:	2781                	sext.w	a5,a5
}
     402:	853e                	mv	a0,a5
     404:	60e2                	ld	ra,24(sp)
     406:	6442                	ld	s0,16(sp)
     408:	6105                	addi	sp,sp,32
     40a:	8082                	ret

000000000000040c <strlen>:

uint
strlen(const char *s)
{
     40c:	7179                	addi	sp,sp,-48
     40e:	f406                	sd	ra,40(sp)
     410:	f022                	sd	s0,32(sp)
     412:	1800                	addi	s0,sp,48
     414:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     418:	fe042623          	sw	zero,-20(s0)
     41c:	a031                	j	428 <strlen+0x1c>
     41e:	fec42783          	lw	a5,-20(s0)
     422:	2785                	addiw	a5,a5,1
     424:	fef42623          	sw	a5,-20(s0)
     428:	fec42783          	lw	a5,-20(s0)
     42c:	fd843703          	ld	a4,-40(s0)
     430:	97ba                	add	a5,a5,a4
     432:	0007c783          	lbu	a5,0(a5)
     436:	f7e5                	bnez	a5,41e <strlen+0x12>
    ;
  return n;
     438:	fec42783          	lw	a5,-20(s0)
}
     43c:	853e                	mv	a0,a5
     43e:	70a2                	ld	ra,40(sp)
     440:	7402                	ld	s0,32(sp)
     442:	6145                	addi	sp,sp,48
     444:	8082                	ret

0000000000000446 <memset>:

void*
memset(void *dst, int c, uint n)
{
     446:	7179                	addi	sp,sp,-48
     448:	f406                	sd	ra,40(sp)
     44a:	f022                	sd	s0,32(sp)
     44c:	1800                	addi	s0,sp,48
     44e:	fca43c23          	sd	a0,-40(s0)
     452:	87ae                	mv	a5,a1
     454:	8732                	mv	a4,a2
     456:	fcf42a23          	sw	a5,-44(s0)
     45a:	87ba                	mv	a5,a4
     45c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     460:	fd843783          	ld	a5,-40(s0)
     464:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     468:	fe042623          	sw	zero,-20(s0)
     46c:	a00d                	j	48e <memset+0x48>
    cdst[i] = c;
     46e:	fec42783          	lw	a5,-20(s0)
     472:	fe043703          	ld	a4,-32(s0)
     476:	97ba                	add	a5,a5,a4
     478:	fd442703          	lw	a4,-44(s0)
     47c:	0ff77713          	zext.b	a4,a4
     480:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     484:	fec42783          	lw	a5,-20(s0)
     488:	2785                	addiw	a5,a5,1
     48a:	fef42623          	sw	a5,-20(s0)
     48e:	fec42783          	lw	a5,-20(s0)
     492:	fd042703          	lw	a4,-48(s0)
     496:	2701                	sext.w	a4,a4
     498:	fce7ebe3          	bltu	a5,a4,46e <memset+0x28>
  }
  return dst;
     49c:	fd843783          	ld	a5,-40(s0)
}
     4a0:	853e                	mv	a0,a5
     4a2:	70a2                	ld	ra,40(sp)
     4a4:	7402                	ld	s0,32(sp)
     4a6:	6145                	addi	sp,sp,48
     4a8:	8082                	ret

00000000000004aa <strchr>:

char*
strchr(const char *s, char c)
{
     4aa:	1101                	addi	sp,sp,-32
     4ac:	ec06                	sd	ra,24(sp)
     4ae:	e822                	sd	s0,16(sp)
     4b0:	1000                	addi	s0,sp,32
     4b2:	fea43423          	sd	a0,-24(s0)
     4b6:	87ae                	mv	a5,a1
     4b8:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     4bc:	a01d                	j	4e2 <strchr+0x38>
    if(*s == c)
     4be:	fe843783          	ld	a5,-24(s0)
     4c2:	0007c703          	lbu	a4,0(a5)
     4c6:	fe744783          	lbu	a5,-25(s0)
     4ca:	0ff7f793          	zext.b	a5,a5
     4ce:	00e79563          	bne	a5,a4,4d8 <strchr+0x2e>
      return (char*)s;
     4d2:	fe843783          	ld	a5,-24(s0)
     4d6:	a821                	j	4ee <strchr+0x44>
  for(; *s; s++)
     4d8:	fe843783          	ld	a5,-24(s0)
     4dc:	0785                	addi	a5,a5,1
     4de:	fef43423          	sd	a5,-24(s0)
     4e2:	fe843783          	ld	a5,-24(s0)
     4e6:	0007c783          	lbu	a5,0(a5)
     4ea:	fbf1                	bnez	a5,4be <strchr+0x14>
  return 0;
     4ec:	4781                	li	a5,0
}
     4ee:	853e                	mv	a0,a5
     4f0:	60e2                	ld	ra,24(sp)
     4f2:	6442                	ld	s0,16(sp)
     4f4:	6105                	addi	sp,sp,32
     4f6:	8082                	ret

00000000000004f8 <gets>:

char*
gets(char *buf, int max)
{
     4f8:	7179                	addi	sp,sp,-48
     4fa:	f406                	sd	ra,40(sp)
     4fc:	f022                	sd	s0,32(sp)
     4fe:	1800                	addi	s0,sp,48
     500:	fca43c23          	sd	a0,-40(s0)
     504:	87ae                	mv	a5,a1
     506:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     50a:	fe042623          	sw	zero,-20(s0)
     50e:	a891                	j	562 <gets+0x6a>
    cc = read(0, &c, 1);
     510:	fe740793          	addi	a5,s0,-25
     514:	4605                	li	a2,1
     516:	85be                	mv	a1,a5
     518:	4501                	li	a0,0
     51a:	33a000ef          	jal	854 <read>
     51e:	87aa                	mv	a5,a0
     520:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     524:	fe842783          	lw	a5,-24(s0)
     528:	2781                	sext.w	a5,a5
     52a:	04f05663          	blez	a5,576 <gets+0x7e>
      break;
    buf[i++] = c;
     52e:	fec42783          	lw	a5,-20(s0)
     532:	0017871b          	addiw	a4,a5,1
     536:	fee42623          	sw	a4,-20(s0)
     53a:	873e                	mv	a4,a5
     53c:	fd843783          	ld	a5,-40(s0)
     540:	97ba                	add	a5,a5,a4
     542:	fe744703          	lbu	a4,-25(s0)
     546:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     54a:	fe744783          	lbu	a5,-25(s0)
     54e:	873e                	mv	a4,a5
     550:	47a9                	li	a5,10
     552:	02f70363          	beq	a4,a5,578 <gets+0x80>
     556:	fe744783          	lbu	a5,-25(s0)
     55a:	873e                	mv	a4,a5
     55c:	47b5                	li	a5,13
     55e:	00f70d63          	beq	a4,a5,578 <gets+0x80>
  for(i=0; i+1 < max; ){
     562:	fec42783          	lw	a5,-20(s0)
     566:	2785                	addiw	a5,a5,1
     568:	2781                	sext.w	a5,a5
     56a:	fd442703          	lw	a4,-44(s0)
     56e:	2701                	sext.w	a4,a4
     570:	fae7c0e3          	blt	a5,a4,510 <gets+0x18>
     574:	a011                	j	578 <gets+0x80>
      break;
     576:	0001                	nop
      break;
  }
  buf[i] = '\0';
     578:	fec42783          	lw	a5,-20(s0)
     57c:	fd843703          	ld	a4,-40(s0)
     580:	97ba                	add	a5,a5,a4
     582:	00078023          	sb	zero,0(a5)
  return buf;
     586:	fd843783          	ld	a5,-40(s0)
}
     58a:	853e                	mv	a0,a5
     58c:	70a2                	ld	ra,40(sp)
     58e:	7402                	ld	s0,32(sp)
     590:	6145                	addi	sp,sp,48
     592:	8082                	ret

0000000000000594 <stat>:

int
stat(const char *n, struct stat *st)
{
     594:	7179                	addi	sp,sp,-48
     596:	f406                	sd	ra,40(sp)
     598:	f022                	sd	s0,32(sp)
     59a:	1800                	addi	s0,sp,48
     59c:	fca43c23          	sd	a0,-40(s0)
     5a0:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5a4:	4581                	li	a1,0
     5a6:	fd843503          	ld	a0,-40(s0)
     5aa:	2d2000ef          	jal	87c <open>
     5ae:	87aa                	mv	a5,a0
     5b0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     5b4:	fec42783          	lw	a5,-20(s0)
     5b8:	2781                	sext.w	a5,a5
     5ba:	0007d463          	bgez	a5,5c2 <stat+0x2e>
    return -1;
     5be:	57fd                	li	a5,-1
     5c0:	a015                	j	5e4 <stat+0x50>
  r = fstat(fd, st);
     5c2:	fec42783          	lw	a5,-20(s0)
     5c6:	fd043583          	ld	a1,-48(s0)
     5ca:	853e                	mv	a0,a5
     5cc:	2c8000ef          	jal	894 <fstat>
     5d0:	87aa                	mv	a5,a0
     5d2:	fef42423          	sw	a5,-24(s0)
  close(fd);
     5d6:	fec42783          	lw	a5,-20(s0)
     5da:	853e                	mv	a0,a5
     5dc:	288000ef          	jal	864 <close>
  return r;
     5e0:	fe842783          	lw	a5,-24(s0)
}
     5e4:	853e                	mv	a0,a5
     5e6:	70a2                	ld	ra,40(sp)
     5e8:	7402                	ld	s0,32(sp)
     5ea:	6145                	addi	sp,sp,48
     5ec:	8082                	ret

00000000000005ee <atoi>:

int
atoi(const char *s)
{
     5ee:	7179                	addi	sp,sp,-48
     5f0:	f406                	sd	ra,40(sp)
     5f2:	f022                	sd	s0,32(sp)
     5f4:	1800                	addi	s0,sp,48
     5f6:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     5fa:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     5fe:	a81d                	j	634 <atoi+0x46>
    n = n*10 + *s++ - '0';
     600:	fec42783          	lw	a5,-20(s0)
     604:	873e                	mv	a4,a5
     606:	87ba                	mv	a5,a4
     608:	0027979b          	slliw	a5,a5,0x2
     60c:	9fb9                	addw	a5,a5,a4
     60e:	0017979b          	slliw	a5,a5,0x1
     612:	0007871b          	sext.w	a4,a5
     616:	fd843783          	ld	a5,-40(s0)
     61a:	00178693          	addi	a3,a5,1
     61e:	fcd43c23          	sd	a3,-40(s0)
     622:	0007c783          	lbu	a5,0(a5)
     626:	2781                	sext.w	a5,a5
     628:	9fb9                	addw	a5,a5,a4
     62a:	2781                	sext.w	a5,a5
     62c:	fd07879b          	addiw	a5,a5,-48
     630:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     634:	fd843783          	ld	a5,-40(s0)
     638:	0007c783          	lbu	a5,0(a5)
     63c:	873e                	mv	a4,a5
     63e:	02f00793          	li	a5,47
     642:	00e7fb63          	bgeu	a5,a4,658 <atoi+0x6a>
     646:	fd843783          	ld	a5,-40(s0)
     64a:	0007c783          	lbu	a5,0(a5)
     64e:	873e                	mv	a4,a5
     650:	03900793          	li	a5,57
     654:	fae7f6e3          	bgeu	a5,a4,600 <atoi+0x12>
  return n;
     658:	fec42783          	lw	a5,-20(s0)
}
     65c:	853e                	mv	a0,a5
     65e:	70a2                	ld	ra,40(sp)
     660:	7402                	ld	s0,32(sp)
     662:	6145                	addi	sp,sp,48
     664:	8082                	ret

0000000000000666 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     666:	7139                	addi	sp,sp,-64
     668:	fc06                	sd	ra,56(sp)
     66a:	f822                	sd	s0,48(sp)
     66c:	0080                	addi	s0,sp,64
     66e:	fca43c23          	sd	a0,-40(s0)
     672:	fcb43823          	sd	a1,-48(s0)
     676:	87b2                	mv	a5,a2
     678:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     67c:	fd843783          	ld	a5,-40(s0)
     680:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     684:	fd043783          	ld	a5,-48(s0)
     688:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     68c:	fe043703          	ld	a4,-32(s0)
     690:	fe843783          	ld	a5,-24(s0)
     694:	02e7fc63          	bgeu	a5,a4,6cc <memmove+0x66>
    while(n-- > 0)
     698:	a00d                	j	6ba <memmove+0x54>
      *dst++ = *src++;
     69a:	fe043703          	ld	a4,-32(s0)
     69e:	00170793          	addi	a5,a4,1
     6a2:	fef43023          	sd	a5,-32(s0)
     6a6:	fe843783          	ld	a5,-24(s0)
     6aa:	00178693          	addi	a3,a5,1
     6ae:	fed43423          	sd	a3,-24(s0)
     6b2:	00074703          	lbu	a4,0(a4)
     6b6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     6ba:	fcc42783          	lw	a5,-52(s0)
     6be:	fff7871b          	addiw	a4,a5,-1
     6c2:	fce42623          	sw	a4,-52(s0)
     6c6:	fcf04ae3          	bgtz	a5,69a <memmove+0x34>
     6ca:	a891                	j	71e <memmove+0xb8>
  } else {
    dst += n;
     6cc:	fcc42783          	lw	a5,-52(s0)
     6d0:	fe843703          	ld	a4,-24(s0)
     6d4:	97ba                	add	a5,a5,a4
     6d6:	fef43423          	sd	a5,-24(s0)
    src += n;
     6da:	fcc42783          	lw	a5,-52(s0)
     6de:	fe043703          	ld	a4,-32(s0)
     6e2:	97ba                	add	a5,a5,a4
     6e4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     6e8:	a01d                	j	70e <memmove+0xa8>
      *--dst = *--src;
     6ea:	fe043783          	ld	a5,-32(s0)
     6ee:	17fd                	addi	a5,a5,-1
     6f0:	fef43023          	sd	a5,-32(s0)
     6f4:	fe843783          	ld	a5,-24(s0)
     6f8:	17fd                	addi	a5,a5,-1
     6fa:	fef43423          	sd	a5,-24(s0)
     6fe:	fe043783          	ld	a5,-32(s0)
     702:	0007c703          	lbu	a4,0(a5)
     706:	fe843783          	ld	a5,-24(s0)
     70a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     70e:	fcc42783          	lw	a5,-52(s0)
     712:	fff7871b          	addiw	a4,a5,-1
     716:	fce42623          	sw	a4,-52(s0)
     71a:	fcf048e3          	bgtz	a5,6ea <memmove+0x84>
  }
  return vdst;
     71e:	fd843783          	ld	a5,-40(s0)
}
     722:	853e                	mv	a0,a5
     724:	70e2                	ld	ra,56(sp)
     726:	7442                	ld	s0,48(sp)
     728:	6121                	addi	sp,sp,64
     72a:	8082                	ret

000000000000072c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     72c:	7139                	addi	sp,sp,-64
     72e:	fc06                	sd	ra,56(sp)
     730:	f822                	sd	s0,48(sp)
     732:	0080                	addi	s0,sp,64
     734:	fca43c23          	sd	a0,-40(s0)
     738:	fcb43823          	sd	a1,-48(s0)
     73c:	87b2                	mv	a5,a2
     73e:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     742:	fd843783          	ld	a5,-40(s0)
     746:	fef43423          	sd	a5,-24(s0)
     74a:	fd043783          	ld	a5,-48(s0)
     74e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     752:	a0a1                	j	79a <memcmp+0x6e>
    if (*p1 != *p2) {
     754:	fe843783          	ld	a5,-24(s0)
     758:	0007c703          	lbu	a4,0(a5)
     75c:	fe043783          	ld	a5,-32(s0)
     760:	0007c783          	lbu	a5,0(a5)
     764:	02f70163          	beq	a4,a5,786 <memcmp+0x5a>
      return *p1 - *p2;
     768:	fe843783          	ld	a5,-24(s0)
     76c:	0007c783          	lbu	a5,0(a5)
     770:	0007871b          	sext.w	a4,a5
     774:	fe043783          	ld	a5,-32(s0)
     778:	0007c783          	lbu	a5,0(a5)
     77c:	2781                	sext.w	a5,a5
     77e:	40f707bb          	subw	a5,a4,a5
     782:	2781                	sext.w	a5,a5
     784:	a01d                	j	7aa <memcmp+0x7e>
    }
    p1++;
     786:	fe843783          	ld	a5,-24(s0)
     78a:	0785                	addi	a5,a5,1
     78c:	fef43423          	sd	a5,-24(s0)
    p2++;
     790:	fe043783          	ld	a5,-32(s0)
     794:	0785                	addi	a5,a5,1
     796:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     79a:	fcc42783          	lw	a5,-52(s0)
     79e:	fff7871b          	addiw	a4,a5,-1
     7a2:	fce42623          	sw	a4,-52(s0)
     7a6:	f7dd                	bnez	a5,754 <memcmp+0x28>
  }
  return 0;
     7a8:	4781                	li	a5,0
}
     7aa:	853e                	mv	a0,a5
     7ac:	70e2                	ld	ra,56(sp)
     7ae:	7442                	ld	s0,48(sp)
     7b0:	6121                	addi	sp,sp,64
     7b2:	8082                	ret

00000000000007b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     7b4:	7179                	addi	sp,sp,-48
     7b6:	f406                	sd	ra,40(sp)
     7b8:	f022                	sd	s0,32(sp)
     7ba:	1800                	addi	s0,sp,48
     7bc:	fea43423          	sd	a0,-24(s0)
     7c0:	feb43023          	sd	a1,-32(s0)
     7c4:	87b2                	mv	a5,a2
     7c6:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     7ca:	fdc42783          	lw	a5,-36(s0)
     7ce:	863e                	mv	a2,a5
     7d0:	fe043583          	ld	a1,-32(s0)
     7d4:	fe843503          	ld	a0,-24(s0)
     7d8:	e8fff0ef          	jal	666 <memmove>
     7dc:	87aa                	mv	a5,a0
}
     7de:	853e                	mv	a0,a5
     7e0:	70a2                	ld	ra,40(sp)
     7e2:	7402                	ld	s0,32(sp)
     7e4:	6145                	addi	sp,sp,48
     7e6:	8082                	ret

00000000000007e8 <sbrk>:

char *
sbrk(int n) {
     7e8:	1101                	addi	sp,sp,-32
     7ea:	ec06                	sd	ra,24(sp)
     7ec:	e822                	sd	s0,16(sp)
     7ee:	1000                	addi	s0,sp,32
     7f0:	87aa                	mv	a5,a0
     7f2:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     7f6:	fec42783          	lw	a5,-20(s0)
     7fa:	4585                	li	a1,1
     7fc:	853e                	mv	a0,a5
     7fe:	0c6000ef          	jal	8c4 <sys_sbrk>
     802:	87aa                	mv	a5,a0
}
     804:	853e                	mv	a0,a5
     806:	60e2                	ld	ra,24(sp)
     808:	6442                	ld	s0,16(sp)
     80a:	6105                	addi	sp,sp,32
     80c:	8082                	ret

000000000000080e <sbrklazy>:

char *
sbrklazy(int n) {
     80e:	1101                	addi	sp,sp,-32
     810:	ec06                	sd	ra,24(sp)
     812:	e822                	sd	s0,16(sp)
     814:	1000                	addi	s0,sp,32
     816:	87aa                	mv	a5,a0
     818:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     81c:	fec42783          	lw	a5,-20(s0)
     820:	4589                	li	a1,2
     822:	853e                	mv	a0,a5
     824:	0a0000ef          	jal	8c4 <sys_sbrk>
     828:	87aa                	mv	a5,a0
}
     82a:	853e                	mv	a0,a5
     82c:	60e2                	ld	ra,24(sp)
     82e:	6442                	ld	s0,16(sp)
     830:	6105                	addi	sp,sp,32
     832:	8082                	ret

0000000000000834 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     834:	4885                	li	a7,1
 ecall
     836:	00000073          	ecall
 ret
     83a:	8082                	ret

000000000000083c <exit>:
.global exit
exit:
 li a7, SYS_exit
     83c:	4889                	li	a7,2
 ecall
     83e:	00000073          	ecall
 ret
     842:	8082                	ret

0000000000000844 <wait>:
.global wait
wait:
 li a7, SYS_wait
     844:	488d                	li	a7,3
 ecall
     846:	00000073          	ecall
 ret
     84a:	8082                	ret

000000000000084c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     84c:	4891                	li	a7,4
 ecall
     84e:	00000073          	ecall
 ret
     852:	8082                	ret

0000000000000854 <read>:
.global read
read:
 li a7, SYS_read
     854:	4895                	li	a7,5
 ecall
     856:	00000073          	ecall
 ret
     85a:	8082                	ret

000000000000085c <write>:
.global write
write:
 li a7, SYS_write
     85c:	48c1                	li	a7,16
 ecall
     85e:	00000073          	ecall
 ret
     862:	8082                	ret

0000000000000864 <close>:
.global close
close:
 li a7, SYS_close
     864:	48d5                	li	a7,21
 ecall
     866:	00000073          	ecall
 ret
     86a:	8082                	ret

000000000000086c <kill>:
.global kill
kill:
 li a7, SYS_kill
     86c:	4899                	li	a7,6
 ecall
     86e:	00000073          	ecall
 ret
     872:	8082                	ret

0000000000000874 <exec>:
.global exec
exec:
 li a7, SYS_exec
     874:	489d                	li	a7,7
 ecall
     876:	00000073          	ecall
 ret
     87a:	8082                	ret

000000000000087c <open>:
.global open
open:
 li a7, SYS_open
     87c:	48bd                	li	a7,15
 ecall
     87e:	00000073          	ecall
 ret
     882:	8082                	ret

0000000000000884 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     884:	48c5                	li	a7,17
 ecall
     886:	00000073          	ecall
 ret
     88a:	8082                	ret

000000000000088c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     88c:	48c9                	li	a7,18
 ecall
     88e:	00000073          	ecall
 ret
     892:	8082                	ret

0000000000000894 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     894:	48a1                	li	a7,8
 ecall
     896:	00000073          	ecall
 ret
     89a:	8082                	ret

000000000000089c <link>:
.global link
link:
 li a7, SYS_link
     89c:	48cd                	li	a7,19
 ecall
     89e:	00000073          	ecall
 ret
     8a2:	8082                	ret

00000000000008a4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     8a4:	48d1                	li	a7,20
 ecall
     8a6:	00000073          	ecall
 ret
     8aa:	8082                	ret

00000000000008ac <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     8ac:	48a5                	li	a7,9
 ecall
     8ae:	00000073          	ecall
 ret
     8b2:	8082                	ret

00000000000008b4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     8b4:	48a9                	li	a7,10
 ecall
     8b6:	00000073          	ecall
 ret
     8ba:	8082                	ret

00000000000008bc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8bc:	48ad                	li	a7,11
 ecall
     8be:	00000073          	ecall
 ret
     8c2:	8082                	ret

00000000000008c4 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     8c4:	48b1                	li	a7,12
 ecall
     8c6:	00000073          	ecall
 ret
     8ca:	8082                	ret

00000000000008cc <pause>:
.global pause
pause:
 li a7, SYS_pause
     8cc:	48b5                	li	a7,13
 ecall
     8ce:	00000073          	ecall
 ret
     8d2:	8082                	ret

00000000000008d4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8d4:	48b9                	li	a7,14
 ecall
     8d6:	00000073          	ecall
 ret
     8da:	8082                	ret

00000000000008dc <top>:
.global top
top:
 li a7, SYS_top
     8dc:	48d9                	li	a7,22
 ecall
     8de:	00000073          	ecall
 ret
     8e2:	8082                	ret

00000000000008e4 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     8e4:	48dd                	li	a7,23
 ecall
     8e6:	00000073          	ecall
 ret
     8ea:	8082                	ret

00000000000008ec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8ec:	1101                	addi	sp,sp,-32
     8ee:	ec06                	sd	ra,24(sp)
     8f0:	e822                	sd	s0,16(sp)
     8f2:	1000                	addi	s0,sp,32
     8f4:	87aa                	mv	a5,a0
     8f6:	872e                	mv	a4,a1
     8f8:	fef42623          	sw	a5,-20(s0)
     8fc:	87ba                	mv	a5,a4
     8fe:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     902:	feb40713          	addi	a4,s0,-21
     906:	fec42783          	lw	a5,-20(s0)
     90a:	4605                	li	a2,1
     90c:	85ba                	mv	a1,a4
     90e:	853e                	mv	a0,a5
     910:	f4dff0ef          	jal	85c <write>
}
     914:	0001                	nop
     916:	60e2                	ld	ra,24(sp)
     918:	6442                	ld	s0,16(sp)
     91a:	6105                	addi	sp,sp,32
     91c:	8082                	ret

000000000000091e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     91e:	711d                	addi	sp,sp,-96
     920:	ec86                	sd	ra,88(sp)
     922:	e8a2                	sd	s0,80(sp)
     924:	1080                	addi	s0,sp,96
     926:	87aa                	mv	a5,a0
     928:	fab43823          	sd	a1,-80(s0)
     92c:	8736                	mv	a4,a3
     92e:	faf42e23          	sw	a5,-68(s0)
     932:	87b2                	mv	a5,a2
     934:	faf42c23          	sw	a5,-72(s0)
     938:	87ba                	mv	a5,a4
     93a:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     93e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     942:	fac42783          	lw	a5,-84(s0)
     946:	2781                	sext.w	a5,a5
     948:	cf99                	beqz	a5,966 <printint+0x48>
     94a:	fb043783          	ld	a5,-80(s0)
     94e:	0007dc63          	bgez	a5,966 <printint+0x48>
    neg = 1;
     952:	4785                	li	a5,1
     954:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     958:	fb043783          	ld	a5,-80(s0)
     95c:	40f007b3          	neg	a5,a5
     960:	fef43023          	sd	a5,-32(s0)
     964:	a029                	j	96e <printint+0x50>
  } else {
    x = xx;
     966:	fb043783          	ld	a5,-80(s0)
     96a:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     96e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     972:	fb842783          	lw	a5,-72(s0)
     976:	fe043703          	ld	a4,-32(s0)
     97a:	02f77733          	remu	a4,a4,a5
     97e:	fec42783          	lw	a5,-20(s0)
     982:	0017869b          	addiw	a3,a5,1
     986:	fed42623          	sw	a3,-20(s0)
     98a:	00001697          	auipc	a3,0x1
     98e:	67668693          	addi	a3,a3,1654 # 2000 <digits>
     992:	9736                	add	a4,a4,a3
     994:	00074703          	lbu	a4,0(a4)
     998:	17c1                	addi	a5,a5,-16
     99a:	97a2                	add	a5,a5,s0
     99c:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     9a0:	fb842783          	lw	a5,-72(s0)
     9a4:	fe043703          	ld	a4,-32(s0)
     9a8:	02f757b3          	divu	a5,a4,a5
     9ac:	fef43023          	sd	a5,-32(s0)
     9b0:	fe043783          	ld	a5,-32(s0)
     9b4:	ffdd                	bnez	a5,972 <printint+0x54>
  if(neg)
     9b6:	fe842783          	lw	a5,-24(s0)
     9ba:	2781                	sext.w	a5,a5
     9bc:	cb95                	beqz	a5,9f0 <printint+0xd2>
    buf[i++] = '-';
     9be:	fec42783          	lw	a5,-20(s0)
     9c2:	0017871b          	addiw	a4,a5,1
     9c6:	fee42623          	sw	a4,-20(s0)
     9ca:	17c1                	addi	a5,a5,-16
     9cc:	97a2                	add	a5,a5,s0
     9ce:	02d00713          	li	a4,45
     9d2:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     9d6:	a829                	j	9f0 <printint+0xd2>
    putc(fd, buf[i]);
     9d8:	fec42783          	lw	a5,-20(s0)
     9dc:	17c1                	addi	a5,a5,-16
     9de:	97a2                	add	a5,a5,s0
     9e0:	fd87c703          	lbu	a4,-40(a5)
     9e4:	fbc42783          	lw	a5,-68(s0)
     9e8:	85ba                	mv	a1,a4
     9ea:	853e                	mv	a0,a5
     9ec:	f01ff0ef          	jal	8ec <putc>
  while(--i >= 0)
     9f0:	fec42783          	lw	a5,-20(s0)
     9f4:	37fd                	addiw	a5,a5,-1
     9f6:	fef42623          	sw	a5,-20(s0)
     9fa:	fec42783          	lw	a5,-20(s0)
     9fe:	2781                	sext.w	a5,a5
     a00:	fc07dce3          	bgez	a5,9d8 <printint+0xba>
}
     a04:	0001                	nop
     a06:	0001                	nop
     a08:	60e6                	ld	ra,88(sp)
     a0a:	6446                	ld	s0,80(sp)
     a0c:	6125                	addi	sp,sp,96
     a0e:	8082                	ret

0000000000000a10 <printptr>:

static void
printptr(int fd, uint64 x) {
     a10:	7179                	addi	sp,sp,-48
     a12:	f406                	sd	ra,40(sp)
     a14:	f022                	sd	s0,32(sp)
     a16:	1800                	addi	s0,sp,48
     a18:	87aa                	mv	a5,a0
     a1a:	fcb43823          	sd	a1,-48(s0)
     a1e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a22:	fdc42783          	lw	a5,-36(s0)
     a26:	03000593          	li	a1,48
     a2a:	853e                	mv	a0,a5
     a2c:	ec1ff0ef          	jal	8ec <putc>
  putc(fd, 'x');
     a30:	fdc42783          	lw	a5,-36(s0)
     a34:	07800593          	li	a1,120
     a38:	853e                	mv	a0,a5
     a3a:	eb3ff0ef          	jal	8ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a3e:	fe042623          	sw	zero,-20(s0)
     a42:	a81d                	j	a78 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a44:	fd043783          	ld	a5,-48(s0)
     a48:	93f1                	srli	a5,a5,0x3c
     a4a:	00001717          	auipc	a4,0x1
     a4e:	5b670713          	addi	a4,a4,1462 # 2000 <digits>
     a52:	97ba                	add	a5,a5,a4
     a54:	0007c703          	lbu	a4,0(a5)
     a58:	fdc42783          	lw	a5,-36(s0)
     a5c:	85ba                	mv	a1,a4
     a5e:	853e                	mv	a0,a5
     a60:	e8dff0ef          	jal	8ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a64:	fec42783          	lw	a5,-20(s0)
     a68:	2785                	addiw	a5,a5,1
     a6a:	fef42623          	sw	a5,-20(s0)
     a6e:	fd043783          	ld	a5,-48(s0)
     a72:	0792                	slli	a5,a5,0x4
     a74:	fcf43823          	sd	a5,-48(s0)
     a78:	fec42703          	lw	a4,-20(s0)
     a7c:	47bd                	li	a5,15
     a7e:	fce7f3e3          	bgeu	a5,a4,a44 <printptr+0x34>
}
     a82:	0001                	nop
     a84:	0001                	nop
     a86:	70a2                	ld	ra,40(sp)
     a88:	7402                	ld	s0,32(sp)
     a8a:	6145                	addi	sp,sp,48
     a8c:	8082                	ret

0000000000000a8e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     a8e:	715d                	addi	sp,sp,-80
     a90:	e486                	sd	ra,72(sp)
     a92:	e0a2                	sd	s0,64(sp)
     a94:	0880                	addi	s0,sp,80
     a96:	87aa                	mv	a5,a0
     a98:	fcb43023          	sd	a1,-64(s0)
     a9c:	fac43c23          	sd	a2,-72(s0)
     aa0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     aa4:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     aa8:	fc042e23          	sw	zero,-36(s0)
     aac:	a189                	j	eee <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     aae:	fdc42783          	lw	a5,-36(s0)
     ab2:	fc043703          	ld	a4,-64(s0)
     ab6:	97ba                	add	a5,a5,a4
     ab8:	0007c783          	lbu	a5,0(a5)
     abc:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     ac0:	fd842783          	lw	a5,-40(s0)
     ac4:	2781                	sext.w	a5,a5
     ac6:	eb8d                	bnez	a5,af8 <vprintf+0x6a>
      if(c0 == '%'){
     ac8:	fd442783          	lw	a5,-44(s0)
     acc:	0007871b          	sext.w	a4,a5
     ad0:	02500793          	li	a5,37
     ad4:	00f71763          	bne	a4,a5,ae2 <vprintf+0x54>
        state = '%';
     ad8:	02500793          	li	a5,37
     adc:	fcf42c23          	sw	a5,-40(s0)
     ae0:	a111                	j	ee4 <vprintf+0x456>
      } else {
        putc(fd, c0);
     ae2:	fd442783          	lw	a5,-44(s0)
     ae6:	0ff7f713          	zext.b	a4,a5
     aea:	fcc42783          	lw	a5,-52(s0)
     aee:	85ba                	mv	a1,a4
     af0:	853e                	mv	a0,a5
     af2:	dfbff0ef          	jal	8ec <putc>
     af6:	a6fd                	j	ee4 <vprintf+0x456>
      }
    } else if(state == '%'){
     af8:	fd842783          	lw	a5,-40(s0)
     afc:	0007871b          	sext.w	a4,a5
     b00:	02500793          	li	a5,37
     b04:	3ef71063          	bne	a4,a5,ee4 <vprintf+0x456>
      c1 = c2 = 0;
     b08:	fe042023          	sw	zero,-32(s0)
     b0c:	fe042783          	lw	a5,-32(s0)
     b10:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     b14:	fd442783          	lw	a5,-44(s0)
     b18:	2781                	sext.w	a5,a5
     b1a:	cb99                	beqz	a5,b30 <vprintf+0xa2>
     b1c:	fdc42783          	lw	a5,-36(s0)
     b20:	0785                	addi	a5,a5,1
     b22:	fc043703          	ld	a4,-64(s0)
     b26:	97ba                	add	a5,a5,a4
     b28:	0007c783          	lbu	a5,0(a5)
     b2c:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     b30:	fe442783          	lw	a5,-28(s0)
     b34:	2781                	sext.w	a5,a5
     b36:	cb99                	beqz	a5,b4c <vprintf+0xbe>
     b38:	fdc42783          	lw	a5,-36(s0)
     b3c:	0789                	addi	a5,a5,2
     b3e:	fc043703          	ld	a4,-64(s0)
     b42:	97ba                	add	a5,a5,a4
     b44:	0007c783          	lbu	a5,0(a5)
     b48:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     b4c:	fd442783          	lw	a5,-44(s0)
     b50:	0007871b          	sext.w	a4,a5
     b54:	06400793          	li	a5,100
     b58:	02f71363          	bne	a4,a5,b7e <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     b5c:	fb843783          	ld	a5,-72(s0)
     b60:	00878713          	addi	a4,a5,8
     b64:	fae43c23          	sd	a4,-72(s0)
     b68:	439c                	lw	a5,0(a5)
     b6a:	873e                	mv	a4,a5
     b6c:	fcc42783          	lw	a5,-52(s0)
     b70:	4685                	li	a3,1
     b72:	4629                	li	a2,10
     b74:	85ba                	mv	a1,a4
     b76:	853e                	mv	a0,a5
     b78:	da7ff0ef          	jal	91e <printint>
     b7c:	a695                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     b7e:	fd442783          	lw	a5,-44(s0)
     b82:	0007871b          	sext.w	a4,a5
     b86:	06c00793          	li	a5,108
     b8a:	04f71063          	bne	a4,a5,bca <vprintf+0x13c>
     b8e:	fe442783          	lw	a5,-28(s0)
     b92:	0007871b          	sext.w	a4,a5
     b96:	06400793          	li	a5,100
     b9a:	02f71863          	bne	a4,a5,bca <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     b9e:	fb843783          	ld	a5,-72(s0)
     ba2:	00878713          	addi	a4,a5,8
     ba6:	fae43c23          	sd	a4,-72(s0)
     baa:	639c                	ld	a5,0(a5)
     bac:	873e                	mv	a4,a5
     bae:	fcc42783          	lw	a5,-52(s0)
     bb2:	4685                	li	a3,1
     bb4:	4629                	li	a2,10
     bb6:	85ba                	mv	a1,a4
     bb8:	853e                	mv	a0,a5
     bba:	d65ff0ef          	jal	91e <printint>
        i += 1;
     bbe:	fdc42783          	lw	a5,-36(s0)
     bc2:	2785                	addiw	a5,a5,1
     bc4:	fcf42e23          	sw	a5,-36(s0)
     bc8:	ae21                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     bca:	fd442783          	lw	a5,-44(s0)
     bce:	0007871b          	sext.w	a4,a5
     bd2:	06c00793          	li	a5,108
     bd6:	04f71863          	bne	a4,a5,c26 <vprintf+0x198>
     bda:	fe442783          	lw	a5,-28(s0)
     bde:	0007871b          	sext.w	a4,a5
     be2:	06c00793          	li	a5,108
     be6:	04f71063          	bne	a4,a5,c26 <vprintf+0x198>
     bea:	fe042783          	lw	a5,-32(s0)
     bee:	0007871b          	sext.w	a4,a5
     bf2:	06400793          	li	a5,100
     bf6:	02f71863          	bne	a4,a5,c26 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     bfa:	fb843783          	ld	a5,-72(s0)
     bfe:	00878713          	addi	a4,a5,8
     c02:	fae43c23          	sd	a4,-72(s0)
     c06:	639c                	ld	a5,0(a5)
     c08:	873e                	mv	a4,a5
     c0a:	fcc42783          	lw	a5,-52(s0)
     c0e:	4685                	li	a3,1
     c10:	4629                	li	a2,10
     c12:	85ba                	mv	a1,a4
     c14:	853e                	mv	a0,a5
     c16:	d09ff0ef          	jal	91e <printint>
        i += 2;
     c1a:	fdc42783          	lw	a5,-36(s0)
     c1e:	2789                	addiw	a5,a5,2
     c20:	fcf42e23          	sw	a5,-36(s0)
     c24:	ac75                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'u'){
     c26:	fd442783          	lw	a5,-44(s0)
     c2a:	0007871b          	sext.w	a4,a5
     c2e:	07500793          	li	a5,117
     c32:	02f71563          	bne	a4,a5,c5c <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     c36:	fb843783          	ld	a5,-72(s0)
     c3a:	00878713          	addi	a4,a5,8
     c3e:	fae43c23          	sd	a4,-72(s0)
     c42:	439c                	lw	a5,0(a5)
     c44:	02079713          	slli	a4,a5,0x20
     c48:	9301                	srli	a4,a4,0x20
     c4a:	fcc42783          	lw	a5,-52(s0)
     c4e:	4681                	li	a3,0
     c50:	4629                	li	a2,10
     c52:	85ba                	mv	a1,a4
     c54:	853e                	mv	a0,a5
     c56:	cc9ff0ef          	jal	91e <printint>
     c5a:	a459                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     c5c:	fd442783          	lw	a5,-44(s0)
     c60:	0007871b          	sext.w	a4,a5
     c64:	06c00793          	li	a5,108
     c68:	04f71063          	bne	a4,a5,ca8 <vprintf+0x21a>
     c6c:	fe442783          	lw	a5,-28(s0)
     c70:	0007871b          	sext.w	a4,a5
     c74:	07500793          	li	a5,117
     c78:	02f71863          	bne	a4,a5,ca8 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c7c:	fb843783          	ld	a5,-72(s0)
     c80:	00878713          	addi	a4,a5,8
     c84:	fae43c23          	sd	a4,-72(s0)
     c88:	639c                	ld	a5,0(a5)
     c8a:	873e                	mv	a4,a5
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	4681                	li	a3,0
     c92:	4629                	li	a2,10
     c94:	85ba                	mv	a1,a4
     c96:	853e                	mv	a0,a5
     c98:	c87ff0ef          	jal	91e <printint>
        i += 1;
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	2785                	addiw	a5,a5,1
     ca2:	fcf42e23          	sw	a5,-36(s0)
     ca6:	ac2d                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ca8:	fd442783          	lw	a5,-44(s0)
     cac:	0007871b          	sext.w	a4,a5
     cb0:	06c00793          	li	a5,108
     cb4:	04f71863          	bne	a4,a5,d04 <vprintf+0x276>
     cb8:	fe442783          	lw	a5,-28(s0)
     cbc:	0007871b          	sext.w	a4,a5
     cc0:	06c00793          	li	a5,108
     cc4:	04f71063          	bne	a4,a5,d04 <vprintf+0x276>
     cc8:	fe042783          	lw	a5,-32(s0)
     ccc:	0007871b          	sext.w	a4,a5
     cd0:	07500793          	li	a5,117
     cd4:	02f71863          	bne	a4,a5,d04 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     cd8:	fb843783          	ld	a5,-72(s0)
     cdc:	00878713          	addi	a4,a5,8
     ce0:	fae43c23          	sd	a4,-72(s0)
     ce4:	639c                	ld	a5,0(a5)
     ce6:	873e                	mv	a4,a5
     ce8:	fcc42783          	lw	a5,-52(s0)
     cec:	4681                	li	a3,0
     cee:	4629                	li	a2,10
     cf0:	85ba                	mv	a1,a4
     cf2:	853e                	mv	a0,a5
     cf4:	c2bff0ef          	jal	91e <printint>
        i += 2;
     cf8:	fdc42783          	lw	a5,-36(s0)
     cfc:	2789                	addiw	a5,a5,2
     cfe:	fcf42e23          	sw	a5,-36(s0)
     d02:	aaf9                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'x'){
     d04:	fd442783          	lw	a5,-44(s0)
     d08:	0007871b          	sext.w	a4,a5
     d0c:	07800793          	li	a5,120
     d10:	02f71563          	bne	a4,a5,d3a <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     d14:	fb843783          	ld	a5,-72(s0)
     d18:	00878713          	addi	a4,a5,8
     d1c:	fae43c23          	sd	a4,-72(s0)
     d20:	439c                	lw	a5,0(a5)
     d22:	02079713          	slli	a4,a5,0x20
     d26:	9301                	srli	a4,a4,0x20
     d28:	fcc42783          	lw	a5,-52(s0)
     d2c:	4681                	li	a3,0
     d2e:	4641                	li	a2,16
     d30:	85ba                	mv	a1,a4
     d32:	853e                	mv	a0,a5
     d34:	bebff0ef          	jal	91e <printint>
     d38:	a265                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     d3a:	fd442783          	lw	a5,-44(s0)
     d3e:	0007871b          	sext.w	a4,a5
     d42:	06c00793          	li	a5,108
     d46:	04f71063          	bne	a4,a5,d86 <vprintf+0x2f8>
     d4a:	fe442783          	lw	a5,-28(s0)
     d4e:	0007871b          	sext.w	a4,a5
     d52:	07800793          	li	a5,120
     d56:	02f71863          	bne	a4,a5,d86 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     d5a:	fb843783          	ld	a5,-72(s0)
     d5e:	00878713          	addi	a4,a5,8
     d62:	fae43c23          	sd	a4,-72(s0)
     d66:	639c                	ld	a5,0(a5)
     d68:	873e                	mv	a4,a5
     d6a:	fcc42783          	lw	a5,-52(s0)
     d6e:	4681                	li	a3,0
     d70:	4641                	li	a2,16
     d72:	85ba                	mv	a1,a4
     d74:	853e                	mv	a0,a5
     d76:	ba9ff0ef          	jal	91e <printint>
        i += 1;
     d7a:	fdc42783          	lw	a5,-36(s0)
     d7e:	2785                	addiw	a5,a5,1
     d80:	fcf42e23          	sw	a5,-36(s0)
     d84:	aab1                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     d86:	fd442783          	lw	a5,-44(s0)
     d8a:	0007871b          	sext.w	a4,a5
     d8e:	06c00793          	li	a5,108
     d92:	04f71863          	bne	a4,a5,de2 <vprintf+0x354>
     d96:	fe442783          	lw	a5,-28(s0)
     d9a:	0007871b          	sext.w	a4,a5
     d9e:	06c00793          	li	a5,108
     da2:	04f71063          	bne	a4,a5,de2 <vprintf+0x354>
     da6:	fe042783          	lw	a5,-32(s0)
     daa:	0007871b          	sext.w	a4,a5
     dae:	07800793          	li	a5,120
     db2:	02f71863          	bne	a4,a5,de2 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     db6:	fb843783          	ld	a5,-72(s0)
     dba:	00878713          	addi	a4,a5,8
     dbe:	fae43c23          	sd	a4,-72(s0)
     dc2:	639c                	ld	a5,0(a5)
     dc4:	873e                	mv	a4,a5
     dc6:	fcc42783          	lw	a5,-52(s0)
     dca:	4681                	li	a3,0
     dcc:	4641                	li	a2,16
     dce:	85ba                	mv	a1,a4
     dd0:	853e                	mv	a0,a5
     dd2:	b4dff0ef          	jal	91e <printint>
        i += 2;
     dd6:	fdc42783          	lw	a5,-36(s0)
     dda:	2789                	addiw	a5,a5,2
     ddc:	fcf42e23          	sw	a5,-36(s0)
     de0:	a201                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'p'){
     de2:	fd442783          	lw	a5,-44(s0)
     de6:	0007871b          	sext.w	a4,a5
     dea:	07000793          	li	a5,112
     dee:	02f71063          	bne	a4,a5,e0e <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     df2:	fb843783          	ld	a5,-72(s0)
     df6:	00878713          	addi	a4,a5,8
     dfa:	fae43c23          	sd	a4,-72(s0)
     dfe:	6398                	ld	a4,0(a5)
     e00:	fcc42783          	lw	a5,-52(s0)
     e04:	85ba                	mv	a1,a4
     e06:	853e                	mv	a0,a5
     e08:	c09ff0ef          	jal	a10 <printptr>
     e0c:	a8d1                	j	ee0 <vprintf+0x452>
      } else if(c0 == 'c'){
     e0e:	fd442783          	lw	a5,-44(s0)
     e12:	0007871b          	sext.w	a4,a5
     e16:	06300793          	li	a5,99
     e1a:	02f71263          	bne	a4,a5,e3e <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     e1e:	fb843783          	ld	a5,-72(s0)
     e22:	00878713          	addi	a4,a5,8
     e26:	fae43c23          	sd	a4,-72(s0)
     e2a:	439c                	lw	a5,0(a5)
     e2c:	0ff7f713          	zext.b	a4,a5
     e30:	fcc42783          	lw	a5,-52(s0)
     e34:	85ba                	mv	a1,a4
     e36:	853e                	mv	a0,a5
     e38:	ab5ff0ef          	jal	8ec <putc>
     e3c:	a055                	j	ee0 <vprintf+0x452>
      } else if(c0 == 's'){
     e3e:	fd442783          	lw	a5,-44(s0)
     e42:	0007871b          	sext.w	a4,a5
     e46:	07300793          	li	a5,115
     e4a:	04f71a63          	bne	a4,a5,e9e <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     e4e:	fb843783          	ld	a5,-72(s0)
     e52:	00878713          	addi	a4,a5,8
     e56:	fae43c23          	sd	a4,-72(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	fef43423          	sd	a5,-24(s0)
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	e79d                	bnez	a5,e92 <vprintf+0x404>
          s = "(null)";
     e66:	00000797          	auipc	a5,0x0
     e6a:	47a78793          	addi	a5,a5,1146 # 12e0 <malloc+0x198>
     e6e:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     e72:	a005                	j	e92 <vprintf+0x404>
          putc(fd, *s);
     e74:	fe843783          	ld	a5,-24(s0)
     e78:	0007c703          	lbu	a4,0(a5)
     e7c:	fcc42783          	lw	a5,-52(s0)
     e80:	85ba                	mv	a1,a4
     e82:	853e                	mv	a0,a5
     e84:	a69ff0ef          	jal	8ec <putc>
        for(; *s; s++)
     e88:	fe843783          	ld	a5,-24(s0)
     e8c:	0785                	addi	a5,a5,1
     e8e:	fef43423          	sd	a5,-24(s0)
     e92:	fe843783          	ld	a5,-24(s0)
     e96:	0007c783          	lbu	a5,0(a5)
     e9a:	ffe9                	bnez	a5,e74 <vprintf+0x3e6>
     e9c:	a091                	j	ee0 <vprintf+0x452>
      } else if(c0 == '%'){
     e9e:	fd442783          	lw	a5,-44(s0)
     ea2:	0007871b          	sext.w	a4,a5
     ea6:	02500793          	li	a5,37
     eaa:	00f71a63          	bne	a4,a5,ebe <vprintf+0x430>
        putc(fd, '%');
     eae:	fcc42783          	lw	a5,-52(s0)
     eb2:	02500593          	li	a1,37
     eb6:	853e                	mv	a0,a5
     eb8:	a35ff0ef          	jal	8ec <putc>
     ebc:	a015                	j	ee0 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ebe:	fcc42783          	lw	a5,-52(s0)
     ec2:	02500593          	li	a1,37
     ec6:	853e                	mv	a0,a5
     ec8:	a25ff0ef          	jal	8ec <putc>
        putc(fd, c0);
     ecc:	fd442783          	lw	a5,-44(s0)
     ed0:	0ff7f713          	zext.b	a4,a5
     ed4:	fcc42783          	lw	a5,-52(s0)
     ed8:	85ba                	mv	a1,a4
     eda:	853e                	mv	a0,a5
     edc:	a11ff0ef          	jal	8ec <putc>
      }

      state = 0;
     ee0:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     ee4:	fdc42783          	lw	a5,-36(s0)
     ee8:	2785                	addiw	a5,a5,1
     eea:	fcf42e23          	sw	a5,-36(s0)
     eee:	fdc42783          	lw	a5,-36(s0)
     ef2:	fc043703          	ld	a4,-64(s0)
     ef6:	97ba                	add	a5,a5,a4
     ef8:	0007c783          	lbu	a5,0(a5)
     efc:	ba0799e3          	bnez	a5,aae <vprintf+0x20>
    }
  }
}
     f00:	0001                	nop
     f02:	0001                	nop
     f04:	60a6                	ld	ra,72(sp)
     f06:	6406                	ld	s0,64(sp)
     f08:	6161                	addi	sp,sp,80
     f0a:	8082                	ret

0000000000000f0c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f0c:	7159                	addi	sp,sp,-112
     f0e:	fc06                	sd	ra,56(sp)
     f10:	f822                	sd	s0,48(sp)
     f12:	0080                	addi	s0,sp,64
     f14:	fcb43823          	sd	a1,-48(s0)
     f18:	e010                	sd	a2,0(s0)
     f1a:	e414                	sd	a3,8(s0)
     f1c:	e818                	sd	a4,16(s0)
     f1e:	ec1c                	sd	a5,24(s0)
     f20:	03043023          	sd	a6,32(s0)
     f24:	03143423          	sd	a7,40(s0)
     f28:	87aa                	mv	a5,a0
     f2a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     f2e:	03040793          	addi	a5,s0,48
     f32:	fcf43423          	sd	a5,-56(s0)
     f36:	fc843783          	ld	a5,-56(s0)
     f3a:	fd078793          	addi	a5,a5,-48
     f3e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     f42:	fe843703          	ld	a4,-24(s0)
     f46:	fdc42783          	lw	a5,-36(s0)
     f4a:	863a                	mv	a2,a4
     f4c:	fd043583          	ld	a1,-48(s0)
     f50:	853e                	mv	a0,a5
     f52:	b3dff0ef          	jal	a8e <vprintf>
}
     f56:	0001                	nop
     f58:	70e2                	ld	ra,56(sp)
     f5a:	7442                	ld	s0,48(sp)
     f5c:	6165                	addi	sp,sp,112
     f5e:	8082                	ret

0000000000000f60 <printf>:

void
printf(const char *fmt, ...)
{
     f60:	7159                	addi	sp,sp,-112
     f62:	f406                	sd	ra,40(sp)
     f64:	f022                	sd	s0,32(sp)
     f66:	1800                	addi	s0,sp,48
     f68:	fca43c23          	sd	a0,-40(s0)
     f6c:	e40c                	sd	a1,8(s0)
     f6e:	e810                	sd	a2,16(s0)
     f70:	ec14                	sd	a3,24(s0)
     f72:	f018                	sd	a4,32(s0)
     f74:	f41c                	sd	a5,40(s0)
     f76:	03043823          	sd	a6,48(s0)
     f7a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f7e:	04040793          	addi	a5,s0,64
     f82:	fcf43823          	sd	a5,-48(s0)
     f86:	fd043783          	ld	a5,-48(s0)
     f8a:	fc878793          	addi	a5,a5,-56
     f8e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     f92:	fe843783          	ld	a5,-24(s0)
     f96:	863e                	mv	a2,a5
     f98:	fd843583          	ld	a1,-40(s0)
     f9c:	4505                	li	a0,1
     f9e:	af1ff0ef          	jal	a8e <vprintf>
}
     fa2:	0001                	nop
     fa4:	70a2                	ld	ra,40(sp)
     fa6:	7402                	ld	s0,32(sp)
     fa8:	6165                	addi	sp,sp,112
     faa:	8082                	ret

0000000000000fac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fac:	7179                	addi	sp,sp,-48
     fae:	f406                	sd	ra,40(sp)
     fb0:	f022                	sd	s0,32(sp)
     fb2:	1800                	addi	s0,sp,48
     fb4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fb8:	fd843783          	ld	a5,-40(s0)
     fbc:	17c1                	addi	a5,a5,-16
     fbe:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc2:	00001797          	auipc	a5,0x1
     fc6:	07e78793          	addi	a5,a5,126 # 2040 <freep>
     fca:	639c                	ld	a5,0(a5)
     fcc:	fef43423          	sd	a5,-24(s0)
     fd0:	a815                	j	1004 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd2:	fe843783          	ld	a5,-24(s0)
     fd6:	639c                	ld	a5,0(a5)
     fd8:	fe843703          	ld	a4,-24(s0)
     fdc:	00f76f63          	bltu	a4,a5,ffa <free+0x4e>
     fe0:	fe043703          	ld	a4,-32(s0)
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	02e7eb63          	bltu	a5,a4,101e <free+0x72>
     fec:	fe843783          	ld	a5,-24(s0)
     ff0:	639c                	ld	a5,0(a5)
     ff2:	fe043703          	ld	a4,-32(s0)
     ff6:	02f76463          	bltu	a4,a5,101e <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ffa:	fe843783          	ld	a5,-24(s0)
     ffe:	639c                	ld	a5,0(a5)
    1000:	fef43423          	sd	a5,-24(s0)
    1004:	fe043703          	ld	a4,-32(s0)
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	fce7f3e3          	bgeu	a5,a4,fd2 <free+0x26>
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	639c                	ld	a5,0(a5)
    1016:	fe043703          	ld	a4,-32(s0)
    101a:	faf77ce3          	bgeu	a4,a5,fd2 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    101e:	fe043783          	ld	a5,-32(s0)
    1022:	479c                	lw	a5,8(a5)
    1024:	1782                	slli	a5,a5,0x20
    1026:	9381                	srli	a5,a5,0x20
    1028:	0792                	slli	a5,a5,0x4
    102a:	fe043703          	ld	a4,-32(s0)
    102e:	973e                	add	a4,a4,a5
    1030:	fe843783          	ld	a5,-24(s0)
    1034:	639c                	ld	a5,0(a5)
    1036:	02f71763          	bne	a4,a5,1064 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    103a:	fe043783          	ld	a5,-32(s0)
    103e:	4798                	lw	a4,8(a5)
    1040:	fe843783          	ld	a5,-24(s0)
    1044:	639c                	ld	a5,0(a5)
    1046:	479c                	lw	a5,8(a5)
    1048:	9fb9                	addw	a5,a5,a4
    104a:	0007871b          	sext.w	a4,a5
    104e:	fe043783          	ld	a5,-32(s0)
    1052:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1054:	fe843783          	ld	a5,-24(s0)
    1058:	639c                	ld	a5,0(a5)
    105a:	6398                	ld	a4,0(a5)
    105c:	fe043783          	ld	a5,-32(s0)
    1060:	e398                	sd	a4,0(a5)
    1062:	a039                	j	1070 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	6398                	ld	a4,0(a5)
    106a:	fe043783          	ld	a5,-32(s0)
    106e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1070:	fe843783          	ld	a5,-24(s0)
    1074:	479c                	lw	a5,8(a5)
    1076:	1782                	slli	a5,a5,0x20
    1078:	9381                	srli	a5,a5,0x20
    107a:	0792                	slli	a5,a5,0x4
    107c:	fe843703          	ld	a4,-24(s0)
    1080:	97ba                	add	a5,a5,a4
    1082:	fe043703          	ld	a4,-32(s0)
    1086:	02f71563          	bne	a4,a5,10b0 <free+0x104>
    p->s.size += bp->s.size;
    108a:	fe843783          	ld	a5,-24(s0)
    108e:	4798                	lw	a4,8(a5)
    1090:	fe043783          	ld	a5,-32(s0)
    1094:	479c                	lw	a5,8(a5)
    1096:	9fb9                	addw	a5,a5,a4
    1098:	0007871b          	sext.w	a4,a5
    109c:	fe843783          	ld	a5,-24(s0)
    10a0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    10a2:	fe043783          	ld	a5,-32(s0)
    10a6:	6398                	ld	a4,0(a5)
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	e398                	sd	a4,0(a5)
    10ae:	a031                	j	10ba <free+0x10e>
  } else
    p->s.ptr = bp;
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	fe043703          	ld	a4,-32(s0)
    10b8:	e398                	sd	a4,0(a5)
  freep = p;
    10ba:	00001797          	auipc	a5,0x1
    10be:	f8678793          	addi	a5,a5,-122 # 2040 <freep>
    10c2:	fe843703          	ld	a4,-24(s0)
    10c6:	e398                	sd	a4,0(a5)
}
    10c8:	0001                	nop
    10ca:	70a2                	ld	ra,40(sp)
    10cc:	7402                	ld	s0,32(sp)
    10ce:	6145                	addi	sp,sp,48
    10d0:	8082                	ret

00000000000010d2 <morecore>:

static Header*
morecore(uint nu)
{
    10d2:	7179                	addi	sp,sp,-48
    10d4:	f406                	sd	ra,40(sp)
    10d6:	f022                	sd	s0,32(sp)
    10d8:	1800                	addi	s0,sp,48
    10da:	87aa                	mv	a5,a0
    10dc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    10e0:	fdc42783          	lw	a5,-36(s0)
    10e4:	0007871b          	sext.w	a4,a5
    10e8:	6785                	lui	a5,0x1
    10ea:	00f77563          	bgeu	a4,a5,10f4 <morecore+0x22>
    nu = 4096;
    10ee:	6785                	lui	a5,0x1
    10f0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    10f4:	fdc42783          	lw	a5,-36(s0)
    10f8:	0047979b          	slliw	a5,a5,0x4
    10fc:	2781                	sext.w	a5,a5
    10fe:	853e                	mv	a0,a5
    1100:	ee8ff0ef          	jal	7e8 <sbrk>
    1104:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    1108:	fe843703          	ld	a4,-24(s0)
    110c:	57fd                	li	a5,-1
    110e:	00f71463          	bne	a4,a5,1116 <morecore+0x44>
    return 0;
    1112:	4781                	li	a5,0
    1114:	a02d                	j	113e <morecore+0x6c>
  hp = (Header*)p;
    1116:	fe843783          	ld	a5,-24(s0)
    111a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    111e:	fe043783          	ld	a5,-32(s0)
    1122:	fdc42703          	lw	a4,-36(s0)
    1126:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1128:	fe043783          	ld	a5,-32(s0)
    112c:	07c1                	addi	a5,a5,16 # 1010 <free+0x64>
    112e:	853e                	mv	a0,a5
    1130:	e7dff0ef          	jal	fac <free>
  return freep;
    1134:	00001797          	auipc	a5,0x1
    1138:	f0c78793          	addi	a5,a5,-244 # 2040 <freep>
    113c:	639c                	ld	a5,0(a5)
}
    113e:	853e                	mv	a0,a5
    1140:	70a2                	ld	ra,40(sp)
    1142:	7402                	ld	s0,32(sp)
    1144:	6145                	addi	sp,sp,48
    1146:	8082                	ret

0000000000001148 <malloc>:

void*
malloc(uint nbytes)
{
    1148:	7139                	addi	sp,sp,-64
    114a:	fc06                	sd	ra,56(sp)
    114c:	f822                	sd	s0,48(sp)
    114e:	0080                	addi	s0,sp,64
    1150:	87aa                	mv	a5,a0
    1152:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1156:	fcc46783          	lwu	a5,-52(s0)
    115a:	07bd                	addi	a5,a5,15
    115c:	8391                	srli	a5,a5,0x4
    115e:	2781                	sext.w	a5,a5
    1160:	2785                	addiw	a5,a5,1
    1162:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1166:	00001797          	auipc	a5,0x1
    116a:	eda78793          	addi	a5,a5,-294 # 2040 <freep>
    116e:	639c                	ld	a5,0(a5)
    1170:	fef43023          	sd	a5,-32(s0)
    1174:	fe043783          	ld	a5,-32(s0)
    1178:	ef95                	bnez	a5,11b4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    117a:	00001797          	auipc	a5,0x1
    117e:	eb678793          	addi	a5,a5,-330 # 2030 <base>
    1182:	fef43023          	sd	a5,-32(s0)
    1186:	00001797          	auipc	a5,0x1
    118a:	eba78793          	addi	a5,a5,-326 # 2040 <freep>
    118e:	fe043703          	ld	a4,-32(s0)
    1192:	e398                	sd	a4,0(a5)
    1194:	00001797          	auipc	a5,0x1
    1198:	eac78793          	addi	a5,a5,-340 # 2040 <freep>
    119c:	6398                	ld	a4,0(a5)
    119e:	00001797          	auipc	a5,0x1
    11a2:	e9278793          	addi	a5,a5,-366 # 2030 <base>
    11a6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    11a8:	00001797          	auipc	a5,0x1
    11ac:	e8878793          	addi	a5,a5,-376 # 2030 <base>
    11b0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11b4:	fe043783          	ld	a5,-32(s0)
    11b8:	639c                	ld	a5,0(a5)
    11ba:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    11be:	fe843783          	ld	a5,-24(s0)
    11c2:	479c                	lw	a5,8(a5)
    11c4:	fdc42703          	lw	a4,-36(s0)
    11c8:	2701                	sext.w	a4,a4
    11ca:	06e7e763          	bltu	a5,a4,1238 <malloc+0xf0>
      if(p->s.size == nunits)
    11ce:	fe843783          	ld	a5,-24(s0)
    11d2:	479c                	lw	a5,8(a5)
    11d4:	fdc42703          	lw	a4,-36(s0)
    11d8:	2701                	sext.w	a4,a4
    11da:	00f71963          	bne	a4,a5,11ec <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    11de:	fe843783          	ld	a5,-24(s0)
    11e2:	6398                	ld	a4,0(a5)
    11e4:	fe043783          	ld	a5,-32(s0)
    11e8:	e398                	sd	a4,0(a5)
    11ea:	a825                	j	1222 <malloc+0xda>
      else {
        p->s.size -= nunits;
    11ec:	fe843783          	ld	a5,-24(s0)
    11f0:	479c                	lw	a5,8(a5)
    11f2:	fdc42703          	lw	a4,-36(s0)
    11f6:	9f99                	subw	a5,a5,a4
    11f8:	0007871b          	sext.w	a4,a5
    11fc:	fe843783          	ld	a5,-24(s0)
    1200:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1202:	fe843783          	ld	a5,-24(s0)
    1206:	479c                	lw	a5,8(a5)
    1208:	1782                	slli	a5,a5,0x20
    120a:	9381                	srli	a5,a5,0x20
    120c:	0792                	slli	a5,a5,0x4
    120e:	fe843703          	ld	a4,-24(s0)
    1212:	97ba                	add	a5,a5,a4
    1214:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1218:	fe843783          	ld	a5,-24(s0)
    121c:	fdc42703          	lw	a4,-36(s0)
    1220:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1222:	00001797          	auipc	a5,0x1
    1226:	e1e78793          	addi	a5,a5,-482 # 2040 <freep>
    122a:	fe043703          	ld	a4,-32(s0)
    122e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1230:	fe843783          	ld	a5,-24(s0)
    1234:	07c1                	addi	a5,a5,16
    1236:	a081                	j	1276 <malloc+0x12e>
    }
    if(p == freep)
    1238:	00001797          	auipc	a5,0x1
    123c:	e0878793          	addi	a5,a5,-504 # 2040 <freep>
    1240:	639c                	ld	a5,0(a5)
    1242:	fe843703          	ld	a4,-24(s0)
    1246:	00f71e63          	bne	a4,a5,1262 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    124a:	fdc42783          	lw	a5,-36(s0)
    124e:	853e                	mv	a0,a5
    1250:	e83ff0ef          	jal	10d2 <morecore>
    1254:	fea43423          	sd	a0,-24(s0)
    1258:	fe843783          	ld	a5,-24(s0)
    125c:	e399                	bnez	a5,1262 <malloc+0x11a>
        return 0;
    125e:	4781                	li	a5,0
    1260:	a819                	j	1276 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1262:	fe843783          	ld	a5,-24(s0)
    1266:	fef43023          	sd	a5,-32(s0)
    126a:	fe843783          	ld	a5,-24(s0)
    126e:	639c                	ld	a5,0(a5)
    1270:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1274:	b7a9                	j	11be <malloc+0x76>
  }
}
    1276:	853e                	mv	a0,a5
    1278:	70e2                	ld	ra,56(sp)
    127a:	7442                	ld	s0,48(sp)
    127c:	6121                	addi	sp,sp,64
    127e:	8082                	ret
