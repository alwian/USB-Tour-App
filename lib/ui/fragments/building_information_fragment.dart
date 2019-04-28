import 'package:flutter/material.dart';


/// A fragment containing useful information about the Urban Sciences Building.
class BuildingInformationFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/building_information/usb2.jpg'),
        DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              // Setup TabBar
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                tabs: <Tab>[
                  Tab(text: 'About', key: Key('about_tab'),),
                  Tab(text: 'Opening times', key: Key('opening_times_tab'),),
                  Tab(text: 'Contact', key: Key('contact_tab'),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 289,
                child: TabBarView(
                  children: <Widget>[
                    // Building info.
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey[400],
                      child: ListView(
                        children: <Widget>[
                          Text(
                            '\n\nAbout the building',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '\nDescribed as a living laboratory, the Urban Sciences Building is home to Newcastle Universitiy\'s School of Computing and several world-leading research facilities, such as the National Green Infrastructure Facility and the Digital Economy Research Centre. Projects include the Urban Observatory, Smart Grid and Building as a Power Plant. With a total development cost of £58 million and a size of 12,800m\u00B2, the USB is the recipient of multiple awards for best practice in sustainability, including the BREEAM Innovation Credit.',
                            style: TextStyle(height: 1.25),
                          ),
                        ],
                      ),
                    ),
                    // Opening hours.
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
                    // Contacts.
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
