import 'package:auth/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth/models/brew.dart';


class DatabaseService{
final String uid;
DatabaseService({this.uid});
  //colloction reference
  final CollectionReference authCollection= Firestore.instance.collection('Auth');

Future updateUserData(String sugars,String name,int strength)async{
  return await authCollection.document(uid).setData({
    'sugars':sugars,
    'name':name,
    'strength':strength,
  });
}
// brew list from snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
    return Brew(
      name:doc.data['name'] ?? '',
      strength: doc.data['strength'] ?? 0,
      sugars: doc.data['sugars'] ?? '0',
    );
  }).toList();
}
//usetData form snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid:uid,
    name: snapshot.data['name'],
    sugars: snapshot.data['sugars'],
    strength: snapshot.data['strength']
  );
}
//get Brew stream
Stream <List<Brew>> get brews{
  return authCollection.snapshots()
  .map(_brewListFromSnapshot);
}
//get user doc Stream
Stream<UserData> get userData{
  return authCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}
} 