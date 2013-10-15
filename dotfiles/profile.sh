export PATH=/usr/local/share/python:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:~/node_modules/.bin:/usr/local/share/npm/bin:~/bin:$PATH
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTIGNORE="&:l:vdir:[bf]g:exit"
export NODE_PATH=/usr/local/bin:$NODE_PATH
#FSHARP_COMPILER_BIN="/Library/Frameworks/Mono.framework/Versions/Current/lib/fsharp/bin"
export PYTHONPATH=/usr/bin/:/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH

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
    cd ~/projects/$1
    source ~/env/$1.zsh
}
function task() {
    taskid=$1
    # set -ex
    git fetch
    name=`git branch -a | sed -e s/\\*//g | grep $taskid | tr -d ' ' | head -n1`
    name=${name/remotes\/origin\/}
    echo "git checkout -t origin/$name || git checkout $name"
    git checkout -t origin/$name || git checkout $name
    git rebase
    npm install
    bower install
    grunt server
}

if type compdef &>/dev/null; then
    # ZSH-only
    _project_complete() {
        compadd `ls ~/projects`
    }
    compdef _project_complete project
fi
