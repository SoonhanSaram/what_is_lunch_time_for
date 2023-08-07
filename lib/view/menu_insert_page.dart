import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/view/filed_button.dart';
import 'package:what_is_lunch_time_for/view/menu_grid.dart';

class InsertPage extends StatelessWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Functions functionProvider = Provider.of<Functions>(context, listen: true);
    TextEditingController menuTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("오늘 뭐 먹지?"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: menuTextController,
                      decoration: const InputDecoration(
                        hintText: "오늘 먹을 메뉴",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 40,
                      style: const ButtonStyle(
                        surfaceTintColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        functionProvider.addMenus(menuTextController.text, context);
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              menuGrid(functionProvider),
              ranndomButton(functionProvider, context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
