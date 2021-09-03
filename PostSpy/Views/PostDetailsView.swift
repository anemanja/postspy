//
//  PSPostDetailsView.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

struct PostDetailsView: View {
    @ObservedObject var viewModel: PostDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var shouldShowAlert: Bool = false
    
    var post: PSPost
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(post.title)
                .font(.headline)
                .padding(.bottom, 5.0)
                .textCase(.uppercase)
                .foregroundColor(.postSpyTextPrimary)
                .padding()
            ScrollView(content: {
                Text(post.body)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            Divider()
            VStack(content: {
                Text(viewModel.user?.name ?? "")
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity)
                Link(viewModel.user?.email ?? "", destination: URL(string: "mailto:" + (viewModel.user?.email ?? ""))!)
                    .multilineTextAlignment(.trailing)
                    .textCase(.lowercase)
                    .font(.subheadline)
                    .foregroundColor(.postSpyTextPrimary)
                    .frame(maxWidth: .infinity)
            })
            .padding()
            Divider()
            Button(action: {
                viewModel.deletePost(postId: post.id) {
                    shouldShowAlert = true
                }
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "trash")
                    .imageScale(.large)
                    .foregroundColor(.postSpySecondary)
            })
            .frame(maxWidth: .infinity, minHeight: 40)
        })
        .onAppear() {
            viewModel.loadUser(userId: post.userId) {
                shouldShowAlert = true
            }
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text("Network Error"), message: Text(viewModel.networkErrorText))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PSPostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(
            viewModel: PostDetailsViewModel(mockFile: "user3.json"),
            post: PSPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "ut aspernatur corporis harum nihil quis provident sequi\n\nmollitia nobis aliquid molestiae perspiciatis et ea nemo ab reprehenderit accusantium quas\n\nvoluptate dolores velit et doloremque molestiae ut aspernatur corporis harum nihil quis provident sequi\n\nmollitia nobis aliquid molestiae\n\nperspiciatis et ea nemo ab reprehenderit accusantium quas  voluptate dolores\nut aspernatur corporis harum nihil quis provident sequi\n\nmollitia nobis aliquid molestiae perspiciatis et ea nemo ab reprehenderit accusantium quas\n\nvoluptate dolores velit et doloremque molestiae ut aspernatur corporis harum nihil quis provident sequi\n\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas  voluptate dolores")
            )
    }
}
