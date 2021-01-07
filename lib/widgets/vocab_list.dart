import 'package:deep_vocab/widgets/vocab_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'multi_dismissible.dart';

class VocabList extends StatelessWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return VocabListState();
//   }
// }
//
// class VocabListState extends State<VocabList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    void _onRefresh() async {
      await Future.delayed(Duration(seconds: 1));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      enableTwoLevel: true,
      header: ClassicHeader(
        // TODO: more customize
        releaseText: "松手刷新",
        refreshingText: "刷新中",
        canTwoLevelText: "超大力的刷新!",
        completeText: "complete",
        failedText: "failed",
        idleText: "下拉刷新",
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          return Container(
            height: 55.0,
            child: Center(child: Text("没有了哦")),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _refreshController.loadComplete,
      onTwoLevel: _onRefresh,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (context, i) => MultiDismissible(
            child: VocabRow(),
            builder: (Widget child, MultiDismissibleStatus status) {
              if (status == MultiDismissibleStatus.ON_IDLE) return child;
              VocabRow vocabRow = child;
              return VocabRow(cross: !vocabRow.cross, hide: vocabRow.hide, checkBox: vocabRow.checkBox,);
            },
          ),
        ),
    );
  }
}
