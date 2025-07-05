# Project Name

## Project Details
This project is a Flutter application designed to [briefly describe the purpose of your project]. It aims to [mention the main goal or feature].

## Links
- **GitHub Repository**: [GitHub Repo URL](https://github.com/your-username/your-repo)
- **Figma Design**: [Figma Link](https://www.figma.com/your-design-link)
- **Jira Issue Tracker**: [Jira Link](https://your-jira-instance.atlassian.net/your-project)

## Development Setup

### Prerequisites
- Flutter SDK: `v3.32.0`
- Dart Version: `3.8.0`

Make sure you have Flutter and Dart set up on your machine before you proceed with the setup. You can install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install).

### Run the Project

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/your-repo.git
    cd your-repo
    ```

2. **Change package name**:
   Since this is template not a project. So you may need to change the package name of this project.

   Run this command to make shell script executable:
    ```bash
    chmod +x package_name_change.sh
    ```

   To change the package name, use this command and replace package name with your new package name (write.new.package.name):
    ```bash
    ./package_name_change.sh pacakgeName
    ```

3. **Install Dependencies**:
   Run the following command to get all the dependencies required by the project:
    ```bash
    flutter pub get
    ```

4. **Generate Code for JSON Serialization**:
   Since this project uses JSON serialization (via `json_serializable` package), you need to run the `build_runner` command to generate code for your models.

   Run this command to generate the necessary code:
    ```bash
    dart run build_runner build
    ```

   If you are making changes to your models and want to regenerate the code, use this command:
    ```bash
    dart run build_runner watch
    ```

5. **Remove Firebase (If Applicable)**:
   Since this project uses firebase, if don't need it, you can remove it using following command.

   Run this command to make shell script executable:
    ```bash
    chmod +x remove_firebase.sh
    ```

   To remove the firebase from project, use this command:
    ```bash
    ./remove_firebase.sh
    ```

6. **Run the App**:
   To run the app on an emulator or connected device:
    ```bash
    flutter run
    ```

### Build the App

1. **Build for Android**:
   To build the app for an Android release:
    ```bash
    flutter build apk --release --no-tree-shake-icons
    ```

2. **Build for iOS**:
   To build the app for iOS:
    ```bash
    flutter build ios --release
    ```

## Notes
- Ensure that you have the appropriate development environment set up for Android or iOS.
- For further instructions on how to configure your device or emulator, refer to [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- If you encounter issues with code generation (e.g., errors with `build_runner`), try clearing any generated files by running the following:
    ```bash
    dart run build_runner clean
    ```