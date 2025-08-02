# My Muse ✍️

A minimalist creative writing app centered around daily prompts to spark your imagination.

---

## 🚀 App Demo

*(Your App Demo GIF Here)*

---

## ✨ About The Project

My Muse is a SwiftUI application designed for writers of all levels who are looking for a simple, beautiful space to practice their craft. The core of the app is a new writing prompt delivered each day. Users can write and share their responses, read submissions from others, and track their creative journey on their personal profile.

This project was built from the ground up to demonstrate a full-stack iOS application using Apple's native frameworks. It showcases modern UI design, cloud data synchronization, and clean architectural patterns.

---

## 🔧 Key Features

* **Daily Prompts:** A new, unique writing prompt is delivered every 24 hours to inspire creativity.
* **CloudKit Backend:** All user data, posts, and prompts are securely stored and synced across devices using iCloud.
* **Reactive UI:** The interface is built with modern SwiftUI and Combine, ensuring data is always up-to-date and responsive.
* **User Profiles:** Users have personal profiles displaying their bio and a complete history of their posts.
* **Post Validation:** Includes client-side checks to prevent empty or duplicate posts and provides clear user feedback.
* **Modern Design:** A clean, minimalist "glassmorphism" UI that creates a focused and pleasant writing environment.

---

## 🛠️ Technologies Used

* **Framework:** SwiftUI
* **Data & State Management:** Combine, ObservableObject
* **Backend & Database:** CloudKit
* **Version Control:** Git & GitHub

---

## ⚙️ Setup and Installation

To run this project locally:

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/your-username/MyMuse.git](https://github.com/your-username/MyMuse.git)
    ```
2.  **Open in Xcode:**
    Open the `myMuse.xcodeproj` file.
3.  **Configure CloudKit:**
    In the "Signing & Capabilities" tab, select your developer team and ensure the CloudKit container identifier matches the one configured in your CloudKit Console. You may need to deploy the schema to your development environment.
4.  **Run the App:**
    Select a simulator or a physical device and run the project.

---

## 🎯 Project Goals & Learning

This project was an exercise in building a complete, data-driven iOS application. Key learning objectives included:

* Mastering asynchronous data fetching and state management with CloudKit and Combine.
* Implementing a robust and reactive UI using modern SwiftUI patterns like `@StateObject`, `@ObservedObject`, and `@FocusState`.
* Designing and structuring a scalable and maintainable project architecture.
* Managing a project from initialization to deployment using Git for version control.
