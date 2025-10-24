import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class AppService {
  Future<File?> compressImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath =
        "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // lower for more compression
    );

    return File(result!.path);
  }

  Future<File> compressFile(File file) async {
    final archive = Archive();
    final bytes = file.readAsBytesSync();
    archive.addFile(
      ArchiveFile(file.path.split('/').last, bytes.length, bytes),
    );

    final tempDir = await getTemporaryDirectory();
    final zipFile = File("${tempDir.path}/${file.uri.pathSegments.last}.zip");
    final zipEncoder = ZipEncoder();
    final zipData = zipEncoder.encode(archive);
    await zipFile.writeAsBytes(zipData);

    return zipFile;
  }
}
