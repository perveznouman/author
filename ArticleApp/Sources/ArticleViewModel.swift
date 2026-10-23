import Foundation

struct ArticleItem: Identifiable {
    let id = UUID()
    let username: String
    let about: String
    let title: String
    let url: String
    let author: String
}

enum APIEndPoint {
    case user
    case article
    
    var urlString: String {
        switch self {
        case .user:
            "https://jsonmock.hackerrank.com/api/article_users"
        case .article:
            "https://jsonmock.hackerrank.com/api/articles"
        }
    }
}

@MainActor
class ArticleViewModel: ObservableObject {
    @Published var items: [ArticleItem] = []
    let network = Network()

    func load() async {
        do {
            async let usersCall: Response<User> = network.fetch(urlString: APIEndPoint.user.urlString)
            async let articlesCall: Response<Article> = network.fetch(urlString: APIEndPoint.article.urlString)
            let (users, articles) = try await (usersCall, articlesCall)

            var result: [ArticleItem] = []
            for article in articles.data {
                if let user = users.data.first(where: { $0.username == article.author }) {
                    result.append(ArticleItem(username: user.username,
                                              about: user.about ?? "",
                                              title: article.title ?? article.storyTitle ?? "",
                                              url: article.url ?? "",
                                              author: article.author))
                }
            }
            items = result
        } catch {
            print("Error: \(error)")
        }
    }
}
