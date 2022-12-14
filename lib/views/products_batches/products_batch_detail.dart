import 'package:bazaar_adm/views/products_batches/products_batch_form.dart';
import 'package:flutter/material.dart';

import '../../constants/size_config.dart';
import '../../models/products_batch.dart';
import '../../utils/date_time_formatter.dart';

class ProductsBatchDetail extends StatelessWidget {
  final ProductsBatch productsBatch;

  const ProductsBatchDetail({
    required this.productsBatch,
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
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductsBatchForm(productsBatch: productsBatch))), 
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
                    Text("Data de Recebimento: ${DateTimeFormatter.formatDateTime(productsBatch.deliveryDate)}"),
                    Text("Observa????o: ${productsBatch.note}")
                  ],
                ),
                const SizedBox(height: 40,),
                const Text(
                  "Org??o Fiscalizador",
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
                    Text("Nome: ${productsBatch.supervisoryOrganDto.name}"),
                    Text("Descri????o: ${productsBatch.supervisoryOrganDto.description}")
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  "Institui????o Donat??ria",
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
                    Text("Nome: ${productsBatch.doneeInstitutionDto?.name}"),
                    Text("Endere??o: ${productsBatch.doneeInstitutionDto?.address}"),
                    Text("Telefone: ${productsBatch.doneeInstitutionDto?.phoneNumber}"),
                    Text("Descri????o: ${productsBatch.doneeInstitutionDto?.description}")
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