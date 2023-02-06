//
//  UserModel.swift
//  CoreNFCSample

import Foundation
import UIKit


class UsersModel: NSObject {
    var username: String?
    var password: String?
    
    override init() {
        //
    }
    
    init(username: String?, password: String?) {
        self.username = username
        self.password = password
    }
}



