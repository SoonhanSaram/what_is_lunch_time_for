import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_animation.dart';
import 'package:what_is_lunch_time_for/service/functions_kakao_api.dart';
import 'package:what_is_lunch_time_for/service/functions_naver_api.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';
import 'package:what_is_lunch_time_for/view/kakao_maps.dart';
import 'package:what_is_lunch_time_for/view/loading.dart';
import 'package:what_is_lunch_time_for/view/menu_insert_page.dart';
import 'package:what_is_lunch_time_for/view/result_page.dart';
import 'package:what_is_lunch_time_for/view/roulette_animation.dart';
import 'package:what_is_lunch_time_for/view/store_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');

  final status = await Permission.location.request();
  if (status.isGranted) {
    runApp(const MainPage());
  }
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
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsKakaoApi(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsAnimation(),
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
          '/roulette': (context) => const RouletteAnimation(),
          '/map': (context) => const KakaoMaps()
        },
      ),
    );
  }
}
