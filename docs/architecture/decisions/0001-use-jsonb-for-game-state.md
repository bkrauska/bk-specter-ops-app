# ADR 0001: Use JSONB for Game State Storage

## Status
Accepted

## Context
We need to store complex game state that includes:
- Agent position (hidden)
- Hunter positions (public)
- Equipment card states
- Mission progress
- Active ability effects
- Movement history

The game state is highly dynamic and may evolve as we add features. We need flexibility while maintaining query performance.

## Decision
Use PostgreSQL's JSONB column type for storing game state rather than normalizing into multiple tables.

## Rationale

### Advantages
1. **Flexibility**: Easy to add new game state fields without migrations
2. **Atomic Updates**: Can update entire game state in single transaction
3. **Version Tolerance**: Different game versions can coexist
4. **Query Performance**: JSONB supports indexing and efficient queries
5. **Simplicity**: Reduces number of tables and joins

### Trade-offs
1. **Schema Validation**: Requires application-level validation
2. **Complex Queries**: Some queries more complex than with normalized tables
3. **Storage**: Slightly more storage than normalized approach

## Alternatives Considered

### Normalized Relational Schema
Create separate tables for:
- agent_positions
- hunter_positions
- equipment_states
- mission_progress

**Rejected because**:
- Too many tables for rapidly changing data
- Complex joins for simple game state queries
- Schema migrations difficult during development
- Harder to maintain consistency

### Document Database (MongoDB)
Store entire game as document.

**Rejected because**:
- Want ACID transactions
- PostgreSQL provides JSONB with SQL benefits
- Keeps all data in one database

## Implementation

### Schema
```sql
CREATE TABLE games (
    id UUID PRIMARY KEY,
    game_state JSONB NOT NULL,
    -- other columns
);

CREATE INDEX idx_game_state_gin ON games USING GIN (game_state);
```

### Validation
Application layer validates game state against schema before saving.

### Queries
Can query specific fields:
```sql
SELECT id FROM games
WHERE game_state->>'status' = 'in_progress'
AND (game_state->'currentRound')::int < 40;
```

## Consequences

### Positive
- Rapid development and iteration
- Easy to add new features
- Simple to serialize for API responses
- Good performance for read/write

### Negative
- Must maintain validation logic in code
- Database can't enforce structure
- Requires careful JSONB indexing strategy
- Need to version game state format

## Notes
- Will monitor performance as game scales
- May extract frequently queried fields to columns later
- Consider using TypeScript types for validation
