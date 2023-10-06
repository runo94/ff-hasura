alter table "public"."squad" alter column "name" set default concat('Unnamed ', to_char(now(), 'DD,MONTH,YYYY'::text));
