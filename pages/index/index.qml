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

        <!--留言部分-->
        <view class="message-container">
            <view class="message-title">
                <view>
                    <text class="left-icon"></text>
                    <text class="title">校园留言</text>
                </view>
                <view class="right-cont">
                    <text class="all">查看全部</text>
                    <image src="../../images/right.png" class="right-icon"></image>
                </view>
            </view>

            <view class="message-main">
                <swiper class="swiper_container" vertical="true" autoplay="auto" circular="true" interval="2000" display-multiple-items="2">
                    <block qq:for="{{messageList}}" qq:key="{{index}}">
                        <swiper-item>
                            <view class="message-list" style="margin-left: {{ index%2 == 0 ? '120rpx' : ''}}">
                                <image src="{{item.headUrl}}" class="message-headImg"></image>
                                <text class="message-font">{{item.nickName}}：{{item.content}}</text>
                            </view>
                        </swiper-item>
                    </block>
                </swiper>
            </view>

            <view class="set-message">
                <image src="{{headImg}}" class="head-img-x2"></image>
                <input type="text" confirm-type="done" bindconfirm="writeMessage" class="message-input" placeholder="我也要留言..." placeholder-class="placeholder" />
            </view>
        </view>

        <!--社团信息集合-->
        <view class="person-all">
            <view class="info-list">
                <text class="active">{{corporationInfo.articlesCount}}</text>
                <text class="active-num">文章</text>
            </view>
            <view class="info-list">
                <text class="info-title">{{corporationInfo.dynamicsCount}}</text>
                <text class="info-num">动态</text>
            </view>
            <view class="info-list">
                <text class="info-title">{{corporationInfo.messageCount || '0'}}</text>
                <text class="info-num">留言</text>
            </view>
            <view class="info-list">
                <text class="info-title">{{corporationInfo.membersCount}}</text>
                <text class="info-num">成员</text>
            </view>
        </view>
    </view>
</view>

<!--新闻列表-->
<view class="news-content">
    <view class="news-title-cont">
        <view>
            <text class="news-icon"></text>
            <text class="news-title">时间</text>
        </view>
        <!--<view class="right-cont">-->
            <!--<text class="sort">排序</text>-->
            <!--<image src="../../images/sort.png" class="sort-icon"></image>-->
        <!--</view>-->
    </view>

    <view class="news-list">
        <view class="list" qq:for="{{articles}}" qq:key="{{index}}" bindtap="detail" data-id="{{item.id}}">
            <view class="">
                <!--../../images/news-image.jpg-->
                <image src="{{item.imgUrl}}" class="news-image"></image>
                <view class="news-info">
                    <text class="news-title">{{item.title}}</text>
                </view>
            </view>

            <view class="news-author">
                <view>
                    <text class="author">作者昵称@{{item.nickName}}</text>
                    <text class="time">{{item.timeDiff}}</text>
                </view>
                <view>
                    <view class="icon-content" catchtap="like" data-id="{{item.id}}" data-index="{{index}}">
                        <image src="../../images/like.png" class="comment-icon"></image>
                        <text class="icon-num" qq:if="{{item.praiseCount > 0}}">{{item.praiseCount}}</text>
                    </view>
                    <view class="icon-content" >
                        <image src="../../images/notlike.png" class="comment-icon"></image>
                        <text class="icon-num" qq:if="{{item.watchCount > 0}}">{{item.watchCount}}</text>
                    </view>
                    <view class="icon-content">
                        <image src="../../images/comment.png" class="comment-icon"></image>
                        <text class="icon-num" qq:if="{{item.commentCount > 0}}">{{item.commentCount}}</text>
                    </view>
                </view>
            </view>
        </view>
    </view>
</view>

<view class="share-content">
    <view class="share-btn">
        <image src="../../images/share.png" class="share-icon"></image>
        <button open-type="share" class="share-font" share-type="3">分享</button>
    </view>
</view>
