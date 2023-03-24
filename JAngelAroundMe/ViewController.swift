//
//  ViewController.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import UIKit
import SwipeCellKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    @IBOutlet weak var tableCategories: UITableView!
    var categorieViewmodel = CategoriesViewModel()
    var categories = [Categories]()
    var nameCategorie = ""
    var idcategoria = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCategories.delegate = self
        tableCategories.dataSource = self
        view.addSubview(tableCategories)
        tableCategories.register(UINib(nibName: "CategoriesTableViewCell", bundle: .main), forCellReuseIdentifier: "categoriescell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func loadData(){
        let result = categorieViewmodel.getCategories()
        if result.Correct == true{
            categories = result.Objects! as! [Categories]
            tableCategories.reloadData()
        }
        else
        {
            loadmessageerror()
        }
    }
    func loadmessageerror(){
        let alertfalse = UIAlertController(title: "Error", message: "Ocurrio un Error", preferredStyle: .alert)
        alertfalse.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertfalse, animated: true)
    }
    func loadmessageCorrect(){
        let alertCorrect = UIAlertController(title: "Correct", message: "Se Agrego Correctamente", preferredStyle: .alert)
        alertCorrect.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertCorrect, animated: true)
    }
    func loadmessage(){
        
        let alertsheet = UIAlertController(title: nil, message: "Select Option", preferredStyle: .actionSheet)
        alertsheet.addAction(UIAlertAction(title: "Add Categorie", style: .default){action in
            let alertaddcategorie = UIAlertController(title: nil, message: "Add Categorie", preferredStyle: .alert)
            alertaddcategorie.addTextField()
            alertaddcategorie.addAction(UIAlertAction(title: "Add", style: .default){ [self]action in
                let categorie = alertaddcategorie.textFields![0]
                let result = categorieViewmodel.addCategories(categorie: categorie.text!)
                if result.Correct == true{
                    viewWillAppear(true)
                    loadmessageCorrect()
                }
                else{
                    loadmessageerror()
                }
            })
            self.present(alertaddcategorie, animated: true)
        })
        alertsheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        self.present(alertsheet, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriescell", for: indexPath as IndexPath) as! CategoriesTableViewCell
        cell.delegate = self
        cell.categorylbl.text = categories[indexPath.row].nameCategorie
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       nameCategorie = categories[indexPath.row].nameCategorie
        performSegue(withIdentifier: "seguesplaces", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesplaces"{
            let detail = segue.destination as! PlacesTableViewController
            detail.categoriename = nameCategorie
        }
    }
    @IBAction func ConfigAction(_ sender: Any) {
        loadmessage()
    }
    
    
}
extension ViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self]
            action, indexPath in
            
            self.idcategoria = indexPath.row
            
            let result = self.categorieViewmodel.Delete(idCategorie: idcategoria)
            if result.Correct!{
                viewWillAppear(true)
                let alert = UIAlertController(title: "oK", message: "El producto se elimino correctamente", preferredStyle: .alert)
                let Ok = UIAlertAction(title: "oK", style: .default)
                alert.addAction(Ok)
                self.present(alert, animated: true)
                
            }
            else{
                let alert = UIAlertController(title: "Alerta", message: "Ocurrio un Error", preferredStyle: .alert)
                let Ok = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(Ok)
                self.present(alert, animated: true)
            }
        }
            deleteAction.image = UIImage(systemName: "trash")
            return [deleteAction]
        }
        
        
    }

