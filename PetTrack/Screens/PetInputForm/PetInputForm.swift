import SwiftUI

struct PetInputFormView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var breed = ""
    @State private var type = "Dog"
    @State private var weight = ""
    @State private var activityLevel = "Medium"
    @State private var dailyExerciseMinutes = ""
    @State private var foodType = ""
    @State private var dailyCalories = ""
    @State private var lastVetVisit = Date()
    @State private var healthConditions = ""
    @State private var vaccinated = true
    @State private var avgDailySteps = ""
    @State private var recommendation = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                
                
                // Cat and Dog image buttons
                HStack(spacing: 40) {
                    Button(action: {
                        type = "Cat"
                    }) {
                        VStack {
                            Image("cat") // Add a relevant cat image to your assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                            Text("Cat")
                                .fontWeight(.bold)
                                .foregroundColor(type == "Cat" ? .blue : .black)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // To prevent default button styling

                    Button(action: {
                        type = "Dog"
                    }) {
                        VStack {
                            Image("dog") // Add a relevant dog image to your assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                            Text("Dog")
                                .fontWeight(.bold)
                                .foregroundColor(type == "Dog" ? .blue : .black)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // To prevent default button styling
                }
                .padding()

               

                // Name, Age, Breed & Type Input
                VStack(spacing: 15) {
                    TextField("Enter Pet's Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Enter Pet's Age", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Enter Pet's Breed", text: $breed)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // Activity Level and Daily Exercise Input
                VStack(spacing: 15) {
                    Picker("Activity Level", selection: $activityLevel) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    TextField("Enter Daily Exercise Minutes", text: $dailyExerciseMinutes)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // Nutrition Section
                VStack(spacing: 15) {
                    TextField("Enter Food Type", text: $foodType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Enter Daily Calories", text: $dailyCalories)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // Health Information Section
                VStack(spacing: 15) {
                    DatePicker("Last Vet Visit", selection: $lastVetVisit, displayedComponents: .date)
                        .padding()
                    TextField("Health Conditions", text: $healthConditions)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Toggle("Vaccinated", isOn: $vaccinated)
                        .padding()
                }

                // Display Graphical Representation (Optional)
                GraphicalRepresentationView()

                // Submit Button
                Button(action: {
                    generateRecommendation()
                }) {
                    Text("Show AI Recommendation")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 350, height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }

                // Recommendation Result
                if !recommendation.isEmpty {
                    VStack {
                        Text("AI Recommendation")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text(recommendation)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("")
    }

    // Recommendation logic
    func generateRecommendation() {
        if healthConditions.lowercased().contains("obesity") {
            recommendation = "Recommended: Special weight management diet."
        } else if activityLevel == "Low" {
            recommendation = "Increase activity level with play and walks."
        } else if healthConditions.lowercased().contains("dental") {
            recommendation = "Use dental-friendly snacks and foods."
        } else {
            recommendation = "Maintain current routine and lifestyle."
        }
    }
}

struct GraphicalRepresentationView: View {
    var body: some View {
        VStack {
            Text("Pet Activity Graph")
                .font(.title2)
                .padding()

            // Example of a bar chart using SwiftUI's shapes (you can use a library like SwiftUICharts for more advanced charts)
            HStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 200)
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 50, height: 150)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 100)
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 50, height: 180)
            }
            .padding(.bottom, 30)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }
}

struct PetInputFormView_Previews: PreviewProvider {
    static var previews: some View {
        PetInputFormView()
    }
}

