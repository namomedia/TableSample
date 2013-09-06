//
//  ContentCell.h
//  TableSample
//
//  Created by Gabor Cselle on 9/2/13.
//  Copyright (c) 2013 Namo Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property(strong, nonatomic) UILabel *labelTitle;
@property(strong, nonatomic) UILabel *labelLikes;
@property(strong, nonatomic) UILabel *labelRepins;
@property(strong, nonatomic) UILabel *labelRepinnedBy;
@property(strong, nonatomic) PFImageView *imageViewPicture;
@property(strong, nonatomic) PFImageView *imageViewRepinnedBy;

@property(nonatomic, strong) UILabel *labelRepinnedByTitle;

+ (NSString *)reuseIdentifier;

+ (CGFloat)desiredHeight;

@end
