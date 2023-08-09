import 'package:flutter/material.dart';

class Functions extends ChangeNotifier {
  final List<String> _menus = [];
  List<String> get menus => _menus;
  final List<bool> _showBack = [];
  List<bool> get showBack => _showBack;

  void showBackSwitch(index) {
    if (index >= 0 && index < showBack.length) {
      showBack[index] = !showBack[index]; // 반전
    }
    print(showBack);
    notifyListeners();
  }

  void addMenus(menu, BuildContext context) {
    if (menu == "") {
      callSnackBar(
        context,
        "텍스트를 입력해 주세요.",
      );
    } else if (_menus.length < 10) {
      _menus.add(menu);
      showBack.add(true);
    } else {
      callSnackBar(
        context,
        "선택지는 최대 10개까지 등록할 수 있습니다.",
      );
    }
    notifyListeners();
  }

  void deleteMenus(menu, index) {
    print(_menus[index]);

    _menus.removeAt(index);
    showBack[index] = true;
    notifyListeners();
  }

  // 기존의 룰렛(로딩 후 결과 발표 방식)
  /** 
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
  */

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
