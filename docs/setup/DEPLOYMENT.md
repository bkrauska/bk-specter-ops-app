# Deployment Guide

## Overview
This guide covers deploying the Specter Ops application to production.

## Architecture

### Components
- **Backend**: ASP.NET Core API (containerized)
- **Frontend**: SvelteKit static site
- **Database**: PostgreSQL (managed service recommended)
- **WebSockets**: SignalR for real-time updates

---

## Production Requirements

### Infrastructure
- **Compute**: 2+ vCPU, 4GB+ RAM for backend
- **Database**: PostgreSQL 15+ with backups
- **Storage**: Minimal (mostly database)
- **CDN**: For frontend static assets

### Security
- HTTPS/TLS certificates
- Database encryption at rest
- Environment variable management
- CORS configuration
- Rate limiting

---

## Deployment Options

## Option 1: Docker Compose (Simple)

### Prerequisites
- VPS with Docker installed
- Domain name configured
- SSL certificates

### Steps

1. **Build Images**
```bash
# Backend
cd backend
docker build -t specterops-api:latest .

# Frontend (build static files)
cd frontend
npm run build
```

2. **Configure docker-compose.yml**
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: specterops_prod
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  api:
    image: specterops-api:latest
    environment:
      - ConnectionStrings__DefaultConnection=${DB_CONNECTION}
      - ASPNETCORE_ENVIRONMENT=Production
    depends_on:
      - postgres
    ports:
      - "5000:5000"
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    volumes:
      - ./frontend/build:/usr/share/nginx/html
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
      - "443:443"
    restart: unless-stopped

volumes:
  postgres_data:
```

3. **Deploy**
```bash
docker-compose up -d
```

---

## Option 2: Cloud Platform (Recommended)

### Backend: Azure App Service / AWS Elastic Beanstalk

#### Azure
```bash
# Login
az login

# Create resource group
az group create --name specterops-rg --location eastus

# Create app service plan
az appservice plan create \
  --name specterops-plan \
  --resource-group specterops-rg \
  --sku B1 --is-linux

# Create web app
az webapp create \
  --name specterops-api \
  --resource-group specterops-rg \
  --plan specterops-plan \
  --runtime "DOTNET|8.0"

# Deploy
dotnet publish -c Release
cd bin/Release/net8.0/publish
zip -r deploy.zip .
az webapp deployment source config-zip \
  --resource-group specterops-rg \
  --name specterops-api \
  --src deploy.zip
```

#### Environment Variables (Azure)
```bash
az webapp config appsettings set \
  --resource-group specterops-rg \
  --name specterops-api \
  --settings \
    ConnectionStrings__DefaultConnection="${DB_CONNECTION}" \
    ASPNETCORE_ENVIRONMENT="Production"
```

### Frontend: Vercel / Netlify

#### Vercel
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
cd frontend
vercel --prod
```

#### Environment Variables (Vercel)
```bash
vercel env add VITE_API_URL production
# Enter: https://api.yourdomain.com/api
```

### Database: Managed PostgreSQL

#### Azure Database for PostgreSQL
```bash
az postgres server create \
  --resource-group specterops-rg \
  --name specterops-db \
  --location eastus \
  --admin-user dbadmin \
  --admin-password ${DB_PASSWORD} \
  --sku-name B_Gen5_1 \
  --version 15
```

#### Connection String
```
Host=specterops-db.postgres.database.azure.com;
Database=specterops;
Username=dbadmin@specterops-db;
Password=${DB_PASSWORD};
SslMode=Require;
```

---

## Option 3: Kubernetes (Advanced)

### Prerequisites
- Kubernetes cluster (GKE, EKS, AKS)
- kubectl configured
- Helm installed

### Deploy with Helm

1. **Create Helm Chart**
```bash
helm create specter-ops
```

2. **Configure values.yaml**
```yaml
api:
  replicaCount: 2
  image:
    repository: your-registry/specterops-api
    tag: latest
  resources:
    limits:
      cpu: 500m
      memory: 512Mi

postgres:
  enabled: true
  auth:
    database: specterops
    username: specterops
    password: ${DB_PASSWORD}
```

3. **Deploy**
```bash
helm install specterops ./specter-ops \
  --set postgres.auth.password=${DB_PASSWORD}
```

---

## Database Migrations

### Production Migration Strategy

#### Safe Migration Process
1. **Backup Database**
```bash
pg_dump -U dbadmin -h prod-db.example.com specterops > backup.sql
```

2. **Test Migration on Staging**
```bash
dotnet ef database update --connection "${STAGING_CONNECTION}"
```

3. **Apply to Production**
```bash
dotnet ef database update --connection "${PROD_CONNECTION}"
```

#### Rollback Plan
```bash
# Restore from backup if needed
psql -U dbadmin -h prod-db.example.com specterops < backup.sql
```

---

## Monitoring & Logging

### Application Insights (Azure)
```csharp
// Program.cs
builder.Services.AddApplicationInsightsTelemetry();
```

### Serilog Configuration
```json
{
  "Serilog": {
    "MinimumLevel": "Information",
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "/logs/specterops-.txt",
          "rollingInterval": "Day"
        }
      }
    ]
  }
}
```

### Health Checks
```csharp
app.MapHealthChecks("/health");
```

---

## Security Checklist

- [ ] HTTPS enabled with valid certificate
- [ ] Database uses SSL/TLS
- [ ] Secrets stored in environment variables (not code)
- [ ] CORS configured for frontend domain only
- [ ] Rate limiting enabled
- [ ] Input validation on all endpoints
- [ ] SQL injection prevention (using EF Core)
- [ ] XSS protection headers
- [ ] Regular security updates

---

## Performance Optimization

### Database
- Enable connection pooling
- Add indexes on frequently queried columns
- Use read replicas for high traffic

### API
- Enable response compression
- Implement caching (Redis)
- Use CDN for static assets

### Frontend
- Enable gzip/brotli compression
- Lazy load components
- Optimize images
- Use CDN

---

## Backup Strategy

### Database Backups
```bash
# Daily automated backup
0 2 * * * pg_dump -U dbadmin specterops | gzip > /backups/$(date +\%Y\%m\%d).sql.gz

# Retention: Keep 30 days
find /backups -name "*.sql.gz" -mtime +30 -delete
```

### Application State
- Game state stored in database (covered by DB backups)
- No additional backup needed

---

## Scaling

### Horizontal Scaling
- Run multiple API instances behind load balancer
- Use sticky sessions for SignalR
- Consider Redis backplane for SignalR

### Database Scaling
- Read replicas for high read traffic
- Connection pooling
- Query optimization

---

## Cost Estimation

### Small Scale (100 concurrent users)
- Backend: $25/month (Azure B1)
- Database: $15/month (PostgreSQL Basic)
- Frontend: $0 (Vercel free tier)
- **Total: ~$40/month**

### Medium Scale (1000 concurrent users)
- Backend: $100/month (Azure S1 + autoscaling)
- Database: $50/month (PostgreSQL Standard)
- Frontend: $20/month (Vercel Pro)
- Redis: $30/month (for SignalR backplane)
- **Total: ~$200/month**

---

## Rollback Procedure

1. **Revert Backend**
```bash
# Deploy previous version
az webapp deployment source config-zip \
  --src previous-version.zip
```

2. **Revert Database**
```bash
# If migration caused issues
psql < backup-before-migration.sql
```

3. **Revert Frontend**
```bash
vercel rollback
```

---

## Support & Maintenance

### Regular Tasks
- Monitor error logs weekly
- Review performance metrics
- Update dependencies monthly
- Backup verification monthly
- Security patches as released

### Emergency Contacts
- Database admin: [contact]
- DevOps: [contact]
- On-call: [rotation]
