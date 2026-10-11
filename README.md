# Circa Gravity Research — Individual Research Milestone

## Purpose
This Godot 4 sample tests third-person movement, collisions, input, UI events, and configurable gravity for the Circa space-exploration capstone.

## Run
1. Install Godot 4 (standard edition; no .NET required).
2. Open Godot Project Manager and import `project.godot`.
3. Press F6? **Use F5** to run the project.
4. Click the game window to capture the mouse; press Escape to release it.

## Controls
- WASD: move
- Space: jump
- Mouse: look around
- Gravity dropdown: switch between 3.0, 9.8, and 20.0
- Reset Player: reset position and velocity

## Research findings
**Godot 4:** Free/open-source, lightweight, scene/node architecture, GDScript, built-in physics, UI, and export tooling. Tradeoffs: learning Godot's node and signal model; large procedurally generated worlds and realistic planetary gravity require custom code and performance testing.

**Unity:** Mature 3D ecosystem and C# workflow; more packages and learning resources, but larger editor and additional licensing/platform considerations.

**Unreal Engine:** High-end 3D rendering and Blueprints/C++; heavier hardware and steeper complexity for a small capstone prototype.

**Godot packages:** Built-in nodes and engine APIs cover this prototype without third-party add-ons. Future add-ons can be installed through Godot Asset Library or copied into `res://addons/`, with versions tracked in Git.

**Limitations:** This is a flat test environment with vertical gravity, not yet spherical planetary gravity, spaceship flight, or procedural planet generation. These should be evaluated next.

## Suggested personal Git commits
1. `Initialize Godot 4 research project`
2. `Add third-person player and test environment`
3. `Add interactive gravity settings and reset button`

## Video outline (about 60–90 seconds)
Show project running, walk and jump, select low gravity and jump, select high gravity and jump, reset player, explain how this prototype informs Circa's gravity and movement design.

## Research milestone issue
Title: `Research Milestone: ishcheema` (verify your exact GitHub username)

Body:
Individual research prototype in Godot 4 demonstrating player movement, collision, interactive gravity controls, and reset functionality.

Research repository: [paste your personal GitHub repo URL]
Demo video: [paste your video URL]

@instructors

Apply the `enhancement` label and `Proof Of Concept` milestone in the team repository.
## Gravity Research Findings

This prototype demonstrates how different gravity strengths affect player movement and jumping in Godot 4.

Low gravity allows the player to jump higher and stay airborne longer. High gravity results in shorter jumps and faster falls.

The project uses CharacterBody3D for player movement, StaticBody3D for platforms, and CollisionShape3D for collision detection.

These mechanics can help with planetary exploration in Circa.
## Player Controls
- WASD: Move around
- Space: Jump
- Mouse: Look around
- Escape: Release mouse
- Reset Player: Return to starting position
