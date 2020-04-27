import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:halls_city/UI_componants/hall_properties.dart';
import 'package:halls_city/models/hall.dart';
import 'package:toast/toast.dart';

import '../Constants.dart';
import 'hall_screen.dart';

class AddHall extends StatefulWidget {
  @override
  _AddHallState createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {


  String hallCategory,hallName;
  bool hallNameValid = true, hasError = false;


  Map<String,dynamic> propertiesWithName = Map<String,dynamic>();
  List<String> properties = List<String>();
  List<String> values = List<String>();
  List <Widget> NamedPropertiesFields  = List<Widget>();
  List<bool> isPropertiesVlaid = List<bool>();
  List<bool> isValuesVlaid = List<bool>();



  Map<IconData,bool> propertiesWithIcon = Map<IconData,bool>();
  List <Widget> IconedPropertyFields  = List<Widget>();
  List<String> chosenIcons = List<String>();
  List<bool> IconValue = List<bool>();

  List<IconData> IconsData = [
    Icons.card_membership,
    Icons.event_seat,
    Icons.record_voice_over,
    Icons.speaker,
    Icons.local_cafe,
    Icons.wifi,
    Icons.wc,
    Icons.ac_unit,
    Icons.personal_video,
    Icons.kitchen,
  ];

  List<String> IconsName =[
    'Membership',
    'Event Seat',
    'Recording tools',
    'Sound system',
    'Drinks',
    'Wifi',
    'Wc',
    'Air condition unit',
    'Screen',
    'Kitchen',
  ];





  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          body:SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8,left: 8,right: 8,),
                child: ClipRRect(
                  borderRadius: circularBorder,
                  //putting the column inside a container to take control of card's color
                  child: Container(
                    color: card_backgrund,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16,left:16,right: 16,),
                          child: DropdownButton(
                            value: hallCategory,
                            hint: Text('Chosse hall category'),
                            isExpanded: true,
                            onChanged: ( NewValue) {
                              setState(() {
                                this.hallCategory = NewValue;
                              });
                            },
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                child: Text('Event hall'),
                                value: 'Event hall',
                              ),
                              DropdownMenuItem(
                                child: Text('Co-WorkSpace'),
                                value: 'Co-WorkSpace',
                              ),
                              DropdownMenuItem(
                                child: Text('Wedding hall'),
                                value:'Wedding hall' ,
                              ),
                              DropdownMenuItem(
                                child: Text('Studio'),
                                value: 'Studio',
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 16,left:16,right: 16,),
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
                          padding: const EdgeInsets.only(top: 16,left:16,right: 16,),
                          child: Row(
                            children: <Widget>[
                              Text('Upload hall images'),
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.camera_alt
                                  ),
                                  onPressed: (){
                                    //ToDo 1 : creat upload image from camera function
                                  }
                              ),
                              IconButton(
                                  icon: Icon(
                                      Icons.photo_library
                                  ),
                                  onPressed: (){
                                    //ToDo 2 : creat uploa image from gallary func and try to upload more than one
                                  }
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Add location'
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                  icon: Icon(
                                      Icons.add_location
                                  ),
                                  onPressed: (){
                                    // ToDo 3 : create getLocation methods here
                                  }
                                  ),
                            ],
                          ),
                        )
                    ]
                    ),
                  ),
                ),
              ),

              Padding(
                // the padding is set to be a constant value with all_sides_padding
                padding: const EdgeInsets.only(top: 8,left: 8,right: 8,),
                //using this widget to clip the card corners with a constant value [circularBorder] radius
                child: ClipRRect(
                  borderRadius: circularBorder,
                  //putting the column inside a container to take control of card's color
                  child: Container(
                    color: card_backgrund,
                    child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                    'Properties with Icons'
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(
                                        Icons.minimize
                                    ),
                                    onPressed: (){

                                      setState(() {
                                        if(IconedPropertyFields.length>0){IconedPropertyFields.removeLast();
                                        chosenIcons.removeLast();
                                        IconValue.removeLast();}
                                      });
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(
                                        Icons.add
                                    ),
                                    onPressed: (){
                                      chosenIcons.add(null);
                                      IconValue.add(true);
                                      setState(() {
                                        IconedPropertyFields.add(addIconedProperty(IconedPropertyFields.length,null));
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                          ...IconedPropertyFields
                        ]
                    ),
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
                    child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Properties with name'
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(
                                        Icons.minimize
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        if(NamedPropertiesFields.length>0){NamedPropertiesFields.removeLast();
                                        properties.removeLast();
                                        values.removeLast();
                                        isPropertiesVlaid.removeLast();
                                        isValuesVlaid.removeLast();}

                                      });
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(
                                        Icons.add
                                    ),
                                    onPressed: (){
                                    properties.add(null);
                                    values.add(null);
                                    isPropertiesVlaid.add(true);
                                    isValuesVlaid.add(true);
                                      setState(() {
                                        NamedPropertiesFields.add(addNamedProperty(NamedPropertiesFields.length));
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                          ...NamedPropertiesFields,
                        ]
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8,right: 8,bottom: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: HallProperties.customButton(
                        text: 'Add my hall',
                        context: this.context,
                        onclick: (){

                          setState((){
                            hasError = false;
                          for(int counter =0; counter<properties.length;counter++) {
                            if (properties[counter] == null || properties[counter] =='') {
                              isPropertiesVlaid[counter] = false;
                              hasError = true;
                            } else {
                              isPropertiesVlaid[counter] = true;
                            }
                            if (values[counter] == null || values[counter] =='') {
                              isValuesVlaid[counter] = false;
                              hasError = true;
                            } else {
                              isValuesVlaid[counter] = true;
                            }
                          }
                          if(!hasError){
                            propertiesWithName.clear();
                            for(int counter=0;counter<properties.length;counter++){
                              propertiesWithName[properties[counter]] = values [counter];
                            }
                           print(propertiesWithName);
                          }
                            print(chosenIcons);
                            for(int counter =0; counter<chosenIcons.length;counter++) {
                              if (chosenIcons[counter] == null ||
                                  chosenIcons[counter] == '') {
                                hasError = true;
                              }
                            }

                            if(!hasError){
                              propertiesWithIcon.clear();
                              for(int counter=0;counter<chosenIcons.length;counter++){
                                propertiesWithIcon[IconsData[IconsName.indexOf(chosenIcons[counter])]] = IconValue [counter];
                              }
                              print(propertiesWithIcon);
                            }

                          if(hasError){
                            Toast.show("error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HallScreen(
                                hallObj: Hall(
                                    name: hallName,
                                    category: hallCategory,
                                    namedProperties: propertiesWithName,
                                    propertyIcon: propertiesWithIcon
                                ),
                              )
                              ),
                            );
                          }});
                        }
                      ),
                    ),
                  ],
                ),
              ),
        ],
          ),
      )
      ),
    );
  }




  Widget addNamedProperty(int index){
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
                errorText: true
                    ? null
                    : 'You must enter a property name',
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
                errorText:isValuesVlaid[index]
                    ? null
                    : 'The property must have value',
                border: OutlineInputBorder(),
                labelText: 'value',
              ),
            ),
          ),
        ],
      ),
    );
  }





  int i =0;
  Widget addIconedProperty(int index,String value){
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
                  IconedPropertyFields[index] = addIconedProperty(index,value) ;
               });
              },
            items: IconsName.map((String IconName){
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
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Switch(
                  value: IconValue[index],
                  onChanged: (value){
                   setState(() {
                     print(value);
                     IconValue[index] = value;
                   });
                  },
                ),
              )
          ),

        ],
      ),
    );
  }
}
