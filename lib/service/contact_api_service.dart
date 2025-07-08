import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../global/model/api_contact.dart';
import '../service/api_service.dart';
import '../service/api_url.dart';

class ContactApiService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<ApiContact>> getContacts(BuildContext context) async {
    print("calling getContacts");
    try {
      final response = await _apiClient.get(
        url: '${ApiUrl.baseUrl}${ApiUrl.getAllContact}',
        isBasic: false,
        showResult: true,
        context: context,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.body as List<dynamic>;
        return jsonList.map((json) => ApiContact.fromJson(json)).toList();
      } else {
        debugPrint('Response: ${response.body}');
        debugPrint('Status Code: ${response.statusCode}');
        throw Exception('Failed to load contacts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching contacts: $e');
      throw Exception('Error fetching contacts: $e');
    }
  }

  static Future<ApiContact> createContact({
    required String name,
    required String phoneNumber,
    required String message,
    String? ringtone,
    File? voiceFile,
    File? photoFile,
    required BuildContext context,
  }) async {
    try {
      // Prepare form data
      Map<String, String> formData = {
        'name': name,
        'phone_number': phoneNumber,
        'message': message,
      };

      if (ringtone != null) {
        formData['ringtone'] = ringtone;
      }

      // Prepare multipart files
      List<MultipartBody> multipartFiles = [];

      if (voiceFile != null) {
        multipartFiles.add(MultipartBody('voice', voiceFile));
      }

      if (photoFile != null) {
        multipartFiles.add(MultipartBody('photo', photoFile));
      }

      final response = await _apiClient.multipartRequest(
        url: '${ApiUrl.baseUrl}${ApiUrl.getAllContact}',
        reqType: 'POST',
        isBasic: false,
        body: formData,
        multipartBody: multipartFiles,
        showResult: true,
      );

      if (response.statusCode == 201) {
        return ApiContact.fromJson(response.body);
      } else {
        throw Exception('Failed to create contact: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating contact: $e');
    }
  }

  static Future<ApiContact> updateContact({
    required int id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? message,
    String? ringtone,
    File? voiceFile,
    File? photoFile,
    required BuildContext context,
  }) async {
    try {
      // Prepare form data
      Map<String, String> formData = {};

      if (firstName != null) formData['first_name'] = firstName;
      if (lastName != null) formData['last_name'] = lastName;
      if (phoneNumber != null) formData['phone_number'] = phoneNumber;
      if (message != null) formData['message'] = message;
      if (ringtone != null) formData['ringtone'] = ringtone;

      // Prepare multipart files
      List<MultipartBody> multipartFiles = [];

      if (voiceFile != null) {
        multipartFiles.add(MultipartBody('voice', voiceFile));
      }

      if (photoFile != null) {
        multipartFiles.add(MultipartBody('photo', photoFile));
      }

      final response = await _apiClient.multipartRequest(
        url: '${ApiUrl.baseUrl}${ApiUrl.getAllContact}$id/',
        reqType: 'PATCH',
        isBasic: false,
        body: formData,
        multipartBody: multipartFiles,
        showResult: true,
      );

      if (response.statusCode == 200) {
        return ApiContact.fromJson(response.body);
      } else {
        throw Exception('Failed to update contact: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating contact: $e');
    }
  }

  static Future<bool> deleteContact(int id, BuildContext context) async {
    try {
      final response = await _apiClient.delete(
        url: '${ApiUrl.baseUrl}${ApiUrl.getAllContact}$id/',
        isBasic: false,
        code: 204,
        showResult: true,
      );

      return response != null;
    } catch (e) {
      throw Exception('Error deleting contact: $e');
    }
  }
}
