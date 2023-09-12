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
    
    //MARK: 지원서 가져오기
    
    static func getStudyAllApplications(study: Study, completion: (@escaping (Result<[Application], Error>) -> Void)) {
        
        let submittedApplications = study.submittedApplications
        
        let group = DispatchGroup()
        var applications: [Application] = []

        for applicationId in submittedApplications {
            group.enter()
            shared.db.collection("applications").document(applicationId).getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                do {
                    guard let data = snapshot?.data() else { return }
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let application = try JSONDecoder().decode(Application.self, from: jsonData)
                    applications.append(application)
                } catch let error {
                    completion(.failure(error))
                }
                
                group.leave()
            }
        }

        // 모든 네트워크 요청이 완료되면, completion 호출
        group.notify(queue: .main) {
            completion(.success(applications))
        }
    }
    
    //MARK: 지원서 삭제
    
    static func deleteApplication(applicationId: String, completion: @escaping (Error?) -> Void) {
        shared.db.collection("applications").document(applicationId).delete() { error in
            completion(error)
        }
    }
        
    //MARK: 지원서 업데이트
    
    static func updateApplication(application: Application, completion: (@escaping (Error?) -> Void)) {
        do {
            let jsonData = try JSONEncoder().encode(application)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("데이터 변환 실패")
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "데이터 변환 실패"]))
                return
            }

            shared.db.collection("applications").document(application.id).updateData(json) { error in
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
