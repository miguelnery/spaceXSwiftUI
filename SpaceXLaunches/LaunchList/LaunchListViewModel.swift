import Combine

protocol LaunchListViewModelProtocol: ObservableObject {
    var launchModels: [LaunchView.Model] { get }
}

final class LaunchListViewModel: LaunchListViewModelProtocol {
    typealias LaunchModel = LaunchView.Model
    var launchModels = [
        LaunchModel(missonName: "mission 1", missonStatus: .Icon.failure),
        LaunchModel(missonName: "mission 2", missonStatus: .Icon.success),
        LaunchModel(missonName: "mission 3", missonStatus: .Icon.failure)
    ]
}
