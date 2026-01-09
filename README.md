# dotfile

個人用のdotfile設定リポジトリです。

## セットアップ方法

### Mac

```shell
make mac-setting
```

または直接実行:

```shell
./ctl_mac.sh
```

このスクリプトは以下の処理を実行します:

1. **Homebrewのインストール**（未インストールの場合）
   - Apple Silicon Macの場合は自動的にパスを追加します

2. **brew bundleの実行**
   - `Brewfile`に記載されたパッケージをインストールします

3. **aquaのパッケージインストール**
   - `aqua.yaml`に記載されたパッケージ（主にGoツール）をインストールします
   - Homebrewでインストールできないツールを管理します

4. **Git補完スクリプトのダウンロード**
   - `.zsh`ディレクトリにgit-prompt.sh、git-completion.bash、_gitをダウンロードします

5. **シンボリックリンクの設定**
   - zsh、git、vimの設定ファイルをホームディレクトリにリンクします
   - 既存のファイルは自動的にバックアップされます（`~/.dotfile_backup_YYYYMMDD_HHMMSS/`）

6. **Vimのmolokaiテーマのインストール**
   - `~/.vim/colors/molokai.vim`にインストールします

7. **nodenvのセットアップ**
   - nodenvとnode-buildプラグインをインストールします

## 設定ファイルの説明

### zsh設定

- `.zshrc`: zshのメイン設定ファイル
- `.zshenv`: 環境変数の設定
- `.zprofile`: ログイン時の設定
- `.p10k.zsh`: Powerlevel10kの設定

### git設定

- `.gitconfig`: Gitの設定ファイル

#### Gitアカウントの切り替え

仕事用とプライベート用のGitアカウントを簡単に切り替えられます。

**初期設定:**

環境変数を設定します（`~/.zshrc.local`などに追加することを推奨）:

```shell
export GIT_WORK_NAME='Your Work Name'
export GIT_WORK_EMAIL='your.work@email.com'
export GIT_PERSONAL_NAME='Your Personal Name'
export GIT_PERSONAL_EMAIL='your.personal@email.com'
```

**使用方法:**

```shell
# 仕事用アカウントに切り替え
gwork
# または
git-work

# プライベート用アカウントに切り替え
gpersonal
# または
git-personal

# 現在のアカウント情報を確認
gaccount
# または
git-account
```

### vim設定

- `.vimrc`: Vimの設定ファイル
- `.vim`: Vimのプラグインと設定ディレクトリ
- `.ideavimrc`: IntelliJ IDEAのVim設定（`.vimrc`へのシンボリックリンク）

## その他の設定

### p10k（Powerlevel10k）

設定を変更する場合:

```shell
p10k configure
```

### Vimフォント設定

1. フォントファイルをダウンロード: https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf
2. ファイルを開いて「フォントをインストール」を選択
3. ターミナルの設定 > プロファイル > テキスト > フォント > 「Menlo Nerd Font」を選択

### Vimプラグインのインストール

初回セットアップ時:

```shell
vim
```

Vim起動後、`:PlugInstall`を実行してプラグインをインストールします。

## パッケージ管理

### Homebrew

Homebrewでインストール可能なパッケージ（brew、cask、vscode拡張機能）は`Brewfile`で管理します。

#### Brewfileからインストール

```shell
brew bundle
```

#### Brewfileにダンプ

```shell
brew bundle dump
```

### aqua

Homebrewでインストールできないツール（主にGoツール）は`aqua.yaml`で管理します。

#### aqua.yamlからインストール

```shell
aqua install -a
```

#### aqua.yamlに追加

新しいツールを追加する場合は、`aqua.yaml`にパッケージを追加してから:

```shell
aqua install
```

または、特定のパッケージのみインストール:

```shell
aqua install <package-name>
```

#### aqua.yamlの更新

レジストリやパッケージの更新:

```shell
aqua update
```

## トラブルシューティング

### シンボリックリンクのエラー

既存のファイルが原因でエラーが発生した場合、バックアップディレクトリ（`~/.dotfile_backup_*`）を確認してください。

### nodenvが動作しない

nodenvを使用するには、シェル設定（`.zshenv`または`.zprofile`）に以下を追加してください:

```shell
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - zsh)"
```
