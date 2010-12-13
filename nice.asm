	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	_apply__7_, 0, 5
# 	ori	2,_apply__7_,0
	jal	f
# was:	jal	f, 2
# 	ori	dead,2,0
	j	_stop_
# 
f:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	f_arg__1_,2,0
# 	ori	_patVar_x__6_,f_arg__1_,0
	ori	$2, $0, 4
# was:	ori	f_res__2_, 0, 4
	j	f_return__3_
_match__5_:
	j	f_fail__4_
f_return__3_:
# 	ori	2,f_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
f_fail__4_:
	ori	$5, $0, 3
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
