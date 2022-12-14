import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/services/products_batch_service.dart';
import 'package:get/state_manager.dart';

class ProductsBatchesController extends GetxController {
  final ProductsBatchService _productsBatchService = ProductsBatchService();
  RxList<ProductsBatch> productsBatches = <ProductsBatch>[].obs;
  RxList<ProductsBatch> selectedProductsBatches = <ProductsBatch>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    findAllProductsBatches();
  }

  void findAllProductsBatches() async {
    isLoading(true);
    productsBatches.value = List<ProductsBatch>.from(await _productsBatchService.findAllProductsBatches());
    isLoading(false);
  }

  Future<List<Product>> findAllProductsFromProductBatch(int productsBatchId) async {
    List<Product> products = List<Product>.from(await _productsBatchService.findAllProductsFromProductBatchId(productsBatchId));
    return products;
  }

  void createProductBatch(String note, DateTime deliveryDate, SupervisoryOrgan supervisoryOrgan, DoneeInstitution? doneeInstitution) async {
    isLoading(true);
    ProductsBatch productsBatch = ProductsBatch(note: note, deliveryDate: deliveryDate, supervisoryOrganDto: supervisoryOrgan, doneeInstitutionDto: doneeInstitution);
    ProductsBatch createdProductsBatch = await _productsBatchService.createProductsBatch(productsBatch);
    productsBatches.add(createdProductsBatch);
    isLoading(false);
  }

  void updateProductBatch(ProductsBatch productsBatch) async {
    isLoading(true);
    await _productsBatchService.updateProductsBatch(productsBatch);
    int productsBatchIndex = productsBatches.indexWhere((element) => element.id == productsBatch.id);
    productsBatches[productsBatchIndex] = productsBatch;
    isLoading(false);
  }

  void deleteProductBatch(int productsBatchId, int productsBatchIndex) async {
    isLoading(true);
    await _productsBatchService.deleteProductsBatchById(productsBatchId);
    productsBatches.removeAt(productsBatchIndex);
    isLoading(false);
  }

  void deleteMultipleProductsBatches(List<ProductsBatch> productsBatchesToBeDeleted) async {
    isLoading(true);
    for (ProductsBatch productsBatch in productsBatchesToBeDeleted) {
      await _productsBatchService.deleteProductsBatchById(productsBatch.id!);
    }
    productsBatchesToBeDeleted.clear();
    findAllProductsBatches();
    isLoading(false);
  }
  
}