import 'package:flutter/cupertino.dart';

class HttpSyncViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;

  /// indicate how many vocabs are on task, refresh on [refreshVocab] function
  int _navigationLearningBadgeCount;

  /// store value

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  HttpSyncViewModel({required this.context}): _navigationLearningBadgeCount = 0;

  /// getters
  get navigationLearningBadgeCount => this._navigationLearningBadgeCount;

  /// interface
  void setNavigationLearningBadgeCount(int count) {
    assert(count >= 0);
    this._navigationLearningBadgeCount = count;
    notifyListeners();
  }
}
