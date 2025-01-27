abstract class BaseRepository<T> {
  Future<T> fetch(String id);
}
