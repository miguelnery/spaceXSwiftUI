import Foundation

extension DefaultLaunchListServiceAdapter {
    func makeLaunchViewModel(_ launch: SpaceXLaunch, rockets: [SpaceXRocket]) -> LaunchView.Model {
        LaunchView.Model(
            infoFields: makeInfoField(launch),
            missionStatus: launch.missionSuccessIcon.image
        )
    }
}

// MARK: - General Helpers
extension DefaultLaunchListServiceAdapter {
    typealias InfoFields = Localized.InfoFields
    private func makeInfoField(_ launch: SpaceXLaunch, rockets: [SpaceXRocket]) -> InfoHStack.Model {
        
        let fields = [
            (title: "\(InfoFields.mission):", value: launch.name),
            makeDateInfoField(utcStringDate: launch.dateUtc),
            (title: "\(InfoFields.rocket):", value: "loqueto"),
            makeDaysOffsetInfoField(from: dateUTCStringToDate(launch.dateUtc))
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
        return (title: "\(InfoFields.dateTime):", value: value)
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

// MARK: - Days Offset
extension DefaultLaunchListServiceAdapter {
    private func makeDaysOffsetInfoField(from date: Date?) -> (String, String) {
        let title: String
        let value: String
        if let date = date,
           let daysOffset = calculateDaysOffset(from: date) {
            title = daysOffset < 0  ? InfoFields.daysSince : InfoFields.daysFromNow
            value = String(abs(daysOffset))
        } else {
            title = InfoFields.daysFromNow
            value = "na"
        }
        return ("\(title):", value)
    }
    
    private func calculateDaysOffset(from date: Date) -> Int? {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day
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
