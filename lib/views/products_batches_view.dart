import 'package:bazaar_adm/controllers/products_batches_controller.dart';
import 'package:bazaar_adm/views/products_batch_form.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../constants/size_config.dart';
import '../constants/style_constants.dart';

class ProductsBatchesView extends StatelessWidget {
  ProductsBatchesView({Key? key}) : super(key: key);
  final ProductsBatchesController _controller = Get.put(ProductsBatchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Batches"),
        actions: [
          Obx(() {
            if(_controller.selectedProductsBatches.isNotEmpty) {
              return IconButton(
                onPressed: () => _controller.deleteMultipleProductsBatches(_controller.selectedProductsBatches),
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
            itemCount: _controller.productsBatches.length,
            itemBuilder: (context, index) => Obx(() => ListTile(
              leading: Text(_controller.productsBatches[index].id.toString()),
              title: Text(_controller.productsBatches[index].supervisoryOrganDto.name),
              subtitle: Text(_controller.productsBatches[index].deliveryDate.toIso8601String()),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedProductsBatches.contains(_controller.productsBatches[index]),
              onLongPress: () {
                _controller.selectedProductsBatches.contains(_controller.productsBatches[index])
                  ? _controller.selectedProductsBatches.remove(_controller.productsBatches[index])
                  : _controller.selectedProductsBatches.add(_controller.productsBatches[index]);
              },
            )) 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<dynamic> fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsBatchForm()));
          _controller.createProductBatch(fields[0]!, fields[1], fields[2], fields[3]);
        },
      ),
    );
  }
}