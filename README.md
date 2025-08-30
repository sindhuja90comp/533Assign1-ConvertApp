
# Unit Converter

A simple and modern Flutter app to convert between Metric and Imperial units for distance and weight.

---

## Features

- Convert between kilometers, miles, metres, centimeters, kilograms, pounds, and grams
- Clean and modern UI with Material 3 design
- Supports both Metric and Imperial units
- Instant conversion and swap functionality
- Input validation and helpful error messages

---
## Getting Started

### Prerequisites

# Flutter + VS Code + Emulator Setup (macOS)

## Steps

1) **Download Flutter**
   - Go to [https://flutter.dev](https://flutter.dev) → **Get Started → macOS** → Download the zip → extract to a folder like `software` or `development`.
   - **Important:** If you extracted it inside `Documents`, move it to `~/development/flutter` to avoid macOS permission issues:
     ```bash
     mkdir -p ~/development
     mv ~/Documents/software/flutter ~/development/flutter
     ```

2) **Copy Flutter folder path**
   - In Finder → right-click the `flutter` folder → **Copy "flutter" as Pathname**.

3) **Add Flutter to PATH**
   - In Terminal and paste the copied path:
     ```bash
     echo 'export PATH="$PATH:PASTE_PATH_HERE/bin"' >> ~/.zshenv
     source ~/.zshenv
     ```
   - Replace `PASTE_PATH_HERE` with the actual path you copied (e.g., `/Users/prithviraj/development/flutter`).

4) **Verify Flutter**
   - Close Terminal → open a new one → run:
     ```bash
     flutter --version
     flutter doctor
     ```
   - It should show Flutter version and checks.

5) **Install VS Code**
   - Add **Flutter** and **Dart** extensions from the Extensions tab.

6) **Create & run your app**
   ```bash
   flutter create unit_converter
   cd unit_converter
   flutter run
   ```
   - Pick the running emulator when asked.

---

## Details

### Explanation
- `echo 'export PATH="$PATH:PASTE_PATH_HERE/bin"' >> ~/.zprofile` → permanently adds Flutter’s `bin` folder to your system PATH so the terminal knows where Flutter is.
- `source ~/.zprofile` → reloads the settings so you don’t have to restart the terminal.

---

### Add Flutter to the PATH
Steps you followed to set Flutter in PATH:
```bash
nano ~/.zshenv
export PATH=<path-to-your-flutter-folder>/bin:$PATH
source ~/.zshenv
flutter --version
```

---

### Android Studio & Emulator Setup

1) **Download Android Studio**
   - [https://developer.android.com/studio](https://developer.android.com/studio)

2) **Open Android Studio**
   - Welcome screen → **More Actions → SDK Manager** → install **Android SDK**, **Platform-Tools**, **Android Emulator**.

3) **Install SDK Platform & System Image**
   - SDK Platforms → API 34 ext 12
   - System Images → **Google APIs Intel x86_64 Atom System Image** (Intel) or **Google Play ARM64** (Apple Silicon)

4) **Create Emulator (AVD)**
   - **More Actions → Virtual Device Manager → Create Device** → Pixel 6 → Download system image → Finish

5) **Start Emulator**
   - Virtual Device Manager → **Play**

6) **Accept Android Licenses**
   ```bash
   flutter doctor --android-licenses
   flutter doctor
   ```

---

### Xcode Setup (for iOS/macOS apps)

1) **Install Xcode**
   - Download from App Store → open → accept license

2) **Point to Xcode tools & initialize**
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

3) **Install CocoaPods**
   ```bash
   brew install cocoapods
   pod setup
   pod --version
   ```

4) **Fix Documents folder warning**
   ```bash
   chmod 755 ~/Documents
   ```

5) **Verify**
   ```bash
   flutter doctor
   ```

---

## Issues Faced in the Setup

### 1) Flutter command not found
**Issue:** Flutter not recognized in terminal  
**Solution:**  
```bash
echo 'export PATH="$PATH:<path-to-your-flutter-folder>/bin"' >> ~/.zshenv
source ~/.zshenv
flutter --version
```

### 2) Android SDK not found / sdkmanager missing
**Issue:** sdkmanager not found  
**Solution:** Install **Command-line Tools (latest)** via SDK Manager, then:  
```bash
echo 'export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk' >> ~/.zshenv
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator' >> ~/.zshenv
source ~/.zshenv
```

### 3) Ruby version too old for CocoaPods
**Issue:** macOS Ruby 2.6 too old  
**Solution:** Install newer Ruby:  
```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshenv
source ~/.zshenv
ruby -v
```

### 4) CocoaPods install errors
**Issue:** Permissions and version errors  
**Solution:**  
```bash
gem install cocoapods
pod setup
pod --version
chmod 755 ~/Documents
```
Reference: [CocoaPods Installation Guide](https://guides.cocoapods.org/using/getting-started.html#installation)

### 5) Xcode version warning
**Issue:** Older Xcode version warning  
**Solution:**  
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

---

## References

1) Flutter official docs – [https://flutter.dev/docs](https://flutter.dev/docs)
2) Android Studio setup – [https://developer.android.com/studio](https://developer.android.com/studio)
3) CocoaPods installation – [https://guides.cocoapods.org/using/getting-started.html#installation](https://guides.cocoapods.org/using/getting-started.html#installation)
4) Homebrew Ruby installation – [https://brew.sh/](https://brew.sh/)
5) Apple Xcode tools – [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)
