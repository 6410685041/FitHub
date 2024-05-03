# Fithub

Fithub is a fitness app designed to help users track their workouts, set fitness goals, and maintain a healthy lifestyle. With features like authentication, user registration, profile management, and navigation, Fithub provides a comprehensive platform for fitness enthusiasts.

## Features

### SignInView

The `SignInView` allows existing users to log in to their accounts. Users can input their email and password to authenticate and access the app's features.

### SignUpView

The `SignUpView` enables new users to create accounts. It collects user information such as email, password, full name, weight, height, gender, and birthdate, facilitating the registration process.

### MapView

The `MapView` displays a map using MapKit and tracks the user's location. It visualizes the user's path as they engage in physical activities, helping them monitor their workout routes.

### Custom Tab Bar Item (`customTabBarItem`)

The `customTabBarItem` defines a custom tab bar item used in the app's main navigation. It includes an icon and a label, with the selected tab highlighted to enhance navigation clarity.

### Custom Top Tab Bar Item (`customTopTabBarItem`)

Similar to `customTabBarItem`, `customTopTabBarItem` is designed for a top tab bar style. It highlights the selected tab with a colored underline, providing an intuitive navigation experience.

### MainView

The `MainView` serves as the central hub of the app, incorporating a tab bar navigation structure. It switches between different content views based on the selected tab, allowing users to seamlessly navigate between app sections.

### ProfileView

The `ProfileView` displays user profile information, including full name, email, weight, height, and gender. It also provides an option for users to log out from the app, ensuring account security and privacy.

## Getting Started

To get started with Fithub, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or physical device.

## Requirements

- Xcode 15.0 or later
- SwiftUI
- MapKit
