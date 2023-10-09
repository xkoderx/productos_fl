import 'package:flutter/material.dart';
import 'package:productos_app/models/productos.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductosServicio>(context);
    if (productService.isLoading) return const Loading();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Productos',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productService.productos.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productService.selectedProduct =
                productService.productos[index].copia();
            Navigator.pushNamed(context, 'productos');
          },
          child: ProductCard(
            producto: productService.productos[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nuevo Producto',
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text(
              'Nuevo',
              style: TextStyle(fontSize: 7),
            )
          ],
        ),
        onPressed: () {
          productService.selectedProduct =
              Producto(img: '', disp: true, nombre: '', prec: 0);
          Navigator.pushNamed(context, 'productos');
        },
      ),
    );
  }
}
