import 'package:shared_preferences/shared_preferences.dart';

setLang(String landCode) async {
  SharedPreferences langStorage = await SharedPreferences.getInstance();
  await langStorage.setString('langCode', landCode);
}
