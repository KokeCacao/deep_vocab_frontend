import '/models/vocab_list_model.dart';
import '/view_models/auth_view_model.dart';
import '/view_models/vocab_list_view_model.dart';
import '/widgets/learning_screen/selection_panel.dart';
import '/widgets/learning_screen/vocab_list_with_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
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
  final void Function(RefreshController controller)? onRefresh;
  final void Function(RefreshController controller)? onTwoLevel;
  final Widget Function(BuildContext context, int index) itemBuilder;

  VocabList({Key? key, this.refreshable = true, required this.itemCount, required this.onRefresh, this.onTwoLevel, required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController? _refreshController = refreshable ? RefreshController(initialRefresh: false) : null;

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
              builder: (BuildContext context, LoadStatus? mode) {
                return Container(
                  height: 55.0,
                  child: Center(child: Text("没有了哦")),
                );
              },
            ),
            controller: _refreshController!,
            onRefresh: () => { // Only Refresh When There is a function passed in
              if (onRefresh != null) onRefresh!(_refreshController) // TODO: design refresh behavior for all refreshables
              else _refreshController.refreshCompleted()
            }, // TODO: refresh failure?
            onLoading: _refreshController.loadComplete,
            // Not sure what the argument `isOpen` means
            onTwoLevel: onTwoLevel == null ? (isOpen) => onRefresh!(_refreshController) : (isOpen) => onRefresh!(_refreshController),
            child: result,
          )
        : result;

    return Flexible(
        child: Stack(
      alignment: Alignment.topCenter,
      children: [
        result,
        Align(
          alignment: Alignment.bottomRight,
          child: SelectionPanel(
            itemCount: itemCount,
          ),
        ),
      ],
    ));
  }
}
