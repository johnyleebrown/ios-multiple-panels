//
//  CVCPhotoCell.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/31/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

class CVCPhotoCell: UICollectionViewCell {

    @IBOutlet weak var ivPhoto: UIImageView!
    
    private var imageDataTask: URLSessionDataTask?
    
    let urlPhoto = URL(string: "https://images.unsplash.com/photo-1557149559-f5ee3514db38?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjUzODQxfQ")
    
    let url = URL(string: "https://api.unsplash.com/photos/random?count=1&client_id=358bd86f2c14fc4a7fa0aab41571241aa6a0ffbef4d3109d290ffa13de9e794c")
    
    func downloadPhoto() {
        imageDataTask = URLSession.shared.dataTask(with: urlPhoto!) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.imageDataTask = nil
            
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
     
            DispatchQueue.main.async {
                UIView.transition(with: strongSelf.ivPhoto, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    strongSelf.ivPhoto.image = image
                }, completion: nil)
            }
        }
        
        imageDataTask?.resume()
    }
    
//    func getFromUrl(urlAddon:String, getStructFromURL:Bool) {
//        if let url = URL.with(string: urlAddon) {
//            var urlRequest = URLRequest(url: url)
//
//            if getStructFromURL {
//                urlRequest.setValue("Client-ID ", forHTTPHeaderField: "Authorization")
//            }
//
//            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//                if let data = data {
//                    do {
//                        if getStructFromURL {
//                            let image = try JSONDecoder().decode(Image.self, from: data)
//                            self.imgURL = image.urls.regular
//                            self.getFromUrl(urlAddon:self.imgURL!, getStructFromURL:false)
//                        } else {
//                            DispatchQueue.main.async {
//                                self.photos.append(Ph(photo: UIImage(data:data)!))
//                            }
//
//                        }
//
//                    } catch let error {
//                        print(error)
//                    }
//                }
//                }.resume()
//        }
//    }
}
