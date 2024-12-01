import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hl_image_picker/hl_image_picker.dart';

import '../../../../core/constants/app_color.dart';
import '../../../auth/domain/entities/user.dart';
import '../bloc/update_info_cubit.dart';

class UserAvatar extends StatelessWidget {
  final UserEntity user;
  final double size;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Color? fallbackBackgroundColor;
  final Color? fallbackTextColor;
  final String defaultInitial;

  const UserAvatar({
    super.key,
    required this.user,
    this.size = 130,
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.fallbackBackgroundColor,
    this.fallbackTextColor,
    this.defaultInitial = 'U',
  });

  String get _cacheKey => '${user.id}_${user.avatarUrl}';

  bool get _hasValidAvatar =>
      user.avatarUrl != null && (user.avatarUrl?.trim().isNotEmpty ?? false);

  bool get _hasValidUsername =>
      user.username != null && (user.username?.trim().isNotEmpty ?? false);

  bool get _isUrl =>
      user.avatarUrl != null &&
      (user.avatarUrl!.startsWith('http') ||
          user.avatarUrl!.startsWith('https'));

  String _getInitials() {
    if (!_hasValidUsername) return defaultInitial;

    final nameParts = user.username!.trim().split(' ');
    if (nameParts.isEmpty) return defaultInitial;

    if (nameParts.length >= 2) {
      return '${_getValidCharacter(nameParts[0])}${_getValidCharacter(nameParts[1])}'
          .toUpperCase();
    }
    return _getValidCharacter(nameParts[0]).toUpperCase();
  }

  String _getValidCharacter(String input) {
    if (input.isEmpty) return defaultInitial;
    return input[0];
  }

  ImageProvider _buildImage(String path) {
    if (_isUrl) {
      return CachedNetworkImageProvider(
        path,
        cacheKey: _cacheKey,
      );
    }

    return FileImage(File(path));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPickImage(context),
      child: AdvancedAvatar(
        autoTextSize: true,
        animated: true,
        name: _hasValidUsername ? user.username : null,
        size: size,
        statusSize: size * 0.2,
        style: TextStyle(
          color: fallbackTextColor ?? Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: fallbackBackgroundColor ?? AppColors.primary,
          shape: BoxShape.circle,
        ),
        image: _hasValidAvatar ? _buildImage(user.avatarUrl!) : null,
        child: _hasValidAvatar
            ? (loadingWidget ??
                const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ))
            : Text(_getInitials()),
      ),
    );
  }

  Future<void> _onPickImage(BuildContext context) async {
    final updateInfoCubit = context.read<UpdateInfoCubit>();
    final HLImagePicker picker = HLImagePicker();

    final List<HLPickerItem> images = await picker.openPicker(
      cropping: true,
      cropOptions: const HLCropOptions(
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 0.9,
        croppingStyle: CroppingStyle.circular,
      ),
      pickerOptions: const HLPickerOptions(
        mediaType: MediaType.image,
        maxSelectedAssets: 1,
        maxFileSize: 100,
        enablePreview: true,
        usedCameraButton: true,
      ),
    );

    await updateInfoCubit.updatePhotoUrl(images.first.path);
  }
}
