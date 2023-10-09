import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _buildBoxDecoration(),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          // child: FadeInImage(
          //   placeholder: const AssetImage('assets/jar-loading.gif'),
          //   imageErrorBuilder: (BuildContext context, Object obj, stackTrace) {
          //     return const Image(
          //       image: AssetImage('assets/no-image.png'),
          //       fit: BoxFit.cover,
          //     );
          //   },
          //   image: NetworkImage(url),
          //   fit: BoxFit.cover,
          // ),
          child: getImage(url!),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      );
  Widget getImage(String? img) {
    if (img == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    }
    if (img.startsWith('http')) {
      return FadeInImage(
        image: NetworkImage(url!),
        placeholder: const AssetImage('assets/jar-loading.gif'),
      );
    }
    return Image.file(
      File(img),
      errorBuilder: (BuildContext context, Object obj, stackTrace) {
        return const Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
        );
      },
      fit: BoxFit.cover,
    );
  }
}
