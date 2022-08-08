import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/views/supervisory_organs/supervisory_organ_form.dart';
import 'package:flutter/material.dart';

import '../../constants/size_config.dart';

class SupervisoryOrganDetail extends StatelessWidget {
  final SupervisoryOrgan supervisoryOrgan;
  const SupervisoryOrganDetail({
    required this.supervisoryOrgan,
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
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SupervisoryOrganForm(supervisoryOrgan: supervisoryOrgan))), 
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
                    Text("Nome: ${supervisoryOrgan.name}"),
                    Text("Descrição: ${supervisoryOrgan.description}"),
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