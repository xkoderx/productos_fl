import 'dart:convert';

class Producto {
  Producto({
    required this.disp,
    required this.img,
    required this.nombre,
    required this.prec,
    this.id,
  });

  bool disp;
  String img;
  String nombre;
  double prec;
  String? id;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disp: json["disp"],
        img: json["img"],
        nombre: json["nombre"],
        prec: json["prec"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "disp": disp,
        "img": img,
        "nombre": nombre,
        "prec": prec,
      };
  Producto copia() =>
      Producto(disp: disp, img: img, nombre: nombre, prec: prec, id: id);
}
