# 2D Educational Memory Card Game 🧩

A single-player, cross-platform educational memory card game developed using the Godot Engine. Designed specifically to be accessible, performant, and engaging, the game targets both Desktop (PC) and Mobile (Android APK) platforms with seamless touch and mouse input integration.

## 🎯 Key Features
* **Cross-Platform Play:** Fully functional on both desktop platforms (using mouse interactions) and mobile Android devices (using touch inputs).
* **Dynamic Grid System:** Cards are spawned dynamically using an array-based GridContainer approach, offering higher visual quality and smoother tween-based flip animations compared to standard TileMap solutions.
* **Algorithmic Scoring:** Includes a custom scoring algorithm that calculates final points based on time spent and the number of clicks used per level.
* **Difficulty Scaling:** Features multiple difficulty levels (8 to 24 card pairs) by dynamically adjusting the array length and grid columns.

## 🏗️ Architecture & Technical Highlights
The system architecture was strictly designed with scalability and separation of concerns in mind:
* **Modular Scene Design:** Core components (Main Menu, Game Scene, Card Objects, HUD) are isolated into reusable modules/prefabs.
* **Decoupled UI & Logic:** The game logic and User Interface communicate entirely via Godot's Signal system, eliminating rigid dependencies and making the codebase highly maintainable.
* **Centralized State Management:** A dedicated `GameManager` script acts as the core coordinator, handling timers, matching logic, and state transitions without being directly tied to a specific visual scene.

## 📂 Documentation & Presentation
This repository includes not only the source code but also the architectural documentation and academic presentation materials demonstrating the Software Development Life Cycle (SDLC) behind the project. Please check the `/documents` folder for detailed UML diagrams, interaction modeling, and non-functional requirement analysis.

## 💻 Tech Stack
* **Engine:** Godot Engine
* **Language:** GDScript
* **Platforms:** Desktop (PC), Mobile (Android)
* **Architecture Concepts:** Signal-Based Communication, Modular Component Design, Decoupled Logic
