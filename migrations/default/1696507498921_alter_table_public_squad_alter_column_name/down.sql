alter table "public"."squad" alter column "name" set default to_char(now(), 'DD,MONTH,YYYY'::text);
