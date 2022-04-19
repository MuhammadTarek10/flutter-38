class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException implements CloudStorageException {}

class CouldNotGetAllNotesException implements CloudStorageException {}

class CloudNotUpdateNoteException implements CloudStorageException {}

class CloudNotDeleteNoteException implements CloudStorageException {}
