#import "UserGalleryUpload.h"
#import "DataManager.h"

@implementation UserGalleryUpload
@synthesize objConnection,delegate;

+(void)clearUserGalleryUpLoad
{
    NSArray *objs=[UserGalleryUpload allObjects];
    
    bool hasChanged=false;
    for(UserGalleryUpload *obj in objs)
    {
        if(obj.desc.length==0)
        {
            [obj markDeleted];
            hasChanged=true;
        }
        else if(obj.enumStatus==USER_GALLERY_UPLOAD_STATUS_NEXT)
        {
            obj.status=@(USER_GALLERY_UPLOAD_STATUS_LISTED);
            hasChanged=true;
        }
            
    }
    
    if(hasChanged)
        [[DataManager shareInstance] save];
}

+(NSArray *)allObjects
{
    NSArray *array=[super allObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserGalleryUpload_SortOrder ascending:true]]];
    
    return array;
}

+(UserGalleryUpload *)makeWithIDShop:(int)idShop image:(UIImage *)image
{
    UserGalleryUpload *obj=[UserGalleryUpload insert];
    
    obj.idShop=@(idShop);
    obj.image=UIImageJPEGRepresentation(image, 1);
    obj.sortOrder=@(0);
    
    NSArray *array=[UserGalleryUpload allObjects];
    if(array.count>0)
        obj.sortOrder=[array valueForKeyPath:[NSString stringWithFormat:@"@max.%@",UserGalleryUpload_SortOrder]];
    
    return obj;
}

-(enum USER_GALLERY_UPLOAD_STATUS)enumStatus
{
    switch (self.status.integerValue) {
        case USER_GALLERY_UPLOAD_STATUS_LISTED:
            return USER_GALLERY_UPLOAD_STATUS_LISTED;
            
        case USER_GALLERY_UPLOAD_STATUS_NEXT:
            return USER_GALLERY_UPLOAD_STATUS_NEXT;
            
        default:
            return USER_GALLERY_UPLOAD_STATUS_NEXT;
    }
}

@end
