	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $29, 0
# was:	ori	_apply__40_, 29, 0
	sw	$29, 0($29)
# was:	sw	29, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $0, 5
# was:	ori	c_e_41_, 0, 5
	sw	$3, 0($29)
# was:	sw	c_e_41_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $29, 0
# was:	ori	c_e_42_, 29, 0
	sw	$29, 0($29)
# was:	sw	29, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$4, $0, 4
# was:	ori	c_e_43_, 0, 4
	sw	$4, 0($29)
# was:	sw	c_e_43_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$4, $0, 0
# was:	ori	c_e_44_, 0, 0
	sw	$4, 0($29)
# was:	sw	c_e_44_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	sw	$3, 0($29)
# was:	sw	c_e_42_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
# 	ori	2,_apply__40_,0
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
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	f_arg__1_,2,0
	bne	$2, $0, _lnext__5_
# was:	bne	f_arg__1_, 0, _lnext__5_
	ori	$2, $0, 1
# was:	ori	f_res__2_, 0, 1
	j	f_return__3_
_lnext__5_:
	lw	$2, 0($2)
# was:	lw	_TupleP_7_, 0(f_arg__1_)
	lw	$4, -4($2)
# was:	lw	_rpe_8_, -4(_TupleP_7_)
# 	ori	_VarP_x_9_,_rpe_8_,0
	lw	$2, -8($2)
# was:	lw	_rpe_10_, -8(_TupleP_7_)
	lw	$2, 0($2)
# was:	lw	_TupleP_11_, 0(_rpe_10_)
	lw	$3, -4($2)
# was:	lw	_rpe_12_, -4(_TupleP_11_)
# 	ori	_VarP_y_13_,_rpe_12_,0
	lw	$2, -8($2)
# was:	lw	_rpe_14_, -8(_TupleP_11_)
# 	ori	_VarP_z_15_,_rpe_14_,0
# 	ori	_plus1__18_,_VarP_x_9_,0
# 	ori	_plus2__19_,_VarP_y_13_,0
	add	$16, $4, $3
# was:	add	_plus1__16_, _plus1__18_, _plus2__19_
# 	ori	_apply__20_,_VarP_z_15_,0
# 	ori	2,_apply__20_,0
	jal	f
# was:	jal	f, 2
# 	ori	_plus2__17_,2,0
	add	$2, $16, $2
# was:	add	f_res__2_, _plus1__16_, _plus2__17_
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
# 
g:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	g_arg__21_,2,0
# 	ori	_VarP_x_26_,g_arg__21_,0
# 	ori	_apply_27_,_VarP_x_26_,0
	ori	$3, $2, 0
# was:	ori	_VarP_y_31_, _apply_27_, 0
# 	ori	_rs_33_,_VarP_x_26_,0
# 	ori	_rt_34_,_VarP_y_31_,0
	xor	$2, $2, $3
# was:	xor	_r1_32_, _rs_33_, _rt_34_
	beq	$2, $0, _lelse_36_
# was:	beq	_r1_32_, 0, _lelse_36_
	ori	$2, $0, 0
# was:	ori	_r1_32_, 0, 0
	j	_lend_37_
_lelse_36_:
	ori	$2, $0, -1
# was:	ori	_r1_32_, 0, -1
_lend_37_:
	beq	$2, $0, _lelse_38_
# was:	beq	_r1_32_, 0, _lelse_38_
	ori	$2, $0, 2
# was:	ori	g_res__22_, 0, 2
	j	_lend_39_
_lelse_38_:
	ori	$2, $0, 3
# was:	ori	g_res__22_, 0, 3
_lend_39_:
	j	_case_exit_28_
_lnext__30_:
	j	_cas_fail_29_
_cas_fail_29_:
	ori	$5, $0, 9
# was:	ori	5, 0, 9
	j	_Error_
_case_exit_28_:
	j	g_return__23_
_lnext__25_:
	j	g_fail__24_
g_return__23_:
# 	ori	2,g_res__22_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
g_fail__24_:
	ori	$5, $0, 8
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
