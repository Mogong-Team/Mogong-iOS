//
//  ApplicationService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire

class ApplicationService {
    
    static let shared = ApplicationService()
    
    func fetchApplications(completion: @escaping (Result<[Application], Error>) -> Void) {
        let url = "https://your-api-url.com/applications"
        
        AF.request(url).responseDecodable(of: [Application].self) { response in
            switch response.result {
            case .success(let applications):
                completion(.success(applications))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addApplication(_ application: Application, completion: @escaping (Result<Application, Error>) -> Void) {
        let url = "https://your-api-url.com/applications"
        
        AF.request(url, method: .post, parameters: application, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Application.self) { response in
                switch response.result {
                case .success(let newApplication):
                    completion(.success(newApplication))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateApplication(_ application: Application, completion: @escaping (Result<Application, Error>) -> Void) {
        let url = "https://your-api-url.com/applications/\(application.id)"
        
        AF.request(url, method: .put, parameters: application, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Application.self) { response in
                switch response.result {
                case .success(let updatedApplication):
                    completion(.success(updatedApplication))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteApplication(_ application: Application, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://your-api-url.com/applications/\(application.id)"
        
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
