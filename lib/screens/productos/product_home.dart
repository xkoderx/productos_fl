import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductosServicio>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _Body(productService: productService),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.productService,
  });

  final ProductosServicio productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct.img,
                ),
                Boton(
                  paonde: () => Navigator.of(context).pop(),
                  left: 20,
                  icono: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 40,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 5)
                    ],
                  ),
                ),
                Boton(
                  paonde: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(
                      // source: ImageSource.camera,
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );
                    productService
                        .actualizarImagenProdSelected(pickedFile!.path);
                  },
                  right: 20,
                  icono: const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 5)
                    ],
                  ),
                ),
              ],
            ),
            const _Form()
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Guardar',
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save),
            Text(
              'Guardar',
              style: TextStyle(fontSize: 7),
            )
          ],
        ),
        onPressed: () async {
          if (!productForm.isValidForm()) return;
          final String? imageUrl = await productService.subirImg();
          productForm.producto.img = imageUrl!;
          await productService.guardarOcrearProducto(
            (productForm.producto),
          );
        },
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final producto = productForm.producto;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Form(
          key: productForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: producto.nombre,
                onChanged: (value) => producto.nombre = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nombre obligatorio';
                  }
                  value.isEmpty;
                  return null;
                },
                decoration: InputDecorations.authInpDecorat(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${producto.prec}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) => double.tryParse(value) == null
                    ? producto.prec = 0
                    : producto.prec = double.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Precio obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInpDecorat(
                  hintText: '\$150',
                  labelText: 'Precio:',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile(
                value: producto.disp,
                title: const Text('Disponible'),
                activeColor: Colors.red,
                onChanged: productForm.actualizarDisp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Boton extends StatelessWidget {
  final Icon icono;
  final double? left;
  final double? right;
  final Function() paonde;

  const Boton(
      {Key? key,
      required this.icono,
      this.left,
      this.right,
      required this.paonde})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return Positioned(
      top: 40,
      left: left,
      right: right,
      child: IconButton(
        onPressed: () {
          paonde();
        },
        icon: icono,
      ),
    );
  }
}
