# UI Component Specifications

## Overview
UI components for the Specter Ops web application using SvelteKit and shadcn-svelte.

## Game Board Components

### GameBoard.svelte
**Purpose**: Main interactive game board

**Props**
```typescript
interface GameBoardProps {
  gameState: GameState;
  board: Board;
  currentPlayer: Player;
  onCellClick: (position: Position) => void;
  highlightedCells?: Position[];
  showAgentPosition?: boolean;
}
```

**Features**
- SVG or Canvas rendering for performance
- Grid overlay with coordinates
- Interactive cell selection
- Visual feedback for valid moves
- LOS visualization
- Objective markers

**State**
- Selected cell
- Hover state
- Movement preview path

---

### PlayerToken.svelte
**Purpose**: Visual representation of player on board

**Props**
```typescript
interface PlayerTokenProps {
  position: Position;
  character: Character;
  isAgent: boolean;
  isCurrentPlayer: boolean;
  revealed?: boolean;
}
```

**Variants**
- Agent (hidden vs revealed)
- Hunters (different colors)
- Animated movement

---

### MovementPath.svelte
**Purpose**: Visual path from start to destination

**Props**
```typescript
interface MovementPathProps {
  path: Position[];
  isValid: boolean;
  distance: number;
  maxDistance: number;
}
```

**Visual States**
- Valid path: Green overlay
- Invalid path: Red overlay
- Partial path: Yellow overlay

---

## Game Controls

### ActionPanel.svelte
**Purpose**: Main control panel for current player

**Layout**
```
┌─────────────────────────────┐
│  Round: 5 / 40              │
│  Role: Agent (The Shadow)   │
├─────────────────────────────┤
│  Movement: 2 / 4 used       │
│  [Move] [Equipment] [End]   │
└─────────────────────────────┘
```

**Sections**
- Game status (round, timer)
- Player info (role, character)
- Movement controls
- Equipment cards
- Action buttons

---

### EquipmentHand.svelte
**Purpose**: Display and manage equipment cards

**Props**
```typescript
interface EquipmentHandProps {
  cards: EquipmentCard[];
  onCardPlay: (cardId: string) => void;
  disabled?: boolean;
}
```

**Features**
- Card fan display
- Hover for details
- Click to play
- Disabled state when not usable

---

### MissionTracker.svelte
**Purpose**: Show mission objectives and progress

**Layout**
```
Mission: Infiltration
━━━━━━━━━━━━━━━━━━━━
☑ Objective 1: Complete
☑ Objective 2: Complete
☐ Objective 3: Pending
☐ Objective 4: Pending

Progress: 2 / 4
```

---

## Player Management

### PlayerList.svelte
**Purpose**: Show all players in game

**Layout**
```
┌─────────────────────────┐
│ 👤 Agent: Player1       │
│    [The Shadow]         │
├─────────────────────────┤
│ 🎯 Hunter: Player2      │
│    [The Hammer]         │
│ 🎯 Hunter: Player3      │
│    [The Spotter]        │
└─────────────────────────┘
```

**Features**
- Role indicators
- Character display
- Active player highlight
- Connection status

---

### CharacterSelect.svelte
**Purpose**: Character selection during setup

**Props**
```typescript
interface CharacterSelectProps {
  role: 'agent' | 'hunter';
  characters: Character[];
  onSelect: (characterId: string) => void;
  unavailable?: string[];
}
```

**Layout**
- Grid of character cards
- Character details on hover
- Disabled state for taken characters

---

## Game Setup

### GameSetup.svelte
**Purpose**: Configure new game

**Form Fields**
```typescript
interface GameSetupForm {
  board: 'museum' | 'facility';
  mission: string;
  maxRounds: number;
  hunterCount: 2 | 3 | 4;
  variant: 'standard' | 'advanced';
}
```

**Sections**
1. Board selection
2. Mission selection
3. Game settings
4. Player configuration

---

### LobbyView.svelte
**Purpose**: Pre-game lobby for players to join

**Features**
- Join code display
- Player list
- Ready status
- Role selection
- Start game button (host only)

---

## UI Overlays

### GameLog.svelte
**Purpose**: Chronological list of game events

**Layout**
```
Round 5
━━━━━━━━━━━━━━━━━━
• Hunter1 moved to (10, 15)
• Hunter2 used Motion Sensor
• Agent moved (hidden)
• Motion Sensor triggered!

Round 4
━━━━━━━━━━━━━━━━━━
• ...
```

---

### AbilityTooltip.svelte
**Purpose**: Detailed ability descriptions

**Props**
```typescript
interface AbilityTooltipProps {
  ability: Ability;
  usesRemaining?: number;
  canUse: boolean;
}
```

---

### ConfirmDialog.svelte
**Purpose**: Confirm important actions

**Usage**
- End turn
- Use limited ability
- Surrender game

---

## Layout Components

### GameLayout.svelte
**Purpose**: Main game view layout

**Structure**
```
┌──────────────────────────────────┐
│  Header: Round, Timer            │
├──────────┬──────────────┬────────┤
│ Player   │              │ Game   │
│ List     │  Game Board  │ Log    │
│          │              │        │
├──────────┴──────────────┴────────┤
│  Action Panel & Equipment        │
└──────────────────────────────────┘
```

**Responsive**
- Desktop: Side-by-side layout
- Tablet: Collapsible sidebars
- Mobile: Stacked layout

---

## Styling Guidelines

### Color Scheme
```css
/* Agent */
--agent-primary: #3b82f6;
--agent-revealed: #ef4444;

/* Hunters */
--hunter-1: #10b981;
--hunter-2: #f59e0b;
--hunter-3: #8b5cf6;
--hunter-4: #ec4899;

/* Board */
--floor: #e5e7eb;
--wall: #1f2937;
--objective: #fbbf24;
--highlight: rgba(59, 130, 246, 0.3);
```

### Typography
- Headers: Inter or system-ui
- Body: System font stack
- Monospace: JetBrains Mono (for coordinates)

### Spacing
- Use Tailwind spacing scale
- Consistent padding: p-4, p-6
- Gap between elements: gap-4

### Animations
- Smooth transitions: `transition-all duration-300`
- Movement: Animate token position
- Card plays: Scale and fade effects
