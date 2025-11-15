
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	94010113          	addi	sp,sp,-1728 # 8000a940 <stack0>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
        csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
        # jump to start() in start.c
        call start
    80000016:	25c000ef          	jal	80000272 <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
#ifndef __ASSEMBLER__

// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000024:	f14027f3          	csrr	a5,mhartid
    80000028:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002c:	fe843783          	ld	a5,-24(s0)
}
    80000030:	853e                	mv	a0,a5
    80000032:	60e2                	ld	ra,24(sp)
    80000034:	6442                	ld	s0,16(sp)
    80000036:	6105                	addi	sp,sp,32
    80000038:	8082                	ret

000000008000003a <r_mstatus>:
#define MSTATUS_MPP_S (1L << 11)
#define MSTATUS_MPP_U (0L << 11)

static inline uint64
r_mstatus()
{
    8000003a:	1101                	addi	sp,sp,-32
    8000003c:	ec06                	sd	ra,24(sp)
    8000003e:	e822                	sd	s0,16(sp)
    80000040:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000042:	300027f3          	csrr	a5,mstatus
    80000046:	fef43423          	sd	a5,-24(s0)
  return x;
    8000004a:	fe843783          	ld	a5,-24(s0)
}
    8000004e:	853e                	mv	a0,a5
    80000050:	60e2                	ld	ra,24(sp)
    80000052:	6442                	ld	s0,16(sp)
    80000054:	6105                	addi	sp,sp,32
    80000056:	8082                	ret

0000000080000058 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000058:	1101                	addi	sp,sp,-32
    8000005a:	ec06                	sd	ra,24(sp)
    8000005c:	e822                	sd	s0,16(sp)
    8000005e:	1000                	addi	s0,sp,32
    80000060:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000064:	fe843783          	ld	a5,-24(s0)
    80000068:	30079073          	csrw	mstatus,a5
}
    8000006c:	0001                	nop
    8000006e:	60e2                	ld	ra,24(sp)
    80000070:	6442                	ld	s0,16(sp)
    80000072:	6105                	addi	sp,sp,32
    80000074:	8082                	ret

0000000080000076 <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    80000076:	1101                	addi	sp,sp,-32
    80000078:	ec06                	sd	ra,24(sp)
    8000007a:	e822                	sd	s0,16(sp)
    8000007c:	1000                	addi	s0,sp,32
    8000007e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000082:	fe843783          	ld	a5,-24(s0)
    80000086:	34179073          	csrw	mepc,a5
}
    8000008a:	0001                	nop
    8000008c:	60e2                	ld	ra,24(sp)
    8000008e:	6442                	ld	s0,16(sp)
    80000090:	6105                	addi	sp,sp,32
    80000092:	8082                	ret

0000000080000094 <r_sie>:
// Supervisor Interrupt Enable
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
static inline uint64
r_sie()
{
    80000094:	1101                	addi	sp,sp,-32
    80000096:	ec06                	sd	ra,24(sp)
    80000098:	e822                	sd	s0,16(sp)
    8000009a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000009c:	104027f3          	csrr	a5,sie
    800000a0:	fef43423          	sd	a5,-24(s0)
  return x;
    800000a4:	fe843783          	ld	a5,-24(s0)
}
    800000a8:	853e                	mv	a0,a5
    800000aa:	60e2                	ld	ra,24(sp)
    800000ac:	6442                	ld	s0,16(sp)
    800000ae:	6105                	addi	sp,sp,32
    800000b0:	8082                	ret

00000000800000b2 <w_sie>:

static inline void 
w_sie(uint64 x)
{
    800000b2:	1101                	addi	sp,sp,-32
    800000b4:	ec06                	sd	ra,24(sp)
    800000b6:	e822                	sd	s0,16(sp)
    800000b8:	1000                	addi	s0,sp,32
    800000ba:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000be:	fe843783          	ld	a5,-24(s0)
    800000c2:	10479073          	csrw	sie,a5
}
    800000c6:	0001                	nop
    800000c8:	60e2                	ld	ra,24(sp)
    800000ca:	6442                	ld	s0,16(sp)
    800000cc:	6105                	addi	sp,sp,32
    800000ce:	8082                	ret

00000000800000d0 <r_mie>:

// Machine-mode Interrupt Enable
#define MIE_STIE (1L << 5)  // supervisor timer
static inline uint64
r_mie()
{
    800000d0:	1101                	addi	sp,sp,-32
    800000d2:	ec06                	sd	ra,24(sp)
    800000d4:	e822                	sd	s0,16(sp)
    800000d6:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000d8:	304027f3          	csrr	a5,mie
    800000dc:	fef43423          	sd	a5,-24(s0)
  return x;
    800000e0:	fe843783          	ld	a5,-24(s0)
}
    800000e4:	853e                	mv	a0,a5
    800000e6:	60e2                	ld	ra,24(sp)
    800000e8:	6442                	ld	s0,16(sp)
    800000ea:	6105                	addi	sp,sp,32
    800000ec:	8082                	ret

00000000800000ee <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000ee:	1101                	addi	sp,sp,-32
    800000f0:	ec06                	sd	ra,24(sp)
    800000f2:	e822                	sd	s0,16(sp)
    800000f4:	1000                	addi	s0,sp,32
    800000f6:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000fa:	fe843783          	ld	a5,-24(s0)
    800000fe:	30479073          	csrw	mie,a5
}
    80000102:	0001                	nop
    80000104:	60e2                	ld	ra,24(sp)
    80000106:	6442                	ld	s0,16(sp)
    80000108:	6105                	addi	sp,sp,32
    8000010a:	8082                	ret

000000008000010c <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    8000010c:	1101                	addi	sp,sp,-32
    8000010e:	ec06                	sd	ra,24(sp)
    80000110:	e822                	sd	s0,16(sp)
    80000112:	1000                	addi	s0,sp,32
    80000114:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80000118:	fe843783          	ld	a5,-24(s0)
    8000011c:	30279073          	csrw	medeleg,a5
}
    80000120:	0001                	nop
    80000122:	60e2                	ld	ra,24(sp)
    80000124:	6442                	ld	s0,16(sp)
    80000126:	6105                	addi	sp,sp,32
    80000128:	8082                	ret

000000008000012a <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    8000012a:	1101                	addi	sp,sp,-32
    8000012c:	ec06                	sd	ra,24(sp)
    8000012e:	e822                	sd	s0,16(sp)
    80000130:	1000                	addi	s0,sp,32
    80000132:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000136:	fe843783          	ld	a5,-24(s0)
    8000013a:	30379073          	csrw	mideleg,a5
}
    8000013e:	0001                	nop
    80000140:	60e2                	ld	ra,24(sp)
    80000142:	6442                	ld	s0,16(sp)
    80000144:	6105                	addi	sp,sp,32
    80000146:	8082                	ret

0000000080000148 <w_stimecmp>:
  return x;
}

static inline void 
w_stimecmp(uint64 x)
{
    80000148:	1101                	addi	sp,sp,-32
    8000014a:	ec06                	sd	ra,24(sp)
    8000014c:	e822                	sd	s0,16(sp)
    8000014e:	1000                	addi	s0,sp,32
    80000150:	fea43423          	sd	a0,-24(s0)
  // asm volatile("csrw stimecmp, %0" : : "r" (x));
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80000154:	fe843783          	ld	a5,-24(s0)
    80000158:	14d79073          	csrw	stimecmp,a5
}
    8000015c:	0001                	nop
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret

0000000080000166 <r_menvcfg>:

// Machine Environment Configuration Register
static inline uint64
r_menvcfg()
{
    80000166:	1101                	addi	sp,sp,-32
    80000168:	ec06                	sd	ra,24(sp)
    8000016a:	e822                	sd	s0,16(sp)
    8000016c:	1000                	addi	s0,sp,32
  uint64 x;
  // asm volatile("csrr %0, menvcfg" : "=r" (x) );
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    8000016e:	30a027f3          	csrr	a5,0x30a
    80000172:	fef43423          	sd	a5,-24(s0)
  return x;
    80000176:	fe843783          	ld	a5,-24(s0)
}
    8000017a:	853e                	mv	a0,a5
    8000017c:	60e2                	ld	ra,24(sp)
    8000017e:	6442                	ld	s0,16(sp)
    80000180:	6105                	addi	sp,sp,32
    80000182:	8082                	ret

0000000080000184 <w_menvcfg>:

static inline void 
w_menvcfg(uint64 x)
{
    80000184:	1101                	addi	sp,sp,-32
    80000186:	ec06                	sd	ra,24(sp)
    80000188:	e822                	sd	s0,16(sp)
    8000018a:	1000                	addi	s0,sp,32
    8000018c:	fea43423          	sd	a0,-24(s0)
  // asm volatile("csrw menvcfg, %0" : : "r" (x));
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80000190:	fe843783          	ld	a5,-24(s0)
    80000194:	30a79073          	csrw	0x30a,a5
}
    80000198:	0001                	nop
    8000019a:	60e2                	ld	ra,24(sp)
    8000019c:	6442                	ld	s0,16(sp)
    8000019e:	6105                	addi	sp,sp,32
    800001a0:	8082                	ret

00000000800001a2 <w_pmpcfg0>:

// Physical Memory Protection
static inline void
w_pmpcfg0(uint64 x)
{
    800001a2:	1101                	addi	sp,sp,-32
    800001a4:	ec06                	sd	ra,24(sp)
    800001a6:	e822                	sd	s0,16(sp)
    800001a8:	1000                	addi	s0,sp,32
    800001aa:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800001ae:	fe843783          	ld	a5,-24(s0)
    800001b2:	3a079073          	csrw	pmpcfg0,a5
}
    800001b6:	0001                	nop
    800001b8:	60e2                	ld	ra,24(sp)
    800001ba:	6442                	ld	s0,16(sp)
    800001bc:	6105                	addi	sp,sp,32
    800001be:	8082                	ret

00000000800001c0 <w_pmpaddr0>:

static inline void
w_pmpaddr0(uint64 x)
{
    800001c0:	1101                	addi	sp,sp,-32
    800001c2:	ec06                	sd	ra,24(sp)
    800001c4:	e822                	sd	s0,16(sp)
    800001c6:	1000                	addi	s0,sp,32
    800001c8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800001cc:	fe843783          	ld	a5,-24(s0)
    800001d0:	3b079073          	csrw	pmpaddr0,a5
}
    800001d4:	0001                	nop
    800001d6:	60e2                	ld	ra,24(sp)
    800001d8:	6442                	ld	s0,16(sp)
    800001da:	6105                	addi	sp,sp,32
    800001dc:	8082                	ret

00000000800001de <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    800001de:	1101                	addi	sp,sp,-32
    800001e0:	ec06                	sd	ra,24(sp)
    800001e2:	e822                	sd	s0,16(sp)
    800001e4:	1000                	addi	s0,sp,32
    800001e6:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    800001ea:	fe843783          	ld	a5,-24(s0)
    800001ee:	18079073          	csrw	satp,a5
}
    800001f2:	0001                	nop
    800001f4:	60e2                	ld	ra,24(sp)
    800001f6:	6442                	ld	s0,16(sp)
    800001f8:	6105                	addi	sp,sp,32
    800001fa:	8082                	ret

00000000800001fc <w_mcounteren>:
}

// Machine-mode Counter-Enable
static inline void 
w_mcounteren(uint64 x)
{
    800001fc:	1101                	addi	sp,sp,-32
    800001fe:	ec06                	sd	ra,24(sp)
    80000200:	e822                	sd	s0,16(sp)
    80000202:	1000                	addi	s0,sp,32
    80000204:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80000208:	fe843783          	ld	a5,-24(s0)
    8000020c:	30679073          	csrw	mcounteren,a5
}
    80000210:	0001                	nop
    80000212:	60e2                	ld	ra,24(sp)
    80000214:	6442                	ld	s0,16(sp)
    80000216:	6105                	addi	sp,sp,32
    80000218:	8082                	ret

000000008000021a <r_mcounteren>:

static inline uint64
r_mcounteren()
{
    8000021a:	1101                	addi	sp,sp,-32
    8000021c:	ec06                	sd	ra,24(sp)
    8000021e:	e822                	sd	s0,16(sp)
    80000220:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80000222:	306027f3          	csrr	a5,mcounteren
    80000226:	fef43423          	sd	a5,-24(s0)
  return x;
    8000022a:	fe843783          	ld	a5,-24(s0)
}
    8000022e:	853e                	mv	a0,a5
    80000230:	60e2                	ld	ra,24(sp)
    80000232:	6442                	ld	s0,16(sp)
    80000234:	6105                	addi	sp,sp,32
    80000236:	8082                	ret

0000000080000238 <r_time>:

// machine-mode cycle counter
static inline uint64
r_time()
{
    80000238:	1101                	addi	sp,sp,-32
    8000023a:	ec06                	sd	ra,24(sp)
    8000023c:	e822                	sd	s0,16(sp)
    8000023e:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, time" : "=r" (x) );
    80000240:	c01027f3          	rdtime	a5
    80000244:	fef43423          	sd	a5,-24(s0)
  return x;
    80000248:	fe843783          	ld	a5,-24(s0)
}
    8000024c:	853e                	mv	a0,a5
    8000024e:	60e2                	ld	ra,24(sp)
    80000250:	6442                	ld	s0,16(sp)
    80000252:	6105                	addi	sp,sp,32
    80000254:	8082                	ret

0000000080000256 <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    80000256:	1101                	addi	sp,sp,-32
    80000258:	ec06                	sd	ra,24(sp)
    8000025a:	e822                	sd	s0,16(sp)
    8000025c:	1000                	addi	s0,sp,32
    8000025e:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    80000262:	fe843783          	ld	a5,-24(s0)
    80000266:	823e                	mv	tp,a5
}
    80000268:	0001                	nop
    8000026a:	60e2                	ld	ra,24(sp)
    8000026c:	6442                	ld	s0,16(sp)
    8000026e:	6105                	addi	sp,sp,32
    80000270:	8082                	ret

0000000080000272 <start>:
__attribute__ ((aligned (16))) char stack0[4096 * NCPU];

// entry.S jumps here in machine mode on stack0.
void
start()
{
    80000272:	1101                	addi	sp,sp,-32
    80000274:	ec06                	sd	ra,24(sp)
    80000276:	e822                	sd	s0,16(sp)
    80000278:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    8000027a:	dc1ff0ef          	jal	8000003a <r_mstatus>
    8000027e:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    80000282:	fe843703          	ld	a4,-24(s0)
    80000286:	77f9                	lui	a5,0xffffe
    80000288:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffdaba7>
    8000028c:	8ff9                	and	a5,a5,a4
    8000028e:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    80000292:	fe843703          	ld	a4,-24(s0)
    80000296:	6785                	lui	a5,0x1
    80000298:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    8000029c:	8fd9                	or	a5,a5,a4
    8000029e:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800002a2:	fe843503          	ld	a0,-24(s0)
    800002a6:	db3ff0ef          	jal	80000058 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800002aa:	00001797          	auipc	a5,0x1
    800002ae:	5fa78793          	addi	a5,a5,1530 # 800018a4 <main>
    800002b2:	853e                	mv	a0,a5
    800002b4:	dc3ff0ef          	jal	80000076 <w_mepc>

  // disable paging for now.
  w_satp(0);
    800002b8:	4501                	li	a0,0
    800002ba:	f25ff0ef          	jal	800001de <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    800002be:	67c1                	lui	a5,0x10
    800002c0:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800002c4:	e49ff0ef          	jal	8000010c <w_medeleg>
  w_mideleg(0xffff);
    800002c8:	67c1                	lui	a5,0x10
    800002ca:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800002ce:	e5dff0ef          	jal	8000012a <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    800002d2:	dc3ff0ef          	jal	80000094 <r_sie>
    800002d6:	87aa                	mv	a5,a0
    800002d8:	2207e793          	ori	a5,a5,544
    800002dc:	853e                	mv	a0,a5
    800002de:	dd5ff0ef          	jal	800000b2 <w_sie>

  // configure Physical Memory Protection to give supervisor mode
  // access to all of physical memory.
  w_pmpaddr0(0x3fffffffffffffull);
    800002e2:	57fd                	li	a5,-1
    800002e4:	00a7d513          	srli	a0,a5,0xa
    800002e8:	ed9ff0ef          	jal	800001c0 <w_pmpaddr0>
  w_pmpcfg0(0xf);
    800002ec:	453d                	li	a0,15
    800002ee:	eb5ff0ef          	jal	800001a2 <w_pmpcfg0>

  // ask for clock interrupts.
  timerinit();
    800002f2:	026000ef          	jal	80000318 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    800002f6:	d27ff0ef          	jal	8000001c <r_mhartid>
    800002fa:	87aa                	mv	a5,a0
    800002fc:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    80000300:	fe442783          	lw	a5,-28(s0)
    80000304:	853e                	mv	a0,a5
    80000306:	f51ff0ef          	jal	80000256 <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    8000030a:	30200073          	mret
}
    8000030e:	0001                	nop
    80000310:	60e2                	ld	ra,24(sp)
    80000312:	6442                	ld	s0,16(sp)
    80000314:	6105                	addi	sp,sp,32
    80000316:	8082                	ret

0000000080000318 <timerinit>:

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80000318:	1141                	addi	sp,sp,-16
    8000031a:	e406                	sd	ra,8(sp)
    8000031c:	e022                	sd	s0,0(sp)
    8000031e:	0800                	addi	s0,sp,16
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80000320:	db1ff0ef          	jal	800000d0 <r_mie>
    80000324:	87aa                	mv	a5,a0
    80000326:	0207e793          	ori	a5,a5,32
    8000032a:	853e                	mv	a0,a5
    8000032c:	dc3ff0ef          	jal	800000ee <w_mie>
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80000330:	e37ff0ef          	jal	80000166 <r_menvcfg>
    80000334:	872a                	mv	a4,a0
    80000336:	57fd                	li	a5,-1
    80000338:	17fe                	slli	a5,a5,0x3f
    8000033a:	8fd9                	or	a5,a5,a4
    8000033c:	853e                	mv	a0,a5
    8000033e:	e47ff0ef          	jal	80000184 <w_menvcfg>
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80000342:	ed9ff0ef          	jal	8000021a <r_mcounteren>
    80000346:	87aa                	mv	a5,a0
    80000348:	0027e793          	ori	a5,a5,2
    8000034c:	853e                	mv	a0,a5
    8000034e:	eafff0ef          	jal	800001fc <w_mcounteren>
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80000352:	ee7ff0ef          	jal	80000238 <r_time>
    80000356:	872a                	mv	a4,a0
    80000358:	000f47b7          	lui	a5,0xf4
    8000035c:	24078793          	addi	a5,a5,576 # f4240 <_entry-0x7ff0bdc0>
    80000360:	97ba                	add	a5,a5,a4
    80000362:	853e                	mv	a0,a5
    80000364:	de5ff0ef          	jal	80000148 <w_stimecmp>
}
    80000368:	0001                	nop
    8000036a:	60a2                	ld	ra,8(sp)
    8000036c:	6402                	ld	s0,0(sp)
    8000036e:	0141                	addi	sp,sp,16
    80000370:	8082                	ret

0000000080000372 <consputc>:
// interrupts, e.g. by printf and to echo input
// characters.
//
void
consputc(int c)
{
    80000372:	1101                	addi	sp,sp,-32
    80000374:	ec06                	sd	ra,24(sp)
    80000376:	e822                	sd	s0,16(sp)
    80000378:	1000                	addi	s0,sp,32
    8000037a:	87aa                	mv	a5,a0
    8000037c:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000380:	fec42783          	lw	a5,-20(s0)
    80000384:	0007871b          	sext.w	a4,a5
    80000388:	10000793          	li	a5,256
    8000038c:	00f71d63          	bne	a4,a5,800003a6 <consputc+0x34>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000390:	4521                	li	a0,8
    80000392:	41d000ef          	jal	80000fae <uartputc_sync>
    80000396:	02000513          	li	a0,32
    8000039a:	415000ef          	jal	80000fae <uartputc_sync>
    8000039e:	4521                	li	a0,8
    800003a0:	40f000ef          	jal	80000fae <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    800003a4:	a031                	j	800003b0 <consputc+0x3e>
    uartputc_sync(c);
    800003a6:	fec42783          	lw	a5,-20(s0)
    800003aa:	853e                	mv	a0,a5
    800003ac:	403000ef          	jal	80000fae <uartputc_sync>
}
    800003b0:	0001                	nop
    800003b2:	60e2                	ld	ra,24(sp)
    800003b4:	6442                	ld	s0,16(sp)
    800003b6:	6105                	addi	sp,sp,32
    800003b8:	8082                	ret

00000000800003ba <consolewrite>:
// user write() system calls to the console go here.
// uses sleep() and UART interrupts.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800003ba:	715d                	addi	sp,sp,-80
    800003bc:	e486                	sd	ra,72(sp)
    800003be:	e0a2                	sd	s0,64(sp)
    800003c0:	0880                	addi	s0,sp,80
    800003c2:	87aa                	mv	a5,a0
    800003c4:	fab43823          	sd	a1,-80(s0)
    800003c8:	8732                	mv	a4,a2
    800003ca:	faf42e23          	sw	a5,-68(s0)
    800003ce:	87ba                	mv	a5,a4
    800003d0:	faf42c23          	sw	a5,-72(s0)
  char buf[32]; // move batches from user space to uart.
  int i = 0;
    800003d4:	fe042623          	sw	zero,-20(s0)

  while(i < n){
    800003d8:	a041                	j	80000458 <consolewrite+0x9e>
    int nn = sizeof(buf);
    800003da:	02000793          	li	a5,32
    800003de:	fef42423          	sw	a5,-24(s0)
    if(nn > n - i)
    800003e2:	fb842783          	lw	a5,-72(s0)
    800003e6:	873e                	mv	a4,a5
    800003e8:	fec42783          	lw	a5,-20(s0)
    800003ec:	40f707bb          	subw	a5,a4,a5
    800003f0:	2781                	sext.w	a5,a5
    800003f2:	fe842703          	lw	a4,-24(s0)
    800003f6:	2701                	sext.w	a4,a4
    800003f8:	00e7db63          	bge	a5,a4,8000040e <consolewrite+0x54>
      nn = n - i;
    800003fc:	fb842783          	lw	a5,-72(s0)
    80000400:	873e                	mv	a4,a5
    80000402:	fec42783          	lw	a5,-20(s0)
    80000406:	40f707bb          	subw	a5,a4,a5
    8000040a:	fef42423          	sw	a5,-24(s0)
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    8000040e:	fec42703          	lw	a4,-20(s0)
    80000412:	fb043783          	ld	a5,-80(s0)
    80000416:	00f70633          	add	a2,a4,a5
    8000041a:	fe842683          	lw	a3,-24(s0)
    8000041e:	fbc42703          	lw	a4,-68(s0)
    80000422:	fc840793          	addi	a5,s0,-56
    80000426:	85ba                	mv	a1,a4
    80000428:	853e                	mv	a0,a5
    8000042a:	11a030ef          	jal	80003544 <either_copyin>
    8000042e:	87aa                	mv	a5,a0
    80000430:	873e                	mv	a4,a5
    80000432:	57fd                	li	a5,-1
    80000434:	02f70c63          	beq	a4,a5,8000046c <consolewrite+0xb2>
      break;
    uartwrite(buf, nn);
    80000438:	fe842703          	lw	a4,-24(s0)
    8000043c:	fc840793          	addi	a5,s0,-56
    80000440:	85ba                	mv	a1,a4
    80000442:	853e                	mv	a0,a5
    80000444:	2d3000ef          	jal	80000f16 <uartwrite>
    i += nn;
    80000448:	fec42783          	lw	a5,-20(s0)
    8000044c:	873e                	mv	a4,a5
    8000044e:	fe842783          	lw	a5,-24(s0)
    80000452:	9fb9                	addw	a5,a5,a4
    80000454:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80000458:	fec42783          	lw	a5,-20(s0)
    8000045c:	873e                	mv	a4,a5
    8000045e:	fb842783          	lw	a5,-72(s0)
    80000462:	2701                	sext.w	a4,a4
    80000464:	2781                	sext.w	a5,a5
    80000466:	f6f74ae3          	blt	a4,a5,800003da <consolewrite+0x20>
    8000046a:	a011                	j	8000046e <consolewrite+0xb4>
      break;
    8000046c:	0001                	nop
  }

  return i;
    8000046e:	fec42783          	lw	a5,-20(s0)
}
    80000472:	853e                	mv	a0,a5
    80000474:	60a6                	ld	ra,72(sp)
    80000476:	6406                	ld	s0,64(sp)
    80000478:	6161                	addi	sp,sp,80
    8000047a:	8082                	ret

000000008000047c <consoleread>:
// user_dst indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    8000047c:	7179                	addi	sp,sp,-48
    8000047e:	f406                	sd	ra,40(sp)
    80000480:	f022                	sd	s0,32(sp)
    80000482:	1800                	addi	s0,sp,48
    80000484:	87aa                	mv	a5,a0
    80000486:	fcb43823          	sd	a1,-48(s0)
    8000048a:	8732                	mv	a4,a2
    8000048c:	fcf42e23          	sw	a5,-36(s0)
    80000490:	87ba                	mv	a5,a4
    80000492:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    80000496:	fd842783          	lw	a5,-40(s0)
    8000049a:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    8000049e:	00012517          	auipc	a0,0x12
    800004a2:	4a250513          	addi	a0,a0,1186 # 80012940 <cons>
    800004a6:	6a5000ef          	jal	8000134a <acquire>
  while(n > 0){
    800004aa:	aa21                	j	800005c2 <consoleread+0x146>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(killed(myproc())){
    800004ac:	3a8020ef          	jal	80002854 <myproc>
    800004b0:	87aa                	mv	a5,a0
    800004b2:	853e                	mv	a0,a5
    800004b4:	7f1020ef          	jal	800034a4 <killed>
    800004b8:	87aa                	mv	a5,a0
    800004ba:	cb89                	beqz	a5,800004cc <consoleread+0x50>
        release(&cons.lock);
    800004bc:	00012517          	auipc	a0,0x12
    800004c0:	48450513          	addi	a0,a0,1156 # 80012940 <cons>
    800004c4:	6db000ef          	jal	8000139e <release>
        return -1;
    800004c8:	57fd                	li	a5,-1
    800004ca:	a225                	j	800005f2 <consoleread+0x176>
      }
      sleep(&cons.r, &cons.lock);
    800004cc:	00012597          	auipc	a1,0x12
    800004d0:	47458593          	addi	a1,a1,1140 # 80012940 <cons>
    800004d4:	00012517          	auipc	a0,0x12
    800004d8:	50450513          	addi	a0,a0,1284 # 800129d8 <cons+0x98>
    800004dc:	61b020ef          	jal	800032f6 <sleep>
    while(cons.r == cons.w){
    800004e0:	00012797          	auipc	a5,0x12
    800004e4:	46078793          	addi	a5,a5,1120 # 80012940 <cons>
    800004e8:	0987a703          	lw	a4,152(a5)
    800004ec:	00012797          	auipc	a5,0x12
    800004f0:	45478793          	addi	a5,a5,1108 # 80012940 <cons>
    800004f4:	09c7a783          	lw	a5,156(a5)
    800004f8:	faf70ae3          	beq	a4,a5,800004ac <consoleread+0x30>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800004fc:	00012797          	auipc	a5,0x12
    80000500:	44478793          	addi	a5,a5,1092 # 80012940 <cons>
    80000504:	0987a783          	lw	a5,152(a5)
    80000508:	0017871b          	addiw	a4,a5,1
    8000050c:	0007069b          	sext.w	a3,a4
    80000510:	00012717          	auipc	a4,0x12
    80000514:	43070713          	addi	a4,a4,1072 # 80012940 <cons>
    80000518:	08d72c23          	sw	a3,152(a4)
    8000051c:	07f7f793          	andi	a5,a5,127
    80000520:	2781                	sext.w	a5,a5
    80000522:	00012717          	auipc	a4,0x12
    80000526:	41e70713          	addi	a4,a4,1054 # 80012940 <cons>
    8000052a:	1782                	slli	a5,a5,0x20
    8000052c:	9381                	srli	a5,a5,0x20
    8000052e:	97ba                	add	a5,a5,a4
    80000530:	0187c783          	lbu	a5,24(a5)
    80000534:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    80000538:	fe842783          	lw	a5,-24(s0)
    8000053c:	0007871b          	sext.w	a4,a5
    80000540:	4791                	li	a5,4
    80000542:	02f71963          	bne	a4,a5,80000574 <consoleread+0xf8>
      if(n < target){
    80000546:	fd842783          	lw	a5,-40(s0)
    8000054a:	fec42703          	lw	a4,-20(s0)
    8000054e:	2701                	sext.w	a4,a4
    80000550:	06e7ff63          	bgeu	a5,a4,800005ce <consoleread+0x152>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    80000554:	00012797          	auipc	a5,0x12
    80000558:	3ec78793          	addi	a5,a5,1004 # 80012940 <cons>
    8000055c:	0987a783          	lw	a5,152(a5)
    80000560:	37fd                	addiw	a5,a5,-1
    80000562:	0007871b          	sext.w	a4,a5
    80000566:	00012797          	auipc	a5,0x12
    8000056a:	3da78793          	addi	a5,a5,986 # 80012940 <cons>
    8000056e:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    80000572:	a8b1                	j	800005ce <consoleread+0x152>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000574:	fe842783          	lw	a5,-24(s0)
    80000578:	0ff7f793          	zext.b	a5,a5
    8000057c:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000580:	fe740713          	addi	a4,s0,-25
    80000584:	fdc42783          	lw	a5,-36(s0)
    80000588:	4685                	li	a3,1
    8000058a:	863a                	mv	a2,a4
    8000058c:	fd043583          	ld	a1,-48(s0)
    80000590:	853e                	mv	a0,a5
    80000592:	74b020ef          	jal	800034dc <either_copyout>
    80000596:	87aa                	mv	a5,a0
    80000598:	873e                	mv	a4,a5
    8000059a:	57fd                	li	a5,-1
    8000059c:	02f70b63          	beq	a4,a5,800005d2 <consoleread+0x156>
      break;

    dst++;
    800005a0:	fd043783          	ld	a5,-48(s0)
    800005a4:	0785                	addi	a5,a5,1
    800005a6:	fcf43823          	sd	a5,-48(s0)
    --n;
    800005aa:	fd842783          	lw	a5,-40(s0)
    800005ae:	37fd                	addiw	a5,a5,-1
    800005b0:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    800005b4:	fe842783          	lw	a5,-24(s0)
    800005b8:	0007871b          	sext.w	a4,a5
    800005bc:	47a9                	li	a5,10
    800005be:	00f70c63          	beq	a4,a5,800005d6 <consoleread+0x15a>
  while(n > 0){
    800005c2:	fd842783          	lw	a5,-40(s0)
    800005c6:	2781                	sext.w	a5,a5
    800005c8:	f0f04ce3          	bgtz	a5,800004e0 <consoleread+0x64>
    800005cc:	a031                	j	800005d8 <consoleread+0x15c>
      break;
    800005ce:	0001                	nop
    800005d0:	a021                	j	800005d8 <consoleread+0x15c>
      break;
    800005d2:	0001                	nop
    800005d4:	a011                	j	800005d8 <consoleread+0x15c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    800005d6:	0001                	nop
    }
  }
  release(&cons.lock);
    800005d8:	00012517          	auipc	a0,0x12
    800005dc:	36850513          	addi	a0,a0,872 # 80012940 <cons>
    800005e0:	5bf000ef          	jal	8000139e <release>

  return target - n;
    800005e4:	fd842783          	lw	a5,-40(s0)
    800005e8:	fec42703          	lw	a4,-20(s0)
    800005ec:	40f707bb          	subw	a5,a4,a5
    800005f0:	2781                	sext.w	a5,a5
}
    800005f2:	853e                	mv	a0,a5
    800005f4:	70a2                	ld	ra,40(sp)
    800005f6:	7402                	ld	s0,32(sp)
    800005f8:	6145                	addi	sp,sp,48
    800005fa:	8082                	ret

00000000800005fc <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005fc:	1101                	addi	sp,sp,-32
    800005fe:	ec06                	sd	ra,24(sp)
    80000600:	e822                	sd	s0,16(sp)
    80000602:	1000                	addi	s0,sp,32
    80000604:	87aa                	mv	a5,a0
    80000606:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    8000060a:	00012517          	auipc	a0,0x12
    8000060e:	33650513          	addi	a0,a0,822 # 80012940 <cons>
    80000612:	539000ef          	jal	8000134a <acquire>

  switch(c){
    80000616:	fec42783          	lw	a5,-20(s0)
    8000061a:	0007871b          	sext.w	a4,a5
    8000061e:	07f00793          	li	a5,127
    80000622:	0cf70363          	beq	a4,a5,800006e8 <consoleintr+0xec>
    80000626:	fec42783          	lw	a5,-20(s0)
    8000062a:	0007871b          	sext.w	a4,a5
    8000062e:	07f00793          	li	a5,127
    80000632:	0ee7cd63          	blt	a5,a4,8000072c <consoleintr+0x130>
    80000636:	fec42783          	lw	a5,-20(s0)
    8000063a:	0007871b          	sext.w	a4,a5
    8000063e:	47d5                	li	a5,21
    80000640:	04f70d63          	beq	a4,a5,8000069a <consoleintr+0x9e>
    80000644:	fec42783          	lw	a5,-20(s0)
    80000648:	0007871b          	sext.w	a4,a5
    8000064c:	47d5                	li	a5,21
    8000064e:	0ce7cf63          	blt	a5,a4,8000072c <consoleintr+0x130>
    80000652:	fec42783          	lw	a5,-20(s0)
    80000656:	0007871b          	sext.w	a4,a5
    8000065a:	47a1                	li	a5,8
    8000065c:	08f70663          	beq	a4,a5,800006e8 <consoleintr+0xec>
    80000660:	fec42783          	lw	a5,-20(s0)
    80000664:	0007871b          	sext.w	a4,a5
    80000668:	47c1                	li	a5,16
    8000066a:	0cf71163          	bne	a4,a5,8000072c <consoleintr+0x130>
  case C('P'):  // Print process list.
    procdump();
    8000066e:	73f020ef          	jal	800035ac <procdump>
    break;
    80000672:	a2d1                	j	80000836 <consoleintr+0x23a>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
      cons.e--;
    80000674:	00012797          	auipc	a5,0x12
    80000678:	2cc78793          	addi	a5,a5,716 # 80012940 <cons>
    8000067c:	0a07a783          	lw	a5,160(a5)
    80000680:	37fd                	addiw	a5,a5,-1
    80000682:	0007871b          	sext.w	a4,a5
    80000686:	00012797          	auipc	a5,0x12
    8000068a:	2ba78793          	addi	a5,a5,698 # 80012940 <cons>
    8000068e:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000692:	10000513          	li	a0,256
    80000696:	cddff0ef          	jal	80000372 <consputc>
    while(cons.e != cons.w &&
    8000069a:	00012797          	auipc	a5,0x12
    8000069e:	2a678793          	addi	a5,a5,678 # 80012940 <cons>
    800006a2:	0a07a703          	lw	a4,160(a5)
    800006a6:	00012797          	auipc	a5,0x12
    800006aa:	29a78793          	addi	a5,a5,666 # 80012940 <cons>
    800006ae:	09c7a783          	lw	a5,156(a5)
    800006b2:	16f70d63          	beq	a4,a5,8000082c <consoleintr+0x230>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800006b6:	00012797          	auipc	a5,0x12
    800006ba:	28a78793          	addi	a5,a5,650 # 80012940 <cons>
    800006be:	0a07a783          	lw	a5,160(a5)
    800006c2:	37fd                	addiw	a5,a5,-1
    800006c4:	2781                	sext.w	a5,a5
    800006c6:	07f7f793          	andi	a5,a5,127
    800006ca:	2781                	sext.w	a5,a5
    800006cc:	00012717          	auipc	a4,0x12
    800006d0:	27470713          	addi	a4,a4,628 # 80012940 <cons>
    800006d4:	1782                	slli	a5,a5,0x20
    800006d6:	9381                	srli	a5,a5,0x20
    800006d8:	97ba                	add	a5,a5,a4
    800006da:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006de:	873e                	mv	a4,a5
    800006e0:	47a9                	li	a5,10
    800006e2:	f8f719e3          	bne	a4,a5,80000674 <consoleintr+0x78>
    }
    break;
    800006e6:	a299                	j	8000082c <consoleintr+0x230>
  case C('H'): // Backspace
  case '\x7f': // Delete key
    if(cons.e != cons.w){
    800006e8:	00012797          	auipc	a5,0x12
    800006ec:	25878793          	addi	a5,a5,600 # 80012940 <cons>
    800006f0:	0a07a703          	lw	a4,160(a5)
    800006f4:	00012797          	auipc	a5,0x12
    800006f8:	24c78793          	addi	a5,a5,588 # 80012940 <cons>
    800006fc:	09c7a783          	lw	a5,156(a5)
    80000700:	12f70863          	beq	a4,a5,80000830 <consoleintr+0x234>
      cons.e--;
    80000704:	00012797          	auipc	a5,0x12
    80000708:	23c78793          	addi	a5,a5,572 # 80012940 <cons>
    8000070c:	0a07a783          	lw	a5,160(a5)
    80000710:	37fd                	addiw	a5,a5,-1
    80000712:	0007871b          	sext.w	a4,a5
    80000716:	00012797          	auipc	a5,0x12
    8000071a:	22a78793          	addi	a5,a5,554 # 80012940 <cons>
    8000071e:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000722:	10000513          	li	a0,256
    80000726:	c4dff0ef          	jal	80000372 <consputc>
    }
    break;
    8000072a:	a219                	j	80000830 <consoleintr+0x234>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000072c:	fec42783          	lw	a5,-20(s0)
    80000730:	2781                	sext.w	a5,a5
    80000732:	10078163          	beqz	a5,80000834 <consoleintr+0x238>
    80000736:	00012797          	auipc	a5,0x12
    8000073a:	20a78793          	addi	a5,a5,522 # 80012940 <cons>
    8000073e:	0a07a703          	lw	a4,160(a5)
    80000742:	00012797          	auipc	a5,0x12
    80000746:	1fe78793          	addi	a5,a5,510 # 80012940 <cons>
    8000074a:	0987a783          	lw	a5,152(a5)
    8000074e:	40f707bb          	subw	a5,a4,a5
    80000752:	0007871b          	sext.w	a4,a5
    80000756:	07f00793          	li	a5,127
    8000075a:	0ce7ed63          	bltu	a5,a4,80000834 <consoleintr+0x238>
      c = (c == '\r') ? '\n' : c;
    8000075e:	fec42783          	lw	a5,-20(s0)
    80000762:	0007871b          	sext.w	a4,a5
    80000766:	47b5                	li	a5,13
    80000768:	00f70563          	beq	a4,a5,80000772 <consoleintr+0x176>
    8000076c:	fec42783          	lw	a5,-20(s0)
    80000770:	a011                	j	80000774 <consoleintr+0x178>
    80000772:	47a9                	li	a5,10
    80000774:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    80000778:	fec42783          	lw	a5,-20(s0)
    8000077c:	853e                	mv	a0,a5
    8000077e:	bf5ff0ef          	jal	80000372 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000782:	00012797          	auipc	a5,0x12
    80000786:	1be78793          	addi	a5,a5,446 # 80012940 <cons>
    8000078a:	0a07a783          	lw	a5,160(a5)
    8000078e:	0017871b          	addiw	a4,a5,1
    80000792:	0007069b          	sext.w	a3,a4
    80000796:	00012717          	auipc	a4,0x12
    8000079a:	1aa70713          	addi	a4,a4,426 # 80012940 <cons>
    8000079e:	0ad72023          	sw	a3,160(a4)
    800007a2:	07f7f793          	andi	a5,a5,127
    800007a6:	2781                	sext.w	a5,a5
    800007a8:	fec42703          	lw	a4,-20(s0)
    800007ac:	0ff77713          	zext.b	a4,a4
    800007b0:	00012697          	auipc	a3,0x12
    800007b4:	19068693          	addi	a3,a3,400 # 80012940 <cons>
    800007b8:	1782                	slli	a5,a5,0x20
    800007ba:	9381                	srli	a5,a5,0x20
    800007bc:	97b6                	add	a5,a5,a3
    800007be:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    800007c2:	fec42783          	lw	a5,-20(s0)
    800007c6:	0007871b          	sext.w	a4,a5
    800007ca:	47a9                	li	a5,10
    800007cc:	02f70d63          	beq	a4,a5,80000806 <consoleintr+0x20a>
    800007d0:	fec42783          	lw	a5,-20(s0)
    800007d4:	0007871b          	sext.w	a4,a5
    800007d8:	4791                	li	a5,4
    800007da:	02f70663          	beq	a4,a5,80000806 <consoleintr+0x20a>
    800007de:	00012797          	auipc	a5,0x12
    800007e2:	16278793          	addi	a5,a5,354 # 80012940 <cons>
    800007e6:	0a07a703          	lw	a4,160(a5)
    800007ea:	00012797          	auipc	a5,0x12
    800007ee:	15678793          	addi	a5,a5,342 # 80012940 <cons>
    800007f2:	0987a783          	lw	a5,152(a5)
    800007f6:	40f707bb          	subw	a5,a4,a5
    800007fa:	0007871b          	sext.w	a4,a5
    800007fe:	08000793          	li	a5,128
    80000802:	02f71963          	bne	a4,a5,80000834 <consoleintr+0x238>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000806:	00012797          	auipc	a5,0x12
    8000080a:	13a78793          	addi	a5,a5,314 # 80012940 <cons>
    8000080e:	0a07a703          	lw	a4,160(a5)
    80000812:	00012797          	auipc	a5,0x12
    80000816:	12e78793          	addi	a5,a5,302 # 80012940 <cons>
    8000081a:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000081e:	00012517          	auipc	a0,0x12
    80000822:	1ba50513          	addi	a0,a0,442 # 800129d8 <cons+0x98>
    80000826:	335020ef          	jal	8000335a <wakeup>
      }
    }
    break;
    8000082a:	a029                	j	80000834 <consoleintr+0x238>
    break;
    8000082c:	0001                	nop
    8000082e:	a021                	j	80000836 <consoleintr+0x23a>
    break;
    80000830:	0001                	nop
    80000832:	a011                	j	80000836 <consoleintr+0x23a>
    break;
    80000834:	0001                	nop
  }
  
  release(&cons.lock);
    80000836:	00012517          	auipc	a0,0x12
    8000083a:	10a50513          	addi	a0,a0,266 # 80012940 <cons>
    8000083e:	361000ef          	jal	8000139e <release>
}
    80000842:	0001                	nop
    80000844:	60e2                	ld	ra,24(sp)
    80000846:	6442                	ld	s0,16(sp)
    80000848:	6105                	addi	sp,sp,32
    8000084a:	8082                	ret

000000008000084c <consoleinit>:

void
consoleinit(void)
{
    8000084c:	1141                	addi	sp,sp,-16
    8000084e:	e406                	sd	ra,8(sp)
    80000850:	e022                	sd	s0,0(sp)
    80000852:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000854:	00009597          	auipc	a1,0x9
    80000858:	7ac58593          	addi	a1,a1,1964 # 8000a000 <etext>
    8000085c:	00012517          	auipc	a0,0x12
    80000860:	0e450513          	addi	a0,a0,228 # 80012940 <cons>
    80000864:	2b3000ef          	jal	80001316 <initlock>

  uartinit();
    80000868:	638000ef          	jal	80000ea0 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000086c:	00022797          	auipc	a5,0x22
    80000870:	25478793          	addi	a5,a5,596 # 80022ac0 <devsw>
    80000874:	00000717          	auipc	a4,0x0
    80000878:	c0870713          	addi	a4,a4,-1016 # 8000047c <consoleread>
    8000087c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000087e:	00022797          	auipc	a5,0x22
    80000882:	24278793          	addi	a5,a5,578 # 80022ac0 <devsw>
    80000886:	00000717          	auipc	a4,0x0
    8000088a:	b3470713          	addi	a4,a4,-1228 # 800003ba <consolewrite>
    8000088e:	ef98                	sd	a4,24(a5)
}
    80000890:	0001                	nop
    80000892:	60a2                	ld	ra,8(sp)
    80000894:	6402                	ld	s0,0(sp)
    80000896:	0141                	addi	sp,sp,16
    80000898:	8082                	ret

000000008000089a <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    8000089a:	715d                	addi	sp,sp,-80
    8000089c:	e486                	sd	ra,72(sp)
    8000089e:	e0a2                	sd	s0,64(sp)
    800008a0:	0880                	addi	s0,sp,80
    800008a2:	faa43c23          	sd	a0,-72(s0)
    800008a6:	87ae                	mv	a5,a1
    800008a8:	8732                	mv	a4,a2
    800008aa:	faf42a23          	sw	a5,-76(s0)
    800008ae:	87ba                	mv	a5,a4
    800008b0:	faf42823          	sw	a5,-80(s0)
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    800008b4:	fb042783          	lw	a5,-80(s0)
    800008b8:	2781                	sext.w	a5,a5
    800008ba:	c39d                	beqz	a5,800008e0 <printint+0x46>
    800008bc:	fb843783          	ld	a5,-72(s0)
    800008c0:	93fd                	srli	a5,a5,0x3f
    800008c2:	0ff7f793          	zext.b	a5,a5
    800008c6:	faf42823          	sw	a5,-80(s0)
    800008ca:	fb042783          	lw	a5,-80(s0)
    800008ce:	2781                	sext.w	a5,a5
    800008d0:	cb81                	beqz	a5,800008e0 <printint+0x46>
    x = -xx;
    800008d2:	fb843783          	ld	a5,-72(s0)
    800008d6:	40f007b3          	neg	a5,a5
    800008da:	fef43023          	sd	a5,-32(s0)
    800008de:	a029                	j	800008e8 <printint+0x4e>
  else
    x = xx;
    800008e0:	fb843783          	ld	a5,-72(s0)
    800008e4:	fef43023          	sd	a5,-32(s0)

  i = 0;
    800008e8:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    800008ec:	fb442783          	lw	a5,-76(s0)
    800008f0:	fe043703          	ld	a4,-32(s0)
    800008f4:	02f77733          	remu	a4,a4,a5
    800008f8:	fec42783          	lw	a5,-20(s0)
    800008fc:	0017869b          	addiw	a3,a5,1
    80000900:	fed42623          	sw	a3,-20(s0)
    80000904:	0000a697          	auipc	a3,0xa
    80000908:	edc68693          	addi	a3,a3,-292 # 8000a7e0 <digits>
    8000090c:	9736                	add	a4,a4,a3
    8000090e:	00074703          	lbu	a4,0(a4)
    80000912:	17c1                	addi	a5,a5,-16
    80000914:	97a2                	add	a5,a5,s0
    80000916:	fce78c23          	sb	a4,-40(a5)
  } while((x /= base) != 0);
    8000091a:	fb442783          	lw	a5,-76(s0)
    8000091e:	fe043703          	ld	a4,-32(s0)
    80000922:	02f757b3          	divu	a5,a4,a5
    80000926:	fef43023          	sd	a5,-32(s0)
    8000092a:	fe043783          	ld	a5,-32(s0)
    8000092e:	ffdd                	bnez	a5,800008ec <printint+0x52>

  if(sign)
    80000930:	fb042783          	lw	a5,-80(s0)
    80000934:	2781                	sext.w	a5,a5
    80000936:	cb85                	beqz	a5,80000966 <printint+0xcc>
    buf[i++] = '-';
    80000938:	fec42783          	lw	a5,-20(s0)
    8000093c:	0017871b          	addiw	a4,a5,1
    80000940:	fee42623          	sw	a4,-20(s0)
    80000944:	17c1                	addi	a5,a5,-16
    80000946:	97a2                	add	a5,a5,s0
    80000948:	02d00713          	li	a4,45
    8000094c:	fce78c23          	sb	a4,-40(a5)

  while(--i >= 0)
    80000950:	a819                	j	80000966 <printint+0xcc>
    consputc(buf[i]);
    80000952:	fec42783          	lw	a5,-20(s0)
    80000956:	17c1                	addi	a5,a5,-16
    80000958:	97a2                	add	a5,a5,s0
    8000095a:	fd87c783          	lbu	a5,-40(a5)
    8000095e:	2781                	sext.w	a5,a5
    80000960:	853e                	mv	a0,a5
    80000962:	a11ff0ef          	jal	80000372 <consputc>
  while(--i >= 0)
    80000966:	fec42783          	lw	a5,-20(s0)
    8000096a:	37fd                	addiw	a5,a5,-1
    8000096c:	fef42623          	sw	a5,-20(s0)
    80000970:	fec42783          	lw	a5,-20(s0)
    80000974:	2781                	sext.w	a5,a5
    80000976:	fc07dee3          	bgez	a5,80000952 <printint+0xb8>
}
    8000097a:	0001                	nop
    8000097c:	0001                	nop
    8000097e:	60a6                	ld	ra,72(sp)
    80000980:	6406                	ld	s0,64(sp)
    80000982:	6161                	addi	sp,sp,80
    80000984:	8082                	ret

0000000080000986 <printptr>:

static void
printptr(uint64 x)
{
    80000986:	7179                	addi	sp,sp,-48
    80000988:	f406                	sd	ra,40(sp)
    8000098a:	f022                	sd	s0,32(sp)
    8000098c:	1800                	addi	s0,sp,48
    8000098e:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    80000992:	03000513          	li	a0,48
    80000996:	9ddff0ef          	jal	80000372 <consputc>
  consputc('x');
    8000099a:	07800513          	li	a0,120
    8000099e:	9d5ff0ef          	jal	80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009a2:	fe042623          	sw	zero,-20(s0)
    800009a6:	a80d                	j	800009d8 <printptr+0x52>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009a8:	fd843783          	ld	a5,-40(s0)
    800009ac:	93f1                	srli	a5,a5,0x3c
    800009ae:	0000a717          	auipc	a4,0xa
    800009b2:	e3270713          	addi	a4,a4,-462 # 8000a7e0 <digits>
    800009b6:	97ba                	add	a5,a5,a4
    800009b8:	0007c783          	lbu	a5,0(a5)
    800009bc:	2781                	sext.w	a5,a5
    800009be:	853e                	mv	a0,a5
    800009c0:	9b3ff0ef          	jal	80000372 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009c4:	fec42783          	lw	a5,-20(s0)
    800009c8:	2785                	addiw	a5,a5,1
    800009ca:	fef42623          	sw	a5,-20(s0)
    800009ce:	fd843783          	ld	a5,-40(s0)
    800009d2:	0792                	slli	a5,a5,0x4
    800009d4:	fcf43c23          	sd	a5,-40(s0)
    800009d8:	fec42703          	lw	a4,-20(s0)
    800009dc:	47bd                	li	a5,15
    800009de:	fce7f5e3          	bgeu	a5,a4,800009a8 <printptr+0x22>
}
    800009e2:	0001                	nop
    800009e4:	0001                	nop
    800009e6:	70a2                	ld	ra,40(sp)
    800009e8:	7402                	ld	s0,32(sp)
    800009ea:	6145                	addi	sp,sp,48
    800009ec:	8082                	ret

00000000800009ee <printf>:

// Print to the console.
int
printf(char *fmt, ...)
{
    800009ee:	7175                	addi	sp,sp,-144
    800009f0:	e486                	sd	ra,72(sp)
    800009f2:	e0a2                	sd	s0,64(sp)
    800009f4:	0880                	addi	s0,sp,80
    800009f6:	faa43c23          	sd	a0,-72(s0)
    800009fa:	e40c                	sd	a1,8(s0)
    800009fc:	e810                	sd	a2,16(s0)
    800009fe:	ec14                	sd	a3,24(s0)
    80000a00:	f018                	sd	a4,32(s0)
    80000a02:	f41c                	sd	a5,40(s0)
    80000a04:	03043823          	sd	a6,48(s0)
    80000a08:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    80000a0c:	0000a797          	auipc	a5,0xa
    80000a10:	f1478793          	addi	a5,a5,-236 # 8000a920 <panicking>
    80000a14:	439c                	lw	a5,0(a5)
    80000a16:	2781                	sext.w	a5,a5
    80000a18:	e799                	bnez	a5,80000a26 <printf+0x38>
    acquire(&pr.lock);
    80000a1a:	00012517          	auipc	a0,0x12
    80000a1e:	fce50513          	addi	a0,a0,-50 # 800129e8 <pr>
    80000a22:	129000ef          	jal	8000134a <acquire>

  va_start(ap, fmt);
    80000a26:	04040793          	addi	a5,s0,64
    80000a2a:	faf43823          	sd	a5,-80(s0)
    80000a2e:	fb043783          	ld	a5,-80(s0)
    80000a32:	fc878793          	addi	a5,a5,-56
    80000a36:	fcf43423          	sd	a5,-56(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80000a3a:	fe042623          	sw	zero,-20(s0)
    80000a3e:	ae4d                	j	80000df0 <printf+0x402>
    if(cx != '%'){
    80000a40:	fd442783          	lw	a5,-44(s0)
    80000a44:	0007871b          	sext.w	a4,a5
    80000a48:	02500793          	li	a5,37
    80000a4c:	00f70863          	beq	a4,a5,80000a5c <printf+0x6e>
      consputc(cx);
    80000a50:	fd442783          	lw	a5,-44(s0)
    80000a54:	853e                	mv	a0,a5
    80000a56:	91dff0ef          	jal	80000372 <consputc>
      continue;
    80000a5a:	a671                	j	80000de6 <printf+0x3f8>
    }
    i++;
    80000a5c:	fec42783          	lw	a5,-20(s0)
    80000a60:	2785                	addiw	a5,a5,1
    80000a62:	fef42623          	sw	a5,-20(s0)
    c0 = fmt[i+0] & 0xff;
    80000a66:	fec42783          	lw	a5,-20(s0)
    80000a6a:	fb843703          	ld	a4,-72(s0)
    80000a6e:	97ba                	add	a5,a5,a4
    80000a70:	0007c783          	lbu	a5,0(a5)
    80000a74:	fcf42823          	sw	a5,-48(s0)
    c1 = c2 = 0;
    80000a78:	fe042223          	sw	zero,-28(s0)
    80000a7c:	fe442783          	lw	a5,-28(s0)
    80000a80:	fef42423          	sw	a5,-24(s0)
    if(c0) c1 = fmt[i+1] & 0xff;
    80000a84:	fd042783          	lw	a5,-48(s0)
    80000a88:	2781                	sext.w	a5,a5
    80000a8a:	cb99                	beqz	a5,80000aa0 <printf+0xb2>
    80000a8c:	fec42783          	lw	a5,-20(s0)
    80000a90:	0785                	addi	a5,a5,1
    80000a92:	fb843703          	ld	a4,-72(s0)
    80000a96:	97ba                	add	a5,a5,a4
    80000a98:	0007c783          	lbu	a5,0(a5)
    80000a9c:	fef42423          	sw	a5,-24(s0)
    if(c1) c2 = fmt[i+2] & 0xff;
    80000aa0:	fe842783          	lw	a5,-24(s0)
    80000aa4:	2781                	sext.w	a5,a5
    80000aa6:	cb99                	beqz	a5,80000abc <printf+0xce>
    80000aa8:	fec42783          	lw	a5,-20(s0)
    80000aac:	0789                	addi	a5,a5,2
    80000aae:	fb843703          	ld	a4,-72(s0)
    80000ab2:	97ba                	add	a5,a5,a4
    80000ab4:	0007c783          	lbu	a5,0(a5)
    80000ab8:	fef42223          	sw	a5,-28(s0)
    if(c0 == 'd'){
    80000abc:	fd042783          	lw	a5,-48(s0)
    80000ac0:	0007871b          	sext.w	a4,a5
    80000ac4:	06400793          	li	a5,100
    80000ac8:	00f71f63          	bne	a4,a5,80000ae6 <printf+0xf8>
      printint(va_arg(ap, int), 10, 1);
    80000acc:	fc843783          	ld	a5,-56(s0)
    80000ad0:	00878713          	addi	a4,a5,8
    80000ad4:	fce43423          	sd	a4,-56(s0)
    80000ad8:	439c                	lw	a5,0(a5)
    80000ada:	4605                	li	a2,1
    80000adc:	45a9                	li	a1,10
    80000ade:	853e                	mv	a0,a5
    80000ae0:	dbbff0ef          	jal	8000089a <printint>
    80000ae4:	a609                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'd'){
    80000ae6:	fd042783          	lw	a5,-48(s0)
    80000aea:	0007871b          	sext.w	a4,a5
    80000aee:	06c00793          	li	a5,108
    80000af2:	02f71c63          	bne	a4,a5,80000b2a <printf+0x13c>
    80000af6:	fe842783          	lw	a5,-24(s0)
    80000afa:	0007871b          	sext.w	a4,a5
    80000afe:	06400793          	li	a5,100
    80000b02:	02f71463          	bne	a4,a5,80000b2a <printf+0x13c>
      printint(va_arg(ap, uint64), 10, 1);
    80000b06:	fc843783          	ld	a5,-56(s0)
    80000b0a:	00878713          	addi	a4,a5,8
    80000b0e:	fce43423          	sd	a4,-56(s0)
    80000b12:	639c                	ld	a5,0(a5)
    80000b14:	4605                	li	a2,1
    80000b16:	45a9                	li	a1,10
    80000b18:	853e                	mv	a0,a5
    80000b1a:	d81ff0ef          	jal	8000089a <printint>
      i += 1;
    80000b1e:	fec42783          	lw	a5,-20(s0)
    80000b22:	2785                	addiw	a5,a5,1
    80000b24:	fef42623          	sw	a5,-20(s0)
    80000b28:	ac7d                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    80000b2a:	fd042783          	lw	a5,-48(s0)
    80000b2e:	0007871b          	sext.w	a4,a5
    80000b32:	06c00793          	li	a5,108
    80000b36:	04f71463          	bne	a4,a5,80000b7e <printf+0x190>
    80000b3a:	fe842783          	lw	a5,-24(s0)
    80000b3e:	0007871b          	sext.w	a4,a5
    80000b42:	06c00793          	li	a5,108
    80000b46:	02f71c63          	bne	a4,a5,80000b7e <printf+0x190>
    80000b4a:	fe442783          	lw	a5,-28(s0)
    80000b4e:	0007871b          	sext.w	a4,a5
    80000b52:	06400793          	li	a5,100
    80000b56:	02f71463          	bne	a4,a5,80000b7e <printf+0x190>
      printint(va_arg(ap, uint64), 10, 1);
    80000b5a:	fc843783          	ld	a5,-56(s0)
    80000b5e:	00878713          	addi	a4,a5,8
    80000b62:	fce43423          	sd	a4,-56(s0)
    80000b66:	639c                	ld	a5,0(a5)
    80000b68:	4605                	li	a2,1
    80000b6a:	45a9                	li	a1,10
    80000b6c:	853e                	mv	a0,a5
    80000b6e:	d2dff0ef          	jal	8000089a <printint>
      i += 2;
    80000b72:	fec42783          	lw	a5,-20(s0)
    80000b76:	2789                	addiw	a5,a5,2
    80000b78:	fef42623          	sw	a5,-20(s0)
    80000b7c:	a4ad                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'u'){
    80000b7e:	fd042783          	lw	a5,-48(s0)
    80000b82:	0007871b          	sext.w	a4,a5
    80000b86:	07500793          	li	a5,117
    80000b8a:	02f71163          	bne	a4,a5,80000bac <printf+0x1be>
      printint(va_arg(ap, uint32), 10, 0);
    80000b8e:	fc843783          	ld	a5,-56(s0)
    80000b92:	00878713          	addi	a4,a5,8
    80000b96:	fce43423          	sd	a4,-56(s0)
    80000b9a:	439c                	lw	a5,0(a5)
    80000b9c:	1782                	slli	a5,a5,0x20
    80000b9e:	9381                	srli	a5,a5,0x20
    80000ba0:	4601                	li	a2,0
    80000ba2:	45a9                	li	a1,10
    80000ba4:	853e                	mv	a0,a5
    80000ba6:	cf5ff0ef          	jal	8000089a <printint>
    80000baa:	ac35                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'u'){
    80000bac:	fd042783          	lw	a5,-48(s0)
    80000bb0:	0007871b          	sext.w	a4,a5
    80000bb4:	06c00793          	li	a5,108
    80000bb8:	02f71c63          	bne	a4,a5,80000bf0 <printf+0x202>
    80000bbc:	fe842783          	lw	a5,-24(s0)
    80000bc0:	0007871b          	sext.w	a4,a5
    80000bc4:	07500793          	li	a5,117
    80000bc8:	02f71463          	bne	a4,a5,80000bf0 <printf+0x202>
      printint(va_arg(ap, uint64), 10, 0);
    80000bcc:	fc843783          	ld	a5,-56(s0)
    80000bd0:	00878713          	addi	a4,a5,8
    80000bd4:	fce43423          	sd	a4,-56(s0)
    80000bd8:	639c                	ld	a5,0(a5)
    80000bda:	4601                	li	a2,0
    80000bdc:	45a9                	li	a1,10
    80000bde:	853e                	mv	a0,a5
    80000be0:	cbbff0ef          	jal	8000089a <printint>
      i += 1;
    80000be4:	fec42783          	lw	a5,-20(s0)
    80000be8:	2785                	addiw	a5,a5,1
    80000bea:	fef42623          	sw	a5,-20(s0)
    80000bee:	aae5                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    80000bf0:	fd042783          	lw	a5,-48(s0)
    80000bf4:	0007871b          	sext.w	a4,a5
    80000bf8:	06c00793          	li	a5,108
    80000bfc:	04f71463          	bne	a4,a5,80000c44 <printf+0x256>
    80000c00:	fe842783          	lw	a5,-24(s0)
    80000c04:	0007871b          	sext.w	a4,a5
    80000c08:	06c00793          	li	a5,108
    80000c0c:	02f71c63          	bne	a4,a5,80000c44 <printf+0x256>
    80000c10:	fe442783          	lw	a5,-28(s0)
    80000c14:	0007871b          	sext.w	a4,a5
    80000c18:	07500793          	li	a5,117
    80000c1c:	02f71463          	bne	a4,a5,80000c44 <printf+0x256>
      printint(va_arg(ap, uint64), 10, 0);
    80000c20:	fc843783          	ld	a5,-56(s0)
    80000c24:	00878713          	addi	a4,a5,8
    80000c28:	fce43423          	sd	a4,-56(s0)
    80000c2c:	639c                	ld	a5,0(a5)
    80000c2e:	4601                	li	a2,0
    80000c30:	45a9                	li	a1,10
    80000c32:	853e                	mv	a0,a5
    80000c34:	c67ff0ef          	jal	8000089a <printint>
      i += 2;
    80000c38:	fec42783          	lw	a5,-20(s0)
    80000c3c:	2789                	addiw	a5,a5,2
    80000c3e:	fef42623          	sw	a5,-20(s0)
    80000c42:	a255                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'x'){
    80000c44:	fd042783          	lw	a5,-48(s0)
    80000c48:	0007871b          	sext.w	a4,a5
    80000c4c:	07800793          	li	a5,120
    80000c50:	02f71163          	bne	a4,a5,80000c72 <printf+0x284>
      printint(va_arg(ap, uint32), 16, 0);
    80000c54:	fc843783          	ld	a5,-56(s0)
    80000c58:	00878713          	addi	a4,a5,8
    80000c5c:	fce43423          	sd	a4,-56(s0)
    80000c60:	439c                	lw	a5,0(a5)
    80000c62:	1782                	slli	a5,a5,0x20
    80000c64:	9381                	srli	a5,a5,0x20
    80000c66:	4601                	li	a2,0
    80000c68:	45c1                	li	a1,16
    80000c6a:	853e                	mv	a0,a5
    80000c6c:	c2fff0ef          	jal	8000089a <printint>
    80000c70:	aa9d                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'x'){
    80000c72:	fd042783          	lw	a5,-48(s0)
    80000c76:	0007871b          	sext.w	a4,a5
    80000c7a:	06c00793          	li	a5,108
    80000c7e:	02f71c63          	bne	a4,a5,80000cb6 <printf+0x2c8>
    80000c82:	fe842783          	lw	a5,-24(s0)
    80000c86:	0007871b          	sext.w	a4,a5
    80000c8a:	07800793          	li	a5,120
    80000c8e:	02f71463          	bne	a4,a5,80000cb6 <printf+0x2c8>
      printint(va_arg(ap, uint64), 16, 0);
    80000c92:	fc843783          	ld	a5,-56(s0)
    80000c96:	00878713          	addi	a4,a5,8
    80000c9a:	fce43423          	sd	a4,-56(s0)
    80000c9e:	639c                	ld	a5,0(a5)
    80000ca0:	4601                	li	a2,0
    80000ca2:	45c1                	li	a1,16
    80000ca4:	853e                	mv	a0,a5
    80000ca6:	bf5ff0ef          	jal	8000089a <printint>
      i += 1;
    80000caa:	fec42783          	lw	a5,-20(s0)
    80000cae:	2785                	addiw	a5,a5,1
    80000cb0:	fef42623          	sw	a5,-20(s0)
    80000cb4:	aa0d                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    80000cb6:	fd042783          	lw	a5,-48(s0)
    80000cba:	0007871b          	sext.w	a4,a5
    80000cbe:	06c00793          	li	a5,108
    80000cc2:	04f71463          	bne	a4,a5,80000d0a <printf+0x31c>
    80000cc6:	fe842783          	lw	a5,-24(s0)
    80000cca:	0007871b          	sext.w	a4,a5
    80000cce:	06c00793          	li	a5,108
    80000cd2:	02f71c63          	bne	a4,a5,80000d0a <printf+0x31c>
    80000cd6:	fe442783          	lw	a5,-28(s0)
    80000cda:	0007871b          	sext.w	a4,a5
    80000cde:	07800793          	li	a5,120
    80000ce2:	02f71463          	bne	a4,a5,80000d0a <printf+0x31c>
      printint(va_arg(ap, uint64), 16, 0);
    80000ce6:	fc843783          	ld	a5,-56(s0)
    80000cea:	00878713          	addi	a4,a5,8
    80000cee:	fce43423          	sd	a4,-56(s0)
    80000cf2:	639c                	ld	a5,0(a5)
    80000cf4:	4601                	li	a2,0
    80000cf6:	45c1                	li	a1,16
    80000cf8:	853e                	mv	a0,a5
    80000cfa:	ba1ff0ef          	jal	8000089a <printint>
      i += 2;
    80000cfe:	fec42783          	lw	a5,-20(s0)
    80000d02:	2789                	addiw	a5,a5,2
    80000d04:	fef42623          	sw	a5,-20(s0)
    80000d08:	a8f9                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'p'){
    80000d0a:	fd042783          	lw	a5,-48(s0)
    80000d0e:	0007871b          	sext.w	a4,a5
    80000d12:	07000793          	li	a5,112
    80000d16:	00f71d63          	bne	a4,a5,80000d30 <printf+0x342>
      printptr(va_arg(ap, uint64));
    80000d1a:	fc843783          	ld	a5,-56(s0)
    80000d1e:	00878713          	addi	a4,a5,8
    80000d22:	fce43423          	sd	a4,-56(s0)
    80000d26:	639c                	ld	a5,0(a5)
    80000d28:	853e                	mv	a0,a5
    80000d2a:	c5dff0ef          	jal	80000986 <printptr>
    80000d2e:	a865                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 'c'){
    80000d30:	fd042783          	lw	a5,-48(s0)
    80000d34:	0007871b          	sext.w	a4,a5
    80000d38:	06300793          	li	a5,99
    80000d3c:	00f71d63          	bne	a4,a5,80000d56 <printf+0x368>
      consputc(va_arg(ap, uint));
    80000d40:	fc843783          	ld	a5,-56(s0)
    80000d44:	00878713          	addi	a4,a5,8
    80000d48:	fce43423          	sd	a4,-56(s0)
    80000d4c:	439c                	lw	a5,0(a5)
    80000d4e:	853e                	mv	a0,a5
    80000d50:	e22ff0ef          	jal	80000372 <consputc>
    80000d54:	a849                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 's'){
    80000d56:	fd042783          	lw	a5,-48(s0)
    80000d5a:	0007871b          	sext.w	a4,a5
    80000d5e:	07300793          	li	a5,115
    80000d62:	04f71863          	bne	a4,a5,80000db2 <printf+0x3c4>
      if((s = va_arg(ap, char*)) == 0)
    80000d66:	fc843783          	ld	a5,-56(s0)
    80000d6a:	00878713          	addi	a4,a5,8
    80000d6e:	fce43423          	sd	a4,-56(s0)
    80000d72:	639c                	ld	a5,0(a5)
    80000d74:	fcf43c23          	sd	a5,-40(s0)
    80000d78:	fd843783          	ld	a5,-40(s0)
    80000d7c:	e78d                	bnez	a5,80000da6 <printf+0x3b8>
        s = "(null)";
    80000d7e:	00009797          	auipc	a5,0x9
    80000d82:	28a78793          	addi	a5,a5,650 # 8000a008 <etext+0x8>
    80000d86:	fcf43c23          	sd	a5,-40(s0)
      for(; *s; s++)
    80000d8a:	a831                	j	80000da6 <printf+0x3b8>
        consputc(*s);
    80000d8c:	fd843783          	ld	a5,-40(s0)
    80000d90:	0007c783          	lbu	a5,0(a5)
    80000d94:	2781                	sext.w	a5,a5
    80000d96:	853e                	mv	a0,a5
    80000d98:	ddaff0ef          	jal	80000372 <consputc>
      for(; *s; s++)
    80000d9c:	fd843783          	ld	a5,-40(s0)
    80000da0:	0785                	addi	a5,a5,1
    80000da2:	fcf43c23          	sd	a5,-40(s0)
    80000da6:	fd843783          	ld	a5,-40(s0)
    80000daa:	0007c783          	lbu	a5,0(a5)
    80000dae:	fff9                	bnez	a5,80000d8c <printf+0x39e>
    80000db0:	a81d                	j	80000de6 <printf+0x3f8>
    } else if(c0 == '%'){
    80000db2:	fd042783          	lw	a5,-48(s0)
    80000db6:	0007871b          	sext.w	a4,a5
    80000dba:	02500793          	li	a5,37
    80000dbe:	00f71763          	bne	a4,a5,80000dcc <printf+0x3de>
      consputc('%');
    80000dc2:	02500513          	li	a0,37
    80000dc6:	dacff0ef          	jal	80000372 <consputc>
    80000dca:	a831                	j	80000de6 <printf+0x3f8>
    } else if(c0 == 0){
    80000dcc:	fd042783          	lw	a5,-48(s0)
    80000dd0:	2781                	sext.w	a5,a5
    80000dd2:	cf95                	beqz	a5,80000e0e <printf+0x420>
      break;
    } else {
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000dd4:	02500513          	li	a0,37
    80000dd8:	d9aff0ef          	jal	80000372 <consputc>
      consputc(c0);
    80000ddc:	fd042783          	lw	a5,-48(s0)
    80000de0:	853e                	mv	a0,a5
    80000de2:	d90ff0ef          	jal	80000372 <consputc>
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80000de6:	fec42783          	lw	a5,-20(s0)
    80000dea:	2785                	addiw	a5,a5,1
    80000dec:	fef42623          	sw	a5,-20(s0)
    80000df0:	fec42783          	lw	a5,-20(s0)
    80000df4:	fb843703          	ld	a4,-72(s0)
    80000df8:	97ba                	add	a5,a5,a4
    80000dfa:	0007c783          	lbu	a5,0(a5)
    80000dfe:	fcf42a23          	sw	a5,-44(s0)
    80000e02:	fd442783          	lw	a5,-44(s0)
    80000e06:	2781                	sext.w	a5,a5
    80000e08:	c2079ce3          	bnez	a5,80000a40 <printf+0x52>
    80000e0c:	a011                	j	80000e10 <printf+0x422>
      break;
    80000e0e:	0001                	nop
    }

  }
  va_end(ap);

  if(panicking == 0)
    80000e10:	0000a797          	auipc	a5,0xa
    80000e14:	b1078793          	addi	a5,a5,-1264 # 8000a920 <panicking>
    80000e18:	439c                	lw	a5,0(a5)
    80000e1a:	2781                	sext.w	a5,a5
    80000e1c:	e799                	bnez	a5,80000e2a <printf+0x43c>
    release(&pr.lock);
    80000e1e:	00012517          	auipc	a0,0x12
    80000e22:	bca50513          	addi	a0,a0,-1078 # 800129e8 <pr>
    80000e26:	578000ef          	jal	8000139e <release>

  return 0;
    80000e2a:	4781                	li	a5,0
}
    80000e2c:	853e                	mv	a0,a5
    80000e2e:	60a6                	ld	ra,72(sp)
    80000e30:	6406                	ld	s0,64(sp)
    80000e32:	6149                	addi	sp,sp,144
    80000e34:	8082                	ret

0000000080000e36 <panic>:

void
panic(char *s)
{
    80000e36:	1101                	addi	sp,sp,-32
    80000e38:	ec06                	sd	ra,24(sp)
    80000e3a:	e822                	sd	s0,16(sp)
    80000e3c:	1000                	addi	s0,sp,32
    80000e3e:	fea43423          	sd	a0,-24(s0)
  panicking = 1;
    80000e42:	0000a797          	auipc	a5,0xa
    80000e46:	ade78793          	addi	a5,a5,-1314 # 8000a920 <panicking>
    80000e4a:	4705                	li	a4,1
    80000e4c:	c398                	sw	a4,0(a5)
  printf("panic: ");
    80000e4e:	00009517          	auipc	a0,0x9
    80000e52:	1c250513          	addi	a0,a0,450 # 8000a010 <etext+0x10>
    80000e56:	b99ff0ef          	jal	800009ee <printf>
  printf("%s\n", s);
    80000e5a:	fe843583          	ld	a1,-24(s0)
    80000e5e:	00009517          	auipc	a0,0x9
    80000e62:	1ba50513          	addi	a0,a0,442 # 8000a018 <etext+0x18>
    80000e66:	b89ff0ef          	jal	800009ee <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000e6a:	0000a797          	auipc	a5,0xa
    80000e6e:	aba78793          	addi	a5,a5,-1350 # 8000a924 <panicked>
    80000e72:	4705                	li	a4,1
    80000e74:	c398                	sw	a4,0(a5)
  for(;;)
    80000e76:	0001                	nop
    80000e78:	bffd                	j	80000e76 <panic+0x40>

0000000080000e7a <printfinit>:
    ;
}

void
printfinit(void)
{
    80000e7a:	1141                	addi	sp,sp,-16
    80000e7c:	e406                	sd	ra,8(sp)
    80000e7e:	e022                	sd	s0,0(sp)
    80000e80:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000e82:	00009597          	auipc	a1,0x9
    80000e86:	19e58593          	addi	a1,a1,414 # 8000a020 <etext+0x20>
    80000e8a:	00012517          	auipc	a0,0x12
    80000e8e:	b5e50513          	addi	a0,a0,-1186 # 800129e8 <pr>
    80000e92:	484000ef          	jal	80001316 <initlock>
}
    80000e96:	0001                	nop
    80000e98:	60a2                	ld	ra,8(sp)
    80000e9a:	6402                	ld	s0,0(sp)
    80000e9c:	0141                	addi	sp,sp,16
    80000e9e:	8082                	ret

0000000080000ea0 <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    80000ea0:	1141                	addi	sp,sp,-16
    80000ea2:	e406                	sd	ra,8(sp)
    80000ea4:	e022                	sd	s0,0(sp)
    80000ea6:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000ea8:	100007b7          	lui	a5,0x10000
    80000eac:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000eae:	00078023          	sb	zero,0(a5)

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000eb2:	100007b7          	lui	a5,0x10000
    80000eb6:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80000eb8:	f8000713          	li	a4,-128
    80000ebc:	00e78023          	sb	a4,0(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000ec0:	100007b7          	lui	a5,0x10000
    80000ec4:	470d                	li	a4,3
    80000ec6:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000eca:	100007b7          	lui	a5,0x10000
    80000ece:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000ed0:	00078023          	sb	zero,0(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000ed4:	100007b7          	lui	a5,0x10000
    80000ed8:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80000eda:	470d                	li	a4,3
    80000edc:	00e78023          	sb	a4,0(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000ee0:	100007b7          	lui	a5,0x10000
    80000ee4:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    80000ee6:	471d                	li	a4,7
    80000ee8:	00e78023          	sb	a4,0(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000eec:	100007b7          	lui	a5,0x10000
    80000ef0:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80000ef2:	470d                	li	a4,3
    80000ef4:	00e78023          	sb	a4,0(a5)

  initlock(&tx_lock, "uart");
    80000ef8:	00009597          	auipc	a1,0x9
    80000efc:	13058593          	addi	a1,a1,304 # 8000a028 <etext+0x28>
    80000f00:	00012517          	auipc	a0,0x12
    80000f04:	b0050513          	addi	a0,a0,-1280 # 80012a00 <tx_lock>
    80000f08:	40e000ef          	jal	80001316 <initlock>
}
    80000f0c:	0001                	nop
    80000f0e:	60a2                	ld	ra,8(sp)
    80000f10:	6402                	ld	s0,0(sp)
    80000f12:	0141                	addi	sp,sp,16
    80000f14:	8082                	ret

0000000080000f16 <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    80000f16:	7179                	addi	sp,sp,-48
    80000f18:	f406                	sd	ra,40(sp)
    80000f1a:	f022                	sd	s0,32(sp)
    80000f1c:	1800                	addi	s0,sp,48
    80000f1e:	fca43c23          	sd	a0,-40(s0)
    80000f22:	87ae                	mv	a5,a1
    80000f24:	fcf42a23          	sw	a5,-44(s0)
  acquire(&tx_lock);
    80000f28:	00012517          	auipc	a0,0x12
    80000f2c:	ad850513          	addi	a0,a0,-1320 # 80012a00 <tx_lock>
    80000f30:	41a000ef          	jal	8000134a <acquire>

  int i = 0;
    80000f34:	fe042623          	sw	zero,-20(s0)
  while(i < n){ 
    80000f38:	a0b9                	j	80000f86 <uartwrite+0x70>
    while(tx_busy != 0){
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    80000f3a:	00012597          	auipc	a1,0x12
    80000f3e:	ac658593          	addi	a1,a1,-1338 # 80012a00 <tx_lock>
    80000f42:	00012517          	auipc	a0,0x12
    80000f46:	ada50513          	addi	a0,a0,-1318 # 80012a1c <tx_chan>
    80000f4a:	3ac020ef          	jal	800032f6 <sleep>
    while(tx_busy != 0){
    80000f4e:	00012797          	auipc	a5,0x12
    80000f52:	aca78793          	addi	a5,a5,-1334 # 80012a18 <tx_busy>
    80000f56:	439c                	lw	a5,0(a5)
    80000f58:	f3ed                	bnez	a5,80000f3a <uartwrite+0x24>
    }   
      
    WriteReg(THR, buf[i]);
    80000f5a:	fec42783          	lw	a5,-20(s0)
    80000f5e:	fd843703          	ld	a4,-40(s0)
    80000f62:	973e                	add	a4,a4,a5
    80000f64:	100007b7          	lui	a5,0x10000
    80000f68:	00074703          	lbu	a4,0(a4)
    80000f6c:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
    i += 1;
    80000f70:	fec42783          	lw	a5,-20(s0)
    80000f74:	2785                	addiw	a5,a5,1
    80000f76:	fef42623          	sw	a5,-20(s0)
    tx_busy = 1;
    80000f7a:	00012797          	auipc	a5,0x12
    80000f7e:	a9e78793          	addi	a5,a5,-1378 # 80012a18 <tx_busy>
    80000f82:	4705                	li	a4,1
    80000f84:	c398                	sw	a4,0(a5)
  while(i < n){ 
    80000f86:	fec42783          	lw	a5,-20(s0)
    80000f8a:	873e                	mv	a4,a5
    80000f8c:	fd442783          	lw	a5,-44(s0)
    80000f90:	2701                	sext.w	a4,a4
    80000f92:	2781                	sext.w	a5,a5
    80000f94:	faf74de3          	blt	a4,a5,80000f4e <uartwrite+0x38>
  }

  release(&tx_lock);
    80000f98:	00012517          	auipc	a0,0x12
    80000f9c:	a6850513          	addi	a0,a0,-1432 # 80012a00 <tx_lock>
    80000fa0:	3fe000ef          	jal	8000139e <release>
}
    80000fa4:	0001                	nop
    80000fa6:	70a2                	ld	ra,40(sp)
    80000fa8:	7402                	ld	s0,32(sp)
    80000faa:	6145                	addi	sp,sp,48
    80000fac:	8082                	ret

0000000080000fae <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000fae:	1101                	addi	sp,sp,-32
    80000fb0:	ec06                	sd	ra,24(sp)
    80000fb2:	e822                	sd	s0,16(sp)
    80000fb4:	1000                	addi	s0,sp,32
    80000fb6:	87aa                	mv	a5,a0
    80000fb8:	fef42623          	sw	a5,-20(s0)
  if(panicking == 0)
    80000fbc:	0000a797          	auipc	a5,0xa
    80000fc0:	96478793          	addi	a5,a5,-1692 # 8000a920 <panicking>
    80000fc4:	439c                	lw	a5,0(a5)
    80000fc6:	2781                	sext.w	a5,a5
    80000fc8:	e399                	bnez	a5,80000fce <uartputc_sync+0x20>
    push_off();
    80000fca:	45e000ef          	jal	80001428 <push_off>

  if(panicked){
    80000fce:	0000a797          	auipc	a5,0xa
    80000fd2:	95678793          	addi	a5,a5,-1706 # 8000a924 <panicked>
    80000fd6:	439c                	lw	a5,0(a5)
    80000fd8:	2781                	sext.w	a5,a5
    80000fda:	c399                	beqz	a5,80000fe0 <uartputc_sync+0x32>
    for(;;)
    80000fdc:	0001                	nop
    80000fde:	bffd                	j	80000fdc <uartputc_sync+0x2e>
      ;
  }

  // wait for UART to set Transmit Holding Empty in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000fe0:	0001                	nop
    80000fe2:	100007b7          	lui	a5,0x10000
    80000fe6:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80000fe8:	0007c783          	lbu	a5,0(a5)
    80000fec:	0ff7f793          	zext.b	a5,a5
    80000ff0:	2781                	sext.w	a5,a5
    80000ff2:	0207f793          	andi	a5,a5,32
    80000ff6:	2781                	sext.w	a5,a5
    80000ff8:	d7ed                	beqz	a5,80000fe2 <uartputc_sync+0x34>
    ;
  WriteReg(THR, c);
    80000ffa:	100007b7          	lui	a5,0x10000
    80000ffe:	fec42703          	lw	a4,-20(s0)
    80001002:	0ff77713          	zext.b	a4,a4
    80001006:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    8000100a:	0000a797          	auipc	a5,0xa
    8000100e:	91678793          	addi	a5,a5,-1770 # 8000a920 <panicking>
    80001012:	439c                	lw	a5,0(a5)
    80001014:	2781                	sext.w	a5,a5
    80001016:	e399                	bnez	a5,8000101c <uartputc_sync+0x6e>
    pop_off();
    80001018:	454000ef          	jal	8000146c <pop_off>
}
    8000101c:	0001                	nop
    8000101e:	60e2                	ld	ra,24(sp)
    80001020:	6442                	ld	s0,16(sp)
    80001022:	6105                	addi	sp,sp,32
    80001024:	8082                	ret

0000000080001026 <uartgetc>:

// try to read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80001026:	1141                	addi	sp,sp,-16
    80001028:	e406                	sd	ra,8(sp)
    8000102a:	e022                	sd	s0,0(sp)
    8000102c:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    8000102e:	100007b7          	lui	a5,0x10000
    80001032:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80001034:	0007c783          	lbu	a5,0(a5)
    80001038:	0ff7f793          	zext.b	a5,a5
    8000103c:	2781                	sext.w	a5,a5
    8000103e:	8b85                	andi	a5,a5,1
    80001040:	2781                	sext.w	a5,a5
    80001042:	cb89                	beqz	a5,80001054 <uartgetc+0x2e>
    // input data is ready.
    return ReadReg(RHR);
    80001044:	100007b7          	lui	a5,0x10000
    80001048:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    8000104c:	0ff7f793          	zext.b	a5,a5
    80001050:	2781                	sext.w	a5,a5
    80001052:	a011                	j	80001056 <uartgetc+0x30>
  } else {
    return -1;
    80001054:	57fd                	li	a5,-1
  }
}
    80001056:	853e                	mv	a0,a5
    80001058:	60a2                	ld	ra,8(sp)
    8000105a:	6402                	ld	s0,0(sp)
    8000105c:	0141                	addi	sp,sp,16
    8000105e:	8082                	ret

0000000080001060 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80001060:	1101                	addi	sp,sp,-32
    80001062:	ec06                	sd	ra,24(sp)
    80001064:	e822                	sd	s0,16(sp)
    80001066:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    80001068:	100007b7          	lui	a5,0x10000
    8000106c:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    8000106e:	0007c783          	lbu	a5,0(a5)

  acquire(&tx_lock);
    80001072:	00012517          	auipc	a0,0x12
    80001076:	98e50513          	addi	a0,a0,-1650 # 80012a00 <tx_lock>
    8000107a:	2d0000ef          	jal	8000134a <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    8000107e:	100007b7          	lui	a5,0x10000
    80001082:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80001084:	0007c783          	lbu	a5,0(a5)
    80001088:	0ff7f793          	zext.b	a5,a5
    8000108c:	2781                	sext.w	a5,a5
    8000108e:	0207f793          	andi	a5,a5,32
    80001092:	2781                	sext.w	a5,a5
    80001094:	cf89                	beqz	a5,800010ae <uartintr+0x4e>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    80001096:	00012797          	auipc	a5,0x12
    8000109a:	98278793          	addi	a5,a5,-1662 # 80012a18 <tx_busy>
    8000109e:	0007a023          	sw	zero,0(a5)
    wakeup(&tx_chan);
    800010a2:	00012517          	auipc	a0,0x12
    800010a6:	97a50513          	addi	a0,a0,-1670 # 80012a1c <tx_chan>
    800010aa:	2b0020ef          	jal	8000335a <wakeup>
  }
  release(&tx_lock);
    800010ae:	00012517          	auipc	a0,0x12
    800010b2:	95250513          	addi	a0,a0,-1710 # 80012a00 <tx_lock>
    800010b6:	2e8000ef          	jal	8000139e <release>

  // read and process incoming characters, if any.
  while(1){
    int c = uartgetc();
    800010ba:	f6dff0ef          	jal	80001026 <uartgetc>
    800010be:	87aa                	mv	a5,a0
    800010c0:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    800010c4:	fec42783          	lw	a5,-20(s0)
    800010c8:	0007871b          	sext.w	a4,a5
    800010cc:	57fd                	li	a5,-1
    800010ce:	00f70863          	beq	a4,a5,800010de <uartintr+0x7e>
      break;
    consoleintr(c);
    800010d2:	fec42783          	lw	a5,-20(s0)
    800010d6:	853e                	mv	a0,a5
    800010d8:	d24ff0ef          	jal	800005fc <consoleintr>
  while(1){
    800010dc:	bff9                	j	800010ba <uartintr+0x5a>
      break;
    800010de:	0001                	nop
  }
}
    800010e0:	0001                	nop
    800010e2:	60e2                	ld	ra,24(sp)
    800010e4:	6442                	ld	s0,16(sp)
    800010e6:	6105                	addi	sp,sp,32
    800010e8:	8082                	ret

00000000800010ea <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    800010ea:	1141                	addi	sp,sp,-16
    800010ec:	e406                	sd	ra,8(sp)
    800010ee:	e022                	sd	s0,0(sp)
    800010f0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800010f2:	00009597          	auipc	a1,0x9
    800010f6:	f3e58593          	addi	a1,a1,-194 # 8000a030 <etext+0x30>
    800010fa:	00012517          	auipc	a0,0x12
    800010fe:	92650513          	addi	a0,a0,-1754 # 80012a20 <kmem>
    80001102:	214000ef          	jal	80001316 <initlock>
  freerange(end, (void*)PHYSTOP);
    80001106:	47c5                	li	a5,17
    80001108:	01b79593          	slli	a1,a5,0x1b
    8000110c:	00023517          	auipc	a0,0x23
    80001110:	b4c50513          	addi	a0,a0,-1204 # 80023c58 <end>
    80001114:	00e000ef          	jal	80001122 <freerange>
}
    80001118:	0001                	nop
    8000111a:	60a2                	ld	ra,8(sp)
    8000111c:	6402                	ld	s0,0(sp)
    8000111e:	0141                	addi	sp,sp,16
    80001120:	8082                	ret

0000000080001122 <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    80001122:	7179                	addi	sp,sp,-48
    80001124:	f406                	sd	ra,40(sp)
    80001126:	f022                	sd	s0,32(sp)
    80001128:	1800                	addi	s0,sp,48
    8000112a:	fca43c23          	sd	a0,-40(s0)
    8000112e:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    80001132:	fd843703          	ld	a4,-40(s0)
    80001136:	6785                	lui	a5,0x1
    80001138:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000113a:	973e                	add	a4,a4,a5
    8000113c:	77fd                	lui	a5,0xfffff
    8000113e:	8ff9                	and	a5,a5,a4
    80001140:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001144:	a819                	j	8000115a <freerange+0x38>
    kfree(p);
    80001146:	fe843503          	ld	a0,-24(s0)
    8000114a:	02c000ef          	jal	80001176 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000114e:	fe843703          	ld	a4,-24(s0)
    80001152:	6785                	lui	a5,0x1
    80001154:	97ba                	add	a5,a5,a4
    80001156:	fef43423          	sd	a5,-24(s0)
    8000115a:	fe843703          	ld	a4,-24(s0)
    8000115e:	6785                	lui	a5,0x1
    80001160:	97ba                	add	a5,a5,a4
    80001162:	fd043703          	ld	a4,-48(s0)
    80001166:	fef770e3          	bgeu	a4,a5,80001146 <freerange+0x24>
}
    8000116a:	0001                	nop
    8000116c:	0001                	nop
    8000116e:	70a2                	ld	ra,40(sp)
    80001170:	7402                	ld	s0,32(sp)
    80001172:	6145                	addi	sp,sp,48
    80001174:	8082                	ret

0000000080001176 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001176:	7179                	addi	sp,sp,-48
    80001178:	f406                	sd	ra,40(sp)
    8000117a:	f022                	sd	s0,32(sp)
    8000117c:	1800                	addi	s0,sp,48
    8000117e:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80001182:	fd843703          	ld	a4,-40(s0)
    80001186:	6785                	lui	a5,0x1
    80001188:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000118a:	8ff9                	and	a5,a5,a4
    8000118c:	ef99                	bnez	a5,800011aa <kfree+0x34>
    8000118e:	fd843703          	ld	a4,-40(s0)
    80001192:	00023797          	auipc	a5,0x23
    80001196:	ac678793          	addi	a5,a5,-1338 # 80023c58 <end>
    8000119a:	00f76863          	bltu	a4,a5,800011aa <kfree+0x34>
    8000119e:	fd843703          	ld	a4,-40(s0)
    800011a2:	47c5                	li	a5,17
    800011a4:	07ee                	slli	a5,a5,0x1b
    800011a6:	00f76863          	bltu	a4,a5,800011b6 <kfree+0x40>
    panic("kfree");
    800011aa:	00009517          	auipc	a0,0x9
    800011ae:	e8e50513          	addi	a0,a0,-370 # 8000a038 <etext+0x38>
    800011b2:	c85ff0ef          	jal	80000e36 <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800011b6:	6605                	lui	a2,0x1
    800011b8:	4585                	li	a1,1
    800011ba:	fd843503          	ld	a0,-40(s0)
    800011be:	318000ef          	jal	800014d6 <memset>

  r = (struct run*)pa;
    800011c2:	fd843783          	ld	a5,-40(s0)
    800011c6:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    800011ca:	00012517          	auipc	a0,0x12
    800011ce:	85650513          	addi	a0,a0,-1962 # 80012a20 <kmem>
    800011d2:	178000ef          	jal	8000134a <acquire>
  r->next = kmem.freelist;
    800011d6:	00012797          	auipc	a5,0x12
    800011da:	84a78793          	addi	a5,a5,-1974 # 80012a20 <kmem>
    800011de:	6f98                	ld	a4,24(a5)
    800011e0:	fe843783          	ld	a5,-24(s0)
    800011e4:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800011e6:	00012797          	auipc	a5,0x12
    800011ea:	83a78793          	addi	a5,a5,-1990 # 80012a20 <kmem>
    800011ee:	fe843703          	ld	a4,-24(s0)
    800011f2:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    800011f4:	00012517          	auipc	a0,0x12
    800011f8:	82c50513          	addi	a0,a0,-2004 # 80012a20 <kmem>
    800011fc:	1a2000ef          	jal	8000139e <release>
}
    80001200:	0001                	nop
    80001202:	70a2                	ld	ra,40(sp)
    80001204:	7402                	ld	s0,32(sp)
    80001206:	6145                	addi	sp,sp,48
    80001208:	8082                	ret

000000008000120a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000120a:	1101                	addi	sp,sp,-32
    8000120c:	ec06                	sd	ra,24(sp)
    8000120e:	e822                	sd	s0,16(sp)
    80001210:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80001212:	00012517          	auipc	a0,0x12
    80001216:	80e50513          	addi	a0,a0,-2034 # 80012a20 <kmem>
    8000121a:	130000ef          	jal	8000134a <acquire>
  r = kmem.freelist;
    8000121e:	00012797          	auipc	a5,0x12
    80001222:	80278793          	addi	a5,a5,-2046 # 80012a20 <kmem>
    80001226:	6f9c                	ld	a5,24(a5)
    80001228:	fef43423          	sd	a5,-24(s0)
  if(r)
    8000122c:	fe843783          	ld	a5,-24(s0)
    80001230:	cb89                	beqz	a5,80001242 <kalloc+0x38>
    kmem.freelist = r->next;
    80001232:	fe843783          	ld	a5,-24(s0)
    80001236:	6398                	ld	a4,0(a5)
    80001238:	00011797          	auipc	a5,0x11
    8000123c:	7e878793          	addi	a5,a5,2024 # 80012a20 <kmem>
    80001240:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001242:	00011517          	auipc	a0,0x11
    80001246:	7de50513          	addi	a0,a0,2014 # 80012a20 <kmem>
    8000124a:	154000ef          	jal	8000139e <release>

  if(r)
    8000124e:	fe843783          	ld	a5,-24(s0)
    80001252:	c799                	beqz	a5,80001260 <kalloc+0x56>
    memset((char*)r, 5, PGSIZE); // fill with junk
    80001254:	6605                	lui	a2,0x1
    80001256:	4595                	li	a1,5
    80001258:	fe843503          	ld	a0,-24(s0)
    8000125c:	27a000ef          	jal	800014d6 <memset>
  return (void*)r;
    80001260:	fe843783          	ld	a5,-24(s0)
}
    80001264:	853e                	mv	a0,a5
    80001266:	60e2                	ld	ra,24(sp)
    80001268:	6442                	ld	s0,16(sp)
    8000126a:	6105                	addi	sp,sp,32
    8000126c:	8082                	ret

000000008000126e <r_sstatus>:
{
    8000126e:	1101                	addi	sp,sp,-32
    80001270:	ec06                	sd	ra,24(sp)
    80001272:	e822                	sd	s0,16(sp)
    80001274:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001276:	100027f3          	csrr	a5,sstatus
    8000127a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000127e:	fe843783          	ld	a5,-24(s0)
}
    80001282:	853e                	mv	a0,a5
    80001284:	60e2                	ld	ra,24(sp)
    80001286:	6442                	ld	s0,16(sp)
    80001288:	6105                	addi	sp,sp,32
    8000128a:	8082                	ret

000000008000128c <w_sstatus>:
{
    8000128c:	1101                	addi	sp,sp,-32
    8000128e:	ec06                	sd	ra,24(sp)
    80001290:	e822                	sd	s0,16(sp)
    80001292:	1000                	addi	s0,sp,32
    80001294:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001298:	fe843783          	ld	a5,-24(s0)
    8000129c:	10079073          	csrw	sstatus,a5
}
    800012a0:	0001                	nop
    800012a2:	60e2                	ld	ra,24(sp)
    800012a4:	6442                	ld	s0,16(sp)
    800012a6:	6105                	addi	sp,sp,32
    800012a8:	8082                	ret

00000000800012aa <intr_on>:
{
    800012aa:	1141                	addi	sp,sp,-16
    800012ac:	e406                	sd	ra,8(sp)
    800012ae:	e022                	sd	s0,0(sp)
    800012b0:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800012b2:	fbdff0ef          	jal	8000126e <r_sstatus>
    800012b6:	87aa                	mv	a5,a0
    800012b8:	0027e793          	ori	a5,a5,2
    800012bc:	853e                	mv	a0,a5
    800012be:	fcfff0ef          	jal	8000128c <w_sstatus>
}
    800012c2:	0001                	nop
    800012c4:	60a2                	ld	ra,8(sp)
    800012c6:	6402                	ld	s0,0(sp)
    800012c8:	0141                	addi	sp,sp,16
    800012ca:	8082                	ret

00000000800012cc <intr_off>:
{
    800012cc:	1141                	addi	sp,sp,-16
    800012ce:	e406                	sd	ra,8(sp)
    800012d0:	e022                	sd	s0,0(sp)
    800012d2:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800012d4:	f9bff0ef          	jal	8000126e <r_sstatus>
    800012d8:	87aa                	mv	a5,a0
    800012da:	9bf5                	andi	a5,a5,-3
    800012dc:	853e                	mv	a0,a5
    800012de:	fafff0ef          	jal	8000128c <w_sstatus>
}
    800012e2:	0001                	nop
    800012e4:	60a2                	ld	ra,8(sp)
    800012e6:	6402                	ld	s0,0(sp)
    800012e8:	0141                	addi	sp,sp,16
    800012ea:	8082                	ret

00000000800012ec <intr_get>:
{
    800012ec:	1101                	addi	sp,sp,-32
    800012ee:	ec06                	sd	ra,24(sp)
    800012f0:	e822                	sd	s0,16(sp)
    800012f2:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800012f4:	f7bff0ef          	jal	8000126e <r_sstatus>
    800012f8:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800012fc:	fe843783          	ld	a5,-24(s0)
    80001300:	8b89                	andi	a5,a5,2
    80001302:	00f037b3          	snez	a5,a5
    80001306:	0ff7f793          	zext.b	a5,a5
    8000130a:	2781                	sext.w	a5,a5
}
    8000130c:	853e                	mv	a0,a5
    8000130e:	60e2                	ld	ra,24(sp)
    80001310:	6442                	ld	s0,16(sp)
    80001312:	6105                	addi	sp,sp,32
    80001314:	8082                	ret

0000000080001316 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80001316:	1101                	addi	sp,sp,-32
    80001318:	ec06                	sd	ra,24(sp)
    8000131a:	e822                	sd	s0,16(sp)
    8000131c:	1000                	addi	s0,sp,32
    8000131e:	fea43423          	sd	a0,-24(s0)
    80001322:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    80001326:	fe843783          	ld	a5,-24(s0)
    8000132a:	fe043703          	ld	a4,-32(s0)
    8000132e:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001330:	fe843783          	ld	a5,-24(s0)
    80001334:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    80001338:	fe843783          	ld	a5,-24(s0)
    8000133c:	0007b823          	sd	zero,16(a5)
}
    80001340:	0001                	nop
    80001342:	60e2                	ld	ra,24(sp)
    80001344:	6442                	ld	s0,16(sp)
    80001346:	6105                	addi	sp,sp,32
    80001348:	8082                	ret

000000008000134a <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    8000134a:	1101                	addi	sp,sp,-32
    8000134c:	ec06                	sd	ra,24(sp)
    8000134e:	e822                	sd	s0,16(sp)
    80001350:	1000                	addi	s0,sp,32
    80001352:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    80001356:	0d2000ef          	jal	80001428 <push_off>
  if(holding(lk))
    8000135a:	fe843503          	ld	a0,-24(s0)
    8000135e:	08a000ef          	jal	800013e8 <holding>
    80001362:	87aa                	mv	a5,a0
    80001364:	c799                	beqz	a5,80001372 <acquire+0x28>
    panic("acquire");
    80001366:	00009517          	auipc	a0,0x9
    8000136a:	cda50513          	addi	a0,a0,-806 # 8000a040 <etext+0x40>
    8000136e:	ac9ff0ef          	jal	80000e36 <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80001372:	0001                	nop
    80001374:	fe843783          	ld	a5,-24(s0)
    80001378:	4705                	li	a4,1
    8000137a:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    8000137e:	0007079b          	sext.w	a5,a4
    80001382:	fbed                	bnez	a5,80001374 <acquire+0x2a>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001384:	0330000f          	fence	rw,rw

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    80001388:	496010ef          	jal	8000281e <mycpu>
    8000138c:	872a                	mv	a4,a0
    8000138e:	fe843783          	ld	a5,-24(s0)
    80001392:	eb98                	sd	a4,16(a5)
}
    80001394:	0001                	nop
    80001396:	60e2                	ld	ra,24(sp)
    80001398:	6442                	ld	s0,16(sp)
    8000139a:	6105                	addi	sp,sp,32
    8000139c:	8082                	ret

000000008000139e <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    8000139e:	1101                	addi	sp,sp,-32
    800013a0:	ec06                	sd	ra,24(sp)
    800013a2:	e822                	sd	s0,16(sp)
    800013a4:	1000                	addi	s0,sp,32
    800013a6:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800013aa:	fe843503          	ld	a0,-24(s0)
    800013ae:	03a000ef          	jal	800013e8 <holding>
    800013b2:	87aa                	mv	a5,a0
    800013b4:	e799                	bnez	a5,800013c2 <release+0x24>
    panic("release");
    800013b6:	00009517          	auipc	a0,0x9
    800013ba:	c9250513          	addi	a0,a0,-878 # 8000a048 <etext+0x48>
    800013be:	a79ff0ef          	jal	80000e36 <panic>

  lk->cpu = 0;
    800013c2:	fe843783          	ld	a5,-24(s0)
    800013c6:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800013ca:	0330000f          	fence	rw,rw
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    800013ce:	fe843783          	ld	a5,-24(s0)
    800013d2:	0310000f          	fence	rw,w
    800013d6:	0007a023          	sw	zero,0(a5)

  pop_off();
    800013da:	092000ef          	jal	8000146c <pop_off>
}
    800013de:	0001                	nop
    800013e0:	60e2                	ld	ra,24(sp)
    800013e2:	6442                	ld	s0,16(sp)
    800013e4:	6105                	addi	sp,sp,32
    800013e6:	8082                	ret

00000000800013e8 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    800013e8:	7139                	addi	sp,sp,-64
    800013ea:	fc06                	sd	ra,56(sp)
    800013ec:	f822                	sd	s0,48(sp)
    800013ee:	f426                	sd	s1,40(sp)
    800013f0:	0080                	addi	s0,sp,64
    800013f2:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800013f6:	fc843783          	ld	a5,-56(s0)
    800013fa:	439c                	lw	a5,0(a5)
    800013fc:	cb99                	beqz	a5,80001412 <holding+0x2a>
    800013fe:	fc843783          	ld	a5,-56(s0)
    80001402:	6b84                	ld	s1,16(a5)
    80001404:	41a010ef          	jal	8000281e <mycpu>
    80001408:	87aa                	mv	a5,a0
    8000140a:	00f49463          	bne	s1,a5,80001412 <holding+0x2a>
    8000140e:	4785                	li	a5,1
    80001410:	a011                	j	80001414 <holding+0x2c>
    80001412:	4781                	li	a5,0
    80001414:	fcf42e23          	sw	a5,-36(s0)
  return r;
    80001418:	fdc42783          	lw	a5,-36(s0)
}
    8000141c:	853e                	mv	a0,a5
    8000141e:	70e2                	ld	ra,56(sp)
    80001420:	7442                	ld	s0,48(sp)
    80001422:	74a2                	ld	s1,40(sp)
    80001424:	6121                	addi	sp,sp,64
    80001426:	8082                	ret

0000000080001428 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80001428:	1101                	addi	sp,sp,-32
    8000142a:	ec06                	sd	ra,24(sp)
    8000142c:	e822                	sd	s0,16(sp)
    8000142e:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001430:	ebdff0ef          	jal	800012ec <intr_get>
    80001434:	87aa                	mv	a5,a0
    80001436:	fef42623          	sw	a5,-20(s0)

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();
    8000143a:	e93ff0ef          	jal	800012cc <intr_off>

  if(mycpu()->noff == 0)
    8000143e:	3e0010ef          	jal	8000281e <mycpu>
    80001442:	87aa                	mv	a5,a0
    80001444:	5fbc                	lw	a5,120(a5)
    80001446:	e799                	bnez	a5,80001454 <push_off+0x2c>
    mycpu()->intena = old;
    80001448:	3d6010ef          	jal	8000281e <mycpu>
    8000144c:	872a                	mv	a4,a0
    8000144e:	fec42783          	lw	a5,-20(s0)
    80001452:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    80001454:	3ca010ef          	jal	8000281e <mycpu>
    80001458:	87aa                	mv	a5,a0
    8000145a:	5fb8                	lw	a4,120(a5)
    8000145c:	2705                	addiw	a4,a4,1
    8000145e:	2701                	sext.w	a4,a4
    80001460:	dfb8                	sw	a4,120(a5)
}
    80001462:	0001                	nop
    80001464:	60e2                	ld	ra,24(sp)
    80001466:	6442                	ld	s0,16(sp)
    80001468:	6105                	addi	sp,sp,32
    8000146a:	8082                	ret

000000008000146c <pop_off>:

void
pop_off(void)
{
    8000146c:	1101                	addi	sp,sp,-32
    8000146e:	ec06                	sd	ra,24(sp)
    80001470:	e822                	sd	s0,16(sp)
    80001472:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    80001474:	3aa010ef          	jal	8000281e <mycpu>
    80001478:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    8000147c:	e71ff0ef          	jal	800012ec <intr_get>
    80001480:	87aa                	mv	a5,a0
    80001482:	c799                	beqz	a5,80001490 <pop_off+0x24>
    panic("pop_off - interruptible");
    80001484:	00009517          	auipc	a0,0x9
    80001488:	bcc50513          	addi	a0,a0,-1076 # 8000a050 <etext+0x50>
    8000148c:	9abff0ef          	jal	80000e36 <panic>
  if(c->noff < 1)
    80001490:	fe843783          	ld	a5,-24(s0)
    80001494:	5fbc                	lw	a5,120(a5)
    80001496:	00f04863          	bgtz	a5,800014a6 <pop_off+0x3a>
    panic("pop_off");
    8000149a:	00009517          	auipc	a0,0x9
    8000149e:	bce50513          	addi	a0,a0,-1074 # 8000a068 <etext+0x68>
    800014a2:	995ff0ef          	jal	80000e36 <panic>
  c->noff -= 1;
    800014a6:	fe843783          	ld	a5,-24(s0)
    800014aa:	5fbc                	lw	a5,120(a5)
    800014ac:	37fd                	addiw	a5,a5,-1
    800014ae:	0007871b          	sext.w	a4,a5
    800014b2:	fe843783          	ld	a5,-24(s0)
    800014b6:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    800014b8:	fe843783          	ld	a5,-24(s0)
    800014bc:	5fbc                	lw	a5,120(a5)
    800014be:	e799                	bnez	a5,800014cc <pop_off+0x60>
    800014c0:	fe843783          	ld	a5,-24(s0)
    800014c4:	5ffc                	lw	a5,124(a5)
    800014c6:	c399                	beqz	a5,800014cc <pop_off+0x60>
    intr_on();
    800014c8:	de3ff0ef          	jal	800012aa <intr_on>
}
    800014cc:	0001                	nop
    800014ce:	60e2                	ld	ra,24(sp)
    800014d0:	6442                	ld	s0,16(sp)
    800014d2:	6105                	addi	sp,sp,32
    800014d4:	8082                	ret

00000000800014d6 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    800014d6:	7179                	addi	sp,sp,-48
    800014d8:	f406                	sd	ra,40(sp)
    800014da:	f022                	sd	s0,32(sp)
    800014dc:	1800                	addi	s0,sp,48
    800014de:	fca43c23          	sd	a0,-40(s0)
    800014e2:	87ae                	mv	a5,a1
    800014e4:	8732                	mv	a4,a2
    800014e6:	fcf42a23          	sw	a5,-44(s0)
    800014ea:	87ba                	mv	a5,a4
    800014ec:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    800014f0:	fd843783          	ld	a5,-40(s0)
    800014f4:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    800014f8:	fe042623          	sw	zero,-20(s0)
    800014fc:	a00d                	j	8000151e <memset+0x48>
    cdst[i] = c;
    800014fe:	fec42783          	lw	a5,-20(s0)
    80001502:	fe043703          	ld	a4,-32(s0)
    80001506:	97ba                	add	a5,a5,a4
    80001508:	fd442703          	lw	a4,-44(s0)
    8000150c:	0ff77713          	zext.b	a4,a4
    80001510:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    80001514:	fec42783          	lw	a5,-20(s0)
    80001518:	2785                	addiw	a5,a5,1
    8000151a:	fef42623          	sw	a5,-20(s0)
    8000151e:	fec42783          	lw	a5,-20(s0)
    80001522:	fd042703          	lw	a4,-48(s0)
    80001526:	2701                	sext.w	a4,a4
    80001528:	fce7ebe3          	bltu	a5,a4,800014fe <memset+0x28>
  }
  return dst;
    8000152c:	fd843783          	ld	a5,-40(s0)
}
    80001530:	853e                	mv	a0,a5
    80001532:	70a2                	ld	ra,40(sp)
    80001534:	7402                	ld	s0,32(sp)
    80001536:	6145                	addi	sp,sp,48
    80001538:	8082                	ret

000000008000153a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000153a:	7139                	addi	sp,sp,-64
    8000153c:	fc06                	sd	ra,56(sp)
    8000153e:	f822                	sd	s0,48(sp)
    80001540:	0080                	addi	s0,sp,64
    80001542:	fca43c23          	sd	a0,-40(s0)
    80001546:	fcb43823          	sd	a1,-48(s0)
    8000154a:	87b2                	mv	a5,a2
    8000154c:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    80001550:	fd843783          	ld	a5,-40(s0)
    80001554:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    80001558:	fd043783          	ld	a5,-48(s0)
    8000155c:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80001560:	a0a1                	j	800015a8 <memcmp+0x6e>
    if(*s1 != *s2)
    80001562:	fe843783          	ld	a5,-24(s0)
    80001566:	0007c703          	lbu	a4,0(a5)
    8000156a:	fe043783          	ld	a5,-32(s0)
    8000156e:	0007c783          	lbu	a5,0(a5)
    80001572:	02f70163          	beq	a4,a5,80001594 <memcmp+0x5a>
      return *s1 - *s2;
    80001576:	fe843783          	ld	a5,-24(s0)
    8000157a:	0007c783          	lbu	a5,0(a5)
    8000157e:	0007871b          	sext.w	a4,a5
    80001582:	fe043783          	ld	a5,-32(s0)
    80001586:	0007c783          	lbu	a5,0(a5)
    8000158a:	2781                	sext.w	a5,a5
    8000158c:	40f707bb          	subw	a5,a4,a5
    80001590:	2781                	sext.w	a5,a5
    80001592:	a01d                	j	800015b8 <memcmp+0x7e>
    s1++, s2++;
    80001594:	fe843783          	ld	a5,-24(s0)
    80001598:	0785                	addi	a5,a5,1
    8000159a:	fef43423          	sd	a5,-24(s0)
    8000159e:	fe043783          	ld	a5,-32(s0)
    800015a2:	0785                	addi	a5,a5,1
    800015a4:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800015a8:	fcc42783          	lw	a5,-52(s0)
    800015ac:	fff7871b          	addiw	a4,a5,-1
    800015b0:	fce42623          	sw	a4,-52(s0)
    800015b4:	f7dd                	bnez	a5,80001562 <memcmp+0x28>
  }

  return 0;
    800015b6:	4781                	li	a5,0
}
    800015b8:	853e                	mv	a0,a5
    800015ba:	70e2                	ld	ra,56(sp)
    800015bc:	7442                	ld	s0,48(sp)
    800015be:	6121                	addi	sp,sp,64
    800015c0:	8082                	ret

00000000800015c2 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800015c2:	7139                	addi	sp,sp,-64
    800015c4:	fc06                	sd	ra,56(sp)
    800015c6:	f822                	sd	s0,48(sp)
    800015c8:	0080                	addi	s0,sp,64
    800015ca:	fca43c23          	sd	a0,-40(s0)
    800015ce:	fcb43823          	sd	a1,-48(s0)
    800015d2:	87b2                	mv	a5,a2
    800015d4:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    800015d8:	fcc42783          	lw	a5,-52(s0)
    800015dc:	2781                	sext.w	a5,a5
    800015de:	e781                	bnez	a5,800015e6 <memmove+0x24>
    return dst;
    800015e0:	fd843783          	ld	a5,-40(s0)
    800015e4:	a855                	j	80001698 <memmove+0xd6>
  
  s = src;
    800015e6:	fd043783          	ld	a5,-48(s0)
    800015ea:	fef43423          	sd	a5,-24(s0)
  d = dst;
    800015ee:	fd843783          	ld	a5,-40(s0)
    800015f2:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    800015f6:	fe843703          	ld	a4,-24(s0)
    800015fa:	fe043783          	ld	a5,-32(s0)
    800015fe:	08f77463          	bgeu	a4,a5,80001686 <memmove+0xc4>
    80001602:	fcc46783          	lwu	a5,-52(s0)
    80001606:	fe843703          	ld	a4,-24(s0)
    8000160a:	97ba                	add	a5,a5,a4
    8000160c:	fe043703          	ld	a4,-32(s0)
    80001610:	06f77b63          	bgeu	a4,a5,80001686 <memmove+0xc4>
    s += n;
    80001614:	fcc46783          	lwu	a5,-52(s0)
    80001618:	fe843703          	ld	a4,-24(s0)
    8000161c:	97ba                	add	a5,a5,a4
    8000161e:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001622:	fcc46783          	lwu	a5,-52(s0)
    80001626:	fe043703          	ld	a4,-32(s0)
    8000162a:	97ba                	add	a5,a5,a4
    8000162c:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    80001630:	a01d                	j	80001656 <memmove+0x94>
      *--d = *--s;
    80001632:	fe843783          	ld	a5,-24(s0)
    80001636:	17fd                	addi	a5,a5,-1
    80001638:	fef43423          	sd	a5,-24(s0)
    8000163c:	fe043783          	ld	a5,-32(s0)
    80001640:	17fd                	addi	a5,a5,-1
    80001642:	fef43023          	sd	a5,-32(s0)
    80001646:	fe843783          	ld	a5,-24(s0)
    8000164a:	0007c703          	lbu	a4,0(a5)
    8000164e:	fe043783          	ld	a5,-32(s0)
    80001652:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    80001656:	fcc42783          	lw	a5,-52(s0)
    8000165a:	fff7871b          	addiw	a4,a5,-1
    8000165e:	fce42623          	sw	a4,-52(s0)
    80001662:	fbe1                	bnez	a5,80001632 <memmove+0x70>
  if(s < d && s + n > d){
    80001664:	a805                	j	80001694 <memmove+0xd2>
  } else
    while(n-- > 0)
      *d++ = *s++;
    80001666:	fe843703          	ld	a4,-24(s0)
    8000166a:	00170793          	addi	a5,a4,1
    8000166e:	fef43423          	sd	a5,-24(s0)
    80001672:	fe043783          	ld	a5,-32(s0)
    80001676:	00178693          	addi	a3,a5,1
    8000167a:	fed43023          	sd	a3,-32(s0)
    8000167e:	00074703          	lbu	a4,0(a4)
    80001682:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    80001686:	fcc42783          	lw	a5,-52(s0)
    8000168a:	fff7871b          	addiw	a4,a5,-1
    8000168e:	fce42623          	sw	a4,-52(s0)
    80001692:	fbf1                	bnez	a5,80001666 <memmove+0xa4>

  return dst;
    80001694:	fd843783          	ld	a5,-40(s0)
}
    80001698:	853e                	mv	a0,a5
    8000169a:	70e2                	ld	ra,56(sp)
    8000169c:	7442                	ld	s0,48(sp)
    8000169e:	6121                	addi	sp,sp,64
    800016a0:	8082                	ret

00000000800016a2 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800016a2:	7179                	addi	sp,sp,-48
    800016a4:	f406                	sd	ra,40(sp)
    800016a6:	f022                	sd	s0,32(sp)
    800016a8:	1800                	addi	s0,sp,48
    800016aa:	fea43423          	sd	a0,-24(s0)
    800016ae:	feb43023          	sd	a1,-32(s0)
    800016b2:	87b2                	mv	a5,a2
    800016b4:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    800016b8:	fdc42783          	lw	a5,-36(s0)
    800016bc:	863e                	mv	a2,a5
    800016be:	fe043583          	ld	a1,-32(s0)
    800016c2:	fe843503          	ld	a0,-24(s0)
    800016c6:	efdff0ef          	jal	800015c2 <memmove>
    800016ca:	87aa                	mv	a5,a0
}
    800016cc:	853e                	mv	a0,a5
    800016ce:	70a2                	ld	ra,40(sp)
    800016d0:	7402                	ld	s0,32(sp)
    800016d2:	6145                	addi	sp,sp,48
    800016d4:	8082                	ret

00000000800016d6 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    800016d6:	7179                	addi	sp,sp,-48
    800016d8:	f406                	sd	ra,40(sp)
    800016da:	f022                	sd	s0,32(sp)
    800016dc:	1800                	addi	s0,sp,48
    800016de:	fea43423          	sd	a0,-24(s0)
    800016e2:	feb43023          	sd	a1,-32(s0)
    800016e6:	87b2                	mv	a5,a2
    800016e8:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    800016ec:	a005                	j	8000170c <strncmp+0x36>
    n--, p++, q++;
    800016ee:	fdc42783          	lw	a5,-36(s0)
    800016f2:	37fd                	addiw	a5,a5,-1
    800016f4:	fcf42e23          	sw	a5,-36(s0)
    800016f8:	fe843783          	ld	a5,-24(s0)
    800016fc:	0785                	addi	a5,a5,1
    800016fe:	fef43423          	sd	a5,-24(s0)
    80001702:	fe043783          	ld	a5,-32(s0)
    80001706:	0785                	addi	a5,a5,1
    80001708:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    8000170c:	fdc42783          	lw	a5,-36(s0)
    80001710:	2781                	sext.w	a5,a5
    80001712:	c385                	beqz	a5,80001732 <strncmp+0x5c>
    80001714:	fe843783          	ld	a5,-24(s0)
    80001718:	0007c783          	lbu	a5,0(a5)
    8000171c:	cb99                	beqz	a5,80001732 <strncmp+0x5c>
    8000171e:	fe843783          	ld	a5,-24(s0)
    80001722:	0007c703          	lbu	a4,0(a5)
    80001726:	fe043783          	ld	a5,-32(s0)
    8000172a:	0007c783          	lbu	a5,0(a5)
    8000172e:	fcf700e3          	beq	a4,a5,800016ee <strncmp+0x18>
  if(n == 0)
    80001732:	fdc42783          	lw	a5,-36(s0)
    80001736:	2781                	sext.w	a5,a5
    80001738:	e399                	bnez	a5,8000173e <strncmp+0x68>
    return 0;
    8000173a:	4781                	li	a5,0
    8000173c:	a839                	j	8000175a <strncmp+0x84>
  return (uchar)*p - (uchar)*q;
    8000173e:	fe843783          	ld	a5,-24(s0)
    80001742:	0007c783          	lbu	a5,0(a5)
    80001746:	0007871b          	sext.w	a4,a5
    8000174a:	fe043783          	ld	a5,-32(s0)
    8000174e:	0007c783          	lbu	a5,0(a5)
    80001752:	2781                	sext.w	a5,a5
    80001754:	40f707bb          	subw	a5,a4,a5
    80001758:	2781                	sext.w	a5,a5
}
    8000175a:	853e                	mv	a0,a5
    8000175c:	70a2                	ld	ra,40(sp)
    8000175e:	7402                	ld	s0,32(sp)
    80001760:	6145                	addi	sp,sp,48
    80001762:	8082                	ret

0000000080001764 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80001764:	7139                	addi	sp,sp,-64
    80001766:	fc06                	sd	ra,56(sp)
    80001768:	f822                	sd	s0,48(sp)
    8000176a:	0080                	addi	s0,sp,64
    8000176c:	fca43c23          	sd	a0,-40(s0)
    80001770:	fcb43823          	sd	a1,-48(s0)
    80001774:	87b2                	mv	a5,a2
    80001776:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000177a:	fd843783          	ld	a5,-40(s0)
    8000177e:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    80001782:	0001                	nop
    80001784:	fcc42783          	lw	a5,-52(s0)
    80001788:	fff7871b          	addiw	a4,a5,-1
    8000178c:	fce42623          	sw	a4,-52(s0)
    80001790:	02f05e63          	blez	a5,800017cc <strncpy+0x68>
    80001794:	fd043703          	ld	a4,-48(s0)
    80001798:	00170793          	addi	a5,a4,1
    8000179c:	fcf43823          	sd	a5,-48(s0)
    800017a0:	fd843783          	ld	a5,-40(s0)
    800017a4:	00178693          	addi	a3,a5,1
    800017a8:	fcd43c23          	sd	a3,-40(s0)
    800017ac:	00074703          	lbu	a4,0(a4)
    800017b0:	00e78023          	sb	a4,0(a5)
    800017b4:	0007c783          	lbu	a5,0(a5)
    800017b8:	f7f1                	bnez	a5,80001784 <strncpy+0x20>
    ;
  while(n-- > 0)
    800017ba:	a809                	j	800017cc <strncpy+0x68>
    *s++ = 0;
    800017bc:	fd843783          	ld	a5,-40(s0)
    800017c0:	00178713          	addi	a4,a5,1
    800017c4:	fce43c23          	sd	a4,-40(s0)
    800017c8:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    800017cc:	fcc42783          	lw	a5,-52(s0)
    800017d0:	fff7871b          	addiw	a4,a5,-1
    800017d4:	fce42623          	sw	a4,-52(s0)
    800017d8:	fef042e3          	bgtz	a5,800017bc <strncpy+0x58>
  return os;
    800017dc:	fe843783          	ld	a5,-24(s0)
}
    800017e0:	853e                	mv	a0,a5
    800017e2:	70e2                	ld	ra,56(sp)
    800017e4:	7442                	ld	s0,48(sp)
    800017e6:	6121                	addi	sp,sp,64
    800017e8:	8082                	ret

00000000800017ea <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800017ea:	7139                	addi	sp,sp,-64
    800017ec:	fc06                	sd	ra,56(sp)
    800017ee:	f822                	sd	s0,48(sp)
    800017f0:	0080                	addi	s0,sp,64
    800017f2:	fca43c23          	sd	a0,-40(s0)
    800017f6:	fcb43823          	sd	a1,-48(s0)
    800017fa:	87b2                	mv	a5,a2
    800017fc:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    80001800:	fd843783          	ld	a5,-40(s0)
    80001804:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    80001808:	fcc42783          	lw	a5,-52(s0)
    8000180c:	2781                	sext.w	a5,a5
    8000180e:	00f04563          	bgtz	a5,80001818 <safestrcpy+0x2e>
    return os;
    80001812:	fe843783          	ld	a5,-24(s0)
    80001816:	a0a9                	j	80001860 <safestrcpy+0x76>
  while(--n > 0 && (*s++ = *t++) != 0)
    80001818:	0001                	nop
    8000181a:	fcc42783          	lw	a5,-52(s0)
    8000181e:	37fd                	addiw	a5,a5,-1
    80001820:	fcf42623          	sw	a5,-52(s0)
    80001824:	fcc42783          	lw	a5,-52(s0)
    80001828:	2781                	sext.w	a5,a5
    8000182a:	02f05563          	blez	a5,80001854 <safestrcpy+0x6a>
    8000182e:	fd043703          	ld	a4,-48(s0)
    80001832:	00170793          	addi	a5,a4,1
    80001836:	fcf43823          	sd	a5,-48(s0)
    8000183a:	fd843783          	ld	a5,-40(s0)
    8000183e:	00178693          	addi	a3,a5,1
    80001842:	fcd43c23          	sd	a3,-40(s0)
    80001846:	00074703          	lbu	a4,0(a4)
    8000184a:	00e78023          	sb	a4,0(a5)
    8000184e:	0007c783          	lbu	a5,0(a5)
    80001852:	f7e1                	bnez	a5,8000181a <safestrcpy+0x30>
    ;
  *s = 0;
    80001854:	fd843783          	ld	a5,-40(s0)
    80001858:	00078023          	sb	zero,0(a5)
  return os;
    8000185c:	fe843783          	ld	a5,-24(s0)
}
    80001860:	853e                	mv	a0,a5
    80001862:	70e2                	ld	ra,56(sp)
    80001864:	7442                	ld	s0,48(sp)
    80001866:	6121                	addi	sp,sp,64
    80001868:	8082                	ret

000000008000186a <strlen>:

int
strlen(const char *s)
{
    8000186a:	7179                	addi	sp,sp,-48
    8000186c:	f406                	sd	ra,40(sp)
    8000186e:	f022                	sd	s0,32(sp)
    80001870:	1800                	addi	s0,sp,48
    80001872:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    80001876:	fe042623          	sw	zero,-20(s0)
    8000187a:	a031                	j	80001886 <strlen+0x1c>
    8000187c:	fec42783          	lw	a5,-20(s0)
    80001880:	2785                	addiw	a5,a5,1
    80001882:	fef42623          	sw	a5,-20(s0)
    80001886:	fec42783          	lw	a5,-20(s0)
    8000188a:	fd843703          	ld	a4,-40(s0)
    8000188e:	97ba                	add	a5,a5,a4
    80001890:	0007c783          	lbu	a5,0(a5)
    80001894:	f7e5                	bnez	a5,8000187c <strlen+0x12>
    ;
  return n;
    80001896:	fec42783          	lw	a5,-20(s0)
}
    8000189a:	853e                	mv	a0,a5
    8000189c:	70a2                	ld	ra,40(sp)
    8000189e:	7402                	ld	s0,32(sp)
    800018a0:	6145                	addi	sp,sp,48
    800018a2:	8082                	ret

00000000800018a4 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800018a4:	1141                	addi	sp,sp,-16
    800018a6:	e406                	sd	ra,8(sp)
    800018a8:	e022                	sd	s0,0(sp)
    800018aa:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800018ac:	753000ef          	jal	800027fe <cpuid>
    800018b0:	87aa                	mv	a5,a0
    800018b2:	ebb5                	bnez	a5,80001926 <main+0x82>
    consoleinit();
    800018b4:	f99fe0ef          	jal	8000084c <consoleinit>
    printfinit();
    800018b8:	dc2ff0ef          	jal	80000e7a <printfinit>
    printf("\n");
    800018bc:	00008517          	auipc	a0,0x8
    800018c0:	7b450513          	addi	a0,a0,1972 # 8000a070 <etext+0x70>
    800018c4:	92aff0ef          	jal	800009ee <printf>
    printf("xv6 kernel is booting\n");
    800018c8:	00008517          	auipc	a0,0x8
    800018cc:	7b050513          	addi	a0,a0,1968 # 8000a078 <etext+0x78>
    800018d0:	91eff0ef          	jal	800009ee <printf>
    printf("\n");
    800018d4:	00008517          	auipc	a0,0x8
    800018d8:	79c50513          	addi	a0,a0,1948 # 8000a070 <etext+0x70>
    800018dc:	912ff0ef          	jal	800009ee <printf>
    kinit();         // physical page allocator
    800018e0:	80bff0ef          	jal	800010ea <kinit>
    kvminit();       // create kernel page table
    800018e4:	1e2000ef          	jal	80001ac6 <kvminit>
    kvminithart();   // turn on paging
    800018e8:	200000ef          	jal	80001ae8 <kvminithart>
    procinit();      // process table
    800018ec:	651000ef          	jal	8000273c <procinit>
    trapinit();      // trap vectors
    800018f0:	7af010ef          	jal	8000389e <trapinit>
    trapinithart();  // install kernel trap vector
    800018f4:	7d1010ef          	jal	800038c4 <trapinithart>
    plicinit();      // set up interrupt controller
    800018f8:	0d7060ef          	jal	800081ce <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800018fc:	0fb060ef          	jal	800081f6 <plicinithart>
    binit();         // buffer cache
    80001900:	321020ef          	jal	80004420 <binit>
    iinit();         // inode table
    80001904:	2b4030ef          	jal	80004bb8 <iinit>
    fileinit();      // file table
    80001908:	309040ef          	jal	80006410 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000190c:	1b3060ef          	jal	800082be <virtio_disk_init>
    userinit();      // first user process
    80001910:	25c010ef          	jal	80002b6c <userinit>
    __sync_synchronize();
    80001914:	0330000f          	fence	rw,rw
    started = 1;
    80001918:	00011797          	auipc	a5,0x11
    8000191c:	12878793          	addi	a5,a5,296 # 80012a40 <started>
    80001920:	4705                	li	a4,1
    80001922:	c398                	sw	a4,0(a5)
    80001924:	a81d                	j	8000195a <main+0xb6>
  } else {
    while(started == 0)
    80001926:	0001                	nop
    80001928:	00011797          	auipc	a5,0x11
    8000192c:	11878793          	addi	a5,a5,280 # 80012a40 <started>
    80001930:	439c                	lw	a5,0(a5)
    80001932:	2781                	sext.w	a5,a5
    80001934:	dbf5                	beqz	a5,80001928 <main+0x84>
      ;
    __sync_synchronize();
    80001936:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    8000193a:	6c5000ef          	jal	800027fe <cpuid>
    8000193e:	87aa                	mv	a5,a0
    80001940:	85be                	mv	a1,a5
    80001942:	00008517          	auipc	a0,0x8
    80001946:	74e50513          	addi	a0,a0,1870 # 8000a090 <etext+0x90>
    8000194a:	8a4ff0ef          	jal	800009ee <printf>
    kvminithart();    // turn on paging
    8000194e:	19a000ef          	jal	80001ae8 <kvminithart>
    trapinithart();   // install kernel trap vector
    80001952:	773010ef          	jal	800038c4 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001956:	0a1060ef          	jal	800081f6 <plicinithart>
  }

  scheduler();        
    8000195a:	730010ef          	jal	8000308a <scheduler>

000000008000195e <w_satp>:
{
    8000195e:	1101                	addi	sp,sp,-32
    80001960:	ec06                	sd	ra,24(sp)
    80001962:	e822                	sd	s0,16(sp)
    80001964:	1000                	addi	s0,sp,32
    80001966:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    8000196a:	fe843783          	ld	a5,-24(s0)
    8000196e:	18079073          	csrw	satp,a5
}
    80001972:	0001                	nop
    80001974:	60e2                	ld	ra,24(sp)
    80001976:	6442                	ld	s0,16(sp)
    80001978:	6105                	addi	sp,sp,32
    8000197a:	8082                	ret

000000008000197c <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    8000197c:	1141                	addi	sp,sp,-16
    8000197e:	e406                	sd	ra,8(sp)
    80001980:	e022                	sd	s0,0(sp)
    80001982:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001984:	12000073          	sfence.vma
}
    80001988:	0001                	nop
    8000198a:	60a2                	ld	ra,8(sp)
    8000198c:	6402                	ld	s0,0(sp)
    8000198e:	0141                	addi	sp,sp,16
    80001990:	8082                	ret

0000000080001992 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001992:	1101                	addi	sp,sp,-32
    80001994:	ec06                	sd	ra,24(sp)
    80001996:	e822                	sd	s0,16(sp)
    80001998:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    8000199a:	871ff0ef          	jal	8000120a <kalloc>
    8000199e:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    800019a2:	6605                	lui	a2,0x1
    800019a4:	4581                	li	a1,0
    800019a6:	fe843503          	ld	a0,-24(s0)
    800019aa:	b2dff0ef          	jal	800014d6 <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800019ae:	4719                	li	a4,6
    800019b0:	6685                	lui	a3,0x1
    800019b2:	10000637          	lui	a2,0x10000
    800019b6:	100005b7          	lui	a1,0x10000
    800019ba:	fe843503          	ld	a0,-24(s0)
    800019be:	0b6000ef          	jal	80001a74 <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800019c2:	4719                	li	a4,6
    800019c4:	6685                	lui	a3,0x1
    800019c6:	10001637          	lui	a2,0x10001
    800019ca:	100015b7          	lui	a1,0x10001
    800019ce:	fe843503          	ld	a0,-24(s0)
    800019d2:	0a2000ef          	jal	80001a74 <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800019d6:	4719                	li	a4,6
    800019d8:	040006b7          	lui	a3,0x4000
    800019dc:	0c000637          	lui	a2,0xc000
    800019e0:	0c0005b7          	lui	a1,0xc000
    800019e4:	fe843503          	ld	a0,-24(s0)
    800019e8:	08c000ef          	jal	80001a74 <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800019ec:	00008717          	auipc	a4,0x8
    800019f0:	61470713          	addi	a4,a4,1556 # 8000a000 <etext>
    800019f4:	800007b7          	lui	a5,0x80000
    800019f8:	97ba                	add	a5,a5,a4
    800019fa:	4729                	li	a4,10
    800019fc:	86be                	mv	a3,a5
    800019fe:	4785                	li	a5,1
    80001a00:	01f79613          	slli	a2,a5,0x1f
    80001a04:	4785                	li	a5,1
    80001a06:	01f79593          	slli	a1,a5,0x1f
    80001a0a:	fe843503          	ld	a0,-24(s0)
    80001a0e:	066000ef          	jal	80001a74 <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001a12:	00008597          	auipc	a1,0x8
    80001a16:	5ee58593          	addi	a1,a1,1518 # 8000a000 <etext>
    80001a1a:	00008617          	auipc	a2,0x8
    80001a1e:	5e660613          	addi	a2,a2,1510 # 8000a000 <etext>
    80001a22:	00008797          	auipc	a5,0x8
    80001a26:	5de78793          	addi	a5,a5,1502 # 8000a000 <etext>
    80001a2a:	4745                	li	a4,17
    80001a2c:	076e                	slli	a4,a4,0x1b
    80001a2e:	40f707b3          	sub	a5,a4,a5
    80001a32:	4719                	li	a4,6
    80001a34:	86be                	mv	a3,a5
    80001a36:	fe843503          	ld	a0,-24(s0)
    80001a3a:	03a000ef          	jal	80001a74 <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001a3e:	00007797          	auipc	a5,0x7
    80001a42:	5c278793          	addi	a5,a5,1474 # 80009000 <_trampoline>
    80001a46:	4729                	li	a4,10
    80001a48:	6685                	lui	a3,0x1
    80001a4a:	863e                	mv	a2,a5
    80001a4c:	040007b7          	lui	a5,0x4000
    80001a50:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001a52:	00c79593          	slli	a1,a5,0xc
    80001a56:	fe843503          	ld	a0,-24(s0)
    80001a5a:	01a000ef          	jal	80001a74 <kvmmap>

  // allocate and map a kernel stack for each process.
  proc_mapstacks(kpgtbl);
    80001a5e:	fe843503          	ld	a0,-24(s0)
    80001a62:	42b000ef          	jal	8000268c <proc_mapstacks>
  
  return kpgtbl;
    80001a66:	fe843783          	ld	a5,-24(s0)
}
    80001a6a:	853e                	mv	a0,a5
    80001a6c:	60e2                	ld	ra,24(sp)
    80001a6e:	6442                	ld	s0,16(sp)
    80001a70:	6105                	addi	sp,sp,32
    80001a72:	8082                	ret

0000000080001a74 <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001a74:	7139                	addi	sp,sp,-64
    80001a76:	fc06                	sd	ra,56(sp)
    80001a78:	f822                	sd	s0,48(sp)
    80001a7a:	0080                	addi	s0,sp,64
    80001a7c:	fea43423          	sd	a0,-24(s0)
    80001a80:	feb43023          	sd	a1,-32(s0)
    80001a84:	fcc43c23          	sd	a2,-40(s0)
    80001a88:	fcd43823          	sd	a3,-48(s0)
    80001a8c:	87ba                	mv	a5,a4
    80001a8e:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001a92:	fcc42783          	lw	a5,-52(s0)
    80001a96:	873e                	mv	a4,a5
    80001a98:	fd843683          	ld	a3,-40(s0)
    80001a9c:	fd043603          	ld	a2,-48(s0)
    80001aa0:	fe043583          	ld	a1,-32(s0)
    80001aa4:	fe843503          	ld	a0,-24(s0)
    80001aa8:	1ce000ef          	jal	80001c76 <mappages>
    80001aac:	87aa                	mv	a5,a0
    80001aae:	c799                	beqz	a5,80001abc <kvmmap+0x48>
    panic("kvmmap");
    80001ab0:	00008517          	auipc	a0,0x8
    80001ab4:	5f850513          	addi	a0,a0,1528 # 8000a0a8 <etext+0xa8>
    80001ab8:	b7eff0ef          	jal	80000e36 <panic>
}
    80001abc:	0001                	nop
    80001abe:	70e2                	ld	ra,56(sp)
    80001ac0:	7442                	ld	s0,48(sp)
    80001ac2:	6121                	addi	sp,sp,64
    80001ac4:	8082                	ret

0000000080001ac6 <kvminit>:

// Initialize the kernel_pagetable, shared by all CPUs.
void
kvminit(void)
{
    80001ac6:	1141                	addi	sp,sp,-16
    80001ac8:	e406                	sd	ra,8(sp)
    80001aca:	e022                	sd	s0,0(sp)
    80001acc:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001ace:	ec5ff0ef          	jal	80001992 <kvmmake>
    80001ad2:	872a                	mv	a4,a0
    80001ad4:	00009797          	auipc	a5,0x9
    80001ad8:	e5478793          	addi	a5,a5,-428 # 8000a928 <kernel_pagetable>
    80001adc:	e398                	sd	a4,0(a5)
}
    80001ade:	0001                	nop
    80001ae0:	60a2                	ld	ra,8(sp)
    80001ae2:	6402                	ld	s0,0(sp)
    80001ae4:	0141                	addi	sp,sp,16
    80001ae6:	8082                	ret

0000000080001ae8 <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    80001ae8:	1141                	addi	sp,sp,-16
    80001aea:	e406                	sd	ra,8(sp)
    80001aec:	e022                	sd	s0,0(sp)
    80001aee:	0800                	addi	s0,sp,16
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();
    80001af0:	e8dff0ef          	jal	8000197c <sfence_vma>

  w_satp(MAKE_SATP(kernel_pagetable));
    80001af4:	00009797          	auipc	a5,0x9
    80001af8:	e3478793          	addi	a5,a5,-460 # 8000a928 <kernel_pagetable>
    80001afc:	639c                	ld	a5,0(a5)
    80001afe:	00c7d713          	srli	a4,a5,0xc
    80001b02:	57fd                	li	a5,-1
    80001b04:	17fe                	slli	a5,a5,0x3f
    80001b06:	8fd9                	or	a5,a5,a4
    80001b08:	853e                	mv	a0,a5
    80001b0a:	e55ff0ef          	jal	8000195e <w_satp>

  // flush stale entries from the TLB.
  sfence_vma();
    80001b0e:	e6fff0ef          	jal	8000197c <sfence_vma>
}
    80001b12:	0001                	nop
    80001b14:	60a2                	ld	ra,8(sp)
    80001b16:	6402                	ld	s0,0(sp)
    80001b18:	0141                	addi	sp,sp,16
    80001b1a:	8082                	ret

0000000080001b1c <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001b1c:	7139                	addi	sp,sp,-64
    80001b1e:	fc06                	sd	ra,56(sp)
    80001b20:	f822                	sd	s0,48(sp)
    80001b22:	0080                	addi	s0,sp,64
    80001b24:	fca43c23          	sd	a0,-40(s0)
    80001b28:	fcb43823          	sd	a1,-48(s0)
    80001b2c:	87b2                	mv	a5,a2
    80001b2e:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001b32:	fd043703          	ld	a4,-48(s0)
    80001b36:	57fd                	li	a5,-1
    80001b38:	83e9                	srli	a5,a5,0x1a
    80001b3a:	00e7f863          	bgeu	a5,a4,80001b4a <walk+0x2e>
    panic("walk");
    80001b3e:	00008517          	auipc	a0,0x8
    80001b42:	57250513          	addi	a0,a0,1394 # 8000a0b0 <etext+0xb0>
    80001b46:	af0ff0ef          	jal	80000e36 <panic>

  for(int level = 2; level > 0; level--) {
    80001b4a:	4789                	li	a5,2
    80001b4c:	fef42623          	sw	a5,-20(s0)
    80001b50:	a071                	j	80001bdc <walk+0xc0>
    pte_t *pte = &pagetable[PX(level, va)];
    80001b52:	fec42783          	lw	a5,-20(s0)
    80001b56:	873e                	mv	a4,a5
    80001b58:	87ba                	mv	a5,a4
    80001b5a:	0037979b          	slliw	a5,a5,0x3
    80001b5e:	9fb9                	addw	a5,a5,a4
    80001b60:	2781                	sext.w	a5,a5
    80001b62:	27b1                	addiw	a5,a5,12
    80001b64:	2781                	sext.w	a5,a5
    80001b66:	873e                	mv	a4,a5
    80001b68:	fd043783          	ld	a5,-48(s0)
    80001b6c:	00e7d7b3          	srl	a5,a5,a4
    80001b70:	1ff7f793          	andi	a5,a5,511
    80001b74:	078e                	slli	a5,a5,0x3
    80001b76:	fd843703          	ld	a4,-40(s0)
    80001b7a:	97ba                	add	a5,a5,a4
    80001b7c:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001b80:	fe043783          	ld	a5,-32(s0)
    80001b84:	639c                	ld	a5,0(a5)
    80001b86:	8b85                	andi	a5,a5,1
    80001b88:	cb89                	beqz	a5,80001b9a <walk+0x7e>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001b8a:	fe043783          	ld	a5,-32(s0)
    80001b8e:	639c                	ld	a5,0(a5)
    80001b90:	83a9                	srli	a5,a5,0xa
    80001b92:	07b2                	slli	a5,a5,0xc
    80001b94:	fcf43c23          	sd	a5,-40(s0)
    80001b98:	a82d                	j	80001bd2 <walk+0xb6>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001b9a:	fcc42783          	lw	a5,-52(s0)
    80001b9e:	2781                	sext.w	a5,a5
    80001ba0:	cb81                	beqz	a5,80001bb0 <walk+0x94>
    80001ba2:	e68ff0ef          	jal	8000120a <kalloc>
    80001ba6:	fca43c23          	sd	a0,-40(s0)
    80001baa:	fd843783          	ld	a5,-40(s0)
    80001bae:	e399                	bnez	a5,80001bb4 <walk+0x98>
        return 0;
    80001bb0:	4781                	li	a5,0
    80001bb2:	a099                	j	80001bf8 <walk+0xdc>
      memset(pagetable, 0, PGSIZE);
    80001bb4:	6605                	lui	a2,0x1
    80001bb6:	4581                	li	a1,0
    80001bb8:	fd843503          	ld	a0,-40(s0)
    80001bbc:	91bff0ef          	jal	800014d6 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001bc0:	fd843783          	ld	a5,-40(s0)
    80001bc4:	83b1                	srli	a5,a5,0xc
    80001bc6:	07aa                	slli	a5,a5,0xa
    80001bc8:	0017e713          	ori	a4,a5,1
    80001bcc:	fe043783          	ld	a5,-32(s0)
    80001bd0:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001bd2:	fec42783          	lw	a5,-20(s0)
    80001bd6:	37fd                	addiw	a5,a5,-1
    80001bd8:	fef42623          	sw	a5,-20(s0)
    80001bdc:	fec42783          	lw	a5,-20(s0)
    80001be0:	2781                	sext.w	a5,a5
    80001be2:	f6f048e3          	bgtz	a5,80001b52 <walk+0x36>
    }
  }
  return &pagetable[PX(0, va)];
    80001be6:	fd043783          	ld	a5,-48(s0)
    80001bea:	83b1                	srli	a5,a5,0xc
    80001bec:	1ff7f793          	andi	a5,a5,511
    80001bf0:	078e                	slli	a5,a5,0x3
    80001bf2:	fd843703          	ld	a4,-40(s0)
    80001bf6:	97ba                	add	a5,a5,a4
}
    80001bf8:	853e                	mv	a0,a5
    80001bfa:	70e2                	ld	ra,56(sp)
    80001bfc:	7442                	ld	s0,48(sp)
    80001bfe:	6121                	addi	sp,sp,64
    80001c00:	8082                	ret

0000000080001c02 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001c02:	7179                	addi	sp,sp,-48
    80001c04:	f406                	sd	ra,40(sp)
    80001c06:	f022                	sd	s0,32(sp)
    80001c08:	1800                	addi	s0,sp,48
    80001c0a:	fca43c23          	sd	a0,-40(s0)
    80001c0e:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001c12:	fd043703          	ld	a4,-48(s0)
    80001c16:	57fd                	li	a5,-1
    80001c18:	83e9                	srli	a5,a5,0x1a
    80001c1a:	00e7f463          	bgeu	a5,a4,80001c22 <walkaddr+0x20>
    return 0;
    80001c1e:	4781                	li	a5,0
    80001c20:	a0b1                	j	80001c6c <walkaddr+0x6a>

  pte = walk(pagetable, va, 0);
    80001c22:	4601                	li	a2,0
    80001c24:	fd043583          	ld	a1,-48(s0)
    80001c28:	fd843503          	ld	a0,-40(s0)
    80001c2c:	ef1ff0ef          	jal	80001b1c <walk>
    80001c30:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001c34:	fe843783          	ld	a5,-24(s0)
    80001c38:	e399                	bnez	a5,80001c3e <walkaddr+0x3c>
    return 0;
    80001c3a:	4781                	li	a5,0
    80001c3c:	a805                	j	80001c6c <walkaddr+0x6a>
  if((*pte & PTE_V) == 0)
    80001c3e:	fe843783          	ld	a5,-24(s0)
    80001c42:	639c                	ld	a5,0(a5)
    80001c44:	8b85                	andi	a5,a5,1
    80001c46:	e399                	bnez	a5,80001c4c <walkaddr+0x4a>
    return 0;
    80001c48:	4781                	li	a5,0
    80001c4a:	a00d                	j	80001c6c <walkaddr+0x6a>
  if((*pte & PTE_U) == 0)
    80001c4c:	fe843783          	ld	a5,-24(s0)
    80001c50:	639c                	ld	a5,0(a5)
    80001c52:	8bc1                	andi	a5,a5,16
    80001c54:	e399                	bnez	a5,80001c5a <walkaddr+0x58>
    return 0;
    80001c56:	4781                	li	a5,0
    80001c58:	a811                	j	80001c6c <walkaddr+0x6a>
  pa = PTE2PA(*pte);
    80001c5a:	fe843783          	ld	a5,-24(s0)
    80001c5e:	639c                	ld	a5,0(a5)
    80001c60:	83a9                	srli	a5,a5,0xa
    80001c62:	07b2                	slli	a5,a5,0xc
    80001c64:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001c68:	fe043783          	ld	a5,-32(s0)
}
    80001c6c:	853e                	mv	a0,a5
    80001c6e:	70a2                	ld	ra,40(sp)
    80001c70:	7402                	ld	s0,32(sp)
    80001c72:	6145                	addi	sp,sp,48
    80001c74:	8082                	ret

0000000080001c76 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001c76:	711d                	addi	sp,sp,-96
    80001c78:	ec86                	sd	ra,88(sp)
    80001c7a:	e8a2                	sd	s0,80(sp)
    80001c7c:	1080                	addi	s0,sp,96
    80001c7e:	fca43423          	sd	a0,-56(s0)
    80001c82:	fcb43023          	sd	a1,-64(s0)
    80001c86:	fac43c23          	sd	a2,-72(s0)
    80001c8a:	fad43823          	sd	a3,-80(s0)
    80001c8e:	87ba                	mv	a5,a4
    80001c90:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001c94:	fc043703          	ld	a4,-64(s0)
    80001c98:	6785                	lui	a5,0x1
    80001c9a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001c9c:	8ff9                	and	a5,a5,a4
    80001c9e:	c799                	beqz	a5,80001cac <mappages+0x36>
    panic("mappages: va not aligned");
    80001ca0:	00008517          	auipc	a0,0x8
    80001ca4:	41850513          	addi	a0,a0,1048 # 8000a0b8 <etext+0xb8>
    80001ca8:	98eff0ef          	jal	80000e36 <panic>

  if((size % PGSIZE) != 0)
    80001cac:	fb843703          	ld	a4,-72(s0)
    80001cb0:	6785                	lui	a5,0x1
    80001cb2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001cb4:	8ff9                	and	a5,a5,a4
    80001cb6:	c799                	beqz	a5,80001cc4 <mappages+0x4e>
    panic("mappages: size not aligned");
    80001cb8:	00008517          	auipc	a0,0x8
    80001cbc:	42050513          	addi	a0,a0,1056 # 8000a0d8 <etext+0xd8>
    80001cc0:	976ff0ef          	jal	80000e36 <panic>

  if(size == 0)
    80001cc4:	fb843783          	ld	a5,-72(s0)
    80001cc8:	e799                	bnez	a5,80001cd6 <mappages+0x60>
    panic("mappages: size");
    80001cca:	00008517          	auipc	a0,0x8
    80001cce:	42e50513          	addi	a0,a0,1070 # 8000a0f8 <etext+0xf8>
    80001cd2:	964ff0ef          	jal	80000e36 <panic>
  
  a = va;
    80001cd6:	fc043783          	ld	a5,-64(s0)
    80001cda:	fef43423          	sd	a5,-24(s0)
  last = va + size - PGSIZE;
    80001cde:	fc043703          	ld	a4,-64(s0)
    80001ce2:	fb843783          	ld	a5,-72(s0)
    80001ce6:	973e                	add	a4,a4,a5
    80001ce8:	77fd                	lui	a5,0xfffff
    80001cea:	97ba                	add	a5,a5,a4
    80001cec:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001cf0:	4605                	li	a2,1
    80001cf2:	fe843583          	ld	a1,-24(s0)
    80001cf6:	fc843503          	ld	a0,-56(s0)
    80001cfa:	e23ff0ef          	jal	80001b1c <walk>
    80001cfe:	fca43c23          	sd	a0,-40(s0)
    80001d02:	fd843783          	ld	a5,-40(s0)
    80001d06:	e399                	bnez	a5,80001d0c <mappages+0x96>
      return -1;
    80001d08:	57fd                	li	a5,-1
    80001d0a:	a8b1                	j	80001d66 <mappages+0xf0>
    if(*pte & PTE_V)
    80001d0c:	fd843783          	ld	a5,-40(s0)
    80001d10:	639c                	ld	a5,0(a5)
    80001d12:	8b85                	andi	a5,a5,1
    80001d14:	c799                	beqz	a5,80001d22 <mappages+0xac>
      panic("mappages: remap");
    80001d16:	00008517          	auipc	a0,0x8
    80001d1a:	3f250513          	addi	a0,a0,1010 # 8000a108 <etext+0x108>
    80001d1e:	918ff0ef          	jal	80000e36 <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001d22:	fb043783          	ld	a5,-80(s0)
    80001d26:	83b1                	srli	a5,a5,0xc
    80001d28:	00a79713          	slli	a4,a5,0xa
    80001d2c:	fac42783          	lw	a5,-84(s0)
    80001d30:	8fd9                	or	a5,a5,a4
    80001d32:	0017e713          	ori	a4,a5,1
    80001d36:	fd843783          	ld	a5,-40(s0)
    80001d3a:	e398                	sd	a4,0(a5)
    if(a == last)
    80001d3c:	fe843703          	ld	a4,-24(s0)
    80001d40:	fe043783          	ld	a5,-32(s0)
    80001d44:	00f70f63          	beq	a4,a5,80001d62 <mappages+0xec>
      break;
    a += PGSIZE;
    80001d48:	fe843703          	ld	a4,-24(s0)
    80001d4c:	6785                	lui	a5,0x1
    80001d4e:	97ba                	add	a5,a5,a4
    80001d50:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001d54:	fb043703          	ld	a4,-80(s0)
    80001d58:	6785                	lui	a5,0x1
    80001d5a:	97ba                	add	a5,a5,a4
    80001d5c:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80001d60:	bf41                	j	80001cf0 <mappages+0x7a>
      break;
    80001d62:	0001                	nop
  }
  return 0;
    80001d64:	4781                	li	a5,0
}
    80001d66:	853e                	mv	a0,a5
    80001d68:	60e6                	ld	ra,88(sp)
    80001d6a:	6446                	ld	s0,80(sp)
    80001d6c:	6125                	addi	sp,sp,96
    80001d6e:	8082                	ret

0000000080001d70 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001d70:	1101                	addi	sp,sp,-32
    80001d72:	ec06                	sd	ra,24(sp)
    80001d74:	e822                	sd	s0,16(sp)
    80001d76:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001d78:	c92ff0ef          	jal	8000120a <kalloc>
    80001d7c:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80001d80:	fe843783          	ld	a5,-24(s0)
    80001d84:	e399                	bnez	a5,80001d8a <uvmcreate+0x1a>
    return 0;
    80001d86:	4781                	li	a5,0
    80001d88:	a809                	j	80001d9a <uvmcreate+0x2a>
  memset(pagetable, 0, PGSIZE);
    80001d8a:	6605                	lui	a2,0x1
    80001d8c:	4581                	li	a1,0
    80001d8e:	fe843503          	ld	a0,-24(s0)
    80001d92:	f44ff0ef          	jal	800014d6 <memset>
  return pagetable;
    80001d96:	fe843783          	ld	a5,-24(s0)
}
    80001d9a:	853e                	mv	a0,a5
    80001d9c:	60e2                	ld	ra,24(sp)
    80001d9e:	6442                	ld	s0,16(sp)
    80001da0:	6105                	addi	sp,sp,32
    80001da2:	8082                	ret

0000000080001da4 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001da4:	715d                	addi	sp,sp,-80
    80001da6:	e486                	sd	ra,72(sp)
    80001da8:	e0a2                	sd	s0,64(sp)
    80001daa:	0880                	addi	s0,sp,80
    80001dac:	fca43423          	sd	a0,-56(s0)
    80001db0:	fcb43023          	sd	a1,-64(s0)
    80001db4:	fac43c23          	sd	a2,-72(s0)
    80001db8:	87b6                	mv	a5,a3
    80001dba:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001dbe:	fc043703          	ld	a4,-64(s0)
    80001dc2:	6785                	lui	a5,0x1
    80001dc4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001dc6:	8ff9                	and	a5,a5,a4
    80001dc8:	c799                	beqz	a5,80001dd6 <uvmunmap+0x32>
    panic("uvmunmap: not aligned");
    80001dca:	00008517          	auipc	a0,0x8
    80001dce:	34e50513          	addi	a0,a0,846 # 8000a118 <etext+0x118>
    80001dd2:	864ff0ef          	jal	80000e36 <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001dd6:	fc043783          	ld	a5,-64(s0)
    80001dda:	fef43423          	sd	a5,-24(s0)
    80001dde:	a085                	j	80001e3e <uvmunmap+0x9a>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    80001de0:	4601                	li	a2,0
    80001de2:	fe843583          	ld	a1,-24(s0)
    80001de6:	fc843503          	ld	a0,-56(s0)
    80001dea:	d33ff0ef          	jal	80001b1c <walk>
    80001dee:	fea43023          	sd	a0,-32(s0)
    80001df2:	fe043783          	ld	a5,-32(s0)
    80001df6:	cb9d                	beqz	a5,80001e2c <uvmunmap+0x88>
      continue;   
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    80001df8:	fe043783          	ld	a5,-32(s0)
    80001dfc:	639c                	ld	a5,0(a5)
    80001dfe:	8b85                	andi	a5,a5,1
    80001e00:	cb85                	beqz	a5,80001e30 <uvmunmap+0x8c>
      continue;
    if(do_free){
    80001e02:	fb442783          	lw	a5,-76(s0)
    80001e06:	2781                	sext.w	a5,a5
    80001e08:	cf89                	beqz	a5,80001e22 <uvmunmap+0x7e>
      uint64 pa = PTE2PA(*pte);
    80001e0a:	fe043783          	ld	a5,-32(s0)
    80001e0e:	639c                	ld	a5,0(a5)
    80001e10:	83a9                	srli	a5,a5,0xa
    80001e12:	07b2                	slli	a5,a5,0xc
    80001e14:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80001e18:	fd843783          	ld	a5,-40(s0)
    80001e1c:	853e                	mv	a0,a5
    80001e1e:	b58ff0ef          	jal	80001176 <kfree>
    }
    *pte = 0;
    80001e22:	fe043783          	ld	a5,-32(s0)
    80001e26:	0007b023          	sd	zero,0(a5)
    80001e2a:	a021                	j	80001e32 <uvmunmap+0x8e>
      continue;   
    80001e2c:	0001                	nop
    80001e2e:	a011                	j	80001e32 <uvmunmap+0x8e>
      continue;
    80001e30:	0001                	nop
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001e32:	fe843703          	ld	a4,-24(s0)
    80001e36:	6785                	lui	a5,0x1
    80001e38:	97ba                	add	a5,a5,a4
    80001e3a:	fef43423          	sd	a5,-24(s0)
    80001e3e:	fb843783          	ld	a5,-72(s0)
    80001e42:	00c79713          	slli	a4,a5,0xc
    80001e46:	fc043783          	ld	a5,-64(s0)
    80001e4a:	97ba                	add	a5,a5,a4
    80001e4c:	fe843703          	ld	a4,-24(s0)
    80001e50:	f8f768e3          	bltu	a4,a5,80001de0 <uvmunmap+0x3c>
  }
}
    80001e54:	0001                	nop
    80001e56:	0001                	nop
    80001e58:	60a6                	ld	ra,72(sp)
    80001e5a:	6406                	ld	s0,64(sp)
    80001e5c:	6161                	addi	sp,sp,80
    80001e5e:	8082                	ret

0000000080001e60 <uvmalloc>:

// Allocate PTEs and physical memory to grow a process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
    80001e60:	7139                	addi	sp,sp,-64
    80001e62:	fc06                	sd	ra,56(sp)
    80001e64:	f822                	sd	s0,48(sp)
    80001e66:	0080                	addi	s0,sp,64
    80001e68:	fca43c23          	sd	a0,-40(s0)
    80001e6c:	fcb43823          	sd	a1,-48(s0)
    80001e70:	fcc43423          	sd	a2,-56(s0)
    80001e74:	87b6                	mv	a5,a3
    80001e76:	fcf42223          	sw	a5,-60(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80001e7a:	fc843703          	ld	a4,-56(s0)
    80001e7e:	fd043783          	ld	a5,-48(s0)
    80001e82:	00f77563          	bgeu	a4,a5,80001e8c <uvmalloc+0x2c>
    return oldsz;
    80001e86:	fd043783          	ld	a5,-48(s0)
    80001e8a:	a05d                	j	80001f30 <uvmalloc+0xd0>

  oldsz = PGROUNDUP(oldsz);
    80001e8c:	fd043703          	ld	a4,-48(s0)
    80001e90:	6785                	lui	a5,0x1
    80001e92:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001e94:	973e                	add	a4,a4,a5
    80001e96:	77fd                	lui	a5,0xfffff
    80001e98:	8ff9                	and	a5,a5,a4
    80001e9a:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001e9e:	fd043783          	ld	a5,-48(s0)
    80001ea2:	fef43423          	sd	a5,-24(s0)
    80001ea6:	a8ad                	j	80001f20 <uvmalloc+0xc0>
    mem = kalloc();
    80001ea8:	b62ff0ef          	jal	8000120a <kalloc>
    80001eac:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80001eb0:	fe043783          	ld	a5,-32(s0)
    80001eb4:	eb99                	bnez	a5,80001eca <uvmalloc+0x6a>
      uvmdealloc(pagetable, a, oldsz);
    80001eb6:	fd043603          	ld	a2,-48(s0)
    80001eba:	fe843583          	ld	a1,-24(s0)
    80001ebe:	fd843503          	ld	a0,-40(s0)
    80001ec2:	078000ef          	jal	80001f3a <uvmdealloc>
      return 0;
    80001ec6:	4781                	li	a5,0
    80001ec8:	a0a5                	j	80001f30 <uvmalloc+0xd0>
    }
    memset(mem, 0, PGSIZE);
    80001eca:	6605                	lui	a2,0x1
    80001ecc:	4581                	li	a1,0
    80001ece:	fe043503          	ld	a0,-32(s0)
    80001ed2:	e04ff0ef          	jal	800014d6 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80001ed6:	fe043783          	ld	a5,-32(s0)
    80001eda:	fc442703          	lw	a4,-60(s0)
    80001ede:	01276713          	ori	a4,a4,18
    80001ee2:	2701                	sext.w	a4,a4
    80001ee4:	86be                	mv	a3,a5
    80001ee6:	6605                	lui	a2,0x1
    80001ee8:	fe843583          	ld	a1,-24(s0)
    80001eec:	fd843503          	ld	a0,-40(s0)
    80001ef0:	d87ff0ef          	jal	80001c76 <mappages>
    80001ef4:	87aa                	mv	a5,a0
    80001ef6:	cf99                	beqz	a5,80001f14 <uvmalloc+0xb4>
      kfree(mem);
    80001ef8:	fe043503          	ld	a0,-32(s0)
    80001efc:	a7aff0ef          	jal	80001176 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001f00:	fd043603          	ld	a2,-48(s0)
    80001f04:	fe843583          	ld	a1,-24(s0)
    80001f08:	fd843503          	ld	a0,-40(s0)
    80001f0c:	02e000ef          	jal	80001f3a <uvmdealloc>
      return 0;
    80001f10:	4781                	li	a5,0
    80001f12:	a839                	j	80001f30 <uvmalloc+0xd0>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001f14:	fe843703          	ld	a4,-24(s0)
    80001f18:	6785                	lui	a5,0x1
    80001f1a:	97ba                	add	a5,a5,a4
    80001f1c:	fef43423          	sd	a5,-24(s0)
    80001f20:	fe843703          	ld	a4,-24(s0)
    80001f24:	fc843783          	ld	a5,-56(s0)
    80001f28:	f8f760e3          	bltu	a4,a5,80001ea8 <uvmalloc+0x48>
    }
  }
  return newsz;
    80001f2c:	fc843783          	ld	a5,-56(s0)
}
    80001f30:	853e                	mv	a0,a5
    80001f32:	70e2                	ld	ra,56(sp)
    80001f34:	7442                	ld	s0,48(sp)
    80001f36:	6121                	addi	sp,sp,64
    80001f38:	8082                	ret

0000000080001f3a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001f3a:	7139                	addi	sp,sp,-64
    80001f3c:	fc06                	sd	ra,56(sp)
    80001f3e:	f822                	sd	s0,48(sp)
    80001f40:	0080                	addi	s0,sp,64
    80001f42:	fca43c23          	sd	a0,-40(s0)
    80001f46:	fcb43823          	sd	a1,-48(s0)
    80001f4a:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    80001f4e:	fc843703          	ld	a4,-56(s0)
    80001f52:	fd043783          	ld	a5,-48(s0)
    80001f56:	00f76563          	bltu	a4,a5,80001f60 <uvmdealloc+0x26>
    return oldsz;
    80001f5a:	fd043783          	ld	a5,-48(s0)
    80001f5e:	a0b5                	j	80001fca <uvmdealloc+0x90>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001f60:	fc843703          	ld	a4,-56(s0)
    80001f64:	6785                	lui	a5,0x1
    80001f66:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001f68:	973e                	add	a4,a4,a5
    80001f6a:	77fd                	lui	a5,0xfffff
    80001f6c:	8f7d                	and	a4,a4,a5
    80001f6e:	fd043683          	ld	a3,-48(s0)
    80001f72:	6785                	lui	a5,0x1
    80001f74:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001f76:	96be                	add	a3,a3,a5
    80001f78:	77fd                	lui	a5,0xfffff
    80001f7a:	8ff5                	and	a5,a5,a3
    80001f7c:	04f77563          	bgeu	a4,a5,80001fc6 <uvmdealloc+0x8c>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001f80:	fd043703          	ld	a4,-48(s0)
    80001f84:	6785                	lui	a5,0x1
    80001f86:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001f88:	973e                	add	a4,a4,a5
    80001f8a:	77fd                	lui	a5,0xfffff
    80001f8c:	8f7d                	and	a4,a4,a5
    80001f8e:	fc843683          	ld	a3,-56(s0)
    80001f92:	6785                	lui	a5,0x1
    80001f94:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001f96:	96be                	add	a3,a3,a5
    80001f98:	77fd                	lui	a5,0xfffff
    80001f9a:	8ff5                	and	a5,a5,a3
    80001f9c:	40f707b3          	sub	a5,a4,a5
    80001fa0:	83b1                	srli	a5,a5,0xc
    80001fa2:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80001fa6:	fc843703          	ld	a4,-56(s0)
    80001faa:	6785                	lui	a5,0x1
    80001fac:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001fae:	973e                	add	a4,a4,a5
    80001fb0:	77fd                	lui	a5,0xfffff
    80001fb2:	8ff9                	and	a5,a5,a4
    80001fb4:	fec42703          	lw	a4,-20(s0)
    80001fb8:	4685                	li	a3,1
    80001fba:	863a                	mv	a2,a4
    80001fbc:	85be                	mv	a1,a5
    80001fbe:	fd843503          	ld	a0,-40(s0)
    80001fc2:	de3ff0ef          	jal	80001da4 <uvmunmap>
  }

  return newsz;
    80001fc6:	fc843783          	ld	a5,-56(s0)
}
    80001fca:	853e                	mv	a0,a5
    80001fcc:	70e2                	ld	ra,56(sp)
    80001fce:	7442                	ld	s0,48(sp)
    80001fd0:	6121                	addi	sp,sp,64
    80001fd2:	8082                	ret

0000000080001fd4 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80001fd4:	7139                	addi	sp,sp,-64
    80001fd6:	fc06                	sd	ra,56(sp)
    80001fd8:	f822                	sd	s0,48(sp)
    80001fda:	0080                	addi	s0,sp,64
    80001fdc:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001fe0:	fe042623          	sw	zero,-20(s0)
    80001fe4:	a0ad                	j	8000204e <freewalk+0x7a>
    pte_t pte = pagetable[i];
    80001fe6:	fec42783          	lw	a5,-20(s0)
    80001fea:	078e                	slli	a5,a5,0x3
    80001fec:	fc843703          	ld	a4,-56(s0)
    80001ff0:	97ba                	add	a5,a5,a4
    80001ff2:	639c                	ld	a5,0(a5)
    80001ff4:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001ff8:	fe043783          	ld	a5,-32(s0)
    80001ffc:	8b85                	andi	a5,a5,1
    80001ffe:	cb8d                	beqz	a5,80002030 <freewalk+0x5c>
    80002000:	fe043783          	ld	a5,-32(s0)
    80002004:	8bb9                	andi	a5,a5,14
    80002006:	e78d                	bnez	a5,80002030 <freewalk+0x5c>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80002008:	fe043783          	ld	a5,-32(s0)
    8000200c:	83a9                	srli	a5,a5,0xa
    8000200e:	07b2                	slli	a5,a5,0xc
    80002010:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    80002014:	fd843783          	ld	a5,-40(s0)
    80002018:	853e                	mv	a0,a5
    8000201a:	fbbff0ef          	jal	80001fd4 <freewalk>
      pagetable[i] = 0;
    8000201e:	fec42783          	lw	a5,-20(s0)
    80002022:	078e                	slli	a5,a5,0x3
    80002024:	fc843703          	ld	a4,-56(s0)
    80002028:	97ba                	add	a5,a5,a4
    8000202a:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffdb3a8>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000202e:	a819                	j	80002044 <freewalk+0x70>
    } else if(pte & PTE_V){
    80002030:	fe043783          	ld	a5,-32(s0)
    80002034:	8b85                	andi	a5,a5,1
    80002036:	c799                	beqz	a5,80002044 <freewalk+0x70>
      panic("freewalk: leaf");
    80002038:	00008517          	auipc	a0,0x8
    8000203c:	0f850513          	addi	a0,a0,248 # 8000a130 <etext+0x130>
    80002040:	df7fe0ef          	jal	80000e36 <panic>
  for(int i = 0; i < 512; i++){
    80002044:	fec42783          	lw	a5,-20(s0)
    80002048:	2785                	addiw	a5,a5,1
    8000204a:	fef42623          	sw	a5,-20(s0)
    8000204e:	fec42783          	lw	a5,-20(s0)
    80002052:	0007871b          	sext.w	a4,a5
    80002056:	1ff00793          	li	a5,511
    8000205a:	f8e7d6e3          	bge	a5,a4,80001fe6 <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    8000205e:	fc843503          	ld	a0,-56(s0)
    80002062:	914ff0ef          	jal	80001176 <kfree>
}
    80002066:	0001                	nop
    80002068:	70e2                	ld	ra,56(sp)
    8000206a:	7442                	ld	s0,48(sp)
    8000206c:	6121                	addi	sp,sp,64
    8000206e:	8082                	ret

0000000080002070 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80002070:	1101                	addi	sp,sp,-32
    80002072:	ec06                	sd	ra,24(sp)
    80002074:	e822                	sd	s0,16(sp)
    80002076:	1000                	addi	s0,sp,32
    80002078:	fea43423          	sd	a0,-24(s0)
    8000207c:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80002080:	fe043783          	ld	a5,-32(s0)
    80002084:	cf91                	beqz	a5,800020a0 <uvmfree+0x30>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80002086:	fe043703          	ld	a4,-32(s0)
    8000208a:	6785                	lui	a5,0x1
    8000208c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000208e:	97ba                	add	a5,a5,a4
    80002090:	83b1                	srli	a5,a5,0xc
    80002092:	4685                	li	a3,1
    80002094:	863e                	mv	a2,a5
    80002096:	4581                	li	a1,0
    80002098:	fe843503          	ld	a0,-24(s0)
    8000209c:	d09ff0ef          	jal	80001da4 <uvmunmap>
  freewalk(pagetable);
    800020a0:	fe843503          	ld	a0,-24(s0)
    800020a4:	f31ff0ef          	jal	80001fd4 <freewalk>
}
    800020a8:	0001                	nop
    800020aa:	60e2                	ld	ra,24(sp)
    800020ac:	6442                	ld	s0,16(sp)
    800020ae:	6105                	addi	sp,sp,32
    800020b0:	8082                	ret

00000000800020b2 <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    800020b2:	711d                	addi	sp,sp,-96
    800020b4:	ec86                	sd	ra,88(sp)
    800020b6:	e8a2                	sd	s0,80(sp)
    800020b8:	1080                	addi	s0,sp,96
    800020ba:	faa43c23          	sd	a0,-72(s0)
    800020be:	fab43823          	sd	a1,-80(s0)
    800020c2:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800020c6:	fe043423          	sd	zero,-24(s0)
    800020ca:	a861                	j	80002162 <uvmcopy+0xb0>
    if((pte = walk(old, i, 0)) == 0)
    800020cc:	4601                	li	a2,0
    800020ce:	fe843583          	ld	a1,-24(s0)
    800020d2:	fb843503          	ld	a0,-72(s0)
    800020d6:	a47ff0ef          	jal	80001b1c <walk>
    800020da:	fea43023          	sd	a0,-32(s0)
    800020de:	fe043783          	ld	a5,-32(s0)
    800020e2:	c7bd                	beqz	a5,80002150 <uvmcopy+0x9e>
      continue;   // page table entry hasn't been allocated
    if((*pte & PTE_V) == 0)
    800020e4:	fe043783          	ld	a5,-32(s0)
    800020e8:	639c                	ld	a5,0(a5)
    800020ea:	8b85                	andi	a5,a5,1
    800020ec:	c7a5                	beqz	a5,80002154 <uvmcopy+0xa2>
      continue;   // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    800020ee:	fe043783          	ld	a5,-32(s0)
    800020f2:	639c                	ld	a5,0(a5)
    800020f4:	83a9                	srli	a5,a5,0xa
    800020f6:	07b2                	slli	a5,a5,0xc
    800020f8:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800020fc:	fe043783          	ld	a5,-32(s0)
    80002100:	639c                	ld	a5,0(a5)
    80002102:	2781                	sext.w	a5,a5
    80002104:	3ff7f793          	andi	a5,a5,1023
    80002108:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    8000210c:	8feff0ef          	jal	8000120a <kalloc>
    80002110:	fca43423          	sd	a0,-56(s0)
    80002114:	fc843783          	ld	a5,-56(s0)
    80002118:	cfa9                	beqz	a5,80002172 <uvmcopy+0xc0>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000211a:	fd843783          	ld	a5,-40(s0)
    8000211e:	6605                	lui	a2,0x1
    80002120:	85be                	mv	a1,a5
    80002122:	fc843503          	ld	a0,-56(s0)
    80002126:	c9cff0ef          	jal	800015c2 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000212a:	fc843783          	ld	a5,-56(s0)
    8000212e:	fd442703          	lw	a4,-44(s0)
    80002132:	86be                	mv	a3,a5
    80002134:	6605                	lui	a2,0x1
    80002136:	fe843583          	ld	a1,-24(s0)
    8000213a:	fb043503          	ld	a0,-80(s0)
    8000213e:	b39ff0ef          	jal	80001c76 <mappages>
    80002142:	87aa                	mv	a5,a0
    80002144:	cb89                	beqz	a5,80002156 <uvmcopy+0xa4>
      kfree(mem);
    80002146:	fc843503          	ld	a0,-56(s0)
    8000214a:	82cff0ef          	jal	80001176 <kfree>
      goto err;
    8000214e:	a01d                	j	80002174 <uvmcopy+0xc2>
      continue;   // page table entry hasn't been allocated
    80002150:	0001                	nop
    80002152:	a011                	j	80002156 <uvmcopy+0xa4>
      continue;   // physical page hasn't been allocated
    80002154:	0001                	nop
  for(i = 0; i < sz; i += PGSIZE){
    80002156:	fe843703          	ld	a4,-24(s0)
    8000215a:	6785                	lui	a5,0x1
    8000215c:	97ba                	add	a5,a5,a4
    8000215e:	fef43423          	sd	a5,-24(s0)
    80002162:	fe843703          	ld	a4,-24(s0)
    80002166:	fa843783          	ld	a5,-88(s0)
    8000216a:	f6f761e3          	bltu	a4,a5,800020cc <uvmcopy+0x1a>
    }
  }
  return 0;
    8000216e:	4781                	li	a5,0
    80002170:	a829                	j	8000218a <uvmcopy+0xd8>
      goto err;
    80002172:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80002174:	fe843783          	ld	a5,-24(s0)
    80002178:	83b1                	srli	a5,a5,0xc
    8000217a:	4685                	li	a3,1
    8000217c:	863e                	mv	a2,a5
    8000217e:	4581                	li	a1,0
    80002180:	fb043503          	ld	a0,-80(s0)
    80002184:	c21ff0ef          	jal	80001da4 <uvmunmap>
  return -1;
    80002188:	57fd                	li	a5,-1
}
    8000218a:	853e                	mv	a0,a5
    8000218c:	60e6                	ld	ra,88(sp)
    8000218e:	6446                	ld	s0,80(sp)
    80002190:	6125                	addi	sp,sp,96
    80002192:	8082                	ret

0000000080002194 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80002194:	7179                	addi	sp,sp,-48
    80002196:	f406                	sd	ra,40(sp)
    80002198:	f022                	sd	s0,32(sp)
    8000219a:	1800                	addi	s0,sp,48
    8000219c:	fca43c23          	sd	a0,-40(s0)
    800021a0:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800021a4:	4601                	li	a2,0
    800021a6:	fd043583          	ld	a1,-48(s0)
    800021aa:	fd843503          	ld	a0,-40(s0)
    800021ae:	96fff0ef          	jal	80001b1c <walk>
    800021b2:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800021b6:	fe843783          	ld	a5,-24(s0)
    800021ba:	e799                	bnez	a5,800021c8 <uvmclear+0x34>
    panic("uvmclear");
    800021bc:	00008517          	auipc	a0,0x8
    800021c0:	f8450513          	addi	a0,a0,-124 # 8000a140 <etext+0x140>
    800021c4:	c73fe0ef          	jal	80000e36 <panic>
  *pte &= ~PTE_U;
    800021c8:	fe843783          	ld	a5,-24(s0)
    800021cc:	639c                	ld	a5,0(a5)
    800021ce:	fef7f713          	andi	a4,a5,-17
    800021d2:	fe843783          	ld	a5,-24(s0)
    800021d6:	e398                	sd	a4,0(a5)
}
    800021d8:	0001                	nop
    800021da:	70a2                	ld	ra,40(sp)
    800021dc:	7402                	ld	s0,32(sp)
    800021de:	6145                	addi	sp,sp,48
    800021e0:	8082                	ret

00000000800021e2 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800021e2:	715d                	addi	sp,sp,-80
    800021e4:	e486                	sd	ra,72(sp)
    800021e6:	e0a2                	sd	s0,64(sp)
    800021e8:	0880                	addi	s0,sp,80
    800021ea:	fca43423          	sd	a0,-56(s0)
    800021ee:	fcb43023          	sd	a1,-64(s0)
    800021f2:	fac43c23          	sd	a2,-72(s0)
    800021f6:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    800021fa:	a0d5                	j	800022de <copyout+0xfc>
    va0 = PGROUNDDOWN(dstva);
    800021fc:	fc043703          	ld	a4,-64(s0)
    80002200:	77fd                	lui	a5,0xfffff
    80002202:	8ff9                	and	a5,a5,a4
    80002204:	fcf43c23          	sd	a5,-40(s0)
    if(va0 >= MAXVA)
    80002208:	fd843703          	ld	a4,-40(s0)
    8000220c:	57fd                	li	a5,-1
    8000220e:	83e9                	srli	a5,a5,0x1a
    80002210:	00e7f463          	bgeu	a5,a4,80002218 <copyout+0x36>
      return -1;
    80002214:	57fd                	li	a5,-1
    80002216:	a8c1                	j	800022e6 <copyout+0x104>
  
    pa0 = walkaddr(pagetable, va0);
    80002218:	fd843583          	ld	a1,-40(s0)
    8000221c:	fc843503          	ld	a0,-56(s0)
    80002220:	9e3ff0ef          	jal	80001c02 <walkaddr>
    80002224:	fea43023          	sd	a0,-32(s0)
    if(pa0 == 0) {
    80002228:	fe043783          	ld	a5,-32(s0)
    8000222c:	ef99                	bnez	a5,8000224a <copyout+0x68>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    8000222e:	4601                	li	a2,0
    80002230:	fd843583          	ld	a1,-40(s0)
    80002234:	fc843503          	ld	a0,-56(s0)
    80002238:	2a0000ef          	jal	800024d8 <vmfault>
    8000223c:	fea43023          	sd	a0,-32(s0)
    80002240:	fe043783          	ld	a5,-32(s0)
    80002244:	e399                	bnez	a5,8000224a <copyout+0x68>
        return -1;
    80002246:	57fd                	li	a5,-1
    80002248:	a879                	j	800022e6 <copyout+0x104>
      }
    }

    pte = walk(pagetable, va0, 0);
    8000224a:	4601                	li	a2,0
    8000224c:	fd843583          	ld	a1,-40(s0)
    80002250:	fc843503          	ld	a0,-56(s0)
    80002254:	8c9ff0ef          	jal	80001b1c <walk>
    80002258:	fca43823          	sd	a0,-48(s0)
    // forbid copyout over read-only user text pages.
    if((*pte & PTE_W) == 0)
    8000225c:	fd043783          	ld	a5,-48(s0)
    80002260:	639c                	ld	a5,0(a5)
    80002262:	8b91                	andi	a5,a5,4
    80002264:	e399                	bnez	a5,8000226a <copyout+0x88>
      return -1;
    80002266:	57fd                	li	a5,-1
    80002268:	a8bd                	j	800022e6 <copyout+0x104>
      
    n = PGSIZE - (dstva - va0);
    8000226a:	fd843703          	ld	a4,-40(s0)
    8000226e:	fc043783          	ld	a5,-64(s0)
    80002272:	8f1d                	sub	a4,a4,a5
    80002274:	6785                	lui	a5,0x1
    80002276:	97ba                	add	a5,a5,a4
    80002278:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000227c:	fe843703          	ld	a4,-24(s0)
    80002280:	fb043783          	ld	a5,-80(s0)
    80002284:	00e7f663          	bgeu	a5,a4,80002290 <copyout+0xae>
      n = len;
    80002288:	fb043783          	ld	a5,-80(s0)
    8000228c:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80002290:	fc043703          	ld	a4,-64(s0)
    80002294:	fd843783          	ld	a5,-40(s0)
    80002298:	8f1d                	sub	a4,a4,a5
    8000229a:	fe043783          	ld	a5,-32(s0)
    8000229e:	97ba                	add	a5,a5,a4
    800022a0:	873e                	mv	a4,a5
    800022a2:	fe843783          	ld	a5,-24(s0)
    800022a6:	2781                	sext.w	a5,a5
    800022a8:	863e                	mv	a2,a5
    800022aa:	fb843583          	ld	a1,-72(s0)
    800022ae:	853a                	mv	a0,a4
    800022b0:	b12ff0ef          	jal	800015c2 <memmove>

    len -= n;
    800022b4:	fb043703          	ld	a4,-80(s0)
    800022b8:	fe843783          	ld	a5,-24(s0)
    800022bc:	40f707b3          	sub	a5,a4,a5
    800022c0:	faf43823          	sd	a5,-80(s0)
    src += n;
    800022c4:	fb843703          	ld	a4,-72(s0)
    800022c8:	fe843783          	ld	a5,-24(s0)
    800022cc:	97ba                	add	a5,a5,a4
    800022ce:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    800022d2:	fd843703          	ld	a4,-40(s0)
    800022d6:	6785                	lui	a5,0x1
    800022d8:	97ba                	add	a5,a5,a4
    800022da:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    800022de:	fb043783          	ld	a5,-80(s0)
    800022e2:	ff89                	bnez	a5,800021fc <copyout+0x1a>
  }
  return 0;
    800022e4:	4781                	li	a5,0
}
    800022e6:	853e                	mv	a0,a5
    800022e8:	60a6                	ld	ra,72(sp)
    800022ea:	6406                	ld	s0,64(sp)
    800022ec:	6161                	addi	sp,sp,80
    800022ee:	8082                	ret

00000000800022f0 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    800022f0:	715d                	addi	sp,sp,-80
    800022f2:	e486                	sd	ra,72(sp)
    800022f4:	e0a2                	sd	s0,64(sp)
    800022f6:	0880                	addi	s0,sp,80
    800022f8:	fca43423          	sd	a0,-56(s0)
    800022fc:	fcb43023          	sd	a1,-64(s0)
    80002300:	fac43c23          	sd	a2,-72(s0)
    80002304:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    80002308:	a855                	j	800023bc <copyin+0xcc>
    va0 = PGROUNDDOWN(srcva);
    8000230a:	fb843703          	ld	a4,-72(s0)
    8000230e:	77fd                	lui	a5,0xfffff
    80002310:	8ff9                	and	a5,a5,a4
    80002312:	fcf43c23          	sd	a5,-40(s0)
    pa0 = walkaddr(pagetable, va0);
    80002316:	fd843583          	ld	a1,-40(s0)
    8000231a:	fc843503          	ld	a0,-56(s0)
    8000231e:	8e5ff0ef          	jal	80001c02 <walkaddr>
    80002322:	fea43023          	sd	a0,-32(s0)
    if(pa0 == 0) {
    80002326:	fe043783          	ld	a5,-32(s0)
    8000232a:	ef99                	bnez	a5,80002348 <copyin+0x58>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    8000232c:	4601                	li	a2,0
    8000232e:	fd843583          	ld	a1,-40(s0)
    80002332:	fc843503          	ld	a0,-56(s0)
    80002336:	1a2000ef          	jal	800024d8 <vmfault>
    8000233a:	fea43023          	sd	a0,-32(s0)
    8000233e:	fe043783          	ld	a5,-32(s0)
    80002342:	e399                	bnez	a5,80002348 <copyin+0x58>
        return -1;
    80002344:	57fd                	li	a5,-1
    80002346:	a8bd                	j	800023c4 <copyin+0xd4>
      }
    }
    n = PGSIZE - (srcva - va0);
    80002348:	fd843703          	ld	a4,-40(s0)
    8000234c:	fb843783          	ld	a5,-72(s0)
    80002350:	8f1d                	sub	a4,a4,a5
    80002352:	6785                	lui	a5,0x1
    80002354:	97ba                	add	a5,a5,a4
    80002356:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000235a:	fe843703          	ld	a4,-24(s0)
    8000235e:	fb043783          	ld	a5,-80(s0)
    80002362:	00e7f663          	bgeu	a5,a4,8000236e <copyin+0x7e>
      n = len;
    80002366:	fb043783          	ld	a5,-80(s0)
    8000236a:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000236e:	fb843703          	ld	a4,-72(s0)
    80002372:	fd843783          	ld	a5,-40(s0)
    80002376:	8f1d                	sub	a4,a4,a5
    80002378:	fe043783          	ld	a5,-32(s0)
    8000237c:	97ba                	add	a5,a5,a4
    8000237e:	873e                	mv	a4,a5
    80002380:	fe843783          	ld	a5,-24(s0)
    80002384:	2781                	sext.w	a5,a5
    80002386:	863e                	mv	a2,a5
    80002388:	85ba                	mv	a1,a4
    8000238a:	fc043503          	ld	a0,-64(s0)
    8000238e:	a34ff0ef          	jal	800015c2 <memmove>

    len -= n;
    80002392:	fb043703          	ld	a4,-80(s0)
    80002396:	fe843783          	ld	a5,-24(s0)
    8000239a:	40f707b3          	sub	a5,a4,a5
    8000239e:	faf43823          	sd	a5,-80(s0)
    dst += n;
    800023a2:	fc043703          	ld	a4,-64(s0)
    800023a6:	fe843783          	ld	a5,-24(s0)
    800023aa:	97ba                	add	a5,a5,a4
    800023ac:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    800023b0:	fd843703          	ld	a4,-40(s0)
    800023b4:	6785                	lui	a5,0x1
    800023b6:	97ba                	add	a5,a5,a4
    800023b8:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    800023bc:	fb043783          	ld	a5,-80(s0)
    800023c0:	f7a9                	bnez	a5,8000230a <copyin+0x1a>
  }
  return 0;
    800023c2:	4781                	li	a5,0
}
    800023c4:	853e                	mv	a0,a5
    800023c6:	60a6                	ld	ra,72(sp)
    800023c8:	6406                	ld	s0,64(sp)
    800023ca:	6161                	addi	sp,sp,80
    800023cc:	8082                	ret

00000000800023ce <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    800023ce:	711d                	addi	sp,sp,-96
    800023d0:	ec86                	sd	ra,88(sp)
    800023d2:	e8a2                	sd	s0,80(sp)
    800023d4:	1080                	addi	s0,sp,96
    800023d6:	faa43c23          	sd	a0,-72(s0)
    800023da:	fab43823          	sd	a1,-80(s0)
    800023de:	fac43423          	sd	a2,-88(s0)
    800023e2:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    800023e6:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    800023ea:	a0e1                	j	800024b2 <copyinstr+0xe4>
    va0 = PGROUNDDOWN(srcva);
    800023ec:	fa843703          	ld	a4,-88(s0)
    800023f0:	77fd                	lui	a5,0xfffff
    800023f2:	8ff9                	and	a5,a5,a4
    800023f4:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    800023f8:	fd043583          	ld	a1,-48(s0)
    800023fc:	fb843503          	ld	a0,-72(s0)
    80002400:	803ff0ef          	jal	80001c02 <walkaddr>
    80002404:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    80002408:	fc843783          	ld	a5,-56(s0)
    8000240c:	e399                	bnez	a5,80002412 <copyinstr+0x44>
      return -1;
    8000240e:	57fd                	li	a5,-1
    80002410:	a87d                	j	800024ce <copyinstr+0x100>
    n = PGSIZE - (srcva - va0);
    80002412:	fd043703          	ld	a4,-48(s0)
    80002416:	fa843783          	ld	a5,-88(s0)
    8000241a:	8f1d                	sub	a4,a4,a5
    8000241c:	6785                	lui	a5,0x1
    8000241e:	97ba                	add	a5,a5,a4
    80002420:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    80002424:	fe843703          	ld	a4,-24(s0)
    80002428:	fa043783          	ld	a5,-96(s0)
    8000242c:	00e7f663          	bgeu	a5,a4,80002438 <copyinstr+0x6a>
      n = max;
    80002430:	fa043783          	ld	a5,-96(s0)
    80002434:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    80002438:	fa843703          	ld	a4,-88(s0)
    8000243c:	fd043783          	ld	a5,-48(s0)
    80002440:	8f1d                	sub	a4,a4,a5
    80002442:	fc843783          	ld	a5,-56(s0)
    80002446:	97ba                	add	a5,a5,a4
    80002448:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    8000244c:	a891                	j	800024a0 <copyinstr+0xd2>
      if(*p == '\0'){
    8000244e:	fd843783          	ld	a5,-40(s0)
    80002452:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    80002456:	eb89                	bnez	a5,80002468 <copyinstr+0x9a>
        *dst = '\0';
    80002458:	fb043783          	ld	a5,-80(s0)
    8000245c:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80002460:	4785                	li	a5,1
    80002462:	fef42223          	sw	a5,-28(s0)
        break;
    80002466:	a081                	j	800024a6 <copyinstr+0xd8>
      } else {
        *dst = *p;
    80002468:	fd843783          	ld	a5,-40(s0)
    8000246c:	0007c703          	lbu	a4,0(a5)
    80002470:	fb043783          	ld	a5,-80(s0)
    80002474:	00e78023          	sb	a4,0(a5)
      }
      --n;
    80002478:	fe843783          	ld	a5,-24(s0)
    8000247c:	17fd                	addi	a5,a5,-1
    8000247e:	fef43423          	sd	a5,-24(s0)
      --max;
    80002482:	fa043783          	ld	a5,-96(s0)
    80002486:	17fd                	addi	a5,a5,-1
    80002488:	faf43023          	sd	a5,-96(s0)
      p++;
    8000248c:	fd843783          	ld	a5,-40(s0)
    80002490:	0785                	addi	a5,a5,1
    80002492:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    80002496:	fb043783          	ld	a5,-80(s0)
    8000249a:	0785                	addi	a5,a5,1
    8000249c:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    800024a0:	fe843783          	ld	a5,-24(s0)
    800024a4:	f7cd                	bnez	a5,8000244e <copyinstr+0x80>
    }

    srcva = va0 + PGSIZE;
    800024a6:	fd043703          	ld	a4,-48(s0)
    800024aa:	6785                	lui	a5,0x1
    800024ac:	97ba                	add	a5,a5,a4
    800024ae:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    800024b2:	fe442783          	lw	a5,-28(s0)
    800024b6:	2781                	sext.w	a5,a5
    800024b8:	e781                	bnez	a5,800024c0 <copyinstr+0xf2>
    800024ba:	fa043783          	ld	a5,-96(s0)
    800024be:	f79d                	bnez	a5,800023ec <copyinstr+0x1e>
  }
  if(got_null){
    800024c0:	fe442783          	lw	a5,-28(s0)
    800024c4:	2781                	sext.w	a5,a5
    800024c6:	c399                	beqz	a5,800024cc <copyinstr+0xfe>
    return 0;
    800024c8:	4781                	li	a5,0
    800024ca:	a011                	j	800024ce <copyinstr+0x100>
  } else {
    return -1;
    800024cc:	57fd                	li	a5,-1
  }
}
    800024ce:	853e                	mv	a0,a5
    800024d0:	60e6                	ld	ra,88(sp)
    800024d2:	6446                	ld	s0,80(sp)
    800024d4:	6125                	addi	sp,sp,96
    800024d6:	8082                	ret

00000000800024d8 <vmfault>:
// that was lazily allocated in sys_sbrk().
// returns 0 if va is invalid or already mapped, or if
// out of physical memory, and physical address if successful.
uint64
vmfault(pagetable_t pagetable, uint64 va, int read)
{
    800024d8:	7139                	addi	sp,sp,-64
    800024da:	fc06                	sd	ra,56(sp)
    800024dc:	f822                	sd	s0,48(sp)
    800024de:	0080                	addi	s0,sp,64
    800024e0:	fca43c23          	sd	a0,-40(s0)
    800024e4:	fcb43823          	sd	a1,-48(s0)
    800024e8:	87b2                	mv	a5,a2
    800024ea:	fcf42623          	sw	a5,-52(s0)
  uint64 mem;
  struct proc *p = myproc();
    800024ee:	366000ef          	jal	80002854 <myproc>
    800024f2:	fea43423          	sd	a0,-24(s0)

  if (va >= p->sz)
    800024f6:	fe843783          	ld	a5,-24(s0)
    800024fa:	67bc                	ld	a5,72(a5)
    800024fc:	fd043703          	ld	a4,-48(s0)
    80002500:	00f76463          	bltu	a4,a5,80002508 <vmfault+0x30>
    return 0;
    80002504:	4781                	li	a5,0
    80002506:	a88d                	j	80002578 <vmfault+0xa0>
  va = PGROUNDDOWN(va);
    80002508:	fd043703          	ld	a4,-48(s0)
    8000250c:	77fd                	lui	a5,0xfffff
    8000250e:	8ff9                	and	a5,a5,a4
    80002510:	fcf43823          	sd	a5,-48(s0)
  if(ismapped(pagetable, va)) {
    80002514:	fd043583          	ld	a1,-48(s0)
    80002518:	fd843503          	ld	a0,-40(s0)
    8000251c:	066000ef          	jal	80002582 <ismapped>
    80002520:	87aa                	mv	a5,a0
    80002522:	c399                	beqz	a5,80002528 <vmfault+0x50>
    return 0;
    80002524:	4781                	li	a5,0
    80002526:	a889                	j	80002578 <vmfault+0xa0>
  }
  mem = (uint64) kalloc();
    80002528:	ce3fe0ef          	jal	8000120a <kalloc>
    8000252c:	87aa                	mv	a5,a0
    8000252e:	fef43023          	sd	a5,-32(s0)
  if(mem == 0)
    80002532:	fe043783          	ld	a5,-32(s0)
    80002536:	e399                	bnez	a5,8000253c <vmfault+0x64>
    return 0;
    80002538:	4781                	li	a5,0
    8000253a:	a83d                	j	80002578 <vmfault+0xa0>
  memset((void *) mem, 0, PGSIZE);
    8000253c:	fe043783          	ld	a5,-32(s0)
    80002540:	6605                	lui	a2,0x1
    80002542:	4581                	li	a1,0
    80002544:	853e                	mv	a0,a5
    80002546:	f91fe0ef          	jal	800014d6 <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    8000254a:	fe843783          	ld	a5,-24(s0)
    8000254e:	6bbc                	ld	a5,80(a5)
    80002550:	4759                	li	a4,22
    80002552:	fe043683          	ld	a3,-32(s0)
    80002556:	6605                	lui	a2,0x1
    80002558:	fd043583          	ld	a1,-48(s0)
    8000255c:	853e                	mv	a0,a5
    8000255e:	f18ff0ef          	jal	80001c76 <mappages>
    80002562:	87aa                	mv	a5,a0
    80002564:	cb81                	beqz	a5,80002574 <vmfault+0x9c>
    kfree((void *)mem);
    80002566:	fe043783          	ld	a5,-32(s0)
    8000256a:	853e                	mv	a0,a5
    8000256c:	c0bfe0ef          	jal	80001176 <kfree>
    return 0;
    80002570:	4781                	li	a5,0
    80002572:	a019                	j	80002578 <vmfault+0xa0>
  }
  return mem;
    80002574:	fe043783          	ld	a5,-32(s0)
}
    80002578:	853e                	mv	a0,a5
    8000257a:	70e2                	ld	ra,56(sp)
    8000257c:	7442                	ld	s0,48(sp)
    8000257e:	6121                	addi	sp,sp,64
    80002580:	8082                	ret

0000000080002582 <ismapped>:

int
ismapped(pagetable_t pagetable, uint64 va)
{
    80002582:	7179                	addi	sp,sp,-48
    80002584:	f406                	sd	ra,40(sp)
    80002586:	f022                	sd	s0,32(sp)
    80002588:	1800                	addi	s0,sp,48
    8000258a:	fca43c23          	sd	a0,-40(s0)
    8000258e:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte = walk(pagetable, va, 0);
    80002592:	4601                	li	a2,0
    80002594:	fd043583          	ld	a1,-48(s0)
    80002598:	fd843503          	ld	a0,-40(s0)
    8000259c:	d80ff0ef          	jal	80001b1c <walk>
    800025a0:	fea43423          	sd	a0,-24(s0)
  if (pte == 0) {
    800025a4:	fe843783          	ld	a5,-24(s0)
    800025a8:	e399                	bnez	a5,800025ae <ismapped+0x2c>
    return 0;
    800025aa:	4781                	li	a5,0
    800025ac:	a809                	j	800025be <ismapped+0x3c>
  }
  if (*pte & PTE_V){
    800025ae:	fe843783          	ld	a5,-24(s0)
    800025b2:	639c                	ld	a5,0(a5)
    800025b4:	8b85                	andi	a5,a5,1
    800025b6:	c399                	beqz	a5,800025bc <ismapped+0x3a>
    return 1;
    800025b8:	4785                	li	a5,1
    800025ba:	a011                	j	800025be <ismapped+0x3c>
  }
  return 0;
    800025bc:	4781                	li	a5,0
}
    800025be:	853e                	mv	a0,a5
    800025c0:	70a2                	ld	ra,40(sp)
    800025c2:	7402                	ld	s0,32(sp)
    800025c4:	6145                	addi	sp,sp,48
    800025c6:	8082                	ret

00000000800025c8 <r_sstatus>:
{
    800025c8:	1101                	addi	sp,sp,-32
    800025ca:	ec06                	sd	ra,24(sp)
    800025cc:	e822                	sd	s0,16(sp)
    800025ce:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800025d0:	100027f3          	csrr	a5,sstatus
    800025d4:	fef43423          	sd	a5,-24(s0)
  return x;
    800025d8:	fe843783          	ld	a5,-24(s0)
}
    800025dc:	853e                	mv	a0,a5
    800025de:	60e2                	ld	ra,24(sp)
    800025e0:	6442                	ld	s0,16(sp)
    800025e2:	6105                	addi	sp,sp,32
    800025e4:	8082                	ret

00000000800025e6 <w_sstatus>:
{
    800025e6:	1101                	addi	sp,sp,-32
    800025e8:	ec06                	sd	ra,24(sp)
    800025ea:	e822                	sd	s0,16(sp)
    800025ec:	1000                	addi	s0,sp,32
    800025ee:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025f2:	fe843783          	ld	a5,-24(s0)
    800025f6:	10079073          	csrw	sstatus,a5
}
    800025fa:	0001                	nop
    800025fc:	60e2                	ld	ra,24(sp)
    800025fe:	6442                	ld	s0,16(sp)
    80002600:	6105                	addi	sp,sp,32
    80002602:	8082                	ret

0000000080002604 <intr_on>:
{
    80002604:	1141                	addi	sp,sp,-16
    80002606:	e406                	sd	ra,8(sp)
    80002608:	e022                	sd	s0,0(sp)
    8000260a:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000260c:	fbdff0ef          	jal	800025c8 <r_sstatus>
    80002610:	87aa                	mv	a5,a0
    80002612:	0027e793          	ori	a5,a5,2
    80002616:	853e                	mv	a0,a5
    80002618:	fcfff0ef          	jal	800025e6 <w_sstatus>
}
    8000261c:	0001                	nop
    8000261e:	60a2                	ld	ra,8(sp)
    80002620:	6402                	ld	s0,0(sp)
    80002622:	0141                	addi	sp,sp,16
    80002624:	8082                	ret

0000000080002626 <intr_off>:
{
    80002626:	1141                	addi	sp,sp,-16
    80002628:	e406                	sd	ra,8(sp)
    8000262a:	e022                	sd	s0,0(sp)
    8000262c:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000262e:	f9bff0ef          	jal	800025c8 <r_sstatus>
    80002632:	87aa                	mv	a5,a0
    80002634:	9bf5                	andi	a5,a5,-3
    80002636:	853e                	mv	a0,a5
    80002638:	fafff0ef          	jal	800025e6 <w_sstatus>
}
    8000263c:	0001                	nop
    8000263e:	60a2                	ld	ra,8(sp)
    80002640:	6402                	ld	s0,0(sp)
    80002642:	0141                	addi	sp,sp,16
    80002644:	8082                	ret

0000000080002646 <intr_get>:
{
    80002646:	1101                	addi	sp,sp,-32
    80002648:	ec06                	sd	ra,24(sp)
    8000264a:	e822                	sd	s0,16(sp)
    8000264c:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    8000264e:	f7bff0ef          	jal	800025c8 <r_sstatus>
    80002652:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80002656:	fe843783          	ld	a5,-24(s0)
    8000265a:	8b89                	andi	a5,a5,2
    8000265c:	00f037b3          	snez	a5,a5
    80002660:	0ff7f793          	zext.b	a5,a5
    80002664:	2781                	sext.w	a5,a5
}
    80002666:	853e                	mv	a0,a5
    80002668:	60e2                	ld	ra,24(sp)
    8000266a:	6442                	ld	s0,16(sp)
    8000266c:	6105                	addi	sp,sp,32
    8000266e:	8082                	ret

0000000080002670 <r_tp>:
{
    80002670:	1101                	addi	sp,sp,-32
    80002672:	ec06                	sd	ra,24(sp)
    80002674:	e822                	sd	s0,16(sp)
    80002676:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002678:	8792                	mv	a5,tp
    8000267a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000267e:	fe843783          	ld	a5,-24(s0)
}
    80002682:	853e                	mv	a0,a5
    80002684:	60e2                	ld	ra,24(sp)
    80002686:	6442                	ld	s0,16(sp)
    80002688:	6105                	addi	sp,sp,32
    8000268a:	8082                	ret

000000008000268c <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    8000268c:	7139                	addi	sp,sp,-64
    8000268e:	fc06                	sd	ra,56(sp)
    80002690:	f822                	sd	s0,48(sp)
    80002692:	0080                	addi	s0,sp,64
    80002694:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80002698:	00010797          	auipc	a5,0x10
    8000269c:	7b078793          	addi	a5,a5,1968 # 80012e48 <proc>
    800026a0:	fef43423          	sd	a5,-24(s0)
    800026a4:	a8b5                	j	80002720 <proc_mapstacks+0x94>
    char *pa = kalloc();
    800026a6:	b65fe0ef          	jal	8000120a <kalloc>
    800026aa:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    800026ae:	fe043783          	ld	a5,-32(s0)
    800026b2:	e799                	bnez	a5,800026c0 <proc_mapstacks+0x34>
      panic("kalloc");
    800026b4:	00008517          	auipc	a0,0x8
    800026b8:	a9c50513          	addi	a0,a0,-1380 # 8000a150 <etext+0x150>
    800026bc:	f7afe0ef          	jal	80000e36 <panic>
    uint64 va = KSTACK((int) (p - proc));
    800026c0:	fe843703          	ld	a4,-24(s0)
    800026c4:	00010797          	auipc	a5,0x10
    800026c8:	78478793          	addi	a5,a5,1924 # 80012e48 <proc>
    800026cc:	40f707b3          	sub	a5,a4,a5
    800026d0:	4037d713          	srai	a4,a5,0x3
    800026d4:	00008797          	auipc	a5,0x8
    800026d8:	b7478793          	addi	a5,a5,-1164 # 8000a248 <etext+0x248>
    800026dc:	639c                	ld	a5,0(a5)
    800026de:	02f707b3          	mul	a5,a4,a5
    800026e2:	2781                	sext.w	a5,a5
    800026e4:	2785                	addiw	a5,a5,1
    800026e6:	2781                	sext.w	a5,a5
    800026e8:	00d7979b          	slliw	a5,a5,0xd
    800026ec:	2781                	sext.w	a5,a5
    800026ee:	873e                	mv	a4,a5
    800026f0:	040007b7          	lui	a5,0x4000
    800026f4:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800026f6:	07b2                	slli	a5,a5,0xc
    800026f8:	8f99                	sub	a5,a5,a4
    800026fa:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800026fe:	fe043783          	ld	a5,-32(s0)
    80002702:	4719                	li	a4,6
    80002704:	6685                	lui	a3,0x1
    80002706:	863e                	mv	a2,a5
    80002708:	fd843583          	ld	a1,-40(s0)
    8000270c:	fc843503          	ld	a0,-56(s0)
    80002710:	b64ff0ef          	jal	80001a74 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002714:	fe843783          	ld	a5,-24(s0)
    80002718:	16878793          	addi	a5,a5,360
    8000271c:	fef43423          	sd	a5,-24(s0)
    80002720:	fe843703          	ld	a4,-24(s0)
    80002724:	00016797          	auipc	a5,0x16
    80002728:	12478793          	addi	a5,a5,292 # 80018848 <pid_lock>
    8000272c:	f6f76de3          	bltu	a4,a5,800026a6 <proc_mapstacks+0x1a>
  }
}
    80002730:	0001                	nop
    80002732:	0001                	nop
    80002734:	70e2                	ld	ra,56(sp)
    80002736:	7442                	ld	s0,48(sp)
    80002738:	6121                	addi	sp,sp,64
    8000273a:	8082                	ret

000000008000273c <procinit>:

// initialize the proc table.
void
procinit(void)
{
    8000273c:	1101                	addi	sp,sp,-32
    8000273e:	ec06                	sd	ra,24(sp)
    80002740:	e822                	sd	s0,16(sp)
    80002742:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80002744:	00008597          	auipc	a1,0x8
    80002748:	a1458593          	addi	a1,a1,-1516 # 8000a158 <etext+0x158>
    8000274c:	00016517          	auipc	a0,0x16
    80002750:	0fc50513          	addi	a0,a0,252 # 80018848 <pid_lock>
    80002754:	bc3fe0ef          	jal	80001316 <initlock>
  initlock(&wait_lock, "wait_lock");
    80002758:	00008597          	auipc	a1,0x8
    8000275c:	a0858593          	addi	a1,a1,-1528 # 8000a160 <etext+0x160>
    80002760:	00016517          	auipc	a0,0x16
    80002764:	10050513          	addi	a0,a0,256 # 80018860 <wait_lock>
    80002768:	baffe0ef          	jal	80001316 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000276c:	00010797          	auipc	a5,0x10
    80002770:	6dc78793          	addi	a5,a5,1756 # 80012e48 <proc>
    80002774:	fef43423          	sd	a5,-24(s0)
    80002778:	a0ad                	j	800027e2 <procinit+0xa6>
      initlock(&p->lock, "proc");
    8000277a:	fe843783          	ld	a5,-24(s0)
    8000277e:	00008597          	auipc	a1,0x8
    80002782:	9f258593          	addi	a1,a1,-1550 # 8000a170 <etext+0x170>
    80002786:	853e                	mv	a0,a5
    80002788:	b8ffe0ef          	jal	80001316 <initlock>
      p->state = UNUSED;
    8000278c:	fe843783          	ld	a5,-24(s0)
    80002790:	0007ac23          	sw	zero,24(a5)
      p->kstack = KSTACK((int) (p - proc));
    80002794:	fe843703          	ld	a4,-24(s0)
    80002798:	00010797          	auipc	a5,0x10
    8000279c:	6b078793          	addi	a5,a5,1712 # 80012e48 <proc>
    800027a0:	40f707b3          	sub	a5,a4,a5
    800027a4:	4037d713          	srai	a4,a5,0x3
    800027a8:	00008797          	auipc	a5,0x8
    800027ac:	aa078793          	addi	a5,a5,-1376 # 8000a248 <etext+0x248>
    800027b0:	639c                	ld	a5,0(a5)
    800027b2:	02f707b3          	mul	a5,a4,a5
    800027b6:	2781                	sext.w	a5,a5
    800027b8:	2785                	addiw	a5,a5,1
    800027ba:	2781                	sext.w	a5,a5
    800027bc:	00d7979b          	slliw	a5,a5,0xd
    800027c0:	2781                	sext.w	a5,a5
    800027c2:	873e                	mv	a4,a5
    800027c4:	040007b7          	lui	a5,0x4000
    800027c8:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800027ca:	07b2                	slli	a5,a5,0xc
    800027cc:	8f99                	sub	a5,a5,a4
    800027ce:	873e                	mv	a4,a5
    800027d0:	fe843783          	ld	a5,-24(s0)
    800027d4:	e3b8                	sd	a4,64(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    800027d6:	fe843783          	ld	a5,-24(s0)
    800027da:	16878793          	addi	a5,a5,360
    800027de:	fef43423          	sd	a5,-24(s0)
    800027e2:	fe843703          	ld	a4,-24(s0)
    800027e6:	00016797          	auipc	a5,0x16
    800027ea:	06278793          	addi	a5,a5,98 # 80018848 <pid_lock>
    800027ee:	f8f766e3          	bltu	a4,a5,8000277a <procinit+0x3e>
  }
}
    800027f2:	0001                	nop
    800027f4:	0001                	nop
    800027f6:	60e2                	ld	ra,24(sp)
    800027f8:	6442                	ld	s0,16(sp)
    800027fa:	6105                	addi	sp,sp,32
    800027fc:	8082                	ret

00000000800027fe <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800027fe:	1101                	addi	sp,sp,-32
    80002800:	ec06                	sd	ra,24(sp)
    80002802:	e822                	sd	s0,16(sp)
    80002804:	1000                	addi	s0,sp,32
  int id = r_tp();
    80002806:	e6bff0ef          	jal	80002670 <r_tp>
    8000280a:	87aa                	mv	a5,a0
    8000280c:	fef42623          	sw	a5,-20(s0)
  return id;
    80002810:	fec42783          	lw	a5,-20(s0)
}
    80002814:	853e                	mv	a0,a5
    80002816:	60e2                	ld	ra,24(sp)
    80002818:	6442                	ld	s0,16(sp)
    8000281a:	6105                	addi	sp,sp,32
    8000281c:	8082                	ret

000000008000281e <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    8000281e:	1101                	addi	sp,sp,-32
    80002820:	ec06                	sd	ra,24(sp)
    80002822:	e822                	sd	s0,16(sp)
    80002824:	1000                	addi	s0,sp,32
  int id = cpuid();
    80002826:	fd9ff0ef          	jal	800027fe <cpuid>
    8000282a:	87aa                	mv	a5,a0
    8000282c:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    80002830:	fec42783          	lw	a5,-20(s0)
    80002834:	00779713          	slli	a4,a5,0x7
    80002838:	00010797          	auipc	a5,0x10
    8000283c:	21078793          	addi	a5,a5,528 # 80012a48 <cpus>
    80002840:	97ba                	add	a5,a5,a4
    80002842:	fef43023          	sd	a5,-32(s0)
  return c;
    80002846:	fe043783          	ld	a5,-32(s0)
}
    8000284a:	853e                	mv	a0,a5
    8000284c:	60e2                	ld	ra,24(sp)
    8000284e:	6442                	ld	s0,16(sp)
    80002850:	6105                	addi	sp,sp,32
    80002852:	8082                	ret

0000000080002854 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80002854:	1101                	addi	sp,sp,-32
    80002856:	ec06                	sd	ra,24(sp)
    80002858:	e822                	sd	s0,16(sp)
    8000285a:	1000                	addi	s0,sp,32
  push_off();
    8000285c:	bcdfe0ef          	jal	80001428 <push_off>
  struct cpu *c = mycpu();
    80002860:	fbfff0ef          	jal	8000281e <mycpu>
    80002864:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002868:	fe843783          	ld	a5,-24(s0)
    8000286c:	639c                	ld	a5,0(a5)
    8000286e:	fef43023          	sd	a5,-32(s0)
  pop_off();
    80002872:	bfbfe0ef          	jal	8000146c <pop_off>
  return p;
    80002876:	fe043783          	ld	a5,-32(s0)
}
    8000287a:	853e                	mv	a0,a5
    8000287c:	60e2                	ld	ra,24(sp)
    8000287e:	6442                	ld	s0,16(sp)
    80002880:	6105                	addi	sp,sp,32
    80002882:	8082                	ret

0000000080002884 <allocpid>:

int
allocpid()
{
    80002884:	1101                	addi	sp,sp,-32
    80002886:	ec06                	sd	ra,24(sp)
    80002888:	e822                	sd	s0,16(sp)
    8000288a:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    8000288c:	00016517          	auipc	a0,0x16
    80002890:	fbc50513          	addi	a0,a0,-68 # 80018848 <pid_lock>
    80002894:	ab7fe0ef          	jal	8000134a <acquire>
  pid = nextpid;
    80002898:	00008797          	auipc	a5,0x8
    8000289c:	f3878793          	addi	a5,a5,-200 # 8000a7d0 <nextpid>
    800028a0:	439c                	lw	a5,0(a5)
    800028a2:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    800028a6:	00008797          	auipc	a5,0x8
    800028aa:	f2a78793          	addi	a5,a5,-214 # 8000a7d0 <nextpid>
    800028ae:	439c                	lw	a5,0(a5)
    800028b0:	2785                	addiw	a5,a5,1
    800028b2:	0007871b          	sext.w	a4,a5
    800028b6:	00008797          	auipc	a5,0x8
    800028ba:	f1a78793          	addi	a5,a5,-230 # 8000a7d0 <nextpid>
    800028be:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800028c0:	00016517          	auipc	a0,0x16
    800028c4:	f8850513          	addi	a0,a0,-120 # 80018848 <pid_lock>
    800028c8:	ad7fe0ef          	jal	8000139e <release>

  return pid;
    800028cc:	fec42783          	lw	a5,-20(s0)
}
    800028d0:	853e                	mv	a0,a5
    800028d2:	60e2                	ld	ra,24(sp)
    800028d4:	6442                	ld	s0,16(sp)
    800028d6:	6105                	addi	sp,sp,32
    800028d8:	8082                	ret

00000000800028da <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    800028da:	1101                	addi	sp,sp,-32
    800028dc:	ec06                	sd	ra,24(sp)
    800028de:	e822                	sd	s0,16(sp)
    800028e0:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800028e2:	00010797          	auipc	a5,0x10
    800028e6:	56678793          	addi	a5,a5,1382 # 80012e48 <proc>
    800028ea:	fef43423          	sd	a5,-24(s0)
    800028ee:	a02d                	j	80002918 <allocproc+0x3e>
    acquire(&p->lock);
    800028f0:	fe843783          	ld	a5,-24(s0)
    800028f4:	853e                	mv	a0,a5
    800028f6:	a55fe0ef          	jal	8000134a <acquire>
    if(p->state == UNUSED) {
    800028fa:	fe843783          	ld	a5,-24(s0)
    800028fe:	4f9c                	lw	a5,24(a5)
    80002900:	c795                	beqz	a5,8000292c <allocproc+0x52>
      goto found;
    } else {
      release(&p->lock);
    80002902:	fe843783          	ld	a5,-24(s0)
    80002906:	853e                	mv	a0,a5
    80002908:	a97fe0ef          	jal	8000139e <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000290c:	fe843783          	ld	a5,-24(s0)
    80002910:	16878793          	addi	a5,a5,360
    80002914:	fef43423          	sd	a5,-24(s0)
    80002918:	fe843703          	ld	a4,-24(s0)
    8000291c:	00016797          	auipc	a5,0x16
    80002920:	f2c78793          	addi	a5,a5,-212 # 80018848 <pid_lock>
    80002924:	fcf766e3          	bltu	a4,a5,800028f0 <allocproc+0x16>
    }
  }
  return 0;
    80002928:	4781                	li	a5,0
    8000292a:	a065                	j	800029d2 <allocproc+0xf8>
      goto found;
    8000292c:	0001                	nop

found:
  p->pid = allocpid();
    8000292e:	f57ff0ef          	jal	80002884 <allocpid>
    80002932:	87aa                	mv	a5,a0
    80002934:	873e                	mv	a4,a5
    80002936:	fe843783          	ld	a5,-24(s0)
    8000293a:	db98                	sw	a4,48(a5)
  p->state = USED;
    8000293c:	fe843783          	ld	a5,-24(s0)
    80002940:	4705                	li	a4,1
    80002942:	cf98                	sw	a4,24(a5)

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002944:	8c7fe0ef          	jal	8000120a <kalloc>
    80002948:	872a                	mv	a4,a0
    8000294a:	fe843783          	ld	a5,-24(s0)
    8000294e:	efb8                	sd	a4,88(a5)
    80002950:	fe843783          	ld	a5,-24(s0)
    80002954:	6fbc                	ld	a5,88(a5)
    80002956:	ef81                	bnez	a5,8000296e <allocproc+0x94>
    freeproc(p);
    80002958:	fe843503          	ld	a0,-24(s0)
    8000295c:	080000ef          	jal	800029dc <freeproc>
    release(&p->lock);
    80002960:	fe843783          	ld	a5,-24(s0)
    80002964:	853e                	mv	a0,a5
    80002966:	a39fe0ef          	jal	8000139e <release>
    return 0;
    8000296a:	4781                	li	a5,0
    8000296c:	a09d                	j	800029d2 <allocproc+0xf8>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    8000296e:	fe843503          	ld	a0,-24(s0)
    80002972:	100000ef          	jal	80002a72 <proc_pagetable>
    80002976:	872a                	mv	a4,a0
    80002978:	fe843783          	ld	a5,-24(s0)
    8000297c:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    8000297e:	fe843783          	ld	a5,-24(s0)
    80002982:	6bbc                	ld	a5,80(a5)
    80002984:	ef81                	bnez	a5,8000299c <allocproc+0xc2>
    freeproc(p);
    80002986:	fe843503          	ld	a0,-24(s0)
    8000298a:	052000ef          	jal	800029dc <freeproc>
    release(&p->lock);
    8000298e:	fe843783          	ld	a5,-24(s0)
    80002992:	853e                	mv	a0,a5
    80002994:	a0bfe0ef          	jal	8000139e <release>
    return 0;
    80002998:	4781                	li	a5,0
    8000299a:	a825                	j	800029d2 <allocproc+0xf8>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    8000299c:	fe843783          	ld	a5,-24(s0)
    800029a0:	06078793          	addi	a5,a5,96
    800029a4:	07000613          	li	a2,112
    800029a8:	4581                	li	a1,0
    800029aa:	853e                	mv	a0,a5
    800029ac:	b2bfe0ef          	jal	800014d6 <memset>
  p->context.ra = (uint64)forkret;
    800029b0:	00001717          	auipc	a4,0x1
    800029b4:	87670713          	addi	a4,a4,-1930 # 80003226 <forkret>
    800029b8:	fe843783          	ld	a5,-24(s0)
    800029bc:	f3b8                	sd	a4,96(a5)
  p->context.sp = p->kstack + PGSIZE;
    800029be:	fe843783          	ld	a5,-24(s0)
    800029c2:	63b8                	ld	a4,64(a5)
    800029c4:	6785                	lui	a5,0x1
    800029c6:	973e                	add	a4,a4,a5
    800029c8:	fe843783          	ld	a5,-24(s0)
    800029cc:	f7b8                	sd	a4,104(a5)

  return p;
    800029ce:	fe843783          	ld	a5,-24(s0)
}
    800029d2:	853e                	mv	a0,a5
    800029d4:	60e2                	ld	ra,24(sp)
    800029d6:	6442                	ld	s0,16(sp)
    800029d8:	6105                	addi	sp,sp,32
    800029da:	8082                	ret

00000000800029dc <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    800029dc:	1101                	addi	sp,sp,-32
    800029de:	ec06                	sd	ra,24(sp)
    800029e0:	e822                	sd	s0,16(sp)
    800029e2:	1000                	addi	s0,sp,32
    800029e4:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    800029e8:	fe843783          	ld	a5,-24(s0)
    800029ec:	6fbc                	ld	a5,88(a5)
    800029ee:	c799                	beqz	a5,800029fc <freeproc+0x20>
    kfree((void*)p->trapframe);
    800029f0:	fe843783          	ld	a5,-24(s0)
    800029f4:	6fbc                	ld	a5,88(a5)
    800029f6:	853e                	mv	a0,a5
    800029f8:	f7efe0ef          	jal	80001176 <kfree>
  p->trapframe = 0;
    800029fc:	fe843783          	ld	a5,-24(s0)
    80002a00:	0407bc23          	sd	zero,88(a5) # 1058 <_entry-0x7fffefa8>
  if(p->pagetable)
    80002a04:	fe843783          	ld	a5,-24(s0)
    80002a08:	6bbc                	ld	a5,80(a5)
    80002a0a:	cb99                	beqz	a5,80002a20 <freeproc+0x44>
    proc_freepagetable(p->pagetable, p->sz);
    80002a0c:	fe843783          	ld	a5,-24(s0)
    80002a10:	6bb8                	ld	a4,80(a5)
    80002a12:	fe843783          	ld	a5,-24(s0)
    80002a16:	67bc                	ld	a5,72(a5)
    80002a18:	85be                	mv	a1,a5
    80002a1a:	853a                	mv	a0,a4
    80002a1c:	0fe000ef          	jal	80002b1a <proc_freepagetable>
  p->pagetable = 0;
    80002a20:	fe843783          	ld	a5,-24(s0)
    80002a24:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80002a28:	fe843783          	ld	a5,-24(s0)
    80002a2c:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80002a30:	fe843783          	ld	a5,-24(s0)
    80002a34:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002a38:	fe843783          	ld	a5,-24(s0)
    80002a3c:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80002a40:	fe843783          	ld	a5,-24(s0)
    80002a44:	14078c23          	sb	zero,344(a5)
  p->chan = 0;
    80002a48:	fe843783          	ld	a5,-24(s0)
    80002a4c:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002a50:	fe843783          	ld	a5,-24(s0)
    80002a54:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002a58:	fe843783          	ld	a5,-24(s0)
    80002a5c:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002a60:	fe843783          	ld	a5,-24(s0)
    80002a64:	0007ac23          	sw	zero,24(a5)
}
    80002a68:	0001                	nop
    80002a6a:	60e2                	ld	ra,24(sp)
    80002a6c:	6442                	ld	s0,16(sp)
    80002a6e:	6105                	addi	sp,sp,32
    80002a70:	8082                	ret

0000000080002a72 <proc_pagetable>:

// Create a user page table for a given process, with no user memory,
// but with trampoline and trapframe pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002a72:	7179                	addi	sp,sp,-48
    80002a74:	f406                	sd	ra,40(sp)
    80002a76:	f022                	sd	s0,32(sp)
    80002a78:	1800                	addi	s0,sp,48
    80002a7a:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002a7e:	af2ff0ef          	jal	80001d70 <uvmcreate>
    80002a82:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002a86:	fe843783          	ld	a5,-24(s0)
    80002a8a:	e399                	bnez	a5,80002a90 <proc_pagetable+0x1e>
    return 0;
    80002a8c:	4781                	li	a5,0
    80002a8e:	a049                	j	80002b10 <proc_pagetable+0x9e>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002a90:	00006797          	auipc	a5,0x6
    80002a94:	57078793          	addi	a5,a5,1392 # 80009000 <_trampoline>
    80002a98:	4729                	li	a4,10
    80002a9a:	86be                	mv	a3,a5
    80002a9c:	6605                	lui	a2,0x1
    80002a9e:	040007b7          	lui	a5,0x4000
    80002aa2:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002aa4:	00c79593          	slli	a1,a5,0xc
    80002aa8:	fe843503          	ld	a0,-24(s0)
    80002aac:	9caff0ef          	jal	80001c76 <mappages>
    80002ab0:	87aa                	mv	a5,a0
    80002ab2:	0007d963          	bgez	a5,80002ac4 <proc_pagetable+0x52>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002ab6:	4581                	li	a1,0
    80002ab8:	fe843503          	ld	a0,-24(s0)
    80002abc:	db4ff0ef          	jal	80002070 <uvmfree>
    return 0;
    80002ac0:	4781                	li	a5,0
    80002ac2:	a0b9                	j	80002b10 <proc_pagetable+0x9e>
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002ac4:	fd843783          	ld	a5,-40(s0)
    80002ac8:	6fbc                	ld	a5,88(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002aca:	4719                	li	a4,6
    80002acc:	86be                	mv	a3,a5
    80002ace:	6605                	lui	a2,0x1
    80002ad0:	020007b7          	lui	a5,0x2000
    80002ad4:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002ad6:	00d79593          	slli	a1,a5,0xd
    80002ada:	fe843503          	ld	a0,-24(s0)
    80002ade:	998ff0ef          	jal	80001c76 <mappages>
    80002ae2:	87aa                	mv	a5,a0
    80002ae4:	0207d463          	bgez	a5,80002b0c <proc_pagetable+0x9a>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002ae8:	4681                	li	a3,0
    80002aea:	4605                	li	a2,1
    80002aec:	040007b7          	lui	a5,0x4000
    80002af0:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002af2:	00c79593          	slli	a1,a5,0xc
    80002af6:	fe843503          	ld	a0,-24(s0)
    80002afa:	aaaff0ef          	jal	80001da4 <uvmunmap>
    uvmfree(pagetable, 0);
    80002afe:	4581                	li	a1,0
    80002b00:	fe843503          	ld	a0,-24(s0)
    80002b04:	d6cff0ef          	jal	80002070 <uvmfree>
    return 0;
    80002b08:	4781                	li	a5,0
    80002b0a:	a019                	j	80002b10 <proc_pagetable+0x9e>
  }

  return pagetable;
    80002b0c:	fe843783          	ld	a5,-24(s0)
}
    80002b10:	853e                	mv	a0,a5
    80002b12:	70a2                	ld	ra,40(sp)
    80002b14:	7402                	ld	s0,32(sp)
    80002b16:	6145                	addi	sp,sp,48
    80002b18:	8082                	ret

0000000080002b1a <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002b1a:	1101                	addi	sp,sp,-32
    80002b1c:	ec06                	sd	ra,24(sp)
    80002b1e:	e822                	sd	s0,16(sp)
    80002b20:	1000                	addi	s0,sp,32
    80002b22:	fea43423          	sd	a0,-24(s0)
    80002b26:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002b2a:	4681                	li	a3,0
    80002b2c:	4605                	li	a2,1
    80002b2e:	040007b7          	lui	a5,0x4000
    80002b32:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002b34:	00c79593          	slli	a1,a5,0xc
    80002b38:	fe843503          	ld	a0,-24(s0)
    80002b3c:	a68ff0ef          	jal	80001da4 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002b40:	4681                	li	a3,0
    80002b42:	4605                	li	a2,1
    80002b44:	020007b7          	lui	a5,0x2000
    80002b48:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002b4a:	00d79593          	slli	a1,a5,0xd
    80002b4e:	fe843503          	ld	a0,-24(s0)
    80002b52:	a52ff0ef          	jal	80001da4 <uvmunmap>
  uvmfree(pagetable, sz);
    80002b56:	fe043583          	ld	a1,-32(s0)
    80002b5a:	fe843503          	ld	a0,-24(s0)
    80002b5e:	d12ff0ef          	jal	80002070 <uvmfree>
}
    80002b62:	0001                	nop
    80002b64:	60e2                	ld	ra,24(sp)
    80002b66:	6442                	ld	s0,16(sp)
    80002b68:	6105                	addi	sp,sp,32
    80002b6a:	8082                	ret

0000000080002b6c <userinit>:

// Set up first user process.
void
userinit(void)
{
    80002b6c:	1101                	addi	sp,sp,-32
    80002b6e:	ec06                	sd	ra,24(sp)
    80002b70:	e822                	sd	s0,16(sp)
    80002b72:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002b74:	d67ff0ef          	jal	800028da <allocproc>
    80002b78:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002b7c:	00008797          	auipc	a5,0x8
    80002b80:	db478793          	addi	a5,a5,-588 # 8000a930 <initproc>
    80002b84:	fe843703          	ld	a4,-24(s0)
    80002b88:	e398                	sd	a4,0(a5)
  
  p->cwd = namei("/");
    80002b8a:	00007517          	auipc	a0,0x7
    80002b8e:	5ee50513          	addi	a0,a0,1518 # 8000a178 <etext+0x178>
    80002b92:	09a030ef          	jal	80005c2c <namei>
    80002b96:	872a                	mv	a4,a0
    80002b98:	fe843783          	ld	a5,-24(s0)
    80002b9c:	14e7b823          	sd	a4,336(a5)

  p->state = RUNNABLE;
    80002ba0:	fe843783          	ld	a5,-24(s0)
    80002ba4:	470d                	li	a4,3
    80002ba6:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002ba8:	fe843783          	ld	a5,-24(s0)
    80002bac:	853e                	mv	a0,a5
    80002bae:	ff0fe0ef          	jal	8000139e <release>
}
    80002bb2:	0001                	nop
    80002bb4:	60e2                	ld	ra,24(sp)
    80002bb6:	6442                	ld	s0,16(sp)
    80002bb8:	6105                	addi	sp,sp,32
    80002bba:	8082                	ret

0000000080002bbc <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002bbc:	7179                	addi	sp,sp,-48
    80002bbe:	f406                	sd	ra,40(sp)
    80002bc0:	f022                	sd	s0,32(sp)
    80002bc2:	1800                	addi	s0,sp,48
    80002bc4:	87aa                	mv	a5,a0
    80002bc6:	fcf42e23          	sw	a5,-36(s0)
  uint64 sz;
  struct proc *p = myproc();
    80002bca:	c8bff0ef          	jal	80002854 <myproc>
    80002bce:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002bd2:	fe043783          	ld	a5,-32(s0)
    80002bd6:	67bc                	ld	a5,72(a5)
    80002bd8:	fef43423          	sd	a5,-24(s0)
  if(n > 0){
    80002bdc:	fdc42783          	lw	a5,-36(s0)
    80002be0:	2781                	sext.w	a5,a5
    80002be2:	04f05463          	blez	a5,80002c2a <growproc+0x6e>
    if(sz + n > TRAPFRAME) {
    80002be6:	fdc42703          	lw	a4,-36(s0)
    80002bea:	fe843783          	ld	a5,-24(s0)
    80002bee:	973e                	add	a4,a4,a5
    80002bf0:	020007b7          	lui	a5,0x2000
    80002bf4:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002bf6:	07b6                	slli	a5,a5,0xd
    80002bf8:	00e7f463          	bgeu	a5,a4,80002c00 <growproc+0x44>
      return -1;
    80002bfc:	57fd                	li	a5,-1
    80002bfe:	a08d                	j	80002c60 <growproc+0xa4>
    }
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80002c00:	fe043783          	ld	a5,-32(s0)
    80002c04:	6ba8                	ld	a0,80(a5)
    80002c06:	fdc42703          	lw	a4,-36(s0)
    80002c0a:	fe843783          	ld	a5,-24(s0)
    80002c0e:	97ba                	add	a5,a5,a4
    80002c10:	4691                	li	a3,4
    80002c12:	863e                	mv	a2,a5
    80002c14:	fe843583          	ld	a1,-24(s0)
    80002c18:	a48ff0ef          	jal	80001e60 <uvmalloc>
    80002c1c:	fea43423          	sd	a0,-24(s0)
    80002c20:	fe843783          	ld	a5,-24(s0)
    80002c24:	eb85                	bnez	a5,80002c54 <growproc+0x98>
      return -1;
    80002c26:	57fd                	li	a5,-1
    80002c28:	a825                	j	80002c60 <growproc+0xa4>
    }
  } else if(n < 0){
    80002c2a:	fdc42783          	lw	a5,-36(s0)
    80002c2e:	2781                	sext.w	a5,a5
    80002c30:	0207d263          	bgez	a5,80002c54 <growproc+0x98>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002c34:	fe043783          	ld	a5,-32(s0)
    80002c38:	6bb4                	ld	a3,80(a5)
    80002c3a:	fdc42703          	lw	a4,-36(s0)
    80002c3e:	fe843783          	ld	a5,-24(s0)
    80002c42:	97ba                	add	a5,a5,a4
    80002c44:	863e                	mv	a2,a5
    80002c46:	fe843583          	ld	a1,-24(s0)
    80002c4a:	8536                	mv	a0,a3
    80002c4c:	aeeff0ef          	jal	80001f3a <uvmdealloc>
    80002c50:	fea43423          	sd	a0,-24(s0)
  }
  p->sz = sz;
    80002c54:	fe043783          	ld	a5,-32(s0)
    80002c58:	fe843703          	ld	a4,-24(s0)
    80002c5c:	e7b8                	sd	a4,72(a5)
  return 0;
    80002c5e:	4781                	li	a5,0
}
    80002c60:	853e                	mv	a0,a5
    80002c62:	70a2                	ld	ra,40(sp)
    80002c64:	7402                	ld	s0,32(sp)
    80002c66:	6145                	addi	sp,sp,48
    80002c68:	8082                	ret

0000000080002c6a <kfork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
kfork(void)
{
    80002c6a:	7179                	addi	sp,sp,-48
    80002c6c:	f406                	sd	ra,40(sp)
    80002c6e:	f022                	sd	s0,32(sp)
    80002c70:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002c72:	be3ff0ef          	jal	80002854 <myproc>
    80002c76:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002c7a:	c61ff0ef          	jal	800028da <allocproc>
    80002c7e:	fca43c23          	sd	a0,-40(s0)
    80002c82:	fd843783          	ld	a5,-40(s0)
    80002c86:	e399                	bnez	a5,80002c8c <kfork+0x22>
    return -1;
    80002c88:	57fd                	li	a5,-1
    80002c8a:	a2b1                	j	80002dd6 <kfork+0x16c>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002c8c:	fe043783          	ld	a5,-32(s0)
    80002c90:	6bb8                	ld	a4,80(a5)
    80002c92:	fd843783          	ld	a5,-40(s0)
    80002c96:	6bb4                	ld	a3,80(a5)
    80002c98:	fe043783          	ld	a5,-32(s0)
    80002c9c:	67bc                	ld	a5,72(a5)
    80002c9e:	863e                	mv	a2,a5
    80002ca0:	85b6                	mv	a1,a3
    80002ca2:	853a                	mv	a0,a4
    80002ca4:	c0eff0ef          	jal	800020b2 <uvmcopy>
    80002ca8:	87aa                	mv	a5,a0
    80002caa:	0007dd63          	bgez	a5,80002cc4 <kfork+0x5a>
    freeproc(np);
    80002cae:	fd843503          	ld	a0,-40(s0)
    80002cb2:	d2bff0ef          	jal	800029dc <freeproc>
    release(&np->lock);
    80002cb6:	fd843783          	ld	a5,-40(s0)
    80002cba:	853e                	mv	a0,a5
    80002cbc:	ee2fe0ef          	jal	8000139e <release>
    return -1;
    80002cc0:	57fd                	li	a5,-1
    80002cc2:	aa11                	j	80002dd6 <kfork+0x16c>
  }
  np->sz = p->sz;
    80002cc4:	fe043783          	ld	a5,-32(s0)
    80002cc8:	67b8                	ld	a4,72(a5)
    80002cca:	fd843783          	ld	a5,-40(s0)
    80002cce:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002cd0:	fe043783          	ld	a5,-32(s0)
    80002cd4:	6fb8                	ld	a4,88(a5)
    80002cd6:	fd843783          	ld	a5,-40(s0)
    80002cda:	6fbc                	ld	a5,88(a5)
    80002cdc:	86be                	mv	a3,a5
    80002cde:	12000793          	li	a5,288
    80002ce2:	863e                	mv	a2,a5
    80002ce4:	85ba                	mv	a1,a4
    80002ce6:	8536                	mv	a0,a3
    80002ce8:	9bbfe0ef          	jal	800016a2 <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002cec:	fd843783          	ld	a5,-40(s0)
    80002cf0:	6fbc                	ld	a5,88(a5)
    80002cf2:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002cf6:	fe042623          	sw	zero,-20(s0)
    80002cfa:	a099                	j	80002d40 <kfork+0xd6>
    if(p->ofile[i])
    80002cfc:	fe043703          	ld	a4,-32(s0)
    80002d00:	fec42783          	lw	a5,-20(s0)
    80002d04:	07e9                	addi	a5,a5,26
    80002d06:	078e                	slli	a5,a5,0x3
    80002d08:	97ba                	add	a5,a5,a4
    80002d0a:	639c                	ld	a5,0(a5)
    80002d0c:	c78d                	beqz	a5,80002d36 <kfork+0xcc>
      np->ofile[i] = filedup(p->ofile[i]);
    80002d0e:	fe043703          	ld	a4,-32(s0)
    80002d12:	fec42783          	lw	a5,-20(s0)
    80002d16:	07e9                	addi	a5,a5,26
    80002d18:	078e                	slli	a5,a5,0x3
    80002d1a:	97ba                	add	a5,a5,a4
    80002d1c:	639c                	ld	a5,0(a5)
    80002d1e:	853e                	mv	a0,a5
    80002d20:	78e030ef          	jal	800064ae <filedup>
    80002d24:	86aa                	mv	a3,a0
    80002d26:	fd843703          	ld	a4,-40(s0)
    80002d2a:	fec42783          	lw	a5,-20(s0)
    80002d2e:	07e9                	addi	a5,a5,26
    80002d30:	078e                	slli	a5,a5,0x3
    80002d32:	97ba                	add	a5,a5,a4
    80002d34:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80002d36:	fec42783          	lw	a5,-20(s0)
    80002d3a:	2785                	addiw	a5,a5,1
    80002d3c:	fef42623          	sw	a5,-20(s0)
    80002d40:	fec42783          	lw	a5,-20(s0)
    80002d44:	0007871b          	sext.w	a4,a5
    80002d48:	47bd                	li	a5,15
    80002d4a:	fae7d9e3          	bge	a5,a4,80002cfc <kfork+0x92>
  np->cwd = idup(p->cwd);
    80002d4e:	fe043783          	ld	a5,-32(s0)
    80002d52:	1507b783          	ld	a5,336(a5)
    80002d56:	853e                	mv	a0,a5
    80002d58:	19c020ef          	jal	80004ef4 <idup>
    80002d5c:	872a                	mv	a4,a0
    80002d5e:	fd843783          	ld	a5,-40(s0)
    80002d62:	14e7b823          	sd	a4,336(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80002d66:	fd843783          	ld	a5,-40(s0)
    80002d6a:	15878713          	addi	a4,a5,344
    80002d6e:	fe043783          	ld	a5,-32(s0)
    80002d72:	15878793          	addi	a5,a5,344
    80002d76:	4641                	li	a2,16
    80002d78:	85be                	mv	a1,a5
    80002d7a:	853a                	mv	a0,a4
    80002d7c:	a6ffe0ef          	jal	800017ea <safestrcpy>

  pid = np->pid;
    80002d80:	fd843783          	ld	a5,-40(s0)
    80002d84:	5b9c                	lw	a5,48(a5)
    80002d86:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80002d8a:	fd843783          	ld	a5,-40(s0)
    80002d8e:	853e                	mv	a0,a5
    80002d90:	e0efe0ef          	jal	8000139e <release>

  acquire(&wait_lock);
    80002d94:	00016517          	auipc	a0,0x16
    80002d98:	acc50513          	addi	a0,a0,-1332 # 80018860 <wait_lock>
    80002d9c:	daefe0ef          	jal	8000134a <acquire>
  np->parent = p;
    80002da0:	fd843783          	ld	a5,-40(s0)
    80002da4:	fe043703          	ld	a4,-32(s0)
    80002da8:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80002daa:	00016517          	auipc	a0,0x16
    80002dae:	ab650513          	addi	a0,a0,-1354 # 80018860 <wait_lock>
    80002db2:	decfe0ef          	jal	8000139e <release>

  acquire(&np->lock);
    80002db6:	fd843783          	ld	a5,-40(s0)
    80002dba:	853e                	mv	a0,a5
    80002dbc:	d8efe0ef          	jal	8000134a <acquire>
  np->state = RUNNABLE;
    80002dc0:	fd843783          	ld	a5,-40(s0)
    80002dc4:	470d                	li	a4,3
    80002dc6:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80002dc8:	fd843783          	ld	a5,-40(s0)
    80002dcc:	853e                	mv	a0,a5
    80002dce:	dd0fe0ef          	jal	8000139e <release>

  return pid;
    80002dd2:	fd442783          	lw	a5,-44(s0)
}
    80002dd6:	853e                	mv	a0,a5
    80002dd8:	70a2                	ld	ra,40(sp)
    80002dda:	7402                	ld	s0,32(sp)
    80002ddc:	6145                	addi	sp,sp,48
    80002dde:	8082                	ret

0000000080002de0 <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    80002de0:	7179                	addi	sp,sp,-48
    80002de2:	f406                	sd	ra,40(sp)
    80002de4:	f022                	sd	s0,32(sp)
    80002de6:	1800                	addi	s0,sp,48
    80002de8:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002dec:	00010797          	auipc	a5,0x10
    80002df0:	05c78793          	addi	a5,a5,92 # 80012e48 <proc>
    80002df4:	fef43423          	sd	a5,-24(s0)
    80002df8:	a835                	j	80002e34 <reparent+0x54>
    if(pp->parent == p){
    80002dfa:	fe843783          	ld	a5,-24(s0)
    80002dfe:	7f9c                	ld	a5,56(a5)
    80002e00:	fd843703          	ld	a4,-40(s0)
    80002e04:	02f71263          	bne	a4,a5,80002e28 <reparent+0x48>
      pp->parent = initproc;
    80002e08:	00008797          	auipc	a5,0x8
    80002e0c:	b2878793          	addi	a5,a5,-1240 # 8000a930 <initproc>
    80002e10:	6398                	ld	a4,0(a5)
    80002e12:	fe843783          	ld	a5,-24(s0)
    80002e16:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    80002e18:	00008797          	auipc	a5,0x8
    80002e1c:	b1878793          	addi	a5,a5,-1256 # 8000a930 <initproc>
    80002e20:	639c                	ld	a5,0(a5)
    80002e22:	853e                	mv	a0,a5
    80002e24:	536000ef          	jal	8000335a <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002e28:	fe843783          	ld	a5,-24(s0)
    80002e2c:	16878793          	addi	a5,a5,360
    80002e30:	fef43423          	sd	a5,-24(s0)
    80002e34:	fe843703          	ld	a4,-24(s0)
    80002e38:	00016797          	auipc	a5,0x16
    80002e3c:	a1078793          	addi	a5,a5,-1520 # 80018848 <pid_lock>
    80002e40:	faf76de3          	bltu	a4,a5,80002dfa <reparent+0x1a>
    }
  }
}
    80002e44:	0001                	nop
    80002e46:	0001                	nop
    80002e48:	70a2                	ld	ra,40(sp)
    80002e4a:	7402                	ld	s0,32(sp)
    80002e4c:	6145                	addi	sp,sp,48
    80002e4e:	8082                	ret

0000000080002e50 <kexit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
kexit(int status)
{
    80002e50:	7139                	addi	sp,sp,-64
    80002e52:	fc06                	sd	ra,56(sp)
    80002e54:	f822                	sd	s0,48(sp)
    80002e56:	0080                	addi	s0,sp,64
    80002e58:	87aa                	mv	a5,a0
    80002e5a:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80002e5e:	9f7ff0ef          	jal	80002854 <myproc>
    80002e62:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80002e66:	00008797          	auipc	a5,0x8
    80002e6a:	aca78793          	addi	a5,a5,-1334 # 8000a930 <initproc>
    80002e6e:	639c                	ld	a5,0(a5)
    80002e70:	fe043703          	ld	a4,-32(s0)
    80002e74:	00f71863          	bne	a4,a5,80002e84 <kexit+0x34>
    panic("init exiting");
    80002e78:	00007517          	auipc	a0,0x7
    80002e7c:	30850513          	addi	a0,a0,776 # 8000a180 <etext+0x180>
    80002e80:	fb7fd0ef          	jal	80000e36 <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80002e84:	fe042623          	sw	zero,-20(s0)
    80002e88:	a0b1                	j	80002ed4 <kexit+0x84>
    if(p->ofile[fd]){
    80002e8a:	fe043703          	ld	a4,-32(s0)
    80002e8e:	fec42783          	lw	a5,-20(s0)
    80002e92:	07e9                	addi	a5,a5,26
    80002e94:	078e                	slli	a5,a5,0x3
    80002e96:	97ba                	add	a5,a5,a4
    80002e98:	639c                	ld	a5,0(a5)
    80002e9a:	cb85                	beqz	a5,80002eca <kexit+0x7a>
      struct file *f = p->ofile[fd];
    80002e9c:	fe043703          	ld	a4,-32(s0)
    80002ea0:	fec42783          	lw	a5,-20(s0)
    80002ea4:	07e9                	addi	a5,a5,26
    80002ea6:	078e                	slli	a5,a5,0x3
    80002ea8:	97ba                	add	a5,a5,a4
    80002eaa:	639c                	ld	a5,0(a5)
    80002eac:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    80002eb0:	fd843503          	ld	a0,-40(s0)
    80002eb4:	654030ef          	jal	80006508 <fileclose>
      p->ofile[fd] = 0;
    80002eb8:	fe043703          	ld	a4,-32(s0)
    80002ebc:	fec42783          	lw	a5,-20(s0)
    80002ec0:	07e9                	addi	a5,a5,26
    80002ec2:	078e                	slli	a5,a5,0x3
    80002ec4:	97ba                	add	a5,a5,a4
    80002ec6:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80002eca:	fec42783          	lw	a5,-20(s0)
    80002ece:	2785                	addiw	a5,a5,1
    80002ed0:	fef42623          	sw	a5,-20(s0)
    80002ed4:	fec42783          	lw	a5,-20(s0)
    80002ed8:	0007871b          	sext.w	a4,a5
    80002edc:	47bd                	li	a5,15
    80002ede:	fae7d6e3          	bge	a5,a4,80002e8a <kexit+0x3a>
    }
  }

  begin_op();
    80002ee2:	06c030ef          	jal	80005f4e <begin_op>
  iput(p->cwd);
    80002ee6:	fe043783          	ld	a5,-32(s0)
    80002eea:	1507b783          	ld	a5,336(a5)
    80002eee:	853e                	mv	a0,a5
    80002ef0:	1b2020ef          	jal	800050a2 <iput>
  end_op();
    80002ef4:	10c030ef          	jal	80006000 <end_op>
  p->cwd = 0;
    80002ef8:	fe043783          	ld	a5,-32(s0)
    80002efc:	1407b823          	sd	zero,336(a5)

  acquire(&wait_lock);
    80002f00:	00016517          	auipc	a0,0x16
    80002f04:	96050513          	addi	a0,a0,-1696 # 80018860 <wait_lock>
    80002f08:	c42fe0ef          	jal	8000134a <acquire>

  // Give any children to init.
  reparent(p);
    80002f0c:	fe043503          	ld	a0,-32(s0)
    80002f10:	ed1ff0ef          	jal	80002de0 <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    80002f14:	fe043783          	ld	a5,-32(s0)
    80002f18:	7f9c                	ld	a5,56(a5)
    80002f1a:	853e                	mv	a0,a5
    80002f1c:	43e000ef          	jal	8000335a <wakeup>
  
  acquire(&p->lock);
    80002f20:	fe043783          	ld	a5,-32(s0)
    80002f24:	853e                	mv	a0,a5
    80002f26:	c24fe0ef          	jal	8000134a <acquire>

  p->xstate = status;
    80002f2a:	fe043783          	ld	a5,-32(s0)
    80002f2e:	fcc42703          	lw	a4,-52(s0)
    80002f32:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    80002f34:	fe043783          	ld	a5,-32(s0)
    80002f38:	4715                	li	a4,5
    80002f3a:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80002f3c:	00016517          	auipc	a0,0x16
    80002f40:	92450513          	addi	a0,a0,-1756 # 80018860 <wait_lock>
    80002f44:	c5afe0ef          	jal	8000139e <release>

  // Jump into the scheduler, never to return.
  sched();
    80002f48:	1f6000ef          	jal	8000313e <sched>
  panic("zombie exit");
    80002f4c:	00007517          	auipc	a0,0x7
    80002f50:	24450513          	addi	a0,a0,580 # 8000a190 <etext+0x190>
    80002f54:	ee3fd0ef          	jal	80000e36 <panic>

0000000080002f58 <kwait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
kwait(uint64 addr)
{
    80002f58:	7139                	addi	sp,sp,-64
    80002f5a:	fc06                	sd	ra,56(sp)
    80002f5c:	f822                	sd	s0,48(sp)
    80002f5e:	0080                	addi	s0,sp,64
    80002f60:	fca43423          	sd	a0,-56(s0)
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();
    80002f64:	8f1ff0ef          	jal	80002854 <myproc>
    80002f68:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80002f6c:	00016517          	auipc	a0,0x16
    80002f70:	8f450513          	addi	a0,a0,-1804 # 80018860 <wait_lock>
    80002f74:	bd6fe0ef          	jal	8000134a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80002f78:	fe042223          	sw	zero,-28(s0)
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002f7c:	00010797          	auipc	a5,0x10
    80002f80:	ecc78793          	addi	a5,a5,-308 # 80012e48 <proc>
    80002f84:	fef43423          	sd	a5,-24(s0)
    80002f88:	a84d                	j	8000303a <kwait+0xe2>
      if(pp->parent == p){
    80002f8a:	fe843783          	ld	a5,-24(s0)
    80002f8e:	7f9c                	ld	a5,56(a5)
    80002f90:	fd843703          	ld	a4,-40(s0)
    80002f94:	08f71d63          	bne	a4,a5,8000302e <kwait+0xd6>
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);
    80002f98:	fe843783          	ld	a5,-24(s0)
    80002f9c:	853e                	mv	a0,a5
    80002f9e:	bacfe0ef          	jal	8000134a <acquire>

        havekids = 1;
    80002fa2:	4785                	li	a5,1
    80002fa4:	fef42223          	sw	a5,-28(s0)
        if(pp->state == ZOMBIE){
    80002fa8:	fe843783          	ld	a5,-24(s0)
    80002fac:	4f98                	lw	a4,24(a5)
    80002fae:	4795                	li	a5,5
    80002fb0:	06f71a63          	bne	a4,a5,80003024 <kwait+0xcc>
          // Found one.
          pid = pp->pid;
    80002fb4:	fe843783          	ld	a5,-24(s0)
    80002fb8:	5b9c                	lw	a5,48(a5)
    80002fba:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80002fbe:	fc843783          	ld	a5,-56(s0)
    80002fc2:	cf9d                	beqz	a5,80003000 <kwait+0xa8>
    80002fc4:	fd843783          	ld	a5,-40(s0)
    80002fc8:	6bb8                	ld	a4,80(a5)
    80002fca:	fe843783          	ld	a5,-24(s0)
    80002fce:	02c78793          	addi	a5,a5,44
    80002fd2:	4691                	li	a3,4
    80002fd4:	863e                	mv	a2,a5
    80002fd6:	fc843583          	ld	a1,-56(s0)
    80002fda:	853a                	mv	a0,a4
    80002fdc:	a06ff0ef          	jal	800021e2 <copyout>
    80002fe0:	87aa                	mv	a5,a0
    80002fe2:	0007df63          	bgez	a5,80003000 <kwait+0xa8>
                                  sizeof(pp->xstate)) < 0) {
            release(&pp->lock);
    80002fe6:	fe843783          	ld	a5,-24(s0)
    80002fea:	853e                	mv	a0,a5
    80002fec:	bb2fe0ef          	jal	8000139e <release>
            release(&wait_lock);
    80002ff0:	00016517          	auipc	a0,0x16
    80002ff4:	87050513          	addi	a0,a0,-1936 # 80018860 <wait_lock>
    80002ff8:	ba6fe0ef          	jal	8000139e <release>
            return -1;
    80002ffc:	57fd                	li	a5,-1
    80002ffe:	a049                	j	80003080 <kwait+0x128>
          }
          freeproc(pp);
    80003000:	fe843503          	ld	a0,-24(s0)
    80003004:	9d9ff0ef          	jal	800029dc <freeproc>
          release(&pp->lock);
    80003008:	fe843783          	ld	a5,-24(s0)
    8000300c:	853e                	mv	a0,a5
    8000300e:	b90fe0ef          	jal	8000139e <release>
          release(&wait_lock);
    80003012:	00016517          	auipc	a0,0x16
    80003016:	84e50513          	addi	a0,a0,-1970 # 80018860 <wait_lock>
    8000301a:	b84fe0ef          	jal	8000139e <release>
          return pid;
    8000301e:	fd442783          	lw	a5,-44(s0)
    80003022:	a8b9                	j	80003080 <kwait+0x128>
        }
        release(&pp->lock);
    80003024:	fe843783          	ld	a5,-24(s0)
    80003028:	853e                	mv	a0,a5
    8000302a:	b74fe0ef          	jal	8000139e <release>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000302e:	fe843783          	ld	a5,-24(s0)
    80003032:	16878793          	addi	a5,a5,360
    80003036:	fef43423          	sd	a5,-24(s0)
    8000303a:	fe843703          	ld	a4,-24(s0)
    8000303e:	00016797          	auipc	a5,0x16
    80003042:	80a78793          	addi	a5,a5,-2038 # 80018848 <pid_lock>
    80003046:	f4f762e3          	bltu	a4,a5,80002f8a <kwait+0x32>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || killed(p)){
    8000304a:	fe442783          	lw	a5,-28(s0)
    8000304e:	2781                	sext.w	a5,a5
    80003050:	c799                	beqz	a5,8000305e <kwait+0x106>
    80003052:	fd843503          	ld	a0,-40(s0)
    80003056:	44e000ef          	jal	800034a4 <killed>
    8000305a:	87aa                	mv	a5,a0
    8000305c:	cb89                	beqz	a5,8000306e <kwait+0x116>
      release(&wait_lock);
    8000305e:	00016517          	auipc	a0,0x16
    80003062:	80250513          	addi	a0,a0,-2046 # 80018860 <wait_lock>
    80003066:	b38fe0ef          	jal	8000139e <release>
      return -1;
    8000306a:	57fd                	li	a5,-1
    8000306c:	a811                	j	80003080 <kwait+0x128>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000306e:	00015597          	auipc	a1,0x15
    80003072:	7f258593          	addi	a1,a1,2034 # 80018860 <wait_lock>
    80003076:	fd843503          	ld	a0,-40(s0)
    8000307a:	27c000ef          	jal	800032f6 <sleep>
    havekids = 0;
    8000307e:	bded                	j	80002f78 <kwait+0x20>
  }
}
    80003080:	853e                	mv	a0,a5
    80003082:	70e2                	ld	ra,56(sp)
    80003084:	7442                	ld	s0,48(sp)
    80003086:	6121                	addi	sp,sp,64
    80003088:	8082                	ret

000000008000308a <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    8000308a:	7179                	addi	sp,sp,-48
    8000308c:	f406                	sd	ra,40(sp)
    8000308e:	f022                	sd	s0,32(sp)
    80003090:	1800                	addi	s0,sp,48
  struct proc *p;
  struct cpu *c = mycpu();
    80003092:	f8cff0ef          	jal	8000281e <mycpu>
    80003096:	fca43c23          	sd	a0,-40(s0)

  c->proc = 0;
    8000309a:	fd843783          	ld	a5,-40(s0)
    8000309e:	0007b023          	sd	zero,0(a5)
    // The most recent process to run may have had interrupts
    // turned off; enable them to avoid a deadlock if all
    // processes are waiting. Then turn them back off
    // to avoid a possible race between an interrupt
    // and wfi.
    intr_on();
    800030a2:	d62ff0ef          	jal	80002604 <intr_on>
    intr_off();
    800030a6:	d80ff0ef          	jal	80002626 <intr_off>

    int found = 0;
    800030aa:	fe042223          	sw	zero,-28(s0)
    for(p = proc; p < &proc[NPROC]; p++) {
    800030ae:	00010797          	auipc	a5,0x10
    800030b2:	d9a78793          	addi	a5,a5,-614 # 80012e48 <proc>
    800030b6:	fef43423          	sd	a5,-24(s0)
    800030ba:	a09d                	j	80003120 <scheduler+0x96>
      acquire(&p->lock);
    800030bc:	fe843783          	ld	a5,-24(s0)
    800030c0:	853e                	mv	a0,a5
    800030c2:	a88fe0ef          	jal	8000134a <acquire>
      if(p->state == RUNNABLE) {
    800030c6:	fe843783          	ld	a5,-24(s0)
    800030ca:	4f98                	lw	a4,24(a5)
    800030cc:	478d                	li	a5,3
    800030ce:	02f71e63          	bne	a4,a5,8000310a <scheduler+0x80>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    800030d2:	fe843783          	ld	a5,-24(s0)
    800030d6:	4711                	li	a4,4
    800030d8:	cf98                	sw	a4,24(a5)
        c->proc = p;
    800030da:	fd843783          	ld	a5,-40(s0)
    800030de:	fe843703          	ld	a4,-24(s0)
    800030e2:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    800030e4:	fd843783          	ld	a5,-40(s0)
    800030e8:	00878713          	addi	a4,a5,8
    800030ec:	fe843783          	ld	a5,-24(s0)
    800030f0:	06078793          	addi	a5,a5,96
    800030f4:	85be                	mv	a1,a5
    800030f6:	853a                	mv	a0,a4
    800030f8:	588000ef          	jal	80003680 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    800030fc:	fd843783          	ld	a5,-40(s0)
    80003100:	0007b023          	sd	zero,0(a5)
        found = 1;
    80003104:	4785                	li	a5,1
    80003106:	fef42223          	sw	a5,-28(s0)
      }
      release(&p->lock);
    8000310a:	fe843783          	ld	a5,-24(s0)
    8000310e:	853e                	mv	a0,a5
    80003110:	a8efe0ef          	jal	8000139e <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003114:	fe843783          	ld	a5,-24(s0)
    80003118:	16878793          	addi	a5,a5,360
    8000311c:	fef43423          	sd	a5,-24(s0)
    80003120:	fe843703          	ld	a4,-24(s0)
    80003124:	00015797          	auipc	a5,0x15
    80003128:	72478793          	addi	a5,a5,1828 # 80018848 <pid_lock>
    8000312c:	f8f768e3          	bltu	a4,a5,800030bc <scheduler+0x32>
    }
    if(found == 0) {
    80003130:	fe442783          	lw	a5,-28(s0)
    80003134:	2781                	sext.w	a5,a5
    80003136:	f7b5                	bnez	a5,800030a2 <scheduler+0x18>
      // nothing to run; stop running on this core until an interrupt.
      asm volatile("wfi");
    80003138:	10500073          	wfi
  for(;;){
    8000313c:	b79d                	j	800030a2 <scheduler+0x18>

000000008000313e <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    8000313e:	7179                	addi	sp,sp,-48
    80003140:	f406                	sd	ra,40(sp)
    80003142:	f022                	sd	s0,32(sp)
    80003144:	ec26                	sd	s1,24(sp)
    80003146:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    80003148:	f0cff0ef          	jal	80002854 <myproc>
    8000314c:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    80003150:	fd843783          	ld	a5,-40(s0)
    80003154:	853e                	mv	a0,a5
    80003156:	a92fe0ef          	jal	800013e8 <holding>
    8000315a:	87aa                	mv	a5,a0
    8000315c:	e799                	bnez	a5,8000316a <sched+0x2c>
    panic("sched p->lock");
    8000315e:	00007517          	auipc	a0,0x7
    80003162:	04250513          	addi	a0,a0,66 # 8000a1a0 <etext+0x1a0>
    80003166:	cd1fd0ef          	jal	80000e36 <panic>
  if(mycpu()->noff != 1)
    8000316a:	eb4ff0ef          	jal	8000281e <mycpu>
    8000316e:	87aa                	mv	a5,a0
    80003170:	5fb8                	lw	a4,120(a5)
    80003172:	4785                	li	a5,1
    80003174:	00f70863          	beq	a4,a5,80003184 <sched+0x46>
    panic("sched locks");
    80003178:	00007517          	auipc	a0,0x7
    8000317c:	03850513          	addi	a0,a0,56 # 8000a1b0 <etext+0x1b0>
    80003180:	cb7fd0ef          	jal	80000e36 <panic>
  if(p->state == RUNNING)
    80003184:	fd843783          	ld	a5,-40(s0)
    80003188:	4f98                	lw	a4,24(a5)
    8000318a:	4791                	li	a5,4
    8000318c:	00f71863          	bne	a4,a5,8000319c <sched+0x5e>
    panic("sched RUNNING");
    80003190:	00007517          	auipc	a0,0x7
    80003194:	03050513          	addi	a0,a0,48 # 8000a1c0 <etext+0x1c0>
    80003198:	c9ffd0ef          	jal	80000e36 <panic>
  if(intr_get())
    8000319c:	caaff0ef          	jal	80002646 <intr_get>
    800031a0:	87aa                	mv	a5,a0
    800031a2:	c799                	beqz	a5,800031b0 <sched+0x72>
    panic("sched interruptible");
    800031a4:	00007517          	auipc	a0,0x7
    800031a8:	02c50513          	addi	a0,a0,44 # 8000a1d0 <etext+0x1d0>
    800031ac:	c8bfd0ef          	jal	80000e36 <panic>

  intena = mycpu()->intena;
    800031b0:	e6eff0ef          	jal	8000281e <mycpu>
    800031b4:	87aa                	mv	a5,a0
    800031b6:	5ffc                	lw	a5,124(a5)
    800031b8:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    800031bc:	fd843783          	ld	a5,-40(s0)
    800031c0:	06078493          	addi	s1,a5,96
    800031c4:	e5aff0ef          	jal	8000281e <mycpu>
    800031c8:	87aa                	mv	a5,a0
    800031ca:	07a1                	addi	a5,a5,8
    800031cc:	85be                	mv	a1,a5
    800031ce:	8526                	mv	a0,s1
    800031d0:	4b0000ef          	jal	80003680 <swtch>
  mycpu()->intena = intena;
    800031d4:	e4aff0ef          	jal	8000281e <mycpu>
    800031d8:	872a                	mv	a4,a0
    800031da:	fd442783          	lw	a5,-44(s0)
    800031de:	df7c                	sw	a5,124(a4)
}
    800031e0:	0001                	nop
    800031e2:	70a2                	ld	ra,40(sp)
    800031e4:	7402                	ld	s0,32(sp)
    800031e6:	64e2                	ld	s1,24(sp)
    800031e8:	6145                	addi	sp,sp,48
    800031ea:	8082                	ret

00000000800031ec <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    800031ec:	1101                	addi	sp,sp,-32
    800031ee:	ec06                	sd	ra,24(sp)
    800031f0:	e822                	sd	s0,16(sp)
    800031f2:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800031f4:	e60ff0ef          	jal	80002854 <myproc>
    800031f8:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    800031fc:	fe843783          	ld	a5,-24(s0)
    80003200:	853e                	mv	a0,a5
    80003202:	948fe0ef          	jal	8000134a <acquire>
  p->state = RUNNABLE;
    80003206:	fe843783          	ld	a5,-24(s0)
    8000320a:	470d                	li	a4,3
    8000320c:	cf98                	sw	a4,24(a5)
  sched();
    8000320e:	f31ff0ef          	jal	8000313e <sched>
  release(&p->lock);
    80003212:	fe843783          	ld	a5,-24(s0)
    80003216:	853e                	mv	a0,a5
    80003218:	986fe0ef          	jal	8000139e <release>
}
    8000321c:	0001                	nop
    8000321e:	60e2                	ld	ra,24(sp)
    80003220:	6442                	ld	s0,16(sp)
    80003222:	6105                	addi	sp,sp,32
    80003224:	8082                	ret

0000000080003226 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80003226:	7139                	addi	sp,sp,-64
    80003228:	fc06                	sd	ra,56(sp)
    8000322a:	f822                	sd	s0,48(sp)
    8000322c:	0080                	addi	s0,sp,64
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    8000322e:	e26ff0ef          	jal	80002854 <myproc>
    80003232:	fea43423          	sd	a0,-24(s0)

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80003236:	fe843783          	ld	a5,-24(s0)
    8000323a:	853e                	mv	a0,a5
    8000323c:	962fe0ef          	jal	8000139e <release>

  if (first) {
    80003240:	00007797          	auipc	a5,0x7
    80003244:	59478793          	addi	a5,a5,1428 # 8000a7d4 <first.1>
    80003248:	439c                	lw	a5,0(a5)
    8000324a:	c3a5                	beqz	a5,800032aa <forkret+0x84>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    8000324c:	4505                	li	a0,1
    8000324e:	61a010ef          	jal	80004868 <fsinit>

    first = 0;
    80003252:	00007797          	auipc	a5,0x7
    80003256:	58278793          	addi	a5,a5,1410 # 8000a7d4 <first.1>
    8000325a:	0007a023          	sw	zero,0(a5)
    // ensure other cores see first=0.
    __sync_synchronize();
    8000325e:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80003262:	00007797          	auipc	a5,0x7
    80003266:	f8678793          	addi	a5,a5,-122 # 8000a1e8 <etext+0x1e8>
    8000326a:	fcf43423          	sd	a5,-56(s0)
    8000326e:	fc043823          	sd	zero,-48(s0)
    80003272:	fc840793          	addi	a5,s0,-56
    80003276:	85be                	mv	a1,a5
    80003278:	00007517          	auipc	a0,0x7
    8000327c:	f7050513          	addi	a0,a0,-144 # 8000a1e8 <etext+0x1e8>
    80003280:	3a1030ef          	jal	80006e20 <kexec>
    80003284:	87aa                	mv	a5,a0
    80003286:	873e                	mv	a4,a5
    80003288:	fe843783          	ld	a5,-24(s0)
    8000328c:	6fbc                	ld	a5,88(a5)
    8000328e:	fbb8                	sd	a4,112(a5)
    if (p->trapframe->a0 == -1) {
    80003290:	fe843783          	ld	a5,-24(s0)
    80003294:	6fbc                	ld	a5,88(a5)
    80003296:	7bb8                	ld	a4,112(a5)
    80003298:	57fd                	li	a5,-1
    8000329a:	00f71863          	bne	a4,a5,800032aa <forkret+0x84>
      panic("exec");
    8000329e:	00007517          	auipc	a0,0x7
    800032a2:	f5250513          	addi	a0,a0,-174 # 8000a1f0 <etext+0x1f0>
    800032a6:	b91fd0ef          	jal	80000e36 <panic>
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    800032aa:	7a4000ef          	jal	80003a4e <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    800032ae:	fe843783          	ld	a5,-24(s0)
    800032b2:	6bbc                	ld	a5,80(a5)
    800032b4:	00c7d713          	srli	a4,a5,0xc
    800032b8:	57fd                	li	a5,-1
    800032ba:	17fe                	slli	a5,a5,0x3f
    800032bc:	8fd9                	or	a5,a5,a4
    800032be:	fef43023          	sd	a5,-32(s0)
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    800032c2:	00006717          	auipc	a4,0x6
    800032c6:	dda70713          	addi	a4,a4,-550 # 8000909c <userret>
    800032ca:	00006797          	auipc	a5,0x6
    800032ce:	d3678793          	addi	a5,a5,-714 # 80009000 <_trampoline>
    800032d2:	8f1d                	sub	a4,a4,a5
    800032d4:	040007b7          	lui	a5,0x4000
    800032d8:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800032da:	07b2                	slli	a5,a5,0xc
    800032dc:	97ba                	add	a5,a5,a4
    800032de:	fcf43c23          	sd	a5,-40(s0)
  ((void (*)(uint64))trampoline_userret)(satp);
    800032e2:	fd843783          	ld	a5,-40(s0)
    800032e6:	fe043503          	ld	a0,-32(s0)
    800032ea:	9782                	jalr	a5
}
    800032ec:	0001                	nop
    800032ee:	70e2                	ld	ra,56(sp)
    800032f0:	7442                	ld	s0,48(sp)
    800032f2:	6121                	addi	sp,sp,64
    800032f4:	8082                	ret

00000000800032f6 <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800032f6:	7179                	addi	sp,sp,-48
    800032f8:	f406                	sd	ra,40(sp)
    800032fa:	f022                	sd	s0,32(sp)
    800032fc:	1800                	addi	s0,sp,48
    800032fe:	fca43c23          	sd	a0,-40(s0)
    80003302:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003306:	d4eff0ef          	jal	80002854 <myproc>
    8000330a:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000330e:	fe843783          	ld	a5,-24(s0)
    80003312:	853e                	mv	a0,a5
    80003314:	836fe0ef          	jal	8000134a <acquire>
  release(lk);
    80003318:	fd043503          	ld	a0,-48(s0)
    8000331c:	882fe0ef          	jal	8000139e <release>

  // Go to sleep.
  p->chan = chan;
    80003320:	fe843783          	ld	a5,-24(s0)
    80003324:	fd843703          	ld	a4,-40(s0)
    80003328:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    8000332a:	fe843783          	ld	a5,-24(s0)
    8000332e:	4709                	li	a4,2
    80003330:	cf98                	sw	a4,24(a5)

  sched();
    80003332:	e0dff0ef          	jal	8000313e <sched>

  // Tidy up.
  p->chan = 0;
    80003336:	fe843783          	ld	a5,-24(s0)
    8000333a:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    8000333e:	fe843783          	ld	a5,-24(s0)
    80003342:	853e                	mv	a0,a5
    80003344:	85afe0ef          	jal	8000139e <release>
  acquire(lk);
    80003348:	fd043503          	ld	a0,-48(s0)
    8000334c:	ffffd0ef          	jal	8000134a <acquire>
}
    80003350:	0001                	nop
    80003352:	70a2                	ld	ra,40(sp)
    80003354:	7402                	ld	s0,32(sp)
    80003356:	6145                	addi	sp,sp,48
    80003358:	8082                	ret

000000008000335a <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    8000335a:	7179                	addi	sp,sp,-48
    8000335c:	f406                	sd	ra,40(sp)
    8000335e:	f022                	sd	s0,32(sp)
    80003360:	1800                	addi	s0,sp,48
    80003362:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80003366:	00010797          	auipc	a5,0x10
    8000336a:	ae278793          	addi	a5,a5,-1310 # 80012e48 <proc>
    8000336e:	fef43423          	sd	a5,-24(s0)
    80003372:	a889                	j	800033c4 <wakeup+0x6a>
    if(p != myproc()){
    80003374:	ce0ff0ef          	jal	80002854 <myproc>
    80003378:	872a                	mv	a4,a0
    8000337a:	fe843783          	ld	a5,-24(s0)
    8000337e:	02e78d63          	beq	a5,a4,800033b8 <wakeup+0x5e>
      acquire(&p->lock);
    80003382:	fe843783          	ld	a5,-24(s0)
    80003386:	853e                	mv	a0,a5
    80003388:	fc3fd0ef          	jal	8000134a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000338c:	fe843783          	ld	a5,-24(s0)
    80003390:	4f98                	lw	a4,24(a5)
    80003392:	4789                	li	a5,2
    80003394:	00f71d63          	bne	a4,a5,800033ae <wakeup+0x54>
    80003398:	fe843783          	ld	a5,-24(s0)
    8000339c:	739c                	ld	a5,32(a5)
    8000339e:	fd843703          	ld	a4,-40(s0)
    800033a2:	00f71663          	bne	a4,a5,800033ae <wakeup+0x54>
        p->state = RUNNABLE;
    800033a6:	fe843783          	ld	a5,-24(s0)
    800033aa:	470d                	li	a4,3
    800033ac:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800033ae:	fe843783          	ld	a5,-24(s0)
    800033b2:	853e                	mv	a0,a5
    800033b4:	febfd0ef          	jal	8000139e <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800033b8:	fe843783          	ld	a5,-24(s0)
    800033bc:	16878793          	addi	a5,a5,360
    800033c0:	fef43423          	sd	a5,-24(s0)
    800033c4:	fe843703          	ld	a4,-24(s0)
    800033c8:	00015797          	auipc	a5,0x15
    800033cc:	48078793          	addi	a5,a5,1152 # 80018848 <pid_lock>
    800033d0:	faf762e3          	bltu	a4,a5,80003374 <wakeup+0x1a>
    }
  }
}
    800033d4:	0001                	nop
    800033d6:	0001                	nop
    800033d8:	70a2                	ld	ra,40(sp)
    800033da:	7402                	ld	s0,32(sp)
    800033dc:	6145                	addi	sp,sp,48
    800033de:	8082                	ret

00000000800033e0 <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    800033e0:	7179                	addi	sp,sp,-48
    800033e2:	f406                	sd	ra,40(sp)
    800033e4:	f022                	sd	s0,32(sp)
    800033e6:	1800                	addi	s0,sp,48
    800033e8:	87aa                	mv	a5,a0
    800033ea:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800033ee:	00010797          	auipc	a5,0x10
    800033f2:	a5a78793          	addi	a5,a5,-1446 # 80012e48 <proc>
    800033f6:	fef43423          	sd	a5,-24(s0)
    800033fa:	a8b1                	j	80003456 <kkill+0x76>
    acquire(&p->lock);
    800033fc:	fe843783          	ld	a5,-24(s0)
    80003400:	853e                	mv	a0,a5
    80003402:	f49fd0ef          	jal	8000134a <acquire>
    if(p->pid == pid){
    80003406:	fe843783          	ld	a5,-24(s0)
    8000340a:	5b9c                	lw	a5,48(a5)
    8000340c:	fdc42703          	lw	a4,-36(s0)
    80003410:	2701                	sext.w	a4,a4
    80003412:	02f71763          	bne	a4,a5,80003440 <kkill+0x60>
      p->killed = 1;
    80003416:	fe843783          	ld	a5,-24(s0)
    8000341a:	4705                	li	a4,1
    8000341c:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    8000341e:	fe843783          	ld	a5,-24(s0)
    80003422:	4f98                	lw	a4,24(a5)
    80003424:	4789                	li	a5,2
    80003426:	00f71663          	bne	a4,a5,80003432 <kkill+0x52>
        // Wake process from sleep().
        p->state = RUNNABLE;
    8000342a:	fe843783          	ld	a5,-24(s0)
    8000342e:	470d                	li	a4,3
    80003430:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003432:	fe843783          	ld	a5,-24(s0)
    80003436:	853e                	mv	a0,a5
    80003438:	f67fd0ef          	jal	8000139e <release>
      return 0;
    8000343c:	4781                	li	a5,0
    8000343e:	a02d                	j	80003468 <kkill+0x88>
    }
    release(&p->lock);
    80003440:	fe843783          	ld	a5,-24(s0)
    80003444:	853e                	mv	a0,a5
    80003446:	f59fd0ef          	jal	8000139e <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000344a:	fe843783          	ld	a5,-24(s0)
    8000344e:	16878793          	addi	a5,a5,360
    80003452:	fef43423          	sd	a5,-24(s0)
    80003456:	fe843703          	ld	a4,-24(s0)
    8000345a:	00015797          	auipc	a5,0x15
    8000345e:	3ee78793          	addi	a5,a5,1006 # 80018848 <pid_lock>
    80003462:	f8f76de3          	bltu	a4,a5,800033fc <kkill+0x1c>
  }
  return -1;
    80003466:	57fd                	li	a5,-1
}
    80003468:	853e                	mv	a0,a5
    8000346a:	70a2                	ld	ra,40(sp)
    8000346c:	7402                	ld	s0,32(sp)
    8000346e:	6145                	addi	sp,sp,48
    80003470:	8082                	ret

0000000080003472 <setkilled>:

void
setkilled(struct proc *p)
{
    80003472:	1101                	addi	sp,sp,-32
    80003474:	ec06                	sd	ra,24(sp)
    80003476:	e822                	sd	s0,16(sp)
    80003478:	1000                	addi	s0,sp,32
    8000347a:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000347e:	fe843783          	ld	a5,-24(s0)
    80003482:	853e                	mv	a0,a5
    80003484:	ec7fd0ef          	jal	8000134a <acquire>
  p->killed = 1;
    80003488:	fe843783          	ld	a5,-24(s0)
    8000348c:	4705                	li	a4,1
    8000348e:	d798                	sw	a4,40(a5)
  release(&p->lock);
    80003490:	fe843783          	ld	a5,-24(s0)
    80003494:	853e                	mv	a0,a5
    80003496:	f09fd0ef          	jal	8000139e <release>
}
    8000349a:	0001                	nop
    8000349c:	60e2                	ld	ra,24(sp)
    8000349e:	6442                	ld	s0,16(sp)
    800034a0:	6105                	addi	sp,sp,32
    800034a2:	8082                	ret

00000000800034a4 <killed>:

int
killed(struct proc *p)
{
    800034a4:	7179                	addi	sp,sp,-48
    800034a6:	f406                	sd	ra,40(sp)
    800034a8:	f022                	sd	s0,32(sp)
    800034aa:	1800                	addi	s0,sp,48
    800034ac:	fca43c23          	sd	a0,-40(s0)
  int k;
  
  acquire(&p->lock);
    800034b0:	fd843783          	ld	a5,-40(s0)
    800034b4:	853e                	mv	a0,a5
    800034b6:	e95fd0ef          	jal	8000134a <acquire>
  k = p->killed;
    800034ba:	fd843783          	ld	a5,-40(s0)
    800034be:	579c                	lw	a5,40(a5)
    800034c0:	fef42623          	sw	a5,-20(s0)
  release(&p->lock);
    800034c4:	fd843783          	ld	a5,-40(s0)
    800034c8:	853e                	mv	a0,a5
    800034ca:	ed5fd0ef          	jal	8000139e <release>
  return k;
    800034ce:	fec42783          	lw	a5,-20(s0)
}
    800034d2:	853e                	mv	a0,a5
    800034d4:	70a2                	ld	ra,40(sp)
    800034d6:	7402                	ld	s0,32(sp)
    800034d8:	6145                	addi	sp,sp,48
    800034da:	8082                	ret

00000000800034dc <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800034dc:	7139                	addi	sp,sp,-64
    800034de:	fc06                	sd	ra,56(sp)
    800034e0:	f822                	sd	s0,48(sp)
    800034e2:	0080                	addi	s0,sp,64
    800034e4:	87aa                	mv	a5,a0
    800034e6:	fcb43823          	sd	a1,-48(s0)
    800034ea:	fcc43423          	sd	a2,-56(s0)
    800034ee:	fcd43023          	sd	a3,-64(s0)
    800034f2:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    800034f6:	b5eff0ef          	jal	80002854 <myproc>
    800034fa:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    800034fe:	fdc42783          	lw	a5,-36(s0)
    80003502:	2781                	sext.w	a5,a5
    80003504:	cf99                	beqz	a5,80003522 <either_copyout+0x46>
    return copyout(p->pagetable, dst, src, len);
    80003506:	fe843783          	ld	a5,-24(s0)
    8000350a:	6bbc                	ld	a5,80(a5)
    8000350c:	fc043683          	ld	a3,-64(s0)
    80003510:	fc843603          	ld	a2,-56(s0)
    80003514:	fd043583          	ld	a1,-48(s0)
    80003518:	853e                	mv	a0,a5
    8000351a:	cc9fe0ef          	jal	800021e2 <copyout>
    8000351e:	87aa                	mv	a5,a0
    80003520:	a829                	j	8000353a <either_copyout+0x5e>
  } else {
    memmove((char *)dst, src, len);
    80003522:	fd043783          	ld	a5,-48(s0)
    80003526:	fc043703          	ld	a4,-64(s0)
    8000352a:	2701                	sext.w	a4,a4
    8000352c:	863a                	mv	a2,a4
    8000352e:	fc843583          	ld	a1,-56(s0)
    80003532:	853e                	mv	a0,a5
    80003534:	88efe0ef          	jal	800015c2 <memmove>
    return 0;
    80003538:	4781                	li	a5,0
  }
}
    8000353a:	853e                	mv	a0,a5
    8000353c:	70e2                	ld	ra,56(sp)
    8000353e:	7442                	ld	s0,48(sp)
    80003540:	6121                	addi	sp,sp,64
    80003542:	8082                	ret

0000000080003544 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80003544:	7139                	addi	sp,sp,-64
    80003546:	fc06                	sd	ra,56(sp)
    80003548:	f822                	sd	s0,48(sp)
    8000354a:	0080                	addi	s0,sp,64
    8000354c:	fca43c23          	sd	a0,-40(s0)
    80003550:	87ae                	mv	a5,a1
    80003552:	fcc43423          	sd	a2,-56(s0)
    80003556:	fcd43023          	sd	a3,-64(s0)
    8000355a:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    8000355e:	af6ff0ef          	jal	80002854 <myproc>
    80003562:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    80003566:	fd442783          	lw	a5,-44(s0)
    8000356a:	2781                	sext.w	a5,a5
    8000356c:	cf99                	beqz	a5,8000358a <either_copyin+0x46>
    return copyin(p->pagetable, dst, src, len);
    8000356e:	fe843783          	ld	a5,-24(s0)
    80003572:	6bbc                	ld	a5,80(a5)
    80003574:	fc043683          	ld	a3,-64(s0)
    80003578:	fc843603          	ld	a2,-56(s0)
    8000357c:	fd843583          	ld	a1,-40(s0)
    80003580:	853e                	mv	a0,a5
    80003582:	d6ffe0ef          	jal	800022f0 <copyin>
    80003586:	87aa                	mv	a5,a0
    80003588:	a829                	j	800035a2 <either_copyin+0x5e>
  } else {
    memmove(dst, (char*)src, len);
    8000358a:	fc843783          	ld	a5,-56(s0)
    8000358e:	fc043703          	ld	a4,-64(s0)
    80003592:	2701                	sext.w	a4,a4
    80003594:	863a                	mv	a2,a4
    80003596:	85be                	mv	a1,a5
    80003598:	fd843503          	ld	a0,-40(s0)
    8000359c:	826fe0ef          	jal	800015c2 <memmove>
    return 0;
    800035a0:	4781                	li	a5,0
  }
}
    800035a2:	853e                	mv	a0,a5
    800035a4:	70e2                	ld	ra,56(sp)
    800035a6:	7442                	ld	s0,48(sp)
    800035a8:	6121                	addi	sp,sp,64
    800035aa:	8082                	ret

00000000800035ac <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800035ac:	1101                	addi	sp,sp,-32
    800035ae:	ec06                	sd	ra,24(sp)
    800035b0:	e822                	sd	s0,16(sp)
    800035b2:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800035b4:	00007517          	auipc	a0,0x7
    800035b8:	c4450513          	addi	a0,a0,-956 # 8000a1f8 <etext+0x1f8>
    800035bc:	c32fd0ef          	jal	800009ee <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800035c0:	00010797          	auipc	a5,0x10
    800035c4:	88878793          	addi	a5,a5,-1912 # 80012e48 <proc>
    800035c8:	fef43423          	sd	a5,-24(s0)
    800035cc:	a861                	j	80003664 <procdump+0xb8>
    if(p->state == UNUSED)
    800035ce:	fe843783          	ld	a5,-24(s0)
    800035d2:	4f9c                	lw	a5,24(a5)
    800035d4:	c3c9                	beqz	a5,80003656 <procdump+0xaa>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800035d6:	fe843783          	ld	a5,-24(s0)
    800035da:	4f98                	lw	a4,24(a5)
    800035dc:	4795                	li	a5,5
    800035de:	02e7ee63          	bltu	a5,a4,8000361a <procdump+0x6e>
    800035e2:	fe843783          	ld	a5,-24(s0)
    800035e6:	4f9c                	lw	a5,24(a5)
    800035e8:	00007717          	auipc	a4,0x7
    800035ec:	21070713          	addi	a4,a4,528 # 8000a7f8 <states.0>
    800035f0:	1782                	slli	a5,a5,0x20
    800035f2:	9381                	srli	a5,a5,0x20
    800035f4:	078e                	slli	a5,a5,0x3
    800035f6:	97ba                	add	a5,a5,a4
    800035f8:	639c                	ld	a5,0(a5)
    800035fa:	c385                	beqz	a5,8000361a <procdump+0x6e>
      state = states[p->state];
    800035fc:	fe843783          	ld	a5,-24(s0)
    80003600:	4f9c                	lw	a5,24(a5)
    80003602:	00007717          	auipc	a4,0x7
    80003606:	1f670713          	addi	a4,a4,502 # 8000a7f8 <states.0>
    8000360a:	1782                	slli	a5,a5,0x20
    8000360c:	9381                	srli	a5,a5,0x20
    8000360e:	078e                	slli	a5,a5,0x3
    80003610:	97ba                	add	a5,a5,a4
    80003612:	639c                	ld	a5,0(a5)
    80003614:	fef43023          	sd	a5,-32(s0)
    80003618:	a039                	j	80003626 <procdump+0x7a>
    else
      state = "???";
    8000361a:	00007797          	auipc	a5,0x7
    8000361e:	be678793          	addi	a5,a5,-1050 # 8000a200 <etext+0x200>
    80003622:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003626:	fe843783          	ld	a5,-24(s0)
    8000362a:	5b98                	lw	a4,48(a5)
    8000362c:	fe843783          	ld	a5,-24(s0)
    80003630:	15878793          	addi	a5,a5,344
    80003634:	86be                	mv	a3,a5
    80003636:	fe043603          	ld	a2,-32(s0)
    8000363a:	85ba                	mv	a1,a4
    8000363c:	00007517          	auipc	a0,0x7
    80003640:	bcc50513          	addi	a0,a0,-1076 # 8000a208 <etext+0x208>
    80003644:	baafd0ef          	jal	800009ee <printf>
    printf("\n");
    80003648:	00007517          	auipc	a0,0x7
    8000364c:	bb050513          	addi	a0,a0,-1104 # 8000a1f8 <etext+0x1f8>
    80003650:	b9efd0ef          	jal	800009ee <printf>
    80003654:	a011                	j	80003658 <procdump+0xac>
      continue;
    80003656:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    80003658:	fe843783          	ld	a5,-24(s0)
    8000365c:	16878793          	addi	a5,a5,360
    80003660:	fef43423          	sd	a5,-24(s0)
    80003664:	fe843703          	ld	a4,-24(s0)
    80003668:	00015797          	auipc	a5,0x15
    8000366c:	1e078793          	addi	a5,a5,480 # 80018848 <pid_lock>
    80003670:	f4f76fe3          	bltu	a4,a5,800035ce <procdump+0x22>
  }
}
    80003674:	0001                	nop
    80003676:	0001                	nop
    80003678:	60e2                	ld	ra,24(sp)
    8000367a:	6442                	ld	s0,16(sp)
    8000367c:	6105                	addi	sp,sp,32
    8000367e:	8082                	ret

0000000080003680 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    80003680:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    80003684:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    80003688:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    8000368a:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    8000368c:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    80003690:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    80003694:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    80003698:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    8000369c:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    800036a0:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    800036a4:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    800036a8:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    800036ac:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    800036b0:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    800036b4:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    800036b8:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    800036bc:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    800036be:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    800036c0:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    800036c4:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    800036c8:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    800036cc:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    800036d0:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    800036d4:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    800036d8:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    800036dc:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    800036e0:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    800036e4:	0685bd83          	ld	s11,104(a1)
        
        ret
    800036e8:	8082                	ret

00000000800036ea <r_sstatus>:
{
    800036ea:	1101                	addi	sp,sp,-32
    800036ec:	ec06                	sd	ra,24(sp)
    800036ee:	e822                	sd	s0,16(sp)
    800036f0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800036f2:	100027f3          	csrr	a5,sstatus
    800036f6:	fef43423          	sd	a5,-24(s0)
  return x;
    800036fa:	fe843783          	ld	a5,-24(s0)
}
    800036fe:	853e                	mv	a0,a5
    80003700:	60e2                	ld	ra,24(sp)
    80003702:	6442                	ld	s0,16(sp)
    80003704:	6105                	addi	sp,sp,32
    80003706:	8082                	ret

0000000080003708 <w_sstatus>:
{
    80003708:	1101                	addi	sp,sp,-32
    8000370a:	ec06                	sd	ra,24(sp)
    8000370c:	e822                	sd	s0,16(sp)
    8000370e:	1000                	addi	s0,sp,32
    80003710:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80003714:	fe843783          	ld	a5,-24(s0)
    80003718:	10079073          	csrw	sstatus,a5
}
    8000371c:	0001                	nop
    8000371e:	60e2                	ld	ra,24(sp)
    80003720:	6442                	ld	s0,16(sp)
    80003722:	6105                	addi	sp,sp,32
    80003724:	8082                	ret

0000000080003726 <w_sepc>:
{
    80003726:	1101                	addi	sp,sp,-32
    80003728:	ec06                	sd	ra,24(sp)
    8000372a:	e822                	sd	s0,16(sp)
    8000372c:	1000                	addi	s0,sp,32
    8000372e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80003732:	fe843783          	ld	a5,-24(s0)
    80003736:	14179073          	csrw	sepc,a5
}
    8000373a:	0001                	nop
    8000373c:	60e2                	ld	ra,24(sp)
    8000373e:	6442                	ld	s0,16(sp)
    80003740:	6105                	addi	sp,sp,32
    80003742:	8082                	ret

0000000080003744 <r_sepc>:
{
    80003744:	1101                	addi	sp,sp,-32
    80003746:	ec06                	sd	ra,24(sp)
    80003748:	e822                	sd	s0,16(sp)
    8000374a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000374c:	141027f3          	csrr	a5,sepc
    80003750:	fef43423          	sd	a5,-24(s0)
  return x;
    80003754:	fe843783          	ld	a5,-24(s0)
}
    80003758:	853e                	mv	a0,a5
    8000375a:	60e2                	ld	ra,24(sp)
    8000375c:	6442                	ld	s0,16(sp)
    8000375e:	6105                	addi	sp,sp,32
    80003760:	8082                	ret

0000000080003762 <w_stvec>:
{
    80003762:	1101                	addi	sp,sp,-32
    80003764:	ec06                	sd	ra,24(sp)
    80003766:	e822                	sd	s0,16(sp)
    80003768:	1000                	addi	s0,sp,32
    8000376a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000376e:	fe843783          	ld	a5,-24(s0)
    80003772:	10579073          	csrw	stvec,a5
}
    80003776:	0001                	nop
    80003778:	60e2                	ld	ra,24(sp)
    8000377a:	6442                	ld	s0,16(sp)
    8000377c:	6105                	addi	sp,sp,32
    8000377e:	8082                	ret

0000000080003780 <w_stimecmp>:
{
    80003780:	1101                	addi	sp,sp,-32
    80003782:	ec06                	sd	ra,24(sp)
    80003784:	e822                	sd	s0,16(sp)
    80003786:	1000                	addi	s0,sp,32
    80003788:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    8000378c:	fe843783          	ld	a5,-24(s0)
    80003790:	14d79073          	csrw	stimecmp,a5
}
    80003794:	0001                	nop
    80003796:	60e2                	ld	ra,24(sp)
    80003798:	6442                	ld	s0,16(sp)
    8000379a:	6105                	addi	sp,sp,32
    8000379c:	8082                	ret

000000008000379e <r_satp>:
{
    8000379e:	1101                	addi	sp,sp,-32
    800037a0:	ec06                	sd	ra,24(sp)
    800037a2:	e822                	sd	s0,16(sp)
    800037a4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    800037a6:	180027f3          	csrr	a5,satp
    800037aa:	fef43423          	sd	a5,-24(s0)
  return x;
    800037ae:	fe843783          	ld	a5,-24(s0)
}
    800037b2:	853e                	mv	a0,a5
    800037b4:	60e2                	ld	ra,24(sp)
    800037b6:	6442                	ld	s0,16(sp)
    800037b8:	6105                	addi	sp,sp,32
    800037ba:	8082                	ret

00000000800037bc <r_scause>:
{
    800037bc:	1101                	addi	sp,sp,-32
    800037be:	ec06                	sd	ra,24(sp)
    800037c0:	e822                	sd	s0,16(sp)
    800037c2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800037c4:	142027f3          	csrr	a5,scause
    800037c8:	fef43423          	sd	a5,-24(s0)
  return x;
    800037cc:	fe843783          	ld	a5,-24(s0)
}
    800037d0:	853e                	mv	a0,a5
    800037d2:	60e2                	ld	ra,24(sp)
    800037d4:	6442                	ld	s0,16(sp)
    800037d6:	6105                	addi	sp,sp,32
    800037d8:	8082                	ret

00000000800037da <r_stval>:
{
    800037da:	1101                	addi	sp,sp,-32
    800037dc:	ec06                	sd	ra,24(sp)
    800037de:	e822                	sd	s0,16(sp)
    800037e0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    800037e2:	143027f3          	csrr	a5,stval
    800037e6:	fef43423          	sd	a5,-24(s0)
  return x;
    800037ea:	fe843783          	ld	a5,-24(s0)
}
    800037ee:	853e                	mv	a0,a5
    800037f0:	60e2                	ld	ra,24(sp)
    800037f2:	6442                	ld	s0,16(sp)
    800037f4:	6105                	addi	sp,sp,32
    800037f6:	8082                	ret

00000000800037f8 <r_time>:
{
    800037f8:	1101                	addi	sp,sp,-32
    800037fa:	ec06                	sd	ra,24(sp)
    800037fc:	e822                	sd	s0,16(sp)
    800037fe:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, time" : "=r" (x) );
    80003800:	c01027f3          	rdtime	a5
    80003804:	fef43423          	sd	a5,-24(s0)
  return x;
    80003808:	fe843783          	ld	a5,-24(s0)
}
    8000380c:	853e                	mv	a0,a5
    8000380e:	60e2                	ld	ra,24(sp)
    80003810:	6442                	ld	s0,16(sp)
    80003812:	6105                	addi	sp,sp,32
    80003814:	8082                	ret

0000000080003816 <intr_on>:
{
    80003816:	1141                	addi	sp,sp,-16
    80003818:	e406                	sd	ra,8(sp)
    8000381a:	e022                	sd	s0,0(sp)
    8000381c:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000381e:	ecdff0ef          	jal	800036ea <r_sstatus>
    80003822:	87aa                	mv	a5,a0
    80003824:	0027e793          	ori	a5,a5,2
    80003828:	853e                	mv	a0,a5
    8000382a:	edfff0ef          	jal	80003708 <w_sstatus>
}
    8000382e:	0001                	nop
    80003830:	60a2                	ld	ra,8(sp)
    80003832:	6402                	ld	s0,0(sp)
    80003834:	0141                	addi	sp,sp,16
    80003836:	8082                	ret

0000000080003838 <intr_off>:
{
    80003838:	1141                	addi	sp,sp,-16
    8000383a:	e406                	sd	ra,8(sp)
    8000383c:	e022                	sd	s0,0(sp)
    8000383e:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003840:	eabff0ef          	jal	800036ea <r_sstatus>
    80003844:	87aa                	mv	a5,a0
    80003846:	9bf5                	andi	a5,a5,-3
    80003848:	853e                	mv	a0,a5
    8000384a:	ebfff0ef          	jal	80003708 <w_sstatus>
}
    8000384e:	0001                	nop
    80003850:	60a2                	ld	ra,8(sp)
    80003852:	6402                	ld	s0,0(sp)
    80003854:	0141                	addi	sp,sp,16
    80003856:	8082                	ret

0000000080003858 <intr_get>:
{
    80003858:	1101                	addi	sp,sp,-32
    8000385a:	ec06                	sd	ra,24(sp)
    8000385c:	e822                	sd	s0,16(sp)
    8000385e:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003860:	e8bff0ef          	jal	800036ea <r_sstatus>
    80003864:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003868:	fe843783          	ld	a5,-24(s0)
    8000386c:	8b89                	andi	a5,a5,2
    8000386e:	00f037b3          	snez	a5,a5
    80003872:	0ff7f793          	zext.b	a5,a5
    80003876:	2781                	sext.w	a5,a5
}
    80003878:	853e                	mv	a0,a5
    8000387a:	60e2                	ld	ra,24(sp)
    8000387c:	6442                	ld	s0,16(sp)
    8000387e:	6105                	addi	sp,sp,32
    80003880:	8082                	ret

0000000080003882 <r_tp>:
{
    80003882:	1101                	addi	sp,sp,-32
    80003884:	ec06                	sd	ra,24(sp)
    80003886:	e822                	sd	s0,16(sp)
    80003888:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    8000388a:	8792                	mv	a5,tp
    8000388c:	fef43423          	sd	a5,-24(s0)
  return x;
    80003890:	fe843783          	ld	a5,-24(s0)
}
    80003894:	853e                	mv	a0,a5
    80003896:	60e2                	ld	ra,24(sp)
    80003898:	6442                	ld	s0,16(sp)
    8000389a:	6105                	addi	sp,sp,32
    8000389c:	8082                	ret

000000008000389e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000389e:	1141                	addi	sp,sp,-16
    800038a0:	e406                	sd	ra,8(sp)
    800038a2:	e022                	sd	s0,0(sp)
    800038a4:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800038a6:	00007597          	auipc	a1,0x7
    800038aa:	9aa58593          	addi	a1,a1,-1622 # 8000a250 <etext+0x250>
    800038ae:	00015517          	auipc	a0,0x15
    800038b2:	fca50513          	addi	a0,a0,-54 # 80018878 <tickslock>
    800038b6:	a61fd0ef          	jal	80001316 <initlock>
}
    800038ba:	0001                	nop
    800038bc:	60a2                	ld	ra,8(sp)
    800038be:	6402                	ld	s0,0(sp)
    800038c0:	0141                	addi	sp,sp,16
    800038c2:	8082                	ret

00000000800038c4 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800038c4:	1141                	addi	sp,sp,-16
    800038c6:	e406                	sd	ra,8(sp)
    800038c8:	e022                	sd	s0,0(sp)
    800038ca:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    800038cc:	00005797          	auipc	a5,0x5
    800038d0:	8a478793          	addi	a5,a5,-1884 # 80008170 <kernelvec>
    800038d4:	853e                	mv	a0,a5
    800038d6:	e8dff0ef          	jal	80003762 <w_stvec>
}
    800038da:	0001                	nop
    800038dc:	60a2                	ld	ra,8(sp)
    800038de:	6402                	ld	s0,0(sp)
    800038e0:	0141                	addi	sp,sp,16
    800038e2:	8082                	ret

00000000800038e4 <usertrap>:
// called from, and returns to, trampoline.S
// return value is user satp for trampoline.S to switch to.
//
uint64
usertrap(void)
{
    800038e4:	7139                	addi	sp,sp,-64
    800038e6:	fc06                	sd	ra,56(sp)
    800038e8:	f822                	sd	s0,48(sp)
    800038ea:	f426                	sd	s1,40(sp)
    800038ec:	f04a                	sd	s2,32(sp)
    800038ee:	0080                	addi	s0,sp,64
  int which_dev = 0;
    800038f0:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    800038f4:	df7ff0ef          	jal	800036ea <r_sstatus>
    800038f8:	87aa                	mv	a5,a0
    800038fa:	1007f793          	andi	a5,a5,256
    800038fe:	c799                	beqz	a5,8000390c <usertrap+0x28>
    panic("usertrap: not from user mode");
    80003900:	00007517          	auipc	a0,0x7
    80003904:	95850513          	addi	a0,a0,-1704 # 8000a258 <etext+0x258>
    80003908:	d2efd0ef          	jal	80000e36 <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);  //DOC: kernelvec
    8000390c:	00005797          	auipc	a5,0x5
    80003910:	86478793          	addi	a5,a5,-1948 # 80008170 <kernelvec>
    80003914:	853e                	mv	a0,a5
    80003916:	e4dff0ef          	jal	80003762 <w_stvec>

  struct proc *p = myproc();
    8000391a:	f3bfe0ef          	jal	80002854 <myproc>
    8000391e:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80003922:	fd043783          	ld	a5,-48(s0)
    80003926:	6fa4                	ld	s1,88(a5)
    80003928:	e1dff0ef          	jal	80003744 <r_sepc>
    8000392c:	87aa                	mv	a5,a0
    8000392e:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80003930:	e8dff0ef          	jal	800037bc <r_scause>
    80003934:	872a                	mv	a4,a0
    80003936:	47a1                	li	a5,8
    80003938:	02f71963          	bne	a4,a5,8000396a <usertrap+0x86>
    // system call

    if(killed(p))
    8000393c:	fd043503          	ld	a0,-48(s0)
    80003940:	b65ff0ef          	jal	800034a4 <killed>
    80003944:	87aa                	mv	a5,a0
    80003946:	c781                	beqz	a5,8000394e <usertrap+0x6a>
      kexit(-1);
    80003948:	557d                	li	a0,-1
    8000394a:	d06ff0ef          	jal	80002e50 <kexit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    8000394e:	fd043783          	ld	a5,-48(s0)
    80003952:	6fbc                	ld	a5,88(a5)
    80003954:	6f98                	ld	a4,24(a5)
    80003956:	fd043783          	ld	a5,-48(s0)
    8000395a:	6fbc                	ld	a5,88(a5)
    8000395c:	0711                	addi	a4,a4,4
    8000395e:	ef98                	sd	a4,24(a5)

    // an interrupt will change sepc, scause, and sstatus,
    // so enable only now that we're done with those registers.
    intr_on();
    80003960:	eb7ff0ef          	jal	80003816 <intr_on>

    syscall();
    80003964:	57c000ef          	jal	80003ee0 <syscall>
    80003968:	a861                	j	80003a00 <usertrap+0x11c>
  } else if((which_dev = devintr()) != 0){
    8000396a:	2d4000ef          	jal	80003c3e <devintr>
    8000396e:	87aa                	mv	a5,a0
    80003970:	fcf42e23          	sw	a5,-36(s0)
    80003974:	fdc42783          	lw	a5,-36(s0)
    80003978:	2781                	sext.w	a5,a5
    8000397a:	e3d9                	bnez	a5,80003a00 <usertrap+0x11c>
    // ok
  } else if((r_scause() == 15 || r_scause() == 13) &&
    8000397c:	e41ff0ef          	jal	800037bc <r_scause>
    80003980:	872a                	mv	a4,a0
    80003982:	47bd                	li	a5,15
    80003984:	00f70863          	beq	a4,a5,80003994 <usertrap+0xb0>
    80003988:	e35ff0ef          	jal	800037bc <r_scause>
    8000398c:	872a                	mv	a4,a0
    8000398e:	47b5                	li	a5,13
    80003990:	02f71863          	bne	a4,a5,800039c0 <usertrap+0xdc>
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80003994:	fd043783          	ld	a5,-48(s0)
    80003998:	6ba4                	ld	s1,80(a5)
    8000399a:	e41ff0ef          	jal	800037da <r_stval>
    8000399e:	892a                	mv	s2,a0
    800039a0:	e1dff0ef          	jal	800037bc <r_scause>
    800039a4:	87aa                	mv	a5,a0
    800039a6:	17cd                	addi	a5,a5,-13
    800039a8:	0017b793          	seqz	a5,a5
    800039ac:	0ff7f793          	zext.b	a5,a5
    800039b0:	2781                	sext.w	a5,a5
    800039b2:	863e                	mv	a2,a5
    800039b4:	85ca                	mv	a1,s2
    800039b6:	8526                	mv	a0,s1
    800039b8:	b21fe0ef          	jal	800024d8 <vmfault>
    800039bc:	87aa                	mv	a5,a0
  } else if((r_scause() == 15 || r_scause() == 13) &&
    800039be:	e3a9                	bnez	a5,80003a00 <usertrap+0x11c>
    // page fault on lazily-allocated page
  } else {
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    800039c0:	dfdff0ef          	jal	800037bc <r_scause>
    800039c4:	872a                	mv	a4,a0
    800039c6:	fd043783          	ld	a5,-48(s0)
    800039ca:	5b9c                	lw	a5,48(a5)
    800039cc:	863e                	mv	a2,a5
    800039ce:	85ba                	mv	a1,a4
    800039d0:	00007517          	auipc	a0,0x7
    800039d4:	8a850513          	addi	a0,a0,-1880 # 8000a278 <etext+0x278>
    800039d8:	816fd0ef          	jal	800009ee <printf>
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    800039dc:	d69ff0ef          	jal	80003744 <r_sepc>
    800039e0:	84aa                	mv	s1,a0
    800039e2:	df9ff0ef          	jal	800037da <r_stval>
    800039e6:	87aa                	mv	a5,a0
    800039e8:	863e                	mv	a2,a5
    800039ea:	85a6                	mv	a1,s1
    800039ec:	00007517          	auipc	a0,0x7
    800039f0:	8bc50513          	addi	a0,a0,-1860 # 8000a2a8 <etext+0x2a8>
    800039f4:	ffbfc0ef          	jal	800009ee <printf>
    setkilled(p);
    800039f8:	fd043503          	ld	a0,-48(s0)
    800039fc:	a77ff0ef          	jal	80003472 <setkilled>
  }

  if(killed(p))
    80003a00:	fd043503          	ld	a0,-48(s0)
    80003a04:	aa1ff0ef          	jal	800034a4 <killed>
    80003a08:	87aa                	mv	a5,a0
    80003a0a:	c781                	beqz	a5,80003a12 <usertrap+0x12e>
    kexit(-1);
    80003a0c:	557d                	li	a0,-1
    80003a0e:	c42ff0ef          	jal	80002e50 <kexit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    80003a12:	fdc42783          	lw	a5,-36(s0)
    80003a16:	0007871b          	sext.w	a4,a5
    80003a1a:	4789                	li	a5,2
    80003a1c:	00f71463          	bne	a4,a5,80003a24 <usertrap+0x140>
    yield();
    80003a20:	fccff0ef          	jal	800031ec <yield>

  prepare_return();
    80003a24:	02a000ef          	jal	80003a4e <prepare_return>

  // the user page table to switch to, for trampoline.S
  uint64 satp = MAKE_SATP(p->pagetable);
    80003a28:	fd043783          	ld	a5,-48(s0)
    80003a2c:	6bbc                	ld	a5,80(a5)
    80003a2e:	00c7d713          	srli	a4,a5,0xc
    80003a32:	57fd                	li	a5,-1
    80003a34:	17fe                	slli	a5,a5,0x3f
    80003a36:	8fd9                	or	a5,a5,a4
    80003a38:	fcf43423          	sd	a5,-56(s0)

  // return to trampoline.S; satp value in a0.
  return satp;
    80003a3c:	fc843783          	ld	a5,-56(s0)
}
    80003a40:	853e                	mv	a0,a5
    80003a42:	70e2                	ld	ra,56(sp)
    80003a44:	7442                	ld	s0,48(sp)
    80003a46:	74a2                	ld	s1,40(sp)
    80003a48:	7902                	ld	s2,32(sp)
    80003a4a:	6121                	addi	sp,sp,64
    80003a4c:	8082                	ret

0000000080003a4e <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    80003a4e:	7139                	addi	sp,sp,-64
    80003a50:	fc06                	sd	ra,56(sp)
    80003a52:	f822                	sd	s0,48(sp)
    80003a54:	f426                	sd	s1,40(sp)
    80003a56:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80003a58:	dfdfe0ef          	jal	80002854 <myproc>
    80003a5c:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();
    80003a60:	dd9ff0ef          	jal	80003838 <intr_off>

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80003a64:	00005717          	auipc	a4,0x5
    80003a68:	59c70713          	addi	a4,a4,1436 # 80009000 <_trampoline>
    80003a6c:	00005797          	auipc	a5,0x5
    80003a70:	59478793          	addi	a5,a5,1428 # 80009000 <_trampoline>
    80003a74:	8f1d                	sub	a4,a4,a5
    80003a76:	040007b7          	lui	a5,0x4000
    80003a7a:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80003a7c:	07b2                	slli	a5,a5,0xc
    80003a7e:	97ba                	add	a5,a5,a4
    80003a80:	fcf43823          	sd	a5,-48(s0)
  w_stvec(trampoline_uservec);
    80003a84:	fd043503          	ld	a0,-48(s0)
    80003a88:	cdbff0ef          	jal	80003762 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003a8c:	fd843783          	ld	a5,-40(s0)
    80003a90:	6fa4                	ld	s1,88(a5)
    80003a92:	d0dff0ef          	jal	8000379e <r_satp>
    80003a96:	87aa                	mv	a5,a0
    80003a98:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80003a9a:	fd843783          	ld	a5,-40(s0)
    80003a9e:	63b4                	ld	a3,64(a5)
    80003aa0:	fd843783          	ld	a5,-40(s0)
    80003aa4:	6fbc                	ld	a5,88(a5)
    80003aa6:	6705                	lui	a4,0x1
    80003aa8:	9736                	add	a4,a4,a3
    80003aaa:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003aac:	fd843783          	ld	a5,-40(s0)
    80003ab0:	6fbc                	ld	a5,88(a5)
    80003ab2:	00000717          	auipc	a4,0x0
    80003ab6:	e3270713          	addi	a4,a4,-462 # 800038e4 <usertrap>
    80003aba:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003abc:	fd843783          	ld	a5,-40(s0)
    80003ac0:	6fa4                	ld	s1,88(a5)
    80003ac2:	dc1ff0ef          	jal	80003882 <r_tp>
    80003ac6:	87aa                	mv	a5,a0
    80003ac8:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80003aca:	c21ff0ef          	jal	800036ea <r_sstatus>
    80003ace:	fca43423          	sd	a0,-56(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80003ad2:	fc843783          	ld	a5,-56(s0)
    80003ad6:	eff7f793          	andi	a5,a5,-257
    80003ada:	fcf43423          	sd	a5,-56(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80003ade:	fc843783          	ld	a5,-56(s0)
    80003ae2:	0207e793          	ori	a5,a5,32
    80003ae6:	fcf43423          	sd	a5,-56(s0)
  w_sstatus(x);
    80003aea:	fc843503          	ld	a0,-56(s0)
    80003aee:	c1bff0ef          	jal	80003708 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80003af2:	fd843783          	ld	a5,-40(s0)
    80003af6:	6fbc                	ld	a5,88(a5)
    80003af8:	6f9c                	ld	a5,24(a5)
    80003afa:	853e                	mv	a0,a5
    80003afc:	c2bff0ef          	jal	80003726 <w_sepc>
}
    80003b00:	0001                	nop
    80003b02:	70e2                	ld	ra,56(sp)
    80003b04:	7442                	ld	s0,48(sp)
    80003b06:	74a2                	ld	s1,40(sp)
    80003b08:	6121                	addi	sp,sp,64
    80003b0a:	8082                	ret

0000000080003b0c <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80003b0c:	7139                	addi	sp,sp,-64
    80003b0e:	fc06                	sd	ra,56(sp)
    80003b10:	f822                	sd	s0,48(sp)
    80003b12:	f426                	sd	s1,40(sp)
    80003b14:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80003b16:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80003b1a:	c2bff0ef          	jal	80003744 <r_sepc>
    80003b1e:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80003b22:	bc9ff0ef          	jal	800036ea <r_sstatus>
    80003b26:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80003b2a:	c93ff0ef          	jal	800037bc <r_scause>
    80003b2e:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80003b32:	fc843783          	ld	a5,-56(s0)
    80003b36:	1007f793          	andi	a5,a5,256
    80003b3a:	e799                	bnez	a5,80003b48 <kerneltrap+0x3c>
    panic("kerneltrap: not from supervisor mode");
    80003b3c:	00006517          	auipc	a0,0x6
    80003b40:	79450513          	addi	a0,a0,1940 # 8000a2d0 <etext+0x2d0>
    80003b44:	af2fd0ef          	jal	80000e36 <panic>
  if(intr_get() != 0)
    80003b48:	d11ff0ef          	jal	80003858 <intr_get>
    80003b4c:	87aa                	mv	a5,a0
    80003b4e:	c799                	beqz	a5,80003b5c <kerneltrap+0x50>
    panic("kerneltrap: interrupts enabled");
    80003b50:	00006517          	auipc	a0,0x6
    80003b54:	7a850513          	addi	a0,a0,1960 # 8000a2f8 <etext+0x2f8>
    80003b58:	adefd0ef          	jal	80000e36 <panic>

  if((which_dev = devintr()) == 0){
    80003b5c:	0e2000ef          	jal	80003c3e <devintr>
    80003b60:	87aa                	mv	a5,a0
    80003b62:	fcf42e23          	sw	a5,-36(s0)
    80003b66:	fdc42783          	lw	a5,-36(s0)
    80003b6a:	2781                	sext.w	a5,a5
    80003b6c:	e79d                	bnez	a5,80003b9a <kerneltrap+0x8e>
    // interrupt or trap from an unknown source
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80003b6e:	bd7ff0ef          	jal	80003744 <r_sepc>
    80003b72:	84aa                	mv	s1,a0
    80003b74:	c67ff0ef          	jal	800037da <r_stval>
    80003b78:	87aa                	mv	a5,a0
    80003b7a:	86be                	mv	a3,a5
    80003b7c:	8626                	mv	a2,s1
    80003b7e:	fc043583          	ld	a1,-64(s0)
    80003b82:	00006517          	auipc	a0,0x6
    80003b86:	79650513          	addi	a0,a0,1942 # 8000a318 <etext+0x318>
    80003b8a:	e65fc0ef          	jal	800009ee <printf>
    panic("kerneltrap");
    80003b8e:	00006517          	auipc	a0,0x6
    80003b92:	7b250513          	addi	a0,a0,1970 # 8000a340 <etext+0x340>
    80003b96:	aa0fd0ef          	jal	80000e36 <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0)
    80003b9a:	fdc42783          	lw	a5,-36(s0)
    80003b9e:	0007871b          	sext.w	a4,a5
    80003ba2:	4789                	li	a5,2
    80003ba4:	00f71863          	bne	a4,a5,80003bb4 <kerneltrap+0xa8>
    80003ba8:	cadfe0ef          	jal	80002854 <myproc>
    80003bac:	87aa                	mv	a5,a0
    80003bae:	c399                	beqz	a5,80003bb4 <kerneltrap+0xa8>
    yield();
    80003bb0:	e3cff0ef          	jal	800031ec <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80003bb4:	fd043503          	ld	a0,-48(s0)
    80003bb8:	b6fff0ef          	jal	80003726 <w_sepc>
  w_sstatus(sstatus);
    80003bbc:	fc843503          	ld	a0,-56(s0)
    80003bc0:	b49ff0ef          	jal	80003708 <w_sstatus>
}
    80003bc4:	0001                	nop
    80003bc6:	70e2                	ld	ra,56(sp)
    80003bc8:	7442                	ld	s0,48(sp)
    80003bca:	74a2                	ld	s1,40(sp)
    80003bcc:	6121                	addi	sp,sp,64
    80003bce:	8082                	ret

0000000080003bd0 <clockintr>:

void
clockintr()
{
    80003bd0:	1141                	addi	sp,sp,-16
    80003bd2:	e406                	sd	ra,8(sp)
    80003bd4:	e022                	sd	s0,0(sp)
    80003bd6:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80003bd8:	c27fe0ef          	jal	800027fe <cpuid>
    80003bdc:	87aa                	mv	a5,a0
    80003bde:	e3a1                	bnez	a5,80003c1e <clockintr+0x4e>
    acquire(&tickslock);
    80003be0:	00015517          	auipc	a0,0x15
    80003be4:	c9850513          	addi	a0,a0,-872 # 80018878 <tickslock>
    80003be8:	f62fd0ef          	jal	8000134a <acquire>
    ticks++;
    80003bec:	00007797          	auipc	a5,0x7
    80003bf0:	d4c78793          	addi	a5,a5,-692 # 8000a938 <ticks>
    80003bf4:	439c                	lw	a5,0(a5)
    80003bf6:	2785                	addiw	a5,a5,1
    80003bf8:	0007871b          	sext.w	a4,a5
    80003bfc:	00007797          	auipc	a5,0x7
    80003c00:	d3c78793          	addi	a5,a5,-708 # 8000a938 <ticks>
    80003c04:	c398                	sw	a4,0(a5)
    wakeup(&ticks);
    80003c06:	00007517          	auipc	a0,0x7
    80003c0a:	d3250513          	addi	a0,a0,-718 # 8000a938 <ticks>
    80003c0e:	f4cff0ef          	jal	8000335a <wakeup>
    release(&tickslock);
    80003c12:	00015517          	auipc	a0,0x15
    80003c16:	c6650513          	addi	a0,a0,-922 # 80018878 <tickslock>
    80003c1a:	f84fd0ef          	jal	8000139e <release>
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    80003c1e:	bdbff0ef          	jal	800037f8 <r_time>
    80003c22:	872a                	mv	a4,a0
    80003c24:	000f47b7          	lui	a5,0xf4
    80003c28:	24078793          	addi	a5,a5,576 # f4240 <_entry-0x7ff0bdc0>
    80003c2c:	97ba                	add	a5,a5,a4
    80003c2e:	853e                	mv	a0,a5
    80003c30:	b51ff0ef          	jal	80003780 <w_stimecmp>
}
    80003c34:	0001                	nop
    80003c36:	60a2                	ld	ra,8(sp)
    80003c38:	6402                	ld	s0,0(sp)
    80003c3a:	0141                	addi	sp,sp,16
    80003c3c:	8082                	ret

0000000080003c3e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80003c3e:	1101                	addi	sp,sp,-32
    80003c40:	ec06                	sd	ra,24(sp)
    80003c42:	e822                	sd	s0,16(sp)
    80003c44:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80003c46:	b77ff0ef          	jal	800037bc <r_scause>
    80003c4a:	fea43423          	sd	a0,-24(s0)

  if(scause == 0x8000000000000009L){
    80003c4e:	fe843703          	ld	a4,-24(s0)
    80003c52:	57fd                	li	a5,-1
    80003c54:	17fe                	slli	a5,a5,0x3f
    80003c56:	07a5                	addi	a5,a5,9
    80003c58:	06f71363          	bne	a4,a5,80003cbe <devintr+0x80>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    80003c5c:	5ea040ef          	jal	80008246 <plic_claim>
    80003c60:	87aa                	mv	a5,a0
    80003c62:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80003c66:	fe442783          	lw	a5,-28(s0)
    80003c6a:	0007871b          	sext.w	a4,a5
    80003c6e:	47a9                	li	a5,10
    80003c70:	00f71563          	bne	a4,a5,80003c7a <devintr+0x3c>
      uartintr();
    80003c74:	becfd0ef          	jal	80001060 <uartintr>
    80003c78:	a805                	j	80003ca8 <devintr+0x6a>
    } else if(irq == VIRTIO0_IRQ){
    80003c7a:	fe442783          	lw	a5,-28(s0)
    80003c7e:	0007871b          	sext.w	a4,a5
    80003c82:	4785                	li	a5,1
    80003c84:	00f71563          	bne	a4,a5,80003c8e <devintr+0x50>
      virtio_disk_intr();
    80003c88:	717040ef          	jal	80008b9e <virtio_disk_intr>
    80003c8c:	a831                	j	80003ca8 <devintr+0x6a>
    } else if(irq){
    80003c8e:	fe442783          	lw	a5,-28(s0)
    80003c92:	2781                	sext.w	a5,a5
    80003c94:	cb91                	beqz	a5,80003ca8 <devintr+0x6a>
      printf("unexpected interrupt irq=%d\n", irq);
    80003c96:	fe442783          	lw	a5,-28(s0)
    80003c9a:	85be                	mv	a1,a5
    80003c9c:	00006517          	auipc	a0,0x6
    80003ca0:	6b450513          	addi	a0,a0,1716 # 8000a350 <etext+0x350>
    80003ca4:	d4bfc0ef          	jal	800009ee <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    80003ca8:	fe442783          	lw	a5,-28(s0)
    80003cac:	2781                	sext.w	a5,a5
    80003cae:	c791                	beqz	a5,80003cba <devintr+0x7c>
      plic_complete(irq);
    80003cb0:	fe442783          	lw	a5,-28(s0)
    80003cb4:	853e                	mv	a0,a5
    80003cb6:	5ca040ef          	jal	80008280 <plic_complete>

    return 1;
    80003cba:	4785                	li	a5,1
    80003cbc:	a829                	j	80003cd6 <devintr+0x98>
  } else if(scause == 0x8000000000000005L){
    80003cbe:	fe843703          	ld	a4,-24(s0)
    80003cc2:	57fd                	li	a5,-1
    80003cc4:	17fe                	slli	a5,a5,0x3f
    80003cc6:	0795                	addi	a5,a5,5
    80003cc8:	00f71663          	bne	a4,a5,80003cd4 <devintr+0x96>
    // timer interrupt.
    clockintr();
    80003ccc:	f05ff0ef          	jal	80003bd0 <clockintr>
    return 2;
    80003cd0:	4789                	li	a5,2
    80003cd2:	a011                	j	80003cd6 <devintr+0x98>
  } else {
    return 0;
    80003cd4:	4781                	li	a5,0
  }
}
    80003cd6:	853e                	mv	a0,a5
    80003cd8:	60e2                	ld	ra,24(sp)
    80003cda:	6442                	ld	s0,16(sp)
    80003cdc:	6105                	addi	sp,sp,32
    80003cde:	8082                	ret

0000000080003ce0 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    80003ce0:	7179                	addi	sp,sp,-48
    80003ce2:	f406                	sd	ra,40(sp)
    80003ce4:	f022                	sd	s0,32(sp)
    80003ce6:	1800                	addi	s0,sp,48
    80003ce8:	fca43c23          	sd	a0,-40(s0)
    80003cec:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003cf0:	b65fe0ef          	jal	80002854 <myproc>
    80003cf4:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80003cf8:	fe843783          	ld	a5,-24(s0)
    80003cfc:	67bc                	ld	a5,72(a5)
    80003cfe:	fd843703          	ld	a4,-40(s0)
    80003d02:	00f77b63          	bgeu	a4,a5,80003d18 <fetchaddr+0x38>
    80003d06:	fd843783          	ld	a5,-40(s0)
    80003d0a:	00878713          	addi	a4,a5,8
    80003d0e:	fe843783          	ld	a5,-24(s0)
    80003d12:	67bc                	ld	a5,72(a5)
    80003d14:	00e7f463          	bgeu	a5,a4,80003d1c <fetchaddr+0x3c>
    return -1;
    80003d18:	57fd                	li	a5,-1
    80003d1a:	a00d                	j	80003d3c <fetchaddr+0x5c>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80003d1c:	fe843783          	ld	a5,-24(s0)
    80003d20:	6bbc                	ld	a5,80(a5)
    80003d22:	46a1                	li	a3,8
    80003d24:	fd843603          	ld	a2,-40(s0)
    80003d28:	fd043583          	ld	a1,-48(s0)
    80003d2c:	853e                	mv	a0,a5
    80003d2e:	dc2fe0ef          	jal	800022f0 <copyin>
    80003d32:	87aa                	mv	a5,a0
    80003d34:	c399                	beqz	a5,80003d3a <fetchaddr+0x5a>
    return -1;
    80003d36:	57fd                	li	a5,-1
    80003d38:	a011                	j	80003d3c <fetchaddr+0x5c>
  return 0;
    80003d3a:	4781                	li	a5,0
}
    80003d3c:	853e                	mv	a0,a5
    80003d3e:	70a2                	ld	ra,40(sp)
    80003d40:	7402                	ld	s0,32(sp)
    80003d42:	6145                	addi	sp,sp,48
    80003d44:	8082                	ret

0000000080003d46 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80003d46:	7139                	addi	sp,sp,-64
    80003d48:	fc06                	sd	ra,56(sp)
    80003d4a:	f822                	sd	s0,48(sp)
    80003d4c:	0080                	addi	s0,sp,64
    80003d4e:	fca43c23          	sd	a0,-40(s0)
    80003d52:	fcb43823          	sd	a1,-48(s0)
    80003d56:	87b2                	mv	a5,a2
    80003d58:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003d5c:	af9fe0ef          	jal	80002854 <myproc>
    80003d60:	fea43423          	sd	a0,-24(s0)
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80003d64:	fe843783          	ld	a5,-24(s0)
    80003d68:	6bbc                	ld	a5,80(a5)
    80003d6a:	fcc42703          	lw	a4,-52(s0)
    80003d6e:	86ba                	mv	a3,a4
    80003d70:	fd843603          	ld	a2,-40(s0)
    80003d74:	fd043583          	ld	a1,-48(s0)
    80003d78:	853e                	mv	a0,a5
    80003d7a:	e54fe0ef          	jal	800023ce <copyinstr>
    80003d7e:	87aa                	mv	a5,a0
    80003d80:	0007d463          	bgez	a5,80003d88 <fetchstr+0x42>
    return -1;
    80003d84:	57fd                	li	a5,-1
    80003d86:	a031                	j	80003d92 <fetchstr+0x4c>
  return strlen(buf);
    80003d88:	fd043503          	ld	a0,-48(s0)
    80003d8c:	adffd0ef          	jal	8000186a <strlen>
    80003d90:	87aa                	mv	a5,a0
}
    80003d92:	853e                	mv	a0,a5
    80003d94:	70e2                	ld	ra,56(sp)
    80003d96:	7442                	ld	s0,48(sp)
    80003d98:	6121                	addi	sp,sp,64
    80003d9a:	8082                	ret

0000000080003d9c <argraw>:

static uint64
argraw(int n)
{
    80003d9c:	7179                	addi	sp,sp,-48
    80003d9e:	f406                	sd	ra,40(sp)
    80003da0:	f022                	sd	s0,32(sp)
    80003da2:	1800                	addi	s0,sp,48
    80003da4:	87aa                	mv	a5,a0
    80003da6:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003daa:	aabfe0ef          	jal	80002854 <myproc>
    80003dae:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80003db2:	fdc42783          	lw	a5,-36(s0)
    80003db6:	0007871b          	sext.w	a4,a5
    80003dba:	4795                	li	a5,5
    80003dbc:	06e7e263          	bltu	a5,a4,80003e20 <argraw+0x84>
    80003dc0:	fdc46783          	lwu	a5,-36(s0)
    80003dc4:	00279713          	slli	a4,a5,0x2
    80003dc8:	00006797          	auipc	a5,0x6
    80003dcc:	5b078793          	addi	a5,a5,1456 # 8000a378 <etext+0x378>
    80003dd0:	97ba                	add	a5,a5,a4
    80003dd2:	439c                	lw	a5,0(a5)
    80003dd4:	0007871b          	sext.w	a4,a5
    80003dd8:	00006797          	auipc	a5,0x6
    80003ddc:	5a078793          	addi	a5,a5,1440 # 8000a378 <etext+0x378>
    80003de0:	97ba                	add	a5,a5,a4
    80003de2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80003de4:	fe843783          	ld	a5,-24(s0)
    80003de8:	6fbc                	ld	a5,88(a5)
    80003dea:	7bbc                	ld	a5,112(a5)
    80003dec:	a081                	j	80003e2c <argraw+0x90>
  case 1:
    return p->trapframe->a1;
    80003dee:	fe843783          	ld	a5,-24(s0)
    80003df2:	6fbc                	ld	a5,88(a5)
    80003df4:	7fbc                	ld	a5,120(a5)
    80003df6:	a81d                	j	80003e2c <argraw+0x90>
  case 2:
    return p->trapframe->a2;
    80003df8:	fe843783          	ld	a5,-24(s0)
    80003dfc:	6fbc                	ld	a5,88(a5)
    80003dfe:	63dc                	ld	a5,128(a5)
    80003e00:	a035                	j	80003e2c <argraw+0x90>
  case 3:
    return p->trapframe->a3;
    80003e02:	fe843783          	ld	a5,-24(s0)
    80003e06:	6fbc                	ld	a5,88(a5)
    80003e08:	67dc                	ld	a5,136(a5)
    80003e0a:	a00d                	j	80003e2c <argraw+0x90>
  case 4:
    return p->trapframe->a4;
    80003e0c:	fe843783          	ld	a5,-24(s0)
    80003e10:	6fbc                	ld	a5,88(a5)
    80003e12:	6bdc                	ld	a5,144(a5)
    80003e14:	a821                	j	80003e2c <argraw+0x90>
  case 5:
    return p->trapframe->a5;
    80003e16:	fe843783          	ld	a5,-24(s0)
    80003e1a:	6fbc                	ld	a5,88(a5)
    80003e1c:	6fdc                	ld	a5,152(a5)
    80003e1e:	a039                	j	80003e2c <argraw+0x90>
  }
  panic("argraw");
    80003e20:	00006517          	auipc	a0,0x6
    80003e24:	55050513          	addi	a0,a0,1360 # 8000a370 <etext+0x370>
    80003e28:	80efd0ef          	jal	80000e36 <panic>
  return -1;
}
    80003e2c:	853e                	mv	a0,a5
    80003e2e:	70a2                	ld	ra,40(sp)
    80003e30:	7402                	ld	s0,32(sp)
    80003e32:	6145                	addi	sp,sp,48
    80003e34:	8082                	ret

0000000080003e36 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80003e36:	1101                	addi	sp,sp,-32
    80003e38:	ec06                	sd	ra,24(sp)
    80003e3a:	e822                	sd	s0,16(sp)
    80003e3c:	1000                	addi	s0,sp,32
    80003e3e:	87aa                	mv	a5,a0
    80003e40:	feb43023          	sd	a1,-32(s0)
    80003e44:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80003e48:	fec42783          	lw	a5,-20(s0)
    80003e4c:	853e                	mv	a0,a5
    80003e4e:	f4fff0ef          	jal	80003d9c <argraw>
    80003e52:	87aa                	mv	a5,a0
    80003e54:	0007871b          	sext.w	a4,a5
    80003e58:	fe043783          	ld	a5,-32(s0)
    80003e5c:	c398                	sw	a4,0(a5)
}
    80003e5e:	0001                	nop
    80003e60:	60e2                	ld	ra,24(sp)
    80003e62:	6442                	ld	s0,16(sp)
    80003e64:	6105                	addi	sp,sp,32
    80003e66:	8082                	ret

0000000080003e68 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80003e68:	1101                	addi	sp,sp,-32
    80003e6a:	ec06                	sd	ra,24(sp)
    80003e6c:	e822                	sd	s0,16(sp)
    80003e6e:	1000                	addi	s0,sp,32
    80003e70:	87aa                	mv	a5,a0
    80003e72:	feb43023          	sd	a1,-32(s0)
    80003e76:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80003e7a:	fec42783          	lw	a5,-20(s0)
    80003e7e:	853e                	mv	a0,a5
    80003e80:	f1dff0ef          	jal	80003d9c <argraw>
    80003e84:	872a                	mv	a4,a0
    80003e86:	fe043783          	ld	a5,-32(s0)
    80003e8a:	e398                	sd	a4,0(a5)
}
    80003e8c:	0001                	nop
    80003e8e:	60e2                	ld	ra,24(sp)
    80003e90:	6442                	ld	s0,16(sp)
    80003e92:	6105                	addi	sp,sp,32
    80003e94:	8082                	ret

0000000080003e96 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80003e96:	7179                	addi	sp,sp,-48
    80003e98:	f406                	sd	ra,40(sp)
    80003e9a:	f022                	sd	s0,32(sp)
    80003e9c:	1800                	addi	s0,sp,48
    80003e9e:	87aa                	mv	a5,a0
    80003ea0:	fcb43823          	sd	a1,-48(s0)
    80003ea4:	8732                	mv	a4,a2
    80003ea6:	fcf42e23          	sw	a5,-36(s0)
    80003eaa:	87ba                	mv	a5,a4
    80003eac:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  argaddr(n, &addr);
    80003eb0:	fe840713          	addi	a4,s0,-24
    80003eb4:	fdc42783          	lw	a5,-36(s0)
    80003eb8:	85ba                	mv	a1,a4
    80003eba:	853e                	mv	a0,a5
    80003ebc:	fadff0ef          	jal	80003e68 <argaddr>
  return fetchstr(addr, buf, max);
    80003ec0:	fe843783          	ld	a5,-24(s0)
    80003ec4:	fd842703          	lw	a4,-40(s0)
    80003ec8:	863a                	mv	a2,a4
    80003eca:	fd043583          	ld	a1,-48(s0)
    80003ece:	853e                	mv	a0,a5
    80003ed0:	e77ff0ef          	jal	80003d46 <fetchstr>
    80003ed4:	87aa                	mv	a5,a0
}
    80003ed6:	853e                	mv	a0,a5
    80003ed8:	70a2                	ld	ra,40(sp)
    80003eda:	7402                	ld	s0,32(sp)
    80003edc:	6145                	addi	sp,sp,48
    80003ede:	8082                	ret

0000000080003ee0 <syscall>:
[SYS_next_process] sys_next_process,
};

void
syscall(void)
{
    80003ee0:	7179                	addi	sp,sp,-48
    80003ee2:	f406                	sd	ra,40(sp)
    80003ee4:	f022                	sd	s0,32(sp)
    80003ee6:	ec26                	sd	s1,24(sp)
    80003ee8:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80003eea:	96bfe0ef          	jal	80002854 <myproc>
    80003eee:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80003ef2:	fd843783          	ld	a5,-40(s0)
    80003ef6:	6fbc                	ld	a5,88(a5)
    80003ef8:	77dc                	ld	a5,168(a5)
    80003efa:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80003efe:	fd442783          	lw	a5,-44(s0)
    80003f02:	2781                	sext.w	a5,a5
    80003f04:	04f05163          	blez	a5,80003f46 <syscall+0x66>
    80003f08:	fd442703          	lw	a4,-44(s0)
    80003f0c:	47dd                	li	a5,23
    80003f0e:	02e7ec63          	bltu	a5,a4,80003f46 <syscall+0x66>
    80003f12:	00007717          	auipc	a4,0x7
    80003f16:	91670713          	addi	a4,a4,-1770 # 8000a828 <syscalls>
    80003f1a:	fd442783          	lw	a5,-44(s0)
    80003f1e:	078e                	slli	a5,a5,0x3
    80003f20:	97ba                	add	a5,a5,a4
    80003f22:	639c                	ld	a5,0(a5)
    80003f24:	c38d                	beqz	a5,80003f46 <syscall+0x66>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80003f26:	00007717          	auipc	a4,0x7
    80003f2a:	90270713          	addi	a4,a4,-1790 # 8000a828 <syscalls>
    80003f2e:	fd442783          	lw	a5,-44(s0)
    80003f32:	078e                	slli	a5,a5,0x3
    80003f34:	97ba                	add	a5,a5,a4
    80003f36:	639c                	ld	a5,0(a5)
    80003f38:	fd843703          	ld	a4,-40(s0)
    80003f3c:	6f24                	ld	s1,88(a4)
    80003f3e:	9782                	jalr	a5
    80003f40:	87aa                	mv	a5,a0
    80003f42:	f8bc                	sd	a5,112(s1)
    80003f44:	a805                	j	80003f74 <syscall+0x94>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80003f46:	fd843783          	ld	a5,-40(s0)
    80003f4a:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    80003f4c:	fd843783          	ld	a5,-40(s0)
    80003f50:	15878793          	addi	a5,a5,344
    printf("%d %s: unknown sys call %d\n",
    80003f54:	fd442683          	lw	a3,-44(s0)
    80003f58:	863e                	mv	a2,a5
    80003f5a:	85ba                	mv	a1,a4
    80003f5c:	00006517          	auipc	a0,0x6
    80003f60:	43450513          	addi	a0,a0,1076 # 8000a390 <etext+0x390>
    80003f64:	a8bfc0ef          	jal	800009ee <printf>
    p->trapframe->a0 = -1;
    80003f68:	fd843783          	ld	a5,-40(s0)
    80003f6c:	6fbc                	ld	a5,88(a5)
    80003f6e:	577d                	li	a4,-1
    80003f70:	fbb8                	sd	a4,112(a5)
  }
}
    80003f72:	0001                	nop
    80003f74:	0001                	nop
    80003f76:	70a2                	ld	ra,40(sp)
    80003f78:	7402                	ld	s0,32(sp)
    80003f7a:	64e2                	ld	s1,24(sp)
    80003f7c:	6145                	addi	sp,sp,48
    80003f7e:	8082                	ret

0000000080003f80 <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    80003f80:	1101                	addi	sp,sp,-32
    80003f82:	ec06                	sd	ra,24(sp)
    80003f84:	e822                	sd	s0,16(sp)
    80003f86:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80003f88:	fec40793          	addi	a5,s0,-20
    80003f8c:	85be                	mv	a1,a5
    80003f8e:	4501                	li	a0,0
    80003f90:	ea7ff0ef          	jal	80003e36 <argint>
  kexit(n);
    80003f94:	fec42783          	lw	a5,-20(s0)
    80003f98:	853e                	mv	a0,a5
    80003f9a:	eb7fe0ef          	jal	80002e50 <kexit>
  return 0;  // not reached
    80003f9e:	4781                	li	a5,0
}
    80003fa0:	853e                	mv	a0,a5
    80003fa2:	60e2                	ld	ra,24(sp)
    80003fa4:	6442                	ld	s0,16(sp)
    80003fa6:	6105                	addi	sp,sp,32
    80003fa8:	8082                	ret

0000000080003faa <sys_getpid>:

uint64
sys_getpid(void)
{
    80003faa:	1141                	addi	sp,sp,-16
    80003fac:	e406                	sd	ra,8(sp)
    80003fae:	e022                	sd	s0,0(sp)
    80003fb0:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80003fb2:	8a3fe0ef          	jal	80002854 <myproc>
    80003fb6:	87aa                	mv	a5,a0
    80003fb8:	5b9c                	lw	a5,48(a5)
}
    80003fba:	853e                	mv	a0,a5
    80003fbc:	60a2                	ld	ra,8(sp)
    80003fbe:	6402                	ld	s0,0(sp)
    80003fc0:	0141                	addi	sp,sp,16
    80003fc2:	8082                	ret

0000000080003fc4 <sys_fork>:

uint64
sys_fork(void)
{
    80003fc4:	1141                	addi	sp,sp,-16
    80003fc6:	e406                	sd	ra,8(sp)
    80003fc8:	e022                	sd	s0,0(sp)
    80003fca:	0800                	addi	s0,sp,16
  return kfork();
    80003fcc:	c9ffe0ef          	jal	80002c6a <kfork>
    80003fd0:	87aa                	mv	a5,a0
}
    80003fd2:	853e                	mv	a0,a5
    80003fd4:	60a2                	ld	ra,8(sp)
    80003fd6:	6402                	ld	s0,0(sp)
    80003fd8:	0141                	addi	sp,sp,16
    80003fda:	8082                	ret

0000000080003fdc <sys_wait>:

uint64
sys_wait(void)
{
    80003fdc:	1101                	addi	sp,sp,-32
    80003fde:	ec06                	sd	ra,24(sp)
    80003fe0:	e822                	sd	s0,16(sp)
    80003fe2:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80003fe4:	fe840793          	addi	a5,s0,-24
    80003fe8:	85be                	mv	a1,a5
    80003fea:	4501                	li	a0,0
    80003fec:	e7dff0ef          	jal	80003e68 <argaddr>
  return kwait(p);
    80003ff0:	fe843783          	ld	a5,-24(s0)
    80003ff4:	853e                	mv	a0,a5
    80003ff6:	f63fe0ef          	jal	80002f58 <kwait>
    80003ffa:	87aa                	mv	a5,a0
}
    80003ffc:	853e                	mv	a0,a5
    80003ffe:	60e2                	ld	ra,24(sp)
    80004000:	6442                	ld	s0,16(sp)
    80004002:	6105                	addi	sp,sp,32
    80004004:	8082                	ret

0000000080004006 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004006:	1101                	addi	sp,sp,-32
    80004008:	ec06                	sd	ra,24(sp)
    8000400a:	e822                	sd	s0,16(sp)
    8000400c:	1000                	addi	s0,sp,32
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    8000400e:	fe040793          	addi	a5,s0,-32
    80004012:	85be                	mv	a1,a5
    80004014:	4501                	li	a0,0
    80004016:	e21ff0ef          	jal	80003e36 <argint>
  argint(1, &t);
    8000401a:	fe440793          	addi	a5,s0,-28
    8000401e:	85be                	mv	a1,a5
    80004020:	4505                	li	a0,1
    80004022:	e15ff0ef          	jal	80003e36 <argint>
  addr = myproc()->sz;
    80004026:	82ffe0ef          	jal	80002854 <myproc>
    8000402a:	87aa                	mv	a5,a0
    8000402c:	67bc                	ld	a5,72(a5)
    8000402e:	fef43423          	sd	a5,-24(s0)

  if(t == SBRK_EAGER || n < 0) {
    80004032:	fe442703          	lw	a4,-28(s0)
    80004036:	4785                	li	a5,1
    80004038:	00f70663          	beq	a4,a5,80004044 <sys_sbrk+0x3e>
    8000403c:	fe042783          	lw	a5,-32(s0)
    80004040:	0007dc63          	bgez	a5,80004058 <sys_sbrk+0x52>
    if(growproc(n) < 0) {
    80004044:	fe042783          	lw	a5,-32(s0)
    80004048:	853e                	mv	a0,a5
    8000404a:	b73fe0ef          	jal	80002bbc <growproc>
    8000404e:	87aa                	mv	a5,a0
    80004050:	0407d663          	bgez	a5,8000409c <sys_sbrk+0x96>
      return -1;
    80004054:	57fd                	li	a5,-1
    80004056:	a0a9                	j	800040a0 <sys_sbrk+0x9a>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80004058:	fe042783          	lw	a5,-32(s0)
    8000405c:	873e                	mv	a4,a5
    8000405e:	fe843783          	ld	a5,-24(s0)
    80004062:	97ba                	add	a5,a5,a4
    80004064:	fe843703          	ld	a4,-24(s0)
    80004068:	00e7f463          	bgeu	a5,a4,80004070 <sys_sbrk+0x6a>
      return -1;
    8000406c:	57fd                	li	a5,-1
    8000406e:	a80d                	j	800040a0 <sys_sbrk+0x9a>
    if(addr + n > TRAPFRAME)
    80004070:	fe042783          	lw	a5,-32(s0)
    80004074:	873e                	mv	a4,a5
    80004076:	fe843783          	ld	a5,-24(s0)
    8000407a:	973e                	add	a4,a4,a5
    8000407c:	020007b7          	lui	a5,0x2000
    80004080:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80004082:	07b6                	slli	a5,a5,0xd
    80004084:	00e7f463          	bgeu	a5,a4,8000408c <sys_sbrk+0x86>
      return -1;
    80004088:	57fd                	li	a5,-1
    8000408a:	a819                	j	800040a0 <sys_sbrk+0x9a>
    myproc()->sz += n;
    8000408c:	fc8fe0ef          	jal	80002854 <myproc>
    80004090:	87aa                	mv	a5,a0
    80004092:	67b8                	ld	a4,72(a5)
    80004094:	fe042683          	lw	a3,-32(s0)
    80004098:	9736                	add	a4,a4,a3
    8000409a:	e7b8                	sd	a4,72(a5)
  }
  return addr;
    8000409c:	fe843783          	ld	a5,-24(s0)
}
    800040a0:	853e                	mv	a0,a5
    800040a2:	60e2                	ld	ra,24(sp)
    800040a4:	6442                	ld	s0,16(sp)
    800040a6:	6105                	addi	sp,sp,32
    800040a8:	8082                	ret

00000000800040aa <sys_pause>:

uint64
sys_pause(void)
{
    800040aa:	1101                	addi	sp,sp,-32
    800040ac:	ec06                	sd	ra,24(sp)
    800040ae:	e822                	sd	s0,16(sp)
    800040b0:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  argint(0, &n);
    800040b2:	fe840793          	addi	a5,s0,-24
    800040b6:	85be                	mv	a1,a5
    800040b8:	4501                	li	a0,0
    800040ba:	d7dff0ef          	jal	80003e36 <argint>
  if(n < 0)
    800040be:	fe842783          	lw	a5,-24(s0)
    800040c2:	0007d463          	bgez	a5,800040ca <sys_pause+0x20>
    n = 0;
    800040c6:	fe042423          	sw	zero,-24(s0)
  acquire(&tickslock);
    800040ca:	00014517          	auipc	a0,0x14
    800040ce:	7ae50513          	addi	a0,a0,1966 # 80018878 <tickslock>
    800040d2:	a78fd0ef          	jal	8000134a <acquire>
  ticks0 = ticks;
    800040d6:	00007797          	auipc	a5,0x7
    800040da:	86278793          	addi	a5,a5,-1950 # 8000a938 <ticks>
    800040de:	439c                	lw	a5,0(a5)
    800040e0:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    800040e4:	a81d                	j	8000411a <sys_pause+0x70>
    if(killed(myproc())){
    800040e6:	f6efe0ef          	jal	80002854 <myproc>
    800040ea:	87aa                	mv	a5,a0
    800040ec:	853e                	mv	a0,a5
    800040ee:	bb6ff0ef          	jal	800034a4 <killed>
    800040f2:	87aa                	mv	a5,a0
    800040f4:	cb89                	beqz	a5,80004106 <sys_pause+0x5c>
      release(&tickslock);
    800040f6:	00014517          	auipc	a0,0x14
    800040fa:	78250513          	addi	a0,a0,1922 # 80018878 <tickslock>
    800040fe:	aa0fd0ef          	jal	8000139e <release>
      return -1;
    80004102:	57fd                	li	a5,-1
    80004104:	a83d                	j	80004142 <sys_pause+0x98>
    }
    sleep(&ticks, &tickslock);
    80004106:	00014597          	auipc	a1,0x14
    8000410a:	77258593          	addi	a1,a1,1906 # 80018878 <tickslock>
    8000410e:	00007517          	auipc	a0,0x7
    80004112:	82a50513          	addi	a0,a0,-2006 # 8000a938 <ticks>
    80004116:	9e0ff0ef          	jal	800032f6 <sleep>
  while(ticks - ticks0 < n){
    8000411a:	00007797          	auipc	a5,0x7
    8000411e:	81e78793          	addi	a5,a5,-2018 # 8000a938 <ticks>
    80004122:	439c                	lw	a5,0(a5)
    80004124:	fec42703          	lw	a4,-20(s0)
    80004128:	9f99                	subw	a5,a5,a4
    8000412a:	2781                	sext.w	a5,a5
    8000412c:	fe842703          	lw	a4,-24(s0)
    80004130:	fae7ebe3          	bltu	a5,a4,800040e6 <sys_pause+0x3c>
  }
  release(&tickslock);
    80004134:	00014517          	auipc	a0,0x14
    80004138:	74450513          	addi	a0,a0,1860 # 80018878 <tickslock>
    8000413c:	a62fd0ef          	jal	8000139e <release>
  return 0;
    80004140:	4781                	li	a5,0
}
    80004142:	853e                	mv	a0,a5
    80004144:	60e2                	ld	ra,24(sp)
    80004146:	6442                	ld	s0,16(sp)
    80004148:	6105                	addi	sp,sp,32
    8000414a:	8082                	ret

000000008000414c <sys_kill>:

uint64
sys_kill(void)
{
    8000414c:	1101                	addi	sp,sp,-32
    8000414e:	ec06                	sd	ra,24(sp)
    80004150:	e822                	sd	s0,16(sp)
    80004152:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80004154:	fec40793          	addi	a5,s0,-20
    80004158:	85be                	mv	a1,a5
    8000415a:	4501                	li	a0,0
    8000415c:	cdbff0ef          	jal	80003e36 <argint>
  return kkill(pid);
    80004160:	fec42783          	lw	a5,-20(s0)
    80004164:	853e                	mv	a0,a5
    80004166:	a7aff0ef          	jal	800033e0 <kkill>
    8000416a:	87aa                	mv	a5,a0
}
    8000416c:	853e                	mv	a0,a5
    8000416e:	60e2                	ld	ra,24(sp)
    80004170:	6442                	ld	s0,16(sp)
    80004172:	6105                	addi	sp,sp,32
    80004174:	8082                	ret

0000000080004176 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80004176:	1101                	addi	sp,sp,-32
    80004178:	ec06                	sd	ra,24(sp)
    8000417a:	e822                	sd	s0,16(sp)
    8000417c:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000417e:	00014517          	auipc	a0,0x14
    80004182:	6fa50513          	addi	a0,a0,1786 # 80018878 <tickslock>
    80004186:	9c4fd0ef          	jal	8000134a <acquire>
  xticks = ticks;
    8000418a:	00006797          	auipc	a5,0x6
    8000418e:	7ae78793          	addi	a5,a5,1966 # 8000a938 <ticks>
    80004192:	439c                	lw	a5,0(a5)
    80004194:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004198:	00014517          	auipc	a0,0x14
    8000419c:	6e050513          	addi	a0,a0,1760 # 80018878 <tickslock>
    800041a0:	9fefd0ef          	jal	8000139e <release>
  return xticks;
    800041a4:	fec46783          	lwu	a5,-20(s0)
}
    800041a8:	853e                	mv	a0,a5
    800041aa:	60e2                	ld	ra,24(sp)
    800041ac:	6442                	ld	s0,16(sp)
    800041ae:	6105                	addi	sp,sp,32
    800041b0:	8082                	ret

00000000800041b2 <sys_top>:
extern struct spinlock proc_lock;


uint64
sys_top(void)
{
    800041b2:	1101                	addi	sp,sp,-32
    800041b4:	ec06                	sd	ra,24(sp)
    800041b6:	e822                	sd	s0,16(sp)
    800041b8:	1000                	addi	s0,sp,32
  struct proc *p;
  // این خط به کامپایلر می‌گوید که جدول فرآیندها در جای دیگری تعریف شده است
  extern struct proc proc[NPROC];
  
  printf("PID\tName\t\tSize\t\tState\n");
    800041ba:	00006517          	auipc	a0,0x6
    800041be:	23650513          	addi	a0,a0,566 # 8000a3f0 <etext+0x3f0>
    800041c2:	82dfc0ef          	jal	800009ee <printf>
  printf("---\t----\t\t----\t\t-----\n");
    800041c6:	00006517          	auipc	a0,0x6
    800041ca:	24250513          	addi	a0,a0,578 # 8000a408 <etext+0x408>
    800041ce:	821fc0ef          	jal	800009ee <printf>
  
  for(p = proc; p < &proc[NPROC]; p++){
    800041d2:	0000f797          	auipc	a5,0xf
    800041d6:	c7678793          	addi	a5,a5,-906 # 80012e48 <proc>
    800041da:	fef43423          	sd	a5,-24(s0)
    800041de:	a8c5                	j	800042ce <sys_top+0x11c>
    acquire(&p->lock);
    800041e0:	fe843783          	ld	a5,-24(s0)
    800041e4:	853e                	mv	a0,a5
    800041e6:	964fd0ef          	jal	8000134a <acquire>
    if(p->state == SLEEPING || p->state == RUNNABLE || p->state == RUNNING || p->state == ZOMBIE){
    800041ea:	fe843783          	ld	a5,-24(s0)
    800041ee:	4f98                	lw	a4,24(a5)
    800041f0:	4789                	li	a5,2
    800041f2:	02f70463          	beq	a4,a5,8000421a <sys_top+0x68>
    800041f6:	fe843783          	ld	a5,-24(s0)
    800041fa:	4f98                	lw	a4,24(a5)
    800041fc:	478d                	li	a5,3
    800041fe:	00f70e63          	beq	a4,a5,8000421a <sys_top+0x68>
    80004202:	fe843783          	ld	a5,-24(s0)
    80004206:	4f98                	lw	a4,24(a5)
    80004208:	4791                	li	a5,4
    8000420a:	00f70863          	beq	a4,a5,8000421a <sys_top+0x68>
    8000420e:	fe843783          	ld	a5,-24(s0)
    80004212:	4f98                	lw	a4,24(a5)
    80004214:	4795                	li	a5,5
    80004216:	0af71163          	bne	a4,a5,800042b8 <sys_top+0x106>
      printf("%d\t%s", p->pid, p->name);
    8000421a:	fe843783          	ld	a5,-24(s0)
    8000421e:	5b98                	lw	a4,48(a5)
    80004220:	fe843783          	ld	a5,-24(s0)
    80004224:	15878793          	addi	a5,a5,344
    80004228:	863e                	mv	a2,a5
    8000422a:	85ba                	mv	a1,a4
    8000422c:	00006517          	auipc	a0,0x6
    80004230:	1f450513          	addi	a0,a0,500 # 8000a420 <etext+0x420>
    80004234:	fbafc0ef          	jal	800009ee <printf>
      
      int len = strlen(p->name);
    80004238:	fe843783          	ld	a5,-24(s0)
    8000423c:	15878793          	addi	a5,a5,344
    80004240:	853e                	mv	a0,a5
    80004242:	e28fd0ef          	jal	8000186a <strlen>
    80004246:	87aa                	mv	a5,a0
    80004248:	fef42223          	sw	a5,-28(s0)
      if(len < 8)
    8000424c:	fe442783          	lw	a5,-28(s0)
    80004250:	0007871b          	sext.w	a4,a5
    80004254:	479d                	li	a5,7
    80004256:	02e7ca63          	blt	a5,a4,8000428a <sys_top+0xd8>
        // اصلاح ۱: استفاده از فرمت صحیح %lu برای چاپ uint64
        printf("\t\t%lu\t\t%s\n", p->sz, proc_states[p->state]);
    8000425a:	fe843783          	ld	a5,-24(s0)
    8000425e:	67b4                	ld	a3,72(a5)
    80004260:	fe843783          	ld	a5,-24(s0)
    80004264:	4f9c                	lw	a5,24(a5)
    80004266:	00006717          	auipc	a4,0x6
    8000426a:	68270713          	addi	a4,a4,1666 # 8000a8e8 <proc_states>
    8000426e:	1782                	slli	a5,a5,0x20
    80004270:	9381                	srli	a5,a5,0x20
    80004272:	078e                	slli	a5,a5,0x3
    80004274:	97ba                	add	a5,a5,a4
    80004276:	639c                	ld	a5,0(a5)
    80004278:	863e                	mv	a2,a5
    8000427a:	85b6                	mv	a1,a3
    8000427c:	00006517          	auipc	a0,0x6
    80004280:	1ac50513          	addi	a0,a0,428 # 8000a428 <etext+0x428>
    80004284:	f6afc0ef          	jal	800009ee <printf>
    80004288:	a805                	j	800042b8 <sys_top+0x106>
      else
        // اصلاح ۱: استفاده از فرمت صحیح %lu برای چاپ uint64
        printf("\t%lu\t\t%s\n", p->sz, proc_states[p->state]);
    8000428a:	fe843783          	ld	a5,-24(s0)
    8000428e:	67b4                	ld	a3,72(a5)
    80004290:	fe843783          	ld	a5,-24(s0)
    80004294:	4f9c                	lw	a5,24(a5)
    80004296:	00006717          	auipc	a4,0x6
    8000429a:	65270713          	addi	a4,a4,1618 # 8000a8e8 <proc_states>
    8000429e:	1782                	slli	a5,a5,0x20
    800042a0:	9381                	srli	a5,a5,0x20
    800042a2:	078e                	slli	a5,a5,0x3
    800042a4:	97ba                	add	a5,a5,a4
    800042a6:	639c                	ld	a5,0(a5)
    800042a8:	863e                	mv	a2,a5
    800042aa:	85b6                	mv	a1,a3
    800042ac:	00006517          	auipc	a0,0x6
    800042b0:	18c50513          	addi	a0,a0,396 # 8000a438 <etext+0x438>
    800042b4:	f3afc0ef          	jal	800009ee <printf>
    }
    release(&p->lock);
    800042b8:	fe843783          	ld	a5,-24(s0)
    800042bc:	853e                	mv	a0,a5
    800042be:	8e0fd0ef          	jal	8000139e <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800042c2:	fe843783          	ld	a5,-24(s0)
    800042c6:	16878793          	addi	a5,a5,360
    800042ca:	fef43423          	sd	a5,-24(s0)
    800042ce:	fe843703          	ld	a4,-24(s0)
    800042d2:	00014797          	auipc	a5,0x14
    800042d6:	57678793          	addi	a5,a5,1398 # 80018848 <pid_lock>
    800042da:	f0f763e3          	bltu	a4,a5,800041e0 <sys_top+0x2e>
  }
  
  return 0;
    800042de:	4781                	li	a5,0
}
    800042e0:	853e                	mv	a0,a5
    800042e2:	60e2                	ld	ra,24(sp)
    800042e4:	6442                	ld	s0,16(sp)
    800042e6:	6105                	addi	sp,sp,32
    800042e8:	8082                	ret

00000000800042ea <sys_next_process>:


uint64
sys_next_process(void)
{
    800042ea:	715d                	addi	sp,sp,-80
    800042ec:	e486                	sd	ra,72(sp)
    800042ee:	e0a2                	sd	s0,64(sp)
    800042f0:	0880                	addi	s0,sp,80
  int before_pid;
  uint64 p_data_addr; // User space address
  struct proc *p;
  int search_started = 0;
    800042f2:	fe042223          	sw	zero,-28(s0)

  argint(0, &before_pid);
    800042f6:	fe040793          	addi	a5,s0,-32
    800042fa:	85be                	mv	a1,a5
    800042fc:	4501                	li	a0,0
    800042fe:	b39ff0ef          	jal	80003e36 <argint>
  argaddr(1, &p_data_addr);
    80004302:	fd840793          	addi	a5,s0,-40
    80004306:	85be                	mv	a1,a5
    80004308:	4505                	li	a0,1
    8000430a:	b5fff0ef          	jal	80003e68 <argaddr>
  
  if (before_pid == -1) {
    8000430e:	fe042703          	lw	a4,-32(s0)
    80004312:	57fd                	li	a5,-1
    80004314:	00f71563          	bne	a4,a5,8000431e <sys_next_process+0x34>
    search_started = 1;
    80004318:	4785                	li	a5,1
    8000431a:	fef42223          	sw	a5,-28(s0)
  }

  for (p = proc; p < &proc[NPROC]; p++) {
    8000431e:	0000f797          	auipc	a5,0xf
    80004322:	b2a78793          	addi	a5,a5,-1238 # 80012e48 <proc>
    80004326:	fef43423          	sd	a5,-24(s0)
    8000432a:	a8e9                	j	80004404 <sys_next_process+0x11a>
    // Acquire the lock for this specific process entry to safely read its state.
    acquire(&p->lock);
    8000432c:	fe843783          	ld	a5,-24(s0)
    80004330:	853e                	mv	a0,a5
    80004332:	818fd0ef          	jal	8000134a <acquire>

    if (p->state == UNUSED) {
    80004336:	fe843783          	ld	a5,-24(s0)
    8000433a:	4f9c                	lw	a5,24(a5)
    8000433c:	e799                	bnez	a5,8000434a <sys_next_process+0x60>
      release(&p->lock); // Must release before continuing
    8000433e:	fe843783          	ld	a5,-24(s0)
    80004342:	853e                	mv	a0,a5
    80004344:	85afd0ef          	jal	8000139e <release>
      continue;
    80004348:	a845                	j	800043f8 <sys_next_process+0x10e>
    }

    if (search_started) {
    8000434a:	fe442783          	lw	a5,-28(s0)
    8000434e:	2781                	sext.w	a5,a5
    80004350:	c7c9                	beqz	a5,800043da <sys_next_process+0xf0>
      // Found the next process.
      struct process_data data;
      data.pid = p->pid;
    80004352:	fe843783          	ld	a5,-24(s0)
    80004356:	5b9c                	lw	a5,48(a5)
    80004358:	faf42c23          	sw	a5,-72(s0)
      // p->parent is stable while we hold p->lock. Reading parent->pid is
      // a "dirty read" but acceptable for a tool like top.
      data.parent_id = p->parent ? p->parent->pid : 1;
    8000435c:	fe843783          	ld	a5,-24(s0)
    80004360:	7f9c                	ld	a5,56(a5)
    80004362:	c791                	beqz	a5,8000436e <sys_next_process+0x84>
    80004364:	fe843783          	ld	a5,-24(s0)
    80004368:	7f9c                	ld	a5,56(a5)
    8000436a:	5b9c                	lw	a5,48(a5)
    8000436c:	a011                	j	80004370 <sys_next_process+0x86>
    8000436e:	4785                	li	a5,1
    80004370:	faf42e23          	sw	a5,-68(s0)
      data.size = p->sz;
    80004374:	fe843783          	ld	a5,-24(s0)
    80004378:	67bc                	ld	a5,72(a5)
    8000437a:	2781                	sext.w	a5,a5
    8000437c:	fcf42023          	sw	a5,-64(s0)
      data.state = p->state;
    80004380:	fe843783          	ld	a5,-24(s0)
    80004384:	4f9c                	lw	a5,24(a5)
    80004386:	fcf42223          	sw	a5,-60(s0)
      safestrcpy(data.name, p->name, sizeof(data.name));
    8000438a:	fe843783          	ld	a5,-24(s0)
    8000438e:	15878713          	addi	a4,a5,344
    80004392:	fb840793          	addi	a5,s0,-72
    80004396:	07c1                	addi	a5,a5,16
    80004398:	4641                	li	a2,16
    8000439a:	85ba                	mv	a1,a4
    8000439c:	853e                	mv	a0,a5
    8000439e:	c4cfd0ef          	jal	800017ea <safestrcpy>

      // Release the lock *before* copying data to user space.
      release(&p->lock);
    800043a2:	fe843783          	ld	a5,-24(s0)
    800043a6:	853e                	mv	a0,a5
    800043a8:	ff7fc0ef          	jal	8000139e <release>

      if (copyout(myproc()->pagetable, p_data_addr, (char *)&data, sizeof(data)) < 0) {
    800043ac:	ca8fe0ef          	jal	80002854 <myproc>
    800043b0:	87aa                	mv	a5,a0
    800043b2:	6bbc                	ld	a5,80(a5)
    800043b4:	fd843703          	ld	a4,-40(s0)
    800043b8:	fb840613          	addi	a2,s0,-72
    800043bc:	02000693          	li	a3,32
    800043c0:	85ba                	mv	a1,a4
    800043c2:	853e                	mv	a0,a5
    800043c4:	e1ffd0ef          	jal	800021e2 <copyout>
    800043c8:	87aa                	mv	a5,a0
    800043ca:	0007d463          	bgez	a5,800043d2 <sys_next_process+0xe8>
        return 0; // Copy failed
    800043ce:	4781                	li	a5,0
    800043d0:	a099                	j	80004416 <sys_next_process+0x12c>
      }
      
      return p->pid; // Success, return the PID of the found process
    800043d2:	fe843783          	ld	a5,-24(s0)
    800043d6:	5b9c                	lw	a5,48(a5)
    800043d8:	a83d                	j	80004416 <sys_next_process+0x12c>
    }

    if (p->pid == before_pid) {
    800043da:	fe843783          	ld	a5,-24(s0)
    800043de:	5b98                	lw	a4,48(a5)
    800043e0:	fe042783          	lw	a5,-32(s0)
    800043e4:	00f71563          	bne	a4,a5,800043ee <sys_next_process+0x104>
      search_started = 1;
    800043e8:	4785                	li	a5,1
    800043ea:	fef42223          	sw	a5,-28(s0)
    }
    
    // Release lock before moving to the next process in the loop.
    release(&p->lock);
    800043ee:	fe843783          	ld	a5,-24(s0)
    800043f2:	853e                	mv	a0,a5
    800043f4:	fabfc0ef          	jal	8000139e <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    800043f8:	fe843783          	ld	a5,-24(s0)
    800043fc:	16878793          	addi	a5,a5,360
    80004400:	fef43423          	sd	a5,-24(s0)
    80004404:	fe843703          	ld	a4,-24(s0)
    80004408:	00014797          	auipc	a5,0x14
    8000440c:	44078793          	addi	a5,a5,1088 # 80018848 <pid_lock>
    80004410:	f0f76ee3          	bltu	a4,a5,8000432c <sys_next_process+0x42>
  }

  // Reached the end of the process table.
  return 0;
    80004414:	4781                	li	a5,0
    80004416:	853e                	mv	a0,a5
    80004418:	60a6                	ld	ra,72(sp)
    8000441a:	6406                	ld	s0,64(sp)
    8000441c:	6161                	addi	sp,sp,80
    8000441e:	8082                	ret

0000000080004420 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004420:	1101                	addi	sp,sp,-32
    80004422:	ec06                	sd	ra,24(sp)
    80004424:	e822                	sd	s0,16(sp)
    80004426:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80004428:	00006597          	auipc	a1,0x6
    8000442c:	02058593          	addi	a1,a1,32 # 8000a448 <etext+0x448>
    80004430:	00014517          	auipc	a0,0x14
    80004434:	46050513          	addi	a0,a0,1120 # 80018890 <bcache>
    80004438:	edffc0ef          	jal	80001316 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000443c:	00014717          	auipc	a4,0x14
    80004440:	45470713          	addi	a4,a4,1108 # 80018890 <bcache>
    80004444:	67a1                	lui	a5,0x8
    80004446:	97ba                	add	a5,a5,a4
    80004448:	0001c717          	auipc	a4,0x1c
    8000444c:	6b070713          	addi	a4,a4,1712 # 80020af8 <bcache+0x8268>
    80004450:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    80004454:	00014717          	auipc	a4,0x14
    80004458:	43c70713          	addi	a4,a4,1084 # 80018890 <bcache>
    8000445c:	67a1                	lui	a5,0x8
    8000445e:	97ba                	add	a5,a5,a4
    80004460:	0001c717          	auipc	a4,0x1c
    80004464:	69870713          	addi	a4,a4,1688 # 80020af8 <bcache+0x8268>
    80004468:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000446c:	00014797          	auipc	a5,0x14
    80004470:	43c78793          	addi	a5,a5,1084 # 800188a8 <bcache+0x18>
    80004474:	fef43423          	sd	a5,-24(s0)
    80004478:	a885                	j	800044e8 <binit+0xc8>
    b->next = bcache.head.next;
    8000447a:	00014717          	auipc	a4,0x14
    8000447e:	41670713          	addi	a4,a4,1046 # 80018890 <bcache>
    80004482:	67a1                	lui	a5,0x8
    80004484:	97ba                	add	a5,a5,a4
    80004486:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000448a:	fe843783          	ld	a5,-24(s0)
    8000448e:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004490:	fe843783          	ld	a5,-24(s0)
    80004494:	0001c717          	auipc	a4,0x1c
    80004498:	66470713          	addi	a4,a4,1636 # 80020af8 <bcache+0x8268>
    8000449c:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    8000449e:	fe843783          	ld	a5,-24(s0)
    800044a2:	07c1                	addi	a5,a5,16
    800044a4:	00006597          	auipc	a1,0x6
    800044a8:	fac58593          	addi	a1,a1,-84 # 8000a450 <etext+0x450>
    800044ac:	853e                	mv	a0,a5
    800044ae:	61d010ef          	jal	800062ca <initsleeplock>
    bcache.head.next->prev = b;
    800044b2:	00014717          	auipc	a4,0x14
    800044b6:	3de70713          	addi	a4,a4,990 # 80018890 <bcache>
    800044ba:	67a1                	lui	a5,0x8
    800044bc:	97ba                	add	a5,a5,a4
    800044be:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800044c2:	fe843703          	ld	a4,-24(s0)
    800044c6:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800044c8:	00014717          	auipc	a4,0x14
    800044cc:	3c870713          	addi	a4,a4,968 # 80018890 <bcache>
    800044d0:	67a1                	lui	a5,0x8
    800044d2:	97ba                	add	a5,a5,a4
    800044d4:	fe843703          	ld	a4,-24(s0)
    800044d8:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800044dc:	fe843783          	ld	a5,-24(s0)
    800044e0:	45878793          	addi	a5,a5,1112
    800044e4:	fef43423          	sd	a5,-24(s0)
    800044e8:	0001c797          	auipc	a5,0x1c
    800044ec:	61078793          	addi	a5,a5,1552 # 80020af8 <bcache+0x8268>
    800044f0:	fe843703          	ld	a4,-24(s0)
    800044f4:	f8f763e3          	bltu	a4,a5,8000447a <binit+0x5a>
  }
}
    800044f8:	0001                	nop
    800044fa:	0001                	nop
    800044fc:	60e2                	ld	ra,24(sp)
    800044fe:	6442                	ld	s0,16(sp)
    80004500:	6105                	addi	sp,sp,32
    80004502:	8082                	ret

0000000080004504 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80004504:	7179                	addi	sp,sp,-48
    80004506:	f406                	sd	ra,40(sp)
    80004508:	f022                	sd	s0,32(sp)
    8000450a:	1800                	addi	s0,sp,48
    8000450c:	87aa                	mv	a5,a0
    8000450e:	872e                	mv	a4,a1
    80004510:	fcf42e23          	sw	a5,-36(s0)
    80004514:	87ba                	mv	a5,a4
    80004516:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    8000451a:	00014517          	auipc	a0,0x14
    8000451e:	37650513          	addi	a0,a0,886 # 80018890 <bcache>
    80004522:	e29fc0ef          	jal	8000134a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004526:	00014717          	auipc	a4,0x14
    8000452a:	36a70713          	addi	a4,a4,874 # 80018890 <bcache>
    8000452e:	67a1                	lui	a5,0x8
    80004530:	97ba                	add	a5,a5,a4
    80004532:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004536:	fef43423          	sd	a5,-24(s0)
    8000453a:	a8b1                	j	80004596 <bget+0x92>
    if(b->dev == dev && b->blockno == blockno){
    8000453c:	fe843783          	ld	a5,-24(s0)
    80004540:	479c                	lw	a5,8(a5)
    80004542:	fdc42703          	lw	a4,-36(s0)
    80004546:	2701                	sext.w	a4,a4
    80004548:	04f71263          	bne	a4,a5,8000458c <bget+0x88>
    8000454c:	fe843783          	ld	a5,-24(s0)
    80004550:	47dc                	lw	a5,12(a5)
    80004552:	fd842703          	lw	a4,-40(s0)
    80004556:	2701                	sext.w	a4,a4
    80004558:	02f71a63          	bne	a4,a5,8000458c <bget+0x88>
      b->refcnt++;
    8000455c:	fe843783          	ld	a5,-24(s0)
    80004560:	43bc                	lw	a5,64(a5)
    80004562:	2785                	addiw	a5,a5,1
    80004564:	0007871b          	sext.w	a4,a5
    80004568:	fe843783          	ld	a5,-24(s0)
    8000456c:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    8000456e:	00014517          	auipc	a0,0x14
    80004572:	32250513          	addi	a0,a0,802 # 80018890 <bcache>
    80004576:	e29fc0ef          	jal	8000139e <release>
      acquiresleep(&b->lock);
    8000457a:	fe843783          	ld	a5,-24(s0)
    8000457e:	07c1                	addi	a5,a5,16
    80004580:	853e                	mv	a0,a5
    80004582:	591010ef          	jal	80006312 <acquiresleep>
      return b;
    80004586:	fe843783          	ld	a5,-24(s0)
    8000458a:	a04d                	j	8000462c <bget+0x128>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000458c:	fe843783          	ld	a5,-24(s0)
    80004590:	6bbc                	ld	a5,80(a5)
    80004592:	fef43423          	sd	a5,-24(s0)
    80004596:	fe843703          	ld	a4,-24(s0)
    8000459a:	0001c797          	auipc	a5,0x1c
    8000459e:	55e78793          	addi	a5,a5,1374 # 80020af8 <bcache+0x8268>
    800045a2:	f8f71de3          	bne	a4,a5,8000453c <bget+0x38>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800045a6:	00014717          	auipc	a4,0x14
    800045aa:	2ea70713          	addi	a4,a4,746 # 80018890 <bcache>
    800045ae:	67a1                	lui	a5,0x8
    800045b0:	97ba                	add	a5,a5,a4
    800045b2:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800045b6:	fef43423          	sd	a5,-24(s0)
    800045ba:	a899                	j	80004610 <bget+0x10c>
    if(b->refcnt == 0) {
    800045bc:	fe843783          	ld	a5,-24(s0)
    800045c0:	43bc                	lw	a5,64(a5)
    800045c2:	e3b1                	bnez	a5,80004606 <bget+0x102>
      b->dev = dev;
    800045c4:	fe843783          	ld	a5,-24(s0)
    800045c8:	fdc42703          	lw	a4,-36(s0)
    800045cc:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800045ce:	fe843783          	ld	a5,-24(s0)
    800045d2:	fd842703          	lw	a4,-40(s0)
    800045d6:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    800045d8:	fe843783          	ld	a5,-24(s0)
    800045dc:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    800045e0:	fe843783          	ld	a5,-24(s0)
    800045e4:	4705                	li	a4,1
    800045e6:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800045e8:	00014517          	auipc	a0,0x14
    800045ec:	2a850513          	addi	a0,a0,680 # 80018890 <bcache>
    800045f0:	daffc0ef          	jal	8000139e <release>
      acquiresleep(&b->lock);
    800045f4:	fe843783          	ld	a5,-24(s0)
    800045f8:	07c1                	addi	a5,a5,16
    800045fa:	853e                	mv	a0,a5
    800045fc:	517010ef          	jal	80006312 <acquiresleep>
      return b;
    80004600:	fe843783          	ld	a5,-24(s0)
    80004604:	a025                	j	8000462c <bget+0x128>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004606:	fe843783          	ld	a5,-24(s0)
    8000460a:	67bc                	ld	a5,72(a5)
    8000460c:	fef43423          	sd	a5,-24(s0)
    80004610:	fe843703          	ld	a4,-24(s0)
    80004614:	0001c797          	auipc	a5,0x1c
    80004618:	4e478793          	addi	a5,a5,1252 # 80020af8 <bcache+0x8268>
    8000461c:	faf710e3          	bne	a4,a5,800045bc <bget+0xb8>
    }
  }
  panic("bget: no buffers");
    80004620:	00006517          	auipc	a0,0x6
    80004624:	e3850513          	addi	a0,a0,-456 # 8000a458 <etext+0x458>
    80004628:	80ffc0ef          	jal	80000e36 <panic>
}
    8000462c:	853e                	mv	a0,a5
    8000462e:	70a2                	ld	ra,40(sp)
    80004630:	7402                	ld	s0,32(sp)
    80004632:	6145                	addi	sp,sp,48
    80004634:	8082                	ret

0000000080004636 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80004636:	7179                	addi	sp,sp,-48
    80004638:	f406                	sd	ra,40(sp)
    8000463a:	f022                	sd	s0,32(sp)
    8000463c:	1800                	addi	s0,sp,48
    8000463e:	87aa                	mv	a5,a0
    80004640:	872e                	mv	a4,a1
    80004642:	fcf42e23          	sw	a5,-36(s0)
    80004646:	87ba                	mv	a5,a4
    80004648:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    8000464c:	fd842703          	lw	a4,-40(s0)
    80004650:	fdc42783          	lw	a5,-36(s0)
    80004654:	85ba                	mv	a1,a4
    80004656:	853e                	mv	a0,a5
    80004658:	eadff0ef          	jal	80004504 <bget>
    8000465c:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    80004660:	fe843783          	ld	a5,-24(s0)
    80004664:	439c                	lw	a5,0(a5)
    80004666:	eb91                	bnez	a5,8000467a <bread+0x44>
    virtio_disk_rw(b, 0);
    80004668:	4581                	li	a1,0
    8000466a:	fe843503          	ld	a0,-24(s0)
    8000466e:	208040ef          	jal	80008876 <virtio_disk_rw>
    b->valid = 1;
    80004672:	fe843783          	ld	a5,-24(s0)
    80004676:	4705                	li	a4,1
    80004678:	c398                	sw	a4,0(a5)
  }
  return b;
    8000467a:	fe843783          	ld	a5,-24(s0)
}
    8000467e:	853e                	mv	a0,a5
    80004680:	70a2                	ld	ra,40(sp)
    80004682:	7402                	ld	s0,32(sp)
    80004684:	6145                	addi	sp,sp,48
    80004686:	8082                	ret

0000000080004688 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80004688:	1101                	addi	sp,sp,-32
    8000468a:	ec06                	sd	ra,24(sp)
    8000468c:	e822                	sd	s0,16(sp)
    8000468e:	1000                	addi	s0,sp,32
    80004690:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004694:	fe843783          	ld	a5,-24(s0)
    80004698:	07c1                	addi	a5,a5,16
    8000469a:	853e                	mv	a0,a5
    8000469c:	51b010ef          	jal	800063b6 <holdingsleep>
    800046a0:	87aa                	mv	a5,a0
    800046a2:	e799                	bnez	a5,800046b0 <bwrite+0x28>
    panic("bwrite");
    800046a4:	00006517          	auipc	a0,0x6
    800046a8:	dcc50513          	addi	a0,a0,-564 # 8000a470 <etext+0x470>
    800046ac:	f8afc0ef          	jal	80000e36 <panic>
  virtio_disk_rw(b, 1);
    800046b0:	4585                	li	a1,1
    800046b2:	fe843503          	ld	a0,-24(s0)
    800046b6:	1c0040ef          	jal	80008876 <virtio_disk_rw>
}
    800046ba:	0001                	nop
    800046bc:	60e2                	ld	ra,24(sp)
    800046be:	6442                	ld	s0,16(sp)
    800046c0:	6105                	addi	sp,sp,32
    800046c2:	8082                	ret

00000000800046c4 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800046c4:	1101                	addi	sp,sp,-32
    800046c6:	ec06                	sd	ra,24(sp)
    800046c8:	e822                	sd	s0,16(sp)
    800046ca:	1000                	addi	s0,sp,32
    800046cc:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800046d0:	fe843783          	ld	a5,-24(s0)
    800046d4:	07c1                	addi	a5,a5,16
    800046d6:	853e                	mv	a0,a5
    800046d8:	4df010ef          	jal	800063b6 <holdingsleep>
    800046dc:	87aa                	mv	a5,a0
    800046de:	e799                	bnez	a5,800046ec <brelse+0x28>
    panic("brelse");
    800046e0:	00006517          	auipc	a0,0x6
    800046e4:	d9850513          	addi	a0,a0,-616 # 8000a478 <etext+0x478>
    800046e8:	f4efc0ef          	jal	80000e36 <panic>

  releasesleep(&b->lock);
    800046ec:	fe843783          	ld	a5,-24(s0)
    800046f0:	07c1                	addi	a5,a5,16
    800046f2:	853e                	mv	a0,a5
    800046f4:	47d010ef          	jal	80006370 <releasesleep>

  acquire(&bcache.lock);
    800046f8:	00014517          	auipc	a0,0x14
    800046fc:	19850513          	addi	a0,a0,408 # 80018890 <bcache>
    80004700:	c4bfc0ef          	jal	8000134a <acquire>
  b->refcnt--;
    80004704:	fe843783          	ld	a5,-24(s0)
    80004708:	43bc                	lw	a5,64(a5)
    8000470a:	37fd                	addiw	a5,a5,-1
    8000470c:	0007871b          	sext.w	a4,a5
    80004710:	fe843783          	ld	a5,-24(s0)
    80004714:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004716:	fe843783          	ld	a5,-24(s0)
    8000471a:	43bc                	lw	a5,64(a5)
    8000471c:	e7b5                	bnez	a5,80004788 <brelse+0xc4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000471e:	fe843783          	ld	a5,-24(s0)
    80004722:	6bbc                	ld	a5,80(a5)
    80004724:	fe843703          	ld	a4,-24(s0)
    80004728:	6738                	ld	a4,72(a4)
    8000472a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000472c:	fe843783          	ld	a5,-24(s0)
    80004730:	67bc                	ld	a5,72(a5)
    80004732:	fe843703          	ld	a4,-24(s0)
    80004736:	6b38                	ld	a4,80(a4)
    80004738:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000473a:	00014717          	auipc	a4,0x14
    8000473e:	15670713          	addi	a4,a4,342 # 80018890 <bcache>
    80004742:	67a1                	lui	a5,0x8
    80004744:	97ba                	add	a5,a5,a4
    80004746:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000474a:	fe843783          	ld	a5,-24(s0)
    8000474e:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004750:	fe843783          	ld	a5,-24(s0)
    80004754:	0001c717          	auipc	a4,0x1c
    80004758:	3a470713          	addi	a4,a4,932 # 80020af8 <bcache+0x8268>
    8000475c:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    8000475e:	00014717          	auipc	a4,0x14
    80004762:	13270713          	addi	a4,a4,306 # 80018890 <bcache>
    80004766:	67a1                	lui	a5,0x8
    80004768:	97ba                	add	a5,a5,a4
    8000476a:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    8000476e:	fe843703          	ld	a4,-24(s0)
    80004772:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004774:	00014717          	auipc	a4,0x14
    80004778:	11c70713          	addi	a4,a4,284 # 80018890 <bcache>
    8000477c:	67a1                	lui	a5,0x8
    8000477e:	97ba                	add	a5,a5,a4
    80004780:	fe843703          	ld	a4,-24(s0)
    80004784:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80004788:	00014517          	auipc	a0,0x14
    8000478c:	10850513          	addi	a0,a0,264 # 80018890 <bcache>
    80004790:	c0ffc0ef          	jal	8000139e <release>
}
    80004794:	0001                	nop
    80004796:	60e2                	ld	ra,24(sp)
    80004798:	6442                	ld	s0,16(sp)
    8000479a:	6105                	addi	sp,sp,32
    8000479c:	8082                	ret

000000008000479e <bpin>:

void
bpin(struct buf *b) {
    8000479e:	1101                	addi	sp,sp,-32
    800047a0:	ec06                	sd	ra,24(sp)
    800047a2:	e822                	sd	s0,16(sp)
    800047a4:	1000                	addi	s0,sp,32
    800047a6:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    800047aa:	00014517          	auipc	a0,0x14
    800047ae:	0e650513          	addi	a0,a0,230 # 80018890 <bcache>
    800047b2:	b99fc0ef          	jal	8000134a <acquire>
  b->refcnt++;
    800047b6:	fe843783          	ld	a5,-24(s0)
    800047ba:	43bc                	lw	a5,64(a5)
    800047bc:	2785                	addiw	a5,a5,1
    800047be:	0007871b          	sext.w	a4,a5
    800047c2:	fe843783          	ld	a5,-24(s0)
    800047c6:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    800047c8:	00014517          	auipc	a0,0x14
    800047cc:	0c850513          	addi	a0,a0,200 # 80018890 <bcache>
    800047d0:	bcffc0ef          	jal	8000139e <release>
}
    800047d4:	0001                	nop
    800047d6:	60e2                	ld	ra,24(sp)
    800047d8:	6442                	ld	s0,16(sp)
    800047da:	6105                	addi	sp,sp,32
    800047dc:	8082                	ret

00000000800047de <bunpin>:

void
bunpin(struct buf *b) {
    800047de:	1101                	addi	sp,sp,-32
    800047e0:	ec06                	sd	ra,24(sp)
    800047e2:	e822                	sd	s0,16(sp)
    800047e4:	1000                	addi	s0,sp,32
    800047e6:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    800047ea:	00014517          	auipc	a0,0x14
    800047ee:	0a650513          	addi	a0,a0,166 # 80018890 <bcache>
    800047f2:	b59fc0ef          	jal	8000134a <acquire>
  b->refcnt--;
    800047f6:	fe843783          	ld	a5,-24(s0)
    800047fa:	43bc                	lw	a5,64(a5)
    800047fc:	37fd                	addiw	a5,a5,-1
    800047fe:	0007871b          	sext.w	a4,a5
    80004802:	fe843783          	ld	a5,-24(s0)
    80004806:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004808:	00014517          	auipc	a0,0x14
    8000480c:	08850513          	addi	a0,a0,136 # 80018890 <bcache>
    80004810:	b8ffc0ef          	jal	8000139e <release>
}
    80004814:	0001                	nop
    80004816:	60e2                	ld	ra,24(sp)
    80004818:	6442                	ld	s0,16(sp)
    8000481a:	6105                	addi	sp,sp,32
    8000481c:	8082                	ret

000000008000481e <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    8000481e:	7179                	addi	sp,sp,-48
    80004820:	f406                	sd	ra,40(sp)
    80004822:	f022                	sd	s0,32(sp)
    80004824:	1800                	addi	s0,sp,48
    80004826:	87aa                	mv	a5,a0
    80004828:	fcb43823          	sd	a1,-48(s0)
    8000482c:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004830:	fdc42783          	lw	a5,-36(s0)
    80004834:	4585                	li	a1,1
    80004836:	853e                	mv	a0,a5
    80004838:	dffff0ef          	jal	80004636 <bread>
    8000483c:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80004840:	fe843783          	ld	a5,-24(s0)
    80004844:	05878793          	addi	a5,a5,88
    80004848:	02000613          	li	a2,32
    8000484c:	85be                	mv	a1,a5
    8000484e:	fd043503          	ld	a0,-48(s0)
    80004852:	d71fc0ef          	jal	800015c2 <memmove>
  brelse(bp);
    80004856:	fe843503          	ld	a0,-24(s0)
    8000485a:	e6bff0ef          	jal	800046c4 <brelse>
}
    8000485e:	0001                	nop
    80004860:	70a2                	ld	ra,40(sp)
    80004862:	7402                	ld	s0,32(sp)
    80004864:	6145                	addi	sp,sp,48
    80004866:	8082                	ret

0000000080004868 <fsinit>:

// Init fs
void
fsinit(int dev) {
    80004868:	1101                	addi	sp,sp,-32
    8000486a:	ec06                	sd	ra,24(sp)
    8000486c:	e822                	sd	s0,16(sp)
    8000486e:	1000                	addi	s0,sp,32
    80004870:	87aa                	mv	a5,a0
    80004872:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    80004876:	fec42783          	lw	a5,-20(s0)
    8000487a:	0001c597          	auipc	a1,0x1c
    8000487e:	6d658593          	addi	a1,a1,1750 # 80020f50 <sb>
    80004882:	853e                	mv	a0,a5
    80004884:	f9bff0ef          	jal	8000481e <readsb>
  if(sb.magic != FSMAGIC)
    80004888:	0001c797          	auipc	a5,0x1c
    8000488c:	6c878793          	addi	a5,a5,1736 # 80020f50 <sb>
    80004890:	4398                	lw	a4,0(a5)
    80004892:	102037b7          	lui	a5,0x10203
    80004896:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000489a:	00f70863          	beq	a4,a5,800048aa <fsinit+0x42>
    panic("invalid file system");
    8000489e:	00006517          	auipc	a0,0x6
    800048a2:	be250513          	addi	a0,a0,-1054 # 8000a480 <etext+0x480>
    800048a6:	d90fc0ef          	jal	80000e36 <panic>
  initlog(dev, &sb);
    800048aa:	fec42783          	lw	a5,-20(s0)
    800048ae:	0001c597          	auipc	a1,0x1c
    800048b2:	6a258593          	addi	a1,a1,1698 # 80020f50 <sb>
    800048b6:	853e                	mv	a0,a5
    800048b8:	3c6010ef          	jal	80005c7e <initlog>
  ireclaim(dev);
    800048bc:	fec42783          	lw	a5,-20(s0)
    800048c0:	853e                	mv	a0,a5
    800048c2:	0b5000ef          	jal	80005176 <ireclaim>
}
    800048c6:	0001                	nop
    800048c8:	60e2                	ld	ra,24(sp)
    800048ca:	6442                	ld	s0,16(sp)
    800048cc:	6105                	addi	sp,sp,32
    800048ce:	8082                	ret

00000000800048d0 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    800048d0:	7179                	addi	sp,sp,-48
    800048d2:	f406                	sd	ra,40(sp)
    800048d4:	f022                	sd	s0,32(sp)
    800048d6:	1800                	addi	s0,sp,48
    800048d8:	87aa                	mv	a5,a0
    800048da:	872e                	mv	a4,a1
    800048dc:	fcf42e23          	sw	a5,-36(s0)
    800048e0:	87ba                	mv	a5,a4
    800048e2:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    800048e6:	fdc42783          	lw	a5,-36(s0)
    800048ea:	fd842703          	lw	a4,-40(s0)
    800048ee:	85ba                	mv	a1,a4
    800048f0:	853e                	mv	a0,a5
    800048f2:	d45ff0ef          	jal	80004636 <bread>
    800048f6:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    800048fa:	fe843783          	ld	a5,-24(s0)
    800048fe:	05878793          	addi	a5,a5,88
    80004902:	40000613          	li	a2,1024
    80004906:	4581                	li	a1,0
    80004908:	853e                	mv	a0,a5
    8000490a:	bcdfc0ef          	jal	800014d6 <memset>
  log_write(bp);
    8000490e:	fe843503          	ld	a0,-24(s0)
    80004912:	0bb010ef          	jal	800061cc <log_write>
  brelse(bp);
    80004916:	fe843503          	ld	a0,-24(s0)
    8000491a:	dabff0ef          	jal	800046c4 <brelse>
}
    8000491e:	0001                	nop
    80004920:	70a2                	ld	ra,40(sp)
    80004922:	7402                	ld	s0,32(sp)
    80004924:	6145                	addi	sp,sp,48
    80004926:	8082                	ret

0000000080004928 <balloc>:

// Allocate a zeroed disk block.
// returns 0 if out of disk space.
static uint
balloc(uint dev)
{
    80004928:	7139                	addi	sp,sp,-64
    8000492a:	fc06                	sd	ra,56(sp)
    8000492c:	f822                	sd	s0,48(sp)
    8000492e:	0080                	addi	s0,sp,64
    80004930:	87aa                	mv	a5,a0
    80004932:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004936:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    8000493a:	fe042623          	sw	zero,-20(s0)
    8000493e:	a2a9                	j	80004a88 <balloc+0x160>
    bp = bread(dev, BBLOCK(b, sb));
    80004940:	fec42783          	lw	a5,-20(s0)
    80004944:	41f7d71b          	sraiw	a4,a5,0x1f
    80004948:	0137571b          	srliw	a4,a4,0x13
    8000494c:	9fb9                	addw	a5,a5,a4
    8000494e:	40d7d79b          	sraiw	a5,a5,0xd
    80004952:	2781                	sext.w	a5,a5
    80004954:	873e                	mv	a4,a5
    80004956:	0001c797          	auipc	a5,0x1c
    8000495a:	5fa78793          	addi	a5,a5,1530 # 80020f50 <sb>
    8000495e:	4fdc                	lw	a5,28(a5)
    80004960:	9fb9                	addw	a5,a5,a4
    80004962:	0007871b          	sext.w	a4,a5
    80004966:	fcc42783          	lw	a5,-52(s0)
    8000496a:	85ba                	mv	a1,a4
    8000496c:	853e                	mv	a0,a5
    8000496e:	cc9ff0ef          	jal	80004636 <bread>
    80004972:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004976:	fe042423          	sw	zero,-24(s0)
    8000497a:	a0f1                	j	80004a46 <balloc+0x11e>
      m = 1 << (bi % 8);
    8000497c:	fe842783          	lw	a5,-24(s0)
    80004980:	8b9d                	andi	a5,a5,7
    80004982:	2781                	sext.w	a5,a5
    80004984:	4705                	li	a4,1
    80004986:	00f717bb          	sllw	a5,a4,a5
    8000498a:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000498e:	fe842783          	lw	a5,-24(s0)
    80004992:	41f7d71b          	sraiw	a4,a5,0x1f
    80004996:	01d7571b          	srliw	a4,a4,0x1d
    8000499a:	9fb9                	addw	a5,a5,a4
    8000499c:	4037d79b          	sraiw	a5,a5,0x3
    800049a0:	2781                	sext.w	a5,a5
    800049a2:	fe043703          	ld	a4,-32(s0)
    800049a6:	97ba                	add	a5,a5,a4
    800049a8:	0587c783          	lbu	a5,88(a5)
    800049ac:	2781                	sext.w	a5,a5
    800049ae:	fdc42703          	lw	a4,-36(s0)
    800049b2:	8ff9                	and	a5,a5,a4
    800049b4:	2781                	sext.w	a5,a5
    800049b6:	e3d9                	bnez	a5,80004a3c <balloc+0x114>
        bp->data[bi/8] |= m;  // Mark block in use.
    800049b8:	fe842783          	lw	a5,-24(s0)
    800049bc:	41f7d71b          	sraiw	a4,a5,0x1f
    800049c0:	01d7571b          	srliw	a4,a4,0x1d
    800049c4:	9fb9                	addw	a5,a5,a4
    800049c6:	4037d79b          	sraiw	a5,a5,0x3
    800049ca:	2781                	sext.w	a5,a5
    800049cc:	fe043703          	ld	a4,-32(s0)
    800049d0:	973e                	add	a4,a4,a5
    800049d2:	05874703          	lbu	a4,88(a4)
    800049d6:	0187169b          	slliw	a3,a4,0x18
    800049da:	4186d69b          	sraiw	a3,a3,0x18
    800049de:	fdc42703          	lw	a4,-36(s0)
    800049e2:	0187171b          	slliw	a4,a4,0x18
    800049e6:	4187571b          	sraiw	a4,a4,0x18
    800049ea:	8f55                	or	a4,a4,a3
    800049ec:	0187171b          	slliw	a4,a4,0x18
    800049f0:	4187571b          	sraiw	a4,a4,0x18
    800049f4:	0ff77713          	zext.b	a4,a4
    800049f8:	fe043683          	ld	a3,-32(s0)
    800049fc:	97b6                	add	a5,a5,a3
    800049fe:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004a02:	fe043503          	ld	a0,-32(s0)
    80004a06:	7c6010ef          	jal	800061cc <log_write>
        brelse(bp);
    80004a0a:	fe043503          	ld	a0,-32(s0)
    80004a0e:	cb7ff0ef          	jal	800046c4 <brelse>
        bzero(dev, b + bi);
    80004a12:	fcc42783          	lw	a5,-52(s0)
    80004a16:	fec42703          	lw	a4,-20(s0)
    80004a1a:	86ba                	mv	a3,a4
    80004a1c:	fe842703          	lw	a4,-24(s0)
    80004a20:	9f35                	addw	a4,a4,a3
    80004a22:	2701                	sext.w	a4,a4
    80004a24:	85ba                	mv	a1,a4
    80004a26:	853e                	mv	a0,a5
    80004a28:	ea9ff0ef          	jal	800048d0 <bzero>
        return b + bi;
    80004a2c:	fec42783          	lw	a5,-20(s0)
    80004a30:	873e                	mv	a4,a5
    80004a32:	fe842783          	lw	a5,-24(s0)
    80004a36:	9fb9                	addw	a5,a5,a4
    80004a38:	2781                	sext.w	a5,a5
    80004a3a:	a0bd                	j	80004aa8 <balloc+0x180>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004a3c:	fe842783          	lw	a5,-24(s0)
    80004a40:	2785                	addiw	a5,a5,1
    80004a42:	fef42423          	sw	a5,-24(s0)
    80004a46:	fe842783          	lw	a5,-24(s0)
    80004a4a:	0007871b          	sext.w	a4,a5
    80004a4e:	6789                	lui	a5,0x2
    80004a50:	02f75163          	bge	a4,a5,80004a72 <balloc+0x14a>
    80004a54:	fec42783          	lw	a5,-20(s0)
    80004a58:	873e                	mv	a4,a5
    80004a5a:	fe842783          	lw	a5,-24(s0)
    80004a5e:	9fb9                	addw	a5,a5,a4
    80004a60:	2781                	sext.w	a5,a5
    80004a62:	873e                	mv	a4,a5
    80004a64:	0001c797          	auipc	a5,0x1c
    80004a68:	4ec78793          	addi	a5,a5,1260 # 80020f50 <sb>
    80004a6c:	43dc                	lw	a5,4(a5)
    80004a6e:	f0f767e3          	bltu	a4,a5,8000497c <balloc+0x54>
      }
    }
    brelse(bp);
    80004a72:	fe043503          	ld	a0,-32(s0)
    80004a76:	c4fff0ef          	jal	800046c4 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80004a7a:	fec42783          	lw	a5,-20(s0)
    80004a7e:	873e                	mv	a4,a5
    80004a80:	6789                	lui	a5,0x2
    80004a82:	9fb9                	addw	a5,a5,a4
    80004a84:	fef42623          	sw	a5,-20(s0)
    80004a88:	0001c797          	auipc	a5,0x1c
    80004a8c:	4c878793          	addi	a5,a5,1224 # 80020f50 <sb>
    80004a90:	43d8                	lw	a4,4(a5)
    80004a92:	fec42783          	lw	a5,-20(s0)
    80004a96:	eae7e5e3          	bltu	a5,a4,80004940 <balloc+0x18>
  }
  printf("balloc: out of blocks\n");
    80004a9a:	00006517          	auipc	a0,0x6
    80004a9e:	9fe50513          	addi	a0,a0,-1538 # 8000a498 <etext+0x498>
    80004aa2:	f4dfb0ef          	jal	800009ee <printf>
  return 0;
    80004aa6:	4781                	li	a5,0
}
    80004aa8:	853e                	mv	a0,a5
    80004aaa:	70e2                	ld	ra,56(sp)
    80004aac:	7442                	ld	s0,48(sp)
    80004aae:	6121                	addi	sp,sp,64
    80004ab0:	8082                	ret

0000000080004ab2 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004ab2:	7179                	addi	sp,sp,-48
    80004ab4:	f406                	sd	ra,40(sp)
    80004ab6:	f022                	sd	s0,32(sp)
    80004ab8:	1800                	addi	s0,sp,48
    80004aba:	87aa                	mv	a5,a0
    80004abc:	872e                	mv	a4,a1
    80004abe:	fcf42e23          	sw	a5,-36(s0)
    80004ac2:	87ba                	mv	a5,a4
    80004ac4:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80004ac8:	fdc42683          	lw	a3,-36(s0)
    80004acc:	fd842783          	lw	a5,-40(s0)
    80004ad0:	00d7d79b          	srliw	a5,a5,0xd
    80004ad4:	0007871b          	sext.w	a4,a5
    80004ad8:	0001c797          	auipc	a5,0x1c
    80004adc:	47878793          	addi	a5,a5,1144 # 80020f50 <sb>
    80004ae0:	4fdc                	lw	a5,28(a5)
    80004ae2:	9fb9                	addw	a5,a5,a4
    80004ae4:	2781                	sext.w	a5,a5
    80004ae6:	85be                	mv	a1,a5
    80004ae8:	8536                	mv	a0,a3
    80004aea:	b4dff0ef          	jal	80004636 <bread>
    80004aee:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004af2:	fd842703          	lw	a4,-40(s0)
    80004af6:	6789                	lui	a5,0x2
    80004af8:	17fd                	addi	a5,a5,-1 # 1fff <_entry-0x7fffe001>
    80004afa:	8ff9                	and	a5,a5,a4
    80004afc:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004b00:	fe442783          	lw	a5,-28(s0)
    80004b04:	8b9d                	andi	a5,a5,7
    80004b06:	2781                	sext.w	a5,a5
    80004b08:	4705                	li	a4,1
    80004b0a:	00f717bb          	sllw	a5,a4,a5
    80004b0e:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004b12:	fe442783          	lw	a5,-28(s0)
    80004b16:	41f7d71b          	sraiw	a4,a5,0x1f
    80004b1a:	01d7571b          	srliw	a4,a4,0x1d
    80004b1e:	9fb9                	addw	a5,a5,a4
    80004b20:	4037d79b          	sraiw	a5,a5,0x3
    80004b24:	2781                	sext.w	a5,a5
    80004b26:	fe843703          	ld	a4,-24(s0)
    80004b2a:	97ba                	add	a5,a5,a4
    80004b2c:	0587c783          	lbu	a5,88(a5)
    80004b30:	2781                	sext.w	a5,a5
    80004b32:	fe042703          	lw	a4,-32(s0)
    80004b36:	8ff9                	and	a5,a5,a4
    80004b38:	2781                	sext.w	a5,a5
    80004b3a:	e799                	bnez	a5,80004b48 <bfree+0x96>
    panic("freeing free block");
    80004b3c:	00006517          	auipc	a0,0x6
    80004b40:	97450513          	addi	a0,a0,-1676 # 8000a4b0 <etext+0x4b0>
    80004b44:	af2fc0ef          	jal	80000e36 <panic>
  bp->data[bi/8] &= ~m;
    80004b48:	fe442783          	lw	a5,-28(s0)
    80004b4c:	41f7d71b          	sraiw	a4,a5,0x1f
    80004b50:	01d7571b          	srliw	a4,a4,0x1d
    80004b54:	9fb9                	addw	a5,a5,a4
    80004b56:	4037d79b          	sraiw	a5,a5,0x3
    80004b5a:	2781                	sext.w	a5,a5
    80004b5c:	fe843703          	ld	a4,-24(s0)
    80004b60:	973e                	add	a4,a4,a5
    80004b62:	05874703          	lbu	a4,88(a4)
    80004b66:	0187169b          	slliw	a3,a4,0x18
    80004b6a:	4186d69b          	sraiw	a3,a3,0x18
    80004b6e:	fe042703          	lw	a4,-32(s0)
    80004b72:	0187171b          	slliw	a4,a4,0x18
    80004b76:	4187571b          	sraiw	a4,a4,0x18
    80004b7a:	fff74713          	not	a4,a4
    80004b7e:	0187171b          	slliw	a4,a4,0x18
    80004b82:	4187571b          	sraiw	a4,a4,0x18
    80004b86:	8f75                	and	a4,a4,a3
    80004b88:	0187171b          	slliw	a4,a4,0x18
    80004b8c:	4187571b          	sraiw	a4,a4,0x18
    80004b90:	0ff77713          	zext.b	a4,a4
    80004b94:	fe843683          	ld	a3,-24(s0)
    80004b98:	97b6                	add	a5,a5,a3
    80004b9a:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80004b9e:	fe843503          	ld	a0,-24(s0)
    80004ba2:	62a010ef          	jal	800061cc <log_write>
  brelse(bp);
    80004ba6:	fe843503          	ld	a0,-24(s0)
    80004baa:	b1bff0ef          	jal	800046c4 <brelse>
}
    80004bae:	0001                	nop
    80004bb0:	70a2                	ld	ra,40(sp)
    80004bb2:	7402                	ld	s0,32(sp)
    80004bb4:	6145                	addi	sp,sp,48
    80004bb6:	8082                	ret

0000000080004bb8 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80004bb8:	1101                	addi	sp,sp,-32
    80004bba:	ec06                	sd	ra,24(sp)
    80004bbc:	e822                	sd	s0,16(sp)
    80004bbe:	1000                	addi	s0,sp,32
  int i = 0;
    80004bc0:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80004bc4:	00006597          	auipc	a1,0x6
    80004bc8:	90458593          	addi	a1,a1,-1788 # 8000a4c8 <etext+0x4c8>
    80004bcc:	0001c517          	auipc	a0,0x1c
    80004bd0:	3a450513          	addi	a0,a0,932 # 80020f70 <itable>
    80004bd4:	f42fc0ef          	jal	80001316 <initlock>
  for(i = 0; i < NINODE; i++) {
    80004bd8:	fe042623          	sw	zero,-20(s0)
    80004bdc:	a81d                	j	80004c12 <iinit+0x5a>
    initsleeplock(&itable.inode[i].lock, "inode");
    80004bde:	fec42703          	lw	a4,-20(s0)
    80004be2:	87ba                	mv	a5,a4
    80004be4:	0792                	slli	a5,a5,0x4
    80004be6:	97ba                	add	a5,a5,a4
    80004be8:	078e                	slli	a5,a5,0x3
    80004bea:	02078713          	addi	a4,a5,32
    80004bee:	0001c797          	auipc	a5,0x1c
    80004bf2:	38278793          	addi	a5,a5,898 # 80020f70 <itable>
    80004bf6:	97ba                	add	a5,a5,a4
    80004bf8:	07a1                	addi	a5,a5,8
    80004bfa:	00006597          	auipc	a1,0x6
    80004bfe:	8d658593          	addi	a1,a1,-1834 # 8000a4d0 <etext+0x4d0>
    80004c02:	853e                	mv	a0,a5
    80004c04:	6c6010ef          	jal	800062ca <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80004c08:	fec42783          	lw	a5,-20(s0)
    80004c0c:	2785                	addiw	a5,a5,1
    80004c0e:	fef42623          	sw	a5,-20(s0)
    80004c12:	fec42783          	lw	a5,-20(s0)
    80004c16:	0007871b          	sext.w	a4,a5
    80004c1a:	03100793          	li	a5,49
    80004c1e:	fce7d0e3          	bge	a5,a4,80004bde <iinit+0x26>
  }
}
    80004c22:	0001                	nop
    80004c24:	0001                	nop
    80004c26:	60e2                	ld	ra,24(sp)
    80004c28:	6442                	ld	s0,16(sp)
    80004c2a:	6105                	addi	sp,sp,32
    80004c2c:	8082                	ret

0000000080004c2e <ialloc>:
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode,
// or NULL if there is no free inode.
struct inode*
ialloc(uint dev, short type)
{
    80004c2e:	7139                	addi	sp,sp,-64
    80004c30:	fc06                	sd	ra,56(sp)
    80004c32:	f822                	sd	s0,48(sp)
    80004c34:	0080                	addi	s0,sp,64
    80004c36:	87aa                	mv	a5,a0
    80004c38:	872e                	mv	a4,a1
    80004c3a:	fcf42623          	sw	a5,-52(s0)
    80004c3e:	87ba                	mv	a5,a4
    80004c40:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    80004c44:	4785                	li	a5,1
    80004c46:	fef42623          	sw	a5,-20(s0)
    80004c4a:	a871                	j	80004ce6 <ialloc+0xb8>
    bp = bread(dev, IBLOCK(inum, sb));
    80004c4c:	fec42783          	lw	a5,-20(s0)
    80004c50:	8391                	srli	a5,a5,0x4
    80004c52:	0007871b          	sext.w	a4,a5
    80004c56:	0001c797          	auipc	a5,0x1c
    80004c5a:	2fa78793          	addi	a5,a5,762 # 80020f50 <sb>
    80004c5e:	4f9c                	lw	a5,24(a5)
    80004c60:	9fb9                	addw	a5,a5,a4
    80004c62:	0007871b          	sext.w	a4,a5
    80004c66:	fcc42783          	lw	a5,-52(s0)
    80004c6a:	85ba                	mv	a1,a4
    80004c6c:	853e                	mv	a0,a5
    80004c6e:	9c9ff0ef          	jal	80004636 <bread>
    80004c72:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80004c76:	fe043783          	ld	a5,-32(s0)
    80004c7a:	05878713          	addi	a4,a5,88
    80004c7e:	fec42783          	lw	a5,-20(s0)
    80004c82:	8bbd                	andi	a5,a5,15
    80004c84:	079a                	slli	a5,a5,0x6
    80004c86:	97ba                	add	a5,a5,a4
    80004c88:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80004c8c:	fd843783          	ld	a5,-40(s0)
    80004c90:	00079783          	lh	a5,0(a5)
    80004c94:	e3a1                	bnez	a5,80004cd4 <ialloc+0xa6>
      memset(dip, 0, sizeof(*dip));
    80004c96:	04000613          	li	a2,64
    80004c9a:	4581                	li	a1,0
    80004c9c:	fd843503          	ld	a0,-40(s0)
    80004ca0:	837fc0ef          	jal	800014d6 <memset>
      dip->type = type;
    80004ca4:	fd843783          	ld	a5,-40(s0)
    80004ca8:	fca45703          	lhu	a4,-54(s0)
    80004cac:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80004cb0:	fe043503          	ld	a0,-32(s0)
    80004cb4:	518010ef          	jal	800061cc <log_write>
      brelse(bp);
    80004cb8:	fe043503          	ld	a0,-32(s0)
    80004cbc:	a09ff0ef          	jal	800046c4 <brelse>
      return iget(dev, inum);
    80004cc0:	fec42703          	lw	a4,-20(s0)
    80004cc4:	fcc42783          	lw	a5,-52(s0)
    80004cc8:	85ba                	mv	a1,a4
    80004cca:	853e                	mv	a0,a5
    80004ccc:	11c000ef          	jal	80004de8 <iget>
    80004cd0:	87aa                	mv	a5,a0
    80004cd2:	a815                	j	80004d06 <ialloc+0xd8>
    }
    brelse(bp);
    80004cd4:	fe043503          	ld	a0,-32(s0)
    80004cd8:	9edff0ef          	jal	800046c4 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80004cdc:	fec42783          	lw	a5,-20(s0)
    80004ce0:	2785                	addiw	a5,a5,1
    80004ce2:	fef42623          	sw	a5,-20(s0)
    80004ce6:	0001c797          	auipc	a5,0x1c
    80004cea:	26a78793          	addi	a5,a5,618 # 80020f50 <sb>
    80004cee:	47d8                	lw	a4,12(a5)
    80004cf0:	fec42783          	lw	a5,-20(s0)
    80004cf4:	f4e7ece3          	bltu	a5,a4,80004c4c <ialloc+0x1e>
  }
  printf("ialloc: no inodes\n");
    80004cf8:	00005517          	auipc	a0,0x5
    80004cfc:	7e050513          	addi	a0,a0,2016 # 8000a4d8 <etext+0x4d8>
    80004d00:	ceffb0ef          	jal	800009ee <printf>
  return 0;
    80004d04:	4781                	li	a5,0
}
    80004d06:	853e                	mv	a0,a5
    80004d08:	70e2                	ld	ra,56(sp)
    80004d0a:	7442                	ld	s0,48(sp)
    80004d0c:	6121                	addi	sp,sp,64
    80004d0e:	8082                	ret

0000000080004d10 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80004d10:	7179                	addi	sp,sp,-48
    80004d12:	f406                	sd	ra,40(sp)
    80004d14:	f022                	sd	s0,32(sp)
    80004d16:	1800                	addi	s0,sp,48
    80004d18:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004d1c:	fd843783          	ld	a5,-40(s0)
    80004d20:	4394                	lw	a3,0(a5)
    80004d22:	fd843783          	ld	a5,-40(s0)
    80004d26:	43dc                	lw	a5,4(a5)
    80004d28:	0047d79b          	srliw	a5,a5,0x4
    80004d2c:	0007871b          	sext.w	a4,a5
    80004d30:	0001c797          	auipc	a5,0x1c
    80004d34:	22078793          	addi	a5,a5,544 # 80020f50 <sb>
    80004d38:	4f9c                	lw	a5,24(a5)
    80004d3a:	9fb9                	addw	a5,a5,a4
    80004d3c:	2781                	sext.w	a5,a5
    80004d3e:	85be                	mv	a1,a5
    80004d40:	8536                	mv	a0,a3
    80004d42:	8f5ff0ef          	jal	80004636 <bread>
    80004d46:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004d4a:	fe843783          	ld	a5,-24(s0)
    80004d4e:	05878713          	addi	a4,a5,88
    80004d52:	fd843783          	ld	a5,-40(s0)
    80004d56:	43dc                	lw	a5,4(a5)
    80004d58:	1782                	slli	a5,a5,0x20
    80004d5a:	9381                	srli	a5,a5,0x20
    80004d5c:	8bbd                	andi	a5,a5,15
    80004d5e:	079a                	slli	a5,a5,0x6
    80004d60:	97ba                	add	a5,a5,a4
    80004d62:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80004d66:	fd843783          	ld	a5,-40(s0)
    80004d6a:	04479703          	lh	a4,68(a5)
    80004d6e:	fe043783          	ld	a5,-32(s0)
    80004d72:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80004d76:	fd843783          	ld	a5,-40(s0)
    80004d7a:	04679703          	lh	a4,70(a5)
    80004d7e:	fe043783          	ld	a5,-32(s0)
    80004d82:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80004d86:	fd843783          	ld	a5,-40(s0)
    80004d8a:	04879703          	lh	a4,72(a5)
    80004d8e:	fe043783          	ld	a5,-32(s0)
    80004d92:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80004d96:	fd843783          	ld	a5,-40(s0)
    80004d9a:	04a79703          	lh	a4,74(a5)
    80004d9e:	fe043783          	ld	a5,-32(s0)
    80004da2:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80004da6:	fd843783          	ld	a5,-40(s0)
    80004daa:	47f8                	lw	a4,76(a5)
    80004dac:	fe043783          	ld	a5,-32(s0)
    80004db0:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80004db2:	fe043783          	ld	a5,-32(s0)
    80004db6:	00c78713          	addi	a4,a5,12
    80004dba:	fd843783          	ld	a5,-40(s0)
    80004dbe:	05078793          	addi	a5,a5,80
    80004dc2:	03400613          	li	a2,52
    80004dc6:	85be                	mv	a1,a5
    80004dc8:	853a                	mv	a0,a4
    80004dca:	ff8fc0ef          	jal	800015c2 <memmove>
  log_write(bp);
    80004dce:	fe843503          	ld	a0,-24(s0)
    80004dd2:	3fa010ef          	jal	800061cc <log_write>
  brelse(bp);
    80004dd6:	fe843503          	ld	a0,-24(s0)
    80004dda:	8ebff0ef          	jal	800046c4 <brelse>
}
    80004dde:	0001                	nop
    80004de0:	70a2                	ld	ra,40(sp)
    80004de2:	7402                	ld	s0,32(sp)
    80004de4:	6145                	addi	sp,sp,48
    80004de6:	8082                	ret

0000000080004de8 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80004de8:	7179                	addi	sp,sp,-48
    80004dea:	f406                	sd	ra,40(sp)
    80004dec:	f022                	sd	s0,32(sp)
    80004dee:	1800                	addi	s0,sp,48
    80004df0:	87aa                	mv	a5,a0
    80004df2:	872e                	mv	a4,a1
    80004df4:	fcf42e23          	sw	a5,-36(s0)
    80004df8:	87ba                	mv	a5,a4
    80004dfa:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    80004dfe:	0001c517          	auipc	a0,0x1c
    80004e02:	17250513          	addi	a0,a0,370 # 80020f70 <itable>
    80004e06:	d44fc0ef          	jal	8000134a <acquire>

  // Is the inode already in the table?
  empty = 0;
    80004e0a:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80004e0e:	0001c797          	auipc	a5,0x1c
    80004e12:	17a78793          	addi	a5,a5,378 # 80020f88 <itable+0x18>
    80004e16:	fef43423          	sd	a5,-24(s0)
    80004e1a:	a88d                	j	80004e8c <iget+0xa4>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80004e1c:	fe843783          	ld	a5,-24(s0)
    80004e20:	479c                	lw	a5,8(a5)
    80004e22:	04f05463          	blez	a5,80004e6a <iget+0x82>
    80004e26:	fe843783          	ld	a5,-24(s0)
    80004e2a:	439c                	lw	a5,0(a5)
    80004e2c:	fdc42703          	lw	a4,-36(s0)
    80004e30:	2701                	sext.w	a4,a4
    80004e32:	02f71c63          	bne	a4,a5,80004e6a <iget+0x82>
    80004e36:	fe843783          	ld	a5,-24(s0)
    80004e3a:	43dc                	lw	a5,4(a5)
    80004e3c:	fd842703          	lw	a4,-40(s0)
    80004e40:	2701                	sext.w	a4,a4
    80004e42:	02f71463          	bne	a4,a5,80004e6a <iget+0x82>
      ip->ref++;
    80004e46:	fe843783          	ld	a5,-24(s0)
    80004e4a:	479c                	lw	a5,8(a5)
    80004e4c:	2785                	addiw	a5,a5,1
    80004e4e:	0007871b          	sext.w	a4,a5
    80004e52:	fe843783          	ld	a5,-24(s0)
    80004e56:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80004e58:	0001c517          	auipc	a0,0x1c
    80004e5c:	11850513          	addi	a0,a0,280 # 80020f70 <itable>
    80004e60:	d3efc0ef          	jal	8000139e <release>
      return ip;
    80004e64:	fe843783          	ld	a5,-24(s0)
    80004e68:	a049                	j	80004eea <iget+0x102>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80004e6a:	fe043783          	ld	a5,-32(s0)
    80004e6e:	eb89                	bnez	a5,80004e80 <iget+0x98>
    80004e70:	fe843783          	ld	a5,-24(s0)
    80004e74:	479c                	lw	a5,8(a5)
    80004e76:	e789                	bnez	a5,80004e80 <iget+0x98>
      empty = ip;
    80004e78:	fe843783          	ld	a5,-24(s0)
    80004e7c:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80004e80:	fe843783          	ld	a5,-24(s0)
    80004e84:	08878793          	addi	a5,a5,136
    80004e88:	fef43423          	sd	a5,-24(s0)
    80004e8c:	fe843703          	ld	a4,-24(s0)
    80004e90:	0001e797          	auipc	a5,0x1e
    80004e94:	b8878793          	addi	a5,a5,-1144 # 80022a18 <log>
    80004e98:	f8f762e3          	bltu	a4,a5,80004e1c <iget+0x34>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80004e9c:	fe043783          	ld	a5,-32(s0)
    80004ea0:	e799                	bnez	a5,80004eae <iget+0xc6>
    panic("iget: no inodes");
    80004ea2:	00005517          	auipc	a0,0x5
    80004ea6:	64e50513          	addi	a0,a0,1614 # 8000a4f0 <etext+0x4f0>
    80004eaa:	f8dfb0ef          	jal	80000e36 <panic>

  ip = empty;
    80004eae:	fe043783          	ld	a5,-32(s0)
    80004eb2:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80004eb6:	fe843783          	ld	a5,-24(s0)
    80004eba:	fdc42703          	lw	a4,-36(s0)
    80004ebe:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80004ec0:	fe843783          	ld	a5,-24(s0)
    80004ec4:	fd842703          	lw	a4,-40(s0)
    80004ec8:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80004eca:	fe843783          	ld	a5,-24(s0)
    80004ece:	4705                	li	a4,1
    80004ed0:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80004ed2:	fe843783          	ld	a5,-24(s0)
    80004ed6:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80004eda:	0001c517          	auipc	a0,0x1c
    80004ede:	09650513          	addi	a0,a0,150 # 80020f70 <itable>
    80004ee2:	cbcfc0ef          	jal	8000139e <release>

  return ip;
    80004ee6:	fe843783          	ld	a5,-24(s0)
}
    80004eea:	853e                	mv	a0,a5
    80004eec:	70a2                	ld	ra,40(sp)
    80004eee:	7402                	ld	s0,32(sp)
    80004ef0:	6145                	addi	sp,sp,48
    80004ef2:	8082                	ret

0000000080004ef4 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80004ef4:	1101                	addi	sp,sp,-32
    80004ef6:	ec06                	sd	ra,24(sp)
    80004ef8:	e822                	sd	s0,16(sp)
    80004efa:	1000                	addi	s0,sp,32
    80004efc:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80004f00:	0001c517          	auipc	a0,0x1c
    80004f04:	07050513          	addi	a0,a0,112 # 80020f70 <itable>
    80004f08:	c42fc0ef          	jal	8000134a <acquire>
  ip->ref++;
    80004f0c:	fe843783          	ld	a5,-24(s0)
    80004f10:	479c                	lw	a5,8(a5)
    80004f12:	2785                	addiw	a5,a5,1
    80004f14:	0007871b          	sext.w	a4,a5
    80004f18:	fe843783          	ld	a5,-24(s0)
    80004f1c:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80004f1e:	0001c517          	auipc	a0,0x1c
    80004f22:	05250513          	addi	a0,a0,82 # 80020f70 <itable>
    80004f26:	c78fc0ef          	jal	8000139e <release>
  return ip;
    80004f2a:	fe843783          	ld	a5,-24(s0)
}
    80004f2e:	853e                	mv	a0,a5
    80004f30:	60e2                	ld	ra,24(sp)
    80004f32:	6442                	ld	s0,16(sp)
    80004f34:	6105                	addi	sp,sp,32
    80004f36:	8082                	ret

0000000080004f38 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80004f38:	7179                	addi	sp,sp,-48
    80004f3a:	f406                	sd	ra,40(sp)
    80004f3c:	f022                	sd	s0,32(sp)
    80004f3e:	1800                	addi	s0,sp,48
    80004f40:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80004f44:	fd843783          	ld	a5,-40(s0)
    80004f48:	c791                	beqz	a5,80004f54 <ilock+0x1c>
    80004f4a:	fd843783          	ld	a5,-40(s0)
    80004f4e:	479c                	lw	a5,8(a5)
    80004f50:	00f04863          	bgtz	a5,80004f60 <ilock+0x28>
    panic("ilock");
    80004f54:	00005517          	auipc	a0,0x5
    80004f58:	5ac50513          	addi	a0,a0,1452 # 8000a500 <etext+0x500>
    80004f5c:	edbfb0ef          	jal	80000e36 <panic>

  acquiresleep(&ip->lock);
    80004f60:	fd843783          	ld	a5,-40(s0)
    80004f64:	07c1                	addi	a5,a5,16
    80004f66:	853e                	mv	a0,a5
    80004f68:	3aa010ef          	jal	80006312 <acquiresleep>

  if(ip->valid == 0){
    80004f6c:	fd843783          	ld	a5,-40(s0)
    80004f70:	43bc                	lw	a5,64(a5)
    80004f72:	efe1                	bnez	a5,8000504a <ilock+0x112>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004f74:	fd843783          	ld	a5,-40(s0)
    80004f78:	4394                	lw	a3,0(a5)
    80004f7a:	fd843783          	ld	a5,-40(s0)
    80004f7e:	43dc                	lw	a5,4(a5)
    80004f80:	0047d79b          	srliw	a5,a5,0x4
    80004f84:	0007871b          	sext.w	a4,a5
    80004f88:	0001c797          	auipc	a5,0x1c
    80004f8c:	fc878793          	addi	a5,a5,-56 # 80020f50 <sb>
    80004f90:	4f9c                	lw	a5,24(a5)
    80004f92:	9fb9                	addw	a5,a5,a4
    80004f94:	2781                	sext.w	a5,a5
    80004f96:	85be                	mv	a1,a5
    80004f98:	8536                	mv	a0,a3
    80004f9a:	e9cff0ef          	jal	80004636 <bread>
    80004f9e:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004fa2:	fe843783          	ld	a5,-24(s0)
    80004fa6:	05878713          	addi	a4,a5,88
    80004faa:	fd843783          	ld	a5,-40(s0)
    80004fae:	43dc                	lw	a5,4(a5)
    80004fb0:	1782                	slli	a5,a5,0x20
    80004fb2:	9381                	srli	a5,a5,0x20
    80004fb4:	8bbd                	andi	a5,a5,15
    80004fb6:	079a                	slli	a5,a5,0x6
    80004fb8:	97ba                	add	a5,a5,a4
    80004fba:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80004fbe:	fe043783          	ld	a5,-32(s0)
    80004fc2:	00079703          	lh	a4,0(a5)
    80004fc6:	fd843783          	ld	a5,-40(s0)
    80004fca:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80004fce:	fe043783          	ld	a5,-32(s0)
    80004fd2:	00279703          	lh	a4,2(a5)
    80004fd6:	fd843783          	ld	a5,-40(s0)
    80004fda:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80004fde:	fe043783          	ld	a5,-32(s0)
    80004fe2:	00479703          	lh	a4,4(a5)
    80004fe6:	fd843783          	ld	a5,-40(s0)
    80004fea:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80004fee:	fe043783          	ld	a5,-32(s0)
    80004ff2:	00679703          	lh	a4,6(a5)
    80004ff6:	fd843783          	ld	a5,-40(s0)
    80004ffa:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80004ffe:	fe043783          	ld	a5,-32(s0)
    80005002:	4798                	lw	a4,8(a5)
    80005004:	fd843783          	ld	a5,-40(s0)
    80005008:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000500a:	fd843783          	ld	a5,-40(s0)
    8000500e:	05078713          	addi	a4,a5,80
    80005012:	fe043783          	ld	a5,-32(s0)
    80005016:	07b1                	addi	a5,a5,12
    80005018:	03400613          	li	a2,52
    8000501c:	85be                	mv	a1,a5
    8000501e:	853a                	mv	a0,a4
    80005020:	da2fc0ef          	jal	800015c2 <memmove>
    brelse(bp);
    80005024:	fe843503          	ld	a0,-24(s0)
    80005028:	e9cff0ef          	jal	800046c4 <brelse>
    ip->valid = 1;
    8000502c:	fd843783          	ld	a5,-40(s0)
    80005030:	4705                	li	a4,1
    80005032:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005034:	fd843783          	ld	a5,-40(s0)
    80005038:	04479783          	lh	a5,68(a5)
    8000503c:	e799                	bnez	a5,8000504a <ilock+0x112>
      panic("ilock: no type");
    8000503e:	00005517          	auipc	a0,0x5
    80005042:	4ca50513          	addi	a0,a0,1226 # 8000a508 <etext+0x508>
    80005046:	df1fb0ef          	jal	80000e36 <panic>
  }
}
    8000504a:	0001                	nop
    8000504c:	70a2                	ld	ra,40(sp)
    8000504e:	7402                	ld	s0,32(sp)
    80005050:	6145                	addi	sp,sp,48
    80005052:	8082                	ret

0000000080005054 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005054:	1101                	addi	sp,sp,-32
    80005056:	ec06                	sd	ra,24(sp)
    80005058:	e822                	sd	s0,16(sp)
    8000505a:	1000                	addi	s0,sp,32
    8000505c:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005060:	fe843783          	ld	a5,-24(s0)
    80005064:	cf91                	beqz	a5,80005080 <iunlock+0x2c>
    80005066:	fe843783          	ld	a5,-24(s0)
    8000506a:	07c1                	addi	a5,a5,16
    8000506c:	853e                	mv	a0,a5
    8000506e:	348010ef          	jal	800063b6 <holdingsleep>
    80005072:	87aa                	mv	a5,a0
    80005074:	c791                	beqz	a5,80005080 <iunlock+0x2c>
    80005076:	fe843783          	ld	a5,-24(s0)
    8000507a:	479c                	lw	a5,8(a5)
    8000507c:	00f04863          	bgtz	a5,8000508c <iunlock+0x38>
    panic("iunlock");
    80005080:	00005517          	auipc	a0,0x5
    80005084:	49850513          	addi	a0,a0,1176 # 8000a518 <etext+0x518>
    80005088:	daffb0ef          	jal	80000e36 <panic>

  releasesleep(&ip->lock);
    8000508c:	fe843783          	ld	a5,-24(s0)
    80005090:	07c1                	addi	a5,a5,16
    80005092:	853e                	mv	a0,a5
    80005094:	2dc010ef          	jal	80006370 <releasesleep>
}
    80005098:	0001                	nop
    8000509a:	60e2                	ld	ra,24(sp)
    8000509c:	6442                	ld	s0,16(sp)
    8000509e:	6105                	addi	sp,sp,32
    800050a0:	8082                	ret

00000000800050a2 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800050a2:	1101                	addi	sp,sp,-32
    800050a4:	ec06                	sd	ra,24(sp)
    800050a6:	e822                	sd	s0,16(sp)
    800050a8:	1000                	addi	s0,sp,32
    800050aa:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800050ae:	0001c517          	auipc	a0,0x1c
    800050b2:	ec250513          	addi	a0,a0,-318 # 80020f70 <itable>
    800050b6:	a94fc0ef          	jal	8000134a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800050ba:	fe843783          	ld	a5,-24(s0)
    800050be:	4798                	lw	a4,8(a5)
    800050c0:	4785                	li	a5,1
    800050c2:	06f71363          	bne	a4,a5,80005128 <iput+0x86>
    800050c6:	fe843783          	ld	a5,-24(s0)
    800050ca:	43bc                	lw	a5,64(a5)
    800050cc:	cfb1                	beqz	a5,80005128 <iput+0x86>
    800050ce:	fe843783          	ld	a5,-24(s0)
    800050d2:	04a79783          	lh	a5,74(a5)
    800050d6:	eba9                	bnez	a5,80005128 <iput+0x86>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    800050d8:	fe843783          	ld	a5,-24(s0)
    800050dc:	07c1                	addi	a5,a5,16
    800050de:	853e                	mv	a0,a5
    800050e0:	232010ef          	jal	80006312 <acquiresleep>

    release(&itable.lock);
    800050e4:	0001c517          	auipc	a0,0x1c
    800050e8:	e8c50513          	addi	a0,a0,-372 # 80020f70 <itable>
    800050ec:	ab2fc0ef          	jal	8000139e <release>

    itrunc(ip);
    800050f0:	fe843503          	ld	a0,-24(s0)
    800050f4:	2ca000ef          	jal	800053be <itrunc>
    ip->type = 0;
    800050f8:	fe843783          	ld	a5,-24(s0)
    800050fc:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005100:	fe843503          	ld	a0,-24(s0)
    80005104:	c0dff0ef          	jal	80004d10 <iupdate>
    ip->valid = 0;
    80005108:	fe843783          	ld	a5,-24(s0)
    8000510c:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005110:	fe843783          	ld	a5,-24(s0)
    80005114:	07c1                	addi	a5,a5,16
    80005116:	853e                	mv	a0,a5
    80005118:	258010ef          	jal	80006370 <releasesleep>

    acquire(&itable.lock);
    8000511c:	0001c517          	auipc	a0,0x1c
    80005120:	e5450513          	addi	a0,a0,-428 # 80020f70 <itable>
    80005124:	a26fc0ef          	jal	8000134a <acquire>
  }

  ip->ref--;
    80005128:	fe843783          	ld	a5,-24(s0)
    8000512c:	479c                	lw	a5,8(a5)
    8000512e:	37fd                	addiw	a5,a5,-1
    80005130:	0007871b          	sext.w	a4,a5
    80005134:	fe843783          	ld	a5,-24(s0)
    80005138:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    8000513a:	0001c517          	auipc	a0,0x1c
    8000513e:	e3650513          	addi	a0,a0,-458 # 80020f70 <itable>
    80005142:	a5cfc0ef          	jal	8000139e <release>
}
    80005146:	0001                	nop
    80005148:	60e2                	ld	ra,24(sp)
    8000514a:	6442                	ld	s0,16(sp)
    8000514c:	6105                	addi	sp,sp,32
    8000514e:	8082                	ret

0000000080005150 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005150:	1101                	addi	sp,sp,-32
    80005152:	ec06                	sd	ra,24(sp)
    80005154:	e822                	sd	s0,16(sp)
    80005156:	1000                	addi	s0,sp,32
    80005158:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    8000515c:	fe843503          	ld	a0,-24(s0)
    80005160:	ef5ff0ef          	jal	80005054 <iunlock>
  iput(ip);
    80005164:	fe843503          	ld	a0,-24(s0)
    80005168:	f3bff0ef          	jal	800050a2 <iput>
}
    8000516c:	0001                	nop
    8000516e:	60e2                	ld	ra,24(sp)
    80005170:	6442                	ld	s0,16(sp)
    80005172:	6105                	addi	sp,sp,32
    80005174:	8082                	ret

0000000080005176 <ireclaim>:

void
ireclaim(int dev)
{
    80005176:	7139                	addi	sp,sp,-64
    80005178:	fc06                	sd	ra,56(sp)
    8000517a:	f822                	sd	s0,48(sp)
    8000517c:	0080                	addi	s0,sp,64
    8000517e:	87aa                	mv	a5,a0
    80005180:	fcf42623          	sw	a5,-52(s0)
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80005184:	4785                	li	a5,1
    80005186:	fef42623          	sw	a5,-20(s0)
    8000518a:	a85d                	j	80005240 <ireclaim+0xca>
    struct inode *ip = 0;
    8000518c:	fe043023          	sd	zero,-32(s0)
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80005190:	fcc42683          	lw	a3,-52(s0)
    80005194:	fec42783          	lw	a5,-20(s0)
    80005198:	8391                	srli	a5,a5,0x4
    8000519a:	0007871b          	sext.w	a4,a5
    8000519e:	0001c797          	auipc	a5,0x1c
    800051a2:	db278793          	addi	a5,a5,-590 # 80020f50 <sb>
    800051a6:	4f9c                	lw	a5,24(a5)
    800051a8:	9fb9                	addw	a5,a5,a4
    800051aa:	2781                	sext.w	a5,a5
    800051ac:	85be                	mv	a1,a5
    800051ae:	8536                	mv	a0,a3
    800051b0:	c86ff0ef          	jal	80004636 <bread>
    800051b4:	fca43c23          	sd	a0,-40(s0)
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    800051b8:	fd843783          	ld	a5,-40(s0)
    800051bc:	05878713          	addi	a4,a5,88
    800051c0:	fec42783          	lw	a5,-20(s0)
    800051c4:	8bbd                	andi	a5,a5,15
    800051c6:	079a                	slli	a5,a5,0x6
    800051c8:	97ba                	add	a5,a5,a4
    800051ca:	fcf43823          	sd	a5,-48(s0)
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    800051ce:	fd043783          	ld	a5,-48(s0)
    800051d2:	00079783          	lh	a5,0(a5)
    800051d6:	cb8d                	beqz	a5,80005208 <ireclaim+0x92>
    800051d8:	fd043783          	ld	a5,-48(s0)
    800051dc:	00679783          	lh	a5,6(a5)
    800051e0:	e785                	bnez	a5,80005208 <ireclaim+0x92>
      printf("ireclaim: orphaned inode %d\n", inum);
    800051e2:	fec42783          	lw	a5,-20(s0)
    800051e6:	85be                	mv	a1,a5
    800051e8:	00005517          	auipc	a0,0x5
    800051ec:	33850513          	addi	a0,a0,824 # 8000a520 <etext+0x520>
    800051f0:	ffefb0ef          	jal	800009ee <printf>
      ip = iget(dev, inum);
    800051f4:	fcc42783          	lw	a5,-52(s0)
    800051f8:	fec42703          	lw	a4,-20(s0)
    800051fc:	85ba                	mv	a1,a4
    800051fe:	853e                	mv	a0,a5
    80005200:	be9ff0ef          	jal	80004de8 <iget>
    80005204:	fea43023          	sd	a0,-32(s0)
    }
    brelse(bp);
    80005208:	fd843503          	ld	a0,-40(s0)
    8000520c:	cb8ff0ef          	jal	800046c4 <brelse>
    if (ip) {
    80005210:	fe043783          	ld	a5,-32(s0)
    80005214:	c38d                	beqz	a5,80005236 <ireclaim+0xc0>
      begin_op();
    80005216:	539000ef          	jal	80005f4e <begin_op>
      ilock(ip);
    8000521a:	fe043503          	ld	a0,-32(s0)
    8000521e:	d1bff0ef          	jal	80004f38 <ilock>
      iunlock(ip);
    80005222:	fe043503          	ld	a0,-32(s0)
    80005226:	e2fff0ef          	jal	80005054 <iunlock>
      iput(ip);
    8000522a:	fe043503          	ld	a0,-32(s0)
    8000522e:	e75ff0ef          	jal	800050a2 <iput>
      end_op();
    80005232:	5cf000ef          	jal	80006000 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80005236:	fec42783          	lw	a5,-20(s0)
    8000523a:	2785                	addiw	a5,a5,1
    8000523c:	fef42623          	sw	a5,-20(s0)
    80005240:	0001c797          	auipc	a5,0x1c
    80005244:	d1078793          	addi	a5,a5,-752 # 80020f50 <sb>
    80005248:	47d8                	lw	a4,12(a5)
    8000524a:	fec42783          	lw	a5,-20(s0)
    8000524e:	f2e7efe3          	bltu	a5,a4,8000518c <ireclaim+0x16>
    }
  }
}
    80005252:	0001                	nop
    80005254:	0001                	nop
    80005256:	70e2                	ld	ra,56(sp)
    80005258:	7442                	ld	s0,48(sp)
    8000525a:	6121                	addi	sp,sp,64
    8000525c:	8082                	ret

000000008000525e <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    8000525e:	7139                	addi	sp,sp,-64
    80005260:	fc06                	sd	ra,56(sp)
    80005262:	f822                	sd	s0,48(sp)
    80005264:	0080                	addi	s0,sp,64
    80005266:	fca43423          	sd	a0,-56(s0)
    8000526a:	87ae                	mv	a5,a1
    8000526c:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80005270:	fc442783          	lw	a5,-60(s0)
    80005274:	0007871b          	sext.w	a4,a5
    80005278:	47ad                	li	a5,11
    8000527a:	04e7ec63          	bltu	a5,a4,800052d2 <bmap+0x74>
    if((addr = ip->addrs[bn]) == 0){
    8000527e:	fc843703          	ld	a4,-56(s0)
    80005282:	fc446783          	lwu	a5,-60(s0)
    80005286:	07d1                	addi	a5,a5,20
    80005288:	078a                	slli	a5,a5,0x2
    8000528a:	97ba                	add	a5,a5,a4
    8000528c:	439c                	lw	a5,0(a5)
    8000528e:	fef42623          	sw	a5,-20(s0)
    80005292:	fec42783          	lw	a5,-20(s0)
    80005296:	2781                	sext.w	a5,a5
    80005298:	eb95                	bnez	a5,800052cc <bmap+0x6e>
      addr = balloc(ip->dev);
    8000529a:	fc843783          	ld	a5,-56(s0)
    8000529e:	439c                	lw	a5,0(a5)
    800052a0:	853e                	mv	a0,a5
    800052a2:	e86ff0ef          	jal	80004928 <balloc>
    800052a6:	87aa                	mv	a5,a0
    800052a8:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    800052ac:	fec42783          	lw	a5,-20(s0)
    800052b0:	2781                	sext.w	a5,a5
    800052b2:	e399                	bnez	a5,800052b8 <bmap+0x5a>
        return 0;
    800052b4:	4781                	li	a5,0
    800052b6:	a8fd                	j	800053b4 <bmap+0x156>
      ip->addrs[bn] = addr;
    800052b8:	fc843703          	ld	a4,-56(s0)
    800052bc:	fc446783          	lwu	a5,-60(s0)
    800052c0:	07d1                	addi	a5,a5,20
    800052c2:	078a                	slli	a5,a5,0x2
    800052c4:	97ba                	add	a5,a5,a4
    800052c6:	fec42703          	lw	a4,-20(s0)
    800052ca:	c398                	sw	a4,0(a5)
    }
    return addr;
    800052cc:	fec42783          	lw	a5,-20(s0)
    800052d0:	a0d5                	j	800053b4 <bmap+0x156>
  }
  bn -= NDIRECT;
    800052d2:	fc442783          	lw	a5,-60(s0)
    800052d6:	37d1                	addiw	a5,a5,-12
    800052d8:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    800052dc:	fc442783          	lw	a5,-60(s0)
    800052e0:	0007871b          	sext.w	a4,a5
    800052e4:	0ff00793          	li	a5,255
    800052e8:	0ce7e063          	bltu	a5,a4,800053a8 <bmap+0x14a>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800052ec:	fc843783          	ld	a5,-56(s0)
    800052f0:	0807a783          	lw	a5,128(a5)
    800052f4:	fef42623          	sw	a5,-20(s0)
    800052f8:	fec42783          	lw	a5,-20(s0)
    800052fc:	2781                	sext.w	a5,a5
    800052fe:	e795                	bnez	a5,8000532a <bmap+0xcc>
      addr = balloc(ip->dev);
    80005300:	fc843783          	ld	a5,-56(s0)
    80005304:	439c                	lw	a5,0(a5)
    80005306:	853e                	mv	a0,a5
    80005308:	e20ff0ef          	jal	80004928 <balloc>
    8000530c:	87aa                	mv	a5,a0
    8000530e:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    80005312:	fec42783          	lw	a5,-20(s0)
    80005316:	2781                	sext.w	a5,a5
    80005318:	e399                	bnez	a5,8000531e <bmap+0xc0>
        return 0;
    8000531a:	4781                	li	a5,0
    8000531c:	a861                	j	800053b4 <bmap+0x156>
      ip->addrs[NDIRECT] = addr;
    8000531e:	fc843783          	ld	a5,-56(s0)
    80005322:	fec42703          	lw	a4,-20(s0)
    80005326:	08e7a023          	sw	a4,128(a5)
    }
    bp = bread(ip->dev, addr);
    8000532a:	fc843783          	ld	a5,-56(s0)
    8000532e:	439c                	lw	a5,0(a5)
    80005330:	fec42703          	lw	a4,-20(s0)
    80005334:	85ba                	mv	a1,a4
    80005336:	853e                	mv	a0,a5
    80005338:	afeff0ef          	jal	80004636 <bread>
    8000533c:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005340:	fe043783          	ld	a5,-32(s0)
    80005344:	05878793          	addi	a5,a5,88
    80005348:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    8000534c:	fc446783          	lwu	a5,-60(s0)
    80005350:	078a                	slli	a5,a5,0x2
    80005352:	fd843703          	ld	a4,-40(s0)
    80005356:	97ba                	add	a5,a5,a4
    80005358:	439c                	lw	a5,0(a5)
    8000535a:	fef42623          	sw	a5,-20(s0)
    8000535e:	fec42783          	lw	a5,-20(s0)
    80005362:	2781                	sext.w	a5,a5
    80005364:	eb9d                	bnez	a5,8000539a <bmap+0x13c>
      addr = balloc(ip->dev);
    80005366:	fc843783          	ld	a5,-56(s0)
    8000536a:	439c                	lw	a5,0(a5)
    8000536c:	853e                	mv	a0,a5
    8000536e:	dbaff0ef          	jal	80004928 <balloc>
    80005372:	87aa                	mv	a5,a0
    80005374:	fef42623          	sw	a5,-20(s0)
      if(addr){
    80005378:	fec42783          	lw	a5,-20(s0)
    8000537c:	2781                	sext.w	a5,a5
    8000537e:	cf91                	beqz	a5,8000539a <bmap+0x13c>
        a[bn] = addr;
    80005380:	fc446783          	lwu	a5,-60(s0)
    80005384:	078a                	slli	a5,a5,0x2
    80005386:	fd843703          	ld	a4,-40(s0)
    8000538a:	97ba                	add	a5,a5,a4
    8000538c:	fec42703          	lw	a4,-20(s0)
    80005390:	c398                	sw	a4,0(a5)
        log_write(bp);
    80005392:	fe043503          	ld	a0,-32(s0)
    80005396:	637000ef          	jal	800061cc <log_write>
      }
    }
    brelse(bp);
    8000539a:	fe043503          	ld	a0,-32(s0)
    8000539e:	b26ff0ef          	jal	800046c4 <brelse>
    return addr;
    800053a2:	fec42783          	lw	a5,-20(s0)
    800053a6:	a039                	j	800053b4 <bmap+0x156>
  }

  panic("bmap: out of range");
    800053a8:	00005517          	auipc	a0,0x5
    800053ac:	19850513          	addi	a0,a0,408 # 8000a540 <etext+0x540>
    800053b0:	a87fb0ef          	jal	80000e36 <panic>
}
    800053b4:	853e                	mv	a0,a5
    800053b6:	70e2                	ld	ra,56(sp)
    800053b8:	7442                	ld	s0,48(sp)
    800053ba:	6121                	addi	sp,sp,64
    800053bc:	8082                	ret

00000000800053be <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800053be:	7139                	addi	sp,sp,-64
    800053c0:	fc06                	sd	ra,56(sp)
    800053c2:	f822                	sd	s0,48(sp)
    800053c4:	0080                	addi	s0,sp,64
    800053c6:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800053ca:	fe042623          	sw	zero,-20(s0)
    800053ce:	a881                	j	8000541e <itrunc+0x60>
    if(ip->addrs[i]){
    800053d0:	fc843703          	ld	a4,-56(s0)
    800053d4:	fec42783          	lw	a5,-20(s0)
    800053d8:	07d1                	addi	a5,a5,20
    800053da:	078a                	slli	a5,a5,0x2
    800053dc:	97ba                	add	a5,a5,a4
    800053de:	439c                	lw	a5,0(a5)
    800053e0:	cb95                	beqz	a5,80005414 <itrunc+0x56>
      bfree(ip->dev, ip->addrs[i]);
    800053e2:	fc843783          	ld	a5,-56(s0)
    800053e6:	439c                	lw	a5,0(a5)
    800053e8:	86be                	mv	a3,a5
    800053ea:	fc843703          	ld	a4,-56(s0)
    800053ee:	fec42783          	lw	a5,-20(s0)
    800053f2:	07d1                	addi	a5,a5,20
    800053f4:	078a                	slli	a5,a5,0x2
    800053f6:	97ba                	add	a5,a5,a4
    800053f8:	439c                	lw	a5,0(a5)
    800053fa:	85be                	mv	a1,a5
    800053fc:	8536                	mv	a0,a3
    800053fe:	eb4ff0ef          	jal	80004ab2 <bfree>
      ip->addrs[i] = 0;
    80005402:	fc843703          	ld	a4,-56(s0)
    80005406:	fec42783          	lw	a5,-20(s0)
    8000540a:	07d1                	addi	a5,a5,20
    8000540c:	078a                	slli	a5,a5,0x2
    8000540e:	97ba                	add	a5,a5,a4
    80005410:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005414:	fec42783          	lw	a5,-20(s0)
    80005418:	2785                	addiw	a5,a5,1
    8000541a:	fef42623          	sw	a5,-20(s0)
    8000541e:	fec42783          	lw	a5,-20(s0)
    80005422:	0007871b          	sext.w	a4,a5
    80005426:	47ad                	li	a5,11
    80005428:	fae7d4e3          	bge	a5,a4,800053d0 <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000542c:	fc843783          	ld	a5,-56(s0)
    80005430:	0807a783          	lw	a5,128(a5)
    80005434:	cfc9                	beqz	a5,800054ce <itrunc+0x110>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80005436:	fc843783          	ld	a5,-56(s0)
    8000543a:	4398                	lw	a4,0(a5)
    8000543c:	fc843783          	ld	a5,-56(s0)
    80005440:	0807a783          	lw	a5,128(a5)
    80005444:	85be                	mv	a1,a5
    80005446:	853a                	mv	a0,a4
    80005448:	9eeff0ef          	jal	80004636 <bread>
    8000544c:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005450:	fe043783          	ld	a5,-32(s0)
    80005454:	05878793          	addi	a5,a5,88
    80005458:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    8000545c:	fe042423          	sw	zero,-24(s0)
    80005460:	a82d                	j	8000549a <itrunc+0xdc>
      if(a[j])
    80005462:	fe842783          	lw	a5,-24(s0)
    80005466:	078a                	slli	a5,a5,0x2
    80005468:	fd843703          	ld	a4,-40(s0)
    8000546c:	97ba                	add	a5,a5,a4
    8000546e:	439c                	lw	a5,0(a5)
    80005470:	c385                	beqz	a5,80005490 <itrunc+0xd2>
        bfree(ip->dev, a[j]);
    80005472:	fc843783          	ld	a5,-56(s0)
    80005476:	439c                	lw	a5,0(a5)
    80005478:	86be                	mv	a3,a5
    8000547a:	fe842783          	lw	a5,-24(s0)
    8000547e:	078a                	slli	a5,a5,0x2
    80005480:	fd843703          	ld	a4,-40(s0)
    80005484:	97ba                	add	a5,a5,a4
    80005486:	439c                	lw	a5,0(a5)
    80005488:	85be                	mv	a1,a5
    8000548a:	8536                	mv	a0,a3
    8000548c:	e26ff0ef          	jal	80004ab2 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80005490:	fe842783          	lw	a5,-24(s0)
    80005494:	2785                	addiw	a5,a5,1
    80005496:	fef42423          	sw	a5,-24(s0)
    8000549a:	fe842703          	lw	a4,-24(s0)
    8000549e:	0ff00793          	li	a5,255
    800054a2:	fce7f0e3          	bgeu	a5,a4,80005462 <itrunc+0xa4>
    }
    brelse(bp);
    800054a6:	fe043503          	ld	a0,-32(s0)
    800054aa:	a1aff0ef          	jal	800046c4 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800054ae:	fc843783          	ld	a5,-56(s0)
    800054b2:	439c                	lw	a5,0(a5)
    800054b4:	873e                	mv	a4,a5
    800054b6:	fc843783          	ld	a5,-56(s0)
    800054ba:	0807a783          	lw	a5,128(a5)
    800054be:	85be                	mv	a1,a5
    800054c0:	853a                	mv	a0,a4
    800054c2:	df0ff0ef          	jal	80004ab2 <bfree>
    ip->addrs[NDIRECT] = 0;
    800054c6:	fc843783          	ld	a5,-56(s0)
    800054ca:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    800054ce:	fc843783          	ld	a5,-56(s0)
    800054d2:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    800054d6:	fc843503          	ld	a0,-56(s0)
    800054da:	837ff0ef          	jal	80004d10 <iupdate>
}
    800054de:	0001                	nop
    800054e0:	70e2                	ld	ra,56(sp)
    800054e2:	7442                	ld	s0,48(sp)
    800054e4:	6121                	addi	sp,sp,64
    800054e6:	8082                	ret

00000000800054e8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800054e8:	1101                	addi	sp,sp,-32
    800054ea:	ec06                	sd	ra,24(sp)
    800054ec:	e822                	sd	s0,16(sp)
    800054ee:	1000                	addi	s0,sp,32
    800054f0:	fea43423          	sd	a0,-24(s0)
    800054f4:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    800054f8:	fe843783          	ld	a5,-24(s0)
    800054fc:	439c                	lw	a5,0(a5)
    800054fe:	873e                	mv	a4,a5
    80005500:	fe043783          	ld	a5,-32(s0)
    80005504:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80005506:	fe843783          	ld	a5,-24(s0)
    8000550a:	43d8                	lw	a4,4(a5)
    8000550c:	fe043783          	ld	a5,-32(s0)
    80005510:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    80005512:	fe843783          	ld	a5,-24(s0)
    80005516:	04479703          	lh	a4,68(a5)
    8000551a:	fe043783          	ld	a5,-32(s0)
    8000551e:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    80005522:	fe843783          	ld	a5,-24(s0)
    80005526:	04a79703          	lh	a4,74(a5)
    8000552a:	fe043783          	ld	a5,-32(s0)
    8000552e:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    80005532:	fe843783          	ld	a5,-24(s0)
    80005536:	47fc                	lw	a5,76(a5)
    80005538:	02079713          	slli	a4,a5,0x20
    8000553c:	9301                	srli	a4,a4,0x20
    8000553e:	fe043783          	ld	a5,-32(s0)
    80005542:	eb98                	sd	a4,16(a5)
}
    80005544:	0001                	nop
    80005546:	60e2                	ld	ra,24(sp)
    80005548:	6442                	ld	s0,16(sp)
    8000554a:	6105                	addi	sp,sp,32
    8000554c:	8082                	ret

000000008000554e <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    8000554e:	715d                	addi	sp,sp,-80
    80005550:	e486                	sd	ra,72(sp)
    80005552:	e0a2                	sd	s0,64(sp)
    80005554:	0880                	addi	s0,sp,80
    80005556:	fca43423          	sd	a0,-56(s0)
    8000555a:	87ae                	mv	a5,a1
    8000555c:	fac43c23          	sd	a2,-72(s0)
    80005560:	fcf42223          	sw	a5,-60(s0)
    80005564:	87b6                	mv	a5,a3
    80005566:	fcf42023          	sw	a5,-64(s0)
    8000556a:	87ba                	mv	a5,a4
    8000556c:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005570:	fc843783          	ld	a5,-56(s0)
    80005574:	47fc                	lw	a5,76(a5)
    80005576:	fc042703          	lw	a4,-64(s0)
    8000557a:	2701                	sext.w	a4,a4
    8000557c:	00e7ee63          	bltu	a5,a4,80005598 <readi+0x4a>
    80005580:	fc042783          	lw	a5,-64(s0)
    80005584:	873e                	mv	a4,a5
    80005586:	fb442783          	lw	a5,-76(s0)
    8000558a:	9fb9                	addw	a5,a5,a4
    8000558c:	2781                	sext.w	a5,a5
    8000558e:	fc042703          	lw	a4,-64(s0)
    80005592:	2701                	sext.w	a4,a4
    80005594:	00e7f463          	bgeu	a5,a4,8000559c <readi+0x4e>
    return 0;
    80005598:	4781                	li	a5,0
    8000559a:	aa0d                	j	800056cc <readi+0x17e>
  if(off + n > ip->size)
    8000559c:	fc042783          	lw	a5,-64(s0)
    800055a0:	873e                	mv	a4,a5
    800055a2:	fb442783          	lw	a5,-76(s0)
    800055a6:	9fb9                	addw	a5,a5,a4
    800055a8:	0007871b          	sext.w	a4,a5
    800055ac:	fc843783          	ld	a5,-56(s0)
    800055b0:	47fc                	lw	a5,76(a5)
    800055b2:	00e7fa63          	bgeu	a5,a4,800055c6 <readi+0x78>
    n = ip->size - off;
    800055b6:	fc843783          	ld	a5,-56(s0)
    800055ba:	47fc                	lw	a5,76(a5)
    800055bc:	fc042703          	lw	a4,-64(s0)
    800055c0:	9f99                	subw	a5,a5,a4
    800055c2:	faf42a23          	sw	a5,-76(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800055c6:	fe042623          	sw	zero,-20(s0)
    800055ca:	a0e5                	j	800056b2 <readi+0x164>
    uint addr = bmap(ip, off/BSIZE);
    800055cc:	fc042783          	lw	a5,-64(s0)
    800055d0:	00a7d79b          	srliw	a5,a5,0xa
    800055d4:	2781                	sext.w	a5,a5
    800055d6:	85be                	mv	a1,a5
    800055d8:	fc843503          	ld	a0,-56(s0)
    800055dc:	c83ff0ef          	jal	8000525e <bmap>
    800055e0:	87aa                	mv	a5,a0
    800055e2:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    800055e6:	fe842783          	lw	a5,-24(s0)
    800055ea:	2781                	sext.w	a5,a5
    800055ec:	cfe9                	beqz	a5,800056c6 <readi+0x178>
      break;
    bp = bread(ip->dev, addr);
    800055ee:	fc843783          	ld	a5,-56(s0)
    800055f2:	439c                	lw	a5,0(a5)
    800055f4:	fe842703          	lw	a4,-24(s0)
    800055f8:	85ba                	mv	a1,a4
    800055fa:	853e                	mv	a0,a5
    800055fc:	83aff0ef          	jal	80004636 <bread>
    80005600:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005604:	fc042783          	lw	a5,-64(s0)
    80005608:	3ff7f793          	andi	a5,a5,1023
    8000560c:	2781                	sext.w	a5,a5
    8000560e:	40000713          	li	a4,1024
    80005612:	40f707bb          	subw	a5,a4,a5
    80005616:	2781                	sext.w	a5,a5
    80005618:	fb442703          	lw	a4,-76(s0)
    8000561c:	86ba                	mv	a3,a4
    8000561e:	fec42703          	lw	a4,-20(s0)
    80005622:	40e6873b          	subw	a4,a3,a4
    80005626:	2701                	sext.w	a4,a4
    80005628:	863a                	mv	a2,a4
    8000562a:	0007869b          	sext.w	a3,a5
    8000562e:	0006071b          	sext.w	a4,a2
    80005632:	00d77363          	bgeu	a4,a3,80005638 <readi+0xea>
    80005636:	87b2                	mv	a5,a2
    80005638:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000563c:	fe043783          	ld	a5,-32(s0)
    80005640:	05878713          	addi	a4,a5,88
    80005644:	fc046783          	lwu	a5,-64(s0)
    80005648:	3ff7f793          	andi	a5,a5,1023
    8000564c:	973e                	add	a4,a4,a5
    8000564e:	fdc46683          	lwu	a3,-36(s0)
    80005652:	fc442783          	lw	a5,-60(s0)
    80005656:	863a                	mv	a2,a4
    80005658:	fb843583          	ld	a1,-72(s0)
    8000565c:	853e                	mv	a0,a5
    8000565e:	e7ffd0ef          	jal	800034dc <either_copyout>
    80005662:	87aa                	mv	a5,a0
    80005664:	873e                	mv	a4,a5
    80005666:	57fd                	li	a5,-1
    80005668:	00f71a63          	bne	a4,a5,8000567c <readi+0x12e>
      brelse(bp);
    8000566c:	fe043503          	ld	a0,-32(s0)
    80005670:	854ff0ef          	jal	800046c4 <brelse>
      tot = -1;
    80005674:	57fd                	li	a5,-1
    80005676:	fef42623          	sw	a5,-20(s0)
      break;
    8000567a:	a0b9                	j	800056c8 <readi+0x17a>
    }
    brelse(bp);
    8000567c:	fe043503          	ld	a0,-32(s0)
    80005680:	844ff0ef          	jal	800046c4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005684:	fec42783          	lw	a5,-20(s0)
    80005688:	873e                	mv	a4,a5
    8000568a:	fdc42783          	lw	a5,-36(s0)
    8000568e:	9fb9                	addw	a5,a5,a4
    80005690:	fef42623          	sw	a5,-20(s0)
    80005694:	fc042783          	lw	a5,-64(s0)
    80005698:	873e                	mv	a4,a5
    8000569a:	fdc42783          	lw	a5,-36(s0)
    8000569e:	9fb9                	addw	a5,a5,a4
    800056a0:	fcf42023          	sw	a5,-64(s0)
    800056a4:	fdc46783          	lwu	a5,-36(s0)
    800056a8:	fb843703          	ld	a4,-72(s0)
    800056ac:	97ba                	add	a5,a5,a4
    800056ae:	faf43c23          	sd	a5,-72(s0)
    800056b2:	fec42783          	lw	a5,-20(s0)
    800056b6:	873e                	mv	a4,a5
    800056b8:	fb442783          	lw	a5,-76(s0)
    800056bc:	2701                	sext.w	a4,a4
    800056be:	2781                	sext.w	a5,a5
    800056c0:	f0f766e3          	bltu	a4,a5,800055cc <readi+0x7e>
    800056c4:	a011                	j	800056c8 <readi+0x17a>
      break;
    800056c6:	0001                	nop
  }
  return tot;
    800056c8:	fec42783          	lw	a5,-20(s0)
}
    800056cc:	853e                	mv	a0,a5
    800056ce:	60a6                	ld	ra,72(sp)
    800056d0:	6406                	ld	s0,64(sp)
    800056d2:	6161                	addi	sp,sp,80
    800056d4:	8082                	ret

00000000800056d6 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    800056d6:	715d                	addi	sp,sp,-80
    800056d8:	e486                	sd	ra,72(sp)
    800056da:	e0a2                	sd	s0,64(sp)
    800056dc:	0880                	addi	s0,sp,80
    800056de:	fca43423          	sd	a0,-56(s0)
    800056e2:	87ae                	mv	a5,a1
    800056e4:	fac43c23          	sd	a2,-72(s0)
    800056e8:	fcf42223          	sw	a5,-60(s0)
    800056ec:	87b6                	mv	a5,a3
    800056ee:	fcf42023          	sw	a5,-64(s0)
    800056f2:	87ba                	mv	a5,a4
    800056f4:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800056f8:	fc843783          	ld	a5,-56(s0)
    800056fc:	47fc                	lw	a5,76(a5)
    800056fe:	fc042703          	lw	a4,-64(s0)
    80005702:	2701                	sext.w	a4,a4
    80005704:	00e7ee63          	bltu	a5,a4,80005720 <writei+0x4a>
    80005708:	fc042783          	lw	a5,-64(s0)
    8000570c:	873e                	mv	a4,a5
    8000570e:	fb442783          	lw	a5,-76(s0)
    80005712:	9fb9                	addw	a5,a5,a4
    80005714:	2781                	sext.w	a5,a5
    80005716:	fc042703          	lw	a4,-64(s0)
    8000571a:	2701                	sext.w	a4,a4
    8000571c:	00e7f463          	bgeu	a5,a4,80005724 <writei+0x4e>
    return -1;
    80005720:	57fd                	li	a5,-1
    80005722:	a2a1                	j	8000586a <writei+0x194>
  if(off + n > MAXFILE*BSIZE)
    80005724:	fc042783          	lw	a5,-64(s0)
    80005728:	873e                	mv	a4,a5
    8000572a:	fb442783          	lw	a5,-76(s0)
    8000572e:	9fb9                	addw	a5,a5,a4
    80005730:	0007871b          	sext.w	a4,a5
    80005734:	000437b7          	lui	a5,0x43
    80005738:	00e7f463          	bgeu	a5,a4,80005740 <writei+0x6a>
    return -1;
    8000573c:	57fd                	li	a5,-1
    8000573e:	a235                	j	8000586a <writei+0x194>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005740:	fe042623          	sw	zero,-20(s0)
    80005744:	a0ed                	j	8000582e <writei+0x158>
    uint addr = bmap(ip, off/BSIZE);
    80005746:	fc042783          	lw	a5,-64(s0)
    8000574a:	00a7d79b          	srliw	a5,a5,0xa
    8000574e:	2781                	sext.w	a5,a5
    80005750:	85be                	mv	a1,a5
    80005752:	fc843503          	ld	a0,-56(s0)
    80005756:	b09ff0ef          	jal	8000525e <bmap>
    8000575a:	87aa                	mv	a5,a0
    8000575c:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80005760:	fe842783          	lw	a5,-24(s0)
    80005764:	2781                	sext.w	a5,a5
    80005766:	cff1                	beqz	a5,80005842 <writei+0x16c>
      break;
    bp = bread(ip->dev, addr);
    80005768:	fc843783          	ld	a5,-56(s0)
    8000576c:	439c                	lw	a5,0(a5)
    8000576e:	fe842703          	lw	a4,-24(s0)
    80005772:	85ba                	mv	a1,a4
    80005774:	853e                	mv	a0,a5
    80005776:	ec1fe0ef          	jal	80004636 <bread>
    8000577a:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    8000577e:	fc042783          	lw	a5,-64(s0)
    80005782:	3ff7f793          	andi	a5,a5,1023
    80005786:	2781                	sext.w	a5,a5
    80005788:	40000713          	li	a4,1024
    8000578c:	40f707bb          	subw	a5,a4,a5
    80005790:	2781                	sext.w	a5,a5
    80005792:	fb442703          	lw	a4,-76(s0)
    80005796:	86ba                	mv	a3,a4
    80005798:	fec42703          	lw	a4,-20(s0)
    8000579c:	40e6873b          	subw	a4,a3,a4
    800057a0:	2701                	sext.w	a4,a4
    800057a2:	863a                	mv	a2,a4
    800057a4:	0007869b          	sext.w	a3,a5
    800057a8:	0006071b          	sext.w	a4,a2
    800057ac:	00d77363          	bgeu	a4,a3,800057b2 <writei+0xdc>
    800057b0:	87b2                	mv	a5,a2
    800057b2:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800057b6:	fe043783          	ld	a5,-32(s0)
    800057ba:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    800057be:	fc046783          	lwu	a5,-64(s0)
    800057c2:	3ff7f793          	andi	a5,a5,1023
    800057c6:	97ba                	add	a5,a5,a4
    800057c8:	fdc46683          	lwu	a3,-36(s0)
    800057cc:	fc442703          	lw	a4,-60(s0)
    800057d0:	fb843603          	ld	a2,-72(s0)
    800057d4:	85ba                	mv	a1,a4
    800057d6:	853e                	mv	a0,a5
    800057d8:	d6dfd0ef          	jal	80003544 <either_copyin>
    800057dc:	87aa                	mv	a5,a0
    800057de:	873e                	mv	a4,a5
    800057e0:	57fd                	li	a5,-1
    800057e2:	00f71763          	bne	a4,a5,800057f0 <writei+0x11a>
      brelse(bp);
    800057e6:	fe043503          	ld	a0,-32(s0)
    800057ea:	edbfe0ef          	jal	800046c4 <brelse>
      break;
    800057ee:	a899                	j	80005844 <writei+0x16e>
    }
    log_write(bp);
    800057f0:	fe043503          	ld	a0,-32(s0)
    800057f4:	1d9000ef          	jal	800061cc <log_write>
    brelse(bp);
    800057f8:	fe043503          	ld	a0,-32(s0)
    800057fc:	ec9fe0ef          	jal	800046c4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005800:	fec42783          	lw	a5,-20(s0)
    80005804:	873e                	mv	a4,a5
    80005806:	fdc42783          	lw	a5,-36(s0)
    8000580a:	9fb9                	addw	a5,a5,a4
    8000580c:	fef42623          	sw	a5,-20(s0)
    80005810:	fc042783          	lw	a5,-64(s0)
    80005814:	873e                	mv	a4,a5
    80005816:	fdc42783          	lw	a5,-36(s0)
    8000581a:	9fb9                	addw	a5,a5,a4
    8000581c:	fcf42023          	sw	a5,-64(s0)
    80005820:	fdc46783          	lwu	a5,-36(s0)
    80005824:	fb843703          	ld	a4,-72(s0)
    80005828:	97ba                	add	a5,a5,a4
    8000582a:	faf43c23          	sd	a5,-72(s0)
    8000582e:	fec42783          	lw	a5,-20(s0)
    80005832:	873e                	mv	a4,a5
    80005834:	fb442783          	lw	a5,-76(s0)
    80005838:	2701                	sext.w	a4,a4
    8000583a:	2781                	sext.w	a5,a5
    8000583c:	f0f765e3          	bltu	a4,a5,80005746 <writei+0x70>
    80005840:	a011                	j	80005844 <writei+0x16e>
      break;
    80005842:	0001                	nop
  }

  if(off > ip->size)
    80005844:	fc843783          	ld	a5,-56(s0)
    80005848:	47fc                	lw	a5,76(a5)
    8000584a:	fc042703          	lw	a4,-64(s0)
    8000584e:	2701                	sext.w	a4,a4
    80005850:	00e7f763          	bgeu	a5,a4,8000585e <writei+0x188>
    ip->size = off;
    80005854:	fc843783          	ld	a5,-56(s0)
    80005858:	fc042703          	lw	a4,-64(s0)
    8000585c:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    8000585e:	fc843503          	ld	a0,-56(s0)
    80005862:	caeff0ef          	jal	80004d10 <iupdate>

  return tot;
    80005866:	fec42783          	lw	a5,-20(s0)
}
    8000586a:	853e                	mv	a0,a5
    8000586c:	60a6                	ld	ra,72(sp)
    8000586e:	6406                	ld	s0,64(sp)
    80005870:	6161                	addi	sp,sp,80
    80005872:	8082                	ret

0000000080005874 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80005874:	1101                	addi	sp,sp,-32
    80005876:	ec06                	sd	ra,24(sp)
    80005878:	e822                	sd	s0,16(sp)
    8000587a:	1000                	addi	s0,sp,32
    8000587c:	fea43423          	sd	a0,-24(s0)
    80005880:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80005884:	4639                	li	a2,14
    80005886:	fe043583          	ld	a1,-32(s0)
    8000588a:	fe843503          	ld	a0,-24(s0)
    8000588e:	e49fb0ef          	jal	800016d6 <strncmp>
    80005892:	87aa                	mv	a5,a0
}
    80005894:	853e                	mv	a0,a5
    80005896:	60e2                	ld	ra,24(sp)
    80005898:	6442                	ld	s0,16(sp)
    8000589a:	6105                	addi	sp,sp,32
    8000589c:	8082                	ret

000000008000589e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000589e:	715d                	addi	sp,sp,-80
    800058a0:	e486                	sd	ra,72(sp)
    800058a2:	e0a2                	sd	s0,64(sp)
    800058a4:	0880                	addi	s0,sp,80
    800058a6:	fca43423          	sd	a0,-56(s0)
    800058aa:	fcb43023          	sd	a1,-64(s0)
    800058ae:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800058b2:	fc843783          	ld	a5,-56(s0)
    800058b6:	04479703          	lh	a4,68(a5)
    800058ba:	4785                	li	a5,1
    800058bc:	00f70863          	beq	a4,a5,800058cc <dirlookup+0x2e>
    panic("dirlookup not DIR");
    800058c0:	00005517          	auipc	a0,0x5
    800058c4:	c9850513          	addi	a0,a0,-872 # 8000a558 <etext+0x558>
    800058c8:	d6efb0ef          	jal	80000e36 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    800058cc:	fe042623          	sw	zero,-20(s0)
    800058d0:	a049                	j	80005952 <dirlookup+0xb4>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800058d2:	fd840793          	addi	a5,s0,-40
    800058d6:	fec42683          	lw	a3,-20(s0)
    800058da:	4741                	li	a4,16
    800058dc:	863e                	mv	a2,a5
    800058de:	4581                	li	a1,0
    800058e0:	fc843503          	ld	a0,-56(s0)
    800058e4:	c6bff0ef          	jal	8000554e <readi>
    800058e8:	87aa                	mv	a5,a0
    800058ea:	873e                	mv	a4,a5
    800058ec:	47c1                	li	a5,16
    800058ee:	00f70863          	beq	a4,a5,800058fe <dirlookup+0x60>
      panic("dirlookup read");
    800058f2:	00005517          	auipc	a0,0x5
    800058f6:	c7e50513          	addi	a0,a0,-898 # 8000a570 <etext+0x570>
    800058fa:	d3cfb0ef          	jal	80000e36 <panic>
    if(de.inum == 0)
    800058fe:	fd845783          	lhu	a5,-40(s0)
    80005902:	c3b1                	beqz	a5,80005946 <dirlookup+0xa8>
      continue;
    if(namecmp(name, de.name) == 0){
    80005904:	fd840793          	addi	a5,s0,-40
    80005908:	0789                	addi	a5,a5,2
    8000590a:	85be                	mv	a1,a5
    8000590c:	fc043503          	ld	a0,-64(s0)
    80005910:	f65ff0ef          	jal	80005874 <namecmp>
    80005914:	87aa                	mv	a5,a0
    80005916:	eb8d                	bnez	a5,80005948 <dirlookup+0xaa>
      // entry matches path element
      if(poff)
    80005918:	fb843783          	ld	a5,-72(s0)
    8000591c:	c791                	beqz	a5,80005928 <dirlookup+0x8a>
        *poff = off;
    8000591e:	fb843783          	ld	a5,-72(s0)
    80005922:	fec42703          	lw	a4,-20(s0)
    80005926:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80005928:	fd845783          	lhu	a5,-40(s0)
    8000592c:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005930:	fc843783          	ld	a5,-56(s0)
    80005934:	439c                	lw	a5,0(a5)
    80005936:	fe842703          	lw	a4,-24(s0)
    8000593a:	85ba                	mv	a1,a4
    8000593c:	853e                	mv	a0,a5
    8000593e:	caaff0ef          	jal	80004de8 <iget>
    80005942:	87aa                	mv	a5,a0
    80005944:	a005                	j	80005964 <dirlookup+0xc6>
      continue;
    80005946:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005948:	fec42783          	lw	a5,-20(s0)
    8000594c:	27c1                	addiw	a5,a5,16
    8000594e:	fef42623          	sw	a5,-20(s0)
    80005952:	fc843783          	ld	a5,-56(s0)
    80005956:	47fc                	lw	a5,76(a5)
    80005958:	fec42703          	lw	a4,-20(s0)
    8000595c:	2701                	sext.w	a4,a4
    8000595e:	f6f76ae3          	bltu	a4,a5,800058d2 <dirlookup+0x34>
    }
  }

  return 0;
    80005962:	4781                	li	a5,0
}
    80005964:	853e                	mv	a0,a5
    80005966:	60a6                	ld	ra,72(sp)
    80005968:	6406                	ld	s0,64(sp)
    8000596a:	6161                	addi	sp,sp,80
    8000596c:	8082                	ret

000000008000596e <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
// Returns 0 on success, -1 on failure (e.g. out of disk blocks).
int
dirlink(struct inode *dp, char *name, uint inum)
{
    8000596e:	715d                	addi	sp,sp,-80
    80005970:	e486                	sd	ra,72(sp)
    80005972:	e0a2                	sd	s0,64(sp)
    80005974:	0880                	addi	s0,sp,80
    80005976:	fca43423          	sd	a0,-56(s0)
    8000597a:	fcb43023          	sd	a1,-64(s0)
    8000597e:	87b2                	mv	a5,a2
    80005980:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80005984:	4601                	li	a2,0
    80005986:	fc043583          	ld	a1,-64(s0)
    8000598a:	fc843503          	ld	a0,-56(s0)
    8000598e:	f11ff0ef          	jal	8000589e <dirlookup>
    80005992:	fea43023          	sd	a0,-32(s0)
    80005996:	fe043783          	ld	a5,-32(s0)
    8000599a:	c799                	beqz	a5,800059a8 <dirlink+0x3a>
    iput(ip);
    8000599c:	fe043503          	ld	a0,-32(s0)
    800059a0:	f02ff0ef          	jal	800050a2 <iput>
    return -1;
    800059a4:	57fd                	li	a5,-1
    800059a6:	a871                	j	80005a42 <dirlink+0xd4>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    800059a8:	fe042623          	sw	zero,-20(s0)
    800059ac:	a081                	j	800059ec <dirlink+0x7e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800059ae:	fd040793          	addi	a5,s0,-48
    800059b2:	fec42683          	lw	a3,-20(s0)
    800059b6:	4741                	li	a4,16
    800059b8:	863e                	mv	a2,a5
    800059ba:	4581                	li	a1,0
    800059bc:	fc843503          	ld	a0,-56(s0)
    800059c0:	b8fff0ef          	jal	8000554e <readi>
    800059c4:	87aa                	mv	a5,a0
    800059c6:	873e                	mv	a4,a5
    800059c8:	47c1                	li	a5,16
    800059ca:	00f70863          	beq	a4,a5,800059da <dirlink+0x6c>
      panic("dirlink read");
    800059ce:	00005517          	auipc	a0,0x5
    800059d2:	bb250513          	addi	a0,a0,-1102 # 8000a580 <etext+0x580>
    800059d6:	c60fb0ef          	jal	80000e36 <panic>
    if(de.inum == 0)
    800059da:	fd045783          	lhu	a5,-48(s0)
    800059de:	cf99                	beqz	a5,800059fc <dirlink+0x8e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800059e0:	fec42783          	lw	a5,-20(s0)
    800059e4:	27c1                	addiw	a5,a5,16
    800059e6:	2781                	sext.w	a5,a5
    800059e8:	fef42623          	sw	a5,-20(s0)
    800059ec:	fc843783          	ld	a5,-56(s0)
    800059f0:	47f8                	lw	a4,76(a5)
    800059f2:	fec42783          	lw	a5,-20(s0)
    800059f6:	fae7ece3          	bltu	a5,a4,800059ae <dirlink+0x40>
    800059fa:	a011                	j	800059fe <dirlink+0x90>
      break;
    800059fc:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    800059fe:	fd040793          	addi	a5,s0,-48
    80005a02:	0789                	addi	a5,a5,2
    80005a04:	4639                	li	a2,14
    80005a06:	fc043583          	ld	a1,-64(s0)
    80005a0a:	853e                	mv	a0,a5
    80005a0c:	d59fb0ef          	jal	80001764 <strncpy>
  de.inum = inum;
    80005a10:	fbc42783          	lw	a5,-68(s0)
    80005a14:	17c2                	slli	a5,a5,0x30
    80005a16:	93c1                	srli	a5,a5,0x30
    80005a18:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005a1c:	fd040793          	addi	a5,s0,-48
    80005a20:	fec42683          	lw	a3,-20(s0)
    80005a24:	4741                	li	a4,16
    80005a26:	863e                	mv	a2,a5
    80005a28:	4581                	li	a1,0
    80005a2a:	fc843503          	ld	a0,-56(s0)
    80005a2e:	ca9ff0ef          	jal	800056d6 <writei>
    80005a32:	87aa                	mv	a5,a0
    80005a34:	873e                	mv	a4,a5
    80005a36:	47c1                	li	a5,16
    80005a38:	00f70463          	beq	a4,a5,80005a40 <dirlink+0xd2>
    return -1;
    80005a3c:	57fd                	li	a5,-1
    80005a3e:	a011                	j	80005a42 <dirlink+0xd4>

  return 0;
    80005a40:	4781                	li	a5,0
}
    80005a42:	853e                	mv	a0,a5
    80005a44:	60a6                	ld	ra,72(sp)
    80005a46:	6406                	ld	s0,64(sp)
    80005a48:	6161                	addi	sp,sp,80
    80005a4a:	8082                	ret

0000000080005a4c <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80005a4c:	7179                	addi	sp,sp,-48
    80005a4e:	f406                	sd	ra,40(sp)
    80005a50:	f022                	sd	s0,32(sp)
    80005a52:	1800                	addi	s0,sp,48
    80005a54:	fca43c23          	sd	a0,-40(s0)
    80005a58:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80005a5c:	a031                	j	80005a68 <skipelem+0x1c>
    path++;
    80005a5e:	fd843783          	ld	a5,-40(s0)
    80005a62:	0785                	addi	a5,a5,1
    80005a64:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005a68:	fd843783          	ld	a5,-40(s0)
    80005a6c:	0007c783          	lbu	a5,0(a5)
    80005a70:	873e                	mv	a4,a5
    80005a72:	02f00793          	li	a5,47
    80005a76:	fef704e3          	beq	a4,a5,80005a5e <skipelem+0x12>
  if(*path == 0)
    80005a7a:	fd843783          	ld	a5,-40(s0)
    80005a7e:	0007c783          	lbu	a5,0(a5)
    80005a82:	e399                	bnez	a5,80005a88 <skipelem+0x3c>
    return 0;
    80005a84:	4781                	li	a5,0
    80005a86:	a04d                	j	80005b28 <skipelem+0xdc>
  s = path;
    80005a88:	fd843783          	ld	a5,-40(s0)
    80005a8c:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80005a90:	a031                	j	80005a9c <skipelem+0x50>
    path++;
    80005a92:	fd843783          	ld	a5,-40(s0)
    80005a96:	0785                	addi	a5,a5,1
    80005a98:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80005a9c:	fd843783          	ld	a5,-40(s0)
    80005aa0:	0007c783          	lbu	a5,0(a5)
    80005aa4:	873e                	mv	a4,a5
    80005aa6:	02f00793          	li	a5,47
    80005aaa:	00f70763          	beq	a4,a5,80005ab8 <skipelem+0x6c>
    80005aae:	fd843783          	ld	a5,-40(s0)
    80005ab2:	0007c783          	lbu	a5,0(a5)
    80005ab6:	fff1                	bnez	a5,80005a92 <skipelem+0x46>
  len = path - s;
    80005ab8:	fd843703          	ld	a4,-40(s0)
    80005abc:	fe843783          	ld	a5,-24(s0)
    80005ac0:	40f707b3          	sub	a5,a4,a5
    80005ac4:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80005ac8:	fe442783          	lw	a5,-28(s0)
    80005acc:	0007871b          	sext.w	a4,a5
    80005ad0:	47b5                	li	a5,13
    80005ad2:	00e7da63          	bge	a5,a4,80005ae6 <skipelem+0x9a>
    memmove(name, s, DIRSIZ);
    80005ad6:	4639                	li	a2,14
    80005ad8:	fe843583          	ld	a1,-24(s0)
    80005adc:	fd043503          	ld	a0,-48(s0)
    80005ae0:	ae3fb0ef          	jal	800015c2 <memmove>
    80005ae4:	a03d                	j	80005b12 <skipelem+0xc6>
  else {
    memmove(name, s, len);
    80005ae6:	fe442783          	lw	a5,-28(s0)
    80005aea:	863e                	mv	a2,a5
    80005aec:	fe843583          	ld	a1,-24(s0)
    80005af0:	fd043503          	ld	a0,-48(s0)
    80005af4:	acffb0ef          	jal	800015c2 <memmove>
    name[len] = 0;
    80005af8:	fe442783          	lw	a5,-28(s0)
    80005afc:	fd043703          	ld	a4,-48(s0)
    80005b00:	97ba                	add	a5,a5,a4
    80005b02:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005b06:	a031                	j	80005b12 <skipelem+0xc6>
    path++;
    80005b08:	fd843783          	ld	a5,-40(s0)
    80005b0c:	0785                	addi	a5,a5,1
    80005b0e:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005b12:	fd843783          	ld	a5,-40(s0)
    80005b16:	0007c783          	lbu	a5,0(a5)
    80005b1a:	873e                	mv	a4,a5
    80005b1c:	02f00793          	li	a5,47
    80005b20:	fef704e3          	beq	a4,a5,80005b08 <skipelem+0xbc>
  return path;
    80005b24:	fd843783          	ld	a5,-40(s0)
}
    80005b28:	853e                	mv	a0,a5
    80005b2a:	70a2                	ld	ra,40(sp)
    80005b2c:	7402                	ld	s0,32(sp)
    80005b2e:	6145                	addi	sp,sp,48
    80005b30:	8082                	ret

0000000080005b32 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005b32:	7139                	addi	sp,sp,-64
    80005b34:	fc06                	sd	ra,56(sp)
    80005b36:	f822                	sd	s0,48(sp)
    80005b38:	0080                	addi	s0,sp,64
    80005b3a:	fca43c23          	sd	a0,-40(s0)
    80005b3e:	87ae                	mv	a5,a1
    80005b40:	fcc43423          	sd	a2,-56(s0)
    80005b44:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80005b48:	fd843783          	ld	a5,-40(s0)
    80005b4c:	0007c783          	lbu	a5,0(a5)
    80005b50:	873e                	mv	a4,a5
    80005b52:	02f00793          	li	a5,47
    80005b56:	00f71963          	bne	a4,a5,80005b68 <namex+0x36>
    ip = iget(ROOTDEV, ROOTINO);
    80005b5a:	4585                	li	a1,1
    80005b5c:	4505                	li	a0,1
    80005b5e:	a8aff0ef          	jal	80004de8 <iget>
    80005b62:	fea43423          	sd	a0,-24(s0)
    80005b66:	a079                	j	80005bf4 <namex+0xc2>
  else
    ip = idup(myproc()->cwd);
    80005b68:	cedfc0ef          	jal	80002854 <myproc>
    80005b6c:	87aa                	mv	a5,a0
    80005b6e:	1507b783          	ld	a5,336(a5)
    80005b72:	853e                	mv	a0,a5
    80005b74:	b80ff0ef          	jal	80004ef4 <idup>
    80005b78:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80005b7c:	a8a5                	j	80005bf4 <namex+0xc2>
    ilock(ip);
    80005b7e:	fe843503          	ld	a0,-24(s0)
    80005b82:	bb6ff0ef          	jal	80004f38 <ilock>
    if(ip->type != T_DIR){
    80005b86:	fe843783          	ld	a5,-24(s0)
    80005b8a:	04479703          	lh	a4,68(a5)
    80005b8e:	4785                	li	a5,1
    80005b90:	00f70863          	beq	a4,a5,80005ba0 <namex+0x6e>
      iunlockput(ip);
    80005b94:	fe843503          	ld	a0,-24(s0)
    80005b98:	db8ff0ef          	jal	80005150 <iunlockput>
      return 0;
    80005b9c:	4781                	li	a5,0
    80005b9e:	a051                	j	80005c22 <namex+0xf0>
    }
    if(nameiparent && *path == '\0'){
    80005ba0:	fd442783          	lw	a5,-44(s0)
    80005ba4:	2781                	sext.w	a5,a5
    80005ba6:	cf89                	beqz	a5,80005bc0 <namex+0x8e>
    80005ba8:	fd843783          	ld	a5,-40(s0)
    80005bac:	0007c783          	lbu	a5,0(a5)
    80005bb0:	eb81                	bnez	a5,80005bc0 <namex+0x8e>
      // Stop one level early.
      iunlock(ip);
    80005bb2:	fe843503          	ld	a0,-24(s0)
    80005bb6:	c9eff0ef          	jal	80005054 <iunlock>
      return ip;
    80005bba:	fe843783          	ld	a5,-24(s0)
    80005bbe:	a095                	j	80005c22 <namex+0xf0>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80005bc0:	4601                	li	a2,0
    80005bc2:	fc843583          	ld	a1,-56(s0)
    80005bc6:	fe843503          	ld	a0,-24(s0)
    80005bca:	cd5ff0ef          	jal	8000589e <dirlookup>
    80005bce:	fea43023          	sd	a0,-32(s0)
    80005bd2:	fe043783          	ld	a5,-32(s0)
    80005bd6:	e799                	bnez	a5,80005be4 <namex+0xb2>
      iunlockput(ip);
    80005bd8:	fe843503          	ld	a0,-24(s0)
    80005bdc:	d74ff0ef          	jal	80005150 <iunlockput>
      return 0;
    80005be0:	4781                	li	a5,0
    80005be2:	a081                	j	80005c22 <namex+0xf0>
    }
    iunlockput(ip);
    80005be4:	fe843503          	ld	a0,-24(s0)
    80005be8:	d68ff0ef          	jal	80005150 <iunlockput>
    ip = next;
    80005bec:	fe043783          	ld	a5,-32(s0)
    80005bf0:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80005bf4:	fc843583          	ld	a1,-56(s0)
    80005bf8:	fd843503          	ld	a0,-40(s0)
    80005bfc:	e51ff0ef          	jal	80005a4c <skipelem>
    80005c00:	fca43c23          	sd	a0,-40(s0)
    80005c04:	fd843783          	ld	a5,-40(s0)
    80005c08:	fbbd                	bnez	a5,80005b7e <namex+0x4c>
  }
  if(nameiparent){
    80005c0a:	fd442783          	lw	a5,-44(s0)
    80005c0e:	2781                	sext.w	a5,a5
    80005c10:	c799                	beqz	a5,80005c1e <namex+0xec>
    iput(ip);
    80005c12:	fe843503          	ld	a0,-24(s0)
    80005c16:	c8cff0ef          	jal	800050a2 <iput>
    return 0;
    80005c1a:	4781                	li	a5,0
    80005c1c:	a019                	j	80005c22 <namex+0xf0>
  }
  return ip;
    80005c1e:	fe843783          	ld	a5,-24(s0)
}
    80005c22:	853e                	mv	a0,a5
    80005c24:	70e2                	ld	ra,56(sp)
    80005c26:	7442                	ld	s0,48(sp)
    80005c28:	6121                	addi	sp,sp,64
    80005c2a:	8082                	ret

0000000080005c2c <namei>:

struct inode*
namei(char *path)
{
    80005c2c:	7179                	addi	sp,sp,-48
    80005c2e:	f406                	sd	ra,40(sp)
    80005c30:	f022                	sd	s0,32(sp)
    80005c32:	1800                	addi	s0,sp,48
    80005c34:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80005c38:	fe040793          	addi	a5,s0,-32
    80005c3c:	863e                	mv	a2,a5
    80005c3e:	4581                	li	a1,0
    80005c40:	fd843503          	ld	a0,-40(s0)
    80005c44:	eefff0ef          	jal	80005b32 <namex>
    80005c48:	87aa                	mv	a5,a0
}
    80005c4a:	853e                	mv	a0,a5
    80005c4c:	70a2                	ld	ra,40(sp)
    80005c4e:	7402                	ld	s0,32(sp)
    80005c50:	6145                	addi	sp,sp,48
    80005c52:	8082                	ret

0000000080005c54 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80005c54:	1101                	addi	sp,sp,-32
    80005c56:	ec06                	sd	ra,24(sp)
    80005c58:	e822                	sd	s0,16(sp)
    80005c5a:	1000                	addi	s0,sp,32
    80005c5c:	fea43423          	sd	a0,-24(s0)
    80005c60:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80005c64:	fe043603          	ld	a2,-32(s0)
    80005c68:	4585                	li	a1,1
    80005c6a:	fe843503          	ld	a0,-24(s0)
    80005c6e:	ec5ff0ef          	jal	80005b32 <namex>
    80005c72:	87aa                	mv	a5,a0
}
    80005c74:	853e                	mv	a0,a5
    80005c76:	60e2                	ld	ra,24(sp)
    80005c78:	6442                	ld	s0,16(sp)
    80005c7a:	6105                	addi	sp,sp,32
    80005c7c:	8082                	ret

0000000080005c7e <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80005c7e:	1101                	addi	sp,sp,-32
    80005c80:	ec06                	sd	ra,24(sp)
    80005c82:	e822                	sd	s0,16(sp)
    80005c84:	1000                	addi	s0,sp,32
    80005c86:	87aa                	mv	a5,a0
    80005c88:	feb43023          	sd	a1,-32(s0)
    80005c8c:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80005c90:	00005597          	auipc	a1,0x5
    80005c94:	90058593          	addi	a1,a1,-1792 # 8000a590 <etext+0x590>
    80005c98:	0001d517          	auipc	a0,0x1d
    80005c9c:	d8050513          	addi	a0,a0,-640 # 80022a18 <log>
    80005ca0:	e76fb0ef          	jal	80001316 <initlock>
  log.start = sb->logstart;
    80005ca4:	fe043783          	ld	a5,-32(s0)
    80005ca8:	4bdc                	lw	a5,20(a5)
    80005caa:	873e                	mv	a4,a5
    80005cac:	0001d797          	auipc	a5,0x1d
    80005cb0:	d6c78793          	addi	a5,a5,-660 # 80022a18 <log>
    80005cb4:	cf98                	sw	a4,24(a5)
  log.dev = dev;
    80005cb6:	0001d797          	auipc	a5,0x1d
    80005cba:	d6278793          	addi	a5,a5,-670 # 80022a18 <log>
    80005cbe:	fec42703          	lw	a4,-20(s0)
    80005cc2:	d3d8                	sw	a4,36(a5)
  recover_from_log();
    80005cc4:	25e000ef          	jal	80005f22 <recover_from_log>
}
    80005cc8:	0001                	nop
    80005cca:	60e2                	ld	ra,24(sp)
    80005ccc:	6442                	ld	s0,16(sp)
    80005cce:	6105                	addi	sp,sp,32
    80005cd0:	8082                	ret

0000000080005cd2 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80005cd2:	7139                	addi	sp,sp,-64
    80005cd4:	fc06                	sd	ra,56(sp)
    80005cd6:	f822                	sd	s0,48(sp)
    80005cd8:	0080                	addi	s0,sp,64
    80005cda:	87aa                	mv	a5,a0
    80005cdc:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80005ce0:	fe042623          	sw	zero,-20(s0)
    80005ce4:	a8e9                	j	80005dbe <install_trans+0xec>
    if(recovering) {
    80005ce6:	fcc42783          	lw	a5,-52(s0)
    80005cea:	2781                	sext.w	a5,a5
    80005cec:	c78d                	beqz	a5,80005d16 <install_trans+0x44>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80005cee:	0001d717          	auipc	a4,0x1d
    80005cf2:	d2a70713          	addi	a4,a4,-726 # 80022a18 <log>
    80005cf6:	fec42783          	lw	a5,-20(s0)
    80005cfa:	07a1                	addi	a5,a5,8
    80005cfc:	078a                	slli	a5,a5,0x2
    80005cfe:	97ba                	add	a5,a5,a4
    80005d00:	47d8                	lw	a4,12(a5)
    80005d02:	fec42783          	lw	a5,-20(s0)
    80005d06:	863a                	mv	a2,a4
    80005d08:	85be                	mv	a1,a5
    80005d0a:	00005517          	auipc	a0,0x5
    80005d0e:	88e50513          	addi	a0,a0,-1906 # 8000a598 <etext+0x598>
    80005d12:	cddfa0ef          	jal	800009ee <printf>
    }
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80005d16:	0001d797          	auipc	a5,0x1d
    80005d1a:	d0278793          	addi	a5,a5,-766 # 80022a18 <log>
    80005d1e:	53dc                	lw	a5,36(a5)
    80005d20:	86be                	mv	a3,a5
    80005d22:	0001d797          	auipc	a5,0x1d
    80005d26:	cf678793          	addi	a5,a5,-778 # 80022a18 <log>
    80005d2a:	4f9c                	lw	a5,24(a5)
    80005d2c:	fec42703          	lw	a4,-20(s0)
    80005d30:	9fb9                	addw	a5,a5,a4
    80005d32:	2781                	sext.w	a5,a5
    80005d34:	2785                	addiw	a5,a5,1
    80005d36:	2781                	sext.w	a5,a5
    80005d38:	85be                	mv	a1,a5
    80005d3a:	8536                	mv	a0,a3
    80005d3c:	8fbfe0ef          	jal	80004636 <bread>
    80005d40:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80005d44:	0001d797          	auipc	a5,0x1d
    80005d48:	cd478793          	addi	a5,a5,-812 # 80022a18 <log>
    80005d4c:	53dc                	lw	a5,36(a5)
    80005d4e:	86be                	mv	a3,a5
    80005d50:	0001d717          	auipc	a4,0x1d
    80005d54:	cc870713          	addi	a4,a4,-824 # 80022a18 <log>
    80005d58:	fec42783          	lw	a5,-20(s0)
    80005d5c:	07a1                	addi	a5,a5,8
    80005d5e:	078a                	slli	a5,a5,0x2
    80005d60:	97ba                	add	a5,a5,a4
    80005d62:	47dc                	lw	a5,12(a5)
    80005d64:	85be                	mv	a1,a5
    80005d66:	8536                	mv	a0,a3
    80005d68:	8cffe0ef          	jal	80004636 <bread>
    80005d6c:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80005d70:	fd843783          	ld	a5,-40(s0)
    80005d74:	05878713          	addi	a4,a5,88
    80005d78:	fe043783          	ld	a5,-32(s0)
    80005d7c:	05878793          	addi	a5,a5,88
    80005d80:	40000613          	li	a2,1024
    80005d84:	85be                	mv	a1,a5
    80005d86:	853a                	mv	a0,a4
    80005d88:	83bfb0ef          	jal	800015c2 <memmove>
    bwrite(dbuf);  // write dst to disk
    80005d8c:	fd843503          	ld	a0,-40(s0)
    80005d90:	8f9fe0ef          	jal	80004688 <bwrite>
    if(recovering == 0)
    80005d94:	fcc42783          	lw	a5,-52(s0)
    80005d98:	2781                	sext.w	a5,a5
    80005d9a:	e789                	bnez	a5,80005da4 <install_trans+0xd2>
      bunpin(dbuf);
    80005d9c:	fd843503          	ld	a0,-40(s0)
    80005da0:	a3ffe0ef          	jal	800047de <bunpin>
    brelse(lbuf);
    80005da4:	fe043503          	ld	a0,-32(s0)
    80005da8:	91dfe0ef          	jal	800046c4 <brelse>
    brelse(dbuf);
    80005dac:	fd843503          	ld	a0,-40(s0)
    80005db0:	915fe0ef          	jal	800046c4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80005db4:	fec42783          	lw	a5,-20(s0)
    80005db8:	2785                	addiw	a5,a5,1
    80005dba:	fef42623          	sw	a5,-20(s0)
    80005dbe:	0001d797          	auipc	a5,0x1d
    80005dc2:	c5a78793          	addi	a5,a5,-934 # 80022a18 <log>
    80005dc6:	579c                	lw	a5,40(a5)
    80005dc8:	fec42703          	lw	a4,-20(s0)
    80005dcc:	2701                	sext.w	a4,a4
    80005dce:	f0f74ce3          	blt	a4,a5,80005ce6 <install_trans+0x14>
  }
}
    80005dd2:	0001                	nop
    80005dd4:	0001                	nop
    80005dd6:	70e2                	ld	ra,56(sp)
    80005dd8:	7442                	ld	s0,48(sp)
    80005dda:	6121                	addi	sp,sp,64
    80005ddc:	8082                	ret

0000000080005dde <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80005dde:	7179                	addi	sp,sp,-48
    80005de0:	f406                	sd	ra,40(sp)
    80005de2:	f022                	sd	s0,32(sp)
    80005de4:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80005de6:	0001d797          	auipc	a5,0x1d
    80005dea:	c3278793          	addi	a5,a5,-974 # 80022a18 <log>
    80005dee:	53dc                	lw	a5,36(a5)
    80005df0:	873e                	mv	a4,a5
    80005df2:	0001d797          	auipc	a5,0x1d
    80005df6:	c2678793          	addi	a5,a5,-986 # 80022a18 <log>
    80005dfa:	4f9c                	lw	a5,24(a5)
    80005dfc:	85be                	mv	a1,a5
    80005dfe:	853a                	mv	a0,a4
    80005e00:	837fe0ef          	jal	80004636 <bread>
    80005e04:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80005e08:	fe043783          	ld	a5,-32(s0)
    80005e0c:	05878793          	addi	a5,a5,88
    80005e10:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80005e14:	fd843783          	ld	a5,-40(s0)
    80005e18:	4398                	lw	a4,0(a5)
    80005e1a:	0001d797          	auipc	a5,0x1d
    80005e1e:	bfe78793          	addi	a5,a5,-1026 # 80022a18 <log>
    80005e22:	d798                	sw	a4,40(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005e24:	fe042623          	sw	zero,-20(s0)
    80005e28:	a03d                	j	80005e56 <read_head+0x78>
    log.lh.block[i] = lh->block[i];
    80005e2a:	fd843703          	ld	a4,-40(s0)
    80005e2e:	fec42783          	lw	a5,-20(s0)
    80005e32:	078a                	slli	a5,a5,0x2
    80005e34:	97ba                	add	a5,a5,a4
    80005e36:	43d8                	lw	a4,4(a5)
    80005e38:	0001d697          	auipc	a3,0x1d
    80005e3c:	be068693          	addi	a3,a3,-1056 # 80022a18 <log>
    80005e40:	fec42783          	lw	a5,-20(s0)
    80005e44:	07a1                	addi	a5,a5,8
    80005e46:	078a                	slli	a5,a5,0x2
    80005e48:	97b6                	add	a5,a5,a3
    80005e4a:	c7d8                	sw	a4,12(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005e4c:	fec42783          	lw	a5,-20(s0)
    80005e50:	2785                	addiw	a5,a5,1
    80005e52:	fef42623          	sw	a5,-20(s0)
    80005e56:	0001d797          	auipc	a5,0x1d
    80005e5a:	bc278793          	addi	a5,a5,-1086 # 80022a18 <log>
    80005e5e:	579c                	lw	a5,40(a5)
    80005e60:	fec42703          	lw	a4,-20(s0)
    80005e64:	2701                	sext.w	a4,a4
    80005e66:	fcf742e3          	blt	a4,a5,80005e2a <read_head+0x4c>
  }
  brelse(buf);
    80005e6a:	fe043503          	ld	a0,-32(s0)
    80005e6e:	857fe0ef          	jal	800046c4 <brelse>
}
    80005e72:	0001                	nop
    80005e74:	70a2                	ld	ra,40(sp)
    80005e76:	7402                	ld	s0,32(sp)
    80005e78:	6145                	addi	sp,sp,48
    80005e7a:	8082                	ret

0000000080005e7c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80005e7c:	7179                	addi	sp,sp,-48
    80005e7e:	f406                	sd	ra,40(sp)
    80005e80:	f022                	sd	s0,32(sp)
    80005e82:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80005e84:	0001d797          	auipc	a5,0x1d
    80005e88:	b9478793          	addi	a5,a5,-1132 # 80022a18 <log>
    80005e8c:	53dc                	lw	a5,36(a5)
    80005e8e:	873e                	mv	a4,a5
    80005e90:	0001d797          	auipc	a5,0x1d
    80005e94:	b8878793          	addi	a5,a5,-1144 # 80022a18 <log>
    80005e98:	4f9c                	lw	a5,24(a5)
    80005e9a:	85be                	mv	a1,a5
    80005e9c:	853a                	mv	a0,a4
    80005e9e:	f98fe0ef          	jal	80004636 <bread>
    80005ea2:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80005ea6:	fe043783          	ld	a5,-32(s0)
    80005eaa:	05878793          	addi	a5,a5,88
    80005eae:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80005eb2:	0001d797          	auipc	a5,0x1d
    80005eb6:	b6678793          	addi	a5,a5,-1178 # 80022a18 <log>
    80005eba:	5798                	lw	a4,40(a5)
    80005ebc:	fd843783          	ld	a5,-40(s0)
    80005ec0:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005ec2:	fe042623          	sw	zero,-20(s0)
    80005ec6:	a03d                	j	80005ef4 <write_head+0x78>
    hb->block[i] = log.lh.block[i];
    80005ec8:	0001d717          	auipc	a4,0x1d
    80005ecc:	b5070713          	addi	a4,a4,-1200 # 80022a18 <log>
    80005ed0:	fec42783          	lw	a5,-20(s0)
    80005ed4:	07a1                	addi	a5,a5,8
    80005ed6:	078a                	slli	a5,a5,0x2
    80005ed8:	97ba                	add	a5,a5,a4
    80005eda:	47d8                	lw	a4,12(a5)
    80005edc:	fd843683          	ld	a3,-40(s0)
    80005ee0:	fec42783          	lw	a5,-20(s0)
    80005ee4:	078a                	slli	a5,a5,0x2
    80005ee6:	97b6                	add	a5,a5,a3
    80005ee8:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005eea:	fec42783          	lw	a5,-20(s0)
    80005eee:	2785                	addiw	a5,a5,1
    80005ef0:	fef42623          	sw	a5,-20(s0)
    80005ef4:	0001d797          	auipc	a5,0x1d
    80005ef8:	b2478793          	addi	a5,a5,-1244 # 80022a18 <log>
    80005efc:	579c                	lw	a5,40(a5)
    80005efe:	fec42703          	lw	a4,-20(s0)
    80005f02:	2701                	sext.w	a4,a4
    80005f04:	fcf742e3          	blt	a4,a5,80005ec8 <write_head+0x4c>
  }
  bwrite(buf);
    80005f08:	fe043503          	ld	a0,-32(s0)
    80005f0c:	f7cfe0ef          	jal	80004688 <bwrite>
  brelse(buf);
    80005f10:	fe043503          	ld	a0,-32(s0)
    80005f14:	fb0fe0ef          	jal	800046c4 <brelse>
}
    80005f18:	0001                	nop
    80005f1a:	70a2                	ld	ra,40(sp)
    80005f1c:	7402                	ld	s0,32(sp)
    80005f1e:	6145                	addi	sp,sp,48
    80005f20:	8082                	ret

0000000080005f22 <recover_from_log>:

static void
recover_from_log(void)
{
    80005f22:	1141                	addi	sp,sp,-16
    80005f24:	e406                	sd	ra,8(sp)
    80005f26:	e022                	sd	s0,0(sp)
    80005f28:	0800                	addi	s0,sp,16
  read_head();
    80005f2a:	eb5ff0ef          	jal	80005dde <read_head>
  install_trans(1); // if committed, copy from log to disk
    80005f2e:	4505                	li	a0,1
    80005f30:	da3ff0ef          	jal	80005cd2 <install_trans>
  log.lh.n = 0;
    80005f34:	0001d797          	auipc	a5,0x1d
    80005f38:	ae478793          	addi	a5,a5,-1308 # 80022a18 <log>
    80005f3c:	0207a423          	sw	zero,40(a5)
  write_head(); // clear the log
    80005f40:	f3dff0ef          	jal	80005e7c <write_head>
}
    80005f44:	0001                	nop
    80005f46:	60a2                	ld	ra,8(sp)
    80005f48:	6402                	ld	s0,0(sp)
    80005f4a:	0141                	addi	sp,sp,16
    80005f4c:	8082                	ret

0000000080005f4e <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80005f4e:	1141                	addi	sp,sp,-16
    80005f50:	e406                	sd	ra,8(sp)
    80005f52:	e022                	sd	s0,0(sp)
    80005f54:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80005f56:	0001d517          	auipc	a0,0x1d
    80005f5a:	ac250513          	addi	a0,a0,-1342 # 80022a18 <log>
    80005f5e:	becfb0ef          	jal	8000134a <acquire>
  while(1){
    if(log.committing){
    80005f62:	0001d797          	auipc	a5,0x1d
    80005f66:	ab678793          	addi	a5,a5,-1354 # 80022a18 <log>
    80005f6a:	539c                	lw	a5,32(a5)
    80005f6c:	cf81                	beqz	a5,80005f84 <begin_op+0x36>
      sleep(&log, &log.lock);
    80005f6e:	0001d597          	auipc	a1,0x1d
    80005f72:	aaa58593          	addi	a1,a1,-1366 # 80022a18 <log>
    80005f76:	0001d517          	auipc	a0,0x1d
    80005f7a:	aa250513          	addi	a0,a0,-1374 # 80022a18 <log>
    80005f7e:	b78fd0ef          	jal	800032f6 <sleep>
    80005f82:	b7c5                	j	80005f62 <begin_op+0x14>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    80005f84:	0001d797          	auipc	a5,0x1d
    80005f88:	a9478793          	addi	a5,a5,-1388 # 80022a18 <log>
    80005f8c:	5798                	lw	a4,40(a5)
    80005f8e:	0001d797          	auipc	a5,0x1d
    80005f92:	a8a78793          	addi	a5,a5,-1398 # 80022a18 <log>
    80005f96:	4fdc                	lw	a5,28(a5)
    80005f98:	2785                	addiw	a5,a5,1
    80005f9a:	2781                	sext.w	a5,a5
    80005f9c:	86be                	mv	a3,a5
    80005f9e:	87b6                	mv	a5,a3
    80005fa0:	0027979b          	slliw	a5,a5,0x2
    80005fa4:	9fb5                	addw	a5,a5,a3
    80005fa6:	0017979b          	slliw	a5,a5,0x1
    80005faa:	2781                	sext.w	a5,a5
    80005fac:	9fb9                	addw	a5,a5,a4
    80005fae:	0007871b          	sext.w	a4,a5
    80005fb2:	47f9                	li	a5,30
    80005fb4:	00e7dd63          	bge	a5,a4,80005fce <begin_op+0x80>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80005fb8:	0001d597          	auipc	a1,0x1d
    80005fbc:	a6058593          	addi	a1,a1,-1440 # 80022a18 <log>
    80005fc0:	0001d517          	auipc	a0,0x1d
    80005fc4:	a5850513          	addi	a0,a0,-1448 # 80022a18 <log>
    80005fc8:	b2efd0ef          	jal	800032f6 <sleep>
    80005fcc:	bf59                	j	80005f62 <begin_op+0x14>
    } else {
      log.outstanding += 1;
    80005fce:	0001d797          	auipc	a5,0x1d
    80005fd2:	a4a78793          	addi	a5,a5,-1462 # 80022a18 <log>
    80005fd6:	4fdc                	lw	a5,28(a5)
    80005fd8:	2785                	addiw	a5,a5,1
    80005fda:	0007871b          	sext.w	a4,a5
    80005fde:	0001d797          	auipc	a5,0x1d
    80005fe2:	a3a78793          	addi	a5,a5,-1478 # 80022a18 <log>
    80005fe6:	cfd8                	sw	a4,28(a5)
      release(&log.lock);
    80005fe8:	0001d517          	auipc	a0,0x1d
    80005fec:	a3050513          	addi	a0,a0,-1488 # 80022a18 <log>
    80005ff0:	baefb0ef          	jal	8000139e <release>
      break;
    80005ff4:	0001                	nop
    }
  }
}
    80005ff6:	0001                	nop
    80005ff8:	60a2                	ld	ra,8(sp)
    80005ffa:	6402                	ld	s0,0(sp)
    80005ffc:	0141                	addi	sp,sp,16
    80005ffe:	8082                	ret

0000000080006000 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80006000:	1101                	addi	sp,sp,-32
    80006002:	ec06                	sd	ra,24(sp)
    80006004:	e822                	sd	s0,16(sp)
    80006006:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80006008:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    8000600c:	0001d517          	auipc	a0,0x1d
    80006010:	a0c50513          	addi	a0,a0,-1524 # 80022a18 <log>
    80006014:	b36fb0ef          	jal	8000134a <acquire>
  log.outstanding -= 1;
    80006018:	0001d797          	auipc	a5,0x1d
    8000601c:	a0078793          	addi	a5,a5,-1536 # 80022a18 <log>
    80006020:	4fdc                	lw	a5,28(a5)
    80006022:	37fd                	addiw	a5,a5,-1
    80006024:	0007871b          	sext.w	a4,a5
    80006028:	0001d797          	auipc	a5,0x1d
    8000602c:	9f078793          	addi	a5,a5,-1552 # 80022a18 <log>
    80006030:	cfd8                	sw	a4,28(a5)
  if(log.committing)
    80006032:	0001d797          	auipc	a5,0x1d
    80006036:	9e678793          	addi	a5,a5,-1562 # 80022a18 <log>
    8000603a:	539c                	lw	a5,32(a5)
    8000603c:	c799                	beqz	a5,8000604a <end_op+0x4a>
    panic("log.committing");
    8000603e:	00004517          	auipc	a0,0x4
    80006042:	57a50513          	addi	a0,a0,1402 # 8000a5b8 <etext+0x5b8>
    80006046:	df1fa0ef          	jal	80000e36 <panic>
  if(log.outstanding == 0){
    8000604a:	0001d797          	auipc	a5,0x1d
    8000604e:	9ce78793          	addi	a5,a5,-1586 # 80022a18 <log>
    80006052:	4fdc                	lw	a5,28(a5)
    80006054:	eb99                	bnez	a5,8000606a <end_op+0x6a>
    do_commit = 1;
    80006056:	4785                	li	a5,1
    80006058:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    8000605c:	0001d797          	auipc	a5,0x1d
    80006060:	9bc78793          	addi	a5,a5,-1604 # 80022a18 <log>
    80006064:	4705                	li	a4,1
    80006066:	d398                	sw	a4,32(a5)
    80006068:	a039                	j	80006076 <end_op+0x76>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    8000606a:	0001d517          	auipc	a0,0x1d
    8000606e:	9ae50513          	addi	a0,a0,-1618 # 80022a18 <log>
    80006072:	ae8fd0ef          	jal	8000335a <wakeup>
  }
  release(&log.lock);
    80006076:	0001d517          	auipc	a0,0x1d
    8000607a:	9a250513          	addi	a0,a0,-1630 # 80022a18 <log>
    8000607e:	b20fb0ef          	jal	8000139e <release>

  if(do_commit){
    80006082:	fec42783          	lw	a5,-20(s0)
    80006086:	2781                	sext.w	a5,a5
    80006088:	cb9d                	beqz	a5,800060be <end_op+0xbe>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    8000608a:	104000ef          	jal	8000618e <commit>
    acquire(&log.lock);
    8000608e:	0001d517          	auipc	a0,0x1d
    80006092:	98a50513          	addi	a0,a0,-1654 # 80022a18 <log>
    80006096:	ab4fb0ef          	jal	8000134a <acquire>
    log.committing = 0;
    8000609a:	0001d797          	auipc	a5,0x1d
    8000609e:	97e78793          	addi	a5,a5,-1666 # 80022a18 <log>
    800060a2:	0207a023          	sw	zero,32(a5)
    wakeup(&log);
    800060a6:	0001d517          	auipc	a0,0x1d
    800060aa:	97250513          	addi	a0,a0,-1678 # 80022a18 <log>
    800060ae:	aacfd0ef          	jal	8000335a <wakeup>
    release(&log.lock);
    800060b2:	0001d517          	auipc	a0,0x1d
    800060b6:	96650513          	addi	a0,a0,-1690 # 80022a18 <log>
    800060ba:	ae4fb0ef          	jal	8000139e <release>
  }
}
    800060be:	0001                	nop
    800060c0:	60e2                	ld	ra,24(sp)
    800060c2:	6442                	ld	s0,16(sp)
    800060c4:	6105                	addi	sp,sp,32
    800060c6:	8082                	ret

00000000800060c8 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    800060c8:	7179                	addi	sp,sp,-48
    800060ca:	f406                	sd	ra,40(sp)
    800060cc:	f022                	sd	s0,32(sp)
    800060ce:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    800060d0:	fe042623          	sw	zero,-20(s0)
    800060d4:	a869                	j	8000616e <write_log+0xa6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800060d6:	0001d797          	auipc	a5,0x1d
    800060da:	94278793          	addi	a5,a5,-1726 # 80022a18 <log>
    800060de:	53dc                	lw	a5,36(a5)
    800060e0:	86be                	mv	a3,a5
    800060e2:	0001d797          	auipc	a5,0x1d
    800060e6:	93678793          	addi	a5,a5,-1738 # 80022a18 <log>
    800060ea:	4f9c                	lw	a5,24(a5)
    800060ec:	fec42703          	lw	a4,-20(s0)
    800060f0:	9fb9                	addw	a5,a5,a4
    800060f2:	2781                	sext.w	a5,a5
    800060f4:	2785                	addiw	a5,a5,1
    800060f6:	2781                	sext.w	a5,a5
    800060f8:	85be                	mv	a1,a5
    800060fa:	8536                	mv	a0,a3
    800060fc:	d3afe0ef          	jal	80004636 <bread>
    80006100:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80006104:	0001d797          	auipc	a5,0x1d
    80006108:	91478793          	addi	a5,a5,-1772 # 80022a18 <log>
    8000610c:	53dc                	lw	a5,36(a5)
    8000610e:	86be                	mv	a3,a5
    80006110:	0001d717          	auipc	a4,0x1d
    80006114:	90870713          	addi	a4,a4,-1784 # 80022a18 <log>
    80006118:	fec42783          	lw	a5,-20(s0)
    8000611c:	07a1                	addi	a5,a5,8
    8000611e:	078a                	slli	a5,a5,0x2
    80006120:	97ba                	add	a5,a5,a4
    80006122:	47dc                	lw	a5,12(a5)
    80006124:	85be                	mv	a1,a5
    80006126:	8536                	mv	a0,a3
    80006128:	d0efe0ef          	jal	80004636 <bread>
    8000612c:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80006130:	fe043783          	ld	a5,-32(s0)
    80006134:	05878713          	addi	a4,a5,88
    80006138:	fd843783          	ld	a5,-40(s0)
    8000613c:	05878793          	addi	a5,a5,88
    80006140:	40000613          	li	a2,1024
    80006144:	85be                	mv	a1,a5
    80006146:	853a                	mv	a0,a4
    80006148:	c7afb0ef          	jal	800015c2 <memmove>
    bwrite(to);  // write the log
    8000614c:	fe043503          	ld	a0,-32(s0)
    80006150:	d38fe0ef          	jal	80004688 <bwrite>
    brelse(from);
    80006154:	fd843503          	ld	a0,-40(s0)
    80006158:	d6cfe0ef          	jal	800046c4 <brelse>
    brelse(to);
    8000615c:	fe043503          	ld	a0,-32(s0)
    80006160:	d64fe0ef          	jal	800046c4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006164:	fec42783          	lw	a5,-20(s0)
    80006168:	2785                	addiw	a5,a5,1
    8000616a:	fef42623          	sw	a5,-20(s0)
    8000616e:	0001d797          	auipc	a5,0x1d
    80006172:	8aa78793          	addi	a5,a5,-1878 # 80022a18 <log>
    80006176:	579c                	lw	a5,40(a5)
    80006178:	fec42703          	lw	a4,-20(s0)
    8000617c:	2701                	sext.w	a4,a4
    8000617e:	f4f74ce3          	blt	a4,a5,800060d6 <write_log+0xe>
  }
}
    80006182:	0001                	nop
    80006184:	0001                	nop
    80006186:	70a2                	ld	ra,40(sp)
    80006188:	7402                	ld	s0,32(sp)
    8000618a:	6145                	addi	sp,sp,48
    8000618c:	8082                	ret

000000008000618e <commit>:

static void
commit()
{
    8000618e:	1141                	addi	sp,sp,-16
    80006190:	e406                	sd	ra,8(sp)
    80006192:	e022                	sd	s0,0(sp)
    80006194:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006196:	0001d797          	auipc	a5,0x1d
    8000619a:	88278793          	addi	a5,a5,-1918 # 80022a18 <log>
    8000619e:	579c                	lw	a5,40(a5)
    800061a0:	02f05163          	blez	a5,800061c2 <commit+0x34>
    write_log();     // Write modified blocks from cache to log
    800061a4:	f25ff0ef          	jal	800060c8 <write_log>
    write_head();    // Write header to disk -- the real commit
    800061a8:	cd5ff0ef          	jal	80005e7c <write_head>
    install_trans(0); // Now install writes to home locations
    800061ac:	4501                	li	a0,0
    800061ae:	b25ff0ef          	jal	80005cd2 <install_trans>
    log.lh.n = 0;
    800061b2:	0001d797          	auipc	a5,0x1d
    800061b6:	86678793          	addi	a5,a5,-1946 # 80022a18 <log>
    800061ba:	0207a423          	sw	zero,40(a5)
    write_head();    // Erase the transaction from the log
    800061be:	cbfff0ef          	jal	80005e7c <write_head>
  }
}
    800061c2:	0001                	nop
    800061c4:	60a2                	ld	ra,8(sp)
    800061c6:	6402                	ld	s0,0(sp)
    800061c8:	0141                	addi	sp,sp,16
    800061ca:	8082                	ret

00000000800061cc <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800061cc:	7179                	addi	sp,sp,-48
    800061ce:	f406                	sd	ra,40(sp)
    800061d0:	f022                	sd	s0,32(sp)
    800061d2:	1800                	addi	s0,sp,48
    800061d4:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    800061d8:	0001d517          	auipc	a0,0x1d
    800061dc:	84050513          	addi	a0,a0,-1984 # 80022a18 <log>
    800061e0:	96afb0ef          	jal	8000134a <acquire>
  if (log.lh.n >= LOGBLOCKS)
    800061e4:	0001d797          	auipc	a5,0x1d
    800061e8:	83478793          	addi	a5,a5,-1996 # 80022a18 <log>
    800061ec:	5798                	lw	a4,40(a5)
    800061ee:	47f5                	li	a5,29
    800061f0:	00e7d863          	bge	a5,a4,80006200 <log_write+0x34>
    panic("too big a transaction");
    800061f4:	00004517          	auipc	a0,0x4
    800061f8:	3d450513          	addi	a0,a0,980 # 8000a5c8 <etext+0x5c8>
    800061fc:	c3bfa0ef          	jal	80000e36 <panic>
  if (log.outstanding < 1)
    80006200:	0001d797          	auipc	a5,0x1d
    80006204:	81878793          	addi	a5,a5,-2024 # 80022a18 <log>
    80006208:	4fdc                	lw	a5,28(a5)
    8000620a:	00f04863          	bgtz	a5,8000621a <log_write+0x4e>
    panic("log_write outside of trans");
    8000620e:	00004517          	auipc	a0,0x4
    80006212:	3d250513          	addi	a0,a0,978 # 8000a5e0 <etext+0x5e0>
    80006216:	c21fa0ef          	jal	80000e36 <panic>

  for (i = 0; i < log.lh.n; i++) {
    8000621a:	fe042623          	sw	zero,-20(s0)
    8000621e:	a035                	j	8000624a <log_write+0x7e>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80006220:	0001c717          	auipc	a4,0x1c
    80006224:	7f870713          	addi	a4,a4,2040 # 80022a18 <log>
    80006228:	fec42783          	lw	a5,-20(s0)
    8000622c:	07a1                	addi	a5,a5,8
    8000622e:	078a                	slli	a5,a5,0x2
    80006230:	97ba                	add	a5,a5,a4
    80006232:	47dc                	lw	a5,12(a5)
    80006234:	873e                	mv	a4,a5
    80006236:	fd843783          	ld	a5,-40(s0)
    8000623a:	47dc                	lw	a5,12(a5)
    8000623c:	02f70263          	beq	a4,a5,80006260 <log_write+0x94>
  for (i = 0; i < log.lh.n; i++) {
    80006240:	fec42783          	lw	a5,-20(s0)
    80006244:	2785                	addiw	a5,a5,1
    80006246:	fef42623          	sw	a5,-20(s0)
    8000624a:	0001c797          	auipc	a5,0x1c
    8000624e:	7ce78793          	addi	a5,a5,1998 # 80022a18 <log>
    80006252:	579c                	lw	a5,40(a5)
    80006254:	fec42703          	lw	a4,-20(s0)
    80006258:	2701                	sext.w	a4,a4
    8000625a:	fcf743e3          	blt	a4,a5,80006220 <log_write+0x54>
    8000625e:	a011                	j	80006262 <log_write+0x96>
      break;
    80006260:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006262:	fd843783          	ld	a5,-40(s0)
    80006266:	47dc                	lw	a5,12(a5)
    80006268:	86be                	mv	a3,a5
    8000626a:	0001c717          	auipc	a4,0x1c
    8000626e:	7ae70713          	addi	a4,a4,1966 # 80022a18 <log>
    80006272:	fec42783          	lw	a5,-20(s0)
    80006276:	07a1                	addi	a5,a5,8
    80006278:	078a                	slli	a5,a5,0x2
    8000627a:	97ba                	add	a5,a5,a4
    8000627c:	c7d4                	sw	a3,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    8000627e:	0001c797          	auipc	a5,0x1c
    80006282:	79a78793          	addi	a5,a5,1946 # 80022a18 <log>
    80006286:	579c                	lw	a5,40(a5)
    80006288:	fec42703          	lw	a4,-20(s0)
    8000628c:	2701                	sext.w	a4,a4
    8000628e:	02f71363          	bne	a4,a5,800062b4 <log_write+0xe8>
    bpin(b);
    80006292:	fd843503          	ld	a0,-40(s0)
    80006296:	d08fe0ef          	jal	8000479e <bpin>
    log.lh.n++;
    8000629a:	0001c797          	auipc	a5,0x1c
    8000629e:	77e78793          	addi	a5,a5,1918 # 80022a18 <log>
    800062a2:	579c                	lw	a5,40(a5)
    800062a4:	2785                	addiw	a5,a5,1
    800062a6:	0007871b          	sext.w	a4,a5
    800062aa:	0001c797          	auipc	a5,0x1c
    800062ae:	76e78793          	addi	a5,a5,1902 # 80022a18 <log>
    800062b2:	d798                	sw	a4,40(a5)
  }
  release(&log.lock);
    800062b4:	0001c517          	auipc	a0,0x1c
    800062b8:	76450513          	addi	a0,a0,1892 # 80022a18 <log>
    800062bc:	8e2fb0ef          	jal	8000139e <release>
}
    800062c0:	0001                	nop
    800062c2:	70a2                	ld	ra,40(sp)
    800062c4:	7402                	ld	s0,32(sp)
    800062c6:	6145                	addi	sp,sp,48
    800062c8:	8082                	ret

00000000800062ca <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800062ca:	1101                	addi	sp,sp,-32
    800062cc:	ec06                	sd	ra,24(sp)
    800062ce:	e822                	sd	s0,16(sp)
    800062d0:	1000                	addi	s0,sp,32
    800062d2:	fea43423          	sd	a0,-24(s0)
    800062d6:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    800062da:	fe843783          	ld	a5,-24(s0)
    800062de:	07a1                	addi	a5,a5,8
    800062e0:	00004597          	auipc	a1,0x4
    800062e4:	32058593          	addi	a1,a1,800 # 8000a600 <etext+0x600>
    800062e8:	853e                	mv	a0,a5
    800062ea:	82cfb0ef          	jal	80001316 <initlock>
  lk->name = name;
    800062ee:	fe843783          	ld	a5,-24(s0)
    800062f2:	fe043703          	ld	a4,-32(s0)
    800062f6:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    800062f8:	fe843783          	ld	a5,-24(s0)
    800062fc:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006300:	fe843783          	ld	a5,-24(s0)
    80006304:	0207a423          	sw	zero,40(a5)
}
    80006308:	0001                	nop
    8000630a:	60e2                	ld	ra,24(sp)
    8000630c:	6442                	ld	s0,16(sp)
    8000630e:	6105                	addi	sp,sp,32
    80006310:	8082                	ret

0000000080006312 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80006312:	1101                	addi	sp,sp,-32
    80006314:	ec06                	sd	ra,24(sp)
    80006316:	e822                	sd	s0,16(sp)
    80006318:	1000                	addi	s0,sp,32
    8000631a:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    8000631e:	fe843783          	ld	a5,-24(s0)
    80006322:	07a1                	addi	a5,a5,8
    80006324:	853e                	mv	a0,a5
    80006326:	824fb0ef          	jal	8000134a <acquire>
  while (lk->locked) {
    8000632a:	a809                	j	8000633c <acquiresleep+0x2a>
    sleep(lk, &lk->lk);
    8000632c:	fe843783          	ld	a5,-24(s0)
    80006330:	07a1                	addi	a5,a5,8
    80006332:	85be                	mv	a1,a5
    80006334:	fe843503          	ld	a0,-24(s0)
    80006338:	fbffc0ef          	jal	800032f6 <sleep>
  while (lk->locked) {
    8000633c:	fe843783          	ld	a5,-24(s0)
    80006340:	439c                	lw	a5,0(a5)
    80006342:	f7ed                	bnez	a5,8000632c <acquiresleep+0x1a>
  }
  lk->locked = 1;
    80006344:	fe843783          	ld	a5,-24(s0)
    80006348:	4705                	li	a4,1
    8000634a:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    8000634c:	d08fc0ef          	jal	80002854 <myproc>
    80006350:	87aa                	mv	a5,a0
    80006352:	5b98                	lw	a4,48(a5)
    80006354:	fe843783          	ld	a5,-24(s0)
    80006358:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000635a:	fe843783          	ld	a5,-24(s0)
    8000635e:	07a1                	addi	a5,a5,8
    80006360:	853e                	mv	a0,a5
    80006362:	83cfb0ef          	jal	8000139e <release>
}
    80006366:	0001                	nop
    80006368:	60e2                	ld	ra,24(sp)
    8000636a:	6442                	ld	s0,16(sp)
    8000636c:	6105                	addi	sp,sp,32
    8000636e:	8082                	ret

0000000080006370 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80006370:	1101                	addi	sp,sp,-32
    80006372:	ec06                	sd	ra,24(sp)
    80006374:	e822                	sd	s0,16(sp)
    80006376:	1000                	addi	s0,sp,32
    80006378:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    8000637c:	fe843783          	ld	a5,-24(s0)
    80006380:	07a1                	addi	a5,a5,8
    80006382:	853e                	mv	a0,a5
    80006384:	fc7fa0ef          	jal	8000134a <acquire>
  lk->locked = 0;
    80006388:	fe843783          	ld	a5,-24(s0)
    8000638c:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006390:	fe843783          	ld	a5,-24(s0)
    80006394:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    80006398:	fe843503          	ld	a0,-24(s0)
    8000639c:	fbffc0ef          	jal	8000335a <wakeup>
  release(&lk->lk);
    800063a0:	fe843783          	ld	a5,-24(s0)
    800063a4:	07a1                	addi	a5,a5,8
    800063a6:	853e                	mv	a0,a5
    800063a8:	ff7fa0ef          	jal	8000139e <release>
}
    800063ac:	0001                	nop
    800063ae:	60e2                	ld	ra,24(sp)
    800063b0:	6442                	ld	s0,16(sp)
    800063b2:	6105                	addi	sp,sp,32
    800063b4:	8082                	ret

00000000800063b6 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800063b6:	7139                	addi	sp,sp,-64
    800063b8:	fc06                	sd	ra,56(sp)
    800063ba:	f822                	sd	s0,48(sp)
    800063bc:	f426                	sd	s1,40(sp)
    800063be:	0080                	addi	s0,sp,64
    800063c0:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    800063c4:	fc843783          	ld	a5,-56(s0)
    800063c8:	07a1                	addi	a5,a5,8
    800063ca:	853e                	mv	a0,a5
    800063cc:	f7ffa0ef          	jal	8000134a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800063d0:	fc843783          	ld	a5,-56(s0)
    800063d4:	439c                	lw	a5,0(a5)
    800063d6:	cf81                	beqz	a5,800063ee <holdingsleep+0x38>
    800063d8:	fc843783          	ld	a5,-56(s0)
    800063dc:	5784                	lw	s1,40(a5)
    800063de:	c76fc0ef          	jal	80002854 <myproc>
    800063e2:	87aa                	mv	a5,a0
    800063e4:	5b9c                	lw	a5,48(a5)
    800063e6:	00f49463          	bne	s1,a5,800063ee <holdingsleep+0x38>
    800063ea:	4785                	li	a5,1
    800063ec:	a011                	j	800063f0 <holdingsleep+0x3a>
    800063ee:	4781                	li	a5,0
    800063f0:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    800063f4:	fc843783          	ld	a5,-56(s0)
    800063f8:	07a1                	addi	a5,a5,8
    800063fa:	853e                	mv	a0,a5
    800063fc:	fa3fa0ef          	jal	8000139e <release>
  return r;
    80006400:	fdc42783          	lw	a5,-36(s0)
}
    80006404:	853e                	mv	a0,a5
    80006406:	70e2                	ld	ra,56(sp)
    80006408:	7442                	ld	s0,48(sp)
    8000640a:	74a2                	ld	s1,40(sp)
    8000640c:	6121                	addi	sp,sp,64
    8000640e:	8082                	ret

0000000080006410 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80006410:	1141                	addi	sp,sp,-16
    80006412:	e406                	sd	ra,8(sp)
    80006414:	e022                	sd	s0,0(sp)
    80006416:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006418:	00004597          	auipc	a1,0x4
    8000641c:	1f858593          	addi	a1,a1,504 # 8000a610 <etext+0x610>
    80006420:	0001c517          	auipc	a0,0x1c
    80006424:	74050513          	addi	a0,a0,1856 # 80022b60 <ftable>
    80006428:	eeffa0ef          	jal	80001316 <initlock>
}
    8000642c:	0001                	nop
    8000642e:	60a2                	ld	ra,8(sp)
    80006430:	6402                	ld	s0,0(sp)
    80006432:	0141                	addi	sp,sp,16
    80006434:	8082                	ret

0000000080006436 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006436:	1101                	addi	sp,sp,-32
    80006438:	ec06                	sd	ra,24(sp)
    8000643a:	e822                	sd	s0,16(sp)
    8000643c:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000643e:	0001c517          	auipc	a0,0x1c
    80006442:	72250513          	addi	a0,a0,1826 # 80022b60 <ftable>
    80006446:	f05fa0ef          	jal	8000134a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000644a:	0001c797          	auipc	a5,0x1c
    8000644e:	72e78793          	addi	a5,a5,1838 # 80022b78 <ftable+0x18>
    80006452:	fef43423          	sd	a5,-24(s0)
    80006456:	a805                	j	80006486 <filealloc+0x50>
    if(f->ref == 0){
    80006458:	fe843783          	ld	a5,-24(s0)
    8000645c:	43dc                	lw	a5,4(a5)
    8000645e:	ef91                	bnez	a5,8000647a <filealloc+0x44>
      f->ref = 1;
    80006460:	fe843783          	ld	a5,-24(s0)
    80006464:	4705                	li	a4,1
    80006466:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    80006468:	0001c517          	auipc	a0,0x1c
    8000646c:	6f850513          	addi	a0,a0,1784 # 80022b60 <ftable>
    80006470:	f2ffa0ef          	jal	8000139e <release>
      return f;
    80006474:	fe843783          	ld	a5,-24(s0)
    80006478:	a035                	j	800064a4 <filealloc+0x6e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000647a:	fe843783          	ld	a5,-24(s0)
    8000647e:	02878793          	addi	a5,a5,40
    80006482:	fef43423          	sd	a5,-24(s0)
    80006486:	0001d797          	auipc	a5,0x1d
    8000648a:	69278793          	addi	a5,a5,1682 # 80023b18 <disk>
    8000648e:	fe843703          	ld	a4,-24(s0)
    80006492:	fcf763e3          	bltu	a4,a5,80006458 <filealloc+0x22>
    }
  }
  release(&ftable.lock);
    80006496:	0001c517          	auipc	a0,0x1c
    8000649a:	6ca50513          	addi	a0,a0,1738 # 80022b60 <ftable>
    8000649e:	f01fa0ef          	jal	8000139e <release>
  return 0;
    800064a2:	4781                	li	a5,0
}
    800064a4:	853e                	mv	a0,a5
    800064a6:	60e2                	ld	ra,24(sp)
    800064a8:	6442                	ld	s0,16(sp)
    800064aa:	6105                	addi	sp,sp,32
    800064ac:	8082                	ret

00000000800064ae <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800064ae:	1101                	addi	sp,sp,-32
    800064b0:	ec06                	sd	ra,24(sp)
    800064b2:	e822                	sd	s0,16(sp)
    800064b4:	1000                	addi	s0,sp,32
    800064b6:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    800064ba:	0001c517          	auipc	a0,0x1c
    800064be:	6a650513          	addi	a0,a0,1702 # 80022b60 <ftable>
    800064c2:	e89fa0ef          	jal	8000134a <acquire>
  if(f->ref < 1)
    800064c6:	fe843783          	ld	a5,-24(s0)
    800064ca:	43dc                	lw	a5,4(a5)
    800064cc:	00f04863          	bgtz	a5,800064dc <filedup+0x2e>
    panic("filedup");
    800064d0:	00004517          	auipc	a0,0x4
    800064d4:	14850513          	addi	a0,a0,328 # 8000a618 <etext+0x618>
    800064d8:	95ffa0ef          	jal	80000e36 <panic>
  f->ref++;
    800064dc:	fe843783          	ld	a5,-24(s0)
    800064e0:	43dc                	lw	a5,4(a5)
    800064e2:	2785                	addiw	a5,a5,1
    800064e4:	0007871b          	sext.w	a4,a5
    800064e8:	fe843783          	ld	a5,-24(s0)
    800064ec:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    800064ee:	0001c517          	auipc	a0,0x1c
    800064f2:	67250513          	addi	a0,a0,1650 # 80022b60 <ftable>
    800064f6:	ea9fa0ef          	jal	8000139e <release>
  return f;
    800064fa:	fe843783          	ld	a5,-24(s0)
}
    800064fe:	853e                	mv	a0,a5
    80006500:	60e2                	ld	ra,24(sp)
    80006502:	6442                	ld	s0,16(sp)
    80006504:	6105                	addi	sp,sp,32
    80006506:	8082                	ret

0000000080006508 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006508:	715d                	addi	sp,sp,-80
    8000650a:	e486                	sd	ra,72(sp)
    8000650c:	e0a2                	sd	s0,64(sp)
    8000650e:	0880                	addi	s0,sp,80
    80006510:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006514:	0001c517          	auipc	a0,0x1c
    80006518:	64c50513          	addi	a0,a0,1612 # 80022b60 <ftable>
    8000651c:	e2ffa0ef          	jal	8000134a <acquire>
  if(f->ref < 1)
    80006520:	fb843783          	ld	a5,-72(s0)
    80006524:	43dc                	lw	a5,4(a5)
    80006526:	00f04863          	bgtz	a5,80006536 <fileclose+0x2e>
    panic("fileclose");
    8000652a:	00004517          	auipc	a0,0x4
    8000652e:	0f650513          	addi	a0,a0,246 # 8000a620 <etext+0x620>
    80006532:	905fa0ef          	jal	80000e36 <panic>
  if(--f->ref > 0){
    80006536:	fb843783          	ld	a5,-72(s0)
    8000653a:	43dc                	lw	a5,4(a5)
    8000653c:	37fd                	addiw	a5,a5,-1
    8000653e:	0007871b          	sext.w	a4,a5
    80006542:	fb843783          	ld	a5,-72(s0)
    80006546:	c3d8                	sw	a4,4(a5)
    80006548:	fb843783          	ld	a5,-72(s0)
    8000654c:	43dc                	lw	a5,4(a5)
    8000654e:	00f05963          	blez	a5,80006560 <fileclose+0x58>
    release(&ftable.lock);
    80006552:	0001c517          	auipc	a0,0x1c
    80006556:	60e50513          	addi	a0,a0,1550 # 80022b60 <ftable>
    8000655a:	e45fa0ef          	jal	8000139e <release>
    8000655e:	a051                	j	800065e2 <fileclose+0xda>
    return;
  }
  ff = *f;
    80006560:	fb843783          	ld	a5,-72(s0)
    80006564:	638c                	ld	a1,0(a5)
    80006566:	6790                	ld	a2,8(a5)
    80006568:	6b94                	ld	a3,16(a5)
    8000656a:	6f98                	ld	a4,24(a5)
    8000656c:	739c                	ld	a5,32(a5)
    8000656e:	fcb43423          	sd	a1,-56(s0)
    80006572:	fcc43823          	sd	a2,-48(s0)
    80006576:	fcd43c23          	sd	a3,-40(s0)
    8000657a:	fee43023          	sd	a4,-32(s0)
    8000657e:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006582:	fb843783          	ld	a5,-72(s0)
    80006586:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    8000658a:	fb843783          	ld	a5,-72(s0)
    8000658e:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006592:	0001c517          	auipc	a0,0x1c
    80006596:	5ce50513          	addi	a0,a0,1486 # 80022b60 <ftable>
    8000659a:	e05fa0ef          	jal	8000139e <release>

  if(ff.type == FD_PIPE){
    8000659e:	fc842703          	lw	a4,-56(s0)
    800065a2:	4785                	li	a5,1
    800065a4:	00f71c63          	bne	a4,a5,800065bc <fileclose+0xb4>
    pipeclose(ff.pipe, ff.writable);
    800065a8:	fd843783          	ld	a5,-40(s0)
    800065ac:	fd144703          	lbu	a4,-47(s0)
    800065b0:	2701                	sext.w	a4,a4
    800065b2:	85ba                	mv	a1,a4
    800065b4:	853e                	mv	a0,a5
    800065b6:	51e000ef          	jal	80006ad4 <pipeclose>
    800065ba:	a025                	j	800065e2 <fileclose+0xda>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800065bc:	fc842703          	lw	a4,-56(s0)
    800065c0:	4789                	li	a5,2
    800065c2:	00f70763          	beq	a4,a5,800065d0 <fileclose+0xc8>
    800065c6:	fc842703          	lw	a4,-56(s0)
    800065ca:	478d                	li	a5,3
    800065cc:	00f71b63          	bne	a4,a5,800065e2 <fileclose+0xda>
    begin_op();
    800065d0:	97fff0ef          	jal	80005f4e <begin_op>
    iput(ff.ip);
    800065d4:	fe043783          	ld	a5,-32(s0)
    800065d8:	853e                	mv	a0,a5
    800065da:	ac9fe0ef          	jal	800050a2 <iput>
    end_op();
    800065de:	a23ff0ef          	jal	80006000 <end_op>
  }
}
    800065e2:	60a6                	ld	ra,72(sp)
    800065e4:	6406                	ld	s0,64(sp)
    800065e6:	6161                	addi	sp,sp,80
    800065e8:	8082                	ret

00000000800065ea <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800065ea:	7139                	addi	sp,sp,-64
    800065ec:	fc06                	sd	ra,56(sp)
    800065ee:	f822                	sd	s0,48(sp)
    800065f0:	0080                	addi	s0,sp,64
    800065f2:	fca43423          	sd	a0,-56(s0)
    800065f6:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    800065fa:	a5afc0ef          	jal	80002854 <myproc>
    800065fe:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006602:	fc843783          	ld	a5,-56(s0)
    80006606:	4398                	lw	a4,0(a5)
    80006608:	4789                	li	a5,2
    8000660a:	00f70863          	beq	a4,a5,8000661a <filestat+0x30>
    8000660e:	fc843783          	ld	a5,-56(s0)
    80006612:	4398                	lw	a4,0(a5)
    80006614:	478d                	li	a5,3
    80006616:	04f71a63          	bne	a4,a5,8000666a <filestat+0x80>
    ilock(f->ip);
    8000661a:	fc843783          	ld	a5,-56(s0)
    8000661e:	6f9c                	ld	a5,24(a5)
    80006620:	853e                	mv	a0,a5
    80006622:	917fe0ef          	jal	80004f38 <ilock>
    stati(f->ip, &st);
    80006626:	fc843783          	ld	a5,-56(s0)
    8000662a:	6f9c                	ld	a5,24(a5)
    8000662c:	fd040713          	addi	a4,s0,-48
    80006630:	85ba                	mv	a1,a4
    80006632:	853e                	mv	a0,a5
    80006634:	eb5fe0ef          	jal	800054e8 <stati>
    iunlock(f->ip);
    80006638:	fc843783          	ld	a5,-56(s0)
    8000663c:	6f9c                	ld	a5,24(a5)
    8000663e:	853e                	mv	a0,a5
    80006640:	a15fe0ef          	jal	80005054 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80006644:	fe843783          	ld	a5,-24(s0)
    80006648:	6bbc                	ld	a5,80(a5)
    8000664a:	fd040713          	addi	a4,s0,-48
    8000664e:	46e1                	li	a3,24
    80006650:	863a                	mv	a2,a4
    80006652:	fc043583          	ld	a1,-64(s0)
    80006656:	853e                	mv	a0,a5
    80006658:	b8bfb0ef          	jal	800021e2 <copyout>
    8000665c:	87aa                	mv	a5,a0
    8000665e:	0007d463          	bgez	a5,80006666 <filestat+0x7c>
      return -1;
    80006662:	57fd                	li	a5,-1
    80006664:	a021                	j	8000666c <filestat+0x82>
    return 0;
    80006666:	4781                	li	a5,0
    80006668:	a011                	j	8000666c <filestat+0x82>
  }
  return -1;
    8000666a:	57fd                	li	a5,-1
}
    8000666c:	853e                	mv	a0,a5
    8000666e:	70e2                	ld	ra,56(sp)
    80006670:	7442                	ld	s0,48(sp)
    80006672:	6121                	addi	sp,sp,64
    80006674:	8082                	ret

0000000080006676 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80006676:	7139                	addi	sp,sp,-64
    80006678:	fc06                	sd	ra,56(sp)
    8000667a:	f822                	sd	s0,48(sp)
    8000667c:	0080                	addi	s0,sp,64
    8000667e:	fca43c23          	sd	a0,-40(s0)
    80006682:	fcb43823          	sd	a1,-48(s0)
    80006686:	87b2                	mv	a5,a2
    80006688:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    8000668c:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80006690:	fd843783          	ld	a5,-40(s0)
    80006694:	0087c783          	lbu	a5,8(a5)
    80006698:	e399                	bnez	a5,8000669e <fileread+0x28>
    return -1;
    8000669a:	57fd                	li	a5,-1
    8000669c:	aa09                	j	800067ae <fileread+0x138>

  if(f->type == FD_PIPE){
    8000669e:	fd843783          	ld	a5,-40(s0)
    800066a2:	4398                	lw	a4,0(a5)
    800066a4:	4785                	li	a5,1
    800066a6:	02f71163          	bne	a4,a5,800066c8 <fileread+0x52>
    r = piperead(f->pipe, addr, n);
    800066aa:	fd843783          	ld	a5,-40(s0)
    800066ae:	6b9c                	ld	a5,16(a5)
    800066b0:	fcc42703          	lw	a4,-52(s0)
    800066b4:	863a                	mv	a2,a4
    800066b6:	fd043583          	ld	a1,-48(s0)
    800066ba:	853e                	mv	a0,a5
    800066bc:	5d6000ef          	jal	80006c92 <piperead>
    800066c0:	87aa                	mv	a5,a0
    800066c2:	fef42623          	sw	a5,-20(s0)
    800066c6:	a0d5                	j	800067aa <fileread+0x134>
  } else if(f->type == FD_DEVICE){
    800066c8:	fd843783          	ld	a5,-40(s0)
    800066cc:	4398                	lw	a4,0(a5)
    800066ce:	478d                	li	a5,3
    800066d0:	06f71363          	bne	a4,a5,80006736 <fileread+0xc0>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800066d4:	fd843783          	ld	a5,-40(s0)
    800066d8:	02479783          	lh	a5,36(a5)
    800066dc:	0207c563          	bltz	a5,80006706 <fileread+0x90>
    800066e0:	fd843783          	ld	a5,-40(s0)
    800066e4:	02479703          	lh	a4,36(a5)
    800066e8:	47a5                	li	a5,9
    800066ea:	00e7ce63          	blt	a5,a4,80006706 <fileread+0x90>
    800066ee:	fd843783          	ld	a5,-40(s0)
    800066f2:	02479783          	lh	a5,36(a5)
    800066f6:	0001c717          	auipc	a4,0x1c
    800066fa:	3ca70713          	addi	a4,a4,970 # 80022ac0 <devsw>
    800066fe:	0792                	slli	a5,a5,0x4
    80006700:	97ba                	add	a5,a5,a4
    80006702:	639c                	ld	a5,0(a5)
    80006704:	e399                	bnez	a5,8000670a <fileread+0x94>
      return -1;
    80006706:	57fd                	li	a5,-1
    80006708:	a05d                	j	800067ae <fileread+0x138>
    r = devsw[f->major].read(1, addr, n);
    8000670a:	fd843783          	ld	a5,-40(s0)
    8000670e:	02479783          	lh	a5,36(a5)
    80006712:	0001c717          	auipc	a4,0x1c
    80006716:	3ae70713          	addi	a4,a4,942 # 80022ac0 <devsw>
    8000671a:	0792                	slli	a5,a5,0x4
    8000671c:	97ba                	add	a5,a5,a4
    8000671e:	639c                	ld	a5,0(a5)
    80006720:	fcc42703          	lw	a4,-52(s0)
    80006724:	863a                	mv	a2,a4
    80006726:	fd043583          	ld	a1,-48(s0)
    8000672a:	4505                	li	a0,1
    8000672c:	9782                	jalr	a5
    8000672e:	87aa                	mv	a5,a0
    80006730:	fef42623          	sw	a5,-20(s0)
    80006734:	a89d                	j	800067aa <fileread+0x134>
  } else if(f->type == FD_INODE){
    80006736:	fd843783          	ld	a5,-40(s0)
    8000673a:	4398                	lw	a4,0(a5)
    8000673c:	4789                	li	a5,2
    8000673e:	06f71063          	bne	a4,a5,8000679e <fileread+0x128>
    ilock(f->ip);
    80006742:	fd843783          	ld	a5,-40(s0)
    80006746:	6f9c                	ld	a5,24(a5)
    80006748:	853e                	mv	a0,a5
    8000674a:	feefe0ef          	jal	80004f38 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000674e:	fd843783          	ld	a5,-40(s0)
    80006752:	6f88                	ld	a0,24(a5)
    80006754:	fd843783          	ld	a5,-40(s0)
    80006758:	539c                	lw	a5,32(a5)
    8000675a:	fcc42703          	lw	a4,-52(s0)
    8000675e:	86be                	mv	a3,a5
    80006760:	fd043603          	ld	a2,-48(s0)
    80006764:	4585                	li	a1,1
    80006766:	de9fe0ef          	jal	8000554e <readi>
    8000676a:	87aa                	mv	a5,a0
    8000676c:	fef42623          	sw	a5,-20(s0)
    80006770:	fec42783          	lw	a5,-20(s0)
    80006774:	2781                	sext.w	a5,a5
    80006776:	00f05d63          	blez	a5,80006790 <fileread+0x11a>
      f->off += r;
    8000677a:	fd843783          	ld	a5,-40(s0)
    8000677e:	5398                	lw	a4,32(a5)
    80006780:	fec42783          	lw	a5,-20(s0)
    80006784:	9fb9                	addw	a5,a5,a4
    80006786:	0007871b          	sext.w	a4,a5
    8000678a:	fd843783          	ld	a5,-40(s0)
    8000678e:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80006790:	fd843783          	ld	a5,-40(s0)
    80006794:	6f9c                	ld	a5,24(a5)
    80006796:	853e                	mv	a0,a5
    80006798:	8bdfe0ef          	jal	80005054 <iunlock>
    8000679c:	a039                	j	800067aa <fileread+0x134>
  } else {
    panic("fileread");
    8000679e:	00004517          	auipc	a0,0x4
    800067a2:	e9250513          	addi	a0,a0,-366 # 8000a630 <etext+0x630>
    800067a6:	e90fa0ef          	jal	80000e36 <panic>
  }

  return r;
    800067aa:	fec42783          	lw	a5,-20(s0)
}
    800067ae:	853e                	mv	a0,a5
    800067b0:	70e2                	ld	ra,56(sp)
    800067b2:	7442                	ld	s0,48(sp)
    800067b4:	6121                	addi	sp,sp,64
    800067b6:	8082                	ret

00000000800067b8 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800067b8:	715d                	addi	sp,sp,-80
    800067ba:	e486                	sd	ra,72(sp)
    800067bc:	e0a2                	sd	s0,64(sp)
    800067be:	0880                	addi	s0,sp,80
    800067c0:	fca43423          	sd	a0,-56(s0)
    800067c4:	fcb43023          	sd	a1,-64(s0)
    800067c8:	87b2                	mv	a5,a2
    800067ca:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    800067ce:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    800067d2:	fc843783          	ld	a5,-56(s0)
    800067d6:	0097c783          	lbu	a5,9(a5)
    800067da:	e399                	bnez	a5,800067e0 <filewrite+0x28>
    return -1;
    800067dc:	57fd                	li	a5,-1
    800067de:	aa55                	j	80006992 <filewrite+0x1da>

  if(f->type == FD_PIPE){
    800067e0:	fc843783          	ld	a5,-56(s0)
    800067e4:	4398                	lw	a4,0(a5)
    800067e6:	4785                	li	a5,1
    800067e8:	02f71163          	bne	a4,a5,8000680a <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
    800067ec:	fc843783          	ld	a5,-56(s0)
    800067f0:	6b9c                	ld	a5,16(a5)
    800067f2:	fbc42703          	lw	a4,-68(s0)
    800067f6:	863a                	mv	a2,a4
    800067f8:	fc043583          	ld	a1,-64(s0)
    800067fc:	853e                	mv	a0,a5
    800067fe:	366000ef          	jal	80006b64 <pipewrite>
    80006802:	87aa                	mv	a5,a0
    80006804:	fef42623          	sw	a5,-20(s0)
    80006808:	a259                	j	8000698e <filewrite+0x1d6>
  } else if(f->type == FD_DEVICE){
    8000680a:	fc843783          	ld	a5,-56(s0)
    8000680e:	4398                	lw	a4,0(a5)
    80006810:	478d                	li	a5,3
    80006812:	06f71363          	bne	a4,a5,80006878 <filewrite+0xc0>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006816:	fc843783          	ld	a5,-56(s0)
    8000681a:	02479783          	lh	a5,36(a5)
    8000681e:	0207c563          	bltz	a5,80006848 <filewrite+0x90>
    80006822:	fc843783          	ld	a5,-56(s0)
    80006826:	02479703          	lh	a4,36(a5)
    8000682a:	47a5                	li	a5,9
    8000682c:	00e7ce63          	blt	a5,a4,80006848 <filewrite+0x90>
    80006830:	fc843783          	ld	a5,-56(s0)
    80006834:	02479783          	lh	a5,36(a5)
    80006838:	0001c717          	auipc	a4,0x1c
    8000683c:	28870713          	addi	a4,a4,648 # 80022ac0 <devsw>
    80006840:	0792                	slli	a5,a5,0x4
    80006842:	97ba                	add	a5,a5,a4
    80006844:	679c                	ld	a5,8(a5)
    80006846:	e399                	bnez	a5,8000684c <filewrite+0x94>
      return -1;
    80006848:	57fd                	li	a5,-1
    8000684a:	a2a1                	j	80006992 <filewrite+0x1da>
    ret = devsw[f->major].write(1, addr, n);
    8000684c:	fc843783          	ld	a5,-56(s0)
    80006850:	02479783          	lh	a5,36(a5)
    80006854:	0001c717          	auipc	a4,0x1c
    80006858:	26c70713          	addi	a4,a4,620 # 80022ac0 <devsw>
    8000685c:	0792                	slli	a5,a5,0x4
    8000685e:	97ba                	add	a5,a5,a4
    80006860:	679c                	ld	a5,8(a5)
    80006862:	fbc42703          	lw	a4,-68(s0)
    80006866:	863a                	mv	a2,a4
    80006868:	fc043583          	ld	a1,-64(s0)
    8000686c:	4505                	li	a0,1
    8000686e:	9782                	jalr	a5
    80006870:	87aa                	mv	a5,a0
    80006872:	fef42623          	sw	a5,-20(s0)
    80006876:	aa21                	j	8000698e <filewrite+0x1d6>
  } else if(f->type == FD_INODE){
    80006878:	fc843783          	ld	a5,-56(s0)
    8000687c:	4398                	lw	a4,0(a5)
    8000687e:	4789                	li	a5,2
    80006880:	10f71163          	bne	a4,a5,80006982 <filewrite+0x1ca>
    // write a few blocks at a time to avoid exceeding
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80006884:	6785                	lui	a5,0x1
    80006886:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    8000688a:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    8000688e:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80006892:	a86d                	j	8000694c <filewrite+0x194>
      int n1 = n - i;
    80006894:	fbc42783          	lw	a5,-68(s0)
    80006898:	873e                	mv	a4,a5
    8000689a:	fe842783          	lw	a5,-24(s0)
    8000689e:	40f707bb          	subw	a5,a4,a5
    800068a2:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    800068a6:	fe442783          	lw	a5,-28(s0)
    800068aa:	873e                	mv	a4,a5
    800068ac:	fe042783          	lw	a5,-32(s0)
    800068b0:	2701                	sext.w	a4,a4
    800068b2:	2781                	sext.w	a5,a5
    800068b4:	00e7d663          	bge	a5,a4,800068c0 <filewrite+0x108>
        n1 = max;
    800068b8:	fe042783          	lw	a5,-32(s0)
    800068bc:	fef42223          	sw	a5,-28(s0)

      begin_op();
    800068c0:	e8eff0ef          	jal	80005f4e <begin_op>
      ilock(f->ip);
    800068c4:	fc843783          	ld	a5,-56(s0)
    800068c8:	6f9c                	ld	a5,24(a5)
    800068ca:	853e                	mv	a0,a5
    800068cc:	e6cfe0ef          	jal	80004f38 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800068d0:	fc843783          	ld	a5,-56(s0)
    800068d4:	6f88                	ld	a0,24(a5)
    800068d6:	fe842703          	lw	a4,-24(s0)
    800068da:	fc043783          	ld	a5,-64(s0)
    800068de:	00f70633          	add	a2,a4,a5
    800068e2:	fc843783          	ld	a5,-56(s0)
    800068e6:	539c                	lw	a5,32(a5)
    800068e8:	fe442703          	lw	a4,-28(s0)
    800068ec:	86be                	mv	a3,a5
    800068ee:	4585                	li	a1,1
    800068f0:	de7fe0ef          	jal	800056d6 <writei>
    800068f4:	87aa                	mv	a5,a0
    800068f6:	fcf42e23          	sw	a5,-36(s0)
    800068fa:	fdc42783          	lw	a5,-36(s0)
    800068fe:	2781                	sext.w	a5,a5
    80006900:	00f05d63          	blez	a5,8000691a <filewrite+0x162>
        f->off += r;
    80006904:	fc843783          	ld	a5,-56(s0)
    80006908:	5398                	lw	a4,32(a5)
    8000690a:	fdc42783          	lw	a5,-36(s0)
    8000690e:	9fb9                	addw	a5,a5,a4
    80006910:	0007871b          	sext.w	a4,a5
    80006914:	fc843783          	ld	a5,-56(s0)
    80006918:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    8000691a:	fc843783          	ld	a5,-56(s0)
    8000691e:	6f9c                	ld	a5,24(a5)
    80006920:	853e                	mv	a0,a5
    80006922:	f32fe0ef          	jal	80005054 <iunlock>
      end_op();
    80006926:	edaff0ef          	jal	80006000 <end_op>

      if(r != n1){
    8000692a:	fdc42783          	lw	a5,-36(s0)
    8000692e:	873e                	mv	a4,a5
    80006930:	fe442783          	lw	a5,-28(s0)
    80006934:	2701                	sext.w	a4,a4
    80006936:	2781                	sext.w	a5,a5
    80006938:	02f71463          	bne	a4,a5,80006960 <filewrite+0x1a8>
        // error from writei
        break;
      }
      i += r;
    8000693c:	fe842783          	lw	a5,-24(s0)
    80006940:	873e                	mv	a4,a5
    80006942:	fdc42783          	lw	a5,-36(s0)
    80006946:	9fb9                	addw	a5,a5,a4
    80006948:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    8000694c:	fe842783          	lw	a5,-24(s0)
    80006950:	873e                	mv	a4,a5
    80006952:	fbc42783          	lw	a5,-68(s0)
    80006956:	2701                	sext.w	a4,a4
    80006958:	2781                	sext.w	a5,a5
    8000695a:	f2f74de3          	blt	a4,a5,80006894 <filewrite+0xdc>
    8000695e:	a011                	j	80006962 <filewrite+0x1aa>
        break;
    80006960:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80006962:	fe842783          	lw	a5,-24(s0)
    80006966:	873e                	mv	a4,a5
    80006968:	fbc42783          	lw	a5,-68(s0)
    8000696c:	2701                	sext.w	a4,a4
    8000696e:	2781                	sext.w	a5,a5
    80006970:	00f71563          	bne	a4,a5,8000697a <filewrite+0x1c2>
    80006974:	fbc42783          	lw	a5,-68(s0)
    80006978:	a011                	j	8000697c <filewrite+0x1c4>
    8000697a:	57fd                	li	a5,-1
    8000697c:	fef42623          	sw	a5,-20(s0)
    80006980:	a039                	j	8000698e <filewrite+0x1d6>
  } else {
    panic("filewrite");
    80006982:	00004517          	auipc	a0,0x4
    80006986:	cbe50513          	addi	a0,a0,-834 # 8000a640 <etext+0x640>
    8000698a:	cacfa0ef          	jal	80000e36 <panic>
  }

  return ret;
    8000698e:	fec42783          	lw	a5,-20(s0)
}
    80006992:	853e                	mv	a0,a5
    80006994:	60a6                	ld	ra,72(sp)
    80006996:	6406                	ld	s0,64(sp)
    80006998:	6161                	addi	sp,sp,80
    8000699a:	8082                	ret

000000008000699c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000699c:	7179                	addi	sp,sp,-48
    8000699e:	f406                	sd	ra,40(sp)
    800069a0:	f022                	sd	s0,32(sp)
    800069a2:	1800                	addi	s0,sp,48
    800069a4:	fca43c23          	sd	a0,-40(s0)
    800069a8:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    800069ac:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    800069b0:	fd043783          	ld	a5,-48(s0)
    800069b4:	0007b023          	sd	zero,0(a5)
    800069b8:	fd043783          	ld	a5,-48(s0)
    800069bc:	6398                	ld	a4,0(a5)
    800069be:	fd843783          	ld	a5,-40(s0)
    800069c2:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800069c4:	a73ff0ef          	jal	80006436 <filealloc>
    800069c8:	872a                	mv	a4,a0
    800069ca:	fd843783          	ld	a5,-40(s0)
    800069ce:	e398                	sd	a4,0(a5)
    800069d0:	fd843783          	ld	a5,-40(s0)
    800069d4:	639c                	ld	a5,0(a5)
    800069d6:	cbdd                	beqz	a5,80006a8c <pipealloc+0xf0>
    800069d8:	a5fff0ef          	jal	80006436 <filealloc>
    800069dc:	872a                	mv	a4,a0
    800069de:	fd043783          	ld	a5,-48(s0)
    800069e2:	e398                	sd	a4,0(a5)
    800069e4:	fd043783          	ld	a5,-48(s0)
    800069e8:	639c                	ld	a5,0(a5)
    800069ea:	c3cd                	beqz	a5,80006a8c <pipealloc+0xf0>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800069ec:	81ffa0ef          	jal	8000120a <kalloc>
    800069f0:	fea43423          	sd	a0,-24(s0)
    800069f4:	fe843783          	ld	a5,-24(s0)
    800069f8:	cfc1                	beqz	a5,80006a90 <pipealloc+0xf4>
    goto bad;
  pi->readopen = 1;
    800069fa:	fe843783          	ld	a5,-24(s0)
    800069fe:	4705                	li	a4,1
    80006a00:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80006a04:	fe843783          	ld	a5,-24(s0)
    80006a08:	4705                	li	a4,1
    80006a0a:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    80006a0e:	fe843783          	ld	a5,-24(s0)
    80006a12:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    80006a16:	fe843783          	ld	a5,-24(s0)
    80006a1a:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    80006a1e:	fe843783          	ld	a5,-24(s0)
    80006a22:	00004597          	auipc	a1,0x4
    80006a26:	c2e58593          	addi	a1,a1,-978 # 8000a650 <etext+0x650>
    80006a2a:	853e                	mv	a0,a5
    80006a2c:	8ebfa0ef          	jal	80001316 <initlock>
  (*f0)->type = FD_PIPE;
    80006a30:	fd843783          	ld	a5,-40(s0)
    80006a34:	639c                	ld	a5,0(a5)
    80006a36:	4705                	li	a4,1
    80006a38:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    80006a3a:	fd843783          	ld	a5,-40(s0)
    80006a3e:	639c                	ld	a5,0(a5)
    80006a40:	4705                	li	a4,1
    80006a42:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    80006a46:	fd843783          	ld	a5,-40(s0)
    80006a4a:	639c                	ld	a5,0(a5)
    80006a4c:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80006a50:	fd843783          	ld	a5,-40(s0)
    80006a54:	639c                	ld	a5,0(a5)
    80006a56:	fe843703          	ld	a4,-24(s0)
    80006a5a:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80006a5c:	fd043783          	ld	a5,-48(s0)
    80006a60:	639c                	ld	a5,0(a5)
    80006a62:	4705                	li	a4,1
    80006a64:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80006a66:	fd043783          	ld	a5,-48(s0)
    80006a6a:	639c                	ld	a5,0(a5)
    80006a6c:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80006a70:	fd043783          	ld	a5,-48(s0)
    80006a74:	639c                	ld	a5,0(a5)
    80006a76:	4705                	li	a4,1
    80006a78:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80006a7c:	fd043783          	ld	a5,-48(s0)
    80006a80:	639c                	ld	a5,0(a5)
    80006a82:	fe843703          	ld	a4,-24(s0)
    80006a86:	eb98                	sd	a4,16(a5)
  return 0;
    80006a88:	4781                	li	a5,0
    80006a8a:	a081                	j	80006aca <pipealloc+0x12e>
    goto bad;
    80006a8c:	0001                	nop
    80006a8e:	a011                	j	80006a92 <pipealloc+0xf6>
    goto bad;
    80006a90:	0001                	nop

 bad:
  if(pi)
    80006a92:	fe843783          	ld	a5,-24(s0)
    80006a96:	c789                	beqz	a5,80006aa0 <pipealloc+0x104>
    kfree((char*)pi);
    80006a98:	fe843503          	ld	a0,-24(s0)
    80006a9c:	edafa0ef          	jal	80001176 <kfree>
  if(*f0)
    80006aa0:	fd843783          	ld	a5,-40(s0)
    80006aa4:	639c                	ld	a5,0(a5)
    80006aa6:	c799                	beqz	a5,80006ab4 <pipealloc+0x118>
    fileclose(*f0);
    80006aa8:	fd843783          	ld	a5,-40(s0)
    80006aac:	639c                	ld	a5,0(a5)
    80006aae:	853e                	mv	a0,a5
    80006ab0:	a59ff0ef          	jal	80006508 <fileclose>
  if(*f1)
    80006ab4:	fd043783          	ld	a5,-48(s0)
    80006ab8:	639c                	ld	a5,0(a5)
    80006aba:	c799                	beqz	a5,80006ac8 <pipealloc+0x12c>
    fileclose(*f1);
    80006abc:	fd043783          	ld	a5,-48(s0)
    80006ac0:	639c                	ld	a5,0(a5)
    80006ac2:	853e                	mv	a0,a5
    80006ac4:	a45ff0ef          	jal	80006508 <fileclose>
  return -1;
    80006ac8:	57fd                	li	a5,-1
}
    80006aca:	853e                	mv	a0,a5
    80006acc:	70a2                	ld	ra,40(sp)
    80006ace:	7402                	ld	s0,32(sp)
    80006ad0:	6145                	addi	sp,sp,48
    80006ad2:	8082                	ret

0000000080006ad4 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80006ad4:	1101                	addi	sp,sp,-32
    80006ad6:	ec06                	sd	ra,24(sp)
    80006ad8:	e822                	sd	s0,16(sp)
    80006ada:	1000                	addi	s0,sp,32
    80006adc:	fea43423          	sd	a0,-24(s0)
    80006ae0:	87ae                	mv	a5,a1
    80006ae2:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80006ae6:	fe843783          	ld	a5,-24(s0)
    80006aea:	853e                	mv	a0,a5
    80006aec:	85ffa0ef          	jal	8000134a <acquire>
  if(writable){
    80006af0:	fe442783          	lw	a5,-28(s0)
    80006af4:	2781                	sext.w	a5,a5
    80006af6:	cf89                	beqz	a5,80006b10 <pipeclose+0x3c>
    pi->writeopen = 0;
    80006af8:	fe843783          	ld	a5,-24(s0)
    80006afc:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80006b00:	fe843783          	ld	a5,-24(s0)
    80006b04:	21878793          	addi	a5,a5,536
    80006b08:	853e                	mv	a0,a5
    80006b0a:	851fc0ef          	jal	8000335a <wakeup>
    80006b0e:	a821                	j	80006b26 <pipeclose+0x52>
  } else {
    pi->readopen = 0;
    80006b10:	fe843783          	ld	a5,-24(s0)
    80006b14:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80006b18:	fe843783          	ld	a5,-24(s0)
    80006b1c:	21c78793          	addi	a5,a5,540
    80006b20:	853e                	mv	a0,a5
    80006b22:	839fc0ef          	jal	8000335a <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80006b26:	fe843783          	ld	a5,-24(s0)
    80006b2a:	2207a783          	lw	a5,544(a5)
    80006b2e:	e385                	bnez	a5,80006b4e <pipeclose+0x7a>
    80006b30:	fe843783          	ld	a5,-24(s0)
    80006b34:	2247a783          	lw	a5,548(a5)
    80006b38:	eb99                	bnez	a5,80006b4e <pipeclose+0x7a>
    release(&pi->lock);
    80006b3a:	fe843783          	ld	a5,-24(s0)
    80006b3e:	853e                	mv	a0,a5
    80006b40:	85ffa0ef          	jal	8000139e <release>
    kfree((char*)pi);
    80006b44:	fe843503          	ld	a0,-24(s0)
    80006b48:	e2efa0ef          	jal	80001176 <kfree>
    80006b4c:	a039                	j	80006b5a <pipeclose+0x86>
  } else
    release(&pi->lock);
    80006b4e:	fe843783          	ld	a5,-24(s0)
    80006b52:	853e                	mv	a0,a5
    80006b54:	84bfa0ef          	jal	8000139e <release>
}
    80006b58:	0001                	nop
    80006b5a:	0001                	nop
    80006b5c:	60e2                	ld	ra,24(sp)
    80006b5e:	6442                	ld	s0,16(sp)
    80006b60:	6105                	addi	sp,sp,32
    80006b62:	8082                	ret

0000000080006b64 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80006b64:	715d                	addi	sp,sp,-80
    80006b66:	e486                	sd	ra,72(sp)
    80006b68:	e0a2                	sd	s0,64(sp)
    80006b6a:	0880                	addi	s0,sp,80
    80006b6c:	fca43423          	sd	a0,-56(s0)
    80006b70:	fcb43023          	sd	a1,-64(s0)
    80006b74:	87b2                	mv	a5,a2
    80006b76:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80006b7a:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80006b7e:	cd7fb0ef          	jal	80002854 <myproc>
    80006b82:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    80006b86:	fc843783          	ld	a5,-56(s0)
    80006b8a:	853e                	mv	a0,a5
    80006b8c:	fbefa0ef          	jal	8000134a <acquire>
  while(i < n){
    80006b90:	a0d9                	j	80006c56 <pipewrite+0xf2>
    if(pi->readopen == 0 || killed(pr)){
    80006b92:	fc843783          	ld	a5,-56(s0)
    80006b96:	2207a783          	lw	a5,544(a5)
    80006b9a:	c799                	beqz	a5,80006ba8 <pipewrite+0x44>
    80006b9c:	fe043503          	ld	a0,-32(s0)
    80006ba0:	905fc0ef          	jal	800034a4 <killed>
    80006ba4:	87aa                	mv	a5,a0
    80006ba6:	cb81                	beqz	a5,80006bb6 <pipewrite+0x52>
      release(&pi->lock);
    80006ba8:	fc843783          	ld	a5,-56(s0)
    80006bac:	853e                	mv	a0,a5
    80006bae:	ff0fa0ef          	jal	8000139e <release>
      return -1;
    80006bb2:	57fd                	li	a5,-1
    80006bb4:	a8d1                	j	80006c88 <pipewrite+0x124>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80006bb6:	fc843783          	ld	a5,-56(s0)
    80006bba:	21c7a703          	lw	a4,540(a5)
    80006bbe:	fc843783          	ld	a5,-56(s0)
    80006bc2:	2187a783          	lw	a5,536(a5)
    80006bc6:	2007879b          	addiw	a5,a5,512
    80006bca:	2781                	sext.w	a5,a5
    80006bcc:	02f71463          	bne	a4,a5,80006bf4 <pipewrite+0x90>
      wakeup(&pi->nread);
    80006bd0:	fc843783          	ld	a5,-56(s0)
    80006bd4:	21878793          	addi	a5,a5,536
    80006bd8:	853e                	mv	a0,a5
    80006bda:	f80fc0ef          	jal	8000335a <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80006bde:	fc843783          	ld	a5,-56(s0)
    80006be2:	21c78793          	addi	a5,a5,540
    80006be6:	fc843703          	ld	a4,-56(s0)
    80006bea:	85ba                	mv	a1,a4
    80006bec:	853e                	mv	a0,a5
    80006bee:	f08fc0ef          	jal	800032f6 <sleep>
    80006bf2:	a095                	j	80006c56 <pipewrite+0xf2>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80006bf4:	fe043783          	ld	a5,-32(s0)
    80006bf8:	6ba8                	ld	a0,80(a5)
    80006bfa:	fec42703          	lw	a4,-20(s0)
    80006bfe:	fc043783          	ld	a5,-64(s0)
    80006c02:	973e                	add	a4,a4,a5
    80006c04:	fdf40793          	addi	a5,s0,-33
    80006c08:	4685                	li	a3,1
    80006c0a:	863a                	mv	a2,a4
    80006c0c:	85be                	mv	a1,a5
    80006c0e:	ee2fb0ef          	jal	800022f0 <copyin>
    80006c12:	87aa                	mv	a5,a0
    80006c14:	873e                	mv	a4,a5
    80006c16:	57fd                	li	a5,-1
    80006c18:	04f70963          	beq	a4,a5,80006c6a <pipewrite+0x106>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80006c1c:	fc843783          	ld	a5,-56(s0)
    80006c20:	21c7a783          	lw	a5,540(a5)
    80006c24:	0017871b          	addiw	a4,a5,1
    80006c28:	0007069b          	sext.w	a3,a4
    80006c2c:	fc843703          	ld	a4,-56(s0)
    80006c30:	20d72e23          	sw	a3,540(a4)
    80006c34:	1ff7f793          	andi	a5,a5,511
    80006c38:	2781                	sext.w	a5,a5
    80006c3a:	fdf44703          	lbu	a4,-33(s0)
    80006c3e:	fc843683          	ld	a3,-56(s0)
    80006c42:	1782                	slli	a5,a5,0x20
    80006c44:	9381                	srli	a5,a5,0x20
    80006c46:	97b6                	add	a5,a5,a3
    80006c48:	00e78c23          	sb	a4,24(a5)
      i++;
    80006c4c:	fec42783          	lw	a5,-20(s0)
    80006c50:	2785                	addiw	a5,a5,1
    80006c52:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80006c56:	fec42783          	lw	a5,-20(s0)
    80006c5a:	873e                	mv	a4,a5
    80006c5c:	fbc42783          	lw	a5,-68(s0)
    80006c60:	2701                	sext.w	a4,a4
    80006c62:	2781                	sext.w	a5,a5
    80006c64:	f2f747e3          	blt	a4,a5,80006b92 <pipewrite+0x2e>
    80006c68:	a011                	j	80006c6c <pipewrite+0x108>
        break;
    80006c6a:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80006c6c:	fc843783          	ld	a5,-56(s0)
    80006c70:	21878793          	addi	a5,a5,536
    80006c74:	853e                	mv	a0,a5
    80006c76:	ee4fc0ef          	jal	8000335a <wakeup>
  release(&pi->lock);
    80006c7a:	fc843783          	ld	a5,-56(s0)
    80006c7e:	853e                	mv	a0,a5
    80006c80:	f1efa0ef          	jal	8000139e <release>

  return i;
    80006c84:	fec42783          	lw	a5,-20(s0)
}
    80006c88:	853e                	mv	a0,a5
    80006c8a:	60a6                	ld	ra,72(sp)
    80006c8c:	6406                	ld	s0,64(sp)
    80006c8e:	6161                	addi	sp,sp,80
    80006c90:	8082                	ret

0000000080006c92 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80006c92:	715d                	addi	sp,sp,-80
    80006c94:	e486                	sd	ra,72(sp)
    80006c96:	e0a2                	sd	s0,64(sp)
    80006c98:	0880                	addi	s0,sp,80
    80006c9a:	fca43423          	sd	a0,-56(s0)
    80006c9e:	fcb43023          	sd	a1,-64(s0)
    80006ca2:	87b2                	mv	a5,a2
    80006ca4:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80006ca8:	badfb0ef          	jal	80002854 <myproc>
    80006cac:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80006cb0:	fc843783          	ld	a5,-56(s0)
    80006cb4:	853e                	mv	a0,a5
    80006cb6:	e94fa0ef          	jal	8000134a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80006cba:	a805                	j	80006cea <piperead+0x58>
    if(killed(pr)){
    80006cbc:	fe043503          	ld	a0,-32(s0)
    80006cc0:	fe4fc0ef          	jal	800034a4 <killed>
    80006cc4:	87aa                	mv	a5,a0
    80006cc6:	cb81                	beqz	a5,80006cd6 <piperead+0x44>
      release(&pi->lock);
    80006cc8:	fc843783          	ld	a5,-56(s0)
    80006ccc:	853e                	mv	a0,a5
    80006cce:	ed0fa0ef          	jal	8000139e <release>
      return -1;
    80006cd2:	57fd                	li	a5,-1
    80006cd4:	a8f5                	j	80006dd0 <piperead+0x13e>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80006cd6:	fc843783          	ld	a5,-56(s0)
    80006cda:	21878793          	addi	a5,a5,536
    80006cde:	fc843703          	ld	a4,-56(s0)
    80006ce2:	85ba                	mv	a1,a4
    80006ce4:	853e                	mv	a0,a5
    80006ce6:	e10fc0ef          	jal	800032f6 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80006cea:	fc843783          	ld	a5,-56(s0)
    80006cee:	2187a703          	lw	a4,536(a5)
    80006cf2:	fc843783          	ld	a5,-56(s0)
    80006cf6:	21c7a783          	lw	a5,540(a5)
    80006cfa:	00f71763          	bne	a4,a5,80006d08 <piperead+0x76>
    80006cfe:	fc843783          	ld	a5,-56(s0)
    80006d02:	2247a783          	lw	a5,548(a5)
    80006d06:	fbdd                	bnez	a5,80006cbc <piperead+0x2a>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80006d08:	fe042623          	sw	zero,-20(s0)
    80006d0c:	a079                	j	80006d9a <piperead+0x108>
    if(pi->nread == pi->nwrite)
    80006d0e:	fc843783          	ld	a5,-56(s0)
    80006d12:	2187a703          	lw	a4,536(a5)
    80006d16:	fc843783          	ld	a5,-56(s0)
    80006d1a:	21c7a783          	lw	a5,540(a5)
    80006d1e:	08f70863          	beq	a4,a5,80006dae <piperead+0x11c>
      break;
    ch = pi->data[pi->nread % PIPESIZE];
    80006d22:	fc843783          	ld	a5,-56(s0)
    80006d26:	2187a783          	lw	a5,536(a5)
    80006d2a:	1ff7f793          	andi	a5,a5,511
    80006d2e:	2781                	sext.w	a5,a5
    80006d30:	fc843703          	ld	a4,-56(s0)
    80006d34:	1782                	slli	a5,a5,0x20
    80006d36:	9381                	srli	a5,a5,0x20
    80006d38:	97ba                	add	a5,a5,a4
    80006d3a:	0187c783          	lbu	a5,24(a5)
    80006d3e:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1) {
    80006d42:	fe043783          	ld	a5,-32(s0)
    80006d46:	6ba8                	ld	a0,80(a5)
    80006d48:	fec42703          	lw	a4,-20(s0)
    80006d4c:	fc043783          	ld	a5,-64(s0)
    80006d50:	97ba                	add	a5,a5,a4
    80006d52:	fdf40713          	addi	a4,s0,-33
    80006d56:	4685                	li	a3,1
    80006d58:	863a                	mv	a2,a4
    80006d5a:	85be                	mv	a1,a5
    80006d5c:	c86fb0ef          	jal	800021e2 <copyout>
    80006d60:	87aa                	mv	a5,a0
    80006d62:	873e                	mv	a4,a5
    80006d64:	57fd                	li	a5,-1
    80006d66:	00f71a63          	bne	a4,a5,80006d7a <piperead+0xe8>
      if(i == 0)
    80006d6a:	fec42783          	lw	a5,-20(s0)
    80006d6e:	2781                	sext.w	a5,a5
    80006d70:	e3a9                	bnez	a5,80006db2 <piperead+0x120>
        i = -1;
    80006d72:	57fd                	li	a5,-1
    80006d74:	fef42623          	sw	a5,-20(s0)
      break;
    80006d78:	a82d                	j	80006db2 <piperead+0x120>
    }
    pi->nread++;
    80006d7a:	fc843783          	ld	a5,-56(s0)
    80006d7e:	2187a783          	lw	a5,536(a5)
    80006d82:	2785                	addiw	a5,a5,1
    80006d84:	0007871b          	sext.w	a4,a5
    80006d88:	fc843783          	ld	a5,-56(s0)
    80006d8c:	20e7ac23          	sw	a4,536(a5)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80006d90:	fec42783          	lw	a5,-20(s0)
    80006d94:	2785                	addiw	a5,a5,1
    80006d96:	fef42623          	sw	a5,-20(s0)
    80006d9a:	fec42783          	lw	a5,-20(s0)
    80006d9e:	873e                	mv	a4,a5
    80006da0:	fbc42783          	lw	a5,-68(s0)
    80006da4:	2701                	sext.w	a4,a4
    80006da6:	2781                	sext.w	a5,a5
    80006da8:	f6f743e3          	blt	a4,a5,80006d0e <piperead+0x7c>
    80006dac:	a021                	j	80006db4 <piperead+0x122>
      break;
    80006dae:	0001                	nop
    80006db0:	a011                	j	80006db4 <piperead+0x122>
      break;
    80006db2:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80006db4:	fc843783          	ld	a5,-56(s0)
    80006db8:	21c78793          	addi	a5,a5,540
    80006dbc:	853e                	mv	a0,a5
    80006dbe:	d9cfc0ef          	jal	8000335a <wakeup>
  release(&pi->lock);
    80006dc2:	fc843783          	ld	a5,-56(s0)
    80006dc6:	853e                	mv	a0,a5
    80006dc8:	dd6fa0ef          	jal	8000139e <release>
  return i;
    80006dcc:	fec42783          	lw	a5,-20(s0)
}
    80006dd0:	853e                	mv	a0,a5
    80006dd2:	60a6                	ld	ra,72(sp)
    80006dd4:	6406                	ld	s0,64(sp)
    80006dd6:	6161                	addi	sp,sp,80
    80006dd8:	8082                	ret

0000000080006dda <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80006dda:	7179                	addi	sp,sp,-48
    80006ddc:	f406                	sd	ra,40(sp)
    80006dde:	f022                	sd	s0,32(sp)
    80006de0:	1800                	addi	s0,sp,48
    80006de2:	87aa                	mv	a5,a0
    80006de4:	fcf42e23          	sw	a5,-36(s0)
    int perm = 0;
    80006de8:	fe042623          	sw	zero,-20(s0)
    if(flags & 0x1)
    80006dec:	fdc42783          	lw	a5,-36(s0)
    80006df0:	8b85                	andi	a5,a5,1
    80006df2:	2781                	sext.w	a5,a5
    80006df4:	c781                	beqz	a5,80006dfc <flags2perm+0x22>
      perm = PTE_X;
    80006df6:	47a1                	li	a5,8
    80006df8:	fef42623          	sw	a5,-20(s0)
    if(flags & 0x2)
    80006dfc:	fdc42783          	lw	a5,-36(s0)
    80006e00:	8b89                	andi	a5,a5,2
    80006e02:	2781                	sext.w	a5,a5
    80006e04:	c799                	beqz	a5,80006e12 <flags2perm+0x38>
      perm |= PTE_W;
    80006e06:	fec42783          	lw	a5,-20(s0)
    80006e0a:	0047e793          	ori	a5,a5,4
    80006e0e:	fef42623          	sw	a5,-20(s0)
    return perm;
    80006e12:	fec42783          	lw	a5,-20(s0)
}
    80006e16:	853e                	mv	a0,a5
    80006e18:	70a2                	ld	ra,40(sp)
    80006e1a:	7402                	ld	s0,32(sp)
    80006e1c:	6145                	addi	sp,sp,48
    80006e1e:	8082                	ret

0000000080006e20 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80006e20:	de010113          	addi	sp,sp,-544
    80006e24:	20113c23          	sd	ra,536(sp)
    80006e28:	20813823          	sd	s0,528(sp)
    80006e2c:	20913423          	sd	s1,520(sp)
    80006e30:	1400                	addi	s0,sp,544
    80006e32:	dea43423          	sd	a0,-536(s0)
    80006e36:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80006e3a:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80006e3e:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80006e42:	a13fb0ef          	jal	80002854 <myproc>
    80006e46:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80006e4a:	904ff0ef          	jal	80005f4e <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80006e4e:	de843503          	ld	a0,-536(s0)
    80006e52:	ddbfe0ef          	jal	80005c2c <namei>
    80006e56:	faa43423          	sd	a0,-88(s0)
    80006e5a:	fa843783          	ld	a5,-88(s0)
    80006e5e:	e789                	bnez	a5,80006e68 <kexec+0x48>
    end_op();
    80006e60:	9a0ff0ef          	jal	80006000 <end_op>
    return -1;
    80006e64:	57fd                	li	a5,-1
    80006e66:	a6f5                	j	80007252 <kexec+0x432>
  }
  ilock(ip);
    80006e68:	fa843503          	ld	a0,-88(s0)
    80006e6c:	8ccfe0ef          	jal	80004f38 <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80006e70:	e3040793          	addi	a5,s0,-464
    80006e74:	04000713          	li	a4,64
    80006e78:	4681                	li	a3,0
    80006e7a:	863e                	mv	a2,a5
    80006e7c:	4581                	li	a1,0
    80006e7e:	fa843503          	ld	a0,-88(s0)
    80006e82:	eccfe0ef          	jal	8000554e <readi>
    80006e86:	87aa                	mv	a5,a0
    80006e88:	873e                	mv	a4,a5
    80006e8a:	04000793          	li	a5,64
    80006e8e:	36f71263          	bne	a4,a5,800071f2 <kexec+0x3d2>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80006e92:	e3042703          	lw	a4,-464(s0)
    80006e96:	464c47b7          	lui	a5,0x464c4
    80006e9a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80006e9e:	34f71c63          	bne	a4,a5,800071f6 <kexec+0x3d6>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80006ea2:	f9843503          	ld	a0,-104(s0)
    80006ea6:	bcdfb0ef          	jal	80002a72 <proc_pagetable>
    80006eaa:	faa43023          	sd	a0,-96(s0)
    80006eae:	fa043783          	ld	a5,-96(s0)
    80006eb2:	34078463          	beqz	a5,800071fa <kexec+0x3da>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80006eb6:	fc042623          	sw	zero,-52(s0)
    80006eba:	e5043783          	ld	a5,-432(s0)
    80006ebe:	fcf42423          	sw	a5,-56(s0)
    80006ec2:	a8e9                	j	80006f9c <kexec+0x17c>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80006ec4:	df840793          	addi	a5,s0,-520
    80006ec8:	fc842683          	lw	a3,-56(s0)
    80006ecc:	03800713          	li	a4,56
    80006ed0:	863e                	mv	a2,a5
    80006ed2:	4581                	li	a1,0
    80006ed4:	fa843503          	ld	a0,-88(s0)
    80006ed8:	e76fe0ef          	jal	8000554e <readi>
    80006edc:	87aa                	mv	a5,a0
    80006ede:	873e                	mv	a4,a5
    80006ee0:	03800793          	li	a5,56
    80006ee4:	30f71d63          	bne	a4,a5,800071fe <kexec+0x3de>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80006ee8:	df842703          	lw	a4,-520(s0)
    80006eec:	4785                	li	a5,1
    80006eee:	08f71a63          	bne	a4,a5,80006f82 <kexec+0x162>
      continue;
    if(ph.memsz < ph.filesz)
    80006ef2:	e2043703          	ld	a4,-480(s0)
    80006ef6:	e1843783          	ld	a5,-488(s0)
    80006efa:	30f76463          	bltu	a4,a5,80007202 <kexec+0x3e2>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80006efe:	e0843703          	ld	a4,-504(s0)
    80006f02:	e2043783          	ld	a5,-480(s0)
    80006f06:	973e                	add	a4,a4,a5
    80006f08:	e0843783          	ld	a5,-504(s0)
    80006f0c:	2ef76d63          	bltu	a4,a5,80007206 <kexec+0x3e6>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
    80006f10:	e0843703          	ld	a4,-504(s0)
    80006f14:	6785                	lui	a5,0x1
    80006f16:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80006f18:	8ff9                	and	a5,a5,a4
    80006f1a:	2e079863          	bnez	a5,8000720a <kexec+0x3ea>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80006f1e:	e0843703          	ld	a4,-504(s0)
    80006f22:	e2043783          	ld	a5,-480(s0)
    80006f26:	00f704b3          	add	s1,a4,a5
    80006f2a:	dfc42783          	lw	a5,-516(s0)
    80006f2e:	853e                	mv	a0,a5
    80006f30:	eabff0ef          	jal	80006dda <flags2perm>
    80006f34:	87aa                	mv	a5,a0
    80006f36:	86be                	mv	a3,a5
    80006f38:	8626                	mv	a2,s1
    80006f3a:	fb843583          	ld	a1,-72(s0)
    80006f3e:	fa043503          	ld	a0,-96(s0)
    80006f42:	f1ffa0ef          	jal	80001e60 <uvmalloc>
    80006f46:	f6a43823          	sd	a0,-144(s0)
    80006f4a:	f7043783          	ld	a5,-144(s0)
    80006f4e:	2c078063          	beqz	a5,8000720e <kexec+0x3ee>
      goto bad;
    sz = sz1;
    80006f52:	f7043783          	ld	a5,-144(s0)
    80006f56:	faf43c23          	sd	a5,-72(s0)
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80006f5a:	e0843783          	ld	a5,-504(s0)
    80006f5e:	e0043703          	ld	a4,-512(s0)
    80006f62:	0007069b          	sext.w	a3,a4
    80006f66:	e1843703          	ld	a4,-488(s0)
    80006f6a:	2701                	sext.w	a4,a4
    80006f6c:	fa843603          	ld	a2,-88(s0)
    80006f70:	85be                	mv	a1,a5
    80006f72:	fa043503          	ld	a0,-96(s0)
    80006f76:	2f0000ef          	jal	80007266 <loadseg>
    80006f7a:	87aa                	mv	a5,a0
    80006f7c:	2807cb63          	bltz	a5,80007212 <kexec+0x3f2>
    80006f80:	a011                	j	80006f84 <kexec+0x164>
      continue;
    80006f82:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80006f84:	fcc42783          	lw	a5,-52(s0)
    80006f88:	2785                	addiw	a5,a5,1
    80006f8a:	fcf42623          	sw	a5,-52(s0)
    80006f8e:	fc842783          	lw	a5,-56(s0)
    80006f92:	0387879b          	addiw	a5,a5,56
    80006f96:	2781                	sext.w	a5,a5
    80006f98:	fcf42423          	sw	a5,-56(s0)
    80006f9c:	e6845783          	lhu	a5,-408(s0)
    80006fa0:	2781                	sext.w	a5,a5
    80006fa2:	fcc42703          	lw	a4,-52(s0)
    80006fa6:	2701                	sext.w	a4,a4
    80006fa8:	f0f74ee3          	blt	a4,a5,80006ec4 <kexec+0xa4>
      goto bad;
  }
  iunlockput(ip);
    80006fac:	fa843503          	ld	a0,-88(s0)
    80006fb0:	9a0fe0ef          	jal	80005150 <iunlockput>
  end_op();
    80006fb4:	84cff0ef          	jal	80006000 <end_op>
  ip = 0;
    80006fb8:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80006fbc:	899fb0ef          	jal	80002854 <myproc>
    80006fc0:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80006fc4:	f9843783          	ld	a5,-104(s0)
    80006fc8:	67bc                	ld	a5,72(a5)
    80006fca:	f8f43823          	sd	a5,-112(s0)

  // Allocate some pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the rest as the user stack.
  sz = PGROUNDUP(sz);
    80006fce:	fb843703          	ld	a4,-72(s0)
    80006fd2:	6785                	lui	a5,0x1
    80006fd4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80006fd6:	973e                	add	a4,a4,a5
    80006fd8:	77fd                	lui	a5,0xfffff
    80006fda:	8ff9                	and	a5,a5,a4
    80006fdc:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80006fe0:	fb843703          	ld	a4,-72(s0)
    80006fe4:	6789                	lui	a5,0x2
    80006fe6:	97ba                	add	a5,a5,a4
    80006fe8:	4691                	li	a3,4
    80006fea:	863e                	mv	a2,a5
    80006fec:	fb843583          	ld	a1,-72(s0)
    80006ff0:	fa043503          	ld	a0,-96(s0)
    80006ff4:	e6dfa0ef          	jal	80001e60 <uvmalloc>
    80006ff8:	f8a43423          	sd	a0,-120(s0)
    80006ffc:	f8843783          	ld	a5,-120(s0)
    80007000:	20078b63          	beqz	a5,80007216 <kexec+0x3f6>
    goto bad;
  sz = sz1;
    80007004:	f8843783          	ld	a5,-120(s0)
    80007008:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    8000700c:	fb843703          	ld	a4,-72(s0)
    80007010:	77f9                	lui	a5,0xffffe
    80007012:	97ba                	add	a5,a5,a4
    80007014:	85be                	mv	a1,a5
    80007016:	fa043503          	ld	a0,-96(s0)
    8000701a:	97afb0ef          	jal	80002194 <uvmclear>
  sp = sz;
    8000701e:	fb843783          	ld	a5,-72(s0)
    80007022:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - USERSTACK*PGSIZE;
    80007026:	fb043703          	ld	a4,-80(s0)
    8000702a:	77fd                	lui	a5,0xfffff
    8000702c:	97ba                	add	a5,a5,a4
    8000702e:	f8f43023          	sd	a5,-128(s0)

  // Copy argument strings into new stack, remember their
  // addresses in ustack[].
  for(argc = 0; argv[argc]; argc++) {
    80007032:	fc043023          	sd	zero,-64(s0)
    80007036:	a04d                	j	800070d8 <kexec+0x2b8>
    if(argc >= MAXARG)
    80007038:	fc043703          	ld	a4,-64(s0)
    8000703c:	47fd                	li	a5,31
    8000703e:	1ce7ee63          	bltu	a5,a4,8000721a <kexec+0x3fa>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80007042:	fc043783          	ld	a5,-64(s0)
    80007046:	078e                	slli	a5,a5,0x3
    80007048:	de043703          	ld	a4,-544(s0)
    8000704c:	97ba                	add	a5,a5,a4
    8000704e:	639c                	ld	a5,0(a5)
    80007050:	853e                	mv	a0,a5
    80007052:	819fa0ef          	jal	8000186a <strlen>
    80007056:	87aa                	mv	a5,a0
    80007058:	2785                	addiw	a5,a5,1 # fffffffffffff001 <end+0xffffffff7ffdb3a9>
    8000705a:	2781                	sext.w	a5,a5
    8000705c:	873e                	mv	a4,a5
    8000705e:	fb043783          	ld	a5,-80(s0)
    80007062:	8f99                	sub	a5,a5,a4
    80007064:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80007068:	fb043783          	ld	a5,-80(s0)
    8000706c:	9bc1                	andi	a5,a5,-16
    8000706e:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007072:	fb043703          	ld	a4,-80(s0)
    80007076:	f8043783          	ld	a5,-128(s0)
    8000707a:	1af76263          	bltu	a4,a5,8000721e <kexec+0x3fe>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000707e:	fc043783          	ld	a5,-64(s0)
    80007082:	078e                	slli	a5,a5,0x3
    80007084:	de043703          	ld	a4,-544(s0)
    80007088:	97ba                	add	a5,a5,a4
    8000708a:	6384                	ld	s1,0(a5)
    8000708c:	fc043783          	ld	a5,-64(s0)
    80007090:	078e                	slli	a5,a5,0x3
    80007092:	de043703          	ld	a4,-544(s0)
    80007096:	97ba                	add	a5,a5,a4
    80007098:	639c                	ld	a5,0(a5)
    8000709a:	853e                	mv	a0,a5
    8000709c:	fcefa0ef          	jal	8000186a <strlen>
    800070a0:	87aa                	mv	a5,a0
    800070a2:	2785                	addiw	a5,a5,1
    800070a4:	2781                	sext.w	a5,a5
    800070a6:	86be                	mv	a3,a5
    800070a8:	8626                	mv	a2,s1
    800070aa:	fb043583          	ld	a1,-80(s0)
    800070ae:	fa043503          	ld	a0,-96(s0)
    800070b2:	930fb0ef          	jal	800021e2 <copyout>
    800070b6:	87aa                	mv	a5,a0
    800070b8:	1607c563          	bltz	a5,80007222 <kexec+0x402>
      goto bad;
    ustack[argc] = sp;
    800070bc:	fc043703          	ld	a4,-64(s0)
    800070c0:	e7040793          	addi	a5,s0,-400
    800070c4:	070e                	slli	a4,a4,0x3
    800070c6:	97ba                	add	a5,a5,a4
    800070c8:	fb043703          	ld	a4,-80(s0)
    800070cc:	e398                	sd	a4,0(a5)
  for(argc = 0; argv[argc]; argc++) {
    800070ce:	fc043783          	ld	a5,-64(s0)
    800070d2:	0785                	addi	a5,a5,1
    800070d4:	fcf43023          	sd	a5,-64(s0)
    800070d8:	fc043783          	ld	a5,-64(s0)
    800070dc:	078e                	slli	a5,a5,0x3
    800070de:	de043703          	ld	a4,-544(s0)
    800070e2:	97ba                	add	a5,a5,a4
    800070e4:	639c                	ld	a5,0(a5)
    800070e6:	fba9                	bnez	a5,80007038 <kexec+0x218>
  }
  ustack[argc] = 0;
    800070e8:	fc043703          	ld	a4,-64(s0)
    800070ec:	e7040793          	addi	a5,s0,-400
    800070f0:	070e                	slli	a4,a4,0x3
    800070f2:	97ba                	add	a5,a5,a4
    800070f4:	0007b023          	sd	zero,0(a5)

  // push a copy of ustack[], the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    800070f8:	fc043783          	ld	a5,-64(s0)
    800070fc:	0785                	addi	a5,a5,1
    800070fe:	078e                	slli	a5,a5,0x3
    80007100:	fb043703          	ld	a4,-80(s0)
    80007104:	40f707b3          	sub	a5,a4,a5
    80007108:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    8000710c:	fb043783          	ld	a5,-80(s0)
    80007110:	9bc1                	andi	a5,a5,-16
    80007112:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    80007116:	fb043703          	ld	a4,-80(s0)
    8000711a:	f8043783          	ld	a5,-128(s0)
    8000711e:	10f76463          	bltu	a4,a5,80007226 <kexec+0x406>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80007122:	fc043783          	ld	a5,-64(s0)
    80007126:	0785                	addi	a5,a5,1
    80007128:	00379713          	slli	a4,a5,0x3
    8000712c:	e7040793          	addi	a5,s0,-400
    80007130:	86ba                	mv	a3,a4
    80007132:	863e                	mv	a2,a5
    80007134:	fb043583          	ld	a1,-80(s0)
    80007138:	fa043503          	ld	a0,-96(s0)
    8000713c:	8a6fb0ef          	jal	800021e2 <copyout>
    80007140:	87aa                	mv	a5,a0
    80007142:	0e07c463          	bltz	a5,8000722a <kexec+0x40a>
    goto bad;

  // a0 and a1 contain arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80007146:	f9843783          	ld	a5,-104(s0)
    8000714a:	6fbc                	ld	a5,88(a5)
    8000714c:	fb043703          	ld	a4,-80(s0)
    80007150:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80007152:	de843783          	ld	a5,-536(s0)
    80007156:	fcf43c23          	sd	a5,-40(s0)
    8000715a:	fd843783          	ld	a5,-40(s0)
    8000715e:	fcf43823          	sd	a5,-48(s0)
    80007162:	a025                	j	8000718a <kexec+0x36a>
    if(*s == '/')
    80007164:	fd843783          	ld	a5,-40(s0)
    80007168:	0007c783          	lbu	a5,0(a5)
    8000716c:	873e                	mv	a4,a5
    8000716e:	02f00793          	li	a5,47
    80007172:	00f71763          	bne	a4,a5,80007180 <kexec+0x360>
      last = s+1;
    80007176:	fd843783          	ld	a5,-40(s0)
    8000717a:	0785                	addi	a5,a5,1
    8000717c:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80007180:	fd843783          	ld	a5,-40(s0)
    80007184:	0785                	addi	a5,a5,1
    80007186:	fcf43c23          	sd	a5,-40(s0)
    8000718a:	fd843783          	ld	a5,-40(s0)
    8000718e:	0007c783          	lbu	a5,0(a5)
    80007192:	fbe9                	bnez	a5,80007164 <kexec+0x344>
  safestrcpy(p->name, last, sizeof(p->name));
    80007194:	f9843783          	ld	a5,-104(s0)
    80007198:	15878793          	addi	a5,a5,344
    8000719c:	4641                	li	a2,16
    8000719e:	fd043583          	ld	a1,-48(s0)
    800071a2:	853e                	mv	a0,a5
    800071a4:	e46fa0ef          	jal	800017ea <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    800071a8:	f9843783          	ld	a5,-104(s0)
    800071ac:	6bbc                	ld	a5,80(a5)
    800071ae:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    800071b2:	f9843783          	ld	a5,-104(s0)
    800071b6:	fa043703          	ld	a4,-96(s0)
    800071ba:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    800071bc:	f9843783          	ld	a5,-104(s0)
    800071c0:	fb843703          	ld	a4,-72(s0)
    800071c4:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = ulib.c:start()
    800071c6:	f9843783          	ld	a5,-104(s0)
    800071ca:	6fbc                	ld	a5,88(a5)
    800071cc:	e4843703          	ld	a4,-440(s0)
    800071d0:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800071d2:	f9843783          	ld	a5,-104(s0)
    800071d6:	6fbc                	ld	a5,88(a5)
    800071d8:	fb043703          	ld	a4,-80(s0)
    800071dc:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800071de:	f9043583          	ld	a1,-112(s0)
    800071e2:	f7843503          	ld	a0,-136(s0)
    800071e6:	935fb0ef          	jal	80002b1a <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800071ea:	fc043783          	ld	a5,-64(s0)
    800071ee:	2781                	sext.w	a5,a5
    800071f0:	a08d                	j	80007252 <kexec+0x432>
    goto bad;
    800071f2:	0001                	nop
    800071f4:	a825                	j	8000722c <kexec+0x40c>
    goto bad;
    800071f6:	0001                	nop
    800071f8:	a815                	j	8000722c <kexec+0x40c>
    goto bad;
    800071fa:	0001                	nop
    800071fc:	a805                	j	8000722c <kexec+0x40c>
      goto bad;
    800071fe:	0001                	nop
    80007200:	a035                	j	8000722c <kexec+0x40c>
      goto bad;
    80007202:	0001                	nop
    80007204:	a025                	j	8000722c <kexec+0x40c>
      goto bad;
    80007206:	0001                	nop
    80007208:	a015                	j	8000722c <kexec+0x40c>
      goto bad;
    8000720a:	0001                	nop
    8000720c:	a005                	j	8000722c <kexec+0x40c>
      goto bad;
    8000720e:	0001                	nop
    80007210:	a831                	j	8000722c <kexec+0x40c>
      goto bad;
    80007212:	0001                	nop
    80007214:	a821                	j	8000722c <kexec+0x40c>
    goto bad;
    80007216:	0001                	nop
    80007218:	a811                	j	8000722c <kexec+0x40c>
      goto bad;
    8000721a:	0001                	nop
    8000721c:	a801                	j	8000722c <kexec+0x40c>
      goto bad;
    8000721e:	0001                	nop
    80007220:	a031                	j	8000722c <kexec+0x40c>
      goto bad;
    80007222:	0001                	nop
    80007224:	a021                	j	8000722c <kexec+0x40c>
    goto bad;
    80007226:	0001                	nop
    80007228:	a011                	j	8000722c <kexec+0x40c>
    goto bad;
    8000722a:	0001                	nop

 bad:
  if(pagetable)
    8000722c:	fa043783          	ld	a5,-96(s0)
    80007230:	c799                	beqz	a5,8000723e <kexec+0x41e>
    proc_freepagetable(pagetable, sz);
    80007232:	fb843583          	ld	a1,-72(s0)
    80007236:	fa043503          	ld	a0,-96(s0)
    8000723a:	8e1fb0ef          	jal	80002b1a <proc_freepagetable>
  if(ip){
    8000723e:	fa843783          	ld	a5,-88(s0)
    80007242:	c799                	beqz	a5,80007250 <kexec+0x430>
    iunlockput(ip);
    80007244:	fa843503          	ld	a0,-88(s0)
    80007248:	f09fd0ef          	jal	80005150 <iunlockput>
    end_op();
    8000724c:	db5fe0ef          	jal	80006000 <end_op>
  }
  return -1;
    80007250:	57fd                	li	a5,-1
}
    80007252:	853e                	mv	a0,a5
    80007254:	21813083          	ld	ra,536(sp)
    80007258:	21013403          	ld	s0,528(sp)
    8000725c:	20813483          	ld	s1,520(sp)
    80007260:	22010113          	addi	sp,sp,544
    80007264:	8082                	ret

0000000080007266 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    80007266:	7139                	addi	sp,sp,-64
    80007268:	fc06                	sd	ra,56(sp)
    8000726a:	f822                	sd	s0,48(sp)
    8000726c:	0080                	addi	s0,sp,64
    8000726e:	fca43c23          	sd	a0,-40(s0)
    80007272:	fcb43823          	sd	a1,-48(s0)
    80007276:	fcc43423          	sd	a2,-56(s0)
    8000727a:	87b6                	mv	a5,a3
    8000727c:	fcf42223          	sw	a5,-60(s0)
    80007280:	87ba                	mv	a5,a4
    80007282:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80007286:	fe042623          	sw	zero,-20(s0)
    8000728a:	a045                	j	8000732a <loadseg+0xc4>
    pa = walkaddr(pagetable, va + i);
    8000728c:	fec46703          	lwu	a4,-20(s0)
    80007290:	fd043783          	ld	a5,-48(s0)
    80007294:	97ba                	add	a5,a5,a4
    80007296:	85be                	mv	a1,a5
    80007298:	fd843503          	ld	a0,-40(s0)
    8000729c:	967fa0ef          	jal	80001c02 <walkaddr>
    800072a0:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    800072a4:	fe043783          	ld	a5,-32(s0)
    800072a8:	e799                	bnez	a5,800072b6 <loadseg+0x50>
      panic("loadseg: address should exist");
    800072aa:	00003517          	auipc	a0,0x3
    800072ae:	3ae50513          	addi	a0,a0,942 # 8000a658 <etext+0x658>
    800072b2:	b85f90ef          	jal	80000e36 <panic>
    if(sz - i < PGSIZE)
    800072b6:	fc042783          	lw	a5,-64(s0)
    800072ba:	873e                	mv	a4,a5
    800072bc:	fec42783          	lw	a5,-20(s0)
    800072c0:	40f707bb          	subw	a5,a4,a5
    800072c4:	0007871b          	sext.w	a4,a5
    800072c8:	6785                	lui	a5,0x1
    800072ca:	00f77c63          	bgeu	a4,a5,800072e2 <loadseg+0x7c>
      n = sz - i;
    800072ce:	fc042783          	lw	a5,-64(s0)
    800072d2:	873e                	mv	a4,a5
    800072d4:	fec42783          	lw	a5,-20(s0)
    800072d8:	40f707bb          	subw	a5,a4,a5
    800072dc:	fef42423          	sw	a5,-24(s0)
    800072e0:	a021                	j	800072e8 <loadseg+0x82>
    else
      n = PGSIZE;
    800072e2:	6785                	lui	a5,0x1
    800072e4:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800072e8:	fc442783          	lw	a5,-60(s0)
    800072ec:	873e                	mv	a4,a5
    800072ee:	fec42783          	lw	a5,-20(s0)
    800072f2:	9fb9                	addw	a5,a5,a4
    800072f4:	2781                	sext.w	a5,a5
    800072f6:	fe842703          	lw	a4,-24(s0)
    800072fa:	86be                	mv	a3,a5
    800072fc:	fe043603          	ld	a2,-32(s0)
    80007300:	4581                	li	a1,0
    80007302:	fc843503          	ld	a0,-56(s0)
    80007306:	a48fe0ef          	jal	8000554e <readi>
    8000730a:	87aa                	mv	a5,a0
    8000730c:	873e                	mv	a4,a5
    8000730e:	fe842783          	lw	a5,-24(s0)
    80007312:	2781                	sext.w	a5,a5
    80007314:	00e78463          	beq	a5,a4,8000731c <loadseg+0xb6>
      return -1;
    80007318:	57fd                	li	a5,-1
    8000731a:	a015                	j	8000733e <loadseg+0xd8>
  for(i = 0; i < sz; i += PGSIZE){
    8000731c:	fec42783          	lw	a5,-20(s0)
    80007320:	873e                	mv	a4,a5
    80007322:	6785                	lui	a5,0x1
    80007324:	9fb9                	addw	a5,a5,a4
    80007326:	fef42623          	sw	a5,-20(s0)
    8000732a:	fec42783          	lw	a5,-20(s0)
    8000732e:	873e                	mv	a4,a5
    80007330:	fc042783          	lw	a5,-64(s0)
    80007334:	2701                	sext.w	a4,a4
    80007336:	2781                	sext.w	a5,a5
    80007338:	f4f76ae3          	bltu	a4,a5,8000728c <loadseg+0x26>
  }
  
  return 0;
    8000733c:	4781                	li	a5,0
}
    8000733e:	853e                	mv	a0,a5
    80007340:	70e2                	ld	ra,56(sp)
    80007342:	7442                	ld	s0,48(sp)
    80007344:	6121                	addi	sp,sp,64
    80007346:	8082                	ret

0000000080007348 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007348:	7139                	addi	sp,sp,-64
    8000734a:	fc06                	sd	ra,56(sp)
    8000734c:	f822                	sd	s0,48(sp)
    8000734e:	0080                	addi	s0,sp,64
    80007350:	87aa                	mv	a5,a0
    80007352:	fcb43823          	sd	a1,-48(s0)
    80007356:	fcc43423          	sd	a2,-56(s0)
    8000735a:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  argint(n, &fd);
    8000735e:	fe440713          	addi	a4,s0,-28
    80007362:	fdc42783          	lw	a5,-36(s0)
    80007366:	85ba                	mv	a1,a4
    80007368:	853e                	mv	a0,a5
    8000736a:	acdfc0ef          	jal	80003e36 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000736e:	fe442783          	lw	a5,-28(s0)
    80007372:	0207c563          	bltz	a5,8000739c <argfd+0x54>
    80007376:	fe442703          	lw	a4,-28(s0)
    8000737a:	47bd                	li	a5,15
    8000737c:	02e7c063          	blt	a5,a4,8000739c <argfd+0x54>
    80007380:	cd4fb0ef          	jal	80002854 <myproc>
    80007384:	872a                	mv	a4,a0
    80007386:	fe442783          	lw	a5,-28(s0)
    8000738a:	07e9                	addi	a5,a5,26 # 101a <_entry-0x7fffefe6>
    8000738c:	078e                	slli	a5,a5,0x3
    8000738e:	97ba                	add	a5,a5,a4
    80007390:	639c                	ld	a5,0(a5)
    80007392:	fef43423          	sd	a5,-24(s0)
    80007396:	fe843783          	ld	a5,-24(s0)
    8000739a:	e399                	bnez	a5,800073a0 <argfd+0x58>
    return -1;
    8000739c:	57fd                	li	a5,-1
    8000739e:	a015                	j	800073c2 <argfd+0x7a>
  if(pfd)
    800073a0:	fd043783          	ld	a5,-48(s0)
    800073a4:	c791                	beqz	a5,800073b0 <argfd+0x68>
    *pfd = fd;
    800073a6:	fe442703          	lw	a4,-28(s0)
    800073aa:	fd043783          	ld	a5,-48(s0)
    800073ae:	c398                	sw	a4,0(a5)
  if(pf)
    800073b0:	fc843783          	ld	a5,-56(s0)
    800073b4:	c791                	beqz	a5,800073c0 <argfd+0x78>
    *pf = f;
    800073b6:	fc843783          	ld	a5,-56(s0)
    800073ba:	fe843703          	ld	a4,-24(s0)
    800073be:	e398                	sd	a4,0(a5)
  return 0;
    800073c0:	4781                	li	a5,0
}
    800073c2:	853e                	mv	a0,a5
    800073c4:	70e2                	ld	ra,56(sp)
    800073c6:	7442                	ld	s0,48(sp)
    800073c8:	6121                	addi	sp,sp,64
    800073ca:	8082                	ret

00000000800073cc <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800073cc:	7179                	addi	sp,sp,-48
    800073ce:	f406                	sd	ra,40(sp)
    800073d0:	f022                	sd	s0,32(sp)
    800073d2:	1800                	addi	s0,sp,48
    800073d4:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    800073d8:	c7cfb0ef          	jal	80002854 <myproc>
    800073dc:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    800073e0:	fe042623          	sw	zero,-20(s0)
    800073e4:	a825                	j	8000741c <fdalloc+0x50>
    if(p->ofile[fd] == 0){
    800073e6:	fe043703          	ld	a4,-32(s0)
    800073ea:	fec42783          	lw	a5,-20(s0)
    800073ee:	07e9                	addi	a5,a5,26
    800073f0:	078e                	slli	a5,a5,0x3
    800073f2:	97ba                	add	a5,a5,a4
    800073f4:	639c                	ld	a5,0(a5)
    800073f6:	ef91                	bnez	a5,80007412 <fdalloc+0x46>
      p->ofile[fd] = f;
    800073f8:	fe043703          	ld	a4,-32(s0)
    800073fc:	fec42783          	lw	a5,-20(s0)
    80007400:	07e9                	addi	a5,a5,26
    80007402:	078e                	slli	a5,a5,0x3
    80007404:	97ba                	add	a5,a5,a4
    80007406:	fd843703          	ld	a4,-40(s0)
    8000740a:	e398                	sd	a4,0(a5)
      return fd;
    8000740c:	fec42783          	lw	a5,-20(s0)
    80007410:	a831                	j	8000742c <fdalloc+0x60>
  for(fd = 0; fd < NOFILE; fd++){
    80007412:	fec42783          	lw	a5,-20(s0)
    80007416:	2785                	addiw	a5,a5,1
    80007418:	fef42623          	sw	a5,-20(s0)
    8000741c:	fec42783          	lw	a5,-20(s0)
    80007420:	0007871b          	sext.w	a4,a5
    80007424:	47bd                	li	a5,15
    80007426:	fce7d0e3          	bge	a5,a4,800073e6 <fdalloc+0x1a>
    }
  }
  return -1;
    8000742a:	57fd                	li	a5,-1
}
    8000742c:	853e                	mv	a0,a5
    8000742e:	70a2                	ld	ra,40(sp)
    80007430:	7402                	ld	s0,32(sp)
    80007432:	6145                	addi	sp,sp,48
    80007434:	8082                	ret

0000000080007436 <sys_dup>:

uint64
sys_dup(void)
{
    80007436:	1101                	addi	sp,sp,-32
    80007438:	ec06                	sd	ra,24(sp)
    8000743a:	e822                	sd	s0,16(sp)
    8000743c:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    8000743e:	fe040793          	addi	a5,s0,-32
    80007442:	863e                	mv	a2,a5
    80007444:	4581                	li	a1,0
    80007446:	4501                	li	a0,0
    80007448:	f01ff0ef          	jal	80007348 <argfd>
    8000744c:	87aa                	mv	a5,a0
    8000744e:	0007d463          	bgez	a5,80007456 <sys_dup+0x20>
    return -1;
    80007452:	57fd                	li	a5,-1
    80007454:	a03d                	j	80007482 <sys_dup+0x4c>
  if((fd=fdalloc(f)) < 0)
    80007456:	fe043783          	ld	a5,-32(s0)
    8000745a:	853e                	mv	a0,a5
    8000745c:	f71ff0ef          	jal	800073cc <fdalloc>
    80007460:	87aa                	mv	a5,a0
    80007462:	fef42623          	sw	a5,-20(s0)
    80007466:	fec42783          	lw	a5,-20(s0)
    8000746a:	2781                	sext.w	a5,a5
    8000746c:	0007d463          	bgez	a5,80007474 <sys_dup+0x3e>
    return -1;
    80007470:	57fd                	li	a5,-1
    80007472:	a801                	j	80007482 <sys_dup+0x4c>
  filedup(f);
    80007474:	fe043783          	ld	a5,-32(s0)
    80007478:	853e                	mv	a0,a5
    8000747a:	834ff0ef          	jal	800064ae <filedup>
  return fd;
    8000747e:	fec42783          	lw	a5,-20(s0)
}
    80007482:	853e                	mv	a0,a5
    80007484:	60e2                	ld	ra,24(sp)
    80007486:	6442                	ld	s0,16(sp)
    80007488:	6105                	addi	sp,sp,32
    8000748a:	8082                	ret

000000008000748c <sys_read>:

uint64
sys_read(void)
{
    8000748c:	7179                	addi	sp,sp,-48
    8000748e:	f406                	sd	ra,40(sp)
    80007490:	f022                	sd	s0,32(sp)
    80007492:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
    80007494:	fd840793          	addi	a5,s0,-40
    80007498:	85be                	mv	a1,a5
    8000749a:	4505                	li	a0,1
    8000749c:	9cdfc0ef          	jal	80003e68 <argaddr>
  argint(2, &n);
    800074a0:	fe440793          	addi	a5,s0,-28
    800074a4:	85be                	mv	a1,a5
    800074a6:	4509                	li	a0,2
    800074a8:	98ffc0ef          	jal	80003e36 <argint>
  if(argfd(0, 0, &f) < 0)
    800074ac:	fe840793          	addi	a5,s0,-24
    800074b0:	863e                	mv	a2,a5
    800074b2:	4581                	li	a1,0
    800074b4:	4501                	li	a0,0
    800074b6:	e93ff0ef          	jal	80007348 <argfd>
    800074ba:	87aa                	mv	a5,a0
    800074bc:	0007d463          	bgez	a5,800074c4 <sys_read+0x38>
    return -1;
    800074c0:	57fd                	li	a5,-1
    800074c2:	a829                	j	800074dc <sys_read+0x50>
  return fileread(f, p, n);
    800074c4:	fe843783          	ld	a5,-24(s0)
    800074c8:	fd843703          	ld	a4,-40(s0)
    800074cc:	fe442683          	lw	a3,-28(s0)
    800074d0:	8636                	mv	a2,a3
    800074d2:	85ba                	mv	a1,a4
    800074d4:	853e                	mv	a0,a5
    800074d6:	9a0ff0ef          	jal	80006676 <fileread>
    800074da:	87aa                	mv	a5,a0
}
    800074dc:	853e                	mv	a0,a5
    800074de:	70a2                	ld	ra,40(sp)
    800074e0:	7402                	ld	s0,32(sp)
    800074e2:	6145                	addi	sp,sp,48
    800074e4:	8082                	ret

00000000800074e6 <sys_write>:

uint64
sys_write(void)
{
    800074e6:	7179                	addi	sp,sp,-48
    800074e8:	f406                	sd	ra,40(sp)
    800074ea:	f022                	sd	s0,32(sp)
    800074ec:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
    800074ee:	fd840793          	addi	a5,s0,-40
    800074f2:	85be                	mv	a1,a5
    800074f4:	4505                	li	a0,1
    800074f6:	973fc0ef          	jal	80003e68 <argaddr>
  argint(2, &n);
    800074fa:	fe440793          	addi	a5,s0,-28
    800074fe:	85be                	mv	a1,a5
    80007500:	4509                	li	a0,2
    80007502:	935fc0ef          	jal	80003e36 <argint>
  if(argfd(0, 0, &f) < 0)
    80007506:	fe840793          	addi	a5,s0,-24
    8000750a:	863e                	mv	a2,a5
    8000750c:	4581                	li	a1,0
    8000750e:	4501                	li	a0,0
    80007510:	e39ff0ef          	jal	80007348 <argfd>
    80007514:	87aa                	mv	a5,a0
    80007516:	0007d463          	bgez	a5,8000751e <sys_write+0x38>
    return -1;
    8000751a:	57fd                	li	a5,-1
    8000751c:	a829                	j	80007536 <sys_write+0x50>

  return filewrite(f, p, n);
    8000751e:	fe843783          	ld	a5,-24(s0)
    80007522:	fd843703          	ld	a4,-40(s0)
    80007526:	fe442683          	lw	a3,-28(s0)
    8000752a:	8636                	mv	a2,a3
    8000752c:	85ba                	mv	a1,a4
    8000752e:	853e                	mv	a0,a5
    80007530:	a88ff0ef          	jal	800067b8 <filewrite>
    80007534:	87aa                	mv	a5,a0
}
    80007536:	853e                	mv	a0,a5
    80007538:	70a2                	ld	ra,40(sp)
    8000753a:	7402                	ld	s0,32(sp)
    8000753c:	6145                	addi	sp,sp,48
    8000753e:	8082                	ret

0000000080007540 <sys_close>:

uint64
sys_close(void)
{
    80007540:	1101                	addi	sp,sp,-32
    80007542:	ec06                	sd	ra,24(sp)
    80007544:	e822                	sd	s0,16(sp)
    80007546:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80007548:	fe040713          	addi	a4,s0,-32
    8000754c:	fec40793          	addi	a5,s0,-20
    80007550:	863a                	mv	a2,a4
    80007552:	85be                	mv	a1,a5
    80007554:	4501                	li	a0,0
    80007556:	df3ff0ef          	jal	80007348 <argfd>
    8000755a:	87aa                	mv	a5,a0
    8000755c:	0007d463          	bgez	a5,80007564 <sys_close+0x24>
    return -1;
    80007560:	57fd                	li	a5,-1
    80007562:	a00d                	j	80007584 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80007564:	af0fb0ef          	jal	80002854 <myproc>
    80007568:	872a                	mv	a4,a0
    8000756a:	fec42783          	lw	a5,-20(s0)
    8000756e:	07e9                	addi	a5,a5,26
    80007570:	078e                	slli	a5,a5,0x3
    80007572:	97ba                	add	a5,a5,a4
    80007574:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80007578:	fe043783          	ld	a5,-32(s0)
    8000757c:	853e                	mv	a0,a5
    8000757e:	f8bfe0ef          	jal	80006508 <fileclose>
  return 0;
    80007582:	4781                	li	a5,0
}
    80007584:	853e                	mv	a0,a5
    80007586:	60e2                	ld	ra,24(sp)
    80007588:	6442                	ld	s0,16(sp)
    8000758a:	6105                	addi	sp,sp,32
    8000758c:	8082                	ret

000000008000758e <sys_fstat>:

uint64
sys_fstat(void)
{
    8000758e:	1101                	addi	sp,sp,-32
    80007590:	ec06                	sd	ra,24(sp)
    80007592:	e822                	sd	s0,16(sp)
    80007594:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
    80007596:	fe040793          	addi	a5,s0,-32
    8000759a:	85be                	mv	a1,a5
    8000759c:	4505                	li	a0,1
    8000759e:	8cbfc0ef          	jal	80003e68 <argaddr>
  if(argfd(0, 0, &f) < 0)
    800075a2:	fe840793          	addi	a5,s0,-24
    800075a6:	863e                	mv	a2,a5
    800075a8:	4581                	li	a1,0
    800075aa:	4501                	li	a0,0
    800075ac:	d9dff0ef          	jal	80007348 <argfd>
    800075b0:	87aa                	mv	a5,a0
    800075b2:	0007d463          	bgez	a5,800075ba <sys_fstat+0x2c>
    return -1;
    800075b6:	57fd                	li	a5,-1
    800075b8:	a811                	j	800075cc <sys_fstat+0x3e>
  return filestat(f, st);
    800075ba:	fe843783          	ld	a5,-24(s0)
    800075be:	fe043703          	ld	a4,-32(s0)
    800075c2:	85ba                	mv	a1,a4
    800075c4:	853e                	mv	a0,a5
    800075c6:	824ff0ef          	jal	800065ea <filestat>
    800075ca:	87aa                	mv	a5,a0
}
    800075cc:	853e                	mv	a0,a5
    800075ce:	60e2                	ld	ra,24(sp)
    800075d0:	6442                	ld	s0,16(sp)
    800075d2:	6105                	addi	sp,sp,32
    800075d4:	8082                	ret

00000000800075d6 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    800075d6:	7169                	addi	sp,sp,-304
    800075d8:	f606                	sd	ra,296(sp)
    800075da:	f222                	sd	s0,288(sp)
    800075dc:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800075de:	ed040793          	addi	a5,s0,-304
    800075e2:	08000613          	li	a2,128
    800075e6:	85be                	mv	a1,a5
    800075e8:	4501                	li	a0,0
    800075ea:	8adfc0ef          	jal	80003e96 <argstr>
    800075ee:	87aa                	mv	a5,a0
    800075f0:	0007cd63          	bltz	a5,8000760a <sys_link+0x34>
    800075f4:	f5040793          	addi	a5,s0,-176
    800075f8:	08000613          	li	a2,128
    800075fc:	85be                	mv	a1,a5
    800075fe:	4505                	li	a0,1
    80007600:	897fc0ef          	jal	80003e96 <argstr>
    80007604:	87aa                	mv	a5,a0
    80007606:	0007d463          	bgez	a5,8000760e <sys_link+0x38>
    return -1;
    8000760a:	57fd                	li	a5,-1
    8000760c:	a235                	j	80007738 <sys_link+0x162>

  begin_op();
    8000760e:	941fe0ef          	jal	80005f4e <begin_op>
  if((ip = namei(old)) == 0){
    80007612:	ed040793          	addi	a5,s0,-304
    80007616:	853e                	mv	a0,a5
    80007618:	e14fe0ef          	jal	80005c2c <namei>
    8000761c:	fea43423          	sd	a0,-24(s0)
    80007620:	fe843783          	ld	a5,-24(s0)
    80007624:	e789                	bnez	a5,8000762e <sys_link+0x58>
    end_op();
    80007626:	9dbfe0ef          	jal	80006000 <end_op>
    return -1;
    8000762a:	57fd                	li	a5,-1
    8000762c:	a231                	j	80007738 <sys_link+0x162>
  }

  ilock(ip);
    8000762e:	fe843503          	ld	a0,-24(s0)
    80007632:	907fd0ef          	jal	80004f38 <ilock>
  if(ip->type == T_DIR){
    80007636:	fe843783          	ld	a5,-24(s0)
    8000763a:	04479703          	lh	a4,68(a5)
    8000763e:	4785                	li	a5,1
    80007640:	00f71a63          	bne	a4,a5,80007654 <sys_link+0x7e>
    iunlockput(ip);
    80007644:	fe843503          	ld	a0,-24(s0)
    80007648:	b09fd0ef          	jal	80005150 <iunlockput>
    end_op();
    8000764c:	9b5fe0ef          	jal	80006000 <end_op>
    return -1;
    80007650:	57fd                	li	a5,-1
    80007652:	a0dd                	j	80007738 <sys_link+0x162>
  }

  ip->nlink++;
    80007654:	fe843783          	ld	a5,-24(s0)
    80007658:	04a79783          	lh	a5,74(a5)
    8000765c:	17c2                	slli	a5,a5,0x30
    8000765e:	93c1                	srli	a5,a5,0x30
    80007660:	2785                	addiw	a5,a5,1
    80007662:	17c2                	slli	a5,a5,0x30
    80007664:	93c1                	srli	a5,a5,0x30
    80007666:	0107971b          	slliw	a4,a5,0x10
    8000766a:	4107571b          	sraiw	a4,a4,0x10
    8000766e:	fe843783          	ld	a5,-24(s0)
    80007672:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007676:	fe843503          	ld	a0,-24(s0)
    8000767a:	e96fd0ef          	jal	80004d10 <iupdate>
  iunlock(ip);
    8000767e:	fe843503          	ld	a0,-24(s0)
    80007682:	9d3fd0ef          	jal	80005054 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80007686:	fd040713          	addi	a4,s0,-48
    8000768a:	f5040793          	addi	a5,s0,-176
    8000768e:	85ba                	mv	a1,a4
    80007690:	853e                	mv	a0,a5
    80007692:	dc2fe0ef          	jal	80005c54 <nameiparent>
    80007696:	fea43023          	sd	a0,-32(s0)
    8000769a:	fe043783          	ld	a5,-32(s0)
    8000769e:	cfa1                	beqz	a5,800076f6 <sys_link+0x120>
    goto bad;
  ilock(dp);
    800076a0:	fe043503          	ld	a0,-32(s0)
    800076a4:	895fd0ef          	jal	80004f38 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800076a8:	fe043783          	ld	a5,-32(s0)
    800076ac:	4398                	lw	a4,0(a5)
    800076ae:	fe843783          	ld	a5,-24(s0)
    800076b2:	439c                	lw	a5,0(a5)
    800076b4:	02f71063          	bne	a4,a5,800076d4 <sys_link+0xfe>
    800076b8:	fe843783          	ld	a5,-24(s0)
    800076bc:	43d8                	lw	a4,4(a5)
    800076be:	fd040793          	addi	a5,s0,-48
    800076c2:	863a                	mv	a2,a4
    800076c4:	85be                	mv	a1,a5
    800076c6:	fe043503          	ld	a0,-32(s0)
    800076ca:	aa4fe0ef          	jal	8000596e <dirlink>
    800076ce:	87aa                	mv	a5,a0
    800076d0:	0007d763          	bgez	a5,800076de <sys_link+0x108>
    iunlockput(dp);
    800076d4:	fe043503          	ld	a0,-32(s0)
    800076d8:	a79fd0ef          	jal	80005150 <iunlockput>
    goto bad;
    800076dc:	a831                	j	800076f8 <sys_link+0x122>
  }
  iunlockput(dp);
    800076de:	fe043503          	ld	a0,-32(s0)
    800076e2:	a6ffd0ef          	jal	80005150 <iunlockput>
  iput(ip);
    800076e6:	fe843503          	ld	a0,-24(s0)
    800076ea:	9b9fd0ef          	jal	800050a2 <iput>

  end_op();
    800076ee:	913fe0ef          	jal	80006000 <end_op>

  return 0;
    800076f2:	4781                	li	a5,0
    800076f4:	a091                	j	80007738 <sys_link+0x162>
    goto bad;
    800076f6:	0001                	nop

bad:
  ilock(ip);
    800076f8:	fe843503          	ld	a0,-24(s0)
    800076fc:	83dfd0ef          	jal	80004f38 <ilock>
  ip->nlink--;
    80007700:	fe843783          	ld	a5,-24(s0)
    80007704:	04a79783          	lh	a5,74(a5)
    80007708:	17c2                	slli	a5,a5,0x30
    8000770a:	93c1                	srli	a5,a5,0x30
    8000770c:	37fd                	addiw	a5,a5,-1
    8000770e:	17c2                	slli	a5,a5,0x30
    80007710:	93c1                	srli	a5,a5,0x30
    80007712:	0107971b          	slliw	a4,a5,0x10
    80007716:	4107571b          	sraiw	a4,a4,0x10
    8000771a:	fe843783          	ld	a5,-24(s0)
    8000771e:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007722:	fe843503          	ld	a0,-24(s0)
    80007726:	deafd0ef          	jal	80004d10 <iupdate>
  iunlockput(ip);
    8000772a:	fe843503          	ld	a0,-24(s0)
    8000772e:	a23fd0ef          	jal	80005150 <iunlockput>
  end_op();
    80007732:	8cffe0ef          	jal	80006000 <end_op>
  return -1;
    80007736:	57fd                	li	a5,-1
}
    80007738:	853e                	mv	a0,a5
    8000773a:	70b2                	ld	ra,296(sp)
    8000773c:	7412                	ld	s0,288(sp)
    8000773e:	6155                	addi	sp,sp,304
    80007740:	8082                	ret

0000000080007742 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80007742:	7139                	addi	sp,sp,-64
    80007744:	fc06                	sd	ra,56(sp)
    80007746:	f822                	sd	s0,48(sp)
    80007748:	0080                	addi	s0,sp,64
    8000774a:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000774e:	02000793          	li	a5,32
    80007752:	fef42623          	sw	a5,-20(s0)
    80007756:	a091                	j	8000779a <isdirempty+0x58>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007758:	fd840793          	addi	a5,s0,-40
    8000775c:	fec42683          	lw	a3,-20(s0)
    80007760:	4741                	li	a4,16
    80007762:	863e                	mv	a2,a5
    80007764:	4581                	li	a1,0
    80007766:	fc843503          	ld	a0,-56(s0)
    8000776a:	de5fd0ef          	jal	8000554e <readi>
    8000776e:	87aa                	mv	a5,a0
    80007770:	873e                	mv	a4,a5
    80007772:	47c1                	li	a5,16
    80007774:	00f70863          	beq	a4,a5,80007784 <isdirempty+0x42>
      panic("isdirempty: readi");
    80007778:	00003517          	auipc	a0,0x3
    8000777c:	f0050513          	addi	a0,a0,-256 # 8000a678 <etext+0x678>
    80007780:	eb6f90ef          	jal	80000e36 <panic>
    if(de.inum != 0)
    80007784:	fd845783          	lhu	a5,-40(s0)
    80007788:	c399                	beqz	a5,8000778e <isdirempty+0x4c>
      return 0;
    8000778a:	4781                	li	a5,0
    8000778c:	a839                	j	800077aa <isdirempty+0x68>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000778e:	fec42783          	lw	a5,-20(s0)
    80007792:	27c1                	addiw	a5,a5,16
    80007794:	2781                	sext.w	a5,a5
    80007796:	fef42623          	sw	a5,-20(s0)
    8000779a:	fc843783          	ld	a5,-56(s0)
    8000779e:	47f8                	lw	a4,76(a5)
    800077a0:	fec42783          	lw	a5,-20(s0)
    800077a4:	fae7eae3          	bltu	a5,a4,80007758 <isdirempty+0x16>
  }
  return 1;
    800077a8:	4785                	li	a5,1
}
    800077aa:	853e                	mv	a0,a5
    800077ac:	70e2                	ld	ra,56(sp)
    800077ae:	7442                	ld	s0,48(sp)
    800077b0:	6121                	addi	sp,sp,64
    800077b2:	8082                	ret

00000000800077b4 <sys_unlink>:

uint64
sys_unlink(void)
{
    800077b4:	7155                	addi	sp,sp,-208
    800077b6:	e586                	sd	ra,200(sp)
    800077b8:	e1a2                	sd	s0,192(sp)
    800077ba:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    800077bc:	f4040793          	addi	a5,s0,-192
    800077c0:	08000613          	li	a2,128
    800077c4:	85be                	mv	a1,a5
    800077c6:	4501                	li	a0,0
    800077c8:	ecefc0ef          	jal	80003e96 <argstr>
    800077cc:	87aa                	mv	a5,a0
    800077ce:	0007d463          	bgez	a5,800077d6 <sys_unlink+0x22>
    return -1;
    800077d2:	57fd                	li	a5,-1
    800077d4:	a271                	j	80007960 <sys_unlink+0x1ac>

  begin_op();
    800077d6:	f78fe0ef          	jal	80005f4e <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800077da:	fc040713          	addi	a4,s0,-64
    800077de:	f4040793          	addi	a5,s0,-192
    800077e2:	85ba                	mv	a1,a4
    800077e4:	853e                	mv	a0,a5
    800077e6:	c6efe0ef          	jal	80005c54 <nameiparent>
    800077ea:	fea43423          	sd	a0,-24(s0)
    800077ee:	fe843783          	ld	a5,-24(s0)
    800077f2:	e789                	bnez	a5,800077fc <sys_unlink+0x48>
    end_op();
    800077f4:	80dfe0ef          	jal	80006000 <end_op>
    return -1;
    800077f8:	57fd                	li	a5,-1
    800077fa:	a29d                	j	80007960 <sys_unlink+0x1ac>
  }

  ilock(dp);
    800077fc:	fe843503          	ld	a0,-24(s0)
    80007800:	f38fd0ef          	jal	80004f38 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80007804:	fc040793          	addi	a5,s0,-64
    80007808:	00003597          	auipc	a1,0x3
    8000780c:	e8858593          	addi	a1,a1,-376 # 8000a690 <etext+0x690>
    80007810:	853e                	mv	a0,a5
    80007812:	862fe0ef          	jal	80005874 <namecmp>
    80007816:	87aa                	mv	a5,a0
    80007818:	12078a63          	beqz	a5,8000794c <sys_unlink+0x198>
    8000781c:	fc040793          	addi	a5,s0,-64
    80007820:	00003597          	auipc	a1,0x3
    80007824:	e7858593          	addi	a1,a1,-392 # 8000a698 <etext+0x698>
    80007828:	853e                	mv	a0,a5
    8000782a:	84afe0ef          	jal	80005874 <namecmp>
    8000782e:	87aa                	mv	a5,a0
    80007830:	10078e63          	beqz	a5,8000794c <sys_unlink+0x198>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80007834:	f3c40713          	addi	a4,s0,-196
    80007838:	fc040793          	addi	a5,s0,-64
    8000783c:	863a                	mv	a2,a4
    8000783e:	85be                	mv	a1,a5
    80007840:	fe843503          	ld	a0,-24(s0)
    80007844:	85afe0ef          	jal	8000589e <dirlookup>
    80007848:	fea43023          	sd	a0,-32(s0)
    8000784c:	fe043783          	ld	a5,-32(s0)
    80007850:	10078063          	beqz	a5,80007950 <sys_unlink+0x19c>
    goto bad;
  ilock(ip);
    80007854:	fe043503          	ld	a0,-32(s0)
    80007858:	ee0fd0ef          	jal	80004f38 <ilock>

  if(ip->nlink < 1)
    8000785c:	fe043783          	ld	a5,-32(s0)
    80007860:	04a79783          	lh	a5,74(a5)
    80007864:	00f04863          	bgtz	a5,80007874 <sys_unlink+0xc0>
    panic("unlink: nlink < 1");
    80007868:	00003517          	auipc	a0,0x3
    8000786c:	e3850513          	addi	a0,a0,-456 # 8000a6a0 <etext+0x6a0>
    80007870:	dc6f90ef          	jal	80000e36 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80007874:	fe043783          	ld	a5,-32(s0)
    80007878:	04479703          	lh	a4,68(a5)
    8000787c:	4785                	li	a5,1
    8000787e:	00f71d63          	bne	a4,a5,80007898 <sys_unlink+0xe4>
    80007882:	fe043503          	ld	a0,-32(s0)
    80007886:	ebdff0ef          	jal	80007742 <isdirempty>
    8000788a:	87aa                	mv	a5,a0
    8000788c:	e791                	bnez	a5,80007898 <sys_unlink+0xe4>
    iunlockput(ip);
    8000788e:	fe043503          	ld	a0,-32(s0)
    80007892:	8bffd0ef          	jal	80005150 <iunlockput>
    goto bad;
    80007896:	a875                	j	80007952 <sys_unlink+0x19e>
  }

  memset(&de, 0, sizeof(de));
    80007898:	fd040793          	addi	a5,s0,-48
    8000789c:	4641                	li	a2,16
    8000789e:	4581                	li	a1,0
    800078a0:	853e                	mv	a0,a5
    800078a2:	c35f90ef          	jal	800014d6 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800078a6:	fd040793          	addi	a5,s0,-48
    800078aa:	f3c42683          	lw	a3,-196(s0)
    800078ae:	4741                	li	a4,16
    800078b0:	863e                	mv	a2,a5
    800078b2:	4581                	li	a1,0
    800078b4:	fe843503          	ld	a0,-24(s0)
    800078b8:	e1ffd0ef          	jal	800056d6 <writei>
    800078bc:	87aa                	mv	a5,a0
    800078be:	873e                	mv	a4,a5
    800078c0:	47c1                	li	a5,16
    800078c2:	00f70863          	beq	a4,a5,800078d2 <sys_unlink+0x11e>
    panic("unlink: writei");
    800078c6:	00003517          	auipc	a0,0x3
    800078ca:	df250513          	addi	a0,a0,-526 # 8000a6b8 <etext+0x6b8>
    800078ce:	d68f90ef          	jal	80000e36 <panic>
  if(ip->type == T_DIR){
    800078d2:	fe043783          	ld	a5,-32(s0)
    800078d6:	04479703          	lh	a4,68(a5)
    800078da:	4785                	li	a5,1
    800078dc:	02f71763          	bne	a4,a5,8000790a <sys_unlink+0x156>
    dp->nlink--;
    800078e0:	fe843783          	ld	a5,-24(s0)
    800078e4:	04a79783          	lh	a5,74(a5)
    800078e8:	17c2                	slli	a5,a5,0x30
    800078ea:	93c1                	srli	a5,a5,0x30
    800078ec:	37fd                	addiw	a5,a5,-1
    800078ee:	17c2                	slli	a5,a5,0x30
    800078f0:	93c1                	srli	a5,a5,0x30
    800078f2:	0107971b          	slliw	a4,a5,0x10
    800078f6:	4107571b          	sraiw	a4,a4,0x10
    800078fa:	fe843783          	ld	a5,-24(s0)
    800078fe:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80007902:	fe843503          	ld	a0,-24(s0)
    80007906:	c0afd0ef          	jal	80004d10 <iupdate>
  }
  iunlockput(dp);
    8000790a:	fe843503          	ld	a0,-24(s0)
    8000790e:	843fd0ef          	jal	80005150 <iunlockput>

  ip->nlink--;
    80007912:	fe043783          	ld	a5,-32(s0)
    80007916:	04a79783          	lh	a5,74(a5)
    8000791a:	17c2                	slli	a5,a5,0x30
    8000791c:	93c1                	srli	a5,a5,0x30
    8000791e:	37fd                	addiw	a5,a5,-1
    80007920:	17c2                	slli	a5,a5,0x30
    80007922:	93c1                	srli	a5,a5,0x30
    80007924:	0107971b          	slliw	a4,a5,0x10
    80007928:	4107571b          	sraiw	a4,a4,0x10
    8000792c:	fe043783          	ld	a5,-32(s0)
    80007930:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007934:	fe043503          	ld	a0,-32(s0)
    80007938:	bd8fd0ef          	jal	80004d10 <iupdate>
  iunlockput(ip);
    8000793c:	fe043503          	ld	a0,-32(s0)
    80007940:	811fd0ef          	jal	80005150 <iunlockput>

  end_op();
    80007944:	ebcfe0ef          	jal	80006000 <end_op>

  return 0;
    80007948:	4781                	li	a5,0
    8000794a:	a819                	j	80007960 <sys_unlink+0x1ac>
    goto bad;
    8000794c:	0001                	nop
    8000794e:	a011                	j	80007952 <sys_unlink+0x19e>
    goto bad;
    80007950:	0001                	nop

bad:
  iunlockput(dp);
    80007952:	fe843503          	ld	a0,-24(s0)
    80007956:	ffafd0ef          	jal	80005150 <iunlockput>
  end_op();
    8000795a:	ea6fe0ef          	jal	80006000 <end_op>
  return -1;
    8000795e:	57fd                	li	a5,-1
}
    80007960:	853e                	mv	a0,a5
    80007962:	60ae                	ld	ra,200(sp)
    80007964:	640e                	ld	s0,192(sp)
    80007966:	6169                	addi	sp,sp,208
    80007968:	8082                	ret

000000008000796a <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000796a:	7139                	addi	sp,sp,-64
    8000796c:	fc06                	sd	ra,56(sp)
    8000796e:	f822                	sd	s0,48(sp)
    80007970:	0080                	addi	s0,sp,64
    80007972:	fca43423          	sd	a0,-56(s0)
    80007976:	87ae                	mv	a5,a1
    80007978:	8736                	mv	a4,a3
    8000797a:	fcf41323          	sh	a5,-58(s0)
    8000797e:	87b2                	mv	a5,a2
    80007980:	fcf41223          	sh	a5,-60(s0)
    80007984:	87ba                	mv	a5,a4
    80007986:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    8000798a:	fd040793          	addi	a5,s0,-48
    8000798e:	85be                	mv	a1,a5
    80007990:	fc843503          	ld	a0,-56(s0)
    80007994:	ac0fe0ef          	jal	80005c54 <nameiparent>
    80007998:	fea43423          	sd	a0,-24(s0)
    8000799c:	fe843783          	ld	a5,-24(s0)
    800079a0:	e399                	bnez	a5,800079a6 <create+0x3c>
    return 0;
    800079a2:	4781                	li	a5,0
    800079a4:	aa79                	j	80007b42 <create+0x1d8>

  ilock(dp);
    800079a6:	fe843503          	ld	a0,-24(s0)
    800079aa:	d8efd0ef          	jal	80004f38 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800079ae:	fd040793          	addi	a5,s0,-48
    800079b2:	4601                	li	a2,0
    800079b4:	85be                	mv	a1,a5
    800079b6:	fe843503          	ld	a0,-24(s0)
    800079ba:	ee5fd0ef          	jal	8000589e <dirlookup>
    800079be:	fea43023          	sd	a0,-32(s0)
    800079c2:	fe043783          	ld	a5,-32(s0)
    800079c6:	c7b9                	beqz	a5,80007a14 <create+0xaa>
    iunlockput(dp);
    800079c8:	fe843503          	ld	a0,-24(s0)
    800079cc:	f84fd0ef          	jal	80005150 <iunlockput>
    ilock(ip);
    800079d0:	fe043503          	ld	a0,-32(s0)
    800079d4:	d64fd0ef          	jal	80004f38 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800079d8:	fc641783          	lh	a5,-58(s0)
    800079dc:	0007871b          	sext.w	a4,a5
    800079e0:	4789                	li	a5,2
    800079e2:	02f71363          	bne	a4,a5,80007a08 <create+0x9e>
    800079e6:	fe043783          	ld	a5,-32(s0)
    800079ea:	04479703          	lh	a4,68(a5)
    800079ee:	4789                	li	a5,2
    800079f0:	00f70963          	beq	a4,a5,80007a02 <create+0x98>
    800079f4:	fe043783          	ld	a5,-32(s0)
    800079f8:	04479703          	lh	a4,68(a5)
    800079fc:	478d                	li	a5,3
    800079fe:	00f71563          	bne	a4,a5,80007a08 <create+0x9e>
      return ip;
    80007a02:	fe043783          	ld	a5,-32(s0)
    80007a06:	aa35                	j	80007b42 <create+0x1d8>
    iunlockput(ip);
    80007a08:	fe043503          	ld	a0,-32(s0)
    80007a0c:	f44fd0ef          	jal	80005150 <iunlockput>
    return 0;
    80007a10:	4781                	li	a5,0
    80007a12:	aa05                	j	80007b42 <create+0x1d8>
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    80007a14:	fe843783          	ld	a5,-24(s0)
    80007a18:	439c                	lw	a5,0(a5)
    80007a1a:	fc641703          	lh	a4,-58(s0)
    80007a1e:	85ba                	mv	a1,a4
    80007a20:	853e                	mv	a0,a5
    80007a22:	a0cfd0ef          	jal	80004c2e <ialloc>
    80007a26:	fea43023          	sd	a0,-32(s0)
    80007a2a:	fe043783          	ld	a5,-32(s0)
    80007a2e:	e799                	bnez	a5,80007a3c <create+0xd2>
    iunlockput(dp);
    80007a30:	fe843503          	ld	a0,-24(s0)
    80007a34:	f1cfd0ef          	jal	80005150 <iunlockput>
    return 0;
    80007a38:	4781                	li	a5,0
    80007a3a:	a221                	j	80007b42 <create+0x1d8>
  }

  ilock(ip);
    80007a3c:	fe043503          	ld	a0,-32(s0)
    80007a40:	cf8fd0ef          	jal	80004f38 <ilock>
  ip->major = major;
    80007a44:	fe043783          	ld	a5,-32(s0)
    80007a48:	fc445703          	lhu	a4,-60(s0)
    80007a4c:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    80007a50:	fe043783          	ld	a5,-32(s0)
    80007a54:	fc245703          	lhu	a4,-62(s0)
    80007a58:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80007a5c:	fe043783          	ld	a5,-32(s0)
    80007a60:	4705                	li	a4,1
    80007a62:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007a66:	fe043503          	ld	a0,-32(s0)
    80007a6a:	aa6fd0ef          	jal	80004d10 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80007a6e:	fc641783          	lh	a5,-58(s0)
    80007a72:	0007871b          	sext.w	a4,a5
    80007a76:	4785                	li	a5,1
    80007a78:	04f71063          	bne	a4,a5,80007ab8 <create+0x14e>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80007a7c:	fe043783          	ld	a5,-32(s0)
    80007a80:	43dc                	lw	a5,4(a5)
    80007a82:	863e                	mv	a2,a5
    80007a84:	00003597          	auipc	a1,0x3
    80007a88:	c0c58593          	addi	a1,a1,-1012 # 8000a690 <etext+0x690>
    80007a8c:	fe043503          	ld	a0,-32(s0)
    80007a90:	edffd0ef          	jal	8000596e <dirlink>
    80007a94:	87aa                	mv	a5,a0
    80007a96:	0807c263          	bltz	a5,80007b1a <create+0x1b0>
    80007a9a:	fe843783          	ld	a5,-24(s0)
    80007a9e:	43dc                	lw	a5,4(a5)
    80007aa0:	863e                	mv	a2,a5
    80007aa2:	00003597          	auipc	a1,0x3
    80007aa6:	bf658593          	addi	a1,a1,-1034 # 8000a698 <etext+0x698>
    80007aaa:	fe043503          	ld	a0,-32(s0)
    80007aae:	ec1fd0ef          	jal	8000596e <dirlink>
    80007ab2:	87aa                	mv	a5,a0
    80007ab4:	0607c363          	bltz	a5,80007b1a <create+0x1b0>
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80007ab8:	fe043783          	ld	a5,-32(s0)
    80007abc:	43d8                	lw	a4,4(a5)
    80007abe:	fd040793          	addi	a5,s0,-48
    80007ac2:	863a                	mv	a2,a4
    80007ac4:	85be                	mv	a1,a5
    80007ac6:	fe843503          	ld	a0,-24(s0)
    80007aca:	ea5fd0ef          	jal	8000596e <dirlink>
    80007ace:	87aa                	mv	a5,a0
    80007ad0:	0407c763          	bltz	a5,80007b1e <create+0x1b4>
    goto fail;

  if(type == T_DIR){
    80007ad4:	fc641783          	lh	a5,-58(s0)
    80007ad8:	0007871b          	sext.w	a4,a5
    80007adc:	4785                	li	a5,1
    80007ade:	02f71763          	bne	a4,a5,80007b0c <create+0x1a2>
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    80007ae2:	fe843783          	ld	a5,-24(s0)
    80007ae6:	04a79783          	lh	a5,74(a5)
    80007aea:	17c2                	slli	a5,a5,0x30
    80007aec:	93c1                	srli	a5,a5,0x30
    80007aee:	2785                	addiw	a5,a5,1
    80007af0:	17c2                	slli	a5,a5,0x30
    80007af2:	93c1                	srli	a5,a5,0x30
    80007af4:	0107971b          	slliw	a4,a5,0x10
    80007af8:	4107571b          	sraiw	a4,a4,0x10
    80007afc:	fe843783          	ld	a5,-24(s0)
    80007b00:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80007b04:	fe843503          	ld	a0,-24(s0)
    80007b08:	a08fd0ef          	jal	80004d10 <iupdate>
  }

  iunlockput(dp);
    80007b0c:	fe843503          	ld	a0,-24(s0)
    80007b10:	e40fd0ef          	jal	80005150 <iunlockput>

  return ip;
    80007b14:	fe043783          	ld	a5,-32(s0)
    80007b18:	a02d                	j	80007b42 <create+0x1d8>
      goto fail;
    80007b1a:	0001                	nop
    80007b1c:	a011                	j	80007b20 <create+0x1b6>
    goto fail;
    80007b1e:	0001                	nop

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
    80007b20:	fe043783          	ld	a5,-32(s0)
    80007b24:	04079523          	sh	zero,74(a5)
  iupdate(ip);
    80007b28:	fe043503          	ld	a0,-32(s0)
    80007b2c:	9e4fd0ef          	jal	80004d10 <iupdate>
  iunlockput(ip);
    80007b30:	fe043503          	ld	a0,-32(s0)
    80007b34:	e1cfd0ef          	jal	80005150 <iunlockput>
  iunlockput(dp);
    80007b38:	fe843503          	ld	a0,-24(s0)
    80007b3c:	e14fd0ef          	jal	80005150 <iunlockput>
  return 0;
    80007b40:	4781                	li	a5,0
}
    80007b42:	853e                	mv	a0,a5
    80007b44:	70e2                	ld	ra,56(sp)
    80007b46:	7442                	ld	s0,48(sp)
    80007b48:	6121                	addi	sp,sp,64
    80007b4a:	8082                	ret

0000000080007b4c <sys_open>:

uint64
sys_open(void)
{
    80007b4c:	7131                	addi	sp,sp,-192
    80007b4e:	fd06                	sd	ra,184(sp)
    80007b50:	f922                	sd	s0,176(sp)
    80007b52:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80007b54:	f4c40793          	addi	a5,s0,-180
    80007b58:	85be                	mv	a1,a5
    80007b5a:	4505                	li	a0,1
    80007b5c:	adafc0ef          	jal	80003e36 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80007b60:	f5040793          	addi	a5,s0,-176
    80007b64:	08000613          	li	a2,128
    80007b68:	85be                	mv	a1,a5
    80007b6a:	4501                	li	a0,0
    80007b6c:	b2afc0ef          	jal	80003e96 <argstr>
    80007b70:	87aa                	mv	a5,a0
    80007b72:	fef42223          	sw	a5,-28(s0)
    80007b76:	fe442783          	lw	a5,-28(s0)
    80007b7a:	2781                	sext.w	a5,a5
    80007b7c:	0007d463          	bgez	a5,80007b84 <sys_open+0x38>
    return -1;
    80007b80:	57fd                	li	a5,-1
    80007b82:	a275                	j	80007d2e <sys_open+0x1e2>

  begin_op();
    80007b84:	bcafe0ef          	jal	80005f4e <begin_op>

  if(omode & O_CREATE){
    80007b88:	f4c42783          	lw	a5,-180(s0)
    80007b8c:	2007f793          	andi	a5,a5,512
    80007b90:	2781                	sext.w	a5,a5
    80007b92:	c395                	beqz	a5,80007bb6 <sys_open+0x6a>
    ip = create(path, T_FILE, 0, 0);
    80007b94:	f5040793          	addi	a5,s0,-176
    80007b98:	4681                	li	a3,0
    80007b9a:	4601                	li	a2,0
    80007b9c:	4589                	li	a1,2
    80007b9e:	853e                	mv	a0,a5
    80007ba0:	dcbff0ef          	jal	8000796a <create>
    80007ba4:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80007ba8:	fe843783          	ld	a5,-24(s0)
    80007bac:	eba9                	bnez	a5,80007bfe <sys_open+0xb2>
      end_op();
    80007bae:	c52fe0ef          	jal	80006000 <end_op>
      return -1;
    80007bb2:	57fd                	li	a5,-1
    80007bb4:	aaad                	j	80007d2e <sys_open+0x1e2>
    }
  } else {
    if((ip = namei(path)) == 0){
    80007bb6:	f5040793          	addi	a5,s0,-176
    80007bba:	853e                	mv	a0,a5
    80007bbc:	870fe0ef          	jal	80005c2c <namei>
    80007bc0:	fea43423          	sd	a0,-24(s0)
    80007bc4:	fe843783          	ld	a5,-24(s0)
    80007bc8:	e789                	bnez	a5,80007bd2 <sys_open+0x86>
      end_op();
    80007bca:	c36fe0ef          	jal	80006000 <end_op>
      return -1;
    80007bce:	57fd                	li	a5,-1
    80007bd0:	aab9                	j	80007d2e <sys_open+0x1e2>
    }
    ilock(ip);
    80007bd2:	fe843503          	ld	a0,-24(s0)
    80007bd6:	b62fd0ef          	jal	80004f38 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80007bda:	fe843783          	ld	a5,-24(s0)
    80007bde:	04479703          	lh	a4,68(a5)
    80007be2:	4785                	li	a5,1
    80007be4:	00f71d63          	bne	a4,a5,80007bfe <sys_open+0xb2>
    80007be8:	f4c42783          	lw	a5,-180(s0)
    80007bec:	cb89                	beqz	a5,80007bfe <sys_open+0xb2>
      iunlockput(ip);
    80007bee:	fe843503          	ld	a0,-24(s0)
    80007bf2:	d5efd0ef          	jal	80005150 <iunlockput>
      end_op();
    80007bf6:	c0afe0ef          	jal	80006000 <end_op>
      return -1;
    80007bfa:	57fd                	li	a5,-1
    80007bfc:	aa0d                	j	80007d2e <sys_open+0x1e2>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80007bfe:	fe843783          	ld	a5,-24(s0)
    80007c02:	04479703          	lh	a4,68(a5)
    80007c06:	478d                	li	a5,3
    80007c08:	02f71763          	bne	a4,a5,80007c36 <sys_open+0xea>
    80007c0c:	fe843783          	ld	a5,-24(s0)
    80007c10:	04679783          	lh	a5,70(a5)
    80007c14:	0007c963          	bltz	a5,80007c26 <sys_open+0xda>
    80007c18:	fe843783          	ld	a5,-24(s0)
    80007c1c:	04679703          	lh	a4,70(a5)
    80007c20:	47a5                	li	a5,9
    80007c22:	00e7da63          	bge	a5,a4,80007c36 <sys_open+0xea>
    iunlockput(ip);
    80007c26:	fe843503          	ld	a0,-24(s0)
    80007c2a:	d26fd0ef          	jal	80005150 <iunlockput>
    end_op();
    80007c2e:	bd2fe0ef          	jal	80006000 <end_op>
    return -1;
    80007c32:	57fd                	li	a5,-1
    80007c34:	a8ed                	j	80007d2e <sys_open+0x1e2>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80007c36:	801fe0ef          	jal	80006436 <filealloc>
    80007c3a:	fca43c23          	sd	a0,-40(s0)
    80007c3e:	fd843783          	ld	a5,-40(s0)
    80007c42:	cf89                	beqz	a5,80007c5c <sys_open+0x110>
    80007c44:	fd843503          	ld	a0,-40(s0)
    80007c48:	f84ff0ef          	jal	800073cc <fdalloc>
    80007c4c:	87aa                	mv	a5,a0
    80007c4e:	fcf42a23          	sw	a5,-44(s0)
    80007c52:	fd442783          	lw	a5,-44(s0)
    80007c56:	2781                	sext.w	a5,a5
    80007c58:	0207d163          	bgez	a5,80007c7a <sys_open+0x12e>
    if(f)
    80007c5c:	fd843783          	ld	a5,-40(s0)
    80007c60:	c789                	beqz	a5,80007c6a <sys_open+0x11e>
      fileclose(f);
    80007c62:	fd843503          	ld	a0,-40(s0)
    80007c66:	8a3fe0ef          	jal	80006508 <fileclose>
    iunlockput(ip);
    80007c6a:	fe843503          	ld	a0,-24(s0)
    80007c6e:	ce2fd0ef          	jal	80005150 <iunlockput>
    end_op();
    80007c72:	b8efe0ef          	jal	80006000 <end_op>
    return -1;
    80007c76:	57fd                	li	a5,-1
    80007c78:	a85d                	j	80007d2e <sys_open+0x1e2>
  }

  if(ip->type == T_DEVICE){
    80007c7a:	fe843783          	ld	a5,-24(s0)
    80007c7e:	04479703          	lh	a4,68(a5)
    80007c82:	478d                	li	a5,3
    80007c84:	00f71f63          	bne	a4,a5,80007ca2 <sys_open+0x156>
    f->type = FD_DEVICE;
    80007c88:	fd843783          	ld	a5,-40(s0)
    80007c8c:	470d                	li	a4,3
    80007c8e:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80007c90:	fe843783          	ld	a5,-24(s0)
    80007c94:	04679703          	lh	a4,70(a5)
    80007c98:	fd843783          	ld	a5,-40(s0)
    80007c9c:	02e79223          	sh	a4,36(a5)
    80007ca0:	a809                	j	80007cb2 <sys_open+0x166>
  } else {
    f->type = FD_INODE;
    80007ca2:	fd843783          	ld	a5,-40(s0)
    80007ca6:	4709                	li	a4,2
    80007ca8:	c398                	sw	a4,0(a5)
    f->off = 0;
    80007caa:	fd843783          	ld	a5,-40(s0)
    80007cae:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80007cb2:	fd843783          	ld	a5,-40(s0)
    80007cb6:	fe843703          	ld	a4,-24(s0)
    80007cba:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80007cbc:	f4c42783          	lw	a5,-180(s0)
    80007cc0:	8b85                	andi	a5,a5,1
    80007cc2:	2781                	sext.w	a5,a5
    80007cc4:	0017b793          	seqz	a5,a5
    80007cc8:	0ff7f793          	zext.b	a5,a5
    80007ccc:	873e                	mv	a4,a5
    80007cce:	fd843783          	ld	a5,-40(s0)
    80007cd2:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80007cd6:	f4c42783          	lw	a5,-180(s0)
    80007cda:	8b85                	andi	a5,a5,1
    80007cdc:	2781                	sext.w	a5,a5
    80007cde:	e791                	bnez	a5,80007cea <sys_open+0x19e>
    80007ce0:	f4c42783          	lw	a5,-180(s0)
    80007ce4:	8b89                	andi	a5,a5,2
    80007ce6:	2781                	sext.w	a5,a5
    80007ce8:	c399                	beqz	a5,80007cee <sys_open+0x1a2>
    80007cea:	4785                	li	a5,1
    80007cec:	a011                	j	80007cf0 <sys_open+0x1a4>
    80007cee:	4781                	li	a5,0
    80007cf0:	0ff7f713          	zext.b	a4,a5
    80007cf4:	fd843783          	ld	a5,-40(s0)
    80007cf8:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80007cfc:	f4c42783          	lw	a5,-180(s0)
    80007d00:	4007f793          	andi	a5,a5,1024
    80007d04:	2781                	sext.w	a5,a5
    80007d06:	cf81                	beqz	a5,80007d1e <sys_open+0x1d2>
    80007d08:	fe843783          	ld	a5,-24(s0)
    80007d0c:	04479703          	lh	a4,68(a5)
    80007d10:	4789                	li	a5,2
    80007d12:	00f71663          	bne	a4,a5,80007d1e <sys_open+0x1d2>
    itrunc(ip);
    80007d16:	fe843503          	ld	a0,-24(s0)
    80007d1a:	ea4fd0ef          	jal	800053be <itrunc>
  }

  iunlock(ip);
    80007d1e:	fe843503          	ld	a0,-24(s0)
    80007d22:	b32fd0ef          	jal	80005054 <iunlock>
  end_op();
    80007d26:	adafe0ef          	jal	80006000 <end_op>

  return fd;
    80007d2a:	fd442783          	lw	a5,-44(s0)
}
    80007d2e:	853e                	mv	a0,a5
    80007d30:	70ea                	ld	ra,184(sp)
    80007d32:	744a                	ld	s0,176(sp)
    80007d34:	6129                	addi	sp,sp,192
    80007d36:	8082                	ret

0000000080007d38 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80007d38:	7135                	addi	sp,sp,-160
    80007d3a:	ed06                	sd	ra,152(sp)
    80007d3c:	e922                	sd	s0,144(sp)
    80007d3e:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80007d40:	a0efe0ef          	jal	80005f4e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80007d44:	f6840793          	addi	a5,s0,-152
    80007d48:	08000613          	li	a2,128
    80007d4c:	85be                	mv	a1,a5
    80007d4e:	4501                	li	a0,0
    80007d50:	946fc0ef          	jal	80003e96 <argstr>
    80007d54:	87aa                	mv	a5,a0
    80007d56:	0007cf63          	bltz	a5,80007d74 <sys_mkdir+0x3c>
    80007d5a:	f6840793          	addi	a5,s0,-152
    80007d5e:	4681                	li	a3,0
    80007d60:	4601                	li	a2,0
    80007d62:	4585                	li	a1,1
    80007d64:	853e                	mv	a0,a5
    80007d66:	c05ff0ef          	jal	8000796a <create>
    80007d6a:	fea43423          	sd	a0,-24(s0)
    80007d6e:	fe843783          	ld	a5,-24(s0)
    80007d72:	e789                	bnez	a5,80007d7c <sys_mkdir+0x44>
    end_op();
    80007d74:	a8cfe0ef          	jal	80006000 <end_op>
    return -1;
    80007d78:	57fd                	li	a5,-1
    80007d7a:	a801                	j	80007d8a <sys_mkdir+0x52>
  }
  iunlockput(ip);
    80007d7c:	fe843503          	ld	a0,-24(s0)
    80007d80:	bd0fd0ef          	jal	80005150 <iunlockput>
  end_op();
    80007d84:	a7cfe0ef          	jal	80006000 <end_op>
  return 0;
    80007d88:	4781                	li	a5,0
}
    80007d8a:	853e                	mv	a0,a5
    80007d8c:	60ea                	ld	ra,152(sp)
    80007d8e:	644a                	ld	s0,144(sp)
    80007d90:	610d                	addi	sp,sp,160
    80007d92:	8082                	ret

0000000080007d94 <sys_mknod>:

uint64
sys_mknod(void)
{
    80007d94:	7135                	addi	sp,sp,-160
    80007d96:	ed06                	sd	ra,152(sp)
    80007d98:	e922                	sd	s0,144(sp)
    80007d9a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80007d9c:	9b2fe0ef          	jal	80005f4e <begin_op>
  argint(1, &major);
    80007da0:	f6440793          	addi	a5,s0,-156
    80007da4:	85be                	mv	a1,a5
    80007da6:	4505                	li	a0,1
    80007da8:	88efc0ef          	jal	80003e36 <argint>
  argint(2, &minor);
    80007dac:	f6040793          	addi	a5,s0,-160
    80007db0:	85be                	mv	a1,a5
    80007db2:	4509                	li	a0,2
    80007db4:	882fc0ef          	jal	80003e36 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80007db8:	f6840793          	addi	a5,s0,-152
    80007dbc:	08000613          	li	a2,128
    80007dc0:	85be                	mv	a1,a5
    80007dc2:	4501                	li	a0,0
    80007dc4:	8d2fc0ef          	jal	80003e96 <argstr>
    80007dc8:	87aa                	mv	a5,a0
    80007dca:	0207ca63          	bltz	a5,80007dfe <sys_mknod+0x6a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80007dce:	f6442783          	lw	a5,-156(s0)
    80007dd2:	0107971b          	slliw	a4,a5,0x10
    80007dd6:	4107571b          	sraiw	a4,a4,0x10
    80007dda:	f6042783          	lw	a5,-160(s0)
    80007dde:	0107969b          	slliw	a3,a5,0x10
    80007de2:	4106d69b          	sraiw	a3,a3,0x10
    80007de6:	f6840793          	addi	a5,s0,-152
    80007dea:	863a                	mv	a2,a4
    80007dec:	458d                	li	a1,3
    80007dee:	853e                	mv	a0,a5
    80007df0:	b7bff0ef          	jal	8000796a <create>
    80007df4:	fea43423          	sd	a0,-24(s0)
  if((argstr(0, path, MAXPATH)) < 0 ||
    80007df8:	fe843783          	ld	a5,-24(s0)
    80007dfc:	e789                	bnez	a5,80007e06 <sys_mknod+0x72>
    end_op();
    80007dfe:	a02fe0ef          	jal	80006000 <end_op>
    return -1;
    80007e02:	57fd                	li	a5,-1
    80007e04:	a801                	j	80007e14 <sys_mknod+0x80>
  }
  iunlockput(ip);
    80007e06:	fe843503          	ld	a0,-24(s0)
    80007e0a:	b46fd0ef          	jal	80005150 <iunlockput>
  end_op();
    80007e0e:	9f2fe0ef          	jal	80006000 <end_op>
  return 0;
    80007e12:	4781                	li	a5,0
}
    80007e14:	853e                	mv	a0,a5
    80007e16:	60ea                	ld	ra,152(sp)
    80007e18:	644a                	ld	s0,144(sp)
    80007e1a:	610d                	addi	sp,sp,160
    80007e1c:	8082                	ret

0000000080007e1e <sys_chdir>:

uint64
sys_chdir(void)
{
    80007e1e:	7135                	addi	sp,sp,-160
    80007e20:	ed06                	sd	ra,152(sp)
    80007e22:	e922                	sd	s0,144(sp)
    80007e24:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80007e26:	a2ffa0ef          	jal	80002854 <myproc>
    80007e2a:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80007e2e:	920fe0ef          	jal	80005f4e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80007e32:	f6040793          	addi	a5,s0,-160
    80007e36:	08000613          	li	a2,128
    80007e3a:	85be                	mv	a1,a5
    80007e3c:	4501                	li	a0,0
    80007e3e:	858fc0ef          	jal	80003e96 <argstr>
    80007e42:	87aa                	mv	a5,a0
    80007e44:	0007cc63          	bltz	a5,80007e5c <sys_chdir+0x3e>
    80007e48:	f6040793          	addi	a5,s0,-160
    80007e4c:	853e                	mv	a0,a5
    80007e4e:	ddffd0ef          	jal	80005c2c <namei>
    80007e52:	fea43023          	sd	a0,-32(s0)
    80007e56:	fe043783          	ld	a5,-32(s0)
    80007e5a:	e789                	bnez	a5,80007e64 <sys_chdir+0x46>
    end_op();
    80007e5c:	9a4fe0ef          	jal	80006000 <end_op>
    return -1;
    80007e60:	57fd                	li	a5,-1
    80007e62:	a881                	j	80007eb2 <sys_chdir+0x94>
  }
  ilock(ip);
    80007e64:	fe043503          	ld	a0,-32(s0)
    80007e68:	8d0fd0ef          	jal	80004f38 <ilock>
  if(ip->type != T_DIR){
    80007e6c:	fe043783          	ld	a5,-32(s0)
    80007e70:	04479703          	lh	a4,68(a5)
    80007e74:	4785                	li	a5,1
    80007e76:	00f70a63          	beq	a4,a5,80007e8a <sys_chdir+0x6c>
    iunlockput(ip);
    80007e7a:	fe043503          	ld	a0,-32(s0)
    80007e7e:	ad2fd0ef          	jal	80005150 <iunlockput>
    end_op();
    80007e82:	97efe0ef          	jal	80006000 <end_op>
    return -1;
    80007e86:	57fd                	li	a5,-1
    80007e88:	a02d                	j	80007eb2 <sys_chdir+0x94>
  }
  iunlock(ip);
    80007e8a:	fe043503          	ld	a0,-32(s0)
    80007e8e:	9c6fd0ef          	jal	80005054 <iunlock>
  iput(p->cwd);
    80007e92:	fe843783          	ld	a5,-24(s0)
    80007e96:	1507b783          	ld	a5,336(a5)
    80007e9a:	853e                	mv	a0,a5
    80007e9c:	a06fd0ef          	jal	800050a2 <iput>
  end_op();
    80007ea0:	960fe0ef          	jal	80006000 <end_op>
  p->cwd = ip;
    80007ea4:	fe843783          	ld	a5,-24(s0)
    80007ea8:	fe043703          	ld	a4,-32(s0)
    80007eac:	14e7b823          	sd	a4,336(a5)
  return 0;
    80007eb0:	4781                	li	a5,0
}
    80007eb2:	853e                	mv	a0,a5
    80007eb4:	60ea                	ld	ra,152(sp)
    80007eb6:	644a                	ld	s0,144(sp)
    80007eb8:	610d                	addi	sp,sp,160
    80007eba:	8082                	ret

0000000080007ebc <sys_exec>:

uint64
sys_exec(void)
{
    80007ebc:	7161                	addi	sp,sp,-432
    80007ebe:	f706                	sd	ra,424(sp)
    80007ec0:	f322                	sd	s0,416(sp)
    80007ec2:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80007ec4:	e6040793          	addi	a5,s0,-416
    80007ec8:	85be                	mv	a1,a5
    80007eca:	4505                	li	a0,1
    80007ecc:	f9dfb0ef          	jal	80003e68 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80007ed0:	f6840793          	addi	a5,s0,-152
    80007ed4:	08000613          	li	a2,128
    80007ed8:	85be                	mv	a1,a5
    80007eda:	4501                	li	a0,0
    80007edc:	fbbfb0ef          	jal	80003e96 <argstr>
    80007ee0:	87aa                	mv	a5,a0
    80007ee2:	0007d463          	bgez	a5,80007eea <sys_exec+0x2e>
    return -1;
    80007ee6:	57fd                	li	a5,-1
    80007ee8:	aa89                	j	8000803a <sys_exec+0x17e>
  }
  memset(argv, 0, sizeof(argv));
    80007eea:	e6840793          	addi	a5,s0,-408
    80007eee:	10000613          	li	a2,256
    80007ef2:	4581                	li	a1,0
    80007ef4:	853e                	mv	a0,a5
    80007ef6:	de0f90ef          	jal	800014d6 <memset>
  for(i=0;; i++){
    80007efa:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80007efe:	fec42703          	lw	a4,-20(s0)
    80007f02:	47fd                	li	a5,31
    80007f04:	0ee7e463          	bltu	a5,a4,80007fec <sys_exec+0x130>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80007f08:	fec42783          	lw	a5,-20(s0)
    80007f0c:	00379713          	slli	a4,a5,0x3
    80007f10:	e6043783          	ld	a5,-416(s0)
    80007f14:	97ba                	add	a5,a5,a4
    80007f16:	e5840713          	addi	a4,s0,-424
    80007f1a:	85ba                	mv	a1,a4
    80007f1c:	853e                	mv	a0,a5
    80007f1e:	dc3fb0ef          	jal	80003ce0 <fetchaddr>
    80007f22:	87aa                	mv	a5,a0
    80007f24:	0c07c663          	bltz	a5,80007ff0 <sys_exec+0x134>
      goto bad;
    }
    if(uarg == 0){
    80007f28:	e5843783          	ld	a5,-424(s0)
    80007f2c:	eb85                	bnez	a5,80007f5c <sys_exec+0xa0>
      argv[i] = 0;
    80007f2e:	fec42703          	lw	a4,-20(s0)
    80007f32:	e6840793          	addi	a5,s0,-408
    80007f36:	070e                	slli	a4,a4,0x3
    80007f38:	97ba                	add	a5,a5,a4
    80007f3a:	0007b023          	sd	zero,0(a5)
      break;
    80007f3e:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = kexec(path, argv);
    80007f40:	e6840713          	addi	a4,s0,-408
    80007f44:	f6840793          	addi	a5,s0,-152
    80007f48:	85ba                	mv	a1,a4
    80007f4a:	853e                	mv	a0,a5
    80007f4c:	ed5fe0ef          	jal	80006e20 <kexec>
    80007f50:	87aa                	mv	a5,a0
    80007f52:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007f56:	fe042623          	sw	zero,-20(s0)
    80007f5a:	a88d                	j	80007fcc <sys_exec+0x110>
    argv[i] = kalloc();
    80007f5c:	aaef90ef          	jal	8000120a <kalloc>
    80007f60:	86aa                	mv	a3,a0
    80007f62:	fec42703          	lw	a4,-20(s0)
    80007f66:	e6840793          	addi	a5,s0,-408
    80007f6a:	070e                	slli	a4,a4,0x3
    80007f6c:	97ba                	add	a5,a5,a4
    80007f6e:	e394                	sd	a3,0(a5)
    if(argv[i] == 0)
    80007f70:	fec42703          	lw	a4,-20(s0)
    80007f74:	e6840793          	addi	a5,s0,-408
    80007f78:	070e                	slli	a4,a4,0x3
    80007f7a:	97ba                	add	a5,a5,a4
    80007f7c:	639c                	ld	a5,0(a5)
    80007f7e:	cbbd                	beqz	a5,80007ff4 <sys_exec+0x138>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80007f80:	e5843683          	ld	a3,-424(s0)
    80007f84:	fec42703          	lw	a4,-20(s0)
    80007f88:	e6840793          	addi	a5,s0,-408
    80007f8c:	070e                	slli	a4,a4,0x3
    80007f8e:	97ba                	add	a5,a5,a4
    80007f90:	639c                	ld	a5,0(a5)
    80007f92:	6605                	lui	a2,0x1
    80007f94:	85be                	mv	a1,a5
    80007f96:	8536                	mv	a0,a3
    80007f98:	daffb0ef          	jal	80003d46 <fetchstr>
    80007f9c:	87aa                	mv	a5,a0
    80007f9e:	0407cd63          	bltz	a5,80007ff8 <sys_exec+0x13c>
  for(i=0;; i++){
    80007fa2:	fec42783          	lw	a5,-20(s0)
    80007fa6:	2785                	addiw	a5,a5,1
    80007fa8:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    80007fac:	bf89                	j	80007efe <sys_exec+0x42>
    kfree(argv[i]);
    80007fae:	fec42703          	lw	a4,-20(s0)
    80007fb2:	e6840793          	addi	a5,s0,-408
    80007fb6:	070e                	slli	a4,a4,0x3
    80007fb8:	97ba                	add	a5,a5,a4
    80007fba:	639c                	ld	a5,0(a5)
    80007fbc:	853e                	mv	a0,a5
    80007fbe:	9b8f90ef          	jal	80001176 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007fc2:	fec42783          	lw	a5,-20(s0)
    80007fc6:	2785                	addiw	a5,a5,1
    80007fc8:	fef42623          	sw	a5,-20(s0)
    80007fcc:	fec42703          	lw	a4,-20(s0)
    80007fd0:	47fd                	li	a5,31
    80007fd2:	00e7ea63          	bltu	a5,a4,80007fe6 <sys_exec+0x12a>
    80007fd6:	fec42703          	lw	a4,-20(s0)
    80007fda:	e6840793          	addi	a5,s0,-408
    80007fde:	070e                	slli	a4,a4,0x3
    80007fe0:	97ba                	add	a5,a5,a4
    80007fe2:	639c                	ld	a5,0(a5)
    80007fe4:	f7e9                	bnez	a5,80007fae <sys_exec+0xf2>

  return ret;
    80007fe6:	fe842783          	lw	a5,-24(s0)
    80007fea:	a881                	j	8000803a <sys_exec+0x17e>
      goto bad;
    80007fec:	0001                	nop
    80007fee:	a031                	j	80007ffa <sys_exec+0x13e>
      goto bad;
    80007ff0:	0001                	nop
    80007ff2:	a021                	j	80007ffa <sys_exec+0x13e>
      goto bad;
    80007ff4:	0001                	nop
    80007ff6:	a011                	j	80007ffa <sys_exec+0x13e>
      goto bad;
    80007ff8:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007ffa:	fe042623          	sw	zero,-20(s0)
    80007ffe:	a005                	j	8000801e <sys_exec+0x162>
    kfree(argv[i]);
    80008000:	fec42703          	lw	a4,-20(s0)
    80008004:	e6840793          	addi	a5,s0,-408
    80008008:	070e                	slli	a4,a4,0x3
    8000800a:	97ba                	add	a5,a5,a4
    8000800c:	639c                	ld	a5,0(a5)
    8000800e:	853e                	mv	a0,a5
    80008010:	966f90ef          	jal	80001176 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008014:	fec42783          	lw	a5,-20(s0)
    80008018:	2785                	addiw	a5,a5,1
    8000801a:	fef42623          	sw	a5,-20(s0)
    8000801e:	fec42703          	lw	a4,-20(s0)
    80008022:	47fd                	li	a5,31
    80008024:	00e7ea63          	bltu	a5,a4,80008038 <sys_exec+0x17c>
    80008028:	fec42703          	lw	a4,-20(s0)
    8000802c:	e6840793          	addi	a5,s0,-408
    80008030:	070e                	slli	a4,a4,0x3
    80008032:	97ba                	add	a5,a5,a4
    80008034:	639c                	ld	a5,0(a5)
    80008036:	f7e9                	bnez	a5,80008000 <sys_exec+0x144>
  return -1;
    80008038:	57fd                	li	a5,-1
}
    8000803a:	853e                	mv	a0,a5
    8000803c:	70ba                	ld	ra,424(sp)
    8000803e:	741a                	ld	s0,416(sp)
    80008040:	615d                	addi	sp,sp,432
    80008042:	8082                	ret

0000000080008044 <sys_pipe>:

uint64
sys_pipe(void)
{
    80008044:	7139                	addi	sp,sp,-64
    80008046:	fc06                	sd	ra,56(sp)
    80008048:	f822                	sd	s0,48(sp)
    8000804a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000804c:	809fa0ef          	jal	80002854 <myproc>
    80008050:	fea43423          	sd	a0,-24(s0)

  argaddr(0, &fdarray);
    80008054:	fe040793          	addi	a5,s0,-32
    80008058:	85be                	mv	a1,a5
    8000805a:	4501                	li	a0,0
    8000805c:	e0dfb0ef          	jal	80003e68 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80008060:	fd040713          	addi	a4,s0,-48
    80008064:	fd840793          	addi	a5,s0,-40
    80008068:	85ba                	mv	a1,a4
    8000806a:	853e                	mv	a0,a5
    8000806c:	931fe0ef          	jal	8000699c <pipealloc>
    80008070:	87aa                	mv	a5,a0
    80008072:	0007d463          	bgez	a5,8000807a <sys_pipe+0x36>
    return -1;
    80008076:	57fd                	li	a5,-1
    80008078:	a0dd                	j	8000815e <sys_pipe+0x11a>
  fd0 = -1;
    8000807a:	57fd                	li	a5,-1
    8000807c:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80008080:	fd843783          	ld	a5,-40(s0)
    80008084:	853e                	mv	a0,a5
    80008086:	b46ff0ef          	jal	800073cc <fdalloc>
    8000808a:	87aa                	mv	a5,a0
    8000808c:	fcf42623          	sw	a5,-52(s0)
    80008090:	fcc42783          	lw	a5,-52(s0)
    80008094:	0007ce63          	bltz	a5,800080b0 <sys_pipe+0x6c>
    80008098:	fd043783          	ld	a5,-48(s0)
    8000809c:	853e                	mv	a0,a5
    8000809e:	b2eff0ef          	jal	800073cc <fdalloc>
    800080a2:	87aa                	mv	a5,a0
    800080a4:	fcf42423          	sw	a5,-56(s0)
    800080a8:	fc842783          	lw	a5,-56(s0)
    800080ac:	0207db63          	bgez	a5,800080e2 <sys_pipe+0x9e>
    if(fd0 >= 0)
    800080b0:	fcc42783          	lw	a5,-52(s0)
    800080b4:	0007cb63          	bltz	a5,800080ca <sys_pipe+0x86>
      p->ofile[fd0] = 0;
    800080b8:	fcc42783          	lw	a5,-52(s0)
    800080bc:	fe843703          	ld	a4,-24(s0)
    800080c0:	07e9                	addi	a5,a5,26
    800080c2:	078e                	slli	a5,a5,0x3
    800080c4:	97ba                	add	a5,a5,a4
    800080c6:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800080ca:	fd843783          	ld	a5,-40(s0)
    800080ce:	853e                	mv	a0,a5
    800080d0:	c38fe0ef          	jal	80006508 <fileclose>
    fileclose(wf);
    800080d4:	fd043783          	ld	a5,-48(s0)
    800080d8:	853e                	mv	a0,a5
    800080da:	c2efe0ef          	jal	80006508 <fileclose>
    return -1;
    800080de:	57fd                	li	a5,-1
    800080e0:	a8bd                	j	8000815e <sys_pipe+0x11a>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800080e2:	fe843783          	ld	a5,-24(s0)
    800080e6:	6bbc                	ld	a5,80(a5)
    800080e8:	fe043703          	ld	a4,-32(s0)
    800080ec:	fcc40613          	addi	a2,s0,-52
    800080f0:	4691                	li	a3,4
    800080f2:	85ba                	mv	a1,a4
    800080f4:	853e                	mv	a0,a5
    800080f6:	8ecfa0ef          	jal	800021e2 <copyout>
    800080fa:	87aa                	mv	a5,a0
    800080fc:	0207c263          	bltz	a5,80008120 <sys_pipe+0xdc>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008100:	fe843783          	ld	a5,-24(s0)
    80008104:	6bb8                	ld	a4,80(a5)
    80008106:	fe043783          	ld	a5,-32(s0)
    8000810a:	0791                	addi	a5,a5,4
    8000810c:	fc840613          	addi	a2,s0,-56
    80008110:	4691                	li	a3,4
    80008112:	85be                	mv	a1,a5
    80008114:	853a                	mv	a0,a4
    80008116:	8ccfa0ef          	jal	800021e2 <copyout>
    8000811a:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000811c:	0407d063          	bgez	a5,8000815c <sys_pipe+0x118>
    p->ofile[fd0] = 0;
    80008120:	fcc42783          	lw	a5,-52(s0)
    80008124:	fe843703          	ld	a4,-24(s0)
    80008128:	07e9                	addi	a5,a5,26
    8000812a:	078e                	slli	a5,a5,0x3
    8000812c:	97ba                	add	a5,a5,a4
    8000812e:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80008132:	fc842783          	lw	a5,-56(s0)
    80008136:	fe843703          	ld	a4,-24(s0)
    8000813a:	07e9                	addi	a5,a5,26
    8000813c:	078e                	slli	a5,a5,0x3
    8000813e:	97ba                	add	a5,a5,a4
    80008140:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80008144:	fd843783          	ld	a5,-40(s0)
    80008148:	853e                	mv	a0,a5
    8000814a:	bbefe0ef          	jal	80006508 <fileclose>
    fileclose(wf);
    8000814e:	fd043783          	ld	a5,-48(s0)
    80008152:	853e                	mv	a0,a5
    80008154:	bb4fe0ef          	jal	80006508 <fileclose>
    return -1;
    80008158:	57fd                	li	a5,-1
    8000815a:	a011                	j	8000815e <sys_pipe+0x11a>
  }
  return 0;
    8000815c:	4781                	li	a5,0
}
    8000815e:	853e                	mv	a0,a5
    80008160:	70e2                	ld	ra,56(sp)
    80008162:	7442                	ld	s0,48(sp)
    80008164:	6121                	addi	sp,sp,64
    80008166:	8082                	ret
	...

0000000080008170 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80008170:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80008172:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80008174:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80008176:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80008178:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000817a:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000817c:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    8000817e:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80008180:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80008182:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80008184:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80008186:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80008188:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000818a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000818c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000818e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80008190:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80008192:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80008194:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80008196:	977fb0ef          	jal	80003b0c <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000819a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000819c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000819e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    800081a0:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    800081a2:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    800081a4:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    800081a6:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    800081a8:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    800081aa:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    800081ac:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    800081ae:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    800081b0:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    800081b2:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    800081b4:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    800081b6:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    800081b8:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    800081ba:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    800081bc:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    800081be:	10200073          	sret
	...

00000000800081ce <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800081ce:	1141                	addi	sp,sp,-16
    800081d0:	e406                	sd	ra,8(sp)
    800081d2:	e022                	sd	s0,0(sp)
    800081d4:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800081d6:	0c0007b7          	lui	a5,0xc000
    800081da:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    800081de:	4705                	li	a4,1
    800081e0:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800081e2:	0c0007b7          	lui	a5,0xc000
    800081e6:	0791                	addi	a5,a5,4 # c000004 <_entry-0x73fffffc>
    800081e8:	4705                	li	a4,1
    800081ea:	c398                	sw	a4,0(a5)
}
    800081ec:	0001                	nop
    800081ee:	60a2                	ld	ra,8(sp)
    800081f0:	6402                	ld	s0,0(sp)
    800081f2:	0141                	addi	sp,sp,16
    800081f4:	8082                	ret

00000000800081f6 <plicinithart>:

void
plicinithart(void)
{
    800081f6:	1101                	addi	sp,sp,-32
    800081f8:	ec06                	sd	ra,24(sp)
    800081fa:	e822                	sd	s0,16(sp)
    800081fc:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800081fe:	e00fa0ef          	jal	800027fe <cpuid>
    80008202:	87aa                	mv	a5,a0
    80008204:	fef42623          	sw	a5,-20(s0)
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80008208:	fec42783          	lw	a5,-20(s0)
    8000820c:	0087979b          	slliw	a5,a5,0x8
    80008210:	2781                	sext.w	a5,a5
    80008212:	873e                	mv	a4,a5
    80008214:	0c0027b7          	lui	a5,0xc002
    80008218:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    8000821c:	97ba                	add	a5,a5,a4
    8000821e:	873e                	mv	a4,a5
    80008220:	40200793          	li	a5,1026
    80008224:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80008226:	fec42783          	lw	a5,-20(s0)
    8000822a:	00d7979b          	slliw	a5,a5,0xd
    8000822e:	2781                	sext.w	a5,a5
    80008230:	873e                	mv	a4,a5
    80008232:	0c2017b7          	lui	a5,0xc201
    80008236:	97ba                	add	a5,a5,a4
    80008238:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    8000823c:	0001                	nop
    8000823e:	60e2                	ld	ra,24(sp)
    80008240:	6442                	ld	s0,16(sp)
    80008242:	6105                	addi	sp,sp,32
    80008244:	8082                	ret

0000000080008246 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80008246:	1101                	addi	sp,sp,-32
    80008248:	ec06                	sd	ra,24(sp)
    8000824a:	e822                	sd	s0,16(sp)
    8000824c:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000824e:	db0fa0ef          	jal	800027fe <cpuid>
    80008252:	87aa                	mv	a5,a0
    80008254:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80008258:	fec42783          	lw	a5,-20(s0)
    8000825c:	00d7979b          	slliw	a5,a5,0xd
    80008260:	2781                	sext.w	a5,a5
    80008262:	873e                	mv	a4,a5
    80008264:	0c2017b7          	lui	a5,0xc201
    80008268:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    8000826a:	97ba                	add	a5,a5,a4
    8000826c:	439c                	lw	a5,0(a5)
    8000826e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80008272:	fe842783          	lw	a5,-24(s0)
}
    80008276:	853e                	mv	a0,a5
    80008278:	60e2                	ld	ra,24(sp)
    8000827a:	6442                	ld	s0,16(sp)
    8000827c:	6105                	addi	sp,sp,32
    8000827e:	8082                	ret

0000000080008280 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80008280:	7179                	addi	sp,sp,-48
    80008282:	f406                	sd	ra,40(sp)
    80008284:	f022                	sd	s0,32(sp)
    80008286:	1800                	addi	s0,sp,48
    80008288:	87aa                	mv	a5,a0
    8000828a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    8000828e:	d70fa0ef          	jal	800027fe <cpuid>
    80008292:	87aa                	mv	a5,a0
    80008294:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80008298:	fec42783          	lw	a5,-20(s0)
    8000829c:	00d7979b          	slliw	a5,a5,0xd
    800082a0:	2781                	sext.w	a5,a5
    800082a2:	873e                	mv	a4,a5
    800082a4:	0c2017b7          	lui	a5,0xc201
    800082a8:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    800082aa:	97ba                	add	a5,a5,a4
    800082ac:	873e                	mv	a4,a5
    800082ae:	fdc42783          	lw	a5,-36(s0)
    800082b2:	c31c                	sw	a5,0(a4)
}
    800082b4:	0001                	nop
    800082b6:	70a2                	ld	ra,40(sp)
    800082b8:	7402                	ld	s0,32(sp)
    800082ba:	6145                	addi	sp,sp,48
    800082bc:	8082                	ret

00000000800082be <virtio_disk_init>:
  
} disk;

void
virtio_disk_init(void)
{
    800082be:	7179                	addi	sp,sp,-48
    800082c0:	f406                	sd	ra,40(sp)
    800082c2:	f022                	sd	s0,32(sp)
    800082c4:	1800                	addi	s0,sp,48
  uint32 status = 0;
    800082c6:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    800082ca:	00002597          	auipc	a1,0x2
    800082ce:	3fe58593          	addi	a1,a1,1022 # 8000a6c8 <etext+0x6c8>
    800082d2:	0001c517          	auipc	a0,0x1c
    800082d6:	96e50513          	addi	a0,a0,-1682 # 80023c40 <disk+0x128>
    800082da:	83cf90ef          	jal	80001316 <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800082de:	100017b7          	lui	a5,0x10001
    800082e2:	439c                	lw	a5,0(a5)
    800082e4:	0007871b          	sext.w	a4,a5
    800082e8:	747277b7          	lui	a5,0x74727
    800082ec:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800082f0:	04f71063          	bne	a4,a5,80008330 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800082f4:	100017b7          	lui	a5,0x10001
    800082f8:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    800082fa:	439c                	lw	a5,0(a5)
    800082fc:	0007871b          	sext.w	a4,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008300:	4789                	li	a5,2
    80008302:	02f71763          	bne	a4,a5,80008330 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008306:	100017b7          	lui	a5,0x10001
    8000830a:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    8000830c:	439c                	lw	a5,0(a5)
    8000830e:	0007871b          	sext.w	a4,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80008312:	4789                	li	a5,2
    80008314:	00f71e63          	bne	a4,a5,80008330 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008318:	100017b7          	lui	a5,0x10001
    8000831c:	07b1                	addi	a5,a5,12 # 1000100c <_entry-0x6fffeff4>
    8000831e:	439c                	lw	a5,0(a5)
    80008320:	0007871b          	sext.w	a4,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008324:	554d47b7          	lui	a5,0x554d4
    80008328:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000832c:	00f70863          	beq	a4,a5,8000833c <virtio_disk_init+0x7e>
    panic("could not find virtio disk");
    80008330:	00002517          	auipc	a0,0x2
    80008334:	3a850513          	addi	a0,a0,936 # 8000a6d8 <etext+0x6d8>
    80008338:	afff80ef          	jal	80000e36 <panic>
  }
  
  // reset device
  *R(VIRTIO_MMIO_STATUS) = status;
    8000833c:	100017b7          	lui	a5,0x10001
    80008340:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008344:	fe842703          	lw	a4,-24(s0)
    80008348:	c398                	sw	a4,0(a5)

  // set ACKNOWLEDGE status bit
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    8000834a:	fe842783          	lw	a5,-24(s0)
    8000834e:	0017e793          	ori	a5,a5,1
    80008352:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008356:	100017b7          	lui	a5,0x10001
    8000835a:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000835e:	fe842703          	lw	a4,-24(s0)
    80008362:	c398                	sw	a4,0(a5)

  // set DRIVER status bit
  status |= VIRTIO_CONFIG_S_DRIVER;
    80008364:	fe842783          	lw	a5,-24(s0)
    80008368:	0027e793          	ori	a5,a5,2
    8000836c:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008370:	100017b7          	lui	a5,0x10001
    80008374:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008378:	fe842703          	lw	a4,-24(s0)
    8000837c:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000837e:	100017b7          	lui	a5,0x10001
    80008382:	07c1                	addi	a5,a5,16 # 10001010 <_entry-0x6fffeff0>
    80008384:	439c                	lw	a5,0(a5)
    80008386:	2781                	sext.w	a5,a5
    80008388:	1782                	slli	a5,a5,0x20
    8000838a:	9381                	srli	a5,a5,0x20
    8000838c:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    80008390:	fe043783          	ld	a5,-32(s0)
    80008394:	fdf7f793          	andi	a5,a5,-33
    80008398:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    8000839c:	fe043783          	ld	a5,-32(s0)
    800083a0:	f7f7f793          	andi	a5,a5,-129
    800083a4:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    800083a8:	fe043703          	ld	a4,-32(s0)
    800083ac:	77fd                	lui	a5,0xfffff
    800083ae:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffdbba7>
    800083b2:	8ff9                	and	a5,a5,a4
    800083b4:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    800083b8:	fe043703          	ld	a4,-32(s0)
    800083bc:	77fd                	lui	a5,0xfffff
    800083be:	17fd                	addi	a5,a5,-1 # ffffffffffffefff <end+0xffffffff7ffdb3a7>
    800083c0:	8ff9                	and	a5,a5,a4
    800083c2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    800083c6:	fe043703          	ld	a4,-32(s0)
    800083ca:	f80007b7          	lui	a5,0xf8000
    800083ce:	17fd                	addi	a5,a5,-1 # fffffffff7ffffff <end+0xffffffff77fdc3a7>
    800083d0:	8ff9                	and	a5,a5,a4
    800083d2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    800083d6:	fe043703          	ld	a4,-32(s0)
    800083da:	e00007b7          	lui	a5,0xe0000
    800083de:	17fd                	addi	a5,a5,-1 # ffffffffdfffffff <end+0xffffffff5ffdc3a7>
    800083e0:	8ff9                	and	a5,a5,a4
    800083e2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800083e6:	fe043703          	ld	a4,-32(s0)
    800083ea:	f00007b7          	lui	a5,0xf0000
    800083ee:	17fd                	addi	a5,a5,-1 # ffffffffefffffff <end+0xffffffff6ffdc3a7>
    800083f0:	8ff9                	and	a5,a5,a4
    800083f2:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800083f6:	100017b7          	lui	a5,0x10001
    800083fa:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    800083fe:	fe043703          	ld	a4,-32(s0)
    80008402:	2701                	sext.w	a4,a4
    80008404:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008406:	fe842783          	lw	a5,-24(s0)
    8000840a:	0087e793          	ori	a5,a5,8
    8000840e:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008412:	100017b7          	lui	a5,0x10001
    80008416:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000841a:	fe842703          	lw	a4,-24(s0)
    8000841e:	c398                	sw	a4,0(a5)

  // re-read status to ensure FEATURES_OK is set.
  status = *R(VIRTIO_MMIO_STATUS);
    80008420:	100017b7          	lui	a5,0x10001
    80008424:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008428:	439c                	lw	a5,0(a5)
    8000842a:	fef42423          	sw	a5,-24(s0)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    8000842e:	fe842783          	lw	a5,-24(s0)
    80008432:	8ba1                	andi	a5,a5,8
    80008434:	2781                	sext.w	a5,a5
    80008436:	e799                	bnez	a5,80008444 <virtio_disk_init+0x186>
    panic("virtio disk FEATURES_OK unset");
    80008438:	00002517          	auipc	a0,0x2
    8000843c:	2c050513          	addi	a0,a0,704 # 8000a6f8 <etext+0x6f8>
    80008440:	9f7f80ef          	jal	80000e36 <panic>

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80008444:	100017b7          	lui	a5,0x10001
    80008448:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    8000844c:	0007a023          	sw	zero,0(a5)

  // ensure queue 0 is not in use.
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80008450:	100017b7          	lui	a5,0x10001
    80008454:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    80008458:	439c                	lw	a5,0(a5)
    8000845a:	2781                	sext.w	a5,a5
    8000845c:	c799                	beqz	a5,8000846a <virtio_disk_init+0x1ac>
    panic("virtio disk should not be ready");
    8000845e:	00002517          	auipc	a0,0x2
    80008462:	2ba50513          	addi	a0,a0,698 # 8000a718 <etext+0x718>
    80008466:	9d1f80ef          	jal	80000e36 <panic>

  // check maximum queue size.
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    8000846a:	100017b7          	lui	a5,0x10001
    8000846e:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80008472:	439c                	lw	a5,0(a5)
    80008474:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80008478:	fdc42783          	lw	a5,-36(s0)
    8000847c:	2781                	sext.w	a5,a5
    8000847e:	e799                	bnez	a5,8000848c <virtio_disk_init+0x1ce>
    panic("virtio disk has no queue 0");
    80008480:	00002517          	auipc	a0,0x2
    80008484:	2b850513          	addi	a0,a0,696 # 8000a738 <etext+0x738>
    80008488:	9aff80ef          	jal	80000e36 <panic>
  if(max < NUM)
    8000848c:	fdc42783          	lw	a5,-36(s0)
    80008490:	0007871b          	sext.w	a4,a5
    80008494:	479d                	li	a5,7
    80008496:	00e7e863          	bltu	a5,a4,800084a6 <virtio_disk_init+0x1e8>
    panic("virtio disk max queue too short");
    8000849a:	00002517          	auipc	a0,0x2
    8000849e:	2be50513          	addi	a0,a0,702 # 8000a758 <etext+0x758>
    800084a2:	995f80ef          	jal	80000e36 <panic>

  // allocate and zero queue memory.
  disk.desc = kalloc();
    800084a6:	d65f80ef          	jal	8000120a <kalloc>
    800084aa:	872a                	mv	a4,a0
    800084ac:	0001b797          	auipc	a5,0x1b
    800084b0:	66c78793          	addi	a5,a5,1644 # 80023b18 <disk>
    800084b4:	e398                	sd	a4,0(a5)
  disk.avail = kalloc();
    800084b6:	d55f80ef          	jal	8000120a <kalloc>
    800084ba:	872a                	mv	a4,a0
    800084bc:	0001b797          	auipc	a5,0x1b
    800084c0:	65c78793          	addi	a5,a5,1628 # 80023b18 <disk>
    800084c4:	e798                	sd	a4,8(a5)
  disk.used = kalloc();
    800084c6:	d45f80ef          	jal	8000120a <kalloc>
    800084ca:	872a                	mv	a4,a0
    800084cc:	0001b797          	auipc	a5,0x1b
    800084d0:	64c78793          	addi	a5,a5,1612 # 80023b18 <disk>
    800084d4:	eb98                	sd	a4,16(a5)
  if(!disk.desc || !disk.avail || !disk.used)
    800084d6:	0001b797          	auipc	a5,0x1b
    800084da:	64278793          	addi	a5,a5,1602 # 80023b18 <disk>
    800084de:	639c                	ld	a5,0(a5)
    800084e0:	cf89                	beqz	a5,800084fa <virtio_disk_init+0x23c>
    800084e2:	0001b797          	auipc	a5,0x1b
    800084e6:	63678793          	addi	a5,a5,1590 # 80023b18 <disk>
    800084ea:	679c                	ld	a5,8(a5)
    800084ec:	c799                	beqz	a5,800084fa <virtio_disk_init+0x23c>
    800084ee:	0001b797          	auipc	a5,0x1b
    800084f2:	62a78793          	addi	a5,a5,1578 # 80023b18 <disk>
    800084f6:	6b9c                	ld	a5,16(a5)
    800084f8:	e799                	bnez	a5,80008506 <virtio_disk_init+0x248>
    panic("virtio disk kalloc");
    800084fa:	00002517          	auipc	a0,0x2
    800084fe:	27e50513          	addi	a0,a0,638 # 8000a778 <etext+0x778>
    80008502:	935f80ef          	jal	80000e36 <panic>
  memset(disk.desc, 0, PGSIZE);
    80008506:	0001b797          	auipc	a5,0x1b
    8000850a:	61278793          	addi	a5,a5,1554 # 80023b18 <disk>
    8000850e:	639c                	ld	a5,0(a5)
    80008510:	6605                	lui	a2,0x1
    80008512:	4581                	li	a1,0
    80008514:	853e                	mv	a0,a5
    80008516:	fc1f80ef          	jal	800014d6 <memset>
  memset(disk.avail, 0, PGSIZE);
    8000851a:	0001b797          	auipc	a5,0x1b
    8000851e:	5fe78793          	addi	a5,a5,1534 # 80023b18 <disk>
    80008522:	679c                	ld	a5,8(a5)
    80008524:	6605                	lui	a2,0x1
    80008526:	4581                	li	a1,0
    80008528:	853e                	mv	a0,a5
    8000852a:	fadf80ef          	jal	800014d6 <memset>
  memset(disk.used, 0, PGSIZE);
    8000852e:	0001b797          	auipc	a5,0x1b
    80008532:	5ea78793          	addi	a5,a5,1514 # 80023b18 <disk>
    80008536:	6b9c                	ld	a5,16(a5)
    80008538:	6605                	lui	a2,0x1
    8000853a:	4581                	li	a1,0
    8000853c:	853e                	mv	a0,a5
    8000853e:	f99f80ef          	jal	800014d6 <memset>

  // set queue size.
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80008542:	100017b7          	lui	a5,0x10001
    80008546:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    8000854a:	4721                	li	a4,8
    8000854c:	c398                	sw	a4,0(a5)

  // write physical addresses.
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000854e:	0001b797          	auipc	a5,0x1b
    80008552:	5ca78793          	addi	a5,a5,1482 # 80023b18 <disk>
    80008556:	639c                	ld	a5,0(a5)
    80008558:	873e                	mv	a4,a5
    8000855a:	100017b7          	lui	a5,0x10001
    8000855e:	08078793          	addi	a5,a5,128 # 10001080 <_entry-0x6fffef80>
    80008562:	2701                	sext.w	a4,a4
    80008564:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80008566:	0001b797          	auipc	a5,0x1b
    8000856a:	5b278793          	addi	a5,a5,1458 # 80023b18 <disk>
    8000856e:	639c                	ld	a5,0(a5)
    80008570:	0207d713          	srli	a4,a5,0x20
    80008574:	100017b7          	lui	a5,0x10001
    80008578:	08478793          	addi	a5,a5,132 # 10001084 <_entry-0x6fffef7c>
    8000857c:	2701                	sext.w	a4,a4
    8000857e:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80008580:	0001b797          	auipc	a5,0x1b
    80008584:	59878793          	addi	a5,a5,1432 # 80023b18 <disk>
    80008588:	679c                	ld	a5,8(a5)
    8000858a:	873e                	mv	a4,a5
    8000858c:	100017b7          	lui	a5,0x10001
    80008590:	09078793          	addi	a5,a5,144 # 10001090 <_entry-0x6fffef70>
    80008594:	2701                	sext.w	a4,a4
    80008596:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80008598:	0001b797          	auipc	a5,0x1b
    8000859c:	58078793          	addi	a5,a5,1408 # 80023b18 <disk>
    800085a0:	679c                	ld	a5,8(a5)
    800085a2:	0207d713          	srli	a4,a5,0x20
    800085a6:	100017b7          	lui	a5,0x10001
    800085aa:	09478793          	addi	a5,a5,148 # 10001094 <_entry-0x6fffef6c>
    800085ae:	2701                	sext.w	a4,a4
    800085b0:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800085b2:	0001b797          	auipc	a5,0x1b
    800085b6:	56678793          	addi	a5,a5,1382 # 80023b18 <disk>
    800085ba:	6b9c                	ld	a5,16(a5)
    800085bc:	873e                	mv	a4,a5
    800085be:	100017b7          	lui	a5,0x10001
    800085c2:	0a078793          	addi	a5,a5,160 # 100010a0 <_entry-0x6fffef60>
    800085c6:	2701                	sext.w	a4,a4
    800085c8:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800085ca:	0001b797          	auipc	a5,0x1b
    800085ce:	54e78793          	addi	a5,a5,1358 # 80023b18 <disk>
    800085d2:	6b9c                	ld	a5,16(a5)
    800085d4:	0207d713          	srli	a4,a5,0x20
    800085d8:	100017b7          	lui	a5,0x10001
    800085dc:	0a478793          	addi	a5,a5,164 # 100010a4 <_entry-0x6fffef5c>
    800085e0:	2701                	sext.w	a4,a4
    800085e2:	c398                	sw	a4,0(a5)

  // queue is ready.
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800085e4:	100017b7          	lui	a5,0x10001
    800085e8:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    800085ec:	4705                	li	a4,1
    800085ee:	c398                	sw	a4,0(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    800085f0:	fe042623          	sw	zero,-20(s0)
    800085f4:	a005                	j	80008614 <virtio_disk_init+0x356>
    disk.free[i] = 1;
    800085f6:	0001b717          	auipc	a4,0x1b
    800085fa:	52270713          	addi	a4,a4,1314 # 80023b18 <disk>
    800085fe:	fec42783          	lw	a5,-20(s0)
    80008602:	97ba                	add	a5,a5,a4
    80008604:	4705                	li	a4,1
    80008606:	00e78c23          	sb	a4,24(a5)
  for(int i = 0; i < NUM; i++)
    8000860a:	fec42783          	lw	a5,-20(s0)
    8000860e:	2785                	addiw	a5,a5,1
    80008610:	fef42623          	sw	a5,-20(s0)
    80008614:	fec42783          	lw	a5,-20(s0)
    80008618:	0007871b          	sext.w	a4,a5
    8000861c:	479d                	li	a5,7
    8000861e:	fce7dce3          	bge	a5,a4,800085f6 <virtio_disk_init+0x338>

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80008622:	fe842783          	lw	a5,-24(s0)
    80008626:	0047e793          	ori	a5,a5,4
    8000862a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000862e:	100017b7          	lui	a5,0x10001
    80008632:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008636:	fe842703          	lw	a4,-24(s0)
    8000863a:	c398                	sw	a4,0(a5)

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    8000863c:	0001                	nop
    8000863e:	70a2                	ld	ra,40(sp)
    80008640:	7402                	ld	s0,32(sp)
    80008642:	6145                	addi	sp,sp,48
    80008644:	8082                	ret

0000000080008646 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80008646:	1101                	addi	sp,sp,-32
    80008648:	ec06                	sd	ra,24(sp)
    8000864a:	e822                	sd	s0,16(sp)
    8000864c:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    8000864e:	fe042623          	sw	zero,-20(s0)
    80008652:	a825                	j	8000868a <alloc_desc+0x44>
    if(disk.free[i]){
    80008654:	0001b717          	auipc	a4,0x1b
    80008658:	4c470713          	addi	a4,a4,1220 # 80023b18 <disk>
    8000865c:	fec42783          	lw	a5,-20(s0)
    80008660:	97ba                	add	a5,a5,a4
    80008662:	0187c783          	lbu	a5,24(a5)
    80008666:	cf89                	beqz	a5,80008680 <alloc_desc+0x3a>
      disk.free[i] = 0;
    80008668:	0001b717          	auipc	a4,0x1b
    8000866c:	4b070713          	addi	a4,a4,1200 # 80023b18 <disk>
    80008670:	fec42783          	lw	a5,-20(s0)
    80008674:	97ba                	add	a5,a5,a4
    80008676:	00078c23          	sb	zero,24(a5)
      return i;
    8000867a:	fec42783          	lw	a5,-20(s0)
    8000867e:	a831                	j	8000869a <alloc_desc+0x54>
  for(int i = 0; i < NUM; i++){
    80008680:	fec42783          	lw	a5,-20(s0)
    80008684:	2785                	addiw	a5,a5,1
    80008686:	fef42623          	sw	a5,-20(s0)
    8000868a:	fec42783          	lw	a5,-20(s0)
    8000868e:	0007871b          	sext.w	a4,a5
    80008692:	479d                	li	a5,7
    80008694:	fce7d0e3          	bge	a5,a4,80008654 <alloc_desc+0xe>
    }
  }
  return -1;
    80008698:	57fd                	li	a5,-1
}
    8000869a:	853e                	mv	a0,a5
    8000869c:	60e2                	ld	ra,24(sp)
    8000869e:	6442                	ld	s0,16(sp)
    800086a0:	6105                	addi	sp,sp,32
    800086a2:	8082                	ret

00000000800086a4 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    800086a4:	1101                	addi	sp,sp,-32
    800086a6:	ec06                	sd	ra,24(sp)
    800086a8:	e822                	sd	s0,16(sp)
    800086aa:	1000                	addi	s0,sp,32
    800086ac:	87aa                	mv	a5,a0
    800086ae:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    800086b2:	fec42783          	lw	a5,-20(s0)
    800086b6:	0007871b          	sext.w	a4,a5
    800086ba:	479d                	li	a5,7
    800086bc:	00e7d863          	bge	a5,a4,800086cc <free_desc+0x28>
    panic("free_desc 1");
    800086c0:	00002517          	auipc	a0,0x2
    800086c4:	0d050513          	addi	a0,a0,208 # 8000a790 <etext+0x790>
    800086c8:	f6ef80ef          	jal	80000e36 <panic>
  if(disk.free[i])
    800086cc:	0001b717          	auipc	a4,0x1b
    800086d0:	44c70713          	addi	a4,a4,1100 # 80023b18 <disk>
    800086d4:	fec42783          	lw	a5,-20(s0)
    800086d8:	97ba                	add	a5,a5,a4
    800086da:	0187c783          	lbu	a5,24(a5)
    800086de:	c799                	beqz	a5,800086ec <free_desc+0x48>
    panic("free_desc 2");
    800086e0:	00002517          	auipc	a0,0x2
    800086e4:	0c050513          	addi	a0,a0,192 # 8000a7a0 <etext+0x7a0>
    800086e8:	f4ef80ef          	jal	80000e36 <panic>
  disk.desc[i].addr = 0;
    800086ec:	0001b797          	auipc	a5,0x1b
    800086f0:	42c78793          	addi	a5,a5,1068 # 80023b18 <disk>
    800086f4:	6398                	ld	a4,0(a5)
    800086f6:	fec42783          	lw	a5,-20(s0)
    800086fa:	0792                	slli	a5,a5,0x4
    800086fc:	97ba                	add	a5,a5,a4
    800086fe:	0007b023          	sd	zero,0(a5)
  disk.desc[i].len = 0;
    80008702:	0001b797          	auipc	a5,0x1b
    80008706:	41678793          	addi	a5,a5,1046 # 80023b18 <disk>
    8000870a:	6398                	ld	a4,0(a5)
    8000870c:	fec42783          	lw	a5,-20(s0)
    80008710:	0792                	slli	a5,a5,0x4
    80008712:	97ba                	add	a5,a5,a4
    80008714:	0007a423          	sw	zero,8(a5)
  disk.desc[i].flags = 0;
    80008718:	0001b797          	auipc	a5,0x1b
    8000871c:	40078793          	addi	a5,a5,1024 # 80023b18 <disk>
    80008720:	6398                	ld	a4,0(a5)
    80008722:	fec42783          	lw	a5,-20(s0)
    80008726:	0792                	slli	a5,a5,0x4
    80008728:	97ba                	add	a5,a5,a4
    8000872a:	00079623          	sh	zero,12(a5)
  disk.desc[i].next = 0;
    8000872e:	0001b797          	auipc	a5,0x1b
    80008732:	3ea78793          	addi	a5,a5,1002 # 80023b18 <disk>
    80008736:	6398                	ld	a4,0(a5)
    80008738:	fec42783          	lw	a5,-20(s0)
    8000873c:	0792                	slli	a5,a5,0x4
    8000873e:	97ba                	add	a5,a5,a4
    80008740:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80008744:	0001b717          	auipc	a4,0x1b
    80008748:	3d470713          	addi	a4,a4,980 # 80023b18 <disk>
    8000874c:	fec42783          	lw	a5,-20(s0)
    80008750:	97ba                	add	a5,a5,a4
    80008752:	4705                	li	a4,1
    80008754:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80008758:	0001b517          	auipc	a0,0x1b
    8000875c:	3d850513          	addi	a0,a0,984 # 80023b30 <disk+0x18>
    80008760:	bfbfa0ef          	jal	8000335a <wakeup>
}
    80008764:	0001                	nop
    80008766:	60e2                	ld	ra,24(sp)
    80008768:	6442                	ld	s0,16(sp)
    8000876a:	6105                	addi	sp,sp,32
    8000876c:	8082                	ret

000000008000876e <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    8000876e:	7179                	addi	sp,sp,-48
    80008770:	f406                	sd	ra,40(sp)
    80008772:	f022                	sd	s0,32(sp)
    80008774:	1800                	addi	s0,sp,48
    80008776:	87aa                	mv	a5,a0
    80008778:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    8000877c:	0001b797          	auipc	a5,0x1b
    80008780:	39c78793          	addi	a5,a5,924 # 80023b18 <disk>
    80008784:	6398                	ld	a4,0(a5)
    80008786:	fdc42783          	lw	a5,-36(s0)
    8000878a:	0792                	slli	a5,a5,0x4
    8000878c:	97ba                	add	a5,a5,a4
    8000878e:	00c7d783          	lhu	a5,12(a5)
    80008792:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    80008796:	0001b797          	auipc	a5,0x1b
    8000879a:	38278793          	addi	a5,a5,898 # 80023b18 <disk>
    8000879e:	6398                	ld	a4,0(a5)
    800087a0:	fdc42783          	lw	a5,-36(s0)
    800087a4:	0792                	slli	a5,a5,0x4
    800087a6:	97ba                	add	a5,a5,a4
    800087a8:	00e7d783          	lhu	a5,14(a5)
    800087ac:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    800087b0:	fdc42783          	lw	a5,-36(s0)
    800087b4:	853e                	mv	a0,a5
    800087b6:	eefff0ef          	jal	800086a4 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800087ba:	fec42783          	lw	a5,-20(s0)
    800087be:	8b85                	andi	a5,a5,1
    800087c0:	2781                	sext.w	a5,a5
    800087c2:	c791                	beqz	a5,800087ce <free_chain+0x60>
      i = nxt;
    800087c4:	fe842783          	lw	a5,-24(s0)
    800087c8:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    800087cc:	bf45                	j	8000877c <free_chain+0xe>
    else
      break;
    800087ce:	0001                	nop
  }
}
    800087d0:	0001                	nop
    800087d2:	70a2                	ld	ra,40(sp)
    800087d4:	7402                	ld	s0,32(sp)
    800087d6:	6145                	addi	sp,sp,48
    800087d8:	8082                	ret

00000000800087da <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    800087da:	7139                	addi	sp,sp,-64
    800087dc:	fc06                	sd	ra,56(sp)
    800087de:	f822                	sd	s0,48(sp)
    800087e0:	f426                	sd	s1,40(sp)
    800087e2:	0080                	addi	s0,sp,64
    800087e4:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    800087e8:	fc042e23          	sw	zero,-36(s0)
    800087ec:	a0bd                	j	8000885a <alloc3_desc+0x80>
    idx[i] = alloc_desc();
    800087ee:	fdc42783          	lw	a5,-36(s0)
    800087f2:	078a                	slli	a5,a5,0x2
    800087f4:	fc843703          	ld	a4,-56(s0)
    800087f8:	00f704b3          	add	s1,a4,a5
    800087fc:	e4bff0ef          	jal	80008646 <alloc_desc>
    80008800:	87aa                	mv	a5,a0
    80008802:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80008804:	fdc42783          	lw	a5,-36(s0)
    80008808:	078a                	slli	a5,a5,0x2
    8000880a:	fc843703          	ld	a4,-56(s0)
    8000880e:	97ba                	add	a5,a5,a4
    80008810:	439c                	lw	a5,0(a5)
    80008812:	0207df63          	bgez	a5,80008850 <alloc3_desc+0x76>
      for(int j = 0; j < i; j++)
    80008816:	fc042c23          	sw	zero,-40(s0)
    8000881a:	a005                	j	8000883a <alloc3_desc+0x60>
        free_desc(idx[j]);
    8000881c:	fd842783          	lw	a5,-40(s0)
    80008820:	078a                	slli	a5,a5,0x2
    80008822:	fc843703          	ld	a4,-56(s0)
    80008826:	97ba                	add	a5,a5,a4
    80008828:	439c                	lw	a5,0(a5)
    8000882a:	853e                	mv	a0,a5
    8000882c:	e79ff0ef          	jal	800086a4 <free_desc>
      for(int j = 0; j < i; j++)
    80008830:	fd842783          	lw	a5,-40(s0)
    80008834:	2785                	addiw	a5,a5,1
    80008836:	fcf42c23          	sw	a5,-40(s0)
    8000883a:	fd842783          	lw	a5,-40(s0)
    8000883e:	873e                	mv	a4,a5
    80008840:	fdc42783          	lw	a5,-36(s0)
    80008844:	2701                	sext.w	a4,a4
    80008846:	2781                	sext.w	a5,a5
    80008848:	fcf74ae3          	blt	a4,a5,8000881c <alloc3_desc+0x42>
      return -1;
    8000884c:	57fd                	li	a5,-1
    8000884e:	a831                	j	8000886a <alloc3_desc+0x90>
  for(int i = 0; i < 3; i++){
    80008850:	fdc42783          	lw	a5,-36(s0)
    80008854:	2785                	addiw	a5,a5,1
    80008856:	fcf42e23          	sw	a5,-36(s0)
    8000885a:	fdc42783          	lw	a5,-36(s0)
    8000885e:	0007871b          	sext.w	a4,a5
    80008862:	4789                	li	a5,2
    80008864:	f8e7d5e3          	bge	a5,a4,800087ee <alloc3_desc+0x14>
    }
  }
  return 0;
    80008868:	4781                	li	a5,0
}
    8000886a:	853e                	mv	a0,a5
    8000886c:	70e2                	ld	ra,56(sp)
    8000886e:	7442                	ld	s0,48(sp)
    80008870:	74a2                	ld	s1,40(sp)
    80008872:	6121                	addi	sp,sp,64
    80008874:	8082                	ret

0000000080008876 <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    80008876:	7139                	addi	sp,sp,-64
    80008878:	fc06                	sd	ra,56(sp)
    8000887a:	f822                	sd	s0,48(sp)
    8000887c:	0080                	addi	s0,sp,64
    8000887e:	fca43423          	sd	a0,-56(s0)
    80008882:	87ae                	mv	a5,a1
    80008884:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    80008888:	fc843783          	ld	a5,-56(s0)
    8000888c:	47dc                	lw	a5,12(a5)
    8000888e:	0017979b          	slliw	a5,a5,0x1
    80008892:	2781                	sext.w	a5,a5
    80008894:	1782                	slli	a5,a5,0x20
    80008896:	9381                	srli	a5,a5,0x20
    80008898:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    8000889c:	0001b517          	auipc	a0,0x1b
    800088a0:	3a450513          	addi	a0,a0,932 # 80023c40 <disk+0x128>
    800088a4:	aa7f80ef          	jal	8000134a <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    800088a8:	fd040793          	addi	a5,s0,-48
    800088ac:	853e                	mv	a0,a5
    800088ae:	f2dff0ef          	jal	800087da <alloc3_desc>
    800088b2:	87aa                	mv	a5,a0
    800088b4:	cf81                	beqz	a5,800088cc <virtio_disk_rw+0x56>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800088b6:	0001b597          	auipc	a1,0x1b
    800088ba:	38a58593          	addi	a1,a1,906 # 80023c40 <disk+0x128>
    800088be:	0001b517          	auipc	a0,0x1b
    800088c2:	27250513          	addi	a0,a0,626 # 80023b30 <disk+0x18>
    800088c6:	a31fa0ef          	jal	800032f6 <sleep>
    if(alloc3_desc(idx) == 0) {
    800088ca:	bff9                	j	800088a8 <virtio_disk_rw+0x32>
      break;
    800088cc:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800088ce:	fd042783          	lw	a5,-48(s0)
    800088d2:	07a9                	addi	a5,a5,10
    800088d4:	00479713          	slli	a4,a5,0x4
    800088d8:	0001b797          	auipc	a5,0x1b
    800088dc:	24078793          	addi	a5,a5,576 # 80023b18 <disk>
    800088e0:	97ba                	add	a5,a5,a4
    800088e2:	07a1                	addi	a5,a5,8
    800088e4:	fef43023          	sd	a5,-32(s0)

  if(write)
    800088e8:	fc442783          	lw	a5,-60(s0)
    800088ec:	2781                	sext.w	a5,a5
    800088ee:	c791                	beqz	a5,800088fa <virtio_disk_rw+0x84>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    800088f0:	fe043783          	ld	a5,-32(s0)
    800088f4:	4705                	li	a4,1
    800088f6:	c398                	sw	a4,0(a5)
    800088f8:	a029                	j	80008902 <virtio_disk_rw+0x8c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    800088fa:	fe043783          	ld	a5,-32(s0)
    800088fe:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80008902:	fe043783          	ld	a5,-32(s0)
    80008906:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000890a:	fe043783          	ld	a5,-32(s0)
    8000890e:	fe843703          	ld	a4,-24(s0)
    80008912:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80008914:	0001b797          	auipc	a5,0x1b
    80008918:	20478793          	addi	a5,a5,516 # 80023b18 <disk>
    8000891c:	6398                	ld	a4,0(a5)
    8000891e:	fd042783          	lw	a5,-48(s0)
    80008922:	0792                	slli	a5,a5,0x4
    80008924:	97ba                	add	a5,a5,a4
    80008926:	fe043703          	ld	a4,-32(s0)
    8000892a:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000892c:	0001b797          	auipc	a5,0x1b
    80008930:	1ec78793          	addi	a5,a5,492 # 80023b18 <disk>
    80008934:	6398                	ld	a4,0(a5)
    80008936:	fd042783          	lw	a5,-48(s0)
    8000893a:	0792                	slli	a5,a5,0x4
    8000893c:	97ba                	add	a5,a5,a4
    8000893e:	4741                	li	a4,16
    80008940:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80008942:	0001b797          	auipc	a5,0x1b
    80008946:	1d678793          	addi	a5,a5,470 # 80023b18 <disk>
    8000894a:	6398                	ld	a4,0(a5)
    8000894c:	fd042783          	lw	a5,-48(s0)
    80008950:	0792                	slli	a5,a5,0x4
    80008952:	97ba                	add	a5,a5,a4
    80008954:	4705                	li	a4,1
    80008956:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[0]].next = idx[1];
    8000895a:	fd442683          	lw	a3,-44(s0)
    8000895e:	0001b797          	auipc	a5,0x1b
    80008962:	1ba78793          	addi	a5,a5,442 # 80023b18 <disk>
    80008966:	6398                	ld	a4,0(a5)
    80008968:	fd042783          	lw	a5,-48(s0)
    8000896c:	0792                	slli	a5,a5,0x4
    8000896e:	97ba                	add	a5,a5,a4
    80008970:	03069713          	slli	a4,a3,0x30
    80008974:	9341                	srli	a4,a4,0x30
    80008976:	00e79723          	sh	a4,14(a5)

  disk.desc[idx[1]].addr = (uint64) b->data;
    8000897a:	fc843783          	ld	a5,-56(s0)
    8000897e:	05878693          	addi	a3,a5,88
    80008982:	0001b797          	auipc	a5,0x1b
    80008986:	19678793          	addi	a5,a5,406 # 80023b18 <disk>
    8000898a:	6398                	ld	a4,0(a5)
    8000898c:	fd442783          	lw	a5,-44(s0)
    80008990:	0792                	slli	a5,a5,0x4
    80008992:	97ba                	add	a5,a5,a4
    80008994:	8736                	mv	a4,a3
    80008996:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80008998:	0001b797          	auipc	a5,0x1b
    8000899c:	18078793          	addi	a5,a5,384 # 80023b18 <disk>
    800089a0:	6398                	ld	a4,0(a5)
    800089a2:	fd442783          	lw	a5,-44(s0)
    800089a6:	0792                	slli	a5,a5,0x4
    800089a8:	97ba                	add	a5,a5,a4
    800089aa:	40000713          	li	a4,1024
    800089ae:	c798                	sw	a4,8(a5)
  if(write)
    800089b0:	fc442783          	lw	a5,-60(s0)
    800089b4:	2781                	sext.w	a5,a5
    800089b6:	cf89                	beqz	a5,800089d0 <virtio_disk_rw+0x15a>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800089b8:	0001b797          	auipc	a5,0x1b
    800089bc:	16078793          	addi	a5,a5,352 # 80023b18 <disk>
    800089c0:	6398                	ld	a4,0(a5)
    800089c2:	fd442783          	lw	a5,-44(s0)
    800089c6:	0792                	slli	a5,a5,0x4
    800089c8:	97ba                	add	a5,a5,a4
    800089ca:	00079623          	sh	zero,12(a5)
    800089ce:	a829                	j	800089e8 <virtio_disk_rw+0x172>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800089d0:	0001b797          	auipc	a5,0x1b
    800089d4:	14878793          	addi	a5,a5,328 # 80023b18 <disk>
    800089d8:	6398                	ld	a4,0(a5)
    800089da:	fd442783          	lw	a5,-44(s0)
    800089de:	0792                	slli	a5,a5,0x4
    800089e0:	97ba                	add	a5,a5,a4
    800089e2:	4709                	li	a4,2
    800089e4:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800089e8:	0001b797          	auipc	a5,0x1b
    800089ec:	13078793          	addi	a5,a5,304 # 80023b18 <disk>
    800089f0:	6398                	ld	a4,0(a5)
    800089f2:	fd442783          	lw	a5,-44(s0)
    800089f6:	0792                	slli	a5,a5,0x4
    800089f8:	97ba                	add	a5,a5,a4
    800089fa:	00c7d703          	lhu	a4,12(a5)
    800089fe:	0001b797          	auipc	a5,0x1b
    80008a02:	11a78793          	addi	a5,a5,282 # 80023b18 <disk>
    80008a06:	6394                	ld	a3,0(a5)
    80008a08:	fd442783          	lw	a5,-44(s0)
    80008a0c:	0792                	slli	a5,a5,0x4
    80008a0e:	97b6                	add	a5,a5,a3
    80008a10:	00176713          	ori	a4,a4,1
    80008a14:	1742                	slli	a4,a4,0x30
    80008a16:	9341                	srli	a4,a4,0x30
    80008a18:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].next = idx[2];
    80008a1c:	fd842683          	lw	a3,-40(s0)
    80008a20:	0001b797          	auipc	a5,0x1b
    80008a24:	0f878793          	addi	a5,a5,248 # 80023b18 <disk>
    80008a28:	6398                	ld	a4,0(a5)
    80008a2a:	fd442783          	lw	a5,-44(s0)
    80008a2e:	0792                	slli	a5,a5,0x4
    80008a30:	97ba                	add	a5,a5,a4
    80008a32:	03069713          	slli	a4,a3,0x30
    80008a36:	9341                	srli	a4,a4,0x30
    80008a38:	00e79723          	sh	a4,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80008a3c:	fd042783          	lw	a5,-48(s0)
    80008a40:	0001b717          	auipc	a4,0x1b
    80008a44:	0d870713          	addi	a4,a4,216 # 80023b18 <disk>
    80008a48:	0789                	addi	a5,a5,2
    80008a4a:	0792                	slli	a5,a5,0x4
    80008a4c:	97ba                	add	a5,a5,a4
    80008a4e:	577d                	li	a4,-1
    80008a50:	00e78823          	sb	a4,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80008a54:	fd042783          	lw	a5,-48(s0)
    80008a58:	0789                	addi	a5,a5,2
    80008a5a:	00479713          	slli	a4,a5,0x4
    80008a5e:	0001b797          	auipc	a5,0x1b
    80008a62:	0ba78793          	addi	a5,a5,186 # 80023b18 <disk>
    80008a66:	97ba                	add	a5,a5,a4
    80008a68:	01078693          	addi	a3,a5,16
    80008a6c:	0001b797          	auipc	a5,0x1b
    80008a70:	0ac78793          	addi	a5,a5,172 # 80023b18 <disk>
    80008a74:	6398                	ld	a4,0(a5)
    80008a76:	fd842783          	lw	a5,-40(s0)
    80008a7a:	0792                	slli	a5,a5,0x4
    80008a7c:	97ba                	add	a5,a5,a4
    80008a7e:	8736                	mv	a4,a3
    80008a80:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    80008a82:	0001b797          	auipc	a5,0x1b
    80008a86:	09678793          	addi	a5,a5,150 # 80023b18 <disk>
    80008a8a:	6398                	ld	a4,0(a5)
    80008a8c:	fd842783          	lw	a5,-40(s0)
    80008a90:	0792                	slli	a5,a5,0x4
    80008a92:	97ba                	add	a5,a5,a4
    80008a94:	4705                	li	a4,1
    80008a96:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80008a98:	0001b797          	auipc	a5,0x1b
    80008a9c:	08078793          	addi	a5,a5,128 # 80023b18 <disk>
    80008aa0:	6398                	ld	a4,0(a5)
    80008aa2:	fd842783          	lw	a5,-40(s0)
    80008aa6:	0792                	slli	a5,a5,0x4
    80008aa8:	97ba                	add	a5,a5,a4
    80008aaa:	4709                	li	a4,2
    80008aac:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[2]].next = 0;
    80008ab0:	0001b797          	auipc	a5,0x1b
    80008ab4:	06878793          	addi	a5,a5,104 # 80023b18 <disk>
    80008ab8:	6398                	ld	a4,0(a5)
    80008aba:	fd842783          	lw	a5,-40(s0)
    80008abe:	0792                	slli	a5,a5,0x4
    80008ac0:	97ba                	add	a5,a5,a4
    80008ac2:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80008ac6:	fc843783          	ld	a5,-56(s0)
    80008aca:	4705                	li	a4,1
    80008acc:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80008ace:	fd042783          	lw	a5,-48(s0)
    80008ad2:	0001b717          	auipc	a4,0x1b
    80008ad6:	04670713          	addi	a4,a4,70 # 80023b18 <disk>
    80008ada:	0789                	addi	a5,a5,2
    80008adc:	0792                	slli	a5,a5,0x4
    80008ade:	97ba                	add	a5,a5,a4
    80008ae0:	fc843703          	ld	a4,-56(s0)
    80008ae4:	e798                	sd	a4,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80008ae6:	fd042703          	lw	a4,-48(s0)
    80008aea:	0001b797          	auipc	a5,0x1b
    80008aee:	02e78793          	addi	a5,a5,46 # 80023b18 <disk>
    80008af2:	6794                	ld	a3,8(a5)
    80008af4:	0001b797          	auipc	a5,0x1b
    80008af8:	02478793          	addi	a5,a5,36 # 80023b18 <disk>
    80008afc:	679c                	ld	a5,8(a5)
    80008afe:	0027d783          	lhu	a5,2(a5)
    80008b02:	2781                	sext.w	a5,a5
    80008b04:	8b9d                	andi	a5,a5,7
    80008b06:	2781                	sext.w	a5,a5
    80008b08:	1742                	slli	a4,a4,0x30
    80008b0a:	9341                	srli	a4,a4,0x30
    80008b0c:	0786                	slli	a5,a5,0x1
    80008b0e:	97b6                	add	a5,a5,a3
    80008b10:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80008b14:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80008b18:	0001b797          	auipc	a5,0x1b
    80008b1c:	00078793          	mv	a5,a5
    80008b20:	679c                	ld	a5,8(a5)
    80008b22:	0027d703          	lhu	a4,2(a5) # 80023b1a <disk+0x2>
    80008b26:	0001b797          	auipc	a5,0x1b
    80008b2a:	ff278793          	addi	a5,a5,-14 # 80023b18 <disk>
    80008b2e:	679c                	ld	a5,8(a5)
    80008b30:	2705                	addiw	a4,a4,1
    80008b32:	1742                	slli	a4,a4,0x30
    80008b34:	9341                	srli	a4,a4,0x30
    80008b36:	00e79123          	sh	a4,2(a5)

  __sync_synchronize();
    80008b3a:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80008b3e:	100017b7          	lui	a5,0x10001
    80008b42:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    80008b46:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80008b4a:	a809                	j	80008b5c <virtio_disk_rw+0x2e6>
    sleep(b, &disk.vdisk_lock);
    80008b4c:	0001b597          	auipc	a1,0x1b
    80008b50:	0f458593          	addi	a1,a1,244 # 80023c40 <disk+0x128>
    80008b54:	fc843503          	ld	a0,-56(s0)
    80008b58:	f9efa0ef          	jal	800032f6 <sleep>
  while(b->disk == 1) {
    80008b5c:	fc843783          	ld	a5,-56(s0)
    80008b60:	43d8                	lw	a4,4(a5)
    80008b62:	4785                	li	a5,1
    80008b64:	fef704e3          	beq	a4,a5,80008b4c <virtio_disk_rw+0x2d6>
  }

  disk.info[idx[0]].b = 0;
    80008b68:	fd042783          	lw	a5,-48(s0)
    80008b6c:	0001b717          	auipc	a4,0x1b
    80008b70:	fac70713          	addi	a4,a4,-84 # 80023b18 <disk>
    80008b74:	0789                	addi	a5,a5,2
    80008b76:	0792                	slli	a5,a5,0x4
    80008b78:	97ba                	add	a5,a5,a4
    80008b7a:	0007b423          	sd	zero,8(a5)
  free_chain(idx[0]);
    80008b7e:	fd042783          	lw	a5,-48(s0)
    80008b82:	853e                	mv	a0,a5
    80008b84:	bebff0ef          	jal	8000876e <free_chain>

  release(&disk.vdisk_lock);
    80008b88:	0001b517          	auipc	a0,0x1b
    80008b8c:	0b850513          	addi	a0,a0,184 # 80023c40 <disk+0x128>
    80008b90:	80ff80ef          	jal	8000139e <release>
}
    80008b94:	0001                	nop
    80008b96:	70e2                	ld	ra,56(sp)
    80008b98:	7442                	ld	s0,48(sp)
    80008b9a:	6121                	addi	sp,sp,64
    80008b9c:	8082                	ret

0000000080008b9e <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80008b9e:	1101                	addi	sp,sp,-32
    80008ba0:	ec06                	sd	ra,24(sp)
    80008ba2:	e822                	sd	s0,16(sp)
    80008ba4:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80008ba6:	0001b517          	auipc	a0,0x1b
    80008baa:	09a50513          	addi	a0,a0,154 # 80023c40 <disk+0x128>
    80008bae:	f9cf80ef          	jal	8000134a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80008bb2:	100017b7          	lui	a5,0x10001
    80008bb6:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80008bba:	439c                	lw	a5,0(a5)
    80008bbc:	0007871b          	sext.w	a4,a5
    80008bc0:	100017b7          	lui	a5,0x10001
    80008bc4:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80008bc8:	8b0d                	andi	a4,a4,3
    80008bca:	2701                	sext.w	a4,a4
    80008bcc:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    80008bce:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80008bd2:	a861                	j	80008c6a <virtio_disk_intr+0xcc>
    __sync_synchronize();
    80008bd4:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80008bd8:	0001b797          	auipc	a5,0x1b
    80008bdc:	f4078793          	addi	a5,a5,-192 # 80023b18 <disk>
    80008be0:	6b98                	ld	a4,16(a5)
    80008be2:	0001b797          	auipc	a5,0x1b
    80008be6:	f3678793          	addi	a5,a5,-202 # 80023b18 <disk>
    80008bea:	0207d783          	lhu	a5,32(a5)
    80008bee:	2781                	sext.w	a5,a5
    80008bf0:	8b9d                	andi	a5,a5,7
    80008bf2:	2781                	sext.w	a5,a5
    80008bf4:	078e                	slli	a5,a5,0x3
    80008bf6:	97ba                	add	a5,a5,a4
    80008bf8:	43dc                	lw	a5,4(a5)
    80008bfa:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80008bfe:	0001b717          	auipc	a4,0x1b
    80008c02:	f1a70713          	addi	a4,a4,-230 # 80023b18 <disk>
    80008c06:	fec42783          	lw	a5,-20(s0)
    80008c0a:	0789                	addi	a5,a5,2
    80008c0c:	0792                	slli	a5,a5,0x4
    80008c0e:	97ba                	add	a5,a5,a4
    80008c10:	0107c783          	lbu	a5,16(a5)
    80008c14:	c799                	beqz	a5,80008c22 <virtio_disk_intr+0x84>
      panic("virtio_disk_intr status");
    80008c16:	00002517          	auipc	a0,0x2
    80008c1a:	b9a50513          	addi	a0,a0,-1126 # 8000a7b0 <etext+0x7b0>
    80008c1e:	a18f80ef          	jal	80000e36 <panic>

    struct buf *b = disk.info[id].b;
    80008c22:	0001b717          	auipc	a4,0x1b
    80008c26:	ef670713          	addi	a4,a4,-266 # 80023b18 <disk>
    80008c2a:	fec42783          	lw	a5,-20(s0)
    80008c2e:	0789                	addi	a5,a5,2
    80008c30:	0792                	slli	a5,a5,0x4
    80008c32:	97ba                	add	a5,a5,a4
    80008c34:	679c                	ld	a5,8(a5)
    80008c36:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80008c3a:	fe043783          	ld	a5,-32(s0)
    80008c3e:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80008c42:	fe043503          	ld	a0,-32(s0)
    80008c46:	f14fa0ef          	jal	8000335a <wakeup>

    disk.used_idx += 1;
    80008c4a:	0001b797          	auipc	a5,0x1b
    80008c4e:	ece78793          	addi	a5,a5,-306 # 80023b18 <disk>
    80008c52:	0207d783          	lhu	a5,32(a5)
    80008c56:	2785                	addiw	a5,a5,1
    80008c58:	03079713          	slli	a4,a5,0x30
    80008c5c:	9341                	srli	a4,a4,0x30
    80008c5e:	0001b797          	auipc	a5,0x1b
    80008c62:	eba78793          	addi	a5,a5,-326 # 80023b18 <disk>
    80008c66:	02e79023          	sh	a4,32(a5)
  while(disk.used_idx != disk.used->idx){
    80008c6a:	0001b797          	auipc	a5,0x1b
    80008c6e:	eae78793          	addi	a5,a5,-338 # 80023b18 <disk>
    80008c72:	0207d703          	lhu	a4,32(a5)
    80008c76:	0001b797          	auipc	a5,0x1b
    80008c7a:	ea278793          	addi	a5,a5,-350 # 80023b18 <disk>
    80008c7e:	6b9c                	ld	a5,16(a5)
    80008c80:	0027d783          	lhu	a5,2(a5)
    80008c84:	2701                	sext.w	a4,a4
    80008c86:	2781                	sext.w	a5,a5
    80008c88:	f4f716e3          	bne	a4,a5,80008bd4 <virtio_disk_intr+0x36>
  }

  release(&disk.vdisk_lock);
    80008c8c:	0001b517          	auipc	a0,0x1b
    80008c90:	fb450513          	addi	a0,a0,-76 # 80023c40 <disk+0x128>
    80008c94:	f0af80ef          	jal	8000139e <release>
}
    80008c98:	0001                	nop
    80008c9a:	60e2                	ld	ra,24(sp)
    80008c9c:	6442                	ld	s0,16(sp)
    80008c9e:	6105                	addi	sp,sp,32
    80008ca0:	8082                	ret
	...

0000000080009000 <_trampoline>:
    80009000:	14051073          	csrw	sscratch,a0
    80009004:	02000537          	lui	a0,0x2000
    80009008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000900a:	0536                	slli	a0,a0,0xd
    8000900c:	02153423          	sd	ra,40(a0)
    80009010:	02253823          	sd	sp,48(a0)
    80009014:	02353c23          	sd	gp,56(a0)
    80009018:	04453023          	sd	tp,64(a0)
    8000901c:	04553423          	sd	t0,72(a0)
    80009020:	04653823          	sd	t1,80(a0)
    80009024:	04753c23          	sd	t2,88(a0)
    80009028:	f120                	sd	s0,96(a0)
    8000902a:	f524                	sd	s1,104(a0)
    8000902c:	fd2c                	sd	a1,120(a0)
    8000902e:	e150                	sd	a2,128(a0)
    80009030:	e554                	sd	a3,136(a0)
    80009032:	e958                	sd	a4,144(a0)
    80009034:	ed5c                	sd	a5,152(a0)
    80009036:	0b053023          	sd	a6,160(a0)
    8000903a:	0b153423          	sd	a7,168(a0)
    8000903e:	0b253823          	sd	s2,176(a0)
    80009042:	0b353c23          	sd	s3,184(a0)
    80009046:	0d453023          	sd	s4,192(a0)
    8000904a:	0d553423          	sd	s5,200(a0)
    8000904e:	0d653823          	sd	s6,208(a0)
    80009052:	0d753c23          	sd	s7,216(a0)
    80009056:	0f853023          	sd	s8,224(a0)
    8000905a:	0f953423          	sd	s9,232(a0)
    8000905e:	0fa53823          	sd	s10,240(a0)
    80009062:	0fb53c23          	sd	s11,248(a0)
    80009066:	11c53023          	sd	t3,256(a0)
    8000906a:	11d53423          	sd	t4,264(a0)
    8000906e:	11e53823          	sd	t5,272(a0)
    80009072:	11f53c23          	sd	t6,280(a0)
    80009076:	140022f3          	csrr	t0,sscratch
    8000907a:	06553823          	sd	t0,112(a0)
    8000907e:	00853103          	ld	sp,8(a0)
    80009082:	02053203          	ld	tp,32(a0)
    80009086:	01053283          	ld	t0,16(a0)
    8000908a:	00053303          	ld	t1,0(a0)
    8000908e:	12000073          	sfence.vma
    80009092:	18031073          	csrw	satp,t1
    80009096:	12000073          	sfence.vma
    8000909a:	9282                	jalr	t0

000000008000909c <userret>:
    8000909c:	12000073          	sfence.vma
    800090a0:	18051073          	csrw	satp,a0
    800090a4:	12000073          	sfence.vma
    800090a8:	02000537          	lui	a0,0x2000
    800090ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800090ae:	0536                	slli	a0,a0,0xd
    800090b0:	02853083          	ld	ra,40(a0)
    800090b4:	03053103          	ld	sp,48(a0)
    800090b8:	03853183          	ld	gp,56(a0)
    800090bc:	04053203          	ld	tp,64(a0)
    800090c0:	04853283          	ld	t0,72(a0)
    800090c4:	05053303          	ld	t1,80(a0)
    800090c8:	05853383          	ld	t2,88(a0)
    800090cc:	7120                	ld	s0,96(a0)
    800090ce:	7524                	ld	s1,104(a0)
    800090d0:	7d2c                	ld	a1,120(a0)
    800090d2:	6150                	ld	a2,128(a0)
    800090d4:	6554                	ld	a3,136(a0)
    800090d6:	6958                	ld	a4,144(a0)
    800090d8:	6d5c                	ld	a5,152(a0)
    800090da:	0a053803          	ld	a6,160(a0)
    800090de:	0a853883          	ld	a7,168(a0)
    800090e2:	0b053903          	ld	s2,176(a0)
    800090e6:	0b853983          	ld	s3,184(a0)
    800090ea:	0c053a03          	ld	s4,192(a0)
    800090ee:	0c853a83          	ld	s5,200(a0)
    800090f2:	0d053b03          	ld	s6,208(a0)
    800090f6:	0d853b83          	ld	s7,216(a0)
    800090fa:	0e053c03          	ld	s8,224(a0)
    800090fe:	0e853c83          	ld	s9,232(a0)
    80009102:	0f053d03          	ld	s10,240(a0)
    80009106:	0f853d83          	ld	s11,248(a0)
    8000910a:	10053e03          	ld	t3,256(a0)
    8000910e:	10853e83          	ld	t4,264(a0)
    80009112:	11053f03          	ld	t5,272(a0)
    80009116:	11853f83          	ld	t6,280(a0)
    8000911a:	7928                	ld	a0,112(a0)
    8000911c:	10200073          	sret
	...
