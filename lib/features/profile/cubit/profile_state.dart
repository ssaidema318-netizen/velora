part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState {
  final ProfileStatus status;
  final UserData? userData;
  final bool isProfileIncomplete; // 🔥 جديد
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userData,
    this.isProfileIncomplete = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserData? userData,
    bool? isProfileIncomplete,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      isProfileIncomplete: isProfileIncomplete ?? this.isProfileIncomplete,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}