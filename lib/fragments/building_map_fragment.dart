import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BuildingMapFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: AssetImage('assets/images/floor1_temp.png')

      )
    );
  }
}