#import "ScanCodeDecode.h"
#import "UserNotificationAction.h"

@implementation ScanCodeDecode
@synthesize imageSize,videoSize,textAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.imageSize=CGSizeZero;
    self.videoSize=CGSizeZero;
    
    return self;
}

+(ScanCodeDecode *)makeWithDictionary:(NSDictionary *)dict
{
    ScanCodeDecode *obj=[ScanCodeDecode insert];
    
    if([dict[@"header"] hasData])
    {
        obj.type=@(SCANCODE_DECODE_TYPE_HEADER);
        obj.text=[NSString makeString:dict[@"header"]];
    }
    else if([dict[@"bigText"] hasData])
    {
        obj.type=@(SCANCODE_DECODE_TYPE_BIGTEXT);
        obj.text=[NSString makeString:dict[@"bigText"]];
    }
    else if([dict[@"smallText"] hasData])
    {
        obj.type=@(SCANCODE_DECODE_TYPE_SMALLTEXT);
        obj.text=[NSString makeString:dict[@"smallText"]];
    }
    else if([dict[@"image"] hasData])
    {
        NSDictionary *image=dict[@"image"];
        obj.type=@(SCANCODE_DECODE_TYPE_IMAGE);
        obj.image=[NSString makeString:image[@"url"]];
        obj.imageWidth=[NSNumber makeNumber:image[@"width"]];
        obj.imageHeight=[NSNumber makeNumber:image[@"height"]];
    }
    else if([dict[@"video"] hasData])
    {
        NSDictionary *video=dict[@"video"];
        obj.type=@(SCANCODE_DECODE_TYPE_VIDEO);
        obj.video=[NSString makeString:video[@"url"]];
        obj.videoThumbnail=[NSString makeString:video[@"thumbnail"]];
        obj.videoWidth=[NSNumber makeNumber:video[@"width"]];
        obj.videoHeight=[NSNumber makeNumber:video[@"height"]];
    }
    else if([dict[@"buttons"] hasData])
    {
        NSArray *buttons=dict[@"buttons"];
        
        obj.type=@(SCANCODE_DECODE_TYPE_BUTTONS);
        
        int count=0;
        for(NSDictionary *button in buttons)
        {
            UserNotificationAction *action=[UserNotificationAction makeWithAction:button];
            action.color=[NSNumber makeNumber:button[@"color"]];
            action.sortOrder=@(count++);
            
            [obj addActionObject:action];
        }
    }
    else if([dict[@"linkToShare"] hasData])
    {
        obj.type=@(SCANCODE_DECODE_TYPE_SHARE);
        
        obj.linkShare=[NSString makeString:dict[@"linkToShare"]];
    }
    else
    {
        obj.type=@(SCANCODE_DECODE_TYPE_UNKNOW);
    }
    
    return obj;
}

-(enum SCANCODE_DECODE_TYPE)enumType
{
    switch ((enum SCANCODE_DECODE_TYPE)self.type.integerValue) {
        case SCANCODE_DECODE_TYPE_UNKNOW:
            return SCANCODE_DECODE_TYPE_UNKNOW;
            
        case SCANCODE_DECODE_TYPE_VIDEO:
            return SCANCODE_DECODE_TYPE_VIDEO;
            
        case SCANCODE_DECODE_TYPE_BIGTEXT:
            return SCANCODE_DECODE_TYPE_BIGTEXT;
            
        case SCANCODE_DECODE_TYPE_BUTTONS:
            return SCANCODE_DECODE_TYPE_BUTTONS;
            
        case SCANCODE_DECODE_TYPE_HEADER:
            return SCANCODE_DECODE_TYPE_HEADER;
            
        case SCANCODE_DECODE_TYPE_IMAGE:
            return SCANCODE_DECODE_TYPE_IMAGE;
            
        case SCANCODE_DECODE_TYPE_SMALLTEXT:
            return SCANCODE_DECODE_TYPE_SMALLTEXT;
            
        case SCANCODE_DECODE_TYPE_SHARE:
            return SCANCODE_DECODE_TYPE_SHARE;
    }
    
    return SCANCODE_DECODE_TYPE_UNKNOW;
}

-(NSArray *)actionObjects
{
    return [[super actionObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserNotificationAction_SortOrder ascending:true]]];
}

@end
