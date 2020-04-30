import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:halls_city/UI_componants/hall_properties.dart';
import 'package:halls_city/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import '../Constants.dart';

class AddHall extends StatefulWidget {
  @override
  _AddHallState createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {
  Firestore _fireStore = Firestore.instance;
  String hallCategory, hallName;
  GeoPoint location;
  bool hallNameValid = true, hasError = false, isLocationValid;

  Map<String, dynamic> propertiesWithName = Map<String, dynamic>();
  List<Widget> NamedPropertiesFields = List<Widget>();
  List<String> properties = List<String>();
  List<String> values = List<String>();

  Map<String, bool> propertiesWithIcon = Map<String, bool>();
  List<Widget> IconedPropertyFields = List<Widget>();
  List<String> chosenIcons = List<String>();
  List<bool> IconValue = List<bool>();

  File _image;
  String imageURL;
  bool showSpinner = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> uploadImage() async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(_image.path.substring(_image.path.lastIndexOf('/')));

    final StorageUploadTask uploadTask = ref.putFile(_image);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      Toast.show(event.type.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    });

// Cancel your subscription when done.
    final downloadurl =
        await (await uploadTask.onComplete).ref.getDownloadURL();
    streamSubscription.cancel();
    imageURL = downloadurl.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: light_gray_color,
            // creating an app bar
            appBar: AppBar(
              //setting a color for the app bar
              backgroundColor: main_light_color,
              // creating back button at leading
              leading: IconButton(
                // back_icon is aconstant value
                icon: back_icon,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // adding the logo to the flexible space of abb par
              flexibleSpace: Padding(
                padding: all_sides_padding,
                //adding the logo inside app bar flexibleSpace with 8 padding
                child: Image(
                  image: darkLogo, // calling logo image from constants file
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: circularBorder,
                      //putting the column inside a container to take control of card's color
                      child: Container(
                        color: card_backgrund,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: DropdownButton(
                              value: hallCategory,
                              hint: Text('Chosse hall category'),
                              isExpanded: true,
                              onChanged: (NewValue) {
                                setState(() {
                                  this.hallCategory = NewValue;
                                });
                              },
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('Event hall'),
                                  value: 'event',
                                ),
                                DropdownMenuItem(
                                  child: Text('Co-WorkSpace'),
                                  value: 'co-workspace',
                                ),
                                DropdownMenuItem(
                                  child: Text('Wedding hall'),
                                  value: 'wedding',
                                ),
                                DropdownMenuItem(
                                  child: Text('Studio'),
                                  value: 'studio',
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  hallName = value;
                                });
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                errorText: hallNameValid
                                    ? null
                                    : 'You must enter a hall name',
                                border: OutlineInputBorder(),
                                labelText: 'Hall Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    'Upload hall images : ${_image == null ? '' : _image.path.substring(_image.path.lastIndexOf('/'))}'),
                                Expanded(
                                  child: Container(),
                                ),
                                IconButton(
                                    icon: Icon(Icons.photo_library),
                                    onPressed: () async {
                                      await getImage();
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    'Add location : ${isLocationValid == null ? '' : isLocationValid ? 'Location capteured' : 'try adding your location'}'),
                                Expanded(
                                  child: Container(),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add_location),
                                    onPressed: () async {
                                      bool isLocationEnabled =
                                          await Geolocator()
                                              .isLocationServiceEnabled();
                                      isLocationEnabled
                                          ? null
                                          : showDialog<String>(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    backgroundColor:
                                                        light_gray_color,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.0))),
                                                    title: Text(
                                                        'please enable GPS'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Ok'),
                                                        onPressed: () async {
                                                          await Geolocator()
                                                                  .isLocationServiceEnabled()
                                                              ? Navigator.pop(
                                                                  context, 'ok')
                                                              : null;
                                                        },
                                                      )
                                                    ],
                                                  ));
                                      print('oooooooooh');
                                      Position position;
                                      try {
                                        position = await Geolocator()
                                            .getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.high);
                                      } catch (e) {
                                        Toast.show(e.toString(), context,
                                            duration: Toast.LENGTH_SHORT,
                                            gravity: Toast.BOTTOM);
                                      }
                                      position == null
                                          ? isLocationValid = false
                                          : isLocationValid = true;
                                      if (isLocationValid) {
                                        location = GeoPoint(position.latitude,
                                            position.longitude);
                                      }
                                      setState(() {
                                        isLocationValid;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    // the padding is set to be a constant value with all_sides_padding
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                    ),
                    //using this widget to clip the card corners with a constant value [circularBorder] radius
                    child: ClipRRect(
                      borderRadius: circularBorder,
                      //putting the column inside a container to take control of card's color
                      child: Container(
                        color: card_backgrund,
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text('Properties with Icons'),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(Icons.minimize),
                                    onPressed: () {
                                      setState(() {
                                        if (IconedPropertyFields.length > 0) {
                                          IconedPropertyFields.removeLast();
                                          chosenIcons.removeLast();
                                          IconValue.removeLast();
                                        }
                                      });
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      chosenIcons.add(null);
                                      IconValue.add(true);
                                      setState(() {
                                        IconedPropertyFields.add(
                                            addIconedProperty(
                                                IconedPropertyFields.length,
                                                null));
                                      });
                                    }),
                              ),
                            ],
                          ),
                          ...IconedPropertyFields
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    // the padding is set to be a constant value with all_sides_padding
                    padding: all_sides_padding,
                    //using this widget to clip the card corners with a constant value [circularBorder] radius
                    child: ClipRRect(
                      borderRadius: circularBorder,
                      //putting the column inside a container to take control of card's color
                      child: Container(
                        color: card_backgrund,
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text('Properties with name'),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(Icons.minimize),
                                    onPressed: () {
                                      setState(() {
                                        if (NamedPropertiesFields.length > 0) {
                                          NamedPropertiesFields.removeLast();
                                          properties.removeLast();
                                          values.removeLast();
//                                        isPropertiesVlaid.removeLast();
//                                        isValuesVlaid.removeLast();
                                        }
                                      });
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      properties.add(null);
                                      values.add(null);
//                                    isPropertiesVlaid.add(true);
//                                    isValuesVlaid.add(true);
                                      setState(() {
                                        NamedPropertiesFields.add(
                                            addNamedProperty(
                                                NamedPropertiesFields.length));
                                      });
                                    }),
                              ),
                            ],
                          ),
                          ...NamedPropertiesFields,
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: HallProperties.customButton(
                              text: 'Add my hall',
                              context: this.context,
                              onclick: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                hasError = false;
                                if (hallCategory == null) {
                                  hasError = true;
                                  Toast.show(
                                      "please add hall Category", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                  return;
                                }
                                if (hallName == null || hallName == '') {
                                  setState(() {
                                    hallNameValid = false;
                                  });
                                  hasError = true;
                                }
                                for (int counter = 0;
                                    counter < properties.length;
                                    counter++) {
                                  (properties[counter] == null ||
                                          properties[counter] == '')
                                      ? hasError = true
                                      : null;
                                  (values[counter] == null ||
                                          values[counter] == '')
                                      ? hasError = true
                                      : null;
                                }
                                if (!hasError) {
                                  propertiesWithName.clear();
                                  propertiesWithIcon.clear();
                                  for (int counter = 0;
                                      counter < properties.length;
                                      counter++) {
                                    propertiesWithName[properties[counter]] =
                                        values[counter];
                                  }
                                  for (int counter = 0;
                                      counter < chosenIcons.length;
                                      counter++) {
                                    propertiesWithIcon[chosenIcons[counter]] =
                                        IconValue[counter];
                                  }

                                  for (int counter = 0;
                                      counter < chosenIcons.length;
                                      counter++) {
                                    if (chosenIcons[counter] == null ||
                                        chosenIcons[counter] == '') {
                                      hasError = true;
                                    }
                                  }
                                }
                                if (_image == null) {
                                  hasError = true;
                                }
                                if (location == null) {
                                  hasError = true;
                                  Toast.show(
                                      "please add hall location", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                  return;
                                }

                                if (hasError) {
                                  Toast.show(
                                      "Please complete all feilds", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                } else {
                                  await uploadImage();
                                  await _fireStore
                                      .collection('my app')
                                      .document('halls')
                                      .collection(hallCategory)
                                      .document()
                                      .setData({
                                    'placeName': hallName,
                                    'category': hallCategory,
                                    'images': [imageURL],
                                    'rating': 5,
                                    'namedProperties': propertiesWithName,
                                    'propertyIcon': propertiesWithIcon,
                                    'schedule': {},
                                    'location': location
                                  });
                                  showDialog<String>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            backgroundColor: light_gray_color,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0))),
                                            title: Text(
                                                'Your hall have been added sucsessfully'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()));
                                                },
                                              )
                                            ],
                                          ));
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget addNamedProperty(int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  print(value);
                  properties[index] = value;
                });
              },
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                errorText: true ? null : 'You must enter a property name',
                border: OutlineInputBorder(),
                labelText: 'Property',
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 4,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  print(value);
                  values[index] = value;
                });
              },
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
//                errorText: isValuesVlaid[index]
//                    ? null
//                    : 'The property must have value',
                border: OutlineInputBorder(),
                labelText: 'value',
              ),
            ),
          ),
        ],
      ),
    );
  }

  int i = 0;
  Widget addIconedProperty(int index, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: DropdownButton(
              value: value,
              hint: Text('Chosse Icon'),
              isExpanded: true,
              onChanged: (newIconName) {
                setState(() {
                  print(newIconName);
                  value = newIconName;
                  chosenIcons[index] = value;
                  IconedPropertyFields[index] = addIconedProperty(index, value);
                });
              },
              items: IconsName.map((String IconName) {
                return DropdownMenuItem(
                  child: Text(IconName),
                  value: IconName,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Switch(
                  value: IconValue[index],
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      IconValue[index] = value;
                    });
                  },
                ),
              )),
        ],
      ),
    );
  }
}
