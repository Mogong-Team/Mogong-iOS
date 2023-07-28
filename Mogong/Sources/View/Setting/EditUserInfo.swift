//
//  EditUserInfo.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/26.
//

import SwiftUI

struct EditUserInfo: View {
    @EnvironmentObject var viewModel: UserViewModel
    
    @State private var showDialog = false
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            ZStack {
                Image(viewModel.currentUser.userimageString)
                    .resizable()
                    .onTapGesture {
                        showDialog = true
                    }
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundColor(.gray)
                    .padding(.leading, 60)
                    .padding(.top, 70)
            }
            .frame(width: 100, height: 100)
            .padding(20)
            Divider()
            
            HStack {
                Text("닉네임")
                    .font(.pretendard(weight: .medium, size: 20))
                TextField("닉네임 변경", text: $viewModel.currentUser.username)
                    .font(.pretendard(weight: .medium, size: 20))
                    .foregroundColor(Color(hexColor: "00C7F4"))
                    .multilineTextAlignment(.trailing)
            }
            .padding(20)
            Divider()
            
            Spacer()
            
            ActionButton("프로필 수정하기") {
                
            }
            .padding(20)

        }
        .navigationTitle("프로필 수정")
        .confirmationDialog("컬러 선택", isPresented: $showDialog) {
            Button() {
                showImagePicker = true
            } label: {
                Text("앨범에서 사진 선택")
            }
            
            Button() {
                viewModel.currentUser.userimageString = "TempBasicImage"
            } label: {
                Text("기본 이미지로 변경")
            }
            
            Button(role: .cancel) {
                
            } label: {
                Text("취소")
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        // TODO: Post User
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
}


struct EditUserInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditUserInfo()
            .environmentObject(UserViewModel())
    }
}
