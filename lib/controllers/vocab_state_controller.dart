import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class VocabStateController extends ChangeNotifier {
  /// storage
  final BuildContext context;
  final Set<String?> _crossedVocabId;
  final Set<String?> _selectedVocabId;
  final Set<String?> _unhideVocabId;

  bool _inverseCross;
  bool _inverseSelect;
  bool _inverseUnhide;

  VocabStateController({required this.context})
      : this._crossedVocabId = {},
        this._selectedVocabId = {},
        this._unhideVocabId = {},
        _inverseCross = false,
        _inverseSelect = false,
        _inverseUnhide = false;

  void clear() {
    _crossedVocabId.clear();
    _selectedVocabId.clear();
    _unhideVocabId.clear();
    _inverseCross = false;
    _inverseUnhide = false;
    _inverseUnhide = false;
  }

  void allCross() {
    _inverseCross = true;
    _crossedVocabId.clear();
    notifyListeners();
  }
  void allSelect() {
    _inverseSelect = true;
    _selectedVocabId.clear();
    notifyListeners();
  }
  void allUnhide() {
    _inverseUnhide = true;
    _unhideVocabId.clear();
    notifyListeners();
  }

  void noneCross() {
    _inverseCross = false;
    _crossedVocabId.clear();
    notifyListeners();
  }
  void noneSelect() {
    _inverseSelect = false;
    _selectedVocabId.clear();
    notifyListeners();
  }
  void noneUnhide() {
    _inverseUnhide = false;
    _unhideVocabId.clear();
    notifyListeners();
  }

  bool inverseCross() {
    _inverseCross = !_inverseCross;
    notifyListeners();
    return _inverseCross;
  }
  bool inverseSelect() {
    _inverseSelect = !_inverseSelect;
    notifyListeners();
    return _inverseSelect;
  }
  bool inverseUnhide() {
    _inverseUnhide = !_inverseUnhide;
    notifyListeners();
    return _inverseUnhide;
  }

  bool crossedVocabIdContains(String? s) => _inverseCross ? !_crossedVocabId.contains(s) : _crossedVocabId.contains(s);
  bool selectedVocabIdContains(String? s) => _inverseSelect ? !_selectedVocabId.contains(s) : _selectedVocabId.contains(s);
  bool unhideVocabIdContains(String? s) => _inverseUnhide ? !_unhideVocabId.contains(s) : _unhideVocabId.contains(s);

  int getCrossedVocabIdLength(int totalVocab) => _inverseCross ? totalVocab-_crossedVocabId.length : _crossedVocabId.length;
  int getSelectedVocabIdLength(int totalVocab) => _inverseSelect ? totalVocab - _selectedVocabId.length: _selectedVocabId.length;
  int getUnhideVocabIdLength(int totalVocab) => _inverseUnhide ? totalVocab - _unhideVocabId.length : _unhideVocabId.length;

  Set<String?> getCrossedVocabId(Set<String> allVocabId) =>_inverseCross ? allVocabId.difference(_crossedVocabId) : _crossedVocabId.intersection(allVocabId);
  Set<String?> getSelectedVocabId(Set<String> allVocabId) =>_inverseCross ? allVocabId.difference(_selectedVocabId) : _selectedVocabId.intersection(allVocabId);
  Set<String?> getUnhideVocabId(Set<String> allVocabId) =>_inverseCross ? allVocabId.difference(_unhideVocabId) : _unhideVocabId.intersection(allVocabId);

  bool crossedVocabIdAdd(String? s, {bool regardlessInverse = false}) {
    if (_inverseCross && !regardlessInverse) return crossedVocabIdRemove(s, regardlessInverse: true);
    bool b = _crossedVocabId.add(s);
    notifyListeners();
    return b;
  }

  bool selectedVocabIdAdd(String? s, {bool regardlessInverse = false}) {
    if (_inverseSelect && !regardlessInverse) return selectedVocabIdRemove(s, regardlessInverse: true);
    bool b = _selectedVocabId.add(s);
    notifyListeners();
    return b;
  }

  bool unhideVocabIdAdd(String? s, {bool regardlessInverse = false}) {
    if (_inverseUnhide && !regardlessInverse) return unhideVocabIdRemove(s, regardlessInverse: true);
    bool b = _unhideVocabId.add(s);
    notifyListeners();
    return b;
  }

  bool crossedVocabIdRemove(String? s, {bool regardlessInverse = false}) {
    if (_inverseCross && !regardlessInverse) return crossedVocabIdAdd(s, regardlessInverse: true);
    bool b = _crossedVocabId.remove(s);
    notifyListeners();
    return b;
  }

  bool selectedVocabIdRemove(String? s, {bool regardlessInverse = false}) {
    if (_inverseSelect && !regardlessInverse) return selectedVocabIdAdd(s, regardlessInverse: true);
    bool b = _selectedVocabId.remove(s);
    notifyListeners();
    return b;
  }

  bool unhideVocabIdRemove(String? s, {bool regardlessInverse = false}) {
    if (_inverseUnhide && !regardlessInverse) return unhideVocabIdAdd(s, regardlessInverse: true);
    bool b = _unhideVocabId.remove(s);
    notifyListeners();
    return b;
  }
}
