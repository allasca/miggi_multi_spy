import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetSpy extends StatelessWidget {
  const WidgetSpy(
      {super.key, required this.controller, required this.participant});

  final TextEditingController controller;
  final List<String> participant;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    label: Text('Room'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.colorScheme.surfaceVariant,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 9,
                        columns: const [
                          DataColumn(
                            label: Text('Username'),
                          ),
                        ],
                        rows: List.generate(
                          participant.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  participant[index],
                                ),
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
