lw $1, 8188($0)
	li $2, -91893367
	addu $2, $1, $2
	li $3, 1992236442
	li $4, 1501897826
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $14, $14, $1
	seh $7, $2
	bne $7, $14, skip0
	nop
	addiu $7, $7, 18672
skip0:	sw $7, 0($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $24, $24, $1
	seh $10, $2
	nop
	beq $10, $24, skip1
	nop
	addiu $10, $10, 29849
skip1:	sw $10, 4($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $20, $20, $1
	seh $24, $2
	nop
	nop
	beq $24, $20, skip2
	nop
	addiu $24, $24, 26533
skip2:	sw $24, 8($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $26, $26, $1
	seh $12, $2
	beq $12, $26, skip3
	nop
	addiu $12, $12, 12410
skip3:	sw $12, 12($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $21, $21, $1
	seh $13, $2
	nop
	bne $13, $21, skip4
	nop
	addiu $13, $13, 22555
skip4:	sw $13, 16($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $10, $10, $1
	seh $21, $2
	nop
	nop
	beq $21, $10, skip5
	nop
	addiu $21, $21, 14319
skip5:	sw $21, 20($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $15, $15, $1
	seh $25, $2
	bne $25, $15, skip6
	nop
	addiu $25, $25, 23748
skip6:	sw $25, 24($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $22, $22, $1
	seh $17, $2
	nop
	bne $17, $22, skip7
	nop
	addiu $17, $17, 6931
skip7:	sw $17, 28($0)
	addu $2, $6, $4
	xor $6, $2, $3
	ori $1, $0, 0xffff
	and $9, $9, $1
	seh $25, $2
	nop
	nop
	beq $25, $9, skip8
	nop
	addiu $25, $25, 14469
skip8:	sw $25, 32($0)
	addu $2, $6, $4
	jal beg9
	seh $23, $31
	beq $0, $0, skip9
	nop
beg9:	jr $23
	nop
	sw $23, 36($0)
skip9:	jal beg10
	seh $10, $31
	beq $0, $0, skip10
	nop
beg10:	nop
	jr $10
	nop
	sw $10, 40($0)
skip10:	jal beg11
	seh $17, $31
	beq $0, $0, skip11
	nop
beg11:	nop
	nop
	jr $17
	nop
	sw $17, 44($0)
skip11:	jal beg12
	nop
	beq $0, $0, skip12
	nop
beg12:	seh $8, $31
	jr $8
	nop
	sw $8, 48($0)
skip12:	jal beg13
	nop
	beq $0, $0, skip13
	nop
beg13:	seh $20, $31
	nop
	jr $20
	nop
	sw $20, 52($0)
skip13:	jal beg14
	nop
	beq $0, $0, skip14
	nop
beg14:	seh $17, $31
	nop
	nop
	jr $17
	nop
	sw $17, 56($0)
skip14:	jal beg15
	nop
	beq $0, $0, skip15
	nop
beg15:	nop
	seh $25, $31
	jr $25
	nop
	sw $25, 60($0)
skip15:	jal beg16
	nop
	beq $0, $0, skip16
	nop
beg16:	nop
	seh $9, $31
	nop
	jr $9
	nop
	sw $9, 64($0)
skip16:	jal beg17
	nop
	beq $0, $0, skip17
	nop
beg17:	nop
	seh $22, $31
	nop
	nop
	jr $22
	nop
	sw $22, 68($0)
skip17:	jal beg18
	seh $21, $31
	beq $0, $0, skip18
	nop
beg18:	jr $21
	nop
	sw $21, 72($0)
skip18:	jal beg19
	seh $29, $31
	beq $0, $0, skip19
	nop
beg19:	nop
	jr $29
	nop
	sw $29, 76($0)
skip19:	jal beg20
	seh $7, $31
	beq $0, $0, skip20
	nop
beg20:	nop
	nop
	jr $7
	nop
	sw $7, 80($0)
skip20:	jal beg21
	nop
	beq $0, $0, skip21
	nop
beg21:	seh $11, $31
	jr $11
	nop
	sw $11, 84($0)
skip21:	jal beg22
	nop
	beq $0, $0, skip22
	nop
beg22:	seh $22, $31
	nop
	jr $22
	nop
	sw $22, 88($0)
skip22:	jal beg23
	nop
	beq $0, $0, skip23
	nop
beg23:	seh $17, $31
	nop
	nop
	jr $17
	nop
	sw $17, 92($0)
skip23:	jal beg24
	nop
	beq $0, $0, skip24
	nop
beg24:	nop
	seh $16, $31
	jr $16
	nop
	sw $16, 96($0)
skip24:	jal beg25
	nop
	beq $0, $0, skip25
	nop
beg25:	nop
	seh $14, $31
	nop
	jr $14
	nop
	sw $14, 100($0)
skip25:	jal beg26
	nop
	beq $0, $0, skip26
	nop
beg26:	nop
	seh $23, $31
	nop
	nop
	jr $23
	nop
	sw $23, 104($0)
skip26:
dl:	j dl
	nop