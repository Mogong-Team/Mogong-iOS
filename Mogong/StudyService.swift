//
//  StudyService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire
import FirebaseFirestore

//MARK: Firebase

class StudyService {
    
    static let shared = StudyService()
    private init() { }
    
    private var db = Firestore.firestore()
    
    //MARK: 스터디 생성
    
    static func createStudy(study: Study, completion: @escaping () -> Void) {
        do {
            // Study 인스턴스를 JSON 객체로 변환
            let jsonData = try JSONEncoder().encode(study)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion()
                return
            }
            
            shared.db.collection("studys").document(study.id).setData(json) { error in
                completion()
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion()
        }
    }
    
    //MARK: 스터디 수정
    
    static func updateStudy(study: Study, completion: @escaping (Error?) -> Void) {
        do {
            // Study 인스턴스를 JSON 객체로 변환
            let jsonData = try JSONEncoder().encode(study)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터 변환 실패"]))
                return
            }
            
            shared.db.collection("studys").document(study.id).updateData(json) { error in
                if let error = error {
                    print("업데이트 실패: \(error)")
                    completion(error)
                    return
                }
                completion(nil)
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion(error)
        }
    }
    
    //MARK: 스터디 가져오기
    
    static func getAllStudys(completion: @escaping (Result<[Study], Error>) -> Void) {
        shared.db.collection("studys")
            .order(by: "createDate", descending: true)
            .getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let studys: [Study] = querySnapshot?.documents.compactMap { document in
                do {
                    let data = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    let study = try JSONDecoder().decode(Study.self, from: data)
                    return study
                } catch {
                    print("JSON 변환 오류: \(error)")
                    return nil
                }
            } ?? []
            
            completion(.success(studys))
        }
    }
    
    static func getUserStudys(completion: @escaping (Result<[Study], Error>) -> Void) {
        
        let joinedStudyIds = UserViewModel.shared.currentUser.joinedStudyIds
        
        //  각 스터디 ID에 대해 스터디 정보를 가져오고, Study 객체 배열을 생성합니다.
        let group = DispatchGroup()
        var studys: [Study] = []
        
        for studyId in joinedStudyIds {
            group.enter()
            shared.db.collection("studys").document(studyId).getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                do {
                    guard let data = snapshot?.data() else { return }
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let study = try JSONDecoder().decode(Study.self, from: jsonData)
                    studys.append(study)
                } catch let error {
                    completion(.failure(error))
                }
                
                group.leave()
            }
        }
        
        // 모든 네트워크 요청이 완료되면, completion 호출
        group.notify(queue: .main) {
            completion(.success(studys))
        }
    }
    
    
    static func getStudyById(studyId: String, completion: @escaping (Result<Study, Error>) -> Void) {
        shared.db.collection("studys").document(studyId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                guard let data = snapshot?.data() else { return }
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let study = try JSONDecoder().decode(Study.self, from: jsonData)
                completion(.success(study))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    //MARK: 북마크
    
    static func addBookmarkedUser(studyId: String, userId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("studys").document(studyId).updateData([
            "bookMarkedUsers": FieldValue.arrayUnion([userId])
        ]) { error in
            completion(error)
        }
    }
    
    static func deleteBookmarkedUser(studyId: String, userId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("studys").document(studyId).updateData([
            "bookMarkedUsers": FieldValue.arrayRemove([userId])
        ]) { error in
            completion(error)
        }
    }
    
    //MARK: 지원서
    
    static func addApplicationId(studyId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("studys").document(studyId).updateData([
            "submittedApplications": FieldValue.arrayUnion([applicationId])
        ]) { error in
            completion(error)
        }
    }
    
    static func deleteApplicationId(studyId: String, applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("studys").document(studyId).updateData([
            "submittedApplications": FieldValue.arrayRemove([applicationId])
        ]) { error in
            completion(error)
        }
        
        
    }
}
