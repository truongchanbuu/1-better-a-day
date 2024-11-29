import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/auth_exception.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

part 'update_info_state.dart';

class UpdateInfoCubit extends Cubit<UpdateInfoState> {
  final AuthRepository authRepository;
  UpdateInfoCubit(this.authRepository) : super(UpdateInfoInitial());

  Future<void> _updateInfo(Future<void> Function() updateFn) async {
    try {
      await updateFn();
      emit(UpdateSucceed());
    } on UpdateInfoFailure catch (e) {
      emit(UpdateFailed(e.message));
    }
  }

  Future<void> updateEmail(String email) =>
      _updateInfo(() => authRepository.updateEmail(email));

  Future<void> updateDisplayName(String name) =>
      _updateInfo(() => authRepository.updateDisplayName(name));

  Future<void> updateGender(String gender) =>
      _updateInfo(() => authRepository.updateGender(gender));

  Future<void> updateBirthDate(DateTime date) =>
      _updateInfo(() => authRepository.updateBirthDate(date));

  Future<void> updatePassword(String password) =>
      _updateInfo(() => authRepository.updatePassword(password));

  Future<void> updatePhoneNumber(String phoneNumber) =>
      _updateInfo(() => authRepository.updatePhoneNumber(phoneNumber));
}
