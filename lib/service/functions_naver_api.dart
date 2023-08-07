import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:what_is_lunch_time_for/config/naver.dart';

class FunctionsNaverApi extends ChangeNotifier {
  final List<Map<String, dynamic>> _stores = [];
  List<Map<String, dynamic>> get stores => _stores;
  Apis apis = Apis();

// searchStore() 를 실행하기 위한 함수
  Future<void> goToSearchList(context, String selectedMenu) async {
    try {
      await searchStore(context, selectedMenu);
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
  Future<void> searchStore(context, String selectedMenu) async {
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
