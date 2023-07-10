//
//  UserService.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI
import Alamofire

class UserServices  {
    
    static let shared = UserServices()
    
    static func fetchUser(withId id: String, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request("https://your-api-url.com/users/\(id)")
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func addUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request("https://your-api-url.com/users", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func updateUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request("https://your-api-url.com/users/\(user.id)", method: .put, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func deleteUser(withId id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request("https://your-api-url.com/users/\(id)", method: .delete)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func updateJoinedStudys(user: User, studyId: String, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request("https://your-api-url.com/users/\(user.id)", method: .put, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
