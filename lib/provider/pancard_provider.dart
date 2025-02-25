import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanProvider with ChangeNotifier {
  String? _fullName;
  bool _isLoading = false;

  String? get fullName => _fullName;
  bool get isLoading => _isLoading;

  Future<void> verifyPan(String panNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://lab.pixel6.co/api/verify-pan.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'panNumber': panNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Success' && data['isValid'] == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _fullName = data['fullName'];
            _isLoading = false;
            notifyListeners();
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _fullName = null;
            _isLoading = false;
            notifyListeners();
          });
        }
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _fullName = null;
          _isLoading = false;
          notifyListeners();
        });
      }
    } catch (e) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _fullName = null;
        _isLoading = false;
        notifyListeners();
      });
    }
  }
}
