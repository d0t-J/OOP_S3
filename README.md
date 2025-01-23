# [OOP S3](https://gitingest.com/d0t-J/OOP_S3)

## Overview

OOP S3 is a Flutter application designed to process and interact with PDF documents. The application allows users to upload PDF files, extract text, translate the text, and interact with the content through a chat interface. The backend services are integrated with Pinecone for indexing and querying the text data.

## Features

-   **PDF Upload**: Users can upload PDF files.
-   **Text Extraction**: Extract text content from the uploaded PDF.
-   **Translation**: Translate the extracted text to English.
-   **Indexing**: Index the translated text into Pinecone.
-   **Chat Interface**: Interact with the indexed content through a chat interface.
-   **Real-time Streaming**: Stream bot responses in real-time.

## Data Flow between major components

[![](https://mermaid.ink/img/pako:eNqNVE1z2jAQ_Ss7uiSdgTTYCQQfOgM2TTjQ0nz0UJzpqPYCntqSR5I7IcB_70rGOCmX-uKV9N7T29VKW5bIFFnAVoqXa3iMYgH0jRYxK9Plz6rMJU8vUq5MAGWW_P6c5Xj-IWbP0O1-2tkRzLlZ72B8YKwxL1EFgC9G8cQ80t_ha92xo30tTVZkr5h-DHPkAlOwsB2EpEEsoXNuMIBj-I9I6EQm9QZH8mg-7S1Gr5VCeDwQpYIHVH-yBA9Mi3HkBnFkR4v70S1MRYovYCTMM4GJFA0vcqSYzbniBRpUOogZRDKpChQGplHnQP1CyzuYLMI1p2lByCVPEL5VqDYwVzJBrTOxOshOnOyTRlUjXBIeFSGstJGFHcE9krCCc8VXXe2DFKqeSGTRVsTSnNY96lIKbT28Lbg7pxkannLDd3C7aM82gLMlrVrjZ-9sjaWBRk7v4K7O6SFRiKJxNaN0-Ar1gXjX5tOsHI3o6lfdYjF7mkIoCxKm2umY1esujTactOFtHdKOdXCi19YVZjKtcnwnOm7DsA2jN6IngtRaqATPbV3fG_yPHmvOY3FyiM8ne9Z95VrHuv-OCenZi9H2tBcL1mEFqoJnKd3TrWXSNVljgTELKExxyavcWJ97gvLKyIeNSFhgVIUdpmS1WrNgyXNNo6qkFsAo45Rr0UBKLn5IeRximpGNWf0uuOfBQViwZS8s6Pq9C__6Zuj3r7zLgd8bev0O29B8rze86F_7Xs-_7A-G3tXwZt9hr06XGP7w0kK9vu8P9n8By5Vlvg?type=png)](https://mermaid.live/edit#pako:eNqNVE1z2jAQ_Ss7uiSdgTTYCQQfOgM2TTjQ0nz0UJzpqPYCntqSR5I7IcB_70rGOCmX-uKV9N7T29VKW5bIFFnAVoqXa3iMYgH0jRYxK9Plz6rMJU8vUq5MAGWW_P6c5Xj-IWbP0O1-2tkRzLlZ72B8YKwxL1EFgC9G8cQ80t_ha92xo30tTVZkr5h-DHPkAlOwsB2EpEEsoXNuMIBj-I9I6EQm9QZH8mg-7S1Gr5VCeDwQpYIHVH-yBA9Mi3HkBnFkR4v70S1MRYovYCTMM4GJFA0vcqSYzbniBRpUOogZRDKpChQGplHnQP1CyzuYLMI1p2lByCVPEL5VqDYwVzJBrTOxOshOnOyTRlUjXBIeFSGstJGFHcE9krCCc8VXXe2DFKqeSGTRVsTSnNY96lIKbT28Lbg7pxkannLDd3C7aM82gLMlrVrjZ-9sjaWBRk7v4K7O6SFRiKJxNaN0-Ar1gXjX5tOsHI3o6lfdYjF7mkIoCxKm2umY1esujTactOFtHdKOdXCi19YVZjKtcnwnOm7DsA2jN6IngtRaqATPbV3fG_yPHmvOY3FyiM8ne9Z95VrHuv-OCenZi9H2tBcL1mEFqoJnKd3TrWXSNVljgTELKExxyavcWJ97gvLKyIeNSFhgVIUdpmS1WrNgyXNNo6qkFsAo45Rr0UBKLn5IeRximpGNWf0uuOfBQViwZS8s6Pq9C__6Zuj3r7zLgd8bev0O29B8rze86F_7Xs-_7A-G3tXwZt9hr06XGP7w0kK9vu8P9n8By5Vlvg)

## Project Structure:

```
OOP_S3/
├── android/                # Android-specific files
├── ios/                    # iOS-specific files
├── lib/                    # Main source code
│   ├── api/                # API interaction code
│   ├── models/             # Data models
│   ├── modules/            # Business logic modules
│   ├── repository/         # Data repositories
│   ├── screens/            # UI screens
│   ├── utils/              # Utility functions
│   └── widgets/            # Custom widgets
├── test/                   # Unit tests
├── pubspec.yaml            # Project configuration
└── README.md               # Project documentation
```

## Getting Started

### Prerequisites

-   Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
-   Dart SDK: Included with Flutter
-   Android Studio or Visual Studio Code: Recommended IDEs for Flutter development

### Installation

1. **Clone the repository**:

    ```sh
    git clone https://gitingest.com/d0t-J/OOP_S3.git
    cd OOP_S3
    ```

2. **Install Dependencies**

    ```
    flutter pub get
    ```

3. **Add `.env` file for Environment Variables at the root of your project**

    ```
    AZURE_TRANSLATOR_KEY=<your-azure-key>
    AZURE_TRANSLATOR_REGION=<your-region>
    ```

### Run the App

1. **Choosing Device**
 <li>Connect to a Physical Device</li>
 <li>Connect to a Virtual Emulator</li>

2. **Run the App ( default mode )**

    ```
    flutter run
    ```

    Additional Flags:<br>
    $$
    `--debug` for debug mode
    `--profile` for performance profiling mode
    `--release` for release mode
    $$

## Anomalies in the build

#### Warning 1

```
Warning: SDK processing. This version only understands SDK XML versions up to 3 but an SDK XML file of version 4 was encountered. This can happen if you use versions of Android Studio and the command-line tools that were released at different times.
```

**Reason:**

1. **Outdated SDK Tools:** Your SDK tools might be outdated and do not support the newer XML version.
2. **Version Mismatch:** You might be using a newer version of Android Studio that generates SDK XML files of version 4, but your command-line tools are older and only understand up to version 3.

#### Warning 2

-   **Linux:**
    -   Default plugin: `file_picker:linux`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: linux: default_package: file_picker` or add an inline implementation via `platforms: linux: pluginClass` or `dartPluginClass`.
-   **macOS:**
    -   Default plugin: `file_picker:macos`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: macos: default_package: file_picker` or add an inline implementation via `platforms: macos: pluginClass` or `dartPluginClass`.
-   **Windows:**
    -   Default plugin: `file_picker:windows`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: windows: default_package: file_picker` or add an inline implementation via `platforms: windows: pluginClass` or `dartPluginClass`.

##### Why is this Error of No Concern to Us

This issue is relevant for the Windows, Linux, and macOS platforms. However, it does not affect this project as it is focused solely on Android app development.

#### Warning 3

**Warning:**

```
[options] source value 8 is obsolete and will be removed in a future release
warning: [options] To suppress warnings about obsolete options, use -Xlint:-options.
```

**Reason:**

1. **Deprecated Java Version:** The project is using an outdated Java version (source value 8) which is no longer supported and will be removed in future releases.
2. **Target Compatibility:** The target value 8 is also obsolete and will be removed in future releases.
   **Solution:** To suppress warnings about obsolete options, use `-Xlint:-options` or update the project to use a supported Java version.
