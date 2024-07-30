import 'package:flutter/material.dart';
import 'package:pixel6/app_theme.dart';
import 'package:pixel6/models/customer_model.dart';
import 'package:pixel6/provider/customer_provider.dart';
import 'package:pixel6/views/home_screen.dart';
import 'package:pixel6/widgets/common_sizedbox.dart';
import 'package:pixel6/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class EditDetailsScreen extends StatefulWidget {
  const EditDetailsScreen({super.key, required this.index});
  final int index;

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressLineOneController;
  late TextEditingController _addressLineTwoController;
  late TextEditingController _postCodeController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    final customerProvider = context.read<CustomerProvider>();
    final customer = customerProvider.customers[widget.index];

    _fullNameController = TextEditingController(text: customer.fullName);
    _emailController = TextEditingController(text: customer.email);
    _phoneNumberController = TextEditingController(text: customer.phoneNumber);
    _addressLineOneController =
        TextEditingController(text: customer.addresses[0].addressLineOne);
    _addressLineTwoController =
        TextEditingController(text: customer.addresses[0].addressLineTwo);
    _postCodeController =
        TextEditingController(text: customer.addresses[0].postcode);
    _stateController = TextEditingController(text: customer.addresses[0].state);
    _cityController = TextEditingController(text: customer.addresses[0].city);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressLineOneController.dispose();
    _addressLineTwoController.dispose();
    _postCodeController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _updateCustomer() {
    if (_formKey.currentState?.validate() ?? false) {
      final customerProvider = context.read<CustomerProvider>();
      final updatedCustomer = CustomerModel(
        pan: customerProvider.customers[widget.index].pan,
        fullName: _fullNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        addresses: [
          Address(
            addressLineOne: _addressLineOneController.text,
            addressLineTwo: _addressLineTwoController.text,
            postcode: _postCodeController.text,
            state: _stateController.text,
            city: _cityController.text,
          ),
        ],
      );
      customerProvider.updateCustomer(widget.index, updatedCustomer);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _fullNameController,
                labelText: 'Enter Full Name',
                maxLength: 140,
                prefixIcon: const Icon(Icons.abc, color: iconColor),
                keyboardType: TextInputType.name,
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                maxLength: 255,
                validator: validateEmail,
                prefixIcon: const Icon(Icons.email, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                labelText: 'Mobile Number',
                maxLength: 10,
                prefix: const Text('+91 '),
                prefixIcon: const Icon(Icons.phone, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _addressLineOneController,
                keyboardType: TextInputType.streetAddress,
                validator: validateAddress,
                labelText: 'Address (Required)',
                prefixIcon: const Icon(Icons.home, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _addressLineTwoController,
                keyboardType: TextInputType.streetAddress,
                labelText: 'Street Address',
                prefixIcon: const Icon(Icons.home, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _postCodeController,
                keyboardType: TextInputType.number,
                labelText: 'Zipcode',
                maxLength: 6,
                prefixIcon:
                    const Icon(Icons.numbers_outlined, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _stateController,
                keyboardType: TextInputType.text,
                labelText: 'State',
                prefixIcon:
                    const Icon(Icons.location_on_rounded, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              CustomTextFormField(
                controller: _cityController,
                keyboardType: TextInputType.text,
                labelText: 'City',
                prefixIcon: const Icon(Icons.location_city, color: iconColor),
              ),
              const TextFormFieldSizedbox(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    surfaceColor,
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: _updateCustomer,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? validateEmail(String? value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePAN(String? value) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Please enter PAN card number";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid PAN card number";
    }
    return null;
  }
}
