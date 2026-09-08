import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/user_data.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/profile_services.dart';
import 'package:velora/services/storage_services.dart';

part 'profile_state.dart';



class ProfileCubit extends Cubit<ProfileState> {
  final ProfileServices profileServices;
  final AuthServices authServices;
  final storageServices = StorageServicesImpl();

  ProfileCubit({
    required this.profileServices,
    required this.authServices,
  }) : super(const ProfileState());
  
  Future<void> updateProfilePicture(File imageFile) async {
  debugPrint('🟡 STEP 1: updateProfilePicture called, path: ${imageFile.path}');
    final currentUser = authServices.currentUser();
    final currentData = state.userData;
    if (currentUser == null || currentData == null) return;
    debugPrint('🔴 STOPPED: currentUser or currentData is null');

    try {
        debugPrint('🟡 STEP 2: uploading to Cloudinary...');

      final photoUrl = await storageServices.uploadProfileImage(
        currentUser.uid,
        imageFile,
      );
          debugPrint('🟢 STEP 3: got new URL from Cloudinary: $photoUrl');


      await profileServices.updatePhotoUrl(currentUser.uid, photoUrl);
    debugPrint('🟢 STEP 4: Firestore updated');

      emit(state.copyWith(
        userData: currentData.copyWith(photoUrl: photoUrl),
      ));
          debugPrint('🟢 STEP 5: state emitted with new photoUrl');

    } catch (e) {
          debugPrint('🔴 ERROR at some step: $e');

      emit(state.copyWith(errorMessage: 'Failed to update photo: $e'));
    }
  }
  Future<void> loadProfile() async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'User is not authenticated',
      ));
      return;
    }

    emit(state.copyWith(status: ProfileStatus.loading, clearErrorMessage: true));

    try {
      final userData = await profileServices.fetchUserData(currentUser.uid);
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        userData: userData,
        isProfileIncomplete: false,
        clearErrorMessage: true,
      ));
    } on UserNotFoundException {
  final fallbackUser = UserData(
    id: currentUser.uid,
    name: currentUser.displayName ?? '',
    email: currentUser.email ?? '',
    phone: currentUser.phoneNumber ?? '',
  );
  emit(state.copyWith(
    status: ProfileStatus.loaded,
    userData: fallbackUser,
    isProfileIncomplete: true,
    clearErrorMessage: true,
  ));
}catch (e) {
      // 🔥 مفيش document في Firestore — نبني بيانات مؤقتة من الـ Auth بس
      final fallbackUser = UserData(
        id: currentUser.uid,
        name: currentUser.displayName ?? '',
        email: currentUser.email ?? '',
        phone: currentUser.phoneNumber ?? '',
      );
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        userData: fallbackUser,
        isProfileIncomplete: true, // 🔥 الـ UI هيستخدمها عشان يعرض رسالة
        clearErrorMessage: true,
      ));
    }
  }
  
}
