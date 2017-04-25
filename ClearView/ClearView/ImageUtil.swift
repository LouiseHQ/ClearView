//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import Foundation

/*!
 @brief A utility for images processing
 */
public class ImageUtil {
    /*!
     @brief Attempt to remove reflection on the image
     */
    class func removeReflection(_ image: UIImage) -> UIImage {
        return NativeImageUtil.removeReflection(image)
    }
}
