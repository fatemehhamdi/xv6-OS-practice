
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       c:	fc843783          	ld	a5,-56(s0)
      10:	6394                	ld	a3,0(a5)
      12:	0016d713          	srli	a4,a3,0x1
      16:	00002797          	auipc	a5,0x2
      1a:	eea78793          	addi	a5,a5,-278 # 1f00 <malloc+0x43e>
      1e:	639c                	ld	a5,0(a5)
      20:	02f737b3          	mulhu	a5,a4,a5
      24:	01d7d713          	srli	a4,a5,0x1d
      28:	87ba                	mv	a5,a4
      2a:	07fa                	slli	a5,a5,0x1e
      2c:	8f99                	sub	a5,a5,a4
      2e:	0786                	slli	a5,a5,0x1
      30:	40f68733          	sub	a4,a3,a5
      34:	00170793          	addi	a5,a4,1
      38:	fef43423          	sd	a5,-24(s0)
    hi = x / 127773;
      3c:	fe843783          	ld	a5,-24(s0)
      40:	00002717          	auipc	a4,0x2
      44:	ec870713          	addi	a4,a4,-312 # 1f08 <malloc+0x446>
      48:	6318                	ld	a4,0(a4)
      4a:	02e79733          	mulh	a4,a5,a4
      4e:	873d                	srai	a4,a4,0xf
      50:	97fd                	srai	a5,a5,0x3f
      52:	40f707b3          	sub	a5,a4,a5
      56:	fef43023          	sd	a5,-32(s0)
    lo = x % 127773;
      5a:	fe843783          	ld	a5,-24(s0)
      5e:	00002717          	auipc	a4,0x2
      62:	eaa70713          	addi	a4,a4,-342 # 1f08 <malloc+0x446>
      66:	6318                	ld	a4,0(a4)
      68:	02e79733          	mulh	a4,a5,a4
      6c:	40f75693          	srai	a3,a4,0xf
      70:	43f7d713          	srai	a4,a5,0x3f
      74:	8e99                	sub	a3,a3,a4
      76:	677d                	lui	a4,0x1f
      78:	31d70713          	addi	a4,a4,797 # 1f31d <freep+0x1cef5>
      7c:	02e68733          	mul	a4,a3,a4
      80:	8f99                	sub	a5,a5,a4
      82:	fcf43c23          	sd	a5,-40(s0)
    x = 16807 * lo - 2836 * hi;
      86:	fd843703          	ld	a4,-40(s0)
      8a:	6791                	lui	a5,0x4
      8c:	1a778793          	addi	a5,a5,423 # 41a7 <freep+0x1d7f>
      90:	02f70733          	mul	a4,a4,a5
      94:	fe043683          	ld	a3,-32(s0)
      98:	77fd                	lui	a5,0xfffff
      9a:	4ec78793          	addi	a5,a5,1260 # fffffffffffff4ec <freep+0xffffffffffffd0c4>
      9e:	02f687b3          	mul	a5,a3,a5
      a2:	97ba                	add	a5,a5,a4
      a4:	fef43423          	sd	a5,-24(s0)
    if (x < 0)
      a8:	fe843783          	ld	a5,-24(s0)
      ac:	0007db63          	bgez	a5,c2 <do_rand+0xc2>
        x += 0x7fffffff;
      b0:	fe843703          	ld	a4,-24(s0)
      b4:	800007b7          	lui	a5,0x80000
      b8:	fff7c793          	not	a5,a5
      bc:	97ba                	add	a5,a5,a4
      be:	fef43423          	sd	a5,-24(s0)
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      c2:	fe843783          	ld	a5,-24(s0)
      c6:	17fd                	addi	a5,a5,-1 # ffffffff7fffffff <freep+0xffffffff7fffdbd7>
      c8:	fef43423          	sd	a5,-24(s0)
    *ctx = x;
      cc:	fe843703          	ld	a4,-24(s0)
      d0:	fc843783          	ld	a5,-56(s0)
      d4:	e398                	sd	a4,0(a5)
    return (x);
      d6:	fe843783          	ld	a5,-24(s0)
      da:	2781                	sext.w	a5,a5
}
      dc:	853e                	mv	a0,a5
      de:	70e2                	ld	ra,56(sp)
      e0:	7442                	ld	s0,48(sp)
      e2:	6121                	addi	sp,sp,64
      e4:	8082                	ret

00000000000000e6 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      e6:	1141                	addi	sp,sp,-16
      e8:	e406                	sd	ra,8(sp)
      ea:	e022                	sd	s0,0(sp)
      ec:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      ee:	00002517          	auipc	a0,0x2
      f2:	f1250513          	addi	a0,a0,-238 # 2000 <rand_next>
      f6:	f0bff0ef          	jal	0 <do_rand>
      fa:	87aa                	mv	a5,a0
}
      fc:	853e                	mv	a0,a5
      fe:	60a2                	ld	ra,8(sp)
     100:	6402                	ld	s0,0(sp)
     102:	0141                	addi	sp,sp,16
     104:	8082                	ret

0000000000000106 <go>:

void
go(int which_child)
{
     106:	7155                	addi	sp,sp,-208
     108:	e586                	sd	ra,200(sp)
     10a:	e1a2                	sd	s0,192(sp)
     10c:	0980                	addi	s0,sp,208
     10e:	87aa                	mv	a5,a0
     110:	f2f42e23          	sw	a5,-196(s0)
  int fd = -1;
     114:	57fd                	li	a5,-1
     116:	fef42623          	sw	a5,-20(s0)
  static char buf[999];
  char *break0 = sbrk(0);
     11a:	4501                	li	a0,0
     11c:	046010ef          	jal	1162 <sbrk>
     120:	fca43c23          	sd	a0,-40(s0)
  uint64 iters = 0;
     124:	fe043023          	sd	zero,-32(s0)

  mkdir("grindir");
     128:	00002517          	auipc	a0,0x2
     12c:	ad850513          	addi	a0,a0,-1320 # 1c00 <malloc+0x13e>
     130:	0ee010ef          	jal	121e <mkdir>
  if(chdir("grindir") != 0){
     134:	00002517          	auipc	a0,0x2
     138:	acc50513          	addi	a0,a0,-1332 # 1c00 <malloc+0x13e>
     13c:	0ea010ef          	jal	1226 <chdir>
     140:	87aa                	mv	a5,a0
     142:	cb91                	beqz	a5,156 <go+0x50>
    printf("grind: chdir grindir failed\n");
     144:	00002517          	auipc	a0,0x2
     148:	ac450513          	addi	a0,a0,-1340 # 1c08 <malloc+0x146>
     14c:	78e010ef          	jal	18da <printf>
    exit(1);
     150:	4505                	li	a0,1
     152:	064010ef          	jal	11b6 <exit>
  }
  chdir("/");
     156:	00002517          	auipc	a0,0x2
     15a:	ad250513          	addi	a0,a0,-1326 # 1c28 <malloc+0x166>
     15e:	0c8010ef          	jal	1226 <chdir>
  
  while(1){
    iters++;
     162:	fe043783          	ld	a5,-32(s0)
     166:	0785                	addi	a5,a5,1
     168:	fef43023          	sd	a5,-32(s0)
    if((iters % 500) == 0)
     16c:	fe043703          	ld	a4,-32(s0)
     170:	00275693          	srli	a3,a4,0x2
     174:	00002797          	auipc	a5,0x2
     178:	d9c78793          	addi	a5,a5,-612 # 1f10 <malloc+0x44e>
     17c:	639c                	ld	a5,0(a5)
     17e:	02f6b7b3          	mulhu	a5,a3,a5
     182:	8391                	srli	a5,a5,0x4
     184:	1f400693          	li	a3,500
     188:	02d787b3          	mul	a5,a5,a3
     18c:	40f707b3          	sub	a5,a4,a5
     190:	e39d                	bnez	a5,1b6 <go+0xb0>
      write(1, which_child?"B":"A", 1);
     192:	f3c42783          	lw	a5,-196(s0)
     196:	2781                	sext.w	a5,a5
     198:	c791                	beqz	a5,1a4 <go+0x9e>
     19a:	00002797          	auipc	a5,0x2
     19e:	a9678793          	addi	a5,a5,-1386 # 1c30 <malloc+0x16e>
     1a2:	a029                	j	1ac <go+0xa6>
     1a4:	00002797          	auipc	a5,0x2
     1a8:	a9478793          	addi	a5,a5,-1388 # 1c38 <malloc+0x176>
     1ac:	4605                	li	a2,1
     1ae:	85be                	mv	a1,a5
     1b0:	4505                	li	a0,1
     1b2:	024010ef          	jal	11d6 <write>
    int what = rand() % 23;
     1b6:	f31ff0ef          	jal	e6 <rand>
     1ba:	87aa                	mv	a5,a0
     1bc:	0007869b          	sext.w	a3,a5
     1c0:	b2164737          	lui	a4,0xb2164
     1c4:	2c970713          	addi	a4,a4,713 # ffffffffb21642c9 <freep+0xffffffffb2161ea1>
     1c8:	02e68733          	mul	a4,a3,a4
     1cc:	9301                	srli	a4,a4,0x20
     1ce:	9f3d                	addw	a4,a4,a5
     1d0:	4047571b          	sraiw	a4,a4,0x4
     1d4:	86ba                	mv	a3,a4
     1d6:	41f7d71b          	sraiw	a4,a5,0x1f
     1da:	40e6873b          	subw	a4,a3,a4
     1de:	86ba                	mv	a3,a4
     1e0:	0016969b          	slliw	a3,a3,0x1
     1e4:	9eb9                	addw	a3,a3,a4
     1e6:	0036969b          	slliw	a3,a3,0x3
     1ea:	40e6873b          	subw	a4,a3,a4
     1ee:	9f99                	subw	a5,a5,a4
     1f0:	fcf42a23          	sw	a5,-44(s0)
    if(what == 1){
     1f4:	fd442783          	lw	a5,-44(s0)
     1f8:	0007871b          	sext.w	a4,a5
     1fc:	4785                	li	a5,1
     1fe:	00f71f63          	bne	a4,a5,21c <go+0x116>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     202:	20200593          	li	a1,514
     206:	00002517          	auipc	a0,0x2
     20a:	a3a50513          	addi	a0,a0,-1478 # 1c40 <malloc+0x17e>
     20e:	7e9000ef          	jal	11f6 <open>
     212:	87aa                	mv	a5,a0
     214:	853e                	mv	a0,a5
     216:	7c9000ef          	jal	11de <close>
     21a:	b7a1                	j	162 <go+0x5c>
    } else if(what == 2){
     21c:	fd442783          	lw	a5,-44(s0)
     220:	0007871b          	sext.w	a4,a5
     224:	4789                	li	a5,2
     226:	00f71f63          	bne	a4,a5,244 <go+0x13e>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     22a:	20200593          	li	a1,514
     22e:	00002517          	auipc	a0,0x2
     232:	a2250513          	addi	a0,a0,-1502 # 1c50 <malloc+0x18e>
     236:	7c1000ef          	jal	11f6 <open>
     23a:	87aa                	mv	a5,a0
     23c:	853e                	mv	a0,a5
     23e:	7a1000ef          	jal	11de <close>
     242:	b705                	j	162 <go+0x5c>
    } else if(what == 3){
     244:	fd442783          	lw	a5,-44(s0)
     248:	0007871b          	sext.w	a4,a5
     24c:	478d                	li	a5,3
     24e:	00f71963          	bne	a4,a5,260 <go+0x15a>
      unlink("grindir/../a");
     252:	00002517          	auipc	a0,0x2
     256:	9ee50513          	addi	a0,a0,-1554 # 1c40 <malloc+0x17e>
     25a:	7ad000ef          	jal	1206 <unlink>
     25e:	b711                	j	162 <go+0x5c>
    } else if(what == 4){
     260:	fd442783          	lw	a5,-44(s0)
     264:	0007871b          	sext.w	a4,a5
     268:	4791                	li	a5,4
     26a:	04f71063          	bne	a4,a5,2aa <go+0x1a4>
      if(chdir("grindir") != 0){
     26e:	00002517          	auipc	a0,0x2
     272:	99250513          	addi	a0,a0,-1646 # 1c00 <malloc+0x13e>
     276:	7b1000ef          	jal	1226 <chdir>
     27a:	87aa                	mv	a5,a0
     27c:	cb91                	beqz	a5,290 <go+0x18a>
        printf("grind: chdir grindir failed\n");
     27e:	00002517          	auipc	a0,0x2
     282:	98a50513          	addi	a0,a0,-1654 # 1c08 <malloc+0x146>
     286:	654010ef          	jal	18da <printf>
        exit(1);
     28a:	4505                	li	a0,1
     28c:	72b000ef          	jal	11b6 <exit>
      }
      unlink("../b");
     290:	00002517          	auipc	a0,0x2
     294:	9d850513          	addi	a0,a0,-1576 # 1c68 <malloc+0x1a6>
     298:	76f000ef          	jal	1206 <unlink>
      chdir("/");
     29c:	00002517          	auipc	a0,0x2
     2a0:	98c50513          	addi	a0,a0,-1652 # 1c28 <malloc+0x166>
     2a4:	783000ef          	jal	1226 <chdir>
     2a8:	bd6d                	j	162 <go+0x5c>
    } else if(what == 5){
     2aa:	fd442783          	lw	a5,-44(s0)
     2ae:	0007871b          	sext.w	a4,a5
     2b2:	4795                	li	a5,5
     2b4:	02f71363          	bne	a4,a5,2da <go+0x1d4>
      close(fd);
     2b8:	fec42783          	lw	a5,-20(s0)
     2bc:	853e                	mv	a0,a5
     2be:	721000ef          	jal	11de <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     2c2:	20200593          	li	a1,514
     2c6:	00002517          	auipc	a0,0x2
     2ca:	9aa50513          	addi	a0,a0,-1622 # 1c70 <malloc+0x1ae>
     2ce:	729000ef          	jal	11f6 <open>
     2d2:	87aa                	mv	a5,a0
     2d4:	fef42623          	sw	a5,-20(s0)
     2d8:	b569                	j	162 <go+0x5c>
    } else if(what == 6){
     2da:	fd442783          	lw	a5,-44(s0)
     2de:	0007871b          	sext.w	a4,a5
     2e2:	4799                	li	a5,6
     2e4:	02f71363          	bne	a4,a5,30a <go+0x204>
      close(fd);
     2e8:	fec42783          	lw	a5,-20(s0)
     2ec:	853e                	mv	a0,a5
     2ee:	6f1000ef          	jal	11de <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     2f2:	20200593          	li	a1,514
     2f6:	00002517          	auipc	a0,0x2
     2fa:	98a50513          	addi	a0,a0,-1654 # 1c80 <malloc+0x1be>
     2fe:	6f9000ef          	jal	11f6 <open>
     302:	87aa                	mv	a5,a0
     304:	fef42623          	sw	a5,-20(s0)
     308:	bda9                	j	162 <go+0x5c>
    } else if(what == 7){
     30a:	fd442783          	lw	a5,-44(s0)
     30e:	0007871b          	sext.w	a4,a5
     312:	479d                	li	a5,7
     314:	00f71e63          	bne	a4,a5,330 <go+0x22a>
      write(fd, buf, sizeof(buf));
     318:	fec42783          	lw	a5,-20(s0)
     31c:	3e700613          	li	a2,999
     320:	00002597          	auipc	a1,0x2
     324:	d1058593          	addi	a1,a1,-752 # 2030 <buf.0>
     328:	853e                	mv	a0,a5
     32a:	6ad000ef          	jal	11d6 <write>
     32e:	bd15                	j	162 <go+0x5c>
    } else if(what == 8){
     330:	fd442783          	lw	a5,-44(s0)
     334:	0007871b          	sext.w	a4,a5
     338:	47a1                	li	a5,8
     33a:	00f71e63          	bne	a4,a5,356 <go+0x250>
      read(fd, buf, sizeof(buf));
     33e:	fec42783          	lw	a5,-20(s0)
     342:	3e700613          	li	a2,999
     346:	00002597          	auipc	a1,0x2
     34a:	cea58593          	addi	a1,a1,-790 # 2030 <buf.0>
     34e:	853e                	mv	a0,a5
     350:	67f000ef          	jal	11ce <read>
     354:	b539                	j	162 <go+0x5c>
    } else if(what == 9){
     356:	fd442783          	lw	a5,-44(s0)
     35a:	0007871b          	sext.w	a4,a5
     35e:	47a5                	li	a5,9
     360:	02f71b63          	bne	a4,a5,396 <go+0x290>
      mkdir("grindir/../a");
     364:	00002517          	auipc	a0,0x2
     368:	8dc50513          	addi	a0,a0,-1828 # 1c40 <malloc+0x17e>
     36c:	6b3000ef          	jal	121e <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     370:	20200593          	li	a1,514
     374:	00002517          	auipc	a0,0x2
     378:	92450513          	addi	a0,a0,-1756 # 1c98 <malloc+0x1d6>
     37c:	67b000ef          	jal	11f6 <open>
     380:	87aa                	mv	a5,a0
     382:	853e                	mv	a0,a5
     384:	65b000ef          	jal	11de <close>
      unlink("a/a");
     388:	00002517          	auipc	a0,0x2
     38c:	92050513          	addi	a0,a0,-1760 # 1ca8 <malloc+0x1e6>
     390:	677000ef          	jal	1206 <unlink>
     394:	b3f9                	j	162 <go+0x5c>
    } else if(what == 10){
     396:	fd442783          	lw	a5,-44(s0)
     39a:	0007871b          	sext.w	a4,a5
     39e:	47a9                	li	a5,10
     3a0:	02f71b63          	bne	a4,a5,3d6 <go+0x2d0>
      mkdir("/../b");
     3a4:	00002517          	auipc	a0,0x2
     3a8:	90c50513          	addi	a0,a0,-1780 # 1cb0 <malloc+0x1ee>
     3ac:	673000ef          	jal	121e <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     3b0:	20200593          	li	a1,514
     3b4:	00002517          	auipc	a0,0x2
     3b8:	90450513          	addi	a0,a0,-1788 # 1cb8 <malloc+0x1f6>
     3bc:	63b000ef          	jal	11f6 <open>
     3c0:	87aa                	mv	a5,a0
     3c2:	853e                	mv	a0,a5
     3c4:	61b000ef          	jal	11de <close>
      unlink("b/b");
     3c8:	00002517          	auipc	a0,0x2
     3cc:	90050513          	addi	a0,a0,-1792 # 1cc8 <malloc+0x206>
     3d0:	637000ef          	jal	1206 <unlink>
     3d4:	b379                	j	162 <go+0x5c>
    } else if(what == 11){
     3d6:	fd442783          	lw	a5,-44(s0)
     3da:	0007871b          	sext.w	a4,a5
     3de:	47ad                	li	a5,11
     3e0:	02f71363          	bne	a4,a5,406 <go+0x300>
      unlink("b");
     3e4:	00002517          	auipc	a0,0x2
     3e8:	8ec50513          	addi	a0,a0,-1812 # 1cd0 <malloc+0x20e>
     3ec:	61b000ef          	jal	1206 <unlink>
      link("../grindir/./../a", "../b");
     3f0:	00002597          	auipc	a1,0x2
     3f4:	87858593          	addi	a1,a1,-1928 # 1c68 <malloc+0x1a6>
     3f8:	00002517          	auipc	a0,0x2
     3fc:	8e050513          	addi	a0,a0,-1824 # 1cd8 <malloc+0x216>
     400:	617000ef          	jal	1216 <link>
     404:	bbb9                	j	162 <go+0x5c>
    } else if(what == 12){
     406:	fd442783          	lw	a5,-44(s0)
     40a:	0007871b          	sext.w	a4,a5
     40e:	47b1                	li	a5,12
     410:	02f71363          	bne	a4,a5,436 <go+0x330>
      unlink("../grindir/../a");
     414:	00002517          	auipc	a0,0x2
     418:	8dc50513          	addi	a0,a0,-1828 # 1cf0 <malloc+0x22e>
     41c:	5eb000ef          	jal	1206 <unlink>
      link(".././b", "/grindir/../a");
     420:	00002597          	auipc	a1,0x2
     424:	85058593          	addi	a1,a1,-1968 # 1c70 <malloc+0x1ae>
     428:	00002517          	auipc	a0,0x2
     42c:	8d850513          	addi	a0,a0,-1832 # 1d00 <malloc+0x23e>
     430:	5e7000ef          	jal	1216 <link>
     434:	b33d                	j	162 <go+0x5c>
    } else if(what == 13){
     436:	fd442783          	lw	a5,-44(s0)
     43a:	0007871b          	sext.w	a4,a5
     43e:	47b5                	li	a5,13
     440:	04f71063          	bne	a4,a5,480 <go+0x37a>
      int pid = fork();
     444:	56b000ef          	jal	11ae <fork>
     448:	87aa                	mv	a5,a0
     44a:	faf42823          	sw	a5,-80(s0)
      if(pid == 0){
     44e:	fb042783          	lw	a5,-80(s0)
     452:	2781                	sext.w	a5,a5
     454:	e781                	bnez	a5,45c <go+0x356>
        exit(0);
     456:	4501                	li	a0,0
     458:	55f000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     45c:	fb042783          	lw	a5,-80(s0)
     460:	2781                	sext.w	a5,a5
     462:	0007db63          	bgez	a5,478 <go+0x372>
        printf("grind: fork failed\n");
     466:	00002517          	auipc	a0,0x2
     46a:	8a250513          	addi	a0,a0,-1886 # 1d08 <malloc+0x246>
     46e:	46c010ef          	jal	18da <printf>
        exit(1);
     472:	4505                	li	a0,1
     474:	543000ef          	jal	11b6 <exit>
      }
      wait(0);
     478:	4501                	li	a0,0
     47a:	545000ef          	jal	11be <wait>
     47e:	b1d5                	j	162 <go+0x5c>
    } else if(what == 14){
     480:	fd442783          	lw	a5,-44(s0)
     484:	0007871b          	sext.w	a4,a5
     488:	47b9                	li	a5,14
     48a:	04f71463          	bne	a4,a5,4d2 <go+0x3cc>
      int pid = fork();
     48e:	521000ef          	jal	11ae <fork>
     492:	87aa                	mv	a5,a0
     494:	faf42a23          	sw	a5,-76(s0)
      if(pid == 0){
     498:	fb442783          	lw	a5,-76(s0)
     49c:	2781                	sext.w	a5,a5
     49e:	eb81                	bnez	a5,4ae <go+0x3a8>
        fork();
     4a0:	50f000ef          	jal	11ae <fork>
        fork();
     4a4:	50b000ef          	jal	11ae <fork>
        exit(0);
     4a8:	4501                	li	a0,0
     4aa:	50d000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     4ae:	fb442783          	lw	a5,-76(s0)
     4b2:	2781                	sext.w	a5,a5
     4b4:	0007db63          	bgez	a5,4ca <go+0x3c4>
        printf("grind: fork failed\n");
     4b8:	00002517          	auipc	a0,0x2
     4bc:	85050513          	addi	a0,a0,-1968 # 1d08 <malloc+0x246>
     4c0:	41a010ef          	jal	18da <printf>
        exit(1);
     4c4:	4505                	li	a0,1
     4c6:	4f1000ef          	jal	11b6 <exit>
      }
      wait(0);
     4ca:	4501                	li	a0,0
     4cc:	4f3000ef          	jal	11be <wait>
     4d0:	b949                	j	162 <go+0x5c>
    } else if(what == 15){
     4d2:	fd442783          	lw	a5,-44(s0)
     4d6:	0007871b          	sext.w	a4,a5
     4da:	47bd                	li	a5,15
     4dc:	00f71863          	bne	a4,a5,4ec <go+0x3e6>
      sbrk(6011);
     4e0:	6785                	lui	a5,0x1
     4e2:	77b78513          	addi	a0,a5,1915 # 177b <vprintf+0x373>
     4e6:	47d000ef          	jal	1162 <sbrk>
     4ea:	b9a5                	j	162 <go+0x5c>
    } else if(what == 16){
     4ec:	fd442783          	lw	a5,-44(s0)
     4f0:	0007871b          	sext.w	a4,a5
     4f4:	47c1                	li	a5,16
     4f6:	02f71663          	bne	a4,a5,522 <go+0x41c>
      if(sbrk(0) > break0)
     4fa:	4501                	li	a0,0
     4fc:	467000ef          	jal	1162 <sbrk>
     500:	872a                	mv	a4,a0
     502:	fd843783          	ld	a5,-40(s0)
     506:	c4e7fee3          	bgeu	a5,a4,162 <go+0x5c>
        sbrk(-(sbrk(0) - break0));
     50a:	4501                	li	a0,0
     50c:	457000ef          	jal	1162 <sbrk>
     510:	872a                	mv	a4,a0
     512:	fd843783          	ld	a5,-40(s0)
     516:	8f99                	sub	a5,a5,a4
     518:	2781                	sext.w	a5,a5
     51a:	853e                	mv	a0,a5
     51c:	447000ef          	jal	1162 <sbrk>
     520:	b189                	j	162 <go+0x5c>
    } else if(what == 17){
     522:	fd442783          	lw	a5,-44(s0)
     526:	0007871b          	sext.w	a4,a5
     52a:	47c5                	li	a5,17
     52c:	08f71263          	bne	a4,a5,5b0 <go+0x4aa>
      int pid = fork();
     530:	47f000ef          	jal	11ae <fork>
     534:	87aa                	mv	a5,a0
     536:	faf42c23          	sw	a5,-72(s0)
      if(pid == 0){
     53a:	fb842783          	lw	a5,-72(s0)
     53e:	2781                	sext.w	a5,a5
     540:	e385                	bnez	a5,560 <go+0x45a>
        close(open("a", O_CREATE|O_RDWR));
     542:	20200593          	li	a1,514
     546:	00001517          	auipc	a0,0x1
     54a:	7da50513          	addi	a0,a0,2010 # 1d20 <malloc+0x25e>
     54e:	4a9000ef          	jal	11f6 <open>
     552:	87aa                	mv	a5,a0
     554:	853e                	mv	a0,a5
     556:	489000ef          	jal	11de <close>
        exit(0);
     55a:	4501                	li	a0,0
     55c:	45b000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     560:	fb842783          	lw	a5,-72(s0)
     564:	2781                	sext.w	a5,a5
     566:	0007db63          	bgez	a5,57c <go+0x476>
        printf("grind: fork failed\n");
     56a:	00001517          	auipc	a0,0x1
     56e:	79e50513          	addi	a0,a0,1950 # 1d08 <malloc+0x246>
     572:	368010ef          	jal	18da <printf>
        exit(1);
     576:	4505                	li	a0,1
     578:	43f000ef          	jal	11b6 <exit>
      }
      if(chdir("../grindir/..") != 0){
     57c:	00001517          	auipc	a0,0x1
     580:	7ac50513          	addi	a0,a0,1964 # 1d28 <malloc+0x266>
     584:	4a3000ef          	jal	1226 <chdir>
     588:	87aa                	mv	a5,a0
     58a:	cb91                	beqz	a5,59e <go+0x498>
        printf("grind: chdir failed\n");
     58c:	00001517          	auipc	a0,0x1
     590:	7ac50513          	addi	a0,a0,1964 # 1d38 <malloc+0x276>
     594:	346010ef          	jal	18da <printf>
        exit(1);
     598:	4505                	li	a0,1
     59a:	41d000ef          	jal	11b6 <exit>
      }
      kill(pid);
     59e:	fb842783          	lw	a5,-72(s0)
     5a2:	853e                	mv	a0,a5
     5a4:	443000ef          	jal	11e6 <kill>
      wait(0);
     5a8:	4501                	li	a0,0
     5aa:	415000ef          	jal	11be <wait>
     5ae:	be55                	j	162 <go+0x5c>
    } else if(what == 18){
     5b0:	fd442783          	lw	a5,-44(s0)
     5b4:	0007871b          	sext.w	a4,a5
     5b8:	47c9                	li	a5,18
     5ba:	04f71663          	bne	a4,a5,606 <go+0x500>
      int pid = fork();
     5be:	3f1000ef          	jal	11ae <fork>
     5c2:	87aa                	mv	a5,a0
     5c4:	faf42e23          	sw	a5,-68(s0)
      if(pid == 0){
     5c8:	fbc42783          	lw	a5,-68(s0)
     5cc:	2781                	sext.w	a5,a5
     5ce:	eb91                	bnez	a5,5e2 <go+0x4dc>
        kill(getpid());
     5d0:	467000ef          	jal	1236 <getpid>
     5d4:	87aa                	mv	a5,a0
     5d6:	853e                	mv	a0,a5
     5d8:	40f000ef          	jal	11e6 <kill>
        exit(0);
     5dc:	4501                	li	a0,0
     5de:	3d9000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     5e2:	fbc42783          	lw	a5,-68(s0)
     5e6:	2781                	sext.w	a5,a5
     5e8:	0007db63          	bgez	a5,5fe <go+0x4f8>
        printf("grind: fork failed\n");
     5ec:	00001517          	auipc	a0,0x1
     5f0:	71c50513          	addi	a0,a0,1820 # 1d08 <malloc+0x246>
     5f4:	2e6010ef          	jal	18da <printf>
        exit(1);
     5f8:	4505                	li	a0,1
     5fa:	3bd000ef          	jal	11b6 <exit>
      }
      wait(0);
     5fe:	4501                	li	a0,0
     600:	3bf000ef          	jal	11be <wait>
     604:	beb9                	j	162 <go+0x5c>
    } else if(what == 19){
     606:	fd442783          	lw	a5,-44(s0)
     60a:	0007871b          	sext.w	a4,a5
     60e:	47cd                	li	a5,19
     610:	0cf71863          	bne	a4,a5,6e0 <go+0x5da>
      int fds[2];
      if(pipe(fds) < 0){
     614:	fa840793          	addi	a5,s0,-88
     618:	853e                	mv	a0,a5
     61a:	3ad000ef          	jal	11c6 <pipe>
     61e:	87aa                	mv	a5,a0
     620:	0007db63          	bgez	a5,636 <go+0x530>
        printf("grind: pipe failed\n");
     624:	00001517          	auipc	a0,0x1
     628:	72c50513          	addi	a0,a0,1836 # 1d50 <malloc+0x28e>
     62c:	2ae010ef          	jal	18da <printf>
        exit(1);
     630:	4505                	li	a0,1
     632:	385000ef          	jal	11b6 <exit>
      }
      int pid = fork();
     636:	379000ef          	jal	11ae <fork>
     63a:	87aa                	mv	a5,a0
     63c:	fcf42023          	sw	a5,-64(s0)
      if(pid == 0){
     640:	fc042783          	lw	a5,-64(s0)
     644:	2781                	sext.w	a5,a5
     646:	e3ad                	bnez	a5,6a8 <go+0x5a2>
        fork();
     648:	367000ef          	jal	11ae <fork>
        fork();
     64c:	363000ef          	jal	11ae <fork>
        if(write(fds[1], "x", 1) != 1)
     650:	fac42783          	lw	a5,-84(s0)
     654:	4605                	li	a2,1
     656:	00001597          	auipc	a1,0x1
     65a:	71258593          	addi	a1,a1,1810 # 1d68 <malloc+0x2a6>
     65e:	853e                	mv	a0,a5
     660:	377000ef          	jal	11d6 <write>
     664:	87aa                	mv	a5,a0
     666:	873e                	mv	a4,a5
     668:	4785                	li	a5,1
     66a:	00f70863          	beq	a4,a5,67a <go+0x574>
          printf("grind: pipe write failed\n");
     66e:	00001517          	auipc	a0,0x1
     672:	70250513          	addi	a0,a0,1794 # 1d70 <malloc+0x2ae>
     676:	264010ef          	jal	18da <printf>
        char c;
        if(read(fds[0], &c, 1) != 1)
     67a:	fa842783          	lw	a5,-88(s0)
     67e:	fa740713          	addi	a4,s0,-89
     682:	4605                	li	a2,1
     684:	85ba                	mv	a1,a4
     686:	853e                	mv	a0,a5
     688:	347000ef          	jal	11ce <read>
     68c:	87aa                	mv	a5,a0
     68e:	873e                	mv	a4,a5
     690:	4785                	li	a5,1
     692:	00f70863          	beq	a4,a5,6a2 <go+0x59c>
          printf("grind: pipe read failed\n");
     696:	00001517          	auipc	a0,0x1
     69a:	6fa50513          	addi	a0,a0,1786 # 1d90 <malloc+0x2ce>
     69e:	23c010ef          	jal	18da <printf>
        exit(0);
     6a2:	4501                	li	a0,0
     6a4:	313000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     6a8:	fc042783          	lw	a5,-64(s0)
     6ac:	2781                	sext.w	a5,a5
     6ae:	0007db63          	bgez	a5,6c4 <go+0x5be>
        printf("grind: fork failed\n");
     6b2:	00001517          	auipc	a0,0x1
     6b6:	65650513          	addi	a0,a0,1622 # 1d08 <malloc+0x246>
     6ba:	220010ef          	jal	18da <printf>
        exit(1);
     6be:	4505                	li	a0,1
     6c0:	2f7000ef          	jal	11b6 <exit>
      }
      close(fds[0]);
     6c4:	fa842783          	lw	a5,-88(s0)
     6c8:	853e                	mv	a0,a5
     6ca:	315000ef          	jal	11de <close>
      close(fds[1]);
     6ce:	fac42783          	lw	a5,-84(s0)
     6d2:	853e                	mv	a0,a5
     6d4:	30b000ef          	jal	11de <close>
      wait(0);
     6d8:	4501                	li	a0,0
     6da:	2e5000ef          	jal	11be <wait>
     6de:	b451                	j	162 <go+0x5c>
    } else if(what == 20){
     6e0:	fd442783          	lw	a5,-44(s0)
     6e4:	0007871b          	sext.w	a4,a5
     6e8:	47d1                	li	a5,20
     6ea:	08f71963          	bne	a4,a5,77c <go+0x676>
      int pid = fork();
     6ee:	2c1000ef          	jal	11ae <fork>
     6f2:	87aa                	mv	a5,a0
     6f4:	fcf42223          	sw	a5,-60(s0)
      if(pid == 0){
     6f8:	fc442783          	lw	a5,-60(s0)
     6fc:	2781                	sext.w	a5,a5
     6fe:	efa9                	bnez	a5,758 <go+0x652>
        unlink("a");
     700:	00001517          	auipc	a0,0x1
     704:	62050513          	addi	a0,a0,1568 # 1d20 <malloc+0x25e>
     708:	2ff000ef          	jal	1206 <unlink>
        mkdir("a");
     70c:	00001517          	auipc	a0,0x1
     710:	61450513          	addi	a0,a0,1556 # 1d20 <malloc+0x25e>
     714:	30b000ef          	jal	121e <mkdir>
        chdir("a");
     718:	00001517          	auipc	a0,0x1
     71c:	60850513          	addi	a0,a0,1544 # 1d20 <malloc+0x25e>
     720:	307000ef          	jal	1226 <chdir>
        unlink("../a");
     724:	00001517          	auipc	a0,0x1
     728:	68c50513          	addi	a0,a0,1676 # 1db0 <malloc+0x2ee>
     72c:	2db000ef          	jal	1206 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     730:	20200593          	li	a1,514
     734:	00001517          	auipc	a0,0x1
     738:	63450513          	addi	a0,a0,1588 # 1d68 <malloc+0x2a6>
     73c:	2bb000ef          	jal	11f6 <open>
     740:	87aa                	mv	a5,a0
     742:	fef42623          	sw	a5,-20(s0)
        unlink("x");
     746:	00001517          	auipc	a0,0x1
     74a:	62250513          	addi	a0,a0,1570 # 1d68 <malloc+0x2a6>
     74e:	2b9000ef          	jal	1206 <unlink>
        exit(0);
     752:	4501                	li	a0,0
     754:	263000ef          	jal	11b6 <exit>
      } else if(pid < 0){
     758:	fc442783          	lw	a5,-60(s0)
     75c:	2781                	sext.w	a5,a5
     75e:	0007db63          	bgez	a5,774 <go+0x66e>
        printf("grind: fork failed\n");
     762:	00001517          	auipc	a0,0x1
     766:	5a650513          	addi	a0,a0,1446 # 1d08 <malloc+0x246>
     76a:	170010ef          	jal	18da <printf>
        exit(1);
     76e:	4505                	li	a0,1
     770:	247000ef          	jal	11b6 <exit>
      }
      wait(0);
     774:	4501                	li	a0,0
     776:	249000ef          	jal	11be <wait>
     77a:	b2e5                	j	162 <go+0x5c>
    } else if(what == 21){
     77c:	fd442783          	lw	a5,-44(s0)
     780:	0007871b          	sext.w	a4,a5
     784:	47d5                	li	a5,21
     786:	0ef71d63          	bne	a4,a5,880 <go+0x77a>
      unlink("c");
     78a:	00001517          	auipc	a0,0x1
     78e:	62e50513          	addi	a0,a0,1582 # 1db8 <malloc+0x2f6>
     792:	275000ef          	jal	1206 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     796:	20200593          	li	a1,514
     79a:	00001517          	auipc	a0,0x1
     79e:	61e50513          	addi	a0,a0,1566 # 1db8 <malloc+0x2f6>
     7a2:	255000ef          	jal	11f6 <open>
     7a6:	87aa                	mv	a5,a0
     7a8:	fcf42423          	sw	a5,-56(s0)
      if(fd1 < 0){
     7ac:	fc842783          	lw	a5,-56(s0)
     7b0:	2781                	sext.w	a5,a5
     7b2:	0007db63          	bgez	a5,7c8 <go+0x6c2>
        printf("grind: create c failed\n");
     7b6:	00001517          	auipc	a0,0x1
     7ba:	60a50513          	addi	a0,a0,1546 # 1dc0 <malloc+0x2fe>
     7be:	11c010ef          	jal	18da <printf>
        exit(1);
     7c2:	4505                	li	a0,1
     7c4:	1f3000ef          	jal	11b6 <exit>
      }
      if(write(fd1, "x", 1) != 1){
     7c8:	fc842783          	lw	a5,-56(s0)
     7cc:	4605                	li	a2,1
     7ce:	00001597          	auipc	a1,0x1
     7d2:	59a58593          	addi	a1,a1,1434 # 1d68 <malloc+0x2a6>
     7d6:	853e                	mv	a0,a5
     7d8:	1ff000ef          	jal	11d6 <write>
     7dc:	87aa                	mv	a5,a0
     7de:	873e                	mv	a4,a5
     7e0:	4785                	li	a5,1
     7e2:	00f70b63          	beq	a4,a5,7f8 <go+0x6f2>
        printf("grind: write c failed\n");
     7e6:	00001517          	auipc	a0,0x1
     7ea:	5f250513          	addi	a0,a0,1522 # 1dd8 <malloc+0x316>
     7ee:	0ec010ef          	jal	18da <printf>
        exit(1);
     7f2:	4505                	li	a0,1
     7f4:	1c3000ef          	jal	11b6 <exit>
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     7f8:	f8840713          	addi	a4,s0,-120
     7fc:	fc842783          	lw	a5,-56(s0)
     800:	85ba                	mv	a1,a4
     802:	853e                	mv	a0,a5
     804:	20b000ef          	jal	120e <fstat>
     808:	87aa                	mv	a5,a0
     80a:	cb91                	beqz	a5,81e <go+0x718>
        printf("grind: fstat failed\n");
     80c:	00001517          	auipc	a0,0x1
     810:	5e450513          	addi	a0,a0,1508 # 1df0 <malloc+0x32e>
     814:	0c6010ef          	jal	18da <printf>
        exit(1);
     818:	4505                	li	a0,1
     81a:	19d000ef          	jal	11b6 <exit>
      }
      if(st.size != 1){
     81e:	f9843703          	ld	a4,-104(s0)
     822:	4785                	li	a5,1
     824:	00f70f63          	beq	a4,a5,842 <go+0x73c>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     828:	f9843783          	ld	a5,-104(s0)
     82c:	2781                	sext.w	a5,a5
     82e:	85be                	mv	a1,a5
     830:	00001517          	auipc	a0,0x1
     834:	5d850513          	addi	a0,a0,1496 # 1e08 <malloc+0x346>
     838:	0a2010ef          	jal	18da <printf>
        exit(1);
     83c:	4505                	li	a0,1
     83e:	179000ef          	jal	11b6 <exit>
      }
      if(st.ino > 200){
     842:	f8c42703          	lw	a4,-116(s0)
     846:	0c800793          	li	a5,200
     84a:	00e7fe63          	bgeu	a5,a4,866 <go+0x760>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     84e:	f8c42783          	lw	a5,-116(s0)
     852:	85be                	mv	a1,a5
     854:	00001517          	auipc	a0,0x1
     858:	5dc50513          	addi	a0,a0,1500 # 1e30 <malloc+0x36e>
     85c:	07e010ef          	jal	18da <printf>
        exit(1);
     860:	4505                	li	a0,1
     862:	155000ef          	jal	11b6 <exit>
      }
      close(fd1);
     866:	fc842783          	lw	a5,-56(s0)
     86a:	853e                	mv	a0,a5
     86c:	173000ef          	jal	11de <close>
      unlink("c");
     870:	00001517          	auipc	a0,0x1
     874:	54850513          	addi	a0,a0,1352 # 1db8 <malloc+0x2f6>
     878:	18f000ef          	jal	1206 <unlink>
     87c:	8e7ff06f          	j	162 <go+0x5c>
    } else if(what == 22){
     880:	fd442783          	lw	a5,-44(s0)
     884:	0007871b          	sext.w	a4,a5
     888:	47d9                	li	a5,22
     88a:	8cf71ce3          	bne	a4,a5,162 <go+0x5c>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     88e:	f8040793          	addi	a5,s0,-128
     892:	853e                	mv	a0,a5
     894:	133000ef          	jal	11c6 <pipe>
     898:	87aa                	mv	a5,a0
     89a:	0007dc63          	bgez	a5,8b2 <go+0x7ac>
        fprintf(2, "grind: pipe failed\n");
     89e:	00001597          	auipc	a1,0x1
     8a2:	4b258593          	addi	a1,a1,1202 # 1d50 <malloc+0x28e>
     8a6:	4509                	li	a0,2
     8a8:	7df000ef          	jal	1886 <fprintf>
        exit(1);
     8ac:	4505                	li	a0,1
     8ae:	109000ef          	jal	11b6 <exit>
      }
      if(pipe(bb) < 0){
     8b2:	f7840793          	addi	a5,s0,-136
     8b6:	853e                	mv	a0,a5
     8b8:	10f000ef          	jal	11c6 <pipe>
     8bc:	87aa                	mv	a5,a0
     8be:	0007dc63          	bgez	a5,8d6 <go+0x7d0>
        fprintf(2, "grind: pipe failed\n");
     8c2:	00001597          	auipc	a1,0x1
     8c6:	48e58593          	addi	a1,a1,1166 # 1d50 <malloc+0x28e>
     8ca:	4509                	li	a0,2
     8cc:	7bb000ef          	jal	1886 <fprintf>
        exit(1);
     8d0:	4505                	li	a0,1
     8d2:	0e5000ef          	jal	11b6 <exit>
      }
      int pid1 = fork();
     8d6:	0d9000ef          	jal	11ae <fork>
     8da:	87aa                	mv	a5,a0
     8dc:	fcf42823          	sw	a5,-48(s0)
      if(pid1 == 0){
     8e0:	fd042783          	lw	a5,-48(s0)
     8e4:	2781                	sext.w	a5,a5
     8e6:	efc9                	bnez	a5,980 <go+0x87a>
        close(bb[0]);
     8e8:	f7842783          	lw	a5,-136(s0)
     8ec:	853e                	mv	a0,a5
     8ee:	0f1000ef          	jal	11de <close>
        close(bb[1]);
     8f2:	f7c42783          	lw	a5,-132(s0)
     8f6:	853e                	mv	a0,a5
     8f8:	0e7000ef          	jal	11de <close>
        close(aa[0]);
     8fc:	f8042783          	lw	a5,-128(s0)
     900:	853e                	mv	a0,a5
     902:	0dd000ef          	jal	11de <close>
        close(1);
     906:	4505                	li	a0,1
     908:	0d7000ef          	jal	11de <close>
        if(dup(aa[1]) != 1){
     90c:	f8442783          	lw	a5,-124(s0)
     910:	853e                	mv	a0,a5
     912:	11d000ef          	jal	122e <dup>
     916:	87aa                	mv	a5,a0
     918:	873e                	mv	a4,a5
     91a:	4785                	li	a5,1
     91c:	00f70c63          	beq	a4,a5,934 <go+0x82e>
          fprintf(2, "grind: dup failed\n");
     920:	00001597          	auipc	a1,0x1
     924:	53858593          	addi	a1,a1,1336 # 1e58 <malloc+0x396>
     928:	4509                	li	a0,2
     92a:	75d000ef          	jal	1886 <fprintf>
          exit(1);
     92e:	4505                	li	a0,1
     930:	087000ef          	jal	11b6 <exit>
        }
        close(aa[1]);
     934:	f8442783          	lw	a5,-124(s0)
     938:	853e                	mv	a0,a5
     93a:	0a5000ef          	jal	11de <close>
        char *args[3] = { "echo", "hi", 0 };
     93e:	00001797          	auipc	a5,0x1
     942:	53278793          	addi	a5,a5,1330 # 1e70 <malloc+0x3ae>
     946:	f4f43823          	sd	a5,-176(s0)
     94a:	00001797          	auipc	a5,0x1
     94e:	52e78793          	addi	a5,a5,1326 # 1e78 <malloc+0x3b6>
     952:	f4f43c23          	sd	a5,-168(s0)
     956:	f6043023          	sd	zero,-160(s0)
        exec("grindir/../echo", args);
     95a:	f5040793          	addi	a5,s0,-176
     95e:	85be                	mv	a1,a5
     960:	00001517          	auipc	a0,0x1
     964:	52050513          	addi	a0,a0,1312 # 1e80 <malloc+0x3be>
     968:	087000ef          	jal	11ee <exec>
        fprintf(2, "grind: echo: not found\n");
     96c:	00001597          	auipc	a1,0x1
     970:	52458593          	addi	a1,a1,1316 # 1e90 <malloc+0x3ce>
     974:	4509                	li	a0,2
     976:	711000ef          	jal	1886 <fprintf>
        exit(2);
     97a:	4509                	li	a0,2
     97c:	03b000ef          	jal	11b6 <exit>
      } else if(pid1 < 0){
     980:	fd042783          	lw	a5,-48(s0)
     984:	2781                	sext.w	a5,a5
     986:	0007dc63          	bgez	a5,99e <go+0x898>
        fprintf(2, "grind: fork failed\n");
     98a:	00001597          	auipc	a1,0x1
     98e:	37e58593          	addi	a1,a1,894 # 1d08 <malloc+0x246>
     992:	4509                	li	a0,2
     994:	6f3000ef          	jal	1886 <fprintf>
        exit(3);
     998:	450d                	li	a0,3
     99a:	01d000ef          	jal	11b6 <exit>
      }
      int pid2 = fork();
     99e:	011000ef          	jal	11ae <fork>
     9a2:	87aa                	mv	a5,a0
     9a4:	fcf42623          	sw	a5,-52(s0)
      if(pid2 == 0){
     9a8:	fcc42783          	lw	a5,-52(s0)
     9ac:	2781                	sext.w	a5,a5
     9ae:	ebdd                	bnez	a5,a64 <go+0x95e>
        close(aa[1]);
     9b0:	f8442783          	lw	a5,-124(s0)
     9b4:	853e                	mv	a0,a5
     9b6:	029000ef          	jal	11de <close>
        close(bb[0]);
     9ba:	f7842783          	lw	a5,-136(s0)
     9be:	853e                	mv	a0,a5
     9c0:	01f000ef          	jal	11de <close>
        close(0);
     9c4:	4501                	li	a0,0
     9c6:	019000ef          	jal	11de <close>
        if(dup(aa[0]) != 0){
     9ca:	f8042783          	lw	a5,-128(s0)
     9ce:	853e                	mv	a0,a5
     9d0:	05f000ef          	jal	122e <dup>
     9d4:	87aa                	mv	a5,a0
     9d6:	cb99                	beqz	a5,9ec <go+0x8e6>
          fprintf(2, "grind: dup failed\n");
     9d8:	00001597          	auipc	a1,0x1
     9dc:	48058593          	addi	a1,a1,1152 # 1e58 <malloc+0x396>
     9e0:	4509                	li	a0,2
     9e2:	6a5000ef          	jal	1886 <fprintf>
          exit(4);
     9e6:	4511                	li	a0,4
     9e8:	7ce000ef          	jal	11b6 <exit>
        }
        close(aa[0]);
     9ec:	f8042783          	lw	a5,-128(s0)
     9f0:	853e                	mv	a0,a5
     9f2:	7ec000ef          	jal	11de <close>
        close(1);
     9f6:	4505                	li	a0,1
     9f8:	7e6000ef          	jal	11de <close>
        if(dup(bb[1]) != 1){
     9fc:	f7c42783          	lw	a5,-132(s0)
     a00:	853e                	mv	a0,a5
     a02:	02d000ef          	jal	122e <dup>
     a06:	87aa                	mv	a5,a0
     a08:	873e                	mv	a4,a5
     a0a:	4785                	li	a5,1
     a0c:	00f70c63          	beq	a4,a5,a24 <go+0x91e>
          fprintf(2, "grind: dup failed\n");
     a10:	00001597          	auipc	a1,0x1
     a14:	44858593          	addi	a1,a1,1096 # 1e58 <malloc+0x396>
     a18:	4509                	li	a0,2
     a1a:	66d000ef          	jal	1886 <fprintf>
          exit(5);
     a1e:	4515                	li	a0,5
     a20:	796000ef          	jal	11b6 <exit>
        }
        close(bb[1]);
     a24:	f7c42783          	lw	a5,-132(s0)
     a28:	853e                	mv	a0,a5
     a2a:	7b4000ef          	jal	11de <close>
        char *args[2] = { "cat", 0 };
     a2e:	00001797          	auipc	a5,0x1
     a32:	47a78793          	addi	a5,a5,1146 # 1ea8 <malloc+0x3e6>
     a36:	f4f43023          	sd	a5,-192(s0)
     a3a:	f4043423          	sd	zero,-184(s0)
        exec("/cat", args);
     a3e:	f4040793          	addi	a5,s0,-192
     a42:	85be                	mv	a1,a5
     a44:	00001517          	auipc	a0,0x1
     a48:	46c50513          	addi	a0,a0,1132 # 1eb0 <malloc+0x3ee>
     a4c:	7a2000ef          	jal	11ee <exec>
        fprintf(2, "grind: cat: not found\n");
     a50:	00001597          	auipc	a1,0x1
     a54:	46858593          	addi	a1,a1,1128 # 1eb8 <malloc+0x3f6>
     a58:	4509                	li	a0,2
     a5a:	62d000ef          	jal	1886 <fprintf>
        exit(6);
     a5e:	4519                	li	a0,6
     a60:	756000ef          	jal	11b6 <exit>
      } else if(pid2 < 0){
     a64:	fcc42783          	lw	a5,-52(s0)
     a68:	2781                	sext.w	a5,a5
     a6a:	0007dc63          	bgez	a5,a82 <go+0x97c>
        fprintf(2, "grind: fork failed\n");
     a6e:	00001597          	auipc	a1,0x1
     a72:	29a58593          	addi	a1,a1,666 # 1d08 <malloc+0x246>
     a76:	4509                	li	a0,2
     a78:	60f000ef          	jal	1886 <fprintf>
        exit(7);
     a7c:	451d                	li	a0,7
     a7e:	738000ef          	jal	11b6 <exit>
      }
      close(aa[0]);
     a82:	f8042783          	lw	a5,-128(s0)
     a86:	853e                	mv	a0,a5
     a88:	756000ef          	jal	11de <close>
      close(aa[1]);
     a8c:	f8442783          	lw	a5,-124(s0)
     a90:	853e                	mv	a0,a5
     a92:	74c000ef          	jal	11de <close>
      close(bb[1]);
     a96:	f7c42783          	lw	a5,-132(s0)
     a9a:	853e                	mv	a0,a5
     a9c:	742000ef          	jal	11de <close>
      char buf[4] = { 0, 0, 0, 0 };
     aa0:	f6042823          	sw	zero,-144(s0)
      read(bb[0], buf+0, 1);
     aa4:	f7842783          	lw	a5,-136(s0)
     aa8:	f7040713          	addi	a4,s0,-144
     aac:	4605                	li	a2,1
     aae:	85ba                	mv	a1,a4
     ab0:	853e                	mv	a0,a5
     ab2:	71c000ef          	jal	11ce <read>
      read(bb[0], buf+1, 1);
     ab6:	f7842703          	lw	a4,-136(s0)
     aba:	f7040793          	addi	a5,s0,-144
     abe:	0785                	addi	a5,a5,1
     ac0:	4605                	li	a2,1
     ac2:	85be                	mv	a1,a5
     ac4:	853a                	mv	a0,a4
     ac6:	708000ef          	jal	11ce <read>
      read(bb[0], buf+2, 1);
     aca:	f7842703          	lw	a4,-136(s0)
     ace:	f7040793          	addi	a5,s0,-144
     ad2:	0789                	addi	a5,a5,2
     ad4:	4605                	li	a2,1
     ad6:	85be                	mv	a1,a5
     ad8:	853a                	mv	a0,a4
     ada:	6f4000ef          	jal	11ce <read>
      close(bb[0]);
     ade:	f7842783          	lw	a5,-136(s0)
     ae2:	853e                	mv	a0,a5
     ae4:	6fa000ef          	jal	11de <close>
      int st1, st2;
      wait(&st1);
     ae8:	f6c40793          	addi	a5,s0,-148
     aec:	853e                	mv	a0,a5
     aee:	6d0000ef          	jal	11be <wait>
      wait(&st2);
     af2:	f6840793          	addi	a5,s0,-152
     af6:	853e                	mv	a0,a5
     af8:	6c6000ef          	jal	11be <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     afc:	f6c42783          	lw	a5,-148(s0)
     b00:	e385                	bnez	a5,b20 <go+0xa1a>
     b02:	f6842783          	lw	a5,-152(s0)
     b06:	ef89                	bnez	a5,b20 <go+0xa1a>
     b08:	f7040793          	addi	a5,s0,-144
     b0c:	00001597          	auipc	a1,0x1
     b10:	3c458593          	addi	a1,a1,964 # 1ed0 <malloc+0x40e>
     b14:	853e                	mv	a0,a5
     b16:	206000ef          	jal	d1c <strcmp>
     b1a:	87aa                	mv	a5,a0
     b1c:	e4078363          	beqz	a5,162 <go+0x5c>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     b20:	f6c42783          	lw	a5,-148(s0)
     b24:	f6842703          	lw	a4,-152(s0)
     b28:	f7040693          	addi	a3,s0,-144
     b2c:	863a                	mv	a2,a4
     b2e:	85be                	mv	a1,a5
     b30:	00001517          	auipc	a0,0x1
     b34:	3a850513          	addi	a0,a0,936 # 1ed8 <malloc+0x416>
     b38:	5a3000ef          	jal	18da <printf>
        exit(1);
     b3c:	4505                	li	a0,1
     b3e:	678000ef          	jal	11b6 <exit>

0000000000000b42 <iter>:
  }
}

void
iter()
{
     b42:	1101                	addi	sp,sp,-32
     b44:	ec06                	sd	ra,24(sp)
     b46:	e822                	sd	s0,16(sp)
     b48:	1000                	addi	s0,sp,32
  unlink("a");
     b4a:	00001517          	auipc	a0,0x1
     b4e:	1d650513          	addi	a0,a0,470 # 1d20 <malloc+0x25e>
     b52:	6b4000ef          	jal	1206 <unlink>
  unlink("b");
     b56:	00001517          	auipc	a0,0x1
     b5a:	17a50513          	addi	a0,a0,378 # 1cd0 <malloc+0x20e>
     b5e:	6a8000ef          	jal	1206 <unlink>
  
  int pid1 = fork();
     b62:	64c000ef          	jal	11ae <fork>
     b66:	87aa                	mv	a5,a0
     b68:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0){
     b6c:	fec42783          	lw	a5,-20(s0)
     b70:	2781                	sext.w	a5,a5
     b72:	0007db63          	bgez	a5,b88 <iter+0x46>
    printf("grind: fork failed\n");
     b76:	00001517          	auipc	a0,0x1
     b7a:	19250513          	addi	a0,a0,402 # 1d08 <malloc+0x246>
     b7e:	55d000ef          	jal	18da <printf>
    exit(1);
     b82:	4505                	li	a0,1
     b84:	632000ef          	jal	11b6 <exit>
  }
  if(pid1 == 0){
     b88:	fec42783          	lw	a5,-20(s0)
     b8c:	2781                	sext.w	a5,a5
     b8e:	e39d                	bnez	a5,bb4 <iter+0x72>
    rand_next ^= 31;
     b90:	00001797          	auipc	a5,0x1
     b94:	47078793          	addi	a5,a5,1136 # 2000 <rand_next>
     b98:	639c                	ld	a5,0(a5)
     b9a:	01f7c713          	xori	a4,a5,31
     b9e:	00001797          	auipc	a5,0x1
     ba2:	46278793          	addi	a5,a5,1122 # 2000 <rand_next>
     ba6:	e398                	sd	a4,0(a5)
    go(0);
     ba8:	4501                	li	a0,0
     baa:	d5cff0ef          	jal	106 <go>
    exit(0);
     bae:	4501                	li	a0,0
     bb0:	606000ef          	jal	11b6 <exit>
  }

  int pid2 = fork();
     bb4:	5fa000ef          	jal	11ae <fork>
     bb8:	87aa                	mv	a5,a0
     bba:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0){
     bbe:	fe842783          	lw	a5,-24(s0)
     bc2:	2781                	sext.w	a5,a5
     bc4:	0007db63          	bgez	a5,bda <iter+0x98>
    printf("grind: fork failed\n");
     bc8:	00001517          	auipc	a0,0x1
     bcc:	14050513          	addi	a0,a0,320 # 1d08 <malloc+0x246>
     bd0:	50b000ef          	jal	18da <printf>
    exit(1);
     bd4:	4505                	li	a0,1
     bd6:	5e0000ef          	jal	11b6 <exit>
  }
  if(pid2 == 0){
     bda:	fe842783          	lw	a5,-24(s0)
     bde:	2781                	sext.w	a5,a5
     be0:	e78d                	bnez	a5,c0a <iter+0xc8>
    rand_next ^= 7177;
     be2:	00001797          	auipc	a5,0x1
     be6:	41e78793          	addi	a5,a5,1054 # 2000 <rand_next>
     bea:	6398                	ld	a4,0(a5)
     bec:	6789                	lui	a5,0x2
     bee:	c0978793          	addi	a5,a5,-1015 # 1c09 <malloc+0x147>
     bf2:	8f3d                	xor	a4,a4,a5
     bf4:	00001797          	auipc	a5,0x1
     bf8:	40c78793          	addi	a5,a5,1036 # 2000 <rand_next>
     bfc:	e398                	sd	a4,0(a5)
    go(1);
     bfe:	4505                	li	a0,1
     c00:	d06ff0ef          	jal	106 <go>
    exit(0);
     c04:	4501                	li	a0,0
     c06:	5b0000ef          	jal	11b6 <exit>
  }

  int st1 = -1;
     c0a:	57fd                	li	a5,-1
     c0c:	fef42223          	sw	a5,-28(s0)
  wait(&st1);
     c10:	fe440793          	addi	a5,s0,-28
     c14:	853e                	mv	a0,a5
     c16:	5a8000ef          	jal	11be <wait>
  if(st1 != 0){
     c1a:	fe442783          	lw	a5,-28(s0)
     c1e:	cb99                	beqz	a5,c34 <iter+0xf2>
    kill(pid1);
     c20:	fec42783          	lw	a5,-20(s0)
     c24:	853e                	mv	a0,a5
     c26:	5c0000ef          	jal	11e6 <kill>
    kill(pid2);
     c2a:	fe842783          	lw	a5,-24(s0)
     c2e:	853e                	mv	a0,a5
     c30:	5b6000ef          	jal	11e6 <kill>
  }
  int st2 = -1;
     c34:	57fd                	li	a5,-1
     c36:	fef42023          	sw	a5,-32(s0)
  wait(&st2);
     c3a:	fe040793          	addi	a5,s0,-32
     c3e:	853e                	mv	a0,a5
     c40:	57e000ef          	jal	11be <wait>

  exit(0);
     c44:	4501                	li	a0,0
     c46:	570000ef          	jal	11b6 <exit>

0000000000000c4a <main>:
}

int
main()
{
     c4a:	1101                	addi	sp,sp,-32
     c4c:	ec06                	sd	ra,24(sp)
     c4e:	e822                	sd	s0,16(sp)
     c50:	1000                	addi	s0,sp,32
  while(1){
    int pid = fork();
     c52:	55c000ef          	jal	11ae <fork>
     c56:	87aa                	mv	a5,a0
     c58:	fef42623          	sw	a5,-20(s0)
    if(pid == 0){
     c5c:	fec42783          	lw	a5,-20(s0)
     c60:	2781                	sext.w	a5,a5
     c62:	e791                	bnez	a5,c6e <main+0x24>
      iter();
     c64:	edfff0ef          	jal	b42 <iter>
      exit(0);
     c68:	4501                	li	a0,0
     c6a:	54c000ef          	jal	11b6 <exit>
    }
    if(pid > 0){
     c6e:	fec42783          	lw	a5,-20(s0)
     c72:	2781                	sext.w	a5,a5
     c74:	00f05563          	blez	a5,c7e <main+0x34>
      wait(0);
     c78:	4501                	li	a0,0
     c7a:	544000ef          	jal	11be <wait>
    }
    pause(20);
     c7e:	4551                	li	a0,20
     c80:	5c6000ef          	jal	1246 <pause>
    rand_next += 1;
     c84:	00001797          	auipc	a5,0x1
     c88:	37c78793          	addi	a5,a5,892 # 2000 <rand_next>
     c8c:	639c                	ld	a5,0(a5)
     c8e:	00178713          	addi	a4,a5,1
     c92:	00001797          	auipc	a5,0x1
     c96:	36e78793          	addi	a5,a5,878 # 2000 <rand_next>
     c9a:	e398                	sd	a4,0(a5)
  while(1){
     c9c:	bf5d                	j	c52 <main+0x8>

0000000000000c9e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     c9e:	7179                	addi	sp,sp,-48
     ca0:	f406                	sd	ra,40(sp)
     ca2:	f022                	sd	s0,32(sp)
     ca4:	1800                	addi	s0,sp,48
     ca6:	87aa                	mv	a5,a0
     ca8:	fcb43823          	sd	a1,-48(s0)
     cac:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     cb0:	fdc42783          	lw	a5,-36(s0)
     cb4:	fd043583          	ld	a1,-48(s0)
     cb8:	853e                	mv	a0,a5
     cba:	f91ff0ef          	jal	c4a <main>
     cbe:	87aa                	mv	a5,a0
     cc0:	fef42623          	sw	a5,-20(s0)
  exit(r);
     cc4:	fec42783          	lw	a5,-20(s0)
     cc8:	853e                	mv	a0,a5
     cca:	4ec000ef          	jal	11b6 <exit>

0000000000000cce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     cce:	7179                	addi	sp,sp,-48
     cd0:	f406                	sd	ra,40(sp)
     cd2:	f022                	sd	s0,32(sp)
     cd4:	1800                	addi	s0,sp,48
     cd6:	fca43c23          	sd	a0,-40(s0)
     cda:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     cde:	fd843783          	ld	a5,-40(s0)
     ce2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     ce6:	0001                	nop
     ce8:	fd043703          	ld	a4,-48(s0)
     cec:	00170793          	addi	a5,a4,1
     cf0:	fcf43823          	sd	a5,-48(s0)
     cf4:	fd843783          	ld	a5,-40(s0)
     cf8:	00178693          	addi	a3,a5,1
     cfc:	fcd43c23          	sd	a3,-40(s0)
     d00:	00074703          	lbu	a4,0(a4)
     d04:	00e78023          	sb	a4,0(a5)
     d08:	0007c783          	lbu	a5,0(a5)
     d0c:	fff1                	bnez	a5,ce8 <strcpy+0x1a>
    ;
  return os;
     d0e:	fe843783          	ld	a5,-24(s0)
}
     d12:	853e                	mv	a0,a5
     d14:	70a2                	ld	ra,40(sp)
     d16:	7402                	ld	s0,32(sp)
     d18:	6145                	addi	sp,sp,48
     d1a:	8082                	ret

0000000000000d1c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d1c:	1101                	addi	sp,sp,-32
     d1e:	ec06                	sd	ra,24(sp)
     d20:	e822                	sd	s0,16(sp)
     d22:	1000                	addi	s0,sp,32
     d24:	fea43423          	sd	a0,-24(s0)
     d28:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     d2c:	a819                	j	d42 <strcmp+0x26>
    p++, q++;
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	0785                	addi	a5,a5,1
     d34:	fef43423          	sd	a5,-24(s0)
     d38:	fe043783          	ld	a5,-32(s0)
     d3c:	0785                	addi	a5,a5,1
     d3e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	0007c783          	lbu	a5,0(a5)
     d4a:	cb99                	beqz	a5,d60 <strcmp+0x44>
     d4c:	fe843783          	ld	a5,-24(s0)
     d50:	0007c703          	lbu	a4,0(a5)
     d54:	fe043783          	ld	a5,-32(s0)
     d58:	0007c783          	lbu	a5,0(a5)
     d5c:	fcf709e3          	beq	a4,a5,d2e <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     d60:	fe843783          	ld	a5,-24(s0)
     d64:	0007c783          	lbu	a5,0(a5)
     d68:	0007871b          	sext.w	a4,a5
     d6c:	fe043783          	ld	a5,-32(s0)
     d70:	0007c783          	lbu	a5,0(a5)
     d74:	2781                	sext.w	a5,a5
     d76:	40f707bb          	subw	a5,a4,a5
     d7a:	2781                	sext.w	a5,a5
}
     d7c:	853e                	mv	a0,a5
     d7e:	60e2                	ld	ra,24(sp)
     d80:	6442                	ld	s0,16(sp)
     d82:	6105                	addi	sp,sp,32
     d84:	8082                	ret

0000000000000d86 <strlen>:

uint
strlen(const char *s)
{
     d86:	7179                	addi	sp,sp,-48
     d88:	f406                	sd	ra,40(sp)
     d8a:	f022                	sd	s0,32(sp)
     d8c:	1800                	addi	s0,sp,48
     d8e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     d92:	fe042623          	sw	zero,-20(s0)
     d96:	a031                	j	da2 <strlen+0x1c>
     d98:	fec42783          	lw	a5,-20(s0)
     d9c:	2785                	addiw	a5,a5,1
     d9e:	fef42623          	sw	a5,-20(s0)
     da2:	fec42783          	lw	a5,-20(s0)
     da6:	fd843703          	ld	a4,-40(s0)
     daa:	97ba                	add	a5,a5,a4
     dac:	0007c783          	lbu	a5,0(a5)
     db0:	f7e5                	bnez	a5,d98 <strlen+0x12>
    ;
  return n;
     db2:	fec42783          	lw	a5,-20(s0)
}
     db6:	853e                	mv	a0,a5
     db8:	70a2                	ld	ra,40(sp)
     dba:	7402                	ld	s0,32(sp)
     dbc:	6145                	addi	sp,sp,48
     dbe:	8082                	ret

0000000000000dc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     dc0:	7179                	addi	sp,sp,-48
     dc2:	f406                	sd	ra,40(sp)
     dc4:	f022                	sd	s0,32(sp)
     dc6:	1800                	addi	s0,sp,48
     dc8:	fca43c23          	sd	a0,-40(s0)
     dcc:	87ae                	mv	a5,a1
     dce:	8732                	mv	a4,a2
     dd0:	fcf42a23          	sw	a5,-44(s0)
     dd4:	87ba                	mv	a5,a4
     dd6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     dda:	fd843783          	ld	a5,-40(s0)
     dde:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     de2:	fe042623          	sw	zero,-20(s0)
     de6:	a00d                	j	e08 <memset+0x48>
    cdst[i] = c;
     de8:	fec42783          	lw	a5,-20(s0)
     dec:	fe043703          	ld	a4,-32(s0)
     df0:	97ba                	add	a5,a5,a4
     df2:	fd442703          	lw	a4,-44(s0)
     df6:	0ff77713          	zext.b	a4,a4
     dfa:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     dfe:	fec42783          	lw	a5,-20(s0)
     e02:	2785                	addiw	a5,a5,1
     e04:	fef42623          	sw	a5,-20(s0)
     e08:	fec42783          	lw	a5,-20(s0)
     e0c:	fd042703          	lw	a4,-48(s0)
     e10:	2701                	sext.w	a4,a4
     e12:	fce7ebe3          	bltu	a5,a4,de8 <memset+0x28>
  }
  return dst;
     e16:	fd843783          	ld	a5,-40(s0)
}
     e1a:	853e                	mv	a0,a5
     e1c:	70a2                	ld	ra,40(sp)
     e1e:	7402                	ld	s0,32(sp)
     e20:	6145                	addi	sp,sp,48
     e22:	8082                	ret

0000000000000e24 <strchr>:

char*
strchr(const char *s, char c)
{
     e24:	1101                	addi	sp,sp,-32
     e26:	ec06                	sd	ra,24(sp)
     e28:	e822                	sd	s0,16(sp)
     e2a:	1000                	addi	s0,sp,32
     e2c:	fea43423          	sd	a0,-24(s0)
     e30:	87ae                	mv	a5,a1
     e32:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     e36:	a01d                	j	e5c <strchr+0x38>
    if(*s == c)
     e38:	fe843783          	ld	a5,-24(s0)
     e3c:	0007c703          	lbu	a4,0(a5)
     e40:	fe744783          	lbu	a5,-25(s0)
     e44:	0ff7f793          	zext.b	a5,a5
     e48:	00e79563          	bne	a5,a4,e52 <strchr+0x2e>
      return (char*)s;
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	a821                	j	e68 <strchr+0x44>
  for(; *s; s++)
     e52:	fe843783          	ld	a5,-24(s0)
     e56:	0785                	addi	a5,a5,1
     e58:	fef43423          	sd	a5,-24(s0)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	0007c783          	lbu	a5,0(a5)
     e64:	fbf1                	bnez	a5,e38 <strchr+0x14>
  return 0;
     e66:	4781                	li	a5,0
}
     e68:	853e                	mv	a0,a5
     e6a:	60e2                	ld	ra,24(sp)
     e6c:	6442                	ld	s0,16(sp)
     e6e:	6105                	addi	sp,sp,32
     e70:	8082                	ret

0000000000000e72 <gets>:

char*
gets(char *buf, int max)
{
     e72:	7179                	addi	sp,sp,-48
     e74:	f406                	sd	ra,40(sp)
     e76:	f022                	sd	s0,32(sp)
     e78:	1800                	addi	s0,sp,48
     e7a:	fca43c23          	sd	a0,-40(s0)
     e7e:	87ae                	mv	a5,a1
     e80:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e84:	fe042623          	sw	zero,-20(s0)
     e88:	a891                	j	edc <gets+0x6a>
    cc = read(0, &c, 1);
     e8a:	fe740793          	addi	a5,s0,-25
     e8e:	4605                	li	a2,1
     e90:	85be                	mv	a1,a5
     e92:	4501                	li	a0,0
     e94:	33a000ef          	jal	11ce <read>
     e98:	87aa                	mv	a5,a0
     e9a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     e9e:	fe842783          	lw	a5,-24(s0)
     ea2:	2781                	sext.w	a5,a5
     ea4:	04f05663          	blez	a5,ef0 <gets+0x7e>
      break;
    buf[i++] = c;
     ea8:	fec42783          	lw	a5,-20(s0)
     eac:	0017871b          	addiw	a4,a5,1
     eb0:	fee42623          	sw	a4,-20(s0)
     eb4:	873e                	mv	a4,a5
     eb6:	fd843783          	ld	a5,-40(s0)
     eba:	97ba                	add	a5,a5,a4
     ebc:	fe744703          	lbu	a4,-25(s0)
     ec0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     ec4:	fe744783          	lbu	a5,-25(s0)
     ec8:	873e                	mv	a4,a5
     eca:	47a9                	li	a5,10
     ecc:	02f70363          	beq	a4,a5,ef2 <gets+0x80>
     ed0:	fe744783          	lbu	a5,-25(s0)
     ed4:	873e                	mv	a4,a5
     ed6:	47b5                	li	a5,13
     ed8:	00f70d63          	beq	a4,a5,ef2 <gets+0x80>
  for(i=0; i+1 < max; ){
     edc:	fec42783          	lw	a5,-20(s0)
     ee0:	2785                	addiw	a5,a5,1
     ee2:	2781                	sext.w	a5,a5
     ee4:	fd442703          	lw	a4,-44(s0)
     ee8:	2701                	sext.w	a4,a4
     eea:	fae7c0e3          	blt	a5,a4,e8a <gets+0x18>
     eee:	a011                	j	ef2 <gets+0x80>
      break;
     ef0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     ef2:	fec42783          	lw	a5,-20(s0)
     ef6:	fd843703          	ld	a4,-40(s0)
     efa:	97ba                	add	a5,a5,a4
     efc:	00078023          	sb	zero,0(a5)
  return buf;
     f00:	fd843783          	ld	a5,-40(s0)
}
     f04:	853e                	mv	a0,a5
     f06:	70a2                	ld	ra,40(sp)
     f08:	7402                	ld	s0,32(sp)
     f0a:	6145                	addi	sp,sp,48
     f0c:	8082                	ret

0000000000000f0e <stat>:

int
stat(const char *n, struct stat *st)
{
     f0e:	7179                	addi	sp,sp,-48
     f10:	f406                	sd	ra,40(sp)
     f12:	f022                	sd	s0,32(sp)
     f14:	1800                	addi	s0,sp,48
     f16:	fca43c23          	sd	a0,-40(s0)
     f1a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f1e:	4581                	li	a1,0
     f20:	fd843503          	ld	a0,-40(s0)
     f24:	2d2000ef          	jal	11f6 <open>
     f28:	87aa                	mv	a5,a0
     f2a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     f2e:	fec42783          	lw	a5,-20(s0)
     f32:	2781                	sext.w	a5,a5
     f34:	0007d463          	bgez	a5,f3c <stat+0x2e>
    return -1;
     f38:	57fd                	li	a5,-1
     f3a:	a015                	j	f5e <stat+0x50>
  r = fstat(fd, st);
     f3c:	fec42783          	lw	a5,-20(s0)
     f40:	fd043583          	ld	a1,-48(s0)
     f44:	853e                	mv	a0,a5
     f46:	2c8000ef          	jal	120e <fstat>
     f4a:	87aa                	mv	a5,a0
     f4c:	fef42423          	sw	a5,-24(s0)
  close(fd);
     f50:	fec42783          	lw	a5,-20(s0)
     f54:	853e                	mv	a0,a5
     f56:	288000ef          	jal	11de <close>
  return r;
     f5a:	fe842783          	lw	a5,-24(s0)
}
     f5e:	853e                	mv	a0,a5
     f60:	70a2                	ld	ra,40(sp)
     f62:	7402                	ld	s0,32(sp)
     f64:	6145                	addi	sp,sp,48
     f66:	8082                	ret

0000000000000f68 <atoi>:

int
atoi(const char *s)
{
     f68:	7179                	addi	sp,sp,-48
     f6a:	f406                	sd	ra,40(sp)
     f6c:	f022                	sd	s0,32(sp)
     f6e:	1800                	addi	s0,sp,48
     f70:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     f74:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     f78:	a81d                	j	fae <atoi+0x46>
    n = n*10 + *s++ - '0';
     f7a:	fec42783          	lw	a5,-20(s0)
     f7e:	873e                	mv	a4,a5
     f80:	87ba                	mv	a5,a4
     f82:	0027979b          	slliw	a5,a5,0x2
     f86:	9fb9                	addw	a5,a5,a4
     f88:	0017979b          	slliw	a5,a5,0x1
     f8c:	0007871b          	sext.w	a4,a5
     f90:	fd843783          	ld	a5,-40(s0)
     f94:	00178693          	addi	a3,a5,1
     f98:	fcd43c23          	sd	a3,-40(s0)
     f9c:	0007c783          	lbu	a5,0(a5)
     fa0:	2781                	sext.w	a5,a5
     fa2:	9fb9                	addw	a5,a5,a4
     fa4:	2781                	sext.w	a5,a5
     fa6:	fd07879b          	addiw	a5,a5,-48
     faa:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     fae:	fd843783          	ld	a5,-40(s0)
     fb2:	0007c783          	lbu	a5,0(a5)
     fb6:	873e                	mv	a4,a5
     fb8:	02f00793          	li	a5,47
     fbc:	00e7fb63          	bgeu	a5,a4,fd2 <atoi+0x6a>
     fc0:	fd843783          	ld	a5,-40(s0)
     fc4:	0007c783          	lbu	a5,0(a5)
     fc8:	873e                	mv	a4,a5
     fca:	03900793          	li	a5,57
     fce:	fae7f6e3          	bgeu	a5,a4,f7a <atoi+0x12>
  return n;
     fd2:	fec42783          	lw	a5,-20(s0)
}
     fd6:	853e                	mv	a0,a5
     fd8:	70a2                	ld	ra,40(sp)
     fda:	7402                	ld	s0,32(sp)
     fdc:	6145                	addi	sp,sp,48
     fde:	8082                	ret

0000000000000fe0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fe0:	7139                	addi	sp,sp,-64
     fe2:	fc06                	sd	ra,56(sp)
     fe4:	f822                	sd	s0,48(sp)
     fe6:	0080                	addi	s0,sp,64
     fe8:	fca43c23          	sd	a0,-40(s0)
     fec:	fcb43823          	sd	a1,-48(s0)
     ff0:	87b2                	mv	a5,a2
     ff2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     ff6:	fd843783          	ld	a5,-40(s0)
     ffa:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     ffe:	fd043783          	ld	a5,-48(s0)
    1002:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    1006:	fe043703          	ld	a4,-32(s0)
    100a:	fe843783          	ld	a5,-24(s0)
    100e:	02e7fc63          	bgeu	a5,a4,1046 <memmove+0x66>
    while(n-- > 0)
    1012:	a00d                	j	1034 <memmove+0x54>
      *dst++ = *src++;
    1014:	fe043703          	ld	a4,-32(s0)
    1018:	00170793          	addi	a5,a4,1
    101c:	fef43023          	sd	a5,-32(s0)
    1020:	fe843783          	ld	a5,-24(s0)
    1024:	00178693          	addi	a3,a5,1
    1028:	fed43423          	sd	a3,-24(s0)
    102c:	00074703          	lbu	a4,0(a4)
    1030:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1034:	fcc42783          	lw	a5,-52(s0)
    1038:	fff7871b          	addiw	a4,a5,-1
    103c:	fce42623          	sw	a4,-52(s0)
    1040:	fcf04ae3          	bgtz	a5,1014 <memmove+0x34>
    1044:	a891                	j	1098 <memmove+0xb8>
  } else {
    dst += n;
    1046:	fcc42783          	lw	a5,-52(s0)
    104a:	fe843703          	ld	a4,-24(s0)
    104e:	97ba                	add	a5,a5,a4
    1050:	fef43423          	sd	a5,-24(s0)
    src += n;
    1054:	fcc42783          	lw	a5,-52(s0)
    1058:	fe043703          	ld	a4,-32(s0)
    105c:	97ba                	add	a5,a5,a4
    105e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    1062:	a01d                	j	1088 <memmove+0xa8>
      *--dst = *--src;
    1064:	fe043783          	ld	a5,-32(s0)
    1068:	17fd                	addi	a5,a5,-1
    106a:	fef43023          	sd	a5,-32(s0)
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	17fd                	addi	a5,a5,-1
    1074:	fef43423          	sd	a5,-24(s0)
    1078:	fe043783          	ld	a5,-32(s0)
    107c:	0007c703          	lbu	a4,0(a5)
    1080:	fe843783          	ld	a5,-24(s0)
    1084:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1088:	fcc42783          	lw	a5,-52(s0)
    108c:	fff7871b          	addiw	a4,a5,-1
    1090:	fce42623          	sw	a4,-52(s0)
    1094:	fcf048e3          	bgtz	a5,1064 <memmove+0x84>
  }
  return vdst;
    1098:	fd843783          	ld	a5,-40(s0)
}
    109c:	853e                	mv	a0,a5
    109e:	70e2                	ld	ra,56(sp)
    10a0:	7442                	ld	s0,48(sp)
    10a2:	6121                	addi	sp,sp,64
    10a4:	8082                	ret

00000000000010a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    10a6:	7139                	addi	sp,sp,-64
    10a8:	fc06                	sd	ra,56(sp)
    10aa:	f822                	sd	s0,48(sp)
    10ac:	0080                	addi	s0,sp,64
    10ae:	fca43c23          	sd	a0,-40(s0)
    10b2:	fcb43823          	sd	a1,-48(s0)
    10b6:	87b2                	mv	a5,a2
    10b8:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    10bc:	fd843783          	ld	a5,-40(s0)
    10c0:	fef43423          	sd	a5,-24(s0)
    10c4:	fd043783          	ld	a5,-48(s0)
    10c8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    10cc:	a0a1                	j	1114 <memcmp+0x6e>
    if (*p1 != *p2) {
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	0007c703          	lbu	a4,0(a5)
    10d6:	fe043783          	ld	a5,-32(s0)
    10da:	0007c783          	lbu	a5,0(a5)
    10de:	02f70163          	beq	a4,a5,1100 <memcmp+0x5a>
      return *p1 - *p2;
    10e2:	fe843783          	ld	a5,-24(s0)
    10e6:	0007c783          	lbu	a5,0(a5)
    10ea:	0007871b          	sext.w	a4,a5
    10ee:	fe043783          	ld	a5,-32(s0)
    10f2:	0007c783          	lbu	a5,0(a5)
    10f6:	2781                	sext.w	a5,a5
    10f8:	40f707bb          	subw	a5,a4,a5
    10fc:	2781                	sext.w	a5,a5
    10fe:	a01d                	j	1124 <memcmp+0x7e>
    }
    p1++;
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	0785                	addi	a5,a5,1
    1106:	fef43423          	sd	a5,-24(s0)
    p2++;
    110a:	fe043783          	ld	a5,-32(s0)
    110e:	0785                	addi	a5,a5,1
    1110:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    1114:	fcc42783          	lw	a5,-52(s0)
    1118:	fff7871b          	addiw	a4,a5,-1
    111c:	fce42623          	sw	a4,-52(s0)
    1120:	f7dd                	bnez	a5,10ce <memcmp+0x28>
  }
  return 0;
    1122:	4781                	li	a5,0
}
    1124:	853e                	mv	a0,a5
    1126:	70e2                	ld	ra,56(sp)
    1128:	7442                	ld	s0,48(sp)
    112a:	6121                	addi	sp,sp,64
    112c:	8082                	ret

000000000000112e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    112e:	7179                	addi	sp,sp,-48
    1130:	f406                	sd	ra,40(sp)
    1132:	f022                	sd	s0,32(sp)
    1134:	1800                	addi	s0,sp,48
    1136:	fea43423          	sd	a0,-24(s0)
    113a:	feb43023          	sd	a1,-32(s0)
    113e:	87b2                	mv	a5,a2
    1140:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    1144:	fdc42783          	lw	a5,-36(s0)
    1148:	863e                	mv	a2,a5
    114a:	fe043583          	ld	a1,-32(s0)
    114e:	fe843503          	ld	a0,-24(s0)
    1152:	e8fff0ef          	jal	fe0 <memmove>
    1156:	87aa                	mv	a5,a0
}
    1158:	853e                	mv	a0,a5
    115a:	70a2                	ld	ra,40(sp)
    115c:	7402                	ld	s0,32(sp)
    115e:	6145                	addi	sp,sp,48
    1160:	8082                	ret

0000000000001162 <sbrk>:

char *
sbrk(int n) {
    1162:	1101                	addi	sp,sp,-32
    1164:	ec06                	sd	ra,24(sp)
    1166:	e822                	sd	s0,16(sp)
    1168:	1000                	addi	s0,sp,32
    116a:	87aa                	mv	a5,a0
    116c:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
    1170:	fec42783          	lw	a5,-20(s0)
    1174:	4585                	li	a1,1
    1176:	853e                	mv	a0,a5
    1178:	0c6000ef          	jal	123e <sys_sbrk>
    117c:	87aa                	mv	a5,a0
}
    117e:	853e                	mv	a0,a5
    1180:	60e2                	ld	ra,24(sp)
    1182:	6442                	ld	s0,16(sp)
    1184:	6105                	addi	sp,sp,32
    1186:	8082                	ret

0000000000001188 <sbrklazy>:

char *
sbrklazy(int n) {
    1188:	1101                	addi	sp,sp,-32
    118a:	ec06                	sd	ra,24(sp)
    118c:	e822                	sd	s0,16(sp)
    118e:	1000                	addi	s0,sp,32
    1190:	87aa                	mv	a5,a0
    1192:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
    1196:	fec42783          	lw	a5,-20(s0)
    119a:	4589                	li	a1,2
    119c:	853e                	mv	a0,a5
    119e:	0a0000ef          	jal	123e <sys_sbrk>
    11a2:	87aa                	mv	a5,a0
}
    11a4:	853e                	mv	a0,a5
    11a6:	60e2                	ld	ra,24(sp)
    11a8:	6442                	ld	s0,16(sp)
    11aa:	6105                	addi	sp,sp,32
    11ac:	8082                	ret

00000000000011ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    11ae:	4885                	li	a7,1
 ecall
    11b0:	00000073          	ecall
 ret
    11b4:	8082                	ret

00000000000011b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    11b6:	4889                	li	a7,2
 ecall
    11b8:	00000073          	ecall
 ret
    11bc:	8082                	ret

00000000000011be <wait>:
.global wait
wait:
 li a7, SYS_wait
    11be:	488d                	li	a7,3
 ecall
    11c0:	00000073          	ecall
 ret
    11c4:	8082                	ret

00000000000011c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    11c6:	4891                	li	a7,4
 ecall
    11c8:	00000073          	ecall
 ret
    11cc:	8082                	ret

00000000000011ce <read>:
.global read
read:
 li a7, SYS_read
    11ce:	4895                	li	a7,5
 ecall
    11d0:	00000073          	ecall
 ret
    11d4:	8082                	ret

00000000000011d6 <write>:
.global write
write:
 li a7, SYS_write
    11d6:	48c1                	li	a7,16
 ecall
    11d8:	00000073          	ecall
 ret
    11dc:	8082                	ret

00000000000011de <close>:
.global close
close:
 li a7, SYS_close
    11de:	48d5                	li	a7,21
 ecall
    11e0:	00000073          	ecall
 ret
    11e4:	8082                	ret

00000000000011e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    11e6:	4899                	li	a7,6
 ecall
    11e8:	00000073          	ecall
 ret
    11ec:	8082                	ret

00000000000011ee <exec>:
.global exec
exec:
 li a7, SYS_exec
    11ee:	489d                	li	a7,7
 ecall
    11f0:	00000073          	ecall
 ret
    11f4:	8082                	ret

00000000000011f6 <open>:
.global open
open:
 li a7, SYS_open
    11f6:	48bd                	li	a7,15
 ecall
    11f8:	00000073          	ecall
 ret
    11fc:	8082                	ret

00000000000011fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    11fe:	48c5                	li	a7,17
 ecall
    1200:	00000073          	ecall
 ret
    1204:	8082                	ret

0000000000001206 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1206:	48c9                	li	a7,18
 ecall
    1208:	00000073          	ecall
 ret
    120c:	8082                	ret

000000000000120e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    120e:	48a1                	li	a7,8
 ecall
    1210:	00000073          	ecall
 ret
    1214:	8082                	ret

0000000000001216 <link>:
.global link
link:
 li a7, SYS_link
    1216:	48cd                	li	a7,19
 ecall
    1218:	00000073          	ecall
 ret
    121c:	8082                	ret

000000000000121e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    121e:	48d1                	li	a7,20
 ecall
    1220:	00000073          	ecall
 ret
    1224:	8082                	ret

0000000000001226 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1226:	48a5                	li	a7,9
 ecall
    1228:	00000073          	ecall
 ret
    122c:	8082                	ret

000000000000122e <dup>:
.global dup
dup:
 li a7, SYS_dup
    122e:	48a9                	li	a7,10
 ecall
    1230:	00000073          	ecall
 ret
    1234:	8082                	ret

0000000000001236 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1236:	48ad                	li	a7,11
 ecall
    1238:	00000073          	ecall
 ret
    123c:	8082                	ret

000000000000123e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    123e:	48b1                	li	a7,12
 ecall
    1240:	00000073          	ecall
 ret
    1244:	8082                	ret

0000000000001246 <pause>:
.global pause
pause:
 li a7, SYS_pause
    1246:	48b5                	li	a7,13
 ecall
    1248:	00000073          	ecall
 ret
    124c:	8082                	ret

000000000000124e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    124e:	48b9                	li	a7,14
 ecall
    1250:	00000073          	ecall
 ret
    1254:	8082                	ret

0000000000001256 <top>:
.global top
top:
 li a7, SYS_top
    1256:	48d9                	li	a7,22
 ecall
    1258:	00000073          	ecall
 ret
    125c:	8082                	ret

000000000000125e <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
    125e:	48dd                	li	a7,23
 ecall
    1260:	00000073          	ecall
 ret
    1264:	8082                	ret

0000000000001266 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1266:	1101                	addi	sp,sp,-32
    1268:	ec06                	sd	ra,24(sp)
    126a:	e822                	sd	s0,16(sp)
    126c:	1000                	addi	s0,sp,32
    126e:	87aa                	mv	a5,a0
    1270:	872e                	mv	a4,a1
    1272:	fef42623          	sw	a5,-20(s0)
    1276:	87ba                	mv	a5,a4
    1278:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    127c:	feb40713          	addi	a4,s0,-21
    1280:	fec42783          	lw	a5,-20(s0)
    1284:	4605                	li	a2,1
    1286:	85ba                	mv	a1,a4
    1288:	853e                	mv	a0,a5
    128a:	f4dff0ef          	jal	11d6 <write>
}
    128e:	0001                	nop
    1290:	60e2                	ld	ra,24(sp)
    1292:	6442                	ld	s0,16(sp)
    1294:	6105                	addi	sp,sp,32
    1296:	8082                	ret

0000000000001298 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    1298:	711d                	addi	sp,sp,-96
    129a:	ec86                	sd	ra,88(sp)
    129c:	e8a2                	sd	s0,80(sp)
    129e:	1080                	addi	s0,sp,96
    12a0:	87aa                	mv	a5,a0
    12a2:	fab43823          	sd	a1,-80(s0)
    12a6:	8736                	mv	a4,a3
    12a8:	faf42e23          	sw	a5,-68(s0)
    12ac:	87b2                	mv	a5,a2
    12ae:	faf42c23          	sw	a5,-72(s0)
    12b2:	87ba                	mv	a5,a4
    12b4:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
    12b8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    12bc:	fac42783          	lw	a5,-84(s0)
    12c0:	2781                	sext.w	a5,a5
    12c2:	cf99                	beqz	a5,12e0 <printint+0x48>
    12c4:	fb043783          	ld	a5,-80(s0)
    12c8:	0007dc63          	bgez	a5,12e0 <printint+0x48>
    neg = 1;
    12cc:	4785                	li	a5,1
    12ce:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    12d2:	fb043783          	ld	a5,-80(s0)
    12d6:	40f007b3          	neg	a5,a5
    12da:	fef43023          	sd	a5,-32(s0)
    12de:	a029                	j	12e8 <printint+0x50>
  } else {
    x = xx;
    12e0:	fb043783          	ld	a5,-80(s0)
    12e4:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
    12e8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    12ec:	fb842783          	lw	a5,-72(s0)
    12f0:	fe043703          	ld	a4,-32(s0)
    12f4:	02f77733          	remu	a4,a4,a5
    12f8:	fec42783          	lw	a5,-20(s0)
    12fc:	0017869b          	addiw	a3,a5,1
    1300:	fed42623          	sw	a3,-20(s0)
    1304:	00001697          	auipc	a3,0x1
    1308:	d0c68693          	addi	a3,a3,-756 # 2010 <digits>
    130c:	9736                	add	a4,a4,a3
    130e:	00074703          	lbu	a4,0(a4)
    1312:	17c1                	addi	a5,a5,-16
    1314:	97a2                	add	a5,a5,s0
    1316:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
    131a:	fb842783          	lw	a5,-72(s0)
    131e:	fe043703          	ld	a4,-32(s0)
    1322:	02f757b3          	divu	a5,a4,a5
    1326:	fef43023          	sd	a5,-32(s0)
    132a:	fe043783          	ld	a5,-32(s0)
    132e:	ffdd                	bnez	a5,12ec <printint+0x54>
  if(neg)
    1330:	fe842783          	lw	a5,-24(s0)
    1334:	2781                	sext.w	a5,a5
    1336:	cb95                	beqz	a5,136a <printint+0xd2>
    buf[i++] = '-';
    1338:	fec42783          	lw	a5,-20(s0)
    133c:	0017871b          	addiw	a4,a5,1
    1340:	fee42623          	sw	a4,-20(s0)
    1344:	17c1                	addi	a5,a5,-16
    1346:	97a2                	add	a5,a5,s0
    1348:	02d00713          	li	a4,45
    134c:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
    1350:	a829                	j	136a <printint+0xd2>
    putc(fd, buf[i]);
    1352:	fec42783          	lw	a5,-20(s0)
    1356:	17c1                	addi	a5,a5,-16
    1358:	97a2                	add	a5,a5,s0
    135a:	fd87c703          	lbu	a4,-40(a5)
    135e:	fbc42783          	lw	a5,-68(s0)
    1362:	85ba                	mv	a1,a4
    1364:	853e                	mv	a0,a5
    1366:	f01ff0ef          	jal	1266 <putc>
  while(--i >= 0)
    136a:	fec42783          	lw	a5,-20(s0)
    136e:	37fd                	addiw	a5,a5,-1
    1370:	fef42623          	sw	a5,-20(s0)
    1374:	fec42783          	lw	a5,-20(s0)
    1378:	2781                	sext.w	a5,a5
    137a:	fc07dce3          	bgez	a5,1352 <printint+0xba>
}
    137e:	0001                	nop
    1380:	0001                	nop
    1382:	60e6                	ld	ra,88(sp)
    1384:	6446                	ld	s0,80(sp)
    1386:	6125                	addi	sp,sp,96
    1388:	8082                	ret

000000000000138a <printptr>:

static void
printptr(int fd, uint64 x) {
    138a:	7179                	addi	sp,sp,-48
    138c:	f406                	sd	ra,40(sp)
    138e:	f022                	sd	s0,32(sp)
    1390:	1800                	addi	s0,sp,48
    1392:	87aa                	mv	a5,a0
    1394:	fcb43823          	sd	a1,-48(s0)
    1398:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    139c:	fdc42783          	lw	a5,-36(s0)
    13a0:	03000593          	li	a1,48
    13a4:	853e                	mv	a0,a5
    13a6:	ec1ff0ef          	jal	1266 <putc>
  putc(fd, 'x');
    13aa:	fdc42783          	lw	a5,-36(s0)
    13ae:	07800593          	li	a1,120
    13b2:	853e                	mv	a0,a5
    13b4:	eb3ff0ef          	jal	1266 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13b8:	fe042623          	sw	zero,-20(s0)
    13bc:	a81d                	j	13f2 <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    13be:	fd043783          	ld	a5,-48(s0)
    13c2:	93f1                	srli	a5,a5,0x3c
    13c4:	00001717          	auipc	a4,0x1
    13c8:	c4c70713          	addi	a4,a4,-948 # 2010 <digits>
    13cc:	97ba                	add	a5,a5,a4
    13ce:	0007c703          	lbu	a4,0(a5)
    13d2:	fdc42783          	lw	a5,-36(s0)
    13d6:	85ba                	mv	a1,a4
    13d8:	853e                	mv	a0,a5
    13da:	e8dff0ef          	jal	1266 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13de:	fec42783          	lw	a5,-20(s0)
    13e2:	2785                	addiw	a5,a5,1
    13e4:	fef42623          	sw	a5,-20(s0)
    13e8:	fd043783          	ld	a5,-48(s0)
    13ec:	0792                	slli	a5,a5,0x4
    13ee:	fcf43823          	sd	a5,-48(s0)
    13f2:	fec42703          	lw	a4,-20(s0)
    13f6:	47bd                	li	a5,15
    13f8:	fce7f3e3          	bgeu	a5,a4,13be <printptr+0x34>
}
    13fc:	0001                	nop
    13fe:	0001                	nop
    1400:	70a2                	ld	ra,40(sp)
    1402:	7402                	ld	s0,32(sp)
    1404:	6145                	addi	sp,sp,48
    1406:	8082                	ret

0000000000001408 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1408:	715d                	addi	sp,sp,-80
    140a:	e486                	sd	ra,72(sp)
    140c:	e0a2                	sd	s0,64(sp)
    140e:	0880                	addi	s0,sp,80
    1410:	87aa                	mv	a5,a0
    1412:	fcb43023          	sd	a1,-64(s0)
    1416:	fac43c23          	sd	a2,-72(s0)
    141a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
    141e:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    1422:	fc042e23          	sw	zero,-36(s0)
    1426:	a189                	j	1868 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
    1428:	fdc42783          	lw	a5,-36(s0)
    142c:	fc043703          	ld	a4,-64(s0)
    1430:	97ba                	add	a5,a5,a4
    1432:	0007c783          	lbu	a5,0(a5)
    1436:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
    143a:	fd842783          	lw	a5,-40(s0)
    143e:	2781                	sext.w	a5,a5
    1440:	eb8d                	bnez	a5,1472 <vprintf+0x6a>
      if(c0 == '%'){
    1442:	fd442783          	lw	a5,-44(s0)
    1446:	0007871b          	sext.w	a4,a5
    144a:	02500793          	li	a5,37
    144e:	00f71763          	bne	a4,a5,145c <vprintf+0x54>
        state = '%';
    1452:	02500793          	li	a5,37
    1456:	fcf42c23          	sw	a5,-40(s0)
    145a:	a111                	j	185e <vprintf+0x456>
      } else {
        putc(fd, c0);
    145c:	fd442783          	lw	a5,-44(s0)
    1460:	0ff7f713          	zext.b	a4,a5
    1464:	fcc42783          	lw	a5,-52(s0)
    1468:	85ba                	mv	a1,a4
    146a:	853e                	mv	a0,a5
    146c:	dfbff0ef          	jal	1266 <putc>
    1470:	a6fd                	j	185e <vprintf+0x456>
      }
    } else if(state == '%'){
    1472:	fd842783          	lw	a5,-40(s0)
    1476:	0007871b          	sext.w	a4,a5
    147a:	02500793          	li	a5,37
    147e:	3ef71063          	bne	a4,a5,185e <vprintf+0x456>
      c1 = c2 = 0;
    1482:	fe042023          	sw	zero,-32(s0)
    1486:	fe042783          	lw	a5,-32(s0)
    148a:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
    148e:	fd442783          	lw	a5,-44(s0)
    1492:	2781                	sext.w	a5,a5
    1494:	cb99                	beqz	a5,14aa <vprintf+0xa2>
    1496:	fdc42783          	lw	a5,-36(s0)
    149a:	0785                	addi	a5,a5,1
    149c:	fc043703          	ld	a4,-64(s0)
    14a0:	97ba                	add	a5,a5,a4
    14a2:	0007c783          	lbu	a5,0(a5)
    14a6:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
    14aa:	fe442783          	lw	a5,-28(s0)
    14ae:	2781                	sext.w	a5,a5
    14b0:	cb99                	beqz	a5,14c6 <vprintf+0xbe>
    14b2:	fdc42783          	lw	a5,-36(s0)
    14b6:	0789                	addi	a5,a5,2
    14b8:	fc043703          	ld	a4,-64(s0)
    14bc:	97ba                	add	a5,a5,a4
    14be:	0007c783          	lbu	a5,0(a5)
    14c2:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
    14c6:	fd442783          	lw	a5,-44(s0)
    14ca:	0007871b          	sext.w	a4,a5
    14ce:	06400793          	li	a5,100
    14d2:	02f71363          	bne	a4,a5,14f8 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
    14d6:	fb843783          	ld	a5,-72(s0)
    14da:	00878713          	addi	a4,a5,8
    14de:	fae43c23          	sd	a4,-72(s0)
    14e2:	439c                	lw	a5,0(a5)
    14e4:	873e                	mv	a4,a5
    14e6:	fcc42783          	lw	a5,-52(s0)
    14ea:	4685                	li	a3,1
    14ec:	4629                	li	a2,10
    14ee:	85ba                	mv	a1,a4
    14f0:	853e                	mv	a0,a5
    14f2:	da7ff0ef          	jal	1298 <printint>
    14f6:	a695                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
    14f8:	fd442783          	lw	a5,-44(s0)
    14fc:	0007871b          	sext.w	a4,a5
    1500:	06c00793          	li	a5,108
    1504:	04f71063          	bne	a4,a5,1544 <vprintf+0x13c>
    1508:	fe442783          	lw	a5,-28(s0)
    150c:	0007871b          	sext.w	a4,a5
    1510:	06400793          	li	a5,100
    1514:	02f71863          	bne	a4,a5,1544 <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1518:	fb843783          	ld	a5,-72(s0)
    151c:	00878713          	addi	a4,a5,8
    1520:	fae43c23          	sd	a4,-72(s0)
    1524:	639c                	ld	a5,0(a5)
    1526:	873e                	mv	a4,a5
    1528:	fcc42783          	lw	a5,-52(s0)
    152c:	4685                	li	a3,1
    152e:	4629                	li	a2,10
    1530:	85ba                	mv	a1,a4
    1532:	853e                	mv	a0,a5
    1534:	d65ff0ef          	jal	1298 <printint>
        i += 1;
    1538:	fdc42783          	lw	a5,-36(s0)
    153c:	2785                	addiw	a5,a5,1
    153e:	fcf42e23          	sw	a5,-36(s0)
    1542:	ae21                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1544:	fd442783          	lw	a5,-44(s0)
    1548:	0007871b          	sext.w	a4,a5
    154c:	06c00793          	li	a5,108
    1550:	04f71863          	bne	a4,a5,15a0 <vprintf+0x198>
    1554:	fe442783          	lw	a5,-28(s0)
    1558:	0007871b          	sext.w	a4,a5
    155c:	06c00793          	li	a5,108
    1560:	04f71063          	bne	a4,a5,15a0 <vprintf+0x198>
    1564:	fe042783          	lw	a5,-32(s0)
    1568:	0007871b          	sext.w	a4,a5
    156c:	06400793          	li	a5,100
    1570:	02f71863          	bne	a4,a5,15a0 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1574:	fb843783          	ld	a5,-72(s0)
    1578:	00878713          	addi	a4,a5,8
    157c:	fae43c23          	sd	a4,-72(s0)
    1580:	639c                	ld	a5,0(a5)
    1582:	873e                	mv	a4,a5
    1584:	fcc42783          	lw	a5,-52(s0)
    1588:	4685                	li	a3,1
    158a:	4629                	li	a2,10
    158c:	85ba                	mv	a1,a4
    158e:	853e                	mv	a0,a5
    1590:	d09ff0ef          	jal	1298 <printint>
        i += 2;
    1594:	fdc42783          	lw	a5,-36(s0)
    1598:	2789                	addiw	a5,a5,2
    159a:	fcf42e23          	sw	a5,-36(s0)
    159e:	ac75                	j	185a <vprintf+0x452>
      } else if(c0 == 'u'){
    15a0:	fd442783          	lw	a5,-44(s0)
    15a4:	0007871b          	sext.w	a4,a5
    15a8:	07500793          	li	a5,117
    15ac:	02f71563          	bne	a4,a5,15d6 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
    15b0:	fb843783          	ld	a5,-72(s0)
    15b4:	00878713          	addi	a4,a5,8
    15b8:	fae43c23          	sd	a4,-72(s0)
    15bc:	439c                	lw	a5,0(a5)
    15be:	02079713          	slli	a4,a5,0x20
    15c2:	9301                	srli	a4,a4,0x20
    15c4:	fcc42783          	lw	a5,-52(s0)
    15c8:	4681                	li	a3,0
    15ca:	4629                	li	a2,10
    15cc:	85ba                	mv	a1,a4
    15ce:	853e                	mv	a0,a5
    15d0:	cc9ff0ef          	jal	1298 <printint>
    15d4:	a459                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
    15d6:	fd442783          	lw	a5,-44(s0)
    15da:	0007871b          	sext.w	a4,a5
    15de:	06c00793          	li	a5,108
    15e2:	04f71063          	bne	a4,a5,1622 <vprintf+0x21a>
    15e6:	fe442783          	lw	a5,-28(s0)
    15ea:	0007871b          	sext.w	a4,a5
    15ee:	07500793          	li	a5,117
    15f2:	02f71863          	bne	a4,a5,1622 <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    15f6:	fb843783          	ld	a5,-72(s0)
    15fa:	00878713          	addi	a4,a5,8
    15fe:	fae43c23          	sd	a4,-72(s0)
    1602:	639c                	ld	a5,0(a5)
    1604:	873e                	mv	a4,a5
    1606:	fcc42783          	lw	a5,-52(s0)
    160a:	4681                	li	a3,0
    160c:	4629                	li	a2,10
    160e:	85ba                	mv	a1,a4
    1610:	853e                	mv	a0,a5
    1612:	c87ff0ef          	jal	1298 <printint>
        i += 1;
    1616:	fdc42783          	lw	a5,-36(s0)
    161a:	2785                	addiw	a5,a5,1
    161c:	fcf42e23          	sw	a5,-36(s0)
    1620:	ac2d                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    1622:	fd442783          	lw	a5,-44(s0)
    1626:	0007871b          	sext.w	a4,a5
    162a:	06c00793          	li	a5,108
    162e:	04f71863          	bne	a4,a5,167e <vprintf+0x276>
    1632:	fe442783          	lw	a5,-28(s0)
    1636:	0007871b          	sext.w	a4,a5
    163a:	06c00793          	li	a5,108
    163e:	04f71063          	bne	a4,a5,167e <vprintf+0x276>
    1642:	fe042783          	lw	a5,-32(s0)
    1646:	0007871b          	sext.w	a4,a5
    164a:	07500793          	li	a5,117
    164e:	02f71863          	bne	a4,a5,167e <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1652:	fb843783          	ld	a5,-72(s0)
    1656:	00878713          	addi	a4,a5,8
    165a:	fae43c23          	sd	a4,-72(s0)
    165e:	639c                	ld	a5,0(a5)
    1660:	873e                	mv	a4,a5
    1662:	fcc42783          	lw	a5,-52(s0)
    1666:	4681                	li	a3,0
    1668:	4629                	li	a2,10
    166a:	85ba                	mv	a1,a4
    166c:	853e                	mv	a0,a5
    166e:	c2bff0ef          	jal	1298 <printint>
        i += 2;
    1672:	fdc42783          	lw	a5,-36(s0)
    1676:	2789                	addiw	a5,a5,2
    1678:	fcf42e23          	sw	a5,-36(s0)
    167c:	aaf9                	j	185a <vprintf+0x452>
      } else if(c0 == 'x'){
    167e:	fd442783          	lw	a5,-44(s0)
    1682:	0007871b          	sext.w	a4,a5
    1686:	07800793          	li	a5,120
    168a:	02f71563          	bne	a4,a5,16b4 <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
    168e:	fb843783          	ld	a5,-72(s0)
    1692:	00878713          	addi	a4,a5,8
    1696:	fae43c23          	sd	a4,-72(s0)
    169a:	439c                	lw	a5,0(a5)
    169c:	02079713          	slli	a4,a5,0x20
    16a0:	9301                	srli	a4,a4,0x20
    16a2:	fcc42783          	lw	a5,-52(s0)
    16a6:	4681                	li	a3,0
    16a8:	4641                	li	a2,16
    16aa:	85ba                	mv	a1,a4
    16ac:	853e                	mv	a0,a5
    16ae:	bebff0ef          	jal	1298 <printint>
    16b2:	a265                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
    16b4:	fd442783          	lw	a5,-44(s0)
    16b8:	0007871b          	sext.w	a4,a5
    16bc:	06c00793          	li	a5,108
    16c0:	04f71063          	bne	a4,a5,1700 <vprintf+0x2f8>
    16c4:	fe442783          	lw	a5,-28(s0)
    16c8:	0007871b          	sext.w	a4,a5
    16cc:	07800793          	li	a5,120
    16d0:	02f71863          	bne	a4,a5,1700 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
    16d4:	fb843783          	ld	a5,-72(s0)
    16d8:	00878713          	addi	a4,a5,8
    16dc:	fae43c23          	sd	a4,-72(s0)
    16e0:	639c                	ld	a5,0(a5)
    16e2:	873e                	mv	a4,a5
    16e4:	fcc42783          	lw	a5,-52(s0)
    16e8:	4681                	li	a3,0
    16ea:	4641                	li	a2,16
    16ec:	85ba                	mv	a1,a4
    16ee:	853e                	mv	a0,a5
    16f0:	ba9ff0ef          	jal	1298 <printint>
        i += 1;
    16f4:	fdc42783          	lw	a5,-36(s0)
    16f8:	2785                	addiw	a5,a5,1
    16fa:	fcf42e23          	sw	a5,-36(s0)
    16fe:	aab1                	j	185a <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    1700:	fd442783          	lw	a5,-44(s0)
    1704:	0007871b          	sext.w	a4,a5
    1708:	06c00793          	li	a5,108
    170c:	04f71863          	bne	a4,a5,175c <vprintf+0x354>
    1710:	fe442783          	lw	a5,-28(s0)
    1714:	0007871b          	sext.w	a4,a5
    1718:	06c00793          	li	a5,108
    171c:	04f71063          	bne	a4,a5,175c <vprintf+0x354>
    1720:	fe042783          	lw	a5,-32(s0)
    1724:	0007871b          	sext.w	a4,a5
    1728:	07800793          	li	a5,120
    172c:	02f71863          	bne	a4,a5,175c <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1730:	fb843783          	ld	a5,-72(s0)
    1734:	00878713          	addi	a4,a5,8
    1738:	fae43c23          	sd	a4,-72(s0)
    173c:	639c                	ld	a5,0(a5)
    173e:	873e                	mv	a4,a5
    1740:	fcc42783          	lw	a5,-52(s0)
    1744:	4681                	li	a3,0
    1746:	4641                	li	a2,16
    1748:	85ba                	mv	a1,a4
    174a:	853e                	mv	a0,a5
    174c:	b4dff0ef          	jal	1298 <printint>
        i += 2;
    1750:	fdc42783          	lw	a5,-36(s0)
    1754:	2789                	addiw	a5,a5,2
    1756:	fcf42e23          	sw	a5,-36(s0)
    175a:	a201                	j	185a <vprintf+0x452>
      } else if(c0 == 'p'){
    175c:	fd442783          	lw	a5,-44(s0)
    1760:	0007871b          	sext.w	a4,a5
    1764:	07000793          	li	a5,112
    1768:	02f71063          	bne	a4,a5,1788 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
    176c:	fb843783          	ld	a5,-72(s0)
    1770:	00878713          	addi	a4,a5,8
    1774:	fae43c23          	sd	a4,-72(s0)
    1778:	6398                	ld	a4,0(a5)
    177a:	fcc42783          	lw	a5,-52(s0)
    177e:	85ba                	mv	a1,a4
    1780:	853e                	mv	a0,a5
    1782:	c09ff0ef          	jal	138a <printptr>
    1786:	a8d1                	j	185a <vprintf+0x452>
      } else if(c0 == 'c'){
    1788:	fd442783          	lw	a5,-44(s0)
    178c:	0007871b          	sext.w	a4,a5
    1790:	06300793          	li	a5,99
    1794:	02f71263          	bne	a4,a5,17b8 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
    1798:	fb843783          	ld	a5,-72(s0)
    179c:	00878713          	addi	a4,a5,8
    17a0:	fae43c23          	sd	a4,-72(s0)
    17a4:	439c                	lw	a5,0(a5)
    17a6:	0ff7f713          	zext.b	a4,a5
    17aa:	fcc42783          	lw	a5,-52(s0)
    17ae:	85ba                	mv	a1,a4
    17b0:	853e                	mv	a0,a5
    17b2:	ab5ff0ef          	jal	1266 <putc>
    17b6:	a055                	j	185a <vprintf+0x452>
      } else if(c0 == 's'){
    17b8:	fd442783          	lw	a5,-44(s0)
    17bc:	0007871b          	sext.w	a4,a5
    17c0:	07300793          	li	a5,115
    17c4:	04f71a63          	bne	a4,a5,1818 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
    17c8:	fb843783          	ld	a5,-72(s0)
    17cc:	00878713          	addi	a4,a5,8
    17d0:	fae43c23          	sd	a4,-72(s0)
    17d4:	639c                	ld	a5,0(a5)
    17d6:	fef43423          	sd	a5,-24(s0)
    17da:	fe843783          	ld	a5,-24(s0)
    17de:	e79d                	bnez	a5,180c <vprintf+0x404>
          s = "(null)";
    17e0:	00000797          	auipc	a5,0x0
    17e4:	73878793          	addi	a5,a5,1848 # 1f18 <malloc+0x456>
    17e8:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
    17ec:	a005                	j	180c <vprintf+0x404>
          putc(fd, *s);
    17ee:	fe843783          	ld	a5,-24(s0)
    17f2:	0007c703          	lbu	a4,0(a5)
    17f6:	fcc42783          	lw	a5,-52(s0)
    17fa:	85ba                	mv	a1,a4
    17fc:	853e                	mv	a0,a5
    17fe:	a69ff0ef          	jal	1266 <putc>
        for(; *s; s++)
    1802:	fe843783          	ld	a5,-24(s0)
    1806:	0785                	addi	a5,a5,1
    1808:	fef43423          	sd	a5,-24(s0)
    180c:	fe843783          	ld	a5,-24(s0)
    1810:	0007c783          	lbu	a5,0(a5)
    1814:	ffe9                	bnez	a5,17ee <vprintf+0x3e6>
    1816:	a091                	j	185a <vprintf+0x452>
      } else if(c0 == '%'){
    1818:	fd442783          	lw	a5,-44(s0)
    181c:	0007871b          	sext.w	a4,a5
    1820:	02500793          	li	a5,37
    1824:	00f71a63          	bne	a4,a5,1838 <vprintf+0x430>
        putc(fd, '%');
    1828:	fcc42783          	lw	a5,-52(s0)
    182c:	02500593          	li	a1,37
    1830:	853e                	mv	a0,a5
    1832:	a35ff0ef          	jal	1266 <putc>
    1836:	a015                	j	185a <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1838:	fcc42783          	lw	a5,-52(s0)
    183c:	02500593          	li	a1,37
    1840:	853e                	mv	a0,a5
    1842:	a25ff0ef          	jal	1266 <putc>
        putc(fd, c0);
    1846:	fd442783          	lw	a5,-44(s0)
    184a:	0ff7f713          	zext.b	a4,a5
    184e:	fcc42783          	lw	a5,-52(s0)
    1852:	85ba                	mv	a1,a4
    1854:	853e                	mv	a0,a5
    1856:	a11ff0ef          	jal	1266 <putc>
      }

      state = 0;
    185a:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    185e:	fdc42783          	lw	a5,-36(s0)
    1862:	2785                	addiw	a5,a5,1
    1864:	fcf42e23          	sw	a5,-36(s0)
    1868:	fdc42783          	lw	a5,-36(s0)
    186c:	fc043703          	ld	a4,-64(s0)
    1870:	97ba                	add	a5,a5,a4
    1872:	0007c783          	lbu	a5,0(a5)
    1876:	ba0799e3          	bnez	a5,1428 <vprintf+0x20>
    }
  }
}
    187a:	0001                	nop
    187c:	0001                	nop
    187e:	60a6                	ld	ra,72(sp)
    1880:	6406                	ld	s0,64(sp)
    1882:	6161                	addi	sp,sp,80
    1884:	8082                	ret

0000000000001886 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1886:	7159                	addi	sp,sp,-112
    1888:	fc06                	sd	ra,56(sp)
    188a:	f822                	sd	s0,48(sp)
    188c:	0080                	addi	s0,sp,64
    188e:	fcb43823          	sd	a1,-48(s0)
    1892:	e010                	sd	a2,0(s0)
    1894:	e414                	sd	a3,8(s0)
    1896:	e818                	sd	a4,16(s0)
    1898:	ec1c                	sd	a5,24(s0)
    189a:	03043023          	sd	a6,32(s0)
    189e:	03143423          	sd	a7,40(s0)
    18a2:	87aa                	mv	a5,a0
    18a4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    18a8:	03040793          	addi	a5,s0,48
    18ac:	fcf43423          	sd	a5,-56(s0)
    18b0:	fc843783          	ld	a5,-56(s0)
    18b4:	fd078793          	addi	a5,a5,-48
    18b8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    18bc:	fe843703          	ld	a4,-24(s0)
    18c0:	fdc42783          	lw	a5,-36(s0)
    18c4:	863a                	mv	a2,a4
    18c6:	fd043583          	ld	a1,-48(s0)
    18ca:	853e                	mv	a0,a5
    18cc:	b3dff0ef          	jal	1408 <vprintf>
}
    18d0:	0001                	nop
    18d2:	70e2                	ld	ra,56(sp)
    18d4:	7442                	ld	s0,48(sp)
    18d6:	6165                	addi	sp,sp,112
    18d8:	8082                	ret

00000000000018da <printf>:

void
printf(const char *fmt, ...)
{
    18da:	7159                	addi	sp,sp,-112
    18dc:	f406                	sd	ra,40(sp)
    18de:	f022                	sd	s0,32(sp)
    18e0:	1800                	addi	s0,sp,48
    18e2:	fca43c23          	sd	a0,-40(s0)
    18e6:	e40c                	sd	a1,8(s0)
    18e8:	e810                	sd	a2,16(s0)
    18ea:	ec14                	sd	a3,24(s0)
    18ec:	f018                	sd	a4,32(s0)
    18ee:	f41c                	sd	a5,40(s0)
    18f0:	03043823          	sd	a6,48(s0)
    18f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    18f8:	04040793          	addi	a5,s0,64
    18fc:	fcf43823          	sd	a5,-48(s0)
    1900:	fd043783          	ld	a5,-48(s0)
    1904:	fc878793          	addi	a5,a5,-56
    1908:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    190c:	fe843783          	ld	a5,-24(s0)
    1910:	863e                	mv	a2,a5
    1912:	fd843583          	ld	a1,-40(s0)
    1916:	4505                	li	a0,1
    1918:	af1ff0ef          	jal	1408 <vprintf>
}
    191c:	0001                	nop
    191e:	70a2                	ld	ra,40(sp)
    1920:	7402                	ld	s0,32(sp)
    1922:	6165                	addi	sp,sp,112
    1924:	8082                	ret

0000000000001926 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1926:	7179                	addi	sp,sp,-48
    1928:	f406                	sd	ra,40(sp)
    192a:	f022                	sd	s0,32(sp)
    192c:	1800                	addi	s0,sp,48
    192e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1932:	fd843783          	ld	a5,-40(s0)
    1936:	17c1                	addi	a5,a5,-16
    1938:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    193c:	00001797          	auipc	a5,0x1
    1940:	aec78793          	addi	a5,a5,-1300 # 2428 <freep>
    1944:	639c                	ld	a5,0(a5)
    1946:	fef43423          	sd	a5,-24(s0)
    194a:	a815                	j	197e <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    194c:	fe843783          	ld	a5,-24(s0)
    1950:	639c                	ld	a5,0(a5)
    1952:	fe843703          	ld	a4,-24(s0)
    1956:	00f76f63          	bltu	a4,a5,1974 <free+0x4e>
    195a:	fe043703          	ld	a4,-32(s0)
    195e:	fe843783          	ld	a5,-24(s0)
    1962:	02e7eb63          	bltu	a5,a4,1998 <free+0x72>
    1966:	fe843783          	ld	a5,-24(s0)
    196a:	639c                	ld	a5,0(a5)
    196c:	fe043703          	ld	a4,-32(s0)
    1970:	02f76463          	bltu	a4,a5,1998 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1974:	fe843783          	ld	a5,-24(s0)
    1978:	639c                	ld	a5,0(a5)
    197a:	fef43423          	sd	a5,-24(s0)
    197e:	fe043703          	ld	a4,-32(s0)
    1982:	fe843783          	ld	a5,-24(s0)
    1986:	fce7f3e3          	bgeu	a5,a4,194c <free+0x26>
    198a:	fe843783          	ld	a5,-24(s0)
    198e:	639c                	ld	a5,0(a5)
    1990:	fe043703          	ld	a4,-32(s0)
    1994:	faf77ce3          	bgeu	a4,a5,194c <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1998:	fe043783          	ld	a5,-32(s0)
    199c:	479c                	lw	a5,8(a5)
    199e:	1782                	slli	a5,a5,0x20
    19a0:	9381                	srli	a5,a5,0x20
    19a2:	0792                	slli	a5,a5,0x4
    19a4:	fe043703          	ld	a4,-32(s0)
    19a8:	973e                	add	a4,a4,a5
    19aa:	fe843783          	ld	a5,-24(s0)
    19ae:	639c                	ld	a5,0(a5)
    19b0:	02f71763          	bne	a4,a5,19de <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    19b4:	fe043783          	ld	a5,-32(s0)
    19b8:	4798                	lw	a4,8(a5)
    19ba:	fe843783          	ld	a5,-24(s0)
    19be:	639c                	ld	a5,0(a5)
    19c0:	479c                	lw	a5,8(a5)
    19c2:	9fb9                	addw	a5,a5,a4
    19c4:	0007871b          	sext.w	a4,a5
    19c8:	fe043783          	ld	a5,-32(s0)
    19cc:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    19ce:	fe843783          	ld	a5,-24(s0)
    19d2:	639c                	ld	a5,0(a5)
    19d4:	6398                	ld	a4,0(a5)
    19d6:	fe043783          	ld	a5,-32(s0)
    19da:	e398                	sd	a4,0(a5)
    19dc:	a039                	j	19ea <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    19de:	fe843783          	ld	a5,-24(s0)
    19e2:	6398                	ld	a4,0(a5)
    19e4:	fe043783          	ld	a5,-32(s0)
    19e8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    19ea:	fe843783          	ld	a5,-24(s0)
    19ee:	479c                	lw	a5,8(a5)
    19f0:	1782                	slli	a5,a5,0x20
    19f2:	9381                	srli	a5,a5,0x20
    19f4:	0792                	slli	a5,a5,0x4
    19f6:	fe843703          	ld	a4,-24(s0)
    19fa:	97ba                	add	a5,a5,a4
    19fc:	fe043703          	ld	a4,-32(s0)
    1a00:	02f71563          	bne	a4,a5,1a2a <free+0x104>
    p->s.size += bp->s.size;
    1a04:	fe843783          	ld	a5,-24(s0)
    1a08:	4798                	lw	a4,8(a5)
    1a0a:	fe043783          	ld	a5,-32(s0)
    1a0e:	479c                	lw	a5,8(a5)
    1a10:	9fb9                	addw	a5,a5,a4
    1a12:	0007871b          	sext.w	a4,a5
    1a16:	fe843783          	ld	a5,-24(s0)
    1a1a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1a1c:	fe043783          	ld	a5,-32(s0)
    1a20:	6398                	ld	a4,0(a5)
    1a22:	fe843783          	ld	a5,-24(s0)
    1a26:	e398                	sd	a4,0(a5)
    1a28:	a031                	j	1a34 <free+0x10e>
  } else
    p->s.ptr = bp;
    1a2a:	fe843783          	ld	a5,-24(s0)
    1a2e:	fe043703          	ld	a4,-32(s0)
    1a32:	e398                	sd	a4,0(a5)
  freep = p;
    1a34:	00001797          	auipc	a5,0x1
    1a38:	9f478793          	addi	a5,a5,-1548 # 2428 <freep>
    1a3c:	fe843703          	ld	a4,-24(s0)
    1a40:	e398                	sd	a4,0(a5)
}
    1a42:	0001                	nop
    1a44:	70a2                	ld	ra,40(sp)
    1a46:	7402                	ld	s0,32(sp)
    1a48:	6145                	addi	sp,sp,48
    1a4a:	8082                	ret

0000000000001a4c <morecore>:

static Header*
morecore(uint nu)
{
    1a4c:	7179                	addi	sp,sp,-48
    1a4e:	f406                	sd	ra,40(sp)
    1a50:	f022                	sd	s0,32(sp)
    1a52:	1800                	addi	s0,sp,48
    1a54:	87aa                	mv	a5,a0
    1a56:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1a5a:	fdc42783          	lw	a5,-36(s0)
    1a5e:	0007871b          	sext.w	a4,a5
    1a62:	6785                	lui	a5,0x1
    1a64:	00f77563          	bgeu	a4,a5,1a6e <morecore+0x22>
    nu = 4096;
    1a68:	6785                	lui	a5,0x1
    1a6a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1a6e:	fdc42783          	lw	a5,-36(s0)
    1a72:	0047979b          	slliw	a5,a5,0x4
    1a76:	2781                	sext.w	a5,a5
    1a78:	853e                	mv	a0,a5
    1a7a:	ee8ff0ef          	jal	1162 <sbrk>
    1a7e:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    1a82:	fe843703          	ld	a4,-24(s0)
    1a86:	57fd                	li	a5,-1
    1a88:	00f71463          	bne	a4,a5,1a90 <morecore+0x44>
    return 0;
    1a8c:	4781                	li	a5,0
    1a8e:	a02d                	j	1ab8 <morecore+0x6c>
  hp = (Header*)p;
    1a90:	fe843783          	ld	a5,-24(s0)
    1a94:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1a98:	fe043783          	ld	a5,-32(s0)
    1a9c:	fdc42703          	lw	a4,-36(s0)
    1aa0:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1aa2:	fe043783          	ld	a5,-32(s0)
    1aa6:	07c1                	addi	a5,a5,16 # 1010 <memmove+0x30>
    1aa8:	853e                	mv	a0,a5
    1aaa:	e7dff0ef          	jal	1926 <free>
  return freep;
    1aae:	00001797          	auipc	a5,0x1
    1ab2:	97a78793          	addi	a5,a5,-1670 # 2428 <freep>
    1ab6:	639c                	ld	a5,0(a5)
}
    1ab8:	853e                	mv	a0,a5
    1aba:	70a2                	ld	ra,40(sp)
    1abc:	7402                	ld	s0,32(sp)
    1abe:	6145                	addi	sp,sp,48
    1ac0:	8082                	ret

0000000000001ac2 <malloc>:

void*
malloc(uint nbytes)
{
    1ac2:	7139                	addi	sp,sp,-64
    1ac4:	fc06                	sd	ra,56(sp)
    1ac6:	f822                	sd	s0,48(sp)
    1ac8:	0080                	addi	s0,sp,64
    1aca:	87aa                	mv	a5,a0
    1acc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ad0:	fcc46783          	lwu	a5,-52(s0)
    1ad4:	07bd                	addi	a5,a5,15
    1ad6:	8391                	srli	a5,a5,0x4
    1ad8:	2781                	sext.w	a5,a5
    1ada:	2785                	addiw	a5,a5,1
    1adc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1ae0:	00001797          	auipc	a5,0x1
    1ae4:	94878793          	addi	a5,a5,-1720 # 2428 <freep>
    1ae8:	639c                	ld	a5,0(a5)
    1aea:	fef43023          	sd	a5,-32(s0)
    1aee:	fe043783          	ld	a5,-32(s0)
    1af2:	ef95                	bnez	a5,1b2e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1af4:	00001797          	auipc	a5,0x1
    1af8:	92478793          	addi	a5,a5,-1756 # 2418 <base>
    1afc:	fef43023          	sd	a5,-32(s0)
    1b00:	00001797          	auipc	a5,0x1
    1b04:	92878793          	addi	a5,a5,-1752 # 2428 <freep>
    1b08:	fe043703          	ld	a4,-32(s0)
    1b0c:	e398                	sd	a4,0(a5)
    1b0e:	00001797          	auipc	a5,0x1
    1b12:	91a78793          	addi	a5,a5,-1766 # 2428 <freep>
    1b16:	6398                	ld	a4,0(a5)
    1b18:	00001797          	auipc	a5,0x1
    1b1c:	90078793          	addi	a5,a5,-1792 # 2418 <base>
    1b20:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1b22:	00001797          	auipc	a5,0x1
    1b26:	8f678793          	addi	a5,a5,-1802 # 2418 <base>
    1b2a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b2e:	fe043783          	ld	a5,-32(s0)
    1b32:	639c                	ld	a5,0(a5)
    1b34:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1b38:	fe843783          	ld	a5,-24(s0)
    1b3c:	479c                	lw	a5,8(a5)
    1b3e:	fdc42703          	lw	a4,-36(s0)
    1b42:	2701                	sext.w	a4,a4
    1b44:	06e7e763          	bltu	a5,a4,1bb2 <malloc+0xf0>
      if(p->s.size == nunits)
    1b48:	fe843783          	ld	a5,-24(s0)
    1b4c:	479c                	lw	a5,8(a5)
    1b4e:	fdc42703          	lw	a4,-36(s0)
    1b52:	2701                	sext.w	a4,a4
    1b54:	00f71963          	bne	a4,a5,1b66 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1b58:	fe843783          	ld	a5,-24(s0)
    1b5c:	6398                	ld	a4,0(a5)
    1b5e:	fe043783          	ld	a5,-32(s0)
    1b62:	e398                	sd	a4,0(a5)
    1b64:	a825                	j	1b9c <malloc+0xda>
      else {
        p->s.size -= nunits;
    1b66:	fe843783          	ld	a5,-24(s0)
    1b6a:	479c                	lw	a5,8(a5)
    1b6c:	fdc42703          	lw	a4,-36(s0)
    1b70:	9f99                	subw	a5,a5,a4
    1b72:	0007871b          	sext.w	a4,a5
    1b76:	fe843783          	ld	a5,-24(s0)
    1b7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1b7c:	fe843783          	ld	a5,-24(s0)
    1b80:	479c                	lw	a5,8(a5)
    1b82:	1782                	slli	a5,a5,0x20
    1b84:	9381                	srli	a5,a5,0x20
    1b86:	0792                	slli	a5,a5,0x4
    1b88:	fe843703          	ld	a4,-24(s0)
    1b8c:	97ba                	add	a5,a5,a4
    1b8e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1b92:	fe843783          	ld	a5,-24(s0)
    1b96:	fdc42703          	lw	a4,-36(s0)
    1b9a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1b9c:	00001797          	auipc	a5,0x1
    1ba0:	88c78793          	addi	a5,a5,-1908 # 2428 <freep>
    1ba4:	fe043703          	ld	a4,-32(s0)
    1ba8:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1baa:	fe843783          	ld	a5,-24(s0)
    1bae:	07c1                	addi	a5,a5,16
    1bb0:	a081                	j	1bf0 <malloc+0x12e>
    }
    if(p == freep)
    1bb2:	00001797          	auipc	a5,0x1
    1bb6:	87678793          	addi	a5,a5,-1930 # 2428 <freep>
    1bba:	639c                	ld	a5,0(a5)
    1bbc:	fe843703          	ld	a4,-24(s0)
    1bc0:	00f71e63          	bne	a4,a5,1bdc <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1bc4:	fdc42783          	lw	a5,-36(s0)
    1bc8:	853e                	mv	a0,a5
    1bca:	e83ff0ef          	jal	1a4c <morecore>
    1bce:	fea43423          	sd	a0,-24(s0)
    1bd2:	fe843783          	ld	a5,-24(s0)
    1bd6:	e399                	bnez	a5,1bdc <malloc+0x11a>
        return 0;
    1bd8:	4781                	li	a5,0
    1bda:	a819                	j	1bf0 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1bdc:	fe843783          	ld	a5,-24(s0)
    1be0:	fef43023          	sd	a5,-32(s0)
    1be4:	fe843783          	ld	a5,-24(s0)
    1be8:	639c                	ld	a5,0(a5)
    1bea:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1bee:	b7a9                	j	1b38 <malloc+0x76>
  }
}
    1bf0:	853e                	mv	a0,a5
    1bf2:	70e2                	ld	ra,56(sp)
    1bf4:	7442                	ld	s0,48(sp)
    1bf6:	6121                	addi	sp,sp,64
    1bf8:	8082                	ret
