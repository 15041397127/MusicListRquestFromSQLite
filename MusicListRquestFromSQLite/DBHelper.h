//
//  DBHelper.h
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject
+(DBHelper *)shareSqlite;

//打开数据库
-(void)openDB;

//关闭数据库;
-(void)closeDB;

//插入信息
-(void)insertMusicList:(MusicModel *)musicList;

//删除信息
-(void)deleteMusicList;

//更新信息
-(void)updataMusicList:(NSString *)name singer:(NSString *)singer  picUrl:(NSString *)picUrl;

//查找

-(NSMutableArray *)selectAllMusic;


@end
