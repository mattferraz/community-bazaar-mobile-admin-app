import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../constants/style_constants.dart';
import 'donee_institutions/donee_institutions_view.dart';
import 'products_batches/products_batches_view.dart';
import 'products/products_view.dart';
import 'supervisory_organs/supervisory_organs_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedViewIndex = 0;

  final List<Widget> views = [
    ProductsView(),
    ProductsBatchesView(),
    DoneeInstitutionsView(),
    SupervisoryOrgansView()
  ];
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().initSizeConfig(context);
    return Scaffold(
      body: views.elementAt(_selectedViewIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.0,
        fixedColor: StyleConstants.primaryColor,
        showUnselectedLabels: true,
        unselectedFontSize: 14.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedViewIndex,
        onTap: (value) => setState(() {
          _selectedViewIndex = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/basket.png", width: 24.0, height: 24.0),
            label: "Produtos",
            activeIcon: Image.asset("assets/icons/basket.png", width: 24.0, height: 24.0, color: StyleConstants.primaryColor)
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/product.png", width: 24.0, height: 24.0),
            label: "Lotes",
            activeIcon: Image.asset("assets/icons/product.png", width: 24.0, height: 24.0, color: StyleConstants.primaryColor)
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/solidarity.png", width: 24.0, height: 24.0),
            label: "Doadores",
            activeIcon: Image.asset("assets/icons/solidarity.png", width: 24.0, height: 24.0, color: StyleConstants.primaryColor)
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/insurance.png", width: 24.0, height: 24.0),
            label: "Fiscalizadores",
            activeIcon: Image.asset("assets/icons/insurance.png", width: 24.0, height: 24.0, color: StyleConstants.primaryColor)
          )
        ]
      ),
    );
  }
}