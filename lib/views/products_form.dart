import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/products_batches_controller.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsForm extends StatefulWidget {

  const ProductsForm({Key? key}) : super(key: key);

  @override
  State<ProductsForm> createState() => _ProductsFormState();
}

class _ProductsFormState extends State<ProductsForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController categoryController= TextEditingController();

  final TextEditingController? descriptionController = TextEditingController();

  final ProductsBatchesController _productsBatchesController = Get.put(ProductsBatchesController());

  ProductsBatch? productsBatchSelected;

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
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Cadastrar Instituição Donatária",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 60,),
                  CustomTextFormField(fieldLabel: "Name", controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Brand", controller: categoryController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Category", controller: brandController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Description", controller: descriptionController),
                  DropdownButton<dynamic>(
                    items: List<DropdownMenuItem>.from(_productsBatchesController.productsBatches.map((element) => DropdownMenuItem(value: element, child: Text("${element.id}: ${element.supervisoryOrganDto.name} -> ${element.doneeInstitutionDto?.name}")))),
                    value: productsBatchSelected,
                    onChanged: (value) {
                      if (value is ProductsBatch) {
                        setState(() {
                          productsBatchSelected = value;
                          print(productsBatchSelected!.id);
                        });
                      }
                    }
                  ),
                  const SizedBox(height: 60),
                  CustomButton(
                    text: "Continue", 
                    onPressed: () => Navigator.pop(context, [nameController.text, brandController.text, categoryController.text, descriptionController?.text, productsBatchSelected])
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