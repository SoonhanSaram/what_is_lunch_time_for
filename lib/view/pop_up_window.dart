import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions_kakao_api.dart';
import 'package:what_is_lunch_time_for/service/functions_naver_api.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';

class PopupWindow extends StatelessWidget {
  const PopupWindow({super.key});

  @override
  Widget build(BuildContext context) {
    FunctionsNaverApi functionsNaverApi = Provider.of<FunctionsNaverApi>(context, listen: true);
    FunctionsKakaoApi functionsKakaoApi = Provider.of<FunctionsKakaoApi>(context, listen: false);
    String selectedMenu = context.watch<FunctionsRoulette>().selectedMenu;

    return AlertDialog(
      title: const Text("메뉴 검색 하기"),
      content: Row(
        children: [
          TextButton(
            onPressed: () {
              functionsKakaoApi.searchStoreWithMap(context, selectedMenu);
            },
            child: const Text(
              "주변에서 찾아 보기",
              style: TextStyle(fontSize: 16, color: Colors.yellow),
            ),
          ),
          TextButton(
            onPressed: () {
              functionsNaverApi.goToSearchList(context, selectedMenu);
            },
            child: const Text(
              "네이버 맛집 검색",
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // 팝업 닫기
          },
          child: const Text("닫기"),
        ),
      ],
    );
  }
}
