struct SpaceXLaunch: Codable, Equatable {
    let name: String
    let dateUtc: String
    let rocket: String
    let success: Bool?
    let links: Links
}

extension SpaceXLaunch {
    struct Links: Codable, Equatable {
        let patch: Patch
        
        struct Patch: Codable, Equatable {
            let small: String?
            let large: String?
        }
    }
}
