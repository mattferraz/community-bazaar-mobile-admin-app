import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:bazaar_adm/controllers/products_controller.dart';
import 'package:bazaar_adm/views/products_form.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/size_config.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);
  final ProductsController _controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Produtos"),
        actions: [
          Obx(() {
            if(_controller.selectedProducts.isNotEmpty) {
              return IconButton(
                onPressed: () => _controller.deleteMultipleProducts(_controller.selectedProducts),
                icon: const Icon(Icons.delete_rounded)
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
      body: SizedBox(
        width: SizeConfig.kDeviceWidth,
        height: SizeConfig.kDeviceHeight,
        child: SafeArea(
          child: Obx(() => ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.products.length,
            itemBuilder: (context, index) => Obx(() => ListTile(
              leading: Text(_controller.products[index].id.toString()),
              title: Text(_controller.products[index].name),
              subtitle: Text(_controller.products[index].brand),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedProducts.contains(_controller.products[index]),
              onLongPress: () {
                _controller.selectedProducts.contains(_controller.products[index])
                  ? _controller.selectedProducts.remove(_controller.products[index])
                  : _controller.selectedProducts.add(_controller.products[index]);
              },
            )) 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<dynamic> fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsForm()));
          _controller.createProduct(fields[0], fields[1], fields[2], fields[3], fields[4]);
        },
      ),
    );
  }
}