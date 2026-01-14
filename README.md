# Specter Ops: Shadow of Babel - Digital Companion App

A modern digital companion application for the board game **Specter Ops: Shadow of Babel**, designed to streamline the agent's hidden movement tracking while preserving the tactile board game experience for local multiplayer sessions.

## Project Overview

This companion app digitizes the complex paper-based movement tracking system used by the A.R.K. agent player, making the game more accessible to new players while maintaining the physical board as the centerpiece of gameplay.

### Target Audience

- **Primary**: New players learning Specter Ops who need guidance and support
- **Secondary**: Experienced players seeking convenience without sacrificing the physical game experience

### Design Philosophy

- Enhance the learning experience without replacing tactile board game elements
- Prioritize local multiplayer gameplay over remote synchronization
- Simplify complexity while maintaining game integrity
- Support the physical board as the primary play surface

## Game Context

### What is Specter Ops?

Specter Ops is an asymmetric hidden movement board game where:
- **1 Agent Player** (A.R.K. operative) infiltrates a facility to complete missions while hidden
- **1-4 Hunter Players** (Raxxon security) work to track down and eliminate the agent

The agent secretly tracks movement on a paper sheet while hunters move visible figures on the board, creating a cat-and-mouse game of deduction and strategy.

### Key Game Mechanics

- **Hidden Movement**: Agent tracks position secretly, revealing only when spotted
- **Mission Objectives**: Agent must complete 3 of 4 randomly-placed objectives
- **Equipment Cards**: Special abilities with limited charges
- **Line of Sight**: Hunters have specific vision patterns based on position
- **Vehicle System**: Fast movement on roads with motion sensor detection
- **Turn Limit**: 40 rounds to complete objectives and escape

## Technical Architecture

### Tech Stack

- **Frontend**: SvelteKit + shadcn-svelte
- **Backend**: .NET Core with FastEndpoints library
- **Database**: PostgreSQL with JSONB columns
- **Target Platform**: iPad Pro (primary)

### Database Design

Simplified single-table approach using JSONB for game state management:
```sql
-- Simplified schema focusing on essential game state
CREATE TABLE games (
    game_id UUID PRIMARY KEY,
    created_at TIMESTAMP,
    game_state JSONB,  -- Contains all dynamic game data
    player_count INT,
    status VARCHAR(20)
);
```

**Rationale**: 
- Local gameplay eliminates need for complex relational structures
- JSONB provides flexibility for varying game states
- Simplified architecture reduces development and maintenance overhead

### Architecture Decisions

1. **Local-First Design**: No remote synchronization required
2. **Denormalized Storage**: JSONB over normalized tables for simplicity
3. **FastEndpoints**: Chosen for clean .NET API patterns and performance
4. **SvelteKit**: Reactive UI with excellent mobile support

## Core Features

### Phase 1: Essential Gameplay

- [ ] Digital movement tracking system
  - Replace paper movement sheet
  - Visual coordinate grid
  - Movement history with undo capability
  
- [ ] Equipment management
  - Card selection during setup
  - Charge tracking
  - Usage recording tied to specific rounds

- [ ] Mission objective tracking
  - Random objective generation
  - Proximity detection
  - Completion status

- [ ] Visibility calculation
  - Hunter line-of-sight rules
  - Agent reveal mechanics
  - "Last seen" marker placement

### Phase 2: Enhanced Features

- [ ] Vehicle tracking and motion sensor
- [ ] Turn/round management
- [ ] HP tracking
- [ ] Game state persistence
- [ ] Multi-player mode support (4-5 players)

### Phase 3: Advanced Features

- [ ] Game statistics and history
- [ ] Tutorial/onboarding mode
- [ ] Character ability reference
- [ ] Rule clarifications

## Key Game Rules (Implementation Reference)

### Agent Movement
- 4 spaces per turn (orthogonal/diagonal)
- Starts at space N1
- Cannot move through structures or hunters
- Records position secretly on movement sheet

### Mission Objectives
- 4 objectives randomly placed (1 per map section)
- Agent must complete 3 of 4
- Complete by starting turn adjacent to objective
- Flip token from blue (Raxxon) to red (A.R.K.)

### Equipment Cards
- Agent selects 3 cards at setup (5 in 4-player mode)
- Cards have limited charges
- Some revealed, others remain secret
- Usage marked on movement sheet

### Hunter Vision
- Line of sight down row/column
- Extended vision along road paths
- Blocked by structures
- No range limit

### Victory Conditions
- **Agent Wins**: Complete 3 objectives + escape before round 40
- **Hunters Win**: Reduce agent to 0 HP OR prevent escape by round 40

### Player Count Variations
- **2-3 Players**: Standard rules, objectives visible
- **4 Players**: Objectives hidden, agent gets +2 HP and 5 equipment cards
- **5 Players**: Includes traitor mechanic (secret agent sympathizer)

## Development Roadmap

### Current Phase: Foundation & Context
- [x] Define technical stack
- [x] Establish database architecture
- [x] Clarify target audience and design philosophy
- [x] Document game mechanics
- [ ] Prepare implementation context for Claude Code

### Next Phase: Core Implementation
- [ ] Set up SvelteKit + shadcn-svelte project
- [ ] Create .NET Core backend with FastEndpoints
- [ ] Implement PostgreSQL database
- [ ] Build digital movement grid
- [ ] Develop equipment selection UI

### Future Phases
- Advanced game mechanics
- Testing with target users
- Polish and refinement
- Deployment strategy

## Project Goals

### Primary Goals
1. Make Specter Ops more accessible to new players
2. Eliminate paper movement sheet friction
3. Maintain physical board as centerpiece
4. Support local multiplayer seamlessly

### Non-Goals
1. Replace the physical board game
2. Support remote/online play
3. Optimize for experienced players who prefer paper
4. Implement AI opponents

## Getting Started

*This section will be populated as development progresses*

### Prerequisites
- .NET Core SDK (version TBD)
- Node.js (version TBD)
- PostgreSQL (version TBD)

### Installation
```bash
# Clone repository
git clone [repository-url]

# Install frontend dependencies
cd frontend
npm install

# Install backend dependencies
cd ../backend
dotnet restore

# Set up database
# Instructions TBD
```

### Running the Application
```bash
# Start backend
cd backend
dotnet run

# Start frontend (separate terminal)
cd frontend
npm run dev
```

## Contributing

This is currently a personal learning project. Contributions are not being accepted at this time.

## Resources

- [Specter Ops Official Rules](https://www.plaidhatgames.com/games/specter-ops)
- [SvelteKit Documentation](https://kit.svelte.dev/)
- [FastEndpoints Documentation](https://fast-endpoints.com/)
- [shadcn-svelte Components](https://www.shadcn-svelte.com/)

## License

*To be determined*

## Acknowledgments

- **Plaid Hat Games** for creating Specter Ops
- **Game Designer**: Emerson Matsuuchi
- **Illustrator**: Steven Hamilton

---

**Project Status**: 🚧 Planning & Architecture Phase

**Last Updated**: January 2026
