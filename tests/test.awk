#!/usr/bin/awk -f

# test.awk: Compare actual.txt with expected.txt, allowing [TIME] as a timestamp placeholder

BEGIN {
    passed = 1
    line = 0

    # Load expected lines from second file (expected.txt)
    while ((getline expectedLine < ARGV[2]) > 0) {
        line++
        expected[line] = expectedLine
    }

    delete ARGV[2]  # remove expected.txt so AWK processes only actual.txt
}

{
    line++
    actual = $0
    expectedLine = expected[line]

    # Match timestamp in the form [YYYY-MM-DDTHH:MM:SS]
    if (match(actual, /\[([0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2})Z\] (.*)/)) {
        ts_len = RLENGTH
        msg = substr(actual, ts_len + 1)
    } else {
        printf("FAIL: Line %d: Invalid or missing timestamp: %s\n", line, actual)
        passed = 0
        next
    }

    # If expected line begins with [TIME], strip it
    if (index(expectedLine, "[TIME] ") == 1) {
        expectedLine = substr(expectedLine, 8)
    }

    if (msg != expectedLine) {
        printf("FAIL: Line %d:\n  expected: %s\n  actual:   %s\n", line, expectedLine, msg)
        passed = 0
    }
}

END {
    if (passed) {
        print "PASS: all lines matched with valid timestamps"
        exit 0
    } else {
        print "FAIL: differences found"
        exit 1
    }
}
