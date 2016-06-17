//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "ABMediaPlayer.h"
#import "ABYoutubePlayer.h"
#import "ABVimeoPlayer.h"
#import "ABFilePlayer.h"
//#import "ABWebViewPlayer.h"

typedef NS_ENUM(NSUInteger, ABMediaType) {
    ABMediaTypeYouTube,
    ABMediaTypeVimeo,
    ABMediaTypeFile
    //ABMediaTypeWebView
};

@interface ABMediaPlayer : NSObject

@property (nonatomic) ABQuailityOptions videoQuality;
@property (nonatomic, strong) NSURL *contentURL;


#pragma mark - Instance Methods

- (instancetype)initWithURL:(NSURL *)contentURL;

- (void)parseWithCompletion:(void(^)(ABMediaType videoType, ABMediaHandler *video, NSError *error))callback;


#pragma mark - Class Methods

+ (void)parse:(NSURL *)contentURL completion:(void(^)(ABMediaType, ABMediaHandler *, NSError *))callback;

- (void)playInViewController:(UIViewController *)rootViewController withQuality:(ABQuailityOptions)quality;

@end
