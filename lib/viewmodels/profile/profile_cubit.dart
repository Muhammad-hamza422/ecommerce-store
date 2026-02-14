import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api/user_service.dart';
import '../../services/storage/secure_storage.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserService userService;
  final SecureStorage secureStorage;

  ProfileCubit({
    required this.userService,
    required this.secureStorage,
  }) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final user = await userService.getCurrentUser(secureStorage);
      if (user == null) {
        emit(state.copyWith(status: ProfileStatus.error, errorMessage: 'User not found'));
      } else {
        emit(state.copyWith(status: ProfileStatus.loaded, user: user));
      }
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }
}


