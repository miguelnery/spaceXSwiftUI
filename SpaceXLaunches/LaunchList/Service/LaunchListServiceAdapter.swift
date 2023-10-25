protocol LaunchListServiceAdapter {
    func adapt(launches: [SpaceXLaunch]) -> [LaunchView.Model]
}

final class DefaultLaunchListServiceAdapter: LaunchListServiceAdapter {
    func adapt(launches: [SpaceXLaunch]) -> [LaunchView.Model] {
//        launches.map { item in
//            LaunchView.Model(infoFields: InfoHStack.Model(), missionStatus: <#T##UIImage#>)
//        }
        []
    }
}

//// MARK: - Adapt Launches Helpers
//private extension DefaultLaunchListServiceAdapter {
//    private func makeInfoField(_ launches: [SpaceXLaunch]) -> InfoHStack.Model {
//        let fields = [
//            (title: "Mission:", value: ""),
//            (title: "Date/time:", value: ""),
//            (title: "Rocket:", value: ""),
//            (title: "Days from now:", value: "")
//        ]
//        InfoHStack.Model(fields: [(title: "", value: "")])
//    }
//}
