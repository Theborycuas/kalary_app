import 'package:flutter/material.dart';

class TextFormGlobalScreen extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final IconData icon;
  final TextCapitalization textCap;

  const TextFormGlobalScreen(
      {Key? key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obscure,
      required this.icon,
      required this.textCap})
      : super(key: key);

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
        onChanged: ((value) {
          print(value);
        }),
        controller: controller,
        keyboardType: textInputType,
        textCapitalization: textCap,
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
