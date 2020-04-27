import 'package:cloud_firestore/cloud_firestore.dart';

class HallsData {
  final _fireStore = Firestore.instance;
  List<Map<String, dynamic>> co_workspaceHallsList,
      eventHallsList,
      studioHallsList,
      weddingHallsList;

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
}
