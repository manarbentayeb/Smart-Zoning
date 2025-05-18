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

smart-zoning-project/
├── backend/
│   ├── Wilayas_CSVs/             # CSV data for Wilaya segmentation
│   ├── app/                      # Backend application code
│   ├── uploaded_files/          # Uploaded PDV or user files for processing
│
├── mobile_app/
│   ├── lib/
│   │   ├── core/                 # Constants, themes, utilities, config
│   │   ├── data/                 # Data models and API sources
│   │   ├── domain/               # Business logic, use cases
│   │   ├── presentation/         # Screens, widgets, UI components
│   │   ├── routes/               # Navigation routes
│   │   └── main.dart             # Flutter app entry point
│   ├── assets/                  # Images
│   └── pubspec.yaml             # Flutter dependencies and configuration
│
├── webapp/
│   ├── lib/
│   │   ├── app/
│   │   │   ├── database/        # window storage 
│   │   │   ├── model/           # data models 
│   │   │   ├── pages/           # Screens 
│   │   │   ├── services/        
│   │   │   ├── widgets/         # Reusable UI components
│   │   │        
│   │   └── main.dart            # Flutter app entry point
│   └── pubspec.yaml             # Flutter dependencies and configuration
│
├── docs/
├── assets/
└── README.md




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
