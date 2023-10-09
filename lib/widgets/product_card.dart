import 'package:flutter/material.dart';
import 'package:productos_app/models/productos.dart';

class ProductCard extends StatelessWidget {
  final Producto producto;

  const ProductCard({super.key, required this.producto});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        width: double.infinity,
        height: size.height / 2.3,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _fondo(
              url: producto.img,
            ),
            _productoDetalle(
              title: producto.nombre,
              subtitle: producto.id!,
            ),
            _precio(
              precio: producto.prec,
            ),
            if (!producto.disp) _estado(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ],
      );
}

class _fondo extends StatelessWidget {
  final String url;
  const _fondo({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          imageErrorBuilder: (BuildContext context, Object obj, stackTrace) {
            return const Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            );
          },
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _precio extends StatelessWidget {
  final double precio;

  const _precio({required this.precio});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$ $precio',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class _estado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Agotado",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _productoDetalle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _productoDetalle({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontStyle: FontStyle.normal),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
