//
//  SaveView.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import SwiftUI

struct SaveView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SaveViewModel()
    @State var isShowAlert = false
    @State var errorMessage = ""
    @State var isAppear = false

    var body: some View {
        NavigationView{
            VStack {
                ZStack {
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("title.save")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .accessibilityIdentifier("title.detail")
                    }
                    HStack{
                        Spacer()
                        Button(action: {
//                            addApod()
                        }) {
                            Image(systemName: "bookmark")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                }
                Divider()
                if viewModel.isLoading {
                    ProgressView {
                        Text("loading")
                            .foregroundColor(.pink)
                            .bold()
                            .accessibilityIdentifier("loading")
                    }
                } else {
                    List {
                        ForEach(viewModel.apodList, id: \.date) { item in
                            NavigationLink(destination: DetailView(date: item.date)) {
                                HStack {
                                    if item.mediaType == "video" {
                                        AsyncImage(url: URL(string: API.DefaultValue.playVideoImade )) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        AsyncImage(url: URL(string: item.url )) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    VStack {
                                        HStack {
                                            Text("date")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .accessibilityIdentifier("date")
                                            Text(item.date)
                                                .font(.subheadline)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("title")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .accessibilityIdentifier("title")
                                            Text(item.title)
                                                .font(.subheadline)
                                            Spacer()
                                        }
                                        
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.green, lineWidth: 4)
                            )
                            .listRowSeparator(.hidden)
                            .accessibilityIdentifier("DetailViewButton")
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarHidden(true)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }.navigationViewStyle(.stack)
    }
}

#Preview {
    SaveView()
}
