import 'package:flutter/material.dart';
import 'package:productos_app/models/productos.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Producto producto;
  ProductFormProvider(this.producto);
  actualizarDisp(bool value) {
    producto.disp = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
