import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class StorageServices {
  Future<String> uploadProfileImage(String uid, File imageFile);
}

class StorageServicesImpl implements StorageServices {
  static const String _cloudName = 'i46pow8a';
  static const String _uploadPreset = 'velora_profile_pics';

  @override
Future<String> uploadProfileImage(String uid, File imageFile) async {
  final uri = Uri.parse(
    'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
  );

  final timestamp = DateTime.now().millisecondsSinceEpoch; // 🔥 جديد

  final request = http.MultipartRequest('POST', uri)
    ..fields['upload_preset'] = _uploadPreset
    ..fields['public_id'] = 'profile_images/${uid}_$timestamp' // 🔥 اسم مختلف كل رفعة
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();

  if (response.statusCode != 200) {
    final body = await response.stream.bytesToString();
    throw Exception('Cloudinary upload failed: $body');
  }

  final responseBody = await response.stream.bytesToString();
  final decoded = jsonDecode(responseBody) as Map<String, dynamic>;

  return decoded['secure_url'] as String;
}
}