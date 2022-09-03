//
//  ViewController.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-08-30.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var makeTextFielf: UITextField!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    var listOfcar = CarListViewModel().ListOfCar
    var expandedIndexPath =  IndexPath(row: 0, section: 0)
   // var selectedIndex = -1
   // var isCollapse = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "CarTableViewCell")
        setupLayout()
    }
    
    private func setupLayout() {
        filterView.layer.cornerRadius = 8
        makeTextFielf.layer.cornerRadius = 5
        modelTextField.layer.cornerRadius = 5
    }
}

//MARK: extension UITableViewDataSource ,UITableViewDelegate
extension CarViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfcar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.generateCell(car: listOfcar[indexPath.row])
        tableView.rowHeight = 370
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if indexPath == expandedIndexPath {
            expandedIndexPath = IndexPath()
        } else {
            expandedIndexPath = indexPath
        }
        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == expandedIndexPath {
            return 370
        }
        return 110
    }
}
