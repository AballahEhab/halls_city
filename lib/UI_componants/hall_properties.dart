import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';


//this class contains some static methods which can be called by class name
// every method returns a customized widget used commonly over the project


class HallProperties {


//this method returns an icon which represents a property of a hall
  // this func creates a new room property with the name and its value as Row
  static Widget creatNamedproperty({String property, String value}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(property), Text(value)],
      ),
    );
  }


  //this function takes two parameter
  //iconData to return an icon widget in a cutom setup
  // and isEnabed to chose icon color if gray or blue
  static Widget creatPropertyIcon(
      {@required IconData iconName, bool isEnabled = false}) {
    // the method inputs are [iconName] of type IconDdata which is required
    //the second input [isEnabled] of boolean type which is specifies if the hall has this property icon or not
    return Padding(
      padding: all_sides_padding,
      child: Icon(
        iconName,
        color: isEnabled ? main_light_color : Colors.grey,
        size: 24.0,
      ),
    );
  }

  // a custom Material button method which has two parameters
  // the first is the
  static Widget customButton({text, context, onclick}) {
    return ClipRRect(
      borderRadius: circularBorder,
      child: MaterialButton(
        //setting a height of the button to fill the row height
        height: 50,
        color: main_light_color,
          // button color which is the same app bar color
        child: Text(
          text,
          // customizing the text style and change the text size and color
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
          onPressed: onclick
      ),
    );
  }


  static Widget customRateBar({num rate}) {
    return RatingBar(
      itemSize: 22,
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(),
      itemBuilder: (context, _) =>
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
    );
  }
}
