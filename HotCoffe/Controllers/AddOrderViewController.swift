//
//  AddOrderTableViewController.swift
//  HotCoffe
//
//  Created by Guilherme Berson on 08/10/21.
//

import Foundation
import UIKit

protocol AddCoffeOrderDelegate {
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController : UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var delegate: AddCoffeOrderDelegate?
    
    private var vm = AddCoffeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    private var coffeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI(){
        self.coffeSegmentedControl = UISegmentedControl(items: self.vm.size)
        self.coffeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.coffeSegmentedControl)
        
        self.coffeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.vm.type[indexPath.row]
        return cell
    }
    
    
    @IBAction func close(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.addCoffeOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeSegmentedControl.titleForSegment(at: self.coffeSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selected Coffe")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.type[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
                print(order)
            case .failure(let error):
                print(error)
            }
        }
    }
}
