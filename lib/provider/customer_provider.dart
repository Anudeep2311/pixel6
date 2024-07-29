import 'package:flutter/material.dart';
import 'package:pixel6/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomerProvider extends ChangeNotifier {
  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  CustomerProvider() {
    _loadCustomersFromPrefs();
  }

  Future<void> _loadCustomersFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final customerString = prefs.getString('customers') ?? '[]';
    final List decoded = json.decode(customerString);
    _customers = decoded.map((item) => CustomerModel.fromJson(item)).toList();
    notifyListeners();
  }

  Future<void> addCustomer(CustomerModel customer) async {
    _customers.add(customer);
    await _saveCustomersToPrefs();
  }

  Future<void> editCustomer(int index, CustomerModel customer) async {
    if (index >= 0 && index < _customers.length) {
      _customers[index] = customer;
      await _saveCustomersToPrefs();
    }
  }

  Future<void> deleteCustomer(int index) async {
    if (index >= 0 && index < _customers.length) {
      _customers.removeAt(index);
      await _saveCustomersToPrefs();
    }
  }

  Future<void> _saveCustomersToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final customerString =
        json.encode(_customers.map((e) => e.toJson()).toList());
    prefs.setString('customers', customerString);
    notifyListeners();
  }
}
