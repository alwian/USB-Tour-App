/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/fragments/find_a_room_fragment.dart';
import 'package:csc2022_app/fragments/explore_a_floor_fragment.dart';
import 'package:csc2022_app/fragments/building_information_fragment.dart';
import 'package:csc2022_app/fragments/urban_observatory_fragment.dart';

/// Is used to collect data used to created a [ListTile].
class _DrawerTile {

  /// The page the [ListTile] will lead to.
  String tileTitle;

  /// The [IconData] for the [Icon] to be displayed on the [ListTile].
  IconData icon;

  /// The title for the [AppBar] on the page the [ListTile] will lead to.
  String appbarTitle;

  /// Defines a [_DrawerTile].
  _DrawerTile(this.tileTitle, this.icon, this.appbarTitle);
}

///  The main shell used to house different sections of the app.
class HomePage extends StatefulWidget {

  /// The [_DrawerTiles] to display in the [Drawer].
  final _drawerTiles = [
    _DrawerTile('Find a room', Icons.navigation, 'Find a room'),
    _DrawerTile('Explore a floor', Icons.map, 'Explore'),
    _DrawerTile('Building information', Icons.info, 'Building information'),
    _DrawerTile('Urban Observatory', Icons.computer, 'Urban Observatory'),
  ];

  /// Returns a [State] of a [HomePage].
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

/// A [State] of a [HomePage].
class _HomePageState extends State<HomePage> {

  /// The section of the app currently being displayed.
  int _selectedFragmentIndex = 0;

  /// Loads the app section that needs to be displayed.
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

  /// Loads a new [_HomePageState] with the correct app section displayed.
  _onItemPressed(index) {
    setState(() {
      _selectedFragmentIndex = index;
    });
    Navigator.pop(context);
  }

  /// Builds the [ListTile]s to be displayed in the [Drawer].
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

  /// Builds this [_HomePageState].
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