# Lyricist

![Demo gif](/../images/screenshots/demo.gif?raw=true)

The app is built with the BLoC architecture pattern.
- It makes http requests to fetch lyrics data from [Musixmatch](https://developer.musixmatch.com/plans) through API calls.
- Then it updates the UI state to present data using a Listview widget.
- Instead of retrieving all of the data at once, it just retrieves data when the user scrolls down the list.
- It uses separate blocs and cubits to separate business logic from UI components.

 Check out all of my flutter projects [here.](https://github.com/MrAlpha786/flutter_projects)

## Installation

- ### Build from source:

  1. Clone the repo

  ```sh
  git clone https://github.com/MrAlpha786/Lyricist
  ```

  2. cd into the project's root directory and run:

  ```sh
  flutter pub get
  ```

  3. Get a [Musixmatch](https://developer.musixmatch.com/plans) API Key.

  4. Edit the following line with your API Key in `/lib/constants.dart` file in project's root folder.:

  ```dart
  const kMusixMatchApiKey = '<--YOUR-API-HERE-->';
  ```

  5. You can test the app in debug mode by running the below command in the project's root directory:

  ```sh
  flutter run
  ```

  6. Follow the [Build and Release](https://docs.flutter.dev/deployment/android) instructions.

## Screenshots

|                     Trending Screen                     |                    Lyrics Screen                    |
| :-----------------------------------------------------: | :-------------------------------------------------: |
| ![welcome](/../images/screenshots/trending.png?raw=true) | ![login](/../images/screenshots/lyrics.png?raw=true) |

|                       Bookmarks Screen                        |
| :-----------------------------------------------------------: |
| ![register](/../images/screenshots/bookmarks.png?raw=true) |
