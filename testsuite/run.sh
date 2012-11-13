#!/bin/bash

tests="add"
not_working="non"
expect_fail=0

# make tools
# make rom bsim

echo === Tests ===
failed=()
for f in  ${tests}; do
    testsuite/single.sh ${f}
    result=$?
    if [ "$result" -ne 0 ] ; then
        failed+=("${f}")
    fi
done

for f in  ${not_working}; do
    echo $f
    echo " skipped"
done
if [ "${#failed[@]}" -ne 0 ] ; then
    echo "Failed tests: ${failed[@]}" >&2
else
    echo "All tests ok"
fi
echo "Test failures: expected ${expect_fail}, actual ${#failed[@]}" >&2
if [ "${#failed[@]}" -ne $expect_fail ] ; then
    exit 1
else
    exit 0
fi

