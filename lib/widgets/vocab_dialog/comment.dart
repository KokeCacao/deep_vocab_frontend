import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  final String uuid;
  final String userName;
  final String dateTime;
  final String message;
  final int likes;
  bool isLike;
  final Function(bool isLike) isLikeCallback;
  final String avatarUrl;
  final Function(String userName, String uuid) avatarCallback;

  Comment(
      {Key key,
      @required this.uuid,
      @required this.userName,
      @required this.dateTime,
      @required this.message,
      @required this.likes,
      @required this.isLike,
      @required this.avatarUrl,
      this.isLikeCallback,
      this.avatarCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommentState();
  }
}

class CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.avatarCallback != null)
                    widget.avatarCallback(widget.userName, widget.uuid);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style:
                                TextStyle(fontSize: 18, color: Colors.blueGrey),
                          ),
                          Text(
                            widget.dateTime,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black26),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.isLike = !widget.isLike;
                  setState(() {});
                  if (widget.isLikeCallback != null)
                    widget.isLikeCallback(widget.isLike);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.isLike ? "${widget.likes+1}" : "${widget.likes}",
                      style: TextStyle(
                          color:
                              widget.isLike ? Colors.blueGrey : Colors.black45,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      widget.isLike ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: widget.isLike ? Colors.blueGrey : Colors.black45,
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 20 * 2.0 + 10), // should be 2 times of avatar
            child: Text(widget.message),
          )
        ],
      ),
    );
  }
}
