# Drone & Aerial Survey Service App

A Flutter application demonstrating forms and input handling through a professional drone and aerial survey service business interface.

## Description

This app showcases various Flutter form widgets and validation techniques through a real-world themed application. Users can register, login, book drone services, manage reservations, and view booking history. The app features a clean Material Design interface with a bottom navigation bar for easy access to all features.

## Project Structure

```
lib/
 ┣ main.dart                          # App entry point with BottomNavigationBar
 ┣ views/
 ┃ ┣ welcome_page.dart                # Home page with username form
 ┃ ┣ login_page.dart                  # Login with validation
 ┃ ┣ register_page.dart               # Registration with role dropdown
 ┃ ┣ service_options_page.dart        # Service options with mixed inputs
 ┃ ┣ reservation_page.dart            # Booking with date & time pickers
 ┃ ┣ notes_page.dart                  # Flight notes with TextEditingController
 ┃ ┗ booking_history_page.dart        # Booking history with local storage
 ┗ widgets/
   ┣ custom_form_field.dart           # Reusable TextFormField
   ┣ custom_dropdown.dart             # Reusable DropdownButtonFormField
   ┣ custom_checkbox.dart             # Reusable CheckboxListTile
   ┣ custom_switch.dart               # Reusable SwitchListTile
   ┣ custom_date_picker.dart          # Reusable date picker
   ┣ custom_time_picker.dart          # Reusable time picker
   ┗ custom_button.dart               # Reusable styled button
```

## Tasks & Implementation

### Task 1: Create a simple form with a TextFormField for entering a username.

**Implementation:** `WelcomePage` with username input field and submit button.

### Task 2: Build a login form with two fields (email and password) and a submit button.

**Implementation:** `LoginPage` with email and password fields using `CustomFormField` widgets.

### Task 3: Add form validation to check if the email field contains "@" and password is not empty.

**Implementation:** Added validation methods in `LoginPage` - email must contain "@" and password cannot be empty.

### Task 4: Use a GlobalKey<FormState> to manage form validation and submission.

**Implementation:** Implemented `GlobalKey<FormState>` in `LoginPage` to manage form validation.

### Task 5: Create a form with different input types: TextField, Checkbox, and Switch.

**Implementation:** `ServiceOptionsPage` with TextField (drone model), Checkbox (pilot assistance), and Switch (insurance).

### Task 6: Build a registration form with name, email, password, and confirm password fields.

**Implementation:** `RegisterPage` with name, email, password, and confirm password fields with validation.

### Task 7: Implement a dropdown menu inside a form to select a user's role (e.g., Admin, User).

**Implementation:** Added `CustomDropdown` in `RegisterPage` with roles: Client, Drone Pilot, Admin.

### Task 8: Add a date picker and time picker input to a form.

**Implementation:** `ReservationPage` with `CustomDatePicker` and `CustomTimePicker` for booking schedules.

### Task 9: Use a controller to capture and display text from a TextField after pressing a button.

**Implementation:** `NotesPage` using `TextEditingController` to capture and display flight notes.

### Task 10: Create a form that saves data into a local list and displays the submitted inputs below the form.

**Implementation:** `BookingHistoryPage` with form that saves bookings to a local list and displays them using `ListView.builder`.

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  intl: ^0.19.0 # For date formatting
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Navigation

The app uses a `BottomNavigationBar` with 4 tabs:

- **Home** → Welcome Page
- **Services** → Service Options & Reservation Pages
- **Bookings** → Booking History Page
- **Profile** → Login, Register & Notes Pages
