//
//  Contact.swift
//  StretchHeader
//
//  Created by Mike Saradeth on 5/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation

struct Contact: Codable {
    var firstName: String
    var lastName: String
    var fullName: String {
        return "Section: \(firstName)  Row: \(lastName)"
    }
    
    static func load() -> [Contact] {
        var arr = [Contact]()
        for ii in 0..<10 {
            let contact = Contact(firstName: "0", lastName: "\(ii)")
            arr.append(contact)
        }
        return arr
    }
}

extension Array where Element == [Contact] {
    func save() {
        print(self)
    
        do {
            let coder = JSONEncoder()
            let data = try? coder.encode(self)
            try data?.write(to: getURL(), options: .atomic)
        }catch {
            print(error.localizedDescription)
        }

    }
    
    func getURL() -> URL {
        var url: URL
        let documentUrl = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).first!
        
        let fileWithPath = FileManager.default.url(for: <#T##FileManager.SearchPathDirectory#>, in: <#T##FileManager.SearchPathDomainMask#>, appropriateFor: <#T##URL?#>, create: <#T##Bool#>)
        
        return url
    }
}


