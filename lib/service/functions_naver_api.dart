import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:what_is_lunch_time_for/config/naver.dart';

class FunctionsNaverApi extends ChangeNotifier {
  final List<Map<String, dynamic>> _stores = [];
  List<Map<String, dynamic>> get stores => _stores;
  Apis apis = Apis();
  double _longitude = 0;
  double _latitude = 0;
  String _villageName = "";
  String get vilageName => _villageName;

  void clearApiData() => {
        _longitude = 0,
        _latitude = 0,
        _villageName = "",
        _stores.clear(),
      };

// searchStore() 를 실행하기 위한 함수
  Future<void> goToSearchList(context, String selectedMenu) async {
    try {
      await getLocation();
      print(_villageName);
      try {
        await searchStore(context, selectedMenu);
        List<dynamic> items = _stores[0]['items'];
        for (var itemData in items) {
          String title = itemData['title'];
          title = title.replaceAll('<b>', ' ').replaceAll('</b>', ' ').replaceAll("&quot;", "");
          itemData['title'] = title;
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/stores',
          (route) => false,
        );
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

// naverApi 를 통해서 선정된 메뉴 검색
  Future<void> searchStore(context, String selectedMenu) async {
    try {
      final uri = Uri.parse(
        'https://openapi.naver.com/v1/search/blog.json?query=${Uri.encodeComponent(selectedMenu)},${Uri.encodeComponent(_villageName)}&display=100',
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

  // 동네이름 찾기 함수
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _longitude = position.longitude;
    _latitude = position.latitude;

    // 현재 위치의 행정동 이름 찾기
    final response = await http.get(
      Uri.parse("https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$_longitude&y=$_latitude"),
      headers: {
        "Authorization": "KakaoAK ${dotenv.env['RESTAPI_KEY']}",
      },
    );

    Map<String, dynamic> body = jsonDecode(response.body);

    _villageName = body['documents'][0]['address_name'];
  }

// 해당 블로그로 이동하기 위한 함수
  Future<void> goUrl(url) async {
    print(url);
    await launchUrl(
      Uri.parse(url),
    );
  }
}
