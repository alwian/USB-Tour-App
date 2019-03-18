import 'package:flutter/material.dart';

class DisableableButtons extends StatefulWidget {
  @override
  _DisableableButtonsState createState() => _DisableableButtonsState();
}

class _DisableableButtonsState extends State<DisableableButtons> {
  bool _aboutIsPressed = false;
  bool _openIsPressed = false;
  bool _contactIsPressed = false;

  void _pressButton(String button) {
    setState(() {
      if (button == 'about') {
        _aboutIsPressed = true;
        _openIsPressed = false;
        _contactIsPressed = false;
      } else if (button == 'open') {
        _openIsPressed = true;
        _aboutIsPressed = false;
        _contactIsPressed = false;
      } else if (button == 'contact') {
        _contactIsPressed = true;
        _aboutIsPressed = false;
        _openIsPressed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            child: Text(
              'About',
            ),
            onPressed: () => _pressButton('about'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: _aboutIsPressed ? Colors.lightGreen[200] : Colors.white,
            disabledTextColor: Colors.black,
            textColor: Colors.black,
            splashColor: Colors.lightGreen[200],
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'Opening times',
            ),
            onPressed: () => _pressButton('open'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: _openIsPressed ? Colors.lightGreen[200] : Colors.white,
            disabledTextColor: Colors.black,
            textColor: Colors.black,
            splashColor: Colors.lightGreen[200],
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'Contact',
            ),
            onPressed: () => _pressButton('contact'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: _contactIsPressed ? Colors.lightGreen[200] : Colors.white,
            disabledTextColor: Colors.black,
            textColor: Colors.black,
            splashColor: Colors.lightGreen[200],
          ),
        )
      ],
    );
  }
}

class BuildingInformationFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
            'assets/images/usb2.jpg'
        ),
        DisableableButtons(),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              color: Colors.grey,
              child: Text(
                'Sample text',
              ),
            ),
          ),
        )
      ],
    );
  }
}