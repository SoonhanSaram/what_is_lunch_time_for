import 'package:flutter/material.dart';
import 'dart:math' as Math;

class FunctionsRoulette extends ChangeNotifier {
  final List<String> _randomIndexList = [];
  List<String> get randomIndexList => _randomIndexList;
  String _selectedMenu = "";
  String get selectedMenu => _selectedMenu;

  void flickerAnimation(context, menus) async {
    Navigator.pushNamed(context, '/roulette');
    int randomIndex;
    randomIndex = Math.Random().nextInt(menus.length);
    _selectedMenu = await menus[randomIndex];

    // for문 안쪽에 비동기 함수인 await Future.delayed()를 사용하면 ui 업데이트에 오류 야기
    // for문 안쪽 중간에 사용하지 않고 마지막에 사용해 delay 이 후 다시 for문이 실행되도록 바꿔 줌
    for (String item in menus) {
      if (_randomIndexList.isNotEmpty) {
        _randomIndexList.removeLast();
        notifyListeners();
      }
      _randomIndexList.add(item);
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));
    }
    await Future.delayed(const Duration(milliseconds: 300));
    _randomIndexList.removeLast();
    _randomIndexList.add(_selectedMenu);
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/result',
      (route) => false,
    );
  }
}