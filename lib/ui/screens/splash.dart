import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(child: CircularProgressIndicator()));
  }

  @override
  void initState() {
    super.initState();

    setup();
  }

  void setup() async {
    await Future.delayed(Duration(seconds: 5));
    // User user = await User.get();

    bool loggedIn = true;

    if (loggedIn)
      Navigator.pushReplacementNamed(context, '/user2',
      //  arguments: user
       );
    else
      Navigator.pushReplacementNamed(context, '/login');
  }
}
