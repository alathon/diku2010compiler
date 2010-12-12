	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	_apply__9_, 0, 5
# 	ori	2,_apply__9_,0
	jal	a
# was:	jal	a, 2
# 	ori	dead,2,0
	j	_stop_
# 
a:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	a_arg__1_,2,0
# 	ori	_patVar_n__6_,a_arg__1_,0
# 	ori	_plus1__7_,_patVar_n__6_,0
	ori	$3, $0, 5
# was:	ori	_plus2__8_, 0, 5
	add	$2, $2, $3
# was:	add	a_res__2_, _plus1__7_, _plus2__8_
	j	a_return__3_
_match__5_:
	j	a_fail__4_
a_return__3_:
# 	ori	2,a_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
a_fail__4_:
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
