# Character Abilities

## Agent Characters

### The Shadow
**Role**: Infiltrator

**Stats**
- Movement: 4
- Special Uses: 3 per game

**Ability**: Phase Walk
- Can move through one wall per turn
- Does not count as extra movement
- Cannot end turn inside wall
- Limited to 3 uses per game

**Strategy**: Best for sneaking through secure areas and avoiding hunter patrols.

---

### The Driver
**Role**: Speed Agent

**Stats**
- Movement: 5
- Special Uses: Passive

**Ability**: Enhanced Speed
- Base movement is 5 instead of 4
- Can cover more ground quickly
- No special activation required

**Strategy**: Excellent for hit-and-run objectives, escaping tight situations.

---

### The Beast
**Role**: Aggressive Agent

**Stats**
- Movement: 4
- Special Uses: 2 per game

**Ability**: Rampage
- When revealed, can push adjacent hunters 2 spaces
- Pushed hunters take 1 turn to recover
- Can only be used when revealed

**Strategy**: High-risk, high-reward. Forces hunters to be cautious.

---

### Ember
**Role**: Tactical Agent

**Stats**
- Movement: 4
- Special Uses: 2 per game

**Ability**: Blink
- Can teleport up to 3 spaces
- Teleport ignores walls and obstacles
- Does not use movement points
- Limited to 2 uses per game

**Strategy**: Perfect for escaping surrounded positions or reaching distant objectives.

---

## Hunter Characters

### The Hammer
**Role**: Bruiser

**Stats**
- Movement: 3
- Shooting Range: 8

**Ability**: Heavy Ordnance
- Increased shooting range (8 vs standard 5)
- Can shoot through one obstacle
- When hits agent, agent takes 2 damage (instant elimination)

**Strategy**: Position for long-range shots, control sightlines.

---

### The Spotter
**Role**: Reconnaissance

**Stats**
- Movement: 3
- Vision Range: Unlimited

**Ability**: Enhanced Optics
- Can see through one layer of wall/obstacle
- Reveals agent location if in extended vision
- Shares vision with team

**Strategy**: Support role, scouts ahead and guides team.

---

### The Sentry
**Role**: Area Denial

**Stats**
- Movement: 2
- Special Uses: 3 per game

**Ability**: Lockdown
- Can place barrier on adjacent space
- Agent cannot move through barrier
- Barrier lasts 3 rounds
- Limited to 3 uses per game

**Strategy**: Cut off escape routes, force agent into ambushes.

---

### The Hacker
**Role**: Information Warfare

**Stats**
- Movement: 3
- Special Uses: 4 per game

**Ability**: Motion Tracker
- Once per round, can ask "Is agent within 5 spaces?"
- Agent player must answer truthfully
- Does not reveal exact location
- Limited to 4 uses per game

**Strategy**: Narrow down agent location, coordinate with team.

---

## Ability Implementation Notes

### Database Storage
```json
{
  "characterId": "shadow",
  "abilityUses": 2,
  "maxAbilityUses": 3,
  "passiveActive": true
}
```

### Ability Validation
- Check uses remaining before allowing activation
- Validate ability conditions (e.g., "must be revealed")
- Update game state after ability use
- Notify all players of ability activation (or keep secret if agent ability)

### Ability Cooldowns
Some abilities may have cooldown periods:
```json
{
  "abilityId": "rampage",
  "lastUsedRound": 12,
  "cooldown": 5,
  "availableRound": 17
}
```
