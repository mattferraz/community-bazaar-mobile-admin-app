import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/utils/date_time_formatter.dart';
import 'package:bazaar_adm/views/products/products_form.dart';
import 'package:flutter/material.dart';

import '../../constants/size_config.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({
    required this.product,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.kDeviceHeight,
        width: SizeConfig.kDeviceWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close)
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductsForm(product: product))), 
                      icon: const Icon(Icons.edit_rounded)
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                const Text(
                  "Detalhes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome: ${product.name}"),
                    Text("Marca: ${product.brand}"),
                    Text("Categoria: ${product.category}"),
                    Text("Descrição: ${product.description}"),
                  ],
                ),

                const SizedBox(height: 40,),

                const Text(
                  "Lote do Produto",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Orgão Fiscalizador: ${product.productsBatch?.supervisoryOrganDto.name}"),
                    Text("Instituição Donatária: ${product.productsBatch?.doneeInstitutionDto?.name}"),
                    Text("Data de Recebimento: ${DateTimeFormatter.formatDateTime(product.productsBatch!.deliveryDate)}"),
                    Text("Observação: ${product.productsBatch?.note}")
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}