//
//  MusicListViewController.swift
//  Music_API
//
//  Created by Mr. Naveen Kumar on 15/04/21.
//

import UIKit
import AVFoundation
import Alamofire
import SVProgressHUD

class MusicListViewController: UIViewController {
    @IBOutlet var musicListTableView: UITableView!
    
    var musicData: [String] = []
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    var isPlay: Bool = false
    var isDownloaded: Bool = false
    var isIndexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK:- TableView Method
extension MusicListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: musicListCellIdentifier, for: indexPath) as? MusicTableViewListCell {
            cell.musicNameLabel.text = musicData[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  downloadMediaFile(musicData[indexPath.row])
//        isPlay = !isPlay
        if isDownloaded && indexPath.row == isIndexSelected{
            if isPlay {
                player?.pause()
            }else {
                player?.play()
            }
            isPlay = !isPlay
        } else {
            player?.pause()
            isDownloaded = !isDownloaded
            downloadMediaFile(musicData[indexPath.row])
        }
        isIndexSelected = indexPath.row
    }
}

// MARK:- TableView Cell
class MusicTableViewListCell: UITableViewCell {
    @IBOutlet weak var musicNameLabel: UILabel!
}

// MARK:- For downloading audio
extension MusicListViewController {
    func downloadMediaFile(_ musicURL: String){
        AF.request("\(musicURL)").downloadProgress(closure : { (progress) in
            print(progress.fractionCompleted)
            SVProgressHUD.showProgress(Float(progress.fractionCompleted))
        }).responseData{ (response) in
            print(response)
            self.isPlay = !self.isPlay
            SVProgressHUD.dismiss()
            self.playSound(soundUrl: musicURL)
        }
    }
    
    func playSound(soundUrl: String) {
        guard let url = URL.init(string: soundUrl) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
}
