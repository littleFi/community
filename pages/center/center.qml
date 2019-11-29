<view id="container">
    <view class="header-cont">
        <view class="now-cont">
            <image src="../../images/home/address.png" class="icon"></image>
            <span class="head-font">当前学校：</span>
            <picker bindchange="bindPickerChange" value="" range="{{school}}" range-key="{{'name'}}" style="display: inline-block">
                <span class="now-school">{{schoolName}}</span>
            </picker>
        </view>
        <view class="community-cont">
            <view class="item rightBorder">
                <span class="item-num">98</span>
                <view class="item-cont">
                    <image src="../../images/home/people.png" class="item-icon"></image>
                    <span class="item-font">社团数</span>
                </view>
            </view>
            <view class="item">
                <span class="item-num">{{people.corpNum}}</span>
                <view class="item-cont">
                    <image src="../../images/home/flag.png" class="item-icon"></image>
                    <span class="item-font">我的社团</span>
                </view>
            </view>
        </view>
    </view>

    <view class="community-list column">
        <view class="community row" bindtap="goToIndex" qq:key="{{index}}" data-index="{{index}}" qq:for="{{community}}">
            <view class="detail column">
                <span class="name">{{item.name}}</span>
                <view class="tags row">
                    <span class="tag" qq:for="{{item.corpLabels}}" qq:key="{{index}}"qq:for-item="label" style="background:{{item.color}}" qq:for-index="index">{{label.content}}</span>
                </view>
            </view>

            <view class="community-people">
                <image src="../../images/home/people.png" class="community-icon"></image>
                <span class="num">{{item.num}}</span>
            </view>
        </view>
    </view>

    <!--学校选择-->
    <view class="dialog-bg" qq:if="{{!schoolName}}"></view>
    <view class="auth" qq:if="{{!schoolName}}">
        <picker bindchange="bindPickerChange" value="" range="{{school}}" range-key="{{'name'}}">
            <text class="auth-btn">请选择学校</text>
        </picker>
    </view>
</view>
