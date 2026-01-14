# Database Schema

## Overview
The database uses PostgreSQL with JSONB for flexible game state storage.

## Tables

### Games
Primary table for game sessions.

```sql
CREATE TABLE games (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status VARCHAR(20) NOT NULL, -- 'setup', 'in_progress', 'completed'
    current_round INTEGER NOT NULL DEFAULT 1,
    winner VARCHAR(20), -- 'agent', 'hunters', null
    game_state JSONB NOT NULL,
    settings JSONB NOT NULL
);
```

### Players
Players participating in a game.

```sql
CREATE TABLE players (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    username VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL, -- 'agent', 'hunter'
    character_id VARCHAR(50),
    is_active BOOLEAN NOT NULL DEFAULT true,
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### GameMoves
Movement and action history.

```sql
CREATE TABLE game_moves (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id),
    round_number INTEGER NOT NULL,
    move_number INTEGER NOT NULL,
    move_type VARCHAR(50) NOT NULL, -- 'move', 'ability', 'equipment', 'reveal'
    move_data JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

## JSONB Schemas

### game_state
```json
{
  "board": "museum",
  "agentPosition": { "x": 10, "y": 15 },
  "agentRevealed": false,
  "hunterPositions": [
    { "playerId": "uuid", "x": 5, "y": 5 }
  ],
  "missionProgress": {
    "objectivesCompleted": 0,
    "totalObjectives": 3,
    "completedObjectiveIds": []
  },
  "equipmentState": {
    "agentCards": ["disguise", "flash_grenade"],
    "hunterCards": ["motion_sensor", "radar"]
  }
}
```

### settings
```json
{
  "board": "museum",
  "missionId": "classic",
  "maxRounds": 40,
  "hunterCount": 4,
  "variant": "standard"
}
```

## Indexes
```sql
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_players_game_id ON players(game_id);
CREATE INDEX idx_game_moves_game_id ON game_moves(game_id);
CREATE INDEX idx_game_moves_round ON game_moves(game_id, round_number);
```
