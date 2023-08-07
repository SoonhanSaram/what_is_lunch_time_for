import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions_naver_api.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    FunctionsNaverApi functionsNaverApi = Provider.of<FunctionsNaverApi>(context, listen: true);
    String selectedMenu = context.watch<FunctionsRoulette>().selectedMenu;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                functionsNaverApi.goToSearchList(context, selectedMenu);
              },
              child: Text(
                '"$selectedMenu" 먹으러 GoGo ~ ',
                style: const TextStyle(fontSize: 34, color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text(
                "돌아가기",
                style: TextStyle(fontSize: 24, color: Colors.redAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
