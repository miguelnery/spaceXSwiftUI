import SwiftUI

struct LaunchView: View {
    let model: Model
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: model.iconURL) { image in
                image
                    .resizable()
                    .frame(width: 35, height: 35)
            } placeholder: {
                Color(.gray)
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 0.75))
            }
            InfoHStack(model: model.infoFields)
            Spacer()
            Image(uiImage: model.missionStatus)
                .resizable()
                .frame(width: 35, height: 35)
                .alignmentGuide(VerticalAlignment.center) { context in
                    context[.bottom] * 1.2
                }
        }
    }
}

extension LaunchView {
    struct Model: Identifiable {
        let id = UUID()
        let iconURL: URL?
        let infoFields: InfoHStack.Model
        let missionStatus: UIImage
    }
}
