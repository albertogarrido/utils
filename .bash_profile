#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH=/usr/local/mysql/bin:/Users/k40s/android-sdks/tools:/Applications/MAMP/Library/bin/:$PATH


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
# export TERM=xterm-256color

################### alias ###################

#system utilities
alias resetbashProfile='source ~/.bash_profile;echo -n "Done";'
alias editbashProfile='subl ~/.bash_profile'
alias ls='ls -aFhlG'
alias ll='ls -l'
alias search=grep
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v='vim'

## MAMP
alias webserverdirectory='cd /Applications/MAMP/htdocs'

#directory
alias gotowebServerDirectory='cd /Library/WebServer/Documents/;echo -n " ***  Your current directory is:";pwd'
alias gotoworkspace='cd ~/Dropbox/workspace;echo -n " *** Your current directory is:";pwd'

##project directory
#alias themeDirectoryWorkmans='cd /Library/WebServer/Documents/theworkmansclub/wp-content/themes/theworkmansclub-theme/;echo -n " ***  Your current directory is:";pwd'
#alias themeDirectoryWebMob='cd /Library/WebServer/Documents/webmobnew/wp-content/themes/moviweb-tpl/;echo -n " ***  Your current directory is:";pwd'
# alias themeDirectory='cd /Library/WebServer/Documents/theworkmansclub/wp-content/themes/theworkmansclub-theme/;echo -n " ***  Your current directory is:";pwd'~/

#apps
alias sb='subl'

#Connections
alias sshHome='ssh -p 22222 innerfunction@173.203.78.246'
alias sshClients='ssh -p 22222 innerfunction@173.203.91.164'
alias sshk40s='ssh -l k40s k40s.org'
alias mysqlk40s='mysql -u k40s -p -h mysql.k40s.org'




#colores de javi
# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PROMPT_COMMAND='echo -ne "\033]0;k40s_sh@: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac