import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:halls_city/Constants.dart';
import 'package:halls_city/UI_componants/hall_properties.dart';
import 'package:halls_city/models/schedule.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

class ReservationScreen extends StatefulWidget {
  DocumentSnapshot hall;
  Schedule hallSchedule;
  Map<String, dynamic> reservations;

  ReservationScreen({this.hall}) {
    reservations = hall.data['schedule'];
    hallSchedule = new Schedule(this.reservations);
  }

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String value;
  bool hasAName = true;
  Firestore _fireStore;
  bool isSatrtingValid = true;
  bool isEndValid = true;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime statrtingDate, endDate;
  String customerName, startDateErrorMessage, EndDateErrorMessage;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    _fireStore = Firestore.instance;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
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
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    onChanged: (value) {
                      customerName = value;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        errorText: hasAName
                            ? null
                            : 'You must enter a reservation name',
                        border: OutlineInputBorder(),
                        labelText: 'Reservation Name',
                        icon: Icon(Icons.perm_identity)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DateTimeField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hoverColor: Colors.cyan,
                      labelText: 'Starting Date',
                      prefixText: 'From: ',
                      alignLabelWithHint: true,
                      errorText: isSatrtingValid ? null : startDateErrorMessage,
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        statrtingDate = DateTime(date.year, date.month,
                            date.day, time.hour, time.minute);
//                      print(statrtingDate);
                        return DateTimeField.combine(date, time);
                      } else {
                        statrtingDate = currentValue;
//                      print(currentValue);
                        return currentValue;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DateTimeField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hoverColor: Colors.cyan,
                      labelText: 'End Date',
                      prefixText: 'To: ',
                      alignLabelWithHint: true,
                      errorText: isEndValid ? null : EndDateErrorMessage,
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        endDate = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                        return DateTimeField.combine(date, time);
                      } else {
                        endDate = currentValue;
                        return currentValue;
                      }
                    },
                  ),
                ),
                HallProperties.customButton(
                    context: this.context,
                    text: ' Summit Reservation ',
                    onclick: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      hasAName = true;
                      isSatrtingValid = true;
                      isEndValid = true;
//                    print(widget.reservations);
                      if (customerName == null) {
                        hasAName = false;
                      } else {
                        hasAName = true;
                      }

                      if (statrtingDate != null) {
//                      print('in the method');
//                      print(
//                          '${widget.hallSchedule.checkStartingDate(statrtingDate)} lolo');
//                      print('out the method');
//                      print(statrtingDate);
                        if (widget.hallSchedule
                                .checkStartingDate(statrtingDate) ==
                            null) {
                          isSatrtingValid = true;
                        } else {
                          isSatrtingValid = false;
                          startDateErrorMessage = 'the hall is reserved from '
                              '${widget.reservations[widget.hallSchedule.checkStartingDate(statrtingDate)][0].toDate().hour}'
                              ' to  ${widget.reservations[widget.hallSchedule.checkStartingDate(statrtingDate)][1].toDate().hour}';
//                        print(startDateErrorMessage);
//                        print(isSatrtingValid);
                        }
                      } else {
//                      print('else');
                        isSatrtingValid = false;
                        startDateErrorMessage = 'please chose a date';
                      }
                      if (isSatrtingValid) {
                        if (endDate != null) {
                          if (statrtingDate.isAfter(endDate)) {
                            isSatrtingValid = false;
                            startDateErrorMessage =
                                'Reservation start time can\'t be after the end time';
                          } else if (statrtingDate.isAtSameMomentAs(endDate)) {
                            isSatrtingValid = false;
                            startDateErrorMessage =
                                'Reservation start time can\'t be the time as the end time';
                          }
                        }
                      }

                      if (endDate != null) {
                        if (endDate.isBefore(statrtingDate)) {
                          isEndValid = false;
                          EndDateErrorMessage =
                              'Reservation end time can\'t be before the satrting time';
                        } else if (endDate.isAtSameMomentAs(statrtingDate)) {
                          isEndValid = false;
                          EndDateErrorMessage =
                              'Reservation end time can\'t be the time as the satrting time';
                        } else {
                          if (widget.hallSchedule.checkEndDate(endDate) ==
                              null) {
                            isEndValid = true;
                          } else {
                            isEndValid = false;
                            EndDateErrorMessage = 'the hall is reserved from '
                                '${widget.reservations[widget.hallSchedule.checkEndDate(endDate)][0].toDate().hour}'
                                ' to  ${widget.reservations[widget.hallSchedule.checkEndDate(endDate)][1].toDate().hour}';
                          }
                        }
                      } else {
                        isEndValid = false;
                        EndDateErrorMessage = 'please chose a date';
                      }
//                    print(hasAName);
//                    print(isSatrtingValid);
                      setState(() {
                        hasAName;
                        isSatrtingValid;
                        isEndValid;
                        startDateErrorMessage;
                        EndDateErrorMessage;
                      });

                      if (hasAName && isSatrtingValid && isEndValid) {
                        widget.hallSchedule.addNewReservation(
                            statrtingDate, endDate, customerName);
                        try {
                          await _fireStore
                              .collection('my app')
                              .document('halls')
                              .collection(widget.hall.data['category'])
                              .document(widget.hall.documentID)
                              .updateData({
                            'schedule': widget.hallSchedule.reservations
                          });
                        } catch (e) {
                          Toast.show(e.toString(), context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                        showDialog<String>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: light_gray_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  title: Text(
                                      'Your reservation have been summitted sucsessfully'),
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
                        widget.reservations = null;
                        widget.hallSchedule = null;
                        widget.hall = null;
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
