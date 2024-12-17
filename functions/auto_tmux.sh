#!/bin/bash
# auto_tmux.sh | v.1.0 | 12.11.24

start_tmux() {
	session_name=$1
	if [ -z "$session_name" ]; then
		session_name="session"
	fi	
	if tmux has-session -t $session_name 2>/dev/null; then
	    tmux attach-session -t $session_name
	else
	    tmux new-session -d -s $session_name
		tmux split-window -v

	    # Process 0: CLIENT
	    tmux send-keys -t 0 C-m
	    sleep 2
	    tmux send-keys -t 0 'rename CLIENT $bold_red' C-m
	    tmux send-keys -t 0 'goto recent && cd frontend && npm run build && clear && npm run dev' C-m

		# Process 1: SERVER
	    tmux send-keys -t 1 C-m
	    sleep 2
		tmux send-keys -t 1 'rename SERVER $bold_blue' C-m
	    tmux send-keys -t 1 'goto recent && cd backend && clear && npm run start' C-m

		tmux split-window -h
		tmux split-window -v

		# Process 2: JSX
	    tmux send-keys -t 2 C-m
	    sleep 2
		tmux send-keys -t 2 'rename JSX $bold_purple' C-m
		tmux send-keys -t 2 'goto recent && cd frontend/src/pages && clear' C-m
		
        # Process 3: GIT
	    tmux send-keys -t 3 C-m
	    sleep 2
		tmux send-keys -t 3 'rename GIT $bold_yellow' C-m
	    tmux send-keys -t 3 'goto recent && clear' C-m

		tmux split-window -h

		# Process 4: CSS
	    tmux send-keys -t 4 C-m
		sleep 2
		tmux send-keys -t 4 'rename CSS $green' C-m
		tmux send-keys -t 4 'goto recent && cd frontend/src/styles && clear' C-m
	
		tmux attach-session -t $session_name
	fi
}
