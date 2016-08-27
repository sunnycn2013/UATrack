UATrack
====




## 一、版本历史

## 二、UATrack 使用规范

### 2.1 libUATrack.a导入说明

UATrack 统计SDK设计初衷暂时只作为一个上报数据工具而存在，SDK不涉及app相关的业务，由app调用SDK并将需要上报的参数传入，之后SDK会讲数据最终上报到大数据后台。

下面先介绍一下SDK接入流程

(1)、导入libUATrack.a文件

&nbsp;&nbsp;&nbsp;&nbsp;下载工程, Xcode 打开工程,选择target->UniversalLib 进行Commond + B 编译，编译成功后，在Products-> libUATrack.a 下右键 show in finder,

找到Release-universal文件夹如下：

```

-Release-universal
--libUATrack.a
---include
----UATrack

```

将libUATrack.a 文件copy到UATrack文件夹下，然后将整个UATrack文件夹一起拖拽入要引用的工程(一个a文件，两个头文件)，拖拽时间切记勾选copy。

(2)、引入动态库

打开工程设置target->Build Phases->Link Binary With Libraries,添加一下动态库

```

Security.framework
Libsqlite3.dylib
SystemConfiguration.framework
libz.1.2.5.dylib
libsqlite3.dylib

```

(3)、 设置加载项命令

打开工程target->Build seting->other link flags

追加项：

```
-force_load
$(SRCROOT)/XXX/UATrack/libUATrack.a

```


(4)、在项目的AppDelegate.m文件下，引入头文件UATrack.h, 在application:didFinishLaunchingWithOptions中进行以下初始化工作，

```
    [UATrack startWithAppkey:@""];
    [UATrack setAppVersion:1];
    [UATrack setAppChannel:@"apple_store"];
    [UATrack setLogEnable:YES]

```

Commond+B 编译通过，则SDK倒入成功... 



