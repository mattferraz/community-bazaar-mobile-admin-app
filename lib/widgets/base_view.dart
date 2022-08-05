import 'package:bazaar_adm/views/donee_institutions_view.dart';
import 'package:bazaar_adm/views/products_batches_view.dart';
import 'package:bazaar_adm/views/products_view.dart';
import 'package:bazaar_adm/views/supervisory_organs_view.dart';
import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int selectedViewIndex = 0;

  final Map<String, Widget> views = {
    "Products": const ProductsView(),
    "Batches": const ProductsBatchesView(),
    "Donors": const DoneeInstitutionsView(),
    "Supervisors": const SupervisoryOrgansView()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1565C0),
        title: Text(views.keys.elementAt(selectedViewIndex)),
      ),
      body: views.values.elementAt(selectedViewIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(color: Color(0xFF1565C0)),
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          selectedViewIndex = value;
        }),
        currentIndex: selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/basket.png", width: 24.0, height: 24.0),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/insurance.png", width: 24.0, height: 24.0),
            label: "Supervisors"
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/product.png", width: 24.0, height: 24.0),
            label: "Batches"
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/solidarity.png", width: 24.0, height: 24.0),
            label: "Donors"
          )
        ]
      ),
    );
  }
}