//
//  HomeViewController.swift
//  TestQiuShiBiK
//
//  Created by tianao on 2021/1/25.
//

import UIKit


class HomeViewController: UIViewController {
   
    lazy var tableView: UITableView = UITableView()
    lazy var items = [Item]()
    var page = 0
    static let itemID = "Itme"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Self.itemID)
        view.addSubview(tableView)
        let header = MJRefreshNormalHeader(refreshingBlock: self.loadNewdata)
        header.beginRefreshing()
        tableView.mj_header = header
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: self.loadMoreData)
    }
    
    
    //MARK: - 数据加载
    func loadNewdata() {
        AF.request(API.imageRank, parameters: ["page": 1]).responseJSON {
            [weak self] response in
            guard let dict = response.value else {return}
            let jsons = JSON(dict)["items"].arrayObject
            guard let modes =  jsons?.kj.modelArray(Item.self) else {return}
            self?.items.removeAll()
            self?.items.append(contentsOf: modes)
            self?.tableView.reloadData()
            self?.tableView.mj_header?.endRefreshing()
            self?.page = 1
        }
    }
    
    func  loadMoreData(){
        AF.request(API.imageRank, parameters: ["page": page + 1]).responseJSON {
            [weak self] response in
            guard let dict = response.value else {return}
            let jsons = JSON(dict)["items"].arrayObject
            guard let modes =  jsons?.kj.modelArray(Item.self) else {return}
            self?.items.append(contentsOf: modes)
            self?.tableView.reloadData()
            self?.tableView.mj_footer?.endRefreshing()
            self?.page += 1
        }
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer?.isHidden = items.count == 0
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{        
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.itemID, for: indexPath) as! HomeTableViewCell
        
        let model = items[indexPath.row]
        cell.contentLab.text = model.user.name
        let url = model.user.thumb.replacingOccurrences(of: ".webp", with: ".png")
        cell.homeImageView.kf.setImage(with: URL(string:url))

        return cell
    }
}
