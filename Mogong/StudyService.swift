//
//  StudyService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire

class StudyService {
    
    static let shared = StudyService()
    
    func fetchStudys(completion: @escaping (Result<[Study], Error>) -> Void) {
        let url = "https://your-api-url.com/studys"
        
        AF.request(url).responseDecodable(of: [Study].self) { response in
            switch response.result {
            case .success(let study):
                completion(.success(study))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addStudy(_ study: Study, completion: @escaping (Result<Study, Error>) -> Void) {
        let url = "https://your-api-url.com/studys"
        
        AF.request(url, method: .post, parameters: study, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Study.self) { response in
                switch response.result {
                case .success(let newApplication):
                    completion(.success(newApplication))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateStudy(_ study: Study, completion: @escaping (Result<Study, Error>) -> Void) {
        let url = "https://your-api-url.com/studys/\(study.id)"
        
        AF.request(url, method: .put, parameters: study, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Study.self) { response in
                switch response.result {
                case .success(let updatedStudy):
                    completion(.success(updatedStudy))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteStudy(_ study: Study, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://your-api-url.com/studys/\(study.id)"
        
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
