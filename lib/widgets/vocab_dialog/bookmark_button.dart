import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/widgets/vocab_dialog/bookmark_shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  final int number;
  final void Function(bool bookmarked) onChangeBookmarked;
  final bool optimiztic;

  bool bookmarked;

  BookmarkButton(
      {Key key,
      @required this.number,
      @required this.bookmarked,
      this.onChangeBookmarked, this.optimiztic=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BookmarkButtonState();
  }
}

class BookmarkButtonState extends State<BookmarkButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        value: 0, vsync: this, duration: Duration(milliseconds: 50));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (detail) {
        _animationController.forward();
      },
      onPanEnd: (detail) {
        // when drag
        _animationController.reverse();
      },
      onTap: () {
        // when click
        _animationController.reverse();

        if (widget.onChangeBookmarked != null)
          widget.onChangeBookmarked(!widget.bookmarked);
        if (widget.optimiztic) widget.bookmarked = !widget.bookmarked;
        setState(() {});
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (ctx, _) {
          return BookmarkShape(
            height: 80 + 10 * _animationController.value,
            width: 30 + 1 * _animationController.value,
            borderRadius: 8.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  // TODO: UI cannot display 4 digits correctly
                  "${widget.number}",
                  minFontSize: 10,
                  maxFontSize: 16,
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                widget.bookmarked
                    ? Icon(
                        Icons.star,
                        color: Colors.yellow[300],
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.red[900],
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
