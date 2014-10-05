//
//  MainViewController.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/2/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//
//
//MainViewController is the main home page of the application, it will form as the  landing page of every user accessing the applicaition.It allows the users to search for  their favorite song and search teh lyrics, users can also list all songs and skim through all of them. Users can also  switch the given search point from local to server.

#import "MainViewController.h"
#import "CommonViews.h"
#import "Constants.h"
#import "Utils.h"
#import "JSONKit.h"
#import "TPKeyBoardAvoidingScrollView.h"
#import "SongViewController.h"
#import "SongsRequestHandler.h"


@interface MainViewController ()
@property (nonatomic, assign)  CGFloat standardWidth;
@property (nonatomic, strong) NSMutableArray *txnsArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger pointOfSearch;
@property (nonatomic, assign) UILabel *searchSongsLabel;
@property (nonatomic, assign) UISwitch *searchPoint;
@property (nonatomic, assign) UITextField *searchField;
@property (nonatomic, assign) UIButton *searchButton;
@property (nonatomic, assign) UIButton *searchAllButton;
@property (nonatomic, assign) UIButton *searchFieldButton;
@property (nonatomic, strong)  SongsRequestHandler *songsRequestHandler;

@end

@implementation MainViewController
@synthesize tableView;
@synthesize navigationController;
@synthesize searchSongsLabel;
@synthesize searchPoint;
@synthesize searchField;
@synthesize searchButton;
@synthesize searchAllButton;
@synthesize searchFieldButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    navigationController = (NavigationViewController*)self.parentViewController;
    self.pointOfSearch = 1;
    
    self.navigationItem.titleView = [CommonViews logo:[UIApplication sharedApplication].statusBarOrientation];
    
    self.title = @"Home";
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect wholeScreenRect = [[UIScreen mainScreen] bounds];
    
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.standardWidth = screenRect.size.width-(LAYOUT_STANDARD_VIEW_MARGIN_IPHONE*2);
        
    }
    else
    {
        self.standardWidth = wholeScreenRect.size.height-(LAYOUT_STANDARD_VIEW_MARGIN_IPHONE*2);
        
    }
    
    [self.view addSubview:[CommonViews imageView:@"activity_background.png" frame:CGRectMake(0.0f, - navigationController.navigationBar.bounds.size.height, screenRect.size.width, screenRect.size.height ) topInset:0 leftInset:0 bottomInset:0 rightInset:0]];
    
    [self.view addSubview:[self createActivateViews]];
    
    [self createTableView];
}
-(void) fetchLocalSongs{
    //Load raw file that has the songs
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSData *jsonData = [Utils readFileData:@"local_songs" type:@"json"];
    self.dataArray = [jsonDecoder objectWithData:jsonData];
   
}
- (UIView*) createActivateViews {
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    NavigationViewController *navigationController = (NavigationViewController*)self.parentViewController;
    
    TPKeyboardAvoidingScrollView *containerView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(LAYOUT_LEFT_OUTER_X_POS, 20.0f, self.view.frame.size.width-(LAYOUT_STANDARD_VIEW_MARGIN_IPHONE*2), (self.view.frame.size.height - navigationController.navigationBar.bounds.size.height - (LAYOUT_Y_POSITION_AFTER_TITLE-LAYOUT_TOP_MARGIN)) - LAYOUT_BACKGROUND_MARGIN_IPHONE - (LAYOUT_TOP_MARGIN + LAYOUT_BOTTOM_MARGIN))];
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    containerView.tag = TAG_SCROLL_VIEW;
    containerView.delegate = self;
    [containerView setShowsHorizontalScrollIndicator:NO];
    
    
    searchSongsLabel = [CommonViews labelView:@"Search Local Songs?" frame:CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT)];
    [containerView addSubview:searchSongsLabel];
    
    searchPoint =[CommonViews switchView:@"" frame:CGRectMake(LAYOUT_RIGHT_INNER_X_POS+35, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH, LAYOUT_VIEW_HEIGHT) selector:@selector(changeSwitch:) target:self on:YES];
    
    [containerView addSubview:searchPoint];
    
    searchField =[CommonViews textFieldView:@"Search by title/Number" frame:CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT) delegate:self viewTag:TAG_SEARCH_FIELD nextTag:TAG_SEARCH_BUTTON previousTag:TAG_SWITCH_FIELD];
    
    [containerView addSubview:searchField];
    
    UIImage *image = [UIImage imageNamed:@"button_normal.png"];
    UIImage *imagePressed = [UIImage imageNamed:@"button_pressed.png"];
    
    UIImage *imageSearch = [UIImage imageNamed:@"searchIcon.png"];
    UIImage *imageSearchPressed = [UIImage imageNamed:@"searchIcon.png"];

    
    searchFieldButton=[CommonViews buttonWithTitle:nil target:self selector:@selector(searchButtonClicked) frame:CGRectMake(LAYOUT_VIEW_WIDTH + 100, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, 50, 30) image:imageSearch imagePressed:imageSearchPressed darkTextColor:NO];
    
    [containerView addSubview:searchFieldButton];
    
    searchButton=[CommonViews buttonWithTitle:@"Search" target:self selector:@selector(searchButtonClicked) frame:CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT) image:image imagePressed:imagePressed darkTextColor:NO];
    [containerView addSubview:searchButton];
    
    searchAllButton= [CommonViews buttonWithTitle:@"All Songs" target:self selector:@selector(listAllButtonClicked) frame:CGRectMake(LAYOUT_LEFT_INNER_X_POS+150, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT) image:image imagePressed:imagePressed darkTextColor:NO];
    
    [containerView addSubview:searchAllButton];
    
    
    
    return containerView;
}

// Function to determine to search local or server songs
- (void)changeSwitch:(id)sender{
    
    if([sender isOn]){
        self.pointOfSearch = 1;
    } else{
        self.pointOfSearch = 2;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //this tells the operating system to remove
    //the keyboard from the forefront
    [textField resignFirstResponder];

    return NO;
}

- (void) listAllButtonClicked {
    
    self.txnsArray=nil;
    if(self.pointOfSearch==1){ // do a local Search
        [self fetchLocalSongs];
        self.txnsArray = self.dataArray;
        
        [tableView reloadData];
        tableView.hidden=NO;
    }
    else{//list all from online
        [navigationController clearPayload];
        [navigationController putPayload:@"All" key:@"sSearch"];
        [self setSongsRequestHandler: [SongsRequestHandler alloc]];
        [self.songsRequestHandler initWithPayload:navigationController.payloadDictionaryInnerLevel navigationController:navigationController viewController:self];
    }
    
}
- (void) showServerData:(NSArray *)serverData {

    tableView.hidden=YES;
    self.txnsArray = serverData;
    [tableView reloadData];
    tableView.hidden=NO;
}
- (void) searchButtonClicked {
    NSMutableString* errorMsg = [NSMutableString string];
    Boolean valid = true;
    
    UITextField *searchField = (UITextField *)[self.view viewWithTag:TAG_SEARCH_FIELD];
    
    NSString *searchFieldStr = searchField.text;
    if([searchFieldStr length] == 0 ){
        valid = false;
        [errorMsg appendString:@"Please enter a search value\n"];
    }
    
    if(valid){
        
        searchField.text =@"";
        self.txnsArray=nil;
        if(self.pointOfSearch==1){ // do a local Search
            [self fetchLocalSongs];
            NSMutableArray *comboDataArray = [[NSMutableArray alloc] init];
            for(NSDictionary *data in self.dataArray){
                NSString *title=[data objectForKey:@"Title"];
                NSString *songNo=[data objectForKey:@"No"];
                if(([title rangeOfString:searchFieldStr].location !=NSNotFound)||([songNo rangeOfString:searchFieldStr].location !=NSNotFound))
                {// match found load the list
                    [comboDataArray addObject:data];
                }
                
            }
            
            if([comboDataArray count]>0){
                
                tableView.hidden=YES;
                self.txnsArray = comboDataArray;
                [tableView reloadData];
                tableView.hidden=NO;
                
            } else {
                self.txnsArray = nil;
                [tableView reloadData];
                tableView.hidden=YES;
                [NavigationViewController showMessage:@"There is no song matching your search criteria, try again." title:@"Info"];
            }
            
            
        }else{ // Do an online search of the song
            [navigationController clearPayload];
            [navigationController putPayload:searchFieldStr key:@"sSearch"];
            [self setSongsRequestHandler: [SongsRequestHandler alloc]];
            [self.songsRequestHandler initWithPayload:navigationController.payloadDictionaryInnerLevel navigationController:navigationController viewController:self];
            
        }
        
    }else{
        [NavigationViewController showMessage:errorMsg title:@"Validation Error"];
    }
    
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIApplication* application = [UIApplication sharedApplication];
    
    [self adjustLayout:application.statusBarOrientation];
    
    
}
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    self.navigationItem.titleView = [CommonViews logo:toInterfaceOrientation];
    self.navigationItem.rightBarButtonItem = [CommonViews layoutActionBarButtons:self home:YES signedIn:YES orientation: toInterfaceOrientation ];
    
    [self adjustLayout:toInterfaceOrientation];
}
- (void)adjustLayout:(UIInterfaceOrientation)toInterfaceOrientation {
    UIView *scrollView = (UIView *)[self.view viewWithTag:TAG_SCROLL_VIEW];
    self.navigationItem.rightBarButtonItem=nil;
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        
        
        searchSongsLabel.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT);
        searchPoint.frame=CGRectMake(LAYOUT_RIGHT_INNER_X_POS+35, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH, LAYOUT_VIEW_HEIGHT);
        searchField.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT);
        searchFieldButton.frame=CGRectMake(LAYOUT_VIEW_WIDTH + 100, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, 50, 30);
        searchButton.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT);
        
        searchAllButton.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS+150, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT);
        
        
    }else{
        
        
        searchSongsLabel.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS_LANDSCAPE, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT);
        searchPoint.frame=CGRectMake(LAYOUT_RIGHT_OUTER_X_POS_LANDSCAPE+35, LAYOUT_LEVEL_2_VIEW_START_Y_POS, LAYOUT_VIEW_WIDTH, LAYOUT_VIEW_HEIGHT);
        searchField.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS_LANDSCAPE, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, LAYOUT_VIEW_WIDTH*2, LAYOUT_VIEW_HEIGHT);
        searchFieldButton.frame=CGRectMake(LAYOUT_RIGHT_OUTER_X_POS_LANDSCAPE + 100, LAYOUT_LEVEL_2_VIEW_START_Y_POS+40, 50, 30);
        searchButton.frame=CGRectMake(LAYOUT_LEFT_INNER_X_POS_LANDSCAPE, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT);
        
        searchAllButton.frame=CGRectMake(LAYOUT_RIGHT_OUTER_X_POS_LANDSCAPE, LAYOUT_LEVEL_2_VIEW_START_Y_POS+(LAYOUT_VIEW_HEIGHT+LAYOUT_VERTICAL_SPACING)+40, LAYOUT_BUTTON_WIDTH, LAYOUT_VIEW_HEIGHT);
    }
}

- (void) createTableView {
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(LAYOUT_LEFT_OUTER_X_POS, LAYOUT_Y_POSITION_AFTER_TITLE*4, screenRect.size.width-(LAYOUT_STANDARD_VIEW_MARGIN_IPHONE*2), (screenRect.size.height - navigationController.navigationBar.bounds.size.height - (LAYOUT_Y_POSITION_AFTER_TITLE-LAYOUT_TOP_MARGIN)) - LAYOUT_BACKGROUND_MARGIN_IPHONE - (LAYOUT_TOP_MARGIN + LAYOUT_BOTTOM_MARGIN)) style:UITableViewStylePlain];
    
    [tableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tableView reloadData];
    
    [self.view addSubview: tableView];
    
    tableView.hidden=YES;
    
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    CGRect frame= tableView.frame;
    frame.size=tableView.contentSize;
}
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.txnsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    UILabel *titleLabel, *songNo;
    
    static NSString *mmReuseRowIdentifier = @"ReuseRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:mmReuseRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mmReuseRowIdentifier];
        
        titleLabel = [CommonViews labelView:@"" frame:CGRectMake(20.0, 0.0, 300.0, 20.0)];
        titleLabel.tag=TAG_TITLE_LABEL;
        [cell.contentView addSubview:titleLabel];
        
        songNo = [CommonViews labelView:@"" frame:CGRectMake(0.0, 0.0, 300.0, 20.0)];
        songNo.tag=TAG_NO_LABEL;
        [cell.contentView addSubview:songNo];
    } else {
        titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE_LABEL];
        songNo = (UILabel *)[cell.contentView viewWithTag:TAG_NO_LABEL];
    }
    
    NSDictionary *currentTxn = [self.txnsArray objectAtIndex:indexPath.row];
    
    songNo.text = [currentTxn objectForKey:@"No"];
    titleLabel.text = [currentTxn objectForKey:@"Title"];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NavigationViewController *navigationController = (NavigationViewController*)self.parentViewController;
    
    SongViewController *songViewController = [[SongViewController alloc] initWithData:[self.txnsArray objectAtIndex:indexPath.row] pointOfSearch:self.pointOfSearch ];
    
    [navigationController pushViewController:songViewController animated:YES];
    self.txnsArray = nil;
    
    [tableView reloadData];
    tableView.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end;
