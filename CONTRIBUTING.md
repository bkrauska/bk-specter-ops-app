# Contributing to Specter Ops

Thank you for your interest in contributing to Specter Ops! This document provides guidelines and instructions for contributing.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

### Our Pledge
We are committed to providing a welcoming and inclusive environment for all contributors.

### Expected Behavior
- Be respectful and considerate
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Accept criticism gracefully

### Unacceptable Behavior
- Harassment or discriminatory language
- Trolling or insulting comments
- Publishing others' private information
- Any conduct that could be considered inappropriate in a professional setting

## Getting Started

### Prerequisites
1. Read the [PROJECT_OVERVIEW.md](docs/context/PROJECT_OVERVIEW.md)
2. Set up your development environment following [LOCAL_DEVELOPMENT.md](docs/setup/LOCAL_DEVELOPMENT.md)
3. Familiarize yourself with the codebase structure

### First Time Contributors
Look for issues labeled `good-first-issue` or `help-wanted`. These are great starting points!

## How to Contribute

### Reporting Bugs
Use the bug report template when creating an issue:
1. Go to Issues → New Issue → Bug Report
2. Provide clear steps to reproduce
3. Include expected vs actual behavior
4. Add screenshots if applicable
5. Specify your environment (OS, browser, versions)

### Suggesting Features
Use the feature request template:
1. Go to Issues → New Issue → Feature Request
2. Describe the problem you're solving
3. Explain your proposed solution
4. Consider alternatives and trade-offs

### Code Contributions
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests
5. Submit a pull request

## Development Workflow

### 1. Fork and Clone
```bash
# Fork via GitHub UI, then:
git clone https://github.com/YOUR_USERNAME/specter-ops-companion.git
cd specter-ops-companion
```

### 2. Create Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests

### 3. Make Changes
Follow the coding standards outlined below.

### 4. Run Tests
```bash
# Backend
cd backend/src/SpecterOps.Tests
dotnet test

# Frontend
cd frontend
npm test
```

### 5. Commit Changes
Follow the commit guidelines below.

### 6. Push and Create PR
```bash
git push origin feature/your-feature-name
```
Then create a pull request via GitHub.

## Coding Standards

### C# (Backend)

#### Style Guidelines
- Follow [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- Use PascalCase for public members
- Use camelCase for private fields (with underscore prefix: `_fieldName`)
- Use meaningful names

#### Example
```csharp
public class GameService
{
    private readonly IGameRepository _gameRepository;

    public GameService(IGameRepository gameRepository)
    {
        _gameRepository = gameRepository;
    }

    public async Task<Game> CreateGameAsync(GameSettings settings)
    {
        // Implementation
    }
}
```

#### Tests
- Use xUnit framework
- Name tests clearly: `MethodName_Scenario_ExpectedBehavior`
- Follow Arrange-Act-Assert pattern

```csharp
[Fact]
public async Task CreateGame_WithValidSettings_ReturnsNewGame()
{
    // Arrange
    var settings = new GameSettings { Board = "museum" };

    // Act
    var game = await _gameService.CreateGameAsync(settings);

    // Assert
    Assert.NotNull(game);
    Assert.Equal("museum", game.Settings.Board);
}
```

### TypeScript/Svelte (Frontend)

#### Style Guidelines
- Use TypeScript for type safety
- Follow [Svelte Style Guide](https://svelte.dev/docs/style-guide)
- Use camelCase for variables and functions
- Use PascalCase for components

#### Component Example
```svelte
<script lang="ts">
	import type { Game } from '$lib/types/game';

	export let game: Game;

	function handleMove() {
		// Implementation
	}
</script>

<div class="game-board">
	<h2>{game.settings.board}</h2>
	<button on:click={handleMove}>Move</button>
</div>
```

#### Tests
```typescript
import { describe, it, expect } from 'vitest';
import { render } from '@testing-library/svelte';
import GameBoard from './GameBoard.svelte';

describe('GameBoard', () => {
	it('renders board correctly', () => {
		const { getByText } = render(GameBoard, {
			props: { game: mockGame }
		});

		expect(getByText('museum')).toBeInTheDocument();
	});
});
```

### SQL
- Use snake_case for table and column names
- Always include comments for complex queries
- Use meaningful names

## Commit Guidelines

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks

### Examples
```
feat(game): add line of sight calculation

Implement Bresenham's algorithm for LOS checks between hunters and agent.
Includes wall collision detection.

Closes #42
```

```
fix(api): correct movement validation logic

Movement validation was not properly checking diagonal movement costs.

Fixes #58
```

## Pull Request Process

### Before Submitting
- [ ] Code follows style guidelines
- [ ] Tests pass locally
- [ ] New tests added for new features
- [ ] Documentation updated
- [ ] Self-review completed
- [ ] No console errors

### PR Template
Your PR will automatically use our template. Please fill out:
- Description of changes
- Related issue numbers
- Type of change (bugfix, feature, etc.)
- Testing performed
- Screenshots (if UI changes)

### Review Process
1. Automated checks must pass (CI/CD)
2. At least one maintainer review required
3. Address feedback and update PR
4. Maintainer will merge when approved

### After Merge
- Delete your feature branch
- Update local main branch
- Close related issues if not auto-closed

## Documentation

### When to Update Docs
- New features added
- API changes
- Configuration changes
- Deployment process changes

### Where to Update
- `/docs/context/` - Game rules and specifications
- `/docs/architecture/` - Architecture decisions
- `/docs/setup/` - Setup and deployment guides
- Code comments - Complex logic

## Questions?

- Check existing documentation in `/docs`
- Search existing issues
- Ask in discussions or create a new issue

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Specter Ops! 🎮
