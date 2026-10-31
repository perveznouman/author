import Foundation

/*
 If Response struct is no generic we have to have below types
 
 struct UserResponse: Decodable {
     let data: [User]
 }
 struct ArticleResponse: Decodable {
     let data: [Article]
 
 */


struct Response<T: Decodable>: Decodable {
    let data: [T]
}

struct User: Decodable {
    let id: Int
    let username: String
    let about: String?
}

struct Article: Decodable {
    let title: String?
    let url: String?
    let author: String
    let storyTitle: String?

    // Left side: Swift property name. Right side: key name in the JSON.
    enum CodingKeys: String, CodingKey {
        case title
        case url
        case author
        case storyTitle = "story_title"
    }
}

// Response of https://dummyjson.com/users/{id} (a single object, no "data" wrapper)
struct UserDetail: Decodable {
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let phone: String
    let university: String
    let address: Address

    struct Address: Decodable {
        let city: String
        let country: String
    }
}
