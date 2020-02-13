//
//  APIData.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import Foundation
import Firebase

class APIData {
    var ref: DatabaseReference!
    
    typealias completionHandler = (DataSnapshot) -> Void
    
    private func CallFireAPI(completion:@escaping completionHandler) {
        ref = Database.database().reference()
        
        self.ref.child("spaces").observe(.value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    public func getSiloFirebaseData(completion:@escaping completionHandler){
        
        CallFireAPI(completion: completion)
    }
}
