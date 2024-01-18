import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miggi_multi_spy/badgeni/badgeni.dart';

class MainController extends GetxController {
  var listRoomController = <TextEditingController>[];
  var listResultParticipant = <List<String>>[];

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var isLogin = false.obs;

  late BadgeniUs bot;

  doSpy() async {
    for (var e in listResultParticipant) {
      e.clear();
      update();
    }
    bot = BadgeniUs(usernameController.text, passwordController.text);
    await Future.delayed(const Duration(seconds: 3));
    isLogin.value = bot.isLogin.value;
    for (var i = 0; i < 6; i++) {
      if (listRoomController[i].text.isEmpty) continue;
      Map status = {};
      bot.status.clear();
      bot.listRoom(listRoomController[i].text);
      while (true) {
        if (bot.status.isNotEmpty) {
          status = bot.status;
          break;
        }
        await Future.delayed(const Duration(milliseconds: 10));
      }
      List<String> users = [];
      if (status['event'] == 'room_list') {
        for (var e in status['data']['users']) {
          users.add(e['username']);
        }
      } else {
        users.add('Error');
      }
      listResultParticipant[i] = users;
      update();
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  createBucket() {
    for (var i = 0; i < 6; i++) {
      final t = TextEditingController(text: "");
      final p = <String>[];
      listRoomController.add(t);
      listResultParticipant.add(p);
    }
  }

  @override
  void onInit() {
    createBucket();
    super.onInit();
  }
}
