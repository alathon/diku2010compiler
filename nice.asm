	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 0
# was:	ori	_apply__10_, 0, 0
# 	ori	2,_apply__10_,0
	jal	g
# was:	jal	g, 2
# 	ori	dead,2,0
	ori	$4, $2, 0
# was:	ori	4, dead, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_stop_
# 
g:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	g_arg__1_,2,0
# 	ori	_patVar_x__6_,g_arg__1_,0
# 	ori	_r1_7_,_patVar_x__6_,0
	beq	$2, $0, _lelse_8_
# was:	beq	_r1_7_, 0, _lelse_8_
	ori	$2, $0, 1
# was:	ori	g_res__2_, 0, 1
	j	_lend_9_
_lelse_8_:
	ori	$2, $0, 0
# was:	ori	g_res__2_, 0, 0
_lend_9_:
	j	g_return__3_
_match__5_:
	j	g_fail__4_
g_return__3_:
# 	ori	2,g_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
g_fail__4_:
	ori	$5, $0, 1
	j	_Error_
_stop_:
	ori	$2, $0, 10
	syscall
_Error_:
	la	$4, _ErrorString_
	ori	$2, $0, 4
	syscall
	ori	$4, $5, 0
	ori	$2, $0, 1
	syscall
	la	$4, _cr_
	ori	$2, $0, 4
	syscall
	j	_stop_
	.data	
_cr_:
	.asciiz	"\n"
_ErrorString_:
	.asciiz	"Match failed near line "
	.align	2
_heap_:
	.space	100000
