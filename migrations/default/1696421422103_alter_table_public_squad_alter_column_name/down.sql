alter table "public"."squad" alter column "name" set default concat('Untitled ', to_char(((now())::date)::timestamp with time zone, 'dd,mm,yyyy'::text));
