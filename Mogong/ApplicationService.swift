//
//  ApplicationService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire
import FirebaseFirestore

//MARK: FIreabase

class ApplicationService {
    
    static let shared = ApplicationService()
    private init() { }
    
    private var db = Firestore.firestore()
    
    //MARK: 지원서 제출
    
    static func submitApplication(application: Application, completion: @escaping (Error?) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(application)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터 변환 실패"]))
                return
            }
            
            shared.db.collection("applications").document(application.id).setData(json) { error in
                completion(error)
            }
        } catch let error {
            print("JSON 인코딩 오류: \(error)")
            completion(error)
        }
    }
    
    //MARK: 지원서 삭제
    
    static func deleteApplication(applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("applications").document(applicationId).delete() { error in
            completion(error)
        }
    }
    
    //MARK: 지원서 가져오기
    
    static func getStudyAllApplications(studyId: String, completion: (@escaping (Result<[Application], Error>) -> Void)) {
        shared.db.collection("applications").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let applications: [Application] = querySnapshot?.documents.compactMap { document in
                do {
                    let data = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    let application = try JSONDecoder().decode(Application.self, from: data)
                    return application
                } catch {
                    print("JSON 변환 오류: \(error)")
                    return nil
                }
            } ?? []
            
            completion(.success(applications))
        }
    }
    
    static func getMyAllApplications(userId: String, completion: (@escaping (Error?) -> Void)) {
        
    }
}

//MARK: Alamofire

//class ApplicationService {
//
//    static let shared = ApplicationService()
//
//    func fetchApplications(completion: @escaping (Result<[Application], Error>) -> Void) {
//        let url = "https://your-api-url.com/applications"
//
//        AF.request(url).responseDecodable(of: [Application].self) { response in
//            switch response.result {
//            case .success(let applications):
//                completion(.success(applications))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    func addApplication(_ application: Application, completion: @escaping (Result<Application, Error>) -> Void) {
//        let url = "https://your-api-url.com/applications"
//
//        AF.request(url, method: .post, parameters: application, encoder: JSONParameterEncoder.default)
//            .responseDecodable(of: Application.self) { response in
//                switch response.result {
//                case .success(let newApplication):
//                    completion(.success(newApplication))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    func updateApplication(_ application: Application, completion: @escaping (Result<Application, Error>) -> Void) {
//        let url = "https://your-api-url.com/applications/\(application.id)"
//
//        AF.request(url, method: .put, parameters: application, encoder: JSONParameterEncoder.default)
//            .responseDecodable(of: Application.self) { response in
//                switch response.result {
//                case .success(let updatedApplication):
//                    completion(.success(updatedApplication))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    func deleteApplication(_ application: Application, completion: @escaping (Result<Void, Error>) -> Void) {
//        let url = "https://your-api-url.com/applications/\(application.id)"
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
