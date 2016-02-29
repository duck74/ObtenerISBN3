//
//  EntrarISBN.swift
//  ISBNTable
//
//  Created by Koss on 29/02/16.
//  Copyright © 2016 mine. All rights reserved.
//

import UIKit

class EntrarISBN: UIViewController, UITextFieldDelegate {
    
    var ISBNbuscar: String?
    var longitud: Int?
    
    @IBOutlet weak var buscarButton: UIButton!
    @IBOutlet weak var entrarISBNText: UITextField!
    
    @IBAction func buscarISBN(sender: AnyObject) {
        
        ISBNbuscar = entrarISBNText.text
        //print(longitud)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        entrarISBNText.becomeFirstResponder()
        initializeTextField()
        buscarButton.enabled = false
        buscarButton.alpha = 0.50
        
    }
    
    func initializeTextField(){
        entrarISBNText.delegate = self
        entrarISBNText.keyboardType = UIKeyboardType.NumberPad
        //entrarISBNText.text = "9788437604947"
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentText = entrarISBNText.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        longitud = prospectiveText.characters.count
        //print(longitud)
        if longitud >= 13 {
            buscarButton.enabled = true
            buscarButton.alpha = 1
        }
        else {
            buscarButton.enabled = false
            buscarButton.alpha = 0.50
        }
        return prospectiveText.characters.count <= 13
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //segue for going back ti main view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveISBN" {
            //ISBNbuscar = entrarISBNText.text
            
        }
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    /*
    let alert = UIAlertView()
    alert.title = "No Text"
    alert.message = "Please Enter Text In The Box"
    alert.addButtonWithTitle("Ok")
    alert.show()
    */
    
}
