contrib_icon_updater
====

## Description

twitterのユーザープロフィールをgithubのContribution Calendar（通称，草）の最新の情報を元に変更します．以下の機能をサポートしています．

- アイコンを草の濃さ毎に変更
- 名前のsuffixに年間コミット数を表示

これらの機能は`config.json`から実行の切り替えが設定できます．

## Requirement 

+ gem
+ bundler


## Usage

1. cloneします．

	```
	$ git clone git@github.com:tanitta/contrib_icon_updater.git
	```

2. bundle installします．

	```
	$ cd contrib_icon_updater
	$ bundle install
	```

3. consumer_key等の設定を行います．`_config.json`を`config.json`としてコピーし空欄を埋めること．
また，機能の切り替えは, `enable_to_change_icon`, `enable_to_change_name`フラグでそれぞれ指定ができます．
名前の変更機能を利用する場合，suffixが付与されるユーザー名を`user_name`に記入してください．

	```
	$ cp _config.json config.json
	$ vim config.json
	```

4. スクリプトを実行してtwitterのプロフィールを変更．

	```
	$ ruby bin/update_contrib_icon
	```
	
	permissionを設定するとインタプリタの指定無しで実行できるはず．
	
	```
	$ chmod 755 bin/update_contrib_icon # set permission
	$ bin/update_contrib_icon
	```
  
## Option

画像はresourceの中に置いているので適宜差し替えたりしてください．
