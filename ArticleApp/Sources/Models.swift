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
