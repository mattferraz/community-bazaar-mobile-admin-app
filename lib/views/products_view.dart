import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:bazaar_adm/controllers/products_controller.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Products"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
        itemCount: productsController.products.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(productsController.products.elementAt(index).name),
          subtitle: Text(productsController.products.elementAt(index).brand),
        ), 
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}