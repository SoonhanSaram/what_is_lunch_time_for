import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as Math;

import 'package:what_is_lunch_time_for/config/naver.dart';

class Functions extends ChangeNotifier {
  final List<String> _menus = [];
  String _selectedMenu = "";
  List<String> get menus => _menus;
  String get selectedMenu => _selectedMenu;
  final List<Map<String, dynamic>> _stores = [];
  List<Map<String, dynamic>> get stores => _stores;

  final apis = Apis();

  void addMenus(menu, BuildContext context) {
    if (menu == "") {
      callSnackBar(
        context,
        "텍스트를 입력해 주세요.",
      );
    } else if (_menus.length < 10) {
      _menus.add(menu);
    } else {
      callSnackBar(
        context,
        "선택지는 최대 10개까지 등록할 수 있습니다.",
      );
    }
    notifyListeners();
  }

  void deleteMenus(menu) {
    _menus.retainWhere(
      (element) {
        return element != menu;
      },
    );
    notifyListeners();
  }

  void roulette(context) {
    int randomIndex = 0;
    if (menus.isEmpty) {
      callSnackBar(context, "메뉴를 입력해주세요");
    } else if (menus.length == 1) {
      callSnackBar(context, "2개 이상의 메뉴를 입력해주세요");
    } else {
      // 로딩 화면으로 전환
      Navigator.pushNamed(context, '/loading');

      // menus 배열의 랜덤 인덱스 위치 값을 _selectedMenu에 할당
      randomIndex = Math.Random().nextInt(menus.length);
      _selectedMenu = menus[randomIndex];

      // menus 배열 초기화
      menus.clear();

      // 2초 딜레이 이후 결과창 전환
      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
          );
        },
      );
    }
  }

  void callSnackBar(context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // searchStore() 를 실행하기 위한 함수
  Future<void> goToSearchList(context) async {
    try {
      await searchStore(context);
      List<dynamic> items = _stores[0]['items'];
      for (var itemData in items) {
        String title = itemData['title'];
        title = title.replaceAll('<b>', ' ').replaceAll('</b>', ' ').replaceAll("&quot;", "");
        itemData['title'] = title;
      }
      print(_stores);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/stores',
        (route) => false,
      );
    } catch (e) {
      rethrow;
    }
  }

  // naverApi 를 통해서 선정된 메뉴 검색
  Future<void> searchStore(context) async {
    try {
      final uri = Uri.parse(
        'https://openapi.naver.com/v1/search/blog.json?query=${Uri.encodeComponent(selectedMenu)}&display=100',
      );
      final response = await http.get(
        uri,
        headers: {
          "X-Naver-Client-Id": apis.naverId,
          "X-Naver-Client-Secret": apis.naverPasswd,
        },
      );
      _stores.add(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      print("수신실패");
      rethrow;
    }
  }

  // 해당 블로그로 이동하기 위한 함수
  Future<void> goUrl(url) async {
    print(url);
    await launchUrl(
      Uri.parse(url),
    );
  }
}
