import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';


class PostService {
  String postsNode = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  StorageReference _firebaseStorageRef;
  Map post;
  PostService(this.post);

  uploadPic(_image, imageKey, k) async {
    _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('blogimg/${imageKey + '.' + k}');
    StorageUploadTask uploadTask = _firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
  }

  String addPost() {
    String uniqueKey;
    _databaseReference = database.reference().child(postsNode);
    uniqueKey = _databaseReference.push().key;
    _databaseReference.child(uniqueKey).set(post);
    return uniqueKey;
  }
}
