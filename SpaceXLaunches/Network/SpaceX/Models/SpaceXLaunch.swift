struct SpaceXLaunch: Codable {
    let name: String
    let dateUtc: String
    let rocket: String
    let success: Bool?
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
