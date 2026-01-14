using Microsoft.EntityFrameworkCore;

namespace SpecterOps.Api.Data;

public class SpecterOpsContext : DbContext
{
    public SpecterOpsContext(DbContextOptions<SpecterOpsContext> options)
        : base(options)
    {
    }

    // DbSets will be added as models are created
    // public DbSet<Game> Games { get; set; }
    // public DbSet<Player> Players { get; set; }
    // public DbSet<GameMove> GameMoves { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Entity configurations will be added here
    }
}
