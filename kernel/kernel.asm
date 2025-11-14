
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
    80000004:	8a010113          	addi	sp,sp,-1888 # 8000a8a0 <stack0>
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
    80000288:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffdac47>
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
    800004a2:	40250513          	addi	a0,a0,1026 # 800128a0 <cons>
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
    800004c0:	3e450513          	addi	a0,a0,996 # 800128a0 <cons>
    800004c4:	6db000ef          	jal	8000139e <release>
        return -1;
    800004c8:	57fd                	li	a5,-1
    800004ca:	a225                	j	800005f2 <consoleread+0x176>
      }
      sleep(&cons.r, &cons.lock);
    800004cc:	00012597          	auipc	a1,0x12
    800004d0:	3d458593          	addi	a1,a1,980 # 800128a0 <cons>
    800004d4:	00012517          	auipc	a0,0x12
    800004d8:	46450513          	addi	a0,a0,1124 # 80012938 <cons+0x98>
    800004dc:	61b020ef          	jal	800032f6 <sleep>
    while(cons.r == cons.w){
    800004e0:	00012797          	auipc	a5,0x12
    800004e4:	3c078793          	addi	a5,a5,960 # 800128a0 <cons>
    800004e8:	0987a703          	lw	a4,152(a5)
    800004ec:	00012797          	auipc	a5,0x12
    800004f0:	3b478793          	addi	a5,a5,948 # 800128a0 <cons>
    800004f4:	09c7a783          	lw	a5,156(a5)
    800004f8:	faf70ae3          	beq	a4,a5,800004ac <consoleread+0x30>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800004fc:	00012797          	auipc	a5,0x12
    80000500:	3a478793          	addi	a5,a5,932 # 800128a0 <cons>
    80000504:	0987a783          	lw	a5,152(a5)
    80000508:	0017871b          	addiw	a4,a5,1
    8000050c:	0007069b          	sext.w	a3,a4
    80000510:	00012717          	auipc	a4,0x12
    80000514:	39070713          	addi	a4,a4,912 # 800128a0 <cons>
    80000518:	08d72c23          	sw	a3,152(a4)
    8000051c:	07f7f793          	andi	a5,a5,127
    80000520:	2781                	sext.w	a5,a5
    80000522:	00012717          	auipc	a4,0x12
    80000526:	37e70713          	addi	a4,a4,894 # 800128a0 <cons>
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
    80000558:	34c78793          	addi	a5,a5,844 # 800128a0 <cons>
    8000055c:	0987a783          	lw	a5,152(a5)
    80000560:	37fd                	addiw	a5,a5,-1
    80000562:	0007871b          	sext.w	a4,a5
    80000566:	00012797          	auipc	a5,0x12
    8000056a:	33a78793          	addi	a5,a5,826 # 800128a0 <cons>
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
    800005dc:	2c850513          	addi	a0,a0,712 # 800128a0 <cons>
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
    8000060e:	29650513          	addi	a0,a0,662 # 800128a0 <cons>
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
    80000678:	22c78793          	addi	a5,a5,556 # 800128a0 <cons>
    8000067c:	0a07a783          	lw	a5,160(a5)
    80000680:	37fd                	addiw	a5,a5,-1
    80000682:	0007871b          	sext.w	a4,a5
    80000686:	00012797          	auipc	a5,0x12
    8000068a:	21a78793          	addi	a5,a5,538 # 800128a0 <cons>
    8000068e:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000692:	10000513          	li	a0,256
    80000696:	cddff0ef          	jal	80000372 <consputc>
    while(cons.e != cons.w &&
    8000069a:	00012797          	auipc	a5,0x12
    8000069e:	20678793          	addi	a5,a5,518 # 800128a0 <cons>
    800006a2:	0a07a703          	lw	a4,160(a5)
    800006a6:	00012797          	auipc	a5,0x12
    800006aa:	1fa78793          	addi	a5,a5,506 # 800128a0 <cons>
    800006ae:	09c7a783          	lw	a5,156(a5)
    800006b2:	16f70d63          	beq	a4,a5,8000082c <consoleintr+0x230>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800006b6:	00012797          	auipc	a5,0x12
    800006ba:	1ea78793          	addi	a5,a5,490 # 800128a0 <cons>
    800006be:	0a07a783          	lw	a5,160(a5)
    800006c2:	37fd                	addiw	a5,a5,-1
    800006c4:	2781                	sext.w	a5,a5
    800006c6:	07f7f793          	andi	a5,a5,127
    800006ca:	2781                	sext.w	a5,a5
    800006cc:	00012717          	auipc	a4,0x12
    800006d0:	1d470713          	addi	a4,a4,468 # 800128a0 <cons>
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
    800006ec:	1b878793          	addi	a5,a5,440 # 800128a0 <cons>
    800006f0:	0a07a703          	lw	a4,160(a5)
    800006f4:	00012797          	auipc	a5,0x12
    800006f8:	1ac78793          	addi	a5,a5,428 # 800128a0 <cons>
    800006fc:	09c7a783          	lw	a5,156(a5)
    80000700:	12f70863          	beq	a4,a5,80000830 <consoleintr+0x234>
      cons.e--;
    80000704:	00012797          	auipc	a5,0x12
    80000708:	19c78793          	addi	a5,a5,412 # 800128a0 <cons>
    8000070c:	0a07a783          	lw	a5,160(a5)
    80000710:	37fd                	addiw	a5,a5,-1
    80000712:	0007871b          	sext.w	a4,a5
    80000716:	00012797          	auipc	a5,0x12
    8000071a:	18a78793          	addi	a5,a5,394 # 800128a0 <cons>
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
    8000073a:	16a78793          	addi	a5,a5,362 # 800128a0 <cons>
    8000073e:	0a07a703          	lw	a4,160(a5)
    80000742:	00012797          	auipc	a5,0x12
    80000746:	15e78793          	addi	a5,a5,350 # 800128a0 <cons>
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
    80000786:	11e78793          	addi	a5,a5,286 # 800128a0 <cons>
    8000078a:	0a07a783          	lw	a5,160(a5)
    8000078e:	0017871b          	addiw	a4,a5,1
    80000792:	0007069b          	sext.w	a3,a4
    80000796:	00012717          	auipc	a4,0x12
    8000079a:	10a70713          	addi	a4,a4,266 # 800128a0 <cons>
    8000079e:	0ad72023          	sw	a3,160(a4)
    800007a2:	07f7f793          	andi	a5,a5,127
    800007a6:	2781                	sext.w	a5,a5
    800007a8:	fec42703          	lw	a4,-20(s0)
    800007ac:	0ff77713          	zext.b	a4,a4
    800007b0:	00012697          	auipc	a3,0x12
    800007b4:	0f068693          	addi	a3,a3,240 # 800128a0 <cons>
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
    800007e2:	0c278793          	addi	a5,a5,194 # 800128a0 <cons>
    800007e6:	0a07a703          	lw	a4,160(a5)
    800007ea:	00012797          	auipc	a5,0x12
    800007ee:	0b678793          	addi	a5,a5,182 # 800128a0 <cons>
    800007f2:	0987a783          	lw	a5,152(a5)
    800007f6:	40f707bb          	subw	a5,a4,a5
    800007fa:	0007871b          	sext.w	a4,a5
    800007fe:	08000793          	li	a5,128
    80000802:	02f71963          	bne	a4,a5,80000834 <consoleintr+0x238>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000806:	00012797          	auipc	a5,0x12
    8000080a:	09a78793          	addi	a5,a5,154 # 800128a0 <cons>
    8000080e:	0a07a703          	lw	a4,160(a5)
    80000812:	00012797          	auipc	a5,0x12
    80000816:	08e78793          	addi	a5,a5,142 # 800128a0 <cons>
    8000081a:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000081e:	00012517          	auipc	a0,0x12
    80000822:	11a50513          	addi	a0,a0,282 # 80012938 <cons+0x98>
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
    8000083a:	06a50513          	addi	a0,a0,106 # 800128a0 <cons>
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
    80000860:	04450513          	addi	a0,a0,68 # 800128a0 <cons>
    80000864:	2b3000ef          	jal	80001316 <initlock>

  uartinit();
    80000868:	638000ef          	jal	80000ea0 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000086c:	00022797          	auipc	a5,0x22
    80000870:	1b478793          	addi	a5,a5,436 # 80022a20 <devsw>
    80000874:	00000717          	auipc	a4,0x0
    80000878:	c0870713          	addi	a4,a4,-1016 # 8000047c <consoleread>
    8000087c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000087e:	00022797          	auipc	a5,0x22
    80000882:	1a278793          	addi	a5,a5,418 # 80022a20 <devsw>
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
    80000908:	e7c68693          	addi	a3,a3,-388 # 8000a780 <digits>
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
    800009b2:	dd270713          	addi	a4,a4,-558 # 8000a780 <digits>
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
    80000a10:	e7478793          	addi	a5,a5,-396 # 8000a880 <panicking>
    80000a14:	439c                	lw	a5,0(a5)
    80000a16:	2781                	sext.w	a5,a5
    80000a18:	e799                	bnez	a5,80000a26 <printf+0x38>
    acquire(&pr.lock);
    80000a1a:	00012517          	auipc	a0,0x12
    80000a1e:	f2e50513          	addi	a0,a0,-210 # 80012948 <pr>
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
    80000e14:	a7078793          	addi	a5,a5,-1424 # 8000a880 <panicking>
    80000e18:	439c                	lw	a5,0(a5)
    80000e1a:	2781                	sext.w	a5,a5
    80000e1c:	e799                	bnez	a5,80000e2a <printf+0x43c>
    release(&pr.lock);
    80000e1e:	00012517          	auipc	a0,0x12
    80000e22:	b2a50513          	addi	a0,a0,-1238 # 80012948 <pr>
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
    80000e46:	a3e78793          	addi	a5,a5,-1474 # 8000a880 <panicking>
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
    80000e6e:	a1a78793          	addi	a5,a5,-1510 # 8000a884 <panicked>
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
    80000e8e:	abe50513          	addi	a0,a0,-1346 # 80012948 <pr>
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
    80000f04:	a6050513          	addi	a0,a0,-1440 # 80012960 <tx_lock>
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
    80000f2c:	a3850513          	addi	a0,a0,-1480 # 80012960 <tx_lock>
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
    80000f3e:	a2658593          	addi	a1,a1,-1498 # 80012960 <tx_lock>
    80000f42:	00012517          	auipc	a0,0x12
    80000f46:	a3a50513          	addi	a0,a0,-1478 # 8001297c <tx_chan>
    80000f4a:	3ac020ef          	jal	800032f6 <sleep>
    while(tx_busy != 0){
    80000f4e:	00012797          	auipc	a5,0x12
    80000f52:	a2a78793          	addi	a5,a5,-1494 # 80012978 <tx_busy>
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
    80000f7e:	9fe78793          	addi	a5,a5,-1538 # 80012978 <tx_busy>
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
    80000f9c:	9c850513          	addi	a0,a0,-1592 # 80012960 <tx_lock>
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
    80000fc0:	8c478793          	addi	a5,a5,-1852 # 8000a880 <panicking>
    80000fc4:	439c                	lw	a5,0(a5)
    80000fc6:	2781                	sext.w	a5,a5
    80000fc8:	e399                	bnez	a5,80000fce <uartputc_sync+0x20>
    push_off();
    80000fca:	45e000ef          	jal	80001428 <push_off>

  if(panicked){
    80000fce:	0000a797          	auipc	a5,0xa
    80000fd2:	8b678793          	addi	a5,a5,-1866 # 8000a884 <panicked>
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
    8000100e:	87678793          	addi	a5,a5,-1930 # 8000a880 <panicking>
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
    80001076:	8ee50513          	addi	a0,a0,-1810 # 80012960 <tx_lock>
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
    8000109a:	8e278793          	addi	a5,a5,-1822 # 80012978 <tx_busy>
    8000109e:	0007a023          	sw	zero,0(a5)
    wakeup(&tx_chan);
    800010a2:	00012517          	auipc	a0,0x12
    800010a6:	8da50513          	addi	a0,a0,-1830 # 8001297c <tx_chan>
    800010aa:	2b0020ef          	jal	8000335a <wakeup>
  }
  release(&tx_lock);
    800010ae:	00012517          	auipc	a0,0x12
    800010b2:	8b250513          	addi	a0,a0,-1870 # 80012960 <tx_lock>
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
    800010fe:	88650513          	addi	a0,a0,-1914 # 80012980 <kmem>
    80001102:	214000ef          	jal	80001316 <initlock>
  freerange(end, (void*)PHYSTOP);
    80001106:	47c5                	li	a5,17
    80001108:	01b79593          	slli	a1,a5,0x1b
    8000110c:	00023517          	auipc	a0,0x23
    80001110:	aac50513          	addi	a0,a0,-1364 # 80023bb8 <end>
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
    80001196:	a2678793          	addi	a5,a5,-1498 # 80023bb8 <end>
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
    800011ca:	00011517          	auipc	a0,0x11
    800011ce:	7b650513          	addi	a0,a0,1974 # 80012980 <kmem>
    800011d2:	178000ef          	jal	8000134a <acquire>
  r->next = kmem.freelist;
    800011d6:	00011797          	auipc	a5,0x11
    800011da:	7aa78793          	addi	a5,a5,1962 # 80012980 <kmem>
    800011de:	6f98                	ld	a4,24(a5)
    800011e0:	fe843783          	ld	a5,-24(s0)
    800011e4:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800011e6:	00011797          	auipc	a5,0x11
    800011ea:	79a78793          	addi	a5,a5,1946 # 80012980 <kmem>
    800011ee:	fe843703          	ld	a4,-24(s0)
    800011f2:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    800011f4:	00011517          	auipc	a0,0x11
    800011f8:	78c50513          	addi	a0,a0,1932 # 80012980 <kmem>
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
    80001212:	00011517          	auipc	a0,0x11
    80001216:	76e50513          	addi	a0,a0,1902 # 80012980 <kmem>
    8000121a:	130000ef          	jal	8000134a <acquire>
  r = kmem.freelist;
    8000121e:	00011797          	auipc	a5,0x11
    80001222:	76278793          	addi	a5,a5,1890 # 80012980 <kmem>
    80001226:	6f9c                	ld	a5,24(a5)
    80001228:	fef43423          	sd	a5,-24(s0)
  if(r)
    8000122c:	fe843783          	ld	a5,-24(s0)
    80001230:	cb89                	beqz	a5,80001242 <kalloc+0x38>
    kmem.freelist = r->next;
    80001232:	fe843783          	ld	a5,-24(s0)
    80001236:	6398                	ld	a4,0(a5)
    80001238:	00011797          	auipc	a5,0x11
    8000123c:	74878793          	addi	a5,a5,1864 # 80012980 <kmem>
    80001240:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001242:	00011517          	auipc	a0,0x11
    80001246:	73e50513          	addi	a0,a0,1854 # 80012980 <kmem>
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
    800018f8:	736060ef          	jal	8000802e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800018fc:	75a060ef          	jal	80008056 <plicinithart>
    binit();         // buffer cache
    80001900:	183020ef          	jal	80004282 <binit>
    iinit();         // inode table
    80001904:	116030ef          	jal	80004a1a <iinit>
    fileinit();      // file table
    80001908:	16b040ef          	jal	80006272 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000190c:	013060ef          	jal	8000811e <virtio_disk_init>
    userinit();      // first user process
    80001910:	25c010ef          	jal	80002b6c <userinit>
    __sync_synchronize();
    80001914:	0330000f          	fence	rw,rw
    started = 1;
    80001918:	00011797          	auipc	a5,0x11
    8000191c:	08878793          	addi	a5,a5,136 # 800129a0 <started>
    80001920:	4705                	li	a4,1
    80001922:	c398                	sw	a4,0(a5)
    80001924:	a81d                	j	8000195a <main+0xb6>
  } else {
    while(started == 0)
    80001926:	0001                	nop
    80001928:	00011797          	auipc	a5,0x11
    8000192c:	07878793          	addi	a5,a5,120 # 800129a0 <started>
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
    80001956:	700060ef          	jal	80008056 <plicinithart>
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
    80001ad8:	db478793          	addi	a5,a5,-588 # 8000a888 <kernel_pagetable>
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
    80001af8:	d9478793          	addi	a5,a5,-620 # 8000a888 <kernel_pagetable>
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
    8000202a:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffdb448>
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
    8000269c:	71078793          	addi	a5,a5,1808 # 80012da8 <proc>
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
    800026c8:	6e478793          	addi	a5,a5,1764 # 80012da8 <proc>
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
    80002728:	08478793          	addi	a5,a5,132 # 800187a8 <pid_lock>
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
    80002750:	05c50513          	addi	a0,a0,92 # 800187a8 <pid_lock>
    80002754:	bc3fe0ef          	jal	80001316 <initlock>
  initlock(&wait_lock, "wait_lock");
    80002758:	00008597          	auipc	a1,0x8
    8000275c:	a0858593          	addi	a1,a1,-1528 # 8000a160 <etext+0x160>
    80002760:	00016517          	auipc	a0,0x16
    80002764:	06050513          	addi	a0,a0,96 # 800187c0 <wait_lock>
    80002768:	baffe0ef          	jal	80001316 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000276c:	00010797          	auipc	a5,0x10
    80002770:	63c78793          	addi	a5,a5,1596 # 80012da8 <proc>
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
    8000279c:	61078793          	addi	a5,a5,1552 # 80012da8 <proc>
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
    800027ea:	fc278793          	addi	a5,a5,-62 # 800187a8 <pid_lock>
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
    8000283c:	17078793          	addi	a5,a5,368 # 800129a8 <cpus>
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
    80002890:	f1c50513          	addi	a0,a0,-228 # 800187a8 <pid_lock>
    80002894:	ab7fe0ef          	jal	8000134a <acquire>
  pid = nextpid;
    80002898:	00008797          	auipc	a5,0x8
    8000289c:	ed878793          	addi	a5,a5,-296 # 8000a770 <nextpid>
    800028a0:	439c                	lw	a5,0(a5)
    800028a2:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    800028a6:	00008797          	auipc	a5,0x8
    800028aa:	eca78793          	addi	a5,a5,-310 # 8000a770 <nextpid>
    800028ae:	439c                	lw	a5,0(a5)
    800028b0:	2785                	addiw	a5,a5,1
    800028b2:	0007871b          	sext.w	a4,a5
    800028b6:	00008797          	auipc	a5,0x8
    800028ba:	eba78793          	addi	a5,a5,-326 # 8000a770 <nextpid>
    800028be:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800028c0:	00016517          	auipc	a0,0x16
    800028c4:	ee850513          	addi	a0,a0,-280 # 800187a8 <pid_lock>
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
    800028e6:	4c678793          	addi	a5,a5,1222 # 80012da8 <proc>
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
    80002920:	e8c78793          	addi	a5,a5,-372 # 800187a8 <pid_lock>
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
    80002b80:	d1478793          	addi	a5,a5,-748 # 8000a890 <initproc>
    80002b84:	fe843703          	ld	a4,-24(s0)
    80002b88:	e398                	sd	a4,0(a5)
  
  p->cwd = namei("/");
    80002b8a:	00007517          	auipc	a0,0x7
    80002b8e:	5ee50513          	addi	a0,a0,1518 # 8000a178 <etext+0x178>
    80002b92:	6fd020ef          	jal	80005a8e <namei>
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
    80002d20:	5f0030ef          	jal	80006310 <filedup>
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
    80002d58:	7ff010ef          	jal	80004d56 <idup>
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
    80002d98:	a2c50513          	addi	a0,a0,-1492 # 800187c0 <wait_lock>
    80002d9c:	daefe0ef          	jal	8000134a <acquire>
  np->parent = p;
    80002da0:	fd843783          	ld	a5,-40(s0)
    80002da4:	fe043703          	ld	a4,-32(s0)
    80002da8:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80002daa:	00016517          	auipc	a0,0x16
    80002dae:	a1650513          	addi	a0,a0,-1514 # 800187c0 <wait_lock>
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
    80002df0:	fbc78793          	addi	a5,a5,-68 # 80012da8 <proc>
    80002df4:	fef43423          	sd	a5,-24(s0)
    80002df8:	a835                	j	80002e34 <reparent+0x54>
    if(pp->parent == p){
    80002dfa:	fe843783          	ld	a5,-24(s0)
    80002dfe:	7f9c                	ld	a5,56(a5)
    80002e00:	fd843703          	ld	a4,-40(s0)
    80002e04:	02f71263          	bne	a4,a5,80002e28 <reparent+0x48>
      pp->parent = initproc;
    80002e08:	00008797          	auipc	a5,0x8
    80002e0c:	a8878793          	addi	a5,a5,-1400 # 8000a890 <initproc>
    80002e10:	6398                	ld	a4,0(a5)
    80002e12:	fe843783          	ld	a5,-24(s0)
    80002e16:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    80002e18:	00008797          	auipc	a5,0x8
    80002e1c:	a7878793          	addi	a5,a5,-1416 # 8000a890 <initproc>
    80002e20:	639c                	ld	a5,0(a5)
    80002e22:	853e                	mv	a0,a5
    80002e24:	536000ef          	jal	8000335a <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002e28:	fe843783          	ld	a5,-24(s0)
    80002e2c:	16878793          	addi	a5,a5,360
    80002e30:	fef43423          	sd	a5,-24(s0)
    80002e34:	fe843703          	ld	a4,-24(s0)
    80002e38:	00016797          	auipc	a5,0x16
    80002e3c:	97078793          	addi	a5,a5,-1680 # 800187a8 <pid_lock>
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
    80002e6a:	a2a78793          	addi	a5,a5,-1494 # 8000a890 <initproc>
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
    80002eb4:	4b6030ef          	jal	8000636a <fileclose>
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
    80002ee2:	6cf020ef          	jal	80005db0 <begin_op>
  iput(p->cwd);
    80002ee6:	fe043783          	ld	a5,-32(s0)
    80002eea:	1507b783          	ld	a5,336(a5)
    80002eee:	853e                	mv	a0,a5
    80002ef0:	014020ef          	jal	80004f04 <iput>
  end_op();
    80002ef4:	76f020ef          	jal	80005e62 <end_op>
  p->cwd = 0;
    80002ef8:	fe043783          	ld	a5,-32(s0)
    80002efc:	1407b823          	sd	zero,336(a5)

  acquire(&wait_lock);
    80002f00:	00016517          	auipc	a0,0x16
    80002f04:	8c050513          	addi	a0,a0,-1856 # 800187c0 <wait_lock>
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
    80002f40:	88450513          	addi	a0,a0,-1916 # 800187c0 <wait_lock>
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
    80002f70:	85450513          	addi	a0,a0,-1964 # 800187c0 <wait_lock>
    80002f74:	bd6fe0ef          	jal	8000134a <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80002f78:	fe042223          	sw	zero,-28(s0)
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002f7c:	00010797          	auipc	a5,0x10
    80002f80:	e2c78793          	addi	a5,a5,-468 # 80012da8 <proc>
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
    80002ff0:	00015517          	auipc	a0,0x15
    80002ff4:	7d050513          	addi	a0,a0,2000 # 800187c0 <wait_lock>
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
    80003012:	00015517          	auipc	a0,0x15
    80003016:	7ae50513          	addi	a0,a0,1966 # 800187c0 <wait_lock>
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
    8000303e:	00015797          	auipc	a5,0x15
    80003042:	76a78793          	addi	a5,a5,1898 # 800187a8 <pid_lock>
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
    8000305e:	00015517          	auipc	a0,0x15
    80003062:	76250513          	addi	a0,a0,1890 # 800187c0 <wait_lock>
    80003066:	b38fe0ef          	jal	8000139e <release>
      return -1;
    8000306a:	57fd                	li	a5,-1
    8000306c:	a811                	j	80003080 <kwait+0x128>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000306e:	00015597          	auipc	a1,0x15
    80003072:	75258593          	addi	a1,a1,1874 # 800187c0 <wait_lock>
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
    800030b2:	cfa78793          	addi	a5,a5,-774 # 80012da8 <proc>
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
    80003128:	68478793          	addi	a5,a5,1668 # 800187a8 <pid_lock>
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
    80003244:	53478793          	addi	a5,a5,1332 # 8000a774 <first.1>
    80003248:	439c                	lw	a5,0(a5)
    8000324a:	c3a5                	beqz	a5,800032aa <forkret+0x84>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    8000324c:	4505                	li	a0,1
    8000324e:	47c010ef          	jal	800046ca <fsinit>

    first = 0;
    80003252:	00007797          	auipc	a5,0x7
    80003256:	52278793          	addi	a5,a5,1314 # 8000a774 <first.1>
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
    80003280:	203030ef          	jal	80006c82 <kexec>
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
    8000336a:	a4278793          	addi	a5,a5,-1470 # 80012da8 <proc>
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
    800033cc:	3e078793          	addi	a5,a5,992 # 800187a8 <pid_lock>
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
    800033f2:	9ba78793          	addi	a5,a5,-1606 # 80012da8 <proc>
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
    8000345e:	34e78793          	addi	a5,a5,846 # 800187a8 <pid_lock>
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
    800035c0:	0000f797          	auipc	a5,0xf
    800035c4:	7e878793          	addi	a5,a5,2024 # 80012da8 <proc>
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
    800035ec:	1b070713          	addi	a4,a4,432 # 8000a798 <states.0>
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
    80003606:	19670713          	addi	a4,a4,406 # 8000a798 <states.0>
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
    8000366c:	14078793          	addi	a5,a5,320 # 800187a8 <pid_lock>
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
    800038b2:	f2a50513          	addi	a0,a0,-214 # 800187d8 <tickslock>
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
    800038cc:	00004797          	auipc	a5,0x4
    800038d0:	70478793          	addi	a5,a5,1796 # 80007fd0 <kernelvec>
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
    8000390c:	00004797          	auipc	a5,0x4
    80003910:	6c478793          	addi	a5,a5,1732 # 80007fd0 <kernelvec>
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
    80003be4:	bf850513          	addi	a0,a0,-1032 # 800187d8 <tickslock>
    80003be8:	f62fd0ef          	jal	8000134a <acquire>
    ticks++;
    80003bec:	00007797          	auipc	a5,0x7
    80003bf0:	cac78793          	addi	a5,a5,-852 # 8000a898 <ticks>
    80003bf4:	439c                	lw	a5,0(a5)
    80003bf6:	2785                	addiw	a5,a5,1
    80003bf8:	0007871b          	sext.w	a4,a5
    80003bfc:	00007797          	auipc	a5,0x7
    80003c00:	c9c78793          	addi	a5,a5,-868 # 8000a898 <ticks>
    80003c04:	c398                	sw	a4,0(a5)
    wakeup(&ticks);
    80003c06:	00007517          	auipc	a0,0x7
    80003c0a:	c9250513          	addi	a0,a0,-878 # 8000a898 <ticks>
    80003c0e:	f4cff0ef          	jal	8000335a <wakeup>
    release(&tickslock);
    80003c12:	00015517          	auipc	a0,0x15
    80003c16:	bc650513          	addi	a0,a0,-1082 # 800187d8 <tickslock>
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
    80003c5c:	44a040ef          	jal	800080a6 <plic_claim>
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
    80003c88:	577040ef          	jal	800089fe <virtio_disk_intr>
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
    80003cb6:	42a040ef          	jal	800080e0 <plic_complete>

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
[SYS_top]     sys_top,
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
    80003f0c:	47d9                	li	a5,22
    80003f0e:	02e7ec63          	bltu	a5,a4,80003f46 <syscall+0x66>
    80003f12:	00007717          	auipc	a4,0x7
    80003f16:	8b670713          	addi	a4,a4,-1866 # 8000a7c8 <syscalls>
    80003f1a:	fd442783          	lw	a5,-44(s0)
    80003f1e:	078e                	slli	a5,a5,0x3
    80003f20:	97ba                	add	a5,a5,a4
    80003f22:	639c                	ld	a5,0(a5)
    80003f24:	c38d                	beqz	a5,80003f46 <syscall+0x66>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80003f26:	00007717          	auipc	a4,0x7
    80003f2a:	8a270713          	addi	a4,a4,-1886 # 8000a7c8 <syscalls>
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
    800040ce:	70e50513          	addi	a0,a0,1806 # 800187d8 <tickslock>
    800040d2:	a78fd0ef          	jal	8000134a <acquire>
  ticks0 = ticks;
    800040d6:	00006797          	auipc	a5,0x6
    800040da:	7c278793          	addi	a5,a5,1986 # 8000a898 <ticks>
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
    800040fa:	6e250513          	addi	a0,a0,1762 # 800187d8 <tickslock>
    800040fe:	aa0fd0ef          	jal	8000139e <release>
      return -1;
    80004102:	57fd                	li	a5,-1
    80004104:	a83d                	j	80004142 <sys_pause+0x98>
    }
    sleep(&ticks, &tickslock);
    80004106:	00014597          	auipc	a1,0x14
    8000410a:	6d258593          	addi	a1,a1,1746 # 800187d8 <tickslock>
    8000410e:	00006517          	auipc	a0,0x6
    80004112:	78a50513          	addi	a0,a0,1930 # 8000a898 <ticks>
    80004116:	9e0ff0ef          	jal	800032f6 <sleep>
  while(ticks - ticks0 < n){
    8000411a:	00006797          	auipc	a5,0x6
    8000411e:	77e78793          	addi	a5,a5,1918 # 8000a898 <ticks>
    80004122:	439c                	lw	a5,0(a5)
    80004124:	fec42703          	lw	a4,-20(s0)
    80004128:	9f99                	subw	a5,a5,a4
    8000412a:	2781                	sext.w	a5,a5
    8000412c:	fe842703          	lw	a4,-24(s0)
    80004130:	fae7ebe3          	bltu	a5,a4,800040e6 <sys_pause+0x3c>
  }
  release(&tickslock);
    80004134:	00014517          	auipc	a0,0x14
    80004138:	6a450513          	addi	a0,a0,1700 # 800187d8 <tickslock>
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
    80004182:	65a50513          	addi	a0,a0,1626 # 800187d8 <tickslock>
    80004186:	9c4fd0ef          	jal	8000134a <acquire>
  xticks = ticks;
    8000418a:	00006797          	auipc	a5,0x6
    8000418e:	70e78793          	addi	a5,a5,1806 # 8000a898 <ticks>
    80004192:	439c                	lw	a5,0(a5)
    80004194:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004198:	00014517          	auipc	a0,0x14
    8000419c:	64050513          	addi	a0,a0,1600 # 800187d8 <tickslock>
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

uint64
sys_top(void)
{
    800041b2:	1101                	addi	sp,sp,-32
    800041b4:	ec06                	sd	ra,24(sp)
    800041b6:	e822                	sd	s0,16(sp)
    800041b8:	1000                	addi	s0,sp,32
  struct proc *p;
  extern struct proc proc[NPROC];
  
  printf("---\t-------\t\t ----------------------\n");
    800041ba:	00006517          	auipc	a0,0x6
    800041be:	1f650513          	addi	a0,a0,502 # 8000a3b0 <etext+0x3b0>
    800041c2:	82dfc0ef          	jal	800009ee <printf>
  
  for(p = proc; p < &proc[NPROC]; p++){
    800041c6:	0000f797          	auipc	a5,0xf
    800041ca:	be278793          	addi	a5,a5,-1054 # 80012da8 <proc>
    800041ce:	fef43423          	sd	a5,-24(s0)
    800041d2:	a851                	j	80004266 <sys_top+0xb4>
    acquire(&p->lock);
    800041d4:	fe843783          	ld	a5,-24(s0)
    800041d8:	853e                	mv	a0,a5
    800041da:	970fd0ef          	jal	8000134a <acquire>
    if(p->state != UNUSED){
    800041de:	fe843783          	ld	a5,-24(s0)
    800041e2:	4f9c                	lw	a5,24(a5)
    800041e4:	c7b5                	beqz	a5,80004250 <sys_top+0x9e>
      printf("%d\t%s", p->pid, p->name);
    800041e6:	fe843783          	ld	a5,-24(s0)
    800041ea:	5b98                	lw	a4,48(a5)
    800041ec:	fe843783          	ld	a5,-24(s0)
    800041f0:	15878793          	addi	a5,a5,344
    800041f4:	863e                	mv	a2,a5
    800041f6:	85ba                	mv	a1,a4
    800041f8:	00006517          	auipc	a0,0x6
    800041fc:	1e050513          	addi	a0,a0,480 # 8000a3d8 <etext+0x3d8>
    80004200:	feefc0ef          	jal	800009ee <printf>
      
      int len = strlen(p->name);
    80004204:	fe843783          	ld	a5,-24(s0)
    80004208:	15878793          	addi	a5,a5,344
    8000420c:	853e                	mv	a0,a5
    8000420e:	e5cfd0ef          	jal	8000186a <strlen>
    80004212:	87aa                	mv	a5,a0
    80004214:	fef42223          	sw	a5,-28(s0)
      if(len < 8)
    80004218:	fe442783          	lw	a5,-28(s0)
    8000421c:	0007871b          	sext.w	a4,a5
    80004220:	479d                	li	a5,7
    80004222:	00e7cd63          	blt	a5,a4,8000423c <sys_top+0x8a>
        printf("\t\t%lu\n", p->sz);
    80004226:	fe843783          	ld	a5,-24(s0)
    8000422a:	67bc                	ld	a5,72(a5)
    8000422c:	85be                	mv	a1,a5
    8000422e:	00006517          	auipc	a0,0x6
    80004232:	1b250513          	addi	a0,a0,434 # 8000a3e0 <etext+0x3e0>
    80004236:	fb8fc0ef          	jal	800009ee <printf>
    8000423a:	a819                	j	80004250 <sys_top+0x9e>
      else
        printf("\t%lu\n", p->sz);
    8000423c:	fe843783          	ld	a5,-24(s0)
    80004240:	67bc                	ld	a5,72(a5)
    80004242:	85be                	mv	a1,a5
    80004244:	00006517          	auipc	a0,0x6
    80004248:	1a450513          	addi	a0,a0,420 # 8000a3e8 <etext+0x3e8>
    8000424c:	fa2fc0ef          	jal	800009ee <printf>
    }
    release(&p->lock);
    80004250:	fe843783          	ld	a5,-24(s0)
    80004254:	853e                	mv	a0,a5
    80004256:	948fd0ef          	jal	8000139e <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000425a:	fe843783          	ld	a5,-24(s0)
    8000425e:	16878793          	addi	a5,a5,360
    80004262:	fef43423          	sd	a5,-24(s0)
    80004266:	fe843703          	ld	a4,-24(s0)
    8000426a:	00014797          	auipc	a5,0x14
    8000426e:	53e78793          	addi	a5,a5,1342 # 800187a8 <pid_lock>
    80004272:	f6f761e3          	bltu	a4,a5,800041d4 <sys_top+0x22>
  }
  
  return 0;
    80004276:	4781                	li	a5,0
}
    80004278:	853e                	mv	a0,a5
    8000427a:	60e2                	ld	ra,24(sp)
    8000427c:	6442                	ld	s0,16(sp)
    8000427e:	6105                	addi	sp,sp,32
    80004280:	8082                	ret

0000000080004282 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004282:	1101                	addi	sp,sp,-32
    80004284:	ec06                	sd	ra,24(sp)
    80004286:	e822                	sd	s0,16(sp)
    80004288:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000428a:	00006597          	auipc	a1,0x6
    8000428e:	16658593          	addi	a1,a1,358 # 8000a3f0 <etext+0x3f0>
    80004292:	00014517          	auipc	a0,0x14
    80004296:	55e50513          	addi	a0,a0,1374 # 800187f0 <bcache>
    8000429a:	87cfd0ef          	jal	80001316 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000429e:	00014717          	auipc	a4,0x14
    800042a2:	55270713          	addi	a4,a4,1362 # 800187f0 <bcache>
    800042a6:	67a1                	lui	a5,0x8
    800042a8:	97ba                	add	a5,a5,a4
    800042aa:	0001c717          	auipc	a4,0x1c
    800042ae:	7ae70713          	addi	a4,a4,1966 # 80020a58 <bcache+0x8268>
    800042b2:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    800042b6:	00014717          	auipc	a4,0x14
    800042ba:	53a70713          	addi	a4,a4,1338 # 800187f0 <bcache>
    800042be:	67a1                	lui	a5,0x8
    800042c0:	97ba                	add	a5,a5,a4
    800042c2:	0001c717          	auipc	a4,0x1c
    800042c6:	79670713          	addi	a4,a4,1942 # 80020a58 <bcache+0x8268>
    800042ca:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800042ce:	00014797          	auipc	a5,0x14
    800042d2:	53a78793          	addi	a5,a5,1338 # 80018808 <bcache+0x18>
    800042d6:	fef43423          	sd	a5,-24(s0)
    800042da:	a885                	j	8000434a <binit+0xc8>
    b->next = bcache.head.next;
    800042dc:	00014717          	auipc	a4,0x14
    800042e0:	51470713          	addi	a4,a4,1300 # 800187f0 <bcache>
    800042e4:	67a1                	lui	a5,0x8
    800042e6:	97ba                	add	a5,a5,a4
    800042e8:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800042ec:	fe843783          	ld	a5,-24(s0)
    800042f0:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800042f2:	fe843783          	ld	a5,-24(s0)
    800042f6:	0001c717          	auipc	a4,0x1c
    800042fa:	76270713          	addi	a4,a4,1890 # 80020a58 <bcache+0x8268>
    800042fe:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    80004300:	fe843783          	ld	a5,-24(s0)
    80004304:	07c1                	addi	a5,a5,16
    80004306:	00006597          	auipc	a1,0x6
    8000430a:	0f258593          	addi	a1,a1,242 # 8000a3f8 <etext+0x3f8>
    8000430e:	853e                	mv	a0,a5
    80004310:	61d010ef          	jal	8000612c <initsleeplock>
    bcache.head.next->prev = b;
    80004314:	00014717          	auipc	a4,0x14
    80004318:	4dc70713          	addi	a4,a4,1244 # 800187f0 <bcache>
    8000431c:	67a1                	lui	a5,0x8
    8000431e:	97ba                	add	a5,a5,a4
    80004320:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004324:	fe843703          	ld	a4,-24(s0)
    80004328:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    8000432a:	00014717          	auipc	a4,0x14
    8000432e:	4c670713          	addi	a4,a4,1222 # 800187f0 <bcache>
    80004332:	67a1                	lui	a5,0x8
    80004334:	97ba                	add	a5,a5,a4
    80004336:	fe843703          	ld	a4,-24(s0)
    8000433a:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000433e:	fe843783          	ld	a5,-24(s0)
    80004342:	45878793          	addi	a5,a5,1112
    80004346:	fef43423          	sd	a5,-24(s0)
    8000434a:	0001c797          	auipc	a5,0x1c
    8000434e:	70e78793          	addi	a5,a5,1806 # 80020a58 <bcache+0x8268>
    80004352:	fe843703          	ld	a4,-24(s0)
    80004356:	f8f763e3          	bltu	a4,a5,800042dc <binit+0x5a>
  }
}
    8000435a:	0001                	nop
    8000435c:	0001                	nop
    8000435e:	60e2                	ld	ra,24(sp)
    80004360:	6442                	ld	s0,16(sp)
    80004362:	6105                	addi	sp,sp,32
    80004364:	8082                	ret

0000000080004366 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80004366:	7179                	addi	sp,sp,-48
    80004368:	f406                	sd	ra,40(sp)
    8000436a:	f022                	sd	s0,32(sp)
    8000436c:	1800                	addi	s0,sp,48
    8000436e:	87aa                	mv	a5,a0
    80004370:	872e                	mv	a4,a1
    80004372:	fcf42e23          	sw	a5,-36(s0)
    80004376:	87ba                	mv	a5,a4
    80004378:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    8000437c:	00014517          	auipc	a0,0x14
    80004380:	47450513          	addi	a0,a0,1140 # 800187f0 <bcache>
    80004384:	fc7fc0ef          	jal	8000134a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004388:	00014717          	auipc	a4,0x14
    8000438c:	46870713          	addi	a4,a4,1128 # 800187f0 <bcache>
    80004390:	67a1                	lui	a5,0x8
    80004392:	97ba                	add	a5,a5,a4
    80004394:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004398:	fef43423          	sd	a5,-24(s0)
    8000439c:	a8b1                	j	800043f8 <bget+0x92>
    if(b->dev == dev && b->blockno == blockno){
    8000439e:	fe843783          	ld	a5,-24(s0)
    800043a2:	479c                	lw	a5,8(a5)
    800043a4:	fdc42703          	lw	a4,-36(s0)
    800043a8:	2701                	sext.w	a4,a4
    800043aa:	04f71263          	bne	a4,a5,800043ee <bget+0x88>
    800043ae:	fe843783          	ld	a5,-24(s0)
    800043b2:	47dc                	lw	a5,12(a5)
    800043b4:	fd842703          	lw	a4,-40(s0)
    800043b8:	2701                	sext.w	a4,a4
    800043ba:	02f71a63          	bne	a4,a5,800043ee <bget+0x88>
      b->refcnt++;
    800043be:	fe843783          	ld	a5,-24(s0)
    800043c2:	43bc                	lw	a5,64(a5)
    800043c4:	2785                	addiw	a5,a5,1
    800043c6:	0007871b          	sext.w	a4,a5
    800043ca:	fe843783          	ld	a5,-24(s0)
    800043ce:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800043d0:	00014517          	auipc	a0,0x14
    800043d4:	42050513          	addi	a0,a0,1056 # 800187f0 <bcache>
    800043d8:	fc7fc0ef          	jal	8000139e <release>
      acquiresleep(&b->lock);
    800043dc:	fe843783          	ld	a5,-24(s0)
    800043e0:	07c1                	addi	a5,a5,16
    800043e2:	853e                	mv	a0,a5
    800043e4:	591010ef          	jal	80006174 <acquiresleep>
      return b;
    800043e8:	fe843783          	ld	a5,-24(s0)
    800043ec:	a04d                	j	8000448e <bget+0x128>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800043ee:	fe843783          	ld	a5,-24(s0)
    800043f2:	6bbc                	ld	a5,80(a5)
    800043f4:	fef43423          	sd	a5,-24(s0)
    800043f8:	fe843703          	ld	a4,-24(s0)
    800043fc:	0001c797          	auipc	a5,0x1c
    80004400:	65c78793          	addi	a5,a5,1628 # 80020a58 <bcache+0x8268>
    80004404:	f8f71de3          	bne	a4,a5,8000439e <bget+0x38>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004408:	00014717          	auipc	a4,0x14
    8000440c:	3e870713          	addi	a4,a4,1000 # 800187f0 <bcache>
    80004410:	67a1                	lui	a5,0x8
    80004412:	97ba                	add	a5,a5,a4
    80004414:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    80004418:	fef43423          	sd	a5,-24(s0)
    8000441c:	a899                	j	80004472 <bget+0x10c>
    if(b->refcnt == 0) {
    8000441e:	fe843783          	ld	a5,-24(s0)
    80004422:	43bc                	lw	a5,64(a5)
    80004424:	e3b1                	bnez	a5,80004468 <bget+0x102>
      b->dev = dev;
    80004426:	fe843783          	ld	a5,-24(s0)
    8000442a:	fdc42703          	lw	a4,-36(s0)
    8000442e:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    80004430:	fe843783          	ld	a5,-24(s0)
    80004434:	fd842703          	lw	a4,-40(s0)
    80004438:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    8000443a:	fe843783          	ld	a5,-24(s0)
    8000443e:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    80004442:	fe843783          	ld	a5,-24(s0)
    80004446:	4705                	li	a4,1
    80004448:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    8000444a:	00014517          	auipc	a0,0x14
    8000444e:	3a650513          	addi	a0,a0,934 # 800187f0 <bcache>
    80004452:	f4dfc0ef          	jal	8000139e <release>
      acquiresleep(&b->lock);
    80004456:	fe843783          	ld	a5,-24(s0)
    8000445a:	07c1                	addi	a5,a5,16
    8000445c:	853e                	mv	a0,a5
    8000445e:	517010ef          	jal	80006174 <acquiresleep>
      return b;
    80004462:	fe843783          	ld	a5,-24(s0)
    80004466:	a025                	j	8000448e <bget+0x128>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004468:	fe843783          	ld	a5,-24(s0)
    8000446c:	67bc                	ld	a5,72(a5)
    8000446e:	fef43423          	sd	a5,-24(s0)
    80004472:	fe843703          	ld	a4,-24(s0)
    80004476:	0001c797          	auipc	a5,0x1c
    8000447a:	5e278793          	addi	a5,a5,1506 # 80020a58 <bcache+0x8268>
    8000447e:	faf710e3          	bne	a4,a5,8000441e <bget+0xb8>
    }
  }
  panic("bget: no buffers");
    80004482:	00006517          	auipc	a0,0x6
    80004486:	f7e50513          	addi	a0,a0,-130 # 8000a400 <etext+0x400>
    8000448a:	9adfc0ef          	jal	80000e36 <panic>
}
    8000448e:	853e                	mv	a0,a5
    80004490:	70a2                	ld	ra,40(sp)
    80004492:	7402                	ld	s0,32(sp)
    80004494:	6145                	addi	sp,sp,48
    80004496:	8082                	ret

0000000080004498 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80004498:	7179                	addi	sp,sp,-48
    8000449a:	f406                	sd	ra,40(sp)
    8000449c:	f022                	sd	s0,32(sp)
    8000449e:	1800                	addi	s0,sp,48
    800044a0:	87aa                	mv	a5,a0
    800044a2:	872e                	mv	a4,a1
    800044a4:	fcf42e23          	sw	a5,-36(s0)
    800044a8:	87ba                	mv	a5,a4
    800044aa:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    800044ae:	fd842703          	lw	a4,-40(s0)
    800044b2:	fdc42783          	lw	a5,-36(s0)
    800044b6:	85ba                	mv	a1,a4
    800044b8:	853e                	mv	a0,a5
    800044ba:	eadff0ef          	jal	80004366 <bget>
    800044be:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    800044c2:	fe843783          	ld	a5,-24(s0)
    800044c6:	439c                	lw	a5,0(a5)
    800044c8:	eb91                	bnez	a5,800044dc <bread+0x44>
    virtio_disk_rw(b, 0);
    800044ca:	4581                	li	a1,0
    800044cc:	fe843503          	ld	a0,-24(s0)
    800044d0:	206040ef          	jal	800086d6 <virtio_disk_rw>
    b->valid = 1;
    800044d4:	fe843783          	ld	a5,-24(s0)
    800044d8:	4705                	li	a4,1
    800044da:	c398                	sw	a4,0(a5)
  }
  return b;
    800044dc:	fe843783          	ld	a5,-24(s0)
}
    800044e0:	853e                	mv	a0,a5
    800044e2:	70a2                	ld	ra,40(sp)
    800044e4:	7402                	ld	s0,32(sp)
    800044e6:	6145                	addi	sp,sp,48
    800044e8:	8082                	ret

00000000800044ea <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800044ea:	1101                	addi	sp,sp,-32
    800044ec:	ec06                	sd	ra,24(sp)
    800044ee:	e822                	sd	s0,16(sp)
    800044f0:	1000                	addi	s0,sp,32
    800044f2:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800044f6:	fe843783          	ld	a5,-24(s0)
    800044fa:	07c1                	addi	a5,a5,16
    800044fc:	853e                	mv	a0,a5
    800044fe:	51b010ef          	jal	80006218 <holdingsleep>
    80004502:	87aa                	mv	a5,a0
    80004504:	e799                	bnez	a5,80004512 <bwrite+0x28>
    panic("bwrite");
    80004506:	00006517          	auipc	a0,0x6
    8000450a:	f1250513          	addi	a0,a0,-238 # 8000a418 <etext+0x418>
    8000450e:	929fc0ef          	jal	80000e36 <panic>
  virtio_disk_rw(b, 1);
    80004512:	4585                	li	a1,1
    80004514:	fe843503          	ld	a0,-24(s0)
    80004518:	1be040ef          	jal	800086d6 <virtio_disk_rw>
}
    8000451c:	0001                	nop
    8000451e:	60e2                	ld	ra,24(sp)
    80004520:	6442                	ld	s0,16(sp)
    80004522:	6105                	addi	sp,sp,32
    80004524:	8082                	ret

0000000080004526 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004526:	1101                	addi	sp,sp,-32
    80004528:	ec06                	sd	ra,24(sp)
    8000452a:	e822                	sd	s0,16(sp)
    8000452c:	1000                	addi	s0,sp,32
    8000452e:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004532:	fe843783          	ld	a5,-24(s0)
    80004536:	07c1                	addi	a5,a5,16
    80004538:	853e                	mv	a0,a5
    8000453a:	4df010ef          	jal	80006218 <holdingsleep>
    8000453e:	87aa                	mv	a5,a0
    80004540:	e799                	bnez	a5,8000454e <brelse+0x28>
    panic("brelse");
    80004542:	00006517          	auipc	a0,0x6
    80004546:	ede50513          	addi	a0,a0,-290 # 8000a420 <etext+0x420>
    8000454a:	8edfc0ef          	jal	80000e36 <panic>

  releasesleep(&b->lock);
    8000454e:	fe843783          	ld	a5,-24(s0)
    80004552:	07c1                	addi	a5,a5,16
    80004554:	853e                	mv	a0,a5
    80004556:	47d010ef          	jal	800061d2 <releasesleep>

  acquire(&bcache.lock);
    8000455a:	00014517          	auipc	a0,0x14
    8000455e:	29650513          	addi	a0,a0,662 # 800187f0 <bcache>
    80004562:	de9fc0ef          	jal	8000134a <acquire>
  b->refcnt--;
    80004566:	fe843783          	ld	a5,-24(s0)
    8000456a:	43bc                	lw	a5,64(a5)
    8000456c:	37fd                	addiw	a5,a5,-1
    8000456e:	0007871b          	sext.w	a4,a5
    80004572:	fe843783          	ld	a5,-24(s0)
    80004576:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004578:	fe843783          	ld	a5,-24(s0)
    8000457c:	43bc                	lw	a5,64(a5)
    8000457e:	e7b5                	bnez	a5,800045ea <brelse+0xc4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80004580:	fe843783          	ld	a5,-24(s0)
    80004584:	6bbc                	ld	a5,80(a5)
    80004586:	fe843703          	ld	a4,-24(s0)
    8000458a:	6738                	ld	a4,72(a4)
    8000458c:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000458e:	fe843783          	ld	a5,-24(s0)
    80004592:	67bc                	ld	a5,72(a5)
    80004594:	fe843703          	ld	a4,-24(s0)
    80004598:	6b38                	ld	a4,80(a4)
    8000459a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000459c:	00014717          	auipc	a4,0x14
    800045a0:	25470713          	addi	a4,a4,596 # 800187f0 <bcache>
    800045a4:	67a1                	lui	a5,0x8
    800045a6:	97ba                	add	a5,a5,a4
    800045a8:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800045ac:	fe843783          	ld	a5,-24(s0)
    800045b0:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800045b2:	fe843783          	ld	a5,-24(s0)
    800045b6:	0001c717          	auipc	a4,0x1c
    800045ba:	4a270713          	addi	a4,a4,1186 # 80020a58 <bcache+0x8268>
    800045be:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    800045c0:	00014717          	auipc	a4,0x14
    800045c4:	23070713          	addi	a4,a4,560 # 800187f0 <bcache>
    800045c8:	67a1                	lui	a5,0x8
    800045ca:	97ba                	add	a5,a5,a4
    800045cc:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800045d0:	fe843703          	ld	a4,-24(s0)
    800045d4:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800045d6:	00014717          	auipc	a4,0x14
    800045da:	21a70713          	addi	a4,a4,538 # 800187f0 <bcache>
    800045de:	67a1                	lui	a5,0x8
    800045e0:	97ba                	add	a5,a5,a4
    800045e2:	fe843703          	ld	a4,-24(s0)
    800045e6:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    800045ea:	00014517          	auipc	a0,0x14
    800045ee:	20650513          	addi	a0,a0,518 # 800187f0 <bcache>
    800045f2:	dadfc0ef          	jal	8000139e <release>
}
    800045f6:	0001                	nop
    800045f8:	60e2                	ld	ra,24(sp)
    800045fa:	6442                	ld	s0,16(sp)
    800045fc:	6105                	addi	sp,sp,32
    800045fe:	8082                	ret

0000000080004600 <bpin>:

void
bpin(struct buf *b) {
    80004600:	1101                	addi	sp,sp,-32
    80004602:	ec06                	sd	ra,24(sp)
    80004604:	e822                	sd	s0,16(sp)
    80004606:	1000                	addi	s0,sp,32
    80004608:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    8000460c:	00014517          	auipc	a0,0x14
    80004610:	1e450513          	addi	a0,a0,484 # 800187f0 <bcache>
    80004614:	d37fc0ef          	jal	8000134a <acquire>
  b->refcnt++;
    80004618:	fe843783          	ld	a5,-24(s0)
    8000461c:	43bc                	lw	a5,64(a5)
    8000461e:	2785                	addiw	a5,a5,1
    80004620:	0007871b          	sext.w	a4,a5
    80004624:	fe843783          	ld	a5,-24(s0)
    80004628:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    8000462a:	00014517          	auipc	a0,0x14
    8000462e:	1c650513          	addi	a0,a0,454 # 800187f0 <bcache>
    80004632:	d6dfc0ef          	jal	8000139e <release>
}
    80004636:	0001                	nop
    80004638:	60e2                	ld	ra,24(sp)
    8000463a:	6442                	ld	s0,16(sp)
    8000463c:	6105                	addi	sp,sp,32
    8000463e:	8082                	ret

0000000080004640 <bunpin>:

void
bunpin(struct buf *b) {
    80004640:	1101                	addi	sp,sp,-32
    80004642:	ec06                	sd	ra,24(sp)
    80004644:	e822                	sd	s0,16(sp)
    80004646:	1000                	addi	s0,sp,32
    80004648:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    8000464c:	00014517          	auipc	a0,0x14
    80004650:	1a450513          	addi	a0,a0,420 # 800187f0 <bcache>
    80004654:	cf7fc0ef          	jal	8000134a <acquire>
  b->refcnt--;
    80004658:	fe843783          	ld	a5,-24(s0)
    8000465c:	43bc                	lw	a5,64(a5)
    8000465e:	37fd                	addiw	a5,a5,-1
    80004660:	0007871b          	sext.w	a4,a5
    80004664:	fe843783          	ld	a5,-24(s0)
    80004668:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    8000466a:	00014517          	auipc	a0,0x14
    8000466e:	18650513          	addi	a0,a0,390 # 800187f0 <bcache>
    80004672:	d2dfc0ef          	jal	8000139e <release>
}
    80004676:	0001                	nop
    80004678:	60e2                	ld	ra,24(sp)
    8000467a:	6442                	ld	s0,16(sp)
    8000467c:	6105                	addi	sp,sp,32
    8000467e:	8082                	ret

0000000080004680 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004680:	7179                	addi	sp,sp,-48
    80004682:	f406                	sd	ra,40(sp)
    80004684:	f022                	sd	s0,32(sp)
    80004686:	1800                	addi	s0,sp,48
    80004688:	87aa                	mv	a5,a0
    8000468a:	fcb43823          	sd	a1,-48(s0)
    8000468e:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004692:	fdc42783          	lw	a5,-36(s0)
    80004696:	4585                	li	a1,1
    80004698:	853e                	mv	a0,a5
    8000469a:	dffff0ef          	jal	80004498 <bread>
    8000469e:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    800046a2:	fe843783          	ld	a5,-24(s0)
    800046a6:	05878793          	addi	a5,a5,88
    800046aa:	02000613          	li	a2,32
    800046ae:	85be                	mv	a1,a5
    800046b0:	fd043503          	ld	a0,-48(s0)
    800046b4:	f0ffc0ef          	jal	800015c2 <memmove>
  brelse(bp);
    800046b8:	fe843503          	ld	a0,-24(s0)
    800046bc:	e6bff0ef          	jal	80004526 <brelse>
}
    800046c0:	0001                	nop
    800046c2:	70a2                	ld	ra,40(sp)
    800046c4:	7402                	ld	s0,32(sp)
    800046c6:	6145                	addi	sp,sp,48
    800046c8:	8082                	ret

00000000800046ca <fsinit>:

// Init fs
void
fsinit(int dev) {
    800046ca:	1101                	addi	sp,sp,-32
    800046cc:	ec06                	sd	ra,24(sp)
    800046ce:	e822                	sd	s0,16(sp)
    800046d0:	1000                	addi	s0,sp,32
    800046d2:	87aa                	mv	a5,a0
    800046d4:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    800046d8:	fec42783          	lw	a5,-20(s0)
    800046dc:	0001c597          	auipc	a1,0x1c
    800046e0:	7d458593          	addi	a1,a1,2004 # 80020eb0 <sb>
    800046e4:	853e                	mv	a0,a5
    800046e6:	f9bff0ef          	jal	80004680 <readsb>
  if(sb.magic != FSMAGIC)
    800046ea:	0001c797          	auipc	a5,0x1c
    800046ee:	7c678793          	addi	a5,a5,1990 # 80020eb0 <sb>
    800046f2:	4398                	lw	a4,0(a5)
    800046f4:	102037b7          	lui	a5,0x10203
    800046f8:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800046fc:	00f70863          	beq	a4,a5,8000470c <fsinit+0x42>
    panic("invalid file system");
    80004700:	00006517          	auipc	a0,0x6
    80004704:	d2850513          	addi	a0,a0,-728 # 8000a428 <etext+0x428>
    80004708:	f2efc0ef          	jal	80000e36 <panic>
  initlog(dev, &sb);
    8000470c:	fec42783          	lw	a5,-20(s0)
    80004710:	0001c597          	auipc	a1,0x1c
    80004714:	7a058593          	addi	a1,a1,1952 # 80020eb0 <sb>
    80004718:	853e                	mv	a0,a5
    8000471a:	3c6010ef          	jal	80005ae0 <initlog>
  ireclaim(dev);
    8000471e:	fec42783          	lw	a5,-20(s0)
    80004722:	853e                	mv	a0,a5
    80004724:	0b5000ef          	jal	80004fd8 <ireclaim>
}
    80004728:	0001                	nop
    8000472a:	60e2                	ld	ra,24(sp)
    8000472c:	6442                	ld	s0,16(sp)
    8000472e:	6105                	addi	sp,sp,32
    80004730:	8082                	ret

0000000080004732 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80004732:	7179                	addi	sp,sp,-48
    80004734:	f406                	sd	ra,40(sp)
    80004736:	f022                	sd	s0,32(sp)
    80004738:	1800                	addi	s0,sp,48
    8000473a:	87aa                	mv	a5,a0
    8000473c:	872e                	mv	a4,a1
    8000473e:	fcf42e23          	sw	a5,-36(s0)
    80004742:	87ba                	mv	a5,a4
    80004744:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80004748:	fdc42783          	lw	a5,-36(s0)
    8000474c:	fd842703          	lw	a4,-40(s0)
    80004750:	85ba                	mv	a1,a4
    80004752:	853e                	mv	a0,a5
    80004754:	d45ff0ef          	jal	80004498 <bread>
    80004758:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    8000475c:	fe843783          	ld	a5,-24(s0)
    80004760:	05878793          	addi	a5,a5,88
    80004764:	40000613          	li	a2,1024
    80004768:	4581                	li	a1,0
    8000476a:	853e                	mv	a0,a5
    8000476c:	d6bfc0ef          	jal	800014d6 <memset>
  log_write(bp);
    80004770:	fe843503          	ld	a0,-24(s0)
    80004774:	0bb010ef          	jal	8000602e <log_write>
  brelse(bp);
    80004778:	fe843503          	ld	a0,-24(s0)
    8000477c:	dabff0ef          	jal	80004526 <brelse>
}
    80004780:	0001                	nop
    80004782:	70a2                	ld	ra,40(sp)
    80004784:	7402                	ld	s0,32(sp)
    80004786:	6145                	addi	sp,sp,48
    80004788:	8082                	ret

000000008000478a <balloc>:

// Allocate a zeroed disk block.
// returns 0 if out of disk space.
static uint
balloc(uint dev)
{
    8000478a:	7139                	addi	sp,sp,-64
    8000478c:	fc06                	sd	ra,56(sp)
    8000478e:	f822                	sd	s0,48(sp)
    80004790:	0080                	addi	s0,sp,64
    80004792:	87aa                	mv	a5,a0
    80004794:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004798:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    8000479c:	fe042623          	sw	zero,-20(s0)
    800047a0:	a2a9                	j	800048ea <balloc+0x160>
    bp = bread(dev, BBLOCK(b, sb));
    800047a2:	fec42783          	lw	a5,-20(s0)
    800047a6:	41f7d71b          	sraiw	a4,a5,0x1f
    800047aa:	0137571b          	srliw	a4,a4,0x13
    800047ae:	9fb9                	addw	a5,a5,a4
    800047b0:	40d7d79b          	sraiw	a5,a5,0xd
    800047b4:	2781                	sext.w	a5,a5
    800047b6:	873e                	mv	a4,a5
    800047b8:	0001c797          	auipc	a5,0x1c
    800047bc:	6f878793          	addi	a5,a5,1784 # 80020eb0 <sb>
    800047c0:	4fdc                	lw	a5,28(a5)
    800047c2:	9fb9                	addw	a5,a5,a4
    800047c4:	0007871b          	sext.w	a4,a5
    800047c8:	fcc42783          	lw	a5,-52(s0)
    800047cc:	85ba                	mv	a1,a4
    800047ce:	853e                	mv	a0,a5
    800047d0:	cc9ff0ef          	jal	80004498 <bread>
    800047d4:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800047d8:	fe042423          	sw	zero,-24(s0)
    800047dc:	a0f1                	j	800048a8 <balloc+0x11e>
      m = 1 << (bi % 8);
    800047de:	fe842783          	lw	a5,-24(s0)
    800047e2:	8b9d                	andi	a5,a5,7
    800047e4:	2781                	sext.w	a5,a5
    800047e6:	4705                	li	a4,1
    800047e8:	00f717bb          	sllw	a5,a4,a5
    800047ec:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800047f0:	fe842783          	lw	a5,-24(s0)
    800047f4:	41f7d71b          	sraiw	a4,a5,0x1f
    800047f8:	01d7571b          	srliw	a4,a4,0x1d
    800047fc:	9fb9                	addw	a5,a5,a4
    800047fe:	4037d79b          	sraiw	a5,a5,0x3
    80004802:	2781                	sext.w	a5,a5
    80004804:	fe043703          	ld	a4,-32(s0)
    80004808:	97ba                	add	a5,a5,a4
    8000480a:	0587c783          	lbu	a5,88(a5)
    8000480e:	2781                	sext.w	a5,a5
    80004810:	fdc42703          	lw	a4,-36(s0)
    80004814:	8ff9                	and	a5,a5,a4
    80004816:	2781                	sext.w	a5,a5
    80004818:	e3d9                	bnez	a5,8000489e <balloc+0x114>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000481a:	fe842783          	lw	a5,-24(s0)
    8000481e:	41f7d71b          	sraiw	a4,a5,0x1f
    80004822:	01d7571b          	srliw	a4,a4,0x1d
    80004826:	9fb9                	addw	a5,a5,a4
    80004828:	4037d79b          	sraiw	a5,a5,0x3
    8000482c:	2781                	sext.w	a5,a5
    8000482e:	fe043703          	ld	a4,-32(s0)
    80004832:	973e                	add	a4,a4,a5
    80004834:	05874703          	lbu	a4,88(a4)
    80004838:	0187169b          	slliw	a3,a4,0x18
    8000483c:	4186d69b          	sraiw	a3,a3,0x18
    80004840:	fdc42703          	lw	a4,-36(s0)
    80004844:	0187171b          	slliw	a4,a4,0x18
    80004848:	4187571b          	sraiw	a4,a4,0x18
    8000484c:	8f55                	or	a4,a4,a3
    8000484e:	0187171b          	slliw	a4,a4,0x18
    80004852:	4187571b          	sraiw	a4,a4,0x18
    80004856:	0ff77713          	zext.b	a4,a4
    8000485a:	fe043683          	ld	a3,-32(s0)
    8000485e:	97b6                	add	a5,a5,a3
    80004860:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004864:	fe043503          	ld	a0,-32(s0)
    80004868:	7c6010ef          	jal	8000602e <log_write>
        brelse(bp);
    8000486c:	fe043503          	ld	a0,-32(s0)
    80004870:	cb7ff0ef          	jal	80004526 <brelse>
        bzero(dev, b + bi);
    80004874:	fcc42783          	lw	a5,-52(s0)
    80004878:	fec42703          	lw	a4,-20(s0)
    8000487c:	86ba                	mv	a3,a4
    8000487e:	fe842703          	lw	a4,-24(s0)
    80004882:	9f35                	addw	a4,a4,a3
    80004884:	2701                	sext.w	a4,a4
    80004886:	85ba                	mv	a1,a4
    80004888:	853e                	mv	a0,a5
    8000488a:	ea9ff0ef          	jal	80004732 <bzero>
        return b + bi;
    8000488e:	fec42783          	lw	a5,-20(s0)
    80004892:	873e                	mv	a4,a5
    80004894:	fe842783          	lw	a5,-24(s0)
    80004898:	9fb9                	addw	a5,a5,a4
    8000489a:	2781                	sext.w	a5,a5
    8000489c:	a0bd                	j	8000490a <balloc+0x180>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000489e:	fe842783          	lw	a5,-24(s0)
    800048a2:	2785                	addiw	a5,a5,1
    800048a4:	fef42423          	sw	a5,-24(s0)
    800048a8:	fe842783          	lw	a5,-24(s0)
    800048ac:	0007871b          	sext.w	a4,a5
    800048b0:	6789                	lui	a5,0x2
    800048b2:	02f75163          	bge	a4,a5,800048d4 <balloc+0x14a>
    800048b6:	fec42783          	lw	a5,-20(s0)
    800048ba:	873e                	mv	a4,a5
    800048bc:	fe842783          	lw	a5,-24(s0)
    800048c0:	9fb9                	addw	a5,a5,a4
    800048c2:	2781                	sext.w	a5,a5
    800048c4:	873e                	mv	a4,a5
    800048c6:	0001c797          	auipc	a5,0x1c
    800048ca:	5ea78793          	addi	a5,a5,1514 # 80020eb0 <sb>
    800048ce:	43dc                	lw	a5,4(a5)
    800048d0:	f0f767e3          	bltu	a4,a5,800047de <balloc+0x54>
      }
    }
    brelse(bp);
    800048d4:	fe043503          	ld	a0,-32(s0)
    800048d8:	c4fff0ef          	jal	80004526 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800048dc:	fec42783          	lw	a5,-20(s0)
    800048e0:	873e                	mv	a4,a5
    800048e2:	6789                	lui	a5,0x2
    800048e4:	9fb9                	addw	a5,a5,a4
    800048e6:	fef42623          	sw	a5,-20(s0)
    800048ea:	0001c797          	auipc	a5,0x1c
    800048ee:	5c678793          	addi	a5,a5,1478 # 80020eb0 <sb>
    800048f2:	43d8                	lw	a4,4(a5)
    800048f4:	fec42783          	lw	a5,-20(s0)
    800048f8:	eae7e5e3          	bltu	a5,a4,800047a2 <balloc+0x18>
  }
  printf("balloc: out of blocks\n");
    800048fc:	00006517          	auipc	a0,0x6
    80004900:	b4450513          	addi	a0,a0,-1212 # 8000a440 <etext+0x440>
    80004904:	8eafc0ef          	jal	800009ee <printf>
  return 0;
    80004908:	4781                	li	a5,0
}
    8000490a:	853e                	mv	a0,a5
    8000490c:	70e2                	ld	ra,56(sp)
    8000490e:	7442                	ld	s0,48(sp)
    80004910:	6121                	addi	sp,sp,64
    80004912:	8082                	ret

0000000080004914 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004914:	7179                	addi	sp,sp,-48
    80004916:	f406                	sd	ra,40(sp)
    80004918:	f022                	sd	s0,32(sp)
    8000491a:	1800                	addi	s0,sp,48
    8000491c:	87aa                	mv	a5,a0
    8000491e:	872e                	mv	a4,a1
    80004920:	fcf42e23          	sw	a5,-36(s0)
    80004924:	87ba                	mv	a5,a4
    80004926:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000492a:	fdc42683          	lw	a3,-36(s0)
    8000492e:	fd842783          	lw	a5,-40(s0)
    80004932:	00d7d79b          	srliw	a5,a5,0xd
    80004936:	0007871b          	sext.w	a4,a5
    8000493a:	0001c797          	auipc	a5,0x1c
    8000493e:	57678793          	addi	a5,a5,1398 # 80020eb0 <sb>
    80004942:	4fdc                	lw	a5,28(a5)
    80004944:	9fb9                	addw	a5,a5,a4
    80004946:	2781                	sext.w	a5,a5
    80004948:	85be                	mv	a1,a5
    8000494a:	8536                	mv	a0,a3
    8000494c:	b4dff0ef          	jal	80004498 <bread>
    80004950:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004954:	fd842703          	lw	a4,-40(s0)
    80004958:	6789                	lui	a5,0x2
    8000495a:	17fd                	addi	a5,a5,-1 # 1fff <_entry-0x7fffe001>
    8000495c:	8ff9                	and	a5,a5,a4
    8000495e:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004962:	fe442783          	lw	a5,-28(s0)
    80004966:	8b9d                	andi	a5,a5,7
    80004968:	2781                	sext.w	a5,a5
    8000496a:	4705                	li	a4,1
    8000496c:	00f717bb          	sllw	a5,a4,a5
    80004970:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004974:	fe442783          	lw	a5,-28(s0)
    80004978:	41f7d71b          	sraiw	a4,a5,0x1f
    8000497c:	01d7571b          	srliw	a4,a4,0x1d
    80004980:	9fb9                	addw	a5,a5,a4
    80004982:	4037d79b          	sraiw	a5,a5,0x3
    80004986:	2781                	sext.w	a5,a5
    80004988:	fe843703          	ld	a4,-24(s0)
    8000498c:	97ba                	add	a5,a5,a4
    8000498e:	0587c783          	lbu	a5,88(a5)
    80004992:	2781                	sext.w	a5,a5
    80004994:	fe042703          	lw	a4,-32(s0)
    80004998:	8ff9                	and	a5,a5,a4
    8000499a:	2781                	sext.w	a5,a5
    8000499c:	e799                	bnez	a5,800049aa <bfree+0x96>
    panic("freeing free block");
    8000499e:	00006517          	auipc	a0,0x6
    800049a2:	aba50513          	addi	a0,a0,-1350 # 8000a458 <etext+0x458>
    800049a6:	c90fc0ef          	jal	80000e36 <panic>
  bp->data[bi/8] &= ~m;
    800049aa:	fe442783          	lw	a5,-28(s0)
    800049ae:	41f7d71b          	sraiw	a4,a5,0x1f
    800049b2:	01d7571b          	srliw	a4,a4,0x1d
    800049b6:	9fb9                	addw	a5,a5,a4
    800049b8:	4037d79b          	sraiw	a5,a5,0x3
    800049bc:	2781                	sext.w	a5,a5
    800049be:	fe843703          	ld	a4,-24(s0)
    800049c2:	973e                	add	a4,a4,a5
    800049c4:	05874703          	lbu	a4,88(a4)
    800049c8:	0187169b          	slliw	a3,a4,0x18
    800049cc:	4186d69b          	sraiw	a3,a3,0x18
    800049d0:	fe042703          	lw	a4,-32(s0)
    800049d4:	0187171b          	slliw	a4,a4,0x18
    800049d8:	4187571b          	sraiw	a4,a4,0x18
    800049dc:	fff74713          	not	a4,a4
    800049e0:	0187171b          	slliw	a4,a4,0x18
    800049e4:	4187571b          	sraiw	a4,a4,0x18
    800049e8:	8f75                	and	a4,a4,a3
    800049ea:	0187171b          	slliw	a4,a4,0x18
    800049ee:	4187571b          	sraiw	a4,a4,0x18
    800049f2:	0ff77713          	zext.b	a4,a4
    800049f6:	fe843683          	ld	a3,-24(s0)
    800049fa:	97b6                	add	a5,a5,a3
    800049fc:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80004a00:	fe843503          	ld	a0,-24(s0)
    80004a04:	62a010ef          	jal	8000602e <log_write>
  brelse(bp);
    80004a08:	fe843503          	ld	a0,-24(s0)
    80004a0c:	b1bff0ef          	jal	80004526 <brelse>
}
    80004a10:	0001                	nop
    80004a12:	70a2                	ld	ra,40(sp)
    80004a14:	7402                	ld	s0,32(sp)
    80004a16:	6145                	addi	sp,sp,48
    80004a18:	8082                	ret

0000000080004a1a <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80004a1a:	1101                	addi	sp,sp,-32
    80004a1c:	ec06                	sd	ra,24(sp)
    80004a1e:	e822                	sd	s0,16(sp)
    80004a20:	1000                	addi	s0,sp,32
  int i = 0;
    80004a22:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80004a26:	00006597          	auipc	a1,0x6
    80004a2a:	a4a58593          	addi	a1,a1,-1462 # 8000a470 <etext+0x470>
    80004a2e:	0001c517          	auipc	a0,0x1c
    80004a32:	4a250513          	addi	a0,a0,1186 # 80020ed0 <itable>
    80004a36:	8e1fc0ef          	jal	80001316 <initlock>
  for(i = 0; i < NINODE; i++) {
    80004a3a:	fe042623          	sw	zero,-20(s0)
    80004a3e:	a81d                	j	80004a74 <iinit+0x5a>
    initsleeplock(&itable.inode[i].lock, "inode");
    80004a40:	fec42703          	lw	a4,-20(s0)
    80004a44:	87ba                	mv	a5,a4
    80004a46:	0792                	slli	a5,a5,0x4
    80004a48:	97ba                	add	a5,a5,a4
    80004a4a:	078e                	slli	a5,a5,0x3
    80004a4c:	02078713          	addi	a4,a5,32
    80004a50:	0001c797          	auipc	a5,0x1c
    80004a54:	48078793          	addi	a5,a5,1152 # 80020ed0 <itable>
    80004a58:	97ba                	add	a5,a5,a4
    80004a5a:	07a1                	addi	a5,a5,8
    80004a5c:	00006597          	auipc	a1,0x6
    80004a60:	a1c58593          	addi	a1,a1,-1508 # 8000a478 <etext+0x478>
    80004a64:	853e                	mv	a0,a5
    80004a66:	6c6010ef          	jal	8000612c <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80004a6a:	fec42783          	lw	a5,-20(s0)
    80004a6e:	2785                	addiw	a5,a5,1
    80004a70:	fef42623          	sw	a5,-20(s0)
    80004a74:	fec42783          	lw	a5,-20(s0)
    80004a78:	0007871b          	sext.w	a4,a5
    80004a7c:	03100793          	li	a5,49
    80004a80:	fce7d0e3          	bge	a5,a4,80004a40 <iinit+0x26>
  }
}
    80004a84:	0001                	nop
    80004a86:	0001                	nop
    80004a88:	60e2                	ld	ra,24(sp)
    80004a8a:	6442                	ld	s0,16(sp)
    80004a8c:	6105                	addi	sp,sp,32
    80004a8e:	8082                	ret

0000000080004a90 <ialloc>:
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode,
// or NULL if there is no free inode.
struct inode*
ialloc(uint dev, short type)
{
    80004a90:	7139                	addi	sp,sp,-64
    80004a92:	fc06                	sd	ra,56(sp)
    80004a94:	f822                	sd	s0,48(sp)
    80004a96:	0080                	addi	s0,sp,64
    80004a98:	87aa                	mv	a5,a0
    80004a9a:	872e                	mv	a4,a1
    80004a9c:	fcf42623          	sw	a5,-52(s0)
    80004aa0:	87ba                	mv	a5,a4
    80004aa2:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    80004aa6:	4785                	li	a5,1
    80004aa8:	fef42623          	sw	a5,-20(s0)
    80004aac:	a871                	j	80004b48 <ialloc+0xb8>
    bp = bread(dev, IBLOCK(inum, sb));
    80004aae:	fec42783          	lw	a5,-20(s0)
    80004ab2:	8391                	srli	a5,a5,0x4
    80004ab4:	0007871b          	sext.w	a4,a5
    80004ab8:	0001c797          	auipc	a5,0x1c
    80004abc:	3f878793          	addi	a5,a5,1016 # 80020eb0 <sb>
    80004ac0:	4f9c                	lw	a5,24(a5)
    80004ac2:	9fb9                	addw	a5,a5,a4
    80004ac4:	0007871b          	sext.w	a4,a5
    80004ac8:	fcc42783          	lw	a5,-52(s0)
    80004acc:	85ba                	mv	a1,a4
    80004ace:	853e                	mv	a0,a5
    80004ad0:	9c9ff0ef          	jal	80004498 <bread>
    80004ad4:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80004ad8:	fe043783          	ld	a5,-32(s0)
    80004adc:	05878713          	addi	a4,a5,88
    80004ae0:	fec42783          	lw	a5,-20(s0)
    80004ae4:	8bbd                	andi	a5,a5,15
    80004ae6:	079a                	slli	a5,a5,0x6
    80004ae8:	97ba                	add	a5,a5,a4
    80004aea:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80004aee:	fd843783          	ld	a5,-40(s0)
    80004af2:	00079783          	lh	a5,0(a5)
    80004af6:	e3a1                	bnez	a5,80004b36 <ialloc+0xa6>
      memset(dip, 0, sizeof(*dip));
    80004af8:	04000613          	li	a2,64
    80004afc:	4581                	li	a1,0
    80004afe:	fd843503          	ld	a0,-40(s0)
    80004b02:	9d5fc0ef          	jal	800014d6 <memset>
      dip->type = type;
    80004b06:	fd843783          	ld	a5,-40(s0)
    80004b0a:	fca45703          	lhu	a4,-54(s0)
    80004b0e:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80004b12:	fe043503          	ld	a0,-32(s0)
    80004b16:	518010ef          	jal	8000602e <log_write>
      brelse(bp);
    80004b1a:	fe043503          	ld	a0,-32(s0)
    80004b1e:	a09ff0ef          	jal	80004526 <brelse>
      return iget(dev, inum);
    80004b22:	fec42703          	lw	a4,-20(s0)
    80004b26:	fcc42783          	lw	a5,-52(s0)
    80004b2a:	85ba                	mv	a1,a4
    80004b2c:	853e                	mv	a0,a5
    80004b2e:	11c000ef          	jal	80004c4a <iget>
    80004b32:	87aa                	mv	a5,a0
    80004b34:	a815                	j	80004b68 <ialloc+0xd8>
    }
    brelse(bp);
    80004b36:	fe043503          	ld	a0,-32(s0)
    80004b3a:	9edff0ef          	jal	80004526 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80004b3e:	fec42783          	lw	a5,-20(s0)
    80004b42:	2785                	addiw	a5,a5,1
    80004b44:	fef42623          	sw	a5,-20(s0)
    80004b48:	0001c797          	auipc	a5,0x1c
    80004b4c:	36878793          	addi	a5,a5,872 # 80020eb0 <sb>
    80004b50:	47d8                	lw	a4,12(a5)
    80004b52:	fec42783          	lw	a5,-20(s0)
    80004b56:	f4e7ece3          	bltu	a5,a4,80004aae <ialloc+0x1e>
  }
  printf("ialloc: no inodes\n");
    80004b5a:	00006517          	auipc	a0,0x6
    80004b5e:	92650513          	addi	a0,a0,-1754 # 8000a480 <etext+0x480>
    80004b62:	e8dfb0ef          	jal	800009ee <printf>
  return 0;
    80004b66:	4781                	li	a5,0
}
    80004b68:	853e                	mv	a0,a5
    80004b6a:	70e2                	ld	ra,56(sp)
    80004b6c:	7442                	ld	s0,48(sp)
    80004b6e:	6121                	addi	sp,sp,64
    80004b70:	8082                	ret

0000000080004b72 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80004b72:	7179                	addi	sp,sp,-48
    80004b74:	f406                	sd	ra,40(sp)
    80004b76:	f022                	sd	s0,32(sp)
    80004b78:	1800                	addi	s0,sp,48
    80004b7a:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004b7e:	fd843783          	ld	a5,-40(s0)
    80004b82:	4394                	lw	a3,0(a5)
    80004b84:	fd843783          	ld	a5,-40(s0)
    80004b88:	43dc                	lw	a5,4(a5)
    80004b8a:	0047d79b          	srliw	a5,a5,0x4
    80004b8e:	0007871b          	sext.w	a4,a5
    80004b92:	0001c797          	auipc	a5,0x1c
    80004b96:	31e78793          	addi	a5,a5,798 # 80020eb0 <sb>
    80004b9a:	4f9c                	lw	a5,24(a5)
    80004b9c:	9fb9                	addw	a5,a5,a4
    80004b9e:	2781                	sext.w	a5,a5
    80004ba0:	85be                	mv	a1,a5
    80004ba2:	8536                	mv	a0,a3
    80004ba4:	8f5ff0ef          	jal	80004498 <bread>
    80004ba8:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004bac:	fe843783          	ld	a5,-24(s0)
    80004bb0:	05878713          	addi	a4,a5,88
    80004bb4:	fd843783          	ld	a5,-40(s0)
    80004bb8:	43dc                	lw	a5,4(a5)
    80004bba:	1782                	slli	a5,a5,0x20
    80004bbc:	9381                	srli	a5,a5,0x20
    80004bbe:	8bbd                	andi	a5,a5,15
    80004bc0:	079a                	slli	a5,a5,0x6
    80004bc2:	97ba                	add	a5,a5,a4
    80004bc4:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80004bc8:	fd843783          	ld	a5,-40(s0)
    80004bcc:	04479703          	lh	a4,68(a5)
    80004bd0:	fe043783          	ld	a5,-32(s0)
    80004bd4:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80004bd8:	fd843783          	ld	a5,-40(s0)
    80004bdc:	04679703          	lh	a4,70(a5)
    80004be0:	fe043783          	ld	a5,-32(s0)
    80004be4:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80004be8:	fd843783          	ld	a5,-40(s0)
    80004bec:	04879703          	lh	a4,72(a5)
    80004bf0:	fe043783          	ld	a5,-32(s0)
    80004bf4:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80004bf8:	fd843783          	ld	a5,-40(s0)
    80004bfc:	04a79703          	lh	a4,74(a5)
    80004c00:	fe043783          	ld	a5,-32(s0)
    80004c04:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80004c08:	fd843783          	ld	a5,-40(s0)
    80004c0c:	47f8                	lw	a4,76(a5)
    80004c0e:	fe043783          	ld	a5,-32(s0)
    80004c12:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80004c14:	fe043783          	ld	a5,-32(s0)
    80004c18:	00c78713          	addi	a4,a5,12
    80004c1c:	fd843783          	ld	a5,-40(s0)
    80004c20:	05078793          	addi	a5,a5,80
    80004c24:	03400613          	li	a2,52
    80004c28:	85be                	mv	a1,a5
    80004c2a:	853a                	mv	a0,a4
    80004c2c:	997fc0ef          	jal	800015c2 <memmove>
  log_write(bp);
    80004c30:	fe843503          	ld	a0,-24(s0)
    80004c34:	3fa010ef          	jal	8000602e <log_write>
  brelse(bp);
    80004c38:	fe843503          	ld	a0,-24(s0)
    80004c3c:	8ebff0ef          	jal	80004526 <brelse>
}
    80004c40:	0001                	nop
    80004c42:	70a2                	ld	ra,40(sp)
    80004c44:	7402                	ld	s0,32(sp)
    80004c46:	6145                	addi	sp,sp,48
    80004c48:	8082                	ret

0000000080004c4a <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80004c4a:	7179                	addi	sp,sp,-48
    80004c4c:	f406                	sd	ra,40(sp)
    80004c4e:	f022                	sd	s0,32(sp)
    80004c50:	1800                	addi	s0,sp,48
    80004c52:	87aa                	mv	a5,a0
    80004c54:	872e                	mv	a4,a1
    80004c56:	fcf42e23          	sw	a5,-36(s0)
    80004c5a:	87ba                	mv	a5,a4
    80004c5c:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    80004c60:	0001c517          	auipc	a0,0x1c
    80004c64:	27050513          	addi	a0,a0,624 # 80020ed0 <itable>
    80004c68:	ee2fc0ef          	jal	8000134a <acquire>

  // Is the inode already in the table?
  empty = 0;
    80004c6c:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80004c70:	0001c797          	auipc	a5,0x1c
    80004c74:	27878793          	addi	a5,a5,632 # 80020ee8 <itable+0x18>
    80004c78:	fef43423          	sd	a5,-24(s0)
    80004c7c:	a88d                	j	80004cee <iget+0xa4>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80004c7e:	fe843783          	ld	a5,-24(s0)
    80004c82:	479c                	lw	a5,8(a5)
    80004c84:	04f05463          	blez	a5,80004ccc <iget+0x82>
    80004c88:	fe843783          	ld	a5,-24(s0)
    80004c8c:	439c                	lw	a5,0(a5)
    80004c8e:	fdc42703          	lw	a4,-36(s0)
    80004c92:	2701                	sext.w	a4,a4
    80004c94:	02f71c63          	bne	a4,a5,80004ccc <iget+0x82>
    80004c98:	fe843783          	ld	a5,-24(s0)
    80004c9c:	43dc                	lw	a5,4(a5)
    80004c9e:	fd842703          	lw	a4,-40(s0)
    80004ca2:	2701                	sext.w	a4,a4
    80004ca4:	02f71463          	bne	a4,a5,80004ccc <iget+0x82>
      ip->ref++;
    80004ca8:	fe843783          	ld	a5,-24(s0)
    80004cac:	479c                	lw	a5,8(a5)
    80004cae:	2785                	addiw	a5,a5,1
    80004cb0:	0007871b          	sext.w	a4,a5
    80004cb4:	fe843783          	ld	a5,-24(s0)
    80004cb8:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80004cba:	0001c517          	auipc	a0,0x1c
    80004cbe:	21650513          	addi	a0,a0,534 # 80020ed0 <itable>
    80004cc2:	edcfc0ef          	jal	8000139e <release>
      return ip;
    80004cc6:	fe843783          	ld	a5,-24(s0)
    80004cca:	a049                	j	80004d4c <iget+0x102>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80004ccc:	fe043783          	ld	a5,-32(s0)
    80004cd0:	eb89                	bnez	a5,80004ce2 <iget+0x98>
    80004cd2:	fe843783          	ld	a5,-24(s0)
    80004cd6:	479c                	lw	a5,8(a5)
    80004cd8:	e789                	bnez	a5,80004ce2 <iget+0x98>
      empty = ip;
    80004cda:	fe843783          	ld	a5,-24(s0)
    80004cde:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80004ce2:	fe843783          	ld	a5,-24(s0)
    80004ce6:	08878793          	addi	a5,a5,136
    80004cea:	fef43423          	sd	a5,-24(s0)
    80004cee:	fe843703          	ld	a4,-24(s0)
    80004cf2:	0001e797          	auipc	a5,0x1e
    80004cf6:	c8678793          	addi	a5,a5,-890 # 80022978 <log>
    80004cfa:	f8f762e3          	bltu	a4,a5,80004c7e <iget+0x34>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80004cfe:	fe043783          	ld	a5,-32(s0)
    80004d02:	e799                	bnez	a5,80004d10 <iget+0xc6>
    panic("iget: no inodes");
    80004d04:	00005517          	auipc	a0,0x5
    80004d08:	79450513          	addi	a0,a0,1940 # 8000a498 <etext+0x498>
    80004d0c:	92afc0ef          	jal	80000e36 <panic>

  ip = empty;
    80004d10:	fe043783          	ld	a5,-32(s0)
    80004d14:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80004d18:	fe843783          	ld	a5,-24(s0)
    80004d1c:	fdc42703          	lw	a4,-36(s0)
    80004d20:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80004d22:	fe843783          	ld	a5,-24(s0)
    80004d26:	fd842703          	lw	a4,-40(s0)
    80004d2a:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80004d2c:	fe843783          	ld	a5,-24(s0)
    80004d30:	4705                	li	a4,1
    80004d32:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80004d34:	fe843783          	ld	a5,-24(s0)
    80004d38:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80004d3c:	0001c517          	auipc	a0,0x1c
    80004d40:	19450513          	addi	a0,a0,404 # 80020ed0 <itable>
    80004d44:	e5afc0ef          	jal	8000139e <release>

  return ip;
    80004d48:	fe843783          	ld	a5,-24(s0)
}
    80004d4c:	853e                	mv	a0,a5
    80004d4e:	70a2                	ld	ra,40(sp)
    80004d50:	7402                	ld	s0,32(sp)
    80004d52:	6145                	addi	sp,sp,48
    80004d54:	8082                	ret

0000000080004d56 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80004d56:	1101                	addi	sp,sp,-32
    80004d58:	ec06                	sd	ra,24(sp)
    80004d5a:	e822                	sd	s0,16(sp)
    80004d5c:	1000                	addi	s0,sp,32
    80004d5e:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80004d62:	0001c517          	auipc	a0,0x1c
    80004d66:	16e50513          	addi	a0,a0,366 # 80020ed0 <itable>
    80004d6a:	de0fc0ef          	jal	8000134a <acquire>
  ip->ref++;
    80004d6e:	fe843783          	ld	a5,-24(s0)
    80004d72:	479c                	lw	a5,8(a5)
    80004d74:	2785                	addiw	a5,a5,1
    80004d76:	0007871b          	sext.w	a4,a5
    80004d7a:	fe843783          	ld	a5,-24(s0)
    80004d7e:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80004d80:	0001c517          	auipc	a0,0x1c
    80004d84:	15050513          	addi	a0,a0,336 # 80020ed0 <itable>
    80004d88:	e16fc0ef          	jal	8000139e <release>
  return ip;
    80004d8c:	fe843783          	ld	a5,-24(s0)
}
    80004d90:	853e                	mv	a0,a5
    80004d92:	60e2                	ld	ra,24(sp)
    80004d94:	6442                	ld	s0,16(sp)
    80004d96:	6105                	addi	sp,sp,32
    80004d98:	8082                	ret

0000000080004d9a <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80004d9a:	7179                	addi	sp,sp,-48
    80004d9c:	f406                	sd	ra,40(sp)
    80004d9e:	f022                	sd	s0,32(sp)
    80004da0:	1800                	addi	s0,sp,48
    80004da2:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80004da6:	fd843783          	ld	a5,-40(s0)
    80004daa:	c791                	beqz	a5,80004db6 <ilock+0x1c>
    80004dac:	fd843783          	ld	a5,-40(s0)
    80004db0:	479c                	lw	a5,8(a5)
    80004db2:	00f04863          	bgtz	a5,80004dc2 <ilock+0x28>
    panic("ilock");
    80004db6:	00005517          	auipc	a0,0x5
    80004dba:	6f250513          	addi	a0,a0,1778 # 8000a4a8 <etext+0x4a8>
    80004dbe:	878fc0ef          	jal	80000e36 <panic>

  acquiresleep(&ip->lock);
    80004dc2:	fd843783          	ld	a5,-40(s0)
    80004dc6:	07c1                	addi	a5,a5,16
    80004dc8:	853e                	mv	a0,a5
    80004dca:	3aa010ef          	jal	80006174 <acquiresleep>

  if(ip->valid == 0){
    80004dce:	fd843783          	ld	a5,-40(s0)
    80004dd2:	43bc                	lw	a5,64(a5)
    80004dd4:	efe1                	bnez	a5,80004eac <ilock+0x112>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004dd6:	fd843783          	ld	a5,-40(s0)
    80004dda:	4394                	lw	a3,0(a5)
    80004ddc:	fd843783          	ld	a5,-40(s0)
    80004de0:	43dc                	lw	a5,4(a5)
    80004de2:	0047d79b          	srliw	a5,a5,0x4
    80004de6:	0007871b          	sext.w	a4,a5
    80004dea:	0001c797          	auipc	a5,0x1c
    80004dee:	0c678793          	addi	a5,a5,198 # 80020eb0 <sb>
    80004df2:	4f9c                	lw	a5,24(a5)
    80004df4:	9fb9                	addw	a5,a5,a4
    80004df6:	2781                	sext.w	a5,a5
    80004df8:	85be                	mv	a1,a5
    80004dfa:	8536                	mv	a0,a3
    80004dfc:	e9cff0ef          	jal	80004498 <bread>
    80004e00:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004e04:	fe843783          	ld	a5,-24(s0)
    80004e08:	05878713          	addi	a4,a5,88
    80004e0c:	fd843783          	ld	a5,-40(s0)
    80004e10:	43dc                	lw	a5,4(a5)
    80004e12:	1782                	slli	a5,a5,0x20
    80004e14:	9381                	srli	a5,a5,0x20
    80004e16:	8bbd                	andi	a5,a5,15
    80004e18:	079a                	slli	a5,a5,0x6
    80004e1a:	97ba                	add	a5,a5,a4
    80004e1c:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80004e20:	fe043783          	ld	a5,-32(s0)
    80004e24:	00079703          	lh	a4,0(a5)
    80004e28:	fd843783          	ld	a5,-40(s0)
    80004e2c:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80004e30:	fe043783          	ld	a5,-32(s0)
    80004e34:	00279703          	lh	a4,2(a5)
    80004e38:	fd843783          	ld	a5,-40(s0)
    80004e3c:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80004e40:	fe043783          	ld	a5,-32(s0)
    80004e44:	00479703          	lh	a4,4(a5)
    80004e48:	fd843783          	ld	a5,-40(s0)
    80004e4c:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80004e50:	fe043783          	ld	a5,-32(s0)
    80004e54:	00679703          	lh	a4,6(a5)
    80004e58:	fd843783          	ld	a5,-40(s0)
    80004e5c:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80004e60:	fe043783          	ld	a5,-32(s0)
    80004e64:	4798                	lw	a4,8(a5)
    80004e66:	fd843783          	ld	a5,-40(s0)
    80004e6a:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80004e6c:	fd843783          	ld	a5,-40(s0)
    80004e70:	05078713          	addi	a4,a5,80
    80004e74:	fe043783          	ld	a5,-32(s0)
    80004e78:	07b1                	addi	a5,a5,12
    80004e7a:	03400613          	li	a2,52
    80004e7e:	85be                	mv	a1,a5
    80004e80:	853a                	mv	a0,a4
    80004e82:	f40fc0ef          	jal	800015c2 <memmove>
    brelse(bp);
    80004e86:	fe843503          	ld	a0,-24(s0)
    80004e8a:	e9cff0ef          	jal	80004526 <brelse>
    ip->valid = 1;
    80004e8e:	fd843783          	ld	a5,-40(s0)
    80004e92:	4705                	li	a4,1
    80004e94:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80004e96:	fd843783          	ld	a5,-40(s0)
    80004e9a:	04479783          	lh	a5,68(a5)
    80004e9e:	e799                	bnez	a5,80004eac <ilock+0x112>
      panic("ilock: no type");
    80004ea0:	00005517          	auipc	a0,0x5
    80004ea4:	61050513          	addi	a0,a0,1552 # 8000a4b0 <etext+0x4b0>
    80004ea8:	f8ffb0ef          	jal	80000e36 <panic>
  }
}
    80004eac:	0001                	nop
    80004eae:	70a2                	ld	ra,40(sp)
    80004eb0:	7402                	ld	s0,32(sp)
    80004eb2:	6145                	addi	sp,sp,48
    80004eb4:	8082                	ret

0000000080004eb6 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80004eb6:	1101                	addi	sp,sp,-32
    80004eb8:	ec06                	sd	ra,24(sp)
    80004eba:	e822                	sd	s0,16(sp)
    80004ebc:	1000                	addi	s0,sp,32
    80004ebe:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80004ec2:	fe843783          	ld	a5,-24(s0)
    80004ec6:	cf91                	beqz	a5,80004ee2 <iunlock+0x2c>
    80004ec8:	fe843783          	ld	a5,-24(s0)
    80004ecc:	07c1                	addi	a5,a5,16
    80004ece:	853e                	mv	a0,a5
    80004ed0:	348010ef          	jal	80006218 <holdingsleep>
    80004ed4:	87aa                	mv	a5,a0
    80004ed6:	c791                	beqz	a5,80004ee2 <iunlock+0x2c>
    80004ed8:	fe843783          	ld	a5,-24(s0)
    80004edc:	479c                	lw	a5,8(a5)
    80004ede:	00f04863          	bgtz	a5,80004eee <iunlock+0x38>
    panic("iunlock");
    80004ee2:	00005517          	auipc	a0,0x5
    80004ee6:	5de50513          	addi	a0,a0,1502 # 8000a4c0 <etext+0x4c0>
    80004eea:	f4dfb0ef          	jal	80000e36 <panic>

  releasesleep(&ip->lock);
    80004eee:	fe843783          	ld	a5,-24(s0)
    80004ef2:	07c1                	addi	a5,a5,16
    80004ef4:	853e                	mv	a0,a5
    80004ef6:	2dc010ef          	jal	800061d2 <releasesleep>
}
    80004efa:	0001                	nop
    80004efc:	60e2                	ld	ra,24(sp)
    80004efe:	6442                	ld	s0,16(sp)
    80004f00:	6105                	addi	sp,sp,32
    80004f02:	8082                	ret

0000000080004f04 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    80004f04:	1101                	addi	sp,sp,-32
    80004f06:	ec06                	sd	ra,24(sp)
    80004f08:	e822                	sd	s0,16(sp)
    80004f0a:	1000                	addi	s0,sp,32
    80004f0c:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80004f10:	0001c517          	auipc	a0,0x1c
    80004f14:	fc050513          	addi	a0,a0,-64 # 80020ed0 <itable>
    80004f18:	c32fc0ef          	jal	8000134a <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80004f1c:	fe843783          	ld	a5,-24(s0)
    80004f20:	4798                	lw	a4,8(a5)
    80004f22:	4785                	li	a5,1
    80004f24:	06f71363          	bne	a4,a5,80004f8a <iput+0x86>
    80004f28:	fe843783          	ld	a5,-24(s0)
    80004f2c:	43bc                	lw	a5,64(a5)
    80004f2e:	cfb1                	beqz	a5,80004f8a <iput+0x86>
    80004f30:	fe843783          	ld	a5,-24(s0)
    80004f34:	04a79783          	lh	a5,74(a5)
    80004f38:	eba9                	bnez	a5,80004f8a <iput+0x86>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    80004f3a:	fe843783          	ld	a5,-24(s0)
    80004f3e:	07c1                	addi	a5,a5,16
    80004f40:	853e                	mv	a0,a5
    80004f42:	232010ef          	jal	80006174 <acquiresleep>

    release(&itable.lock);
    80004f46:	0001c517          	auipc	a0,0x1c
    80004f4a:	f8a50513          	addi	a0,a0,-118 # 80020ed0 <itable>
    80004f4e:	c50fc0ef          	jal	8000139e <release>

    itrunc(ip);
    80004f52:	fe843503          	ld	a0,-24(s0)
    80004f56:	2ca000ef          	jal	80005220 <itrunc>
    ip->type = 0;
    80004f5a:	fe843783          	ld	a5,-24(s0)
    80004f5e:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80004f62:	fe843503          	ld	a0,-24(s0)
    80004f66:	c0dff0ef          	jal	80004b72 <iupdate>
    ip->valid = 0;
    80004f6a:	fe843783          	ld	a5,-24(s0)
    80004f6e:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80004f72:	fe843783          	ld	a5,-24(s0)
    80004f76:	07c1                	addi	a5,a5,16
    80004f78:	853e                	mv	a0,a5
    80004f7a:	258010ef          	jal	800061d2 <releasesleep>

    acquire(&itable.lock);
    80004f7e:	0001c517          	auipc	a0,0x1c
    80004f82:	f5250513          	addi	a0,a0,-174 # 80020ed0 <itable>
    80004f86:	bc4fc0ef          	jal	8000134a <acquire>
  }

  ip->ref--;
    80004f8a:	fe843783          	ld	a5,-24(s0)
    80004f8e:	479c                	lw	a5,8(a5)
    80004f90:	37fd                	addiw	a5,a5,-1
    80004f92:	0007871b          	sext.w	a4,a5
    80004f96:	fe843783          	ld	a5,-24(s0)
    80004f9a:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80004f9c:	0001c517          	auipc	a0,0x1c
    80004fa0:	f3450513          	addi	a0,a0,-204 # 80020ed0 <itable>
    80004fa4:	bfafc0ef          	jal	8000139e <release>
}
    80004fa8:	0001                	nop
    80004faa:	60e2                	ld	ra,24(sp)
    80004fac:	6442                	ld	s0,16(sp)
    80004fae:	6105                	addi	sp,sp,32
    80004fb0:	8082                	ret

0000000080004fb2 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80004fb2:	1101                	addi	sp,sp,-32
    80004fb4:	ec06                	sd	ra,24(sp)
    80004fb6:	e822                	sd	s0,16(sp)
    80004fb8:	1000                	addi	s0,sp,32
    80004fba:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    80004fbe:	fe843503          	ld	a0,-24(s0)
    80004fc2:	ef5ff0ef          	jal	80004eb6 <iunlock>
  iput(ip);
    80004fc6:	fe843503          	ld	a0,-24(s0)
    80004fca:	f3bff0ef          	jal	80004f04 <iput>
}
    80004fce:	0001                	nop
    80004fd0:	60e2                	ld	ra,24(sp)
    80004fd2:	6442                	ld	s0,16(sp)
    80004fd4:	6105                	addi	sp,sp,32
    80004fd6:	8082                	ret

0000000080004fd8 <ireclaim>:

void
ireclaim(int dev)
{
    80004fd8:	7139                	addi	sp,sp,-64
    80004fda:	fc06                	sd	ra,56(sp)
    80004fdc:	f822                	sd	s0,48(sp)
    80004fde:	0080                	addi	s0,sp,64
    80004fe0:	87aa                	mv	a5,a0
    80004fe2:	fcf42623          	sw	a5,-52(s0)
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80004fe6:	4785                	li	a5,1
    80004fe8:	fef42623          	sw	a5,-20(s0)
    80004fec:	a85d                	j	800050a2 <ireclaim+0xca>
    struct inode *ip = 0;
    80004fee:	fe043023          	sd	zero,-32(s0)
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80004ff2:	fcc42683          	lw	a3,-52(s0)
    80004ff6:	fec42783          	lw	a5,-20(s0)
    80004ffa:	8391                	srli	a5,a5,0x4
    80004ffc:	0007871b          	sext.w	a4,a5
    80005000:	0001c797          	auipc	a5,0x1c
    80005004:	eb078793          	addi	a5,a5,-336 # 80020eb0 <sb>
    80005008:	4f9c                	lw	a5,24(a5)
    8000500a:	9fb9                	addw	a5,a5,a4
    8000500c:	2781                	sext.w	a5,a5
    8000500e:	85be                	mv	a1,a5
    80005010:	8536                	mv	a0,a3
    80005012:	c86ff0ef          	jal	80004498 <bread>
    80005016:	fca43c23          	sd	a0,-40(s0)
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    8000501a:	fd843783          	ld	a5,-40(s0)
    8000501e:	05878713          	addi	a4,a5,88
    80005022:	fec42783          	lw	a5,-20(s0)
    80005026:	8bbd                	andi	a5,a5,15
    80005028:	079a                	slli	a5,a5,0x6
    8000502a:	97ba                	add	a5,a5,a4
    8000502c:	fcf43823          	sd	a5,-48(s0)
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    80005030:	fd043783          	ld	a5,-48(s0)
    80005034:	00079783          	lh	a5,0(a5)
    80005038:	cb8d                	beqz	a5,8000506a <ireclaim+0x92>
    8000503a:	fd043783          	ld	a5,-48(s0)
    8000503e:	00679783          	lh	a5,6(a5)
    80005042:	e785                	bnez	a5,8000506a <ireclaim+0x92>
      printf("ireclaim: orphaned inode %d\n", inum);
    80005044:	fec42783          	lw	a5,-20(s0)
    80005048:	85be                	mv	a1,a5
    8000504a:	00005517          	auipc	a0,0x5
    8000504e:	47e50513          	addi	a0,a0,1150 # 8000a4c8 <etext+0x4c8>
    80005052:	99dfb0ef          	jal	800009ee <printf>
      ip = iget(dev, inum);
    80005056:	fcc42783          	lw	a5,-52(s0)
    8000505a:	fec42703          	lw	a4,-20(s0)
    8000505e:	85ba                	mv	a1,a4
    80005060:	853e                	mv	a0,a5
    80005062:	be9ff0ef          	jal	80004c4a <iget>
    80005066:	fea43023          	sd	a0,-32(s0)
    }
    brelse(bp);
    8000506a:	fd843503          	ld	a0,-40(s0)
    8000506e:	cb8ff0ef          	jal	80004526 <brelse>
    if (ip) {
    80005072:	fe043783          	ld	a5,-32(s0)
    80005076:	c38d                	beqz	a5,80005098 <ireclaim+0xc0>
      begin_op();
    80005078:	539000ef          	jal	80005db0 <begin_op>
      ilock(ip);
    8000507c:	fe043503          	ld	a0,-32(s0)
    80005080:	d1bff0ef          	jal	80004d9a <ilock>
      iunlock(ip);
    80005084:	fe043503          	ld	a0,-32(s0)
    80005088:	e2fff0ef          	jal	80004eb6 <iunlock>
      iput(ip);
    8000508c:	fe043503          	ld	a0,-32(s0)
    80005090:	e75ff0ef          	jal	80004f04 <iput>
      end_op();
    80005094:	5cf000ef          	jal	80005e62 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80005098:	fec42783          	lw	a5,-20(s0)
    8000509c:	2785                	addiw	a5,a5,1
    8000509e:	fef42623          	sw	a5,-20(s0)
    800050a2:	0001c797          	auipc	a5,0x1c
    800050a6:	e0e78793          	addi	a5,a5,-498 # 80020eb0 <sb>
    800050aa:	47d8                	lw	a4,12(a5)
    800050ac:	fec42783          	lw	a5,-20(s0)
    800050b0:	f2e7efe3          	bltu	a5,a4,80004fee <ireclaim+0x16>
    }
  }
}
    800050b4:	0001                	nop
    800050b6:	0001                	nop
    800050b8:	70e2                	ld	ra,56(sp)
    800050ba:	7442                	ld	s0,48(sp)
    800050bc:	6121                	addi	sp,sp,64
    800050be:	8082                	ret

00000000800050c0 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800050c0:	7139                	addi	sp,sp,-64
    800050c2:	fc06                	sd	ra,56(sp)
    800050c4:	f822                	sd	s0,48(sp)
    800050c6:	0080                	addi	s0,sp,64
    800050c8:	fca43423          	sd	a0,-56(s0)
    800050cc:	87ae                	mv	a5,a1
    800050ce:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800050d2:	fc442783          	lw	a5,-60(s0)
    800050d6:	0007871b          	sext.w	a4,a5
    800050da:	47ad                	li	a5,11
    800050dc:	04e7ec63          	bltu	a5,a4,80005134 <bmap+0x74>
    if((addr = ip->addrs[bn]) == 0){
    800050e0:	fc843703          	ld	a4,-56(s0)
    800050e4:	fc446783          	lwu	a5,-60(s0)
    800050e8:	07d1                	addi	a5,a5,20
    800050ea:	078a                	slli	a5,a5,0x2
    800050ec:	97ba                	add	a5,a5,a4
    800050ee:	439c                	lw	a5,0(a5)
    800050f0:	fef42623          	sw	a5,-20(s0)
    800050f4:	fec42783          	lw	a5,-20(s0)
    800050f8:	2781                	sext.w	a5,a5
    800050fa:	eb95                	bnez	a5,8000512e <bmap+0x6e>
      addr = balloc(ip->dev);
    800050fc:	fc843783          	ld	a5,-56(s0)
    80005100:	439c                	lw	a5,0(a5)
    80005102:	853e                	mv	a0,a5
    80005104:	e86ff0ef          	jal	8000478a <balloc>
    80005108:	87aa                	mv	a5,a0
    8000510a:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    8000510e:	fec42783          	lw	a5,-20(s0)
    80005112:	2781                	sext.w	a5,a5
    80005114:	e399                	bnez	a5,8000511a <bmap+0x5a>
        return 0;
    80005116:	4781                	li	a5,0
    80005118:	a8fd                	j	80005216 <bmap+0x156>
      ip->addrs[bn] = addr;
    8000511a:	fc843703          	ld	a4,-56(s0)
    8000511e:	fc446783          	lwu	a5,-60(s0)
    80005122:	07d1                	addi	a5,a5,20
    80005124:	078a                	slli	a5,a5,0x2
    80005126:	97ba                	add	a5,a5,a4
    80005128:	fec42703          	lw	a4,-20(s0)
    8000512c:	c398                	sw	a4,0(a5)
    }
    return addr;
    8000512e:	fec42783          	lw	a5,-20(s0)
    80005132:	a0d5                	j	80005216 <bmap+0x156>
  }
  bn -= NDIRECT;
    80005134:	fc442783          	lw	a5,-60(s0)
    80005138:	37d1                	addiw	a5,a5,-12
    8000513a:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    8000513e:	fc442783          	lw	a5,-60(s0)
    80005142:	0007871b          	sext.w	a4,a5
    80005146:	0ff00793          	li	a5,255
    8000514a:	0ce7e063          	bltu	a5,a4,8000520a <bmap+0x14a>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000514e:	fc843783          	ld	a5,-56(s0)
    80005152:	0807a783          	lw	a5,128(a5)
    80005156:	fef42623          	sw	a5,-20(s0)
    8000515a:	fec42783          	lw	a5,-20(s0)
    8000515e:	2781                	sext.w	a5,a5
    80005160:	e795                	bnez	a5,8000518c <bmap+0xcc>
      addr = balloc(ip->dev);
    80005162:	fc843783          	ld	a5,-56(s0)
    80005166:	439c                	lw	a5,0(a5)
    80005168:	853e                	mv	a0,a5
    8000516a:	e20ff0ef          	jal	8000478a <balloc>
    8000516e:	87aa                	mv	a5,a0
    80005170:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    80005174:	fec42783          	lw	a5,-20(s0)
    80005178:	2781                	sext.w	a5,a5
    8000517a:	e399                	bnez	a5,80005180 <bmap+0xc0>
        return 0;
    8000517c:	4781                	li	a5,0
    8000517e:	a861                	j	80005216 <bmap+0x156>
      ip->addrs[NDIRECT] = addr;
    80005180:	fc843783          	ld	a5,-56(s0)
    80005184:	fec42703          	lw	a4,-20(s0)
    80005188:	08e7a023          	sw	a4,128(a5)
    }
    bp = bread(ip->dev, addr);
    8000518c:	fc843783          	ld	a5,-56(s0)
    80005190:	439c                	lw	a5,0(a5)
    80005192:	fec42703          	lw	a4,-20(s0)
    80005196:	85ba                	mv	a1,a4
    80005198:	853e                	mv	a0,a5
    8000519a:	afeff0ef          	jal	80004498 <bread>
    8000519e:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800051a2:	fe043783          	ld	a5,-32(s0)
    800051a6:	05878793          	addi	a5,a5,88
    800051aa:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    800051ae:	fc446783          	lwu	a5,-60(s0)
    800051b2:	078a                	slli	a5,a5,0x2
    800051b4:	fd843703          	ld	a4,-40(s0)
    800051b8:	97ba                	add	a5,a5,a4
    800051ba:	439c                	lw	a5,0(a5)
    800051bc:	fef42623          	sw	a5,-20(s0)
    800051c0:	fec42783          	lw	a5,-20(s0)
    800051c4:	2781                	sext.w	a5,a5
    800051c6:	eb9d                	bnez	a5,800051fc <bmap+0x13c>
      addr = balloc(ip->dev);
    800051c8:	fc843783          	ld	a5,-56(s0)
    800051cc:	439c                	lw	a5,0(a5)
    800051ce:	853e                	mv	a0,a5
    800051d0:	dbaff0ef          	jal	8000478a <balloc>
    800051d4:	87aa                	mv	a5,a0
    800051d6:	fef42623          	sw	a5,-20(s0)
      if(addr){
    800051da:	fec42783          	lw	a5,-20(s0)
    800051de:	2781                	sext.w	a5,a5
    800051e0:	cf91                	beqz	a5,800051fc <bmap+0x13c>
        a[bn] = addr;
    800051e2:	fc446783          	lwu	a5,-60(s0)
    800051e6:	078a                	slli	a5,a5,0x2
    800051e8:	fd843703          	ld	a4,-40(s0)
    800051ec:	97ba                	add	a5,a5,a4
    800051ee:	fec42703          	lw	a4,-20(s0)
    800051f2:	c398                	sw	a4,0(a5)
        log_write(bp);
    800051f4:	fe043503          	ld	a0,-32(s0)
    800051f8:	637000ef          	jal	8000602e <log_write>
      }
    }
    brelse(bp);
    800051fc:	fe043503          	ld	a0,-32(s0)
    80005200:	b26ff0ef          	jal	80004526 <brelse>
    return addr;
    80005204:	fec42783          	lw	a5,-20(s0)
    80005208:	a039                	j	80005216 <bmap+0x156>
  }

  panic("bmap: out of range");
    8000520a:	00005517          	auipc	a0,0x5
    8000520e:	2de50513          	addi	a0,a0,734 # 8000a4e8 <etext+0x4e8>
    80005212:	c25fb0ef          	jal	80000e36 <panic>
}
    80005216:	853e                	mv	a0,a5
    80005218:	70e2                	ld	ra,56(sp)
    8000521a:	7442                	ld	s0,48(sp)
    8000521c:	6121                	addi	sp,sp,64
    8000521e:	8082                	ret

0000000080005220 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80005220:	7139                	addi	sp,sp,-64
    80005222:	fc06                	sd	ra,56(sp)
    80005224:	f822                	sd	s0,48(sp)
    80005226:	0080                	addi	s0,sp,64
    80005228:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    8000522c:	fe042623          	sw	zero,-20(s0)
    80005230:	a881                	j	80005280 <itrunc+0x60>
    if(ip->addrs[i]){
    80005232:	fc843703          	ld	a4,-56(s0)
    80005236:	fec42783          	lw	a5,-20(s0)
    8000523a:	07d1                	addi	a5,a5,20
    8000523c:	078a                	slli	a5,a5,0x2
    8000523e:	97ba                	add	a5,a5,a4
    80005240:	439c                	lw	a5,0(a5)
    80005242:	cb95                	beqz	a5,80005276 <itrunc+0x56>
      bfree(ip->dev, ip->addrs[i]);
    80005244:	fc843783          	ld	a5,-56(s0)
    80005248:	439c                	lw	a5,0(a5)
    8000524a:	86be                	mv	a3,a5
    8000524c:	fc843703          	ld	a4,-56(s0)
    80005250:	fec42783          	lw	a5,-20(s0)
    80005254:	07d1                	addi	a5,a5,20
    80005256:	078a                	slli	a5,a5,0x2
    80005258:	97ba                	add	a5,a5,a4
    8000525a:	439c                	lw	a5,0(a5)
    8000525c:	85be                	mv	a1,a5
    8000525e:	8536                	mv	a0,a3
    80005260:	eb4ff0ef          	jal	80004914 <bfree>
      ip->addrs[i] = 0;
    80005264:	fc843703          	ld	a4,-56(s0)
    80005268:	fec42783          	lw	a5,-20(s0)
    8000526c:	07d1                	addi	a5,a5,20
    8000526e:	078a                	slli	a5,a5,0x2
    80005270:	97ba                	add	a5,a5,a4
    80005272:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005276:	fec42783          	lw	a5,-20(s0)
    8000527a:	2785                	addiw	a5,a5,1
    8000527c:	fef42623          	sw	a5,-20(s0)
    80005280:	fec42783          	lw	a5,-20(s0)
    80005284:	0007871b          	sext.w	a4,a5
    80005288:	47ad                	li	a5,11
    8000528a:	fae7d4e3          	bge	a5,a4,80005232 <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000528e:	fc843783          	ld	a5,-56(s0)
    80005292:	0807a783          	lw	a5,128(a5)
    80005296:	cfc9                	beqz	a5,80005330 <itrunc+0x110>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80005298:	fc843783          	ld	a5,-56(s0)
    8000529c:	4398                	lw	a4,0(a5)
    8000529e:	fc843783          	ld	a5,-56(s0)
    800052a2:	0807a783          	lw	a5,128(a5)
    800052a6:	85be                	mv	a1,a5
    800052a8:	853a                	mv	a0,a4
    800052aa:	9eeff0ef          	jal	80004498 <bread>
    800052ae:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800052b2:	fe043783          	ld	a5,-32(s0)
    800052b6:	05878793          	addi	a5,a5,88
    800052ba:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    800052be:	fe042423          	sw	zero,-24(s0)
    800052c2:	a82d                	j	800052fc <itrunc+0xdc>
      if(a[j])
    800052c4:	fe842783          	lw	a5,-24(s0)
    800052c8:	078a                	slli	a5,a5,0x2
    800052ca:	fd843703          	ld	a4,-40(s0)
    800052ce:	97ba                	add	a5,a5,a4
    800052d0:	439c                	lw	a5,0(a5)
    800052d2:	c385                	beqz	a5,800052f2 <itrunc+0xd2>
        bfree(ip->dev, a[j]);
    800052d4:	fc843783          	ld	a5,-56(s0)
    800052d8:	439c                	lw	a5,0(a5)
    800052da:	86be                	mv	a3,a5
    800052dc:	fe842783          	lw	a5,-24(s0)
    800052e0:	078a                	slli	a5,a5,0x2
    800052e2:	fd843703          	ld	a4,-40(s0)
    800052e6:	97ba                	add	a5,a5,a4
    800052e8:	439c                	lw	a5,0(a5)
    800052ea:	85be                	mv	a1,a5
    800052ec:	8536                	mv	a0,a3
    800052ee:	e26ff0ef          	jal	80004914 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800052f2:	fe842783          	lw	a5,-24(s0)
    800052f6:	2785                	addiw	a5,a5,1
    800052f8:	fef42423          	sw	a5,-24(s0)
    800052fc:	fe842703          	lw	a4,-24(s0)
    80005300:	0ff00793          	li	a5,255
    80005304:	fce7f0e3          	bgeu	a5,a4,800052c4 <itrunc+0xa4>
    }
    brelse(bp);
    80005308:	fe043503          	ld	a0,-32(s0)
    8000530c:	a1aff0ef          	jal	80004526 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80005310:	fc843783          	ld	a5,-56(s0)
    80005314:	439c                	lw	a5,0(a5)
    80005316:	873e                	mv	a4,a5
    80005318:	fc843783          	ld	a5,-56(s0)
    8000531c:	0807a783          	lw	a5,128(a5)
    80005320:	85be                	mv	a1,a5
    80005322:	853a                	mv	a0,a4
    80005324:	df0ff0ef          	jal	80004914 <bfree>
    ip->addrs[NDIRECT] = 0;
    80005328:	fc843783          	ld	a5,-56(s0)
    8000532c:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005330:	fc843783          	ld	a5,-56(s0)
    80005334:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    80005338:	fc843503          	ld	a0,-56(s0)
    8000533c:	837ff0ef          	jal	80004b72 <iupdate>
}
    80005340:	0001                	nop
    80005342:	70e2                	ld	ra,56(sp)
    80005344:	7442                	ld	s0,48(sp)
    80005346:	6121                	addi	sp,sp,64
    80005348:	8082                	ret

000000008000534a <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    8000534a:	1101                	addi	sp,sp,-32
    8000534c:	ec06                	sd	ra,24(sp)
    8000534e:	e822                	sd	s0,16(sp)
    80005350:	1000                	addi	s0,sp,32
    80005352:	fea43423          	sd	a0,-24(s0)
    80005356:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    8000535a:	fe843783          	ld	a5,-24(s0)
    8000535e:	439c                	lw	a5,0(a5)
    80005360:	873e                	mv	a4,a5
    80005362:	fe043783          	ld	a5,-32(s0)
    80005366:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80005368:	fe843783          	ld	a5,-24(s0)
    8000536c:	43d8                	lw	a4,4(a5)
    8000536e:	fe043783          	ld	a5,-32(s0)
    80005372:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    80005374:	fe843783          	ld	a5,-24(s0)
    80005378:	04479703          	lh	a4,68(a5)
    8000537c:	fe043783          	ld	a5,-32(s0)
    80005380:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    80005384:	fe843783          	ld	a5,-24(s0)
    80005388:	04a79703          	lh	a4,74(a5)
    8000538c:	fe043783          	ld	a5,-32(s0)
    80005390:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    80005394:	fe843783          	ld	a5,-24(s0)
    80005398:	47fc                	lw	a5,76(a5)
    8000539a:	02079713          	slli	a4,a5,0x20
    8000539e:	9301                	srli	a4,a4,0x20
    800053a0:	fe043783          	ld	a5,-32(s0)
    800053a4:	eb98                	sd	a4,16(a5)
}
    800053a6:	0001                	nop
    800053a8:	60e2                	ld	ra,24(sp)
    800053aa:	6442                	ld	s0,16(sp)
    800053ac:	6105                	addi	sp,sp,32
    800053ae:	8082                	ret

00000000800053b0 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800053b0:	715d                	addi	sp,sp,-80
    800053b2:	e486                	sd	ra,72(sp)
    800053b4:	e0a2                	sd	s0,64(sp)
    800053b6:	0880                	addi	s0,sp,80
    800053b8:	fca43423          	sd	a0,-56(s0)
    800053bc:	87ae                	mv	a5,a1
    800053be:	fac43c23          	sd	a2,-72(s0)
    800053c2:	fcf42223          	sw	a5,-60(s0)
    800053c6:	87b6                	mv	a5,a3
    800053c8:	fcf42023          	sw	a5,-64(s0)
    800053cc:	87ba                	mv	a5,a4
    800053ce:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800053d2:	fc843783          	ld	a5,-56(s0)
    800053d6:	47fc                	lw	a5,76(a5)
    800053d8:	fc042703          	lw	a4,-64(s0)
    800053dc:	2701                	sext.w	a4,a4
    800053de:	00e7ee63          	bltu	a5,a4,800053fa <readi+0x4a>
    800053e2:	fc042783          	lw	a5,-64(s0)
    800053e6:	873e                	mv	a4,a5
    800053e8:	fb442783          	lw	a5,-76(s0)
    800053ec:	9fb9                	addw	a5,a5,a4
    800053ee:	2781                	sext.w	a5,a5
    800053f0:	fc042703          	lw	a4,-64(s0)
    800053f4:	2701                	sext.w	a4,a4
    800053f6:	00e7f463          	bgeu	a5,a4,800053fe <readi+0x4e>
    return 0;
    800053fa:	4781                	li	a5,0
    800053fc:	aa0d                	j	8000552e <readi+0x17e>
  if(off + n > ip->size)
    800053fe:	fc042783          	lw	a5,-64(s0)
    80005402:	873e                	mv	a4,a5
    80005404:	fb442783          	lw	a5,-76(s0)
    80005408:	9fb9                	addw	a5,a5,a4
    8000540a:	0007871b          	sext.w	a4,a5
    8000540e:	fc843783          	ld	a5,-56(s0)
    80005412:	47fc                	lw	a5,76(a5)
    80005414:	00e7fa63          	bgeu	a5,a4,80005428 <readi+0x78>
    n = ip->size - off;
    80005418:	fc843783          	ld	a5,-56(s0)
    8000541c:	47fc                	lw	a5,76(a5)
    8000541e:	fc042703          	lw	a4,-64(s0)
    80005422:	9f99                	subw	a5,a5,a4
    80005424:	faf42a23          	sw	a5,-76(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005428:	fe042623          	sw	zero,-20(s0)
    8000542c:	a0e5                	j	80005514 <readi+0x164>
    uint addr = bmap(ip, off/BSIZE);
    8000542e:	fc042783          	lw	a5,-64(s0)
    80005432:	00a7d79b          	srliw	a5,a5,0xa
    80005436:	2781                	sext.w	a5,a5
    80005438:	85be                	mv	a1,a5
    8000543a:	fc843503          	ld	a0,-56(s0)
    8000543e:	c83ff0ef          	jal	800050c0 <bmap>
    80005442:	87aa                	mv	a5,a0
    80005444:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80005448:	fe842783          	lw	a5,-24(s0)
    8000544c:	2781                	sext.w	a5,a5
    8000544e:	cfe9                	beqz	a5,80005528 <readi+0x178>
      break;
    bp = bread(ip->dev, addr);
    80005450:	fc843783          	ld	a5,-56(s0)
    80005454:	439c                	lw	a5,0(a5)
    80005456:	fe842703          	lw	a4,-24(s0)
    8000545a:	85ba                	mv	a1,a4
    8000545c:	853e                	mv	a0,a5
    8000545e:	83aff0ef          	jal	80004498 <bread>
    80005462:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005466:	fc042783          	lw	a5,-64(s0)
    8000546a:	3ff7f793          	andi	a5,a5,1023
    8000546e:	2781                	sext.w	a5,a5
    80005470:	40000713          	li	a4,1024
    80005474:	40f707bb          	subw	a5,a4,a5
    80005478:	2781                	sext.w	a5,a5
    8000547a:	fb442703          	lw	a4,-76(s0)
    8000547e:	86ba                	mv	a3,a4
    80005480:	fec42703          	lw	a4,-20(s0)
    80005484:	40e6873b          	subw	a4,a3,a4
    80005488:	2701                	sext.w	a4,a4
    8000548a:	863a                	mv	a2,a4
    8000548c:	0007869b          	sext.w	a3,a5
    80005490:	0006071b          	sext.w	a4,a2
    80005494:	00d77363          	bgeu	a4,a3,8000549a <readi+0xea>
    80005498:	87b2                	mv	a5,a2
    8000549a:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000549e:	fe043783          	ld	a5,-32(s0)
    800054a2:	05878713          	addi	a4,a5,88
    800054a6:	fc046783          	lwu	a5,-64(s0)
    800054aa:	3ff7f793          	andi	a5,a5,1023
    800054ae:	973e                	add	a4,a4,a5
    800054b0:	fdc46683          	lwu	a3,-36(s0)
    800054b4:	fc442783          	lw	a5,-60(s0)
    800054b8:	863a                	mv	a2,a4
    800054ba:	fb843583          	ld	a1,-72(s0)
    800054be:	853e                	mv	a0,a5
    800054c0:	81cfe0ef          	jal	800034dc <either_copyout>
    800054c4:	87aa                	mv	a5,a0
    800054c6:	873e                	mv	a4,a5
    800054c8:	57fd                	li	a5,-1
    800054ca:	00f71a63          	bne	a4,a5,800054de <readi+0x12e>
      brelse(bp);
    800054ce:	fe043503          	ld	a0,-32(s0)
    800054d2:	854ff0ef          	jal	80004526 <brelse>
      tot = -1;
    800054d6:	57fd                	li	a5,-1
    800054d8:	fef42623          	sw	a5,-20(s0)
      break;
    800054dc:	a0b9                	j	8000552a <readi+0x17a>
    }
    brelse(bp);
    800054de:	fe043503          	ld	a0,-32(s0)
    800054e2:	844ff0ef          	jal	80004526 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800054e6:	fec42783          	lw	a5,-20(s0)
    800054ea:	873e                	mv	a4,a5
    800054ec:	fdc42783          	lw	a5,-36(s0)
    800054f0:	9fb9                	addw	a5,a5,a4
    800054f2:	fef42623          	sw	a5,-20(s0)
    800054f6:	fc042783          	lw	a5,-64(s0)
    800054fa:	873e                	mv	a4,a5
    800054fc:	fdc42783          	lw	a5,-36(s0)
    80005500:	9fb9                	addw	a5,a5,a4
    80005502:	fcf42023          	sw	a5,-64(s0)
    80005506:	fdc46783          	lwu	a5,-36(s0)
    8000550a:	fb843703          	ld	a4,-72(s0)
    8000550e:	97ba                	add	a5,a5,a4
    80005510:	faf43c23          	sd	a5,-72(s0)
    80005514:	fec42783          	lw	a5,-20(s0)
    80005518:	873e                	mv	a4,a5
    8000551a:	fb442783          	lw	a5,-76(s0)
    8000551e:	2701                	sext.w	a4,a4
    80005520:	2781                	sext.w	a5,a5
    80005522:	f0f766e3          	bltu	a4,a5,8000542e <readi+0x7e>
    80005526:	a011                	j	8000552a <readi+0x17a>
      break;
    80005528:	0001                	nop
  }
  return tot;
    8000552a:	fec42783          	lw	a5,-20(s0)
}
    8000552e:	853e                	mv	a0,a5
    80005530:	60a6                	ld	ra,72(sp)
    80005532:	6406                	ld	s0,64(sp)
    80005534:	6161                	addi	sp,sp,80
    80005536:	8082                	ret

0000000080005538 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005538:	715d                	addi	sp,sp,-80
    8000553a:	e486                	sd	ra,72(sp)
    8000553c:	e0a2                	sd	s0,64(sp)
    8000553e:	0880                	addi	s0,sp,80
    80005540:	fca43423          	sd	a0,-56(s0)
    80005544:	87ae                	mv	a5,a1
    80005546:	fac43c23          	sd	a2,-72(s0)
    8000554a:	fcf42223          	sw	a5,-60(s0)
    8000554e:	87b6                	mv	a5,a3
    80005550:	fcf42023          	sw	a5,-64(s0)
    80005554:	87ba                	mv	a5,a4
    80005556:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000555a:	fc843783          	ld	a5,-56(s0)
    8000555e:	47fc                	lw	a5,76(a5)
    80005560:	fc042703          	lw	a4,-64(s0)
    80005564:	2701                	sext.w	a4,a4
    80005566:	00e7ee63          	bltu	a5,a4,80005582 <writei+0x4a>
    8000556a:	fc042783          	lw	a5,-64(s0)
    8000556e:	873e                	mv	a4,a5
    80005570:	fb442783          	lw	a5,-76(s0)
    80005574:	9fb9                	addw	a5,a5,a4
    80005576:	2781                	sext.w	a5,a5
    80005578:	fc042703          	lw	a4,-64(s0)
    8000557c:	2701                	sext.w	a4,a4
    8000557e:	00e7f463          	bgeu	a5,a4,80005586 <writei+0x4e>
    return -1;
    80005582:	57fd                	li	a5,-1
    80005584:	a2a1                	j	800056cc <writei+0x194>
  if(off + n > MAXFILE*BSIZE)
    80005586:	fc042783          	lw	a5,-64(s0)
    8000558a:	873e                	mv	a4,a5
    8000558c:	fb442783          	lw	a5,-76(s0)
    80005590:	9fb9                	addw	a5,a5,a4
    80005592:	0007871b          	sext.w	a4,a5
    80005596:	000437b7          	lui	a5,0x43
    8000559a:	00e7f463          	bgeu	a5,a4,800055a2 <writei+0x6a>
    return -1;
    8000559e:	57fd                	li	a5,-1
    800055a0:	a235                	j	800056cc <writei+0x194>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800055a2:	fe042623          	sw	zero,-20(s0)
    800055a6:	a0ed                	j	80005690 <writei+0x158>
    uint addr = bmap(ip, off/BSIZE);
    800055a8:	fc042783          	lw	a5,-64(s0)
    800055ac:	00a7d79b          	srliw	a5,a5,0xa
    800055b0:	2781                	sext.w	a5,a5
    800055b2:	85be                	mv	a1,a5
    800055b4:	fc843503          	ld	a0,-56(s0)
    800055b8:	b09ff0ef          	jal	800050c0 <bmap>
    800055bc:	87aa                	mv	a5,a0
    800055be:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    800055c2:	fe842783          	lw	a5,-24(s0)
    800055c6:	2781                	sext.w	a5,a5
    800055c8:	cff1                	beqz	a5,800056a4 <writei+0x16c>
      break;
    bp = bread(ip->dev, addr);
    800055ca:	fc843783          	ld	a5,-56(s0)
    800055ce:	439c                	lw	a5,0(a5)
    800055d0:	fe842703          	lw	a4,-24(s0)
    800055d4:	85ba                	mv	a1,a4
    800055d6:	853e                	mv	a0,a5
    800055d8:	ec1fe0ef          	jal	80004498 <bread>
    800055dc:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800055e0:	fc042783          	lw	a5,-64(s0)
    800055e4:	3ff7f793          	andi	a5,a5,1023
    800055e8:	2781                	sext.w	a5,a5
    800055ea:	40000713          	li	a4,1024
    800055ee:	40f707bb          	subw	a5,a4,a5
    800055f2:	2781                	sext.w	a5,a5
    800055f4:	fb442703          	lw	a4,-76(s0)
    800055f8:	86ba                	mv	a3,a4
    800055fa:	fec42703          	lw	a4,-20(s0)
    800055fe:	40e6873b          	subw	a4,a3,a4
    80005602:	2701                	sext.w	a4,a4
    80005604:	863a                	mv	a2,a4
    80005606:	0007869b          	sext.w	a3,a5
    8000560a:	0006071b          	sext.w	a4,a2
    8000560e:	00d77363          	bgeu	a4,a3,80005614 <writei+0xdc>
    80005612:	87b2                	mv	a5,a2
    80005614:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005618:	fe043783          	ld	a5,-32(s0)
    8000561c:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80005620:	fc046783          	lwu	a5,-64(s0)
    80005624:	3ff7f793          	andi	a5,a5,1023
    80005628:	97ba                	add	a5,a5,a4
    8000562a:	fdc46683          	lwu	a3,-36(s0)
    8000562e:	fc442703          	lw	a4,-60(s0)
    80005632:	fb843603          	ld	a2,-72(s0)
    80005636:	85ba                	mv	a1,a4
    80005638:	853e                	mv	a0,a5
    8000563a:	f0bfd0ef          	jal	80003544 <either_copyin>
    8000563e:	87aa                	mv	a5,a0
    80005640:	873e                	mv	a4,a5
    80005642:	57fd                	li	a5,-1
    80005644:	00f71763          	bne	a4,a5,80005652 <writei+0x11a>
      brelse(bp);
    80005648:	fe043503          	ld	a0,-32(s0)
    8000564c:	edbfe0ef          	jal	80004526 <brelse>
      break;
    80005650:	a899                	j	800056a6 <writei+0x16e>
    }
    log_write(bp);
    80005652:	fe043503          	ld	a0,-32(s0)
    80005656:	1d9000ef          	jal	8000602e <log_write>
    brelse(bp);
    8000565a:	fe043503          	ld	a0,-32(s0)
    8000565e:	ec9fe0ef          	jal	80004526 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005662:	fec42783          	lw	a5,-20(s0)
    80005666:	873e                	mv	a4,a5
    80005668:	fdc42783          	lw	a5,-36(s0)
    8000566c:	9fb9                	addw	a5,a5,a4
    8000566e:	fef42623          	sw	a5,-20(s0)
    80005672:	fc042783          	lw	a5,-64(s0)
    80005676:	873e                	mv	a4,a5
    80005678:	fdc42783          	lw	a5,-36(s0)
    8000567c:	9fb9                	addw	a5,a5,a4
    8000567e:	fcf42023          	sw	a5,-64(s0)
    80005682:	fdc46783          	lwu	a5,-36(s0)
    80005686:	fb843703          	ld	a4,-72(s0)
    8000568a:	97ba                	add	a5,a5,a4
    8000568c:	faf43c23          	sd	a5,-72(s0)
    80005690:	fec42783          	lw	a5,-20(s0)
    80005694:	873e                	mv	a4,a5
    80005696:	fb442783          	lw	a5,-76(s0)
    8000569a:	2701                	sext.w	a4,a4
    8000569c:	2781                	sext.w	a5,a5
    8000569e:	f0f765e3          	bltu	a4,a5,800055a8 <writei+0x70>
    800056a2:	a011                	j	800056a6 <writei+0x16e>
      break;
    800056a4:	0001                	nop
  }

  if(off > ip->size)
    800056a6:	fc843783          	ld	a5,-56(s0)
    800056aa:	47fc                	lw	a5,76(a5)
    800056ac:	fc042703          	lw	a4,-64(s0)
    800056b0:	2701                	sext.w	a4,a4
    800056b2:	00e7f763          	bgeu	a5,a4,800056c0 <writei+0x188>
    ip->size = off;
    800056b6:	fc843783          	ld	a5,-56(s0)
    800056ba:	fc042703          	lw	a4,-64(s0)
    800056be:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800056c0:	fc843503          	ld	a0,-56(s0)
    800056c4:	caeff0ef          	jal	80004b72 <iupdate>

  return tot;
    800056c8:	fec42783          	lw	a5,-20(s0)
}
    800056cc:	853e                	mv	a0,a5
    800056ce:	60a6                	ld	ra,72(sp)
    800056d0:	6406                	ld	s0,64(sp)
    800056d2:	6161                	addi	sp,sp,80
    800056d4:	8082                	ret

00000000800056d6 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800056d6:	1101                	addi	sp,sp,-32
    800056d8:	ec06                	sd	ra,24(sp)
    800056da:	e822                	sd	s0,16(sp)
    800056dc:	1000                	addi	s0,sp,32
    800056de:	fea43423          	sd	a0,-24(s0)
    800056e2:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    800056e6:	4639                	li	a2,14
    800056e8:	fe043583          	ld	a1,-32(s0)
    800056ec:	fe843503          	ld	a0,-24(s0)
    800056f0:	fe7fb0ef          	jal	800016d6 <strncmp>
    800056f4:	87aa                	mv	a5,a0
}
    800056f6:	853e                	mv	a0,a5
    800056f8:	60e2                	ld	ra,24(sp)
    800056fa:	6442                	ld	s0,16(sp)
    800056fc:	6105                	addi	sp,sp,32
    800056fe:	8082                	ret

0000000080005700 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80005700:	715d                	addi	sp,sp,-80
    80005702:	e486                	sd	ra,72(sp)
    80005704:	e0a2                	sd	s0,64(sp)
    80005706:	0880                	addi	s0,sp,80
    80005708:	fca43423          	sd	a0,-56(s0)
    8000570c:	fcb43023          	sd	a1,-64(s0)
    80005710:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80005714:	fc843783          	ld	a5,-56(s0)
    80005718:	04479703          	lh	a4,68(a5)
    8000571c:	4785                	li	a5,1
    8000571e:	00f70863          	beq	a4,a5,8000572e <dirlookup+0x2e>
    panic("dirlookup not DIR");
    80005722:	00005517          	auipc	a0,0x5
    80005726:	dde50513          	addi	a0,a0,-546 # 8000a500 <etext+0x500>
    8000572a:	f0cfb0ef          	jal	80000e36 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000572e:	fe042623          	sw	zero,-20(s0)
    80005732:	a049                	j	800057b4 <dirlookup+0xb4>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005734:	fd840793          	addi	a5,s0,-40
    80005738:	fec42683          	lw	a3,-20(s0)
    8000573c:	4741                	li	a4,16
    8000573e:	863e                	mv	a2,a5
    80005740:	4581                	li	a1,0
    80005742:	fc843503          	ld	a0,-56(s0)
    80005746:	c6bff0ef          	jal	800053b0 <readi>
    8000574a:	87aa                	mv	a5,a0
    8000574c:	873e                	mv	a4,a5
    8000574e:	47c1                	li	a5,16
    80005750:	00f70863          	beq	a4,a5,80005760 <dirlookup+0x60>
      panic("dirlookup read");
    80005754:	00005517          	auipc	a0,0x5
    80005758:	dc450513          	addi	a0,a0,-572 # 8000a518 <etext+0x518>
    8000575c:	edafb0ef          	jal	80000e36 <panic>
    if(de.inum == 0)
    80005760:	fd845783          	lhu	a5,-40(s0)
    80005764:	c3b1                	beqz	a5,800057a8 <dirlookup+0xa8>
      continue;
    if(namecmp(name, de.name) == 0){
    80005766:	fd840793          	addi	a5,s0,-40
    8000576a:	0789                	addi	a5,a5,2
    8000576c:	85be                	mv	a1,a5
    8000576e:	fc043503          	ld	a0,-64(s0)
    80005772:	f65ff0ef          	jal	800056d6 <namecmp>
    80005776:	87aa                	mv	a5,a0
    80005778:	eb8d                	bnez	a5,800057aa <dirlookup+0xaa>
      // entry matches path element
      if(poff)
    8000577a:	fb843783          	ld	a5,-72(s0)
    8000577e:	c791                	beqz	a5,8000578a <dirlookup+0x8a>
        *poff = off;
    80005780:	fb843783          	ld	a5,-72(s0)
    80005784:	fec42703          	lw	a4,-20(s0)
    80005788:	c398                	sw	a4,0(a5)
      inum = de.inum;
    8000578a:	fd845783          	lhu	a5,-40(s0)
    8000578e:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005792:	fc843783          	ld	a5,-56(s0)
    80005796:	439c                	lw	a5,0(a5)
    80005798:	fe842703          	lw	a4,-24(s0)
    8000579c:	85ba                	mv	a1,a4
    8000579e:	853e                	mv	a0,a5
    800057a0:	caaff0ef          	jal	80004c4a <iget>
    800057a4:	87aa                	mv	a5,a0
    800057a6:	a005                	j	800057c6 <dirlookup+0xc6>
      continue;
    800057a8:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    800057aa:	fec42783          	lw	a5,-20(s0)
    800057ae:	27c1                	addiw	a5,a5,16
    800057b0:	fef42623          	sw	a5,-20(s0)
    800057b4:	fc843783          	ld	a5,-56(s0)
    800057b8:	47fc                	lw	a5,76(a5)
    800057ba:	fec42703          	lw	a4,-20(s0)
    800057be:	2701                	sext.w	a4,a4
    800057c0:	f6f76ae3          	bltu	a4,a5,80005734 <dirlookup+0x34>
    }
  }

  return 0;
    800057c4:	4781                	li	a5,0
}
    800057c6:	853e                	mv	a0,a5
    800057c8:	60a6                	ld	ra,72(sp)
    800057ca:	6406                	ld	s0,64(sp)
    800057cc:	6161                	addi	sp,sp,80
    800057ce:	8082                	ret

00000000800057d0 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
// Returns 0 on success, -1 on failure (e.g. out of disk blocks).
int
dirlink(struct inode *dp, char *name, uint inum)
{
    800057d0:	715d                	addi	sp,sp,-80
    800057d2:	e486                	sd	ra,72(sp)
    800057d4:	e0a2                	sd	s0,64(sp)
    800057d6:	0880                	addi	s0,sp,80
    800057d8:	fca43423          	sd	a0,-56(s0)
    800057dc:	fcb43023          	sd	a1,-64(s0)
    800057e0:	87b2                	mv	a5,a2
    800057e2:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    800057e6:	4601                	li	a2,0
    800057e8:	fc043583          	ld	a1,-64(s0)
    800057ec:	fc843503          	ld	a0,-56(s0)
    800057f0:	f11ff0ef          	jal	80005700 <dirlookup>
    800057f4:	fea43023          	sd	a0,-32(s0)
    800057f8:	fe043783          	ld	a5,-32(s0)
    800057fc:	c799                	beqz	a5,8000580a <dirlink+0x3a>
    iput(ip);
    800057fe:	fe043503          	ld	a0,-32(s0)
    80005802:	f02ff0ef          	jal	80004f04 <iput>
    return -1;
    80005806:	57fd                	li	a5,-1
    80005808:	a871                	j	800058a4 <dirlink+0xd4>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000580a:	fe042623          	sw	zero,-20(s0)
    8000580e:	a081                	j	8000584e <dirlink+0x7e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005810:	fd040793          	addi	a5,s0,-48
    80005814:	fec42683          	lw	a3,-20(s0)
    80005818:	4741                	li	a4,16
    8000581a:	863e                	mv	a2,a5
    8000581c:	4581                	li	a1,0
    8000581e:	fc843503          	ld	a0,-56(s0)
    80005822:	b8fff0ef          	jal	800053b0 <readi>
    80005826:	87aa                	mv	a5,a0
    80005828:	873e                	mv	a4,a5
    8000582a:	47c1                	li	a5,16
    8000582c:	00f70863          	beq	a4,a5,8000583c <dirlink+0x6c>
      panic("dirlink read");
    80005830:	00005517          	auipc	a0,0x5
    80005834:	cf850513          	addi	a0,a0,-776 # 8000a528 <etext+0x528>
    80005838:	dfefb0ef          	jal	80000e36 <panic>
    if(de.inum == 0)
    8000583c:	fd045783          	lhu	a5,-48(s0)
    80005840:	cf99                	beqz	a5,8000585e <dirlink+0x8e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005842:	fec42783          	lw	a5,-20(s0)
    80005846:	27c1                	addiw	a5,a5,16
    80005848:	2781                	sext.w	a5,a5
    8000584a:	fef42623          	sw	a5,-20(s0)
    8000584e:	fc843783          	ld	a5,-56(s0)
    80005852:	47f8                	lw	a4,76(a5)
    80005854:	fec42783          	lw	a5,-20(s0)
    80005858:	fae7ece3          	bltu	a5,a4,80005810 <dirlink+0x40>
    8000585c:	a011                	j	80005860 <dirlink+0x90>
      break;
    8000585e:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80005860:	fd040793          	addi	a5,s0,-48
    80005864:	0789                	addi	a5,a5,2
    80005866:	4639                	li	a2,14
    80005868:	fc043583          	ld	a1,-64(s0)
    8000586c:	853e                	mv	a0,a5
    8000586e:	ef7fb0ef          	jal	80001764 <strncpy>
  de.inum = inum;
    80005872:	fbc42783          	lw	a5,-68(s0)
    80005876:	17c2                	slli	a5,a5,0x30
    80005878:	93c1                	srli	a5,a5,0x30
    8000587a:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000587e:	fd040793          	addi	a5,s0,-48
    80005882:	fec42683          	lw	a3,-20(s0)
    80005886:	4741                	li	a4,16
    80005888:	863e                	mv	a2,a5
    8000588a:	4581                	li	a1,0
    8000588c:	fc843503          	ld	a0,-56(s0)
    80005890:	ca9ff0ef          	jal	80005538 <writei>
    80005894:	87aa                	mv	a5,a0
    80005896:	873e                	mv	a4,a5
    80005898:	47c1                	li	a5,16
    8000589a:	00f70463          	beq	a4,a5,800058a2 <dirlink+0xd2>
    return -1;
    8000589e:	57fd                	li	a5,-1
    800058a0:	a011                	j	800058a4 <dirlink+0xd4>

  return 0;
    800058a2:	4781                	li	a5,0
}
    800058a4:	853e                	mv	a0,a5
    800058a6:	60a6                	ld	ra,72(sp)
    800058a8:	6406                	ld	s0,64(sp)
    800058aa:	6161                	addi	sp,sp,80
    800058ac:	8082                	ret

00000000800058ae <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    800058ae:	7179                	addi	sp,sp,-48
    800058b0:	f406                	sd	ra,40(sp)
    800058b2:	f022                	sd	s0,32(sp)
    800058b4:	1800                	addi	s0,sp,48
    800058b6:	fca43c23          	sd	a0,-40(s0)
    800058ba:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    800058be:	a031                	j	800058ca <skipelem+0x1c>
    path++;
    800058c0:	fd843783          	ld	a5,-40(s0)
    800058c4:	0785                	addi	a5,a5,1
    800058c6:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    800058ca:	fd843783          	ld	a5,-40(s0)
    800058ce:	0007c783          	lbu	a5,0(a5)
    800058d2:	873e                	mv	a4,a5
    800058d4:	02f00793          	li	a5,47
    800058d8:	fef704e3          	beq	a4,a5,800058c0 <skipelem+0x12>
  if(*path == 0)
    800058dc:	fd843783          	ld	a5,-40(s0)
    800058e0:	0007c783          	lbu	a5,0(a5)
    800058e4:	e399                	bnez	a5,800058ea <skipelem+0x3c>
    return 0;
    800058e6:	4781                	li	a5,0
    800058e8:	a04d                	j	8000598a <skipelem+0xdc>
  s = path;
    800058ea:	fd843783          	ld	a5,-40(s0)
    800058ee:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    800058f2:	a031                	j	800058fe <skipelem+0x50>
    path++;
    800058f4:	fd843783          	ld	a5,-40(s0)
    800058f8:	0785                	addi	a5,a5,1
    800058fa:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    800058fe:	fd843783          	ld	a5,-40(s0)
    80005902:	0007c783          	lbu	a5,0(a5)
    80005906:	873e                	mv	a4,a5
    80005908:	02f00793          	li	a5,47
    8000590c:	00f70763          	beq	a4,a5,8000591a <skipelem+0x6c>
    80005910:	fd843783          	ld	a5,-40(s0)
    80005914:	0007c783          	lbu	a5,0(a5)
    80005918:	fff1                	bnez	a5,800058f4 <skipelem+0x46>
  len = path - s;
    8000591a:	fd843703          	ld	a4,-40(s0)
    8000591e:	fe843783          	ld	a5,-24(s0)
    80005922:	40f707b3          	sub	a5,a4,a5
    80005926:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    8000592a:	fe442783          	lw	a5,-28(s0)
    8000592e:	0007871b          	sext.w	a4,a5
    80005932:	47b5                	li	a5,13
    80005934:	00e7da63          	bge	a5,a4,80005948 <skipelem+0x9a>
    memmove(name, s, DIRSIZ);
    80005938:	4639                	li	a2,14
    8000593a:	fe843583          	ld	a1,-24(s0)
    8000593e:	fd043503          	ld	a0,-48(s0)
    80005942:	c81fb0ef          	jal	800015c2 <memmove>
    80005946:	a03d                	j	80005974 <skipelem+0xc6>
  else {
    memmove(name, s, len);
    80005948:	fe442783          	lw	a5,-28(s0)
    8000594c:	863e                	mv	a2,a5
    8000594e:	fe843583          	ld	a1,-24(s0)
    80005952:	fd043503          	ld	a0,-48(s0)
    80005956:	c6dfb0ef          	jal	800015c2 <memmove>
    name[len] = 0;
    8000595a:	fe442783          	lw	a5,-28(s0)
    8000595e:	fd043703          	ld	a4,-48(s0)
    80005962:	97ba                	add	a5,a5,a4
    80005964:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005968:	a031                	j	80005974 <skipelem+0xc6>
    path++;
    8000596a:	fd843783          	ld	a5,-40(s0)
    8000596e:	0785                	addi	a5,a5,1
    80005970:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005974:	fd843783          	ld	a5,-40(s0)
    80005978:	0007c783          	lbu	a5,0(a5)
    8000597c:	873e                	mv	a4,a5
    8000597e:	02f00793          	li	a5,47
    80005982:	fef704e3          	beq	a4,a5,8000596a <skipelem+0xbc>
  return path;
    80005986:	fd843783          	ld	a5,-40(s0)
}
    8000598a:	853e                	mv	a0,a5
    8000598c:	70a2                	ld	ra,40(sp)
    8000598e:	7402                	ld	s0,32(sp)
    80005990:	6145                	addi	sp,sp,48
    80005992:	8082                	ret

0000000080005994 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005994:	7139                	addi	sp,sp,-64
    80005996:	fc06                	sd	ra,56(sp)
    80005998:	f822                	sd	s0,48(sp)
    8000599a:	0080                	addi	s0,sp,64
    8000599c:	fca43c23          	sd	a0,-40(s0)
    800059a0:	87ae                	mv	a5,a1
    800059a2:	fcc43423          	sd	a2,-56(s0)
    800059a6:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    800059aa:	fd843783          	ld	a5,-40(s0)
    800059ae:	0007c783          	lbu	a5,0(a5)
    800059b2:	873e                	mv	a4,a5
    800059b4:	02f00793          	li	a5,47
    800059b8:	00f71963          	bne	a4,a5,800059ca <namex+0x36>
    ip = iget(ROOTDEV, ROOTINO);
    800059bc:	4585                	li	a1,1
    800059be:	4505                	li	a0,1
    800059c0:	a8aff0ef          	jal	80004c4a <iget>
    800059c4:	fea43423          	sd	a0,-24(s0)
    800059c8:	a079                	j	80005a56 <namex+0xc2>
  else
    ip = idup(myproc()->cwd);
    800059ca:	e8bfc0ef          	jal	80002854 <myproc>
    800059ce:	87aa                	mv	a5,a0
    800059d0:	1507b783          	ld	a5,336(a5)
    800059d4:	853e                	mv	a0,a5
    800059d6:	b80ff0ef          	jal	80004d56 <idup>
    800059da:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    800059de:	a8a5                	j	80005a56 <namex+0xc2>
    ilock(ip);
    800059e0:	fe843503          	ld	a0,-24(s0)
    800059e4:	bb6ff0ef          	jal	80004d9a <ilock>
    if(ip->type != T_DIR){
    800059e8:	fe843783          	ld	a5,-24(s0)
    800059ec:	04479703          	lh	a4,68(a5)
    800059f0:	4785                	li	a5,1
    800059f2:	00f70863          	beq	a4,a5,80005a02 <namex+0x6e>
      iunlockput(ip);
    800059f6:	fe843503          	ld	a0,-24(s0)
    800059fa:	db8ff0ef          	jal	80004fb2 <iunlockput>
      return 0;
    800059fe:	4781                	li	a5,0
    80005a00:	a051                	j	80005a84 <namex+0xf0>
    }
    if(nameiparent && *path == '\0'){
    80005a02:	fd442783          	lw	a5,-44(s0)
    80005a06:	2781                	sext.w	a5,a5
    80005a08:	cf89                	beqz	a5,80005a22 <namex+0x8e>
    80005a0a:	fd843783          	ld	a5,-40(s0)
    80005a0e:	0007c783          	lbu	a5,0(a5)
    80005a12:	eb81                	bnez	a5,80005a22 <namex+0x8e>
      // Stop one level early.
      iunlock(ip);
    80005a14:	fe843503          	ld	a0,-24(s0)
    80005a18:	c9eff0ef          	jal	80004eb6 <iunlock>
      return ip;
    80005a1c:	fe843783          	ld	a5,-24(s0)
    80005a20:	a095                	j	80005a84 <namex+0xf0>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80005a22:	4601                	li	a2,0
    80005a24:	fc843583          	ld	a1,-56(s0)
    80005a28:	fe843503          	ld	a0,-24(s0)
    80005a2c:	cd5ff0ef          	jal	80005700 <dirlookup>
    80005a30:	fea43023          	sd	a0,-32(s0)
    80005a34:	fe043783          	ld	a5,-32(s0)
    80005a38:	e799                	bnez	a5,80005a46 <namex+0xb2>
      iunlockput(ip);
    80005a3a:	fe843503          	ld	a0,-24(s0)
    80005a3e:	d74ff0ef          	jal	80004fb2 <iunlockput>
      return 0;
    80005a42:	4781                	li	a5,0
    80005a44:	a081                	j	80005a84 <namex+0xf0>
    }
    iunlockput(ip);
    80005a46:	fe843503          	ld	a0,-24(s0)
    80005a4a:	d68ff0ef          	jal	80004fb2 <iunlockput>
    ip = next;
    80005a4e:	fe043783          	ld	a5,-32(s0)
    80005a52:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80005a56:	fc843583          	ld	a1,-56(s0)
    80005a5a:	fd843503          	ld	a0,-40(s0)
    80005a5e:	e51ff0ef          	jal	800058ae <skipelem>
    80005a62:	fca43c23          	sd	a0,-40(s0)
    80005a66:	fd843783          	ld	a5,-40(s0)
    80005a6a:	fbbd                	bnez	a5,800059e0 <namex+0x4c>
  }
  if(nameiparent){
    80005a6c:	fd442783          	lw	a5,-44(s0)
    80005a70:	2781                	sext.w	a5,a5
    80005a72:	c799                	beqz	a5,80005a80 <namex+0xec>
    iput(ip);
    80005a74:	fe843503          	ld	a0,-24(s0)
    80005a78:	c8cff0ef          	jal	80004f04 <iput>
    return 0;
    80005a7c:	4781                	li	a5,0
    80005a7e:	a019                	j	80005a84 <namex+0xf0>
  }
  return ip;
    80005a80:	fe843783          	ld	a5,-24(s0)
}
    80005a84:	853e                	mv	a0,a5
    80005a86:	70e2                	ld	ra,56(sp)
    80005a88:	7442                	ld	s0,48(sp)
    80005a8a:	6121                	addi	sp,sp,64
    80005a8c:	8082                	ret

0000000080005a8e <namei>:

struct inode*
namei(char *path)
{
    80005a8e:	7179                	addi	sp,sp,-48
    80005a90:	f406                	sd	ra,40(sp)
    80005a92:	f022                	sd	s0,32(sp)
    80005a94:	1800                	addi	s0,sp,48
    80005a96:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80005a9a:	fe040793          	addi	a5,s0,-32
    80005a9e:	863e                	mv	a2,a5
    80005aa0:	4581                	li	a1,0
    80005aa2:	fd843503          	ld	a0,-40(s0)
    80005aa6:	eefff0ef          	jal	80005994 <namex>
    80005aaa:	87aa                	mv	a5,a0
}
    80005aac:	853e                	mv	a0,a5
    80005aae:	70a2                	ld	ra,40(sp)
    80005ab0:	7402                	ld	s0,32(sp)
    80005ab2:	6145                	addi	sp,sp,48
    80005ab4:	8082                	ret

0000000080005ab6 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80005ab6:	1101                	addi	sp,sp,-32
    80005ab8:	ec06                	sd	ra,24(sp)
    80005aba:	e822                	sd	s0,16(sp)
    80005abc:	1000                	addi	s0,sp,32
    80005abe:	fea43423          	sd	a0,-24(s0)
    80005ac2:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80005ac6:	fe043603          	ld	a2,-32(s0)
    80005aca:	4585                	li	a1,1
    80005acc:	fe843503          	ld	a0,-24(s0)
    80005ad0:	ec5ff0ef          	jal	80005994 <namex>
    80005ad4:	87aa                	mv	a5,a0
}
    80005ad6:	853e                	mv	a0,a5
    80005ad8:	60e2                	ld	ra,24(sp)
    80005ada:	6442                	ld	s0,16(sp)
    80005adc:	6105                	addi	sp,sp,32
    80005ade:	8082                	ret

0000000080005ae0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80005ae0:	1101                	addi	sp,sp,-32
    80005ae2:	ec06                	sd	ra,24(sp)
    80005ae4:	e822                	sd	s0,16(sp)
    80005ae6:	1000                	addi	s0,sp,32
    80005ae8:	87aa                	mv	a5,a0
    80005aea:	feb43023          	sd	a1,-32(s0)
    80005aee:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80005af2:	00005597          	auipc	a1,0x5
    80005af6:	a4658593          	addi	a1,a1,-1466 # 8000a538 <etext+0x538>
    80005afa:	0001d517          	auipc	a0,0x1d
    80005afe:	e7e50513          	addi	a0,a0,-386 # 80022978 <log>
    80005b02:	815fb0ef          	jal	80001316 <initlock>
  log.start = sb->logstart;
    80005b06:	fe043783          	ld	a5,-32(s0)
    80005b0a:	4bdc                	lw	a5,20(a5)
    80005b0c:	873e                	mv	a4,a5
    80005b0e:	0001d797          	auipc	a5,0x1d
    80005b12:	e6a78793          	addi	a5,a5,-406 # 80022978 <log>
    80005b16:	cf98                	sw	a4,24(a5)
  log.dev = dev;
    80005b18:	0001d797          	auipc	a5,0x1d
    80005b1c:	e6078793          	addi	a5,a5,-416 # 80022978 <log>
    80005b20:	fec42703          	lw	a4,-20(s0)
    80005b24:	d3d8                	sw	a4,36(a5)
  recover_from_log();
    80005b26:	25e000ef          	jal	80005d84 <recover_from_log>
}
    80005b2a:	0001                	nop
    80005b2c:	60e2                	ld	ra,24(sp)
    80005b2e:	6442                	ld	s0,16(sp)
    80005b30:	6105                	addi	sp,sp,32
    80005b32:	8082                	ret

0000000080005b34 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80005b34:	7139                	addi	sp,sp,-64
    80005b36:	fc06                	sd	ra,56(sp)
    80005b38:	f822                	sd	s0,48(sp)
    80005b3a:	0080                	addi	s0,sp,64
    80005b3c:	87aa                	mv	a5,a0
    80005b3e:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80005b42:	fe042623          	sw	zero,-20(s0)
    80005b46:	a8e9                	j	80005c20 <install_trans+0xec>
    if(recovering) {
    80005b48:	fcc42783          	lw	a5,-52(s0)
    80005b4c:	2781                	sext.w	a5,a5
    80005b4e:	c78d                	beqz	a5,80005b78 <install_trans+0x44>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80005b50:	0001d717          	auipc	a4,0x1d
    80005b54:	e2870713          	addi	a4,a4,-472 # 80022978 <log>
    80005b58:	fec42783          	lw	a5,-20(s0)
    80005b5c:	07a1                	addi	a5,a5,8
    80005b5e:	078a                	slli	a5,a5,0x2
    80005b60:	97ba                	add	a5,a5,a4
    80005b62:	47d8                	lw	a4,12(a5)
    80005b64:	fec42783          	lw	a5,-20(s0)
    80005b68:	863a                	mv	a2,a4
    80005b6a:	85be                	mv	a1,a5
    80005b6c:	00005517          	auipc	a0,0x5
    80005b70:	9d450513          	addi	a0,a0,-1580 # 8000a540 <etext+0x540>
    80005b74:	e7bfa0ef          	jal	800009ee <printf>
    }
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80005b78:	0001d797          	auipc	a5,0x1d
    80005b7c:	e0078793          	addi	a5,a5,-512 # 80022978 <log>
    80005b80:	53dc                	lw	a5,36(a5)
    80005b82:	86be                	mv	a3,a5
    80005b84:	0001d797          	auipc	a5,0x1d
    80005b88:	df478793          	addi	a5,a5,-524 # 80022978 <log>
    80005b8c:	4f9c                	lw	a5,24(a5)
    80005b8e:	fec42703          	lw	a4,-20(s0)
    80005b92:	9fb9                	addw	a5,a5,a4
    80005b94:	2781                	sext.w	a5,a5
    80005b96:	2785                	addiw	a5,a5,1
    80005b98:	2781                	sext.w	a5,a5
    80005b9a:	85be                	mv	a1,a5
    80005b9c:	8536                	mv	a0,a3
    80005b9e:	8fbfe0ef          	jal	80004498 <bread>
    80005ba2:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80005ba6:	0001d797          	auipc	a5,0x1d
    80005baa:	dd278793          	addi	a5,a5,-558 # 80022978 <log>
    80005bae:	53dc                	lw	a5,36(a5)
    80005bb0:	86be                	mv	a3,a5
    80005bb2:	0001d717          	auipc	a4,0x1d
    80005bb6:	dc670713          	addi	a4,a4,-570 # 80022978 <log>
    80005bba:	fec42783          	lw	a5,-20(s0)
    80005bbe:	07a1                	addi	a5,a5,8
    80005bc0:	078a                	slli	a5,a5,0x2
    80005bc2:	97ba                	add	a5,a5,a4
    80005bc4:	47dc                	lw	a5,12(a5)
    80005bc6:	85be                	mv	a1,a5
    80005bc8:	8536                	mv	a0,a3
    80005bca:	8cffe0ef          	jal	80004498 <bread>
    80005bce:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80005bd2:	fd843783          	ld	a5,-40(s0)
    80005bd6:	05878713          	addi	a4,a5,88
    80005bda:	fe043783          	ld	a5,-32(s0)
    80005bde:	05878793          	addi	a5,a5,88
    80005be2:	40000613          	li	a2,1024
    80005be6:	85be                	mv	a1,a5
    80005be8:	853a                	mv	a0,a4
    80005bea:	9d9fb0ef          	jal	800015c2 <memmove>
    bwrite(dbuf);  // write dst to disk
    80005bee:	fd843503          	ld	a0,-40(s0)
    80005bf2:	8f9fe0ef          	jal	800044ea <bwrite>
    if(recovering == 0)
    80005bf6:	fcc42783          	lw	a5,-52(s0)
    80005bfa:	2781                	sext.w	a5,a5
    80005bfc:	e789                	bnez	a5,80005c06 <install_trans+0xd2>
      bunpin(dbuf);
    80005bfe:	fd843503          	ld	a0,-40(s0)
    80005c02:	a3ffe0ef          	jal	80004640 <bunpin>
    brelse(lbuf);
    80005c06:	fe043503          	ld	a0,-32(s0)
    80005c0a:	91dfe0ef          	jal	80004526 <brelse>
    brelse(dbuf);
    80005c0e:	fd843503          	ld	a0,-40(s0)
    80005c12:	915fe0ef          	jal	80004526 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80005c16:	fec42783          	lw	a5,-20(s0)
    80005c1a:	2785                	addiw	a5,a5,1
    80005c1c:	fef42623          	sw	a5,-20(s0)
    80005c20:	0001d797          	auipc	a5,0x1d
    80005c24:	d5878793          	addi	a5,a5,-680 # 80022978 <log>
    80005c28:	579c                	lw	a5,40(a5)
    80005c2a:	fec42703          	lw	a4,-20(s0)
    80005c2e:	2701                	sext.w	a4,a4
    80005c30:	f0f74ce3          	blt	a4,a5,80005b48 <install_trans+0x14>
  }
}
    80005c34:	0001                	nop
    80005c36:	0001                	nop
    80005c38:	70e2                	ld	ra,56(sp)
    80005c3a:	7442                	ld	s0,48(sp)
    80005c3c:	6121                	addi	sp,sp,64
    80005c3e:	8082                	ret

0000000080005c40 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80005c40:	7179                	addi	sp,sp,-48
    80005c42:	f406                	sd	ra,40(sp)
    80005c44:	f022                	sd	s0,32(sp)
    80005c46:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80005c48:	0001d797          	auipc	a5,0x1d
    80005c4c:	d3078793          	addi	a5,a5,-720 # 80022978 <log>
    80005c50:	53dc                	lw	a5,36(a5)
    80005c52:	873e                	mv	a4,a5
    80005c54:	0001d797          	auipc	a5,0x1d
    80005c58:	d2478793          	addi	a5,a5,-732 # 80022978 <log>
    80005c5c:	4f9c                	lw	a5,24(a5)
    80005c5e:	85be                	mv	a1,a5
    80005c60:	853a                	mv	a0,a4
    80005c62:	837fe0ef          	jal	80004498 <bread>
    80005c66:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80005c6a:	fe043783          	ld	a5,-32(s0)
    80005c6e:	05878793          	addi	a5,a5,88
    80005c72:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80005c76:	fd843783          	ld	a5,-40(s0)
    80005c7a:	4398                	lw	a4,0(a5)
    80005c7c:	0001d797          	auipc	a5,0x1d
    80005c80:	cfc78793          	addi	a5,a5,-772 # 80022978 <log>
    80005c84:	d798                	sw	a4,40(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005c86:	fe042623          	sw	zero,-20(s0)
    80005c8a:	a03d                	j	80005cb8 <read_head+0x78>
    log.lh.block[i] = lh->block[i];
    80005c8c:	fd843703          	ld	a4,-40(s0)
    80005c90:	fec42783          	lw	a5,-20(s0)
    80005c94:	078a                	slli	a5,a5,0x2
    80005c96:	97ba                	add	a5,a5,a4
    80005c98:	43d8                	lw	a4,4(a5)
    80005c9a:	0001d697          	auipc	a3,0x1d
    80005c9e:	cde68693          	addi	a3,a3,-802 # 80022978 <log>
    80005ca2:	fec42783          	lw	a5,-20(s0)
    80005ca6:	07a1                	addi	a5,a5,8
    80005ca8:	078a                	slli	a5,a5,0x2
    80005caa:	97b6                	add	a5,a5,a3
    80005cac:	c7d8                	sw	a4,12(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005cae:	fec42783          	lw	a5,-20(s0)
    80005cb2:	2785                	addiw	a5,a5,1
    80005cb4:	fef42623          	sw	a5,-20(s0)
    80005cb8:	0001d797          	auipc	a5,0x1d
    80005cbc:	cc078793          	addi	a5,a5,-832 # 80022978 <log>
    80005cc0:	579c                	lw	a5,40(a5)
    80005cc2:	fec42703          	lw	a4,-20(s0)
    80005cc6:	2701                	sext.w	a4,a4
    80005cc8:	fcf742e3          	blt	a4,a5,80005c8c <read_head+0x4c>
  }
  brelse(buf);
    80005ccc:	fe043503          	ld	a0,-32(s0)
    80005cd0:	857fe0ef          	jal	80004526 <brelse>
}
    80005cd4:	0001                	nop
    80005cd6:	70a2                	ld	ra,40(sp)
    80005cd8:	7402                	ld	s0,32(sp)
    80005cda:	6145                	addi	sp,sp,48
    80005cdc:	8082                	ret

0000000080005cde <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80005cde:	7179                	addi	sp,sp,-48
    80005ce0:	f406                	sd	ra,40(sp)
    80005ce2:	f022                	sd	s0,32(sp)
    80005ce4:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80005ce6:	0001d797          	auipc	a5,0x1d
    80005cea:	c9278793          	addi	a5,a5,-878 # 80022978 <log>
    80005cee:	53dc                	lw	a5,36(a5)
    80005cf0:	873e                	mv	a4,a5
    80005cf2:	0001d797          	auipc	a5,0x1d
    80005cf6:	c8678793          	addi	a5,a5,-890 # 80022978 <log>
    80005cfa:	4f9c                	lw	a5,24(a5)
    80005cfc:	85be                	mv	a1,a5
    80005cfe:	853a                	mv	a0,a4
    80005d00:	f98fe0ef          	jal	80004498 <bread>
    80005d04:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80005d08:	fe043783          	ld	a5,-32(s0)
    80005d0c:	05878793          	addi	a5,a5,88
    80005d10:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80005d14:	0001d797          	auipc	a5,0x1d
    80005d18:	c6478793          	addi	a5,a5,-924 # 80022978 <log>
    80005d1c:	5798                	lw	a4,40(a5)
    80005d1e:	fd843783          	ld	a5,-40(s0)
    80005d22:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005d24:	fe042623          	sw	zero,-20(s0)
    80005d28:	a03d                	j	80005d56 <write_head+0x78>
    hb->block[i] = log.lh.block[i];
    80005d2a:	0001d717          	auipc	a4,0x1d
    80005d2e:	c4e70713          	addi	a4,a4,-946 # 80022978 <log>
    80005d32:	fec42783          	lw	a5,-20(s0)
    80005d36:	07a1                	addi	a5,a5,8
    80005d38:	078a                	slli	a5,a5,0x2
    80005d3a:	97ba                	add	a5,a5,a4
    80005d3c:	47d8                	lw	a4,12(a5)
    80005d3e:	fd843683          	ld	a3,-40(s0)
    80005d42:	fec42783          	lw	a5,-20(s0)
    80005d46:	078a                	slli	a5,a5,0x2
    80005d48:	97b6                	add	a5,a5,a3
    80005d4a:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80005d4c:	fec42783          	lw	a5,-20(s0)
    80005d50:	2785                	addiw	a5,a5,1
    80005d52:	fef42623          	sw	a5,-20(s0)
    80005d56:	0001d797          	auipc	a5,0x1d
    80005d5a:	c2278793          	addi	a5,a5,-990 # 80022978 <log>
    80005d5e:	579c                	lw	a5,40(a5)
    80005d60:	fec42703          	lw	a4,-20(s0)
    80005d64:	2701                	sext.w	a4,a4
    80005d66:	fcf742e3          	blt	a4,a5,80005d2a <write_head+0x4c>
  }
  bwrite(buf);
    80005d6a:	fe043503          	ld	a0,-32(s0)
    80005d6e:	f7cfe0ef          	jal	800044ea <bwrite>
  brelse(buf);
    80005d72:	fe043503          	ld	a0,-32(s0)
    80005d76:	fb0fe0ef          	jal	80004526 <brelse>
}
    80005d7a:	0001                	nop
    80005d7c:	70a2                	ld	ra,40(sp)
    80005d7e:	7402                	ld	s0,32(sp)
    80005d80:	6145                	addi	sp,sp,48
    80005d82:	8082                	ret

0000000080005d84 <recover_from_log>:

static void
recover_from_log(void)
{
    80005d84:	1141                	addi	sp,sp,-16
    80005d86:	e406                	sd	ra,8(sp)
    80005d88:	e022                	sd	s0,0(sp)
    80005d8a:	0800                	addi	s0,sp,16
  read_head();
    80005d8c:	eb5ff0ef          	jal	80005c40 <read_head>
  install_trans(1); // if committed, copy from log to disk
    80005d90:	4505                	li	a0,1
    80005d92:	da3ff0ef          	jal	80005b34 <install_trans>
  log.lh.n = 0;
    80005d96:	0001d797          	auipc	a5,0x1d
    80005d9a:	be278793          	addi	a5,a5,-1054 # 80022978 <log>
    80005d9e:	0207a423          	sw	zero,40(a5)
  write_head(); // clear the log
    80005da2:	f3dff0ef          	jal	80005cde <write_head>
}
    80005da6:	0001                	nop
    80005da8:	60a2                	ld	ra,8(sp)
    80005daa:	6402                	ld	s0,0(sp)
    80005dac:	0141                	addi	sp,sp,16
    80005dae:	8082                	ret

0000000080005db0 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80005db0:	1141                	addi	sp,sp,-16
    80005db2:	e406                	sd	ra,8(sp)
    80005db4:	e022                	sd	s0,0(sp)
    80005db6:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80005db8:	0001d517          	auipc	a0,0x1d
    80005dbc:	bc050513          	addi	a0,a0,-1088 # 80022978 <log>
    80005dc0:	d8afb0ef          	jal	8000134a <acquire>
  while(1){
    if(log.committing){
    80005dc4:	0001d797          	auipc	a5,0x1d
    80005dc8:	bb478793          	addi	a5,a5,-1100 # 80022978 <log>
    80005dcc:	539c                	lw	a5,32(a5)
    80005dce:	cf81                	beqz	a5,80005de6 <begin_op+0x36>
      sleep(&log, &log.lock);
    80005dd0:	0001d597          	auipc	a1,0x1d
    80005dd4:	ba858593          	addi	a1,a1,-1112 # 80022978 <log>
    80005dd8:	0001d517          	auipc	a0,0x1d
    80005ddc:	ba050513          	addi	a0,a0,-1120 # 80022978 <log>
    80005de0:	d16fd0ef          	jal	800032f6 <sleep>
    80005de4:	b7c5                	j	80005dc4 <begin_op+0x14>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    80005de6:	0001d797          	auipc	a5,0x1d
    80005dea:	b9278793          	addi	a5,a5,-1134 # 80022978 <log>
    80005dee:	5798                	lw	a4,40(a5)
    80005df0:	0001d797          	auipc	a5,0x1d
    80005df4:	b8878793          	addi	a5,a5,-1144 # 80022978 <log>
    80005df8:	4fdc                	lw	a5,28(a5)
    80005dfa:	2785                	addiw	a5,a5,1
    80005dfc:	2781                	sext.w	a5,a5
    80005dfe:	86be                	mv	a3,a5
    80005e00:	87b6                	mv	a5,a3
    80005e02:	0027979b          	slliw	a5,a5,0x2
    80005e06:	9fb5                	addw	a5,a5,a3
    80005e08:	0017979b          	slliw	a5,a5,0x1
    80005e0c:	2781                	sext.w	a5,a5
    80005e0e:	9fb9                	addw	a5,a5,a4
    80005e10:	0007871b          	sext.w	a4,a5
    80005e14:	47f9                	li	a5,30
    80005e16:	00e7dd63          	bge	a5,a4,80005e30 <begin_op+0x80>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80005e1a:	0001d597          	auipc	a1,0x1d
    80005e1e:	b5e58593          	addi	a1,a1,-1186 # 80022978 <log>
    80005e22:	0001d517          	auipc	a0,0x1d
    80005e26:	b5650513          	addi	a0,a0,-1194 # 80022978 <log>
    80005e2a:	cccfd0ef          	jal	800032f6 <sleep>
    80005e2e:	bf59                	j	80005dc4 <begin_op+0x14>
    } else {
      log.outstanding += 1;
    80005e30:	0001d797          	auipc	a5,0x1d
    80005e34:	b4878793          	addi	a5,a5,-1208 # 80022978 <log>
    80005e38:	4fdc                	lw	a5,28(a5)
    80005e3a:	2785                	addiw	a5,a5,1
    80005e3c:	0007871b          	sext.w	a4,a5
    80005e40:	0001d797          	auipc	a5,0x1d
    80005e44:	b3878793          	addi	a5,a5,-1224 # 80022978 <log>
    80005e48:	cfd8                	sw	a4,28(a5)
      release(&log.lock);
    80005e4a:	0001d517          	auipc	a0,0x1d
    80005e4e:	b2e50513          	addi	a0,a0,-1234 # 80022978 <log>
    80005e52:	d4cfb0ef          	jal	8000139e <release>
      break;
    80005e56:	0001                	nop
    }
  }
}
    80005e58:	0001                	nop
    80005e5a:	60a2                	ld	ra,8(sp)
    80005e5c:	6402                	ld	s0,0(sp)
    80005e5e:	0141                	addi	sp,sp,16
    80005e60:	8082                	ret

0000000080005e62 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80005e62:	1101                	addi	sp,sp,-32
    80005e64:	ec06                	sd	ra,24(sp)
    80005e66:	e822                	sd	s0,16(sp)
    80005e68:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80005e6a:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    80005e6e:	0001d517          	auipc	a0,0x1d
    80005e72:	b0a50513          	addi	a0,a0,-1270 # 80022978 <log>
    80005e76:	cd4fb0ef          	jal	8000134a <acquire>
  log.outstanding -= 1;
    80005e7a:	0001d797          	auipc	a5,0x1d
    80005e7e:	afe78793          	addi	a5,a5,-1282 # 80022978 <log>
    80005e82:	4fdc                	lw	a5,28(a5)
    80005e84:	37fd                	addiw	a5,a5,-1
    80005e86:	0007871b          	sext.w	a4,a5
    80005e8a:	0001d797          	auipc	a5,0x1d
    80005e8e:	aee78793          	addi	a5,a5,-1298 # 80022978 <log>
    80005e92:	cfd8                	sw	a4,28(a5)
  if(log.committing)
    80005e94:	0001d797          	auipc	a5,0x1d
    80005e98:	ae478793          	addi	a5,a5,-1308 # 80022978 <log>
    80005e9c:	539c                	lw	a5,32(a5)
    80005e9e:	c799                	beqz	a5,80005eac <end_op+0x4a>
    panic("log.committing");
    80005ea0:	00004517          	auipc	a0,0x4
    80005ea4:	6c050513          	addi	a0,a0,1728 # 8000a560 <etext+0x560>
    80005ea8:	f8ffa0ef          	jal	80000e36 <panic>
  if(log.outstanding == 0){
    80005eac:	0001d797          	auipc	a5,0x1d
    80005eb0:	acc78793          	addi	a5,a5,-1332 # 80022978 <log>
    80005eb4:	4fdc                	lw	a5,28(a5)
    80005eb6:	eb99                	bnez	a5,80005ecc <end_op+0x6a>
    do_commit = 1;
    80005eb8:	4785                	li	a5,1
    80005eba:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    80005ebe:	0001d797          	auipc	a5,0x1d
    80005ec2:	aba78793          	addi	a5,a5,-1350 # 80022978 <log>
    80005ec6:	4705                	li	a4,1
    80005ec8:	d398                	sw	a4,32(a5)
    80005eca:	a039                	j	80005ed8 <end_op+0x76>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80005ecc:	0001d517          	auipc	a0,0x1d
    80005ed0:	aac50513          	addi	a0,a0,-1364 # 80022978 <log>
    80005ed4:	c86fd0ef          	jal	8000335a <wakeup>
  }
  release(&log.lock);
    80005ed8:	0001d517          	auipc	a0,0x1d
    80005edc:	aa050513          	addi	a0,a0,-1376 # 80022978 <log>
    80005ee0:	cbefb0ef          	jal	8000139e <release>

  if(do_commit){
    80005ee4:	fec42783          	lw	a5,-20(s0)
    80005ee8:	2781                	sext.w	a5,a5
    80005eea:	cb9d                	beqz	a5,80005f20 <end_op+0xbe>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80005eec:	104000ef          	jal	80005ff0 <commit>
    acquire(&log.lock);
    80005ef0:	0001d517          	auipc	a0,0x1d
    80005ef4:	a8850513          	addi	a0,a0,-1400 # 80022978 <log>
    80005ef8:	c52fb0ef          	jal	8000134a <acquire>
    log.committing = 0;
    80005efc:	0001d797          	auipc	a5,0x1d
    80005f00:	a7c78793          	addi	a5,a5,-1412 # 80022978 <log>
    80005f04:	0207a023          	sw	zero,32(a5)
    wakeup(&log);
    80005f08:	0001d517          	auipc	a0,0x1d
    80005f0c:	a7050513          	addi	a0,a0,-1424 # 80022978 <log>
    80005f10:	c4afd0ef          	jal	8000335a <wakeup>
    release(&log.lock);
    80005f14:	0001d517          	auipc	a0,0x1d
    80005f18:	a6450513          	addi	a0,a0,-1436 # 80022978 <log>
    80005f1c:	c82fb0ef          	jal	8000139e <release>
  }
}
    80005f20:	0001                	nop
    80005f22:	60e2                	ld	ra,24(sp)
    80005f24:	6442                	ld	s0,16(sp)
    80005f26:	6105                	addi	sp,sp,32
    80005f28:	8082                	ret

0000000080005f2a <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80005f2a:	7179                	addi	sp,sp,-48
    80005f2c:	f406                	sd	ra,40(sp)
    80005f2e:	f022                	sd	s0,32(sp)
    80005f30:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80005f32:	fe042623          	sw	zero,-20(s0)
    80005f36:	a869                	j	80005fd0 <write_log+0xa6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80005f38:	0001d797          	auipc	a5,0x1d
    80005f3c:	a4078793          	addi	a5,a5,-1472 # 80022978 <log>
    80005f40:	53dc                	lw	a5,36(a5)
    80005f42:	86be                	mv	a3,a5
    80005f44:	0001d797          	auipc	a5,0x1d
    80005f48:	a3478793          	addi	a5,a5,-1484 # 80022978 <log>
    80005f4c:	4f9c                	lw	a5,24(a5)
    80005f4e:	fec42703          	lw	a4,-20(s0)
    80005f52:	9fb9                	addw	a5,a5,a4
    80005f54:	2781                	sext.w	a5,a5
    80005f56:	2785                	addiw	a5,a5,1
    80005f58:	2781                	sext.w	a5,a5
    80005f5a:	85be                	mv	a1,a5
    80005f5c:	8536                	mv	a0,a3
    80005f5e:	d3afe0ef          	jal	80004498 <bread>
    80005f62:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80005f66:	0001d797          	auipc	a5,0x1d
    80005f6a:	a1278793          	addi	a5,a5,-1518 # 80022978 <log>
    80005f6e:	53dc                	lw	a5,36(a5)
    80005f70:	86be                	mv	a3,a5
    80005f72:	0001d717          	auipc	a4,0x1d
    80005f76:	a0670713          	addi	a4,a4,-1530 # 80022978 <log>
    80005f7a:	fec42783          	lw	a5,-20(s0)
    80005f7e:	07a1                	addi	a5,a5,8
    80005f80:	078a                	slli	a5,a5,0x2
    80005f82:	97ba                	add	a5,a5,a4
    80005f84:	47dc                	lw	a5,12(a5)
    80005f86:	85be                	mv	a1,a5
    80005f88:	8536                	mv	a0,a3
    80005f8a:	d0efe0ef          	jal	80004498 <bread>
    80005f8e:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80005f92:	fe043783          	ld	a5,-32(s0)
    80005f96:	05878713          	addi	a4,a5,88
    80005f9a:	fd843783          	ld	a5,-40(s0)
    80005f9e:	05878793          	addi	a5,a5,88
    80005fa2:	40000613          	li	a2,1024
    80005fa6:	85be                	mv	a1,a5
    80005fa8:	853a                	mv	a0,a4
    80005faa:	e18fb0ef          	jal	800015c2 <memmove>
    bwrite(to);  // write the log
    80005fae:	fe043503          	ld	a0,-32(s0)
    80005fb2:	d38fe0ef          	jal	800044ea <bwrite>
    brelse(from);
    80005fb6:	fd843503          	ld	a0,-40(s0)
    80005fba:	d6cfe0ef          	jal	80004526 <brelse>
    brelse(to);
    80005fbe:	fe043503          	ld	a0,-32(s0)
    80005fc2:	d64fe0ef          	jal	80004526 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80005fc6:	fec42783          	lw	a5,-20(s0)
    80005fca:	2785                	addiw	a5,a5,1
    80005fcc:	fef42623          	sw	a5,-20(s0)
    80005fd0:	0001d797          	auipc	a5,0x1d
    80005fd4:	9a878793          	addi	a5,a5,-1624 # 80022978 <log>
    80005fd8:	579c                	lw	a5,40(a5)
    80005fda:	fec42703          	lw	a4,-20(s0)
    80005fde:	2701                	sext.w	a4,a4
    80005fe0:	f4f74ce3          	blt	a4,a5,80005f38 <write_log+0xe>
  }
}
    80005fe4:	0001                	nop
    80005fe6:	0001                	nop
    80005fe8:	70a2                	ld	ra,40(sp)
    80005fea:	7402                	ld	s0,32(sp)
    80005fec:	6145                	addi	sp,sp,48
    80005fee:	8082                	ret

0000000080005ff0 <commit>:

static void
commit()
{
    80005ff0:	1141                	addi	sp,sp,-16
    80005ff2:	e406                	sd	ra,8(sp)
    80005ff4:	e022                	sd	s0,0(sp)
    80005ff6:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80005ff8:	0001d797          	auipc	a5,0x1d
    80005ffc:	98078793          	addi	a5,a5,-1664 # 80022978 <log>
    80006000:	579c                	lw	a5,40(a5)
    80006002:	02f05163          	blez	a5,80006024 <commit+0x34>
    write_log();     // Write modified blocks from cache to log
    80006006:	f25ff0ef          	jal	80005f2a <write_log>
    write_head();    // Write header to disk -- the real commit
    8000600a:	cd5ff0ef          	jal	80005cde <write_head>
    install_trans(0); // Now install writes to home locations
    8000600e:	4501                	li	a0,0
    80006010:	b25ff0ef          	jal	80005b34 <install_trans>
    log.lh.n = 0;
    80006014:	0001d797          	auipc	a5,0x1d
    80006018:	96478793          	addi	a5,a5,-1692 # 80022978 <log>
    8000601c:	0207a423          	sw	zero,40(a5)
    write_head();    // Erase the transaction from the log
    80006020:	cbfff0ef          	jal	80005cde <write_head>
  }
}
    80006024:	0001                	nop
    80006026:	60a2                	ld	ra,8(sp)
    80006028:	6402                	ld	s0,0(sp)
    8000602a:	0141                	addi	sp,sp,16
    8000602c:	8082                	ret

000000008000602e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000602e:	7179                	addi	sp,sp,-48
    80006030:	f406                	sd	ra,40(sp)
    80006032:	f022                	sd	s0,32(sp)
    80006034:	1800                	addi	s0,sp,48
    80006036:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    8000603a:	0001d517          	auipc	a0,0x1d
    8000603e:	93e50513          	addi	a0,a0,-1730 # 80022978 <log>
    80006042:	b08fb0ef          	jal	8000134a <acquire>
  if (log.lh.n >= LOGBLOCKS)
    80006046:	0001d797          	auipc	a5,0x1d
    8000604a:	93278793          	addi	a5,a5,-1742 # 80022978 <log>
    8000604e:	5798                	lw	a4,40(a5)
    80006050:	47f5                	li	a5,29
    80006052:	00e7d863          	bge	a5,a4,80006062 <log_write+0x34>
    panic("too big a transaction");
    80006056:	00004517          	auipc	a0,0x4
    8000605a:	51a50513          	addi	a0,a0,1306 # 8000a570 <etext+0x570>
    8000605e:	dd9fa0ef          	jal	80000e36 <panic>
  if (log.outstanding < 1)
    80006062:	0001d797          	auipc	a5,0x1d
    80006066:	91678793          	addi	a5,a5,-1770 # 80022978 <log>
    8000606a:	4fdc                	lw	a5,28(a5)
    8000606c:	00f04863          	bgtz	a5,8000607c <log_write+0x4e>
    panic("log_write outside of trans");
    80006070:	00004517          	auipc	a0,0x4
    80006074:	51850513          	addi	a0,a0,1304 # 8000a588 <etext+0x588>
    80006078:	dbffa0ef          	jal	80000e36 <panic>

  for (i = 0; i < log.lh.n; i++) {
    8000607c:	fe042623          	sw	zero,-20(s0)
    80006080:	a035                	j	800060ac <log_write+0x7e>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80006082:	0001d717          	auipc	a4,0x1d
    80006086:	8f670713          	addi	a4,a4,-1802 # 80022978 <log>
    8000608a:	fec42783          	lw	a5,-20(s0)
    8000608e:	07a1                	addi	a5,a5,8
    80006090:	078a                	slli	a5,a5,0x2
    80006092:	97ba                	add	a5,a5,a4
    80006094:	47dc                	lw	a5,12(a5)
    80006096:	873e                	mv	a4,a5
    80006098:	fd843783          	ld	a5,-40(s0)
    8000609c:	47dc                	lw	a5,12(a5)
    8000609e:	02f70263          	beq	a4,a5,800060c2 <log_write+0x94>
  for (i = 0; i < log.lh.n; i++) {
    800060a2:	fec42783          	lw	a5,-20(s0)
    800060a6:	2785                	addiw	a5,a5,1
    800060a8:	fef42623          	sw	a5,-20(s0)
    800060ac:	0001d797          	auipc	a5,0x1d
    800060b0:	8cc78793          	addi	a5,a5,-1844 # 80022978 <log>
    800060b4:	579c                	lw	a5,40(a5)
    800060b6:	fec42703          	lw	a4,-20(s0)
    800060ba:	2701                	sext.w	a4,a4
    800060bc:	fcf743e3          	blt	a4,a5,80006082 <log_write+0x54>
    800060c0:	a011                	j	800060c4 <log_write+0x96>
      break;
    800060c2:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    800060c4:	fd843783          	ld	a5,-40(s0)
    800060c8:	47dc                	lw	a5,12(a5)
    800060ca:	86be                	mv	a3,a5
    800060cc:	0001d717          	auipc	a4,0x1d
    800060d0:	8ac70713          	addi	a4,a4,-1876 # 80022978 <log>
    800060d4:	fec42783          	lw	a5,-20(s0)
    800060d8:	07a1                	addi	a5,a5,8
    800060da:	078a                	slli	a5,a5,0x2
    800060dc:	97ba                	add	a5,a5,a4
    800060de:	c7d4                	sw	a3,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    800060e0:	0001d797          	auipc	a5,0x1d
    800060e4:	89878793          	addi	a5,a5,-1896 # 80022978 <log>
    800060e8:	579c                	lw	a5,40(a5)
    800060ea:	fec42703          	lw	a4,-20(s0)
    800060ee:	2701                	sext.w	a4,a4
    800060f0:	02f71363          	bne	a4,a5,80006116 <log_write+0xe8>
    bpin(b);
    800060f4:	fd843503          	ld	a0,-40(s0)
    800060f8:	d08fe0ef          	jal	80004600 <bpin>
    log.lh.n++;
    800060fc:	0001d797          	auipc	a5,0x1d
    80006100:	87c78793          	addi	a5,a5,-1924 # 80022978 <log>
    80006104:	579c                	lw	a5,40(a5)
    80006106:	2785                	addiw	a5,a5,1
    80006108:	0007871b          	sext.w	a4,a5
    8000610c:	0001d797          	auipc	a5,0x1d
    80006110:	86c78793          	addi	a5,a5,-1940 # 80022978 <log>
    80006114:	d798                	sw	a4,40(a5)
  }
  release(&log.lock);
    80006116:	0001d517          	auipc	a0,0x1d
    8000611a:	86250513          	addi	a0,a0,-1950 # 80022978 <log>
    8000611e:	a80fb0ef          	jal	8000139e <release>
}
    80006122:	0001                	nop
    80006124:	70a2                	ld	ra,40(sp)
    80006126:	7402                	ld	s0,32(sp)
    80006128:	6145                	addi	sp,sp,48
    8000612a:	8082                	ret

000000008000612c <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000612c:	1101                	addi	sp,sp,-32
    8000612e:	ec06                	sd	ra,24(sp)
    80006130:	e822                	sd	s0,16(sp)
    80006132:	1000                	addi	s0,sp,32
    80006134:	fea43423          	sd	a0,-24(s0)
    80006138:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    8000613c:	fe843783          	ld	a5,-24(s0)
    80006140:	07a1                	addi	a5,a5,8
    80006142:	00004597          	auipc	a1,0x4
    80006146:	46658593          	addi	a1,a1,1126 # 8000a5a8 <etext+0x5a8>
    8000614a:	853e                	mv	a0,a5
    8000614c:	9cafb0ef          	jal	80001316 <initlock>
  lk->name = name;
    80006150:	fe843783          	ld	a5,-24(s0)
    80006154:	fe043703          	ld	a4,-32(s0)
    80006158:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    8000615a:	fe843783          	ld	a5,-24(s0)
    8000615e:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006162:	fe843783          	ld	a5,-24(s0)
    80006166:	0207a423          	sw	zero,40(a5)
}
    8000616a:	0001                	nop
    8000616c:	60e2                	ld	ra,24(sp)
    8000616e:	6442                	ld	s0,16(sp)
    80006170:	6105                	addi	sp,sp,32
    80006172:	8082                	ret

0000000080006174 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80006174:	1101                	addi	sp,sp,-32
    80006176:	ec06                	sd	ra,24(sp)
    80006178:	e822                	sd	s0,16(sp)
    8000617a:	1000                	addi	s0,sp,32
    8000617c:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006180:	fe843783          	ld	a5,-24(s0)
    80006184:	07a1                	addi	a5,a5,8
    80006186:	853e                	mv	a0,a5
    80006188:	9c2fb0ef          	jal	8000134a <acquire>
  while (lk->locked) {
    8000618c:	a809                	j	8000619e <acquiresleep+0x2a>
    sleep(lk, &lk->lk);
    8000618e:	fe843783          	ld	a5,-24(s0)
    80006192:	07a1                	addi	a5,a5,8
    80006194:	85be                	mv	a1,a5
    80006196:	fe843503          	ld	a0,-24(s0)
    8000619a:	95cfd0ef          	jal	800032f6 <sleep>
  while (lk->locked) {
    8000619e:	fe843783          	ld	a5,-24(s0)
    800061a2:	439c                	lw	a5,0(a5)
    800061a4:	f7ed                	bnez	a5,8000618e <acquiresleep+0x1a>
  }
  lk->locked = 1;
    800061a6:	fe843783          	ld	a5,-24(s0)
    800061aa:	4705                	li	a4,1
    800061ac:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    800061ae:	ea6fc0ef          	jal	80002854 <myproc>
    800061b2:	87aa                	mv	a5,a0
    800061b4:	5b98                	lw	a4,48(a5)
    800061b6:	fe843783          	ld	a5,-24(s0)
    800061ba:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    800061bc:	fe843783          	ld	a5,-24(s0)
    800061c0:	07a1                	addi	a5,a5,8
    800061c2:	853e                	mv	a0,a5
    800061c4:	9dafb0ef          	jal	8000139e <release>
}
    800061c8:	0001                	nop
    800061ca:	60e2                	ld	ra,24(sp)
    800061cc:	6442                	ld	s0,16(sp)
    800061ce:	6105                	addi	sp,sp,32
    800061d0:	8082                	ret

00000000800061d2 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800061d2:	1101                	addi	sp,sp,-32
    800061d4:	ec06                	sd	ra,24(sp)
    800061d6:	e822                	sd	s0,16(sp)
    800061d8:	1000                	addi	s0,sp,32
    800061da:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800061de:	fe843783          	ld	a5,-24(s0)
    800061e2:	07a1                	addi	a5,a5,8
    800061e4:	853e                	mv	a0,a5
    800061e6:	964fb0ef          	jal	8000134a <acquire>
  lk->locked = 0;
    800061ea:	fe843783          	ld	a5,-24(s0)
    800061ee:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800061f2:	fe843783          	ld	a5,-24(s0)
    800061f6:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    800061fa:	fe843503          	ld	a0,-24(s0)
    800061fe:	95cfd0ef          	jal	8000335a <wakeup>
  release(&lk->lk);
    80006202:	fe843783          	ld	a5,-24(s0)
    80006206:	07a1                	addi	a5,a5,8
    80006208:	853e                	mv	a0,a5
    8000620a:	994fb0ef          	jal	8000139e <release>
}
    8000620e:	0001                	nop
    80006210:	60e2                	ld	ra,24(sp)
    80006212:	6442                	ld	s0,16(sp)
    80006214:	6105                	addi	sp,sp,32
    80006216:	8082                	ret

0000000080006218 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80006218:	7139                	addi	sp,sp,-64
    8000621a:	fc06                	sd	ra,56(sp)
    8000621c:	f822                	sd	s0,48(sp)
    8000621e:	f426                	sd	s1,40(sp)
    80006220:	0080                	addi	s0,sp,64
    80006222:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80006226:	fc843783          	ld	a5,-56(s0)
    8000622a:	07a1                	addi	a5,a5,8
    8000622c:	853e                	mv	a0,a5
    8000622e:	91cfb0ef          	jal	8000134a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80006232:	fc843783          	ld	a5,-56(s0)
    80006236:	439c                	lw	a5,0(a5)
    80006238:	cf81                	beqz	a5,80006250 <holdingsleep+0x38>
    8000623a:	fc843783          	ld	a5,-56(s0)
    8000623e:	5784                	lw	s1,40(a5)
    80006240:	e14fc0ef          	jal	80002854 <myproc>
    80006244:	87aa                	mv	a5,a0
    80006246:	5b9c                	lw	a5,48(a5)
    80006248:	00f49463          	bne	s1,a5,80006250 <holdingsleep+0x38>
    8000624c:	4785                	li	a5,1
    8000624e:	a011                	j	80006252 <holdingsleep+0x3a>
    80006250:	4781                	li	a5,0
    80006252:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    80006256:	fc843783          	ld	a5,-56(s0)
    8000625a:	07a1                	addi	a5,a5,8
    8000625c:	853e                	mv	a0,a5
    8000625e:	940fb0ef          	jal	8000139e <release>
  return r;
    80006262:	fdc42783          	lw	a5,-36(s0)
}
    80006266:	853e                	mv	a0,a5
    80006268:	70e2                	ld	ra,56(sp)
    8000626a:	7442                	ld	s0,48(sp)
    8000626c:	74a2                	ld	s1,40(sp)
    8000626e:	6121                	addi	sp,sp,64
    80006270:	8082                	ret

0000000080006272 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80006272:	1141                	addi	sp,sp,-16
    80006274:	e406                	sd	ra,8(sp)
    80006276:	e022                	sd	s0,0(sp)
    80006278:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    8000627a:	00004597          	auipc	a1,0x4
    8000627e:	33e58593          	addi	a1,a1,830 # 8000a5b8 <etext+0x5b8>
    80006282:	0001d517          	auipc	a0,0x1d
    80006286:	83e50513          	addi	a0,a0,-1986 # 80022ac0 <ftable>
    8000628a:	88cfb0ef          	jal	80001316 <initlock>
}
    8000628e:	0001                	nop
    80006290:	60a2                	ld	ra,8(sp)
    80006292:	6402                	ld	s0,0(sp)
    80006294:	0141                	addi	sp,sp,16
    80006296:	8082                	ret

0000000080006298 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006298:	1101                	addi	sp,sp,-32
    8000629a:	ec06                	sd	ra,24(sp)
    8000629c:	e822                	sd	s0,16(sp)
    8000629e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800062a0:	0001d517          	auipc	a0,0x1d
    800062a4:	82050513          	addi	a0,a0,-2016 # 80022ac0 <ftable>
    800062a8:	8a2fb0ef          	jal	8000134a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800062ac:	0001d797          	auipc	a5,0x1d
    800062b0:	82c78793          	addi	a5,a5,-2004 # 80022ad8 <ftable+0x18>
    800062b4:	fef43423          	sd	a5,-24(s0)
    800062b8:	a805                	j	800062e8 <filealloc+0x50>
    if(f->ref == 0){
    800062ba:	fe843783          	ld	a5,-24(s0)
    800062be:	43dc                	lw	a5,4(a5)
    800062c0:	ef91                	bnez	a5,800062dc <filealloc+0x44>
      f->ref = 1;
    800062c2:	fe843783          	ld	a5,-24(s0)
    800062c6:	4705                	li	a4,1
    800062c8:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    800062ca:	0001c517          	auipc	a0,0x1c
    800062ce:	7f650513          	addi	a0,a0,2038 # 80022ac0 <ftable>
    800062d2:	8ccfb0ef          	jal	8000139e <release>
      return f;
    800062d6:	fe843783          	ld	a5,-24(s0)
    800062da:	a035                	j	80006306 <filealloc+0x6e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800062dc:	fe843783          	ld	a5,-24(s0)
    800062e0:	02878793          	addi	a5,a5,40
    800062e4:	fef43423          	sd	a5,-24(s0)
    800062e8:	0001d797          	auipc	a5,0x1d
    800062ec:	79078793          	addi	a5,a5,1936 # 80023a78 <disk>
    800062f0:	fe843703          	ld	a4,-24(s0)
    800062f4:	fcf763e3          	bltu	a4,a5,800062ba <filealloc+0x22>
    }
  }
  release(&ftable.lock);
    800062f8:	0001c517          	auipc	a0,0x1c
    800062fc:	7c850513          	addi	a0,a0,1992 # 80022ac0 <ftable>
    80006300:	89efb0ef          	jal	8000139e <release>
  return 0;
    80006304:	4781                	li	a5,0
}
    80006306:	853e                	mv	a0,a5
    80006308:	60e2                	ld	ra,24(sp)
    8000630a:	6442                	ld	s0,16(sp)
    8000630c:	6105                	addi	sp,sp,32
    8000630e:	8082                	ret

0000000080006310 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80006310:	1101                	addi	sp,sp,-32
    80006312:	ec06                	sd	ra,24(sp)
    80006314:	e822                	sd	s0,16(sp)
    80006316:	1000                	addi	s0,sp,32
    80006318:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    8000631c:	0001c517          	auipc	a0,0x1c
    80006320:	7a450513          	addi	a0,a0,1956 # 80022ac0 <ftable>
    80006324:	826fb0ef          	jal	8000134a <acquire>
  if(f->ref < 1)
    80006328:	fe843783          	ld	a5,-24(s0)
    8000632c:	43dc                	lw	a5,4(a5)
    8000632e:	00f04863          	bgtz	a5,8000633e <filedup+0x2e>
    panic("filedup");
    80006332:	00004517          	auipc	a0,0x4
    80006336:	28e50513          	addi	a0,a0,654 # 8000a5c0 <etext+0x5c0>
    8000633a:	afdfa0ef          	jal	80000e36 <panic>
  f->ref++;
    8000633e:	fe843783          	ld	a5,-24(s0)
    80006342:	43dc                	lw	a5,4(a5)
    80006344:	2785                	addiw	a5,a5,1
    80006346:	0007871b          	sext.w	a4,a5
    8000634a:	fe843783          	ld	a5,-24(s0)
    8000634e:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006350:	0001c517          	auipc	a0,0x1c
    80006354:	77050513          	addi	a0,a0,1904 # 80022ac0 <ftable>
    80006358:	846fb0ef          	jal	8000139e <release>
  return f;
    8000635c:	fe843783          	ld	a5,-24(s0)
}
    80006360:	853e                	mv	a0,a5
    80006362:	60e2                	ld	ra,24(sp)
    80006364:	6442                	ld	s0,16(sp)
    80006366:	6105                	addi	sp,sp,32
    80006368:	8082                	ret

000000008000636a <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    8000636a:	715d                	addi	sp,sp,-80
    8000636c:	e486                	sd	ra,72(sp)
    8000636e:	e0a2                	sd	s0,64(sp)
    80006370:	0880                	addi	s0,sp,80
    80006372:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006376:	0001c517          	auipc	a0,0x1c
    8000637a:	74a50513          	addi	a0,a0,1866 # 80022ac0 <ftable>
    8000637e:	fcdfa0ef          	jal	8000134a <acquire>
  if(f->ref < 1)
    80006382:	fb843783          	ld	a5,-72(s0)
    80006386:	43dc                	lw	a5,4(a5)
    80006388:	00f04863          	bgtz	a5,80006398 <fileclose+0x2e>
    panic("fileclose");
    8000638c:	00004517          	auipc	a0,0x4
    80006390:	23c50513          	addi	a0,a0,572 # 8000a5c8 <etext+0x5c8>
    80006394:	aa3fa0ef          	jal	80000e36 <panic>
  if(--f->ref > 0){
    80006398:	fb843783          	ld	a5,-72(s0)
    8000639c:	43dc                	lw	a5,4(a5)
    8000639e:	37fd                	addiw	a5,a5,-1
    800063a0:	0007871b          	sext.w	a4,a5
    800063a4:	fb843783          	ld	a5,-72(s0)
    800063a8:	c3d8                	sw	a4,4(a5)
    800063aa:	fb843783          	ld	a5,-72(s0)
    800063ae:	43dc                	lw	a5,4(a5)
    800063b0:	00f05963          	blez	a5,800063c2 <fileclose+0x58>
    release(&ftable.lock);
    800063b4:	0001c517          	auipc	a0,0x1c
    800063b8:	70c50513          	addi	a0,a0,1804 # 80022ac0 <ftable>
    800063bc:	fe3fa0ef          	jal	8000139e <release>
    800063c0:	a051                	j	80006444 <fileclose+0xda>
    return;
  }
  ff = *f;
    800063c2:	fb843783          	ld	a5,-72(s0)
    800063c6:	638c                	ld	a1,0(a5)
    800063c8:	6790                	ld	a2,8(a5)
    800063ca:	6b94                	ld	a3,16(a5)
    800063cc:	6f98                	ld	a4,24(a5)
    800063ce:	739c                	ld	a5,32(a5)
    800063d0:	fcb43423          	sd	a1,-56(s0)
    800063d4:	fcc43823          	sd	a2,-48(s0)
    800063d8:	fcd43c23          	sd	a3,-40(s0)
    800063dc:	fee43023          	sd	a4,-32(s0)
    800063e0:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    800063e4:	fb843783          	ld	a5,-72(s0)
    800063e8:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    800063ec:	fb843783          	ld	a5,-72(s0)
    800063f0:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    800063f4:	0001c517          	auipc	a0,0x1c
    800063f8:	6cc50513          	addi	a0,a0,1740 # 80022ac0 <ftable>
    800063fc:	fa3fa0ef          	jal	8000139e <release>

  if(ff.type == FD_PIPE){
    80006400:	fc842703          	lw	a4,-56(s0)
    80006404:	4785                	li	a5,1
    80006406:	00f71c63          	bne	a4,a5,8000641e <fileclose+0xb4>
    pipeclose(ff.pipe, ff.writable);
    8000640a:	fd843783          	ld	a5,-40(s0)
    8000640e:	fd144703          	lbu	a4,-47(s0)
    80006412:	2701                	sext.w	a4,a4
    80006414:	85ba                	mv	a1,a4
    80006416:	853e                	mv	a0,a5
    80006418:	51e000ef          	jal	80006936 <pipeclose>
    8000641c:	a025                	j	80006444 <fileclose+0xda>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    8000641e:	fc842703          	lw	a4,-56(s0)
    80006422:	4789                	li	a5,2
    80006424:	00f70763          	beq	a4,a5,80006432 <fileclose+0xc8>
    80006428:	fc842703          	lw	a4,-56(s0)
    8000642c:	478d                	li	a5,3
    8000642e:	00f71b63          	bne	a4,a5,80006444 <fileclose+0xda>
    begin_op();
    80006432:	97fff0ef          	jal	80005db0 <begin_op>
    iput(ff.ip);
    80006436:	fe043783          	ld	a5,-32(s0)
    8000643a:	853e                	mv	a0,a5
    8000643c:	ac9fe0ef          	jal	80004f04 <iput>
    end_op();
    80006440:	a23ff0ef          	jal	80005e62 <end_op>
  }
}
    80006444:	60a6                	ld	ra,72(sp)
    80006446:	6406                	ld	s0,64(sp)
    80006448:	6161                	addi	sp,sp,80
    8000644a:	8082                	ret

000000008000644c <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000644c:	7139                	addi	sp,sp,-64
    8000644e:	fc06                	sd	ra,56(sp)
    80006450:	f822                	sd	s0,48(sp)
    80006452:	0080                	addi	s0,sp,64
    80006454:	fca43423          	sd	a0,-56(s0)
    80006458:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    8000645c:	bf8fc0ef          	jal	80002854 <myproc>
    80006460:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006464:	fc843783          	ld	a5,-56(s0)
    80006468:	4398                	lw	a4,0(a5)
    8000646a:	4789                	li	a5,2
    8000646c:	00f70863          	beq	a4,a5,8000647c <filestat+0x30>
    80006470:	fc843783          	ld	a5,-56(s0)
    80006474:	4398                	lw	a4,0(a5)
    80006476:	478d                	li	a5,3
    80006478:	04f71a63          	bne	a4,a5,800064cc <filestat+0x80>
    ilock(f->ip);
    8000647c:	fc843783          	ld	a5,-56(s0)
    80006480:	6f9c                	ld	a5,24(a5)
    80006482:	853e                	mv	a0,a5
    80006484:	917fe0ef          	jal	80004d9a <ilock>
    stati(f->ip, &st);
    80006488:	fc843783          	ld	a5,-56(s0)
    8000648c:	6f9c                	ld	a5,24(a5)
    8000648e:	fd040713          	addi	a4,s0,-48
    80006492:	85ba                	mv	a1,a4
    80006494:	853e                	mv	a0,a5
    80006496:	eb5fe0ef          	jal	8000534a <stati>
    iunlock(f->ip);
    8000649a:	fc843783          	ld	a5,-56(s0)
    8000649e:	6f9c                	ld	a5,24(a5)
    800064a0:	853e                	mv	a0,a5
    800064a2:	a15fe0ef          	jal	80004eb6 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800064a6:	fe843783          	ld	a5,-24(s0)
    800064aa:	6bbc                	ld	a5,80(a5)
    800064ac:	fd040713          	addi	a4,s0,-48
    800064b0:	46e1                	li	a3,24
    800064b2:	863a                	mv	a2,a4
    800064b4:	fc043583          	ld	a1,-64(s0)
    800064b8:	853e                	mv	a0,a5
    800064ba:	d29fb0ef          	jal	800021e2 <copyout>
    800064be:	87aa                	mv	a5,a0
    800064c0:	0007d463          	bgez	a5,800064c8 <filestat+0x7c>
      return -1;
    800064c4:	57fd                	li	a5,-1
    800064c6:	a021                	j	800064ce <filestat+0x82>
    return 0;
    800064c8:	4781                	li	a5,0
    800064ca:	a011                	j	800064ce <filestat+0x82>
  }
  return -1;
    800064cc:	57fd                	li	a5,-1
}
    800064ce:	853e                	mv	a0,a5
    800064d0:	70e2                	ld	ra,56(sp)
    800064d2:	7442                	ld	s0,48(sp)
    800064d4:	6121                	addi	sp,sp,64
    800064d6:	8082                	ret

00000000800064d8 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800064d8:	7139                	addi	sp,sp,-64
    800064da:	fc06                	sd	ra,56(sp)
    800064dc:	f822                	sd	s0,48(sp)
    800064de:	0080                	addi	s0,sp,64
    800064e0:	fca43c23          	sd	a0,-40(s0)
    800064e4:	fcb43823          	sd	a1,-48(s0)
    800064e8:	87b2                	mv	a5,a2
    800064ea:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    800064ee:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    800064f2:	fd843783          	ld	a5,-40(s0)
    800064f6:	0087c783          	lbu	a5,8(a5)
    800064fa:	e399                	bnez	a5,80006500 <fileread+0x28>
    return -1;
    800064fc:	57fd                	li	a5,-1
    800064fe:	aa09                	j	80006610 <fileread+0x138>

  if(f->type == FD_PIPE){
    80006500:	fd843783          	ld	a5,-40(s0)
    80006504:	4398                	lw	a4,0(a5)
    80006506:	4785                	li	a5,1
    80006508:	02f71163          	bne	a4,a5,8000652a <fileread+0x52>
    r = piperead(f->pipe, addr, n);
    8000650c:	fd843783          	ld	a5,-40(s0)
    80006510:	6b9c                	ld	a5,16(a5)
    80006512:	fcc42703          	lw	a4,-52(s0)
    80006516:	863a                	mv	a2,a4
    80006518:	fd043583          	ld	a1,-48(s0)
    8000651c:	853e                	mv	a0,a5
    8000651e:	5d6000ef          	jal	80006af4 <piperead>
    80006522:	87aa                	mv	a5,a0
    80006524:	fef42623          	sw	a5,-20(s0)
    80006528:	a0d5                	j	8000660c <fileread+0x134>
  } else if(f->type == FD_DEVICE){
    8000652a:	fd843783          	ld	a5,-40(s0)
    8000652e:	4398                	lw	a4,0(a5)
    80006530:	478d                	li	a5,3
    80006532:	06f71363          	bne	a4,a5,80006598 <fileread+0xc0>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80006536:	fd843783          	ld	a5,-40(s0)
    8000653a:	02479783          	lh	a5,36(a5)
    8000653e:	0207c563          	bltz	a5,80006568 <fileread+0x90>
    80006542:	fd843783          	ld	a5,-40(s0)
    80006546:	02479703          	lh	a4,36(a5)
    8000654a:	47a5                	li	a5,9
    8000654c:	00e7ce63          	blt	a5,a4,80006568 <fileread+0x90>
    80006550:	fd843783          	ld	a5,-40(s0)
    80006554:	02479783          	lh	a5,36(a5)
    80006558:	0001c717          	auipc	a4,0x1c
    8000655c:	4c870713          	addi	a4,a4,1224 # 80022a20 <devsw>
    80006560:	0792                	slli	a5,a5,0x4
    80006562:	97ba                	add	a5,a5,a4
    80006564:	639c                	ld	a5,0(a5)
    80006566:	e399                	bnez	a5,8000656c <fileread+0x94>
      return -1;
    80006568:	57fd                	li	a5,-1
    8000656a:	a05d                	j	80006610 <fileread+0x138>
    r = devsw[f->major].read(1, addr, n);
    8000656c:	fd843783          	ld	a5,-40(s0)
    80006570:	02479783          	lh	a5,36(a5)
    80006574:	0001c717          	auipc	a4,0x1c
    80006578:	4ac70713          	addi	a4,a4,1196 # 80022a20 <devsw>
    8000657c:	0792                	slli	a5,a5,0x4
    8000657e:	97ba                	add	a5,a5,a4
    80006580:	639c                	ld	a5,0(a5)
    80006582:	fcc42703          	lw	a4,-52(s0)
    80006586:	863a                	mv	a2,a4
    80006588:	fd043583          	ld	a1,-48(s0)
    8000658c:	4505                	li	a0,1
    8000658e:	9782                	jalr	a5
    80006590:	87aa                	mv	a5,a0
    80006592:	fef42623          	sw	a5,-20(s0)
    80006596:	a89d                	j	8000660c <fileread+0x134>
  } else if(f->type == FD_INODE){
    80006598:	fd843783          	ld	a5,-40(s0)
    8000659c:	4398                	lw	a4,0(a5)
    8000659e:	4789                	li	a5,2
    800065a0:	06f71063          	bne	a4,a5,80006600 <fileread+0x128>
    ilock(f->ip);
    800065a4:	fd843783          	ld	a5,-40(s0)
    800065a8:	6f9c                	ld	a5,24(a5)
    800065aa:	853e                	mv	a0,a5
    800065ac:	feefe0ef          	jal	80004d9a <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800065b0:	fd843783          	ld	a5,-40(s0)
    800065b4:	6f88                	ld	a0,24(a5)
    800065b6:	fd843783          	ld	a5,-40(s0)
    800065ba:	539c                	lw	a5,32(a5)
    800065bc:	fcc42703          	lw	a4,-52(s0)
    800065c0:	86be                	mv	a3,a5
    800065c2:	fd043603          	ld	a2,-48(s0)
    800065c6:	4585                	li	a1,1
    800065c8:	de9fe0ef          	jal	800053b0 <readi>
    800065cc:	87aa                	mv	a5,a0
    800065ce:	fef42623          	sw	a5,-20(s0)
    800065d2:	fec42783          	lw	a5,-20(s0)
    800065d6:	2781                	sext.w	a5,a5
    800065d8:	00f05d63          	blez	a5,800065f2 <fileread+0x11a>
      f->off += r;
    800065dc:	fd843783          	ld	a5,-40(s0)
    800065e0:	5398                	lw	a4,32(a5)
    800065e2:	fec42783          	lw	a5,-20(s0)
    800065e6:	9fb9                	addw	a5,a5,a4
    800065e8:	0007871b          	sext.w	a4,a5
    800065ec:	fd843783          	ld	a5,-40(s0)
    800065f0:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    800065f2:	fd843783          	ld	a5,-40(s0)
    800065f6:	6f9c                	ld	a5,24(a5)
    800065f8:	853e                	mv	a0,a5
    800065fa:	8bdfe0ef          	jal	80004eb6 <iunlock>
    800065fe:	a039                	j	8000660c <fileread+0x134>
  } else {
    panic("fileread");
    80006600:	00004517          	auipc	a0,0x4
    80006604:	fd850513          	addi	a0,a0,-40 # 8000a5d8 <etext+0x5d8>
    80006608:	82ffa0ef          	jal	80000e36 <panic>
  }

  return r;
    8000660c:	fec42783          	lw	a5,-20(s0)
}
    80006610:	853e                	mv	a0,a5
    80006612:	70e2                	ld	ra,56(sp)
    80006614:	7442                	ld	s0,48(sp)
    80006616:	6121                	addi	sp,sp,64
    80006618:	8082                	ret

000000008000661a <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    8000661a:	715d                	addi	sp,sp,-80
    8000661c:	e486                	sd	ra,72(sp)
    8000661e:	e0a2                	sd	s0,64(sp)
    80006620:	0880                	addi	s0,sp,80
    80006622:	fca43423          	sd	a0,-56(s0)
    80006626:	fcb43023          	sd	a1,-64(s0)
    8000662a:	87b2                	mv	a5,a2
    8000662c:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80006630:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80006634:	fc843783          	ld	a5,-56(s0)
    80006638:	0097c783          	lbu	a5,9(a5)
    8000663c:	e399                	bnez	a5,80006642 <filewrite+0x28>
    return -1;
    8000663e:	57fd                	li	a5,-1
    80006640:	aa55                	j	800067f4 <filewrite+0x1da>

  if(f->type == FD_PIPE){
    80006642:	fc843783          	ld	a5,-56(s0)
    80006646:	4398                	lw	a4,0(a5)
    80006648:	4785                	li	a5,1
    8000664a:	02f71163          	bne	a4,a5,8000666c <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
    8000664e:	fc843783          	ld	a5,-56(s0)
    80006652:	6b9c                	ld	a5,16(a5)
    80006654:	fbc42703          	lw	a4,-68(s0)
    80006658:	863a                	mv	a2,a4
    8000665a:	fc043583          	ld	a1,-64(s0)
    8000665e:	853e                	mv	a0,a5
    80006660:	366000ef          	jal	800069c6 <pipewrite>
    80006664:	87aa                	mv	a5,a0
    80006666:	fef42623          	sw	a5,-20(s0)
    8000666a:	a259                	j	800067f0 <filewrite+0x1d6>
  } else if(f->type == FD_DEVICE){
    8000666c:	fc843783          	ld	a5,-56(s0)
    80006670:	4398                	lw	a4,0(a5)
    80006672:	478d                	li	a5,3
    80006674:	06f71363          	bne	a4,a5,800066da <filewrite+0xc0>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006678:	fc843783          	ld	a5,-56(s0)
    8000667c:	02479783          	lh	a5,36(a5)
    80006680:	0207c563          	bltz	a5,800066aa <filewrite+0x90>
    80006684:	fc843783          	ld	a5,-56(s0)
    80006688:	02479703          	lh	a4,36(a5)
    8000668c:	47a5                	li	a5,9
    8000668e:	00e7ce63          	blt	a5,a4,800066aa <filewrite+0x90>
    80006692:	fc843783          	ld	a5,-56(s0)
    80006696:	02479783          	lh	a5,36(a5)
    8000669a:	0001c717          	auipc	a4,0x1c
    8000669e:	38670713          	addi	a4,a4,902 # 80022a20 <devsw>
    800066a2:	0792                	slli	a5,a5,0x4
    800066a4:	97ba                	add	a5,a5,a4
    800066a6:	679c                	ld	a5,8(a5)
    800066a8:	e399                	bnez	a5,800066ae <filewrite+0x94>
      return -1;
    800066aa:	57fd                	li	a5,-1
    800066ac:	a2a1                	j	800067f4 <filewrite+0x1da>
    ret = devsw[f->major].write(1, addr, n);
    800066ae:	fc843783          	ld	a5,-56(s0)
    800066b2:	02479783          	lh	a5,36(a5)
    800066b6:	0001c717          	auipc	a4,0x1c
    800066ba:	36a70713          	addi	a4,a4,874 # 80022a20 <devsw>
    800066be:	0792                	slli	a5,a5,0x4
    800066c0:	97ba                	add	a5,a5,a4
    800066c2:	679c                	ld	a5,8(a5)
    800066c4:	fbc42703          	lw	a4,-68(s0)
    800066c8:	863a                	mv	a2,a4
    800066ca:	fc043583          	ld	a1,-64(s0)
    800066ce:	4505                	li	a0,1
    800066d0:	9782                	jalr	a5
    800066d2:	87aa                	mv	a5,a0
    800066d4:	fef42623          	sw	a5,-20(s0)
    800066d8:	aa21                	j	800067f0 <filewrite+0x1d6>
  } else if(f->type == FD_INODE){
    800066da:	fc843783          	ld	a5,-56(s0)
    800066de:	4398                	lw	a4,0(a5)
    800066e0:	4789                	li	a5,2
    800066e2:	10f71163          	bne	a4,a5,800067e4 <filewrite+0x1ca>
    // write a few blocks at a time to avoid exceeding
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    800066e6:	6785                	lui	a5,0x1
    800066e8:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800066ec:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    800066f0:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    800066f4:	a86d                	j	800067ae <filewrite+0x194>
      int n1 = n - i;
    800066f6:	fbc42783          	lw	a5,-68(s0)
    800066fa:	873e                	mv	a4,a5
    800066fc:	fe842783          	lw	a5,-24(s0)
    80006700:	40f707bb          	subw	a5,a4,a5
    80006704:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80006708:	fe442783          	lw	a5,-28(s0)
    8000670c:	873e                	mv	a4,a5
    8000670e:	fe042783          	lw	a5,-32(s0)
    80006712:	2701                	sext.w	a4,a4
    80006714:	2781                	sext.w	a5,a5
    80006716:	00e7d663          	bge	a5,a4,80006722 <filewrite+0x108>
        n1 = max;
    8000671a:	fe042783          	lw	a5,-32(s0)
    8000671e:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80006722:	e8eff0ef          	jal	80005db0 <begin_op>
      ilock(f->ip);
    80006726:	fc843783          	ld	a5,-56(s0)
    8000672a:	6f9c                	ld	a5,24(a5)
    8000672c:	853e                	mv	a0,a5
    8000672e:	e6cfe0ef          	jal	80004d9a <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80006732:	fc843783          	ld	a5,-56(s0)
    80006736:	6f88                	ld	a0,24(a5)
    80006738:	fe842703          	lw	a4,-24(s0)
    8000673c:	fc043783          	ld	a5,-64(s0)
    80006740:	00f70633          	add	a2,a4,a5
    80006744:	fc843783          	ld	a5,-56(s0)
    80006748:	539c                	lw	a5,32(a5)
    8000674a:	fe442703          	lw	a4,-28(s0)
    8000674e:	86be                	mv	a3,a5
    80006750:	4585                	li	a1,1
    80006752:	de7fe0ef          	jal	80005538 <writei>
    80006756:	87aa                	mv	a5,a0
    80006758:	fcf42e23          	sw	a5,-36(s0)
    8000675c:	fdc42783          	lw	a5,-36(s0)
    80006760:	2781                	sext.w	a5,a5
    80006762:	00f05d63          	blez	a5,8000677c <filewrite+0x162>
        f->off += r;
    80006766:	fc843783          	ld	a5,-56(s0)
    8000676a:	5398                	lw	a4,32(a5)
    8000676c:	fdc42783          	lw	a5,-36(s0)
    80006770:	9fb9                	addw	a5,a5,a4
    80006772:	0007871b          	sext.w	a4,a5
    80006776:	fc843783          	ld	a5,-56(s0)
    8000677a:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    8000677c:	fc843783          	ld	a5,-56(s0)
    80006780:	6f9c                	ld	a5,24(a5)
    80006782:	853e                	mv	a0,a5
    80006784:	f32fe0ef          	jal	80004eb6 <iunlock>
      end_op();
    80006788:	edaff0ef          	jal	80005e62 <end_op>

      if(r != n1){
    8000678c:	fdc42783          	lw	a5,-36(s0)
    80006790:	873e                	mv	a4,a5
    80006792:	fe442783          	lw	a5,-28(s0)
    80006796:	2701                	sext.w	a4,a4
    80006798:	2781                	sext.w	a5,a5
    8000679a:	02f71463          	bne	a4,a5,800067c2 <filewrite+0x1a8>
        // error from writei
        break;
      }
      i += r;
    8000679e:	fe842783          	lw	a5,-24(s0)
    800067a2:	873e                	mv	a4,a5
    800067a4:	fdc42783          	lw	a5,-36(s0)
    800067a8:	9fb9                	addw	a5,a5,a4
    800067aa:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    800067ae:	fe842783          	lw	a5,-24(s0)
    800067b2:	873e                	mv	a4,a5
    800067b4:	fbc42783          	lw	a5,-68(s0)
    800067b8:	2701                	sext.w	a4,a4
    800067ba:	2781                	sext.w	a5,a5
    800067bc:	f2f74de3          	blt	a4,a5,800066f6 <filewrite+0xdc>
    800067c0:	a011                	j	800067c4 <filewrite+0x1aa>
        break;
    800067c2:	0001                	nop
    }
    ret = (i == n ? n : -1);
    800067c4:	fe842783          	lw	a5,-24(s0)
    800067c8:	873e                	mv	a4,a5
    800067ca:	fbc42783          	lw	a5,-68(s0)
    800067ce:	2701                	sext.w	a4,a4
    800067d0:	2781                	sext.w	a5,a5
    800067d2:	00f71563          	bne	a4,a5,800067dc <filewrite+0x1c2>
    800067d6:	fbc42783          	lw	a5,-68(s0)
    800067da:	a011                	j	800067de <filewrite+0x1c4>
    800067dc:	57fd                	li	a5,-1
    800067de:	fef42623          	sw	a5,-20(s0)
    800067e2:	a039                	j	800067f0 <filewrite+0x1d6>
  } else {
    panic("filewrite");
    800067e4:	00004517          	auipc	a0,0x4
    800067e8:	e0450513          	addi	a0,a0,-508 # 8000a5e8 <etext+0x5e8>
    800067ec:	e4afa0ef          	jal	80000e36 <panic>
  }

  return ret;
    800067f0:	fec42783          	lw	a5,-20(s0)
}
    800067f4:	853e                	mv	a0,a5
    800067f6:	60a6                	ld	ra,72(sp)
    800067f8:	6406                	ld	s0,64(sp)
    800067fa:	6161                	addi	sp,sp,80
    800067fc:	8082                	ret

00000000800067fe <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800067fe:	7179                	addi	sp,sp,-48
    80006800:	f406                	sd	ra,40(sp)
    80006802:	f022                	sd	s0,32(sp)
    80006804:	1800                	addi	s0,sp,48
    80006806:	fca43c23          	sd	a0,-40(s0)
    8000680a:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    8000680e:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80006812:	fd043783          	ld	a5,-48(s0)
    80006816:	0007b023          	sd	zero,0(a5)
    8000681a:	fd043783          	ld	a5,-48(s0)
    8000681e:	6398                	ld	a4,0(a5)
    80006820:	fd843783          	ld	a5,-40(s0)
    80006824:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80006826:	a73ff0ef          	jal	80006298 <filealloc>
    8000682a:	872a                	mv	a4,a0
    8000682c:	fd843783          	ld	a5,-40(s0)
    80006830:	e398                	sd	a4,0(a5)
    80006832:	fd843783          	ld	a5,-40(s0)
    80006836:	639c                	ld	a5,0(a5)
    80006838:	cbdd                	beqz	a5,800068ee <pipealloc+0xf0>
    8000683a:	a5fff0ef          	jal	80006298 <filealloc>
    8000683e:	872a                	mv	a4,a0
    80006840:	fd043783          	ld	a5,-48(s0)
    80006844:	e398                	sd	a4,0(a5)
    80006846:	fd043783          	ld	a5,-48(s0)
    8000684a:	639c                	ld	a5,0(a5)
    8000684c:	c3cd                	beqz	a5,800068ee <pipealloc+0xf0>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    8000684e:	9bdfa0ef          	jal	8000120a <kalloc>
    80006852:	fea43423          	sd	a0,-24(s0)
    80006856:	fe843783          	ld	a5,-24(s0)
    8000685a:	cfc1                	beqz	a5,800068f2 <pipealloc+0xf4>
    goto bad;
  pi->readopen = 1;
    8000685c:	fe843783          	ld	a5,-24(s0)
    80006860:	4705                	li	a4,1
    80006862:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80006866:	fe843783          	ld	a5,-24(s0)
    8000686a:	4705                	li	a4,1
    8000686c:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    80006870:	fe843783          	ld	a5,-24(s0)
    80006874:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    80006878:	fe843783          	ld	a5,-24(s0)
    8000687c:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    80006880:	fe843783          	ld	a5,-24(s0)
    80006884:	00004597          	auipc	a1,0x4
    80006888:	d7458593          	addi	a1,a1,-652 # 8000a5f8 <etext+0x5f8>
    8000688c:	853e                	mv	a0,a5
    8000688e:	a89fa0ef          	jal	80001316 <initlock>
  (*f0)->type = FD_PIPE;
    80006892:	fd843783          	ld	a5,-40(s0)
    80006896:	639c                	ld	a5,0(a5)
    80006898:	4705                	li	a4,1
    8000689a:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    8000689c:	fd843783          	ld	a5,-40(s0)
    800068a0:	639c                	ld	a5,0(a5)
    800068a2:	4705                	li	a4,1
    800068a4:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    800068a8:	fd843783          	ld	a5,-40(s0)
    800068ac:	639c                	ld	a5,0(a5)
    800068ae:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800068b2:	fd843783          	ld	a5,-40(s0)
    800068b6:	639c                	ld	a5,0(a5)
    800068b8:	fe843703          	ld	a4,-24(s0)
    800068bc:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    800068be:	fd043783          	ld	a5,-48(s0)
    800068c2:	639c                	ld	a5,0(a5)
    800068c4:	4705                	li	a4,1
    800068c6:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    800068c8:	fd043783          	ld	a5,-48(s0)
    800068cc:	639c                	ld	a5,0(a5)
    800068ce:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800068d2:	fd043783          	ld	a5,-48(s0)
    800068d6:	639c                	ld	a5,0(a5)
    800068d8:	4705                	li	a4,1
    800068da:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    800068de:	fd043783          	ld	a5,-48(s0)
    800068e2:	639c                	ld	a5,0(a5)
    800068e4:	fe843703          	ld	a4,-24(s0)
    800068e8:	eb98                	sd	a4,16(a5)
  return 0;
    800068ea:	4781                	li	a5,0
    800068ec:	a081                	j	8000692c <pipealloc+0x12e>
    goto bad;
    800068ee:	0001                	nop
    800068f0:	a011                	j	800068f4 <pipealloc+0xf6>
    goto bad;
    800068f2:	0001                	nop

 bad:
  if(pi)
    800068f4:	fe843783          	ld	a5,-24(s0)
    800068f8:	c789                	beqz	a5,80006902 <pipealloc+0x104>
    kfree((char*)pi);
    800068fa:	fe843503          	ld	a0,-24(s0)
    800068fe:	879fa0ef          	jal	80001176 <kfree>
  if(*f0)
    80006902:	fd843783          	ld	a5,-40(s0)
    80006906:	639c                	ld	a5,0(a5)
    80006908:	c799                	beqz	a5,80006916 <pipealloc+0x118>
    fileclose(*f0);
    8000690a:	fd843783          	ld	a5,-40(s0)
    8000690e:	639c                	ld	a5,0(a5)
    80006910:	853e                	mv	a0,a5
    80006912:	a59ff0ef          	jal	8000636a <fileclose>
  if(*f1)
    80006916:	fd043783          	ld	a5,-48(s0)
    8000691a:	639c                	ld	a5,0(a5)
    8000691c:	c799                	beqz	a5,8000692a <pipealloc+0x12c>
    fileclose(*f1);
    8000691e:	fd043783          	ld	a5,-48(s0)
    80006922:	639c                	ld	a5,0(a5)
    80006924:	853e                	mv	a0,a5
    80006926:	a45ff0ef          	jal	8000636a <fileclose>
  return -1;
    8000692a:	57fd                	li	a5,-1
}
    8000692c:	853e                	mv	a0,a5
    8000692e:	70a2                	ld	ra,40(sp)
    80006930:	7402                	ld	s0,32(sp)
    80006932:	6145                	addi	sp,sp,48
    80006934:	8082                	ret

0000000080006936 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80006936:	1101                	addi	sp,sp,-32
    80006938:	ec06                	sd	ra,24(sp)
    8000693a:	e822                	sd	s0,16(sp)
    8000693c:	1000                	addi	s0,sp,32
    8000693e:	fea43423          	sd	a0,-24(s0)
    80006942:	87ae                	mv	a5,a1
    80006944:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80006948:	fe843783          	ld	a5,-24(s0)
    8000694c:	853e                	mv	a0,a5
    8000694e:	9fdfa0ef          	jal	8000134a <acquire>
  if(writable){
    80006952:	fe442783          	lw	a5,-28(s0)
    80006956:	2781                	sext.w	a5,a5
    80006958:	cf89                	beqz	a5,80006972 <pipeclose+0x3c>
    pi->writeopen = 0;
    8000695a:	fe843783          	ld	a5,-24(s0)
    8000695e:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80006962:	fe843783          	ld	a5,-24(s0)
    80006966:	21878793          	addi	a5,a5,536
    8000696a:	853e                	mv	a0,a5
    8000696c:	9effc0ef          	jal	8000335a <wakeup>
    80006970:	a821                	j	80006988 <pipeclose+0x52>
  } else {
    pi->readopen = 0;
    80006972:	fe843783          	ld	a5,-24(s0)
    80006976:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    8000697a:	fe843783          	ld	a5,-24(s0)
    8000697e:	21c78793          	addi	a5,a5,540
    80006982:	853e                	mv	a0,a5
    80006984:	9d7fc0ef          	jal	8000335a <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80006988:	fe843783          	ld	a5,-24(s0)
    8000698c:	2207a783          	lw	a5,544(a5)
    80006990:	e385                	bnez	a5,800069b0 <pipeclose+0x7a>
    80006992:	fe843783          	ld	a5,-24(s0)
    80006996:	2247a783          	lw	a5,548(a5)
    8000699a:	eb99                	bnez	a5,800069b0 <pipeclose+0x7a>
    release(&pi->lock);
    8000699c:	fe843783          	ld	a5,-24(s0)
    800069a0:	853e                	mv	a0,a5
    800069a2:	9fdfa0ef          	jal	8000139e <release>
    kfree((char*)pi);
    800069a6:	fe843503          	ld	a0,-24(s0)
    800069aa:	fccfa0ef          	jal	80001176 <kfree>
    800069ae:	a039                	j	800069bc <pipeclose+0x86>
  } else
    release(&pi->lock);
    800069b0:	fe843783          	ld	a5,-24(s0)
    800069b4:	853e                	mv	a0,a5
    800069b6:	9e9fa0ef          	jal	8000139e <release>
}
    800069ba:	0001                	nop
    800069bc:	0001                	nop
    800069be:	60e2                	ld	ra,24(sp)
    800069c0:	6442                	ld	s0,16(sp)
    800069c2:	6105                	addi	sp,sp,32
    800069c4:	8082                	ret

00000000800069c6 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800069c6:	715d                	addi	sp,sp,-80
    800069c8:	e486                	sd	ra,72(sp)
    800069ca:	e0a2                	sd	s0,64(sp)
    800069cc:	0880                	addi	s0,sp,80
    800069ce:	fca43423          	sd	a0,-56(s0)
    800069d2:	fcb43023          	sd	a1,-64(s0)
    800069d6:	87b2                	mv	a5,a2
    800069d8:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    800069dc:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    800069e0:	e75fb0ef          	jal	80002854 <myproc>
    800069e4:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    800069e8:	fc843783          	ld	a5,-56(s0)
    800069ec:	853e                	mv	a0,a5
    800069ee:	95dfa0ef          	jal	8000134a <acquire>
  while(i < n){
    800069f2:	a0d9                	j	80006ab8 <pipewrite+0xf2>
    if(pi->readopen == 0 || killed(pr)){
    800069f4:	fc843783          	ld	a5,-56(s0)
    800069f8:	2207a783          	lw	a5,544(a5)
    800069fc:	c799                	beqz	a5,80006a0a <pipewrite+0x44>
    800069fe:	fe043503          	ld	a0,-32(s0)
    80006a02:	aa3fc0ef          	jal	800034a4 <killed>
    80006a06:	87aa                	mv	a5,a0
    80006a08:	cb81                	beqz	a5,80006a18 <pipewrite+0x52>
      release(&pi->lock);
    80006a0a:	fc843783          	ld	a5,-56(s0)
    80006a0e:	853e                	mv	a0,a5
    80006a10:	98ffa0ef          	jal	8000139e <release>
      return -1;
    80006a14:	57fd                	li	a5,-1
    80006a16:	a8d1                	j	80006aea <pipewrite+0x124>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80006a18:	fc843783          	ld	a5,-56(s0)
    80006a1c:	21c7a703          	lw	a4,540(a5)
    80006a20:	fc843783          	ld	a5,-56(s0)
    80006a24:	2187a783          	lw	a5,536(a5)
    80006a28:	2007879b          	addiw	a5,a5,512
    80006a2c:	2781                	sext.w	a5,a5
    80006a2e:	02f71463          	bne	a4,a5,80006a56 <pipewrite+0x90>
      wakeup(&pi->nread);
    80006a32:	fc843783          	ld	a5,-56(s0)
    80006a36:	21878793          	addi	a5,a5,536
    80006a3a:	853e                	mv	a0,a5
    80006a3c:	91ffc0ef          	jal	8000335a <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80006a40:	fc843783          	ld	a5,-56(s0)
    80006a44:	21c78793          	addi	a5,a5,540
    80006a48:	fc843703          	ld	a4,-56(s0)
    80006a4c:	85ba                	mv	a1,a4
    80006a4e:	853e                	mv	a0,a5
    80006a50:	8a7fc0ef          	jal	800032f6 <sleep>
    80006a54:	a095                	j	80006ab8 <pipewrite+0xf2>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80006a56:	fe043783          	ld	a5,-32(s0)
    80006a5a:	6ba8                	ld	a0,80(a5)
    80006a5c:	fec42703          	lw	a4,-20(s0)
    80006a60:	fc043783          	ld	a5,-64(s0)
    80006a64:	973e                	add	a4,a4,a5
    80006a66:	fdf40793          	addi	a5,s0,-33
    80006a6a:	4685                	li	a3,1
    80006a6c:	863a                	mv	a2,a4
    80006a6e:	85be                	mv	a1,a5
    80006a70:	881fb0ef          	jal	800022f0 <copyin>
    80006a74:	87aa                	mv	a5,a0
    80006a76:	873e                	mv	a4,a5
    80006a78:	57fd                	li	a5,-1
    80006a7a:	04f70963          	beq	a4,a5,80006acc <pipewrite+0x106>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80006a7e:	fc843783          	ld	a5,-56(s0)
    80006a82:	21c7a783          	lw	a5,540(a5)
    80006a86:	0017871b          	addiw	a4,a5,1
    80006a8a:	0007069b          	sext.w	a3,a4
    80006a8e:	fc843703          	ld	a4,-56(s0)
    80006a92:	20d72e23          	sw	a3,540(a4)
    80006a96:	1ff7f793          	andi	a5,a5,511
    80006a9a:	2781                	sext.w	a5,a5
    80006a9c:	fdf44703          	lbu	a4,-33(s0)
    80006aa0:	fc843683          	ld	a3,-56(s0)
    80006aa4:	1782                	slli	a5,a5,0x20
    80006aa6:	9381                	srli	a5,a5,0x20
    80006aa8:	97b6                	add	a5,a5,a3
    80006aaa:	00e78c23          	sb	a4,24(a5)
      i++;
    80006aae:	fec42783          	lw	a5,-20(s0)
    80006ab2:	2785                	addiw	a5,a5,1
    80006ab4:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80006ab8:	fec42783          	lw	a5,-20(s0)
    80006abc:	873e                	mv	a4,a5
    80006abe:	fbc42783          	lw	a5,-68(s0)
    80006ac2:	2701                	sext.w	a4,a4
    80006ac4:	2781                	sext.w	a5,a5
    80006ac6:	f2f747e3          	blt	a4,a5,800069f4 <pipewrite+0x2e>
    80006aca:	a011                	j	80006ace <pipewrite+0x108>
        break;
    80006acc:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80006ace:	fc843783          	ld	a5,-56(s0)
    80006ad2:	21878793          	addi	a5,a5,536
    80006ad6:	853e                	mv	a0,a5
    80006ad8:	883fc0ef          	jal	8000335a <wakeup>
  release(&pi->lock);
    80006adc:	fc843783          	ld	a5,-56(s0)
    80006ae0:	853e                	mv	a0,a5
    80006ae2:	8bdfa0ef          	jal	8000139e <release>

  return i;
    80006ae6:	fec42783          	lw	a5,-20(s0)
}
    80006aea:	853e                	mv	a0,a5
    80006aec:	60a6                	ld	ra,72(sp)
    80006aee:	6406                	ld	s0,64(sp)
    80006af0:	6161                	addi	sp,sp,80
    80006af2:	8082                	ret

0000000080006af4 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80006af4:	715d                	addi	sp,sp,-80
    80006af6:	e486                	sd	ra,72(sp)
    80006af8:	e0a2                	sd	s0,64(sp)
    80006afa:	0880                	addi	s0,sp,80
    80006afc:	fca43423          	sd	a0,-56(s0)
    80006b00:	fcb43023          	sd	a1,-64(s0)
    80006b04:	87b2                	mv	a5,a2
    80006b06:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80006b0a:	d4bfb0ef          	jal	80002854 <myproc>
    80006b0e:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80006b12:	fc843783          	ld	a5,-56(s0)
    80006b16:	853e                	mv	a0,a5
    80006b18:	833fa0ef          	jal	8000134a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80006b1c:	a805                	j	80006b4c <piperead+0x58>
    if(killed(pr)){
    80006b1e:	fe043503          	ld	a0,-32(s0)
    80006b22:	983fc0ef          	jal	800034a4 <killed>
    80006b26:	87aa                	mv	a5,a0
    80006b28:	cb81                	beqz	a5,80006b38 <piperead+0x44>
      release(&pi->lock);
    80006b2a:	fc843783          	ld	a5,-56(s0)
    80006b2e:	853e                	mv	a0,a5
    80006b30:	86ffa0ef          	jal	8000139e <release>
      return -1;
    80006b34:	57fd                	li	a5,-1
    80006b36:	a8f5                	j	80006c32 <piperead+0x13e>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80006b38:	fc843783          	ld	a5,-56(s0)
    80006b3c:	21878793          	addi	a5,a5,536
    80006b40:	fc843703          	ld	a4,-56(s0)
    80006b44:	85ba                	mv	a1,a4
    80006b46:	853e                	mv	a0,a5
    80006b48:	faefc0ef          	jal	800032f6 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80006b4c:	fc843783          	ld	a5,-56(s0)
    80006b50:	2187a703          	lw	a4,536(a5)
    80006b54:	fc843783          	ld	a5,-56(s0)
    80006b58:	21c7a783          	lw	a5,540(a5)
    80006b5c:	00f71763          	bne	a4,a5,80006b6a <piperead+0x76>
    80006b60:	fc843783          	ld	a5,-56(s0)
    80006b64:	2247a783          	lw	a5,548(a5)
    80006b68:	fbdd                	bnez	a5,80006b1e <piperead+0x2a>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80006b6a:	fe042623          	sw	zero,-20(s0)
    80006b6e:	a079                	j	80006bfc <piperead+0x108>
    if(pi->nread == pi->nwrite)
    80006b70:	fc843783          	ld	a5,-56(s0)
    80006b74:	2187a703          	lw	a4,536(a5)
    80006b78:	fc843783          	ld	a5,-56(s0)
    80006b7c:	21c7a783          	lw	a5,540(a5)
    80006b80:	08f70863          	beq	a4,a5,80006c10 <piperead+0x11c>
      break;
    ch = pi->data[pi->nread % PIPESIZE];
    80006b84:	fc843783          	ld	a5,-56(s0)
    80006b88:	2187a783          	lw	a5,536(a5)
    80006b8c:	1ff7f793          	andi	a5,a5,511
    80006b90:	2781                	sext.w	a5,a5
    80006b92:	fc843703          	ld	a4,-56(s0)
    80006b96:	1782                	slli	a5,a5,0x20
    80006b98:	9381                	srli	a5,a5,0x20
    80006b9a:	97ba                	add	a5,a5,a4
    80006b9c:	0187c783          	lbu	a5,24(a5)
    80006ba0:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1) {
    80006ba4:	fe043783          	ld	a5,-32(s0)
    80006ba8:	6ba8                	ld	a0,80(a5)
    80006baa:	fec42703          	lw	a4,-20(s0)
    80006bae:	fc043783          	ld	a5,-64(s0)
    80006bb2:	97ba                	add	a5,a5,a4
    80006bb4:	fdf40713          	addi	a4,s0,-33
    80006bb8:	4685                	li	a3,1
    80006bba:	863a                	mv	a2,a4
    80006bbc:	85be                	mv	a1,a5
    80006bbe:	e24fb0ef          	jal	800021e2 <copyout>
    80006bc2:	87aa                	mv	a5,a0
    80006bc4:	873e                	mv	a4,a5
    80006bc6:	57fd                	li	a5,-1
    80006bc8:	00f71a63          	bne	a4,a5,80006bdc <piperead+0xe8>
      if(i == 0)
    80006bcc:	fec42783          	lw	a5,-20(s0)
    80006bd0:	2781                	sext.w	a5,a5
    80006bd2:	e3a9                	bnez	a5,80006c14 <piperead+0x120>
        i = -1;
    80006bd4:	57fd                	li	a5,-1
    80006bd6:	fef42623          	sw	a5,-20(s0)
      break;
    80006bda:	a82d                	j	80006c14 <piperead+0x120>
    }
    pi->nread++;
    80006bdc:	fc843783          	ld	a5,-56(s0)
    80006be0:	2187a783          	lw	a5,536(a5)
    80006be4:	2785                	addiw	a5,a5,1
    80006be6:	0007871b          	sext.w	a4,a5
    80006bea:	fc843783          	ld	a5,-56(s0)
    80006bee:	20e7ac23          	sw	a4,536(a5)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80006bf2:	fec42783          	lw	a5,-20(s0)
    80006bf6:	2785                	addiw	a5,a5,1
    80006bf8:	fef42623          	sw	a5,-20(s0)
    80006bfc:	fec42783          	lw	a5,-20(s0)
    80006c00:	873e                	mv	a4,a5
    80006c02:	fbc42783          	lw	a5,-68(s0)
    80006c06:	2701                	sext.w	a4,a4
    80006c08:	2781                	sext.w	a5,a5
    80006c0a:	f6f743e3          	blt	a4,a5,80006b70 <piperead+0x7c>
    80006c0e:	a021                	j	80006c16 <piperead+0x122>
      break;
    80006c10:	0001                	nop
    80006c12:	a011                	j	80006c16 <piperead+0x122>
      break;
    80006c14:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80006c16:	fc843783          	ld	a5,-56(s0)
    80006c1a:	21c78793          	addi	a5,a5,540
    80006c1e:	853e                	mv	a0,a5
    80006c20:	f3afc0ef          	jal	8000335a <wakeup>
  release(&pi->lock);
    80006c24:	fc843783          	ld	a5,-56(s0)
    80006c28:	853e                	mv	a0,a5
    80006c2a:	f74fa0ef          	jal	8000139e <release>
  return i;
    80006c2e:	fec42783          	lw	a5,-20(s0)
}
    80006c32:	853e                	mv	a0,a5
    80006c34:	60a6                	ld	ra,72(sp)
    80006c36:	6406                	ld	s0,64(sp)
    80006c38:	6161                	addi	sp,sp,80
    80006c3a:	8082                	ret

0000000080006c3c <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80006c3c:	7179                	addi	sp,sp,-48
    80006c3e:	f406                	sd	ra,40(sp)
    80006c40:	f022                	sd	s0,32(sp)
    80006c42:	1800                	addi	s0,sp,48
    80006c44:	87aa                	mv	a5,a0
    80006c46:	fcf42e23          	sw	a5,-36(s0)
    int perm = 0;
    80006c4a:	fe042623          	sw	zero,-20(s0)
    if(flags & 0x1)
    80006c4e:	fdc42783          	lw	a5,-36(s0)
    80006c52:	8b85                	andi	a5,a5,1
    80006c54:	2781                	sext.w	a5,a5
    80006c56:	c781                	beqz	a5,80006c5e <flags2perm+0x22>
      perm = PTE_X;
    80006c58:	47a1                	li	a5,8
    80006c5a:	fef42623          	sw	a5,-20(s0)
    if(flags & 0x2)
    80006c5e:	fdc42783          	lw	a5,-36(s0)
    80006c62:	8b89                	andi	a5,a5,2
    80006c64:	2781                	sext.w	a5,a5
    80006c66:	c799                	beqz	a5,80006c74 <flags2perm+0x38>
      perm |= PTE_W;
    80006c68:	fec42783          	lw	a5,-20(s0)
    80006c6c:	0047e793          	ori	a5,a5,4
    80006c70:	fef42623          	sw	a5,-20(s0)
    return perm;
    80006c74:	fec42783          	lw	a5,-20(s0)
}
    80006c78:	853e                	mv	a0,a5
    80006c7a:	70a2                	ld	ra,40(sp)
    80006c7c:	7402                	ld	s0,32(sp)
    80006c7e:	6145                	addi	sp,sp,48
    80006c80:	8082                	ret

0000000080006c82 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80006c82:	de010113          	addi	sp,sp,-544
    80006c86:	20113c23          	sd	ra,536(sp)
    80006c8a:	20813823          	sd	s0,528(sp)
    80006c8e:	20913423          	sd	s1,520(sp)
    80006c92:	1400                	addi	s0,sp,544
    80006c94:	dea43423          	sd	a0,-536(s0)
    80006c98:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80006c9c:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80006ca0:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80006ca4:	bb1fb0ef          	jal	80002854 <myproc>
    80006ca8:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80006cac:	904ff0ef          	jal	80005db0 <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80006cb0:	de843503          	ld	a0,-536(s0)
    80006cb4:	ddbfe0ef          	jal	80005a8e <namei>
    80006cb8:	faa43423          	sd	a0,-88(s0)
    80006cbc:	fa843783          	ld	a5,-88(s0)
    80006cc0:	e789                	bnez	a5,80006cca <kexec+0x48>
    end_op();
    80006cc2:	9a0ff0ef          	jal	80005e62 <end_op>
    return -1;
    80006cc6:	57fd                	li	a5,-1
    80006cc8:	a6f5                	j	800070b4 <kexec+0x432>
  }
  ilock(ip);
    80006cca:	fa843503          	ld	a0,-88(s0)
    80006cce:	8ccfe0ef          	jal	80004d9a <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80006cd2:	e3040793          	addi	a5,s0,-464
    80006cd6:	04000713          	li	a4,64
    80006cda:	4681                	li	a3,0
    80006cdc:	863e                	mv	a2,a5
    80006cde:	4581                	li	a1,0
    80006ce0:	fa843503          	ld	a0,-88(s0)
    80006ce4:	eccfe0ef          	jal	800053b0 <readi>
    80006ce8:	87aa                	mv	a5,a0
    80006cea:	873e                	mv	a4,a5
    80006cec:	04000793          	li	a5,64
    80006cf0:	36f71263          	bne	a4,a5,80007054 <kexec+0x3d2>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80006cf4:	e3042703          	lw	a4,-464(s0)
    80006cf8:	464c47b7          	lui	a5,0x464c4
    80006cfc:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80006d00:	34f71c63          	bne	a4,a5,80007058 <kexec+0x3d6>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80006d04:	f9843503          	ld	a0,-104(s0)
    80006d08:	d6bfb0ef          	jal	80002a72 <proc_pagetable>
    80006d0c:	faa43023          	sd	a0,-96(s0)
    80006d10:	fa043783          	ld	a5,-96(s0)
    80006d14:	34078463          	beqz	a5,8000705c <kexec+0x3da>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80006d18:	fc042623          	sw	zero,-52(s0)
    80006d1c:	e5043783          	ld	a5,-432(s0)
    80006d20:	fcf42423          	sw	a5,-56(s0)
    80006d24:	a8e9                	j	80006dfe <kexec+0x17c>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80006d26:	df840793          	addi	a5,s0,-520
    80006d2a:	fc842683          	lw	a3,-56(s0)
    80006d2e:	03800713          	li	a4,56
    80006d32:	863e                	mv	a2,a5
    80006d34:	4581                	li	a1,0
    80006d36:	fa843503          	ld	a0,-88(s0)
    80006d3a:	e76fe0ef          	jal	800053b0 <readi>
    80006d3e:	87aa                	mv	a5,a0
    80006d40:	873e                	mv	a4,a5
    80006d42:	03800793          	li	a5,56
    80006d46:	30f71d63          	bne	a4,a5,80007060 <kexec+0x3de>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80006d4a:	df842703          	lw	a4,-520(s0)
    80006d4e:	4785                	li	a5,1
    80006d50:	08f71a63          	bne	a4,a5,80006de4 <kexec+0x162>
      continue;
    if(ph.memsz < ph.filesz)
    80006d54:	e2043703          	ld	a4,-480(s0)
    80006d58:	e1843783          	ld	a5,-488(s0)
    80006d5c:	30f76463          	bltu	a4,a5,80007064 <kexec+0x3e2>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80006d60:	e0843703          	ld	a4,-504(s0)
    80006d64:	e2043783          	ld	a5,-480(s0)
    80006d68:	973e                	add	a4,a4,a5
    80006d6a:	e0843783          	ld	a5,-504(s0)
    80006d6e:	2ef76d63          	bltu	a4,a5,80007068 <kexec+0x3e6>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
    80006d72:	e0843703          	ld	a4,-504(s0)
    80006d76:	6785                	lui	a5,0x1
    80006d78:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80006d7a:	8ff9                	and	a5,a5,a4
    80006d7c:	2e079863          	bnez	a5,8000706c <kexec+0x3ea>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80006d80:	e0843703          	ld	a4,-504(s0)
    80006d84:	e2043783          	ld	a5,-480(s0)
    80006d88:	00f704b3          	add	s1,a4,a5
    80006d8c:	dfc42783          	lw	a5,-516(s0)
    80006d90:	853e                	mv	a0,a5
    80006d92:	eabff0ef          	jal	80006c3c <flags2perm>
    80006d96:	87aa                	mv	a5,a0
    80006d98:	86be                	mv	a3,a5
    80006d9a:	8626                	mv	a2,s1
    80006d9c:	fb843583          	ld	a1,-72(s0)
    80006da0:	fa043503          	ld	a0,-96(s0)
    80006da4:	8bcfb0ef          	jal	80001e60 <uvmalloc>
    80006da8:	f6a43823          	sd	a0,-144(s0)
    80006dac:	f7043783          	ld	a5,-144(s0)
    80006db0:	2c078063          	beqz	a5,80007070 <kexec+0x3ee>
      goto bad;
    sz = sz1;
    80006db4:	f7043783          	ld	a5,-144(s0)
    80006db8:	faf43c23          	sd	a5,-72(s0)
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80006dbc:	e0843783          	ld	a5,-504(s0)
    80006dc0:	e0043703          	ld	a4,-512(s0)
    80006dc4:	0007069b          	sext.w	a3,a4
    80006dc8:	e1843703          	ld	a4,-488(s0)
    80006dcc:	2701                	sext.w	a4,a4
    80006dce:	fa843603          	ld	a2,-88(s0)
    80006dd2:	85be                	mv	a1,a5
    80006dd4:	fa043503          	ld	a0,-96(s0)
    80006dd8:	2f0000ef          	jal	800070c8 <loadseg>
    80006ddc:	87aa                	mv	a5,a0
    80006dde:	2807cb63          	bltz	a5,80007074 <kexec+0x3f2>
    80006de2:	a011                	j	80006de6 <kexec+0x164>
      continue;
    80006de4:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80006de6:	fcc42783          	lw	a5,-52(s0)
    80006dea:	2785                	addiw	a5,a5,1
    80006dec:	fcf42623          	sw	a5,-52(s0)
    80006df0:	fc842783          	lw	a5,-56(s0)
    80006df4:	0387879b          	addiw	a5,a5,56
    80006df8:	2781                	sext.w	a5,a5
    80006dfa:	fcf42423          	sw	a5,-56(s0)
    80006dfe:	e6845783          	lhu	a5,-408(s0)
    80006e02:	2781                	sext.w	a5,a5
    80006e04:	fcc42703          	lw	a4,-52(s0)
    80006e08:	2701                	sext.w	a4,a4
    80006e0a:	f0f74ee3          	blt	a4,a5,80006d26 <kexec+0xa4>
      goto bad;
  }
  iunlockput(ip);
    80006e0e:	fa843503          	ld	a0,-88(s0)
    80006e12:	9a0fe0ef          	jal	80004fb2 <iunlockput>
  end_op();
    80006e16:	84cff0ef          	jal	80005e62 <end_op>
  ip = 0;
    80006e1a:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80006e1e:	a37fb0ef          	jal	80002854 <myproc>
    80006e22:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80006e26:	f9843783          	ld	a5,-104(s0)
    80006e2a:	67bc                	ld	a5,72(a5)
    80006e2c:	f8f43823          	sd	a5,-112(s0)

  // Allocate some pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the rest as the user stack.
  sz = PGROUNDUP(sz);
    80006e30:	fb843703          	ld	a4,-72(s0)
    80006e34:	6785                	lui	a5,0x1
    80006e36:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80006e38:	973e                	add	a4,a4,a5
    80006e3a:	77fd                	lui	a5,0xfffff
    80006e3c:	8ff9                	and	a5,a5,a4
    80006e3e:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80006e42:	fb843703          	ld	a4,-72(s0)
    80006e46:	6789                	lui	a5,0x2
    80006e48:	97ba                	add	a5,a5,a4
    80006e4a:	4691                	li	a3,4
    80006e4c:	863e                	mv	a2,a5
    80006e4e:	fb843583          	ld	a1,-72(s0)
    80006e52:	fa043503          	ld	a0,-96(s0)
    80006e56:	80afb0ef          	jal	80001e60 <uvmalloc>
    80006e5a:	f8a43423          	sd	a0,-120(s0)
    80006e5e:	f8843783          	ld	a5,-120(s0)
    80006e62:	20078b63          	beqz	a5,80007078 <kexec+0x3f6>
    goto bad;
  sz = sz1;
    80006e66:	f8843783          	ld	a5,-120(s0)
    80006e6a:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80006e6e:	fb843703          	ld	a4,-72(s0)
    80006e72:	77f9                	lui	a5,0xffffe
    80006e74:	97ba                	add	a5,a5,a4
    80006e76:	85be                	mv	a1,a5
    80006e78:	fa043503          	ld	a0,-96(s0)
    80006e7c:	b18fb0ef          	jal	80002194 <uvmclear>
  sp = sz;
    80006e80:	fb843783          	ld	a5,-72(s0)
    80006e84:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - USERSTACK*PGSIZE;
    80006e88:	fb043703          	ld	a4,-80(s0)
    80006e8c:	77fd                	lui	a5,0xfffff
    80006e8e:	97ba                	add	a5,a5,a4
    80006e90:	f8f43023          	sd	a5,-128(s0)

  // Copy argument strings into new stack, remember their
  // addresses in ustack[].
  for(argc = 0; argv[argc]; argc++) {
    80006e94:	fc043023          	sd	zero,-64(s0)
    80006e98:	a04d                	j	80006f3a <kexec+0x2b8>
    if(argc >= MAXARG)
    80006e9a:	fc043703          	ld	a4,-64(s0)
    80006e9e:	47fd                	li	a5,31
    80006ea0:	1ce7ee63          	bltu	a5,a4,8000707c <kexec+0x3fa>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80006ea4:	fc043783          	ld	a5,-64(s0)
    80006ea8:	078e                	slli	a5,a5,0x3
    80006eaa:	de043703          	ld	a4,-544(s0)
    80006eae:	97ba                	add	a5,a5,a4
    80006eb0:	639c                	ld	a5,0(a5)
    80006eb2:	853e                	mv	a0,a5
    80006eb4:	9b7fa0ef          	jal	8000186a <strlen>
    80006eb8:	87aa                	mv	a5,a0
    80006eba:	2785                	addiw	a5,a5,1 # fffffffffffff001 <end+0xffffffff7ffdb449>
    80006ebc:	2781                	sext.w	a5,a5
    80006ebe:	873e                	mv	a4,a5
    80006ec0:	fb043783          	ld	a5,-80(s0)
    80006ec4:	8f99                	sub	a5,a5,a4
    80006ec6:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80006eca:	fb043783          	ld	a5,-80(s0)
    80006ece:	9bc1                	andi	a5,a5,-16
    80006ed0:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80006ed4:	fb043703          	ld	a4,-80(s0)
    80006ed8:	f8043783          	ld	a5,-128(s0)
    80006edc:	1af76263          	bltu	a4,a5,80007080 <kexec+0x3fe>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80006ee0:	fc043783          	ld	a5,-64(s0)
    80006ee4:	078e                	slli	a5,a5,0x3
    80006ee6:	de043703          	ld	a4,-544(s0)
    80006eea:	97ba                	add	a5,a5,a4
    80006eec:	6384                	ld	s1,0(a5)
    80006eee:	fc043783          	ld	a5,-64(s0)
    80006ef2:	078e                	slli	a5,a5,0x3
    80006ef4:	de043703          	ld	a4,-544(s0)
    80006ef8:	97ba                	add	a5,a5,a4
    80006efa:	639c                	ld	a5,0(a5)
    80006efc:	853e                	mv	a0,a5
    80006efe:	96dfa0ef          	jal	8000186a <strlen>
    80006f02:	87aa                	mv	a5,a0
    80006f04:	2785                	addiw	a5,a5,1
    80006f06:	2781                	sext.w	a5,a5
    80006f08:	86be                	mv	a3,a5
    80006f0a:	8626                	mv	a2,s1
    80006f0c:	fb043583          	ld	a1,-80(s0)
    80006f10:	fa043503          	ld	a0,-96(s0)
    80006f14:	acefb0ef          	jal	800021e2 <copyout>
    80006f18:	87aa                	mv	a5,a0
    80006f1a:	1607c563          	bltz	a5,80007084 <kexec+0x402>
      goto bad;
    ustack[argc] = sp;
    80006f1e:	fc043703          	ld	a4,-64(s0)
    80006f22:	e7040793          	addi	a5,s0,-400
    80006f26:	070e                	slli	a4,a4,0x3
    80006f28:	97ba                	add	a5,a5,a4
    80006f2a:	fb043703          	ld	a4,-80(s0)
    80006f2e:	e398                	sd	a4,0(a5)
  for(argc = 0; argv[argc]; argc++) {
    80006f30:	fc043783          	ld	a5,-64(s0)
    80006f34:	0785                	addi	a5,a5,1
    80006f36:	fcf43023          	sd	a5,-64(s0)
    80006f3a:	fc043783          	ld	a5,-64(s0)
    80006f3e:	078e                	slli	a5,a5,0x3
    80006f40:	de043703          	ld	a4,-544(s0)
    80006f44:	97ba                	add	a5,a5,a4
    80006f46:	639c                	ld	a5,0(a5)
    80006f48:	fba9                	bnez	a5,80006e9a <kexec+0x218>
  }
  ustack[argc] = 0;
    80006f4a:	fc043703          	ld	a4,-64(s0)
    80006f4e:	e7040793          	addi	a5,s0,-400
    80006f52:	070e                	slli	a4,a4,0x3
    80006f54:	97ba                	add	a5,a5,a4
    80006f56:	0007b023          	sd	zero,0(a5)

  // push a copy of ustack[], the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    80006f5a:	fc043783          	ld	a5,-64(s0)
    80006f5e:	0785                	addi	a5,a5,1
    80006f60:	078e                	slli	a5,a5,0x3
    80006f62:	fb043703          	ld	a4,-80(s0)
    80006f66:	40f707b3          	sub	a5,a4,a5
    80006f6a:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    80006f6e:	fb043783          	ld	a5,-80(s0)
    80006f72:	9bc1                	andi	a5,a5,-16
    80006f74:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    80006f78:	fb043703          	ld	a4,-80(s0)
    80006f7c:	f8043783          	ld	a5,-128(s0)
    80006f80:	10f76463          	bltu	a4,a5,80007088 <kexec+0x406>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80006f84:	fc043783          	ld	a5,-64(s0)
    80006f88:	0785                	addi	a5,a5,1
    80006f8a:	00379713          	slli	a4,a5,0x3
    80006f8e:	e7040793          	addi	a5,s0,-400
    80006f92:	86ba                	mv	a3,a4
    80006f94:	863e                	mv	a2,a5
    80006f96:	fb043583          	ld	a1,-80(s0)
    80006f9a:	fa043503          	ld	a0,-96(s0)
    80006f9e:	a44fb0ef          	jal	800021e2 <copyout>
    80006fa2:	87aa                	mv	a5,a0
    80006fa4:	0e07c463          	bltz	a5,8000708c <kexec+0x40a>
    goto bad;

  // a0 and a1 contain arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80006fa8:	f9843783          	ld	a5,-104(s0)
    80006fac:	6fbc                	ld	a5,88(a5)
    80006fae:	fb043703          	ld	a4,-80(s0)
    80006fb2:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80006fb4:	de843783          	ld	a5,-536(s0)
    80006fb8:	fcf43c23          	sd	a5,-40(s0)
    80006fbc:	fd843783          	ld	a5,-40(s0)
    80006fc0:	fcf43823          	sd	a5,-48(s0)
    80006fc4:	a025                	j	80006fec <kexec+0x36a>
    if(*s == '/')
    80006fc6:	fd843783          	ld	a5,-40(s0)
    80006fca:	0007c783          	lbu	a5,0(a5)
    80006fce:	873e                	mv	a4,a5
    80006fd0:	02f00793          	li	a5,47
    80006fd4:	00f71763          	bne	a4,a5,80006fe2 <kexec+0x360>
      last = s+1;
    80006fd8:	fd843783          	ld	a5,-40(s0)
    80006fdc:	0785                	addi	a5,a5,1
    80006fde:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80006fe2:	fd843783          	ld	a5,-40(s0)
    80006fe6:	0785                	addi	a5,a5,1
    80006fe8:	fcf43c23          	sd	a5,-40(s0)
    80006fec:	fd843783          	ld	a5,-40(s0)
    80006ff0:	0007c783          	lbu	a5,0(a5)
    80006ff4:	fbe9                	bnez	a5,80006fc6 <kexec+0x344>
  safestrcpy(p->name, last, sizeof(p->name));
    80006ff6:	f9843783          	ld	a5,-104(s0)
    80006ffa:	15878793          	addi	a5,a5,344
    80006ffe:	4641                	li	a2,16
    80007000:	fd043583          	ld	a1,-48(s0)
    80007004:	853e                	mv	a0,a5
    80007006:	fe4fa0ef          	jal	800017ea <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    8000700a:	f9843783          	ld	a5,-104(s0)
    8000700e:	6bbc                	ld	a5,80(a5)
    80007010:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80007014:	f9843783          	ld	a5,-104(s0)
    80007018:	fa043703          	ld	a4,-96(s0)
    8000701c:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    8000701e:	f9843783          	ld	a5,-104(s0)
    80007022:	fb843703          	ld	a4,-72(s0)
    80007026:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = ulib.c:start()
    80007028:	f9843783          	ld	a5,-104(s0)
    8000702c:	6fbc                	ld	a5,88(a5)
    8000702e:	e4843703          	ld	a4,-440(s0)
    80007032:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80007034:	f9843783          	ld	a5,-104(s0)
    80007038:	6fbc                	ld	a5,88(a5)
    8000703a:	fb043703          	ld	a4,-80(s0)
    8000703e:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80007040:	f9043583          	ld	a1,-112(s0)
    80007044:	f7843503          	ld	a0,-136(s0)
    80007048:	ad3fb0ef          	jal	80002b1a <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000704c:	fc043783          	ld	a5,-64(s0)
    80007050:	2781                	sext.w	a5,a5
    80007052:	a08d                	j	800070b4 <kexec+0x432>
    goto bad;
    80007054:	0001                	nop
    80007056:	a825                	j	8000708e <kexec+0x40c>
    goto bad;
    80007058:	0001                	nop
    8000705a:	a815                	j	8000708e <kexec+0x40c>
    goto bad;
    8000705c:	0001                	nop
    8000705e:	a805                	j	8000708e <kexec+0x40c>
      goto bad;
    80007060:	0001                	nop
    80007062:	a035                	j	8000708e <kexec+0x40c>
      goto bad;
    80007064:	0001                	nop
    80007066:	a025                	j	8000708e <kexec+0x40c>
      goto bad;
    80007068:	0001                	nop
    8000706a:	a015                	j	8000708e <kexec+0x40c>
      goto bad;
    8000706c:	0001                	nop
    8000706e:	a005                	j	8000708e <kexec+0x40c>
      goto bad;
    80007070:	0001                	nop
    80007072:	a831                	j	8000708e <kexec+0x40c>
      goto bad;
    80007074:	0001                	nop
    80007076:	a821                	j	8000708e <kexec+0x40c>
    goto bad;
    80007078:	0001                	nop
    8000707a:	a811                	j	8000708e <kexec+0x40c>
      goto bad;
    8000707c:	0001                	nop
    8000707e:	a801                	j	8000708e <kexec+0x40c>
      goto bad;
    80007080:	0001                	nop
    80007082:	a031                	j	8000708e <kexec+0x40c>
      goto bad;
    80007084:	0001                	nop
    80007086:	a021                	j	8000708e <kexec+0x40c>
    goto bad;
    80007088:	0001                	nop
    8000708a:	a011                	j	8000708e <kexec+0x40c>
    goto bad;
    8000708c:	0001                	nop

 bad:
  if(pagetable)
    8000708e:	fa043783          	ld	a5,-96(s0)
    80007092:	c799                	beqz	a5,800070a0 <kexec+0x41e>
    proc_freepagetable(pagetable, sz);
    80007094:	fb843583          	ld	a1,-72(s0)
    80007098:	fa043503          	ld	a0,-96(s0)
    8000709c:	a7ffb0ef          	jal	80002b1a <proc_freepagetable>
  if(ip){
    800070a0:	fa843783          	ld	a5,-88(s0)
    800070a4:	c799                	beqz	a5,800070b2 <kexec+0x430>
    iunlockput(ip);
    800070a6:	fa843503          	ld	a0,-88(s0)
    800070aa:	f09fd0ef          	jal	80004fb2 <iunlockput>
    end_op();
    800070ae:	db5fe0ef          	jal	80005e62 <end_op>
  }
  return -1;
    800070b2:	57fd                	li	a5,-1
}
    800070b4:	853e                	mv	a0,a5
    800070b6:	21813083          	ld	ra,536(sp)
    800070ba:	21013403          	ld	s0,528(sp)
    800070be:	20813483          	ld	s1,520(sp)
    800070c2:	22010113          	addi	sp,sp,544
    800070c6:	8082                	ret

00000000800070c8 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    800070c8:	7139                	addi	sp,sp,-64
    800070ca:	fc06                	sd	ra,56(sp)
    800070cc:	f822                	sd	s0,48(sp)
    800070ce:	0080                	addi	s0,sp,64
    800070d0:	fca43c23          	sd	a0,-40(s0)
    800070d4:	fcb43823          	sd	a1,-48(s0)
    800070d8:	fcc43423          	sd	a2,-56(s0)
    800070dc:	87b6                	mv	a5,a3
    800070de:	fcf42223          	sw	a5,-60(s0)
    800070e2:	87ba                	mv	a5,a4
    800070e4:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    800070e8:	fe042623          	sw	zero,-20(s0)
    800070ec:	a045                	j	8000718c <loadseg+0xc4>
    pa = walkaddr(pagetable, va + i);
    800070ee:	fec46703          	lwu	a4,-20(s0)
    800070f2:	fd043783          	ld	a5,-48(s0)
    800070f6:	97ba                	add	a5,a5,a4
    800070f8:	85be                	mv	a1,a5
    800070fa:	fd843503          	ld	a0,-40(s0)
    800070fe:	b05fa0ef          	jal	80001c02 <walkaddr>
    80007102:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80007106:	fe043783          	ld	a5,-32(s0)
    8000710a:	e799                	bnez	a5,80007118 <loadseg+0x50>
      panic("loadseg: address should exist");
    8000710c:	00003517          	auipc	a0,0x3
    80007110:	4f450513          	addi	a0,a0,1268 # 8000a600 <etext+0x600>
    80007114:	d23f90ef          	jal	80000e36 <panic>
    if(sz - i < PGSIZE)
    80007118:	fc042783          	lw	a5,-64(s0)
    8000711c:	873e                	mv	a4,a5
    8000711e:	fec42783          	lw	a5,-20(s0)
    80007122:	40f707bb          	subw	a5,a4,a5
    80007126:	0007871b          	sext.w	a4,a5
    8000712a:	6785                	lui	a5,0x1
    8000712c:	00f77c63          	bgeu	a4,a5,80007144 <loadseg+0x7c>
      n = sz - i;
    80007130:	fc042783          	lw	a5,-64(s0)
    80007134:	873e                	mv	a4,a5
    80007136:	fec42783          	lw	a5,-20(s0)
    8000713a:	40f707bb          	subw	a5,a4,a5
    8000713e:	fef42423          	sw	a5,-24(s0)
    80007142:	a021                	j	8000714a <loadseg+0x82>
    else
      n = PGSIZE;
    80007144:	6785                	lui	a5,0x1
    80007146:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000714a:	fc442783          	lw	a5,-60(s0)
    8000714e:	873e                	mv	a4,a5
    80007150:	fec42783          	lw	a5,-20(s0)
    80007154:	9fb9                	addw	a5,a5,a4
    80007156:	2781                	sext.w	a5,a5
    80007158:	fe842703          	lw	a4,-24(s0)
    8000715c:	86be                	mv	a3,a5
    8000715e:	fe043603          	ld	a2,-32(s0)
    80007162:	4581                	li	a1,0
    80007164:	fc843503          	ld	a0,-56(s0)
    80007168:	a48fe0ef          	jal	800053b0 <readi>
    8000716c:	87aa                	mv	a5,a0
    8000716e:	873e                	mv	a4,a5
    80007170:	fe842783          	lw	a5,-24(s0)
    80007174:	2781                	sext.w	a5,a5
    80007176:	00e78463          	beq	a5,a4,8000717e <loadseg+0xb6>
      return -1;
    8000717a:	57fd                	li	a5,-1
    8000717c:	a015                	j	800071a0 <loadseg+0xd8>
  for(i = 0; i < sz; i += PGSIZE){
    8000717e:	fec42783          	lw	a5,-20(s0)
    80007182:	873e                	mv	a4,a5
    80007184:	6785                	lui	a5,0x1
    80007186:	9fb9                	addw	a5,a5,a4
    80007188:	fef42623          	sw	a5,-20(s0)
    8000718c:	fec42783          	lw	a5,-20(s0)
    80007190:	873e                	mv	a4,a5
    80007192:	fc042783          	lw	a5,-64(s0)
    80007196:	2701                	sext.w	a4,a4
    80007198:	2781                	sext.w	a5,a5
    8000719a:	f4f76ae3          	bltu	a4,a5,800070ee <loadseg+0x26>
  }
  
  return 0;
    8000719e:	4781                	li	a5,0
}
    800071a0:	853e                	mv	a0,a5
    800071a2:	70e2                	ld	ra,56(sp)
    800071a4:	7442                	ld	s0,48(sp)
    800071a6:	6121                	addi	sp,sp,64
    800071a8:	8082                	ret

00000000800071aa <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800071aa:	7139                	addi	sp,sp,-64
    800071ac:	fc06                	sd	ra,56(sp)
    800071ae:	f822                	sd	s0,48(sp)
    800071b0:	0080                	addi	s0,sp,64
    800071b2:	87aa                	mv	a5,a0
    800071b4:	fcb43823          	sd	a1,-48(s0)
    800071b8:	fcc43423          	sd	a2,-56(s0)
    800071bc:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  argint(n, &fd);
    800071c0:	fe440713          	addi	a4,s0,-28
    800071c4:	fdc42783          	lw	a5,-36(s0)
    800071c8:	85ba                	mv	a1,a4
    800071ca:	853e                	mv	a0,a5
    800071cc:	c6bfc0ef          	jal	80003e36 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800071d0:	fe442783          	lw	a5,-28(s0)
    800071d4:	0207c563          	bltz	a5,800071fe <argfd+0x54>
    800071d8:	fe442703          	lw	a4,-28(s0)
    800071dc:	47bd                	li	a5,15
    800071de:	02e7c063          	blt	a5,a4,800071fe <argfd+0x54>
    800071e2:	e72fb0ef          	jal	80002854 <myproc>
    800071e6:	872a                	mv	a4,a0
    800071e8:	fe442783          	lw	a5,-28(s0)
    800071ec:	07e9                	addi	a5,a5,26 # 101a <_entry-0x7fffefe6>
    800071ee:	078e                	slli	a5,a5,0x3
    800071f0:	97ba                	add	a5,a5,a4
    800071f2:	639c                	ld	a5,0(a5)
    800071f4:	fef43423          	sd	a5,-24(s0)
    800071f8:	fe843783          	ld	a5,-24(s0)
    800071fc:	e399                	bnez	a5,80007202 <argfd+0x58>
    return -1;
    800071fe:	57fd                	li	a5,-1
    80007200:	a015                	j	80007224 <argfd+0x7a>
  if(pfd)
    80007202:	fd043783          	ld	a5,-48(s0)
    80007206:	c791                	beqz	a5,80007212 <argfd+0x68>
    *pfd = fd;
    80007208:	fe442703          	lw	a4,-28(s0)
    8000720c:	fd043783          	ld	a5,-48(s0)
    80007210:	c398                	sw	a4,0(a5)
  if(pf)
    80007212:	fc843783          	ld	a5,-56(s0)
    80007216:	c791                	beqz	a5,80007222 <argfd+0x78>
    *pf = f;
    80007218:	fc843783          	ld	a5,-56(s0)
    8000721c:	fe843703          	ld	a4,-24(s0)
    80007220:	e398                	sd	a4,0(a5)
  return 0;
    80007222:	4781                	li	a5,0
}
    80007224:	853e                	mv	a0,a5
    80007226:	70e2                	ld	ra,56(sp)
    80007228:	7442                	ld	s0,48(sp)
    8000722a:	6121                	addi	sp,sp,64
    8000722c:	8082                	ret

000000008000722e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000722e:	7179                	addi	sp,sp,-48
    80007230:	f406                	sd	ra,40(sp)
    80007232:	f022                	sd	s0,32(sp)
    80007234:	1800                	addi	s0,sp,48
    80007236:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    8000723a:	e1afb0ef          	jal	80002854 <myproc>
    8000723e:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80007242:	fe042623          	sw	zero,-20(s0)
    80007246:	a825                	j	8000727e <fdalloc+0x50>
    if(p->ofile[fd] == 0){
    80007248:	fe043703          	ld	a4,-32(s0)
    8000724c:	fec42783          	lw	a5,-20(s0)
    80007250:	07e9                	addi	a5,a5,26
    80007252:	078e                	slli	a5,a5,0x3
    80007254:	97ba                	add	a5,a5,a4
    80007256:	639c                	ld	a5,0(a5)
    80007258:	ef91                	bnez	a5,80007274 <fdalloc+0x46>
      p->ofile[fd] = f;
    8000725a:	fe043703          	ld	a4,-32(s0)
    8000725e:	fec42783          	lw	a5,-20(s0)
    80007262:	07e9                	addi	a5,a5,26
    80007264:	078e                	slli	a5,a5,0x3
    80007266:	97ba                	add	a5,a5,a4
    80007268:	fd843703          	ld	a4,-40(s0)
    8000726c:	e398                	sd	a4,0(a5)
      return fd;
    8000726e:	fec42783          	lw	a5,-20(s0)
    80007272:	a831                	j	8000728e <fdalloc+0x60>
  for(fd = 0; fd < NOFILE; fd++){
    80007274:	fec42783          	lw	a5,-20(s0)
    80007278:	2785                	addiw	a5,a5,1
    8000727a:	fef42623          	sw	a5,-20(s0)
    8000727e:	fec42783          	lw	a5,-20(s0)
    80007282:	0007871b          	sext.w	a4,a5
    80007286:	47bd                	li	a5,15
    80007288:	fce7d0e3          	bge	a5,a4,80007248 <fdalloc+0x1a>
    }
  }
  return -1;
    8000728c:	57fd                	li	a5,-1
}
    8000728e:	853e                	mv	a0,a5
    80007290:	70a2                	ld	ra,40(sp)
    80007292:	7402                	ld	s0,32(sp)
    80007294:	6145                	addi	sp,sp,48
    80007296:	8082                	ret

0000000080007298 <sys_dup>:

uint64
sys_dup(void)
{
    80007298:	1101                	addi	sp,sp,-32
    8000729a:	ec06                	sd	ra,24(sp)
    8000729c:	e822                	sd	s0,16(sp)
    8000729e:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    800072a0:	fe040793          	addi	a5,s0,-32
    800072a4:	863e                	mv	a2,a5
    800072a6:	4581                	li	a1,0
    800072a8:	4501                	li	a0,0
    800072aa:	f01ff0ef          	jal	800071aa <argfd>
    800072ae:	87aa                	mv	a5,a0
    800072b0:	0007d463          	bgez	a5,800072b8 <sys_dup+0x20>
    return -1;
    800072b4:	57fd                	li	a5,-1
    800072b6:	a03d                	j	800072e4 <sys_dup+0x4c>
  if((fd=fdalloc(f)) < 0)
    800072b8:	fe043783          	ld	a5,-32(s0)
    800072bc:	853e                	mv	a0,a5
    800072be:	f71ff0ef          	jal	8000722e <fdalloc>
    800072c2:	87aa                	mv	a5,a0
    800072c4:	fef42623          	sw	a5,-20(s0)
    800072c8:	fec42783          	lw	a5,-20(s0)
    800072cc:	2781                	sext.w	a5,a5
    800072ce:	0007d463          	bgez	a5,800072d6 <sys_dup+0x3e>
    return -1;
    800072d2:	57fd                	li	a5,-1
    800072d4:	a801                	j	800072e4 <sys_dup+0x4c>
  filedup(f);
    800072d6:	fe043783          	ld	a5,-32(s0)
    800072da:	853e                	mv	a0,a5
    800072dc:	834ff0ef          	jal	80006310 <filedup>
  return fd;
    800072e0:	fec42783          	lw	a5,-20(s0)
}
    800072e4:	853e                	mv	a0,a5
    800072e6:	60e2                	ld	ra,24(sp)
    800072e8:	6442                	ld	s0,16(sp)
    800072ea:	6105                	addi	sp,sp,32
    800072ec:	8082                	ret

00000000800072ee <sys_read>:

uint64
sys_read(void)
{
    800072ee:	7179                	addi	sp,sp,-48
    800072f0:	f406                	sd	ra,40(sp)
    800072f2:	f022                	sd	s0,32(sp)
    800072f4:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
    800072f6:	fd840793          	addi	a5,s0,-40
    800072fa:	85be                	mv	a1,a5
    800072fc:	4505                	li	a0,1
    800072fe:	b6bfc0ef          	jal	80003e68 <argaddr>
  argint(2, &n);
    80007302:	fe440793          	addi	a5,s0,-28
    80007306:	85be                	mv	a1,a5
    80007308:	4509                	li	a0,2
    8000730a:	b2dfc0ef          	jal	80003e36 <argint>
  if(argfd(0, 0, &f) < 0)
    8000730e:	fe840793          	addi	a5,s0,-24
    80007312:	863e                	mv	a2,a5
    80007314:	4581                	li	a1,0
    80007316:	4501                	li	a0,0
    80007318:	e93ff0ef          	jal	800071aa <argfd>
    8000731c:	87aa                	mv	a5,a0
    8000731e:	0007d463          	bgez	a5,80007326 <sys_read+0x38>
    return -1;
    80007322:	57fd                	li	a5,-1
    80007324:	a829                	j	8000733e <sys_read+0x50>
  return fileread(f, p, n);
    80007326:	fe843783          	ld	a5,-24(s0)
    8000732a:	fd843703          	ld	a4,-40(s0)
    8000732e:	fe442683          	lw	a3,-28(s0)
    80007332:	8636                	mv	a2,a3
    80007334:	85ba                	mv	a1,a4
    80007336:	853e                	mv	a0,a5
    80007338:	9a0ff0ef          	jal	800064d8 <fileread>
    8000733c:	87aa                	mv	a5,a0
}
    8000733e:	853e                	mv	a0,a5
    80007340:	70a2                	ld	ra,40(sp)
    80007342:	7402                	ld	s0,32(sp)
    80007344:	6145                	addi	sp,sp,48
    80007346:	8082                	ret

0000000080007348 <sys_write>:

uint64
sys_write(void)
{
    80007348:	7179                	addi	sp,sp,-48
    8000734a:	f406                	sd	ra,40(sp)
    8000734c:	f022                	sd	s0,32(sp)
    8000734e:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
    80007350:	fd840793          	addi	a5,s0,-40
    80007354:	85be                	mv	a1,a5
    80007356:	4505                	li	a0,1
    80007358:	b11fc0ef          	jal	80003e68 <argaddr>
  argint(2, &n);
    8000735c:	fe440793          	addi	a5,s0,-28
    80007360:	85be                	mv	a1,a5
    80007362:	4509                	li	a0,2
    80007364:	ad3fc0ef          	jal	80003e36 <argint>
  if(argfd(0, 0, &f) < 0)
    80007368:	fe840793          	addi	a5,s0,-24
    8000736c:	863e                	mv	a2,a5
    8000736e:	4581                	li	a1,0
    80007370:	4501                	li	a0,0
    80007372:	e39ff0ef          	jal	800071aa <argfd>
    80007376:	87aa                	mv	a5,a0
    80007378:	0007d463          	bgez	a5,80007380 <sys_write+0x38>
    return -1;
    8000737c:	57fd                	li	a5,-1
    8000737e:	a829                	j	80007398 <sys_write+0x50>

  return filewrite(f, p, n);
    80007380:	fe843783          	ld	a5,-24(s0)
    80007384:	fd843703          	ld	a4,-40(s0)
    80007388:	fe442683          	lw	a3,-28(s0)
    8000738c:	8636                	mv	a2,a3
    8000738e:	85ba                	mv	a1,a4
    80007390:	853e                	mv	a0,a5
    80007392:	a88ff0ef          	jal	8000661a <filewrite>
    80007396:	87aa                	mv	a5,a0
}
    80007398:	853e                	mv	a0,a5
    8000739a:	70a2                	ld	ra,40(sp)
    8000739c:	7402                	ld	s0,32(sp)
    8000739e:	6145                	addi	sp,sp,48
    800073a0:	8082                	ret

00000000800073a2 <sys_close>:

uint64
sys_close(void)
{
    800073a2:	1101                	addi	sp,sp,-32
    800073a4:	ec06                	sd	ra,24(sp)
    800073a6:	e822                	sd	s0,16(sp)
    800073a8:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    800073aa:	fe040713          	addi	a4,s0,-32
    800073ae:	fec40793          	addi	a5,s0,-20
    800073b2:	863a                	mv	a2,a4
    800073b4:	85be                	mv	a1,a5
    800073b6:	4501                	li	a0,0
    800073b8:	df3ff0ef          	jal	800071aa <argfd>
    800073bc:	87aa                	mv	a5,a0
    800073be:	0007d463          	bgez	a5,800073c6 <sys_close+0x24>
    return -1;
    800073c2:	57fd                	li	a5,-1
    800073c4:	a00d                	j	800073e6 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800073c6:	c8efb0ef          	jal	80002854 <myproc>
    800073ca:	872a                	mv	a4,a0
    800073cc:	fec42783          	lw	a5,-20(s0)
    800073d0:	07e9                	addi	a5,a5,26
    800073d2:	078e                	slli	a5,a5,0x3
    800073d4:	97ba                	add	a5,a5,a4
    800073d6:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    800073da:	fe043783          	ld	a5,-32(s0)
    800073de:	853e                	mv	a0,a5
    800073e0:	f8bfe0ef          	jal	8000636a <fileclose>
  return 0;
    800073e4:	4781                	li	a5,0
}
    800073e6:	853e                	mv	a0,a5
    800073e8:	60e2                	ld	ra,24(sp)
    800073ea:	6442                	ld	s0,16(sp)
    800073ec:	6105                	addi	sp,sp,32
    800073ee:	8082                	ret

00000000800073f0 <sys_fstat>:

uint64
sys_fstat(void)
{
    800073f0:	1101                	addi	sp,sp,-32
    800073f2:	ec06                	sd	ra,24(sp)
    800073f4:	e822                	sd	s0,16(sp)
    800073f6:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
    800073f8:	fe040793          	addi	a5,s0,-32
    800073fc:	85be                	mv	a1,a5
    800073fe:	4505                	li	a0,1
    80007400:	a69fc0ef          	jal	80003e68 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80007404:	fe840793          	addi	a5,s0,-24
    80007408:	863e                	mv	a2,a5
    8000740a:	4581                	li	a1,0
    8000740c:	4501                	li	a0,0
    8000740e:	d9dff0ef          	jal	800071aa <argfd>
    80007412:	87aa                	mv	a5,a0
    80007414:	0007d463          	bgez	a5,8000741c <sys_fstat+0x2c>
    return -1;
    80007418:	57fd                	li	a5,-1
    8000741a:	a811                	j	8000742e <sys_fstat+0x3e>
  return filestat(f, st);
    8000741c:	fe843783          	ld	a5,-24(s0)
    80007420:	fe043703          	ld	a4,-32(s0)
    80007424:	85ba                	mv	a1,a4
    80007426:	853e                	mv	a0,a5
    80007428:	824ff0ef          	jal	8000644c <filestat>
    8000742c:	87aa                	mv	a5,a0
}
    8000742e:	853e                	mv	a0,a5
    80007430:	60e2                	ld	ra,24(sp)
    80007432:	6442                	ld	s0,16(sp)
    80007434:	6105                	addi	sp,sp,32
    80007436:	8082                	ret

0000000080007438 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80007438:	7169                	addi	sp,sp,-304
    8000743a:	f606                	sd	ra,296(sp)
    8000743c:	f222                	sd	s0,288(sp)
    8000743e:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80007440:	ed040793          	addi	a5,s0,-304
    80007444:	08000613          	li	a2,128
    80007448:	85be                	mv	a1,a5
    8000744a:	4501                	li	a0,0
    8000744c:	a4bfc0ef          	jal	80003e96 <argstr>
    80007450:	87aa                	mv	a5,a0
    80007452:	0007cd63          	bltz	a5,8000746c <sys_link+0x34>
    80007456:	f5040793          	addi	a5,s0,-176
    8000745a:	08000613          	li	a2,128
    8000745e:	85be                	mv	a1,a5
    80007460:	4505                	li	a0,1
    80007462:	a35fc0ef          	jal	80003e96 <argstr>
    80007466:	87aa                	mv	a5,a0
    80007468:	0007d463          	bgez	a5,80007470 <sys_link+0x38>
    return -1;
    8000746c:	57fd                	li	a5,-1
    8000746e:	a235                	j	8000759a <sys_link+0x162>

  begin_op();
    80007470:	941fe0ef          	jal	80005db0 <begin_op>
  if((ip = namei(old)) == 0){
    80007474:	ed040793          	addi	a5,s0,-304
    80007478:	853e                	mv	a0,a5
    8000747a:	e14fe0ef          	jal	80005a8e <namei>
    8000747e:	fea43423          	sd	a0,-24(s0)
    80007482:	fe843783          	ld	a5,-24(s0)
    80007486:	e789                	bnez	a5,80007490 <sys_link+0x58>
    end_op();
    80007488:	9dbfe0ef          	jal	80005e62 <end_op>
    return -1;
    8000748c:	57fd                	li	a5,-1
    8000748e:	a231                	j	8000759a <sys_link+0x162>
  }

  ilock(ip);
    80007490:	fe843503          	ld	a0,-24(s0)
    80007494:	907fd0ef          	jal	80004d9a <ilock>
  if(ip->type == T_DIR){
    80007498:	fe843783          	ld	a5,-24(s0)
    8000749c:	04479703          	lh	a4,68(a5)
    800074a0:	4785                	li	a5,1
    800074a2:	00f71a63          	bne	a4,a5,800074b6 <sys_link+0x7e>
    iunlockput(ip);
    800074a6:	fe843503          	ld	a0,-24(s0)
    800074aa:	b09fd0ef          	jal	80004fb2 <iunlockput>
    end_op();
    800074ae:	9b5fe0ef          	jal	80005e62 <end_op>
    return -1;
    800074b2:	57fd                	li	a5,-1
    800074b4:	a0dd                	j	8000759a <sys_link+0x162>
  }

  ip->nlink++;
    800074b6:	fe843783          	ld	a5,-24(s0)
    800074ba:	04a79783          	lh	a5,74(a5)
    800074be:	17c2                	slli	a5,a5,0x30
    800074c0:	93c1                	srli	a5,a5,0x30
    800074c2:	2785                	addiw	a5,a5,1
    800074c4:	17c2                	slli	a5,a5,0x30
    800074c6:	93c1                	srli	a5,a5,0x30
    800074c8:	0107971b          	slliw	a4,a5,0x10
    800074cc:	4107571b          	sraiw	a4,a4,0x10
    800074d0:	fe843783          	ld	a5,-24(s0)
    800074d4:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800074d8:	fe843503          	ld	a0,-24(s0)
    800074dc:	e96fd0ef          	jal	80004b72 <iupdate>
  iunlock(ip);
    800074e0:	fe843503          	ld	a0,-24(s0)
    800074e4:	9d3fd0ef          	jal	80004eb6 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    800074e8:	fd040713          	addi	a4,s0,-48
    800074ec:	f5040793          	addi	a5,s0,-176
    800074f0:	85ba                	mv	a1,a4
    800074f2:	853e                	mv	a0,a5
    800074f4:	dc2fe0ef          	jal	80005ab6 <nameiparent>
    800074f8:	fea43023          	sd	a0,-32(s0)
    800074fc:	fe043783          	ld	a5,-32(s0)
    80007500:	cfa1                	beqz	a5,80007558 <sys_link+0x120>
    goto bad;
  ilock(dp);
    80007502:	fe043503          	ld	a0,-32(s0)
    80007506:	895fd0ef          	jal	80004d9a <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000750a:	fe043783          	ld	a5,-32(s0)
    8000750e:	4398                	lw	a4,0(a5)
    80007510:	fe843783          	ld	a5,-24(s0)
    80007514:	439c                	lw	a5,0(a5)
    80007516:	02f71063          	bne	a4,a5,80007536 <sys_link+0xfe>
    8000751a:	fe843783          	ld	a5,-24(s0)
    8000751e:	43d8                	lw	a4,4(a5)
    80007520:	fd040793          	addi	a5,s0,-48
    80007524:	863a                	mv	a2,a4
    80007526:	85be                	mv	a1,a5
    80007528:	fe043503          	ld	a0,-32(s0)
    8000752c:	aa4fe0ef          	jal	800057d0 <dirlink>
    80007530:	87aa                	mv	a5,a0
    80007532:	0007d763          	bgez	a5,80007540 <sys_link+0x108>
    iunlockput(dp);
    80007536:	fe043503          	ld	a0,-32(s0)
    8000753a:	a79fd0ef          	jal	80004fb2 <iunlockput>
    goto bad;
    8000753e:	a831                	j	8000755a <sys_link+0x122>
  }
  iunlockput(dp);
    80007540:	fe043503          	ld	a0,-32(s0)
    80007544:	a6ffd0ef          	jal	80004fb2 <iunlockput>
  iput(ip);
    80007548:	fe843503          	ld	a0,-24(s0)
    8000754c:	9b9fd0ef          	jal	80004f04 <iput>

  end_op();
    80007550:	913fe0ef          	jal	80005e62 <end_op>

  return 0;
    80007554:	4781                	li	a5,0
    80007556:	a091                	j	8000759a <sys_link+0x162>
    goto bad;
    80007558:	0001                	nop

bad:
  ilock(ip);
    8000755a:	fe843503          	ld	a0,-24(s0)
    8000755e:	83dfd0ef          	jal	80004d9a <ilock>
  ip->nlink--;
    80007562:	fe843783          	ld	a5,-24(s0)
    80007566:	04a79783          	lh	a5,74(a5)
    8000756a:	17c2                	slli	a5,a5,0x30
    8000756c:	93c1                	srli	a5,a5,0x30
    8000756e:	37fd                	addiw	a5,a5,-1
    80007570:	17c2                	slli	a5,a5,0x30
    80007572:	93c1                	srli	a5,a5,0x30
    80007574:	0107971b          	slliw	a4,a5,0x10
    80007578:	4107571b          	sraiw	a4,a4,0x10
    8000757c:	fe843783          	ld	a5,-24(s0)
    80007580:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007584:	fe843503          	ld	a0,-24(s0)
    80007588:	deafd0ef          	jal	80004b72 <iupdate>
  iunlockput(ip);
    8000758c:	fe843503          	ld	a0,-24(s0)
    80007590:	a23fd0ef          	jal	80004fb2 <iunlockput>
  end_op();
    80007594:	8cffe0ef          	jal	80005e62 <end_op>
  return -1;
    80007598:	57fd                	li	a5,-1
}
    8000759a:	853e                	mv	a0,a5
    8000759c:	70b2                	ld	ra,296(sp)
    8000759e:	7412                	ld	s0,288(sp)
    800075a0:	6155                	addi	sp,sp,304
    800075a2:	8082                	ret

00000000800075a4 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    800075a4:	7139                	addi	sp,sp,-64
    800075a6:	fc06                	sd	ra,56(sp)
    800075a8:	f822                	sd	s0,48(sp)
    800075aa:	0080                	addi	s0,sp,64
    800075ac:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800075b0:	02000793          	li	a5,32
    800075b4:	fef42623          	sw	a5,-20(s0)
    800075b8:	a091                	j	800075fc <isdirempty+0x58>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800075ba:	fd840793          	addi	a5,s0,-40
    800075be:	fec42683          	lw	a3,-20(s0)
    800075c2:	4741                	li	a4,16
    800075c4:	863e                	mv	a2,a5
    800075c6:	4581                	li	a1,0
    800075c8:	fc843503          	ld	a0,-56(s0)
    800075cc:	de5fd0ef          	jal	800053b0 <readi>
    800075d0:	87aa                	mv	a5,a0
    800075d2:	873e                	mv	a4,a5
    800075d4:	47c1                	li	a5,16
    800075d6:	00f70863          	beq	a4,a5,800075e6 <isdirempty+0x42>
      panic("isdirempty: readi");
    800075da:	00003517          	auipc	a0,0x3
    800075de:	04650513          	addi	a0,a0,70 # 8000a620 <etext+0x620>
    800075e2:	855f90ef          	jal	80000e36 <panic>
    if(de.inum != 0)
    800075e6:	fd845783          	lhu	a5,-40(s0)
    800075ea:	c399                	beqz	a5,800075f0 <isdirempty+0x4c>
      return 0;
    800075ec:	4781                	li	a5,0
    800075ee:	a839                	j	8000760c <isdirempty+0x68>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800075f0:	fec42783          	lw	a5,-20(s0)
    800075f4:	27c1                	addiw	a5,a5,16
    800075f6:	2781                	sext.w	a5,a5
    800075f8:	fef42623          	sw	a5,-20(s0)
    800075fc:	fc843783          	ld	a5,-56(s0)
    80007600:	47f8                	lw	a4,76(a5)
    80007602:	fec42783          	lw	a5,-20(s0)
    80007606:	fae7eae3          	bltu	a5,a4,800075ba <isdirempty+0x16>
  }
  return 1;
    8000760a:	4785                	li	a5,1
}
    8000760c:	853e                	mv	a0,a5
    8000760e:	70e2                	ld	ra,56(sp)
    80007610:	7442                	ld	s0,48(sp)
    80007612:	6121                	addi	sp,sp,64
    80007614:	8082                	ret

0000000080007616 <sys_unlink>:

uint64
sys_unlink(void)
{
    80007616:	7155                	addi	sp,sp,-208
    80007618:	e586                	sd	ra,200(sp)
    8000761a:	e1a2                	sd	s0,192(sp)
    8000761c:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    8000761e:	f4040793          	addi	a5,s0,-192
    80007622:	08000613          	li	a2,128
    80007626:	85be                	mv	a1,a5
    80007628:	4501                	li	a0,0
    8000762a:	86dfc0ef          	jal	80003e96 <argstr>
    8000762e:	87aa                	mv	a5,a0
    80007630:	0007d463          	bgez	a5,80007638 <sys_unlink+0x22>
    return -1;
    80007634:	57fd                	li	a5,-1
    80007636:	a271                	j	800077c2 <sys_unlink+0x1ac>

  begin_op();
    80007638:	f78fe0ef          	jal	80005db0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000763c:	fc040713          	addi	a4,s0,-64
    80007640:	f4040793          	addi	a5,s0,-192
    80007644:	85ba                	mv	a1,a4
    80007646:	853e                	mv	a0,a5
    80007648:	c6efe0ef          	jal	80005ab6 <nameiparent>
    8000764c:	fea43423          	sd	a0,-24(s0)
    80007650:	fe843783          	ld	a5,-24(s0)
    80007654:	e789                	bnez	a5,8000765e <sys_unlink+0x48>
    end_op();
    80007656:	80dfe0ef          	jal	80005e62 <end_op>
    return -1;
    8000765a:	57fd                	li	a5,-1
    8000765c:	a29d                	j	800077c2 <sys_unlink+0x1ac>
  }

  ilock(dp);
    8000765e:	fe843503          	ld	a0,-24(s0)
    80007662:	f38fd0ef          	jal	80004d9a <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80007666:	fc040793          	addi	a5,s0,-64
    8000766a:	00003597          	auipc	a1,0x3
    8000766e:	fce58593          	addi	a1,a1,-50 # 8000a638 <etext+0x638>
    80007672:	853e                	mv	a0,a5
    80007674:	862fe0ef          	jal	800056d6 <namecmp>
    80007678:	87aa                	mv	a5,a0
    8000767a:	12078a63          	beqz	a5,800077ae <sys_unlink+0x198>
    8000767e:	fc040793          	addi	a5,s0,-64
    80007682:	00003597          	auipc	a1,0x3
    80007686:	fbe58593          	addi	a1,a1,-66 # 8000a640 <etext+0x640>
    8000768a:	853e                	mv	a0,a5
    8000768c:	84afe0ef          	jal	800056d6 <namecmp>
    80007690:	87aa                	mv	a5,a0
    80007692:	10078e63          	beqz	a5,800077ae <sys_unlink+0x198>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80007696:	f3c40713          	addi	a4,s0,-196
    8000769a:	fc040793          	addi	a5,s0,-64
    8000769e:	863a                	mv	a2,a4
    800076a0:	85be                	mv	a1,a5
    800076a2:	fe843503          	ld	a0,-24(s0)
    800076a6:	85afe0ef          	jal	80005700 <dirlookup>
    800076aa:	fea43023          	sd	a0,-32(s0)
    800076ae:	fe043783          	ld	a5,-32(s0)
    800076b2:	10078063          	beqz	a5,800077b2 <sys_unlink+0x19c>
    goto bad;
  ilock(ip);
    800076b6:	fe043503          	ld	a0,-32(s0)
    800076ba:	ee0fd0ef          	jal	80004d9a <ilock>

  if(ip->nlink < 1)
    800076be:	fe043783          	ld	a5,-32(s0)
    800076c2:	04a79783          	lh	a5,74(a5)
    800076c6:	00f04863          	bgtz	a5,800076d6 <sys_unlink+0xc0>
    panic("unlink: nlink < 1");
    800076ca:	00003517          	auipc	a0,0x3
    800076ce:	f7e50513          	addi	a0,a0,-130 # 8000a648 <etext+0x648>
    800076d2:	f64f90ef          	jal	80000e36 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800076d6:	fe043783          	ld	a5,-32(s0)
    800076da:	04479703          	lh	a4,68(a5)
    800076de:	4785                	li	a5,1
    800076e0:	00f71d63          	bne	a4,a5,800076fa <sys_unlink+0xe4>
    800076e4:	fe043503          	ld	a0,-32(s0)
    800076e8:	ebdff0ef          	jal	800075a4 <isdirempty>
    800076ec:	87aa                	mv	a5,a0
    800076ee:	e791                	bnez	a5,800076fa <sys_unlink+0xe4>
    iunlockput(ip);
    800076f0:	fe043503          	ld	a0,-32(s0)
    800076f4:	8bffd0ef          	jal	80004fb2 <iunlockput>
    goto bad;
    800076f8:	a875                	j	800077b4 <sys_unlink+0x19e>
  }

  memset(&de, 0, sizeof(de));
    800076fa:	fd040793          	addi	a5,s0,-48
    800076fe:	4641                	li	a2,16
    80007700:	4581                	li	a1,0
    80007702:	853e                	mv	a0,a5
    80007704:	dd3f90ef          	jal	800014d6 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007708:	fd040793          	addi	a5,s0,-48
    8000770c:	f3c42683          	lw	a3,-196(s0)
    80007710:	4741                	li	a4,16
    80007712:	863e                	mv	a2,a5
    80007714:	4581                	li	a1,0
    80007716:	fe843503          	ld	a0,-24(s0)
    8000771a:	e1ffd0ef          	jal	80005538 <writei>
    8000771e:	87aa                	mv	a5,a0
    80007720:	873e                	mv	a4,a5
    80007722:	47c1                	li	a5,16
    80007724:	00f70863          	beq	a4,a5,80007734 <sys_unlink+0x11e>
    panic("unlink: writei");
    80007728:	00003517          	auipc	a0,0x3
    8000772c:	f3850513          	addi	a0,a0,-200 # 8000a660 <etext+0x660>
    80007730:	f06f90ef          	jal	80000e36 <panic>
  if(ip->type == T_DIR){
    80007734:	fe043783          	ld	a5,-32(s0)
    80007738:	04479703          	lh	a4,68(a5)
    8000773c:	4785                	li	a5,1
    8000773e:	02f71763          	bne	a4,a5,8000776c <sys_unlink+0x156>
    dp->nlink--;
    80007742:	fe843783          	ld	a5,-24(s0)
    80007746:	04a79783          	lh	a5,74(a5)
    8000774a:	17c2                	slli	a5,a5,0x30
    8000774c:	93c1                	srli	a5,a5,0x30
    8000774e:	37fd                	addiw	a5,a5,-1
    80007750:	17c2                	slli	a5,a5,0x30
    80007752:	93c1                	srli	a5,a5,0x30
    80007754:	0107971b          	slliw	a4,a5,0x10
    80007758:	4107571b          	sraiw	a4,a4,0x10
    8000775c:	fe843783          	ld	a5,-24(s0)
    80007760:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80007764:	fe843503          	ld	a0,-24(s0)
    80007768:	c0afd0ef          	jal	80004b72 <iupdate>
  }
  iunlockput(dp);
    8000776c:	fe843503          	ld	a0,-24(s0)
    80007770:	843fd0ef          	jal	80004fb2 <iunlockput>

  ip->nlink--;
    80007774:	fe043783          	ld	a5,-32(s0)
    80007778:	04a79783          	lh	a5,74(a5)
    8000777c:	17c2                	slli	a5,a5,0x30
    8000777e:	93c1                	srli	a5,a5,0x30
    80007780:	37fd                	addiw	a5,a5,-1
    80007782:	17c2                	slli	a5,a5,0x30
    80007784:	93c1                	srli	a5,a5,0x30
    80007786:	0107971b          	slliw	a4,a5,0x10
    8000778a:	4107571b          	sraiw	a4,a4,0x10
    8000778e:	fe043783          	ld	a5,-32(s0)
    80007792:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007796:	fe043503          	ld	a0,-32(s0)
    8000779a:	bd8fd0ef          	jal	80004b72 <iupdate>
  iunlockput(ip);
    8000779e:	fe043503          	ld	a0,-32(s0)
    800077a2:	811fd0ef          	jal	80004fb2 <iunlockput>

  end_op();
    800077a6:	ebcfe0ef          	jal	80005e62 <end_op>

  return 0;
    800077aa:	4781                	li	a5,0
    800077ac:	a819                	j	800077c2 <sys_unlink+0x1ac>
    goto bad;
    800077ae:	0001                	nop
    800077b0:	a011                	j	800077b4 <sys_unlink+0x19e>
    goto bad;
    800077b2:	0001                	nop

bad:
  iunlockput(dp);
    800077b4:	fe843503          	ld	a0,-24(s0)
    800077b8:	ffafd0ef          	jal	80004fb2 <iunlockput>
  end_op();
    800077bc:	ea6fe0ef          	jal	80005e62 <end_op>
  return -1;
    800077c0:	57fd                	li	a5,-1
}
    800077c2:	853e                	mv	a0,a5
    800077c4:	60ae                	ld	ra,200(sp)
    800077c6:	640e                	ld	s0,192(sp)
    800077c8:	6169                	addi	sp,sp,208
    800077ca:	8082                	ret

00000000800077cc <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    800077cc:	7139                	addi	sp,sp,-64
    800077ce:	fc06                	sd	ra,56(sp)
    800077d0:	f822                	sd	s0,48(sp)
    800077d2:	0080                	addi	s0,sp,64
    800077d4:	fca43423          	sd	a0,-56(s0)
    800077d8:	87ae                	mv	a5,a1
    800077da:	8736                	mv	a4,a3
    800077dc:	fcf41323          	sh	a5,-58(s0)
    800077e0:	87b2                	mv	a5,a2
    800077e2:	fcf41223          	sh	a5,-60(s0)
    800077e6:	87ba                	mv	a5,a4
    800077e8:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800077ec:	fd040793          	addi	a5,s0,-48
    800077f0:	85be                	mv	a1,a5
    800077f2:	fc843503          	ld	a0,-56(s0)
    800077f6:	ac0fe0ef          	jal	80005ab6 <nameiparent>
    800077fa:	fea43423          	sd	a0,-24(s0)
    800077fe:	fe843783          	ld	a5,-24(s0)
    80007802:	e399                	bnez	a5,80007808 <create+0x3c>
    return 0;
    80007804:	4781                	li	a5,0
    80007806:	aa79                	j	800079a4 <create+0x1d8>

  ilock(dp);
    80007808:	fe843503          	ld	a0,-24(s0)
    8000780c:	d8efd0ef          	jal	80004d9a <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80007810:	fd040793          	addi	a5,s0,-48
    80007814:	4601                	li	a2,0
    80007816:	85be                	mv	a1,a5
    80007818:	fe843503          	ld	a0,-24(s0)
    8000781c:	ee5fd0ef          	jal	80005700 <dirlookup>
    80007820:	fea43023          	sd	a0,-32(s0)
    80007824:	fe043783          	ld	a5,-32(s0)
    80007828:	c7b9                	beqz	a5,80007876 <create+0xaa>
    iunlockput(dp);
    8000782a:	fe843503          	ld	a0,-24(s0)
    8000782e:	f84fd0ef          	jal	80004fb2 <iunlockput>
    ilock(ip);
    80007832:	fe043503          	ld	a0,-32(s0)
    80007836:	d64fd0ef          	jal	80004d9a <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000783a:	fc641783          	lh	a5,-58(s0)
    8000783e:	0007871b          	sext.w	a4,a5
    80007842:	4789                	li	a5,2
    80007844:	02f71363          	bne	a4,a5,8000786a <create+0x9e>
    80007848:	fe043783          	ld	a5,-32(s0)
    8000784c:	04479703          	lh	a4,68(a5)
    80007850:	4789                	li	a5,2
    80007852:	00f70963          	beq	a4,a5,80007864 <create+0x98>
    80007856:	fe043783          	ld	a5,-32(s0)
    8000785a:	04479703          	lh	a4,68(a5)
    8000785e:	478d                	li	a5,3
    80007860:	00f71563          	bne	a4,a5,8000786a <create+0x9e>
      return ip;
    80007864:	fe043783          	ld	a5,-32(s0)
    80007868:	aa35                	j	800079a4 <create+0x1d8>
    iunlockput(ip);
    8000786a:	fe043503          	ld	a0,-32(s0)
    8000786e:	f44fd0ef          	jal	80004fb2 <iunlockput>
    return 0;
    80007872:	4781                	li	a5,0
    80007874:	aa05                	j	800079a4 <create+0x1d8>
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    80007876:	fe843783          	ld	a5,-24(s0)
    8000787a:	439c                	lw	a5,0(a5)
    8000787c:	fc641703          	lh	a4,-58(s0)
    80007880:	85ba                	mv	a1,a4
    80007882:	853e                	mv	a0,a5
    80007884:	a0cfd0ef          	jal	80004a90 <ialloc>
    80007888:	fea43023          	sd	a0,-32(s0)
    8000788c:	fe043783          	ld	a5,-32(s0)
    80007890:	e799                	bnez	a5,8000789e <create+0xd2>
    iunlockput(dp);
    80007892:	fe843503          	ld	a0,-24(s0)
    80007896:	f1cfd0ef          	jal	80004fb2 <iunlockput>
    return 0;
    8000789a:	4781                	li	a5,0
    8000789c:	a221                	j	800079a4 <create+0x1d8>
  }

  ilock(ip);
    8000789e:	fe043503          	ld	a0,-32(s0)
    800078a2:	cf8fd0ef          	jal	80004d9a <ilock>
  ip->major = major;
    800078a6:	fe043783          	ld	a5,-32(s0)
    800078aa:	fc445703          	lhu	a4,-60(s0)
    800078ae:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    800078b2:	fe043783          	ld	a5,-32(s0)
    800078b6:	fc245703          	lhu	a4,-62(s0)
    800078ba:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    800078be:	fe043783          	ld	a5,-32(s0)
    800078c2:	4705                	li	a4,1
    800078c4:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800078c8:	fe043503          	ld	a0,-32(s0)
    800078cc:	aa6fd0ef          	jal	80004b72 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    800078d0:	fc641783          	lh	a5,-58(s0)
    800078d4:	0007871b          	sext.w	a4,a5
    800078d8:	4785                	li	a5,1
    800078da:	04f71063          	bne	a4,a5,8000791a <create+0x14e>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800078de:	fe043783          	ld	a5,-32(s0)
    800078e2:	43dc                	lw	a5,4(a5)
    800078e4:	863e                	mv	a2,a5
    800078e6:	00003597          	auipc	a1,0x3
    800078ea:	d5258593          	addi	a1,a1,-686 # 8000a638 <etext+0x638>
    800078ee:	fe043503          	ld	a0,-32(s0)
    800078f2:	edffd0ef          	jal	800057d0 <dirlink>
    800078f6:	87aa                	mv	a5,a0
    800078f8:	0807c263          	bltz	a5,8000797c <create+0x1b0>
    800078fc:	fe843783          	ld	a5,-24(s0)
    80007900:	43dc                	lw	a5,4(a5)
    80007902:	863e                	mv	a2,a5
    80007904:	00003597          	auipc	a1,0x3
    80007908:	d3c58593          	addi	a1,a1,-708 # 8000a640 <etext+0x640>
    8000790c:	fe043503          	ld	a0,-32(s0)
    80007910:	ec1fd0ef          	jal	800057d0 <dirlink>
    80007914:	87aa                	mv	a5,a0
    80007916:	0607c363          	bltz	a5,8000797c <create+0x1b0>
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    8000791a:	fe043783          	ld	a5,-32(s0)
    8000791e:	43d8                	lw	a4,4(a5)
    80007920:	fd040793          	addi	a5,s0,-48
    80007924:	863a                	mv	a2,a4
    80007926:	85be                	mv	a1,a5
    80007928:	fe843503          	ld	a0,-24(s0)
    8000792c:	ea5fd0ef          	jal	800057d0 <dirlink>
    80007930:	87aa                	mv	a5,a0
    80007932:	0407c763          	bltz	a5,80007980 <create+0x1b4>
    goto fail;

  if(type == T_DIR){
    80007936:	fc641783          	lh	a5,-58(s0)
    8000793a:	0007871b          	sext.w	a4,a5
    8000793e:	4785                	li	a5,1
    80007940:	02f71763          	bne	a4,a5,8000796e <create+0x1a2>
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    80007944:	fe843783          	ld	a5,-24(s0)
    80007948:	04a79783          	lh	a5,74(a5)
    8000794c:	17c2                	slli	a5,a5,0x30
    8000794e:	93c1                	srli	a5,a5,0x30
    80007950:	2785                	addiw	a5,a5,1
    80007952:	17c2                	slli	a5,a5,0x30
    80007954:	93c1                	srli	a5,a5,0x30
    80007956:	0107971b          	slliw	a4,a5,0x10
    8000795a:	4107571b          	sraiw	a4,a4,0x10
    8000795e:	fe843783          	ld	a5,-24(s0)
    80007962:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80007966:	fe843503          	ld	a0,-24(s0)
    8000796a:	a08fd0ef          	jal	80004b72 <iupdate>
  }

  iunlockput(dp);
    8000796e:	fe843503          	ld	a0,-24(s0)
    80007972:	e40fd0ef          	jal	80004fb2 <iunlockput>

  return ip;
    80007976:	fe043783          	ld	a5,-32(s0)
    8000797a:	a02d                	j	800079a4 <create+0x1d8>
      goto fail;
    8000797c:	0001                	nop
    8000797e:	a011                	j	80007982 <create+0x1b6>
    goto fail;
    80007980:	0001                	nop

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
    80007982:	fe043783          	ld	a5,-32(s0)
    80007986:	04079523          	sh	zero,74(a5)
  iupdate(ip);
    8000798a:	fe043503          	ld	a0,-32(s0)
    8000798e:	9e4fd0ef          	jal	80004b72 <iupdate>
  iunlockput(ip);
    80007992:	fe043503          	ld	a0,-32(s0)
    80007996:	e1cfd0ef          	jal	80004fb2 <iunlockput>
  iunlockput(dp);
    8000799a:	fe843503          	ld	a0,-24(s0)
    8000799e:	e14fd0ef          	jal	80004fb2 <iunlockput>
  return 0;
    800079a2:	4781                	li	a5,0
}
    800079a4:	853e                	mv	a0,a5
    800079a6:	70e2                	ld	ra,56(sp)
    800079a8:	7442                	ld	s0,48(sp)
    800079aa:	6121                	addi	sp,sp,64
    800079ac:	8082                	ret

00000000800079ae <sys_open>:

uint64
sys_open(void)
{
    800079ae:	7131                	addi	sp,sp,-192
    800079b0:	fd06                	sd	ra,184(sp)
    800079b2:	f922                	sd	s0,176(sp)
    800079b4:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    800079b6:	f4c40793          	addi	a5,s0,-180
    800079ba:	85be                	mv	a1,a5
    800079bc:	4505                	li	a0,1
    800079be:	c78fc0ef          	jal	80003e36 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800079c2:	f5040793          	addi	a5,s0,-176
    800079c6:	08000613          	li	a2,128
    800079ca:	85be                	mv	a1,a5
    800079cc:	4501                	li	a0,0
    800079ce:	cc8fc0ef          	jal	80003e96 <argstr>
    800079d2:	87aa                	mv	a5,a0
    800079d4:	fef42223          	sw	a5,-28(s0)
    800079d8:	fe442783          	lw	a5,-28(s0)
    800079dc:	2781                	sext.w	a5,a5
    800079de:	0007d463          	bgez	a5,800079e6 <sys_open+0x38>
    return -1;
    800079e2:	57fd                	li	a5,-1
    800079e4:	a275                	j	80007b90 <sys_open+0x1e2>

  begin_op();
    800079e6:	bcafe0ef          	jal	80005db0 <begin_op>

  if(omode & O_CREATE){
    800079ea:	f4c42783          	lw	a5,-180(s0)
    800079ee:	2007f793          	andi	a5,a5,512
    800079f2:	2781                	sext.w	a5,a5
    800079f4:	c395                	beqz	a5,80007a18 <sys_open+0x6a>
    ip = create(path, T_FILE, 0, 0);
    800079f6:	f5040793          	addi	a5,s0,-176
    800079fa:	4681                	li	a3,0
    800079fc:	4601                	li	a2,0
    800079fe:	4589                	li	a1,2
    80007a00:	853e                	mv	a0,a5
    80007a02:	dcbff0ef          	jal	800077cc <create>
    80007a06:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80007a0a:	fe843783          	ld	a5,-24(s0)
    80007a0e:	eba9                	bnez	a5,80007a60 <sys_open+0xb2>
      end_op();
    80007a10:	c52fe0ef          	jal	80005e62 <end_op>
      return -1;
    80007a14:	57fd                	li	a5,-1
    80007a16:	aaad                	j	80007b90 <sys_open+0x1e2>
    }
  } else {
    if((ip = namei(path)) == 0){
    80007a18:	f5040793          	addi	a5,s0,-176
    80007a1c:	853e                	mv	a0,a5
    80007a1e:	870fe0ef          	jal	80005a8e <namei>
    80007a22:	fea43423          	sd	a0,-24(s0)
    80007a26:	fe843783          	ld	a5,-24(s0)
    80007a2a:	e789                	bnez	a5,80007a34 <sys_open+0x86>
      end_op();
    80007a2c:	c36fe0ef          	jal	80005e62 <end_op>
      return -1;
    80007a30:	57fd                	li	a5,-1
    80007a32:	aab9                	j	80007b90 <sys_open+0x1e2>
    }
    ilock(ip);
    80007a34:	fe843503          	ld	a0,-24(s0)
    80007a38:	b62fd0ef          	jal	80004d9a <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80007a3c:	fe843783          	ld	a5,-24(s0)
    80007a40:	04479703          	lh	a4,68(a5)
    80007a44:	4785                	li	a5,1
    80007a46:	00f71d63          	bne	a4,a5,80007a60 <sys_open+0xb2>
    80007a4a:	f4c42783          	lw	a5,-180(s0)
    80007a4e:	cb89                	beqz	a5,80007a60 <sys_open+0xb2>
      iunlockput(ip);
    80007a50:	fe843503          	ld	a0,-24(s0)
    80007a54:	d5efd0ef          	jal	80004fb2 <iunlockput>
      end_op();
    80007a58:	c0afe0ef          	jal	80005e62 <end_op>
      return -1;
    80007a5c:	57fd                	li	a5,-1
    80007a5e:	aa0d                	j	80007b90 <sys_open+0x1e2>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80007a60:	fe843783          	ld	a5,-24(s0)
    80007a64:	04479703          	lh	a4,68(a5)
    80007a68:	478d                	li	a5,3
    80007a6a:	02f71763          	bne	a4,a5,80007a98 <sys_open+0xea>
    80007a6e:	fe843783          	ld	a5,-24(s0)
    80007a72:	04679783          	lh	a5,70(a5)
    80007a76:	0007c963          	bltz	a5,80007a88 <sys_open+0xda>
    80007a7a:	fe843783          	ld	a5,-24(s0)
    80007a7e:	04679703          	lh	a4,70(a5)
    80007a82:	47a5                	li	a5,9
    80007a84:	00e7da63          	bge	a5,a4,80007a98 <sys_open+0xea>
    iunlockput(ip);
    80007a88:	fe843503          	ld	a0,-24(s0)
    80007a8c:	d26fd0ef          	jal	80004fb2 <iunlockput>
    end_op();
    80007a90:	bd2fe0ef          	jal	80005e62 <end_op>
    return -1;
    80007a94:	57fd                	li	a5,-1
    80007a96:	a8ed                	j	80007b90 <sys_open+0x1e2>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80007a98:	801fe0ef          	jal	80006298 <filealloc>
    80007a9c:	fca43c23          	sd	a0,-40(s0)
    80007aa0:	fd843783          	ld	a5,-40(s0)
    80007aa4:	cf89                	beqz	a5,80007abe <sys_open+0x110>
    80007aa6:	fd843503          	ld	a0,-40(s0)
    80007aaa:	f84ff0ef          	jal	8000722e <fdalloc>
    80007aae:	87aa                	mv	a5,a0
    80007ab0:	fcf42a23          	sw	a5,-44(s0)
    80007ab4:	fd442783          	lw	a5,-44(s0)
    80007ab8:	2781                	sext.w	a5,a5
    80007aba:	0207d163          	bgez	a5,80007adc <sys_open+0x12e>
    if(f)
    80007abe:	fd843783          	ld	a5,-40(s0)
    80007ac2:	c789                	beqz	a5,80007acc <sys_open+0x11e>
      fileclose(f);
    80007ac4:	fd843503          	ld	a0,-40(s0)
    80007ac8:	8a3fe0ef          	jal	8000636a <fileclose>
    iunlockput(ip);
    80007acc:	fe843503          	ld	a0,-24(s0)
    80007ad0:	ce2fd0ef          	jal	80004fb2 <iunlockput>
    end_op();
    80007ad4:	b8efe0ef          	jal	80005e62 <end_op>
    return -1;
    80007ad8:	57fd                	li	a5,-1
    80007ada:	a85d                	j	80007b90 <sys_open+0x1e2>
  }

  if(ip->type == T_DEVICE){
    80007adc:	fe843783          	ld	a5,-24(s0)
    80007ae0:	04479703          	lh	a4,68(a5)
    80007ae4:	478d                	li	a5,3
    80007ae6:	00f71f63          	bne	a4,a5,80007b04 <sys_open+0x156>
    f->type = FD_DEVICE;
    80007aea:	fd843783          	ld	a5,-40(s0)
    80007aee:	470d                	li	a4,3
    80007af0:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80007af2:	fe843783          	ld	a5,-24(s0)
    80007af6:	04679703          	lh	a4,70(a5)
    80007afa:	fd843783          	ld	a5,-40(s0)
    80007afe:	02e79223          	sh	a4,36(a5)
    80007b02:	a809                	j	80007b14 <sys_open+0x166>
  } else {
    f->type = FD_INODE;
    80007b04:	fd843783          	ld	a5,-40(s0)
    80007b08:	4709                	li	a4,2
    80007b0a:	c398                	sw	a4,0(a5)
    f->off = 0;
    80007b0c:	fd843783          	ld	a5,-40(s0)
    80007b10:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80007b14:	fd843783          	ld	a5,-40(s0)
    80007b18:	fe843703          	ld	a4,-24(s0)
    80007b1c:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80007b1e:	f4c42783          	lw	a5,-180(s0)
    80007b22:	8b85                	andi	a5,a5,1
    80007b24:	2781                	sext.w	a5,a5
    80007b26:	0017b793          	seqz	a5,a5
    80007b2a:	0ff7f793          	zext.b	a5,a5
    80007b2e:	873e                	mv	a4,a5
    80007b30:	fd843783          	ld	a5,-40(s0)
    80007b34:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80007b38:	f4c42783          	lw	a5,-180(s0)
    80007b3c:	8b85                	andi	a5,a5,1
    80007b3e:	2781                	sext.w	a5,a5
    80007b40:	e791                	bnez	a5,80007b4c <sys_open+0x19e>
    80007b42:	f4c42783          	lw	a5,-180(s0)
    80007b46:	8b89                	andi	a5,a5,2
    80007b48:	2781                	sext.w	a5,a5
    80007b4a:	c399                	beqz	a5,80007b50 <sys_open+0x1a2>
    80007b4c:	4785                	li	a5,1
    80007b4e:	a011                	j	80007b52 <sys_open+0x1a4>
    80007b50:	4781                	li	a5,0
    80007b52:	0ff7f713          	zext.b	a4,a5
    80007b56:	fd843783          	ld	a5,-40(s0)
    80007b5a:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80007b5e:	f4c42783          	lw	a5,-180(s0)
    80007b62:	4007f793          	andi	a5,a5,1024
    80007b66:	2781                	sext.w	a5,a5
    80007b68:	cf81                	beqz	a5,80007b80 <sys_open+0x1d2>
    80007b6a:	fe843783          	ld	a5,-24(s0)
    80007b6e:	04479703          	lh	a4,68(a5)
    80007b72:	4789                	li	a5,2
    80007b74:	00f71663          	bne	a4,a5,80007b80 <sys_open+0x1d2>
    itrunc(ip);
    80007b78:	fe843503          	ld	a0,-24(s0)
    80007b7c:	ea4fd0ef          	jal	80005220 <itrunc>
  }

  iunlock(ip);
    80007b80:	fe843503          	ld	a0,-24(s0)
    80007b84:	b32fd0ef          	jal	80004eb6 <iunlock>
  end_op();
    80007b88:	adafe0ef          	jal	80005e62 <end_op>

  return fd;
    80007b8c:	fd442783          	lw	a5,-44(s0)
}
    80007b90:	853e                	mv	a0,a5
    80007b92:	70ea                	ld	ra,184(sp)
    80007b94:	744a                	ld	s0,176(sp)
    80007b96:	6129                	addi	sp,sp,192
    80007b98:	8082                	ret

0000000080007b9a <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80007b9a:	7135                	addi	sp,sp,-160
    80007b9c:	ed06                	sd	ra,152(sp)
    80007b9e:	e922                	sd	s0,144(sp)
    80007ba0:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80007ba2:	a0efe0ef          	jal	80005db0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80007ba6:	f6840793          	addi	a5,s0,-152
    80007baa:	08000613          	li	a2,128
    80007bae:	85be                	mv	a1,a5
    80007bb0:	4501                	li	a0,0
    80007bb2:	ae4fc0ef          	jal	80003e96 <argstr>
    80007bb6:	87aa                	mv	a5,a0
    80007bb8:	0007cf63          	bltz	a5,80007bd6 <sys_mkdir+0x3c>
    80007bbc:	f6840793          	addi	a5,s0,-152
    80007bc0:	4681                	li	a3,0
    80007bc2:	4601                	li	a2,0
    80007bc4:	4585                	li	a1,1
    80007bc6:	853e                	mv	a0,a5
    80007bc8:	c05ff0ef          	jal	800077cc <create>
    80007bcc:	fea43423          	sd	a0,-24(s0)
    80007bd0:	fe843783          	ld	a5,-24(s0)
    80007bd4:	e789                	bnez	a5,80007bde <sys_mkdir+0x44>
    end_op();
    80007bd6:	a8cfe0ef          	jal	80005e62 <end_op>
    return -1;
    80007bda:	57fd                	li	a5,-1
    80007bdc:	a801                	j	80007bec <sys_mkdir+0x52>
  }
  iunlockput(ip);
    80007bde:	fe843503          	ld	a0,-24(s0)
    80007be2:	bd0fd0ef          	jal	80004fb2 <iunlockput>
  end_op();
    80007be6:	a7cfe0ef          	jal	80005e62 <end_op>
  return 0;
    80007bea:	4781                	li	a5,0
}
    80007bec:	853e                	mv	a0,a5
    80007bee:	60ea                	ld	ra,152(sp)
    80007bf0:	644a                	ld	s0,144(sp)
    80007bf2:	610d                	addi	sp,sp,160
    80007bf4:	8082                	ret

0000000080007bf6 <sys_mknod>:

uint64
sys_mknod(void)
{
    80007bf6:	7135                	addi	sp,sp,-160
    80007bf8:	ed06                	sd	ra,152(sp)
    80007bfa:	e922                	sd	s0,144(sp)
    80007bfc:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80007bfe:	9b2fe0ef          	jal	80005db0 <begin_op>
  argint(1, &major);
    80007c02:	f6440793          	addi	a5,s0,-156
    80007c06:	85be                	mv	a1,a5
    80007c08:	4505                	li	a0,1
    80007c0a:	a2cfc0ef          	jal	80003e36 <argint>
  argint(2, &minor);
    80007c0e:	f6040793          	addi	a5,s0,-160
    80007c12:	85be                	mv	a1,a5
    80007c14:	4509                	li	a0,2
    80007c16:	a20fc0ef          	jal	80003e36 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80007c1a:	f6840793          	addi	a5,s0,-152
    80007c1e:	08000613          	li	a2,128
    80007c22:	85be                	mv	a1,a5
    80007c24:	4501                	li	a0,0
    80007c26:	a70fc0ef          	jal	80003e96 <argstr>
    80007c2a:	87aa                	mv	a5,a0
    80007c2c:	0207ca63          	bltz	a5,80007c60 <sys_mknod+0x6a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80007c30:	f6442783          	lw	a5,-156(s0)
    80007c34:	0107971b          	slliw	a4,a5,0x10
    80007c38:	4107571b          	sraiw	a4,a4,0x10
    80007c3c:	f6042783          	lw	a5,-160(s0)
    80007c40:	0107969b          	slliw	a3,a5,0x10
    80007c44:	4106d69b          	sraiw	a3,a3,0x10
    80007c48:	f6840793          	addi	a5,s0,-152
    80007c4c:	863a                	mv	a2,a4
    80007c4e:	458d                	li	a1,3
    80007c50:	853e                	mv	a0,a5
    80007c52:	b7bff0ef          	jal	800077cc <create>
    80007c56:	fea43423          	sd	a0,-24(s0)
  if((argstr(0, path, MAXPATH)) < 0 ||
    80007c5a:	fe843783          	ld	a5,-24(s0)
    80007c5e:	e789                	bnez	a5,80007c68 <sys_mknod+0x72>
    end_op();
    80007c60:	a02fe0ef          	jal	80005e62 <end_op>
    return -1;
    80007c64:	57fd                	li	a5,-1
    80007c66:	a801                	j	80007c76 <sys_mknod+0x80>
  }
  iunlockput(ip);
    80007c68:	fe843503          	ld	a0,-24(s0)
    80007c6c:	b46fd0ef          	jal	80004fb2 <iunlockput>
  end_op();
    80007c70:	9f2fe0ef          	jal	80005e62 <end_op>
  return 0;
    80007c74:	4781                	li	a5,0
}
    80007c76:	853e                	mv	a0,a5
    80007c78:	60ea                	ld	ra,152(sp)
    80007c7a:	644a                	ld	s0,144(sp)
    80007c7c:	610d                	addi	sp,sp,160
    80007c7e:	8082                	ret

0000000080007c80 <sys_chdir>:

uint64
sys_chdir(void)
{
    80007c80:	7135                	addi	sp,sp,-160
    80007c82:	ed06                	sd	ra,152(sp)
    80007c84:	e922                	sd	s0,144(sp)
    80007c86:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80007c88:	bcdfa0ef          	jal	80002854 <myproc>
    80007c8c:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80007c90:	920fe0ef          	jal	80005db0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80007c94:	f6040793          	addi	a5,s0,-160
    80007c98:	08000613          	li	a2,128
    80007c9c:	85be                	mv	a1,a5
    80007c9e:	4501                	li	a0,0
    80007ca0:	9f6fc0ef          	jal	80003e96 <argstr>
    80007ca4:	87aa                	mv	a5,a0
    80007ca6:	0007cc63          	bltz	a5,80007cbe <sys_chdir+0x3e>
    80007caa:	f6040793          	addi	a5,s0,-160
    80007cae:	853e                	mv	a0,a5
    80007cb0:	ddffd0ef          	jal	80005a8e <namei>
    80007cb4:	fea43023          	sd	a0,-32(s0)
    80007cb8:	fe043783          	ld	a5,-32(s0)
    80007cbc:	e789                	bnez	a5,80007cc6 <sys_chdir+0x46>
    end_op();
    80007cbe:	9a4fe0ef          	jal	80005e62 <end_op>
    return -1;
    80007cc2:	57fd                	li	a5,-1
    80007cc4:	a881                	j	80007d14 <sys_chdir+0x94>
  }
  ilock(ip);
    80007cc6:	fe043503          	ld	a0,-32(s0)
    80007cca:	8d0fd0ef          	jal	80004d9a <ilock>
  if(ip->type != T_DIR){
    80007cce:	fe043783          	ld	a5,-32(s0)
    80007cd2:	04479703          	lh	a4,68(a5)
    80007cd6:	4785                	li	a5,1
    80007cd8:	00f70a63          	beq	a4,a5,80007cec <sys_chdir+0x6c>
    iunlockput(ip);
    80007cdc:	fe043503          	ld	a0,-32(s0)
    80007ce0:	ad2fd0ef          	jal	80004fb2 <iunlockput>
    end_op();
    80007ce4:	97efe0ef          	jal	80005e62 <end_op>
    return -1;
    80007ce8:	57fd                	li	a5,-1
    80007cea:	a02d                	j	80007d14 <sys_chdir+0x94>
  }
  iunlock(ip);
    80007cec:	fe043503          	ld	a0,-32(s0)
    80007cf0:	9c6fd0ef          	jal	80004eb6 <iunlock>
  iput(p->cwd);
    80007cf4:	fe843783          	ld	a5,-24(s0)
    80007cf8:	1507b783          	ld	a5,336(a5)
    80007cfc:	853e                	mv	a0,a5
    80007cfe:	a06fd0ef          	jal	80004f04 <iput>
  end_op();
    80007d02:	960fe0ef          	jal	80005e62 <end_op>
  p->cwd = ip;
    80007d06:	fe843783          	ld	a5,-24(s0)
    80007d0a:	fe043703          	ld	a4,-32(s0)
    80007d0e:	14e7b823          	sd	a4,336(a5)
  return 0;
    80007d12:	4781                	li	a5,0
}
    80007d14:	853e                	mv	a0,a5
    80007d16:	60ea                	ld	ra,152(sp)
    80007d18:	644a                	ld	s0,144(sp)
    80007d1a:	610d                	addi	sp,sp,160
    80007d1c:	8082                	ret

0000000080007d1e <sys_exec>:

uint64
sys_exec(void)
{
    80007d1e:	7161                	addi	sp,sp,-432
    80007d20:	f706                	sd	ra,424(sp)
    80007d22:	f322                	sd	s0,416(sp)
    80007d24:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80007d26:	e6040793          	addi	a5,s0,-416
    80007d2a:	85be                	mv	a1,a5
    80007d2c:	4505                	li	a0,1
    80007d2e:	93afc0ef          	jal	80003e68 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80007d32:	f6840793          	addi	a5,s0,-152
    80007d36:	08000613          	li	a2,128
    80007d3a:	85be                	mv	a1,a5
    80007d3c:	4501                	li	a0,0
    80007d3e:	958fc0ef          	jal	80003e96 <argstr>
    80007d42:	87aa                	mv	a5,a0
    80007d44:	0007d463          	bgez	a5,80007d4c <sys_exec+0x2e>
    return -1;
    80007d48:	57fd                	li	a5,-1
    80007d4a:	aa89                	j	80007e9c <sys_exec+0x17e>
  }
  memset(argv, 0, sizeof(argv));
    80007d4c:	e6840793          	addi	a5,s0,-408
    80007d50:	10000613          	li	a2,256
    80007d54:	4581                	li	a1,0
    80007d56:	853e                	mv	a0,a5
    80007d58:	f7ef90ef          	jal	800014d6 <memset>
  for(i=0;; i++){
    80007d5c:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80007d60:	fec42703          	lw	a4,-20(s0)
    80007d64:	47fd                	li	a5,31
    80007d66:	0ee7e463          	bltu	a5,a4,80007e4e <sys_exec+0x130>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80007d6a:	fec42783          	lw	a5,-20(s0)
    80007d6e:	00379713          	slli	a4,a5,0x3
    80007d72:	e6043783          	ld	a5,-416(s0)
    80007d76:	97ba                	add	a5,a5,a4
    80007d78:	e5840713          	addi	a4,s0,-424
    80007d7c:	85ba                	mv	a1,a4
    80007d7e:	853e                	mv	a0,a5
    80007d80:	f61fb0ef          	jal	80003ce0 <fetchaddr>
    80007d84:	87aa                	mv	a5,a0
    80007d86:	0c07c663          	bltz	a5,80007e52 <sys_exec+0x134>
      goto bad;
    }
    if(uarg == 0){
    80007d8a:	e5843783          	ld	a5,-424(s0)
    80007d8e:	eb85                	bnez	a5,80007dbe <sys_exec+0xa0>
      argv[i] = 0;
    80007d90:	fec42703          	lw	a4,-20(s0)
    80007d94:	e6840793          	addi	a5,s0,-408
    80007d98:	070e                	slli	a4,a4,0x3
    80007d9a:	97ba                	add	a5,a5,a4
    80007d9c:	0007b023          	sd	zero,0(a5)
      break;
    80007da0:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = kexec(path, argv);
    80007da2:	e6840713          	addi	a4,s0,-408
    80007da6:	f6840793          	addi	a5,s0,-152
    80007daa:	85ba                	mv	a1,a4
    80007dac:	853e                	mv	a0,a5
    80007dae:	ed5fe0ef          	jal	80006c82 <kexec>
    80007db2:	87aa                	mv	a5,a0
    80007db4:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007db8:	fe042623          	sw	zero,-20(s0)
    80007dbc:	a88d                	j	80007e2e <sys_exec+0x110>
    argv[i] = kalloc();
    80007dbe:	c4cf90ef          	jal	8000120a <kalloc>
    80007dc2:	86aa                	mv	a3,a0
    80007dc4:	fec42703          	lw	a4,-20(s0)
    80007dc8:	e6840793          	addi	a5,s0,-408
    80007dcc:	070e                	slli	a4,a4,0x3
    80007dce:	97ba                	add	a5,a5,a4
    80007dd0:	e394                	sd	a3,0(a5)
    if(argv[i] == 0)
    80007dd2:	fec42703          	lw	a4,-20(s0)
    80007dd6:	e6840793          	addi	a5,s0,-408
    80007dda:	070e                	slli	a4,a4,0x3
    80007ddc:	97ba                	add	a5,a5,a4
    80007dde:	639c                	ld	a5,0(a5)
    80007de0:	cbbd                	beqz	a5,80007e56 <sys_exec+0x138>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80007de2:	e5843683          	ld	a3,-424(s0)
    80007de6:	fec42703          	lw	a4,-20(s0)
    80007dea:	e6840793          	addi	a5,s0,-408
    80007dee:	070e                	slli	a4,a4,0x3
    80007df0:	97ba                	add	a5,a5,a4
    80007df2:	639c                	ld	a5,0(a5)
    80007df4:	6605                	lui	a2,0x1
    80007df6:	85be                	mv	a1,a5
    80007df8:	8536                	mv	a0,a3
    80007dfa:	f4dfb0ef          	jal	80003d46 <fetchstr>
    80007dfe:	87aa                	mv	a5,a0
    80007e00:	0407cd63          	bltz	a5,80007e5a <sys_exec+0x13c>
  for(i=0;; i++){
    80007e04:	fec42783          	lw	a5,-20(s0)
    80007e08:	2785                	addiw	a5,a5,1
    80007e0a:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    80007e0e:	bf89                	j	80007d60 <sys_exec+0x42>
    kfree(argv[i]);
    80007e10:	fec42703          	lw	a4,-20(s0)
    80007e14:	e6840793          	addi	a5,s0,-408
    80007e18:	070e                	slli	a4,a4,0x3
    80007e1a:	97ba                	add	a5,a5,a4
    80007e1c:	639c                	ld	a5,0(a5)
    80007e1e:	853e                	mv	a0,a5
    80007e20:	b56f90ef          	jal	80001176 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007e24:	fec42783          	lw	a5,-20(s0)
    80007e28:	2785                	addiw	a5,a5,1
    80007e2a:	fef42623          	sw	a5,-20(s0)
    80007e2e:	fec42703          	lw	a4,-20(s0)
    80007e32:	47fd                	li	a5,31
    80007e34:	00e7ea63          	bltu	a5,a4,80007e48 <sys_exec+0x12a>
    80007e38:	fec42703          	lw	a4,-20(s0)
    80007e3c:	e6840793          	addi	a5,s0,-408
    80007e40:	070e                	slli	a4,a4,0x3
    80007e42:	97ba                	add	a5,a5,a4
    80007e44:	639c                	ld	a5,0(a5)
    80007e46:	f7e9                	bnez	a5,80007e10 <sys_exec+0xf2>

  return ret;
    80007e48:	fe842783          	lw	a5,-24(s0)
    80007e4c:	a881                	j	80007e9c <sys_exec+0x17e>
      goto bad;
    80007e4e:	0001                	nop
    80007e50:	a031                	j	80007e5c <sys_exec+0x13e>
      goto bad;
    80007e52:	0001                	nop
    80007e54:	a021                	j	80007e5c <sys_exec+0x13e>
      goto bad;
    80007e56:	0001                	nop
    80007e58:	a011                	j	80007e5c <sys_exec+0x13e>
      goto bad;
    80007e5a:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007e5c:	fe042623          	sw	zero,-20(s0)
    80007e60:	a005                	j	80007e80 <sys_exec+0x162>
    kfree(argv[i]);
    80007e62:	fec42703          	lw	a4,-20(s0)
    80007e66:	e6840793          	addi	a5,s0,-408
    80007e6a:	070e                	slli	a4,a4,0x3
    80007e6c:	97ba                	add	a5,a5,a4
    80007e6e:	639c                	ld	a5,0(a5)
    80007e70:	853e                	mv	a0,a5
    80007e72:	b04f90ef          	jal	80001176 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007e76:	fec42783          	lw	a5,-20(s0)
    80007e7a:	2785                	addiw	a5,a5,1
    80007e7c:	fef42623          	sw	a5,-20(s0)
    80007e80:	fec42703          	lw	a4,-20(s0)
    80007e84:	47fd                	li	a5,31
    80007e86:	00e7ea63          	bltu	a5,a4,80007e9a <sys_exec+0x17c>
    80007e8a:	fec42703          	lw	a4,-20(s0)
    80007e8e:	e6840793          	addi	a5,s0,-408
    80007e92:	070e                	slli	a4,a4,0x3
    80007e94:	97ba                	add	a5,a5,a4
    80007e96:	639c                	ld	a5,0(a5)
    80007e98:	f7e9                	bnez	a5,80007e62 <sys_exec+0x144>
  return -1;
    80007e9a:	57fd                	li	a5,-1
}
    80007e9c:	853e                	mv	a0,a5
    80007e9e:	70ba                	ld	ra,424(sp)
    80007ea0:	741a                	ld	s0,416(sp)
    80007ea2:	615d                	addi	sp,sp,432
    80007ea4:	8082                	ret

0000000080007ea6 <sys_pipe>:

uint64
sys_pipe(void)
{
    80007ea6:	7139                	addi	sp,sp,-64
    80007ea8:	fc06                	sd	ra,56(sp)
    80007eaa:	f822                	sd	s0,48(sp)
    80007eac:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80007eae:	9a7fa0ef          	jal	80002854 <myproc>
    80007eb2:	fea43423          	sd	a0,-24(s0)

  argaddr(0, &fdarray);
    80007eb6:	fe040793          	addi	a5,s0,-32
    80007eba:	85be                	mv	a1,a5
    80007ebc:	4501                	li	a0,0
    80007ebe:	fabfb0ef          	jal	80003e68 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80007ec2:	fd040713          	addi	a4,s0,-48
    80007ec6:	fd840793          	addi	a5,s0,-40
    80007eca:	85ba                	mv	a1,a4
    80007ecc:	853e                	mv	a0,a5
    80007ece:	931fe0ef          	jal	800067fe <pipealloc>
    80007ed2:	87aa                	mv	a5,a0
    80007ed4:	0007d463          	bgez	a5,80007edc <sys_pipe+0x36>
    return -1;
    80007ed8:	57fd                	li	a5,-1
    80007eda:	a0dd                	j	80007fc0 <sys_pipe+0x11a>
  fd0 = -1;
    80007edc:	57fd                	li	a5,-1
    80007ede:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80007ee2:	fd843783          	ld	a5,-40(s0)
    80007ee6:	853e                	mv	a0,a5
    80007ee8:	b46ff0ef          	jal	8000722e <fdalloc>
    80007eec:	87aa                	mv	a5,a0
    80007eee:	fcf42623          	sw	a5,-52(s0)
    80007ef2:	fcc42783          	lw	a5,-52(s0)
    80007ef6:	0007ce63          	bltz	a5,80007f12 <sys_pipe+0x6c>
    80007efa:	fd043783          	ld	a5,-48(s0)
    80007efe:	853e                	mv	a0,a5
    80007f00:	b2eff0ef          	jal	8000722e <fdalloc>
    80007f04:	87aa                	mv	a5,a0
    80007f06:	fcf42423          	sw	a5,-56(s0)
    80007f0a:	fc842783          	lw	a5,-56(s0)
    80007f0e:	0207db63          	bgez	a5,80007f44 <sys_pipe+0x9e>
    if(fd0 >= 0)
    80007f12:	fcc42783          	lw	a5,-52(s0)
    80007f16:	0007cb63          	bltz	a5,80007f2c <sys_pipe+0x86>
      p->ofile[fd0] = 0;
    80007f1a:	fcc42783          	lw	a5,-52(s0)
    80007f1e:	fe843703          	ld	a4,-24(s0)
    80007f22:	07e9                	addi	a5,a5,26
    80007f24:	078e                	slli	a5,a5,0x3
    80007f26:	97ba                	add	a5,a5,a4
    80007f28:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80007f2c:	fd843783          	ld	a5,-40(s0)
    80007f30:	853e                	mv	a0,a5
    80007f32:	c38fe0ef          	jal	8000636a <fileclose>
    fileclose(wf);
    80007f36:	fd043783          	ld	a5,-48(s0)
    80007f3a:	853e                	mv	a0,a5
    80007f3c:	c2efe0ef          	jal	8000636a <fileclose>
    return -1;
    80007f40:	57fd                	li	a5,-1
    80007f42:	a8bd                	j	80007fc0 <sys_pipe+0x11a>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80007f44:	fe843783          	ld	a5,-24(s0)
    80007f48:	6bbc                	ld	a5,80(a5)
    80007f4a:	fe043703          	ld	a4,-32(s0)
    80007f4e:	fcc40613          	addi	a2,s0,-52
    80007f52:	4691                	li	a3,4
    80007f54:	85ba                	mv	a1,a4
    80007f56:	853e                	mv	a0,a5
    80007f58:	a8afa0ef          	jal	800021e2 <copyout>
    80007f5c:	87aa                	mv	a5,a0
    80007f5e:	0207c263          	bltz	a5,80007f82 <sys_pipe+0xdc>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80007f62:	fe843783          	ld	a5,-24(s0)
    80007f66:	6bb8                	ld	a4,80(a5)
    80007f68:	fe043783          	ld	a5,-32(s0)
    80007f6c:	0791                	addi	a5,a5,4
    80007f6e:	fc840613          	addi	a2,s0,-56
    80007f72:	4691                	li	a3,4
    80007f74:	85be                	mv	a1,a5
    80007f76:	853a                	mv	a0,a4
    80007f78:	a6afa0ef          	jal	800021e2 <copyout>
    80007f7c:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80007f7e:	0407d063          	bgez	a5,80007fbe <sys_pipe+0x118>
    p->ofile[fd0] = 0;
    80007f82:	fcc42783          	lw	a5,-52(s0)
    80007f86:	fe843703          	ld	a4,-24(s0)
    80007f8a:	07e9                	addi	a5,a5,26
    80007f8c:	078e                	slli	a5,a5,0x3
    80007f8e:	97ba                	add	a5,a5,a4
    80007f90:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80007f94:	fc842783          	lw	a5,-56(s0)
    80007f98:	fe843703          	ld	a4,-24(s0)
    80007f9c:	07e9                	addi	a5,a5,26
    80007f9e:	078e                	slli	a5,a5,0x3
    80007fa0:	97ba                	add	a5,a5,a4
    80007fa2:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80007fa6:	fd843783          	ld	a5,-40(s0)
    80007faa:	853e                	mv	a0,a5
    80007fac:	bbefe0ef          	jal	8000636a <fileclose>
    fileclose(wf);
    80007fb0:	fd043783          	ld	a5,-48(s0)
    80007fb4:	853e                	mv	a0,a5
    80007fb6:	bb4fe0ef          	jal	8000636a <fileclose>
    return -1;
    80007fba:	57fd                	li	a5,-1
    80007fbc:	a011                	j	80007fc0 <sys_pipe+0x11a>
  }
  return 0;
    80007fbe:	4781                	li	a5,0
}
    80007fc0:	853e                	mv	a0,a5
    80007fc2:	70e2                	ld	ra,56(sp)
    80007fc4:	7442                	ld	s0,48(sp)
    80007fc6:	6121                	addi	sp,sp,64
    80007fc8:	8082                	ret
    80007fca:	0000                	unimp
    80007fcc:	0000                	unimp
	...

0000000080007fd0 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80007fd0:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80007fd2:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80007fd4:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80007fd6:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80007fd8:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    80007fda:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    80007fdc:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    80007fde:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80007fe0:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80007fe2:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80007fe4:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80007fe6:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80007fe8:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    80007fea:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    80007fec:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    80007fee:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80007ff0:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80007ff2:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80007ff4:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80007ff6:	b17fb0ef          	jal	80003b0c <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    80007ffa:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    80007ffc:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    80007ffe:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80008000:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80008002:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80008004:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80008006:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80008008:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000800a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000800c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000800e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80008010:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80008012:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80008014:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80008016:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80008018:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000801a:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    8000801c:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    8000801e:	10200073          	sret
	...

000000008000802e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000802e:	1141                	addi	sp,sp,-16
    80008030:	e406                	sd	ra,8(sp)
    80008032:	e022                	sd	s0,0(sp)
    80008034:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80008036:	0c0007b7          	lui	a5,0xc000
    8000803a:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    8000803e:	4705                	li	a4,1
    80008040:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80008042:	0c0007b7          	lui	a5,0xc000
    80008046:	0791                	addi	a5,a5,4 # c000004 <_entry-0x73fffffc>
    80008048:	4705                	li	a4,1
    8000804a:	c398                	sw	a4,0(a5)
}
    8000804c:	0001                	nop
    8000804e:	60a2                	ld	ra,8(sp)
    80008050:	6402                	ld	s0,0(sp)
    80008052:	0141                	addi	sp,sp,16
    80008054:	8082                	ret

0000000080008056 <plicinithart>:

void
plicinithart(void)
{
    80008056:	1101                	addi	sp,sp,-32
    80008058:	ec06                	sd	ra,24(sp)
    8000805a:	e822                	sd	s0,16(sp)
    8000805c:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000805e:	fa0fa0ef          	jal	800027fe <cpuid>
    80008062:	87aa                	mv	a5,a0
    80008064:	fef42623          	sw	a5,-20(s0)
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80008068:	fec42783          	lw	a5,-20(s0)
    8000806c:	0087979b          	slliw	a5,a5,0x8
    80008070:	2781                	sext.w	a5,a5
    80008072:	873e                	mv	a4,a5
    80008074:	0c0027b7          	lui	a5,0xc002
    80008078:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    8000807c:	97ba                	add	a5,a5,a4
    8000807e:	873e                	mv	a4,a5
    80008080:	40200793          	li	a5,1026
    80008084:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80008086:	fec42783          	lw	a5,-20(s0)
    8000808a:	00d7979b          	slliw	a5,a5,0xd
    8000808e:	2781                	sext.w	a5,a5
    80008090:	873e                	mv	a4,a5
    80008092:	0c2017b7          	lui	a5,0xc201
    80008096:	97ba                	add	a5,a5,a4
    80008098:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    8000809c:	0001                	nop
    8000809e:	60e2                	ld	ra,24(sp)
    800080a0:	6442                	ld	s0,16(sp)
    800080a2:	6105                	addi	sp,sp,32
    800080a4:	8082                	ret

00000000800080a6 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800080a6:	1101                	addi	sp,sp,-32
    800080a8:	ec06                	sd	ra,24(sp)
    800080aa:	e822                	sd	s0,16(sp)
    800080ac:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800080ae:	f50fa0ef          	jal	800027fe <cpuid>
    800080b2:	87aa                	mv	a5,a0
    800080b4:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800080b8:	fec42783          	lw	a5,-20(s0)
    800080bc:	00d7979b          	slliw	a5,a5,0xd
    800080c0:	2781                	sext.w	a5,a5
    800080c2:	873e                	mv	a4,a5
    800080c4:	0c2017b7          	lui	a5,0xc201
    800080c8:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    800080ca:	97ba                	add	a5,a5,a4
    800080cc:	439c                	lw	a5,0(a5)
    800080ce:	fef42423          	sw	a5,-24(s0)
  return irq;
    800080d2:	fe842783          	lw	a5,-24(s0)
}
    800080d6:	853e                	mv	a0,a5
    800080d8:	60e2                	ld	ra,24(sp)
    800080da:	6442                	ld	s0,16(sp)
    800080dc:	6105                	addi	sp,sp,32
    800080de:	8082                	ret

00000000800080e0 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800080e0:	7179                	addi	sp,sp,-48
    800080e2:	f406                	sd	ra,40(sp)
    800080e4:	f022                	sd	s0,32(sp)
    800080e6:	1800                	addi	s0,sp,48
    800080e8:	87aa                	mv	a5,a0
    800080ea:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    800080ee:	f10fa0ef          	jal	800027fe <cpuid>
    800080f2:	87aa                	mv	a5,a0
    800080f4:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800080f8:	fec42783          	lw	a5,-20(s0)
    800080fc:	00d7979b          	slliw	a5,a5,0xd
    80008100:	2781                	sext.w	a5,a5
    80008102:	873e                	mv	a4,a5
    80008104:	0c2017b7          	lui	a5,0xc201
    80008108:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    8000810a:	97ba                	add	a5,a5,a4
    8000810c:	873e                	mv	a4,a5
    8000810e:	fdc42783          	lw	a5,-36(s0)
    80008112:	c31c                	sw	a5,0(a4)
}
    80008114:	0001                	nop
    80008116:	70a2                	ld	ra,40(sp)
    80008118:	7402                	ld	s0,32(sp)
    8000811a:	6145                	addi	sp,sp,48
    8000811c:	8082                	ret

000000008000811e <virtio_disk_init>:
  
} disk;

void
virtio_disk_init(void)
{
    8000811e:	7179                	addi	sp,sp,-48
    80008120:	f406                	sd	ra,40(sp)
    80008122:	f022                	sd	s0,32(sp)
    80008124:	1800                	addi	s0,sp,48
  uint32 status = 0;
    80008126:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    8000812a:	00002597          	auipc	a1,0x2
    8000812e:	54658593          	addi	a1,a1,1350 # 8000a670 <etext+0x670>
    80008132:	0001c517          	auipc	a0,0x1c
    80008136:	a6e50513          	addi	a0,a0,-1426 # 80023ba0 <disk+0x128>
    8000813a:	9dcf90ef          	jal	80001316 <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000813e:	100017b7          	lui	a5,0x10001
    80008142:	439c                	lw	a5,0(a5)
    80008144:	0007871b          	sext.w	a4,a5
    80008148:	747277b7          	lui	a5,0x74727
    8000814c:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80008150:	04f71063          	bne	a4,a5,80008190 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80008154:	100017b7          	lui	a5,0x10001
    80008158:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    8000815a:	439c                	lw	a5,0(a5)
    8000815c:	0007871b          	sext.w	a4,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008160:	4789                	li	a5,2
    80008162:	02f71763          	bne	a4,a5,80008190 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008166:	100017b7          	lui	a5,0x10001
    8000816a:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    8000816c:	439c                	lw	a5,0(a5)
    8000816e:	0007871b          	sext.w	a4,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80008172:	4789                	li	a5,2
    80008174:	00f71e63          	bne	a4,a5,80008190 <virtio_disk_init+0x72>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008178:	100017b7          	lui	a5,0x10001
    8000817c:	07b1                	addi	a5,a5,12 # 1000100c <_entry-0x6fffeff4>
    8000817e:	439c                	lw	a5,0(a5)
    80008180:	0007871b          	sext.w	a4,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008184:	554d47b7          	lui	a5,0x554d4
    80008188:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000818c:	00f70863          	beq	a4,a5,8000819c <virtio_disk_init+0x7e>
    panic("could not find virtio disk");
    80008190:	00002517          	auipc	a0,0x2
    80008194:	4f050513          	addi	a0,a0,1264 # 8000a680 <etext+0x680>
    80008198:	c9ff80ef          	jal	80000e36 <panic>
  }
  
  // reset device
  *R(VIRTIO_MMIO_STATUS) = status;
    8000819c:	100017b7          	lui	a5,0x10001
    800081a0:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800081a4:	fe842703          	lw	a4,-24(s0)
    800081a8:	c398                	sw	a4,0(a5)

  // set ACKNOWLEDGE status bit
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    800081aa:	fe842783          	lw	a5,-24(s0)
    800081ae:	0017e793          	ori	a5,a5,1
    800081b2:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    800081b6:	100017b7          	lui	a5,0x10001
    800081ba:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800081be:	fe842703          	lw	a4,-24(s0)
    800081c2:	c398                	sw	a4,0(a5)

  // set DRIVER status bit
  status |= VIRTIO_CONFIG_S_DRIVER;
    800081c4:	fe842783          	lw	a5,-24(s0)
    800081c8:	0027e793          	ori	a5,a5,2
    800081cc:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    800081d0:	100017b7          	lui	a5,0x10001
    800081d4:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800081d8:	fe842703          	lw	a4,-24(s0)
    800081dc:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800081de:	100017b7          	lui	a5,0x10001
    800081e2:	07c1                	addi	a5,a5,16 # 10001010 <_entry-0x6fffeff0>
    800081e4:	439c                	lw	a5,0(a5)
    800081e6:	2781                	sext.w	a5,a5
    800081e8:	1782                	slli	a5,a5,0x20
    800081ea:	9381                	srli	a5,a5,0x20
    800081ec:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    800081f0:	fe043783          	ld	a5,-32(s0)
    800081f4:	fdf7f793          	andi	a5,a5,-33
    800081f8:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    800081fc:	fe043783          	ld	a5,-32(s0)
    80008200:	f7f7f793          	andi	a5,a5,-129
    80008204:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80008208:	fe043703          	ld	a4,-32(s0)
    8000820c:	77fd                	lui	a5,0xfffff
    8000820e:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffdbc47>
    80008212:	8ff9                	and	a5,a5,a4
    80008214:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80008218:	fe043703          	ld	a4,-32(s0)
    8000821c:	77fd                	lui	a5,0xfffff
    8000821e:	17fd                	addi	a5,a5,-1 # ffffffffffffefff <end+0xffffffff7ffdb447>
    80008220:	8ff9                	and	a5,a5,a4
    80008222:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80008226:	fe043703          	ld	a4,-32(s0)
    8000822a:	f80007b7          	lui	a5,0xf8000
    8000822e:	17fd                	addi	a5,a5,-1 # fffffffff7ffffff <end+0xffffffff77fdc447>
    80008230:	8ff9                	and	a5,a5,a4
    80008232:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80008236:	fe043703          	ld	a4,-32(s0)
    8000823a:	e00007b7          	lui	a5,0xe0000
    8000823e:	17fd                	addi	a5,a5,-1 # ffffffffdfffffff <end+0xffffffff5ffdc447>
    80008240:	8ff9                	and	a5,a5,a4
    80008242:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80008246:	fe043703          	ld	a4,-32(s0)
    8000824a:	f00007b7          	lui	a5,0xf0000
    8000824e:	17fd                	addi	a5,a5,-1 # ffffffffefffffff <end+0xffffffff6ffdc447>
    80008250:	8ff9                	and	a5,a5,a4
    80008252:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80008256:	100017b7          	lui	a5,0x10001
    8000825a:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    8000825e:	fe043703          	ld	a4,-32(s0)
    80008262:	2701                	sext.w	a4,a4
    80008264:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008266:	fe842783          	lw	a5,-24(s0)
    8000826a:	0087e793          	ori	a5,a5,8
    8000826e:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008272:	100017b7          	lui	a5,0x10001
    80008276:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000827a:	fe842703          	lw	a4,-24(s0)
    8000827e:	c398                	sw	a4,0(a5)

  // re-read status to ensure FEATURES_OK is set.
  status = *R(VIRTIO_MMIO_STATUS);
    80008280:	100017b7          	lui	a5,0x10001
    80008284:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008288:	439c                	lw	a5,0(a5)
    8000828a:	fef42423          	sw	a5,-24(s0)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    8000828e:	fe842783          	lw	a5,-24(s0)
    80008292:	8ba1                	andi	a5,a5,8
    80008294:	2781                	sext.w	a5,a5
    80008296:	e799                	bnez	a5,800082a4 <virtio_disk_init+0x186>
    panic("virtio disk FEATURES_OK unset");
    80008298:	00002517          	auipc	a0,0x2
    8000829c:	40850513          	addi	a0,a0,1032 # 8000a6a0 <etext+0x6a0>
    800082a0:	b97f80ef          	jal	80000e36 <panic>

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800082a4:	100017b7          	lui	a5,0x10001
    800082a8:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    800082ac:	0007a023          	sw	zero,0(a5)

  // ensure queue 0 is not in use.
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800082b0:	100017b7          	lui	a5,0x10001
    800082b4:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    800082b8:	439c                	lw	a5,0(a5)
    800082ba:	2781                	sext.w	a5,a5
    800082bc:	c799                	beqz	a5,800082ca <virtio_disk_init+0x1ac>
    panic("virtio disk should not be ready");
    800082be:	00002517          	auipc	a0,0x2
    800082c2:	40250513          	addi	a0,a0,1026 # 8000a6c0 <etext+0x6c0>
    800082c6:	b71f80ef          	jal	80000e36 <panic>

  // check maximum queue size.
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800082ca:	100017b7          	lui	a5,0x10001
    800082ce:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    800082d2:	439c                	lw	a5,0(a5)
    800082d4:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    800082d8:	fdc42783          	lw	a5,-36(s0)
    800082dc:	2781                	sext.w	a5,a5
    800082de:	e799                	bnez	a5,800082ec <virtio_disk_init+0x1ce>
    panic("virtio disk has no queue 0");
    800082e0:	00002517          	auipc	a0,0x2
    800082e4:	40050513          	addi	a0,a0,1024 # 8000a6e0 <etext+0x6e0>
    800082e8:	b4ff80ef          	jal	80000e36 <panic>
  if(max < NUM)
    800082ec:	fdc42783          	lw	a5,-36(s0)
    800082f0:	0007871b          	sext.w	a4,a5
    800082f4:	479d                	li	a5,7
    800082f6:	00e7e863          	bltu	a5,a4,80008306 <virtio_disk_init+0x1e8>
    panic("virtio disk max queue too short");
    800082fa:	00002517          	auipc	a0,0x2
    800082fe:	40650513          	addi	a0,a0,1030 # 8000a700 <etext+0x700>
    80008302:	b35f80ef          	jal	80000e36 <panic>

  // allocate and zero queue memory.
  disk.desc = kalloc();
    80008306:	f05f80ef          	jal	8000120a <kalloc>
    8000830a:	872a                	mv	a4,a0
    8000830c:	0001b797          	auipc	a5,0x1b
    80008310:	76c78793          	addi	a5,a5,1900 # 80023a78 <disk>
    80008314:	e398                	sd	a4,0(a5)
  disk.avail = kalloc();
    80008316:	ef5f80ef          	jal	8000120a <kalloc>
    8000831a:	872a                	mv	a4,a0
    8000831c:	0001b797          	auipc	a5,0x1b
    80008320:	75c78793          	addi	a5,a5,1884 # 80023a78 <disk>
    80008324:	e798                	sd	a4,8(a5)
  disk.used = kalloc();
    80008326:	ee5f80ef          	jal	8000120a <kalloc>
    8000832a:	872a                	mv	a4,a0
    8000832c:	0001b797          	auipc	a5,0x1b
    80008330:	74c78793          	addi	a5,a5,1868 # 80023a78 <disk>
    80008334:	eb98                	sd	a4,16(a5)
  if(!disk.desc || !disk.avail || !disk.used)
    80008336:	0001b797          	auipc	a5,0x1b
    8000833a:	74278793          	addi	a5,a5,1858 # 80023a78 <disk>
    8000833e:	639c                	ld	a5,0(a5)
    80008340:	cf89                	beqz	a5,8000835a <virtio_disk_init+0x23c>
    80008342:	0001b797          	auipc	a5,0x1b
    80008346:	73678793          	addi	a5,a5,1846 # 80023a78 <disk>
    8000834a:	679c                	ld	a5,8(a5)
    8000834c:	c799                	beqz	a5,8000835a <virtio_disk_init+0x23c>
    8000834e:	0001b797          	auipc	a5,0x1b
    80008352:	72a78793          	addi	a5,a5,1834 # 80023a78 <disk>
    80008356:	6b9c                	ld	a5,16(a5)
    80008358:	e799                	bnez	a5,80008366 <virtio_disk_init+0x248>
    panic("virtio disk kalloc");
    8000835a:	00002517          	auipc	a0,0x2
    8000835e:	3c650513          	addi	a0,a0,966 # 8000a720 <etext+0x720>
    80008362:	ad5f80ef          	jal	80000e36 <panic>
  memset(disk.desc, 0, PGSIZE);
    80008366:	0001b797          	auipc	a5,0x1b
    8000836a:	71278793          	addi	a5,a5,1810 # 80023a78 <disk>
    8000836e:	639c                	ld	a5,0(a5)
    80008370:	6605                	lui	a2,0x1
    80008372:	4581                	li	a1,0
    80008374:	853e                	mv	a0,a5
    80008376:	960f90ef          	jal	800014d6 <memset>
  memset(disk.avail, 0, PGSIZE);
    8000837a:	0001b797          	auipc	a5,0x1b
    8000837e:	6fe78793          	addi	a5,a5,1790 # 80023a78 <disk>
    80008382:	679c                	ld	a5,8(a5)
    80008384:	6605                	lui	a2,0x1
    80008386:	4581                	li	a1,0
    80008388:	853e                	mv	a0,a5
    8000838a:	94cf90ef          	jal	800014d6 <memset>
  memset(disk.used, 0, PGSIZE);
    8000838e:	0001b797          	auipc	a5,0x1b
    80008392:	6ea78793          	addi	a5,a5,1770 # 80023a78 <disk>
    80008396:	6b9c                	ld	a5,16(a5)
    80008398:	6605                	lui	a2,0x1
    8000839a:	4581                	li	a1,0
    8000839c:	853e                	mv	a0,a5
    8000839e:	938f90ef          	jal	800014d6 <memset>

  // set queue size.
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800083a2:	100017b7          	lui	a5,0x10001
    800083a6:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    800083aa:	4721                	li	a4,8
    800083ac:	c398                	sw	a4,0(a5)

  // write physical addresses.
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800083ae:	0001b797          	auipc	a5,0x1b
    800083b2:	6ca78793          	addi	a5,a5,1738 # 80023a78 <disk>
    800083b6:	639c                	ld	a5,0(a5)
    800083b8:	873e                	mv	a4,a5
    800083ba:	100017b7          	lui	a5,0x10001
    800083be:	08078793          	addi	a5,a5,128 # 10001080 <_entry-0x6fffef80>
    800083c2:	2701                	sext.w	a4,a4
    800083c4:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800083c6:	0001b797          	auipc	a5,0x1b
    800083ca:	6b278793          	addi	a5,a5,1714 # 80023a78 <disk>
    800083ce:	639c                	ld	a5,0(a5)
    800083d0:	0207d713          	srli	a4,a5,0x20
    800083d4:	100017b7          	lui	a5,0x10001
    800083d8:	08478793          	addi	a5,a5,132 # 10001084 <_entry-0x6fffef7c>
    800083dc:	2701                	sext.w	a4,a4
    800083de:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800083e0:	0001b797          	auipc	a5,0x1b
    800083e4:	69878793          	addi	a5,a5,1688 # 80023a78 <disk>
    800083e8:	679c                	ld	a5,8(a5)
    800083ea:	873e                	mv	a4,a5
    800083ec:	100017b7          	lui	a5,0x10001
    800083f0:	09078793          	addi	a5,a5,144 # 10001090 <_entry-0x6fffef70>
    800083f4:	2701                	sext.w	a4,a4
    800083f6:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800083f8:	0001b797          	auipc	a5,0x1b
    800083fc:	68078793          	addi	a5,a5,1664 # 80023a78 <disk>
    80008400:	679c                	ld	a5,8(a5)
    80008402:	0207d713          	srli	a4,a5,0x20
    80008406:	100017b7          	lui	a5,0x10001
    8000840a:	09478793          	addi	a5,a5,148 # 10001094 <_entry-0x6fffef6c>
    8000840e:	2701                	sext.w	a4,a4
    80008410:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80008412:	0001b797          	auipc	a5,0x1b
    80008416:	66678793          	addi	a5,a5,1638 # 80023a78 <disk>
    8000841a:	6b9c                	ld	a5,16(a5)
    8000841c:	873e                	mv	a4,a5
    8000841e:	100017b7          	lui	a5,0x10001
    80008422:	0a078793          	addi	a5,a5,160 # 100010a0 <_entry-0x6fffef60>
    80008426:	2701                	sext.w	a4,a4
    80008428:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    8000842a:	0001b797          	auipc	a5,0x1b
    8000842e:	64e78793          	addi	a5,a5,1614 # 80023a78 <disk>
    80008432:	6b9c                	ld	a5,16(a5)
    80008434:	0207d713          	srli	a4,a5,0x20
    80008438:	100017b7          	lui	a5,0x10001
    8000843c:	0a478793          	addi	a5,a5,164 # 100010a4 <_entry-0x6fffef5c>
    80008440:	2701                	sext.w	a4,a4
    80008442:	c398                	sw	a4,0(a5)

  // queue is ready.
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80008444:	100017b7          	lui	a5,0x10001
    80008448:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    8000844c:	4705                	li	a4,1
    8000844e:	c398                	sw	a4,0(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    80008450:	fe042623          	sw	zero,-20(s0)
    80008454:	a005                	j	80008474 <virtio_disk_init+0x356>
    disk.free[i] = 1;
    80008456:	0001b717          	auipc	a4,0x1b
    8000845a:	62270713          	addi	a4,a4,1570 # 80023a78 <disk>
    8000845e:	fec42783          	lw	a5,-20(s0)
    80008462:	97ba                	add	a5,a5,a4
    80008464:	4705                	li	a4,1
    80008466:	00e78c23          	sb	a4,24(a5)
  for(int i = 0; i < NUM; i++)
    8000846a:	fec42783          	lw	a5,-20(s0)
    8000846e:	2785                	addiw	a5,a5,1
    80008470:	fef42623          	sw	a5,-20(s0)
    80008474:	fec42783          	lw	a5,-20(s0)
    80008478:	0007871b          	sext.w	a4,a5
    8000847c:	479d                	li	a5,7
    8000847e:	fce7dce3          	bge	a5,a4,80008456 <virtio_disk_init+0x338>

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80008482:	fe842783          	lw	a5,-24(s0)
    80008486:	0047e793          	ori	a5,a5,4
    8000848a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000848e:	100017b7          	lui	a5,0x10001
    80008492:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008496:	fe842703          	lw	a4,-24(s0)
    8000849a:	c398                	sw	a4,0(a5)

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    8000849c:	0001                	nop
    8000849e:	70a2                	ld	ra,40(sp)
    800084a0:	7402                	ld	s0,32(sp)
    800084a2:	6145                	addi	sp,sp,48
    800084a4:	8082                	ret

00000000800084a6 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    800084a6:	1101                	addi	sp,sp,-32
    800084a8:	ec06                	sd	ra,24(sp)
    800084aa:	e822                	sd	s0,16(sp)
    800084ac:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    800084ae:	fe042623          	sw	zero,-20(s0)
    800084b2:	a825                	j	800084ea <alloc_desc+0x44>
    if(disk.free[i]){
    800084b4:	0001b717          	auipc	a4,0x1b
    800084b8:	5c470713          	addi	a4,a4,1476 # 80023a78 <disk>
    800084bc:	fec42783          	lw	a5,-20(s0)
    800084c0:	97ba                	add	a5,a5,a4
    800084c2:	0187c783          	lbu	a5,24(a5)
    800084c6:	cf89                	beqz	a5,800084e0 <alloc_desc+0x3a>
      disk.free[i] = 0;
    800084c8:	0001b717          	auipc	a4,0x1b
    800084cc:	5b070713          	addi	a4,a4,1456 # 80023a78 <disk>
    800084d0:	fec42783          	lw	a5,-20(s0)
    800084d4:	97ba                	add	a5,a5,a4
    800084d6:	00078c23          	sb	zero,24(a5)
      return i;
    800084da:	fec42783          	lw	a5,-20(s0)
    800084de:	a831                	j	800084fa <alloc_desc+0x54>
  for(int i = 0; i < NUM; i++){
    800084e0:	fec42783          	lw	a5,-20(s0)
    800084e4:	2785                	addiw	a5,a5,1
    800084e6:	fef42623          	sw	a5,-20(s0)
    800084ea:	fec42783          	lw	a5,-20(s0)
    800084ee:	0007871b          	sext.w	a4,a5
    800084f2:	479d                	li	a5,7
    800084f4:	fce7d0e3          	bge	a5,a4,800084b4 <alloc_desc+0xe>
    }
  }
  return -1;
    800084f8:	57fd                	li	a5,-1
}
    800084fa:	853e                	mv	a0,a5
    800084fc:	60e2                	ld	ra,24(sp)
    800084fe:	6442                	ld	s0,16(sp)
    80008500:	6105                	addi	sp,sp,32
    80008502:	8082                	ret

0000000080008504 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    80008504:	1101                	addi	sp,sp,-32
    80008506:	ec06                	sd	ra,24(sp)
    80008508:	e822                	sd	s0,16(sp)
    8000850a:	1000                	addi	s0,sp,32
    8000850c:	87aa                	mv	a5,a0
    8000850e:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    80008512:	fec42783          	lw	a5,-20(s0)
    80008516:	0007871b          	sext.w	a4,a5
    8000851a:	479d                	li	a5,7
    8000851c:	00e7d863          	bge	a5,a4,8000852c <free_desc+0x28>
    panic("free_desc 1");
    80008520:	00002517          	auipc	a0,0x2
    80008524:	21850513          	addi	a0,a0,536 # 8000a738 <etext+0x738>
    80008528:	90ff80ef          	jal	80000e36 <panic>
  if(disk.free[i])
    8000852c:	0001b717          	auipc	a4,0x1b
    80008530:	54c70713          	addi	a4,a4,1356 # 80023a78 <disk>
    80008534:	fec42783          	lw	a5,-20(s0)
    80008538:	97ba                	add	a5,a5,a4
    8000853a:	0187c783          	lbu	a5,24(a5)
    8000853e:	c799                	beqz	a5,8000854c <free_desc+0x48>
    panic("free_desc 2");
    80008540:	00002517          	auipc	a0,0x2
    80008544:	20850513          	addi	a0,a0,520 # 8000a748 <etext+0x748>
    80008548:	8eff80ef          	jal	80000e36 <panic>
  disk.desc[i].addr = 0;
    8000854c:	0001b797          	auipc	a5,0x1b
    80008550:	52c78793          	addi	a5,a5,1324 # 80023a78 <disk>
    80008554:	6398                	ld	a4,0(a5)
    80008556:	fec42783          	lw	a5,-20(s0)
    8000855a:	0792                	slli	a5,a5,0x4
    8000855c:	97ba                	add	a5,a5,a4
    8000855e:	0007b023          	sd	zero,0(a5)
  disk.desc[i].len = 0;
    80008562:	0001b797          	auipc	a5,0x1b
    80008566:	51678793          	addi	a5,a5,1302 # 80023a78 <disk>
    8000856a:	6398                	ld	a4,0(a5)
    8000856c:	fec42783          	lw	a5,-20(s0)
    80008570:	0792                	slli	a5,a5,0x4
    80008572:	97ba                	add	a5,a5,a4
    80008574:	0007a423          	sw	zero,8(a5)
  disk.desc[i].flags = 0;
    80008578:	0001b797          	auipc	a5,0x1b
    8000857c:	50078793          	addi	a5,a5,1280 # 80023a78 <disk>
    80008580:	6398                	ld	a4,0(a5)
    80008582:	fec42783          	lw	a5,-20(s0)
    80008586:	0792                	slli	a5,a5,0x4
    80008588:	97ba                	add	a5,a5,a4
    8000858a:	00079623          	sh	zero,12(a5)
  disk.desc[i].next = 0;
    8000858e:	0001b797          	auipc	a5,0x1b
    80008592:	4ea78793          	addi	a5,a5,1258 # 80023a78 <disk>
    80008596:	6398                	ld	a4,0(a5)
    80008598:	fec42783          	lw	a5,-20(s0)
    8000859c:	0792                	slli	a5,a5,0x4
    8000859e:	97ba                	add	a5,a5,a4
    800085a0:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800085a4:	0001b717          	auipc	a4,0x1b
    800085a8:	4d470713          	addi	a4,a4,1236 # 80023a78 <disk>
    800085ac:	fec42783          	lw	a5,-20(s0)
    800085b0:	97ba                	add	a5,a5,a4
    800085b2:	4705                	li	a4,1
    800085b4:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800085b8:	0001b517          	auipc	a0,0x1b
    800085bc:	4d850513          	addi	a0,a0,1240 # 80023a90 <disk+0x18>
    800085c0:	d9bfa0ef          	jal	8000335a <wakeup>
}
    800085c4:	0001                	nop
    800085c6:	60e2                	ld	ra,24(sp)
    800085c8:	6442                	ld	s0,16(sp)
    800085ca:	6105                	addi	sp,sp,32
    800085cc:	8082                	ret

00000000800085ce <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    800085ce:	7179                	addi	sp,sp,-48
    800085d0:	f406                	sd	ra,40(sp)
    800085d2:	f022                	sd	s0,32(sp)
    800085d4:	1800                	addi	s0,sp,48
    800085d6:	87aa                	mv	a5,a0
    800085d8:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    800085dc:	0001b797          	auipc	a5,0x1b
    800085e0:	49c78793          	addi	a5,a5,1180 # 80023a78 <disk>
    800085e4:	6398                	ld	a4,0(a5)
    800085e6:	fdc42783          	lw	a5,-36(s0)
    800085ea:	0792                	slli	a5,a5,0x4
    800085ec:	97ba                	add	a5,a5,a4
    800085ee:	00c7d783          	lhu	a5,12(a5)
    800085f2:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800085f6:	0001b797          	auipc	a5,0x1b
    800085fa:	48278793          	addi	a5,a5,1154 # 80023a78 <disk>
    800085fe:	6398                	ld	a4,0(a5)
    80008600:	fdc42783          	lw	a5,-36(s0)
    80008604:	0792                	slli	a5,a5,0x4
    80008606:	97ba                	add	a5,a5,a4
    80008608:	00e7d783          	lhu	a5,14(a5)
    8000860c:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    80008610:	fdc42783          	lw	a5,-36(s0)
    80008614:	853e                	mv	a0,a5
    80008616:	eefff0ef          	jal	80008504 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000861a:	fec42783          	lw	a5,-20(s0)
    8000861e:	8b85                	andi	a5,a5,1
    80008620:	2781                	sext.w	a5,a5
    80008622:	c791                	beqz	a5,8000862e <free_chain+0x60>
      i = nxt;
    80008624:	fe842783          	lw	a5,-24(s0)
    80008628:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    8000862c:	bf45                	j	800085dc <free_chain+0xe>
    else
      break;
    8000862e:	0001                	nop
  }
}
    80008630:	0001                	nop
    80008632:	70a2                	ld	ra,40(sp)
    80008634:	7402                	ld	s0,32(sp)
    80008636:	6145                	addi	sp,sp,48
    80008638:	8082                	ret

000000008000863a <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    8000863a:	7139                	addi	sp,sp,-64
    8000863c:	fc06                	sd	ra,56(sp)
    8000863e:	f822                	sd	s0,48(sp)
    80008640:	f426                	sd	s1,40(sp)
    80008642:	0080                	addi	s0,sp,64
    80008644:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80008648:	fc042e23          	sw	zero,-36(s0)
    8000864c:	a0bd                	j	800086ba <alloc3_desc+0x80>
    idx[i] = alloc_desc();
    8000864e:	fdc42783          	lw	a5,-36(s0)
    80008652:	078a                	slli	a5,a5,0x2
    80008654:	fc843703          	ld	a4,-56(s0)
    80008658:	00f704b3          	add	s1,a4,a5
    8000865c:	e4bff0ef          	jal	800084a6 <alloc_desc>
    80008660:	87aa                	mv	a5,a0
    80008662:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80008664:	fdc42783          	lw	a5,-36(s0)
    80008668:	078a                	slli	a5,a5,0x2
    8000866a:	fc843703          	ld	a4,-56(s0)
    8000866e:	97ba                	add	a5,a5,a4
    80008670:	439c                	lw	a5,0(a5)
    80008672:	0207df63          	bgez	a5,800086b0 <alloc3_desc+0x76>
      for(int j = 0; j < i; j++)
    80008676:	fc042c23          	sw	zero,-40(s0)
    8000867a:	a005                	j	8000869a <alloc3_desc+0x60>
        free_desc(idx[j]);
    8000867c:	fd842783          	lw	a5,-40(s0)
    80008680:	078a                	slli	a5,a5,0x2
    80008682:	fc843703          	ld	a4,-56(s0)
    80008686:	97ba                	add	a5,a5,a4
    80008688:	439c                	lw	a5,0(a5)
    8000868a:	853e                	mv	a0,a5
    8000868c:	e79ff0ef          	jal	80008504 <free_desc>
      for(int j = 0; j < i; j++)
    80008690:	fd842783          	lw	a5,-40(s0)
    80008694:	2785                	addiw	a5,a5,1
    80008696:	fcf42c23          	sw	a5,-40(s0)
    8000869a:	fd842783          	lw	a5,-40(s0)
    8000869e:	873e                	mv	a4,a5
    800086a0:	fdc42783          	lw	a5,-36(s0)
    800086a4:	2701                	sext.w	a4,a4
    800086a6:	2781                	sext.w	a5,a5
    800086a8:	fcf74ae3          	blt	a4,a5,8000867c <alloc3_desc+0x42>
      return -1;
    800086ac:	57fd                	li	a5,-1
    800086ae:	a831                	j	800086ca <alloc3_desc+0x90>
  for(int i = 0; i < 3; i++){
    800086b0:	fdc42783          	lw	a5,-36(s0)
    800086b4:	2785                	addiw	a5,a5,1
    800086b6:	fcf42e23          	sw	a5,-36(s0)
    800086ba:	fdc42783          	lw	a5,-36(s0)
    800086be:	0007871b          	sext.w	a4,a5
    800086c2:	4789                	li	a5,2
    800086c4:	f8e7d5e3          	bge	a5,a4,8000864e <alloc3_desc+0x14>
    }
  }
  return 0;
    800086c8:	4781                	li	a5,0
}
    800086ca:	853e                	mv	a0,a5
    800086cc:	70e2                	ld	ra,56(sp)
    800086ce:	7442                	ld	s0,48(sp)
    800086d0:	74a2                	ld	s1,40(sp)
    800086d2:	6121                	addi	sp,sp,64
    800086d4:	8082                	ret

00000000800086d6 <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    800086d6:	7139                	addi	sp,sp,-64
    800086d8:	fc06                	sd	ra,56(sp)
    800086da:	f822                	sd	s0,48(sp)
    800086dc:	0080                	addi	s0,sp,64
    800086de:	fca43423          	sd	a0,-56(s0)
    800086e2:	87ae                	mv	a5,a1
    800086e4:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800086e8:	fc843783          	ld	a5,-56(s0)
    800086ec:	47dc                	lw	a5,12(a5)
    800086ee:	0017979b          	slliw	a5,a5,0x1
    800086f2:	2781                	sext.w	a5,a5
    800086f4:	1782                	slli	a5,a5,0x20
    800086f6:	9381                	srli	a5,a5,0x20
    800086f8:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    800086fc:	0001b517          	auipc	a0,0x1b
    80008700:	4a450513          	addi	a0,a0,1188 # 80023ba0 <disk+0x128>
    80008704:	c47f80ef          	jal	8000134a <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80008708:	fd040793          	addi	a5,s0,-48
    8000870c:	853e                	mv	a0,a5
    8000870e:	f2dff0ef          	jal	8000863a <alloc3_desc>
    80008712:	87aa                	mv	a5,a0
    80008714:	cf81                	beqz	a5,8000872c <virtio_disk_rw+0x56>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80008716:	0001b597          	auipc	a1,0x1b
    8000871a:	48a58593          	addi	a1,a1,1162 # 80023ba0 <disk+0x128>
    8000871e:	0001b517          	auipc	a0,0x1b
    80008722:	37250513          	addi	a0,a0,882 # 80023a90 <disk+0x18>
    80008726:	bd1fa0ef          	jal	800032f6 <sleep>
    if(alloc3_desc(idx) == 0) {
    8000872a:	bff9                	j	80008708 <virtio_disk_rw+0x32>
      break;
    8000872c:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000872e:	fd042783          	lw	a5,-48(s0)
    80008732:	07a9                	addi	a5,a5,10
    80008734:	00479713          	slli	a4,a5,0x4
    80008738:	0001b797          	auipc	a5,0x1b
    8000873c:	34078793          	addi	a5,a5,832 # 80023a78 <disk>
    80008740:	97ba                	add	a5,a5,a4
    80008742:	07a1                	addi	a5,a5,8
    80008744:	fef43023          	sd	a5,-32(s0)

  if(write)
    80008748:	fc442783          	lw	a5,-60(s0)
    8000874c:	2781                	sext.w	a5,a5
    8000874e:	c791                	beqz	a5,8000875a <virtio_disk_rw+0x84>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80008750:	fe043783          	ld	a5,-32(s0)
    80008754:	4705                	li	a4,1
    80008756:	c398                	sw	a4,0(a5)
    80008758:	a029                	j	80008762 <virtio_disk_rw+0x8c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000875a:	fe043783          	ld	a5,-32(s0)
    8000875e:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80008762:	fe043783          	ld	a5,-32(s0)
    80008766:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000876a:	fe043783          	ld	a5,-32(s0)
    8000876e:	fe843703          	ld	a4,-24(s0)
    80008772:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80008774:	0001b797          	auipc	a5,0x1b
    80008778:	30478793          	addi	a5,a5,772 # 80023a78 <disk>
    8000877c:	6398                	ld	a4,0(a5)
    8000877e:	fd042783          	lw	a5,-48(s0)
    80008782:	0792                	slli	a5,a5,0x4
    80008784:	97ba                	add	a5,a5,a4
    80008786:	fe043703          	ld	a4,-32(s0)
    8000878a:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000878c:	0001b797          	auipc	a5,0x1b
    80008790:	2ec78793          	addi	a5,a5,748 # 80023a78 <disk>
    80008794:	6398                	ld	a4,0(a5)
    80008796:	fd042783          	lw	a5,-48(s0)
    8000879a:	0792                	slli	a5,a5,0x4
    8000879c:	97ba                	add	a5,a5,a4
    8000879e:	4741                	li	a4,16
    800087a0:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800087a2:	0001b797          	auipc	a5,0x1b
    800087a6:	2d678793          	addi	a5,a5,726 # 80023a78 <disk>
    800087aa:	6398                	ld	a4,0(a5)
    800087ac:	fd042783          	lw	a5,-48(s0)
    800087b0:	0792                	slli	a5,a5,0x4
    800087b2:	97ba                	add	a5,a5,a4
    800087b4:	4705                	li	a4,1
    800087b6:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[0]].next = idx[1];
    800087ba:	fd442683          	lw	a3,-44(s0)
    800087be:	0001b797          	auipc	a5,0x1b
    800087c2:	2ba78793          	addi	a5,a5,698 # 80023a78 <disk>
    800087c6:	6398                	ld	a4,0(a5)
    800087c8:	fd042783          	lw	a5,-48(s0)
    800087cc:	0792                	slli	a5,a5,0x4
    800087ce:	97ba                	add	a5,a5,a4
    800087d0:	03069713          	slli	a4,a3,0x30
    800087d4:	9341                	srli	a4,a4,0x30
    800087d6:	00e79723          	sh	a4,14(a5)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800087da:	fc843783          	ld	a5,-56(s0)
    800087de:	05878693          	addi	a3,a5,88
    800087e2:	0001b797          	auipc	a5,0x1b
    800087e6:	29678793          	addi	a5,a5,662 # 80023a78 <disk>
    800087ea:	6398                	ld	a4,0(a5)
    800087ec:	fd442783          	lw	a5,-44(s0)
    800087f0:	0792                	slli	a5,a5,0x4
    800087f2:	97ba                	add	a5,a5,a4
    800087f4:	8736                	mv	a4,a3
    800087f6:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    800087f8:	0001b797          	auipc	a5,0x1b
    800087fc:	28078793          	addi	a5,a5,640 # 80023a78 <disk>
    80008800:	6398                	ld	a4,0(a5)
    80008802:	fd442783          	lw	a5,-44(s0)
    80008806:	0792                	slli	a5,a5,0x4
    80008808:	97ba                	add	a5,a5,a4
    8000880a:	40000713          	li	a4,1024
    8000880e:	c798                	sw	a4,8(a5)
  if(write)
    80008810:	fc442783          	lw	a5,-60(s0)
    80008814:	2781                	sext.w	a5,a5
    80008816:	cf89                	beqz	a5,80008830 <virtio_disk_rw+0x15a>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80008818:	0001b797          	auipc	a5,0x1b
    8000881c:	26078793          	addi	a5,a5,608 # 80023a78 <disk>
    80008820:	6398                	ld	a4,0(a5)
    80008822:	fd442783          	lw	a5,-44(s0)
    80008826:	0792                	slli	a5,a5,0x4
    80008828:	97ba                	add	a5,a5,a4
    8000882a:	00079623          	sh	zero,12(a5)
    8000882e:	a829                	j	80008848 <virtio_disk_rw+0x172>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80008830:	0001b797          	auipc	a5,0x1b
    80008834:	24878793          	addi	a5,a5,584 # 80023a78 <disk>
    80008838:	6398                	ld	a4,0(a5)
    8000883a:	fd442783          	lw	a5,-44(s0)
    8000883e:	0792                	slli	a5,a5,0x4
    80008840:	97ba                	add	a5,a5,a4
    80008842:	4709                	li	a4,2
    80008844:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80008848:	0001b797          	auipc	a5,0x1b
    8000884c:	23078793          	addi	a5,a5,560 # 80023a78 <disk>
    80008850:	6398                	ld	a4,0(a5)
    80008852:	fd442783          	lw	a5,-44(s0)
    80008856:	0792                	slli	a5,a5,0x4
    80008858:	97ba                	add	a5,a5,a4
    8000885a:	00c7d703          	lhu	a4,12(a5)
    8000885e:	0001b797          	auipc	a5,0x1b
    80008862:	21a78793          	addi	a5,a5,538 # 80023a78 <disk>
    80008866:	6394                	ld	a3,0(a5)
    80008868:	fd442783          	lw	a5,-44(s0)
    8000886c:	0792                	slli	a5,a5,0x4
    8000886e:	97b6                	add	a5,a5,a3
    80008870:	00176713          	ori	a4,a4,1
    80008874:	1742                	slli	a4,a4,0x30
    80008876:	9341                	srli	a4,a4,0x30
    80008878:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].next = idx[2];
    8000887c:	fd842683          	lw	a3,-40(s0)
    80008880:	0001b797          	auipc	a5,0x1b
    80008884:	1f878793          	addi	a5,a5,504 # 80023a78 <disk>
    80008888:	6398                	ld	a4,0(a5)
    8000888a:	fd442783          	lw	a5,-44(s0)
    8000888e:	0792                	slli	a5,a5,0x4
    80008890:	97ba                	add	a5,a5,a4
    80008892:	03069713          	slli	a4,a3,0x30
    80008896:	9341                	srli	a4,a4,0x30
    80008898:	00e79723          	sh	a4,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000889c:	fd042783          	lw	a5,-48(s0)
    800088a0:	0001b717          	auipc	a4,0x1b
    800088a4:	1d870713          	addi	a4,a4,472 # 80023a78 <disk>
    800088a8:	0789                	addi	a5,a5,2
    800088aa:	0792                	slli	a5,a5,0x4
    800088ac:	97ba                	add	a5,a5,a4
    800088ae:	577d                	li	a4,-1
    800088b0:	00e78823          	sb	a4,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800088b4:	fd042783          	lw	a5,-48(s0)
    800088b8:	0789                	addi	a5,a5,2
    800088ba:	00479713          	slli	a4,a5,0x4
    800088be:	0001b797          	auipc	a5,0x1b
    800088c2:	1ba78793          	addi	a5,a5,442 # 80023a78 <disk>
    800088c6:	97ba                	add	a5,a5,a4
    800088c8:	01078693          	addi	a3,a5,16
    800088cc:	0001b797          	auipc	a5,0x1b
    800088d0:	1ac78793          	addi	a5,a5,428 # 80023a78 <disk>
    800088d4:	6398                	ld	a4,0(a5)
    800088d6:	fd842783          	lw	a5,-40(s0)
    800088da:	0792                	slli	a5,a5,0x4
    800088dc:	97ba                	add	a5,a5,a4
    800088de:	8736                	mv	a4,a3
    800088e0:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    800088e2:	0001b797          	auipc	a5,0x1b
    800088e6:	19678793          	addi	a5,a5,406 # 80023a78 <disk>
    800088ea:	6398                	ld	a4,0(a5)
    800088ec:	fd842783          	lw	a5,-40(s0)
    800088f0:	0792                	slli	a5,a5,0x4
    800088f2:	97ba                	add	a5,a5,a4
    800088f4:	4705                	li	a4,1
    800088f6:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800088f8:	0001b797          	auipc	a5,0x1b
    800088fc:	18078793          	addi	a5,a5,384 # 80023a78 <disk>
    80008900:	6398                	ld	a4,0(a5)
    80008902:	fd842783          	lw	a5,-40(s0)
    80008906:	0792                	slli	a5,a5,0x4
    80008908:	97ba                	add	a5,a5,a4
    8000890a:	4709                	li	a4,2
    8000890c:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[2]].next = 0;
    80008910:	0001b797          	auipc	a5,0x1b
    80008914:	16878793          	addi	a5,a5,360 # 80023a78 <disk>
    80008918:	6398                	ld	a4,0(a5)
    8000891a:	fd842783          	lw	a5,-40(s0)
    8000891e:	0792                	slli	a5,a5,0x4
    80008920:	97ba                	add	a5,a5,a4
    80008922:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80008926:	fc843783          	ld	a5,-56(s0)
    8000892a:	4705                	li	a4,1
    8000892c:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    8000892e:	fd042783          	lw	a5,-48(s0)
    80008932:	0001b717          	auipc	a4,0x1b
    80008936:	14670713          	addi	a4,a4,326 # 80023a78 <disk>
    8000893a:	0789                	addi	a5,a5,2
    8000893c:	0792                	slli	a5,a5,0x4
    8000893e:	97ba                	add	a5,a5,a4
    80008940:	fc843703          	ld	a4,-56(s0)
    80008944:	e798                	sd	a4,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80008946:	fd042703          	lw	a4,-48(s0)
    8000894a:	0001b797          	auipc	a5,0x1b
    8000894e:	12e78793          	addi	a5,a5,302 # 80023a78 <disk>
    80008952:	6794                	ld	a3,8(a5)
    80008954:	0001b797          	auipc	a5,0x1b
    80008958:	12478793          	addi	a5,a5,292 # 80023a78 <disk>
    8000895c:	679c                	ld	a5,8(a5)
    8000895e:	0027d783          	lhu	a5,2(a5)
    80008962:	2781                	sext.w	a5,a5
    80008964:	8b9d                	andi	a5,a5,7
    80008966:	2781                	sext.w	a5,a5
    80008968:	1742                	slli	a4,a4,0x30
    8000896a:	9341                	srli	a4,a4,0x30
    8000896c:	0786                	slli	a5,a5,0x1
    8000896e:	97b6                	add	a5,a5,a3
    80008970:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80008974:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80008978:	0001b797          	auipc	a5,0x1b
    8000897c:	10078793          	addi	a5,a5,256 # 80023a78 <disk>
    80008980:	679c                	ld	a5,8(a5)
    80008982:	0027d703          	lhu	a4,2(a5)
    80008986:	0001b797          	auipc	a5,0x1b
    8000898a:	0f278793          	addi	a5,a5,242 # 80023a78 <disk>
    8000898e:	679c                	ld	a5,8(a5)
    80008990:	2705                	addiw	a4,a4,1
    80008992:	1742                	slli	a4,a4,0x30
    80008994:	9341                	srli	a4,a4,0x30
    80008996:	00e79123          	sh	a4,2(a5)

  __sync_synchronize();
    8000899a:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000899e:	100017b7          	lui	a5,0x10001
    800089a2:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    800089a6:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800089aa:	a809                	j	800089bc <virtio_disk_rw+0x2e6>
    sleep(b, &disk.vdisk_lock);
    800089ac:	0001b597          	auipc	a1,0x1b
    800089b0:	1f458593          	addi	a1,a1,500 # 80023ba0 <disk+0x128>
    800089b4:	fc843503          	ld	a0,-56(s0)
    800089b8:	93ffa0ef          	jal	800032f6 <sleep>
  while(b->disk == 1) {
    800089bc:	fc843783          	ld	a5,-56(s0)
    800089c0:	43d8                	lw	a4,4(a5)
    800089c2:	4785                	li	a5,1
    800089c4:	fef704e3          	beq	a4,a5,800089ac <virtio_disk_rw+0x2d6>
  }

  disk.info[idx[0]].b = 0;
    800089c8:	fd042783          	lw	a5,-48(s0)
    800089cc:	0001b717          	auipc	a4,0x1b
    800089d0:	0ac70713          	addi	a4,a4,172 # 80023a78 <disk>
    800089d4:	0789                	addi	a5,a5,2
    800089d6:	0792                	slli	a5,a5,0x4
    800089d8:	97ba                	add	a5,a5,a4
    800089da:	0007b423          	sd	zero,8(a5)
  free_chain(idx[0]);
    800089de:	fd042783          	lw	a5,-48(s0)
    800089e2:	853e                	mv	a0,a5
    800089e4:	bebff0ef          	jal	800085ce <free_chain>

  release(&disk.vdisk_lock);
    800089e8:	0001b517          	auipc	a0,0x1b
    800089ec:	1b850513          	addi	a0,a0,440 # 80023ba0 <disk+0x128>
    800089f0:	9aff80ef          	jal	8000139e <release>
}
    800089f4:	0001                	nop
    800089f6:	70e2                	ld	ra,56(sp)
    800089f8:	7442                	ld	s0,48(sp)
    800089fa:	6121                	addi	sp,sp,64
    800089fc:	8082                	ret

00000000800089fe <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800089fe:	1101                	addi	sp,sp,-32
    80008a00:	ec06                	sd	ra,24(sp)
    80008a02:	e822                	sd	s0,16(sp)
    80008a04:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80008a06:	0001b517          	auipc	a0,0x1b
    80008a0a:	19a50513          	addi	a0,a0,410 # 80023ba0 <disk+0x128>
    80008a0e:	93df80ef          	jal	8000134a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80008a12:	100017b7          	lui	a5,0x10001
    80008a16:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80008a1a:	439c                	lw	a5,0(a5)
    80008a1c:	0007871b          	sext.w	a4,a5
    80008a20:	100017b7          	lui	a5,0x10001
    80008a24:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80008a28:	8b0d                	andi	a4,a4,3
    80008a2a:	2701                	sext.w	a4,a4
    80008a2c:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    80008a2e:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80008a32:	a861                	j	80008aca <virtio_disk_intr+0xcc>
    __sync_synchronize();
    80008a34:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80008a38:	0001b797          	auipc	a5,0x1b
    80008a3c:	04078793          	addi	a5,a5,64 # 80023a78 <disk>
    80008a40:	6b98                	ld	a4,16(a5)
    80008a42:	0001b797          	auipc	a5,0x1b
    80008a46:	03678793          	addi	a5,a5,54 # 80023a78 <disk>
    80008a4a:	0207d783          	lhu	a5,32(a5)
    80008a4e:	2781                	sext.w	a5,a5
    80008a50:	8b9d                	andi	a5,a5,7
    80008a52:	2781                	sext.w	a5,a5
    80008a54:	078e                	slli	a5,a5,0x3
    80008a56:	97ba                	add	a5,a5,a4
    80008a58:	43dc                	lw	a5,4(a5)
    80008a5a:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80008a5e:	0001b717          	auipc	a4,0x1b
    80008a62:	01a70713          	addi	a4,a4,26 # 80023a78 <disk>
    80008a66:	fec42783          	lw	a5,-20(s0)
    80008a6a:	0789                	addi	a5,a5,2
    80008a6c:	0792                	slli	a5,a5,0x4
    80008a6e:	97ba                	add	a5,a5,a4
    80008a70:	0107c783          	lbu	a5,16(a5)
    80008a74:	c799                	beqz	a5,80008a82 <virtio_disk_intr+0x84>
      panic("virtio_disk_intr status");
    80008a76:	00002517          	auipc	a0,0x2
    80008a7a:	ce250513          	addi	a0,a0,-798 # 8000a758 <etext+0x758>
    80008a7e:	bb8f80ef          	jal	80000e36 <panic>

    struct buf *b = disk.info[id].b;
    80008a82:	0001b717          	auipc	a4,0x1b
    80008a86:	ff670713          	addi	a4,a4,-10 # 80023a78 <disk>
    80008a8a:	fec42783          	lw	a5,-20(s0)
    80008a8e:	0789                	addi	a5,a5,2
    80008a90:	0792                	slli	a5,a5,0x4
    80008a92:	97ba                	add	a5,a5,a4
    80008a94:	679c                	ld	a5,8(a5)
    80008a96:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80008a9a:	fe043783          	ld	a5,-32(s0)
    80008a9e:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80008aa2:	fe043503          	ld	a0,-32(s0)
    80008aa6:	8b5fa0ef          	jal	8000335a <wakeup>

    disk.used_idx += 1;
    80008aaa:	0001b797          	auipc	a5,0x1b
    80008aae:	fce78793          	addi	a5,a5,-50 # 80023a78 <disk>
    80008ab2:	0207d783          	lhu	a5,32(a5)
    80008ab6:	2785                	addiw	a5,a5,1
    80008ab8:	03079713          	slli	a4,a5,0x30
    80008abc:	9341                	srli	a4,a4,0x30
    80008abe:	0001b797          	auipc	a5,0x1b
    80008ac2:	fba78793          	addi	a5,a5,-70 # 80023a78 <disk>
    80008ac6:	02e79023          	sh	a4,32(a5)
  while(disk.used_idx != disk.used->idx){
    80008aca:	0001b797          	auipc	a5,0x1b
    80008ace:	fae78793          	addi	a5,a5,-82 # 80023a78 <disk>
    80008ad2:	0207d703          	lhu	a4,32(a5)
    80008ad6:	0001b797          	auipc	a5,0x1b
    80008ada:	fa278793          	addi	a5,a5,-94 # 80023a78 <disk>
    80008ade:	6b9c                	ld	a5,16(a5)
    80008ae0:	0027d783          	lhu	a5,2(a5)
    80008ae4:	2701                	sext.w	a4,a4
    80008ae6:	2781                	sext.w	a5,a5
    80008ae8:	f4f716e3          	bne	a4,a5,80008a34 <virtio_disk_intr+0x36>
  }

  release(&disk.vdisk_lock);
    80008aec:	0001b517          	auipc	a0,0x1b
    80008af0:	0b450513          	addi	a0,a0,180 # 80023ba0 <disk+0x128>
    80008af4:	8abf80ef          	jal	8000139e <release>
}
    80008af8:	0001                	nop
    80008afa:	60e2                	ld	ra,24(sp)
    80008afc:	6442                	ld	s0,16(sp)
    80008afe:	6105                	addi	sp,sp,32
    80008b00:	8082                	ret
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
