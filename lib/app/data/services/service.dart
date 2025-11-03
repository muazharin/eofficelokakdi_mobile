import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
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

  Future<File> createFileFromUrl(String path) async {
    Completer<File> completer = Completer();
    try {
      final url = path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<Uint8List> createByteFromUrl(String path) async {
    Uint8List? bytes;
    try {
      final url = path;
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      bytes = await consolidateHttpClientResponseBytes(response);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return bytes;
  }
}
