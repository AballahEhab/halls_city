import 'package:flutter/material.dart';
import 'package:halls_city/Constants.dart' as constant;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class HallsImage extends StatelessWidget {
//  final String imgUrl;
//  final String imgName;
//  HallsImage(this.imgUrl, this.imgName);
  //list of network image halls which i call it in network image widget
  final List<String> images = [
    'https://media.weddingz.in/images/fc860b718e1c38c958f3cdc0e64cc244/g-p-janarajan-marriage-hall-injambakkam-chennai-1.jpg',
    'https://www.regalhotel.com/uploads/rseah/meetings_n_events/meetings/720x475/img_meeting01.jpg',
    'https://www.galaxystudios.com/wp-content/uploads/2016/06/Mastering-Room-Sound-Galaxy-Studios-1024x677.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/d/d0/Galaxy_Studios_-_Galaxy_Hall.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/0e/5b/29/ef/meeting-room-with-u-shape.jpg',
    'https://www.brandsynario.com/wp-content/uploads/2019/03/karachi-marriage-halls.jpg',
    'https://www.kingstonarts.com.au/files/sharedassets/arts-website/hire/sbt/sbt-studio-1.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/c/c4/Meeting_Room_%28U_shape%29_-_Novotel_Century_Hong_Kong_Hotel.jpg',
  ];
  //list of titles of halls image which i call it in text widget
  final List<String> title = [
    'Almasa',
    'plaza',
    'fun',
    'happy',
    'fantasy',
     ];

  @override
  Widget build(BuildContext context) {
    //making GridView which is a view group that displays items in a two-dimensional scrolling grid (rows and columns)
    return GridView.builder(
        itemCount: 8,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            //making the image border curvy not hard
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          images[index % images.length],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : Container(
                                    height: 150,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.indigo),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text( title[index % title.length],
                          style: TextStyle(color: Colors.white, fontSize: 18,),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:constant.three_sides_padding,
                    child: RatingBar(
                      itemSize: 22,
                      initialRating: 3.5,
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
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
