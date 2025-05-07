import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/view/get_started/get_started.dart';

import 'src/utils/providers/language_list_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sara AI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Roboto',
        ),
        home: const GetStartedPage(),
      ),
    ),
  );
}
