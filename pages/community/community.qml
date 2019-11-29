<view id="container" class="column">
    <view class="community-main">
        <view class="item rightBorder column">
            <span class="item-font">距下次更新:</span>
            <view class="time-count">
                <span class="time">{{bigHour}}</span>
                <span class="time">{{smallHour}}</span>
                <span class="unit">小时</span>
                <span class="time">{{bigMinute}}</span>
                <span class="time">{{smallMinute}}</span>
                <span class="unit">分</span>
            </view>
        </view>
        <view class="item column">
            <span class="item-font">参评社团数:</span>
            <span class="number">{{total}}</span>
        </view>
    </view>

    <view class="rank column">
        <!--{{item.rank == 1 ? 'first':'' || item.rank == 2 ? 'second':'' || item.rank == 3 ? 'third':'' || item.rank > 3 ? 'normal':''}}-->
        <view class="list row normal" bindtap="goToIndex" data-index="{{idx}}" qq:for="{{rank}}" qq:key="{{idx}}" qq:for-index="idx">
            <view class="prize-cont row">
                <!--<image src="../../images/home/prize1.png" class="prize-icon" qq:if="{{item.rank == 1}}"></image>-->
                <!--<image src="../../images/home/prize2.png" class="prize-icon" qq:if="{{item.rank == 2}}"></image>-->
                <!--<image src="../../images/home/prize3.png" class="prize-icon" qq:if="{{item.rank == 3}}"></image>-->
                <!--qq:if="{{item.rank > 3}}"-->
                <text class="sort-num" >{{idx+1}}</text>
                <view class="column">
                    <span class="community-name">{{item.name}}</span>
                    <view class="tags row">
                        <span class="tag" qq:for="{{item.corpLabels}}" qq:key="{{index}}" qq:for-item="value" style="color:#222222;background: {{ value.color}}" qq:for-index="index">{{value.content}}</span>
                    </view>
                    <view class="row school-info">
                        <image src="../../images/home/school.png" alt="" class="school-icon"></image>
                        <span class="school-name">{{item.schoolName || '暂无学校'}}</span>
                    </view>
                </view>
            </view>
            <view class="community-people">
                <image src="../../images/home/people.png" class="community-icon"></image>
                <span class="num">{{item.num}}</span>
            </view>
        </view>
    </view>
</view>