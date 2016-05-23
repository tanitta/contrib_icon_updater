contrib_icon_updater
====

# Description

twitterのユーザーアイコンをgithubのContribution Calendar（通称，草）の色に変更するやつ．

# Requirement 

+ gem
+ bundler


# Usage

1. cloneする．

    $ git clone git@github.com:tanitta/contrib_icon_updater.git

2. bundle installする．

    $ cd contrib_icon_updater
    $ bundle install

3. consumer_key等の設定をする．\_config.jsonをconfig.jsonとしてコピーし空欄を埋めること．

    $ cp \_config.json config.json
    $ vim config.json

4. スクリプトを実行してtwitterのアイコンを変更する．

    $ ruby bin/update_contrib_icon
  
permissionを設定するとインタプリタの指定無しで実行できるはず．

    $ chmod 755 bin/update_contrib_icon # set permission
    $ bin/update_contrib_icon
  
# Option
画像はresourceの中に置いているので適宜差し替えたりしてください．
