import 'package:flutter/material.dart';
import 'package:halls_city/UI_componants/halls_images.dart';
import 'package:halls_city/Constants.dart' as constant;

class CategoryScreen extends StatefulWidget {
  List<Map<String, dynamic>> hallsList;
  String categoryName;
  CategoryScreen({this.hallsList, this.categoryName});
  // creating a new Category screen which contains halls categories { Wedding, workSpace, event, studio }

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // for not overriding notification bar
    return SafeArea(
      child: Center(
        // the largest widget of material app which contains all other widgets.
        child: Scaffold(
          // key: _key,
          // creating an app bar
          appBar: AppBar(
            //setting a color for the app bar
            backgroundColor: constant.main_light_color,
            title: Text(
              widget.categoryName,
              style: TextStyle(fontFamily: "nunito", color: Colors.white),
            ),
            centerTitle: true,
            // creating menu button at leading
            leading: IconButton(
              // menu_icon is a constant value
              icon: constant.back_icon,
              //Return to the previous page(home screen)
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // making app bar is gradient color
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.blue,
                      Colors.blue[200],
                    ]),
              ),
            ),
          ),
          //calling a HallImage class, return a list of halls for categories.
          body: HallsImage(
            hallsList: widget.hallsList,
          ),
        ),
      ),
    );
  }
}
