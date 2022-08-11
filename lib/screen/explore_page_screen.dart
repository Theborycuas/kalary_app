import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:kalary_app/data/explore_json.dart';

import '../data/icons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List itemTemp = [];
  int itemLength = 0;

  //INICIALIZAMOS CON EL NÚMERO DE ITEM DE LA LISTA EN explore_json
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      itemTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          //NUMERO DE ITEM DESDE EL JSON explore_json
          totalNum: itemLength,
          maxWidth: size.width,
          maxHeight: size.height * 0.75,
          minWidth: size.width * 0.75,
          minHeight: size.height * 0.6,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(itemTemp[index]['img']),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0)
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.72,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        itemTemp[index]['name'],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        itemTemp[index]['age'],
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Recien Conectado',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: List.generate(
                                        itemTemp[index]['likes'].length,
                                        (indexLikes) {
                                      if (indexLikes == 0) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white
                                                    .withOpacity(0.4),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 3,
                                                    top: 3),
                                                child: Text(
                                                  itemTemp[index]['likes']
                                                      [indexLikes],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color:
                                                Colors.white.withOpacity(0.2),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 3,
                                                  top: 3),
                                              child: Text(
                                                itemTemp[index]['likes']
                                                    [indexLikes],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: size.width * 0.2,
                              child: Center(
                                  child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 28,
                              )),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

//ICONOS DEL FOOTER
  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(item_icons.length, (index) {
              return Container(
                width: item_icons[index]['size'],
                height: item_icons[index]['size'],
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                child: Center(
                  child: SvgPicture.asset(
                    item_icons[index]['icon'],
                    width: item_icons[index]['icon_size'],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
