import 'package:flutter/material.dart';
import 'package:halls_city/UI_componants/hall_properties.dart';
import 'package:halls_city/models/place.dart';

import '../Constants.dart';

//this class is a parent class for all halls categories

class Hall extends Place {
  //this map stores boolean values for properties which performed in ui as icons
  Map<IconData, bool> propertyIcon;

  String category;

  //hall location
  var location;

  num rating;

  Hall(
      {String name,
      this.category,
      this.propertyIcon,
      Map<String, dynamic> namedProperties})
      : super(placeName: name, namedProperty: namedProperties) {
    this.images = [network_image1, network_image2, network_image2];
    rating = 3.0;
  }

  Hall.Initialize({
    String name,
    List hallImages,
    this.category,
    this.location,
    this.rating,
    String address,
    bool wifi,
    bool WC,
  }) : super.initialize(
          placeName: name,
          images: hallImages,
        ) {
    propertyIcon = Map();
    this.namedProperty['Address'] = address;
    this.propertyIcon[Icons.wifi] = wifi;
    this.propertyIcon[Icons.wc] = WC;
  }

  // adding a new property icon to the hall
  void addpropertyIcon({IconData name, bool value}) {
    propertyIcon[name] = value;
  }

  // [getPropertyIcons] function run in a loop in property icons list
  // and add every property as an icon in a list of widget in a custom UI component [creatPropertyIcon]

}
