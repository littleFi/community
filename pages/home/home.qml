<view id="container">
    <image src="../../images/home/home-bg.png" class="bg"></image>
    <view class="community absolute column" bindtap="center">
        <image src="../../images/home/center.png" class="center"></image>
        <text class="name">社区中心</text>
    </view>

    <view class="rank absolute column" bindtap="rank">
        <image src="../../images/home/rank.png" class="rank-icon"></image>
        <text class="name rank-name">社区榜</text>
    </view>

    <view class="sleep absolute column">
        <image src="../../images/home/mian.png" class="sleep-icon"></image>
        <text class="name sleep-name">失眠馆</text>
    </view>

    <view class="people absolute">
        <view class="cont-list">
            <text class="circle">{{home.allAmount}}</text>
            <view class="cont">
                <image src="../../images/home/people-icon.png" class="people-icon"></image>
                <text class="cont-desc">社区人口</text>
            </view>
        </view>
        <view class="cont-list">
            <image src="../../images/home/clock.png" class="clock"></image>
            <view class="cont">
                <text class="cont-desc" style="font-size:22rpx">{{month}}月{{day}}号 星期{{week}}</text>
            </view>
        </view>
    </view>
    <view class="view absolute">
        <view class="cont-list">
            <text class="circle">{{home.dailyAmount}}</text>
            <view class="cont">
                <image src="../../images/home/view.png" class="view-icon"></image>
                <text class="cont-desc">今日访客</text>
            </view>
        </view>
    </view>
</view>


<!--授权登录-->
<view class="dialog-bg" qq:if="{{auth}}"></view>
<view class="auth" qq:if="{{auth}}">
    <text class="auth-title color">QQ登录</text>
    <text class="auth-desc color">授权使用QQ头像和昵称</text>
    <text class="auth-desc color">大家才能和你一起玩哦~</text>
    <button open-type="getUserInfo" bindgetuserinfo="auth" class="auth-btn">QQ登录</button>
</view>