# 📒 Contact Diary App

A sleek, Samsung-inspired contact diary app built using Flutter! The app provides an intuitive UI for managing contacts and allows users to permanently store, edit, delete, hide, call, and message contacts on their device. The theme is customizable, and state management is handled using the Provider package for smooth functionality.

---

## ✨ Features

- **Samsung-inspired UI**: Designed to resemble the clean, minimalist look of Samsung's contact manager.
- **Add, Edit, Delete Contacts**: Easily add new contacts or modify existing ones. Contacts are stored permanently on the device.
- **Hide Contacts**: Users can hide specific contacts for privacy, with the option to reveal them as needed.
- **Call & Message Contacts**: Initiate calls or send messages directly from the app.
- **Change Theme**: Customize the app’s theme to match your personal style.
- **Persistent Storage**: Contact information is stored using Shared Preferences, ensuring data is kept even after the app is closed.
- **Profile Image Support**: Add a profile picture for each contact using the `image_picker` package.
- **Responsive Design**: Supports various screen sizes for an optimal experience on any device.

---

## 🛠️ Technologies & Packages

- **Flutter**: Built using Flutter's rich widget library.
- **Provider**: State management solution to handle contact data efficiently.
- **Shared Preferences**: Persistent storage for saving contacts locally.
- **Image Picker**: Allows users to select images from their gallery or take new photos for contact profiles.
- **URL Launcher**: Enables calling and messaging functionality.

---

## 📸 Screenshots

### Splash Screen
<img src="https://github.com/user-attachments/assets/3b61428a-3214-4df6-87fa-d803c8d594e5" height="400em">

### Home Page
<img src="https://github.com/user-attachments/assets/759f0528-2d4c-445d-a6e7-69c9e3b2ba06" height="400em">
<img src="https://github.com/user-attachments/assets/5955046b-4c92-44af-b5b4-fb9180e40abb" height="400em">
<img src="https://github.com/user-attachments/assets/85859d1f-dca4-44bb-8415-e860d320a8c6" height="400em">
<img src="https://github.com/user-attachments/assets/be6f48ec-3077-4dcf-8851-7750bd7cd7c1" height="400em">

### Add Contacts Page
<img src="https://github.com/user-attachments/assets/2a20ce82-07e8-49ac-b01a-a01eae249e29" height="400em">

### Details Page
<img src="https://github.com/user-attachments/assets/086c0b67-bf5d-44c2-bc06-a1854215cf03" height="400em">
<img src="https://github.com/user-attachments/assets/6eeced96-d26b-4583-8d2b-cc8e8f7fce8b" height="400em">

### Edit Contacts Page
<img src="https://github.com/user-attachments/assets/ae6a9ed9-0b4e-4318-ada7-4a06aba68bf0" height="400em">

### Video Output

[![Watch the video](https://github.com/user-attachments/assets/0b64e09c-8c7e-4f32-bac8-210df7a6afc6)](https://github.com/user-attachments/assets/0b64e09c-8c7e-4f32-bac8-210df7a6afc6)

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A compatible IDE (e.g., Android Studio, VS Code)

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/contact-diary-app.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd contact-diary-app
    ```

3. **Install dependencies:**

    ```bash
    flutter pub get
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

---

## 📄 Code Structure

### Main Files

- `main.dart`: Initializes the app and sets up the theme.
- `providers/contact_provider.dart`: Manages contact data with Provider.
- `screens/contact_list_screen.dart`: Displays the list of saved contacts.
- `screens/add_edit_contact_screen.dart`: Allows users to add or edit contacts.
- `screens/settings_screen.dart`: Provides options for theme customization.
- `utils/shared_preferences_helper.dart`: Manages storage and retrieval of contact data.

---

## 📦 Key Code Sections

### Provider Setup for Contact Management

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
    // Save to shared preferences
  }

  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
    // Update shared preferences
  }

  void editContact(String id, Contact newContact) {
    final index = _contacts.indexWhere((contact) => contact.id == id);
    _contacts[index] = newContact;
    notifyListeners();
    // Update shared preferences
  }

  Future<void> callContact(String phoneNumber) async {
    final uri = 'tel:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    }
  }

  Future<void> messageContact(String phoneNumber) async {
    final uri = 'sms:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    }
  }
}
