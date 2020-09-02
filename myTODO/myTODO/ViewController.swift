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
    
    let realm = try! Realm()
    var todoList = [TODOModel]()
    
    var item = TODOModel?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        todoList = realm.objects(TODOModel.self).map( {$0} )
        
        textField.placeholder = "TODOを入力してください"
        textField.clearButtonMode = .always
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TODOCell" , for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row].todo
        return cell
    }
    
    @IBAction func addButton(_ sender: Any) {
        if let text = textField.text, !text.isEmpty {
            realm.beginWrite()
            
            let newItem = TODOModel()
            newItem.todo = text
            realm.add(newItem)
            try! realm.commitWrite()
            
            textField.text = ""
            refresh()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let delItem = todoList[indexPath.row]
            
            realm.beginWrite()
            realm.delete(delItem)
            try! realm.commitWrite()
            refresh()
            
        }
    }
    
    func refresh() {
        todoList = realm.objects(TODOModel.self).map({ $0 })
        tableView.reloadData()
    }
}

