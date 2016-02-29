//
//  VerDetalles.swift
//  ISBNTable
//
//  Created by Koss on 29/02/16.
//  Copyright © 2016 mine. All rights reserved.
//

import UIKit

class VerDetalles: UIViewController {
    
    var libroTitulo = ""
    var isbn = ""
    var portada = ""
    var autor = ""
    var portadaImage:UIImage?
    
    @IBOutlet weak var noPortada: UILabel!
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var autores: UILabel!
    
    @IBOutlet weak var portadaImagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = isbn
        titulo.text = libroTitulo
        autores.text = autor
        
        noPortada.hidden = true
        portadaImagen.hidden = true
        
        if portada == "Libro no hay una portada" {
            noPortada.hidden = false
            noPortada.text = portada
        }
        else {
            if let url = NSURL(string: portada), data = NSData(contentsOfURL: url) {
                portadaImagen.hidden = false
                portadaImage = UIImage(data: data)
                self.portadaImagen.image = portadaImage
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
