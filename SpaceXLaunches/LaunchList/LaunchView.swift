import SwiftUI

struct LaunchView: View {
    let model: Model
    
    var body: some View {
        HStack(alignment: .top) {
            Color(.brown)
                .frame(width: 35, height: 35)
            InfoHStack(model: model.infoFields)
            Spacer()
            Image(uiImage: model.missionStatus)
                .resizable()
                .frame(width: 35, height: 35)
        }
    }
}

extension LaunchView {
    struct Model: Identifiable {
        let id = UUID()
        let infoFields: InfoHStack.Model
        let missionStatus: UIImage
    }
}
