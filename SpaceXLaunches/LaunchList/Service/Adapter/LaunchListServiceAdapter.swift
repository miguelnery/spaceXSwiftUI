protocol LaunchListServiceAdapter {
    typealias Launches = Result<[SpaceXLaunch], ServiceError>
    typealias Rockets = Result<[SpaceXRocket], ServiceError>
    typealias LaunchViewModels = Result<[LaunchView.Model], ServiceError>
    
    func adapt(
        launches: Launches,
        rockets: Rockets
    ) -> LaunchViewModels
}

final class DefaultLaunchListServiceAdapter: LaunchListServiceAdapter {
    func adapt(
        launches: Launches,
        rockets: Rockets
    ) -> LaunchViewModels {
        let rockets = try? rockets.get()
        switch launches {
        case .success(let launches):
            return .success(launches.map {
                makeLaunchViewModel($0, rockets: rockets ?? [])
            })
        case .failure(let error):
            return .failure(error)
        }
    }
}
