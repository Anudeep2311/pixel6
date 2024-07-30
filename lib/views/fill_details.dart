import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixel6/app_theme.dart';
import 'package:pixel6/models/customer_model.dart';
import 'package:pixel6/provider/customer_provider.dart';
import 'package:pixel6/provider/pancard_provider.dart';
import 'package:pixel6/provider/postcode_provider.dart';
import 'package:pixel6/views/home_screen.dart';
import 'package:pixel6/widgets/capitalized_form_field.dart';
import 'package:pixel6/widgets/common_sizedbox.dart';
import 'package:pixel6/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class FillDetailsScreen extends StatefulWidget {
  const FillDetailsScreen({super.key});

  @override
  State<FillDetailsScreen> createState() => _FillDetailsScreenState();
}

class _FillDetailsScreenState extends State<FillDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressLineOneController =
      TextEditingController();
  final TextEditingController _addressLineTwoController =
      TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final panProvider = context.read<PanProvider>();
    panProvider.addListener(() {
      if (_fullNameController.text != panProvider.fullName) {
        _fullNameController.text = panProvider.fullName ?? '';
      }
    });
    _panController.addListener(() {
      final text = _panController.text;
      if (text != text.toUpperCase()) {
        _panController.value = _panController.value.copyWith(
          text: text.toUpperCase(),
          selection: TextSelection(
            baseOffset: _panController.selection.baseOffset,
            extentOffset: _panController.selection.extentOffset,
          ),
        );
      }
    });
    final postcodeProvider = context.read<PostcodeProvider>();
    postcodeProvider.addListener(() {
      if (_stateController.text != postcodeProvider.state) {
        _stateController.text = postcodeProvider.state ?? '';
      }
      if (_cityController.text != postcodeProvider.city) {
        _cityController.text = postcodeProvider.city ?? '';
      }
    });
  }

  @override
  void dispose() {
    _panController.dispose();
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

  Future<void> _fetchPostcodeDetails(String postcode) async {
    final postcodeProvider =
        Provider.of<PostcodeProvider>(context, listen: false);
    await postcodeProvider.fetchPostcodeDetails(postcode);
  }

  Future<void> _verifyPan(String panNumber) async {
    final panProvider = Provider.of<PanProvider>(context, listen: false);
    await panProvider.verifyPan(panNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Fill Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<PanProvider>(
                  builder: (context, panProvider, child) {
                    return CapitalizedTextFormField(
                      controller: _panController,
                      labelText: 'PAN Number',
                      validator: validatePAN,
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      prefixIcon:
                          const Icon(Icons.assignment_ind, color: iconColor),
                      onChanged: (value) {
                        if (value.length == 10) {
                          _verifyPan(value);
                        }
                      },
                      suffixIcon: panProvider.isLoading
                          ? const SizedBox(
                              height: 2,
                              width: 2,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: onSurfaceColor,
                                  strokeWidth: RefreshProgressIndicator
                                      .defaultStrokeWidth,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                ),
                const TextFormFieldSizedbox(),
                Consumer<PanProvider>(
                  builder: (context, panProvider, child) {
                    _fullNameController.text = panProvider.fullName ?? '';

                    return CustomTextFormField(
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Full Name',
                      maxLength: 140,
                      prefixIcon: const Icon(Icons.abc, color: iconColor),
                    );
                  },
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
                Consumer<PostcodeProvider>(
                  builder: (context, postcodeProvider, child) {
                    return CustomTextFormField(
                      controller: _postCodeController,
                      keyboardType: TextInputType.number,
                      labelText: 'Zipcode',
                      maxLength: 6,
                      prefixIcon:
                          const Icon(Icons.numbers_outlined, color: iconColor),
                      onChanged: (value) {
                        if (value.length == 6) {
                          _fetchPostcodeDetails(value);
                        }
                      },
                      suffixIcon: postcodeProvider.isLoading
                          ? const SizedBox(
                              height: 10,
                              width: 10,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: onSurfaceColor,
                                  strokeWidth: RefreshProgressIndicator
                                      .defaultStrokeWidth,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                ),
                const TextFormFieldSizedbox(),
                Consumer<PostcodeProvider>(
                  builder: (context, postcodeProvider, child) {
                    _stateController.text = postcodeProvider.state ?? '';
                    _cityController.text = postcodeProvider.city ?? '';

                    return Column(
                      children: [
                        CustomTextFormField(
                          labelText: 'State',
                          prefixIcon: const Icon(Icons.location_on_rounded,
                              color: iconColor),
                          controller: _stateController,
                          keyboardType: TextInputType.text,
                        ),
                        const TextFormFieldSizedbox(),
                        CustomTextFormField(
                          prefixIcon:
                              const Icon(Icons.location_city, color: iconColor),
                          labelText: 'City',
                          controller: _cityController,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_formKey.currentState?.validate() ?? false) {
            _saveCustomerData(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter valid data."),
              ),
            );
          }
        },
        child: const BottomAppBar(
          child: Center(
            child: Text(
              'SUBMIT',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
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

  void _saveCustomerData(BuildContext context) {
    final CustomerModel customer = CustomerModel(
      pan: _panController.text,
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
    context.read<CustomerProvider>().addCustomer(customer);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
    log("-------->>>>> GETTING MAIL ------>>>>>${customer.email}");
  }
}
