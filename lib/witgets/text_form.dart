import 'package:flutter/material.dart';

class TextFormGlobalScreen extends StatelessWidget {
  const TextFormGlobalScreen(
      {Key? key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obscure,
      required this.icon})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 7)
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(icon),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: const TextStyle(
              height: 1,
            )),
      ),
    );
  }
}
