import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class FunctionsKakaoApi extends ChangeNotifier {
  double _longitude = 0;
  double _latitude = 0;
  String _villageName = "";
  String get vilageName => _villageName;
  double get latitude => _latitude;
  double get longitude => _longitude;
  List<Map<String, dynamic>> _positions = [];
  List<Map<String, dynamic>> get positions => _positions;

  void clearApiData() => {
        _longitude = 0,
        _latitude = 0,
        _villageName = "",
        _positions.clear(),
      };

  Future<void> searchStoreWithMap(BuildContext context, menu) async {
    _positions = [];
    try {
      await getLocation();
      try {
        // 현재위치를 기반으로 선택된 메뉴 검색
        final response = await http.get(
          Uri.parse("https://dapi.kakao.com/v2/local/search/keyword.json?x=$_longitude&y=$_latitude&radius=2000&query=$menu"),
          headers: {
            "Authorization": "KakaoAK ${dotenv.env['RESTAPI_KEY']}",
          },
        );
        Map<String, dynamic> body = jsonDecode(response.body);

        // 카카오 맵 Markers 배열에 담기 가게 정보 담기
        if (body['documents'].isNotEmpty) {
          int i = 0;
          for (i = 0; i < body['documents'].length; i++) {
            _positions.add(
              {
                'name': body['documents'][i]['place_name'].toString(),
                'lat': double.parse(body['documents'][i]['x']),
                'lng': double.parse(body['documents'][i]['y']),
              },
            );
          }
          Navigator.pushNamed(context, '/map');
        } else {
          callSnackBar(context, "주변에 매장이 없습니다.");
        }
      } catch (e) {
        callSnackBar(context, "$e 매장 검색에 실패했습니다.");
      }
    } catch (e) {
      callSnackBar(context, "$e 맛집 검색을 실패했습니다");
    }
  }

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
}
