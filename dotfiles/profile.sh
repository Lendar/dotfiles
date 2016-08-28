export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:~/node_modules/.bin:~/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTIGNORE="&:l:vdir:[bf]g:exit"
#FSHARP_COMPILER_BIN="/Library/Frameworks/Mono.framework/Versions/Current/lib/fsharp/bin"
export PYTHONPATH=/usr/bin/:/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH

# Android Profile
export PATH=$PATH:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
export ANDROID_HOME=~/Library/Android/sdk
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ANDROID_HOME/tools/lib
export LANG="en_US"
export LC_ALL=$LANG.UTF-8

# Set pbcopy to use UTF-8 by default
export __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:0x8000100

export EDITOR='subl -w'
# export EDITOR="open -a /Applications/Emacs.app";export EDITOR

export nginx_conf='/usr/local/etc/nginx/nginx.conf'

# network
# TODO: complete -W "$(egrep "^[^#]*(Host )([^*]*)$" ~/.ssh/config|sort -u)" ssh
mkdir -p ~/secure
alias mntsec='encfs ~/Dropbox/.secure-data ~/secure -ovolname=secure && sleep 2 && chmod 0600 ~/secure/*.pem'

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

alias edit-nginx='subl $nginx_conf'
alias terminal-notifier='~/bin/terminal-notifier.app/Contents/MacOS/terminal-notifier'

# export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"

# salt
alias salt-call="salt-call --local -c ~/.salt"
alias salt-cloud="salt-cloud -c ~/.salt"
alias salt-master="salt-master -c ~/.salt"
alias salt-key="salt-key -c ~/.salt"
alias salt-minion="salt-minion -c ~/.salt"
alias salt-run="salt-run -c ~/.salt"
alias salt="salt -c ~/.salt"

# projects
function project() {
    source ~/.iterm2_helpers.sh
    export project="$1"
    export DISABLE_AUTO_TITLE="true"
    tab_green "🐔 $1"
    project_folder="$HOME/projects/$project"
    if [ ! -d "$project_folder" ]; then
        read -q "REPLY?Create project $project? (y/n)" || return
        echo
        mkdir -p "$project_folder"
        echo "Created $project_folder"
        mkdir -p "$project_folder/.git"
        master_settings="$HOME/Dropbox/scotty/raven"
        cp -v "$master_settings/gitconfig/$project" "$project_folder/.git/config"
        cp -v "$master_settings/history/.history-$project" ~/
        cd "$project_folder"
        git init .
        echo "Created project"
    fi
    export HISTFILE=~/.history-$1
    touch $HISTFILE
    fc -R
    cd "$project_folder"
    env_script="$HOME/env/$1.zsh"
    if [[ -f "$env_script" && -r "$env_script" ]]; then
        source $env_script
    fi
    projectfile="$HOME/Dropbox/dev/sublime/$1.sublime-project"
    if [ -e $projectfile ]; then
        echo 'Opening sublime in background...'
        subl -n -b --project $projectfile
    fi
    projectfile="$HOME/Dropbox/Library/Application Support/Sublime Text 2/Projects/$1.sublime-project"
    if [ -e $projectfile ]; then
        echo 'Opening sublime in background...'
        subl -n -b --project $projectfile
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

function archive-project() {
    project $1
    git fetch
    echo "Archiving... To restore use: git clone --mirror"
    git bundle create ../$project.git.bundle --all
    zip ~/secure/archive/$project.git.bundle.zip ../$project.git.bundle
}

function reload() {
    . ~/env/$project.zsh
}

if type compdef &>/dev/null; then
    # ZSH-only
    _project_complete() {
        compadd `ls ~/projects`
    }
    compdef _project_complete project
    compdef _project_complete archive-project
fi

doge
