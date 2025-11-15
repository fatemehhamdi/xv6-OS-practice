
user/_top:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <itoa>:
#define MAX_PROCS 64

// --- توابع کمکی برای تبدیل عدد به رشته ---

// پیاده‌سازی ساده itoa (integer to ASCII) برای اعداد مثبت
void itoa(int n, char *buf) {
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  char temp[12];
  int i = 0;
      12:	fe042623          	sw	zero,-20(s0)
  if (n == 0) {
      16:	fcc42783          	lw	a5,-52(s0)
      1a:	2781                	sext.w	a5,a5
      1c:	efd9                	bnez	a5,ba <itoa+0xba>
    buf[0] = '0';
      1e:	fc043783          	ld	a5,-64(s0)
      22:	03000713          	li	a4,48
      26:	00e78023          	sb	a4,0(a5)
    buf[1] = '\0';
      2a:	fc043783          	ld	a5,-64(s0)
      2e:	0785                	addi	a5,a5,1
      30:	00078023          	sb	zero,0(a5)
      34:	a8f1                	j	110 <itoa+0x110>
    return;
  }
  while (n > 0) {
    temp[i++] = (n % 10) + '0';
      36:	fcc42783          	lw	a5,-52(s0)
      3a:	873e                	mv	a4,a5
      3c:	0007069b          	sext.w	a3,a4
      40:	666667b7          	lui	a5,0x66666
      44:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x66664607>
      48:	02f687b3          	mul	a5,a3,a5
      4c:	9381                	srli	a5,a5,0x20
      4e:	4027d79b          	sraiw	a5,a5,0x2
      52:	86be                	mv	a3,a5
      54:	41f7579b          	sraiw	a5,a4,0x1f
      58:	40f687bb          	subw	a5,a3,a5
      5c:	86be                	mv	a3,a5
      5e:	87b6                	mv	a5,a3
      60:	0027979b          	slliw	a5,a5,0x2
      64:	9fb5                	addw	a5,a5,a3
      66:	0017979b          	slliw	a5,a5,0x1
      6a:	40f707bb          	subw	a5,a4,a5
      6e:	2781                	sext.w	a5,a5
      70:	0ff7f713          	zext.b	a4,a5
      74:	fec42783          	lw	a5,-20(s0)
      78:	0017869b          	addiw	a3,a5,1
      7c:	fed42623          	sw	a3,-20(s0)
      80:	0307071b          	addiw	a4,a4,48
      84:	0ff77713          	zext.b	a4,a4
      88:	17c1                	addi	a5,a5,-16
      8a:	97a2                	add	a5,a5,s0
      8c:	fee78423          	sb	a4,-24(a5)
    n /= 10;
      90:	fcc42783          	lw	a5,-52(s0)
      94:	86be                	mv	a3,a5
      96:	0006871b          	sext.w	a4,a3
      9a:	666667b7          	lui	a5,0x66666
      9e:	66778793          	addi	a5,a5,1639 # 66666667 <freep+0x66664607>
      a2:	02f707b3          	mul	a5,a4,a5
      a6:	9381                	srli	a5,a5,0x20
      a8:	4027d79b          	sraiw	a5,a5,0x2
      ac:	873e                	mv	a4,a5
      ae:	41f6d79b          	sraiw	a5,a3,0x1f
      b2:	40f707bb          	subw	a5,a4,a5
      b6:	fcf42623          	sw	a5,-52(s0)
  while (n > 0) {
      ba:	fcc42783          	lw	a5,-52(s0)
      be:	2781                	sext.w	a5,a5
      c0:	f6f04be3          	bgtz	a5,36 <itoa+0x36>
  }
  int j = 0;
      c4:	fe042423          	sw	zero,-24(s0)
  while (i > 0) {
      c8:	a805                	j	f8 <itoa+0xf8>
    buf[j++] = temp[--i];
      ca:	fec42783          	lw	a5,-20(s0)
      ce:	37fd                	addiw	a5,a5,-1
      d0:	fef42623          	sw	a5,-20(s0)
      d4:	fe842783          	lw	a5,-24(s0)
      d8:	0017871b          	addiw	a4,a5,1
      dc:	fee42423          	sw	a4,-24(s0)
      e0:	873e                	mv	a4,a5
      e2:	fc043783          	ld	a5,-64(s0)
      e6:	97ba                	add	a5,a5,a4
      e8:	fec42703          	lw	a4,-20(s0)
      ec:	1741                	addi	a4,a4,-16
      ee:	9722                	add	a4,a4,s0
      f0:	fe874703          	lbu	a4,-24(a4)
      f4:	00e78023          	sb	a4,0(a5)
  while (i > 0) {
      f8:	fec42783          	lw	a5,-20(s0)
      fc:	2781                	sext.w	a5,a5
      fe:	fcf046e3          	bgtz	a5,ca <itoa+0xca>
  }
  buf[j] = '\0';
     102:	fe842783          	lw	a5,-24(s0)
     106:	fc043703          	ld	a4,-64(s0)
     10a:	97ba                	add	a5,a5,a4
     10c:	00078023          	sb	zero,0(a5)
}
     110:	70e2                	ld	ra,56(sp)
     112:	7442                	ld	s0,48(sp)
     114:	6121                	addi	sp,sp,64
     116:	8082                	ret

0000000000000118 <uitoa64>:

// پیاده‌سازی ساده uitoa64 (unsigned 64-bit integer to ASCII) برای فیلد size
void uitoa64(uint64 n, char *buf) {
     118:	7139                	addi	sp,sp,-64
     11a:	fc06                	sd	ra,56(sp)
     11c:	f822                	sd	s0,48(sp)
     11e:	0080                	addi	s0,sp,64
     120:	fca43423          	sd	a0,-56(s0)
     124:	fcb43023          	sd	a1,-64(s0)
  char temp[21]; // uint64 حداکثر ۲۰ رقم دارد
  int i = 0;
     128:	fe042623          	sw	zero,-20(s0)
  if (n == 0) {
     12c:	fc843783          	ld	a5,-56(s0)
     130:	ebb5                	bnez	a5,1a4 <uitoa64+0x8c>
    buf[0] = '0';
     132:	fc043783          	ld	a5,-64(s0)
     136:	03000713          	li	a4,48
     13a:	00e78023          	sb	a4,0(a5)
    buf[1] = '\0';
     13e:	fc043783          	ld	a5,-64(s0)
     142:	0785                	addi	a5,a5,1
     144:	00078023          	sb	zero,0(a5)
     148:	a07d                	j	1f6 <uitoa64+0xde>
    return;
  }
  while (n > 0) {
    temp[i++] = (n % 10) + '0';
     14a:	fc843683          	ld	a3,-56(s0)
     14e:	00001797          	auipc	a5,0x1
     152:	61a78793          	addi	a5,a5,1562 # 1768 <malloc+0x25c>
     156:	639c                	ld	a5,0(a5)
     158:	02f6b7b3          	mulhu	a5,a3,a5
     15c:	0037d713          	srli	a4,a5,0x3
     160:	87ba                	mv	a5,a4
     162:	078a                	slli	a5,a5,0x2
     164:	97ba                	add	a5,a5,a4
     166:	0786                	slli	a5,a5,0x1
     168:	40f68733          	sub	a4,a3,a5
     16c:	0ff77713          	zext.b	a4,a4
     170:	fec42783          	lw	a5,-20(s0)
     174:	0017869b          	addiw	a3,a5,1
     178:	fed42623          	sw	a3,-20(s0)
     17c:	0307071b          	addiw	a4,a4,48
     180:	0ff77713          	zext.b	a4,a4
     184:	17c1                	addi	a5,a5,-16
     186:	97a2                	add	a5,a5,s0
     188:	fee78023          	sb	a4,-32(a5)
    n /= 10;
     18c:	fc843703          	ld	a4,-56(s0)
     190:	00001797          	auipc	a5,0x1
     194:	5d878793          	addi	a5,a5,1496 # 1768 <malloc+0x25c>
     198:	639c                	ld	a5,0(a5)
     19a:	02f737b3          	mulhu	a5,a4,a5
     19e:	838d                	srli	a5,a5,0x3
     1a0:	fcf43423          	sd	a5,-56(s0)
  while (n > 0) {
     1a4:	fc843783          	ld	a5,-56(s0)
     1a8:	f3cd                	bnez	a5,14a <uitoa64+0x32>
  }
  int j = 0;
     1aa:	fe042423          	sw	zero,-24(s0)
  while (i > 0) {
     1ae:	a805                	j	1de <uitoa64+0xc6>
    buf[j++] = temp[--i];
     1b0:	fec42783          	lw	a5,-20(s0)
     1b4:	37fd                	addiw	a5,a5,-1
     1b6:	fef42623          	sw	a5,-20(s0)
     1ba:	fe842783          	lw	a5,-24(s0)
     1be:	0017871b          	addiw	a4,a5,1
     1c2:	fee42423          	sw	a4,-24(s0)
     1c6:	873e                	mv	a4,a5
     1c8:	fc043783          	ld	a5,-64(s0)
     1cc:	97ba                	add	a5,a5,a4
     1ce:	fec42703          	lw	a4,-20(s0)
     1d2:	1741                	addi	a4,a4,-16
     1d4:	9722                	add	a4,a4,s0
     1d6:	fe074703          	lbu	a4,-32(a4)
     1da:	00e78023          	sb	a4,0(a5)
  while (i > 0) {
     1de:	fec42783          	lw	a5,-20(s0)
     1e2:	2781                	sext.w	a5,a5
     1e4:	fcf046e3          	bgtz	a5,1b0 <uitoa64+0x98>
  }
  buf[j] = '\0';
     1e8:	fe842783          	lw	a5,-24(s0)
     1ec:	fc043703          	ld	a4,-64(s0)
     1f0:	97ba                	add	a5,a5,a4
     1f2:	00078023          	sb	zero,0(a5)
}
     1f6:	70e2                	ld	ra,56(sp)
     1f8:	7442                	ld	s0,48(sp)
     1fa:	6121                	addi	sp,sp,64
     1fc:	8082                	ret

00000000000001fe <get_state_str>:

// --- توابع اصلی برنامه ---

// تابع کمکی برای تبدیل وضعیت به رشته
const char*
get_state_str(enum procstate state) {
     1fe:	1101                	addi	sp,sp,-32
     200:	ec06                	sd	ra,24(sp)
     202:	e822                	sd	s0,16(sp)
     204:	1000                	addi	s0,sp,32
     206:	87aa                	mv	a5,a0
     208:	fef42623          	sw	a5,-20(s0)
  static const char *states[] = {
    [UNUSED]   "Unused",   [USED]   "Used",
    [SLEEPING] "Sleeping", [RUNNABLE] "Runnable",
    [RUNNING]  "Running",  [ZOMBIE]   "Zombie"
  };
  if (state >= 0 && state < sizeof(states)/sizeof(states[0]))
     20c:	fec42783          	lw	a5,-20(s0)
     210:	0007871b          	sext.w	a4,a5
     214:	4795                	li	a5,5
     216:	00e7ec63          	bltu	a5,a4,22e <get_state_str+0x30>
    return states[state];
     21a:	00002717          	auipc	a4,0x2
     21e:	de670713          	addi	a4,a4,-538 # 2000 <states.0>
     222:	fec46783          	lwu	a5,-20(s0)
     226:	078e                	slli	a5,a5,0x3
     228:	97ba                	add	a5,a5,a4
     22a:	639c                	ld	a5,0(a5)
     22c:	a029                	j	236 <get_state_str+0x38>
  return "???";
     22e:	00001797          	auipc	a5,0x1
     232:	42278793          	addi	a5,a5,1058 # 1650 <malloc+0x144>
}
     236:	853e                	mv	a0,a5
     238:	60e2                	ld	ra,24(sp)
     23a:	6442                	ld	s0,16(sp)
     23c:	6105                	addi	sp,sp,32
     23e:	8082                	ret

0000000000000240 <run_top_list>:

// تابع برای چاپ لیست ساده فرآیندها (اصلاح شده)
void run_top_list() {
     240:	7159                	addi	sp,sp,-112
     242:	f486                	sd	ra,104(sp)
     244:	f0a2                	sd	s0,96(sp)
     246:	1880                	addi	s0,sp,112
     248:	81010113          	addi	sp,sp,-2032
  struct process_data all_procs[MAX_PROCS];
  int count = 0;
     24c:	fe042623          	sw	zero,-20(s0)
  int last_pid = -1;
     250:	57fd                	li	a5,-1
     252:	fef42423          	sw	a5,-24(s0)

  while (count < MAX_PROCS) {
     256:	a089                	j	298 <run_top_list+0x58>
    int next_pid = next_process(last_pid, &all_procs[count]);
     258:	77fd                	lui	a5,0xfffff
     25a:	7e878793          	addi	a5,a5,2024 # fffffffffffff7e8 <freep+0xffffffffffffd788>
     25e:	17c1                	addi	a5,a5,-16
     260:	00878733          	add	a4,a5,s0
     264:	fec42783          	lw	a5,-20(s0)
     268:	0796                	slli	a5,a5,0x5
     26a:	973e                	add	a4,a4,a5
     26c:	fe842783          	lw	a5,-24(s0)
     270:	85ba                	mv	a1,a4
     272:	853e                	mv	a0,a5
     274:	235000ef          	jal	ca8 <next_process>
     278:	87aa                	mv	a5,a0
     27a:	fef42023          	sw	a5,-32(s0)
    if (next_pid == 0) break;
     27e:	fe042783          	lw	a5,-32(s0)
     282:	2781                	sext.w	a5,a5
     284:	c39d                	beqz	a5,2aa <run_top_list+0x6a>
    last_pid = next_pid;
     286:	fe042783          	lw	a5,-32(s0)
     28a:	fef42423          	sw	a5,-24(s0)
    count++;
     28e:	fec42783          	lw	a5,-20(s0)
     292:	2785                	addiw	a5,a5,1
     294:	fef42623          	sw	a5,-20(s0)
  while (count < MAX_PROCS) {
     298:	fec42783          	lw	a5,-20(s0)
     29c:	0007871b          	sext.w	a4,a5
     2a0:	03f00793          	li	a5,63
     2a4:	fae7dae3          	bge	a5,a4,258 <run_top_list+0x18>
     2a8:	a011                	j	2ac <run_top_list+0x6c>
    if (next_pid == 0) break;
     2aa:	0001                	nop
  }

  printf("PID\tPPID\tSTATE\t\tSIZE\t\tNAME\n");
     2ac:	00001517          	auipc	a0,0x1
     2b0:	3ac50513          	addi	a0,a0,940 # 1658 <malloc+0x14c>
     2b4:	070010ef          	jal	1324 <printf>
  printf("----------------------------------------------------------\n");
     2b8:	00001517          	auipc	a0,0x1
     2bc:	3c050513          	addi	a0,a0,960 # 1678 <malloc+0x16c>
     2c0:	064010ef          	jal	1324 <printf>
  
  for (int i = 0; i < count; i++) {
     2c4:	fe042223          	sw	zero,-28(s0)
     2c8:	a215                	j	3ec <run_top_list+0x1ac>
    char pid_buf[12], ppid_buf[12], size_buf[21];
    
    // تبدیل اعداد به رشته قبل از چاپ
    itoa(all_procs[i].pid, pid_buf);
     2ca:	77fd                	lui	a5,0xfffff
     2cc:	17c1                	addi	a5,a5,-16 # ffffffffffffeff0 <freep+0xffffffffffffcf90>
     2ce:	00878733          	add	a4,a5,s0
     2d2:	fe442783          	lw	a5,-28(s0)
     2d6:	0796                	slli	a5,a5,0x5
     2d8:	97ba                	add	a5,a5,a4
     2da:	7e87a703          	lw	a4,2024(a5)
     2de:	77fd                	lui	a5,0xfffff
     2e0:	7d878793          	addi	a5,a5,2008 # fffffffffffff7d8 <freep+0xffffffffffffd778>
     2e4:	17c1                	addi	a5,a5,-16
     2e6:	97a2                	add	a5,a5,s0
     2e8:	85be                	mv	a1,a5
     2ea:	853a                	mv	a0,a4
     2ec:	d15ff0ef          	jal	0 <itoa>
    itoa(all_procs[i].parent_id, ppid_buf);
     2f0:	77fd                	lui	a5,0xfffff
     2f2:	17c1                	addi	a5,a5,-16 # ffffffffffffeff0 <freep+0xffffffffffffcf90>
     2f4:	00878733          	add	a4,a5,s0
     2f8:	fe442783          	lw	a5,-28(s0)
     2fc:	0796                	slli	a5,a5,0x5
     2fe:	97ba                	add	a5,a5,a4
     300:	7ec7a703          	lw	a4,2028(a5)
     304:	77fd                	lui	a5,0xfffff
     306:	7c878793          	addi	a5,a5,1992 # fffffffffffff7c8 <freep+0xffffffffffffd768>
     30a:	17c1                	addi	a5,a5,-16
     30c:	97a2                	add	a5,a5,s0
     30e:	85be                	mv	a1,a5
     310:	853a                	mv	a0,a4
     312:	cefff0ef          	jal	0 <itoa>
    uitoa64(all_procs[i].size, size_buf);
     316:	77fd                	lui	a5,0xfffff
     318:	17c1                	addi	a5,a5,-16 # ffffffffffffeff0 <freep+0xffffffffffffcf90>
     31a:	00878733          	add	a4,a5,s0
     31e:	fe442783          	lw	a5,-28(s0)
     322:	0796                	slli	a5,a5,0x5
     324:	97ba                	add	a5,a5,a4
     326:	7f07a783          	lw	a5,2032(a5)
     32a:	873e                	mv	a4,a5
     32c:	77fd                	lui	a5,0xfffff
     32e:	7b078793          	addi	a5,a5,1968 # fffffffffffff7b0 <freep+0xffffffffffffd750>
     332:	17c1                	addi	a5,a5,-16
     334:	97a2                	add	a5,a5,s0
     336:	85be                	mv	a1,a5
     338:	853a                	mv	a0,a4
     33a:	ddfff0ef          	jal	118 <uitoa64>
    
    const char* state_str = get_state_str(all_procs[i].state);
     33e:	77fd                	lui	a5,0xfffff
     340:	17c1                	addi	a5,a5,-16 # ffffffffffffeff0 <freep+0xffffffffffffcf90>
     342:	00878733          	add	a4,a5,s0
     346:	fe442783          	lw	a5,-28(s0)
     34a:	0796                	slli	a5,a5,0x5
     34c:	97ba                	add	a5,a5,a4
     34e:	7f47a783          	lw	a5,2036(a5)
     352:	853e                	mv	a0,a5
     354:	eabff0ef          	jal	1fe <get_state_str>
     358:	fca43c23          	sd	a0,-40(s0)
    
    printf("%s\t%s\t%s", pid_buf, ppid_buf, state_str);
     35c:	77fd                	lui	a5,0xfffff
     35e:	7c878793          	addi	a5,a5,1992 # fffffffffffff7c8 <freep+0xffffffffffffd768>
     362:	17c1                	addi	a5,a5,-16
     364:	00878733          	add	a4,a5,s0
     368:	77fd                	lui	a5,0xfffff
     36a:	7d878793          	addi	a5,a5,2008 # fffffffffffff7d8 <freep+0xffffffffffffd778>
     36e:	17c1                	addi	a5,a5,-16
     370:	97a2                	add	a5,a5,s0
     372:	fd843683          	ld	a3,-40(s0)
     376:	863a                	mv	a2,a4
     378:	85be                	mv	a1,a5
     37a:	00001517          	auipc	a0,0x1
     37e:	33e50513          	addi	a0,a0,830 # 16b8 <malloc+0x1ac>
     382:	7a3000ef          	jal	1324 <printf>
    
    // ترفند ساده برای تراز کردن ستون STATE
    if (strlen(state_str) < 8) {
     386:	fd843503          	ld	a0,-40(s0)
     38a:	446000ef          	jal	7d0 <strlen>
     38e:	87aa                	mv	a5,a0
     390:	873e                	mv	a4,a5
     392:	479d                	li	a5,7
     394:	00e7e963          	bltu	a5,a4,3a6 <run_top_list+0x166>
      printf("\t\t");
     398:	00001517          	auipc	a0,0x1
     39c:	33050513          	addi	a0,a0,816 # 16c8 <malloc+0x1bc>
     3a0:	785000ef          	jal	1324 <printf>
     3a4:	a039                	j	3b2 <run_top_list+0x172>
    } else {
      printf("\t");
     3a6:	00001517          	auipc	a0,0x1
     3aa:	32a50513          	addi	a0,a0,810 # 16d0 <malloc+0x1c4>
     3ae:	777000ef          	jal	1324 <printf>
    }
    
    printf("%s\t\t%s\n", size_buf, all_procs[i].name);
     3b2:	77fd                	lui	a5,0xfffff
     3b4:	7e878793          	addi	a5,a5,2024 # fffffffffffff7e8 <freep+0xffffffffffffd788>
     3b8:	17c1                	addi	a5,a5,-16
     3ba:	00878733          	add	a4,a5,s0
     3be:	fe442783          	lw	a5,-28(s0)
     3c2:	0796                	slli	a5,a5,0x5
     3c4:	07c1                	addi	a5,a5,16
     3c6:	973e                	add	a4,a4,a5
     3c8:	77fd                	lui	a5,0xfffff
     3ca:	7b078793          	addi	a5,a5,1968 # fffffffffffff7b0 <freep+0xffffffffffffd750>
     3ce:	17c1                	addi	a5,a5,-16
     3d0:	97a2                	add	a5,a5,s0
     3d2:	863a                	mv	a2,a4
     3d4:	85be                	mv	a1,a5
     3d6:	00001517          	auipc	a0,0x1
     3da:	30250513          	addi	a0,a0,770 # 16d8 <malloc+0x1cc>
     3de:	747000ef          	jal	1324 <printf>
  for (int i = 0; i < count; i++) {
     3e2:	fe442783          	lw	a5,-28(s0)
     3e6:	2785                	addiw	a5,a5,1
     3e8:	fef42223          	sw	a5,-28(s0)
     3ec:	fe442783          	lw	a5,-28(s0)
     3f0:	873e                	mv	a4,a5
     3f2:	fec42783          	lw	a5,-20(s0)
     3f6:	2701                	sext.w	a4,a4
     3f8:	2781                	sext.w	a5,a5
     3fa:	ecf748e3          	blt	a4,a5,2ca <run_top_list+0x8a>
  }
}
     3fe:	0001                	nop
     400:	0001                	nop
     402:	7f010113          	addi	sp,sp,2032
     406:	70a6                	ld	ra,104(sp)
     408:	7406                	ld	s0,96(sp)
     40a:	6165                	addi	sp,sp,112
     40c:	8082                	ret

000000000000040e <print_tree>:

// تابع بازگشتی برای چاپ درخت فرآیندها (اصلاح شده)
void print_tree(struct process_data procs[], int count, int parent_pid, int depth) {
     40e:	715d                	addi	sp,sp,-80
     410:	e486                	sd	ra,72(sp)
     412:	e0a2                	sd	s0,64(sp)
     414:	fc26                	sd	s1,56(sp)
     416:	f84a                	sd	s2,48(sp)
     418:	0880                	addi	s0,sp,80
     41a:	fca43423          	sd	a0,-56(s0)
     41e:	87ae                	mv	a5,a1
     420:	8736                	mv	a4,a3
     422:	fcf42223          	sw	a5,-60(s0)
     426:	87b2                	mv	a5,a2
     428:	fcf42023          	sw	a5,-64(s0)
     42c:	87ba                	mv	a5,a4
     42e:	faf42e23          	sw	a5,-68(s0)
  for (int i = 0; i < count; i++) {
     432:	fc042e23          	sw	zero,-36(s0)
     436:	a8e1                	j	50e <print_tree+0x100>
    // یک فرآیند نمی‌تواند فرزند خودش باشد. این شرط از حلقه بی‌نهایت جلوگیری می‌کند.
    if (procs[i].parent_id == parent_pid && procs[i].pid != parent_pid) {
     438:	fdc42783          	lw	a5,-36(s0)
     43c:	0796                	slli	a5,a5,0x5
     43e:	fc843703          	ld	a4,-56(s0)
     442:	97ba                	add	a5,a5,a4
     444:	43dc                	lw	a5,4(a5)
     446:	fc042703          	lw	a4,-64(s0)
     44a:	2701                	sext.w	a4,a4
     44c:	0af71c63          	bne	a4,a5,504 <print_tree+0xf6>
     450:	fdc42783          	lw	a5,-36(s0)
     454:	0796                	slli	a5,a5,0x5
     456:	fc843703          	ld	a4,-56(s0)
     45a:	97ba                	add	a5,a5,a4
     45c:	439c                	lw	a5,0(a5)
     45e:	fc042703          	lw	a4,-64(s0)
     462:	2701                	sext.w	a4,a4
     464:	0af70063          	beq	a4,a5,504 <print_tree+0xf6>
      for (int d = 0; d < depth; d++) {
     468:	fc042c23          	sw	zero,-40(s0)
     46c:	a821                	j	484 <print_tree+0x76>
        printf("  ");
     46e:	00001517          	auipc	a0,0x1
     472:	27250513          	addi	a0,a0,626 # 16e0 <malloc+0x1d4>
     476:	6af000ef          	jal	1324 <printf>
      for (int d = 0; d < depth; d++) {
     47a:	fd842783          	lw	a5,-40(s0)
     47e:	2785                	addiw	a5,a5,1
     480:	fcf42c23          	sw	a5,-40(s0)
     484:	fd842783          	lw	a5,-40(s0)
     488:	873e                	mv	a4,a5
     48a:	fbc42783          	lw	a5,-68(s0)
     48e:	2701                	sext.w	a4,a4
     490:	2781                	sext.w	a5,a5
     492:	fcf74ee3          	blt	a4,a5,46e <print_tree+0x60>
      }
      printf("|- %d (%s, %s)\n", procs[i].pid, procs[i].name, get_state_str(procs[i].state));
     496:	fdc42783          	lw	a5,-36(s0)
     49a:	0796                	slli	a5,a5,0x5
     49c:	fc843703          	ld	a4,-56(s0)
     4a0:	97ba                	add	a5,a5,a4
     4a2:	4384                	lw	s1,0(a5)
     4a4:	fdc42783          	lw	a5,-36(s0)
     4a8:	0796                	slli	a5,a5,0x5
     4aa:	fc843703          	ld	a4,-56(s0)
     4ae:	97ba                	add	a5,a5,a4
     4b0:	01078913          	addi	s2,a5,16
     4b4:	fdc42783          	lw	a5,-36(s0)
     4b8:	0796                	slli	a5,a5,0x5
     4ba:	fc843703          	ld	a4,-56(s0)
     4be:	97ba                	add	a5,a5,a4
     4c0:	47dc                	lw	a5,12(a5)
     4c2:	853e                	mv	a0,a5
     4c4:	d3bff0ef          	jal	1fe <get_state_str>
     4c8:	87aa                	mv	a5,a0
     4ca:	86be                	mv	a3,a5
     4cc:	864a                	mv	a2,s2
     4ce:	85a6                	mv	a1,s1
     4d0:	00001517          	auipc	a0,0x1
     4d4:	21850513          	addi	a0,a0,536 # 16e8 <malloc+0x1dc>
     4d8:	64d000ef          	jal	1324 <printf>
      print_tree(procs, count, procs[i].pid, depth + 1);
     4dc:	fdc42783          	lw	a5,-36(s0)
     4e0:	0796                	slli	a5,a5,0x5
     4e2:	fc843703          	ld	a4,-56(s0)
     4e6:	97ba                	add	a5,a5,a4
     4e8:	4398                	lw	a4,0(a5)
     4ea:	fbc42783          	lw	a5,-68(s0)
     4ee:	2785                	addiw	a5,a5,1
     4f0:	0007869b          	sext.w	a3,a5
     4f4:	fc442783          	lw	a5,-60(s0)
     4f8:	863a                	mv	a2,a4
     4fa:	85be                	mv	a1,a5
     4fc:	fc843503          	ld	a0,-56(s0)
     500:	f0fff0ef          	jal	40e <print_tree>
  for (int i = 0; i < count; i++) {
     504:	fdc42783          	lw	a5,-36(s0)
     508:	2785                	addiw	a5,a5,1
     50a:	fcf42e23          	sw	a5,-36(s0)
     50e:	fdc42783          	lw	a5,-36(s0)
     512:	873e                	mv	a4,a5
     514:	fc442783          	lw	a5,-60(s0)
     518:	2701                	sext.w	a4,a4
     51a:	2781                	sext.w	a5,a5
     51c:	f0f74ee3          	blt	a4,a5,438 <print_tree+0x2a>
    }
  }
}
     520:	0001                	nop
     522:	0001                	nop
     524:	60a6                	ld	ra,72(sp)
     526:	6406                	ld	s0,64(sp)
     528:	74e2                	ld	s1,56(sp)
     52a:	7942                	ld	s2,48(sp)
     52c:	6161                	addi	sp,sp,80
     52e:	8082                	ret

0000000000000530 <run_top_tree>:

// تابع برای اجرای حالت درختی (بدون تغییر)
void run_top_tree() {
     530:	7139                	addi	sp,sp,-64
     532:	fc06                	sd	ra,56(sp)
     534:	f822                	sd	s0,48(sp)
     536:	f426                	sd	s1,40(sp)
     538:	f04a                	sd	s2,32(sp)
     53a:	0080                	addi	s0,sp,64
     53c:	81010113          	addi	sp,sp,-2032
  struct process_data all_procs[MAX_PROCS];
  int count = 0;
     540:	fc042e23          	sw	zero,-36(s0)
  int last_pid = -1;
     544:	57fd                	li	a5,-1
     546:	fcf42c23          	sw	a5,-40(s0)

  while (count < MAX_PROCS) {
     54a:	a089                	j	58c <run_top_tree+0x5c>
    int next_pid = next_process(last_pid, &all_procs[count]);
     54c:	77fd                	lui	a5,0xfffff
     54e:	7f078793          	addi	a5,a5,2032 # fffffffffffff7f0 <freep+0xffffffffffffd790>
     552:	1781                	addi	a5,a5,-32
     554:	00878733          	add	a4,a5,s0
     558:	fdc42783          	lw	a5,-36(s0)
     55c:	0796                	slli	a5,a5,0x5
     55e:	973e                	add	a4,a4,a5
     560:	fd842783          	lw	a5,-40(s0)
     564:	85ba                	mv	a1,a4
     566:	853e                	mv	a0,a5
     568:	740000ef          	jal	ca8 <next_process>
     56c:	87aa                	mv	a5,a0
     56e:	fcf42823          	sw	a5,-48(s0)
    if (next_pid == 0) break;
     572:	fd042783          	lw	a5,-48(s0)
     576:	2781                	sext.w	a5,a5
     578:	c39d                	beqz	a5,59e <run_top_tree+0x6e>
    last_pid = next_pid;
     57a:	fd042783          	lw	a5,-48(s0)
     57e:	fcf42c23          	sw	a5,-40(s0)
    count++;
     582:	fdc42783          	lw	a5,-36(s0)
     586:	2785                	addiw	a5,a5,1
     588:	fcf42e23          	sw	a5,-36(s0)
  while (count < MAX_PROCS) {
     58c:	fdc42783          	lw	a5,-36(s0)
     590:	0007871b          	sext.w	a4,a5
     594:	03f00793          	li	a5,63
     598:	fae7dae3          	bge	a5,a4,54c <run_top_tree+0x1c>
     59c:	a011                	j	5a0 <run_top_tree+0x70>
    if (next_pid == 0) break;
     59e:	0001                	nop
  }
  
  printf("Process Tree:\n");
     5a0:	00001517          	auipc	a0,0x1
     5a4:	15850513          	addi	a0,a0,344 # 16f8 <malloc+0x1ec>
     5a8:	57d000ef          	jal	1324 <printf>
  
  for(int i = 0; i < count; i++){
     5ac:	fc042a23          	sw	zero,-44(s0)
     5b0:	a871                	j	64c <run_top_tree+0x11c>
    if(all_procs[i].pid == 1){
     5b2:	77fd                	lui	a5,0xfffff
     5b4:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <freep+0xffffffffffffcf80>
     5b6:	00878733          	add	a4,a5,s0
     5ba:	fd442783          	lw	a5,-44(s0)
     5be:	0796                	slli	a5,a5,0x5
     5c0:	97ba                	add	a5,a5,a4
     5c2:	7f07a703          	lw	a4,2032(a5)
     5c6:	4785                	li	a5,1
     5c8:	06f71d63          	bne	a4,a5,642 <run_top_tree+0x112>
      printf("%d (%s, %s)\n", all_procs[i].pid, all_procs[i].name, get_state_str(all_procs[i].state));
     5cc:	77fd                	lui	a5,0xfffff
     5ce:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <freep+0xffffffffffffcf80>
     5d0:	00878733          	add	a4,a5,s0
     5d4:	fd442783          	lw	a5,-44(s0)
     5d8:	0796                	slli	a5,a5,0x5
     5da:	97ba                	add	a5,a5,a4
     5dc:	7f07a483          	lw	s1,2032(a5)
     5e0:	77fd                	lui	a5,0xfffff
     5e2:	7f078793          	addi	a5,a5,2032 # fffffffffffff7f0 <freep+0xffffffffffffd790>
     5e6:	1781                	addi	a5,a5,-32
     5e8:	00878733          	add	a4,a5,s0
     5ec:	fd442783          	lw	a5,-44(s0)
     5f0:	0796                	slli	a5,a5,0x5
     5f2:	07c1                	addi	a5,a5,16
     5f4:	00f70933          	add	s2,a4,a5
     5f8:	77fd                	lui	a5,0xfffff
     5fa:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <freep+0xffffffffffffcf80>
     5fc:	00878733          	add	a4,a5,s0
     600:	fd442783          	lw	a5,-44(s0)
     604:	0796                	slli	a5,a5,0x5
     606:	97ba                	add	a5,a5,a4
     608:	7fc7a783          	lw	a5,2044(a5)
     60c:	853e                	mv	a0,a5
     60e:	bf1ff0ef          	jal	1fe <get_state_str>
     612:	87aa                	mv	a5,a0
     614:	86be                	mv	a3,a5
     616:	864a                	mv	a2,s2
     618:	85a6                	mv	a1,s1
     61a:	00001517          	auipc	a0,0x1
     61e:	0ee50513          	addi	a0,a0,238 # 1708 <malloc+0x1fc>
     622:	503000ef          	jal	1324 <printf>
      print_tree(all_procs, count, 1, 0); 
     626:	fdc42703          	lw	a4,-36(s0)
     62a:	77fd                	lui	a5,0xfffff
     62c:	7f078793          	addi	a5,a5,2032 # fffffffffffff7f0 <freep+0xffffffffffffd790>
     630:	1781                	addi	a5,a5,-32
     632:	97a2                	add	a5,a5,s0
     634:	4681                	li	a3,0
     636:	4605                	li	a2,1
     638:	85ba                	mv	a1,a4
     63a:	853e                	mv	a0,a5
     63c:	dd3ff0ef          	jal	40e <print_tree>
      break;
     640:	a005                	j	660 <run_top_tree+0x130>
  for(int i = 0; i < count; i++){
     642:	fd442783          	lw	a5,-44(s0)
     646:	2785                	addiw	a5,a5,1
     648:	fcf42a23          	sw	a5,-44(s0)
     64c:	fd442783          	lw	a5,-44(s0)
     650:	873e                	mv	a4,a5
     652:	fdc42783          	lw	a5,-36(s0)
     656:	2701                	sext.w	a4,a4
     658:	2781                	sext.w	a5,a5
     65a:	f4f74ce3          	blt	a4,a5,5b2 <run_top_tree+0x82>
    }
  }
}
     65e:	0001                	nop
     660:	0001                	nop
     662:	7f010113          	addi	sp,sp,2032
     666:	70e2                	ld	ra,56(sp)
     668:	7442                	ld	s0,48(sp)
     66a:	74a2                	ld	s1,40(sp)
     66c:	7902                	ld	s2,32(sp)
     66e:	6121                	addi	sp,sp,64
     670:	8082                	ret

0000000000000672 <main>:

// تابع main (بدون تغییر)
int main(int argc, char *argv[]) {
     672:	7179                	addi	sp,sp,-48
     674:	f406                	sd	ra,40(sp)
     676:	f022                	sd	s0,32(sp)
     678:	1800                	addi	s0,sp,48
     67a:	87aa                	mv	a5,a0
     67c:	fcb43823          	sd	a1,-48(s0)
     680:	fcf42e23          	sw	a5,-36(s0)
  int tree_mode = 0;
     684:	fe042623          	sw	zero,-20(s0)
  if (argc > 1) {
     688:	fdc42783          	lw	a5,-36(s0)
     68c:	0007871b          	sext.w	a4,a5
     690:	4785                	li	a5,1
     692:	02e7df63          	bge	a5,a4,6d0 <main+0x5e>
    if (strcmp(argv[1], "-t") == 0 || strcmp(argv[1], "--tree") == 0) {
     696:	fd043783          	ld	a5,-48(s0)
     69a:	07a1                	addi	a5,a5,8
     69c:	639c                	ld	a5,0(a5)
     69e:	00001597          	auipc	a1,0x1
     6a2:	07a58593          	addi	a1,a1,122 # 1718 <malloc+0x20c>
     6a6:	853e                	mv	a0,a5
     6a8:	0be000ef          	jal	766 <strcmp>
     6ac:	87aa                	mv	a5,a0
     6ae:	cf91                	beqz	a5,6ca <main+0x58>
     6b0:	fd043783          	ld	a5,-48(s0)
     6b4:	07a1                	addi	a5,a5,8
     6b6:	639c                	ld	a5,0(a5)
     6b8:	00001597          	auipc	a1,0x1
     6bc:	06858593          	addi	a1,a1,104 # 1720 <malloc+0x214>
     6c0:	853e                	mv	a0,a5
     6c2:	0a4000ef          	jal	766 <strcmp>
     6c6:	87aa                	mv	a5,a0
     6c8:	e781                	bnez	a5,6d0 <main+0x5e>
      tree_mode = 1;
     6ca:	4785                	li	a5,1
     6cc:	fef42623          	sw	a5,-20(s0)
    }
  }

  if (tree_mode) {
     6d0:	fec42783          	lw	a5,-20(s0)
     6d4:	2781                	sext.w	a5,a5
     6d6:	c781                	beqz	a5,6de <main+0x6c>
    run_top_tree();
     6d8:	e59ff0ef          	jal	530 <run_top_tree>
     6dc:	a019                	j	6e2 <main+0x70>
  } else {
    run_top_list();
     6de:	b63ff0ef          	jal	240 <run_top_list>
  }

  exit(0);
     6e2:	4501                	li	a0,0
     6e4:	51c000ef          	jal	c00 <exit>

00000000000006e8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     6e8:	7179                	addi	sp,sp,-48
     6ea:	f406                	sd	ra,40(sp)
     6ec:	f022                	sd	s0,32(sp)
     6ee:	1800                	addi	s0,sp,48
     6f0:	87aa                	mv	a5,a0
     6f2:	fcb43823          	sd	a1,-48(s0)
     6f6:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     6fa:	fdc42783          	lw	a5,-36(s0)
     6fe:	fd043583          	ld	a1,-48(s0)
     702:	853e                	mv	a0,a5
     704:	f6fff0ef          	jal	672 <main>
     708:	87aa                	mv	a5,a0
     70a:	fef42623          	sw	a5,-20(s0)
  exit(r);
     70e:	fec42783          	lw	a5,-20(s0)
     712:	853e                	mv	a0,a5
     714:	4ec000ef          	jal	c00 <exit>

0000000000000718 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     718:	7179                	addi	sp,sp,-48
     71a:	f406                	sd	ra,40(sp)
     71c:	f022                	sd	s0,32(sp)
     71e:	1800                	addi	s0,sp,48
     720:	fca43c23          	sd	a0,-40(s0)
     724:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     728:	fd843783          	ld	a5,-40(s0)
     72c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     730:	0001                	nop
     732:	fd043703          	ld	a4,-48(s0)
     736:	00170793          	addi	a5,a4,1
     73a:	fcf43823          	sd	a5,-48(s0)
     73e:	fd843783          	ld	a5,-40(s0)
     742:	00178693          	addi	a3,a5,1
     746:	fcd43c23          	sd	a3,-40(s0)
     74a:	00074703          	lbu	a4,0(a4)
     74e:	00e78023          	sb	a4,0(a5)
     752:	0007c783          	lbu	a5,0(a5)
     756:	fff1                	bnez	a5,732 <strcpy+0x1a>
    ;
  return os;
     758:	fe843783          	ld	a5,-24(s0)
}
     75c:	853e                	mv	a0,a5
     75e:	70a2                	ld	ra,40(sp)
     760:	7402                	ld	s0,32(sp)
     762:	6145                	addi	sp,sp,48
     764:	8082                	ret

0000000000000766 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     766:	1101                	addi	sp,sp,-32
     768:	ec06                	sd	ra,24(sp)
     76a:	e822                	sd	s0,16(sp)
     76c:	1000                	addi	s0,sp,32
     76e:	fea43423          	sd	a0,-24(s0)
     772:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     776:	a819                	j	78c <strcmp+0x26>
    p++, q++;
     778:	fe843783          	ld	a5,-24(s0)
     77c:	0785                	addi	a5,a5,1
     77e:	fef43423          	sd	a5,-24(s0)
     782:	fe043783          	ld	a5,-32(s0)
     786:	0785                	addi	a5,a5,1
     788:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     78c:	fe843783          	ld	a5,-24(s0)
     790:	0007c783          	lbu	a5,0(a5)
     794:	cb99                	beqz	a5,7aa <strcmp+0x44>
     796:	fe843783          	ld	a5,-24(s0)
     79a:	0007c703          	lbu	a4,0(a5)
     79e:	fe043783          	ld	a5,-32(s0)
     7a2:	0007c783          	lbu	a5,0(a5)
     7a6:	fcf709e3          	beq	a4,a5,778 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     7aa:	fe843783          	ld	a5,-24(s0)
     7ae:	0007c783          	lbu	a5,0(a5)
     7b2:	0007871b          	sext.w	a4,a5
     7b6:	fe043783          	ld	a5,-32(s0)
     7ba:	0007c783          	lbu	a5,0(a5)
     7be:	2781                	sext.w	a5,a5
     7c0:	40f707bb          	subw	a5,a4,a5
     7c4:	2781                	sext.w	a5,a5
}
     7c6:	853e                	mv	a0,a5
     7c8:	60e2                	ld	ra,24(sp)
     7ca:	6442                	ld	s0,16(sp)
     7cc:	6105                	addi	sp,sp,32
     7ce:	8082                	ret

00000000000007d0 <strlen>:

uint
strlen(const char *s)
{
     7d0:	7179                	addi	sp,sp,-48
     7d2:	f406                	sd	ra,40(sp)
     7d4:	f022                	sd	s0,32(sp)
     7d6:	1800                	addi	s0,sp,48
     7d8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     7dc:	fe042623          	sw	zero,-20(s0)
     7e0:	a031                	j	7ec <strlen+0x1c>
     7e2:	fec42783          	lw	a5,-20(s0)
     7e6:	2785                	addiw	a5,a5,1
     7e8:	fef42623          	sw	a5,-20(s0)
     7ec:	fec42783          	lw	a5,-20(s0)
     7f0:	fd843703          	ld	a4,-40(s0)
     7f4:	97ba                	add	a5,a5,a4
     7f6:	0007c783          	lbu	a5,0(a5)
     7fa:	f7e5                	bnez	a5,7e2 <strlen+0x12>
    ;
  return n;
     7fc:	fec42783          	lw	a5,-20(s0)
}
     800:	853e                	mv	a0,a5
     802:	70a2                	ld	ra,40(sp)
     804:	7402                	ld	s0,32(sp)
     806:	6145                	addi	sp,sp,48
     808:	8082                	ret

000000000000080a <memset>:

void*
memset(void *dst, int c, uint n)
{
     80a:	7179                	addi	sp,sp,-48
     80c:	f406                	sd	ra,40(sp)
     80e:	f022                	sd	s0,32(sp)
     810:	1800                	addi	s0,sp,48
     812:	fca43c23          	sd	a0,-40(s0)
     816:	87ae                	mv	a5,a1
     818:	8732                	mv	a4,a2
     81a:	fcf42a23          	sw	a5,-44(s0)
     81e:	87ba                	mv	a5,a4
     820:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     824:	fd843783          	ld	a5,-40(s0)
     828:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     82c:	fe042623          	sw	zero,-20(s0)
     830:	a00d                	j	852 <memset+0x48>
    cdst[i] = c;
     832:	fec42783          	lw	a5,-20(s0)
     836:	fe043703          	ld	a4,-32(s0)
     83a:	97ba                	add	a5,a5,a4
     83c:	fd442703          	lw	a4,-44(s0)
     840:	0ff77713          	zext.b	a4,a4
     844:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     848:	fec42783          	lw	a5,-20(s0)
     84c:	2785                	addiw	a5,a5,1
     84e:	fef42623          	sw	a5,-20(s0)
     852:	fec42783          	lw	a5,-20(s0)
     856:	fd042703          	lw	a4,-48(s0)
     85a:	2701                	sext.w	a4,a4
     85c:	fce7ebe3          	bltu	a5,a4,832 <memset+0x28>
  }
  return dst;
     860:	fd843783          	ld	a5,-40(s0)
}
     864:	853e                	mv	a0,a5
     866:	70a2                	ld	ra,40(sp)
     868:	7402                	ld	s0,32(sp)
     86a:	6145                	addi	sp,sp,48
     86c:	8082                	ret

000000000000086e <strchr>:

char*
strchr(const char *s, char c)
{
     86e:	1101                	addi	sp,sp,-32
     870:	ec06                	sd	ra,24(sp)
     872:	e822                	sd	s0,16(sp)
     874:	1000                	addi	s0,sp,32
     876:	fea43423          	sd	a0,-24(s0)
     87a:	87ae                	mv	a5,a1
     87c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     880:	a01d                	j	8a6 <strchr+0x38>
    if(*s == c)
     882:	fe843783          	ld	a5,-24(s0)
     886:	0007c703          	lbu	a4,0(a5)
     88a:	fe744783          	lbu	a5,-25(s0)
     88e:	0ff7f793          	zext.b	a5,a5
     892:	00e79563          	bne	a5,a4,89c <strchr+0x2e>
      return (char*)s;
     896:	fe843783          	ld	a5,-24(s0)
     89a:	a821                	j	8b2 <strchr+0x44>
  for(; *s; s++)
     89c:	fe843783          	ld	a5,-24(s0)
     8a0:	0785                	addi	a5,a5,1
     8a2:	fef43423          	sd	a5,-24(s0)
     8a6:	fe843783          	ld	a5,-24(s0)
     8aa:	0007c783          	lbu	a5,0(a5)
     8ae:	fbf1                	bnez	a5,882 <strchr+0x14>
  return 0;
     8b0:	4781                	li	a5,0
}
     8b2:	853e                	mv	a0,a5
     8b4:	60e2                	ld	ra,24(sp)
     8b6:	6442                	ld	s0,16(sp)
     8b8:	6105                	addi	sp,sp,32
     8ba:	8082                	ret

00000000000008bc <gets>:

char*
gets(char *buf, int max)
{
     8bc:	7179                	addi	sp,sp,-48
     8be:	f406                	sd	ra,40(sp)
     8c0:	f022                	sd	s0,32(sp)
     8c2:	1800                	addi	s0,sp,48
     8c4:	fca43c23          	sd	a0,-40(s0)
     8c8:	87ae                	mv	a5,a1
     8ca:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     8ce:	fe042623          	sw	zero,-20(s0)
     8d2:	a891                	j	926 <gets+0x6a>
    cc = read(0, &c, 1);
     8d4:	fe740793          	addi	a5,s0,-25
     8d8:	4605                	li	a2,1
     8da:	85be                	mv	a1,a5
     8dc:	4501                	li	a0,0
     8de:	33a000ef          	jal	c18 <read>
     8e2:	87aa                	mv	a5,a0
     8e4:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     8e8:	fe842783          	lw	a5,-24(s0)
     8ec:	2781                	sext.w	a5,a5
     8ee:	04f05663          	blez	a5,93a <gets+0x7e>
      break;
    buf[i++] = c;
     8f2:	fec42783          	lw	a5,-20(s0)
     8f6:	0017871b          	addiw	a4,a5,1
     8fa:	fee42623          	sw	a4,-20(s0)
     8fe:	873e                	mv	a4,a5
     900:	fd843783          	ld	a5,-40(s0)
     904:	97ba                	add	a5,a5,a4
     906:	fe744703          	lbu	a4,-25(s0)
     90a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     90e:	fe744783          	lbu	a5,-25(s0)
     912:	873e                	mv	a4,a5
     914:	47a9                	li	a5,10
     916:	02f70363          	beq	a4,a5,93c <gets+0x80>
     91a:	fe744783          	lbu	a5,-25(s0)
     91e:	873e                	mv	a4,a5
     920:	47b5                	li	a5,13
     922:	00f70d63          	beq	a4,a5,93c <gets+0x80>
  for(i=0; i+1 < max; ){
     926:	fec42783          	lw	a5,-20(s0)
     92a:	2785                	addiw	a5,a5,1
     92c:	2781                	sext.w	a5,a5
     92e:	fd442703          	lw	a4,-44(s0)
     932:	2701                	sext.w	a4,a4
     934:	fae7c0e3          	blt	a5,a4,8d4 <gets+0x18>
     938:	a011                	j	93c <gets+0x80>
      break;
     93a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     93c:	fec42783          	lw	a5,-20(s0)
     940:	fd843703          	ld	a4,-40(s0)
     944:	97ba                	add	a5,a5,a4
     946:	00078023          	sb	zero,0(a5)
  return buf;
     94a:	fd843783          	ld	a5,-40(s0)
}
     94e:	853e                	mv	a0,a5
     950:	70a2                	ld	ra,40(sp)
     952:	7402                	ld	s0,32(sp)
     954:	6145                	addi	sp,sp,48
     956:	8082                	ret

0000000000000958 <stat>:

int
stat(const char *n, struct stat *st)
{
     958:	7179                	addi	sp,sp,-48
     95a:	f406                	sd	ra,40(sp)
     95c:	f022                	sd	s0,32(sp)
     95e:	1800                	addi	s0,sp,48
     960:	fca43c23          	sd	a0,-40(s0)
     964:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     968:	4581                	li	a1,0
     96a:	fd843503          	ld	a0,-40(s0)
     96e:	2d2000ef          	jal	c40 <open>
     972:	87aa                	mv	a5,a0
     974:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     978:	fec42783          	lw	a5,-20(s0)
     97c:	2781                	sext.w	a5,a5
     97e:	0007d463          	bgez	a5,986 <stat+0x2e>
    return -1;
     982:	57fd                	li	a5,-1
     984:	a015                	j	9a8 <stat+0x50>
  r = fstat(fd, st);
     986:	fec42783          	lw	a5,-20(s0)
     98a:	fd043583          	ld	a1,-48(s0)
     98e:	853e                	mv	a0,a5
     990:	2c8000ef          	jal	c58 <fstat>
     994:	87aa                	mv	a5,a0
     996:	fef42423          	sw	a5,-24(s0)
  close(fd);
     99a:	fec42783          	lw	a5,-20(s0)
     99e:	853e                	mv	a0,a5
     9a0:	288000ef          	jal	c28 <close>
  return r;
     9a4:	fe842783          	lw	a5,-24(s0)
}
     9a8:	853e                	mv	a0,a5
     9aa:	70a2                	ld	ra,40(sp)
     9ac:	7402                	ld	s0,32(sp)
     9ae:	6145                	addi	sp,sp,48
     9b0:	8082                	ret

00000000000009b2 <atoi>:

int
atoi(const char *s)
{
     9b2:	7179                	addi	sp,sp,-48
     9b4:	f406                	sd	ra,40(sp)
     9b6:	f022                	sd	s0,32(sp)
     9b8:	1800                	addi	s0,sp,48
     9ba:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     9be:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     9c2:	a81d                	j	9f8 <atoi+0x46>
    n = n*10 + *s++ - '0';
     9c4:	fec42783          	lw	a5,-20(s0)
     9c8:	873e                	mv	a4,a5
     9ca:	87ba                	mv	a5,a4
     9cc:	0027979b          	slliw	a5,a5,0x2
     9d0:	9fb9                	addw	a5,a5,a4
     9d2:	0017979b          	slliw	a5,a5,0x1
     9d6:	0007871b          	sext.w	a4,a5
     9da:	fd843783          	ld	a5,-40(s0)
     9de:	00178693          	addi	a3,a5,1
     9e2:	fcd43c23          	sd	a3,-40(s0)
     9e6:	0007c783          	lbu	a5,0(a5)
     9ea:	2781                	sext.w	a5,a5
     9ec:	9fb9                	addw	a5,a5,a4
     9ee:	2781                	sext.w	a5,a5
     9f0:	fd07879b          	addiw	a5,a5,-48
     9f4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     9f8:	fd843783          	ld	a5,-40(s0)
     9fc:	0007c783          	lbu	a5,0(a5)
     a00:	873e                	mv	a4,a5
     a02:	02f00793          	li	a5,47
     a06:	00e7fb63          	bgeu	a5,a4,a1c <atoi+0x6a>
     a0a:	fd843783          	ld	a5,-40(s0)
     a0e:	0007c783          	lbu	a5,0(a5)
     a12:	873e                	mv	a4,a5
     a14:	03900793          	li	a5,57
     a18:	fae7f6e3          	bgeu	a5,a4,9c4 <atoi+0x12>
  return n;
     a1c:	fec42783          	lw	a5,-20(s0)
}
     a20:	853e                	mv	a0,a5
     a22:	70a2                	ld	ra,40(sp)
     a24:	7402                	ld	s0,32(sp)
     a26:	6145                	addi	sp,sp,48
     a28:	8082                	ret

0000000000000a2a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     a2a:	7139                	addi	sp,sp,-64
     a2c:	fc06                	sd	ra,56(sp)
     a2e:	f822                	sd	s0,48(sp)
     a30:	0080                	addi	s0,sp,64
     a32:	fca43c23          	sd	a0,-40(s0)
     a36:	fcb43823          	sd	a1,-48(s0)
     a3a:	87b2                	mv	a5,a2
     a3c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     a40:	fd843783          	ld	a5,-40(s0)
     a44:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     a48:	fd043783          	ld	a5,-48(s0)
     a4c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     a50:	fe043703          	ld	a4,-32(s0)
     a54:	fe843783          	ld	a5,-24(s0)
     a58:	02e7fc63          	bgeu	a5,a4,a90 <memmove+0x66>
    while(n-- > 0)
     a5c:	a00d                	j	a7e <memmove+0x54>
      *dst++ = *src++;
     a5e:	fe043703          	ld	a4,-32(s0)
     a62:	00170793          	addi	a5,a4,1
     a66:	fef43023          	sd	a5,-32(s0)
     a6a:	fe843783          	ld	a5,-24(s0)
     a6e:	00178693          	addi	a3,a5,1
     a72:	fed43423          	sd	a3,-24(s0)
     a76:	00074703          	lbu	a4,0(a4)
     a7a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     a7e:	fcc42783          	lw	a5,-52(s0)
     a82:	fff7871b          	addiw	a4,a5,-1
     a86:	fce42623          	sw	a4,-52(s0)
     a8a:	fcf04ae3          	bgtz	a5,a5e <memmove+0x34>
     a8e:	a891                	j	ae2 <memmove+0xb8>
  } else {
    dst += n;
     a90:	fcc42783          	lw	a5,-52(s0)
     a94:	fe843703          	ld	a4,-24(s0)
     a98:	97ba                	add	a5,a5,a4
     a9a:	fef43423          	sd	a5,-24(s0)
    src += n;
     a9e:	fcc42783          	lw	a5,-52(s0)
     aa2:	fe043703          	ld	a4,-32(s0)
     aa6:	97ba                	add	a5,a5,a4
     aa8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     aac:	a01d                	j	ad2 <memmove+0xa8>
      *--dst = *--src;
     aae:	fe043783          	ld	a5,-32(s0)
     ab2:	17fd                	addi	a5,a5,-1
     ab4:	fef43023          	sd	a5,-32(s0)
     ab8:	fe843783          	ld	a5,-24(s0)
     abc:	17fd                	addi	a5,a5,-1
     abe:	fef43423          	sd	a5,-24(s0)
     ac2:	fe043783          	ld	a5,-32(s0)
     ac6:	0007c703          	lbu	a4,0(a5)
     aca:	fe843783          	ld	a5,-24(s0)
     ace:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     ad2:	fcc42783          	lw	a5,-52(s0)
     ad6:	fff7871b          	addiw	a4,a5,-1
     ada:	fce42623          	sw	a4,-52(s0)
     ade:	fcf048e3          	bgtz	a5,aae <memmove+0x84>
  }
  return vdst;
     ae2:	fd843783          	ld	a5,-40(s0)
}
     ae6:	853e                	mv	a0,a5
     ae8:	70e2                	ld	ra,56(sp)
     aea:	7442                	ld	s0,48(sp)
     aec:	6121                	addi	sp,sp,64
     aee:	8082                	ret

0000000000000af0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af0:	7139                	addi	sp,sp,-64
     af2:	fc06                	sd	ra,56(sp)
     af4:	f822                	sd	s0,48(sp)
     af6:	0080                	addi	s0,sp,64
     af8:	fca43c23          	sd	a0,-40(s0)
     afc:	fcb43823          	sd	a1,-48(s0)
     b00:	87b2                	mv	a5,a2
     b02:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     b06:	fd843783          	ld	a5,-40(s0)
     b0a:	fef43423          	sd	a5,-24(s0)
     b0e:	fd043783          	ld	a5,-48(s0)
     b12:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     b16:	a0a1                	j	b5e <memcmp+0x6e>
    if (*p1 != *p2) {
     b18:	fe843783          	ld	a5,-24(s0)
     b1c:	0007c703          	lbu	a4,0(a5)
     b20:	fe043783          	ld	a5,-32(s0)
     b24:	0007c783          	lbu	a5,0(a5)
     b28:	02f70163          	beq	a4,a5,b4a <memcmp+0x5a>
      return *p1 - *p2;
     b2c:	fe843783          	ld	a5,-24(s0)
     b30:	0007c783          	lbu	a5,0(a5)
     b34:	0007871b          	sext.w	a4,a5
     b38:	fe043783          	ld	a5,-32(s0)
     b3c:	0007c783          	lbu	a5,0(a5)
     b40:	2781                	sext.w	a5,a5
     b42:	40f707bb          	subw	a5,a4,a5
     b46:	2781                	sext.w	a5,a5
     b48:	a01d                	j	b6e <memcmp+0x7e>
    }
    p1++;
     b4a:	fe843783          	ld	a5,-24(s0)
     b4e:	0785                	addi	a5,a5,1
     b50:	fef43423          	sd	a5,-24(s0)
    p2++;
     b54:	fe043783          	ld	a5,-32(s0)
     b58:	0785                	addi	a5,a5,1
     b5a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     b5e:	fcc42783          	lw	a5,-52(s0)
     b62:	fff7871b          	addiw	a4,a5,-1
     b66:	fce42623          	sw	a4,-52(s0)
     b6a:	f7dd                	bnez	a5,b18 <memcmp+0x28>
  }
  return 0;
     b6c:	4781                	li	a5,0
}
     b6e:	853e                	mv	a0,a5
     b70:	70e2                	ld	ra,56(sp)
     b72:	7442                	ld	s0,48(sp)
     b74:	6121                	addi	sp,sp,64
     b76:	8082                	ret

0000000000000b78 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b78:	7179                	addi	sp,sp,-48
     b7a:	f406                	sd	ra,40(sp)
     b7c:	f022                	sd	s0,32(sp)
     b7e:	1800                	addi	s0,sp,48
     b80:	fea43423          	sd	a0,-24(s0)
     b84:	feb43023          	sd	a1,-32(s0)
     b88:	87b2                	mv	a5,a2
     b8a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     b8e:	fdc42783          	lw	a5,-36(s0)
     b92:	863e                	mv	a2,a5
     b94:	fe043583          	ld	a1,-32(s0)
     b98:	fe843503          	ld	a0,-24(s0)
     b9c:	e8fff0ef          	jal	a2a <memmove>
     ba0:	87aa                	mv	a5,a0
}
     ba2:	853e                	mv	a0,a5
     ba4:	70a2                	ld	ra,40(sp)
     ba6:	7402                	ld	s0,32(sp)
     ba8:	6145                	addi	sp,sp,48
     baa:	8082                	ret

0000000000000bac <sbrk>:

char *
sbrk(int n) {
     bac:	1101                	addi	sp,sp,-32
     bae:	ec06                	sd	ra,24(sp)
     bb0:	e822                	sd	s0,16(sp)
     bb2:	1000                	addi	s0,sp,32
     bb4:	87aa                	mv	a5,a0
     bb6:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
     bba:	fec42783          	lw	a5,-20(s0)
     bbe:	4585                	li	a1,1
     bc0:	853e                	mv	a0,a5
     bc2:	0c6000ef          	jal	c88 <sys_sbrk>
     bc6:	87aa                	mv	a5,a0
}
     bc8:	853e                	mv	a0,a5
     bca:	60e2                	ld	ra,24(sp)
     bcc:	6442                	ld	s0,16(sp)
     bce:	6105                	addi	sp,sp,32
     bd0:	8082                	ret

0000000000000bd2 <sbrklazy>:

char *
sbrklazy(int n) {
     bd2:	1101                	addi	sp,sp,-32
     bd4:	ec06                	sd	ra,24(sp)
     bd6:	e822                	sd	s0,16(sp)
     bd8:	1000                	addi	s0,sp,32
     bda:	87aa                	mv	a5,a0
     bdc:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
     be0:	fec42783          	lw	a5,-20(s0)
     be4:	4589                	li	a1,2
     be6:	853e                	mv	a0,a5
     be8:	0a0000ef          	jal	c88 <sys_sbrk>
     bec:	87aa                	mv	a5,a0
}
     bee:	853e                	mv	a0,a5
     bf0:	60e2                	ld	ra,24(sp)
     bf2:	6442                	ld	s0,16(sp)
     bf4:	6105                	addi	sp,sp,32
     bf6:	8082                	ret

0000000000000bf8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     bf8:	4885                	li	a7,1
 ecall
     bfa:	00000073          	ecall
 ret
     bfe:	8082                	ret

0000000000000c00 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c00:	4889                	li	a7,2
 ecall
     c02:	00000073          	ecall
 ret
     c06:	8082                	ret

0000000000000c08 <wait>:
.global wait
wait:
 li a7, SYS_wait
     c08:	488d                	li	a7,3
 ecall
     c0a:	00000073          	ecall
 ret
     c0e:	8082                	ret

0000000000000c10 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c10:	4891                	li	a7,4
 ecall
     c12:	00000073          	ecall
 ret
     c16:	8082                	ret

0000000000000c18 <read>:
.global read
read:
 li a7, SYS_read
     c18:	4895                	li	a7,5
 ecall
     c1a:	00000073          	ecall
 ret
     c1e:	8082                	ret

0000000000000c20 <write>:
.global write
write:
 li a7, SYS_write
     c20:	48c1                	li	a7,16
 ecall
     c22:	00000073          	ecall
 ret
     c26:	8082                	ret

0000000000000c28 <close>:
.global close
close:
 li a7, SYS_close
     c28:	48d5                	li	a7,21
 ecall
     c2a:	00000073          	ecall
 ret
     c2e:	8082                	ret

0000000000000c30 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c30:	4899                	li	a7,6
 ecall
     c32:	00000073          	ecall
 ret
     c36:	8082                	ret

0000000000000c38 <exec>:
.global exec
exec:
 li a7, SYS_exec
     c38:	489d                	li	a7,7
 ecall
     c3a:	00000073          	ecall
 ret
     c3e:	8082                	ret

0000000000000c40 <open>:
.global open
open:
 li a7, SYS_open
     c40:	48bd                	li	a7,15
 ecall
     c42:	00000073          	ecall
 ret
     c46:	8082                	ret

0000000000000c48 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c48:	48c5                	li	a7,17
 ecall
     c4a:	00000073          	ecall
 ret
     c4e:	8082                	ret

0000000000000c50 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c50:	48c9                	li	a7,18
 ecall
     c52:	00000073          	ecall
 ret
     c56:	8082                	ret

0000000000000c58 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c58:	48a1                	li	a7,8
 ecall
     c5a:	00000073          	ecall
 ret
     c5e:	8082                	ret

0000000000000c60 <link>:
.global link
link:
 li a7, SYS_link
     c60:	48cd                	li	a7,19
 ecall
     c62:	00000073          	ecall
 ret
     c66:	8082                	ret

0000000000000c68 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c68:	48d1                	li	a7,20
 ecall
     c6a:	00000073          	ecall
 ret
     c6e:	8082                	ret

0000000000000c70 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c70:	48a5                	li	a7,9
 ecall
     c72:	00000073          	ecall
 ret
     c76:	8082                	ret

0000000000000c78 <dup>:
.global dup
dup:
 li a7, SYS_dup
     c78:	48a9                	li	a7,10
 ecall
     c7a:	00000073          	ecall
 ret
     c7e:	8082                	ret

0000000000000c80 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c80:	48ad                	li	a7,11
 ecall
     c82:	00000073          	ecall
 ret
     c86:	8082                	ret

0000000000000c88 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     c88:	48b1                	li	a7,12
 ecall
     c8a:	00000073          	ecall
 ret
     c8e:	8082                	ret

0000000000000c90 <pause>:
.global pause
pause:
 li a7, SYS_pause
     c90:	48b5                	li	a7,13
 ecall
     c92:	00000073          	ecall
 ret
     c96:	8082                	ret

0000000000000c98 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c98:	48b9                	li	a7,14
 ecall
     c9a:	00000073          	ecall
 ret
     c9e:	8082                	ret

0000000000000ca0 <top>:
.global top
top:
 li a7, SYS_top
     ca0:	48d9                	li	a7,22
 ecall
     ca2:	00000073          	ecall
 ret
     ca6:	8082                	ret

0000000000000ca8 <next_process>:
.global next_process
next_process:
 li a7, SYS_next_process
     ca8:	48dd                	li	a7,23
 ecall
     caa:	00000073          	ecall
 ret
     cae:	8082                	ret

0000000000000cb0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     cb0:	1101                	addi	sp,sp,-32
     cb2:	ec06                	sd	ra,24(sp)
     cb4:	e822                	sd	s0,16(sp)
     cb6:	1000                	addi	s0,sp,32
     cb8:	87aa                	mv	a5,a0
     cba:	872e                	mv	a4,a1
     cbc:	fef42623          	sw	a5,-20(s0)
     cc0:	87ba                	mv	a5,a4
     cc2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     cc6:	feb40713          	addi	a4,s0,-21
     cca:	fec42783          	lw	a5,-20(s0)
     cce:	4605                	li	a2,1
     cd0:	85ba                	mv	a1,a4
     cd2:	853e                	mv	a0,a5
     cd4:	f4dff0ef          	jal	c20 <write>
}
     cd8:	0001                	nop
     cda:	60e2                	ld	ra,24(sp)
     cdc:	6442                	ld	s0,16(sp)
     cde:	6105                	addi	sp,sp,32
     ce0:	8082                	ret

0000000000000ce2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     ce2:	711d                	addi	sp,sp,-96
     ce4:	ec86                	sd	ra,88(sp)
     ce6:	e8a2                	sd	s0,80(sp)
     ce8:	1080                	addi	s0,sp,96
     cea:	87aa                	mv	a5,a0
     cec:	fab43823          	sd	a1,-80(s0)
     cf0:	8736                	mv	a4,a3
     cf2:	faf42e23          	sw	a5,-68(s0)
     cf6:	87b2                	mv	a5,a2
     cf8:	faf42c23          	sw	a5,-72(s0)
     cfc:	87ba                	mv	a5,a4
     cfe:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
     d02:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     d06:	fac42783          	lw	a5,-84(s0)
     d0a:	2781                	sext.w	a5,a5
     d0c:	cf99                	beqz	a5,d2a <printint+0x48>
     d0e:	fb043783          	ld	a5,-80(s0)
     d12:	0007dc63          	bgez	a5,d2a <printint+0x48>
    neg = 1;
     d16:	4785                	li	a5,1
     d18:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     d1c:	fb043783          	ld	a5,-80(s0)
     d20:	40f007b3          	neg	a5,a5
     d24:	fef43023          	sd	a5,-32(s0)
     d28:	a029                	j	d32 <printint+0x50>
  } else {
    x = xx;
     d2a:	fb043783          	ld	a5,-80(s0)
     d2e:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
     d32:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     d36:	fb842783          	lw	a5,-72(s0)
     d3a:	fe043703          	ld	a4,-32(s0)
     d3e:	02f77733          	remu	a4,a4,a5
     d42:	fec42783          	lw	a5,-20(s0)
     d46:	0017869b          	addiw	a3,a5,1
     d4a:	fed42623          	sw	a3,-20(s0)
     d4e:	00001697          	auipc	a3,0x1
     d52:	2e268693          	addi	a3,a3,738 # 2030 <digits>
     d56:	9736                	add	a4,a4,a3
     d58:	00074703          	lbu	a4,0(a4)
     d5c:	17c1                	addi	a5,a5,-16
     d5e:	97a2                	add	a5,a5,s0
     d60:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
     d64:	fb842783          	lw	a5,-72(s0)
     d68:	fe043703          	ld	a4,-32(s0)
     d6c:	02f757b3          	divu	a5,a4,a5
     d70:	fef43023          	sd	a5,-32(s0)
     d74:	fe043783          	ld	a5,-32(s0)
     d78:	ffdd                	bnez	a5,d36 <printint+0x54>
  if(neg)
     d7a:	fe842783          	lw	a5,-24(s0)
     d7e:	2781                	sext.w	a5,a5
     d80:	cb95                	beqz	a5,db4 <printint+0xd2>
    buf[i++] = '-';
     d82:	fec42783          	lw	a5,-20(s0)
     d86:	0017871b          	addiw	a4,a5,1
     d8a:	fee42623          	sw	a4,-20(s0)
     d8e:	17c1                	addi	a5,a5,-16
     d90:	97a2                	add	a5,a5,s0
     d92:	02d00713          	li	a4,45
     d96:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
     d9a:	a829                	j	db4 <printint+0xd2>
    putc(fd, buf[i]);
     d9c:	fec42783          	lw	a5,-20(s0)
     da0:	17c1                	addi	a5,a5,-16
     da2:	97a2                	add	a5,a5,s0
     da4:	fd87c703          	lbu	a4,-40(a5)
     da8:	fbc42783          	lw	a5,-68(s0)
     dac:	85ba                	mv	a1,a4
     dae:	853e                	mv	a0,a5
     db0:	f01ff0ef          	jal	cb0 <putc>
  while(--i >= 0)
     db4:	fec42783          	lw	a5,-20(s0)
     db8:	37fd                	addiw	a5,a5,-1
     dba:	fef42623          	sw	a5,-20(s0)
     dbe:	fec42783          	lw	a5,-20(s0)
     dc2:	2781                	sext.w	a5,a5
     dc4:	fc07dce3          	bgez	a5,d9c <printint+0xba>
}
     dc8:	0001                	nop
     dca:	0001                	nop
     dcc:	60e6                	ld	ra,88(sp)
     dce:	6446                	ld	s0,80(sp)
     dd0:	6125                	addi	sp,sp,96
     dd2:	8082                	ret

0000000000000dd4 <printptr>:

static void
printptr(int fd, uint64 x) {
     dd4:	7179                	addi	sp,sp,-48
     dd6:	f406                	sd	ra,40(sp)
     dd8:	f022                	sd	s0,32(sp)
     dda:	1800                	addi	s0,sp,48
     ddc:	87aa                	mv	a5,a0
     dde:	fcb43823          	sd	a1,-48(s0)
     de2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     de6:	fdc42783          	lw	a5,-36(s0)
     dea:	03000593          	li	a1,48
     dee:	853e                	mv	a0,a5
     df0:	ec1ff0ef          	jal	cb0 <putc>
  putc(fd, 'x');
     df4:	fdc42783          	lw	a5,-36(s0)
     df8:	07800593          	li	a1,120
     dfc:	853e                	mv	a0,a5
     dfe:	eb3ff0ef          	jal	cb0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     e02:	fe042623          	sw	zero,-20(s0)
     e06:	a81d                	j	e3c <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     e08:	fd043783          	ld	a5,-48(s0)
     e0c:	93f1                	srli	a5,a5,0x3c
     e0e:	00001717          	auipc	a4,0x1
     e12:	22270713          	addi	a4,a4,546 # 2030 <digits>
     e16:	97ba                	add	a5,a5,a4
     e18:	0007c703          	lbu	a4,0(a5)
     e1c:	fdc42783          	lw	a5,-36(s0)
     e20:	85ba                	mv	a1,a4
     e22:	853e                	mv	a0,a5
     e24:	e8dff0ef          	jal	cb0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     e28:	fec42783          	lw	a5,-20(s0)
     e2c:	2785                	addiw	a5,a5,1
     e2e:	fef42623          	sw	a5,-20(s0)
     e32:	fd043783          	ld	a5,-48(s0)
     e36:	0792                	slli	a5,a5,0x4
     e38:	fcf43823          	sd	a5,-48(s0)
     e3c:	fec42703          	lw	a4,-20(s0)
     e40:	47bd                	li	a5,15
     e42:	fce7f3e3          	bgeu	a5,a4,e08 <printptr+0x34>
}
     e46:	0001                	nop
     e48:	0001                	nop
     e4a:	70a2                	ld	ra,40(sp)
     e4c:	7402                	ld	s0,32(sp)
     e4e:	6145                	addi	sp,sp,48
     e50:	8082                	ret

0000000000000e52 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e52:	715d                	addi	sp,sp,-80
     e54:	e486                	sd	ra,72(sp)
     e56:	e0a2                	sd	s0,64(sp)
     e58:	0880                	addi	s0,sp,80
     e5a:	87aa                	mv	a5,a0
     e5c:	fcb43023          	sd	a1,-64(s0)
     e60:	fac43c23          	sd	a2,-72(s0)
     e64:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
     e68:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
     e6c:	fc042e23          	sw	zero,-36(s0)
     e70:	a189                	j	12b2 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
     e72:	fdc42783          	lw	a5,-36(s0)
     e76:	fc043703          	ld	a4,-64(s0)
     e7a:	97ba                	add	a5,a5,a4
     e7c:	0007c783          	lbu	a5,0(a5)
     e80:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
     e84:	fd842783          	lw	a5,-40(s0)
     e88:	2781                	sext.w	a5,a5
     e8a:	eb8d                	bnez	a5,ebc <vprintf+0x6a>
      if(c0 == '%'){
     e8c:	fd442783          	lw	a5,-44(s0)
     e90:	0007871b          	sext.w	a4,a5
     e94:	02500793          	li	a5,37
     e98:	00f71763          	bne	a4,a5,ea6 <vprintf+0x54>
        state = '%';
     e9c:	02500793          	li	a5,37
     ea0:	fcf42c23          	sw	a5,-40(s0)
     ea4:	a111                	j	12a8 <vprintf+0x456>
      } else {
        putc(fd, c0);
     ea6:	fd442783          	lw	a5,-44(s0)
     eaa:	0ff7f713          	zext.b	a4,a5
     eae:	fcc42783          	lw	a5,-52(s0)
     eb2:	85ba                	mv	a1,a4
     eb4:	853e                	mv	a0,a5
     eb6:	dfbff0ef          	jal	cb0 <putc>
     eba:	a6fd                	j	12a8 <vprintf+0x456>
      }
    } else if(state == '%'){
     ebc:	fd842783          	lw	a5,-40(s0)
     ec0:	0007871b          	sext.w	a4,a5
     ec4:	02500793          	li	a5,37
     ec8:	3ef71063          	bne	a4,a5,12a8 <vprintf+0x456>
      c1 = c2 = 0;
     ecc:	fe042023          	sw	zero,-32(s0)
     ed0:	fe042783          	lw	a5,-32(s0)
     ed4:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
     ed8:	fd442783          	lw	a5,-44(s0)
     edc:	2781                	sext.w	a5,a5
     ede:	cb99                	beqz	a5,ef4 <vprintf+0xa2>
     ee0:	fdc42783          	lw	a5,-36(s0)
     ee4:	0785                	addi	a5,a5,1
     ee6:	fc043703          	ld	a4,-64(s0)
     eea:	97ba                	add	a5,a5,a4
     eec:	0007c783          	lbu	a5,0(a5)
     ef0:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
     ef4:	fe442783          	lw	a5,-28(s0)
     ef8:	2781                	sext.w	a5,a5
     efa:	cb99                	beqz	a5,f10 <vprintf+0xbe>
     efc:	fdc42783          	lw	a5,-36(s0)
     f00:	0789                	addi	a5,a5,2
     f02:	fc043703          	ld	a4,-64(s0)
     f06:	97ba                	add	a5,a5,a4
     f08:	0007c783          	lbu	a5,0(a5)
     f0c:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
     f10:	fd442783          	lw	a5,-44(s0)
     f14:	0007871b          	sext.w	a4,a5
     f18:	06400793          	li	a5,100
     f1c:	02f71363          	bne	a4,a5,f42 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
     f20:	fb843783          	ld	a5,-72(s0)
     f24:	00878713          	addi	a4,a5,8
     f28:	fae43c23          	sd	a4,-72(s0)
     f2c:	439c                	lw	a5,0(a5)
     f2e:	873e                	mv	a4,a5
     f30:	fcc42783          	lw	a5,-52(s0)
     f34:	4685                	li	a3,1
     f36:	4629                	li	a2,10
     f38:	85ba                	mv	a1,a4
     f3a:	853e                	mv	a0,a5
     f3c:	da7ff0ef          	jal	ce2 <printint>
     f40:	a695                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
     f42:	fd442783          	lw	a5,-44(s0)
     f46:	0007871b          	sext.w	a4,a5
     f4a:	06c00793          	li	a5,108
     f4e:	04f71063          	bne	a4,a5,f8e <vprintf+0x13c>
     f52:	fe442783          	lw	a5,-28(s0)
     f56:	0007871b          	sext.w	a4,a5
     f5a:	06400793          	li	a5,100
     f5e:	02f71863          	bne	a4,a5,f8e <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f62:	fb843783          	ld	a5,-72(s0)
     f66:	00878713          	addi	a4,a5,8
     f6a:	fae43c23          	sd	a4,-72(s0)
     f6e:	639c                	ld	a5,0(a5)
     f70:	873e                	mv	a4,a5
     f72:	fcc42783          	lw	a5,-52(s0)
     f76:	4685                	li	a3,1
     f78:	4629                	li	a2,10
     f7a:	85ba                	mv	a1,a4
     f7c:	853e                	mv	a0,a5
     f7e:	d65ff0ef          	jal	ce2 <printint>
        i += 1;
     f82:	fdc42783          	lw	a5,-36(s0)
     f86:	2785                	addiw	a5,a5,1
     f88:	fcf42e23          	sw	a5,-36(s0)
     f8c:	ae21                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f8e:	fd442783          	lw	a5,-44(s0)
     f92:	0007871b          	sext.w	a4,a5
     f96:	06c00793          	li	a5,108
     f9a:	04f71863          	bne	a4,a5,fea <vprintf+0x198>
     f9e:	fe442783          	lw	a5,-28(s0)
     fa2:	0007871b          	sext.w	a4,a5
     fa6:	06c00793          	li	a5,108
     faa:	04f71063          	bne	a4,a5,fea <vprintf+0x198>
     fae:	fe042783          	lw	a5,-32(s0)
     fb2:	0007871b          	sext.w	a4,a5
     fb6:	06400793          	li	a5,100
     fba:	02f71863          	bne	a4,a5,fea <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
     fbe:	fb843783          	ld	a5,-72(s0)
     fc2:	00878713          	addi	a4,a5,8
     fc6:	fae43c23          	sd	a4,-72(s0)
     fca:	639c                	ld	a5,0(a5)
     fcc:	873e                	mv	a4,a5
     fce:	fcc42783          	lw	a5,-52(s0)
     fd2:	4685                	li	a3,1
     fd4:	4629                	li	a2,10
     fd6:	85ba                	mv	a1,a4
     fd8:	853e                	mv	a0,a5
     fda:	d09ff0ef          	jal	ce2 <printint>
        i += 2;
     fde:	fdc42783          	lw	a5,-36(s0)
     fe2:	2789                	addiw	a5,a5,2
     fe4:	fcf42e23          	sw	a5,-36(s0)
     fe8:	ac75                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'u'){
     fea:	fd442783          	lw	a5,-44(s0)
     fee:	0007871b          	sext.w	a4,a5
     ff2:	07500793          	li	a5,117
     ff6:	02f71563          	bne	a4,a5,1020 <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
     ffa:	fb843783          	ld	a5,-72(s0)
     ffe:	00878713          	addi	a4,a5,8
    1002:	fae43c23          	sd	a4,-72(s0)
    1006:	439c                	lw	a5,0(a5)
    1008:	02079713          	slli	a4,a5,0x20
    100c:	9301                	srli	a4,a4,0x20
    100e:	fcc42783          	lw	a5,-52(s0)
    1012:	4681                	li	a3,0
    1014:	4629                	li	a2,10
    1016:	85ba                	mv	a1,a4
    1018:	853e                	mv	a0,a5
    101a:	cc9ff0ef          	jal	ce2 <printint>
    101e:	a459                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
    1020:	fd442783          	lw	a5,-44(s0)
    1024:	0007871b          	sext.w	a4,a5
    1028:	06c00793          	li	a5,108
    102c:	04f71063          	bne	a4,a5,106c <vprintf+0x21a>
    1030:	fe442783          	lw	a5,-28(s0)
    1034:	0007871b          	sext.w	a4,a5
    1038:	07500793          	li	a5,117
    103c:	02f71863          	bne	a4,a5,106c <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1040:	fb843783          	ld	a5,-72(s0)
    1044:	00878713          	addi	a4,a5,8
    1048:	fae43c23          	sd	a4,-72(s0)
    104c:	639c                	ld	a5,0(a5)
    104e:	873e                	mv	a4,a5
    1050:	fcc42783          	lw	a5,-52(s0)
    1054:	4681                	li	a3,0
    1056:	4629                	li	a2,10
    1058:	85ba                	mv	a1,a4
    105a:	853e                	mv	a0,a5
    105c:	c87ff0ef          	jal	ce2 <printint>
        i += 1;
    1060:	fdc42783          	lw	a5,-36(s0)
    1064:	2785                	addiw	a5,a5,1
    1066:	fcf42e23          	sw	a5,-36(s0)
    106a:	ac2d                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    106c:	fd442783          	lw	a5,-44(s0)
    1070:	0007871b          	sext.w	a4,a5
    1074:	06c00793          	li	a5,108
    1078:	04f71863          	bne	a4,a5,10c8 <vprintf+0x276>
    107c:	fe442783          	lw	a5,-28(s0)
    1080:	0007871b          	sext.w	a4,a5
    1084:	06c00793          	li	a5,108
    1088:	04f71063          	bne	a4,a5,10c8 <vprintf+0x276>
    108c:	fe042783          	lw	a5,-32(s0)
    1090:	0007871b          	sext.w	a4,a5
    1094:	07500793          	li	a5,117
    1098:	02f71863          	bne	a4,a5,10c8 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
    109c:	fb843783          	ld	a5,-72(s0)
    10a0:	00878713          	addi	a4,a5,8
    10a4:	fae43c23          	sd	a4,-72(s0)
    10a8:	639c                	ld	a5,0(a5)
    10aa:	873e                	mv	a4,a5
    10ac:	fcc42783          	lw	a5,-52(s0)
    10b0:	4681                	li	a3,0
    10b2:	4629                	li	a2,10
    10b4:	85ba                	mv	a1,a4
    10b6:	853e                	mv	a0,a5
    10b8:	c2bff0ef          	jal	ce2 <printint>
        i += 2;
    10bc:	fdc42783          	lw	a5,-36(s0)
    10c0:	2789                	addiw	a5,a5,2
    10c2:	fcf42e23          	sw	a5,-36(s0)
    10c6:	aaf9                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'x'){
    10c8:	fd442783          	lw	a5,-44(s0)
    10cc:	0007871b          	sext.w	a4,a5
    10d0:	07800793          	li	a5,120
    10d4:	02f71563          	bne	a4,a5,10fe <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
    10d8:	fb843783          	ld	a5,-72(s0)
    10dc:	00878713          	addi	a4,a5,8
    10e0:	fae43c23          	sd	a4,-72(s0)
    10e4:	439c                	lw	a5,0(a5)
    10e6:	02079713          	slli	a4,a5,0x20
    10ea:	9301                	srli	a4,a4,0x20
    10ec:	fcc42783          	lw	a5,-52(s0)
    10f0:	4681                	li	a3,0
    10f2:	4641                	li	a2,16
    10f4:	85ba                	mv	a1,a4
    10f6:	853e                	mv	a0,a5
    10f8:	bebff0ef          	jal	ce2 <printint>
    10fc:	a265                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
    10fe:	fd442783          	lw	a5,-44(s0)
    1102:	0007871b          	sext.w	a4,a5
    1106:	06c00793          	li	a5,108
    110a:	04f71063          	bne	a4,a5,114a <vprintf+0x2f8>
    110e:	fe442783          	lw	a5,-28(s0)
    1112:	0007871b          	sext.w	a4,a5
    1116:	07800793          	li	a5,120
    111a:	02f71863          	bne	a4,a5,114a <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
    111e:	fb843783          	ld	a5,-72(s0)
    1122:	00878713          	addi	a4,a5,8
    1126:	fae43c23          	sd	a4,-72(s0)
    112a:	639c                	ld	a5,0(a5)
    112c:	873e                	mv	a4,a5
    112e:	fcc42783          	lw	a5,-52(s0)
    1132:	4681                	li	a3,0
    1134:	4641                	li	a2,16
    1136:	85ba                	mv	a1,a4
    1138:	853e                	mv	a0,a5
    113a:	ba9ff0ef          	jal	ce2 <printint>
        i += 1;
    113e:	fdc42783          	lw	a5,-36(s0)
    1142:	2785                	addiw	a5,a5,1
    1144:	fcf42e23          	sw	a5,-36(s0)
    1148:	aab1                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    114a:	fd442783          	lw	a5,-44(s0)
    114e:	0007871b          	sext.w	a4,a5
    1152:	06c00793          	li	a5,108
    1156:	04f71863          	bne	a4,a5,11a6 <vprintf+0x354>
    115a:	fe442783          	lw	a5,-28(s0)
    115e:	0007871b          	sext.w	a4,a5
    1162:	06c00793          	li	a5,108
    1166:	04f71063          	bne	a4,a5,11a6 <vprintf+0x354>
    116a:	fe042783          	lw	a5,-32(s0)
    116e:	0007871b          	sext.w	a4,a5
    1172:	07800793          	li	a5,120
    1176:	02f71863          	bne	a4,a5,11a6 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
    117a:	fb843783          	ld	a5,-72(s0)
    117e:	00878713          	addi	a4,a5,8
    1182:	fae43c23          	sd	a4,-72(s0)
    1186:	639c                	ld	a5,0(a5)
    1188:	873e                	mv	a4,a5
    118a:	fcc42783          	lw	a5,-52(s0)
    118e:	4681                	li	a3,0
    1190:	4641                	li	a2,16
    1192:	85ba                	mv	a1,a4
    1194:	853e                	mv	a0,a5
    1196:	b4dff0ef          	jal	ce2 <printint>
        i += 2;
    119a:	fdc42783          	lw	a5,-36(s0)
    119e:	2789                	addiw	a5,a5,2
    11a0:	fcf42e23          	sw	a5,-36(s0)
    11a4:	a201                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'p'){
    11a6:	fd442783          	lw	a5,-44(s0)
    11aa:	0007871b          	sext.w	a4,a5
    11ae:	07000793          	li	a5,112
    11b2:	02f71063          	bne	a4,a5,11d2 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
    11b6:	fb843783          	ld	a5,-72(s0)
    11ba:	00878713          	addi	a4,a5,8
    11be:	fae43c23          	sd	a4,-72(s0)
    11c2:	6398                	ld	a4,0(a5)
    11c4:	fcc42783          	lw	a5,-52(s0)
    11c8:	85ba                	mv	a1,a4
    11ca:	853e                	mv	a0,a5
    11cc:	c09ff0ef          	jal	dd4 <printptr>
    11d0:	a8d1                	j	12a4 <vprintf+0x452>
      } else if(c0 == 'c'){
    11d2:	fd442783          	lw	a5,-44(s0)
    11d6:	0007871b          	sext.w	a4,a5
    11da:	06300793          	li	a5,99
    11de:	02f71263          	bne	a4,a5,1202 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
    11e2:	fb843783          	ld	a5,-72(s0)
    11e6:	00878713          	addi	a4,a5,8
    11ea:	fae43c23          	sd	a4,-72(s0)
    11ee:	439c                	lw	a5,0(a5)
    11f0:	0ff7f713          	zext.b	a4,a5
    11f4:	fcc42783          	lw	a5,-52(s0)
    11f8:	85ba                	mv	a1,a4
    11fa:	853e                	mv	a0,a5
    11fc:	ab5ff0ef          	jal	cb0 <putc>
    1200:	a055                	j	12a4 <vprintf+0x452>
      } else if(c0 == 's'){
    1202:	fd442783          	lw	a5,-44(s0)
    1206:	0007871b          	sext.w	a4,a5
    120a:	07300793          	li	a5,115
    120e:	04f71a63          	bne	a4,a5,1262 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
    1212:	fb843783          	ld	a5,-72(s0)
    1216:	00878713          	addi	a4,a5,8
    121a:	fae43c23          	sd	a4,-72(s0)
    121e:	639c                	ld	a5,0(a5)
    1220:	fef43423          	sd	a5,-24(s0)
    1224:	fe843783          	ld	a5,-24(s0)
    1228:	e79d                	bnez	a5,1256 <vprintf+0x404>
          s = "(null)";
    122a:	00000797          	auipc	a5,0x0
    122e:	54678793          	addi	a5,a5,1350 # 1770 <malloc+0x264>
    1232:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
    1236:	a005                	j	1256 <vprintf+0x404>
          putc(fd, *s);
    1238:	fe843783          	ld	a5,-24(s0)
    123c:	0007c703          	lbu	a4,0(a5)
    1240:	fcc42783          	lw	a5,-52(s0)
    1244:	85ba                	mv	a1,a4
    1246:	853e                	mv	a0,a5
    1248:	a69ff0ef          	jal	cb0 <putc>
        for(; *s; s++)
    124c:	fe843783          	ld	a5,-24(s0)
    1250:	0785                	addi	a5,a5,1
    1252:	fef43423          	sd	a5,-24(s0)
    1256:	fe843783          	ld	a5,-24(s0)
    125a:	0007c783          	lbu	a5,0(a5)
    125e:	ffe9                	bnez	a5,1238 <vprintf+0x3e6>
    1260:	a091                	j	12a4 <vprintf+0x452>
      } else if(c0 == '%'){
    1262:	fd442783          	lw	a5,-44(s0)
    1266:	0007871b          	sext.w	a4,a5
    126a:	02500793          	li	a5,37
    126e:	00f71a63          	bne	a4,a5,1282 <vprintf+0x430>
        putc(fd, '%');
    1272:	fcc42783          	lw	a5,-52(s0)
    1276:	02500593          	li	a1,37
    127a:	853e                	mv	a0,a5
    127c:	a35ff0ef          	jal	cb0 <putc>
    1280:	a015                	j	12a4 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1282:	fcc42783          	lw	a5,-52(s0)
    1286:	02500593          	li	a1,37
    128a:	853e                	mv	a0,a5
    128c:	a25ff0ef          	jal	cb0 <putc>
        putc(fd, c0);
    1290:	fd442783          	lw	a5,-44(s0)
    1294:	0ff7f713          	zext.b	a4,a5
    1298:	fcc42783          	lw	a5,-52(s0)
    129c:	85ba                	mv	a1,a4
    129e:	853e                	mv	a0,a5
    12a0:	a11ff0ef          	jal	cb0 <putc>
      }

      state = 0;
    12a4:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    12a8:	fdc42783          	lw	a5,-36(s0)
    12ac:	2785                	addiw	a5,a5,1
    12ae:	fcf42e23          	sw	a5,-36(s0)
    12b2:	fdc42783          	lw	a5,-36(s0)
    12b6:	fc043703          	ld	a4,-64(s0)
    12ba:	97ba                	add	a5,a5,a4
    12bc:	0007c783          	lbu	a5,0(a5)
    12c0:	ba0799e3          	bnez	a5,e72 <vprintf+0x20>
    }
  }
}
    12c4:	0001                	nop
    12c6:	0001                	nop
    12c8:	60a6                	ld	ra,72(sp)
    12ca:	6406                	ld	s0,64(sp)
    12cc:	6161                	addi	sp,sp,80
    12ce:	8082                	ret

00000000000012d0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    12d0:	7159                	addi	sp,sp,-112
    12d2:	fc06                	sd	ra,56(sp)
    12d4:	f822                	sd	s0,48(sp)
    12d6:	0080                	addi	s0,sp,64
    12d8:	fcb43823          	sd	a1,-48(s0)
    12dc:	e010                	sd	a2,0(s0)
    12de:	e414                	sd	a3,8(s0)
    12e0:	e818                	sd	a4,16(s0)
    12e2:	ec1c                	sd	a5,24(s0)
    12e4:	03043023          	sd	a6,32(s0)
    12e8:	03143423          	sd	a7,40(s0)
    12ec:	87aa                	mv	a5,a0
    12ee:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    12f2:	03040793          	addi	a5,s0,48
    12f6:	fcf43423          	sd	a5,-56(s0)
    12fa:	fc843783          	ld	a5,-56(s0)
    12fe:	fd078793          	addi	a5,a5,-48
    1302:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1306:	fe843703          	ld	a4,-24(s0)
    130a:	fdc42783          	lw	a5,-36(s0)
    130e:	863a                	mv	a2,a4
    1310:	fd043583          	ld	a1,-48(s0)
    1314:	853e                	mv	a0,a5
    1316:	b3dff0ef          	jal	e52 <vprintf>
}
    131a:	0001                	nop
    131c:	70e2                	ld	ra,56(sp)
    131e:	7442                	ld	s0,48(sp)
    1320:	6165                	addi	sp,sp,112
    1322:	8082                	ret

0000000000001324 <printf>:

void
printf(const char *fmt, ...)
{
    1324:	7159                	addi	sp,sp,-112
    1326:	f406                	sd	ra,40(sp)
    1328:	f022                	sd	s0,32(sp)
    132a:	1800                	addi	s0,sp,48
    132c:	fca43c23          	sd	a0,-40(s0)
    1330:	e40c                	sd	a1,8(s0)
    1332:	e810                	sd	a2,16(s0)
    1334:	ec14                	sd	a3,24(s0)
    1336:	f018                	sd	a4,32(s0)
    1338:	f41c                	sd	a5,40(s0)
    133a:	03043823          	sd	a6,48(s0)
    133e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1342:	04040793          	addi	a5,s0,64
    1346:	fcf43823          	sd	a5,-48(s0)
    134a:	fd043783          	ld	a5,-48(s0)
    134e:	fc878793          	addi	a5,a5,-56
    1352:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1356:	fe843783          	ld	a5,-24(s0)
    135a:	863e                	mv	a2,a5
    135c:	fd843583          	ld	a1,-40(s0)
    1360:	4505                	li	a0,1
    1362:	af1ff0ef          	jal	e52 <vprintf>
}
    1366:	0001                	nop
    1368:	70a2                	ld	ra,40(sp)
    136a:	7402                	ld	s0,32(sp)
    136c:	6165                	addi	sp,sp,112
    136e:	8082                	ret

0000000000001370 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1370:	7179                	addi	sp,sp,-48
    1372:	f406                	sd	ra,40(sp)
    1374:	f022                	sd	s0,32(sp)
    1376:	1800                	addi	s0,sp,48
    1378:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    137c:	fd843783          	ld	a5,-40(s0)
    1380:	17c1                	addi	a5,a5,-16
    1382:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1386:	00001797          	auipc	a5,0x1
    138a:	cda78793          	addi	a5,a5,-806 # 2060 <freep>
    138e:	639c                	ld	a5,0(a5)
    1390:	fef43423          	sd	a5,-24(s0)
    1394:	a815                	j	13c8 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1396:	fe843783          	ld	a5,-24(s0)
    139a:	639c                	ld	a5,0(a5)
    139c:	fe843703          	ld	a4,-24(s0)
    13a0:	00f76f63          	bltu	a4,a5,13be <free+0x4e>
    13a4:	fe043703          	ld	a4,-32(s0)
    13a8:	fe843783          	ld	a5,-24(s0)
    13ac:	02e7eb63          	bltu	a5,a4,13e2 <free+0x72>
    13b0:	fe843783          	ld	a5,-24(s0)
    13b4:	639c                	ld	a5,0(a5)
    13b6:	fe043703          	ld	a4,-32(s0)
    13ba:	02f76463          	bltu	a4,a5,13e2 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13be:	fe843783          	ld	a5,-24(s0)
    13c2:	639c                	ld	a5,0(a5)
    13c4:	fef43423          	sd	a5,-24(s0)
    13c8:	fe043703          	ld	a4,-32(s0)
    13cc:	fe843783          	ld	a5,-24(s0)
    13d0:	fce7f3e3          	bgeu	a5,a4,1396 <free+0x26>
    13d4:	fe843783          	ld	a5,-24(s0)
    13d8:	639c                	ld	a5,0(a5)
    13da:	fe043703          	ld	a4,-32(s0)
    13de:	faf77ce3          	bgeu	a4,a5,1396 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13e2:	fe043783          	ld	a5,-32(s0)
    13e6:	479c                	lw	a5,8(a5)
    13e8:	1782                	slli	a5,a5,0x20
    13ea:	9381                	srli	a5,a5,0x20
    13ec:	0792                	slli	a5,a5,0x4
    13ee:	fe043703          	ld	a4,-32(s0)
    13f2:	973e                	add	a4,a4,a5
    13f4:	fe843783          	ld	a5,-24(s0)
    13f8:	639c                	ld	a5,0(a5)
    13fa:	02f71763          	bne	a4,a5,1428 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    13fe:	fe043783          	ld	a5,-32(s0)
    1402:	4798                	lw	a4,8(a5)
    1404:	fe843783          	ld	a5,-24(s0)
    1408:	639c                	ld	a5,0(a5)
    140a:	479c                	lw	a5,8(a5)
    140c:	9fb9                	addw	a5,a5,a4
    140e:	0007871b          	sext.w	a4,a5
    1412:	fe043783          	ld	a5,-32(s0)
    1416:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1418:	fe843783          	ld	a5,-24(s0)
    141c:	639c                	ld	a5,0(a5)
    141e:	6398                	ld	a4,0(a5)
    1420:	fe043783          	ld	a5,-32(s0)
    1424:	e398                	sd	a4,0(a5)
    1426:	a039                	j	1434 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    1428:	fe843783          	ld	a5,-24(s0)
    142c:	6398                	ld	a4,0(a5)
    142e:	fe043783          	ld	a5,-32(s0)
    1432:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1434:	fe843783          	ld	a5,-24(s0)
    1438:	479c                	lw	a5,8(a5)
    143a:	1782                	slli	a5,a5,0x20
    143c:	9381                	srli	a5,a5,0x20
    143e:	0792                	slli	a5,a5,0x4
    1440:	fe843703          	ld	a4,-24(s0)
    1444:	97ba                	add	a5,a5,a4
    1446:	fe043703          	ld	a4,-32(s0)
    144a:	02f71563          	bne	a4,a5,1474 <free+0x104>
    p->s.size += bp->s.size;
    144e:	fe843783          	ld	a5,-24(s0)
    1452:	4798                	lw	a4,8(a5)
    1454:	fe043783          	ld	a5,-32(s0)
    1458:	479c                	lw	a5,8(a5)
    145a:	9fb9                	addw	a5,a5,a4
    145c:	0007871b          	sext.w	a4,a5
    1460:	fe843783          	ld	a5,-24(s0)
    1464:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1466:	fe043783          	ld	a5,-32(s0)
    146a:	6398                	ld	a4,0(a5)
    146c:	fe843783          	ld	a5,-24(s0)
    1470:	e398                	sd	a4,0(a5)
    1472:	a031                	j	147e <free+0x10e>
  } else
    p->s.ptr = bp;
    1474:	fe843783          	ld	a5,-24(s0)
    1478:	fe043703          	ld	a4,-32(s0)
    147c:	e398                	sd	a4,0(a5)
  freep = p;
    147e:	00001797          	auipc	a5,0x1
    1482:	be278793          	addi	a5,a5,-1054 # 2060 <freep>
    1486:	fe843703          	ld	a4,-24(s0)
    148a:	e398                	sd	a4,0(a5)
}
    148c:	0001                	nop
    148e:	70a2                	ld	ra,40(sp)
    1490:	7402                	ld	s0,32(sp)
    1492:	6145                	addi	sp,sp,48
    1494:	8082                	ret

0000000000001496 <morecore>:

static Header*
morecore(uint nu)
{
    1496:	7179                	addi	sp,sp,-48
    1498:	f406                	sd	ra,40(sp)
    149a:	f022                	sd	s0,32(sp)
    149c:	1800                	addi	s0,sp,48
    149e:	87aa                	mv	a5,a0
    14a0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    14a4:	fdc42783          	lw	a5,-36(s0)
    14a8:	0007871b          	sext.w	a4,a5
    14ac:	6785                	lui	a5,0x1
    14ae:	00f77563          	bgeu	a4,a5,14b8 <morecore+0x22>
    nu = 4096;
    14b2:	6785                	lui	a5,0x1
    14b4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    14b8:	fdc42783          	lw	a5,-36(s0)
    14bc:	0047979b          	slliw	a5,a5,0x4
    14c0:	2781                	sext.w	a5,a5
    14c2:	853e                	mv	a0,a5
    14c4:	ee8ff0ef          	jal	bac <sbrk>
    14c8:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    14cc:	fe843703          	ld	a4,-24(s0)
    14d0:	57fd                	li	a5,-1
    14d2:	00f71463          	bne	a4,a5,14da <morecore+0x44>
    return 0;
    14d6:	4781                	li	a5,0
    14d8:	a02d                	j	1502 <morecore+0x6c>
  hp = (Header*)p;
    14da:	fe843783          	ld	a5,-24(s0)
    14de:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    14e2:	fe043783          	ld	a5,-32(s0)
    14e6:	fdc42703          	lw	a4,-36(s0)
    14ea:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    14ec:	fe043783          	ld	a5,-32(s0)
    14f0:	07c1                	addi	a5,a5,16 # 1010 <vprintf+0x1be>
    14f2:	853e                	mv	a0,a5
    14f4:	e7dff0ef          	jal	1370 <free>
  return freep;
    14f8:	00001797          	auipc	a5,0x1
    14fc:	b6878793          	addi	a5,a5,-1176 # 2060 <freep>
    1500:	639c                	ld	a5,0(a5)
}
    1502:	853e                	mv	a0,a5
    1504:	70a2                	ld	ra,40(sp)
    1506:	7402                	ld	s0,32(sp)
    1508:	6145                	addi	sp,sp,48
    150a:	8082                	ret

000000000000150c <malloc>:

void*
malloc(uint nbytes)
{
    150c:	7139                	addi	sp,sp,-64
    150e:	fc06                	sd	ra,56(sp)
    1510:	f822                	sd	s0,48(sp)
    1512:	0080                	addi	s0,sp,64
    1514:	87aa                	mv	a5,a0
    1516:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    151a:	fcc46783          	lwu	a5,-52(s0)
    151e:	07bd                	addi	a5,a5,15
    1520:	8391                	srli	a5,a5,0x4
    1522:	2781                	sext.w	a5,a5
    1524:	2785                	addiw	a5,a5,1
    1526:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    152a:	00001797          	auipc	a5,0x1
    152e:	b3678793          	addi	a5,a5,-1226 # 2060 <freep>
    1532:	639c                	ld	a5,0(a5)
    1534:	fef43023          	sd	a5,-32(s0)
    1538:	fe043783          	ld	a5,-32(s0)
    153c:	ef95                	bnez	a5,1578 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    153e:	00001797          	auipc	a5,0x1
    1542:	b1278793          	addi	a5,a5,-1262 # 2050 <base>
    1546:	fef43023          	sd	a5,-32(s0)
    154a:	00001797          	auipc	a5,0x1
    154e:	b1678793          	addi	a5,a5,-1258 # 2060 <freep>
    1552:	fe043703          	ld	a4,-32(s0)
    1556:	e398                	sd	a4,0(a5)
    1558:	00001797          	auipc	a5,0x1
    155c:	b0878793          	addi	a5,a5,-1272 # 2060 <freep>
    1560:	6398                	ld	a4,0(a5)
    1562:	00001797          	auipc	a5,0x1
    1566:	aee78793          	addi	a5,a5,-1298 # 2050 <base>
    156a:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    156c:	00001797          	auipc	a5,0x1
    1570:	ae478793          	addi	a5,a5,-1308 # 2050 <base>
    1574:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1578:	fe043783          	ld	a5,-32(s0)
    157c:	639c                	ld	a5,0(a5)
    157e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1582:	fe843783          	ld	a5,-24(s0)
    1586:	479c                	lw	a5,8(a5)
    1588:	fdc42703          	lw	a4,-36(s0)
    158c:	2701                	sext.w	a4,a4
    158e:	06e7e763          	bltu	a5,a4,15fc <malloc+0xf0>
      if(p->s.size == nunits)
    1592:	fe843783          	ld	a5,-24(s0)
    1596:	479c                	lw	a5,8(a5)
    1598:	fdc42703          	lw	a4,-36(s0)
    159c:	2701                	sext.w	a4,a4
    159e:	00f71963          	bne	a4,a5,15b0 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    15a2:	fe843783          	ld	a5,-24(s0)
    15a6:	6398                	ld	a4,0(a5)
    15a8:	fe043783          	ld	a5,-32(s0)
    15ac:	e398                	sd	a4,0(a5)
    15ae:	a825                	j	15e6 <malloc+0xda>
      else {
        p->s.size -= nunits;
    15b0:	fe843783          	ld	a5,-24(s0)
    15b4:	479c                	lw	a5,8(a5)
    15b6:	fdc42703          	lw	a4,-36(s0)
    15ba:	9f99                	subw	a5,a5,a4
    15bc:	0007871b          	sext.w	a4,a5
    15c0:	fe843783          	ld	a5,-24(s0)
    15c4:	c798                	sw	a4,8(a5)
        p += p->s.size;
    15c6:	fe843783          	ld	a5,-24(s0)
    15ca:	479c                	lw	a5,8(a5)
    15cc:	1782                	slli	a5,a5,0x20
    15ce:	9381                	srli	a5,a5,0x20
    15d0:	0792                	slli	a5,a5,0x4
    15d2:	fe843703          	ld	a4,-24(s0)
    15d6:	97ba                	add	a5,a5,a4
    15d8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    15dc:	fe843783          	ld	a5,-24(s0)
    15e0:	fdc42703          	lw	a4,-36(s0)
    15e4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    15e6:	00001797          	auipc	a5,0x1
    15ea:	a7a78793          	addi	a5,a5,-1414 # 2060 <freep>
    15ee:	fe043703          	ld	a4,-32(s0)
    15f2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    15f4:	fe843783          	ld	a5,-24(s0)
    15f8:	07c1                	addi	a5,a5,16
    15fa:	a081                	j	163a <malloc+0x12e>
    }
    if(p == freep)
    15fc:	00001797          	auipc	a5,0x1
    1600:	a6478793          	addi	a5,a5,-1436 # 2060 <freep>
    1604:	639c                	ld	a5,0(a5)
    1606:	fe843703          	ld	a4,-24(s0)
    160a:	00f71e63          	bne	a4,a5,1626 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    160e:	fdc42783          	lw	a5,-36(s0)
    1612:	853e                	mv	a0,a5
    1614:	e83ff0ef          	jal	1496 <morecore>
    1618:	fea43423          	sd	a0,-24(s0)
    161c:	fe843783          	ld	a5,-24(s0)
    1620:	e399                	bnez	a5,1626 <malloc+0x11a>
        return 0;
    1622:	4781                	li	a5,0
    1624:	a819                	j	163a <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1626:	fe843783          	ld	a5,-24(s0)
    162a:	fef43023          	sd	a5,-32(s0)
    162e:	fe843783          	ld	a5,-24(s0)
    1632:	639c                	ld	a5,0(a5)
    1634:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1638:	b7a9                	j	1582 <malloc+0x76>
  }
}
    163a:	853e                	mv	a0,a5
    163c:	70e2                	ld	ra,56(sp)
    163e:	7442                	ld	s0,48(sp)
    1640:	6121                	addi	sp,sp,64
    1642:	8082                	ret
