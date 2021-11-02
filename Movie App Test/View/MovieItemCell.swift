//
//  MovieItemCell.swift
//  MovieItemCell
//
//  Created by MoonBoon on 2/11/21.
//

import UIKit

class MovieItemCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDetails: UILabel!
    
    var cellViewModel: MovieCellViewModel? {
        didSet{
            movieName.text = cellViewModel?.movieTitle
            movieDetails.text = cellViewModel?.movieOverview
            if let link = cellViewModel?.poster{
                poster.downloaded(from: "https://www.themoviedb.org/t/p/w94_and_h141_bestv2\(link)")
            }
            
            
        }
    }

    
}
extension UIImageView {
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
