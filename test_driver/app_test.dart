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

  tearDownAll(() async {
    if(driver != null) {
      driver.close();
    }
  });
}