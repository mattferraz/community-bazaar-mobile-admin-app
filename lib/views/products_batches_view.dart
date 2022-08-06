import 'package:bazaar_adm/controllers/products_batches_controller.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style_constants.dart';

class ProductsBatchesView extends StatelessWidget {
  ProductsBatchesView({Key? key}) : super(key: key);
  final ProductsBatchesController _productsBatchesController = Get.put(ProductsBatchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Batches"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
        itemCount: _productsBatchesController.productsBatches.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_productsBatchesController.productsBatches.elementAt(index).supervisoryOrgan.name),
          subtitle: Text(_productsBatchesController.productsBatches.elementAt(index).deliveryDate.toIso8601String()),
        ), 
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}