alter table "public"."matches" add column "date" date
 not null default now();
