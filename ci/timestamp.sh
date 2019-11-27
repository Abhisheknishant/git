#!/bin/sh

cat >timestamp.sh <<-\EOF
#!/bin/sh

set -ex

i=0
while true
do
	printf "$i\r"
	i=$((i + 1))

	# set a file's mtime to one second ago
	now=$(date "+%s.%N")
	one_sec_ago=$(date -d "@$((${now%.*} - 1))" "+%Y%m%d%H%M%S")
	touch -t ${one_sec_ago%??}.${one_sec_ago#????????????} file
	# save its actual mtime
	old=$(date -r file "+%s.%N")
	# set its mtime to now
	touch file
	# the current the mtime should be different, but sometimes it isn't
	new=$(date -r file "+%s.%N")
	test "${old%.*}" != "${new%.*}"
done
EOF
chmod u+x timestamp.sh
./timestamp.sh 2>out
echo
tail -n11 out
