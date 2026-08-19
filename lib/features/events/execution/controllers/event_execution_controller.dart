import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class ExecutionItem {
  final String title;
  final String vendor;
  final int qty;
  final double rate;
  final double total;
  final String? description;
  final List<String> tags;
  bool isExpanded;

  ExecutionItem({
    required this.title,
    required this.vendor,
    required this.qty,
    required this.rate,
    required this.total,
    this.description,
    this.tags = const [],
    this.isExpanded = false,
  });
}

class EventExecutionController extends GetxController {
  final referenceController = TextEditingController();
  final inchargeController = TextEditingController(text: 'Select Incharge');
  final noteController = TextEditingController();
  
  final setupDateController = TextEditingController();
  final setupTimeController = TextEditingController();
  final dismantleDateController = TextEditingController();
  final dismantleTimeController = TextEditingController();

  final searchItemController = TextEditingController();

  final selectedFunction = 'Gala Dinner'.obs;

  final items = <ExecutionItem>[
    ExecutionItem(
      title: 'Flowers & Props',
      vendor: 'Vendor: Vishal Bhai',
      qty: 100,
      rate: 12,
      total: 1200,
      isExpanded: false,
    ),
    ExecutionItem(
      title: 'Decorative Lighting',
      vendor: 'Vendor: Lumina Events',
      qty: 50,
      rate: 150,
      total: 7500,
      description: 'Setup required before 4:00 PM. Include 10 extra ambient uplights around the main stage area.',
      tags: ['Uplighting', 'Stage Wash'],
      isExpanded: true,
    ),
    ExecutionItem(
      title: 'Floral Centerpieces',
      vendor: 'Vendor: Vishal Bhai',
      qty: 25,
      rate: 800,
      total: 20000,
      isExpanded: false,
    ),
  ].obs;

  void toggleItemExpansion(int index) {
    items[index].isExpanded = !items[index].isExpanded;
    items.refresh();
  }

  void navigateToItemDetails({String? itemName}) {
    Get.toNamed(
      AppRoutes.itemDetails,
      arguments: {'title': itemName ?? 'Decorative Lighting'},
    );
  }

  @override
  void onClose() {
    referenceController.dispose();
    inchargeController.dispose();
    noteController.dispose();
    setupDateController.dispose();
    setupTimeController.dispose();
    dismantleDateController.dispose();
    dismantleTimeController.dispose();
    searchItemController.dispose();
    super.onClose();
  }
}
