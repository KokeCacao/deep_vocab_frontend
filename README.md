<h1 align="center">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab.png" alt="Deep Vocab" width="200">
  <br>深度单词: Deep Vocab<br>
</h1>

<h4 align="center">最科学的记忆方式</h4>

<p align="center">
  <img src="https://api.codemagic.io/apps/611d38a986db0df7ae0505e0/611d38a986db0df7ae0505df/status_badge.svg">
  <img src="https://img.shields.io/github/v/release/kokecacao/deep_vocab?include_prereleases">
  <img src="https://img.shields.io/github/last-commit/kokecacao/deep_vocab">
  <img src="https://img.shields.io/website?down_message=offline&up_message=online&url=https%3A%2F%2Fwww.kokecacao.me">
</p>

## 特性: Features

深度单词 Deep Vocab 致力于打造第一款信息时代的单词记忆软件. 其运用机器学习算法为您实时推送快要忘记的单词, 已达到最省时间, 最高效的记忆.

<p align="center">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab_01.png" height="400">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab_02.png" height="400">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab_03.png" height="400">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab_04.png" height="400">
</p>

## 下载: Download

还在开发中, 敬请期待...

## 联系: Contacts

hankec@andrew.cmu.edu

## 贡献: Contribution Guideline

### Commit Emoji
|   Commit type              | Emoji                                         |
|:---------------------------|:----------------------------------------------|
| Initial commit             | :tada: `:tada:`                               |
| Version tag                | :bookmark: `:bookmark:`                       |
| New feature                | :sparkles: `:sparkles:`                       |
| Bugfix                     | :bug: `:bug:`                                 |
| Documentation              | :books: `:books:`                             |
| Performance                | :racehorse: `:racehorse:`                     |
| Tests                      | :rotating_light: `:rotating_light:`           |
| Improve format/structure   | :art: `:art:`                                 |
| Removing code/files        | :fire: `:fire:`                               |
| Upgrading dependencies     | :arrow_up: `:arrow_up:`                       |
| Downgrading dependencies   | :arrow_down: `:arrow_down:`                   |
| Work in progress           | :construction:  `:construction:`              |
| Breaking changes           | :boom: `:boom:`                               |
| Move/rename repository     | :truck: `:truck:`                             |
| Other                      | [Be creative](http://www.emoji-cheat-sheet.com/)  |

Inspired by [GitCommitEmoji.md](https://gist.github.com/parmentf/035de27d6ed1dce0b36a)

## 更新: Changelog

<details>
  <summary>[Click Here To Expand]</summary>
  
```
2020/01/06: :sparkles: finish dragging list UI
2020/01/07: :sparkles: finish quick-multi-selection UI (4 different option, big interactive area, accurate sliding feedback, color differentiation)
            :construction: start vocab database design
2020/01/08: register company
2020/01/09: :sparkles: vocab detail screen first design (tab)
2020/01/11: :sparkles: vocab detail screen second design (slide up with blackened background, more detail but hide, more interactive, big control area)
2020/01/12: :construction: thinking about new feature: pause music when not reviewing vocab.
            :construction: thinking about new feature: growing plants for each vocab. 单词永远置顶(备忘录).
            :sparkles: complete most UI elements.
            :bug: fix password obscure.
2020/01/13: :art: adjust code structure
2020/01/21: :sparkles: first write json for vocab
2020/01/22: :sparkles: json serialization and database
2020/01/23: :construction: connect database to actual screen
2020/01/24: :sparkles: connect database to actual screen
2020/01/25: :sparkles: finish sliding to mark vocab and link to database
            :sparkles: finish vocab selection ui
2020/01/26: :sparkles: finish selecting vocab, frontend
2020/01/27: :sparkles: finish pinMark backend
2020/01/28: :sparkles: added pull (refresh) vocab functionality
2020/01/29: :sparkles: finish downloading user vocab to fetch vocab list
            :sparkles: added graphql query and support RESTful download
2020/01/30: :sparkles: finish downloading vocab header
2021/06/11: :sparkles: finish refreshing vocab and basic LTM/STM prediction
2021/06/12: :bug: fix hide meaning after refresh
2021/06/26: :bug: fix refresh algorithm
            :bug: fix http_proxy in /etc/.profile
2021/06/27: :art: change refactor BottomNavigationBadge
            :boom: fully upgrade to support null-safety
            :books: documentation for README.md and code
            :sparkles: now alert user if there are task
            :arrow_up: upgrade to android API 30
            :arrow_up: upgrade gradle, gradle-wrapper and kotlin plugin
2021/07/17: :arrow_up: add background_fetch package
2021/07/18: :sparkles: auto-refresh every 15 min
            :arrow_up: upgrade fl_chart package
            :racehorse: add empty screen for initialization after provider
            :bug: fix notifyListeners() error after dispose() on ViewModels
            :sparkles: add stats screen and 3 plots
            :art: README image created using mockuphone.com with "Google Pixel 4 Just Black"
            :art: fix README, rename init_callback
            :sparkles: add line chart to individual vocab; remove from stats
2021/08/15: :bug: fix display after refresh
            :sparkles: add arguments to backends
            :sparkles: deploy on remote server
            :books: simplify environment.yml by remove build info
2021/08/17: :sparkles: remove stats http handling, calculated locally
            :bug: make calendar stats transparent
            :bug: fix stats chart when not logged in
            :sparkles: add icon
            :sparkles: add .jks to gitignore
            :sparkles: add key.properties to gitignore
            :sparkles: prepare for release
2021/08/18: :fire: remove fsearch
            :sparkles: support more android ISA
2021/08/20: :sparkles: add bottom_navigation_badge as submodule
2021/08/21: :sparkles: fix password security issue. support utf8 password
2021/08/22: :bug: fix unique columns in database
            :art: better print message
            :bug: with_for_update on insert update (flask-sqlitealchemy provides auto rollback last commit on error), implement erase_cache (https://github.com/sqlalchemy/sqlalchemy/issues/4774)
2021/08/23: :bug: make userVocab and markColor requests sequential to avoid concurrency issue
            :bug: fix formating issue in vocab translation
            :sparkles: add log upload feature
            :bug: fix accepting graphql arguments
2021/08/24: :arrow_up: upgrade snackbar system
            :sparkles: add update checks
2021/08/25: :sparkles: email verification when registeration
            :sparkles: add double password verification
2021/08/27: :sparkles: finish changing password, new UI
2021/09/22: :construction: IOS build success on 5e60538
2021/09/26: :sparkles: added ThemeDataWrapper; change Navigation logic; Account UI; Progress Bar
            :sparkles: change AndroidManifest.xml
            :construction: increment build 1->2
            :sparkles: remove debug flag (send actual email) backend, add graphene-file-upload
            :construction: increment build 2->3; Switch to release server
            :sparkles: add permission handler; change deep_vocab to Deep Vocab
            :construction: increment build 3->4
2022/01/07: :sparkles: implement SSL / TSL
2022/01/15: :sparkles: add backdoor command to create user
            :sparkles: validate found password
            :sparkles: reserve UI space for empty vocab list
2022/01/29: :sparkles: add progress indicator
2022/02/05: :bug: maybe fixed IOS FocusNode issue when login
            :sparkles: add label to progress indicator
            :bug: fix unable to refresh when there is no vocab
            :bug: test logs in iOS
2022/02/06: :sparkles: dark mode for everything except vocabpenel, login, logout, dev_screen
            :arrow_up: bump up build version
            :arrow_up: migrate to v2 AndroidManifest.xml
            :bug: bottom navigation badge deprecate `old.title`
            :arrow_up: MinimumOSVersion change from 8.0 to 9.0 in bottom navigation badge
            :arrow_up: package dependency upgraded
            :arrow_up: upgrade Flutter to 2.10.0 from 2.2.3 in /opt/flutter
            :bug: resolve dependency issue related to Moor: https://forums.raywenderlich.com/t/ch-15-problem-using-moor-generator/155792
            :bug: fix fl_chart update bug
            :bug: regenerate app_database.g
            :bug: bump up compileSdkVersion from 30 to 31 since 30 is unsupported
            :bug: fixed bugs in v0.1.0-7, bump up version
            :sparkles: fixed non-allow download before login; add login UI

```
</details>

## Known Issues
```
1. in dismissible_vocab_row.dart, in mark_color_mutation.py (re-write it)
adjust grpahql mutation to create and update sequentially

2. not sure whether "erase_cache" will work with .query.populate_existing().get()

3. lag detected when doing vocab add request by sliding (due to listening to database changes)

4. do not mix mutation and query in front end, start using types and variable (especially fix backend `String` to `UUID`). Try using https://github.com/comigor/artemis

5. sync time zone: https://pub.dev/packages/timezone

6. error message should be more clear, not just throw error

7. limite rate of sending email from server side (can be solved by limit request/sec for ip)

8. test that actually not sending multiple request

9. set restriction on field using validate, only validate once when submit?


ui too small

10. https://github.com/adar2378/pin_code_fields/issues/204

```

## TODO 后端 (for v0.0.1 milestone)
- [ ] Add: Documentation
- [ ] Add: Allow user modify password, if success, try logout user

## TODO 美术 (for v0.0.1 milestone)
- [ ] Add: better avatar
- [ ] Add: better download screen design
- [ ] Fix: improve UI

## TODO 前端 (for v0.0.1 milestone)
CHECK YOUR EMAIL
- [ ] Add: Documentation
- [ ] Add: Dark Mode
- [ ] Add: xp system by active time
- [ ] Add: filter by star/pin
- [ ] Add: [Large] search bar
- [ ] Add: [Large] app notification
- [ ] Add: [Large] password changing by email and email verification
- [ ] Add: [Large] wechat login / binding

## TODO (less important)
- [ ] Fix: datetime should be consistent and use universal timestamp and convert to local time when appropriate. but user display should display according to local time zone (especially in stats)
- [ ] Add: automatically direct user to download vocab when opening the learning tab
- [ ] Add: Vocab count in [已完成] section
- [ ] Add: Stats (something like App usage in IOS) (See: https://ft-interactive.github.io/visual-vocabulary/) (vocab/time, how-long-does-it-take-to-remember-1-vocab, )
- [ ] Add: search bar
- [ ] Add: notification for unsuccessful refresh due to internet connection
- [ ] Fix: login screen button to always shown above keyboard
- [ ] Fix: login screen scroll view wave animation
- [ ] Add: global configuration
- [ ] Fix: box lose data?
- [ ] Fix: optimization: https://segmentfault.com/a/1190000019462984
- [ ] Fix: solve green rectangle https://github.com/flutter/flutter/issues/16810
- [ ] Optimize: download need text indication
- [ ] Optimize: make hide vocab bigger
- [ ] Optimize: make vocabs bigger (or adjustable)
- [ ] Optimize: 注册时 actually 引导到注册
- [ ] Optimize: must contain one letter 省略号看不到
- [ ] Optimize: 邮件验证码加到标题
- [ ] Optimize: 更改密码 不要调到 register
- [ ] Optimize: 背了以后需要反馈 选中了哪个需要反馈
- [ ] Bug: why sharing vocab data.
- [ ] Optimize: add special character to password



## Inspirations
[[UI]](https://zhuanlan.zhihu.com/p/38045611), [[UI]](https://zhuanlan.zhihu.com/p/69265395)
