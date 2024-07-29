import 'package:flutter/material.dart';
import 'package:pixel6/app_theme.dart';
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

// ---------> This function is for fetching the city and state by passing postcode
  Future<void> _fetchPostcodeDetails(String postcode) async {
    final postcodeProvider =
        Provider.of<PostcodeProvider>(context, listen: false);
    await postcodeProvider.fetchPostcodeDetails(postcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                CapitalizedTextFormField(
                  controller: _panController,
                  labelText: 'PAN Number',
                  validator: validatePAN,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  prefixIcon:
                      const Icon(Icons.assignment_ind, color: iconColor),
                ),
                const TextFormFieldSizedbox(),
                CustomTextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  labelText: 'Enter Full Name',
                  maxLength: 140,
                  prefixIcon: const Icon(Icons.abc, color: iconColor),
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
                          ? const CircularProgressIndicator()
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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
}
