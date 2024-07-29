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

    try {
      final response = await http.post(
        Uri.parse('https://lab.pixel6.co/api/get-postcode-details.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'postcode': postcode}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Success') {
          _city = data['city'][0]['name'];
          _state = data['state'][0]['name'];
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
