//
//  SOAPConnection.m
//  MobilePos
//
//  Created by lessu on 14-3-21.
//  Copyright (c) 2014年 lessu. All rights reserved.
//

#import "SOAPConnection.h"
#import "RegexKitLite.h"
@implementation SOAPConnection
- (NSString *)makeParamSoapBody:(NSDictionary *)params{
    NSMutableString* resultString = [NSMutableString string];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop) {
        [resultString appendFormat:@"<%@>",key];

        if (IS_STRING(obj)) {
            [resultString appendString:obj];
        }else if (IS_DICTIONARY(obj)){
            [resultString appendString:[self makeParamSoapBody:obj]];
        }else if (IS_ARRAY(obj)){
            for (NSInteger i = 0; i <  ARRAY_CAST(obj).count; i++) {
                [resultString appendString:[self makeParamSoapBody:obj[i]]];
            }
        }else{

            [resultString appendFormat:@"%@",obj];

        }
        [resultString appendFormat:@"</%@>\n",key];

    }];
    return resultString;
    
}
- (void)prepareForRequest{
    [super prepareForRequest];
    NSMutableString *postSoap =[NSMutableString string];
    [postSoap appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    [postSoap appendString:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"];
    [postSoap appendString:@"<soap:Body>"];
    [postSoap appendFormat:@"<%@ xmlns=\"%@\">",self.soapAction,self.soapActionUrl];
//    [postSoap appendFormat:@"<%@Req>",self.soapAction];

    [postSoap appendString:[self makeParamSoapBody:self.params]];
    
//    [postSoap appendFormat:@"</%@Req>",self.soapAction];
    [postSoap appendFormat:@"</%@>",self.soapAction];
    [postSoap appendString:@"</soap:Body>"];
    [postSoap appendString:@"</soap:Envelope>"];

    [self setPostBody:[[postSoap dataUsingEncoding:NSUTF8StringEncoding] mutableCopy]];
//    [self addRequestHeader:@"Host" value:@"www.scetia.com"];
    [self addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [self addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@/%@", self.soapActionUrl,self.soapAction]];
    [self setRequestMethod:@"POST"];


}
- (void)onConnectionCompelte:(NSString *)responseString{
    responseString = [responseString stringByMatching:@">\\{.+\\}</"];
    responseString = [responseString stringByReplacingOccurrencesOfString:@">{" withString:@"{" ];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"}</" withString:@"}" ];
    [super onConnectionCompelte:responseString];
}

@end
