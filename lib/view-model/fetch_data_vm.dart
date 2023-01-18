import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safespace/model/city_news_model.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../shared/dialog.dart';

class FetchData with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<List<CityNewsModel>> getNewsContentsFromDb(
      {required BuildContext context, required String id}) async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    late List<dynamic> cityContent;
    late String cityName;

    List<CityNewsModel> cityModelList = [];
    if (isConnected == true) {
      try {
        QuerySnapshot snapshot = await _db.collection("City").get();
        snapshot.docs.forEach((element) {
          if (element.get('id') == id) {
            cityName = element.get('cityName');
            cityContent = element['cityUpdate'];
            cityContent.forEach((element) {
              CityNewsModel cityNewsModel = CityNewsModel(
                cityNews: element['cityNews'],
                user: element['user'] ?? "Anonymous user",
                cityName: cityName,
                time: DateTime.parse(element['time'].toDate().toString()),
              );
              cityModelList.add(cityNewsModel);

              notifyListeners();
            });
          }
        });
      } catch (e) {
        showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Something went wrong 😞",
          body: "Retry",
        );
        print(e.toString());
      }
    }
    return cityModelList;
  }

  Future updateContent({
    required BuildContext context,
    required String cityId,
    required String news,
    required String user,
  }) async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    // late List<dynamic> newsContent;
    late String id;

    // late List<dynamic> airContentSecondList;
    if (isConnected == true) {
      try {
        QuerySnapshot snapshot = await _db.collection("City").get();
        snapshot.docs.forEach((element) {
          if (element['id'] == cityId) {
            id = element['id'];
            _db.collection("City").doc(id).set({
              "cityUpdate": FieldValue.arrayUnion([
                {
                  "cityNews": news,
                  "time": DateTime.now(),
                  "user": user == "" ? "Anonymous" : user,
                }
              ])
            }, SetOptions(merge: true));

            notifyListeners();
          }
        });
      } catch (e) {
        showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Something went wrong 😞",
          body: "Retry",
        );
        print(e.toString());
      }
    }
  }
}
