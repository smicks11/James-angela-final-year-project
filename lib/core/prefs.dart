import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences with ChangeNotifier {
  static SharedPreferences? _preferences;
  static const _keyFName = 'fName';
  static const _keyLName = 'lName';
  static const _keyEmail = 'email';
  static const _keyPassword = 'pwd';
  static const _keyPhoneNum = 'pwd';
  static const _keyLocation = 'location';
  static const _keyProfileImg = 'profile';
  static const _keySelectedPlan = 'selectedPlan';
  static const String PREFS_KEY_IS_USER_LOGGED_IN =
      "PREFS_KEY_IS_USER_LOGGED_IN";
  static const _hasProfileDialogShowed = 'hasProfileDialogShowed';
  static const _hasUserLike = 'hasUserLike';

  static const _keyCredential = 'cred';
  static const _keyAdNum = 'adNum';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setProfileData(String fName, String lName, String email,
      String password) async {
    await _preferences?.setString(_keyFName, fName);
    await _preferences?.setString(_keyLName, lName);
    await _preferences?.setString(_keyEmail, email);
    await _preferences?.setString(_keyPassword, password);
    // await _preferences?.setString(_keyLocation, location);
    // await _preferences?.setString(_keyPhoneNum, phone);
  }

  static Future setProfilePic(String pic)async{
    await _preferences?.setString(_keyProfileImg, pic);
  }
  static Future setAdsNum(String num)async{
    await _preferences?.setString(_keyAdNum, num);
  }

  static Future saveSelectedplan(String plan) async {
    await _preferences?.setString(_keySelectedPlan, plan);
  }

  Future<void> setIsUserLoggedIn(bool isUserLoggedIn) async {
    await _preferences?.setBool(PREFS_KEY_IS_USER_LOGGED_IN, isUserLoggedIn);
    notifyListeners();
  }
  Future<void> setUserLike(bool checkHasUserLike) async {
    await _preferences?.setBool(_hasUserLike, checkHasUserLike);
    notifyListeners();
  }
  static Future<void> setProfiledialog(bool hasIt) async {
    await _preferences?.setBool(_hasProfileDialogShowed, hasIt);
    // notifyListeners();
  }

  //GETTERS
  static String? getCallNum() {
    return _preferences?.getString(_keyPhoneNum);
  }
  static String? getSavedPlan() {
    return _preferences?.getString(_keySelectedPlan);
  }

  static String? getFName() {
    return _preferences?.getString(_keyFName);
  }

  static String? getLName() {
    return _preferences?.getString(_keyLName);
  }

  static String? getEmail() {
    return _preferences?.getString(_keyEmail);
  }

  static String? getPwd() {
    return _preferences?.getString(_keyPassword);
  }

  static String? getProfileImg() {
    return _preferences?.getString(_keyProfileImg);
  }

  static String? getLocation() {
    return _preferences?.getString(_keyLocation);
  }

  static Future<bool> isUserLoggedIn() async {
    return _preferences?.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
  static Future<bool> getProfileDialog() async {
    return _preferences?.getBool("true") ?? false;
  }
  bool? getUserLike() {
    return _preferences?.getBool(_hasUserLike) ?? false;
  }

  //Save User Credential To Local Storage
  static Future setUserCredential({UserCredential? credential}) async {
    await _preferences?.setString(_keyCredential, credential!.user!.uid);
  }

  static String? getUserCredentialUid() {
    return _preferences?.getString(_keyCredential);
  }
}