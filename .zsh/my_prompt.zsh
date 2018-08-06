zstyle ':vcs_info:*' formats '%F{green}(%s)[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)[%b|%a]%f'
zstyle ':vcs_info:git:*' check-for-change true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '[%b|%a] %c%u'

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  PROMPT="%{$fg[yellow]%}┏━ %{$reset_color%}[%n]%{${fg[cyan]}%}[%~]%{${reset_color}%}%{${fg[yellow]}%}${vcs_info_msg_0_}%{${reset_color}%}
%{$fg[yellow]%}┗━ %{$reset_color%}%(?.%{${fg[green]}%}.%{${fg[red]}%})%#%{${reset_color}%} "
}
add-zsh-hook precmd _update_vcs_info_msg

