alter table "public"."squad" alter column "name" set default concat('Untitled ', TO_CHAR((now())::date, 'dd.mm.yyyy'));
