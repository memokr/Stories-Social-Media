//
//  ContentViewModel.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 16/11/23.
//

import Foundation
import Firebase
import Combine


@MainActor
class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSuscribers()
    }
    
    func setupSuscribers(){
        service.$userSession.sink {[weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink {[weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
