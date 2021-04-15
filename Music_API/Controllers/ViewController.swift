//
//  ViewController.swift
//  Music_API
//
//  Created by Mr. Naveen Kumar on 15/04/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var musicData: MusicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPI()
    }
    
    func handleAPI() {
        SVProgressHUD.show(withStatus: "Loading...")
        APIManager.shared.fetchGenericData(urlString: urlString, dict: [:], requestType: .get) { (model: MusicModel) in
            if model.success == 1 {
                DispatchQueue.main.async {
                    self.musicData = model
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        } failure: { (error) in
            Global.shared.showAlert(title: error , message: "")
            SVProgressHUD.dismiss()
        }
        
    }
    
    
}

// MARK:- TableView Method
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MusicTableViewCell {
            cell.musicLabel.text = musicData?.data[indexPath.row].name
            cell.musicImage.sd_setImage(with: URL(string: musicData?.data[indexPath.row].categoryImage ?? ""), placeholderImage: UIImage(systemName: "applelogo"))

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let musicListVC = self.storyboard?.instantiateViewController(withIdentifier: "MusicListViewController") as? MusicListViewController {
            musicListVC.musicData = (musicData?.data[indexPath.row].list)!
            self.navigationController?.pushViewController(musicListVC, animated: true)
        }
    }
}


// MARK:- TableView Cell
class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
}
