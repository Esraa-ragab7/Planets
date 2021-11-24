//
//  PlanetsTableViewController.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import UIKit

class PlantesTableViewController: UITableViewController, PlanetsView {
    var configurator = PlanetsConfiguratorImplementation()
    var presenter: PlanetsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(plantesTableViewController: self)
        presenter.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPlanets
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell", for: indexPath) as! PlanetTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    // MARK: - PlanetsView
    
    func refreshPlanetsView() {
        tableView.reloadData()
    }
    
    func displayPlanetsRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
}
