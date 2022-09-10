//
//  HostingSectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct HostSectionView: View {
    @State private var showAlert = false
    @State private var selectMusic = false
    @State private var showQR = false
    @State private var showChat = false
    @State private var showSettings = false
//    @State private var settings = SettingEntry(displayName: "Settings", setting: .group(entries: [SettingEntry(displayName: "Colors", setting: .group(entries: [])), SettingEntry(displayName: "Host Settings", setting: .group(entries: [SettingEntry(name: "Allow Changing Votes", displayName: "Allow Changing Votes", setting: .toggle(value: false)), SettingEntry(name: "Post Votes", displayName: "Post Votes in Chat", setting: .toggle(value: false))]))]))
    
    @StateObject var viewModel = HostSectionViewModel()
    
    
    var body: some View {
        let noPlaylist = Binding<Bool>(get: { viewModel.playlist == nil }, set: { _ in })
        var nominations = viewModel.room?.nominations
        
        //        GeometryReader {geometry in
        
        VStack(alignment: .center) {
            if viewModel.leaving {
                ProgressView()
            } else {
                HStack {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        
                        
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, alignment: .center)
                            .foregroundColor(Color.black)
                            .scaleEffect(x: -1)
                        
                        
                    }
                    Spacer()
//                    Text("**Funktion**").font(.system(size: 30))
                    Spacer()
                    
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, alignment: .center)
                            .foregroundColor(Color.black)
                    }
//                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top, 4)
                
                if let errorMessage = viewModel.leavingErrorMessage {
                    Text(errorMessage)
                        .padding()

                }
                if let nominations = nominations {
                    
                

                    VoteButtonsView(nominations: nominations, vote: viewModel.room?.vote, voteTally: viewModel.room!.voteTally, colors: viewModel.colors, allowChangingVotes: viewModel.settingsState.allowChangingVotes, postVotesInChat: viewModel.settingsState.postVotesInChat) { vote in
            
                        
                       viewModel.vote(vote: vote)
                        
                   }
                    .padding(.top)
                    Spacer()
                }
                CurrentSongView()
                
                HStack {
                    Spacer()
                    Button(action: {
                        selectMusic = true
                    }) {
                        Image(systemName: "music.note.house.fill")
                        
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    
                    Button(action: {
                        showChat = true
                    }) {
                        Image(systemName: "message")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    
                    Button(action: {
                        showQR = true
                    }) {
                        Image(systemName: "qrcode")
                        
                        
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .foregroundColor(Color.black)
                        
                        
                    }
                    Spacer()
                    
                    
                                
                }
                .padding(.bottom)
                
            }
        }
    
      //  .background(viewModel.colors.color3.opacity(0.6))
    //    .background(LinearGradient(colors: [viewModel.colors.color1.opacity(0.6), viewModel.colors.color2.opacity(0.6)], startPoint: .top, endPoint: .bottom))
  //      .background(AsyncImage(url: URL(string: //"https://unblast.com/wp-content/uploads/2020/05/Gradient-Abstract-Textures-1.jpg")))
        //            .frame(width: geometry.size.width , height: geometry.size.height)
        //.background(Color(hex: "#77216f"))
      //  .background(Color(hex: "#3ea380"))
        .background(AngularGradient(colors: [viewModel.colors[1], viewModel.colors[2], viewModel.colors[0], viewModel.colors[1]], center: .center))
        
   //     .background(AngularGradient(colors: [viewModel.colors[0], viewModel.colors[2], viewModel.colors[0], viewModel.colors[2], viewModel.colors[0], viewModel.colors[2], viewModel.colors[0], ], center: .center))
        
      //  .background(AngularGradient(colors: [viewModel.colors[1], viewModel.colors[3], viewModel.colors[2], viewModel.colors[1]], center: .center))
        
     //   .background(AngularGradient(colors: []))
        
    //    .background(viewModel.colors[2])
        
       // .background(LinearGradient(colors: [viewModel.colors[2], viewModel.colors[0], viewModel.colors[4]], startPoint: .leading, endPoint: .trailing))
        
      //  .background(viewModel.colors[2])
        
       // .background(LinearGradient(colors: [viewModel.colors[3], viewModel.colors[0], viewModel.colors[2], viewModel.colors[0], viewModel.colors[3]], startPoint: .topTrailing, endPoint: .bottomLeading))
        
        
       // .background(RadialGradient(colors: [viewModel.colors[3], viewModel.colors[2], viewModel.colors[0]], center: .center, startRadius: 50, endRadius: 400))
        //        }
        
        //        .background(Color.green)
        .sheet(isPresented: $selectMusic) {
            //PickPlaylistFlowView(provider: $viewModel.provider)
            
            PlaylistSelectionView()
//                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showQR) {
            VStack {
                if let code = viewModel.room?.code {
                    Image(uiImage: generateQRCode(from: code))
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                }
                
            }
        }
        
        .sheet(isPresented: $showChat) {
            ChatView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(model: SettingsViewModel(entry: SettingEntry(displayName: "Settings", setting: .group(entries: [SettingEntry(displayName: "Colors", setting: .group(entries: [SettingEntry(displayName: "Colleges", setting: .group(entries: []))])), SettingEntry(displayName: "Host Settings", setting: .group(entries: [SettingEntry(name: "Allow Changing Votes", displayName: "Allow Changing Votes", setting: .toggle(value: $viewModel.settingsState.allowChangingVotes)), SettingEntry(name: "Post Votes", displayName: "Post Votes in Chat", setting: .toggle(value: $viewModel.settingsState.postVotesInChat))]))]))), root: true, showing: $showSettings)
        }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure want to exit the room?"),
                message: Text("All guests will have to leave as well."),
                primaryButton: .destructive(
                    Text("Yes"),
                    action: {viewModel.leaveRoom()}
                ),
                secondaryButton: .cancel()
                
            )
            
        }
        
    }
                    
    
    func generateQRCode(from code: String) -> UIImage {
        let context = CIContext()
        var qrImage = UIImage(systemName: "xmark.circle") ?? UIImage()
        let data = Data(code.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let image = context.createCGImage(outputImage, from: outputImage.extent) {
                qrImage = UIImage(cgImage: image)
            }
        }
        return qrImage
    }
}



struct PickPlaylistFlowView: View {
    @Binding var provider: Provider?
    
    var body: some View {
        if provider == nil {
            SelectMusicProviderView()
        } else {
            PlaylistSelectionView()
        }
    }
}

struct HostingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HostSectionView()
    }
}
