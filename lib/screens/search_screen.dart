import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halls_city/Constants.dart';
import 'package:halls_city/UI_componants/hall_properties.dart';
import 'package:halls_city/UI_componants/halls_images.dart';
import 'package:halls_city/screens/reservation_screen.dart';
import 'package:toast/toast.dart';
import '../Constants.dart';

class Search extends StatefulWidget {
  String searchKey;
  List allHalls;
  Search({this.searchKey, this.allHalls});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool loading = true;
  Widget logo = Padding(
    //adding the logo inside app bar flexibleSpace with 8 padding
    padding: all_sides_padding,
    child: Image(
      // calling logo image from constants file
      image: darkLogo,
    ),
  );
  Widget bottomSearchfeild = null;
  Icon SearchBotton = new Icon(
    Icons.search,
    color: main_dark_color,
    size: 25,
  );
  Widget appBarTitle = Text("Search");
  Widget bottom_search;
  List result;

  // ignore: non_constant_identifier_names
  String value;

  _search() {
    setState(() {
      loading = true;
    });
    result = List();
    for (DocumentSnapshot hall in widget.allHalls) {
      print(hall.data['placeName'].toLowerCase());
      if (hall.data['placeName'].toLowerCase() == widget.searchKey) {
        result.add(hall);
      }
    }

    setState(() {
      loading = false;
      print(result);
    });
  }

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          backgroundColor: light_gray_color,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: SearchBotton,
                  onPressed: () {
                    setState(() {
                      if (this.SearchBotton.icon == Icons.search) {
                        this.SearchBotton = new Icon(
                          Icons.close,
                          color: main_dark_color,
                          size: 24,
                        );
                        logo = null;

                        this.bottomSearchfeild = new TextField(
                          onChanged: (newValue) {
                            widget.searchKey = newValue;
                          },
                          cursorColor: main_dark_color,
                          style: new TextStyle(
                            color: light_gray_color,
                          ),
                          decoration: new InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: main_dark_color,
                                size: 24,
                              ),
                              color: main_dark_color,
                              onPressed: () {
                                if (widget.searchKey != null &&
                                    widget.searchKey != '') {
                                  widget.searchKey =
                                      widget.searchKey.toLowerCase();
                                  _search();
                                } else {
                                  Toast.show('you must enter at least one word',
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              },
                            ),
                            hintText: "Search with hall name...",
                            hintStyle: new TextStyle(color: main_dark_color),
                          ),
                        );
                      } else {
                        this.SearchBotton = new Icon(
                          Icons.search,
                          color: main_dark_color,
                          size: 24,
                        );
                        bottomSearchfeild = null;
                        this.logo = Padding(
                          //adding the logo inside app bar flexibleSpace with 8 padding
                          padding: all_sides_padding,
                          child: Image(
                            // calling logo image from constants file
                            image: darkLogo,
                          ),
                        );
                      }
                    });
                  }),
            ],
            backgroundColor: main_light_color,
            leading: IconButton(
              // back_icon is aconstant value
              icon: back_icon,
              color: main_dark_color,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // adding the logo to the flexible space of abb par
            title: bottomSearchfeild,
            flexibleSpace: logo,
          ),
          body: loading
              ? Center(child: CircularProgressIndicator())
              : new Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 138,
                          child: result == null || result == []
                              ? Center(
                                  child: Text('NO mach result'),
                                )
                              : HallsImage(
                                  hallsList: result,
                                )),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.black12,
                        child: ExpansionTile(
                          title: Text('Custom search'),
                          backgroundColor: light_gray_color,
                          onExpansionChanged: (state) {
                            setState(() {
                              if (state) {
                                bottom_search = Row(
                                  children: <Widget>[
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                        child: HallProperties.customButton(
                                      context: this.context,
                                      text: 'Search',
                                      onclick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReservationScreen())); // routing the
                                      },
                                    )),
                                    const SizedBox(width: 10.0),
                                    new FlatButton(
                                      color: Colors.black26,
                                      textColor: Colors.white,
                                      onPressed: () => debugPrint('Clear'),
                                      child: new Text('Clear'),
                                    ),
                                  ],
                                );
                              } else if (!state) {
                                bottom_search = null;
                              }
                            });
                          },
                          children: <Widget>[
                            new Text(
                              'Please Enter The Required Data',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            DropdownButton(
                              value: value,
                              hint: Text('Enter Choose Country'),
                              isExpanded: true,
                              // ignore: non_constant_identifier_names
                              onChanged: (NewValue) {
                                print(value);
                                this.value = NewValue;
                              },
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('Alexandria'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Aswan'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Asyut'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Arish'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Banha'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Beheira'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Beni Suef'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Cairo'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Dakahlia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Damanhur'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Damietta'),
                                ),
                                DropdownMenuItem(
                                  child: Text('El Tor'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Faiyum'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Gharbia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Giza'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Hurghada'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Ismailia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Kafr El Sheikh'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Kharga'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Luxor'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Mansoura'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Marsa Matruh'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Minya'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Monufia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('New Valley'),
                                ),
                                DropdownMenuItem(
                                  child: Text('North Sinai'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Port Said'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Qalyubia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Qena'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Red Sea'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Sharqia'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Shibin El Kom'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Sohag'),
                                ),
                                DropdownMenuItem(
                                  child: Text('South Sinai'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Suez'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Tanta'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Zagazig'),
                                ),
                              ],
                            ),

                            new TextField(
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black),
                              decoration: InputDecoration(labelText: 'Area'),
                            ),
                            DropdownButton(
                              value: value,
                              hint: Text('Hall type'),
                              isExpanded: true,
                              // ignore: non_constant_identifier_names
                              onChanged: (NewValue) {
                                print(value);
                                this.value = NewValue;
                              },
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('Meetings'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Wedding'),
                                ),
                                DropdownMenuItem(
                                  child: Text('CoWork'),
                                ),
                                DropdownMenuItem(
                                  child: Text('Studio'),
                                ),
                              ],
                            ),
                            new TextField(
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: 'The Requested Data'),
                            ),
                            new TextField(
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black),
                              decoration: InputDecoration(labelText: 'Time'),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 7)),
                            //to create an area before the title
                            new Text(
                              'Hall Characteristics',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            DropdownButton(
                              value: value,
                              hint: Text('Number Of Chairs'),
                              isExpanded: true,
                              // ignore: non_constant_identifier_names
                              onChanged: (NewValue) {
                                print(value);
                                this.value = NewValue;
                              },
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('50'),
                                ),
                                DropdownMenuItem(
                                  child: Text('100'),
                                ),
                                DropdownMenuItem(
                                  child: Text('150'),
                                ),
                                DropdownMenuItem(
                                  child: Text('200'),
                                ),
                                DropdownMenuItem(
                                  child: Text('250'),
                                ),
                                DropdownMenuItem(
                                  child: Text('300'),
                                ),
                                DropdownMenuItem(
                                  child: Text('350'),
                                ),
                                DropdownMenuItem(
                                  child: Text('400'),
                                ),
                                DropdownMenuItem(
                                  child: Text('450'),
                                ),
                                DropdownMenuItem(
                                  child: Text('500'),
                                ),
                              ],
                            ),
                            DropdownButton(
                              value: value,
                              hint: Text('The Space'),
                              isExpanded: true,
                              // ignore: non_constant_identifier_names
                              onChanged: (NewValue) {
                                print(value);
                                this.value = NewValue;
                              },
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('100 m'),
                                ),
                                DropdownMenuItem(
                                  child: Text('200 m'),
                                ),
                                DropdownMenuItem(
                                  child: Text('300 m'),
                                ),
                                DropdownMenuItem(
                                  child: Text('400 m'),
                                ),
                                DropdownMenuItem(
                                  child: Text('500 m'),
                                ),
                                DropdownMenuItem(
                                  child: Text('600 m'),
                                ),
                              ],
                            ),

                            new Padding(padding: EdgeInsets.only(top: 7)),
                            new Text(
                              'Price',
                              style: TextStyle(fontSize: 12.0),
                              textAlign: TextAlign.left,
                            ),
                            new TextField(
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black),
                              decoration: InputDecoration(labelText: 'Min'),
                            ),
                            new TextField(
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black),
                              decoration: InputDecoration(labelText: 'Max'),
                            ),
                            new Padding(padding: EdgeInsets.all(4)),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: bottom_search),
    );
  }
}
