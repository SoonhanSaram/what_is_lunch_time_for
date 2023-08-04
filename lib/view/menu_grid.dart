import 'package:flutter/material.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';

Expanded menuGrid(Functions functionProvider) {
  return Expanded(
    child: GridView.builder(
      itemCount: functionProvider.menus.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
      ),
      itemBuilder: (BuildContext context, index) {
        return TextButton(
          onPressed: () {
            functionProvider.deleteMenus(
              functionProvider.menus[index],
            );
          },
          child: Text(
            functionProvider.menus[index],
            style: const TextStyle(fontSize: 36),
          ),
        );
      },
    ),
  );
}
