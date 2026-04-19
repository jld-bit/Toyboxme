import Foundation

struct APIConfiguration {
    let baseURL: URL
    let apiKey: String

    static func load() -> APIConfiguration {
        let baseURLString = Bundle.main.object(forInfoDictionaryKey: "TOYBOX_API_BASE_URL") as? String ?? ""
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "TOYBOX_API_KEY") as? String ?? ""
        let baseURL = URL(string: baseURLString) ?? URL(string: "https://api.example.com")!
        return APIConfiguration(baseURL: baseURL, apiKey: apiKey)
    }
}
