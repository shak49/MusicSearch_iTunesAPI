//
//  SearchView.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/24/21.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SearchView: View {
//    @State var show = false
//    @State var searchText = ""
//    @State var songListVM = SongListVM()
//
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack {
////                if !self.show {
////                    Text("Artists")
////                        .fontWeight(.medium)
////                        .font(.title)
////                        .foregroundColor(Color(.systemBlue))
////                }
//                Spacer(minLength: 0)
//                HStack {
//                    if self.show {
//                        TextField("Search for an artist...", text: self.$searchText)
//                            .padding(10)
//                            //.background(Color(.secondarySystemBackground))
//                        Button {
//                            withAnimation {
//                                self.show.toggle()
//                            }
//                        } label: {
//                            Image(systemName: "xmark")
//                                .padding(.trailing)
//                        }
//                    } else {
//                        Button {
//                            withAnimation {
//                                self.show.toggle()
//                            }
//                        } label: {
//                            Text("Search Artist").foregroundColor(.blue).padding(10)
//                        }
//                    }
//                }
//                .background(Color(.secondarySystemBackground))
//                .cornerRadius(20)
//                //.clipShape(Circle())
//                .padding(self.show ? 10 : 0)
//            }
//            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
//            .padding(.horizontal)
//            .padding(.bottom, 10)
//            Spacer()
//
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: 15) {
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
