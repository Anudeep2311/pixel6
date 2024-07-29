import 'package:flutter/material.dart';
import 'package:pixel6/app_theme.dart';
import 'package:pixel6/provider/postcode_provider.dart';
import 'package:pixel6/views/fill_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => PostcodeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const FillDetailsScreen(),
    );
  }
}
