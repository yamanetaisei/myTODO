//
//  ViewController.swift
//  myTODO
//
//  Created by 山根大生 on 2020/08/27.
//  Copyright © 2020 taisei. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var TODOList: Results<TODOModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        TODOList = realm.objects(TODOModel.self)
        
        textField.placeholder = "TODOを入力してください"
        textField.clearButtonMode = .always
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODOList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deleteTODO(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TODOCell" , for: indexPath)
        let item = TODOList[indexPath.row]
        cell.textLabel!.text = item.TODO
        return cell
    }
    
//    func deleteTODO(at index: Int){
//        let realm = try! Realm()
//        try! realm.write {
//            realm.delete(TODOList[index])
//        }
//
//    }
    @IBAction func addButton(_ sender: Any) {
        let model:TODOModel = TODOModel()
        model.TODO = self.textField.text
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(model)
        }
        self.tableView.reloadData()
        textField.text = ""
    }
}

