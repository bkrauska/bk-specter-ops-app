# Coordinate System

## Overview
The game board uses a 2D grid coordinate system for tracking positions.

## Coordinate Format

### Standard Format
```json
{
  "x": 10,
  "y": 15
}
```

### Origin Point
- Origin (0, 0) is at **top-left** corner of the board
- X increases to the right
- Y increases downward

```
(0,0) -----> X
  |
  |
  v
  Y
```

## Board Dimensions

### Museum Board
- Width: 40 spaces (x: 0-39)
- Height: 30 spaces (y: 0-29)
- Total spaces: 1200

### Facility Board
- Width: 35 spaces (x: 0-34)
- Height: 35 spaces (y: 0-34)
- Total spaces: 1225

## Space Types

### Valid Spaces
```json
{
  "x": 10,
  "y": 15,
  "type": "floor",
  "walkable": true,
  "isObjective": false
}
```

### Wall Spaces
```json
{
  "x": 5,
  "y": 5,
  "type": "wall",
  "walkable": false
}
```

## Distance Calculation

### Manhattan Distance (Grid Movement)
```csharp
int Distance(Position a, Position b)
{
    return Math.Abs(a.X - b.X) + Math.Abs(a.Y - b.Y);
}
```

### Euclidean Distance (Line of Sight)
```csharp
double Distance(Position a, Position b)
{
    int dx = a.X - b.X;
    int dy = a.Y - b.Y;
    return Math.Sqrt(dx * dx + dy * dy);
}
```

## Adjacent Spaces

### 4-Direction (Orthogonal)
```csharp
var adjacentOrthogonal = new[]
{
    new Position(x, y - 1),  // North
    new Position(x + 1, y),  // East
    new Position(x, y + 1),  // South
    new Position(x - 1, y)   // West
};
```

### 8-Direction (Including Diagonals)
```csharp
var adjacentAll = new[]
{
    new Position(x, y - 1),      // N
    new Position(x + 1, y - 1),  // NE
    new Position(x + 1, y),      // E
    new Position(x + 1, y + 1),  // SE
    new Position(x, y + 1),      // S
    new Position(x - 1, y + 1),  // SW
    new Position(x - 1, y),      // W
    new Position(x - 1, y - 1)   // NW
};
```

## Path Representation

### Movement Path
Array of sequential positions from start to end.

```json
{
  "path": [
    { "x": 10, "y": 15 },
    { "x": 11, "y": 15 },
    { "x": 12, "y": 15 },
    { "x": 12, "y": 16 }
  ],
  "totalDistance": 3
}
```

### Validation Rules
1. Each step must be adjacent (orthogonal or diagonal)
2. Total distance must not exceed movement allowance
3. No step can be on unwalkable space
4. Path must be continuous

## Special Locations

### Objective Markers
```json
{
  "objectiveId": "vault",
  "position": { "x": 25, "y": 20 },
  "radius": 1
}
```

### Starting Zones
```json
{
  "agentStart": [
    { "x": 0, "y": 0 },
    { "x": 1, "y": 0 },
    { "x": 0, "y": 1 }
  ],
  "hunterStarts": [
    { "x": 39, "y": 29 },
    { "x": 38, "y": 29 }
  ]
}
```
