import Foundation

struct MealPlanService {
    static let shared = MealPlanService()
    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/meal-plan"

    struct MealPlanWrapper: Codable {
        let mealPlans: [MealPlanResponse]
    }

    struct MealPlanResponse: Codable {
        let id: String
        let userId: String
        let mealPlan: String
        let createdAt: String?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case userId
            case mealPlan
            case createdAt
        }
    }

    struct MealPlanPostResponse: Codable {
        let message: String
        let mealPlan: String
    }

    func generateMealPlan(token: String, completion: @escaping (Result<MealPlanResponse, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                return
            }

            do {
                let postResponse = try JSONDecoder().decode(MealPlanPostResponse.self, from: data)
                let mealPlanResponse = MealPlanResponse(
                    id: UUID().uuidString,
                    userId: "",
                    mealPlan: postResponse.mealPlan,
                    createdAt: nil
                )

                completion(.success(mealPlanResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchMealPlans(token: String, completion: @escaping (Result<[MealPlanResponse], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                return
            }

            do {
                let mealPlanWrapper = try JSONDecoder().decode(MealPlanWrapper.self, from: data)
                completion(.success(mealPlanWrapper.mealPlans))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
