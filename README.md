# Hospital on Wheels

Hospital on Wheels is a Flutter application for a healthcare provider in Mukono, Uganda. It introduces the hospital and its services, provides location information, and lets visitors submit an appointment request form.

## Features

- Responsive home page with hospital information, care highlights, and location details.
- Appointment request form with patient details, service selection, preferred date, and optional notes.
- Shared app theme, reusable widgets, and animated page sections.
- Flutter support for mobile, desktop, and web.

> **Appointment requests are not saved yet.** The form currently validates its fields and displays a local confirmation message. Although Firebase packages and a Firestore appointment service are present, the app does not initialize Firebase or connect the form to Firestore.

## Requirements

- Flutter SDK with Dart 3.13.4 or later (compatible with the constraint in `pubspec.yaml`).
- For web hosting: the Firebase CLI, a Firebase account, and access to the configured Firebase project.

## Run locally

Install dependencies and start the app:

```sh
flutter pub get
flutter run
```

To launch in a browser:

```sh
flutter run -d chrome
```

## Test

Run the Flutter widget tests:

```sh
flutter test
```

## Firebase Hosting

Firebase Hosting is configured to serve the Flutter web build from `build/web`, with a rewrite to `index.html` for client-side routes. The default Firebase project alias is `uganda1` in `.firebaserc`.

Build and deploy the web app:

```sh
flutter build web
firebase deploy --only hosting
```

Deployment requires the Firebase CLI to be installed and authenticated, and the selected Firebase project to be accessible. Firebase client SDK initialization and platform-specific Firebase app configuration have not been set up in this project; configure them before enabling Firebase-backed app features.

## Project structure

```text
lib/
  core/       App colors and theme
  screens/    Home and appointment pages
  services/   Appointment data service
  widgets/    Shared interface components
  assets/     Hospital images
test/         Flutter widget tests
```
