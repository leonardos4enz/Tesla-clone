import 'package:flutter/material.dart';
import 'package:saenz/data/explore_data.dart';
import 'package:saenz/screens/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int value = 0;

  _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //print(prefs.getInt('firstTime'));
      value = (prefs.getInt('firstTime') ?? 1);
      if (value == 1) {
        //print(value);
        _changeFirstTime();
      }
    });
  }

  _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('firstTime', 0);
    //print(prefs.getInt('firstTime'));
  }

  void _changeFirstTime() {
    setState(() {
      value = 0;
    });
    _saveValue();
  }

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        body: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              espacio(24),
              Row(
                children: [
                  const Text(
                    "Explorar",
                    style: TextStyle(
                      fontFamily: 'SanFranciscoPro',
                      letterSpacing: 4,
                      fontSize: 25,
                      color: Color.fromARGB(200, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
                      // if (kDebugMode) {
                      //   print("Picandole a la foto");
                      // }
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://pbs.twimg.com/profile_images/1614490716859777024/ZBqkiV2z_400x400.jpg"),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            color: const Color.fromARGB(255, 12, 12, 12),
                            width: 1.0,
                            style: BorderStyle.solid,
                          )),
                    ),
                  ),
                ],
              ),
              espacio(30),
              Column(children: _cardsList)
            ],
          ),
        ));
  }
}

List<Widget> get _cardsList {
  List<Widget> listStack = [];
  for (var tesla in data) {
    listStack.add(Column(
      children: [
        Stack(children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              minWidth: 0,
              maxHeight: 500,
              minHeight: 0,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(tesla['url']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          containerGradientBottom(),
          containerGradientTop(),
          containerText(tesla['title'], tesla['description'])
        ]),
        espacio(30)
      ],
    ));
  }
  return listStack;
}

Widget containerText(String title, String description) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 500,
      minWidth: 0,
      maxHeight: 500,
      minHeight: 0,
    ),
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'SanFranciscoPro', color: Color.fromARGB(255, 214, 214, 214), fontSize: 18),
            ),
            espacio(5),
            Text(description,
                style: const TextStyle(
                    fontFamily: 'SanFranciscoPro', color: Color.fromARGB(255, 214, 214, 214), fontSize: 13)),
          ],
        ),
      ),
    ),
  );
}

Widget containerGradientTop() {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 500,
      minWidth: 0,
      maxHeight: 500,
      minHeight: 0,
    ),
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: AlignmentDirectional.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(47, 0, 0, 0)],
              stops: [0.6, 1.0],
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

Widget containerGradientBottom() {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 500,
      minWidth: 0,
      maxHeight: 500,
      minHeight: 0,
    ),
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(207, 0, 0, 0)],
              stops: [0.6, 1.0],
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

Widget espacio(double espacio) {
  return SizedBox(
    height: espacio,
  );
}
