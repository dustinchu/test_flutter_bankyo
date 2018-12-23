import 'package:flutter/material.dart';

class makeBotton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(0, 0, 0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
