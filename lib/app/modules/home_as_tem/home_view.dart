import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.signIn();
      }),
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(
              ()=> Text(
                controller.tok.value,
                style: TextStyle(fontSize: 20),
              ),
            ),
            FloatingActionButton(onPressed: () {
              controller.fetchCompany();
            })
          ],
        ),
      ),
    );
  }
}
