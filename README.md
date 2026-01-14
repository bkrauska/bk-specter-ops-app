# Specter Ops Companion App

A digital companion app for the board game Specter Ops, designed to replace the agent's paper-based hidden movement tracking with an intuitive iPad Pro interface.

## Overview

This app modernizes the agent's gameplay experience while preserving the physical board game for local multiplayer sessions. It's designed specifically for new players who need guidance while learning the game.

## Tech Stack

### Backend
- .NET 8
- FastEndpoints
- PostgreSQL with JSONB
- Entity Framework Core

### Frontend
- SvelteKit
- shadcn-svelte
- TailwindCSS
- TypeScript

### Target Platform
- iPad Pro (primary)
- Modern web browsers (secondary)

## Project Structure

- `/backend` - .NET Core API using FastEndpoints
- `/frontend` - SvelteKit web application
- `/docs` - Documentation and context files

## Getting Started

See [LOCAL_DEVELOPMENT.md](./docs/setup/LOCAL_DEVELOPMENT.md) for detailed setup instructions.

### Quick Start

#### Backend
```bash
cd backend/src/SpecterOps.Api
dotnet restore
dotnet run
