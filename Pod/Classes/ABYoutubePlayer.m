//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import "ABYoutubePlayer.h"
#import "HCYoutubeParser.h"

@interface ABYoutubePlayer()
@end

@implementation ABYoutubePlayer

- (void)parseWithCompletion:(void(^)(NSError *error))callback {
    __weak ABYoutubePlayer *weakSelf = self;
    [HCYoutubeParser h264videosWithYoutubeURL:self.contentURL completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
        ABYoutubePlayer *strongSelf = weakSelf;
        strongSelf.videosInfo = videoDictionary;
        
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        }
    }];
}

- (void)thumbImage:(ABQuailityOptions)quality completion:(void(^)(UIImage *thumbImage, NSError *error))callback {
    NSAssert(callback, @"usingBlock cannot be nil");
    
    YouTubeThumbnail youTubeQuality = YouTubeThumbnailDefault;
    switch (quality) {
        case ABQuailityLow:
            youTubeQuality = YouTubeThumbnailDefaultMedium;
            break;
        case ABQuailityMedium:
            youTubeQuality = YouTubeThumbnailDefaultHighQuality;
            break;
        case ABQuailityHigh:
            youTubeQuality = YouTubeThumbnailDefaultMaxQuality;
            break;
    }
    
    [HCYoutubeParser thumbnailForYoutubeURL:self.contentURL thumbnailSize:youTubeQuality completeBlock:^(UIImage *image, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(image, nil);
        });
    }];
}

- (NSURL *)videoURL:(ABQuailityOptions)quality {
    NSString *strURL = nil;
    
    switch (quality) {
        case ABQuailityLow:
            strURL = self.videosInfo[@"small"];
            break;
        case ABQuailityMedium:
            strURL = self.videosInfo[@"medium"];
            break;
        case ABQuailityHigh:
            strURL = self.videosInfo[@"hd720"];
    }
    
    if (!strURL && self.videosInfo.count > 0) {
        strURL = [self.videosInfo allValues][0]; //defaults to 1st index
    }
    
    return strURL ? [NSURL URLWithString:strURL] : nil;
}


@end
