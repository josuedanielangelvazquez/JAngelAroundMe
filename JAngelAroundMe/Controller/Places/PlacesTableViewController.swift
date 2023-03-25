//
//  PlacesTableViewController.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    var categoriename = ""
    let placesviewmodel = PlaceViewModel()
    var places = [results]()
    var idPlace = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PlacesTableViewCell", bundle: .main), forCellReuseIdentifier: "placescell")
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    func uialerterror(){
        let alertfalse = UIAlertController(title: nil, message: "Ocurrio un Erro", preferredStyle: .alert)
        alertfalse.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertfalse, animated: true)
    }
    func loadData(){
        placesviewmodel.getplaces(Categorie: categoriename) { PlacesModel in
            DispatchQueue.main.async { [self] in
                if PlacesModel != nil{
                    places = PlacesModel!.results as [results]
                    tableView.reloadData()
                }
                else{
                    uialerterror()
                }
             
            }
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idPlace = places[indexPath.row].place_id!
        performSegue(withIdentifier: "seguesdetail", sender: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placescell", for: indexPath) as! PlacesTableViewCell
        cell.namelbl.text = places[indexPath.row].name
        cell.Directionlbl.text = places[indexPath.row].formatted_address
        if places[indexPath.row].opening_hours?.open_now == true{
            cell.Openlbl.text = "Open"
        }
        else{
            cell.Openlbl.text = "Close"
        }
        cell.City.text = "Mexico"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesdetail"{
            let detail = segue.destination as! PlaceDetailViewController
            detail.idPlace = idPlace
        }
        if segue.identifier == "seugesmaps"{
            let detail = segue.destination as! LocationViewController
            detail.categoriesname = categoriename
        }
    }
    func loadUbications(){
        performSegue(withIdentifier: "seugesmaps", sender: nil)
    }
    @IBAction func PlacesUbicationAction(_ sender: Any) {
    loadUbications()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
