import SwiftUI

struct InfoHStack: View {
    let model: Model
    
    var body: some View {
        Grid(alignment: .leading) {
            ForEach(model.fields, id: \.title) { field in
                GridRow() {
                    Text(field.title)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(field.value)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    
    struct Model {
        let fields: [(title: String, value: String)]
    }
}
