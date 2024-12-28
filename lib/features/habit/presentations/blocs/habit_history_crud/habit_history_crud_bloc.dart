import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/habit_history_model.dart';
import '../../../data/repositories/habit_ai_repo_impl.dart';
import '../../../domain/entities/habit_history.dart';
import '../../../domain/repositories/habit_history_repository.dart';

part 'habit_history_crud_event.dart';
part 'habit_history_crud_state.dart';

class HabitHistoryCrudBloc
    extends Bloc<HabitHistoryCrudEvent, HabitHistoryCrudState> {
  final HabitHistoryRepository habitHistoryRepository;
  HabitHistoryCrudBloc(this.habitHistoryRepository)
      : super(HabitHistoryCrudInitial()) {
    on<HabitHistoryCrudCreate>(_onCreateHistory);
    on<HabitHistoryCrudListByHabitId>(_onGetHistoriesByHabitId);
    on<AddWaterHabitHistory>(_onAddWaterHabit);
  }

  final _appLogger = getIt.get<AppLogger>();

  FutureOr<void> _onCreateHistory(
      HabitHistoryCrudCreate event, Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      await habitHistoryRepository
          .createHabitHistory(HabitHistoryModel.fromEntity(event.habitHistory));

      final createdHistory = await habitHistoryRepository
          .getHabitHistoryById(event.habitHistory.id);

      if (createdHistory == null) {
        emit(HabitHistoryCrudFailure(S.current.cannot_store_history));
      } else {
        emit(
          HabitHistoryCrudSuccess(
              HabitHistoryCrudEventType.create, [createdHistory.toEntity()]),
        );
      }
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetHistoriesByHabitId(HabitHistoryCrudListByHabitId event,
      Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final histories = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      emit(HabitHistoryCrudSuccess(HabitHistoryCrudEventType.list,
          histories.map((e) => e.toEntity()).toList()));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }

  FutureOr<void> _onAddWaterHabit(
      AddWaterHabitHistory event, Emitter<HabitHistoryCrudState> emit) async {
    emit(HabitHistoryCrudInProgress());
    try {
      final histories = await habitHistoryRepository
          .getHabitHistoriesByHabitId(event.habitId);

      final todayHistory = histories.firstWhere(
        (element) =>
            element.date.toMoment().isAtSameDayAs(DateTime.now().toMoment()),
        orElse: () => HabitHistoryModel.fromEntity(HabitHistory.init()),
      );

      todayHistory.copyWith(
        habitId: event.habitId,
        quantity: () => ((todayHistory.quantity ?? 0) + event.quantity),
      );

      emit(HabitHistoryCrudSuccess(
          HabitHistoryCrudEventType.update, [todayHistory.toEntity()]));
    } catch (e) {
      _appLogger.e(e.toString());
      emit(HabitHistoryCrudFailure(e.toString()));
    }
  }
}
