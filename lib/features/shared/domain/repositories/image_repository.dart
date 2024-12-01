import 'dart:io';
import 'dart:typed_data';

abstract interface class ImageRepository {
  Future<String> saveImage(File imageFile);
  Future<Uint8List?> getImage(String path);
  Future<void> deleteImage(String path);
  Future<File?> createTmpFile(String path);
}
