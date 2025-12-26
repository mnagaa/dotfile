# ==========================================
# カスタム関数定義
# ==========================================

# fh - repeat history (fzfで履歴から選択して実行)
fh () {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed" >&2
    return 1
  fi

  local selected
  selected=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')

  if [[ -n "$selected" ]]; then
    eval "$selected"
  fi
}

# gbr - checkout git branch (fzfでブランチを選択してチェックアウト)
gbr() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed" >&2
    return 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed" >&2
    return 1
  fi

  local branches branch branch_name
  branches=$(git --no-pager branch -vv --no-color 2>/dev/null)

  if [[ $? -ne 0 ]]; then
    echo "Error: Not a git repository" >&2
    return 1
  fi

  branch=$(echo "$branches" | fzf +m)

  if [[ -z "$branch" ]]; then
    return 0  # キャンセルされた場合
  fi

  branch_name=$(echo "$branch" | awk '{print $1}' | sed "s/.* //")

  if [[ -n "$branch_name" ]]; then
    git checkout "$branch_name"
  fi
}

