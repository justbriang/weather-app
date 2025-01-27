abstract class BaseRepository<T> {
  Future<T> fetch(String id);
  Future<List<T>> fetchAll();
  Future<void> save(T item);
  Future<void> delete(String id);
  Future<void> update(T item);
}