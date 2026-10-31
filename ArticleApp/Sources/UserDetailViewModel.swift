import Foundation

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var detail: UserDetail?
    let network = Network()   // same Network class, not modified

    func load(userId: Int) async {
        do {
            detail = try await network.fetch(urlString: APIEndPoint.userDetail(userId: userId).urlString)
        } catch {
            print("Error: \(error)")
        }
    }
}
