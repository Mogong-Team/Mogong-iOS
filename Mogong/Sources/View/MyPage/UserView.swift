//
//  UserView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @State private var showingSettings = false
    
    var body: some View {
            VStack(alignment: .leading) {
                UserInfo()
                    .padding(.bottom, 10)
                UserBadge()
            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("setting")
                        .onTapGesture {
                            showingSettings = true
                        }
                }
            }
            .navigationDestination(isPresented: $showingSettings) {
                SettingView()
            }
        }
}

struct UserInfo: View {
    @EnvironmentObject var viewModel: UserViewModel
    
    @State private var showDialog = false
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var showingEditNickname = false
    @State private var newNickname = ""

    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                ZStack {
                    Image(viewModel.currentUser.userimageString)
                        .resizable()
                        .frame(width: 92, height: 92)
//                        .onTapGesture {
//                            showDialog = true
//                        }
                    
//                    Image(systemName: "camera.fill")
//                        .resizable()
//                        .frame(width: 25, height: 20)
//                        .foregroundColor(.gray)
//                        .padding(.leading, 60)
//                        .padding(.top, 70)
                }
                .frame(height: 100)
                .padding(.trailing, 20)
                
                HStack {
//                    TextField("닉네임 변경", text: $viewModel.currentUser.username)
                    Text(viewModel.currentUser.username)
                        .font(.pretendard(weight: .bold, size: 28))
                        .foregroundColor(Color(hexColor: "4E4E4E"))
                        .frame(height: 32)
//                    Button {
//                        showingEditNickname.toggle()
//                    } label: {
//                        Image(systemName: "pencil")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                    }
                }
                
                Spacer()
            }
        }
        .frame(height: 100)
//        .confirmationDialog("수정", isPresented: $showDialog) {
//            Button() {
//                showImagePicker = true
//            } label: {
//                Text("앨범에서 사진 선택")
//            }
//
//            Button() {
//                viewModel.currentUser.userimageString = "TempBasicImage"
//            } label: {
//                 Text("기본 이미지로 변경")
//            }
//
//            Button(role: .cancel) {
//
//            } label: {
//                Text("취소")
//            }
//        }
//        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
//            ImagePicker(selectedImage: $inputImage)
//        }
//        .confirmationDialog("닉네임 수정", isPresented: $showingEditNickname) {
//            Button("저장") {
//                viewModel.currentUser.username = viewModel.currentUser.username
//                showingEditNickname = false
//            }
//        }
    }
    
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//        // TODO: Post User
//    }
}

//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Environment(\.dismiss) private var dismiss
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.selectedImage = uiImage
//            }
//
//            parent.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
//}

struct UserBadge: View {
    @EnvironmentObject var viewModel: UserViewModel
    @State var presentBookmarkView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("나의 뱃지")
                        .font(.pretendard(weight: .bold, size: 24))
                        .foregroundColor(Color(hexColor: "615B5B"))
                    Text("뽐내고 싶은 뱃지를 선택하세요!")
                        .font(.pretendard(weight: .regular, size: 14))
                        .foregroundColor(Color(hexColor: "ABA5A5"))
                }
                Spacer()
                HStack {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 7, height: 10)
                        .foregroundColor(Color.main)
                    Text("스크랩 스터디")
                        .font(.pretendard(weight: .semiBold, size: 12))
                        .foregroundColor(Color(hexColor: "545454"))
                        .onTapGesture {
                            presentBookmarkView = true
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(Color(hexColor: "8FD0FF"), lineWidth: 1)
                }
            }
            .padding(.bottom, 5)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 30) {
                        Badge(name: "스터디 비기너")
                        Badge(name: "스터디 창립자")
                        Badge(name: "스터디 가입자")
                        Badge(name: "스터디 출석자")
                        Badge(name: "트리플 출석자")
                        Badge(name: "스터디 완주자")
                        Badge(name: "두번째 완주자")
                        Badge(name: "세번째 완주자")
                        Badge(name: "네번쨰 완주자")
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationDestination(isPresented: $presentBookmarkView) {
            BookmarkView()
        }
    }
}

struct Badge: View {
    var name: String
    
    var body: some View {
        VStack {
            Image("noOpenBadge")
            Text(name)
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(Color(hexColor: "545454"))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserViewModel())
    }
}
