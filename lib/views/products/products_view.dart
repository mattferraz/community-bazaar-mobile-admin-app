import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:bazaar_adm/controllers/products_controller.dart';
import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/views/products/product_detail.dart';
import 'package:bazaar_adm/views/products/products_form.dart';
import 'package:bazaar_adm/widgets/empty_list_view_illustrator.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/size_config.dart';

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
          child: Obx(() => _controller.products.isEmpty 
            ? const Padding(
              padding: EdgeInsets.all(SizeConfig.kdefaultPadding),
              child: EmptyListViewIllustrator(
                message: "Você ainda não cadastrou nenhum produto. Clique no botão abaixo para cadastrar um novo.", 
                imagePath: "assets/images/Online shopping-bro.png"
              ),
            )
            : _controller.isLoading.value 
            ? const Center(child: CircularProgressIndicator(color: StyleConstants.primaryColor)) 
            : ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.products.length,
            itemBuilder: (context, index) {
              final Product currentProduct = _controller.products[index];
              return Obx(() => ListTile(
              leading: Text(currentProduct.id.toString()),
              title: Text(currentProduct.name),
              subtitle: Text(currentProduct.brand),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedProducts.contains(currentProduct),
              onLongPress: () {
                _controller.selectedProducts.contains(currentProduct)
                  ? _controller.selectedProducts.remove(currentProduct)
                  : _controller.selectedProducts.add(currentProduct);
              },
              onTap: () {
                _controller.selectedProducts.isEmpty 
                ? Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: currentProduct)))
                : _controller.selectedProducts.contains(currentProduct)
                ? _controller.selectedProducts.remove(currentProduct)
                : _controller.selectedProducts.add(currentProduct);
              },
            ));
            } 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<dynamic>? fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsForm()));
          if (fields != null) {
            _controller.createProduct(fields[0], fields[1], fields[2], fields[3], fields[4]);
          }
        },
      ),
    );
  }
}