import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

class ExploreAFloorFragment extends StatelessWidget {
  final int _floorCount = 5;

  _buildFloorButton(context, floorNo, fullWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: fullWidth ? screenWidth : screenWidth / 2,
      child: Text('Floor ' + floorNo.toString()),
    );
  }

  _buildFloorButtonList(context) {
    var rows = <Widget>[];
    for(int i = 0; i < _floorCount; i++) {
      if(i % 3 == 0 && i + 1 < _floorCount) {
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