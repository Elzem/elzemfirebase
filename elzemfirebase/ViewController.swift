//
//  ViewController.swift
//  elzemfirebase
//
//  Created by Elzem on 7.12.2018.
//  Copyright © 2018 Elzem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var adArray: Array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = Database.database().reference()
        databaseRef.child("Kullanici").observe(.value){ (snapshot) in
            let values = snapshot.value! as! NSDictionary
            let gonderi = values["Gonderi"] as! NSDictionary
            let postID = gonderi.allKeys
            print(postID)
            
            for id in postID{
                let post = gonderi[id] as! NSDictionary
                self.adArray.append(post["Ad"] as! String)
            }
            print(self.adArray)
        }
        
        
    }
    
    @IBOutlet weak var mailtext: UITextField!
    @IBOutlet weak var adtext: UITextField!
    @IBOutlet weak var soyadtext: UITextField!
    @IBOutlet weak var dogumyeritext: UITextField!
    @IBOutlet weak var telefontext: UITextField!
    
    
    @IBAction func Oku(_ sender: Any) {
        
    }
    
    @IBAction func kaydet(_ sender: Any) {
        let storageRef = Storage.storage().reference()
        let uuid = NSUUID().uuidString
        
            let databaseRef = Database.database().reference()
            let icerik = ["E-Mail": self.mailtext.text!, "Ad": self.adtext.text, "Soyad": self.soyadtext.text!, "Dogum Yeri": self.dogumyeritext.text!, "Telefon Numarası": self.telefontext.text!, "uuid": uuid] as [String: Any]
            
            databaseRef.child("Kullanici").child("Gonderi").childByAutoId().setValue(icerik)
        
    }
}
