import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = "key";
  static const DATE = "date";
  static const BODY = "body";
  static const BY = "by";
  static const UID = "uid";
  static const EXT = "ext";

  int date;
  String key;
  String body;
  String by;
  String uid;
  String ext;

  Post(this.date, this.body, this.by, this.uid, this.ext);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.body = snap.value[BODY],
        this.date = snap.value[DATE],
        this.by = snap.value[BY],
        this.uid = snap.value[UID],
        this.ext = snap.value[EXT];


  Map toMap() {
    return {BODY: body, DATE: date, BY: by, UID: uid, EXT: ext};
  }
}