protocol LaunchListServiceAdapter {
    func adapt(launches: [SpaceXLaunch]) -> [LaunchView.Model]
}

final class DefaultLaunchListServiceAdapter: LaunchListServiceAdapter {
    func adapt(launches: [SpaceXLaunch]) -> [LaunchView.Model] {
        launches.map(makeLaunchViewModel(_:))
    }
}

// MARK: - Adapt Launches Helpers
private extension DefaultLaunchListServiceAdapter {
    private func makeLaunchViewModel(_ launch: SpaceXLaunch) -> LaunchView.Model {
        LaunchView.Model(
            infoFields: makeInfoField(launch),
            missionStatus: launch.success.icon.image
        )
    }
    
    private func makeInfoField(_ launch: SpaceXLaunch) -> InfoHStack.Model {
        typealias InfoFields = Localized.InfoFields
        let fields = [
            (title: "\(InfoFields.mission):", value: launch.name),
            (title: "\(InfoFields.dateTime):", value: "10/01/1995"),
            (title: "\(InfoFields.rocket):", value: "loqueto"),
            (title: "\(InfoFields.daysFromNow):", value: "365")
        ]
        return InfoHStack.Model(fields: fields)
    }
}
