//
//  SongViewController.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/1/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface SongViewController : UIViewController
{
    AVAudioPlayer *myAudioPlayer;
    AVPlayer *myPlayer;
    MPMoviePlayerController *myVideoPlayer;
}
- (SongViewController*)initWithData:(NSDictionary*)songDetails pointOfSearch:(NSInteger*) pointOfSearch;

@property (nonatomic,retain) AVAudioPlayer *myAudioPlayer;
@property (nonatomic,retain) AVPlayer *myPlayer;
@property (nonatomic,retain) MPMoviePlayerController *myVideoPlayer;


@end
