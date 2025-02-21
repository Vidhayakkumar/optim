import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

class ApiUpdateUserDetailsProfile {
  final DioClient _dioClient;
  ApiUpdateUserDetailsProfile(this._dioClient);
  final logger = Logger();

  Future<Map<String, dynamic>> updateUserProfile({
    required String jwtToken,
    File? imageFile,
    required Map<String, dynamic> dto,
  }) async {
    try {
      if (imageFile != null) {
        if (!imageFile.path.endsWith('.jpg') &&
            !imageFile.path.endsWith('.jpeg') &&
            !imageFile.path.endsWith('.png')) {
          throw Exception('Only JPG, JPEG, and PNG image formats are allowed');
        }
      }

      MultipartFile? filePart;
      if (imageFile != null) {
        filePart = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      String dtoJson = jsonEncode(dto);

      FormData formData = FormData.fromMap({
        'dto': dtoJson,
        if (filePart != null) 'file': filePart,
      });

      final response = await _dioClient.dio.put(
        '/employee/profileupdate',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception('Failed to update profile. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('DioException during profile update', error: e);
      if (e.response != null) {
        logger.e('Server response: ${e.response?.data}');
      }
      throw Exception('Error during update profile: ${e.message}');
    } catch (e) {
      logger.e('Unexpected error during profile update', error: e);
      throw Exception('Unexpected error during update profile: $e');
    }
  }
}