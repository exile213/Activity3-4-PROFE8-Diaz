# Drone & Aerial Survey Service App

A Flutter application demonstrating forms and input handling through a professional drone and aerial survey service business interface.

## Description

This app showcases various Flutter form widgets and validation techniques through a real-world themed application. Users can register, login, book drone services, manage reservations, and view booking history. The app features a clean Material Design interface with a bottom navigation bar for easy access to all features.

## Project Structure

```
lib/
 ┣ main.dart                          # App entry point with BottomNavigationBar
 ┣ pages/
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

## Features & Implementation

### Task 1: Simple Form with TextFormField

**Requirement:** Create a simple form with a TextFormField for entering a username.

**Implementation:**

- Created `WelcomePage` with a username input field
- Used `CustomFormField` widget (reusable TextFormField)
- Added submit button that displays the entered username
- Shows confirmation message using SnackBar

---

### Task 2: Login Form

**Requirement:** Build a login form with two fields (email and password) and a submit button.

**Implementation:**

- Created `LoginPage` with email and password fields
- Used `CustomFormField` widget for both inputs
- Password field has `obscureText: true` for security
- Email field uses `TextInputType.emailAddress` keyboard type

---

### Task 3: Form Validation

**Requirement:** Add form validation to check if the email field contains "@" and password is not empty.

**Implementation:**

- Implemented `_validateEmail()` method that checks for "@" symbol
- Implemented `_validatePassword()` method that checks for non-empty input
- Validation errors display below respective fields
- Form submission blocked until validation passes

---

### Task 4: GlobalKey for Form Management

**Requirement:** Use a GlobalKey<FormState> to manage form validation and submission.

**Implementation:**

- Created `_formKey = GlobalKey<FormState>()` in LoginPage
- Wrapped form fields in `Form` widget with the key
- Used `_formKey.currentState!.validate()` on submit
- Only processes login when validation returns true

---

### Task 5: Mixed Input Types

**Requirement:** Create a form with different input types: TextField, Checkbox, and Switch.

**Implementation:**

- Created `ServiceOptionsPage` with three input types:
  - TextField for drone model preference
  - Checkbox for "Need Pilot Assistance?"
  - Switch for "Include Insurance?"
- Used custom reusable widgets for each input type
- State management tracks all input values

---

### Task 6: Registration Form

**Requirement:** Build a registration form with name, email, password, and confirm password fields.

**Implementation:**

- Created `RegisterPage` with four text fields
- Validates all fields are filled
- Validates email contains "@"
- Validates password and confirm password match
- Uses `GlobalKey<FormState>` for form validation

---

### Task 7: Dropdown Menu

**Requirement:** Implement a dropdown menu inside a form to select a user's role (e.g., Admin, User).

**Implementation:**

- Added `CustomDropdown` widget in RegisterPage
- Three role options: "Client", "Drone Pilot", "Admin"
- Dropdown integrated with form validation
- Selected role stored in state

---

### Task 8: Date and Time Pickers

**Requirement:** Add a date picker and time picker input to a form.

**Implementation:**

- Created `ReservationPage` for booking drone schedules
- Implemented `CustomDatePicker` using `showDatePicker()`
- Implemented `CustomTimePicker` using `showTimePicker()`
- Date formatted using `intl` package
- Selected date and time displayed in form fields

---

### Task 9: TextEditingController Usage

**Requirement:** Use a controller to capture and display text from a TextField after pressing a button.

**Implementation:**

- Created `NotesPage` for flight instructions/notes
- Used `TextEditingController` to manage text input
- Button captures controller text and displays it below
- Demonstrates direct text manipulation with controllers

---

### Task 10: Local Data Persistence

**Requirement:** Create a form that saves data into a local list and displays the submitted inputs below the form.

**Implementation:**

- Created `BookingHistoryPage` with booking form
- Form captures service type and location
- Data saved to local `List<Map<String, String>>`
- Uses `ListView.builder` to display all bookings
- Each booking shown in a card below the form

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
