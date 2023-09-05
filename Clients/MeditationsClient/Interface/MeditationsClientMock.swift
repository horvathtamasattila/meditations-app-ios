import Combine
import Foundation

public extension MeditationsClient {
    static var mock: Self {
        Self(
            getMeditations: { location in
                Future<[Meditation], ApiError> { promise in
                    let resource = location == nil ? "get_meditations_200" : "get_meditations_with_location_200"
                    let decoder = JSONDecoder()
                    do {
                        let url = Bundle.main.url(forResource: resource, withExtension: "json")
                        let data = try Data(contentsOf: url!)
                        let result = try decoder.decode([Meditation].self, from: data)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            promise(.success(result))
                        }
                    } catch {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            promise(.failure(ApiError(error: "Error")))
                        }
                    }
                }
            }
        )
    }
}
