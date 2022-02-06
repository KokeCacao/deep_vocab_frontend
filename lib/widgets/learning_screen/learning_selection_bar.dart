import 'package:auto_size_text/auto_size_text.dart';
import '../../utils/theme_data_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearningSelectionBar extends StatelessWidget {
  final bool? random;
  final Function(bool value)? onChanged;

  const LearningSelectionBar({Key? key, this.random, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     RaisedButton(
            //       child: Text("全选",
            //           style: TextStyle(
            //             color: Colors.white,
            //           )),
            //       onPressed: () => {},
            //     ),
            //     RaisedButton(
            //       child: Text("反选",
            //           style: TextStyle(
            //             color: Colors.white,
            //           )),
            //       onPressed: () => {},
            //     ),
            //     Text("已选: 23",
            //         style: TextStyle(
            //           color: Colors.black,
            //         ))
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                "程序猿吐槽: 编程好累, 还是上学好~",
                minFontSize: 12,
                maxFontSize: 16,
                style: TextStyle(
                    color: Provider.of<ThemeDataWrapper>(context, listen: false)
                        .fadeTextColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("乱序:",
                        style: TextStyle(
                          color: Provider.of<ThemeDataWrapper>(context,
                                  listen: false)
                              .textColor,
//                          fontWeight: FontWeight.bold,
                        )),
                    Switch(
                      value: random!,
                      onChanged: onChanged,
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
}
