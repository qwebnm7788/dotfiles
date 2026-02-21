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

# Cleanup git worktree and return to main repo
cld() {
  # 1. Check if we're in a git repo
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not in a git repository."
    return 1
  fi

  # 2. Check if we're in a linked worktree
  local git_dir=$(git rev-parse --path-format=absolute --git-dir)
  local common_dir=$(git rev-parse --path-format=absolute --git-common-dir)
  
  if [[ "$git_dir" == "$common_dir" ]]; then
    echo "Error: You are in the main repository, not a linked worktree."
    return 1
  fi

  # 3. Check for unpushed/uncommitted changes
  local current_branch=$(git branch --show-current)
  local uncommitted=$(git status --porcelain)
  local unpushed=""

  # Try to find an upstream tracking branch
  local upstream=$(git rev-parse --abbrev-ref "@{u}" 2>/dev/null)
  
  if [ -n "$upstream" ]; then
    # Tracking branch exists, check for commits not in upstream
    if [ -n "$(git log "$upstream..HEAD" --oneline 2>/dev/null)" ]; then
      unpushed="Unpushed commits relative to $upstream."
    fi
  else
    # No tracking branch. Check if a remote branch with the same name exists.
    # We look for any remote branch ending in /branch_name (e.g., origin/my-feature)
    local remote_branch=$(git branch -r | grep -E "/$current_branch$" | head -n 1 | xargs)
    
    if [ -n "$remote_branch" ]; then
      if [ -n "$(git log "$remote_branch..HEAD" --oneline 2>/dev/null)" ]; then
        unpushed="Unpushed commits relative to $remote_branch."
      fi
    else
      # No tracking and no remote branch with same name found.
      # Check if there are any commits at all on this branch.
      # If it's a new branch with work, it's technically "unpushed".
      unpushed="Branch '$current_branch' has no remote counterpart."
    fi
  fi

  if [ -n "$uncommitted" ] || [ -n "$unpushed" ]; then
    echo "Warning: Worktree has pending changes."
    [ -n "$uncommitted" ] && echo "- Uncommitted changes present."
    [ -n "$unpushed" ] && echo "- $unpushed"
    
    echo -n "Proceed with removal? (y/n): "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
      echo "Aborted."
      return 1
    fi
  fi

  # 4. Cleanup
  local worktree_path=$(git rev-parse --show-toplevel)
  local main_repo_path=$(cd "$common_dir/.." && pwd)

  echo "Returning to main repo: $main_repo_path"
  cd "$main_repo_path" || return 1
  
  # Remove the worktree directory and registration
  git worktree remove "$worktree_path" --force
  
  # Optionally delete the branch
  echo -n "Delete branch '$current_branch' too? (y/n): "
  read -r response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    git branch -D "$current_branch"
  fi
}
