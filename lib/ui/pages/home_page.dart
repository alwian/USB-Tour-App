/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:charcode/charcode.dart';
import 'package:csc2022_app/ui/fragments/find_a_room_fragment.dart';
import 'package:csc2022_app/ui/fragments/explore_a_floor_fragment.dart';
import 'package:csc2022_app/ui/fragments/building_information_fragment.dart';
import 'package:csc2022_app/ui/fragments/urban_observatory_fragment.dart';
import 'package:csc2022_app/ui/fragments/building_map_fragment.dart';
import 'package:csc2022_app/ui/pages/settings_page.dart';

/// An appbar action.
class _Action {

  /// The title of the the [_Action].
  String title;

  /// The [IconData] to represent the [_Action].
  IconData icon;

  /// Defines an _Action.
  _Action(this.title, this.icon);
}

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

  /// The appbar actions to display in the appbar.
  final List<_Action> _actions = <_Action>[
    _Action('Settings', Icons.settings),
  ];

  /// The [_DrawerTiles] to display in the [Drawer].
  final List<_DrawerTile> _drawerTiles = <_DrawerTile>[
    _DrawerTile('Find a room', Icons.navigation, 'Find a room'),
    _DrawerTile('Explore a floor', Icons.map, 'Explore'),
    _DrawerTile('Building information', Icons.info, 'Building information'),
    _DrawerTile('Urban Observatory', Icons.computer, 'Urban Observatory'),
    _DrawerTile('Map', Icons.explore, 'Map'),
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


  /// Handle actions being selected.
  void _actionSelected(_Action action) {
    switch(action.title) {
      case 'Settings':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SettingsPage())
        );
    }
  }

  /// Loads the app section that needs to be displayed.
  Widget _getSelectedFragment() {
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
        return BuildingMapFragment();
      default:
        return Text('Error');
    }
  }

  /// Loads a new [_HomePageState] with the correct app section displayed.
  void _onItemPressed(int index) {
    // Update the state to show the correct fragment.
    setState(() {
      _selectedFragmentIndex = index;
    });
    Navigator.pop(context);
  }

  /// Builds the [ListTile]s to be displayed in the [Drawer].
  List<Widget> _buildDrawerTiles() {
    List<Widget> tiles = <Widget>[];
    // Create a drawer entry for each app section.
    for(int i = 0; i < widget._drawerTiles.length; i++) {
      tiles.add(
          ListTile(
            // Key used for testing.
            key: Key(widget._drawerTiles[i].tileTitle.toLowerCase().split(' ').join('_') + '_tile'),
            title: Text(widget._drawerTiles[i].tileTitle),
            leading: Icon(widget._drawerTiles[i].icon),
            selected: _selectedFragmentIndex == i,
            onTap: () => _onItemPressed(i),
          )
      );
    }

    // Add about tile.
    tiles.add(Divider(height: 10.0,color: Colors.black,));
    tiles.add(
      AboutListTile(
        icon: Icon(Icons.copyright),
        applicationName: 'USB Tour',
        applicationVersion: '1.0.0',
      )
    );

    return tiles;
  }

  /// Builds this [_HomePageState].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title of the current section.
        title: Text(widget._drawerTiles[_selectedFragmentIndex].appbarTitle),
        actions: <Widget>[
          PopupMenuButton<_Action>(
            onSelected: _actionSelected,
            itemBuilder: (BuildContext context) {
              return widget._actions.map((_Action action) {
                return PopupMenuItem<_Action>(
                  child: Text(action.title),
                  value: action,
                );
              }).toList();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              // University logo.
              child: Image.asset('assets/images/ncl_logo.jpg'),
            ),
            Column(
              // List of tiles.
              children: _buildDrawerTiles()
            ),
          ],
        ),
      ),
      body: _getSelectedFragment(),
    );
  }
}