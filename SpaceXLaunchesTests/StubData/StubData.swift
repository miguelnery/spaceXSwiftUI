@testable import SpaceXLaunches

extension SpaceXLaunch {
    static func stub(
        name: String = "name",
        dateUtc: String = "dateUTC",
        rocket: String = "rocket",
        success: Bool? = true,
        links: Links = .stub()
    ) -> SpaceXLaunch {
        .init(
            name: name,
            dateUtc: dateUtc,
            rocket: rocket,
            success: success,
            links: links
        )
    }
}

extension SpaceXLaunch.Links {
    static func stub(patch: Patch = .stub()) -> SpaceXLaunch.Links {
        .init(patch: patch)
    }
}

extension SpaceXLaunch.Links.Patch {
    static func stub(
        small: String? = "small",
        large: String? = "large"
    ) -> SpaceXLaunch.Links.Patch {
        .init(
            small: small,
            large: large
        )
    }
}

extension SpaceXRocket {
    static func stub(
        id: String = "id",
        name: String = "name",
        type: String = "type"
    ) -> SpaceXRocket {
        .init(
            id: id,
            name: name,
            type: type
        )
    }
}
