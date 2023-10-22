import SwiftUI

struct LaunchListView<ViewModel: LaunchListViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.launchModels, id: \.id) { model in
            LaunchView(model: model)
                .listRowInsets(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
        }
    }
}
