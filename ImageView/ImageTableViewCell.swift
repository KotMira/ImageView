//
//  ImageTableViewCell.swift
//  ImageView
//
//  Created by Пользователь on 14.12.2020.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.layer.cornerRadius = 7
        containerView.layer.cornerRadius = 7
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 3, height: 1)
        containerView.layer.shadowRadius = 5
    }
}
