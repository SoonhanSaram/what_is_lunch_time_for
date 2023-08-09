import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_kakao_api.dart';
import 'package:what_is_lunch_time_for/service/functions_naver_api.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';

class StoreListPage extends StatelessWidget {
  const StoreListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> stores = context.read<FunctionsNaverApi>().stores;
    FunctionsNaverApi functionsNaverApi = Provider.of<FunctionsNaverApi>(context, listen: true);
    String vilageName = context.read<FunctionsKakaoApi>().vilageName == "" ? context.read<FunctionsNaverApi>().vilageName : context.read<FunctionsKakaoApi>().vilageName;
    String selectedMenu = context.read<FunctionsRoulette>().selectedMenu;
    List<String> menus = context.watch<Functions>().menus;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              textAlign: TextAlign.center,
              "$vilageName의 $selectedMenu집",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stores[0]['items'].length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      functionsNaverApi.goUrl(
                        stores[0]['items'][index]['link'],
                      );
                    },
                    title: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                      )),
                      child: Text(
                        stores[0]['items'][index]['title'],
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                functionsNaverApi.clearApiData();
                menus.clear();
              },
              child: const Text("홈으로"),
            )
          ],
        ),
      ),
    );
  }
}
