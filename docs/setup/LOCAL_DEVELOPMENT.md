# Local Development Setup

## Prerequisites

### Required Software
- **Node.js**: v20 or later
- **.NET SDK**: 8.0 or later
- **PostgreSQL**: 15 or later
- **Git**: Latest version
- **Docker** (optional): For containerized database

### Recommended Tools
- **VS Code** or **Rider** for development
- **Postman** or **Insomnia** for API testing
- **pgAdmin** or **DBeaver** for database management

---

## Backend Setup

### 1. Install .NET SDK
```bash
# Verify installation
dotnet --version
# Should output 8.0.x or later
```

### 2. Setup PostgreSQL

#### Option A: Local Installation
```bash
# Install PostgreSQL (Ubuntu/Debian)
sudo apt-get install postgresql postgresql-contrib

# Start service
sudo systemctl start postgresql

# Create database
sudo -u postgres psql
CREATE DATABASE specterops_dev;
CREATE USER specterops_user WITH PASSWORD 'dev_password';
GRANT ALL PRIVILEGES ON DATABASE specterops_dev TO specterops_user;
\q
```

#### Option B: Docker
```bash
cd backend/docker
docker-compose up -d
```

### 3. Configure Backend
```bash
cd backend/src/SpecterOps.Api

# Copy environment file
cp ../../.env.example .env

# Edit .env with your settings
# Update connection string if needed
```

### 4. Run Database Migrations
```bash
dotnet ef database update
```

### 5. Start Backend Server
```bash
dotnet run
# Server runs at http://localhost:5000
```

### 6. Verify Backend
```bash
curl http://localhost:5000/api/health
# Should return: {"status": "healthy"}
```

---

## Frontend Setup

### 1. Install Dependencies
```bash
cd frontend
npm install
```

### 2. Configure Frontend
```bash
# Copy environment file
cp .env.example .env

# Edit .env
# VITE_API_URL=http://localhost:5000/api
```

### 3. Start Development Server
```bash
npm run dev
# Server runs at http://localhost:5173
```

### 4. Verify Frontend
Open browser to http://localhost:5173

---

## Running Tests

### Backend Tests
```bash
cd backend/src/SpecterOps.Tests
dotnet test
```

### Frontend Tests
```bash
cd frontend
npm test
```

---

## Database Management

### View Current Schema
```bash
psql -U specterops_user -d specterops_dev
\dt  # List tables
\d games  # Describe games table
```

### Seed Test Data
```bash
cd backend/scripts
psql -U specterops_user -d specterops_dev < seed-data.sql
```

### Reset Database
```bash
dotnet ef database drop
dotnet ef database update
```

---

## Development Workflow

### 1. Start All Services
```bash
# Terminal 1: Database (if using Docker)
cd backend/docker && docker-compose up

# Terminal 2: Backend
cd backend/src/SpecterOps.Api && dotnet run

# Terminal 3: Frontend
cd frontend && npm run dev
```

### 2. Making Changes

#### Backend Changes
- Edit files in `backend/src/SpecterOps.Api/`
- Hot reload enabled (dotnet watch)
- Run tests: `dotnet test`

#### Frontend Changes
- Edit files in `frontend/src/`
- Hot reload enabled (Vite HMR)
- Type check: `npm run check`
- Lint: `npm run lint`

### 3. Database Changes
```bash
# Create new migration
cd backend/src/SpecterOps.Api
dotnet ef migrations add MigrationName

# Apply migration
dotnet ef database update
```

---

## Common Issues

### Port Already in Use
```bash
# Backend (5000)
lsof -ti:5000 | xargs kill

# Frontend (5173)
lsof -ti:5173 | xargs kill
```

### Database Connection Failed
- Check PostgreSQL is running
- Verify connection string in .env
- Check firewall settings

### npm install fails
```bash
# Clear cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### .NET restore fails
```bash
# Clear NuGet cache
dotnet nuget locals all --clear
dotnet restore
```

---

## IDE Setup

### VS Code
Install extensions:
- C# Dev Kit
- Svelte for VS Code
- ESLint
- Tailwind CSS IntelliSense
- PostgreSQL

### Rider
- Built-in support for .NET and Svelte
- Configure database connection
- Enable hot reload

---

## Environment Variables

### Backend (.env)
```bash
# Database
ConnectionStrings__DefaultConnection="Host=localhost;Database=specterops_dev;Username=specterops_user;Password=dev_password"

# Application
ASPNETCORE_ENVIRONMENT=Development
ASPNETCORE_URLS=http://localhost:5000

# Logging
Logging__LogLevel__Default=Information
```

### Frontend (.env)
```bash
# API
VITE_API_URL=http://localhost:5000/api
VITE_WS_URL=ws://localhost:5000/hubs/game

# Environment
VITE_ENV=development
```

---

## Next Steps
- Read [PROJECT_OVERVIEW.md](../context/PROJECT_OVERVIEW.md)
- Review [DEVELOPMENT_PHASES.md](../context/DEVELOPMENT_PHASES.md)
- Check [API_SPECIFICATION.md](../context/API_SPECIFICATION.md)
