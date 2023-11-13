import Foundation

extension DefaultLaunchListServiceAdapter {
    func makeLaunchViewModel(
        _ launch: SpaceXLaunch,
        rockets: [SpaceXRocket]
    ) -> LaunchView.Model {
        LaunchView.Model(
            iconURL: makeIconURL(launch),
            infoFields: makeInfoFields(
                launch,
                rockets: rockets
            ),
            missionStatus: launch.missionSuccessIcon.image
        )
    }
}

// MARK: - InfoField makers
extension DefaultLaunchListServiceAdapter {
    typealias LocalizedFields = Localized.InfoFields
    typealias InfoField = (String, String)
    
    private func makeInfoFields(_ launch: SpaceXLaunch, rockets: [SpaceXRocket]) -> InfoHStack.Model {
        
        let fields = [
            (title: "\(LocalizedFields.mission):", value: launch.name),
            makeDateInfoField(utcStringDate: launch.dateUtc),
            makeRocketInfoField(launch, rockets: rockets),
            makeDaysOffsetInfoField(from: dateUTCStringToDate(launch.dateUtc))
        ]
        return InfoHStack.Model(fields: fields)
    }
    
    private func makeDateInfoField(utcStringDate: String) -> InfoField {
        let value: String
        if let date = dateUTCStringToDate(utcStringDate) {
            value = formatted(date: date)
        } else {
            value = "na"
        }
        return ("\(LocalizedFields.dateTime):", value)
    }
    
    private func makeRocketInfoField(_ launch: SpaceXLaunch, rockets: [SpaceXRocket]) -> InfoField {
        let value: String
        let rocket = rockets.filter { $0.id == launch.rocket }.first
        if let rocket = rocket { value = "\(rocket.name) / \(rocket.type)" }
        else { value = "na" }
        return (LocalizedFields.rocket, value)
    }
    
    private func makeDaysOffsetInfoField(from date: Date?) -> InfoField {
        let title: String
        let value: String
        if let date = date,
           let daysOffset = calculateDaysOffset(from: date) {
            title = daysOffset < 0  ? LocalizedFields.daysSince : LocalizedFields.daysFromNow
            value = String(abs(daysOffset))
        } else {
            title = LocalizedFields.daysFromNow
            value = "na"
        }
        return ("\(title):", value)
    }
}

// MARK: - Icon Helpers
extension DefaultLaunchListServiceAdapter {
    private func makeIconURL(_ launch: SpaceXLaunch) -> URL? {
        let patch = launch.links.patch
        let urlString = patch.large ?? patch.small ?? ""
        return URL(string: urlString)
    }
}

// MARK: - Date Helpers
extension DefaultLaunchListServiceAdapter {
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
