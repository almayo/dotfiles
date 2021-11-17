# .bashrc

#-----------------------------------------------------
# Source global definitions
#-----------------------------------------------------
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

if type hcli >/dev/null 2>&1 ;then
    . ${HOME}/.bashrc.d/work.sh
fi

if grep -q home <(cat /etc/hostname) ;then
    . ${HOME}/.bashrc.d/home.sh
fi

#-----------------------------------------------------
# global vars
#-----------------------------------------------------
export HISTIGNORE='?:??:???:exit'
export HISTSIZE=100000
export LESS="-FRSMKi"
[[ -z $TMUX ]] && export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

#-----------------------------------------------------
# shell options 
#-----------------------------------------------------
shopt -s histappend
shopt -s no_empty_cmd_completion

#-----------------------------------------------------
# User specific aliases and functions
#-----------------------------------------------------
alias 'ls'='ls --color=auto'
alias 'rm'='rm -i'
alias 'cp'='cp -i'
alias 'mv'='mv -i'
alias 'll'='ls -l'
alias 'la'='ls -la'
function graphawk() {
    awk 'BEGIN {
            split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec", month_name);
            for (i=1; i<=12; i++) month[month_name[i]]=sprintf("%02d", i);
        }
        {
            sub(/^\[/,"",$4); sub(/:/," ",$4);
            split($4,time); split(time[1],date,"/");
            $4="[" date[3] "-" month[date[2]] "-" date[1] "_" time[2];
            print $0;
        }'
}

#-----------------------------------------------------
# keybind
#-----------------------------------------------------
if [[ -t 1 ]] ;then
    bind '"\C-f": forward-word'
    bind '"\C-b": backward-word'
fi

#-----------------------------------------------------
# tmux setting
#-----------------------------------------------------
if (type tmux >/dev/null 2>&1) && [[ -n $TMUX ]] ;then
    ## auto logging
    if [[ $TERM = screen ]] || [[ $TERM = screen-256color ]] ;then
        LOGDIR=$HOME/logs/term_log
        LOGFILE=$(cat /etc/hostname)_$(date +%Y-%m-%d_%H%M%S_%N.log)
        FILECOUNT=0
        MAXFILECOUNT=100

        for file in `\find "$LOGDIR" -maxdepth 1 -type f -name "*.log" | sort --reverse`; do
            FILECOUNT=`expr $FILECOUNT + 1`
            if [ $FILECOUNT -ge $MAXFILECOUNT ]; then
                rm -f $file
            fi
        done
        [ ! -d $LOGDIR ] && mkdir -p $LOGDIR
        tmux pipe-pane   "cat >> $LOGDIR/$LOGFILE" \; \
        display-message  "Started logging to $LOGDIR/$LOGFILE"
    fi
fi
