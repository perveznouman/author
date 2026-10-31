import SwiftUI

struct UserDetailView: View {
    let item: ArticleItem
    @StateObject var viewModel = UserDetailViewModel()

    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: item.profileImageURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())

            Text(item.username).font(.title2)

            if let d = viewModel.detail {
                Text("\(d.firstName) \(d.lastName)").font(.headline)
                Text("Age: \(d.age)")
                Text(d.email)
                Text(d.phone)
                Text(d.university)
                Text("\(d.address.city), \(d.address.country)")
            } else {
                ProgressView()
            }
            Spacer()
        }
        .padding()
        .navigationTitle("User Detail")
        .task { await viewModel.load(userId: item.userId) }
    }
}
