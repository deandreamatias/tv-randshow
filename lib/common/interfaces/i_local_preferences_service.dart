abstract class ILocalPreferencesService {
  Future<T?> read<T>({required String key});
  Future<bool> write<T>({required String key, required T value});
}
