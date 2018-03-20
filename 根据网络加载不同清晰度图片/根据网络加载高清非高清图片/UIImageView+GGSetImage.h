//
//  UIImageView+GGSetImage.h
//  根据网络加载高清非高清图片
//
//  Created by LGQ on 16/5/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GGImageDownloadType) {
    GGImageDownloadTypeCache,
    GGImageDownloadTypeNet
};

typedef void(^GGWebImageCompletionBlock)(UIImage *image, GGImageDownloadType type, NSError *error);

@interface UIImageView (GGSetImage)

- (void)gg_setImageWithOriginalUrl:(NSURL *)originalUrl
                      thumbnailUrl:(NSURL *)thumbnailUrl
                       placeholder:(UIImage *)placeholder
                         completed:(GGWebImageCompletionBlock)compltedBlock;
@end
