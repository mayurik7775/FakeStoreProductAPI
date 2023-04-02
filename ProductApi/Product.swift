//
//  Product.swift
//  ProductApi
//
//  Created by Mac on 08/03/23.
//

import Foundation
struct Product : Decodable{
    var id : Int
    var title : String
    var image : URL
}
