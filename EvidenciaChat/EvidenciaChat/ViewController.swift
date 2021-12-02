//
//  ViewController.swift
//  EvidenciaChat
//
//  Created by user209408 on 11/30/21.
//

import UIKit
import CometChatPro


class ViewController: UIViewController {
    
    
    @IBOutlet weak var newUsername: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
    }
    func openChat(){
        DispatchQueue.main.async {
        let cometChatUI = CometChatUI()
        cometChatUI.setup(withStyle: .fullScreen)
        self.present(cometChatUI, animated: true, completion: nil)
        }
    }
    
       
        
    @IBAction func register(_ sender: Any) {
        let uid:String = self.newUsername.text!
        
        
        let url = URL(string:"https://198408b9fad322d7.api-us.cometchat.io/v3/users")!
        let payload: [String:Any] = [
            "uid":uid,
            "name":uid
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("b7daffc277e7ad7144a07ba415636aa5be19c073", forHTTPHeaderField: "apiKey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
                request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }.resume()
    }
    
    @IBAction func Login(_ sender: Any) {
        let uid:String = self.username.text!
        let authKey = "b7daffc277e7ad7144a07ba415636aa5be19c073"
        
        
        
        CometChat.login(UID: uid, apiKey: authKey, onSuccess: { (user) in

            self.openChat()
        }) { (error) in

          print("Login failed with error: " + error.errorDescription);

        }
    
    }
}

