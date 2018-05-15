//
//  UIViewController+DZNEmptyDataSet.m
//  UseCategoryDemo
//
//  Created by litianqi on 16/5/11.
//  Copyright © 2016年 updown. All rights reserved.
//

#import "UIViewController+DZNEmptyDataSet.h"
#import <objc/runtime.h>
#import "UIColor+HexString.h"
static  NSString * const DefaultErrorText =@"加载失败,点击重新加载";
static  NSString * const DefaultNodataText =@"没有内容~";

static  NSString * const DefaultUnKnowndataText =@"加载中~";


static char const * const DataStatusTypeKey = "DataStatusType";
static char const * const DataStatusUnknownTextKey = "DataStatusUnknownTextKey";
static char const * const DataStatusUnknownImgKey = "DataStatusUnknownImgKey";

static char const * const DataStatusErrorTextKey = "DataStatusErrorText";
static char const * const DataStatusErrorImgKey = "DataStatusErrorImgKey";


static char const * const DataStatusNoDataTextKey = "DataStatusNoDataText";

static char const * const DataStatusNoDataFontSizeKey = "DataStatusNoDataFontSize";
static char const * const DataStatusNoDataImgKey = "DataStatusNoDataImg";
static char const * const VerticalOffset = "VerticalOffset";
static char const * const DataStatusTextColorKey = "DataStatusTextColorKey";

@implementation UIViewController (DZNEmptyDataSet)

-(NSNumber*)dataStatusType{
    return objc_getAssociatedObject(self, DataStatusTypeKey);
}

-(void)setDataStatusType:(NSNumber*)dataStatusType{
    objc_setAssociatedObject(self, DataStatusTypeKey, dataStatusType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)dataStatusNoData_text_fontSize{
    return objc_getAssociatedObject(self, DataStatusNoDataFontSizeKey);
}

-(void)setDataStatusNoData_text_fontSize:(NSNumber *)dataStatusNoData_text_fontSize{
    objc_setAssociatedObject(self, DataStatusNoDataFontSizeKey, dataStatusNoData_text_fontSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dataStatusUnknown_text{
    return objc_getAssociatedObject(self, DataStatusUnknownTextKey);
}

- (void)setDataStatusUnknown_text:(NSString *)dataStatusUnknown_text{
    objc_setAssociatedObject(self, DataStatusUnknownTextKey, dataStatusUnknown_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStatusUnknown_img{
    return objc_getAssociatedObject(self, DataStatusUnknownImgKey);
}

- (void)setDataStatusUnknown_img:(NSString *)dataStatusUnknown_img{
    objc_setAssociatedObject(self, DataStatusUnknownImgKey, dataStatusUnknown_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(NSString*)dataStatusError_text{
    return objc_getAssociatedObject(self, DataStatusErrorTextKey);
}

-(void)setDataStatusError_text:(NSString *)dataStatusError_text{
    objc_setAssociatedObject(self, DataStatusErrorTextKey, dataStatusError_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStatusError_img{
    return objc_getAssociatedObject(self, DataStatusErrorImgKey);
}

- (void)setDataStatusError_img:(NSString *)dataStatusError_img{
    objc_setAssociatedObject(self, DataStatusErrorImgKey, dataStatusError_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(NSString *)dataStatusNoData_text{
    return objc_getAssociatedObject(self, DataStatusNoDataTextKey);
}

-(void)setDataStatusNoData_text:(NSString *)dataStatusNoData_text{
    objc_setAssociatedObject(self, DataStatusNoDataTextKey, dataStatusNoData_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)dataStatusNoData_img{
    return objc_getAssociatedObject(self, DataStatusNoDataImgKey);
}

-(void)setDataStatusNoData_img:(NSString *)dataStatusNoData_img{
    objc_setAssociatedObject(self, DataStatusNoDataImgKey, dataStatusNoData_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSNumber *)verticalOffset{
    return objc_getAssociatedObject(self, VerticalOffset);
}

-(void)setVerticalOffset:(NSNumber *)verticalOffset{
    objc_setAssociatedObject(self, VerticalOffset, verticalOffset, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStatusTextColor{
    return objc_getAssociatedObject(self, DataStatusTextColorKey);
}

- (void)setDataStatusTextColor:(NSString *)dataStatusTextColor{
    return objc_setAssociatedObject(self, DataStatusTextColorKey, dataStatusTextColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

#pragma mark --DZNEmptyDataSetDelegate
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor colorWithHexString:@"0xf2f2f2"];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString * imgUrl = @"";
    if ([self.dataStatusType integerValue] == DataStatusNoData) {
        imgUrl = @"unusual-empty";
        if (self.dataStatusNoData_img && self.dataStatusNoData_img.length > 0) {
            imgUrl = self.dataStatusNoData_img;
        }
        return [UIImage imageNamed:imgUrl];
    } else if ([self.dataStatusType integerValue] == DataStatusError) {
        imgUrl = @"unusual-badmood";
        if (self.dataStatusError_img && self.dataStatusError_img.length > 0) {
            imgUrl = self.dataStatusError_img;
        }
        return [UIImage imageNamed:imgUrl];
    }else if ([self.dataStatusType integerValue] == DataStatusNoKnown) {
        imgUrl = self.dataStatusUnknown_img ? self.dataStatusUnknown_img : imgUrl;
        return [UIImage imageNamed:imgUrl];
    }
    else
        return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    if ([self.dataStatusType integerValue] == DataStatusNoData) {
        text = self.dataStatusNoData_text;
        if (!text || text.length == 0) {
            text = DefaultNodataText;
        }
    }
    else if ([self.dataStatusType integerValue] == DataStatusError) {
        text = self.dataStatusError_text;
        if (!text || text.length == 0) {
            text = DefaultErrorText;
        }
    }
    else if ([self.dataStatusType integerValue] == DataStatusNoKnown){
        text = self.dataStatusUnknown_text;
        if (!text || text.length == 0) {
            text = DefaultUnKnowndataText;
        }
    }else if ([self.dataStatusType integerValue] == DataStatusOk){
        text = @"";
    }
    text = text ? text : @"";
    UIFont *font = [UIFont systemFontOfSize:16.f];
    if (self.dataStatusNoData_text_fontSize && [self.dataStatusNoData_text_fontSize integerValue]>0) {
        font = [UIFont systemFontOfSize:[self.dataStatusNoData_text_fontSize integerValue]];
    }
    UIColor * textColor = nil;
    if (self.dataStatusTextColor && self.dataStatusTextColor.length > 0) {
        textColor = [UIColor colorWithHexString:self.dataStatusTextColor];
    }else
        textColor = [UIColor colorWithHexString:@"0x969696"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.verticalOffset) {
        return [self.verticalOffset floatValue];
    }
    return 0 ;
}

@end

