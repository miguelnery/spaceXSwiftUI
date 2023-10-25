import SwiftUI

@main
struct SpaceXLaunchesApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchListView(viewModel: DefaultLaunchListViewModel())
        }
    }
}
