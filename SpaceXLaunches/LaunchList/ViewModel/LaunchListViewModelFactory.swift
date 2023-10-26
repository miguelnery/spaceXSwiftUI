enum LaunchListViewModelFactory {
    static func make() -> some LaunchListViewModel {
        let service = LaunchListServiceFactory.make()
        let adapter = DefaultLaunchListServiceAdapter()
        return DefaultLaunchListViewModel(service: service, adapter: adapter)
    }
}
