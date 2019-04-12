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