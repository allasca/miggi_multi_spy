import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:miggi_multi_spy/controller/main_controller.dart';
import 'package:miggi_multi_spy/model/storage_model.dart';

class StorageController extends GetxController {
  final box = GetStorage("app");
  final c = Get.find<MainController>();

  save() {
    var lRoom = <String>[];
    for (TextEditingController e in c.listRoomController) {
      lRoom.add(e.text);
    }
    final d = StorageModel(
      username: c.usernameController.text,
      password: c.passwordController.text,
      listRoom: lRoom,
    );
    box.write('data', d.toRawJson());
  }

  load() {
    String d = box.read('data') ??
        StorageModel(
          username: "",
          password: "",
          listRoom: ["", "", "", "", "", ""],
        ).toRawJson();
    StorageModel j = StorageModel.fromRawJson(d);
    c.usernameController.text = j.username;
    c.passwordController.text = j.password;
    for (var i = 0; i < j.listRoom.length; i++) {
      c.listRoomController[i].text = j.listRoom[i];
    }
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }
}
