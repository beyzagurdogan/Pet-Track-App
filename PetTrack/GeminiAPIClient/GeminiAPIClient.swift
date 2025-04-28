import Foundation

struct GeminiAPIClient {
    
    private let apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key="  // Gemini API'nin gerçek URL'si burada olacak
    
    func fetchSuggestion(petInfo: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let requestBody = GeminiRequestBody(
            contents: [
                Content(
                    parts: [
                        Part(text: buildHealthSuggestionPrompt(petInfo: petInfo))
                    ]
                )
            ]
        )
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData

            // 🔵 İstek Gönderilmeden Önce Loglama
            if let bodyString = String(data: jsonData, encoding: .utf8) {
                print("➡️ Request URL: \(request.url?.absoluteString ?? "Unknown URL")")
                print("➡️ Request Method: \(request.httpMethod ?? "Unknown Method")")
                print("➡️ Request Headers: \(request.allHTTPHeaderFields ?? [:])")
                print("➡️ Request Body: \(bodyString)")
            }
        } catch {
            completion(.failure(error))
            return
        }

        // API'ye istek gönderme
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Request Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("🔵 Response Status Code: \(httpResponse.statusCode)")
                print("🔵 Response Headers: \(httpResponse.allHeaderFields)")
            }
            
            guard let data = data else {
                print("⚠️ No Data in Response")
                completion(.failure(NSError(domain: "NoData", code: 400, userInfo: nil)))
                return
            }
            
            if let responseBody = String(data: data, encoding: .utf8) {
                print("⬅️ Response Body: \(responseBody)")
            }
            
            
            do {
                let decodedResponse = try JSONDecoder().decode(GeminiResponseBody.self, from: data)
                if let firstCandidateText = decodedResponse.candidates.first?.content.parts.first?.text {
                    print("✅ AI Suggestion Text: \(firstCandidateText)")
                    completion(.success(firstCandidateText))
                } else {
                    print("⚠️ No suggestion text found")
                    completion(.failure(NSError(domain: "NoSuggestion", code: 404, userInfo: nil)))
                }
            } catch {
                print("❌ Decoding Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    
    func buildHealthSuggestionPrompt(petInfo: [String: Any]) -> String {
        let type = petInfo["type"] as? String ?? "Unknown type"
        let weight = petInfo["weight"] as? String ?? "Unknown weight"
        let activityLevel = petInfo["activityLevel"] as? String ?? "Unknown activity level"
        let vaccinated = (petInfo["vaccinated"] as? Bool) == true ? "vaccinated" : "not vaccinated"
        let dietType = petInfo["dietType"] as? String ?? "Unknown diet type"
        
        let prompt = """
        I have a \(type) that weighs \(weight) kilograms. 
        The activity level of the pet is \(activityLevel).
        The pet is \(vaccinated).
        The diet type is \(dietType).

        Based on this information, could you provide detailed health, nutrition, and care suggestions for the pet?
        Please include:
        - Recommended daily calorie intake
        - Suitable food types and portion suggestions
        - Activity or exercise routines
        - Any important health screenings or vaccinations to consider
        - Any additional tips based on the type, weight, and activity level

        Make sure the recommendations are practical, clear, and personalized according to the pet's condition.
        
        TURKCE YAZ
        """
        
        return prompt
    }

}

