#
# Test the ALU.
# This is a collection of arbitrary ALU operations. The co-simulation will find the bugs.
#
# Author: Martin Schoeberl (martin@jopdesign.com)
#
main:
	li $2, 1
	li $3, 2
	li $4, -123
	li $5, 2000000000
#	add $7, $4, $3   # this sends yarisim in a very long loop, no idea why
	addu $7, $4, $3
	addi $7, $3, 123
	addi $8, $4, -34
	or $9, $7, $8
	ori $10, $2, 3
	or $10, $4, -100
	or $11, $5, 2000000000
	and $12, $4, $5
	andi $13, $5, 1234
	and $13, $4, -100
	and $14, $5, 2000000000
	addiu $15, $3, -456
	addu $16, $4, $5


	nop
	nop
	nop
	nop
	nop
	nop
	
