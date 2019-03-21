import 'package:flutter/material.dart';

class BuildingInformationFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/usb2.jpg'),
        DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                tabs: <Tab>[
                  Tab(text: 'About'),
                  Tab(text: 'Opening times'),
                  Tab(text: 'Contact'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 289,
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      color: Colors.grey[400],
                      child: Text('About text'),
                    ),
                    Container(
                      color: Colors.grey[400],
                      child: Text('Opening times text'),
                    ),
                    Container(
                      color: Colors.grey[400],
                      child: Text('Contact text'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
