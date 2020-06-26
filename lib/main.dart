import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
AudioPlayer audioPlayer = AudioPlayer();

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation anima;
  double ScaleSize = 0;

  void play(){
    final player = AudioCache();
    player.play('play.mpeg');
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    anima = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(reverse: true);

    animationController.addListener(() {
      setState(() {
        ScaleSize = 0.9 + 0.1 * animationController.value;
      });
    });
    play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            child: Container(
                color: Colors.blue[300],
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: TypewriterAnimatedTextKit(
                        text: ['Learning Curve - Giggles'],
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FlareActor(
                        'images/hello.flr',
                        fit: BoxFit.contain,
                        animation: 'play',
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
