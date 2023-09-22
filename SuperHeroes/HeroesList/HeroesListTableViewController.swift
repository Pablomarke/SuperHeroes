//
//  HeroesListTableViewController.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 6/9/23.
//

import UIKit

class HeroesListTableViewController: UITableViewController {
   
    // MARK: - Outlets
    @IBOutlet var HeroesListTable: UITableView!
    
    var model: [Hero]
    
    init(model: [Hero]) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heroes"
        HeroesListTable.rowHeight = 120
        HeroesListTable.register(UINib(
            nibName: HeroesCustomTableViewCell.identifier,
            bundle: nil),
                                 forCellReuseIdentifier: "HeroesCell"
        )
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return model.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "HeroesCell",
            for: indexPath) as? HeroesCustomTableViewCell else {
            return UITableViewCell()
        }
        let myHero = model[indexPath.row]
        cell.configure(with: myHero)
        return cell
    }
   
    // MARK: - Navigation
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) 
    {
        let detail = HeroesDetailViewController()
        self.navigationController?.show(detail, sender: true)
    }
}
