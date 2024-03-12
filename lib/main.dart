import 'constants/colors.dart';
import 'package:flutter/material.dart';

import 'views/screens/author_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Author Search App',
        home: AuthorSearchPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.getBackgroundColor(),
          primaryColor: AppColors.getPrimaryColor(),
          appBarTheme: AppBarTheme(
            color: AppColors.getBackgroundColor(),
            elevation: 1.0,
            iconTheme: IconThemeData(color: AppColors.getAccentColor()),
            titleTextStyle: TextStyle(
              color: AppColors.getAccentColor(),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: AppColors.getSecondaryColor(),
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
            bodyText2: TextStyle(
              color: AppColors.getSecondaryColor(),
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));
  }
}
