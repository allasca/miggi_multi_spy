import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miggi_multi_spy/controller/main_controller.dart';
import 'package:miggi_multi_spy/controller/storage_controller.dart';
import 'package:miggi_multi_spy/ui/widget_spy.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MainController());
    final s = Get.put(StorageController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      controller: c.usernameController,
                      onChanged: s.save(),
                      decoration: const InputDecoration(
                        label: Text('Username'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Flexible(
                    child: TextField(
                      controller: c.passwordController,
                      onChanged: s.save(),
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Obx(
                    () => FilledButton(
                      onPressed: () {
                        c.doSpy();
                        s.save();
                      },
                      style: ButtonStyle(
                        backgroundColor: c.isLogin.value
                            ? MaterialStateProperty.all(Colors.greenAccent)
                            : MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Text('SPY ALL'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            Expanded(
              child: GetBuilder<MainController>(
                init: MainController(),
                builder: (cc) => Row(
                  children: List.generate(
                    6,
                    (index) => WidgetSpy(
                      controller: cc.listRoomController[index],
                      participant: cc.listResultParticipant[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
