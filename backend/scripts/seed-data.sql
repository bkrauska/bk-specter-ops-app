-- Seed data for development and testing

-- Insert test game
INSERT INTO games (id, status, current_round, game_state, settings) VALUES
(
    '123e4567-e89b-12d3-a456-426614174000',
    'setup',
    1,
    '{
        "board": "museum",
        "agentPosition": {"x": 0, "y": 0},
        "agentRevealed": false,
        "hunterPositions": [],
        "missionProgress": {
            "objectivesCompleted": 0,
            "totalObjectives": 3,
            "completedObjectiveIds": []
        },
        "equipmentState": {
            "agentCards": ["disguise", "flash_grenade"],
            "hunterCards": ["motion_sensor", "radar_sweep"]
        }
    }'::jsonb,
    '{
        "board": "museum",
        "missionId": "classic",
        "maxRounds": 40,
        "hunterCount": 4,
        "variant": "standard"
    }'::jsonb
);

-- Insert test players
INSERT INTO players (game_id, user_id, username, role, character_id) VALUES
(
    '123e4567-e89b-12d3-a456-426614174000',
    '223e4567-e89b-12d3-a456-426614174001',
    'TestAgent',
    'agent',
    'shadow'
),
(
    '123e4567-e89b-12d3-a456-426614174000',
    '323e4567-e89b-12d3-a456-426614174002',
    'TestHunter1',
    'hunter',
    'hammer'
),
(
    '123e4567-e89b-12d3-a456-426614174000',
    '423e4567-e89b-12d3-a456-426614174003',
    'TestHunter2',
    'hunter',
    'spotter'
);
