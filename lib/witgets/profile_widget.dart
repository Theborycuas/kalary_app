import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  //LLAMAR A UNA FUNCIÓN ONCLIC DESDE OTRO WIDGET
  final VoidCallback onClicked;
  const ProfileWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
        child: Stack(
      children: [
        buildImage(),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(),
        ),
      ],
    ));
  }

  Widget buildImage() {
    final image = NetworkImage(
        'https://scontent.fuio1-1.fna.fbcdn.net/v/t39.30808-6/295890552_5389864964435233_5220293913403080335_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeENqneHox3izzLFIzE-HbBxAY01pY56ZKcBjTWljnpkp03oDaBtZOz7CoDj2Thmu4JbEThS0a5J8Y1xwlOHGtSS&_nc_ohc=tkAHOB-HOIsAX_APMjm&_nc_ht=scontent.fuio1-1.fna&oh=00_AT9pQLStcPF584c9EScLPxxn24LXCt6wS1dlssZfdbltiA&oe=62FB1644');
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
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
