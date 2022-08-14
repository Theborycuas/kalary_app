import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidget extends StatelessWidget {
  //LLAMAR A UNA FUNCIÓN ONCLIC DESDE OTRO WIDGET
  final VoidCallback onClicked;
  final DocumentSnapshot userSnapshot;
  const ProfileWidget({
    Key? key,
    required this.onClicked,
    required this.userSnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
        child: Stack(
      children: [
        buildImage(userSnapshot),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(),
        ),
      ],
    ));
  }

  Widget buildImage(DocumentSnapshot userUnapshot) {
    final data = userSnapshot.data() as Map<String, dynamic>;

    final photoUser = NetworkImage(data['photo']);
    final photowithoutUser = NetworkImage(
        'https://image.shutterstock.com/image-vector/user-avatar-icon-button-profile-260nw-1517550290.jpg');

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
