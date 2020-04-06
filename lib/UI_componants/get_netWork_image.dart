import 'package:flutter/material.dart';

import '../constants.dart';


// this widget gets the image provider and set it to an image widget
//with some custom properties
//with progress indicator


class GetNetworkImage extends StatelessWidget {
  ImageProvider image;

// receiving image provider from constructor
  GetNetworkImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Image(
      //the images fills the parent with hte same ratio
      fit: BoxFit.cover,
      image: this.image,
      // loading builder checks for the image if available or not
      // and showing progress Indicator if the image not found
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : Container(
                height: 150,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(main_dark_color),
                  ),
                ),
              );
      },
    );
    ;
  }
}
