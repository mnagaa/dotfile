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
   - `Brewfile`に記載されたパッケージ（chezmoiを含む）をインストールします
   - または、chezmoi公式インストールスクリプトを使用することもできます:
     ```shell
     sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <GITHUB_USERNAME>
     ```

3. **aquaのパッケージインストール**
   - `aqua.yaml`に記載されたパッケージ（主にGoツール）をインストールします
   - Homebrewでインストールできないツールを管理します

4. **Git補完スクリプトのダウンロード**
   - `.zsh`ディレクトリにgit-prompt.sh、git-completion.bash、_gitをダウンロードします

5. **chezmoiによるドットファイルの管理**
   - chezmoiがインストールされている場合、chezmoiを使用してドットファイルを管理します
   - このリポジトリをchezmoiのソースディレクトリとして使用します
   - chezmoiがインストールされていない場合は、従来のシンボリックリンク方式で設定します

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

### JankyBorders設定

[JankyBorders](https://github.com/FelixKratz/JankyBorders)は、macOS用の軽量なウィンドウボーダーシステムです。アクティブなウィンドウを視覚的に強調表示します。

- `~/.config/borders/bordersrc`: JankyBordersの設定ファイル

#### インストール

`Brewfile`に含まれているため、`brew bundle`で自動的にインストールされます。

手動でインストールする場合:

```shell
brew tap FelixKratz/formulae
brew install borders
```

#### 起動方法

**設定ファイルを使用する場合:**

```shell
# 設定ファイルを適用（chezmoiを使用している場合）
chezmoi apply

# bordersを起動
borders
```

**brew servicesでサービスとして起動:**

```shell
brew services start borders
```

**yabaiと連携する場合:**

`yabairc`の最後に以下を追加:

```shell
borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0 &
```

#### 設定の変更

設定ファイル `~/.config/borders/bordersrc` を編集することで、以下のオプションを変更できます:

- `style`: ボーダーのスタイル（`round`または`square`）
- `width`: ボーダーの幅（ピクセル単位）
- `hidpi`: HiDPIモード（`on`または`off`）
- `active_color`: アクティブウィンドウのボーダー色（16進数形式、例: `0xffe2e2e3`）
- `inactive_color`: 非アクティブウィンドウのボーダー色（16進数形式、例: `0xff414550`）

設定を変更した後、既に`borders`プロセスが実行中の場合は、新しい設定で`borders`を再起動すると自動的に反映されます。

#### 設定ファイルの場所

chezmoiで管理している場合、設定ファイルは `private_dot_config/borders/bordersrc` にあります。

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

## chezmoiによるドットファイル管理

このリポジトリは[chezmoi](https://www.chezmoi.io/)を使用してドットファイルを管理します。chezmoiは、ドットファイルの管理を簡単かつ安全に行うためのツールです。

### なぜchezmoiを使うのか？

- **シンボリックリンクよりも柔軟**: ファイルの一部だけを変更したり、環境に応じた設定を適用できます
- **テンプレート機能**: 環境変数やOSに応じた設定を自動的に適用できます
- **安全な管理**: 既存のファイルを自動的にバックアップし、変更前に確認できます
- **マシン間での同期**: 複数のマシンで同じ設定を簡単に同期できます

### 初回セットアップ

chezmoiを使った初回セットアップには、以下の2つの方法があります:

#### 方法1: このリポジトリを使用する場合（推奨）

```shell
# リポジトリをクローン
git clone <repository-url> ~/dotfile
cd ~/dotfile

# セットアップスクリプトを実行（chezmoiも自動的にインストールされます）
make mac-setting
# または
./ctl_mac.sh

# または、chezmoiのみを手動で初期化する場合
make chezmoi-init
# または
chezmoi init --source $(pwd) --apply
```

#### 方法2: chezmoi公式インストールスクリプトを使用する場合

chezmoiの公式インストールスクリプトを使用して、GitHubリポジトリから直接インストールする場合:

```shell
# chezmoiをインストールし、GitHubリポジトリから初期化
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <GITHUB_USERNAME>

# その後、このリポジトリをソースとして設定
cd ~/dotfile
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi apply
```

**注意**: `<GITHUB_USERNAME>`は、chezmoiで管理したいGitHubリポジトリのユーザー名に置き換えてください。このリポジトリを使用する場合は、方法1を推奨します。

### 日常的な使い方

#### 設定ファイルを適用する

```shell
make chezmoi-apply
# または
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi apply
```

#### 変更内容を確認する

```shell
make chezmoi-diff
# または
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi diff
```

#### 管理状態を確認する

```shell
make chezmoi-status
# または
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi status
```

### 新しいファイルを追加する

新しいドットファイルを管理対象に追加する場合:

```shell
# 1. ホームディレクトリのファイルをchezmoiに追加
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi add ~/.newfile

# 2. chezmoiが追加したファイルを確認（リポジトリ内に追加されます）
# chezmoiはファイル名を変換します（例：.zshrc → dot_zshrc）
git status

# 3. 変更をコミット
git add .
git commit -m "Add .newfile"
```

**注意**: chezmoiはファイル名を変換します。ドットファイル（`.zshrc`など）は`dot_zshrc`、ディレクトリ（`.vim`など）は`dot_vim`という形式になります。

### テンプレート機能の使用

chezmoiはテンプレート機能をサポートしています。ファイル名に`.tmpl`拡張子を付けるか、ファイル内で`{{ }}`構文を使用できます。

例: `.zshrc.local.tmpl`で環境変数を使用:

```bash
export GIT_WORK_EMAIL='{{ .gitWorkEmail }}'
```

テンプレート変数は`.chezmoi.yaml`で定義するか、環境変数として設定できます。

### 既存のchezmoiリポジトリからの移行

既にchezmoiで管理しているドットファイルがある場合、このリポジトリに移行するには:

```shell
# 1. 現在のchezmoiのソースディレクトリを確認
chezmoi source-path

# 2. ファイルをこのリポジトリにコピー（必要に応じて）
# 3. このリポジトリをソースとして設定
CHEZMOI_SOURCE_DIR=$(pwd) chezmoi apply
```

### 既存のシンボリックリンク方式への切り替え

chezmoiを使わず、従来のシンボリックリンク方式を使いたい場合:

```shell
make symbolic-link
```

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

### chezmoi関連

#### chezmoiが正しく動作しない

chezmoiのソースディレクトリを確認:

```shell
chezmoi source-path
```

リポジトリをソースとして設定:

```shell
chezmoi source -- $(pwd)
```

#### ファイルが適用されない

chezmoiの状態を確認:

```shell
chezmoi status
```

強制的に適用:

```shell
chezmoi apply --force
```

### シンボリックリンクのエラー

chezmoiを使わない場合、既存のファイルが原因でエラーが発生した場合、バックアップディレクトリ（`~/.dotfile_backup_*`）を確認してください。

### nodenvが動作しない

nodenvを使用するには、シェル設定（`.zshenv`または`.zprofile`）に以下を追加してください:

```shell
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - zsh)"
```
