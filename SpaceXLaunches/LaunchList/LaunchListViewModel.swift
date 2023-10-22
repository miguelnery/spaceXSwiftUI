import Combine

protocol LaunchListViewModelProtocol: ObservableObject {
    var launchModels: [LaunchView.Model] { get }
}

final class LaunchListViewModel: LaunchListViewModelProtocol {
    typealias LaunchModel = LaunchView.Model
    var launchModels = [
        LaunchModel(
            infoFields: .init(fields: [
                (title: "Mission:", value: "mission 1"),
                (title: "Date/time:", value: "10/01/1995"),
                (title: "Rocket:", value: "some rocket"),
                (title: "Days since now:", value: "3400")
            ]),
            missionStatus: .Icon.failure
        ),
        LaunchModel(
            infoFields: .init(fields: [
                (title: "Mission:", value: "mission 2"),
                (title: "Date/time:", value: "10/01/1995"),
                (title: "Rocket:", value: "some rocket"),
                (title: "Days since now:", value: "3400")
            ]),
            missionStatus: .Icon.success
        ),
        LaunchModel(
            infoFields: .init(fields: [
                (title: "Mission:", value: "mission 3"),
                (title: "Date/time:", value: "10/01/1995"),
                (title: "Rocket:", value: "some rocket"),
                (title: "Days since now:", value: "3400")
            ]),
            missionStatus: .Icon.failure
        )
    ]
}
