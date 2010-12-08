	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 10
# was:	ori	_apply__7_, 0, 10
# 	ori	2,_apply__7_,0
	jal	t
# was:	jal	t, 2
# 	ori	dead,2,0
	j	_stop_
# 
t:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	t_arg__1_,2,0
# 	ori	_patVar_n__6_,t_arg__1_,0
# 	ori	t_res__2_,_patVar_n__6_,0
	j	t_return__3_
_match__5_:
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
