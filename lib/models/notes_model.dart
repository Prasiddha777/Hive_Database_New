import 'package:hive/hive.dart';
part 'notes_model.g.dart';

//notes_model.g.dart => g for generated

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  NotesModel({required this.title, required this.description});
}


//for new model TypeId must be ====> 1
// @HiveType(typeId: 1)
// class ContactModel {
//   String title;
//   String description;

//   ContactModel({required this.title, required this.description});
// }


//IMPORTANT 
// EXTENDS HIVE GARYO VANI AFAI LISTEN , SAVE AND AUTOMATIC SCREEN UPDATE GARDINCHA
//YEDI EXTENDS HIVE GARENA VANI SABAI AFAI LAY GARNU PARNI HUNCHA==> Sabai ko ID AFAI MAINTAIN GARNU PARCHA