# Built-in improvements
alias ls='eza --icons --group-directories-first --color=auto'
alias la='eza -a --icons --group-directories-first --color=auto'
alias ll='eza -lh --icons --group-directories-first --color=auto'
alias less='less -SRXF'
alias mv='mv -v'
alias cp='cp -v'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias open='xdg-open'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias net='nmtui'

alias v='nvim'
alias nv='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias top='btop'
alias news='clx -n --indent 3 --article-width 100 --comment-width 100 --graphics=always --pages 5 --show-images-on-open'
alias rss='newsboat'
alias restore="gtrash r"
alias op='opencode'
alias md='glow --pager'
alias copy='wl-copy'
alias blue='bluetuith'
alias music='cliamp'
alias pn='pnpm'
alias speedtest='speedtest-go'
alias reader='bookokrat'

# Script
alias t="$DOTFILES/scripts/bin/tmux-init.sh"
alias of="$DOTFILES/scripts/bin/open-file.sh"
alias ytdl="$DOTFILES/scripts/bin/yt-audio-dl.sh"
