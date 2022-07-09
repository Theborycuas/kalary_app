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
          height: 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            children: [
              ///GOOGLE
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ]),
                  child: SvgPicture.asset(
                    'assets/img/google.svg',
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),

              ///FACEBOOK
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ]),
                    child: Image.asset(
                      'assets/img/facebookpng.png',
                      width: 50,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
