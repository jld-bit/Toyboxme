import Foundation
import UIKit

protocol ImageCaching {
    func image(for key: String) -> UIImage?
    func insert(_ image: UIImage, for key: String)
}

final class ImageCache: ImageCaching {
    private let cache = NSCache<NSString, UIImage>()

    func image(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func insert(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
