import 'package:flutter/material.dart';

class ExploreAFloorFragment extends StatelessWidget {
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
                  children: <Widget>[
                    RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Color(0xFFDC817E),
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                            ),
                          ),
                          Text(
                            'Floor',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            ),
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Color(0xFFE59D62),
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                            ),
                          ),
                          Text(
                            'Floor',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            ),
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Color(0xFFE2DE83),
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                            ),
                          ),
                          Text(
                            'Floor',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            ),
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Color(0xFFB4D47F),
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                            ),
                          ),
                          Text(
                            'Floor',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}