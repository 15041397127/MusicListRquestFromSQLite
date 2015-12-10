//
//  HttpRequestData.m
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "HttpRequestData.h"

@implementation HttpRequestData
+(HttpRequestData *)shareInstance{
    static HttpRequestData *HrData=nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
       
        HrData = [[HttpRequestData alloc]init];;
    });
    return HrData;
}

#pragma mark 获取数据
-(void)muiscUrl:(NSString *)url requestDataBlock:(void (^)(NSArray *))block{
    NSMutableArray *listArray=[NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *arr =[NSArray arrayWithContentsOfURL:[NSURL URLWithString:MusicListUrl]];
        for (NSDictionary * dic in arr) {
            MusicModel *model=[[MusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [[DBHelper shareSqlite]insertMusicList:model];
            [listArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(listArray);
        });
    });
}



@end
