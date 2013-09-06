//  Copyright (c) 2013 Namo Media. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Parse/Parse.h>

#import "ContentCell.h"

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    self.labelTitle.contentMode = UIViewContentModeTop;
    [self addSubview:self.labelTitle];

    self.labelLikes = [[UILabel alloc] init];
    [self addSubview:self.labelLikes];
    self.labelLikes.font = [UIFont systemFontOfSize:12.0f];

    self.labelRepins = [[UILabel alloc] init];
    [self addSubview:self.labelRepins];
    self.labelRepins.font = [UIFont systemFontOfSize:12.0f];

    self.labelRepinnedBy = [[UILabel alloc] init];
    [self addSubview:self.labelRepinnedBy];
    self.labelRepinnedBy.font = [UIFont boldSystemFontOfSize:12.0f];

    self.labelRepinnedByTitle = [[UILabel alloc] init];
    [self addSubview:self.labelRepinnedByTitle];
    self.labelRepinnedByTitle.font = [UIFont systemFontOfSize:12.0f];
    self.labelRepinnedByTitle.text = @"Repinned by:";

    self.imageViewPicture = [[PFImageView alloc] init];
    self.imageViewPicture.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewPicture.clipsToBounds = YES;
    [self addSubview:self.imageViewPicture];

    self.imageViewRepinnedBy = [[PFImageView alloc] init];
    [self addSubview:self.imageViewRepinnedBy];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat width = self.bounds.size.width;
  self.imageViewPicture.frame = CGRectMake(5, 5, 120, 120);

  CGFloat contentLeft = CGRectGetMaxX(self.imageViewPicture.frame) + 5.0f;

  self.labelTitle.frame = CGRectMake(contentLeft, 5, width - contentLeft - 5, 45.0f);
  self.labelTitle.numberOfLines = 3;
  self.labelTitle.lineBreakMode = NSLineBreakByWordWrapping;

  float y = CGRectGetMaxY(self.labelTitle.frame) + 10;

  self.labelLikes.frame = CGRectMake(contentLeft, y, 80, 15);
  self.labelRepins.frame = CGRectMake(contentLeft + 80 + 5, y, 100, 15);

  y = CGRectGetMaxY(self.labelLikes.frame) + 10;

  self.imageViewRepinnedBy.frame = CGRectMake(contentLeft, y, 40, 40);
  self.labelRepinnedByTitle.frame = CGRectMake(contentLeft + 44, y, width - contentLeft - 46, 20);
  self.labelRepinnedBy.frame = CGRectMake(contentLeft + 44, y + 20, width - contentLeft - 46, 10);
}

#pragma mark - Static Methods
+ (CGFloat)desiredHeight {
  return 130.0f;
}

+ (NSString *)reuseIdentifier {
  static NSString *reuseIdentifier = @"ContentCell";
  return reuseIdentifier;
}

@end
