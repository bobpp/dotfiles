# NOT_AUTO_DEPLOY Dir

例えば `.ssh` ディレクトリは自身のマシンの `id_rsa`, `id_rsa.pub` も置かれるので、ディレクトリ全体を symlink することが出来ない。
そのため、特殊な deploy 手順が必要になる。
このディレクトリはそういうものを配置するためのディレクトリです。

## ssh の設定を例にした構造の解説
```
NOT_AUTO_DEPLOY/
  ssh/
    .ssh/
      config
    deploy.sh
```

上記のような構造になっており、
- `NOT_AUTO_DEPLOY/ssh` 設定のひとかたまりを押し込むためのディレクトリ
- `NOT_AUTO_DEPLOY/ssh/.ssh/config` 実際に `$HOME/.ssh/config` に symlink されるファイル
- `NOT_AUTO_DEPLOY/ssh/deploy.sh` `NOT_AUTO_DEPLOY/ssh/.ssh/config` を `$HOME/.ssh/config` に symlink したりする配置用のシェルスクリプト。ひとかたまりごとに記載する。

`NOT_AUTO_DEPLOY/*/deploy.sh` が `make deploy` 時にすべて実行されるようになっている。