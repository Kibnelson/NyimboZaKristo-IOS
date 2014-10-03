//
//  SongViewController.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/1/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import "SongViewController.h"
#import "NavigationViewController.h"
#import "CommonViews.h"
#import "Constants.h"
#import "Utils.h"
#import "TPKeyBoardAvoidingScrollView.h"

@interface SongViewController ()
@property (nonatomic, strong) NSDictionary *songDetails;
@property (nonatomic, strong) UIButton *mediaButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, assign)  CGFloat standardWidth;
@property (nonatomic, assign)  BOOL songPaused;
@property (nonatomic, assign) NSString *songNo;
@property (nonatomic, assign) NSString *songURL;
@property (nonatomic, assign) NSInteger *pointOfSearch;
@property (nonatomic, strong) NavigationViewController *navigationController;
@property (nonatomic, strong) UIBarButtonItem *uIBarButtonItem;
@property (nonatomic, strong)  UITextView *text;

@end

@implementation SongViewController
@synthesize mediaButton;
@synthesize pauseButton;
@synthesize videoButton;
@synthesize myAudioPlayer;
@synthesize myPlayer;
@synthesize myVideoPlayer;
@synthesize navigationController;
@synthesize uIBarButtonItem;
@synthesize text;


- (SongViewController*)initWithData:(NSDictionary*)songDetails pointOfSearch:(NSInteger*) pointOfSearch
{
    self = [super init];
    
    if (self) {
        self.songDetails = songDetails;
        self.pointOfSearch=pointOfSearch;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.songPaused=NO;
    self.songNo=[self.songDetails objectForKey:@"No"];
    self.songURL=[self.songDetails objectForKey:@"url"];
    NSString *str=self.songNo;
    str=[str stringByAppendingString:@" "];
    str=[str stringByAppendingString:[self.songDetails objectForKey:@"Title"]];
    
    self.title = str;
    
    navigationController = (NavigationViewController*)self.parentViewController;
    
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    
    [self.view addSubview:[CommonViews imageView:@"activity_background.png"
                                           frame:CGRectMake(0.0f, - navigationController.navigationBar.bounds.size.height, screenRect.size.width, screenRect.size.height )  topInset:0 leftInset:0 bottomInset:0 rightInset:0]];
    
    
    UIView *titleView = [CommonViews titleView:str];
    
    [self.view addSubview:titleView];
    
    UIApplication* application = [UIApplication sharedApplication];
    
    uIBarButtonItem=[CommonViews layoutActionBarButtons:self home:YES signedIn:YES orientation: application.statusBarOrientation ];
    
    // NSLog(@"-------%@",self.pointOfSearch);
    
    [self.view addSubview:[self createViews]];
    
    //    [self createViews];
    
}
- (UIView*) createViews {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    
    
    
    TPKeyboardAvoidingScrollView *containerView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(LAYOUT_LEFT_OUTER_X_POS, 20.0f, self.view.frame.size.width-(LAYOUT_STANDARD_VIEW_MARGIN_IPHONE*2), (self.view.frame.size.height - navigationController.navigationBar.bounds.size.height - (LAYOUT_Y_POSITION_AFTER_TITLE-LAYOUT_TOP_MARGIN)) - LAYOUT_BACKGROUND_MARGIN_IPHONE - (LAYOUT_TOP_MARGIN + LAYOUT_BOTTOM_MARGIN))];
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    containerView.tag = TAG_SCROLL_VIEW;
    containerView.delegate = self;
    [containerView setShowsHorizontalScrollIndicator:NO];
    
    
    text =[[UITextView alloc] initWithFrame: CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS+15, 300.0f, 300)];
    [text setText:[self.songDetails objectForKey:@"Song"]];
    
    text.backgroundColor= [UIColor clearColor];
    text.editable=NO;
    [text setFont:[UIFont boldSystemFontOfSize:20]];
    
    
    text.delegate=self;
    
    [containerView addSubview:text];
    
    
    UIImage *image = [UIImage imageNamed:@"play_audio"];
    UIImage *imagePressed = [UIImage imageNamed:@"pressed"];
    
    mediaButton=[CommonViews buttonWithTitle:@"" target:self selector:@selector(playSound) frame:CGRectMake(80.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10, 40, 40) image:image imagePressed:imagePressed darkTextColor:NO];
    
    
    UIImage *imagePause = [UIImage imageNamed:@"pause"];
    
    pauseButton=[CommonViews buttonWithTitle:@"" target:self selector:@selector(pauseSound) frame:CGRectMake(140.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10, 40, 40) image:imagePause imagePressed:imagePressed darkTextColor:NO];
    
    UIImage *imagePlayVideo = [UIImage imageNamed:@"video"];
    
    videoButton=[CommonViews buttonWithTitle:nil target:self selector:@selector(playVideo) frame:CGRectMake(190.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10,40, 40) image:imagePlayVideo imagePressed:imagePressed darkTextColor:NO];
    
    [self.view addSubview:mediaButton];
    [self.view addSubview:pauseButton];
    [self.view addSubview:videoButton];
    
    
    
    
    return containerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIApplication* application = [UIApplication sharedApplication];
    
    self.navigationItem.titleView = [CommonViews logo:application.statusBarOrientation ];
    
    [self adjustLayout:application.statusBarOrientation];
    
    
}
- (void)adjustLayout:(UIInterfaceOrientation)toInterfaceOrientation {
    
    self.navigationItem.rightBarButtonItem=nil;
    UIView *scrollView = (UIView *)[self.view viewWithTag:TAG_SCROLL_VIEW];
    
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        for(UIView *currentView in scrollView.subviews){
            if([currentView isKindOfClass:[UITextView class]]){
                
                
                currentView.frame = CGRectMake(0.0f, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
            }
        }
        
        mediaButton.frame=CGRectMake(80.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10, 40, 40);
        
        pauseButton.frame=CGRectMake(140.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10, 40, 40);
        videoButton.frame=CGRectMake(190.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*10, 40, 40);
        
        
    }else{
        
        mediaButton.frame=CGRectMake(140.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*6, 40, 40);
        pauseButton.frame=CGRectMake(200.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*6, 40, 40);
        videoButton.frame=CGRectMake(260.0f, (LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)*6, 40, 40);
        for(UIView *currentView in scrollView.subviews){
            if([currentView isKindOfClass:[UITextView class]]){
                
                
                currentView.frame = CGRectMake(100.0f, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
            }
        }
    }
}
- (void)playVideo{
    
    
    NSString *preFix =[NSString stringWithFormat:@"%@%@", @"song_video_", self.songNo];
    NSString *path = [[NSBundle mainBundle] pathForResource:preFix ofType:@"mp4"];
    
    if(path !=nil){
        
        if(self.pointOfSearch==1){
            myVideoPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
            myVideoPlayer.movieSourceType=MPMovieSourceTypeFile;
        }
        else{
            myVideoPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.songURL]];
            myVideoPlayer.movieSourceType=MPMovieSourceTypeStreaming;
        }
        [myVideoPlayer prepareToPlay];
        [myVideoPlayer.view setFrame: self.view.bounds];
        myVideoPlayer.shouldAutoplay=YES;
        myVideoPlayer.repeatMode = MPMovieRepeatModeOne;
        myVideoPlayer.fullscreen =NO;
        myVideoPlayer.scalingMode = MPMovieScalingModeAspectFit;
        myVideoPlayer.view.tag=8001;
        [self.view addSubview:myVideoPlayer.view];
        [myVideoPlayer play];
        self.navigationItem.rightBarButtonItem = uIBarButtonItem;
        
    }else
    {
        [navigationController showToastMessage:@"The selected song has no video available."];
    }
    
}
- (void)pauseSound{
    
    if(myAudioPlayer==nil){
        
        [navigationController showToastMessage:@"There is no song playing"];
    }
    else
    {
        [myAudioPlayer pause];
        self.songPaused=YES;
        [mediaButton setSelected:NO];
    }
}
- (void)playSound{
    
    if(self.songPaused){
        self.songPaused=NO;
        [myAudioPlayer play];
        [mediaButton setSelected:YES];
    }else {
        if(!mediaButton.isSelected){
            if([myAudioPlayer isPlaying])
            {
                [myAudioPlayer stop];
                myAudioPlayer=nil;
                
            }
            else
            {
                NSError *error;
                NSString *preFix =[NSString stringWithFormat:@"%@%@", @"song_", self.songNo];
                
                
                NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:preFix ofType:@"mp3"];
                
                if(self.pointOfSearch==1){
                    
                    if(soundFilePath !=nil){
                        NSURL *fileURL =[[NSURL alloc] initFileURLWithPath:soundFilePath];
                        myAudioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
                    }
                }
                else{
                    //Sample video for testing
                    //                        NSString *resoucePath=@"http://www.chiptape.com/chiptape/sounds/long/_sweet.mp3";
                    
                    NSData *objectData=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.songURL]];
                    
                    myAudioPlayer =[[AVAudioPlayer alloc] initWithData:objectData error:&error];
                    soundFilePath=@"test";
                }
            
                if(soundFilePath !=nil){
                    
                    myAudioPlayer.numberOfLoops=-1;
                    myAudioPlayer.volume=1.0f;
                    [myAudioPlayer prepareToPlay];
                    if(myAudioPlayer!=nil){
                        [myAudioPlayer play];
                        [mediaButton setSelected:YES];
                    }
                }
                else{
                    [navigationController showToastMessage:@"The selected song has no audio available."];
                    
                }
                
            }
        } else{
            [myAudioPlayer stop];
            myAudioPlayer=nil;
            [mediaButton setSelected:NO];
        }
    }
    
}
- (void)exitVideoPlayer{
    self.navigationItem.rightBarButtonItem=nil;
    [myVideoPlayer stop];
    [myVideoPlayer.view removeFromSuperview];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [aScrollView setContentOffset: CGPointMake(0, aScrollView.contentOffset.y)];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    self.navigationItem.titleView = [CommonViews logo:toInterfaceOrientation];
    self.navigationItem.rightBarButtonItem = [CommonViews layoutActionBarButtons:self home:YES signedIn:YES orientation: toInterfaceOrientation ];
    
    [self adjustLayout:toInterfaceOrientation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
