# dotfile

個人用のdotfile設定リポジトリです。

## セットアップ

前提: このリポジトリは **`~/dotfile`** にクローンすること（`.zsh/plugins.zsh` が
`~/dotfile/.zplug` を参照するため）。

```shell
git clone git@github.com:mnagaa/dotfile.git ~/dotfile
cd ~/dotfile
make mac-setting
```

または

```shell
./ctl_mac.sh
```

実行内容:
1. Homebrewのインストール（未インストールの場合。sudoパスワードの入力が必要）
2. `Brewfile`からパッケージをインストール
3. `aqua.yaml`からパッケージをインストール
4. Git補完スクリプトのダウンロード
5. ドットファイルをシンボリックリンクで配置（既存ファイルは`~/.dotfile_backup_*`に退避）
6. Vimのmolokaiテーマをインストール
7. nodenvのセットアップ

ドットファイルの配置だけをやり直したい場合:

```shell
make symbolic-link
```

## 設定ファイル

### zsh
- `.zshrc`: メイン設定ファイル
- `.zshenv`: 環境変数設定
- `.zprofile`: ログイン時設定
- `.p10k.zsh`: Powerlevel10k設定

### Gitアカウント切り替え

このリポジトリでは`.envrc`で環境変数を管理しています。

```shell
# 仕事用アカウントに切り替え
gwork

# プライベート用アカウントに切り替え
gpersonal

# 現在のアカウント情報を確認
gaccount
```

### vim
- `.vimrc`: Vim設定ファイル
- `.vim`: プラグインと設定ディレクトリ

### borders
- `~/.config/borders/bordersrc`: 設定ファイル

起動: `borders` または `brew services start borders`

## chezmoi について（現状は補助的な位置づけ）

chezmoiは**ソースディレクトリ内の "." 始まりのエントリを無視する**仕様のため、
このリポジトリの `.zshrc` / `.zshenv` / `.gitconfig` などは chezmoi では管理されない。
（管理するには `dot_zshrc` のようにリネームが必要）

そのため `chezmoi apply` を実行しても、

- ドットファイルは一切配置されず、
- 代わりに `README.md` / `Makefile` / `Brewfile` / `cmd/` などが `$HOME` 直下にコピーされる

という状態だった。現在は `.chezmoiignore` でリポジトリ管理用ファイルを除外してあるため、
chezmoiが実際に管理するのは `private_dot_config/` 配下（`~/.config/borders/bordersrc`）のみ。

ドットファイルの配置は `make symbolic-link` を使うこと。

状態の確認のみ:

```shell
make chezmoi-diff
make chezmoi-status
```

全面的にchezmoi管理へ移行する場合は、`.zshrc` → `dot_zshrc` のリネームと
`cmd/setup_synbolic_links.sh` の廃止をセットで行う必要がある。

## パッケージ管理

### Homebrew
```shell
brew bundle          # インストール
brew bundle dump     # ダンプ
```

### aqua
```shell
aqua install -a      # インストール
aqua update          # 更新
```
