BEGIN;


--
-- MIGRATION VERSION FOR user_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('user_app', '20240323011128390', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240323011128390', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20240323012834349', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240323012834349', "timestamp" = now();


COMMIT;
