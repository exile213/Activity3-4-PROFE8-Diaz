# Drone & Aerial Survey Booking App

A Flutter application demonstrating forms and input handling through a professional drone and aerial surv5. **Create a simple to-do list app using Provider for state management.**
_Implementation: TodoProvider with flight preparation checklist in notes page, Consumer widgets for UI updates_

### Media & Assets Tasks

#### Images, Videos, Music, Icons, Fonts

6. **Display a local image using Image.asset().**
   _Implementation: EquipmentCartPage uses Image.asset() for drone equipment with fallback to icons_

7. **Display an image from the internet using Image.network().**
   _Implementation: DroneFleetPage and PilotsPage use Image.network() with loading indicators and error handling_

8. **Add a circular border to an image using BoxDecoration.**
   _Implementation: PilotsPage shows circular profile images using BoxDecoration with shape: BoxShape.circle_

9. **Display a list of images from assets in a GridView.**
   _Implementation: DroneFleetPage contains GridView.builder displaying both network and local asset images_

10. **Implement a video player using the video_player package.**
    *Implementation: TrainingVideosPage with VideoPlayerController for drone training videos with custom controls*usiness interface.

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

### Task 1: Create a Flutter app with two screens and navigate between them using Navigator.push() and Navigator.pop().

**Implementation:** ServiceOptionsPage buttons use Navigator.push() to navigate to ReservationPage, with automatic back button for Navigator.pop().

### Task 2: Build an app with a Drawer menu that navigates to three different pages.

**Implementation:** MainScreen includes a gradient Drawer with navigation items that use setState() to switch between Home, Booking, and Profile tabs.

### Task 3: Implement a BottomNavigationBar with three tabs (e.g., Home, Profile, Settings).

**Implementation:** MainScreen features a 3-tab BottomNavigationBar (Home, Booking, Profile) with gradient styling and proper tab switching logic.

### Task 4: Create a TabBar with TabBarView that switches between two screens inside a Scaffold.

**Implementation:** BookingHistoryPage contains TabBar with TabBarView showing "New Booking" and "History" tabs using TabController and SingleTickerProviderStateMixin.

### Task 5: Add icons to each item in a BottomNavigationBar.

**Implementation:** BottomNavigationBar items include appropriate icons: home (Home), book_online (Booking), and person (Profile).

### Task 6: Combine Drawer and BottomNavigationBar in the same app.

**Implementation:** MainScreen successfully combines gradient Drawer menu with BottomNavigationBar, both navigating between the same three main tabs.

### Task 7: Implement named routes for three screens: Home, About, and Contact.

**Implementation:** MaterialApp defines named routes (/home, /about, /contact) with dedicated AboutPage and ContactPage accessed via Drawer navigation.

### Task 8: Demonstrate the difference between push() and pushReplacement() using two screens.

**Implementation:** PushDemoPage and PushReplacementDemoPage show interactive demonstrations of Navigator.push() vs Navigator.pushReplacement() with clear explanations.

### Task 9: Create a TabBar inside an AppBar with three tabs (e.g., Chats, Status, Calls).

**Implementation:** MessagesPage features TabBar embedded in AppBar using bottom property, with Chats, Status, and Calls tabs as requested.

### Task 10: Build a navigation flow where a login screen navigates to a home screen, and the home screen contains a Drawer and Bottom Tabs.

**Implementation:** LoginEntryPage serves as app entry point with email/password form, using Navigator.pushReplacement() to navigate to MainScreen with full Drawer and BottomNavigationBar functionality.

---

## Activity 5 - State Management (setState, useState, Provider, Redux) and Media & Assets

### State Management Tasks

1. **Create a shopping cart app or any that can add items using Provider.**
   _Implementation: EquipmentCartPage with drone accessories cart using CartProvider with add/remove functionality_

2. **Use ChangeNotifier with Provider to update the UI when data changes.**
   _Implementation: CartProvider extends ChangeNotifier, automatically updates cart UI when items added/removed_

3. **Demonstrate the difference between context.read() and context.watch() in Provider.**
   _Implementation: Cart uses context.read() for actions (add/remove) and Consumer/context.watch() for UI updates_

4. **Implement a theme switcher (dark/light mode) using Provider.**
   _Implementation: ThemeProvider with SettingsPage toggle, Consumer watches theme changes across entire app_

5. **Create a simple to-do list app using Provider for state management.**
   _Implementation: TodoProvider for flight preparation checklist in notes page (in progress)_

### Media & Assets Tasks

#### Images, Videos, Music, Icons, Fonts

6. **Display a local image using Image.asset().**
7. **Display an image from the internet using Image.network().**
8. **Add a circular border to an image using BoxDecoration.**
9. **Display a list of images from assets in a GridView.**
10. **Implement a video player using the video_player package.**
11. **Enhance the video player with controls using the chewie package.**
12. **Play a short audio clip using the audioplayers package.**
13. **Display Material Icons and change their color and size dynamically.**
14. **Add a custom icon set using the flutter_icons package.**
15. **Add a custom font (e.g., Roboto, Poppins) via pubspec.yaml.**
16. **Display two different text styles using two custom fonts.**
17. **Create a profile card with an image, custom icon, and styled text.**
18. **Build a gallery app / carousel that loads images from assets.**
19. **Build a video + audio player app with play, pause, and stop buttons.**
