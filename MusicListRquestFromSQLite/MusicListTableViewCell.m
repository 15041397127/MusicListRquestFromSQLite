//
//  MusicListTableViewCell.m
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "MusicListTableViewCell.h"

@implementation MusicListTableViewCell

-(void)requstDataFromHttp:(MusicModel *)model{
    self.nameLabel.text=model.name;
    self.singerLabel.text=model.singer;
    [self.PicImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
