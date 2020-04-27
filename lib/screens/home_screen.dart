import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:halls_city/models/user_data.dart';
import 'package:halls_city/UI_componants/drawer.dart';
import 'package:halls_city/UI_componants/halls_images.dart';
import 'package:halls_city/Constants.dart' as constant;
import 'package:halls_city/screens/category_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  // intializing a new home screen which contains a (app bar ,slider, halls category,mix halls)

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;
  List<Map<String, dynamic>> co_workspaceHallsList,
      eventHallsList,
      studioHallsList,
      weddingHallsList;

  getCurrentUser() async {
    try {
      final _user = await _auth.currentUser();
      if (_user != null) {
        _loggedInUser = _user;
        print(_loggedInUser);
      }
    } catch (e) {
      Toast.show(e, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  getAllHalls() async {
    co_workspaceHallsList = List<Map<String, dynamic>>();
    eventHallsList = List<Map<String, dynamic>>();
    studioHallsList = List<Map<String, dynamic>>();
    weddingHallsList = List<Map<String, dynamic>>();
    try {
      QuerySnapshot co_workspaceHalls = await _fireStore
          .collection('my app')
          .document('halls')
          .collection('co-workspace')
          .getDocuments();
      QuerySnapshot eventHalls = await _fireStore
          .collection('my app')
          .document('halls')
          .collection('event')
          .getDocuments();
      QuerySnapshot studioHalls = await _fireStore
          .collection('my app')
          .document('halls')
          .collection('studio')
          .getDocuments();
      QuerySnapshot weddingHalls = await _fireStore
          .collection('my app')
          .document('halls')
          .collection('wedding')
          .getDocuments();
      for (var hall in co_workspaceHalls.documents) {
        co_workspaceHallsList.add(hall.data);
      }
      for (var hall in eventHalls.documents) {
        eventHallsList.add(hall.data);
      }
      for (var hall in studioHalls.documents) {
        studioHallsList.add(hall.data);
      }
      for (var hall in weddingHalls.documents) {
        weddingHallsList.add(hall.data);
      }
    } catch (e) {}
    print('5');
    print([
      ...weddingHallsList,
      ...studioHallsList,
      ...co_workspaceHallsList,
      ...eventHallsList
    ]);
//    for (var hall in allHalls) {
//      print(hall.data);
//    }
  }

  @override
  void initState() {
    super.initState();
    getAllHalls();
    getCurrentUser();
  }

//  void navigateUser() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var status = prefs.getBool('isLoggedIn') ?? false;
//    print('labla$status');
//  }

  @override
  Widget build(BuildContext context) {
    //Now Lets Add Slider class
    final _slider = SizedBox(
      height: 180.0,
      //creating a carousel using carousel pro library.
      child: new Carousel(
        images: [
          new NetworkImage(
              "https://media.weddingz.in/images/31b500a2fbab21f93117c57d29ab72a2/vaishnav-banquet-marriage-party-hall-kandivali-west-mumbai-1.jpg"),
          new NetworkImage(
              "https://www.wework.com/ideas/wp-content/uploads/sites/4/2019/06/Web_150DPI-20180324-WeWork-Carioca-Common-Areas-Couch-Area-2-1120x630.jpg"),
          new NetworkImage(
              "https://i.pinimg.com/originals/e9/75/f1/e975f175ac33b096149991a8aa992616.jpg"),
          new NetworkImage(
              "https://i.pinimg.com/originals/90/47/12/904712e9e43797e4468a0ac19cbb0ca7.jpg"),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.white,
        indicatorBgPadding: 1.0,
        dotBgColor: Colors.black.withOpacity(0.3),
      ),
    );
    // for not overriding notification bar
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Center(
          // the largest widget of material app which contains all other widgets.
          child: Scaffold(
            key: _key,
            // creating an app bar
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
//                onPressed: () {
//                  showSearch(context: context, delegate: DataSearch(listWords));
//                }
                )
              ],
              backgroundColor: constant.main_light_color,
              leading: IconButton(
                // menu_icon is a constant value
                icon: constant.menu_icon,
                onPressed: () {
                  _key.currentState.openDrawer();
                },
              ),
              // adding the logo to the flexible space of app bar
              flexibleSpace: Padding(
                //adding the logo inside app bar flexibleSpace with 8 padding
                padding: constant.all_sides_padding,
                child: Image(
                  // calling logo image from constants file
                  image: constant.darkLogo,
                ),
              ),
            ),
            //get drawer from drawer class
            drawer: BuildDrawer(),
            // inserting all widgets inside a single scroll view to make the scrollable
            body: SingleChildScrollView(
              //all widgets will be assigned into a column
              child: Column(
                children: <Widget>[
                  _slider,
                  Padding(padding: const EdgeInsets.all(0.8)),
                  //category(event+wedding+workspace+studio),when you click on category its open halls image class

                  Container(
                    width: 400,
                    height: 120,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 7,
                        ),
                        //Use`Navigator` widget to go to category screen .
                        GestureDetector(
                          onTap: () {
                            //Use`Navigator` widget to push the category to out stack of screens
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return CategoryScreen(
                                hallsList: co_workspaceHallsList,
                                categoryName: 'Co-workspace',
                              );
                            }));
                          },
                          child: Container(
                            width: 70.0,
                            height: 210.0,
                            color: Colors.white,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                color: constant.main_light_color,
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        "Co",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'images/3.png',
                                    height: 50,
                                    width: 55,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            //Use`Navigator` widget to go to category screen .
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return CategoryScreen(
                                hallsList: weddingHallsList,
                                categoryName: 'Wedding Halls',
                              );
                            }));
                          },
                          child: Container(
                            width: 70.0,
                            height: 210.0,
                            color: Colors.white,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                color: constant.main_light_color,
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        "We",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'images/2.png',
                                    height: 50,
                                    width: 55,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            //Use`Navigator` widget to go to category screen .
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return CategoryScreen(
                                categoryName: 'Event Halls',
                                hallsList: eventHallsList,
                              );
                            }));
                          },
                          child: Container(
                            width: 70.0,
                            height: 210.0,
                            color: Colors.white,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                color: constant.main_light_color,
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        "Ev",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'images/1.png',
                                    height: 50,
                                    width: 55,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            //Use`Navigator` widget to go to category screen .
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return CategoryScreen(
                                hallsList: studioHallsList,
                                categoryName: 'Studio',
                              );
                            }));
                          },
                          child: Container(
                            width: 70.0,
                            height: 210.0,
                            color: Colors.white,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                color: constant.main_light_color,
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        "St",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  //studio image
                                  Image.asset(
                                    'images/4.png',
                                    height: 50,
                                    width: 55,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.8),
                  ),
                  //mix halls
                  Container(
                    color: Colors.white,
                    width: 330,
                    height: 300,
                    // move to halls image class
                    child: HallsImage(
                      hallsList: [
                        ...weddingHallsList,
                        ...studioHallsList,
                        ...co_workspaceHallsList,
                        ...eventHallsList
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
