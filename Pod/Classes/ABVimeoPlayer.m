//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import "ABVimeoPlayer.h"

NSString *const kVideoConfigURL = @"http://player.vimeo.com/video/%@/config";

@interface ABVimeoPlayer()
@property (nonatomic, strong) NSString *videoID;
@end

@implementation ABVimeoPlayer

- (void)parseWithCompletion:(void(^)(NSError *))callback {
    BOOL (^callback_if_error)(NSError *) = ^(NSError *error){
        if (error) {
            if (callback) {
                dispatch_async(dispatch_get_main_queue(), ^{ callback(error); });
            }
            return YES;
        }
        return NO;
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSString *dataURL = [NSString stringWithFormat:kVideoConfigURL, self.videoID];
        NSString *data = [NSString stringWithContentsOfURL:[NSURL URLWithString:dataURL] encoding:NSUTF8StringEncoding error:&error];
        
        if (callback_if_error(error)) return;
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
        
        if (callback_if_error(error)) return;
        
        self.videosInfo = [jsonData valueForKeyPath:@"request.files.h264"];

        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil);
            });
        }
    });
}

- (NSURL *)videoURL:(ABQuailityOptions)quality {
    NSDictionary *data = nil;
    
    switch (quality) {
        case ABQuailityLow:
            data = _videosInfo[@"mobile"];
            break;
        case ABQuailityMedium:
            data = _videosInfo[@"sd"];
            break;
        case ABQuailityHigh:
            data = _videosInfo[@"hd"];
    }
    
    if (!data && _videosInfo.count > 0) {
        data = [_videosInfo allValues][0]; //defaults to 1st index
    }
    
    NSURL *resultVideoURL = data ? [NSURL URLWithString:data[@"url"]] : nil;
    return resultVideoURL;
}


#pragma mark - Properties

- (NSString *)videoID {
    NSString* result = self.contentURL.lastPathComponent;
    return result;
}

@end
