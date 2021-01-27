import 'package:deep_vocab/controllers/vocab_state_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionPanel extends StatelessWidget {
  final int itemCount;

  const SelectionPanel({Key key, @required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VocabStateController vocabStateController = Provider.of<VocabStateController>(context, listen: true);
    int selectedCount = vocabStateController.getSelectedVocabIdLength(itemCount);
    if (selectedCount == 0) return SizedBox.shrink();
    return Container(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomRight,
      height: 40,
      decoration: BoxDecoration(color: Colors.blueGrey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Align(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                "${selectedCount}|${itemCount}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Colors.blueGrey[200],
              height: double.infinity,
              child: GestureDetector(
                onTap: () => selectedCount == itemCount ? vocabStateController.inverseSelect() : vocabStateController.allSelect(),
                child: selectedCount == itemCount
                    ? Text(
                        "反选",
                        textAlign: TextAlign.center,
                      )
                    : Text("全选", textAlign: TextAlign.center),
              ),
            )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Colors.blueGrey[400],
              height: double.infinity,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "加入计划",
                  textAlign: TextAlign.center,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
