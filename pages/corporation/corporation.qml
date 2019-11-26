<view class="container">
    <view class="container-list">
        <view class="list column" bindtap="choose" data-index="{{index}}" qq:for="{{corpList}}" qq:key="{{index}}">
            <image src="{{item.headUrl}}" class="corp-image"></image>
            <text class="name">{{item.name}}</text>
        </view>
    </view>
</view>