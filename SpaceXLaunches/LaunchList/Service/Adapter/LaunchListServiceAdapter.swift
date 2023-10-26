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
