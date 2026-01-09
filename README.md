# dotfile

個人用のdotfile設定リポジトリです。

## セットアップ

```shell
make mac-setting
```

または

```shell
./ctl_mac.sh
```

実行内容:
1. Homebrewのインストール（未インストールの場合）
2. `Brewfile`からパッケージをインストール
3. `aqua.yaml`からパッケージをインストール
4. Git補完スクリプトのダウンロード
5. chezmoiでドットファイルを適用
6. Vimのmolokaiテーマをインストール
7. nodenvのセットアップ

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

## chezmoi

### 基本的なコマンド

```shell
# 設定を適用
make chezmoi-apply

# 変更内容を確認
make chezmoi-diff

# 管理状態を確認
make chezmoi-status
```

### 新しいファイルを追加

```shell
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi add ~/.newfile
```

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
