import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/view/loading.dart';
import 'package:what_is_lunch_time_for/view/menu_insert_page.dart';
import 'package:what_is_lunch_time_for/view/result_page.dart';
import 'package:what_is_lunch_time_for/view/store_list.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Functions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "오늘 뭐 먹지?",
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => InsertPage(),
          '/loading': (context) => const LoadingAnimation(),
          '/result': (context) => ResultPage(),
          '/stores': (context) => StoreListPage(),
        },
      ),
    );
  }
}
