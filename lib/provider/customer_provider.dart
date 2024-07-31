import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pixel6/models/customer_model.dart';

class CustomerProvider with ChangeNotifier {
  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  CustomerProvider() {
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? customerData = prefs.getString('customers');
    if (customerData != null) {
      try {
        final List<dynamic> jsonList = json.decode(customerData);
        _customers =
            jsonList.map((json) => CustomerModel.fromJson(json)).toList();
      } catch (e) {
        _customers = [];
      }
      notifyListeners();
    }
  }

  Future<void> addCustomer(CustomerModel customer) async {
    _customers.add(customer);
    notifyListeners();
    await _saveCustomers();
  }

  Future<void> deleteCustomer(int index) async {
    _customers.removeAt(index);
    notifyListeners();
    await _saveCustomers();
  }

  Future<void> updateCustomer(int index, CustomerModel updatedCustomer) async {
    _customers[index] = updatedCustomer;
    notifyListeners();
    await _saveCustomers();
  }

  Future<void> _saveCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String customerData =
          json.encode(_customers.map((cust) => cust.toJson()).toList());
      await prefs.setString('customers', customerData);
    } catch (e) {
      log(e.toString());
    }
  }
}
