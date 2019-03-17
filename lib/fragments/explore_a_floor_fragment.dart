import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

class ExploreAFloorFragment extends StatelessWidget {
  final int _floorCount = 5;

  _buildFloorButton(context, floorNo, height, fullWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Color(0xFFD5E3AF),
        onTap: () => {},
        child: Container(
          height: height,
          width: fullWidth ? screenWidth : screenWidth / 2,
          child: Text('Floor ' + floorNo.toString()),
        ),
      ),
    );
  }

  _calcRowCount() {
    int rows = 0;
    for(int i = 0; i < _floorCount; i++) {
      if (i % 3 == 0 || i % 3 == 2) {
        rows++;
      }
    }
    return rows;
  }

  _buildFloorButtonList(context, rowHeight) {
    var rows = <Widget>[];
    for(int i = 0; i < _floorCount; i++) {
      if(i % 3 == 0 && i + 1 < _floorCount) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, rowHeight, false),
              _buildFloorButton(context, i + 1, rowHeight, false),
            ],
          ),
        );
      } else if (i % 3 == 0) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, rowHeight, true),
            ],
          ),
        );
      } else if (i % 3 == 2) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, i, rowHeight, true),
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
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: _buildFloorButtonList(
                      context,
                      constraints.maxHeight / _calcRowCount()
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }
}