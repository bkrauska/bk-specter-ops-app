// Game types and interfaces

export interface Position {
	x: number;
	y: number;
}

export interface Player {
	id: string;
	gameId: string;
	userId: string;
	username: string;
	role: 'agent' | 'hunter';
	characterId?: string;
	isActive: boolean;
}

export interface GameState {
	board: string;
	agentPosition: Position;
	agentRevealed: boolean;
	hunterPositions: Array<{
		playerId: string;
		x: number;
		y: number;
	}>;
	missionProgress: {
		objectivesCompleted: number;
		totalObjectives: number;
		completedObjectiveIds: string[];
	};
	equipmentState: {
		agentCards: string[];
		hunterCards: string[];
	};
}

export interface GameSettings {
	board: 'museum' | 'facility';
	missionId: string;
	maxRounds: number;
	hunterCount: number;
	variant: 'standard' | 'advanced';
}

export interface Game {
	id: string;
	createdAt: string;
	updatedAt: string;
	status: 'setup' | 'in_progress' | 'completed';
	currentRound: number;
	winner?: 'agent' | 'hunters';
	gameState: GameState;
	settings: GameSettings;
	players?: Player[];
}
