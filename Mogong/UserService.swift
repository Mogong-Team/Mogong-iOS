//
//  UserService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire
import FirebaseFirestore

//MARK: Firebase

class UserService {
    
    static let shared = UserService()
    private init() { }
    
    private var db = Firestore.firestore()
    
    // 현재 유저 정보 저장
    static func saveUser(user: User, completion: @escaping (Error?) -> Void) {
        let dataDic: [String: Any] = [
            "id": user.id,
            "email": user.email,
            "username": user.username,
            "userimageString": user.userimageString,
            "submittedApplicationIds": user.submittedApplicationIds,
            "joinedStudyIds": user.joinedStudyIds,
            "bookmarkedStudyIds": user.bookmarkedStudyIds,
        ]
        
        shared.db.collection("users").document(user.id).setData(dataDic) { error in
            completion(error)
        }
    }
    
    // 현재 유저 정보 가져오기
    static func getUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        shared.db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists, let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
                return
            }
            
            guard
                let id = data["id"] as? String,
                let email = data["email"] as? String,
                let username = data["username"] as? String,
                let userimageString = data["userimageString"] as? String,
                let submittedApplicationIds = data["submittedApplicationIds"] as? [String],
                let joinedStudyIds = data["joinedStudyIds"] as? [String],
                let bookmarkedStudyIds = data["bookmarkedStudyIds"] as? [String]
            else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is corrupt"])))
                return
            }

            let user = User(
                id: id,
                email: email,
                username: username,
                userimageString: userimageString,
                submittedApplicationIds: submittedApplicationIds,
                joinedStudyIds: joinedStudyIds,
                bookmarkedStudyIds: bookmarkedStudyIds
            )
            completion(.success(user))
        }
    }
    
    //MARK: 북마크

    static func addBookmarkedStudyIds(userId: String, studyId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "bookmarkedStudyIds": FieldValue.arrayUnion([studyId])
        ]) { error in
            completion(error)
        }
    }
    
    static func deleteBookmarkedStudyIds(userId: String, studyId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "bookmarkedStudyIds": FieldValue.arrayRemove([studyId])
        ]) { error in
            completion(error)
        }
    }
    
    //MARK: 지원서
    
    static func addBookmarkedStudyIds(userId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "submittedApplicationIds": FieldValue.arrayUnion([applicationId])
        ]) { error in
            completion(error)
        }
    }
    
    static func deleteBookmarkedStudyIds(userId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "submittedApplicationIds": FieldValue.arrayRemove([applicationId])
        ]) { error in
            completion(error)
        }
    }
}

//MARK: Alamofire
    
//class UserServices  {
//
//    static let shared = UserServices()
//
//    static func fetchUser(withId id: String, completion: @escaping (Result<User, Error>) -> Void) {
//        AF.request("https://your-api-url.com/users/\(id)")
//            .validate()
//            .responseDecodable(of: User.self) { response in
//                switch response.result {
//                case .success(let user):
//                    completion(.success(user))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    static func addUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
//        AF.request("https://your-api-url.com/users", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
//            .validate()
//            .responseDecodable(of: User.self) { response in
//                switch response.result {
//                case .success(let user):
//                    completion(.success(user))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    static func updateUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
//        AF.request("https://your-api-url.com/users/\(user.id)", method: .put, parameters: user, encoder: JSONParameterEncoder.default)
//            .validate()
//            .responseDecodable(of: User.self) { response in
//                switch response.result {
//                case .success(let user):
//                    completion(.success(user))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    static func deleteUser(withId id: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        AF.request("https://your-api-url.com/users/\(id)", method: .delete)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    static func updateJoinedStudys(user: User, studyId: String, completion: @escaping (Result<User, Error>) -> Void) {
//        AF.request("https://your-api-url.com/users/\(user.id)", method: .put, parameters: user, encoder: JSONParameterEncoder.default)
//            .validate()
//            .responseDecodable(of: User.self) { response in
//                switch response.result {
//                case .success(let user):
//                    completion(.success(user))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//}
