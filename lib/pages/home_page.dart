import 'package:flutter/material.dart';
import 'package:csc2022_app/fragments/find_a_room_fragment.dart';
import 'package:csc2022_app/fragments/explore_a_floor_fragment.dart';
import 'package:csc2022_app/fragments/building_information_fragment.dart';
import 'package:csc2022_app/fragments/urban_observatory_fragment.dart';
import 'package:csc2022_app/fragments/history_fragment.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedFragmentIndex = 0;

  _getSelectedFragment() {
    switch(_selectedFragmentIndex) {
      case 0:
        return FindARoomFragment();
      case 1:
        return ExploreAFloorFragment();
      case 2:
        return BuildingInformationFragment();
      case 3:
        return UrbanObservatoryFragment();
      case 4:
        return HistoryFragment();
      default:
        return Text('Error');
    }
  }

  _onItemPressed(index) {
    setState(() {
      _selectedFragmentIndex = index;
    });
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project App'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/images/ncl_logo.jpg'),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.navigation),
                  title: Text('Find a room'),
                  selected: _selectedFragmentIndex == 0,
                  onTap: () => _onItemPressed(0),
                ),
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Explore a floor'),
                  selected: _selectedFragmentIndex == 1,
                  onTap: () => _onItemPressed(1),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Building information'),
                  selected: _selectedFragmentIndex == 2,
                  onTap: () => _onItemPressed(2),
                ),
                ListTile(
                  leading: Icon(Icons.computer),
                  title: Text('Urban Observatory'),
                  selected: _selectedFragmentIndex == 3,
                  onTap: () => _onItemPressed(3),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                  selected: _selectedFragmentIndex == 4,
                  onTap: () => _onItemPressed(4),
                )
              ],
            ),
          ],
        ),
      ),
      body: _getSelectedFragment(),
    );
  }
}