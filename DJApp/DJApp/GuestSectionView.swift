//
//  GuestSectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI



struct GuestSectionView: View {
    @State private var showAlert = false
    @State private var selectMusic = false
    @State private var showQR = false
    @State private var showChat = false
    @State private var showSettings = false
    
    @State private var sheetMode: SheetMode = .half
    
 
    @StateObject var viewModel = GuestSectionViewModel()
    
    
    var body: some View {
//        let noPlaylist = Binding<Bool>(get: { viewModel.playlist == nil }, set: { _ in })
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

               //     VoteButtonsView(nominations: nominations, vote: viewModel.room?.vote, voteTally: viewModel.room!.voteTally, colors: viewModel.colors, postVotesInChat: ) { vote in
          //              viewModel.vote(vote: vote)

       //             }
          //          .padding(.top)
            //        Spacer()
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
   //     .background(LinearGradient(colors: [Color(hex: "#666666"), Color(hex: "#d41041")], startPoint: .top, endPoint: .bottom))
        //            .frame(width: geometry.size.width , height: geometry.size.height)
        .background(LinearGradient(colors: [viewModel.colors[0], viewModel.colors[2], viewModel.colors[3]], startPoint: .bottomLeading, endPoint: .topTrailing))        
        //        }
        
        //        .background(Color.green)
        .sheet(isPresented: $selectMusic) {
            SongLinkView()
//                    .offset(y: UIScreen.main.bounds.height/2)
            
            
//            PickPlaylistFlowView(provider: $viewModel.provider)
//            List
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
//            Color.yellow.opacity(5)
            ChatView()
//                .opacity(0.5)
                
        }
//        .opacity(0.5)
        
//        .fullScreenCover(isPresented: $showSettings) {
 //           SettingsView(model: SettingsViewModel(entry: viewModel.room!.settings), root: true, showing: $showSettings, toggle:)
   //     }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure want to exit the room?"),
//                message: Text("All guests will have to leave as well."),
                primaryButton: .default(
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
    
//    @StateObject var viewModel: GuestSectionViewModel
//    @State private var showAlert = false
//
//    public init(roomService: RoomService) {
//        _viewModel = StateObject(wrappedValue: GuestSectionViewModel(roomService: roomService))
//    }
//
//    var body: some View {
//        let nominations = viewModel.room?.nominations
//
//        VStack(alignment: .center) {
//            if viewModel.leaving {
//                ProgressView()
//            } else {
//                if let errorMessage = viewModel.leavingErrorMessage {
//                    Text(errorMessage)
//                        .padding()
//
//                    //                Text("Name: \(viewModel.room.name)")
//                    //                    .padding()
//                    //
//                    //                Text("Code: \(viewModel.room.code)")
//                    //                    .padding()
//                }
//                if let nominations = nominations {
//                    VoteButtonsView(nominations: nominations, vote: viewModel.room?.vote, voteTally: viewModel.room!.voteTally) { vote in
//                        viewModel.vote(vote: vote)
//                    }
//                }
//
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        showAlert = true
//                    }) {
//                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
//
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 50)
//                            .foregroundColor(Color.black)
//
//                    }
//                    Spacer()
////                    Button(action: {
////
////                    }) {
////                        //                            Text("HostSettings")
////
////                        Image(systemName: "gearshape.fill")
////                            .resizable()
////                            .aspectRatio(contentMode: .fit)
////                            .frame(width: 50)
////                            .foregroundColor(Color.black)
////                    }
////                    Spacer()
//                    //                        Button(action: {
//                    //
//                    //                        }) {
//                }
//                .padding(.vertical, 16)
//                .background(Color.white)
//
//            }
//        }
////            .frame(width: geometry.size.width , height: geometry.size.height)
//        .background(Color.green)
//
////        }
//
//    .background(Color.green)
//
//    .alert(isPresented: $showAlert) {
//        Alert(
//            title: Text("Are you sure want to exit the room?"),
//            message: Text("All guests will have to leave as well."),
//            primaryButton: .destructive(
//                Text("Yes"),
//                action: {viewModel.leaveRoom()}
//            ),
//            secondaryButton: .cancel()
//        )
//
//    }
//    }
//}

class MockRoomService: RoomService {
    var room:Room? = Room(id: "1516", name: "myRoom", code: "156", hosting: false, currentSong: Song(id: "98610", provider: .spotify, title: "Way 2 Sexy", artist: "Drake", artwork: "https://i.scdn.co/image/ab67616d0000b273cd945b4e3de57edd28481a3f"),
        nominations: (Song(id: "15615", provider: .spotify, title: "Every Little Thing She Does is Magic", artist: "The Police", artwork: "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Everylittlething.jpg/220px-Everylittlething.jpg"), Song(id: "48118", provider: .spotify, title: "Levels", artist: "Aviici", artwork: "https://upload.wikimedia.org/wikipedia/en/2/2c/Levelssong.jpg")),
                          vote: nil, voteTally: VoteTally(song1: 5, song2: 2, random: 1))
    
    func joinRoom(_ code: String) async -> JoinRoomResult {
        return .success
    }
    
    func refreshRoom() async -> RefreshRoomResult {
        return .success
    }
    
    func hostRoom(_ name: String) async -> HostRoomResult {
        return .success(room!)
    }
    
    func leaveRoom() async -> LeaveRoomResult {
        return .success
    }
    
    func updateCurrentSong(song: Song) async -> UpdateSongResult {
        return .success
    }
    
    func updateNominations(song1: Song, song2: Song) async -> UpdateNominationsResult {
        return .success
    }
    
    func vote(vote: Vote) async -> VoteResult {
        return .success(room!)
    }
    
    
}

struct GuestSectionView_Previews: PreviewProvider {
    static var previews: some View {
        GuestSectionView()
    }
}
