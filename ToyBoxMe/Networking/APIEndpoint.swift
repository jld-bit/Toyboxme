import Foundation

struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    let body: Data?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
