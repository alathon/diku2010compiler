	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $29, 0
# was:	ori	_apply__30_, 29, 0
	ori	$3, $0, 5
# was:	ori	c_e_31_, 0, 5
	sw	$3, 0($29)
# was:	sw	c_e_31_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$3, $29, 0
# was:	ori	c_e_32_, 29, 0
	ori	$4, $0, 4
# was:	ori	c_e_33_, 0, 4
	sw	$4, 0($29)
# was:	sw	c_e_33_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$4, $29, 0
# was:	ori	c_e_34_, 29, 0
	ori	$6, $0, 3
# was:	ori	c_e_35_, 0, 3
	sw	$6, 0($29)
# was:	sw	c_e_35_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	ori	$6, $0, 0
# was:	ori	c_e_36_, 0, 0
	sw	$6, 0($29)
# was:	sw	c_e_36_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	sw	$4, 0($29)
# was:	sw	c_e_34_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
	sw	$3, 0($29)
# was:	sw	c_e_32_, 0(29)
	addi	$29, $29, -4
# was:	addi	29, 29, -4
# 	ori	2,_apply__30_,0
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
	lw	$2, 0($2)
# was:	lw	_per_7_, 0(f_arg__1_)
	ori	$16, $2, 0
# was:	ori	_patVar_x__8_, _per_7_, 0
# hej
# 	ori	_per_9_,_per_7_,0
# move per
# 	ori	_plus1__11_,_patVar_x__8_,0
# 	ori	_apply__13_,_per_9_,0
# 	ori	2,_apply__13_,0
	jal	f
# was:	jal	f, 2
# 	ori	_plus2__12_,2,0
	add	$2, $16, $2
# was:	add	f_res__2_, _plus1__11_, _plus2__12_
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
	ori	$5, $0, 4
	j	_Error_
# 
g:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	g_arg__14_,2,0
	bne	$2, $0, _lnext__18_
# was:	bne	g_arg__14_, 0, _lnext__18_
	ori	$2, $0, 1
# was:	ori	g_res__15_, 0, 1
	j	g_return__16_
_lnext__18_:
	lw	$4, 0($2)
# was:	lw	_per_20_, 0(g_arg__14_)
# 	ori	_patVar_x__21_,_per_20_,0
# hej
	lw	$3, -4($4)
# was:	lw	_per_22_, -4(_per_20_)
# 	ori	_patVar_y__23_,_per_22_,0
# hej
	lw	$2, -8($3)
# was:	lw	_per_24_, -8(_per_22_)
# 	ori	_patVar_z__25_,_per_24_,0
# hej
# 	ori	_plus1__28_,_patVar_x__21_,0
# 	ori	_plus2__29_,_patVar_y__23_,0
	add	$3, $4, $3
# was:	add	_plus1__26_, _plus1__28_, _plus2__29_
# 	ori	_plus2__27_,_patVar_z__25_,0
	add	$2, $3, $2
# was:	add	g_res__15_, _plus1__26_, _plus2__27_
	j	g_return__16_
_lnext__19_:
	j	g_fail__17_
g_return__16_:
# 	ori	2,g_res__15_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
g_fail__17_:
	ori	$5, $0, 9
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
