import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:thuga/data/local/local_base_services.dart';
import 'package:thuga/data/local/sembast_database_opener.dart';

part 'sembast_services.g.dart';

@Riverpod(keepAlive: true)
SembastServices sembastServices(Ref ref) {
  return SembastServices();
}

class SembastServices extends LocalBaseServices {
  String dbPath = 'track_eats_app.db';
  final _tokenStore = StoreRef<String, Map<String, dynamic>>('auth_tokens');
  final _userStatus = StoreRef<String, String>('user_status');
  final _onboardedStatus = StoreRef<String, bool>('onboarded_status');
  final _reminderStore = StoreRef<String, String>('reminder_shown');
  final _completeProfileFromHome = StoreRef<String, bool>(
    'complete_profile_from_home',
  );
  final _calculationBillsStore =
      StoreRef<String, Map<String, dynamic>>('calculation_bills');

  Database? _db;
  Future<void>? _opening;

  Future<Database> _ensureDb() async {
    if (_db != null) return _db!;
    _opening ??= _openDatabase();
    await _opening;
    return _db!;
  }

  Future<void> _openDatabase() async {
    _db = await openSembastDatabase(dbPath);
    debugPrint('🟢 SEMBAST: database opened');
  }

  @override
  Future<void> deleteUserData() async {}

  @override
  Future<void> getUserData() async {}

  @override
  Future<void> initialize() async {
    await _ensureDb();
  }

  @override
  Future<void> insertUserData() async {}

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final database = await _ensureDb();
      debugPrint(
        '🔍 SEMBAST SAVE: access="$accessToken", refresh="$refreshToken"',
      );
      await _tokenStore.record('tokens').put(database, {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      });
      debugPrint('🔍 SEMBAST SAVE: success');
    } catch (e) {
      debugPrint('🔴 SEMBAST SAVE ERROR: $e');
    }
  }

  @override
  Future<void> saveUser({required bool isNewUser}) async {
    try {
      final database = await _ensureDb();
      await _userStatus.record('isNewUser').put(database, isNewUser.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<bool> isNewUser() async {
    final database = await _ensureDb();
    final status = await _userStatus.record('isNewUser').get(database);
    return status == 'true';
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      final database = await _ensureDb();
      final token = await _tokenStore.record('tokens').get(database);
      debugPrint('🔍 SEMBAST READ: raw record=$token');
      final result = token?['accessToken'];
      debugPrint('🔍 SEMBAST READ: accessToken="$result"');
      return result;
    } catch (e) {
      debugPrint('🔴 SEMBAST READ ERROR: $e');
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final database = await _ensureDb();
      final token = await _tokenStore.record('tokens').get(database);
      return token?['refreshToken'];
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserId(String userId) async {
    try {
      final database = await _ensureDb();
      await _tokenStore.record('userId').put(database, {'userId': userId});
    } catch (e) {
      debugPrint('saveUserId error: $e');
    }
  }

  Future<String?> getUserId() async {
    try {
      final database = await _ensureDb();
      final record = await _tokenStore.record('userId').get(database);
      return record?['userId'];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> clearLocalDb() async {
    try {
      final database = await _ensureDb();
      await _userStatus.delete(database);
      await _tokenStore.delete(database);
      await _reminderStore.delete(database);
      await _completeProfileFromHome.delete(database);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateOnboardedStatus(bool value) async {
    try {
      final database = await _ensureDb();
      await _onboardedStatus.record('onboarded_status').put(database, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> getOnboardedStatus() async {
    try {
      final database = await _ensureDb();
      final onboardedStatus = await _onboardedStatus
          .record('onboarded_status')
          .get(database);
      return onboardedStatus ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setLastReminderShown(String mealLabel, DateTime time) async {
    try {
      final database = await _ensureDb();
      await _reminderStore.record(mealLabel).put(database, time.toIso8601String());
    } catch (e) {
      debugPrint('setLastReminderShown error: $e');
    }
  }

  Future<DateTime?> getLastReminderShown(String mealLabel) async {
    try {
      final database = await _ensureDb();
      final iso = await _reminderStore.record(mealLabel).get(database);
      if (iso == null) return null;
      return DateTime.tryParse(iso);
    } catch (e) {
      debugPrint('getLastReminderShown error: $e');
      return null;
    }
  }

  Future<void> removeCompleteProfileFromHome(bool value) async {
    try {
      final database = await _ensureDb();
      await _completeProfileFromHome
          .record('remove_complete_profile_from_home')
          .put(database, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> getCompleteProfileFromHome() async {
    try {
      final database = await _ensureDb();
      final onboardedStatus = await _completeProfileFromHome
          .record('remove_complete_profile_from_home')
          .get(database);
      return onboardedStatus ?? false;
    } catch (e) {
      debugPrint('getCompleteProfileFromHome error: $e');
      return false;
    }
  }

  Future<void> saveCalculationBill(Map<String, dynamic> billJson) async {
    try {
      final id = billJson['id']?.toString();
      if (id == null || id.isEmpty) return;
      final database = await _ensureDb();
      await _calculationBillsStore.record(id).put(database, billJson);
      debugPrint('🟢 SEMBAST: calculation bill saved id=$id');
    } catch (e) {
      debugPrint('🔴 SEMBAST saveCalculationBill error: $e');
    }
  }

  Future<Map<String, dynamic>?> getCalculationBill(String id) async {
    try {
      final database = await _ensureDb();
      return await _calculationBillsStore.record(id).get(database);
    } catch (e) {
      debugPrint('🔴 SEMBAST getCalculationBill error: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllCalculationBills() async {
    try {
      final database = await _ensureDb();
      final records = await _calculationBillsStore.find(database);
      return records.map((record) => record.value).toList();
    } catch (e) {
      debugPrint('🔴 SEMBAST getAllCalculationBills error: $e');
      return [];
    }
  }

  Future<void> deleteCalculationBill(String id) async {
    try {
      final database = await _ensureDb();
      await _calculationBillsStore.record(id).delete(database);
      debugPrint('🟢 SEMBAST: calculation bill deleted id=$id');
    } catch (e) {
      debugPrint('🔴 SEMBAST deleteCalculationBill error: $e');
    }
  }
}
