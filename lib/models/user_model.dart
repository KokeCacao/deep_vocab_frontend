import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UserModel extends ChangeNotifier {
  static UserModel user_model;

  int xp;
  int level;
  String avatarUrl;
  String userName;
  var uuid;

  UserModel({this.uuid, this.userName, this.avatarUrl, this.level, this.xp});

  fetch() {
    HttpWidget.fakeGet("path", onSuccess: (response) {
        user_model = UserModel( // TODO: compute from json
            uuid: Uuid().v4(),
            userName: "Koke_Cacao",
            avatarUrl: "http://via.placeholder.com/350x150",
            level: 19,
            xp: 10);
        print("[DEBUG] ${user_model.userName} is my username");
        notifyListeners();
        print("[DEBUG] fakeGet onSuccess");
    }, onFail: (response) {
      print("[DEBUG] fakeGet onFail");
    }, onFinished: (response) {
      print("[DEBUG] fakeGet onFinished");
    });
  }

}
