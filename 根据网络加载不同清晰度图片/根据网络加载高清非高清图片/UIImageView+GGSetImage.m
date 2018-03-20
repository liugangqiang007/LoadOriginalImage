//
//  UIImageView+GGSetImage.m
//  根据网络加载高清非高清图片
//
//  Created by LGQ on 16/5/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "UIImageView+GGSetImage.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@implementation UIImageView (GGSetImage)

- (void)gg_setImageWithOriginalUrl:(NSURL *)originalUrl thumbnailUrl:(NSURL *)thumbnailUrl placeholder:(UIImage *)placeholder completed:(GGWebImageCompletionBlock)compltedBlock {
    
    // 从缓存加载原图，高清图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalUrl.absoluteString];
   
    
    if (originalImage) {
        
        // 如果高清图存在，直接使用，使用SDWebImage，可以取消当前的下载，赋值
        [self sd_setImageWithURL:originalUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            compltedBlock(image, GGImageDownloadTypeCache, error);
        }];
        
    } else {
        
        // 如果高清图不存在，从缓存加载缩略图
        UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailUrl.absoluteString];
        
        // afn监控网络状态
        AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
        // 这两行代码在控制器中设置
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 3g、4g 网络下是否下载高清图
        BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
        
        if (manger.isReachableViaWiFi || (manger.isReachableViaWWAN && alwaysDownloadOriginalImage)) {
            
            // wifi网络下，3g/4g 网络并且允许下载高清图情况下，下载原图
            UIImage *placeholderImage = thumbnailImage ? thumbnailImage : placeholder;
            [self sd_setImageWithURL:originalUrl placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                compltedBlock(image, GGImageDownloadTypeNet, error);
            }];
            
        } else {
            
            [self sd_setImageWithURL:thumbnailUrl placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                GGImageDownloadType type = thumbnailImage ? GGImageDownloadTypeCache : GGImageDownloadTypeNet;
                compltedBlock(image, type, error);
            }];
            
        }
    }
}

@end
