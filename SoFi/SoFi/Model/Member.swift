//
//  Member.swift
//  SoFi
//
//  Created by Riley Hooper on 4/6/18.
//  Copyright © 2018 Riley Hooper. All rights reserved.
//

import Foundation

struct Member: Codable {
    let avatar: String? // URL to picture
    let bio: String?
    let firstName: String?
    let id: Int?
    let lastName: String?
    let title: String?
}
