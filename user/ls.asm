
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
     11c:	16858593          	addi	a1,a1,360 # 1280 <malloc+0x140>
     120:	4509                	li	a0,2
     122:	5e3000ef          	jal	f04 <fprintf>
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
     146:	15658593          	addi	a1,a1,342 # 1298 <malloc+0x158>
     14a:	4509                	li	a0,2
     14c:	5b9000ef          	jal	f04 <fprintf>
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
     196:	11e50513          	addi	a0,a0,286 # 12b0 <malloc+0x170>
     19a:	5bf000ef          	jal	f58 <printf>
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
     1bc:	10850513          	addi	a0,a0,264 # 12c0 <malloc+0x180>
     1c0:	599000ef          	jal	f58 <printf>
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
     246:	05650513          	addi	a0,a0,86 # 1298 <malloc+0x158>
     24a:	50f000ef          	jal	f58 <printf>
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
     272:	04250513          	addi	a0,a0,66 # 12b0 <malloc+0x170>
     276:	4e3000ef          	jal	f58 <printf>
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
     2d8:	00450513          	addi	a0,a0,4 # 12d8 <malloc+0x198>
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

00000000000008e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8e4:	1101                	addi	sp,sp,-32
     8e6:	ec06                	sd	ra,24(sp)
     8e8:	e822                	sd	s0,16(sp)
     8ea:	1000                	addi	s0,sp,32
     8ec:	87aa                	mv	a5,a0
     8ee:	872e                	mv	a4,a1
     8f0:	fef42623          	sw	a5,-20(s0)
     8f4:	87ba                	mv	a5,a4
     8f6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8fa:	feb40713          	addi	a4,s0,-21
     8fe:	fec42783          	lw	a5,-20(s0)
     902:	4605                	li	a2,1
     904:	85ba                	mv	a1,a4
     906:	853e                	mv	a0,a5
     908:	f55ff0ef          	jal	85c <write>
}
     90c:	0001                	nop
     90e:	60e2                	ld	ra,24(sp)
     910:	6442                	ld	s0,16(sp)
     912:	6105                	addi	sp,sp,32
     914:	8082                	ret

0000000000000916 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     916:	711d                	addi	sp,sp,-96
     918:	ec86                	sd	ra,88(sp)
     91a:	e8a2                	sd	s0,80(sp)
     91c:	1080                	addi	s0,sp,96
     91e:	87aa                	mv	a5,a0
     920:	fab43823          	sd	a1,-80(s0)
     924:	8736                	mv	a4,a3
     926:	faf42e23          	sw	a5,-68(s0)
     92a:	87b2                	mv	a5,a2
     92c:	faf42c23          	sw	a5,-72(s0)
     930:	87ba                	mv	a5,a4
     932:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     936:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     93a:	fac42783          	lw	a5,-84(s0)
     93e:	2781                	sext.w	a5,a5
     940:	cf99                	beqz	a5,95e <printint+0x48>
     942:	fb043783          	ld	a5,-80(s0)
     946:	0007dc63          	bgez	a5,95e <printint+0x48>
    neg = 1;
     94a:	4785                	li	a5,1
     94c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     950:	fb043783          	ld	a5,-80(s0)
     954:	40f007b3          	neg	a5,a5
     958:	fef43023          	sd	a5,-32(s0)
     95c:	a029                	j	966 <printint+0x50>
  } else {
    x = xx;
     95e:	fb043783          	ld	a5,-80(s0)
     962:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     966:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     96a:	fb842783          	lw	a5,-72(s0)
     96e:	fe043703          	ld	a4,-32(s0)
     972:	02f77733          	remu	a4,a4,a5
     976:	fec42783          	lw	a5,-20(s0)
     97a:	0017869b          	addiw	a3,a5,1
     97e:	fed42623          	sw	a3,-20(s0)
     982:	00001697          	auipc	a3,0x1
     986:	67e68693          	addi	a3,a3,1662 # 2000 <digits>
     98a:	9736                	add	a4,a4,a3
     98c:	00074703          	lbu	a4,0(a4)
     990:	17c1                	addi	a5,a5,-16
     992:	97a2                	add	a5,a5,s0
     994:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     998:	fb842783          	lw	a5,-72(s0)
     99c:	fe043703          	ld	a4,-32(s0)
     9a0:	02f757b3          	divu	a5,a4,a5
     9a4:	fef43023          	sd	a5,-32(s0)
     9a8:	fe043783          	ld	a5,-32(s0)
     9ac:	ffdd                	bnez	a5,96a <printint+0x54>
  if(neg)
     9ae:	fe842783          	lw	a5,-24(s0)
     9b2:	2781                	sext.w	a5,a5
     9b4:	cb95                	beqz	a5,9e8 <printint+0xd2>
    buf[i++] = '-';
     9b6:	fec42783          	lw	a5,-20(s0)
     9ba:	0017871b          	addiw	a4,a5,1
     9be:	fee42623          	sw	a4,-20(s0)
     9c2:	17c1                	addi	a5,a5,-16
     9c4:	97a2                	add	a5,a5,s0
     9c6:	02d00713          	li	a4,45
     9ca:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     9ce:	a829                	j	9e8 <printint+0xd2>
    putc(fd, buf[i]);
     9d0:	fec42783          	lw	a5,-20(s0)
     9d4:	17c1                	addi	a5,a5,-16
     9d6:	97a2                	add	a5,a5,s0
     9d8:	fd87c703          	lbu	a4,-40(a5)
     9dc:	fbc42783          	lw	a5,-68(s0)
     9e0:	85ba                	mv	a1,a4
     9e2:	853e                	mv	a0,a5
     9e4:	f01ff0ef          	jal	8e4 <putc>
  while(--i >= 0)
     9e8:	fec42783          	lw	a5,-20(s0)
     9ec:	37fd                	addiw	a5,a5,-1
     9ee:	fef42623          	sw	a5,-20(s0)
     9f2:	fec42783          	lw	a5,-20(s0)
     9f6:	2781                	sext.w	a5,a5
     9f8:	fc07dce3          	bgez	a5,9d0 <printint+0xba>
}
     9fc:	0001                	nop
     9fe:	0001                	nop
     a00:	60e6                	ld	ra,88(sp)
     a02:	6446                	ld	s0,80(sp)
     a04:	6125                	addi	sp,sp,96
     a06:	8082                	ret

0000000000000a08 <printptr>:

static void
printptr(int fd, uint64 x) {
     a08:	7179                	addi	sp,sp,-48
     a0a:	f406                	sd	ra,40(sp)
     a0c:	f022                	sd	s0,32(sp)
     a0e:	1800                	addi	s0,sp,48
     a10:	87aa                	mv	a5,a0
     a12:	fcb43823          	sd	a1,-48(s0)
     a16:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a1a:	fdc42783          	lw	a5,-36(s0)
     a1e:	03000593          	li	a1,48
     a22:	853e                	mv	a0,a5
     a24:	ec1ff0ef          	jal	8e4 <putc>
  putc(fd, 'x');
     a28:	fdc42783          	lw	a5,-36(s0)
     a2c:	07800593          	li	a1,120
     a30:	853e                	mv	a0,a5
     a32:	eb3ff0ef          	jal	8e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a36:	fe042623          	sw	zero,-20(s0)
     a3a:	a81d                	j	a70 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a3c:	fd043783          	ld	a5,-48(s0)
     a40:	93f1                	srli	a5,a5,0x3c
     a42:	00001717          	auipc	a4,0x1
     a46:	5be70713          	addi	a4,a4,1470 # 2000 <digits>
     a4a:	97ba                	add	a5,a5,a4
     a4c:	0007c703          	lbu	a4,0(a5)
     a50:	fdc42783          	lw	a5,-36(s0)
     a54:	85ba                	mv	a1,a4
     a56:	853e                	mv	a0,a5
     a58:	e8dff0ef          	jal	8e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a5c:	fec42783          	lw	a5,-20(s0)
     a60:	2785                	addiw	a5,a5,1
     a62:	fef42623          	sw	a5,-20(s0)
     a66:	fd043783          	ld	a5,-48(s0)
     a6a:	0792                	slli	a5,a5,0x4
     a6c:	fcf43823          	sd	a5,-48(s0)
     a70:	fec42703          	lw	a4,-20(s0)
     a74:	47bd                	li	a5,15
     a76:	fce7f3e3          	bgeu	a5,a4,a3c <printptr+0x34>
}
     a7a:	0001                	nop
     a7c:	0001                	nop
     a7e:	70a2                	ld	ra,40(sp)
     a80:	7402                	ld	s0,32(sp)
     a82:	6145                	addi	sp,sp,48
     a84:	8082                	ret

0000000000000a86 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     a86:	715d                	addi	sp,sp,-80
     a88:	e486                	sd	ra,72(sp)
     a8a:	e0a2                	sd	s0,64(sp)
     a8c:	0880                	addi	s0,sp,80
     a8e:	87aa                	mv	a5,a0
     a90:	fcb43023          	sd	a1,-64(s0)
     a94:	fac43c23          	sd	a2,-72(s0)
     a98:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     a9c:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     aa0:	fc042e23          	sw	zero,-36(s0)
     aa4:	a189                	j	ee6 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     aa6:	fdc42783          	lw	a5,-36(s0)
     aaa:	fc043703          	ld	a4,-64(s0)
     aae:	97ba                	add	a5,a5,a4
     ab0:	0007c783          	lbu	a5,0(a5)
     ab4:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     ab8:	fd842783          	lw	a5,-40(s0)
     abc:	2781                	sext.w	a5,a5
     abe:	eb8d                	bnez	a5,af0 <vprintf+0x6a>
      if(c0 == '%'){
     ac0:	fd442783          	lw	a5,-44(s0)
     ac4:	0007871b          	sext.w	a4,a5
     ac8:	02500793          	li	a5,37
     acc:	00f71763          	bne	a4,a5,ada <vprintf+0x54>
        state = '%';
     ad0:	02500793          	li	a5,37
     ad4:	fcf42c23          	sw	a5,-40(s0)
     ad8:	a111                	j	edc <vprintf+0x456>
      } else {
        putc(fd, c0);
     ada:	fd442783          	lw	a5,-44(s0)
     ade:	0ff7f713          	zext.b	a4,a5
     ae2:	fcc42783          	lw	a5,-52(s0)
     ae6:	85ba                	mv	a1,a4
     ae8:	853e                	mv	a0,a5
     aea:	dfbff0ef          	jal	8e4 <putc>
     aee:	a6fd                	j	edc <vprintf+0x456>
      }
    } else if(state == '%'){
     af0:	fd842783          	lw	a5,-40(s0)
     af4:	0007871b          	sext.w	a4,a5
     af8:	02500793          	li	a5,37
     afc:	3ef71063          	bne	a4,a5,edc <vprintf+0x456>
      c1 = c2 = 0;
     b00:	fe042023          	sw	zero,-32(s0)
     b04:	fe042783          	lw	a5,-32(s0)
     b08:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     b0c:	fd442783          	lw	a5,-44(s0)
     b10:	2781                	sext.w	a5,a5
     b12:	cb99                	beqz	a5,b28 <vprintf+0xa2>
     b14:	fdc42783          	lw	a5,-36(s0)
     b18:	0785                	addi	a5,a5,1
     b1a:	fc043703          	ld	a4,-64(s0)
     b1e:	97ba                	add	a5,a5,a4
     b20:	0007c783          	lbu	a5,0(a5)
     b24:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     b28:	fe442783          	lw	a5,-28(s0)
     b2c:	2781                	sext.w	a5,a5
     b2e:	cb99                	beqz	a5,b44 <vprintf+0xbe>
     b30:	fdc42783          	lw	a5,-36(s0)
     b34:	0789                	addi	a5,a5,2
     b36:	fc043703          	ld	a4,-64(s0)
     b3a:	97ba                	add	a5,a5,a4
     b3c:	0007c783          	lbu	a5,0(a5)
     b40:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     b44:	fd442783          	lw	a5,-44(s0)
     b48:	0007871b          	sext.w	a4,a5
     b4c:	06400793          	li	a5,100
     b50:	02f71363          	bne	a4,a5,b76 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     b54:	fb843783          	ld	a5,-72(s0)
     b58:	00878713          	addi	a4,a5,8
     b5c:	fae43c23          	sd	a4,-72(s0)
     b60:	439c                	lw	a5,0(a5)
     b62:	873e                	mv	a4,a5
     b64:	fcc42783          	lw	a5,-52(s0)
     b68:	4685                	li	a3,1
     b6a:	4629                	li	a2,10
     b6c:	85ba                	mv	a1,a4
     b6e:	853e                	mv	a0,a5
     b70:	da7ff0ef          	jal	916 <printint>
     b74:	a695                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     b76:	fd442783          	lw	a5,-44(s0)
     b7a:	0007871b          	sext.w	a4,a5
     b7e:	06c00793          	li	a5,108
     b82:	04f71063          	bne	a4,a5,bc2 <vprintf+0x13c>
     b86:	fe442783          	lw	a5,-28(s0)
     b8a:	0007871b          	sext.w	a4,a5
     b8e:	06400793          	li	a5,100
     b92:	02f71863          	bne	a4,a5,bc2 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     b96:	fb843783          	ld	a5,-72(s0)
     b9a:	00878713          	addi	a4,a5,8
     b9e:	fae43c23          	sd	a4,-72(s0)
     ba2:	639c                	ld	a5,0(a5)
     ba4:	873e                	mv	a4,a5
     ba6:	fcc42783          	lw	a5,-52(s0)
     baa:	4685                	li	a3,1
     bac:	4629                	li	a2,10
     bae:	85ba                	mv	a1,a4
     bb0:	853e                	mv	a0,a5
     bb2:	d65ff0ef          	jal	916 <printint>
        i += 1;
     bb6:	fdc42783          	lw	a5,-36(s0)
     bba:	2785                	addiw	a5,a5,1
     bbc:	fcf42e23          	sw	a5,-36(s0)
     bc0:	ae21                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     bc2:	fd442783          	lw	a5,-44(s0)
     bc6:	0007871b          	sext.w	a4,a5
     bca:	06c00793          	li	a5,108
     bce:	04f71863          	bne	a4,a5,c1e <vprintf+0x198>
     bd2:	fe442783          	lw	a5,-28(s0)
     bd6:	0007871b          	sext.w	a4,a5
     bda:	06c00793          	li	a5,108
     bde:	04f71063          	bne	a4,a5,c1e <vprintf+0x198>
     be2:	fe042783          	lw	a5,-32(s0)
     be6:	0007871b          	sext.w	a4,a5
     bea:	06400793          	li	a5,100
     bee:	02f71863          	bne	a4,a5,c1e <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     bf2:	fb843783          	ld	a5,-72(s0)
     bf6:	00878713          	addi	a4,a5,8
     bfa:	fae43c23          	sd	a4,-72(s0)
     bfe:	639c                	ld	a5,0(a5)
     c00:	873e                	mv	a4,a5
     c02:	fcc42783          	lw	a5,-52(s0)
     c06:	4685                	li	a3,1
     c08:	4629                	li	a2,10
     c0a:	85ba                	mv	a1,a4
     c0c:	853e                	mv	a0,a5
     c0e:	d09ff0ef          	jal	916 <printint>
        i += 2;
     c12:	fdc42783          	lw	a5,-36(s0)
     c16:	2789                	addiw	a5,a5,2
     c18:	fcf42e23          	sw	a5,-36(s0)
     c1c:	ac75                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'u'){
     c1e:	fd442783          	lw	a5,-44(s0)
     c22:	0007871b          	sext.w	a4,a5
     c26:	07500793          	li	a5,117
     c2a:	02f71563          	bne	a4,a5,c54 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     c2e:	fb843783          	ld	a5,-72(s0)
     c32:	00878713          	addi	a4,a5,8
     c36:	fae43c23          	sd	a4,-72(s0)
     c3a:	439c                	lw	a5,0(a5)
     c3c:	02079713          	slli	a4,a5,0x20
     c40:	9301                	srli	a4,a4,0x20
     c42:	fcc42783          	lw	a5,-52(s0)
     c46:	4681                	li	a3,0
     c48:	4629                	li	a2,10
     c4a:	85ba                	mv	a1,a4
     c4c:	853e                	mv	a0,a5
     c4e:	cc9ff0ef          	jal	916 <printint>
     c52:	a459                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     c54:	fd442783          	lw	a5,-44(s0)
     c58:	0007871b          	sext.w	a4,a5
     c5c:	06c00793          	li	a5,108
     c60:	04f71063          	bne	a4,a5,ca0 <vprintf+0x21a>
     c64:	fe442783          	lw	a5,-28(s0)
     c68:	0007871b          	sext.w	a4,a5
     c6c:	07500793          	li	a5,117
     c70:	02f71863          	bne	a4,a5,ca0 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c74:	fb843783          	ld	a5,-72(s0)
     c78:	00878713          	addi	a4,a5,8
     c7c:	fae43c23          	sd	a4,-72(s0)
     c80:	639c                	ld	a5,0(a5)
     c82:	873e                	mv	a4,a5
     c84:	fcc42783          	lw	a5,-52(s0)
     c88:	4681                	li	a3,0
     c8a:	4629                	li	a2,10
     c8c:	85ba                	mv	a1,a4
     c8e:	853e                	mv	a0,a5
     c90:	c87ff0ef          	jal	916 <printint>
        i += 1;
     c94:	fdc42783          	lw	a5,-36(s0)
     c98:	2785                	addiw	a5,a5,1
     c9a:	fcf42e23          	sw	a5,-36(s0)
     c9e:	ac2d                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ca0:	fd442783          	lw	a5,-44(s0)
     ca4:	0007871b          	sext.w	a4,a5
     ca8:	06c00793          	li	a5,108
     cac:	04f71863          	bne	a4,a5,cfc <vprintf+0x276>
     cb0:	fe442783          	lw	a5,-28(s0)
     cb4:	0007871b          	sext.w	a4,a5
     cb8:	06c00793          	li	a5,108
     cbc:	04f71063          	bne	a4,a5,cfc <vprintf+0x276>
     cc0:	fe042783          	lw	a5,-32(s0)
     cc4:	0007871b          	sext.w	a4,a5
     cc8:	07500793          	li	a5,117
     ccc:	02f71863          	bne	a4,a5,cfc <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     cd0:	fb843783          	ld	a5,-72(s0)
     cd4:	00878713          	addi	a4,a5,8
     cd8:	fae43c23          	sd	a4,-72(s0)
     cdc:	639c                	ld	a5,0(a5)
     cde:	873e                	mv	a4,a5
     ce0:	fcc42783          	lw	a5,-52(s0)
     ce4:	4681                	li	a3,0
     ce6:	4629                	li	a2,10
     ce8:	85ba                	mv	a1,a4
     cea:	853e                	mv	a0,a5
     cec:	c2bff0ef          	jal	916 <printint>
        i += 2;
     cf0:	fdc42783          	lw	a5,-36(s0)
     cf4:	2789                	addiw	a5,a5,2
     cf6:	fcf42e23          	sw	a5,-36(s0)
     cfa:	aaf9                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'x'){
     cfc:	fd442783          	lw	a5,-44(s0)
     d00:	0007871b          	sext.w	a4,a5
     d04:	07800793          	li	a5,120
     d08:	02f71563          	bne	a4,a5,d32 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     d0c:	fb843783          	ld	a5,-72(s0)
     d10:	00878713          	addi	a4,a5,8
     d14:	fae43c23          	sd	a4,-72(s0)
     d18:	439c                	lw	a5,0(a5)
     d1a:	02079713          	slli	a4,a5,0x20
     d1e:	9301                	srli	a4,a4,0x20
     d20:	fcc42783          	lw	a5,-52(s0)
     d24:	4681                	li	a3,0
     d26:	4641                	li	a2,16
     d28:	85ba                	mv	a1,a4
     d2a:	853e                	mv	a0,a5
     d2c:	bebff0ef          	jal	916 <printint>
     d30:	a265                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     d32:	fd442783          	lw	a5,-44(s0)
     d36:	0007871b          	sext.w	a4,a5
     d3a:	06c00793          	li	a5,108
     d3e:	04f71063          	bne	a4,a5,d7e <vprintf+0x2f8>
     d42:	fe442783          	lw	a5,-28(s0)
     d46:	0007871b          	sext.w	a4,a5
     d4a:	07800793          	li	a5,120
     d4e:	02f71863          	bne	a4,a5,d7e <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     d52:	fb843783          	ld	a5,-72(s0)
     d56:	00878713          	addi	a4,a5,8
     d5a:	fae43c23          	sd	a4,-72(s0)
     d5e:	639c                	ld	a5,0(a5)
     d60:	873e                	mv	a4,a5
     d62:	fcc42783          	lw	a5,-52(s0)
     d66:	4681                	li	a3,0
     d68:	4641                	li	a2,16
     d6a:	85ba                	mv	a1,a4
     d6c:	853e                	mv	a0,a5
     d6e:	ba9ff0ef          	jal	916 <printint>
        i += 1;
     d72:	fdc42783          	lw	a5,-36(s0)
     d76:	2785                	addiw	a5,a5,1
     d78:	fcf42e23          	sw	a5,-36(s0)
     d7c:	aab1                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     d7e:	fd442783          	lw	a5,-44(s0)
     d82:	0007871b          	sext.w	a4,a5
     d86:	06c00793          	li	a5,108
     d8a:	04f71863          	bne	a4,a5,dda <vprintf+0x354>
     d8e:	fe442783          	lw	a5,-28(s0)
     d92:	0007871b          	sext.w	a4,a5
     d96:	06c00793          	li	a5,108
     d9a:	04f71063          	bne	a4,a5,dda <vprintf+0x354>
     d9e:	fe042783          	lw	a5,-32(s0)
     da2:	0007871b          	sext.w	a4,a5
     da6:	07800793          	li	a5,120
     daa:	02f71863          	bne	a4,a5,dda <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     dae:	fb843783          	ld	a5,-72(s0)
     db2:	00878713          	addi	a4,a5,8
     db6:	fae43c23          	sd	a4,-72(s0)
     dba:	639c                	ld	a5,0(a5)
     dbc:	873e                	mv	a4,a5
     dbe:	fcc42783          	lw	a5,-52(s0)
     dc2:	4681                	li	a3,0
     dc4:	4641                	li	a2,16
     dc6:	85ba                	mv	a1,a4
     dc8:	853e                	mv	a0,a5
     dca:	b4dff0ef          	jal	916 <printint>
        i += 2;
     dce:	fdc42783          	lw	a5,-36(s0)
     dd2:	2789                	addiw	a5,a5,2
     dd4:	fcf42e23          	sw	a5,-36(s0)
     dd8:	a201                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'p'){
     dda:	fd442783          	lw	a5,-44(s0)
     dde:	0007871b          	sext.w	a4,a5
     de2:	07000793          	li	a5,112
     de6:	02f71063          	bne	a4,a5,e06 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     dea:	fb843783          	ld	a5,-72(s0)
     dee:	00878713          	addi	a4,a5,8
     df2:	fae43c23          	sd	a4,-72(s0)
     df6:	6398                	ld	a4,0(a5)
     df8:	fcc42783          	lw	a5,-52(s0)
     dfc:	85ba                	mv	a1,a4
     dfe:	853e                	mv	a0,a5
     e00:	c09ff0ef          	jal	a08 <printptr>
     e04:	a8d1                	j	ed8 <vprintf+0x452>
      } else if(c0 == 'c'){
     e06:	fd442783          	lw	a5,-44(s0)
     e0a:	0007871b          	sext.w	a4,a5
     e0e:	06300793          	li	a5,99
     e12:	02f71263          	bne	a4,a5,e36 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     e16:	fb843783          	ld	a5,-72(s0)
     e1a:	00878713          	addi	a4,a5,8
     e1e:	fae43c23          	sd	a4,-72(s0)
     e22:	439c                	lw	a5,0(a5)
     e24:	0ff7f713          	zext.b	a4,a5
     e28:	fcc42783          	lw	a5,-52(s0)
     e2c:	85ba                	mv	a1,a4
     e2e:	853e                	mv	a0,a5
     e30:	ab5ff0ef          	jal	8e4 <putc>
     e34:	a055                	j	ed8 <vprintf+0x452>
      } else if(c0 == 's'){
     e36:	fd442783          	lw	a5,-44(s0)
     e3a:	0007871b          	sext.w	a4,a5
     e3e:	07300793          	li	a5,115
     e42:	04f71a63          	bne	a4,a5,e96 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     e46:	fb843783          	ld	a5,-72(s0)
     e4a:	00878713          	addi	a4,a5,8
     e4e:	fae43c23          	sd	a4,-72(s0)
     e52:	639c                	ld	a5,0(a5)
     e54:	fef43423          	sd	a5,-24(s0)
     e58:	fe843783          	ld	a5,-24(s0)
     e5c:	e79d                	bnez	a5,e8a <vprintf+0x404>
          s = "(null)";
     e5e:	00000797          	auipc	a5,0x0
     e62:	48278793          	addi	a5,a5,1154 # 12e0 <malloc+0x1a0>
     e66:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     e6a:	a005                	j	e8a <vprintf+0x404>
          putc(fd, *s);
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	0007c703          	lbu	a4,0(a5)
     e74:	fcc42783          	lw	a5,-52(s0)
     e78:	85ba                	mv	a1,a4
     e7a:	853e                	mv	a0,a5
     e7c:	a69ff0ef          	jal	8e4 <putc>
        for(; *s; s++)
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	0785                	addi	a5,a5,1
     e86:	fef43423          	sd	a5,-24(s0)
     e8a:	fe843783          	ld	a5,-24(s0)
     e8e:	0007c783          	lbu	a5,0(a5)
     e92:	ffe9                	bnez	a5,e6c <vprintf+0x3e6>
     e94:	a091                	j	ed8 <vprintf+0x452>
      } else if(c0 == '%'){
     e96:	fd442783          	lw	a5,-44(s0)
     e9a:	0007871b          	sext.w	a4,a5
     e9e:	02500793          	li	a5,37
     ea2:	00f71a63          	bne	a4,a5,eb6 <vprintf+0x430>
        putc(fd, '%');
     ea6:	fcc42783          	lw	a5,-52(s0)
     eaa:	02500593          	li	a1,37
     eae:	853e                	mv	a0,a5
     eb0:	a35ff0ef          	jal	8e4 <putc>
     eb4:	a015                	j	ed8 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     eb6:	fcc42783          	lw	a5,-52(s0)
     eba:	02500593          	li	a1,37
     ebe:	853e                	mv	a0,a5
     ec0:	a25ff0ef          	jal	8e4 <putc>
        putc(fd, c0);
     ec4:	fd442783          	lw	a5,-44(s0)
     ec8:	0ff7f713          	zext.b	a4,a5
     ecc:	fcc42783          	lw	a5,-52(s0)
     ed0:	85ba                	mv	a1,a4
     ed2:	853e                	mv	a0,a5
     ed4:	a11ff0ef          	jal	8e4 <putc>
      }

      state = 0;
     ed8:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     edc:	fdc42783          	lw	a5,-36(s0)
     ee0:	2785                	addiw	a5,a5,1
     ee2:	fcf42e23          	sw	a5,-36(s0)
     ee6:	fdc42783          	lw	a5,-36(s0)
     eea:	fc043703          	ld	a4,-64(s0)
     eee:	97ba                	add	a5,a5,a4
     ef0:	0007c783          	lbu	a5,0(a5)
     ef4:	ba0799e3          	bnez	a5,aa6 <vprintf+0x20>
    }
  }
}
     ef8:	0001                	nop
     efa:	0001                	nop
     efc:	60a6                	ld	ra,72(sp)
     efe:	6406                	ld	s0,64(sp)
     f00:	6161                	addi	sp,sp,80
     f02:	8082                	ret

0000000000000f04 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f04:	7159                	addi	sp,sp,-112
     f06:	fc06                	sd	ra,56(sp)
     f08:	f822                	sd	s0,48(sp)
     f0a:	0080                	addi	s0,sp,64
     f0c:	fcb43823          	sd	a1,-48(s0)
     f10:	e010                	sd	a2,0(s0)
     f12:	e414                	sd	a3,8(s0)
     f14:	e818                	sd	a4,16(s0)
     f16:	ec1c                	sd	a5,24(s0)
     f18:	03043023          	sd	a6,32(s0)
     f1c:	03143423          	sd	a7,40(s0)
     f20:	87aa                	mv	a5,a0
     f22:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     f26:	03040793          	addi	a5,s0,48
     f2a:	fcf43423          	sd	a5,-56(s0)
     f2e:	fc843783          	ld	a5,-56(s0)
     f32:	fd078793          	addi	a5,a5,-48
     f36:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     f3a:	fe843703          	ld	a4,-24(s0)
     f3e:	fdc42783          	lw	a5,-36(s0)
     f42:	863a                	mv	a2,a4
     f44:	fd043583          	ld	a1,-48(s0)
     f48:	853e                	mv	a0,a5
     f4a:	b3dff0ef          	jal	a86 <vprintf>
}
     f4e:	0001                	nop
     f50:	70e2                	ld	ra,56(sp)
     f52:	7442                	ld	s0,48(sp)
     f54:	6165                	addi	sp,sp,112
     f56:	8082                	ret

0000000000000f58 <printf>:

void
printf(const char *fmt, ...)
{
     f58:	7159                	addi	sp,sp,-112
     f5a:	f406                	sd	ra,40(sp)
     f5c:	f022                	sd	s0,32(sp)
     f5e:	1800                	addi	s0,sp,48
     f60:	fca43c23          	sd	a0,-40(s0)
     f64:	e40c                	sd	a1,8(s0)
     f66:	e810                	sd	a2,16(s0)
     f68:	ec14                	sd	a3,24(s0)
     f6a:	f018                	sd	a4,32(s0)
     f6c:	f41c                	sd	a5,40(s0)
     f6e:	03043823          	sd	a6,48(s0)
     f72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f76:	04040793          	addi	a5,s0,64
     f7a:	fcf43823          	sd	a5,-48(s0)
     f7e:	fd043783          	ld	a5,-48(s0)
     f82:	fc878793          	addi	a5,a5,-56
     f86:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     f8a:	fe843783          	ld	a5,-24(s0)
     f8e:	863e                	mv	a2,a5
     f90:	fd843583          	ld	a1,-40(s0)
     f94:	4505                	li	a0,1
     f96:	af1ff0ef          	jal	a86 <vprintf>
}
     f9a:	0001                	nop
     f9c:	70a2                	ld	ra,40(sp)
     f9e:	7402                	ld	s0,32(sp)
     fa0:	6165                	addi	sp,sp,112
     fa2:	8082                	ret

0000000000000fa4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fa4:	7179                	addi	sp,sp,-48
     fa6:	f406                	sd	ra,40(sp)
     fa8:	f022                	sd	s0,32(sp)
     faa:	1800                	addi	s0,sp,48
     fac:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fb0:	fd843783          	ld	a5,-40(s0)
     fb4:	17c1                	addi	a5,a5,-16
     fb6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fba:	00001797          	auipc	a5,0x1
     fbe:	08678793          	addi	a5,a5,134 # 2040 <freep>
     fc2:	639c                	ld	a5,0(a5)
     fc4:	fef43423          	sd	a5,-24(s0)
     fc8:	a815                	j	ffc <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fca:	fe843783          	ld	a5,-24(s0)
     fce:	639c                	ld	a5,0(a5)
     fd0:	fe843703          	ld	a4,-24(s0)
     fd4:	00f76f63          	bltu	a4,a5,ff2 <free+0x4e>
     fd8:	fe043703          	ld	a4,-32(s0)
     fdc:	fe843783          	ld	a5,-24(s0)
     fe0:	02e7eb63          	bltu	a5,a4,1016 <free+0x72>
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	639c                	ld	a5,0(a5)
     fea:	fe043703          	ld	a4,-32(s0)
     fee:	02f76463          	bltu	a4,a5,1016 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	639c                	ld	a5,0(a5)
     ff8:	fef43423          	sd	a5,-24(s0)
     ffc:	fe043703          	ld	a4,-32(s0)
    1000:	fe843783          	ld	a5,-24(s0)
    1004:	fce7f3e3          	bgeu	a5,a4,fca <free+0x26>
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	639c                	ld	a5,0(a5)
    100e:	fe043703          	ld	a4,-32(s0)
    1012:	faf77ce3          	bgeu	a4,a5,fca <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1016:	fe043783          	ld	a5,-32(s0)
    101a:	479c                	lw	a5,8(a5)
    101c:	1782                	slli	a5,a5,0x20
    101e:	9381                	srli	a5,a5,0x20
    1020:	0792                	slli	a5,a5,0x4
    1022:	fe043703          	ld	a4,-32(s0)
    1026:	973e                	add	a4,a4,a5
    1028:	fe843783          	ld	a5,-24(s0)
    102c:	639c                	ld	a5,0(a5)
    102e:	02f71763          	bne	a4,a5,105c <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    1032:	fe043783          	ld	a5,-32(s0)
    1036:	4798                	lw	a4,8(a5)
    1038:	fe843783          	ld	a5,-24(s0)
    103c:	639c                	ld	a5,0(a5)
    103e:	479c                	lw	a5,8(a5)
    1040:	9fb9                	addw	a5,a5,a4
    1042:	0007871b          	sext.w	a4,a5
    1046:	fe043783          	ld	a5,-32(s0)
    104a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    104c:	fe843783          	ld	a5,-24(s0)
    1050:	639c                	ld	a5,0(a5)
    1052:	6398                	ld	a4,0(a5)
    1054:	fe043783          	ld	a5,-32(s0)
    1058:	e398                	sd	a4,0(a5)
    105a:	a039                	j	1068 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    105c:	fe843783          	ld	a5,-24(s0)
    1060:	6398                	ld	a4,0(a5)
    1062:	fe043783          	ld	a5,-32(s0)
    1066:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1068:	fe843783          	ld	a5,-24(s0)
    106c:	479c                	lw	a5,8(a5)
    106e:	1782                	slli	a5,a5,0x20
    1070:	9381                	srli	a5,a5,0x20
    1072:	0792                	slli	a5,a5,0x4
    1074:	fe843703          	ld	a4,-24(s0)
    1078:	97ba                	add	a5,a5,a4
    107a:	fe043703          	ld	a4,-32(s0)
    107e:	02f71563          	bne	a4,a5,10a8 <free+0x104>
    p->s.size += bp->s.size;
    1082:	fe843783          	ld	a5,-24(s0)
    1086:	4798                	lw	a4,8(a5)
    1088:	fe043783          	ld	a5,-32(s0)
    108c:	479c                	lw	a5,8(a5)
    108e:	9fb9                	addw	a5,a5,a4
    1090:	0007871b          	sext.w	a4,a5
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    109a:	fe043783          	ld	a5,-32(s0)
    109e:	6398                	ld	a4,0(a5)
    10a0:	fe843783          	ld	a5,-24(s0)
    10a4:	e398                	sd	a4,0(a5)
    10a6:	a031                	j	10b2 <free+0x10e>
  } else
    p->s.ptr = bp;
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	fe043703          	ld	a4,-32(s0)
    10b0:	e398                	sd	a4,0(a5)
  freep = p;
    10b2:	00001797          	auipc	a5,0x1
    10b6:	f8e78793          	addi	a5,a5,-114 # 2040 <freep>
    10ba:	fe843703          	ld	a4,-24(s0)
    10be:	e398                	sd	a4,0(a5)
}
    10c0:	0001                	nop
    10c2:	70a2                	ld	ra,40(sp)
    10c4:	7402                	ld	s0,32(sp)
    10c6:	6145                	addi	sp,sp,48
    10c8:	8082                	ret

00000000000010ca <morecore>:

static Header*
morecore(uint nu)
{
    10ca:	7179                	addi	sp,sp,-48
    10cc:	f406                	sd	ra,40(sp)
    10ce:	f022                	sd	s0,32(sp)
    10d0:	1800                	addi	s0,sp,48
    10d2:	87aa                	mv	a5,a0
    10d4:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    10d8:	fdc42783          	lw	a5,-36(s0)
    10dc:	0007871b          	sext.w	a4,a5
    10e0:	6785                	lui	a5,0x1
    10e2:	00f77563          	bgeu	a4,a5,10ec <morecore+0x22>
    nu = 4096;
    10e6:	6785                	lui	a5,0x1
    10e8:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    10ec:	fdc42783          	lw	a5,-36(s0)
    10f0:	0047979b          	slliw	a5,a5,0x4
    10f4:	2781                	sext.w	a5,a5
    10f6:	853e                	mv	a0,a5
    10f8:	ef0ff0ef          	jal	7e8 <sbrk>
    10fc:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    1100:	fe843703          	ld	a4,-24(s0)
    1104:	57fd                	li	a5,-1
    1106:	00f71463          	bne	a4,a5,110e <morecore+0x44>
    return 0;
    110a:	4781                	li	a5,0
    110c:	a02d                	j	1136 <morecore+0x6c>
  hp = (Header*)p;
    110e:	fe843783          	ld	a5,-24(s0)
    1112:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1116:	fe043783          	ld	a5,-32(s0)
    111a:	fdc42703          	lw	a4,-36(s0)
    111e:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1120:	fe043783          	ld	a5,-32(s0)
    1124:	07c1                	addi	a5,a5,16 # 1010 <free+0x6c>
    1126:	853e                	mv	a0,a5
    1128:	e7dff0ef          	jal	fa4 <free>
  return freep;
    112c:	00001797          	auipc	a5,0x1
    1130:	f1478793          	addi	a5,a5,-236 # 2040 <freep>
    1134:	639c                	ld	a5,0(a5)
}
    1136:	853e                	mv	a0,a5
    1138:	70a2                	ld	ra,40(sp)
    113a:	7402                	ld	s0,32(sp)
    113c:	6145                	addi	sp,sp,48
    113e:	8082                	ret

0000000000001140 <malloc>:

void*
malloc(uint nbytes)
{
    1140:	7139                	addi	sp,sp,-64
    1142:	fc06                	sd	ra,56(sp)
    1144:	f822                	sd	s0,48(sp)
    1146:	0080                	addi	s0,sp,64
    1148:	87aa                	mv	a5,a0
    114a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    114e:	fcc46783          	lwu	a5,-52(s0)
    1152:	07bd                	addi	a5,a5,15
    1154:	8391                	srli	a5,a5,0x4
    1156:	2781                	sext.w	a5,a5
    1158:	2785                	addiw	a5,a5,1
    115a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    115e:	00001797          	auipc	a5,0x1
    1162:	ee278793          	addi	a5,a5,-286 # 2040 <freep>
    1166:	639c                	ld	a5,0(a5)
    1168:	fef43023          	sd	a5,-32(s0)
    116c:	fe043783          	ld	a5,-32(s0)
    1170:	ef95                	bnez	a5,11ac <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1172:	00001797          	auipc	a5,0x1
    1176:	ebe78793          	addi	a5,a5,-322 # 2030 <base>
    117a:	fef43023          	sd	a5,-32(s0)
    117e:	00001797          	auipc	a5,0x1
    1182:	ec278793          	addi	a5,a5,-318 # 2040 <freep>
    1186:	fe043703          	ld	a4,-32(s0)
    118a:	e398                	sd	a4,0(a5)
    118c:	00001797          	auipc	a5,0x1
    1190:	eb478793          	addi	a5,a5,-332 # 2040 <freep>
    1194:	6398                	ld	a4,0(a5)
    1196:	00001797          	auipc	a5,0x1
    119a:	e9a78793          	addi	a5,a5,-358 # 2030 <base>
    119e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    11a0:	00001797          	auipc	a5,0x1
    11a4:	e9078793          	addi	a5,a5,-368 # 2030 <base>
    11a8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11ac:	fe043783          	ld	a5,-32(s0)
    11b0:	639c                	ld	a5,0(a5)
    11b2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    11b6:	fe843783          	ld	a5,-24(s0)
    11ba:	479c                	lw	a5,8(a5)
    11bc:	fdc42703          	lw	a4,-36(s0)
    11c0:	2701                	sext.w	a4,a4
    11c2:	06e7e763          	bltu	a5,a4,1230 <malloc+0xf0>
      if(p->s.size == nunits)
    11c6:	fe843783          	ld	a5,-24(s0)
    11ca:	479c                	lw	a5,8(a5)
    11cc:	fdc42703          	lw	a4,-36(s0)
    11d0:	2701                	sext.w	a4,a4
    11d2:	00f71963          	bne	a4,a5,11e4 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    11d6:	fe843783          	ld	a5,-24(s0)
    11da:	6398                	ld	a4,0(a5)
    11dc:	fe043783          	ld	a5,-32(s0)
    11e0:	e398                	sd	a4,0(a5)
    11e2:	a825                	j	121a <malloc+0xda>
      else {
        p->s.size -= nunits;
    11e4:	fe843783          	ld	a5,-24(s0)
    11e8:	479c                	lw	a5,8(a5)
    11ea:	fdc42703          	lw	a4,-36(s0)
    11ee:	9f99                	subw	a5,a5,a4
    11f0:	0007871b          	sext.w	a4,a5
    11f4:	fe843783          	ld	a5,-24(s0)
    11f8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    11fa:	fe843783          	ld	a5,-24(s0)
    11fe:	479c                	lw	a5,8(a5)
    1200:	1782                	slli	a5,a5,0x20
    1202:	9381                	srli	a5,a5,0x20
    1204:	0792                	slli	a5,a5,0x4
    1206:	fe843703          	ld	a4,-24(s0)
    120a:	97ba                	add	a5,a5,a4
    120c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1210:	fe843783          	ld	a5,-24(s0)
    1214:	fdc42703          	lw	a4,-36(s0)
    1218:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    121a:	00001797          	auipc	a5,0x1
    121e:	e2678793          	addi	a5,a5,-474 # 2040 <freep>
    1222:	fe043703          	ld	a4,-32(s0)
    1226:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1228:	fe843783          	ld	a5,-24(s0)
    122c:	07c1                	addi	a5,a5,16
    122e:	a081                	j	126e <malloc+0x12e>
    }
    if(p == freep)
    1230:	00001797          	auipc	a5,0x1
    1234:	e1078793          	addi	a5,a5,-496 # 2040 <freep>
    1238:	639c                	ld	a5,0(a5)
    123a:	fe843703          	ld	a4,-24(s0)
    123e:	00f71e63          	bne	a4,a5,125a <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1242:	fdc42783          	lw	a5,-36(s0)
    1246:	853e                	mv	a0,a5
    1248:	e83ff0ef          	jal	10ca <morecore>
    124c:	fea43423          	sd	a0,-24(s0)
    1250:	fe843783          	ld	a5,-24(s0)
    1254:	e399                	bnez	a5,125a <malloc+0x11a>
        return 0;
    1256:	4781                	li	a5,0
    1258:	a819                	j	126e <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    125a:	fe843783          	ld	a5,-24(s0)
    125e:	fef43023          	sd	a5,-32(s0)
    1262:	fe843783          	ld	a5,-24(s0)
    1266:	639c                	ld	a5,0(a5)
    1268:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    126c:	b7a9                	j	11b6 <malloc+0x76>
  }
}
    126e:	853e                	mv	a0,a5
    1270:	70e2                	ld	ra,56(sp)
    1272:	7442                	ld	s0,48(sp)
    1274:	6121                	addi	sp,sp,64
    1276:	8082                	ret
