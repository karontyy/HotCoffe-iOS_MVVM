//
//  AddCoffeOrderViewModel.swift
//  HotCoffe
//
//  Created by Guilherme Berson on 10/10/21.
//

import Foundation

struct AddCoffeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var type: [String] {
        return CoffeType.allCases.map{ $0.rawValue.capitalized }
    }
    
    var size: [String] {
        return CoffeSize.allCases.map{ $0.rawValue.capitalized }
    }
}
