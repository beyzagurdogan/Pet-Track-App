# 🐾 PetTrack

**PetTrack** is an open-source iOS application that helps pet owners monitor their pets' health by collecting essential information and evaluating a personalized health score using Machine Learning.

## 📱 Features

- Step-by-step form to collect pet data:
  - Name, type, breed, weight, age, and activity level
- Dynamic UI with **SwiftUI**
- Health score calculation (0–100) using:
  - A custom-trained **Tabular Classifier** model
  - Integrated via **CoreML**
- UserDefaults support for storing pet profiles
- Personalized and visually clean summary views

## 🧠 Machine Learning

The app integrates a **CoreML** model trained with Apple’s Create ML tool. It uses a tabular dataset of pet attributes and health labels to classify and predict a health score between **0 (poor)** and **100 (excellent)**.

### Model Details

- **Model type:** Tabular Classifier
- **Input:** Breed, Age, Weight, Activity level, etc.
- **Output:** Discrete health score class
- **Training tools:** Create ML, Python (data prep)

## 🛠️ Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **ML Framework:** CoreML
- **Persistence:** UserDefaults
- **Platform:** iOS 15+
