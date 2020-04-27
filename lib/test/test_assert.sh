# ----------------------------------------------------------------------------------------------------------------------
# best | Copyright (C) 2020 eth-p | MIT License
#
# Repository: https://github.com/eth-p/best
# Issues:     https://github.com/eth-p/best/issues
# ----------------------------------------------------------------------------------------------------------------------

# Asserts a statement returns true.
#
# Arguments:
#     ... [string]    -- The command and arguments to execute.
#
# Example:
#
#     assert [ "true" = false ]
#     assert ! false
#
:PREFIX:assert() {
	if [[ "$1" = "!" ]]; then
		if ! "$@" &>/dev/null; then
			return 0
		fi
	else
		if "$@" &>/dev/null; then
			return 0
		fi
	fi

	__best_ipc_send_test_result "FAIL"
	__best_ipc_send_test_result_message "Assertion failed: %s"
	__best_ipc_send_test_result_message_data "$*"
	exit 1
}

# Asserts one value equals another value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_equal 2 2
#
:PREFIX:assert_equal() {
	:PREFIX:assert [ "$1" = "$2" ]
	return $?
}

# Asserts one value does not equal another value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_not_equal 1 2
#
:PREFIX:assert_not_equal() {
	:PREFIX:assert [ "$1" != "$2" ]
	return $?
}

# Asserts one value is less than the other value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_less 1 2
#
:PREFIX:assert_less() {
	:PREFIX:assert [ "$1" -lt "$2" ]
	return $?
}

# Asserts one value is less than or equal to the other value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_less_or_equal 2 2
#
:PREFIX:assert_less_or_equal() {
	:PREFIX:assert [ "$1" -le "$2" ]
	return $?
}

# Asserts one value is greater than the other value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_greater 5 2
#
:PREFIX:assert_greater() {
	:PREFIX:assert [ "$1" -gt "$2" ]
	return $?
}

# Asserts one value is greater than or equal to the other value.
#
# Arguments:
#     $1  [string]    -- The first value.
#     $2  [string]    -- The second value.
#
# Example:
#
#     assert_greater_or_equal 2 2
#
:PREFIX:assert_greater_or_equal() {
	:PREFIX:assert [ "$1" -ge "$2" ]
	return $?
}


# Asserts that the test exits with a specific exit code.
#
# Arguments:
#     $1  [number]    -- The expected exit code.
#
# Example:
#
#     assert_exit 1
#
:PREFIX:assert_exit() {
	__best_ipc_send "TEST_SHOULD_COMPLETE_WITH" "$1"
}
