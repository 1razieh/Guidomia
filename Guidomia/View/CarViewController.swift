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
    var filteredList = [CarViewModel]()
    var makePickerView = UIPickerView()
    var modelPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "CarTableViewCell")
        setupLayout()
        filteredList = listOfcar
        makeTextFielf.delegate = self
        modelTextField.delegate = self
        
        makePickerView.dataSource = self
        makePickerView.delegate = self
        makePickerView.tag = 1
        makeTextFielf.inputView = makePickerView
        
        modelPickerView.dataSource = self
        modelPickerView.delegate = self
        modelPickerView.tag = 0
        modelTextField.inputView = modelPickerView
    }
    
    private func setupLayout() {
        filterView.layer.cornerRadius = 8
        makeTextFielf.layer.cornerRadius = 5
        modelTextField.layer.cornerRadius = 5
    }
}

//MARK: UITableViewDataSource ,UITableViewDelegate
extension CarViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.generateCell(car: filteredList[indexPath.row])
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

//MARK: UIPickerViewDataSource, UIPickerViewDelegate
extension CarViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        listOfcar.count
    }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return listOfcar[row].make
        } else {
            return listOfcar[row].model
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            makeTextFielf.text = listOfcar[row].make
            makeTextFielf.resignFirstResponder()
        } else {
            modelTextField.text = listOfcar[row].model
            modelTextField.resignFirstResponder()
        }
    }
}

//MARK: UITextFieldDelegate
extension CarViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            filteredList = listOfcar.filter({$0.make == textField.text})
        } else {
            filteredList = listOfcar.filter({$0.model == textField.text})
        }
        tableView.reloadData()
    }
}


