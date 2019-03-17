import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

class _FloorButton {
  int number;
  Color color;

  _FloorButton(this.number, this.color);
}

class ExploreAFloorFragment extends StatelessWidget {
  final _floorButtons = [
    _FloorButton(0, Color(0xFFB4D47F)),
    _FloorButton(1, Color(0xFFDC817E)),
    _FloorButton(2, Color(0xFFE59D62)),
    _FloorButton(3, Color(0xFFE2DE83)),
    _FloorButton(4, Color(0xFFB4D47F)),
  ];

  _buildFloorButton(context, floorNo, fullWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: fullWidth ? screenWidth : screenWidth / 2,
      child: Text('Floor ' + floorNo.toString()),
    );
  }

  _buildFloorButtonList(context) {
    var rows = <Widget>[];
    for(int i = 0; i < _floorButtons.length; i++) {
      if(i % 3 == 0 && i + 1 < _floorButtons.length) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, false),
              _buildFloorButton(context, i + 1, false),
            ],
          ),
        );
      } else if (i % 3 == 0) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, true),
            ],
          ),
        );
      } else if (i % 3 == 2) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, true),
            ],
          ),
        );
      }
    }
    return rows;
  }
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Color(0xFF333333)
      ),
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/usb.jpg'),
          Expanded(
            child: Column(
              children: _buildFloorButtonList(context),
            ),
          )
        ],
      ),
    );
  }
}