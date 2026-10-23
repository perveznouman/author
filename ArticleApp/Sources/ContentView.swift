import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ArticleViewModel()

    var body: some View {
        List(viewModel.items) { item in
            VStack(alignment: .leading, spacing: 4) {
                Text(item.username).font(.headline)
                Text(item.about).font(.caption)
                Text(item.title)
                Text(item.url).font(.caption).foregroundColor(.blue)
                Text(item.author).font(.caption)
            }
        }
        .task { await viewModel.load() }
    }
}
