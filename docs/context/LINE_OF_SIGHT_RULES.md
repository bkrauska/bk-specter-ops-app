# Line of Sight Rules

## Overview
Line of Sight (LOS) determines whether a hunter can see the agent's location. Critical for agent reveals and shooting.

## Basic LOS Algorithm

### Ray Casting Method
1. Draw straight line from hunter position to target position
2. Check each grid space the line passes through
3. If line intersects wall or obstacle, LOS is blocked
4. If line is clear, LOS is established

### Bresenham's Line Algorithm
Used for grid-based line drawing:

```csharp
public bool HasLineOfSight(Position from, Position to)
{
    var points = GetLinePoints(from, to);

    foreach (var point in points)
    {
        if (point.Equals(from) || point.Equals(to))
            continue;

        if (IsWall(point))
            return false;
    }

    return true;
}

private List<Position> GetLinePoints(Position from, Position to)
{
    var points = new List<Position>();

    int dx = Math.Abs(to.X - from.X);
    int dy = Math.Abs(to.Y - from.Y);
    int sx = from.X < to.X ? 1 : -1;
    int sy = from.Y < to.Y ? 1 : -1;
    int err = dx - dy;

    int x = from.X;
    int y = from.Y;

    while (true)
    {
        points.Add(new Position(x, y));

        if (x == to.X && y == to.Y)
            break;

        int e2 = 2 * err;

        if (e2 > -dy)
        {
            err -= dy;
            x += sx;
        }

        if (e2 < dx)
        {
            err += dx;
            y += sy;
        }
    }

    return points;
}
```

## Corner Cases

### Diagonal Wall Corners
When line passes through corner where two walls meet diagonally:

```
# # # #
# X # #    <- Wall corner at X
# # O #    <- Observer at O
# # # A    <- Agent at A
```

**Rule**: If line passes through corner of two adjacent walls, LOS is **blocked**.

### Grazing Walls
When line barely touches edge of wall:

```
# # # #
# W # #    <- Wall at W
O . . A    <- Observer to Agent
```

**Rule**: If line passes through any part of wall space, LOS is **blocked**.

## Range Limitations

### Vision Range
- Most hunters: Unlimited
- The Spotter: Can see through 1 wall
- Smoke effects: Blocks LOS within area

### Shooting Range
Character-specific limits:
- Standard hunters: 5 spaces
- The Hammer: 8 spaces
- Range measured as Euclidean distance

```csharp
public bool IsInShootingRange(Position hunter, Position target, int range)
{
    double distance = Math.Sqrt(
        Math.Pow(target.X - hunter.X, 2) +
        Math.Pow(target.Y - hunter.Y, 2)
    );

    return distance <= range;
}
```

## Special Abilities & Equipment

### The Spotter - Enhanced Optics
Can see through one wall:
```csharp
public bool HasLineOfSightWithXRay(Position from, Position to)
{
    var points = GetLinePoints(from, to);
    int wallsPassed = 0;

    foreach (var point in points)
    {
        if (point.Equals(from) || point.Equals(to))
            continue;

        if (IsWall(point))
        {
            wallsPassed++;
            if (wallsPassed > 1)
                return false;
        }
    }

    return true;
}
```

### Smoke Bomb Effect
Blocks all LOS within affected area:
```csharp
public bool HasLineOfSight(Position from, Position to, List<SmokeEffect> smokeEffects)
{
    var points = GetLinePoints(from, to);

    foreach (var point in points)
    {
        if (smokeEffects.Any(smoke => smoke.Contains(point)))
            return false;
    }

    return CheckWallsOnLine(from, to);
}
```

## Revelation Rules

### Agent Must Reveal When:
1. **Hunter has LOS** during their turn
2. **Agent is on hunter's space** at end of movement
3. **Equipment reveals** (motion sensor, etc.)

### Partial Reveals
Some equipment gives information without exact location:
- Motion sensor: "Agent was in area"
- Radar: "Agent is in this direction"
- These do NOT count as full reveals

## Implementation in Game State

### Check LOS Each Hunter Turn
```csharp
public void ProcessHunterTurn(HunterMove move, GameState state)
{
    // Move hunter
    state.MoveHunter(move.PlayerId, move.Destination);

    // Check LOS to agent position
    if (HasLineOfSight(move.Destination, state.AgentPosition))
    {
        RevealAgent(state);
        NotifyAllPlayers(new AgentRevealedEvent
        {
            Location = state.AgentPosition,
            RevealedBy = move.PlayerId
        });
    }
}
```

### Store LOS State
```json
{
  "losCheckResults": [
    {
      "hunterId": "uuid",
      "hunterPosition": { "x": 10, "y": 10 },
      "hasLOS": false,
      "round": 5
    }
  ]
}
```

## UI Visualization

### Show LOS Indicators
- Highlight spaces in hunter's vision
- Show blocked sightlines (grayed out)
- Indicate maximum shooting range

### Agent View
- Show which hunters can potentially see them
- Highlight dangerous zones
- Preview LOS before committing move
