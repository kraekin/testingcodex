# Zombies Ate My Neighbors Reference Notes

Zombies Ate My Neighbors (LucasArts, 1993) is a top-down run-and-gun game where players rescue neighbors across suburban and horror-themed stages while managing limited weapon ammo and power-ups. Core hallmarks include:

- **Dual-stick style movement and aiming**: characters can move freely while firing in 8 directions, with projectile-based weapons such as squirt guns and bazookas.
- **Rescue objective loop**: each level scatters civilians to save before time or monsters deplete their health.
- **Enemy variety**: zombies are the baseline threat, joined by chainsaw maniacs, mummies, and boss monsters with unique movement and resistances.
- **Inventory management**: players cycle through diverse weapons and items with situational strengths.
- **Cooperative play**: two-player simultaneous action with shared screen.

This prototype targets a modern Godot 4 workflow for cross-platform reach (desktop, consoles via export modules, web, and mobile). Godot provides an open-source toolchain, permissive licensing, built-in 2D physics, and scriptable scenes that map well to the game's modular design (player, neighbors, monsters, weapons, tile-based levels).

## Prototype Goals

1. Establish a responsive top-down controller with mouse aiming and rapid-fire squirt gun analogue.
2. Implement a basic chasing zombie enemy with damage interactions.
3. Block out a compact arena map and collision to prove movement, shooting, and AI.
4. Scaffold systems (signals, exported properties) for future additions: rescuable civilians, pickups, multi-weapon inventory, and co-op.

## Next Steps After Prototype

- **Neighbor rescue loop**: create civilian NPC scenes, rescue counter, and exit portal logic mirroring the original objectives.
- **Weapon variety**: add alternate projectile scenes (spread shot, explosives) and an inventory UI with cycling input.
- **Monster roster**: expand enemy AI behaviors and resistances, including boss encounters and obstacles such as werewolves or chainsaw maniacs.
- **Cooperative mode**: spawn a second player instance with split input mapping and shared camera logic.
- **Level progression**: author tile-based maps with secret areas, keys, and special interactions (hedge mazes, trampolines, etc.).
- **Presentation**: integrate pixel art sprites, soundtrack homage, HUD reminiscent of the original (score, neighbors remaining, item inventory).
