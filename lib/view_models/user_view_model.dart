import 'package:deep_vocab/models/user_model.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class UserViewModel extends ChangeNotifier {
  UserModel _userModel;

  get userModel {
    return _userModel;
  }

  fetch() {
    Map<String, dynamic> map = {
      "query": "hi",
      "wowo": "mom",
    };

    HttpWidget.post(
        path: "/graphql",
        data: map,
        protocol: "POST",
        onSuccess: (response) {
          _userModel = UserModel(
              // TODO: compute from json
              uuid: Uuid().v4(),
              userName: "Koke_Cacao",
              avatarUrl: "http://via.placeholder.com/350x150",
              level: 19,
              xp: 10);
          print("[UserModel] ${_userModel.userName} is my username");
          notifyListeners();
          print("[UserModel] onSuccess");
        },
        onFail: (response) {
          print("[UserModel] onFail");
        },
        onFinished: (response) {
          print("[UserModel] onFinished");
        });
  }

  // static UserModel fromJson(dynamic json) {
  //     compute(function, json).then((value) {
  //      
  //       // notify 
  //     })
  // }
}
