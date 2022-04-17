const createUserTabelQuery = '''
      CREATE TABLE "user" IF NOT EXISTS (
        "id" INTEGER NOT NULL,
        "email" TEXT NOT NULL UNIQUE,
        PRIMARY KEY("id", AUTOINCREMENT)
      )
      ''';
const createNoteTableQuery = '''
      CREATE TABLE "note" IF NOT EXISTS (
        "id" INTEGER NOT NULL,
        "user_id" INTEGER NOT NULL,
        "text" TEXT,
        "is_synced_with_cloud" INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY("user_id") REFERENCE "user"("id")
        PRIMARY KEY("id", AUTOINCREMENT)
      )
      ''';
