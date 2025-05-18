# Smart-Zoning Project For mobilis Company 


![Project Status](https://img.shields.io/badge/Status-In%20Development-yellow)  
![License](https://img.shields.io/badge/License-Educational-blue)  
![Contributors](https://img.shields.io/badge/Contributors-4-brightgreen)  
Smart Zoning System for Mobilis - Web and Mobile Applications for PDV Zone Management

## Overview  
The **Smart Zoning Solution** aims to replace the manual and non-optimized PDV assignment for representatives by digitizing the management and assignment of PDV tasks. This solution will help mobile entities efficiently manage PDV visits, assignment data, and representative performance tracking.

> **This project is currently under development phase.** The structure, functionality, and features will evolve as the team progresses. Teachers have access to this repository to monitor and review our progress.

## Objectives  
- Replace the manual process of handling PDVs assignemnt and zone partitioning with a secure digital system.  
- Provide efficient data entry, retrieval, and report generation functionalities.  
- Ensure secure access and compliance with data protection standards.
- Facilitate representatives work through a simple application designed to track their tasks and monitor performance.


## Planned Features  

| **Feature**                   | **Description**                                                                                       |
| ----------------------------- | ----------------------------------------------------------------------------------------------------- |
| **Smart Zoning Model**        | Automatically segments PDVs by region (wilaya) using intelligent zoning instead of manual assignment. |
| **PDV Management**            | Add, update, and organize PDVs with relevant location and task data.                                  |
| **Representative Management** | Assign representatives to optimized PDV zones and track their performance.                            |
| **Task Assignment**           | Digitally assign PDVs to representatives based on smart zones.                                        |
| **Performance Reporting**     | Monitor and report on representative activity, assignment efficiency, and zone coverage.              |
| **User Authentication**       | Secure access for different user roles to manage and track system operations.                         |


---

## Repository Structure

The repository is organized into several directories and files, each serving a specific purpose in the application development. Below is a breakdown of the structure:

Smart-Zoning Project Structure
<pre> ```Smart-Zoning-main/
├── README.md
├── setup\_structure.sh
├── smart-zoning/
│   ├── .gitignore
│   └── README.md
├── backend/
│   ├── app.log
│   ├── requirements.txt
│   ├── start\_server.bat
│   ├── app/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   ├── init.py
│   │   ├── data/
│   │   │   └── all-wilayas.geojson
│   │   ├── database/
│   │   │   ├── database.py
│   │   │   └── init.py
│   │   ├── ml/
│   │   │   ├── add\_pdv.py
│   │   │   ├── clustering.py
│   │   │   ├── cluster\_rebalancer.py
│   │   │   ├── delete\_pdv.py
│   │   │   ├── preprocessing.py
│   │   │   └── init.py
│   │   ├── models/
│   │   │   ├── pdv\_models.py
│   │   │   ├── user\_models.py
│   │   │   ├── zone\_models.py
│   │   │   └── init.py
│   │   ├── routes/
│   │   │   ├── pdv\_routes.py
│   │   │   ├── user\_routes.py
│   │   │   ├── zone\_routes.py
│   │   │   └── init.py
│   │   └── services/
│   │       ├── clustering\_service.py
│   │       ├── notification\_service.py
│   │       ├── tsp\_service.py
│   │       └── init.py
│   ├── uploaded\_files/
│   │   └── PDV\_dataset\_sample\_cc5f6922.csv
│   └── Wilaya\_CSVs/
│       ├── best\_workload\_parameters.json
│       ├── cleaned\_pdv\_data.csv
│       ├── initial\_clusters.json
│       └── rebalanced\_clusters.json
├── docs/
│   ├── api\_endpoints.md
│   ├── architecture\_diagram.png
│   ├── ERD.png
│   ├── roadmap.md
│   └── use\_case\_diagram.png
├── mobileapp/
│   ├── .flutter-plugins
│   ├── .flutter-plugins-dependencies
│   ├── pubspec.lock
│   ├── pubspec.yaml
│   ├── README.md
│   └── lib/
│       ├── main.dart
│       ├── app/
│       │   ├── acceuil/
│       │   │   └── home.dart
│       │   ├── ChangerMotDePasse/
│       │   │   ├── change pass.dart
│       │   │   └── PasswordField.dart
│       │   ├── home/
│       │   │   └── side bar.dart
│       │   ├── Identification/
│       │   │   ├── InputField.dart
│       │   │   ├── login.dart
│       │   │   ├── LoginButton.dart
│       │   │   └── SignUpLink.dart
│       │   ├── Inscription/
│       │   │   ├── LoginLink.dart
│       │   │   ├── SignUpButton.dart
│       │   │   └── sign\_up.dart
│       │   ├── PDVs/
│       │   │   ├── list de pdv.dart
│       │   │   └── QRCode.dart
│       │   ├── Profile/
│       │   │   ├── inputfieldformat.dart
│       │   │   ├── MenuItem.dart
│       │   │   ├── modify\_profile.dart
│       │   │   └── profile.dart
│       │   └── Settings/
│       │       └── Settings.dart
│       └── assets/
│           └── profile\_picture.jpg
└── webapp/
├── .flutter-plugins
├── .flutter-plugins-dependencies
├── .gitignore
├── .metadata
├── analysis\_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── assets/
│   ├── assignment.json
│   ├── representatives.json
│   └── images/
│       ├── gps\_map.png
│       ├── mini\_map.png
│       ├── mobilis-logo.png
│       └── zoning.png
└── lib/
├── config.dart
├── main.dart
├── database/
│   └── local\_database.dart
├── model/
│   ├── assignement.dart
│   ├── manager\_model.dart
│   ├── pdv\_model.dart
│   └── representative\_model.dart
├── pages/
│   ├── assignment.json
│   ├── assignment\_table.dart
│   ├── auth\_page.dart
│   ├── edit\_profile.dart
│   ├── homepage.dart
│   ├── profile.dart
│   └── zones\_page.dart
├── services/
│   └── api\_service.dart
└── widgets/
├── app\_bar.dart
└── footer.dart

 ``` </pre>
            
### Tech Stack 

  - **Frontend (Mobile/Web)**: Flutter
  - **Backend**:  FastAPI (Python) 
  - **Hosting**:  Localhost

###  Prerequisites  
1. **Flutter SDk**
2. **Dart SDK**
3. **IDE/Editor**
   - Install an IDE or editor to work with Flutter:
     - **Visual Studio Code** with Flutter and Dart plugins
     
4. **Flutter Web and Mobile Support**
– Ensure you have Flutter web and mobile support enabled. Follow the instructions in the Flutter documentation to enable support for your target platforms.

6. **Operating System Requirements**
- **Windows**:
  - Install **Android Studio** for Android development.
  - Ensure **Chrome** is installed for Flutter web support.
- **macOS**:
  - Install **Xcode** for iOS development.
  - Install **Android Studio** for Android.
  - Ensure **Chrome** or **Safari** is available for web.
- **Linux**:
  - Install **Android Studio** for Android development.
  - Ensure **Chrome** is installed for Flutter web development.

7. **Git**
8. **Flutter Dependencies**
   - You may need to install additional Flutter packages. Check the `pubspec.yaml` file for required dependencies and run:
     ```
     flutter pub get
     ```


### Steps to Set Up  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/manarbentayeb/Smart-Zoning.git
   cd Smart-Zoning
   ```

2. **Install Flutter dependencies**  
   For both web and mobile apps:
   ```bash
   cd webapp
   flutter pub get

   cd ../mobile_app
   flutter pub get
   ```

3. **Run the backend server**  
   ```bash
   cd ../backend
   uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
   ```

4. **Run the Web App**  
   ```bash
   cd ../webapp
   flutter run -d chrome
   ```

5. **Run the Mobile App**  
   ```bash
   cd ../mobile_app
   flutter run -d <device_id>  # e.g., emulator-5554 or iPhone
   ```

 
---
## License  
This project was originally proposed by Obilis Company as a contribution in collaboration with our school. While developed in an academic setting, it is intended for potential commercial use and practical application.



## Contact  

For any questions or suggestions, please reach out to the project team:  

| **Role**       | **Name**       | **Email**               |  
|----------------|---------------|-------------------------|  
| Team Lead      |Bentayeb Manar    | manar.bentayeb@ensia.edu.dz  |  
| Contributor    | Hiba AYADI | hiba.ayadi@ensia.edu.dz|  
| Contributor    | Yousra BOUHOUIA | yousra.bouhouia@ensia.edu.dz|  
| Contributor    | Lydia BENHAMOUCHE | lydia.benhamouche@ensia.edu.dz| 
