# このソフトウェアについて

GitHubリポジトリを作成してローカルDBに登録するシェルスクリプト。 

# 開発環境

* Windows XP Pro SP3 32bit
    * cmd.exe
* [Python 3.4.4](https://www.python.org/downloads/release/python-344/)
    * [requests](http://requests-docs-ja.readthedocs.io/en/latest/)
    * [dataset](https://github.com/pudo/dataset)
    * [furl](https://github.com/gruns/furl)

## WebService

* [GitHub](https://github.com/)
    * [アカウント](https://github.com/join?source=header-home)
    * [AccessToken](https://github.com/settings/tokens)
    * [Two-Factor認証](https://github.com/settings/two_factor_authentication/intro)
    * [API v3](https://developer.github.com/v3/)

# 準備

## 必要なデータベースを作成する

* [GitHub.Accounts.Database](https://github.com/ytyaru/GitHub.Accounts.Database.20170107081237765)
    * [GiHubApi.Authorizations.Create](https://github.com/ytyaru/GiHubApi.Authorizations.Create.20170113141429500)
* [GitHub.Repositories.Database.Create](https://github.com/ytyaru/GitHub.Repositories.Database.Create.20170114123411296)

## パラメータ設定

`meta_up.sh`にある以下の変数を任意に設定する。

```sh
...
USER_NAME=GitHubUsername
SSH_HOST=github.com.${USER_NAME}
DB_ACCOUNTS="C:/GitHub.Accounts.sqlite3"
DB_REPO="C:/GitHub.Repositories.${USER_NAME}.sqlite3"
REPO_DESC=リポジトリ説明文。
REPO_HOME=http://```
...
# 共通HTTPヘッダ
HDR_TIMEZONE="Time-Zone: Asia/Tokyo"
HDR_AUTHOR="Authorization: token ${TOKEN}"

# リポジトリ名を取得（親ディレクトリ名）
REPO_NAME=`basename $(cd $(dirname $0) && pwd)`
```

# 実行

```dosbatch
python meta_up.sh
```

# 結果

リポジトリ取得した結果を`src/GiHubApi.Repositories.{username}.json`ファイルに保存する。

# ライセンス #

このソフトウェアはCC0ライセンスである。

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)
