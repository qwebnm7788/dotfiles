# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Zim configuration
zstyle ':zim:input' double-dot-expand yes


# Module configuration

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source /opt/homebrew/opt/zimfw/share/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Initialize zsh-defer
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh

zsh-defer _evalcache zoxide init zsh
zsh-defer _evalcache mise activate zsh
# -------------------
# User configuration
# -------------------

# Customize p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
eval "$(rbenv init - zsh)"

# Added by Antigravity
export PATH="/Users/jaewon/.antigravity/antigravity/bin:$PATH"

# ADB
export PATH="$PATH:/Users/jaewon/Library/Android/sdk/platform-tools"
export PATH="$HOME/.local/bin:$PATH"

# Go configuration
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# Claude worktree with agent selection
clx() {
  local branch_name
  if [ -z "$1" ]; then
    branch_name="worktree-$(date +%Y%m%d-%H%M%S)"
  else
    branch_name="$1"
  fi

  # Create worktree and navigate to it
  git worktree add "../$branch_name" -b "$branch_name" || return 1
  cd "../$branch_name" || return 1

  # Interactive agent selection
  PS3="Select an AI agent (1-2): "
  select agent in "Claude" "Gemini"; do
    case $REPLY in
      1)
        claude --model opusplan --permission-mode plan
        break
        ;;
      2)
        gemini
        break
        ;;
      *)
        echo "Invalid selection. Please select 1 (Claude) or 2 (Gemini)."
        ;;
    esac
  done
}
