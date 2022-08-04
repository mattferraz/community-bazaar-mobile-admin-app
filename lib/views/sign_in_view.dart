import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class SignInView extends StatelessWidget {
    SignInView({Key? key}) : super(key: key);
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        SizeConfig().initSizeConfig(context);
        return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
                    width: SizeConfig.kDeviceWidth,
                    height: SizeConfig.kDeviceHeight,
                    child: SafeArea(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Text("Sign In"),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                        children: [
                                            TextFormField()
                                        ],
                                    )
                                )
                            ],
                        ),
                    ),
                ),
            )
        );
    }
}
