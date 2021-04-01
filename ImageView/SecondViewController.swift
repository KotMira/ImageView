//
//  SecondViewController.swift
//  ImageView
//
//  Created by Пользователь on 20.12.2020.
//

import UIKit
import Kingfisher

class SecondViewController: UIViewController {
    var urlImage: URL?
    var author: String?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = author
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        fullImage.kf.setImage(with: urlImage)
        return fullImage
    }
}

extension SecondViewController: UIScrollViewDelegate {
    
}

