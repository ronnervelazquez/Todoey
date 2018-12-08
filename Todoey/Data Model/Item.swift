//
//  Item.swift
//  Todoey
//
//  Created by Ronner Velazquez on 12/7/18.
//  Copyright © 2018 Ronner Velazquez. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable{
    var title : String = ""
    var done : Bool = false
}
