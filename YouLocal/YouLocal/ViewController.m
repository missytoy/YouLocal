#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTableCell.h"

NSArray  *notifications;

int currentHeight;
bool notificationDescriptionExist;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    float height = [[UIScreen mainScreen] bounds].size.height;
    float width = [[UIScreen mainScreen] bounds].size.width;
    view.backgroundColor = [UIColor whiteColor];
    
    
    //notifications = [self getInfo];
    if (notifications.count==0 || notifications ==nil) {
        
        UIImageView *noNotificationsImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
        noNotificationsImage.image = [UIImage imageNamed:@"icon-notifications-large@2x.png"];
        
        UILabel *noNotificationsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,400, width, 200) ];
        noNotificationsLabel.textAlignment = NSTextAlignmentCenter;
        noNotificationsLabel.text = @"No notifications";
        
        UIColor *grayCustomColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        noNotificationsLabel.textColor = grayCustomColor;
        noNotificationsLabel.font= [UIFont fontWithName:@"Lato-Regular" size:25.0];
        
        [view addSubview:noNotificationsImage];
        [view addSubview:noNotificationsLabel];
        
    }else{
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 100, width, height) style:UITableViewStylePlain];
        
        self.tableView = tableView;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        [view addSubview:self.tableView];
    }
    
    CGRect navBarFrame = CGRectMake(0, 0,self.view.frame.size.width, 100);
    
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:navBarFrame];
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"Notifications"];
    [navbar setItems:@[navItem]];
    NSDictionary *attributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],
                               NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:30.0]};
    navbar.titleTextAttributes = attributes;
    
    
    UIColor *blueCustomColor = [UIColor colorWithRed:0.0625 green:0.418 blue:0.7773 alpha:1];
    UIColor *greenCustomColor = [UIColor colorWithRed:0.179 green:0.785 blue:0.4219 alpha:1];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = navBarFrame;
    gradient.colors = [NSArray arrayWithObjects:(id)blueCustomColor.CGColor, (id)greenCustomColor.CGColor, nil];
    [navbar.layer insertSublayer:gradient atIndex:1];
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1,0);
    
    [view addSubview:navbar];
    
    self.view = view;
}

-(NSArray*)getInfo{
    NSError *error = nil;
    
    NSString *lookUpString  = [NSString stringWithFormat:@"https://www.youlocalapp.com/api/notifications/load/?largeScreen&token=f2908658dc92d32a491d2e5b30aad86e"];
    
    
    lookUpString = [lookUpString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    
    NSArray* allNotifications = [jsonDict objectForKey:@"notifications"];
    NSMutableArray *onlyNeededNotifications = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< allNotifications.count; i++) {
        
        NSString *notificationType =  [allNotifications[i] objectForKey:@"notificationType"];
        if([notificationType  isEqual: @"Comment"] || [notificationType isEqual: @"Photo like"] || [notificationType  isEqual: @"Message like"] ){
            [ onlyNeededNotifications  addObject: allNotifications[i] ];
        }
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"notificationDate"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedNotifications = [onlyNeededNotifications sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedNotifications;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 131;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return notifications.count;
}

- (NSString*)compareNotificationDate:(NSDate*)notificationDate andCurrentDate:(NSDate*)currentDate {
    
    NSTimeInterval secondsBetweenDates = [currentDate timeIntervalSinceDate:notificationDate];
    
    int daysBetweenDates = secondsBetweenDates / 86400;
    
    if (daysBetweenDates <1 ) {
        
        int hours = secondsBetweenDates/3600;
        
        if (hours<1) {
            return [NSString stringWithFormat:@"%dm",(int)(secondsBetweenDates / 60)];
        }else{
            return [NSString stringWithFormat:@"%dh",hours];
        }
        
    }else if(daysBetweenDates< 30){
        return [NSString stringWithFormat:@"%dd",daysBetweenDates];
    }else if(daysBetweenDates >=30 &&daysBetweenDates<365){
        return [NSString stringWithFormat:@"%dm",daysBetweenDates/30];
        
    }else{
        return [NSString stringWithFormat:@"%dy",daysBetweenDates/365];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomTableCell *cell = (CustomTableCell * )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    
    id currentNotification =[notifications objectAtIndex:indexPath.row];
    cell.userNameLabel.text = [currentNotification objectForKey:@"fullname"];
    
    UIImage *image;
    
    id avatarObject = [currentNotification objectForKey:@"photo"];
    
    if(avatarObject == nil){
        image = [UIImage imageNamed:@"avatar.png"];
    }else{
        NSString *avatarUrl = [avatarObject objectForKey:@"photo"];
        NSURL* aURL = [NSURL URLWithString:avatarUrl];
        NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
        image = [UIImage imageWithData:data];
    }
    
    cell.userImage.image = image;
    cell.userImage.layer.cornerRadius =25;
    cell.userImage.layer.masksToBounds = YES;
    
    cell.notification.text = [currentNotification objectForKey:@"notificationType"];
    
    
    if([cell.notification.text  isEqual: @"Comment"]){
        cell.notification.text= @"commented your post:";
        cell.notificationDescription.text = @"Well, I couldn't find the comment in the JSON";
        cell.likeOrCommentImage.image=[UIImage imageNamed:@"icon-notifications-comment.png"];
    }else if([cell.notification.text  isEqual: @"Photo like"] || [cell.notification.text  isEqual: @"Message like"]){
        cell.notificationDescription.text = @"";
        NSArray *users = [currentNotification objectForKey:@"users"];
        if(users.count>1){
            NSString *numberOfOtherUsers = [NSString stringWithFormat:@" and %lu others",(unsigned long)users.count];
            cell.userNameLabel.text  = [cell.userNameLabel.text stringByAppendingString:numberOfOtherUsers];
        }
        if([cell.notification.text  isEqual: @"Photo like"]){
            cell.notification.text = @"liked your photo";
        }else{
            cell.notification.text = @"liked your post";
        }
        
        cell.likeOrCommentImage.image=[UIImage imageNamed:@"icon-notifications-like.png"];
    }
    
    cell.notificationDescription.lineBreakMode = NSLineBreakByWordWrapping;
    cell.notificationDescription.numberOfLines = 0;
    cell.timerImage.image = [UIImage imageNamed:@"icon-time.png"];
    
    NSString *dateStr = [currentNotification objectForKey:@"notificationDate"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
    NSDate *notificationDate = [dateFormat dateFromString: dateStr];
    NSDate *currentDate = [NSDate date];
    NSString *timePassed =   [self compareNotificationDate:notificationDate andCurrentDate:currentDate];
    
    cell.timerLabel.text = timePassed;
    
    
    return cell;
}

- (void)viewDidUnload {
    self.tableView = nil;
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
