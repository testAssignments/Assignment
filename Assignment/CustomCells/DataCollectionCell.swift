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
    static let cellCornerRadius: CGFloat = 5.0
    /// Container view for beautification
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = cellCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    /// Image from the data
    let imgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill // image will never be strecthed vertially or horizontally
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
        contentView.layer.cornerRadius = DataCollectionCell.cellCornerRadius
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.black
    }
    /// Layout for the cell things
    func layoutCellConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 3),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imgView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            title.topAnchor.constraint(equalTo: imgView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 30),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            subTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            subTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }
    /// Setting up the collectionview cell
    func setUpCell(with cellData: DataDict) {
        title.text = ""
        subTitle.text = ""
        /// check for nil values
        if cellData.title != nil || cellData.description != nil || cellData.imageHref != nil {
            if let titletext = cellData.title {
                title.text = titletext
            }
            if let subTitleText = cellData.description {
                subTitle.text = subTitleText
            }
            if let imghref = cellData.imageHref {
                imgView.downloadImageFrom(link: imghref)
            } else {
                imgView.image = #imageLiteral(resourceName: "Imageplaceholder")
            }
        }
        layoutCellConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
