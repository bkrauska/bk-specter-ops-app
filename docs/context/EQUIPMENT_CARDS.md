# Equipment Cards

## Overview
Equipment cards provide one-time use abilities for both agents and hunters. Each game has a limited deck.

## Agent Equipment

### Disguise
**Type**: Defensive

**Effect**
- When revealed, immediately hide again
- Hunters lose track of agent location
- Must wait 1 round before moving

**Timing**: Play when revealed

**Strategy**: Escape from being cornered, reset hunter tracking.

---

### Flash Grenade
**Type**: Offensive

**Effect**
- All hunters within 5 spaces lose next turn
- Agent can move normally
- Does not reveal agent location

**Timing**: Play during movement phase

**Strategy**: Create distance, escape pursuit.

---

### Smoke Bomb
**Type**: Utility

**Effect**
- Create 3x3 area of obscurement
- Blocks line of sight for 2 rounds
- Agent can see through smoke

**Timing**: Play during equipment phase

**Strategy**: Create safe corridors, block hunter vision.

---

### Rappel Kit
**Type**: Movement

**Effect**
- Move up to 8 spaces in straight line
- Ignores walls and obstacles
- One-time use

**Timing**: Play during movement phase

**Strategy**: Quick escape or objective rush.

---

### Hologram
**Type**: Deception

**Effect**
- Create fake agent location
- Hunters see "agent" at location
- Disappears when hunter investigates

**Timing**: Play during movement phase

**Strategy**: Misdirect hunters, buy time.

---

## Hunter Equipment

### Motion Sensor
**Type**: Detection

**Effect**
- Place sensor on current location
- Activates if agent moves within 3 spaces
- Reveals agent was in area (not exact location)
- Lasts 5 rounds

**Timing**: Play during equipment phase

**Strategy**: Guard chokepoints, track agent movement.

---

### Radar Sweep
**Type**: Detection

**Effect**
- Choose direction (N, S, E, W)
- Reveals if agent is in that half of board
- Narrows down search area

**Timing**: Play during action phase

**Strategy**: Coordinate with team to triangulate agent.

---

### Drone
**Type**: Reconnaissance

**Effect**
- Check line of sight from any location
- Does not require hunter to be there
- One-time check

**Timing**: Play during action phase

**Strategy**: Check distant locations without committing movement.

---

### Lockdown Protocol
**Type**: Area Denial

**Effect**
- Lock all doors in 5-space radius
- Agent cannot pass through doors in area
- Lasts 3 rounds

**Timing**: Play during equipment phase

**Strategy**: Trap agent in section, force confrontation.

---

### Tactical Scan
**Type**: Detection

**Effect**
- Reveal if agent is in any chosen 4x4 area
- If agent present, narrow to 2x2
- One-time use

**Timing**: Play during action phase

**Strategy**: Precise location checking for suspected areas.

---

## Equipment Deck Management

### Starting Decks
```json
{
  "agentDeck": [
    "disguise",
    "flash_grenade",
    "smoke_bomb",
    "rappel_kit",
    "hologram"
  ],
  "hunterDeck": [
    "motion_sensor",
    "motion_sensor",
    "radar_sweep",
    "drone",
    "lockdown_protocol",
    "tactical_scan"
  ]
}
```

### Draw Rules
- Agents draw 2 cards at game start
- Hunters collectively draw 3 cards at game start
- Can draw additional cards at specific rounds (10, 20, 30)

### Play Restrictions
- One equipment card per turn
- Equipment is discarded after use
- Cannot play equipment if none in hand

## Database Schema

```json
{
  "gameId": "uuid",
  "equipmentState": {
    "agentHand": ["disguise", "smoke_bomb"],
    "hunterHand": ["motion_sensor", "radar_sweep"],
    "agentDiscard": ["flash_grenade"],
    "hunterDiscard": [],
    "activeEffects": [
      {
        "equipmentId": "motion_sensor",
        "playedBy": "hunter1",
        "location": { "x": 15, "y": 20 },
        "expiresRound": 15,
        "radius": 3
      }
    ]
  }
}
```

## Implementation Notes

### Equipment Validation
1. Check if card in player's hand
2. Verify timing is correct for card type
3. Validate any targeting/location requirements
4. Process effect
5. Move card to discard pile

### Active Effect Tracking
- Track which effects are currently active
- Check each round for expiration
- Apply effects to relevant actions (movement, LOS, etc.)
