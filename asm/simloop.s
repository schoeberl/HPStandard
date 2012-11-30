#
# yarisim loops
#
main:
	li $2, 1
	li $3, 2
# this 'hangs' on yarisim. Don't understand why.
	sub $4, $3, $2
	nop
	nop
	nop
	nop

