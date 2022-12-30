//
//  CustomTableViewController.swift
//  APINetworking
//
//  Created by Consultant on 12/29/22.
//

import UIKit

class CustomTableViewController: UITableViewController {

    var networkingModel = NetworkingModel()
    var films:Films!
    let userDefaults = UserDefaults.standard
    var selected = 0
    var isSelected = false
    var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let ud = self.userDefaults.object(forKey: "selectedFilm") as? Film
        
        self.networkingModel.loadData(fileName: "https://swapi.dev/api/films") { films in
            DispatchQueue.main.async {
                //self.userDefaults.set(films.all[0], forKey: "selectedFilm")
                self.films = films
                //self.userDefaults.set(self.films.all[0], forKey: "selectedFilm")
                //print("Films: \(self.films)")
                self.isLoaded = true
                self.tableView.reloadData()
                
            }
        }
        
        
    }
    
    func reloadSelection() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if isLoaded {
                return self.films.count
            } else {
                return 2
            }
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        if indexPath.section == 0 {
            
            if let film = self.getDefault() {
                print("Setting Title: \(film.title)")
                cell.titleLabel.text = film.title
            }
            //self.isSelected = false
            return cell
        } else {
                //print("Setting Title: \(film.title)")
            let film = self.films?.all[indexPath.row]
            cell.titleLabel.text = film?.title
            //cell.titleLabel.text = self.films?.all[indexPath.row].title
            
            self.setDefaults(film: film ?? Film(id: 0, title: "", openingCrawl: "", director: "", producer: "", releaseDate: "", starships: ["",""]))
            let savedFilm = self.getDefault()
            print("Saved Film: \(savedFilm)")
            self.isSelected = false
            return cell
        }
        
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelected = true
        if indexPath.section != 0 {
            let selectedFilm = self.films.all[indexPath.row]
            //print("Selected: \(selectedFilm)")
            self.setDefaults(film: selectedFilm)
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        self.isSelected = false
    }
    
    func getDefault() -> Film? {
        // Retrieve from UserDefaults
        if let data = self.userDefaults.object(forKey: "selectedFilm"),
           let film = try? JSONDecoder().decode(Film.self, from: data as! Data) {
            //
            let filmObject = film
            return filmObject
        }
        return nil
    }
    
    func setDefaults(film: Film) {
        // To store in UserDefaults
        //print("Film: \(film)")
        if let encoded = try? JSONEncoder().encode(film) {
            //print("Encoded: \(encoded)")
            self.userDefaults.set(encoded, forKey: "selectedFilm")
            let udef = self.userDefaults.object(forKey: "selectedFilm")
            //print("Selected User Default: \(udef)")
            
        }
        
        
        
        
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
