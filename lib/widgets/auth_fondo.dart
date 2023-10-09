import 'package:flutter/material.dart';

class AuthFondo extends StatelessWidget {
  const AuthFondo({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.grey[350],
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [_PBox(), _headIcon(), child],
      ),
    );
  }
}

class _headIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _PBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.purple,
      decoration: _BoxDec(),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: _bubble(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: _bubble(),
          ),
          Positioned(
            top: -50,
            right: -20,
            child: _bubble(),
          ),
          Positioned(
            bottom: -50,
            left: 10,
            child: _bubble(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: _bubble(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _BoxDec() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ],
        ),
      );
}

class _bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
