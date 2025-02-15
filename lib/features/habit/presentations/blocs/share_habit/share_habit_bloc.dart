import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/constants/app_common.dart';
import '../../../../../core/helpers/permission_helper.dart';
import '../../../../../generated/l10n.dart';

part 'share_habit_event.dart';
part 'share_habit_state.dart';

class ShareHabitBloc extends Bloc<ShareHabitEvent, ShareHabitState> {
  ShareHabitBloc() : super(ShareHabitInitial()) {
    on<ShareHabitToSocial>(_onShareToFacebook);
    on<SaveImage>(_onSaveImage);
  }

  Future<void> _onSaveImage(
    SaveImage event,
    Emitter<ShareHabitState> emit,
  ) async {
    try {
      emit(ShareHabitLoading());

      // Request storage permission
      final status =
          await PermissionHelper.checkAndRequestPermission(Permission.photos);
      if (status.isDenied ||
          status.isPermanentlyDenied ||
          status.isRestricted ||
          status.isLimited) {
        emit(ShareHabitFailure(S.current.storage_permission_denied));
        return;
      }

      // Capture the widget
      final RenderRepaintBoundary boundary = event.screenshotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final bytes = byteData.buffer.asUint8List();

        // Save to gallery
        final result = await ImageGallerySaverPlus.saveImage(
          bytes,
          name:
              '${event.name ?? 'habit'}_${DateTime.now().millisecondsSinceEpoch}',
          quality: 100,
        );

        if (result['isSuccess']) {
          emit(SaveSuccess(result['filePath']));
        } else {
          emit(ShareHabitFailure('Failed to save image to gallery'));
        }
      } else {
        emit(ShareHabitFailure('Failed to generate image'));
      }
    } catch (e) {
      emit(ShareHabitFailure(e.toString()));
    }
  }

  Future<void> _onShareToFacebook(
    ShareHabitToSocial event,
    Emitter<ShareHabitState> emit,
  ) async {
    try {
      emit(ShareHabitLoading());

      final String? imagePath = await _captureWidget(event.screenshotKey);

      if (imagePath != null) {
        final XFile file = XFile(imagePath);

        await Share.shareXFiles(
          [file],
          subject: event.subject ??
              S.current.default_share_subject(AppCommons.appName),
          text: event.content ??
              S.current.default_share_content(AppCommons.appName),
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
