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
    
    private var db = Firestore.firestore()
    
    // 새로운 스터디 생성
    func createStudy(study: Study, completion: @escaping () -> Void) {
        do {
            // Study 인스턴스를 JSON 객체로 변환
            let jsonData = try JSONEncoder().encode(study)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패") // 오류 메시지를 콘솔에 로깅
                completion()
                return
            }
            
            // Firestore에 스터디 데이터 저장
            db.collection("studies").addDocument(data: json) { error in
                if let error = error {
                    print("Firestore 저장 오류: \(error)")
                }
                completion()
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion()
        }
    }
    
    // ID를 통해 스터디 가져오기
    func getStudyById(studyId: String, completion: @escaping (Study?, Error?) -> Void) {
        db.collection("studies").document(studyId).getDocument { snapshot, error in
            guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data() else {
                completion(nil, error)
                return
            }
            
            do {
                // JSON 데이터를 Study 인스턴스로 디코딩
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let study = try JSONDecoder().decode(Study.self, from: jsonData)
                completion(study, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
    
    // 스터디 업데이트
    func updateStudy(studyId: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("studies").document(studyId).updateData(data) { error in
            completion(error)
        }
    }
    
    // 스터디 삭제
    func deleteStudy(studyId: String, completion: @escaping (Error?) -> Void) {
        db.collection("studies").document(studyId).delete { error in
            completion(error)
        }
    }
    
    // 모든 스터디 가져오기
    func getAllStudies(completion: @escaping ([Study]?, Error?) -> Void) {
        db.collection("studies").getDocuments { snapshot, error in
            guard let snapshot = snapshot else {
                completion(nil, error)
                return
            }
            
            do {
                // 각 문서의 데이터를 Study 인스턴스로 디코딩하여 배열로 반환
                let studies = try snapshot.documents.compactMap {
                    try JSONDecoder().decode(Study.self, from: JSONSerialization.data(withJSONObject: $0.data(), options: []))
                }
                completion(studies, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
    
    // 필요에 따라 검색, 필터링 등의 추가 메서드를 여기에 추가할 수 있습니다.
}

//MARK: Alamofire

//class StudyService {
//
//    static let shared = StudyService()
//
//    func fetchStudys(completion: @escaping (Result<[Study], Error>) -> Void) {
//        let url = "https://your-api-url.com/studys"
//
//        AF.request(url).responseDecodable(of: [Study].self) { response in
//            switch response.result {
//            case .success(let study):
//                completion(.success(study))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    func addStudy(_ study: Study, completion: @escaping (Result<Study, Error>) -> Void) {
//        let url = "https://your-api-url.com/studys"
//
//        AF.request(url, method: .post, parameters: study, encoder: JSONParameterEncoder.default)
//            .responseDecodable(of: Study.self) { response in
//                switch response.result {
//                case .success(let newApplication):
//                    completion(.success(newApplication))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    func updateStudy(_ study: Study, completion: @escaping (Result<Study, Error>) -> Void) {
//        let url = "https://your-api-url.com/studys/\(study.id)"
//
//        AF.request(url, method: .put, parameters: study, encoder: JSONParameterEncoder.default)
//            .responseDecodable(of: Study.self) { response in
//                switch response.result {
//                case .success(let updatedStudy):
//                    completion(.success(updatedStudy))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    func deleteStudy(_ study: Study, completion: @escaping (Result<Void, Error>) -> Void) {
//        let url = "https://your-api-url.com/studys/\(study.id)"
//
//        AF.request(url, method: .delete).response { response in
//            switch response.result {
//            case .success:
//                completion(.success(()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}



