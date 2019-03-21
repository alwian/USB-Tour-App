import 'package:flutter/material.dart';

class BuildingInformationFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Image.asset('assets/images/usb2.jpg'),
              /*flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset('assets/images/usb2.jpg'),
                    ),
                  ],
                ),
              ),*/
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                tabs: <Tab>[
                  Tab(text: 'About'),
                  Tab(text: 'Opening times'),
                  Tab(text: 'Contact'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Text('About text'),
              ),
              Container(
                child: Text('Opening times text'),
              ),
              Container(
                child: Text('Contact text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
