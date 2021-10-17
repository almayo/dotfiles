#!/usr/bin/env bash
set -ue

helpmsg() {
	command echo "Usage: $0 [--help | -h]" 0>&2
	command echo ""
}

link_to_homedir() {
	command echo "backup old dotfiles..."
	if [ ! -d "$HOME/.dotbackup" ];then
		command echo "$HOME/.dotbackup not found. Auto Make it"
		command mkdir -p "$HOME/.dotbackup/.config"
	fi

	local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
	local dotdir=$(dirname ${script_dir})
	if [[ "$HOME" != "$dotdir" ]];then
		for f in $dotdir/.??*; do
			[[ `basename $f` == ".git" ]] && continue
			[[ `basename $f` == ".config" ]] && continue
			if [[ -L "$HOME/`basename $f`" ]];then
				command rm -f "$HOME/`basename $f`"
			fi
			if [[ -e "$HOME/`basename $f`" ]];then
				command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
			fi
			command ln -snf $f $HOME
		done
		for d in $dotdir/.config/*; do
			if [[ -L "$HOME/.config/`basename $d`" ]];then
				command rm -f "$HOME/.config/`basename $d`"
			fi
			if [[ -e "$HOME/.config/`basename $d`" ]];then
				command mv "$HOME/.config/`basename $d`" "$HOME/.dotbackup/.config"
			fi
			command ln -snf $d $HOME/.config
		done
	else
		command echo "same install src dest"
	fi
}

while [ $# -gt 0 ];do
	case ${1} in
		--debug|-d)
			set -uex
			;;
		--help|-h)
			helpmsg
			exit 1
			;;
		*)
			;;
	esac
	shift
done

link_to_homedir
git config --global include.path "~/.gitconfig_shared"
command echo -e "\e[1;36m Install completed!!!! \e[m"

