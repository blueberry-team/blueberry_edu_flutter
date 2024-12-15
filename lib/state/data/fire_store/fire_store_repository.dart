import 'package:blueberry_edu/state/dto/sign_up_dto.dart';
import 'package:blueberry_edu/state/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireStoreRepositoryProvider = Provider<FireStoreInterface>((ref) {
  return FireStoreRepository(FirebaseFirestore.instance);
});

abstract class FireStoreInterface {
  Future<void> saveUserData(SignUpDto signUpDto);
  Future<UserModel> getUserData(String uid);
}

class FireStoreRepository implements FireStoreInterface {
  final FirebaseFirestore _firebaseFirestore;

  FireStoreRepository(this._firebaseFirestore);

  @override
  Future<void> saveUserData(SignUpDto signUpDto) async {
    await _firebaseFirestore.collection('users').doc(signUpDto.id).set({
      'email': signUpDto.email,
      'name': signUpDto.name,
      'activity': signUpDto.activity,
    });
  }

  @override
  Future<UserModel> getUserData(String uid) async {
    final userData =
        await _firebaseFirestore.collection('users').doc(uid).get();
    return UserModel.fromJson(userData.data() ?? {});
  }
}
