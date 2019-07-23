//
//  DataCollectionCell.swift
//  Assignment
//
//  Created by test on 23/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class DataCollectionCell: UICollectionViewCell {
    static let dataCelIdentifier = "DataCollectionCell"
    /// Container view for beautification
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        return view
    }()
    /// Image from the data
    let imgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        image.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        return image
    }()
    /// Main title label
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /// Description Label
    let subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        containerView.addSubview(imgView)
        containerView.addSubview(title)
        containerView.addSubview(subTitle)
        contentView.addSubview(containerView)
        contentView.backgroundColor = UIColor.white
        layoutCellConstraints()
    }
    /// Layout for the cell things
    func layoutCellConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imgView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 70),
            title.topAnchor.constraint(equalTo: imgView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 30),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            subTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
    }
    func setUpCell(with cellData: DataDict) {
        title.text = ""
        subTitle.text = ""
        /// check for nil values
        if cellData.title != nil || cellData.description != nil || cellData.imageHref != nil {
            if let titletext = cellData.title{
                title.text = titletext
            }
            if let subTitleText = cellData.description{
                subTitle.text = subTitleText
            }
            if let imghref = cellData.imageHref {
                imgView.downloadImageFrom(link: imghref)
            } else {
                imgView.image = #imageLiteral(resourceName: "Imageplaceholder")
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
