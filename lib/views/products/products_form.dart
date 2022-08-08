import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/products_batches_controller.dart';
import 'package:bazaar_adm/controllers/products_controller.dart';
import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/style_constants.dart';

class ProductsForm extends StatefulWidget {

  final Product? product;

  const ProductsForm({
    this.product,
    Key? key
  }) : super(key: key);

  @override
  State<ProductsForm> createState() => _ProductsFormState();
}

class _ProductsFormState extends State<ProductsForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController categoryController= TextEditingController();

  final TextEditingController? descriptionController = TextEditingController();

  final ProductsBatchesController _productsBatchesController = Get.put(ProductsBatchesController());

  final ProductsController _controller = Get.find<ProductsController>();

  ProductsBatch? productsBatchSelected;
  
  @override
  void initState() {
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      brandController.text = widget.product!.brand;
      categoryController.text = widget.product!.category;
      descriptionController?.text = widget.product!.description ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.kDeviceHeight,
        width: SizeConfig.kDeviceWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  widget.product == null ? const Text(
                    "Cadastrar Produto",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  : const Text(
                    "Editar Produto",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  CustomTextFormField(fieldLabel: "Nome", controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Marca", controller: categoryController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Categoria", controller: brandController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Descrição", controller: descriptionController),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<dynamic>(
                    items: List<DropdownMenuItem>.from(_productsBatchesController.productsBatches.map((element) => DropdownMenuItem(value: element, child: Text("${element.id}: ${element.supervisoryOrganDto.name} -> ${element.doneeInstitutionDto?.name}")))),
                    value: productsBatchSelected,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1.5, color: StyleConstants.primaryColor)
                      ),
                      label: const Text("Lote de Produtos"),
                      fillColor: Colors.white
                    ),
                    onChanged: (value) {
                      if (value is ProductsBatch) {
                        setState(() {
                          productsBatchSelected = value;
                        });
                      }
                    }
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Continuar", 
                    onPressed: widget.product == null ? () {
                      Navigator.pop(context, [nameController.text, brandController.text, categoryController.text, descriptionController?.text, productsBatchSelected]);
                    }
                    :() {
                      widget.product!.name = nameController.text;
                      widget.product!.brand = brandController.text;
                      widget.product!.category = categoryController.text;
                      widget.product!.description = descriptionController?.text;
                      widget.product!.productsBatch = productsBatchSelected;
                      _controller.updateProduct(widget.product!);
                      Navigator.pop(context);
                    }
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}