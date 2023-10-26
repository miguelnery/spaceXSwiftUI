import Foundation

extension DefaultLaunchListServiceAdapter {
    func makeLaunchViewModel(_ launch: SpaceXLaunch) -> LaunchView.Model {
        LaunchView.Model(
            infoFields: makeInfoField(launch),
            missionStatus: launch.missionSuccessIcon.image
        )
    }
}

// MARK: - General Helpers
extension DefaultLaunchListServiceAdapter {
    private func makeInfoField(_ launch: SpaceXLaunch) -> InfoHStack.Model {
        typealias InfoFields = Localized.InfoFields
        let fields = [
            (title: "\(InfoFields.mission):", value: launch.name),
            makeDateInfoField(utcStringDate: launch.dateUtc),
            (title: "\(InfoFields.rocket):", value: "loqueto"),
            (title: "\(InfoFields.daysFromNow):", value: "365")
        ]
        return InfoHStack.Model(fields: fields)
    }
}

// MARK: - Date Helpers
extension DefaultLaunchListServiceAdapter {
    private func makeDateInfoField(utcStringDate: String) -> (String, String) {
        let value: String
        if let date = dateUTCStringToDate(utcStringDate) {
            value = formatted(date: date)
        } else {
            value = "na"
        }
        return (title: "\(Localized.InfoFields.dateTime):", value: value)
    }
    
    private func dateUTCStringToDate(_ utcDateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: utcDateString)
    }
    
    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'at' HH'H'"
        return formatter.string(from: date)
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
