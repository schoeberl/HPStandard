#
# Test an overflowing addition.
# We don't intend to implement exceptions now.
# yarisim does not throw an exception as well. So it is ok for us.
#
# Author: Martin Schoeberl (martin@jopdesign.com)
#
main:
	li $2, 2000000000
	addu $1, $0, $2
	add $3, $1, $2
	nop
	nop
	nop
	nop
