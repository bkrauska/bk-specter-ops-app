# API Specification

## Base URL
```
Development: http://localhost:5000/api
Production: https://api.specterops.app/api
```

## Authentication
Not implemented in Phase 1 (local play). Will use JWT in Phase 2.

## REST Endpoints

### Games

#### Create Game
```http
POST /api/games
Content-Type: application/json

{
  "settings": {
    "board": "museum",
    "missionId": "classic",
    "maxRounds": 40,
    "hunterCount": 4
  }
}

Response: 201 Created
{
  "id": "uuid",
  "status": "setup",
  "joinCode": "ABCD1234",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

#### Get Game
```http
GET /api/games/{id}

Response: 200 OK
{
  "id": "uuid",
  "status": "in_progress",
  "currentRound": 5,
  "settings": {...},
  "gameState": {...},
  "players": [...]
}
```

#### Join Game
```http
POST /api/games/{id}/join
Content-Type: application/json

{
  "username": "Player1",
  "role": "hunter"
}

Response: 200 OK
{
  "playerId": "uuid",
  "gameId": "uuid",
  "role": "hunter"
}
```

### Movement

#### Submit Agent Move
```http
POST /api/games/{id}/moves/agent
Content-Type: application/json

{
  "playerId": "uuid",
  "path": [
    { "x": 10, "y": 15 },
    { "x": 11, "y": 15 },
    { "x": 12, "y": 16 }
  ],
  "equipment": "disguise"
}

Response: 200 OK
{
  "success": true,
  "roundNumber": 5,
  "moveNumber": 1
}
```

#### Submit Hunter Move
```http
POST /api/games/{id}/moves/hunter
Content-Type: application/json

{
  "playerId": "uuid",
  "destination": { "x": 8, "y": 10 },
  "equipment": "motion_sensor",
  "targetLocation": { "x": 9, "y": 11 }
}

Response: 200 OK
{
  "success": true,
  "revealed": false,
  "inLineOfSight": false
}
```

### Missions

#### Get Mission Details
```http
GET /api/missions/{id}

Response: 200 OK
{
  "id": "classic",
  "name": "Classic Mission",
  "objectives": [
    {
      "id": "obj1",
      "type": "location",
      "location": { "x": 20, "y": 20 },
      "description": "Reach the vault"
    }
  ],
  "objectivesRequired": 3
}
```

## SignalR Hubs

### GameHub
Real-time game events.

#### Client -> Server Methods
- `JoinGame(gameId, playerId)`
- `LeaveGame(gameId, playerId)`

#### Server -> Client Events
- `PlayerJoined(player)`
- `PlayerLeft(playerId)`
- `MoveMade(moveData)`
- `AgentRevealed(location)`
- `RoundEnded(roundNumber)`
- `GameEnded(winner)`

## Error Responses

```json
{
  "error": {
    "code": "INVALID_MOVE",
    "message": "Movement exceeds character speed limit",
    "details": {
      "maxSpeed": 4,
      "attemptedDistance": 6
    }
  }
}
```

### Error Codes
- `GAME_NOT_FOUND`
- `INVALID_MOVE`
- `PLAYER_NOT_FOUND`
- `GAME_FULL`
- `INVALID_PHASE`
- `EQUIPMENT_NOT_AVAILABLE`
