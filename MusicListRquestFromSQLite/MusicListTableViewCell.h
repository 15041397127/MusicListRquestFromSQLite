//
//  MusicListTableViewCell.h
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

-(void)requstDataFromHttp:(MusicModel *)model;
@end
