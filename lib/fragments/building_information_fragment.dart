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
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.grey[400],
                      child: ListView(
                        children: <Widget>[
                          Text(
                            '\n\nAbout title',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('\nAbout text'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.grey[400],
                      child: ListView(
                        children: <Widget>[
                          Text(
                            '\n\nReception opening hours',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('\nMonday to Friday, 9:00 - 17:00'),
                          Text(
                            '\n\nBuilding opening hours',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('\nMonday to Friday, 9:00 - 22:00'),
                          Text('Saturday and Sunday, 9:00 - 21:00'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.grey[400],
                      child: ListView(
                        children: <Widget>[
                          Text(
                            '\n\nAddress',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('\nSchool of Computing\nUrban Sciences Building\nNewcastle University\n1 Science Square\nNewcastle Helix\nNewcastle upon Tyne\nNE4 5TG'),
                          Text(
                            '\n\nEmail and phone',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('\nTelephone: +44 (0)191 208 7972\nFax: +44 (0)191 208 8232\nGeneral email: computing@ncl.ac.uk\nStudent admissions email: cs.admissions@newcastle.ac.uk'),
                        ],
                      ),
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
