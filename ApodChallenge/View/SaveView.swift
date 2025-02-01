//
//  SaveView.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import SwiftUI
import RealmSwift

struct SaveView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SaveViewModel()
    @State var isShowAlert = false
    @State var errorMessage = ""
    @State var isAppear = false
    @ObservedResults(ApodObject.self) var apodList

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
                }
                .padding(.horizontal, 10)
                Divider()
                if apodList.isEmpty {
                    Text("no.saves")
                        .foregroundColor(.pink)
                        .bold()
                        .accessibilityIdentifier("no.saves")
                    Spacer()
                } else {
                    List {
                        ForEach(apodList, id: \.date) { item in
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
                            Button(action:{ self.deleteData(id: "\(item.id)") }) {
                                Text("delete.button")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal, 10)
                    .listStyle(.plain)
                }
            }
            .onAppear {
                if !self.isAppear {
                    self.isAppear = true
                    callData()
                }
            }
            .alert(isPresented: $isShowAlert, content: {
                Alert(
                    title: Text("warning.network.connection"),
                    message: Text(errorMessage))
            })
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)

        
    }
    
    func callData() {
        viewModel.isLoading = true
        viewModel.getApodRealm(
            callBack: {
                viewModel.isLoading = false
            },
            failure: { error in
                errorMessage = error
                self.isShowAlert = true
            })
    }
    
    func deleteData(id: String) {
        viewModel.removeApod(
            id: id,
            failure: { error in
                errorMessage = error
                self.isShowAlert = true
            })
    }
}

#Preview {
    SaveView()
}
