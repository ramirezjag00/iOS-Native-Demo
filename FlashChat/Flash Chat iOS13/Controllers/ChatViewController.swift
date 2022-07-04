//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        messageTextfield.delegate = self
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField, descending: false)
            .addSnapshotListener { querySnapShot, error in

            if let e = error {
                print("Error getting collection, \(e)")
            } else {
                if let snapshotDocuments = querySnapShot?.documents {
                    self.messages = []
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                        }
                    }

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        // scroll to latest message
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName)
                .addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970
                ]) { (error) in

                if let e = error {
                    print("There was an issue saving data to fireStore, \(e)")
                } else {
                    self.messageTextfield.text?.removeAll()
                }
            }
        }
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    // trigger if return key in keyboard is tapped
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            messageTextfield.endEditing(true)
            return true
        }
        
        // will trigger for all text fields in this view controller
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            // user is typing and already has value
            if messageTextfield.text != "" {
                return true
            } else {
                // user tapped into text field but no value yet
                messageTextfield.placeholder = "Type something"
                return false
            }
        }
        
        // will trigger once a text field is done editting
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(K.FStore.collectionName)
                    .addDocument(data: [
                        K.FStore.senderField: messageSender,
                        K.FStore.bodyField: messageBody,
                        K.FStore.dateField: Date().timeIntervalSince1970
                    ]) { (error) in

                    if let e = error {
                        print("There was an issue saving data to fireStore, \(e)")
                    } else {
                        self.messageTextfield.text?.removeAll()
                    }
                }
            }
        }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.label?.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
}
