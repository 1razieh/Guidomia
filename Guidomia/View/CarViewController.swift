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
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    
    private var listOfcar = CarListViewModel().ListOfCar
    private var expandedIndexPath =  IndexPath(row: 0, section: 0)
    private var filteredList = [CarViewModel]()
    private let makePickerView = UIPickerView()
    private let modelPickerView = UIPickerView()
    private var pickerSource = [CarViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.setupLayout()
        self.setupPickerSource()
        self.filteredList = self.listOfcar
    }
    
    private func setupPickerSource() {
        self.pickerSource = self.listOfcar
        pickerSource.insert((CarViewModel(car: Car(consList: [""], customerPrice: 0.0, make: makeTextField.placeholder ?? "", marketPrice: 0.0, model: modelTextField.placeholder ?? "", prosList: [""], rating: 0))),
                            at: 0)
    }
    
    private func configure() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "CarTableViewCell")
        self.makeTextField.delegate = self
        self.modelTextField.delegate = self
        
        self.makePickerView.dataSource = self
        self.makePickerView.delegate = self
        self.makePickerView.tag = 1
        self.makeTextField.inputView = self.makePickerView
        
        self.modelPickerView.dataSource = self
        self.modelPickerView.delegate = self
        self.modelPickerView.tag = 0
        self.modelTextField.inputView = modelPickerView
    }
    
    private func setupLayout() {
        self.filterView.layer.cornerRadius = 8
        self.makeTextField.layer.cornerRadius = 5
        self.modelTextField.layer.cornerRadius = 5
    }
}

//MARK: UITableViewDataSource ,UITableViewDelegate
extension CarViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.generateCell(car: filteredList[indexPath.row])
        tableView.rowHeight = expandedRowHeight
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if indexPath == self.expandedIndexPath {
            self.expandedIndexPath = IndexPath()
        } else {
            self.expandedIndexPath = indexPath
        }
        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == expandedIndexPath {
            return expandedRowHeight
        }
        return defaultRowHeight
    }
}

//MARK: UIPickerViewDataSource, UIPickerViewDelegate
extension CarViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerSource.count
    }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return self.pickerSource[row].make
        default:
            return self.pickerSource[row].model
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            self.makeTextField.text = self.pickerSource[row].make
            self.makeTextField.resignFirstResponder()
        default:
            self.modelTextField.text = pickerSource[row].model
            self.modelTextField.resignFirstResponder()
        }
    }
}

//MARK: UITextFieldDelegate
extension CarViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            self.filteredList = self.listOfcar.filter({$0.make == textField.text})
        default:
            self.filteredList = self.listOfcar.filter({$0.model == textField.text})
        }
        
        if self.filteredList.count == 0 {
            self.filteredList = self.listOfcar
        }
        self.tableView.reloadData()
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            self.modelTextField.text = ""
        } else {
            self.makeTextField.text = ""
        }
        
    }
}


