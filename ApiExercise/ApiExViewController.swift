//
//  ViewController.swift
//  ApiExercise
//
//  Created by Gabriella Gracia MT on 22/12/20.
//

import UIKit

class ApiExViewController: UITableViewController{

    var countryName = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
            print("sukses")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: Get JSON
    func downloadJSON(completed: @escaping() -> ())
    {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")

        URLSession.shared.dataTask(with: url!) {(data, resoponse, error) in
            if error == nil
            {
                do
                {
                    self.countryName = try JSONDecoder().decode([Country].self, from: data!)
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                        for country in self.countryName
                        {
                            print(country.name)
                            print(country.capital)
                            print(country.region)
                            print("")
                        }
                }
                catch
                {
                    print("Error!")
                }
            }
        }.resume()
    }
    
    //MARK: tableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApiExViewCell", for: indexPath) as! CountryCell
       
        //cell.textLabel?.text = countryName[indexPath.row].name
        cell.countryLabel.text = "Name: \(countryName[indexPath.row].name)"
        cell.capitalLabel.text = "Capital: \(countryName[indexPath.row].capital)"
        cell.regionLabel.text = "Region: \(countryName[indexPath.row].region)"

        
        return cell
    }

    //MARK: tableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(countryName[indexPath.row])
        tableView.reloadData()
    }
}


