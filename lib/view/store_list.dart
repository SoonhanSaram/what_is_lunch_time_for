import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';

class StoreListPage extends StatelessWidget {
  StoreListPage({super.key});
  late Functions _functionProvider;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> stores = context.read<Functions>().stores;
    _functionProvider = Provider.of<Functions>(context, listen: true);
    return Scaffold(
      body: ListView.builder(
        itemCount: stores[0]['items'].length,
        itemBuilder: (BuildContext context, index) {
          return SafeArea(
            child: ListTile(
              onTap: () {
                _functionProvider.goUrl(
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
            ),
          );
        },
      ),
    );
  }
}
