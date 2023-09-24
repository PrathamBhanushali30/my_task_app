import 'package:get_storage/get_storage.dart';

class LocalStorage{
  LocalStorage._privateConstructor();
  static final LocalStorage instance = LocalStorage._privateConstructor();
  final GetStorage getStorage = GetStorage();

  dynamic read(String key) => getStorage.read(key);

  dynamic write(String key, dynamic value) => getStorage.write(key, value);

  Future remove(String key) => getStorage.remove(key);
}