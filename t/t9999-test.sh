#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success 'test' '
	one_sec_ago=$(date -d "@$(($(date +"%s") - 1))" "+%Y%m%d%H%M%S") &&
	touch -t ${one_sec_ago%??}.${one_sec_ago#????????????} file &&
	old=$(date -r file "+%s") &&
	touch file &&
	new=$(date -r file "+%s") &&

	test "$old" != "$new"
'

test_done
