#import "CustomTableCell.h"

@implementation CustomTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect userImageFrame = CGRectMake(15,20,50,50);
        CGRect userNameFrame = CGRectMake(85,17,200,30);
        CGRect likeOrCommentImageFrame = CGRectMake(85,50,30,30);
        CGRect likeOrCommentLabelFrame = CGRectMake(120,50,250,30);
        CGRect notificationDescriptionFrame = CGRectMake(85,80,300,50);
        
        float width = [[UIScreen mainScreen] bounds].size.width;
        CGRect timerImageFrame = CGRectMake(width-80,20,20,20);
        CGRect timerLabelFrame = CGRectMake(width-47,20,35,20);
        UIColor*   blueColorForCommentOrLike = [UIColor colorWithRed:26/256.0  green:135/256.0 blue:171/256.0  alpha:1];
        
        self.userImage = [[UIImageView alloc ]initWithFrame:userImageFrame];
        self.userNameLabel = [[UILabel alloc] initWithFrame:userNameFrame];
        
        [self.userNameLabel setFont:[UIFont fontWithName:@"Lato-Black" size:22]];
        UIColor*   blueColorForUserName = [UIColor colorWithRed:18/256.0  green:108/256.0 blue:199/256.0  alpha:1];
        self.userNameLabel.textColor = blueColorForUserName;
        
        self.likeOrCommentImage = [[UIImageView alloc]initWithFrame:likeOrCommentImageFrame];
        
        self.notification = [[UILabel alloc]initWithFrame:likeOrCommentLabelFrame];
        self.notification.textColor = blueColorForCommentOrLike;
        [self.notification setFont:[UIFont fontWithName:@"Lato-Regular" size:21]];
        
        self.notificationDescription = [[UILabel alloc]initWithFrame:notificationDescriptionFrame];
        
        self.timerImage = [[UIImageView alloc]initWithFrame:timerImageFrame];
        
        self.timerLabel = [[UILabel alloc]initWithFrame:timerLabelFrame];
        self.timerLabel.textColor = [UIColor grayColor];
        
        float widthView = [[UIScreen mainScreen] bounds].size.width;
        self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0,125, widthView, 1)];
        self.bottomLineView.backgroundColor = [UIColor grayColor];
        
        [self addSubview: self.bottomLineView];
        [self addSubview: self.userNameLabel];
        [self addSubview: self.userImage];
        [self addSubview: self.likeOrCommentImage];
        [self addSubview: self.notification];
        [self addSubview: self.notificationDescription];
        [self addSubview: self.timerImage];
        [self addSubview: self.timerLabel];
    }
    
    return self;
}

@end
