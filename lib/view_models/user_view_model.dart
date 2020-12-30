import 'package:deep_vocab/models/user_model.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class UserViewModel extends ChangeNotifier {
  UserModel _userModel;

  get userModel {
    return _userModel;
  }

  fetch() {
    // Map<String, dynamic> map = {
    //   "query": "hi",
    //   "wowo": "mom",
    // };
    String map = r"""
    query {
        user(uuid: "038c4d22-4731-11eb-b378-0242ac130002") {
            uuid
            userName
            avatarUrl
            level
            xp
        }
    }
    """;

    HttpWidget.post(
        path: "/graphql",
        data: map,
        protocol: "POST",
        onSuccess: (Response<Map> response) {
          _userModel = UserModel(
              // TODO: compute from json
              uuid: Uuid().v4(),
              userName: "Koke_Cacao",
              avatarUrl: "http://via.placeholder.com/350x150",
              level: 19,
              xp: 10);
          Map<dynamic, dynamic> body = response.data; // throw away everything besides body
          print("[UserModel] json = ${body}");
          print("[UserModel] Successfully fetch ${_userModel.userName} as my username");
          notifyListeners();
        },
        onFail: (response) {
          print("[UserModel] Fetching Failed");
        },
        onFinished: (response) {
        });
  }
}
