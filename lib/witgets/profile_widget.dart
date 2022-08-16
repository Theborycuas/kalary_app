import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidget extends StatelessWidget {
  //LLAMAR A UNA FUNCIÓN ONCLIC DESDE OTRO WIDGET
  final VoidCallback onClicked;
  const ProfileWidget({
    Key? key,
    required this.onClicked,
    this.data,
  }) : super(key: key);

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
        child: Stack(
      children: [
        buildImage(data),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(),
        ),
      ],
    ));
  }

  Widget buildImage(Map<String, dynamic>? data) {
    final photoUser = NetworkImage(data!['photo']);
    final photowithoutUser = NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/klary-bd657.appspot.com/o/WithOutUser.png?alt=media&token=29347eaa-61da-4f9b-849d-d5e4aef346fb');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: data['photo'] != 'null' ? photoUser : photowithoutUser,
          fit: BoxFit.cover,
          width: 130,
          height: 130,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }

//ICONO DE EDITAR
  Widget buildEditIcon() => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: Color.fromARGB(255, 42, 147, 233),
        all: 8,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

//CIRCULO DEL ICONO DE EDITAR
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      InkWell(
        onTap: () {
          print('object');
        },
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child,
          ),
        ),
      );
}
