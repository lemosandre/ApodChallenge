//
//  DetailView.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoId: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: videoId) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = DetailViewModel()
    @State private var viewModelSave = SaveViewModel()
    @State var date: String
    @State var errorMessage = ""
    @State var isShowAlert = false
    
    var body: some View {
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
                    Text("title.detail")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .accessibilityIdentifier("title.detail")
                }
                HStack{
                    Spacer()
                    Button(action: {
                        addApod()
                    }) {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
            }
            ScrollView {
                VStack(spacing: 10) {
                    if viewModel.apod.mediaType == "video" {
                        YouTubeView(videoId: viewModel.apod.url ?? "")
                            .frame(width: 300, height: 300)
                            .padding()
                    } else {
                        AsyncImage(url: URL(string: viewModel.apod.url ?? API.DefaultValue.notFoundImageURL )) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    HStack {
                        Text("name.detail")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(viewModel.apod.title)
                            .font(.subheadline)
                        Spacer()
                    }
                    VStack {
                        Text("explanation.detail")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(viewModel.apod.explanation ?? "")
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .onAppear {
            callApi()
        }
        .alert(isPresented: $isShowAlert, content: {
            Alert(
                title: Text("warning.network.connection"),
                message: Text(errorMessage),
                dismissButton: .destructive(Text("button.try.again"), action: {
                    callApi()
                }))
        })
    }
    
    func callApi() {
        viewModel.getApodDate(
            date: self.date,
            callBack: {
                viewModel.isLoading = false
            }, failure: { error in
                self.isShowAlert = true
                self.errorMessage = error
            })
    }
    
    func addApod() {
        print("Save")
        let apod = ApodObject()
        apod.title = viewModel.apod.title
        apod.date = viewModel.apod.date
        apod.explanationone = viewModel.apod.explanation ?? ""
        apod.hdurl = viewModel.apod.hdurl ?? ""
        apod.mediaType = viewModel.apod.mediaType ?? ""
        apod.serviceVersion = viewModel.apod.serviceVersion ?? ""
        apod.url = viewModel.apod.url ?? ""
        apod.copyright = viewModel.apod.copyright ?? ""
        viewModelSave.addApod(apod: apod)
    }
}

#Preview {
    DetailView(date: "2025-01-29")
}
