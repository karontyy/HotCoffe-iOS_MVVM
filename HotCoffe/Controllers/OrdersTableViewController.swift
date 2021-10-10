//
//  OrdersTableViewController.swift
//  HotCoffe
//
//  Created by Guilherme Berson on 08/10/21.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeOrderDelegate  {
    var orderListViewModel = OrderListVierModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrder()
    }
    
    //MARK: - ADDCoffeOrderDelegate functions
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderVierModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addCoffeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Normal Functions
    private func populateOrder(){
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel =
                    orders.map(OrderVierModel.init)
                self?.tableView.reloadData()
            case .failure(let errors):
                print(errors)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
        let addCoffeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
            fatalError("error performing segue")
        }
        addCoffeOrderVC.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListViewModel.oderViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewModel", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text  = vm.size
        
        return cell
    }
    
}
