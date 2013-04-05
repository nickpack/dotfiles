# Remove this if you arent using OSX otherwise you'll end up with recursion ;)
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Set some sensible defaults
export EDITOR='vi'
export SVN_EDITOR='vi'
export VISUAL='vi'
export CLICOLOR=1
export ANDROID_SDK_ROOT='/usr/local/opt/android-sdk'
export NODE_PATH='/usr/local/lib/node_modules'
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/share/python:/usr/local/heroku/bin:$PATH"
export HISTCONTROL="erasedups"
export HISTSIZE=5000
export HISTIGNORE=ls:ll:"ls -altr":"ls -alt":la:l:pwd:exit:mc:su:df:clear:ps:"ps aux":h:history:"ls -al"
shopt -s histappend
shopt -s checkwinsize

# Stupidly high number of file descriptors (mainly for ab)
ulimit -n 10000

# These probably arent massively useful unless you are an android/linux dev on OSX
# I build ARM binaries a lot!
function iDroidEnv { hdiutil attach ~/iDroid/ics.dmg -mountpoint /Volumes/android; cd /Volumes/android; . build/envsetup.sh; export CROSS_COMPILE='/usr/local/Cellar/android-ndk/r7/toolchains/arm-linux-androideabi-4.4.3/prebuilt/darwin-x86/bin/arm-linux-androideabi-'; export ARCH='arm'; }

alias dropbox2='HOME=~/iDroid /Applications/Dropbox.app/Contents/MacOS/Dropbox'

# Hipster Shit
alias startpg9='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias startmongo='nohup mongod run --config /usr/local/etc/mongod.conf &'
alias startredis='redis-server /usr/local/etc/redis.conf'
alias redistogo='redis-cli -h cod.redistogo.com -p 9884 -a'
alias herokuoff='heroku maintenance:on'
alias herokuon='heroku maintenance:off'
alias pushheroku='git push heroku HEAD:master'
alias herokudbbackup='heroku pgbackups:capture --expire'
alias pyenv='source venv/bin/activate'
alias vagvm='vagrant up --provider=vmware_fusion'
alias gw='grunt watch'

# Misc
alias ding='growl "Done!"'
alias cwd='pwd | pbcopy'
alias randpass="openssl rand -base64 12"

# DVCS lazyness
alias gs='git status'
alias g='git'
alias gb='git checkout -b'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gd='git diff | $EDITOR'
alias ga='git add'
alias gl='git log'
alias gpr='git pull --rebase'
alias st='svn status | grep -v "^X      " | grep -v "^Performing status on external item"'
alias get-current-branch="git branch 2>/dev/null | grep '^*' | colrm 1 2"
alias get-current-color="if [[ \$(get-current-branch) == \"master\" ]] ; then echo \"1;33m\" ; else echo \"0;32m\" ; fi"

# common command adjustments/common typos
alias rm='rm -i'
alias cd..='cd ..'
alias cd.='cd `pwd -LP`'
alias su-='su -'
alias gunt='grunt'

# Sometimes canhaz dotfiles for common operations
alias dotson='shopt -s dotglob'
alias dotsoff='shopt -u dotglob'

# Remember where I was last kthx
if [ -f ~/.cdpath ]; then
  cd "$(cat ~/.cdpath)"
fi

# Dir and file colours pl0x
LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35\
    :bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31\
    :*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31\
    :*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35\
    :*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35\
    :*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35\
    :*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35\
    :*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35"

LS_COLORS="$LS_COLORS\
    :*.html=00;33:*.htm=00;33:*.doc=00;33:*.txt=00;33:*.css=00;33\
    :*.conf=00;33:*README=00;33\
    :*.shtml=01;33:*.java=01;33:*.c=01;33:*.cc=01;33:*.cpp=01;33\
    :*.php=01;33:*.pl=01;33:*.h=01;33:*.inc=01;33:*.pm=01;33:*.py=01;33\
    :*core=1;41:*dead.letter=01;41\
    :*.class=00;32;32:*.o=00;32:*.so=00;32:*.exe=00;32\
    :*,v=01;30:*.bak=01;30:*~=01;30"

export LS_COLORS

# I r english, canhaz GB locale kthx
[ -z "$LANG" ] && export LANG="en_GB.UTF8"

# Show me directory contents when I change directories
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

# Integer representation of domain registration status
domain() {
  # see http://troy.yort.com/short-fast-micro-whois
  result=`dig -t NS "$1" | grep -c "ANSWER SECTION"`
  if [ "$result" = "0" ]; then
    # some registered domains have no NS resource record in root servers; may
    # be false negative, so confirm with whois
    result=`whois -n "$1" | grep -c "Registrar: "`
  fi
  echo $result
}

localtime() {
        perl -e "print scalar localtime $1";
            echo;
}

gmtime() {
        perl -e "print scalar gmtime $1";
            echo;
}

pyhelp() {
        echo "import $1;help($1)" | python | less
}

b64e() { perl -e 'use MIME::Base64 qw(encode_base64);$/=undef;print encode_base64(<>);'; }
b64d() { perl -e 'use MIME::Base64 qw(decode_base64);$/=undef;print decode_base64(<>);'; }

pack() {
        gzip -c $* | b64e
}

unpack() {
        b64d | gunzip
}

packf() {
        tar -cf - $* | gzip | b64e
}

unpackf() {
        b64d | tar -zxf -
}

parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "svn::"$1 "/" $2 ""}'
}

parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}

parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

function pathed_cd () {
    if [ "$1" == "" ]; then
        cd
    else
        cd "$1"
    fi
    rm -f ~/.cdpath
    pwd > ~/.cdpath
}
alias cd="pathed_cd"

# Prompt with branch and colours
export PS1="\[\033[1;30m\]\\u@\h \[\033[0;37m\]\\W:\[\033[\$(get-current-color)\]\$(parse_svn_branch)\$(get-current-branch)\\[\033[0m\]\$ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
