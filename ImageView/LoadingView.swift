//
//  LoadingView.swift
//  ImageView
//
//  Created by Пользователь on 04.01.2021.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    init (){
        super.init(frame: .zero)
        initView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
}

private extension LoadingView {
    func initView() {
        configureContentView()
    }
    func configureContentView () {
        UINib(nibName: String(describing: LoadingView.self), bundle: nil).instantiate(withOwner: self)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
