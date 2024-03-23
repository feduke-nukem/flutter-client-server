BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "users" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "lastName" text NOT NULL
);


--
-- MIGRATION VERSION FOR user_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('user_app', '20240323013037425', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240323013037425', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
