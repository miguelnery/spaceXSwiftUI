import Foundation
protocol LaunchListViewModel: ObservableObject {
    var launchModels: [LaunchView.Model] { get }
}

final class DefaultLaunchListViewModel<Service: LaunchListService, Adapter: LaunchListServiceAdapter>: LaunchListViewModel {
    typealias LaunchModel = LaunchView.Model
    let service: Service
    let adapter: Adapter
    @Published var launchModels = [LaunchView.Model]()
    
    init(service: Service, adapter: Adapter) {
        self.service = service
        self.adapter = adapter
        Task { await fetchModels() }
    }
    
    @MainActor
    private func fetchModels() async {
        let result = adapter.adapt(
            launches: await service.fetchLaunches(),
            rockets: await service.fetchRockets()
        )
        guard let launches = try? result.get() else {
            return // present error
        }
        launchModels = launches
    }
}
