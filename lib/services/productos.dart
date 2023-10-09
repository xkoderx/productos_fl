import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/dotenv.dart';
import 'package:productos_app/models/models.dart';

class ProductosServicio extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final List<Producto> productos = [];
  late Producto selectedProduct;
  bool isLoading = true;
  bool isSaving = false;
  File? newImgFile;
  ProductosServicio() {
    cargarProductos();
  }
  Future cargarProductos() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(
      baseUrl,
      'productos.json',
      {'auth': await storage.read(key: 'token') ?? ''},
    );
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Producto.fromMap(value);
      tempProduct.id = key;
      productos.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return productos;
  }

  Future guardarOcrearProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    producto.id == null
        ? await crearProducto(producto)
        : await actualizarProducto(producto);

    isSaving = false;
    notifyListeners();
  }

  Future actualizarProducto(Producto producto) async {
    final url = Uri.https(baseUrl, 'productos/${producto.id}.json');
    final resp = await http.put(
      url,
      body: producto.toJson(),
    );
    final decodedData = resp.body;
    //actualizar el listado de productos
    final index = productos.indexWhere((element) => element.id == producto.id);
    productos[index] = producto;
    notifyListeners();
    return producto.id;
  }

  Future crearProducto(Producto producto) async {
    final url = Uri.https(baseUrl, 'productos.json');
    final resp = await http.post(
      url,
      body: producto.toJson(),
    );
    final decodedData = jsonDecode(resp.body);
    producto.id = decodedData['name'];
    productos.add(producto);
    // notifyListeners();
    return producto.id;
  }

  void actualizarImagenProdSelected(String path) {
    selectedProduct.img = path;
    newImgFile = File.fromUri(
      Uri(path: path),
    );
    notifyListeners();
  }

  Future<String?> subirImg() async {
    newImgFile!;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse(imgUrl);
    final imgUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newImgFile!.path);
    imgUploadRequest.files.add(file);
    final streamResponse = await imgUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
