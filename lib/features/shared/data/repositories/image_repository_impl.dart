import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final String _baseDirectory;

  ImageRepositoryImpl({String? baseDirectory})
      : _baseDirectory = baseDirectory ?? 'images';

  @override
  Future<String> saveImage(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final savePath =
          '${directory.path}/$_baseDirectory/${path.basename(imageFile.path)}';

      await Directory(path.dirname(savePath)).create(recursive: true);
      await imageFile.copy(savePath);
      return imageFile.path;
    } catch (e) {
      throw ImageStorageException('Failed to save image: $e');
    }
  }

  @override
  Future<Uint8List?> getImage(String path) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fullPath = '${directory.path}/$_baseDirectory/$path';
      final file = File(fullPath);

      if (!await file.exists()) return null;
      return await file.readAsBytes();
    } catch (e) {
      throw ImageStorageException('Failed to read image: $e');
    }
  }

  @override
  Future<void> deleteImage(String path) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fullPath = '${directory.path}/$_baseDirectory/$path';
      final file = File(fullPath);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw ImageStorageException('Failed to delete image: $e');
    }
  }

  @override
  Future<File?> createTmpFile(String p) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = path.basename(p);
      final tempFile = File('${tempDir.path}/$fileName');

      final imageData = await getImage(p);
      if (imageData == null) return null;

      await tempFile.writeAsBytes(imageData);
      return tempFile;
    } catch (e) {
      throw ImageStorageException('Failed to create temp file: $e');
    }
  }
}

class ImageStorageException implements Exception {
  final String message;
  ImageStorageException(this.message);

  @override
  String toString() => message;
}
