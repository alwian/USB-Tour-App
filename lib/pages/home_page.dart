import 'package:flutter/material.dart';
import 'package:csc2022_app/fragments/find_a_room_fragment.dart';
import 'package:csc2022_app/fragments/explore_a_floor_fragment.dart';
import 'package:csc2022_app/fragments/building_information_fragment.dart';
import 'package:csc2022_app/fragments/urban_observatory_fragment.dart';

class _DrawerTile {
  String tileTitle;
  IconData icon;
  String appbarTitle;

  _DrawerTile(this.tileTitle, this.icon, this.appbarTitle);
}

class HomePage extends StatefulWidget {
  final _drawerTiles = [
    _DrawerTile('Find a room', Icons.navigation, 'Find a room'),
    _DrawerTile('Explore a floor', Icons.map, 'Explore'),
    _DrawerTile('Building information', Icons.info, 'Building information'),
    _DrawerTile('Urban Observatory', Icons.computer, 'Urban Observatory'),
  ];

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

  _buildDrawerTiles() {
    var tiles = <Widget>[];
    for(int i = 0; i < widget._drawerTiles.length; i++) {
      tiles.add(
          ListTile(
            title: Text(widget._drawerTiles[i].tileTitle),
            leading: Icon(widget._drawerTiles[i].icon),
            selected: _selectedFragmentIndex == i,
            onTap: () => _onItemPressed(i),
          )
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._drawerTiles[_selectedFragmentIndex].appbarTitle),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/images/ncl_logo.jpg'),
            ),
            Column(
              children: _buildDrawerTiles()
            ),
          ],
        ),
      ),
      body: _getSelectedFragment(),
    );
  }
}