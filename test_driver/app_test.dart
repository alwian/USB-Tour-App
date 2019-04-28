/// Author: Alex Anderson
/// Student No: 17045390

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

/// Main test method.
void main() {
  // Driver which uses the app.
  FlutterDriver driver;

  // Button to open navigation drawer.
  final SerializableFinder drawerButtonFinder =
      find.byTooltip('Open navigation menu');

  // Executes before all tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Tests for the navigation drawer.
  group('Drawer:', () {
    // Test the 'Explore a floor' tile.
    test('Explore a floor', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('explore_a_floor_tile'));
      await driver.waitFor(find.byType('ExploreAFloorFragment'));
    });

    // Test the 'Building information' tile.
    test('Building information', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('building_information_tile'));
      await driver.waitFor(find.byType('BuildingInformationFragment'));
    });

    // Test the 'Urban Observatory' tile.
    test('Urban Observatory', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('urban_observatory_tile'));
      await driver.waitFor(find.byType('UrbanObservatoryFragment'));
    });

    // Test the 'Find a room' tile.
    test('Find a room', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('find_a_room_tile'));
      await driver.waitFor(find.byType('FindARoomFragment'));
    });

    // Test the 'Map' tile.
    test('Map', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('map_tile'));
      await driver.waitFor(find.byType('BuildingMapFragment'));
    });
  });

  // Tests for the 'Explore a floor' section.
  group('Explore a floor:', () {
    int maxFloor;
    Map<int, int> maxRoomNos = <int, int>{};

    // Executes before all tests in the group.
    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('explore_a_floor_tile'));
    });

    // Test all floor buttons.
    test('Floor buttons', () async {
      // Keep trying to press floor buttons.
      for (int i = 0; i > -1; i++) {
        try {
          await driver.waitFor(find.byValueKey('floor_btn_' + i.toString()),
              timeout: Duration(milliseconds: 500));
          await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
          await driver.waitFor(find.byType('FloorFeatureListPage'));
          await driver.tap(find.byType('IconButton'));
          // If no more buttons found, catch exception that is thrown.
        } on DriverError catch (_) {
          if (i == 0) {
            await driver.waitFor(find.text('No floors found'));
          }
          // Record maximum floor number.
          maxFloor = i;
          break;
        }
      }
    });

    // Test all room buttons.
    test('Room buttons', () async {
      // For all floor buttons.
      for (int i = 0; i < maxFloor; i++) {
        await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
        // Try and tap all rooms on the floor.
        for (int j = 0; j > -1; j++) {
          try {
            await driver.waitFor(find.byValueKey('room_btn_' + j.toString()),
                timeout: Duration(milliseconds: 500));
            await driver.scrollUntilVisible(find.byType('ListView'),
                find.byValueKey('room_btn_' + j.toString()));
            await driver.tap(find.byValueKey('room_btn_' + j.toString()));
            await driver.waitFor(find.byType('RoomFeatureListPage'));
            await driver.tap(find.byType('IconButton'));
            // If no more rooms found, catch the exception that is thrown.
          } on DriverError catch (_) {
            if (j == 0) {
              await driver.waitFor(find.text('No rooms found on this floor'));
            }
            // Record number of rooms on the current floor.
            maxRoomNos[i] = j;
            break;
          }
        }
        await driver.tap(find.byType('IconButton'));
      }
    });

    // Test all feature buttons.
    test('Feature buttons', () async {
      // For all floors.
      for (int i = 0; i < maxFloor; i++) {
        await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
        // For all rooms on the current floor.
        for (int j = 0; j < maxRoomNos[i]; j++) {
          await driver.scrollUntilVisible(find.byType('ListView'),
              find.byValueKey('room_btn_' + j.toString()));
          await driver.tap(find.byValueKey('room_btn_' + j.toString()));
          // Try and tap all features in the current room.
          for (int k = 0; k > -1; k++) {
            try {
              await driver.waitFor(
                  find.byValueKey('feature_btn_' + k.toString()),
                  timeout: Duration(milliseconds: 500));
              await driver.scrollUntilVisible(find.byType('ListView'),
                  find.byValueKey('feature_btn_' + k.toString()));
              await driver.tap(find.byValueKey('feature_btn_' + k.toString()));
              await driver.waitFor(find.byType('Dialog'));
              await driver.tap(find.byType('FlatButton'));
              // If no more features found, catch the exception that is thrown.
            } on DriverError catch (_) {
              if (k == 0) {
                await driver
                    .waitFor(find.text('No features found in this room'));
              }
              break;
            }
          }
          await driver.tap(find.byType('IconButton'));
        }
        await driver.tap(find.byType('IconButton'));
      }
    });
  }, timeout: Timeout(Duration(minutes: 10)));

  //Tests for the "Building information" section.
  group('Building information:', () {
    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('building_information_tile'));
    });

    test('About tab', () async {
      await driver.tap(find.byValueKey('about_tab'));
    });

    test('Opening tab', () async {
      await driver.tap(find.byValueKey('opening_times_tab'));
    });

    test('Contact tab', () async {
      await driver.tap(find.byValueKey('contact_tab'));
    });
  });

  // Tests for the 'Urban Observatory' section.
  group('Urban Observatory:', () {
    // Find the search box and submit button needed for following tests.
    SerializableFinder searchFieldFinder = find.byValueKey('room_input');
    SerializableFinder searchButtonFinder = find.byValueKey('search_btn');
    SerializableFinder refreshFinder = find.byValueKey('sensor_refresh');

    // Known good/bad room values.
    final String invalidRoom = '_____';
    final String validRoom = 'G.009';

    // Executes before all tests in the group.
    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('urban_observatory_tile'));
    });

    // Tests for the 'Pick a room' tab of this section.
    group('Pick a room:', () {
      setUpAll(() async {
        await driver.tap(find.byValueKey('pick_a_room_tab'));
      });

      // Tests for searching rooms.
      group('Searching:', () {
        // Test for correct text when no rooms have been searched.
        test('No data requested', () async {
          await driver.waitFor(find.text('No data requested'));
        });

        // Try refreshing with no data requested.
        test('Refresh button with no data requested', () async {
          // Refresh and check correct message is still displayed.
          await driver.tap(refreshFinder);
          await driver.waitFor(find.text('No data requested'));
        });

        // search for an invalid room.
        test('Invalid search', () async {
          await driver.tap(searchFieldFinder);
          await driver.enterText(invalidRoom);
          await driver.tap(searchButtonFinder);
          await Future<void>.delayed(Duration(seconds: 5));

          // Check correct text is displayed.
          await driver.waitFor(find.text('No sensors available in this room'));
        });

        // Try refreshing an invalid room.
        test('Refresh button with an invalid search', () async {
          // refresh and check the correct message is still displayed.
          await driver.tap(refreshFinder);
          await driver.waitFor(find.text('No sensors available in this room'));
        });

        // Search for a valid room.
        test('Valid search', () async {
          await driver.tap(searchFieldFinder);
          await driver.enterText(validRoom);
          await driver.tap(searchButtonFinder);
          await Future<void>.delayed(Duration(seconds: 5));

          // Check a list of data is displayed.
          await driver.waitFor(find.byValueKey('sensor_data'));
        });

        // Try refreshing currently loaded data.
        test('Refresh button with a valid room', () async {
          //Refresh and check data is still displayed.
          await driver.tap(refreshFinder);
          await driver.waitFor(find.byValueKey('sensor_data'));
        });

        // Try refreshing using pull to refresh.
        test('Scroll to refresh with a valid room', () async {
          await driver.scroll(
              find.byType('ListView'), 0, 500, Duration(milliseconds: 250));
          await driver.waitFor(find.byValueKey('sensor_data'));
        });
      });
    });
  });

  group('Map', () {
    SerializableFinder sourceButtonFinder = find.byValueKey('source_btn');
    SerializableFinder targetButtonFinder = find.byValueKey('target_btn');
    SerializableFinder drawButtonFinder = find.byValueKey('draw_btn');
    SerializableFinder dropdownButtonFinder = find.byValueKey('dropdown_btn');
    SerializableFinder roomListFinder = find.byValueKey('room_list');

    // Executes before all tests in the group.
    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('map_tile'));
    });

    group('Select', () {

      test('source button', () async {
        await driver.tap(sourceButtonFinder);
        await driver.tap(find.byType('IconButton'));
      });

      test('target button', () async {
        await driver.tap(targetButtonFinder);
        await driver.tap(find.byType('IconButton'));
      });
    });

    group('Select and draw', () {
      SerializableFinder sourceFinder;
      SerializableFinder targetFinder;
      test('route for the same floor', () async {
        sourceFinder = find.byValueKey('G.063');
        targetFinder = find.byValueKey('G.071');

        await driver.tap(sourceButtonFinder);
        await driver.scrollUntilVisible(roomListFinder, sourceFinder, dyScroll: -150);
        await driver.tap(find.byValueKey('G.063'));

        await driver.tap(targetButtonFinder);
        await driver.scrollUntilVisible(roomListFinder, targetFinder, dyScroll: -150);
        await driver.tap(find.byValueKey('G.071'));

        await driver.tap(drawButtonFinder);
        await Future<void>.delayed(Duration(seconds: 5));
      });


      test('route across multiple floors', () async {
        sourceFinder = find.byValueKey('G.063');
        targetFinder = find.byValueKey('1.006');

        await driver.tap(sourceButtonFinder);
        await driver.scrollUntilVisible(roomListFinder, sourceFinder, dyScroll: -150);
        await driver.tap(sourceFinder);

        await driver.tap(targetButtonFinder);
        await driver.scrollUntilVisible(roomListFinder, targetFinder, dyScroll: -200);
        await driver.tap(targetFinder);

        await driver.tap(drawButtonFinder);
        await Future<void>.delayed(Duration(seconds: 5));

      });
    });
  });

  // Executes after all tests.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

}
