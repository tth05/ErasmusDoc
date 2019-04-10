## Building

1. Download and install flutter https://flutter.dev/docs/get-started/install
2. Download and install the android sdk. (You can download Android Studio and it will do this for you)
3. Clone this repo and the [custom version of zefyr](https://github.com/tth05/zefyr) to the same directory
    `git clone https://github.com/tth05/ErasmusDoc`, `git clone https://github.com/tth05/zefyr`
4. Download the flutter and dart plugins for your IDE
5. Open the project and change the signingConfigs from release to debug for testing
6. Run `flutter packages get` in the root directory
7. Generate the json files `flutter packages pub run build_runner build`
8. Build the app `flutter build apk`
