import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_naver_api.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';
import 'package:what_is_lunch_time_for/view/loading.dart';
import 'package:what_is_lunch_time_for/view/menu_insert_page.dart';
import 'package:what_is_lunch_time_for/view/result_page.dart';
import 'package:what_is_lunch_time_for/view/roulette_animation.dart';
import 'package:what_is_lunch_time_for/view/store_list.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 여러개의 Provider 를 추가하기 위한 MultiProvider
    return MultiProvider(
      // 추가 할 Provider 설정
      providers: [
        ChangeNotifierProvider(
          create: (_) => Functions(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsRoulette(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsNaverApi(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "오늘 뭐 먹지?",
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => const InsertPage(),
          '/loading': (context) => const LoadingAnimation(),
          '/result': (context) => const ResultPage(),
          '/stores': (context) => const StoreListPage(),
          '/roulette': (context) => const RouletteAnimation()
        },
      ),
    );
  }
}
