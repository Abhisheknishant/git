#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success 'test' '
	touch file &&
	old=$(test-tool chmtime --get =-1 file) &&
	touch file &&
	new=$(test-tool chmtime --get file) &&
	test $old -lt $new
'

test_done
