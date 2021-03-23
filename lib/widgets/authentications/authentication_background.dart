import 'dart:async';
import 'package:flutter/cupertino.dart';

class AuthenticationBackground extends StatefulWidget {
  @override
  _AuthenticationBackgroundState createState() =>
      _AuthenticationBackgroundState();
}

class _AuthenticationBackgroundState
    extends State<AuthenticationBackground> {
  late Timer animatedCounter;
  late StreamController<bool> animatedTicker;
  late bool _animatedTicker;

  @override
  void initState() {
    this.animatedTicker = StreamController<bool>();
    this._animatedTicker = true;
    this.animatedTicker.add(this._animatedTicker);
    this.animatedCounter = Timer.periodic(Duration(milliseconds: 1500), (_) {
      this._animatedTicker = !this._animatedTicker;
      this.animatedTicker.add(this._animatedTicker);
    });

    super.initState();
  }

  @override
  void dispose() {
    this.animatedTicker.close();
    this.animatedCounter.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(
          child: StreamBuilder(
            stream: animatedTicker.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    top: snapshot.data ? (MediaQuery.of(context).size.height / 7) : (MediaQuery.of(context).size.height / 7)-5,
                    right: MediaQuery.of(context).size.width / 1.75,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.easeIn,
                    child: Container(
                      child: Image.asset('lib/statics/login_man.png'),
                    ),
                  ),
                  AnimatedPositioned(
                    top: snapshot.data ? (MediaQuery.of(context).size.height / 7) : (MediaQuery.of(context).size.height / 7)-5,
                    left: MediaQuery.of(context).size.width / 1.75,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.easeIn,
                    child: Container(
                      child: Image.asset('lib/statics/login_girl.png'),
                    ),
                  ),
                  AnimatedPositioned(
                    top: snapshot.data
                        ? MediaQuery.of(context).size.height / 7
                        : (MediaQuery.of(context).size.height / 7)-10,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.easeIn,
                    child: Container(
                      child: Image.asset('lib/statics/login_old_man.png'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
