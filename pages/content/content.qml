<view class="container">
    <view class="message-content">
        <!--个人部分-->
        <view class="person-content">
            <view class="person-left">
                <image src="{{corporationInfo.headUrl}}" class="person-head"></image>
                <view class="name-content">
                    <text class="main-name">{{corporationInfo.name}}</text>
                    <text class="person-tip">{{corporationInfo.briefIntroduction}}</text>
                </view>
            </view>

            <view class="person-right" bindtap="follow">
                <image src="../../images/follow.png" class="follow-icon"></image>
                <text class="follow-font">{{corporationInfo.focus ? '已关注' : '关注'}}</text>
            </view>
        </view>

    </view>
</view>


<view class="article-content">
    <!--文章内容-->
    <view style="flex-direction:column">
        <text class="article-title">{{article.title}}</text>
        <view class="article-author">
            <image src="../../images/author-icon.png" class="author-icon"></image>
            <text class="font">{{article.nickName}}</text>
            <image src="../../images/time-icon.png" class="author-icon" style="margin-left: 40rpx"></image>
            <text class="font">{{article.viewTime}}</text>
        </view>
        <import src="../../plugins/wxParse/wxParse.wxml" />
        <template is="wxParse" data="{{wxParseData:detailInfo.nodes}}">
        </template>
    </view>

    <!--文章留言-->
    <view class="comment-container">
        <view class="comment-list" qq:for="{{comments}}" qq:key="{{index}}">
            <image src="../../images/head@x2.png" class="head-image"></image>
            <view class="comment-content">
                <view class="column" style="justify-content: space-between">
                    <text class="comment-name">{{item.nickName}}</text>
                    <image src="../../images/content/ellipsis.png" class="ellipsis" bindtap="report" style="width: 30rpx;height: 30rpx"></image>
                </view>
                <text class="comment-cont">{{item.content}}</text>
                <view class="more-reply" qq:if="{{item.secondCommentCount > 0}}">
                    <text class="all-font">查看全部{{item.secondCommentCount}}条回复</text>
                    <image src="../../images/all-icon.png" class="all-icon"></image>
                </view>
                <!--<view class="all-cont">-->
                <!--<text class="all-font">展开全部</text>-->
                <!--<image src="../../images/all-icon.png" class="all-icon"></image>-->
                <!--</view>-->
                <view class="reply-content">
                    <text class="reply-time">{{item.viewTime}}</text>
                    <view>
                        <image src="../../images/comment-like.png" class="comment-icon"></image>
                        <text class="num">150</text>
                        <image src="../../images/comment-notlike.png" class="comment-icon" style="margin-left: 20rpx"></image>
                        <text class="num">150</text>
                        <image src="../../images/comment-icon.png" class="comment-icon"></image>
                        <image src="../../images/comment-share.png" class="comment-icon"></image>
                    </view>
                </view>
            </view>
        </view>
    </view>
</view>

<!--评论-->
<view class="comment-fixed">
    <input type="text" value="{{content}}" confirm-type="done" bindconfirm="writeComment" class="message-input" placeholder="请写入评论内容" placeholder-class="placeholder" />
    <view class="image-cont">
        <view class="icon-content" bindtap="like">
            <image src="../../images/like.png" class="comment-image"></image>
            <text class="icon-num" qq:if="{{article.praiseCount > 0}}">{{article.praiseCount}}</text>
        </view>
        <view class="icon-content" >
            <image src="../../images/notlike.png" class="comment-image"></image>
            <text class="icon-num">{{article.watchCount}}</text>
        </view>
        <view class="icon-content">
            <image src="../../images/comment.png" class="comment-image"></image>
            <text class="icon-num" qq:if="{{comments.length > 0}}">{{comments.length}}</text>
        </view>
        <view class="icon-content">
            <image src="../../images/zhuan.png" class="comment-image"></image>
        </view>
    </view>
</view>

<!--弹出框-->
<view class="dialog-bg" qq:if="{{dialog}}"></view>
<view class="dialog" qq:if="{{dialog}}">
    <view class="head-bg">
        <text class="complaint">举报</text>
    </view>
    <view class="input-cont">
        <textarea placeholder="举报详细说明:(必填)" placeholder-class="complaint-placeholder" name="textarea" class="textarea" />
    </view>
    <view class="btn-content">
        <view class="btn com-bg">举报</view>
        <view class="btn cancel-bg" bindtap="cancel">取消</view>
    </view>
</view>


<!--弹出框-->
<view class="dialog-bg" qq:if="{{dialog}}"></view>
<view class="dialog" qq:if="{{dialog}}">
    <view class="head-bg">
        <text class="complaint">我很不爽</text>
    </view>
    <view class="input-cont">
        <radio-group class="radio-group" bindchange="radioChange">
            <view class="angry-list" qq:for="{{options}}">
                <label class="radio">
                    <radio value="{{item.name}}" checked="{{item.checked}}" />
                    <text style="margin-left: -15rpx">{{item.value}}</text>
                </label>
            </view>
        </radio-group>
    </view>
    <view class="btn-content">
        <view class="btn com-bg">提交</view>
        <view class="btn cancel-bg" bindtap="cancel">取消</view>
    </view>
</view>