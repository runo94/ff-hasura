SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
CREATE TABLE public.matches (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    g_team_id uuid NOT NULL,
    h_team_id uuid NOT NULL,
    result character varying(255) NOT NULL,
    w_team_id uuid NOT NULL,
    tournament_id uuid NOT NULL
);
CREATE TABLE public.squad (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    captain_id uuid NOT NULL
);
CREATE TABLE public.squad_match (
    match_id uuid NOT NULL,
    squad_id uuid NOT NULL
);
CREATE TABLE public.squad_team (
    team_id uuid NOT NULL,
    squad_id uuid NOT NULL
);
CREATE TABLE public.squad_user (
    user_id uuid NOT NULL,
    squad_id uuid NOT NULL
);
CREATE TABLE public.teams (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    manager_id uuid NOT NULL
);
CREATE TABLE public.tournaments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL
);
CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);
ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.squad
    ADD CONSTRAINT squad_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_g_team_id_fkey FOREIGN KEY (g_team_id) REFERENCES public.teams(id);
ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_h_team_id_fkey FOREIGN KEY (h_team_id) REFERENCES public.teams(id);
ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);
ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_w_team_id_fkey FOREIGN KEY (w_team_id) REFERENCES public.teams(id);
ALTER TABLE ONLY public.squad
    ADD CONSTRAINT squad_captain_id_fkey FOREIGN KEY (captain_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.squad_match
    ADD CONSTRAINT squad_match_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(id);
ALTER TABLE ONLY public.squad_match
    ADD CONSTRAINT squad_match_squad_id_fkey FOREIGN KEY (squad_id) REFERENCES public.squad(id);
ALTER TABLE ONLY public.squad_team
    ADD CONSTRAINT squad_team_squad_id_fkey FOREIGN KEY (squad_id) REFERENCES public.squad(id);
ALTER TABLE ONLY public.squad_team
    ADD CONSTRAINT squad_team_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);
ALTER TABLE ONLY public.squad_user
    ADD CONSTRAINT squad_user_squad_id_fkey FOREIGN KEY (squad_id) REFERENCES public.squad(id);
ALTER TABLE ONLY public.squad_user
    ADD CONSTRAINT squad_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);
