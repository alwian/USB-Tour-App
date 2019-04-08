/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

/// Allows users to view information about different floors in the Urban Sciences Building.
class ExploreAFloorFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExploreAFragmentState();
  }
}

class _ExploreAFragmentState extends State<ExploreAFloorFragment> {

  List<int> _floors;

  @override
  void initState() {
    super.initState();
    _loadFloors();
  }

  Future<void> _loadFloors() async {
    _floors = await ExploreAFloorManager.getFloors();
    setState(() {});
  }
  /// Returns a button which navigates to a [FloorFeatureListPage].
  Material _buildFloorButton(context, floorNo, height, fullWidth) {
    // Get screen width.
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
          // Give button the correct width.
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
    for(int i = 0; i < _floors.length; i++) {
      // A new row is required if conditions are true.
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
    for(int i = 0; i < _floors.length; i++) {
      // If on a 2 wide row.
      if(i % 3 == 0 && i + 1 < _floors.length) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, _floors[i], rowHeight, false),
              _buildFloorButton(context, _floors[i] + 1, rowHeight, false),
            ],
          ),
        );
        // If on a 1 wide row or only 1 item left.
      } else if (i % 3 == 0 || i % 3 == 2) {
        rows.add(
          Row(
            children: <Widget>[
              _buildFloorButton(context, _floors[i], rowHeight, true),
            ],
          ),
        );
      }
    }
    return rows;
  }

  /// Builds the state.
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
              child: _floors == null ? CircularProgressIndicator() : LayoutBuilder(
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