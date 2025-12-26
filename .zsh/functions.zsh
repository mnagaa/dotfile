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

# ==========================================
# Gitアカウント切り替え関数
# ==========================================

# git-work - 仕事用アカウントに切り替え（現在のリポジトリのローカル設定を変更）
git-work() {
  # gitリポジトリ内かチェック
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: gitリポジトリ内で実行してください" >&2
    return 1
  fi

  if [[ -z "$GIT_WORK_NAME" ]] || [[ -z "$GIT_WORK_EMAIL" ]]; then
    echo "Error: GIT_WORK_NAME と GIT_WORK_EMAIL が設定されていません" >&2
    echo "以下のように環境変数を設定してください:" >&2
    echo "  export GIT_WORK_NAME='Your Work Name'" >&2
    echo "  export GIT_WORK_EMAIL='your.work@email.com'" >&2
    return 1
  fi

  git config --local user.name "$GIT_WORK_NAME"
  git config --local user.email "$GIT_WORK_EMAIL"
  echo "✓ Gitアカウントを仕事用に切り替えました"
  echo "  Name:  $GIT_WORK_NAME"
  echo "  Email: $GIT_WORK_EMAIL"
}

# git-personal - プライベート用アカウントに切り替え（現在のリポジトリのローカル設定を変更）
git-personal() {
  # gitリポジトリ内かチェック
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: gitリポジトリ内で実行してください" >&2
    return 1
  fi

  if [[ -z "$GIT_PERSONAL_NAME" ]] || [[ -z "$GIT_PERSONAL_EMAIL" ]]; then
    echo "Error: GIT_PERSONAL_NAME と GIT_PERSONAL_EMAIL が設定されていません" >&2
    echo "以下のように環境変数を設定してください:" >&2
    echo "  export GIT_PERSONAL_NAME='Your Personal Name'" >&2
    echo "  export GIT_PERSONAL_EMAIL='your.personal@email.com'" >&2
    return 1
  fi

  git config --local user.name "$GIT_PERSONAL_NAME"
  git config --local user.email "$GIT_PERSONAL_EMAIL"
  echo "✓ Gitアカウントをプライベート用に切り替えました"
  echo "  Name:  $GIT_PERSONAL_NAME"
  echo "  Email: $GIT_PERSONAL_EMAIL"
}

# git-account - 現在のGitアカウント情報を表示（ローカル設定を優先）
git-account() {
  local current_name current_email scope

  # ローカル設定を優先して取得
  current_name=$(git config --local user.name 2>/dev/null)
  current_email=$(git config --local user.email 2>/dev/null)

  if [[ -n "$current_name" || -n "$current_email" ]]; then
    scope="(ローカル)"
  else
    # ローカル設定がなければグローバル設定を使用
    current_name=$(git config --global user.name 2>/dev/null)
    current_email=$(git config --global user.email 2>/dev/null)
    scope="(グローバル)"
  fi

  echo "現在のGitアカウント設定 $scope:"
  echo "  Name:  ${current_name:-未設定}"
  echo "  Email: ${current_email:-未設定}"
  echo ""
  echo "利用可能なコマンド:"
  echo "  git-work     - 仕事用アカウントに切り替え"
  echo "  git-personal - プライベート用アカウントに切り替え"
  echo "  git-account  - 現在のアカウント情報を表示"
}

