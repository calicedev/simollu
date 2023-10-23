import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/preferenceModel.dart';
import 'package:simollu_front/utils/token.dart';

class PreferenceViewModel extends GetxController {
  RxSet<String> preferences = <String>{}.obs;
  RxList<String> places = <String>[].obs;

  late String token;

  Future<void> initialize() async {
    token = await getToken();
  }

  void onChangePreferences(String preference) {
    if (preferences.contains(preference)) {
      preferences.remove(preference);
    } else {
      preferences.add(preference);
    }
  }

  Future<void> postPreference(String json) async {
    await initialize();
    var url = Uri.https('simollu.com', '/api/user/user/preference');
    // Uri uri = Uri.parse('https://simollu.com/api/user/preference');
    final response = await http.post(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, body: json, url);

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> userPreferenceList = responseBody['userPrefernceList'];
      List<dynamic> userPreferencePlaceList =
          responseBody['userPreferncePlaceList'];

      for (dynamic preference in userPreferenceList) {
        preferences.add(preference);
      }
      for (dynamic place in userPreferencePlaceList) {
        places.add(place);
      }
    } else {
      throw Exception('Failed to post preferences...');
    }
  }

  Future<List<String>> getPreference() async {
    await initialize();
    late List<String> result;
    var url = Uri.https('simollu.com', '/api/user/user/preference');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      result = jsonDecode(utf8.decode(response.bodyBytes))['userPrefernceList']
          ?.cast<String>();
      for (String preference in result) {
        preferences.add(preference);
      }
      result =
          jsonDecode(utf8.decode(response.bodyBytes))['userPreferncePlaceList']
              ?.cast<String>();
      for (String place in result) {
        print(place);
        places.add(place);
      }
      // result = PreferenceModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to get preferences...');
    }
    return result;
  }
}
