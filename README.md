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

3. **Git補完スクリプトのダウンロード**
   - `.zsh`ディレクトリにgit-prompt.sh、git-completion.bash、_gitをダウンロードします

4. **シンボリックリンクの設定**
   - zsh、git、vimの設定ファイルをホームディレクトリにリンクします
   - 既存のファイルは自動的にバックアップされます（`~/.dotfile_backup_YYYYMMDD_HHMMSS/`）

5. **Vimのmolokaiテーマのインストール**
   - `~/.vim/colors/molokai.vim`にインストールします

6. **nodenvのセットアップ**
   - nodenvとnode-buildプラグインをインストールします

### Linux

```shell
make linux-setting
```

または直接実行:

```shell
./ctl_linux.sh
```

## 設定ファイルの説明

### zsh設定

- `.zshrc`: zshのメイン設定ファイル
- `.zshenv`: 環境変数の設定
- `.zprofile`: ログイン時の設定
- `.p10k.zsh`: Powerlevel10kの設定

### git設定

- `.gitconfig`: Gitの設定ファイル

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

## Homebrew

### Brewfileからインストール

```shell
brew bundle
```

### Brewfileにダンプ

```shell
brew bundle dump
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
