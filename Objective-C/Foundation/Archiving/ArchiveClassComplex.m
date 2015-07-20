@interface ArchiveClassComplex : NSObject
{
    NSMutableArray *nodes;
    NSString *string;
    int integer;
}
+ new;
+ newNode1;
+ newNode2;
- initComplexData1;
- initComplexData2;
- initWithString:(NSString *)theString andInteger:(int)theInteger;
@end

@implementation ArchiveClassComplex
+ new
{
    return OOB_AUTORELEASE([[self alloc] initComplexData1]);
}

+ newNode1
{
    return OOB_AUTORELEASE([[self alloc] initComplexData2]);
}

+ newNode2
{
    return OOB_AUTORELEASE([[self alloc] init]);
}


- initComplexData1
{
    int i = 0;

    nodes = [NSMutableArray array];
    string = @"level1";
    integer = 1;
    for (i = 0; i < 10; i++) {
        [nodes addObject:[ArchiveClassComplex newNode1]];
    }
    return self;
}

- initComplexData2
{
    int i = 0;

    nodes = [NSMutableArray array];
    string = @"level2";
    integer = 2;
    for (i = 0; i < 3; i++) {
        [nodes addObject:[ArchiveClassComplex newNode2]];
    }
    return self;
}

- init
{
    [super init];
    return [self initWithString:@"archiveTest" andInteger:23];
}

- initWithString:(NSString *)theString andInteger:(int)theInteger
{
    nodes = nil;
    integer = theInteger;
    string = theString;
    return self;
}

- (int)integer 
{
    return integer;
}

- (NSString *)string
{
    return string;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:string];
    [coder encodeValueOfObjCType:@encode(typeof(integer)) at:&integer];
    [coder encodeObject:nodes];
}

- initWithCoder:(NSCoder *)decoder
{
    string = [decoder decodeObject];
    [decoder decodeValueOfObjCType:@encode(typeof(integer)) at:&integer];
    nodes = [decoder decodeObject];
    return self;
}
@end
