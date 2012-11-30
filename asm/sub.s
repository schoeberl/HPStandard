#
# Test subtract with and without overflow
#
# Author: Martin Schoeberl (martin@jopdesign.com)
#
main:
	li $2, 1
	li $3, 2
# this 'hangs' on yarisim. Don't understand why.
#	sub $4, $3, $2
# this is ok
	subu $5, $3, $2
	li $2, -1
#	sub $6, $2, $3
	subu $7, $2, $3
	li $2, -2000000000
	li $3, 10000
#	sub $8, $2, $3
	subu $9, $2, $3
	nop
	nop
	nop
	nop
	nop

