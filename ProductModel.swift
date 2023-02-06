//
//  ProductModel.swift
//  CoreNFCSample

import Foundation
import UIKit

class ProductModel: NSObject {
    //propertites
    var productId: String?
    var productName: String?
    var productBrand: String?
    var productCategory: String?
    var productColor: String?
    var productPrice: String?
    
    override init() {
        //
    }
    
    init(productId: String?, productName: String?, productBrand: String?, productCategory: String?, productColor: String?, productPrice: String?) {
        self.productId = productId
        self.productName = productName
        self.productBrand = productBrand
        self.productCategory = productCategory
        self.productColor = productColor
        self.productPrice = productPrice
    }
    
}
