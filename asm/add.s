#
# First test of a simple add. With some forwarding tests.
#
# Author: Martin Schoeberl (martin@jopdesign.com)
#
main:
	li $2, 1
	li $3, 2
	nop
	nop
	add $4, $2, $3
	nop
	nop
	nop
#
# Now check forwarding
#
	li $5, 0
	nop
	nop
	nop
	add $5, $2, $3
	add $6, $0, $5
	add $7, $0, $5
	add $8, $0, $5
	add $9, $0, $5
	add $10, $0, $5
	nop
	nop
#
# Other forwarding path
#
	add $5, $5, $5
	add $6, $5, $0
	add $7, $5, $0
	add $8, $5, $0
	add $9, $5, $0
	add $10, $5, $0
	nop
	nop
# 
# Now check write to $0 and if value escapes due to forwarding
#
	add $0, $0, 7
	add $1, $0, 1
	add $2, $0, 1
	add $3, $0, 1
	add $4, $0, 1
	add $5, $0, 1
	add $25, $0, 1
	nop
	nop
	nop
	nop
	nop

