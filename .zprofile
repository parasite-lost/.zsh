## .zprofile
## set path variables 

#~/bin/zsh/compile_zsh_scripts
path=(
~/bin # user progs
/usr/local/opt/coreutils/libexec/gnubin # gnuprogs with real names
# /opt/local/bin
# /opt/local/sbin
${path}
# ~/.cabal/bin
# /usr/texbin
# /usr/X11/bin
)
manpath=(
/usr/local/opt/coreutils/libexec/gnuman
${manpath}
)
fpath=(
~/.zsh
${fpath} )

