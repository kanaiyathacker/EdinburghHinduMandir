//
//  GalleryData.h
//  Hindu Mandir
//
//  Created by kanaiyathacker on 13/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryData : NSObject
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *imageUrl;
@property (nonatomic , strong) NSString *albumID;
@property (nonatomic , strong) NSData *imageData;

@end
