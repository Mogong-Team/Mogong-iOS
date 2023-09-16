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
    
    //MARK: 유저 정보 업데이트
    
    static func updateUser(user: User, completion: @escaping (Error?) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(user)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터 변환 실패"]))
                return
            }
            
            shared.db.collection("users").document(user.id).setData(json, merge: true) { error in
                completion(error)
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion(error)
        }
    }

    //MARK: 유저 정보 저장
    
    static func saveUser(user: User, completion: @escaping (Error?) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(user)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터 변환 실패"]))
                return
            }
            
            shared.db.collection("users").document(user.id).setData(json) { error in
                completion(error)
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion(error)
        }
    }

    //MARK: 유저 정보 가져오기
    
    static func getUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
//        shared.db.collection("users").document(userId).getDocument { document, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let document = document, document.exists, let data = document.data() else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
//                return
//            }
//
//            guard
//                let id = data["id"] as? String,
//                let email = data["email"] as? String,
//                let username = data["username"] as? String,
//                let userimageString = data["userimageString"] as? String,
//                let submittedApplicationIds = data["submittedApplicationIds"] as? [String],
//                let joinedStudyIds = data["joinedStudyIds"] as? [String],
//                let bookmarkedStudyIds = data["bookmarkedStudyIds"] as? [String]
//            else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is corrupt"])))
//                return
//            }
//
//            let user = User(
//                id: id,
//                email: email,
//                username: username,
//                userimageString: userimageString,
//                submittedApplicationIds: submittedApplicationIds,
//                joinedStudyIds: joinedStudyIds,
//                bookmarkedStudyIds: bookmarkedStudyIds
//            )
//            completion(.success(user))
//        }
        
        shared.db.collection("users").document(userId).getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                do {
                    guard let data = snapshot?.data() else { return }
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            }
    }
    
    //MAKR: 탈퇴하기
    static func deleteAccount(userId: String) {
    }
    
    //MARK: 스터디
    
    static func addJoinedStudyIds(userId: String, studyId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "joinedStudyIds": FieldValue.arrayUnion([studyId])
        ]) { error in
            completion(error)
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
    
    static func addApplicationId(userId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "submittedApplicationIds": FieldValue.arrayUnion([applicationId])
        ]) { error in
            completion(error)
        }
    }
    
    static func deleteApplicationId(userId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("users").document(userId).updateData([
            "submittedApplicationIds": FieldValue.arrayRemove([applicationId])
        ]) { error in
            completion(error)
        }
    }
}
