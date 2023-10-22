import SwiftUI

struct LaunchView: View {
    let model: Model
    
    var body: some View {
        HStack(alignment: .top) {
            Color(.brown)
                .frame(width: 35, height: 35)
            LaunchInfoHStack()
            Spacer()
            Image(uiImage: model.missonStatus)
                .resizable()
                .frame(width: 35, height: 35)
        }
    }
}

extension LaunchView {
    struct Model: Identifiable {
        let id = UUID()
        let missonName: String
        let missonStatus: UIImage
    }
}

struct LaunchInfoHStack: View {
    let models = [
        (title: "Mission:", value: "mission 1"),
        (title: "Date/time:", value: "10/01/1995"),
        (title: "Rocket:", value: "some rocket"),
        (title: "Days since now:", value: "3400")
    ]
    
    var body: some View {
        VStack {
            Grid(alignment: .leading) {
                ForEach(models, id: \.0) { model in
                    GridRow() {
                        Text(model.title)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(model.value)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}
