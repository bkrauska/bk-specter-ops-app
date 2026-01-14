# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["src/SpecterOps.Api/SpecterOps.Api.csproj", "SpecterOps.Api/"]
RUN dotnet restore "SpecterOps.Api/SpecterOps.Api.csproj"

# Copy everything else and build
COPY src/SpecterOps.Api/ SpecterOps.Api/
WORKDIR "/src/SpecterOps.Api"
RUN dotnet build "SpecterOps.Api.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "SpecterOps.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 5000

COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SpecterOps.Api.dll"]
