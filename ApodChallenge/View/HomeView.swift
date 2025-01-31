//
//  HomeView.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State var isShowAlert = false
    @State var errorMessage = ""
    @State var isAppear = false
    @State private var startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date.now)!
    @State private var endDate = Date.now


    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("title.home")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .accessibilityIdentifier("title.home")
                    Spacer()
                    NavigationLink(destination: SaveView()) {
                      Image("diskette")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }
                }
                .padding(.horizontal, 10)
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
                        HStack {
                            VStack {
                                Text("start.date")
                                DatePicker("", selection: $startDate, in: ...Date.now, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .fixedSize()
                            }
                            Spacer()
                            VStack {
                                Text("end.date")
                                DatePicker("", selection: $endDate, in: ...Date.now, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .fixedSize()
                            }
                        }.padding(.horizontal, 10)
                        Button(action:{callApi()}) {
                            Text("date.search")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .padding(.horizontal, 10)
                        Button(action:{callApiToday()}) {
                            Text("today")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .padding(.horizontal, 10)
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
                                        AsyncImage(url: URL(string: item.url ?? API.DefaultValue.notFoundImageURL )) { image in
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
            .padding(.vertical, 10)
            .onAppear {
                if !self.isAppear {
                    self.isAppear = true
                    callApi()
                }
            }
            .alert(isPresented: $isShowAlert, content: {
                Alert(
                    title: Text("warning.network.connection"),
                    message: Text(errorMessage),
                    dismissButton: .destructive(Text("button.try.again"), action: {
                        callApi()
                    }))
            })
        }.navigationViewStyle(.stack)
    }
    
    
    func callApi() {
        viewModel.isLoading = true
        let formatter = DateFormatter()
        formatter.dateFormat = API.DefaultValue.dateFormat
        viewModel.getApodList(
            startDate: formatter.string(from: self.startDate),
            endDate: formatter.string(from: self.endDate),
            callBack: {
                viewModel.isLoading = false
            }, failure: { error in
                self.isShowAlert = true
                self.errorMessage = error
            })
    }
    
    func callApiToday() {
        viewModel.isLoading = true
        viewModel.getApod(
            callBack: {
                viewModel.isLoading = false
            }, failure: { error in
                self.isShowAlert = true
                self.errorMessage = error
            })
    }
}

#Preview {
    HomeView()
}
