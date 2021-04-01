//
//  ViewController.swift
//  ImageView
//
//  Created by Пользователь on 14.12.2020.
//

import UIKit
import Moya
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var images: [ImageResponseModel] = []
    var currentImageUrl: URL?
    var currentAuthor: String?
    var loadingView = LoadingView()
    var indexOfPage = 1
    var indexOfCell = 0
    var setIsEndPages = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catalog"
        var tableHeadrViewframe = CGRect.zero
        tableHeadrViewframe.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: tableHeadrViewframe)
        tableView.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        makeImage()
    }
}

extension ViewController {
    
    
    func makeImage () {
        ApiProvider.request(.getImageList(page: indexOfPage, limit: 100)) { result in
            switch result {
            case .success (let response):
                do {
                    let response = try JSONDecoder().decode([ImageResponseModel].self, from: response.data)
                    if response.isEmpty {
                        self.setIsEndPages = true
                    } else {
                        self.tableView.beginUpdates()
                        var ips: [IndexPath] = []
                        for (index, _) in response.enumerated() {
                            ips.append(IndexPath(row: self.images.count + index, section: 0))
                        }
                        self.tableView.insertRows(at: ips, with: .automatic)
                        self.images.append(contentsOf: response)
                        self.indexOfPage += 1
                        self.tableView.endUpdates()
                        
                    }
                } catch {
                    print (error)
                }
            case .failure (let error):
                print (error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if setIsEndPages {
            return nil
        } else {
            return loadingView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageTableViewCell.self),
                                                 for: indexPath) as! ImageTableViewCell
        let image = images [indexPath.row]
        var url = image.download_url
        url.deleteLastPathComponent()
        url.deleteLastPathComponent()
        url.appendPathComponent("300")
        url.appendPathComponent("200")
        
        cell.viewImage.kf.setImage(with: url, options: [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = images [indexPath.row]
        currentAuthor = image.author
        currentImageUrl = image.download_url
        performSegue(withIdentifier: "segue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let offsetY = scrollView.contentOffset.y
    //        let contentHeight = scrollView.contentSize.height
    //
    //        if offsetY > contentHeight - scrollView.frame.size.height {
    //            indexOfPage += 1
    //            makeImage()
    //        }
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SecondViewController else { return }
        dvc.urlImage = currentImageUrl
        dvc.author = currentAuthor
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !setIsEndPages && tableView.isLast(indexPath) else { return }
        makeImage ()
    }
}

struct ImageResponseModel: Decodable {
    let author: String
    let download_url: URL
}

extension UITableView {
    func isLast (_ indexPath: IndexPath) -> Bool{
        return indexPath.row == numberOfRows(inSection: indexPath.section) - 1
    }
}
