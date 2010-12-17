	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	_apply__36_, 0, 5
# 	ori	2,_apply__36_,0
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
f:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	f_arg__1_,2,0
	lw	$4, 0($2)
# was:	lw	_TupleP_6_, 0(f_arg__1_)
	lw	$2, -4($4)
# was:	lw	_rpe_7_, -4(_TupleP_6_)
# 	ori	_VarP_x_8_,_rpe_7_,0
	lw	$4, -8($4)
# was:	lw	_rpe_9_, -8(_TupleP_6_)
# 	ori	_VarP_y_10_,_rpe_9_,0
# 	ori	_rs__11_,_VarP_x_8_,0
# 	ori	_rt__12_,_VarP_y_10_,0
	slt	$2, $2, $4
# was:	slt	_rd__13_, _rs__11_, _rt__12_
	beq	$2, $0, _lend__14_
# was:	beq	_rd__13_, 0, _lend__14_
	ori	$3, $0, -1
# was:	ori	f_res__2_, 0, -1
_lend__14_:
	j	f_return__3_
_lnext__5_:
	j	f_fail__4_
f_return__3_:
	ori	$2, $3, 0
# was:	ori	2, f_res__2_, 0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
f_fail__4_:
	ori	$5, $0, 3
	j	_Error_
# 
g:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	g_arg__15_,2,0
	ori	$4, $2, 0
# was:	ori	_VarP_x_20_, g_arg__15_, 0
# 	ori	_rs__22_,_VarP_x_20_,0
	ori	$2, $0, 6
# was:	ori	_rt__23_, 0, 6
	slt	$2, $4, $2
# was:	slt	_rd__24_, _rs__22_, _rt__23_
	beq	$2, $0, _lend__25_
# was:	beq	_rd__24_, 0, _lend__25_
	ori	$3, $0, -1
# was:	ori	_r1_21_, 0, -1
_lend__25_:
	beq	$3, $0, _lend_33_
# was:	beq	_r1_21_, 0, _lend_33_
	ori	$2, $29, 0
# was:	ori	_apply__26_, 29, 0
	sw	$29, 0($29)
# was:	sw	29, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $0, 2
# was:	ori	c_e_27_, 0, 2
	sw	$3, 0($29)
# was:	sw	c_e_27_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $0, 3
# was:	ori	c_e_28_, 0, 3
	sw	$3, 0($29)
# was:	sw	c_e_28_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
# 	ori	2,_apply__26_,0
	jal	f
# was:	jal	f, 2
	ori	$3, $2, 0
# was:	ori	_r1_21_, 2, 0
	bne	$3, $0, _lend_32_
# was:	bne	_r1_21_, 0, _lend_32_
	ori	$2, $29, 0
# was:	ori	_apply__29_, 29, 0
	sw	$29, 0($29)
# was:	sw	29, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $0, 3
# was:	ori	c_e_30_, 0, 3
	sw	$3, 0($29)
# was:	sw	c_e_30_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $0, 2
# was:	ori	c_e_31_, 0, 2
	sw	$3, 0($29)
# was:	sw	c_e_31_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
# 	ori	2,_apply__29_,0
	jal	f
# was:	jal	f, 2
	ori	$3, $2, 0
# was:	ori	_r1_21_, 2, 0
	beq	$3, $0, _lend_32_
# was:	beq	_r1_21_, 0, _lend_32_
_lend_32_:
	beq	$3, $0, _lend_33_
# was:	beq	_r1_21_, 0, _lend_33_
_lend_33_:
	beq	$3, $0, _lelse_34_
# was:	beq	_r1_21_, 0, _lelse_34_
	ori	$2, $0, 1
# was:	ori	g_res__16_, 0, 1
	j	_lend_35_
_lelse_34_:
	ori	$2, $0, 0
# was:	ori	g_res__16_, 0, 0
_lend_35_:
	j	g_return__17_
_lnext__19_:
	j	g_fail__18_
g_return__17_:
# 	ori	2,g_res__16_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
g_fail__18_:
	ori	$5, $0, 7
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
