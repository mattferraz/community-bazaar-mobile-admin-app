import 'package:bazaar_adm/controllers/products_batches_controller.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/utils/date_time_formatter.dart';
import 'package:bazaar_adm/views/products_batches/products_batch_detail.dart';
import 'package:bazaar_adm/views/products_batches/products_batch_form.dart';
import 'package:bazaar_adm/widgets/empty_list_view_illustrator.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../constants/size_config.dart';
import '../../constants/style_constants.dart';

class ProductsBatchesView extends StatelessWidget {
  ProductsBatchesView({Key? key}) : super(key: key);
  final ProductsBatchesController _controller = Get.put(ProductsBatchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Lotes"),
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
          child: Obx(() => _controller.productsBatches.isEmpty 
          ? const Padding(
            padding: EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: EmptyListViewIllustrator(
              message: "Você ainda não cadastrou nenhum lote de produtos. Clique no botão abaixo para cadastrar um novo.", 
              imagePath: "assets/images/Online shopping-bro.png"
            ),
          )
          : _controller.isLoading.value 
          ? const Center(child: CircularProgressIndicator(color: StyleConstants.primaryColor)) 
          : ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.productsBatches.length,
            itemBuilder: (context, index) {
              ProductsBatch currentProductsBatch = _controller.productsBatches[index];
              return Obx(() => ListTile(
              leading: Text(currentProductsBatch.id.toString()),
              title: Text(currentProductsBatch.supervisoryOrganDto.name),
              subtitle: Text(DateTimeFormatter.formatDateTime(currentProductsBatch.deliveryDate)),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedProductsBatches.contains(currentProductsBatch),
              onLongPress: () {
                _controller.selectedProductsBatches.contains(currentProductsBatch)
                  ? _controller.selectedProductsBatches.remove(currentProductsBatch)
                  : _controller.selectedProductsBatches.add(currentProductsBatch);
              },
              onTap: () {
                _controller.selectedProductsBatches.isEmpty 
                ? Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsBatchDetail(productsBatch: currentProductsBatch)))
                : _controller.selectedProductsBatches.contains(currentProductsBatch)
                ? _controller.selectedProductsBatches.remove(currentProductsBatch)
                : _controller.selectedProductsBatches.add(currentProductsBatch);
              },
            ));
            } 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<dynamic>? fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsBatchForm()));
          if (fields != null) {
            _controller.createProductBatch(fields[0]!, fields[1], fields[2], fields[3]);
          }
        },
      ),
    );
  }
}