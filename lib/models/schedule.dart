import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halls_city/models/reservation.dart';

class Schedule {
//  List<Reservation> reservations;
  Map<String, dynamic> reservations;
  List resevervationNameList;

  Schedule(this.reservations) {
    this.resevervationNameList = reservations.keys.toList();
  }

  void addNewReservation(DateTime start, DateTime end, var reservationName) {
    reservations[reservationName] = [
      Timestamp.fromDate(start),
      Timestamp.fromDate(end)
    ];
  }

  String checkStartingDate(DateTime startDate) {
//    String reservationStuckedWith = null;
    if (resevervationNameList.isEmpty) {
      return null;
    } else {
      for (int counter = 0; counter < resevervationNameList.length; counter++) {
//      print(time[0].toDate());
//      print(time[1].toDate());
//      print('');
//      print(startDate);
//      print(reservationName);
//      print(' names lit $resevervationNameList');
//      print(reservations[resevervationNameList[counter]]);
        if (startDate.isAtSameMomentAs(
            reservations[resevervationNameList[counter]][0].toDate())) {
          return resevervationNameList[counter];
        } else if (startDate.isAtSameMomentAs(
            reservations[resevervationNameList[counter]][1].toDate())) {
        } else {
//        print(
//            'is the value after the start : ${startDate.isAfter(reservations[resevervationNameList[counter]][0].toDate())}');
          if (startDate.isAfter(
              reservations[resevervationNameList[counter]][0].toDate())) {
//          print(
//              'is the value berfor the end : ${startDate.isBefore(reservations[resevervationNameList[counter]][1].toDate())}');
            if (startDate.isBefore(
                reservations[resevervationNameList[counter]][1].toDate())) {
//            print(reservations[resevervationNameList[counter]]);
              return resevervationNameList[counter];
            }
//          print('returned');
          }
        }
      }

      return null;
    }
  }

  String checkEndDate(DateTime endDate) {
    if (resevervationNameList.isEmpty) {
      return null;
    } else {
      for (int counter = 0; counter < resevervationNameList.length; counter++) {
        if (endDate.isAtSameMomentAs(
            reservations[resevervationNameList[counter]][1].toDate())) {
          return resevervationNameList[counter];
        } else if (endDate.isAtSameMomentAs(
            reservations[resevervationNameList[counter]][0].toDate())) {
        } else {
          if (endDate.isAfter(
              reservations[resevervationNameList[counter]][0].toDate())) {
            if (endDate.isBefore(
                reservations[resevervationNameList[counter]][1].toDate())) {
              return resevervationNameList[counter];
            }
          }
        }
      }
//    for (int counter = 0; counter < reservations.length; counter++) {
//      Reservation a_reservation = reservations[counter];
//
//      if (endDate.isAtSameMomentAs(a_reservation.end)) {
//        return a_reservation;
//      } else if (endDate.isAtSameMomentAs(a_reservation.start)) {
//        return null;
//      } else {
//        if (endDate.isAfter(a_reservation.start)) {
//          if (endDate.isBefore(a_reservation.end)) {
//            return a_reservation;
//          }
//        }
//      }
//    }
      return null;
    }
  }
}
