import 'package:f_logs/f_logs.dart';

import '/models/hive_models/settings_model.dart';
import '/models/hive_models/user_model.dart';
import '/models/hive_models/vocab_header_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO: wrap all Hive and Box using HiveBox
class HiveBox {
  static const String SINGLETON_BOX = "singleton"; // store singleton (see below)
  static const String REQUEST_BOX = "request"; // store temp json request
  static const String SHOWCASE_BOX = "showcase"; // store whether showcase is stored
  static const String VOCAB_LIST_HEADER_BOX = "vocabListHeader"; // store Map<listId, VocabHeaderModel>

  // indexes in singleton
  static const String USER_SINGLETON_INDEX = "user"; // store UserViewModel: uuid, userName, avatarUrl, level, xp...
  static const String SETTING_SINGLETON_INDEX = "settings";
  static const String USER_SINGLETON_UUID = "uuid"; // one of AuthViewModel
  static const String USER_SINGLETON_ACCESS_TOKEN = "accessToken"; // one of AuthViewModel
  static const String USER_SINGLETON_REFRESH_TOKEN = "refreshToken"; // one of AuthViewModel
  static const String USER_SINGLETON_WX_TOKEN = "wxToken"; // one of AuthViewModel

  Future init() async {
    // final Directory documentDirectory = await getApplicationDocumentsDirectory();
    // Hive.init(documentDirectory.path);
    await Hive.initFlutter();
    FLog.info(text: "[HiveBox] Finish initialize flutter Hivebox instance");

    // run flutter build to generate models, registering generated model here
    // below code can't be packaged into one functions with list because they depend on the exact type of adapters
    // otherwise will give errors like: Unhandled Exception: type 'VocabHeaderModel' is not a subtype of type 'UserModel' of 'obj'
    UserModelAdapter userModelAdapter = UserModelAdapter();
    if (!Hive.isAdapterRegistered(userModelAdapter.typeId)) Hive.registerAdapter(userModelAdapter);
    FLog.info(text: "[HiveBox] Finish registered ${userModelAdapter.toString()}; id = ${userModelAdapter.typeId}");
    SettingsModelAdapter settingsModelAdapter = SettingsModelAdapter();
    if (!Hive.isAdapterRegistered(settingsModelAdapter.typeId)) Hive.registerAdapter(settingsModelAdapter);
    FLog.info(text: "[HiveBox] Finish registered ${settingsModelAdapter.toString()}; id = ${settingsModelAdapter.typeId}");
    VocabHeaderModelAdapter vocabHeaderModelAdapter = VocabHeaderModelAdapter();
    if (!Hive.isAdapterRegistered(vocabHeaderModelAdapter.typeId)) Hive.registerAdapter(vocabHeaderModelAdapter);
    FLog.info(text: "[HiveBox] Finish registered ${vocabHeaderModelAdapter.toString()}; id = ${vocabHeaderModelAdapter.typeId}");

    // open box: dynamic here is the store type. They have to be dynamic
    // open box cannot be stored somewhere, otherwise it will cause infinite loading time
    await Hive.openBox<dynamic>(HiveBox.SINGLETON_BOX);
    FLog.info(text: "[HiveBox] initialize ${HiveBox.SINGLETON_BOX} box");
    await Hive.openBox<dynamic>(HiveBox.REQUEST_BOX)..clear();
    FLog.info(text: "[HiveBox] initialize ${HiveBox.REQUEST_BOX} box (cleared)");
    await Hive.openBox<dynamic>(HiveBox.VOCAB_LIST_HEADER_BOX);
    FLog.info(text: "[HiveBox] initialize ${HiveBox.VOCAB_LIST_HEADER_BOX} box");
    await Hive.openBox<dynamic>(HiveBox.SHOWCASE_BOX)..clear();
    FLog.info(text: "[HiveBox] initialize ${HiveBox.SHOWCASE_BOX} box");

    FLog.info(text: "[HiveBox] Initialization successful");

    return Future.value();
  }

  static bool loggedIn() => getBox(SINGLETON_BOX).get(USER_SINGLETON_ACCESS_TOKEN, defaultValue: null) != null;

  /// Box interface
  static Box<dynamic> getBox(String boxName) => Hive.box<dynamic>(boxName);
  static void deleteFrom(String boxName, dynamic key) => getBox(boxName).delete(key);
  static bool containKey(String boxName, dynamic key) => getBox(boxName).containsKey(key);
  static void put(String boxName, dynamic key, dynamic value)  => getBox(boxName).put(key, value);
  static dynamic get(String boxName, dynamic key, {dynamic defaultValue}) => getBox(boxName).get(key, defaultValue: defaultValue);
  static Future<void> clear() async {
    await Hive.box(SINGLETON_BOX).clear();
    await Hive.box(REQUEST_BOX).clear();
    await Hive.box(VOCAB_LIST_HEADER_BOX).clear();
    return Future.value();
  }
}