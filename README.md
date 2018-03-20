# 根据网络是否是WiFi加载不同清晰度图片


---
给 UIImageView 添加分类，在使用 AFN 和 SDWebImage 框架的情况下，使用下面方法分辨传入原图url、缩略图url 和 placeholder，会自动根据网络状况下载不同清晰的图片

```
- (void)gg_setImageWithOriginalUrl:(NSURL *)originalUrl thumbnailUrl:(NSURL *)thumbnailUrl placeholder:(UIImage *)placeholder completed:(GGWebImageCompletionBlock)compltedBlock;

```

