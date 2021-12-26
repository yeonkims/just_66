// ignore_for_file: constant_identifier_names

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Preferences {
  static const String _VERSION = '_VERSION';
  static const String IS_NOTIFICATIONS_ENABLED = 'IS_NOTIFICATIONS_ENABLED';
  static const String SELECTED_LANGUAGE = 'SELECTED_LANGUAGE';

  final Map<String, dynamic> _initialPreferences = {
    _VERSION: 2,
    IS_NOTIFICATIONS_ENABLED: true,
    SELECTED_LANGUAGE: "EN",
  };

  Map<String, dynamic> _currentPreferences = {};

  Future<Map<String, dynamic>> get currentPreferences async {
    if (_currentPreferences.isNotEmpty) {
      return _currentPreferences;
    }
    await reInitiliaze();
    return _currentPreferences;
  }

  final String _fileName = 'user_stats.json';
  static late File _jsonFile;

  static final Preferences _singleton = Preferences._internal();

  factory Preferences() {
    return _singleton;
  }

  Preferences._internal() {
    reInitiliaze();
  }

  reInitiliaze() async {
    Directory? directory = Platform.isIOS
        ? await getApplicationSupportDirectory()
        : await getExternalStorageDirectory();
    Directory dir = directory!;
    _jsonFile = File(dir.path + "/" + _fileName);
    bool fileExists = _jsonFile.existsSync();
    if (fileExists) {
      _currentPreferences = json.decode(_jsonFile.readAsStringSync());
      if (hasNewVersion) {
        _addAnyMissingAttributes();
        _removeDeletedAttributes();
        _currentPreferences[_VERSION] = _initialPreferences[_VERSION];
      }
      _jsonFile.writeAsStringSync(json.encode(_currentPreferences));
    } else {
      _currentPreferences = _initialPreferences;
      _createPreferencesFile(_currentPreferences);
    }
  }

  void _createPreferencesFile(Map<String, dynamic> content) {
    _jsonFile.createSync();
    _jsonFile.writeAsStringSync(json.encode(content));
  }

  bool get hasNewVersion =>
      !_currentPreferences.containsKey(_VERSION) ||
      _currentPreferences[_VERSION] != _initialPreferences[_VERSION];

  void _addAnyMissingAttributes() {
    for (String missingKey in _initialPreferences.keys) {
      if (!_currentPreferences.containsKey(missingKey)) {
        print('adding key $missingKey');
        _currentPreferences[missingKey] = _initialPreferences[missingKey];
      }
    }
  }

  void _removeDeletedAttributes() {
    List<String> keysToDelete = [];
    for (String keyWhichMightNotExistsAnymore in _currentPreferences.keys) {
      if (!_initialPreferences.containsKey(keyWhichMightNotExistsAnymore)) {
        print('removing key $keyWhichMightNotExistsAnymore');
        keysToDelete.add(keyWhichMightNotExistsAnymore);
      }
    }
    keysToDelete.forEach((key) => _currentPreferences.remove(key));
  }

  void resetPreferences() =>
      _jsonFile.writeAsStringSync(json.encode(_initialPreferences));

  void updatePreference(String key, dynamic value) {
    Map<String, dynamic> content = {key: value};
    Map<String, dynamic> jsonFileContent =
        json.decode(_jsonFile.readAsStringSync());
    jsonFileContent.addAll(content);
    _currentPreferences = jsonFileContent;
    _jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  }

  Future<dynamic> getPreference(String key) async {
    var preferences = await currentPreferences;
    return preferences[key];
  }
}
