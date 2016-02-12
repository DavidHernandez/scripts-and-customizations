#!/bin/sh

tmux new-session -d -s $1

tmux send-keys -t $1:0 "cd ~/CLIENT/$1/www/dev.$1.es" C-m
tmux rename-window 'drush'

tmux new-window -t $1:1 -n "Logs" ;
tmux split-window -h ;
tmux select-pane -L
tmux send-keys -t $1:1 "sudo tail -f /var/log/apache2/error.log" C-m
tmux select-pane -R
tmux send-keys -t $1:1 "cd ~/CLIENT/$1/www/dev.$1.es" C-m
tmux send-keys -t $1:1 "drush ws --tail" C-m

tmux new-window -t $1:2 -n "code" "vi ~/CLIENT/$1/src"

tmux new-window -t $1:3 -n "sql" "cd ~/CLIENT/$1/www/dev.$1.es; drush sqlc"

tmux new-window -t $1:4 -n "git"
tmux send-keys -t $1:4 "cd ~/CLIENT/$1/src" C-m

tmux select-window -t $1:2

tmux -2 attach-session -t $1
