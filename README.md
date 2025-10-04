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

## Activity 3 Tasks & Implementation

### Task 1: Create a simple form with a TextFormField for entering a username.

**Implementation:** WelcomePage features a username input field with submit button that displays the entered username below the form.

### Task 2: Build a login form with two fields (email and password) and a submit button.

**Implementation:** LoginPage contains email and password CustomFormField widgets with a login submit button.

### Task 3: Add form validation to check if the email field contains "@" and password is not empty.

**Implementation:** LoginPage uses custom validator functions that check email contains "@" symbol and password is not empty.

### Task 4: Use a GlobalKey<FormState> to manage form validation and submission.

**Implementation:** LoginPage implements GlobalKey<FormState> with \_formKey.currentState!.validate() to manage form validation.

### Task 5: Create a form with different input types: TextField, Checkbox, and Switch.

**Implementation:** ServiceOptionsPage includes CustomFormField (drone model), CustomCheckbox (pilot assistance), and CustomSwitch (insurance).

### Task 6: Build a registration form with name, email, password, and confirm password fields.

**Implementation:** RegisterPage contains four CustomFormField widgets for name, email, password, and confirm password with validation.

### Task 7: Implement a dropdown menu inside a form to select a user's role (e.g., Admin, User).

**Implementation:** RegisterPage includes CustomDropdown with three role options: Client, Drone Pilot, and Admin.

### Task 8: Add a date picker and time picker input to a form.

**Implementation:** ReservationPage features CustomDatePicker and CustomTimePicker widgets for scheduling drone services.

### Task 9: Use a controller to capture and display text from a TextField after pressing a button.

**Implementation:** NotesPage uses TextEditingController to capture mission notes and displays them in a styled container below.

### Task 10: Create a form that saves data into a local list and displays the submitted inputs below the form.

**Implementation:** BookingHistoryPage has a form above the list that saves survey bookings to local List<Map<String, String>> and displays them using ListView.builder below.

## Navigation Structure

The app uses a `BottomNavigationBar` with 4 tabs:

- **Home** → Welcome Page (Task 1)
- **Surveying** → Service Options & Reservation Pages (Tasks 5, 8)
- **Bookings** → Booking History Page (Task 10)
- **Profile** → Login, Register & Notes Pages (Tasks 2-4, 6-7, 9)

---

## Activity 4 - Navigation (Stack, Drawer, Bottom Tabs, TabBar)

### Upcoming Tasks (Not Yet Implemented):

1. **Create a Flutter app with two screens and navigate between them using Navigator.push() and Navigator.pop().**

2. **Build an app with a Drawer menu that navigates to three different pages.**

3. **Implement a BottomNavigationBar with three tabs (e.g., Home, Profile, Settings).**

4. **Create a TabBar with TabBarView that switches between two screens inside a Scaffold.**

5. **Add icons to each item in a BottomNavigationBar.**

6. **Combine Drawer and BottomNavigationBar in the same app.**

7. **Implement named routes for three screens: Home, About, and Contact.**

8. **Demonstrate the difference between push() and pushReplacement() using two screens.**

9. **Create a TabBar inside an AppBar with three tabs (e.g., Chats, Status, Calls).**

10. **Build a navigation flow where a login screen navigates to a home screen, and the home screen contains a Drawer and Bottom Tabs.**

### Notes:

- These navigation tasks will extend the current drone survey app
- Implementation will build upon the existing foundation from Activity 3
- Focus will be on various Flutter navigation patterns and widgets
