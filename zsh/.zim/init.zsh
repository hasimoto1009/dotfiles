zimfw() { source /Users/hashimoto.takashi/.config/zsh/.zim/zimfw.zsh "${@}" }
zmodule() { source /Users/hashimoto.takashi/.config/zsh/.zim/zimfw.zsh "${@}" }
typeset -g _zim_fpath=(/Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/git/functions /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/utility/functions /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/duration-info/functions /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/git-info/functions /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/zsh-completions/src)
fpath=(${_zim_fpath} ${fpath})
autoload -Uz -- git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw duration-info-precmd duration-info-preexec coalesce git-action git-info
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/environment/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/git/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/input/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/termtitle/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/utility/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/duration-info/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/asciiship/asciiship.zsh-theme
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/completion/init.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
source /Users/hashimoto.takashi/dotfiles/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
