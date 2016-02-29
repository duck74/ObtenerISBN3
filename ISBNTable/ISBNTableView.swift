//
//  ISBNTableView.swift
//  ISBNTable
//
//  Created by Koss on 29/02/16.
//  Copyright © 2016 mine. All rights reserved.
//

import UIKit

struct Libro {
    var isbn: String
    var titulo: String
    var autor: String
    //var portada: String
    var portadaImagenURL: String
    init(isbn: String, titulo:String, autor: String, portadaImagenURL: String){
        self.isbn = isbn
        self.titulo = titulo
        self.autor = autor
        //self.portada = portada
        self.portadaImagenURL = portadaImagenURL
    }
    
}


class ISBNTableView: UITableViewController {

    var recISBN:String?
    var resultado:[NSString] = [NSString]()
    var portadaImageURL: String = ""
    var libros = [Libro]()
    //var titulos: [String] = [String]()
    var error = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        if error {
            showAlert()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       print(self.libros.count)
        return self.libros.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = libros[indexPath.row].titulo
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "libroDetalles" {
        let verDetalles = segue.destinationViewController as! VerDetalles
        let selLibro = self.tableView.indexPathForSelectedRow
        
        verDetalles.libroTitulo = self.libros[selLibro!.row].titulo
        
        let isbn = NSMutableString(string: recISBN!)
        verDetalles.isbn = (crearISBNString(isbn))
        verDetalles.autor = self.libros[selLibro!.row].autor
        verDetalles.portada = self.libros[selLibro!.row].portadaImagenURL
        }
    }
    
    
    @IBAction func entrarISBNView(segue: UIStoryboardSegue) {
        if let isbnViewController = segue.sourceViewController as? EntrarISBN {
            //let isbn = NSMutableString(string: isbnViewController.ISBNbuscar!)
            //let isbnString = (crearISBNString(isbn))
           // verISBN.text = isbnString
            //verISBN.text = isbnViewController.ISBNbuscar
            recISBN = isbnViewController.ISBNbuscar
            //verResultado.text = String(recibirJSON())
            //acceder los avlores de JSON
            resultado = recibirJSON()
            }
            if resultado.count < 4 {
                error = true
            }
            else {
            let libro = Libro(isbn: resultado[0] as String, titulo: resultado[1] as String, autor: resultado[2] as String, portadaImagenURL: resultado[3] as String)
                print(libro)
                libros.insert(libro, atIndex: 0)
                error = false
            
            }
            self.tableView!.reloadData()
        
    }

    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "Error", message: resultado[0] as String, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.view.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func recibirJSON() -> [NSString]{
        let isbn = NSMutableString(string: recISBN!)
        let isbnString = (crearISBNString(isbn))
        //cuando puede test, usa este variable
        //let x = "978-84-376-0494-7"
        //let y = "978-08-125-0356-2"
        var test:NSString?
        var textField:[NSString] = []
        
        let urlPath:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        guard let endpoint = NSURL(string: urlPath as String + isbnString) else { print("Error creating endpoint");return ["error"]}
        print(endpoint)
        let datos:NSData? = NSData(contentsOfURL: endpoint)
        //test = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        if datos?.length > 2 {
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dico1 = json as! NSDictionary
                
                let dico2 = dico1["ISBN:"+isbnString] as! NSDictionary
                textField.append(isbnString)
                textField.append(String(dico2["title"]!))
                textField.append(String((dico2["authors"]![0]!["name"]!)!))
                //textField = (textField as String) + "Titulo: " + String(dico2["title"]!) + "\n" + "Autor(es): " + String((dico2["authors"]![0]!["name"]!)!) + "\n"
                
                //libros. = String(dico2["title"]!) //.append(String(dico2["title"]!))
                //print(titulos)
                if dico2["cover"] == nil {
                    textField.append("Libro no hay una portada")
                    //textField =  (textField as String) + "\nLibro no hay una portada"
                    //portadaTitulo.hidden = true
                    //portadaView.image = nil
                }
                else
                {
                    let url = String((dico2["cover"]!["medium"]!)!)
                        //portadaImage = UIImage(data: data)
                        textField.append(String(url))
                        print(url)
                        //portadaTitulo.hidden = false
                        //self.portadaView.image = portadaImage
                    
                    //textField.append("Portada")
                    //textField = (textField as String) //+ "\nPortada" + String((dico2["cover"]!["medium"]!)!)
                }
                
            }
            catch _ {
                
            }
        }
        else
        {
            print(test)
            test = "error"
        }
        
        if  (datos == nil){
            return ["Hay un problema con los datos o el coneccion."]
        }
        else if test == "error" {
            return ["No encontró un libro con este ISBN"]
        }
        else {
            return textField
        }
    }
    
    
    func crearISBNString(isbn: NSMutableString) -> String{
        isbn.insertString("-", atIndex: 3)
        isbn.insertString("-", atIndex: 6)
        isbn.insertString("-", atIndex: 10)
        isbn.insertString("-", atIndex: 15)
        //print(isbn)
        return String(isbn)
    }

}
