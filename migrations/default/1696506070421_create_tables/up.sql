SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NOT NULL
);

CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    manager_id UUID REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE squad (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TIME NOT NULL,
    captain_id UUID REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE tournaments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    date_start DATE NOT NULL,
    date_end DATE NOT NULL
);

CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    g_team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    h_team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    score VARCHAR(255) NOT NULL,
    w_team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE
);

CREATE TABLE squad_team (
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    squad_id UUID REFERENCES squad(id) ON DELETE CASCADE
);

CREATE TABLE squad_match (
    match_id UUID REFERENCES matches(id) ON DELETE CASCADE,
    squad_id UUID REFERENCES squad(id) ON DELETE CASCADE
);

CREATE TABLE squad_user (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    squad_id UUID REFERENCES squad(id) ON DELETE CASCADE
);

CREATE TABLE team_user (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE
);
