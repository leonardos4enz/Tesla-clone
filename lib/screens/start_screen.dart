import 'package:flutter/material.dart';
import 'package:saenz/screens/login_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // bool get wantKeepAlive => true;
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/videos/TeslaApp7.mp4');

  ChewieController? chewieController;

  double videoContainerRatio = 0.5;

  @override
  void initState() {
    chewieController = ChewieController(
      allowMuting: true,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
      allowFullScreen: true,
      maxScale: 5,
      controlsSafeAreaMinimum: EdgeInsets.zero,
    );
    chewieController?.setVolume(0);

    chewieController?.videoPlayerController.play();
    super.initState();
  }

  bool chewiePlaying = true;
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 1000)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("");
          } else {
            return Stack(
              children: <Widget>[
                Transform.scale(
                  scale: getScale() + 0.15,
                  child: SizedBox(
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black12,
                ),
                superCuerpo(),

                //Text(getScale().toString()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget superCuerpo() {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 140),
            child: Text(
              "TEZLA",
              style: TextStyle(color: Colors.white, fontFamily: 'Tesla', fontSize: 20, letterSpacing: 10.0),
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            height: 50,
            child: MaterialButton(
                splashColor: Colors.transparent,
                color: const Color.fromARGB(255, 61, 123, 255),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                onPressed: () async {
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    chewiePlaying = false;
                    chewieController!.videoPlayerController.pause();
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    chewieController?.videoPlayerController.play();
                    chewiePlaying = true;
                  });
                },
                child: const Text(
                  "Registrarse",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SanFranciscoPro'),
                )),
          ),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Crear cuenta",
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SanFranciscoPro'),
              )),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  double getScale() {
    double alturaPantalla = MediaQuery.of(context).size.height;
    double anchoPantalla = MediaQuery.of(context).size.width;
    double alturaVideo = chewieController!.videoPlayerController.value.size.height;
    double anchoVideo = chewieController!.videoPlayerController.value.size.width;
    double alturaPost = (alturaVideo * anchoPantalla) / anchoVideo;
    double escala = alturaPantalla / alturaPost;

    return escala;
  }
}
