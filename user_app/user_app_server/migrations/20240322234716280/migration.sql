BEGIN;


--
-- MIGRATION VERSION FOR user_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('user_app', '20240322234716280', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240322234716280', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
