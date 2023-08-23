import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefences {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  
//   Future<void> saveUser(ApiResponse apiResponse) async {
//     final SharedPreferences prefs = await _prefs;
//    await prefs.setString('userdata', 'apiResponse');

   
//   }

//   Future<String>getUserDetails()async{
//     final SharedPreferences prefs = await _prefs;
//     return  await  prefs.getString('userdata');
//   }

// }

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _user_token = 'api_token';
  static const _user_id = 'customer_id';
  static const _username = 'email';
  static const _profileurl = 'logo';
  static const _location_id = 'location';
  static const _language_id = 'language';
  static const _first_name = 'firstname';
  static const _last_name = 'lastname';
  static const _telephone = 'telephone';
  static const _customer_group_id = 'customer_group_id';

//Set SharedPreferences
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setApiToken(String apiToken) async =>
     await  _preferences?.setString(_user_token, apiToken).toString();

  static Future setCustomerId(String customerId) async =>
  await     _preferences?.setString(_user_id, customerId).toString();

  static Future setUsername(String email) async =>
   await    _preferences?.setString(_username, email).toString();

  static Future setProfileUrl(String? logo) async =>
   await    _preferences?.setString(_profileurl, logo ?? "").toString();

  static Future setLocationId(String location) async =>
     await  _preferences?.setString(_location_id, location).toString();

  static Future setLanguageId(String language) async =>
   await   _preferences?.setString(_language_id, language).toString();

  static Future setFirstname(String firstname) async =>
   await    _preferences?.setString(_first_name, firstname).toString();

  static Future setLastname(String lastname) async =>
   await   _preferences?.setString(_last_name, lastname).toString();

  static Future setTelephone(String telephone) async =>
  await    _preferences?.setString(_telephone, telephone).toString();

  static Future setCustomerGroupID(String customerGroupId) async =>
    await   _preferences
          ?.setString(_customer_group_id, customerGroupId)
          .toString();

  //Get String SharedPreferences
  static String? getApiToken() =>
      _preferences?.getString(_user_token).toString();

  static String? getCustomerId() =>
      _preferences!.getString(_user_id).toString();

  static String? getUsername() => _preferences!.getString(_username).toString();

  static String? getProfileUrl() =>
      _preferences!.getString(_profileurl).toString();

  static String? getLocationId() =>
      _preferences!.getString(_location_id).toString();

  static String? getLanguageId() =>
      _preferences?.getString(_language_id).toString();

  static String? getFirstname() =>
      _preferences?.getString(_first_name).toString();

  static String? getLastname() =>
      _preferences?.getString(_last_name).toString();

  static String? getTelephone() =>
      _preferences!.getString(_telephone).toString();

  static String? getCustomerGroupID() =>
      _preferences!.getString(_customer_group_id).toString();
}