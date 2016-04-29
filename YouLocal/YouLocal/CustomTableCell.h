#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property (strong, nonatomic) UIImageView *userImage;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UIImageView *likeOrCommentImage;
@property (strong, nonatomic) UILabel *notification;
@property (strong, nonatomic) UILabel *notificationDescription;
@property (strong, nonatomic) UIImageView *timerImage;
@property (strong, nonatomic) UILabel *timerLabel;
@property (strong, nonatomic) UIView *bottomLineView;

@end
