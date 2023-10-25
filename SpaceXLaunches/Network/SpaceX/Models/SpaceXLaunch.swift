struct SpaceXLaunch: Codable {
    let name: String
    let dateUtc: String
    let rocket: String
    let success: MissionSuccess
    let links: Links
}

extension SpaceXLaunch {
    struct Links: Codable {
        let patch: Patch
        
        struct Patch: Codable {
            let small: String?
            let large: String?
        }
    }
}

extension SpaceXLaunch {
    enum MissionSuccess: Codable {
        case success
        case failure
        case unknown
        
        var icon: ImageAsset {
            switch self {
            case .success:
                return Asset.success
            case .failure:
                return Asset.failure
            case .unknown:
                return Asset.unknown
            }
        }
        
        init(_ value: Bool?) {
            guard let value = value else {
                self = .unknown
                return
            }
            self = value ? .success : .failure
        }
    }
}
