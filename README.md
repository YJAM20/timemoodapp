# ⏳ Time Mood Visualizer  
A minimal, artistic Flutter app that transforms the current time into a visual “mood” using colors, gradients, and soft animations.

Instead of showing the time in numbers, the app expresses it through motion and color — turning the screen into a small, living artwork.

---

## 🎨 Concept

Time is represented through:
- **Color changes** based on hour ranges (morning → warm; night → deep & calm).
- **Brightness / saturation** shifts based on minutes.
- **Soft animated elements** that respond to passing seconds.

No digits, no clock hands — just an abstract visual of time.

The goal is a calm, simple, and slightly experimental experience.

---

## ✨ Features

### **🌈 Time-Based Color System**
- Dynamic gradient/background changes according to:
  - Hour → overall hue
  - Minute → intensity/brightness
  - Second → subtle animations
- Mapping logic is isolated in a clean `TimeColorMapper` service.

### **🎞 Animated Visualization**
- Central animated shapes (e.g., mood ring / orbiting dot).
- Smooth transitions using Flutter’s animation tools.
- No heavy effects — the app stays light and fluid.

### **🖐 Simple Interactions**
- **Tap:** Switch between predefined visual themes.  
- **Long Press:** Change the visualization pattern (circular, linear, etc.).  
- **Swipe Up:** Reveal a brief, time-aware message like:
  - _“New day, new energy.”_
  - _“Keep going.”_
  - _“Slow down.”_

### **📂 Clean Architecture**
Organized project structure:
lib/
main.dart
services/
time_color_mapper.dart
widgets/
mood_background.dart
animated_shapes.dart
theme/
app_theme.dart

yaml
Copy code

### **🛠 Tech**
- Flutter (latest stable)
- Null safety
- No backend — fully offline
- Minimal dependencies

---

## 🚀 Getting Started

### **Clone the repository**
```bash
git clone https://github.com/YJAM20/timemoodapp.git
cd timemoodapp
Install dependencies
bash
Copy code
flutter pub get
Run the app
bash
Copy code
flutter run
📸 Screenshots (Coming Soon)
You can add screenshots or GIFs here once the UI is complete.

🧩 Project Goals
The project is intentionally small and focused.
It’s meant to demonstrate:

Clean, readable Flutter code

Animation fundamentals

Creative UI work

Good project structure

A unique app concept

Perfect as a portfolio piece.

📄 License
This project is open-source and available under the MIT License.

👤 Author
Yaman Jehad Muhanna
Flutter Developer & Software Engineering Student
GitHub: YJAM20
