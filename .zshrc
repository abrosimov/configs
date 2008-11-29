autoload -U compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false

zstyle ':completion:*:processes-names' command 'ps xho command'

PROMPT="%n@%m %~ %(!.#.$) "
RPROMPT='%T'

setopt autocd

hash -d anime=/mnt/user_space/Anime/

alias -g L='| less'
alias -g G='| grep'
alias -g GI='|grep -i'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g SU='|sort -u'
alias -g P='| patch -p1'
alias -g PD='| patch -p1 --dry-run'
alias -g WC='| wc -l'

alias man="LC_ALL=en_US.UTF-8 man"
alias rxit="exit"
alias exir="exit"
alias eexit="exit"
alias exitt="exit"
alias sl="ls"
alias ls="ls --color"
alias cd..="cd .."
alias rm="rm -i"
alias св="cd"
alias ды="ls"
alias pya="ping ya.ru"
alias mplayer="mplayer -lavdopts threads=2:fast:skiploopfilter=all"
alias umplayer="mplayer -utf8 -lavdopts threads=2:fast:skiploopfilter=all"
alias cmplayer="mplayer -subcp cp1251 -lavdopts threads=2:fast:skiploopfilter=all"
alias kmplayer="mplayer -subcp koi8-r -lavdopts threads=2:fast:skiploopfilter=all"
alias slapt-get="slapt-get --no-md5"
alias la="ls --color"
alias :q="exit"
alias :Q="exit"
alias :q!="exit"
alias :Q!="exit"
alias vf="cd"
alias xs="cd"
alias vimm="vim"
alias kess="less"
alias top="htop"
alias sodu="sudo"
alias sido="sudo"
alias sidi="sudo"
alias sudi="sudo"
alias sudp="sudo"
alias suds="sudo"
alias 550="ssh 550.nigma.ru"
alias ncmpc="ncmpcpp"
alias df="df -m"
setopt CORRECT_ALL
SPROMPT="Ошибка! Вы хотели ввести %r вместо %R? ([Y]es/[N]o/[E]dit/[A]bort) "

autoload -U tetris
zle -N tetris
bindkey ^T tetris
        
case $TERM in
    linux)
        bindkey "^[[2~" yank
        bindkey "^[[3~" delete-char
        bindkey "^[[5~" up-line-or-history
        bindkey "^[[6~" down-line-or-history
        bindkey "^[[1~" beginning-of-line
        bindkey "^[[4~" end-of-line
        bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
        bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
        bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
        bindkey " " magic-space ## do history expansion on space
    ;; 
    *xterm*|rxvt|(dt|k|E)term)
        bindkey "^[[2~" yank
        bindkey "^[[3~" delete-char
        bindkey "^[[5~" up-line-or-history
        bindkey "^[[6~" down-line-or-history
        bindkey "^[[7~" beginning-of-line
        bindkey "^[[8~" end-of-line
        bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
        bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
        bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
        bindkey " " magic-space ## do history expansion on space
    ;;
esac
