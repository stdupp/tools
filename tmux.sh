#! /bin/bash

if [ "$#" -eq 0 ]
then
    echo "Usage: $0 <session> <ip-file>"
    exit
fi

s=$1
f=$2
c=`cat $f |wc -l`

let c=c-1
echo $c

tmux new -d -s "$s"

for i in `seq 0 $c`
do
	tmux splitw -t "$s"  -h -p 50
done

c=0
for ip in `cat $f`
do
	tmux select-pane -t $c\; send-keys "./login.expect $ip" C-m
	let c=c+1
done

tmux attach -d -t "$s"\; select-layout -t 0 tiled
