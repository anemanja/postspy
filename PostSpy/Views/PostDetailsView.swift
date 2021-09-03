//
//  PSPostDetailsView.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

struct PostDetailsView: View {
    @ObservedObject var viewModel: PostDetailsViewModel
    
    var post: PSPost
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(post.title)
                .font(.headline)
                .padding(.bottom, 5.0)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .padding()
            ScrollView(content: {
                Text(post.body)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            .border(Color.gray, width: 1)
            VStack(content: {
                Text(viewModel.user?.name ?? "")
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity)
                Link(viewModel.user?.email ?? "", destination: URL(string: "mailto:" + (viewModel.user?.email ?? ""))!)
                    .multilineTextAlignment(.trailing)
                    .textCase(.lowercase)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            })
            .padding()
        })
        .onAppear() {
            viewModel.loadUser(userId: post.userId)
        }
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
