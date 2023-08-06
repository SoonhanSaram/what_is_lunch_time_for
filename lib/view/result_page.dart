import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});
  late Functions _functionProvider;
  @override
  Widget build(BuildContext context) {
    _functionProvider = Provider.of<Functions>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _functionProvider.goToSearchList(context);
              },
              child: Text(
                '"${_functionProvider.selectedMenu}" 먹으러 GoGo ~ ',
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
