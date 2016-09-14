# IOS推流SDK
###   文件集成:
    1.添加libLiveVideoCoreSDK.a(在lib目录下) , 添加库文件搜索路径
    2.添加libz.tbd , libstdc++.tbd , CoreMedia.framework , AVFoundation.framework , VideoToolbox.framework , AudioToolbox.framework , OpenGLES.framework , CoreGraphics.framework
    3.添加头文件VCSimpleSession.h , LiveVideoCorSDK.h ,文件在lib目录下
###   使用说明:
    1.在需要使用sdk的文件中引入LiveVideoCorSDK.h
    2.在app启动入口设置与cdn相关参数:
        [LiveVideoCoreSDK initEnv:@{
                                        @"dnsParserUrl":@"http://httpdnslej.satadn.com/down",
                                                                        @"key":@"cztv"
                                                                                }];
    //dnsParserUrl 是分配的dns解析的服务地址
    //key是分配的用于防盗链的key
	   3.初始化：
    - (void)LiveInit:(NSURL*)rtmpUrl Preview:(UIView*)previewView;
    或者
    - (void)LiveInit:(NSURL*)rtmpUrl Preview:(UIView*)previewView VideSize:(CGSize)videSize BitRate:(LIVE_BITRATE)iBitRate FrameRate:(LIVE_FRAMERATE)iFrameRate;
	4.开始推流
- (void)connect;

    5.结束推流
    - (void)disconnect;

    6.处理推流 SDK 状态变化事件
    实现协议LIVEVCSessionDelegate
    状态说明:
    typedef NS_ENUM(NSInteger, VCSessionState)
    {
	VCSessionStateNone, ///推流 SDK 的初始状态/
	VCSessionStatePreviewStarted,//推流 SDK 开始出现预览画面
	VCSessionStateStarting,//推流 SDK 开始连接服务器
	VCSessionStateStarted,//推流已经开始
	VCSessionStateEnded,//推流已经结束
	VCSessionStateError//推流 SDK 出错

    };

    7.切换前后摄像头
    - (void)setCameraFront:(Boolean)bCameraFrontFlag; 

###   注意事项：
	1.iOS9引入了新特性App Transport Security (ATS)，要求App内访问的网络必须使用 HTTPS协议,现在sdk的DNS解析用的是http，所以需要在app中作如下设置：
	    1.在Info.plist中添加NSAppTransportSecurity类型Dictionary。
	    2.在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
	2.请用真机测试运行
	3.demo目录下是可以运行的测试项目
###   主要功能：
     1. 编码方式：ios8.0以上版本H264,AAC 硬件编码
     2. 码率： 智能码率调整算法，根据网络状况自动调节码率。
     3. 滤镜： 实时性超强的美白，磨皮功能
     4. 加速： gpu加速，渲染
     5. 稳定性： 系统自动断线重传，低cpu,低内存。
     6. 辅助功能：支持语音，视频混合。
     7. 图像质量：支持720p一下格式
     8. 摄像头： 支持前后摄像头实时切换
     9. 低延时： 在rtmp-nginx + srs播放器网络状况良好情况下1秒延时，网络状况差时延时能自动缩小到3秒内。
     10. 丢包策略： 当发送队列超过阈值时，自动丢掉gop,防止出现马赛克。
     
      	
