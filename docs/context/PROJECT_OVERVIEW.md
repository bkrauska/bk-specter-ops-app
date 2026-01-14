# Specter Ops - Project Overview

## What is Specter Ops?
Specter Ops is a digital adaptation of the hidden-movement board game where one player controls a secret agent navigating through a facility while 2-4 other players control hunters trying to locate and eliminate the agent.

## Technology Stack

### Backend
- **Framework**: ASP.NET Core 8.0 (Web API)
- **Database**: PostgreSQL with JSONB for game state
- **ORM**: Entity Framework Core
- **Real-time**: SignalR for live game updates

### Frontend
- **Framework**: SvelteKit
- **UI Library**: shadcn-svelte with Tailwind CSS
- **State Management**: Svelte stores
- **Build Tool**: Vite

## Core Game Concepts

### Roles
- **Agent**: Hidden movement, wins by completing objectives
- **Hunters**: Visible movement, win by locating and eliminating the agent

### Game Flow
1. Setup: Choose characters, equipment, and mission
2. Rounds: Agent moves secretly, hunters move and search
3. Resolution: Agent completes objectives or hunters eliminate agent

### Key Mechanics
- Hidden movement tracking
- Line of sight calculations
- Equipment card usage
- Mission objective tracking
- Character special abilities

## Project Structure
- `/backend` - .NET API server
- `/frontend` - SvelteKit web application
- `/docs` - Documentation and design specs
- `/.github` - CI/CD workflows and templates

## Development Phases
See [DEVELOPMENT_PHASES.md](DEVELOPMENT_PHASES.md) for detailed roadmap.
