import 'dart:convert';
// import 'package:base_flutter_framework/core/models/user.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//cache file
class Shared {
  static Shared? instance;
  static Shared getInstance() {
    if (instance == null) {
      instance = new Shared();
    }
    return instance!;
  }

  // UserModel userModel = new UserModel();
  // String? carsId;

  // Future<void> saveUser({required UserModel user}) async {
  //   await deleteUser();
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   this.userModel = user;
  //   await preferences.setString(
  //       StringCommon.userCache, jsonEncode(this.userModel));
  // }

  // Future<UserModel> getUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if (preferences.containsKey(StringCommon.userCache)) {
  //     userModel = UserModel.fromJson(
  //         jsonDecode(preferences.getString(StringCommon.userCache)!));
  //     return userModel;
  //   }
  //   return UserModel();
  // }

  // Future<bool> deleteUser() async {
  //   try {
  //     await FacebookAuth.instance.logOut();
  //     await FirebaseAuth.instance.signOut();
  //   } catch (_e) {}
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.remove(StringCommon.userCache);
  //   userModel = new UserModel();
  //   return true;
  // }

  // Future<void> saveCarsId({required String carsId}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setString(StringCommon.carsCache, carsId);
  //   this.carsId = carsId;
  // }

  // Future<String?> getCarsId() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if (preferences.containsKey(StringCommon.carsCache)) {
  //     carsId = preferences.getString(StringCommon.carsCache);
  //     return this.carsId;
  //   }
  //   return "";
  // }

  // Future<bool> deleteCarsId() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.remove(StringCommon.carsCache);
  //   carsId = "";
  //   return true;
  // }
}
