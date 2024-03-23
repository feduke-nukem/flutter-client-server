BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "users" DROP COLUMN "lastName";

--
-- MIGRATION VERSION FOR user_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('user_app', '20240323013128794', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240323013128794', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
