abstract class StorageService {
  Future<void> deleteNote({required String id});
  Future<T> updateNote<T>({
    required T noteOrId,
    required String text,
  });
  Stream<Iterable<T>> getAllNote<T>({String owner=''});
  Future<T> getNote<T>({required T id});
  Future<T> createNote<T>({required T owner});

}
