##  zsh: Environment
# no /etc/z* parsing
unsetopt GLOBAL_RCS
# language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

if [ -f $ZDOTDIR/githubaccesstoken ]; then
    . $ZDOTDIR/githubaccesstoken
fi

# python virtualenv
export WORKON_HOME=$HOME/.virtualenvs/
export PROJECT_HOME=$HOME/Coding/python/
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

