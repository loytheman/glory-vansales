import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';

class StoreHelper {
  static const secureStore = FlutterSecureStorage();

  static Future<String?> read(String key) async {
    try {
      return await secureStore.read(key: key);
    } catch (e) {
      Utils.err("Error retrieving key: $key - $e");
      return null;
    }
  }

  static Future<void> write(String key, String value) async {
    try {
      await secureStore.write(key: key, value: value);
    } catch (e) {
      Utils.err("Error saving key: $key - $e");
    }
  }

  static void delete(String key) async {
    try {
      return secureStore.delete(key: key);
    } catch (e) {
      Utils.err("Error retrieving key: $key - $e");
      return null;
    }
  }

  static Future<void> clearStorage() async {
    try {
      await secureStore.deleteAll();
      Utils.log("Storage cleared successfully!");
    } catch (e) {
      Utils.err("Error clearing storage: $e");
    }
  }

  static Future<void> clearCredential() async {
    try {
      final flag = await StoreHelper.read(StoreKey.USE_BIOMETRIC_FLAG);
      await secureStore.deleteAll();
      if (flag != null) {
        await StoreHelper.write(StoreKey.USE_BIOMETRIC_FLAG, flag);
      }
      Utils.log("Credential cleared successfully!");
    } catch (e) {
      Utils.err("Error clearing Credential: $e");
    }
  }

  /////////////////////////////////
  static Future<Company?> readPrefCompany() async {
    Company? c = Company();
    c.id = await StoreHelper.read(StoreKey.PREF_COMPANY_ID);
    c.companyName = await StoreHelper.read(StoreKey.PREF_COMPANY_NAME);
    c.registeredNumber = await StoreHelper.read(StoreKey.PREF_COMPANY_REG_NO);
    if (c.id == null) {
      c = null;
      Utils.log("No readPrefCompany");
    }
    return c;
  }

  static Future<void> writePrefCompany(Company c) async {
    await StoreHelper.write(StoreKey.PREF_COMPANY_ID, c.id ?? '');
    await StoreHelper.write(StoreKey.PREF_COMPANY_NAME, c.companyName ?? '');
    await StoreHelper.write(StoreKey.PREF_COMPANY_REG_NO, c.registeredNumber ?? '');
    return;
  }
}
