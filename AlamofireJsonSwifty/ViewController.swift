//
//  ViewController.swift
//  AlamofireJsonSwifty
//
//  Created by 정재훈 on 06/10/2019.
//  Copyright © 2019 Jung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var buttonGet: UIButton!
    @IBOutlet var buttonPost: UIButton!
    @IBOutlet var buttonPatch: UIButton!
    @IBOutlet var buttonPut: UIButton!
    @IBOutlet var buttonDelete: UIButton!
    @IBOutlet var labelHost: UILabel!
    @IBOutlet var labelUserAgent: UILabel!
    @IBOutlet var labelUrl: UILabel!

    let url: String = "https://httpbin.org/"
    let buttonStackView: UIStackView = UIStackView()
    let labelStackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setButtonStackView()
        setLabelStackView()
    }
    
    @IBAction func touchUpInsideGet(_ sender: UIButton) {
        setButtonTitleColor(sender: buttonGet)
        alamofireRequest(urlQuery: "Get", httpMethod: .get)
    }
    
    @IBAction func touchUpInsidePost(_ sender: UIButton) {
        setButtonTitleColor(sender: buttonPost)
        alamofireRequest(urlQuery: "Post", httpMethod: .post)
    }
    
    @IBAction func touchUpInsidePatch(_ sender: UIButton) {
        setButtonTitleColor(sender: buttonPatch)
        alamofireRequest(urlQuery: "Patch", httpMethod: .patch)
    }
    
    @IBAction func touchUpInsidePut(_ sender: UIButton) {
        setButtonTitleColor(sender: buttonPut)
        alamofireRequest(urlQuery: "Put", httpMethod: .put)
    }
    
    @IBAction func touchUpInsideDelete(_ sender: UIButton) {
        setButtonTitleColor(sender: buttonDelete)
        alamofireRequest(urlQuery: "Delete", httpMethod: .delete)
    }
    

    func alamofireRequest(urlQuery: String ,httpMethod: HTTPMethod) {
        
        self.alertActionController(kindOfMethod: urlQuery)
        
        AF.request(url+urlQuery.lowercased(), method: httpMethod).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.labelHost.text = json["headers"]["Host"].stringValue
                self.labelUrl.text = json["url"].stringValue
                self.labelUserAgent.text = json["headers"]["User-Agent"].stringValue

            case .failure(let error):
                print(error)
                self.alertActionController()
            }
        }
    }
    
    func alertActionController(kindOfMethod: String = "Error") {
        
        var alertMessage: String?
        
        if kindOfMethod == "Error" {
            alertMessage = kindOfMethod
        } else {
            alertMessage = kindOfMethod + " Method is working"
        }
        
        let alertController: UIAlertController = UIAlertController(title: "Pleas Wait", message: alertMessage, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setButtonStackView() {
        view.addSubview(buttonStackView)
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.addArrangedSubview(buttonGet)
        buttonStackView.addArrangedSubview(buttonPost)
        buttonStackView.addArrangedSubview(buttonPatch)
        buttonStackView.addArrangedSubview(buttonPut)
        buttonStackView.addArrangedSubview(buttonDelete)

        buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
    }
    
    func setLabelStackView() {
        view.addSubview(labelStackView)
        
        labelStackView.axis = .vertical
        // labelStackView.distribution = .fillEqually
        labelStackView.alignment = .leading
        labelStackView.spacing = 5.0
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        labelStackView.addArrangedSubview(labelHost)
        labelStackView.addArrangedSubview(labelUrl)
        labelStackView.addArrangedSubview(labelUserAgent)

        labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        labelStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 15.0).isActive = true
    }
    
    func setButtonTitleColor(sender button: UIButton) {
        buttonGet.setTitleColor(.systemBlue, for: .init())
        buttonPost.setTitleColor(.systemBlue, for: .init())
        buttonPatch.setTitleColor(.systemBlue, for: .init())
        buttonPut.setTitleColor(.systemBlue, for: .init())
        buttonDelete.setTitleColor(.systemBlue, for: .init())
        
        button.setTitleColor(.red, for: .init())
    }
}
