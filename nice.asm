	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $29, 0
# was:	ori	_apply__18_, 29, 0
	ori	$3, $0, 5
# was:	ori	c_e_19_, 0, 5
	sw	$3, -4($29)
# was:	sw	c_e_19_, -4(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $29, 0
# was:	ori	c_e_20_, 29, 0
	ori	$4, $0, 2
# was:	ori	c_e_21_, 0, 2
	sw	$4, -4($29)
# was:	sw	c_e_21_, -4(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$4, $0, 0
# was:	ori	c_e_22_, 0, 0
	sw	$4, -4($29)
# was:	sw	c_e_22_, -4(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	sw	$3, -4($29)
# was:	sw	c_e_20_, -4(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
# 	ori	2,_apply__18_,0
	jal	f
# was:	jal	f, 2
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
f:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	f_arg__1_,2,0
	bne	$2, $0, _lnext__5_
# was:	bne	f_arg__1_, 0, _lnext__5_
	ori	$2, $0, 1
# was:	ori	f_res__2_, 0, 1
	j	f_return__3_
_lnext__5_:
# nice
	lw	$16, -4($2)
# was:	lw	_me_7_, -4(f_arg__1_)
# lol
# 	ori	_patVar_x__9_,_me_7_,0
# hej
	lw	$2, -8($2)
# was:	lw	_me_11_, -8(f_arg__1_)
# lol
# 	ori	_patVar_y__13_,_me_11_,0
# hej
# 	ori	_plus1__15_,_patVar_x__9_,0
# 	ori	_apply__17_,_patVar_y__13_,0
# 	ori	2,_apply__17_,0
	jal	f
# was:	jal	f, 2
# 	ori	_plus2__16_,2,0
	add	$2, $16, $2
# was:	add	f_res__2_, _plus1__15_, _plus2__16_
	j	f_return__3_
_lnext__6_:
	j	f_fail__4_
f_return__3_:
# 	ori	2,f_res__2_,0
	addi	$29, $29, 12
	lw	$16, -8($29)
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
