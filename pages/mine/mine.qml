<view class="container column">
    <view class="bg">
        <image src="{{headImg}}" class="people-head"></image>
    </view>
    <view class="mine-content column" qq:if="{{mine}}">
        <text class="nickName">昵称({{mine.realName}})</text>
        <text class="mine-id">雅言：ID{{mine.userId}}</text>
        <text class="mine-item">{{mine.schoolName}}</text>
        <text class="mine-item">{{mine.departmentName}}</text>
        <view>
            <image src="../../images/address.png" class="address-icon"></image>
            <text style="font-size:30rpx;">{{mine.province}}{{mine.city}}</text>
        </view>
    </view>
    <view class="mine-content column" style="min-height: 300rpx" qq:else>
        <text style="color: #999;font-size: 32rpx">暂无个人详细信息</text>
    </view>
    <view class="hr"></view>
    <view class="expires column">
        <view class="tab-list row">
            <text class="tab-active">个人简介</text>
            <text class="tab">个人信息</text>
        </view>
        <view class="mine-expires">
            <!--<textarea name="content" show-confirm-bar="true" class="mine-cont" value="{{content}}" bindconfirm='updateIntroduction' placeholder-class="placeholder" auto-height placeholder="分享新鲜事" />-->
            <text class="mine-cont">{{content}}</text>
        </view>
    </view>

    <button open-type="share" share-type="3" class="btn">分享主页</button>
</view>