protocol LaunchListServiceAdapter {
    func adapt(launches: Result<[SpaceXLaunch], ServiceError>) -> Result<[LaunchView.Model], ServiceError>
}

final class DefaultLaunchListServiceAdapter: LaunchListServiceAdapter {
    func adapt(launches: Result<[SpaceXLaunch], ServiceError>) -> Result<[LaunchView.Model], ServiceError> {
        switch launches {
        case .success(let launches):
            return .success(launches.map(makeLaunchViewModel(_:)))
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: - Adapt Launches Helpers
private extension DefaultLaunchListServiceAdapter {
    private func makeLaunchViewModel(_ launch: SpaceXLaunch) -> LaunchView.Model {
        LaunchView.Model(
            infoFields: makeInfoField(launch),
            missionStatus: launch.missionSuccessIcon.image
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

private extension SpaceXLaunch {
    var missionSuccessIcon: ImageAsset {
        switch success {
        case .none:
            return Asset.unknown
        case .some(let isSuccessfull):
            return isSuccessfull ? Asset.success : Asset.failure
        }
    }
}
