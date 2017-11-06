//
//  ListeMagasinsTableViewController.swift
//  mesCourses
//
//  Created by etudiant on 16/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class ListeMagasinsTableViewController: UITableViewController {

    @IBOutlet weak var vLogo: UIView!

    var listeMagasins: [Magasin]
    {
        return MagasinDao.getListeMagasins()
    }
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = vLogo
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        return listeMagasins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMagasin", for: indexPath)
        cell.accessoryType = .detailDisclosureButton
        // Configure the cell...
        cell.imageView?.image = UIImage(named:"_shops")
        cell.detailTextLabel?.text = listeMagasins[indexPath.row].description
        cell.textLabel?.text = listeMagasins[indexPath.row].nom
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
        let al = alert(titre: "Future", message: "to be determined", boutonTitre: "ok")
        self.present(al, animated: true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            _ = MagasinDao.deleteMagasinById(id: listeMagasins[indexPath.row]._ID)
            tableView.deleteRows(at: [indexPath], with: .fade)

   /*     } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       */
       }
 
    }
   

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
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     if segue.identifier == "detailMagasinSegue"
      {
       if let detailMagasinVc = segue.destination as? DetailMagasinViewController,
            let index = self.tableView.indexPathForSelectedRow
       {
            detailMagasinVc.magasin = listeMagasins[index.row]
       }
      }
     if segue.identifier == "ajoutMagasinSegue"
        {
            if let detailMagasinVc = segue.destination as? DetailMagasinViewController
            {
                detailMagasinVc.magasin = nil
            }
        }
  
    }
    @IBAction func unwindToListeMagasins(segue: UIStoryboardSegue)
    {}
    
}



