import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningScreen extends StatefulWidget {
  static const String routeName = '/learning_screen';

  bool random = false;

  @override
  State<StatefulWidget> createState() {
    return _LearningScreenState();
  }
}

class _LearningScreenState extends State<LearningScreen>
    with SingleTickerProviderStateMixin {
  Widget _buildSelectionBar() {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0,
            ),
            vertical: BorderSide(
              width: 0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("全选",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () => {},
                ),
                RaisedButton(
                  child: Text("反选",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () => {},
                ),
                Text("已选: 23",
                    style: TextStyle(
                      color: Colors.black,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("乱序:",
                        style: TextStyle(
                          color: Colors.black,
//                          fontWeight: FontWeight.bold,
                        )),
                    Switch(
                      value: widget.random,
                      onChanged: (bool) {
                        setState(() {
                          widget.random = bool;
                        });
                      },
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.filter_list),
                  onPressed: () {},
                )
              ],
            )
          ],
        ));
  }

  Widget _buildList() {
    return Flexible(
        child: ListView.builder(
      itemCount: 100,
      itemBuilder: (context, i) => _buildVocab(),
    ));
  }

  Widget _buildVocab() {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0,
          ),
          vertical: BorderSide(
            width: 0,
          ),
        ),
      ),
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          IntrinsicWidth(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool) {},
                )
              ],
            ),
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    child: AutoSizeText(
                  "grandiloquent",
                  minFontSize: 10,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                )),
                Expanded(
                    child: AutoSizeText(
                  "辞藻浮夸的; 夸大",
                  minFontSize: 10,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                ))
              ],
            ),
          ),
          IntrinsicWidth(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.green,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  height: double.infinity,
                  width: 10,
                  color: Colors.black38,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tabBar = TabBar(
      controller: _tabController,
      labelColor: Colors.teal, // selected text
      indicatorColor: Colors.black, // selected button
      unselectedLabelColor: Colors.black, // unselected text
      tabs: [
        Tab(
          text: "任务",
        ),
        Tab(
          text: "已完成",
        ),
        Tab(
          text: "未完成",
        ),
      ],
    );

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          _tabBar,
          Expanded(
            // needed for TabBarView to show correctly
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Column(
                  children: [
                    _buildSelectionBar(),
                    _buildList(),
                  ],
                ),
                Text("已完成"),
                Text("未完成"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
