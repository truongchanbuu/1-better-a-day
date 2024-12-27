import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/habit_statistic_model.dart';
import '../../../domain/entities/habit_statistic_entity.dart';
import '../../../domain/entities/habit_statistic_entity.dart';

part 'statistic_crud_event.dart';
part 'statistic_crud_state.dart';

class StatisticCrudBloc extends Bloc<StatisticCrudEvent, StatisticCrudState> {
  StatisticCrudBloc() : super(StatisticCrudInitial()) {
    on<StatisticCrudEvent>((event, emit) {});
  }
}
