<view class="container">
    <view class="bg">
        <view class="people">
            <image src="{{headImg}}" class="people-head"></image>
            <view class="people-cont" bindtap="goToMine">
                <text class="people-desc people-name">{{nickName}}</text>
                <text class="people-desc" style="margin-top: 50rpx;">{{label || '暂无标签'}}</text>
            </view>
        </view>
        <view class="main-container">
            <view class="item-list">
                <text class="item-num">{{people.corpNum}}</text>
                <text class="item-font">社区</text>
            </view>
            <view class="item-list">
                <text class="item-num">{{people.collectNum}}</text>
                <text class="item-font">动态</text>
            </view>
            <view class="item-list">
                <text class="item-num">{{people.visitorNum}}</text>
                <text class="item-font">访客</text>
            </view>
        </view>
    </view>

    <view class="list-cont">
        <view class="list">
            <view class="weui-cell weui-cell_access" >
            <view class="weui-cell__bd">
                <view class="item-name">我的动态</view>
            </view>
            <view class="weui-cell__ft weui-cell__ft_in-access"></view>
            </view>
        </view>
        <view class="list">
            <view class="weui-cell weui-cell_access" >
                <view class="weui-cell__bd">
                    <view class="item-name">成为认证用户</view>
                </view>
                <view class="weui-cell__ft weui-cell__ft_in-access"></view>
            </view>
        </view>
        <view class="list" style="position: relative">
            <button open-type="share" share-type="3" class="btn"></button>
            <view class="weui-cell weui-cell_access" >
                <view class="weui-cell__bd">
                    <view class="item-name">邀请好友</view>
                </view>
                <view class="weui-cell__ft weui-cell__ft_in-access"></view>
            </view>
        </view>
        <view class="list">
            <view class="weui-cell weui-cell_access" >
                <view class="weui-cell__bd">
                    <view class="item-name">意见反馈</view>
                </view>
                <view class="weui-cell__ft weui-cell__ft_in-access"></view>
            </view>
        </view>
    </view>
</view>

<!--授权登录-->
<view class="dialog-bg" qq:if="{{!auth}}"></view>
<view class="auth" qq:if="{{!auth}}">
    <text class="auth-title color">QQ登录</text>
    <text class="auth-desc color">授权使用QQ头像和昵称</text>
    <text class="auth-desc color">大家才能和你一起玩哦~</text>
    <button open-type="getUserInfo" bindgetuserinfo="auth" class="auth-btn">QQ登录</button>
</view>