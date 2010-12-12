	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, -1
# was:	ori	_apply__9_, 0, -1
# 	ori	2,_apply__9_,0
	jal	t
# was:	jal	t, 2
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
t:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	t_arg__1_,2,0
	ori	$3, $0, -1
# was:	ori	_truePat__6_, 0, -1
	bne	$2, $3, _match__5_
# was:	bne	t_arg__1_, _truePat__6_, _match__5_
	ori	$2, $0, 1
# was:	ori	t_res__2_, 0, 1
	j	t_return__3_
_match__5_:
	ori	$3, $0, 0
# was:	ori	_falsePat__8_, 0, 0
	bne	$2, $3, _match__7_
# was:	bne	t_arg__1_, _falsePat__8_, _match__7_
	ori	$2, $0, 0
# was:	ori	t_res__2_, 0, 0
	j	t_return__3_
_match__7_:
	j	t_fail__4_
t_return__3_:
# 	ori	2,t_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
t_fail__4_:
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
