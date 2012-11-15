#!/bin/bash
#
# Synopsis: ./single.sh APP
#
# Return Value:
#   0 ... test ok
#   1 ... test failed
#   2 ... exception

LOG_DIR="tmp"
TEST="${1}"

errors=()
mkdir -p "${LOG_DIR}"
echo "${TEST}"

# assemble the test case
make rom APP="${TEST}" 1>"${LOG_DIR}/asm.out" 2>"${LOG_DIR}/asm.err"

# run modelsim
make bsim APP="${TEST}" 1>"${LOG_DIR}/ms.out" 2>"${LOG_DIR}/ms.err" \
    || errors+=("ms")

# run high-level simulator
make ysim APP="${TEST}" 1>"${LOG_DIR}/hs.out" 2>"${LOG_DIR}/hs.err"
# -- error codes correspond to patmos exceptions

# compare output
java -cp java/lib/yamp-tools.jar util.YampYari "${LOG_DIR}/hs.out" "${LOG_DIR}/ms.out" | \
    tee "${LOG_DIR}/comptest.out" | sed -e 's/^\(\S\)/ \1/'

# report errors, failure or ok
if [ "${#errors[@]}" -ne 0 ] ; then
    echo "Error: ${TEST}: Failed to execute test (${errors[@]})"
    for f in "${errors[@]}" ; do cat "${LOG_DIR}"/$f.err ; done
    exit 2
elif (grep '^[ ]*ok[ ]*$' "${LOG_DIR}/comptest.out" >/dev/null) ; then
    exit 0
else
    echo " failed"
    exit 1
fi

