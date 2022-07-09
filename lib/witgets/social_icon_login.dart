import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIconLoginScreen extends StatelessWidget {
  const SocialIconLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            'O Inicia seción con',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/google.svg',
                height: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}
