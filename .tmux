tmux splitw -h -p70
tmux send-keys -t 0 C-l
tmux send-keys -t 1 C-l 'vi' Enter
tmux send-keys -t 0 'bx guard' C-l Enter
tmux new-window
tmux send-keys -t 0 'bx thin start -p 1111' C-l Enter
tmux selectw -t 1
