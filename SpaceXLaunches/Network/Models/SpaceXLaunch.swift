struct SpaceXLaunch {
    let name: String
    let dateUtc: String
    let rocket: String
    let success: Bool?
    let links: Links
}

extension SpaceXLaunch {
    struct Links {
        let patch: Patch
        
        struct Patch {
            let small: String?
            let large: String?
        }
    }
}
