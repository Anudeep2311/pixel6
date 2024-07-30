import 'package:flutter/material.dart';
import 'package:pixel6/app.dart';
import 'package:pixel6/provider/customer_provider.dart';
import 'package:pixel6/provider/pancard_provider.dart';
import 'package:pixel6/provider/postcode_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PostcodeProvider>(
          create: (_) => PostcodeProvider(),
        ),
        ChangeNotifierProvider<PanProvider>(
          create: (_) => PanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
