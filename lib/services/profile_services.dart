import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/user_data.dart';
import 'package:velora/services/firestore_services.dart';

abstract class ProfileServices {
  Future<UserData> fetchUserData(String uid);
  Future<void> updatePhotoUrl(String uid, String photoUrl);
}

class UserNotFoundException implements Exception {
  final String uid;
  UserNotFoundException(this.uid);

  @override
  String toString() => 'No user document found for uid: $uid';
}

class ProfileServicesImpl implements ProfileServices {
  final FirestoreServices firestoreServices;

  ProfileServicesImpl({required this.firestoreServices});

  @override
  Future<void> updatePhotoUrl(String uid, String photoUrl) async {
    await firestoreServices.updateData(
      path: ApiPaths.user(uid),
      data: {'photoUrl': photoUrl},
    );
  }

  @override
  Future<UserData> fetchUserData(String uid) async {
    final snapshot = await firestoreServices.firestore
        .doc(ApiPaths.user(uid))
        .get();

    if (!snapshot.exists) {
      throw UserNotFoundException(uid);
    }

    return UserData.fromMap(snapshot.data()!);
  }
}