import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostcodeProvider with ChangeNotifier {
  String? _city;
  String? _state;
  bool _isLoading = false;

  String? get city => _city;
  String? get state => _state;
  bool get isLoading => _isLoading;

  Future<void> fetchPostcodeDetails(String postcode) async {
    _isLoading = true;
    notifyListeners();

    log("------>>>> Details For The POSTCODE ----->>>>: $postcode");

    try {
      final response = await http.post(
        Uri.parse('https://lab.pixel6.co/api/get-postcode-details.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'postcode': postcode}),
      );

      log("Response STATUS: ------>>>> ${response.statusCode}");
      log("Response BODY: -------->>>>> ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'Success') {
          final cityList = data['city'] as List<dynamic>;
          final stateList = data['state'] as List<dynamic>;
          _city = cityList.isNotEmpty ? cityList[0]['name'] : null;
          _state = stateList.isNotEmpty ? stateList[0]['name'] : null;
        } else {
          _city = null;
          _state = null;
        }
      } else {
        _city = null;
        _state = null;
      }
    } catch (e) {
      _city = null;
      _state = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
