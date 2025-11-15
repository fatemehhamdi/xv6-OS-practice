
user/_treetest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(void) {
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
    int worker_pid;
    int p[2]; // آرایه برای نگهداری فایل‌دسکریپتورهای پایپ

    // 1. یک پایپ برای هماهنگ‌سازی ایجاد کن
    // p[0] برای خواندن است, p[1] برای نوشتن
    if(pipe(p) < 0){
       8:	fe040793          	addi	a5,s0,-32
       c:	853e                	mv	a0,a5
       e:	6ae000ef          	jal	6bc <pipe>
      12:	87aa                	mv	a5,a0
      14:	0007db63          	bgez	a5,2a <main+0x2a>
        printf("pipe failed\n");
      18:	00001517          	auipc	a0,0x1
      1c:	0d850513          	addi	a0,a0,216 # 10f0 <malloc+0x138>
      20:	5b1000ef          	jal	dd0 <printf>
        exit(1);
      24:	4505                	li	a0,1
      26:	686000ef          	jal	6ac <exit>
    }

    printf("simpletest: Creating a worker child and synchronizing with a pipe.\n");
      2a:	00001517          	auipc	a0,0x1
      2e:	0d650513          	addi	a0,a0,214 # 1100 <malloc+0x148>
      32:	59f000ef          	jal	dd0 <printf>

    // 2. فرآیند فرزند (worker) را ایجاد کن
    worker_pid = fork();
      36:	66e000ef          	jal	6a4 <fork>
      3a:	87aa                	mv	a5,a0
      3c:	fef42623          	sw	a5,-20(s0)

    if(worker_pid < 0){
      40:	fec42783          	lw	a5,-20(s0)
      44:	2781                	sext.w	a5,a5
      46:	0007db63          	bgez	a5,5c <main+0x5c>
        printf("fork failed\n");
      4a:	00001517          	auipc	a0,0x1
      4e:	0fe50513          	addi	a0,a0,254 # 1148 <malloc+0x190>
      52:	57f000ef          	jal	dd0 <printf>
        exit(1);
      56:	4505                	li	a0,1
      58:	654000ef          	jal	6ac <exit>
    }

    if(worker_pid == 0){
      5c:	fec42783          	lw	a5,-20(s0)
      60:	2781                	sext.w	a5,a5
      62:	e3c1                	bnez	a5,e2 <main+0xe2>
        // --- کد فرآیند فرزند (Worker) ---
        close(p[0]); // فرزند به سرِ خواندنی پایپ نیازی ندارد
      64:	fe042783          	lw	a5,-32(s0)
      68:	853e                	mv	a0,a5
      6a:	66a000ef          	jal	6d4 <close>

        printf("worker (%d): I am alive. Signaling parent through pipe...\n", getpid());
      6e:	6be000ef          	jal	72c <getpid>
      72:	87aa                	mv	a5,a0
      74:	85be                	mv	a1,a5
      76:	00001517          	auipc	a0,0x1
      7a:	0e250513          	addi	a0,a0,226 # 1158 <malloc+0x1a0>
      7e:	553000ef          	jal	dd0 <printf>
        
        // یک بایت در پایپ بنویس تا به والد اطلاع دهی که آماده‌ای
        // محتوای "a" مهم نیست، فقط خود عمل نوشتن مهم است
        write(p[1], "a", 1); 
      82:	fe442783          	lw	a5,-28(s0)
      86:	4605                	li	a2,1
      88:	00001597          	auipc	a1,0x1
      8c:	11058593          	addi	a1,a1,272 # 1198 <malloc+0x1e0>
      90:	853e                	mv	a0,a5
      92:	63a000ef          	jal	6cc <write>
        close(p[1]); // کارمان با سرِ نوشتنی تمام شد
      96:	fe442783          	lw	a5,-28(s0)
      9a:	853e                	mv	a0,a5
      9c:	638000ef          	jal	6d4 <close>

        // حالا کار اصلی را انجام بده
        for(volatile int i = 0; i < 90000000; i++); 
      a0:	fc042e23          	sw	zero,-36(s0)
      a4:	a801                	j	b4 <main+0xb4>
      a6:	fdc42783          	lw	a5,-36(s0)
      aa:	2781                	sext.w	a5,a5
      ac:	2785                	addiw	a5,a5,1
      ae:	2781                	sext.w	a5,a5
      b0:	fcf42e23          	sw	a5,-36(s0)
      b4:	fdc42783          	lw	a5,-36(s0)
      b8:	0007871b          	sext.w	a4,a5
      bc:	055d57b7          	lui	a5,0x55d5
      c0:	a7f78793          	addi	a5,a5,-1409 # 55d4a7f <freep+0x55d2a4f>
      c4:	fee7d1e3          	bge	a5,a4,a6 <main+0xa6>
        
        printf("worker (%d): Work done. Exiting.\n", getpid());
      c8:	664000ef          	jal	72c <getpid>
      cc:	87aa                	mv	a5,a0
      ce:	85be                	mv	a1,a5
      d0:	00001517          	auipc	a0,0x1
      d4:	0d050513          	addi	a0,a0,208 # 11a0 <malloc+0x1e8>
      d8:	4f9000ef          	jal	dd0 <printf>
        exit(0);
      dc:	4501                	li	a0,0
      de:	5ce000ef          	jal	6ac <exit>
    } else {
        // --- کد فرآیند والد (simpletest) ---
        close(p[1]); // والد به سرِ نوشتنی پایپ نیازی ندارد
      e2:	fe442783          	lw	a5,-28(s0)
      e6:	853e                	mv	a0,a5
      e8:	5ec000ef          	jal	6d4 <close>

        char buf[1];
        // منتظر سیگنال از طرف فرزند بمان
        // این دستور تا زمانی که فرزند در پایپ ننویسد، برنامه را متوقف می‌کند
        read(p[0], buf, 1);
      ec:	fe042783          	lw	a5,-32(s0)
      f0:	fd840713          	addi	a4,s0,-40
      f4:	4605                	li	a2,1
      f6:	85ba                	mv	a1,a4
      f8:	853e                	mv	a0,a5
      fa:	5ca000ef          	jal	6c4 <read>
        close(p[0]); // کارمان با سرِ خواندنی تمام شد
      fe:	fe042783          	lw	a5,-32(s0)
     102:	853e                	mv	a0,a5
     104:	5d0000ef          	jal	6d4 <close>

        printf("parent (%d): Signal received from worker. Now running 'top --tree'.\n\n", getpid());
     108:	624000ef          	jal	72c <getpid>
     10c:	87aa                	mv	a5,a0
     10e:	85be                	mv	a1,a5
     110:	00001517          	auipc	a0,0x1
     114:	0b850513          	addi	a0,a0,184 # 11c8 <malloc+0x210>
     118:	4b9000ef          	jal	dd0 <printf>

        // 3. حالا که مطمئنیم worker در حال اجراست، top را اجرا کن
        int top_pid = fork();
     11c:	588000ef          	jal	6a4 <fork>
     120:	87aa                	mv	a5,a0
     122:	fef42423          	sw	a5,-24(s0)
        if(top_pid == 0){
     126:	fe842783          	lw	a5,-24(s0)
     12a:	2781                	sext.w	a5,a5
     12c:	e3a9                	bnez	a5,16e <main+0x16e>
            char *argv[] = {"top", "--tree", 0};
     12e:	00001797          	auipc	a5,0x1
     132:	0e278793          	addi	a5,a5,226 # 1210 <malloc+0x258>
     136:	fcf43023          	sd	a5,-64(s0)
     13a:	00001797          	auipc	a5,0x1
     13e:	0de78793          	addi	a5,a5,222 # 1218 <malloc+0x260>
     142:	fcf43423          	sd	a5,-56(s0)
     146:	fc043823          	sd	zero,-48(s0)
            exec("top", argv);
     14a:	fc040793          	addi	a5,s0,-64
     14e:	85be                	mv	a1,a5
     150:	00001517          	auipc	a0,0x1
     154:	0c050513          	addi	a0,a0,192 # 1210 <malloc+0x258>
     158:	58c000ef          	jal	6e4 <exec>
            printf("exec top failed!\n"); 
     15c:	00001517          	auipc	a0,0x1
     160:	0c450513          	addi	a0,a0,196 # 1220 <malloc+0x268>
     164:	46d000ef          	jal	dd0 <printf>
            exit(1);
     168:	4505                	li	a0,1
     16a:	542000ef          	jal	6ac <exit>
        }

        // 4. والد منتظر تمام شدن هر دو فرزندش می‌ماند
        wait(0); // منتظر باش تا فرآیند top تمام شود
     16e:	4501                	li	a0,0
     170:	544000ef          	jal	6b4 <wait>
        wait(0); // منتظر باش تا فرآیند worker تمام شود
     174:	4501                	li	a0,0
     176:	53e000ef          	jal	6b4 <wait>

        printf("\nparent (%d): Test complete.\n", getpid());
     17a:	5b2000ef          	jal	72c <getpid>
     17e:	87aa                	mv	a5,a0
     180:	85be                	mv	a1,a5
     182:	00001517          	auipc	a0,0x1
     186:	0b650513          	addi	a0,a0,182 # 1238 <malloc+0x280>
     18a:	447000ef          	jal	dd0 <printf>
    }

    exit(0);
     18e:	4501                	li	a0,0
     190:	51c000ef          	jal	6ac <exit>

0000000000000194 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     194:	7179                	addi	sp,sp,-48
     196:	f406                	sd	ra,40(sp)
     198:	f022                	sd	s0,32(sp)
     19a:	1800                	addi	s0,sp,48
     19c:	87aa                	mv	a5,a0
     19e:	fcb43823          	sd	a1,-48(s0)
     1a2:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     1a6:	fdc42783          	lw	a5,-36(s0)
     1aa:	fd043583          	ld	a1,-48(s0)
     1ae:	853e                	mv	a0,a5
     1b0:	e51ff0ef          	jal	0 <main>
     1b4:	87aa                	mv	a5,a0
     1b6:	fef42623          	sw	a5,-20(s0)
  exit(r);
     1ba:	fec42783          	lw	a5,-20(s0)
     1be:	853e                	mv	a0,a5
     1c0:	4ec000ef          	jal	6ac <exit>

00000000000001c4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     1c4:	7179                	addi	sp,sp,-48
     1c6:	f406                	sd	ra,40(sp)
     1c8:	f022                	sd	s0,32(sp)
     1ca:	1800                	addi	s0,sp,48
     1cc:	fca43c23          	sd	a0,-40(s0)
     1d0:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     1d4:	fd843783          	ld	a5,-40(s0)
     1d8:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     1dc:	0001                	nop
     1de:	fd043703          	ld	a4,-48(s0)
     1e2:	00170793          	addi	a5,a4,1
     1e6:	fcf43823          	sd	a5,-48(s0)
     1ea:	fd843783          	ld	a5,-40(s0)
     1ee:	00178693          	addi	a3,a5,1
     1f2:	fcd43c23          	sd	a3,-40(s0)
     1f6:	00074703          	lbu	a4,0(a4)
     1fa:	00e78023          	sb	a4,0(a5)
     1fe:	0007c783          	lbu	a5,0(a5)
     202:	fff1                	bnez	a5,1de <strcpy+0x1a>
    ;
  return os;
     204:	fe843783          	ld	a5,-24(s0)
}
     208:	853e                	mv	a0,a5
     20a:	70a2                	ld	ra,40(sp)
     20c:	7402                	ld	s0,32(sp)
     20e:	6145                	addi	sp,sp,48
     210:	8082                	ret

0000000000000212 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     212:	1101                	addi	sp,sp,-32
     214:	ec06                	sd	ra,24(sp)
     216:	e822                	sd	s0,16(sp)
     218:	1000                	addi	s0,sp,32
     21a:	fea43423          	sd	a0,-24(s0)
     21e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     222:	a819                	j	238 <strcmp+0x26>
    p++, q++;
     224:	fe843783          	ld	a5,-24(s0)
     228:	0785                	addi	a5,a5,1
     22a:	fef43423          	sd	a5,-24(s0)
     22e:	fe043783          	ld	a5,-32(s0)
     232:	0785                	addi	a5,a5,1
     234:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     238:	fe843783          	ld	a5,-24(s0)
     23c:	0007c783          	lbu	a5,0(a5)
     240:	cb99                	beqz	a5,256 <strcmp+0x44>
     242:	fe843783          	ld	a5,-24(s0)
     246:	0007c703          	lbu	a4,0(a5)
     24a:	fe043783          	ld	a5,-32(s0)
     24e:	0007c783          	lbu	a5,0(a5)
     252:	fcf709e3          	beq	a4,a5,224 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     256:	fe843783          	ld	a5,-24(s0)
     25a:	0007c783          	lbu	a5,0(a5)
     25e:	0007871b          	sext.w	a4,a5
     262:	fe043783          	ld	a5,-32(s0)
     266:	0007c783          	lbu	a5,0(a5)
     26a:	2781                	sext.w	a5,a5
     26c:	40f707bb          	subw	a5,a4,a5
     270:	2781                	sext.w	a5,a5
}
     272:	853e                	mv	a0,a5
     274:	60e2                	ld	ra,24(sp)
     276:	6442                	ld	s0,16(sp)
     278:	6105                	addi	sp,sp,32
     27a:	8082                	ret

000000000000027c <strlen>:

uint
strlen(const char *s)
{
     27c:	7179                	addi	sp,sp,-48
     27e:	f406                	sd	ra,40(sp)
     280:	f022                	sd	s0,32(sp)
     282:	1800                	addi	s0,sp,48
     284:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     288:	fe042623          	sw	zero,-20(s0)
     28c:	a031                	j	298 <strlen+0x1c>
     28e:	fec42783          	lw	a5,-20(s0)
     292:	2785                	addiw	a5,a5,1
     294:	fef42623          	sw	a5,-20(s0)
     298:	fec42783          	lw	a5,-20(s0)
     29c:	fd843703          	ld	a4,-40(s0)
     2a0:	97ba                	add	a5,a5,a4
     2a2:	0007c783          	lbu	a5,0(a5)
     2a6:	f7e5                	bnez	a5,28e <strlen+0x12>
    ;
  return n;
     2a8:	fec42783          	lw	a5,-20(s0)
}
     2ac:	853e                	mv	a0,a5
     2ae:	70a2                	ld	ra,40(sp)
     2b0:	7402                	ld	s0,32(sp)
     2b2:	6145                	addi	sp,sp,48
     2b4:	8082                	ret

00000000000002b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2b6:	7179                	addi	sp,sp,-48
     2b8:	f406                	sd	ra,40(sp)
     2ba:	f022                	sd	s0,32(sp)
     2bc:	1800                	addi	s0,sp,48
     2be:	fca43c23          	sd	a0,-40(s0)
     2c2:	87ae                	mv	a5,a1
     2c4:	8732                	mv	a4,a2
     2c6:	fcf42a23          	sw	a5,-44(s0)
     2ca:	87ba                	mv	a5,a4
     2cc:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     2d0:	fd843783          	ld	a5,-40(s0)
     2d4:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     2d8:	fe042623          	sw	zero,-20(s0)
     2dc:	a00d                	j	2fe <memset+0x48>
    cdst[i] = c;
     2de:	fec42783          	lw	a5,-20(s0)
     2e2:	fe043703          	ld	a4,-32(s0)
     2e6:	97ba                	add	a5,a5,a4
     2e8:	fd442703          	lw	a4,-44(s0)
     2ec:	0ff77713          	zext.b	a4,a4
     2f0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2f4:	fec42783          	lw	a5,-20(s0)
     2f8:	2785                	addiw	a5,a5,1
     2fa:	fef42623          	sw	a5,-20(s0)
     2fe:	fec42783          	lw	a5,-20(s0)
     302:	fd042703          	lw	a4,-48(s0)
     306:	2701                	sext.w	a4,a4
     308:	fce7ebe3          	bltu	a5,a4,2de <memset+0x28>
  }
  return dst;
     30c:	fd843783          	ld	a5,-40(s0)
}
     310:	853e                	mv	a0,a5
     312:	70a2                	ld	ra,40(sp)
     314:	7402                	ld	s0,32(sp)
     316:	6145                	addi	sp,sp,48
     318:	8082                	ret

000000000000031a <strchr>:

char*
strchr(const char *s, char c)
{
     31a:	1101                	addi	sp,sp,-32
     31c:	ec06                	sd	ra,24(sp)
     31e:	e822                	sd	s0,16(sp)
     320:	1000                	addi	s0,sp,32
     322:	fea43423          	sd	a0,-24(s0)
     326:	87ae                	mv	a5,a1
     328:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     32c:	a01d                	j	352 <strchr+0x38>
    if(*s == c)
     32e:	fe843783          	ld	a5,-24(s0)
     332:	0007c703          	lbu	a4,0(a5)
     336:	fe744783          	lbu	a5,-25(s0)
     33a:	0ff7f793          	zext.b	a5,a5
     33e:	00e79563          	bne	a5,a4,348 <strchr+0x2e>
      return (char*)s;
     342:	fe843783          	ld	a5,-24(s0)
     346:	a821                	j	35e <strchr+0x44>
  for(; *s; s++)
     348:	fe843783          	ld	a5,-24(s0)
     34c:	0785                	addi	a5,a5,1
     34e:	fef43423          	sd	a5,-24(s0)
     352:	fe843783          	ld	a5,-24(s0)
     356:	0007c783          	lbu	a5,0(a5)
     35a:	fbf1                	bnez	a5,32e <strchr+0x14>
  return 0;
     35c:	4781                	li	a5,0
}
     35e:	853e                	mv	a0,a5
     360:	60e2                	ld	ra,24(sp)
     362:	6442                	ld	s0,16(sp)
     364:	6105                	addi	sp,sp,32
     366:	8082                	ret

0000000000000368 <gets>:

char*
gets(char *buf, int max)
{
     368:	7179                	addi	sp,sp,-48
     36a:	f406                	sd	ra,40(sp)
     36c:	f022                	sd	s0,32(sp)
     36e:	1800                	addi	s0,sp,48
     370:	fca43c23          	sd	a0,-40(s0)
     374:	87ae                	mv	a5,a1
     376:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     37a:	fe042623          	sw	zero,-20(s0)
     37e:	a891                	j	3d2 <gets+0x6a>
    cc = read(0, &c, 1);
     380:	fe740793          	addi	a5,s0,-25
     384:	4605                	li	a2,1
     386:	85be                	mv	a1,a5
     388:	4501                	li	a0,0
     38a:	33a000ef          	jal	6c4 <read>
     38e:	87aa                	mv	a5,a0
     390:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     394:	fe842783          	lw	a5,-24(s0)
     398:	2781                	sext.w	a5,a5
     39a:	04f05663          	blez	a5,3e6 <gets+0x7e>
      break;
    buf[i++] = c;
     39e:	fec42783          	lw	a5,-20(s0)
     3a2:	0017871b          	addiw	a4,a5,1
     3a6:	fee42623          	sw	a4,-20(s0)
     3aa:	873e                	mv	a4,a5
     3ac:	fd843783          	ld	a5,-40(s0)
     3b0:	97ba                	add	a5,a5,a4
     3b2:	fe744703          	lbu	a4,-25(s0)
     3b6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     3ba:	fe744783          	lbu	a5,-25(s0)
     3be:	873e                	mv	a4,a5
     3c0:	47a9                	li	a5,10
     3c2:	02f70363          	beq	a4,a5,3e8 <gets+0x80>
     3c6:	fe744783          	lbu	a5,-25(s0)
     3ca:	873e                	mv	a4,a5
     3cc:	47b5                	li	a5,13
     3ce:	00f70d63          	beq	a4,a5,3e8 <gets+0x80>
  for(i=0; i+1 < max; ){
     3d2:	fec42783          	lw	a5,-20(s0)
     3d6:	2785                	addiw	a5,a5,1
     3d8:	2781                	sext.w	a5,a5
     3da:	fd442703          	lw	a4,-44(s0)
     3de:	2701                	sext.w	a4,a4
     3e0:	fae7c0e3          	blt	a5,a4,380 <gets+0x18>
     3e4:	a011                	j	3e8 <gets+0x80>
      break;
     3e6:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3e8:	fec42783          	lw	a5,-20(s0)
     3ec:	fd843703          	ld	a4,-40(s0)
     3f0:	97ba                	add	a5,a5,a4
     3f2:	00078023          	sb	zero,0(a5)
  return buf;
     3f6:	fd843783          	ld	a5,-40(s0)
}
     3fa:	853e                	mv	a0,a5
     3fc:	70a2                	ld	ra,40(sp)
     3fe:	7402                	ld	s0,32(sp)
     400:	6145                	addi	sp,sp,48
     402:	8082                	ret

0000000000000404 <stat>:

int
stat(const char *n, struct stat *st)
{
     404:	7179                	addi	sp,sp,-48
     406:	f406                	sd	ra,40(sp)
     408:	f022                	sd	s0,32(sp)
     40a:	1800                	addi	s0,sp,48
     40c:	fca43c23          	sd	a0,-40(s0)
     410:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     414:	4581                	li	a1,0
     416:	fd843503          	ld	a0,-40(s0)
     41a:	2d2000ef          	jal	6ec <open>
     41e:	87aa                	mv	a5,a0
     420:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     424:	fec42783          	lw	a5,-20(s0)
     428:	2781                	sext.w	a5,a5
     42a:	0007d463          	bgez	a5,432 <stat+0x2e>
    return -1;
     42e:	57fd                	li	a5,-1
     430:	a015                	j	454 <stat+0x50>
  r = fstat(fd, st);
     432:	fec42783          	lw	a5,-20(s0)
     436:	fd043583          	ld	a1,-48(s0)
     43a:	853e                	mv	a0,a5
     43c:	2c8000ef          	jal	704 <fstat>
     440:	87aa                	mv	a5,a0
     442:	fef42423          	sw	a5,-24(s0)
  close(fd);
     446:	fec42783          	lw	a5,-20(s0)
     44a:	853e                	mv	a0,a5
     44c:	288000ef          	jal	6d4 <close>
  return r;
     450:	fe842783          	lw	a5,-24(s0)
}
     454:	853e                	mv	a0,a5
     456:	70a2                	ld	ra,40(sp)
     458:	7402                	ld	s0,32(sp)
     45a:	6145                	addi	sp,sp,48
     45c:	8082                	ret

000000000000045e <atoi>:

int
atoi(const char *s)
{
     45e:	7179                	addi	sp,sp,-48
     460:	f406                	sd	ra,40(sp)
     462:	f022                	sd	s0,32(sp)
     464:	1800                	addi	s0,sp,48
     466:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     46a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     46e:	a81d                	j	4a4 <atoi+0x46>
    n = n*10 + *s++ - '0';
     470:	fec42783          	lw	a5,-20(s0)
     474:	873e                	mv	a4,a5
     476:	87ba                	mv	a5,a4
     478:	0027979b          	slliw	a5,a5,0x2
     47c:	9fb9                	addw	a5,a5,a4
     47e:	0017979b          	slliw	a5,a5,0x1
     482:	0007871b          	sext.w	a4,a5
     486:	fd843783          	ld	a5,-40(s0)
     48a:	00178693          	addi	a3,a5,1
     48e:	fcd43c23          	sd	a3,-40(s0)
     492:	0007c783          	lbu	a5,0(a5)
     496:	2781                	sext.w	a5,a5
     498:	9fb9                	addw	a5,a5,a4
     49a:	2781                	sext.w	a5,a5
     49c:	fd07879b          	addiw	a5,a5,-48
     4a0:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     4a4:	fd843783          	ld	a5,-40(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	873e                	mv	a4,a5
     4ae:	02f00793          	li	a5,47
     4b2:	00e7fb63          	bgeu	a5,a4,4c8 <atoi+0x6a>
     4b6:	fd843783          	ld	a5,-40(s0)
     4ba:	0007c783          	lbu	a5,0(a5)
     4be:	873e                	mv	a4,a5
     4c0:	03900793          	li	a5,57
     4c4:	fae7f6e3          	bgeu	a5,a4,470 <atoi+0x12>
  return n;
     4c8:	fec42783          	lw	a5,-20(s0)
}
     4cc:	853e                	mv	a0,a5
     4ce:	70a2                	ld	ra,40(sp)
     4d0:	7402                	ld	s0,32(sp)
     4d2:	6145                	addi	sp,sp,48
     4d4:	8082                	ret

00000000000004d6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     4d6:	7139                	addi	sp,sp,-64
     4d8:	fc06                	sd	ra,56(sp)
     4da:	f822                	sd	s0,48(sp)
     4dc:	0080                	addi	s0,sp,64
     4de:	fca43c23          	sd	a0,-40(s0)
     4e2:	fcb43823          	sd	a1,-48(s0)
     4e6:	87b2                	mv	a5,a2
     4e8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4ec:	fd843783          	ld	a5,-40(s0)
     4f0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4f4:	fd043783          	ld	a5,-48(s0)
     4f8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4fc:	fe043703          	ld	a4,-32(s0)
     500:	fe843783          	ld	a5,-24(s0)
     504:	02e7fc63          	bgeu	a5,a4,53c <memmove+0x66>
    while(n-- > 0)
     508:	a00d                	j	52a <memmove+0x54>
      *dst++ = *src++;
     50a:	fe043703          	ld	a4,-32(s0)
     50e:	00170793          	addi	a5,a4,1
     512:	fef43023          	sd	a5,-32(s0)
     516:	fe843783          	ld	a5,-24(s0)
     51a:	00178693          	addi	a3,a5,1
     51e:	fed43423          	sd	a3,-24(s0)
     522:	00074703          	lbu	a4,0(a4)
     526:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     52a:	fcc42783          	lw	a5,-52(s0)
     52e:	fff7871b          	addiw	a4,a5,-1
     532:	fce42623          	sw	a4,-52(s0)
     536:	fcf04ae3          	bgtz	a5,50a <memmove+0x34>
     53a:	a891                	j	58e <memmove+0xb8>
  } else {
    dst += n;
     53c:	fcc42783          	lw	a5,-52(s0)
     540:	fe843703          	ld	a4,-24(s0)
     544:	97ba                	add	a5,a5,a4
     546:	fef43423          	sd	a5,-24(s0)
    src += n;
     54a:	fcc42783          	lw	a5,-52(s0)
     54e:	fe043703          	ld	a4,-32(s0)
     552:	97ba                	add	a5,a5,a4
     554:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     558:	a01d                	j	57e <memmove+0xa8>
      *--dst = *--src;
     55a:	fe043783          	ld	a5,-32(s0)
     55e:	17fd                	addi	a5,a5,-1
     560:	fef43023          	sd	a5,-32(s0)
     564:	fe843783          	ld	a5,-24(s0)
     568:	17fd                	addi	a5,a5,-1
     56a:	fef43423          	sd	a5,-24(s0)
     56e:	fe043783          	ld	a5,-32(s0)
     572:	0007c703          	lbu	a4,0(a5)
     576:	fe843783          	ld	a5,-24(s0)
     57a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     57e:	fcc42783          	lw	a5,-52(s0)
     582:	fff7871b          	addiw	a4,a5,-1
     586:	fce42623          	sw	a4,-52(s0)
     58a:	fcf048e3          	bgtz	a5,55a <memmove+0x84>
  }
  return vdst;
     58e:	fd843783          	ld	a5,-40(s0)
}
     592:	853e                	mv	a0,a5
     594:	70e2                	ld	ra,56(sp)
     596:	7442                	ld	s0,48(sp)
     598:	6121                	addi	sp,sp,64
     59a:	8082                	ret

000000000000059c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     59c:	7139                	addi	sp,sp,-64
     59e:	fc06                	sd	ra,56(sp)
     5a0:	f822                	sd	s0,48(sp)
     5a2:	0080                	addi	s0,sp,64
     5a4:	fca43c23          	sd	a0,-40(s0)
     5a8:	fcb43823          	sd	a1,-48(s0)
     5ac:	87b2                	mv	a5,a2
     5ae:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     5b2:	fd843783          	ld	a5,-40(s0)
     5b6:	fef43423          	sd	a5,-24(s0)
     5ba:	fd043783          	ld	a5,-48(s0)
     5be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5c2:	a0a1                	j	60a <memcmp+0x6e>
    if (*p1 != *p2) {
     5c4:	fe843783          	ld	a5,-24(s0)
     5c8:	0007c703          	lbu	a4,0(a5)
     5cc:	fe043783          	ld	a5,-32(s0)
     5d0:	0007c783          	lbu	a5,0(a5)
     5d4:	02f70163          	beq	a4,a5,5f6 <memcmp+0x5a>
      return *p1 - *p2;
     5d8:	fe843783          	ld	a5,-24(s0)
     5dc:	0007c783          	lbu	a5,0(a5)
     5e0:	0007871b          	sext.w	a4,a5
     5e4:	fe043783          	ld	a5,-32(s0)
     5e8:	0007c783          	lbu	a5,0(a5)
     5ec:	2781                	sext.w	a5,a5
     5ee:	40f707bb          	subw	a5,a4,a5
     5f2:	2781                	sext.w	a5,a5
     5f4:	a01d                	j	61a <memcmp+0x7e>
    }
    p1++;
     5f6:	fe843783          	ld	a5,-24(s0)
     5fa:	0785                	addi	a5,a5,1
     5fc:	fef43423          	sd	a5,-24(s0)
    p2++;
     600:	fe043783          	ld	a5,-32(s0)
     604:	0785                	addi	a5,a5,1
     606:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     60a:	fcc42783          	lw	a5,-52(s0)
     60e:	fff7871b          	addiw	a4,a5,-1
     612:	fce42623          	sw	a4,-52(s0)
     616:	f7dd                	bnez	a5,5c4 <memcmp+0x28>
  }
  return 0;
     618:	4781                	li	a5,0
}
     61a:	853e                	mv	a0,a5
     61c:	70e2                	ld	ra,56(sp)
     61e:	7442                	ld	s0,48(sp)
     620:	6121                	addi	sp,sp,64
     622:	8082                	ret

0000000000000624 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     624:	7179                	addi	sp,sp,-48
     626:	f406                	sd	ra,40(sp)
     628:	f022                	sd	s0,32(sp)
     62a:	1800                	addi	s0,sp,48
     62c:	fea43423          	sd	a0,-24(s0)
     630:	feb43023          	sd	a1,-32(s0)
     634:	87b2                	mv	a5,a2
     636:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     63a:	fdc42783          	lw	a5,-36(s0)
     63e:	863e                	mv	a2,a5
     640:	fe043583          	ld	a1,-32(s0)
     644:	fe843503          	ld	a0,-24(s0)
     648:	e8fff0ef          	jal	4d6 <memmove>
     64c:	87aa                	mv	a5,a0
}
     64e:	853e                	mv	a0,a5
     650:	70a2                	ld	ra,40(sp)
     652:	7402                	ld	s0,32(sp)
     654:	6145                	addi	sp,sp,48
     656:	8082                	ret

0000000000000658 <sbrk>:

char *
sbrk(int n) {
     658:	1101                	addi	sp,sp,-32
     65a:	ec06                	sd	ra,24(sp)
     65c:	e822                	sd	s0,16(sp)
     65e:	1000                	addi	s0,sp,32
     660:	87aa                	mv	a5,a0
     662:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     666:	fec42783          	lw	a5,-20(s0)
     66a:	4585                	li	a1,1
     66c:	853e                	mv	a0,a5
     66e:	0c6000ef          	jal	734 <sys_sbrk>
     672:	87aa                	mv	a5,a0
}
     674:	853e                	mv	a0,a5
     676:	60e2                	ld	ra,24(sp)
     678:	6442                	ld	s0,16(sp)
     67a:	6105                	addi	sp,sp,32
     67c:	8082                	ret

000000000000067e <sbrklazy>:

char *
sbrklazy(int n) {
     67e:	1101                	addi	sp,sp,-32
     680:	ec06                	sd	ra,24(sp)
     682:	e822                	sd	s0,16(sp)
     684:	1000                	addi	s0,sp,32
     686:	87aa                	mv	a5,a0
     688:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     68c:	fec42783          	lw	a5,-20(s0)
     690:	4589                	li	a1,2
     692:	853e                	mv	a0,a5
     694:	0a0000ef          	jal	734 <sys_sbrk>
     698:	87aa                	mv	a5,a0
}
     69a:	853e                	mv	a0,a5
     69c:	60e2                	ld	ra,24(sp)
     69e:	6442                	ld	s0,16(sp)
     6a0:	6105                	addi	sp,sp,32
     6a2:	8082                	ret

00000000000006a4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     6a4:	4885                	li	a7,1
 ecall
     6a6:	00000073          	ecall
 ret
     6aa:	8082                	ret

00000000000006ac <exit>:
.global exit
exit:
 li a7, SYS_exit
     6ac:	4889                	li	a7,2
 ecall
     6ae:	00000073          	ecall
 ret
     6b2:	8082                	ret

00000000000006b4 <wait>:
.global wait
wait:
 li a7, SYS_wait
     6b4:	488d                	li	a7,3
 ecall
     6b6:	00000073          	ecall
 ret
     6ba:	8082                	ret

00000000000006bc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6bc:	4891                	li	a7,4
 ecall
     6be:	00000073          	ecall
 ret
     6c2:	8082                	ret

00000000000006c4 <read>:
.global read
read:
 li a7, SYS_read
     6c4:	4895                	li	a7,5
 ecall
     6c6:	00000073          	ecall
 ret
     6ca:	8082                	ret

00000000000006cc <write>:
.global write
write:
 li a7, SYS_write
     6cc:	48c1                	li	a7,16
 ecall
     6ce:	00000073          	ecall
 ret
     6d2:	8082                	ret

00000000000006d4 <close>:
.global close
close:
 li a7, SYS_close
     6d4:	48d5                	li	a7,21
 ecall
     6d6:	00000073          	ecall
 ret
     6da:	8082                	ret

00000000000006dc <kill>:
.global kill
kill:
 li a7, SYS_kill
     6dc:	4899                	li	a7,6
 ecall
     6de:	00000073          	ecall
 ret
     6e2:	8082                	ret

00000000000006e4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     6e4:	489d                	li	a7,7
 ecall
     6e6:	00000073          	ecall
 ret
     6ea:	8082                	ret

00000000000006ec <open>:
.global open
open:
 li a7, SYS_open
     6ec:	48bd                	li	a7,15
 ecall
     6ee:	00000073          	ecall
 ret
     6f2:	8082                	ret

00000000000006f4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6f4:	48c5                	li	a7,17
 ecall
     6f6:	00000073          	ecall
 ret
     6fa:	8082                	ret

00000000000006fc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     6fc:	48c9                	li	a7,18
 ecall
     6fe:	00000073          	ecall
 ret
     702:	8082                	ret

0000000000000704 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     704:	48a1                	li	a7,8
 ecall
     706:	00000073          	ecall
 ret
     70a:	8082                	ret

000000000000070c <link>:
.global link
link:
 li a7, SYS_link
     70c:	48cd                	li	a7,19
 ecall
     70e:	00000073          	ecall
 ret
     712:	8082                	ret

0000000000000714 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     714:	48d1                	li	a7,20
 ecall
     716:	00000073          	ecall
 ret
     71a:	8082                	ret

000000000000071c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     71c:	48a5                	li	a7,9
 ecall
     71e:	00000073          	ecall
 ret
     722:	8082                	ret

0000000000000724 <dup>:
.global dup
dup:
 li a7, SYS_dup
     724:	48a9                	li	a7,10
 ecall
     726:	00000073          	ecall
 ret
     72a:	8082                	ret

000000000000072c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     72c:	48ad                	li	a7,11
 ecall
     72e:	00000073          	ecall
 ret
     732:	8082                	ret

0000000000000734 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     734:	48b1                	li	a7,12
 ecall
     736:	00000073          	ecall
 ret
     73a:	8082                	ret

000000000000073c <pause>:
.global pause
pause:
 li a7, SYS_pause
     73c:	48b5                	li	a7,13
 ecall
     73e:	00000073          	ecall
 ret
     742:	8082                	ret

0000000000000744 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     744:	48b9                	li	a7,14
 ecall
     746:	00000073          	ecall
 ret
     74a:	8082                	ret

000000000000074c <top>:
.global top
top:
 li a7, SYS_top
     74c:	48d9                	li	a7,22
 ecall
     74e:	00000073          	ecall
 ret
     752:	8082                	ret

0000000000000754 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     754:	48dd                	li	a7,23
 ecall
     756:	00000073          	ecall
 ret
     75a:	8082                	ret

000000000000075c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     75c:	1101                	addi	sp,sp,-32
     75e:	ec06                	sd	ra,24(sp)
     760:	e822                	sd	s0,16(sp)
     762:	1000                	addi	s0,sp,32
     764:	87aa                	mv	a5,a0
     766:	872e                	mv	a4,a1
     768:	fef42623          	sw	a5,-20(s0)
     76c:	87ba                	mv	a5,a4
     76e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     772:	feb40713          	addi	a4,s0,-21
     776:	fec42783          	lw	a5,-20(s0)
     77a:	4605                	li	a2,1
     77c:	85ba                	mv	a1,a4
     77e:	853e                	mv	a0,a5
     780:	f4dff0ef          	jal	6cc <write>
}
     784:	0001                	nop
     786:	60e2                	ld	ra,24(sp)
     788:	6442                	ld	s0,16(sp)
     78a:	6105                	addi	sp,sp,32
     78c:	8082                	ret

000000000000078e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     78e:	711d                	addi	sp,sp,-96
     790:	ec86                	sd	ra,88(sp)
     792:	e8a2                	sd	s0,80(sp)
     794:	1080                	addi	s0,sp,96
     796:	87aa                	mv	a5,a0
     798:	fab43823          	sd	a1,-80(s0)
     79c:	8736                	mv	a4,a3
     79e:	faf42e23          	sw	a5,-68(s0)
     7a2:	87b2                	mv	a5,a2
     7a4:	faf42c23          	sw	a5,-72(s0)
     7a8:	87ba                	mv	a5,a4
     7aa:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     7ae:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7b2:	fac42783          	lw	a5,-84(s0)
     7b6:	2781                	sext.w	a5,a5
     7b8:	cf99                	beqz	a5,7d6 <printint+0x48>
     7ba:	fb043783          	ld	a5,-80(s0)
     7be:	0007dc63          	bgez	a5,7d6 <printint+0x48>
    neg = 1;
     7c2:	4785                	li	a5,1
     7c4:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7c8:	fb043783          	ld	a5,-80(s0)
     7cc:	40f007b3          	neg	a5,a5
     7d0:	fef43023          	sd	a5,-32(s0)
     7d4:	a029                	j	7de <printint+0x50>
  } else {
    x = xx;
     7d6:	fb043783          	ld	a5,-80(s0)
     7da:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     7de:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7e2:	fb842783          	lw	a5,-72(s0)
     7e6:	fe043703          	ld	a4,-32(s0)
     7ea:	02f77733          	remu	a4,a4,a5
     7ee:	fec42783          	lw	a5,-20(s0)
     7f2:	0017869b          	addiw	a3,a5,1
     7f6:	fed42623          	sw	a3,-20(s0)
     7fa:	00002697          	auipc	a3,0x2
     7fe:	80668693          	addi	a3,a3,-2042 # 2000 <digits>
     802:	9736                	add	a4,a4,a3
     804:	00074703          	lbu	a4,0(a4)
     808:	17c1                	addi	a5,a5,-16
     80a:	97a2                	add	a5,a5,s0
     80c:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     810:	fb842783          	lw	a5,-72(s0)
     814:	fe043703          	ld	a4,-32(s0)
     818:	02f757b3          	divu	a5,a4,a5
     81c:	fef43023          	sd	a5,-32(s0)
     820:	fe043783          	ld	a5,-32(s0)
     824:	ffdd                	bnez	a5,7e2 <printint+0x54>
  if(neg)
     826:	fe842783          	lw	a5,-24(s0)
     82a:	2781                	sext.w	a5,a5
     82c:	cb95                	beqz	a5,860 <printint+0xd2>
    buf[i++] = '-';
     82e:	fec42783          	lw	a5,-20(s0)
     832:	0017871b          	addiw	a4,a5,1
     836:	fee42623          	sw	a4,-20(s0)
     83a:	17c1                	addi	a5,a5,-16
     83c:	97a2                	add	a5,a5,s0
     83e:	02d00713          	li	a4,45
     842:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     846:	a829                	j	860 <printint+0xd2>
    putc(fd, buf[i]);
     848:	fec42783          	lw	a5,-20(s0)
     84c:	17c1                	addi	a5,a5,-16
     84e:	97a2                	add	a5,a5,s0
     850:	fd87c703          	lbu	a4,-40(a5)
     854:	fbc42783          	lw	a5,-68(s0)
     858:	85ba                	mv	a1,a4
     85a:	853e                	mv	a0,a5
     85c:	f01ff0ef          	jal	75c <putc>
  while(--i >= 0)
     860:	fec42783          	lw	a5,-20(s0)
     864:	37fd                	addiw	a5,a5,-1
     866:	fef42623          	sw	a5,-20(s0)
     86a:	fec42783          	lw	a5,-20(s0)
     86e:	2781                	sext.w	a5,a5
     870:	fc07dce3          	bgez	a5,848 <printint+0xba>
}
     874:	0001                	nop
     876:	0001                	nop
     878:	60e6                	ld	ra,88(sp)
     87a:	6446                	ld	s0,80(sp)
     87c:	6125                	addi	sp,sp,96
     87e:	8082                	ret

0000000000000880 <printptr>:

static void
printptr(int fd, uint64 x) {
     880:	7179                	addi	sp,sp,-48
     882:	f406                	sd	ra,40(sp)
     884:	f022                	sd	s0,32(sp)
     886:	1800                	addi	s0,sp,48
     888:	87aa                	mv	a5,a0
     88a:	fcb43823          	sd	a1,-48(s0)
     88e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     892:	fdc42783          	lw	a5,-36(s0)
     896:	03000593          	li	a1,48
     89a:	853e                	mv	a0,a5
     89c:	ec1ff0ef          	jal	75c <putc>
  putc(fd, 'x');
     8a0:	fdc42783          	lw	a5,-36(s0)
     8a4:	07800593          	li	a1,120
     8a8:	853e                	mv	a0,a5
     8aa:	eb3ff0ef          	jal	75c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8ae:	fe042623          	sw	zero,-20(s0)
     8b2:	a81d                	j	8e8 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8b4:	fd043783          	ld	a5,-48(s0)
     8b8:	93f1                	srli	a5,a5,0x3c
     8ba:	00001717          	auipc	a4,0x1
     8be:	74670713          	addi	a4,a4,1862 # 2000 <digits>
     8c2:	97ba                	add	a5,a5,a4
     8c4:	0007c703          	lbu	a4,0(a5)
     8c8:	fdc42783          	lw	a5,-36(s0)
     8cc:	85ba                	mv	a1,a4
     8ce:	853e                	mv	a0,a5
     8d0:	e8dff0ef          	jal	75c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8d4:	fec42783          	lw	a5,-20(s0)
     8d8:	2785                	addiw	a5,a5,1
     8da:	fef42623          	sw	a5,-20(s0)
     8de:	fd043783          	ld	a5,-48(s0)
     8e2:	0792                	slli	a5,a5,0x4
     8e4:	fcf43823          	sd	a5,-48(s0)
     8e8:	fec42703          	lw	a4,-20(s0)
     8ec:	47bd                	li	a5,15
     8ee:	fce7f3e3          	bgeu	a5,a4,8b4 <printptr+0x34>
}
     8f2:	0001                	nop
     8f4:	0001                	nop
     8f6:	70a2                	ld	ra,40(sp)
     8f8:	7402                	ld	s0,32(sp)
     8fa:	6145                	addi	sp,sp,48
     8fc:	8082                	ret

00000000000008fe <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8fe:	715d                	addi	sp,sp,-80
     900:	e486                	sd	ra,72(sp)
     902:	e0a2                	sd	s0,64(sp)
     904:	0880                	addi	s0,sp,80
     906:	87aa                	mv	a5,a0
     908:	fcb43023          	sd	a1,-64(s0)
     90c:	fac43c23          	sd	a2,-72(s0)
     910:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     914:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     918:	fc042e23          	sw	zero,-36(s0)
     91c:	a189                	j	d5e <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     91e:	fdc42783          	lw	a5,-36(s0)
     922:	fc043703          	ld	a4,-64(s0)
     926:	97ba                	add	a5,a5,a4
     928:	0007c783          	lbu	a5,0(a5)
     92c:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     930:	fd842783          	lw	a5,-40(s0)
     934:	2781                	sext.w	a5,a5
     936:	eb8d                	bnez	a5,968 <vprintf+0x6a>
      if(c0 == '%'){
     938:	fd442783          	lw	a5,-44(s0)
     93c:	0007871b          	sext.w	a4,a5
     940:	02500793          	li	a5,37
     944:	00f71763          	bne	a4,a5,952 <vprintf+0x54>
        state = '%';
     948:	02500793          	li	a5,37
     94c:	fcf42c23          	sw	a5,-40(s0)
     950:	a111                	j	d54 <vprintf+0x456>
      } else {
        putc(fd, c0);
     952:	fd442783          	lw	a5,-44(s0)
     956:	0ff7f713          	zext.b	a4,a5
     95a:	fcc42783          	lw	a5,-52(s0)
     95e:	85ba                	mv	a1,a4
     960:	853e                	mv	a0,a5
     962:	dfbff0ef          	jal	75c <putc>
     966:	a6fd                	j	d54 <vprintf+0x456>
      }
    } else if(state == '%'){
     968:	fd842783          	lw	a5,-40(s0)
     96c:	0007871b          	sext.w	a4,a5
     970:	02500793          	li	a5,37
     974:	3ef71063          	bne	a4,a5,d54 <vprintf+0x456>
      c1 = c2 = 0;
     978:	fe042023          	sw	zero,-32(s0)
     97c:	fe042783          	lw	a5,-32(s0)
     980:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     984:	fd442783          	lw	a5,-44(s0)
     988:	2781                	sext.w	a5,a5
     98a:	cb99                	beqz	a5,9a0 <vprintf+0xa2>
     98c:	fdc42783          	lw	a5,-36(s0)
     990:	0785                	addi	a5,a5,1
     992:	fc043703          	ld	a4,-64(s0)
     996:	97ba                	add	a5,a5,a4
     998:	0007c783          	lbu	a5,0(a5)
     99c:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     9a0:	fe442783          	lw	a5,-28(s0)
     9a4:	2781                	sext.w	a5,a5
     9a6:	cb99                	beqz	a5,9bc <vprintf+0xbe>
     9a8:	fdc42783          	lw	a5,-36(s0)
     9ac:	0789                	addi	a5,a5,2
     9ae:	fc043703          	ld	a4,-64(s0)
     9b2:	97ba                	add	a5,a5,a4
     9b4:	0007c783          	lbu	a5,0(a5)
     9b8:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     9bc:	fd442783          	lw	a5,-44(s0)
     9c0:	0007871b          	sext.w	a4,a5
     9c4:	06400793          	li	a5,100
     9c8:	02f71363          	bne	a4,a5,9ee <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     9cc:	fb843783          	ld	a5,-72(s0)
     9d0:	00878713          	addi	a4,a5,8
     9d4:	fae43c23          	sd	a4,-72(s0)
     9d8:	439c                	lw	a5,0(a5)
     9da:	873e                	mv	a4,a5
     9dc:	fcc42783          	lw	a5,-52(s0)
     9e0:	4685                	li	a3,1
     9e2:	4629                	li	a2,10
     9e4:	85ba                	mv	a1,a4
     9e6:	853e                	mv	a0,a5
     9e8:	da7ff0ef          	jal	78e <printint>
     9ec:	a695                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     9ee:	fd442783          	lw	a5,-44(s0)
     9f2:	0007871b          	sext.w	a4,a5
     9f6:	06c00793          	li	a5,108
     9fa:	04f71063          	bne	a4,a5,a3a <vprintf+0x13c>
     9fe:	fe442783          	lw	a5,-28(s0)
     a02:	0007871b          	sext.w	a4,a5
     a06:	06400793          	li	a5,100
     a0a:	02f71863          	bne	a4,a5,a3a <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a0e:	fb843783          	ld	a5,-72(s0)
     a12:	00878713          	addi	a4,a5,8
     a16:	fae43c23          	sd	a4,-72(s0)
     a1a:	639c                	ld	a5,0(a5)
     a1c:	873e                	mv	a4,a5
     a1e:	fcc42783          	lw	a5,-52(s0)
     a22:	4685                	li	a3,1
     a24:	4629                	li	a2,10
     a26:	85ba                	mv	a1,a4
     a28:	853e                	mv	a0,a5
     a2a:	d65ff0ef          	jal	78e <printint>
        i += 1;
     a2e:	fdc42783          	lw	a5,-36(s0)
     a32:	2785                	addiw	a5,a5,1
     a34:	fcf42e23          	sw	a5,-36(s0)
     a38:	ae21                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     a3a:	fd442783          	lw	a5,-44(s0)
     a3e:	0007871b          	sext.w	a4,a5
     a42:	06c00793          	li	a5,108
     a46:	04f71863          	bne	a4,a5,a96 <vprintf+0x198>
     a4a:	fe442783          	lw	a5,-28(s0)
     a4e:	0007871b          	sext.w	a4,a5
     a52:	06c00793          	li	a5,108
     a56:	04f71063          	bne	a4,a5,a96 <vprintf+0x198>
     a5a:	fe042783          	lw	a5,-32(s0)
     a5e:	0007871b          	sext.w	a4,a5
     a62:	06400793          	li	a5,100
     a66:	02f71863          	bne	a4,a5,a96 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     a6a:	fb843783          	ld	a5,-72(s0)
     a6e:	00878713          	addi	a4,a5,8
     a72:	fae43c23          	sd	a4,-72(s0)
     a76:	639c                	ld	a5,0(a5)
     a78:	873e                	mv	a4,a5
     a7a:	fcc42783          	lw	a5,-52(s0)
     a7e:	4685                	li	a3,1
     a80:	4629                	li	a2,10
     a82:	85ba                	mv	a1,a4
     a84:	853e                	mv	a0,a5
     a86:	d09ff0ef          	jal	78e <printint>
        i += 2;
     a8a:	fdc42783          	lw	a5,-36(s0)
     a8e:	2789                	addiw	a5,a5,2
     a90:	fcf42e23          	sw	a5,-36(s0)
     a94:	ac75                	j	d50 <vprintf+0x452>
      } else if(c0 == 'u'){
     a96:	fd442783          	lw	a5,-44(s0)
     a9a:	0007871b          	sext.w	a4,a5
     a9e:	07500793          	li	a5,117
     aa2:	02f71563          	bne	a4,a5,acc <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     aa6:	fb843783          	ld	a5,-72(s0)
     aaa:	00878713          	addi	a4,a5,8
     aae:	fae43c23          	sd	a4,-72(s0)
     ab2:	439c                	lw	a5,0(a5)
     ab4:	02079713          	slli	a4,a5,0x20
     ab8:	9301                	srli	a4,a4,0x20
     aba:	fcc42783          	lw	a5,-52(s0)
     abe:	4681                	li	a3,0
     ac0:	4629                	li	a2,10
     ac2:	85ba                	mv	a1,a4
     ac4:	853e                	mv	a0,a5
     ac6:	cc9ff0ef          	jal	78e <printint>
     aca:	a459                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
     acc:	fd442783          	lw	a5,-44(s0)
     ad0:	0007871b          	sext.w	a4,a5
     ad4:	06c00793          	li	a5,108
     ad8:	04f71063          	bne	a4,a5,b18 <vprintf+0x21a>
     adc:	fe442783          	lw	a5,-28(s0)
     ae0:	0007871b          	sext.w	a4,a5
     ae4:	07500793          	li	a5,117
     ae8:	02f71863          	bne	a4,a5,b18 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     aec:	fb843783          	ld	a5,-72(s0)
     af0:	00878713          	addi	a4,a5,8
     af4:	fae43c23          	sd	a4,-72(s0)
     af8:	639c                	ld	a5,0(a5)
     afa:	873e                	mv	a4,a5
     afc:	fcc42783          	lw	a5,-52(s0)
     b00:	4681                	li	a3,0
     b02:	4629                	li	a2,10
     b04:	85ba                	mv	a1,a4
     b06:	853e                	mv	a0,a5
     b08:	c87ff0ef          	jal	78e <printint>
        i += 1;
     b0c:	fdc42783          	lw	a5,-36(s0)
     b10:	2785                	addiw	a5,a5,1
     b12:	fcf42e23          	sw	a5,-36(s0)
     b16:	ac2d                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     b18:	fd442783          	lw	a5,-44(s0)
     b1c:	0007871b          	sext.w	a4,a5
     b20:	06c00793          	li	a5,108
     b24:	04f71863          	bne	a4,a5,b74 <vprintf+0x276>
     b28:	fe442783          	lw	a5,-28(s0)
     b2c:	0007871b          	sext.w	a4,a5
     b30:	06c00793          	li	a5,108
     b34:	04f71063          	bne	a4,a5,b74 <vprintf+0x276>
     b38:	fe042783          	lw	a5,-32(s0)
     b3c:	0007871b          	sext.w	a4,a5
     b40:	07500793          	li	a5,117
     b44:	02f71863          	bne	a4,a5,b74 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b48:	fb843783          	ld	a5,-72(s0)
     b4c:	00878713          	addi	a4,a5,8
     b50:	fae43c23          	sd	a4,-72(s0)
     b54:	639c                	ld	a5,0(a5)
     b56:	873e                	mv	a4,a5
     b58:	fcc42783          	lw	a5,-52(s0)
     b5c:	4681                	li	a3,0
     b5e:	4629                	li	a2,10
     b60:	85ba                	mv	a1,a4
     b62:	853e                	mv	a0,a5
     b64:	c2bff0ef          	jal	78e <printint>
        i += 2;
     b68:	fdc42783          	lw	a5,-36(s0)
     b6c:	2789                	addiw	a5,a5,2
     b6e:	fcf42e23          	sw	a5,-36(s0)
     b72:	aaf9                	j	d50 <vprintf+0x452>
      } else if(c0 == 'x'){
     b74:	fd442783          	lw	a5,-44(s0)
     b78:	0007871b          	sext.w	a4,a5
     b7c:	07800793          	li	a5,120
     b80:	02f71563          	bne	a4,a5,baa <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
     b84:	fb843783          	ld	a5,-72(s0)
     b88:	00878713          	addi	a4,a5,8
     b8c:	fae43c23          	sd	a4,-72(s0)
     b90:	439c                	lw	a5,0(a5)
     b92:	02079713          	slli	a4,a5,0x20
     b96:	9301                	srli	a4,a4,0x20
     b98:	fcc42783          	lw	a5,-52(s0)
     b9c:	4681                	li	a3,0
     b9e:	4641                	li	a2,16
     ba0:	85ba                	mv	a1,a4
     ba2:	853e                	mv	a0,a5
     ba4:	bebff0ef          	jal	78e <printint>
     ba8:	a265                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
     baa:	fd442783          	lw	a5,-44(s0)
     bae:	0007871b          	sext.w	a4,a5
     bb2:	06c00793          	li	a5,108
     bb6:	04f71063          	bne	a4,a5,bf6 <vprintf+0x2f8>
     bba:	fe442783          	lw	a5,-28(s0)
     bbe:	0007871b          	sext.w	a4,a5
     bc2:	07800793          	li	a5,120
     bc6:	02f71863          	bne	a4,a5,bf6 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
     bca:	fb843783          	ld	a5,-72(s0)
     bce:	00878713          	addi	a4,a5,8
     bd2:	fae43c23          	sd	a4,-72(s0)
     bd6:	639c                	ld	a5,0(a5)
     bd8:	873e                	mv	a4,a5
     bda:	fcc42783          	lw	a5,-52(s0)
     bde:	4681                	li	a3,0
     be0:	4641                	li	a2,16
     be2:	85ba                	mv	a1,a4
     be4:	853e                	mv	a0,a5
     be6:	ba9ff0ef          	jal	78e <printint>
        i += 1;
     bea:	fdc42783          	lw	a5,-36(s0)
     bee:	2785                	addiw	a5,a5,1
     bf0:	fcf42e23          	sw	a5,-36(s0)
     bf4:	aab1                	j	d50 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     bf6:	fd442783          	lw	a5,-44(s0)
     bfa:	0007871b          	sext.w	a4,a5
     bfe:	06c00793          	li	a5,108
     c02:	04f71863          	bne	a4,a5,c52 <vprintf+0x354>
     c06:	fe442783          	lw	a5,-28(s0)
     c0a:	0007871b          	sext.w	a4,a5
     c0e:	06c00793          	li	a5,108
     c12:	04f71063          	bne	a4,a5,c52 <vprintf+0x354>
     c16:	fe042783          	lw	a5,-32(s0)
     c1a:	0007871b          	sext.w	a4,a5
     c1e:	07800793          	li	a5,120
     c22:	02f71863          	bne	a4,a5,c52 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
     c26:	fb843783          	ld	a5,-72(s0)
     c2a:	00878713          	addi	a4,a5,8
     c2e:	fae43c23          	sd	a4,-72(s0)
     c32:	639c                	ld	a5,0(a5)
     c34:	873e                	mv	a4,a5
     c36:	fcc42783          	lw	a5,-52(s0)
     c3a:	4681                	li	a3,0
     c3c:	4641                	li	a2,16
     c3e:	85ba                	mv	a1,a4
     c40:	853e                	mv	a0,a5
     c42:	b4dff0ef          	jal	78e <printint>
        i += 2;
     c46:	fdc42783          	lw	a5,-36(s0)
     c4a:	2789                	addiw	a5,a5,2
     c4c:	fcf42e23          	sw	a5,-36(s0)
     c50:	a201                	j	d50 <vprintf+0x452>
      } else if(c0 == 'p'){
     c52:	fd442783          	lw	a5,-44(s0)
     c56:	0007871b          	sext.w	a4,a5
     c5a:	07000793          	li	a5,112
     c5e:	02f71063          	bne	a4,a5,c7e <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
     c62:	fb843783          	ld	a5,-72(s0)
     c66:	00878713          	addi	a4,a5,8
     c6a:	fae43c23          	sd	a4,-72(s0)
     c6e:	6398                	ld	a4,0(a5)
     c70:	fcc42783          	lw	a5,-52(s0)
     c74:	85ba                	mv	a1,a4
     c76:	853e                	mv	a0,a5
     c78:	c09ff0ef          	jal	880 <printptr>
     c7c:	a8d1                	j	d50 <vprintf+0x452>
      } else if(c0 == 'c'){
     c7e:	fd442783          	lw	a5,-44(s0)
     c82:	0007871b          	sext.w	a4,a5
     c86:	06300793          	li	a5,99
     c8a:	02f71263          	bne	a4,a5,cae <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
     c8e:	fb843783          	ld	a5,-72(s0)
     c92:	00878713          	addi	a4,a5,8
     c96:	fae43c23          	sd	a4,-72(s0)
     c9a:	439c                	lw	a5,0(a5)
     c9c:	0ff7f713          	zext.b	a4,a5
     ca0:	fcc42783          	lw	a5,-52(s0)
     ca4:	85ba                	mv	a1,a4
     ca6:	853e                	mv	a0,a5
     ca8:	ab5ff0ef          	jal	75c <putc>
     cac:	a055                	j	d50 <vprintf+0x452>
      } else if(c0 == 's'){
     cae:	fd442783          	lw	a5,-44(s0)
     cb2:	0007871b          	sext.w	a4,a5
     cb6:	07300793          	li	a5,115
     cba:	04f71a63          	bne	a4,a5,d0e <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
     cbe:	fb843783          	ld	a5,-72(s0)
     cc2:	00878713          	addi	a4,a5,8
     cc6:	fae43c23          	sd	a4,-72(s0)
     cca:	639c                	ld	a5,0(a5)
     ccc:	fef43423          	sd	a5,-24(s0)
     cd0:	fe843783          	ld	a5,-24(s0)
     cd4:	e79d                	bnez	a5,d02 <vprintf+0x404>
          s = "(null)";
     cd6:	00000797          	auipc	a5,0x0
     cda:	58278793          	addi	a5,a5,1410 # 1258 <malloc+0x2a0>
     cde:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
     ce2:	a005                	j	d02 <vprintf+0x404>
          putc(fd, *s);
     ce4:	fe843783          	ld	a5,-24(s0)
     ce8:	0007c703          	lbu	a4,0(a5)
     cec:	fcc42783          	lw	a5,-52(s0)
     cf0:	85ba                	mv	a1,a4
     cf2:	853e                	mv	a0,a5
     cf4:	a69ff0ef          	jal	75c <putc>
        for(; *s; s++)
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	0785                	addi	a5,a5,1
     cfe:	fef43423          	sd	a5,-24(s0)
     d02:	fe843783          	ld	a5,-24(s0)
     d06:	0007c783          	lbu	a5,0(a5)
     d0a:	ffe9                	bnez	a5,ce4 <vprintf+0x3e6>
     d0c:	a091                	j	d50 <vprintf+0x452>
      } else if(c0 == '%'){
     d0e:	fd442783          	lw	a5,-44(s0)
     d12:	0007871b          	sext.w	a4,a5
     d16:	02500793          	li	a5,37
     d1a:	00f71a63          	bne	a4,a5,d2e <vprintf+0x430>
        putc(fd, '%');
     d1e:	fcc42783          	lw	a5,-52(s0)
     d22:	02500593          	li	a1,37
     d26:	853e                	mv	a0,a5
     d28:	a35ff0ef          	jal	75c <putc>
     d2c:	a015                	j	d50 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d2e:	fcc42783          	lw	a5,-52(s0)
     d32:	02500593          	li	a1,37
     d36:	853e                	mv	a0,a5
     d38:	a25ff0ef          	jal	75c <putc>
        putc(fd, c0);
     d3c:	fd442783          	lw	a5,-44(s0)
     d40:	0ff7f713          	zext.b	a4,a5
     d44:	fcc42783          	lw	a5,-52(s0)
     d48:	85ba                	mv	a1,a4
     d4a:	853e                	mv	a0,a5
     d4c:	a11ff0ef          	jal	75c <putc>
      }

      state = 0;
     d50:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     d54:	fdc42783          	lw	a5,-36(s0)
     d58:	2785                	addiw	a5,a5,1
     d5a:	fcf42e23          	sw	a5,-36(s0)
     d5e:	fdc42783          	lw	a5,-36(s0)
     d62:	fc043703          	ld	a4,-64(s0)
     d66:	97ba                	add	a5,a5,a4
     d68:	0007c783          	lbu	a5,0(a5)
     d6c:	ba0799e3          	bnez	a5,91e <vprintf+0x20>
    }
  }
}
     d70:	0001                	nop
     d72:	0001                	nop
     d74:	60a6                	ld	ra,72(sp)
     d76:	6406                	ld	s0,64(sp)
     d78:	6161                	addi	sp,sp,80
     d7a:	8082                	ret

0000000000000d7c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d7c:	7159                	addi	sp,sp,-112
     d7e:	fc06                	sd	ra,56(sp)
     d80:	f822                	sd	s0,48(sp)
     d82:	0080                	addi	s0,sp,64
     d84:	fcb43823          	sd	a1,-48(s0)
     d88:	e010                	sd	a2,0(s0)
     d8a:	e414                	sd	a3,8(s0)
     d8c:	e818                	sd	a4,16(s0)
     d8e:	ec1c                	sd	a5,24(s0)
     d90:	03043023          	sd	a6,32(s0)
     d94:	03143423          	sd	a7,40(s0)
     d98:	87aa                	mv	a5,a0
     d9a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d9e:	03040793          	addi	a5,s0,48
     da2:	fcf43423          	sd	a5,-56(s0)
     da6:	fc843783          	ld	a5,-56(s0)
     daa:	fd078793          	addi	a5,a5,-48
     dae:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     db2:	fe843703          	ld	a4,-24(s0)
     db6:	fdc42783          	lw	a5,-36(s0)
     dba:	863a                	mv	a2,a4
     dbc:	fd043583          	ld	a1,-48(s0)
     dc0:	853e                	mv	a0,a5
     dc2:	b3dff0ef          	jal	8fe <vprintf>
}
     dc6:	0001                	nop
     dc8:	70e2                	ld	ra,56(sp)
     dca:	7442                	ld	s0,48(sp)
     dcc:	6165                	addi	sp,sp,112
     dce:	8082                	ret

0000000000000dd0 <printf>:

void
printf(const char *fmt, ...)
{
     dd0:	7159                	addi	sp,sp,-112
     dd2:	f406                	sd	ra,40(sp)
     dd4:	f022                	sd	s0,32(sp)
     dd6:	1800                	addi	s0,sp,48
     dd8:	fca43c23          	sd	a0,-40(s0)
     ddc:	e40c                	sd	a1,8(s0)
     dde:	e810                	sd	a2,16(s0)
     de0:	ec14                	sd	a3,24(s0)
     de2:	f018                	sd	a4,32(s0)
     de4:	f41c                	sd	a5,40(s0)
     de6:	03043823          	sd	a6,48(s0)
     dea:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     dee:	04040793          	addi	a5,s0,64
     df2:	fcf43823          	sd	a5,-48(s0)
     df6:	fd043783          	ld	a5,-48(s0)
     dfa:	fc878793          	addi	a5,a5,-56
     dfe:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	863e                	mv	a2,a5
     e08:	fd843583          	ld	a1,-40(s0)
     e0c:	4505                	li	a0,1
     e0e:	af1ff0ef          	jal	8fe <vprintf>
}
     e12:	0001                	nop
     e14:	70a2                	ld	ra,40(sp)
     e16:	7402                	ld	s0,32(sp)
     e18:	6165                	addi	sp,sp,112
     e1a:	8082                	ret

0000000000000e1c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e1c:	7179                	addi	sp,sp,-48
     e1e:	f406                	sd	ra,40(sp)
     e20:	f022                	sd	s0,32(sp)
     e22:	1800                	addi	s0,sp,48
     e24:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e28:	fd843783          	ld	a5,-40(s0)
     e2c:	17c1                	addi	a5,a5,-16
     e2e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e32:	00001797          	auipc	a5,0x1
     e36:	1fe78793          	addi	a5,a5,510 # 2030 <freep>
     e3a:	639c                	ld	a5,0(a5)
     e3c:	fef43423          	sd	a5,-24(s0)
     e40:	a815                	j	e74 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	639c                	ld	a5,0(a5)
     e48:	fe843703          	ld	a4,-24(s0)
     e4c:	00f76f63          	bltu	a4,a5,e6a <free+0x4e>
     e50:	fe043703          	ld	a4,-32(s0)
     e54:	fe843783          	ld	a5,-24(s0)
     e58:	02e7eb63          	bltu	a5,a4,e8e <free+0x72>
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	639c                	ld	a5,0(a5)
     e62:	fe043703          	ld	a4,-32(s0)
     e66:	02f76463          	bltu	a4,a5,e8e <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e6a:	fe843783          	ld	a5,-24(s0)
     e6e:	639c                	ld	a5,0(a5)
     e70:	fef43423          	sd	a5,-24(s0)
     e74:	fe043703          	ld	a4,-32(s0)
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	fce7f3e3          	bgeu	a5,a4,e42 <free+0x26>
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	639c                	ld	a5,0(a5)
     e86:	fe043703          	ld	a4,-32(s0)
     e8a:	faf77ce3          	bgeu	a4,a5,e42 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	479c                	lw	a5,8(a5)
     e94:	1782                	slli	a5,a5,0x20
     e96:	9381                	srli	a5,a5,0x20
     e98:	0792                	slli	a5,a5,0x4
     e9a:	fe043703          	ld	a4,-32(s0)
     e9e:	973e                	add	a4,a4,a5
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	639c                	ld	a5,0(a5)
     ea6:	02f71763          	bne	a4,a5,ed4 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
     eaa:	fe043783          	ld	a5,-32(s0)
     eae:	4798                	lw	a4,8(a5)
     eb0:	fe843783          	ld	a5,-24(s0)
     eb4:	639c                	ld	a5,0(a5)
     eb6:	479c                	lw	a5,8(a5)
     eb8:	9fb9                	addw	a5,a5,a4
     eba:	0007871b          	sext.w	a4,a5
     ebe:	fe043783          	ld	a5,-32(s0)
     ec2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ec4:	fe843783          	ld	a5,-24(s0)
     ec8:	639c                	ld	a5,0(a5)
     eca:	6398                	ld	a4,0(a5)
     ecc:	fe043783          	ld	a5,-32(s0)
     ed0:	e398                	sd	a4,0(a5)
     ed2:	a039                	j	ee0 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
     ed4:	fe843783          	ld	a5,-24(s0)
     ed8:	6398                	ld	a4,0(a5)
     eda:	fe043783          	ld	a5,-32(s0)
     ede:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ee0:	fe843783          	ld	a5,-24(s0)
     ee4:	479c                	lw	a5,8(a5)
     ee6:	1782                	slli	a5,a5,0x20
     ee8:	9381                	srli	a5,a5,0x20
     eea:	0792                	slli	a5,a5,0x4
     eec:	fe843703          	ld	a4,-24(s0)
     ef0:	97ba                	add	a5,a5,a4
     ef2:	fe043703          	ld	a4,-32(s0)
     ef6:	02f71563          	bne	a4,a5,f20 <free+0x104>
    p->s.size += bp->s.size;
     efa:	fe843783          	ld	a5,-24(s0)
     efe:	4798                	lw	a4,8(a5)
     f00:	fe043783          	ld	a5,-32(s0)
     f04:	479c                	lw	a5,8(a5)
     f06:	9fb9                	addw	a5,a5,a4
     f08:	0007871b          	sext.w	a4,a5
     f0c:	fe843783          	ld	a5,-24(s0)
     f10:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f12:	fe043783          	ld	a5,-32(s0)
     f16:	6398                	ld	a4,0(a5)
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	e398                	sd	a4,0(a5)
     f1e:	a031                	j	f2a <free+0x10e>
  } else
    p->s.ptr = bp;
     f20:	fe843783          	ld	a5,-24(s0)
     f24:	fe043703          	ld	a4,-32(s0)
     f28:	e398                	sd	a4,0(a5)
  freep = p;
     f2a:	00001797          	auipc	a5,0x1
     f2e:	10678793          	addi	a5,a5,262 # 2030 <freep>
     f32:	fe843703          	ld	a4,-24(s0)
     f36:	e398                	sd	a4,0(a5)
}
     f38:	0001                	nop
     f3a:	70a2                	ld	ra,40(sp)
     f3c:	7402                	ld	s0,32(sp)
     f3e:	6145                	addi	sp,sp,48
     f40:	8082                	ret

0000000000000f42 <morecore>:

static Header*
morecore(uint nu)
{
     f42:	7179                	addi	sp,sp,-48
     f44:	f406                	sd	ra,40(sp)
     f46:	f022                	sd	s0,32(sp)
     f48:	1800                	addi	s0,sp,48
     f4a:	87aa                	mv	a5,a0
     f4c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f50:	fdc42783          	lw	a5,-36(s0)
     f54:	0007871b          	sext.w	a4,a5
     f58:	6785                	lui	a5,0x1
     f5a:	00f77563          	bgeu	a4,a5,f64 <morecore+0x22>
    nu = 4096;
     f5e:	6785                	lui	a5,0x1
     f60:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f64:	fdc42783          	lw	a5,-36(s0)
     f68:	0047979b          	slliw	a5,a5,0x4
     f6c:	2781                	sext.w	a5,a5
     f6e:	853e                	mv	a0,a5
     f70:	ee8ff0ef          	jal	658 <sbrk>
     f74:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
     f78:	fe843703          	ld	a4,-24(s0)
     f7c:	57fd                	li	a5,-1
     f7e:	00f71463          	bne	a4,a5,f86 <morecore+0x44>
    return 0;
     f82:	4781                	li	a5,0
     f84:	a02d                	j	fae <morecore+0x6c>
  hp = (Header*)p;
     f86:	fe843783          	ld	a5,-24(s0)
     f8a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f8e:	fe043783          	ld	a5,-32(s0)
     f92:	fdc42703          	lw	a4,-36(s0)
     f96:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f98:	fe043783          	ld	a5,-32(s0)
     f9c:	07c1                	addi	a5,a5,16 # 1010 <malloc+0x58>
     f9e:	853e                	mv	a0,a5
     fa0:	e7dff0ef          	jal	e1c <free>
  return freep;
     fa4:	00001797          	auipc	a5,0x1
     fa8:	08c78793          	addi	a5,a5,140 # 2030 <freep>
     fac:	639c                	ld	a5,0(a5)
}
     fae:	853e                	mv	a0,a5
     fb0:	70a2                	ld	ra,40(sp)
     fb2:	7402                	ld	s0,32(sp)
     fb4:	6145                	addi	sp,sp,48
     fb6:	8082                	ret

0000000000000fb8 <malloc>:

void*
malloc(uint nbytes)
{
     fb8:	7139                	addi	sp,sp,-64
     fba:	fc06                	sd	ra,56(sp)
     fbc:	f822                	sd	s0,48(sp)
     fbe:	0080                	addi	s0,sp,64
     fc0:	87aa                	mv	a5,a0
     fc2:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fc6:	fcc46783          	lwu	a5,-52(s0)
     fca:	07bd                	addi	a5,a5,15
     fcc:	8391                	srli	a5,a5,0x4
     fce:	2781                	sext.w	a5,a5
     fd0:	2785                	addiw	a5,a5,1
     fd2:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     fd6:	00001797          	auipc	a5,0x1
     fda:	05a78793          	addi	a5,a5,90 # 2030 <freep>
     fde:	639c                	ld	a5,0(a5)
     fe0:	fef43023          	sd	a5,-32(s0)
     fe4:	fe043783          	ld	a5,-32(s0)
     fe8:	ef95                	bnez	a5,1024 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     fea:	00001797          	auipc	a5,0x1
     fee:	03678793          	addi	a5,a5,54 # 2020 <base>
     ff2:	fef43023          	sd	a5,-32(s0)
     ff6:	00001797          	auipc	a5,0x1
     ffa:	03a78793          	addi	a5,a5,58 # 2030 <freep>
     ffe:	fe043703          	ld	a4,-32(s0)
    1002:	e398                	sd	a4,0(a5)
    1004:	00001797          	auipc	a5,0x1
    1008:	02c78793          	addi	a5,a5,44 # 2030 <freep>
    100c:	6398                	ld	a4,0(a5)
    100e:	00001797          	auipc	a5,0x1
    1012:	01278793          	addi	a5,a5,18 # 2020 <base>
    1016:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1018:	00001797          	auipc	a5,0x1
    101c:	00878793          	addi	a5,a5,8 # 2020 <base>
    1020:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1024:	fe043783          	ld	a5,-32(s0)
    1028:	639c                	ld	a5,0(a5)
    102a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    102e:	fe843783          	ld	a5,-24(s0)
    1032:	479c                	lw	a5,8(a5)
    1034:	fdc42703          	lw	a4,-36(s0)
    1038:	2701                	sext.w	a4,a4
    103a:	06e7e763          	bltu	a5,a4,10a8 <malloc+0xf0>
      if(p->s.size == nunits)
    103e:	fe843783          	ld	a5,-24(s0)
    1042:	479c                	lw	a5,8(a5)
    1044:	fdc42703          	lw	a4,-36(s0)
    1048:	2701                	sext.w	a4,a4
    104a:	00f71963          	bne	a4,a5,105c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    104e:	fe843783          	ld	a5,-24(s0)
    1052:	6398                	ld	a4,0(a5)
    1054:	fe043783          	ld	a5,-32(s0)
    1058:	e398                	sd	a4,0(a5)
    105a:	a825                	j	1092 <malloc+0xda>
      else {
        p->s.size -= nunits;
    105c:	fe843783          	ld	a5,-24(s0)
    1060:	479c                	lw	a5,8(a5)
    1062:	fdc42703          	lw	a4,-36(s0)
    1066:	9f99                	subw	a5,a5,a4
    1068:	0007871b          	sext.w	a4,a5
    106c:	fe843783          	ld	a5,-24(s0)
    1070:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1072:	fe843783          	ld	a5,-24(s0)
    1076:	479c                	lw	a5,8(a5)
    1078:	1782                	slli	a5,a5,0x20
    107a:	9381                	srli	a5,a5,0x20
    107c:	0792                	slli	a5,a5,0x4
    107e:	fe843703          	ld	a4,-24(s0)
    1082:	97ba                	add	a5,a5,a4
    1084:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1088:	fe843783          	ld	a5,-24(s0)
    108c:	fdc42703          	lw	a4,-36(s0)
    1090:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1092:	00001797          	auipc	a5,0x1
    1096:	f9e78793          	addi	a5,a5,-98 # 2030 <freep>
    109a:	fe043703          	ld	a4,-32(s0)
    109e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10a0:	fe843783          	ld	a5,-24(s0)
    10a4:	07c1                	addi	a5,a5,16
    10a6:	a081                	j	10e6 <malloc+0x12e>
    }
    if(p == freep)
    10a8:	00001797          	auipc	a5,0x1
    10ac:	f8878793          	addi	a5,a5,-120 # 2030 <freep>
    10b0:	639c                	ld	a5,0(a5)
    10b2:	fe843703          	ld	a4,-24(s0)
    10b6:	00f71e63          	bne	a4,a5,10d2 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    10ba:	fdc42783          	lw	a5,-36(s0)
    10be:	853e                	mv	a0,a5
    10c0:	e83ff0ef          	jal	f42 <morecore>
    10c4:	fea43423          	sd	a0,-24(s0)
    10c8:	fe843783          	ld	a5,-24(s0)
    10cc:	e399                	bnez	a5,10d2 <malloc+0x11a>
        return 0;
    10ce:	4781                	li	a5,0
    10d0:	a819                	j	10e6 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10d2:	fe843783          	ld	a5,-24(s0)
    10d6:	fef43023          	sd	a5,-32(s0)
    10da:	fe843783          	ld	a5,-24(s0)
    10de:	639c                	ld	a5,0(a5)
    10e0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10e4:	b7a9                	j	102e <malloc+0x76>
  }
}
    10e6:	853e                	mv	a0,a5
    10e8:	70e2                	ld	ra,56(sp)
    10ea:	7442                	ld	s0,48(sp)
    10ec:	6121                	addi	sp,sp,64
    10ee:	8082                	ret
