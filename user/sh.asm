
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <runcmd>:
void runcmd(struct cmd*) __attribute__((noreturn));

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	715d                	addi	sp,sp,-80
       2:	e486                	sd	ra,72(sp)
       4:	e0a2                	sd	s0,64(sp)
       6:	0880                	addi	s0,sp,80
       8:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       c:	fb843783          	ld	a5,-72(s0)
      10:	e781                	bnez	a5,18 <runcmd+0x18>
    exit(1);
      12:	4505                	li	a0,1
      14:	2a2010ef          	jal	12b6 <exit>

  switch(cmd->type){
      18:	fb843783          	ld	a5,-72(s0)
      1c:	439c                	lw	a5,0(a5)
      1e:	4715                	li	a4,5
      20:	02f76263          	bltu	a4,a5,44 <runcmd+0x44>
      24:	00279713          	slli	a4,a5,0x2
      28:	00002797          	auipc	a5,0x2
      2c:	d0878793          	addi	a5,a5,-760 # 1d30 <malloc+0x176>
      30:	97ba                	add	a5,a5,a4
      32:	439c                	lw	a5,0(a5)
      34:	0007871b          	sext.w	a4,a5
      38:	00002797          	auipc	a5,0x2
      3c:	cf878793          	addi	a5,a5,-776 # 1d30 <malloc+0x176>
      40:	97ba                	add	a5,a5,a4
      42:	8782                	jr	a5
  default:
    panic("runcmd");
      44:	00002517          	auipc	a0,0x2
      48:	cbc50513          	addi	a0,a0,-836 # 1d00 <malloc+0x146>
      4c:	34a000ef          	jal	396 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      50:	fb843783          	ld	a5,-72(s0)
      54:	fcf43423          	sd	a5,-56(s0)
    if(ecmd->argv[0] == 0)
      58:	fc843783          	ld	a5,-56(s0)
      5c:	679c                	ld	a5,8(a5)
      5e:	e781                	bnez	a5,66 <runcmd+0x66>
      exit(1);
      60:	4505                	li	a0,1
      62:	254010ef          	jal	12b6 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      66:	fc843783          	ld	a5,-56(s0)
      6a:	6798                	ld	a4,8(a5)
      6c:	fc843783          	ld	a5,-56(s0)
      70:	07a1                	addi	a5,a5,8
      72:	85be                	mv	a1,a5
      74:	853a                	mv	a0,a4
      76:	278010ef          	jal	12ee <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      7a:	fc843783          	ld	a5,-56(s0)
      7e:	679c                	ld	a5,8(a5)
      80:	863e                	mv	a2,a5
      82:	00002597          	auipc	a1,0x2
      86:	c8658593          	addi	a1,a1,-890 # 1d08 <malloc+0x14e>
      8a:	4509                	li	a0,2
      8c:	0f3010ef          	jal	197e <fprintf>
    break;
      90:	aaa9                	j	1ea <runcmd+0x1ea>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      92:	fb843783          	ld	a5,-72(s0)
      96:	fcf43823          	sd	a5,-48(s0)
    close(rcmd->fd);
      9a:	fd043783          	ld	a5,-48(s0)
      9e:	53dc                	lw	a5,36(a5)
      a0:	853e                	mv	a0,a5
      a2:	23c010ef          	jal	12de <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      a6:	fd043783          	ld	a5,-48(s0)
      aa:	6b98                	ld	a4,16(a5)
      ac:	fd043783          	ld	a5,-48(s0)
      b0:	539c                	lw	a5,32(a5)
      b2:	85be                	mv	a1,a5
      b4:	853a                	mv	a0,a4
      b6:	240010ef          	jal	12f6 <open>
      ba:	87aa                	mv	a5,a0
      bc:	0207d063          	bgez	a5,dc <runcmd+0xdc>
      fprintf(2, "open %s failed\n", rcmd->file);
      c0:	fd043783          	ld	a5,-48(s0)
      c4:	6b9c                	ld	a5,16(a5)
      c6:	863e                	mv	a2,a5
      c8:	00002597          	auipc	a1,0x2
      cc:	c5058593          	addi	a1,a1,-944 # 1d18 <malloc+0x15e>
      d0:	4509                	li	a0,2
      d2:	0ad010ef          	jal	197e <fprintf>
      exit(1);
      d6:	4505                	li	a0,1
      d8:	1de010ef          	jal	12b6 <exit>
    }
    runcmd(rcmd->cmd);
      dc:	fd043783          	ld	a5,-48(s0)
      e0:	679c                	ld	a5,8(a5)
      e2:	853e                	mv	a0,a5
      e4:	f1dff0ef          	jal	0 <runcmd>
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
      e8:	fb843783          	ld	a5,-72(s0)
      ec:	fef43023          	sd	a5,-32(s0)
    if(fork1() == 0)
      f0:	2ca000ef          	jal	3ba <fork1>
      f4:	87aa                	mv	a5,a0
      f6:	e799                	bnez	a5,104 <runcmd+0x104>
      runcmd(lcmd->left);
      f8:	fe043783          	ld	a5,-32(s0)
      fc:	679c                	ld	a5,8(a5)
      fe:	853e                	mv	a0,a5
     100:	f01ff0ef          	jal	0 <runcmd>
    wait(0);
     104:	4501                	li	a0,0
     106:	1b8010ef          	jal	12be <wait>
    runcmd(lcmd->right);
     10a:	fe043783          	ld	a5,-32(s0)
     10e:	6b9c                	ld	a5,16(a5)
     110:	853e                	mv	a0,a5
     112:	eefff0ef          	jal	0 <runcmd>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     116:	fb843783          	ld	a5,-72(s0)
     11a:	fcf43c23          	sd	a5,-40(s0)
    if(pipe(p) < 0)
     11e:	fc040793          	addi	a5,s0,-64
     122:	853e                	mv	a0,a5
     124:	1a2010ef          	jal	12c6 <pipe>
     128:	87aa                	mv	a5,a0
     12a:	0007d863          	bgez	a5,13a <runcmd+0x13a>
      panic("pipe");
     12e:	00002517          	auipc	a0,0x2
     132:	bfa50513          	addi	a0,a0,-1030 # 1d28 <malloc+0x16e>
     136:	260000ef          	jal	396 <panic>
    if(fork1() == 0){
     13a:	280000ef          	jal	3ba <fork1>
     13e:	87aa                	mv	a5,a0
     140:	eb8d                	bnez	a5,172 <runcmd+0x172>
      close(1);
     142:	4505                	li	a0,1
     144:	19a010ef          	jal	12de <close>
      dup(p[1]);
     148:	fc442783          	lw	a5,-60(s0)
     14c:	853e                	mv	a0,a5
     14e:	1e0010ef          	jal	132e <dup>
      close(p[0]);
     152:	fc042783          	lw	a5,-64(s0)
     156:	853e                	mv	a0,a5
     158:	186010ef          	jal	12de <close>
      close(p[1]);
     15c:	fc442783          	lw	a5,-60(s0)
     160:	853e                	mv	a0,a5
     162:	17c010ef          	jal	12de <close>
      runcmd(pcmd->left);
     166:	fd843783          	ld	a5,-40(s0)
     16a:	679c                	ld	a5,8(a5)
     16c:	853e                	mv	a0,a5
     16e:	e93ff0ef          	jal	0 <runcmd>
    }
    if(fork1() == 0){
     172:	248000ef          	jal	3ba <fork1>
     176:	87aa                	mv	a5,a0
     178:	eb8d                	bnez	a5,1aa <runcmd+0x1aa>
      close(0);
     17a:	4501                	li	a0,0
     17c:	162010ef          	jal	12de <close>
      dup(p[0]);
     180:	fc042783          	lw	a5,-64(s0)
     184:	853e                	mv	a0,a5
     186:	1a8010ef          	jal	132e <dup>
      close(p[0]);
     18a:	fc042783          	lw	a5,-64(s0)
     18e:	853e                	mv	a0,a5
     190:	14e010ef          	jal	12de <close>
      close(p[1]);
     194:	fc442783          	lw	a5,-60(s0)
     198:	853e                	mv	a0,a5
     19a:	144010ef          	jal	12de <close>
      runcmd(pcmd->right);
     19e:	fd843783          	ld	a5,-40(s0)
     1a2:	6b9c                	ld	a5,16(a5)
     1a4:	853e                	mv	a0,a5
     1a6:	e5bff0ef          	jal	0 <runcmd>
    }
    close(p[0]);
     1aa:	fc042783          	lw	a5,-64(s0)
     1ae:	853e                	mv	a0,a5
     1b0:	12e010ef          	jal	12de <close>
    close(p[1]);
     1b4:	fc442783          	lw	a5,-60(s0)
     1b8:	853e                	mv	a0,a5
     1ba:	124010ef          	jal	12de <close>
    wait(0);
     1be:	4501                	li	a0,0
     1c0:	0fe010ef          	jal	12be <wait>
    wait(0);
     1c4:	4501                	li	a0,0
     1c6:	0f8010ef          	jal	12be <wait>
    break;
     1ca:	a005                	j	1ea <runcmd+0x1ea>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     1cc:	fb843783          	ld	a5,-72(s0)
     1d0:	fef43423          	sd	a5,-24(s0)
    if(fork1() == 0)
     1d4:	1e6000ef          	jal	3ba <fork1>
     1d8:	87aa                	mv	a5,a0
     1da:	e799                	bnez	a5,1e8 <runcmd+0x1e8>
      runcmd(bcmd->cmd);
     1dc:	fe843783          	ld	a5,-24(s0)
     1e0:	679c                	ld	a5,8(a5)
     1e2:	853e                	mv	a0,a5
     1e4:	e1dff0ef          	jal	0 <runcmd>
    break;
     1e8:	0001                	nop
  }
  exit(0);
     1ea:	4501                	li	a0,0
     1ec:	0ca010ef          	jal	12b6 <exit>

00000000000001f0 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     1f0:	1101                	addi	sp,sp,-32
     1f2:	ec06                	sd	ra,24(sp)
     1f4:	e822                	sd	s0,16(sp)
     1f6:	1000                	addi	s0,sp,32
     1f8:	fea43423          	sd	a0,-24(s0)
     1fc:	87ae                	mv	a5,a1
     1fe:	fef42223          	sw	a5,-28(s0)
  write(2, "$ ", 2);
     202:	4609                	li	a2,2
     204:	00002597          	auipc	a1,0x2
     208:	b4458593          	addi	a1,a1,-1212 # 1d48 <malloc+0x18e>
     20c:	4509                	li	a0,2
     20e:	0c8010ef          	jal	12d6 <write>
  memset(buf, 0, nbuf);
     212:	fe442783          	lw	a5,-28(s0)
     216:	863e                	mv	a2,a5
     218:	4581                	li	a1,0
     21a:	fe843503          	ld	a0,-24(s0)
     21e:	4a3000ef          	jal	ec0 <memset>
  gets(buf, nbuf);
     222:	fe442783          	lw	a5,-28(s0)
     226:	85be                	mv	a1,a5
     228:	fe843503          	ld	a0,-24(s0)
     22c:	547000ef          	jal	f72 <gets>
  if(buf[0] == 0) // EOF
     230:	fe843783          	ld	a5,-24(s0)
     234:	0007c783          	lbu	a5,0(a5)
     238:	e399                	bnez	a5,23e <getcmd+0x4e>
    return -1;
     23a:	57fd                	li	a5,-1
     23c:	a011                	j	240 <getcmd+0x50>
  return 0;
     23e:	4781                	li	a5,0
}
     240:	853e                	mv	a0,a5
     242:	60e2                	ld	ra,24(sp)
     244:	6442                	ld	s0,16(sp)
     246:	6105                	addi	sp,sp,32
     248:	8082                	ret

000000000000024a <main>:

int
main(void)
{
     24a:	1101                	addi	sp,sp,-32
     24c:	ec06                	sd	ra,24(sp)
     24e:	e822                	sd	s0,16(sp)
     250:	1000                	addi	s0,sp,32
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     252:	a831                	j	26e <main+0x24>
    if(fd >= 3){
     254:	fe442783          	lw	a5,-28(s0)
     258:	0007871b          	sext.w	a4,a5
     25c:	4789                	li	a5,2
     25e:	00e7d863          	bge	a5,a4,26e <main+0x24>
      close(fd);
     262:	fe442783          	lw	a5,-28(s0)
     266:	853e                	mv	a0,a5
     268:	076010ef          	jal	12de <close>
      break;
     26c:	a005                	j	28c <main+0x42>
  while((fd = open("console", O_RDWR)) >= 0){
     26e:	4589                	li	a1,2
     270:	00002517          	auipc	a0,0x2
     274:	ae050513          	addi	a0,a0,-1312 # 1d50 <malloc+0x196>
     278:	07e010ef          	jal	12f6 <open>
     27c:	87aa                	mv	a5,a0
     27e:	fef42223          	sw	a5,-28(s0)
     282:	fe442783          	lw	a5,-28(s0)
     286:	2781                	sext.w	a5,a5
     288:	fc07d6e3          	bgez	a5,254 <main+0xa>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     28c:	a0fd                	j	37a <main+0x130>
    char *cmd = buf;
     28e:	00002797          	auipc	a5,0x2
     292:	da278793          	addi	a5,a5,-606 # 2030 <buf.0>
     296:	fef43423          	sd	a5,-24(s0)
    while (*cmd == ' ' || *cmd == '\t')
     29a:	a031                	j	2a6 <main+0x5c>
      cmd++;
     29c:	fe843783          	ld	a5,-24(s0)
     2a0:	0785                	addi	a5,a5,1
     2a2:	fef43423          	sd	a5,-24(s0)
    while (*cmd == ' ' || *cmd == '\t')
     2a6:	fe843783          	ld	a5,-24(s0)
     2aa:	0007c783          	lbu	a5,0(a5)
     2ae:	873e                	mv	a4,a5
     2b0:	02000793          	li	a5,32
     2b4:	fef704e3          	beq	a4,a5,29c <main+0x52>
     2b8:	fe843783          	ld	a5,-24(s0)
     2bc:	0007c783          	lbu	a5,0(a5)
     2c0:	873e                	mv	a4,a5
     2c2:	47a5                	li	a5,9
     2c4:	fcf70ce3          	beq	a4,a5,29c <main+0x52>
    if (*cmd == '\n') // is a blank command
     2c8:	fe843783          	ld	a5,-24(s0)
     2cc:	0007c783          	lbu	a5,0(a5)
     2d0:	873e                	mv	a4,a5
     2d2:	47a9                	li	a5,10
     2d4:	0af70263          	beq	a4,a5,378 <main+0x12e>
      continue;
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     2d8:	fe843783          	ld	a5,-24(s0)
     2dc:	0007c783          	lbu	a5,0(a5)
     2e0:	873e                	mv	a4,a5
     2e2:	06300793          	li	a5,99
     2e6:	06f71963          	bne	a4,a5,358 <main+0x10e>
     2ea:	fe843783          	ld	a5,-24(s0)
     2ee:	0785                	addi	a5,a5,1
     2f0:	0007c783          	lbu	a5,0(a5)
     2f4:	873e                	mv	a4,a5
     2f6:	06400793          	li	a5,100
     2fa:	04f71f63          	bne	a4,a5,358 <main+0x10e>
     2fe:	fe843783          	ld	a5,-24(s0)
     302:	0789                	addi	a5,a5,2
     304:	0007c783          	lbu	a5,0(a5)
     308:	873e                	mv	a4,a5
     30a:	02000793          	li	a5,32
     30e:	04f71563          	bne	a4,a5,358 <main+0x10e>
      // Chdir must be called by the parent, not the child.
      cmd[strlen(cmd)-1] = 0;  // chop \n
     312:	fe843503          	ld	a0,-24(s0)
     316:	371000ef          	jal	e86 <strlen>
     31a:	87aa                	mv	a5,a0
     31c:	37fd                	addiw	a5,a5,-1
     31e:	2781                	sext.w	a5,a5
     320:	1782                	slli	a5,a5,0x20
     322:	9381                	srli	a5,a5,0x20
     324:	fe843703          	ld	a4,-24(s0)
     328:	97ba                	add	a5,a5,a4
     32a:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     32e:	fe843783          	ld	a5,-24(s0)
     332:	078d                	addi	a5,a5,3
     334:	853e                	mv	a0,a5
     336:	7f1000ef          	jal	1326 <chdir>
     33a:	87aa                	mv	a5,a0
     33c:	0207df63          	bgez	a5,37a <main+0x130>
        fprintf(2, "cannot cd %s\n", cmd+3);
     340:	fe843783          	ld	a5,-24(s0)
     344:	078d                	addi	a5,a5,3
     346:	863e                	mv	a2,a5
     348:	00002597          	auipc	a1,0x2
     34c:	a1058593          	addi	a1,a1,-1520 # 1d58 <malloc+0x19e>
     350:	4509                	li	a0,2
     352:	62c010ef          	jal	197e <fprintf>
      if(chdir(cmd+3) < 0)
     356:	a015                	j	37a <main+0x130>
    } else {
      if(fork1() == 0)
     358:	062000ef          	jal	3ba <fork1>
     35c:	87aa                	mv	a5,a0
     35e:	eb89                	bnez	a5,370 <main+0x126>
        runcmd(parsecmd(cmd));
     360:	fe843503          	ld	a0,-24(s0)
     364:	470000ef          	jal	7d4 <parsecmd>
     368:	87aa                	mv	a5,a0
     36a:	853e                	mv	a0,a5
     36c:	c95ff0ef          	jal	0 <runcmd>
      wait(0);
     370:	4501                	li	a0,0
     372:	74d000ef          	jal	12be <wait>
     376:	a011                	j	37a <main+0x130>
      continue;
     378:	0001                	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     37a:	06400593          	li	a1,100
     37e:	00002517          	auipc	a0,0x2
     382:	cb250513          	addi	a0,a0,-846 # 2030 <buf.0>
     386:	e6bff0ef          	jal	1f0 <getcmd>
     38a:	87aa                	mv	a5,a0
     38c:	f007d1e3          	bgez	a5,28e <main+0x44>
    }
  }
  exit(0);
     390:	4501                	li	a0,0
     392:	725000ef          	jal	12b6 <exit>

0000000000000396 <panic>:
}

void
panic(char *s)
{
     396:	1101                	addi	sp,sp,-32
     398:	ec06                	sd	ra,24(sp)
     39a:	e822                	sd	s0,16(sp)
     39c:	1000                	addi	s0,sp,32
     39e:	fea43423          	sd	a0,-24(s0)
  fprintf(2, "%s\n", s);
     3a2:	fe843603          	ld	a2,-24(s0)
     3a6:	00002597          	auipc	a1,0x2
     3aa:	9c258593          	addi	a1,a1,-1598 # 1d68 <malloc+0x1ae>
     3ae:	4509                	li	a0,2
     3b0:	5ce010ef          	jal	197e <fprintf>
  exit(1);
     3b4:	4505                	li	a0,1
     3b6:	701000ef          	jal	12b6 <exit>

00000000000003ba <fork1>:
}

int
fork1(void)
{
     3ba:	1101                	addi	sp,sp,-32
     3bc:	ec06                	sd	ra,24(sp)
     3be:	e822                	sd	s0,16(sp)
     3c0:	1000                	addi	s0,sp,32
  int pid;

  pid = fork();
     3c2:	6ed000ef          	jal	12ae <fork>
     3c6:	87aa                	mv	a5,a0
     3c8:	fef42623          	sw	a5,-20(s0)
  if(pid == -1)
     3cc:	fec42783          	lw	a5,-20(s0)
     3d0:	0007871b          	sext.w	a4,a5
     3d4:	57fd                	li	a5,-1
     3d6:	00f71863          	bne	a4,a5,3e6 <fork1+0x2c>
    panic("fork");
     3da:	00002517          	auipc	a0,0x2
     3de:	99650513          	addi	a0,a0,-1642 # 1d70 <malloc+0x1b6>
     3e2:	fb5ff0ef          	jal	396 <panic>
  return pid;
     3e6:	fec42783          	lw	a5,-20(s0)
}
     3ea:	853e                	mv	a0,a5
     3ec:	60e2                	ld	ra,24(sp)
     3ee:	6442                	ld	s0,16(sp)
     3f0:	6105                	addi	sp,sp,32
     3f2:	8082                	ret

00000000000003f4 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3f4:	1101                	addi	sp,sp,-32
     3f6:	ec06                	sd	ra,24(sp)
     3f8:	e822                	sd	s0,16(sp)
     3fa:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3fc:	0a800513          	li	a0,168
     400:	7ba010ef          	jal	1bba <malloc>
     404:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     408:	0a800613          	li	a2,168
     40c:	4581                	li	a1,0
     40e:	fe843503          	ld	a0,-24(s0)
     412:	2af000ef          	jal	ec0 <memset>
  cmd->type = EXEC;
     416:	fe843783          	ld	a5,-24(s0)
     41a:	4705                	li	a4,1
     41c:	c398                	sw	a4,0(a5)
  return (struct cmd*)cmd;
     41e:	fe843783          	ld	a5,-24(s0)
}
     422:	853e                	mv	a0,a5
     424:	60e2                	ld	ra,24(sp)
     426:	6442                	ld	s0,16(sp)
     428:	6105                	addi	sp,sp,32
     42a:	8082                	ret

000000000000042c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     42c:	7139                	addi	sp,sp,-64
     42e:	fc06                	sd	ra,56(sp)
     430:	f822                	sd	s0,48(sp)
     432:	0080                	addi	s0,sp,64
     434:	fca43c23          	sd	a0,-40(s0)
     438:	fcb43823          	sd	a1,-48(s0)
     43c:	fcc43423          	sd	a2,-56(s0)
     440:	87b6                	mv	a5,a3
     442:	fcf42223          	sw	a5,-60(s0)
     446:	87ba                	mv	a5,a4
     448:	fcf42023          	sw	a5,-64(s0)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     44c:	02800513          	li	a0,40
     450:	76a010ef          	jal	1bba <malloc>
     454:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     458:	02800613          	li	a2,40
     45c:	4581                	li	a1,0
     45e:	fe843503          	ld	a0,-24(s0)
     462:	25f000ef          	jal	ec0 <memset>
  cmd->type = REDIR;
     466:	fe843783          	ld	a5,-24(s0)
     46a:	4709                	li	a4,2
     46c:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     46e:	fe843783          	ld	a5,-24(s0)
     472:	fd843703          	ld	a4,-40(s0)
     476:	e798                	sd	a4,8(a5)
  cmd->file = file;
     478:	fe843783          	ld	a5,-24(s0)
     47c:	fd043703          	ld	a4,-48(s0)
     480:	eb98                	sd	a4,16(a5)
  cmd->efile = efile;
     482:	fe843783          	ld	a5,-24(s0)
     486:	fc843703          	ld	a4,-56(s0)
     48a:	ef98                	sd	a4,24(a5)
  cmd->mode = mode;
     48c:	fe843783          	ld	a5,-24(s0)
     490:	fc442703          	lw	a4,-60(s0)
     494:	d398                	sw	a4,32(a5)
  cmd->fd = fd;
     496:	fe843783          	ld	a5,-24(s0)
     49a:	fc042703          	lw	a4,-64(s0)
     49e:	d3d8                	sw	a4,36(a5)
  return (struct cmd*)cmd;
     4a0:	fe843783          	ld	a5,-24(s0)
}
     4a4:	853e                	mv	a0,a5
     4a6:	70e2                	ld	ra,56(sp)
     4a8:	7442                	ld	s0,48(sp)
     4aa:	6121                	addi	sp,sp,64
     4ac:	8082                	ret

00000000000004ae <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4ae:	7179                	addi	sp,sp,-48
     4b0:	f406                	sd	ra,40(sp)
     4b2:	f022                	sd	s0,32(sp)
     4b4:	1800                	addi	s0,sp,48
     4b6:	fca43c23          	sd	a0,-40(s0)
     4ba:	fcb43823          	sd	a1,-48(s0)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4be:	4561                	li	a0,24
     4c0:	6fa010ef          	jal	1bba <malloc>
     4c4:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     4c8:	4661                	li	a2,24
     4ca:	4581                	li	a1,0
     4cc:	fe843503          	ld	a0,-24(s0)
     4d0:	1f1000ef          	jal	ec0 <memset>
  cmd->type = PIPE;
     4d4:	fe843783          	ld	a5,-24(s0)
     4d8:	470d                	li	a4,3
     4da:	c398                	sw	a4,0(a5)
  cmd->left = left;
     4dc:	fe843783          	ld	a5,-24(s0)
     4e0:	fd843703          	ld	a4,-40(s0)
     4e4:	e798                	sd	a4,8(a5)
  cmd->right = right;
     4e6:	fe843783          	ld	a5,-24(s0)
     4ea:	fd043703          	ld	a4,-48(s0)
     4ee:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     4f0:	fe843783          	ld	a5,-24(s0)
}
     4f4:	853e                	mv	a0,a5
     4f6:	70a2                	ld	ra,40(sp)
     4f8:	7402                	ld	s0,32(sp)
     4fa:	6145                	addi	sp,sp,48
     4fc:	8082                	ret

00000000000004fe <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4fe:	7179                	addi	sp,sp,-48
     500:	f406                	sd	ra,40(sp)
     502:	f022                	sd	s0,32(sp)
     504:	1800                	addi	s0,sp,48
     506:	fca43c23          	sd	a0,-40(s0)
     50a:	fcb43823          	sd	a1,-48(s0)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     50e:	4561                	li	a0,24
     510:	6aa010ef          	jal	1bba <malloc>
     514:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     518:	4661                	li	a2,24
     51a:	4581                	li	a1,0
     51c:	fe843503          	ld	a0,-24(s0)
     520:	1a1000ef          	jal	ec0 <memset>
  cmd->type = LIST;
     524:	fe843783          	ld	a5,-24(s0)
     528:	4711                	li	a4,4
     52a:	c398                	sw	a4,0(a5)
  cmd->left = left;
     52c:	fe843783          	ld	a5,-24(s0)
     530:	fd843703          	ld	a4,-40(s0)
     534:	e798                	sd	a4,8(a5)
  cmd->right = right;
     536:	fe843783          	ld	a5,-24(s0)
     53a:	fd043703          	ld	a4,-48(s0)
     53e:	eb98                	sd	a4,16(a5)
  return (struct cmd*)cmd;
     540:	fe843783          	ld	a5,-24(s0)
}
     544:	853e                	mv	a0,a5
     546:	70a2                	ld	ra,40(sp)
     548:	7402                	ld	s0,32(sp)
     54a:	6145                	addi	sp,sp,48
     54c:	8082                	ret

000000000000054e <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     54e:	7179                	addi	sp,sp,-48
     550:	f406                	sd	ra,40(sp)
     552:	f022                	sd	s0,32(sp)
     554:	1800                	addi	s0,sp,48
     556:	fca43c23          	sd	a0,-40(s0)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     55a:	4541                	li	a0,16
     55c:	65e010ef          	jal	1bba <malloc>
     560:	fea43423          	sd	a0,-24(s0)
  memset(cmd, 0, sizeof(*cmd));
     564:	4641                	li	a2,16
     566:	4581                	li	a1,0
     568:	fe843503          	ld	a0,-24(s0)
     56c:	155000ef          	jal	ec0 <memset>
  cmd->type = BACK;
     570:	fe843783          	ld	a5,-24(s0)
     574:	4715                	li	a4,5
     576:	c398                	sw	a4,0(a5)
  cmd->cmd = subcmd;
     578:	fe843783          	ld	a5,-24(s0)
     57c:	fd843703          	ld	a4,-40(s0)
     580:	e798                	sd	a4,8(a5)
  return (struct cmd*)cmd;
     582:	fe843783          	ld	a5,-24(s0)
}
     586:	853e                	mv	a0,a5
     588:	70a2                	ld	ra,40(sp)
     58a:	7402                	ld	s0,32(sp)
     58c:	6145                	addi	sp,sp,48
     58e:	8082                	ret

0000000000000590 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     590:	7139                	addi	sp,sp,-64
     592:	fc06                	sd	ra,56(sp)
     594:	f822                	sd	s0,48(sp)
     596:	0080                	addi	s0,sp,64
     598:	fca43c23          	sd	a0,-40(s0)
     59c:	fcb43823          	sd	a1,-48(s0)
     5a0:	fcc43423          	sd	a2,-56(s0)
     5a4:	fcd43023          	sd	a3,-64(s0)
  char *s;
  int ret;

  s = *ps;
     5a8:	fd843783          	ld	a5,-40(s0)
     5ac:	639c                	ld	a5,0(a5)
     5ae:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     5b2:	a031                	j	5be <gettoken+0x2e>
    s++;
     5b4:	fe843783          	ld	a5,-24(s0)
     5b8:	0785                	addi	a5,a5,1
     5ba:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     5be:	fe843703          	ld	a4,-24(s0)
     5c2:	fd043783          	ld	a5,-48(s0)
     5c6:	00f77f63          	bgeu	a4,a5,5e4 <gettoken+0x54>
     5ca:	fe843783          	ld	a5,-24(s0)
     5ce:	0007c783          	lbu	a5,0(a5)
     5d2:	85be                	mv	a1,a5
     5d4:	00002517          	auipc	a0,0x2
     5d8:	a2c50513          	addi	a0,a0,-1492 # 2000 <whitespace>
     5dc:	149000ef          	jal	f24 <strchr>
     5e0:	87aa                	mv	a5,a0
     5e2:	fbe9                	bnez	a5,5b4 <gettoken+0x24>
  if(q)
     5e4:	fc843783          	ld	a5,-56(s0)
     5e8:	c791                	beqz	a5,5f4 <gettoken+0x64>
    *q = s;
     5ea:	fc843783          	ld	a5,-56(s0)
     5ee:	fe843703          	ld	a4,-24(s0)
     5f2:	e398                	sd	a4,0(a5)
  ret = *s;
     5f4:	fe843783          	ld	a5,-24(s0)
     5f8:	0007c783          	lbu	a5,0(a5)
     5fc:	fef42223          	sw	a5,-28(s0)
  switch(*s){
     600:	fe843783          	ld	a5,-24(s0)
     604:	0007c783          	lbu	a5,0(a5)
     608:	2781                	sext.w	a5,a5
     60a:	07c00713          	li	a4,124
     60e:	04e78363          	beq	a5,a4,654 <gettoken+0xc4>
     612:	07c00713          	li	a4,124
     616:	06f74d63          	blt	a4,a5,690 <gettoken+0x100>
     61a:	03e00713          	li	a4,62
     61e:	04e78163          	beq	a5,a4,660 <gettoken+0xd0>
     622:	03e00713          	li	a4,62
     626:	06f74563          	blt	a4,a5,690 <gettoken+0x100>
     62a:	03c00713          	li	a4,60
     62e:	06f74163          	blt	a4,a5,690 <gettoken+0x100>
     632:	03b00713          	li	a4,59
     636:	00e7df63          	bge	a5,a4,654 <gettoken+0xc4>
     63a:	02900713          	li	a4,41
     63e:	04f74963          	blt	a4,a5,690 <gettoken+0x100>
     642:	02800713          	li	a4,40
     646:	00e7d763          	bge	a5,a4,654 <gettoken+0xc4>
     64a:	cfd1                	beqz	a5,6e6 <gettoken+0x156>
     64c:	02600713          	li	a4,38
     650:	04e79063          	bne	a5,a4,690 <gettoken+0x100>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     654:	fe843783          	ld	a5,-24(s0)
     658:	0785                	addi	a5,a5,1
     65a:	fef43423          	sd	a5,-24(s0)
    break;
     65e:	a849                	j	6f0 <gettoken+0x160>
  case '>':
    s++;
     660:	fe843783          	ld	a5,-24(s0)
     664:	0785                	addi	a5,a5,1
     666:	fef43423          	sd	a5,-24(s0)
    if(*s == '>'){
     66a:	fe843783          	ld	a5,-24(s0)
     66e:	0007c783          	lbu	a5,0(a5)
     672:	873e                	mv	a4,a5
     674:	03e00793          	li	a5,62
     678:	06f71963          	bne	a4,a5,6ea <gettoken+0x15a>
      ret = '+';
     67c:	02b00793          	li	a5,43
     680:	fef42223          	sw	a5,-28(s0)
      s++;
     684:	fe843783          	ld	a5,-24(s0)
     688:	0785                	addi	a5,a5,1
     68a:	fef43423          	sd	a5,-24(s0)
    }
    break;
     68e:	a8b1                	j	6ea <gettoken+0x15a>
  default:
    ret = 'a';
     690:	06100793          	li	a5,97
     694:	fef42223          	sw	a5,-28(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     698:	a031                	j	6a4 <gettoken+0x114>
      s++;
     69a:	fe843783          	ld	a5,-24(s0)
     69e:	0785                	addi	a5,a5,1
     6a0:	fef43423          	sd	a5,-24(s0)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6a4:	fe843703          	ld	a4,-24(s0)
     6a8:	fd043783          	ld	a5,-48(s0)
     6ac:	04f77163          	bgeu	a4,a5,6ee <gettoken+0x15e>
     6b0:	fe843783          	ld	a5,-24(s0)
     6b4:	0007c783          	lbu	a5,0(a5)
     6b8:	85be                	mv	a1,a5
     6ba:	00002517          	auipc	a0,0x2
     6be:	94650513          	addi	a0,a0,-1722 # 2000 <whitespace>
     6c2:	063000ef          	jal	f24 <strchr>
     6c6:	87aa                	mv	a5,a0
     6c8:	e39d                	bnez	a5,6ee <gettoken+0x15e>
     6ca:	fe843783          	ld	a5,-24(s0)
     6ce:	0007c783          	lbu	a5,0(a5)
     6d2:	85be                	mv	a1,a5
     6d4:	00002517          	auipc	a0,0x2
     6d8:	93450513          	addi	a0,a0,-1740 # 2008 <symbols>
     6dc:	049000ef          	jal	f24 <strchr>
     6e0:	87aa                	mv	a5,a0
     6e2:	dfc5                	beqz	a5,69a <gettoken+0x10a>
    break;
     6e4:	a029                	j	6ee <gettoken+0x15e>
    break;
     6e6:	0001                	nop
     6e8:	a021                	j	6f0 <gettoken+0x160>
    break;
     6ea:	0001                	nop
     6ec:	a011                	j	6f0 <gettoken+0x160>
    break;
     6ee:	0001                	nop
  }
  if(eq)
     6f0:	fc043783          	ld	a5,-64(s0)
     6f4:	cf81                	beqz	a5,70c <gettoken+0x17c>
    *eq = s;
     6f6:	fc043783          	ld	a5,-64(s0)
     6fa:	fe843703          	ld	a4,-24(s0)
     6fe:	e398                	sd	a4,0(a5)

  while(s < es && strchr(whitespace, *s))
     700:	a031                	j	70c <gettoken+0x17c>
    s++;
     702:	fe843783          	ld	a5,-24(s0)
     706:	0785                	addi	a5,a5,1
     708:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     70c:	fe843703          	ld	a4,-24(s0)
     710:	fd043783          	ld	a5,-48(s0)
     714:	00f77f63          	bgeu	a4,a5,732 <gettoken+0x1a2>
     718:	fe843783          	ld	a5,-24(s0)
     71c:	0007c783          	lbu	a5,0(a5)
     720:	85be                	mv	a1,a5
     722:	00002517          	auipc	a0,0x2
     726:	8de50513          	addi	a0,a0,-1826 # 2000 <whitespace>
     72a:	7fa000ef          	jal	f24 <strchr>
     72e:	87aa                	mv	a5,a0
     730:	fbe9                	bnez	a5,702 <gettoken+0x172>
  *ps = s;
     732:	fd843783          	ld	a5,-40(s0)
     736:	fe843703          	ld	a4,-24(s0)
     73a:	e398                	sd	a4,0(a5)
  return ret;
     73c:	fe442783          	lw	a5,-28(s0)
}
     740:	853e                	mv	a0,a5
     742:	70e2                	ld	ra,56(sp)
     744:	7442                	ld	s0,48(sp)
     746:	6121                	addi	sp,sp,64
     748:	8082                	ret

000000000000074a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     74a:	7139                	addi	sp,sp,-64
     74c:	fc06                	sd	ra,56(sp)
     74e:	f822                	sd	s0,48(sp)
     750:	0080                	addi	s0,sp,64
     752:	fca43c23          	sd	a0,-40(s0)
     756:	fcb43823          	sd	a1,-48(s0)
     75a:	fcc43423          	sd	a2,-56(s0)
  char *s;

  s = *ps;
     75e:	fd843783          	ld	a5,-40(s0)
     762:	639c                	ld	a5,0(a5)
     764:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     768:	a031                	j	774 <peek+0x2a>
    s++;
     76a:	fe843783          	ld	a5,-24(s0)
     76e:	0785                	addi	a5,a5,1
     770:	fef43423          	sd	a5,-24(s0)
  while(s < es && strchr(whitespace, *s))
     774:	fe843703          	ld	a4,-24(s0)
     778:	fd043783          	ld	a5,-48(s0)
     77c:	00f77f63          	bgeu	a4,a5,79a <peek+0x50>
     780:	fe843783          	ld	a5,-24(s0)
     784:	0007c783          	lbu	a5,0(a5)
     788:	85be                	mv	a1,a5
     78a:	00002517          	auipc	a0,0x2
     78e:	87650513          	addi	a0,a0,-1930 # 2000 <whitespace>
     792:	792000ef          	jal	f24 <strchr>
     796:	87aa                	mv	a5,a0
     798:	fbe9                	bnez	a5,76a <peek+0x20>
  *ps = s;
     79a:	fd843783          	ld	a5,-40(s0)
     79e:	fe843703          	ld	a4,-24(s0)
     7a2:	e398                	sd	a4,0(a5)
  return *s && strchr(toks, *s);
     7a4:	fe843783          	ld	a5,-24(s0)
     7a8:	0007c783          	lbu	a5,0(a5)
     7ac:	cf91                	beqz	a5,7c8 <peek+0x7e>
     7ae:	fe843783          	ld	a5,-24(s0)
     7b2:	0007c783          	lbu	a5,0(a5)
     7b6:	85be                	mv	a1,a5
     7b8:	fc843503          	ld	a0,-56(s0)
     7bc:	768000ef          	jal	f24 <strchr>
     7c0:	87aa                	mv	a5,a0
     7c2:	c399                	beqz	a5,7c8 <peek+0x7e>
     7c4:	4785                	li	a5,1
     7c6:	a011                	j	7ca <peek+0x80>
     7c8:	4781                	li	a5,0
}
     7ca:	853e                	mv	a0,a5
     7cc:	70e2                	ld	ra,56(sp)
     7ce:	7442                	ld	s0,48(sp)
     7d0:	6121                	addi	sp,sp,64
     7d2:	8082                	ret

00000000000007d4 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     7d4:	7139                	addi	sp,sp,-64
     7d6:	fc06                	sd	ra,56(sp)
     7d8:	f822                	sd	s0,48(sp)
     7da:	f426                	sd	s1,40(sp)
     7dc:	0080                	addi	s0,sp,64
     7de:	fca43423          	sd	a0,-56(s0)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     7e2:	fc843483          	ld	s1,-56(s0)
     7e6:	fc843783          	ld	a5,-56(s0)
     7ea:	853e                	mv	a0,a5
     7ec:	69a000ef          	jal	e86 <strlen>
     7f0:	87aa                	mv	a5,a0
     7f2:	1782                	slli	a5,a5,0x20
     7f4:	9381                	srli	a5,a5,0x20
     7f6:	97a6                	add	a5,a5,s1
     7f8:	fcf43c23          	sd	a5,-40(s0)
  cmd = parseline(&s, es);
     7fc:	fc840793          	addi	a5,s0,-56
     800:	fd843583          	ld	a1,-40(s0)
     804:	853e                	mv	a0,a5
     806:	062000ef          	jal	868 <parseline>
     80a:	fca43823          	sd	a0,-48(s0)
  peek(&s, es, "");
     80e:	fc840793          	addi	a5,s0,-56
     812:	00001617          	auipc	a2,0x1
     816:	56660613          	addi	a2,a2,1382 # 1d78 <malloc+0x1be>
     81a:	fd843583          	ld	a1,-40(s0)
     81e:	853e                	mv	a0,a5
     820:	f2bff0ef          	jal	74a <peek>
  if(s != es){
     824:	fc843783          	ld	a5,-56(s0)
     828:	fd843703          	ld	a4,-40(s0)
     82c:	02f70263          	beq	a4,a5,850 <parsecmd+0x7c>
    fprintf(2, "leftovers: %s\n", s);
     830:	fc843783          	ld	a5,-56(s0)
     834:	863e                	mv	a2,a5
     836:	00001597          	auipc	a1,0x1
     83a:	54a58593          	addi	a1,a1,1354 # 1d80 <malloc+0x1c6>
     83e:	4509                	li	a0,2
     840:	13e010ef          	jal	197e <fprintf>
    panic("syntax");
     844:	00001517          	auipc	a0,0x1
     848:	54c50513          	addi	a0,a0,1356 # 1d90 <malloc+0x1d6>
     84c:	b4bff0ef          	jal	396 <panic>
  }
  nulterminate(cmd);
     850:	fd043503          	ld	a0,-48(s0)
     854:	442000ef          	jal	c96 <nulterminate>
  return cmd;
     858:	fd043783          	ld	a5,-48(s0)
}
     85c:	853e                	mv	a0,a5
     85e:	70e2                	ld	ra,56(sp)
     860:	7442                	ld	s0,48(sp)
     862:	74a2                	ld	s1,40(sp)
     864:	6121                	addi	sp,sp,64
     866:	8082                	ret

0000000000000868 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     868:	7179                	addi	sp,sp,-48
     86a:	f406                	sd	ra,40(sp)
     86c:	f022                	sd	s0,32(sp)
     86e:	1800                	addi	s0,sp,48
     870:	fca43c23          	sd	a0,-40(s0)
     874:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     878:	fd043583          	ld	a1,-48(s0)
     87c:	fd843503          	ld	a0,-40(s0)
     880:	090000ef          	jal	910 <parsepipe>
     884:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     888:	a839                	j	8a6 <parseline+0x3e>
    gettoken(ps, es, 0, 0);
     88a:	4681                	li	a3,0
     88c:	4601                	li	a2,0
     88e:	fd043583          	ld	a1,-48(s0)
     892:	fd843503          	ld	a0,-40(s0)
     896:	cfbff0ef          	jal	590 <gettoken>
    cmd = backcmd(cmd);
     89a:	fe843503          	ld	a0,-24(s0)
     89e:	cb1ff0ef          	jal	54e <backcmd>
     8a2:	fea43423          	sd	a0,-24(s0)
  while(peek(ps, es, "&")){
     8a6:	00001617          	auipc	a2,0x1
     8aa:	4f260613          	addi	a2,a2,1266 # 1d98 <malloc+0x1de>
     8ae:	fd043583          	ld	a1,-48(s0)
     8b2:	fd843503          	ld	a0,-40(s0)
     8b6:	e95ff0ef          	jal	74a <peek>
     8ba:	87aa                	mv	a5,a0
     8bc:	f7f9                	bnez	a5,88a <parseline+0x22>
  }
  if(peek(ps, es, ";")){
     8be:	00001617          	auipc	a2,0x1
     8c2:	4e260613          	addi	a2,a2,1250 # 1da0 <malloc+0x1e6>
     8c6:	fd043583          	ld	a1,-48(s0)
     8ca:	fd843503          	ld	a0,-40(s0)
     8ce:	e7dff0ef          	jal	74a <peek>
     8d2:	87aa                	mv	a5,a0
     8d4:	c79d                	beqz	a5,902 <parseline+0x9a>
    gettoken(ps, es, 0, 0);
     8d6:	4681                	li	a3,0
     8d8:	4601                	li	a2,0
     8da:	fd043583          	ld	a1,-48(s0)
     8de:	fd843503          	ld	a0,-40(s0)
     8e2:	cafff0ef          	jal	590 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8e6:	fd043583          	ld	a1,-48(s0)
     8ea:	fd843503          	ld	a0,-40(s0)
     8ee:	f7bff0ef          	jal	868 <parseline>
     8f2:	87aa                	mv	a5,a0
     8f4:	85be                	mv	a1,a5
     8f6:	fe843503          	ld	a0,-24(s0)
     8fa:	c05ff0ef          	jal	4fe <listcmd>
     8fe:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     902:	fe843783          	ld	a5,-24(s0)
}
     906:	853e                	mv	a0,a5
     908:	70a2                	ld	ra,40(sp)
     90a:	7402                	ld	s0,32(sp)
     90c:	6145                	addi	sp,sp,48
     90e:	8082                	ret

0000000000000910 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     910:	7179                	addi	sp,sp,-48
     912:	f406                	sd	ra,40(sp)
     914:	f022                	sd	s0,32(sp)
     916:	1800                	addi	s0,sp,48
     918:	fca43c23          	sd	a0,-40(s0)
     91c:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     920:	fd043583          	ld	a1,-48(s0)
     924:	fd843503          	ld	a0,-40(s0)
     928:	220000ef          	jal	b48 <parseexec>
     92c:	fea43423          	sd	a0,-24(s0)
  if(peek(ps, es, "|")){
     930:	00001617          	auipc	a2,0x1
     934:	47860613          	addi	a2,a2,1144 # 1da8 <malloc+0x1ee>
     938:	fd043583          	ld	a1,-48(s0)
     93c:	fd843503          	ld	a0,-40(s0)
     940:	e0bff0ef          	jal	74a <peek>
     944:	87aa                	mv	a5,a0
     946:	c79d                	beqz	a5,974 <parsepipe+0x64>
    gettoken(ps, es, 0, 0);
     948:	4681                	li	a3,0
     94a:	4601                	li	a2,0
     94c:	fd043583          	ld	a1,-48(s0)
     950:	fd843503          	ld	a0,-40(s0)
     954:	c3dff0ef          	jal	590 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     958:	fd043583          	ld	a1,-48(s0)
     95c:	fd843503          	ld	a0,-40(s0)
     960:	fb1ff0ef          	jal	910 <parsepipe>
     964:	87aa                	mv	a5,a0
     966:	85be                	mv	a1,a5
     968:	fe843503          	ld	a0,-24(s0)
     96c:	b43ff0ef          	jal	4ae <pipecmd>
     970:	fea43423          	sd	a0,-24(s0)
  }
  return cmd;
     974:	fe843783          	ld	a5,-24(s0)
}
     978:	853e                	mv	a0,a5
     97a:	70a2                	ld	ra,40(sp)
     97c:	7402                	ld	s0,32(sp)
     97e:	6145                	addi	sp,sp,48
     980:	8082                	ret

0000000000000982 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     982:	715d                	addi	sp,sp,-80
     984:	e486                	sd	ra,72(sp)
     986:	e0a2                	sd	s0,64(sp)
     988:	0880                	addi	s0,sp,80
     98a:	fca43423          	sd	a0,-56(s0)
     98e:	fcb43023          	sd	a1,-64(s0)
     992:	fac43c23          	sd	a2,-72(s0)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     996:	a0c5                	j	a76 <parseredirs+0xf4>
    tok = gettoken(ps, es, 0, 0);
     998:	4681                	li	a3,0
     99a:	4601                	li	a2,0
     99c:	fb843583          	ld	a1,-72(s0)
     9a0:	fc043503          	ld	a0,-64(s0)
     9a4:	bedff0ef          	jal	590 <gettoken>
     9a8:	87aa                	mv	a5,a0
     9aa:	fef42623          	sw	a5,-20(s0)
    if(gettoken(ps, es, &q, &eq) != 'a')
     9ae:	fd840713          	addi	a4,s0,-40
     9b2:	fe040793          	addi	a5,s0,-32
     9b6:	86ba                	mv	a3,a4
     9b8:	863e                	mv	a2,a5
     9ba:	fb843583          	ld	a1,-72(s0)
     9be:	fc043503          	ld	a0,-64(s0)
     9c2:	bcfff0ef          	jal	590 <gettoken>
     9c6:	87aa                	mv	a5,a0
     9c8:	873e                	mv	a4,a5
     9ca:	06100793          	li	a5,97
     9ce:	00f70863          	beq	a4,a5,9de <parseredirs+0x5c>
      panic("missing file for redirection");
     9d2:	00001517          	auipc	a0,0x1
     9d6:	3de50513          	addi	a0,a0,990 # 1db0 <malloc+0x1f6>
     9da:	9bdff0ef          	jal	396 <panic>
    switch(tok){
     9de:	fec42783          	lw	a5,-20(s0)
     9e2:	0007871b          	sext.w	a4,a5
     9e6:	03e00793          	li	a5,62
     9ea:	04f70863          	beq	a4,a5,a3a <parseredirs+0xb8>
     9ee:	fec42783          	lw	a5,-20(s0)
     9f2:	0007871b          	sext.w	a4,a5
     9f6:	03e00793          	li	a5,62
     9fa:	06e7ce63          	blt	a5,a4,a76 <parseredirs+0xf4>
     9fe:	fec42783          	lw	a5,-20(s0)
     a02:	0007871b          	sext.w	a4,a5
     a06:	02b00793          	li	a5,43
     a0a:	04f70763          	beq	a4,a5,a58 <parseredirs+0xd6>
     a0e:	fec42783          	lw	a5,-20(s0)
     a12:	0007871b          	sext.w	a4,a5
     a16:	03c00793          	li	a5,60
     a1a:	04f71e63          	bne	a4,a5,a76 <parseredirs+0xf4>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a1e:	fe043783          	ld	a5,-32(s0)
     a22:	fd843603          	ld	a2,-40(s0)
     a26:	4701                	li	a4,0
     a28:	4681                	li	a3,0
     a2a:	85be                	mv	a1,a5
     a2c:	fc843503          	ld	a0,-56(s0)
     a30:	9fdff0ef          	jal	42c <redircmd>
     a34:	fca43423          	sd	a0,-56(s0)
      break;
     a38:	a83d                	j	a76 <parseredirs+0xf4>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     a3a:	fe043783          	ld	a5,-32(s0)
     a3e:	fd843603          	ld	a2,-40(s0)
     a42:	4705                	li	a4,1
     a44:	60100693          	li	a3,1537
     a48:	85be                	mv	a1,a5
     a4a:	fc843503          	ld	a0,-56(s0)
     a4e:	9dfff0ef          	jal	42c <redircmd>
     a52:	fca43423          	sd	a0,-56(s0)
      break;
     a56:	a005                	j	a76 <parseredirs+0xf4>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a58:	fe043783          	ld	a5,-32(s0)
     a5c:	fd843603          	ld	a2,-40(s0)
     a60:	4705                	li	a4,1
     a62:	20100693          	li	a3,513
     a66:	85be                	mv	a1,a5
     a68:	fc843503          	ld	a0,-56(s0)
     a6c:	9c1ff0ef          	jal	42c <redircmd>
     a70:	fca43423          	sd	a0,-56(s0)
      break;
     a74:	0001                	nop
  while(peek(ps, es, "<>")){
     a76:	00001617          	auipc	a2,0x1
     a7a:	35a60613          	addi	a2,a2,858 # 1dd0 <malloc+0x216>
     a7e:	fb843583          	ld	a1,-72(s0)
     a82:	fc043503          	ld	a0,-64(s0)
     a86:	cc5ff0ef          	jal	74a <peek>
     a8a:	87aa                	mv	a5,a0
     a8c:	f00796e3          	bnez	a5,998 <parseredirs+0x16>
    }
  }
  return cmd;
     a90:	fc843783          	ld	a5,-56(s0)
}
     a94:	853e                	mv	a0,a5
     a96:	60a6                	ld	ra,72(sp)
     a98:	6406                	ld	s0,64(sp)
     a9a:	6161                	addi	sp,sp,80
     a9c:	8082                	ret

0000000000000a9e <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     a9e:	7179                	addi	sp,sp,-48
     aa0:	f406                	sd	ra,40(sp)
     aa2:	f022                	sd	s0,32(sp)
     aa4:	1800                	addi	s0,sp,48
     aa6:	fca43c23          	sd	a0,-40(s0)
     aaa:	fcb43823          	sd	a1,-48(s0)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     aae:	00001617          	auipc	a2,0x1
     ab2:	32a60613          	addi	a2,a2,810 # 1dd8 <malloc+0x21e>
     ab6:	fd043583          	ld	a1,-48(s0)
     aba:	fd843503          	ld	a0,-40(s0)
     abe:	c8dff0ef          	jal	74a <peek>
     ac2:	87aa                	mv	a5,a0
     ac4:	e799                	bnez	a5,ad2 <parseblock+0x34>
    panic("parseblock");
     ac6:	00001517          	auipc	a0,0x1
     aca:	31a50513          	addi	a0,a0,794 # 1de0 <malloc+0x226>
     ace:	8c9ff0ef          	jal	396 <panic>
  gettoken(ps, es, 0, 0);
     ad2:	4681                	li	a3,0
     ad4:	4601                	li	a2,0
     ad6:	fd043583          	ld	a1,-48(s0)
     ada:	fd843503          	ld	a0,-40(s0)
     ade:	ab3ff0ef          	jal	590 <gettoken>
  cmd = parseline(ps, es);
     ae2:	fd043583          	ld	a1,-48(s0)
     ae6:	fd843503          	ld	a0,-40(s0)
     aea:	d7fff0ef          	jal	868 <parseline>
     aee:	fea43423          	sd	a0,-24(s0)
  if(!peek(ps, es, ")"))
     af2:	00001617          	auipc	a2,0x1
     af6:	2fe60613          	addi	a2,a2,766 # 1df0 <malloc+0x236>
     afa:	fd043583          	ld	a1,-48(s0)
     afe:	fd843503          	ld	a0,-40(s0)
     b02:	c49ff0ef          	jal	74a <peek>
     b06:	87aa                	mv	a5,a0
     b08:	e799                	bnez	a5,b16 <parseblock+0x78>
    panic("syntax - missing )");
     b0a:	00001517          	auipc	a0,0x1
     b0e:	2ee50513          	addi	a0,a0,750 # 1df8 <malloc+0x23e>
     b12:	885ff0ef          	jal	396 <panic>
  gettoken(ps, es, 0, 0);
     b16:	4681                	li	a3,0
     b18:	4601                	li	a2,0
     b1a:	fd043583          	ld	a1,-48(s0)
     b1e:	fd843503          	ld	a0,-40(s0)
     b22:	a6fff0ef          	jal	590 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b26:	fd043603          	ld	a2,-48(s0)
     b2a:	fd843583          	ld	a1,-40(s0)
     b2e:	fe843503          	ld	a0,-24(s0)
     b32:	e51ff0ef          	jal	982 <parseredirs>
     b36:	fea43423          	sd	a0,-24(s0)
  return cmd;
     b3a:	fe843783          	ld	a5,-24(s0)
}
     b3e:	853e                	mv	a0,a5
     b40:	70a2                	ld	ra,40(sp)
     b42:	7402                	ld	s0,32(sp)
     b44:	6145                	addi	sp,sp,48
     b46:	8082                	ret

0000000000000b48 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     b48:	715d                	addi	sp,sp,-80
     b4a:	e486                	sd	ra,72(sp)
     b4c:	e0a2                	sd	s0,64(sp)
     b4e:	0880                	addi	s0,sp,80
     b50:	faa43c23          	sd	a0,-72(s0)
     b54:	fab43823          	sd	a1,-80(s0)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     b58:	00001617          	auipc	a2,0x1
     b5c:	28060613          	addi	a2,a2,640 # 1dd8 <malloc+0x21e>
     b60:	fb043583          	ld	a1,-80(s0)
     b64:	fb843503          	ld	a0,-72(s0)
     b68:	be3ff0ef          	jal	74a <peek>
     b6c:	87aa                	mv	a5,a0
     b6e:	cb89                	beqz	a5,b80 <parseexec+0x38>
    return parseblock(ps, es);
     b70:	fb043583          	ld	a1,-80(s0)
     b74:	fb843503          	ld	a0,-72(s0)
     b78:	f27ff0ef          	jal	a9e <parseblock>
     b7c:	87aa                	mv	a5,a0
     b7e:	a239                	j	c8c <parseexec+0x144>

  ret = execcmd();
     b80:	875ff0ef          	jal	3f4 <execcmd>
     b84:	fea43023          	sd	a0,-32(s0)
  cmd = (struct execcmd*)ret;
     b88:	fe043783          	ld	a5,-32(s0)
     b8c:	fcf43c23          	sd	a5,-40(s0)

  argc = 0;
     b90:	fe042623          	sw	zero,-20(s0)
  ret = parseredirs(ret, ps, es);
     b94:	fb043603          	ld	a2,-80(s0)
     b98:	fb843583          	ld	a1,-72(s0)
     b9c:	fe043503          	ld	a0,-32(s0)
     ba0:	de3ff0ef          	jal	982 <parseredirs>
     ba4:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     ba8:	a04d                	j	c4a <parseexec+0x102>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     baa:	fc040713          	addi	a4,s0,-64
     bae:	fc840793          	addi	a5,s0,-56
     bb2:	86ba                	mv	a3,a4
     bb4:	863e                	mv	a2,a5
     bb6:	fb043583          	ld	a1,-80(s0)
     bba:	fb843503          	ld	a0,-72(s0)
     bbe:	9d3ff0ef          	jal	590 <gettoken>
     bc2:	87aa                	mv	a5,a0
     bc4:	fcf42a23          	sw	a5,-44(s0)
     bc8:	fd442783          	lw	a5,-44(s0)
     bcc:	2781                	sext.w	a5,a5
     bce:	cbd9                	beqz	a5,c64 <parseexec+0x11c>
      break;
    if(tok != 'a')
     bd0:	fd442783          	lw	a5,-44(s0)
     bd4:	0007871b          	sext.w	a4,a5
     bd8:	06100793          	li	a5,97
     bdc:	00f70863          	beq	a4,a5,bec <parseexec+0xa4>
      panic("syntax");
     be0:	00001517          	auipc	a0,0x1
     be4:	1b050513          	addi	a0,a0,432 # 1d90 <malloc+0x1d6>
     be8:	faeff0ef          	jal	396 <panic>
    cmd->argv[argc] = q;
     bec:	fc843703          	ld	a4,-56(s0)
     bf0:	fd843683          	ld	a3,-40(s0)
     bf4:	fec42783          	lw	a5,-20(s0)
     bf8:	078e                	slli	a5,a5,0x3
     bfa:	97b6                	add	a5,a5,a3
     bfc:	e798                	sd	a4,8(a5)
    cmd->eargv[argc] = eq;
     bfe:	fc043703          	ld	a4,-64(s0)
     c02:	fd843683          	ld	a3,-40(s0)
     c06:	fec42783          	lw	a5,-20(s0)
     c0a:	07a9                	addi	a5,a5,10
     c0c:	078e                	slli	a5,a5,0x3
     c0e:	97b6                	add	a5,a5,a3
     c10:	e798                	sd	a4,8(a5)
    argc++;
     c12:	fec42783          	lw	a5,-20(s0)
     c16:	2785                	addiw	a5,a5,1
     c18:	fef42623          	sw	a5,-20(s0)
    if(argc >= MAXARGS)
     c1c:	fec42783          	lw	a5,-20(s0)
     c20:	0007871b          	sext.w	a4,a5
     c24:	47a5                	li	a5,9
     c26:	00e7d863          	bge	a5,a4,c36 <parseexec+0xee>
      panic("too many args");
     c2a:	00001517          	auipc	a0,0x1
     c2e:	1e650513          	addi	a0,a0,486 # 1e10 <malloc+0x256>
     c32:	f64ff0ef          	jal	396 <panic>
    ret = parseredirs(ret, ps, es);
     c36:	fb043603          	ld	a2,-80(s0)
     c3a:	fb843583          	ld	a1,-72(s0)
     c3e:	fe043503          	ld	a0,-32(s0)
     c42:	d41ff0ef          	jal	982 <parseredirs>
     c46:	fea43023          	sd	a0,-32(s0)
  while(!peek(ps, es, "|)&;")){
     c4a:	00001617          	auipc	a2,0x1
     c4e:	1d660613          	addi	a2,a2,470 # 1e20 <malloc+0x266>
     c52:	fb043583          	ld	a1,-80(s0)
     c56:	fb843503          	ld	a0,-72(s0)
     c5a:	af1ff0ef          	jal	74a <peek>
     c5e:	87aa                	mv	a5,a0
     c60:	d7a9                	beqz	a5,baa <parseexec+0x62>
     c62:	a011                	j	c66 <parseexec+0x11e>
      break;
     c64:	0001                	nop
  }
  cmd->argv[argc] = 0;
     c66:	fd843703          	ld	a4,-40(s0)
     c6a:	fec42783          	lw	a5,-20(s0)
     c6e:	078e                	slli	a5,a5,0x3
     c70:	97ba                	add	a5,a5,a4
     c72:	0007b423          	sd	zero,8(a5)
  cmd->eargv[argc] = 0;
     c76:	fd843703          	ld	a4,-40(s0)
     c7a:	fec42783          	lw	a5,-20(s0)
     c7e:	07a9                	addi	a5,a5,10
     c80:	078e                	slli	a5,a5,0x3
     c82:	97ba                	add	a5,a5,a4
     c84:	0007b423          	sd	zero,8(a5)
  return ret;
     c88:	fe043783          	ld	a5,-32(s0)
}
     c8c:	853e                	mv	a0,a5
     c8e:	60a6                	ld	ra,72(sp)
     c90:	6406                	ld	s0,64(sp)
     c92:	6161                	addi	sp,sp,80
     c94:	8082                	ret

0000000000000c96 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c96:	715d                	addi	sp,sp,-80
     c98:	e486                	sd	ra,72(sp)
     c9a:	e0a2                	sd	s0,64(sp)
     c9c:	0880                	addi	s0,sp,80
     c9e:	faa43c23          	sd	a0,-72(s0)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     ca2:	fb843783          	ld	a5,-72(s0)
     ca6:	e399                	bnez	a5,cac <nulterminate+0x16>
    return 0;
     ca8:	4781                	li	a5,0
     caa:	a0ed                	j	d94 <nulterminate+0xfe>

  switch(cmd->type){
     cac:	fb843783          	ld	a5,-72(s0)
     cb0:	439c                	lw	a5,0(a5)
     cb2:	4715                	li	a4,5
     cb4:	0cf76e63          	bltu	a4,a5,d90 <nulterminate+0xfa>
     cb8:	00279713          	slli	a4,a5,0x2
     cbc:	00001797          	auipc	a5,0x1
     cc0:	16c78793          	addi	a5,a5,364 # 1e28 <malloc+0x26e>
     cc4:	97ba                	add	a5,a5,a4
     cc6:	439c                	lw	a5,0(a5)
     cc8:	0007871b          	sext.w	a4,a5
     ccc:	00001797          	auipc	a5,0x1
     cd0:	15c78793          	addi	a5,a5,348 # 1e28 <malloc+0x26e>
     cd4:	97ba                	add	a5,a5,a4
     cd6:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     cd8:	fb843783          	ld	a5,-72(s0)
     cdc:	fcf43023          	sd	a5,-64(s0)
    for(i=0; ecmd->argv[i]; i++)
     ce0:	fe042623          	sw	zero,-20(s0)
     ce4:	a005                	j	d04 <nulterminate+0x6e>
      *ecmd->eargv[i] = 0;
     ce6:	fc043703          	ld	a4,-64(s0)
     cea:	fec42783          	lw	a5,-20(s0)
     cee:	07a9                	addi	a5,a5,10
     cf0:	078e                	slli	a5,a5,0x3
     cf2:	97ba                	add	a5,a5,a4
     cf4:	679c                	ld	a5,8(a5)
     cf6:	00078023          	sb	zero,0(a5)
    for(i=0; ecmd->argv[i]; i++)
     cfa:	fec42783          	lw	a5,-20(s0)
     cfe:	2785                	addiw	a5,a5,1
     d00:	fef42623          	sw	a5,-20(s0)
     d04:	fc043703          	ld	a4,-64(s0)
     d08:	fec42783          	lw	a5,-20(s0)
     d0c:	078e                	slli	a5,a5,0x3
     d0e:	97ba                	add	a5,a5,a4
     d10:	679c                	ld	a5,8(a5)
     d12:	fbf1                	bnez	a5,ce6 <nulterminate+0x50>
    break;
     d14:	a8b5                	j	d90 <nulterminate+0xfa>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d16:	fb843783          	ld	a5,-72(s0)
     d1a:	fcf43423          	sd	a5,-56(s0)
    nulterminate(rcmd->cmd);
     d1e:	fc843783          	ld	a5,-56(s0)
     d22:	679c                	ld	a5,8(a5)
     d24:	853e                	mv	a0,a5
     d26:	f71ff0ef          	jal	c96 <nulterminate>
    *rcmd->efile = 0;
     d2a:	fc843783          	ld	a5,-56(s0)
     d2e:	6f9c                	ld	a5,24(a5)
     d30:	00078023          	sb	zero,0(a5)
    break;
     d34:	a8b1                	j	d90 <nulterminate+0xfa>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d36:	fb843783          	ld	a5,-72(s0)
     d3a:	fcf43823          	sd	a5,-48(s0)
    nulterminate(pcmd->left);
     d3e:	fd043783          	ld	a5,-48(s0)
     d42:	679c                	ld	a5,8(a5)
     d44:	853e                	mv	a0,a5
     d46:	f51ff0ef          	jal	c96 <nulterminate>
    nulterminate(pcmd->right);
     d4a:	fd043783          	ld	a5,-48(s0)
     d4e:	6b9c                	ld	a5,16(a5)
     d50:	853e                	mv	a0,a5
     d52:	f45ff0ef          	jal	c96 <nulterminate>
    break;
     d56:	a82d                	j	d90 <nulterminate+0xfa>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     d58:	fb843783          	ld	a5,-72(s0)
     d5c:	fcf43c23          	sd	a5,-40(s0)
    nulterminate(lcmd->left);
     d60:	fd843783          	ld	a5,-40(s0)
     d64:	679c                	ld	a5,8(a5)
     d66:	853e                	mv	a0,a5
     d68:	f2fff0ef          	jal	c96 <nulterminate>
    nulterminate(lcmd->right);
     d6c:	fd843783          	ld	a5,-40(s0)
     d70:	6b9c                	ld	a5,16(a5)
     d72:	853e                	mv	a0,a5
     d74:	f23ff0ef          	jal	c96 <nulterminate>
    break;
     d78:	a821                	j	d90 <nulterminate+0xfa>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     d7a:	fb843783          	ld	a5,-72(s0)
     d7e:	fef43023          	sd	a5,-32(s0)
    nulterminate(bcmd->cmd);
     d82:	fe043783          	ld	a5,-32(s0)
     d86:	679c                	ld	a5,8(a5)
     d88:	853e                	mv	a0,a5
     d8a:	f0dff0ef          	jal	c96 <nulterminate>
    break;
     d8e:	0001                	nop
  }
  return cmd;
     d90:	fb843783          	ld	a5,-72(s0)
}
     d94:	853e                	mv	a0,a5
     d96:	60a6                	ld	ra,72(sp)
     d98:	6406                	ld	s0,64(sp)
     d9a:	6161                	addi	sp,sp,80
     d9c:	8082                	ret

0000000000000d9e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     d9e:	7179                	addi	sp,sp,-48
     da0:	f406                	sd	ra,40(sp)
     da2:	f022                	sd	s0,32(sp)
     da4:	1800                	addi	s0,sp,48
     da6:	87aa                	mv	a5,a0
     da8:	fcb43823          	sd	a1,-48(s0)
     dac:	fcf42e23          	sw	a5,-36(s0)
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     db0:	fdc42783          	lw	a5,-36(s0)
     db4:	fd043583          	ld	a1,-48(s0)
     db8:	853e                	mv	a0,a5
     dba:	c90ff0ef          	jal	24a <main>
     dbe:	87aa                	mv	a5,a0
     dc0:	fef42623          	sw	a5,-20(s0)
  exit(r);
     dc4:	fec42783          	lw	a5,-20(s0)
     dc8:	853e                	mv	a0,a5
     dca:	4ec000ef          	jal	12b6 <exit>

0000000000000dce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     dce:	7179                	addi	sp,sp,-48
     dd0:	f406                	sd	ra,40(sp)
     dd2:	f022                	sd	s0,32(sp)
     dd4:	1800                	addi	s0,sp,48
     dd6:	fca43c23          	sd	a0,-40(s0)
     dda:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     dde:	fd843783          	ld	a5,-40(s0)
     de2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     de6:	0001                	nop
     de8:	fd043703          	ld	a4,-48(s0)
     dec:	00170793          	addi	a5,a4,1
     df0:	fcf43823          	sd	a5,-48(s0)
     df4:	fd843783          	ld	a5,-40(s0)
     df8:	00178693          	addi	a3,a5,1
     dfc:	fcd43c23          	sd	a3,-40(s0)
     e00:	00074703          	lbu	a4,0(a4)
     e04:	00e78023          	sb	a4,0(a5)
     e08:	0007c783          	lbu	a5,0(a5)
     e0c:	fff1                	bnez	a5,de8 <strcpy+0x1a>
    ;
  return os;
     e0e:	fe843783          	ld	a5,-24(s0)
}
     e12:	853e                	mv	a0,a5
     e14:	70a2                	ld	ra,40(sp)
     e16:	7402                	ld	s0,32(sp)
     e18:	6145                	addi	sp,sp,48
     e1a:	8082                	ret

0000000000000e1c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e1c:	1101                	addi	sp,sp,-32
     e1e:	ec06                	sd	ra,24(sp)
     e20:	e822                	sd	s0,16(sp)
     e22:	1000                	addi	s0,sp,32
     e24:	fea43423          	sd	a0,-24(s0)
     e28:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     e2c:	a819                	j	e42 <strcmp+0x26>
    p++, q++;
     e2e:	fe843783          	ld	a5,-24(s0)
     e32:	0785                	addi	a5,a5,1
     e34:	fef43423          	sd	a5,-24(s0)
     e38:	fe043783          	ld	a5,-32(s0)
     e3c:	0785                	addi	a5,a5,1
     e3e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	0007c783          	lbu	a5,0(a5)
     e4a:	cb99                	beqz	a5,e60 <strcmp+0x44>
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	0007c703          	lbu	a4,0(a5)
     e54:	fe043783          	ld	a5,-32(s0)
     e58:	0007c783          	lbu	a5,0(a5)
     e5c:	fcf709e3          	beq	a4,a5,e2e <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	0007c783          	lbu	a5,0(a5)
     e68:	0007871b          	sext.w	a4,a5
     e6c:	fe043783          	ld	a5,-32(s0)
     e70:	0007c783          	lbu	a5,0(a5)
     e74:	2781                	sext.w	a5,a5
     e76:	40f707bb          	subw	a5,a4,a5
     e7a:	2781                	sext.w	a5,a5
}
     e7c:	853e                	mv	a0,a5
     e7e:	60e2                	ld	ra,24(sp)
     e80:	6442                	ld	s0,16(sp)
     e82:	6105                	addi	sp,sp,32
     e84:	8082                	ret

0000000000000e86 <strlen>:

uint
strlen(const char *s)
{
     e86:	7179                	addi	sp,sp,-48
     e88:	f406                	sd	ra,40(sp)
     e8a:	f022                	sd	s0,32(sp)
     e8c:	1800                	addi	s0,sp,48
     e8e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     e92:	fe042623          	sw	zero,-20(s0)
     e96:	a031                	j	ea2 <strlen+0x1c>
     e98:	fec42783          	lw	a5,-20(s0)
     e9c:	2785                	addiw	a5,a5,1
     e9e:	fef42623          	sw	a5,-20(s0)
     ea2:	fec42783          	lw	a5,-20(s0)
     ea6:	fd843703          	ld	a4,-40(s0)
     eaa:	97ba                	add	a5,a5,a4
     eac:	0007c783          	lbu	a5,0(a5)
     eb0:	f7e5                	bnez	a5,e98 <strlen+0x12>
    ;
  return n;
     eb2:	fec42783          	lw	a5,-20(s0)
}
     eb6:	853e                	mv	a0,a5
     eb8:	70a2                	ld	ra,40(sp)
     eba:	7402                	ld	s0,32(sp)
     ebc:	6145                	addi	sp,sp,48
     ebe:	8082                	ret

0000000000000ec0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ec0:	7179                	addi	sp,sp,-48
     ec2:	f406                	sd	ra,40(sp)
     ec4:	f022                	sd	s0,32(sp)
     ec6:	1800                	addi	s0,sp,48
     ec8:	fca43c23          	sd	a0,-40(s0)
     ecc:	87ae                	mv	a5,a1
     ece:	8732                	mv	a4,a2
     ed0:	fcf42a23          	sw	a5,-44(s0)
     ed4:	87ba                	mv	a5,a4
     ed6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     eda:	fd843783          	ld	a5,-40(s0)
     ede:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     ee2:	fe042623          	sw	zero,-20(s0)
     ee6:	a00d                	j	f08 <memset+0x48>
    cdst[i] = c;
     ee8:	fec42783          	lw	a5,-20(s0)
     eec:	fe043703          	ld	a4,-32(s0)
     ef0:	97ba                	add	a5,a5,a4
     ef2:	fd442703          	lw	a4,-44(s0)
     ef6:	0ff77713          	zext.b	a4,a4
     efa:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     efe:	fec42783          	lw	a5,-20(s0)
     f02:	2785                	addiw	a5,a5,1
     f04:	fef42623          	sw	a5,-20(s0)
     f08:	fec42783          	lw	a5,-20(s0)
     f0c:	fd042703          	lw	a4,-48(s0)
     f10:	2701                	sext.w	a4,a4
     f12:	fce7ebe3          	bltu	a5,a4,ee8 <memset+0x28>
  }
  return dst;
     f16:	fd843783          	ld	a5,-40(s0)
}
     f1a:	853e                	mv	a0,a5
     f1c:	70a2                	ld	ra,40(sp)
     f1e:	7402                	ld	s0,32(sp)
     f20:	6145                	addi	sp,sp,48
     f22:	8082                	ret

0000000000000f24 <strchr>:

char*
strchr(const char *s, char c)
{
     f24:	1101                	addi	sp,sp,-32
     f26:	ec06                	sd	ra,24(sp)
     f28:	e822                	sd	s0,16(sp)
     f2a:	1000                	addi	s0,sp,32
     f2c:	fea43423          	sd	a0,-24(s0)
     f30:	87ae                	mv	a5,a1
     f32:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     f36:	a01d                	j	f5c <strchr+0x38>
    if(*s == c)
     f38:	fe843783          	ld	a5,-24(s0)
     f3c:	0007c703          	lbu	a4,0(a5)
     f40:	fe744783          	lbu	a5,-25(s0)
     f44:	0ff7f793          	zext.b	a5,a5
     f48:	00e79563          	bne	a5,a4,f52 <strchr+0x2e>
      return (char*)s;
     f4c:	fe843783          	ld	a5,-24(s0)
     f50:	a821                	j	f68 <strchr+0x44>
  for(; *s; s++)
     f52:	fe843783          	ld	a5,-24(s0)
     f56:	0785                	addi	a5,a5,1
     f58:	fef43423          	sd	a5,-24(s0)
     f5c:	fe843783          	ld	a5,-24(s0)
     f60:	0007c783          	lbu	a5,0(a5)
     f64:	fbf1                	bnez	a5,f38 <strchr+0x14>
  return 0;
     f66:	4781                	li	a5,0
}
     f68:	853e                	mv	a0,a5
     f6a:	60e2                	ld	ra,24(sp)
     f6c:	6442                	ld	s0,16(sp)
     f6e:	6105                	addi	sp,sp,32
     f70:	8082                	ret

0000000000000f72 <gets>:

char*
gets(char *buf, int max)
{
     f72:	7179                	addi	sp,sp,-48
     f74:	f406                	sd	ra,40(sp)
     f76:	f022                	sd	s0,32(sp)
     f78:	1800                	addi	s0,sp,48
     f7a:	fca43c23          	sd	a0,-40(s0)
     f7e:	87ae                	mv	a5,a1
     f80:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f84:	fe042623          	sw	zero,-20(s0)
     f88:	a891                	j	fdc <gets+0x6a>
    cc = read(0, &c, 1);
     f8a:	fe740793          	addi	a5,s0,-25
     f8e:	4605                	li	a2,1
     f90:	85be                	mv	a1,a5
     f92:	4501                	li	a0,0
     f94:	33a000ef          	jal	12ce <read>
     f98:	87aa                	mv	a5,a0
     f9a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     f9e:	fe842783          	lw	a5,-24(s0)
     fa2:	2781                	sext.w	a5,a5
     fa4:	04f05663          	blez	a5,ff0 <gets+0x7e>
      break;
    buf[i++] = c;
     fa8:	fec42783          	lw	a5,-20(s0)
     fac:	0017871b          	addiw	a4,a5,1
     fb0:	fee42623          	sw	a4,-20(s0)
     fb4:	873e                	mv	a4,a5
     fb6:	fd843783          	ld	a5,-40(s0)
     fba:	97ba                	add	a5,a5,a4
     fbc:	fe744703          	lbu	a4,-25(s0)
     fc0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     fc4:	fe744783          	lbu	a5,-25(s0)
     fc8:	873e                	mv	a4,a5
     fca:	47a9                	li	a5,10
     fcc:	02f70363          	beq	a4,a5,ff2 <gets+0x80>
     fd0:	fe744783          	lbu	a5,-25(s0)
     fd4:	873e                	mv	a4,a5
     fd6:	47b5                	li	a5,13
     fd8:	00f70d63          	beq	a4,a5,ff2 <gets+0x80>
  for(i=0; i+1 < max; ){
     fdc:	fec42783          	lw	a5,-20(s0)
     fe0:	2785                	addiw	a5,a5,1
     fe2:	2781                	sext.w	a5,a5
     fe4:	fd442703          	lw	a4,-44(s0)
     fe8:	2701                	sext.w	a4,a4
     fea:	fae7c0e3          	blt	a5,a4,f8a <gets+0x18>
     fee:	a011                	j	ff2 <gets+0x80>
      break;
     ff0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     ff2:	fec42783          	lw	a5,-20(s0)
     ff6:	fd843703          	ld	a4,-40(s0)
     ffa:	97ba                	add	a5,a5,a4
     ffc:	00078023          	sb	zero,0(a5)
  return buf;
    1000:	fd843783          	ld	a5,-40(s0)
}
    1004:	853e                	mv	a0,a5
    1006:	70a2                	ld	ra,40(sp)
    1008:	7402                	ld	s0,32(sp)
    100a:	6145                	addi	sp,sp,48
    100c:	8082                	ret

000000000000100e <stat>:

int
stat(const char *n, struct stat *st)
{
    100e:	7179                	addi	sp,sp,-48
    1010:	f406                	sd	ra,40(sp)
    1012:	f022                	sd	s0,32(sp)
    1014:	1800                	addi	s0,sp,48
    1016:	fca43c23          	sd	a0,-40(s0)
    101a:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    101e:	4581                	li	a1,0
    1020:	fd843503          	ld	a0,-40(s0)
    1024:	2d2000ef          	jal	12f6 <open>
    1028:	87aa                	mv	a5,a0
    102a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    102e:	fec42783          	lw	a5,-20(s0)
    1032:	2781                	sext.w	a5,a5
    1034:	0007d463          	bgez	a5,103c <stat+0x2e>
    return -1;
    1038:	57fd                	li	a5,-1
    103a:	a015                	j	105e <stat+0x50>
  r = fstat(fd, st);
    103c:	fec42783          	lw	a5,-20(s0)
    1040:	fd043583          	ld	a1,-48(s0)
    1044:	853e                	mv	a0,a5
    1046:	2c8000ef          	jal	130e <fstat>
    104a:	87aa                	mv	a5,a0
    104c:	fef42423          	sw	a5,-24(s0)
  close(fd);
    1050:	fec42783          	lw	a5,-20(s0)
    1054:	853e                	mv	a0,a5
    1056:	288000ef          	jal	12de <close>
  return r;
    105a:	fe842783          	lw	a5,-24(s0)
}
    105e:	853e                	mv	a0,a5
    1060:	70a2                	ld	ra,40(sp)
    1062:	7402                	ld	s0,32(sp)
    1064:	6145                	addi	sp,sp,48
    1066:	8082                	ret

0000000000001068 <atoi>:

int
atoi(const char *s)
{
    1068:	7179                	addi	sp,sp,-48
    106a:	f406                	sd	ra,40(sp)
    106c:	f022                	sd	s0,32(sp)
    106e:	1800                	addi	s0,sp,48
    1070:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    1074:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    1078:	a81d                	j	10ae <atoi+0x46>
    n = n*10 + *s++ - '0';
    107a:	fec42783          	lw	a5,-20(s0)
    107e:	873e                	mv	a4,a5
    1080:	87ba                	mv	a5,a4
    1082:	0027979b          	slliw	a5,a5,0x2
    1086:	9fb9                	addw	a5,a5,a4
    1088:	0017979b          	slliw	a5,a5,0x1
    108c:	0007871b          	sext.w	a4,a5
    1090:	fd843783          	ld	a5,-40(s0)
    1094:	00178693          	addi	a3,a5,1
    1098:	fcd43c23          	sd	a3,-40(s0)
    109c:	0007c783          	lbu	a5,0(a5)
    10a0:	2781                	sext.w	a5,a5
    10a2:	9fb9                	addw	a5,a5,a4
    10a4:	2781                	sext.w	a5,a5
    10a6:	fd07879b          	addiw	a5,a5,-48
    10aa:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    10ae:	fd843783          	ld	a5,-40(s0)
    10b2:	0007c783          	lbu	a5,0(a5)
    10b6:	873e                	mv	a4,a5
    10b8:	02f00793          	li	a5,47
    10bc:	00e7fb63          	bgeu	a5,a4,10d2 <atoi+0x6a>
    10c0:	fd843783          	ld	a5,-40(s0)
    10c4:	0007c783          	lbu	a5,0(a5)
    10c8:	873e                	mv	a4,a5
    10ca:	03900793          	li	a5,57
    10ce:	fae7f6e3          	bgeu	a5,a4,107a <atoi+0x12>
  return n;
    10d2:	fec42783          	lw	a5,-20(s0)
}
    10d6:	853e                	mv	a0,a5
    10d8:	70a2                	ld	ra,40(sp)
    10da:	7402                	ld	s0,32(sp)
    10dc:	6145                	addi	sp,sp,48
    10de:	8082                	ret

00000000000010e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    10e0:	7139                	addi	sp,sp,-64
    10e2:	fc06                	sd	ra,56(sp)
    10e4:	f822                	sd	s0,48(sp)
    10e6:	0080                	addi	s0,sp,64
    10e8:	fca43c23          	sd	a0,-40(s0)
    10ec:	fcb43823          	sd	a1,-48(s0)
    10f0:	87b2                	mv	a5,a2
    10f2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    10f6:	fd843783          	ld	a5,-40(s0)
    10fa:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    10fe:	fd043783          	ld	a5,-48(s0)
    1102:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    1106:	fe043703          	ld	a4,-32(s0)
    110a:	fe843783          	ld	a5,-24(s0)
    110e:	02e7fc63          	bgeu	a5,a4,1146 <memmove+0x66>
    while(n-- > 0)
    1112:	a00d                	j	1134 <memmove+0x54>
      *dst++ = *src++;
    1114:	fe043703          	ld	a4,-32(s0)
    1118:	00170793          	addi	a5,a4,1
    111c:	fef43023          	sd	a5,-32(s0)
    1120:	fe843783          	ld	a5,-24(s0)
    1124:	00178693          	addi	a3,a5,1
    1128:	fed43423          	sd	a3,-24(s0)
    112c:	00074703          	lbu	a4,0(a4)
    1130:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1134:	fcc42783          	lw	a5,-52(s0)
    1138:	fff7871b          	addiw	a4,a5,-1
    113c:	fce42623          	sw	a4,-52(s0)
    1140:	fcf04ae3          	bgtz	a5,1114 <memmove+0x34>
    1144:	a891                	j	1198 <memmove+0xb8>
  } else {
    dst += n;
    1146:	fcc42783          	lw	a5,-52(s0)
    114a:	fe843703          	ld	a4,-24(s0)
    114e:	97ba                	add	a5,a5,a4
    1150:	fef43423          	sd	a5,-24(s0)
    src += n;
    1154:	fcc42783          	lw	a5,-52(s0)
    1158:	fe043703          	ld	a4,-32(s0)
    115c:	97ba                	add	a5,a5,a4
    115e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    1162:	a01d                	j	1188 <memmove+0xa8>
      *--dst = *--src;
    1164:	fe043783          	ld	a5,-32(s0)
    1168:	17fd                	addi	a5,a5,-1
    116a:	fef43023          	sd	a5,-32(s0)
    116e:	fe843783          	ld	a5,-24(s0)
    1172:	17fd                	addi	a5,a5,-1
    1174:	fef43423          	sd	a5,-24(s0)
    1178:	fe043783          	ld	a5,-32(s0)
    117c:	0007c703          	lbu	a4,0(a5)
    1180:	fe843783          	ld	a5,-24(s0)
    1184:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    1188:	fcc42783          	lw	a5,-52(s0)
    118c:	fff7871b          	addiw	a4,a5,-1
    1190:	fce42623          	sw	a4,-52(s0)
    1194:	fcf048e3          	bgtz	a5,1164 <memmove+0x84>
  }
  return vdst;
    1198:	fd843783          	ld	a5,-40(s0)
}
    119c:	853e                	mv	a0,a5
    119e:	70e2                	ld	ra,56(sp)
    11a0:	7442                	ld	s0,48(sp)
    11a2:	6121                	addi	sp,sp,64
    11a4:	8082                	ret

00000000000011a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    11a6:	7139                	addi	sp,sp,-64
    11a8:	fc06                	sd	ra,56(sp)
    11aa:	f822                	sd	s0,48(sp)
    11ac:	0080                	addi	s0,sp,64
    11ae:	fca43c23          	sd	a0,-40(s0)
    11b2:	fcb43823          	sd	a1,-48(s0)
    11b6:	87b2                	mv	a5,a2
    11b8:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    11bc:	fd843783          	ld	a5,-40(s0)
    11c0:	fef43423          	sd	a5,-24(s0)
    11c4:	fd043783          	ld	a5,-48(s0)
    11c8:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    11cc:	a0a1                	j	1214 <memcmp+0x6e>
    if (*p1 != *p2) {
    11ce:	fe843783          	ld	a5,-24(s0)
    11d2:	0007c703          	lbu	a4,0(a5)
    11d6:	fe043783          	ld	a5,-32(s0)
    11da:	0007c783          	lbu	a5,0(a5)
    11de:	02f70163          	beq	a4,a5,1200 <memcmp+0x5a>
      return *p1 - *p2;
    11e2:	fe843783          	ld	a5,-24(s0)
    11e6:	0007c783          	lbu	a5,0(a5)
    11ea:	0007871b          	sext.w	a4,a5
    11ee:	fe043783          	ld	a5,-32(s0)
    11f2:	0007c783          	lbu	a5,0(a5)
    11f6:	2781                	sext.w	a5,a5
    11f8:	40f707bb          	subw	a5,a4,a5
    11fc:	2781                	sext.w	a5,a5
    11fe:	a01d                	j	1224 <memcmp+0x7e>
    }
    p1++;
    1200:	fe843783          	ld	a5,-24(s0)
    1204:	0785                	addi	a5,a5,1
    1206:	fef43423          	sd	a5,-24(s0)
    p2++;
    120a:	fe043783          	ld	a5,-32(s0)
    120e:	0785                	addi	a5,a5,1
    1210:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    1214:	fcc42783          	lw	a5,-52(s0)
    1218:	fff7871b          	addiw	a4,a5,-1
    121c:	fce42623          	sw	a4,-52(s0)
    1220:	f7dd                	bnez	a5,11ce <memcmp+0x28>
  }
  return 0;
    1222:	4781                	li	a5,0
}
    1224:	853e                	mv	a0,a5
    1226:	70e2                	ld	ra,56(sp)
    1228:	7442                	ld	s0,48(sp)
    122a:	6121                	addi	sp,sp,64
    122c:	8082                	ret

000000000000122e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    122e:	7179                	addi	sp,sp,-48
    1230:	f406                	sd	ra,40(sp)
    1232:	f022                	sd	s0,32(sp)
    1234:	1800                	addi	s0,sp,48
    1236:	fea43423          	sd	a0,-24(s0)
    123a:	feb43023          	sd	a1,-32(s0)
    123e:	87b2                	mv	a5,a2
    1240:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    1244:	fdc42783          	lw	a5,-36(s0)
    1248:	863e                	mv	a2,a5
    124a:	fe043583          	ld	a1,-32(s0)
    124e:	fe843503          	ld	a0,-24(s0)
    1252:	e8fff0ef          	jal	10e0 <memmove>
    1256:	87aa                	mv	a5,a0
}
    1258:	853e                	mv	a0,a5
    125a:	70a2                	ld	ra,40(sp)
    125c:	7402                	ld	s0,32(sp)
    125e:	6145                	addi	sp,sp,48
    1260:	8082                	ret

0000000000001262 <sbrk>:

char *
sbrk(int n) {
    1262:	1101                	addi	sp,sp,-32
    1264:	ec06                	sd	ra,24(sp)
    1266:	e822                	sd	s0,16(sp)
    1268:	1000                	addi	s0,sp,32
    126a:	87aa                	mv	a5,a0
    126c:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_EAGER);
    1270:	fec42783          	lw	a5,-20(s0)
    1274:	4585                	li	a1,1
    1276:	853e                	mv	a0,a5
    1278:	0c6000ef          	jal	133e <sys_sbrk>
    127c:	87aa                	mv	a5,a0
}
    127e:	853e                	mv	a0,a5
    1280:	60e2                	ld	ra,24(sp)
    1282:	6442                	ld	s0,16(sp)
    1284:	6105                	addi	sp,sp,32
    1286:	8082                	ret

0000000000001288 <sbrklazy>:

char *
sbrklazy(int n) {
    1288:	1101                	addi	sp,sp,-32
    128a:	ec06                	sd	ra,24(sp)
    128c:	e822                	sd	s0,16(sp)
    128e:	1000                	addi	s0,sp,32
    1290:	87aa                	mv	a5,a0
    1292:	fef42623          	sw	a5,-20(s0)
  return sys_sbrk(n, SBRK_LAZY);
    1296:	fec42783          	lw	a5,-20(s0)
    129a:	4589                	li	a1,2
    129c:	853e                	mv	a0,a5
    129e:	0a0000ef          	jal	133e <sys_sbrk>
    12a2:	87aa                	mv	a5,a0
}
    12a4:	853e                	mv	a0,a5
    12a6:	60e2                	ld	ra,24(sp)
    12a8:	6442                	ld	s0,16(sp)
    12aa:	6105                	addi	sp,sp,32
    12ac:	8082                	ret

00000000000012ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    12ae:	4885                	li	a7,1
 ecall
    12b0:	00000073          	ecall
 ret
    12b4:	8082                	ret

00000000000012b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    12b6:	4889                	li	a7,2
 ecall
    12b8:	00000073          	ecall
 ret
    12bc:	8082                	ret

00000000000012be <wait>:
.global wait
wait:
 li a7, SYS_wait
    12be:	488d                	li	a7,3
 ecall
    12c0:	00000073          	ecall
 ret
    12c4:	8082                	ret

00000000000012c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    12c6:	4891                	li	a7,4
 ecall
    12c8:	00000073          	ecall
 ret
    12cc:	8082                	ret

00000000000012ce <read>:
.global read
read:
 li a7, SYS_read
    12ce:	4895                	li	a7,5
 ecall
    12d0:	00000073          	ecall
 ret
    12d4:	8082                	ret

00000000000012d6 <write>:
.global write
write:
 li a7, SYS_write
    12d6:	48c1                	li	a7,16
 ecall
    12d8:	00000073          	ecall
 ret
    12dc:	8082                	ret

00000000000012de <close>:
.global close
close:
 li a7, SYS_close
    12de:	48d5                	li	a7,21
 ecall
    12e0:	00000073          	ecall
 ret
    12e4:	8082                	ret

00000000000012e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    12e6:	4899                	li	a7,6
 ecall
    12e8:	00000073          	ecall
 ret
    12ec:	8082                	ret

00000000000012ee <exec>:
.global exec
exec:
 li a7, SYS_exec
    12ee:	489d                	li	a7,7
 ecall
    12f0:	00000073          	ecall
 ret
    12f4:	8082                	ret

00000000000012f6 <open>:
.global open
open:
 li a7, SYS_open
    12f6:	48bd                	li	a7,15
 ecall
    12f8:	00000073          	ecall
 ret
    12fc:	8082                	ret

00000000000012fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    12fe:	48c5                	li	a7,17
 ecall
    1300:	00000073          	ecall
 ret
    1304:	8082                	ret

0000000000001306 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1306:	48c9                	li	a7,18
 ecall
    1308:	00000073          	ecall
 ret
    130c:	8082                	ret

000000000000130e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    130e:	48a1                	li	a7,8
 ecall
    1310:	00000073          	ecall
 ret
    1314:	8082                	ret

0000000000001316 <link>:
.global link
link:
 li a7, SYS_link
    1316:	48cd                	li	a7,19
 ecall
    1318:	00000073          	ecall
 ret
    131c:	8082                	ret

000000000000131e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    131e:	48d1                	li	a7,20
 ecall
    1320:	00000073          	ecall
 ret
    1324:	8082                	ret

0000000000001326 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1326:	48a5                	li	a7,9
 ecall
    1328:	00000073          	ecall
 ret
    132c:	8082                	ret

000000000000132e <dup>:
.global dup
dup:
 li a7, SYS_dup
    132e:	48a9                	li	a7,10
 ecall
    1330:	00000073          	ecall
 ret
    1334:	8082                	ret

0000000000001336 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1336:	48ad                	li	a7,11
 ecall
    1338:	00000073          	ecall
 ret
    133c:	8082                	ret

000000000000133e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    133e:	48b1                	li	a7,12
 ecall
    1340:	00000073          	ecall
 ret
    1344:	8082                	ret

0000000000001346 <pause>:
.global pause
pause:
 li a7, SYS_pause
    1346:	48b5                	li	a7,13
 ecall
    1348:	00000073          	ecall
 ret
    134c:	8082                	ret

000000000000134e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    134e:	48b9                	li	a7,14
 ecall
    1350:	00000073          	ecall
 ret
    1354:	8082                	ret

0000000000001356 <top>:
.global top
top:
 li a7, SYS_top
    1356:	48d9                	li	a7,22
 ecall
    1358:	00000073          	ecall
 ret
    135c:	8082                	ret

000000000000135e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    135e:	1101                	addi	sp,sp,-32
    1360:	ec06                	sd	ra,24(sp)
    1362:	e822                	sd	s0,16(sp)
    1364:	1000                	addi	s0,sp,32
    1366:	87aa                	mv	a5,a0
    1368:	872e                	mv	a4,a1
    136a:	fef42623          	sw	a5,-20(s0)
    136e:	87ba                	mv	a5,a4
    1370:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    1374:	feb40713          	addi	a4,s0,-21
    1378:	fec42783          	lw	a5,-20(s0)
    137c:	4605                	li	a2,1
    137e:	85ba                	mv	a1,a4
    1380:	853e                	mv	a0,a5
    1382:	f55ff0ef          	jal	12d6 <write>
}
    1386:	0001                	nop
    1388:	60e2                	ld	ra,24(sp)
    138a:	6442                	ld	s0,16(sp)
    138c:	6105                	addi	sp,sp,32
    138e:	8082                	ret

0000000000001390 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    1390:	711d                	addi	sp,sp,-96
    1392:	ec86                	sd	ra,88(sp)
    1394:	e8a2                	sd	s0,80(sp)
    1396:	1080                	addi	s0,sp,96
    1398:	87aa                	mv	a5,a0
    139a:	fab43823          	sd	a1,-80(s0)
    139e:	8736                	mv	a4,a3
    13a0:	faf42e23          	sw	a5,-68(s0)
    13a4:	87b2                	mv	a5,a2
    13a6:	faf42c23          	sw	a5,-72(s0)
    13aa:	87ba                	mv	a5,a4
    13ac:	faf42623          	sw	a5,-84(s0)
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
    13b0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    13b4:	fac42783          	lw	a5,-84(s0)
    13b8:	2781                	sext.w	a5,a5
    13ba:	cf99                	beqz	a5,13d8 <printint+0x48>
    13bc:	fb043783          	ld	a5,-80(s0)
    13c0:	0007dc63          	bgez	a5,13d8 <printint+0x48>
    neg = 1;
    13c4:	4785                	li	a5,1
    13c6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    13ca:	fb043783          	ld	a5,-80(s0)
    13ce:	40f007b3          	neg	a5,a5
    13d2:	fef43023          	sd	a5,-32(s0)
    13d6:	a029                	j	13e0 <printint+0x50>
  } else {
    x = xx;
    13d8:	fb043783          	ld	a5,-80(s0)
    13dc:	fef43023          	sd	a5,-32(s0)
  }

  i = 0;
    13e0:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    13e4:	fb842783          	lw	a5,-72(s0)
    13e8:	fe043703          	ld	a4,-32(s0)
    13ec:	02f77733          	remu	a4,a4,a5
    13f0:	fec42783          	lw	a5,-20(s0)
    13f4:	0017869b          	addiw	a3,a5,1
    13f8:	fed42623          	sw	a3,-20(s0)
    13fc:	00001697          	auipc	a3,0x1
    1400:	c1468693          	addi	a3,a3,-1004 # 2010 <digits>
    1404:	9736                	add	a4,a4,a3
    1406:	00074703          	lbu	a4,0(a4)
    140a:	17c1                	addi	a5,a5,-16
    140c:	97a2                	add	a5,a5,s0
    140e:	fce78c23          	sb	a4,-40(a5)
  }while((x /= base) != 0);
    1412:	fb842783          	lw	a5,-72(s0)
    1416:	fe043703          	ld	a4,-32(s0)
    141a:	02f757b3          	divu	a5,a4,a5
    141e:	fef43023          	sd	a5,-32(s0)
    1422:	fe043783          	ld	a5,-32(s0)
    1426:	ffdd                	bnez	a5,13e4 <printint+0x54>
  if(neg)
    1428:	fe842783          	lw	a5,-24(s0)
    142c:	2781                	sext.w	a5,a5
    142e:	cb95                	beqz	a5,1462 <printint+0xd2>
    buf[i++] = '-';
    1430:	fec42783          	lw	a5,-20(s0)
    1434:	0017871b          	addiw	a4,a5,1
    1438:	fee42623          	sw	a4,-20(s0)
    143c:	17c1                	addi	a5,a5,-16
    143e:	97a2                	add	a5,a5,s0
    1440:	02d00713          	li	a4,45
    1444:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
    1448:	a829                	j	1462 <printint+0xd2>
    putc(fd, buf[i]);
    144a:	fec42783          	lw	a5,-20(s0)
    144e:	17c1                	addi	a5,a5,-16
    1450:	97a2                	add	a5,a5,s0
    1452:	fd87c703          	lbu	a4,-40(a5)
    1456:	fbc42783          	lw	a5,-68(s0)
    145a:	85ba                	mv	a1,a4
    145c:	853e                	mv	a0,a5
    145e:	f01ff0ef          	jal	135e <putc>
  while(--i >= 0)
    1462:	fec42783          	lw	a5,-20(s0)
    1466:	37fd                	addiw	a5,a5,-1
    1468:	fef42623          	sw	a5,-20(s0)
    146c:	fec42783          	lw	a5,-20(s0)
    1470:	2781                	sext.w	a5,a5
    1472:	fc07dce3          	bgez	a5,144a <printint+0xba>
}
    1476:	0001                	nop
    1478:	0001                	nop
    147a:	60e6                	ld	ra,88(sp)
    147c:	6446                	ld	s0,80(sp)
    147e:	6125                	addi	sp,sp,96
    1480:	8082                	ret

0000000000001482 <printptr>:

static void
printptr(int fd, uint64 x) {
    1482:	7179                	addi	sp,sp,-48
    1484:	f406                	sd	ra,40(sp)
    1486:	f022                	sd	s0,32(sp)
    1488:	1800                	addi	s0,sp,48
    148a:	87aa                	mv	a5,a0
    148c:	fcb43823          	sd	a1,-48(s0)
    1490:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    1494:	fdc42783          	lw	a5,-36(s0)
    1498:	03000593          	li	a1,48
    149c:	853e                	mv	a0,a5
    149e:	ec1ff0ef          	jal	135e <putc>
  putc(fd, 'x');
    14a2:	fdc42783          	lw	a5,-36(s0)
    14a6:	07800593          	li	a1,120
    14aa:	853e                	mv	a0,a5
    14ac:	eb3ff0ef          	jal	135e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    14b0:	fe042623          	sw	zero,-20(s0)
    14b4:	a81d                	j	14ea <printptr+0x68>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14b6:	fd043783          	ld	a5,-48(s0)
    14ba:	93f1                	srli	a5,a5,0x3c
    14bc:	00001717          	auipc	a4,0x1
    14c0:	b5470713          	addi	a4,a4,-1196 # 2010 <digits>
    14c4:	97ba                	add	a5,a5,a4
    14c6:	0007c703          	lbu	a4,0(a5)
    14ca:	fdc42783          	lw	a5,-36(s0)
    14ce:	85ba                	mv	a1,a4
    14d0:	853e                	mv	a0,a5
    14d2:	e8dff0ef          	jal	135e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    14d6:	fec42783          	lw	a5,-20(s0)
    14da:	2785                	addiw	a5,a5,1
    14dc:	fef42623          	sw	a5,-20(s0)
    14e0:	fd043783          	ld	a5,-48(s0)
    14e4:	0792                	slli	a5,a5,0x4
    14e6:	fcf43823          	sd	a5,-48(s0)
    14ea:	fec42703          	lw	a4,-20(s0)
    14ee:	47bd                	li	a5,15
    14f0:	fce7f3e3          	bgeu	a5,a4,14b6 <printptr+0x34>
}
    14f4:	0001                	nop
    14f6:	0001                	nop
    14f8:	70a2                	ld	ra,40(sp)
    14fa:	7402                	ld	s0,32(sp)
    14fc:	6145                	addi	sp,sp,48
    14fe:	8082                	ret

0000000000001500 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1500:	715d                	addi	sp,sp,-80
    1502:	e486                	sd	ra,72(sp)
    1504:	e0a2                	sd	s0,64(sp)
    1506:	0880                	addi	s0,sp,80
    1508:	87aa                	mv	a5,a0
    150a:	fcb43023          	sd	a1,-64(s0)
    150e:	fac43c23          	sd	a2,-72(s0)
    1512:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
    1516:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    151a:	fc042e23          	sw	zero,-36(s0)
    151e:	a189                	j	1960 <vprintf+0x460>
    c0 = fmt[i] & 0xff;
    1520:	fdc42783          	lw	a5,-36(s0)
    1524:	fc043703          	ld	a4,-64(s0)
    1528:	97ba                	add	a5,a5,a4
    152a:	0007c783          	lbu	a5,0(a5)
    152e:	fcf42a23          	sw	a5,-44(s0)
    if(state == 0){
    1532:	fd842783          	lw	a5,-40(s0)
    1536:	2781                	sext.w	a5,a5
    1538:	eb8d                	bnez	a5,156a <vprintf+0x6a>
      if(c0 == '%'){
    153a:	fd442783          	lw	a5,-44(s0)
    153e:	0007871b          	sext.w	a4,a5
    1542:	02500793          	li	a5,37
    1546:	00f71763          	bne	a4,a5,1554 <vprintf+0x54>
        state = '%';
    154a:	02500793          	li	a5,37
    154e:	fcf42c23          	sw	a5,-40(s0)
    1552:	a111                	j	1956 <vprintf+0x456>
      } else {
        putc(fd, c0);
    1554:	fd442783          	lw	a5,-44(s0)
    1558:	0ff7f713          	zext.b	a4,a5
    155c:	fcc42783          	lw	a5,-52(s0)
    1560:	85ba                	mv	a1,a4
    1562:	853e                	mv	a0,a5
    1564:	dfbff0ef          	jal	135e <putc>
    1568:	a6fd                	j	1956 <vprintf+0x456>
      }
    } else if(state == '%'){
    156a:	fd842783          	lw	a5,-40(s0)
    156e:	0007871b          	sext.w	a4,a5
    1572:	02500793          	li	a5,37
    1576:	3ef71063          	bne	a4,a5,1956 <vprintf+0x456>
      c1 = c2 = 0;
    157a:	fe042023          	sw	zero,-32(s0)
    157e:	fe042783          	lw	a5,-32(s0)
    1582:	fef42223          	sw	a5,-28(s0)
      if(c0) c1 = fmt[i+1] & 0xff;
    1586:	fd442783          	lw	a5,-44(s0)
    158a:	2781                	sext.w	a5,a5
    158c:	cb99                	beqz	a5,15a2 <vprintf+0xa2>
    158e:	fdc42783          	lw	a5,-36(s0)
    1592:	0785                	addi	a5,a5,1
    1594:	fc043703          	ld	a4,-64(s0)
    1598:	97ba                	add	a5,a5,a4
    159a:	0007c783          	lbu	a5,0(a5)
    159e:	fef42223          	sw	a5,-28(s0)
      if(c1) c2 = fmt[i+2] & 0xff;
    15a2:	fe442783          	lw	a5,-28(s0)
    15a6:	2781                	sext.w	a5,a5
    15a8:	cb99                	beqz	a5,15be <vprintf+0xbe>
    15aa:	fdc42783          	lw	a5,-36(s0)
    15ae:	0789                	addi	a5,a5,2
    15b0:	fc043703          	ld	a4,-64(s0)
    15b4:	97ba                	add	a5,a5,a4
    15b6:	0007c783          	lbu	a5,0(a5)
    15ba:	fef42023          	sw	a5,-32(s0)
      if(c0 == 'd'){
    15be:	fd442783          	lw	a5,-44(s0)
    15c2:	0007871b          	sext.w	a4,a5
    15c6:	06400793          	li	a5,100
    15ca:	02f71363          	bne	a4,a5,15f0 <vprintf+0xf0>
        printint(fd, va_arg(ap, int), 10, 1);
    15ce:	fb843783          	ld	a5,-72(s0)
    15d2:	00878713          	addi	a4,a5,8
    15d6:	fae43c23          	sd	a4,-72(s0)
    15da:	439c                	lw	a5,0(a5)
    15dc:	873e                	mv	a4,a5
    15de:	fcc42783          	lw	a5,-52(s0)
    15e2:	4685                	li	a3,1
    15e4:	4629                	li	a2,10
    15e6:	85ba                	mv	a1,a4
    15e8:	853e                	mv	a0,a5
    15ea:	da7ff0ef          	jal	1390 <printint>
    15ee:	a695                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'd'){
    15f0:	fd442783          	lw	a5,-44(s0)
    15f4:	0007871b          	sext.w	a4,a5
    15f8:	06c00793          	li	a5,108
    15fc:	04f71063          	bne	a4,a5,163c <vprintf+0x13c>
    1600:	fe442783          	lw	a5,-28(s0)
    1604:	0007871b          	sext.w	a4,a5
    1608:	06400793          	li	a5,100
    160c:	02f71863          	bne	a4,a5,163c <vprintf+0x13c>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1610:	fb843783          	ld	a5,-72(s0)
    1614:	00878713          	addi	a4,a5,8
    1618:	fae43c23          	sd	a4,-72(s0)
    161c:	639c                	ld	a5,0(a5)
    161e:	873e                	mv	a4,a5
    1620:	fcc42783          	lw	a5,-52(s0)
    1624:	4685                	li	a3,1
    1626:	4629                	li	a2,10
    1628:	85ba                	mv	a1,a4
    162a:	853e                	mv	a0,a5
    162c:	d65ff0ef          	jal	1390 <printint>
        i += 1;
    1630:	fdc42783          	lw	a5,-36(s0)
    1634:	2785                	addiw	a5,a5,1
    1636:	fcf42e23          	sw	a5,-36(s0)
    163a:	ae21                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    163c:	fd442783          	lw	a5,-44(s0)
    1640:	0007871b          	sext.w	a4,a5
    1644:	06c00793          	li	a5,108
    1648:	04f71863          	bne	a4,a5,1698 <vprintf+0x198>
    164c:	fe442783          	lw	a5,-28(s0)
    1650:	0007871b          	sext.w	a4,a5
    1654:	06c00793          	li	a5,108
    1658:	04f71063          	bne	a4,a5,1698 <vprintf+0x198>
    165c:	fe042783          	lw	a5,-32(s0)
    1660:	0007871b          	sext.w	a4,a5
    1664:	06400793          	li	a5,100
    1668:	02f71863          	bne	a4,a5,1698 <vprintf+0x198>
        printint(fd, va_arg(ap, uint64), 10, 1);
    166c:	fb843783          	ld	a5,-72(s0)
    1670:	00878713          	addi	a4,a5,8
    1674:	fae43c23          	sd	a4,-72(s0)
    1678:	639c                	ld	a5,0(a5)
    167a:	873e                	mv	a4,a5
    167c:	fcc42783          	lw	a5,-52(s0)
    1680:	4685                	li	a3,1
    1682:	4629                	li	a2,10
    1684:	85ba                	mv	a1,a4
    1686:	853e                	mv	a0,a5
    1688:	d09ff0ef          	jal	1390 <printint>
        i += 2;
    168c:	fdc42783          	lw	a5,-36(s0)
    1690:	2789                	addiw	a5,a5,2
    1692:	fcf42e23          	sw	a5,-36(s0)
    1696:	ac75                	j	1952 <vprintf+0x452>
      } else if(c0 == 'u'){
    1698:	fd442783          	lw	a5,-44(s0)
    169c:	0007871b          	sext.w	a4,a5
    16a0:	07500793          	li	a5,117
    16a4:	02f71563          	bne	a4,a5,16ce <vprintf+0x1ce>
        printint(fd, va_arg(ap, uint32), 10, 0);
    16a8:	fb843783          	ld	a5,-72(s0)
    16ac:	00878713          	addi	a4,a5,8
    16b0:	fae43c23          	sd	a4,-72(s0)
    16b4:	439c                	lw	a5,0(a5)
    16b6:	02079713          	slli	a4,a5,0x20
    16ba:	9301                	srli	a4,a4,0x20
    16bc:	fcc42783          	lw	a5,-52(s0)
    16c0:	4681                	li	a3,0
    16c2:	4629                	li	a2,10
    16c4:	85ba                	mv	a1,a4
    16c6:	853e                	mv	a0,a5
    16c8:	cc9ff0ef          	jal	1390 <printint>
    16cc:	a459                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'u'){
    16ce:	fd442783          	lw	a5,-44(s0)
    16d2:	0007871b          	sext.w	a4,a5
    16d6:	06c00793          	li	a5,108
    16da:	04f71063          	bne	a4,a5,171a <vprintf+0x21a>
    16de:	fe442783          	lw	a5,-28(s0)
    16e2:	0007871b          	sext.w	a4,a5
    16e6:	07500793          	li	a5,117
    16ea:	02f71863          	bne	a4,a5,171a <vprintf+0x21a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    16ee:	fb843783          	ld	a5,-72(s0)
    16f2:	00878713          	addi	a4,a5,8
    16f6:	fae43c23          	sd	a4,-72(s0)
    16fa:	639c                	ld	a5,0(a5)
    16fc:	873e                	mv	a4,a5
    16fe:	fcc42783          	lw	a5,-52(s0)
    1702:	4681                	li	a3,0
    1704:	4629                	li	a2,10
    1706:	85ba                	mv	a1,a4
    1708:	853e                	mv	a0,a5
    170a:	c87ff0ef          	jal	1390 <printint>
        i += 1;
    170e:	fdc42783          	lw	a5,-36(s0)
    1712:	2785                	addiw	a5,a5,1
    1714:	fcf42e23          	sw	a5,-36(s0)
    1718:	ac2d                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    171a:	fd442783          	lw	a5,-44(s0)
    171e:	0007871b          	sext.w	a4,a5
    1722:	06c00793          	li	a5,108
    1726:	04f71863          	bne	a4,a5,1776 <vprintf+0x276>
    172a:	fe442783          	lw	a5,-28(s0)
    172e:	0007871b          	sext.w	a4,a5
    1732:	06c00793          	li	a5,108
    1736:	04f71063          	bne	a4,a5,1776 <vprintf+0x276>
    173a:	fe042783          	lw	a5,-32(s0)
    173e:	0007871b          	sext.w	a4,a5
    1742:	07500793          	li	a5,117
    1746:	02f71863          	bne	a4,a5,1776 <vprintf+0x276>
        printint(fd, va_arg(ap, uint64), 10, 0);
    174a:	fb843783          	ld	a5,-72(s0)
    174e:	00878713          	addi	a4,a5,8
    1752:	fae43c23          	sd	a4,-72(s0)
    1756:	639c                	ld	a5,0(a5)
    1758:	873e                	mv	a4,a5
    175a:	fcc42783          	lw	a5,-52(s0)
    175e:	4681                	li	a3,0
    1760:	4629                	li	a2,10
    1762:	85ba                	mv	a1,a4
    1764:	853e                	mv	a0,a5
    1766:	c2bff0ef          	jal	1390 <printint>
        i += 2;
    176a:	fdc42783          	lw	a5,-36(s0)
    176e:	2789                	addiw	a5,a5,2
    1770:	fcf42e23          	sw	a5,-36(s0)
    1774:	aaf9                	j	1952 <vprintf+0x452>
      } else if(c0 == 'x'){
    1776:	fd442783          	lw	a5,-44(s0)
    177a:	0007871b          	sext.w	a4,a5
    177e:	07800793          	li	a5,120
    1782:	02f71563          	bne	a4,a5,17ac <vprintf+0x2ac>
        printint(fd, va_arg(ap, uint32), 16, 0);
    1786:	fb843783          	ld	a5,-72(s0)
    178a:	00878713          	addi	a4,a5,8
    178e:	fae43c23          	sd	a4,-72(s0)
    1792:	439c                	lw	a5,0(a5)
    1794:	02079713          	slli	a4,a5,0x20
    1798:	9301                	srli	a4,a4,0x20
    179a:	fcc42783          	lw	a5,-52(s0)
    179e:	4681                	li	a3,0
    17a0:	4641                	li	a2,16
    17a2:	85ba                	mv	a1,a4
    17a4:	853e                	mv	a0,a5
    17a6:	bebff0ef          	jal	1390 <printint>
    17aa:	a265                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'x'){
    17ac:	fd442783          	lw	a5,-44(s0)
    17b0:	0007871b          	sext.w	a4,a5
    17b4:	06c00793          	li	a5,108
    17b8:	04f71063          	bne	a4,a5,17f8 <vprintf+0x2f8>
    17bc:	fe442783          	lw	a5,-28(s0)
    17c0:	0007871b          	sext.w	a4,a5
    17c4:	07800793          	li	a5,120
    17c8:	02f71863          	bne	a4,a5,17f8 <vprintf+0x2f8>
        printint(fd, va_arg(ap, uint64), 16, 0);
    17cc:	fb843783          	ld	a5,-72(s0)
    17d0:	00878713          	addi	a4,a5,8
    17d4:	fae43c23          	sd	a4,-72(s0)
    17d8:	639c                	ld	a5,0(a5)
    17da:	873e                	mv	a4,a5
    17dc:	fcc42783          	lw	a5,-52(s0)
    17e0:	4681                	li	a3,0
    17e2:	4641                	li	a2,16
    17e4:	85ba                	mv	a1,a4
    17e6:	853e                	mv	a0,a5
    17e8:	ba9ff0ef          	jal	1390 <printint>
        i += 1;
    17ec:	fdc42783          	lw	a5,-36(s0)
    17f0:	2785                	addiw	a5,a5,1
    17f2:	fcf42e23          	sw	a5,-36(s0)
    17f6:	aab1                	j	1952 <vprintf+0x452>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    17f8:	fd442783          	lw	a5,-44(s0)
    17fc:	0007871b          	sext.w	a4,a5
    1800:	06c00793          	li	a5,108
    1804:	04f71863          	bne	a4,a5,1854 <vprintf+0x354>
    1808:	fe442783          	lw	a5,-28(s0)
    180c:	0007871b          	sext.w	a4,a5
    1810:	06c00793          	li	a5,108
    1814:	04f71063          	bne	a4,a5,1854 <vprintf+0x354>
    1818:	fe042783          	lw	a5,-32(s0)
    181c:	0007871b          	sext.w	a4,a5
    1820:	07800793          	li	a5,120
    1824:	02f71863          	bne	a4,a5,1854 <vprintf+0x354>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1828:	fb843783          	ld	a5,-72(s0)
    182c:	00878713          	addi	a4,a5,8
    1830:	fae43c23          	sd	a4,-72(s0)
    1834:	639c                	ld	a5,0(a5)
    1836:	873e                	mv	a4,a5
    1838:	fcc42783          	lw	a5,-52(s0)
    183c:	4681                	li	a3,0
    183e:	4641                	li	a2,16
    1840:	85ba                	mv	a1,a4
    1842:	853e                	mv	a0,a5
    1844:	b4dff0ef          	jal	1390 <printint>
        i += 2;
    1848:	fdc42783          	lw	a5,-36(s0)
    184c:	2789                	addiw	a5,a5,2
    184e:	fcf42e23          	sw	a5,-36(s0)
    1852:	a201                	j	1952 <vprintf+0x452>
      } else if(c0 == 'p'){
    1854:	fd442783          	lw	a5,-44(s0)
    1858:	0007871b          	sext.w	a4,a5
    185c:	07000793          	li	a5,112
    1860:	02f71063          	bne	a4,a5,1880 <vprintf+0x380>
        printptr(fd, va_arg(ap, uint64));
    1864:	fb843783          	ld	a5,-72(s0)
    1868:	00878713          	addi	a4,a5,8
    186c:	fae43c23          	sd	a4,-72(s0)
    1870:	6398                	ld	a4,0(a5)
    1872:	fcc42783          	lw	a5,-52(s0)
    1876:	85ba                	mv	a1,a4
    1878:	853e                	mv	a0,a5
    187a:	c09ff0ef          	jal	1482 <printptr>
    187e:	a8d1                	j	1952 <vprintf+0x452>
      } else if(c0 == 'c'){
    1880:	fd442783          	lw	a5,-44(s0)
    1884:	0007871b          	sext.w	a4,a5
    1888:	06300793          	li	a5,99
    188c:	02f71263          	bne	a4,a5,18b0 <vprintf+0x3b0>
        putc(fd, va_arg(ap, uint32));
    1890:	fb843783          	ld	a5,-72(s0)
    1894:	00878713          	addi	a4,a5,8
    1898:	fae43c23          	sd	a4,-72(s0)
    189c:	439c                	lw	a5,0(a5)
    189e:	0ff7f713          	zext.b	a4,a5
    18a2:	fcc42783          	lw	a5,-52(s0)
    18a6:	85ba                	mv	a1,a4
    18a8:	853e                	mv	a0,a5
    18aa:	ab5ff0ef          	jal	135e <putc>
    18ae:	a055                	j	1952 <vprintf+0x452>
      } else if(c0 == 's'){
    18b0:	fd442783          	lw	a5,-44(s0)
    18b4:	0007871b          	sext.w	a4,a5
    18b8:	07300793          	li	a5,115
    18bc:	04f71a63          	bne	a4,a5,1910 <vprintf+0x410>
        if((s = va_arg(ap, char*)) == 0)
    18c0:	fb843783          	ld	a5,-72(s0)
    18c4:	00878713          	addi	a4,a5,8
    18c8:	fae43c23          	sd	a4,-72(s0)
    18cc:	639c                	ld	a5,0(a5)
    18ce:	fef43423          	sd	a5,-24(s0)
    18d2:	fe843783          	ld	a5,-24(s0)
    18d6:	e79d                	bnez	a5,1904 <vprintf+0x404>
          s = "(null)";
    18d8:	00000797          	auipc	a5,0x0
    18dc:	56878793          	addi	a5,a5,1384 # 1e40 <malloc+0x286>
    18e0:	fef43423          	sd	a5,-24(s0)
        for(; *s; s++)
    18e4:	a005                	j	1904 <vprintf+0x404>
          putc(fd, *s);
    18e6:	fe843783          	ld	a5,-24(s0)
    18ea:	0007c703          	lbu	a4,0(a5)
    18ee:	fcc42783          	lw	a5,-52(s0)
    18f2:	85ba                	mv	a1,a4
    18f4:	853e                	mv	a0,a5
    18f6:	a69ff0ef          	jal	135e <putc>
        for(; *s; s++)
    18fa:	fe843783          	ld	a5,-24(s0)
    18fe:	0785                	addi	a5,a5,1
    1900:	fef43423          	sd	a5,-24(s0)
    1904:	fe843783          	ld	a5,-24(s0)
    1908:	0007c783          	lbu	a5,0(a5)
    190c:	ffe9                	bnez	a5,18e6 <vprintf+0x3e6>
    190e:	a091                	j	1952 <vprintf+0x452>
      } else if(c0 == '%'){
    1910:	fd442783          	lw	a5,-44(s0)
    1914:	0007871b          	sext.w	a4,a5
    1918:	02500793          	li	a5,37
    191c:	00f71a63          	bne	a4,a5,1930 <vprintf+0x430>
        putc(fd, '%');
    1920:	fcc42783          	lw	a5,-52(s0)
    1924:	02500593          	li	a1,37
    1928:	853e                	mv	a0,a5
    192a:	a35ff0ef          	jal	135e <putc>
    192e:	a015                	j	1952 <vprintf+0x452>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1930:	fcc42783          	lw	a5,-52(s0)
    1934:	02500593          	li	a1,37
    1938:	853e                	mv	a0,a5
    193a:	a25ff0ef          	jal	135e <putc>
        putc(fd, c0);
    193e:	fd442783          	lw	a5,-44(s0)
    1942:	0ff7f713          	zext.b	a4,a5
    1946:	fcc42783          	lw	a5,-52(s0)
    194a:	85ba                	mv	a1,a4
    194c:	853e                	mv	a0,a5
    194e:	a11ff0ef          	jal	135e <putc>
      }

      state = 0;
    1952:	fc042c23          	sw	zero,-40(s0)
  for(i = 0; fmt[i]; i++){
    1956:	fdc42783          	lw	a5,-36(s0)
    195a:	2785                	addiw	a5,a5,1
    195c:	fcf42e23          	sw	a5,-36(s0)
    1960:	fdc42783          	lw	a5,-36(s0)
    1964:	fc043703          	ld	a4,-64(s0)
    1968:	97ba                	add	a5,a5,a4
    196a:	0007c783          	lbu	a5,0(a5)
    196e:	ba0799e3          	bnez	a5,1520 <vprintf+0x20>
    }
  }
}
    1972:	0001                	nop
    1974:	0001                	nop
    1976:	60a6                	ld	ra,72(sp)
    1978:	6406                	ld	s0,64(sp)
    197a:	6161                	addi	sp,sp,80
    197c:	8082                	ret

000000000000197e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    197e:	7159                	addi	sp,sp,-112
    1980:	fc06                	sd	ra,56(sp)
    1982:	f822                	sd	s0,48(sp)
    1984:	0080                	addi	s0,sp,64
    1986:	fcb43823          	sd	a1,-48(s0)
    198a:	e010                	sd	a2,0(s0)
    198c:	e414                	sd	a3,8(s0)
    198e:	e818                	sd	a4,16(s0)
    1990:	ec1c                	sd	a5,24(s0)
    1992:	03043023          	sd	a6,32(s0)
    1996:	03143423          	sd	a7,40(s0)
    199a:	87aa                	mv	a5,a0
    199c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    19a0:	03040793          	addi	a5,s0,48
    19a4:	fcf43423          	sd	a5,-56(s0)
    19a8:	fc843783          	ld	a5,-56(s0)
    19ac:	fd078793          	addi	a5,a5,-48
    19b0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    19b4:	fe843703          	ld	a4,-24(s0)
    19b8:	fdc42783          	lw	a5,-36(s0)
    19bc:	863a                	mv	a2,a4
    19be:	fd043583          	ld	a1,-48(s0)
    19c2:	853e                	mv	a0,a5
    19c4:	b3dff0ef          	jal	1500 <vprintf>
}
    19c8:	0001                	nop
    19ca:	70e2                	ld	ra,56(sp)
    19cc:	7442                	ld	s0,48(sp)
    19ce:	6165                	addi	sp,sp,112
    19d0:	8082                	ret

00000000000019d2 <printf>:

void
printf(const char *fmt, ...)
{
    19d2:	7159                	addi	sp,sp,-112
    19d4:	f406                	sd	ra,40(sp)
    19d6:	f022                	sd	s0,32(sp)
    19d8:	1800                	addi	s0,sp,48
    19da:	fca43c23          	sd	a0,-40(s0)
    19de:	e40c                	sd	a1,8(s0)
    19e0:	e810                	sd	a2,16(s0)
    19e2:	ec14                	sd	a3,24(s0)
    19e4:	f018                	sd	a4,32(s0)
    19e6:	f41c                	sd	a5,40(s0)
    19e8:	03043823          	sd	a6,48(s0)
    19ec:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    19f0:	04040793          	addi	a5,s0,64
    19f4:	fcf43823          	sd	a5,-48(s0)
    19f8:	fd043783          	ld	a5,-48(s0)
    19fc:	fc878793          	addi	a5,a5,-56
    1a00:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1a04:	fe843783          	ld	a5,-24(s0)
    1a08:	863e                	mv	a2,a5
    1a0a:	fd843583          	ld	a1,-40(s0)
    1a0e:	4505                	li	a0,1
    1a10:	af1ff0ef          	jal	1500 <vprintf>
}
    1a14:	0001                	nop
    1a16:	70a2                	ld	ra,40(sp)
    1a18:	7402                	ld	s0,32(sp)
    1a1a:	6165                	addi	sp,sp,112
    1a1c:	8082                	ret

0000000000001a1e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a1e:	7179                	addi	sp,sp,-48
    1a20:	f406                	sd	ra,40(sp)
    1a22:	f022                	sd	s0,32(sp)
    1a24:	1800                	addi	s0,sp,48
    1a26:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a2a:	fd843783          	ld	a5,-40(s0)
    1a2e:	17c1                	addi	a5,a5,-16
    1a30:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a34:	00000797          	auipc	a5,0x0
    1a38:	67478793          	addi	a5,a5,1652 # 20a8 <freep>
    1a3c:	639c                	ld	a5,0(a5)
    1a3e:	fef43423          	sd	a5,-24(s0)
    1a42:	a815                	j	1a76 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1a44:	fe843783          	ld	a5,-24(s0)
    1a48:	639c                	ld	a5,0(a5)
    1a4a:	fe843703          	ld	a4,-24(s0)
    1a4e:	00f76f63          	bltu	a4,a5,1a6c <free+0x4e>
    1a52:	fe043703          	ld	a4,-32(s0)
    1a56:	fe843783          	ld	a5,-24(s0)
    1a5a:	02e7eb63          	bltu	a5,a4,1a90 <free+0x72>
    1a5e:	fe843783          	ld	a5,-24(s0)
    1a62:	639c                	ld	a5,0(a5)
    1a64:	fe043703          	ld	a4,-32(s0)
    1a68:	02f76463          	bltu	a4,a5,1a90 <free+0x72>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a6c:	fe843783          	ld	a5,-24(s0)
    1a70:	639c                	ld	a5,0(a5)
    1a72:	fef43423          	sd	a5,-24(s0)
    1a76:	fe043703          	ld	a4,-32(s0)
    1a7a:	fe843783          	ld	a5,-24(s0)
    1a7e:	fce7f3e3          	bgeu	a5,a4,1a44 <free+0x26>
    1a82:	fe843783          	ld	a5,-24(s0)
    1a86:	639c                	ld	a5,0(a5)
    1a88:	fe043703          	ld	a4,-32(s0)
    1a8c:	faf77ce3          	bgeu	a4,a5,1a44 <free+0x26>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1a90:	fe043783          	ld	a5,-32(s0)
    1a94:	479c                	lw	a5,8(a5)
    1a96:	1782                	slli	a5,a5,0x20
    1a98:	9381                	srli	a5,a5,0x20
    1a9a:	0792                	slli	a5,a5,0x4
    1a9c:	fe043703          	ld	a4,-32(s0)
    1aa0:	973e                	add	a4,a4,a5
    1aa2:	fe843783          	ld	a5,-24(s0)
    1aa6:	639c                	ld	a5,0(a5)
    1aa8:	02f71763          	bne	a4,a5,1ad6 <free+0xb8>
    bp->s.size += p->s.ptr->s.size;
    1aac:	fe043783          	ld	a5,-32(s0)
    1ab0:	4798                	lw	a4,8(a5)
    1ab2:	fe843783          	ld	a5,-24(s0)
    1ab6:	639c                	ld	a5,0(a5)
    1ab8:	479c                	lw	a5,8(a5)
    1aba:	9fb9                	addw	a5,a5,a4
    1abc:	0007871b          	sext.w	a4,a5
    1ac0:	fe043783          	ld	a5,-32(s0)
    1ac4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ac6:	fe843783          	ld	a5,-24(s0)
    1aca:	639c                	ld	a5,0(a5)
    1acc:	6398                	ld	a4,0(a5)
    1ace:	fe043783          	ld	a5,-32(s0)
    1ad2:	e398                	sd	a4,0(a5)
    1ad4:	a039                	j	1ae2 <free+0xc4>
  } else
    bp->s.ptr = p->s.ptr;
    1ad6:	fe843783          	ld	a5,-24(s0)
    1ada:	6398                	ld	a4,0(a5)
    1adc:	fe043783          	ld	a5,-32(s0)
    1ae0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1ae2:	fe843783          	ld	a5,-24(s0)
    1ae6:	479c                	lw	a5,8(a5)
    1ae8:	1782                	slli	a5,a5,0x20
    1aea:	9381                	srli	a5,a5,0x20
    1aec:	0792                	slli	a5,a5,0x4
    1aee:	fe843703          	ld	a4,-24(s0)
    1af2:	97ba                	add	a5,a5,a4
    1af4:	fe043703          	ld	a4,-32(s0)
    1af8:	02f71563          	bne	a4,a5,1b22 <free+0x104>
    p->s.size += bp->s.size;
    1afc:	fe843783          	ld	a5,-24(s0)
    1b00:	4798                	lw	a4,8(a5)
    1b02:	fe043783          	ld	a5,-32(s0)
    1b06:	479c                	lw	a5,8(a5)
    1b08:	9fb9                	addw	a5,a5,a4
    1b0a:	0007871b          	sext.w	a4,a5
    1b0e:	fe843783          	ld	a5,-24(s0)
    1b12:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1b14:	fe043783          	ld	a5,-32(s0)
    1b18:	6398                	ld	a4,0(a5)
    1b1a:	fe843783          	ld	a5,-24(s0)
    1b1e:	e398                	sd	a4,0(a5)
    1b20:	a031                	j	1b2c <free+0x10e>
  } else
    p->s.ptr = bp;
    1b22:	fe843783          	ld	a5,-24(s0)
    1b26:	fe043703          	ld	a4,-32(s0)
    1b2a:	e398                	sd	a4,0(a5)
  freep = p;
    1b2c:	00000797          	auipc	a5,0x0
    1b30:	57c78793          	addi	a5,a5,1404 # 20a8 <freep>
    1b34:	fe843703          	ld	a4,-24(s0)
    1b38:	e398                	sd	a4,0(a5)
}
    1b3a:	0001                	nop
    1b3c:	70a2                	ld	ra,40(sp)
    1b3e:	7402                	ld	s0,32(sp)
    1b40:	6145                	addi	sp,sp,48
    1b42:	8082                	ret

0000000000001b44 <morecore>:

static Header*
morecore(uint nu)
{
    1b44:	7179                	addi	sp,sp,-48
    1b46:	f406                	sd	ra,40(sp)
    1b48:	f022                	sd	s0,32(sp)
    1b4a:	1800                	addi	s0,sp,48
    1b4c:	87aa                	mv	a5,a0
    1b4e:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1b52:	fdc42783          	lw	a5,-36(s0)
    1b56:	0007871b          	sext.w	a4,a5
    1b5a:	6785                	lui	a5,0x1
    1b5c:	00f77563          	bgeu	a4,a5,1b66 <morecore+0x22>
    nu = 4096;
    1b60:	6785                	lui	a5,0x1
    1b62:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1b66:	fdc42783          	lw	a5,-36(s0)
    1b6a:	0047979b          	slliw	a5,a5,0x4
    1b6e:	2781                	sext.w	a5,a5
    1b70:	853e                	mv	a0,a5
    1b72:	ef0ff0ef          	jal	1262 <sbrk>
    1b76:	fea43423          	sd	a0,-24(s0)
  if(p == SBRK_ERROR)
    1b7a:	fe843703          	ld	a4,-24(s0)
    1b7e:	57fd                	li	a5,-1
    1b80:	00f71463          	bne	a4,a5,1b88 <morecore+0x44>
    return 0;
    1b84:	4781                	li	a5,0
    1b86:	a02d                	j	1bb0 <morecore+0x6c>
  hp = (Header*)p;
    1b88:	fe843783          	ld	a5,-24(s0)
    1b8c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1b90:	fe043783          	ld	a5,-32(s0)
    1b94:	fdc42703          	lw	a4,-36(s0)
    1b98:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1b9a:	fe043783          	ld	a5,-32(s0)
    1b9e:	07c1                	addi	a5,a5,16 # 1010 <stat+0x2>
    1ba0:	853e                	mv	a0,a5
    1ba2:	e7dff0ef          	jal	1a1e <free>
  return freep;
    1ba6:	00000797          	auipc	a5,0x0
    1baa:	50278793          	addi	a5,a5,1282 # 20a8 <freep>
    1bae:	639c                	ld	a5,0(a5)
}
    1bb0:	853e                	mv	a0,a5
    1bb2:	70a2                	ld	ra,40(sp)
    1bb4:	7402                	ld	s0,32(sp)
    1bb6:	6145                	addi	sp,sp,48
    1bb8:	8082                	ret

0000000000001bba <malloc>:

void*
malloc(uint nbytes)
{
    1bba:	7139                	addi	sp,sp,-64
    1bbc:	fc06                	sd	ra,56(sp)
    1bbe:	f822                	sd	s0,48(sp)
    1bc0:	0080                	addi	s0,sp,64
    1bc2:	87aa                	mv	a5,a0
    1bc4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1bc8:	fcc46783          	lwu	a5,-52(s0)
    1bcc:	07bd                	addi	a5,a5,15
    1bce:	8391                	srli	a5,a5,0x4
    1bd0:	2781                	sext.w	a5,a5
    1bd2:	2785                	addiw	a5,a5,1
    1bd4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1bd8:	00000797          	auipc	a5,0x0
    1bdc:	4d078793          	addi	a5,a5,1232 # 20a8 <freep>
    1be0:	639c                	ld	a5,0(a5)
    1be2:	fef43023          	sd	a5,-32(s0)
    1be6:	fe043783          	ld	a5,-32(s0)
    1bea:	ef95                	bnez	a5,1c26 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1bec:	00000797          	auipc	a5,0x0
    1bf0:	4ac78793          	addi	a5,a5,1196 # 2098 <base>
    1bf4:	fef43023          	sd	a5,-32(s0)
    1bf8:	00000797          	auipc	a5,0x0
    1bfc:	4b078793          	addi	a5,a5,1200 # 20a8 <freep>
    1c00:	fe043703          	ld	a4,-32(s0)
    1c04:	e398                	sd	a4,0(a5)
    1c06:	00000797          	auipc	a5,0x0
    1c0a:	4a278793          	addi	a5,a5,1186 # 20a8 <freep>
    1c0e:	6398                	ld	a4,0(a5)
    1c10:	00000797          	auipc	a5,0x0
    1c14:	48878793          	addi	a5,a5,1160 # 2098 <base>
    1c18:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1c1a:	00000797          	auipc	a5,0x0
    1c1e:	47e78793          	addi	a5,a5,1150 # 2098 <base>
    1c22:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c26:	fe043783          	ld	a5,-32(s0)
    1c2a:	639c                	ld	a5,0(a5)
    1c2c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1c30:	fe843783          	ld	a5,-24(s0)
    1c34:	479c                	lw	a5,8(a5)
    1c36:	fdc42703          	lw	a4,-36(s0)
    1c3a:	2701                	sext.w	a4,a4
    1c3c:	06e7e763          	bltu	a5,a4,1caa <malloc+0xf0>
      if(p->s.size == nunits)
    1c40:	fe843783          	ld	a5,-24(s0)
    1c44:	479c                	lw	a5,8(a5)
    1c46:	fdc42703          	lw	a4,-36(s0)
    1c4a:	2701                	sext.w	a4,a4
    1c4c:	00f71963          	bne	a4,a5,1c5e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1c50:	fe843783          	ld	a5,-24(s0)
    1c54:	6398                	ld	a4,0(a5)
    1c56:	fe043783          	ld	a5,-32(s0)
    1c5a:	e398                	sd	a4,0(a5)
    1c5c:	a825                	j	1c94 <malloc+0xda>
      else {
        p->s.size -= nunits;
    1c5e:	fe843783          	ld	a5,-24(s0)
    1c62:	479c                	lw	a5,8(a5)
    1c64:	fdc42703          	lw	a4,-36(s0)
    1c68:	9f99                	subw	a5,a5,a4
    1c6a:	0007871b          	sext.w	a4,a5
    1c6e:	fe843783          	ld	a5,-24(s0)
    1c72:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1c74:	fe843783          	ld	a5,-24(s0)
    1c78:	479c                	lw	a5,8(a5)
    1c7a:	1782                	slli	a5,a5,0x20
    1c7c:	9381                	srli	a5,a5,0x20
    1c7e:	0792                	slli	a5,a5,0x4
    1c80:	fe843703          	ld	a4,-24(s0)
    1c84:	97ba                	add	a5,a5,a4
    1c86:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1c8a:	fe843783          	ld	a5,-24(s0)
    1c8e:	fdc42703          	lw	a4,-36(s0)
    1c92:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1c94:	00000797          	auipc	a5,0x0
    1c98:	41478793          	addi	a5,a5,1044 # 20a8 <freep>
    1c9c:	fe043703          	ld	a4,-32(s0)
    1ca0:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1ca2:	fe843783          	ld	a5,-24(s0)
    1ca6:	07c1                	addi	a5,a5,16
    1ca8:	a081                	j	1ce8 <malloc+0x12e>
    }
    if(p == freep)
    1caa:	00000797          	auipc	a5,0x0
    1cae:	3fe78793          	addi	a5,a5,1022 # 20a8 <freep>
    1cb2:	639c                	ld	a5,0(a5)
    1cb4:	fe843703          	ld	a4,-24(s0)
    1cb8:	00f71e63          	bne	a4,a5,1cd4 <malloc+0x11a>
      if((p = morecore(nunits)) == 0)
    1cbc:	fdc42783          	lw	a5,-36(s0)
    1cc0:	853e                	mv	a0,a5
    1cc2:	e83ff0ef          	jal	1b44 <morecore>
    1cc6:	fea43423          	sd	a0,-24(s0)
    1cca:	fe843783          	ld	a5,-24(s0)
    1cce:	e399                	bnez	a5,1cd4 <malloc+0x11a>
        return 0;
    1cd0:	4781                	li	a5,0
    1cd2:	a819                	j	1ce8 <malloc+0x12e>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1cd4:	fe843783          	ld	a5,-24(s0)
    1cd8:	fef43023          	sd	a5,-32(s0)
    1cdc:	fe843783          	ld	a5,-24(s0)
    1ce0:	639c                	ld	a5,0(a5)
    1ce2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1ce6:	b7a9                	j	1c30 <malloc+0x76>
  }
}
    1ce8:	853e                	mv	a0,a5
    1cea:	70e2                	ld	ra,56(sp)
    1cec:	7442                	ld	s0,48(sp)
    1cee:	6121                	addi	sp,sp,64
    1cf0:	8082                	ret
