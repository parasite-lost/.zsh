## DIRCOLORS
eval `gdircolors $ZDOTDIR/.zsh_dircolors.ansi-dark`


##############
# COMPLETION #
##############
zstyle ':completion:*' completer _expand _complete _correct # _approximate # (dangerous!)
zstyle ':completion:*' expand prefix
#zstyle ':completion:*' list-colors 'di=34:fi=0:ln=35:so=32:pi=33:ex=31:bd=5:cd=5:or=31:mi=0'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-,]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' special-dirs true
# zstyle ':completion:*' menu select=10
zstyle ':completion::complete:*' use-cache 1
autoload -Uz compinit
compinit

###########
# HISTORY #
###########
HISTFILE=$HOME/.zhistfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd autopushd extendedglob nomatch share_history combining_chars noclobber

############
# SECURITY #
############
# case `/usr/bin/tty` in
# /dev/vc/*|*/dev/tty*)
# echo "Shell auto timeout sequence started."
# export TMOUT=300
# ;;
# esac

########
# MISC #
########
REPORTTIME=10 # print statistics for commands running longer than 10 seconds

if [[ $(id -ru) -eq 0 ]]; then # if root
umask 0022 # u=rwx,go+rx-w
else
umask 0077 # u=rwx,go-rwx
fi


ulimit -Sc 0 # no core files
zmodload zsh/datetime

# Colorize stderr
#exec 2>>(while read; do
# print '\e[91m'${(q)REPLY}'\e[0m' >> /dev/tty; print -n $'\0';
#done &)

autoload -Uz edit-command-line
zle -N edit-command-line

############## PATH ##############

typeset -U path
path=(
~/bin # user progs
/usr/local/opt/coreutils/libexec/gnubin # gnuprogs with real names
/usr/local/opt/gnu-sed/libexec/gnubin
/usr/local/opt/python/libexec/bin # python 2.7.13+ from homebrew
# /opt/local/bin
# /opt/local/sbin
${path}
# ~/.cabal/bin
# /usr/texbin
# /usr/X11/bin
)
typeset -U manpath
manpath=(
/usr/local/opt/coreutils/libexec/gnuman
/usr/local/opt/gnu-sed/libexec/gnuman
${manpath}
)
fpath=(
~/.zsh
${fpath}
)


###################
bindkey '[3~' delete-char
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line
bindkey '[A' up-line-or-history
bindkey '[B' down-line-or-history
bindkey '[D' backward-char
bindkey '[C' forward-char
bindkey '[5~' history-search-backward
bindkey '[6~' history-search-forward
bindkey '' history-incremental-search-backward
bindkey '' history-incremental-search-forward

bindkey 'OH' beginning-of-line
bindkey 'OF' end-of-line

bindkey -v
# fix backspace
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "\e[1~" beginning-of-line # home key
bindkey -M viins "\e[4~" end-of-line # end key
bindkey -M viins "\e[3~" delete-char # delete key
bindkey -M viins "\e[5~" history-search-backward # page down
bindkey -M viins "\e[6~" history-search-forward # page up

bindkey -M vicmd "e" edit-command-line

#source ~/bin/zsh/autoload
autoload -Uz promptinit
promptinit
autoload -Uz colors
colors

#autoload -Uz lookupinit && lookupinit
#zstyle ':lookup:*' txt-browser w3m
#zstyle ':lookup:*' txt-formats "%s"
#zstyle ':lookup:*' gui-browser chromium-browser
#zstyle ':lookup:*' gui-formats -remote "openurl(%s)"
#zstyle ':lookup:*' use-pager true
#zstyle ':lookup:*' pager-auto true
#zstyle ':lookup:*' pager less -M
#zstyle ':mime:.pdf:' handler open -a Skim %s

#### POWERLINE:
powerline-daemon -q
source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

help() {
echo -e "
/ directories
. plain files
@ symbolic links
= sockets
p named pipes (FIFOs)
* executable plain files (0100)
% device files (character or block special)
%b block special files
%c character special files
r owner-readable files (0400)
w owner-writable files (0200)
x owner-executable files (0100)
A group-readable files (0040)
I group-writable files (0020)
E group-executable files (0010)
R world-readable files (0004)
W world-writable files (0002)
X world-executable files (0001)
s setuid files (04000)
S setgid files (02000)
t files with the sticky bit (01000)
print *(m-1) # Dateien, die vor bis zu einem Tag modifiziert wurden.
print *(a1) # Dateien, auf die vor einem Tag zugegriffen wurde.
print *(@) # Nur Links
print *(Lk+50) # Dateien die ueber 50 Kilobytes grosz sind
print *(Lk-50) # Dateien die kleiner als 50 Kilobytes sind
print **/*.c # Alle *.c - Dateien unterhalb von \$PWD
print **/*.c~file.c # Alle *.c - Dateien, aber nicht 'file.c'
print (foo|bar).* # Alle Dateien mit 'foo' und / oder 'bar' am Anfang
print *~*.* # Nur Dateien ohne '.' in Namen
chmod 644 *(.^x) # make all non-executable files publically readable
print -l *(.c|.h) # Nur Dateien mit dem Suffix '.c' und / oder '.h'
print **/*(g:users:) # Alle Dateien/Verzeichnisse der Gruppe >users<
echo /proc/*/cwd(:h:t:s/self//) # Analog zu >ps ax | awk '{print $1}'<"
}

# source aliases
if [ -f $ZDOTDIR/.zsh_aliases ]; then
	. $ZDOTDIR/.zsh_aliases
fi

## OPAM configuration
#export C_INCLUDE_PATH=/usr/local/include
#export LIBRARY_PATH=/usr/local/lib
#. /Users/god/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
