//
//  DemoViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/3.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let tableViewReuseCellID = "DemoListCellID"

    var titles: [String] = {
        return ["GIF", "Web Image"]
    }()
    var classNames: [String] = {
        return ["GifViewController", "WebImageViewController"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewReuseCellID)
    }
}

extension DemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseCellID, for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let className = classNames[indexPath.row]
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
