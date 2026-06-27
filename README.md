# Task Manager

## Overview

Task Manager is a Flutter application developed as a technical assessment to demonstrate modern Flutter development practices using Clean Architecture principles.

The application enables authenticated users to manage projects and tasks while maintaining a scalable, maintainable and reusable architecture. It integrates with Supabase REST APIs for backend communication and follows a feature-based project structure that separates business logic from presentation and data access.

The application also demonstrates state management using flutter_bloc, dependency injection using GetIt, local persistence using SharedPreferences, offline caching using Hive and navigation using GoRouter.

---

## Table of Contents

- Overview
- Features
- Tech Stack
- Architecture
- Project Structure
- Authentication Module
- Projects Module
- Tasks Module
- Profile Module
- Theme Management
- Local Storage
- State Management
- Dependency Injection
- Networking
- Error Handling
- Installation
- Running the Project
- Screenshots
- Demo Video
- Future Improvements
- Author

---

## Features

### Authentication

The authentication module allows users to securely register and log into the application.

Implemented functionality includes:

- User Registration
- User Login
- Form Validation
- Persistent Authentication
- Splash Screen Session Check
- Logout

User authentication information is stored locally using SharedPreferences to maintain the login session after restarting the application.

---

### Projects

The Projects module is responsible for retrieving and displaying all available projects from Supabase.

Implemented functionality:

- Retrieve projects from Supabase REST API
- Pull-to-refresh support
- Empty state handling
- Navigate to project details
- Offline caching using Hive

Each project displays:

- Title
- Description
- Status

Projects are cached locally after a successful API request. If the network becomes unavailable, cached projects are displayed instead.

---

### Tasks

The Tasks module displays all tasks belonging to a selected project.

Implemented functionality:

- Retrieve project tasks
- Add new task
- Mark task as completed
- Automatic task list refresh

Each task displays:

- Title
- Status
- Priority

Adding a task is implemented using a reusable Bottom Sheet component connected to the TaskCubit.

---

### Profile

The Profile module displays the authenticated user's information stored locally.

Implemented functionality:

- Display user name
- Display email address
- Logout

User information is retrieved from SharedPreferences.

---

### Theme Management

The application supports both Light Theme and Dark Theme.

Implemented functionality:

- Switch between Light and Dark Mode
- Persist selected theme
- Restore theme after restarting the application

Theme management is implemented using ThemeCubit.

---
## Architecture

The project follows Clean Architecture to separate the application into independent layers. This approach improves maintainability, scalability, and testability by assigning a single responsibility to each layer.

### Presentation Layer

The Presentation layer is responsible for displaying data and handling user interactions.

It contains:

- Screens
- Widgets
- Cubits
- States

Responsibilities:

- Display application data.
- Listen for state changes.
- Handle user interactions.
- Trigger business logic through Use Cases.

The Presentation layer never communicates directly with APIs or local databases.

---

### Domain Layer

The Domain layer contains the application's business rules.

It includes:

- Entities
- Repository Contracts
- Use Cases

Entities represent the core business objects of the application and remain independent from external libraries.

Repository contracts define the operations required by the application without specifying how the data is retrieved.

Each Use Case represents a single business operation such as user login, retrieving projects, retrieving tasks, adding a task or marking a task as completed.

---

### Data Layer

The Data layer is responsible for retrieving and storing data.

It contains:

- Models
- Repository Implementations
- Remote Data Sources
- Local Data Sources

Models convert JSON responses into Dart objects and vice versa.

Remote Data Sources communicate with Supabase using Dio.

Local Data Sources manage local persistence using SharedPreferences and Hive.

Repository implementations coordinate between remote and local data sources and provide data to the Domain layer.

---

## Project Structure

The project follows a feature-based structure where every feature is isolated from the others.

The main project structure consists of:

- core
- features
- main.dart

The **core** directory contains reusable components shared across the application.

It includes:

- Dependency Injection
- Network Configuration
- Routing
- Theme Configuration
- Shared Services

The **features** directory contains all application modules.

Each feature follows the same Clean Architecture structure and contains:

- Data Layer
- Domain Layer
- Presentation Layer

This organization keeps every feature independent and makes future maintenance easier.

---

## State Management

The application uses **flutter_bloc** for state management.

Business logic is separated from the user interface by implementing Cubits for each feature.

Implemented Cubits include:

- AuthCubit
- ProjectCubit
- TaskCubit
- ThemeCubit

Each Cubit is responsible for handling its own feature logic and emitting loading, success and error states.

This approach keeps widgets simple while making the application easier to test and maintain.

---

## Dependency Injection

Dependency Injection is implemented using **GetIt**.

All application dependencies are registered in a single injection container.

Registered services include:

- Dio Client
- Remote Data Sources
- Local Data Sources
- Repositories
- Use Cases
- SharedPreferences Service
- Hive Local Data Source
- Cubits

Using Dependency Injection improves modularity and removes tight coupling between classes.

---

## Networking

The application communicates with Supabase through REST APIs using Dio.

Network requests are responsible for:

- User Authentication
- Retrieving Projects
- Retrieving Tasks
- Creating Tasks
- Updating Task Status

All API communication is isolated inside the Remote Data Source layer, keeping networking logic separated from the rest of the application.

---

## Local Storage

Two local storage solutions are used in the project.

### SharedPreferences

SharedPreferences stores lightweight user data including:

- Authentication Token
- User ID
- User Name
- User Email
- Theme Preference

These values remain available after restarting the application.

### Hive

Hive is used to cache project data locally.

Whenever projects are successfully retrieved from the server, they are stored in Hive.

If the application cannot reach the API, cached projects are loaded instead, allowing the application to continue displaying data while offline.

---

## Error Handling

The application handles errors at multiple layers.

Network exceptions are caught inside the Repository layer.

When a network request fails, the repository attempts to retrieve cached data whenever possible.

Cubit states notify the user interface about loading, success and error conditions, allowing the UI to respond appropriately without crashing.

---
## Packages

The project uses the following packages to simplify development and improve maintainability.

### flutter_bloc

Used for state management by separating business logic from the user interface.

### Dio

Used to perform HTTP requests and communicate with Supabase REST APIs.

### GetIt

Used for Dependency Injection to provide a centralized way of managing application dependencies.

### GoRouter

Used to manage navigation between application screens.

### SharedPreferences

Used to persist user session information and theme preferences.

### Hive

Used as a lightweight local database to cache projects for offline access.

### Equatable

Used to simplify object comparison and improve Bloc state management.

---

## Installation

Clone the repository.

```bash
git clone https://github.com/YOUR_USERNAME/task_manager_app.git
```

Navigate to the project directory.

```bash
cd task_manager_app
```

Install dependencies.

```bash
flutter pub get
```

Configure your Supabase credentials inside the project.

Run the application.

```bash
flutter run
```

---


# Future Improvements

The current version focuses on the assessment requirements. Future improvements may include:

- Create Projects
- Edit Projects
- Delete Projects
- Edit Tasks
- Delete Tasks
- Search Projects
- Search Tasks
- Task Filtering
- Push Notifications
- File Attachments
- User Profile Editing
- Complete Offline Synchronization
- Unit Testing
- Integration Testing
- CI/CD Pipeline

---

## Author

**Rawan Gamal**

Flutter Developer

GitHub: https://github.com/Rwangmal

---

## Acknowledgments

This project was developed as a Flutter technical assessment to demonstrate software architecture, state management, REST API integration, local storage, and modern Flutter development best practices.

The project emphasizes clean code principles, modular architecture, and scalability while maintaining a simple and intuitive user experience.
