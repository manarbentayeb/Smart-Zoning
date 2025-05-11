// lib/app/services/API_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Base URL for your FastAPI backend
  static const String baseUrl = 'http://10.80.4.216:8000';

  // Key constants for SharedPreferences
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'isLoggedIn';

  // Logout method
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Get logged in user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userDataKey);
    if (userData != null) {
      return jsonDecode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<Map<String, dynamic>> signUp({
    required String fullname,
    required String email,
    required String phone,
    required String manager,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'manager': manager,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      
      if (response.statusCode == 201) {
        // Save user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userDataKey, jsonEncode(responseData['user']));
        await prefs.setBool(_isLoggedInKey, true);
        
        return {
          'success': true, 
          'message': responseData['message'].toString(), 
          'user': responseData['user'],
        };
      } else {
        return {
          'success': false, 
          'message': (responseData['detail'] ?? 'Registration failed').toString(),
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false, 
        'message': 'Network error: $e',
        'statusCode': 500,
      };
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      
      if (response.statusCode == 200) {
        // Save user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userDataKey, jsonEncode(responseData['user']));
        await prefs.setBool(_isLoggedInKey, true);
        
        return {
          'success': true, 
          'message': responseData['message'].toString(), 
          'user': responseData['user'],
        };
      } else {
        return {
          'success': false, 
          'message': (responseData['detail'] ?? 'Login failed').toString(),
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false, 
        'message': 'Network error: $e',
        'statusCode': 500,
      };
    }
  }
}