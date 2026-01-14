-- Initial database setup
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Games table with JSONB columns
CREATE TABLE IF NOT EXISTS games (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    player_count INT NOT NULL CHECK (player_count BETWEEN 2 AND 5),
    game_mode VARCHAR(20) NOT NULL,
    current_round INT NOT NULL DEFAULT 1,
    current_phase VARCHAR(10) NOT NULL DEFAULT 'agent',
    game_status VARCHAR(20) NOT NULL DEFAULT 'active',
    completed_at TIMESTAMPTZ,
    
    agent_state JSONB NOT NULL DEFAULT '{}'::jsonb,
    missions JSONB NOT NULL DEFAULT '[]'::jsonb,
    movement_history JSONB NOT NULL DEFAULT '[]'::jsonb,
    hunter_positions JSONB NOT NULL DEFAULT '[]'::jsonb,
    vehicle_state JSONB NOT NULL DEFAULT '{}'::jsonb
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_games_status ON games(game_status);
CREATE INDEX IF NOT EXISTS idx_games_created ON games(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_agent_state ON games USING GIN (agent_state);
CREATE INDEX IF NOT EXISTS idx_movement_history ON games USING GIN (movement_history);

-- Update trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_games_updated_at 
    BEFORE UPDATE ON games
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
