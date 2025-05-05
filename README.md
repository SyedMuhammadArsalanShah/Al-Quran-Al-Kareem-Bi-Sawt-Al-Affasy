

# **Al-Quran Al-Kareem Bi Sawt Al-Affasy - Quran Audio Player**

A beautifully designed and feature-rich Quran audio player app that provides an immersive experience for listening to Quranic verses. The app allows users to listen to Quranic recitations by Sheikh Al-Affasy, with various features such as playback controls, adjustable speed, repeat, shuffle, and more. It's designed with a modern and engaging user interface inspired by popular streaming apps.

## **Features**
- **Audio Playback**: Play Quranic verses from any Surah, with the ability to pause, play, skip forward, or backward.
- **Repeat and Shuffle**: Toggle between repeat mode and shuffle mode for dynamic playback.
- **Adjustable Playback Speed**: Choose from multiple playback speeds, ranging from 1.0x to 2.0x.
- **Ayah Text Display**: Show or hide the Ayah text while the audio plays.
- **Seek Bar**: Use the seek bar to skip to any part of the Surah.
- **Surah Navigation**: Skip between Surahs or go to the previous/next Surah.
- **Teal Theme**: A modern and elegant teal-based theme for a refreshing experience.
- **Dark Mode (Temporary)**: Toggle between light and dark modes for improved user experience.
- **Surah Transitions**: Smooth transitions between Surahs for a more engaging experience.

## **Getting Started**

These instructions will help you set up and run the project on your local machine for development and testing purposes.

### **Prerequisites**

Ensure you have the following installed:
- Flutter 2.x or higher
- Dart 2.x or higher
- Android Studio, VS Code, or another compatible IDE

### **Clone the repository**

```bash
git clone https://github.com/your-username/al-quran-audio-player.git
cd al-quran-audio-player
```

### **Install Dependencies**

Navigate to the project directory and install the necessary dependencies:

```bash
flutter pub get
```

### **Run the App**

To run the app on an emulator or a physical device, execute the following command:

```bash
flutter run
```

Ensure that you have an emulator or a physical device connected before running the app.

## **App Structure**

Here is a quick overview of the file structure:

```
/lib
  /assets
    - alaffasy.png                # Image of Sheikh Al-Affasy
  /screens
    - detail_audio.dart           # Main audio player screen
  /widgets
    - audio_controls.dart         # Custom audio control widgets
    - seek_bar.dart               # Custom seek bar widget
  - main.dart                     # Main entry point for the app
/pubspec.yaml                    # Flutter project configuration
```

## **Dependencies**

This app uses the following Flutter packages:
- `just_audio`: A Flutter package for audio playback.
- `quran`: A package for retrieving Quranic verses and audio URLs.
- `google_fonts`: A package for using Google Fonts in the app.

## **Customization**

- **Theme**: You can easily customize the app’s theme by modifying the colors in the `DetailAudio` screen. The app currently uses a **Teal** color scheme, but you can change it to suit your preferences.
- **Audio Source**: The app fetches Quranic audio from an online source. If you want to use a different source, update the `getAudioURLBySurah` function in the `quran` package accordingly.
- **Surah Transitions**: You can adjust or modify the Surah transitions as needed by customizing the animations or transitions logic in the `DetailAudio` screen.

## **Contributing**

Contributions are welcome! Feel free to fork the repository, create a new branch, and submit a pull request.

### **Steps for contributing:**
1. Fork the repository
2. Create a new feature branch (`git checkout -b feature/your-feature-name`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature-name`)
5. Create a new pull request

## **License**

This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more details.

## **Project Demo**
https://youtube.com/shorts/tReui6xv6KE?si=bdfer_yWhyZU1AKn