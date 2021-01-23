import 'package:deep_vocab/models/hive_models/settings_model.dart';
import 'package:deep_vocab/models/hive_models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO: wrap all Hive and Box using HiveBox
class HiveBox {
  static const String SINGLETON_BOX = "singleton"; // used to store singleon
  static const String REQUEST_BOX = "request"; // used to store current request

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
    print("[HiveBox] Finish initialize futter Hivebox instance");

    // run flutter-generate to generate models
    // registering generated model
    // the checks below are important because hot reload would try to register one more time if not prevented
    UserModelAdapter userModelAdapter = UserModelAdapter();
    if (!Hive.isAdapterRegistered(userModelAdapter.typeId)) Hive.registerAdapter(userModelAdapter);
    SettingsModelAdapter settingsModelAdapter = SettingsModelAdapter();
    if (!Hive.isAdapterRegistered(settingsModelAdapter.typeId)) Hive.registerAdapter(settingsModelAdapter);
    print("[HiveBox] Finish initialize Adapters");

    // open box: dynamic here is the store type. They have to be dynamic
    // open box cannot be stored somewhere, otherwise it will cause infinite loading time
    Box<dynamic> singletonBox = await Hive.openBox<dynamic>(HiveBox.SINGLETON_BOX);
    print("[HiveBox] initialize singleton box");
    Box<dynamic> requestBox = await Hive.openBox<dynamic>(HiveBox.REQUEST_BOX);
    print("[HiveBox] initialize request box");
    await requestBox.clear();

    assert(Hive.box(HiveBox.SINGLETON_BOX) != null);
    assert(Hive.box(HiveBox.REQUEST_BOX) != null);
    print("[HiveBox] Initialization successful");

    return Future.value();
  }

  static bool loggedIn() {
    return getBox(SINGLETON_BOX).get(USER_SINGLETON_ACCESS_TOKEN, defaultValue: null) != null;
  }

  static Box<dynamic> getBox(String boxName) {
      return Hive.box<dynamic>(boxName);
  }

  static void deleteFrom(String boxName, String key) {
    getBox(boxName).delete(key);
  }

  static bool containKey(String boxName, String key) {
    return getBox(boxName).containsKey(key);
  }

  static void put(String boxName, String key, dynamic value) {
    getBox(boxName).put(key, value);
  }

  static dynamic get(String boxName, String key, {dynamic defaultValue}) {
    return getBox(boxName).get(key, defaultValue: defaultValue);
  }
}