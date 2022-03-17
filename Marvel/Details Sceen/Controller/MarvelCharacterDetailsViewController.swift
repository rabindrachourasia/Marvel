//
//  MarvelCharacterDetailsViewController.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import UIKit

class MarvelCharacterDetailsViewController: UIViewController {
    @IBOutlet private weak var characterDescription: UILabel!
    @IBOutlet private weak var characterName: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    var model : [MarvelListResult]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataLoad()
    }
    
    func dataLoad(){
       guard let data = model, data.count > 0  else { return }
        if let name = model?[0].name{
            characterName.text = name
            self.title = name
        }
        if let desc = model?[0].resultDescription{
            characterDescription.text = desc
        }
        if let imgPath = model?[0].thumbnail?.path, let thumbnailExtension = model?[0].thumbnail?.thumbnailExtension{
            productImage.setImage(URL(string:"\(imgPath).\(thumbnailExtension)"))
        }
    }
    deinit {
        debugPrint(String(describing: MarvelCharacterDetailsViewController.self))
    }

}
