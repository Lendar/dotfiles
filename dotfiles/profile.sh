export PATH=/usr/local/share/python:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:~/node_modules/.bin:/usr/local/share/npm/bin:~/bin:$PATH
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTIGNORE="&:l:vdir:[bf]g:exit"
export NODE_PATH=/usr/local/bin:$NODE_PATH
#FSHARP_COMPILER_BIN="/Library/Frameworks/Mono.framework/Versions/Current/lib/fsharp/bin"
export PYTHONPATH=/usr/bin/:/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH

# Set pbcopy to use UTF-8 by default
export __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:0x8000100

export EDITOR='subl -w'
# export EDITOR="open -a /Applications/Emacs.app";export EDITOR

alias nginx='sudo nginx -s reload'
export nginx_conf='/usr/local/etc/nginx/nginx.conf'

# network
# TODO: complete -W "$(egrep "^[^#]*(Host )([^*]*)$" ~/.ssh/config|sort -u)" ssh
mkdir -p ~/secure
alias mntsec='encfs ~/Dropbox/.secure-data ~/secure -ovolname=secure && chmod 0600 ~/secure/*.pem'

# DEPRECATED
alias mntapp='sshfs ec2-user@$appsrv: ~/remote-appsrv -ovolname=appsrv'
alias mntjd='sshfs ec2-user@$jdtest: ~/remote-jdtest -ovolname=jdtest'

alias gitx="open -a gitx ."

# brew
export EC2_HOME=/usr/local
# TODO: source /usr/local/etc/bash_completion.d/git-completion.bash

# system
alias ..="cd .."
alias ...="cd ../.."
# TODO: export PS1="\u@\h:\w\n$ "

alias nginx='sudo killall nginx && sudo launchctl load -w /Library/LaunchAgents/org.nginx.plist'
alias edit-nginx='subl $nginx_conf'
alias terminal-notifier='~/bin/terminal-notifier.app/Contents/MacOS/terminal-notifier'

# export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
source ~/iknow-aws.sh

# salt
alias salt-call="salt-call --local -c ~/.salt"
alias salt-master="salt-master -c ~/.salt"
alias salt-key="salt-key -c ~/.salt"
alias salt-minion="salt-minion -c ~/.salt"
alias salt-run="salt-run -c ~/.salt"
alias salt="salt -c ~/.salt"

# projects
function project() {
    source ~/projects/salt/iterm2_helpers.sh
    export DISABLE_AUTO_TITLE="true"
    tab_green "🐔 $1"
    export HISTFILE=~/.history-$1
    touch $HISTFILE
    fc -R
    cd ~/projects/$1
    export project="$1"
    env_script="$HOME/env/$1.zsh"
    if [[ -f "$env_script" && -r "$env_script" ]]; then
        source $env_script
    fi
}
function task() {
    taskid=$1
    # set -ex
    git fetch &&
    name=`git branch -a | sed -e s/\\*//g | grep $taskid | tr -d ' ' | head -n1` &&
    name=${name/remotes\/origin\/} &&
    echo "git checkout -t origin/$name || git checkout $name" &&
    git branch --set-upstream $name origin/$name &&
    (git checkout -t origin/$name || git checkout $name) &&
    new_commits=$(git rev-list ^HEAD @{upstream} | wc -l)
    git rebase
    if [[ new_commits -ne 0 ]]; then
        npm install --quiet
        bower install
    fi
    grunt server
}

if type compdef &>/dev/null; then
    # ZSH-only
    _project_complete() {
        compadd `ls ~/projects`
    }
    compdef _project_complete project
fi

doge
