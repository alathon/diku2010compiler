	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 0
# was:	ori	_apply__17_, 0, 0
# 	ori	2,_apply__17_,0
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
	ori	$3, $2, 0
# was:	ori	_patVar_x__6_, g_arg__1_, 0
# 
_case_7_:
	sw	$31, -4($29)
# was:	sw	31, -4(29)
	addi	$29, $29, -8
# was:	addi	29, 29, -8
# 	ori	_case_7__arg__8_,2,0
	ori	$3, $0, -1
# was:	ori	3, 0, -1
# was:	ori	_truePat__13_, 0, -1
	bne	$2, $3, _match__12_
# was:	bne	2, 3, _match__12_
# was:	bne	_case_7__arg__8_, _truePat__13_, _match__12_
	ori	$2, $0, 1
# was:	ori	2, 0, 1
# was:	ori	_case_7__res__9_, 0, 1
	j	_case_7__return__10_
_match__12_:
	ori	$3, $0, 0
# was:	ori	3, 0, 0
# was:	ori	_falsePat__15_, 0, 0
	bne	$2, $3, _match__14_
# was:	bne	2, 3, _match__14_
# was:	bne	_case_7__arg__8_, _falsePat__15_, _match__14_
	ori	$2, $0, 0
# was:	ori	2, 0, 0
# was:	ori	_case_7__res__9_, 0, 0
	j	_case_7__return__10_
_match__14_:
	j	_case_7__fail__11_
_case_7__return__10_:
# 	ori	2,_case_7__res__9_,0
	addi	$29, $29, 8
# was:	addi	29, 29, 8
	lw	$31, -4($29)
# was:	lw	31, -4(29)
	jr	$31
# was:	jr	31, 
_case_7__fail__11_:
	ori	$5, $0, 2
# was:	ori	5, 0, 2
	j	_Error_
	ori	$2, $3, 0
# was:	ori	_apply__16_, _patVar_x__6_, 0
# 	ori	2,_apply__16_,0
	jal	_case_7_
# was:	jal	_case_7_, 2
# 	ori	g_res__2_,2,0
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
