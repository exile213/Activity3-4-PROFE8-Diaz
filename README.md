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

**Implemented in:** `lib/views/welcome_page.dart`

### Task 2: Build a login form with two fields (email and password) and a submit button.

**Implemented in:** `lib/views/login_page.dart`

### Task 3: Add form validation to check if the email field contains "@" and password is not empty.

**Implemented in:** `lib/views/login_page.dart`

### Task 4: Use a GlobalKey<FormState> to manage form validation and submission.

**Implemented in:** `lib/views/login_page.dart`

### Task 5: Create a form with different input types: TextField, Checkbox, and Switch.

**Implemented in:** `lib/views/service_options_page.dart`

### Task 6: Build a registration form with name, email, password, and confirm password fields.

**Implemented in:** `lib/views/register_page.dart`

### Task 7: Implement a dropdown menu inside a form to select a user's role (e.g., Admin, User).

**Implemented in:** `lib/views/register_page.dart`

### Task 8: Add a date picker and time picker input to a form.

**Implemented in:** `lib/views/reservation_page.dart`

### Task 9: Use a controller to capture and display text from a TextField after pressing a button.

**Implemented in:** `lib/views/notes_page.dart`

### Task 10: Create a form that saves data into a local list and displays the submitted inputs below the form.

**Implemented in:** `lib/views/booking_history_page.dart`

The app uses a `BottomNavigationBar` with 4 tabs:

- **Home** → Welcome Page
- **Services** → Service Options & Reservation Pages
- **Bookings** → Booking History Page
- **Profile** → Login, Register & Notes Pages
