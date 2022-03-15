//
//  ProductListCell.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//

import UIKit
import SDWebImage
class ProductListCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cardViewShadow()
        characterImg.layer.masksToBounds = true
        characterImg.layer.cornerRadius = 4.0
    }
    
    func wrapView(model: MarvelListResult) {
            self.characterName.text = model.name
            if let imgPath = model.thumbnail?.path, let thumbnailExtension = model.thumbnail?.thumbnailExtension{
                
                SDWebImageManager.shared.loadImage(with: URL.init(string: "\(imgPath).\(thumbnailExtension)"), options: .continueInBackground) { (x, y, url) in
                    
                } completed: { (image, data, error, cache, isBool, url) in
                    if (image != nil && isBool) {
                        SDImageCache.shared.store(image?.resizeImage(s: self.characterImg.bounds.size), imageData: data, forKey: "\(imgPath).\(thumbnailExtension)", toDisk: true, completion: nil)
                        if let imgData = image?.resizeImage(s: self.characterImg.bounds.size)?.jpegData(compressionQuality: 0.35) {
                            DispatchQueue.main.async { [weak self] in
                                self?.characterImg.image = UIImage(data: imgData)
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                self?.characterImg.image = image?.resizeImage(s: self?.characterImg.bounds.size ?? .zero)
                            }
                        }
                    }
                }
            }
        }
    }
