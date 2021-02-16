export RSYNC_RSH=ssh
export EDITOR=vim
if [ z`hostname -s` = zheiding ]; then
  col=36
else
  col=33
fi

export BLOCKSIZE=1024

# ⍻ U+237B NOT CHECK MARK
# ✓ U+2713 CHECK MARK
# ✔ U+2714 HEAVY CHECK MARK
# ✕ U+2715 MULTIPLICATION X
# ✖ U+2716 HEAVY MULTIPLICATION X
# ✗ U+2717 BALLOT X
# ✘ U+2718 HEAVY BALLOT X

# U+FE0E VARIATION SELECTOR-15
# U+FE0F VARIATION SELECTOR-16
# ✓︎ <2713, FE0E>
# ✓️ <2713, FE0F>
# ✔︎ <2714, FE0E>
# ✔️ <2714, FE0F>
# ✖︎ <2716, FE0E>
# ✖️ <2716, FE0F>
# ✘︎ <2718, FE0E>
# ✘️ <2718, FE0F>

# ❦

function __git_clean_or_dirty() {
  if [ -z "$(git status -s)" ]; then
    echo -n '%{[01;32m%}✔'
  else
    echo -n '%{[01;31m%}✗'
  fi
}

function __git_prompt_info() {
  plain_git_prompt=$(__git_prompt_info_plain)
  if [ ! -z "$plain_git_prompt" ]; then
    echo -n '%{[01;32m%}['"$plain_git_prompt] $(__git_clean_or_dirty)%{[01;${col}m%} "
  else
    echo -n ''
  fi
}

function __git_prompt_info_plain() {
  git branch 2>/dev/null | grep -E '^\*' | cut -c 3-
}

setopt PROMPT_SUBST
PS1="%{[01;${col}m%}"'%m %l %T %~ $(__git_prompt_info)%#%{[0m%} '
if `which gls &>/dev/null`
then alias ls='gls --color=auto -T 0 -F'
else
  if `/bin/ls --color &>/dev/null`
  then alias ls='/bin/ls --color=auto -T 0 -F'
  fi
fi
alias la='ls -a'
alias ll='ls -hl'
alias lla='ll -a'

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;34:*.au=00;34:*.flac=00;34:*.mid=00;34:*.midi=00;34:*.mka=00;34:*.mp3=00;34:*.mpc=00;34:*.ogg=00;34:*.ra=00;34:*.wav=00;34:*.axa=00;34:*.oga=00;34:*.spx=00;34:*.xspf=00;34:';

setopt noclobber
setopt -h

export PATH=$HOME/opt/bin:$HOME/bin:$PATH

bindkey -v
bindkey '' beginning-of-line
bindkey '' end-of-line

if [ -d $HOME/.rvm ]; then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  [ -f $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm
fi
export PATH=/usr/local/texlive/2013/bin/x86_64-darwin:$PATH

if [ -d /usr/local/heroku ]; then
  ### Added by the Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"
fi
if [ -d /usr/local/Cellar/bazaar ]; then
  export PYTHONPATH=/usr/local/Cellar/bazaar/2.6.0/lib/python2.7/site-packages
fi

# Why not.
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
