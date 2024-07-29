import 'package:flutter/material.dart';
import 'package:pixel6/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomerProvider with ChangeNotifier {
  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  CustomerProvider() {
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> customersJson = prefs.getStringList('customers') ?? [];
    _customers = customersJson
        .map((json) => CustomerModel.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  Future<void> addCustomer(CustomerModel customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _customers.add(customer);
    List<String> customersJson =
        _customers.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList('customers', customersJson);
    notifyListeners();
  }

  Future<void> deleteCustomer(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (index >= 0 && index < _customers.length) {
      _customers.removeAt(index);
      List<String> customersJson =
          _customers.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList('customers', customersJson);
      notifyListeners();
    }
  }
}
