import 'package:flutter/material.dart';
import 'package:saenz/data/menu_data.dart';
import 'package:saenz/screens/explore_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:saenz/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> fruits = ['Manzana', 'Banana', 'Cereza', 'Durazno', 'Frambuesa'];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int value = 0;

  // _loadValue() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     //print(prefs.getInt('firstTime'));
  //     value = (prefs.getInt('firstTime') ?? 1);
  //   });
  // }

  _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('firstTime', 1);
    //print(prefs.getInt('firstTime'));
  }

  void _resetFirstTime() {
    setState(() {
      value = 1;
    });
    _saveValue();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadValue();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 20,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          espacio(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image:
                          NetworkImage("https://pbs.twimg.com/profile_images/1614490716859777024/ZBqkiV2z_400x400.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 12, 12, 12),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 9,
                        right: 9,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 59, 59, 59),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(1.0),
                          child: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 133, 133, 133),
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          espacio(20),
          const Text(
            "Leonardo S??enz",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'SanFranciscoPro',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          espacio(20),
          SizedBox(
            height: 350,
            child: ListView.builder(
              shrinkWrap: true, // agregar esta l??nea
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    if (menuData[index]['id'] != 5) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => menuData[index]['route']));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              '??Est?? seguro?',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Perder?? sus ajustes y todos los datos almacenados.',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            backgroundColor: const Color.fromARGB(255, 53, 53, 53),
                            contentPadding: const EdgeInsets.only(left: 20, top: 20),
                            //buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'CANCELAR',
                                  style: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'CERRAR SESI??N',
                                  style: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                                ),
                                onPressed: () {
                                  _resetFirstTime();
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => const StartScreen()));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  leading: Icon(
                    menuData[index]['icon'],
                    color: const Color.fromARGB(255, 180, 180, 180),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color.fromARGB(255, 75, 75, 75),
                  ),
                  title: Text(
                    menuData[index]['title'],
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              },
            ),
          ),
          espacio(20),
          const Text(
            "4.17.5-1576 - 625ddcb31f",
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'SanFranciscoPro',
                letterSpacing: 1.2),
          ),
          const Text(
            "leonardorsaenz@gmail.com",
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'SanFranciscoPro',
                letterSpacing: 1.2),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Agradecimientos",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 112, 112, 112),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'SanFranciscoPro',
                    letterSpacing: 1.2,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // ignore: avoid_print
                      print("Agradecimientos");
                    },
                ),
                const TextSpan(
                  text: " - ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 112, 112, 112),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'SanFranciscoPro',
                    letterSpacing: 1.2,
                  ),
                ),
                TextSpan(
                  text: "Aviso de privacidad",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 112, 112, 112),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'SanFranciscoPro',
                    letterSpacing: 1.2,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // ignore: avoid_print
                      print("Aviso de privacidad");
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
//Hecho por Leo
