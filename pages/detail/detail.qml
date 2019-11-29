<view class="container">
    <view class="detail-cont column">
        <view class="dynamic-people row">
            <view class="people-cont row">
                <image src="{{detail.headUrl}}" class="people-head"></image>
                <view class="people-desc column">
                    <text class="nickName">{{detail.nickName}}</text>
                    <text class="label">{{detail.label[0].label}}</text>
                </view>
            </view>
            <text class="time-font">3分钟前</text>
        </view>
        <view class="dynamic-cont column">
            <text qq:if="{{detail.content}}">{{detail.content}}</text>
            <view class="row images">
                <image mode="center" catchtap="preview" data-id="{{index}}" src="{{item}}" class="cont-image" qq:for="{{detail.imgUrl}}" qq:key="{{index}}" qq:if="{{item}}"></image>
            </view>
        </view>
        <view class="dynamic-op row">
            <view class="op-item" bindtap="share">
                <image src="../../images/dynamic/share.png" class="dynamic-icon"></image>
                <text class="icon-font">分享</text>
            </view>
            <view class="op-item" bindtap="comment">
                <view class="number-container">
                    <image src="../../images/dynamic/reply.png" class="dynamic-icon"></image>
                    <text class="number" qq:if="{{ detail.commentCount > 0}}">{{detail.commentCount}}</text>
                </view>
                <text class="icon-font">评论</text>
            </view>
            <view class="op-item" bindtap="praise">
                <view class="number-container">
                    <image src="../../images/dynamic/like.png" class="dynamic-icon"></image>
                    <text class="number" qq:if="{{ detail.praiseCount > 0}}">{{detail.praiseCount}}</text>
                </view>
                <text class="icon-font">点赞</text>
            </view>
        </view>

        <view class="dynamic-comment-cont">
            <text class="comment-head">全部{{detail.commentCount}}条评论</text>
            <view class="comment-total">
                <text class="comment-num">{{detail.praiseCount}}赞</text>
                <text class="comment-num">{{detail.watchCount}}分享</text>
                <image src="../../images/dynamic/right.png" class="right"></image>
            </view>
        </view>
        <view class="comment-items column">
            <view class="comment-item column" qq:for="{{commentList}}" qq:key="{{index}}">
                <view class="comment-people row">
                    <view class="people-cont row">
                        <image src="{{item.headUrl}}" class="comment-img"></image>
                        <view class="reply-desc column">
                            <text class="reply-name">{{item.nickName}}</text>
                            <!--<text>副总餐</text>-->
                        </view>
                    </view>
                    <image src="../../images/dynamic/like.png" class="comment-like"></image>
                </view>
                <view class="comment-content column">
                    <text class="reply-cont">{{item.content}}</text>
                    <text class="reply-key" bindtap="commentReply" data-index="{{index}}">回复</text>
                </view>

                <view class="second-reply column">
                    <view class="second-cont" qq:for="{{item.secondComment}}" qq:for-index="idx" data-index="{{idx}}" qq:for-item="value" catchtap="replySecond" data-id="{{index}}">
                        <image src="{{value.secondUserHeadUrl}}" class="second-headimg"></image>
                        <text class="second-nick">{{value.secondUserNickName}}回复{{value.userNickName}}：</text>
                        <text class="second-font">{{value.content}}</text>
                    </view>
                </view>
            </view>
        </view>
    </view>

    <view class="comment-fixed" qq:if="{{isComment}}">
        <input type="text" value="{{content}}" confirm-type="done" bindconfirm="writeComment" class="message-input" placeholder="请写入评论内容" placeholder-class="placeholder" />
    </view>

    <view class="comment-fixed" qq:if="{{isReply}}">
        <input type="text" value="{{secondContent}}" confirm-type="done" bindconfirm="writeReply" class="message-input" placeholder="请写入回复内容" placeholder-class="placeholder" />
    </view>
</view>