import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'share_habit_event.dart';
part 'share_habit_state.dart';

class ShareHabitBloc extends Bloc<ShareHabitEvent, ShareHabitState> {
  ShareHabitBloc() : super(ShareHabitInitial()) {
    on<ShareHabitToFacebook>(_onShareToFacebook);
  }

  Future<void> _onShareToFacebook(
    ShareHabitToFacebook event,
    Emitter<ShareHabitState> emit,
  ) async {
    try {
      emit(ShareHabitLoading());

      final String? imagePath = await _captureWidget(event.screenshotKey);

      if (imagePath != null) {
        final XFile file = XFile(imagePath);

        await Share.shareXFiles(
          [file],
          text: event.content ?? 'Check out my progress on this habit!',
          subject: event.subject ?? 'My Habit Progress',
        );

        emit(ShareHabitSuccess());
      } else {
        emit(ShareHabitFailure('Failed to generate sharing image'));
      }
    } catch (e) {
      emit(ShareHabitFailure(e.toString()));
    }
  }

  Future<String?> _captureWidget(GlobalKey screenshotKey) async {
    try {
      final RenderRepaintBoundary boundary = screenshotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final bytes = byteData.buffer.asUint8List();
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/habit_share.png';

        final File imageFile = File(imagePath);
        await imageFile.writeAsBytes(bytes);

        return imagePath;
      }
      return null;
    } catch (e) {
      throw Exception('Error capturing widget: $e');
    }
  }
}
