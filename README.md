# Neighbors Rescue Prototype

This repository contains a Godot 4 prototype inspired by **Zombies Ate My Neighbors**. It focuses on a single-player sandbox where a hero can move, aim, and fire a water-gun analogue at pursuing zombies inside a small arena.

## Project Structure

- `project.godot` – Godot project configuration.
- `scenes/` – Packaged scenes for the main world, player, zombies, and bullets.
- `scripts/` – GDScript logic that powers gameplay.
- `docs/research.md` – Reference notes on mechanics and expansion goals drawn from the original game.

## Getting Started

1. Install [Godot 4.x](https://godotengine.org/).
2. Open the project folder (`testingcodex`) in the Godot editor.
3. Run the scene to play the prototype.

### Controls

- **Move**: WASD or arrow keys
- **Aim**: Mouse cursor (player rotates toward the cursor)
- **Shoot**: Hold left mouse button or press Spacebar

## Current Features

- Responsive top-down movement with acceleration and friction.
- Automatic mouse-facing orientation and continuous squirt-gun firing.
- Simple zombie AI that chases and damages the player on contact.
- Bullet collisions that remove zombies.
- Blocked-out arena with boundary walls and a few obstacles.

## Next Steps

See [`docs/research.md`](docs/research.md) for design research and follow-up tasks such as adding neighbors to rescue, inventory swapping, co-op, and richer monster behavior.
