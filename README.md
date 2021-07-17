<h1 align="center">
  <img src="https://github.kokecacao.me/chenhanke.me/assets/images/deep_vocab.png" alt="Deep Vocab" width="200">
  <br>深度单词: Deep Vocab<br>
</h1>

<h4 align="center">最科学的记忆方式</h4>

<p align="center">
  <img src="https://img.shields.io/appveyor/build/kokecacao/deep_vocab_frontend">
  <img src="https://img.shields.io/github/v/release/kokecacao/deep_vocab_frontend?include_prereleases">
  <img src="https://img.shields.io/github/last-commit/kokecacao/deep_vocab_frontend">
  <img src="https://img.shields.io/website?down_message=offline&up_message=online&url=https%3A%2F%2Fwww.kokecacao.me">
</p>

## 特性: Features

深度单词 Deep Vocab 致力于打造第一款信息时代的单词记忆软件. 其运用机器学习算法为您实时推荐快要忘记的单词, 已达到最省时间, 最高效的记忆.

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
2020/01/14: naming failure, next name: "深度残差", "深度玻尔兹曼", "深度二叉", "深度卷积图", "深度全卷积", "基于深度学习的", "深度图", "深度调参", "初春"
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
            :arrow_up: add background_fetch package
2021/06/28: :sparkles: auto-refresh every 15 min
            :arrow_up: upgrade fl_chart package
            :racehorse: add empty screen for initialization after provider

```
</details>

## TODO
- [ ] Add: automatically direct user to download vocab when opening the learning tab
- [ ] Add: Vocab count in [已完成] section
- [ ] Add: Stats (something like App usage in IOS) (See: https://ft-interactive.github.io/visual-vocabulary/) (vocab/time, how-many-in-7-days, how-long-does-it-take-to-remember-1-vocab, )
- [ ] Add: search bar
- [ ] Add: notification for unsuccessful refresh due to internet connection
- [ ] Fix: login screen button to always shown above keyboard
- [ ] Fix: login screen scroll view wave animation
- [ ] Add: global configuration
- [ ] Fix: box lose data?
- [ ] Fix: optimization: https://segmentfault.com/a/1190000019462984
- [ ] Fix: solve green rectangle https://github.com/flutter/flutter/issues/16810

## Inspirations
[[UI]](https://zhuanlan.zhihu.com/p/38045611), [[UI]](https://zhuanlan.zhihu.com/p/69265395)
