<view class="container column">
    <view class="dynamic-list column" qq:for="{{dynamic}}" qq:key="{{index}}" bindtap="detail" data-id="{{item.id}}">
        <view class="people-cont row">
            <view class="row">
                <image src="{{item.headUrl}}" class="people-head"></image>
                <view class="people-desc column">
                    <text class="name font28">{{item.nickName}}</text>
                    <text class="position font28">{{item.label || '无职位'}}</text>
                </view>
            </view>
            <text class="time">{{item.timestamp || '3分钟前'}}</text>
        </view>
        <view class="dynamic-cont column">
            <text class="cont font28" qq:if="{{item.content}}">{{item.content}}</text>
            <view class="row images">
                <image mode="center" src="{{value}}" catchtap="preview" data-parent="{{index}}" data-index="{{idx}}" qq:for-index="idx" class="cont-image" qq:if="{{value}}" qq:for="{{item.imgUrl}}" qq:for-item="value"></image>
            </view>
        </view>
        <view class="dynamic-op row">
            <view class="op-item">
                <image src="../../images/dynamic/share.png" class="dynamic-icon"></image>
                <text class="icon-font font28">分享</text>
            </view>
            <view class="op-item">
                <view class="number-container">
                    <image src="../../images/dynamic/reply.png" class="dynamic-icon"></image>
                    <text class="number" qq:if="{{ item.commentCount > 0}}">{{item.commentCount}}</text>
                </view>
                <text class="icon-font font28">评论</text>
            </view>
            <view class="op-item" catchtap="praise" data-index="{{index}}">
                <view class="number-container">
                    <image src="../../images/dynamic/like.png" class="dynamic-icon"></image>
                    <text class="number" qq:if="{{ item.praiseCount > 0}}">{{item.praiseCount}}</text>
                </view>

                <text class="icon-font font28">点赞</text>
            </view>
        </view>
    </view>

    <image src="../../images/dynamic/publish.png" class="publish-btn" bindtap="goToPublish"></image>
</view>