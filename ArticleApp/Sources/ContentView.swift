import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ArticleViewModel()

    var body: some View {
        List(viewModel.items) { item in
            HStack(alignment: .top, spacing: 12) {
                // AsyncImage downloads the picture itself (it is an image, not JSON)
                AsyncImage(url: item.profileImageURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.username).font(.headline)
                    Text(item.about).font(.caption)
                    Text(item.title)
                    Text(item.url).font(.caption).foregroundColor(.blue)
                    Text(item.author).font(.caption)
                }
            }
        }
        .task { await viewModel.load() }
    }
}
