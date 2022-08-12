import 'package:flutter/material.dart';

import '../../witgets/appbar_user_profile.dart';
import '../../witgets/button_widget_profile.dart';
import '../../witgets/numbersWidget.dart';
import '../../witgets/profile_widget.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // SizedBox(
          //   height: 5,
          // ),
          //LLAMAR A UNA FUNCIÓN ONCLIC DESDE OTRO WIDGET
          ProfileWidget(
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: buildUpgradeButton(),
          ),
          const SizedBox(
            height: 24,
          ),
          const NumbersWidget(),
          const SizedBox(
            height: 50,
          ),
          buildAtributes(text: "0996588558"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "24/10/1996"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "Hombre"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "Activo"),
        ],
      ),
    );
  }

  Widget buildName() {
    return Column(
      children: const [
        Text(
          'BORYS',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          'borys_jair@hotmail.com',
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget buildUpgradeButton() {
    return ButtonWidget(text: 'COPIAR y PEGAR', onClicked: () {});
  }

  Widget buildAtributes({required String text}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
