//
//  DemoViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/3.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import MJScanner

class DemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let tableViewReuseCellID = "DemoListCellID"

    var titles: [String] = {
        return ["GIF", "QRCode Scan", "Moody", "Web View", "Attributed String", "Pull to Refresh", "Scroll Number Label"]
    }()
    var classNames: [String] = {
        return ["GifViewController",
                "QRCodeScanViewController",
                "MoodsRootViewController",
                "MJWebViewController",
                "AttributedStringViewController",
                "PullToRefreshViewController",
                "ScrollNumberViewController"]
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
        if viewController is ManagedObjectContextSettable {
            let vc = viewController as! ManagedObjectContextSettable
            vc.managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
