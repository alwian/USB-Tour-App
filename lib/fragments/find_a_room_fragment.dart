import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:csc2022_app/pages/search_form_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FindARoomFragment extends StatelessWidget {

  //List of images to display in Carousel
  final List<String> imageList = [
    "assets/images/floor0.png",
    "assets/images/floor1.png",
    "assets/images/floor2.png",
    "assets/images/floor3.png",
    "assets/images/floor4.png"
  ];

  ///Method to build button
  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 35.0, right: 15.0, bottom: 35.0),
      child: MaterialButton(
        height: 75.0,
        minWidth: 125.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchFormPage()),
          );
        },

        splashColor: Theme
            .of(context)
            .primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 45.0,
              color: Colors.black
            ),
            Text(
              'Search for a room',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Method to build map content
  Widget _buildMapBody(BuildContext context) {

    return CarouselSlider(
      height: (MediaQuery.of(context).size.height) * 0.66,
      autoPlayInterval: Duration(seconds: 5),
      autoPlayAnimationDuration: Duration(seconds: 1),
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 7),
      viewportFraction: 0.9,
      aspectRatio: 1.0,
      items: imageList.map(
            (url) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Image.asset(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height),
                alignment: Alignment(-.2, 0),
              ),
            ),
          );
        },
      ).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ///@todo replace image with map when finished
          _buildMapBody(context),
          Center(
            child: _buildButton(context),
          )
        ]
      ),
    );
  }
}