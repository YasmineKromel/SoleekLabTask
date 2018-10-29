//
//  CountriesListViewController.swift
//  SoleekLabTask
//
//  Created by mino on 10/28/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

struct country
{
    
    let name: String
    
    init(Name:String ) {
        
        name = Name
        
    }
}


class CountriesListViewController: UITableViewController {
    
    
   
    @IBOutlet var TableOFCountries: UITableView!
    
    var CountriesNamesArray:[String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableOFCountries.dataSource = self
        TableOFCountries.delegate = self
        
        FetchSimpleJson()
        
       // print(CountriesNamesArray.count)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return CountriesNamesArray.count
    }

   
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableOFCountries.dequeueReusableCell(withIdentifier:"CellOfCountry", for: indexPath) as! CountryCell
        
        let country = CountriesNamesArray[indexPath.row] as String
        
        cell.NameOfCountry.text = country        
        
        return cell
    }
 
    func FetchSimpleJson()
    {
        
        let Jsonfile = "https://countryapi.gear.host/v1/Country/getCountries"
        guard let url = URL.init(string: Jsonfile) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let jData = data else{return}
           
            do{
                guard let json = try JSONSerialization.jsonObject(with: jData, options: .mutableContainers) as? NSDictionary else{return}
                
                let jsonResponse = json.value(forKey: "Response") as! NSArray
                
                let CountryName = jsonResponse.value(forKey: "Name") as! NSArray
                
                for i in 0...CountryName.count-1
                {
                    let name = CountryName[i] as! String
                    self.CountriesNamesArray.append(name )
                    
                    
                    
                    
                }
                
                self.TableOFCountries.reloadData()
               // print(self.CountriesNamesArray)
               // print (self.CountriesNamesArray.count)
          
                
            }catch let jsonerr{
                print("Error from parsing :",jsonerr)
            }
            
            }.resume()
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
