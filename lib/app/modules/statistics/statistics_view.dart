import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'statistics_controller.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: const Center(child: Text('Statistics Page')),
    );
  }
}
