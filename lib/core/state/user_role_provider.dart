import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

enum AppUserRole {
  customer, // Standard vehicle driver / Help seeker
  partner,  // Registered Mechanic / Towing operator
  admin,    // Fleet Controller & Emergency Ops Dispatcher
}

class UserRoleNotifier extends Notifier<AppUserRole> {
  @override
  AppUserRole build() {
    _loadSavedRole();
    return AppUserRole.customer;
  }

  Future<void> _loadSavedRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleStr = prefs.getString(AppConstants.keyUserRole) ?? 'customer';
      if (roleStr == 'partner') {
        state = AppUserRole.partner;
      } else if (roleStr == 'admin') {
        state = AppUserRole.admin;
      } else {
        state = AppUserRole.customer;
      }
    } catch (_) {}
  }

  Future<void> setRole(AppUserRole role) async {
    state = role;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserRole, role.name);
    } catch (_) {}
  }
}

final userRoleProvider = NotifierProvider<UserRoleNotifier, AppUserRole>(UserRoleNotifier.new);
