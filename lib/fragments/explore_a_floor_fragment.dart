import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/floor_feature_list_page.dart';

class _FloorButton {
  int number;
  Color color;

  _FloorButton(this.number, this.color);
}

class ExploreAFloorFragment extends StatelessWidget {
  final _floorButtons = [
    _FloorButton(1, Color(0xFFDC817E)),
    _FloorButton(2, Color(0xFFE59D62)),
    _FloorButton(3, Color(0xFFE2DE83)),
    _FloorButton(4, Color(0xFFB4D47F)),
  ];

  _buildFloorButtons(context) {
    var buttons = <Widget>[];
    for(int i = 0; i < _floorButtons.length; i++) {
      buttons.add(
        RawMaterialButton(
          shape: CircleBorder(),
          fillColor: _floorButtons[i].color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Floor',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                ),
              ),
              Text(
                _floorButtons[i].number.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0
                ),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => FloorFeatureListPage(_floorButtons[i].number)));
          },
        ),
      );
    }
    return buttons;
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
            child: Center(
              child: Container(
                width: (MediaQuery.of(context).size.width / 3) * 2,
                child: GridView.count(
                    crossAxisCount: 2,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20.0),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    children: _buildFloorButtons(context)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}