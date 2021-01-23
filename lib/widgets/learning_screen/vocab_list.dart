import 'package:deep_vocab/widgets/learning_screen/dismissible_vocab_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VocabList extends StatelessWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return VocabListState();
//   }
// }
//
// class VocabListState extends State<VocabList> {
  final bool refreshable;
  final int itemCount;
  final void Function(RefreshController controller) onRefresh;
  final void Function(RefreshController controller) onTwoLevel;
  final Widget Function(BuildContext context, int index) itemBuilder;

  VocabList(
      {Key key,
      this.refreshable = true,
      @required this.itemCount,
      @required this.onRefresh,
      this.onTwoLevel,
      @required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        refreshable ? RefreshController(initialRefresh: false) : null;

    Widget result = ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );

    result = refreshable
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            enableTwoLevel: true,
            header: ClassicHeader(
              // TODO: more customize options
              // TODO: 加入颜文字
              releaseText: "松手刷新",
              refreshingText: "刷新中",
              canTwoLevelText: "超大力的刷新!",
              completeText: "刷新成功!",
              failedText: "没有网络你学个叉叉",
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
            onRefresh: () => onRefresh(_refreshController),
            onLoading: _refreshController.loadComplete,
            onTwoLevel: onTwoLevel == null
                ? () => onRefresh(_refreshController)
                : () => onRefresh(_refreshController),
            child: result,
          )
        : result;

    return Flexible(child: result);
  }

  factory VocabList.task() {
    void _onRefresh(RefreshController controller) async {
      await Future.delayed(Duration(seconds: 1));
      // if failed, use refreshFailed()
      controller.refreshCompleted();
    }

    // TODO: buggy onTwoLevel
    return VocabList(
      refreshable: true,
      itemCount: 10,
      onRefresh: _onRefresh,
      onTwoLevel: _onRefresh,
      itemBuilder: (context, i) => DismissibleVocabRow(
        index: i,
      ),
    );
  }

  factory VocabList.memorized() {
    return VocabList(
      refreshable: false,
      itemCount: 2,
      onRefresh: null,
      onTwoLevel: null,
      itemBuilder: (context, i) => DismissibleVocabRow(
        index: i,
      ),
    );
  }

  factory VocabList.list() {
    return VocabList(
      refreshable: false,
      itemCount: 20,
      onRefresh: null,
      onTwoLevel: null,
      itemBuilder: (context, i) => DismissibleVocabRow(
        index: i,
      ),
    );
  }
}
