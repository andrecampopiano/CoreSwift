//
//  UIImageView.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

extension UIImageView {
    public func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        let data = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }
        data.resume()
    }
    
    public func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
