//
//  TableDataSourceModel.swift
//  Biirr
//
//  Created by Ana Márquez on 06/03/2021.
//

import UIKit

///Control dataSource and delegate of a table that handle data of type  GenericDataSource<Beer>
class TableDataSourceModel: GenericDataSource<Beer>, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count + (moreDataAvailable.value ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == data.value.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreBeerCell", for: indexPath) as? MoreBeerTableViewCell else { return UITableViewCell() }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
        cell.beer = data.value[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == data.value.count {
            selectedData.value = Beer.empty
        } else {
            selectedData.value = data.value[indexPath.row]
        }
    }
}
