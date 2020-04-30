import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:halls_city/models/user_data.dart';
import 'package:halls_city/UI_componants/drawer.dart';
import 'package:halls_city/UI_componants/halls_images.dart';
import 'package:halls_city/Constants.dart' as constant;
import 'package:halls_city/screens/category_screen.dart';
import 'package:halls_city/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../Constants.dart';

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
  List<DocumentSnapshot> co_workspaceHallsList,
      eventHallsList,
      studioHallsList,
      weddingHallsList;
  String searxhKeyWord;

  bool loading = true;
  Widget logo = Padding(
    //adding the logo inside app bar flexibleSpace with 8 padding
    padding: constant.all_sides_padding,
    child: Image(
      // calling logo image from constants file
      image: constant.darkLogo,
    ),
  );
  Widget searchfeild = null;
  Icon SearchBotton = new Icon(
    Icons.search,
    color: constant.main_dark_color,
    size: 25,
  );

  getCurrentUser() async {
    try {
      final _user = await _auth.currentUser();
      if (_user != null) {
        _loggedInUser = _user;
        print(_loggedInUser.displayName);
      }
    } catch (e) {
      Toast.show(e, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  getAllHalls() async {
    co_workspaceHallsList = List<DocumentSnapshot>();
    eventHallsList = List<DocumentSnapshot>();
    studioHallsList = List<DocumentSnapshot>();
    weddingHallsList = List<DocumentSnapshot>();
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

      co_workspaceHallsList = co_workspaceHalls.documents;
      eventHallsList = eventHalls.documents;
      studioHallsList = studioHalls.documents;
      weddingHallsList = weddingHalls.documents;
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }

    this.loading = false;
    setState(() {
      loading;
      co_workspaceHallsList;
      eventHallsList;
      studioHallsList;
      weddingHallsList;
    });
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
        child: Scaffold(
          key: _key,
          // creating an app bar
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: SearchBotton,
                  onPressed: () {
                    setState(() {
                      if (this.SearchBotton.icon == Icons.search) {
                        this.SearchBotton = new Icon(
                          Icons.close,
                          color: constant.main_dark_color,
                          size: 24,
                        );
                        logo = null;

                        this.searchfeild = new TextField(
                          onChanged: (newValue) {
                            searxhKeyWord = newValue;
                          },
                          cursorColor: constant.main_dark_color,
                          style: new TextStyle(
                            color: constant.light_gray_color,
                          ),
                          decoration: new InputDecoration(
//
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: constant.main_dark_color,
                                size: 24,
                              ),
                              color: constant.main_dark_color,
                              onPressed: () {
                                if (searxhKeyWord != null &&
                                    searxhKeyWord != '') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                searchKey:
                                                    searxhKeyWord.toLowerCase(),
                                                allHalls: [
                                                  ...weddingHallsList,
                                                  ...studioHallsList,
                                                  ...co_workspaceHallsList,
                                                  ...eventHallsList,
                                                ],
                                              )));
                                } else {
                                  Toast.show('you must enter at least one word',
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              },
                            ),
                            hintText: "Search with hall name...",
                            hintStyle:
                                new TextStyle(color: constant.main_dark_color),
                          ),
                        );
                      } else {
                        this.SearchBotton = new Icon(
                          Icons.search,
                          color: constant.main_dark_color,
                          size: 24,
                        );
                        searchfeild = null;
                        this.logo = Padding(
                          //adding the logo inside app bar flexibleSpace with 8 padding
                          padding: constant.all_sides_padding,
                          child: Image(
                            // calling logo image from constants file
                            image: constant.darkLogo,
                          ),
                        );
                      }
                    });
                  }),
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
            title: searchfeild,
            flexibleSpace: logo,
          ),
          //get drawer from drawer class
          drawer: BuildDrawer(),
          // inserting all widgets inside a single scroll view to make the scrollable
          body: loading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  //all widgets will be assigned into a column
                  child: Column(
                    children: <Widget>[
                      _slider,
                      //category(event+wedding+workspace+studio),when you click on category its open halls image class

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //Use`Navigator` widget to go to category screen .
                              GestureDetector(
                                onTap: () {
                                  //Use`Navigator` widget to push the category to out stack of screens
                                  Navigator.of(context).push(
                                      MaterialPageRoute<Null>(
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
                                      borderRadius:
                                          new BorderRadius.circular(40.0),
                                    ),
                                    child: Center(
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
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

                              GestureDetector(
                                onTap: () {
                                  //Use`Navigator` widget to go to category screen .
                                  Navigator.of(context).push(
                                      MaterialPageRoute<Null>(
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
                                      borderRadius:
                                          new BorderRadius.circular(40.0),
                                    ),
                                    child: Center(
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
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

                              GestureDetector(
                                onTap: () {
                                  //Use`Navigator` widget to go to category screen .
                                  Navigator.of(context).push(
                                      MaterialPageRoute<Null>(
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
                                      borderRadius:
                                          new BorderRadius.circular(40.0),
                                    ),
                                    child: Center(
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
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

                              GestureDetector(
                                onTap: () {
                                  //Use`Navigator` widget to go to category screen .
                                  Navigator.of(context).push(
                                      MaterialPageRoute<Null>(
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
                                      borderRadius:
                                          new BorderRadius.circular(40.0),
                                    ),
                                    child: Center(
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.8),
                      ),
                      //mix halls
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 240,
                        // move to halls image class
                        child: HallsImage(
                          hallsList: [
                            ...weddingHallsList,
                            ...studioHallsList,
                            ...co_workspaceHallsList,
                            ...eventHallsList,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
