import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  final drawerButtonFinder = find.byTooltip('Open navigation menu');

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  group('Drawer:', () {
    test('Explore a floor', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('explore_a_floor_tile'));
      await driver.waitFor(find.byType('ExploreAFloorFragment'));
    });

    test('Building information', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('building_information_tile'));
      await driver.waitFor(find.byType('BuildingInformationFragment'));
    });

    test('Urban Observatory', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('urban_observatory_tile'));
      await driver.waitFor(find.byType('UrbanObservatoryFragment'));
    });

    test('Find a room', () async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('find_a_room_tile'));
      await driver.waitFor(find.byType('FindARoomFragment'));
    });
  });

  group('Explore a floor:', () {
    int maxFloor;
    Map<int, int> maxRoomNos = {};

    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('explore_a_floor_tile'));
    });

    test('Floor buttons', () async {
      for(int i = 0; i > -1; i++) {
        try {
          await driver.waitFor(find.byValueKey('floor_btn_' + i.toString()), timeout: Duration(milliseconds: 500));
          await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
          await driver.waitFor(find.byType('FloorFeatureListPage'));
          await driver.tap(find.byType('IconButton'));
        } on DriverError catch (_) {
          if(i == 0) {
            await driver.waitFor(find.text('No floors found'));
          }
          maxFloor = i;
          break;
        }
      }
    });

    test('Room buttons', () async {
      for(int i = 0; i < maxFloor; i++) {
        await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
        for(int j = 0; j > -1; j++) {
          try {
            await driver.waitFor(find.byValueKey('room_btn_' + j.toString()), timeout: Duration(milliseconds: 500));
            await driver.scrollUntilVisible(find.byType('ListView'), find.byValueKey('room_btn_' + j.toString()));
            await driver.tap(find.byValueKey('room_btn_' + j.toString()));
            await driver.waitFor(find.byType('RoomFeatureListPage'));
            await driver.tap(find.byType('IconButton'));
          } on DriverError catch (_) {
            if(j == 0) {
              await driver.waitFor(find.text('No rooms found on this floor'));
            }
            maxRoomNos[i] = j;
            break;
          }
        }
        await driver.tap(find.byType('IconButton'));
      }
    });

    test('Feature buttons', () async {
      for(int i = 0; i < maxFloor; i++) {
        await driver.tap(find.byValueKey('floor_btn_' + i.toString()));
        for(int j = 0; j < maxRoomNos[i]; j++) {
          await driver.scrollUntilVisible(find.byType('ListView'), find.byValueKey('room_btn_' + j.toString()));
          await driver.tap(find.byValueKey('room_btn_' + j.toString()));
          for(int k = 0; k > - 1; k++) {
            try {
              await driver.waitFor(find.byValueKey('feature_btn_' + k.toString()), timeout: Duration(milliseconds: 500));
              await driver.scrollUntilVisible(find.byType('ListView'), find.byValueKey('feature_btn_' + k.toString()));
              await driver.tap(find.byValueKey('feature_btn_' + k.toString()));
              await driver.waitFor(find.byType('Dialog'));
              await driver.tap(find.byType('FlatButton'));
            } on DriverError catch (_) {
              if(k == 0) {
                await driver.waitFor(find.text('No features found in this room'));
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

  group('Urban Observatory:', () {
    SerializableFinder searchFieldFinder = find.byValueKey('room_input');
    SerializableFinder searchButtonFinder = find.byValueKey('search_btn');
    final String invalidRoom = '_____';
    final String validRoom = 'G.009';

    setUpAll(() async {
      await driver.tap(drawerButtonFinder);
      await driver.tap(find.byValueKey('urban_observatory_tile'));
    });

    group('Pick a room:', () {
      setUpAll(() async {
        await driver.tap(find.byValueKey('pick_a_room_tab'));
      });

      group('Searching:', () {
        test('No data requested', () async {
          await driver.waitFor(find.text('No data requested'));
        });

        test('Invalid search', () async {
          await driver.tap(searchFieldFinder);
          await driver.enterText(invalidRoom);
          await driver.tap(searchButtonFinder);
          await Future.delayed(Duration(seconds: 5));
          await driver.waitFor(find.text('No sensors available in this room'));
        });

        group('Valid search', () {
          test('', () async {
            await driver.tap(searchFieldFinder);
            await driver.enterText(validRoom);
            await driver.tap(searchButtonFinder);
            await Future.delayed(Duration(seconds: 5));
            await driver.waitFor(find.byValueKey('sensor_data'));
          });
        });
      });
    });
  });

  tearDownAll(() async {
    if(driver != null) {
      driver.close();
    }
  });
}