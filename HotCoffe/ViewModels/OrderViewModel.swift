//
//  OrderViewModel.swift
//  HotCoffe
//
//  Created by Guilherme Berson on 09/10/21.
//

import Foundation

//MARK: - VIEWMODEL DE LIST ORDER
struct OrderListVierModel {
    var ordersViewModel: [OrderVierModel]
    
    init() {
        self.ordersViewModel = [OrderVierModel]()
    }
}

extension OrderListVierModel {
    func oderViewModel(at index: Int) -> OrderVierModel {
        return self.ordersViewModel[index]
    }
}


//MARK: - VIEWMODEL DE ORDER
struct OrderVierModel {
    let order: Order
}

extension OrderVierModel {
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
}
