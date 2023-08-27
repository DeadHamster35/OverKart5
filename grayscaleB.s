	.file	1 "grayscale.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	grayscale
	.set	nomips16
	.set	nomicromips
	.ent	grayscale
	.type	grayscale, @function
grayscale:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_DispFrame)
	lhu	$2,%lo(g_DispFrame)($2)
	sll	$2,$2,2
	lui	$3,%hi(g_CfbPtrs)
	addiu	$3,$3,%lo(g_CfbPtrs)
	addu	$2,$2,$3
	lw	$5,0($2)
	li	$6,131072			# 0x20000
	addiu	$6,$6,22528
	addu	$6,$5,$6
	lw	$7,0($5)
$L4:
	srl	$2,$7,11
	andi	$2,$2,0x1f
	srl	$3,$7,6
	andi	$3,$3,0x1f
	addu	$2,$2,$3
	srl	$3,$7,1
	andi	$3,$3,0x1f
	addu	$2,$2,$3
	addiu	$2,$2,15
	sra	$2,$2,2
	srl	$4,$7,22
	andi	$4,$4,0x1f
	srl	$3,$7,27
	addu	$4,$4,$3
	srl	$3,$7,17
	andi	$3,$3,0x1f
	addu	$4,$4,$3
	addiu	$3,$4,15
	sra	$4,$3,31
	andi	$4,$4,0x3
	addu	$4,$4,$3
	sra	$4,$4,2
	sll	$3,$2,27
	sll	$7,$2,22
	or	$3,$3,$7
	sll	$2,$2,17
	or	$2,$3,$2
	sll	$3,$4,11
	or	$2,$2,$3
	sll	$3,$4,6
	or	$2,$2,$3
	sll	$4,$4,1
	or	$2,$2,$4
	sw	$2,0($5)
	addiu	$5,$5,4
	bnel	$6,$5,$L4
	lw	$7,0($5)

	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	grayscale
	.size	grayscale, .-grayscale
	.ident	"GCC: (GNU) 10.1.0"
