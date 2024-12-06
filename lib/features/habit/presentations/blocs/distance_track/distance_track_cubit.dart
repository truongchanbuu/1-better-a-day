import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/tracking_status.dart';

part 'distance_track_state.dart';

class DistanceTrackCubit extends Cubit<DistanceTrackState> {
  final double targetDistance;
  DistanceTrackCubit({required this.targetDistance})
      : super(DistanceTrackInitial(targetDistance: targetDistance));
}
