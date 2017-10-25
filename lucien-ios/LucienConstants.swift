//
//  LucienConstants.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/3/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class LucienConstants {

    // MARK: - UIImage Constants

    static let compressionQuality = CGFloat(0.9)

    // MARK: - BottomBorderTextField Constants

    static let bottomBorderYOffset = CGFloat(3.0)

    // MARK: - Keyboard Constants

    static let keyboardHeightPadding = CGFloat(50)
    static let releaseDateTextFieldCharacterCountLimit = 4

    // MARK: - Form Constants

    static let pickerViewLeftimageEdgeInsetOffset = CGFloat(72)

    // MARK: - CoverPhotoButton Glow Effect Constants

    static let overlayButtonScaleX = CGFloat(0.9)
    static let overlayButtonScaleY = CGFloat(0.9)
    static let coverButtonScaleX = CGFloat(1.65)
    static let coverButtonScaleY = CGFloat(1.29)
    static let coverButtonBlurRadius = CGFloat(55)
    static let coverButtonShadowRadius = CGFloat(5)
    static let coverButtonShadowOpacity = Float(0.35)
    static let coverButtonOpacity = CGFloat(0.6)
    static let buttonBorderRadius = CGFloat(10)

    // MARK: - CoverPhotoButton Default Button Constants

    static let coverPhotoDefaultAlpha =  CGFloat(1.0)
    static let coverPhotoDefaultShadowOpacity =  Float(0.0)
    static let coverPhotoDefaultShadowRadius =  CGFloat(0.0)
    static let coverPhotoBottomImageInset =  CGFloat(70)
    static let coverPhotoNormalStateTitle = NSAttributedString(string: "Take Cover Photo", attributes: [NSAttributedStringKey.font: LucienTheme.Fonts.muliBold(size: 16.0) ?? UIFont(), NSAttributedStringKey.foregroundColor: UIColor.white])
    static let coverPhotoHighlightedStateTitle = NSAttributedString(string: "Take Cover Photo",
                                                                    attributes: [NSAttributedStringKey.font: LucienTheme.Fonts.muliBold(size: 16.0) ?? UIFont(), NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    static let coverPhotoTopTitleEdgeInset =  CGFloat(25)

    // MARK: - Dispatch Queue Constants

    static let captureQueueName = "com.lucien-ios.captureQueue"

    // MARK: - Constraints

    static let overlayButtonTopConstraint = CGFloat(10)
    static let overlayButtonLeadingConstraint = CGFloat(15)

    // MARK: - Dasboard Button Constants

    static let dashboardButtonCornerRadius = CGFloat(3.0)
    static let dashboardButtonBorderWidth = CGFloat(1.0)
    static let dashboardButtonTextSpacing = Float(1.0)

    // MARK: - UIImageView Constants

    static let comicCoverPhotoCornerRadius = CGFloat(6.0)
}
