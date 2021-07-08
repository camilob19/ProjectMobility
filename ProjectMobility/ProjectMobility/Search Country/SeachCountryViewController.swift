//
//  SeachCountryViewController.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import UIKit
import CoreLocation

class SeachCountryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedPosition: CLLocationCoordinate2D?
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9529411765, blue: 0.9882352941, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        let infoCountryCellNib = UINib(nibName: String(describing: InfoCountryTableViewCell.self),
                                       bundle: nil)
        tableView.register(infoCountryCellNib,
                           forCellReuseIdentifier: String(describing: InfoCountryTableViewCell.self))
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        searchBar.delegate = self
        
        viewModel.didUpdateModels = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.getCountriesInformation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MapCountryViewController {
            controller.position = selectedPosition
        }
    }
    
}

extension SeachCountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countrylatlng = viewModel.filteredModels[indexPath.row].latlng
        guard !countrylatlng.isEmpty else { return }
        selectedPosition = CLLocationCoordinate2D(latitude: countrylatlng[0], longitude: countrylatlng[1])
        performSegue(withIdentifier: "mapView", sender: nil)
    }
}

extension SeachCountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoCountryTableViewCell.self)) as? InfoCountryTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.config(country: viewModel.filteredModels[indexPath.row])
        return cell
    }
}

extension SeachCountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(using: searchText)
    }
}
