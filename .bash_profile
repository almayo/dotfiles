# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PS1="\[\e[0;36m\][\u@\h \[\e[m\]\w\[\e[0;36m\]]\[\e[m\]\n\\$ "

# tmux start
(type tmux >/dev/null 2>&1) && \
    [[ $TERM != "screen-256color" ]] && \
    [[ -z $TMUX ]] && tmux -2 -S "${XDG_RUNTIME_DIR}"/tmux.socket new-session -A -s main
