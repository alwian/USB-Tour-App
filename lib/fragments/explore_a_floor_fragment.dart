/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

/// Allows users to view information about different floors in the Urban Sciences Building.
class ExploreAFloorFragment extends StatelessWidget {

  /// The number of floors to be displayed.
  final int _floorCount = 5;

  /// Returns a button which navigates to a [FloorFeatureListPage].
  Material _buildFloorButton(context, floorNo, height, fullWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Color(0xFFD5E3AF),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => FloorFeatureListPage(floorNo)  
            )
          );
        },
        child: Container(
          height: height,
          width: fullWidth ? screenWidth : screenWidth / 2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'FLOOR',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  floorNo.toString(),
                  style: TextStyle(
                    fontSize: 36.0
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  /// Returns how many rows of buttons shall be created.
  int _calcRowCount() {
    int rows = 0;
    for(int i = 0; i < _floorCount; i++) {
      if (i % 3 == 0 || i % 3 == 2) {
        rows++;
      }
    }
    return rows;
  }

  /// Returns a [List] of buttons.
  ///
  /// Buttons are created n a 2:1:2:1:... pattern.
  List<Widget> _buildFloorButtonList(context, rowHeight) {
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
      } else if (i % 3 == 0 || i % 3 == 2) {
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

  /// Builds the fragment.
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